--Tạo bảng lưu thông tin điểm của sinh viên (mã, họ tên ,số điện thoại, địa chỉ, giới tính, ngày sinh, điểm lần 1, điểm lần 2)

--Với điều kiện:
--Thêm 10 học sinh
--Hiển thị chỉ họ tên và số điện thoại của tất cả sinh viên
--Cập nhật sinh viên có mã là 2 sang tên Tuấn
--Xoá sinh viên có mã lớn hơn 3 và giới tính là Nam
--(*) Lấy ra khách hàng sinh tháng 1
--(*) Lấy ra khách hàng có họ tên trong danh sách (Anh,Minh,Đức) và giới tính Nam hoặc chỉ cần năm sinh trước 2000
--(**) Lấy ra khách hàng có tuổi lớn hơn 18
--(**) Lấy ra 3 khách hàng mới nhất
--(**) Lấy ra khách hàng có tên chứa chữ T



--điểm không được phép nhỏ hơn 0 và lớn hơn 10
--điểm lần 1 nếu không nhập mặc định sẽ là 5
--(*) điểm lần 2 không được nhập khi mà điểm lần 1 lớn hơn hoặc bằng 5
--(**) tên không được phép ngắn hơn 2 ký tự
--Điền 5 sinh viên kèm điểm
--Lấy ra các bạn điểm lần 1 hoặc lần 2 lớn hơn 5
--Lấy ra các bạn qua môn ngay từ lần 1
--Lấy ra các bạn trượt môn
--(*) Đếm số bạn qua môn sau khi thi lần 2
--(**) Đếm số bạn cần phải thi lần 2 (tức là thi lần 1 chưa qua nhưng chưa nhập điểm lần 2)



--mã, họ tên ,số điện thoại, địa chỉ, giới tính, ngày sinh, điểm lần 1, điểm lần 2


create database qlsv
go 
use qlsv
go



create table sinhvien(
     ma int not null , 
	 username nvarchar(50) , 
	 sdt char(10) ,
	 adress nvarchar(50) ,
	 sex bit ,
	 birthday date,
	 diemlan1 float ,
	 diemlan2 float,
	 constraint pk_sv primary key (ma)
)

--Thêm 10 học sinh


insert into sinhvien(ma , username , sdt , adress ,sex , birthday , diemlan1 , diemlan2)
values(1 , N'Thắng' , '111222' , N'Lương Tài - Bắc Ninh' , 1 , '1999-01-21' , 6.7 ,8.8),
(2 , N'Ánh' , '111332' , N'Gia Bình - Bắc Ninh' , 0 , '2001-10-21' , 9.7 ,9.8),
(3 , N'Thanh' , '333222' , N'Từ Sơn - Bắc Ninh' , 1 , '1997-01-22' , 6.7 ,8.8),
(4 , N'Anh' , '188222' , N'Lương Tài - Bắc Ninh' , 1 , '1992-01-21' , 2.6 ,4.5),
(5 , N'Minh' , '111222' , N'Lương Tài - Bắc Ninh' , 1 , '2007-01-21' , 7.7 ,9.8),
(6, N'Đức' , '888222' , N'Lương Tài - Bắc Ninh' , 1 , '2009-01-21' , 7.8 ,9.8),
(7 , N'Trúc' , '111222' , N'Lương Tài - Bắc Ninh' , 0 , '2003-11-21' , 9.9 ,8.8),
(8 , N'Đàm' , '111222' , N'Lương Tài - Bắc Ninh' , 0 , '2010-01-21' , 3.7 ,4.8),
(9 , N'Mèo' , '3333222' , N'Lương Tài - Bắc Ninh' , -0 , '2011-01-21' , 6.7 ,7.1),
(10, N'Thắng' , '111222' , N'Lương Tài - Bắc Ninh' , 1 , '1999-01-21' , 6.7 ,8.8)


--Hiển thị chỉ họ tên và số điện thoại của tất cả sinh viên


select *, birthday as Ngay_sinh from sinhvien


--Cập nhật sinh viên có mã là 2 sang tên Tuấn

update sinhvien
set
username = N'Tuấn'
where ma = 2


select * from sinhvien


--Xoá sinh viên có mã lớn hơn 3 và giới tính là Nam

delete from sinhvien
where ma >3 and sex = 1

--(*) Lấy ra khách hàng sinh tháng 1

select * from sinhvien
where MONTH(birthday) =1



--(*) Lấy ra khách hàng có họ tên trong danh sách (Anh,Minh,Đức) và giới tính Nam hoặc chỉ cần năm sinh trước 2000


select * from sinhvien
where (username in('Anh' , 'Minh' ,N'Đức') and sex =1 ) or YEAR(birthday) < 2000


--(**) Lấy ra khách hàng có tuổi lớn hơn 18

select * from sinhvien
where (2024 - YEAR(birthday)) >18



--(**) Lấy ra 3 khách hàng mới nhất

select top 3 * from sinhvien
order by ma DESC


--(**) Lấy ra khách hàng có tên chứa chữ T


select * from sinhvien
where username LIKE N'T%'

-- them bang nguoi yeeu 


--điểm không được phép nhỏ hơn 0 và lớn hơn 10

alter table sinhvien
add constraint check_diem check(diemlan1 >=0 and diemlan1 < 10 and diemlan2 >=0 and diemlan2 < 10)


--(*) điểm lần 2 không được nhập khi mà điểm lần 1 lớn hơn hoặc bằng 5

alter table sinhvien
add constraint check_diem_lan2 check((diemlan1 >= 5 and diemlan2 is null) or diemlan1 < 5)


--(**) tên không được phép ngắn hơn 2 ký tự

alter table sinhvien
add constraint checkten check(len(username) >= 2)




--Lấy ra các bạn điểm lần 1 hoặc lần 2 lớn hơn 5


select * from sinhvien
where diemlan1 >=5 or diemlan2 >=5


--Lấy ra các bạn qua môn ngay từ lần 1



select * from sinhvien
where diemlan1 >= 5



--Lấy ra các bạn trượt môn

select * from sinhvien
where diemlan1 < 5 or diemlan2 < 5


--(*) Đếm số bạn qua môn sau khi thi lần 2

select count(*) from sinhvien
where diemlan1 >= 5 or diemlan2 >=5


--(*) Đếm số bạn trượt lần 1 và qua môn sau lần 2

select count(*)  as cac_ban_qua_mon_lan2 from sinhvien
where diemlan2 >= 5


--(**) Đếm số bạn cần phải thi lần 2 (tức là thi lần 1 chưa qua nhưng chưa nhập điểm lần 2)


select count(*) as thi_qua_lan2 from sinhvien
where diemlan1 < 5 and diemlan2 is null

-- lấy sinh viên có điểm lần 2

select * from sinhvien
where diemlan2 is not null

-- dem so sinh vien qua mon lan 2


select count(*) as check_diem_cac_ban from sinhvien
where diemlan2 is not null


-- dem so diem lan 2
select count(diemlan2) as so_sinh_vien from sinhvien

select diemlan2 from sinhvien

-- tinh tong diem lan 1 va diem lan 2
select sum(diemlan1) as tong_diem_lan1 from sinhvien
select sum(diemlan2) as tong_diem_lan2 from sinhvien

-- tinh diem trung binh lan 1 va 2
select avg(diemlan1) as trung_binh_tong_lan1 from sinhvien
select avg(diemlan2) as trung_binh_tong_lan2 from sinhvien

