--Ban lãnh đạo thành phố yêu cầu bạn tạo bảng lưu các con vật trong sở thú

--Với điều kiện tự bạn quy ước (hãy áp dụng check và default)

--Sở thú hiện có 7 con
--Thống kê có bao nhiêu con 4 chân
--Thống kê số con tương ứng với số chân
--Thống kê số con theo môi trường sống
--Thống kê tuổi thọ trung bình theo môi trường sống
--Lấy ra 3 con có tuổi thọ thọ cao nhất
--(*) Tách những thông tin trên thành 2 bảng cho dễ quản lý (1 môi trường sống gồm nhiều con)

-- tao 2 bang moi trong song gom : ma , ten 
-- bang dong vat gom : ma , ten , tuoi tho, sochan ,  mamoitruongsong  check ten > 2 , tuoi > 10 , 


create database animal
go
use animal
go

create table moi_truong_song(
    mamoitruong int not null , 
	ten_moi_truong nvarchar(50) not null,
	constraint pk_mt primary key (mamoitruong)
)


insert into moi_truong_song(mamoitruong , ten_moi_truong)
values(1 , 'Duoi Nuoc') , (2,'Tren can')

select * from moi_truong_song



create table dv(
    ma int not null , 
	ten nvarchar(50) not null , 
	tuoitho int not null , 
	sochan int not null , 
	ma_mts int not null,
	constraint pk_dv primary key (ma),
	constraint fk_dv foreign key (ma_mts) references moi_truong_song(mamoitruong)

)
alter table dv
add constraint check_ten check(len(ten) >2)

alter table dv
add constraint check_tuoi_tho check(tuoitho > 0)

alter table dv
add constraint check_so_chan check(sochan > 0 and sochan < 100)


--Sở thú hiện có 7 con

insert into dv(ma , ten , tuoitho , sochan , ma_mts)
values(1 , 'con ga' , 11 , 2 , 1),
(2 , 'con ca sau' , 12 , 4 , 2),
(3 , 'con ca map' , 13 , 2 , 2),
(4 , 'con chim' , 10 , 2 , 1),
(5 , 'con coc' , 11 , 4 , 1),
(6 , 'con ech' , 12 , 4 , 2),
(7 , 'con capybara' , 11 , 4 , 2),
(8 , 'con canh cut' , 17 , 2 , 1)


insert into dv(ma , ten , tuoitho , sochan , ma_mts)
values(9 , 'con ok' , 11 , 2 , 1)
select * from dv

--Thống kê có bao nhiêu con 4 chân

select count(sochan) as tong_so_chan from dv
where sochan = 4

select ma_mts , count(*) as sochan from dv
where sochan = 4
group by ma_mts

-- thong ke co bao nhieu con 2 chan

select ma_mts , count(*) as so_chan from dv
group by ma_mts
having sochan = 2


-- --Thống kê số con tương ứng với số chân
select ten , sochan from dv
where sochan = 2

select ten as ten_dv, sochan from dv
where sochan =4 

select ma_mts , count(*) as tong_so from dv
group by ma_mts


-- --Thống kê tuổi thọ trung bình theo môi trường sống


select ma_mts , avg(tuoitho) as tuoi_trung_binh from dv
group by ma_mts


----Lấy ra 3 con có tuổi thọ thọ cao nhất


select top 3 * from dv
order by tuoitho desc


-- Tách những thông tin trên thành 2 bảng cho dễ quản lý (1 môi trường sống gồm nhiều con)

select ma, ten , tuoitho , sochan , ten_moi_truong
from dv
join moi_truong_song
on dv.ma_mts = moi_truong_song.mamoitruong
