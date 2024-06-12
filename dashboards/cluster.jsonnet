local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').cluster;

local panels = [
  lib.createTimeSeriesPanel('Desired Ready Git Repos', [
    { query: 'fleet_cluster_desired_ready_git_repos{exported_namespace="$namespace"}' },
  ]),
  lib.createTimeSeriesPanel('Ready Git Repos', [
    { query: 'fleet_cluster_ready_git_repos{exported_namespace="$namespace"}' },
  ]),
  lib.createTimeSeriesPanel('Resources Count DesiredReady', [
    { query: 'fleet_cluster_resources_count_desiredready{exported_namespace="$namespace"}' },
  ]),
  lib.createTimeSeriesPanel('Resources Count Missing', [
    { query: 'fleet_cluster_resources_count_missing{exported_namespace="$namespace"}' },
  ]),
  lib.createTimeSeriesPanel('Resources Count Modified', [
    { query: 'fleet_cluster_resources_count_modified{exported_namespace="$namespace"}' },
  ]),
  lib.createTimeSeriesPanel('Resources Count NotReady', [
    { query: 'fleet_cluster_resources_count_notready{exported_namespace="$namespace"}' },
  ]),
  lib.createTimeSeriesPanel('Resources Count Orphaned', [
    { query: 'fleet_cluster_resources_count_orphaned{exported_namespace="$namespace"}' },
  ]),
  lib.createTimeSeriesPanel('Resources Count Ready', [
    { query: 'fleet_cluster_resources_count_ready{exported_namespace="$namespace"}' },
  ]),
  lib.createTimeSeriesPanel('Resources Count Unknown', [
    { query: 'fleet_cluster_resources_count_unknown{exported_namespace="$namespace"}' },
  ]),
  lib.createTimeSeriesPanel('Resources Count WaitApplied', [
    { query: 'fleet_cluster_resources_count_waitapplied{exported_namespace="$namespace"}' },
  ]),
  lib.createTimeSeriesPanel('Cluster State', [
    { query: 'fleet_cluster_state{exported_namespace="$namespace"}' },
  ]),
];

lib.createDashboard('Fleet / Cluster', 'fleet-cluster', 'Cluster', panels, [
  vars.namespace,
])
