create database trig
go
use trig
go



create table lop(
    ma int identity , 
	ten nvarchar(50) ,
	so_luong_sv int default 0,

	constraint pk_lop primary key (ma)
)



create table sv(
    masv int identity,
	ten_lop nvarchar(50), 
	ma_lop int ,
	constraint pk_sv primary key (masv) , 
	constraint fk_sv foreign key (ma_lop) references lop(ma)
)

insert into lop(ten)
values('sql'),('web')

insert into sv
values('thang' , 1)


select * from lop
select * from sv
delete from sv

create or alter trigger tg_them_sinh_vien
on sv
after insert 
as
begin
    
	declare @ma_lop int = (select ma_lop from inserted)
	update lop
	set
	so_luong_sv = so_luong_sv + 1
	where ma = @ma_lop

	select * from lop
end



insert into sv
values('thang' , 1)
