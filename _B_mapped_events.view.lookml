
- view: mapped_events
  derived_table:
    sql_trigger_value: select count(*) from ${page_aliases_mapping.SQL_TABLE_NAME}
    sql: |
      select *
        ,timestamp_diff(received_at, lag(received_at) over(partition by looker_visitor_id order by received_at), minute) as idle_time_minutes
      from (
        select CONCAT(cast(t.received_at AS string), t.anonymous_id, '-t') as event_id
          ,t.anonymous_id
          ,coalesce(a2v.looker_visitor_id,a2v.alias) as looker_visitor_id
          ,t.received_at
          ,NULL as referrer
          ,'tracks' as event_source
        from website.tracks as t
        inner join ${page_aliases_mapping.SQL_TABLE_NAME} as a2v
        on a2v.alias = coalesce(t.user_id, t.anonymous_id)
          
        union all
                      
        select CONCAT(cast(t.received_at AS string), t.anonymous_id, '-p') as event_id
          ,t.anonymous_id
          ,coalesce(a2v.looker_visitor_id,a2v.alias) as looker_visitor_id
          ,t.received_at
          ,t.referrer as referrer
          ,'pages' as event_source
        from segment.pages as t
        inner join ${page_aliases_mapping.SQL_TABLE_NAME} as a2v
          on a2v.alias = coalesce(t.user_id, t.anonymous_id)                      
      ) as e 
                      

  fields:

  - dimension: event_id
    sql: ${TABLE}.event_id

  - dimension: looker_visitor_id
    sql: ${TABLE}.looker_visitor_id
  
  - dimension: anonymous_id
    sql: ${TABLE}.anonymous_id

  - dimension_group: received_at
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension: event
    sql: ${TABLE}.event

  - dimension: referrer
    sql: ${TABLE}.referrer

  - dimension: event_source
    sql: ${TABLE}.event_source

  - dimension: idle_time_minutes
    type: number
    sql: ${TABLE}.idle_time_minutes

  sets:
    detail:
      - event_id
      - looker_visitor_id
      - received_at
      - event
      - referrer
      - event_source
      - idle_time_minutes

