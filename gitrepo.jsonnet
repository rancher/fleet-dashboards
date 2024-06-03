local lib = import 'funcs.libsonnet';

local panelData = [
  {
    title: 'Desired Ready Clusters',
    query: 'fleet_gitrepo_desired_ready_clusters',
  },
  {
    title: 'Ready Clusters',
    query: 'fleet_gitrepo_ready_clusters',
  },
  {
    title: 'Resources Desired Ready',
    query: 'fleet_gitrepo_resources_desired_ready',
  },
  {
    title: 'Resources Missing',
    query: 'fleet_gitrepo_resources_missing',
  },
  {
    title: 'Resources Modified',
    query: 'fleet_gitrepo_resources_modified',
  },
  {
    title: 'Resources Not Ready',
    query: 'fleet_gitrepo_resources_not_ready',
  },
  {
    title: 'Resources Orphaned',
    query: 'fleet_gitrepo_resources_orphaned',
  },
  {
    title: 'Resources Ready',
    query: 'fleet_gitrepo_resources_ready',
  },
  {
    title: 'Resources Unknown',
    query: 'fleet_gitrepo_resources_unknown',
  },
  {
    title: 'Resources Wait Applied',
    query: 'fleet_gitrepo_resources_wait_applied',
  },
];

local panels = [lib.createPanel(p.title, p.query) for p in panelData];

lib.createDashboard('Fleet / GitRepo', 'fleet-gitrepo', 'GitRepo', panels)
