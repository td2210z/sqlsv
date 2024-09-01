create database dll1
go
use dll1
go


create table lop(
   ma int , 
   ten nvarchar(50) ,
   constraint pk_lp primary key (ma)
)

create table sinh_vin(
     ma int ,
	 ho varchar(50), 
	 ten varchar(50), 
	 ma_lop int ,
	 constraint pk_sv primary key (ma) ,
	 constraint fk_sv foreign key (ma_lop) references lop(ma)
)

insert into lop(ma, ten)
values(1 , 'LT')

insert into sinh_vin(ma , ho , ten , ma_lop)
values(1 , 'long' ,'nguyen' , 1)

select * from lop


create nonclustered index view_index
on sinh_vin(ma)


create nonclustered index view_id2
on sinh_vin(ho)



select * from sinh_vin

drop view ho_ten_sv
create view ho_ten_sv
as 
select ho , ten from sinh_vin


select * from ho_ten_sv

-- tao view sinh vien , kem lớp


create view thong_sinh_sv_truongA
as
select sinh_vin.ma , sinh_vin.ho , sinh_vin.ten , sinh_vin.ma_lop , lop.ten as ten_lop
from sinh_vin
join lop
on lop.ma = sinh_vin.ma_lop


select * from thong_sinh_sv_truongA