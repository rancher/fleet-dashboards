local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').bundle;

local panels = [
  lib.createStatPanel(
    'Ready Bundles',
    {
      query: 'sum(fleet_bundle_ready{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_bundle_desired_ready{exported_namespace="$namespace",name=~"$name"})',
    },
    options={ height: 5, width: 7, unit: 'percentunit' },
  ),
  lib.createStatPanel(
    'Bundles',
    [
      {
        query: 'sum(fleet_bundle_desired_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Desired Ready',
      },
      {
        query: 'sum(fleet_bundle_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready',
      },
      {
        query: 'sum(fleet_bundle_not_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Not Ready',
      },
    ],
    options={ height: 5, width: 17 },
  ),
  lib.createTimeSeriesPanel(
    'Bundles', [
      {
        query: 'sum(fleet_bundle_desired_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Desired Ready',
      },
      {
        query: 'sum(fleet_bundle_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Ready',
      },
      {
        query: 'sum(fleet_bundle_not_ready{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Not Ready',
      },
      {
        query: 'sum(fleet_bundle_out_of_sync{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Out of Sync',
      },
      {
        query: 'sum(fleet_bundle_err_applied{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Err Applied',
      },
      {
        query: 'sum(fleet_bundle_modified{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Modified',
      },
      {
        query: 'sum(fleet_bundle_pending{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Pending',
      },
      {
        query: 'sum(fleet_bundle_wait_applied{exported_namespace="$namespace",name=~"$name"})',
        legendFormat: 'Wait Applied',
      },
    ],
  ),
  // lib.createTimeSeriesPanel(
  //   'Bundle State', [
  //     {
  //       query: 'sum(fleet_bundle_state{exported_namespace="$namespace",name=~"$name",state=~"Ready"})',
  //       legendFormat: 'Ready',
  //     },
  //     {
  //       query: 'sum(fleet_bundle_state{exported_namespace="$namespace",name=~"$name",state=~"NotReady"})',
  //       legendFormat: 'Not Ready',
  //     },
  //     {
  //       query: 'sum(fleet_bundle_state{exported_namespace="$namespace",name=~"$name",state=~"OutOfSync"})',
  //       legendFormat: 'Out of Sync',
  //     },
  //     {
  //       query: 'sum(fleet_bundle_state{exported_namespace="$namespace",name=~"$name",state=~"ErrApplied"})',
  //       legendFormat: 'Err Applied',
  //     },
  //     {
  //       query: 'sum(fleet_bundle_state{exported_namespace="$namespace",name=~"$name",state=~"Modified"})',
  //       legendFormat: 'Modified',
  //     },
  //     {
  //       query: 'sum(fleet_bundle_state{exported_namespace="$namespace",name=~"$name",state=~"Pending"})',
  //       legendFormat: 'Pending',
  //     },
  //     {
  //       query: 'sum(fleet_bundle_state{exported_namespace="$namespace",name=~"$name",state=~"WaitApplied"})',
  //       legendFormat: 'Wait Applied',
  //     },
  //   ],
  // ),
];

lib.createDashboard('Fleet / Bundle', 'fleet-bundle', 'Bundle', panels, [
  vars.namespace,
  vars.name,
])
