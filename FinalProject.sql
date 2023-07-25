use FinalProject;

select * from admintable
drop table admintable
select * from customer
create table Admintable(id int not null,AdminPassword nvarchar(10))
drop table customer

create table Customer(Cusid int identity(1,1) primary key,Cusname nvarchar(30) not null,Cusph bigint not null,Cusaddress nvarchar(40),Cuspassword nvarchar(10) not null);

insert into Customer(Cusname,Cusph,Cusaddress,Cuspassword) values('Anushaya',9874561230,'Ooty','Anu123'),('Anupama',8527419630,'Mettupalayam','Anupama123'),('Boopathi',9626404720,'Coimbatore','Boopathi55'),('Jothika',9626404722,'Tirunelveli','JooBoo55');

insert into admintable values(143,'boopathi55');
select * from Customer
alter table Customer add Cuspassword nvarchar(10);

create table Productdetails(Productid int identity(11,1) primary key,Productname nvarchar(40) not null,Producttype nvarchar(40) not null,quantity int not null, Costperquantity money not null);



insert into Productdetails(Productname,Producttype,quantity,Costperquantity) values('Tomato','Vegetables',10,15),('LG Washing Machine','Appliances',15,35000),('LG TV','Appliances',5,20000),('Books','Stationary',12,150),('Jeans Wear','Dress',1,950),('Potato','Vegetables',20,25),('Carrot','Vegetables',22,50),('Badam','Nuts',25,500),('HP Reyzen 5','Laptop',10,55000),('HP Probook','Laptop',12,69000);

select * from Productdetails


insert into Productdetails(Productname,Producttype,quantity,Costperquantity) values('Shirts','Dress',14,650),('US Polo Size - 8','Shoes',2,1550),('Bata Size - 8','Footwear',5,350);

create table Orderdetails(Orderid int primary key identity(2000,1),Dateofpurchase date not null,Cusid int foreign key references Customer,Productid int foreign key references Productdetails);

drop table Productdetails

select * from Productdetails

select * from Orderdetails

drop table Orderdetails

select Productname as 'Available Products',Costperquantity as 'Cost Per Quantity' from Productdetails where Producttype='Vegetables';

insert into Orderdetails(Dateofpurchase,Cusid,Productid) values('2023-01-01',1,12),('2023-02-01',2,11),('2023-02-02',1,15),('2023-02-03',1,19),('2023-02-05',4,21),('2023-02-05',4,17),('2023-02-10',3,14),('2023-03-05',1,19);

select Sum(Costperquantity) as 'Total Amount' from Productdetails full outer join Orderdetails on Orderdetails.Cusid=1;

