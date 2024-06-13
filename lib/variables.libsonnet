local g = import './g.libsonnet';
local var = g.dashboard.variable;

local templateVar(templateVarName, labelName, metricName, includeAll=false) =
  var.query.new(templateVarName)
  + var.query.withDatasource('prometheus', 'prometheus')
  + var.query.queryTypes.withLabelValues(labelName, metricName)
  + var.query.refresh.onTime()
  + if includeAll then var.query.selectionOptions.withIncludeAll() else {};

{
  gitrepo: {
    namespace: templateVar(
      'namespace',
      'exported_namespace',
      'fleet_gitrepo_desired_ready_clusters',
    ),
    name: templateVar(
      'name',
      'name',
      'fleet_gitrepo_desired_ready_clusters{exported_namespace=~"$namespace"}',
      true,
    ),
  },
  bundle: {
    namespace: templateVar(
      'namespace',
      'exported_namespace',
      'fleet_bundle_desired_ready',
    ),
    name: templateVar(
      'name',
      'name',
      'fleet_bundle_desired_ready{exported_namespace=~"$namespace"}',
      true,
    ),
  },
  cluster: {
    namespace: templateVar(
      'namespace',
      'exported_namespace',
      'fleet_cluster_desired_ready_git_repos',
    ),
    name: templateVar(
      'name',
      'name',
      'fleet_cluster_desired_ready_git_repos{exported_namespace=~"$namespace"}',
      true,
    ),
  },
  clusterGroup: {
    namespace: templateVar(
      'namespace',
      'exported_namespace',
      'fleet_cluster_group_bundle_desired_ready',
    ),
  },
}
