view: aliases_mapping {
  derived_table: {
   # sql_trigger_value: select count(*) from website.tracks ;;
    sql: with
      all_mappings as (
        select anonymous_id
        , user_id
        , timestamp as timestamp
        from ${tracks_view.SQL_TABLE_NAME}

        union distinct

        select user_id
          , null
          , timestamp
        from  ${tracks_view.SQL_TABLE_NAME}
      )

      select
         distinct anonymous_id as alias
        ,coalesce(first_value(user_id)
            over(
              partition by anonymous_id
              order by timestamp desc
              rows between unbounded preceding and unbounded following), user_id, anonymous_id) as looker_visitor_id
      from all_mappings
       ;;
  }

  # Anonymous ID
  dimension: alias {
    type: string
    primary_key: yes
    sql: ${TABLE}.alias ;;
  }

  # User ID
  dimension: looker_visitor_id {
    type: string
    sql: ${TABLE}.looker_visitor_id ;;
  }
}
