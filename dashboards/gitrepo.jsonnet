local fns = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet');
local g = import 'g.libsonnet';

local panels = [
  fns.createStatPanel(
    'Clusters Ready Percent',
    [
      {
        query: 'sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace"}) / sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"})',
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
        query: 'sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"})',
        legendFormat: 'Desired Ready',
      },
      {
        query: 'sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace"})',
        legendFormat: 'Ready',
      },
      {
        query: 'sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"}) - sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace"})',
        legendFormat: 'Not Ready Clusters',
      },
    ],
    width=12,
  ),
  fns.createTimeSeriesPanel(
    'Clusters Desired Ready/Ready', [
      { query: 'fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"}' },
      { query: 'fleet_gitrepo_ready_clusters{exported_namespace="$namespace"}' },
    ]
  ),
  fns.createTimeSeriesPanel(
    'Resources Desired Ready/Ready', [
      { query: 'fleet_gitrepo_resources_desired_ready{exported_namespace="$namespace"}' },
      { query: 'fleet_gitrepo_resources_ready{exported_namespace="$namespace"}' },
      { query: 'fleet_gitrepo_resources_not_ready{exported_namespace="$namespace"}' },
    ]
  ),
  fns.createTimeSeriesPanel(
    'Resources Missing/Modified/Unknown', [
      { query: 'fleet_gitrepo_resources_missing{exported_namespace="$namespace"}' },
      { query: 'fleet_gitrepo_resources_modified{exported_namespace="$namespace"}' },
      { query: 'fleet_gitrepo_resources_unknown{exported_namespace="$namespace"}' },
    ],
    width=12,
  ),
  fns.createTimeSeriesPanel(
    'Resources', [
      { query: 'fleet_gitrepo_resources_desired_ready{exported_namespace="$namespace"}' },
      { query: 'fleet_gitrepo_resources_ready{exported_namespace="$namespace"}' },
      { query: 'fleet_gitrepo_resources_not_ready{exported_namespace="$namespace"}' },
      { query: 'fleet_gitrepo_resources_missing{exported_namespace="$namespace"}' },
      { query: 'fleet_gitrepo_resources_modified{exported_namespace="$namespace"}' },
      { query: 'fleet_gitrepo_resources_unknown{exported_namespace="$namespace"}' },
    ],
    width=12,
  ),
];

fns.createDashboard('Fleet / GitRepo', 'fleet-gitrepo', 'GitRepo', panels, [
  vars.gitrepo.namespace,
])
