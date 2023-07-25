use adoassessment;

create table Members(Cus_id int Primary Key,Cus_name nvarchar(25)Not null,Date_of_Joining date not null, Points int Default 0);

create table Menu(Product_id int Primary Key,Product_name nvarchar(25) not null,Price int not null);

create table Sales(Invoice_no int primary key,Cus_id int Foreign Key references Members(Cus_id),Product_id int foreign key references Menu(Product_id),Date_of_purchase date not null, TotalAmount int not null);

insert into Members Values(100,'Abi','2022/10/05',0),(101,'Anu','2022/05/11',0),(102,'Abinaya','2023/01/01',0),(103,'Akshaya','2023/02/06',0),(104,'Jothika','2023/04/05',0);

insert into Menu values(10,'Chicken Briyani',110), (11,'Mutton Briyani',150), (12,'French Fries',50), (13,'Noodles',70), (40,'Fried Rice',80);

insert into Sales Values(1000,100,10,'2022/10/10',110), (1001,101,10,'2022/10/12',110), (1002,103,13,'2022/11/05',70), (1003,104,10,'2022/11/11',110), (1004,102,11,'2022/11/15',150), (1005,100,40,'2023/01/01',80);

select * from Members;

select * from Menu;

select * from Sales;

select Cus_name, SUM(TotalAmount) as 'Total Amount Spend' from Members join Sales on Members.Cus_id=Sales.Cus_id group by Cus_name;

select Cus_name, count(Invoice_no) as 'Days Visited' from Sales join Members on Members.Cus_id=Sales.Cus_id group by Cus_name;

select Top 1 Product_name,Sum(TotalAmount) as 'Top Sale' from Sales join Menu on Menu.Product_id=Sales.Product_id group by Product_name ;

select Cus_name, COUNT(Invoice_no) as 'Total Items', SUM(TotalAmount) as 'Total Amount' FROM Members JOIN Sales ON Members.Cus_id = Sales.Cus_id group by Cus_name;

select Cus_name, Sum(TotalAmount *10) as 'Total Earned Points' from Sales join Members on Sales.Cus_id=Members.Cus_id group by Cus_name; 

