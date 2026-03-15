SELECT
    sku_id,
    ROUND(MIN(margin_pct) * 100, 2) AS worst_margin_pct,
    ROUND(MAX(margin_pct) * 100, 2) AS best_margin_pct,
    ROUND(AVG(margin_pct) * 100, 2) AS avg_margin_pct,
    SUM(CASE WHEN margin_flag = true THEN 1 ELSE 0 END) AS breach_count
FROM result_cost_scenario
GROUP BY sku_id
ORDER BY worst_margin_pct ASC;