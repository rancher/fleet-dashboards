local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').cluster;

local panels = [
  lib.createStatPanel(
    'Ready Git Repos',
    [
      {
        query: 'sum(fleet_cluster_ready_git_repos{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_cluster_desired_ready_git_repos{exported_namespace="$namespace",name=~"$name"})',
      },
    ],
    options={ height: 5, width: 7, unit: 'percentunit' },
  ),
  lib.createStatPanel(
    'Ready Git Repos',
    [
      {
        query: 'sum(fleet_cluster_ready_git_repos{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready',
      },
      {
        query: 'sum(fleet_cluster_desired_ready_git_repos{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Desired Ready',
      },
      {
        query: 'sum(fleet_cluster_desired_ready_git_repos{exported_namespace="$namespace",name=~"$name"}) - sum(fleet_cluster_ready_git_repos{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Not Ready',
      },
    ],
    options={
      height: 5,
      width: 17,
    },
  ),
  lib.createTimeSeriesPanel(
    'Git Repos Ready', [
      {
        query: 'sum(fleet_cluster_desired_ready_git_repos{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Desired Ready',
      },
      {
        query: 'sum(fleet_cluster_ready_git_repos{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready',
      },
    ]
  ),
  lib.createStatPanel(
    'Ready Resources',
    [
      {
        query: 'sum(fleet_cluster_resources_count_desiredready{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_cluster_resources_count_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready Resources',
      },
    ],
    options={ height: 5, width: 7, unit: 'percentunit' },
  ),
  lib.createStatPanel(
    'Resources',
    [
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
    options={ height: 5, width: 17 },
  ),
  lib.createTimeSeriesPanel(
    'Resources', [
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
    ]
  ),
  // lib.createStatPanel(
  //   'Ready Clusters',
  //   [
  //     {
  //       query: 'sum(fleet_cluster_state{exported_namespace="$namespace",name=~"$name",state="Ready"}) / sum(fleet_cluster_state{exported_namespace="$namespace",name=~"$name"})',
  //     },
  //   ],
  //   options={ height: 5, width: 7, unit: 'percentunit' },
  // ),
  // lib.createStatPanel(
  //   'Cluster State', [
  //     {
  //       query: 'sum(fleet_cluster_state{exported_namespace="$namespace",name=~"$name"})',
  //       legendFormat: 'Desired Ready',
  //     },
  //     {
  //       query: 'sum(fleet_cluster_state{exported_namespace="$namespace",name=~"$name",state="Ready"})',
  //       legendFormat: 'Ready',
  //     },
  //     {
  //       query: 'sum(fleet_cluster_state{exported_namespace="$namespace",name=~"$name",state="NotReady"})',
  //       legendFormat: 'Not Ready',
  //     },
  //     {
  //       query: 'sum(fleet_cluster_state{exported_namespace="$namespace",name=~"$name",state="WaitCheckIn"})',
  //       legendFormat: 'Wait Check In',
  //     },
  //   ],
  //   options={ height: 5, width: 17 },
  // ),
  lib.createTimeSeriesPanel(
    'Cluster State', [
      // {
      //   query: 'sum(fleet_cluster_state{exported_namespace="$namespace",name=~"$name"})',
      //   legendFormat: 'Desired Ready',
      // },
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
    ]
  ),
];

lib.createDashboard('Fleet / Cluster', 'fleet-cluster', 'Cluster', panels, [
  vars.namespace,
  vars.name,
])
