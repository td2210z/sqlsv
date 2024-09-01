create database hs
go
use hs
go


create table lop(
    ma int identity ,
	ten_lop nvarchar(50) not null unique,
	constraint pk_lop primary key (ma)
)

insert into lop(ten_lop)
values('LT') , ('ATTT') , ('haker mu trang')


create table sinhvien(
     ma int identity,
	 ten nvarchar(50) not null ,
	 gioi_tinh bit not null  default 0,
	 ma_lop int , 
	 constraint pk_sinhvien primary key (ma),
	 constraint fk_sinhvien foreign key (ma_lop) references lop(ma)
)

insert into sinhvien(ten , gioi_tinh , ma_lop)
values('Long' , default , 1) , ('Tuan' , 1 ,1) ,('Tuan hacker' , 1 , 2)
insert into sinhvien(ten)
values('Phong')


select * from sinhvien
join lop on sinhvien.ma_lop = lop.ma



select * from sinhvien
left join lop on lop.ma = sinhvien.ma_lop
where sinhvien.ma_lop is null


-- dem so luong sinh vien co mon hoc la 'ATTT'

select lop.ma , count(*)  as so_sinh_vien from sinhvien
inner join lop 
on lop.ma = sinhvien.ma_lop
group by lop.ma