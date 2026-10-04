Bảng Hướng Dẫn Sử Dụng Thư Viện UI
Tên Chức Năng	                          Cú Pháp (Code Mẫu)	                                               | Giải Thích Chi Tiết
Khởi tạo Window	                        local Window = Library:CreateWindow("Tên Menu")	                   | Tạo khung cửa sổ chính (ScreenGui & MainFrame) cho UI của bạn.
Thêm Tab	                              local Tab = Window:AddTab("Tên Tab")	                             | Tạo một tab mới nằm ở cột Sidebar bên trái.
Thêm Section	                          Tab:AddSection("Tên Phân Mục")	                                   | Tạo tiêu đề phân chia các cụm chức năng bên trong tab, có kèm đường viền trắng.
Thêm Toggle	                            Tab:AddToggle("Tên Toggle", false, function(state)<br>    print("Trạng thái:", state)<br>end)	|  Tạo nút bật/tắt. Callback nhận giá trị true hoặc false khi người dùng bấm.
Thêm Slider	                            Tab:AddSlider("Tên Slider", 0, 100, 50, function(value)<br>    print("Giá trị:", value)<br>end)	  |  Tạo thanh trượt chỉnh số: Min → Max → Giá trị mặc định → Callback trả về số hiện tại.
Thêm Dropdown	                          Tab:AddDropdown("Tên Dropdown", {"Lựa chọn 1", "Lựa chọn 2", "Lựa chọn 3"}, "Lựa chọn 1", function(selected)<br>    print("Đã chọn:", selected)<br>end) |	Tạo menu thả xuống để chọn mục. Danh sách dùng dạng bảng {...}, có giá trị mặc định và callback trả về lựa chọn.
