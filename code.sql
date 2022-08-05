CREATE DATABASE personal_finance_manager /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
use personal_finance_manager;

CREATE TABLE Bank_account (
  AccountNo varchar(20) NOT NULL,
  BankName varchar(45) DEFAULT NULL,
  BranchCode varchar(45) NOT NULL,
  Balance decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (AccountNo,BranchCode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE Expense(
  Exp_type varchar(15) NOT NULL,
  amount decimal(10,2) NOT NULL,
  Exp_date date NOT NULL,
  PRIMARY KEY (Exp_type,Exp_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE Savings(
  Sav_type varchar(15) NOT NULL,
  amount decimal(10,2) NOT NULL,
  Sav_date date NOT NULL,
  PRIMARY KEY (Sav_type,Sav_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE Income (
  Inc_Type varchar(45) NOT NULL,
  Amount decimal(10,2) DEFAULT NULL,
  Credit_Date date NOT NULL,
  PRIMARY KEY (Inc_Type,Credit_Date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create view TotExp as
select sum(amount) as totalExpense, concat(Month(Exp_date),'-',Year(Exp_date)) as Exp_Month
from Expense
group by Exp_date;

create view TotInc as
select sum(amount) as totalIncome, concat(Month(Credit_date),'-',Year(Credit_date)) as Inc_Month
from Income
group by Credit_date;

create view TotSav as 
select sum(amount) as totalSavings, concat(Month(Sav_date),'-',Year(Sav_date)) as Sav_Month
from Savings
group by Sav_date;

create view Net as 
select totalIncome-totalExpense+totalSavings as NetAmount,Exp_Month as Net_Month
From TotInc as T,TotExp as E,TotSav as S
where T.Inc_month=E.Exp_Month and E.Exp_Month=S.Sav_Month;

DELIMITER &&
CREATE PROCEDURE INC_UPDATE(in _Inc_Type varchar(45), in _amount decimal(10,2))
BEGIN
insert into income(Inc_Type,amount,Credit_date)
values
(_Inc_Type, _amount, curdate());
update Bank_account
set balance = balance + _amount
where BankName = 'HDFC';
END &&

DELIMITER &&
CREATE PROCEDURE EXP_UPDATE(in _Exp_Type varchar(45), in _amount decimal(10,2))
BEGIN
insert into expense(Exp_Type,amount,exp_date)
values
(_Exp_Type, _amount, curdate());
update Bank_account
set balance = balance - _amount
where BankName = 'HDFC';
END &&

DELIMITER &&
CREATE PROCEDURE SAV_UPDATE(in _Sav_Type varchar(45), in _amount decimal(10,2))
BEGIN
insert into savings(Sav_Type,amount,Sav_date)
values
(_Sav_Type, _amount, curdate());
update Bank_account
set balance = balance + _amount
where BankName = 'HDFC';
END &&


insert into Bank_account(AccountNo,BankName,BranchCode,Balance) 
values
('379278493915','HDFC','HDFC00A42',125000),
('378439859234','SBI','SBI00A23',75000);

insert into expense(exp_type,amount,exp_date)
values
('Food',8000,'2021-01-01'),
('Food',7000,'2021-02-01'),
('Food',7000,'2021-03-01'),
('Food',7000,'2021-04-01'),
('Food',7000,'2021-05-01'),
('Food',7000,'2021-06-01'),
('Food',7000,'2021-07-01'),
('Food',7000,'2021-08-01'),
('Food',8000,'2021-09-01'),
('Food',8000,'2021-10-01'),
('Food',8000,'2021-11-01'),
('Food',10000,'2021-12-01'),
('Food',10000,'2022-01-01'),
('Food',10000,'2022-02-01'),
('Food',10000,'2022-03-01'),
('Food',10000,'2022-04-01'),
('Food',10000,'2022-05-01'),
('Food',10000,'2022-06-01'),
('Food',10000,'2022-07-01'),
('Food',10000,'2022-08-01'),
('Food',10000,'2022-09-01'),
('Food',10000,'2022-10-01'),
('Food',12000,'2022-11-01'),
('Food',12000,'2022-12-01');

insert into expense(exp_type,amount,exp_date)
values
('Health',1000,'2021-01-01'),
('Health',1000,'2021-02-01'),
('Health',1000,'2021-03-01'),
('Health',1000,'2021-04-01'),
('Health',1000,'2021-05-01'),
('Health',1000,'2021-06-01'),
('Health',1000,'2021-07-01'),
('Health',1000,'2021-08-01'),
('Health',1000,'2021-09-01'),
('Health',1000,'2021-10-01'),
('Health',1000,'2021-11-01'),
('Health',1000,'2021-12-01'),
('Health',3000,'2022-01-01'),
('Health',1500,'2022-02-01'),
('Health',1500,'2022-03-01'),
('Health',1500,'2022-04-01'),
('Health',1500,'2022-05-01'),
('Health',1500,'2022-06-01'),
('Health',1500,'2022-07-01'),
('Health',1500,'2022-08-01'),
('Health',1500,'2022-09-01'),
('Health',1500,'2022-10-01'),
('Health',1500,'2022-11-01'),
('Health',3000,'2022-12-01'),
('Leisure',500,'2021-01-01'),
('Leisure',1500,'2021-02-01'),
('Leisure',500,'2021-03-01'),
('Leisure',1500,'2021-04-01'),
('Leisure',500,'2021-05-01'),
('Leisure',1500,'2021-06-01'),
('Leisure',500,'2021-07-01'),
('Leisure',1500,'2021-08-01'),
('Leisure',4000,'2021-09-01'),
('Leisure',1500,'2021-10-01'),
('Leisure',1500,'2021-11-01'),
('Leisure',1500,'2021-12-01'),
('Leisure',00,'2022-01-01'),
('Leisure',00,'2022-02-01'),
('Leisure',00,'2022-03-01'),
('Leisure',1000,'2022-04-01'),
('Leisure',1000,'2022-05-01'),
('Leisure',1000,'2022-06-01'),
('Leisure',1500,'2022-07-01'),
('Leisure',1500,'2022-08-01'),
('Leisure',1500,'2022-09-01'),
('Leisure',1500,'2022-10-01'),
('Leisure',1500,'2022-11-01'),
('Leisure',1500,'2022-12-01');

insert into expense(exp_type,amount,exp_date)
values
('Shopping',1000,'2021-01-01'),
('Shopping',1000,'2021-02-01'),
('Shopping',1000,'2021-03-01'),
('Shopping',1000,'2021-04-01'),
('Shopping',1000,'2021-05-01'),
('Shopping',1000,'2021-06-01'),
('Shopping',1000,'2021-07-01'),
('Shopping',1000,'2021-08-01'),
('Shopping',2000,'2021-09-01'),
('Shopping',1000,'2021-10-01'),
('Shopping',1000,'2021-11-01'),
('Shopping',1000,'2021-12-01'),
('Shopping',00,'2022-01-01'),
('Shopping',00,'2022-02-01'),
('Shopping',00,'2022-03-01'),
('Shopping',00,'2022-04-01'),
('Shopping',00,'2022-05-01'),
('Shopping',1000,'2022-06-01'),
('Shopping',00,'2022-07-01'),
('Shopping',00,'2022-08-01'),
('Shopping',00,'2022-09-01'),
('Shopping',1000,'2022-10-01'),
('Shopping',1000,'2022-11-01'),
('Shopping',2000,'2022-12-01'),
('EMI',2500,'2021-01-01'),
('EMI',2500,'2021-02-01'),
('EMI',2500,'2021-03-01'),
('EMI',2500,'2021-04-01'),
('EMI',2500,'2021-05-01'),
('EMI',2500,'2021-06-01'),
('EMI',2500,'2021-07-01'),
('EMI',2500,'2021-08-01'),
('EMI',5000,'2021-09-01'),
('EMI',5000,'2021-10-01'),
('EMI',5000,'2021-11-01'),
('EMI',5000,'2021-12-01'),
('EMI',5000,'2022-01-01'),
('EMI',6000,'2022-02-01'),
('EMI',6000,'2022-03-01'),
('EMI',6000,'2022-04-01'),
('EMI',6000,'2022-05-01'),
('EMI',6000,'2022-06-01'),
('EMI',6000,'2022-07-01'),
('EMI',7000,'2022-08-01'),
('EMI',7000,'2022-09-01'),
('EMI',7000,'2022-10-01'),
('EMI',7000,'2022-11-01'),
('EMI',7000,'2022-12-01');

insert into income (inc_type,amount,credit_date)
values
('Salary',30000,'2021-01-01'),
('Salary',30000,'2021-02-01'),
('Salary',30000,'2021-03-01'),
('Salary',30000,'2021-04-01'),
('Salary',30000,'2021-05-01'),
('Salary',30000,'2021-06-01'),
('Salary',30000,'2021-07-01'),
('Salary',30000,'2021-08-01'),
('Salary',35000,'2021-09-01'),
('Salary',35000,'2021-10-01'),
('Salary',35000,'2021-11-01'),
('Salary',35000,'2021-12-01'),
('Salary',35000,'2022-01-01'),
('Salary',35000,'2022-02-01'),
('Salary',35000,'2022-03-01'),
('Salary',35000,'2022-04-01'),
('Salary',35000,'2022-05-01'),
('Salary',35000,'2022-06-01'),
('Salary',35000,'2022-07-01'),
('Salary',35000,'2022-08-01'),
('Salary',35000,'2022-09-01'),
('Salary',35000,'2022-10-01'),
('Salary',35000,'2022-11-01'),
('Salary',35000,'2022-12-01'),
('Source2',1000,'2021-01-01'),
('Source2',1000,'2021-02-01'),
('Source2',1000,'2021-03-01'),
('Source2',1000,'2021-04-01'),
('Source2',1000,'2021-05-01'),
('Source2',1000,'2021-06-01'),
('Source2',1000,'2021-07-01'),
('Source2',1000,'2021-08-01'),
('Source2',1000,'2021-09-01'),
('Source2',1000,'2021-10-01'),
('Source2',1000,'2021-11-01'),
('Source2',1000,'2021-12-01'),
('Source2',1000,'2022-01-01'),
('Source2',4000,'2022-02-01'),
('Source2',4000,'2022-03-01'),
('Source2',4000,'2022-04-01'),
('Source2',4000,'2022-05-01'),
('Source2',4000,'2022-06-01'),
('Source2',4000,'2022-07-01'),
('Source2',4000,'2022-08-01'),
('Source2',4000,'2022-09-01'),
('Source2',4000,'2022-10-01'),
('Source2',4000,'2022-11-01'),
('Source2',4000,'2022-12-01');

insert into Savings(Sav_type,amount,Sav_date)
values
('Emergency Fund',2000,'2021-01-01'),
('Emergency Fund',2000,'2021-02-01'),
('Emergency Fund',2000,'2021-03-01'),
('Emergency Fund',2000,'2021-04-01'),
('Emergency Fund',2000,'2021-05-01'),
('Emergency Fund',2000,'2021-06-01'),
('Emergency Fund',2000,'2021-07-01'),
('Emergency Fund',00,'2021-08-01'),
('Emergency Fund',00,'2021-09-01'),
('Emergency Fund',2000,'2021-10-01'),
('Emergency Fund',2000,'2021-11-01'),
('Emergency Fund',2000,'2021-12-01'),
('Emergency Fund',2000,'2022-01-01'),
('Emergency Fund',2000,'2022-02-01'),
('Emergency Fund',2000,'2022-03-01'),
('Emergency Fund',2000,'2022-04-01'),
('Emergency Fund',2000,'2022-05-01'),
('Emergency Fund',2000,'2022-06-01'),
('Emergency Fund',00,'2022-07-01'),
('Emergency Fund',1000,'2022-08-01'),
('Emergency Fund',00,'2022-09-01'),
('Emergency Fund',1000,'2022-10-01'),
('Emergency Fund',1000,'2022-11-01'),
('Emergency Fund',1000,'2022-12-01'),
('Mutual funds',5000,'2021-01-01'),
('Mutual funds',5000,'2021-02-01'),
('Mutual funds',5000,'2021-03-01'),
('Mutual funds',5000,'2021-04-01'),
('Mutual funds',5000,'2021-05-01'),
('Mutual funds',5000,'2021-06-01'),
('Mutual funds',5000,'2021-07-01'),
('Mutual funds',5000,'2021-08-01'),
('Mutual funds',5000,'2021-09-01'),
('Mutual funds',5000,'2021-10-01'),
('Mutual funds',5000,'2021-11-01'),
('Mutual funds',7000,'2021-12-01'),
('Mutual funds',7000,'2022-01-01'),
('Mutual funds',7000,'2022-02-01'),
('Mutual funds',7000,'2022-03-01'),
('Mutual funds',7000,'2022-04-01'),
('Mutual funds',7000,'2022-05-01'),
('Mutual funds',7000,'2022-06-01'),
('Mutual funds',7000,'2022-07-01'),
('Mutual funds',7000,'2022-08-01'),
('Mutual funds',7000,'2022-09-01'),
('Mutual funds',7000,'2022-10-01'),
('Mutual funds',8000,'2022-11-01'),
('Mutual funds',8000,'2022-12-01');

select balance 
from Bank_account
where BankName = 'HDFC';

select totalExpense, Exp_Month
from totExp 
where Exp_Month = '3-2022';

select totalSavings,Sav_Month
from TotSav 
where Sav_Month = '4-2022';

select concat(Month(Exp_date),'-',Year(Exp_date)) as Exp_Month
from Expense
where Exp_type = 'Food' and amount>=8000;

select totalSavings-totalExpense as NetIn,Sav_month as Month
from totExp, totSav
where Exp_Month= Sav_Month and Sav_month = '3-2022';

select Sav_Month
from totExp,totSav
where Exp_month=Sav_month and totalExpense<=TotalSavings;

call exp_update('Food',6000);
select balance
from Bank_account
where BankName = 'HDFC';

drop table Bank_account;
drop table Expense;
drop table Savings;
drop table Income;
drop database personal_finance_manager;






