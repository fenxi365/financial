/*
 Navicat MySQL Data Transfer


 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 02/02/2023 10:28:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fxy_financial_account_sets
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_account_sets`;
CREATE TABLE `fxy_financial_account_sets`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '单位名称',
  `enable_date` date NOT NULL COMMENT '账套启用年月',
  `credit_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '统一社会信用代码',
  `accounting_standards` smallint NOT NULL COMMENT '0.企业会计准则、1.企业会计准则、2.民间非营利组织会计制度',
  `address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '单位所在地',
  `cashier_module` tinyint NOT NULL DEFAULT 0 COMMENT '是否启用出纳模块',
  `industry` smallint NULL DEFAULT NULL COMMENT '行业',
  `fixed_asset_module` tinyint NOT NULL DEFAULT 0 COMMENT '是否启用固定资产模块',
  `vat_type` smallint NOT NULL DEFAULT 0 COMMENT '增值税种类\n0.小规模纳税人、1.一般纳税人',
  `voucher_reviewed` tinyint NOT NULL DEFAULT 0 COMMENT '凭证是否需要审核',
  `create_date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `creator_id` int NOT NULL COMMENT '创建人',
  `current_account_date` date NULL DEFAULT NULL COMMENT '当前记账年月',
  `encoding` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '4-2-2-2',
  `parent_id` int NULL DEFAULT NULL COMMENT '父账套',
  `assets` bit(1) NOT NULL DEFAULT b'1',
  `journal` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `fxy_financial_account_sets_creator_id_company_name_uindex`(`creator_id`, `company_name`) USING BTREE,
  INDEX `fxy_financial_account_sets_fxy_financial_account_sets_id_fk`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '账套' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_account_sets
-- ----------------------------
INSERT INTO `fxy_financial_account_sets` VALUES (1, '杭州常会', '2022-11-01', '', 0, NULL, 0, NULL, 0, 0, 0, '2022-12-23 00:00:00', 1, '2023-02-28', '4-2-2-2', NULL, b'1', b'1');
INSERT INTO `fxy_financial_account_sets` VALUES (2, '测试', '2022-12-01', '', 0, NULL, 0, NULL, 0, 0, 1, '2022-12-23 04:25:24', 1, '2023-02-01', '4-3-2-2', NULL, b'1', b'1');
INSERT INTO `fxy_financial_account_sets` VALUES (3, '美的美集团测试', '2022-12-01', '', 0, '442000', 0, 3, 0, 0, 0, '2022-12-23 07:46:04', 2, '2022-12-01', '4-2-2-2', NULL, b'1', b'1');
INSERT INTO `fxy_financial_account_sets` VALUES (4, 'KY', '2022-12-01', '', 0, NULL, 0, NULL, 0, 0, 0, '2022-12-24 05:38:35', 3, '2022-12-01', '4-2-2-2', NULL, b'1', b'1');
INSERT INTO `fxy_financial_account_sets` VALUES (5, '研发团队测试', '2022-12-01', '123456789', 0, '371722', 0, 0, 0, 0, 1, '2022-12-26 00:00:00', 1, '2023-01-31', '4-2-2-2', NULL, b'1', b'1');
INSERT INTO `fxy_financial_account_sets` VALUES (6, '研发团队测试1', '2022-12-01', '1234567', 0, '371722', 0, 0, 0, 0, 0, '2022-12-26 02:13:20', 4, '2022-12-01', '4-2-2-2', NULL, b'1', b'1');

-- ----------------------------
-- Table structure for fxy_financial_account_sets_classified
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_account_sets_classified`;
CREATE TABLE `fxy_financial_account_sets_classified`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NULL DEFAULT NULL,
  `business_id` int NULL DEFAULT NULL,
  `brand_id` int NULL DEFAULT NULL,
  `area_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fxy_financial_account]_sets_id_fk`(`account_sets_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '账套属性' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_account_sets_classified
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_accounting_category
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_accounting_category`;
CREATE TABLE `fxy_financial_accounting_category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '辅助核算类别名称',
  `custom_columns` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `system_default` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否为系统默认',
  `account_sets_id` int NULL DEFAULT NULL,
  `can_edit` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `fxy_financial_accounting category_account_sets_id_name_uindex`(`account_sets_id`, `name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '核算类别' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_accounting_category
-- ----------------------------
INSERT INTO `fxy_financial_accounting_category` VALUES (1, '客户', '助记码,客户类别,经营地址,联系人,手机,税号', b'1', NULL, b'1');
INSERT INTO `fxy_financial_accounting_category` VALUES (2, '供应商', '助记码,供应商类别,经营地址,联系人,手机,税号', b'1', NULL, b'1');
INSERT INTO `fxy_financial_accounting_category` VALUES (3, '职员', '助记码,性别,部门编码,部门名称,职务,岗位,手机,出生日期,入职日期,离职日期', b'1', NULL, b'1');
INSERT INTO `fxy_financial_accounting_category` VALUES (4, '部门', '助记码,负责人,手机,成立日期,撤销日期', b'1', NULL, b'1');
INSERT INTO `fxy_financial_accounting_category` VALUES (5, '项目', '助记码,负责部门,负责人,手机,开始日期,验收日期', b'1', NULL, b'1');
INSERT INTO `fxy_financial_accounting_category` VALUES (6, '存货', '助记码,规格型号,存货类别,计量单位,启用日期,停用日期', b'1', NULL, b'1');
INSERT INTO `fxy_financial_accounting_category` VALUES (7, '现金流', '现金流类别,助记码', b'1', NULL, b'1');
INSERT INTO `fxy_financial_accounting_category` VALUES (8, '客户', '助记码,客户类别,经营地址,联系人,手机,税号', b'1', 1, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (9, '供应商', '助记码,供应商类别,经营地址,联系人,手机,税号', b'1', 1, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (10, '职员', '助记码,性别,部门编码,部门名称,职务,岗位,手机,出生日期,入职日期,离职日期', b'1', 1, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (11, '部门', '助记码,负责人,手机,成立日期,撤销日期', b'1', 1, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (12, '项目', '助记码,负责部门,负责人,手机,开始日期,验收日期', b'1', 1, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (13, '存货', '助记码,规格型号,存货类别,计量单位,启用日期,停用日期', b'1', 1, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (14, '现金流', '现金流类别,助记码', b'1', 1, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (15, '客户', '助记码,客户类别,经营地址,联系人,手机,税号', b'1', 2, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (16, '供应商', '助记码,供应商类别,经营地址,联系人,手机,税号', b'1', 2, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (17, '职员', '助记码,性别,部门编码,部门名称,职务,岗位,手机,出生日期,入职日期,离职日期', b'1', 2, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (18, '部门', '助记码,负责人,手机,成立日期,撤销日期', b'1', 2, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (19, '项目', '助记码,负责部门,负责人,手机,开始日期,验收日期', b'1', 2, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (20, '存货', '助记码,规格型号,存货类别,计量单位,启用日期,停用日期', b'1', 2, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (21, '现金流', '现金流类别,助记码', b'1', 2, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (22, '客户', '助记码,客户类别,经营地址,联系人,手机,税号', b'1', 3, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (23, '供应商', '助记码,供应商类别,经营地址,联系人,手机,税号', b'1', 3, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (24, '职员', '助记码,性别,部门编码,部门名称,职务,岗位,手机,出生日期,入职日期,离职日期', b'1', 3, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (25, '部门', '助记码,负责人,手机,成立日期,撤销日期', b'1', 3, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (26, '项目', '助记码,负责部门,负责人,手机,开始日期,验收日期', b'1', 3, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (27, '存货', '助记码,规格型号,存货类别,计量单位,启用日期,停用日期', b'1', 3, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (28, '现金流', '现金流类别,助记码', b'1', 3, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (29, '客户', '助记码,客户类别,经营地址,联系人,手机,税号', b'1', 4, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (30, '供应商', '助记码,供应商类别,经营地址,联系人,手机,税号', b'1', 4, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (31, '职员', '助记码,性别,部门编码,部门名称,职务,岗位,手机,出生日期,入职日期,离职日期', b'1', 4, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (32, '部门', '助记码,负责人,手机,成立日期,撤销日期', b'1', 4, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (33, '项目', '助记码,负责部门,负责人,手机,开始日期,验收日期', b'1', 4, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (34, '存货', '助记码,规格型号,存货类别,计量单位,启用日期,停用日期', b'1', 4, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (35, '现金流', '现金流类别,助记码', b'1', 4, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (36, '客户', '助记码,客户类别,经营地址,联系人,手机,税号', b'1', 5, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (37, '供应商', '助记码,供应商类别,经营地址,联系人,手机,税号', b'1', 5, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (38, '职员', '助记码,性别,部门编码,部门名称,职务,岗位,手机,出生日期,入职日期,离职日期', b'1', 5, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (39, '部门', '助记码,负责人,手机,成立日期,撤销日期', b'1', 5, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (40, '项目', '助记码,负责部门,负责人,手机,开始日期,验收日期', b'1', 5, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (41, '存货', '助记码,规格型号,存货类别,计量单位,启用日期,停用日期', b'1', 5, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (42, '现金流', '现金流类别,助记码', b'1', 5, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (44, '客户', '助记码,客户类别,经营地址,联系人,手机,税号', b'1', 6, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (45, '供应商', '助记码,供应商类别,经营地址,联系人,手机,税号', b'1', 6, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (46, '职员', '助记码,性别,部门编码,部门名称,职务,岗位,手机,出生日期,入职日期,离职日期', b'1', 6, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (47, '部门', '助记码,负责人,手机,成立日期,撤销日期', b'1', 6, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (48, '项目', '助记码,负责部门,负责人,手机,开始日期,验收日期', b'1', 6, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (49, '存货', '助记码,规格型号,存货类别,计量单位,启用日期,停用日期', b'1', 6, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (50, '现金流', '现金流类别,助记码', b'1', 6, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (53, '生产部门', '工序', b'0', 1, b'1');
INSERT INTO `fxy_financial_accounting_category` VALUES (54, 'A部门', '手机号', b'0', 1, b'1');
INSERT INTO `fxy_financial_accounting_category` VALUES (55, '工艺', '工艺码', b'0', 5, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (56, '哈哈', '聚焦,还好', b'0', 5, b'1');
INSERT INTO `fxy_financial_accounting_category` VALUES (57, '测试', '123', b'0', 1, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (58, '5464', '', b'0', 5, b'1');

-- ----------------------------
-- Table structure for fxy_financial_accounting_category_details
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_accounting_category_details`;
CREATE TABLE `fxy_financial_accounting_category_details`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '编码',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `remark` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  `enable` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否启用',
  `accounting_category_id` int NULL DEFAULT NULL,
  `cus_column_0` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_1` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_2` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_3` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_4` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_5` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_6` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_7` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_8` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_9` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_10` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_11` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_12` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_13` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_14` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `cus_column_15` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `fxy_financial_category_details_category_id_code_uindex`(`accounting_category_id`, `code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '辅助核算类别明细列表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_accounting_category_details
-- ----------------------------
INSERT INTO `fxy_financial_accounting_category_details` VALUES (1, 'pgd', '苹果', NULL, b'1', 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (2, 'GYS', '瓦克对对都', NULL, b'1', 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (3, '321', '测试客户', NULL, b'1', 8, '123', 'A级客户', '单县', '13581832297', '13581832297', '123445', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (4, '011', '供应商1', NULL, b'1', 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (5, '001', '职员', NULL, b'1', 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (6, '001', '部门', NULL, b'1', 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (7, '123', '呜呜呜呜吧', NULL, b'1', 55, '5656', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (8, '11', '11', NULL, b'1', 57, '11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (9, '1', '11111', NULL, b'1', 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for fxy_financial_admin
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_admin`;
CREATE TABLE `fxy_financial_admin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `enabled` bit(1) NOT NULL DEFAULT b'1',
  `last_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `last_login_time` datetime(0) NULL DEFAULT NULL,
  `master` bit(1) NOT NULL DEFAULT b'0',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `telephone` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_lsseybko2svlk1tos914yrjuv`(`telephone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_admin
-- ----------------------------
INSERT INTO `fxy_financial_admin` VALUES (1, '2022-12-30 09:57:14', b'1', NULL, NULL, b'1', '夏悸', '$2a$10$H1/f9RR7GX9cSMSCtzUl7Osh.CRnFP3i0TYCqC.jDqPa6KHIcf6UK', '18692626866');

-- ----------------------------
-- Table structure for fxy_financial_admin_report_template
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_admin_report_template`;
CREATE TABLE `fxy_financial_admin_report_template`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `template_key` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int NOT NULL DEFAULT 0 COMMENT '报表类型：0普通报表，1资产报表',
  `classified_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `account_sets_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `fxy_financial_admin_report_template_user_id_template_key_uindex`(`user_id`, `template_key`) USING BTREE,
  INDEX `fxy_financial_admin_report_template_account_sets__fk`(`account_sets_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_admin_report_template
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_admin_report_template_items
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_admin_report_template_items`;
CREATE TABLE `fxy_financial_admin_report_template_items`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `template_id` int NOT NULL,
  `title` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `parent_id` int NULL DEFAULT NULL,
  `line_num` int NOT NULL DEFAULT -1 COMMENT '行次',
  `type` int NULL DEFAULT NULL COMMENT '资产负载类型时需要设置\n0,资产 1,负债 2，所有者权益',
  `sources` int NOT NULL DEFAULT 0 COMMENT '取数来原:0,表外公式,1,表内公式',
  `level` int NOT NULL DEFAULT 1 COMMENT '层级',
  `is_bolder` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否加粗标题',
  `is_folding` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否可以折叠',
  `is_classified` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否是归类项，归类项没有行号',
  `pos` int NOT NULL DEFAULT 1 COMMENT '显示位置',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fxy_template_id_fk`(`template_id`) USING BTREE,
  INDEX `fxy_admin_relate_items_id_fk`(`parent_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_admin_report_template_items
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_admin_report_template_items_formula
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_admin_report_template_items_formula`;
CREATE TABLE `fxy_financial_admin_report_template_items_formula`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `template_id` int NOT NULL COMMENT '模板 id',
  `template_items_id` int NOT NULL,
  `account_sets_id` int NOT NULL,
  `calculation` enum('+','-','*','/') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '+' COMMENT '计算方式',
  `access_rules` int NOT NULL COMMENT '取数规则：0,净发生额度 1,借方发生额 2,贷方发生额',
  `from_tag` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据来源标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fxy_ataa_fk`(`account_sets_id`) USING BTREE,
  INDEX `fxy_iftss_fk`(`template_id`) USING BTREE,
  INDEX `fxy_tifaas_fk`(`template_items_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模板项公式表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_admin_report_template_items_formula
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_assets
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_assets`;
CREATE TABLE `fxy_financial_assets`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `add_type` int NULL DEFAULT NULL,
  `assets_clean_subject_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `assets_subject_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `assets_type_id` int NULL DEFAULT NULL,
  `before_year_total_depreciation` double NULL DEFAULT NULL,
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `create_date_time` datetime(0) NULL DEFAULT NULL,
  `current_month_depreciation` double NULL DEFAULT NULL,
  `depreciation_expense_subject_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `depreciation_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `dept_id` int NULL DEFAULT NULL,
  `dispose_check_date` date NULL DEFAULT NULL,
  `dispose_type` int NULL DEFAULT NULL,
  `entry_date` date NULL DEFAULT NULL,
  `expect_residual_rate` double NULL DEFAULT NULL,
  `expect_use_month` int NULL DEFAULT NULL,
  `is_period` bit(1) NOT NULL DEFAULT b'0',
  `is_voucher` bit(1) NOT NULL DEFAULT b'0',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `original_value` double NULL DEFAULT NULL,
  `reduce_date` date NULL DEFAULT NULL,
  `reduce_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `remaining_use_month` int NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `residual_rate` double NULL DEFAULT NULL,
  `specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `start_date` date NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  `supplier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `total_depreciation` double NULL DEFAULT NULL,
  `total_depreciation_subject_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `use_month` int NULL DEFAULT NULL,
  `year_total_depreciation` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UKbt7vi6yg017jgv55n8bcu33n6`(`account_sets_id`, `code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_assets
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_assets_change
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_assets_change`;
CREATE TABLE `fxy_financial_assets_change`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `after_change` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `assets_id` int NULL DEFAULT NULL,
  `before_change` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `change_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `check_date` date NULL DEFAULT NULL,
  `check_month` int NULL DEFAULT NULL,
  `check_year` int NULL DEFAULT NULL,
  `create_date` date NULL DEFAULT NULL,
  `voucher_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_assets_change
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_assets_depreciation
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_assets_depreciation`;
CREATE TABLE `fxy_financial_assets_depreciation`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `cancel` bit(1) NOT NULL DEFAULT b'1',
  `check_date` date NULL DEFAULT NULL,
  `check_month` int NULL DEFAULT NULL,
  `check_year` int NULL DEFAULT NULL,
  `status` int NOT NULL DEFAULT 1,
  `voucher_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK45dq89nhgva0aou6apiqcao1m`(`account_sets_id`, `check_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_assets_depreciation
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_assets_detail
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_assets_detail`;
CREATE TABLE `fxy_financial_assets_detail`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `assert_id` int NULL DEFAULT NULL,
  `change_id` int NULL DEFAULT NULL,
  `check_date` date NULL DEFAULT NULL,
  `depreciation_balance` double NULL DEFAULT NULL,
  `depreciation_credit` double NULL DEFAULT NULL,
  `depreciation_debit` double NULL DEFAULT NULL,
  `depreciation_id` int NULL DEFAULT NULL,
  `dept_id` int NULL DEFAULT NULL,
  `dept_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `digest` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `impairment_balance` double NULL DEFAULT NULL,
  `impairment_credit` double NULL DEFAULT NULL,
  `impairment_debit` double NULL DEFAULT NULL,
  `net_value` double NULL DEFAULT NULL,
  `original_balance` double NULL DEFAULT NULL,
  `original_credit` double NULL DEFAULT NULL,
  `original_debit` double NULL DEFAULT NULL,
  `use_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `voucher_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_assets_detail
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_assets_type
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_assets_type`;
CREATE TABLE `fxy_financial_assets_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cost_account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `depreciation_account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `depreciation_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `residual_rate` double NULL DEFAULT NULL,
  `use_month` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_assets_type
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_backup
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_backup`;
CREATE TABLE `fxy_financial_backup`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `bak_time` datetime(0) NULL DEFAULT NULL,
  `bak_type` int NULL DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `size` bigint NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_backup
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_cashier_account
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_cashier_account`;
CREATE TABLE `fxy_financial_cashier_account`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `balance` double NOT NULL DEFAULT 0,
  `card_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `currency_id` int NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `subject_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uc_cashieraccount_type_name`(`type`, `name`, `account_sets_id`) USING BTREE,
  UNIQUE INDEX `uc_cashieraccount_type_code`(`type`, `code`, `account_sets_id`) USING BTREE,
  UNIQUE INDEX `uc_cashieraccount_type`(`type`, `card_number`, `account_sets_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_cashier_account
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_cashier_io_type
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_cashier_io_type`;
CREATE TABLE `fxy_financial_cashier_io_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uc_cashieraccount_type_name`(`type`, `name`, `account_sets_id`) USING BTREE,
  UNIQUE INDEX `uc_cashieraccount_type_code`(`type`, `code`, `account_sets_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_cashier_io_type
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_cashier_io_type_voucher_template
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_cashier_io_type_voucher_template`;
CREATE TABLE `fxy_financial_cashier_io_type_voucher_template`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `direction` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `io_type_id` int NULL DEFAULT NULL,
  `journal_type` int NULL DEFAULT NULL,
  `subject_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type` int NULL DEFAULT NULL,
  `word_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UKjgxn69oe3802lvcysok3yv2cc`(`journal_type`, `io_type_id`, `direction`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_cashier_io_type_voucher_template
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_cashier_journal
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_cashier_journal`;
CREATE TABLE `fxy_financial_cashier_journal`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NULL DEFAULT NULL,
  `account_sets_id` int NULL DEFAULT NULL,
  `accounting_category_details_id` int NULL DEFAULT NULL,
  `accounting_category_id` int NULL DEFAULT NULL,
  `balance` double NULL DEFAULT NULL,
  `bill_date` date NULL DEFAULT NULL,
  `bill_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `cashier_transfer_id` int NULL DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `credit` double NULL DEFAULT NULL,
  `debit` double NULL DEFAULT NULL,
  `dept_category_details_id` int NULL DEFAULT NULL,
  `dept_category_id` int NULL DEFAULT NULL,
  `digest` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `init` bit(1) NOT NULL DEFAULT b'0',
  `io_type_id` int NULL DEFAULT NULL,
  `project_category_details_id` int NULL DEFAULT NULL,
  `project_category_id` int NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `serial` int NULL DEFAULT NULL,
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `settlement_type_id` int NULL DEFAULT NULL,
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `voucher_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_cashier_journal
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_cashier_transfer
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_cashier_transfer`;
CREATE TABLE `fxy_financial_cashier_transfer`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `amount` double NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `digest` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `in_account_id` int NULL DEFAULT NULL,
  `out_account_id` int NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `transfer_date` date NULL DEFAULT NULL,
  `voucher_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_cashier_transfer
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_checkout
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_checkout`;
CREATE TABLE `fxy_financial_checkout`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `check_year` int NULL DEFAULT NULL,
  `check_month` int NULL DEFAULT NULL,
  `status` int NOT NULL DEFAULT 0 COMMENT '0,未结转损益、未结账,1,已结转损益、未结账,2,已结转损益、已结账',
  `check_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fxy_financial_checkout_account_sets_id_fk`(`account_sets_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '期末结转' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_checkout
-- ----------------------------
INSERT INTO `fxy_financial_checkout` VALUES (1, 1, 2022, 11, 2, '2022-11-01');
INSERT INTO `fxy_financial_checkout` VALUES (2, 2, 2022, 12, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (3, 2, 2023, 1, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (4, 3, 2022, 12, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (5, 4, 2022, 12, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (6, 5, 2022, 12, 2, '2022-12-01');
INSERT INTO `fxy_financial_checkout` VALUES (7, 6, 2022, 12, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (8, 2, 2023, 2, 0, '2023-02-01');
INSERT INTO `fxy_financial_checkout` VALUES (9, 5, 2023, 1, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (10, 1, 2022, 12, 2, '2022-12-01');
INSERT INTO `fxy_financial_checkout` VALUES (11, 1, 2023, 1, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (12, 1, 2023, 2, 0, NULL);

-- ----------------------------
-- Table structure for fxy_financial_classified
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_classified`;
CREATE TABLE `fxy_financial_classified`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `type` enum('分组','品牌','区域','商圈') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '分组',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '标题',
  `level` tinyint NOT NULL DEFAULT 1 COMMENT '层级',
  `pos` smallint NOT NULL DEFAULT 0 COMMENT '排序标识',
  `xpath` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '树形路径',
  `parent_id` int NULL DEFAULT NULL COMMENT '上级ID',
  `account_sets_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fxy_financial_classified_account_sets_id_fk`(`account_sets_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '账套归类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_classified
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_currency
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_currency`;
CREATE TABLE `fxy_financial_currency`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '编码 ',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '名称 ',
  `exchange_rate` double NOT NULL COMMENT '汇率 ',
  `local_currency` bit(1) NULL DEFAULT b'0' COMMENT '是否本位币',
  `account_sets_id` int NOT NULL COMMENT '所属账套',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `fxy_financial_currency_account_sets_id_code_uindex`(`account_sets_id`, `code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '币别' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_currency
-- ----------------------------
INSERT INTO `fxy_financial_currency` VALUES (1, 'RMB', '人民币', 1, b'1', 1);
INSERT INTO `fxy_financial_currency` VALUES (2, 'RMB', '人民币', 1, b'1', 2);
INSERT INTO `fxy_financial_currency` VALUES (3, 'RMB', '人民币', 1, b'1', 3);
INSERT INTO `fxy_financial_currency` VALUES (4, 'RMB', '人民币', 1, b'1', 4);
INSERT INTO `fxy_financial_currency` VALUES (5, 'RMB', '人民币', 1, b'1', 5);
INSERT INTO `fxy_financial_currency` VALUES (6, 'RMB', '人民币', 1, b'1', 6);
INSERT INTO `fxy_financial_currency` VALUES (7, 'MGY', '美元', 6, b'0', 5);

-- ----------------------------
-- Table structure for fxy_financial_employee
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_employee`;
CREATE TABLE `fxy_financial_employee`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_bank` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `account_sets_id` int NULL DEFAULT NULL,
  `bank_account_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `begin_date` datetime(0) NULL DEFAULT NULL,
  `cert_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `employee_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `enabled` bit(1) NOT NULL DEFAULT b'1',
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `resignation_date` date NULL DEFAULT NULL,
  `social_security_id` int NULL DEFAULT NULL,
  `work_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_employee
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_invoice
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_invoice`;
CREATE TABLE `fxy_financial_invoice`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `account_sets_id` int NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `amount` double NOT NULL DEFAULT 0,
  `category` int NULL DEFAULT NULL,
  `check_date` date NULL DEFAULT NULL,
  `credit_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `have_detail` bit(1) NOT NULL DEFAULT b'1',
  `invoice_business_type_id` int NULL DEFAULT NULL,
  `invoice_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `invoice_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `state` int NULL DEFAULT NULL,
  `tax_amount` double NOT NULL DEFAULT 0,
  `tax_amount_excluded` double NOT NULL DEFAULT 0,
  `trade_date` date NULL DEFAULT NULL,
  `type` int NULL DEFAULT NULL,
  `voucher_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_invoice
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_invoice_business_type
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_invoice_business_type`;
CREATE TABLE `fxy_financial_invoice_business_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `invoice_type` int NULL DEFAULT NULL,
  `items` json NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `voucher_word` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_invoice_business_type
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_invoice_items
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_invoice_items`;
CREATE TABLE `fxy_financial_invoice_items`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `invoice_id` int NULL DEFAULT NULL,
  `quantity` double NULL DEFAULT NULL,
  `specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tax` double NULL DEFAULT NULL,
  `tax_calculation_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tax_rate` int NULL DEFAULT NULL,
  `taxed_items` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_invoice_items
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_renewal_code
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_renewal_code`;
CREATE TABLE `fxy_financial_renewal_code`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `month` int NULL DEFAULT NULL,
  `use_time` datetime(0) NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_oia8gleq5wjlxk67hafl2ivht`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_renewal_code
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_report
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_report`;
CREATE TABLE `fxy_financial_report`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `dimensions` json NULL,
  `is_default` bit(1) NOT NULL DEFAULT b'1',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `pos` int NOT NULL DEFAULT 0,
  `template_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uc_report`(`account_sets_id`, `template_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_report
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_report_items
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_report_items`;
CREATE TABLE `fxy_financial_report_items`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `is_bolder` bit(1) NULL DEFAULT NULL,
  `is_classified` bit(1) NULL DEFAULT NULL,
  `is_folding` bit(1) NULL DEFAULT NULL,
  `parent_id` int NULL DEFAULT NULL,
  `pos` int NULL DEFAULT NULL,
  `template_id` int NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_report_items
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_report_items_formula
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_report_items_formula`;
CREATE TABLE `fxy_financial_report_items_formula`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `access_rules` int NULL DEFAULT NULL,
  `account_sets_id` int NULL DEFAULT NULL,
  `calculation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `from_tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `source` int NULL DEFAULT NULL,
  `template_items_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_report_items_formula
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_report_template
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_report_template`;
CREATE TABLE `fxy_financial_report_template`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `account_sets_id` int NULL DEFAULT NULL,
  `template_key` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` int NOT NULL DEFAULT 0 COMMENT '报表类型：0普通报表，1资产报表',
  `accounting_standards` smallint NULL DEFAULT NULL,
  `dimensions` json NULL,
  `is_default` bit(1) NOT NULL DEFAULT b'1',
  `pos` int NOT NULL DEFAULT 0,
  `vat_type` smallint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `fxy_report_template_account_sets_id_template_key_uindex`(`account_sets_id`, `template_key`) USING BTREE,
  UNIQUE INDEX `uc_reporttemplate`(`accounting_standards`, `vat_type`, `template_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_report_template
-- ----------------------------
INSERT INTO `fxy_financial_report_template` VALUES (1, '利润表', 1, 'lrb', 0, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (2, '现金流量表', 1, 'xjllb', 2, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (3, '资产负债表', 1, 'zcfzb', 1, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (4, '利润表', 2, 'lrb', 0, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (5, '现金流量表', 2, 'xjllb', 2, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (6, '资产负债表', 2, 'zcfzb', 1, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (7, '利润表', 3, 'lrb', 0, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (8, '现金流量表', 3, 'xjllb', 2, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (9, '资产负债表', 3, 'zcfzb', 1, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (10, '利润表', 4, 'lrb', 0, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (11, '现金流量表', 4, 'xjllb', 2, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (12, '资产负债表', 4, 'zcfzb', 1, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (13, '利润表', 5, 'lrb', 0, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (14, '现金流量表', 5, 'xjllb', 2, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (15, '资产负债表', 5, 'zcfzb', 1, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (16, '利润表', 6, 'lrb', 0, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (17, '现金流量表', 6, 'xjllb', 2, NULL, NULL, b'1', 0, NULL);
INSERT INTO `fxy_financial_report_template` VALUES (18, '资产负债表', 6, 'zcfzb', 1, NULL, NULL, b'1', 0, NULL);

-- ----------------------------
-- Table structure for fxy_financial_report_template_items
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_report_template_items`;
CREATE TABLE `fxy_financial_report_template_items`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `template_id` int NOT NULL,
  `title` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `parent_id` int NULL DEFAULT NULL,
  `line_num` int NOT NULL DEFAULT -1 COMMENT '行次',
  `type` int NULL DEFAULT NULL COMMENT '资产负载类型时需要设置\n0,资产 1,负债 2，所有者权益',
  `sources` int NOT NULL DEFAULT 0 COMMENT '取数来原:0,表外公式,1,表内公式',
  `level` int NOT NULL DEFAULT 1 COMMENT '层级',
  `is_bolder` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否加粗标题',
  `is_folding` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否可以折叠',
  `is_classified` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否是归类项，归类项没有行号',
  `pos` int NOT NULL DEFAULT 1 COMMENT '显示位置',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fxy_report_template_items_fxy_report_template_id_fk`(`template_id`) USING BTREE,
  INDEX `fxy_report_template_items_fxy_report_template_items_id_fk`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 695 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_report_template_items
-- ----------------------------
INSERT INTO `fxy_financial_report_template_items` VALUES (1, 1, '一、营业外收入', NULL, 1, NULL, 0, 1, b'1', b'1', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (2, 1, '减：营业成本', 1, 2, NULL, 0, 2, b'0', b'1', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (3, 1, '税金及附加', 2, 3, 0, 0, 3, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (4, 1, '其中:消费税', 3, 4, 0, 0, 4, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (5, 1, '营业税', 3, 5, 0, 0, 4, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (6, 1, '城市维护建设税', 3, 6, 0, 0, 4, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (7, 1, '资源税', 3, 7, 0, 0, 4, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (8, 1, '土地增值税', 3, 8, 0, 0, 4, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (9, 1, '城镇土地使用税、房产税、车船税、印花税', 3, 9, 0, 0, 4, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (10, 1, '教育费附加、矿产资源补偿费、排污费', 3, 10, 0, 0, 4, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (11, 1, '销售费用', 2, 11, 0, 0, 3, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (12, 1, '其中：商品维修费', 11, 12, 0, 0, 4, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (13, 1, '广告费和业务宣传费', 11, 13, 0, 0, 4, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (14, 1, '管理费用', 2, 14, 0, 0, 3, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (15, 1, '其中：开办费', 14, 15, 0, 0, 4, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (16, 1, '业务招待费', 14, 16, 0, 0, 4, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (17, 1, '研究费用', 14, 17, 0, 0, 4, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (18, 1, '财务费用', 2, 18, 0, 0, 3, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (19, 1, '其中：利息费用（收入以\'-\'号填列）', 18, 19, 0, 0, 4, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (20, 1, '投资收益（损失以“-”号填列）', 2, 20, 0, 0, 3, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (21, 1, '二、营业利润（亏损失以\'-\'填列）', NULL, 21, NULL, 1, 1, b'1', b'1', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (22, 1, '加：营业外收入', 21, 22, 0, 0, 2, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (23, 1, '其中：政府补助', 22, 23, 0, 0, 3, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (24, 1, '减：营业外支出', 21, 24, 0, 0, 2, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (25, 1, '其中：坏账损失', 24, 25, 0, 0, 3, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (26, 1, '无法收回的长期债券投资损失', 24, 26, 0, 0, 3, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (27, 1, '无法收回的长期股权投资损失', 24, 27, 0, 0, 3, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (28, 1, '自然灾害等不可抗力因素造成的损失', 24, 28, 0, 0, 3, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (29, 1, '税收滞纳金', 24, 29, 0, 0, 3, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (30, 1, '三、利润总额（亏损失以“-”号填列）', NULL, 30, NULL, 1, 1, b'1', b'1', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (31, 1, ' 减：所得税费用', 30, 31, 0, 0, 2, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (32, 1, '四、净利润（亏损失以“-”号填列）', NULL, 32, NULL, 1, 1, b'1', b'1', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (33, 2, '一、经营活动产生的现金流量：', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (34, 2, '销售产成品、商品、提供劳务收到的现金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (35, 2, '收到其他与经营活动有关的现金', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (36, 2, '购买原材料、商品、接受劳务支付的现金', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (37, 2, '支付的职工薪酬', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (38, 2, '支付的税费', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (39, 2, '支付其他与经营活动有关的现金', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (40, 2, '经营活动产生的现金流量净额', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (41, 2, '二、投资活动产生的现金流量：', NULL, 9, 0, 0, 1, b'1', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (42, 2, '收回短期投资、长期债券投资和长期股权投资收到的现金', NULL, 10, 0, 0, 1, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (43, 2, '取得投资收益收到的现金', NULL, 11, 0, 0, 1, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (44, 2, '处置固定资产、无形资产和其他非流动资产收回的现金净额', NULL, 12, 0, 0, 1, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (45, 2, '短期投资、长期债券投资和长期股权投资支付的现金', NULL, 13, 0, 0, 1, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (46, 2, '购建固定资产、无形资产和其他非流动资产支付的现金', NULL, 14, 0, 0, 1, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (47, 2, '投资活动产生的现金流量净额', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (48, 2, '三、筹资活动产生的现金流量：', NULL, 16, 0, 0, 1, b'1', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (49, 2, '取得借款收到的现金', NULL, 17, 0, 0, 1, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (50, 2, '吸收投资者投资收到的现金', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (51, 2, '偿还借款本金支付的现金', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (52, 2, '偿还借款利息支付的现金', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (53, 2, '分配利润支付的现金', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (54, 2, '筹资活动产生的现金流量净额', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (55, 2, '四、现金净增加额', NULL, 23, 0, 0, 1, b'1', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (56, 2, '加：期初现金余额', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (57, 2, '五、期末现金余额', NULL, 25, 0, 0, 1, b'1', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (58, 3, '流动资产', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (59, 3, '货币资金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (60, 3, '短期投资', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (61, 3, '应收票据', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (62, 3, '应收账款', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (63, 3, '预付账款', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (64, 3, '应收股利', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (65, 3, '应收利息', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (66, 3, '其他应收款', NULL, 9, 0, 0, 1, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (67, 3, '存货', NULL, 10, 0, 0, 1, b'0', b'1', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (68, 3, '其中：原材料', 67, 11, 0, 0, 2, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (69, 3, '在产品', 67, 12, 0, 0, 2, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (70, 3, '库存商品', 67, 13, 0, 0, 2, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (71, 3, '周转材料', 67, 14, 0, 0, 2, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (72, 3, '其他流动资产', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (73, 3, '流动资产合计', NULL, 16, 0, 0, 1, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (74, 3, '非流动资产', NULL, 17, 0, 0, 1, b'1', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (75, 3, '长期债券投资', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (76, 3, '长期股权投资', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (77, 3, '固定资产原价编辑', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (78, 3, '减：累计折旧', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (79, 3, '固定资产账面价值', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (80, 3, '在建工程', NULL, 23, 0, 0, 1, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (81, 3, '工程物资', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (82, 3, '固定资产清理', NULL, 25, 0, 0, 1, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (83, 3, '生产性生物资产', NULL, 26, 0, 0, 1, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (84, 3, '无形资产', NULL, 27, 0, 0, 1, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (85, 3, '开发支出', NULL, 28, 0, 0, 1, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (86, 3, '长期待摊费用', NULL, 29, 0, 0, 1, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (87, 3, '其他非流动资产', NULL, 30, 0, 0, 1, b'0', b'0', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (88, 3, '非流动资产合计', NULL, 31, 0, 0, 1, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (89, 3, '资产合计', NULL, 32, 0, 0, 1, b'1', b'0', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (90, 3, '流动负债', NULL, 33, 1, 0, 1, b'1', b'0', b'0', 33);
INSERT INTO `fxy_financial_report_template_items` VALUES (91, 3, '短期借款', NULL, 34, 1, 0, 1, b'0', b'0', b'0', 34);
INSERT INTO `fxy_financial_report_template_items` VALUES (92, 3, '应付票据', NULL, 35, 1, 0, 1, b'0', b'0', b'0', 35);
INSERT INTO `fxy_financial_report_template_items` VALUES (93, 3, '应付账款', NULL, 36, 1, 0, 1, b'0', b'0', b'0', 36);
INSERT INTO `fxy_financial_report_template_items` VALUES (94, 3, '预收账款', NULL, 37, 1, 0, 1, b'0', b'0', b'0', 37);
INSERT INTO `fxy_financial_report_template_items` VALUES (95, 3, '应付职工薪酬', NULL, 38, 1, 0, 1, b'0', b'0', b'0', 38);
INSERT INTO `fxy_financial_report_template_items` VALUES (96, 3, '应交税费', NULL, 39, 1, 0, 1, b'0', b'0', b'0', 39);
INSERT INTO `fxy_financial_report_template_items` VALUES (97, 3, '应付利息', NULL, 40, 1, 0, 1, b'0', b'0', b'0', 40);
INSERT INTO `fxy_financial_report_template_items` VALUES (98, 3, '应付利润', NULL, 41, 1, 0, 1, b'0', b'0', b'0', 41);
INSERT INTO `fxy_financial_report_template_items` VALUES (99, 3, '其他应付款', NULL, 42, 1, 0, 1, b'0', b'0', b'0', 42);
INSERT INTO `fxy_financial_report_template_items` VALUES (100, 3, '其他流动负债', NULL, 43, 1, 0, 1, b'0', b'0', b'0', 43);
INSERT INTO `fxy_financial_report_template_items` VALUES (101, 3, '流动负债合计', NULL, 44, 1, 0, 1, b'0', b'0', b'0', 44);
INSERT INTO `fxy_financial_report_template_items` VALUES (102, 3, '非流动负债', NULL, 45, 1, 0, 1, b'1', b'0', b'0', 45);
INSERT INTO `fxy_financial_report_template_items` VALUES (103, 3, '长期借款', NULL, 46, 1, 0, 1, b'0', b'0', b'0', 46);
INSERT INTO `fxy_financial_report_template_items` VALUES (104, 3, '长期应付款', NULL, 47, 1, 0, 1, b'0', b'0', b'0', 47);
INSERT INTO `fxy_financial_report_template_items` VALUES (105, 3, '递延收益', NULL, 48, 1, 0, 1, b'0', b'0', b'0', 48);
INSERT INTO `fxy_financial_report_template_items` VALUES (106, 3, '其他非流动负债', NULL, 49, 1, 0, 1, b'0', b'0', b'0', 49);
INSERT INTO `fxy_financial_report_template_items` VALUES (107, 3, '非流动负债合计', NULL, 50, 1, 0, 1, b'0', b'0', b'0', 50);
INSERT INTO `fxy_financial_report_template_items` VALUES (108, 3, '负债合计', NULL, 51, 1, 0, 1, b'1', b'0', b'0', 51);
INSERT INTO `fxy_financial_report_template_items` VALUES (109, 3, '所有者权益（或股东权益）', NULL, 52, 2, 0, 1, b'1', b'0', b'0', 52);
INSERT INTO `fxy_financial_report_template_items` VALUES (110, 3, '实收资本（或股本）', NULL, 53, 2, 0, 1, b'0', b'0', b'0', 53);
INSERT INTO `fxy_financial_report_template_items` VALUES (111, 3, '资本公积', NULL, 54, 2, 0, 1, b'0', b'0', b'0', 54);
INSERT INTO `fxy_financial_report_template_items` VALUES (112, 3, '盈余公积', NULL, 55, 2, 0, 1, b'0', b'0', b'0', 55);
INSERT INTO `fxy_financial_report_template_items` VALUES (113, 3, '未分配利润', NULL, 56, 2, 0, 1, b'0', b'0', b'0', 56);
INSERT INTO `fxy_financial_report_template_items` VALUES (114, 3, '所有者权益（或股东权益）合计', NULL, 57, 2, 0, 1, b'0', b'0', b'0', 57);
INSERT INTO `fxy_financial_report_template_items` VALUES (115, 3, '负债和所有者权益（或股东权益）', NULL, 58, 2, 0, 1, b'1', b'0', b'0', 58);
INSERT INTO `fxy_financial_report_template_items` VALUES (116, 4, '一、营业外收入', NULL, 1, NULL, 0, 1, b'1', b'1', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (117, 4, '减：营业成本', 116, 2, NULL, 0, 2, b'0', b'1', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (118, 4, '税金及附加', 117, 3, 0, 0, 3, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (119, 4, '其中:消费税', 118, 4, 0, 0, 4, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (120, 4, '营业税', 118, 5, 0, 0, 4, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (121, 4, '城市维护建设税', 118, 6, 0, 0, 4, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (122, 4, '资源税', 118, 7, 0, 0, 4, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (123, 4, '土地增值税', 118, 8, 0, 0, 4, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (124, 4, '城镇土地使用税、房产税、车船税、印花税', 118, 9, 0, 0, 4, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (125, 4, '教育费附加、矿产资源补偿费、排污费', 118, 10, 0, 0, 4, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (126, 4, '销售费用', 117, 11, 0, 0, 3, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (127, 4, '其中：商品维修费', 126, 12, 0, 0, 4, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (128, 4, '广告费和业务宣传费', 126, 13, 0, 0, 4, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (129, 4, '管理费用', 117, 14, 0, 0, 3, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (130, 4, '其中：开办费', 129, 15, 0, 0, 4, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (131, 4, '业务招待费', 129, 16, 0, 0, 4, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (132, 4, '研究费用', 129, 17, 0, 0, 4, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (133, 4, '财务费用', 117, 18, 0, 0, 3, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (134, 4, '其中：利息费用（收入以\'-\'号填列）', 133, 19, 0, 0, 4, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (135, 4, '投资收益（损失以“-”号填列）', 117, 20, 0, 0, 3, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (136, 4, '二、营业利润（亏损失以\'-\'填列）', NULL, 21, NULL, 1, 1, b'1', b'1', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (137, 4, '加：营业外收入', 136, 22, 0, 0, 2, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (138, 4, '其中：政府补助', 137, 23, 0, 0, 3, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (139, 4, '减：营业外支出', 136, 24, 0, 0, 2, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (140, 4, '其中：坏账损失', 139, 25, 0, 0, 3, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (141, 4, '无法收回的长期债券投资损失', 139, 26, 0, 0, 3, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (142, 4, '无法收回的长期股权投资损失', 139, 27, 0, 0, 3, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (143, 4, '自然灾害等不可抗力因素造成的损失', 139, 28, 0, 0, 3, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (144, 4, '税收滞纳金', 139, 29, 0, 0, 3, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (145, 4, '三、利润总额（亏损失以“-”号填列）', NULL, 30, NULL, 1, 1, b'1', b'1', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (146, 4, ' 减：所得税费用', 145, 31, 0, 0, 2, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (147, 4, '四、净利润（亏损失以“-”号填列）', NULL, 32, NULL, 1, 1, b'1', b'1', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (148, 5, '一、经营活动产生的现金流量：', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (149, 5, '销售产成品、商品、提供劳务收到的现金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (150, 5, '收到其他与经营活动有关的现金', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (151, 5, '购买原材料、商品、接受劳务支付的现金', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (152, 5, '支付的职工薪酬', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (153, 5, '支付的税费', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (154, 5, '支付其他与经营活动有关的现金', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (155, 5, '经营活动产生的现金流量净额', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (156, 5, '二、投资活动产生的现金流量：', NULL, 9, 0, 0, 1, b'1', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (157, 5, '收回短期投资、长期债券投资和长期股权投资收到的现金', NULL, 10, 0, 0, 1, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (158, 5, '取得投资收益收到的现金', NULL, 11, 0, 0, 1, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (159, 5, '处置固定资产、无形资产和其他非流动资产收回的现金净额', NULL, 12, 0, 0, 1, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (160, 5, '短期投资、长期债券投资和长期股权投资支付的现金', NULL, 13, 0, 0, 1, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (161, 5, '购建固定资产、无形资产和其他非流动资产支付的现金', NULL, 14, 0, 0, 1, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (162, 5, '投资活动产生的现金流量净额', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (163, 5, '三、筹资活动产生的现金流量：', NULL, 16, 0, 0, 1, b'1', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (164, 5, '取得借款收到的现金', NULL, 17, 0, 0, 1, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (165, 5, '吸收投资者投资收到的现金', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (166, 5, '偿还借款本金支付的现金', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (167, 5, '偿还借款利息支付的现金', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (168, 5, '分配利润支付的现金', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (169, 5, '筹资活动产生的现金流量净额', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (170, 5, '四、现金净增加额', NULL, 23, 0, 0, 1, b'1', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (171, 5, '加：期初现金余额', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (172, 5, '五、期末现金余额', NULL, 25, 0, 0, 1, b'1', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (173, 6, '流动资产', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (174, 6, '货币资金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (175, 6, '短期投资', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (176, 6, '应收票据', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (177, 6, '应收账款', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (178, 6, '预付账款', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (179, 6, '应收股利', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (180, 6, '应收利息', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (181, 6, '其他应收款', NULL, 9, 0, 0, 1, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (182, 6, '存货', NULL, 10, 0, 0, 1, b'0', b'1', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (183, 6, '其中：原材料', 182, 11, 0, 0, 2, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (184, 6, '在产品', 182, 12, 0, 0, 2, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (185, 6, '库存商品', 182, 13, 0, 0, 2, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (186, 6, '周转材料', 182, 14, 0, 0, 2, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (187, 6, '其他流动资产', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (188, 6, '流动资产合计', NULL, 16, 0, 0, 1, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (189, 6, '非流动资产', NULL, 17, 0, 0, 1, b'1', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (190, 6, '长期债券投资', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (191, 6, '长期股权投资', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (192, 6, '固定资产原价编辑', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (193, 6, '减：累计折旧', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (194, 6, '固定资产账面价值', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (195, 6, '在建工程', NULL, 23, 0, 0, 1, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (196, 6, '工程物资', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (197, 6, '固定资产清理', NULL, 25, 0, 0, 1, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (198, 6, '生产性生物资产', NULL, 26, 0, 0, 1, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (199, 6, '无形资产', NULL, 27, 0, 0, 1, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (200, 6, '开发支出', NULL, 28, 0, 0, 1, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (201, 6, '长期待摊费用', NULL, 29, 0, 0, 1, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (202, 6, '其他非流动资产', NULL, 30, 0, 0, 1, b'0', b'0', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (203, 6, '非流动资产合计', NULL, 31, 0, 0, 1, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (204, 6, '资产合计', NULL, 32, 0, 0, 1, b'1', b'0', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (205, 6, '流动负债', NULL, 33, 1, 0, 1, b'1', b'0', b'0', 33);
INSERT INTO `fxy_financial_report_template_items` VALUES (206, 6, '短期借款', NULL, 34, 1, 0, 1, b'0', b'0', b'0', 34);
INSERT INTO `fxy_financial_report_template_items` VALUES (207, 6, '应付票据', NULL, 35, 1, 0, 1, b'0', b'0', b'0', 35);
INSERT INTO `fxy_financial_report_template_items` VALUES (208, 6, '应付账款', NULL, 36, 1, 0, 1, b'0', b'0', b'0', 36);
INSERT INTO `fxy_financial_report_template_items` VALUES (209, 6, '预收账款', NULL, 37, 1, 0, 1, b'0', b'0', b'0', 37);
INSERT INTO `fxy_financial_report_template_items` VALUES (210, 6, '应付职工薪酬', NULL, 38, 1, 0, 1, b'0', b'0', b'0', 38);
INSERT INTO `fxy_financial_report_template_items` VALUES (211, 6, '应交税费', NULL, 39, 1, 0, 1, b'0', b'0', b'0', 39);
INSERT INTO `fxy_financial_report_template_items` VALUES (212, 6, '应付利息', NULL, 40, 1, 0, 1, b'0', b'0', b'0', 40);
INSERT INTO `fxy_financial_report_template_items` VALUES (213, 6, '应付利润', NULL, 41, 1, 0, 1, b'0', b'0', b'0', 41);
INSERT INTO `fxy_financial_report_template_items` VALUES (214, 6, '其他应付款', NULL, 42, 1, 0, 1, b'0', b'0', b'0', 42);
INSERT INTO `fxy_financial_report_template_items` VALUES (215, 6, '其他流动负债', NULL, 43, 1, 0, 1, b'0', b'0', b'0', 43);
INSERT INTO `fxy_financial_report_template_items` VALUES (216, 6, '流动负债合计', NULL, 44, 1, 0, 1, b'0', b'0', b'0', 44);
INSERT INTO `fxy_financial_report_template_items` VALUES (217, 6, '非流动负债', NULL, 45, 1, 0, 1, b'1', b'0', b'0', 45);
INSERT INTO `fxy_financial_report_template_items` VALUES (218, 6, '长期借款', NULL, 46, 1, 0, 1, b'0', b'0', b'0', 46);
INSERT INTO `fxy_financial_report_template_items` VALUES (219, 6, '长期应付款', NULL, 47, 1, 0, 1, b'0', b'0', b'0', 47);
INSERT INTO `fxy_financial_report_template_items` VALUES (220, 6, '递延收益', NULL, 48, 1, 0, 1, b'0', b'0', b'0', 48);
INSERT INTO `fxy_financial_report_template_items` VALUES (221, 6, '其他非流动负债', NULL, 49, 1, 0, 1, b'0', b'0', b'0', 49);
INSERT INTO `fxy_financial_report_template_items` VALUES (222, 6, '非流动负债合计', NULL, 50, 1, 0, 1, b'0', b'0', b'0', 50);
INSERT INTO `fxy_financial_report_template_items` VALUES (223, 6, '负债合计', NULL, 51, 1, 0, 1, b'1', b'0', b'0', 51);
INSERT INTO `fxy_financial_report_template_items` VALUES (224, 6, '所有者权益（或股东权益）', NULL, 52, 2, 0, 1, b'1', b'0', b'0', 52);
INSERT INTO `fxy_financial_report_template_items` VALUES (225, 6, '实收资本（或股本）', NULL, 53, 2, 0, 1, b'0', b'0', b'0', 53);
INSERT INTO `fxy_financial_report_template_items` VALUES (226, 6, '资本公积', NULL, 54, 2, 0, 1, b'0', b'0', b'0', 54);
INSERT INTO `fxy_financial_report_template_items` VALUES (227, 6, '盈余公积', NULL, 55, 2, 0, 1, b'0', b'0', b'0', 55);
INSERT INTO `fxy_financial_report_template_items` VALUES (228, 6, '未分配利润', NULL, 56, 2, 0, 1, b'0', b'0', b'0', 56);
INSERT INTO `fxy_financial_report_template_items` VALUES (229, 6, '所有者权益（或股东权益）合计', NULL, 57, 2, 0, 1, b'0', b'0', b'0', 57);
INSERT INTO `fxy_financial_report_template_items` VALUES (230, 6, '负债和所有者权益（或股东权益）', NULL, 58, 2, 0, 1, b'1', b'0', b'0', 58);
INSERT INTO `fxy_financial_report_template_items` VALUES (231, 7, '一、营业外收入', NULL, 1, NULL, 0, 1, b'1', b'1', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (232, 7, '减：营业成本', 231, 2, NULL, 0, 2, b'0', b'1', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (233, 7, '税金及附加', 232, 3, 0, 0, 3, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (234, 7, '其中:消费税', 233, 4, 0, 0, 4, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (235, 7, '营业税', 233, 5, 0, 0, 4, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (236, 7, '城市维护建设税', 233, 6, 0, 0, 4, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (237, 7, '资源税', 233, 7, 0, 0, 4, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (238, 7, '土地增值税', 233, 8, 0, 0, 4, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (239, 7, '城镇土地使用税、房产税、车船税、印花税', 233, 9, 0, 0, 4, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (240, 7, '教育费附加、矿产资源补偿费、排污费', 233, 10, 0, 0, 4, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (241, 7, '销售费用', 232, 11, 0, 0, 3, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (242, 7, '其中：商品维修费', 241, 12, 0, 0, 4, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (243, 7, '广告费和业务宣传费', 241, 13, 0, 0, 4, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (244, 7, '管理费用', 232, 14, 0, 0, 3, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (245, 7, '其中：开办费', 244, 15, 0, 0, 4, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (246, 7, '业务招待费', 244, 16, 0, 0, 4, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (247, 7, '研究费用', 244, 17, 0, 0, 4, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (248, 7, '财务费用', 232, 18, 0, 0, 3, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (249, 7, '其中：利息费用（收入以\'-\'号填列）', 248, 19, 0, 0, 4, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (250, 7, '投资收益（损失以“-”号填列）', 232, 20, 0, 0, 3, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (251, 7, '二、营业利润（亏损失以\'-\'填列）', NULL, 21, NULL, 1, 1, b'1', b'1', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (252, 7, '加：营业外收入', 251, 22, 0, 0, 2, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (253, 7, '其中：政府补助', 252, 23, 0, 0, 3, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (254, 7, '减：营业外支出', 251, 24, 0, 0, 2, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (255, 7, '其中：坏账损失', 254, 25, 0, 0, 3, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (256, 7, '无法收回的长期债券投资损失', 254, 26, 0, 0, 3, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (257, 7, '无法收回的长期股权投资损失', 254, 27, 0, 0, 3, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (258, 7, '自然灾害等不可抗力因素造成的损失', 254, 28, 0, 0, 3, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (259, 7, '税收滞纳金', 254, 29, 0, 0, 3, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (260, 7, '三、利润总额（亏损失以“-”号填列）', NULL, 30, NULL, 1, 1, b'1', b'1', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (261, 7, ' 减：所得税费用', 260, 31, 0, 0, 2, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (262, 7, '四、净利润（亏损失以“-”号填列）', NULL, 32, NULL, 1, 1, b'1', b'1', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (263, 8, '一、经营活动产生的现金流量：', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (264, 8, '销售产成品、商品、提供劳务收到的现金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (265, 8, '收到其他与经营活动有关的现金', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (266, 8, '购买原材料、商品、接受劳务支付的现金', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (267, 8, '支付的职工薪酬', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (268, 8, '支付的税费', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (269, 8, '支付其他与经营活动有关的现金', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (270, 8, '经营活动产生的现金流量净额', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (271, 8, '二、投资活动产生的现金流量：', NULL, 9, 0, 0, 1, b'1', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (272, 8, '收回短期投资、长期债券投资和长期股权投资收到的现金', NULL, 10, 0, 0, 1, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (273, 8, '取得投资收益收到的现金', NULL, 11, 0, 0, 1, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (274, 8, '处置固定资产、无形资产和其他非流动资产收回的现金净额', NULL, 12, 0, 0, 1, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (275, 8, '短期投资、长期债券投资和长期股权投资支付的现金', NULL, 13, 0, 0, 1, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (276, 8, '购建固定资产、无形资产和其他非流动资产支付的现金', NULL, 14, 0, 0, 1, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (277, 8, '投资活动产生的现金流量净额', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (278, 8, '三、筹资活动产生的现金流量：', NULL, 16, 0, 0, 1, b'1', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (279, 8, '取得借款收到的现金', NULL, 17, 0, 0, 1, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (280, 8, '吸收投资者投资收到的现金', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (281, 8, '偿还借款本金支付的现金', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (282, 8, '偿还借款利息支付的现金', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (283, 8, '分配利润支付的现金', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (284, 8, '筹资活动产生的现金流量净额', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (285, 8, '四、现金净增加额', NULL, 23, 0, 0, 1, b'1', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (286, 8, '加：期初现金余额', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (287, 8, '五、期末现金余额', NULL, 25, 0, 0, 1, b'1', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (288, 9, '流动资产', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (289, 9, '货币资金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (290, 9, '短期投资', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (291, 9, '应收票据', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (292, 9, '应收账款', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (293, 9, '预付账款', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (294, 9, '应收股利', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (295, 9, '应收利息', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (296, 9, '其他应收款', NULL, 9, 0, 0, 1, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (297, 9, '存货', NULL, 10, 0, 0, 1, b'0', b'1', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (298, 9, '其中：原材料', 297, 11, 0, 0, 2, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (299, 9, '在产品', 297, 12, 0, 0, 2, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (300, 9, '库存商品', 297, 13, 0, 0, 2, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (301, 9, '周转材料', 297, 14, 0, 0, 2, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (302, 9, '其他流动资产', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (303, 9, '流动资产合计', NULL, 16, 0, 0, 1, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (304, 9, '非流动资产', NULL, 17, 0, 0, 1, b'1', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (305, 9, '长期债券投资', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (306, 9, '长期股权投资', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (307, 9, '固定资产原价编辑', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (308, 9, '减：累计折旧', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (309, 9, '固定资产账面价值', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (310, 9, '在建工程', NULL, 23, 0, 0, 1, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (311, 9, '工程物资', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (312, 9, '固定资产清理', NULL, 25, 0, 0, 1, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (313, 9, '生产性生物资产', NULL, 26, 0, 0, 1, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (314, 9, '无形资产', NULL, 27, 0, 0, 1, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (315, 9, '开发支出', NULL, 28, 0, 0, 1, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (316, 9, '长期待摊费用', NULL, 29, 0, 0, 1, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (317, 9, '其他非流动资产', NULL, 30, 0, 0, 1, b'0', b'0', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (318, 9, '非流动资产合计', NULL, 31, 0, 0, 1, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (319, 9, '资产合计', NULL, 32, 0, 0, 1, b'1', b'0', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (320, 9, '流动负债', NULL, 33, 1, 0, 1, b'1', b'0', b'0', 33);
INSERT INTO `fxy_financial_report_template_items` VALUES (321, 9, '短期借款', NULL, 34, 1, 0, 1, b'0', b'0', b'0', 34);
INSERT INTO `fxy_financial_report_template_items` VALUES (322, 9, '应付票据', NULL, 35, 1, 0, 1, b'0', b'0', b'0', 35);
INSERT INTO `fxy_financial_report_template_items` VALUES (323, 9, '应付账款', NULL, 36, 1, 0, 1, b'0', b'0', b'0', 36);
INSERT INTO `fxy_financial_report_template_items` VALUES (324, 9, '预收账款', NULL, 37, 1, 0, 1, b'0', b'0', b'0', 37);
INSERT INTO `fxy_financial_report_template_items` VALUES (325, 9, '应付职工薪酬', NULL, 38, 1, 0, 1, b'0', b'0', b'0', 38);
INSERT INTO `fxy_financial_report_template_items` VALUES (326, 9, '应交税费', NULL, 39, 1, 0, 1, b'0', b'0', b'0', 39);
INSERT INTO `fxy_financial_report_template_items` VALUES (327, 9, '应付利息', NULL, 40, 1, 0, 1, b'0', b'0', b'0', 40);
INSERT INTO `fxy_financial_report_template_items` VALUES (328, 9, '应付利润', NULL, 41, 1, 0, 1, b'0', b'0', b'0', 41);
INSERT INTO `fxy_financial_report_template_items` VALUES (329, 9, '其他应付款', NULL, 42, 1, 0, 1, b'0', b'0', b'0', 42);
INSERT INTO `fxy_financial_report_template_items` VALUES (330, 9, '其他流动负债', NULL, 43, 1, 0, 1, b'0', b'0', b'0', 43);
INSERT INTO `fxy_financial_report_template_items` VALUES (331, 9, '流动负债合计', NULL, 44, 1, 0, 1, b'0', b'0', b'0', 44);
INSERT INTO `fxy_financial_report_template_items` VALUES (332, 9, '非流动负债', NULL, 45, 1, 0, 1, b'1', b'0', b'0', 45);
INSERT INTO `fxy_financial_report_template_items` VALUES (333, 9, '长期借款', NULL, 46, 1, 0, 1, b'0', b'0', b'0', 46);
INSERT INTO `fxy_financial_report_template_items` VALUES (334, 9, '长期应付款', NULL, 47, 1, 0, 1, b'0', b'0', b'0', 47);
INSERT INTO `fxy_financial_report_template_items` VALUES (335, 9, '递延收益', NULL, 48, 1, 0, 1, b'0', b'0', b'0', 48);
INSERT INTO `fxy_financial_report_template_items` VALUES (336, 9, '其他非流动负债', NULL, 49, 1, 0, 1, b'0', b'0', b'0', 49);
INSERT INTO `fxy_financial_report_template_items` VALUES (337, 9, '非流动负债合计', NULL, 50, 1, 0, 1, b'0', b'0', b'0', 50);
INSERT INTO `fxy_financial_report_template_items` VALUES (338, 9, '负债合计', NULL, 51, 1, 0, 1, b'1', b'0', b'0', 51);
INSERT INTO `fxy_financial_report_template_items` VALUES (339, 9, '所有者权益（或股东权益）', NULL, 52, 2, 0, 1, b'1', b'0', b'0', 52);
INSERT INTO `fxy_financial_report_template_items` VALUES (340, 9, '实收资本（或股本）', NULL, 53, 2, 0, 1, b'0', b'0', b'0', 53);
INSERT INTO `fxy_financial_report_template_items` VALUES (341, 9, '资本公积', NULL, 54, 2, 0, 1, b'0', b'0', b'0', 54);
INSERT INTO `fxy_financial_report_template_items` VALUES (342, 9, '盈余公积', NULL, 55, 2, 0, 1, b'0', b'0', b'0', 55);
INSERT INTO `fxy_financial_report_template_items` VALUES (343, 9, '未分配利润', NULL, 56, 2, 0, 1, b'0', b'0', b'0', 56);
INSERT INTO `fxy_financial_report_template_items` VALUES (344, 9, '所有者权益（或股东权益）合计', NULL, 57, 2, 0, 1, b'0', b'0', b'0', 57);
INSERT INTO `fxy_financial_report_template_items` VALUES (345, 9, '负债和所有者权益（或股东权益）', NULL, 58, 2, 0, 1, b'1', b'0', b'0', 58);
INSERT INTO `fxy_financial_report_template_items` VALUES (347, 10, '一、营业外收入', NULL, 1, NULL, 0, 1, b'1', b'1', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (348, 10, '减：营业成本', 347, 2, NULL, 0, 2, b'0', b'1', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (349, 10, '税金及附加', 348, 3, 0, 0, 3, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (350, 10, '其中:消费税', 349, 4, 0, 0, 4, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (351, 10, '营业税', 349, 5, 0, 0, 4, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (352, 10, '城市维护建设税', 349, 6, 0, 0, 4, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (353, 10, '资源税', 349, 7, 0, 0, 4, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (354, 10, '土地增值税', 349, 8, 0, 0, 4, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (355, 10, '城镇土地使用税、房产税、车船税、印花税', 349, 9, 0, 0, 4, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (356, 10, '教育费附加、矿产资源补偿费、排污费', 349, 10, 0, 0, 4, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (357, 10, '销售费用', 348, 11, 0, 0, 3, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (358, 10, '其中：商品维修费', 357, 12, 0, 0, 4, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (359, 10, '广告费和业务宣传费', 357, 13, 0, 0, 4, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (360, 10, '管理费用', 348, 14, 0, 0, 3, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (361, 10, '其中：开办费', 360, 15, 0, 0, 4, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (362, 10, '业务招待费', 360, 16, 0, 0, 4, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (363, 10, '研究费用', 360, 17, 0, 0, 4, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (364, 10, '财务费用', 348, 18, 0, 0, 3, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (365, 10, '其中：利息费用（收入以\'-\'号填列）', 364, 19, 0, 0, 4, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (366, 10, '投资收益（损失以“-”号填列）', 348, 20, 0, 0, 3, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (367, 10, '二、营业利润（亏损失以\'-\'填列）', NULL, 21, NULL, 1, 1, b'1', b'1', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (368, 10, '加：营业外收入', 367, 22, 0, 0, 2, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (369, 10, '其中：政府补助', 368, 23, 0, 0, 3, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (370, 10, '减：营业外支出', 367, 24, 0, 0, 2, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (371, 10, '其中：坏账损失', 370, 25, 0, 0, 3, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (372, 10, '无法收回的长期债券投资损失', 370, 26, 0, 0, 3, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (373, 10, '无法收回的长期股权投资损失', 370, 27, 0, 0, 3, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (374, 10, '自然灾害等不可抗力因素造成的损失', 370, 28, 0, 0, 3, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (375, 10, '税收滞纳金', 370, 29, 0, 0, 3, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (376, 10, '三、利润总额（亏损失以“-”号填列）', NULL, 30, NULL, 1, 1, b'1', b'1', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (377, 10, ' 减：所得税费用', 376, 31, 0, 0, 2, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (378, 10, '四、净利润（亏损失以“-”号填列）', NULL, 32, NULL, 1, 1, b'1', b'1', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (379, 11, '一、经营活动产生的现金流量：', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (380, 11, '销售产成品、商品、提供劳务收到的现金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (381, 11, '收到其他与经营活动有关的现金', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (382, 11, '购买原材料、商品、接受劳务支付的现金', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (383, 11, '支付的职工薪酬', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (384, 11, '支付的税费', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (385, 11, '支付其他与经营活动有关的现金', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (386, 11, '经营活动产生的现金流量净额', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (387, 11, '二、投资活动产生的现金流量：', NULL, 9, 0, 0, 1, b'1', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (388, 11, '收回短期投资、长期债券投资和长期股权投资收到的现金', NULL, 10, 0, 0, 1, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (389, 11, '取得投资收益收到的现金', NULL, 11, 0, 0, 1, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (390, 11, '处置固定资产、无形资产和其他非流动资产收回的现金净额', NULL, 12, 0, 0, 1, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (391, 11, '短期投资、长期债券投资和长期股权投资支付的现金', NULL, 13, 0, 0, 1, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (392, 11, '购建固定资产、无形资产和其他非流动资产支付的现金', NULL, 14, 0, 0, 1, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (393, 11, '投资活动产生的现金流量净额', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (394, 11, '三、筹资活动产生的现金流量：', NULL, 16, 0, 0, 1, b'1', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (395, 11, '取得借款收到的现金', NULL, 17, 0, 0, 1, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (396, 11, '吸收投资者投资收到的现金', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (397, 11, '偿还借款本金支付的现金', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (398, 11, '偿还借款利息支付的现金', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (399, 11, '分配利润支付的现金', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (400, 11, '筹资活动产生的现金流量净额', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (401, 11, '四、现金净增加额', NULL, 23, 0, 0, 1, b'1', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (402, 11, '加：期初现金余额', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (403, 11, '五、期末现金余额', NULL, 25, 0, 0, 1, b'1', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (404, 12, '流动资产', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (405, 12, '货币资金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (406, 12, '短期投资', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (407, 12, '应收票据', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (408, 12, '应收账款', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (409, 12, '预付账款', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (410, 12, '应收股利', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (411, 12, '应收利息', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (412, 12, '其他应收款', NULL, 9, 0, 0, 1, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (413, 12, '存货', NULL, 10, 0, 0, 1, b'0', b'1', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (414, 12, '其中：原材料', 413, 11, 0, 0, 2, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (415, 12, '在产品', 413, 12, 0, 0, 2, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (416, 12, '库存商品', 413, 13, 0, 0, 2, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (417, 12, '周转材料', 413, 14, 0, 0, 2, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (418, 12, '其他流动资产', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (419, 12, '流动资产合计', NULL, 16, 0, 0, 1, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (420, 12, '非流动资产', NULL, 17, 0, 0, 1, b'1', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (421, 12, '长期债券投资', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (422, 12, '长期股权投资', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (423, 12, '固定资产原价编辑', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (424, 12, '减：累计折旧', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (425, 12, '固定资产账面价值', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (426, 12, '在建工程', NULL, 23, 0, 0, 1, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (427, 12, '工程物资', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (428, 12, '固定资产清理', NULL, 25, 0, 0, 1, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (429, 12, '生产性生物资产', NULL, 26, 0, 0, 1, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (430, 12, '无形资产', NULL, 27, 0, 0, 1, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (431, 12, '开发支出', NULL, 28, 0, 0, 1, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (432, 12, '长期待摊费用', NULL, 29, 0, 0, 1, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (433, 12, '其他非流动资产', NULL, 30, 0, 0, 1, b'0', b'0', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (434, 12, '非流动资产合计', NULL, 31, 0, 0, 1, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (435, 12, '资产合计', NULL, 32, 0, 0, 1, b'1', b'0', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (436, 12, '流动负债', NULL, 33, 1, 0, 1, b'1', b'0', b'0', 33);
INSERT INTO `fxy_financial_report_template_items` VALUES (437, 12, '短期借款', NULL, 34, 1, 0, 1, b'0', b'0', b'0', 34);
INSERT INTO `fxy_financial_report_template_items` VALUES (438, 12, '应付票据', NULL, 35, 1, 0, 1, b'0', b'0', b'0', 35);
INSERT INTO `fxy_financial_report_template_items` VALUES (439, 12, '应付账款', NULL, 36, 1, 0, 1, b'0', b'0', b'0', 36);
INSERT INTO `fxy_financial_report_template_items` VALUES (440, 12, '预收账款', NULL, 37, 1, 0, 1, b'0', b'0', b'0', 37);
INSERT INTO `fxy_financial_report_template_items` VALUES (441, 12, '应付职工薪酬', NULL, 38, 1, 0, 1, b'0', b'0', b'0', 38);
INSERT INTO `fxy_financial_report_template_items` VALUES (442, 12, '应交税费', NULL, 39, 1, 0, 1, b'0', b'0', b'0', 39);
INSERT INTO `fxy_financial_report_template_items` VALUES (443, 12, '应付利息', NULL, 40, 1, 0, 1, b'0', b'0', b'0', 40);
INSERT INTO `fxy_financial_report_template_items` VALUES (444, 12, '应付利润', NULL, 41, 1, 0, 1, b'0', b'0', b'0', 41);
INSERT INTO `fxy_financial_report_template_items` VALUES (445, 12, '其他应付款', NULL, 42, 1, 0, 1, b'0', b'0', b'0', 42);
INSERT INTO `fxy_financial_report_template_items` VALUES (446, 12, '其他流动负债', NULL, 43, 1, 0, 1, b'0', b'0', b'0', 43);
INSERT INTO `fxy_financial_report_template_items` VALUES (447, 12, '流动负债合计', NULL, 44, 1, 0, 1, b'0', b'0', b'0', 44);
INSERT INTO `fxy_financial_report_template_items` VALUES (448, 12, '非流动负债', NULL, 45, 1, 0, 1, b'1', b'0', b'0', 45);
INSERT INTO `fxy_financial_report_template_items` VALUES (449, 12, '长期借款', NULL, 46, 1, 0, 1, b'0', b'0', b'0', 46);
INSERT INTO `fxy_financial_report_template_items` VALUES (450, 12, '长期应付款', NULL, 47, 1, 0, 1, b'0', b'0', b'0', 47);
INSERT INTO `fxy_financial_report_template_items` VALUES (451, 12, '递延收益', NULL, 48, 1, 0, 1, b'0', b'0', b'0', 48);
INSERT INTO `fxy_financial_report_template_items` VALUES (452, 12, '其他非流动负债', NULL, 49, 1, 0, 1, b'0', b'0', b'0', 49);
INSERT INTO `fxy_financial_report_template_items` VALUES (453, 12, '非流动负债合计', NULL, 50, 1, 0, 1, b'0', b'0', b'0', 50);
INSERT INTO `fxy_financial_report_template_items` VALUES (454, 12, '负债合计', NULL, 51, 1, 0, 1, b'1', b'0', b'0', 51);
INSERT INTO `fxy_financial_report_template_items` VALUES (455, 12, '所有者权益（或股东权益）', NULL, 52, 2, 0, 1, b'1', b'0', b'0', 52);
INSERT INTO `fxy_financial_report_template_items` VALUES (456, 12, '实收资本（或股本）', NULL, 53, 2, 0, 1, b'0', b'0', b'0', 53);
INSERT INTO `fxy_financial_report_template_items` VALUES (457, 12, '资本公积', NULL, 54, 2, 0, 1, b'0', b'0', b'0', 54);
INSERT INTO `fxy_financial_report_template_items` VALUES (458, 12, '盈余公积', NULL, 55, 2, 0, 1, b'0', b'0', b'0', 55);
INSERT INTO `fxy_financial_report_template_items` VALUES (459, 12, '未分配利润', NULL, 56, 2, 0, 1, b'0', b'0', b'0', 56);
INSERT INTO `fxy_financial_report_template_items` VALUES (460, 12, '所有者权益（或股东权益）合计', NULL, 57, 2, 0, 1, b'0', b'0', b'0', 57);
INSERT INTO `fxy_financial_report_template_items` VALUES (461, 12, '负债和所有者权益（或股东权益）', NULL, 58, 2, 0, 1, b'1', b'0', b'0', 58);
INSERT INTO `fxy_financial_report_template_items` VALUES (464, 13, '减：营业成本', 463, 2, NULL, 0, 2, b'0', b'1', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (465, 13, '税金及附加', 464, 3, 0, 0, 3, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (466, 13, '其中:消费税', 465, 4, 0, 0, 4, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (467, 13, '营业税', 465, 5, 0, 0, 4, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (468, 13, '城市维护建设税', 465, 6, 0, 0, 4, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (469, 13, '资源税', 465, 7, 0, 0, 4, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (470, 13, '土地增值税', 465, 8, 0, 0, 4, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (471, 13, '城镇土地使用税、房产税、车船税、印花税', 465, 9, 0, 0, 4, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (472, 13, '教育费附加、矿产资源补偿费、排污费', 465, 10, 0, 0, 4, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (473, 13, '销售费用', 464, 11, 0, 0, 3, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (474, 13, '其中：商品维修费', 473, 12, 0, 0, 4, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (475, 13, '广告费和业务宣传费', 473, 13, 0, 0, 4, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (476, 13, '管理费用', 464, 14, 0, 0, 3, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (477, 13, '其中：开办费', 476, 15, 0, 0, 4, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (478, 13, '业务招待费', 476, 16, 0, 0, 4, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (479, 13, '研究费用', 476, 17, 0, 0, 4, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (480, 13, '财务费用', 464, 18, 0, 0, 3, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (481, 13, '其中：利息费用（收入以\'-\'号填列）', 480, 19, 0, 0, 4, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (482, 13, '投资收益（损失以“-”号填列）', 464, 20, 0, 0, 3, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (483, 13, '二、营业利润（亏损失以\'-\'填列）', NULL, 21, NULL, 1, 1, b'1', b'1', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (484, 13, '加：营业外收入', 483, 22, 0, 0, 2, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (485, 13, '其中：政府补助', 484, 23, 0, 0, 3, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (486, 13, '减：营业外支出', 483, 24, 0, 0, 2, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (487, 13, '其中：坏账损失', 486, 25, 0, 0, 3, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (488, 13, '无法收回的长期债券投资损失', 486, 26, 0, 0, 3, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (489, 13, '无法收回的长期股权投资损失', 486, 27, 0, 0, 3, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (490, 13, '自然灾害等不可抗力因素造成的损失', 486, 28, 0, 0, 3, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (491, 13, '税收滞纳金', 486, 29, 0, 0, 3, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (492, 13, '三、利润总额（亏损失以“-”号填列）', NULL, 30, NULL, 1, 1, b'1', b'1', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (493, 13, ' 减：所得税费用', 492, 31, 0, 0, 2, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (494, 13, '四、净利润（亏损失以“-”号填列）', NULL, 32, NULL, 1, 1, b'1', b'1', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (495, 14, '一、经营活动产生的现金流量：', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (496, 14, '销售产成品、商品、提供劳务收到的现金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (497, 14, '收到其他与经营活动有关的现金', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (498, 14, '购买原材料、商品、接受劳务支付的现金', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (499, 14, '支付的职工薪酬', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (500, 14, '支付的税费', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (501, 14, '支付其他与经营活动有关的现金', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (502, 14, '经营活动产生的现金流量净额', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (503, 14, '二、投资活动产生的现金流量：', NULL, 9, 0, 0, 1, b'1', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (504, 14, '收回短期投资、长期债券投资和长期股权投资收到的现金', NULL, 10, 0, 0, 1, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (505, 14, '取得投资收益收到的现金', NULL, 11, 0, 0, 1, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (506, 14, '处置固定资产、无形资产和其他非流动资产收回的现金净额', NULL, 12, 0, 0, 1, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (507, 14, '短期投资、长期债券投资和长期股权投资支付的现金', NULL, 13, 0, 0, 1, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (508, 14, '购建固定资产、无形资产和其他非流动资产支付的现金', NULL, 14, 0, 0, 1, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (509, 14, '投资活动产生的现金流量净额', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (510, 14, '三、筹资活动产生的现金流量：', NULL, 16, 0, 0, 1, b'1', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (511, 14, '取得借款收到的现金', NULL, 17, 0, 0, 1, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (512, 14, '吸收投资者投资收到的现金', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (513, 14, '偿还借款本金支付的现金', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (514, 14, '偿还借款利息支付的现金', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (515, 14, '分配利润支付的现金', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (516, 14, '筹资活动产生的现金流量净额', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (517, 14, '四、现金净增加额', NULL, 23, 0, 0, 1, b'1', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (518, 14, '加：期初现金余额', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (519, 14, '五、期末现金余额', NULL, 25, 0, 0, 1, b'1', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (520, 15, '流动资产', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (521, 15, '货币资金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (522, 15, '短期投资', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (523, 15, '应收票据', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (524, 15, '应收账款', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (525, 15, '预付账款', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (526, 15, '应收股利', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (527, 15, '应收利息', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (528, 15, '其他应收款', NULL, 9, 0, 0, 1, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (529, 15, '存货', NULL, 10, 0, 0, 1, b'0', b'1', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (530, 15, '其中：原材料', 529, 11, 0, 0, 2, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (531, 15, '在产品', 529, 12, 0, 0, 2, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (532, 15, '库存商品', 529, 13, 0, 0, 2, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (533, 15, '周转材料', 529, 14, 0, 0, 2, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (534, 15, '其他流动资产', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (535, 15, '流动资产合计', NULL, 16, 0, 0, 1, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (536, 15, '非流动资产', NULL, 17, 0, 0, 1, b'1', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (537, 15, '长期债券投资', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (538, 15, '长期股权投资', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (539, 15, '固定资产原价编辑', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (540, 15, '减：累计折旧', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (541, 15, '固定资产账面价值', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (542, 15, '在建工程', NULL, 23, 0, 0, 1, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (543, 15, '工程物资', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (544, 15, '固定资产清理', NULL, 25, 0, 0, 1, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (545, 15, '生产性生物资产', NULL, 26, 0, 0, 1, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (546, 15, '无形资产', NULL, 27, 0, 0, 1, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (547, 15, '开发支出', NULL, 28, 0, 0, 1, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (548, 15, '长期待摊费用', NULL, 29, 0, 0, 1, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (549, 15, '其他非流动资产', NULL, 30, 0, 0, 1, b'0', b'0', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (550, 15, '非流动资产合计', NULL, 31, 0, 0, 1, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (551, 15, '资产合计', NULL, 32, 0, 0, 1, b'1', b'0', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (552, 15, '流动负债', NULL, 33, 1, 0, 1, b'1', b'0', b'0', 33);
INSERT INTO `fxy_financial_report_template_items` VALUES (553, 15, '短期借款', NULL, 34, 1, 0, 1, b'0', b'0', b'0', 34);
INSERT INTO `fxy_financial_report_template_items` VALUES (554, 15, '应付票据', NULL, 35, 1, 0, 1, b'0', b'0', b'0', 35);
INSERT INTO `fxy_financial_report_template_items` VALUES (555, 15, '应付账款', NULL, 36, 1, 0, 1, b'0', b'0', b'0', 36);
INSERT INTO `fxy_financial_report_template_items` VALUES (556, 15, '预收账款', NULL, 37, 1, 0, 1, b'0', b'0', b'0', 37);
INSERT INTO `fxy_financial_report_template_items` VALUES (557, 15, '应付职工薪酬', NULL, 38, 1, 0, 1, b'0', b'0', b'0', 38);
INSERT INTO `fxy_financial_report_template_items` VALUES (558, 15, '应交税费', NULL, 39, 1, 0, 1, b'0', b'0', b'0', 39);
INSERT INTO `fxy_financial_report_template_items` VALUES (559, 15, '应付利息', NULL, 40, 1, 0, 1, b'0', b'0', b'0', 40);
INSERT INTO `fxy_financial_report_template_items` VALUES (560, 15, '应付利润', NULL, 41, 1, 0, 1, b'0', b'0', b'0', 41);
INSERT INTO `fxy_financial_report_template_items` VALUES (561, 15, '其他应付款', NULL, 42, 1, 0, 1, b'0', b'0', b'0', 42);
INSERT INTO `fxy_financial_report_template_items` VALUES (562, 15, '其他流动负债', NULL, 43, 1, 0, 1, b'0', b'0', b'0', 43);
INSERT INTO `fxy_financial_report_template_items` VALUES (563, 15, '流动负债合计', NULL, 44, 1, 0, 1, b'0', b'0', b'0', 44);
INSERT INTO `fxy_financial_report_template_items` VALUES (564, 15, '非流动负债', NULL, 45, 1, 0, 1, b'1', b'0', b'0', 45);
INSERT INTO `fxy_financial_report_template_items` VALUES (565, 15, '长期借款', NULL, 46, 1, 0, 1, b'0', b'0', b'0', 46);
INSERT INTO `fxy_financial_report_template_items` VALUES (566, 15, '长期应付款', NULL, 47, 1, 0, 1, b'0', b'0', b'0', 47);
INSERT INTO `fxy_financial_report_template_items` VALUES (567, 15, '递延收益', NULL, 48, 1, 0, 1, b'0', b'0', b'0', 48);
INSERT INTO `fxy_financial_report_template_items` VALUES (568, 15, '其他非流动负债', NULL, 49, 1, 0, 1, b'0', b'0', b'0', 49);
INSERT INTO `fxy_financial_report_template_items` VALUES (569, 15, '非流动负债合计', NULL, 50, 1, 0, 1, b'0', b'0', b'0', 50);
INSERT INTO `fxy_financial_report_template_items` VALUES (570, 15, '负债合计', NULL, 51, 1, 0, 1, b'1', b'0', b'0', 51);
INSERT INTO `fxy_financial_report_template_items` VALUES (571, 15, '所有者权益（或股东权益）', NULL, 52, 2, 0, 1, b'1', b'0', b'0', 52);
INSERT INTO `fxy_financial_report_template_items` VALUES (572, 15, '实收资本（或股本）', NULL, 53, 2, 0, 1, b'0', b'0', b'0', 53);
INSERT INTO `fxy_financial_report_template_items` VALUES (573, 15, '资本公积', NULL, 54, 2, 0, 1, b'0', b'0', b'0', 54);
INSERT INTO `fxy_financial_report_template_items` VALUES (574, 15, '盈余公积', NULL, 55, 2, 0, 1, b'0', b'0', b'0', 55);
INSERT INTO `fxy_financial_report_template_items` VALUES (575, 15, '未分配利润', NULL, 56, 2, 0, 1, b'0', b'0', b'0', 56);
INSERT INTO `fxy_financial_report_template_items` VALUES (576, 15, '所有者权益（或股东权益）合计', NULL, 57, 2, 0, 1, b'0', b'0', b'0', 57);
INSERT INTO `fxy_financial_report_template_items` VALUES (577, 15, '负债和所有者权益（或股东权益）', NULL, 58, 2, 0, 1, b'1', b'0', b'0', 58);
INSERT INTO `fxy_financial_report_template_items` VALUES (578, 16, '一、营业外收入', NULL, 1, NULL, 0, 1, b'1', b'1', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (579, 16, '减：营业成本', 578, 2, NULL, 0, 2, b'0', b'1', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (580, 16, '税金及附加', 579, 3, 0, 0, 3, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (581, 16, '其中:消费税', 580, 4, 0, 0, 4, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (582, 16, '营业税', 580, 5, 0, 0, 4, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (583, 16, '城市维护建设税', 580, 6, 0, 0, 4, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (584, 16, '资源税', 580, 7, 0, 0, 4, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (585, 16, '土地增值税', 580, 8, 0, 0, 4, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (586, 16, '城镇土地使用税、房产税、车船税、印花税', 580, 9, 0, 0, 4, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (587, 16, '教育费附加、矿产资源补偿费、排污费', 580, 10, 0, 0, 4, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (588, 16, '销售费用', 579, 11, 0, 0, 3, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (589, 16, '其中：商品维修费', 588, 12, 0, 0, 4, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (590, 16, '广告费和业务宣传费', 588, 13, 0, 0, 4, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (591, 16, '管理费用', 579, 14, 0, 0, 3, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (592, 16, '其中：开办费', 591, 15, 0, 0, 4, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (593, 16, '业务招待费', 591, 16, 0, 0, 4, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (594, 16, '研究费用', 591, 17, 0, 0, 4, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (595, 16, '财务费用', 579, 18, 0, 0, 3, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (596, 16, '其中：利息费用（收入以\'-\'号填列）', 595, 19, 0, 0, 4, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (597, 16, '投资收益（损失以“-”号填列）', 579, 20, 0, 0, 3, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (598, 16, '二、营业利润（亏损失以\'-\'填列）', NULL, 21, NULL, 1, 1, b'1', b'1', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (599, 16, '加：营业外收入', 598, 22, 0, 0, 2, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (600, 16, '其中：政府补助', 599, 23, 0, 0, 3, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (601, 16, '减：营业外支出', 598, 24, 0, 0, 2, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (602, 16, '其中：坏账损失', 601, 25, 0, 0, 3, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (603, 16, '无法收回的长期债券投资损失', 601, 26, 0, 0, 3, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (604, 16, '无法收回的长期股权投资损失', 601, 27, 0, 0, 3, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (605, 16, '自然灾害等不可抗力因素造成的损失', 601, 28, 0, 0, 3, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (606, 16, '税收滞纳金', 601, 29, 0, 0, 3, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (607, 16, '三、利润总额（亏损失以“-”号填列）', NULL, 30, NULL, 1, 1, b'1', b'1', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (608, 16, ' 减：所得税费用', 607, 31, 0, 0, 2, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (609, 16, '四、净利润（亏损失以“-”号填列）', NULL, 32, NULL, 1, 1, b'1', b'1', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (610, 17, '一、经营活动产生的现金流量：', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (611, 17, '销售产成品、商品、提供劳务收到的现金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (612, 17, '收到其他与经营活动有关的现金', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (613, 17, '购买原材料、商品、接受劳务支付的现金', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (614, 17, '支付的职工薪酬', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (615, 17, '支付的税费', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (616, 17, '支付其他与经营活动有关的现金', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (617, 17, '经营活动产生的现金流量净额', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (618, 17, '二、投资活动产生的现金流量：', NULL, 9, 0, 0, 1, b'1', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (619, 17, '收回短期投资、长期债券投资和长期股权投资收到的现金', NULL, 10, 0, 0, 1, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (620, 17, '取得投资收益收到的现金', NULL, 11, 0, 0, 1, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (621, 17, '处置固定资产、无形资产和其他非流动资产收回的现金净额', NULL, 12, 0, 0, 1, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (622, 17, '短期投资、长期债券投资和长期股权投资支付的现金', NULL, 13, 0, 0, 1, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (623, 17, '购建固定资产、无形资产和其他非流动资产支付的现金', NULL, 14, 0, 0, 1, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (624, 17, '投资活动产生的现金流量净额', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (625, 17, '三、筹资活动产生的现金流量：', NULL, 16, 0, 0, 1, b'1', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (626, 17, '取得借款收到的现金', NULL, 17, 0, 0, 1, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (627, 17, '吸收投资者投资收到的现金', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (628, 17, '偿还借款本金支付的现金', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (629, 17, '偿还借款利息支付的现金', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (630, 17, '分配利润支付的现金', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (631, 17, '筹资活动产生的现金流量净额', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (632, 17, '四、现金净增加额', NULL, 23, 0, 0, 1, b'1', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (633, 17, '加：期初现金余额', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (634, 17, '五、期末现金余额', NULL, 25, 0, 0, 1, b'1', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (635, 18, '流动资产', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (636, 18, '货币资金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (637, 18, '短期投资', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (638, 18, '应收票据', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (639, 18, '应收账款', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (640, 18, '预付账款', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (641, 18, '应收股利', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (642, 18, '应收利息', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (643, 18, '其他应收款', NULL, 9, 0, 0, 1, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (644, 18, '存货', NULL, 10, 0, 0, 1, b'0', b'1', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (645, 18, '其中：原材料', 644, 11, 0, 0, 2, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (646, 18, '在产品', 644, 12, 0, 0, 2, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (647, 18, '库存商品', 644, 13, 0, 0, 2, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (648, 18, '周转材料', 644, 14, 0, 0, 2, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (649, 18, '其他流动资产', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (650, 18, '流动资产合计', NULL, 16, 0, 0, 1, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (651, 18, '非流动资产', NULL, 17, 0, 0, 1, b'1', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (652, 18, '长期债券投资', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (653, 18, '长期股权投资', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (654, 18, '固定资产原价编辑', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (655, 18, '减：累计折旧', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (656, 18, '固定资产账面价值', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (657, 18, '在建工程', NULL, 23, 0, 0, 1, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (658, 18, '工程物资', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (659, 18, '固定资产清理', NULL, 25, 0, 0, 1, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (660, 18, '生产性生物资产', NULL, 26, 0, 0, 1, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (661, 18, '无形资产', NULL, 27, 0, 0, 1, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (662, 18, '开发支出', NULL, 28, 0, 0, 1, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (663, 18, '长期待摊费用', NULL, 29, 0, 0, 1, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (664, 18, '其他非流动资产', NULL, 30, 0, 0, 1, b'0', b'0', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (665, 18, '非流动资产合计', NULL, 31, 0, 0, 1, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (666, 18, '资产合计', NULL, 32, 0, 0, 1, b'1', b'0', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (667, 18, '流动负债', NULL, 33, 1, 0, 1, b'1', b'0', b'0', 33);
INSERT INTO `fxy_financial_report_template_items` VALUES (668, 18, '短期借款', NULL, 34, 1, 0, 1, b'0', b'0', b'0', 34);
INSERT INTO `fxy_financial_report_template_items` VALUES (669, 18, '应付票据', NULL, 35, 1, 0, 1, b'0', b'0', b'0', 35);
INSERT INTO `fxy_financial_report_template_items` VALUES (670, 18, '应付账款', NULL, 36, 1, 0, 1, b'0', b'0', b'0', 36);
INSERT INTO `fxy_financial_report_template_items` VALUES (671, 18, '预收账款', NULL, 37, 1, 0, 1, b'0', b'0', b'0', 37);
INSERT INTO `fxy_financial_report_template_items` VALUES (672, 18, '应付职工薪酬', NULL, 38, 1, 0, 1, b'0', b'0', b'0', 38);
INSERT INTO `fxy_financial_report_template_items` VALUES (673, 18, '应交税费', NULL, 39, 1, 0, 1, b'0', b'0', b'0', 39);
INSERT INTO `fxy_financial_report_template_items` VALUES (674, 18, '应付利息', NULL, 40, 1, 0, 1, b'0', b'0', b'0', 40);
INSERT INTO `fxy_financial_report_template_items` VALUES (675, 18, '应付利润', NULL, 41, 1, 0, 1, b'0', b'0', b'0', 41);
INSERT INTO `fxy_financial_report_template_items` VALUES (676, 18, '其他应付款', NULL, 42, 1, 0, 1, b'0', b'0', b'0', 42);
INSERT INTO `fxy_financial_report_template_items` VALUES (677, 18, '其他流动负债', NULL, 43, 1, 0, 1, b'0', b'0', b'0', 43);
INSERT INTO `fxy_financial_report_template_items` VALUES (678, 18, '流动负债合计', NULL, 44, 1, 0, 1, b'0', b'0', b'0', 44);
INSERT INTO `fxy_financial_report_template_items` VALUES (679, 18, '非流动负债', NULL, 45, 1, 0, 1, b'1', b'0', b'0', 45);
INSERT INTO `fxy_financial_report_template_items` VALUES (680, 18, '长期借款', NULL, 46, 1, 0, 1, b'0', b'0', b'0', 46);
INSERT INTO `fxy_financial_report_template_items` VALUES (681, 18, '长期应付款', NULL, 47, 1, 0, 1, b'0', b'0', b'0', 47);
INSERT INTO `fxy_financial_report_template_items` VALUES (682, 18, '递延收益', NULL, 48, 1, 0, 1, b'0', b'0', b'0', 48);
INSERT INTO `fxy_financial_report_template_items` VALUES (683, 18, '其他非流动负债', NULL, 49, 1, 0, 1, b'0', b'0', b'0', 49);
INSERT INTO `fxy_financial_report_template_items` VALUES (684, 18, '非流动负债合计', NULL, 50, 1, 0, 1, b'0', b'0', b'0', 50);
INSERT INTO `fxy_financial_report_template_items` VALUES (685, 18, '负债合计', NULL, 51, 1, 0, 1, b'1', b'0', b'0', 51);
INSERT INTO `fxy_financial_report_template_items` VALUES (686, 18, '所有者权益（或股东权益）', NULL, 52, 2, 0, 1, b'1', b'0', b'0', 52);
INSERT INTO `fxy_financial_report_template_items` VALUES (687, 18, '实收资本（或股本）', NULL, 53, 2, 0, 1, b'0', b'0', b'0', 53);
INSERT INTO `fxy_financial_report_template_items` VALUES (688, 18, '资本公积', NULL, 54, 2, 0, 1, b'0', b'0', b'0', 54);
INSERT INTO `fxy_financial_report_template_items` VALUES (689, 18, '盈余公积', NULL, 55, 2, 0, 1, b'0', b'0', b'0', 55);
INSERT INTO `fxy_financial_report_template_items` VALUES (690, 18, '未分配利润', NULL, 56, 2, 0, 1, b'0', b'0', b'0', 56);
INSERT INTO `fxy_financial_report_template_items` VALUES (691, 18, '所有者权益（或股东权益）合计', NULL, 57, 2, 0, 1, b'0', b'0', b'0', 57);
INSERT INTO `fxy_financial_report_template_items` VALUES (692, 18, '负债和所有者权益（或股东权益）', NULL, 58, 2, 0, 1, b'1', b'0', b'0', 58);
INSERT INTO `fxy_financial_report_template_items` VALUES (693, 13, '一', NULL, 1, 0, 0, 1, b'0', b'0', b'0', 1);

-- ----------------------------
-- Table structure for fxy_financial_report_template_items_formula
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_report_template_items_formula`;
CREATE TABLE `fxy_financial_report_template_items_formula`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `template_id` int NOT NULL COMMENT '模板 id',
  `template_items_id` int NOT NULL,
  `account_sets_id` int NOT NULL,
  `calculation` enum('+','-','*','/') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '+' COMMENT '计算方式',
  `access_rules` int NOT NULL COMMENT '取数规则：0,净发生额度 1,借方发生额 2,贷方发生额',
  `from_tag` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据来源标识',
  `source` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fxy_at_fk`(`account_sets_id`) USING BTREE,
  INDEX `fxy_ift_fk`(`template_id`) USING BTREE,
  INDEX `fxy_tif_fk`(`template_items_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 316 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模板项公式表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_report_template_items_formula
-- ----------------------------
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1, 1, 1, 1, '+', 0, '264', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (2, 1, 1, 1, '+', 0, '265', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (3, 1, 2, 1, '+', 0, '272', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (4, 1, 2, 1, '+', 0, '273', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (5, 1, 3, 1, '+', 0, '274', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (6, 1, 4, 1, '+', 0, '215', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (7, 1, 5, 1, '+', 0, '216', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (8, 1, 6, 1, '+', 0, '220', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (9, 1, 7, 1, '+', 0, '217', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (10, 1, 8, 1, '+', 0, '219', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (11, 1, 9, 1, '+', 0, '222', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (12, 1, 9, 1, '+', 0, '221', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (13, 1, 9, 1, '+', 0, '223', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (14, 1, 9, 1, '+', 0, '229', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (15, 1, 10, 1, '+', 0, '225', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (16, 1, 10, 1, '+', 0, '227', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (17, 1, 10, 1, '+', 0, '228', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (18, 1, 11, 1, '+', 0, '275', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (19, 1, 12, 1, '+', 0, '285', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (20, 1, 13, 1, '+', 0, '290', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (21, 1, 13, 1, '+', 0, '291', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (22, 1, 14, 1, '+', 0, '292', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (23, 1, 15, 1, '+', 0, '301', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (24, 1, 16, 1, '+', 0, '294', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (25, 1, 17, 1, '+', 0, '302', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (26, 1, 18, 1, '+', 0, '305', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (27, 1, 19, 1, '+', 0, '306', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (28, 1, 20, 1, '+', 0, '266', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (29, 1, 21, 1, '+', 0, '1', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (30, 1, 21, 1, '-', 0, '2', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (31, 1, 21, 1, '-', 0, '3', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (32, 1, 21, 1, '-', 0, '11', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (33, 1, 21, 1, '-', 0, '14', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (34, 1, 21, 1, '-', 0, '18', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (35, 1, 21, 1, '+', 0, '20', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (36, 1, 22, 1, '+', 0, '267', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (37, 1, 23, 1, '+', 0, '269', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (38, 1, 24, 1, '+', 0, '310', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (39, 1, 25, 1, '+', 0, '315', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (40, 1, 26, 1, '+', 0, '317', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (41, 1, 27, 1, '+', 0, '318', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (42, 1, 28, 1, '+', 0, '319', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (43, 1, 29, 1, '+', 0, '320', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (44, 1, 30, 1, '+', 0, '22', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (45, 1, 30, 1, '-', 0, '24', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (46, 1, 30, 1, '+', 0, '21', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (47, 1, 31, 1, '+', 0, '322', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (48, 1, 32, 1, '+', 0, '30', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (49, 1, 32, 1, '-', 0, '31', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (56, 4, 120, 2, '+', 0, '377', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (57, 4, 121, 2, '+', 0, '381', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (58, 4, 122, 2, '+', 0, '378', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (59, 4, 123, 2, '+', 0, '380', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (60, 4, 124, 2, '+', 0, '383', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (61, 4, 124, 2, '+', 0, '382', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (62, 4, 124, 2, '+', 0, '384', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (63, 4, 124, 2, '+', 0, '390', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (64, 4, 125, 2, '+', 0, '386', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (65, 4, 125, 2, '+', 0, '388', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (66, 4, 125, 2, '+', 0, '389', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (67, 4, 126, 2, '+', 0, '436', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (68, 4, 127, 2, '+', 0, '446', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (69, 4, 128, 2, '+', 0, '451', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (70, 4, 128, 2, '+', 0, '452', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (71, 4, 129, 2, '+', 0, '453', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (72, 4, 130, 2, '+', 0, '462', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (73, 4, 131, 2, '+', 0, '455', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (74, 4, 132, 2, '+', 0, '463', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (75, 4, 133, 2, '+', 0, '466', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (76, 4, 134, 2, '+', 0, '467', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (78, 4, 136, 2, '+', 0, '116', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (79, 4, 136, 2, '-', 0, '117', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (80, 4, 136, 2, '-', 0, '118', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (81, 4, 136, 2, '-', 0, '126', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (82, 4, 136, 2, '-', 0, '129', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (83, 4, 136, 2, '-', 0, '133', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (84, 4, 136, 2, '+', 0, '135', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (85, 4, 137, 2, '+', 0, '428', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (86, 4, 138, 2, '+', 0, '430', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (87, 4, 139, 2, '+', 0, '471', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (88, 4, 140, 2, '+', 0, '476', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (89, 4, 141, 2, '+', 0, '478', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (90, 4, 142, 2, '+', 0, '479', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (91, 4, 143, 2, '+', 0, '480', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (92, 4, 144, 2, '+', 0, '481', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (93, 4, 145, 2, '+', 0, '137', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (94, 4, 145, 2, '-', 0, '139', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (95, 4, 145, 2, '+', 0, '136', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (96, 4, 146, 2, '+', 0, '483', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (97, 4, 147, 2, '+', 0, '145', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (98, 4, 147, 2, '-', 0, '146', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (99, 7, 231, 3, '+', 0, '586', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (100, 7, 231, 3, '+', 0, '587', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (101, 7, 232, 3, '+', 0, '594', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (102, 7, 232, 3, '+', 0, '595', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (103, 7, 233, 3, '+', 0, '596', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (104, 7, 234, 3, '+', 0, '537', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (105, 7, 235, 3, '+', 0, '538', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (106, 7, 236, 3, '+', 0, '542', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (107, 7, 237, 3, '+', 0, '539', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (108, 7, 238, 3, '+', 0, '541', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (109, 7, 239, 3, '+', 0, '544', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (110, 7, 239, 3, '+', 0, '543', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (111, 7, 239, 3, '+', 0, '545', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (112, 7, 239, 3, '+', 0, '551', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (113, 7, 240, 3, '+', 0, '547', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (114, 7, 240, 3, '+', 0, '549', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (115, 7, 240, 3, '+', 0, '550', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (116, 7, 241, 3, '+', 0, '597', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (117, 7, 242, 3, '+', 0, '607', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (118, 7, 243, 3, '+', 0, '612', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (119, 7, 243, 3, '+', 0, '613', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (120, 7, 244, 3, '+', 0, '614', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (121, 7, 245, 3, '+', 0, '623', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (122, 7, 246, 3, '+', 0, '616', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (123, 7, 247, 3, '+', 0, '624', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (124, 7, 248, 3, '+', 0, '627', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (125, 7, 249, 3, '+', 0, '628', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (126, 7, 250, 3, '+', 0, '588', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (127, 7, 251, 3, '+', 0, '231', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (128, 7, 251, 3, '-', 0, '232', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (129, 7, 251, 3, '-', 0, '233', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (130, 7, 251, 3, '-', 0, '241', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (131, 7, 251, 3, '-', 0, '244', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (132, 7, 251, 3, '-', 0, '248', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (133, 7, 251, 3, '+', 0, '250', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (134, 7, 252, 3, '+', 0, '589', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (135, 7, 253, 3, '+', 0, '591', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (136, 7, 254, 3, '+', 0, '632', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (137, 7, 255, 3, '+', 0, '637', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (138, 7, 256, 3, '+', 0, '639', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (139, 7, 257, 3, '+', 0, '640', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (140, 7, 258, 3, '+', 0, '641', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (141, 7, 259, 3, '+', 0, '642', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (142, 7, 260, 3, '+', 0, '252', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (143, 7, 260, 3, '-', 0, '254', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (144, 7, 260, 3, '+', 0, '251', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (145, 7, 261, 3, '+', 0, '644', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (146, 7, 262, 3, '+', 0, '260', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (147, 7, 262, 3, '-', 0, '261', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (148, 1, 346, 1, '+', 0, '163', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (149, 2, 35, 1, '+', 0, '163', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (150, 2, 35, 1, '+', 0, '164', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (151, 10, 347, 4, '+', 0, '747', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (152, 10, 347, 4, '+', 0, '748', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (153, 10, 348, 4, '+', 0, '755', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (154, 10, 348, 4, '+', 0, '756', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (155, 10, 349, 4, '+', 0, '757', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (156, 10, 350, 4, '+', 0, '698', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (157, 10, 351, 4, '+', 0, '699', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (158, 10, 352, 4, '+', 0, '703', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (159, 10, 353, 4, '+', 0, '700', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (160, 10, 354, 4, '+', 0, '702', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (161, 10, 355, 4, '+', 0, '705', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (162, 10, 355, 4, '+', 0, '704', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (163, 10, 355, 4, '+', 0, '706', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (164, 10, 355, 4, '+', 0, '712', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (165, 10, 356, 4, '+', 0, '708', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (166, 10, 356, 4, '+', 0, '710', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (167, 10, 356, 4, '+', 0, '711', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (168, 10, 357, 4, '+', 0, '758', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (169, 10, 358, 4, '+', 0, '768', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (170, 10, 359, 4, '+', 0, '773', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (171, 10, 359, 4, '+', 0, '774', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (172, 10, 360, 4, '+', 0, '775', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (173, 10, 361, 4, '+', 0, '784', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (174, 10, 362, 4, '+', 0, '777', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (175, 10, 363, 4, '+', 0, '785', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (176, 10, 364, 4, '+', 0, '788', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (177, 10, 365, 4, '+', 0, '789', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (178, 10, 366, 4, '+', 0, '749', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (179, 10, 367, 4, '+', 0, '347', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (180, 10, 367, 4, '-', 0, '348', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (181, 10, 367, 4, '-', 0, '349', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (182, 10, 367, 4, '-', 0, '357', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (183, 10, 367, 4, '-', 0, '360', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (184, 10, 367, 4, '-', 0, '364', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (185, 10, 367, 4, '+', 0, '366', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (186, 10, 368, 4, '+', 0, '750', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (187, 10, 369, 4, '+', 0, '752', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (188, 10, 370, 4, '+', 0, '793', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (189, 10, 371, 4, '+', 0, '798', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (190, 10, 372, 4, '+', 0, '800', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (191, 10, 373, 4, '+', 0, '801', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (192, 10, 374, 4, '+', 0, '802', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (193, 10, 375, 4, '+', 0, '803', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (194, 10, 376, 4, '+', 0, '368', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (195, 10, 376, 4, '-', 0, '370', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (196, 10, 376, 4, '+', 0, '367', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (197, 10, 377, 4, '+', 0, '805', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (198, 10, 378, 4, '+', 0, '376', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (199, 10, 378, 4, '-', 0, '377', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (201, 13, 463, 5, '+', 0, '908', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (202, 13, 463, 5, '+', 0, '909', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (203, 13, 464, 5, '+', 0, '916', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (204, 13, 464, 5, '+', 0, '917', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (205, 13, 465, 5, '+', 0, '918', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (206, 13, 466, 5, '+', 0, '859', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (207, 13, 467, 5, '+', 0, '860', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (208, 13, 468, 5, '+', 0, '864', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (209, 13, 469, 5, '+', 0, '861', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (210, 13, 470, 5, '+', 0, '863', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (211, 13, 471, 5, '+', 0, '866', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (212, 13, 471, 5, '+', 0, '865', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (213, 13, 471, 5, '+', 0, '867', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (214, 13, 471, 5, '+', 0, '873', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (215, 13, 472, 5, '+', 0, '869', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (216, 13, 472, 5, '+', 0, '871', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (217, 13, 472, 5, '+', 0, '872', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (218, 13, 473, 5, '+', 0, '919', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (219, 13, 474, 5, '+', 0, '929', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (220, 13, 475, 5, '+', 0, '934', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (221, 13, 475, 5, '+', 0, '935', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (222, 13, 476, 5, '+', 0, '936', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (223, 13, 477, 5, '+', 0, '945', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (224, 13, 478, 5, '+', 0, '938', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (225, 13, 479, 5, '+', 0, '946', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (226, 13, 480, 5, '+', 0, '949', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (227, 13, 481, 5, '+', 0, '950', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (228, 13, 482, 5, '+', 0, '910', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (229, 13, 483, 5, '+', 0, '463', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (230, 13, 483, 5, '-', 0, '464', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (231, 13, 483, 5, '-', 0, '465', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (232, 13, 483, 5, '-', 0, '473', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (233, 13, 483, 5, '-', 0, '476', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (234, 13, 483, 5, '-', 0, '480', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (235, 13, 483, 5, '+', 0, '482', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (236, 13, 484, 5, '+', 0, '911', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (237, 13, 485, 5, '+', 0, '913', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (238, 13, 486, 5, '+', 0, '954', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (239, 13, 487, 5, '+', 0, '959', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (240, 13, 488, 5, '+', 0, '961', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (241, 13, 489, 5, '+', 0, '962', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (242, 13, 490, 5, '+', 0, '963', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (243, 13, 491, 5, '+', 0, '964', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (244, 13, 492, 5, '+', 0, '484', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (245, 13, 492, 5, '-', 0, '486', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (246, 13, 492, 5, '+', 0, '483', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (247, 13, 493, 5, '+', 0, '966', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (248, 13, 494, 5, '+', 0, '492', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (249, 13, 494, 5, '-', 0, '493', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (250, 16, 578, 6, '+', 0, '1069', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (251, 16, 578, 6, '+', 0, '1070', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (252, 16, 579, 6, '+', 0, '1077', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (253, 16, 579, 6, '+', 0, '1078', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (254, 16, 580, 6, '+', 0, '1079', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (255, 16, 581, 6, '+', 0, '1020', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (256, 16, 582, 6, '+', 0, '1021', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (257, 16, 583, 6, '+', 0, '1025', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (258, 16, 584, 6, '+', 0, '1022', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (259, 16, 585, 6, '+', 0, '1024', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (260, 16, 586, 6, '+', 0, '1027', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (261, 16, 586, 6, '+', 0, '1026', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (262, 16, 586, 6, '+', 0, '1028', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (263, 16, 586, 6, '+', 0, '1034', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (264, 16, 587, 6, '+', 0, '1030', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (265, 16, 587, 6, '+', 0, '1032', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (266, 16, 587, 6, '+', 0, '1033', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (267, 16, 588, 6, '+', 0, '1080', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (268, 16, 589, 6, '+', 0, '1090', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (269, 16, 590, 6, '+', 0, '1095', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (270, 16, 590, 6, '+', 0, '1096', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (271, 16, 591, 6, '+', 0, '1097', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (272, 16, 592, 6, '+', 0, '1106', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (273, 16, 593, 6, '+', 0, '1099', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (274, 16, 594, 6, '+', 0, '1107', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (275, 16, 595, 6, '+', 0, '1110', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (276, 16, 596, 6, '+', 0, '1111', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (277, 16, 597, 6, '+', 0, '1071', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (278, 16, 598, 6, '+', 0, '578', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (279, 16, 598, 6, '-', 0, '579', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (280, 16, 598, 6, '-', 0, '580', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (281, 16, 598, 6, '-', 0, '588', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (282, 16, 598, 6, '-', 0, '591', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (283, 16, 598, 6, '-', 0, '595', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (284, 16, 598, 6, '+', 0, '597', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (285, 16, 599, 6, '+', 0, '1072', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (286, 16, 600, 6, '+', 0, '1074', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (287, 16, 601, 6, '+', 0, '1115', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (288, 16, 602, 6, '+', 0, '1120', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (289, 16, 603, 6, '+', 0, '1122', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (290, 16, 604, 6, '+', 0, '1123', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (291, 16, 605, 6, '+', 0, '1124', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (292, 16, 606, 6, '+', 0, '1125', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (293, 16, 607, 6, '+', 0, '599', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (294, 16, 607, 6, '-', 0, '601', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (295, 16, 607, 6, '+', 0, '598', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (296, 16, 608, 6, '+', 0, '1127', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (297, 16, 609, 6, '+', 0, '607', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (298, 16, 609, 6, '-', 0, '608', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (299, 13, 693, 5, '+', 0, '807', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (300, 4, 117, 2, '+', 0, '433', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (301, 4, 117, 2, '+', 0, '434', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (302, 4, 118, 2, '+', 0, '435', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (309, 4, 135, 2, '+', 0, '427', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (310, 4, 116, 2, '+', 0, '425', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (311, 4, 116, 2, '+', 0, '426', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (312, 4, 116, 2, '-', 0, '328', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (313, 4, 116, 2, '+', 0, '323', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (314, 4, 119, 2, '+', 0, '376', NULL);
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (315, 4, 119, 2, '+', 0, '323', NULL);

-- ----------------------------
-- Table structure for fxy_financial_settlement_type
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_settlement_type`;
CREATE TABLE `fxy_financial_settlement_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_sets_id` int NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_settlement_type
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_social_security
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_social_security`;
CREATE TABLE `fxy_financial_social_security`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_social_security
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_social_security_config
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_social_security_config`;
CREATE TABLE `fxy_financial_social_security_config`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `base` double NULL DEFAULT NULL,
  `enterprise` double NULL DEFAULT NULL,
  `enterprise_amount` double NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `personal` double NULL DEFAULT NULL,
  `personal_amount` double NULL DEFAULT NULL,
  `social_security_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_social_security_config
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_subject
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_subject`;
CREATE TABLE `fxy_financial_subject`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('资产','负债','权益','成本','损益','共同') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '资产' COMMENT '科目类型',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '科目编码',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '科目名称',
  `mnemonic_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '助记码',
  `balance_direction` enum('借','贷') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '余额方向',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '状态',
  `parent_id` int NULL DEFAULT NULL COMMENT '上级科目',
  `level` smallint NOT NULL DEFAULT 1 COMMENT '所在级别',
  `system_default` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否为系统默认',
  `account_sets_id` int NULL DEFAULT NULL,
  `balance` double NULL DEFAULT NULL COMMENT '科目余额',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '单位',
  `auxiliary_accounting` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '辅助核算',
  `currency_accounting` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `parent_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fxy_financial_subject_account_sets_id_name_index`(`account_sets_id`, `name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1138 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '科目' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_subject
-- ----------------------------
INSERT INTO `fxy_financial_subject` VALUES (1, '资产', '1001', '库存现金', 'kcxj', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (2, '资产', '1002', '银行存款', 'yhck', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (3, '资产', '1012', '其他货币资金', 'qthbzj', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (4, '资产', '1101', '短期投资', 'dqtz', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (5, '资产', '1101001', '股票', 'dqtz_gp', '借', b'1', 4, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (6, '资产', '1101002', '债券', 'dqtz_zq', '借', b'1', 4, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (7, '资产', '1101003', '基金', 'dqtz_jj', '借', b'1', 4, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (8, '资产', '1121', '应收票据', 'yspj', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (9, '资产', '1122', '应收账款', 'yszk', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (10, '资产', '1123', '预付账款', 'yfzk', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (11, '资产', '1131', '应收股利', 'ysgl', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (12, '资产', '1132', '应收利息', 'yslx', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (13, '资产', '1221', '其他应收款', 'qtysk', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (14, '资产', '1401', '材料采购', 'clcg', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (15, '资产', '1402', '在途物资', 'ztwz', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (16, '资产', '1403', '原材料', 'ycl', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (17, '资产', '1404', '材料成本差异', 'clcbcy', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (18, '资产', '1405', '库存商品', 'kcsp', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (19, '资产', '1407', '商品进销差价', 'spjxcj', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (20, '资产', '1408', '委托加工物资', 'wtjgwz', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (21, '资产', '1411', '周转材料', 'zzcl', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (22, '资产', '1421', '消耗性生物资产', 'xhxswzc', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (23, '资产', '1501', '长期债券投资', 'cqzqtz', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (24, '资产', '1511', '长期股权投资', 'cqgqtz', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (25, '资产', '1601', '固定资产', 'gdzc', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (26, '资产', '1602', '累计折旧', 'ljzj', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (27, '资产', '1604', '在建工程', 'zjgc', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (28, '资产', '1605', '工程物资', 'gcwz', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (29, '资产', '1606', '固定资产清理', 'gdzcql', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (30, '资产', '1621', '生产性生物资产', 'scxswzc', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (31, '资产', '1622', '生产性生物资产累计折旧', 'scxswzcljzj', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (32, '资产', '1701', '无形资产', 'wxzc', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (33, '资产', '1702', '累计摊销', 'ljtx', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (34, '资产', '1801', '长期待摊费用', 'cqdtfy', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (35, '资产', '1901', '待处理财产损溢', 'dclccsy', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (36, '负债', '2001', '短期借款', 'dqjk', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (37, '负债', '2201', '应付票据', 'yfpj', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (38, '负债', '2202', '应付账款', 'yfzk', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (39, '负债', '2203', '预收账款', 'yszk', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (40, '负债', '2211', '应付职工薪酬', 'yfzgxc', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (41, '负债', '2221', '应交税费', 'yjsf', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (42, '负债', '2221001', '应交增值税', 'yjsf_yjzzs', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (43, '负债', '222100101', '进项税额', 'yjsf_yjzzs_jxse', '贷', b'1', 42, 3, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (44, '负债', '222100102', '已交税金', 'yjsf_yjzzs_yjsj', '贷', b'1', 42, 3, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (45, '负债', '222100103', '转出未交增值税', 'yjsf_yjzzs_zcwjzzs', '贷', b'1', 42, 3, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (46, '负债', '222100104', '减免税款', 'yjsf_yjzzs_jmsk', '贷', b'1', 42, 3, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (47, '负债', '222100105', '销项税额', 'yjsf_yjzzs_xxse', '贷', b'1', 42, 3, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (48, '负债', '222100106', '出口退税', 'yjsf_yjzzs_ckts', '贷', b'1', 42, 3, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (49, '负债', '222100107', '进项税额转出', 'yjsf_yjzzs_jxsezc', '贷', b'1', 42, 3, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (50, '负债', '222100108', '出口抵减内销产品应纳税额', 'yjsf_yjzzs_ckdjnxcpynse', '贷', b'1', 42, 3, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (51, '负债', '222100109', '转出多交增值税', 'yjsf_yjzzs_zcdjzzs', '贷', b'1', 42, 3, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (52, '负债', '222100110', '销项税额抵减', 'yjsf_yjzzs_xxsedj', '贷', b'1', 42, 3, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (53, '负债', '2221002', '未交增值税', 'yjsf_wjzzs', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (54, '负债', '2221003', '应交消费税', 'yjsf_yjxfs', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (55, '负债', '2221004', '应交营业税', 'yjsf_yjyys', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (56, '负债', '2221005', '应交资源税', 'yjsf_yjzys', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (57, '负债', '2221006', '应交所得税', 'yjsf_yjsds', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (58, '负债', '2221007', '应交土地增值税', 'yjsf_yjtdzzs', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (59, '负债', '2221008', '应交城市维护建设税', 'yjsf_yjcswhjss', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (60, '负债', '2221009', '应交房产税', 'yjsf_yjfcs', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (61, '负债', '2221010', '应交城镇土地使用税', 'yjsf_yjcztdsys', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (62, '负债', '2221011', '应交车船使用税', 'yjsf_yjccsys', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (63, '负债', '2221012', '应交个人所得税', 'yjsf_yjgrsds', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (64, '负债', '2221013', '教育费附加', 'yjsf_jyffj', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (65, '负债', '2221014', '地方教育费附加', 'yjsf_dfjyffj', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (66, '负债', '2221015', '矿产资源补偿费', 'yjsf_kczybcf', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (67, '负债', '2221016', '排污费', 'yjsf_pwf', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (68, '负债', '2221017', '印花税', 'yjsf_yhs', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (69, '负债', '2221018', '预交增值税', 'yjsf_yjzzs', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (70, '负债', '2221019', '待抵扣进项税额', 'yjsf_ddkjxse', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (71, '负债', '2221020', '待认证进项税额', 'yjsf_drzjxse', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (72, '负债', '2221021', '待转销项税额', 'yjsf_dzxxse', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (73, '负债', '2221022', '增值税留抵税额', 'yjsf_zzsldse', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (74, '负债', '2221023', '简易计税', 'yjsf_jyjs', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (75, '负债', '2221024', '转让金融商品应交增值税', 'yjsf_zrjrspyjzzs', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (76, '负债', '2221025', '代扣代交增值税', 'yjsf_dkdjzzs', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (77, '负债', '2221026', '应交增值税（小规模纳税人专用）', 'yjsf_yjzzs（xgmnsrzy）', '贷', b'1', 41, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (78, '负债', '2231', '应付利息', 'yflx', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (79, '负债', '2232', '应付利润', 'yflr', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (80, '负债', '2241', '其他应付款', 'qtyfk', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (81, '负债', '2401', '递延收益', 'dysy', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (82, '负债', '2501', '长期借款', 'cqjk', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (83, '负债', '2701', '长期应付款', 'cqyfk', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (84, '权益', '3001', '实收资本', 'sszb', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (85, '权益', '3002', '资本公积', 'zbgj', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (86, '权益', '3101', '盈余公积', 'yygj', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (87, '权益', '3101001', '法定盈余公积', 'yygj_fdyygj', '贷', b'1', 86, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (88, '权益', '3101002', '任意盈余公积', 'yygj_ryyygj', '贷', b'1', 86, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (89, '权益', '3101003', '法定公益金', 'yygj_fdgyj', '贷', b'1', 86, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (90, '权益', '3103', '本年利润', 'bnlr', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (91, '权益', '3104', '利润分配', 'lrfp', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (92, '权益', '3104001', '其他转入', 'lrfp_qtzr', '贷', b'1', 91, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (93, '权益', '3104002', '提取法定盈余公积', 'lrfp_tqfdyygj', '贷', b'1', 91, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (94, '权益', '3104003', '提取法定公益金', 'lrfp_tqfdgyj', '贷', b'1', 91, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (95, '权益', '3104004', '提取任意盈余公积', 'lrfp_tqryyygj', '贷', b'1', 91, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (96, '权益', '3104005', '应付利润', 'lrfp_yflr', '贷', b'1', 91, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (97, '权益', '3104006', '未分配利润', 'lrfp_wfplr', '贷', b'1', 91, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (98, '成本', '4001', '生产成本', 'sccb', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (99, '成本', '4101', '制造费用', 'zzfy', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (100, '成本', '4301', '研发支出', 'yfzc', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (101, '成本', '4401', '工程施工', 'gcsg', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (102, '成本', '4403', '机械作业', 'jxzy', '借', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (103, '损益', '5001', '主营业务收入', 'zyywsr', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (104, '损益', '5051', '其他业务收入', 'qtywsr', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (105, '损益', '5111', '投资收益', 'tzsy', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (106, '损益', '5301', '营业外收入', 'yywsr', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (107, '损益', '5301001', '非流动资产处置净收益', 'yywsr_fldzcczjsy', '贷', b'1', 106, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (108, '损益', '5301002', '政府补助', 'yywsr_zfbz', '贷', b'1', 106, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (109, '损益', '5301003', '捐赠收益', 'yywsr_jzsy', '贷', b'1', 106, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (110, '损益', '5301004', '盘盈收益', 'yywsr_pysy', '贷', b'1', 106, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (111, '损益', '5401', '主营业务成本', 'zyywcb', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (112, '损益', '5402', '其他业务成本', 'qtywcb', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (113, '损益', '5403', '税金及附加', 'sjjfj', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (114, '损益', '5601', '销售费用', 'xsfy', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (115, '损益', '5601001', '销售人员职工薪酬', 'xsfy_xsryzgxc', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (116, '损益', '5601002', '业务招待费', 'xsfy_ywzdf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (117, '损益', '5601003', '修理费', 'xsfy_xlf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (118, '损益', '5601004', '办公费', 'xsfy_bgf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (119, '损益', '5601005', '水电费', 'xsfy_sdf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (120, '损益', '5601006', '差旅费', 'xsfy_clf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (121, '损益', '5601007', '折旧费', 'xsfy_zjf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (122, '损益', '5601008', '摊销费', 'xsfy_txf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (123, '损益', '5601009', '展览费', 'xsfy_zlf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (124, '损益', '5601010', '商品维修费', 'xsfy_spwxf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (125, '损益', '5601011', '运输费', 'xsfy_ysf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (126, '损益', '5601012', '装卸费', 'xsfy_zxf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (127, '损益', '5601013', '包装费', 'xsfy_bzf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (128, '损益', '5601014', '保险费', 'xsfy_bxf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (129, '损益', '5601015', '广告费', 'xsfy_ggf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (130, '损益', '5601016', '业务宣传费', 'xsfy_ywxcf', '贷', b'1', 114, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (131, '损益', '5602', '管理费用', 'glfy', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (132, '损益', '5602001', '管理人员职工薪酬', 'glfy_glryzgxc', '贷', b'1', 131, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (133, '损益', '5602002', '业务招待费', 'glfy_ywzdf', '贷', b'1', 131, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (134, '损益', '5602003', '修理费', 'glfy_xlf', '贷', b'1', 131, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (135, '损益', '5602004', '办公费', 'glfy_bgf', '贷', b'1', 131, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (136, '损益', '5602005', '水电费', 'glfy_sdf', '贷', b'1', 131, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (137, '损益', '5602006', '差旅费', 'glfy_clf', '贷', b'1', 131, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (138, '损益', '5602007', '折旧费', 'glfy_zjf', '贷', b'1', 131, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (139, '损益', '5602008', '摊销费', 'glfy_txf', '贷', b'1', 131, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (140, '损益', '5602009', '开办费', 'glfy_kbf', '贷', b'1', 131, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (141, '损益', '5602010', '研究费用', 'glfy_yjfy', '贷', b'1', 131, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (142, '损益', '5602011', '咨询费', 'glfy_zxf', '贷', b'1', 131, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (143, '损益', '5602012', '长期待摊费用摊销', 'glfy_cqdtfytx', '贷', b'1', 131, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (144, '损益', '5603', '财务费用', 'cwfy', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (145, '损益', '5603001', '利息费用', 'cwfy_lxfy', '贷', b'1', 144, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (146, '损益', '5603002', '手续费', 'cwfy_sxf', '贷', b'1', 144, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (147, '损益', '5603003', '汇兑损益', 'cwfy_hdsy', '贷', b'1', 144, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (148, '损益', '5603004', '现金折扣', 'cwfy_xjzk', '贷', b'1', 144, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (149, '损益', '5711', '营业外支出', 'yywzc', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (150, '损益', '5711001', '非流动资产处置净损失', 'yywzc_fldzcczjss', '贷', b'1', 149, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (151, '损益', '5711002', '赞助支出', 'yywzc_zzzc', '贷', b'1', 149, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (152, '损益', '5711003', '捐赠支出', 'yywzc_jzzc', '贷', b'1', 149, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (153, '损益', '5711004', '盘亏损失', 'yywzc_pkss', '贷', b'1', 149, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (154, '损益', '5711005', '坏账损失', 'yywzc_hzss', '贷', b'1', 149, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (155, '损益', '5711006', '存货毁损报废损失', 'yywzc_chhsbfss', '贷', b'1', 149, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (156, '损益', '5711007', '无法收回的长期债券投资损失', 'yywzc_wfshdcqzqtzss', '贷', b'1', 149, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (157, '损益', '5711008', '无法收回的长期股权投资损失', 'yywzc_wfshdcqgqtzss', '贷', b'1', 149, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (158, '损益', '5711009', '自然灾害等不可抗力因素造成的损失', 'yywzc_zrzhdbkklyszcdss', '贷', b'1', 149, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (159, '损益', '5711010', '税收滞纳金', 'yywzc_ssznj', '贷', b'1', 149, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (160, '损益', '5711011', '罚款支出', 'yywzc_fkzc', '贷', b'1', 149, 2, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (161, '损益', '5801', '所得税费用', 'sdsfy', '贷', b'1', 0, 1, b'1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (162, '资产', '1001', '库存现金', 'kcxj', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (163, '资产', '1002', '银行存款', 'yhck', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (164, '资产', '1012', '其他货币资金', 'qthbzj', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (165, '资产', '1101', '短期投资', 'dqtz', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (166, '资产', '110101', '股票', 'dqtz_gp', '借', b'1', 165, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (167, '资产', '110102', '债券', 'dqtz_zq', '借', b'1', 165, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (168, '资产', '110103', '基金', 'dqtz_jj', '借', b'1', 165, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (169, '资产', '1121', '应收票据', 'yspj', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (170, '资产', '1122', '应收账款', 'yszk', '借', b'1', 0, 1, b'1', 1, NULL, '', '[{\"id\":8,\"name\":\"客户\"},{\"id\":9,\"name\":\"供应商\"},{\"id\":10,\"name\":\"职员\"},{\"id\":11,\"name\":\"部门\"}]', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (171, '资产', '1123', '预付账款', 'yfzk', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (172, '资产', '1131', '应收股利', 'ysgl', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (173, '资产', '1132', '应收利息', 'yslx', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (174, '资产', '1221', '其他应收款', 'qtysk', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (175, '资产', '1401', '材料采购', 'clcg', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (176, '资产', '1402', '在途物资', 'ztwz', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (177, '资产', '1403', '原材料', 'ycl', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (178, '资产', '1404', '材料成本差异', 'clcbcy', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (179, '资产', '1405', '库存商品', 'kcsp', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (180, '资产', '1407', '商品进销差价', 'spjxcj', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (181, '资产', '1408', '委托加工物资', 'wtjgwz', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (182, '资产', '1411', '周转材料', 'zzcl', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (183, '资产', '1421', '消耗性生物资产', 'xhxswzc', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (184, '资产', '1501', '长期债券投资', 'cqzqtz', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (185, '资产', '1511', '长期股权投资', 'cqgqtz', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (186, '资产', '1601', '固定资产', 'gdzc', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (187, '资产', '1602', '累计折旧', 'ljzj', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (188, '资产', '1604', '在建工程', 'zjgc', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (189, '资产', '1605', '工程物资', 'gcwz', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (190, '资产', '1606', '固定资产清理', 'gdzcql', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (191, '资产', '1621', '生产性生物资产', 'scxswzc', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (192, '资产', '1622', '生产性生物资产累计折旧', 'scxswzcljzj', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (193, '资产', '1701', '无形资产', 'wxzc', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (194, '资产', '1702', '累计摊销', 'ljtx', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (195, '资产', '1801', '长期待摊费用', 'cqdtfy', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (196, '资产', '1901', '待处理财产损溢', 'dclccsy', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (197, '负债', '2001', '短期借款', 'dqjk', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (198, '负债', '2201', '应付票据', 'yfpj', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (199, '负债', '2202', '应付账款', 'yfzk', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (200, '负债', '2203', '预收账款', 'yszk', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (201, '负债', '2211', '应付职工薪酬', 'yfzgxc', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (202, '负债', '2221', '应交税费', 'yjsf', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (203, '负债', '222101', '应交增值税', 'yjsf_yjzzs', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (204, '负债', '22210101', '进项税额', 'yjsf_yjzzs_jxse', '贷', b'1', 203, 3, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (205, '负债', '22210102', '已交税金', 'yjsf_yjzzs_yjsj', '贷', b'1', 203, 3, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (206, '负债', '22210103', '转出未交增值税', 'yjsf_yjzzs_zcwjzzs', '贷', b'1', 203, 3, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (207, '负债', '22210104', '减免税款', 'yjsf_yjzzs_jmsk', '贷', b'1', 203, 3, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (208, '负债', '22210105', '销项税额', 'yjsf_yjzzs_xxse', '贷', b'1', 203, 3, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (209, '负债', '22210106', '出口退税', 'yjsf_yjzzs_ckts', '贷', b'1', 203, 3, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (210, '负债', '22210107', '进项税额转出', 'yjsf_yjzzs_jxsezc', '贷', b'1', 203, 3, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (211, '负债', '22210108', '出口抵减内销产品应纳税额', 'yjsf_yjzzs_ckdjnxcpynse', '贷', b'1', 203, 3, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (212, '负债', '22210109', '转出多交增值税', 'yjsf_yjzzs_zcdjzzs', '贷', b'1', 203, 3, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (213, '负债', '22210110', '销项税额抵减', 'yjsf_yjzzs_xxsedj', '贷', b'1', 203, 3, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (214, '负债', '222102', '未交增值税', 'yjsf_wjzzs', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (215, '负债', '222103', '应交消费税', 'yjsf_yjxfs', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (216, '负债', '222104', '应交营业税', 'yjsf_yjyys', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (217, '负债', '222105', '应交资源税', 'yjsf_yjzys', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (218, '负债', '222106', '应交所得税', 'yjsf_yjsds', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (219, '负债', '222107', '应交土地增值税', 'yjsf_yjtdzzs', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (220, '负债', '222108', '应交城市维护建设税', 'yjsf_yjcswhjss', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (221, '负债', '222109', '应交房产税', 'yjsf_yjfcs', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (222, '负债', '222110', '应交城镇土地使用税', 'yjsf_yjcztdsys', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (223, '负债', '222111', '应交车船使用税', 'yjsf_yjccsys', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (224, '负债', '222112', '应交个人所得税', 'yjsf_yjgrsds', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (225, '负债', '222113', '教育费附加', 'yjsf_jyffj', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (226, '负债', '222114', '地方教育费附加', 'yjsf_dfjyffj', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (227, '负债', '222115', '矿产资源补偿费', 'yjsf_kczybcf', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (228, '负债', '222116', '排污费', 'yjsf_pwf', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (229, '负债', '222117', '印花税', 'yjsf_yhs', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (230, '负债', '222118', '预交增值税', 'yjsf_yjzzs', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (231, '负债', '222119', '待抵扣进项税额', 'yjsf_ddkjxse', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (232, '负债', '222120', '待认证进项税额', 'yjsf_drzjxse', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (233, '负债', '222121', '待转销项税额', 'yjsf_dzxxse', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (234, '负债', '222122', '增值税留抵税额', 'yjsf_zzsldse', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (235, '负债', '222123', '简易计税', 'yjsf_jyjs', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (236, '负债', '222124', '转让金融商品应交增值税', 'yjsf_zrjrspyjzzs', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (237, '负债', '222125', '代扣代交增值税', 'yjsf_dkdjzzs', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (238, '负债', '222126', '应交增值税（小规模纳税人专用）', 'yjsf_yjzzs（xgmnsrzy）', '贷', b'1', 202, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (239, '负债', '2231', '应付利息', 'yflx', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (240, '负债', '2232', '应付利润', 'yflr', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (241, '负债', '2241', '其他应付款', 'qtyfk', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (242, '负债', '2401', '递延收益', 'dysy', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (243, '负债', '2501', '长期借款', 'cqjk', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (244, '负债', '2701', '长期应付款', 'cqyfk', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (245, '权益', '3001', '实收资本', 'sszb', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (246, '权益', '3002', '资本公积', 'zbgj', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (247, '权益', '3101', '盈余公积', 'yygj', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (248, '权益', '310101', '法定盈余公积', 'yygj_fdyygj', '贷', b'1', 247, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (249, '权益', '310102', '任意盈余公积', 'yygj_ryyygj', '贷', b'1', 247, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (250, '权益', '310103', '法定公益金', 'yygj_fdgyj', '贷', b'1', 247, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (251, '权益', '3103', '本年利润', 'bnlr', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (252, '权益', '3104', '利润分配', 'lrfp', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (253, '权益', '310401', '其他转入', 'lrfp_qtzr', '贷', b'1', 252, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (254, '权益', '310402', '提取法定盈余公积', 'lrfp_tqfdyygj', '贷', b'1', 252, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (255, '权益', '310403', '提取法定公益金', 'lrfp_tqfdgyj', '贷', b'1', 252, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (256, '权益', '310404', '提取任意盈余公积', 'lrfp_tqryyygj', '贷', b'1', 252, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (257, '权益', '310405', '应付利润', 'lrfp_yflr', '贷', b'1', 252, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (258, '权益', '310406', '未分配利润', 'lrfp_wfplr', '贷', b'1', 252, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (259, '成本', '4001', '生产成本', 'sccb', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (260, '成本', '4101', '制造费用', 'zzfy', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (261, '成本', '4301', '研发支出', 'yfzc', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (262, '成本', '4401', '工程施工', 'gcsg', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (263, '成本', '4403', '机械作业', 'jxzy', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (264, '损益', '5001', '主营业务收入', 'zyywsr', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (265, '损益', '5051', '其他业务收入', 'qtywsr', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (266, '损益', '5111', '投资收益', 'tzsy', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (267, '损益', '5301', '营业外收入', 'yywsr', '贷', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (268, '损益', '530101', '非流动资产处置净收益', 'yywsr_fldzcczjsy', '贷', b'1', 267, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (269, '损益', '530102', '政府补助', 'yywsr_zfbz', '贷', b'1', 267, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (270, '损益', '530103', '捐赠收益', 'yywsr_jzsy', '贷', b'1', 267, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (271, '损益', '530104', '盘盈收益', 'yywsr_pysy', '贷', b'1', 267, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (272, '损益', '5401', '主营业务成本', 'zyywcb', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (273, '损益', '5402', '其他业务成本', 'qtywcb', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (274, '损益', '5403', '税金及附加', 'sjjfj', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (275, '损益', '5601', '销售费用', 'xsfy', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (276, '损益', '560101', '销售人员职工薪酬', 'xsfy_xsryzgxc', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (277, '损益', '560102', '业务招待费', 'xsfy_ywzdf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (278, '损益', '560103', '修理费', 'xsfy_xlf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (279, '损益', '560104', '办公费', 'xsfy_bgf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (280, '损益', '560105', '水电费', 'xsfy_sdf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (281, '损益', '560106', '差旅费', 'xsfy_clf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (282, '损益', '560107', '折旧费', 'xsfy_zjf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (283, '损益', '560108', '摊销费', 'xsfy_txf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (284, '损益', '560109', '展览费', 'xsfy_zlf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (285, '损益', '560110', '商品维修费', 'xsfy_spwxf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (286, '损益', '560111', '运输费', 'xsfy_ysf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (287, '损益', '560112', '装卸费', 'xsfy_zxf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (288, '损益', '560113', '包装费', 'xsfy_bzf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (289, '损益', '560114', '保险费', 'xsfy_bxf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (290, '损益', '560115', '广告费', 'xsfy_ggf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (291, '损益', '560116', '业务宣传费', 'xsfy_ywxcf', '借', b'1', 275, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (292, '损益', '5602', '管理费用', 'glfy', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (293, '损益', '560201', '管理人员职工薪酬', 'glfy_glryzgxc', '借', b'1', 292, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (294, '损益', '560202', '业务招待费', 'glfy_ywzdf', '借', b'1', 292, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (295, '损益', '560203', '修理费', 'glfy_xlf', '借', b'1', 292, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (296, '损益', '560204', '办公费', 'glfy_bgf', '借', b'1', 292, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (297, '损益', '560205', '水电费', 'glfy_sdf', '借', b'1', 292, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (298, '损益', '560206', '差旅费', 'glfy_clf', '借', b'1', 292, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (299, '损益', '560207', '折旧费', 'glfy_zjf', '借', b'1', 292, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (300, '损益', '560208', '摊销费', 'glfy_txf', '借', b'1', 292, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (301, '损益', '560209', '开办费', 'glfy_kbf', '借', b'1', 292, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (302, '损益', '560210', '研究费用', 'glfy_yjfy', '借', b'1', 292, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (303, '损益', '560211', '咨询费', 'glfy_zxf', '借', b'1', 292, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (304, '损益', '560212', '长期待摊费用摊销', 'glfy_cqdtfytx', '借', b'1', 292, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (305, '损益', '5603', '财务费用', 'cwfy', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (306, '损益', '560301', '利息费用', 'cwfy_lxfy', '借', b'1', 305, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (307, '损益', '560302', '手续费', 'cwfy_sxf', '借', b'1', 305, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (308, '损益', '560303', '汇兑损益', 'cwfy_hdsy', '借', b'1', 305, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (309, '损益', '560304', '现金折扣', 'cwfy_xjzk', '借', b'1', 305, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (310, '损益', '5711', '营业外支出', 'yywzc', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (311, '损益', '571101', '非流动资产处置净损失', 'yywzc_fldzcczjss', '借', b'1', 310, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (312, '损益', '571102', '赞助支出', 'yywzc_zzzc', '借', b'1', 310, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (313, '损益', '571103', '捐赠支出', 'yywzc_jzzc', '借', b'1', 310, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (314, '损益', '571104', '盘亏损失', 'yywzc_pkss', '借', b'1', 310, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (315, '损益', '571105', '坏账损失', 'yywzc_hzss', '借', b'1', 310, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (316, '损益', '571106', '存货毁损报废损失', 'yywzc_chhsbfss', '借', b'1', 310, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (317, '损益', '571107', '无法收回的长期债券投资损失', 'yywzc_wfshdcqzqtzss', '借', b'1', 310, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (318, '损益', '571108', '无法收回的长期股权投资损失', 'yywzc_wfshdcqgqtzss', '借', b'1', 310, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (319, '损益', '571109', '自然灾害等不可抗力因素造成的损失', 'yywzc_zrzhdbkklyszcdss', '借', b'1', 310, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (320, '损益', '571110', '税收滞纳金', 'yywzc_ssznj', '借', b'1', 310, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (321, '损益', '571111', '罚款支出', 'yywzc_fkzc', '借', b'1', 310, 2, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (322, '损益', '5801', '所得税费用', 'sdsfy', '借', b'1', 0, 1, b'1', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (323, '资产', '1001', '库存现金', 'kcxj', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (324, '资产', '1002', '银行存款', 'yhck', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (325, '资产', '1012', '其他货币资金', 'qthbzj', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (326, '资产', '1101', '短期投资', 'dqtz', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (327, '资产', '1101001', '股票', 'dqtz_gp', '借', b'1', 326, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (328, '资产', '1101002', '债券', 'dqtz_zq', '借', b'1', 326, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (329, '资产', '1101003', '基金', 'dqtz_jj', '借', b'1', 326, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (330, '资产', '1121', '应收票据', 'yspj', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (331, '资产', '1122', '应收账款', 'yszk', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (332, '资产', '1123', '预付账款', 'yfzk', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (333, '资产', '1131', '应收股利', 'ysgl', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (334, '资产', '1132', '应收利息', 'yslx', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (335, '资产', '1221', '其他应收款', 'qtysk', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (336, '资产', '1401', '材料采购', 'clcg', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (337, '资产', '1402', '在途物资', 'ztwz', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (338, '资产', '1403', '原材料', 'ycl', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (339, '资产', '1404', '材料成本差异', 'clcbcy', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (340, '资产', '1405', '库存商品', 'kcsp', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (341, '资产', '1407', '商品进销差价', 'spjxcj', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (342, '资产', '1408', '委托加工物资', 'wtjgwz', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (343, '资产', '1411', '周转材料', 'zzcl', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (344, '资产', '1421', '消耗性生物资产', 'xhxswzc', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (345, '资产', '1501', '长期债券投资', 'cqzqtz', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (346, '资产', '1511', '长期股权投资', 'cqgqtz', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (347, '资产', '1601', '固定资产', 'gdzc', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (348, '资产', '1602', '累计折旧', 'ljzj', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (349, '资产', '1604', '在建工程', 'zjgc', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (350, '资产', '1605', '工程物资', 'gcwz', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (351, '资产', '1606', '固定资产清理', 'gdzcql', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (352, '资产', '1621', '生产性生物资产', 'scxswzc', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (353, '资产', '1622', '生产性生物资产累计折旧', 'scxswzcljzj', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (354, '资产', '1701', '无形资产', 'wxzc', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (355, '资产', '1702', '累计摊销', 'ljtx', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (356, '资产', '1801', '长期待摊费用', 'cqdtfy', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (357, '资产', '1901', '待处理财产损溢', 'dclccsy', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (358, '负债', '2001', '短期借款', 'dqjk', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (359, '负债', '2201', '应付票据', 'yfpj', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (360, '负债', '2202', '应付账款', 'yfzk', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (361, '负债', '2203', '预收账款', 'yszk', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (362, '负债', '2211', '应付职工薪酬', 'yfzgxc', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (363, '负债', '2221', '应交税费', 'yjsf', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (364, '负债', '2221001', '应交增值税', 'yjsf_yjzzs', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (365, '负债', '222100101', '进项税额', 'yjsf_yjzzs_jxse', '贷', b'1', 364, 3, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (366, '负债', '222100102', '已交税金', 'yjsf_yjzzs_yjsj', '贷', b'1', 364, 3, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (367, '负债', '222100103', '转出未交增值税', 'yjsf_yjzzs_zcwjzzs', '贷', b'1', 364, 3, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (368, '负债', '222100104', '减免税款', 'yjsf_yjzzs_jmsk', '贷', b'1', 364, 3, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (369, '负债', '222100105', '销项税额', 'yjsf_yjzzs_xxse', '贷', b'1', 364, 3, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (370, '负债', '222100106', '出口退税', 'yjsf_yjzzs_ckts', '贷', b'1', 364, 3, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (371, '负债', '222100107', '进项税额转出', 'yjsf_yjzzs_jxsezc', '贷', b'1', 364, 3, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (372, '负债', '222100108', '出口抵减内销产品应纳税额', 'yjsf_yjzzs_ckdjnxcpynse', '贷', b'1', 364, 3, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (373, '负债', '222100109', '转出多交增值税', 'yjsf_yjzzs_zcdjzzs', '贷', b'1', 364, 3, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (374, '负债', '222100110', '销项税额抵减', 'yjsf_yjzzs_xxsedj', '贷', b'1', 364, 3, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (375, '负债', '2221002', '未交增值税', 'yjsf_wjzzs', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (376, '负债', '2221003', '应交消费税', 'yjsf_yjxfs', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (377, '负债', '2221004', '应交营业税', 'yjsf_yjyys', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (378, '负债', '2221005', '应交资源税', 'yjsf_yjzys', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (379, '负债', '2221006', '应交所得税', 'yjsf_yjsds', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (380, '负债', '2221007', '应交土地增值税', 'yjsf_yjtdzzs', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (381, '负债', '2221008', '应交城市维护建设税', 'yjsf_yjcswhjss', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (382, '负债', '2221009', '应交房产税', 'yjsf_yjfcs', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (383, '负债', '2221010', '应交城镇土地使用税', 'yjsf_yjcztdsys', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (384, '负债', '2221011', '应交车船使用税', 'yjsf_yjccsys', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (385, '负债', '2221012', '应交个人所得税', 'yjsf_yjgrsds', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (386, '负债', '2221013', '教育费附加', 'yjsf_jyffj', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (387, '负债', '2221014', '地方教育费附加', 'yjsf_dfjyffj', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (388, '负债', '2221015', '矿产资源补偿费', 'yjsf_kczybcf', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (389, '负债', '2221016', '排污费', 'yjsf_pwf', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (390, '负债', '2221017', '印花税', 'yjsf_yhs', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (391, '负债', '2221018', '预交增值税', 'yjsf_yjzzs', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (392, '负债', '2221019', '待抵扣进项税额', 'yjsf_ddkjxse', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (393, '负债', '2221020', '待认证进项税额', 'yjsf_drzjxse', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (394, '负债', '2221021', '待转销项税额', 'yjsf_dzxxse', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (395, '负债', '2221022', '增值税留抵税额', 'yjsf_zzsldse', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (396, '负债', '2221023', '简易计税', 'yjsf_jyjs', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (397, '负债', '2221024', '转让金融商品应交增值税', 'yjsf_zrjrspyjzzs', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (398, '负债', '2221025', '代扣代交增值税', 'yjsf_dkdjzzs', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (399, '负债', '2221026', '应交增值税（小规模纳税人专用）', 'yjsf_yjzzs（xgmnsrzy）', '贷', b'1', 363, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (400, '负债', '2231', '应付利息', 'yflx', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (401, '负债', '2232', '应付利润', 'yflr', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (402, '负债', '2241', '其他应付款', 'qtyfk', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (403, '负债', '2401', '递延收益', 'dysy', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (404, '负债', '2501', '长期借款', 'cqjk', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (405, '负债', '2701', '长期应付款', 'cqyfk', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (406, '权益', '3001', '实收资本', 'sszb', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (407, '权益', '3002', '资本公积', 'zbgj', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (408, '权益', '3101', '盈余公积', 'yygj', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (409, '权益', '3101001', '法定盈余公积', 'yygj_fdyygj', '贷', b'1', 408, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (410, '权益', '3101002', '任意盈余公积', 'yygj_ryyygj', '贷', b'1', 408, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (411, '权益', '3101003', '法定公益金', 'yygj_fdgyj', '贷', b'1', 408, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (412, '权益', '3103', '本年利润', 'bnlr', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (413, '权益', '3104', '利润分配', 'lrfp', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (414, '权益', '3104001', '其他转入', 'lrfp_qtzr', '贷', b'1', 413, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (415, '权益', '3104002', '提取法定盈余公积', 'lrfp_tqfdyygj', '贷', b'1', 413, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (416, '权益', '3104003', '提取法定公益金', 'lrfp_tqfdgyj', '贷', b'1', 413, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (417, '权益', '3104004', '提取任意盈余公积', 'lrfp_tqryyygj', '贷', b'1', 413, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (418, '权益', '3104005', '应付利润', 'lrfp_yflr', '贷', b'1', 413, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (419, '权益', '3104006', '未分配利润', 'lrfp_wfplr', '贷', b'1', 413, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (420, '成本', '4001', '生产成本', 'sccb', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (421, '成本', '4101', '制造费用', 'zzfy', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (422, '成本', '4301', '研发支出', 'yfzc', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (423, '成本', '4401', '工程施工', 'gcsg', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (424, '成本', '4403', '机械作业', 'jxzy', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (425, '损益', '5001', '主营业务收入', 'zyywsr', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (426, '损益', '5051', '其他业务收入', 'qtywsr', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (427, '损益', '5111', '投资收益', 'tzsy', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (428, '损益', '5301', '营业外收入', 'yywsr', '贷', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (429, '损益', '5301001', '非流动资产处置净收益', 'yywsr_fldzcczjsy', '贷', b'1', 428, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (430, '损益', '5301002', '政府补助', 'yywsr_zfbz', '贷', b'1', 428, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (431, '损益', '5301003', '捐赠收益', 'yywsr_jzsy', '贷', b'1', 428, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (432, '损益', '5301004', '盘盈收益', 'yywsr_pysy', '贷', b'1', 428, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (433, '损益', '5401', '主营业务成本', 'zyywcb', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (434, '损益', '5402', '其他业务成本', 'qtywcb', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (435, '损益', '5403', '税金及附加', 'sjjfj', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (436, '损益', '5601', '销售费用', 'xsfy', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (437, '损益', '5601001', '销售人员职工薪酬', 'xsfy_xsryzgxc', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (438, '损益', '5601002', '业务招待费', 'xsfy_ywzdf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (439, '损益', '5601003', '修理费', 'xsfy_xlf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (440, '损益', '5601004', '办公费', 'xsfy_bgf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (441, '损益', '5601005', '水电费', 'xsfy_sdf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (442, '损益', '5601006', '差旅费', 'xsfy_clf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (443, '损益', '5601007', '折旧费', 'xsfy_zjf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (444, '损益', '5601008', '摊销费', 'xsfy_txf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (445, '损益', '5601009', '展览费', 'xsfy_zlf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (446, '损益', '5601010', '商品维修费', 'xsfy_spwxf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (447, '损益', '5601011', '运输费', 'xsfy_ysf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (448, '损益', '5601012', '装卸费', 'xsfy_zxf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (449, '损益', '5601013', '包装费', 'xsfy_bzf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (450, '损益', '5601014', '保险费', 'xsfy_bxf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (451, '损益', '5601015', '广告费', 'xsfy_ggf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (452, '损益', '5601016', '业务宣传费', 'xsfy_ywxcf', '借', b'1', 436, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (453, '损益', '5602', '管理费用', 'glfy', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (454, '损益', '5602001', '管理人员职工薪酬', 'glfy_glryzgxc', '借', b'1', 453, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (455, '损益', '5602002', '业务招待费', 'glfy_ywzdf', '借', b'1', 453, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (456, '损益', '5602003', '修理费', 'glfy_xlf', '借', b'1', 453, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (457, '损益', '5602004', '办公费', 'glfy_bgf', '借', b'1', 453, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (458, '损益', '5602005', '水电费', 'glfy_sdf', '借', b'1', 453, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (459, '损益', '5602006', '差旅费', 'glfy_clf', '借', b'1', 453, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (460, '损益', '5602007', '折旧费', 'glfy_zjf', '借', b'1', 453, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (461, '损益', '5602008', '摊销费', 'glfy_txf', '借', b'1', 453, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (462, '损益', '5602009', '开办费', 'glfy_kbf', '借', b'1', 453, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (463, '损益', '5602010', '研究费用', 'glfy_yjfy', '借', b'1', 453, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (464, '损益', '5602011', '咨询费', 'glfy_zxf', '借', b'1', 453, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (465, '损益', '5602012', '长期待摊费用摊销', 'glfy_cqdtfytx', '借', b'1', 453, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (466, '损益', '5603', '财务费用', 'cwfy', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (467, '损益', '5603001', '利息费用', 'cwfy_lxfy', '借', b'1', 466, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (468, '损益', '5603002', '手续费', 'cwfy_sxf', '借', b'1', 466, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (469, '损益', '5603003', '汇兑损益', 'cwfy_hdsy', '借', b'1', 466, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (470, '损益', '5603004', '现金折扣', 'cwfy_xjzk', '借', b'1', 466, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (471, '损益', '5711', '营业外支出', 'yywzc', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (472, '损益', '5711001', '非流动资产处置净损失', 'yywzc_fldzcczjss', '借', b'1', 471, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (473, '损益', '5711002', '赞助支出', 'yywzc_zzzc', '借', b'1', 471, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (474, '损益', '5711003', '捐赠支出', 'yywzc_jzzc', '借', b'1', 471, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (475, '损益', '5711004', '盘亏损失', 'yywzc_pkss', '借', b'1', 471, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (476, '损益', '5711005', '坏账损失', 'yywzc_hzss', '借', b'1', 471, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (477, '损益', '5711006', '存货毁损报废损失', 'yywzc_chhsbfss', '借', b'1', 471, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (478, '损益', '5711007', '无法收回的长期债券投资损失', 'yywzc_wfshdcqzqtzss', '借', b'1', 471, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (479, '损益', '5711008', '无法收回的长期股权投资损失', 'yywzc_wfshdcqgqtzss', '借', b'1', 471, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (480, '损益', '5711009', '自然灾害等不可抗力因素造成的损失', 'yywzc_zrzhdbkklyszcdss', '借', b'1', 471, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (481, '损益', '5711010', '税收滞纳金', 'yywzc_ssznj', '借', b'1', 471, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (482, '损益', '5711011', '罚款支出', 'yywzc_fkzc', '借', b'1', 471, 2, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (483, '损益', '5801', '所得税费用', 'sdsfy', '借', b'1', 0, 1, b'1', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (484, '资产', '1001', '库存现金', 'kcxj', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (485, '资产', '1002', '银行存款', 'yhck', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (486, '资产', '1012', '其他货币资金', 'qthbzj', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (487, '资产', '1101', '短期投资', 'dqtz', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (488, '资产', '110101', '股票', 'dqtz_gp', '借', b'1', 487, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (489, '资产', '110102', '债券', 'dqtz_zq', '借', b'1', 487, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (490, '资产', '110103', '基金', 'dqtz_jj', '借', b'1', 487, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (491, '资产', '1121', '应收票据', 'yspj', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (492, '资产', '1122', '应收账款', 'yszk', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (493, '资产', '1123', '预付账款', 'yfzk', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (494, '资产', '1131', '应收股利', 'ysgl', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (495, '资产', '1132', '应收利息', 'yslx', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (496, '资产', '1221', '其他应收款', 'qtysk', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (497, '资产', '1401', '材料采购', 'clcg', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (498, '资产', '1402', '在途物资', 'ztwz', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (499, '资产', '1403', '原材料', 'ycl', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (500, '资产', '1404', '材料成本差异', 'clcbcy', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (501, '资产', '1405', '库存商品', 'kcsp', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (502, '资产', '1407', '商品进销差价', 'spjxcj', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (503, '资产', '1408', '委托加工物资', 'wtjgwz', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (504, '资产', '1411', '周转材料', 'zzcl', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (505, '资产', '1421', '消耗性生物资产', 'xhxswzc', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (506, '资产', '1501', '长期债券投资', 'cqzqtz', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (507, '资产', '1511', '长期股权投资', 'cqgqtz', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (508, '资产', '1601', '固定资产', 'gdzc', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (509, '资产', '1602', '累计折旧', 'ljzj', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (510, '资产', '1604', '在建工程', 'zjgc', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (511, '资产', '1605', '工程物资', 'gcwz', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (512, '资产', '1606', '固定资产清理', 'gdzcql', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (513, '资产', '1621', '生产性生物资产', 'scxswzc', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (514, '资产', '1622', '生产性生物资产累计折旧', 'scxswzcljzj', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (515, '资产', '1701', '无形资产', 'wxzc', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (516, '资产', '1702', '累计摊销', 'ljtx', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (517, '资产', '1801', '长期待摊费用', 'cqdtfy', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (518, '资产', '1901', '待处理财产损溢', 'dclccsy', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (519, '负债', '2001', '短期借款', 'dqjk', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (520, '负债', '2201', '应付票据', 'yfpj', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (521, '负债', '2202', '应付账款', 'yfzk', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (522, '负债', '2203', '预收账款', 'yszk', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (523, '负债', '2211', '应付职工薪酬', 'yfzgxc', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (524, '负债', '2221', '应交税费', 'yjsf', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (525, '负债', '222101', '应交增值税', 'yjsf_yjzzs', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (526, '负债', '22210101', '进项税额', 'yjsf_yjzzs_jxse', '贷', b'1', 525, 3, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (527, '负债', '22210102', '已交税金', 'yjsf_yjzzs_yjsj', '贷', b'1', 525, 3, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (528, '负债', '22210103', '转出未交增值税', 'yjsf_yjzzs_zcwjzzs', '贷', b'1', 525, 3, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (529, '负债', '22210104', '减免税款', 'yjsf_yjzzs_jmsk', '贷', b'1', 525, 3, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (530, '负债', '22210105', '销项税额', 'yjsf_yjzzs_xxse', '贷', b'1', 525, 3, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (531, '负债', '22210106', '出口退税', 'yjsf_yjzzs_ckts', '贷', b'1', 525, 3, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (532, '负债', '22210107', '进项税额转出', 'yjsf_yjzzs_jxsezc', '贷', b'1', 525, 3, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (533, '负债', '22210108', '出口抵减内销产品应纳税额', 'yjsf_yjzzs_ckdjnxcpynse', '贷', b'1', 525, 3, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (534, '负债', '22210109', '转出多交增值税', 'yjsf_yjzzs_zcdjzzs', '贷', b'1', 525, 3, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (535, '负债', '22210110', '销项税额抵减', 'yjsf_yjzzs_xxsedj', '贷', b'1', 525, 3, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (536, '负债', '222102', '未交增值税', 'yjsf_wjzzs', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (537, '负债', '222103', '应交消费税', 'yjsf_yjxfs', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (538, '负债', '222104', '应交营业税', 'yjsf_yjyys', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (539, '负债', '222105', '应交资源税', 'yjsf_yjzys', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (540, '负债', '222106', '应交所得税', 'yjsf_yjsds', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (541, '负债', '222107', '应交土地增值税', 'yjsf_yjtdzzs', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (542, '负债', '222108', '应交城市维护建设税', 'yjsf_yjcswhjss', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (543, '负债', '222109', '应交房产税', 'yjsf_yjfcs', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (544, '负债', '222110', '应交城镇土地使用税', 'yjsf_yjcztdsys', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (545, '负债', '222111', '应交车船使用税', 'yjsf_yjccsys', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (546, '负债', '222112', '应交个人所得税', 'yjsf_yjgrsds', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (547, '负债', '222113', '教育费附加', 'yjsf_jyffj', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (548, '负债', '222114', '地方教育费附加', 'yjsf_dfjyffj', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (549, '负债', '222115', '矿产资源补偿费', 'yjsf_kczybcf', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (550, '负债', '222116', '排污费', 'yjsf_pwf', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (551, '负债', '222117', '印花税', 'yjsf_yhs', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (552, '负债', '222118', '预交增值税', 'yjsf_yjzzs', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (553, '负债', '222119', '待抵扣进项税额', 'yjsf_ddkjxse', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (554, '负债', '222120', '待认证进项税额', 'yjsf_drzjxse', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (555, '负债', '222121', '待转销项税额', 'yjsf_dzxxse', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (556, '负债', '222122', '增值税留抵税额', 'yjsf_zzsldse', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (557, '负债', '222123', '简易计税', 'yjsf_jyjs', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (558, '负债', '222124', '转让金融商品应交增值税', 'yjsf_zrjrspyjzzs', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (559, '负债', '222125', '代扣代交增值税', 'yjsf_dkdjzzs', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (560, '负债', '222126', '应交增值税（小规模纳税人专用）', 'yjsf_yjzzs（xgmnsrzy）', '贷', b'1', 524, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (561, '负债', '2231', '应付利息', 'yflx', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (562, '负债', '2232', '应付利润', 'yflr', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (563, '负债', '2241', '其他应付款', 'qtyfk', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (564, '负债', '2401', '递延收益', 'dysy', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (565, '负债', '2501', '长期借款', 'cqjk', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (566, '负债', '2701', '长期应付款', 'cqyfk', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (567, '权益', '3001', '实收资本', 'sszb', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (568, '权益', '3002', '资本公积', 'zbgj', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (569, '权益', '3101', '盈余公积', 'yygj', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (570, '权益', '310101', '法定盈余公积', 'yygj_fdyygj', '贷', b'1', 569, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (571, '权益', '310102', '任意盈余公积', 'yygj_ryyygj', '贷', b'1', 569, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (572, '权益', '310103', '法定公益金', 'yygj_fdgyj', '贷', b'1', 569, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (573, '权益', '3103', '本年利润', 'bnlr', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (574, '权益', '3104', '利润分配', 'lrfp', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (575, '权益', '310401', '其他转入', 'lrfp_qtzr', '贷', b'1', 574, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (576, '权益', '310402', '提取法定盈余公积', 'lrfp_tqfdyygj', '贷', b'1', 574, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (577, '权益', '310403', '提取法定公益金', 'lrfp_tqfdgyj', '贷', b'1', 574, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (578, '权益', '310404', '提取任意盈余公积', 'lrfp_tqryyygj', '贷', b'1', 574, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (579, '权益', '310405', '应付利润', 'lrfp_yflr', '贷', b'1', 574, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (580, '权益', '310406', '未分配利润', 'lrfp_wfplr', '贷', b'1', 574, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (581, '成本', '4001', '生产成本', 'sccb', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (582, '成本', '4101', '制造费用', 'zzfy', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (583, '成本', '4301', '研发支出', 'yfzc', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (584, '成本', '4401', '工程施工', 'gcsg', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (585, '成本', '4403', '机械作业', 'jxzy', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (586, '损益', '5001', '主营业务收入', 'zyywsr', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (587, '损益', '5051', '其他业务收入', 'qtywsr', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (588, '损益', '5111', '投资收益', 'tzsy', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (589, '损益', '5301', '营业外收入', 'yywsr', '贷', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (590, '损益', '530101', '非流动资产处置净收益', 'yywsr_fldzcczjsy', '贷', b'1', 589, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (591, '损益', '530102', '政府补助', 'yywsr_zfbz', '贷', b'1', 589, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (592, '损益', '530103', '捐赠收益', 'yywsr_jzsy', '贷', b'1', 589, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (593, '损益', '530104', '盘盈收益', 'yywsr_pysy', '贷', b'1', 589, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (594, '损益', '5401', '主营业务成本', 'zyywcb', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (595, '损益', '5402', '其他业务成本', 'qtywcb', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (596, '损益', '5403', '税金及附加', 'sjjfj', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (597, '损益', '5601', '销售费用', 'xsfy', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (598, '损益', '560101', '销售人员职工薪酬', 'xsfy_xsryzgxc', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (599, '损益', '560102', '业务招待费', 'xsfy_ywzdf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (600, '损益', '560103', '修理费', 'xsfy_xlf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (601, '损益', '560104', '办公费', 'xsfy_bgf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (602, '损益', '560105', '水电费', 'xsfy_sdf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (603, '损益', '560106', '差旅费', 'xsfy_clf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (604, '损益', '560107', '折旧费', 'xsfy_zjf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (605, '损益', '560108', '摊销费', 'xsfy_txf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (606, '损益', '560109', '展览费', 'xsfy_zlf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (607, '损益', '560110', '商品维修费', 'xsfy_spwxf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (608, '损益', '560111', '运输费', 'xsfy_ysf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (609, '损益', '560112', '装卸费', 'xsfy_zxf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (610, '损益', '560113', '包装费', 'xsfy_bzf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (611, '损益', '560114', '保险费', 'xsfy_bxf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (612, '损益', '560115', '广告费', 'xsfy_ggf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (613, '损益', '560116', '业务宣传费', 'xsfy_ywxcf', '借', b'1', 597, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (614, '损益', '5602', '管理费用', 'glfy', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (615, '损益', '560201', '管理人员职工薪酬', 'glfy_glryzgxc', '借', b'1', 614, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (616, '损益', '560202', '业务招待费', 'glfy_ywzdf', '借', b'1', 614, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (617, '损益', '560203', '修理费', 'glfy_xlf', '借', b'1', 614, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (618, '损益', '560204', '办公费', 'glfy_bgf', '借', b'1', 614, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (619, '损益', '560205', '水电费', 'glfy_sdf', '借', b'1', 614, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (620, '损益', '560206', '差旅费', 'glfy_clf', '借', b'1', 614, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (621, '损益', '560207', '折旧费', 'glfy_zjf', '借', b'1', 614, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (622, '损益', '560208', '摊销费', 'glfy_txf', '借', b'1', 614, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (623, '损益', '560209', '开办费', 'glfy_kbf', '借', b'1', 614, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (624, '损益', '560210', '研究费用', 'glfy_yjfy', '借', b'1', 614, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (625, '损益', '560211', '咨询费', 'glfy_zxf', '借', b'1', 614, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (626, '损益', '560212', '长期待摊费用摊销', 'glfy_cqdtfytx', '借', b'1', 614, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (627, '损益', '5603', '财务费用', 'cwfy', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (628, '损益', '560301', '利息费用', 'cwfy_lxfy', '借', b'1', 627, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (629, '损益', '560302', '手续费', 'cwfy_sxf', '借', b'1', 627, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (630, '损益', '560303', '汇兑损益', 'cwfy_hdsy', '借', b'1', 627, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (631, '损益', '560304', '现金折扣', 'cwfy_xjzk', '借', b'1', 627, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (632, '损益', '5711', '营业外支出', 'yywzc', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (633, '损益', '571101', '非流动资产处置净损失', 'yywzc_fldzcczjss', '借', b'1', 632, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (634, '损益', '571102', '赞助支出', 'yywzc_zzzc', '借', b'1', 632, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (635, '损益', '571103', '捐赠支出', 'yywzc_jzzc', '借', b'1', 632, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (636, '损益', '571104', '盘亏损失', 'yywzc_pkss', '借', b'1', 632, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (637, '损益', '571105', '坏账损失', 'yywzc_hzss', '借', b'1', 632, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (638, '损益', '571106', '存货毁损报废损失', 'yywzc_chhsbfss', '借', b'1', 632, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (639, '损益', '571107', '无法收回的长期债券投资损失', 'yywzc_wfshdcqzqtzss', '借', b'1', 632, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (640, '损益', '571108', '无法收回的长期股权投资损失', 'yywzc_wfshdcqgqtzss', '借', b'1', 632, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (641, '损益', '571109', '自然灾害等不可抗力因素造成的损失', 'yywzc_zrzhdbkklyszcdss', '借', b'1', 632, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (642, '损益', '571110', '税收滞纳金', 'yywzc_ssznj', '借', b'1', 632, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (643, '损益', '571111', '罚款支出', 'yywzc_fkzc', '借', b'1', 632, 2, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (644, '损益', '5801', '所得税费用', 'sdsfy', '借', b'1', 0, 1, b'1', 3, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (645, '资产', '1001', '库存现金', 'kcxj', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (646, '资产', '1002', '银行存款', 'yhck', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (647, '资产', '1012', '其他货币资金', 'qthbzj', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (648, '资产', '1101', '短期投资', 'dqtz', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (649, '资产', '110101', '股票', 'dqtz_gp', '借', b'1', 648, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (650, '资产', '110102', '债券', 'dqtz_zq', '借', b'1', 648, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (651, '资产', '110103', '基金', 'dqtz_jj', '借', b'1', 648, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (652, '资产', '1121', '应收票据', 'yspj', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (653, '资产', '1122', '应收账款', 'yszk', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (654, '资产', '1123', '预付账款', 'yfzk', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (655, '资产', '1131', '应收股利', 'ysgl', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (656, '资产', '1132', '应收利息', 'yslx', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (657, '资产', '1221', '其他应收款', 'qtysk', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (658, '资产', '1401', '材料采购', 'clcg', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (659, '资产', '1402', '在途物资', 'ztwz', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (660, '资产', '1403', '原材料', 'ycl', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (661, '资产', '1404', '材料成本差异', 'clcbcy', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (662, '资产', '1405', '库存商品', 'kcsp', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (663, '资产', '1407', '商品进销差价', 'spjxcj', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (664, '资产', '1408', '委托加工物资', 'wtjgwz', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (665, '资产', '1411', '周转材料', 'zzcl', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (666, '资产', '1421', '消耗性生物资产', 'xhxswzc', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (667, '资产', '1501', '长期债券投资', 'cqzqtz', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (668, '资产', '1511', '长期股权投资', 'cqgqtz', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (669, '资产', '1601', '固定资产', 'gdzc', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (670, '资产', '1602', '累计折旧', 'ljzj', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (671, '资产', '1604', '在建工程', 'zjgc', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (672, '资产', '1605', '工程物资', 'gcwz', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (673, '资产', '1606', '固定资产清理', 'gdzcql', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (674, '资产', '1621', '生产性生物资产', 'scxswzc', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (675, '资产', '1622', '生产性生物资产累计折旧', 'scxswzcljzj', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (676, '资产', '1701', '无形资产', 'wxzc', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (677, '资产', '1702', '累计摊销', 'ljtx', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (678, '资产', '1801', '长期待摊费用', 'cqdtfy', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (679, '资产', '1901', '待处理财产损溢', 'dclccsy', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (680, '负债', '2001', '短期借款', 'dqjk', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (681, '负债', '2201', '应付票据', 'yfpj', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (682, '负债', '2202', '应付账款', 'yfzk', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (683, '负债', '2203', '预收账款', 'yszk', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (684, '负债', '2211', '应付职工薪酬', 'yfzgxc', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (685, '负债', '2221', '应交税费', 'yjsf', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (686, '负债', '222101', '应交增值税', 'yjsf_yjzzs', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (687, '负债', '22210101', '进项税额', 'yjsf_yjzzs_jxse', '贷', b'1', 686, 3, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (688, '负债', '22210102', '已交税金', 'yjsf_yjzzs_yjsj', '贷', b'1', 686, 3, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (689, '负债', '22210103', '转出未交增值税', 'yjsf_yjzzs_zcwjzzs', '贷', b'1', 686, 3, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (690, '负债', '22210104', '减免税款', 'yjsf_yjzzs_jmsk', '贷', b'1', 686, 3, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (691, '负债', '22210105', '销项税额', 'yjsf_yjzzs_xxse', '贷', b'1', 686, 3, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (692, '负债', '22210106', '出口退税', 'yjsf_yjzzs_ckts', '贷', b'1', 686, 3, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (693, '负债', '22210107', '进项税额转出', 'yjsf_yjzzs_jxsezc', '贷', b'1', 686, 3, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (694, '负债', '22210108', '出口抵减内销产品应纳税额', 'yjsf_yjzzs_ckdjnxcpynse', '贷', b'1', 686, 3, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (695, '负债', '22210109', '转出多交增值税', 'yjsf_yjzzs_zcdjzzs', '贷', b'1', 686, 3, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (696, '负债', '22210110', '销项税额抵减', 'yjsf_yjzzs_xxsedj', '贷', b'1', 686, 3, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (697, '负债', '222102', '未交增值税', 'yjsf_wjzzs', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (698, '负债', '222103', '应交消费税', 'yjsf_yjxfs', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (699, '负债', '222104', '应交营业税', 'yjsf_yjyys', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (700, '负债', '222105', '应交资源税', 'yjsf_yjzys', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (701, '负债', '222106', '应交所得税', 'yjsf_yjsds', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (702, '负债', '222107', '应交土地增值税', 'yjsf_yjtdzzs', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (703, '负债', '222108', '应交城市维护建设税', 'yjsf_yjcswhjss', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (704, '负债', '222109', '应交房产税', 'yjsf_yjfcs', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (705, '负债', '222110', '应交城镇土地使用税', 'yjsf_yjcztdsys', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (706, '负债', '222111', '应交车船使用税', 'yjsf_yjccsys', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (707, '负债', '222112', '应交个人所得税', 'yjsf_yjgrsds', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (708, '负债', '222113', '教育费附加', 'yjsf_jyffj', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (709, '负债', '222114', '地方教育费附加', 'yjsf_dfjyffj', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (710, '负债', '222115', '矿产资源补偿费', 'yjsf_kczybcf', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (711, '负债', '222116', '排污费', 'yjsf_pwf', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (712, '负债', '222117', '印花税', 'yjsf_yhs', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (713, '负债', '222118', '预交增值税', 'yjsf_yjzzs', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (714, '负债', '222119', '待抵扣进项税额', 'yjsf_ddkjxse', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (715, '负债', '222120', '待认证进项税额', 'yjsf_drzjxse', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (716, '负债', '222121', '待转销项税额', 'yjsf_dzxxse', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (717, '负债', '222122', '增值税留抵税额', 'yjsf_zzsldse', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (718, '负债', '222123', '简易计税', 'yjsf_jyjs', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (719, '负债', '222124', '转让金融商品应交增值税', 'yjsf_zrjrspyjzzs', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (720, '负债', '222125', '代扣代交增值税', 'yjsf_dkdjzzs', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (721, '负债', '222126', '应交增值税（小规模纳税人专用）', 'yjsf_yjzzs（xgmnsrzy）', '贷', b'1', 685, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (722, '负债', '2231', '应付利息', 'yflx', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (723, '负债', '2232', '应付利润', 'yflr', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (724, '负债', '2241', '其他应付款', 'qtyfk', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (725, '负债', '2401', '递延收益', 'dysy', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (726, '负债', '2501', '长期借款', 'cqjk', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (727, '负债', '2701', '长期应付款', 'cqyfk', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (728, '权益', '3001', '实收资本', 'sszb', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (729, '权益', '3002', '资本公积', 'zbgj', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (730, '权益', '3101', '盈余公积', 'yygj', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (731, '权益', '310101', '法定盈余公积', 'yygj_fdyygj', '贷', b'1', 730, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (732, '权益', '310102', '任意盈余公积', 'yygj_ryyygj', '贷', b'1', 730, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (733, '权益', '310103', '法定公益金', 'yygj_fdgyj', '贷', b'1', 730, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (734, '权益', '3103', '本年利润', 'bnlr', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (735, '权益', '3104', '利润分配', 'lrfp', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (736, '权益', '310401', '其他转入', 'lrfp_qtzr', '贷', b'1', 735, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (737, '权益', '310402', '提取法定盈余公积', 'lrfp_tqfdyygj', '贷', b'1', 735, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (738, '权益', '310403', '提取法定公益金', 'lrfp_tqfdgyj', '贷', b'1', 735, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (739, '权益', '310404', '提取任意盈余公积', 'lrfp_tqryyygj', '贷', b'1', 735, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (740, '权益', '310405', '应付利润', 'lrfp_yflr', '贷', b'1', 735, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (741, '权益', '310406', '未分配利润', 'lrfp_wfplr', '贷', b'1', 735, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (742, '成本', '4001', '生产成本', 'sccb', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (743, '成本', '4101', '制造费用', 'zzfy', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (744, '成本', '4301', '研发支出', 'yfzc', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (745, '成本', '4401', '工程施工', 'gcsg', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (746, '成本', '4403', '机械作业', 'jxzy', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (747, '损益', '5001', '主营业务收入', 'zyywsr', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (748, '损益', '5051', '其他业务收入', 'qtywsr', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (749, '损益', '5111', '投资收益', 'tzsy', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (750, '损益', '5301', '营业外收入', 'yywsr', '贷', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (751, '损益', '530101', '非流动资产处置净收益', 'yywsr_fldzcczjsy', '贷', b'1', 750, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (752, '损益', '530102', '政府补助', 'yywsr_zfbz', '贷', b'1', 750, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (753, '损益', '530103', '捐赠收益', 'yywsr_jzsy', '贷', b'1', 750, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (754, '损益', '530104', '盘盈收益', 'yywsr_pysy', '贷', b'1', 750, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (755, '损益', '5401', '主营业务成本', 'zyywcb', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (756, '损益', '5402', '其他业务成本', 'qtywcb', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (757, '损益', '5403', '税金及附加', 'sjjfj', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (758, '损益', '5601', '销售费用', 'xsfy', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (759, '损益', '560101', '销售人员职工薪酬', 'xsfy_xsryzgxc', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (760, '损益', '560102', '业务招待费', 'xsfy_ywzdf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (761, '损益', '560103', '修理费', 'xsfy_xlf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (762, '损益', '560104', '办公费', 'xsfy_bgf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (763, '损益', '560105', '水电费', 'xsfy_sdf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (764, '损益', '560106', '差旅费', 'xsfy_clf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (765, '损益', '560107', '折旧费', 'xsfy_zjf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (766, '损益', '560108', '摊销费', 'xsfy_txf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (767, '损益', '560109', '展览费', 'xsfy_zlf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (768, '损益', '560110', '商品维修费', 'xsfy_spwxf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (769, '损益', '560111', '运输费', 'xsfy_ysf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (770, '损益', '560112', '装卸费', 'xsfy_zxf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (771, '损益', '560113', '包装费', 'xsfy_bzf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (772, '损益', '560114', '保险费', 'xsfy_bxf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (773, '损益', '560115', '广告费', 'xsfy_ggf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (774, '损益', '560116', '业务宣传费', 'xsfy_ywxcf', '借', b'1', 758, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (775, '损益', '5602', '管理费用', 'glfy', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (776, '损益', '560201', '管理人员职工薪酬', 'glfy_glryzgxc', '借', b'1', 775, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (777, '损益', '560202', '业务招待费', 'glfy_ywzdf', '借', b'1', 775, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (778, '损益', '560203', '修理费', 'glfy_xlf', '借', b'1', 775, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (779, '损益', '560204', '办公费', 'glfy_bgf', '借', b'1', 775, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (780, '损益', '560205', '水电费', 'glfy_sdf', '借', b'1', 775, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (781, '损益', '560206', '差旅费', 'glfy_clf', '借', b'1', 775, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (782, '损益', '560207', '折旧费', 'glfy_zjf', '借', b'1', 775, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (783, '损益', '560208', '摊销费', 'glfy_txf', '借', b'1', 775, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (784, '损益', '560209', '开办费', 'glfy_kbf', '借', b'1', 775, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (785, '损益', '560210', '研究费用', 'glfy_yjfy', '借', b'1', 775, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (786, '损益', '560211', '咨询费', 'glfy_zxf', '借', b'1', 775, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (787, '损益', '560212', '长期待摊费用摊销', 'glfy_cqdtfytx', '借', b'1', 775, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (788, '损益', '5603', '财务费用', 'cwfy', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (789, '损益', '560301', '利息费用', 'cwfy_lxfy', '借', b'1', 788, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (790, '损益', '560302', '手续费', 'cwfy_sxf', '借', b'1', 788, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (791, '损益', '560303', '汇兑损益', 'cwfy_hdsy', '借', b'1', 788, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (792, '损益', '560304', '现金折扣', 'cwfy_xjzk', '借', b'1', 788, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (793, '损益', '5711', '营业外支出', 'yywzc', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (794, '损益', '571101', '非流动资产处置净损失', 'yywzc_fldzcczjss', '借', b'1', 793, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (795, '损益', '571102', '赞助支出', 'yywzc_zzzc', '借', b'1', 793, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (796, '损益', '571103', '捐赠支出', 'yywzc_jzzc', '借', b'1', 793, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (797, '损益', '571104', '盘亏损失', 'yywzc_pkss', '借', b'1', 793, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (798, '损益', '571105', '坏账损失', 'yywzc_hzss', '借', b'1', 793, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (799, '损益', '571106', '存货毁损报废损失', 'yywzc_chhsbfss', '借', b'1', 793, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (800, '损益', '571107', '无法收回的长期债券投资损失', 'yywzc_wfshdcqzqtzss', '借', b'1', 793, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (801, '损益', '571108', '无法收回的长期股权投资损失', 'yywzc_wfshdcqgqtzss', '借', b'1', 793, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (802, '损益', '571109', '自然灾害等不可抗力因素造成的损失', 'yywzc_zrzhdbkklyszcdss', '借', b'1', 793, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (803, '损益', '571110', '税收滞纳金', 'yywzc_ssznj', '借', b'1', 793, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (804, '损益', '571111', '罚款支出', 'yywzc_fkzc', '借', b'1', 793, 2, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (805, '损益', '5801', '所得税费用', 'sdsfy', '借', b'1', 0, 1, b'1', 4, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (806, '资产', '1001', '库存现金', 'kcxj', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (807, '资产', '1002', '银行存款', 'yhck', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (808, '资产', '1012', '其他货币资金', 'qthbzj', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (809, '资产', '1101', '短期投资', 'dqtz', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (810, '资产', '110101', '股票', 'dqtz_gp', '借', b'1', 809, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (811, '资产', '110102', '债券', 'dqtz_zq', '借', b'1', 809, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (812, '资产', '110103', '基金', 'dqtz_jj', '借', b'1', 809, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (813, '资产', '1121', '应收票据', 'yspj', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (814, '资产', '1122', '应收账款', 'yszk', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (815, '资产', '1123', '预付账款', 'yfzk', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (816, '资产', '1131', '应收股利', 'ysgl', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (817, '资产', '1132', '应收利息', 'yslx', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (818, '资产', '1221', '其他应收款', 'qtysk', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (819, '资产', '1401', '材料采购', 'clcg', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (820, '资产', '1402', '在途物资', 'ztwz', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (821, '资产', '1403', '原材料', 'ycl', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (822, '资产', '1404', '材料成本差异', 'clcbcy', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (823, '资产', '1405', '库存商品', 'kcsp', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (824, '资产', '1407', '商品进销差价', 'spjxcj', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (825, '资产', '1408', '委托加工物资', 'wtjgwz', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (826, '资产', '1411', '周转材料', 'zzcl', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (827, '资产', '1421', '消耗性生物资产', 'xhxswzc', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (828, '资产', '1501', '长期债券投资', 'cqzqtz', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (829, '资产', '1511', '长期股权投资', 'cqgqtz', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (830, '资产', '1601', '固定资产', 'gdzc', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (831, '资产', '1602', '累计折旧', 'ljzj', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (832, '资产', '1604', '在建工程', 'zjgc', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (833, '资产', '1605', '工程物资', 'gcwz', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (834, '资产', '1606', '固定资产清理', 'gdzcql', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (835, '资产', '1621', '生产性生物资产', 'scxswzc', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (836, '资产', '1622', '生产性生物资产累计折旧', 'scxswzcljzj', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (837, '资产', '1701', '无形资产', 'wxzc', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (838, '资产', '1702', '累计摊销', 'ljtx', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (839, '资产', '1801', '长期待摊费用', 'cqdtfy', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (840, '资产', '1901', '待处理财产损溢', 'dclccsy', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (841, '负债', '2001', '短期借款', 'dqjk', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (842, '负债', '2201', '应付票据', 'yfpj', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (843, '负债', '2202', '应付账款', 'yfzk', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (844, '负债', '2203', '预收账款', 'yszk', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (845, '负债', '2211', '应付职工薪酬', 'yfzgxc', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (846, '负债', '2221', '应交税费', 'yjsf', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (847, '负债', '222101', '应交增值税', 'yjsf_yjzzs', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (848, '负债', '22210101', '进项税额', 'yjsf_yjzzs_jxse', '贷', b'1', 847, 3, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (849, '负债', '22210102', '已交税金', 'yjsf_yjzzs_yjsj', '贷', b'1', 847, 3, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (850, '负债', '22210103', '转出未交增值税', 'yjsf_yjzzs_zcwjzzs', '贷', b'1', 847, 3, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (851, '负债', '22210104', '减免税款', 'yjsf_yjzzs_jmsk', '贷', b'1', 847, 3, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (852, '负债', '22210105', '销项税额', 'yjsf_yjzzs_xxse', '贷', b'1', 847, 3, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (853, '负债', '22210106', '出口退税', 'yjsf_yjzzs_ckts', '贷', b'1', 847, 3, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (854, '负债', '22210107', '进项税额转出', 'yjsf_yjzzs_jxsezc', '贷', b'1', 847, 3, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (855, '负债', '22210108', '出口抵减内销产品应纳税额', 'yjsf_yjzzs_ckdjnxcpynse', '贷', b'1', 847, 3, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (856, '负债', '22210109', '转出多交增值税', 'yjsf_yjzzs_zcdjzzs', '贷', b'1', 847, 3, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (857, '负债', '22210110', '销项税额抵减', 'yjsf_yjzzs_xxsedj', '贷', b'1', 847, 3, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (858, '负债', '222102', '未交增值税', 'yjsf_wjzzs', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (859, '负债', '222103', '应交消费税', 'yjsf_yjxfs', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (860, '负债', '222104', '应交营业税', 'yjsf_yjyys', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (861, '负债', '222105', '应交资源税', 'yjsf_yjzys', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (862, '负债', '222106', '应交所得税', 'yjsf_yjsds', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (863, '负债', '222107', '应交土地增值税', 'yjsf_yjtdzzs', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (864, '负债', '222108', '应交城市维护建设税', 'yjsf_yjcswhjss', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (865, '负债', '222109', '应交房产税', 'yjsf_yjfcs', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (866, '负债', '222110', '应交城镇土地使用税', 'yjsf_yjcztdsys', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (867, '负债', '222111', '应交车船使用税', 'yjsf_yjccsys', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (868, '负债', '222112', '应交个人所得税', 'yjsf_yjgrsds', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (869, '负债', '222113', '教育费附加', 'yjsf_jyffj', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (870, '负债', '222114', '地方教育费附加', 'yjsf_dfjyffj', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (871, '负债', '222115', '矿产资源补偿费', 'yjsf_kczybcf', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (872, '负债', '222116', '排污费', 'yjsf_pwf', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (873, '负债', '222117', '印花税', 'yjsf_yhs', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (874, '负债', '222118', '预交增值税', 'yjsf_yjzzs', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (875, '负债', '222119', '待抵扣进项税额', 'yjsf_ddkjxse', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (876, '负债', '222120', '待认证进项税额', 'yjsf_drzjxse', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (877, '负债', '222121', '待转销项税额', 'yjsf_dzxxse', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (878, '负债', '222122', '增值税留抵税额', 'yjsf_zzsldse', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (879, '负债', '222123', '简易计税', 'yjsf_jyjs', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (880, '负债', '222124', '转让金融商品应交增值税', 'yjsf_zrjrspyjzzs', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (881, '负债', '222125', '代扣代交增值税', 'yjsf_dkdjzzs', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (882, '负债', '222126', '应交增值税（小规模纳税人专用）', 'yjsf_yjzzs（xgmnsrzy）', '贷', b'1', 846, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (883, '负债', '2231', '应付利息', 'yflx', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (884, '负债', '2232', '应付利润', 'yflr', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (885, '负债', '2241', '其他应付款', 'qtyfk', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (886, '负债', '2401', '递延收益', 'dysy', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (887, '负债', '2501', '长期借款', 'cqjk', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (888, '负债', '2701', '长期应付款', 'cqyfk', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (889, '权益', '3001', '实收资本', 'sszb', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (890, '权益', '3002', '资本公积', 'zbgj', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (891, '权益', '3101', '盈余公积', 'yygj', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (892, '权益', '310101', '法定盈余公积', 'yygj_fdyygj', '贷', b'1', 891, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (893, '权益', '310102', '任意盈余公积', 'yygj_ryyygj', '贷', b'1', 891, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (894, '权益', '310103', '法定公益金', 'yygj_fdgyj', '贷', b'1', 891, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (895, '权益', '3103', '本年利润', 'bnlr', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (896, '权益', '3104', '利润分配', 'lrfp', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (897, '权益', '310401', '其他转入', 'lrfp_qtzr', '贷', b'1', 896, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (898, '权益', '310402', '提取法定盈余公积', 'lrfp_tqfdyygj', '贷', b'1', 896, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (899, '权益', '310403', '提取法定公益金', 'lrfp_tqfdgyj', '贷', b'1', 896, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (900, '权益', '310404', '提取任意盈余公积', 'lrfp_tqryyygj', '贷', b'1', 896, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (901, '权益', '310405', '应付利润', 'lrfp_yflr', '贷', b'1', 896, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (902, '权益', '310406', '未分配利润', 'lrfp_wfplr', '贷', b'1', 896, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (903, '成本', '4001', '生产成本', 'sccb', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (904, '成本', '4101', '制造费用', 'zzfy', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (905, '成本', '4301', '研发支出', 'yfzc', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (906, '成本', '4401', '工程施工', 'gcsg', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (907, '成本', '4403', '机械作业', 'jxzy', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (908, '损益', '5001', '主营业务收入', 'zyywsr', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (909, '损益', '5051', '其他业务收入', 'qtywsr', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (910, '损益', '5111', '投资收益', 'tzsy', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (911, '损益', '5301', '营业外收入', 'yywsr', '贷', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (912, '损益', '530101', '非流动资产处置净收益', 'yywsr_fldzcczjsy', '贷', b'1', 911, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (913, '损益', '530102', '政府补助', 'yywsr_zfbz', '贷', b'1', 911, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (914, '损益', '530103', '捐赠收益', 'yywsr_jzsy', '贷', b'1', 911, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (915, '损益', '530104', '盘盈收益', 'yywsr_pysy', '贷', b'1', 911, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (916, '损益', '5401', '主营业务成本', 'zyywcb', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (917, '损益', '5402', '其他业务成本', 'qtywcb', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (918, '损益', '5403', '税金及附加', 'sjjfj', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (919, '损益', '5601', '销售费用', 'xsfy', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (920, '损益', '560101', '销售人员职工薪酬', 'xsfy_xsryzgxc', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (921, '损益', '560102', '业务招待费', 'xsfy_ywzdf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (922, '损益', '560103', '修理费', 'xsfy_xlf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (923, '损益', '560104', '办公费', 'xsfy_bgf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (924, '损益', '560105', '水电费', 'xsfy_sdf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (925, '损益', '560106', '差旅费', 'xsfy_clf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (926, '损益', '560107', '折旧费', 'xsfy_zjf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (927, '损益', '560108', '摊销费', 'xsfy_txf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (928, '损益', '560109', '展览费', 'xsfy_zlf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (929, '损益', '560110', '商品维修费', 'xsfy_spwxf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (930, '损益', '560111', '运输费', 'xsfy_ysf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (931, '损益', '560112', '装卸费', 'xsfy_zxf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (932, '损益', '560113', '包装费', 'xsfy_bzf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (933, '损益', '560114', '保险费', 'xsfy_bxf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (934, '损益', '560115', '广告费', 'xsfy_ggf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (935, '损益', '560116', '业务宣传费', 'xsfy_ywxcf', '借', b'1', 919, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (936, '损益', '5602', '管理费用', 'glfy', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (937, '损益', '560201', '管理人员职工薪酬', 'glfy_glryzgxc', '借', b'1', 936, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (938, '损益', '560202', '业务招待费', 'glfy_ywzdf', '借', b'1', 936, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (939, '损益', '560203', '修理费', 'glfy_xlf', '借', b'1', 936, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (940, '损益', '560204', '办公费', 'glfy_bgf', '借', b'1', 936, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (941, '损益', '560205', '水电费', 'glfy_sdf', '借', b'1', 936, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (942, '损益', '560206', '差旅费', 'glfy_clf', '借', b'1', 936, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (943, '损益', '560207', '折旧费', 'glfy_zjf', '借', b'1', 936, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (944, '损益', '560208', '摊销费', 'glfy_txf', '借', b'1', 936, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (945, '损益', '560209', '开办费', 'glfy_kbf', '借', b'1', 936, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (946, '损益', '560210', '研究费用', 'glfy_yjfy', '借', b'1', 936, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (947, '损益', '560211', '咨询费', 'glfy_zxf', '借', b'1', 936, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (948, '损益', '560212', '长期待摊费用摊销', 'glfy_cqdtfytx', '借', b'1', 936, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (949, '损益', '5603', '财务费用', 'cwfy', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (950, '损益', '560301', '利息费用', 'cwfy_lxfy', '借', b'1', 949, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (951, '损益', '560302', '手续费', 'cwfy_sxf', '借', b'1', 949, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (952, '损益', '560303', '汇兑损益', 'cwfy_hdsy', '借', b'1', 949, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (953, '损益', '560304', '现金折扣', 'cwfy_xjzk', '借', b'1', 949, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (954, '损益', '5711', '营业外支出', 'yywzc', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (955, '损益', '571101', '非流动资产处置净损失', 'yywzc_fldzcczjss', '借', b'1', 954, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (956, '损益', '571102', '赞助支出', 'yywzc_zzzc', '借', b'1', 954, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (957, '损益', '571103', '捐赠支出', 'yywzc_jzzc', '借', b'1', 954, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (958, '损益', '571104', '盘亏损失', 'yywzc_pkss', '借', b'1', 954, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (959, '损益', '571105', '坏账损失', 'yywzc_hzss', '借', b'1', 954, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (960, '损益', '571106', '存货毁损报废损失', 'yywzc_chhsbfss', '借', b'1', 954, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (961, '损益', '571107', '无法收回的长期债券投资损失', 'yywzc_wfshdcqzqtzss', '借', b'1', 954, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (962, '损益', '571108', '无法收回的长期股权投资损失', 'yywzc_wfshdcqgqtzss', '借', b'1', 954, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (963, '损益', '571109', '自然灾害等不可抗力因素造成的损失', 'yywzc_zrzhdbkklyszcdss', '借', b'1', 954, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (964, '损益', '571110', '税收滞纳金', 'yywzc_ssznj', '借', b'1', 954, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (965, '损益', '571111', '罚款支出', 'yywzc_fkzc', '借', b'1', 954, 2, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (966, '损益', '5801', '所得税费用', 'sdsfy', '借', b'1', 0, 1, b'1', 5, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (967, '资产', '1001', '库存现金', 'kcxj', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (968, '资产', '1002', '银行存款', 'yhck', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (969, '资产', '1012', '其他货币资金', 'qthbzj', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (970, '资产', '1101', '短期投资', 'dqtz', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (971, '资产', '110101', '股票', 'dqtz_gp', '借', b'1', 970, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (972, '资产', '110102', '债券', 'dqtz_zq', '借', b'1', 970, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (973, '资产', '110103', '基金', 'dqtz_jj', '借', b'1', 970, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (974, '资产', '1121', '应收票据', 'yspj', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (975, '资产', '1122', '应收账款', 'yszk', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (976, '资产', '1123', '预付账款', 'yfzk', '借', b'0', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (977, '资产', '1131', '应收股利', 'ysgl', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (978, '资产', '1132', '应收利息', 'yslx', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (979, '资产', '1221', '其他应收款', 'qtysk', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (980, '资产', '1401', '材料采购', 'clcg', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (981, '资产', '1402', '在途物资', 'ztwz', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (982, '资产', '1403', '原材料', 'ycl', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (983, '资产', '1404', '材料成本差异', 'clcbcy', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (984, '资产', '1405', '库存商品', 'kcsp', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (985, '资产', '1407', '商品进销差价', 'spjxcj', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (986, '资产', '1408', '委托加工物资', 'wtjgwz', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (987, '资产', '1411', '周转材料', 'zzcl', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (988, '资产', '1421', '消耗性生物资产', 'xhxswzc', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (989, '资产', '1501', '长期债券投资', 'cqzqtz', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (990, '资产', '1511', '长期股权投资', 'cqgqtz', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (991, '资产', '1601', '固定资产', 'gdzc', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (992, '资产', '1602', '累计折旧', 'ljzj', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (993, '资产', '1604', '在建工程', 'zjgc', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (994, '资产', '1605', '工程物资', 'gcwz', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (995, '资产', '1606', '固定资产清理', 'gdzcql', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (996, '资产', '1621', '生产性生物资产', 'scxswzc', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (997, '资产', '1622', '生产性生物资产累计折旧', 'scxswzcljzj', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (998, '资产', '1701', '无形资产', 'wxzc', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (999, '资产', '1702', '累计摊销', 'ljtx', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1000, '资产', '1801', '长期待摊费用', 'cqdtfy', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1001, '资产', '1901', '待处理财产损溢', 'dclccsy', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1002, '负债', '2001', '短期借款', 'dqjk', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1003, '负债', '2201', '应付票据', 'yfpj', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1004, '负债', '2202', '应付账款', 'yfzk', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1005, '负债', '2203', '预收账款', 'yszk', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1006, '负债', '2211', '应付职工薪酬', 'yfzgxc', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1007, '负债', '2221', '应交税费', 'yjsf', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1008, '负债', '222101', '应交增值税', 'yjsf_yjzzs', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1009, '负债', '22210101', '进项税额', 'yjsf_yjzzs_jxse', '贷', b'1', 1008, 3, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1010, '负债', '22210102', '已交税金', 'yjsf_yjzzs_yjsj', '贷', b'1', 1008, 3, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1011, '负债', '22210103', '转出未交增值税', 'yjsf_yjzzs_zcwjzzs', '贷', b'1', 1008, 3, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1012, '负债', '22210104', '减免税款', 'yjsf_yjzzs_jmsk', '贷', b'1', 1008, 3, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1013, '负债', '22210105', '销项税额', 'yjsf_yjzzs_xxse', '贷', b'1', 1008, 3, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1014, '负债', '22210106', '出口退税', 'yjsf_yjzzs_ckts', '贷', b'1', 1008, 3, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1015, '负债', '22210107', '进项税额转出', 'yjsf_yjzzs_jxsezc', '贷', b'1', 1008, 3, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1016, '负债', '22210108', '出口抵减内销产品应纳税额', 'yjsf_yjzzs_ckdjnxcpynse', '贷', b'1', 1008, 3, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1017, '负债', '22210109', '转出多交增值税', 'yjsf_yjzzs_zcdjzzs', '贷', b'1', 1008, 3, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1018, '负债', '22210110', '销项税额抵减', 'yjsf_yjzzs_xxsedj', '贷', b'1', 1008, 3, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1019, '负债', '222102', '未交增值税', 'yjsf_wjzzs', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1020, '负债', '222103', '应交消费税', 'yjsf_yjxfs', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1021, '负债', '222104', '应交营业税', 'yjsf_yjyys', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1022, '负债', '222105', '应交资源税', 'yjsf_yjzys', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1023, '负债', '222106', '应交所得税', 'yjsf_yjsds', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1024, '负债', '222107', '应交土地增值税', 'yjsf_yjtdzzs', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1025, '负债', '222108', '应交城市维护建设税', 'yjsf_yjcswhjss', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1026, '负债', '222109', '应交房产税', 'yjsf_yjfcs', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1027, '负债', '222110', '应交城镇土地使用税', 'yjsf_yjcztdsys', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1028, '负债', '222111', '应交车船使用税', 'yjsf_yjccsys', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1029, '负债', '222112', '应交个人所得税', 'yjsf_yjgrsds', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1030, '负债', '222113', '教育费附加', 'yjsf_jyffj', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1031, '负债', '222114', '地方教育费附加', 'yjsf_dfjyffj', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1032, '负债', '222115', '矿产资源补偿费', 'yjsf_kczybcf', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1033, '负债', '222116', '排污费', 'yjsf_pwf', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1034, '负债', '222117', '印花税', 'yjsf_yhs', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1035, '负债', '222118', '预交增值税', 'yjsf_yjzzs', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1036, '负债', '222119', '待抵扣进项税额', 'yjsf_ddkjxse', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1037, '负债', '222120', '待认证进项税额', 'yjsf_drzjxse', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1038, '负债', '222121', '待转销项税额', 'yjsf_dzxxse', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1039, '负债', '222122', '增值税留抵税额', 'yjsf_zzsldse', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1040, '负债', '222123', '简易计税', 'yjsf_jyjs', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1041, '负债', '222124', '转让金融商品应交增值税', 'yjsf_zrjrspyjzzs', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1042, '负债', '222125', '代扣代交增值税', 'yjsf_dkdjzzs', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1043, '负债', '222126', '应交增值税（小规模纳税人专用）', 'yjsf_yjzzs（xgmnsrzy）', '贷', b'1', 1007, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1044, '负债', '2231', '应付利息', 'yflx', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1045, '负债', '2232', '应付利润', 'yflr', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1046, '负债', '2241', '其他应付款', 'qtyfk', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1047, '负债', '2401', '递延收益', 'dysy', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1048, '负债', '2501', '长期借款', 'cqjk', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1049, '负债', '2701', '长期应付款', 'cqyfk', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1050, '权益', '3001', '实收资本', 'sszb', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1051, '权益', '3002', '资本公积', 'zbgj', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1052, '权益', '3101', '盈余公积', 'yygj', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1053, '权益', '310101', '法定盈余公积', 'yygj_fdyygj', '贷', b'1', 1052, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1054, '权益', '310102', '任意盈余公积', 'yygj_ryyygj', '贷', b'1', 1052, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1055, '权益', '310103', '法定公益金', 'yygj_fdgyj', '贷', b'1', 1052, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1056, '权益', '3103', '本年利润', 'bnlr', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1057, '权益', '3104', '利润分配', 'lrfp', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1058, '权益', '310401', '其他转入', 'lrfp_qtzr', '贷', b'1', 1057, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1059, '权益', '310402', '提取法定盈余公积', 'lrfp_tqfdyygj', '贷', b'1', 1057, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1060, '权益', '310403', '提取法定公益金', 'lrfp_tqfdgyj', '贷', b'1', 1057, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1061, '权益', '310404', '提取任意盈余公积', 'lrfp_tqryyygj', '贷', b'1', 1057, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1062, '权益', '310405', '应付利润', 'lrfp_yflr', '贷', b'1', 1057, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1063, '权益', '310406', '未分配利润', 'lrfp_wfplr', '贷', b'1', 1057, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1064, '成本', '4001', '生产成本', 'sccb', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1065, '成本', '4101', '制造费用', 'zzfy', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1066, '成本', '4301', '研发支出', 'yfzc', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1067, '成本', '4401', '工程施工', 'gcsg', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1068, '成本', '4403', '机械作业', 'jxzy', '借', b'0', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1069, '损益', '5001', '主营业务收入', 'zyywsr', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1070, '损益', '5051', '其他业务收入', 'qtywsr', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1071, '损益', '5111', '投资收益', 'tzsy', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1072, '损益', '5301', '营业外收入', 'yywsr', '贷', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1073, '损益', '530101', '非流动资产处置净收益', 'yywsr_fldzcczjsy', '贷', b'1', 1072, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1074, '损益', '530102', '政府补助', 'yywsr_zfbz', '贷', b'1', 1072, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1075, '损益', '530103', '捐赠收益', 'yywsr_jzsy', '贷', b'1', 1072, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1076, '损益', '530104', '盘盈收益', 'yywsr_pysy', '贷', b'1', 1072, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1077, '损益', '5401', '主营业务成本', 'zyywcb', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1078, '损益', '5402', '其他业务成本', 'qtywcb', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1079, '损益', '5403', '税金及附加', 'sjjfj', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1080, '损益', '5601', '销售费用', 'xsfy', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1081, '损益', '560101', '销售人员职工薪酬', 'xsfy_xsryzgxc', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1082, '损益', '560102', '业务招待费', 'xsfy_ywzdf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1083, '损益', '560103', '修理费', 'xsfy_xlf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1084, '损益', '560104', '办公费', 'xsfy_bgf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1085, '损益', '560105', '水电费', 'xsfy_sdf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1086, '损益', '560106', '差旅费', 'xsfy_clf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1087, '损益', '560107', '折旧费', 'xsfy_zjf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1088, '损益', '560108', '摊销费', 'xsfy_txf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1089, '损益', '560109', '展览费', 'xsfy_zlf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1090, '损益', '560110', '商品维修费', 'xsfy_spwxf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1091, '损益', '560111', '运输费', 'xsfy_ysf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1092, '损益', '560112', '装卸费', 'xsfy_zxf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1093, '损益', '560113', '包装费', 'xsfy_bzf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1094, '损益', '560114', '保险费', 'xsfy_bxf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1095, '损益', '560115', '广告费', 'xsfy_ggf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1096, '损益', '560116', '业务宣传费', 'xsfy_ywxcf', '借', b'1', 1080, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1097, '损益', '5602', '管理费用', 'glfy', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1098, '损益', '560201', '管理人员职工薪酬', 'glfy_glryzgxc', '借', b'1', 1097, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1099, '损益', '560202', '业务招待费', 'glfy_ywzdf', '借', b'1', 1097, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1100, '损益', '560203', '修理费', 'glfy_xlf', '借', b'1', 1097, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1101, '损益', '560204', '办公费', 'glfy_bgf', '借', b'1', 1097, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1102, '损益', '560205', '水电费', 'glfy_sdf', '借', b'1', 1097, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1103, '损益', '560206', '差旅费', 'glfy_clf', '借', b'1', 1097, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1104, '损益', '560207', '折旧费', 'glfy_zjf', '借', b'1', 1097, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1105, '损益', '560208', '摊销费', 'glfy_txf', '借', b'1', 1097, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1106, '损益', '560209', '开办费', 'glfy_kbf', '借', b'1', 1097, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1107, '损益', '560210', '研究费用', 'glfy_yjfy', '借', b'1', 1097, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1108, '损益', '560211', '咨询费', 'glfy_zxf', '借', b'1', 1097, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1109, '损益', '560212', '长期待摊费用摊销', 'glfy_cqdtfytx', '借', b'1', 1097, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1110, '损益', '5603', '财务费用', 'cwfy', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1111, '损益', '560301', '利息费用', 'cwfy_lxfy', '借', b'1', 1110, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1112, '损益', '560302', '手续费', 'cwfy_sxf', '借', b'1', 1110, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1113, '损益', '560303', '汇兑损益', 'cwfy_hdsy', '借', b'1', 1110, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1114, '损益', '560304', '现金折扣', 'cwfy_xjzk', '借', b'1', 1110, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1115, '损益', '5711', '营业外支出', 'yywzc', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1116, '损益', '571101', '非流动资产处置净损失', 'yywzc_fldzcczjss', '借', b'1', 1115, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1117, '损益', '571102', '赞助支出', 'yywzc_zzzc', '借', b'1', 1115, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1118, '损益', '571103', '捐赠支出', 'yywzc_jzzc', '借', b'1', 1115, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1119, '损益', '571104', '盘亏损失', 'yywzc_pkss', '借', b'1', 1115, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1120, '损益', '571105', '坏账损失', 'yywzc_hzss', '借', b'1', 1115, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1121, '损益', '571106', '存货毁损报废损失', 'yywzc_chhsbfss', '借', b'1', 1115, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1122, '损益', '571107', '无法收回的长期债券投资损失', 'yywzc_wfshdcqzqtzss', '借', b'1', 1115, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1123, '损益', '571108', '无法收回的长期股权投资损失', 'yywzc_wfshdcqgqtzss', '借', b'1', 1115, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1124, '损益', '571109', '自然灾害等不可抗力因素造成的损失', 'yywzc_zrzhdbkklyszcdss', '借', b'1', 1115, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1125, '损益', '571110', '税收滞纳金', 'yywzc_ssznj', '借', b'1', 1115, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1126, '损益', '571111', '罚款支出', 'yywzc_fkzc', '借', b'1', 1115, 2, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1127, '损益', '5801', '所得税费用', 'sdsfy', '借', b'1', 0, 1, b'1', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1128, '资产', '1001001', '测试111', 'kcxj_cs111', '借', b'1', 323, 2, b'0', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1129, '资产', '100100101', '测试345', 'kcxj_cs111_cs345', '借', b'1', 1128, 3, b'0', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1130, '资产', '1701001', '测试321', 'wxzc_cs321', '借', b'0', 354, 2, b'0', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1131, '资产', '110100201', '11111', 'dqtz_zq_11111', '借', b'1', 328, 3, b'0', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1132, '负债', '222100111', '11111', 'yjsf_yjzzs_11111', '贷', b'1', 364, 3, b'0', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1133, '资产', '110100101', '11111', 'dqtz_gp_11111', '借', b'1', 327, 3, b'0', 2, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1134, '资产', '110104', '88', 'dqtz_88', '借', b'1', 165, 2, b'0', 1, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1135, '资产', '100101', 'XXXX', 'kcxj_XXXX', '借', b'1', 967, 2, b'0', 6, NULL, '', '', NULL, NULL);
INSERT INTO `fxy_financial_subject` VALUES (1136, '资产', '100102', 'DDD', 'kcxj_DDD', '借', b'1', 967, 2, b'0', 6, NULL, '', '', NULL, NULL);

-- ----------------------------
-- Table structure for fxy_financial_subject_template
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_subject_template`;
CREATE TABLE `fxy_financial_subject_template`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `accounting_standards` smallint NULL DEFAULT NULL,
  `encoding` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `last_update_time` datetime(0) NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `vat_type` smallint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_subject_template
-- ----------------------------
INSERT INTO `fxy_financial_subject_template` VALUES (1, 0, '4-4-4-2', NULL, '小企业会计准则 - 小规模纳税人', 0);
INSERT INTO `fxy_financial_subject_template` VALUES (2, 0, '4-3-2-2', NULL, '小企业会计准则 - 一般纳税人', 1);
INSERT INTO `fxy_financial_subject_template` VALUES (3, 1, '4-3-2-2', NULL, '企业会计准则 - 小规模纳税人', 0);
INSERT INTO `fxy_financial_subject_template` VALUES (4, 1, '4-3-2-2', NULL, '企业会计准则 - 一般纳税人', 1);
INSERT INTO `fxy_financial_subject_template` VALUES (5, 2, '4-2-2-2', NULL, '民间非营利组织会计制度 - 小规模纳税人', 0);
INSERT INTO `fxy_financial_subject_template` VALUES (6, 2, '4-2-2-2', NULL, '民间非营利组织会计制度 - 一般纳税人', 1);

-- ----------------------------
-- Table structure for fxy_financial_subject_template_items
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_subject_template_items`;
CREATE TABLE `fxy_financial_subject_template_items`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `auxiliary_accounting` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `balance` double NULL DEFAULT NULL,
  `balance_direction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `level` int NULL DEFAULT NULL,
  `mnemonic_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `parent_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `subject_template_id` int NULL DEFAULT NULL,
  `system_default` bit(1) NOT NULL DEFAULT b'1',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_subject_template_items
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_user
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_user`;
CREATE TABLE `fxy_financial_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `mobile` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '电话',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '密码',
  `union_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信 unionId',
  `open_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信 openId',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '昵称',
  `avatar_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '头像',
  `real_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '真实姓名',
  `account_sets_id` int NULL DEFAULT NULL,
  `create_date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `init_password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '默认密码',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱',
  `account_sets_num` int NOT NULL DEFAULT 1,
  `accounting_num` int NOT NULL DEFAULT 1,
  `expiration_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `fxy_financial_user_mobile_uindex`(`mobile`) USING BTREE,
  UNIQUE INDEX `fxy_financial_user_open_id_uindex`(`open_id`) USING BTREE,
  UNIQUE INDEX `fxy_financial_user_union_id_uindex`(`union_id`) USING BTREE,
  INDEX `fxy_financial_user_fxy_financial_account_sets_id_fk`(`account_sets_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_user
-- ----------------------------
INSERT INTO `fxy_financial_user` VALUES (1, '13456781004', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, '代码哥', 'https://yun.ch-cm.com/img/avatar.66caf070.png', 'Gson', 2, '2019-08-01 23:00:42', NULL, NULL, 1, 1, NULL);
INSERT INTO `fxy_financial_user` VALUES (2, '13924060407', 'b397a017547e0162ec61083ace25666962ffe554ad9a4e7b9e9bcab6a1bc560d', NULL, NULL, NULL, NULL, '13924060407', 3, '2022-12-23 07:35:54', '488905', NULL, 1, 1, NULL);
INSERT INTO `fxy_financial_user` VALUES (3, '13829766385', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, NULL, NULL, '13829766385', 4, '2022-12-24 05:37:31', '', NULL, 1, 1, NULL);
INSERT INTO `fxy_financial_user` VALUES (4, '13581832297', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, '账套管理员', NULL, '账套管理员2297', 6, '2022-12-26 01:36:14', '', NULL, 1, 1, NULL);
INSERT INTO `fxy_financial_user` VALUES (5, '17852803867', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, '查看', NULL, '查看3867', 2, '2022-12-26 03:01:25', '', NULL, 1, 1, NULL);
INSERT INTO `fxy_financial_user` VALUES (6, '15504726640', 'a58f746e56ff0c881408772272e2975b69d1a49b73ca9215004a3f77673eba41', NULL, NULL, NULL, NULL, 'GYK', NULL, '2022-12-30 17:22:46', '', 'gykvip@qq.coom', 1, 1, NULL);
INSERT INTO `fxy_financial_user` VALUES (7, '18098683479', '10da605006b17b07b194b3489af0d77b580bab589e14a3a2b3dc23a144fa973d', NULL, NULL, NULL, NULL, '18098683479', NULL, '2023-01-30 04:34:08', '687408', NULL, 1, 1, NULL);
INSERT INTO `fxy_financial_user` VALUES (8, '17663003502', '200788c323df9dde1abdce7022c52c6dd7cd02b82ef1e4ec3c58ca903ec8fc5e', NULL, NULL, NULL, NULL, '17663003502', NULL, '2023-02-01 12:12:17', '229498', NULL, 1, 1, NULL);

-- ----------------------------
-- Table structure for fxy_financial_user_account_sets
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_user_account_sets`;
CREATE TABLE `fxy_financial_user_account_sets`  (
  `account_sets_id` int NOT NULL,
  `user_id` int NOT NULL,
  `role_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '账套角色',
  `id` bigint NOT NULL,
  UNIQUE INDEX `fxy_financial_user_uix`(`account_sets_id`, `user_id`) USING BTREE,
  INDEX `fxy_financial_user_account_sets_fxy_financial_user_id_fk`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户关联的账套' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_user_account_sets
-- ----------------------------
INSERT INTO `fxy_financial_user_account_sets` VALUES (1, 1, 'Manager', 0);
INSERT INTO `fxy_financial_user_account_sets` VALUES (2, 1, 'Manager', 0);
INSERT INTO `fxy_financial_user_account_sets` VALUES (2, 4, 'Manager', 0);
INSERT INTO `fxy_financial_user_account_sets` VALUES (2, 5, 'View', 0);
INSERT INTO `fxy_financial_user_account_sets` VALUES (3, 2, 'Manager', 0);
INSERT INTO `fxy_financial_user_account_sets` VALUES (4, 3, 'Manager', 0);
INSERT INTO `fxy_financial_user_account_sets` VALUES (5, 1, 'Manager', 0);
INSERT INTO `fxy_financial_user_account_sets` VALUES (5, 4, 'Manager', 0);
INSERT INTO `fxy_financial_user_account_sets` VALUES (6, 4, 'Manager', 0);

-- ----------------------------
-- Table structure for fxy_financial_voucher
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_voucher`;
CREATE TABLE `fxy_financial_voucher`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `word` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '凭证字',
  `code` int NOT NULL,
  `remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  `receipt_num` int NOT NULL DEFAULT 0 COMMENT '附单据数量',
  `create_member` int NOT NULL COMMENT '制单人',
  `create_date` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `debit_amount` double NULL DEFAULT 0 COMMENT '借方总金额',
  `credit_amount` double NULL DEFAULT 0 COMMENT '贷方总金额',
  `account_sets_id` int NULL DEFAULT NULL,
  `voucher_year` int NULL DEFAULT NULL,
  `voucher_month` int NULL DEFAULT NULL,
  `voucher_date` date NOT NULL,
  `audit_member_id` int NULL DEFAULT NULL COMMENT '审核人 ID',
  `audit_member_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '审核人姓名',
  `audit_date` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
  `carry_forward` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否结转损益',
  `bill_list` json NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fxy_financial_voucher_account_sets_id_fk`(`account_sets_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '凭证' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_voucher
-- ----------------------------
INSERT INTO `fxy_financial_voucher` VALUES (1, '记', 1, '', 0, 1, '2022-12-23 09:43:23', 100, 100, 1, 2022, 11, '2022-11-30', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (2, '记', 1, '', 0, 1, '2022-12-25 11:41:29', 200, 200, 2, 2022, 12, '2022-12-31', 1, 'Gson', '2022-12-28 11:43:33', b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (3, '记', 1, '', 0, 1, '2022-12-25 11:53:59', 200, 200, 2, 2023, 1, '2023-01-31', 1, 'Gson', '2022-12-25 14:04:06', b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (4, '收', 1, '', 0, 1, '2022-12-25 11:57:28', 500, 500, 2, 2023, 1, '2023-01-31', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (5, '收', 2, '', 0, 1, '2022-12-25 11:58:19', 250, 250, 2, 2023, 1, '2023-01-31', 1, 'Gson', '2023-01-05 11:22:57', b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (6, '收', 1, '', 0, 1, '2022-12-25 12:00:20', 375, 375, 2, 2022, 12, '2022-12-25', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (7, '记', 2, '', 0, 1, '2022-12-25 14:50:26', 99, 99, 2, 2023, 1, '2023-01-31', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (8, '收', 2, '', 0, 1, '2022-12-25 14:52:26', 30, 30, 2, 2022, 12, '2022-12-25', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (9, '记', 3, '', 0, 1, '2022-12-25 14:57:46', 50, 50, 2, 2022, 12, '2022-12-25', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (10, '记', 2, '', 0, 1, '2022-12-25 15:00:36', 50, 50, 2, 2022, 12, '2022-12-26', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (11, '记', 4, '', 0, 1, '2022-12-26 11:51:09', 90, 90, 2, 2022, 12, '2022-12-26', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (12, '付', 1, '', 0, 1, '2022-12-26 11:52:42', 99, 99, 2, 2022, 12, '2022-12-26', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (13, '记', 1, '', 0, 1, '2022-12-26 11:59:31', 10, 10, 2, 2023, 2, '2023-02-01', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (14, '记', 2, '', 0, 1, '2022-12-26 13:59:37', 11, 11, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (15, '收', 1, '', 0, 1, '2022-12-26 14:01:37', 12, 12, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (16, '付', 1, '', 0, 1, '2022-12-26 14:02:16', 13, 13, 2, 2023, 2, '2023-02-28', 1, 'Gson', '2023-01-31 10:33:58', b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (18, '记', 3, '', 0, 1, '2022-12-28 11:37:14', 1, 1, 2, 2023, 2, '2023-02-28', 1, 'Gson', '2022-12-28 11:40:26', b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (19, '记', 4, '', 0, 1, '2022-12-28 14:12:44', 35, 35, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (20, '记', 5, '', 0, 1, '2022-12-28 14:14:57', 50, 50, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (21, '记', 6, '', 0, 1, '2022-12-28 14:18:34', 70, 70, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (22, '付', 2, '', 0, 1, '2022-12-28 14:26:00', 90, 90, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (23, '转', 1, '', 0, 1, '2022-12-28 14:35:23', 88, 88, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (24, '记', 7, '', 0, 1, '2022-12-28 14:42:55', 50, 50, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (25, '收', 2, '', 0, 1, '2022-12-28 14:47:52', 100, 100, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (26, '记', 8, '', 0, 1, '2022-12-28 14:57:20', 100, 100, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (29, '记', 9, '', 0, 1, '2022-12-31 16:43:53', 100, 100, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (30, '记', 5, '', 0, 1, '2023-01-01 17:42:16', 200, 200, 2, 2022, 12, '2022-12-31', NULL, NULL, NULL, b'1', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (31, '收', 1, '', 0, 1, '2023-01-02 16:10:24', 100, 100, 1, 2022, 11, '2022-11-30', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (32, '记', 2, '', 0, 1, '2023-01-05 16:33:30', 2, 2, 1, 2022, 11, '2022-11-30', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (33, '记', 1, '', 0, 4, '2023-01-06 09:15:30', 1200, 1200, 6, 2022, 12, '2022-12-31', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (34, '记', 1, '', 0, 1, '2023-01-09 23:21:00', 10, 10, 5, 2023, 1, '2023-01-31', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (35, '记', 2, '', 0, 1, '2023-01-10 00:35:08', 1, 1, 5, 2023, 1, '2023-01-31', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (36, '记', 10, '', 0, 1, '2023-01-12 11:00:26', 300, 300, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (37, '付', 1, '', 0, 1, '2023-01-12 11:04:22', 1000, 1000, 2, 2023, 1, '2023-01-07', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (38, '记', 1, '', 0, 1, '2023-01-16 21:14:18', 222, 222, 1, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (39, '记', 2, '', 0, 4, '2023-01-28 17:45:47', 12, 12, 6, 2022, 12, '2022-12-31', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (40, '记', 3, '', 0, 4, '2023-01-28 17:47:01', 12, 12, 6, 2022, 12, '2022-12-31', NULL, NULL, NULL, b'0', NULL);
INSERT INTO `fxy_financial_voucher` VALUES (41, '记', 11, '', 0, 1, '2023-02-01 20:15:20', 100, 100, 2, 2023, 2, '2023-02-28', NULL, NULL, NULL, b'0', NULL);

-- ----------------------------
-- Table structure for fxy_financial_voucher_details
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_voucher_details`;
CREATE TABLE `fxy_financial_voucher_details`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `voucher_id` int NULL DEFAULT NULL,
  `summary` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '摘要',
  `subject_id` int NOT NULL,
  `subject_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `subject_code` varchar(56) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `debit_amount` double NULL DEFAULT NULL COMMENT '借方金额',
  `credit_amount` double NULL DEFAULT NULL COMMENT '贷方金额',
  `auxiliary_title` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '辅助名称',
  `num` double NULL DEFAULT NULL COMMENT '数量',
  `price` double NULL DEFAULT NULL COMMENT '单价',
  `account_sets_id` int NULL DEFAULT NULL,
  `cumulative_debit` double NULL DEFAULT NULL COMMENT '期初累计借方',
  `cumulative_credit` double NULL DEFAULT NULL COMMENT '期初累计贷方',
  `cumulative_debit_num` double NULL DEFAULT NULL,
  `cumulative_credit_num` double NULL DEFAULT NULL,
  `carry_forward` bit(1) NOT NULL DEFAULT b'0' COMMENT '结转损益',
  `currency_id` int NULL DEFAULT NULL,
  `currency_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `exchange_rate` double NULL DEFAULT NULL,
  `original_amount` double NULL DEFAULT NULL,
  `voucher_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fxy_financial_voucher_details_fxy_financial_subject_id_fk`(`subject_id`) USING BTREE,
  INDEX `fxy_financial_voucher_details_fxy_financial_voucher_id_fk`(`voucher_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 126 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '凭证' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_voucher_details
-- ----------------------------
INSERT INTO `fxy_financial_voucher_details` VALUES (3, NULL, '期初', 484, '1001-库存现金', '1001', NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (4, 2, '第12期结转销售成本', 340, '1405-库存商品', '1405', NULL, 100, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (5, 2, '第12期结转销售成本', 433, '5401-主营业务成本', '5401', 200, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (6, 2, '提现', 323, '1001-库存现金', '1001', NULL, 100, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (7, 3, '提现', 323, '1001-库存现金', '1001', 100, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (8, 3, '利息收入', 324, '1002-银行存款', '1002', 100, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (9, 3, '购入固定资产', 323, '1001-库存现金', '1001', NULL, 100, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (10, 3, '购入固定资产', 324, '1002-银行存款', '1002', NULL, 100, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (11, 4, '提现', 323, '1001-库存现金', '1001', 500, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (12, 4, '利息收入', 324, '1002-银行存款', '1002', NULL, 500, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (13, 5, '提现', 323, '1001-库存现金', '1001', 250, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (14, 5, '利息收入', 324, '1002-银行存款', '1002', NULL, 250, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (15, 6, '提现', 323, '1001-库存现金', '1001', 375, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (16, 6, '利息收入', 324, '1002-银行存款', '1002', NULL, 375, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (17, 7, '提现', 324, '1002-银行存款', '1002', 99, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (18, 7, '购入固定资产', 324, '1002-银行存款', '1002', NULL, 99, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (19, 8, '利息收入', 323, '1001-库存现金', '1001', 30, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (20, 8, '提现', 323, '1001-库存现金', '1001', NULL, 30, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (21, 9, '支付货款', 323, '1001-库存现金', '1001', 50, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (22, 9, '提现', 324, '1002-银行存款', '1002', NULL, 50, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (23, 10, '提现', 323, '1001-库存现金', '1001', 50, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (24, 10, '利息收入', 325, '1012-其他货币资金', '1012', NULL, 50, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (25, 11, '提现', 323, '1001-库存现金', '1001', 90, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (26, 11, '提现', 324, '1002-银行存款', '1002', NULL, 90, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (27, 12, '提现', 323, '1001-库存现金', '1001', 99, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (28, 12, '提现', 323, '1001-库存现金', '1001', NULL, 99, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (29, 13, '提现', 323, '1001-库存现金', '1001', 10, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (30, 13, '提现', 323, '1001-库存现金', '1001', NULL, 10, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (31, 14, '利息收入', 323, '1001-库存现金', '1001', 11, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (32, 14, '利息收入', 324, '1002-银行存款', '1002', NULL, 11, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (33, 15, '提现', 324, '1002-银行存款', '1002', 12, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (34, 15, '利息收入', 324, '1002-银行存款', '1002', NULL, 12, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (35, 16, '提现', 323, '1001-库存现金', '1001', 13, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (36, 16, '提现', 324, '1002-银行存款', '1002', NULL, 13, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (37, NULL, '期初', 332, '1123-预付账款', '1123', 100, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (38, NULL, '期初', 330, '1121-应收票据', '1121', 0, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (39, NULL, '期初', 328, '1101002-债券', '1101002', 100, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (40, NULL, '期初', 324, '1002-银行存款', '1002', 0, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (41, NULL, '期初', 325, '1012-其他货币资金', '1012', 100, NULL, NULL, NULL, NULL, 2, 100, 100, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (42, NULL, '期初', 323, '1001-库存现金', '1001', 0, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (43, NULL, '期初', 327, '1101001-股票', '1101001', 100, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (44, NULL, '期初', 329, '1101003-基金', '1101003', 0, NULL, NULL, NULL, NULL, 2, 100, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (45, NULL, '期初', 331, '1122-应收账款', '1122', 100, NULL, NULL, NULL, NULL, 2, 50, 50, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (46, NULL, '期初', 425, '5001-主营业务收入', '5001', NULL, 0, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (47, NULL, '期初', 337, '1402-在途物资', '1402', NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (48, NULL, '期初', 339, '1404-材料成本差异', '1404', NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (49, NULL, '期初', 808, '1012-其他货币资金', '1012', NULL, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (50, NULL, '期初', 807, '1002-银行存款', '1002', 35, NULL, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (51, NULL, '期初', 426, '5051-其他业务收入', '5051', NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (52, NULL, '期初', 427, '5111-投资收益', '5111', NULL, 70, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (53, NULL, '期初', 429, '5301001-非流动资产处置净收益', '5301001', NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (54, NULL, '期初', 1128, '1001001-测试111', '1001001', NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (55, NULL, '期初', 1129, '100100101-测试345', '100100101', 200, NULL, NULL, NULL, NULL, 2, 100, 100, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (56, NULL, '期初', 1130, '1701001-测试321', '1701001', 0, NULL, NULL, NULL, NULL, 2, 100, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (59, NULL, '期初', 435, '5403-税金及附加', '5403', 80, NULL, NULL, NULL, NULL, 2, NULL, 80, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (60, 18, '利息收入', 325, '1012-其他货币资金', '1012', 1, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (61, 18, '第12期结转销售成本', 324, '1002-银行存款', '1002', NULL, 1, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (62, 19, '提现', 1129, '100100101-库存现金-测试111-测试345', '100100101', 35, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (63, 19, '提现', 324, '1002-银行存款', '1002', NULL, 35, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (64, 20, '提现', 435, '5403-税金及附加', '5403', 50, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (65, 20, '提现', 325, '1012-其他货币资金', '1012', NULL, 50, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (66, 21, '提现', 435, '5403-税金及附加', '5403', 70, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (67, 21, '期初', 327, '1101001-短期投资-股票', '1101001', NULL, 70, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (68, 22, '期初', 435, '5403-税金及附加', '5403', 90, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (69, 22, '购入固定资产', 335, '1221-其他应收款', '1221', NULL, 90, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (70, 23, '支付银行手续费', 435, '5403-税金及附加', '5403', 88, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (71, 23, '报销销售人员的业务招待费', 370, '222100106-应交税费-应交增值税-出口退税', '222100106', NULL, 88, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (72, 24, '购入固定资产', 427, '5111-投资收益', '5111', NULL, 50, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (73, 24, '支付货款', 324, '1002-银行存款', '1002', 50, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (74, 25, '利息收入', 427, '5111-投资收益', '5111', NULL, 100, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (75, 25, '利息收入', 324, '1002-银行存款', '1002', 100, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (76, 26, '期初', 330, '1121-应收票据', '1121', 100, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (77, 26, '提现', 347, '1601-固定资产', '1601', NULL, 100, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (78, 27, '支付银行手续费', 810, '110101-短期投资-股票', '110101', 125, NULL, '', NULL, NULL, 5, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (79, 27, '支付银行手续费', 808, '1012-其他货币资金', '1012', NULL, 125, '', NULL, NULL, 5, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (80, 28, '提现', 819, '1401-材料采购', '1401', 22, NULL, '', NULL, NULL, 5, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (81, 28, '利息收入', 808, '1012-其他货币资金', '1012', NULL, 22, '', NULL, NULL, 5, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (82, NULL, '期初', 968, '1002-银行存款', '1002', NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (83, 29, '期初', 1129, '100100101-库存现金-测试111-测试345', '100100101', 100, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (84, 29, '利息收入', 327, '1101001-短期投资-股票', '1101001', NULL, 100, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (85, 30, '第12期结转损益', 412, '3103-本年利润', '3103', 200, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (86, 30, '第12期结转损益', 433, '5401-主营业务成本', '5401', NULL, 200, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (91, 31, '利息收入', 162, '1001-库存现金', '1001', 100, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (92, 31, '利息收入', 162, '1001-库存现金', '1001', NULL, 100, '', NULL, NULL, 1, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (93, NULL, '期初', 333, '1131-应收股利', '1131', 100, NULL, NULL, NULL, NULL, 2, 100, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (94, NULL, '期初', 365, '222100101-进项税额', '222100101', NULL, 100, NULL, NULL, NULL, 2, 100, 200, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (95, NULL, '期初', 366, '222100102-已交税金', '222100102', NULL, 100, NULL, NULL, NULL, 2, 0, 0, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (96, NULL, '期初', 367, '222100103-转出未交增值税', '222100103', NULL, 100, NULL, NULL, NULL, 2, 0, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (97, NULL, '期初', 368, '222100104-减免税款', '222100104', NULL, 100, NULL, NULL, NULL, 2, 0, 0, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (98, NULL, '期初', 369, '222100105-销项税额', '222100105', NULL, 0, NULL, NULL, NULL, 2, 0, 0, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (99, NULL, '期初', 1131, '110100201-11111', '110100201', NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (100, NULL, '期初', 1133, '110100101-11111', '110100101', NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (101, NULL, '期初', 375, '2221002-未交增值税', '2221002', NULL, 100, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (104, 32, '提现', 170, '1122-应收账款', '1122', NULL, 2, '_321_测试客户_011_供应商1_001_职员_001_部门', NULL, NULL, 1, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (105, 32, '提现', 164, '1012-其他货币资金', '1012', 2, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (106, 33, '购入固定资产', 967, '1001-库存现金', '1001', 1200, NULL, '', NULL, NULL, 6, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (107, 33, '支付银行手续费', 971, '110101-短期投资-股票', '110101', NULL, 1200, '', NULL, NULL, 6, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (108, 34, '支付银行手续费', 950, '560301-财务费用-利息费用', '560301', 10, NULL, '', NULL, NULL, 5, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (109, 34, '支付银行手续费', 807, '1002-银行存款', '1002', NULL, 10, '', NULL, NULL, 5, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (110, 35, '1', 807, '1002-银行存款', '1002', 1, NULL, '', NULL, NULL, 5, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (111, 35, '1', 810, '110101-短期投资-股票', '110101', NULL, 1, '', NULL, NULL, 5, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (112, 36, '利息收入', 324, '1002-银行存款', '1002', 300, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (113, 36, '报销销售人员的业务招待费', 330, '1121-应收票据', '1121', NULL, 300, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (114, 37, '支付货款', 332, '1123-预付账款', '1123', 1000, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (115, 37, '利息收入', 1129, '100100101-库存现金-测试111-测试345', '100100101', NULL, 1000, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (116, 1, '利息收入', 163, '1002-银行存款', '1002', 100, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (117, 1, '提现', 163, '1002-银行存款', '1002', NULL, 100, '', NULL, NULL, 1, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (118, 38, '提现', 162, '1001-库存现金', '1001', 222, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (119, 38, '支付货款', 163, '1002-银行存款', '1002', NULL, 222, '', NULL, NULL, 1, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (120, 39, '购入固定资产', 1135, '100101-库存现金-XXXX', '100101', 12, NULL, '', NULL, NULL, 6, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (121, 39, '提现', 968, '1002-银行存款', '1002', NULL, 12, '', NULL, NULL, 6, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (122, 40, '购入固定资产', 1136, '100102-库存现金-DDD', '100102', 12, NULL, '', NULL, NULL, 6, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (123, 40, '提现', 969, '1012-其他货币资金', '1012', NULL, 12, '', NULL, NULL, 6, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (124, 41, '利息收入', 325, '1012-其他货币资金', '1012', 100, NULL, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_voucher_details` VALUES (125, 41, '利息收入', 325, '1012-其他货币资金', '1012', NULL, 100, '', NULL, NULL, 2, NULL, NULL, NULL, NULL, b'0', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for fxy_financial_voucher_details_auxiliary
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_voucher_details_auxiliary`;
CREATE TABLE `fxy_financial_voucher_details_auxiliary`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `voucher_details_id` int NULL DEFAULT NULL COMMENT '凭证明细 Id',
  `accounting_category_id` int NULL DEFAULT NULL COMMENT '辅助类型 id',
  `accounting_category_details_id` int NULL DEFAULT NULL COMMENT '辅助项值 Id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `accounting_category_id_fk`(`accounting_category_id`) USING BTREE,
  INDEX `details_id_fk`(`accounting_category_details_id`) USING BTREE,
  INDEX `voucher_details_id_fk`(`voucher_details_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '凭证辅助项关联' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_voucher_details_auxiliary
-- ----------------------------
INSERT INTO `fxy_financial_voucher_details_auxiliary` VALUES (1, 102, 8, 3);
INSERT INTO `fxy_financial_voucher_details_auxiliary` VALUES (2, 104, 8, 3);
INSERT INTO `fxy_financial_voucher_details_auxiliary` VALUES (3, 104, 9, 4);
INSERT INTO `fxy_financial_voucher_details_auxiliary` VALUES (4, 104, 10, 5);
INSERT INTO `fxy_financial_voucher_details_auxiliary` VALUES (5, 104, 11, 6);

-- ----------------------------
-- Table structure for fxy_financial_voucher_template
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_voucher_template`;
CREATE TABLE `fxy_financial_voucher_template`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '模板名称',
  `is_default` bit(1) NOT NULL DEFAULT b'0',
  `type` tinyint NOT NULL,
  `account_sets_id` int NOT NULL,
  `debit_amount` double NULL DEFAULT 0,
  `credit_amount` double NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `faas_sss`(`account_sets_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '凭证模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_voucher_template
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_voucher_template_details
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_voucher_template_details`;
CREATE TABLE `fxy_financial_voucher_template_details`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `voucher_template_id` int NOT NULL,
  `summary` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '摘要',
  `subject_id` int NULL DEFAULT NULL,
  `subject_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '科目名称',
  `debit_amount` double NULL DEFAULT NULL COMMENT '借方金额',
  `credit_amount` double NULL DEFAULT NULL COMMENT '贷方金额',
  `account_sets_id` int NULL DEFAULT NULL,
  `subject_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `auxiliary_title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fxy_financial_voucher_details_subject_id_fk`(`subject_id`) USING BTREE,
  INDEX `fxy_financial_voucher_details_voucher_template_id_fk`(`voucher_template_id`) USING BTREE,
  INDEX `fxy_financial_vouchnt_sets_id_fk`(`account_sets_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '凭证模板明细' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_voucher_template_details
-- ----------------------------

-- ----------------------------
-- Table structure for fxy_financial_voucher_word
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_voucher_word`;
CREATE TABLE `fxy_financial_voucher_word`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `word` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '凭证字',
  `print_title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '打印标题',
  `is_default` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否默认',
  `account_sets_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `fxy_financial_voucher_word_word_account_sets_id_uindex`(`word`, `account_sets_id`) USING BTREE,
  INDEX `fxy_financial_voucher_word_fxy_financial_account_sets_id_fk`(`account_sets_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '凭证字' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fxy_financial_voucher_word
-- ----------------------------
INSERT INTO `fxy_financial_voucher_word` VALUES (1, '记', '记账凭证', b'1', 1);
INSERT INTO `fxy_financial_voucher_word` VALUES (2, '收', '收款凭证', b'0', 1);
INSERT INTO `fxy_financial_voucher_word` VALUES (3, '付', '付款凭证', b'0', 1);
INSERT INTO `fxy_financial_voucher_word` VALUES (4, '转', '转账凭证', b'0', 1);
INSERT INTO `fxy_financial_voucher_word` VALUES (5, '记', '记账凭证', b'1', 2);
INSERT INTO `fxy_financial_voucher_word` VALUES (6, '收', '收款凭证', b'0', 2);
INSERT INTO `fxy_financial_voucher_word` VALUES (7, '付', '付款凭证', b'0', 2);
INSERT INTO `fxy_financial_voucher_word` VALUES (8, '转', '转账凭证', b'0', 2);
INSERT INTO `fxy_financial_voucher_word` VALUES (9, '记', '记账凭证', b'1', 3);
INSERT INTO `fxy_financial_voucher_word` VALUES (10, '收', '收款凭证', b'0', 3);
INSERT INTO `fxy_financial_voucher_word` VALUES (11, '付', '付款凭证', b'0', 3);
INSERT INTO `fxy_financial_voucher_word` VALUES (12, '转', '转账凭证', b'0', 3);
INSERT INTO `fxy_financial_voucher_word` VALUES (13, '记', '记账凭证', b'1', 4);
INSERT INTO `fxy_financial_voucher_word` VALUES (14, '收', '收款凭证', b'0', 4);
INSERT INTO `fxy_financial_voucher_word` VALUES (15, '付', '付款凭证', b'0', 4);
INSERT INTO `fxy_financial_voucher_word` VALUES (16, '转', '转账凭证', b'0', 4);
INSERT INTO `fxy_financial_voucher_word` VALUES (17, '记', '记账凭证', b'1', 5);
INSERT INTO `fxy_financial_voucher_word` VALUES (18, '收', '收款凭证', b'0', 5);
INSERT INTO `fxy_financial_voucher_word` VALUES (19, '付', '付款凭证', b'0', 5);
INSERT INTO `fxy_financial_voucher_word` VALUES (20, '转', '转账凭证', b'0', 5);
INSERT INTO `fxy_financial_voucher_word` VALUES (21, '记', '记账凭证', b'1', 6);
INSERT INTO `fxy_financial_voucher_word` VALUES (22, '收', '收款凭证', b'0', 6);
INSERT INTO `fxy_financial_voucher_word` VALUES (23, '付', '付款凭证', b'0', 6);
INSERT INTO `fxy_financial_voucher_word` VALUES (24, '转', '转账凭证', b'0', 6);

SET FOREIGN_KEY_CHECKS = 1;
