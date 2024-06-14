local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').bundle;

local bundles = lib.panelGroupData(
  readyTitle='Ready Bundles',
  readyQuery='sum(fleet_bundle_ready{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_bundle_desired_ready{exported_namespace="$namespace",name=~"$name"})',
  title='Bundles',
  queries=[
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
);

local panels = lib.createPanelGroup(bundles);

local templateVariables = [
  vars.namespace,
  vars.name,
];

lib.createDashboard('Fleet / Bundle', 'fleet-bundle', 'Bundle', panels, templateVariables)
