local g = import 'g.libsonnet';

local defaultHeight = 8;  // TODO Import from a config.json/defaults.json?
local defaultWidth = 24;

local assignGridPosByWidth(panels, height) =
  local gridWidth = 24;
  local assignPos(panels) =
    local foldFunc(acc, panel) =
      local panelWidth = panel.gridPos.w;
      if acc.currentWidth + panelWidth > gridWidth then
        // Move to the next row if the current row is full.
        {
          panels: acc.panels + [panel { gridPos: { w: panelWidth, h: height, x: 0, y: acc.currentHeight + height } }],
          currentWidth: panelWidth,
          currentHeight: acc.currentHeight + height,
        }
      else
        // Place the panel in the current row.
        {
          panels: acc.panels + [panel { gridPos: { w: panelWidth, h: height, x: acc.currentWidth, y: acc.currentHeight } }],
          currentWidth: acc.currentWidth + panelWidth,
          currentHeight: acc.currentHeight,
        };

    local result = std.foldl(foldFunc, panels, { panels: [], currentWidth: 0, currentHeight: 0 });
    result.panels;
  assignPos(panels);


local fromQueries(queries) = [
  g.query.prometheus.new('prometheus', query.query)
  + (if std.get(query, 'legendFormat') != null
     then g.query.prometheus.withLegendFormat(query.legendFormat) else {})
  for query in queries
];

local createStatPanel(title, queries, unit=null, width=defaultWidth) =
  local qs = if std.isArray(queries) then queries else [queries];
  local stat = g.panel.stat;

  stat.new(title)
  + stat.queryOptions.withTargets(fromQueries(qs))
  + stat.gridPos.withW(width)
  + (if unit != null then stat.standardOptions.withUnit(unit) else {});

local createTimeSeriesPanel(title, queries, unit=null, width=defaultWidth) =
  local qs = if std.isArray(queries) then queries else [queries];
  local ts = g.panel.timeSeries;

  ts.new(title)
  + ts.queryOptions.withTargets(fromQueries(qs))
  + ts.gridPos.withW(width)
  + (if unit != null then ts.standardOptions.withUnit(unit) else {});

local createDashboard(name, uid, description, panels, variables=[]) =
  local pls = assignGridPosByWidth(panels, defaultHeight);

  g.dashboard.new(name)
  + g.dashboard.withUid(uid)
  + g.dashboard.withDescription(description)
  + g.dashboard.graphTooltip.withSharedCrosshair()
  + g.dashboard.withPanels(pls)
  + g.dashboard.time.withFrom('now-1h')
  + g.dashboard.time.withTo('now')
  + if std.length(variables) > 0 then g.dashboard.withVariables(variables) else {};


{
  createTimeSeriesPanel: createTimeSeriesPanel,
  createDashboard: createDashboard,
  createStatPanel: createStatPanel,
}
