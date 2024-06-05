local g = import './g.libsonnet';
local var = g.dashboard.variable;


{
  // cluster:
  //   var.query.new('cluster')
  //   + var.query.withDatasourceFromVariable(self.datasource)
  //   + var.query.queryTypes.withLabelValues(
  //     'cluster',
  //     'process_cpu_seconds_total',
  //   )
  //   + var.query.withRefresh('time')
  //   + var.query.selectionOptions.withMulti()
  //   + var.query.selectionOptions.withIncludeAll(),

  namespace:
    var.query.new('namespace')
    // + var.query.withDatasourceFromVariable(self.datasource)
    + var.query.withDatasource('prometheus', 'prometheus')
    + var.query.queryTypes.withLabelValues(
      'exported_namespace',
      'fleet_gitrepo_desired_ready_clusters',
    )
    + var.query.refresh.onTime()
    ,
}
