--Q1
create view vw_sales_analysis as
 select s.* , 
 c.Customer  ,
 c.[Bill To Customer]  ,
 c.Category ,
 c.[Buying Group],
 st.[Stock Item],
 st.Brand,
 st.Color,
 st.Size,
 st.[Selling Package],
 ct.City,
 ct.[State Province],
 ct.Country,
 ct.Continent,
 ct.[Sales Territory],
 ct.Region,
 ct.Subregion,
 e.Employee AS Salesperson
from Fact.Sale as s
left join Dimension.Customer as c on
c.[Customer Key] = s.[Customer Key]
left join [Dimension].[Stock Item] as st
on st.[Stock Item Key] = s.[Stock Item Key]
left join Dimension.City as ct 
on ct.[City Key] = s.[City Key]
left join Dimension.Employee e
    on s.[Salesperson Key] = e.[Employee Key];

select * from vw_sales_analysis

--Q2

create View vw_Order_Delivery_Analysis as
select o.*,
       ct.City,
       ct.[State Province],
       ct.Country,
       ct.Continent,
       ct.[Sales Territory],
       ct.Region,
       ct.Subregion,
       c.Customer,
       c.[Bill To Customer],
       c.[Buying Group],
       c.Category,
       st.[Stock Item],
       st.Brand,
       st.Color,
       st.Size,
       st.[Selling Package],
       e.Employee as [Salesperson Name],
       e.[Preferred Name] as [Salesperson Preferred Name],
       ep.Employee as [Picker Name],
       ep.[Preferred Name] as [Picker Preferred Name]
from [Fact].[Order] as o
left join [Dimension].[Customer] as c
on o.[Customer Key] = c.[Customer Key]
left join [Dimension].[Stock Item] as st
on st.[Stock Item Key]=o.[Stock Item Key]
left join [Dimension].[City] as ct 
on ct.[City Key] = o.[City Key] 
left join [Dimension].[Employee] as e
on e.[Employee Key] = o.[Salesperson Key] 
left join [Dimension].[Employee] AS ep 
on o.[Picker Key] = ep.[Employee Key];
select * from vw_Order_Delivery_Analysis

--Q3 
create view vw_Product_Inventory_Analysis as
select
    s.*,
    st_holding.[Quantity On Hand],
    st_holding.[Bin Location],
    st_holding.[Last Stocktake Quantity],
    st_holding.[Last Cost Price],
    st_holding.[Reorder Level],
    st_holding.[Target Stock Level]
from [Dimension].[Stock Item] as s
left join [Fact].[Stock Holding] as st_holding
on s.[Stock Item Key] = st_holding.[Stock Item Key]

select * from vw_Product_Inventory_Analysis

--Q4

create view vw_Purchase_Supplier_Analysis as
select 
   p.*,
   sp.Supplier,
   sp.Category as [Supplier Category],
   sp.[Primary Contact],
   sp.[Supplier Reference],
   sp.[Payment Days],
   s.[Stock Item],
   s.Brand,
   s.Color,
   s.Size,
   s.[Buying Package],
   s.[Selling Package]
  
from [Fact].[Purchase] as p
left join [Dimension].[Supplier] as sp
on p.[Supplier Key] = sp.[Supplier Key]
left join [Dimension].[Stock Item] as s
on s.[Stock Item Key] = p.[Stock Item Key]

select * from vw_Purchase_Supplier_Analysis

--Q5
create view vw_Stock_Movement_Analysis as
select
    m.*,
    st.[Stock Item],
    st.Brand,
    c.Customer,
    sup.Supplier,
    t.[Transaction Type]
from Fact.Movement m
left join Dimension.[Stock Item] st
    ON m.[Stock Item Key] = st.[Stock Item Key]
left join Dimension.Customer c
    ON m.[Customer Key] = c.[Customer Key]
left join Dimension.Supplier sup
    ON m.[Supplier Key] = sup.[Supplier Key]
left join Dimension.[Transaction Type] t
    ON m.[Transaction Type Key] = t.[Transaction Type Key];

-- Q6

create view vw_Financial_Transaction_Analysis as
select
    t.*,
    c.Customer,
    bc.Customer as [Bill To Customer],
    sup.Supplier,
    tt.[Transaction Type],
    pm.[Payment Method]
from Fact.[Transaction] t
left join Dimension.Customer c
    on t.[Customer Key] = c.[Customer Key]
left join  Dimension.Customer bc
    on t.[Bill To Customer Key] = bc.[Customer Key]
left join  Dimension.Supplier sup
    on t.[Supplier Key] = sup.[Supplier Key]
left join  Dimension.[Transaction Type] tt
    on t.[Transaction Type Key] = tt.[Transaction Type Key]
left join    Dimension.[Payment Method] pm
    on t.[Payment Method Key] = pm.[Payment Method Key];

SELECT TOP 50 *
FROM Fact.[Transaction];
SELECT
    tt.[Transaction Type],
    COUNT(*) AS Transaction_Count,
    MIN(t.[Total Including Tax]) AS Min_Amount,
    MAX(t.[Total Including Tax]) AS Max_Amount,
    SUM(t.[Total Including Tax]) AS Total_Amount
FROM Fact.[Transaction] t
LEFT JOIN Dimension.[Transaction Type] tt
    ON t.[Transaction Type Key] = tt.[Transaction Type Key]
GROUP BY tt.[Transaction Type]
ORDER BY tt.[Transaction Type];
SELECT
    tt.[Transaction Type],
    COUNT(*) AS Transaction_Count,
    MIN(t.[Total Including Tax]) AS Min_Amount,
    MAX(t.[Total Including Tax]) AS Max_Amount,
    SUM(t.[Total Including Tax]) AS Total_Amount
FROM Fact.[Transaction] t
LEFT JOIN Dimension.[Transaction Type] tt
    ON t.[Transaction Type Key] = tt.[Transaction Type Key]
GROUP BY tt.[Transaction Type]
ORDER BY tt.[Transaction Type];