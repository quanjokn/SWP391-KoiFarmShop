--
use master
DROP DATABASE KoiFarmShop
--
CREATE DATABASE KoiFarmShop

use KoiFarmShop
go
-- User
-- cái này là bảng để lưu trữ các account cho tất cả actor 
CREATE TABLE Users (
    userID VARCHAR(50) PRIMARY KEY NOT NULL,
    password VARCHAR(255) NOT NULL,
	id INT NOT NULL, -- Customers(id) or Staffs(id)
	role VARCHAR(50) NOT NULL
);

--  Customers
CREATE TABLE Customers (
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    address VARCHAR(255),
    email VARCHAR(255) NOT NULL,
	role VARCHAR(50) DEFAULT 'Customer',
	status BIT DEFAULT 1
);

--  Staffs
CREATE TABLE Staffs (
    id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    name VARCHAR(255),
    phone VARCHAR(50) NOT NULL,
    address VARCHAR(255),
    email VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL, -- Manager, Staff
	status BIT DEFAULT 1
);

-- ServiceOrders
CREATE TABLE ServiceOrders(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	customerID INT FOREIGN KEY REFERENCES Customers(id) ON DELETE NO ACTION,
	staffID INT FOREIGN KEY REFERENCES Staffs(id) ON DELETE NO ACTION,
	category VARCHAR(50) NOT NULL, -- 'Care' or 'Consign'
	status BIT DEFAULT 0
)

-- CaredKoi
CREATE TABLE CaredKoi (
	id INT PRIMARY KEY IDENTITY(1,1),
    serviceOrderID INT FOREIGN KEY REFERENCES ServiceOrders(id),
    name VARCHAR(255) NOT NULL,
    sex VARCHAR(50) NOT NULL,
    age VARCHAR(50) NOT NULL,
    size VARCHAR(50) NOT NULL,
    healthStatus VARCHAR(255) NOT NULL,
    ration VARCHAR(255) NOT NULL,
	customerID INT NOT NULL,
	startDate DATE NOT NULL,
	endDate DATE NOT NULL,
	status BIT DEFAULT 1
);

-- Fishes
CREATE TABLE Fishes(
	id INT PRIMARY KEY IDENTITY(1,1),
	category VARCHAR(50) NOT NULL -- 'Batch'/'Koi'/'ConsignedKoi'
)

-- Species 
CREATE TABLE Species(
	id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(255) NOT NULL, --'Tancho'....
)

-- Origins
CREATE TABLE Origins(
	id INT PRIMARY KEY IDENTITY(1,1),
	origin VARCHAR(50) NOT NULL, -- 'Purebred imported', 'Purebred Viet', 'F1'
)

-- Koi
CREATE TABLE Kois (
    id INT FOREIGN KEY REFERENCES Fishes(id),
	PRIMARY KEY(id),
    name VARCHAR(255) NOT NULL,
	quantity INT NOT NULL,
    description TEXT NOT NULL,
    speciesID INT FOREIGN KEY REFERENCES Species(id),
    originID INT FOREIGN KEY REFERENCES Origins(id),
    sex VARCHAR(50) NOT NULL,
    age VARCHAR(50) NOT NULL,
    character VARCHAR(255) NOT NULL,
    size VARCHAR(50) NOT NULL,
    price FLOAT NOT NULL,
    healthStatus VARCHAR(255) NOT NULL,
    ration TEXT NOT NULL,
	photo VARCHAR(50) NOT NULL,
    video VARCHAR(50) NOT NULL,
    certificate VARCHAR(50) NOT NULL,
	status bit DEFAULT 1
);

--ConsignedKois
CREATE TABLE ConsignedKois (
    id INT FOREIGN KEY REFERENCES Fishes(id),
	PRIMARY KEY(id),
	serviceOrderID INT FOREIGN KEY REFERENCES ServiceOrders(id) ON DELETE NO ACTION,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    speciesID INT FOREIGN KEY REFERENCES Species(id),
    originID INT FOREIGN KEY REFERENCES Origins(id),
    sex VARCHAR(50) NOT NULL,
    age VARCHAR(50) NOT NULL,
    character VARCHAR(255) NOT NULL,
    size VARCHAR(50) NOT NULL,
    price FLOAT NOT NULL,
    healthStatus VARCHAR(255) NOT NULL,
    ration TEXT NOT NULL,
	photo VARCHAR(50) NOT NULL,
    video VARCHAR(50) NOT NULL,
    certificate VARCHAR(50) NOT NULL,
	status bit DEFAULT 1,
	customerID INT NOT NULL
);

--  BatchKoi
CREATE TABLE Batches (
    id INT FOREIGN KEY REFERENCES Fishes(id),
	PRIMARY KEY(id),
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
	originID INT NOT NULL,
	sex VARCHAR(50) NOT NULL,
    age VARCHAR(50) NOT NULL,
    character VARCHAR(255) NOT NULL,
    size VARCHAR(50) NOT NULL,
    price FLOAT NOT NULL,
    healthStatus VARCHAR(255) NOT NULL,
    ration TEXT NOT NULL,
	photo VARCHAR(50) NOT NULL,
    video TEXT NOT NULL,
	status bit DEFAULT 1
);

-- SpeciesBatches
CREATE TABLE SpeciesBatches(
	bactchID INT FOREIGN KEY REFERENCES Batches(id),
	speciesID INT FOREIGN KEY REFERENCES Species(id),
	PRIMARY KEY(bactchID,speciesID)
)

--  Order
CREATE TABLE Orders (
    id INT PRIMARY KEY IDENTITY(1,1),
    customerID INT FOREIGN KEY REFERENCES Customers(id) ON DELETE NO ACTION,
    staffID INT FOREIGN KEY REFERENCES Staffs(id) ON DELETE NO ACTION,
    date DATE NOT NULL,
    total FLOAT NOT NULL,
    status VARCHAR(50) DEFAULT 'Confirming'-- 'Confirming' 'Deliverying' 'Completed' 
);

--  OrderDetail
CREATE TABLE OrderDetails (
    id INT PRIMARY KEY NOT NULL,
    orderID INT FOREIGN KEY REFERENCES Orders(id) ON DELETE CASCADE,
    fishID INT FOREIGN KEY REFERENCES Fishes(id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    price FLOAT NOT NULL
);

-- Blogs
CREATE TABLE Blogs(
	id INT PRIMARY KEY IDENTITY(1,1),
	title TEXT NOT NULL,
	content TEXT NOT NULL,
	staffID INT FOREIGN KEY REFERENCES Staffs(id),
	date DATE NOT NULL
)

--  RatingFeedback
CREATE TABLE RatingFeedback (
    id INT PRIMARY KEY IDENTITY(1,1),
    fishID INT FOREIGN KEY REFERENCES Fishes(id) ON DELETE CASCADE,
    customerId INT FOREIGN KEY REFERENCES Customers(id) ON DELETE CASCADE, 
    description TEXT NOT NULL,
    rating FLOAT NOT NULL
);

--- INSERT TABLE
INSERT INTO Customers (name, phone, email, role, status) 
VALUES 
('Cao The Quan', '0773363666', 'quanctse182750@fpt.edu.vn', 'Customer', 1),
('Van Kinh Kiet', '0987654321', 'kietvkse182744@fpt.edu.vn', 'Customer', 1);

INSERT INTO Staffs (name, phone, email, role, status)
VALUES 
('Nguyen Quoc Son', '0123456789', 'david.black@example.com', 'Manager', 1),
('Doan Minh Khoi', '0123456789',  'sarah.blue@example.com', 'Staff', 1),
('Nguyen Khanh Vinh', '0123456789', 'kevin.red@example.com', 'Staff', 1);

INSERT INTO Users
VALUES
('quanct', '1', 1, 'Customer'),
('kietvk', '1', 2, 'Customer'),
('sonnq', '1', 1, 'Manager'),
('khoidm', '1', 2, 'Staff'),
('vinhnk', '1', 3, 'Staff');

INSERT INTO Species(name)
VALUES
('Koi Ogon'),('Koi Showa'),('Koi Tancho'),('Koi Bekko'),('Koi Kohaku'),('Koi Platinum');

INSERT INTO Origins
VALUES
('Imported purebred'),('Viet Purebred'),('F1');

INSERT INTO Fishes
VALUES
('Koi'),('Koi'),('Koi'),('Koi'),('Koi'),('Koi'),('Koi'),('Koi'),
('Koi'),('Koi'),('Koi'),('Koi'),('Koi'),('Koi'),('Koi'),
('Koi'),('Koi'),('Koi'),('Batch'),('Batch');

INSERT INTO Kois(id, name, quantity, description,speciesID,originID,sex,age,character,size,price,healthStatus,ration,photo,video,certificate)
VALUES 
(1, 'Koi Tancho Kohaku 84cm 4 tuổi', 15, 'Em koi Tancho Kohaku có kích thước 84 cm được 4 năm tuổi có nguồn gốc từ Dainichi koi farm Nhật Bản. Đây là  em koi có hình thể đẹp mắt, dù mới 4 tuổi nhưng kích thước đã lên đến 84cm. Hoa văn đẹp, màu sắc rõ nét, hình thể đẹp, khỏe mạnh, vạm vỡ, body rắn chắc.',
3, 3, 'Koi cái', '4 tuổi', 'hài hòa', '55 cm', 1700000, 'khỏe mạnh','dễ ăn', '\Tancho_1.jpg', 'https://www.youtube.com/watch?v=z-MzacjOO6k', '\certificate_Tancho_1.jpg'),
(2, 'Koi Tancho Sanke 55cm 3 tuổi', 10, 'Đây là em Koi Tancho Sanke có rất nhiều ưu điểm vượt trội được chúng tôi nhập về từ Dainichi Koi Farm. Mặc dù em ấy mới 2 năm tuổi nhưng đã có kích thước 53 cm, chứng tỏ em ấy được nuôi dưỡng, chăm sóc rất tốt.',
3, 3, 'Koi Cái', '3 tuổi', 'hiền lành, hài hoà', '55 cm', 700000 , 'khoẻ mạnh', 'dễ ăn','\Tancho_2.jpg','https://www.youtube.com/watch?v=7eG2rhMfuqo', '\certificate_Tancho_2.jpg'),
(3, 'Tancho 55cm 2 tuổi', 10 , 'Rắn chắc, khỏe mạnh thể hiện đúng 1 em koi tancho được nuôi theo tiêu chuẩn: Dầy mình, thân đuôi dày, không ngắn, không quá dài, lưng gù, vây bơi nhẹ nhàng, dáng bơi thẳng mà vẫn uốn lượn.',3, 3, 'Koi đực', '2 tuổi', 'hài hòa', '55 cm', 900.000 , 'Sống rất khỏe 20 – 40 năm.','dễ ăn', '\Tancho_3.jpg', 'https://www.youtube.com/watch?v=rY6ib8Xdc4c', '\certificate_Tancho_3.jpg'),
(4, 'Koi Shiro Bekko 86 cm 3 tuổi', 20, 'Koi Shiro Bekko 86 cm 3 tuổi – nữ với body màu trắng kết hợp với sumi vệt đen điểm xuyết hài hòa. Em koi Bekko trắng vệt đen này trông như bức tranh phong thủy nguyên sơ vẽ bằng mực đen mang đến sự tao nhã, thanh thoát, theo phong thủy koi Bekko được coi là loài cá tượng trưng cho may mắn.',
4, 1, 'Koi Cái', '3 tuổi', 'hiền lành, hài hoà', '55 cm', 1500000 , 'khoẻ mạnh', 'dễ ăn','\Bekko_1.jpg','https://www.youtube.com/watch?v=6ldzUd7o0lM', '\certificate_Bekko_1.jpg'),
(5, 'Koi Bekko 80 cm 3 tuổi', 10, 'Em Koi gây ấn tượng mạnh mẽ bởi sắc màu đỏ rực rõ vô cùng cuốn hút và nổi bật, trong giống Bekko thì Bekko màu đỏ luôn được ưa chuộng nhất và rất quý hiếm. Em Koi Bekko 3 năm tuổi này đã đạt tới kích thước 80 cm giới tính Koi cái, với khả năng phát triển nhanh.',
4, 1, 'Koi Cái', '3 tuổi', 'hiền lành, hài hoà', '80 cm', 2500000 , 'khoẻ mạnh', 'Khó ăn, cần chăm sóc kĩ','\Bekko_2.png','https://www.youtube.com/watch?v=stRFguInQhs', '\certificate_Bekko_2.png'),
(6, 'Koi Bekko 65 cm 2 tuổi', 5, 'Em Koi Bekko màu cam này chắc chắn sẽ là điểm nhấn cho hồ Koi của bạn bởi sắc màu cam nổi, sáng rực rỡ kết hợp với các đốm đen sumi xuất hiện đồng đều dọc thân tạo ấn tượng mạnh. Em Koi Bekko mới 2 năm tuổi nhưng chiều dài đã đạt tới 65 cm, màu sắc đậm và sâu chứng tỏ sẽ có khả năng phát triển với kích cỡ lớn. Dòng koi Bekko khi càng lớn kích thước càng tăng lên nhưng màu sắc vẫn đậm đẹp với điều kiện là môi trường sống và nguồn thức ăn cho Bekko phải phù hợp.',
4, 3, 'Koi Cái', '2 tuổi', 'hiền lành, hài hoà', '65 cm', 1700000 , 'khoẻ mạnh', 'Khó ăn, cần chăm sóc kĩ','\Bekko_3.jpg','https://www.youtube.com/watch?v=Nn5hwO-fe7E', '\certificate_Bekko_3.jpg'),
(7, 'Oofuri Goromo 60cm 3 năm tuổi', 7 , 'Koi Oofuri Goromo 60cm 3 năm tuổi  sở hữu lớp Hi rải đều body, nền da trắng như sứ và hàng vảy đẹp long lanh. Tính cách của em ấy cũng rất điềm đạm', 3, 3, 'Koi cái', '3 tuổi', 'điềm đạm', '75 cm', 2700000 , 'khoẻ mạnh','Khó ăn, cần chăm sóc kĩ', '\Platinum_1.jpg', 'https://youtube.com/watch?v=XNEuxHEYKic', '\certificate_Platinum_1.jpg'),
(8, 'Budo goromo 80cm 3 năm tuổi', 9 , 'Budo Goromo này nổi bật với màu đen nổi trên nền đỏ, nước da trắng như tuyết và nền Hi đỏ như son. Body giống như chiếc tàu ngầm, vây đuôi dài và sắc cho thấy rất nhiều hứa hẹn và cơ hội phát triển thành một Koi hoàn hảo trong g tương lai. Sau khoảng 1-2 năm nữa, bạn sẽ nhận thấy sự thay đổi rõ rệt về màu sắc và body. Vì vậy, nếu như chọn Koi Goromo không chuẩn, tỉ lệ thành công để có được một Koi đẹp như mong muốn sẽ rất khó. Việc lựa chọn địa chỉ mua Koi chuẩn là hoàn toàn cần thiết.',6, 1, 'Koi cái', '3 tuổi', 'điềm đạm', '80 cm', 3300000, 'khoẻ mạnh','Khó ăn, cần chăm sóc kĩ', '\Platinum_2.jpg', 'https://www.youtube.com/watch?v=tK4k11e_BfA', '\certificate_Platinum_2.jpg'),
(9, 'Ai goromo 82cm 3 năm tuổi', 10 , 'Koi Ai Goroma 3 tuổi, đạt kích thước lên tới 72 cm, nổi bật với vẻ ngoài dịu dàng và nhã nhặn. Ngoài tên gọi Goromo thì em này còn có tên gọi khác là Koromo, có nhiều loại khác nhau nhưng dòng nổi tiếng nhất là Koi Ai Goromo. Chúng tôi cam kết, chỉ cung cấp những em Koi Goromo nhập khẩu chuẩn từ trang trại Dainichi danh tiếng tại Nhật Bản, sẵn sàng đền bù gấp 10 lần nếu không phải Koi Nhật chuẩn',6, 1, 'Koi cái', '3 tuổi', 'điềm đạm', '82 cm', 3200000, 'khoẻ mạnh','Khó ăn, cần chăm sóc kĩ', '\Platinum_3.jpg',  'https://www.youtube.com/watch?v=Dm5IM4ZxDDs', '\certificate_Platinum_3.jpg'),
(10, 'Kuchibeni Kohaku 50cm 3 tuổi',12,' Kuchibeni Kohaku là một biến thể độc đáo của dòng cá Koi Kohaku, với đặc điểm nổi bật là có một mảng màu đỏ trên miệng, giống như cá đang thoa son, khiến chúng được mệnh danh là “Kohaku thoa son môi” (Kuchibeni trong tiếng Nhật nghĩa là “son môi”).', 4, 3, 'Koi cái', '3 tuổi' , 'điềm tĩnh', '50cm', 8000000 , 'hô hấp tốt','ăn tạp','\Kohaku_1.jpg', 'https://www.youtube.com/watch?v=ie6Ylu_B_Ok', '\certificate_Kohaku_1.jpg'),
(11, 'Maruten Kohaku 45cm 3 tuổi',10,' Maruten Kohaku là một loại cá Koi thuộc dòng Kohaku, một trong những dòng cá Koi nổi tiếng và được ưa chuộng nhất. Điểm đặc biệt của Maruten Kohaku nằm ở hoa văn của nó, đặc biệt là mảng đỏ tròn trên đầu, tạo nên sự khác biệt so với các loại Kohaku thông thường.', 4, 3, 'Koi cái', '3 tuổi' , 'thân thiện', '45cm', 7500000 , 'khỏe mạnh','ăn tạp','\Kohaku_2.jpg', ' https://www.youtube.com/watch?v=QvIMmAUs1Zg','\certificate_Kohaku_2.jpg'),
(12, 'Nidan Kohaku 48cm 4 tuổi',15,' Nidan Kohaku là một trong những biến thể của cá Koi thuộc dòng Kohaku, nổi bật với hoa văn đặc biệt chỉ có hai mảng màu đỏ (Hi) trên nền trắng. Tên gọi "Nidan" trong tiếng Nhật có nghĩa là "hai bước," ám chỉ đến hai mảng màu rõ ràng trên thân cá.', 4, 3, 'Koi cái', '3 tuổi' , 'hòa đồng', '48cm', 9000000 , 'khỏe mạnh','dễ ăn','\Kohaku_3.jpg', ' https://www.youtube.com/watch?v=zkdkPigEMGA','\certificate_Kohaku_3.jpg'),
(13, 'Yamabuki Ogon 45cm 3 tuổi',8,' Yamabuki Ogon là một trong những dòng cá Koi thuộc nhóm Hikari Muji, nổi tiếng với màu vàng kim sáng lấp lánh trên toàn thân. Loại cá này được yêu thích vì vẻ đẹp thuần khiết và sự lấp lánh khi bơi trong nước, đặc biệt dưới ánh sáng tự nhiên.', 1, 3, 'Koi cái', '3 tuổi' , 'thân thiện', '45cm', 9500000 , 'khỏe mạnh','ăn tạp','\Ogon_1.jpg', ' https://www.youtube.com/watch?v=am23cYhPZz0','\certificate_Ogon_1.jpg'),
(14, 'Orenji Ogon 30cm 2 tuổi',10,' Orenji Ogon là một trong những loại cá Koi thuộc nhóm Hikari Muji, nổi bật với màu cam rực rỡ. Màu cam này có thể dao động từ sáng đến đậm, và màu sắc nên đồng đều trên toàn bộ cơ thể cá thường lấp lánh và có độ phản chiếu ánh sáng tốt, tạo sự nổi bật trong hồ cá.', 1, 3, 'Koi đực', '2 tuổi' , 'hòa đồng', '30cm', 5000000, 'khỏe mạnh','dễ ăn','\Ogon_2.jpg', ' https://www.youtube.com/watch?v=7WyAHfbbCH4','\certificate_Ogon_2.jpg'),
(15, 'Nezu Ogon 33cm 2 tuổi',10,' Nezu Ogon là một giống cá Koi thuộc nhóm Hikari Muji, nổi bật với màu sắc xám bạc hoặc bạc hồng nhạt. Đây là một giống cá có vẻ đẹp đơn giản nhưng rất tinh tế, thường được ưa chuộng trong hồ cá vì sự sang trọng và sự phối hợp màu sắc độc đáo của nó.', 1, 3, 'Koi đực', '2 tuổi' , 'điềm tĩnh', '33cm', 6000000, 'hô hấp tốt','ăn tạp','\Ogon_3.jpg', ' https://www.youtube.com/watch?v=80pE1CZ0L0s','\certificate_Ogon_3.jpg'),
(16, 'Tancho Showa 37cm 2 tuổi', 10 , 'Tancho Showa là một trong những loại cá Koi thuộc nhóm Showa, nổi bật với đặc điểm màu sắc và kiểu dáng độc đáo. Điểm đặc trưng là có một đốm đỏ (Tancho) nằm trên đầu, thường ở giữa trán, giống như một dấu ấn đỏ trên màu trắng hoặc đen. Đốm đỏ này là điểm nhấn nổi bật và tạo nên sự khác biệt với các loại Showa khác.',2, 3, 'Koi cái', '2 tuổi', 'Điềm tĩnh , thân thiện', '37 cm', 9800000, 'Sống rất khỏe 20 – 40 năm.','mùa ấm  2-3 lần/ ngày , mùa lạnh 1 lần / ngày', '\Showa_1.jpg', 'https://www.youtube.com/watch?v=GyjmDI2FzwQ', '\certificate_Showa_1.jpg'),
(17, 'Doitsu Showa 39cm 3 tuổi', 10 , 'Tancho Showa là một trong những loại cá Koi thuộc nhóm Showa, nổi bật với đặc điểm màu sắc và kiểu dáng độc đáo. Điểm đặc trưng là có một đốm đỏ (Tancho) nằm trên đầu, thường ở giữa trán, giống như một dấu ấn đỏ trên màu trắng hoặc đen. Đốm đỏ này là điểm nhấn nổi bật và tạo nên sự khác biệt với các loại Showa khác.',2, 3, 'Koi đực', '3 tuổi', 'Điềm tĩnh , thân thiện', '39 cm', 9800000, 'Sống rất khỏe 20 – 40 năm.','mùa ấm  2-3 lần/ ngày , mùa lạnh 1 lần / ngày', '\Showa_2.jpg', 'https://www.youtube.com/watch?v=GyjmDI2FzwQ', '\certificate_Showa_2.jpg'),
(18, 'Hi Showa 40cm 3 tuổi', 10 , 'Hi Showa là một biến thể của giống cá Koi Showa, nổi bật với các đặc điểm màu sắc độc đáo. Hi Showa có màu nền chủ yếu là đỏ (Hi), với các vùng màu đen (Kuro) và trắng (Shiro) tạo nên sự tương phản rõ rệt.',2, 3, 'Koi cái', '3 tuổi', 'Điềm tĩnh , thân thiện', '40 cm', 12000000, 'Sống rất khỏe 20 – 40 năm.','mùa ấm  2-3 lần/ ngày , mùa lạnh 1 lần / ngày', '\Showa_3.jpg', 'https://www.youtube.com/watch?v=8OT7H7btA94', '\certificate_Showa_3.jpg');


INSERT INTO Batches(id, name, description,originID,sex,age,character,size,price,healthStatus,ration,photo,video)
VALUES 
(19, 'Lô koi Showa, Kohaku 75 đến 80 cm', 'Đây là Lô koi Showa, kohaku Onkoi may mắn đấu giá thành công tại sự kiện Dainichi Cup lần thứ 33 ở Nhật Bản. Lô koi bao gồm những em koi thuộc hàng tuyển loại 1 có kích thước 75 – 80 cm.',
1,'Koi Cái', '3 tuổi', 'hài hòa nên dễ kết hợp nuôi với các loài koi khác.', '75-80 cm', 90000000 , 'khoẻ mạnh', 'ăn tạp, dễ nuôi', 'Batch_1.jpg',
'https://www.youtube.com/watch?v=KBtl0k08G7Y&list=TLGGWOl1GfLv3NYxOTA5MjAyNA');
INSERT INTO Batches(id, name, description,originID,sex,age,character,size,price,healthStatus,ration,photo,video)
VALUES 
(20, 'Onkoi lô 3 em Shiro Ogon 78cm 3 tuổi', 'OnKoi tiếp tục lên sàn lô 3 em koi Shiro Utsuri 78 cm 3 năm tuổi (rất giống với những em bò sữa Bekko Koi), hứa hẹn sẽ có kích thước vượt trội trong tương lai.',
1,'Koi Cái', '3 tuổi', 'hài hòa nên dễ kết hợp nuôi với các loài koi khác.', '78 cm', 100000000 , 'Cũng như những koi Hi Utsuri, cá Koi Shiro Utsuri trung bình đạt 35 – 50 năm tuổi.', 'ăn tạp, dễ nuôi. Koi nên được cho ăn các loại thực phẩm khác nhau hoặc hoàn toàn không dựa trên nhiệt độ nước và thời gian trong năm. Vào mùa xuân và mùa thu, Koi nên được cho ăn thức ăn có hàm lượng protein thấp hơn và dễ tiêu hóa hơn. Nếu nhiệt độ nước 20 ° C, sau đó có thể được cho ăn thực phẩm protein cao hơn. Vào mùa đông khi nhiệt độ nước dưới 10 ° C, hệ thống tiêu hóa của Koi sẽ chậm lại gần như dừng lại và chúng không nên được cho ăn trực tiếp, chúng có thể nhấm nháp một chút trên cây và tảo, nhưng sẽ không cần cho ăn trực tiếp.', 'Batch_2.jpg',
'https://www.youtube.com/watch?v=_wpPIaHFNmA&list=TLGGStE8Razir9YxOTA5MjAyNA');

INSERT INTO SpeciesBatches
VALUES 
(19, 2), (19,5), (20,1);