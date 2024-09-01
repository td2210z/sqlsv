create database btfu
go
use btfu
go


create table lop(
   ma int identity , 
   ten nvarchar(50) , 
   constraint pk_lop primary key (ma)
)
insert into lop
values('toann') , ('van') , ('anh')


create table sinh_vien
(
   ma int identity , 
   hoten nvarchar(50) ,
   gt bit , 

   ns date , 
   MA_LOP int ,
   constraint pk_sv primary key (ma) , 
   constraint fk_sv foreign key (MA_LOP) references lop(ma)
)

insert into sinh_vien
values('thang' , 1 , '2003-01-02' , 1) , 
('hao' , 0 , '1998' , 2) , 
('huan'   , 1 , '2020-01-01' , 1) , 
('gon' , 0 , '2012-01-01' , 3)

-- hiển thị tên giới tính

create function hien_thi_gioi_tinh(@ma int)
returns table
return
select hoten , gt from sinh_vien
where ma = @ma


select *  from hien_thi_gioi_tinh(1)

--hiển thị tuổi
drop function hien_thi_tuoi
create function hien_thi_tuoi(@ns date)
returns int 
as
begin
    return datediff(YEAR , @ns , getdate())
end

select * from hien_thi_tuoi(ns)

select 
ma , hoten ,
dbo.hien_thi_tuoi(ns) as so_tuoi
from sinh_vien


create function hien_tuoi(@ma int)
returns table
return 
select ma , hoten , dbo.hien_thi_tuoi(ns) as to_toy from sinh_vien
where ma = @ma


select * from hien_tuoi(1)

--join 2 bảng và hiển thị lại toàn bộ thông tin theo mã sinh viên truyền vào

create function hien_all(@ma int)
returns table
return
select sinh_vien.ma , sinh_vien.hoten , sinh_vien.ns , sinh_vien.MA_LOP ,
lop.ten
from sinh_vien
inner join lop
on lop.ma = sinh_vien.MA_LOP
where sinh_vien.ma = @ma

select * from hien_all(1)


