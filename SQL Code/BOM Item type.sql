SELECT DISTINCT item_type, COUNT(*) as line_count
FROM bom_line
GROUP BY item_type;