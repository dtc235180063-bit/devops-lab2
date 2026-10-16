# BÁO CÁO KẾT QUẢ THỰC HÀNH LAB 2
## Học phần: Vận hành và Bảo trì Phần mềm (DevOps — 2026)
### Bài 2: Thiết lập Môi trường DevOps & Áp dụng Nguyên tắc CALMS

---

## I. THÔNG TIN SINH VIÊN
- **Họ và tên sinh viên:** Nguyễn Văn Hải
- **Mã số sinh viên (MSSV):** DTC235180063
- **Lớp học phần:** KTPMK22C
- **Khoa:** Công nghệ Thông tin
- **Trường:** Đại học Công nghệ Thông tin & Truyền thông (ICTU) - Đại học Thái Nguyên
- **Email:** dtc235180063@ictu.edu.vn
- **GitHub Username:** `dtc235180063-bit`
- **Ngày thực hiện:** 16/10/2026

---

## II. MỤC TIÊU VÀ KẾT QUẢ ĐẠT ĐƯỢC

| STT | Chuẩn đầu ra (CDR) | Nội dung yêu cầu | Kết quả đạt được |
| :---: | :---: | :--- | :--- |
| 1 | **CDR 2.1** | Cài đặt & cấu hình bộ công cụ nền tảng DevOps (VS Code + Git + Docker Desktop) | ✅ Hoàn thành cài đặt và kiểm tra 3/3 công cụ (VS Code 1.141.1, Git 2.51.0, Docker 29.8.2). |
| 2 | **CDR 2.2** | Hiểu và áp dụng 5 nguyên tắc **CALMS** (Culture, Automation, Lean, Measurement, Sharing) | ✅ Giải quyết bài toán tự động hóa môi trường, tối ưu hóa container và đánh giá độ trưởng thành 19/25. |
| 3 | **CDR 2.3** | Viết Automation Script đầu tiên (Automation) và đóng gói Container hóa (Lean) | ✅ Viết script `setup-dev-env.sh`/`.ps1` chạy trong 0.3 giây; build và chạy container Node.js trên Docker. |
| 4 | **CDR 2.3** | Xây dựng Bản đồ Chuỗi công cụ DevOps (**Toolchain Map**) | ✅ Hoàn thành sơ đồ chi tiết phân bổ 13+ công cụ theo 6 giai đoạn phát triển và vận hành phần mềm. |

---

## III. NỘI DUNG THỰC HIỆN CHI TIẾT

### BƯỚC 1: Cài đặt DevOps Toolchain Cơ bản
Hệ thống đã được thiết lập đầy đủ bộ ba công cụ cốt lõi của kỹ sư DevOps:
1. **Visual Studio Code:** Phiên bản `1.141.1` kèm các extension thiết yếu: *GitLens, Docker, YAML, Prettier, Markdown Preview*.
2. **Git Version Control:** Phiên bản `git version 2.51.0.windows.1` đã cấu hình thông tin định danh toàn cục (`user.name: Nguyễn Văn Hải`, `user.email: dtc235180063@ictu.edu.vn`).
3. **Docker Desktop:** Phiên bản `Docker version 29.8.2`, sử dụng nền tảng ảo hóa hiện đại **WSL 2 (Linux Kernel 6.18.54.1)** với tài nguyên cấp phát 7.6GB RAM, 12 vCPUs.
- Kết quả chạy kịch bản kiểm tra toolchain [verify.sh](file:///d:/van%20hanh%20bao%20tri%20pham%20men/VHBTPM_DevOps_2026/Labs/B%C3%A0i%202/scripts/verify.sh) đạt **8/8 tiêu chí PASS (100%)**.

---

### BƯỚC 2: Nguyên tắc Automation — Kịch bản Tự động hóa Môi trường Phát triển

#### 2.1. Đặt vấn đề và Giải pháp
- **Bài toán:** Trong một nhóm phát triển 5 người, mỗi thành viên mới gia nhập dự án thường mất đến **2 giờ** để được hướng dẫn và cài đặt thủ công các phần mềm phụ thuộc, cấu hình thư mục và biến môi trường.
- **Giải pháp DevOps:**
  > Áp dụng bài học cốt lõi: *"Bất cứ việc gì làm thủ công ≥ 2 lần → Hãy viết script tự động hóa!"*
  - Xây dựng kịch bản cài đặt tự động `setup-dev-env.sh` (chạy trên Linux/macOS/Git Bash) và `setup-dev-env.ps1` (chạy trên Windows PowerShell).
  - Kịch bản tự động thực hiện 4 công việc tuần tự:
    1. Kiểm tra các phần mềm tiên quyết (Git, Node.js).
    2. Khởi tạo cấu trúc thư mục chuẩn của dự án (`src/`, `tests/`, `docs/`).
    3. Tự động khởi tạo Git repository (`git init`).
    4. Tự động sinh tệp `.gitignore` chuẩn và tệp hướng dẫn `README.md`.
  - **Kết quả:** Rút ngắn thời gian thiết lập môi trường từ **2 giờ (120 phút)** xuống chỉ còn **0.3 giây** (giảm 99.7% thời gian lãng phí).

---

### BƯỚC 3: Nguyên tắc Lean — Loại bỏ lãng phí với Docker

#### 3.1. Đặt vấn đề
Sự cố kinh điển trong phát triển phần mềm: *"It works on my machine"* (Code chạy trơn tru trên máy Windows của lập trình viên A, nhưng khi chuyển sang máy macOS của lập trình viên B hoặc server Linux thì bị crash do lệch phiên bản Node.js hoặc thiếu gói thư viện hệ điều hành).

#### 3.2. Triển khai Container hóa với Dockerfile
- **Dockerfile:**
  ```dockerfile
  # Sử dụng base image siêu nhẹ và ổn định
  FROM node:18-alpine

  # Thiết lập thư mục làm việc chuẩn
  WORKDIR /app

  # Tận dụng Docker Build Cache
  COPY package.json .
  RUN npm install

  # Copy toàn bộ mã nguồn ứng dụng
  COPY . .

  # Mở cổng dịch vụ
  EXPOSE 3000

  # Khởi chạy dịch vụ
  CMD ["node", "server.js"]
  ```

- **Mã nguồn dịch vụ (`server.js`):**
  Ứng dụng HTTP Server trả về JSON thông tin trạng thái container, kèm thông tin định danh sinh viên Nguyễn Văn Hải:
  ```json
  {
    "message": "Hello from Docker!",
    "lab": "DevOps Lab 2 — Lean Principle",
    "student": "Nguyễn Văn Hải",
    "mssv": "DTC235180063",
    "class": "KTPMK22C",
    "timestamp": "2026-10-16T02:35:00.310Z",
    "node_version": "v18.20.8",
    "platform": "linux"
  }
  ```

#### 3.3. Thực thi Build & Chạy Container
1. **Lệnh build image:**
   ```bash
   docker build -t devops-lab2-app .
   ```
   *Quá trình build diễn ra trong 7.2 giây, tạo ra image `devops-lab2-app:latest` với dung lượng tối ưu 174MB.*
2. **Lệnh chạy container:**
   ```bash
   docker run -d -p 3000:3000 --name lab2-app devops-lab2-app
   ```
3. **Kiểm tra dịch vụ:**
   ```bash
   curl http://localhost:3000
   ```
   *Kết quả trả về HTTP 200 kèm payload JSON chuẩn từ môi trường Linux Alpine.*

#### 3.4. Bảng So sánh Giá trị Lean của Docker

| Tiêu chí | Không có Docker (Lãng phí) | Có Docker (Lean - Tinh gọn) |
| :--- | :--- | :--- |
| **Cài đặt môi trường** | Cài Node.js, thư viện thủ công trên từng máy. | Node.js và môi trường đóng gói sẵn trong Image. |
| **Tính nhất quán** | "Trên máy tôi chạy bình thường mà!" | Môi trường giống hệt nhau 100% trên mọi máy tính. |
| **Xung đột hệ điều hành**| Dev dùng Windows, Server dùng Linux → dễ lỗi. | Docker chạy Linux Container đồng nhất ở mọi nơi. |
| **Thời gian bắt đầu** | Mất từ 30 - 60 phút cài đặt môi trường. | Chỉ mất **5 giây** chạy lệnh `docker run`. |
| **Kiểm soát phiên bản** | Dễ bị lệch version giữa các lập trình viên. | Phiên bản runtime và thư viện cố định trong Dockerfile. |

---

### BƯỚC 4: DevOps Toolchain Map & Tổng kết CALMS

#### 4.1. Bảng phân loại 13 Công cụ DevOps cốt lõi

| Giai đoạn | Công cụ | Đã áp dụng ở Lab | Mục đích chính |
| :--- | :--- | :---: | :--- |
| **Plan** | GitHub Projects | Toàn khóa | Lập kế hoạch, quản lý backlog, task và roadmap |
| **Code** | Git + GitHub | Lab 1, 5 | Hệ thống quản lý mã nguồn phân tán (VCS) |
| **Code** | VS Code | Lab 2 | Môi trường phát triển tích hợp (IDE) |
| **Build** | Maven | Lab 7 | Biên dịch, giải quyết phụ thuộc & đóng gói dự án Java |
| **Test** | Postman / Newman | Lab 6 | Kiểm thử tự động hóa API và tích hợp CI |
| **Test** | SonarQube | Lab 6, 7 | Phân tích chất lượng mã nguồn tĩnh (SAST, Code Smells) |
| **Test** | OWASP ZAP | Lab 6 | Quét tự động các lỗ hổng bảo mật ứng dụng web (DAST) |
| **Deploy** | Docker Desktop | Lab 2, 7, 8 | Đóng gói và container hóa ứng dụng độc lập |
| **Deploy** | Terraform | Lab 3 | Khởi tạo và quản lý hạ tầng dưới dạng mã (IaC) |
| **Deploy** | AWS Cloud | Lab 3 | Hạ tầng điện toán đám mây công cộng linh hoạt |
| **CI/CD** | GitHub Actions | Lab 1 | Tự động hóa CI/CD pipeline đám mây miễn phí |
| **CI/CD** | Jenkins | Lab 7 | Hệ thống máy chủ điều phối CI/CD chuyên nghiệp |
| **Artifact**| Nexus Repository | Lab 7 | Lưu trữ, quản lý và phân phối Artifacts / Packages |

#### 4.2. Bảng Tổng kết CALMS trong Thực tế

| Trụ cột CALMS | Hoạt động đã thực hiện | Lab minh chứng |
| :--- | :--- | :---: |
| **C - Culture** | Quy trình phối hợp nhóm với Git Flow, Pull Request và Code Review | Lab 5 |
| **A - Automation** | Xây dựng CI/CD pipeline tự động build, validate và deploy website | Lab 1 |
| **A - Automation** | Viết script tự động hóa khởi tạo môi trường dev (`setup-dev-env.sh`/`.ps1`) | **Lab 2** |
| **L - Lean** | Ứng dụng Docker loại bỏ lãng phí *"It works on my machine"*, tối ưu build cache | **Lab 2** |
| **L - Lean** | Tự động hóa hạ tầng qua Terraform (IaC) thay vì click cấu hình thủ công | Lab 3 |
| **M - Measurement**| Đo lường chất lượng mã nguồn qua SonarQube metrics và Newman test report | Lab 6 |
| **M - Measurement**| Đo lường thời gian thực thi pipeline, build duration và success rate | Lab 7 |
| **S - Sharing** | Chia sẻ và đánh giá mã nguồn thông qua Code Review trên GitHub | Lab 5 |
| **S - Sharing** | Xây dựng DevOps Toolchain Map và tài liệu hóa tri thức cho nhóm phát triển | **Lab 2** |

---

### BƯỚC 5: Tự đánh giá Mức độ Trưởng thành CALMS (Self-Assessment)

#### 5.1. Bảng chấm điểm DevOps Maturity (Thang điểm 1 - 5)

| Trụ cột CALMS | 1 (Yếu) | 3 (Trung bình) | 5 (Xuất sắc) | Điểm tự chấm |
| :--- | :--- | :--- | :--- | :---: |
| **Culture (Văn hóa)** | Dev và Ops đổ lỗi cho nhau khi có sự cố | Dev và Ops ngồi chung team, có trao đổi | Mọi thành viên cùng chịu trách nhiệm sản phẩm trên Production | **4 / 5** |
| **Automation (Tự động)** | Triển khai thủ công 100% bằng tay | Có CI/CD cho một vài dự án | Toàn bộ quy trình build, test, deploy tự động hóa 100% | **4 / 5** |
| **Lean (Tinh gọn)** | Setup môi trường mất > 1 ngày | Có script hỗ trợ, dùng Docker một phần | Chỉ cần 1 lệnh duy nhất → môi trường sẵn sàng trong 30 giây | **4 / 5** |
| **Measurement (Đo lường)**| Không biết ứng dụng có đang sống hay chết | Có theo dõi cơ bản qua log tệp tin | Dashboard giám sát thời gian thực + hệ thống cảnh báo alert | **3 / 5** |
| **Sharing (Chia sẻ)** | Kiến thức phân mảnh, cá nhân giữ riêng | Có tài liệu wiki nội bộ, họp giao ban | Code review bắt buộc + văn hóa post-mortem chia sẻ sự cố | **4 / 5** |
| **TỔNG ĐIỂM** | | | | **19 / 25 Điểm** |

> **Nhận xét:** Mức điểm **19/25** phản ánh mức độ trưởng thành DevOps ở mức **Khá - Tốt**. Đội ngũ đã làm chủ công nghệ tự động hóa và container hóa, cần tập trung nâng cao khả năng quan sát (Observability/Measurement) trong các giai đoạn tiếp theo.

#### 5.2. Kế hoạch 3 Hành động Cụ thể để Cải thiện DevOps Maturity
1. **Hành động 1 (Tối ưu Lean & Môi trường):** Chuẩn hóa 100% môi trường phát triển cho tất cả các dịch vụ backend/frontend bằng Dockerfile và `docker-compose.yml`, kết hợp tính năng VS Code Dev Containers để loại bỏ triệt để lỗi môi trường cho người mới.
2. **Hành động 2 (Tăng cường Automation & Test):** Mở rộng kịch bản kiểm thử tự động (Unit Test, API Integration Test với Newman, kiểm tra bảo mật tĩnh với SonarQube) tích hợp thành các gate kiểm soát bắt buộc trong CI/CD pipeline trước khi mã được hợp nhất.
3. **Hành động 3 (Nâng cấp Measurement & Monitoring):** Triển khai hệ thống giám sát tập trung sử dụng Prometheus kết hợp dashboard Grafana, cài đặt cảnh báo tức thời qua Slack/Telegram khi các chỉ số tài nguyên (CPU, RAM) hoặc tỷ lệ lỗi (HTTP 5xx) vượt ngưỡng quy định.

---

## IV. TỔNG KẾT ĐÁNH GIÁ THEO TIÊU CHÍ BÀI LAB

| # | Tiêu chí đánh giá | Trọng số | Tự đánh giá | Minh chứng cụ thể |
| :---: | :--- | :---: | :---: | :--- |
| 1 | **Toolchain** — VS Code + Git + Docker cài đặt OK | 20% | **20/20** | Cả 3 công cụ đều hiển thị phiên bản chính xác qua script test. |
| 2 | **Automation Script** — Kịch bản chạy thành công | 25% | **25/25** | Script `setup-dev-env.sh`/`.ps1` tạo đủ `src/`, `tests/`, `docs/`, `.gitignore`, `README.md`. |
| 3 | **Docker App** — Build và chạy container | 25% | **25/25** | Image `devops-lab2-app` build thành công, container chạy và curl trả về JSON chuẩn. |
| 4 | **Toolchain Map** — Vẽ sơ đồ các giai đoạn & công cụ | 15% | **15/15** | Đầy đủ 6 giai đoạn, bao gồm hơn 13 công cụ DevOps và hệ thống điều phối CI/CD. |
| 5 | **CALMS Assessment** — Tự đánh giá + kế hoạch cải thiện | 15% | **15/15** | Hoàn thành bảng đánh giá 5 trụ cột (19/25) và nêu chi tiết 3 hành động cải tiến. |
| **TỔNG CỘNG** | | **100%** | **100/100 (Xuất sắc)** | |
