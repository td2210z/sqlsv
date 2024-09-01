create database dc9
go
use dc9
go


create table dstruong(
     matruong int identity , 
	 tentruong nvarchar(50) , 
	 diachi nvarchar(50) , 
	 constraint pk_ds primary key (matruong)
)

insert into dstruong
values('thpt gia binh 1' , 'nhan thang') , 
('thpt luong tai 1' , 'thi tran thua') ,
('thpt luong tai 2' , 'luong tai'), 
('ttgdtx luong tai' , 'bac ninh')

create table dskhoa(
    MATRUONG int , 
	makhoa int identity , 
	tenkhoa nvarchar(50) , 
	sodt int , 
	constraint pk_khoa primary key (makhoa) , 
	constraint fk_khoa foreign key (MATRUONG) references dstruong(matruong) 
)

insert into dskhoa(MATRUONG , tenkhoa , sodt)
values (1 , 'toantin ' , 123),
(1 , 'toantin' , 333) , 
(2 , 'anh' , 666) , 
(4 , 'the duc' , 11) ,
(3 , 'hoa hoc' , 343)

create table danhsach(
    masv int identity , 
	MAKHOA int , 
	hoten nvarchar(50) , 
	ns date , 
	lop char(10) , 
	hocbong char(50) , 
	constraint pk_d primary key (masv) , 
	constraint fk_d foreign key (MAKHOA) references dskhoa(makhoa)
)

insert into danhsach
values(1 ,  'van lang' , '1992-01-01' , 'tin hoc' , 'Y'), 
(2 ,'hoc di' , '2020-01-01' , 'hoa hoc' , 'Y'),
(3 , 'hust' , '1998-01-01' , 'tin hoc' , 'N'),
(4 , 'newyork' , '2021-01-01' , 'anh van' , 'N')


create table bangdiem(
      MASV int , 
	  d1 float , 
	  d2 float  ,
	  d3 float , 
	  d4 float , 
	  dientb float default NULL ,
	  constraint fk_diem1 foreign key (MASV) references danhsach(masv) 
)

insert into bangdiem(MASV , d1 , d2 , d3 , d4)
values(1 , 4.4  , 3.4 , 5.6 , 4.3), 
(2 , 9.7 , 2.4 , 4.5 , 4.8), 
(3 , 8.8 , 7.7 , 5.5 , 8.7), 
(4 , 2.2 , 1.3 , 5.6 , 7.8)



select * from bangdiem
update bangdiem
set
dientb = (d1 + d2 + d3+ d4) /4

select masv , hoten , lop , hocbong
from danhsach 
WHERE (lop LIKE N'%tin hoc%' OR lop LIKE N'%hoa hoc%')