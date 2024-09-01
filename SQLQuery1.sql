create database fuc
go
use fuc
go


create table sinh_vien(
    ma int identity , 
	ten nvarchar(50) , 
	gt bit , 
	ns date ,
	constraint pk_sv primary key (ma)
)

insert into sinh_vien
values('thang' , 1 , '2012-01-01') ,
('pham' , 0 , '2003-10-22')

select * from sinh_vien



select 
ma ,
ten ,
dbo.lay_ra_tuoi(ns) as tuoi , 
dbo.xem_gioi_tinh(gt) as ten_gt
from sinh_vien

create function xem_gioi_tinh(@gt bit )
returns nvarchar(50)
as
begin
    return case
	when @gt = 1
	then 'nam'
	else 'nu'
	end
end


create function cong(@a int , @b int) 
returns int 
as
begin
    return @a + @b
end


create function tru(@a int , @b int)
returns int 
as
begin
    return case 
	when @a > @b then @a - @b
	else @b - @a
	end
end

create function nhan(@a int , @b int )
returns int
as
begin 
     return @a * @b
end

create function chia(@a int, @b int) 
returns float
as
begin 
     return case when
	 @a % @b = 0 then @a/@b
	 else 0
	 end
end

create function lay_ra_tuoi(@ns date)
returns int 
as
begin
    return datediff(year , @ns , getdate())
end



create function fuc_xem_sv(@ma int)
returns table
return
select * from sinh_vien
where ma = @ma

select * from fuc_xem_sv(2)


select * from sinh_vien
where  dbo.lay_ra_tuoi(ns) - 18 > 0

select dbo.cong(5 , 12) as tong_so
select dbo.tru(6, 1) as tong_tru
select dbo.nhan(2 , 7) as tong_nhan
select dbo.chia(12 , 12) as tong_chuia