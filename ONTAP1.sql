

create database check1
go
use check1
go

create table khoa(
    makhoa char(10),
	tenkhoa nvarchar(50),
	constraint pk_khoa primary key (makhoa)
)

insert into khoa(makhoa , tenkhoa)
values('ANVAN' ,'KHOA ANH VAN'),
('CNTT' ,'CONG NGHE THONG TIN '),
('DTVT' , 'DIEN TU VIEN THONG'),
('QTKD' , 'QUAN TRI KINH DOANH')

select * from khoa

create table monhoc(
    mamh char(10),
	tenmh nvarchar(50) , 
	sotiet numeric(18,0) , 
	constraint pk_monhoc primary key (mamh)

)

insert into monhoc(mamh , tenmh , sotiet)
values('AV' , 'ANH VAN' , 45),
('CSDL' , 'CO SO DU LIEU' , 45),
('KTLT' , 'KI THUAT LAP TRINH' , 60),
('KTTC' , 'KE TOAN TAI CHINH' , 45),
('TCC' , 'TOAN CAO CAP' , 60),
('THVP' , 'TIN VAN PHONG ' , 30),
('TTNT' , 'TRI TUE NHAN TAO' , 60)

SELECT * FROM monhoc

create table sinh_vien(
   masv char(10) , 
   hosv nvarchar(50) ,
   ten nvarchar(50) , 
   ns date ,
   phai nchar(3) , 
   ma_khoa char(10) , 
   constraint pk_sinhvien primary key (masv),
   constraint fk_sv foreign key (ma_khoa) references khoa(makhoa),
)

insert into sinh_vien(masv , hosv , ten , phai , ns , ma_khoa)
values ('S001' , 'NGUYEN VAN' , 'AN' , 'NAM' , '1985-10-21' , 'CNTT'),
('S002' , 'DINH VAN' , 'HOA' , 'NAM' , '1984-01-15' , 'CNTT'),
('S003' , 'NGO VIET' , 'HUNG' ,'NAM' , '1986-12-15' , 'DTVT'),
('S004' , 'NGUYEN THI' , 'HONG' , 'NU' , '1986-02-12' , 'QTKD'), 
('S005', 'LA THI' , 'LAN' , 'NU' , '1985-08-03' ,'ANVAN') , 
('S006' , 'NGUYEN MINH' , 'HIEN' , 'NU' , '1984-11-01' , 'ANVAN'),
('S007' , 'PHAM NGOC' , 'DOAN' , 'NAM' , '1986-10-10' , 'DTVT')

SELECT * FROM sinh_vien

CREATE TABLE KETQUA(
    MA_SV CHAR(10) , 
	MA_MH CHAR(10) , 
	LANTHI INT , 
	DIEM DECIMAL(4 , 2),
	
	CONSTRAINT CHECK_2 FOREIGN KEY (MA_SV) REFERENCES sinh_vien(masv),
	constraint check_3 foreign key (ma_mh) references monhoc(mamh)
)

alter table ketqua
drop constraint CHECK_1	 

insert into ketqua(MA_SV , MA_MH , lanthi , diem)
values('S001' , 'CSDL' , 1 , 4.00) , 
('S001' , 'TCC' , 1 , 6.00) , 
('S002' , 'CSDL' , 1 , 3.00) , 
('S002' , 'CSDL' , 2, 6.00) , 
('S003' , 'KTTC' , 1 , 5.00) , 
('S004' , 'AV' , 1 , 8.00) , 
('S004' , 'THVP' , 1 , 4.00), 
('S004'  ,'THVP' , 2, 8.00) , 
('S005' , 'THVP' , 1 , 4.00) , 
('S006' , 'AV' , 1 , 4.00) ,
('S006' , 'AV' , 2 , 8.00) ,
('S007' , 'KTLT' , 1 , 9.00)

SELECT * FROM ketqua


--Chèn bảng SINHVIEN mã sinh viên S008, hosv: Nguyễn Văn
--tên: Huy có ngày sinh: 21/12/1984, phái Nam, khoa CNTT\


insert into sinh_vien(masv , hosv , ten , phai , ns ,ma_khoa)
values('S008' , 'NGUYEN VAN' , 'HUY' , 'NAM' , '1984-12-21' , 'CNTT')

--Sửa lại bảng SINHVIEN mã sinh viên S008, Năm sinh thành 2004

update sinh_vien
set
ns = '2004-12-21'
where masv = 'S008'

select * from sinh_vien

--Cho biết kết quả học tập của sinh viên mã S007

select * from KETQUA
where MA_SV = 'S007'

--Liệt kê những sinh viên sinh vào ngày 3 tháng 8

select ten from sinh_vien
where MONTH(ns) = 8 and DAY(NS) = 3

--Cho biết sinh viên mà họ có chứa chữ Văn

SELECT TEN FROM sinh_vien
WHERE hosv like '%VAN%'

--Cho biết kết quả học tập gồm:
--HOSV,TEN,MAMH,LANTHI,DIEM của sinh viên có mã S007

select hosv , ten , KETQUA.MA_MH 
, lanthi , diem
from sinh_vien
inner join KETQUA
on KETQUA.MA_SV = sinh_vien.masv


--Cho biết danh sách sinh viên Nam khoa Công nghệ thông tin
--sắp xếp theo tên, họ tăng dần

select * from sinh_vien
where phai = 'NAM' AND ma_khoa= 'CNTT'
order by hosv ASC , ten ASC

--Cho biết danh sách các môn học trên 40 tiết và có tên bắt đầu
--bởi chữ T


select * from monhoc
where sotiet >= 40 and tenmh like 'T%'

--Cho biết kết quả học tập của sinh viên khoa công nghệ thông


select MA_SV , MA_MH , LANTHI , DIEM , ma_khoa from KETQUA
left join sinh_vien
on sinh_vien.masv = KETQUA.MA_SV
where ma_khoa = 'CNTT'


-- Liệt kê những sinh viên ở khoa Công nghệ thông tin và Điện
--tử viễn thông

select * from sinh_vien
where ma_khoa = 'CNTT' OR ma_khoa ='DTVT'

--Cho biết danh sách sinh viên chưa có kết quả thi môn nào,
--thông tin gồm Họ tên, Ngày sinh, Tên khoa

SELECT hosv , ten , ma_khoa from sinh_vien
left join khoa
on khoa.makhoa = sinh_vien.ma_khoa
left join KETQUA
on KETQUA.MA_SV = sinh_vien.masv
where diem is null


--Cho biết những sinh viên đã học môn có mã AV, sắp xếp
--giảm dần theo ngày sinh thông tin gồm:
--MASV,HOSV,TENSV,NGAYSINH,TENKHOA


select masv , hosv , ten , ns , ma_khoa
from sinh_vien
left join KETQUA
on KETQUA.MA_SV = sinh_vien.masv
where KETQUA.MA_MH = 'AV'
ORDER BY sinh_vien.ns

--Cho biết thông tin: MaSV, HoTenSV, TenMon Hoc, Lan Thi,
--DiemThi

select masv , hosv , ten , tenmh , lanthi , diem
from sinh_vien
left join KETQUA
on KETQUA.MA_SV = sinh_vien.masv
left join monhoc
on monhoc.mamh = KETQUA.MA_MH

-- Liệt kê những sinh viên khoa CNTT tuổi dưới 20

select * from sinh_vien
where ma_khoa = 'CNTT' and 2024 - YEAR(ns) <20


--Cho biết tên môn học nào chưa có sinh viên học

select * from KETQUA
where MA_MH is null

-- Cho biết mã sinh viên, họ tên của những sinh viên nào rớt môn
--CSDL ở lần thi thứ 1

select masv , hosv , ten
from sinh_vien
left join KETQUA
on KETQUA.MA_SV = sinh_vien.masv
where MA_MH = 'CSDL' and diem <=5

--Tính tổng số sinh viên theo từng khoa

select  ma_khoa  , count(masv) as so_sinh_vien from sinh_vien
group by  ma_khoa

--Tính tổng số sinh viên tham gia học theo từng môn học

select tenmh , count(MA_SV) AS SO_SINH_VIEN from KETQUA
INNER JOIN monhoc
on monhoc.mamh = KETQUA.MA_MH
GROUP BY tenmh