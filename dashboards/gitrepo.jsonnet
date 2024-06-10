local fns = import '../lib/funcs.libsonnet';
local variables = import '../lib/variables.libsonnet';
local g = import 'g.libsonnet';

local panelData = [
  {
    title: 'Clusters Desired Ready/Ready',
    queries: [
      'fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"}',
      'fleet_gitrepo_ready_clusters{exported_namespace="$namespace"}',
    ],
  },
  {
    title: 'Resources Desired Ready/Ready',
    queries: [
      'fleet_gitrepo_resources_desired_ready{exported_namespace="$namespace"}',
      'fleet_gitrepo_resources_ready{exported_namespace="$namespace"}',
      'fleet_gitrepo_resources_not_ready{exported_namespace="$namespace"}',
    ],
  },
  {
    title: 'Resources Missing/Modified/Unknown',
    queries: [
      'fleet_gitrepo_resources_missing{exported_namespace="$namespace"}',
      'fleet_gitrepo_resources_modified{exported_namespace="$namespace"}',
      'fleet_gitrepo_resources_unknown{exported_namespace="$namespace"}',
    ],
  },
  {
    title: 'Resources',
    queries: [
      'fleet_gitrepo_resources_desired_ready{exported_namespace="$namespace"}',
      'fleet_gitrepo_resources_ready{exported_namespace="$namespace"}',
      'fleet_gitrepo_resources_not_ready{exported_namespace="$namespace"}',
      'fleet_gitrepo_resources_missing{exported_namespace="$namespace"}',
      'fleet_gitrepo_resources_modified{exported_namespace="$namespace"}',
      'fleet_gitrepo_resources_unknown{exported_namespace="$namespace"}',
    ],
  },
];

local panels = [
  fns.createStatPanel(
    'Clusters Ready Percent', [
      {
        query: 'sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace"}) / sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"})',
        legendFormat: 'Ready Clusters Percent',
      },
    ],
    'percentunit',
  ),
  fns.createStatPanel(
    'Clusters Not Ready', [
      {
        query: 'sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"}) - sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace"})',
        legendFormat: 'Not Ready Clusters',
      },
    ],
  ),
  fns.createStatPanel(
    'Clusters Not Ready Percent', [
      {
        query: '\n        ( sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"}) - sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace"})\n        ) / sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"}) * 100',
        legendFormat: 'Not Ready Clusters',
      },
    ],
  ),
  fns.createStatPanel(
    'Clusters Desired Ready/Ready', [
      {
        query: 'sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"})',
        legendFormat: 'Desired Ready',
      },
      {
        query: 'sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace"})',
        legendFormat: 'Ready',
      },
    ],
  ),
] + [fns.createTimeSeriesPanel(p.title, p.queries) for p in panelData];

fns.createDashboard('Fleet / GitRepo', 'fleet-gitrepo', 'GitRepo', panels, [
  variables.namespace,
])
