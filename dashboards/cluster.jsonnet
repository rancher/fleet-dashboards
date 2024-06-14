local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').cluster;

local gitRepos = lib.panelGroupData(
  readyTitle='Ready Git Repos',
  readyQuery='sum(fleet_cluster_ready_git_repos{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_cluster_desired_ready_git_repos{exported_namespace="$namespace",name=~"$name"})',
  title='Git Repos',
  queries=[
    {
      query: 'sum(fleet_cluster_desired_ready_git_repos{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Desired Ready',
    },
    {
      query: 'sum(fleet_cluster_ready_git_repos{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Ready',
    },
  ],
);

local resources = lib.panelGroupData(
  readyTitle='Ready Resources',
  readyQuery='sum(fleet_cluster_resources_count_ready{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_cluster_resources_count_desiredready{exported_namespace="$namespace",name=~"$name"})',
  title='Resources',
  queries=[
    {
      query: 'sum(fleet_cluster_resources_count_desiredready{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Desired Ready',
    },
    {
      query: 'sum(fleet_cluster_resources_count_ready{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Ready',
    },
    {
      query: 'sum(fleet_cluster_resources_count_notready{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Not Ready',
    },
    {
      query: 'sum(fleet_cluster_resources_count_missing{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Missing',
    },
    {
      query: 'sum(fleet_cluster_resources_count_modified{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Modified',
    },
    {
      query: 'sum(fleet_cluster_resources_count_unknown{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Unknown',
    },
    {
      query: 'sum(fleet_cluster_resources_count_orphaned{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Orphaned',
    },
    {
      query: 'sum(fleet_cluster_resources_count_waitapplied{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Wait Applied',
    },
  ],
);

local clusters = lib.panelGroupData(
  readyTitle='Ready Clusters',
  readyQuery='sum(fleet_cluster_state{exported_namespace="$namespace",name=~"$name",state="Ready"}) / sum(fleet_cluster_state{exported_namespace="$namespace",name=~"$name"})',
  title='Clusters',
  queries=[
    {
      query: 'sum(fleet_cluster_state{exported_namespace="$namespace",name=~"$name",state="Ready"})',
      legendFormat: 'Ready',
    },
    {
      query: 'sum(fleet_cluster_state{exported_namespace="$namespace",name=~"$name",state="NotReady"})',
      legendFormat: 'Not Ready',
    },
    {
      query: 'sum(fleet_cluster_state{exported_namespace="$namespace",name=~"$name",state="WaitCheckIn"})',
      legendFormat: 'Wait Check In',
    },
  ],
);

local panels =
  lib.createPanelGroup(gitRepos) + lib.createPanelGroup(resources) + lib.createPanelGroup(clusters);

local templateVariables = [
  vars.namespace,
  vars.name,
];

lib.createDashboard('Fleet / Cluster', 'fleet-cluster', 'Cluster', panels, templateVariables)
