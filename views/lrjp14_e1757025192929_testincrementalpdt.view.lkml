view: lrjp14_e1757025192929_testincrementalpdt {
  sql_table_name: demo_db.LR$JP14E1757025192929_testincrementalpdt ;;

  dimension: count_lrjp14_e1757025192929_testincrementalpdt {
    type: number
    sql: ${TABLE}.count ;;
  }
  dimension_group: created_year {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_year ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  measure: count {
    type: count
  }
}
