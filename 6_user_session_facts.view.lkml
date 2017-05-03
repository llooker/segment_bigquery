view: user_session_facts {
  derived_table: {
    sql_trigger_value: select count(*) from ${session_trk_facts.SQL_TABLE_NAME} ;;
    sql: SELECT
        looker_visitor_id
        , MIN(s.session_start_at) as first_date
        , MAX(s.session_start_at) as last_date
        , COUNT(*) as number_of_sessions
      FROM ${sessions_trk.SQL_TABLE_NAME} as s
      LEFT JOIN ${session_trk_facts.SQL_TABLE_NAME} as sf
      ON s.session_id = sf.session_id
      GROUP BY 1
       ;;
  }

  #     Define your dimensions and measures here, like this:
  dimension: looker_visitor_id {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.looker_visitor_id ;;
  }

  dimension: number_of_sessions {
    type: number
    sql: ${TABLE}.number_of_sessions ;;
  }

  dimension: number_of_sessions_tiered {
    type: tier
    sql: ${number_of_sessions} ;;
    tiers: [
      1,
      2,
      3,
      4,
      5,
      10
    ]
  }

  dimension_group: first {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.first_date ;;
  }

  dimension_group: last {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.last_date ;;
  }
}
