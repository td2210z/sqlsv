create database pco2
go
use pco2
go


create table lop(
     malop int identity , 
	 tenlop nvarchar(50) , 
	 constraint pk_l primary key (malop)
)

create table sinh_vien(
     ma int identity , 
	 ten nvarchar(50) , 
	 gt bit , 
	 ma_lop int ,
	 constraint pk_sv primary key (ma) , 
	 constraint fk_sv foreign key (ma_lop) references lop(malop)
)


insert into lop
values('hacker') , ('attt') , ('lap trinh')

insert into sinh_vien
values('thang' , 1 , 1) , ('pham' , 0 , 2) , ('tun' , 1 , 3) , ('jayce' , 1 , 1)


--xem_sinh_vien: hiển thị thông tin sinh viên kèm lớp. Có thể truyền vào mã lớp hoặc mã sinh viên để lọc

create procedure xem
@ma int = -1
as
begin
    select sinh_vien.ma , sinh_vien.ten , sinh_vien.gt , sinh_vien.ma_lop , lop.tenlop
	from sinh_vien
	left join lop
	on lop.malop = sinh_vien.ma_lop
	where ma = @ma or @ma = -1
end

execute xem


create procedure xem_sinh_vien
@ma int  = -1, 
@ma_lop int = -1
as
begin
      select * from sinh_vien
	  where ma = @ma or @ma = -1
end


execute xem_sinh_vien

--them_sinh_vien: thêm sinh viên rồi hiển thị lại
--thông tin sinh viên đó. Có thể không cần truyền giới tính
--(*: không cần truyền cả mã lớp, mã sẽ lấy mặc định lớp mới nhất)

create procedure them1
@ten nvarchar(50),
@gt bit = 1,
@ma_lop int = -1
as
begin
     insert into sinh_vien(ten , gt , ma_lop)
	 values(@ten , @gt , @ma_lop)

	 select * from sinh_vien
end

execute them1 @ten = 'vu' , @gt = 0 , @ma_lop = 2


--không cần truyền cả mã lớp, mã sẽ lấy mặc định lớp mới nhất
create procedure them2
@ten nvarchar(50) , 
@gt bit = 1, 
@ma_lop int ,
as
begin
    insert into sinh_vien(ten ,gt)
	values(@ten , @gt)


	select * from sinh_vien
end

execute them2  @ten = 'pham' , @gt = 0

-- sua_sinh_vien: sửa thông tin sinh viên

create procedure sua_sinh_vien
@ma int  = -1 , 
@ten nvarchar(50), 
@gt bit = -1, 
@ma_lop int = -1
as
begin
      execute xem_sinh_vien


	update sinh_vien
	set 
	ten = @ten ,
	gt = case when @gt = -1 then gt else @gt end,
	ma_lop = case when @ma_lop = -1 then ma_lop else @ma_lop end
	where 
	ma = @ma

	execute xem_sinh_vien

     
end

execute sua_sinh_vien @ma = 2 , @ten ='thangdepzai' , @gt =  1 , @ma_lop = 3

drop procedure xoasv
create procedure xoasv
@ma int =-1 

as
begin
    execute xem
    delete sinh_vien
	where ma = @ma
	execute xem
end


execute xoasv @ma = 2



