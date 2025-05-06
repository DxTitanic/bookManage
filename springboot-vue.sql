/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : springboot-vue

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 18/04/2022 17:29:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for violation
-- ----------------------------
DROP TABLE IF EXISTS `violation`;
CREATE TABLE `violation`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `book_id` int(0) NOT NULL COMMENT '图书ID',
  `book_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书名称',
  `violation_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '违章类型(逾期未还/图书损坏)',
  `violation_date` datetime(0) NULL DEFAULT NULL COMMENT '违章日期',
  `fine_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '罚款金额',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '处理状态(已处理/未处理)',
  `remarks` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图书编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '作者',
  `publisher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '出版社',
  `create_time` date NULL DEFAULT NULL COMMENT '出版时间',
  `status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0：未归还 1：已归还',
  `borrownum` int(0) NOT NULL COMMENT '此书被借阅次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (9, '12341541321', '十万个为什么', 15.00, '小王', '宁波大学出版社', '2014-12-16', '1', 7);
INSERT INTO `book` VALUES (10, '2312315132131', '五万个为什么', NULL, NULL, NULL, NULL, '1', 3);
INSERT INTO `book` VALUES (11, '25213121232', '一万个为什么', NULL, NULL, NULL, NULL, '1', 5);
INSERT INTO `book` VALUES (12, '3213123123', '操作系统', NULL, NULL, NULL, NULL, '0', 8);
INSERT INTO `book` VALUES (13, '345621212321', '伊索寓言', NULL, NULL, NULL, NULL, '0', 9);
INSERT INTO `book` VALUES (15, '54112312321', '格林童话', NULL, NULL, NULL, NULL, '1', 1);

-- ----------------------------
-- Table structure for bookwithuser
-- ----------------------------
DROP TABLE IF EXISTS `bookwithuser`;
CREATE TABLE `bookwithuser`  (
  `id` bigint(0) NOT NULL COMMENT '读者id',
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书编号',
  `book_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图书名',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '读者姓名',
  `lendtime` datetime(0) NULL DEFAULT NULL COMMENT '借阅时间',
  `deadtime` datetime(0) NULL DEFAULT NULL COMMENT '应归还时间',
  `prolong` int(0) NULL DEFAULT NULL COMMENT '续借次数',
  PRIMARY KEY (`book_name`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bookwithuser
-- ----------------------------
INSERT INTO `bookwithuser` VALUES (14, '345621212321', '伊索寓言', '123456', '2021-12-22 17:30:48', '2022-02-20 17:30:48', 0);
INSERT INTO `bookwithuser` VALUES (14, '3213123123', '操作系统', '123456', '2021-10-12 17:30:42', '2021-12-14 17:30:42', 1);

-- ----------------------------
-- Table structure for lend_record
-- ----------------------------
DROP TABLE IF EXISTS `lend_record`;
CREATE TABLE `lend_record`  (
  `reader_id` bigint(0) NOT NULL COMMENT '读者id',
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图书编号',
  `bookname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书名',
  `lend_time` datetime(0) NULL DEFAULT NULL COMMENT '借书日期',
  `return_time` datetime(0) NULL DEFAULT NULL COMMENT '还书日期',
  `status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '0：未归还 1：已归还',
  `borrownum` int(0) NOT NULL COMMENT '此书被借阅次数'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lend_record
-- ----------------------------
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 10:57:02', '2021-12-18 11:03:54', '1', 2);
INSERT INTO `lend_record` VALUES (13, '465132123123', '狂人日记', '2021-12-18 10:59:21', '2021-12-18 11:22:51', '1', 2);
INSERT INTO `lend_record` VALUES (13, '54156461231', '十万个为什么', '2021-12-18 10:59:21', '2021-12-18 11:04:38', '1', 4);
INSERT INTO `lend_record` VALUES (13, '54156461231', '十万个为什么', '2021-12-18 11:04:40', '2021-12-18 11:05:22', '1', 5);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:04:51', '2021-12-18 11:05:24', '1', 3);
INSERT INTO `lend_record` VALUES (13, '54156461231', '十万个为什么', '2021-12-18 11:05:27', '2021-12-18 11:10:19', '1', 6);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:05:29', '2021-12-18 11:06:09', '1', 4);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:11', '2021-12-18 11:06:38', '1', 5);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:42', '2021-12-18 11:06:52', '1', 6);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:53', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:54', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:54', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:55', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:55', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:55', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:55', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:55', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:55', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:56', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:56', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:56', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (13, '92392321222', '算法笔记', '2021-12-18 11:06:56', '2021-12-18 11:10:20', '1', 7);
INSERT INTO `lend_record` VALUES (14, '12341541321', '十万个为什么', '2021-12-18 16:27:35', '2021-12-21 20:18:58', '1', 1);
INSERT INTO `lend_record` VALUES (14, '2312315132131', '五万个为什么', '2021-12-18 16:27:36', '2021-12-21 20:18:59', '1', 1);
INSERT INTO `lend_record` VALUES (14, '25213121232', '一万个为什么', '2021-12-18 16:27:38', '2021-12-18 16:29:22', '1', 1);
INSERT INTO `lend_record` VALUES (14, '3213123123', '操作系统', '2021-12-18 16:27:40', '2021-12-18 16:29:15', '1', 1);
INSERT INTO `lend_record` VALUES (14, '3213123123', '操作系统', '2021-12-18 16:29:24', '2021-12-21 20:19:01', '1', 2);
INSERT INTO `lend_record` VALUES (14, '25213121232', '一万个为什么', '2021-12-19 11:37:54', '2021-12-21 20:19:00', '1', 2);
INSERT INTO `lend_record` VALUES (14, '345621212321', '伊索寓言', '2021-12-19 11:37:58', '2021-12-19 11:38:42', '1', 1);
INSERT INTO `lend_record` VALUES (15, '345621212321', '伊索寓言', '2021-12-19 13:13:10', '2021-12-19 13:13:26', '1', 2);
INSERT INTO `lend_record` VALUES (14, '12341541321', '十万个为什么', '2021-12-21 20:19:09', '2021-12-22 15:45:35', '1', 2);
INSERT INTO `lend_record` VALUES (14, '25213121232', '一万个为什么', '2021-12-21 20:19:11', '2021-12-22 15:45:32', '1', 3);
INSERT INTO `lend_record` VALUES (14, '2312315132131', '五万个为什么', '2021-12-21 20:20:00', '2021-12-22 15:45:34', '1', 2);
INSERT INTO `lend_record` VALUES (14, '3213123123', '操作系统', '2021-12-21 20:20:01', '2021-12-22 15:45:27', '1', 3);
INSERT INTO `lend_record` VALUES (14, '345621212321', '伊索寓言', '2021-12-21 20:20:02', '2021-12-21 20:20:11', '1', 3);
INSERT INTO `lend_record` VALUES (14, '3213123123', '操作系统', '2021-12-22 15:45:37', '2021-12-22 15:45:39', '1', 4);
INSERT INTO `lend_record` VALUES (14, '3213123123', '操作系统', '2021-12-22 15:46:15', '2021-12-22 15:51:05', '1', 5);
INSERT INTO `lend_record` VALUES (14, '3213123123', '操作系统', '2021-12-22 15:51:12', '2021-12-22 15:51:15', '1', 6);
INSERT INTO `lend_record` VALUES (14, '3213123123', '操作系统', '2021-12-22 15:51:16', '2021-12-22 16:48:09', '1', 7);
INSERT INTO `lend_record` VALUES (14, '25213121232', '一万个为什么', '2021-12-22 16:48:10', '2021-12-22 16:48:13', '1', 4);
INSERT INTO `lend_record` VALUES (14, '345621212321', '伊索寓言', '2021-12-22 16:48:19', '2021-12-22 17:30:46', '1', 4);
INSERT INTO `lend_record` VALUES (14, '3213123123', '操作系统', '2021-12-22 17:30:42', NULL, '0', 8);
INSERT INTO `lend_record` VALUES (14, '345621212321', '伊索寓言', '2021-12-22 17:30:48', NULL, '0', 9);
INSERT INTO `lend_record` VALUES (16, '12341541321', '十万个为什么', '2021-12-23 14:55:34', '2022-04-18 16:36:54', '1', 3);
INSERT INTO `lend_record` VALUES (16, '2312315132131', '五万个为什么', '2021-12-23 14:59:03', '2022-04-18 16:36:55', '1', 3);
INSERT INTO `lend_record` VALUES (16, '25213121232', '一万个为什么', '2021-12-23 14:59:05', '2022-04-18 16:36:56', '1', 5);
INSERT INTO `lend_record` VALUES (17, '54112312321', '格林童话', '2022-01-18 20:02:01', '2022-01-18 20:02:51', '1', 1);
INSERT INTO `lend_record` VALUES (16, '12341541321', '十万个为什么', '2022-04-18 16:37:01', '2022-04-18 16:37:28', '1', 4);
INSERT INTO `lend_record` VALUES (16, '12341541321', '十万个为什么', '2022-04-18 16:37:32', '2022-04-18 16:43:30', '1', 5);
INSERT INTO `lend_record` VALUES (16, '12341541321', '十万个为什么', '2022-04-18 16:43:39', '2022-04-18 16:43:43', '1', 6);
INSERT INTO `lend_record` VALUES (16, '12341541321', '十万个为什么', '2022-04-18 16:44:14', '2022-04-18 16:44:18', '1', 7);

-- ----------------------------
-- Records of violation 违章记录id 用户id 图书id 图书名 违章类型 归还时间 罚款金额 处理状态 备注
-- ----------------------------
INSERT INTO `violation` VALUES (1, 18, 9, '十万个为什么', '逾期未还', '2024-12-18 11:10:20', 10.00, '已处理', '逾期3天');
INSERT INTO `violation` VALUES (2, 14, 12, '操作系统', '图书损坏', '2025-1-22 17:30:48', 50.00, '未处理', '封面损坏');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(50) NOT NULL COMMENT '分类名称',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='图书分类表';

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` (`name`, `create_time`) VALUES 
('文学', '2023-01-21 00:00:00'),
('科技', '2023-02-21 00:00:00'),
('历史', '2023-03-21 00:00:00'),
('艺术', '2023-04-21 00:00:00'),
('计算机', '2023-05-21 00:00:00'),
('经济', '2023-06-21 00:00:00'),
('哲学', '2023-07-21 00:00:00'),
('教育', '2023-08-21 00:00:00'),
('医学', '2023-09-21 00:00:00'),
('法律', '2023-11-21 00:00:00');



-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(100) NOT NULL COMMENT '公告标题',
  `content` TEXT NOT NULL COMMENT '公告内容',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公告表';

-- ----------------------------
-- Records of announcement
-- ----------------------------
INSERT INTO `announcement` (`title`, `content`, `create_time`) VALUES 
('系统维护通知', '系统将于今晚进行维护', '2025-04-12 00:00:00'),
('假期安排', '五一假期图书馆开放时间调整', '2025-04-28 00:00:00');

-- ----------------------------
-- Table structure for policy
-- ----------------------------
DROP TABLE IF EXISTS `policy`;
CREATE TABLE `policy` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL COMMENT '政策名称',
  `borrow_days` INT NOT NULL COMMENT '可借阅天数',
  `renew_days` INT NOT NULL COMMENT '可续借天数',
  `max_renew_times` INT NOT NULL COMMENT '最大续借次数',
  `fine_per_day` DECIMAL(10,2) NOT NULL COMMENT '每日罚金(元)',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='借阅政策表';

-- ----------------------------
-- Records of policy (初始默认政策)
-- ----------------------------
INSERT INTO `policy` (`name`, `borrow_days`, `renew_days`, `max_renew_times`, `fine_per_day`) VALUES 
('标准政策', 30, 15, 1, 0.50),
('学生政策', 60, 30, 2, 0.20),
('教师政策', 90, 30, 3, 0.10);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话号码',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `role` int(0) NOT NULL COMMENT '角色、1：管理员 2：普通用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;



