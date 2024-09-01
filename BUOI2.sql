create database qldiem
go
use qldiem
go


create table khoa(

    makhoa char(10) ,
	tenkhoa nvarchar(50),
	constraint pk_khoa1 primary key (makhoa)
)


create table monhoc(
   
    mamh char(10) , 
	tenmh nvarchar(50) , 
	sotiet numeric(18,0),
	constraint pk_monhoc1 primary key(mamh)
)

create table sv(
   masv char(10) ,
   hosv nvarchar(50),
   ten nvarchar(50) ,
   ns date,
   phai nchar(3),
   makhoa char(10) ,
   constraint pk_sv primary key (masv),
   constraint fk_sv1 foreign key (makhoa) references khoa(makhoa)
)


create table kq(
   masv char(10),
   mamh char(10) ,
   lanthi int,
   diem decimal(4 ,2),
   constraint pk_kq primary key (lanthi),
   constraint fk_kq1 foreign key (masv) references sv(masv),
   constraint fk_kq3 foreign key (mamh) references monhoc(mamh)

)


select * from khoa 
-- nhap du lieu cho bang khoa
insert into khoa(makhoa , tenkhoa)
values('ANVAN' , 'khoa anh van'),
('CNTT' , 'khoa cong nghe thong tin'),
('DTVT' , 'khoa dien tu vien thong'),
('QTKD' , 'khoa quan tri kinh doanh')

--nhap du lieu bang monhoc
select * from monhoc
insert into monhoc(mamh , tenmh , sotiet)
values('AV' , 'anh van' , 45),
('CSDL' , 'co so du lieu' , 45),
('KTLT' , 'ki thuat lap trinh' , 60),
('KTTC' , 'tai chinh ke toan' , 45),
('TCC' , 'toan cao cap' , 60),
('THVP' , 'tin van phong ' , 30),
('TTNT' , 'tri tue nhan tao' , 60)

-- nhap du lieu bang sv

select * from sv
insert into sv(masv , hosv , ten , ns , phai , makhoa)
values('S001' , 'nguyen van' , 'an' , '1985-10-21' , 'nam' , 'CNTT'),
('S002' , 'dinh van' , 'hoa' , '1984-01-15' , 'nam' , 'CNTT'),
('S003' , 'ngo viet' , 'hung' , '1986-12-15' , 'nam' , 'DTVT'),
('S004' , 'nguyen thi' , 'hong' , '1986-02-12' , 'nu' , 'QTKD'),
('S005' , 'la thi' , 'lan' , '1985-08-03' , 'nu' , 'ANVAN'),
('S006' , 'nguyen minh' , 'hien' , '1984-11-01' , 'nu', 'ANVAN'),
('S007' , 'pham ngoc' , 'doan' , '1986-10-10' , 'nam' , 'CNTT')


select * from kq
insert into kq(masv , mamh ,lanthi, diem)
values('S001' , 'CSDL' , 1 , 4.00),
('S001' , 'TCC' , 2 , 6.00),
('S002' , 'CSDL' , 3 , 3.00),
('S002' , 'CSDL' , 4 , 6.00),
('S003' , 'KTTC' , 5 , 5.00),
('S004' , 'AV' , 6 , 8.00),
('S004' , 'THVP' , 7 , 4.00),
('S004' , 'THVP' , 8 , 8.00),
('S005' , 'THVP' , 9 , 6.00),
('S006' , 'AV' , 10 , 4.00),
('S006' , 'AV' , 11 , 8.00),
('S007' , 'KTLT' , 12 , 9.00)


--Câu 1: Chèn bảng SINHVIEN mã sinh viên S008, hosv: Nguyễn Văn
--tên: Huy có ngày sinh: 21/12/1984, phái Nam, khoa CNTT

insert into sv(masv , hosv , ten , ns , phai , makhoa)
values('S008' , 'Nguyen Van', 'Huy' , '1984-12-21' , 'nam' , 'CNTT')

select * from sv

--Sửa lại bảng SINHVIEN mã sinh viên S008, Năm sinh thành 2004

update sv
set
ns = '2004-12-21'
where masv = 'S008'

--Câu 3: Cho biết kết quả học tập của sinh viên mã S007
select * from kq
where masv = 'S007'

--Câu 4: Liệt kê những sinh viên sinh vào ngày 3 tháng 8

select * from sv
where day(ns) = 03 and month(ns) = 08

--Câu 5:Cho biết sinh viên mà họ có chứa chữ Văn

select * from sv 
where hosv LIKE N'%Van%'

-- CAU 6 Cho biết kết quả học tập gồm:
--HOSV,TEN,MAMH,LANTHI,DIEM của sinh viên có mã S007\

select hosv , ten , mamh , lanthi , diem
from sv
inner join kq
on sv.masv = kq.masv
where sv.masv = 'S007'

-- Câu 7: Cho biết danh sách sinh viên Nam khoa Công nghệ thông tin
--sắp xếp theo tên, họ tăng dần


select * from sv
where phai = 'Nam' and makhoa = 'CNTT'
order by ten ASC

-- Câu 8: Cho biết danh sách các môn học trên 40 tiết và có tên bắt đầu
--bởi chữ T

select * from monhoc
where sotiet >= 40 and tenmh like 'T%'

-- Câu 9. Cho biết kết quả học tập của sinh viên khoa công nghệ thông
--tin


select * from kq
where mamh = 'TCC' or mamh = 'CSDL' or mamh ='KTLT' or mamh = 'THVP'

--Câu 10: Liệt kê những sinh viên ở khoa Công nghệ thông tin và Điện
--tử viễn thông

select * from sv
where makhoa = 'CNTT' or makhoa = 'DTVT'

-- Câu 11: Cho biết danh sách sinh viên chưa có kết quả thi môn nào,
--thông tin gồm Họ tên, Ngày sinh, Tên khoa

select hosv , ten , ns , tenkhoa
from sv
inner join khoa
on sv.makhoa = khoa.makhoa
left join kq
on sv.masv = kq.masv
where kq.masv is null


--cau12 Cho biết những sinh viên đã học môn có mã AV, sắp xếp
--giảm dần theo ngày sinh thông tin gồm:
--MASV,HOSV,TENSV,NGAYSINH,TENKHOA

select sv.masv as ma_sinh_vien , hosv , ten , ns , tenkhoa
from sv
inner join khoa
on sv.makhoa = khoa.makhoa
left join kq
on sv.masv = kq.masv
where kq.mamh = 'AV'
order by day(sv.ns) DESC

-- Cho biết thông tin: MaSV, HoTenSV, TenMon Hoc, Lan Thi,
--DiemThi


select sv.masv  , hosv , ten , tenmh , lanthi , diem
from sv
inner join kq
on sv.masv = kq.masv
left join monhoc
on kq.mamh = monhoc.mamh

-- Câu 14. Liệt kê những sinh viên khoa CNTT tuổi dưới 20


select * from sv 
where makhoa = 'CNTT' and (2024 - YEAR(ns) < 20)

-- Câu 15. Cho biết tên môn học nào chưa có sinh viên học

select tenmh
from monhoc
left join kq
on monhoc.mamh = kq.mamh
where kq.mamh is null



-- Câu 16: Cho biết mã sinh viên, họ tên của những sinh viên nào rớt môn
--CSDL ở lần thi thứ 1


--select *, diem as diem_thi from kq
select sv.masv , hosv , ten
from sv
left join kq
on sv.masv = kq.masv
where kq.diem < 5

-- Câu 17. Tính tổng số sinh viên theo từng khoa

select * from sv
select count(masv) as si_so_khoa_cntt from sv
where makhoa = 'CNTT'

select count(masv) as si_so_khoa_av from sv
where makhoa = 'ANVAN'

select count(masv) as si_so_khoa_qtkd from sv
where makhoa = 'QTKD'

select  count(masv) as si_so_khoa_dtvt from sv
where makhoa = 'DTVT'

--Câu 18. Tính tổng số sinh viên tham gia học theo từng môn học


select * from kq
select count(mamh) as so_sv_csdl from kq
where mamh = 'CSDL'

select count(mamh) as so_sv_csdl from kq
where mamh = 'TCC'

select count(mamh) as so_sv_csdl from kq
where mamh = 'KTTC'

select count(mamh) as so_sv_csdl from kq
where mamh = 'AV'

select count(mamh) as so_sv_csdl from kq
where mamh = 'THVP'