create database dc78
go
use dc78
go


create table lop(

     malop int identity ,
	 tenlop nvarchar(50) , 
	 loptruong nvarchar(50) , 
	 siso int ,
	 constraint pk_lop primary key (malop)
)

insert into lop
values('toan' , 'TunPham' , 12) , ('van' , 'CdYesbest' , 33) , ('Anh' , 'CdYesbest' , 20)


create table sinh_vien(
    masv int identity , 
	hodem nvarchar(50) , 
	ten nvarchar(50) , 
	ns date , 
	gt bit , 
	dc nvarchar(50) , 
	MALOP int ,
	constraint pk_f primary key (masv) ,
	constraint fk_f foreign key (MALOP) references lop(malop)
)

insert into sinh_vien
values('Nguyen ' , 'Thang' , '2012-01-01 ' , 1 , 'md' , 1),
('Nguyen ' , 'Trabg' , '1012-01-01 ' , 0 , 'lt' , 2),
('Nguyen ' , 'Tu' , '2212-01-01 ' , 1 , 'pm' , 3)


create table  mon_hoc(
    mamh int identity , 
	tenmh nvarchar(50) , 
	sotin int , 
	sotiet int , 
	constraint pk_m primary key (mamh)

)

insert into mon_hoc
values('toan' , 12 , 22) , ('van' , 44 , 11) , ('co so du lieu' , 12 , 13)
create table kq(
     MASV int , 
	 MAMH int , 
	 lanthi int , 
	 diem int , 
	 kq char(10), 
	 constraint pk_kq primary key(lanthi) , 
	 constraint fk_kq foreign key (MASV) references sinh_vien(masv),
	 constraint fk_dk foreign key (MAMH) references mon_hoc(mamh)
)

insert into kq
values(1 , 3, 1 , 5, 'D'),
(2 , 3 , 2 , 7 , 'D'),
(3 , 1 , 3 , 2 , 'Y')


-- 
select sinh_vien.masv , sinh_vien.hodem , sinh_vien.ten , kq.diem , kq.kq as ket_qua
from sinh_vien
left join kq 
on kq.MASV = sinh_vien.masv
left join mon_hoc
on mon_hoc.mamh = kq.MAMH
where mon_hoc.tenmh like N'%co so du lieu%'
order by kq.diem DESC


-- 
SELECT top 1 lop.tenlop , lop.siso , count(sinh_vien.masv) as so_sinh_vien
from lop
inner join sinh_vien
on sinh_vien.masv = lop.malop
group by lop.tenlop  , lop.siso
order by so_sinh_vien desc

-- cho biet sinh vien hoc nhieu mon nhat 

select  sinh_vien.ten , count(kq.MAMH) as so_lan_hoc
from sinh_vien
inner join kq
on kq.MASV = sinh_vien.masv
group by sinh_vien.ten
order by so_lan_hoc desc
offset 0 rows fetch next 1 rows only;



--
select sinh_vien.masv , sinh_vien.ten , count(kq.MAMH) as so_mon_hoc
from sinh_vien
inner join kq 
on kq.MASV = sinh_vien.masv
group by sinh_vien.masv , sinh_vien.ten


-- 
select sinh_vien.masv , sinh_vien.ten , count(kq.MAMH) as so_mon_hoc
from sinh_vien
inner join kq 
on kq.MASV = sinh_vien.masv
group by sinh_vien.masv , sinh_vien.ten
having count(kq.MAMH) > 5