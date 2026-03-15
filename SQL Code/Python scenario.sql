SELECT result_id, sku_id, scenario_id, as_of_month,
       total_unit_cost, margin_pct, margin_flag, run_timestamp
FROM result_cost_scenario
ORDER BY scenario_id, sku_id;