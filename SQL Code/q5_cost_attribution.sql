SELECT
    r.sku_id,
    s.scenario_name,
    ROUND(r.copper_cost     - b.copper_cost,      4) AS copper_delta,
    ROUND(r.labor_cost      - b.labor_cost,        4) AS labor_delta,
    ROUND(r.purchased_cost  - b.purchased_cost,    4) AS purchased_delta,
    ROUND(r.total_unit_cost - b.total_unit_cost,   4) AS total_cost_delta
FROM result_cost_scenario r
JOIN scenario s ON r.scenario_id = s.scenario_id
JOIN result_cost_scenario b ON b.sku_id = r.sku_id
JOIN scenario bs ON b.scenario_id = bs.scenario_id
    AND bs.scenario_name = 'Baseline'
WHERE s.scenario_name != 'Baseline'
ORDER BY r.sku_id, s.scenario_id;