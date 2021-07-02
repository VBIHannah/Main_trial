connection: "snowflake_demo"

# include all the views
include: "/views/**/*.view"

datagroup: hannah_sf_example_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: hannah_sf_example_default_datagroup

explore: call_center {}

explore: catalog_page {}

explore: catalog_returns {}

explore: catalog_sales {}

explore: customer {}

explore: customer_address {}

explore: customer_demographics {}

explore: date_dim {}

explore: dbgen_version {}

explore: household_demographics {}

explore: income_band {}

explore: inventory {}

explore: item {

  join: item_join_path {
    type: cross
    relationship: one_to_one
  }
  join: store_sales {
    sql_on: ${item_join_path.path} = 'store_sales'
      and ${item.i_item_sk} = ${store_sales.ss_item_sk};;
    relationship: one_to_one
  }
  join: web_sales {
    sql_on: ${item_join_path.path} = 'web_sales'
      and ${item.i_item_sk} = ${web_sales.ws_item_sk};;
    relationship: one_to_one
  }
  join:  date_dim{
    type: inner
    relationship: many_to_one
    sql_on: ${store_sales.ss_sold_date_sk} =  ${date_dim.d_date_sk}
          or
          ${web_sales.ws_sold_date_sk} =  ${date_dim.d_date_sk};;
    #required_joins: [store_sales,web_sales]
  }
}

explore: item_join_path {}

explore: promotion {}

explore: reason {}

explore: ship_mode {}

explore: store {}

explore: store_returns {
  join:  customer{
    type: inner
    relationship: many_to_one
    sql_on: ${store_returns.sr_customer_sk} = ${customer.c_customer_sk} ;;
  }
  join:  date_dim{
    type: inner
    relationship: many_to_one
    sql_on: ${store_returns.sr_returned_date_sk} =  ${date_dim.d_date_sk};;
  }
  join:  store{
    type: inner
    relationship: many_to_one
    sql_on: ${store_returns.sr_store_sk} =  ${store.s_store_sk};;
  }
  join:  item{
    type: inner
    relationship: many_to_one
    sql_on: ${store_returns.sr_item_sk} =  ${item.i_item_sk};;
  }
}

explore: store_returns_bkp {}

explore: store_sales {
  join:  customer{
    type: inner
    relationship: many_to_one
    sql_on: ${store_sales.ss_customer_sk} = ${customer.c_customer_sk} ;;
  }
  join:  date_dim{
    type: inner
    relationship: many_to_one
    sql_on: ${store_sales.ss_sold_date_sk} =  ${date_dim.d_date_sk};;
  }
  join:  item{
    type: inner
    relationship: many_to_one
    sql_on: ${store_sales.ss_item_sk} =  ${item.i_item_sk};;
  }
  join:  store{
    type: inner
    relationship: many_to_one
    sql_on: ${store_sales.ss_store_sk} =  ${store.s_store_sk};;
  }
  join: web_sales {
    type: full_outer
    relationship: one_to_many
    sql_on: ${item.i_item_sk} = ${web_sales.ws_item_sk} ;;
    required_joins: [item]
  }
}

explore: store_sales_bkp {}

explore: time_dim {}

explore: warehouse {}

explore: web_page {}

explore: web_returns {
  join:  date_dim{
    type: inner
    relationship: many_to_one
    sql_on: ${web_returns.wr_returned_date_sk} =  ${date_dim.d_date_sk};;
  }
}

explore: web_returns_bkp {}

explore: web_sales {
  join:  date_dim{
    type: left_outer
    relationship: many_to_one
    sql_on: ${web_sales.ws_sold_date_sk} =  ${date_dim.d_date_sk};;
  }
  join:  item{
    type: inner
    relationship: many_to_one
    sql_on: ${web_sales.ws_item_sk} =  ${item.i_item_sk};;
  }
  join: store_sales {
    type: full_outer
    relationship: one_to_many
    sql_on: ${item.i_item_sk} = ${store_sales.ss_item_sk} ;;
    required_joins: [item]
  }
}

explore: web_sales_bkp {}

explore: web_site {}
