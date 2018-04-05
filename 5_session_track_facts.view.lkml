# Facts about a particular Session.

view: session_trk_facts {
  derived_table: {
    sql_trigger_value: select count(*) from ${track_facts.SQL_TABLE_NAME} ;;
    sql: SELECT s.session_id
        , MAX(map.timestamp) AS ended_time
        , count(distinct map.event_id) AS num_pvs
        , count(case when map.event = 'viewed_product' then event_id else null end) as cnt_viewed_product
        , count(case when map.event = 'signup' then event_id else null end) as cnt_signup
      FROM ${sessions_trk.SQL_TABLE_NAME} AS s
      LEFT JOIN ${track_facts.SQL_TABLE_NAME} as map on map.session_id = s.session_id
      GROUP BY 1
       ;;
  }

  dimension: session_id {
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension_group: ended_time {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.ended_time ;;
  }

  dimension: number_events {
    type: number
    sql: ${TABLE}.num_pvs ;;
  }

  dimension: is_bounced_session {
    type: yesno
    sql: ${number_events} = 1 ;;
  }

  dimension: viewed_product {
    type: yesno
    sql: ${TABLE}.cnt_viewed_product > 0 ;;
  }

  dimension: signup {
    type: yesno
    sql: ${TABLE}.cnt_signup > 0 ;;
  }

  measure: count_viewed_product {
    type: count

    filters: {
      field: viewed_product
      value: "yes"
    }
  }

  measure: count_signup {
    type: count

    filters: {
      field: signup
      value: "yes"
    }
  }


}
