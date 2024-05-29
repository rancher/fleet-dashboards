local g = import 'g.libsonnet';

local createDashboard(name, uid, description, panels) =
  g.dashboard.new(name)
  + g.dashboard.withUid(uid)
  + g.dashboard.withDescription(description)
  + g.dashboard.graphTooltip.withSharedCrosshair()
  + g.dashboard.withPanels(panels);

local createPanel(title, query) =
  g.panel.timeSeries.new(title)
  + g.panel.timeSeries.queryOptions.withTargets([
    g.query.prometheus.new('prometheus', query),
  ]);

local desiredReadyPanel = createPanel(
  'Resource Count - Desired Ready',
  'sum by (name) (fleet_cluster_group_resource_count_desired_ready)',
);

local readyPanel = createPanel(
  'Resource Count - Ready',
  'sum by (name) (fleet_cluster_group_resource_count_ready)',
);

local panels = [
  desiredReadyPanel,
  readyPanel,
  // Add more panels here if needed
];

createDashboard('Fleet / ClusterGroup', 'fleet-cluster-group', 'ClusterGroup', panels)
// local grafonnet = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';

// local g = import 'g.libsonnet';

// g.dashboard.new('Fleet / ClusterGroup')
// + g.dashboard.withUid('fleet-cluster-group')
// + g.dashboard.withDescription('ClusterGroup')
// + g.dashboard.graphTooltip.withSharedCrosshair()
// + g.dashboard.withPanels([
//   g.panel.timeSeries.new('Resource Count - Desired Ready')
//   + g.panel.timeSeries.queryOptions.withTargets([
//     g.query.prometheus.new(
//       'prometheus',
//       'sum by (name) (fleet_cluster_group_resource_count_desired_ready)',
//     ),
//   ]),
//   g.panel.timeSeries.new('Resource Count - Ready')
//   + g.panel.timeSeries.queryOptions.withTargets([
//     g.query.prometheus.new(
//       'prometheus',
//       'sum by (name) (fleet_cluster_group_resource_count_ready)',
//     ),
//   ])
//   // + g.panel.timeSeries.standardOptions.withUnit('reqps')
//   // + g.panel.timeSeries.gridPos.withW(24)
//   // + g.panel.timeSeries.gridPos.withH(8),
// ])

