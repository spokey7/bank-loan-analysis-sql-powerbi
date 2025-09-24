Create database Bank_loan_DB;

use Bank_loan_DB;

select * from financial_loan;

desc financial_loan;

ALTER TABLE financial_loan
ADD issue_date1 DATE;

UPDATE financial_loan
SET issue_date1 = STR_TO_DATE(issue_date, '%d-%m-%Y');

ALTER TABLE financial_loan
DROP COLUMN issue_date;

ALTER TABLE financial_loan
CHANGE old_issue issue_date DATE;

alter table financial_loan modify issue_date date;
# KPI's
# 1)Total loan applications
select count(id) as total_loan_applications from financial_loan;

# Month to date
select count(id) as MTD_total_loan_applications from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;

#2)Total loan amount
select sum(loan_amount) as total_loan_amount from financial_loan;

# Total loan amount MOD
select sum(loan_amount) as MTD_total_loan_amount from financial_loan
where Month(issue_date) = 12;

#3)Total amount recived
select sum(total_payment) as Total_amount_recived from financial_loan;
# total amount recevid MTD
select sum(total_payment) as MTD_total_loan_amount from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;

# 4)Average intreset rate

select round(avg(int_rate)*100,2) as AVG_intrest_rate from financial_loan;

# MTD Average intrest rate
select round(avg(int_rate)*100,2) as MTD_AVG_intrest_rate from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;

# privious month average
select round(avg(int_rate)*100,2) as PMTD_AVG_intrest_rate from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021;

#5) Average Depth_to_income_ratio
select round(Avg(dti) * 100,2) as AVG_DTI from financial_loan;

# MTD Average DTI-ration
select round(avg(dti)*100,2) as MTD_AVG_DTI from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;

# PMTD Average of DTI
select round(avg(dti)*100,2) as PMTD_AVG_DTI from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021;

select * from financial_loan;

#6) Good loan VS Bad loan KPi'savepoint
# Good loan application Percetage
select round((count(case when loan_status = "Current" or loan_status = "Fully Paid" Then id End) * 100)
/
count(id),0) as Good_loan_percentage
from financial_loan;

# Good loan application
select count(id) as good_loan_applications from financial_loan where 
loan_status = "Current" or loan_status = "Fully Paid";

# Good loan Funded Amount
select sum(loan_amount) as good_loan_Funded_Amount from financial_loan where 
loan_status = "Current" or loan_status = "Fully Paid"; 

# Good loan Recived amount
select sum(total_payment) as good_loan_Recived_amount from financial_loan where 
loan_status = "Current" or loan_status = "Fully Paid"; 
select * from financial_loan;
# Bad loan application Percetage
select round((count(case when loan_status = "Charged Off" Then id End) * 100)
/
count(id),0) as Bad_loan_percentage
from financial_loan;

# Good loan application
select count(id) as Bad_loan_applications from financial_loan where 
loan_status = "Charged Off";

# Good loan Funded Amount
select sum(loan_amount) as Bad_loan_Funded_Amount from financial_loan where 
loan_status = "Charged Off"; 

# Good loan Recived amount
select sum(total_payment) as Bad_loan_Recived_amount from financial_loan where 
loan_status = "Charged Off"; 

# Loan Status

select
loan_Status,
count(id) as total_applications,
sum(total_payment) as total_payment_recived,
sum(loan_amount) as total_Funded_amount,
Avg(int_rate * 100) as Interest_rate,
Avg(dti * 100) as DTI
from financial_loan
group by loan_Status;

# MTD loan_status
select
loan_status,
sum(loan_amount) as MTD_Total_Amount_recived,
sum(total_payment) as MTD_total_Funded_Amount
from financial_loan
where month(issue_date) = 12
group by loan_status

