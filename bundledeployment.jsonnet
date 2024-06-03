local lib = import 'funcs.libsonnet';

local panelData = [
  {
    title: 'Bundledeployment State',
    query: 'fleet_bundledeployment_state',
  },
];

local panels = [lib.createPanel(p.title, p.query) for p in panelData];

lib.createDashboard('Fleet / BundleDeployment', 'fleet-bundledeployment', 'BundleDeployment', panels)
