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


COMMIT;
