USE UK_Supermarket;

SELECT
    Region,

    ROUND(
        AVG(
            CASE
                WHEN Supplier_Status = 'On-Time'
                THEN Closing_Stock
            END
        ),
        2
    ) AS Avg_OnTime_Stock,

    ROUND(
        AVG(
            CASE
                WHEN Supplier_Status = 'Delayed'
                THEN Closing_Stock
            END
        ),
        2
    ) AS Avg_Delayed_Stock,

    ROUND(
        AVG(
            CASE
                WHEN Supplier_Status = 'On-Time'
                THEN Closing_Stock
            END
        )
        -
        AVG(
            CASE
                WHEN Supplier_Status = 'Delayed'
                THEN Closing_Stock
            END
        ),
        2
    ) AS Stock_Drop

FROM feature_engineered_supply_data

GROUP BY Region

HAVING Stock_Drop > 20;