WITH opensea_volume AS (
    SELECT
        DATE_TRUNC('day', timestamp) AS day,
        SUM(eth_price) AS opensea_volume_eth
    FROM ethereum.nft_sales
    WHERE timestamp >= '2023-02-10'
    AND exchange_name = 'opensea'
    GROUP BY 1
),
blur_volume AS (
    SELECT
        DATE_TRUNC('day', timestamp) AS day,
        SUM(eth_price) AS blur_volume_eth
    FROM ethereum.nft_sales
    WHERE timestamp >= '2023-02-10'
    AND exchange_name = 'blur'
    GROUP BY 1
),
x2y2_volume AS (
    SELECT
        DATE_TRUNC('day', timestamp) AS day,
        SUM(eth_price) AS x2y2_volume_eth
    FROM ethereum.nft_sales
    WHERE timestamp >='2023-02-10'
    AND exchange_name = 'x2y2'
    GROUP BY 1
),
sudoswap_volume AS (
    SELECT
        DATE_TRUNC('day', timestamp) AS day,
        SUM(eth_price) AS sudoswap_volume
    FROM ethereum.nft_sales
    WHERE timestamp >= '2023-02-10'
    AND exchange_name = 'sudoswap'
    GROUP BY 1
)
SELECT * FROM opensea_volume
LEFT JOIN blur_volume on blur_volume.day = opensea_volume.day
LEFT JOIN x2y2_volume on x2y2_volume.day = blur_volume.day
LEFT JOIN sudoswap_volume on sudoswap_volume.day = x2y2_volume.day
ORDER BY 1 DESC

