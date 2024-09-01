
use dc2

create table chuc_vu(
    ma_vc nvarchar(10) , 
	ten_cv nvarchar(10)
	constraint pk_cv primary key (ma_vc)
)
insert into chuc_vu
values ('1' , 'giam doc') , ('2' , 'ke toan') , ('3' , 'nhan vien')

create table don_vi(
    ma_dv nvarchar(50) ,
	ten_dv nvarchar(50) , 
	constraint pk_dv primary key (ma_dv)
)

insert into don_vi
values('1' , 'phong khong') , ('2' , 'bo doi') , ('3' , 'thuy quan')


create table ho_so(
    ma_ns nvarchar(10) , 
	ho_ten nvarchar(10) ,
	ngay_sinh date ,
	que_quan nvarchar(50) ,
	gioi_tinh bit , 
	MA_DV nvarchar(50) , 
	MA_VC nvarchar(10),
	constraint pk_hs primary key (ma_ns),
	constraint fk_hs2 foreign key (MA_DV) references don_vi(ma_dv),
	constraint fk_hs1 foreign key (MA_VC) references chuc_vu(ma_vc)
)

insert into ho_so
values('1' , 'nguyenvana' , '2003-10-22' , 'BAC NINH' , 1 , '1' , '1'),
('2' , 'nguyenvanb' , '1998-11-12' , 'BAC GIANG' , 0 , '2' , '2'),
('3' , 'nguyenvanC' , '1895-01-27' , 'BAC GIANG' , 1 , '3' , '3')

SELECT * FROM ho_so


CREATE TABLE bang_luong(
    MA_NS nvarchar(10) , 
	luong_chinh float(8) , 
	he_so float(8) , 
	bac_luong float(8) , 
	phu_cap float(8) , 
	bhyt float(8) , 
	bhxh float(8) , 
	constraint fk_bl foreign key (MA_NS) references ho_so(ma_ns)
)


insert into bang_luong
values('1' , 34.22 , 7.56 , 10.00 , 12.22 , 1234.56 , 1234.56),
('2' , 4.22 , 2.56 , 20.00 ,23.62 , 1234.56 , 1234.56),
('3' , 3.22 , 6.56 , 30.00 , 34.42 , 1234.56 , 1234.56)



--  CHO BIẾT NHƯNG NV CÓ HỆ SỐ LỚN HƠN 2.34 VÀ CÓ GIỚI TÍNH LÀ NAM

select ho_so.ho_ten, ho_so.gioi_tinh , ho_so.ngay_sinh , bang_luong.he_so
from ho_so
left join bang_luong
on bang_luong.MA_NS = ho_so.ma_ns
where gioi_tinh = 1 and he_so >= 2.34

-- cho biet nhan vien que o ha noi sinh sau nam 1985

select * from ho_so
where YEAR(ngay_sinh) < 1985 and que_quan like N'%BAC GIANG%'