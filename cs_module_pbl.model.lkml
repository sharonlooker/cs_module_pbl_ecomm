connection: "thelook_events"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: cs_module_pbl_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: cs_module_pbl_default_datagroup


explore: order_items {
  access_filter: {
    field: products.brand
    user_attribute: brand_pbl
  }

  access_filter: {
    field: users.state
    user_attribute: state_pbl
  }

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}
