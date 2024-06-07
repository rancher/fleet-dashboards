local lib = import '../lib/funcs.libsonnet';
local variables = import '../lib/variables.libsonnet';

local panelData = [
  {
    title: 'Bundle - Desired Ready',
    query: 'fleet_cluster_group_bundle_desired_ready{exported_namespace="$namespace"}',
  },
  {
    title: 'Bundle - Ready',
    query: 'fleet_cluster_group_bundle_ready{exported_namespace="$namespace"}',
  },
  {
    title: 'Cluster Count',
    query: 'fleet_cluster_group_cluster_count{exported_namespace="$namespace"}',
  },
  {
    title: 'Non Ready Cluster Count',
    query: 'fleet_cluster_group_non_ready_cluster_count{exported_namespace="$namespace"}',
  },
  {
    title: 'Resource Count - Desired Ready',
    query: 'fleet_cluster_group_resource_count_desired_ready{exported_namespace="$namespace"}',
  },
  {
    title: 'Resource Count - Missing',
    query: 'fleet_cluster_group_resource_count_missing{exported_namespace="$namespace"}',
  },
  {
    title: 'Resource Count - Modified',
    query: 'fleet_cluster_group_resource_count_modified{exported_namespace="$namespace"}',
  },
  {
    title: 'Resource Count - Not Ready',
    query: 'fleet_cluster_group_resource_count_notready{exported_namespace="$namespace"}',
  },
  {
    title: 'Resource Count - Orphaned',
    query: 'fleet_cluster_group_resource_count_orphaned{exported_namespace="$namespace"}',
  },
  {
    title: 'Resource Count - Ready',
    query: 'fleet_cluster_group_resource_count_ready{exported_namespace="$namespace"}',
  },
  {
    title: 'Resource Count - Unknown',
    query: 'fleet_cluster_group_resource_count_unknown{exported_namespace="$namespace"}',
  },
  {
    title: 'Resource Count - Wait Applied',
    query: 'fleet_cluster_group_resource_count_waitapplied{exported_namespace="$namespace"}',
  },
  {
    title: 'State',
    query: 'fleet_cluster_group_state{exported_namespace="$namespace"}',
  },
];

local panels = [lib.createPanel(p.title, p.query) for p in panelData];

lib.createDashboard('Fleet / ClusterGroup', 'fleet-cluster-group', 'ClusterGroup', panels, [
  variables.namespace,
])
