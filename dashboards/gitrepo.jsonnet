local fns = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet');
local g = import 'g.libsonnet';

local panels = [
  fns.createStatPanel(
    'Ready Clusters',
    [
      {
        query: 'sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready Clusters Percent',
      },
    ],
    options={ height: 5, width: 7, unit: 'percentunit' },
  ),
  fns.createStatPanel(
    'Clusters',
    [
      {
        query: 'sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Desired Ready',
      },
      {
        query: 'sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready',
      },
      {
        query: 'sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace",name=~"$name"}) - sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Not Ready',
      },
    ],
    options={ height: 5, width: 17 },
  ),
  fns.createTimeSeriesPanel(
    'Clusters', [
      {
        query: 'sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Desired Ready',
      },
      {
        query: 'sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready',
      },
    ]
  ),
  fns.createStatPanel(
    'Resources Ready',
    [
      {
        query: 'sum(fleet_gitrepo_resources_ready{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_gitrepo_resources_desired_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready Resources Percent',
      },
    ],
    { height: 5, width: 7, unit: 'percentunit' },
  ),
  fns.createStatPanel(
    'Resources',
    [
      {
        query: 'sum(fleet_gitrepo_resources_desired_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Desired Ready',
      },
      {
        query: 'sum(fleet_gitrepo_resources_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready',
      },
      {
        query: 'sum(fleet_gitrepo_resources_not_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Not Ready',
      },
    ],
    { height: 5, width: 17 },
  ),
  fns.createTimeSeriesPanel(
    'Resources',
    [
      {
        query: 'sum(fleet_gitrepo_resources_desired_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Desired Ready',
      },
      {
        query: 'sum(fleet_gitrepo_resources_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready',
      },
      {
        query: 'sum(fleet_gitrepo_resources_not_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Not Ready',
      },
      {
        query: 'sum(fleet_gitrepo_resources_missing{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Missing',
      },
      {
        query: 'sum(fleet_gitrepo_resources_modified{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Modified',
      },
      {
        query: 'sum(fleet_gitrepo_resources_unknown{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Unknown',
      },
    ],
  ),
];

fns.createDashboard('Fleet / GitRepo', 'fleet-gitrepo', 'GitRepo', panels, [
  vars.gitrepo.namespace,
  vars.gitrepo.name,
])
