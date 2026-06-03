USE UK_Supermarket;
SELECT
    Store_ID,
    COUNT(*) AS Total_Critical_Flags,
    SUM(
        CASE
            WHEN Stock_Status = 'Critical'
            AND Closing_Stock >= 150
            THEN 1
            ELSE 0
        END
    ) AS False_Alarms,
    ROUND(
        (
            SUM(
                CASE
                    WHEN Stock_Status = 'Critical'
                    AND Closing_Stock >= 150
                    THEN 1
                    ELSE 0
                END
            ) * 100.0
        ) / COUNT(*),
        2
    ) AS False_Alarm_Percentage
FROM feature_engineered_supply_data
WHERE Stock_Status = 'Critical'
GROUP BY Store_ID
HAVING False_Alarm_Percentage > 0;
