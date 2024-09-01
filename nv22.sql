--Bài tập tổng hợp kiến thức (sau mỗi 3 buổi mình sẽ đăng 1 bài thế này, các bạn có thể bình luận đáp án ở đây hoặc trên Discord để xem ai có câu trả lời chính xác nhất nhé):

--Sếp yêu cầu bạn thiết kế cơ sở dữ liệu quản lý lương nhân viên

--Với điều kiện:

--mã nhân viên không được phép trùng
--lương là số nguyên dương
--tên không được phép ngắn hơn 2 ký tự
--tuổi phải lớn hơn 18
--giới tính mặc định là nữ
--ngày vào làm mặc định là hôm nay
--(*) nghề nghiệp phải nằm trong danh sách ('IT','kế toán','doanh nhân thành đạt')
--tất cả các cột không được để trống
--Công ty có 5 nhân viên
--Tháng này sinh nhật sếp, sếp tăng lương cho nhân viên sinh tháng này thành 100. (*: tăng lương cho mỗi bạn thêm 100)
--Dịch dã khó khăn, cắt giảm nhân sự, cho nghỉ việc bạn nào lương dưới 50. (*: xoá cả bạn vừa thêm 100 nếu lương cũ dưới 50). (**: đuổi cả nhân viên mới vào làm dưới 2 tháng)
--Lấy ra tổng tiền mỗi tháng sếp phải trả cho nhân viên. (*: theo từng nghề)
--Lấy ra trung bình lương nhân viên. (*: theo từng nghề)
--(*) Lấy ra các bạn mới vào làm hôm nay
--(*) Lấy ra 3 bạn nhân viên cũ nhất
--(**) Tách những thông tin trên thành nhiều bảng cho dễ quản lý, lương 1 nhân viên có thể nhập nhiều lần


create database nv
go
use nv
go


create table nhanvien(
     ma int not null , 
	 luong int not null , 
	 ten nvarchar(50) not null ,
	 tuoi int not null ,
	 gioi_tinh bit default 0 not null ,
	 nghenghiep nvarchar(50) not null ,
	 ngayvaolam date default getdate() not null ,
	 ngay_sinh date not null ,
	 constraint pk_nv primary key(ma),
	 constraint check_luong check(luong>0),
	 constraint check_ten check(len(ten) > 2),
	 constraint check_tuoi check(tuoi > 18) ,
	 constraint check_nghe_nghiep check(nghenghiep in('IT' , 'doanh nhan thanh dat' , 'ke toan'))
)


--Công ty có 5 nhân viên

insert into nhanvien(ma , luong , ten , tuoi , gioi_tinh , nghenghiep , ngayvaolam , ngay_sinh)
values(1 , 500 , 'Van A' , 22 , 0 , 'IT' , '2024-07-06' , '1991-07-01' ),
(2 , 200 , 'Van C' , 25 , 0 , 'ke toan' , '2024-07-06', '2003-01-01' ),
(3 , 100 , 'Van D' , 76 , 0 , 'doanh nhan thanh dat' , '2024-07-06' , '1987-07-01' ),
(4 , 50 , 'Van E' , 19 , 0 , 'ke toan' , '2024-07-06' , '1991-01-01'),
(5 , 25 , 'Van F' , 31 , 0 , 'IT' , '2024-07-06' ,'2004-08-01')



select * from nhanvien


--Tháng này sinh nhật sếp, sếp tăng lương cho nhân viên sinh tháng này thành 100. (*: tăng lương cho mỗi bạn thêm 100)


update nhanvien
set 
luong = luong + 100
where MONTH(ngay_sinh) = MONTH(getdate())


--(*: tăng lương cho mỗi bạn thêm 100)

update nhanvien
set 
luong = luong + 100


----Dịch dã khó khăn, cắt giảm nhân sự, cho nghỉ việc bạn nào lương dưới 50. 
--(*: xoá cả bạn vừa thêm 100 nếu lương cũ dưới 50). (**: đuổi cả nhân viên mới vào làm dưới 2 tháng


delete from nhanvien
where luong < 150


delete from nhanvien
where 
datediff(month , ngayvaolam , GETDATE()) < 2
and ngayvaolam < getdate()




--Lấy ra tổng tiền mỗi tháng sếp phải trả cho nhân viên. (*: theo từng nghề)

select nghenghiep , sum(luong) as tong_luong from nhanvien
group by nghenghiep


----Lấy ra trung bình lương nhân viên. (*: theo từng nghề)

select nghenghiep , avg(luong) as luong_nv from nhanvien
group by nghenghiep

-- dem nhan vien theo tuong ngang ngje 

select nghenghiep , count(luong) as luong_nv from nhanvien
group by nghenghiep


--(*) Lấy ra các bạn mới vào làm hôm nay 


select * from nhanvien
where datediff(day , ngayvaolam , getdate()) = 0


----(*) Lấy ra 3 bạn nhân viên cũ nhất

select * from nhanvien
order by ngayvaolam asc
offset 3 rows
fetch next 1 rows only;




select * from nhanvien
-- ten , ngje ngiep
select ten , nghenghiep , SUM(luong) as Tong_luong from nhanvien
group by ten , nghenghiep

select ten , ngayvaolam  , count(nghenghiep) as so_nv from nhanvien
group by ten ,ngayvaolam

select ten , nghenghiep , avg(luong) as tb_luong from nhanvien
group by ten , nghenghiep

select nghenghiep , count(nghenghiep) as tong_sonvas from nhanvien
group by nghenghiep