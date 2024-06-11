local fns = import '../lib/funcs.libsonnet';
local variables = import '../lib/variables.libsonnet';
local g = import 'g.libsonnet';

// fns.createStatPanel(
//   'Clusters Not Ready', [
//     {
//       query: 'sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"}) - sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace"})',
//       legendFormat: 'Not Ready Clusters',
//     },
//   ],
//   width=12,
// ),
// fns.createStatPanel(
//   'Clusters Not Ready Percent', [
//     {
//       query: '\n        ( sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"}) - sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace"})\n        ) / sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"}) * 100',
//       legendFormat: 'Not Ready Clusters',
//     },
//   ],
// ),

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
        query: 'sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"}) - sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace"})',
        legendFormat: 'Not Ready Clusters',
      },
      {
        query: 'sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace"})',
        legendFormat: 'Desired Ready',
      },
      {
        query: 'sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace"})',
        legendFormat: 'Ready',
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
  fns.createTimeSeriesPanel('Resources Desired Ready/Ready', [
    { query: 'fleet_gitrepo_resources_desired_ready{exported_namespace="$namespace"}' },
    { query: 'fleet_gitrepo_resources_ready{exported_namespace="$namespace"}' },
    { query: 'fleet_gitrepo_resources_not_ready{exported_namespace="$namespace"}' },
  ]),
  fns.createTimeSeriesPanel('Resources Missing/Modified/Unknown', [
    { query: 'fleet_gitrepo_resources_missing{exported_namespace="$namespace"}' },
    { query: 'fleet_gitrepo_resources_modified{exported_namespace="$namespace"}' },
    { query: 'fleet_gitrepo_resources_unknown{exported_namespace="$namespace"}' },
  ]),
  fns.createTimeSeriesPanel('Resources', [
    { query: 'fleet_gitrepo_resources_desired_ready{exported_namespace="$namespace"}' },
    { query: 'fleet_gitrepo_resources_ready{exported_namespace="$namespace"}' },
    { query: 'fleet_gitrepo_resources_not_ready{exported_namespace="$namespace"}' },
    { query: 'fleet_gitrepo_resources_missing{exported_namespace="$namespace"}' },
    { query: 'fleet_gitrepo_resources_modified{exported_namespace="$namespace"}' },
    { query: 'fleet_gitrepo_resources_unknown{exported_namespace="$namespace"}' },
  ]),
];

// local panels = fns.arrangePanels(panels);

fns.createDashboard('Fleet / GitRepo', 'fleet-gitrepo', 'GitRepo', panels, [
  variables.namespace,
])
