- view: tracks
  sql_table_name: website.tracks
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

  - dimension: event
    type: string
    sql: ${TABLE}.event

  - dimension: event_text
    type: string
    sql: ${TABLE}.event_text

#   - dimension_group: loaded
#     type: time
#     timeframes: [time, date, week, month]
#     sql: ${TABLE}.loaded_at
# 
#   - dimension_group: original_timestamp
#     type: time
#     timeframes: [time, date, week, month]
#     sql: ${TABLE}.original_timestamp

  - dimension_group: received
    type: time
    timeframes: [raw, time, date, week, month]
    sql: ${TABLE}.received_at

  - dimension_group: sent
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.sent_at

  - dimension_group: timestamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.timestamp

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
    drill_fields: [id, context_library_name, users.context_library_name, users.id]
    

# ## Advanced Fields (require joins to other views) 
# 
#   - dimension_group: weeks_since_first_visit
#     type: number
#     sql: FLOOR(DATEDIFF(day,${user_session_facts.first_date}, ${received_date})/7)
# 
#   - dimension: is_new_user
#     sql:  |
#         CASE 
#         WHEN ${received_date} = ${user_session_facts.first_date} THEN 'New User'
#         ELSE 'Returning User' END
#   
#   - measure: count_percent_of_total
#     type: percent_of_total
#     sql: ${count}
#     value_format_name: decimal_1
#   
#     
# ## Advanced -- Session Count Funnel Meausures
#   
#   - filter: event1
#     suggestions: [added_item, app_became_active, app_entered_background, 
#                   app_entered_foreground, app_launched, app_resigned_active,
#                   asked_for_sizes, completed_order, failed_auth_validation, logged_in,
#                   made_purchase, payment_available, payment_failed, payment_form_shown,
#                   payment_form_submitted, removed_item, saved_sizes, shipping_available,
#                   shipping_form_failed, shipping_form_shown, shipping_form_submitted,
#                   signed_up, submitted_order, switched_auth_forms, tapped_shipit,
#                   view_buy_page, viewed_auth_page]
# 
#   - measure: event1_session_count
#     type: number
#     sql: | 
#       COUNT(
#         DISTINCT(
#           CASE 
#             WHEN 
#             {% condition event1 %} ${event} {% endcondition %} 
#               THEN ${track_facts.session_id}
#             ELSE NULL END 
#         )
#       )
# 
#   - filter: event2
#     suggestions: [added_item, app_became_active, app_entered_background, 
#                   app_entered_foreground, app_launched, app_resigned_active,
#                   asked_for_sizes, completed_order, failed_auth_validation, logged_in,
#                   made_purchase, payment_available, payment_failed, payment_form_shown,
#                   payment_form_submitted, removed_item, saved_sizes, shipping_available,
#                   shipping_form_failed, shipping_form_shown, shipping_form_submitted,
#                   signed_up, submitted_order, switched_auth_forms, tapped_shipit,
#                   view_buy_page, viewed_auth_page]
# 
#   - measure: event2_session_count
#     type: number
#     sql: | 
#       COUNT(
#         DISTINCT(
#           CASE 
#             WHEN 
#             {% condition event2 %} ${event} {% endcondition %} 
#               THEN ${track_facts.session_id}
#             ELSE NULL END 
#         )
#       )
#       
#   - filter: event3
#     suggestions: [added_item, app_became_active, app_entered_background, 
#                   app_entered_foreground, app_launched, app_resigned_active,
#                   asked_for_sizes, completed_order, failed_auth_validation, logged_in,
#                   made_purchase, payment_available, payment_failed, payment_form_shown,
#                   payment_form_submitted, removed_item, saved_sizes, shipping_available,
#                   shipping_form_failed, shipping_form_shown, shipping_form_submitted,
#                   signed_up, submitted_order, switched_auth_forms, tapped_shipit,
#                   view_buy_page, viewed_auth_page]
# 
#   - measure: event3_session_count
#     type: number
#     sql: | 
#       COUNT(
#         DISTINCT(
#           CASE 
#             WHEN 
#             {% condition event3 %} ${event} {% endcondition %} 
#               THEN ${track_facts.session_id}
#             ELSE NULL END 
#         )
#       )
#       
#   - filter: event4
#     suggestions: [added_item, app_became_active, app_entered_background, 
#                   app_entered_foreground, app_launched, app_resigned_active,
#                   asked_for_sizes, completed_order, failed_auth_validation, logged_in,
#                   made_purchase, payment_available, payment_failed, payment_form_shown,
#                   payment_form_submitted, removed_item, saved_sizes, shipping_available,
#                   shipping_form_failed, shipping_form_shown, shipping_form_submitted,
#                   signed_up, submitted_order, switched_auth_forms, tapped_shipit,
#                   view_buy_page, viewed_auth_page]
# 
#   - measure: event4_session_count
#     type: number
#     sql: | 
#       COUNT(
#         DISTINCT(
#           CASE 
#             WHEN 
#             {% condition event4 %} ${event} {% endcondition %} 
#               THEN ${track_facts.session_id}
#             ELSE NULL END 
#         )
#       )
      
      
      



