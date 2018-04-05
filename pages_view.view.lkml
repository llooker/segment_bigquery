view: pages_view {
  derived_table: {
    sql: SELECT * EXCEPT (ROW_NUMBER) FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY loaded_at DESC) ROW_NUMBER FROM website.pages
  WHERE _PARTITIONTIME BETWEEN TIMESTAMP_TRUNC(TIMESTAMP_MICROS(UNIX_MICROS(CURRENT_TIMESTAMP()) - 2000 * 60 * 60 * 24 * 1000000), DAY, 'UTC')
      AND TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY, 'UTC')
)
WHERE ROW_NUMBER = 1  ;;
  }


  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: anonymous_id {
    type: string
    sql: ${TABLE}.anonymous_id ;;
  }

  dimension: context_library_name {
    type: string
    sql: ${TABLE}.context_library_name ;;
  }

  dimension: context_library_version {
    type: string
    sql: ${TABLE}.context_library_version ;;
  }

  dimension_group: loaded {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.loaded_at ;;
  }

  # Page name is optional (https://segment.com/docs/spec/page/)
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension_group: original_timestamp {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.original_timestamp ;;
  }

  dimension: path {
    type: string
    sql: ${TABLE}.path ;;
  }

  dimension_group: received {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at ;;
  }

  dimension: referrer {
    type: string
    sql: ${TABLE}.referrer ;;
  }

  dimension_group: sent {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sent_at ;;
  }

  dimension_group: timestamp {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.timestamp ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: user_id {
    type: string
    # hidden: true
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, context_library_name, name, users.context_library_name, users.id]
  }
}
