local lib = import '../lib/funcs.libsonnet';
local vars = (import '../lib/variables.libsonnet').controllerRuntime;

local panels = [
  // Reconciliation Metrics
  lib.createStatPanel(
    'Number of Workers in Use',
    [
      {
        query: 'controller_runtime_active_workers{job="$job", namespace="$namespace"}',
        legendFormat: '{{controller}} {{instance}}',
      },
    ]
  ),
  lib.createTimeSeriesPanel(
    'Reconciliation Error Count per Controller',
    [
      {
        query: 'sum(rate(controller_runtime_reconcile_errors_total{job="$job", namespace="$namespace"}[5m])) by (instance, pod)',
        legendFormat: '{{instance}} {{pod}}',
      },
    ],
    options={
      decimals: null,
    },
  ),
  lib.createTimeSeriesPanel(
    'Total Reconciliation Count per Controller',
    [
      {
        query: 'sum(rate(controller_runtime_reconcile_total{job="$job", namespace="$namespace"}[5m])) by (instance, pod)',
        legendFormat: '{{instance}} {{pod}}',
      },
    ],
    options={
      decimals: null,
    },
  ),
  // Work Queue Metrics
  lib.createStatPanel(
    'WorkQueue Depth',
    [
      {
        query: 'workqueue_depth{job="$job", namespace="$namespace"}',
        legendFormat: '{{instance}} {{pod}}',
      },
    ],
  ),
  lib.createTimeSeriesPanel(
    'Seconds for Items Stay in Queue (before being requested) P50',
    [
      {
        query: 'histogram_quantile(0.50, sum(rate(workqueue_queue_duration_seconds_bucket{job="$job", namespace="$namespace"}[5m])) by (instance, name, le))',
        legendFormat: '{{name}}',
      },
    ],
    {
      decimals: null,
    },
  ),
  lib.createTimeSeriesPanel(
    'Seconds for Items Stay in Queue (before being requested) P90',
    [
      {
        query: 'histogram_quantile(0.90, sum(rate(workqueue_queue_duration_seconds_bucket{job="$job", namespace="$namespace"}[5m])) by (instance, name, le))',
        legendFormat: '{{name}}',
      },
    ],
    {
      decimals: null,
    },
  ),
  lib.createTimeSeriesPanel(
    'Seconds for Items Stay in Queue (before being requested) P99',
    [
      {
        query: 'histogram_quantile(0.99, sum(rate(workqueue_queue_duration_seconds_bucket{job="$job", namespace="$namespace"}[5m])) by (instance, name, le))',
        legendFormat: '{{name}}',
      },
    ],
    {
      decimals: null,
    },
  ),
  lib.createTimeSeriesPanel(
    'Work Queue Add Rate',
    [
      {
        query: 'sum(rate(workqueue_adds_total{job="$job", namespace="$namespace"}[2m])) by (instance, name)',
        legendFormat: '{{name}} {{instance}}',
      },
    ],
    {
      decimals: null,
    },
  ),
  lib.createStatPanel(
    'Unfinished Seconds',
    [
      {
        query: 'rate(workqueue_unfinished_work_seconds{job="$job", namespace="$namespace"}[5m])',
        legendFormat: '{{name}} {{instance}}',
      },
    ],
    {
      decimals: null,
    },
  ),
  lib.createTimeSeriesPanel(
    'Seconds Processing Items from WorkQueue - 50th Percentile',
    [
      {
        query: 'histogram_quantile(0.50, sum(rate(workqueue_work_duration_seconds_bucket{job="$job", namespace="$namespace"}[5m])) by (instance, name, le))',
        legendFormat: '{{name}}',
      },
    ],
    {
      decimals: null,
    },
  ),
  lib.createTimeSeriesPanel(
    'Seconds Processing Items from WorkQueue - 90th Percentile',
    [
      {
        query: 'histogram_quantile(0.90, sum(rate(workqueue_work_duration_seconds_bucket{job="$job", namespace="$namespace"}[5m])) by (instance, name, le))',
        legendFormat: '{{name}}',
      },
    ],
    {
      decimals: null,
    },
  ),
  lib.createTimeSeriesPanel(
    'Seconds Processing Items from WorkQueue - 99th Percentile',
    [
      {
        query: 'histogram_quantile(0.99, sum(rate(workqueue_work_duration_seconds_bucket{job="$job", namespace="$namespace"}[5m])) by (instance, name, le))',
        legendFormat: '{{name}}',
      },
    ],
    {
      decimals: null,
    },
  ),
  lib.createTimeSeriesPanel(
    'Work Queue Retries Rate',
    [
      {
        query: 'sum(rate(workqueue_retries_total{job="$job", namespace="$namespace"}[5m])) by (instance, name)',
        legendFormat: '{{name}} {{instance}}',
      },
    ],
    {
      decimals: null,
    },
  ),
];

local templateVariables = [
  vars.namespace,
  vars.job,
];

lib.createDashboard(
  'Fleet / Controller-Runtime',
  'fleet-controller-runtime',
  'Controller Runtime',
  panels,
  templateVariables
)
