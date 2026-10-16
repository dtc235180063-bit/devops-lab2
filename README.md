# DevOps Lab 2 — Thiết lập Môi trường DevOps & Áp dụng Nguyên tắc CALMS

## Thông tin sinh viên
- **Họ và tên:** Nguyễn Văn Hải
- **Mã sinh viên:** DTC235180063
- **Lớp:** KTPMK22C
- **Học phần:** Vận hành và Bảo trì Phần mềm (DevOps — 2026)

## Cấu trúc thư mục
```
devops-lab2/
├── Dockerfile
├── package.json
├── server.js
├── setup-dev-env.sh
├── setup-dev-env.ps1
├── ho_ten_mssv.txt
├── README.md
└── screenshots/
    ├── 01-toolchain-check.png
    ├── 02-automation-script.png
    ├── 03-docker-build.png
    ├── 04-docker-run-curl.png
    ├── 05-toolchain-map.png
    └── 06-calms-assessment.png
```

## Hướng dẫn chạy
```bash
# 1. Chạy kịch bản tự động hóa môi trường
bash setup-dev-env.sh
# Hoặc trên PowerShell:
powershell -ExecutionPolicy Bypass -File .\setup-dev-env.ps1

# 2. Build Docker image
docker build -t devops-lab2-app .

# 3. Chạy container
docker run -d -p 3000:3000 --name lab2-app devops-lab2-app

# 4. Kiểm tra ứng dụng
curl http://localhost:3000
```
