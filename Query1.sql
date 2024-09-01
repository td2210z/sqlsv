--Tạo cơ sở dữ liệu để quản lý sinh viên

--Yêu cầu:

--có thông tin sinh viên, lớp (*: môn, điểm)
--có kiểm tra ràng buộc
--Thêm mỗi bảng số bản ghi nhất định
--Lấy ra tất cả sinh viên kèm thông tin lớp
--Đếm số sinh viên theo từng lớp
--Lấy sinh viên kèm thông tin điểm và tên môn
--(*) Lấy điểm trung bình của sinh viên của lớp LT
--(*) Lấy điểm trung bình của sinh viên của môn SQL
--(*) Lấy điểm trung bình của sinh viên theo từng lớp


create database buoi_cuoi
go
use buoi_cuoi
go


create table lop_hai (
    ma int identity ,
	ten nvarchar(50) not null unique , 
	constraint pk_lop primary key (ma)
)

insert into lop_hai(ten)
values('LT'),('ATTT') , ('BTMT')


select * from lop_hai


create table sinh_vien1(
    ma int identity ,
	ten nvarchar(50) not null,
	ma_lop int ,
	constraint pk_sv primary key (ma),
	constraint fk_sv foreign key (ma_lop) references lop_hai(ma)
)


insert into sinh_vien1(ten , ma_lop)
values('Long' , 1) ,('Tuan' , 1) , ('Anh' , 2)
insert into sinh_vien1(ten , ma_lop)
values('Tung' , 1) ,('TuanB' , 1) , ('AnhC' , 2)


select * from sinh_vien1

create table mon_goc(
   ma int identity , 
   ten nvarchar(50) not null unique, 
   constraint pk_mg primary key(ma) ,

)

insert into mon_goc( ten)
values('SQL') , ('PHP') , ('HTML')

select * from mon_goc


create table diem(
    ma_mon int not null , 
	ma_sinh_vien int not null , 
	diem float,
	constraint fk_diem foreign key (ma_mon) references mon_goc(ma),
	constraint fk_diem2 foreign key (ma_sinh_vien) references sinh_vien1(ma),
	constraint pk_diem3 primary key (ma_mon , ma_sinh_vien)
)

alter table diem
add constraint check_diem check(diem >=0 and diem <= 10)


insert into diem
values (1,1,3),(1,2,5)
insert into diem
values (2,1,10)

select * from diem

--Lấy ra tất cả sinh viên kèm thông tin lớp (nếu có)

select * from sinh_vien1
left join lop_hai
on lop_hai.ma = sinh_vien1.ma

--Đếm số sinh viên theo từng lớp

select  lop_hai.ma , lop_hai.ten , count(sinh_vien1.ma) as so_sinh_vien
from sinh_vien1
left join lop_hai
on lop_hai.ma = sinh_vien1.ma
group by lop_hai.ten , lop_hai.ma



--Lấy sinh viên có ,điểm kèm tên. môn

select sinh_vien1.ten ,mon_goc.ten , diem.diem  
from sinh_vien1
inner join mon_goc
on mon_goc.ma = sinh_vien1.ma
inner join diem
on diem.ma_mon = mon_goc.ma

--(*) Lấy điểm trung bình của sinh viên của từng lớp

select lop_hai.ma , avg(diem) as diem_trung_binh
from sinh_vien1
join lop_hai
on lop_hai.ma = sinh_vien1.ma_lop
right join diem
on diem.ma_sinh_vien = sinh_vien1.ma
group by lop_hai.ma

--(*) Lấy điểm trung bình của sinh viên của lớp LT

select avg(diem) as diem_tb
from sinh_vien1
join lop_hai
on lop_hai.ma = sinh_vien1.ma
right join diem
on diem.ma_sinh_vien = sinh_vien1.ma
where lop_hai.ten ='LT'

--(*) Lấy điểm trung bình của sinh viên của môn SQL

select avg(diem)
from diem
join mon_goc 
on diem.ma_mon = mon_goc.ma
where mon_goc.ten = 'SQL'