view: mapped_tracks {
  derived_table: {
    sql_trigger_value: select count(*) from ${aliases_mapping.SQL_TABLE_NAME} ;;
    sql: select *
        ,timestamp_diff(timestamp, lag(timestamp) over(partition by looker_visitor_id order by timestamp), minute) as idle_time_minutes
      from (
        select CONCAT(cast(t.timestamp AS string), t.anonymous_id) as event_id
          ,t.anonymous_id
          ,a2v.looker_visitor_id
          ,t.timestamp
          ,t.event as event
        from website.tracks_view as t
        inner join ${aliases_mapping.SQL_TABLE_NAME} as a2v
        on a2v.alias = coalesce(t.user_id, t.anonymous_id)
        )
       ;;
  }

  dimension: anonymous_id {
    sql: ${TABLE}.anonymous_id ;;
  }

  dimension: event_id {
    sql: ${TABLE}.event_id ;;
  }

  dimension: looker_visitor_id {
    sql: ${TABLE}.looker_visitor_id ;;
  }

  dimension_group: timestamp {
    type: time
    hidden: yes
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.timestamp ;;
  }


  dimension: event {
    sql: ${TABLE}.event ;;
  }

  dimension: idle_time_minutes {
    type: number
    sql: ${TABLE}.idle_time_minutes ;;
  }

  set: detail {
    fields: [event_id, looker_visitor_id, event, idle_time_minutes]
  }
}
