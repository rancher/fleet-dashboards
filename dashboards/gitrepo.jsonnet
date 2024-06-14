local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').gitrepo;

local clusters = {
  readyTitle: 'Ready Clusters',
  readyQuery: 'sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace",name=~"$name"})',
  title: 'Clusters',
  queries: [
    {
      query: 'sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Desired Ready',
    },
    {
      query: 'sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Ready',
    },
    //   {
    //     query: 'sum(fleet_gitrepo_desired_ready_clusters{exported_namespace="$namespace",name=~"$name"}) - sum(fleet_gitrepo_ready_clusters{exported_namespace="$namespace",name=~"$name"})',
    //     legendFormat: 'Not Ready',
    //   },
  ],
};

local resources = {
  readyTitle: 'Ready Resources',
  readyQuery: 'sum(fleet_gitrepo_resources_ready{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_gitrepo_resources_desired_ready{exported_namespace="$namespace",name=~"$name"})',
  title: 'Resources',
  queries: [
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
};

local panels = lib.createPanelGroup(clusters) + lib.createPanelGroup(resources);

local templateVariables = [
  vars.namespace,
  vars.name,
];

lib.createDashboard('Fleet / GitRepo', 'fleet-gitrepo', 'GitRepo', panels, templateVariables)
