local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').gitrepo;

local panels = [
  lib.createTimeSeriesPanel('Time to fetch latest commit - 99th Percentile', [
    {
      query: 'histogram_quantile(0.99, sum(increase(fleet_gitrepo_fetch_latest_commit_duration_seconds_bucket[$__rate_interval])) by (le, namespace, name)) > 0',
      legendFormat: '{{name}} in {{namespace}}',
    },
  ], { width: 8, height: 8 }),
  lib.createTimeSeriesPanel('Time to fetch latest commit - 90th Percentile', [
    {
      query: 'histogram_quantile(0.90, sum(increase(fleet_gitrepo_fetch_latest_commit_duration_seconds_bucket[$__rate_interval])) by (le, namespace, name)) > 0',
      legendFormat: '{{name}} in {{namespace}}',
    },
  ], { width: 8, height: 8 }),
  lib.createTimeSeriesPanel('Time to fetch latest commit - 50th Percentile', [
    {
      query: 'histogram_quantile(0.50, sum(increase(fleet_gitrepo_fetch_latest_commit_duration_seconds_bucket[$__rate_interval])) by (le, namespace, name)) > 0',
      legendFormat: '{{name}} in {{namespace}}',
    },
  ], { width: 8, height: 8 }),
  lib.createBarGaugePanel('Time to fetch latest commit', [
    {
      query: 'sum by (le) (increase(fleet_gitrepo_fetch_latest_commit_duration_seconds_bucket[$__range]))',
      format: 'heatmap',
    },
  ], { width: 12, height: 8 }),
  lib.createHeatmapPanel('Time to fetch latest commit - Heatmap', [
    {
      query: 'sum(increase(fleet_gitrepo_fetch_latest_commit_duration_seconds_bucket[$__rate_interval])) by (le)',
      format: 'heatmap',
      legendFormat: '{{name}} in {{namespace}}',
    },
  ], { width: 12, height: 8 }),
];

local templateVariables = [
  vars.namespace,
  vars.name,
];

lib.createDashboard('Fleet / GitJob', 'fleet-gitjob', 'GitJob', panels, templateVariables)
