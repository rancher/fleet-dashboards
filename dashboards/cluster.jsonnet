local lib = import '../lib/funcs.libsonnet';

local panelData = [
  {
    title: 'Desired Ready Git Repos',
    query: 'fleet_cluster_desired_ready_git_repos',
  },
  {
    title: 'Ready Git Repos',
    query: 'fleet_cluster_ready_git_repos',
  },
  {
    title: 'Resources Count DesiredReady',
    query: 'fleet_cluster_resources_count_desiredready',
  },
  {
    title: 'Resources Count Missing',
    query: 'fleet_cluster_resources_count_missing',
  },
  {
    title: 'Resources Count Modified',
    query: 'fleet_cluster_resources_count_modified',
  },
  {
    title: 'Resources Count NotReady',
    query: 'fleet_cluster_resources_count_notready',
  },
  {
    title: 'Resources Count Orphaned',
    query: 'fleet_cluster_resources_count_orphaned',
  },
  {
    title: 'Resources Count Ready',
    query: 'fleet_cluster_resources_count_ready',
  },
  {
    title: 'Resources Count Unknown',
    query: 'fleet_cluster_resources_count_unknown',
  },
  {
    title: 'Resources Count WaitApplied',
    query: 'fleet_cluster_resources_count_waitapplied',
  },
  {
    title: 'Cluster State',
    query: 'fleet_cluster_state',
  },
];

local panels = [lib.createPanel(p.title, p.query) for p in panelData];

lib.createDashboard('Fleet / Cluster', 'fleet-cluster', 'Cluster', panels)
