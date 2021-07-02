view: item_join_path {
  derived_table: {
    sql: select 'store_sales' as path
    union all
    select 'web_sales as path;;
  }
  dimension: path {
    type: string
 }
}
