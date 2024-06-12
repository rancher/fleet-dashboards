local g = import 'g.libsonnet';

local defaultHeight = 8;  // TODO Import from a config.json/defaults.json?
local defaultWidth = 24;

local assignGridPosByWidth(panels) =
  local gridWidth = 24;
  local assignPos(panels) =
    local foldFunc(acc, panel) =
      local panelWidth = panel.gridPos.w;
      local panelHeight = panel.gridPos.h;
      if acc.currentWidth + panelWidth > gridWidth then
        // Move to the next row if the current row is full.
        {
          panels: acc.panels + [panel { gridPos: { w: panelWidth, h: panelHeight, x: 0, y: acc.currentHeight + panelHeight } }],
          currentWidth: panelWidth,
          currentHeight: acc.currentHeight + panelHeight,
        }
      else
        // Place the panel in the current row.
        {
          panels: acc.panels + [panel { gridPos: { w: panelWidth, h: panelHeight, x: acc.currentWidth, y: acc.currentHeight } }],
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

local createPanel(panelObject, title, queries, options) =
  local qs = if std.isArray(queries) then queries else [queries];
  panelObject.new(title)
  + panelObject.queryOptions.withTargets(fromQueries(qs))
  + panelObject.gridPos.withW(std.get(options, 'width', defaultWidth))
  + panelObject.gridPos.withH(std.get(options, 'height', defaultHeight))
  + panelObject.standardOptions.withUnit(std.get(options, 'unit', null))
  + panelObject.standardOptions.withDecimals(std.get(options, 'decimals', 0));

local createStatPanel(title, queries, options={}) =
  createPanel(g.panel.stat, title, queries, options);

local createTimeSeriesPanel(title, queries, options={}) =
  createPanel(g.panel.timeSeries, title, queries, options);

local createDashboard(name, uid, description, panels, variables=[]) =
  local pls = assignGridPosByWidth(panels);

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
