-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.0.39 - MySQL Community Server - GPL
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- sample 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `sample` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sample`;

-- 테이블 sample.cart 구조 내보내기
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` varchar(50) NOT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.cart:~0 rows (대략적) 내보내기

-- 테이블 sample.cart_items 구조 내보내기
CREATE TABLE IF NOT EXISTS `cart_items` (
  `cart_item_id` varchar(50) NOT NULL,
  `cart_id` varchar(50) DEFAULT NULL,
  `item_id` varchar(50) DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`cart_item_id`),
  KEY `cart_id` (`cart_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`),
  CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `menu_items` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.cart_items:~0 rows (대략적) 내보내기

-- 테이블 sample.inquiries 구조 내보내기
CREATE TABLE IF NOT EXISTS `inquiries` (
  `inquiry_id` varchar(50) NOT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`inquiry_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `inquiries_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.inquiries:~0 rows (대략적) 내보내기

-- 테이블 sample.menu_items 구조 내보내기
CREATE TABLE IF NOT EXISTS `menu_items` (
  `item_id` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.menu_items:~0 rows (대략적) 내보내기

-- 테이블 sample.orders 구조 내보내기
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` varchar(50) NOT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `order_time` datetime NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `delivery_type` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.orders:~0 rows (대략적) 내보내기

-- 테이블 sample.order_items 구조 내보내기
CREATE TABLE IF NOT EXISTS `order_items` (
  `order_item_id` varchar(50) NOT NULL,
  `order_id` varchar(50) DEFAULT NULL,
  `item_id` varchar(50) DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `menu_items` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.order_items:~0 rows (대략적) 내보내기

-- 테이블 sample.reservations 구조 내보내기
CREATE TABLE IF NOT EXISTS `reservations` (
  `reservation_id` varchar(50) NOT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `reservation_time` datetime NOT NULL,
  `party_size` int NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`reservation_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.reservations:~0 rows (대략적) 내보내기

-- 테이블 sample.tbl_board 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_board` (
  `boardNo` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` text,
  `cnt` int DEFAULT '0',
  `userId` varchar(50) NOT NULL,
  `kind` enum('number') NOT NULL,
  `cdatetime` datetime DEFAULT CURRENT_TIMESTAMP,
  `udatetime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`boardNo`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.tbl_board:~9 rows (대략적) 내보내기
INSERT INTO `tbl_board` (`boardNo`, `title`, `contents`, `cnt`, `userId`, `kind`, `cdatetime`, `udatetime`) VALUES
	(2, '두 번째 게시글', '이것은 두 번째 게시글의 내용입니다.', 8, 'user2', 'number', '2024-08-06 10:32:50', '2024-08-06 10:32:50'),
	(3, '세 번째 게시글', '이것은 세 번째 게시글의 내용입니다.', 23, 'user3', 'number', '2024-08-06 10:32:50', '2024-08-06 10:32:50'),
	(4, '네 번째 게시글', '이것은 네 번째 게시글의 내용입니다.', 5, 'user1', 'number', '2024-08-06 10:32:50', '2024-08-06 13:09:01'),
	(5, '다섯 번째 게시글', '이것은 다섯 번째 게시글의 내용입니다.', 9, 'user1', 'number', '2024-08-06 10:32:50', '2024-08-06 13:09:06'),
	(28, '1231231', '1231231', 0, 'admin', 'number', '2024-08-07 17:32:15', '2024-08-07 17:32:15'),
	(30, '555555555555', 'null', 0, 'user1', 'number', '2024-08-09 18:05:02', '2024-08-09 18:05:02'),
	(31, 'null', 'null', 0, 'user1', 'number', '2024-08-10 14:00:38', '2024-08-10 14:00:38'),
	(32, 'null', 'null', 0, 'admin', 'number', '2024-08-23 14:42:14', '2024-08-23 14:42:14'),
	(33, 'null', 'null', 0, 'admin', 'number', '2024-08-23 14:42:56', '2024-08-23 14:42:56'),
	(34, 'null', 'null', 0, 'user1', 'number', '2024-08-23 14:44:18', '2024-08-23 14:44:18'),
	(35, 'null', 'null', 0, 'null', 'number', '2024-09-20 14:38:39', '2024-09-20 14:38:39');

-- 테이블 sample.tbl_feed 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_feed` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `userId` varchar(100) DEFAULT NULL,
  `content` text,
  `cdatetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `favorite` int DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.tbl_feed:~8 rows (대략적) 내보내기
INSERT INTO `tbl_feed` (`user_id`, `userId`, `content`, `cdatetime`, `favorite`) VALUES
	(2, 'test2', '새로운 프로젝트를 시작했어요. 열심히 해야겠어요!', '2024-10-20 01:15:00', 3),
	(3, 'test3', '맛있는 커피 한 잔과 함께 여유로운 아침을 보내고 있어요.', '2024-10-20 02:00:00', 0),
	(4, 'test1', '주말엔 산책이 최고인 것 같아요!', '2024-10-20 04:45:00', 1),
	(5, 'test2', '친구들과 맛있는 저녁을 먹었어요. 정말 즐거운 시간이었어요.', '2024-10-19 09:30:00', 0),
	(6, 'test3', '책을 읽다 보면 시간 가는 줄 몰라요.', '2024-10-18 05:25:00', 0),
	(7, 'test1', '오늘은 운동을 열심히 했어요. 뿌듯하네요!', '2024-10-17 11:00:00', 0),
	(8, 'test1', '드디어 휴가! 이번엔 멀리 여행을 갈 거예요.', '2024-10-16 00:50:00', 0),
	(9, 'test2', '오랜만에 친구를 만났어요. 정말 반가웠어요!', '2024-10-15 08:00:00', 1);

-- 테이블 sample.tbl_person 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_person` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `addr` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.tbl_person:~6 rows (대략적) 내보내기
INSERT INTO `tbl_person` (`id`, `name`, `gender`, `phone`, `addr`) VALUES
	(1, '김민수', 'M', '010-1234-5678', '서울'),
	(2, '이지영', 'F', '010-2345-6789', '인천'),
	(3, '박현우', 'M', '010-3456-7890', '부산'),
	(4, '최수민', 'F', '010-4567-8901', '서울'),
	(5, '정우진', 'M', '010-5678-9012', '대전'),
	(6, '호에에', 'M', NULL, '서울');

-- 테이블 sample.tbl_post 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_post` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `caption` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tbl_post_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.tbl_post:~5 rows (대략적) 내보내기
INSERT INTO `tbl_post` (`post_id`, `user_id`, `image_url`, `caption`, `created_at`) VALUES
	(1, 'test1', 'https://example.com/images/post1.jpg', '첫 번째 게시물입니다!', '2024-10-30 04:06:51'),
	(2, 'test1', 'https://example.com/images/post2.jpg', '두 번째 게시물입니다!', '2024-10-30 04:06:51'),
	(3, 'user1', 'https://example.com/images/post3.jpg', '여행 사진입니다.', '2024-10-30 04:06:51'),
	(4, 'user1', 'https://example.com/images/post4.jpg', '맛있는 음식 사진입니다.', '2024-10-30 04:06:51'),
	(5, 'test1', 'https://example.com/images/post5.jpg', '자연 풍경입니다.', '2024-10-30 04:06:51');

-- 테이블 sample.tbl_student 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_student` (
  `stuNo` varchar(20) NOT NULL,
  `stuName` varchar(50) NOT NULL,
  `stuDept` varchar(100) NOT NULL,
  `stuGrade` int NOT NULL,
  PRIMARY KEY (`stuNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.tbl_student:~8 rows (대략적) 내보내기
INSERT INTO `tbl_student` (`stuNo`, `stuName`, `stuDept`, `stuGrade`) VALUES
	('2024001', '김철수', '컴퓨터학과', 1),
	('2024002', '박영희', '정보통신학과', 2),
	('2024003', '이민호', '컴퓨터학과', 3),
	('2024004', '정수현', '정보통신학과', 4),
	('2024005', '최지은', '컴퓨터학과', 2),
	('2024006', '한서준', '정보통신학과', 1),
	('2024007', '김민지', '컴퓨터학과', 3),
	('2024008', '이동욱', '정보통신학과', 4);

-- 테이블 sample.tbl_user 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_user` (
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pwd` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 테이블 데이터 sample.tbl_user:~8 rows (대략적) 내보내기
INSERT INTO `tbl_user` (`user_id`, `pwd`, `name`, `gender`) VALUES
	('test1', '1234', '철수', 'M'),
	('test2', '1234', NULL, NULL),
	('test22', '1234', '김철수', 'F'),
	('test223', '1234', '655', 'F'),
	('test226', '1234', '6666', 'F'),
	('test23', '1234', '나야나', 'F'),
	('test3', '1234', NULL, NULL),
	('user1', '1234', '홍길동1', 'M');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
