local lib = import '../lib/funcs.libsonnet';
local variables = import '../lib/variables.libsonnet';

local panelData = [
  {
    title: 'Bundledeployment State',
    query: 'fleet_bundledeployment_state',
  },
];

local panels = [lib.createTimeSeriesPanel(p.title, p.query) for p in panelData];

lib.createDashboard(
  'Fleet / BundleDeployment',
  'fleet-bundledeployment',
  'BundleDeployment',
  panels,
)
