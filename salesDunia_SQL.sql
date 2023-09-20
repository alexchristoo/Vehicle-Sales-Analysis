select *from salesdunia_csv;

select distinct status
from salesdunia_csv;

select distinct YEAR_ID
from salesdunia_csv;

select distinct PRODUCTLINE
from salesdunia_csv;

select distinct COUNTRY
from salesdunia_csv;

select distinct DEALSIZE
from salesdunia_csv;

select distinct TERRITORY
from salesdunia_csv;

select distinct MONTH_ID
from salesdunia_csv
where YEAR_ID = 2003;

select distinct MONTH_ID
from salesdunia_csv
where YEAR_ID = 2005;

-- cek duplicate values
select ORDERNUMBER,PRODUCTCODE, count(*) as count
from salesdunia_csv
group by 1,2
having count>1;

-- grouping sales by productline,year,dealsize
select PRODUCTLINE, sum(SALES)
from salesdunia_csv
group by 1;

select YEAR_ID, sum(SALES)
from salesdunia_csv
group by 1;

select DEALSIZE, sum(SALES)
from salesdunia_csv
group by 1;

-- What was the best month for sales in a specific year? How much was earned that month? 
select sum(SALES) as revenues,MONTH_ID,count(ORDERNUMBER) as frekuensi
from salesdunia_csv
where YEAR_ID = 2004
group by 2 
order by 2;

-- November seems to be the month, what product do they sell in November, Classic I believe
select PRODUCTLINE, sum(sales) , count(ORDERNUMBER) as frekuensi, YEAR_ID
from salesdunia_csv
where YEAR_ID = 2003 and MONTH_ID = 11
group by 1; 

select CUSTOMERNAME, count(ORDERNUMBER) as frekuensi
from salesdunia_csv
group by 1
order by 2 desc limit 10;

-- select ORDERNUMBER, PRODUCTLINE, SALES
-- from salesdunia_csv
-- where ORDERNUMBER = 10328;

select ORDERNUMBER ,count(ORDERNUMBER) as banyak 
	from salesdunia_csv
	group by ORDERNUMBER;
    
-- What products are most often sold together? (by productcode)
select ORDERNUMBER, PRODUCTCODE
from salesdunia_csv b
where ORDERNUMBER in(
	select ORDERNUMBER from(
		select ORDERNUMBER ,count(ORDERNUMBER) as banyak 
		from salesdunia_csv
		where STATUS = 'shipped'
		group by ORDERNUMBER
	)a
	 where banyak = 3
);

-- What products are most often sold together? (by productline)
select ORDERNUMBER, PRODUCTLINE
from salesdunia_csv b
where ORDERNUMBER in(
	select ORDERNUMBER from(
		select ORDERNUMBER ,count(ORDERNUMBER) as banyak 
		from salesdunia_csv
		where STATUS = 'shipped'
		group by ORDERNUMBER
	)a
	 where banyak = 2
);

-- What city has the highest number of sales in a specific country
select city, sum(sales) as Total_Penjualan
from salesdunia_csv
where country = 'France'
group by city
order by 2 desc;

-- What is the best 5 product in a specific country?(berdasarkan sering pembelian)
select PRODUCTCODE, count(PRODUCTCODE), PRODUCTLINE, country
from salesdunia_csv
where COUNTRY = 'USA'
group by PRODUCTCODE, PRODUCTLINE
order by 2 desc limit 5;

-- What is the best 5 product in a specific country?(berdasarkan jumlah revenue sales)
select productcode, sum(SALES),  PRODUCTLINE, country
from salesdunia_csv
where COUNTRY = 'France'
group by PRODUCTCODE, PRODUCTLINE
order by 2 desc limit 5;



