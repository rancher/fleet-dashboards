local g = import 'g.libsonnet';

local createStatPanel(title, queries, unit=null) =
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
  + g.panel.stat.gridPos.withW(24)
  + g.panel.stat.gridPos.withH(8)
  + (if unit != null then g.panel.stat.standardOptions.withUnit(unit) else {});

local createTimeSeriesPanel(title, queries) =
  local qs = if std.isArray(queries) then queries else [queries];
  g.panel.timeSeries.new(title)
  + g.panel.timeSeries.queryOptions.withTargets(
    [
      g.query.prometheus.new('prometheus', query)
      for query in qs
    ]
  )
  // + g.panel.timeSeries.standardOptions.withUnit('reqps')
  + g.panel.timeSeries.gridPos.withW(24)
  + g.panel.timeSeries.gridPos.withH(8);

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
