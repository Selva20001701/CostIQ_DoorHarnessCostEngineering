SELECT sku_id, item_type,
       COUNT(*) as line_count,
       ROUND(SUM(qty * unit_cost)::numeric, 4) as total_cost
FROM bom_line
GROUP BY sku_id, item_type
ORDER BY sku_id, item_type;