SELECT 
    r.sku_id,
    MAX(CASE WHEN s.scenario_name = 'Copper +20%' THEN r.total_unit_cost END) -
    MAX(CASE WHEN s.scenario_name = 'Baseline'    THEN r.total_unit_cost END) AS copper_cost_impact,
    MAX(CASE WHEN s.scenario_name = 'Baseline'    THEN r.total_unit_cost END) AS baseline_cost
FROM result_cost_scenario r
JOIN scenario s ON r.scenario_id = s.scenario_id
GROUP BY r.sku_id
ORDER BY copper_cost_impact DESC;