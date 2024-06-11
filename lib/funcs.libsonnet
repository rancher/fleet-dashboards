local g = import 'g.libsonnet';

local defaultHeight = 8;
local defaultWidth = 24;

// local panelHeight = 8;
// local panelWidth = 12;
// local columns = 2;  // Number of columns in the grid

// local arrangePanels(panels, panelHeight, panelWidth) = [
//   {
//     panel: panel,
//     gridPos: {
//       h: panelHeight,
//       w: panelWidth,
//       x: (index % columns) * panelWidth,
//       y: std.floor(index / columns) * panelHeight,
//     },
//   }
//   for index in std.range(0, std.length(panels) - 1)
//   for panel in [panels[index]]
// ];

// local panels = [
//   { title: 'Panel 1' },
//   { title: 'Panel 2' },
//   { title: 'Panel 3' },
//   { title: 'Panel 4' },
// ];

// arrangePanels(panels, panelHeight, panelWidth);

local createStatPanel(title, queries, unit=null, width=defaultWidth, height=defaultHeight) =
  local qs = if std.isArray(queries) then queries else [queries];

  g.panel.stat.new(title)
  + g.panel.stat.queryOptions.withTargets(
    [
      g.query.prometheus.new('prometheus', query.query)
      + (if std.get(query, 'legendFormat') != null
         then g.query.prometheus.withLegendFormat(query.legendFormat) else {})
      for query in qs
    ]
  )
  + g.panel.stat.gridPos.withW(width)
  + g.panel.stat.gridPos.withH(height)
  + (if unit != null then g.panel.stat.standardOptions.withUnit(unit) else {});

local createTimeSeriesPanel(title, queries, unit=null, width=defaultWidth, height=defaultHeight) =
  local qs = if std.isArray(queries) then queries else [queries];
  g.panel.timeSeries.new(title)
  + g.panel.timeSeries.queryOptions.withTargets(
    [
      g.query.prometheus.new('prometheus', query.query)
      + (if std.get(query, 'legendFormat') != null
         then g.query.prometheus.withLegendFormat(query.legendFormat) else {})
      for query in qs
    ]
  )
  + g.panel.timeSeries.gridPos.withW(width)
  + g.panel.timeSeries.gridPos.withH(height)
  + (if unit != null then g.panel.stat.standardOptions.withUnit(unit) else {});

local createDashboard(name, uid, description, panels, variables=[]) =
  g.dashboard.new(name)
  + g.dashboard.withUid(uid)
  + g.dashboard.withDescription(description)
  + g.dashboard.graphTooltip.withSharedCrosshair()
  + g.dashboard.withPanels(panels)
  + g.dashboard.time.withFrom('now-1h')
  + g.dashboard.time.withTo('now')
  + if std.length(variables) > 0 then g.dashboard.withVariables(variables) else {};

{
  createTimeSeriesPanel: createTimeSeriesPanel,
  createDashboard: createDashboard,
  createStatPanel: createStatPanel,
}
