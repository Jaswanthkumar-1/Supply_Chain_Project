USE UK_Supermarket;

SELECT
    Date,
    Store_ID,
    Region,
    Daily_Sales,
    Supplier_Status
FROM feature_engineered_supply_data f1
WHERE Supplier_Status = 'Cancelled'
AND Daily_Sales >
(
    SELECT AVG(f2.Daily_Sales)
    FROM feature_engineered_supply_data f2
    WHERE f2.Region = f1.Region
);
