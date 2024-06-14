local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').bundleDeployment;

local bundleDeployment = {
  readyTitle: 'Ready BundleDeployments',
  readyQuery: 'sum(fleet_bundledeployment_state{cluster_namespace=~"$namespace",state="Ready"}) / sum(fleet_bundledeployment_state{cluster_namespace=~"$namespace"})',
  title: 'BundleDeployments',
  queries: [
    {
      query: 'sum(fleet_bundledeployment_state{cluster_namespace=~"$namespace",state="Ready"})',
      legendFormat: 'Ready',
    },
    {
      query: 'sum(fleet_bundledeployment_state{cluster_namespace=~"$namespace",state="NotReady"})',
      legendFormat: 'Not Ready',
    },
    {
      query: 'sum(fleet_bundledeployment_state{cluster_namespace=~"$namespace",state="WaitApplied"})',
      legendFormat: 'Wait Applied',
    },
    {
      query: 'sum(fleet_bundledeployment_state{cluster_namespace=~"$namespace",state="ErrApplied"})',
      legendFormat: 'Err Applied',
    },
    {
      query: 'sum(fleet_bundledeployment_state{cluster_namespace=~"$namespace",state="OutOfSync"})',
      legendFormat: 'OutOfSync',
    },
    {
      query: 'sum(fleet_bundledeployment_state{cluster_namespace=~"$namespace",state="Pending"})',
      legendFormat: 'Pending',
    },
    {
      query: 'sum(fleet_bundledeployment_state{cluster_namespace=~"$namespace",state="Modified"})',
      legendFormat: 'Modified',
    },
  ],
};

local panels = lib.createPanelGroup(bundleDeployment);

local templateVariables = [vars.namespace];

lib.createDashboard(
  'Fleet / BundleDeployment',
  'fleet-bundledeployment',
  'BundleDeployment',
  panels,
  templateVariables,
)
