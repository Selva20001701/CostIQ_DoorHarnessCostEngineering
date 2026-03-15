SELECT
    r.sku_id,
    s.scenario_name,
    ROUND(b_margin.margin_pct * 100, 4)                          AS baseline_margin_pct,
    ROUND(r.margin_pct * 100, 4)                                 AS scenario_margin_pct,
    ROUND((b_margin.margin_pct - r.margin_pct) * 100, 4)        AS margin_erosion_pct_pts,
    ROUND((b_margin.margin_pct - r.margin_pct) * 10000, 2)      AS margin_erosion_bps,
    CASE
        WHEN (b_margin.margin_pct - r.margin_pct) * 10000 > 10  THEN 'High Erosion'
        WHEN (b_margin.margin_pct - r.margin_pct) * 10000 > 0   THEN 'Low Erosion'
        ELSE 'No Erosion'
    END                                                          AS erosion_flag
FROM result_cost_scenario r
JOIN scenario s
    ON r.scenario_id = s.scenario_id
JOIN result_cost_scenario b_margin
    ON b_margin.sku_id = r.sku_id
JOIN scenario bs
    ON b_margin.scenario_id = bs.scenario_id
    AND bs.scenario_name = 'Baseline'
WHERE s.scenario_name != 'Baseline'
ORDER BY r.sku_id, margin_erosion_bps DESC;