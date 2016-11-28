
- view: aliases_mapping
  derived_table:
#     sql_trigger_value: select current_date
#     indexes: [anonymous_id, user_id]
    sql: |
      with
      all_mappings as (
        select anonymous_id
        , user_id
        , received_at as received_at
        from website.tracks
            
        union distinct
            
        select user_id
          , null
          , received_at
        from website.tracks
      )
            
      select 
        distinct anonymous_id as alias
        ,coalesce(first_value(user_id) 
        over(
          partition by anonymous_id 
          order by received_at 
          rows between unbounded preceding and unbounded following),anonymous_id) as looker_visitor_id
      from all_mappings


  fields:
  - measure: count
    type: count
    drill_fields: detail*
    
  - dimension: alias
    type: string
    primary_key: true
    sql: ${TABLE}.alias

  - dimension: looker_visitor_id
    type: string
    sql: ${TABLE}.looker_visitor_id

