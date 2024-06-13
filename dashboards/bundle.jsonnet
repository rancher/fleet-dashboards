local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').bundle;

local panelData = [
  {
    title: 'Bundle Desired Ready',
    query: 'fleet_bundle_desired_ready{exported_namespace="$namespace",name=~"$name"}',
  },
  {
    title: 'Bundle Err Applied',
    query: 'fleet_bundle_err_applied{exported_namespace="$namespace",name=~"$name"}',
  },
  {
    title: 'Bundle Modified',
    query: 'fleet_bundle_modified{exported_namespace="$namespace",name=~"$name"}',
  },
  {
    title: 'Bundle Not Ready',
    query: 'fleet_bundle_not_ready{exported_namespace="$namespace",name=~"$name"}',
  },
  {
    title: 'Bundle Out of Sync',
    query: 'fleet_bundle_out_of_sync{exported_namespace="$namespace",name=~"$name"}',
  },
  {
    title: 'Bundle Pending',
    query: 'fleet_bundle_pending{exported_namespace="$namespace",name=~"$name"}',
  },
  {
    title: 'Bundle Ready',
    query: 'fleet_bundle_ready{exported_namespace="$namespace",name=~"$name"}',
  },
  {
    title: 'Bundle Wait Applied',
    query: 'fleet_bundle_wait_applied{exported_namespace="$namespace",name=~"$name"}',
  },
  {
    title: 'Bundle State',
    query: 'fleet_bundle_state{exported_namespace="$namespace",name=~"$name"}',
  },
];

local panels = [lib.createTimeSeriesPanel(p.title, {query: p.query}) for p in panelData];

lib.createDashboard('Fleet / Bundle', 'fleet-bundle', 'Bundle', panels, [
  vars.namespace,
  vars.name,
])
