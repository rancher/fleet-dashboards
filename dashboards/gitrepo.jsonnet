local fns = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet');
local g = import 'g.libsonnet';

local panels = [
  fns.createStatPanel(
    'Clusters Ready Percent',
    [
      {
        query: 'sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready Clusters Percent',
      },
    ],
    unit='percentunit',
    width=12,
  ),
  fns.createStatPanel(
    'Clusters Desired Ready/Ready',
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
    width=12,
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
    'Resources Ready Percent',
    [
      {
        query: 'sum(fleet_gitrepo_resources_ready{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_gitrepo_resources_desired_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready Resources Percent',
      },
    ],
    unit='percentunit',
    width=12,
  ),
  fns.createStatPanel(
    'Resources Desired Ready/Ready',
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
    width=12,
  ),
  fns.createTimeSeriesPanel(
    'Resources', [
      { query: 'sum(fleet_gitrepo_resources_desired_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Desired Ready',},
      { query: 'sum(fleet_gitrepo_resources_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready',},
      { query: 'sum(fleet_gitrepo_resources_not_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Not Ready',},
      { query: 'sum(fleet_gitrepo_resources_missing{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Missing',},
      { query: 'sum(fleet_gitrepo_resources_modified{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Modified',},
      { query: 'sum(fleet_gitrepo_resources_unknown{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Unknown',},
    ],
  ),
];

fns.createDashboard('Fleet / GitRepo', 'fleet-gitrepo', 'GitRepo', panels, [
  vars.gitrepo.namespace,
  vars.gitrepo.name,
])
