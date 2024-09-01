create database winform2
go
use winform2
go



create table nganh(
    Ma_nganh char(50) ,
	ten_nganh nvarchar(50) ,
	ghi_chu nvarchar(50) , 
	constraint pk_n primary key (Ma_nganh)
)


insert into nganh
values('01' ,'Cong nghe thong tin 02' , 'nganh nghe 1'),
('02' ,'dien tu - dien lanh' , 'nganh nghe 2'),
('03' ,'Cong nghe thong tin 04' , 'nganh nghe 3'),
('04' ,'Cong nghe thong tin 05' , 'nganh nghe 2'),
('05' ,'Cong nghe thong tin 06' , 'nganh nghe 1')


select * from nganh