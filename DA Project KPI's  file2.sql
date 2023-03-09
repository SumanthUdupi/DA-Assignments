Create database Project;
# Q. 1  MMBtu_TOTAL for Ethane & Ethanol 
select FUEL_TYPE,round(sum(  MMBtu_TOTAL),2) As MMBtu_TOTAL
from data1
 where FUEL_TYPE in('Ethane','Ethanol (100%)')
 Group by FUEL_TYPE;

# Q. 2 Process Heating for 3M Company Facility
select FACILITY_NAME,round(sum(Process_Heating),1) As Process_Heating_Total
from data1 inner join data2
on data1.PRIMARY_NAICS_CODE=data2.PRIMARY_NAICS_CODE
where FACILITY_NAME=('3M COMPANY');

# Q. 3 Unit Name trend (1950-2020) Vs GWht_TOTAL
select data1.UNIT_NAME,data2.GWht_TOTAL
from data1 inner join data2
on data1.PRIMARY_NAICS_CODE=data2.PRIMARY_NAICS_CODE
where  UNIT_NAME in('Aug-50',
'Aug-50','Apr-81', 'May-81', 'Jun-81', 'Jun-97', 'Dec-90', '09-Jan', '21-Jan','01-Feb', '07-Jun',
'05-Aug','05-Aug','05-Aug','05-Aug','05-Aug','05-Aug','05-Aug','05-Aug','01-Sep')
order by UNIT_NAME;

#OR
select UNIT_NAME, GWht_TOTAL
from data1
where UNIT_NAME in ('Aug-50','Aug-50','Apr-81', 'May-81', 'Jun-81', 'Jun-97', 'Dec-90', '09-Jan', '21-Jan',
'01-Feb', '07-Jun','05-Aug','05-Aug','05-Aug','05-Aug','05-Aug','05-Aug','05-Aug','05-Aug','01-Sep');



# Q. 4 % Share of Direct Uses-Total Nonprocess for each MECS_Region
select sum(p.Direct_Uses_Total_Nonprocess),f.MECS_Region,
(sum(Direct_Uses_Total_Nonprocess)*100)/sum(sum(Direct_Uses_Total_Nonprocess))over()as Percentage_Total
FROM data2 as p left join data1 as f on p.PRIMARY_NAICS_CODE=f.PRIMARY_NAICS_CODE
group by MECS_Region;


#Q. 5 County wise Conventional Boiler Use Stats
select COUNTY,sum(Conventional_Boiler_Use) As SUM_Conventional_Boiler_Use,
(avg(Conventional_Boiler_Use))As Average, 
(Var_SAMP(Conventional_Boiler_Use)) As Variance,
stddev(Conventional_Boiler_Use) As Standard_deviation,
 min(Conventional_Boiler_Use) As Minimum, 
max(Conventional_Boiler_Use) As Maximum
from data1 inner join data2
on data1.PRIMARY_NAICS_CODE=data2.PRIMARY_NAICS_CODE
Group by COUNTY;

