create database dc10
go
use dc10 
go


create table khachhang(
     makhachhang int identity , 
	 tencongty nvarchar(50) , 
	 tengiaodich nvarchar(50) , 
	 diachi nvarchar(50) , 
	 email nvarchar(50) , 
	 dienthoai int , 
	 fax int , 
	 constraint pk_kh primary key (makhachhang)
)

insert into khachhang
values('co phan flc' , 'truong chung khoan ' , 'bac ninh' , 'khong@gmail.com' , 34556 , 3232) , 
('co phan dai nam' , 'truong chung khoan 2 ' , 'ha noi' , 'khong1@gmail.com' , 1234556 ,2222) ,
('co phan vinataba' , 'giao dich truc tiep ' , 'ho chi minh' , 'khong3@gmail.com' , 12556 , 3333) 

create table nhanvien(
    manv int identity, 
	ho nvarchar(50) , 
	ten nvarchar(50) , 
	ns date , 
	ngaylamviec date default getdate(),
	diachi nvarchar(40) , 
	dienthoai int ,
	luong int , 
	phucap int , 
	constraint pk_nv primary key (manv)
)

insert into nhanvien(ho , ten , ns , diachi , dienthoai , luong , phucap)
values('nguyen' , 'an' , '1992-01-01' , 'bac ninh' , 1234 , 200 , 100),
('doan' , 'hung' , '1999-01-01' , 'ha noi' , 4321 , 500 , 200),
('van' , 'anh' , '1993-01-01' , 'hochiminh' , 3234 , 500 , 800)

select * from nhanvien


create table dondathang(
    sohoadon int identity , 
	MAKHACHHANG int , 
	MANHANVIEN int , 
	ngaydathang date , 
	ngaygiaohang date , 
	ngaychuyenhang date , 
	noigiaodich nvarchar(50) , 
	constraint pk_dh primary key (sohoadon) , 
	constraint fk_d1 foreign key (MAKHACHHANG) references khachhang(makhachhang),
	constraint fk_d2 foreign key (MANHANVIEN) references nhanvien(manv)

)

insert into dondathang(MAKHACHHANG , MANHANVIEN , ngaydathang , ngaygiaohang , ngaychuyenhang , noigiaodich)
values(1 , 1 , '2014-01-01' , '2014-01-12' , '2014-01-20' , 'thi trran bac ninh'),
(2 , 2 , '2014-01-03' , '2014-01-14' , '2014-01-20' , 'thi trran bac ninh'),
(3 , 3 , '2014-01-02' , '2014-01-13' , '2014-01-20' , 'thi trran bac ninh')


create table nhacungcap(
     macongty int identity , 
	 tencongty nvarchar(50) , 
	 tengiaodich nvarchar(50) , 
	 diachi nvarchar(50) , 
	 fax int , 
	 email nvarchar(50) , 
	 constraint pk_n primary key (macongty)
)

insert into nhacungcap
values('huu han A' , 'chung khoan' , 'bac ninh' , 1234 , 'td@gmail.com'),
('huu han B' , 'truc tiep' , 'ha noi' , 1314 , 'td2@gmail.com'),
('huu han C' , 'chung khoan' , 'ho chi minh' , 999 , 'td3@gmail.com')


create table loaihang(
     maloaihang int identity , 
	 tenloaihang nvarchar(50) , 
	 constraint pk_lh primary key (maloaihang)
)

insert into loaihang
values('Hang dep'), ('hang xau') , ('hang trung binh')
create table mathang(
    mahang int identity , 
	tenhang nvarchar(50) , 
	MACONgTY int , 
	MALOAIHANG int , 
	soluong int , 
	donvitinh char(10) ,
	giahang int , 
	constraint pk_mh primary key (mahang) , 
	constraint fk_mh foreign key (MACONgTY) references nhacungcap(macongty),
	constraint fk_mh2 foreign key (MALOAIHANG) references loaihang(maloaihang)

)

insert into mathang(tenhang , MACONgTY , MALOAIHANG , soluong , donvitinh , giahang)
values('quan jeans' , 1 , 1 , 234 , 'kg' , 1200) ,
('ao jeans' , 2 , 2 , 123 , 'kg' , 3200) ,
('ao khoac jeans' , 3 , 3 , 555 , 'kg' , 2200)


create table chitiet(
       sohoadon int identity , 
	   MAHANG int , 
	   giaban int ,
	   soluong int default 123 , 
	   mucgiamgia int default 30, 
	   constraint ct primary key (sohoadon) , 
	   constraint cr_c1 foreign key (MAHANG) references mathang(mahang) 
)

select * from chitiet
insert into chitiet(MAHANG , giaban )
values(1 , 200) , (2 , 300) , (3 , 400) 


-- cau A
select mathang.mahang , mathang.tenhang , mathang.soluong , nhacungcap.tencongty
from mathang
left join nhacungcap
on nhacungcap.macongty = mathang.MACONgTY

-- cau B


select  mathang.mahang , mathang.tenhang , chitiet.giaban
from mathang
inner join chitiet
on chitiet.MAHANG = mathang.mahang
where chitiet.giaban > 100 and mathang.soluong < 500


-- cau C

select manv , ten , sum(luong+phucap) as tong_luong from nhanvien
group by manv , ten


