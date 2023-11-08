# 🥪 The Jaffle Shop 🦘
This repo provides a production example of a dbt project containting [metrics](https://docs.getdbt.com/docs/build/metrics-overview) and [semantic models](https://docs.getdbt.com/docs/build/semantic-models). These resources are required to use the dbt semantic layer. To get started, follow the instructions below: 

## Prerequisites
- Snowflake
- 🚧 dbt cloud for some of the workflows can also set most of this up via dbt core
- [taskfile](https://taskfile.dev/)

# Setup

## Install
```bash
task deps
```

## Test the connection
1. Update the `profile` within `dbt_project.yml` to refer to one of your pre-existing profile

```shell
dbt debug
```

## Load data

```shell
dbt seed
```

## Run your dbt project, and query metrics

```shell
dbt build --exclude path:jaffle-data
mf validate-configs
mf query --metrics large_orders
```

# Demoing CICD

## linting
[sqlfluff](https://sqlfluff.com/)
```bash
sqlfluff lint models
sqlfluff fix models
```

## regression
[datafold](https://www.datafold.com/)

Review your impact of code changes on the data. See pull requests for cloud demo.

🚧 do some local dev regression testing demos.

## semantic layer

```bash
mf list metrics
mf query --metrics revenue 
mf list dimensions --metrics revenue
mf query --metrics revenue --group-by product__product_name
mf list entities --metrics revenue
```

Lets look at using time
```bash
mf query --metrics revenue --group-by metric_time
mf query --metrics revenue --group-by metric_time__month
mf query --metrics revenue --group-by metric_time__week
mf query --metrics revenue --group-by metric_time__year
```


user `dbt sl` instead of `mf` in dbt cloud

# Limitations

dbt semantic layer only possible currently with teams or enterprise editions.

coming soon in single tenant: [Set up the dbt Semantic Layer | dbt Developer Hub](https://docs.getdbt.com/docs/use-dbt-semantic-layer/setup-sl)