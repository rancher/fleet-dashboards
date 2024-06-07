local g = import 'g.libsonnet';

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
  + g.dashboard.time.withFrom("now-1h")
  + g.dashboard.time.withTo("now")
  + if std.length(variables) > 0 then g.dashboard.withVariables(variables) else {};

{
  createTimeSeriesPanel: createTimeSeriesPanel,
  createDashboard: createDashboard,
}
