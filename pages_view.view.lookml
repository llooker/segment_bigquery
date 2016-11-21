- view: pages_view
  sql_table_name: website.pages_view
  fields:

  - dimension: id
    primary_key: true
    type: string
    sql: ${TABLE}.id

  - dimension: anonymous_id
    type: string
    sql: ${TABLE}.anonymous_id

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

  - dimension: name
    type: string
    sql: ${TABLE}.name

  - dimension_group: original_timestamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.original_timestamp

  - dimension: path
    type: string
    sql: ${TABLE}.path

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: referrer
    type: string
    sql: ${TABLE}.referrer

  - dimension_group: sent
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sent_at

  - dimension_group: timestamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.timestamp

  - dimension: title
    type: string
    sql: ${TABLE}.title

  - dimension: url
    type: string
    sql: ${TABLE}.url

  - dimension: user_id
    type: string
    # hidden: true
    sql: ${TABLE}.user_id

  - measure: count
    type: count
    approximate_threshold: 100000
    drill_fields: [id, context_library_name, name, users.context_library_name, users.id]

