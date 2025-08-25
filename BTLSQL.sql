-- Tạo database QuanLyNhanVien và sử dụng database
CREATE DATABASE QuanLyNhanVien
GO
USE QuanLyNhanVien
GO

-- Tạo bảng Phòng Ban 
CREATE TABLE tblPhongBan 
(
    sMaPB NVARCHAR(10) PRIMARY KEY NOT NULL,
    sTenPB NVARCHAR(30) NULL,
    sDiaChi NVARCHAR(20) NULL,
    sSDTPB NVARCHAR(15) NULL
);

-- Tạo bảng Dự Án và ràng buộc
CREATE TABLE tblDuAn 
(
    sMaDA NVARCHAR(10) PRIMARY KEY NOT NULL,
    sTenDA NVARCHAR(30) NULL,
	sDiaDiem NVARCHAR(20) NULL,
	dNgayBD DATETIME NULL,
	sMaPB NVARCHAR(10) NULL,
	CONSTRAINT FK_DuAn_PhongBan
	FOREIGN KEY (sMaPB) REFERENCES tblPhongBan(sMaPB),
	CONSTRAINT CHK_dNgayBD CHECK(dNgayBD <= GETDATE())
);

-- Tạo bảng Chức Vụ
CREATE TABLE tblChucVu 
(
    sMaCV NVARCHAR(10) PRIMARY KEY NOT NULL,
    sTenCV NVARCHAR(30) NULL
);

-- Tạo bảng Lương và ràng buộc
CREATE TABLE tblLuong 
(
    iBacLuong INT PRIMARY KEY NOT NULL,
    fLuongCB FLOAT NULL,
    fHeSoLuong FLOAT NULL,
    fHSPC FLOAT NULL,
	CONSTRAINT CHK_fLuongCB CHECK(fLuongCB > 0),
	CONSTRAINT CHK_fHeSoLuong CHECK(fHeSoLuong > 0),
	CONSTRAINT CHK_HSPC CHECK(fHSPC > 0)
);

-- Tạo bảng Nhân Viên và ràng buộc
CREATE TABLE tblNhanVien 
(
    sMaNV NVARCHAR(10) PRIMARY KEY NOT NULL,
    sHoTen NVARCHAR(30) NULL,
	sGioiTinh NVARCHAR(5) NULL,
    dNgaySinh DATETIME NULL,
    sQueQuan NVARCHAR(20) NULL,
    sSDT NVARCHAR(15) NULL,
    sMaPB NVARCHAR(10) NULL,
    sMaCV NVARCHAR(10) NULL,
    iBacLuong INT,
	CONSTRAINT FK_NhanVien_PhongBan
    FOREIGN KEY (sMaPB) REFERENCES tblPhongBan(sMaPB),
	CONSTRAINT FK_NhanVien_ChucVu
    FOREIGN KEY (sMaCV) REFERENCES tblChucVu(sMaCV),
	CONSTRAINT FK_NhanVien_BacLuong
    FOREIGN KEY (iBacLuong) REFERENCES tblLuong(iBacLuong)
);

-- Tạo bảng Phân Công và ràng buộc
CREATE TABLE tblPhanCong 
(
    sMaDA NVARCHAR(10) NULL,
	sMaNV NVARCHAR(10) NULL,
    dNgayLamDA DATETIME NULL,
	CONSTRAINT FK_PhanCong_DuAn
	FOREIGN KEY (sMaDA) REFERENCES tblDuAn(sMaDA),
	CONSTRAINT FK_PhanCong_NhanVien
	FOREIGN KEY (sMaNV) REFERENCES tblNhanVien(sMaNV),
	CONSTRAINT CHK_dNgayLamDA CHECK(dNgayLamDA <= GETDATE())
);

-- Tạo bảng Hợp Đồng Lao Động và ràng buộc
CREATE TABLE tblHopDongLaoDong 
(
    sMaHD NVARCHAR(10) PRIMARY KEY NOT NULL,
    sMaNV NVARCHAR(10) NULL,
    sLoaiHD NVARCHAR(30) NULL,
    fSoNam float NULL,
	CONSTRAINT FK_HopDongLaoDong_NhanVien
    FOREIGN KEY (sMaNV) REFERENCES tblNhanVien(sMaNV),
	CONSTRAINT CHK_fSoNam CHECK(fSoNam > 0)
);

-- Thêm dữ liệu vào bảng Phòng ban
INSERT INTO tblPhongBan (sMaPB, sTenPB, sDiaChi, sSDTPB)
VALUES
	('PB01', N'Ban Quản Lý', N'96 Định Công', '0912345678'),
	('PB02', N'Phòng Nhân sự', N'85 Vũ Trọng Phụng', '0987654321'),
	('PB03', N'Phòng Marketing', N'477 Vũ Trọng Phụng','0985675913'),
	('PB04', N'Phòng Kinh doanh', N'255 Giải Phóng','0985684562'),
	('PB05', N'Phòng Chăm sóc Khách Hàng', N'47 Tây Sơn','0635682657'),
	('PB06', N'Phòng Công Nghệ Thông Tin', N'96 Định Công','0635687801'),
	('PB07', N'Phòng Kế Toán', N'123 Nguyễn Trãi','0637776815');
SELECT * FROM tblPhongBan

-- Thêm dữ liệu vào bảng Dự án
INSERT INTO tblDuAn(sMaDA, sTenDA, sDiaDiem, dNgayBD, sMaPB)
VALUES 
	('DA01', N'Website Development', N'Hà Nội', '2023-04-02', 'PB06'),
	('DA02', N'Social Media', N'Thái Bình', '2023-03-19', 'PB03'),
	('DA03', N'E-commerce Design', N'Hà Nội', '2023-03-01', 'PB04'),
	('DA04', N'FIATO Premier', N'TP Hồ Chí Minh', '2023-07-11', 'PB07'),
	('DA05', N'Eco Central Park Vinh', N'Vinh', '2023-01-12', 'PB02'),
	('DA06', N'Sunshine City', N'Hà Nội', '2023-12-11', 'PB01'),
	('DA07', N'Cadia Quy Nhon', N'Quy Nhơn', '2023-02-11', 'PB04'),
	('DA08', N'Lotus Central', N'Bắc Ninh', '2023-01-10', 'PB01'),
	('DA09', N'Vlasta Sam Son', N'Thanh Hoá', '2023-01-16', 'PB06'),
	('DA10', N'Marina Hoi An', N'Quảng Nam', '2023-01-18', 'PB05');
SELECT * FROM tblDuAn

-- Thêm dữ liệu vào bảng Chức vụ
INSERT INTO tblChucVu (sMaCV, sTenCV)
VALUES
	('CV01', N'Giám đốc'),
	('CV02', N'Phó Giám đốc'),
	('CV03', N'Trưởng phòng'),
	('CV04', N'Nhân Viên');
SELECT * FROM tblChucVu

-- Thêm dữ liệu vào bảng Lương
INSERT INTO tblLuong (iBacLuong, fLuongCB, fHeSoLuong, fHSPC)
VALUES
	(1, 1500000, 1.2, 0.1),
	(2, 2000000, 1.3, 0.15),
	(3, 3000000, 1.5, 0.2),
	(4, 4000000, 1.7, 0.3),
	(5, 5000000, 2.0, 0.5);
SELECT * FROM tblLuong

-- Thêm dữ liệu vào bảng Nhân Viên
INSERT INTO tblNhanVien (sMaNV, sHoTen, dNgaySinh, sQueQuan, sGioiTinh, sSDT, sMaPB, sMaCV, iBacLuong)
VALUES
('NV01', N'Lê Văn Đạt', '1980-03-03', N'Hà Nội', N'Nam', '0985675913', 'PB02', 'CV03', 3),
('NV02', N'Phạm Thị Thùy', '1985-04-04', N'Bình Phước', N'Nữ', '0987654320', 'PB02', 'CV04', 2),
('NV03', N'Nguyễn Văn Đạt', '1990-05-05', N'Hà Nội', N'Nam', '0912345679', 'PB02', 'CV04', 1),
('NV04', N'Trần Thị Hà', '1980-06-06', N'Quảng Ninh', N'Nữ', '0987654321', 'PB03', 'CV03', 2),
('NV05', N'Lê Văn Luyện', '1985-07-07', N'Hà Nội', N'Nam', '0985675913', 'PB03', 'CV04', 2),
('NV06', N'Phạm Thị Huyền', '1990-08-08', N'Hà Nội', N'Nữ', '0987654320', 'PB03', 'CV04', 3),
('NV07', N'Nguyễn Văn Trung', '1985-09-09', N'Vĩnh Long', N'Nam', '0985675913', 'PB04', 'CV03', 2),
('NV08', N'Trần Thị Hà', '1990-10-10', N'Hà Nội', N'Nữ', '0987654320', 'PB04', 'CV04', 2),
('NV09', N'Nguyễn Văn Trung', '1990-01-01', N'Hà Nội', N'Nam', '0123456789', 'PB04', 'CV04', 1),
('NV10', N'Trần Thị Hồng', '1991-02-02', N'TP Hồ Chí Minh', N'Nữ', '0987654321', 'PB05', 'CV03', 2),
('NV11', N'Lê Văn Hùng', '1992-03-03', N'Đà Nẵng', N'Nam', '0123456789', 'PB05', 'CV04', 2),
('NV12', N'Phạm Thị Linh', '1993-04-04', N'Cần Thơ', N'Nữ', '0987654321', 'PB05', 'CV04', 2),
('NV13', N'Nguyễn Văn Việt', '1994-05-05', N'Hải Phòng', N'Nam', '0123456789', 'PB06', 'CV01', 5),
('NV14', N'Trần Thị Hạnh', '1995-06-06', N'Hà Nam', N'Nam', '0155556789', 'PB06', 'CV04', 1),
('NV15', N'Lê Văn Giang', '1996-07-07', N'Quảng Nam', N'Nam', '0123456789', 'PB06', 'CV04', 1),
('NV16', N'Trần Thị Thủy', '1999-10-10', N'Đắk Lắk', N'Nữ', '0123456444', 'PB07', 'CV02', 2),
('NV17', N'Đặng Thị Trang', '2000-11-12', N'Lào Cai', N'Nữ', '0123456555', 'PB07', 'CV04', 1),
('NV18', N'Phạm Văn Trung Kiên', '2001-12-12', N'Thanh Hóa', N'Nam', '0987654445', 'PB07', 'CV04', 1),
('NV19', N'Đặng Thị Thu', '2000-11-11', N'Hà Nội', N'Nữ', '0123456789', 'PB07', 'CV04', 2),
('NV20', N'Phạm Văn Trung Nghĩa', '2001-12-13', N'Thái Bình', N'Nam', '0987464321', 'PB07', 'CV04', 2),
('NV21', N'Nguyễn Văn Đức', '1970-01-01', N'Nam Định', N'Nam', '0912345678', 'PB01', 'CV01', 5),
('NV22', N'Trần Thị Linh', '1975-02-02', N'Thái Bình', N'Nữ', '0987654321', 'PB01', 'CV02', 4);
SELECT * FROM tblNhanVien

-- Thêm dữ liệu vào bảng Phân Công
INSERT INTO tblPhanCong (sMaDA, sMaNV, dNgayLamDA)
VALUES 
('DA01', 'NV13', '2024-04-02'),
('DA02', 'NV04', '2024-03-16'),
('DA03', 'NV07', '2023-07-17'),
('DA04', 'NV11', '2024-01-22'),
('DA05', 'NV20', '2023-09-16'),
('DA06', 'NV22', '2024-02-10'),
('DA07', 'NV01', '2023-10-14'),
('DA08', 'NV14', '2023-11-01'),
('DA09', 'NV12', '2024-02-16'),
('DA10', 'NV19', '2024-01-12');
SELECT * FROM tblPhanCong

-- Thêm dữ liệu vào bảng Hợp đồng lao động
INSERT INTO tblHopDongLaoDong (sMaHD, sMaNV, sLoaiHD, fSoNam)
VALUES
('HD01', 'NV01', N'Hợp đồng chính thức', 5),
('HD02', 'NV02', N'Hợp đồng chính thức', 4),
('HD03', 'NV03', N'Hợp đồng thử việc', 1),
('HD04', 'NV04', N'Hợp đồng chính thức', 5),
('HD05', 'NV05', N'Hợp đồng chính thức', 4),
('HD06', 'NV06', N'Hợp đồng thử việc', 1),
('HD07', 'NV07', N'Hợp đồng chính thức', 2),
('HD08', 'NV08', N'Hợp đồng chính thức', 2),
('HD09', 'NV09', N'Hợp đồng chính thức', 2),
('HD10', 'NV10', N'Hợp đồng thử việc', 1),
('HD11', 'NV11', N'Hợp đồng chính thức', 3),
('HD12', 'NV12', N'Hợp đồng chính thức', 3),
('HD13', 'NV13', N'Hợp đồng chính thức', 8),
('HD14', 'NV14', N'Hợp đồng chính thức', 2),
('HD15', 'NV15', N'Hợp đồng thử việc', 1),
('HD16', 'NV16', N'Hợp đồng chính thức', 7),
('HD17', 'NV17', N'Hợp đồng chính thức', 3),
('HD18', 'NV18', N'Hợp đồng chính thức', 3),
('HD19', 'NV19', N'Hợp đồng chính thức', 4),
('HD20', 'NV20', N'Hợp đồng chính thức', 3),
('HD21', 'NV21', N'Hợp đồng chính thức', 10),
('HD22', 'NV22', N'Hợp đồng chính thức', 9);
SELECT * FROM tblHopDongLaoDong

SELECT * FROM tblPhongBan
SELECT * FROM tblDuAn
SELECT * FROM tblChucVu
SELECT * FROM tblLuong
SELECT * FROM tblNhanVien
SELECT * FROM tblPhanCong
SELECT * FROM tblHopDongLaoDong

-- Tạo View: Hiện danh sách nhân viên gồm các thông tin mã nhân viên, họ tên, quê quán, số điện thoại
GO
CREATE VIEW vvNhanVien_ThongTin
AS
	SELECT sMaNV, sHoTen, sQueQuan, sSDT
	FROM tblNhanVien;
GO
SELECT * FROM vvNhanVien_ThongTin


-- Tạo View: Hiện danh sách nhân viên có giới tính nam
GO
CREATE VIEW vvNhanVien_GioiTinh_Nam
AS
	SELECT *
	FROM tblNhanVien
	WHERE sGioiTinh = N'Nam';
GO
SELECT * FROM vvNhanVien_GioiTinh_Nam


-- Tạo View: Đếm số nhân viên ở từng địa chỉ
GO
CREATE VIEW vvNhanVien_DiaChi_Dem 
AS
	SELECT sQueQuan, COUNT(*) AS SoNhanVien
	FROM tblNhanVien
	GROUP BY sQueQuan;
GO
SELECT * FROM vvNhanVien_DiaChi_Dem


-- Tạo View: Hiện danh sách phòng ban có địa chỉ ở 96 Định Công
GO
CREATE VIEW vvPhongBan_DiaChi_HaNoi
AS
	SELECT *
	FROM tblPhongBan
	WHERE sDiaChi = N'96 Định Công';
GO
SELECT * FROM vvPhongBan_DiaChi_HaNoi


-- Tạo View: Hiện danh sách dự án được lập từ ngày 02/07/2024
GO
CREATE VIEW vvDuAn_Ngay_2023
AS
	SELECT *
	FROM tblDuAn
	WHERE dNgayBD >= '2023-07-02';
GO
SELECT * FROM vvDuAn_Ngay_2023


-- Tạo View: Đếm số nhân viên của mỗi phòng ban
GO
CREATE VIEW vvPhongBan_NhanVien_Dem
AS
	SELECT tblPhongBan.sMaPB, sTenPB, COUNT(*) AS SoNhanVien
	FROM tblNhanVien, tblPhongBan
	WHERE tblNhanVien.sMaPB = tblPhongBan.sMaPB
	GROUP BY tblPhongBan.sMaPB, sTenPB
GO
SELECT * FROM vvPhongBan_NhanVien_Dem


-- Tạo View: Tính lương của danh sách nhân viên có tuổi 34
GO
CREATE VIEW vvNhanVien_Luong_Tuoi34
AS
	SELECT sMaNV, sHoTen, (fLuongCB * fHeSoLuong + fLuongCB * fHSPC) AS Luong
	FROM tblNhanVien, tblLuong
	WHERE tblNhanVien.iBacLuong = tblLuong.iBacLuong
	AND DATEDIFF(YEAR, dNgaySinh, GETDATE()) = 34;
GO
SELECT * FROM vvNhanVien_Luong_Tuoi34


-- Tạo View: Danh sách nhân viên có lương > 3000000
GO
CREATE VIEW vvNhanVien_Luong_3000000
AS
	SELECT sMaNV, sHoTen, sGioiTinh, sQueQuan, sSDT, tblNhanVien.iBacLuong
	FROM tblNhanVien, tblLuong
	WHERE tblNhanVien.iBacLuong = tblLuong.iBacLuong 
	AND (fLuongCB * fHeSoLuong + fLuongCB * fHSPC) > 3000000;
GO
SELECT * FROM vvNhanVien_Luong_3000000


-- Tạo View: Danh sách nhân viên có hợp đồng làm việc từ 4 năm
GO
CREATE VIEW vvNhanVien_HopDongLaoDong_4Nam
AS
	SELECT tblNhanVien.sMaNV, sHoTen, sGioiTinh, sQueQuan, sSDT, sLoaiHD, fSoNam
	FROM tblNhanVien, tblHopDongLaoDong
	WHERE tblNhanVien.sMaNV = tblHopDongLaoDong.sMaNV AND fSoNam >= 4;
GO
SELECT * FROM vvNhanVien_HopDongLaoDong_4Nam


-- Tạo View: Danh sách dự án bắt đầu làm từ ngày 2/3/2024
GO
CREATE VIEW vvPhanCong_DuAn_2024
AS
	SELECT tblDuAn.sMaDA, sMaNV, dNgayLamDA, sTenDA, sDiaDiem
	FROM tblPhanCong, tblDuAn
	WHERE tblPhanCong.sMaDA = tblDuAn.sMaDA
	AND dNgayLamDA >= '2024-03-02';
GO
SELECT * FROM vvPhanCong_DuAn_2024


-- Tạo Procedure: Lấy thông tin nhân viên theo mã nhân viên truyền vào
GO
CREATE PROC Pr_NhanVien_MaNV
@manv NVARCHAR(255)
AS
BEGIN
	IF EXISTS (SELECT sMaNV FROM tblNhanVien WHERE sMaNV = @manv)
		SELECT *
		FROM tblNhanVien
		WHERE sMaNV = @manv
	ELSE
		RAISERROR (N'Mã nhân viên không tồn tại', 16, 9) 
END
GO
EXEC Pr_NhanVien_MaNV @manv = 'NV12'


-- Tạo Procedure: Thủ tục có tham số truyền vào là giới tính, cho biết các nhân viên có giới tính đã nhập đó
GO
CREATE PROC Pr_NhanVien_GioiTinh
@gioitinh NVARCHAR(10)
AS
BEGIN
	IF (@gioitinh = N'Nam' OR @gioitinh = N'Nữ')
	BEGIN
		SELECT sMaNV, sHoTen, sQueQuan, sGioiTinh
		FROM tblNhanVien
		WHERE sGioiTinh = @gioitinh
	END
	ELSE 
		RAISERROR (N'Giới tính không hợp lệ', 16, 9) 
END
GO
EXEC Pr_NhanVien_GioiTinh @gioitinh = N'Nữ'


-- Tạo Procedure: Đếm số lượng nhân viên sinh năm, với năm là tham số truyền vào
GO
CREATE PROC Pr_SLNhanVien_Nam
@nam INT
AS
BEGIN
	SELECT YEAR(dNgaySinh) AS [Năm], COUNT(sMaNV) AS [Số lượng nhân viên]
	FROM tblNhanVien
	WHERE YEAR(dNgaySinh) = @nam
	GROUP BY YEAR(dNgaySinh)
END
GO
EXEC Pr_SLNhanVien_Nam @nam = 1990


-- Tạo Procedure: Thủ tục kiểm tra khi thêm 1 nhân viên (điều kiện các thuộc tính thêm vào hợp lệ)
GO
CREATE PROC Pr_ThemNV_HopLe
@manv NVARCHAR(20),
@tennv NVARCHAR(50),
@gioitinh NVARCHAR(10),
@ngaysinh DATETIME,
@quequan NVARCHAR(20),
@sdt NVARCHAR(20),
@mapb NVARCHAR(20),
@macv NVARCHAR(20),
@bacluong INT
AS
BEGIN
	IF @ngaysinh > GETDATE()
		RAISERROR (N'Ngày sinh không hợp lệ', 16, 1)
	ELSE IF EXISTS (SELECT sMaNV FROM tblNhanVien WHERE sMaNV = @manv)
		RAISERROR (N'Mã nhân viên đã tồn tại', 16, 1) 
	ELSE
	BEGIN
		INSERT tblNhanVien (sMaNV, sHoTen, dNgaySinh, sGioiTinh, sQueQuan, sSDT, sMaPB, sMaCV, iBacLuong)
		VALUES (@manv, @tennv, @ngaysinh, @gioitinh, @quequan, @sdt, @mapb, @macv, @bacluong)
	END
END
GO
EXEC Pr_ThemNV_HopLe @manv = 'NV22', @tennv = N'Bùi Quang Việt Hùng', @ngaysinh = '2004/01/12', 
@gioitinh = N'Nam', @quequan = N'Thái Bình', @sdt = '0908769999', @mapb = 'PB06', @macv = 'CV01', @bacluong = 5
EXEC Pr_ThemNV_HopLe @manv = 'NV23', @tennv = N'Bùi Quang Việt Hùng', @ngaysinh = '2004/01/12', 
@gioitinh = N'Nam', @quequan = N'Thái Bình', @sdt = '0908769999', @mapb = 'PB10', @macv = 'CV01', @bacluong = 5
EXEC Pr_ThemNV_HopLe @manv = 'NV24', @tennv = N'Phạm Quốc Quân', @ngaysinh = '2004/01/13', 
@gioitinh = N'Nam', @quequan = N'Nam Định', @sdt = '0908768888', @mapb = 'PB01', @macv = 'CV02', @bacluong = 4


-- Tạo Procedure: Đếm số lượng nhân viên có tên chức vụ truyền vào
GO
CREATE PROC Pr_SLNhanVien_ChucVu
@tencv NVARCHAR(20)
AS
BEGIN
	IF EXISTS (SELECT sTenCV FROM tblChucVu WHERE sTenCV = @tencv)
		SELECT tblChucVu.sTenCV AS [Tên chức vụ], COUNT(sMaNV) AS [Số lượng nhân viên]
		FROM tblNhanVien, tblChucVu
		WHERE tblNhanVien.sMaCV = tblChucVu.sMaCV AND sTenCV = @tencv
		GROUP BY tblChucVu.sTenCV
	ELSE 
		RAISERROR (N'Tên chức vụ không tồn tại', 16, 9) 
END
GO
EXEC Pr_SLNhanVien_ChucVu @tencv = N'Nhân Viên'


-- Tạo Procedure: Thống kê các dự án được phân công làm từ năm, năm là tham số truyền vào
GO
CREATE PROC Pr_DuAn_Nam
@nam INT
AS
BEGIN
	IF @nam > YEAR(GETDATE())
		RAISERROR (N'Năm nhập vào không hợp lệ', 16, 9) 
	ELSE 
		SELECT tblDuAn.sMaDA, sTenDA, sDiaDiem, dNgayLamDA AS [Ngày làm dự án]
		FROM tblDuAn, tblPhanCong
		WHERE tblDuAn.sMaDA = tblPhanCong.sMaDA AND YEAR(dNgayLamDA) >= @nam
END
GO
EXEC Pr_DuAn_Nam @nam = 2024


-- Tạo trigger:  Thông báo khi thêm nhân viên mới
GO
CREATE TRIGGER Tg_NhanVien_TB
ON tblNhanVien
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted INNER JOIN tblNhanVien ON inserted.sMaNV = tblNhanVien.sMaNV)
        PRINT N'Đã thêm nhân viên mới!';
END
GO


-- Tạo trigger kiểm soát giới tính của nhân viên là Nam hoặc Nữ
GO
CREATE TRIGGER Tg_NhanVien_GioiTinh
ON tblNhanVien
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE sGioiTinh NOT IN (N'Nam', N'Nữ'))
    BEGIN
        PRINT N'Giới tính không hợp lệ!';
		ROLLBACK
    END	
	ELSE
	BEGIN
		INSERT INTO tblNhanVien
		SELECT * FROM inserted
    END
END;
GO

INSERT INTO tblNhanVien (sMaNV, sHoTen, sGioiTinh, dNgaySinh, sQueQuan, sSDT, sMaPB, sMaCV, iBacLuong)
VALUES ('NV25', N'Nguyễn Đức Cảnh', N'Namm', '2003/02/10', N'Ninh Bình', '0908769879', 'PB03', 'CV03', 2)
INSERT INTO tblNhanVien (sMaNV, sHoTen, sGioiTinh, dNgaySinh, sQueQuan, sSDT, sMaPB, sMaCV, iBacLuong)
VALUES ('NV25', N'Nguyễn Đức Cảnh', N'Nam', '2003/02/10', N'Ninh Bình', '0908769879', 'PB03', 'CV03', 2)


-- Tạo trigger: Thêm số nhân viên vào phòng ban và tạo trigger tự động đếm số nhân viên ở bảng PhongBan khi có một nhân viên được thêm, xoá khỏi phòng ban đó
GO
ALTER TABLE tblPhongBan
ADD iSoNhanVien INT
GO
CREATE TRIGGER Tg_NhanVien_SoNV
ON tblNhanVien
AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @MaPhongBanI NVARCHAR(10), @MaPhongBanD NVARCHAR(10)
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SELECT @MaPhongBanI = sMaPB FROM inserted
        UPDATE tblPhongBan
        SET iSoNhanVien  = (SELECT COUNT(*) FROM tblNhanVien WHERE sMaPB = @MaPhongBanI)
        WHERE sMaPB = @MaPhongBanI;
    END
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SELECT @MaPhongBanD = sMaPB FROM deleted
        UPDATE tblPhongBan
        SET iSoNhanVien  = (SELECT COUNT(*) FROM tblNhanVien WHERE sMaPB = @MaPhongBanD)
        WHERE sMaPB = @MaPhongBanD;
    END
END
GO

INSERT INTO tblNhanVien (sMaNV, sHoTen, sGioiTinh, dNgaySinh, sQueQuan, sSDT, sMaPB, sMaCV, iBacLuong)
VALUES ('NV26', N'Đặng Văn Nam', N'Nam', '2002/02/11', N'Cà Mau', '0908769979', 'PB03', 'CV04', 1)
SELECT * FROM tblPhongBan


-- Tạo trigger: Khi xoá một nhân viên thì xoá thông tin của nhân viên ở các bảng khác
GO
CREATE TRIGGER Tg_NhanVien_XoaNV
ON tblNhanVien
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @MaNV NVARCHAR(10)
	SELECT @MaNV = sMaNV FROM DELETED
	IF EXISTS( SELECT * FROM tblPhanCong WHERE sMaNV = @MaNV)
	BEGIN
		DELETE FROM tblPhanCong
		WHERE sMaNV = @MaNV
	END
	IF EXISTS( SELECT * FROM tblHopDongLaoDong WHERE sMaNV = @MaNV)
	BEGIN
		DELETE FROM tblHopDongLaoDong
		WHERE sMaNV = @MaNV
	END
	DELETE FROM tblNhanVien
	WHERE sMaNV = @MaNV
END;
GO

DELETE FROM TBLNHANVIEN
WHERE sMaNV = 'NV19'
SELECT * FROM tblNhanVien
SELECT * FROM tblPhongBan
SELECT * FROM tblHopDongLaoDong
SELECT * FROM tblPhanCong


-- Tạo trigger: Chỉ được phân công ngày làm dự án sau ngày bắt đầu dự án
GO
CREATE TRIGGER Tg_PhanCong_NgayLamDA
ON tblPhanCong
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @ngaylamda	DATETIME
	DECLARE @mada NVARCHAR(10)
	SELECT @mada = sMaDA FROM inserted
	SELECT @ngaylamda = dNgayLamDA FROM inserted
	IF (@ngaylamda < (SELECT dNgayBD FROM tblDuAn WHERE sMaDA = @mada))
	BEGIN
		PRINT N'Không thêm được vì ngày làm dự án sau ngày bắt đầu dự án'
		ROLLBACK
	END
END
GO

INSERT INTO tblPhanCong (sMaDA, sMaNV, dNgayLamDA)
VALUES ('DA10', 'NV11', '2022-04-02')
INSERT INTO tblPhanCong (sMaDA, sMaNV, dNgayLamDA)
VALUES ('DA10', 'NV11', '2024-04-02')


-- Phân quyền bảo mật người dùng
-- Tài khoản của Bùi Quang Việt Hùng
CREATE LOGIN BuiQuangVietHung WITH PASSWORD = 'hung1234'
CREATE USER Hung FOR LOGIN BuiQuangVietHung

-- Tài khoản của Phạm Quốc Quân
CREATE LOGIN PhamQuocQuan WITH PASSWORD = 'quan1234'
CREATE USER Quan FOR LOGIN PhamQuocQuan

-- Tài khoản của Nguyễn Đức Cảnh
CREATE LOGIN NguyenDucCanh WITH PASSWORD = 'canh1234'
CREATE USER Canh FOR LOGIN NguyenDucCanh

-- Tài khoản của Đặng Văn Nam
CREATE LOGIN DangVanNam WITH PASSWORD = 'nam1234'
CREATE USER Nam FOR LOGIN DangVanNam

-- Cấp quyền cho Bùi Quang Việt Hùng
GRANT SELECT, INSERT, UPDATE, DELETE ON tblPhongBan TO Hung
GRANT SELECT, INSERT, UPDATE, DELETE ON tblDuAn TO Hung
GRANT SELECT, INSERT, UPDATE, DELETE ON tblChucVu TO Hung
GRANT SELECT, INSERT, UPDATE, DELETE ON tblLuong TO Hung
GRANT SELECT, INSERT, UPDATE, DELETE ON tblPhanCong TO Hung
GRANT SELECT, INSERT, UPDATE, DELETE ON tblHopDongLaoDong TO Hung

-- Cấp quyền cho Phạm Quốc Quân
GRANT SELECT, INSERT, UPDATE, DELETE ON tblPhongBan TO Quan
GRANT SELECT, INSERT, UPDATE, DELETE ON tblDuAn TO Quan
GRANT SELECT, INSERT, UPDATE, DELETE ON tblChucVu TO Quan
GRANT SELECT, INSERT, UPDATE, DELETE ON tblLuong TO Quan
GRANT SELECT, INSERT, UPDATE, DELETE ON tblPhanCong TO Quan
GRANT SELECT, INSERT, UPDATE, DELETE ON tblHopDongLaoDong TO Quan

-- Cấp quyền cho Nguyễn Đức Cảnh
GRANT SELECT, INSERT, UPDATE, DELETE ON tblPhongBan TO Canh
GRANT SELECT, INSERT, UPDATE, DELETE ON tblDuAn TO Canh
GRANT SELECT, INSERT, UPDATE, DELETE ON tblChucVu TO Canh
GRANT SELECT, INSERT, UPDATE, DELETE ON tblLuong TO Canh
GRANT SELECT, INSERT, UPDATE, DELETE ON tblPhanCong TO Canh
GRANT SELECT, INSERT, UPDATE, DELETE ON tblHopDongLaoDong TO Canh

-- Cấp quyền cho Đặng Văn Nam
GRANT SELECT, INSERT, UPDATE, DELETE ON tblPhongBan TO Nam
GRANT SELECT, INSERT, UPDATE, DELETE ON tblDuAn TO Nam
GRANT SELECT, INSERT, UPDATE, DELETE ON tblChucVu TO Nam
GRANT SELECT, INSERT, UPDATE, DELETE ON tblLuong TO Nam
GRANT SELECT, INSERT, UPDATE, DELETE ON tblPhanCong TO Nam
GRANT SELECT, INSERT, UPDATE, DELETE ON tblHopDongLaoDong TO Nam

-- Tạo role rl_NhanVien để quản lý danh sách nhân viên
CREATE ROLE rl_NhanVien

-- Cấp quyền cho role rl_NhanVien được xem, thêm dữ liệu của bảng tblNhanVien, chỉ được xem dữ liệu của bảng tblChucVu, tblPhongBan, tblLuong, tblDuAn và tblHopDongLaoDong và tước quyền với các bảng còn lại
GRANT SELECT, INSERT ON tblNhanVien TO rl_NhanVien
GRANT SELECT ON tblChucVu TO rl_NhanVien
GRANT SELECT ON tblPhongBan TO rl_NhanVien
GRANT SELECT ON tblLuong TO rl_NhanVien
GRANT SELECT ON tblDuAn TO rl_NhanVien
GRANT SELECT ON tblHopDongLaoDong TO rl_NhanVien

DENY DELETE, UPDATE ON tblNhanVien TO rl_NhanVien
DENY INSERT, UPDATE, DELETE ON tblChucVu TO rl_NhanVien
DENY INSERT, UPDATE, DELETE ON tblPhongBan TO rl_NhanVien
DENY INSERT, UPDATE, DELETE ON tblLuong TO rl_NhanVien
DENY INSERT, UPDATE, DELETE ON tblDuAn TO rl_NhanVien
DENY INSERT, UPDATE, DELETE ON tblHopDongLaoDong TO rl_NhanVien
DENY SELECT, INSERT, UPDATE, DELETE ON tblPhanCong TO rl_NhanVien

-- Thêm người dùng vào role rl_NhanVien
ALTER ROLE rl_NhanVien
ADD MEMBER Hung

ALTER ROLE rl_NhanVien
ADD MEMBER Quan

-- Tạo role rl_PhanCong để quản lý danh sách phân công dự án
CREATE ROLE rl_PhanCong

-- Cấp quyền cho rl_PhanCong được xem, thêm, sửa, xoá dữ liệu cho bảng tblPhanCong, bảng tblDuAn, chỉ được xem dữ liệu của bảng tblNhanVien, tblChucVu, tblPhongBan và tblLuong
GRANT SELECT, INSERT, UPDATE, DELETE ON tblPhanCong TO rl_PhanCong
GRANT SELECT, INSERT, UPDATE, DELETE ON tblDuAn TO rl_PhanCong
GRANT SELECT ON tblNhanVien TO rl_PhanCong
GRANT SELECT ON tblChucVu TO rl_PhanCong
GRANT SELECT ON tblPhongBan TO rl_PhanCong
GRANT SELECT ON tblLuong TO rl_PhanCong

DENY INSERT, UPDATE, DELETE ON tbLNhanVien TO rl_PhanCong
DENY INSERT, UPDATE, DELETE ON tblChucVu TO rl_PhanCong
DENY INSERT, UPDATE, DELETE ON tblPhongBan TO rl_PhanCong
DENY INSERT, UPDATE, DELETE ON tblLuong TO rl_PhanCong
DENY SELECT, INSERT, UPDATE, DELETE ON tblHopDongLaoDong TO rl_PhanCong

--Thêm người dùng vào role rl_PhanCong
ALTER ROLE rl_PhanCong
ADD MEMBER Canh

ALTER ROLE rl_PhanCong
ADD MEMBER Nam


-- Phân tán CSDL
-- Thêm một máy chủ liên kết
EXEC sp_addlinkedserver 
	@server = MayTram2,
	@srvproduct = 'BQVH',
	@provider = N'SQLOLEDB',
	@datasrc = N'192.168.89.130,1433'

-- Tạo tài khoản đăng nhập cho máy chủ liên kết
EXEC master.dbo.sp_addlinkedsrvlogin
	@rmtsrvname = MayTram2,
	@rmtuser = 'Hung',
	@rmtpassword = '1201'

-- Đăng nhập vào máy chủ liên kết
EXEC master.dbo.sp_addlinkedsrvlogin 
	@rmtsrvname = N'MayTram2',
	@useself = N'False',
	@locallogin = NULL,
	@rmtuser = N'Hung',
	@rmtpassword = '1201'

-- Phân tán dọc bảng Dự Án thành 2 bảng
-- Tram1 tblDuAn(sMaDA, sTenDA, dNgayBD, sMaPB)
-- Tram2 tblDuAn(sMaDA, sDiaDiem )

-- Tạo bảng tblDuAn(sMaDA, sDiaDiem) trên máy Tram2
EXEC ('USE QuanLyNhanVien
CREATE TABLE tblDuAn
(
	sMaDA NVARCHAR(10) PRIMARY KEY NOT NULL,
	sDiaDiem NVARCHAR(20) NULL,
)'
)AT MayTram2

-- Tạo bí danh cho bảng tblDuAn của máy Tram2
CREATE SYNONYM tblDuAnTram2 FOR MayTram2.QuanLyNhanVien.dbo.tblDuAn

-- Chuyển dữ liệu đã nhập trước đó sang máy Tram2
INSERT INTO tblDuAnTram2
SELECT sMaDA, sDiaDiem FROM tblDuAn

-- Xoá dữ liệu ở máy Tram1
ALTER TABLE tblDuAn
DROP COLUMN sDiaDiem

-- Tạo thủ tục thêm dữ liệu cho bảng tblDuAn và đưa vào trạm phù hợp
GO
CREATE PROC Pr_ThemDuAn
@mada NVARCHAR(10),
@tenda NVARCHAR(30),
@diadiem NVARCHAR(20),
@ngaybd DATETIME,
@mapb NVARCHAR(10)
AS
BEGIN
	IF EXISTS (SELECT sMaDA FROM tblDuAn WHERE sMaDA = @mada)
		RAISERROR (N'Mã dự án đã tồn tại', 16, 9)
	ELSE
		INSERT INTO tblDuAn VALUES(@mada, @tenda, @ngaybd, @mapb)
		INSERT INTO tblDuAnTram2 VALUES(@mada, @diadiem)
END
GO
-- Test thủ tục
EXEC Pr_ThemDuAn @mada = 'DA11', @tenda = N'Sun Ponte Residences', @diadiem = N'Đà Nẵng', @ngaybd = '2024/02/02', @mapb = 'PB06'

-- Dữ liệu từ bảng tblDuAn ở Tram1
SELECT * FROM tblDuAn
-- Dữ liệu từ bảng tblDuAn ở Tram2
SELECT * FROM tblDuAnTram2
-- Xem dữ liệu bảng tblDuAn ở cả 2 trạm
SELECT a.sMaDA, sTenDA, sDiaDiem, dNgayBD, sMaPB
FROM tblDuAn a, tblDuAnTram2 b
WHERE a.sMaDA = b.sMaDA


-- Phân tán ngang bảng HopDongLaoDong với điều kiện: Số năm làm việc lớn hơn 4 thì đặt tại trạm 1, còn lại thì đặt tại trạm 2
-- Tạo bảng tblHopDongLaoDong trên máy ảo
EXEC('USE QuanLyNhanVien
CREATE TABLE tblHopDongLaoDong 
(
    sMaHD NVARCHAR(10) PRIMARY KEY NOT NULL,
    sMaNV NVARCHAR(10) NULL,
    sLoaiHD NVARCHAR(30) NULL,
    fSoNam float NULL,
)'
)AT MayTram2

-- Tạo bí danh cho bảng tblHopDongLaoDong máy Tram2
CREATE SYNONYM tblHopDongLaoDongTram2 FOR MayTram2.QuanLyNhanVien.dbo.tblHopDongLaoDong

-- Thêm ràng buộc số năm lớn hơn 4 tại bảng tblHopDongLaoDong ở Trạm 1
ALTER TABLE tblHopDongLaoDong
ADD CONSTRAINT CHK_fSoNam4 CHECK(fSoNam > 4)

-- Chuyển dữ liệu đã nhập với điều kiện fSoNam < 4 sang máy Tram2
INSERT INTO tblHopDongLaoDongTram2
SELECT * 
FROM tblHopDongLaoDong
WHERE  fSoNam < 4

-- Xoá dữ liệu không thoả mãn điều kiện ở Tram1
DELETE FROM tblHopDongLaoDong
WHERE fSoNam < 4

-- Tạo thủ tục thêm dữ liệu vào bảng tblHopDongLaoDong và đưa vào trạm phù hợp
GO
CREATE PROC Pr_ThemHopDong
@mahd NVARCHAR(10),
@manv NVARCHAR(10),
@loaihd NVARCHAR(30),
@sonam FLOAT
AS
BEGIN
	IF EXISTS (SELECT sMaHD FROM tblHopDongLaoDong WHERE sMaHD = @mahd)
		RAISERROR (N'Mã hợp đồng đã tồn tại', 16, 9)
	ELSE IF EXISTS (SELECT sMaNV FROM tblHopDongLaoDong WHERE sMaNV = @manv)
		RAISERROR (N'Nhân viên đã có hợp đồng', 16, 9)
	ELSE
	BEGIN
		IF @sonam > 4
			INSERT INTO tblHopDongLaoDong
			VALUES (@mahd, @manv, @loaihd, @sonam)
		ELSE
			INSERT INTO tblHopDongLaoDongTram2
			VALUES (@mahd, @manv, @loaihd, @sonam)
	END
END
GO
-- Test thủ tục
EXEC Pr_ThemHopDong @mahd = 'HD23', @manv = 'NV23', @loaihd = N'Hợp đồng chính thức', @sonam = 8
EXEC Pr_ThemHopDong @mahd = 'HD24', @manv = 'NV24', @loaihd = N'Hợp đồng thử việc', @sonam = 2

-- Dữ liệu trong bảng tblHopDongLaoDong ở Tram1
SELECT * FROM tblHopDongLaoDong
-- Dữ liệu trong bảng tblHopDongLaoDong ở Tram2
SELECT * FROM tblHopDongLaoDongTram2

-- Xem dữ liệu bảng tblHopDongLaoDong ở cả 2 bảng
SELECT * FROM tblHopDongLaoDong
UNION
SELECT * FROM tblHopDongLaoDongTram2
