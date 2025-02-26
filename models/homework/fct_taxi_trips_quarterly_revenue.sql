{{
    config(
        materialized="view"
    )
}}

WITH quarterly_agg as(
    select
        quarter,
        year,
        service_type,
        SUM(total_amount) as quarterly_revenue
    from
        {{ ref('fact_trips_dim') }}
    where year in (2020,2019)
    group by
        quarter,
        year,
        service_type
    order by
        year,
        quarter
),
current_year AS (
    SELECT
        quarter,
        service_type,
        quarterly_revenue AS current_rev
    FROM quarterly_agg
    WHERE year = 2020
),
previous_year AS (
    SELECT
        quarter,
        service_type,
        quarterly_revenue AS previous_rev
    FROM quarterly_agg
    WHERE year = 2019
)

SELECT
    c.quarter AS Quarter,
    c.service_type AS ServiceType,
    ROUND(
        ((c.current_rev - p.previous_rev) / p.previous_rev) * 100,
        2
    ) AS YoYGrowth 
FROM current_year c
JOIN previous_year p
    ON c.quarter = p.quarter
    AND c.service_type = p.service_type
ORDER BY c.quarter, c.service_type

