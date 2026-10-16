# DevOps Lab 2 — Thiết lập Môi trường DevOps & Áp dụng Nguyên tắc CALMS

## 1. Thông tin sinh viên
- **Họ và tên:** Nguyễn Văn Hải
- **Mã sinh viên:** DTC235180063
- **Lớp:** KTPMK22C
- **Khoa:** Công nghệ Thông tin
- **Trường:** Đại học Công nghệ Thông tin & Truyền thông (ICTU)
- **Học phần:** Vận hành và Bảo trì Phần mềm với DevOps (2026)

---

## 2. Thông tin dự án Lab 2
- **GitHub Repository:** [dtc235180063-bit/devops-lab2](https://github.com/dtc235180063-bit/devops-lab2)
- **Chuẩn đầu ra (CDR):** CDR 2.1 (DevOps Toolchain) + CDR 2.2 (Nguyên tắc CALMS) + CDR 2.3 (Công cụ DevOps)

---

## 3. Cấu trúc thư mục
```
devops-lab2/
├── Dockerfile                   # Cấu hình container hóa Node.js 18-alpine
├── package.json                 # Định nghĩa dependencies và start script
├── server.js                    # Mã nguồn HTTP server trả về JSON
├── setup-dev-env.sh             # Script tự động hóa cài đặt môi trường (Linux/Git Bash)
├── setup-dev-env.ps1            # Script tự động hóa cài đặt môi trường (Windows PowerShell)
├── BAO_CAO_LAB2.md              # Báo cáo kết quả thực hành chi tiết
├── BaoCao_Lab2.html             # Báo cáo định dạng HTML xem trên trình duyệt
├── ho_ten_mssv.txt              # Thông tin sinh viên nộp bài
└── screenshots/                 # Minh chứng kết quả thực hành
    ├── 01-toolchain-check.png   # Kiểm tra version VS Code, Git, Docker
    ├── 02-automation-script.png # Kết quả chạy kịch bản tự động hóa
    ├── 03-docker-build.png      # Quá trình docker build
    ├── 04-docker-run-curl.png   # Kết quả chạy container & curl localhost:3000
    ├── 05-toolchain-map.png     # Sơ đồ DevOps Toolchain Map
    └── 06-calms-assessment.png  # Bảng đánh giá CALMS Maturity (19/25)
```

---

## 4. Hướng dẫn chạy nhanh (Quick Start)

### 4.1. Chạy Script Tự động hóa Môi trường (Nguyên tắc Automation)
```bash
# Trên Git Bash / Linux / macOS:
bash setup-dev-env.sh

# Trên Windows PowerShell:
powershell -ExecutionPolicy Bypass -File .\setup-dev-env.ps1
```

### 4.2. Build & Chạy Ứng dụng với Docker (Nguyên tắc Lean)
```bash
# 1. Build Docker Image
docker build -t devops-lab2-app .

# 2. Khởi chạy Container
docker run -d -p 3000:3000 --name lab2-app devops-lab2-app

# 3. Kiểm tra kết quả
curl http://localhost:3000
```
