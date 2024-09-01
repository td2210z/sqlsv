--Tạo bảng lưu thông tin khách hàng (mã, họ tên, số điện thoại, địa chỉ, giới tính, ngày sinh)

--Thêm 5 khách hàng
--Hiển thị chỉ họ tên và số điện thoại của tất cả khách hàng
--Cập nhật khách có mã là 2 sang tên Tuấn
--Xoá khách hàng có mã lớn hơn 3 và giới tính là Nam
--(*) Lấy ra khách hàng sinh tháng 1
--(*) Lấy ra khách hàng có họ tên trong danh sách (Anh,Minh,Đức) và giới tính Nam hoặc chỉ cần năm sinh trước 2000
--(**) Lấy ra khách hàng có tuổi lớn hơn 18
--(**) Lấy ra 3 khách hàng mới nhất
--(**) Lấy ra khách hàng có tên chứa chữ T
--(***) Thay đổi bảng sao cho chỉ nhập được ngày sinh bé hơn ngày hiện tại

create database thongtinkhachhang
go
use thongtinkhachhang
go


create table khachhang(
     ma int not null , 
	 hoten nvarchar(50) not null , 
	 sdt char(10) ,
	 diachi nvarchar(50) ,
	 gioitinh bit  , 
	 ngaysinh date,
	 constraint pk_kh primary key(ma)
)


--Thêm 5 khách hàng 

insert into khachhang(ma , hoten , sdt , diachi , gioitinh , ngaysinh)
values(1 , N'Thắng' , '21212' , N'Lương Tài - Bắc Ninh' , 1 , '2003-01-01'),
(2 , N'Anh' , '21212' , N'Lương Tài - Bắc Ninh' , 0 , '2001-01-01'),
(3 , N'Minh' , '21212' , N'Lương Tài - Bắc Ninh' , 1 , '1998-01-01'),
(4 , N'Đức' , '21212' , N'Lương Tài - Bắc Ninh' , 0 , '1997-01-10'),
(5 , N'Tùng' , '21212' , N'Lương Tài - Bắc Ninh' , 1 , '2006-10-10')


--Hiển thị chỉ họ tên và số điện thoại của tất cả khách hàng

select hoten, sdt from khachhang


--Cập nhật khách có mã là 2 sang tên Long
--Cập nhật khách có mã là 1 sang tên Trang
--Cập nhật khách có mã là 5 sang tên Anh


update khachhang
set 
hoten = 'Long'
where ma = 2

update khachhang
set
hoten = 'Trang'
where ma = 1

update khachhang
set
hoten = 'Anh'
where ma = 5


--Xoá khách hàng có mã lớn hơn 3 và giới tính là Nam

delete from khachhang
where ma > 3 and gioitinh =1


select * from khachhang

--(*) Lấy ra khách hàng sinh tháng 1

select * from khachhang
where MONTH(ngaysinh) = 1

--(*) Lấy ra khách hàng có họ tên trong danh sách (Anh,Minh,Đức) và giới tính Nam hoặc chỉ cần năm sinh trước 2000

select * from khachhang
where (hoten in('Anh' , 'Minh' , N'Đức') and gioitinh =1) or year(ngaysinh) < 2000


--(**) Lấy ra khách hàng có tuổi lớn hơn 18

select * from khachhang
where (2024 - YEAR(ngaysinh)) <= 18


--select *, diachi as noi_sinh from khachhang


--(**) Lấy ra 3 khách hàng mới nhất

select top 3 * from khachhang
order by ma desc