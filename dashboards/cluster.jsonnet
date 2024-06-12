local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').cluster;

local panelData = [
  {
    title: 'Desired Ready Git Repos',
    query: 'fleet_cluster_desired_ready_git_repos{exported_namespace="$namespace"}',
  },
  {
    title: 'Ready Git Repos',
    query: 'fleet_cluster_ready_git_repos{exported_namespace="$namespace"}',
  },
  {
    title: 'Resources Count DesiredReady',
    query: 'fleet_cluster_resources_count_desiredready{exported_namespace="$namespace"}',
  },
  {
    title: 'Resources Count Missing',
    query: 'fleet_cluster_resources_count_missing{exported_namespace="$namespace"}',
  },
  {
    title: 'Resources Count Modified',
    query: 'fleet_cluster_resources_count_modified{exported_namespace="$namespace"}',
  },
  {
    title: 'Resources Count NotReady',
    query: 'fleet_cluster_resources_count_notready{exported_namespace="$namespace"}',
  },
  {
    title: 'Resources Count Orphaned',
    query: 'fleet_cluster_resources_count_orphaned{exported_namespace="$namespace"}',
  },
  {
    title: 'Resources Count Ready',
    query: 'fleet_cluster_resources_count_ready{exported_namespace="$namespace"}',
  },
  {
    title: 'Resources Count Unknown',
    query: 'fleet_cluster_resources_count_unknown{exported_namespace="$namespace"}',
  },
  {
    title: 'Resources Count WaitApplied',
    query: 'fleet_cluster_resources_count_waitapplied{exported_namespace="$namespace"}',
  },
  {
    title: 'Cluster State',
    query: 'fleet_cluster_state{exported_namespace="$namespace"}',
  },
];

local panels = [lib.createTimeSeriesPanel(p.title, {query: p.query}) for p in panelData];

lib.createDashboard('Fleet / Cluster', 'fleet-cluster', 'Cluster', panels, [
  vars.namespace,
])
