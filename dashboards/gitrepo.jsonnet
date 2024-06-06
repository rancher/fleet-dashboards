local lib = import '../lib/funcs.libsonnet';
local variables = import '../lib/variables.libsonnet';

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

local panels = [lib.createPanel(p.title, p.queries) for p in panelData];

lib.createDashboard('Fleet / GitRepo', 'fleet-gitrepo', 'GitRepo', panels, [
  variables.namespace,
])
