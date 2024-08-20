
-- DWH_Fact_Employees_Performance

select conversion_rates as EUR_conversion_rate, 
       [time_last_update_utc] as date,
       CAST(CONVERT(DATE, TRIM(SUBSTRING([time_last_update_utc],(CHARINDEX(',', [time_last_update_utc])+1),((select len([time_last_update_utc]))-(SELECT CHARINDEX('00', [time_last_update_utc]))))), 113) AS DATE) as date
from [ODS_Exchange_Rate]
where index1 = 'EUR'
;



SELECT 

	-- select employee, date, sum sales 
    SD.EmployeeID,
    SD.OrderDate,
    SD.USDTotalSales,
    SD.EURTotalSales,
	SD.UnqCountProducts,

    -- cumulative sum sales
    SUM(SD.USDTotalSales) OVER (PARTITION BY SD.EmployeeID ORDER BY SD.OrderDate) AS CumulativeUSDTotalSales,

    -- cumulative avg sum sales
    AVG(SD.USDTotalSales) OVER (
        PARTITION BY SD.EmployeeID 
        ORDER BY SD.OrderDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS MovingAverageUSDSales,

    -- Rank of Employees by Total Sales per Day
    RANK() OVER (
        PARTITION BY SD.OrderDate 
        ORDER BY SD.USDTotalSales DESC
    ) AS DailySalesRank

FROM
(
    -- group by employee, date --> sum sales
    SELECT 
        O.EmployeeID,
        CONVERT(DATE, O.OrderDate) AS OrderDate,
        SUM(OD.Quantity * OD.UnitPrice_USD) AS USDTotalSales,
        isnull(SUM(OD.Quantity * OD.UnitPrice_USD * e.conversion_rates),-1) AS EURTotalSales,
		count(distinct ProductID) as UnqCountProducts
    FROM 
        Orders O
    LEFT JOIN 
        [Order Details] OD ON O.OrderID = OD.OrderID
	LEFT JOIN 
		[ODS_Exchange_Rate] e 
			ON CAST(CONVERT(DATE, TRIM(SUBSTRING([time_last_update_utc],(CHARINDEX(',', [time_last_update_utc])+1),((select len([time_last_update_utc]))-(SELECT CHARINDEX('00', [time_last_update_utc]))))), 113) AS DATE) = CONVERT(DATE, O.OrderDate)
			AND index1 = 'EUR'
    GROUP BY 
        O.EmployeeID, O.OrderDate
) SD
	
order by EmployeeID, OrderDate
;






