SELECT s.sku_id, s.sku_name, s.variant, cp.price_per_unit, cp.currency
FROM sku s
JOIN customer_price cp ON s.sku_id = cp.sku_id;