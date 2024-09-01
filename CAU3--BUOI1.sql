create database qlbh2
go
use qlbh2
go

--drop table hoadon
create table hoadon(
    mahd char(10),
	makhach char(10),
	ngaydat date default getdate(),
	ngaynhan date,
	constraint pk_hd1 primary key (mahd)
)

create table hanghoa(
      mahang char(10),
	  tenhang nvarchar(50) ,
	  dongia numeric(18,2),
	  dvt nchar(15),
	  constraint pk_hh1 primary key (mahang)
)

create table khachhang(
     makhach char(10) ,
	 tenkhach nvarchar(50),
	 diachi nvarchar(50),
	 dienthoai char(15) unique,
	 gioitinh bit,
	 constraint pk_kh1 primary key (makhach)
)

create table hoadonct(
    mahd char(10),
	mahang char(10),
	soluong int,
	constraint fk_hdd foreign key (mahd) references hoadon(mahd),
	constraint fk_hdd2 foreign key (mahang) references hanghoa(mahang)
)

alter table hoadonct
add constraint check_so_luong check(soluong > 0)



select * from hoadon
insert into hoadon(mahd , makhach, ngaydat , ngaynhan)
values('1' , '1' ,null, '2019-01-01'),
('2' , '2' ,'2019-01-01', '2019-01-01'),
('3' , '4' ,'2019-01-01', '2019-01-01'),
('4' , '4' ,'2019-01-01', '2019-01-01'),
('5' , '5' ,'2019-01-01', '2019-01-01'),
('6' , '6' ,'2019-01-01', '2019-01-01'),
('7' , '7' ,'2019-01-01', '2019-01-01'),
('8' , '8' ,'2019-01-01', '2019-01-01'),
('9' , '9' ,'2019-01-01', '2019-01-01')


select * from khachhang
insert into khachhang(makhach , tenkhach , diachi , dienthoai , gioitinh)
values('KH1' , 'Nguyen the an' ,'so 10 nguyen traui', '1233434' , 1),
('KH2' , 'Nguyen xuan hai' ,'so 1 nhan hoa', '8888888' , 1)


select * from hanghoa
insert into hanghoa(mahang , tenhang , dongia , dvt)
values('001' , 'iphone6' ,299977, 'khong ro' ),
('002' , 'Nguyen xuan hai' ,123232332, 'khong ro')



select * from hoadonct
insert into hoadonct(mahd , mahang , soluong)
values('1' , '001' ,77),
('2' , '002' ,32 )





