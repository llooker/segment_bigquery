- connection: bigquery

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

# NOTE: please see https://www.looker.com/docs/r/dialects/bigquery
# NOTE: for BigQuery specific considerations

- explore: sessions_trk

- explore: identifies
  joins:
    - join: users
      type: left_outer #_each
      sql_on: ${identifies.user_id} = ${users.id}
      relationship: many_to_one


- explore: identifies_view
  joins:
    - join: users
      type: left_outer #_each
      sql_on: ${identifies_view.user_id} = ${users.id}
      relationship: many_to_one


- explore: pages
  joins:
    - join: users
      type: left_outer #_each
      sql_on: ${pages.user_id} = ${users.id}
      relationship: many_to_one


- explore: pages_view
  joins:
    - join: users
      type: left_outer #_each
      sql_on: ${pages_view.user_id} = ${users.id}
      relationship: many_to_one


- explore: signup
  joins:
    - join: users
      type: left_outer #_each
      sql_on: ${signup.user_id} = ${users.id}
      relationship: many_to_one


- explore: signup_view
  joins:
    - join: users
      type: left_outer #_each
      sql_on: ${signup_view.user_id} = ${users.id}
      relationship: many_to_one


- explore: tracks
  joins:
    - join: users
      type: left_outer #_each
      sql_on: ${tracks.user_id} = ${users.id}
      relationship: many_to_one


- explore: tracks_view
  joins:
    - join: users
      type: left_outer #_each
      sql_on: ${tracks_view.user_id} = ${users.id}
      relationship: many_to_one


- explore: users

- explore: users_view

- explore: viewed_product
  joins:
    - join: users
      type: left_outer #_each
      sql_on: ${viewed_product.user_id} = ${users.id}
      relationship: many_to_one


- explore: viewed_product_view
  joins:
    - join: users
      type: left_outer #_each
      sql_on: ${viewed_product_view.user_id} = ${users.id}
      relationship: many_to_one


