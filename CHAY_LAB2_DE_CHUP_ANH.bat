@echo off
chcp 65001 > nul
title THỰC HIỆN VÀ CHỤP MÀN HÌNH DESKTOP LAB 2 - NGUYỄN VĂN HẢI (DTC235180063)
color 0A

echo ===============================================================================
echo     HỖ TRỢ THỰC HIỆN VÀ CHỤP MÀN HÌNH TRỰC TIẾP TRÊN MÁY TÍNH LAB 2
echo     Sinh viên: Nguyễn Văn Hải - MSSV: DTC235180063 - Lớp: KTPMK22C
echo ===============================================================================
echo.
echo Thư mục lưu ảnh: D:\git label1\Lab2_NguyenVanHai_DTC235180063\screenshots\
echo Phím tắt chụp ảnh trên Windows: Nhấn tổ hợp phím [Windows + Shift + S]
echo.
pause

cls
echo ===============================================================================
echo [ẢNH 1/6] KIỂM TRA PHIÊN BẢN CÔNG CỤ (01-toolchain-check.png)
echo ===============================================================================
echo Đang kiểm tra VS Code, Git, Docker Desktop...
echo.
code --version
echo.
git --version
echo.
docker --version
echo.
echo -------------------------------------------------------------------------------
echo >>> BƯỚC CHỤP ẢNH 1:
echo Nhấn [Windows + Shift + S], quét chụp cửa sổ này.
echo Lưu ảnh vào thư mục screenshots với tên: 01-toolchain-check.png
echo -------------------------------------------------------------------------------
echo.
pause

cls
echo ===============================================================================
echo [ẢNH 2/6] CHẠY SCRIPT TỰ ĐỘNG HÓA MÔI TRƯỜNG (02-automation-script.png)
echo ===============================================================================
cd /d "d:\van hanh bao tri pham men\VHBTPM_DevOps_2026\Labs\Bài 2\configs"
powershell -ExecutionPolicy Bypass -File .\setup-dev-env.ps1
echo.
echo -------------------------------------------------------------------------------
echo >>> BƯỚC CHỤP ẢNH 2:
echo Nhấn [Windows + Shift + S], quét chụp kết quả chạy script trên.
echo Lưu ảnh vào thư mục screenshots với tên: 02-automation-script.png
echo -------------------------------------------------------------------------------
echo.
pause

cls
echo ===============================================================================
echo [ẢNH 3/6] QUÁ TRÌNH BUILD DOCKER IMAGE (03-docker-build.png)
echo ===============================================================================
cd /d "d:\van hanh bao tri pham men\VHBTPM_DevOps_2026\Labs\Bài 2\configs"
echo Đang chạy lệnh: docker build -t devops-lab2-app .
docker build -t devops-lab2-app .
echo.
docker images devops-lab2-app
echo.
echo -------------------------------------------------------------------------------
echo >>> BƯỚC CHỤP ẢNH 3:
echo Nhấn [Windows + Shift + S], quét chụp màn hình build Docker trên.
echo Lưu ảnh vào thư mục screenshots với tên: 03-docker-build.png
echo -------------------------------------------------------------------------------
echo.
pause

cls
echo ===============================================================================
echo [ẢNH 4/6] CHẠY CONTAINER & KIỂM TRA CURL LOCALHOST:3000 (04-docker-run-curl.png)
echo ===============================================================================
echo Kiểm tra và khởi động container...
docker stop lab2-app >nul 2>&1
docker rm lab2-app >nul 2>&1
docker run -d -p 3000:3000 --name lab2-app devops-lab2-app
echo.
echo Trạng thái container:
docker ps --filter "name=lab2-app"
echo.
echo Kết quả kiểm tra dịch vụ qua lệnh curl:
curl http://localhost:3000
echo.
echo.
echo -------------------------------------------------------------------------------
echo >>> BƯỚC CHỤP ẢNH 4:
echo Nhấn [Windows + Shift + S], quét chụp cửa sổ hiển thị container và kết quả JSON.
echo Lưu ảnh vào thư mục screenshots với tên: 04-docker-run-curl.png
echo -------------------------------------------------------------------------------
echo.
pause

cls
echo ===============================================================================
echo [ẢNH 5/6 & 6/6] MỞ FILE BÁO CÁO ĐỂ CHỤP TOOLCHAIN MAP VÀ BẢNG CALMS
echo ===============================================================================
echo Đang mở file báo cáo BaoCao_Lab2.html trên trình duyệt...
start "" "D:\git label1\Lab2_NguyenVanHai_DTC235180063\BaoCao_Lab2.html"
echo.
echo >>> BƯỚC CHỤP ẢNH 5:
echo - Trên trình duyệt vừa mở, cuộn đến mục: "IV. Bảng Phân Loại 13 Công Cụ Trong DevOps Toolchain"
echo - Nhấn [Windows + Shift + S] chụp lại bảng / sơ đồ.
echo - Lưu thành: 05-toolchain-map.png
echo.
echo >>> BƯỚC CHỤP ẢNH 6:
echo - Cuộn tiếp đến mục: "V. Đánh Giá Mức Độ Trưởng Thành CALMS (19 / 25 Điểm)"
echo - Nhấn [Windows + Shift + S] chụp lại bảng CALMS và 3 hành động cải thiện.
echo - Lưu thành: 06-calms-assessment.png
echo.
echo -------------------------------------------------------------------------------
echo Sau khi đã lưu đủ 6 ảnh vào thư mục:
echo D:\git label1\Lab2_NguyenVanHai_DTC235180063\screenshots\
echo -------------------------------------------------------------------------------
echo Nhấn phím bất kỳ để hệ thống tự động đóng gói tệp ZIP nộp bài!
pause

powershell -Command "Compress-Archive -Path 'D:\git label1\Lab2_NguyenVanHai_DTC235180063\*' -DestinationPath 'D:\git label1\Lab2_NguyenVanHai_DTC235180063.zip' -Force; Copy-Item 'D:\git label1\Lab2_NguyenVanHai_DTC235180063.zip' 'd:\van hanh bao tri pham men\VHBTPM_DevOps_2026\Labs\Bài 2\nop_bai\' -Force"

echo.
echo ===============================================================================
echo ĐÃ ĐÓNG GÓI HOÀN TẤT TỆP NỘP BÀI:
echo 1. D:\git label1\Lab2_NguyenVanHai_DTC235180063.zip
echo 2. d:\van hanh bao tri pham men\VHBTPM_DevOps_2026\Labs\Bài 2\nop_bai\Lab2_NguyenVanHai_DTC235180063.zip
echo ===============================================================================
echo.
pause
