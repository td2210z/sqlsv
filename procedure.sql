create database pro_cedure
go
use pro_cedure
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




drop procedure thong_tin_sinh_vien
create procedure thong_tin_sinh_vien
@ma int , 
@ho nvarchar(50), 
@ten nvarchar(50) , 
@ma_lop int
as 
begin
   insert into sinh_vin(ma , ho , ten , ma_lop)
   values(@ma , @ho , @ten , @ma_lop)

   select top 1 * from sinh_vin
   order by ma desc
end


execute thong_tin_sinh_vien @ma = 11, @ho ='van' , @ten = 'anh' , @ma_lop = 1

-- xem sinh vien va sua sinh vien

create procedure xem_sinh_vien
@ma int =-1
as
begin
   select * from sinh_vin
   where ma = @ma or @ma =-1
end

xem_sinh_vien



drop procedure sua_sinh_vien
create procedure sua_sinh_vien
@ma int ,
@ten nvarchar(50),
@ma_lop int = 0
as
begin
    execute xem_sinh_vien @ma = @ma
	update sinh_vin
	set
	ten = @ten,
    ma_lop = case when @ma_lop = 0 then ma_lop else @ma_lop end
	where ma = @ma

	execute xem_sinh_vien @ma = @ma
end


sua_sinh_vien @ma = 3 , @ten ='pham dinh' , @ma_lop = 0



create procedure xoa_sinh_vien
@ma int
as
begin
   execute xem_sinh_vien @ma = @ma
   delete from sinh_vin
   where ma = @ma
end


xoa_sinh_vien @ma = 1

