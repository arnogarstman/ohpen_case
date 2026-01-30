SELECT
    id,
    account_id,
    amount,
    new_balance,
    tx_date
from {{ source('raw', 'transactions') }}