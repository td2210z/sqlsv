create database dc3
go
use dc3
go


create table khoa(
   ma_khoa int identity , 
   ten_khoa nvarchar(50) , 
   truong_khoa nvarchar(50) , 
   constraint pk_khoa primary key (ma_khoa)
)


insert into khoa
values('cntt' , 'cong nghe thong tin'), ('tkdh' ,'thiet ke do hoa') ,('attt' , 'an toan thong tin')


create table sinh_vien(
     masv int identity,
	 hosv nvarchar(50) , 
	 tensv nvarchar(50),
	 ngay_sinh date , 
	 que_quan nvarchar(50) , 
	 gioitinh bit ,
	 Ma_Khoa int ,
	 constraint pk_sv primary key (masv),
	 constraint fk_sv foreign key (Ma_Khoa) references khoa(ma_khoa)
)

insert into sinh_vien
values('nguyen' , 'adv' , '2003-10-10' , 'BAC NINH' , 1 , 1) ,
('nguyen' , 'luuong' , '2033-10-10' , 'dak lac' , 0 , 2) ,
('nguyen' , 'tam' , '2004-10-10' , 'bay lac' , 1 , 3) 

select * from sinh_vien


create table mon_hoc(
    mamh int identity , 
	tenmh nvarchar(50) , 
	sotiet int , 
	constraint pk_monhoc primary key (mamh)
)

insert into mon_hoc
values('toan roi rac', 12) , ('thiet ke web' , 22) , ('do an ' , 10)

create table kq(
    MASV int , 
	MAMH int , 
	diemthi int , 
	constraint fk_d foreign key (MASV) references sinh_vien(masv),
	constraint fk_d2 foreign key (MAMH) references mon_hoc(mamh)
)

insert into kq
values (1 , 1 , 7) , (2 , 1 , 5) , (3 , 3 , 2)


-- cho biết danh sách sinh viên có tên là Lương

SELECT * FROM sinh_vien
WHERE tensv like N'%Luuong%'


select kq.MASV , sinh_vien.tensv  , kq.diemthi
from kq
inner join sinh_vien
on sinh_vien.masv = kq.MASV
where kq.MASV = 1
