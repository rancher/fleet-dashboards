local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').bundle;

local panelData = [
  {
    title: 'Bundle Desired Ready',
    query: 'fleet_bundle_desired_ready{exported_namespace="$namespace"}',
  },
  {
    title: 'Bundle Err Applied',
    query: 'fleet_bundle_err_applied{exported_namespace="$namespace"}',
  },
  {
    title: 'Bundle Modified',
    query: 'fleet_bundle_modified{exported_namespace="$namespace"}',
  },
  {
    title: 'Bundle Not Ready',
    query: 'fleet_bundle_not_ready{exported_namespace="$namespace"}',
  },
  {
    title: 'Bundle Out of Sync',
    query: 'fleet_bundle_out_of_sync{exported_namespace="$namespace"}',
  },
  {
    title: 'Bundle Pending',
    query: 'fleet_bundle_pending{exported_namespace="$namespace"}',
  },
  {
    title: 'Bundle Ready',
    query: 'fleet_bundle_ready{exported_namespace="$namespace"}',
  },
  {
    title: 'Bundle State',
    query: 'fleet_bundle_state{exported_namespace="$namespace"}',
  },
  {
    title: 'Bundle Wait Applied',
    query: 'fleet_bundle_wait_applied{exported_namespace="$namespace"}',
  },
];

local panels = [lib.createTimeSeriesPanel(p.title, {query: p.query}) for p in panelData];

lib.createDashboard('Fleet / Bundle', 'fleet-bundle', 'Bundle', panels, [
  vars.namespace,
])
