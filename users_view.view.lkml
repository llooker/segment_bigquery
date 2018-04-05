view: users_view {
  derived_table: {
    sql: SELECT * EXCEPT (ROW_NUMBER) FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY loaded_at DESC) ROW_NUMBER FROM website.users
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

  dimension: plan {
    type: string
    sql: ${TABLE}.plan ;;
  }

  dimension_group: received {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, context_library_name]
  }
}
