create database qlnv
go
use qlnv
go


create table phongban(
     mapb int not null,
	 tenpb nvarchar(50) not null , 
	 nguoiquanli int not null, 
	 constraint pk_pb1 primary key (mapb)
)

create table congtrinh(
     mact int not null , 
	 tenct nvarchar(50) not null , 
	 ngaykc date not null ,
	 ngayht date not null , 
	 diadiem nvarchar(50),
	 constraint pk_ct1 primary key (mact)
)


create table nhanvien(
    manv int not null , 
	tennv nvarchar(50) not null , 
	ns date , 
	diachi nvarchar(50) ,
	luong money , 
	gioitinh bit , 
	mapb int ,
	constraint pk_nv1 primary key (manv),
	constraint fk_nvv foreign key (mapb) references phongban(mapb)
)

create table thamgia(
     mact int not null , 
	 manv int not null , 
	 songaycong numeric(18 , 0),
	 constraint fk_tg1 foreign key (mact) references congtrinh(mact),
	 constraint fk_tg2 foreign key (manv) references nhanvien(manv)

)



-- nhap du lieu cho phong banm 
select * from phongban

insert into phongban(mapb , tenpb , nguoiquanli)
values(1 , 'phong phan mem ' , 11),
(2 , 'phong kiem thu phan mem ' , 5),
(3 , 'phong phan mem moi' , 4)


select * from nhanvien

insert into nhanvien(manv , tennv  , ns , diachi , luong , gioitinh , mapb)
values(1 ,'Nguyen Hai Dang' , '1977-08-08' , 'Hoa Binh' , 4000000.0000 , 1, 1),
(2 ,'Tran cao ha' , '1977-08-08' , 'yen bai' , 5000000.0000 , 1, 1),
(3 ,'Hoang hai nam' , '1977-08-08' , 'ha noi' , 4000000.0000 , 1, 1),
(4 ,'tran hong nam' , '1977-08-08' , 'thanh hoa' , 4000000.0000 , 1, 2),
(5 ,'le thi hang' , '1977-08-08' , 'hai phong ' , 4000000.0000 , 1, 3),
(6 ,'Nguyen thi haang' , '1977-08-08' , 'ha noi' , 4000000.0000 , 1, 2),
(7 ,'le thi van anh' , '1977-08-08' , 'yen bai' , 4000000.0000 , 1, 1),
(8 ,'mai van cu' , '1977-08-08' , 'bac ninh' , 4000000.0000 , 1, 3),
(9 ,'dinh hong nam' , '1977-08-08' , 'Hoa Binh' , 4000000.0000 , 1, 3),
(10 ,'ho viet duan' , '1977-08-08' , 'Hoa Binh' , 4000000.0000 , 1, 3),
(11,'tran duc nghia' , '1977-08-08' , 'Hoa Binh' , 4000000.0000 , 1, 1)

select * from congtrinh
insert into congtrinh(mact , tenct , ngaykc, ngayht , diadiem)
values(1 , 'Mobile contact ' , '2005-08-08' ,  '2005-08-08' , 'HITC'),
(2 , 'RE-ISSUE ' , '2005-08-08' ,  '2005-08-08' , 'FPT CAU GIAY'),
(3 , 'MOBILE CONTACT ' , '2005-08-08' ,  '2005-08-08' , 'FPT CAU GIAY'),
(4 , 'WINGS ' , '2005-08-08' ,  '2005-08-08' , 'FPT CAU GIAY')


select * from thamgia
insert into thamgia(mact , manv , songaycong)
values(1 ,7 , 70),
(1 ,9 , 70),
(1 ,11 , 70),
(2 ,1 , 70),
(2 ,2 , 70),
(2 ,5 , 70),
(2 ,11 , 70)



