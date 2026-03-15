SELECT
    r.sku_id,
    s.scenario_name,
    ROUND(r.margin_pct * 100, 2) AS margin_pct,
    r.margin_flag
FROM result_cost_scenario r
JOIN scenario s ON r.scenario_id = s.scenario_id
ORDER BY r.sku_id, s.scenario_id;