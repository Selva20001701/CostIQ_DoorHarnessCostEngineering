SELECT
    r.sku_id,
    s.scenario_name,
    r.total_unit_cost,
    ROUND(r.total_unit_cost / (1 - r.margin_floor), 2) AS required_price,
    r.price_per_unit AS current_price,
    ROUND((r.total_unit_cost / (1 - r.margin_floor)) - r.price_per_unit, 2) AS price_gap
FROM result_cost_scenario r
JOIN scenario s ON r.scenario_id = s.scenario_id
WHERE r.margin_flag = true
ORDER BY r.sku_id, s.scenario_id;