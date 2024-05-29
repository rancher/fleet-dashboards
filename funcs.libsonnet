local g = import 'g.libsonnet';

local createPanel(title, query) =
  g.panel.timeSeries.new(title)
  + g.panel.timeSeries.queryOptions.withTargets([
    g.query.prometheus.new('prometheus', query),
  ]);

local createDashboard(name, uid, description, panels) =
  g.dashboard.new(name)
  + g.dashboard.withUid(uid)
  + g.dashboard.withDescription(description)
  + g.dashboard.graphTooltip.withSharedCrosshair()
  + g.dashboard.withPanels(panels);

{
  createPanel: createPanel,
  createDashboard: createDashboard,
}
