START TRANSACTION;

INSERT INTO etf_trades
(SELECT 
    elem ->> 'symbol' AS symbol,
    elem ->> 'name' AS name,
    (elem ->> 'date')::timestamptz AS date,
    (elem ->> 'open')::numeric AS open,
    (elem ->> 'high')::numeric AS high,
    (elem ->> 'low')::numeric AS low,
    (elem ->> 'close')::numeric AS close,
    (elem ->> 'volume')::numeric AS volume
FROM daily_etf_trades,
     jsonb_array_elements(raw_json -> 'data') AS elem);

INSERT INTO etf_company_info (
SELECT 
  (raw_json ->> 'CIK')::int AS CIK,
  (raw_json ->> 'EPS')::numeric(4, 2) AS EPS,
  (raw_json ->> 'Beta')::numeric(4, 3) AS beta,
  (raw_json -> 'Name')::text AS company_name,
  (raw_json -> 'EBITDA')::text AS EBITDA,
  (raw_json -> 'Sector')::varchar(50) AS sector,
  (raw_json -> 'Symbol')::text AS symbol,
  (raw_json -> 'Address')::varchar(50) AS address,
  (raw_json ->> 'PERatio')::real AS PERatio,
  (raw_json -> 'Currency')::text AS currency,
  (raw_json -> 'Exchange')::text AS exchange,
  (raw_json -> 'Industry')::text AS industry,
  (raw_json ->> 'PEGRatio')::real AS PEGRatio,
  (raw_json ->> '52WeekLow')::real AS year_low,
  (raw_json -> 'AssetType')::text AS asset_type,
  (raw_json ->> 'BookValue')::real AS book_value,
  (raw_json ->> 'ForwardPE')::real AS forward_pe,
  (raw_json ->> '52WeekHigh')::real AS year_high,
  (raw_json ->> 'EVToEBITDA')::text AS ev_to_ebitda,
  (raw_json ->> 'RevenueTTM')::bigint AS revenue_ttm,
  (raw_json ->> 'TrailingPE')::real AS trailing_pe,
  (raw_json -> 'Description')::text AS company_description,
  (raw_json ->> 'EVToRevenue')::real AS ev_to_revenue,
  raw_json ->> 'DividendDate' AS dividend_date,
  (raw_json -> 'OfficialSite')::varchar(55) AS official_site,
  (raw_json ->> 'ProfitMargin')::real AS profit_margin,
  (raw_json ->> 'DilutedEPSTTM')::real AS diluted_epsttm,
  raw_json ->> 'DividenYield' AS dividend_yield,
  (raw_json -> 'FiscalYearEnd')::text AS fiscal_year_end,
  (raw_json ->> 'LatestQuarter')::date AS latest_quarter,
  (raw_json -> 'ExDividendDate')::text AS ex_dividend_date,
  (raw_json ->> 'GrossProfitTTM')::bigint AS gross_profit,
  (raw_json ->> 'AnalystRatingBuy')::int AS analyst_buy,
  raw_json ->> 'DividendPerShare' AS dividend_per_share,
  raw_json ->> 'PriceToBookRatio'AS price_to_book,
  (raw_json ->> 'AnalystRatingHold')::int AS analyst_hold,
  (raw_json ->> 'AnalystRatingSell')::int AS analyst_sell,
  (raw_json ->> 'ReturnOnAssetsTTM')::real AS ROA,
  (raw_json ->> 'ReturnOnEquity')::real AS ROE,
  (raw_json ->> 'SharesOutstanding')::bigint AS shares_outstanding,
  (raw_json ->> '50DayMovingAverage')::real AS fifty_day_moving_avg,
  (raw_json ->> 'AnalystTargetPrice')::real AS target_price,
  (raw_json ->> 'OperatingMarginTTM')::real AS operating_margin,
  (raw_json ->> 'RevenuePerShareTTM')::real AS revenue_per_share,
  (raw_json ->> '200DayMovingAverage')::real AS two_hundred_day_moving_avg,
  (raw_json ->> 'MarketCapitalization')::bigint AS market_cap,
  (raw_json ->> 'PriceToSalesRatioTTM')::real AS price_to_sales_ratio,
  (raw_json ->> 'AnalystRatingStrongBuy')::int AS strong_buy,
  (raw_json ->> 'AnalystRatingStrongSell')::int AS strong_sell,
  (raw_json ->> 'QuarterlyRevenueGrowthYOY')::real AS quarterly_revenue_growth_yoy,
  (raw_json ->> 'QuarterlyEarningsGrowthYOY')::real AS quarterly_earnings_growth_yoy
FROM etf_gen_table); 

COMMIT;
