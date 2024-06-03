local lib = import 'funcs.libsonnet';

local panelData = [
  {
    title: 'Bundle Desired Ready',
    query: 'fleet_bundle_desired_ready',
  },
  {
    title: 'Bundle Err Applied',
    query: 'fleet_bundle_err_applied',
  },
  {
    title: 'Bundle Modified',
    query: 'fleet_bundle_modified',
  },
  {
    title: 'Bundle Not Ready',
    query: 'fleet_bundle_not_ready',
  },
  {
    title: 'Bundle Out of Sync',
    query: 'fleet_bundle_out_of_sync',
  },
  {
    title: 'Bundle Pending',
    query: 'fleet_bundle_pending',
  },
  {
    title: 'Bundle Ready',
    query: 'fleet_bundle_ready',
  },
  {
    title: 'Bundle State',
    query: 'fleet_bundle_state',
  },
  {
    title: 'Bundle Wait Applied',
    query: 'fleet_bundle_wait_applied',
  },
];

local panels = [lib.createPanel(p.title, p.query) for p in panelData];

lib.createDashboard('Fleet / Bundle', 'fleet-bundle', 'Bundle', panels)
