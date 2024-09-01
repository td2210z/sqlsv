create database bt_produ
go
use bt_produ
go


create table lop(
    ma int identity,
	tenlop nvarchar(50) ,
	constraint pk_lop primary key (ma)
)

insert into lop( tenlop)
values('LT') , ( 'Toan'),( 'hacker')

select * from lop


create table sinh_vien(
    masv int identity,
	ten nvarchar(50),
	gioi_tinh bit , 
	ma_lop int,
	constraint pk_sv primary key (masv),
	constraint fk_sv foreign key (ma_lop) references lop(ma)
)

insert into sinh_vien(ten , gioi_tinh , ma_lop)
values('thang' , 1, 1),
('nguyenb' , 0, 2),
('dinh' , 1, 2),
('tam' , 0, 3),
('anh' , 0, 3)

select * from sinh_vien

-- xem sinh vien , them sinh vien , sua sinh vien , xoa sinh vien

drop procedure xem_sinh_vien
create procedure xem_sinh_vien
@masv int = -1
as
begin
   select * from sinh_vien
   where masv = @masv or @masv = -1
end


xem_sinh_vien

--them sinh vien

create procedure them_sinh_vien
@ten nvarchar(50),
@gioi_tinh bit = 0,
@ma_lop int = -1
as
begin

    insert into sinh_vien(ten , gioi_tinh , ma_lop)
	values(@ten , @gioi_tinh, @ma_lop)
end


them_sinh_vien @ten= 'Pham' , @gioi_tinh =1 , @ma_lop = 2


--sua sinh vien
drop proceudre sua_sinh_vien 
create procedure sua_sinh_vien
@masv int= -1,
@ten nvarchar(50) ,
@gioi_tinh bit = 0,
@ma_lop int =-1
as
begin
    execute xem_sinh_vien @masv = @masv

	update sinh_vien
	set
	ten = @ten
	where masv = @masv


	execute xem_sinh_vien @masv = @masv
end

sua_sinh_vien @masv = 2, @ten = 'Tien'


-- xoa sinh vien


drop procedure xoa_sinh_vien
create procedure xoa_sinh_vien
@masv int = -1

as
begin
    execute xem_sinh_vien

	delete from sinh_vien
	where masv = @masv
end

xoa_sinh_vien @masv = 1


