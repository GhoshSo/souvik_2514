view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: "Break down by Day"
      value: "day"
    }
    allowed_value: {
      label: "Break down by Month"
      value: "month"
    }
  }

  dimension: date {
    sql:
    {% if date_granularity._parameter_value == 'day' %}
      ${created_date}
    {% elsif date_granularity._parameter_value == 'month' %}
      ${created_month}
    {% else %}
      ${created_date}
    {% endif %};;
  }
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }
  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  first_name,
  last_name,
  demo_visits_data.count,
  events.count,
  orders.count,
  saralooker.count,
  sindhu.count,
  user_data.count
  ]
  }




















  filter: date_filter {
    label: "The Date Filter"
    hidden: no
    type: date
    datatype: date
  }

  dimension: new_start_current_period {
    hidden: yes
    type: date
    sql: {% date_start date_filter %} ;;
  }

  dimension: new_end_current_period {
    hidden: yes
    type: date
    sql: date_sub({% date_end date_filter %}, interval 1 day) ;;
  }

  dimension: date_diff {
    type: number
    sql: DATEDIFF(${new_end_current_period}, ${new_start_current_period}) ;;
  }
  measure: sum_date_diff {
    type: number
    sql: SUM(${date_diff}) ;;
  }



}
