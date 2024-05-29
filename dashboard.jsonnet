local lib = import 'funcs.libsonnet';

local panelData = [
  {
    title: 'Bundle - Desired Ready',
    query: 'fleet_cluster_group_bundle_desired_ready',
  },
  {
    title: 'Bundle - Ready',
    query: 'fleet_cluster_group_bundle_ready',
  },
  {
    title: 'Cluster Count',
    query: 'fleet_cluster_group_cluster_count',
  },
  {
    title: 'Non Ready Cluster Count',
    query: 'fleet_cluster_group_non_ready_cluster_count',
  },
  {
    title: 'Resource Count - Desired Ready',
    query: 'fleet_cluster_group_resource_count_desired_ready',
  },
  {
    title: 'Resource Count - Missing',
    query: 'fleet_cluster_group_resource_count_missing',
  },
  {
    title: 'Resource Count - Modified',
    query: 'fleet_cluster_group_resource_count_modified',
  },
  {
    title: 'Resource Count - Not Ready',
    query: 'fleet_cluster_group_resource_count_notready',
  },
  {
    title: 'Resource Count - Orphaned',
    query: 'fleet_cluster_group_resource_count_orphaned',
  },
  {
    title: 'Resource Count - Ready',
    query: 'fleet_cluster_group_resource_count_ready',
  },
  {
    title: 'Resource Count - Unknown',
    query: 'fleet_cluster_group_resource_count_unknown',
  },
  {
    title: 'Resource Count - Wait Applied',
    query: 'fleet_cluster_group_resource_count_waitapplied',
  },
  {
    title: 'State',
    query: 'fleet_cluster_group_state',
  },
];

local panels = [lib.createPanel(p.title, p.query) for p in panelData];

lib.createDashboard('Fleet / ClusterGroup', 'fleet-cluster-group', 'ClusterGroup', panels)
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
