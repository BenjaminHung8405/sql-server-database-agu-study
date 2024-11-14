create database QLSVien
on(
name = 'QLSVien_dat',
filename = 'D:\Study\CSDL\sql-server-database-agu-study\QlSVdata.mdf',
size = 8,
maxsize = 64,
filegrowth = 2
)

log on( 
name = 'QLSVien_log',
filename = 'D:\Study\CSDL\sql-server-database-agu-study\QlSVlog.ldf',
size = 8,
maxsize = 64,
filegrowth = 2
)
use QLSVien



---------------------CREATE TABLE---------------------

-- Tạo bảng SINHVIEN
CREATE TABLE SINHVIEN (
    MaSV CHAR(5) NOT NULL,
    HoLot NVARCHAR(30) NOT NULL,
    Ten NVARCHAR(10) NOT NULL,
    NgSinh DATE NOT NULL,
    GioiTinh CHAR(1) CHECK (GioiTinh IN ('M', 'F')),
    Lop CHAR(4) NOT NULL,
    MaGV_CN CHAR(5),
	CONSTRAINT pk_SINHVIEN PRIMARY KEY(MaSV)
	)

	--------Tạo Khóa Chính, Khóa Ngoại và Đặt Tên Ngay Trong Khi Tạo TABLE--------

-- Tạo bảng GIANGVIEN
CREATE TABLE GIANGVIEN (
    MaGV CHAR(5) NOT NULL,
    HoTenGV NVARCHAR(40) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    DiaChi NVARCHAR(100),
    SoDienThoai CHAR(10),
    MaKhoa CHAR(5),
	CONSTRAINT pk_GIANGVIEN PRIMARY KEY(MaGV)
)
	--------Tạo Khóa Chính, Khóa Ngoại và Đặt Tên Ngay Trong Khi Tạo TABLE--------

-- Tạo bảng KHOA
CREATE TABLE KHOA (
    MaKhoa CHAR(5) NOT NULL,
    TenKhoa NVARCHAR(50) NOT NULL,
	CONSTRAINT pk_KHOA PRIMARY KEY(MaKhoa)
)

	--------Tạo Khóa Chính, Khóa Ngoại và Đặt Tên Ngay Trong Khi Tạo TABLE--------
-- Tạo bảng MON
CREATE TABLE MON (
    MaMon CHAR(5) NOT NULL,
    TenMon NVARCHAR(50) NOT NULL,
    SoTC INT CHECK (SoTC > 0),
    Nhom CHAR(2) CHECK (Nhom IN ('TC', 'BB', 'BBĐK')),
	CONSTRAINT pk_MON PRIMARY KEY(MaMon)
)

	--------Tạo Khóa Chính, Khóa Ngoại và Đặt Tên Ngay Trong Khi Tạo TABLE--------

	--CONSTRAINT pk_MON PRIMARY KEY(MaMon)

-- Tạo bảng DAY
CREATE TABLE DAY (
    MaGV CHAR(5)NOT NULL,
    MaMon CHAR(5)NOT NULL,
    HocKy CHAR(5),
    NamHoc CHAR(9),
	CONSTRAINT pk_DAY PRIMARY KEY(MaGV,MaMon)
)

	--------Tạo Khóa Chính, Khóa Ngoại và Đặt Tên Ngay Trong Khi Tạo TABLE--------

    --CONSTRAINT pk_DAY PRIMARY KEY(MaGV,MaMon),
	--CONSTRAINT pk_MON_DAY FOREIGN KEY(MaMon) REFERENCES MON(MaMon),
	--CONSTRAINT pk_GIANGVIEN_DAY FOREIGN KEY(MaGV) REFERENCES GIANGVIEN(MaGV)

-- Tạo bảng KETQUA
CREATE TABLE KETQUA (
    MaSV CHAR(5) NOT NULL,
    MaMon CHAR(5) NOT NULL,
    NgayThi DATE,
    PhongThi NVARCHAR(20),
    DiemThi FLOAT CHECK (DiemThi >= 0 AND DiemThi <= 10),
    LanThi INT CHECK (LanThi > 0),
    Vang BIT,
	CONSTRAINT pk_KETQUA PRIMARY KEY(MaSV,MaMon)
) -- 1: Vắng mặt, 0: Có mặt

	--------Tạo Khóa Chính, Khóa Ngoại và Đặt Tên Ngay Trong Khi Tạo TABLE--------

	--CONSTRAINT pk_KETQUA PRIMARY KEY(MaSV,MaMon),
	--CONSTRAINT pk_MON_KETQUA FOREIGN KEY(MaMon) REFERENCES MON(MaMon),
	--CONSTRAINT pk_SINHVIEN_KETQUA FOREIGN KEY(MaSV) REFERENCES SINHVIEN(MaSV)

           
---------------------CREATE FOREIGN KEY Sau Khi Đã Tạo TABLE---------------------


							--**SinhVien**--
ALTER TABLE SINHVIEN
ADD CONSTRAINT fk_GIANGVIEN_SINHVIEN
FOREIGN KEY (MaGV_CN) REFERENCES GIANGVIEN(MaGV);
							--**GiangVien**--
ALTER TABLE GIANGVIEN
ADD CONSTRAINT fk_KHOA_GIANGVIEN
FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa);

							--**Day**--
ALTER TABLE DAY
ADD CONSTRAINT fk_MON_DAY
FOREIGN KEY (MaMon) REFERENCES MON(MaMon); 

ALTER TABLE DAY
ADD CONSTRAINT fk_GIANGVIEN_DAY
FOREIGN KEY (MaGV) REFERENCES GIANGVIEN(MaGV);

							--**KetQua**--
ALTER TABLE KETQUA
ADD CONSTRAINT fk_MON_KETQUA
FOREIGN KEY (MaMon) REFERENCES MON(MaMon); 

ALTER TABLE KETQUA
ADD CONSTRAINT fk_SINHVIEN_KETQUA
FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV);


---------------------INSERT TO TABLE---------------------

--Insert To Sinh Viên
insert into SINHVIEN values ('S001', N'Nguyễn Hồng',N'Sơn','2021-2-7','M','DA2','A311')
insert into SINHVIEN values ('C010', N'Mộ Dung',N'Phục', '2021-9-8', 'M','NN1','A111')
insert into SINHVIEN values ('C011', N'Đông Phương',N'Bất Bại', '2002-2-17', 'F','TH1','B003')
insert into SINHVIEN values ('C312', N'Tô Tiểu',N'Mễ', '2002-5-16', 'F','NN2','A111')
insert into SINHVIEN values ('S002', N'Âu Dương',N'Phong', '2002-9-1', 'M','DL2','C000')
insert into SINHVIEN values ('S004', N'Hoàng Dược',N'Sư', '2002-7-25', 'M','TH2','B003')
insert into SINHVIEN values ('C113', N'Liễu Vô',N'Sư', '2002-5-5', 'F','DA1','A311')
insert into SINHVIEN values ('S030', N'Nguyễn Hoàng',N'Bân', '2002-2-1', 'M','TA1','A123')
select * from SINHVIEN

--Insert To Giảng Viên
insert into GIANGVIEN values ('B003', N'Tiểu Hoàng Dung', 'THD@gmail.com','42 PTH','0345777825','CNTT')
insert into GIANGVIEN values ('S003', N'Hồng Thất Công', 'HTC@gmail.com','67 NH','0658929384','NN')
insert into GIANGVIEN values ('A123', N'Vi Tiểu Bảo', 'VTB@gmail.com','55A CVL','0356234446','SP')
insert into GIANGVIEN values ('A111', N'Chu Bá Thông', 'CBT@gmail.com','99 NH','0112343565','NN')
insert into GIANGVIEN values ('C120', N'Lý Hoàng Dục', 'LHT@gmail.com','47B TDT','0344155344','CNTT')
insert into GIANGVIEN values ('C000', N'Anh Ba Ngọc Sơn', 'A3NS@gmail.com','113B BVD','0983437661','DL')
insert into GIANGVIEN values ('A311', N'Tô Tiểu Vi', 'TTV@gmail.com','PJDJ','0123456789','DA')

--Insert To Khoa
insert into KHOA values ('CNTT',N'Công Nghệ Thông Tin')
insert into KHOA values ('SP',N'Sư Phạm')
insert into KHOA values ('DA',N'Điện Ảnh')
insert into KHOA values ('NN',N'Nông Nghiệp')
insert into KHOA values ('DL',N'Du Lịch')

--Insert To Môn
insert into MON values ('COS31',N'Cấu Trúc Dữ Liệu',4,'TC')
insert into MON values ('COS32',N'Lập Trình Hướng Đối Tượng',4,'TC')
insert into MON values ('COS30',N'Tiếng Anh 3',3,'BB')
insert into MON values ('COS33',N'Hướng Dẫn',2,'TC')
insert into MON values ('SOS33',N'Tài Nguyên Và Môi Trường',3,'BB')
insert into MON values ('TAA40',N'Nhập Vai',4,'TC')
insert into MON values ('SPP34',N'Đại Cương Tuyến Tính',4,'BB')
SELECT * from MON
--Insert To DAY
insert into DAY values ('B003','COS31',1,'2023-2024')
insert into DAY values ('A123','COS30',2,'2024-2025')
insert into DAY values ('A111','SOS33',1,'2023-2024')
insert into DAY values ('C000','COS33',3,'2024-2025')
insert into DAY values ('A311','TAA40',4,'2023-2025')
insert into DAY values ('A123','SPP34',2,'2023-2024')

--Insert To Kết Quả
insert into KETQUA values ('S001','TAA40','2024-11-27',N'Số 6',7.5,1,0)
insert into KETQUA values ('C010','SOS33','2024-11-25',N'Số 5',8,2,0)
insert into KETQUA values ('C011','COS32','2024-11-26',N'Số 3',9,1,0)
insert into KETQUA values ('C312','SOS33','2024-11-25',N'Số 5',6,1,0)
insert into KETQUA values ('S002','COS33','2024-11-28',N'Số 2',8.3,2,0)
insert into KETQUA values ('S001','COS31','2024-11-24',N'Số 3',9.5,1,0)
insert into KETQUA values ('C113','TAA40','2024-11-27',N'Số 6',0,1,1)
insert into KETQUA values ('S030','COS30','2024-11-22',N'Số 1',8.8,1,0)

--Truy vấn dữ liệu
SELECT TOP 1 m.TenMon, COUNT(kq.MaSV) AS SoLuongSinhVienDat
FROM MON m
INNER JOIN KETQUA kq ON m.MaMon = kq.MaMon
WHERE kq.DiemThi >= 5
GROUP BY m.TenMon
ORDER BY SoLuongSinhVienDat DESC;

--Tạo tài khoản user12, pass 122--
USE master;
GO
CREATE LOGIN user12
	   WITH PASSWORD = '122',
	   CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF,
	   DEFAULT_DATABASE = QLSV;
GO

USE QLSV
GO
CREATE USER user12
	FOR LOGIN user12
GO
--Xóa tài khoản user 12--

DROP USER user12

--Gán quyền thêm xóa sửa trong bảng GIANGVIEN cho user12--

USE QLSVien
GO
GRANT UPDATE,INSERT,DELETE,Select
ON GIANGVIEN TO user12;
GO
