local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').clusterGroup;

local bundles = lib.panelGroupData(
  readyTitle='Ready Bundles',
  readyQuery='sum(fleet_cluster_group_bundle_ready{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_cluster_group_bundle_desired_ready{exported_namespace="$namespace",name=~"$name"})',
  title='Bundles',
  queries=[
    {
      query: 'sum(fleet_cluster_group_bundle_desired_ready{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Desired Ready',
    },
    {
      query: 'sum(fleet_cluster_group_bundle_ready{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Ready',
    },
  ],
);

local clusters = lib.panelGroupData(
  readyTitle='Ready Clusters',
  readyQuery='(sum(fleet_cluster_group_cluster_count{exported_namespace="$namespace",name=~"$name"}) - sum(fleet_cluster_group_non_ready_cluster_count{exported_namespace="$namespace",name=~"$name"})) / sum(fleet_cluster_group_cluster_count{exported_namespace="$namespace",name=~"$name"})',
  title='Clusters',
  queries=[
    {
      query: 'sum(fleet_cluster_group_cluster_count{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Total',
    },
    {
      query: 'sum(fleet_cluster_group_non_ready_cluster_count{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Non Ready',
    },
  ],
);

local resources = lib.panelGroupData(
  readyTitle='Ready Resources',
  readyQuery='sum(fleet_cluster_group_resource_count_ready{exported_namespace="$namespace",name=~"$name"}) / sum(fleet_cluster_group_resource_count_desired_ready{exported_namespace="$namespace",name=~"$name"})',
  title='Resources',
  queries=
  [
    {
      query: 'sum(fleet_cluster_group_resource_count_desired_ready{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Desired Ready',
    },
    {
      query: 'sum(fleet_cluster_group_resource_count_ready{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Ready',
    },
    {
      query: 'sum(fleet_cluster_group_resource_count_notready{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Not Ready',
    },
    {
      query: 'sum(fleet_cluster_group_resource_count_missing{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Missing',
    },
    {
      query: 'sum(fleet_cluster_group_resource_count_modified{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Modified',
    },
    {
      query: 'sum(fleet_cluster_group_resource_count_orphaned{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Orphaned',
    },
    {
      query: 'sum(fleet_cluster_group_resource_count_unknown{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Unknown',
    },
    {
      query: 'sum(fleet_cluster_group_resource_count_waitapplied{exported_namespace="$namespace",name=~"$name"})',
      legendFormat: 'Wait Applied',
    },
  ],
);

local panels =
  lib.createPanelGroup(bundles) +
  lib.createPanelGroup(clusters) +
  lib.createPanelGroup(resources);

local templateVariables = [
  vars.namespace,
  vars.name,
];

lib.createDashboard(
  'Fleet / ClusterGroup',
  'fleet-cluster-group',
  'ClusterGroup',
  panels,
  templateVariables,
)
