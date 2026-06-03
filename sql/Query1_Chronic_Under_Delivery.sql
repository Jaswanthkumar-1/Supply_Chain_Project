USE UK_Supermarket;
SELECT
    Store_ID,
    Category,
    SUM(Deliveries) AS Total_Deliveries,
    SUM(Daily_Sales) AS Total_Sales,
    ROUND(
        (SUM(Deliveries) / SUM(Daily_Sales)) * 100,
        2
    ) AS Delivery_Coverage_Percentage,
    ROUND(
        (
            SUM(
                CASE
                    WHEN Supplier_Status IN ('Delayed', 'Cancelled')
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
        2
    ) AS Failure_Percentage
FROM feature_engineered_supply_data
GROUP BY Store_ID, Category
HAVING
    SUM(Deliveries) < (
        0.5 * SUM(Daily_Sales)
    )
    AND
    (
        SUM(
            CASE
                WHEN Supplier_Status IN ('Delayed', 'Cancelled')
                THEN 1
                ELSE 0
            END
        ) * 100.0
    ) / COUNT(*) > 20;
