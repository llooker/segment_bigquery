- view: users_view
  sql_table_name: website.users_view
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: context_library_name
    type: string
    sql: ${TABLE}.context_library_name

  - dimension: context_library_version
    type: string
    sql: ${TABLE}.context_library_version

  - dimension_group: loaded
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.loaded_at

  - dimension: plan
    type: string
    sql: ${TABLE}.plan

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - measure: count
    type: count
    approximate_threshold: 100000
    drill_fields: [id, context_library_name]

