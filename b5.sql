create database dc5
go
use dc5
go


create table khach_hang(
   makh int identity ,
   hodem nvarchar(50) , 
   ten nvarchar(50) , 
   diachi nvarchar(50) , 
   sdt int , 
   ns date ,
   constraint pk_khach primary key (makh) 
)

insert into khach_hang
values('van' , 'thanh' , 'bac ninh' , 1234 , '1998-10-10'),
('kium' , 'tna' , 'bac noi' , 1434 , '1994-10-10'),
('van' , 'tan' , 'bac tu lienm' , 1342 , '1996-10-10')


create table san_pham
(
   masp int identity , 
   tensp nvarchar(50) , 
   donvitinh nchar(6),
   nsx nvarchar(50) , 
   gia int ,
   constraint pk_sp primary key (masp)
)

insert into san_pham
values('nuoc ngot' , 'kg' , 'tung tua' , 10000),
('nuoc canh kim' , 'kg' , 'viet nam' , 6000),
('banh gao' , 'kg' , 'tung tua' , 25000)


create table hoa_don(
    sohd int identity ,
	ngayhd date default getdate(),
	MAKH int , 
	trigia int ,
	constraint pk_hh primary key (sohd),
	constraint fk_hh foreign key (MAKH) references khach_hang(makh)

)

insert into hoa_don(MAKH, trigia)
values(1 , 100000) , (2, 30000) , (3 , 140000)


create table cthd(
    SOHD int , 
	MASP int , 
	soluong int ,
	constraint fk_ct foreign key (SOHD) references hoa_don(sohd),
	constraint fk_v foreign key (MASP) references san_pham(masp)
)

insert into cthd
values(1 , 1 , 2000), (2 , 1 , 3000) , (3 , 2 , 1000) 

-- in ra danh sách sản phẩm có giá trị 10k - 50k 
--do tq sản xuất


SELECT masp , tensp from san_pham
where (gia between 10000 and 50000) and nsx like N'%tung tua%'

-- 
select khach_hang.makh , khach_hang.ten , hoa_don.trigia
from khach_hang
left join hoa_don
on hoa_don.MAKH = khach_hang.makh
where hoa_don.trigia = (SELECT MAX(trigia) from hoa_don)