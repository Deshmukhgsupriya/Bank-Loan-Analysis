create database project_1;
use project_1;
select * from finance11_sql;
select * from finance2_sql;

# KPI 1 - Year wise loan amount Status 

select year(issue_d) as Year_of_issue_d  ,
concat(round(sum(loan_amnt) /1000000 , 1), 1, "M") as Total_loan_amount
from finance11_sql
group by Year_of_issue_d 
order by Year_of_issue_d;


# KPI2 - Grade and sub grade wise revol_bal 

select 
grade , sub_grade , 
concat(round(sum(revol_bal)/1000000 , 1),1, "M")  as total_revol_bal
from finance11_sql 
inner join
finance2_sql
on (finance11_sql.id = finance2_sql.id)
group by grade , sub_grade
order by grade , sub_grade;


/* KPI3 - Total Payment for Verified Status Vs Total Payment for Non Verified Status */


select verification_status , 
concat(round(sum(total_pymnt)/1000000 , 2) ,2, "M")as total_payment,
from finance11_sql 
inner join
finance2_sql
on (finance11_sql.id = finance2_sql.id)
group by verification_status
HAVING verification_status IN ('verified', 'not verified');

SELECT 
    verification_status,
    SUM(total_pymnt) AS total_payment
FROM finance11_sql 
inner join
finance2_sql
on (finance11_sql.id = finance2_sql.id)
group by verification_status;

select verification_status , 
round(sum(total_pymnt)/1000000 , 0)  as total_payment
from finance11_sql 
inner join
finance2_sql
on (finance11_sql.id = finance2_sql.id)
group by verification_status
HAVING verification_status IN ('verified', 'not verified');



/* KPI4 - State wise and last_credit_pull_d wise loan status */

select addr_State , loan_status , count(last_Credit_pull_D) as Total_Count
from finance11_sql 
inner join
finance2_sql
on (finance11_sql.id = finance2_sql.id)
group by addr_State ,  loan_status
order by Total_Count;


/* KPI 5 - Home ownership Vs last payment date stats */

SELECT home_ownership,count(last_pymnt_d) AS count_last_pymnt_d
from finance11_sql 
inner join
finance2_sql
on (finance11_sql.id = finance2_sql.id)
GROUP BY home_ownership;


# Total Loan Applications
SELECT COUNT(id) AS Total_Applications FROM finance2_sql;

# Total Funded Amount
SELECT SUM(loan_amnt) AS Total_Funded_Amount FROM finance1_sql;

# Total Amount Received
SELECT SUM(total_pymnt) AS Total_Amount_Collected FROM finance2_sql;

