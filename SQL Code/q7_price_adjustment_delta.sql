SELECT
    r.sku_id,
    s.scenario_name,
    r.price_per_unit AS current_price,
    ROUND(r.total_unit_cost / (1 - r.margin_floor), 2) AS required_price,
    ROUND((r.total_unit_cost / (1 - r.margin_floor)) - r.price_per_unit, 2) AS price_adjustment_needed,
    ROUND(((r.total_unit_cost / (1 - r.margin_floor)) - r.price_per_unit) 
          / r.price_per_unit * 100, 2) AS pct_increase_needed
FROM result_cost_scenario r
JOIN scenario s ON r.scenario_id = s.scenario_id
ORDER BY r.sku_id, s.scenario_id;