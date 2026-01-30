{{ 
  config(
    materialized = 'table',
    schema = 'processed',
    cluster_by = ["tx_date"]
  ) 
}}

SELECT
    id,
    account_id,
    amount,
    new_balance,
    tx_date,
    TO_CHAR(tx_date, 'YYYY-MM') as tx_year_month
FROM {{ ref('stg_transactions') }}
