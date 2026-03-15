SELECT
    sku_id,
    ROUND(copper_cost    / total_unit_cost * 100, 2) AS copper_pct,
    ROUND(non_copper_cost/ total_unit_cost * 100, 2) AS non_copper_pct,
    ROUND(purchased_cost / total_unit_cost * 100, 2) AS purchased_pct,
    ROUND(labor_cost     / total_unit_cost * 100, 2) AS labor_pct,
    ROUND(overhead_cost  / total_unit_cost * 100, 2) AS overhead_pct,
    ROUND(scrap_adjustment/total_unit_cost * 100, 2) AS scrap_pct
FROM result_cost_scenario r
JOIN scenario s ON r.scenario_id = s.scenario_id
WHERE s.scenario_name = 'Baseline'
ORDER BY sku_id;