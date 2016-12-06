- view: page_aliases_mapping
  derived_table:
    sql_trigger_value: select count(*) from website.tracks
    sql: |
      with
      -- Establish all child-to-parent edges from tables (tracks, pages, aliases) 
      all_mappings as (
        select 
          anonymous_id
          ,user_id
          ,received_at as received_at
        from website.tracks
            
        union distinct
            
        select 
          user_id
          ,null
          ,received_at
        from website.tracks
              
        union distinct
               
        select 
          anonymous_id
          ,user_id
          ,received_at
        from website.pages
               
        union distinct
               
        select 
          user_id
          ,null
          ,received_at
        from website.pages
      )
      select * from (
      select 
      -- *
        distinct anonymous_id as alias,
        coalesce(first_value(user_id)
            over(
              partition by anonymous_id
              order by COALESCE(user_id, 'ZZZZZZZZZZZZZZZZZ'), received_at desc
              rows between unbounded preceding and unbounded following), anonymous_id) as looker_visitor_id
              
      from all_mappings
      where anonymous_id IS NOT NULL
      order by anonymous_id
      ) 
      where alias is not NULL     
 

  fields:
  
  # Anonymous ID
  - dimension: alias
    primary_key: true
    sql: ${TABLE}.alias

  # User ID
  - dimension: looker_visitor_id
    sql: ${TABLE}.looker_visitor_id
  
  - measure: count
    type: count
    
  - measure: count_visitor
    type: count_distinct
    sql: ${looker_visitor_id}
    
    