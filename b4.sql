create database dc4
use dc4


create table khach_hang(
    makh int identity , 
	tenkh nvarchar(50) , 
	diachi nvarchar(50),
	loaikh nvarchar(50) , 
	constraint pk_kh primary key (makh)
)
insert into khach_hang
values('van a' , 'ha noi' , 'ca nhan') , ('mo be bank' , 'can tho' , 'doanh nghiep') ,
('van c' , 'bac ninh' , 'ca nhan')

create table dien_thoai(
    sodt int , 
	MAKH int ,
	loaidt nvarchar(50) , 
	sohd int ,
	constraint pk_dt primary key (sodt) ,
	constraint fk_dr foreign key (MAKH) references khach_hang(makh)

)

insert into dien_thoai
values(34565 , 1 , 'vo tuyen' , 333),(1234 , 2 , 'day cap' , 222) , (9999 , 3 , 'day cap' , 121)


create table dich_vu(
     madv int identity,
	 tendv nvarchar(50) ,
	 constraint pk_dv primary key (madv)
)

insert into dich_vu
values('viettheo') , ('vinataba') , ('thang long')



create table dang_ky(
    MADV int , 
	SODT int ,
	constraint fk_dk foreign key(MADV) references dich_vu(madv),
	constraint fk_dk1 foreign key (SODT) references dien_thoai(sodt),

)

insert into dang_ky
values (1 ,34565 ) , (2 ,1234 ) , (3,  9999)

-- danh sách khách hàng (mã , tên ) khi lắp đặt điệm thoa=ị loại day cap)

select khach_hang.tenkh , khach_hang.makh , dien_thoai.loaidt
from khach_hang
left join dien_thoai
on dien_thoai.MAKH = khach_hang.makh
where dien_thoai.loaidt like N'%day cap%'

-- voi moi dich vu khach hang dang ki , hay cho biet madv , ten dv , va tong so diem thoai dc dk

select dich_vu.madv , dich_vu.tendv , count(SODT) as tong_so
from dich_vu
inner join dang_ky
on dang_ky.MADV = dich_vu.madv
group by dich_vu.madv , dich_vu.tendv