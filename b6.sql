create database dc6
go
use dc6
go


create table nhan_vien(
    manv int identity , 
	hodem nvarchar(50) , 
	ten nvarchar(50), 
	ns date , 
	que nvarchar(50) , 
	batdau date default getdate() ,
	constraint pk_nv primary key (manv) , 

)

insert into nhan_vien(hodem , ten , ns , que)
values('nguyen' , 'thang' , '1943-01-01' , 'tu son'),
('pham' , 'te de' , '1933-01-01' , 'tu son'),
('long' , 'hai phopng' , '1999-01-01' , 'tu son')


create table hoc_vi(
     MANV int , 
	 hocham nvarchar(50) , 
	 hovi nvarchar(50) , 
	 constraint fk_hv foreign key (MANV) REFERENCES nhan_vien(manv) 

)


insert into hoc_vi
values(1 , 'gs' , 'tien si'), (2 , 'pho gs' , 'tien si') , (3, 'tien si' , 'dai hoc')


select hodem , ten , que , hovi
from nhan_vien
left join hoc_vi
on hoc_vi.MANV = nhan_vien.manv
where YEAR(nhan_vien.ns) = 1956 and hoc_vi.hovi like N'%tien si%'



-- cau 2:
select hodem , ten , ns , hovi 
from nhan_vien
inner join hoc_vi
on hoc_vi.MANV = nhan_vien.manv
where hoc_vi.hovi like N'%tien si%' 
and 
(2024 - YEAR(ns) between 45 and 50)