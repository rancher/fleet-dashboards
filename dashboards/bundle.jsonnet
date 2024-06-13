local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').bundle;

local panels = [
  lib.createTimeSeriesPanel(
    'Bundle Desired Ready',
    {
      query: 'fleet_bundle_desired_ready{exported_namespace="$namespace",name=~"$name"}',
    },
  ),
  lib.createTimeSeriesPanel(
    'Bundle Err Applied',
    {
      query: 'fleet_bundle_err_applied{exported_namespace="$namespace",name=~"$name"}',
    },
  ),
  lib.createTimeSeriesPanel(
    'Bundle Modified',
    {
      query: 'fleet_bundle_modified{exported_namespace="$namespace",name=~"$name"}',
    },
  ),
  lib.createTimeSeriesPanel(
    'Bundle Not Ready',
    {
      query: 'fleet_bundle_not_ready{exported_namespace="$namespace",name=~"$name"}',
    },
  ),
  lib.createTimeSeriesPanel(
    'Bundle Out of Sync',
    {
      query: 'fleet_bundle_out_of_sync{exported_namespace="$namespace",name=~"$name"}',
    },
  ),
  lib.createTimeSeriesPanel(
    'Bundle Pending',
    {
      query: 'fleet_bundle_pending{exported_namespace="$namespace",name=~"$name"}',
    },
  ),
  lib.createTimeSeriesPanel(
    'Bundle Ready',
    {
      query: 'fleet_bundle_ready{exported_namespace="$namespace",name=~"$name"}',
    },
  ),
  lib.createTimeSeriesPanel(
    'Bundle Wait Applied',
    {
      query: 'fleet_bundle_wait_applied{exported_namespace="$namespace",name=~"$name"}',
    },
  ),
  lib.createTimeSeriesPanel(
    'Bundle State',
    {
      query: 'fleet_bundle_state{exported_namespace="$namespace",name=~"$name"}',
    },
  ),
];

lib.createDashboard('Fleet / Bundle', 'fleet-bundle', 'Bundle', panels, [
  vars.namespace,
  vars.name,
])
