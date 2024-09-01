create database dc1
go
use dc1
go


create table dm_hang( 
     ma_hang int identity , 
	 ten_hang nvarchar(50) , 
	 don_vi_tinh int , 
	 mo_ta nvarchar(50) , 
	 constraint pk_hang primary key (ma_hang)
)

insert into dm_hang
values('quan dai' , 1 , 'khong'),('ao dai' , 2 , 'khong') , ('ao ba lo' , 3 , 'khong')


create table loai_phieu_xin(
    ma_loai int identity , 
	ten_loai nvarchar(50) , 
	ghi_chu nvarchar(50) , 
	constraint pk_phieu primary key (ma_loai)

)
insert into loai_phieu_xin
values('loai A' , 'khong') , ('loai B' , 'khong') , ('loai C' , 'khong')


create table dm_nhan_vien(
    ma_nv int identity , 
	ho_nv nvarchar(50) , 
	ten_nv nvarchar(50) , 
	gi_chu nvarchar(50) , 
	constraint pk_nv primary key (ma_nv)
)
insert into dm_nhan_vien
values('Nguyen' ,'Van A' , 'khong'),
('Nguyen' ,'Van B' , 'khong'),
('Nguyen' ,'Van B' , 'khong')


create table chi_tiet_hoa_don(
     ma_hd int identity,
	 ma_hang int , 
	 so_luong int , 
	 don_gia int , 
	 chiet_khau int ,
	 constraint pk_dh primary key (ma_hd),
	 constraint fk_dh foreign key (ma_hang) references dm_hang(ma_hang)
)
select  * from chi_tiet_hoa_don

insert into chi_tiet_hoa_don
values( 1 , 1 , 222 , 12),( 2, 2 , 33 , 12) , ( 3 , 3 , 32 , 12)




create table dm_khach(
    ma_khach int identity ,
	ho_kh nvarchar(50) , 
	ten_kh nvarchar(50) , 
	dia_chi nvarchar(50) , 
	ma_so_thue int , 
	tai_khoan nvarchar(50) , 
	ten_ngan_hang nvarchar(50) ,
	gi_chi nvarchar(50) , 
	constraint pk_khach primary key (ma_khach)
)

insert into dm_khach(ho_kh , ten_kh , dia_chi , ma_so_thue , tai_khoan , ten_ngan_hang , gi_chi)
values('Nguyen' , 'van a' , 'Bac Giang' ,3232323 , 'tk_bg' , 'techcombank' , 'khong'),
('Nguyen' , 'van b' , 'Bac ninh' ,3233 , 'tk_bn' , 'techcombank' , 'khong'),
('Nguyen' , 'van v' , 'Bac tu liem' ,32232323 , 'tk_btn' , 'mb' , 'khong')
select * from dm_khach



create table hoa_don(
    ma_hd int ,
	ngay_lap date,
	ma_khach int  , 
	ma_nv int , 
	ma_loai int , 
	mo_ta nvarchar(50) , 
	constraint pk_hd primary key (ma_loai) ,
	constraint fk_hd1 foreign key (ma_hd) references chi_tiet_hoa_don(ma_hd),
	constraint fk_hd2 foreign key (ma_khach) references dm_khach(ma_khach),
	constraint fk3_hd3 foreign key (ma_nv) references dm_nhan_vien(ma_nv)
)

insert into hoa_don(ma_hd , ngay_lap , ma_khach , ma_nv , ma_loai , mo_ta)
values(1 , '2013-05-21' ,  1 , 1 , 1 , 'khong'),
(2 , '2001-05-21'  , 2 , 2 , 2 , 'khong'),
(3 , '2021-05-21' ,  2 , 3 , 3 , 'khong')

select * from hoa_don
-- cau 1 tao bang

-- cau 2 liệt kê khách hàng có địa chỉ ở Bắc Giang

select ho_kh , ten_kh , dia_chi from dm_khach
where dia_chi Like '%Bac Giang%'


-- câu 3 : liệt kê hóa đơn bán hàng trong tháng 5 năm 2011

select hoa_don.ma_hd , hoa_don.ngay_lap , dm_khach.ten_kh , loai_phieu_xin.ten_loai , dm_nhan_vien.ten_nv
from hoa_don
inner join loai_phieu_xin
on loai_phieu_xin.ma_loai = hoa_don.ma_loai
inner join dm_khach
on dm_khach.ma_khach = hoa_don.ma_khach
inner join dm_nhan_vien
on dm_nhan_vien.ma_nv = hoa_don.ma_nv
where year(hoa_don.ngay_lap) = 2001 and month(hoa_don.ngay_lap) = 5