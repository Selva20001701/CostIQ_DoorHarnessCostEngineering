SELECT rc.default_as_of_month, rc.default_index_name,
       mi.price_per_kg
FROM run_config rc
JOIN market_index mi 
  ON mi.as_of_month = rc.default_as_of_month
  AND mi.index_name = rc.default_index_name;