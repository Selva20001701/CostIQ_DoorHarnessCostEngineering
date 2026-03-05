-- Postgres schema (v2)
CREATE TABLE IF NOT EXISTS sku (
  sku_id TEXT PRIMARY KEY,
  sku_name TEXT NOT NULL,
  variant TEXT NOT NULL,
  program TEXT,
  platform TEXT,
  oem_region TEXT,
  start_month TEXT,
  end_month TEXT
);

CREATE TABLE IF NOT EXISTS assumption (
  assumption_id TEXT PRIMARY KEY,
  sku_id TEXT REFERENCES sku(sku_id),
  scrap_rate NUMERIC NOT NULL,
  labor_minutes NUMERIC NOT NULL,
  labor_rate_per_hour NUMERIC NOT NULL,
  productivity_factor NUMERIC NOT NULL,
  overhead_rate NUMERIC NOT NULL,
  copper_weight_kg NUMERIC NOT NULL,
  margin_floor NUMERIC NOT NULL
);

CREATE TABLE IF NOT EXISTS bom_line (
  bom_id TEXT PRIMARY KEY,
  sku_id TEXT REFERENCES sku(sku_id),
  item_type TEXT CHECK (item_type IN ('non_copper','purchased')) NOT NULL,
  item_name TEXT NOT NULL,
  qty NUMERIC NOT NULL,
  uom TEXT NOT NULL,
  unit_cost NUMERIC NOT NULL
);

CREATE TABLE IF NOT EXISTS market_index (
  index_name TEXT NOT NULL,
  as_of_month TEXT NOT NULL,
  price_per_kg NUMERIC NOT NULL,
  PRIMARY KEY (index_name, as_of_month)
);

CREATE TABLE IF NOT EXISTS scenario (
  scenario_id INTEGER PRIMARY KEY,
  scenario_name TEXT NOT NULL,
  copper_delta_pct NUMERIC NOT NULL,
  labor_delta_pct NUMERIC NOT NULL,
  purchased_delta_pct NUMERIC NOT NULL,
  overhead_delta_pct NUMERIC NOT NULL
);

CREATE TABLE IF NOT EXISTS customer_price (
  sku_id TEXT PRIMARY KEY REFERENCES sku(sku_id),
  currency TEXT NOT NULL,
  price_per_unit NUMERIC NOT NULL
);

CREATE TABLE IF NOT EXISTS run_config (
  default_as_of_month TEXT NOT NULL,
  default_index_name TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE IF NOT EXISTS demand_actual_monthly (
  sku_id TEXT REFERENCES sku(sku_id),
  month TEXT NOT NULL,
  actual_volume INTEGER NOT NULL,
  PRIMARY KEY (sku_id, month)
);

CREATE TABLE IF NOT EXISTS demand_forecast_rolling (
  sku_id TEXT REFERENCES sku(sku_id),
  target_month TEXT NOT NULL,
  issue_month TEXT NOT NULL,
  revision INTEGER NOT NULL,
  forecast_volume INTEGER NOT NULL,
  PRIMARY KEY (sku_id, target_month, issue_month, revision)
);

CREATE TABLE IF NOT EXISTS result_cost_scenario (
  result_id BIGSERIAL PRIMARY KEY,
  sku_id TEXT REFERENCES sku(sku_id),
  scenario_id INTEGER REFERENCES scenario(scenario_id),
  as_of_month TEXT NOT NULL,
  run_timestamp TIMESTAMP NOT NULL DEFAULT NOW(),
  copper_cost NUMERIC NOT NULL,
  labor_cost NUMERIC NOT NULL,
  non_copper_cost NUMERIC NOT NULL,
  purchased_cost NUMERIC NOT NULL,
  overhead_cost NUMERIC NOT NULL,
  scrap_adjustment NUMERIC NOT NULL,
  total_unit_cost NUMERIC NOT NULL,
  price_per_unit NUMERIC,
  margin_pct NUMERIC,
  margin_floor NUMERIC NOT NULL,
  margin_flag BOOLEAN NOT NULL
);
