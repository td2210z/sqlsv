create database otpro
go
use  otpro
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
values(1 , 'LT'),(2 , 'CNTT'),
(3, 'TOAN')

insert into sinh_vin(ma , ho , ten , ma_lop)
values(1 , 'long' ,'nguyen' , 1),
(2 , 'THANG' ,'dinh' , 2),
(3 , 'tam' ,'nguyeen' , 3),
(4 , 'trang' ,'ngu' , 3),
(5 , 'lung' ,'dot' , 2),
(6 , 'ninh' ,'de' , 2)


select * from sinh_vin


drop procedure xem_sinh_vien
create procedure xem_sinh_vien
@ma int = -1
as
begin

     select * from  sinh_vin
	 where ma = @ma or @ma = -1
end

execute xem_sinh_vien



drop procedure hien_thi_sinh_vien
create procedure hien_thi_sinh_vien
@ma int =-1, 
@ho nvarchar(50) , 
@ten nvarchar(50)  , 
@ma_lop int = 1

as
begin
    insert into sinh_vin
	values(@ma, @ho , @ten , @ma_lop)
	select top 1 * from sinh_vin
	order by ma DESC
end

execute hien_thi_sinh_vien  @ho = 'ledn' , @ten = 'nguyen'



drop procedure sua_sinh_vien
create procedure sua_sinh_vien
@ten nvarchar(50) , 
@ma int,
@ma_lop int = -1
as
begin
    execute xem_sinh_vien @ma = @ma

	update sinh_vin
	set
	ten = case when @ten is null then ten else @ten end,
	ma_lop = case when @ma_lop = -1 then ma_lop else @ma_lop end
	where ma = @ma

	execute xem_sinh_vien @ma = @ma
end

execute sua_sinh_vien @ten = 'LICID21' , @ma = 2 , @ma_lop = 1