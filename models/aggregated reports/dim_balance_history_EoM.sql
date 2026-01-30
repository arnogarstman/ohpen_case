{{ 
  config(
    materialized = 'table',
    schema = 'processed'
  ) 
}}

WITH ranked AS (
    SELECT
        account_id,
        amount,
        new_balance,
        tx_date,
        tx_year_month,
        ROW_NUMBER() OVER (
            PARTITION BY account_id,tx_year_month
            ORDER BY tx_date DESC
        ) AS rn
    FROM {{ ref('fct_transactions') }}
)

SELECT
    account_id,
    tx_year_month,
    new_balance AS balance
FROM ranked
WHERE rn = 1