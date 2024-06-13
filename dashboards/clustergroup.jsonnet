local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').clusterGroup;

local panelData = [
  {
    title: 'Bundle - Desired Ready',
    query: 'sum(fleet_cluster_group_bundle_desired_ready{exported_namespace="$namespace",name=~"$name"})',
  },
  {
    title: 'Bundle - Ready',
    query: 'sum(fleet_cluster_group_bundle_ready{exported_namespace="$namespace",name=~"$name"})',
  },
  {
    title: 'Cluster Count',
    query: 'sum(fleet_cluster_group_cluster_count{exported_namespace="$namespace",name=~"$name"})',
  },
  {
    title: 'Non Ready Cluster Count',
    query: 'sum(fleet_cluster_group_non_ready_cluster_count{exported_namespace="$namespace",name=~"$name"})',
  },
  {
    title: 'Resource Count - Desired Ready',
    query: 'sum(fleet_cluster_group_resource_count_desired_ready{exported_namespace="$namespace",name=~"$name"})',
  },
  {
    title: 'Resource Count - Missing',
    query: 'sum(fleet_cluster_group_resource_count_missing{exported_namespace="$namespace",name=~"$name"})',
  },
  {
    title: 'Resource Count - Modified',
    query: 'sum(fleet_cluster_group_resource_count_modified{exported_namespace="$namespace",name=~"$name"})',
  },
  {
    title: 'Resource Count - Not Ready',
    query: 'sum(fleet_cluster_group_resource_count_notready{exported_namespace="$namespace",name=~"$name"})',
  },
  {
    title: 'Resource Count - Orphaned',
    query: 'sum(fleet_cluster_group_resource_count_orphaned{exported_namespace="$namespace",name=~"$name"})',
  },
  {
    title: 'Resource Count - Ready',
    query: 'sum(fleet_cluster_group_resource_count_ready{exported_namespace="$namespace",name=~"$name"})',
  },
  {
    title: 'Resource Count - Unknown',
    query: 'sum(fleet_cluster_group_resource_count_unknown{exported_namespace="$namespace",name=~"$name"})',
  },
  {
    title: 'Resource Count - Wait Applied',
    query: 'sum(fleet_cluster_group_resource_count_waitapplied{exported_namespace="$namespace",name=~"$name"})',
  },
  {
    title: 'State',
    query: 'sum(fleet_cluster_group_state{exported_namespace="$namespace",name=~"$name"})',
  },
];

local panels = [lib.createTimeSeriesPanel(p.title, {query: p.query}) for p in panelData];

lib.createDashboard('Fleet / ClusterGroup', 'fleet-cluster-group', 'ClusterGroup', panels, [
  vars.namespace,
  vars.name,
])
