- explore: pages_test
  from: pages

- view: pages
  sql_table_name: website.pages
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

#   - dimension_group: loaded
#     type: time
#     timeframes: [time, date, week, month]
#     sql: ${TABLE}.loaded_at

  - dimension: name
    type: string
    sql: ${TABLE}.name

#   - dimension_group: original_timestamp
#     type: time
#     timeframes: [time, date, week, month]
#     sql: ${TABLE}.original_timestamp

  - dimension: path
    type: string
    sql: ${TABLE}.path

  - dimension_group: received
    type: time
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: referrer
    type: string
    sql: ${TABLE}.referrer

#   - dimension_group: sent
#     type: time
#     timeframes: [time, date, week, month]
#     sql: ${TABLE}.sent_at
# 
#   - dimension_group: timestamp
#     type: time
#     timeframes: [time, date, week, month]
#     sql: ${TABLE}.timestamp

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

#   - dimension_group: uuid_ts
#     type: time
#     timeframes: [time, date, week, month]
#     sql: ${TABLE}.uuid_ts

  - measure: count
    type: count
    drill_fields: [id, context_library_name, name, users.id]
    
#   - measure: count_visitors
#     type: count_distinct 
#     sql: ${page_facts.looker_visitor_id}
# 
#   - measure: count_pageviews
#     type: count
#     drill_fields: [context_library_name]
# 
#   - measure: avg_page_view_duration_minutes
#     type: average
#     value_format_name: decimal_1
#     sql: ${page_facts.duration_page_view_seconds}/60.0
#   
#   - measure: count_distinct_pageviews
#     type: number
#     sql: COUNT(DISTINCT CONCAT(${page_facts.looker_visitor_id}, ${url}))



