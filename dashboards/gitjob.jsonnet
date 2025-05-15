local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').gitjob;

local panels = lib.createHistogramPanelGroup('Time to fetch new commit', 'fleet_gitrepo_fetch_latest_commit_duration_seconds_bucket');

local templateVariables = [
  vars.namespace,
  vars.name,
];

lib.createDashboard('Fleet / GitJob', 'fleet-gitjob', 'GitJob', panels, templateVariables)
