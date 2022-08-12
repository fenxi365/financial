/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : localhost:3306
 Source Schema         : financial

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 12/02/2022 20:53:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fxy_financial_account_sets
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_account_sets`;
CREATE TABLE `fxy_financial_account_sets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(256) COLLATE utf8mb4_bin NOT NULL COMMENT '单位名称',
  `enable_date` date NOT NULL COMMENT '账套启用年月',
  `credit_code` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '统一社会信用代码',
  `accounting_standards` smallint(6) NOT NULL COMMENT '0.企业会计准则、1.企业会计准则、2.民间非营利组织会计制度',
  `address` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '单位所在地',
  `cashier_module` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否启用出纳模块',
  `industry` smallint(6) DEFAULT NULL COMMENT '行业',
  `fixed_asset_module` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否启用固定资产模块',
  `vat_type` smallint(6) NOT NULL DEFAULT '0' COMMENT '增值税种类\n0.小规模纳税人、1.一般纳税人',
  `voucher_reviewed` tinyint(4) NOT NULL DEFAULT '0' COMMENT '凭证是否需要审核',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator_id` int(11) NOT NULL COMMENT '创建人',
  `current_account_date` date DEFAULT NULL COMMENT '当前记账年月',
  `encoding` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '4-2-2-2',
  `parent_id` int(11) DEFAULT NULL COMMENT '父账套',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `fxy_financial_account_sets_creator_id_company_name_uindex` (`creator_id`,`company_name`) USING BTREE,
  KEY `fxy_financial_account_sets_fxy_financial_account_sets_id_fk` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='账套';

-- ----------------------------
-- Records of fxy_financial_account_sets
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_account_sets` VALUES (73, '杭州财汇', '2019-11-01', '', 0, NULL, 0, NULL, 0, 0, 0, '2019-11-06 12:42:22', 1, '2019-12-31', '4-2-2-2', NULL);
INSERT INTO `fxy_financial_account_sets` VALUES (74, '银泰店', '2017-04-01', '', 0, NULL, 0, NULL, 0, 0, 0, '2019-11-06 00:00:00', 1, '2019-10-31', '4-2-2-2', 73);
INSERT INTO `fxy_financial_account_sets` VALUES (75, '慈溪店', '2017-12-01', '', 0, NULL, 0, NULL, 0, 0, 0, '2019-11-07 14:27:32', 1, '2017-12-01', '4-2-2-2', 73);
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_account_sets_classified
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_account_sets_classified`;
CREATE TABLE `fxy_financial_account_sets_classified` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_sets_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fxy_financial_account]_sets_id_fk` (`account_sets_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='账套属性';

-- ----------------------------
-- Records of fxy_financial_account_sets_classified
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_account_sets_classified` VALUES (14, 74, 1, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_account_sets_classified` VALUES (15, 75, 1, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_accounting_category
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_accounting_category`;
CREATE TABLE `fxy_financial_accounting_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_bin NOT NULL COMMENT '辅助核算类别名称',
  `custom_columns` varchar(512) COLLATE utf8mb4_bin DEFAULT NULL,
  `system_default` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否为系统默认',
  `account_sets_id` int(11) DEFAULT NULL,
  `can_edit` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `fxy_financial_accounting category_account_sets_id_name_uindex` (`account_sets_id`,`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=409 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='核算类别';

-- ----------------------------
-- Records of fxy_financial_accounting_category
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_accounting_category` VALUES (379, 'sss', '', b'0', NULL, b'1');
INSERT INTO `fxy_financial_accounting_category` VALUES (388, '客户', '助记码,客户类别,经营地址,联系人,手机,税号', b'1', 73, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (389, '供应商', '助记码,供应商类别,经营地址,联系人,手机,税号', b'1', 73, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (390, '职员', '助记码,性别,部门编码,部门名称,职务,岗位,手机,出生日期,入职日期,离职日期', b'1', 73, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (391, '部门', '助记码,负责人,手机,成立日期,撤销日期', b'1', 73, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (392, '项目', '助记码,负责部门,负责人,手机,开始日期,验收日期', b'1', 73, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (393, '存货', '助记码,规格型号,存货类别,计量单位,启用日期,停用日期', b'1', 73, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (394, '现金流', '现金流类别,助记码', b'1', 73, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (395, '客户', '助记码,客户类别,经营地址,联系人,手机,税号', b'1', 74, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (396, '供应商', '助记码,供应商类别,经营地址,联系人,手机,税号', b'1', 74, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (397, '职员', '助记码,性别,部门编码,部门名称,职务,岗位,手机,出生日期,入职日期,离职日期', b'1', 74, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (398, '部门', '助记码,负责人,手机,成立日期,撤销日期', b'1', 74, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (399, '项目', '助记码,负责部门,负责人,手机,开始日期,验收日期', b'1', 74, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (400, '存货', '助记码,规格型号,存货类别,计量单位,启用日期,停用日期', b'1', 74, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (401, '现金流', '现金流类别,助记码', b'1', 74, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (402, '客户', '助记码,客户类别,经营地址,联系人,手机,税号', b'1', 75, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (403, '供应商', '助记码,供应商类别,经营地址,联系人,手机,税号', b'1', 75, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (404, '职员', '助记码,性别,部门编码,部门名称,职务,岗位,手机,出生日期,入职日期,离职日期', b'1', 75, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (405, '部门', '助记码,负责人,手机,成立日期,撤销日期', b'1', 75, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (406, '项目', '助记码,负责部门,负责人,手机,开始日期,验收日期', b'1', 75, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (407, '存货', '助记码,规格型号,存货类别,计量单位,启用日期,停用日期', b'1', 75, b'0');
INSERT INTO `fxy_financial_accounting_category` VALUES (408, '现金流', '现金流类别,助记码', b'1', 75, b'0');
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_accounting_category_details
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_accounting_category_details`;
CREATE TABLE `fxy_financial_accounting_category_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '编码',
  `name` varchar(128) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `remark` varchar(512) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  `enable` bit(1) NOT NULL DEFAULT b'1' COMMENT '是否启用',
  `accounting_category_id` int(11) DEFAULT NULL,
  `cus_column_0` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_1` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_2` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_3` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_4` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_5` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_6` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_7` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_8` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_9` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_10` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_11` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_12` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_13` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_14` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `cus_column_15` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `fxy_financial_category_details_category_id_code_uindex` (`accounting_category_id`,`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='辅助核算类别明细列表';

-- ----------------------------
-- Records of fxy_financial_accounting_category_details
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_accounting_category_details` VALUES (1, '1', '陈林', '', b'1', 397, '', '男', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (2, '2', '伍丁蒙', '', b'1', 397, '', '女', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (3, '3', '任徐侠', '', b'1', 397, '', '女', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (4, '4', '朱洪平', '', b'1', 397, '', '女', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (5, '5', '许田科', '', b'1', 397, '', '女', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (6, '6', '董良峰', '', b'1', 397, '', '女', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (7, '7', '吴莹雯', '', b'1', 397, '', '女', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (8, '8', '鲍', '', b'1', 397, '', '女', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (9, '9', '马翠梅', '', b'1', 397, '', '女', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (10, '10', '章总', '', b'1', 397, '', '女', '', '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (11, '1', '慈溪银泰商业管理有限公司', '', b'1', 395, '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (12, '2', '旧巷南总部', '', b'1', 395, '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `fxy_financial_accounting_category_details` VALUES (13, '3', '一点点奶茶', '', b'1', 395, '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_admin_report_template
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_admin_report_template`;
CREATE TABLE `fxy_financial_admin_report_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `template_key` varchar(128) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '报表类型：0普通报表，1资产报表',
  `classified_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `account_sets_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `fxy_financial_admin_report_template_user_id_template_key_uindex` (`user_id`,`template_key`) USING BTREE,
  KEY `fxy_financial_admin_report_template_account_sets__fk` (`account_sets_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fxy_financial_admin_report_template
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_admin_report_template` VALUES (3, '利润报表', 'lrbb', 0, NULL, 1, 73);
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_admin_report_template_items
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_admin_report_template_items`;
CREATE TABLE `fxy_financial_admin_report_template_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) NOT NULL,
  `title` varchar(256) NOT NULL COMMENT '标题',
  `parent_id` int(11) DEFAULT NULL,
  `line_num` int(11) NOT NULL DEFAULT '-1' COMMENT '行次',
  `type` int(11) DEFAULT NULL COMMENT '资产负载类型时需要设置\n0,资产 1,负债 2，所有者权益',
  `sources` int(11) NOT NULL DEFAULT '0' COMMENT '取数来原:0,表外公式,1,表内公式',
  `level` int(11) NOT NULL DEFAULT '1' COMMENT '层级',
  `is_bolder` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否加粗标题',
  `is_folding` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否可以折叠',
  `is_classified` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否是归类项，归类项没有行号',
  `pos` int(11) NOT NULL DEFAULT '1' COMMENT '显示位置',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fxy_template_id_fk` (`template_id`) USING BTREE,
  KEY `fxy_admin_relate_items_id_fk` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fxy_financial_admin_report_template_items
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (14, 2, '一、营业收入', NULL, 1, 0, 0, 1, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (15, 2, '微信', 14, 2, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (16, 2, '支付宝', 14, 3, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (17, 2, '现金', 14, 4, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (18, 2, '二、原料成本', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (19, 2, '水果', 18, 6, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (20, 2, '包装', 18, 7, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (21, 2, '物料', 18, 8, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (22, 2, '三、毛利润', NULL, 9, 0, 0, 1, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (23, 2, '四、营业费用', NULL, 10, 0, 0, 1, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (24, 2, '商场租金', 23, 11, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (25, 2, '物业费', 23, 12, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (26, 2, '水电费', 23, 13, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (27, 2, '宽带', 23, 14, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (28, 2, '易耗品', 23, 15, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (29, 2, '广告费', 23, 16, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (30, 3, '一、营业收入', NULL, 1, 0, 0, 1, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (31, 3, '微信', 30, 2, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (32, 3, '支付宝', 30, 3, 0, 0, 2, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_admin_report_template_items` VALUES (33, 3, '现金', 30, 4, 0, 0, 2, b'0', b'0', b'0', 1);
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_admin_report_template_items_formula
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_admin_report_template_items_formula`;
CREATE TABLE `fxy_financial_admin_report_template_items_formula` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) NOT NULL COMMENT '模板 id',
  `template_items_id` int(11) NOT NULL,
  `account_sets_id` int(11) NOT NULL,
  `calculation` enum('+','-','*','/') NOT NULL DEFAULT '+' COMMENT '计算方式',
  `access_rules` int(11) NOT NULL COMMENT '取数规则：0,净发生额度 1,借方发生额 2,贷方发生额',
  `from_tag` varchar(125) NOT NULL COMMENT '数据来源标识',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fxy_ataa_fk` (`account_sets_id`) USING BTREE,
  KEY `fxy_iftss_fk` (`template_id`) USING BTREE,
  KEY `fxy_tifaas_fk` (`template_items_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='模板项公式表';

-- ----------------------------
-- Records of fxy_financial_admin_report_template_items_formula
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_admin_report_template_items_formula` VALUES (1, 3, 30, 73, '+', 0, '10386');
INSERT INTO `fxy_financial_admin_report_template_items_formula` VALUES (2, 3, 30, 73, '+', 0, '10547');
INSERT INTO `fxy_financial_admin_report_template_items_formula` VALUES (3, 3, 30, 73, '+', 0, '10548');
INSERT INTO `fxy_financial_admin_report_template_items_formula` VALUES (4, 3, 31, 73, '+', 0, '10547');
INSERT INTO `fxy_financial_admin_report_template_items_formula` VALUES (5, 3, 32, 73, '+', 0, '10548');
INSERT INTO `fxy_financial_admin_report_template_items_formula` VALUES (6, 3, 33, 73, '+', 0, '10386');
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_checkout
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_checkout`;
CREATE TABLE `fxy_financial_checkout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_sets_id` int(11) DEFAULT NULL,
  `check_year` int(11) DEFAULT NULL,
  `check_month` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0,未结转损益、未结账,1,已结转损益、未结账,2,已结转损益、已结账',
  `check_date` date DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fxy_financial_checkout_account_sets_id_fk` (`account_sets_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='期末结转';

-- ----------------------------
-- Records of fxy_financial_checkout
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_checkout` VALUES (91, 73, 2019, 11, 2, '2019-11-01');
INSERT INTO `fxy_financial_checkout` VALUES (92, 74, 2017, 4, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (93, 74, 2017, 7, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (94, 74, 2017, 8, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (95, 74, 2017, 9, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (96, 74, 2017, 10, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (97, 74, 2017, 11, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (98, 74, 2017, 12, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (99, 74, 2018, 1, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (100, 74, 2018, 2, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (101, 74, 2018, 3, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (102, 74, 2018, 4, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (103, 74, 2018, 5, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (104, 74, 2018, 6, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (105, 74, 2018, 7, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (106, 74, 2018, 8, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (107, 74, 2018, 9, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (108, 74, 2018, 10, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (109, 74, 2018, 11, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (110, 74, 2018, 12, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (111, 74, 2019, 1, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (112, 74, 2019, 2, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (113, 74, 2019, 3, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (114, 74, 2019, 4, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (115, 74, 2019, 5, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (116, 74, 2019, 6, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (117, 74, 2019, 7, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (118, 74, 2019, 8, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (119, 74, 2019, 9, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (120, 74, 2019, 10, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (121, 75, 2017, 12, 0, NULL);
INSERT INTO `fxy_financial_checkout` VALUES (122, 73, 2019, 12, 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_classified
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_classified`;
CREATE TABLE `fxy_financial_classified` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type` enum('分组','品牌','区域','商圈') COLLATE utf8mb4_bin NOT NULL DEFAULT '分组',
  `title` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '标题',
  `level` tinyint(4) NOT NULL DEFAULT '1' COMMENT '层级',
  `pos` smallint(6) NOT NULL DEFAULT '0' COMMENT '排序标识',
  `xpath` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '树形路径',
  `parent_id` int(11) DEFAULT NULL COMMENT '上级ID',
  `account_sets_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fxy_financial_classified_account_sets_id_fk` (`account_sets_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='账套归类';

-- ----------------------------
-- Records of fxy_financial_classified
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_currency
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_currency`;
CREATE TABLE `fxy_financial_currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(12) COLLATE utf8mb4_bin NOT NULL COMMENT '编码 ',
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '名称 ',
  `exchange_rate` double NOT NULL COMMENT '汇率 ',
  `local_currency` bit(1) DEFAULT b'0' COMMENT '是否本位币',
  `account_sets_id` int(11) NOT NULL COMMENT '所属账套',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `fxy_financial_currency_account_sets_id_code_uindex` (`account_sets_id`,`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='币别';

-- ----------------------------
-- Records of fxy_financial_currency
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_currency` VALUES (65, 'RMB', '人民币', 1, b'1', 73);
INSERT INTO `fxy_financial_currency` VALUES (66, 'RMB', '人民币', 1, b'1', 74);
INSERT INTO `fxy_financial_currency` VALUES (67, 'RMB', '人民币', 1, b'1', 75);
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_report_template
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_report_template`;
CREATE TABLE `fxy_financial_report_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `account_sets_id` int(11) DEFAULT NULL,
  `template_key` varchar(128) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '报表类型：0普通报表，1资产报表',
  `is_default` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `fxy_report_template_account_sets_id_template_key_uindex` (`account_sets_id`,`template_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fxy_financial_report_template
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_report_template` VALUES (129, '利润表', 73, 'lrb', 0);
INSERT INTO `fxy_financial_report_template` VALUES (130, '现金流量表', 73, 'xjllb', 0);
INSERT INTO `fxy_financial_report_template` VALUES (131, '资产负债表', 73, 'zcfzb', 1);
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_report_template_items
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_report_template_items`;
CREATE TABLE `fxy_financial_report_template_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) NOT NULL,
  `title` varchar(256) NOT NULL COMMENT '标题',
  `parent_id` int(11) DEFAULT NULL,
  `line_num` int(11) NOT NULL DEFAULT '-1' COMMENT '行次',
  `type` int(11) DEFAULT NULL COMMENT '资产负载类型时需要设置\n0,资产 1,负债 2，所有者权益',
  `sources` int(11) NOT NULL DEFAULT '0' COMMENT '取数来原:0,表外公式,1,表内公式',
  `level` int(11) NOT NULL DEFAULT '1' COMMENT '层级',
  `is_bolder` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否加粗标题',
  `is_folding` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否可以折叠',
  `is_classified` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否是归类项，归类项没有行号',
  `pos` int(11) NOT NULL DEFAULT '1' COMMENT '显示位置',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fxy_report_template_items_fxy_report_template_id_fk` (`template_id`) USING BTREE,
  KEY `fxy_report_template_items_fxy_report_template_items_id_fk` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1655 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fxy_financial_report_template_items
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_report_template_items` VALUES (1540, 129, '一、营业外收入', NULL, 1, NULL, 0, 1, b'1', b'1', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (1541, 129, '减：营业成本', 1540, 2, NULL, 0, 2, b'0', b'1', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (1542, 129, '税金及附加', 1541, 3, 0, 0, 3, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (1543, 129, '其中:消费税', 1542, 4, 0, 0, 4, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (1544, 129, '营业税', 1542, 5, 0, 0, 4, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (1545, 129, '城市维护建设税', 1542, 6, 0, 0, 4, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (1546, 129, '资源税', 1542, 7, 0, 0, 4, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (1547, 129, '土地增值税', 1542, 8, 0, 0, 4, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (1548, 129, '城镇土地使用税、房产税、车船税、印花税', 1542, 9, 0, 0, 4, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (1549, 129, '教育费附加、矿产资源补偿费、排污费', 1542, 10, 0, 0, 4, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (1550, 129, '销售费用', 1541, 11, 0, 0, 3, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (1551, 129, '其中：商品维修费', 1550, 12, 0, 0, 4, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (1552, 129, '广告费和业务宣传费', 1550, 13, 0, 0, 4, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (1553, 129, '管理费用', 1541, 14, 0, 0, 3, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (1554, 129, '其中：开办费', 1553, 15, 0, 0, 4, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (1555, 129, '业务招待费', 1553, 16, 0, 0, 4, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (1556, 129, '研究费用', 1553, 17, 0, 0, 4, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (1557, 129, '财务费用', 1541, 18, 0, 0, 3, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (1558, 129, '其中：利息费用（收入以\'-\'号填列）', 1557, 19, 0, 0, 4, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (1559, 129, '投资收益（损失以“-”号填列）', 1541, 20, 0, 0, 3, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (1560, 129, '二、营业利润（亏损失以\'-\'填列）', NULL, 21, NULL, 1, 1, b'1', b'1', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (1561, 129, '加：营业外收入', 1560, 22, 0, 0, 2, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (1562, 129, '其中：政府补助', 1561, 23, 0, 0, 3, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (1563, 129, '减：营业外支出', 1560, 24, 0, 0, 2, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (1564, 129, '其中：坏账损失', 1563, 25, 0, 0, 3, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (1565, 129, '无法收回的长期债券投资损失', 1563, 26, 0, 0, 3, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (1566, 129, '无法收回的长期股权投资损失', 1563, 27, 0, 0, 3, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (1567, 129, '自然灾害等不可抗力因素造成的损失', 1563, 28, 0, 0, 3, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (1568, 129, '税收滞纳金', 1563, 29, 0, 0, 3, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (1569, 129, '三、利润总额（亏损失以“-”号填列）', NULL, 30, NULL, 1, 1, b'1', b'1', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (1570, 129, ' 减：所得税费用', 1569, 31, 0, 0, 2, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (1571, 129, '四、净利润（亏损失以“-”号填列）', NULL, 32, NULL, 1, 1, b'1', b'1', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (1572, 130, '一、经营活动产生的现金流量：', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (1573, 130, '销售产成品、商品、提供劳务收到的现金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 2);
INSERT INTO `fxy_financial_report_template_items` VALUES (1574, 130, '收到其他与经营活动有关的现金', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (1575, 130, '购买原材料、商品、接受劳务支付的现金', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (1576, 130, '支付的职工薪酬', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (1577, 130, '支付的税费', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (1578, 130, '支付其他与经营活动有关的现金', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (1579, 130, '经营活动产生的现金流量净额', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (1580, 130, '二、投资活动产生的现金流量：', NULL, 9, 0, 0, 1, b'1', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (1581, 130, '收回短期投资、长期债券投资和长期股权投资收到的现金', NULL, 10, 0, 0, 1, b'0', b'0', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (1582, 130, '取得投资收益收到的现金', NULL, 11, 0, 0, 1, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (1583, 130, '处置固定资产、无形资产和其他非流动资产收回的现金净额', NULL, 12, 0, 0, 1, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (1584, 130, '短期投资、长期债券投资和长期股权投资支付的现金', NULL, 13, 0, 0, 1, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (1585, 130, '购建固定资产、无形资产和其他非流动资产支付的现金', NULL, 14, 0, 0, 1, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (1586, 130, '投资活动产生的现金流量净额', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (1587, 130, '三、筹资活动产生的现金流量：', NULL, 16, 0, 0, 1, b'1', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (1588, 130, '取得借款收到的现金', NULL, 17, 0, 0, 1, b'0', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (1589, 130, '吸收投资者投资收到的现金', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (1590, 130, '偿还借款本金支付的现金', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (1591, 130, '偿还借款利息支付的现金', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (1592, 130, '分配利润支付的现金', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (1593, 130, '筹资活动产生的现金流量净额', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (1594, 130, '四、现金净增加额', NULL, 23, 0, 0, 1, b'1', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (1595, 130, '加：期初现金余额', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (1596, 130, '五、期末现金余额', NULL, 25, 0, 0, 1, b'1', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (1597, 131, '流动资产', NULL, 1, 0, 0, 1, b'1', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (1598, 131, '货币资金', NULL, 2, 0, 0, 1, b'0', b'0', b'0', 1);
INSERT INTO `fxy_financial_report_template_items` VALUES (1599, 131, '短期投资', NULL, 3, 0, 0, 1, b'0', b'0', b'0', 3);
INSERT INTO `fxy_financial_report_template_items` VALUES (1600, 131, '应收票据', NULL, 4, 0, 0, 1, b'0', b'0', b'0', 4);
INSERT INTO `fxy_financial_report_template_items` VALUES (1601, 131, '应收账款', NULL, 5, 0, 0, 1, b'0', b'0', b'0', 5);
INSERT INTO `fxy_financial_report_template_items` VALUES (1602, 131, '预付账款', NULL, 6, 0, 0, 1, b'0', b'0', b'0', 6);
INSERT INTO `fxy_financial_report_template_items` VALUES (1603, 131, '应收股利', NULL, 7, 0, 0, 1, b'0', b'0', b'0', 7);
INSERT INTO `fxy_financial_report_template_items` VALUES (1604, 131, '应收利息', NULL, 8, 0, 0, 1, b'0', b'0', b'0', 8);
INSERT INTO `fxy_financial_report_template_items` VALUES (1605, 131, '其他应收款', NULL, 9, 0, 0, 1, b'0', b'0', b'0', 9);
INSERT INTO `fxy_financial_report_template_items` VALUES (1606, 131, '存货', NULL, 10, 0, 0, 1, b'0', b'1', b'0', 10);
INSERT INTO `fxy_financial_report_template_items` VALUES (1607, 131, '其中：原材料', 1606, 11, 0, 0, 2, b'0', b'0', b'0', 11);
INSERT INTO `fxy_financial_report_template_items` VALUES (1608, 131, '在产品', 1606, 12, 0, 0, 2, b'0', b'0', b'0', 12);
INSERT INTO `fxy_financial_report_template_items` VALUES (1609, 131, '库存商品', 1606, 13, 0, 0, 2, b'0', b'0', b'0', 13);
INSERT INTO `fxy_financial_report_template_items` VALUES (1610, 131, '周转材料', 1606, 14, 0, 0, 2, b'0', b'0', b'0', 14);
INSERT INTO `fxy_financial_report_template_items` VALUES (1611, 131, '其他流动资产', NULL, 15, 0, 0, 1, b'0', b'0', b'0', 15);
INSERT INTO `fxy_financial_report_template_items` VALUES (1612, 131, '流动资产合计', NULL, 16, 0, 0, 1, b'0', b'0', b'0', 16);
INSERT INTO `fxy_financial_report_template_items` VALUES (1613, 131, '非流动资产', NULL, 17, 0, 0, 1, b'1', b'0', b'0', 17);
INSERT INTO `fxy_financial_report_template_items` VALUES (1614, 131, '长期债券投资', NULL, 18, 0, 0, 1, b'0', b'0', b'0', 18);
INSERT INTO `fxy_financial_report_template_items` VALUES (1615, 131, '长期股权投资', NULL, 19, 0, 0, 1, b'0', b'0', b'0', 19);
INSERT INTO `fxy_financial_report_template_items` VALUES (1616, 131, '固定资产原价编辑', NULL, 20, 0, 0, 1, b'0', b'0', b'0', 20);
INSERT INTO `fxy_financial_report_template_items` VALUES (1617, 131, '减：累计折旧', NULL, 21, 0, 0, 1, b'0', b'0', b'0', 21);
INSERT INTO `fxy_financial_report_template_items` VALUES (1618, 131, '固定资产账面价值', NULL, 22, 0, 0, 1, b'0', b'0', b'0', 22);
INSERT INTO `fxy_financial_report_template_items` VALUES (1619, 131, '在建工程', NULL, 23, 0, 0, 1, b'0', b'0', b'0', 23);
INSERT INTO `fxy_financial_report_template_items` VALUES (1620, 131, '工程物资', NULL, 24, 0, 0, 1, b'0', b'0', b'0', 24);
INSERT INTO `fxy_financial_report_template_items` VALUES (1621, 131, '固定资产清理', NULL, 25, 0, 0, 1, b'0', b'0', b'0', 25);
INSERT INTO `fxy_financial_report_template_items` VALUES (1622, 131, '生产性生物资产', NULL, 26, 0, 0, 1, b'0', b'0', b'0', 26);
INSERT INTO `fxy_financial_report_template_items` VALUES (1623, 131, '无形资产', NULL, 27, 0, 0, 1, b'0', b'0', b'0', 27);
INSERT INTO `fxy_financial_report_template_items` VALUES (1624, 131, '开发支出', NULL, 28, 0, 0, 1, b'0', b'0', b'0', 28);
INSERT INTO `fxy_financial_report_template_items` VALUES (1625, 131, '长期待摊费用', NULL, 29, 0, 0, 1, b'0', b'0', b'0', 29);
INSERT INTO `fxy_financial_report_template_items` VALUES (1626, 131, '其他非流动资产', NULL, 30, 0, 0, 1, b'0', b'0', b'0', 30);
INSERT INTO `fxy_financial_report_template_items` VALUES (1627, 131, '非流动资产合计', NULL, 31, 0, 0, 1, b'0', b'0', b'0', 31);
INSERT INTO `fxy_financial_report_template_items` VALUES (1628, 131, '资产合计', NULL, 32, 0, 0, 1, b'1', b'0', b'0', 32);
INSERT INTO `fxy_financial_report_template_items` VALUES (1629, 131, '流动负债', NULL, 33, 1, 0, 1, b'1', b'0', b'0', 33);
INSERT INTO `fxy_financial_report_template_items` VALUES (1630, 131, '短期借款', NULL, 34, 1, 0, 1, b'0', b'0', b'0', 34);
INSERT INTO `fxy_financial_report_template_items` VALUES (1631, 131, '应付票据', NULL, 35, 1, 0, 1, b'0', b'0', b'0', 35);
INSERT INTO `fxy_financial_report_template_items` VALUES (1632, 131, '应付账款', NULL, 36, 1, 0, 1, b'0', b'0', b'0', 36);
INSERT INTO `fxy_financial_report_template_items` VALUES (1633, 131, '预收账款', NULL, 37, 1, 0, 1, b'0', b'0', b'0', 37);
INSERT INTO `fxy_financial_report_template_items` VALUES (1634, 131, '应付职工薪酬', NULL, 38, 1, 0, 1, b'0', b'0', b'0', 38);
INSERT INTO `fxy_financial_report_template_items` VALUES (1635, 131, '应交税费', NULL, 39, 1, 0, 1, b'0', b'0', b'0', 39);
INSERT INTO `fxy_financial_report_template_items` VALUES (1636, 131, '应付利息', NULL, 40, 1, 0, 1, b'0', b'0', b'0', 40);
INSERT INTO `fxy_financial_report_template_items` VALUES (1637, 131, '应付利润', NULL, 41, 1, 0, 1, b'0', b'0', b'0', 41);
INSERT INTO `fxy_financial_report_template_items` VALUES (1638, 131, '其他应付款', NULL, 42, 1, 0, 1, b'0', b'0', b'0', 42);
INSERT INTO `fxy_financial_report_template_items` VALUES (1639, 131, '其他流动负债', NULL, 43, 1, 0, 1, b'0', b'0', b'0', 43);
INSERT INTO `fxy_financial_report_template_items` VALUES (1640, 131, '流动负债合计', NULL, 44, 1, 0, 1, b'0', b'0', b'0', 44);
INSERT INTO `fxy_financial_report_template_items` VALUES (1641, 131, '非流动负债', NULL, 45, 1, 0, 1, b'1', b'0', b'0', 45);
INSERT INTO `fxy_financial_report_template_items` VALUES (1642, 131, '长期借款', NULL, 46, 1, 0, 1, b'0', b'0', b'0', 46);
INSERT INTO `fxy_financial_report_template_items` VALUES (1643, 131, '长期应付款', NULL, 47, 1, 0, 1, b'0', b'0', b'0', 47);
INSERT INTO `fxy_financial_report_template_items` VALUES (1644, 131, '递延收益', NULL, 48, 1, 0, 1, b'0', b'0', b'0', 48);
INSERT INTO `fxy_financial_report_template_items` VALUES (1645, 131, '其他非流动负债', NULL, 49, 1, 0, 1, b'0', b'0', b'0', 49);
INSERT INTO `fxy_financial_report_template_items` VALUES (1646, 131, '非流动负债合计', NULL, 50, 1, 0, 1, b'0', b'0', b'0', 50);
INSERT INTO `fxy_financial_report_template_items` VALUES (1647, 131, '负债合计', NULL, 51, 1, 0, 1, b'1', b'0', b'0', 51);
INSERT INTO `fxy_financial_report_template_items` VALUES (1648, 131, '所有者权益（或股东权益）', NULL, 52, 2, 0, 1, b'1', b'0', b'0', 52);
INSERT INTO `fxy_financial_report_template_items` VALUES (1649, 131, '实收资本（或股本）', NULL, 53, 2, 0, 1, b'0', b'0', b'0', 53);
INSERT INTO `fxy_financial_report_template_items` VALUES (1650, 131, '资本公积', NULL, 54, 2, 0, 1, b'0', b'0', b'0', 54);
INSERT INTO `fxy_financial_report_template_items` VALUES (1651, 131, '盈余公积', NULL, 55, 2, 0, 1, b'0', b'0', b'0', 55);
INSERT INTO `fxy_financial_report_template_items` VALUES (1652, 131, '未分配利润', NULL, 56, 2, 0, 1, b'0', b'0', b'0', 56);
INSERT INTO `fxy_financial_report_template_items` VALUES (1653, 131, '所有者权益（或股东权益）合计', NULL, 57, 2, 0, 1, b'0', b'0', b'0', 57);
INSERT INTO `fxy_financial_report_template_items` VALUES (1654, 131, '负债和所有者权益（或股东权益）', NULL, 58, 2, 0, 1, b'1', b'0', b'0', 58);
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_report_template_items_formula
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_report_template_items_formula`;
CREATE TABLE `fxy_financial_report_template_items_formula` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) NOT NULL COMMENT '模板 id',
  `template_items_id` int(11) NOT NULL,
  `account_sets_id` int(11) NOT NULL,
  `calculation` enum('+','-','*','/') NOT NULL DEFAULT '+' COMMENT '计算方式',
  `access_rules` int(11) NOT NULL COMMENT '取数规则：0,净发生额度 1,借方发生额 2,贷方发生额',
  `from_tag` varchar(125) NOT NULL COMMENT '数据来源标识',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fxy_at_fk` (`account_sets_id`) USING BTREE,
  KEY `fxy_ift_fk` (`template_id`) USING BTREE,
  KEY `fxy_tif_fk` (`template_items_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1261 DEFAULT CHARSET=utf8 COMMENT='模板项公式表';

-- ----------------------------
-- Records of fxy_financial_report_template_items_formula
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1212, 129, 1540, 73, '+', 0, '10488');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1213, 129, 1540, 73, '+', 0, '10489');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1214, 129, 1541, 73, '+', 0, '10496');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1215, 129, 1541, 73, '+', 0, '10497');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1216, 129, 1542, 73, '+', 0, '10498');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1217, 129, 1543, 73, '+', 0, '10439');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1218, 129, 1544, 73, '+', 0, '10440');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1219, 129, 1545, 73, '+', 0, '10444');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1220, 129, 1546, 73, '+', 0, '10441');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1221, 129, 1547, 73, '+', 0, '10443');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1222, 129, 1548, 73, '+', 0, '10446');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1223, 129, 1548, 73, '+', 0, '10445');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1224, 129, 1548, 73, '+', 0, '10447');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1225, 129, 1548, 73, '+', 0, '10453');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1226, 129, 1549, 73, '+', 0, '10449');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1227, 129, 1549, 73, '+', 0, '10451');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1228, 129, 1549, 73, '+', 0, '10452');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1229, 129, 1550, 73, '+', 0, '10499');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1230, 129, 1551, 73, '+', 0, '10509');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1231, 129, 1552, 73, '+', 0, '10514');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1232, 129, 1552, 73, '+', 0, '10515');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1233, 129, 1553, 73, '+', 0, '10516');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1234, 129, 1554, 73, '+', 0, '10525');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1235, 129, 1555, 73, '+', 0, '10518');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1236, 129, 1556, 73, '+', 0, '10526');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1237, 129, 1557, 73, '+', 0, '10529');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1238, 129, 1558, 73, '+', 0, '10530');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1239, 129, 1559, 73, '+', 0, '10490');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1240, 129, 1560, 73, '+', 0, '1540');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1241, 129, 1560, 73, '-', 0, '1541');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1242, 129, 1560, 73, '-', 0, '1542');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1243, 129, 1560, 73, '-', 0, '1550');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1244, 129, 1560, 73, '-', 0, '1553');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1245, 129, 1560, 73, '-', 0, '1557');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1246, 129, 1560, 73, '+', 0, '1559');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1247, 129, 1561, 73, '+', 0, '10491');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1248, 129, 1562, 73, '+', 0, '10493');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1249, 129, 1563, 73, '+', 0, '10534');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1250, 129, 1564, 73, '+', 0, '10539');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1251, 129, 1565, 73, '+', 0, '10541');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1252, 129, 1566, 73, '+', 0, '10542');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1253, 129, 1567, 73, '+', 0, '10543');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1254, 129, 1568, 73, '+', 0, '10544');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1255, 129, 1569, 73, '+', 0, '1561');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1256, 129, 1569, 73, '-', 0, '1563');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1257, 129, 1569, 73, '+', 0, '1560');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1258, 129, 1570, 73, '+', 0, '10546');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1259, 129, 1571, 73, '+', 0, '1569');
INSERT INTO `fxy_financial_report_template_items_formula` VALUES (1260, 129, 1571, 73, '-', 0, '1570');
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_organization
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_organization`;
CREATE TABLE `fxy_financial_organization` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `type` int(11) DEFAULT NULL,
    `code` varchar(32) COLLATE utf8mb4_bin NOT NULL COMMENT '编码',
    `name` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
    `linkman` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系人',
    `telephone` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系电话',
    `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '状态',
    `parent_id` int(11) DEFAULT NULL COMMENT '上级',
    `account_sets_id` int(11) DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY `fxy_financial_organization_account_sets_id_name_index` (`account_sets_id`,`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10643 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='组织机构';


-- ----------------------------
-- Table structure for fxy_financial_subject
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_subject`;
CREATE TABLE `fxy_financial_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('资产','负债','权益','成本','损益','共同') COLLATE utf8mb4_bin NOT NULL DEFAULT '资产' COMMENT '科目类型',
  `code` varchar(32) COLLATE utf8mb4_bin NOT NULL COMMENT '科目编码',
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '科目名称',
  `mnemonic_code` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '助记码',
  `balance_direction` enum('借','贷') COLLATE utf8mb4_bin DEFAULT NULL COMMENT '余额方向',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '状态',
  `parent_id` int(11) DEFAULT NULL COMMENT '上级科目',
  `level` smallint(6) NOT NULL DEFAULT '1' COMMENT '所在级别',
  `system_default` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否为系统默认',
  `account_sets_id` int(11) DEFAULT NULL,
  `balance` double DEFAULT NULL COMMENT '科目余额',
  `unit` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '单位',
  `auxiliary_accounting` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '辅助核算',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fxy_financial_subject_account_sets_id_name_index` (`account_sets_id`,`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10643 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='科目';

-- ----------------------------
-- Records of fxy_financial_subject
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_subject` VALUES (10386, '资产', '1001', '库存现金', 'kcxj', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10387, '资产', '1002', '银行存款', 'yxck', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10388, '资产', '1012', '其他货币资金', 'qthbzj', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10389, '资产', '1101', '短期投资', 'dqtz', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10390, '资产', '110101', '股票', 'dqtz_gp', '借', b'1', 10389, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10391, '资产', '110102', '债券', 'dqtz_zq', '借', b'1', 10389, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10392, '资产', '110103', '基金', 'dqtz_jj', '借', b'1', 10389, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10393, '资产', '1121', '应收票据', 'yspj', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10394, '资产', '1122', '应收账款', 'yszk', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10395, '资产', '1123', '预付账款', 'yfzk', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10396, '资产', '1131', '应收股利', 'ysgl', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10397, '资产', '1132', '应收利息', 'yslx', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10398, '资产', '1221', '其他应收款', 'qtysk', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10399, '资产', '1401', '材料采购', 'clcg', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10400, '资产', '1402', '在途物资', 'ztwz', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10401, '资产', '1403', '原材料', 'ycl', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10402, '资产', '1404', '材料成本差异', 'clcbcy', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10403, '资产', '1405', '库存商品', 'kcsp', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10404, '资产', '1407', '商品进销差价', 'spjxcj', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10405, '资产', '1408', '委托加工物资', 'wtjgwz', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10406, '资产', '1411', '周转材料', 'zzcl', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10407, '资产', '1421', '消耗性生物资产', 'xhxswzc', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10408, '资产', '1501', '长期债券投资', 'zqzqtz', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10409, '资产', '1511', '长期股权投资', 'zqgqtz', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10410, '资产', '1601', '固定资产', 'gdzc', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10411, '资产', '1602', '累计折旧', 'ljzj', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10412, '资产', '1604', '在建工程', 'zjgc', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10413, '资产', '1605', '工程物资', 'gcwz', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10414, '资产', '1606', '固定资产清理', 'gdzcql', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10415, '资产', '1621', '生产性生物资产', 'scxswzc', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10416, '资产', '1622', '生产性生物资产累计折旧', 'scxswzcljzj', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10417, '资产', '1701', '无形资产', 'wxzc', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10418, '资产', '1702', '累计摊销', 'ljtx', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10419, '资产', '1801', '长期待摊费用', 'zqdtfy', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10420, '资产', '1901', '待处理财产损溢', 'dclccsy', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10421, '负债', '2001', '短期借款', 'dqjk', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10422, '负债', '2201', '应付票据', 'yfpj', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10423, '负债', '2202', '应付账款', 'yfzk', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10424, '负债', '2203', '预收账款', 'yszk', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10425, '负债', '2211', '应付职工薪酬', 'yfzgxc', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10426, '负债', '2221', '应交税费', 'yjsf', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10427, '负债', '222101', '应交增值税', 'yjsf_yjzzs', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10428, '负债', '22210101', '进项税额', 'yjsf_yjzzs_jxse', '借', b'1', 10427, 3, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10429, '负债', '22210102', '已交税金', 'yjsf_yjzzs_yjsj', '借', b'1', 10427, 3, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10430, '负债', '22210103', '转出未交增值税', 'yjsf_yjzzs_zcwjzzs', '借', b'1', 10427, 3, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10431, '负债', '22210104', '减免税款', 'yjsf_yjzzs_jmsk', '借', b'1', 10427, 3, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10432, '负债', '22210105', '销项税额', 'yjsf_yjzzs_xxse', '贷', b'1', 10427, 3, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10433, '负债', '22210106', '出口退税', 'yjsf_yjzzs_ckts', '贷', b'1', 10427, 3, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10434, '负债', '22210107', '进项税额转出', 'yjsf_yjzzs_jxsezc', '贷', b'1', 10427, 3, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10435, '负债', '22210108', '出口抵减内销产品应纳税额', 'yjsf_yjzzs_ckdjnxcpynse', '借', b'1', 10427, 3, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10436, '负债', '22210109', '转出多交增值税', 'yjsf_yjzzs_zcdjzzs', '贷', b'1', 10427, 3, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10437, '负债', '22210110', '销项税额抵减', 'yjsf_yjzzs_xxsedj', '借', b'1', 10427, 3, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10438, '负债', '222102', '未交增值税', 'yjsf_wjzzs', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10439, '负债', '222103', '应交消费税', 'yjsf_yjxfs', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10440, '负债', '222104', '应交营业税', 'yjsf_yjyys', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10441, '负债', '222105', '应交资源税', 'yjsf_yjzys', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10442, '负债', '222106', '应交所得税', 'yjsf_yjsds', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10443, '负债', '222107', '应交土地增值税', 'yjsf_yjtdzzs', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10444, '负债', '222108', '应交城市维护建设税', 'yjsf_yjcswhjss', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10445, '负债', '222109', '应交房产税', 'yjsf_yjfcs', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10446, '负债', '222110', '应交城镇土地使用税', 'yjsf_yjcztdsys', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10447, '负债', '222111', '应交车船使用税', 'yjsf_yjccsys', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10448, '负债', '222112', '应交个人所得税', 'yjsf_yjgrsds', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10449, '负债', '222113', '教育费附加', 'yjsf_jyffj', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10450, '负债', '222114', '地方教育费附加', 'yjsf_dfjyffj', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10451, '负债', '222115', '矿产资源补偿费', 'yjsf_kczybcf', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10452, '负债', '222116', '排污费', 'yjsf_pwf', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10453, '负债', '222117', '印花税', 'yjsf_yhs', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10454, '负债', '222118', '预交增值税', 'yjsf_yjzzs', '借', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10455, '负债', '222119', '待抵扣进项税额', 'yjsf_ddkjxse', '借', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10456, '负债', '222120', '待认证进项税额', 'yjsf_drzjxse', '借', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10457, '负债', '222121', '待转销项税额', 'yjsf_dzxxse', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10458, '负债', '222122', '增值税留抵税额', 'yjsf_zzsldse', '借', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10459, '负债', '222123', '简易计税', 'yjsf_jyjs', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10460, '负债', '222124', '转让金融商品应交增值税', 'yjsf_zrjrspyjzzs', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10461, '负债', '222125', '代扣代交增值税', 'yjsf_dkdjzzs', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10462, '负债', '222126', '税金', 'yjsf_sj', '贷', b'1', 10426, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10463, '负债', '2231', '应付利息', 'yflx', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10464, '负债', '2232', '应付利润', 'yflr', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10465, '负债', '2241', '其他应付款', 'qtyfk', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10466, '负债', '2401', '递延收益', 'dysy', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10467, '负债', '2501', '长期借款', 'zqjk', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10468, '负债', '2701', '长期应付款', 'zqyfk', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10469, '权益', '3001', '实收资本', 'sszb', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10470, '权益', '3002', '资本公积', 'zbgj', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10471, '权益', '3101', '盈余公积', 'yygj', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10472, '权益', '310101', '法定盈余公积', 'yygj_fdyygj', '贷', b'1', 10471, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10473, '权益', '310102', '任意盈余公积', 'yygj_ryyygj', '贷', b'1', 10471, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10474, '权益', '310103', '法定公益金', 'yygj_fdgyj', '贷', b'1', 10471, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10475, '权益', '3103', '本年利润', 'bnlr', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10476, '权益', '3104', '利润分配', 'lrfp', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10477, '权益', '310401', '其他转入', 'lrfp_qtzr', '贷', b'1', 10476, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10478, '权益', '310402', '提取法定盈余公积', 'lrfp_tqfdyygj', '贷', b'1', 10476, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10479, '权益', '310403', '提取法定公益金', 'lrfp_tqfdgyj', '贷', b'1', 10476, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10480, '权益', '310404', '提取任意盈余公积', 'lrfp_tqryyygj', '贷', b'1', 10476, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10481, '权益', '310405', '应付利润', 'lrfp_yflr', '贷', b'1', 10476, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10482, '权益', '310406', '未分配利润', 'lrfp_wfplr', '贷', b'1', 10476, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10483, '成本', '4001', '生产成本', 'sccb', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10484, '成本', '4101', '制造费用', 'zzfy', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10485, '成本', '4301', '研发支出', 'yfzc', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10486, '成本', '4401', '工程施工', 'gcsg', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10487, '成本', '4403', '机械作业', 'jxzy', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10488, '损益', '5001', '主营业务收入', 'zyywsr', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10489, '损益', '5051', '其他业务收入', 'qtywsr', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10490, '损益', '5111', '投资收益', 'tzsy', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10491, '损益', '5301', '营业外收入', 'yywsr', '贷', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10492, '损益', '530101', '非流动资产处置净收益', 'yywsr_fldzcczjsy', '贷', b'1', 10491, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10493, '损益', '530102', '政府补助', 'yywsr_zfbz', '贷', b'1', 10491, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10494, '损益', '530103', '捐赠收益', 'yywsr_jzsy', '贷', b'1', 10491, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10495, '损益', '530104', '盘盈收益', 'yywsr_pysy', '贷', b'1', 10491, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10496, '损益', '5401', '主营业务成本', 'zyywcb', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10497, '损益', '5402', '其他业务成本', 'qtywcb', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10498, '损益', '5403', '税金及附加', 'sjjfj', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10499, '损益', '5601', '销售费用', 'xsfy', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10500, '损益', '560101', '销售人员职工薪酬', 'xsfy_xsryzgxc', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10501, '损益', '560102', '业务招待费', 'xsfy_ywzdf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10502, '损益', '560103', '修理费', 'xsfy_xlf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10503, '损益', '560104', '办公费', 'xsfy_bgf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10504, '损益', '560105', '水电费', 'xsfy_sdf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10505, '损益', '560106', '差旅费', 'xsfy_clf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10506, '损益', '560107', '折旧费', 'xsfy_zjf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10507, '损益', '560108', '摊销费', 'xsfy_txf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10508, '损益', '560109', '展览费', 'xsfy_zlf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10509, '损益', '560110', '商品维修费', 'xsfy_spwxf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10510, '损益', '560111', '运输费', 'xsfy_ysf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10511, '损益', '560112', '装卸费', 'xsfy_zxf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10512, '损益', '560113', '包装费', 'xsfy_bzf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10513, '损益', '560114', '保险费', 'xsfy_bxf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10514, '损益', '560115', '广告费', 'xsfy_ggf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10515, '损益', '560116', '业务宣传费', 'xsfy_ywxcf', '借', b'1', 10499, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10516, '损益', '5602', '管理费用', 'glfy', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10517, '损益', '560201', '管理人员职工薪酬', 'glfy_glryzgxc', '借', b'1', 10516, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10518, '损益', '560202', '业务招待费', 'glfy_ywzdf', '借', b'1', 10516, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10519, '损益', '560203', '修理费', 'glfy_xlf', '借', b'1', 10516, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10520, '损益', '560204', '办公费', 'glfy_bgf', '借', b'1', 10516, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10521, '损益', '560205', '水电费', 'glfy_sdf', '借', b'1', 10516, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10522, '损益', '560206', '差旅费', 'glfy_clf', '借', b'1', 10516, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10523, '损益', '560207', '折旧费', 'glfy_zjf', '借', b'1', 10516, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10524, '损益', '560208', '摊销费', 'glfy_txf', '借', b'1', 10516, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10525, '损益', '560209', '开办费', 'glfy_kbf', '借', b'1', 10516, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10526, '损益', '560210', '研究费用', 'glfy_yjfy', '借', b'1', 10516, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10527, '损益', '560211', '咨询费', 'glfy_zxf', '借', b'1', 10516, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10528, '损益', '560212', '长期待摊费用摊销', 'glfy_zqdtfytx', '借', b'1', 10516, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10529, '损益', '5603', '财务费用', 'cwfy', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10530, '损益', '560301', '利息费用', 'cwfy_lxfy', '借', b'1', 10529, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10531, '损益', '560302', '手续费', 'cwfy_sxf', '借', b'1', 10529, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10532, '损益', '560303', '汇兑损益', 'cwfy_hdsy', '借', b'1', 10529, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10533, '损益', '560304', '现金折扣', 'cwfy_xjzk', '借', b'1', 10529, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10534, '损益', '5711', '营业外支出', 'yywzc', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10535, '损益', '571101', '非流动资产处置净损失', 'yywzc_fldzcczjss', '借', b'1', 10534, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10536, '损益', '571102', '赞助支出', 'yywzc_zzzc', '借', b'1', 10534, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10537, '损益', '571103', '捐赠支出', 'yywzc_jzzc', '借', b'1', 10534, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10538, '损益', '571104', '盘亏损失', 'yywzc_pkss', '借', b'1', 10534, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10539, '损益', '571105', '坏账损失', 'yywzc_hzss', '借', b'1', 10534, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10540, '损益', '571106', '存货毁损报废损失', 'yywzc_chhsbfss', '借', b'1', 10534, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10541, '损益', '571107', '无法收回的长期债券投资损失', 'yywzc_wfshdzqzqtzss', '借', b'1', 10534, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10542, '损益', '571108', '无法收回的长期股权投资损失', 'yywzc_wfshdzqgqtzss', '借', b'1', 10534, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10543, '损益', '571109', '自然灾害等不可抗力因素造成的损失', 'yywzc_zrzhdbkklyszcdss', '借', b'1', 10534, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10544, '损益', '571110', '税收滞纳金', 'yywzc_ssznj', '借', b'1', 10534, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10545, '损益', '571111', '罚款支出', 'yywzc_fkzc', '借', b'1', 10534, 2, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10546, '损益', '5801', '所得税费用', 'sdsfy', '借', b'1', 0, 1, b'1', 73, NULL, '', '');
INSERT INTO `fxy_financial_subject` VALUES (10547, '资产', '100201', '中国银行', 'yxck_zgyx', '借', b'1', 10387, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10548, '资产', '100202', '农业银行', 'yxck_nyyx', '借', b'1', 10387, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10549, '资产', '112301', '房租', 'yfzk_fz', '借', b'1', 10395, 2, b'0', 73, NULL, '', '[{\"name\":\"客户\",\"id\":388}]');
INSERT INTO `fxy_financial_subject` VALUES (10550, '资产', '112302', '仓库租金', 'yfzk_ckzj', '借', b'1', 10395, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10551, '资产', '112303', '福州货款', 'yfzk_fzhk', '借', b'1', 10395, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10552, '资产', '112304', '物业', 'yfzk_wy', '借', b'1', 10395, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10553, '资产', '122101', '押金', 'qtysk_yj', '借', b'1', 10398, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10554, '资产', '12210101', '装修押金', 'qtysk_yj_zxyj', '借', b'1', 10553, 3, b'0', 73, NULL, '', '[{\"name\":\"客户\",\"id\":388}]');
INSERT INTO `fxy_financial_subject` VALUES (10555, '资产', '12210102', '旧巷南保证金', 'qtysk_yj_jxnbzj', '借', b'1', 10553, 3, b'0', 73, NULL, '', '[{\"name\":\"客户\",\"id\":388}]');
INSERT INTO `fxy_financial_subject` VALUES (10556, '资产', '12210103', '履约保证金', 'qtysk_yj_lybzj', '借', b'1', 10553, 3, b'0', 73, NULL, '', '[{\"name\":\"客户\",\"id\":388}]');
INSERT INTO `fxy_financial_subject` VALUES (10557, '资产', '12210104', '桶装水', 'qtysk_yj_tzs', '借', b'1', 10553, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10558, '资产', '12210105', '质量保证金', 'qtysk_yj_zlbzj', '借', b'1', 10553, 3, b'0', 73, NULL, '', '[{\"name\":\"客户\",\"id\":388}]');
INSERT INTO `fxy_financial_subject` VALUES (10559, '资产', '122102', '备用金', 'qtysk_byj', '借', b'1', 10398, 2, b'0', 73, NULL, '', '[{\"name\":\"职员\",\"id\":390}]');
INSERT INTO `fxy_financial_subject` VALUES (10560, '资产', '122103', '余姚店', 'qtysk_yyd', '借', b'1', 10398, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10561, '资产', '122104', '总仓', 'qtysk_zc', '借', b'1', 10398, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10562, '资产', '122105', '待入账', 'qtysk_drz', '借', b'1', 10398, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10563, '资产', '122106', '钱箱备用金', 'qtysk_qxbyj', '借', b'1', 10398, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10564, '资产', '122107', '三小店', 'qtysk_sxd', '借', b'1', 10398, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10565, '资产', '122108', '预售卡押金', 'qtysk_yskyj', '借', b'1', 10398, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10566, '资产', '122109', '会员户', 'qtysk_hyh', '借', b'1', 10398, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10567, '资产', '122110', '个人', 'qtysk_gr', '借', b'1', 10398, 2, b'0', 73, NULL, '', '[{\"name\":\"职员\",\"id\":390}]');
INSERT INTO `fxy_financial_subject` VALUES (10568, '资产', '122111', '一点点房租', 'qtysk_yddfz', '借', b'1', 10398, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10569, '资产', '140301', '猪骨头', 'ycl_zgt', '借', b'1', 10401, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10570, '资产', '140302', '饮料', 'ycl_yl', '借', b'1', 10401, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10571, '资产', '140303', '海鲜', 'ycl_hx', '借', b'1', 10401, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10572, '资产', '140304', '面条', 'ycl_mt', '借', b'1', 10401, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10573, '资产', '140305', '花生', 'ycl_hs', '借', b'1', 10401, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10574, '资产', '140306', '蔬菜', 'ycl_sc', '借', b'1', 10401, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10575, '资产', '140307', '福州干货', 'ycl_fzgh', '借', b'1', 10401, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10576, '资产', '140308', '凤爪', 'ycl_fz', '借', b'1', 10401, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10577, '资产', '140309', '自采购', 'ycl_zcg', '借', b'1', 10401, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10578, '负债', '220301', '微信会员充值', 'yszk_wxhycz', '贷', b'1', 10424, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10579, '负债', '220302', '单机会员充值', 'yszk_djhycz', '贷', b'1', 10424, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10580, '负债', '221101', '工资', 'yfzgxc_gz', '贷', b'1', 10425, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10581, '负债', '221102', '提成', 'yfzgxc_tc', '贷', b'1', 10425, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10582, '负债', '224101', '个人', 'qtyfk_gr', '贷', b'1', 10465, 2, b'0', 73, NULL, '', '[{\"name\":\"职员\",\"id\":390}]');
INSERT INTO `fxy_financial_subject` VALUES (10583, '负债', '224102', '设备，装修', 'qtyfk_sb，zx', '贷', b'1', 10465, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10584, '负债', '224104', '月结款', 'qtyfk_yjk', '贷', b'1', 10465, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10585, '负债', '224105', '履约保证金', 'qtyfk_lybzj', '贷', b'1', 10465, 2, b'0', 73, NULL, '', '[{\"name\":\"客户\",\"id\":388}]');
INSERT INTO `fxy_financial_subject` VALUES (10586, '负债', '224106', '装修押金', 'qtyfk_zxyj', '贷', b'1', 10465, 2, b'0', 73, NULL, '', '[{\"name\":\"客户\",\"id\":388}]');
INSERT INTO `fxy_financial_subject` VALUES (10587, '权益', '300101', '陈林', 'sszb_cl', '贷', b'1', 10469, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10588, '权益', '300102', '严岳思', 'sszb_yys', '贷', b'1', 10469, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10589, '权益', '300103', '章永刚', 'sszb_zyg', '贷', b'1', 10469, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10590, '权益', '300104', '张竹挺', 'sszb_zzt', '贷', b'1', 10469, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10591, '权益', '300105', '夏克伟', 'sszb_xkw', '贷', b'1', 10469, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10592, '损益', '530105', '其他', 'yywsr_qt', '贷', b'1', 10491, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10593, '损益', '56010401', '电话费', 'xsfy_bgf_dhf', '借', b'1', 10503, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10594, '损益', '56010402', '打印纸', 'xsfy_bgf_dyz', '借', b'1', 10503, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10595, '损益', '56010403', '桶装水', 'xsfy_bgf_tzs', '借', b'1', 10503, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10596, '损益', '56010404', '办公用品', 'xsfy_bgf_bgyp', '借', b'1', 10503, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10597, '损益', '560117', '设备-小器具', 'xsfy_sb-xqj', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10598, '损益', '560119', '低值易耗品', 'xsfy_dzyhp', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10599, '损益', '560120', '其他', 'xsfy_qt', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10600, '损益', '56012002', '杂项', 'xsfy_qt_zx', '借', b'1', 10599, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10601, '损益', '560121', '厨房原材料-调料', 'xsfy_cfycl-dl', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10602, '损益', '560122', '一次性用品', 'xsfy_ycxyp', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10603, '损益', '560123', '员工关怀', 'xsfy_yggh', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10604, '损益', '560124', '营业折扣', 'xsfy_yyzk', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10605, '损益', '560125', '礼券', 'xsfy_lq', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10606, '损益', '560126', '垃圾费', 'xsfy_ljf', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10607, '损益', '560127', '网络招聘费', 'xsfy_wlzpf', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10608, '损益', '560128', '员工餐', 'xsfy_ygc', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10609, '损益', '560129', '经营期间购买的小设备', 'xsfy_jyqjgmdxsb', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10610, '损益', '560130', '清洁用品', 'xsfy_qjyp', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10611, '损益', '560131', '会员卡短信费', 'xsfy_hykdxf', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10612, '损益', '560132', '物料', 'xsfy_wl', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10613, '损益', '560133', '交通费', 'xsfy_jtf', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10614, '损益', '560134', '推广费', 'xsfy_tgf', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10615, '损益', '560135', '装修费', 'xsfy_zxf', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10616, '损益', '560136', '红包雨', 'xsfy_hby', '借', b'1', 10499, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10617, '损益', '56020401', '物料', 'glfy_bgf_wl', '借', b'1', 10520, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10618, '损益', '56020801', '房租', 'glfy_txf_fz', '借', b'1', 10524, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10619, '损益', '56020802', '仓储租金', 'glfy_txf_cczj', '借', b'1', 10524, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10620, '损益', '56020803', '物业', 'glfy_txf_wy', '借', b'1', 10524, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10621, '损益', '56020901', '公关费用', 'glfy_kbf_ggfy', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10622, '损益', '56020902', '店面装修', 'glfy_kbf_dmzx', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10623, '损益', '56020903', '加盟费', 'glfy_kbf_jmf', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10624, '损益', '56020904', '装修设计', 'glfy_kbf_zxsj', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10625, '损益', '56020905', '企划设计', 'glfy_kbf_qhsj', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10626, '损益', '56020906', '桌椅', 'glfy_kbf_zy', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10627, '损益', '56020907', '灯箱', 'glfy_kbf_dx', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10628, '损益', '56020908', '业务招待费用', 'glfy_kbf_ywzdfy', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10629, '损益', '56020909', '设备', 'glfy_kbf_sb', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10630, '损益', '56020910', '小物件', 'glfy_kbf_xwj', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10631, '损益', '56020911', '开业指导费', 'glfy_kbf_kyzdf', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10632, '损益', '56020912', '餐费', 'glfy_kbf_cf', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10633, '损益', '56020913', '其他', 'glfy_kbf_qt', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10634, '损益', '56020914', '广告费', 'glfy_kbf_ggf', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10635, '损益', '56020915', '工资', 'glfy_kbf_gz', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10636, '损益', '56020916', '租金', 'glfy_kbf_zj', '借', b'1', 10525, 3, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10637, '损益', '560213', '工资', 'glfy_gz', '借', b'1', 10516, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10638, '损益', '560214', '提成', 'glfy_tc', '借', b'1', 10516, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10639, '损益', '560215', '税金', 'glfy_sj', '借', b'1', 10516, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10640, '损益', '560216', '租金', 'glfy_zj', '借', b'1', 10516, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10641, '损益', '560217', '品牌使用费', 'glfy_ppsyf', '借', b'1', 10516, 2, b'0', 73, NULL, '', NULL);
INSERT INTO `fxy_financial_subject` VALUES (10642, '损益', '571112', '其他', 'yywzc_qt', '借', b'1', 10534, 2, b'0', 73, NULL, '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_user
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_user`;
CREATE TABLE `fxy_financial_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(16) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '电话',
  `password` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '密码',
  `union_id` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '微信 unionId',
  `open_id` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '微信 openId',
  `nickname` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '昵称',
  `avatar_url` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '头像',
  `real_name` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '真实姓名',
  `account_sets_id` int(11) DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `init_password` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '默认密码',
  `email` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `fxy_financial_user_mobile_uindex` (`mobile`) USING BTREE,
  UNIQUE KEY `fxy_financial_user_open_id_uindex` (`open_id`) USING BTREE,
  UNIQUE KEY `fxy_financial_user_union_id_uindex` (`union_id`) USING BTREE,
  KEY `fxy_financial_user_fxy_financial_account_sets_id_fk` (`account_sets_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户';

-- ----------------------------
-- Records of fxy_financial_user
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_user` VALUES (1, '18676037292', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, '夏悸', NULL, '夏悸', 73, '2019-08-01 23:00:42', NULL, '88388996@qq.com');
INSERT INTO `fxy_financial_user` VALUES (17, '18692626866', '141b531033830336937d49ad463b6d6196337e0e3d1779cf860ad39bc47864c6', NULL, NULL, '制单人', NULL, '制单人6866', 75, '2019-11-02 00:42:35', '930062', NULL);
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_user_account_sets
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_user_account_sets`;
CREATE TABLE `fxy_financial_user_account_sets` (
  `account_sets_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_type` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '账套角色',
  UNIQUE KEY `fxy_financial_user_uix` (`account_sets_id`,`user_id`) USING BTREE,
  KEY `fxy_financial_user_account_sets_fxy_financial_user_id_fk` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户关联的账套';

-- ----------------------------
-- Records of fxy_financial_user_account_sets
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_user_account_sets` VALUES (73, 1, 'Manager');
INSERT INTO `fxy_financial_user_account_sets` VALUES (74, 1, 'Manager');
INSERT INTO `fxy_financial_user_account_sets` VALUES (74, 17, 'Making');
INSERT INTO `fxy_financial_user_account_sets` VALUES (75, 1, 'Manager');
INSERT INTO `fxy_financial_user_account_sets` VALUES (75, 17, 'Making');
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_voucher
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_voucher`;
CREATE TABLE `fxy_financial_voucher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '凭证字',
  `code` int(11) NOT NULL,
  `remark` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  `receipt_num` int(11) NOT NULL DEFAULT '0' COMMENT '附单据数量',
  `create_member` int(11) NOT NULL COMMENT '制单人',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `debit_amount` double DEFAULT '0' COMMENT '借方总金额',
  `credit_amount` double DEFAULT '0' COMMENT '贷方总金额',
  `account_sets_id` int(11) DEFAULT NULL,
  `voucher_year` int(11) DEFAULT NULL,
  `voucher_month` int(11) DEFAULT NULL,
  `voucher_date` date NOT NULL,
  `audit_member_id` int(11) DEFAULT NULL COMMENT '审核人 ID',
  `audit_member_name` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '审核人姓名',
  `audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `carry_forward` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否结转损益',
  `org_id` int(11) NOT NULL COMMENT '机构ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fxy_financial_voucher_account_sets_id_fk` (`account_sets_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2913 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='凭证';

-- ----------------------------
-- Records of fxy_financial_voucher
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_voucher` VALUES (2290, '记', 7, NULL, 0, 17, '2019-11-07 14:26:24', 20222.46, 20222.46, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2291, '记', 7, NULL, 0, 17, '2019-11-07 14:26:24', 0, 0, 74, 2019, 6, '2019-06-26', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2292, '记', 15, NULL, 0, 17, '2019-11-07 14:26:24', 8249.4, 8249.4, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2293, '记', 27, NULL, 0, 17, '2019-11-07 14:26:24', 3274.48, 3274.48, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2294, '记', 14, NULL, 0, 17, '2019-11-07 14:26:24', 9557.38, 9557.38, 74, 2019, 6, '2019-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2295, '记', 14, NULL, 0, 17, '2019-11-07 14:26:24', 2862.9, 2862.9, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2296, '记', 1, NULL, 0, 17, '2019-11-07 14:26:24', 2, 2, 74, 2019, 4, '2019-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2297, '记', 11, NULL, 0, 17, '2019-11-07 14:26:24', 295, 295, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2298, '记', 14, NULL, 0, 17, '2019-11-07 14:26:24', 27723.8, 27723.8, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2299, '记', 14, NULL, 0, 17, '2019-11-07 14:26:24', 4502.3, 4502.3, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2300, '记', 1, NULL, 0, 17, '2019-11-07 14:26:24', 1500, 1500, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2301, '记', 5, NULL, 0, 17, '2019-11-07 14:26:24', 21523, 21523, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2302, '记', 14, NULL, 0, 17, '2019-11-07 14:26:24', 4647.26, 4647.26, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2303, '记', 2, NULL, 0, 17, '2019-11-07 14:26:25', 2334.6, 2334.6, 74, 2019, 9, '2019-09-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2304, '记', 14, NULL, 0, 17, '2019-11-07 14:26:25', 76470, 76470, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2305, '记', 26, NULL, 0, 17, '2019-11-07 14:26:25', 114269.51, 114269.51, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2306, '记', 14, NULL, 0, 17, '2019-11-07 14:26:25', 21729.9, 21729.9, 74, 2019, 3, '2019-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2307, '记', 8, NULL, 0, 17, '2019-11-07 14:26:25', 280.2, 280.2, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2308, '记', 8, NULL, 0, 17, '2019-11-07 14:26:25', 19511.48, 19511.48, 74, 2019, 6, '2019-06-26', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2309, '记', 1, NULL, 0, 17, '2019-11-07 14:26:25', 2569.5, 2569.5, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2310, '记', 1, NULL, 0, 17, '2019-11-07 14:26:25', 15835.5, 15835.5, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2311, '记', 26, NULL, 0, 17, '2019-11-07 14:26:25', 20000, 20000, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2312, '记', 13, NULL, 0, 17, '2019-11-07 14:26:25', 12552.5, 12552.5, 74, 2019, 6, '2019-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2313, '记', 13, NULL, 0, 17, '2019-11-07 14:26:25', 50000, 50000, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2314, '记', 13, NULL, 0, 17, '2019-11-07 14:26:25', 5948, 5948, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2315, '记', 10, NULL, 0, 17, '2019-11-07 14:26:25', 810, 810, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2316, '记', 2, NULL, 0, 17, '2019-11-07 14:26:25', 4200, 4200, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2317, '记', 13, NULL, 0, 17, '2019-11-07 14:26:25', 16665.14, 16665.14, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2318, '记', 4, NULL, 0, 17, '2019-11-07 14:26:25', 3406.9, 3406.9, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2319, '记', 13, NULL, 0, 17, '2019-11-07 14:26:25', 999, 999, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2320, '记', 25, NULL, 0, 17, '2019-11-07 14:26:25', 0.01, 0.01, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2321, '记', 13, NULL, 0, 17, '2019-11-07 14:26:25', 4200, 4200, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2322, '记', 25, NULL, 0, 17, '2019-11-07 14:26:25', 330293.2, 330293.2, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2323, '记', 9, NULL, 0, 17, '2019-11-07 14:26:25', 111432.42000000001, 111432.42000000001, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2324, '记', 3, NULL, 0, 17, '2019-11-07 14:26:25', 20497, 20497, 74, 2019, 9, '2019-09-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2325, '记', 9, NULL, 0, 17, '2019-11-07 14:26:25', 414, 414, 74, 2019, 6, '2019-06-26', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2326, '记', 2, NULL, 0, 17, '2019-11-07 14:26:25', 7708.5, 7708.5, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2327, '记', 3, NULL, 0, 17, '2019-11-07 14:26:25', 995.3, 995.3, 74, 2019, 4, '2019-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2328, '记', 12, NULL, 0, 17, '2019-11-07 14:26:25', 50544.8, 50544.8, 74, 2019, 6, '2019-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2329, '记', 12, NULL, 0, 17, '2019-11-07 14:26:25', 71.49, 71.49, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2330, '记', 12, NULL, 0, 17, '2019-11-07 14:26:25', 584.6, 584.6, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2331, '记', 20, NULL, 0, 17, '2019-11-07 14:26:25', 1075, 1075, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2332, '记', 12, NULL, 0, 17, '2019-11-07 14:26:25', 183770.05000000002, 183770.05, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2333, '记', 8, NULL, 0, 17, '2019-11-07 14:26:25', 6692.8, 6692.8, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2334, '记', 3, NULL, 0, 17, '2019-11-07 14:26:25', 1619.5, 1619.5, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2335, '记', 12, NULL, 0, 17, '2019-11-07 14:26:25', 475.2, 475.2, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2336, '记', 24, NULL, 0, 17, '2019-11-07 14:26:25', 0, 0, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2337, '记', 12, NULL, 0, 17, '2019-11-07 14:26:25', 2700, 2700, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2338, '记', 24, NULL, 0, 17, '2019-11-07 14:26:25', 61654.2, 61654.2, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2339, '记', 4, NULL, 0, 17, '2019-11-07 14:26:25', 2908, 2908, 74, 2019, 9, '2019-09-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2340, '记', 13, NULL, 0, 17, '2019-11-07 14:26:25', 4050, 4050, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2341, '记', 9, NULL, 0, 17, '2019-11-07 14:26:25', 2, 2, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2342, '记', 3, NULL, 0, 17, '2019-11-07 14:26:25', 1863.6, 1863.6, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2343, '记', 2, NULL, 0, 17, '2019-11-07 14:26:25', 6794.3, 6794.3, 74, 2019, 4, '2019-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2344, '记', 10, NULL, 0, 17, '2019-11-07 14:26:26', 7708, 7708, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2345, '记', 11, NULL, 0, 17, '2019-11-07 14:26:26', 50544.8, 50544.8, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2346, '记', 23, NULL, 0, 17, '2019-11-07 14:26:26', 2569.5, 2569.5, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2347, '记', 5, NULL, 0, 17, '2019-11-07 14:26:26', 1300, 1300, 74, 2019, 9, '2019-09-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2348, '记', 10, NULL, 0, 17, '2019-11-07 14:26:26', 12866, 12866, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2349, '记', 12, NULL, 0, 17, '2019-11-07 14:26:26', 2, 2, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2350, '记', 11, NULL, 0, 17, '2019-11-07 14:26:26', 11143.46, 11143.46, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2351, '记', 11, NULL, 0, 17, '2019-11-07 14:26:26', 220000, 220000, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2352, '记', 9, NULL, 0, 17, '2019-11-07 14:26:26', 115.8, 115.8, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2353, '记', 21, NULL, 0, 17, '2019-11-07 14:26:26', 49331.7, 49331.7, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2354, '记', 11, NULL, 0, 17, '2019-11-07 14:26:26', 400, 400, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2355, '记', 23, NULL, 0, 17, '2019-11-07 14:26:26', 2, 2, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2356, '记', 5, NULL, 0, 17, '2019-11-07 14:26:26', 27832, 27832, 74, 2019, 1, '2019-01-16', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2357, '记', 11, NULL, 0, 17, '2019-11-07 14:26:26', 6900, 6900, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2358, '记', 23, NULL, 0, 17, '2019-11-07 14:26:26', 3450, 3450, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2359, '记', 2, NULL, 0, 17, '2019-11-07 14:26:26', 576, 576, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2360, '记', 16, NULL, 0, 17, '2019-11-07 14:26:26', 4750, 4750, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2361, '记', 19, NULL, 0, 17, '2019-11-07 14:26:26', 995.3, 995.3, 74, 2019, 3, '2019-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2362, '记', 4, NULL, 0, 17, '2019-11-07 14:26:26', 1219.5, 1219.5, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2363, '记', 16, NULL, 0, 17, '2019-11-07 14:26:26', 44000, 44000, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2364, '记', 28, NULL, 0, 17, '2019-11-07 14:26:26', 510814.58, 510814.58, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher` VALUES (2365, '记', 18, NULL, 0, 17, '2019-11-07 14:26:26', 15190.5, 15190.5, 74, 2019, 6, '2019-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2366, '记', 22, NULL, 0, 17, '2019-11-07 14:26:26', 1032, 1032, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2367, '记', 9, NULL, 0, 17, '2019-11-07 14:26:26', 700, 700, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2368, '记', 21, NULL, 0, 17, '2019-11-07 14:26:26', 57706.9, 57706.9, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2369, '记', 10, NULL, 0, 17, '2019-11-07 14:26:26', 30267.5, 30267.5, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2370, '记', 22, NULL, 0, 17, '2019-11-07 14:26:26', 806.5, 806.5, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2371, '记', 22, NULL, 0, 17, '2019-11-07 14:26:26', 1100, 1100, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2372, '记', 1, NULL, 0, 17, '2019-11-07 14:26:26', 2017.35, 2017.35, 74, 2019, 10, '2019-10-13', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2373, '记', 6, NULL, 0, 17, '2019-11-07 14:26:26', 557, 557, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2374, '记', 10, NULL, 0, 17, '2019-11-07 14:26:26', 2210, 2210, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2375, '记', 22, NULL, 0, 17, '2019-11-07 14:26:26', 31681, 31681, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2376, '记', 2, NULL, 0, 17, '2019-11-07 14:26:26', 10406.6, 10406.6, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2377, '记', 15, NULL, 0, 17, '2019-11-07 14:26:26', 11778.2, 11778.2, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2378, '记', 18, NULL, 0, 17, '2019-11-07 14:26:26', 31033, 31033, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2379, '记', 1, NULL, 0, 17, '2019-11-07 14:26:26', 2, 2, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2380, '记', 9, NULL, 0, 17, '2019-11-07 14:26:26', 60544.8, 60544.8, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2381, '记', 2, NULL, 0, 17, '2019-11-07 14:26:26', 1600, 1600, 74, 2019, 6, '2019-06-26', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2382, '记', 10, NULL, 0, 17, '2019-11-07 14:26:26', 1152.9, 1152.9, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2383, '记', 17, NULL, 0, 17, '2019-11-07 14:26:26', 4200, 4200, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2384, '记', 18, NULL, 0, 17, '2019-11-07 14:26:26', 5194.3, 5194.3, 74, 2019, 3, '2019-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2385, '记', 17, NULL, 0, 17, '2019-11-07 14:26:26', 10563.26, 10563.26, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2386, '记', 5, NULL, 0, 17, '2019-11-07 14:26:26', 5453.01, 5453.01, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2387, '记', 17, NULL, 0, 17, '2019-11-07 14:26:26', 4045.3, 4045.3, 74, 2019, 6, '2019-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2388, '记', 20, NULL, 0, 17, '2019-11-07 14:26:26', 35116.4, 35116.4, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2389, '记', 23, NULL, 0, 17, '2019-11-07 14:26:27', 174461.13, 174461.12999999998, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher` VALUES (2390, '记', 17, NULL, 0, 17, '2019-11-07 14:26:27', 2569.5, 2569.5, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2391, '记', 7, NULL, 0, 17, '2019-11-07 14:26:27', 3790, 3790, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2392, '记', 11, NULL, 0, 17, '2019-11-07 14:26:27', 58391.22, 58391.22, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2393, '记', 2, NULL, 0, 17, '2019-11-07 14:26:27', 18890.8, 18890.8, 74, 2019, 10, '2019-10-13', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2394, '记', 21, NULL, 0, 17, '2019-11-07 14:26:27', 9620.089999999998, 9620.09, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2395, '记', 3, NULL, 0, 17, '2019-11-07 14:26:27', 2928.8, 2928.8, 74, 2019, 6, '2019-06-26', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2396, '记', 21, NULL, 0, 17, '2019-11-07 14:26:27', 7887, 7887, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2397, '记', 3, NULL, 0, 17, '2019-11-07 14:26:27', 5000, 5000, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2398, '记', 14, NULL, 0, 17, '2019-11-07 14:26:27', 49331.7, 49331.7, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2399, '记', 18, NULL, 0, 17, '2019-11-07 14:26:27', 76374.91, 76374.91, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2400, '记', 17, NULL, 0, 17, '2019-11-07 14:26:27', 23841, 23841, 74, 2019, 3, '2019-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2401, '记', 5, NULL, 0, 17, '2019-11-07 14:26:27', 42500, 42500, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2402, '记', 2, NULL, 0, 17, '2019-11-07 14:26:27', 2, 2, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2403, '记', 9, NULL, 0, 17, '2019-11-07 14:26:27', 175977.08000000002, 175977.08, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2404, '记', 18, NULL, 0, 17, '2019-11-07 14:26:27', 48677.2, 48677.2, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2405, '记', 16, NULL, 0, 17, '2019-11-07 14:26:27', 1837.8999999999999, 1837.9, 74, 2019, 6, '2019-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2406, '记', 12, NULL, 0, 17, '2019-11-07 14:26:27', 16848.25, 16848.25, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2407, '记', 24, NULL, 0, 17, '2019-11-07 14:26:27', -269108.29, -269108.29, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher` VALUES (2408, '记', 16, NULL, 0, 17, '2019-11-07 14:26:27', 45818.6, 45818.6, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2409, '记', 20, NULL, 0, 17, '2019-11-07 14:26:27', 677.1, 677.1, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2410, '记', 32, NULL, 0, 17, '2019-11-07 14:26:27', 334862.32, 334862.31999999995, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher` VALUES (2411, '记', 17, NULL, 0, 17, '2019-11-07 14:26:27', 60000, 60000, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2412, '记', 4, NULL, 0, 17, '2019-11-07 14:26:27', 2, 2, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2413, '记', 7, NULL, 0, 17, '2019-11-07 14:26:27', 200000, 200000, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2414, '记', 4, NULL, 0, 17, '2019-11-07 14:26:27', 1290.1, 1290.1, 74, 2019, 6, '2019-06-26', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2415, '记', 20, NULL, 0, 17, '2019-11-07 14:26:27', 17398.67, 17398.67, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2416, '记', 19, NULL, 0, 17, '2019-11-07 14:26:27', 7363.2, 7363.2, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2417, '记', 16, NULL, 0, 17, '2019-11-07 14:26:27', 11388.5, 11388.5, 74, 2019, 3, '2019-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2418, '记', 6, NULL, 0, 17, '2019-11-07 14:26:27', 7285.19, 7285.19, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2419, '记', 9, NULL, 0, 17, '2019-11-07 14:26:27', 1293.7, 1293.7, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2420, '记', 6, NULL, 0, 17, '2019-11-07 14:26:27', 13966.130000000001, 13966.130000000001, 74, 2019, 6, '2019-06-26', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2421, '记', 3, NULL, 0, 17, '2019-11-07 14:26:27', 2179, 2179, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2422, '记', 8, NULL, 0, 17, '2019-11-07 14:26:27', 33743, 33743, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2423, '记', 30, NULL, 0, 17, '2019-11-07 14:26:27', 17764.94, 17764.94, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2424, '记', 15, NULL, 0, 17, '2019-11-07 14:26:27', 30941.140000000003, 30941.140000000003, 74, 2019, 6, '2019-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2425, '记', 19, NULL, 0, 17, '2019-11-07 14:26:27', 11271.16, 11271.16, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2426, '记', 15, NULL, 0, 17, '2019-11-07 14:26:27', 53713.35, 53713.35, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2427, '记', 13, NULL, 0, 17, '2019-11-07 14:26:27', 916.67, 916.67, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2428, '记', 5, NULL, 0, 17, '2019-11-07 14:26:27', 8825.5, 8825.5, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2429, '记', 31, NULL, 0, 17, '2019-11-07 14:26:27', 47105.7, 47105.7, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2430, '记', 5, NULL, 0, 17, '2019-11-07 14:26:27', 22648, 22648, 74, 2019, 6, '2019-06-26', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2431, '记', 1, NULL, 0, 17, '2019-11-07 14:26:27', 2, 2, 74, 2019, 9, '2019-09-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2432, '记', 1, NULL, 0, 17, '2019-11-07 14:26:28', 5158.11, 5158.11, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2433, '记', 16, NULL, 0, 17, '2019-11-07 14:26:28', 1150, 1150, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2434, '记', 8, NULL, 0, 17, '2019-11-07 14:26:28', 8850, 8850, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2435, '记', 15, NULL, 0, 17, '2019-11-07 14:26:28', 42500, 42500, 74, 2019, 3, '2019-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2436, '记', 31, NULL, 0, 17, '2019-11-07 14:26:28', 206, 206, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2437, '记', 12, NULL, 0, 17, '2019-11-07 14:26:28', 17730, 17730, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2438, '记', 24, NULL, 0, 17, '2019-11-07 14:26:28', 31681, 31681, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2439, '记', 4, NULL, 0, 17, '2019-11-07 14:26:28', 6020, 6020, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2440, '记', 12, NULL, 0, 17, '2019-11-07 14:26:28', 30752, 30752, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2441, '记', 12, NULL, 0, 17, '2019-11-07 14:26:28', 0, 0, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2442, '记', 24, NULL, 0, 17, '2019-11-07 14:26:28', 130, 130, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2443, '记', 11, NULL, 0, 17, '2019-11-07 14:26:28', 1592.63, 1592.63, 74, 2019, 9, '2019-09-25', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2444, '记', 6, NULL, 0, 17, '2019-11-07 14:26:28', 29459.47, 29459.47, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2445, '记', 5, NULL, 0, 17, '2019-11-07 14:26:28', 10000, 10000, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2446, '记', 17, NULL, 0, 17, '2019-11-07 14:26:28', 21523, 21523, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2447, '记', 18, NULL, 0, 17, '2019-11-07 14:26:28', 4000, 4000, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2448, '记', 17, NULL, 0, 17, '2019-11-07 14:26:28', 50470.59, 50470.59, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2449, '记', 9, NULL, 0, 17, '2019-11-07 14:26:28', 10932.6, 10932.6, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2450, '记', 5, NULL, 0, 17, '2019-11-07 14:26:28', 2, 2, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2451, '记', 2, NULL, 0, 17, '2019-11-07 14:26:28', 30621.44, 30621.44, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2452, '记', 18, NULL, 0, 17, '2019-11-07 14:26:28', 6895.5, 6895.5, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2453, '记', 1, NULL, 0, 17, '2019-11-07 14:26:28', 8900, 8900, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2454, '记', 13, NULL, 0, 17, '2019-11-07 14:26:28', 0, 0, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2455, '记', 5, NULL, 0, 17, '2019-11-07 14:26:28', 29696.25, 29696.25, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2456, '记', 13, NULL, 0, 17, '2019-11-07 14:26:28', 6000, 6000, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2457, '记', 25, NULL, 0, 17, '2019-11-07 14:26:28', 16848.27, 16848.27, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2458, '记', 13, NULL, 0, 17, '2019-11-07 14:26:28', 5064.81, 5064.81, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2459, '记', 25, NULL, 0, 17, '2019-11-07 14:26:28', 2854.3599999999997, 2854.36, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2460, '记', 10, NULL, 0, 17, '2019-11-07 14:26:28', 19943.79, 19943.79, 74, 2019, 9, '2019-09-25', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2461, '记', 10, NULL, 0, 17, '2019-11-07 14:26:28', 12552.5, 12552.5, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2462, '记', 5, NULL, 0, 17, '2019-11-07 14:26:28', 7622.21, 7622.21, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2463, '记', 6, NULL, 0, 17, '2019-11-07 14:26:28', 37444.3, 37444.3, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2464, '记', 6, NULL, 0, 17, '2019-11-07 14:26:28', 16000, 16000, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2465, '记', 18, NULL, 0, 17, '2019-11-07 14:26:28', 19440.89, 19440.89, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2466, '记', 19, NULL, 0, 17, '2019-11-07 14:26:29', 26566.45, 26566.45, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2467, '记', 18, NULL, 0, 17, '2019-11-07 14:26:29', 71344.7, 71344.7, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2468, '记', 19, NULL, 0, 17, '2019-11-07 14:26:29', 1750, 1750, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2469, '记', 3, NULL, 0, 17, '2019-11-07 14:26:29', 31920, 31920, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2470, '记', 9, NULL, 0, 17, '2019-11-07 14:26:29', 1461.9, 1461.9, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2471, '记', 11, NULL, 0, 17, '2019-11-07 14:26:29', 2665.13, 2665.13, 74, 2019, 6, '2019-06-26', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2472, '记', 26, NULL, 0, 17, '2019-11-07 14:26:29', 4224.6, 4224.6, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2473, '记', 6, NULL, 0, 17, '2019-11-07 14:26:29', 27141.6, 27141.6, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2474, '记', 3, NULL, 0, 17, '2019-11-07 14:26:29', 9620.09, 9620.09, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2475, '记', 6, NULL, 0, 17, '2019-11-07 14:26:29', 9346, 9346, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2476, '记', 14, NULL, 0, 17, '2019-11-07 14:26:29', 10000, 10000, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2477, '记', 14, NULL, 0, 17, '2019-11-07 14:26:29', 11197, 11197, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2478, '记', 26, NULL, 0, 17, '2019-11-07 14:26:29', 33108.1, 33108.1, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2479, '记', 9, NULL, 0, 17, '2019-11-07 14:26:29', 2, 2, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2480, '记', 2, NULL, 0, 17, '2019-11-07 14:26:29', 11000, 11000, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2481, '记', 10, NULL, 0, 17, '2019-11-07 14:26:29', 44344.42, 44344.42, 74, 2019, 6, '2019-06-26', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2482, '记', 3, NULL, 0, 17, '2019-11-07 14:26:29', 6000, 6000, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2483, '记', 7, NULL, 0, 17, '2019-11-07 14:26:29', 20000, 20000, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2484, '记', 11, NULL, 0, 17, '2019-11-07 14:26:29', 1290.1, 1290.1, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2485, '记', 8, NULL, 0, 17, '2019-11-07 14:26:29', 79510.39000000001, 79510.39000000001, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2486, '记', 7, NULL, 0, 17, '2019-11-07 14:26:29', 11282.6, 11282.6, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2487, '记', 19, NULL, 0, 17, '2019-11-07 14:26:29', 654.44, 654.44, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2488, '记', 7, NULL, 0, 17, '2019-11-07 14:26:29', 49662.2, 49662.2, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2489, '记', 19, NULL, 0, 17, '2019-11-07 14:26:29', 4595.4, 4595.4, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2490, '记', 16, NULL, 0, 17, '2019-11-07 14:26:29', 8452.6, 8452.6, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2491, '记', 16, NULL, 0, 17, '2019-11-07 14:26:29', 2800, 2800, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2492, '记', 28, NULL, 0, 17, '2019-11-07 14:26:29', 212782.88, 212782.88, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher` VALUES (2493, '记', 15, NULL, 0, 17, '2019-11-07 14:26:29', 6000, 6000, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2494, '记', 7, NULL, 0, 17, '2019-11-07 14:26:29', 8989.4, 8989.4, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2495, '记', 2, NULL, 0, 17, '2019-11-07 14:26:29', 4874, 4874, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2496, '记', 27, NULL, 0, 17, '2019-11-07 14:26:29', 36988.96, 36988.96, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2497, '记', 27, NULL, 0, 17, '2019-11-07 14:26:29', 4874, 4874, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2498, '记', 19, NULL, 0, 17, '2019-11-07 14:26:29', 37582, 37582, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2499, '记', 15, NULL, 0, 17, '2019-11-07 14:26:29', 10709, 10709, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2500, '记', 8, NULL, 0, 17, '2019-11-07 14:26:29', 8452.6, 8452.6, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2501, '记', 9, NULL, 0, 17, '2019-11-07 14:26:29', 7829.099999999999, 7829.1, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2502, '记', 1, NULL, 0, 17, '2019-11-07 14:26:29', 6419.7, 6419.7, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2503, '记', 12, NULL, 0, 17, '2019-11-07 14:26:29', 2928.8, 2928.8, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2504, '记', 8, NULL, 0, 17, '2019-11-07 14:26:29', 25533, 25533, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2505, '记', 4, NULL, 0, 17, '2019-11-07 14:26:29', 50000, 50000, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2506, '记', 7, NULL, 0, 17, '2019-11-07 14:26:29', 2665.13, 2665.13, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2507, '记', 8, NULL, 0, 17, '2019-11-07 14:26:29', 56492.57, 56492.57, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2508, '记', 8, NULL, 0, 17, '2019-11-07 14:26:29', 50000, 50000, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2509, '记', 17, NULL, 0, 17, '2019-11-07 14:26:29', 20000, 20000, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2510, '记', 19, NULL, 0, 17, '2019-11-07 14:26:29', 10821, 10821, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2511, '记', 1, NULL, 0, 17, '2019-11-07 14:26:30', 9983, 9983, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2512, '记', 17, NULL, 0, 17, '2019-11-07 14:26:30', 1000, 1000, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2513, '记', 19, NULL, 0, 17, '2019-11-07 14:26:30', 33743, 33743, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2514, '记', 16, NULL, 0, 17, '2019-11-07 14:26:30', 30000, 30000, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2515, '记', 12, NULL, 0, 17, '2019-11-07 14:26:30', 25681, 25681, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2516, '记', 28, NULL, 0, 17, '2019-11-07 14:26:30', 1051.6, 1051.6, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2517, '记', 9, NULL, 0, 17, '2019-11-07 14:26:30', 29074.620000000003, 29074.620000000003, 74, 2019, 4, '2019-04-29', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2518, '记', 8, NULL, 0, 17, '2019-11-07 14:26:30', 26474, 26474, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2519, '记', 7, NULL, 0, 17, '2019-11-07 14:26:30', 1757.35, 1757.35, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2520, '记', 18, NULL, 0, 17, '2019-11-07 14:26:30', 17581.809999999998, 17581.809999999998, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2521, '记', 5, NULL, 0, 17, '2019-11-07 14:26:30', 110000, 110000, 74, 2019, 4, '2019-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2522, '记', 4, NULL, 0, 17, '2019-11-07 14:26:30', 5000, 5000, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2523, '记', 14, NULL, 0, 17, '2019-11-07 14:26:30', 25186.45, 25186.45, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2524, '记', 20, NULL, 0, 17, '2019-11-07 14:26:30', 7874.08, 7874.08, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2525, '记', 6, NULL, 0, 17, '2019-11-07 14:26:30', 2458.2, 2458.2, 74, 2019, 9, '2019-09-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2526, '记', 13, NULL, 0, 17, '2019-11-07 14:26:30', 947.12, 947.12, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2527, '记', 13, NULL, 0, 17, '2019-11-07 14:26:30', 5064.8, 5064.8, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2528, '记', 14, NULL, 0, 17, '2019-11-07 14:26:30', 50544.8, 50544.8, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2529, '记', 21, NULL, 0, 17, '2019-11-07 14:26:30', 24968.42, 24968.420000000002, 74, 2019, 6, '2019-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2530, '记', 6, NULL, 0, 17, '2019-11-07 14:26:30', 23841, 23841, 74, 2019, 4, '2019-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2531, '记', 26, NULL, 0, 17, '2019-11-07 14:26:30', 51549.99, 51549.990000000005, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2532, '记', 5, NULL, 0, 17, '2019-11-07 14:26:30', 1400, 1400, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2533, '记', 1, NULL, 0, 17, '2019-11-07 14:26:30', 300000, 300000, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2534, '记', 1, NULL, 0, 17, '2019-11-07 14:26:30', 836.4, 836.4, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2535, '记', 3, NULL, 0, 17, '2019-11-07 14:26:30', 7708.5, 7708.5, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2536, '记', 2, NULL, 0, 17, '2019-11-07 14:26:30', 5961.200000000001, 5961.200000000001, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2537, '记', 17, NULL, 0, 17, '2019-11-07 14:26:30', 15069.3, 15069.3, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2538, '记', 21, NULL, 0, 17, '2019-11-07 14:26:30', 0, 0, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2539, '记', 11, NULL, 0, 17, '2019-11-07 14:26:30', 6095.1, 6095.1, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2540, '记', 9, NULL, 0, 17, '2019-11-07 14:26:30', 79582.12000000002, 79582.12000000001, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2541, '记', 9, NULL, 0, 17, '2019-11-07 14:26:30', 5360.2, 5360.200000000001, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2542, '记', 18, NULL, 0, 17, '2019-11-07 14:26:30', 43916.25, 43916.25000000001, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2543, '记', 6, NULL, 0, 17, '2019-11-07 14:26:30', 1135, 1135, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2544, '记', 17, NULL, 0, 17, '2019-11-07 14:26:30', 176182, 176182, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2545, '记', 8, NULL, 0, 17, '2019-11-07 14:26:30', 7124.71, 7124.71, 74, 2019, 4, '2019-04-29', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2546, '记', 4, NULL, 0, 17, '2019-11-07 14:26:30', 11388.5, 11388.5, 74, 2019, 4, '2019-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2547, '记', 3, NULL, 0, 17, '2019-11-07 14:26:30', 10000, 10000, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2548, '记', 15, NULL, 0, 17, '2019-11-07 14:26:30', 1300, 1300, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2549, '记', 31, NULL, 0, 17, '2019-11-07 14:26:30', 153298.78, 153298.77999999997, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher` VALUES (2550, '记', 7, NULL, 0, 17, '2019-11-07 14:26:30', 15732.57, 15732.57, 74, 2019, 9, '2019-09-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2551, '记', 14, NULL, 0, 17, '2019-11-07 14:26:30', 21729.9, 21729.9, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2552, '记', 15, NULL, 0, 17, '2019-11-07 14:26:30', 4252.2699999999995, 4252.27, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2553, '记', 20, NULL, 0, 17, '2019-11-07 14:26:30', 813.6, 813.6, 74, 2019, 6, '2019-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2554, '记', 5, NULL, 0, 17, '2019-11-07 14:26:30', 62500, 62500, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2555, '记', 6, NULL, 0, 17, '2019-11-07 14:26:30', 1219.5, 1219.5, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2556, '记', 2, NULL, 0, 17, '2019-11-07 14:26:30', 40000, 40000, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2557, '记', 27, NULL, 0, 17, '2019-11-07 14:26:30', 2569.5, 2569.5, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2558, '记', 21, NULL, 0, 17, '2019-11-07 14:26:30', 10585.21, 10585.21, 74, 2019, 3, '2019-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2559, '记', 2, NULL, 0, 17, '2019-11-07 14:26:31', 10862.6, 10862.6, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2560, '记', 20, NULL, 0, 17, '2019-11-07 14:26:31', 10000, 10000, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2561, '记', 1, NULL, 0, 17, '2019-11-07 14:26:31', 1302, 1302, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2562, '记', 2, NULL, 0, 17, '2019-11-07 14:26:31', 199, 199, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2563, '记', 10, NULL, 0, 17, '2019-11-07 14:26:31', 3073.7700000000004, 3073.77, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2564, '记', 30, NULL, 0, 17, '2019-11-07 14:26:31', 289.65, 289.65, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2565, '记', 10, NULL, 0, 17, '2019-11-07 14:26:31', 50132.75, 50132.75, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2566, '记', 18, NULL, 0, 17, '2019-11-07 14:26:31', 17014.929999999997, 17014.929999999997, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2567, '记', 22, NULL, 0, 17, '2019-11-07 14:26:31', 76374.91, 76374.91, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2568, '记', 10, NULL, 0, 17, '2019-11-07 14:26:31', 12118.03, 12118.03, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2569, '记', 8, NULL, 0, 17, '2019-11-07 14:26:31', 7654.9, 7654.9, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2570, '记', 17, NULL, 0, 17, '2019-11-07 14:26:31', 37, 37, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2571, '记', 29, NULL, 0, 17, '2019-11-07 14:26:31', 3929, 3929, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2572, '记', 6, NULL, 0, 17, '2019-11-07 14:26:31', 14334.18, 14334.18, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2573, '记', 16, NULL, 0, 17, '2019-11-07 14:26:31', 9969.75, 9969.75, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2574, '记', 16, NULL, 0, 17, '2019-11-07 14:26:31', 22648, 22648, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2575, '记', 4, NULL, 0, 17, '2019-11-07 14:26:31', 42572.5, 42572.5, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2576, '记', 3, NULL, 0, 17, '2019-11-07 14:26:31', 12113.2, 12113.2, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2577, '记', 8, NULL, 0, 17, '2019-11-07 14:26:31', 580, 580, 74, 2019, 9, '2019-09-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2578, '记', 1, NULL, 0, 17, '2019-11-07 14:26:31', 49995.4, 49995.4, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2579, '记', 15, NULL, 0, 17, '2019-11-07 14:26:31', 3406.9, 3406.9, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2580, '记', 4, NULL, 0, 17, '2019-11-07 14:26:31', 33268, 33268, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2581, '记', 12, NULL, 0, 17, '2019-11-07 14:26:31', 1600, 1600, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2582, '记', 16, NULL, 0, 17, '2019-11-07 14:26:31', 20497, 20497, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2583, '记', 24, NULL, 0, 17, '2019-11-07 14:26:31', 17547.859999999993, 17547.86, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2584, '记', 20, NULL, 0, 17, '2019-11-07 14:26:31', 19885.65, 19885.65, 74, 2019, 3, '2019-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2585, '记', 19, NULL, 0, 17, '2019-11-07 14:26:31', 10000, 10000, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2586, '记', 3, NULL, 0, 17, '2019-11-07 14:26:31', 8010, 8010, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2587, '记', 19, NULL, 0, 17, '2019-11-07 14:26:31', 17764.94, 17764.94, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2588, '记', 23, NULL, 0, 17, '2019-11-07 14:26:31', 0, 0, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2589, '记', 11, NULL, 0, 17, '2019-11-07 14:26:31', 15091.16, 15091.16, 74, 2017, 7, '2017-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2590, '记', 7, NULL, 0, 17, '2019-11-07 14:26:31', 30594.2, 30594.2, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2591, '记', 11, NULL, 0, 17, '2019-11-07 14:26:31', 13342.94, 13342.94, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2592, '记', 16, NULL, 0, 17, '2019-11-07 14:26:31', 15763.5, 15763.5, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2593, '记', 28, NULL, 0, 17, '2019-11-07 14:26:31', 88275.31, 88275.31, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2594, '记', 15, NULL, 0, 17, '2019-11-07 14:26:31', 7508.400000000001, 7508.4, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2595, '记', 5, NULL, 0, 17, '2019-11-07 14:26:31', 6150, 6150, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2596, '记', 3, NULL, 0, 17, '2019-11-07 14:26:31', 23611, 23611, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2597, '记', 4, NULL, 0, 17, '2019-11-07 14:26:31', 28836, 28836, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2598, '记', 7, NULL, 0, 17, '2019-11-07 14:26:31', 5691.22, 5691.22, 74, 2019, 4, '2019-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2599, '记', 25, NULL, 0, 17, '2019-11-07 14:26:31', 30752, 30752, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2600, '记', 3, NULL, 0, 17, '2019-11-07 14:26:31', 1600, 1600, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2601, '记', 15, NULL, 0, 17, '2019-11-07 14:26:31', 25410.64, 25410.64, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2602, '记', 16, NULL, 0, 17, '2019-11-07 14:26:32', 1619.5, 1619.5, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2603, '记', 13, NULL, 0, 17, '2019-11-07 14:26:32', 26509, 26509, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2604, '记', 6, NULL, 0, 17, '2019-11-07 14:26:32', 6758.91, 6758.91, 74, 2019, 3, '2019-03-22', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2605, '记', 4, NULL, 0, 17, '2019-11-07 14:26:32', 31467.92, 31467.92, 74, 2018, 6, '2018-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2606, '记', 18, NULL, 0, 17, '2019-11-07 14:26:32', 46830.3, 46830.3, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2607, '记', 11, NULL, 0, 17, '2019-11-07 14:26:32', 76921.06, 76921.06, 74, 2019, 4, '2019-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2608, '记', 6, NULL, 0, 17, '2019-11-07 14:26:32', 113290.70000000003, 113290.7, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2609, '记', 4, NULL, 0, 17, '2019-11-07 14:26:32', 2458.3, 2458.3, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2610, '记', 16, NULL, 0, 17, '2019-11-07 14:26:32', 2569.5, 2569.5, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2611, '记', 9, NULL, 0, 17, '2019-11-07 14:26:32', 47105.7, 47105.7, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2612, '记', 8, NULL, 0, 17, '2019-11-07 14:26:32', 1575.9, 1575.9, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2613, '记', 24, NULL, 0, 17, '2019-11-07 14:26:32', 1250, 1250, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2614, '记', 4, NULL, 0, 17, '2019-11-07 14:26:32', 49446, 49446, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2615, '记', 12, NULL, 0, 17, '2019-11-07 14:26:32', 2064, 2064, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2616, '记', 24, NULL, 0, 17, '2019-11-07 14:26:32', 4580.4, 4580.4, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2617, '记', 10, NULL, 0, 17, '2019-11-07 14:26:32', 31033, 31033, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2618, '记', 22, NULL, 0, 17, '2019-11-07 14:26:32', 160657.30000000002, 160657.3, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2619, '记', 21, NULL, 0, 17, '2019-11-07 14:26:32', 996, 996, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2620, '记', 22, NULL, 0, 17, '2019-11-07 14:26:32', 72869.23, 72869.23000000001, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2621, '记', 2, NULL, 0, 17, '2019-11-07 14:26:32', 901, 901, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2622, '记', 18, NULL, 0, 17, '2019-11-07 14:26:32', 57443.4, 57443.4, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2623, '记', 2, NULL, 0, 17, '2019-11-07 14:26:32', 2745.3, 2745.3, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2624, '记', 10, NULL, 0, 17, '2019-11-07 14:26:32', 5586.1, 5586.1, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2625, '记', 17, NULL, 0, 17, '2019-11-07 14:26:32', 21716, 21716, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2626, '记', 7, NULL, 0, 17, '2019-11-07 14:26:32', 33591.9, 33591.9, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2627, '记', 7, NULL, 0, 17, '2019-11-07 14:26:32', 2578.5, 2578.5, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2628, '记', 17, NULL, 0, 17, '2019-11-07 14:26:32', 2200, 2200, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2629, '记', 22, NULL, 0, 17, '2019-11-07 14:26:32', 5017.799999999999, 5017.799999999999, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2630, '记', 24, NULL, 0, 17, '2019-11-07 14:26:32', 5862.44, 5862.44, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2631, '记', 10, NULL, 0, 17, '2019-11-07 14:26:32', 3208.47, 3208.47, 74, 2019, 4, '2019-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2632, '记', 15, NULL, 0, 17, '2019-11-07 14:26:32', 30997.5, 30997.5, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2633, '记', 5, NULL, 0, 17, '2019-11-07 14:26:32', 24831, 24831, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2634, '记', 8, NULL, 0, 17, '2019-11-07 14:26:32', 0, 0, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2635, '记', 15, NULL, 0, 17, '2019-11-07 14:26:32', 17014.94, 17014.94, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2636, '记', 7, NULL, 0, 17, '2019-11-07 14:26:32', 3500, 3500, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2637, '记', 23, NULL, 0, 17, '2019-11-07 14:26:32', 17398.67, 17398.67, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2638, '记', 5, NULL, 0, 17, '2019-11-07 14:26:32', 1219.5, 1219.5, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2639, '记', 11, NULL, 0, 17, '2019-11-07 14:26:32', 12373.3, 12373.3, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2640, '记', 23, NULL, 0, 17, '2019-11-07 14:26:32', 32525, 32525, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2641, '记', 22, NULL, 0, 17, '2019-11-07 14:26:32', 151215.92, 151215.92, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher` VALUES (2642, '记', 23, NULL, 0, 17, '2019-11-07 14:26:32', 255, 255, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2643, '记', 10, NULL, 0, 17, '2019-11-07 14:26:32', 17297.83, 17297.83, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2644, '记', 11, NULL, 0, 17, '2019-11-07 14:26:32', 1071, 1071, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2645, '记', 10, NULL, 0, 17, '2019-11-07 14:26:32', 32225.060000000005, 32225.06, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2646, '记', 11, NULL, 0, 17, '2019-11-07 14:26:32', 772, 772, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2647, '记', 1, NULL, 0, 17, '2019-11-07 14:26:32', 24732, 24732, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2648, '记', 1, NULL, 0, 17, '2019-11-07 14:26:32', 1302, 1302, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2649, '记', 23, NULL, 0, 17, '2019-11-07 14:26:32', 0, 0, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2650, '记', 19, NULL, 0, 17, '2019-11-07 14:26:32', 51545.39, 51545.39, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2651, '记', 6, NULL, 0, 17, '2019-11-07 14:26:33', 2140, 2140, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2652, '记', 16, NULL, 0, 17, '2019-11-07 14:26:33', 177845.02000000005, 177845.02, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2653, '记', 23, NULL, 0, 17, '2019-11-07 14:26:33', 5740.25, 5740.25, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2654, '记', 14, NULL, 0, 17, '2019-11-07 14:26:33', 2, 2, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2655, '记', 26, NULL, 0, 17, '2019-11-07 14:26:33', 179113.41999999998, 179113.42000000004, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher` VALUES (2656, '记', 14, NULL, 0, 17, '2019-11-07 14:26:33', 39454.4, 39454.4, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2657, '记', 6, NULL, 0, 17, '2019-11-07 14:26:33', 19168, 19168, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2658, '记', 2, NULL, 0, 17, '2019-11-07 14:26:33', 747.5, 747.5, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2659, '记', 2, NULL, 0, 17, '2019-11-07 14:26:33', 382.57, 382.57, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2660, '记', 10, NULL, 0, 17, '2019-11-07 14:26:33', 392.34, 392.34, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2661, '记', 22, NULL, 0, 17, '2019-11-07 14:26:33', 27242, 27242, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2662, '记', 22, NULL, 0, 17, '2019-11-07 14:26:33', 44427.8, 44427.8, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2663, '记', 11, NULL, 0, 17, '2019-11-07 14:26:33', 2715.97, 2715.97, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2664, '记', 11, NULL, 0, 17, '2019-11-07 14:26:33', 10975.52, 10975.52, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2665, '记', 20, NULL, 0, 17, '2019-11-07 14:26:33', 53268, 53268, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2666, '记', 4, NULL, 0, 17, '2019-11-07 14:26:33', 22700, 22700, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2667, '记', 20, NULL, 0, 17, '2019-11-07 14:26:33', 49662.2, 49662.2, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2668, '记', 9, NULL, 0, 17, '2019-11-07 14:26:33', 2, 2, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2669, '记', 20, NULL, 0, 17, '2019-11-07 14:26:33', 42922.94, 42922.94, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2670, '记', 5, NULL, 0, 17, '2019-11-07 14:26:33', 1300, 1300, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2671, '记', 13, NULL, 0, 17, '2019-11-07 14:26:33', 20000, 20000, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2672, '记', 25, NULL, 0, 17, '2019-11-07 14:26:33', 4700, 4700, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2673, '记', 13, NULL, 0, 17, '2019-11-07 14:26:33', 5107.2, 5107.2, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2674, '记', 9, NULL, 0, 17, '2019-11-07 14:26:33', 7159.04, 7159.04, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2675, '记', 7, NULL, 0, 17, '2019-11-07 14:26:33', 807, 807, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2676, '记', 1, NULL, 0, 17, '2019-11-07 14:26:33', 1380, 1380, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2677, '记', 3, NULL, 0, 17, '2019-11-07 14:26:33', 11078.2, 11078.2, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2678, '记', 21, NULL, 0, 17, '2019-11-07 14:26:33', 4898.13, 4898.13, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2679, '记', 21, NULL, 0, 17, '2019-11-07 14:26:33', 10406.6, 10406.6, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2680, '记', 21, NULL, 0, 17, '2019-11-07 14:26:33', 2000, 2000, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2681, '记', 10, NULL, 0, 17, '2019-11-07 14:26:33', 1482, 1482, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2682, '记', 12, NULL, 0, 17, '2019-11-07 14:26:33', 70752.98, 70752.97999999998, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2683, '记', 3, NULL, 0, 17, '2019-11-07 14:26:33', 3737.9, 3737.9, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2684, '记', 21, NULL, 0, 17, '2019-11-07 14:26:33', 17764.94, 17764.94, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2685, '记', 12, NULL, 0, 17, '2019-11-07 14:26:33', 6037.4, 6037.4, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2686, '记', 8, NULL, 0, 17, '2019-11-07 14:26:33', 10000, 10000, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2687, '记', 8, NULL, 0, 17, '2019-11-07 14:26:33', 3844.1, 3844.1, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2688, '记', 21, NULL, 0, 17, '2019-11-07 14:26:33', 26047, 26047, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2689, '记', 4, NULL, 0, 17, '2019-11-07 14:26:34', 12891.64, 12891.64, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2690, '记', 12, NULL, 0, 17, '2019-11-07 14:26:34', 727, 727, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2691, '记', 20, NULL, 0, 17, '2019-11-07 14:26:34', 31920, 31920, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2692, '记', 24, NULL, 0, 17, '2019-11-07 14:26:34', 1548.8, 1548.8, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2693, '记', 27, NULL, 0, 17, '2019-11-07 14:26:34', 2569.5, 2569.5, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2694, '记', 20, NULL, 0, 17, '2019-11-07 14:26:34', 5822.78, 5822.78, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2695, '记', 15, NULL, 0, 17, '2019-11-07 14:26:34', 4130.0599999999995, 4130.0599999999995, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2696, '记', 5, NULL, 0, 17, '2019-11-07 14:26:34', 2, 2, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2697, '记', 9, NULL, 0, 17, '2019-11-07 14:26:34', 19250.65, 19250.65, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2698, '记', 20, NULL, 0, 17, '2019-11-07 14:26:34', 7708.5, 7708.5, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2699, '记', 14, NULL, 0, 17, '2019-11-07 14:26:34', 12, 12, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2700, '记', 11, NULL, 0, 17, '2019-11-07 14:26:34', 8566.3, 8566.3, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2701, '记', 14, NULL, 0, 17, '2019-11-07 14:26:34', 51992.5, 51992.5, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2702, '记', 5, NULL, 0, 17, '2019-11-07 14:26:34', 5000, 5000, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2703, '记', 13, NULL, 0, 17, '2019-11-07 14:26:34', 163453.12, 163453.12, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2704, '记', 29, NULL, 0, 17, '2019-11-07 14:26:34', 1368, 1368, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2705, '记', 6, NULL, 0, 17, '2019-11-07 14:26:34', 80, 80, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2706, '记', 26, NULL, 0, 17, '2019-11-07 14:26:34', 1900, 1900, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2707, '记', 23, NULL, 0, 17, '2019-11-07 14:26:34', 29457.5, 29457.5, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2708, '记', 9, NULL, 0, 17, '2019-11-07 14:26:34', 22623.389999999996, 22623.39, 74, 2019, 9, '2019-09-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2709, '记', 1, NULL, 0, 17, '2019-11-07 14:26:34', 17719.56, 17719.56, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2710, '记', 16, NULL, 0, 17, '2019-11-07 14:26:34', 1400, 1400, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2711, '记', 4, NULL, 0, 17, '2019-11-07 14:26:34', 14636, 14636, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2712, '记', 11, NULL, 0, 17, '2019-11-07 14:26:34', 5000, 5000, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2713, '记', 27, NULL, 0, 17, '2019-11-07 14:26:34', 475.2, 475.2, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2714, '记', 1, NULL, 0, 17, '2019-11-07 14:26:34', 11673.6, 11673.6, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2715, '记', 15, NULL, 0, 17, '2019-11-07 14:26:34', 6232.13, 6232.13, 74, 2019, 9, '2019-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2716, '记', 21, NULL, 0, 17, '2019-11-07 14:26:34', 2569.5, 2569.5, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2717, '记', 3, NULL, 0, 17, '2019-11-07 14:26:34', 46240, 46240, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2718, '记', 14, NULL, 0, 17, '2019-11-07 14:26:34', 25.93, 25.93, 74, 2019, 9, '2019-09-25', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2719, '记', 1, NULL, 0, 17, '2019-11-07 14:26:34', 5000, 5000, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2720, '记', 15, NULL, 0, 17, '2019-11-07 14:26:34', 151690.18, 151690.18, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2721, '记', 12, NULL, 0, 17, '2019-11-07 14:26:34', 28575.7, 28575.7, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2722, '记', 4, NULL, 0, 17, '2019-11-07 14:26:34', 1219.5, 1219.5, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2723, '记', 14, NULL, 0, 17, '2019-11-07 14:26:35', 1700, 1700, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2724, '记', 9, NULL, 0, 17, '2019-11-07 14:26:35', 200, 200, 74, 2019, 5, '2019-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2725, '记', 28, NULL, 0, 17, '2019-11-07 14:26:35', 55541.52, 55541.520000000004, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2726, '记', 5, NULL, 0, 17, '2019-11-07 14:26:35', 13913.1, 13913.1, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2727, '记', 27, NULL, 0, 17, '2019-11-07 14:26:35', 255, 255, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2728, '记', 15, NULL, 0, 17, '2019-11-07 14:26:35', 5390, 5390, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2729, '记', 10, NULL, 0, 17, '2019-11-07 14:26:35', 200, 200, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2730, '记', 25, NULL, 0, 17, '2019-11-07 14:26:35', 467, 467, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2731, '记', 2, NULL, 0, 17, '2019-11-07 14:26:35', 2747.36, 2747.36, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2732, '记', 22, NULL, 0, 17, '2019-11-07 14:26:35', 2000, 2000, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2733, '记', 7, NULL, 0, 17, '2019-11-07 14:26:35', 64274.600000000006, 64274.6, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2734, '记', 10, NULL, 0, 17, '2019-11-07 14:26:35', 5000, 5000, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2735, '记', 22, NULL, 0, 17, '2019-11-07 14:26:35', 60061.68, 60061.68, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2736, '记', 26, NULL, 0, 17, '2019-11-07 14:26:35', 36458.1, 36458.1, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2737, '记', 10, NULL, 0, 17, '2019-11-07 14:26:35', 27658.06, 27658.06, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2738, '记', 2, NULL, 0, 17, '2019-11-07 14:26:35', 3341.7, 3341.7, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2739, '记', 13, NULL, 0, 17, '2019-11-07 14:26:35', 20, 20, 74, 2019, 9, '2019-09-25', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2740, '记', 12, NULL, 0, 17, '2019-11-07 14:26:35', 13000, 13000, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2741, '记', 16, NULL, 0, 17, '2019-11-07 14:26:35', 25533, 25533, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2742, '记', 13, NULL, 0, 17, '2019-11-07 14:26:35', 25000, 25000, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2743, '记', 24, NULL, 0, 17, '2019-11-07 14:26:35', 107.79, 107.79, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2744, '记', 15, NULL, 0, 17, '2019-11-07 14:26:35', 10025.9, 10025.9, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2745, '记', 7, NULL, 0, 17, '2019-11-07 14:26:35', 2299.2, 2299.2, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2746, '记', 8, NULL, 0, 17, '2019-11-07 14:26:35', 27775.550000000003, 27775.550000000003, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2747, '记', 19, NULL, 0, 17, '2019-11-07 14:26:35', 32444.25, 32444.25, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2748, '记', 9, NULL, 0, 17, '2019-11-07 14:26:35', 1738.9, 1738.9, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2749, '记', 11, NULL, 0, 17, '2019-11-07 14:26:35', 3000, 3000, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2750, '记', 3, NULL, 0, 17, '2019-11-07 14:26:35', 3760.6, 3760.6, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2751, '记', 26, NULL, 0, 17, '2019-11-07 14:26:35', 698, 698, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2752, '记', 11, NULL, 0, 17, '2019-11-07 14:26:35', 38147.99, 38147.99, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2753, '记', 6, NULL, 0, 17, '2019-11-07 14:26:35', 8247.3, 8247.3, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2754, '记', 23, NULL, 0, 17, '2019-11-07 14:26:35', 80214.28, 80214.28, 74, 2018, 10, '2018-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2755, '记', 21, NULL, 0, 17, '2019-11-07 14:26:35', 1516.72, 1516.72, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2756, '记', 25, NULL, 0, 17, '2019-11-07 14:26:35', 10000, 10000, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2757, '记', 12, NULL, 0, 17, '2019-11-07 14:26:35', 3000, 3000, 74, 2019, 9, '2019-09-25', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2758, '记', 3, NULL, 0, 17, '2019-11-07 14:26:35', 3000, 3000, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2759, '记', 25, NULL, 0, 17, '2019-11-07 14:26:35', 212782.87999999998, 212782.88, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2760, '记', 13, NULL, 0, 17, '2019-11-07 14:26:35', 2800, 2800, 74, 2017, 9, '2017-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2761, '记', 17, NULL, 0, 17, '2019-11-07 14:26:35', 17581.8, 17581.8, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2762, '记', 14, NULL, 0, 17, '2019-11-07 14:26:35', 17581.8, 17581.8, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2763, '记', 6, NULL, 0, 17, '2019-11-07 14:26:35', 5000, 5000, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2764, '记', 18, NULL, 0, 17, '2019-11-07 14:26:35', 1930.77, 1930.77, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2765, '记', 7, NULL, 0, 17, '2019-11-07 14:26:35', 77746.02999999998, 77746.03, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2766, '记', 8, NULL, 0, 17, '2019-11-07 14:26:35', 32239.68, 32239.68, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2767, '记', 16, NULL, 0, 17, '2019-11-07 14:26:35', 17398.67, 17398.67, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2768, '记', 1, NULL, 0, 17, '2019-11-07 14:26:35', 999, 999, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2769, '记', 8, NULL, 0, 17, '2019-11-07 14:26:36', 10000, 10000, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2770, '记', 24, NULL, 0, 17, '2019-11-07 14:26:36', 219909.53, 219909.53, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher` VALUES (2771, '记', 20, NULL, 0, 17, '2019-11-07 14:26:36', 6973.6, 6973.6, 74, 2017, 11, '2017-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2772, '记', 12, NULL, 0, 17, '2019-11-07 14:26:36', 14, 14, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2773, '记', 19, NULL, 0, 17, '2019-11-07 14:26:36', 4534.47, 4534.47, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2774, '记', 7, NULL, 0, 17, '2019-11-07 14:26:36', 9681, 9681, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2775, '记', 8, NULL, 0, 17, '2019-11-07 14:26:36', 37582, 37582, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2776, '记', 5, NULL, 0, 17, '2019-11-07 14:26:36', 6466.06, 6466.06, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2777, '记', 21, NULL, 0, 17, '2019-11-07 14:26:36', 2569.5, 2569.5, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2778, '记', 4, NULL, 0, 17, '2019-11-07 14:26:36', 4862.9, 4862.9, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2779, '记', 9, NULL, 0, 17, '2019-11-07 14:26:36', 11560, 11560, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2780, '记', 14, NULL, 0, 17, '2019-11-07 14:26:36', 174447.53000000003, 174447.53, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2781, '记', 14, NULL, 0, 17, '2019-11-07 14:26:36', 3930.8, 3930.8, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2782, '记', 6, NULL, 0, 17, '2019-11-07 14:26:36', 5196.4, 5196.4, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2783, '记', 6, NULL, 0, 17, '2019-11-07 14:26:36', 2, 2, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2784, '记', 13, NULL, 0, 17, '2019-11-07 14:26:36', 23517.3, 23517.300000000003, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2785, '记', 13, NULL, 0, 17, '2019-11-07 14:26:36', 30000, 30000, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2786, '记', 30, NULL, 0, 17, '2019-11-07 14:26:36', 132465.63, 132465.63, 74, 2018, 3, '2018-03-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2787, '记', 1, NULL, 0, 17, '2019-11-07 14:26:36', 41030.130000000005, 41030.130000000005, 74, 2018, 12, '2018-12-21', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2788, '记', 11, NULL, 0, 17, '2019-11-07 14:26:36', 10476.759999999998, 10476.759999999998, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2789, '记', 6, NULL, 0, 17, '2019-11-07 14:26:36', 8138.1, 8138.1, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2790, '记', 13, NULL, 0, 17, '2019-11-07 14:26:36', 2.32, 2.32, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2791, '记', 9, NULL, 0, 17, '2019-11-07 14:26:36', 2500, 2500, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2792, '记', 7, NULL, 0, 17, '2019-11-07 14:26:36', 8295.97, 8295.97, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2793, '记', 3, NULL, 0, 17, '2019-11-07 14:26:36', 6692.8, 6692.8, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2794, '记', 10, NULL, 0, 17, '2019-11-07 14:26:36', 8625, 8625, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2795, '记', 16, NULL, 0, 17, '2019-11-07 14:26:36', 46830.3, 46830.3, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2796, '记', 8, NULL, 0, 17, '2019-11-07 14:26:36', 608, 608, 74, 2018, 1, '2018-01-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2797, '记', 15, NULL, 0, 17, '2019-11-07 14:26:36', 1400, 1400, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2798, '记', 15, NULL, 0, 17, '2019-11-07 14:26:36', 32658.8, 32658.8, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2799, '记', 5, NULL, 0, 17, '2019-11-07 14:26:36', 3274.48, 3274.48, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2800, '记', 19, NULL, 0, 17, '2019-11-07 14:26:36', 23611, 23611, 74, 2019, 4, '2019-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2801, '记', 7, NULL, 0, 17, '2019-11-07 14:26:36', 14873.6, 14873.6, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2802, '记', 12, NULL, 0, 17, '2019-11-07 14:26:36', 10306.64, 10306.64, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2803, '记', 2, NULL, 0, 17, '2019-11-07 14:26:36', 18112.22, 18112.22, 74, 2018, 12, '2018-12-21', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2804, '记', 12, NULL, 0, 17, '2019-11-07 14:26:36', 32322.28, 32322.28, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2805, '记', 14, NULL, 0, 17, '2019-11-07 14:26:36', 56492.57, 56492.57, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2806, '记', 7, NULL, 0, 17, '2019-11-07 14:26:36', 10306.64, 10306.64, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2807, '记', 17, NULL, 0, 17, '2019-11-07 14:26:36', 133039.82, 133039.82, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2808, '记', 16, NULL, 0, 17, '2019-11-07 14:26:36', 8656, 8656, 74, 2019, 9, '2019-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2809, '记', 17, NULL, 0, 17, '2019-11-07 14:26:36', 1969.15, 1969.15, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2810, '记', 6, NULL, 0, 17, '2019-11-07 14:26:36', 32525, 32525, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2811, '记', 17, NULL, 0, 17, '2019-11-07 14:26:36', 2, 2, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2812, '记', 2, NULL, 0, 17, '2019-11-07 14:26:36', 1200, 1200, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2813, '记', 11, NULL, 0, 17, '2019-11-07 14:26:36', 2, 2, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2814, '记', 19, NULL, 0, 17, '2019-11-07 14:26:36', 10000, 10000, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2815, '记', 19, NULL, 0, 17, '2019-11-07 14:26:36', 760, 760, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2816, '记', 16, NULL, 0, 17, '2019-11-07 14:26:36', 38645.31, 38645.310000000005, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2817, '记', 3, NULL, 0, 17, '2019-11-07 14:26:36', 2, 2, 74, 2018, 12, '2018-12-21', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2818, '记', 18, NULL, 0, 17, '2019-11-07 14:26:36', 29230.19, 29230.19, 74, 2019, 4, '2019-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2819, '记', 4, NULL, 0, 17, '2019-11-07 14:26:36', 2, 2, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2820, '记', 3, NULL, 0, 17, '2019-11-07 14:26:36', 4600, 4600, 74, 2019, 10, '2019-10-13', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2821, '记', 15, NULL, 0, 17, '2019-11-07 14:26:36', 10480, 10480, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2822, '记', 4, NULL, 0, 17, '2019-11-07 14:26:36', 35000, 35000, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2823, '记', 15, NULL, 0, 17, '2019-11-07 14:26:36', 17764.94, 17764.94, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2824, '记', 18, NULL, 0, 17, '2019-11-07 14:26:37', 52141.6, 52141.6, 74, 2018, 4, '2018-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2825, '记', 8, NULL, 0, 17, '2019-11-07 14:26:37', 75995.98, 75995.98000000001, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2826, '记', 17, NULL, 0, 17, '2019-11-07 14:26:37', 8833, 8833, 74, 2019, 9, '2019-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2827, '记', 17, NULL, 0, 17, '2019-11-07 14:26:37', 16000, 16000, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2828, '记', 19, NULL, 0, 17, '2019-11-07 14:26:37', 22200, 22200, 74, 2019, 6, '2019-06-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2829, '记', 5, NULL, 0, 17, '2019-11-07 14:26:37', 7282.2, 7282.2, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2830, '记', 1, NULL, 0, 17, '2019-11-07 14:26:37', 29823.9, 29823.9, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2831, '记', 12, NULL, 0, 17, '2019-11-07 14:26:37', 20000, 20000, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2832, '记', 18, NULL, 0, 17, '2019-11-07 14:26:37', 0, 0, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2833, '记', 13, NULL, 0, 17, '2019-11-07 14:26:37', 2220, 2220, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2834, '记', 19, NULL, 0, 17, '2019-11-07 14:26:37', 900, 900, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2835, '记', 18, NULL, 0, 17, '2019-11-07 14:26:37', 450, 450, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2836, '记', 18, NULL, 0, 17, '2019-11-07 14:26:37', 153298.78, 153298.78, 74, 2018, 1, '2018-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2837, '记', 1, NULL, 0, 17, '2019-11-07 14:26:37', 1302, 1302, 74, 2019, 6, '2019-06-26', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2838, '记', 4, NULL, 0, 17, '2019-11-07 14:26:37', 25000, 25000, 74, 2018, 12, '2018-12-21', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2839, '记', 5, NULL, 0, 17, '2019-11-07 14:26:37', 5000, 5000, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2840, '记', 4, NULL, 0, 17, '2019-11-07 14:26:37', 1280, 1280, 74, 2019, 10, '2019-10-13', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2841, '记', 3, NULL, 0, 17, '2019-11-07 14:26:37', 7708.5, 7708.5, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2842, '记', 14, NULL, 0, 17, '2019-11-07 14:26:37', 4502.3, 4502.3, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2843, '记', 17, NULL, 0, 17, '2019-11-07 14:26:37', 1746.43, 1746.43, 74, 2019, 4, '2019-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2844, '记', 14, NULL, 0, 17, '2019-11-07 14:26:37', 22700, 22700, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2845, '记', 4, NULL, 0, 17, '2019-11-07 14:26:37', 10036, 10036, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2846, '记', 20, NULL, 0, 17, '2019-11-07 14:26:37', 2974.3, 2974.3, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2847, '记', 8, NULL, 0, 17, '2019-11-07 14:26:37', 23862, 23862, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2848, '记', 16, NULL, 0, 17, '2019-11-07 14:26:37', 763.7, 763.7, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2849, '记', 28, NULL, 0, 17, '2019-11-07 14:26:37', 12185.53, 12185.53, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2850, '记', 1, NULL, 0, 17, '2019-11-07 14:26:37', 1302, 1302, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2851, '记', 4, NULL, 0, 17, '2019-11-07 14:26:37', 6594.86, 6594.86, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2852, '记', 19, NULL, 0, 17, '2019-11-07 14:26:37', 3000, 3000, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2853, '记', 8, NULL, 0, 17, '2019-11-07 14:26:37', 11560, 11560, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2854, '记', 10, NULL, 0, 17, '2019-11-07 14:26:37', 27832, 27832, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2855, '记', 9, NULL, 0, 17, '2019-11-07 14:26:37', 2850, 2850, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2856, '记', 18, NULL, 0, 17, '2019-11-07 14:26:37', 4200, 4200, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2857, '记', 10, NULL, 0, 17, '2019-11-07 14:26:37', 5185.3, 5185.3, 74, 2018, 8, '2018-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2858, '记', 9, NULL, 0, 17, '2019-11-07 14:26:37', 88827.05000000002, 88827.05, 74, 2018, 11, '2018-11-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2859, '记', 17, NULL, 0, 17, '2019-11-07 14:26:37', 42927, 42927, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2860, '记', 4, NULL, 0, 17, '2019-11-07 14:26:37', 2878.33, 2878.33, 74, 2019, 1, '2019-01-16', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2861, '记', 16, NULL, 0, 17, '2019-11-07 14:26:37', 36848, 36848, 74, 2019, 4, '2019-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2862, '记', 2, NULL, 0, 17, '2019-11-07 14:26:37', 2086.2, 2086.2, 74, 2018, 4, '2018-04-24', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2863, '记', 5, NULL, 0, 17, '2019-11-07 14:26:37', 2, 2, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2864, '记', 21, NULL, 0, 17, '2019-11-07 14:26:37', 67967.71, 67967.70999999999, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2865, '记', 2, NULL, 0, 17, '2019-11-07 14:26:37', 11461.9, 11461.9, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2866, '记', 3, NULL, 0, 17, '2019-11-07 14:26:37', 1854, 1854, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2867, '记', 7, NULL, 0, 17, '2019-11-07 14:26:37', 10821, 10821, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2868, '记', 15, NULL, 0, 17, '2019-11-07 14:26:37', 10000, 10000, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2869, '记', 27, NULL, 0, 17, '2019-11-07 14:26:37', 23456.31, 23456.31, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2870, '记', 17, NULL, 0, 17, '2019-11-07 14:26:37', 10325.4, 10325.4, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2871, '记', 29, NULL, 0, 17, '2019-11-07 14:26:37', 3.94, 3.94, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2872, '记', 11, NULL, 0, 17, '2019-11-07 14:26:37', 17014.94, 17014.94, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2873, '记', 16, NULL, 0, 17, '2019-11-07 14:26:37', 56550.14, 56550.14, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2874, '记', 3, NULL, 0, 17, '2019-11-07 14:26:37', 3930.8, 3930.8, 74, 2019, 1, '2019-01-16', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2875, '记', 15, NULL, 0, 17, '2019-11-07 14:26:37', 6189.6, 6189.6, 74, 2019, 4, '2019-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2876, '记', 13, NULL, 0, 17, '2019-11-07 14:26:37', 2665.13, 2665.13, 74, 2019, 4, '2019-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2877, '记', 10, NULL, 0, 17, '2019-11-07 14:26:38', 4349.7, 4349.7, 74, 2019, 7, '2019-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2878, '记', 22, NULL, 0, 17, '2019-11-07 14:26:38', 216935.23, 216935.23, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2879, '记', 10, NULL, 0, 17, '2019-11-07 14:26:38', 2180, 2180, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2880, '记', 14, NULL, 0, 17, '2019-11-07 14:26:38', 462.7, 462.7, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2881, '记', 3, NULL, 0, 17, '2019-11-07 14:26:38', 37890.5, 37890.5, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2882, '记', 2, NULL, 0, 17, '2019-11-07 14:26:38', 27242, 27242, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2883, '记', 26, NULL, 0, 17, '2019-11-07 14:26:38', 166.67, 166.67, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2884, '记', 6, NULL, 0, 17, '2019-11-07 14:26:38', 500, 500, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2885, '记', 6, NULL, 0, 17, '2019-11-07 14:26:38', 2785, 2785, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2886, '记', 6, NULL, 0, 17, '2019-11-07 14:26:38', 5679.4, 5679.4, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2887, '记', 28, NULL, 0, 17, '2019-11-07 14:26:38', 4569.12, 4569.12, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2888, '记', 12, NULL, 0, 17, '2019-11-07 14:26:38', 0, 0, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2889, '记', 19, NULL, 0, 17, '2019-11-07 14:26:38', 17581.77, 17581.77, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2890, '记', 8, NULL, 0, 17, '2019-11-07 14:26:38', 44427.8, 44427.8, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2891, '记', 2, NULL, 0, 17, '2019-11-07 14:26:38', 523, 523, 74, 2019, 1, '2019-01-16', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2892, '记', 14, NULL, 0, 17, '2019-11-07 14:26:38', 1071.6, 1071.6, 74, 2019, 4, '2019-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2893, '记', 16, NULL, 0, 17, '2019-11-07 14:26:38', 2.01, 2.01, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2894, '记', 12, NULL, 0, 17, '2019-11-07 14:26:38', 603, 603, 74, 2019, 4, '2019-04-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2895, '记', 23, NULL, 0, 17, '2019-11-07 14:26:38', 1500, 1500, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2896, '记', 11, NULL, 0, 17, '2019-11-07 14:26:38', 20000, 20000, 74, 2017, 10, '2017-10-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2897, '记', 25, NULL, 0, 17, '2019-11-07 14:26:38', 1101.8, 1101.8, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2898, '记', 4, NULL, 0, 17, '2019-11-07 14:26:38', 3049.7, 3049.7, 74, 2019, 8, '2019-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2899, '记', 1, NULL, 0, 17, '2019-11-07 14:26:38', 2, 2, 74, 2019, 2, '2019-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2900, '记', 5, NULL, 0, 17, '2019-11-07 14:26:38', 7875, 7875, 74, 2018, 9, '2018-09-30', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2901, '记', 7, NULL, 0, 17, '2019-11-07 14:26:38', 11930.8, 11930.8, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2902, '记', 20, NULL, 0, 17, '2019-11-07 14:26:38', 1086, 1086, 74, 2018, 5, '2018-05-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2903, '记', 7, NULL, 0, 17, '2019-11-07 14:26:38', 9931.67, 9931.67, 74, 2017, 12, '2017-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2904, '记', 13, NULL, 0, 17, '2019-11-07 14:26:38', 9027.78, 9027.78, 74, 2019, 1, '2019-01-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2905, '记', 20, NULL, 0, 17, '2019-11-07 14:26:38', 33591.9, 33591.9, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2906, '记', 13, NULL, 0, 17, '2019-11-07 14:26:38', 2878.3300000000004, 2878.33, 74, 2018, 12, '2018-12-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2907, '记', 9, NULL, 0, 17, '2019-11-07 14:26:38', 38913.97, 38913.97, 74, 2018, 2, '2018-02-28', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2908, '记', 18, NULL, 0, 17, '2019-11-07 14:26:38', 173410.42, 173410.42, 74, 2018, 7, '2018-07-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2909, '记', 1, NULL, 0, 17, '2019-11-07 14:26:38', 1747.77, 1747.77, 74, 2019, 1, '2019-01-16', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2910, '记', 15, NULL, 0, 17, '2019-11-07 14:26:38', 16000, 16000, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2911, '记', 27, NULL, 0, 17, '2019-11-07 14:26:38', 8900, 8900, 74, 2017, 8, '2017-08-31', NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher` VALUES (2912, '记', 1, '', 0, 1, '2021-10-10 23:10:30', 100, 100, 73, 2019, 12, '2019-12-31', NULL, NULL, NULL, b'0');
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_voucher_details
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_voucher_details`;
CREATE TABLE `fxy_financial_voucher_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voucher_id` int(11) DEFAULT NULL,
  `summary` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '摘要',
  `subject_id` int(11) NOT NULL,
  `subject_name` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  `subject_code` varchar(56) COLLATE utf8mb4_bin DEFAULT NULL,
  `debit_amount` double DEFAULT NULL COMMENT '借方金额',
  `credit_amount` double DEFAULT NULL COMMENT '贷方金额',
  `auxiliary_title` varchar(512) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '辅助名称',
  `num` double DEFAULT NULL COMMENT '数量',
  `price` double DEFAULT NULL COMMENT '单价',
  `account_sets_id` int(11) DEFAULT NULL,
  `cumulative_debit` double DEFAULT NULL COMMENT '期初累计借方',
  `cumulative_credit` double DEFAULT NULL COMMENT '期初累计贷方',
  `cumulative_debit_num` double DEFAULT NULL,
  `cumulative_credit_num` double DEFAULT NULL,
  `carry_forward` bit(1) NOT NULL DEFAULT b'0' COMMENT '结转损益',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fxy_financial_voucher_details_fxy_financial_subject_id_fk` (`subject_id`) USING BTREE,
  KEY `fxy_financial_voucher_details_fxy_financial_voucher_id_fk` (`voucher_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14647 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='凭证';

-- ----------------------------
-- Records of fxy_financial_voucher_details
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_voucher_details` VALUES (11942, 2290, '支付2019.1-3月房租物业费', 10549, '112301-预付账款-房租', '112301', 14694.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11943, 2290, '支付2019.1-3月房租物业费', 10562, '122105-其他应收款-待入账', '122105', 5528.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11944, 2290, '支付2019.1-3月房租物业费', 10548, '100202-银行存款-农业银行', '100202', NULL, 20222.46, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11945, 2291, '银行结息', 10548, '100202-银行存款-农业银行', '100202', 41.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11946, 2291, '银行结息', 10531, '560302-财务费用-手续费', '560302', -41.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11947, 2292, '3月员工餐', 10608, '560128-销售费用-员工餐', '560128', 3053, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11948, 2292, '3月面条', 10572, '140304-原材料-面条', '140304', 2778, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11949, 2292, '3月虾干', 10571, '140303-原材料-海鲜', '140303', 1000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11950, 2292, '3月蔬菜', 10574, '140306-原材料-蔬菜', '140306', 1418.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11951, 2292, '3月未报销款项', 10582, '224101-其他应付款-个人', '224101', NULL, 8249.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11952, 2293, '3月余姚支付宝', 10548, '100202-银行存款-农业银行', '100202', 3274.48, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11953, 2293, '3月余姚支付宝', 10560, '122103-其他应收款-余姚店', '122103', NULL, 3274.48, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11954, 2294, '收到5月会员消费返款', 10548, '100202-银行存款-农业银行', '100202', 9526.38, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11955, 2294, '收到5月会员消费返款', 10566, '122109-其他应收款-会员户', '122109', NULL, 9526.38, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11956, 2294, '收到5.23日营业款', 10548, '100202-银行存款-农业银行', '100202', 31, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11957, 2294, '收到5.23日营业款', 10562, '122105-其他应收款-待入账', '122105', NULL, 31, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11958, 2295, '支付店长报销费用金', 10559, '122102-其他应收款-备用金', '122102', 2862.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11959, 2295, '支付店长报销费用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 2862.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11960, 2296, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11961, 2296, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11962, 2297, '慈溪店打印机采购', 10609, '560129-销售费用-经营期间购买的小设备', '560129', 295, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11963, 2297, '慈溪店打印机采购', 10548, '100202-银行存款-农业银行', '100202', NULL, 295, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11964, 2298, '8月总仓进货', 10575, '140307-原材料-福州干货', '140307', 27723.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11965, 2298, '8月总仓进货', 10561, '122104-其他应收款-总仓', '122104', NULL, 27723.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11966, 2299, '支付7月备用金', 10559, '122102-其他应收款-备用金', '122102', 4502.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11967, 2299, '支付7月备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 4502.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11968, 2300, '支付天元冻库费用', 10640, '560216-管理费用-租金', '560216', 1500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11969, 2300, '支付天元冻库费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 1500, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11970, 2301, '支付2月工资', 10580, '221101-应付职工薪酬-工资', '221101', 21523, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11971, 2301, '支付2月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 21523, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11972, 2302, '3月备用金报销-打印费用', 10594, '56010402-销售费用-办公费-打印纸', '56010402', 15, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11973, 2302, '3月备用金报销-低值易耗费用', 10598, '560119-销售费用-低值易耗品', '560119', 852.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11974, 2302, '3月备用金报销-会员卡短信费', 10611, '560131-销售费用-会员卡短信费', '560131', 88, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11975, 2302, '3月备用金报销-广告费', 10514, '560115-销售费用-广告费', '560115', 160, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11976, 2302, '3月备用金报销-3月垃圾费', 10606, '560126-销售费用-垃圾费', '560126', 400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11977, 2302, '3月备用金报销-春节礼盒吊旗', 10600, '56012002-销售费用-其他-杂项', '56012002', 75, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11978, 2302, '3月备用金报销-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 32.26, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11979, 2302, '3月备用金报销-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 731, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11980, 2302, '3月备用金报销-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 16, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11981, 2302, '3月备用金报销-维修费', 10502, '560103-销售费用-修理费', '560103', 100, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11982, 2302, '3月备用金报销-一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 929.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11983, 2302, '3月备用金报销-员工聚餐', 10603, '560123-销售费用-员工关怀', '560123', 208, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11984, 2302, '3月备用金报销-猪骨头', 10569, '140301-原材料-猪骨头', '140301', 1040, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11985, 2302, '3月备用金报销', 10582, '224101-其他应付款-个人', '224101', NULL, 2086.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11986, 2302, '3月备用金报销', 10582, '224101-其他应付款-个人', '224101', NULL, 2561.06, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11987, 2303, '支付8月员工餐', 10584, '224104-其他应付款-月结款', '224104', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11988, 2303, '支付8月员工餐', 10548, '100202-银行存款-农业银行', '100202', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11989, 2303, '8月费用报销款', 10559, '122102-其他应收款-备用金', '122102', 584.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11990, 2303, '8月费用报销款', 10548, '100202-银行存款-农业银行', '100202', NULL, 584.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11991, 2303, '9月员工餐', 10608, '560128-销售费用-员工餐', '560128', 450, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11992, 2303, '9月员工餐', 10548, '100202-银行存款-农业银行', '100202', NULL, 450, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11993, 2304, '支付8月福州货款', 10575, '140307-原材料-福州干货', '140307', 29265, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11994, 2304, '支付8月福州货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 29280, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11995, 2304, '支付8月福州货款手续费', 10531, '560302-财务费用-手续费', '560302', 15, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11996, 2304, '支付8月福州货款', 10575, '140307-原材料-福州干货', '140307', 47190, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11997, 2304, '支付8月福州货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 47190, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11998, 2305, '8月结转成本', 10496, '5401-主营业务成本', '5401', 114269.51, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (11999, 2305, '8月结转成本-海鲜', 10571, '140303-原材料-海鲜', '140303', NULL, 3640, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12000, 2305, '8月结转成本-面条', 10572, '140304-原材料-面条', '140304', NULL, 4211, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12001, 2305, '8月结转成本-花生', 10573, '140305-原材料-花生', '140305', NULL, 857.78, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12002, 2305, '8月结转成本-猪骨头', 10569, '140301-原材料-猪骨头', '140301', NULL, 1810, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12003, 2305, '8月结转成本-饮料', 10570, '140302-原材料-饮料', '140302', NULL, 2425, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12004, 2305, '8月结转成本-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 5621.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12005, 2305, '8月结转成本-福州干货', 10575, '140307-原材料-福州干货', '140307', NULL, 95704.53, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12006, 2306, '支付总仓进货余款', 10561, '122104-其他应收款-总仓', '122104', 21729.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12007, 2306, '支付总仓进货余款', 10548, '100202-银行存款-农业银行', '100202', NULL, 21729.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12008, 2307, '补交水电费', 10562, '122105-其他应收款-待入账', '122105', 0.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12009, 2307, '补交水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 0.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12010, 2307, '支付发票机年费', 10639, '560215-管理费用-税金', '560215', 280, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12011, 2307, '支付发票机年费', 10548, '100202-银行存款-农业银行', '100202', NULL, 280, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12012, 2308, '收到5月饿了么营业款', 10548, '100202-银行存款-农业银行', '100202', 2036.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12013, 2308, '收到5月饿了么营业款', 10562, '122105-其他应收款-待入账', '122105', NULL, 2036.06, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12014, 2308, '收到5月支付宝营业款', 10548, '100202-银行存款-农业银行', '100202', 17475.42, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12015, 2308, '收到5月支付宝营业款', 10562, '122105-其他应收款-待入账', '122105', NULL, 17475.42, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12016, 2309, '计提7月税金', 10639, '560215-管理费用-税金', '560215', 2569.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12017, 2309, '计提7月税金', 10462, '222126-应交税费-税金', '222126', NULL, 2569.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12018, 2310, '支付9月蔬菜费用', 10582, '224101-其他应付款-个人', '224101', 2800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12019, 2310, '支付9月员工餐费用', 10582, '224101-其他应付款-个人', '224101', 3390, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12020, 2310, '支付9月海鲜费用', 10582, '224101-其他应付款-个人', '224101', 1000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12021, 2310, '支付9月日常报销', 10582, '224101-其他应付款-个人', '224101', 6895.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12022, 2310, '支付9月饮料费用', 10582, '224101-其他应付款-个人', '224101', 950, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12023, 2310, '支付9月猪骨头费用', 10582, '224101-其他应付款-个人', '224101', 800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12024, 2310, '支付9月猪骨头费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 800, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12025, 2310, '支付9月饮料费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 950, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12026, 2310, '支付9月日常报销费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 6895.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12027, 2310, '支付9月海鲜费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 1000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12028, 2310, '支付9月员工餐费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 3390, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12029, 2310, '支付9月员蔬菜费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 2800, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12030, 2311, '3月总仓暂借款', 10561, '122104-其他应收款-总仓', '122104', 20000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12031, 2311, '3月总仓暂借款', 10548, '100202-银行存款-农业银行', '100202', NULL, 20000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12032, 2312, '支付慈溪旧巷南5月总仓进货款', 10561, '122104-其他应收款-总仓', '122104', 12552.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12033, 2312, '支付慈溪旧巷南5月总仓进货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 12552.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12034, 2313, '预付总仓货款', 10561, '122104-其他应收款-总仓', '122104', 50000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12035, 2313, '预付总仓货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 50000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12036, 2314, '8月月结款-蔬菜筒骨', 10574, '140306-原材料-蔬菜', '140306', 1308, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12037, 2314, '8月月结款-凤爪', 10576, '140308-原材料-凤爪', '140308', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12038, 2314, '8月月结款-面条', 10572, '140304-原材料-面条', '140304', 1740, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12039, 2314, '8月月结款', 10584, '224104-其他应付款-月结款', '224104', NULL, 4648, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12040, 2314, '8月月结款-员工餐', 10608, '560128-销售费用-员工餐', '560128', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12041, 2314, '8月月结款-员工餐', 10584, '224104-其他应付款-月结款', '224104', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12042, 2315, '支付12月总仓进货款补差', 10561, '122104-其他应收款-总仓', '122104', 810, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12043, 2315, '支付12月总仓进货款补差', 10548, '100202-银行存款-农业银行', '100202', NULL, 810, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12044, 2316, '支付10月原材料货款', 10582, '224101-其他应付款-个人', '224101', 4200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12045, 2316, '支付10月原材料货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 4200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12046, 2317, '摊销8月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16665.14, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12047, 2317, '摊销8月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16665.14, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12048, 2318, '支付2月面条月结', 10584, '224104-其他应付款-月结款', '224104', 1470, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12049, 2318, '支付2月蔬菜月结', 10584, '224104-其他应付款-月结款', '224104', 736.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12050, 2318, '支付2月员工餐月结', 10584, '224104-其他应付款-月结款', '224104', 1200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12051, 2318, '支付2月月结款', 10548, '100202-银行存款-农业银行', '100202', NULL, 3406, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12052, 2318, '支付2月月结款', 10592, '530105-营业外收入-其他', '530105', NULL, 0.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12053, 2319, '支付2月垃圾费', 10606, '560126-销售费用-垃圾费', '560126', 400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12054, 2319, '支付2月电话费', 10593, '56010401-销售费用-办公费-电话费', '56010401', 499, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12055, 2319, '支付2月调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 100, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12056, 2319, '支付2月调料', 10582, '224101-其他应付款-个人', '224101', NULL, 999, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12057, 2320, '打款认证', 10642, '571112-营业外支出-其他', '571112', 0.01, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12058, 2320, '打款认证', 10548, '100202-银行存款-农业银行', '100202', NULL, 0.01, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12059, 2321, '支付购买冰箱', 10583, '224102-其他应付款-设备，装修', '224102', 4200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12060, 2321, '支付购买冰箱', 10548, '100202-银行存款-农业银行', '100202', NULL, 4200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12061, 2322, '8月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 81359.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12062, 2322, '8月收入-微信收入', 10548, '100202-银行存款-农业银行', '100202', 57877.14, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12063, 2322, '8月收入-支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 132718.82, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12064, 2322, '8月收入-美团收入', 10548, '100202-银行存款-农业银行', '100202', 2965.36, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12065, 2322, '8月收入-礼券', 10605, '560125-销售费用-礼券', '560125', 785, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12066, 2322, '8月收入-单机会员消费', 10579, '220302-预收账款-单机会员充值', '220302', 2081, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12067, 2322, '8月收入-微信会员消费', 10561, '122104-其他应收款-总仓', '122104', 52192.84, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12068, 2322, '8月收入-微信会员消费手续费', 10531, '560302-财务费用-手续费', '560302', 313.84, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12069, 2322, '8月收入', 10488, '5001-主营业务收入', '5001', NULL, 330293.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12070, 2323, '12.1-12.29现金', 10548, '100202-银行存款-农业银行', '100202', 5300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12071, 2323, '12.30-31现金', 10562, '122105-其他应收款-待入账', '122105', 523, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12072, 2323, '12.1-12.29现金', 10488, '5001-主营业务收入', '5001', NULL, 5823, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12073, 2323, '12.1-12.31饿了么', 10548, '100202-银行存款-农业银行', '100202', 4486.72, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12074, 2323, '12.1-12.31饿了么', 10488, '5001-主营业务收入', '5001', NULL, 4486.72, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12075, 2323, '12.1-12.30美团', 10548, '100202-银行存款-农业银行', '100202', 12273.37, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12076, 2323, '12.31美团收入', 10562, '122105-其他应收款-待入账', '122105', 490.59, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12077, 2323, '12.1-31美团收入', 10488, '5001-主营业务收入', '5001', NULL, 12763.96, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12078, 2323, '12.1-31收钱吧-微信', 10548, '100202-银行存款-农业银行', '100202', 22402.76, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12079, 2323, '12.1-31收钱吧-微信', 10488, '5001-主营业务收入', '5001', NULL, 22402.76, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12080, 2323, '12.1-31收钱吧-支付宝', 10562, '122105-其他应收款-待入账', '122105', 18614.45, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12081, 2323, '12.1-31收钱吧-支付宝', 10488, '5001-主营业务收入', '5001', NULL, 18614.45, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12082, 2323, '收到11.1-31支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 20098.54, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12083, 2323, '收到11.1-31支付宝收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 20098.54, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12084, 2323, '收到美团收入', 10548, '100202-银行存款-农业银行', '100202', 4916.05, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12085, 2323, '收到美团收入', 10488, '5001-主营业务收入', '5001', NULL, 4916.05, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12086, 2323, '收到会员消费', 10566, '122109-其他应收款-会员户', '122109', 12373.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12087, 2323, '收到会员消费', 10531, '560302-财务费用-手续费', '560302', 47, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12088, 2323, '收到会员消费', 10488, '5001-主营业务收入', '5001', NULL, 12420.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12089, 2323, '收到优免折扣', 10604, '560124-销售费用-营业折扣', '560124', 9801.04, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12090, 2323, '收到优免折扣', 10488, '5001-主营业务收入', '5001', NULL, 9801.04, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12091, 2323, '12.1-31喵街', 10562, '122105-其他应收款-待入账', '122105', 105.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12092, 2323, '12.1-31喵街', 10488, '5001-主营业务收入', '5001', NULL, 105.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12093, 2324, '支付8月工资', 10580, '221101-应付职工薪酬-工资', '221101', 20497, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12094, 2324, '支付8月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 20497, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12095, 2325, '5.29-5.31日现金营业款', 10548, '100202-银行存款-农业银行', '100202', 414, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12096, 2325, '5.29-5.31日现金营业款', 10562, '122105-其他应收款-待入账', '122105', NULL, 414, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12097, 2326, '支付4-6月税金', 10462, '222126-应交税费-税金', '222126', 7708.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12098, 2326, '支付4-6月税金', 10548, '100202-银行存款-农业银行', '100202', NULL, 7708.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12099, 2327, '支付3月备用金报销款', 10559, '122102-其他应收款-备用金', '122102', 995.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12100, 2327, '支付3月备用金报销款', 10548, '100202-银行存款-农业银行', '100202', NULL, 995.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12101, 2328, '支付旧巷南7-9月房租物业', 10549, '112301-预付账款-房租', '112301', 30930.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12102, 2328, '支付旧巷南7-9月房租及物业费', 10548, '100202-银行存款-农业银行', '100202', NULL, 30930.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12103, 2328, '代付一点点7-9月房租', 10568, '122111-其他应收款-一点点房租', '122111', 19614.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12104, 2328, '代付一点点7-9月房租', 10548, '100202-银行存款-农业银行', '100202', NULL, 19614.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12105, 2329, '结息', 10548, '100202-银行存款-农业银行', '100202', 71.49, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12106, 2329, '结息', 10530, '560301-财务费用-利息费用', '560301', NULL, 71.49, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12107, 2330, '8月备用金报销-电池、一次性筷子', 10598, '560119-销售费用-低值易耗品', '560119', 28, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12108, 2330, '8月备用金报销-白醋', 10574, '140306-原材料-蔬菜', '140306', 24.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12109, 2330, '8月备用金报销-蒸笼身', 10598, '560119-销售费用-低值易耗品', '560119', 77, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12110, 2330, '8月备用金报销-调料盒', 10612, '560132-销售费用-物料', '560132', 125, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12111, 2330, '8月备用金报销-KT板', 10514, '560115-销售费用-广告费', '560115', 70, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12112, 2330, '8月备用金报销-总仓运费', 10510, '560111-销售费用-运输费', '560111', 60, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12113, 2330, '8月备用金报销-话费', 10593, '56010401-销售费用-办公费-电话费', '56010401', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12114, 2330, '8月备用金报销', 10559, '122102-其他应收款-备用金', '122102', NULL, 584.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12115, 2331, '12月支付店内春联款', 10600, '56012002-销售费用-其他-杂项', '56012002', 1075, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12116, 2331, '12月支付店内春联款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1075, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12117, 2332, '确认8月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 10791.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12118, 2332, '确认8月收入-未入账现金', 10562, '122105-其他应收款-待入账', '122105', 3196, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12119, 2332, '确认8月收入-线上支付', 10548, '100202-银行存款-农业银行', '100202', 56320.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12120, 2332, '确认8月收入-手续费', 10531, '560302-财务费用-手续费', '560302', 5073.75, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12121, 2332, '确认8月收入-支付宝未入账', 10562, '122105-其他应收款-待入账', '122105', 19729.84, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12122, 2332, '确认8月收入-美团', 10548, '100202-银行存款-农业银行', '100202', 25233.22, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12123, 2332, '确认8月收入-美团外卖手续费', 10531, '560302-财务费用-手续费', '560302', 2661.88, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12124, 2332, '确认8月收入-美团团购', 10548, '100202-银行存款-农业银行', '100202', 7481.51, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12125, 2332, '确认8月收入-饿了么', 10562, '122105-其他应收款-待入账', '122105', 6898.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12126, 2332, '确认8月收入-饿了么手续费', 10531, '560302-财务费用-手续费', '560302', 2785.86, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12127, 2332, '确认8月收入-会员消费', 10561, '122104-其他应收款-总仓', '122104', 26566.45, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12128, 2332, '确认8月收入-会员消费手续费', 10531, '560302-财务费用-手续费', '560302', 100.95, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12129, 2332, '确认8月收入-喵街', 10562, '122105-其他应收款-待入账', '122105', 828.38, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12130, 2332, '确认8月收入-报损', 10604, '560124-销售费用-营业折扣', '560124', 169, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12131, 2332, '确认8月收入-优免', 10604, '560124-销售费用-营业折扣', '560124', 15933.99, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12132, 2332, '确认8月收入', 10488, '5001-主营业务收入', '5001', NULL, 183770.05, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12133, 2333, '8月备用金报销-低值', 10598, '560119-销售费用-低值易耗品', '560119', 355.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12134, 2333, '8月备用金报销-凤爪', 10576, '140308-原材料-凤爪', '140308', 3200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12135, 2333, '8月备用金报销-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 72, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12136, 2333, '8月备用金报销-美团推广', 10614, '560134-销售费用-推广费', '560134', 250, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12137, 2333, '8月备用金报销-培训费', 10600, '56012002-销售费用-其他-杂项', '56012002', 482, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12138, 2333, '8月备用金报销-小设备', 10597, '560117-销售费用-设备-小器具', '560117', 32.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12139, 2333, '8月备用金报销-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 366, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12140, 2333, '8月备用金报销-物料', 10612, '560132-销售费用-物料', '560132', 1604, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12141, 2333, '8月备用金报销-员工餐', 10608, '560128-销售费用-员工餐', '560128', 62.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12142, 2333, '8月备用金报销-运费', 10510, '560111-销售费用-运输费', '560111', 268, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12143, 2333, '8月备用金报销', 10559, '122102-其他应收款-备用金', '122102', NULL, 6692.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12144, 2334, '支付2月备用金报销款', 10559, '122102-其他应收款-备用金', '122102', 1619.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12145, 2334, '支付2月备用金报销款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1619.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12146, 2335, '支付1月饮料款', 10582, '224101-其他应付款-个人', '224101', 475.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12147, 2335, '支付1月饮料款', 10548, '100202-银行存款-农业银行', '100202', NULL, 475.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12148, 2336, '3月结息', 10548, '100202-银行存款-农业银行', '100202', 48.64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12149, 2336, '3月结息', 10530, '560301-财务费用-利息费用', '560301', -48.64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12150, 2337, '8月单机会员充值', 10548, '100202-银行存款-农业银行', '100202', 2700, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12151, 2337, '8月单机会员充值', 10579, '220302-预收账款-单机会员充值', '220302', NULL, 2700, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12152, 2338, '支付福州货款', 10575, '140307-原材料-福州干货', '140307', 61654.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12153, 2338, '支付福州货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 61654.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12154, 2339, '支付8月凤爪款', 10584, '224104-其他应付款-月结款', '224104', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12155, 2339, '支付8月凤爪款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12156, 2339, '支付8月蔬菜款', 10584, '224104-其他应付款-月结款', '224104', 1308, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12157, 2339, '支付8月蔬菜款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1308, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12158, 2340, '支付10-12月税金-国税', 10639, '560215-管理费用-税金', '560215', 4050, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12159, 2340, '支付10-12月税金-国税', 10548, '100202-银行存款-农业银行', '100202', NULL, 4050, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12160, 2341, '支付短信服务费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12161, 2341, '支付短信服务费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12162, 2342, '支付6月备用金', 10559, '122102-其他应收款-备用金', '122102', 1863.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12163, 2342, '支付6月备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 1863.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12164, 2343, '支付3月饮料款', 10584, '224104-其他应付款-月结款', '224104', 516, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12165, 2343, '支付3月饮料款', 10548, '100202-银行存款-农业银行', '100202', NULL, 516, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12166, 2343, '支付凤爪款', 10576, '140308-原材料-凤爪', '140308', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12167, 2343, '支付凤爪款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12168, 2343, '支付3月员工餐', 10584, '224104-其他应付款-月结款', '224104', 1200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12169, 2343, '支付3月员工餐', 10548, '100202-银行存款-农业银行', '100202', NULL, 1200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12170, 2343, '支付3月面条款', 10584, '224104-其他应付款-月结款', '224104', 1830, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12171, 2343, '支付3月面条款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1830, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12172, 2343, '支付3月蔬菜款', 10584, '224104-其他应付款-月结款', '224104', 1648.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12173, 2343, '支付3月蔬菜款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1648.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12174, 2344, '7月会员消费返款', 10548, '100202-银行存款-农业银行', '100202', 7708, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12175, 2344, '7月会员消费返款', 10566, '122109-其他应收款-会员户', '122109', NULL, 7708, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12176, 2345, '支付第三季度租金（7-9月）', 10549, '112301-预付账款-房租', '112301', 50544.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12177, 2345, '支付第三季度租金（7-9月）', 10548, '100202-银行存款-农业银行', '100202', NULL, 50544.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12178, 2346, '计提6月税金', 10639, '560215-管理费用-税金', '560215', 2569.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12179, 2346, '计提6月税金', 10462, '222126-应交税费-税金', '222126', NULL, 2569.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12180, 2347, '支付闭店拆运费', 10510, '560111-销售费用-运输费', '560111', 800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12181, 2347, '支付闭店拆运费', 10548, '100202-银行存款-农业银行', '100202', NULL, 800, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12182, 2347, '工商罚款（消毒不达标）', 10642, '571112-营业外支出-其他', '571112', 500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12183, 2347, '工商罚款（消毒不达标）', 10548, '100202-银行存款-农业银行', '100202', NULL, 500, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12184, 2348, '支付5月水费', 10521, '560205-管理费用-水电费', '560205', 434, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12185, 2348, '支付5月电费', 10521, '560205-管理费用-水电费', '560205', 12432, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12186, 2348, '支付5月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 12866, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12187, 2349, '农业银行短线服务费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12188, 2349, '农业银行短线服务费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12189, 2350, '8月摊销-房租物业', 10618, '56020801-管理费用-摊销费-房租', '56020801', 10310.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12190, 2350, '8月摊销-房租物业', 10549, '112301-预付账款-房租', '112301', NULL, 10310.13, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12191, 2350, '8月摊销-仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 833.33, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12192, 2350, '8月摊销-仓库租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 833.33, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12193, 2351, '股权分红', 10481, '310405-利润分配-应付利润', '310405', 110000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12194, 2351, '股权分红', 10548, '100202-银行存款-农业银行', '100202', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12195, 2351, '股权分红', 10548, '100202-银行存款-农业银行', '100202', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12196, 2351, '股权分红', 10548, '100202-银行存款-农业银行', '100202', NULL, 40000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12197, 2351, '股权分红', 10548, '100202-银行存款-农业银行', '100202', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12198, 2351, '股权分红', 10548, '100202-银行存款-农业银行', '100202', NULL, 40000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12199, 2351, '股权分红', 10482, '310406-利润分配-未分配利润', '310406', 110000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12200, 2351, '股权分红', 10481, '310405-利润分配-应付利润', '310405', NULL, 110000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12201, 2352, '卖原材料', 10548, '100202-银行存款-农业银行', '100202', 115.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12202, 2352, '卖原材料', 10592, '530105-营业外收入-其他', '530105', NULL, 115.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12203, 2353, '计提12月员工工资', 10637, '560213-管理费用-工资', '560213', 49331.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12204, 2353, '计提12月员工工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 49331.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12205, 2354, '支付1月垃圾费', 10582, '224101-其他应付款-个人', '224101', 400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12206, 2354, '支付1月垃圾费', 10548, '100202-银行存款-农业银行', '100202', NULL, 400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12207, 2355, '3月短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12208, 2355, '3月短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12209, 2356, '支付12月工资', 10580, '221101-应付职工薪酬-工资', '221101', 27832, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12210, 2356, '支付12月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 27832, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12211, 2357, '7月单机会员充值', 10604, '560124-销售费用-营业折扣', '560124', 3400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12212, 2357, '7月单机会员充值', 10579, '220302-预收账款-单机会员充值', '220302', NULL, 3400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12213, 2357, '8月单机会员充值', 10604, '560124-销售费用-营业折扣', '560124', 3200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12214, 2357, '8月单机会员充值', 10579, '220302-预收账款-单机会员充值', '220302', NULL, 3200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12215, 2357, '8月微信会员充值', 10604, '560124-销售费用-营业折扣', '560124', 300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12216, 2357, '8月微信会员充值', 10561, '122104-其他应收款-总仓', '122104', NULL, 300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12217, 2358, '支付电箱电缆费用', 10583, '224102-其他应付款-设备，装修', '224102', 3450, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12218, 2358, '支付电箱电缆费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 3450, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12219, 2359, '支付龚姐住宿费', 10505, '560106-销售费用-差旅费', '560106', 576, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12220, 2359, '支付龚姐住宿费', 10548, '100202-银行存款-农业银行', '100202', NULL, 576, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12221, 2360, '支付10月员工伙食费', 10608, '560128-销售费用-员工餐', '560128', 4750, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12222, 2360, '支付10月员工伙食费', 10582, '224101-其他应付款-个人', '224101', NULL, 4750, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12223, 2361, '3月备用金报销-低值', 10598, '560119-销售费用-低值易耗品', '560119', 249, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12224, 2361, '3月备用金报销-健康证', 10600, '56012002-销售费用-其他-杂项', '56012002', 98.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12225, 2361, '3月备用金报销-修电涝炉及电表箱盖', 10502, '560103-销售费用-修理费', '560103', 170, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12226, 2361, '3月备用金报销-KT板及广告牌', 10514, '560115-销售费用-广告费', '560115', 75, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12227, 2361, '3月备用金报销-收银纸', 10594, '56010402-销售费用-办公费-打印纸', '56010402', 168, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12228, 2361, '3月备用金报销-调料盒', 10612, '560132-销售费用-物料', '560132', 205, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12229, 2361, '3月备用金报销-运费', 10510, '560111-销售费用-运输费', '560111', 30, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12230, 2361, '3月备用金报销', 10559, '122102-其他应收款-备用金', '122102', NULL, 995.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12231, 2362, '10月地税税费', 10639, '560215-管理费用-税金', '560215', 1219.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12232, 2362, '10月地税税费', 10548, '100202-银行存款-农业银行', '100202', NULL, 1219.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12233, 2363, '支付朱洪平装修第二笔款', 10622, '56020902-管理费用-开办费-店面装修', '56020902', 44000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12234, 2363, '支付朱洪平装修第二笔款', 10547, '100201-银行存款-中国银行', '100201', NULL, 44000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12235, 2364, '第7期  结转损益', 10621, '56020901-管理费用-开办费-公关费用', '56020901', NULL, 40000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12236, 2364, '第7期  结转损益', 10622, '56020902-管理费用-开办费-店面装修', '56020902', NULL, 159652, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12237, 2364, '第7期  结转损益', 10623, '56020903-管理费用-开办费-加盟费', '56020903', NULL, 50000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12238, 2364, '第7期  结转损益', 10624, '56020904-管理费用-开办费-装修设计', '56020904', NULL, 13000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12239, 2364, '第7期  结转损益', 10625, '56020905-管理费用-开办费-企划设计', '56020905', NULL, 7000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12240, 2364, '第7期  结转损益', 10626, '56020906-管理费用-开办费-桌椅', '56020906', NULL, 25000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12241, 2364, '第7期  结转损益', 10627, '56020907-管理费用-开办费-灯箱', '56020907', NULL, 8850, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12242, 2364, '第7期  结转损益', 10628, '56020908-管理费用-开办费-业务招待费用', '56020908', NULL, 11973.34, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12243, 2364, '第7期  结转损益', 10629, '56020909-管理费用-开办费-设备', '56020909', NULL, 114480.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12244, 2364, '第7期  结转损益', 10630, '56020910-管理费用-开办费-小物件', '56020910', NULL, 17911.66, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12245, 2364, '第7期  结转损益', 10631, '56020911-管理费用-开办费-开业指导费', '56020911', NULL, 4874, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12246, 2364, '第7期  结转损益', 10633, '56020913-管理费用-开办费-其他', '56020913', NULL, 8354.89, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12247, 2364, '第7期  结转损益', 10634, '56020914-管理费用-开办费-广告费', '56020914', NULL, 920, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12248, 2364, '第7期  结转损益', 10635, '56020915-管理费用-开办费-工资', '56020915', NULL, 31681, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12249, 2364, '第7期  结转损益', 10636, '56020916-管理费用-开办费-租金', '56020916', NULL, 17148.27, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12250, 2364, '第7期  结转损益', 10530, '560301-财务费用-利息费用', '560301', NULL, -31.28, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12251, 2364, '第7期  结转损益', 10475, '3103-本年利润', '3103', 510814.58, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12252, 2365, '6月总仓进货', 10575, '140307-原材料-福州干货', '140307', 15190.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12253, 2365, '6月总仓进货', 10561, '122104-其他应收款-总仓', '122104', NULL, 15190.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12254, 2366, '计提6月提成', 10638, '560214-管理费用-提成', '560214', 1032, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12255, 2366, '计提6月提成', 10581, '221102-应付职工薪酬-提成', '221102', NULL, 1032, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12256, 2367, '支付清明福利', 10603, '560123-销售费用-员工关怀', '560123', 700, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12257, 2367, '支付清明福利', 10548, '100202-银行存款-农业银行', '100202', NULL, 700, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12258, 2368, '结转6月成本', 10496, '5401-主营业务成本', '5401', 57706.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12259, 2368, '结转6月成本', 10569, '140301-原材料-猪骨头', '140301', NULL, 1260, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12260, 2368, '结转6月成本', 10574, '140306-原材料-蔬菜', '140306', NULL, 2279.25, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12261, 2368, '结转6月成本', 10572, '140304-原材料-面条', '140304', NULL, 2628, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12262, 2368, '结转6月成本', 10570, '140302-原材料-饮料', '140302', NULL, 839, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12263, 2368, '结转6月成本', 10575, '140307-原材料-福州干货', '140307', NULL, 50700.65, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12264, 2369, '12月总仓进货-福州干货', 10575, '140307-原材料-福州干货', '140307', 30267.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12265, 2369, '12月总仓进货-福州干货(回冲11月慈溪调总仓福州货款）', 10561, '122104-其他应收款-总仓', '122104', NULL, 29457.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12266, 2369, '12月总仓进货-福州干货货款', 10561, '122104-其他应收款-总仓', '122104', NULL, 810, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12267, 2370, '计提12月员工提成5%', 10638, '560214-管理费用-提成', '560214', 806.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12268, 2370, '计提12月员工提成5%', 10581, '221102-应付职工薪酬-提成', '221102', NULL, 806.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12269, 2371, '支付中秋广告费', 10514, '560115-销售费用-广告费', '560115', 1100, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12270, 2371, '支付中秋广告费', 10548, '100202-银行存款-农业银行', '100202', NULL, 1100, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12271, 2372, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12272, 2372, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12273, 2372, '慈溪店9月会员消费', 10548, '100202-银行存款-农业银行', '100202', 2015.35, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12274, 2372, '慈溪店9月会员消费', 10566, '122109-其他应收款-会员户', '122109', NULL, 2015.35, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12275, 2373, '购买小物件', 10612, '560132-销售费用-物料', '560132', 557, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12276, 2373, '购买小物件', 10548, '100202-银行存款-农业银行', '100202', NULL, 557, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12277, 2374, '支付福州窗帘窗框费用', 10583, '224102-其他应付款-设备，装修', '224102', 2210, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12278, 2374, '支付福州窗帘窗框费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 2210, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12279, 2375, '发放7月工资', 10580, '221101-应付职工薪酬-工资', '221101', 31681, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12280, 2375, '发放7月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 31681, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12281, 2376, '支付1月蔬菜及餐费', 10582, '224101-其他应付款-个人', '224101', 10406.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12282, 2376, '支付1月蔬菜及餐费', 10548, '100202-银行存款-农业银行', '100202', NULL, 10406.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12283, 2377, '支付12月水费', 10521, '560205-管理费用-水电费', '560205', 287, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12284, 2377, '支付12月电费', 10521, '560205-管理费用-水电费', '560205', 11491.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12285, 2377, '支付12月水电费‘', 10548, '100202-银行存款-农业银行', '100202', NULL, 11778.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12286, 2378, '计提8月工资', 10637, '560213-管理费用-工资', '560213', 31033, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12287, 2378, '计提8月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 31033, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12288, 2379, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12289, 2379, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12290, 2380, '店面租金（7-9月）', 10549, '112301-预付账款-房租', '112301', 50544.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12291, 2380, '店面租金质量保证金', 10558, '12210105-其他应收款-押金-质量保证金', '12210105', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12292, 2380, '店面租金质量保证金及租金', 10547, '100201-银行存款-中国银行', '100201', NULL, 60544.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12293, 2381, '6.1日采购凤爪', 10576, '140308-原材料-凤爪', '140308', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12294, 2381, '6.1日采购凤爪', 10548, '100202-银行存款-农业银行', '100202', NULL, 1600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12295, 2382, '支付2月备用金未报销部分', 10582, '224101-其他应付款-个人', '224101', 1152.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12296, 2382, '支付2月备用金未报销部分', 10548, '100202-银行存款-农业银行', '100202', NULL, 1152.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12297, 2383, '支付10月蔬菜费用', 10574, '140306-原材料-蔬菜', '140306', 2800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12298, 2383, '支付10月饮料费用', 10570, '140302-原材料-饮料', '140302', 600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12299, 2383, '支付10月虾干费用', 10571, '140303-原材料-海鲜', '140303', 800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12300, 2383, '支付10月供应商进货费用', 10582, '224101-其他应付款-个人', '224101', NULL, 4200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12301, 2384, '3月月结-员工餐', 10608, '560128-销售费用-员工餐', '560128', 1200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12302, 2384, '3月月结-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 1648.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12303, 2384, '3月月结-面条', 10572, '140304-原材料-面条', '140304', 1830, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12304, 2384, '3月月结-饮料', 10570, '140302-原材料-饮料', '140302', 516, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12305, 2384, '3月月结', 10584, '224104-其他应付款-月结款', '224104', NULL, 5194.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12306, 2385, '陈林报销开业费用-设备', 10629, '56020909-管理费用-开办费-设备', '56020909', 6741.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12307, 2385, '陈林报销开业费用-装修费用', 10622, '56020902-管理费用-开办费-店面装修', '56020902', 2469, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12308, 2385, '陈林报销开业费用-伍总郑总来访', 10628, '56020908-管理费用-开办费-业务招待费用', '56020908', 567, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12309, 2385, '陈林报销开业费用-调料道具', 10633, '56020913-管理费用-开办费-其他', '56020913', 785.56, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12310, 2385, '陈林报销开业费用-调料道具', 10547, '100201-银行存款-中国银行', '100201', NULL, 10563.26, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12311, 2386, '陈林报销10月1-12号日常费用-低值易耗品', 10598, '560119-销售费用-低值易耗品', '560119', 723.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12312, 2386, '陈林报销10月1-12号日常费用-招聘海报', 10514, '560115-销售费用-广告费', '560115', 20, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12313, 2386, '陈林报销10月1-12号日常费用-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 112, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12314, 2386, '陈林报销10月1-12号日常费用-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 32, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12315, 2386, '陈林报销10月1-12号日常费用-桶装水', 10602, '560122-销售费用-一次性用品', '560122', 411, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12316, 2386, '陈林报销10月1-12号日常费用-员工关怀', 10603, '560123-销售费用-员工关怀', '560123', 2260, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12317, 2386, '陈林报销10月1-12号日常费用-运费', 10510, '560111-销售费用-运输费', '560111', 302, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12318, 2386, '陈林报销10月1-12号日常费用-海鲜', 10571, '140303-原材料-海鲜', '140303', 5.51, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12319, 2386, '陈林报销10月1-12号日常费用-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 62, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12320, 2386, '陈林报销10月1-12号日常费用-猪骨头', 10569, '140301-原材料-猪骨头', '140301', 70, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12321, 2386, '陈林报销10月1-12号日常费用-面条', 10572, '140304-原材料-面条', '140304', 1455, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12322, 2386, '陈林报销10月1-12号日常费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 5453.01, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12323, 2387, '6月月结-面条', 10572, '140304-原材料-面条', '140304', 1575, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12324, 2387, '6月月结-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 1170.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12325, 2387, '6月月结-员工餐', 10608, '560128-销售费用-员工餐', '560128', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12326, 2387, '6月月结', 10584, '224104-其他应付款-月结款', '224104', NULL, 4045.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12327, 2388, '6月进货', 10575, '140307-原材料-福州干货', '140307', 35116.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12328, 2388, '6月进货', 10561, '122104-其他应收款-总仓', '122104', NULL, 35116.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12329, 2389, '第12期  结转损益', 10488, '5001-主营业务收入', '5001', 174447.53, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12330, 2389, '第12期  结转损益', 10592, '530105-营业外收入-其他', '530105', 13.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12331, 2389, '第12期  结转损益', 10475, '3103-本年利润', '3103', NULL, 15795.89, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12332, 2389, '第12期  结转损益', 10496, '5401-主营业务成本', '5401', NULL, 58391.22, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12333, 2389, '第12期  结转损益', 10595, '56010403-销售费用-办公费-桶装水', '56010403', NULL, 32, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12334, 2389, '第12期  结转损益', 10509, '560110-销售费用-商品维修费', '560110', NULL, 600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12335, 2389, '第12期  结转损益', 10510, '560111-销售费用-运输费', '560111', NULL, 1133, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12336, 2389, '第12期  结转损益', 10514, '560115-销售费用-广告费', '560115', NULL, 200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12337, 2389, '第12期  结转损益', 10598, '560119-销售费用-低值易耗品', '560119', NULL, 277.1, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12338, 2389, '第12期  结转损益', 10600, '56012002-销售费用-其他-杂项', '56012002', NULL, 1339, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12339, 2389, '第12期  结转损益', 10601, '560121-销售费用-厨房原材料-调料', '560121', NULL, 1394.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12340, 2389, '第12期  结转损益', 10602, '560122-销售费用-一次性用品', '560122', NULL, 1579.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12341, 2389, '第12期  结转损益', 10603, '560123-销售费用-员工关怀', '560123', NULL, 1044.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12342, 2389, '第12期  结转损益', 10604, '560124-销售费用-营业折扣', '560124', NULL, 2463.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12343, 2389, '第12期  结转损益', 10606, '560126-销售费用-垃圾费', '560126', NULL, 400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12344, 2389, '第12期  结转损益', 10608, '560128-销售费用-员工餐', '560128', NULL, 5092, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12345, 2389, '第12期  结转损益', 10609, '560129-销售费用-经营期间购买的小设备', '560129', NULL, 386, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12346, 2389, '第12期  结转损益', 10521, '560205-管理费用-水电费', '560205', NULL, 11078.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12347, 2389, '第12期  结转损益', 10618, '56020801-管理费用-摊销费-房租', '56020801', NULL, 16848.25, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12348, 2389, '第12期  结转损益', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12349, 2389, '第12期  结转损益', 10637, '560213-管理费用-工资', '560213', NULL, 49331.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12350, 2389, '第12期  结转损益', 10638, '560214-管理费用-提成', '560214', NULL, 806.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12351, 2389, '第12期  结转损益', 10639, '560215-管理费用-税金', '560215', NULL, 1219.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12352, 2389, '第12期  结转损益', 10640, '560216-管理费用-租金', '560216', NULL, 3890, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12353, 2389, '第12期  结转损益', 10530, '560301-财务费用-利息费用', '560301', NULL, -36.54, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12354, 2389, '第12期  结转损益', 10531, '560302-财务费用-手续费', '560302', NULL, 279.44, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12355, 2390, '计提8月税金', 10639, '560215-管理费用-税金', '560215', 2569.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12356, 2390, '计提8月税金', 10462, '222126-应交税费-税金', '222126', NULL, 2569.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12357, 2391, '周年庆经费', 10614, '560134-销售费用-推广费', '560134', 3790, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12358, 2391, '周年庆经费', 10548, '100202-银行存款-农业银行', '100202', NULL, 3790, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12359, 2392, '结转12月成本', 10496, '5401-主营业务成本', '5401', 58391.22, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12360, 2392, '结转12月成本-猪骨头', 10569, '140301-原材料-猪骨头', '140301', NULL, 1160, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12361, 2392, '结转12月成本-海鲜', 10571, '140303-原材料-海鲜', '140303', NULL, 1183.57, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12362, 2392, '结转12月成本-海鲜', 10570, '140302-原材料-饮料', '140302', NULL, 338.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12363, 2392, '结转12月成本-面条', 10572, '140304-原材料-面条', '140304', NULL, 3330, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12364, 2392, '结转12月成本-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 1622, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12365, 2392, '结转12月成本-福州干货', 10575, '140307-原材料-福州干货', '140307', NULL, 50756.85, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12366, 2393, '支付总仓剩余货款', 10561, '122104-其他应收款-总仓', '122104', 18890.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12367, 2393, '支付总仓剩余货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 18890.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12368, 2394, '支付陈林报销8月16-31号-低值易耗品', 10598, '560119-销售费用-低值易耗品', '560119', 1476.15, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12369, 2394, '支付陈林报销8月16-31号-广告费', 10514, '560115-销售费用-广告费', '560115', 118, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12370, 2394, '支付陈林报销8月16-31号-原材料', 10572, '140304-原材料-面条', '140304', 2103, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12371, 2394, '支付陈林报销8月16-31号-设备', 10583, '224102-其他应付款-设备，装修', '224102', 2371, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12372, 2394, '支付陈林报销8月16-31号-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 443, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12373, 2394, '支付陈林报销8月16-31号-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12374, 2394, '支付陈林报销8月16-31号-修理费', 10502, '560103-销售费用-修理费', '560103', 69, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12375, 2394, '支付陈林报销8月16-31号-开业福州住宿', 10501, '560102-销售费用-业务招待费', '560102', 600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12376, 2394, '支付陈林报销8月16-31号-一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 970.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12377, 2394, '支付陈林报销8月16-31号-营业折扣', 10604, '560124-销售费用-营业折扣', '560124', 22, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12378, 2394, '支付陈林报销8月16-31号-员工关怀', 10603, '560123-销售费用-员工关怀', '560123', 113.14, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12379, 2394, '支付陈林报销8月16-31号-运费', 10510, '560111-销售费用-运输费', '560111', 1270, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12380, 2394, '支付陈林报销8月16-31号日常费用', 10582, '224101-其他应付款-个人', '224101', NULL, 9620.09, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12381, 2395, '支付5月月结-面条', 10584, '224104-其他应付款-月结款', '224104', 1725, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12382, 2395, '支付5月月结-面条', 10548, '100202-银行存款-农业银行', '100202', NULL, 1725, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12383, 2395, '支付5月月结-蔬菜', 10584, '224104-其他应付款-月结款', '224104', 1203.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12384, 2395, '支付5月月结-蔬菜', 10548, '100202-银行存款-农业银行', '100202', NULL, 1203.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12385, 2396, '支付2月未付款项', 10582, '224101-其他应付款-个人', '224101', 7887, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12386, 2396, '支付2月面条', 10548, '100202-银行存款-农业银行', '100202', NULL, 3305, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12387, 2396, '支付2月面条', 10548, '100202-银行存款-农业银行', '100202', NULL, 697, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12388, 2396, '支付2月虾干', 10548, '100202-银行存款-农业银行', '100202', NULL, 1200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12389, 2396, '支付2月面条', 10548, '100202-银行存款-农业银行', '100202', NULL, 2685, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12390, 2397, '收到许田科备用金退回', 10548, '100202-银行存款-农业银行', '100202', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12391, 2397, '收到许田科备用金退回', 10559, '122102-其他应收款-备用金', '122102', NULL, 5000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12392, 2398, '支付12月员工工资', 10580, '221101-应付职工薪酬-工资', '221101', 49331.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12393, 2398, '支付12月员工工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 49331.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12394, 2399, '支付7-8月开业前期费用报销', 10582, '224101-其他应付款-个人', '224101', 76374.91, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12395, 2399, '支付7-8月开业前期费用报销', 10548, '100202-银行存款-农业银行', '100202', NULL, 76374.91, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12396, 2400, '计提3月工资', 10637, '560213-管理费用-工资', '560213', 23841, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12397, 2400, '计提3月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 23841, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12398, 2401, '收到一点点2019.1-3月房租', 10548, '100202-银行存款-农业银行', '100202', 42500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12399, 2401, '支付一点点2019.1-3月房租', 10548, '100202-银行存款-农业银行', '100202', NULL, 19188, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12400, 2401, '一点点2019.1-3月房租收入', 10489, '5051-其他业务收入', '5051', NULL, 23312, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12401, 2402, '10月农业银行短信费用', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12402, 2402, '10月农业银行短信费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12403, 2403, '支付3月利润分红（10%）', 10481, '310405-利润分配-应付利润', '310405', 7998.96, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12404, 2403, '支付3月利润分红（章，40%）', 10481, '310405-利润分配-应付利润', '310405', 31995.83, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12405, 2403, '支付3月利润分红（夏，40%）', 10481, '310405-利润分配-应付利润', '310405', 31995.83, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12406, 2403, '支付3月利润分红（张，10%）', 10481, '310405-利润分配-应付利润', '310405', 7998.96, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12407, 2403, '支付3月利润分红（陈，10%）', 10481, '310405-利润分配-应付利润', '310405', 7998.96, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12408, 2403, '支付3月利润分红', 10548, '100202-银行存款-农业银行', '100202', NULL, 87988.54, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12409, 2403, '支付3月利润分红结转', 10482, '310406-利润分配-未分配利润', '310406', 87988.54, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12410, 2403, '支付3月利润分红结转', 10481, '310405-利润分配-应付利润', '310405', NULL, 87988.54, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12411, 2404, '支付福州设备及安装费用', 10629, '56020909-管理费用-开办费-设备', '56020909', 3500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12412, 2404, '支付福州冻货', 10575, '140307-原材料-福州干货', '140307', 27005, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12413, 2404, '支付福州物料', 10630, '56020910-管理费用-开办费-小物件', '56020910', 11254.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12414, 2404, '支付福州包材', 10575, '140307-原材料-福州干货', '140307', 6918, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12415, 2404, '支付福州物料、干货冻货', 10547, '100201-银行存款-中国银行', '100201', NULL, 48677.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12416, 2405, '6月备用金报销-粽子', 10603, '560123-销售费用-员工关怀', '560123', 184, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12417, 2405, '6月备用金报销-脱皮花生、白醋、花生瓶', 10577, '140309-原材料-自采购', '140309', 939.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12418, 2405, '6月备用金报销-百洁布', 10598, '560119-销售费用-低值易耗品', '560119', 19.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12419, 2405, '6月备用金报销-锁、调料盒、花生瓶', 10612, '560132-销售费用-物料', '560132', 137, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12420, 2405, '6月备用金报销-话费', 10593, '56010401-销售费用-办公费-电话费', '56010401', 300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12421, 2405, '6月备用金报销-总仓运费', 10510, '560111-销售费用-运输费', '560111', 30, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12422, 2405, '6月备用金报销-健康证报销', 10600, '56012002-销售费用-其他-杂项', '56012002', 228, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12423, 2405, '6月备用金报销', 10559, '122102-其他应收款-备用金', '122102', NULL, 1837.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12424, 2406, '摊销12月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16848.25, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12425, 2406, '摊销12月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16848.25, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12426, 2407, '年末结转损益', 10475, '3103-本年利润', '3103', -269108.29, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12427, 2407, '年末结转损益', 10482, '310406-利润分配-未分配利润', '310406', NULL, -269108.29, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12428, 2408, '8月购买原材料', 10575, '140307-原材料-福州干货', '140307', 45818.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12429, 2408, '8月购买原材料', 10561, '122104-其他应收款-总仓', '122104', NULL, 45818.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12430, 2409, '支付购买开水机费用', 10583, '224102-其他应付款-设备，装修', '224102', 677.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12431, 2409, '支付购买开水机费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 677.1, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12432, 2410, '第8期  结转损益', 10488, '5001-主营业务收入', '5001', 330293.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12433, 2410, '第8期  结转损益', 10495, '530104-营业外收入-盘盈收益', '530104', 4569.12, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12434, 2410, '第8期  结转损益', 10475, '3103-本年利润', '3103', NULL, 123217.15, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12435, 2410, '第8期  结转损益', 10496, '5401-主营业务成本', '5401', NULL, 114269.51, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12436, 2410, '第8期  结转损益', 10501, '560102-销售费用-业务招待费', '560102', NULL, 600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12437, 2410, '第8期  结转损益', 10502, '560103-销售费用-修理费', '560103', NULL, 69, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12438, 2410, '第8期  结转损益', 10593, '56010401-销售费用-办公费-电话费', '56010401', NULL, 100, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12439, 2410, '第8期  结转损益', 10594, '56010402-销售费用-办公费-打印纸', '56010402', NULL, 85, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12440, 2410, '第8期  结转损益', 10595, '56010403-销售费用-办公费-桶装水', '56010403', NULL, 194, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12441, 2410, '第8期  结转损益', 10510, '560111-销售费用-运输费', '560111', NULL, 2062, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12442, 2410, '第8期  结转损益', 10514, '560115-销售费用-广告费', '560115', NULL, 488, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12443, 2410, '第8期  结转损益', 10597, '560117-销售费用-设备-小器具', '560117', NULL, 470, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12444, 2410, '第8期  结转损益', 10598, '560119-销售费用-低值易耗品', '560119', NULL, 3787.45, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12445, 2410, '第8期  结转损益', 10600, '56012002-销售费用-其他-杂项', '56012002', NULL, 2400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12446, 2410, '第8期  结转损益', 10601, '560121-销售费用-厨房原材料-调料', '560121', NULL, 2769.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12447, 2410, '第8期  结转损益', 10602, '560122-销售费用-一次性用品', '560122', NULL, 1399.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12448, 2410, '第8期  结转损益', 10603, '560123-销售费用-员工关怀', '560123', NULL, 2377.74, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12449, 2410, '第8期  结转损益', 10604, '560124-销售费用-营业折扣', '560124', NULL, 6944, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12450, 2410, '第8期  结转损益', 10605, '560125-销售费用-礼券', '560125', NULL, 785, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12451, 2410, '第8期  结转损益', 10521, '560205-管理费用-水电费', '560205', NULL, 7159.04, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12452, 2410, '第8期  结转损益', 10618, '56020801-管理费用-摊销费-房租', '56020801', NULL, 16848.27, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12453, 2410, '第8期  结转损益', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12454, 2410, '第8期  结转损益', 10637, '560213-管理费用-工资', '560213', NULL, 43998.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12455, 2410, '第8期  结转损益', 10638, '560214-管理费用-提成', '560214', NULL, 3587.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12456, 2410, '第8期  结转损益', 10531, '560302-财务费用-手续费', '560302', NULL, 334.79, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12457, 2411, '总仓进货暂借款', 10561, '122104-其他应收款-总仓', '122104', 60000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12458, 2411, '总仓进货暂借款', 10548, '100202-银行存款-农业银行', '100202', NULL, 60000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12459, 2412, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12460, 2412, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12461, 2413, '夏克伟投资款', 10547, '100201-银行存款-中国银行', '100201', 105000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12462, 2413, '夏克伟支付旧巷南保证金', 10555, '12210102-其他应收款-押金-旧巷南保证金', '12210102', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12463, 2413, '夏克伟支付旧巷南加盟费', 10623, '56020903-管理费用-开办费-加盟费', '56020903', 50000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12464, 2413, '夏克伟支付装修设计', 10624, '56020904-管理费用-开办费-装修设计', '56020904', 13000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12465, 2413, '夏克伟支付企划设计', 10625, '56020905-管理费用-开办费-企划设计', '56020905', 7000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12466, 2413, '夏克伟支付桌椅定金', 10626, '56020906-管理费用-开办费-桌椅', '56020906', 15000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12467, 2413, '夏克伟投资款', 10591, '300105-实收资本-夏克伟', '300105', NULL, 200000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12468, 2414, '5月备用金报销款', 10559, '122102-其他应收款-备用金', '122102', 1290.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12469, 2414, '5月备用金报销款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1290.1, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12470, 2415, '摊销3月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16482, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12471, 2415, '摊销3月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16482, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12472, 2415, '摊销3月仓储租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 916.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12473, 2415, '摊销3月仓储租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12474, 2416, '陈林报销10.13-30号日常费用-低值易耗品', 10598, '560119-销售费用-低值易耗品', '560119', 351.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12475, 2416, '陈林报销10.13-30号日常费用-电话费', 10593, '56010401-销售费用-办公费-电话费', '56010401', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12476, 2416, '陈林报销10.13-30号日常费用-垃圾费', 10606, '560126-销售费用-垃圾费', '560126', 400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12477, 2416, '陈林报销10.13-30号日常费用-设备', 10609, '560129-销售费用-经营期间购买的小设备', '560129', 1177, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12478, 2416, '陈林报销10.13-30号日常费用-收银纸', 10594, '56010402-销售费用-办公费-打印纸', '56010402', 129, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12479, 2416, '陈林报销10.13-30号日常费用-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 247, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12480, 2416, '陈林报销10.13-30号日常费用-调料', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 32, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12481, 2416, '陈林报销10.13-30号日常费用-一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 738.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12482, 2416, '陈林报销10.13-30号日常费用-运费', 10510, '560111-销售费用-运输费', '560111', 1370, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12483, 2416, '陈林报销10.13-30号日常费用-猪骨头', 10569, '140301-原材料-猪骨头', '140301', 238, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12484, 2416, '陈林报销10.13-30号日常费用-面条', 10572, '140304-原材料-面条', '140304', 2475, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12485, 2416, '陈林报销10.13-30号日常费用-海鲜', 10571, '140303-原材料-海鲜', '140303', 5.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12486, 2416, '陈林报销10.13-30号日常费用', 10582, '224101-其他应付款-个人', '224101', NULL, 7363.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12487, 2417, '3月总仓进货', 10575, '140307-原材料-福州干货', '140307', 11388.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12488, 2417, '3月总仓进货', 10561, '122104-其他应收款-总仓', '122104', NULL, 11388.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12489, 2418, '收到1点点水电费', 10548, '100202-银行存款-农业银行', '100202', 7285.19, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12490, 2418, '收到1点点水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 7285.19, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12491, 2419, '收到1.29-1.31现金收入', 10548, '100202-银行存款-农业银行', '100202', 973.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12492, 2419, '收到1.29-1.31现金收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 973.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12493, 2419, '收到卖原材料收入', 10548, '100202-银行存款-农业银行', '100202', 320, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12494, 2419, '收到卖原材料收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 320, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12495, 2420, '支付5月水电费-电费', 10521, '560205-管理费用-水电费', '560205', 6257.02, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12496, 2420, '支付5月水电费-电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 6257.02, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12497, 2420, '支付一点点水电费', 10548, '100202-银行存款-农业银行', '100202', 7709.11, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12498, 2420, '支付一点点水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 7709.11, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12499, 2421, '10月购买发票打印机（税控盘及技术维护费）', 10609, '560129-销售费用-经营期间购买的小设备', '560129', 2179, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12500, 2421, '10月购买发票打印机（税控盘及技术维护费）', 10548, '100202-银行存款-农业银行', '100202', NULL, 2179, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12501, 2422, '支付3月工资', 10580, '221101-应付职工薪酬-工资', '221101', 33743, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12502, 2422, '支付3月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 33743, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12503, 2423, '摊销8月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16848.27, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12504, 2423, '摊销8月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16848.27, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12505, 2423, '摊销8月仓储租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 916.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12506, 2423, '摊销8月仓储租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12507, 2424, '确认6月收入-6.23-6.30微信', 10548, '100202-银行存款-农业银行', '100202', 6162.31, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12508, 2424, '确认6月收入-6.23-6.30微信手续费', 10531, '560302-财务费用-手续费', '560302', 12.21, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12509, 2424, '确认6月收入-6.23-6.30微信', 10488, '5001-主营业务收入', '5001', NULL, 6174.52, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12510, 2424, '确认6月收入-6.23-6.30支付宝', 10562, '122105-其他应收款-待入账', '122105', 4144.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12511, 2424, '确认6月收入-6.23-6.30支付宝手续费', 10531, '560302-财务费用-手续费', '560302', 25.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12512, 2424, '确认6月收入-6.23-6.30支付宝', 10488, '5001-主营业务收入', '5001', NULL, 4169.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12513, 2424, '确认6月收入-6.23-6.28美团外卖', 10548, '100202-银行存款-农业银行', '100202', 1988.51, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12514, 2424, '确认6月收入-6.29-6.30美团外卖待入账', 10562, '122105-其他应收款-待入账', '122105', 804.71, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12515, 2424, '确认6月收入-6.29-6.30美团外卖商家折扣', 10604, '560124-销售费用-营业折扣', '560124', 1240.96, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12516, 2424, '确认6月收入-6.29-6.30美团外卖', 10488, '5001-主营业务收入', '5001', NULL, 4034.18, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12517, 2424, '确认6月收入-6.21-6.30现金营业款', 10548, '100202-银行存款-农业银行', '100202', 795, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12518, 2424, '确认6月收入-6.21-6.30现金营业待入账', 10562, '122105-其他应收款-待入账', '122105', 585, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12519, 2424, '确认6月收入-6.21-6.30现金营业', 10488, '5001-主营业务收入', '5001', NULL, 1380, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12520, 2424, '确认6月收入-6.20-6.30美团团购', 10562, '122105-其他应收款-待入账', '122105', 884.94, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12521, 2424, '确认6月收入-6.20-6.30美团团购手续费', 10531, '560302-财务费用-手续费', '560302', 80.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12522, 2424, '确认6月收入-6.20-6.30美团团购', 10488, '5001-主营业务收入', '5001', NULL, 965, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12523, 2424, '确认6月收入-6.1-6.30日饿了么', 10562, '122105-其他应收款-待入账', '122105', 3220.34, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12524, 2424, '确认6月收入-6.1-6.30日饿了么商家折扣', 10604, '560124-销售费用-营业折扣', '560124', 826.24, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12525, 2424, '确认6月收入-6.1-6.30日饿了么', 10488, '5001-主营业务收入', '5001', NULL, 4046.58, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12526, 2424, '6月会员消费', 10566, '122109-其他应收款-会员户', '122109', 7508.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12527, 2424, '6月会员消费手续费', 10531, '560302-财务费用-手续费', '560302', 28.53, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12528, 2424, '6月会员消费', 10488, '5001-主营业务收入', '5001', NULL, 7536.59, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12529, 2424, '6月优免折扣', 10604, '560124-销售费用-营业折扣', '560124', 2634.47, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12530, 2424, '6月优免折扣', 10488, '5001-主营业务收入', '5001', NULL, 2634.47, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12531, 2425, '陈林报销小器具费用', 10629, '56020909-管理费用-开办费-设备', '56020909', 3371.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12532, 2425, '支付福州饺子物料', 10630, '56020910-管理费用-开办费-小物件', '56020910', 6657.46, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12533, 2425, '支付福州饺子物料', 10575, '140307-原材料-福州干货', '140307', 1242.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12534, 2425, '支付福州物料费用', 10547, '100201-银行存款-中国银行', '100201', NULL, 11271.16, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12535, 2426, '结转8月成本', 10496, '5401-主营业务成本', '5401', 53713.35, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12536, 2426, '结转8月成本', 10572, '140304-原材料-面条', '140304', NULL, 2175, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12537, 2426, '结转8月成本', 10574, '140306-原材料-蔬菜', '140306', NULL, 1255.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12538, 2426, '结转8月成本', 10569, '140301-原材料-猪骨头', '140301', NULL, 2005, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12539, 2426, '结转8月成本', 10570, '140302-原材料-饮料', '140302', NULL, 585.07, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12540, 2426, '结转8月成本', 10576, '140308-原材料-凤爪', '140308', NULL, 1760, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12541, 2426, '结转8月成本', 10575, '140307-原材料-福州干货', '140307', NULL, 45932.78, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12542, 2427, '摊销12月仓储租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 916.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12543, 2427, '摊销12月仓储租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12544, 2428, '8月月结款-面条', 10572, '140304-原材料-面条', '140304', 2175, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12545, 2428, '8月月结款-蔬菜及干货白糖', 10574, '140306-原材料-蔬菜', '140306', 1255.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12546, 2428, '8月月结款-饮料', 10570, '140302-原材料-饮料', '140302', 950, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12547, 2428, '8月月结款-鸡架筒骨', 10569, '140301-原材料-猪骨头', '140301', 2005, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12548, 2428, '8月月结款-员工餐', 10608, '560128-销售费用-员工餐', '560128', 2440, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12549, 2428, '8月月结款', 10584, '224104-其他应付款-月结款', '224104', NULL, 8825.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12550, 2429, '计提8月人员工资', 10637, '560213-管理费用-工资', '560213', 43518.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12551, 2429, '计提8月人员提成', 10638, '560214-管理费用-提成', '560214', 3587.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12552, 2429, '计提8月人员工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 43518.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12553, 2429, '计提8月人员工提成', 10581, '221102-应付职工薪酬-提成', '221102', NULL, 3587.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12554, 2430, '支付5月员工工资', 10580, '221101-应付职工薪酬-工资', '221101', 22648, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12555, 2430, '支付5月员工工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 22648, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12556, 2431, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12557, 2431, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12558, 2432, '支付许田科报销备用金', 10582, '224101-其他应付款-个人', '224101', 5158.11, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12559, 2432, '支付许田科报销备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 5158.11, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12560, 2433, '支付1月企划费用', 10514, '560115-销售费用-广告费', '560115', 1000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12561, 2433, '支付1月推广印刷费用', 10514, '560115-销售费用-广告费', '560115', 150, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12562, 2433, '支付1月企划及推广印刷费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 1150, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12563, 2434, '支付灯箱首付款', 10627, '56020907-管理费用-开办费-灯箱', '56020907', 8850, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12564, 2434, '支付灯箱尾款', 10582, '224101-其他应付款-个人', '224101', NULL, 6150, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12565, 2434, '支付灯箱首付款（总额9000）', 10547, '100201-银行存款-中国银行', '100201', NULL, 2700, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12566, 2435, '收到一点点2019.4-6月房租', 10548, '100202-银行存款-农业银行', '100202', 42500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12567, 2435, '支付一点点2019.4-6月房租', 10548, '100202-银行存款-农业银行', '100202', NULL, 19401.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12568, 2435, '支付一点点2019.4-6月房租', 10549, '112301-预付账款-房租', '112301', NULL, 23098.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12569, 2436, '计提员工提成', 10638, '560214-管理费用-提成', '560214', 206, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12570, 2436, '计提员工提成', 10581, '221102-应付职工薪酬-提成', '221102', NULL, 206, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12571, 2437, '支付福州设备费用', 10629, '56020909-管理费用-开办费-设备', '56020909', 17730, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12572, 2437, '支付福州设备费用', 10547, '100201-银行存款-中国银行', '100201', NULL, 17730, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12573, 2438, '计提7月工资', 10635, '56020915-管理费用-开办费-工资', '56020915', 31681, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12574, 2438, '计提7月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 31681, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12575, 2439, '支付4月月结款', 10584, '224104-其他应付款-月结款', '224104', 5740.25, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12576, 2439, '支付4月月结款-面条', 10548, '100202-银行存款-农业银行', '100202', NULL, 2724, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12577, 2439, '支付4月月结款蔬菜及龙骨', 10548, '100202-银行存款-农业银行', '100202', NULL, 3296, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12578, 2439, '支付4月月结款蔬菜及龙骨', 10642, '571112-营业外支出-其他', '571112', 279.75, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12579, 2440, '支付9月工资', 10580, '221101-应付职工薪酬-工资', '221101', 30752, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12580, 2440, '支付9月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 30752, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12581, 2441, '农业银行结息', 10548, '100202-银行存款-农业银行', '100202', 60.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12582, 2441, '农业银行结息', 10530, '560301-财务费用-利息费用', '560301', -60.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12583, 2442, '收到银泰员工餐费用', 10548, '100202-银行存款-农业银行', '100202', 130, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12584, 2442, '收到银泰员工餐费用', 10488, '5001-主营业务收入', '5001', NULL, 130, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12585, 2443, '确认9月收入-美团团购', 10548, '100202-银行存款-农业银行', '100202', 1494.49, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12586, 2443, '确认9月收入-美团团购', 10531, '560302-财务费用-手续费', '560302', 98.14, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12587, 2443, '确认9月收入-美团团购', 10488, '5001-主营业务收入', '5001', NULL, 1264.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12588, 2443, '8月美团团购收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 328.13, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12589, 2444, '4月饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 3593.64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12590, 2444, '4月饿了么收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 3593.64, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12591, 2444, '4月会员消费返款', 10548, '100202-银行存款-农业银行', '100202', 9669.34, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12592, 2444, '4月会员消费返款', 10566, '122109-其他应收款-会员户', '122109', NULL, 9669.34, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12593, 2444, '4月支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 16196.49, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12594, 2444, '4月支付宝收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 16196.49, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12595, 2445, '店面慈溪银泰装修保证金', 10554, '12210101-其他应收款-押金-装修押金', '12210101', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12596, 2445, '店面慈溪银泰装修保证金', 10547, '100201-银行存款-中国银行', '100201', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12597, 2446, '计提2月工资', 10637, '560213-管理费用-工资', '560213', 21523, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12598, 2446, '计提2月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 21523, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12599, 2447, '仓库电费（2017.7-2018.8）', 10521, '560205-管理费用-水电费', '560205', 4000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12600, 2447, '仓库电费（2017.7-2018.8）', 10548, '100202-银行存款-农业银行', '100202', NULL, 4000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12601, 2448, '结转2月成本', 10496, '5401-主营业务成本', '5401', 50470.59, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12602, 2448, '结转2月成本-猪骨头', 10569, '140301-原材料-猪骨头', '140301', NULL, 780, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12603, 2448, '结转2月成本-饮料', 10570, '140302-原材料-饮料', '140302', NULL, 164, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12604, 2448, '结转2月成本-面条', 10572, '140304-原材料-面条', '140304', NULL, 2685, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12605, 2448, '结转2月成本-海鲜', 10571, '140303-原材料-海鲜', '140303', NULL, 1207.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12606, 2448, '结转2月成本-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 1738.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12607, 2448, '结转2月成本-福州干货', 10575, '140307-原材料-福州干货', '140307', NULL, 43895.29, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12608, 2449, '支付9月电费', 10521, '560205-管理费用-水电费', '560205', 10932.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12609, 2449, '支付9月电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 10932.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12610, 2450, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12611, 2450, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12612, 2451, '收到7月会员返款', 10548, '100202-银行存款-农业银行', '100202', 30621.44, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12613, 2451, '收到7月会员返款', 10561, '122104-其他应收款-总仓', '122104', NULL, 30621.44, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12614, 2452, '陈林报销9.18-30号日常费用-低值易耗品', 10598, '560119-销售费用-低值易耗品', '560119', 1348.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12615, 2452, '陈林报销9.18-30号日常费用-海鲜', 10571, '140303-原材料-海鲜', '140303', 300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12616, 2452, '陈林报销9.18-30号日常费用-面条', 10572, '140304-原材料-面条', '140304', 1425, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12617, 2452, '陈林报销9.18-30号日常费用-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 32, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12618, 2452, '陈林报销9.18-30号日常费用-美团刷单', 10600, '56012002-销售费用-其他-杂项', '56012002', 26, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12619, 2452, '陈林报销9.18-30号日常费用-设备', 10597, '560117-销售费用-设备-小器具', '560117', 1789, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12620, 2452, '陈林报销9.18-30号日常费用-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 655, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12621, 2452, '陈林报销9.18-30号日常费用-员工关怀', 10603, '560123-销售费用-员工关怀', '560123', 89, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12622, 2452, '陈林报销9.18-30号日常费用-运费', 10510, '560111-销售费用-运输费', '560111', 806, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12623, 2452, '陈林报销9.18-30号日常费用-软中华', 10501, '560102-销售费用-业务招待费', '560102', 80, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12624, 2452, '陈林报销9.18-30号日常费用-猪骨头', 10569, '140301-原材料-猪骨头', '140301', 345, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12625, 2452, '陈林报销9.18-30号日常费用', 10582, '224101-其他应付款-个人', '224101', NULL, 6895.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12626, 2453, '支付7-8月自采购费用', 10582, '224101-其他应付款-个人', '224101', 8900, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12627, 2453, '支付7-8月自采购费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 8900, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12628, 2454, '6月中国银行结息', 10547, '100201-银行存款-中国银行', '100201', 27.01, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12629, 2454, '6月中国银行结息', 10530, '560301-财务费用-利息费用', '560301', -27.01, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12630, 2455, '收到4月会员返款', 10548, '100202-银行存款-农业银行', '100202', 29696.25, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12631, 2455, '收到4月会员返款', 10561, '122104-其他应收款-总仓', '122104', NULL, 29696.25, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12632, 2456, '收到小汤主（2018.6-2019.6）仓库费', 10548, '100202-银行存款-农业银行', '100202', 6000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12633, 2456, '收到小汤主（2018.6-2019.6）仓库费', 10489, '5051-其他业务收入', '5051', NULL, 6000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12634, 2457, '摊销7月房租', 10636, '56020916-管理费用-开办费-租金', '56020916', 16848.27, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12635, 2457, '摊销7月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16848.27, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12636, 2458, '3月房租摊销', 10618, '56020801-管理费用-摊销费-房租', '56020801', 4898.14, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12637, 2458, '3月房租摊销', 10549, '112301-预付账款-房租', '112301', NULL, 4898.14, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12638, 2458, '3月仓库租金摊销', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 166.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12639, 2458, '3月仓库租金摊销', 10550, '112302-预付账款-仓库租金', '112302', NULL, 166.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12640, 2459, '店长报销备用金-员工餐', 10608, '560128-销售费用-员工餐', '560128', 55, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12641, 2459, '店长报销备用金-员工福利', 10603, '560123-销售费用-员工关怀', '560123', 959.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12642, 2459, '店长报销备用金-低值', 10598, '560119-销售费用-低值易耗品', '560119', 165.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12643, 2459, '店长报销备用金-话费', 10593, '56010401-销售费用-办公费-电话费', '56010401', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12644, 2459, '店长报销备用金-物料', 10612, '560132-销售费用-物料', '560132', 245.46, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12645, 2459, '店长报销备用金-广告', 10514, '560115-销售费用-广告费', '560115', 325, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12646, 2459, '店长报销备用金-工资', 10637, '560213-管理费用-工资', '560213', 858.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12647, 2459, '店长报销备用金-运费', 10510, '560111-销售费用-运输费', '560111', 30, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12648, 2459, '店长报销备用金-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 16, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12649, 2459, '店长报销备用金', 10559, '122102-其他应收款-备用金', '122102', NULL, 2854.36, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12650, 2460, '收到8月饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 3931.59, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12651, 2460, '收到8月饿了么收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 3931.59, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12652, 2460, '8月支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 16012.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12653, 2460, '8月支付宝收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 16012.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12654, 2461, '5月总仓进货', 10575, '140307-原材料-福州干货', '140307', 12552.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12655, 2461, '5月总仓进货', 10561, '122104-其他应收款-总仓', '122104', NULL, 12552.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12656, 2462, '一点点水电费', 10548, '100202-银行存款-农业银行', '100202', 7622.21, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12657, 2462, '一点点水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 7622.21, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12658, 2463, '支付总仓货款', 10561, '122104-其他应收款-总仓', '122104', 37444.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12659, 2463, '支付总仓货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 37443.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12660, 2463, '支付总仓货款', 10592, '530105-营业外收入-其他', '530105', NULL, 0.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12661, 2464, '店面装修款5%', 10622, '56020902-管理费用-开办费-店面装修', '56020902', 16000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12662, 2464, '店面装修款5%', 10547, '100201-银行存款-中国银行', '100201', NULL, 5000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12663, 2464, '店面装修款尾款', 10582, '224101-其他应付款-个人', '224101', NULL, 11000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12664, 2465, '结转2月成本', 10496, '5401-主营业务成本', '5401', 19440.89, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12665, 2465, '结转2月成本', 10575, '140307-原材料-福州干货', '140307', NULL, 17108.37, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12666, 2465, '结转2月成本', 10572, '140304-原材料-面条', '140304', NULL, 1470, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12667, 2465, '结转2月成本', 10574, '140306-原材料-蔬菜', '140306', NULL, 696.34, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12668, 2465, '结转2月成本', 10576, '140308-原材料-凤爪', '140308', NULL, 80, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12669, 2465, '结转2月成本', 10577, '140309-原材料-自采购', '140309', NULL, 86.18, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12670, 2466, '收到8月会员返款', 10548, '100202-银行存款-农业银行', '100202', 26566.45, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12671, 2466, '收到8月会员返款', 10561, '122104-其他应收款-总仓', '122104', NULL, 26566.45, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12672, 2467, '2月总仓进货-福州干货', 10575, '140307-原材料-福州干货', '140307', 71344.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12673, 2467, '2月总仓进货-福州干货', 10561, '122104-其他应收款-总仓', '122104', NULL, 71344.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12674, 2468, '陈林报销9月饮料', 10570, '140302-原材料-饮料', '140302', 950, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12675, 2468, '陈林报销9月饮料', 10582, '224101-其他应付款-个人', '224101', NULL, 950, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12676, 2468, '陈林报销9月猪骨头', 10569, '140301-原材料-猪骨头', '140301', 800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12677, 2468, '陈林报销9月猪骨头', 10582, '224101-其他应付款-个人', '224101', NULL, 800, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12678, 2469, '支付7月工资', 10580, '221101-应付职工薪酬-工资', '221101', 31920, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12679, 2469, '支付7月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 31920, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12680, 2470, '7月店长备用金报销-消毒柜退货运费', 10510, '560111-销售费用-运输费', '560111', 80, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12681, 2470, '7月店长备用金报销-灯管', 10612, '560132-销售费用-物料', '560132', 20, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12682, 2470, '7月店长备用金报销-消毒液', 10598, '560119-销售费用-低值易耗品', '560119', 16.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12683, 2470, '7月店长备用金报销-收银纸、账本', 10596, '56010404-销售费用-办公费-办公用品', '56010404', 192, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12684, 2470, '7月店长备用金报销-雪碧、可乐等', 10570, '140302-原材料-饮料', '140302', 483, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12685, 2470, '7月店长备用金报销-调料盒', 10612, '560132-销售费用-物料', '560132', 125, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12686, 2470, '7月店长备用金报销-直通水阀', 10502, '560103-销售费用-修理费', '560103', 25, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12687, 2470, '7月店长备用金报销-蒸笼纸', 10598, '560119-销售费用-低值易耗品', '560119', 90, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12688, 2470, '7月店长备用金报销-话费', 10593, '56010401-销售费用-办公费-电话费', '56010401', 300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12689, 2470, '7月店长备用金报销-总仓运费', 10510, '560111-销售费用-运输费', '560111', 30, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12690, 2470, '7月店长备用金报销-健康证', 10600, '56012002-销售费用-其他-杂项', '56012002', 100, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12691, 2470, '7月店长备用金报销', 10559, '122102-其他应收款-备用金', '122102', NULL, 1461.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12692, 2471, '6月摊销-房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 2498.46, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12693, 2471, '6月摊销-房租', 10549, '112301-预付账款-房租', '112301', NULL, 2498.46, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12694, 2471, '6月摊销-仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 166.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12695, 2471, '6月摊销-仓库租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 166.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12696, 2472, '10月月结款-面条', 10572, '140304-原材料-面条', '140304', 1215, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12697, 2472, '10月月结款-员工餐', 10608, '560128-销售费用-员工餐', '560128', 1360, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12698, 2472, '10月月结款-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 329.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12699, 2472, '10月月结款-鸡架', 10569, '140301-原材料-猪骨头', '140301', 856, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12700, 2472, '10月月结款-饮料', 10570, '140302-原材料-饮料', '140302', 464, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12701, 2472, '10月月结款-', 10584, '224104-其他应付款-月结款', '224104', NULL, 4224.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12702, 2473, '支付总仓货款', 10561, '122104-其他应收款-总仓', '122104', 27141.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12703, 2473, '支付总仓货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 27141.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12704, 2474, '支付陈林8月报销8.16-31日常费用', 10582, '224101-其他应付款-个人', '224101', 9620.09, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12705, 2474, '支付陈林8月报销8.16-31日常费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 9620.09, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12706, 2475, '支付福州干货', 10575, '140307-原材料-福州干货', '140307', 9346, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12707, 2475, '支付福州干货', 10548, '100202-银行存款-农业银行', '100202', NULL, 9346, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12708, 2476, '支付傅小豹设备费用', 10629, '56020909-管理费用-开办费-设备', '56020909', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12709, 2476, '支付傅小豹设备费用', 10547, '100201-银行存款-中国银行', '100201', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12710, 2477, '支付9月水费', 10521, '560205-管理费用-水电费', '560205', 378, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12711, 2477, '支付9月电费', 10521, '560205-管理费用-水电费', '560205', 10819, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12712, 2477, '支付9月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 11197, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12713, 2478, '开业费用-窗帘窗框', 10622, '56020902-管理费用-开办费-店面装修', '56020902', 2210, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12714, 2478, '开业费用-购买冰箱', 10629, '56020909-管理费用-开办费-设备', '56020909', 4200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12715, 2478, '开业费用-设备尾款', 10629, '56020909-管理费用-开办费-设备', '56020909', 16000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12716, 2478, '开业费用-购买冰箱', 10629, '56020909-管理费用-开办费-设备', '56020909', 4200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12717, 2478, '开业费用-购买开水机', 10629, '56020909-管理费用-开办费-设备', '56020909', 677.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12718, 2478, '开业费用-购买设备', 10629, '56020909-管理费用-开办费-设备', '56020909', 2371, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12719, 2478, '开业费用-装修电箱电缆', 10622, '56020902-管理费用-开办费-店面装修', '56020902', 3450, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12720, 2478, '开业费用-支付装修及设备款', 10583, '224102-其他应付款-设备，装修', '224102', NULL, 33108.1, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12721, 2479, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12722, 2479, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12723, 2480, '支付仓库租金（8月1日开始）', 10550, '112302-预付账款-仓库租金', '112302', 11000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12724, 2480, '支付仓库租金（2017.8-2018.7）', 10561, '122104-其他应收款-总仓', '122104', NULL, 11000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12725, 2481, '确认6月收入-6.1-6.20日现金', 10548, '100202-银行存款-农业银行', '100202', 2693, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12726, 2481, '确认6月收入-6.1-6.20日现金', 10488, '5001-主营业务收入', '5001', NULL, 2693, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12727, 2481, '确认6月收入-6.1-6.22日收钱吧微信', 10548, '100202-银行存款-农业银行', '100202', 14267.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12728, 2481, '确认6月收入-6.1-6.22日收钱吧支付宝', 10562, '122105-其他应收款-待入账', '122105', 12902.45, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12729, 2481, '确认6月收入-6.1-6.22日收钱吧手续费', 10531, '560302-财务费用-手续费', '560302', 106.17, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12730, 2481, '确认6月收入-6.1-6.22日收钱吧', 10488, '5001-主营业务收入', '5001', NULL, 27276.12, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12731, 2481, '确认6月收入-6.1-6.22日美团外卖', 10548, '100202-银行存款-农业银行', '100202', 8490.51, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12732, 2481, '确认5月收入-5.30-5.31日美团外卖待入账', 10562, '122105-其他应收款-待入账', '122105', NULL, 866.94, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12733, 2481, '确认6月收入-6.1-6.22日美团外卖商家折扣及平台服务费', 10604, '560124-销售费用-营业折扣', '560124', 3399.47, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12734, 2481, '确认6月收入-6.1-6.22日美团外卖', 10488, '5001-主营业务收入', '5001', NULL, 11023.04, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12735, 2481, '确认6月收入-6.1-6.19日美团团购', 10548, '100202-银行存款-农业银行', '100202', 2359.99, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12736, 2481, '确认5月收入-5.23-5.31日美团团购待入账', 10562, '122105-其他应收款-待入账', '122105', NULL, 797.02, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12737, 2481, '确认6月收入-6.1-6.19日美团团购手续费', 10531, '560302-财务费用-手续费', '560302', 125.33, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12738, 2481, '确认6月收入-6.1-6.19日美团团购', 10488, '5001-主营业务收入', '5001', NULL, 1688.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12739, 2482, '店面花砖订购', 10622, '56020902-管理费用-开办费-店面装修', '56020902', 6000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12740, 2482, '店面花砖订购', 10547, '100201-银行存款-中国银行', '100201', NULL, 6000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12741, 2483, '预付总仓货款', 10561, '122104-其他应收款-总仓', '122104', 20000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12742, 2483, '预付总仓货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 20000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12743, 2484, '店长备用金报销-打印纸', 10594, '56010402-销售费用-办公费-打印纸', '56010402', 168, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12744, 2484, '店长备用金报销-低值易耗', 10598, '560119-销售费用-低值易耗品', '560119', 298.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12745, 2484, '店长备用金报销-调料盒', 10612, '560132-销售费用-物料', '560132', 125, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12746, 2484, '店长备用金报销-灭火器充气', 10600, '56012002-销售费用-其他-杂项', '56012002', 84, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12747, 2484, '店长备用金报销-胡椒粉醋', 10601, '560121-销售费用-厨房原材料-调料', '560121', 111.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12748, 2484, '店长备用金报销-醋', 10577, '140309-原材料-自采购', '140309', 36.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12749, 2484, '店长备用金报销-健康证', 10600, '56012002-销售费用-其他-杂项', '56012002', 99, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12750, 2484, '店长备用金报销-广告牌', 10514, '560115-销售费用-广告费', '560115', 30, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12751, 2484, '店长备用金报销-雪碧可乐', 10570, '140302-原材料-饮料', '140302', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12752, 2484, '店长备用金报销-脱皮花生', 10577, '140309-原材料-自采购', '140309', 67.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12753, 2484, '店长备用金报销-总仓运费', 10510, '560111-销售费用-运输费', '560111', 70, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12754, 2484, '店长备用金报销', 10559, '122102-其他应收款-备用金', '122102', NULL, 1290.1, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12755, 2485, '确认5月收入-4.30-5.28现金营业款', 10548, '100202-银行存款-农业银行', '100202', 5354.36, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12756, 2485, '确认5月收入-5.29-5.31现金营业款待入账', 10562, '122105-其他应收款-待入账', '122105', 414, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12757, 2485, '确认5月收入-5.1-5.31现金营业款', 10488, '5001-主营业务收入', '5001', NULL, 5616.36, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12758, 2485, '4.30日现金营业款收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 152, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12759, 2485, '确认5月收入-拉卡拉微信', 10548, '100202-银行存款-农业银行', '100202', 21880.55, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12760, 2485, '确认5月收入-拉卡拉支付宝', 10562, '122105-其他应收款-待入账', '122105', 17475.42, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12761, 2485, '确认5月收入-拉卡拉手续费', 10531, '560302-财务费用-手续费', '560302', 148.87, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12762, 2485, '确认5月收入-微信支付宝待入账', 10562, '122105-其他应收款-待入账', '122105', 31, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12763, 2485, '确认5月收入-拉卡拉', 10488, '5001-主营业务收入', '5001', NULL, 39535.84, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12764, 2485, '确认5月收入-4.30-5.31日美团外卖', 10548, '100202-银行存款-农业银行', '100202', 9283.73, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12765, 2485, '确认5月收入-5.1-5.31日美团外卖商家活动支出及平台服务费', 10604, '560124-销售费用-营业折扣', '560124', 4498.17, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12766, 2485, '确认5月收入-5.30-5.31日美团外卖', 10562, '122105-其他应收款-待入账', '122105', 866.94, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12767, 2485, '确认5月收入-5.1-5.31日美团外卖', 10488, '5001-主营业务收入', '5001', NULL, 14283.98, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12768, 2485, '4.30日美团外卖收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 364.86, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12769, 2485, '确认5月收入-4.25-5.22日美团团购收入', 10548, '100202-银行存款-农业银行', '100202', 2607.83, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12770, 2485, '确认5月收入-5.23-5.31日美团团购待入账', 10562, '122105-其他应收款-待入账', '122105', 797.02, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12771, 2485, '确认5月收入-5.1-5.31日美团团购收入平台手续费', 10531, '560302-财务费用-手续费', '560302', 385.39, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12772, 2485, '确认5月收入-5.1-5.31日美团团购收入', 10488, '5001-主营业务收入', '5001', NULL, 3123.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12773, 2485, '4.25-5.31美团团购收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 666.94, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12774, 2485, '确认5月收入-饿了么', 10562, '122105-其他应收款-待入账', '122105', 2036.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12775, 2485, '确认5月收入-饿了么平台服务费', 10604, '560124-销售费用-营业折扣', '560124', 608.01, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12776, 2485, '确认5月收入-饿了么', 10488, '5001-主营业务收入', '5001', NULL, 2644.07, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12777, 2485, '5月会员消费', 10566, '122109-其他应收款-会员户', '122109', 9526.38, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12778, 2485, '5月会员消费手续费', 10531, '560302-财务费用-手续费', '560302', 36.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12779, 2485, '5月会员消费', 10488, '5001-主营业务收入', '5001', NULL, 9562.58, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12780, 2485, '5月优免折扣', 10604, '560124-销售费用-营业折扣', '560124', 3560.46, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12781, 2485, '5月优免折扣', 10488, '5001-主营业务收入', '5001', NULL, 3560.46, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12782, 2486, '支付10月水电费', 10521, '560205-管理费用-水电费', '560205', 11282.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12783, 2486, '支付10月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 11282.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12784, 2487, '1月期末盘点错误  导致2月出现盘盈', 10570, '140302-原材料-饮料', '140302', 489.44, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12785, 2487, '1月期末盘点错误  导致2月出现盘盈', 10575, '140307-原材料-福州干货', '140307', 165, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12786, 2487, '1月期末盘点错误  导致2月出现盘盈', 10592, '530105-营业外收入-其他', '530105', NULL, 654.44, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12787, 2488, '发放9月人员工资', 10580, '221101-应付职工薪酬-工资', '221101', 47924.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12788, 2488, '发放9月人员工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 47924.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12789, 2488, '发放9月人员提成.', 10581, '221102-应付职工薪酬-提成', '221102', 1738, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12790, 2488, '发放9月人员提成.', 10548, '100202-银行存款-农业银行', '100202', NULL, 1738, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12791, 2489, '调整2月成本结转（番茄酱包）', 10496, '5401-主营业务成本', '5401', 4595.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12792, 2489, '调整2月成本结转（番茄酱包）', 10575, '140307-原材料-福州干货', '140307', NULL, 4595.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12793, 2490, '9月月结款-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 891.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12794, 2490, '9月月结款-面条', 10572, '140304-原材料-面条', '140304', 2460, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12795, 2490, '9月月结款-员工餐', 10608, '560128-销售费用-员工餐', '560128', 3200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12796, 2490, '9月月结款-鸡架和筒骨', 10569, '140301-原材料-猪骨头', '140301', 1616, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12797, 2490, '9月月结款-饮料', 10570, '140302-原材料-饮料', '140302', 285, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12798, 2490, '9月月结款', 10584, '224104-其他应付款-月结款', '224104', NULL, 8452.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12799, 2491, '陈林报销9月蔬菜采购', 10574, '140306-原材料-蔬菜', '140306', 2800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12800, 2491, '陈林报销9月蔬菜采购', 10582, '224101-其他应付款-个人', '224101', NULL, 2800, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12801, 2492, '第9期  结转损益', 10488, '5001-主营业务收入', '5001', 212782.88, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12802, 2492, '第9期  结转损益', 10475, '3103-本年利润', '3103', NULL, 30028.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12803, 2492, '第9期  结转损益', 10496, '5401-主营业务成本', '5401', NULL, 72869.23, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12804, 2492, '第9期  结转损益', 10501, '560102-销售费用-业务招待费', '560102', NULL, 1105, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12805, 2492, '第9期  结转损益', 10593, '56010401-销售费用-办公费-电话费', '56010401', NULL, 200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12806, 2492, '第9期  结转损益', 10594, '56010402-销售费用-办公费-打印纸', '56010402', NULL, 236, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12807, 2492, '第9期  结转损益', 10595, '56010403-销售费用-办公费-桶装水', '56010403', NULL, 96, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12808, 2492, '第9期  结转损益', 10596, '56010404-销售费用-办公费-办公用品', '56010404', NULL, 93.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12809, 2492, '第9期  结转损益', 10510, '560111-销售费用-运输费', '560111', NULL, 2006, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12810, 2492, '第9期  结转损益', 10597, '560117-销售费用-设备-小器具', '560117', NULL, 4069, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12811, 2492, '第9期  结转损益', 10598, '560119-销售费用-低值易耗品', '560119', NULL, 2112.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12812, 2492, '第9期  结转损益', 10600, '56012002-销售费用-其他-杂项', '56012002', NULL, 270.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12813, 2492, '第9期  结转损益', 10601, '560121-销售费用-厨房原材料-调料', '560121', NULL, 792, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12814, 2492, '第9期  结转损益', 10602, '560122-销售费用-一次性用品', '560122', NULL, 1238.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12815, 2492, '第9期  结转损益', 10603, '560123-销售费用-员工关怀', '560123', NULL, 5523, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12816, 2492, '第9期  结转损益', 10605, '560125-销售费用-礼券', '560125', NULL, 224, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12817, 2492, '第9期  结转损益', 10606, '560126-销售费用-垃圾费', '560126', NULL, 400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12818, 2492, '第9期  结转损益', 10607, '560127-销售费用-网络招聘费', '560127', NULL, 2800, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12819, 2492, '第9期  结转损益', 10608, '560128-销售费用-员工餐', '560128', NULL, 5390, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12820, 2492, '第9期  结转损益', 10519, '560203-管理费用-修理费', '560203', NULL, 2000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12821, 2492, '第9期  结转损益', 10521, '560205-管理费用-水电费', '560205', NULL, 13729.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12822, 2492, '第9期  结转损益', 10618, '56020801-管理费用-摊销费-房租', '56020801', NULL, 16848.27, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12823, 2492, '第9期  结转损益', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12824, 2492, '第9期  结转损益', 10637, '560213-管理费用-工资', '560213', NULL, 47924.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12825, 2492, '第9期  结转损益', 10638, '560214-管理费用-提成', '560214', NULL, 1738, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12826, 2492, '第9期  结转损益', 10530, '560301-财务费用-利息费用', '560301', NULL, -14.41, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12827, 2492, '第9期  结转损益', 10531, '560302-财务费用-手续费', '560302', NULL, 186.92, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (12828, 2493, '支付仓库租金（2018.6-2019.6）', 10489, '5051-其他业务收入', '5051', 6000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12829, 2493, '支付仓库租金（2018.6-2019.6）', 10548, '100202-银行存款-农业银行', '100202', NULL, 6000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12830, 2494, '支付4月水', 10521, '560205-管理费用-水电费', '560205', 287, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12831, 2494, '支付4月电', 10521, '560205-管理费用-水电费', '560205', 8702.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12832, 2494, '支付4月水电', 10548, '100202-银行存款-农业银行', '100202', NULL, 8989.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12833, 2495, '支付8月伍总开业指导费', 10582, '224101-其他应付款-个人', '224101', 4874, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12834, 2495, '支付8月伍总开业指导费', 10548, '100202-银行存款-农业银行', '100202', NULL, 4874, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12835, 2496, '结转成本', 10496, '5401-主营业务成本', '5401', 36988.96, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12836, 2496, '结转成本-福州', 10575, '140307-原材料-福州干货', '140307', NULL, 32953.36, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12837, 2496, '结转成本-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 329.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12838, 2496, '结转成本-面条', 10572, '140304-原材料-面条', '140304', NULL, 1215, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12839, 2496, '结转成本-饮料', 10570, '140302-原材料-饮料', '140302', NULL, 195, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12840, 2496, '结转成本-鸡架', 10569, '140301-原材料-猪骨头', '140301', NULL, 856, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12841, 2496, '结转成本-凤爪', 10576, '140308-原材料-凤爪', '140308', NULL, 1440, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12842, 2497, '开业指导费', 10631, '56020911-管理费用-开办费-开业指导费', '56020911', 4874, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12843, 2497, '开业指导费', 10582, '224101-其他应付款-个人', '224101', NULL, 4874, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12844, 2498, '计提6月工资', 10637, '560213-管理费用-工资', '560213', 37582, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12845, 2498, '计提6月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 37582, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12846, 2499, '陈林报销店面筹备费用-设备道具', 10629, '56020909-管理费用-开办费-设备', '56020909', 9939, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12847, 2499, '陈林报销店面筹备费用-装修围挡及搬砖费用', 10622, '56020902-管理费用-开办费-店面装修', '56020902', 770, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12848, 2499, '陈林报销店面筹备费用-装修围挡及搬砖费用', 10547, '100201-银行存款-中国银行', '100201', NULL, 10709, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12849, 2500, '支付9月月结款', 10584, '224104-其他应付款-月结款', '224104', 8452.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12850, 2500, '支付9月月结款-餐费', 10548, '100202-银行存款-农业银行', '100202', NULL, 3200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12851, 2500, '支付9月月结款-饮料', 10548, '100202-银行存款-农业银行', '100202', NULL, 285, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12852, 2500, '支付9月月结款-面条', 10548, '100202-银行存款-农业银行', '100202', NULL, 2460, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12853, 2500, '支付9月月结款-蔬菜', 10548, '100202-银行存款-农业银行', '100202', NULL, 2507.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12854, 2501, '陈林报销11月备用金-一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 561.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12855, 2501, '陈林报销11月备用金-打印纸-收银纸', 10594, '56010402-销售费用-办公费-打印纸', '56010402', 128, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12856, 2501, '陈林报销11月备用金-低值易耗', 10598, '560119-销售费用-低值易耗品', '560119', 1330.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12857, 2501, '陈林报销11月备用金-员工关怀', 10603, '560123-销售费用-员工关怀', '560123', 1119, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12858, 2501, '陈林报销11月备用金-运费', 10510, '560111-销售费用-运输费', '560111', 1992, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12859, 2501, '陈林报销11月备用金-垃圾', 10606, '560126-销售费用-垃圾费', '560126', 400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12860, 2501, '陈林报销11月备用金-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 655.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12861, 2501, '陈林报销11月备用金-设备', 10609, '560129-销售费用-经营期间购买的小设备', '560129', 417.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12862, 2501, '陈林报销11月备用金-杂项', 10600, '56012002-销售费用-其他-杂项', '56012002', 339.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12863, 2501, '陈林报销11月备用金-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 45.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12864, 2501, '陈林报销11月备用金-骨头', 10569, '140301-原材料-猪骨头', '140301', 808, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12865, 2501, '陈林报销11月备用金-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 32, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12866, 2501, '陈林报销11月备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 1518.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12867, 2501, '陈林报销11月备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 2120.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12868, 2501, '陈林报销11月备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 1792.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12869, 2501, '任徐侠报销11月备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 1650.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12870, 2501, '任徐侠报销11月备用金', 10582, '224101-其他应付款-个人', '224101', NULL, 747.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12871, 2502, '购进福州物料', 10575, '140307-原材料-福州干货', '140307', 6419.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12872, 2502, '购进福州物料', 10547, '100201-银行存款-中国银行', '100201', NULL, 2608.02, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12873, 2502, '购进福州物料', 10561, '122104-其他应收款-总仓', '122104', NULL, 3811.68, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12874, 2503, '5月月结-面条', 10572, '140304-原材料-面条', '140304', 1725, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12875, 2503, '5月月结-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 1203.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12876, 2503, '5月月结', 10584, '224104-其他应付款-月结款', '224104', NULL, 2928.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12877, 2504, '支付5月工资', 10580, '221101-应付职工薪酬-工资', '221101', 25533, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12878, 2504, '支付5月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 25533, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12879, 2505, '店面装修款45%', 10622, '56020902-管理费用-开办费-店面装修', '56020902', 50000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12880, 2505, '店面装修款45%', 10547, '100201-银行存款-中国银行', '100201', NULL, 50000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12881, 2506, '5月摊销房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 2498.46, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12882, 2506, '5月摊销房租', 10549, '112301-预付账款-房租', '112301', NULL, 2498.46, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12883, 2506, '5月摊销仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 166.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12884, 2506, '5月摊销仓库租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 166.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12885, 2507, '发放10月人员工资', 10580, '221101-应付职工薪酬-工资', '221101', 53889.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12886, 2507, '发放10月人员工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 53889.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12887, 2507, '发放10月人员提成', 10581, '221102-应付职工薪酬-提成', '221102', 2603.37, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12888, 2507, '发放10月人员提成', 10548, '100202-银行存款-农业银行', '100202', NULL, 2603.37, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12889, 2508, '营业款转入（中行-农行）', 10548, '100202-银行存款-农业银行', '100202', 50000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12890, 2508, '营业款转入（中行-农行）', 10561, '122104-其他应收款-总仓', '122104', NULL, 50000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12891, 2509, '总部进货借款', 10561, '122104-其他应收款-总仓', '122104', 20000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12892, 2509, '总部进货借款', 10548, '100202-银行存款-农业银行', '100202', NULL, 20000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12893, 2510, '三小店调货', 10575, '140307-原材料-福州干货', '140307', 10821, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12894, 2510, '三小店调货', 10564, '122107-其他应收款-三小店', '122107', NULL, 10821, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12895, 2511, '支付7月面条款', 10584, '224104-其他应付款-月结款', '224104', 2865, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12896, 2511, '支付7月蔬菜款', 10584, '224104-其他应付款-月结款', '224104', 3968, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12897, 2511, '支付7月员工餐款', 10584, '224104-其他应付款-月结款', '224104', 3150, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12898, 2511, '支付7月员工餐款', 10548, '100202-银行存款-农业银行', '100202', NULL, 3150, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12899, 2511, '支付7月月结款', 10548, '100202-银行存款-农业银行', '100202', NULL, 2865, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12900, 2511, '支付7月月结款', 10548, '100202-银行存款-农业银行', '100202', NULL, 3968, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12901, 2512, '陈林报销9月海鲜采购', 10571, '140303-原材料-海鲜', '140303', 1000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12902, 2512, '陈林报销9月海鲜采购', 10582, '224101-其他应付款-个人', '224101', NULL, 1000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12903, 2513, '计提3月工资', 10637, '560213-管理费用-工资', '560213', 33743, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12904, 2513, '计提3月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 33743, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12905, 2514, '总仓借款', 10561, '122104-其他应收款-总仓', '122104', 30000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12906, 2514, '总仓借款', 10548, '100202-银行存款-农业银行', '100202', NULL, 30000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12907, 2515, '计提11月工资', 10637, '560213-管理费用-工资', '560213', 25681, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12908, 2515, '计提11月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 25681, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12909, 2516, '9月多结转成本', 10574, '140306-原材料-蔬菜', '140306', 1051.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12910, 2516, '9月多结转成本', 10496, '5401-主营业务成本', '5401', NULL, 1051.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12911, 2517, '收到3月支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 17922.84, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12912, 2517, '收到3月支付宝收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 17922.84, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12913, 2517, '收到3月会员消费返款', 10548, '100202-银行存款-农业银行', '100202', 11151.78, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12914, 2517, '收到3月会员消费返款', 10566, '122109-其他应收款-会员户', '122109', NULL, 11151.78, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12915, 2518, '支付4月工资', 10580, '221101-应付职工薪酬-工资', '221101', 26047, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12916, 2518, '支付4月工资少计提工资', 10637, '560213-管理费用-工资', '560213', 427, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12917, 2518, '支付4月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 26474, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12918, 2519, '支付9月备用金报销', 10559, '122102-其他应收款-备用金', '122102', 1757.35, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12919, 2519, '支付9月备用金报销', 10548, '100202-银行存款-农业银行', '100202', NULL, 1757.35, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12920, 2520, '摊销6月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16665.14, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12921, 2520, '摊销6月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16665.14, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12922, 2520, '摊销6月仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 916.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12923, 2520, '摊销6月仓库租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12924, 2521, '4.12利润分红-夏克伟', 10481, '310405-利润分配-应付利润', '310405', 20000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12925, 2521, '4.12利润分红-章总', 10481, '310405-利润分配-应付利润', '310405', 20000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12926, 2521, '4.12利润分红-张竹挺', 10481, '310405-利润分配-应付利润', '310405', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12927, 2521, '4.12利润分红-陈林', 10481, '310405-利润分配-应付利润', '310405', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12928, 2521, '4.12利润分红-章总（前期利润分配）', 10481, '310405-利润分配-应付利润', '310405', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12929, 2521, '4.12利润分红', 10548, '100202-银行存款-农业银行', '100202', NULL, 55000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12930, 2521, '4.12利润分红结转-夏克伟', 10482, '310406-利润分配-未分配利润', '310406', 20000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12931, 2521, '4.12利润分红结转-章总', 10482, '310406-利润分配-未分配利润', '310406', 20000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12932, 2521, '4.12利润分红结转-张竹挺', 10482, '310406-利润分配-未分配利润', '310406', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12933, 2521, '4.12利润分红结转-陈林', 10482, '310406-利润分配-未分配利润', '310406', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12934, 2521, '4.12利润分红结转-章总（前期利润分配）', 10482, '310406-利润分配-未分配利润', '310406', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12935, 2521, '4.12利润分红结转-夏克伟', 10481, '310405-利润分配-应付利润', '310405', NULL, 20000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12936, 2521, '4.12利润分红结转-章总', 10481, '310405-利润分配-应付利润', '310405', NULL, 20000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12937, 2521, '4.12利润分红结转-张竹挺', 10481, '310405-利润分配-应付利润', '310405', NULL, 5000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12938, 2521, '4.12利润分红结转-陈林', 10481, '310405-利润分配-应付利润', '310405', NULL, 5000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12939, 2521, '4.12利润分红结转-章总（前期利润分配）', 10481, '310405-利润分配-应付利润', '310405', NULL, 5000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12940, 2522, '陈林申请借备用金（首次）', 10559, '122102-其他应收款-备用金', '122102', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12941, 2522, '陈林申请借备用金（首次）', 10548, '100202-银行存款-农业银行', '100202', NULL, 5000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12942, 2523, '结转5月成本', 10496, '5401-主营业务成本', '5401', 25186.45, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12943, 2523, '结转5月成本-福州干货', 10575, '140307-原材料-福州干货', '140307', NULL, 20493.95, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12944, 2523, '结转5月成本-饮料', 10570, '140302-原材料-饮料', '140302', NULL, 144.43, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12945, 2523, '结转5月成本-面条', 10572, '140304-原材料-面条', '140304', NULL, 1725, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12946, 2523, '结转5月成本-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 1279.07, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12947, 2523, '结转5月成本-凤爪', 10576, '140308-原材料-凤爪', '140308', NULL, 1440, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12948, 2523, '结转5月成本-自采购', 10577, '140309-原材料-自采购', '140309', NULL, 104, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12949, 2524, '1月店长报销备用金-办公用品', 10596, '56010404-销售费用-办公费-办公用品', '56010404', 214.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12950, 2524, '1月店长报销备用金-低值易耗', 10598, '560119-销售费用-低值易耗品', '560119', 451.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12951, 2524, '1月店长报销备用金-骨头', 10569, '140301-原材料-猪骨头', '140301', 1040, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12952, 2524, '1月店长报销备用金-广告', 10514, '560115-销售费用-广告费', '560115', 865, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12953, 2524, '1月店长报销备用金-垃圾费', 10606, '560126-销售费用-垃圾费', '560126', 400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12954, 2524, '1月店长报销备用金-制定手册、帽子，制服清洗等杂费', 10600, '56012002-销售费用-其他-杂项', '56012002', 775, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12955, 2524, '1月店长报销备用金-清洁用品', 10610, '560130-销售费用-清洁用品', '560130', 497.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12956, 2524, '1月店长报销备用金-设备-暖烫煲', 10609, '560129-销售费用-经营期间购买的小设备', '560129', 230, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12957, 2524, '1月店长报销备用金-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 17.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12958, 2524, '1月店长报销备用金-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 248.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12959, 2524, '1月店长报销备用金-维修费', 10502, '560103-销售费用-修理费', '560103', 786, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12960, 2524, '1月店长报销备用金-一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 668.88, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12961, 2524, '1月店长报销备用金-员工关怀', 10603, '560123-销售费用-员工关怀', '560123', 1450, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12962, 2524, '1月店长报销备用金-运输费', 10510, '560111-销售费用-运输费', '560111', 230, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12963, 2524, '1月店长报销备用金', 10582, '224101-其他应付款-个人', '224101', NULL, 5158.11, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12964, 2524, '1月店长报销备用金-未报销', 10582, '224101-其他应付款-个人', '224101', NULL, 2715.97, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12965, 2525, '支付9月蔬菜款', 10574, '140306-原材料-蔬菜', '140306', 139.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12966, 2525, '支付9月蔬菜款', 10548, '100202-银行存款-农业银行', '100202', NULL, 139.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12967, 2525, '支付9月面条款', 10572, '140304-原材料-面条', '140304', 579, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12968, 2525, '支付9月面条款', 10548, '100202-银行存款-农业银行', '100202', NULL, 579, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12969, 2525, '支付8月面条款', 10584, '224104-其他应付款-月结款', '224104', 1740, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12970, 2525, '支付8月面条款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1740, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12971, 2526, '5月调味料盘盈', 10575, '140307-原材料-福州干货', '140307', 440, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12972, 2526, '5月调味料盘盈', 10495, '530104-营业外收入-盘盈收益', '530104', NULL, 440, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12973, 2526, '5月材料盘亏', 10642, '571112-营业外支出-其他', '571112', 507.12, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12974, 2526, '5月材料盘亏', 10575, '140307-原材料-福州干货', '140307', NULL, 507.12, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12975, 2527, '2月摊销-房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 4898.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12976, 2527, '2月摊销-房租', 10549, '112301-预付账款-房租', '112301', NULL, 4898.13, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12977, 2527, '2月摊销-仓储租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 166.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12978, 2527, '2月摊销-仓储租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 166.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12979, 2528, '支付租金及物业（2018.10-12）', 10549, '112301-预付账款-房租', '112301', 50544.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12980, 2528, '支付租金及物业（2018.10-12）', 10548, '100202-银行存款-农业银行', '100202', NULL, 50544.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12981, 2529, '6月成本结转', 10496, '5401-主营业务成本', '5401', 24968.42, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12982, 2529, '6月成本结转-总部', 10575, '140307-原材料-福州干货', '140307', NULL, 20046.61, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12983, 2529, '6月成本结转-面条', 10572, '140304-原材料-面条', '140304', NULL, 1575, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12984, 2529, '6月成本结转-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 1578.47, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12985, 2529, '6月成本结转-凤爪', 10576, '140308-原材料-凤爪', '140308', NULL, 1160, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12986, 2529, '6月成本结转-自采购', 10577, '140309-原材料-自采购', '140309', NULL, 552.77, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12987, 2529, '6月成本结转-饮料', 10570, '140302-原材料-饮料', '140302', NULL, 55.57, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12988, 2530, '发放3月工资', 10580, '221101-应付职工薪酬-工资', '221101', 23841, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12989, 2530, '发放3月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 23841, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12990, 2531, '结转成本', 10496, '5401-主营业务成本', '5401', 51549.99, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12991, 2531, '结转成本', 10575, '140307-原材料-福州干货', '140307', NULL, 42722.16, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12992, 2531, '结转成本', 10574, '140306-原材料-蔬菜', '140306', NULL, 1962.05, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12993, 2531, '结转成本', 10572, '140304-原材料-面条', '140304', NULL, 2460, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12994, 2531, '结转成本', 10569, '140301-原材料-猪骨头', '140301', NULL, 1616, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12995, 2531, '结转成本', 10576, '140308-原材料-凤爪', '140308', NULL, 2240, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12996, 2531, '结转成本', 10570, '140302-原材料-饮料', '140302', NULL, 549.78, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12997, 2532, '支付桌椅改造款项', 10502, '560103-销售费用-修理费', '560103', 1400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12998, 2532, '支付桌椅改造款项', 10548, '100202-银行存款-农业银行', '100202', NULL, 1400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (12999, 2533, '陈林投资款', 10547, '100201-银行存款-中国银行', '100201', 50000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13000, 2533, '严岳思投资款', 10547, '100201-银行存款-中国银行', '100201', 80000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13001, 2533, '章永刚投资款', 10547, '100201-银行存款-中国银行', '100201', 120000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13002, 2533, '张竹挺投资款', 10547, '100201-银行存款-中国银行', '100201', 50000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13003, 2533, '陈林投资款', 10587, '300101-实收资本-陈林', '300101', NULL, 50000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13004, 2533, '严岳思投资款', 10588, '300102-实收资本-严岳思', '300102', NULL, 80000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13005, 2533, '章永刚投资款', 10589, '300103-实收资本-章永刚', '300103', NULL, 120000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13006, 2533, '张竹挺投资款', 10590, '300104-实收资本-张竹挺', '300104', NULL, 50000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13007, 2534, '支付活动风扇款', 10604, '560124-销售费用-营业折扣', '560124', 836.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13008, 2534, '支付活动风扇款', 10548, '100202-银行存款-农业银行', '100202', NULL, 836.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13009, 2535, '支付1-3月地税', 10639, '560215-管理费用-税金', '560215', 3658.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13010, 2535, '支付1-3月国税', 10639, '560215-管理费用-税金', '560215', 4050, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13011, 2535, '支付1-3月国地税', 10462, '222126-应交税费-税金', '222126', NULL, 7708.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13012, 2536, '支付四月备用金报销', 10559, '122102-其他应收款-备用金', '122102', 1071.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13013, 2536, '支付四月备用金报销', 10548, '100202-银行存款-农业银行', '100202', NULL, 1071.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13014, 2536, '支付面条月结款', 10584, '224104-其他应付款-月结款', '224104', 1755, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13015, 2536, '支付面条月结款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1755, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13016, 2536, '支付凤爪款', 10584, '224104-其他应付款-月结款', '224104', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13017, 2536, '支付凤爪款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13018, 2536, '4月蔬菜月结', 10584, '224104-其他应付款-月结款', '224104', 1534.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13019, 2536, '4月蔬菜月结', 10548, '100202-银行存款-农业银行', '100202', NULL, 1534.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13020, 2537, '10月进货', 10575, '140307-原材料-福州干货', '140307', 15069.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13021, 2537, '10月进货', 10561, '122104-其他应收款-总仓', '122104', NULL, 15069.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13022, 2538, '收到打款认证', 10547, '100201-银行存款-中国银行', '100201', 0.34, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13023, 2538, '收到打款认证', 10530, '560301-财务费用-利息费用', '560301', -0.34, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13024, 2539, '11月员工餐', 10608, '560128-销售费用-员工餐', '560128', 2000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13025, 2539, '11月面条', 10572, '140304-原材料-面条', '140304', 1755, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13026, 2539, '11月蔬菜', 10574, '140306-原材料-蔬菜', '140306', 1392.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13027, 2539, '11月鸡架、筒骨', 10569, '140301-原材料-猪骨头', '140301', 947.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13028, 2539, '11月月结款', 10584, '224104-其他应付款-月结款', '224104', NULL, 6095.1, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13029, 2540, '2.27-3.27现金收入', 10548, '100202-银行存款-农业银行', '100202', 4603.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13030, 2540, '3.28-3.31现金待收入', 10562, '122105-其他应收款-待入账', '122105', 603, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13031, 2540, '2.27-2.28现金待收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 324, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13032, 2540, '3.1-3.31现金收入', 10488, '5001-主营业务收入', '5001', NULL, 4882.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13033, 2540, '3.1-3.31收钱吧-微信收入', 10548, '100202-银行存款-农业银行', '100202', 22681.79, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13034, 2540, '3.1-3.31收钱吧-微信收入手续费', 10531, '560302-财务费用-手续费', '560302', 153.43, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13035, 2540, '3.1-3.31收钱吧-支付宝收入', 10562, '122105-其他应收款-待入账', '122105', 17922.84, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13036, 2540, '3.1-3.31收钱吧-支付宝微信收入', 10488, '5001-主营业务收入', '5001', NULL, 40758.06, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13037, 2540, '3.1-3.30美团外卖收入', 10548, '100202-银行存款-农业银行', '100202', 11474.55, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13038, 2540, '3.31美团外卖待收入', 10562, '122105-其他应收款-待入账', '122105', 298.89, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13039, 2540, '3.1-3.31美团外卖收入', 10488, '5001-主营业务收入', '5001', NULL, 11773.44, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13040, 2540, '2.28-3.27美团团购收入', 10548, '100202-银行存款-农业银行', '100202', 2788.68, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13041, 2540, '3.28-3.31美团团购待收入', 10562, '122105-其他应收款-待入账', '122105', 539.58, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13042, 2540, '2.28美团团购待收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 152.91, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13043, 2540, '3月美团团购收入手续费', 10531, '560302-财务费用-手续费', '560302', 465.55, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13044, 2540, '3月美团团购收入', 10488, '5001-主营业务收入', '5001', NULL, 3640.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13045, 2540, '3月饿了么收入', 10562, '122105-其他应收款-待入账', '122105', 3208.47, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13046, 2540, '3月饿了么收入', 10488, '5001-主营业务收入', '5001', NULL, 3208.47, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13047, 2540, '3月会员消费', 10566, '122109-其他应收款-会员户', '122109', 11151.78, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13048, 2540, '3月会员消费', 10531, '560302-财务费用-手续费', '560302', 42.38, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13049, 2540, '3月会员消费', 10488, '5001-主营业务收入', '5001', NULL, 11194.16, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13050, 2540, '3月优免折扣', 10604, '560124-销售费用-营业折扣', '560124', 3647.58, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13051, 2540, '3月优免折扣', 10488, '5001-主营业务收入', '5001', NULL, 3647.58, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13052, 2541, '5月店长备用金报销-办公用品及收银纸', 10594, '56010402-销售费用-办公费-打印纸', '56010402', 299.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13053, 2541, '5月店长备用金报销-低值易耗', 10598, '560119-销售费用-低值易耗品', '560119', 747.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13054, 2541, '5月店长备用金报销-货架', 10612, '560132-销售费用-物料', '560132', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13055, 2541, '5月店长备用金报销-电话费', 10593, '56010401-销售费用-办公费-电话费', '56010401', 500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13056, 2541, '5月店长备用金报销-器具', 10597, '560117-销售费用-设备-小器具', '560117', 332, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13057, 2541, '5月店长备用金报销-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 191.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13058, 2541, '5月店长备用金报销-通下水', 10502, '560103-销售费用-修理费', '560103', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13059, 2541, '5月店长备用金报销-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 56, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13060, 2541, '5月店长备用金报销-桶装水押金', 10557, '12210104-其他应收款-押金-桶装水', '12210104', 25, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13061, 2541, '5月店长备用金报销-物料', 10612, '560132-销售费用-物料', '560132', 281.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13062, 2541, '5月店长备用金报销-一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 1055.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13063, 2541, '5月店长备用金报销-可乐5箱', 10570, '140302-原材料-饮料', '140302', 237.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13064, 2541, '5月店长备用金报销-红酒', 10604, '560124-销售费用-营业折扣', '560124', 240, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13065, 2541, '5月店长备用金报销-员工餐', 10608, '560128-销售费用-员工餐', '560128', 50, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13066, 2541, '5月店长备用金报销-员工福利', 10603, '560123-销售费用-员工关怀', '560123', 764, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13067, 2541, '5月店长备用金报销-运费', 10510, '560111-销售费用-运输费', '560111', 180, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13068, 2541, '5月店长备用金报销', 10548, '100202-银行存款-农业银行', '100202', NULL, 2497.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13069, 2541, '5月店长备用金报销', 10559, '122102-其他应收款-备用金', '122102', NULL, 2862.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13070, 2542, '3月结转成本', 10575, '140307-原材料-福州干货', '140307', NULL, 37145.15, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13071, 2542, '3月结转成本', 10569, '140301-原材料-猪骨头', '140301', NULL, 1040, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13072, 2542, '3月结转成本', 10570, '140302-原材料-饮料', '140302', NULL, 430.44, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13073, 2542, '3月结转成本', 10571, '140303-原材料-海鲜', '140303', NULL, 1000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13074, 2542, '3月结转成本', 10572, '140304-原材料-面条', '140304', NULL, 2778, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13075, 2542, '3月结转成本', 10574, '140306-原材料-蔬菜', '140306', NULL, 1522.66, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13076, 2542, '3月结转成本', 10496, '5401-主营业务成本', '5401', 43916.25, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13077, 2543, '采购中秋月饼赠送', 10604, '560124-销售费用-营业折扣', '560124', 1135, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13078, 2543, '采购中秋月饼赠送', 10548, '100202-银行存款-农业银行', '100202', NULL, 1135, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13079, 2544, '确认6月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 21294, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13080, 2544, '确认6月收入-小白盒及美团', 10548, '100202-银行存款-农业银行', '100202', 105930.28, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13081, 2544, '确认6月收入-饿了么', 10548, '100202-银行存款-农业银行', '100202', 4209.84, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13082, 2544, '确认6月收入-平台手续费', 10531, '560302-财务费用-手续费', '560302', 1925.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13083, 2544, '确认6月收入-会员卡消费', 10561, '122104-其他应收款-总仓', '122104', 32322.28, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13084, 2544, '确认6月收入-会员卡消费', 10531, '560302-财务费用-手续费', '560302', 122.82, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13085, 2544, '确认6月收入-礼券', 10604, '560124-销售费用-营业折扣', '560124', 220, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13086, 2544, '确认6月收入-优免活动折扣', 10604, '560124-销售费用-营业折扣', '560124', 10157.38, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13087, 2544, '确认6月收入', 10488, '5001-主营业务收入', '5001', NULL, 176182, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13088, 2545, '代付一点点3月水电费', 10548, '100202-银行存款-农业银行', '100202', 7124.71, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13089, 2545, '代付一点点3月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 7124.71, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13090, 2546, '支付3月总仓货款', 10561, '122104-其他应收款-总仓', '122104', 11388.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13091, 2546, '支付3月总仓货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 11388.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13092, 2547, '支付8月福州货款', 10575, '140307-原材料-福州干货', '140307', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13093, 2547, '支付8月福州货款', 10561, '122104-其他应收款-总仓', '122104', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13094, 2548, '5月员工餐', 10608, '560128-销售费用-员工餐', '560128', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13095, 2548, '5月员工餐', 10584, '224104-其他应付款-月结款', '224104', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13096, 2549, '第1期  结转损益', 10488, '5001-主营业务收入', '5001', 153298.78, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13097, 2549, '第1期  结转损益', 10475, '3103-本年利润', '3103', NULL, 5503.43, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13098, 2549, '第1期  结转损益', 10496, '5401-主营业务成本', '5401', NULL, 54863.52, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13099, 2549, '第1期  结转损益', 10502, '560103-销售费用-修理费', '560103', NULL, 786, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13100, 2549, '第1期  结转损益', 10596, '56010404-销售费用-办公费-办公用品', '56010404', NULL, 214.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13101, 2549, '第1期  结转损益', 10510, '560111-销售费用-运输费', '560111', NULL, 230, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13102, 2549, '第1期  结转损益', 10514, '560115-销售费用-广告费', '560115', NULL, 2775, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13103, 2549, '第1期  结转损益', 10598, '560119-销售费用-低值易耗品', '560119', NULL, 451.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13104, 2549, '第1期  结转损益', 10600, '56012002-销售费用-其他-杂项', '56012002', NULL, 828, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13105, 2549, '第1期  结转损益', 10601, '560121-销售费用-厨房原材料-调料', '560121', NULL, 248.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13106, 2549, '第1期  结转损益', 10602, '560122-销售费用-一次性用品', '560122', NULL, 763.88, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13107, 2549, '第1期  结转损益', 10603, '560123-销售费用-员工关怀', '560123', NULL, 1650, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13108, 2549, '第1期  结转损益', 10604, '560124-销售费用-营业折扣', '560124', NULL, 333, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13109, 2549, '第1期  结转损益', 10606, '560126-销售费用-垃圾费', '560126', NULL, 400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13110, 2549, '第1期  结转损益', 10608, '560128-销售费用-员工餐', '560128', NULL, 3849, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13111, 2549, '第1期  结转损益', 10609, '560129-销售费用-经营期间购买的小设备', '560129', NULL, 525, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13112, 2549, '第1期  结转损益', 10610, '560130-销售费用-清洁用品', '560130', NULL, 497.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13113, 2549, '第1期  结转损益', 10521, '560205-管理费用-水电费', '560205', NULL, 11778.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13114, 2549, '第1期  结转损益', 10618, '56020801-管理费用-摊销费-房租', '56020801', NULL, 16482, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13115, 2549, '第1期  结转损益', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13116, 2549, '第1期  结转损益', 10637, '560213-管理费用-工资', '560213', NULL, 44427.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13117, 2549, '第1期  结转损益', 10638, '560214-管理费用-提成', '560214', NULL, 289.65, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13118, 2549, '第1期  结转损益', 10639, '560215-管理费用-税金', '560215', NULL, 5269.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13119, 2549, '第1期  结转损益', 10531, '560302-财务费用-手续费', '560302', NULL, 216.03, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13120, 2550, '支付一点点水电费', 10548, '100202-银行存款-农业银行', '100202', 8994.99, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13121, 2550, '支付一点点水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 8994.99, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13122, 2550, '旧巷南支付8月水费', 10521, '560205-管理费用-水电费', '560205', 238, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13123, 2550, '旧巷南支付8月电费', 10521, '560205-管理费用-水电费', '560205', 6499.58, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13124, 2550, '旧巷南支付8月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 6737.58, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13125, 2551, '2月进货', 10575, '140307-原材料-福州干货', '140307', 21729.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13126, 2551, '2月进货', 10561, '122104-其他应收款-总仓', '122104', NULL, 21729.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13127, 2552, '9月店长报销备用金-办公用品', 10596, '56010404-销售费用-办公费-办公用品', '56010404', 28, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13128, 2552, '9月店长报销备用金-低值易耗', 10598, '560119-销售费用-低值易耗品', '560119', 1910, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13129, 2552, '9月店长报销备用金-垃圾费（7-9月）', 10606, '560126-销售费用-垃圾费', '560126', 1200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13130, 2552, '9月店长报销备用金-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 18.85, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13131, 2552, '9月店长报销备用金-胡椒粉', 10601, '560121-销售费用-厨房原材料-调料', '560121', 121.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13132, 2552, '9月店长报销备用金-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 96, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13133, 2552, '9月店长报销备用金-维修费', 10502, '560103-销售费用-修理费', '560103', 220, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13134, 2552, '9月店长报销备用金-员工餐', 10608, '560128-销售费用-员工餐', '560128', 40, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13135, 2552, '9月店长报销备用金-员工关怀', 10603, '560123-销售费用-员工关怀', '560123', 463.92, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13136, 2552, '9月店长报销备用金-运费', 10510, '560111-销售费用-运输费', '560111', 154, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13137, 2552, '9月店长报销备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 2494.92, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13138, 2552, '9月店长报销备用金', 10559, '122102-其他应收款-备用金', '122102', NULL, 1757.35, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13139, 2553, '6月报损肉面36斤', 10642, '571112-营业外支出-其他', '571112', 813.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13140, 2553, '6月报损肉面36斤', 10575, '140307-原材料-福州干货', '140307', NULL, 813.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13141, 2554, '收到1点点房租及押金', 10548, '100202-银行存款-农业银行', '100202', 62500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13142, 2554, '收到1点点房租及押金（2018.10-2019.1.9）', 10489, '5051-其他业务收入', '5051', NULL, 42500, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13143, 2554, '收到1点点押金（2018.10-2019.1.9）', 10585, '224105-其他应付款-履约保证金', '224105', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13144, 2554, '收到1点点装修押金（2018.10-2019.1.9）', 10586, '224106-其他应付款-装修押金', '224106', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13145, 2555, '11月缴纳地税税金', 10639, '560215-管理费用-税金', '560215', 1219.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13146, 2555, '11月缴纳地税税金', 10548, '100202-银行存款-农业银行', '100202', NULL, 1219.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13147, 2556, '章总公关费用', 10621, '56020901-管理费用-开办费-公关费用', '56020901', 40000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13148, 2556, '章总公关费用', 10547, '100201-银行存款-中国银行', '100201', NULL, 40000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13149, 2557, '计提9月税金', 10639, '560215-管理费用-税金', '560215', 2569.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13150, 2557, '计提9月税金', 10462, '222126-应交税费-税金', '222126', NULL, 2569.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13151, 2558, '调整3月成本', 10496, '5401-主营业务成本', '5401', 10585.21, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13152, 2558, '调整3月成本', 10575, '140307-原材料-福州干货', '140307', NULL, 10585.21, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13153, 2559, '支付2月水费', 10521, '560205-管理费用-水电费', '560205', 245, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13154, 2559, '支付2月电费', 10521, '560205-管理费用-水电费', '560205', 10617.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13155, 2559, '支付2月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 10862.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13156, 2560, '支付王国华桌椅费用40%', 10626, '56020906-管理费用-开办费-桌椅', '56020906', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13157, 2560, '支付王国华桌椅费用40%', 10547, '100201-银行存款-中国银行', '100201', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13158, 2561, '支付4月员工餐', 10584, '224104-其他应付款-月结款', '224104', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13159, 2561, '支付4月员工餐', 10548, '100202-银行存款-农业银行', '100202', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13160, 2561, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13161, 2561, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13162, 2562, '收到小白盒押金退回', 10548, '100202-银行存款-农业银行', '100202', 199, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13163, 2562, '收到小白盒押金退回', 10597, '560117-销售费用-设备-小器具', '560117', NULL, 199, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13164, 2563, '店长报销备用金-办公', 10596, '56010404-销售费用-办公费-办公用品', '56010404', 179, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13165, 2563, '店长报销备用金-餐费', 10608, '560128-销售费用-员工餐', '560128', 157.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13166, 2563, '店长报销备用金-低值', 10598, '560119-销售费用-低值易耗品', '560119', 1113.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13167, 2563, '店长报销备用金-修理费', 10502, '560103-销售费用-修理费', '560103', 30, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13168, 2563, '店长报销备用金-生日蛋糕', 10603, '560123-销售费用-员工关怀', '560123', 99.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13169, 2563, '店长报销备用金-健康证', 10600, '56012002-销售费用-其他-杂项', '56012002', 103.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13170, 2563, '店长报销备用金-9-11月垃圾费', 10606, '560126-销售费用-垃圾费', '560126', 800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13171, 2563, '店长报销备用金-喷绘', 10615, '560135-销售费用-装修费', '560135', 140, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13172, 2563, '店长报销备用金-推广', 10614, '560134-销售费用-推广费', '560134', 150, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13173, 2563, '店长报销备用金-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 14.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13174, 2563, '店长报销备用金-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 210.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13175, 2563, '店长报销备用金-运费', 10510, '560111-销售费用-运输费', '560111', 76, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13176, 2563, '店长报销备用金', 10559, '122102-其他应收款-备用金', '122102', NULL, 3073.77, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13177, 2564, '1月计提员工提成5%', 10638, '560214-管理费用-提成', '560214', 289.65, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13178, 2564, '1月计提员工提成5%', 10581, '221102-应付职工薪酬-提成', '221102', NULL, 289.65, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13179, 2565, '店面银泰履约保证金', 10556, '12210103-其他应收款-押金-履约保证金', '12210103', 50132.75, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13180, 2565, '店面银泰履约保证金', 10547, '100201-银行存款-中国银行', '100201', NULL, 50132.75, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13181, 2566, '摊销10月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16848.26, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13182, 2566, '摊销10月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16848.26, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13183, 2566, '摊销10月仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 166.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13184, 2566, '摊销10月仓库租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 166.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13185, 2567, '陈林报销开业费用-广告宣传', 10634, '56020914-管理费用-开办费-广告费', '56020914', 920, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13186, 2567, '陈林报销开业费用-冻库租金', 10636, '56020916-管理费用-开办费-租金', '56020916', 300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13187, 2567, '陈林报销开业费用-试品尝最慈溪美食', 10628, '56020908-管理费用-开办费-业务招待费用', '56020908', 6861.72, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13188, 2567, '陈林报销开业费用-设备', 10629, '56020909-管理费用-开办费-设备', '56020909', 29880, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13189, 2567, '陈林报销开业费用-调料', 10633, '56020913-管理费用-开办费-其他', '56020913', 29.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13190, 2567, '陈林报销开业费用-小器具', 10629, '56020909-管理费用-开办费-设备', '56020909', 320.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13191, 2567, '陈林报销开业费用-小器具', 10628, '56020908-管理费用-开办费-业务招待费用', '56020908', 2237.46, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13192, 2567, '陈林报销开业费用-一次性用品', 10633, '56020913-管理费用-开办费-其他', '56020913', 78.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13193, 2567, '陈林报销开业费用-一次性用品', 10633, '56020913-管理费用-开办费-其他', '56020913', 775, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13194, 2567, '陈林报销开业费用-猪骨头', 10569, '140301-原材料-猪骨头', '140301', 40, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13195, 2567, '陈林报销开业费用-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 34, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13196, 2567, '陈林报销开业费用-面条', 10572, '140304-原材料-面条', '140304', 93, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13197, 2567, '陈林报销开业费用-海鲜', 10571, '140303-原材料-海鲜', '140303', 600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13198, 2567, '陈林报销开业费用-运费', 10633, '56020913-管理费用-开办费-其他', '56020913', 2746, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13199, 2567, '陈林报销开业费用-杂货', 10633, '56020913-管理费用-开办费-其他', '56020913', 3940.33, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13200, 2567, '陈林报销开业费用-装修设备及安装费用', 10622, '56020902-管理费用-开办费-店面装修', '56020902', 27519, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13201, 2567, '陈林报销开业前期费用', 10582, '224101-其他应付款-个人', '224101', NULL, 76374.91, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13202, 2568, '2月支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 12118.03, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13203, 2568, '2月支付宝收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 12118.03, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13204, 2569, '一点点水电费', 10548, '100202-银行存款-农业银行', '100202', 7654.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13205, 2569, '一点点水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 7654.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13206, 2570, '3月虾油盘盈', 10575, '140307-原材料-福州干货', '140307', 37, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13207, 2570, '3月虾油盘盈', 10592, '530105-营业外收入-其他', '530105', NULL, 37, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13208, 2571, '收到2月饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 3235.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13209, 2571, '收到2月饿了么收入', 10488, '5001-主营业务收入', '5001', 693.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13210, 2571, '收到2月饿了么收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 3929, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13211, 2572, '陈林报销7-8月低值易耗品', 10598, '560119-销售费用-低值易耗品', '560119', 2012.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13212, 2572, '陈林报销7-8月电话费', 10593, '56010401-销售费用-办公费-电话费', '56010401', 100, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13213, 2572, '陈林报销7-8月广告费', 10514, '560115-销售费用-广告费', '560115', 320, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13214, 2572, '陈林报销7-8月海鲜', 10571, '140303-原材料-海鲜', '140303', 750, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13215, 2572, '陈林报销7-8月面条', 10572, '140304-原材料-面条', '140304', 2015, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13216, 2572, '陈林报销7-8月花篮等', 10600, '56012002-销售费用-其他-杂项', '56012002', 2400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13217, 2572, '陈林报销7-8月打印纸', 10594, '56010402-销售费用-办公费-打印纸', '56010402', 85, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13218, 2572, '陈林报销7-8月厨具', 10597, '560117-销售费用-设备-小器具', '560117', 470, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13219, 2572, '陈林报销7-8月人员工资', 10637, '560213-管理费用-工资', '560213', 480, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13220, 2572, '陈林报销7-8月调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 1964.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13221, 2572, '陈林报销7-8月桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 130, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13222, 2572, '陈林报销7-8月桶装水押金', 10557, '12210104-其他应收款-押金-桶装水', '12210104', 20, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13223, 2572, '陈林报销7-8月一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 138.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13224, 2572, '陈林报销7-8月顾客鱼面退款', 10604, '560124-销售费用-营业折扣', '560124', 22, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13225, 2572, '陈林报销7-8月员工关怀', 10603, '560123-销售费用-员工关怀', '560123', 1777.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13226, 2572, '陈林报销7-8月原材料-花生', 10573, '140305-原材料-花生', '140305', 857.78, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13227, 2572, '陈林报销7-8月原材料运费', 10510, '560111-销售费用-运输费', '560111', 792, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13228, 2572, '陈林报销7-8月日常费用及开销', 10561, '122104-其他应收款-总仓', '122104', NULL, 14334.18, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13229, 2573, '6月月结款-面条', 10572, '140304-原材料-面条', '140304', 2628, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13230, 2573, '6月月结款-蔬菜及干货', 10574, '140306-原材料-蔬菜', '140306', 1850.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13231, 2573, '6月月结款-虾干、白糖', 10574, '140306-原材料-蔬菜', '140306', 428.75, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13232, 2573, '6月月结款-鸡架及筒骨', 10569, '140301-原材料-猪骨头', '140301', 1260, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13233, 2573, '6月月结款-员工餐', 10608, '560128-销售费用-员工餐', '560128', 3440, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13234, 2573, '6月月结款-饮料', 10570, '140302-原材料-饮料', '140302', 362.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13235, 2573, '6月月结款', 10584, '224104-其他应付款-月结款', '224104', NULL, 9969.75, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13236, 2574, '计提5月工资', 10637, '560213-管理费用-工资', '560213', 22648, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13237, 2574, '计提5月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 22648, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13238, 2575, '支付4月总仓货款', 10561, '122104-其他应收款-总仓', '122104', 36848, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13239, 2575, '支付4月总仓货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 36848, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13240, 2575, '支付四月水电费', 10521, '560205-管理费用-水电费', '560205', 5724.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13241, 2575, '支付四月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 5724.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13242, 2576, '支付10月员工伙食费', 10582, '224101-其他应付款-个人', '224101', 4750, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13243, 2576, '支付10月员工伙食费', 10548, '100202-银行存款-农业银行', '100202', NULL, 4750, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13244, 2576, '支付10月员工伙食费', 10582, '224101-其他应付款-个人', '224101', 7363.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13245, 2576, '支付10月员工伙食费', 10548, '100202-银行存款-农业银行', '100202', NULL, 7363.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13246, 2577, '8月现金营业款', 10548, '100202-银行存款-农业银行', '100202', 580, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13247, 2577, '8月现金营业款', 10562, '122105-其他应收款-待入账', '122105', NULL, 580, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13248, 2578, '支付4-6月房租', 10549, '112301-预付账款-房租', '112301', 49995.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13249, 2578, '支付4-6月房租', 10548, '100202-银行存款-农业银行', '100202', NULL, 49995.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13250, 2579, '2月月结-蔬菜筒骨', 10574, '140306-原材料-蔬菜', '140306', 624.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13251, 2579, '2月月结-白糖', 10574, '140306-原材料-蔬菜', '140306', 112.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13252, 2579, '2月月结-面条', 10572, '140304-原材料-面条', '140304', 1470, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13253, 2579, '2月月结-餐费', 10608, '560128-销售费用-员工餐', '560128', 1200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13254, 2579, '2月月结', 10584, '224104-其他应付款-月结款', '224104', NULL, 3406.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13255, 2580, '支付9月剩余货款', 10561, '122104-其他应收款-总仓', '122104', 33268, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13256, 2580, '支付9月剩余货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 33268, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13257, 2581, '采购9月凤爪', 10576, '140308-原材料-凤爪', '140308', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13258, 2581, '采购9月凤爪', 10548, '100202-银行存款-农业银行', '100202', NULL, 1600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13259, 2582, '计提8月工资', 10637, '560213-管理费用-工资', '560213', 20497, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13260, 2582, '计提8月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 20497, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13261, 2583, '摊销9月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16848.26, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13262, 2583, '补摊销7-8月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 366.26, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13263, 2583, '补摊销7-8月房租', 10549, '112301-预付账款-房租', '112301', NULL, 17214.52, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13264, 2583, '摊销8月仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 166.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13265, 2583, '摊销9月仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 166.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13266, 2583, '摊销8-9月仓库租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 333.34, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13267, 2584, '3月成本结转', 10496, '5401-主营业务成本', '5401', 19885.65, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13268, 2584, '3月成本结转-福州干货', 10575, '140307-原材料-福州干货', '140307', NULL, 15274.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13269, 2584, '3月成本结转-饮料', 10570, '140302-原材料-饮料', '140302', NULL, 516, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13270, 2584, '3月成本结转-面条', 10572, '140304-原材料-面条', '140304', NULL, 1830, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13271, 2584, '3月成本结转-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 1688.86, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13272, 2584, '3月成本结转-凤爪', 10576, '140308-原材料-凤爪', '140308', NULL, 576.29, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13273, 2585, '支付预售卡押金', 10565, '122108-其他应收款-预售卡押金', '122108', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13274, 2585, '支付预售卡押金', 10548, '100202-银行存款-农业银行', '100202', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13275, 2586, '支付月结款-面条', 10584, '224104-其他应付款-月结款', '224104', 2310, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13276, 2586, '支付月结款-面条', 10548, '100202-银行存款-农业银行', '100202', NULL, 2310, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13277, 2586, '支付月结款-员工餐', 10584, '224104-其他应付款-月结款', '224104', 2600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13278, 2586, '支付月结款-员工餐', 10548, '100202-银行存款-农业银行', '100202', NULL, 2600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13279, 2586, '支付月结款-蔬菜', 10584, '224104-其他应付款-月结款', '224104', 3100, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13280, 2586, '支付月结款-蔬菜', 10548, '100202-银行存款-农业银行', '100202', NULL, 3100, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13281, 2587, '摊销11月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16848.27, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13282, 2587, '摊销11月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16848.27, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13283, 2587, '摊销11月仓储租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 916.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13284, 2587, '摊销11月仓储租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13285, 2588, '农业银行结息', 10548, '100202-银行存款-农业银行', '100202', 3.93, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13286, 2588, '农业银行结息', 10530, '560301-财务费用-利息费用', '560301', -3.93, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13287, 2589, '陈林报销开业费用如考察团住宿，餐费等', 10628, '56020908-管理费用-开办费-业务招待费用', '56020908', 2307.16, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13288, 2589, '陈林报销开业费用如施工、围挡喷绘及制作等', 10622, '56020902-管理费用-开办费-店面装修', '56020902', 7234, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13289, 2589, '陈林报销收银机、麻吉系统', 10629, '56020909-管理费用-开办费-设备', '56020909', 5550, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13290, 2589, '陈林报销开业费用', 10547, '100201-银行存款-中国银行', '100201', NULL, 15091.16, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13291, 2590, '支付2019.4-6月房租', 10549, '112301-预付账款-房租', '112301', 30594.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13292, 2590, '支付2019.4-6月房租物业', 10548, '100202-银行存款-农业银行', '100202', NULL, 30594.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13293, 2591, '2月会员消费返款', 10548, '100202-银行存款-农业银行', '100202', 7669.38, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13294, 2591, '2月会员消费返款', 10566, '122109-其他应收款-会员户', '122109', NULL, 7669.38, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13295, 2591, '2月饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 5673.56, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13296, 2591, '2月饿了么收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 5673.56, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13297, 2592, '3月原材料采购', 10575, '140307-原材料-福州干货', '140307', 15763.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13298, 2592, '3月原材料采购', 10561, '122104-其他应收款-总仓', '122104', NULL, 15763.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13299, 2593, '收到2月支付宝款', 10548, '100202-银行存款-农业银行', '100202', 65767.31, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13300, 2593, '收到2月支付宝款', 10562, '122105-其他应收款-待入账', '122105', NULL, 65767.31, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13301, 2593, '收到2月微信款', 10548, '100202-银行存款-农业银行', '100202', 22508, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13302, 2593, '收到2月微信款', 10562, '122105-其他应收款-待入账', '122105', NULL, 22508, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13303, 2594, '店长报销备用金-打印纸', 10594, '56010402-销售费用-办公费-打印纸', '56010402', 169.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13304, 2594, '店长报销备用金-低值', 10598, '560119-销售费用-低值易耗品', '560119', 687.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13305, 2594, '店长报销备用金-员工福利', 10603, '560123-销售费用-员工关怀', '560123', 968.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13306, 2594, '店长报销备用金-交通', 10613, '560133-销售费用-交通费', '560133', 34, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13307, 2594, '店长报销备用金-垃圾费4-5月', 10606, '560126-销售费用-垃圾费', '560126', 800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13308, 2594, '店长报销备用金-垃圾费空调清洗', 10502, '560103-销售费用-修理费', '560103', 1050, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13309, 2594, '店长报销备用金-阿乐健康证', 10600, '56012002-销售费用-其他-杂项', '56012002', 100, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13310, 2594, '店长报销备用金-蒸炉', 10609, '560129-销售费用-经营期间购买的小设备', '560129', 600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13311, 2594, '店长报销备用金-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 1137.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13312, 2594, '店长报销备用金-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 80, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13313, 2594, '店长报销备用金-活动装饰及其他物料', 10612, '560132-销售费用-物料', '560132', 1467.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13314, 2594, '店长报销备用金-员工餐', 10608, '560128-销售费用-员工餐', '560128', 60, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13315, 2594, '店长报销备用金-运费', 10510, '560111-销售费用-运输费', '560111', 354, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13316, 2594, '店长报销备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 5644.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13317, 2594, '店长报销备用金', 10559, '122102-其他应收款-备用金', '122102', NULL, 1863.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13318, 2595, '支付灯箱尾款', 10582, '224101-其他应付款-个人', '224101', 6150, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13319, 2595, '支付灯箱尾款', 10561, '122104-其他应收款-总仓', '122104', NULL, 6150, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13320, 2596, '支付4月员工工资', 10580, '221101-应付职工薪酬-工资', '221101', 23611, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13321, 2596, '支付4月员工工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 23611, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13322, 2597, '支付福州货款', 10575, '140307-原材料-福州干货', '140307', 25665.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13323, 2597, '支付福州货款', 10400, '1402-在途物资', '1402', 2850, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13324, 2597, '支付福州货款中含上月少付的差价', 10495, '530104-营业外收入-盘盈收益', '530104', 280, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13325, 2597, '支付福州货款多付0.4元尾差', 10495, '530104-营业外收入-盘盈收益', '530104', 0.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13326, 2597, '支付福州货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 28796, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13327, 2597, '11.7号补付福州货款', 10575, '140307-原材料-福州干货', '140307', 40, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13328, 2597, '11.7号补付福州货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 40, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13329, 2598, '支付3月电费', 10521, '560205-管理费用-水电费', '560205', 5691.22, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13330, 2598, '支付3月电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 5691.22, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13331, 2599, '计提9月工资', 10637, '560213-管理费用-工资', '560213', 30752, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13332, 2599, '计提9月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 30752, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13333, 2600, '支付10月鸡爪', 10576, '140308-原材料-凤爪', '140308', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13334, 2600, '支付10月鸡爪', 10548, '100202-银行存款-农业银行', '100202', NULL, 1600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13335, 2601, '8月成本结转', 10496, '5401-主营业务成本', '5401', 25410.64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13336, 2601, '8月成本结转-总部干货', 10575, '140307-原材料-福州干货', '140307', NULL, 20715.75, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13337, 2601, '8月成本结转-凤爪', 10576, '140308-原材料-凤爪', '140308', NULL, 1280, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13338, 2601, '8月成本结转-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 1430.75, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13339, 2601, '8月成本结转-面条', 10572, '140304-原材料-面条', '140304', NULL, 1740, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13340, 2601, '8月成本结转-饮料', 10570, '140302-原材料-饮料', '140302', NULL, 244.14, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13341, 2602, '报销2月备用金-低值', 10598, '560119-销售费用-低值易耗品', '560119', 314.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13342, 2602, '报销2月备用金-手机充值', 10593, '56010401-销售费用-办公费-电话费', '56010401', 300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13343, 2602, '报销2月备用金-垃圾费', 10606, '560126-销售费用-垃圾费', '560126', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13344, 2602, '报销2月备用金-维修', 10502, '560103-销售费用-修理费', '560103', 700, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13345, 2602, '报销2月备用金-运费', 10510, '560111-销售费用-运输费', '560111', 75, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13346, 2602, '报销2月备用金-其他', 10600, '56012002-销售费用-其他-杂项', '56012002', 12, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13347, 2602, '报销2月备用金-白醋', 10601, '560121-销售费用-厨房原材料-调料', '560121', 18, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13348, 2602, '报销2月备用金', 10559, '122102-其他应收款-备用金', '122102', NULL, 1619.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13349, 2603, '支付7月水电费', 10521, '560205-管理费用-水电费', '560205', 14049, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13350, 2603, '支付8月水电费', 10521, '560205-管理费用-水电费', '560205', 12460, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13351, 2603, '支付7-8月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 26509, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13352, 2604, '支付2月水费', 10521, '560205-管理费用-水电费', '560205', 868, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13353, 2604, '支付2月电费', 10521, '560205-管理费用-水电费', '560205', 5890.91, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13354, 2604, '支付2月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 6758.91, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13355, 2605, '收到5月会员返款', 10548, '100202-银行存款-农业银行', '100202', 31467.92, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13356, 2605, '收到5月会员返款', 10561, '122104-其他应收款-总仓', '122104', NULL, 31467.92, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13357, 2606, '计提11月人员工资', 10637, '560213-管理费用-工资', '560213', 46830.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13358, 2606, '计提11月人员工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 46830.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13359, 2607, '4月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 4361, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13360, 2607, '4月收入-4.30现金待入账', 10562, '122105-其他应收款-待入账', '122105', 152, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13361, 2607, '4月收入-现金', 10488, '5001-主营业务收入', '5001', NULL, 4513, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13362, 2607, '4月收入-微信', 10548, '100202-银行存款-农业银行', '100202', 21706.37, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13363, 2607, '4月收入-微信手续费', 10531, '560302-财务费用-手续费', '560302', 42.99, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13364, 2607, '4月收入-微信', 10488, '5001-主营业务收入', '5001', NULL, 21749.36, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13365, 2607, '4月收入-支付宝', 10562, '122105-其他应收款-待入账', '122105', 16196.49, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13366, 2607, '4月收入-支付宝手续费', 10531, '560302-财务费用-手续费', '560302', 97.79, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13367, 2607, '4月收入-支付宝', 10488, '5001-主营业务收入', '5001', NULL, 16294.28, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13368, 2607, '4月收入-美团团购', 10548, '100202-银行存款-农业银行', '100202', 2904.03, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13369, 2607, '4月收入-美团团购', 10562, '122105-其他应收款-待入账', '122105', 666.94, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13370, 2607, '3月美团团购到帐', 10562, '122105-其他应收款-待入账', '122105', NULL, 539.58, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13371, 2607, '4月收入-美团团购平台服务费', 10531, '560302-财务费用-手续费', '560302', 456.71, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13372, 2607, '4月收入-美团团购', 10488, '5001-主营业务收入', '5001', NULL, 3488.1, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13373, 2607, '4月收入-美团外卖', 10548, '100202-银行存款-农业银行', '100202', 8836.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13374, 2607, '4月收入-美团外卖待入账', 10562, '122105-其他应收款-待入账', '122105', 364.86, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13375, 2607, '3月美团外卖待到帐', 10562, '122105-其他应收款-待入账', '122105', NULL, 298.89, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13376, 2607, '4月收入-美团外卖', 10604, '560124-销售费用-营业折扣', '560124', 4330.28, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13377, 2607, '4月收入-美团外卖', 10488, '5001-主营业务收入', '5001', NULL, 13232.65, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13378, 2607, '4月收入-饿了么待入账', 10562, '122105-其他应收款-待入账', '122105', 3593.64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13379, 2607, '4月收入-饿了么', 10488, '5001-主营业务收入', '5001', NULL, 3593.64, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13380, 2607, '4月报损', 10604, '560124-销售费用-营业折扣', '560124', 9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13381, 2607, '4月报损', 10488, '5001-主营业务收入', '5001', NULL, 9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13382, 2607, '4月会员消费', 10566, '122109-其他应收款-会员户', '122109', 9669.34, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13383, 2607, '4月会员消费手续费', 10531, '560302-财务费用-手续费', '560302', 36.74, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13384, 2607, '4月会员消费', 10488, '5001-主营业务收入', '5001', NULL, 9706.08, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13385, 2607, '4月优免折扣', 10604, '560124-销售费用-营业折扣', '560124', 3496.48, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13386, 2607, '4月优免折扣', 10488, '5001-主营业务收入', '5001', NULL, 3496.48, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13387, 2608, '1.1-1.28现金', 10548, '100202-银行存款-农业银行', '100202', 5788, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13388, 2608, '1.29-1.31现金', 10562, '122105-其他应收款-待入账', '122105', 973.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13389, 2608, '1.1-1.28现金', 10488, '5001-主营业务收入', '5001', NULL, 6761.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13390, 2608, '1.1-1.31饿了么', 10548, '100202-银行存款-农业银行', '100202', 4386.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13391, 2608, '1.1-1.31饿了么', 10488, '5001-主营业务收入', '5001', NULL, 4386.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13392, 2608, '1.3-31美团', 10548, '100202-银行存款-农业银行', '100202', 20609.65, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13393, 2608, '1.3-31美团', 10488, '5001-主营业务收入', '5001', NULL, 20609.65, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13394, 2608, '1.1-31收钱吧-微信', 10548, '100202-银行存款-农业银行', '100202', 22527.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13395, 2608, '1.1-31收钱吧-支付宝', 10562, '122105-其他应收款-待入账', '122105', 17297.83, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13396, 2608, '1.1-31收钱吧-手续费', 10531, '560302-财务费用-手续费', '560302', 140.71, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13397, 2608, '1.1-31收钱吧-支付宝', 10488, '5001-主营业务收入', '5001', NULL, 39966.04, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13398, 2608, '收到12.1-31支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 18614.45, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13399, 2608, '收到12.1-31支付宝收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 18614.45, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13400, 2608, '收到会员消费', 10566, '122109-其他应收款-会员户', '122109', 10975.52, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13401, 2608, '收到会员消费', 10531, '560302-财务费用-手续费', '560302', 41.71, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13402, 2608, '收到会员消费', 10488, '5001-主营业务收入', '5001', NULL, 11017.23, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13403, 2608, '1.1-31报损', 10604, '560124-销售费用-营业折扣', '560124', 21, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13404, 2608, '1.1-31报损', 10488, '5001-主营业务收入', '5001', NULL, 21, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13405, 2608, '收到优免折扣', 10604, '560124-销售费用-营业折扣', '560124', 11914.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13406, 2608, '收到优免折扣', 10488, '5001-主营业务收入', '5001', NULL, 11914.13, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13407, 2609, '支付红包雨', 10616, '560136-销售费用-红包雨', '560136', 858.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13408, 2609, '支付红包雨', 10548, '100202-银行存款-农业银行', '100202', NULL, 858.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13409, 2609, '支付凤爪费用', 10576, '140308-原材料-凤爪', '140308', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13410, 2609, '支付凤爪费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 1600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13411, 2610, '计提11月税金', 10639, '560215-管理费用-税金', '560215', 2569.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13412, 2610, '计提11月税金', 10462, '222126-应交税费-税金', '222126', NULL, 2569.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13413, 2611, '支付8月人员工资', 10580, '221101-应付职工薪酬-工资', '221101', 43518.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13414, 2611, '支付8月人员提成', 10581, '221102-应付职工薪酬-提成', '221102', 3587.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13415, 2611, '支付8月人员工资及提成', 10561, '122104-其他应收款-总仓', '122104', NULL, 47105.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13416, 2612, '陈林报销日常开销-低值易耗品', 10598, '560119-销售费用-低值易耗品', '560119', 299, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13417, 2612, '陈林报销日常开销-广告制作', 10514, '560115-销售费用-广告费', '560115', 50, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13418, 2612, '陈林报销日常开销-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 87.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13419, 2612, '陈林报销日常开销-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 362.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13420, 2612, '陈林报销日常开销-一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 290, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13421, 2612, '陈林报销日常开销-员工关怀', 10603, '560123-销售费用-员工关怀', '560123', 487.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13422, 2612, '陈林报销日常开销', 10561, '122104-其他应收款-总仓', '122104', NULL, 1575.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13423, 2613, '1月单机会员充值', 10548, '100202-银行存款-农业银行', '100202', 1250, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13424, 2613, '1月单机会员充值', 10579, '220302-预收账款-单机会员充值', '220302', NULL, 1250, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13425, 2614, '预付2018.1-3月店面房租', 10549, '112301-预付账款-房租', '112301', 49446, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13426, 2614, '预付2018.1-3月店面房租', 10548, '100202-银行存款-农业银行', '100202', NULL, 49446, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13427, 2615, '支付月结款-饮料', 10584, '224104-其他应付款-月结款', '224104', 464, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13428, 2615, '支付月结款-饮料', 10548, '100202-银行存款-农业银行', '100202', NULL, 464, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13429, 2615, '支付月结凤爪款', 10576, '140308-原材料-凤爪', '140308', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13430, 2615, '支付月结凤爪款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13431, 2616, '1月自购蔬菜筒骨', 10574, '140306-原材料-蔬菜', '140306', 880.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13432, 2616, '1月自购面条', 10572, '140304-原材料-面条', '140304', 2025, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13433, 2616, '1月自购香菇鸡架', 10574, '140306-原材料-蔬菜', '140306', 145, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13434, 2616, '1月自购大豆油', 10574, '140306-原材料-蔬菜', '140306', 124, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13435, 2616, '1月自购白糖', 10574, '140306-原材料-蔬菜', '140306', 106.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13436, 2616, '1月员工餐', 10608, '560128-销售费用-员工餐', '560128', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13437, 2616, '1月月结', 10584, '224104-其他应付款-月结款', '224104', NULL, 4580.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13438, 2617, '支付8月工资', 10580, '221101-应付职工薪酬-工资', '221101', 31033, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13439, 2617, '支付8月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 31033, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13440, 2618, '确认9月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 11276, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13441, 2618, '确认9月收入-现金（29-30）', 10562, '122105-其他应收款-待入账', '122105', 901, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13442, 2618, '确认9月收入-饿了么外卖', 10562, '122105-其他应收款-待入账', '122105', 7457.19, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13443, 2618, '确认9月收入-饿了么外卖', 10562, '122105-其他应收款-待入账', '122105', 713.46, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13444, 2618, '确认9月收入-饿了么外卖手续费', 10531, '560302-财务费用-手续费', '560302', 1893.92, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13445, 2618, '确认9月收入-微信收入', 10548, '100202-银行存款-农业银行', '100202', 41742.96, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13446, 2618, '确认9月收入-支付宝收入', 10562, '122105-其他应收款-待入账', '122105', 30690.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13447, 2618, '确认9月收入-手续费', 10531, '560302-财务费用-手续费', '560302', 237, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13448, 2618, '确认9月收入-美团外卖', 10548, '100202-银行存款-农业银行', '100202', 17848.01, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13449, 2618, '确认9月收入-美团外卖手续费', 10531, '560302-财务费用-手续费', '560302', 1036.29, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13450, 2618, '确认9月收入-美团团购', 10548, '100202-银行存款-农业银行', '100202', 3906.09, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13451, 2618, '确认9月收入-会员消费', 10561, '122104-其他应收款-总仓', '122104', 27658.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13452, 2618, '确认9月收入-会员消费手续费', 10531, '560302-财务费用-手续费', '560302', 105.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13453, 2618, '确认9月收入-报损', 10604, '560124-销售费用-营业折扣', '560124', 114, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13454, 2618, '确认9月收入-喵街收入', 10562, '122105-其他应收款-待入账', '122105', 393.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13455, 2618, '确认9月收入-优免活动', 10604, '560124-销售费用-营业折扣', '560124', 13440.35, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13456, 2618, '确认9月收入-团购待入账', 10562, '122105-其他应收款-待入账', '122105', 1243.87, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13457, 2618, '确认9月收入', 10488, '5001-主营业务收入', '5001', NULL, 160657.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13458, 2619, '计提2月4%提成', 10638, '560214-管理费用-提成', '560214', 996, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13459, 2619, '计提2月4%提成', 10581, '221102-应付职工薪酬-提成', '221102', NULL, 996, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13460, 2620, '9月结转成本', 10496, '5401-主营业务成本', '5401', 72869.23, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13461, 2620, '9月结转成本-猪骨头', 10569, '140301-原材料-猪骨头', '140301', NULL, 1365, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13462, 2620, '9月结转成本-饮料', 10570, '140302-原材料-饮料', '140302', NULL, 842.28, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13463, 2620, '9月结转成本-海鲜', 10571, '140303-原材料-海鲜', '140303', NULL, 1582, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13464, 2620, '9月结转成本-面条', 10572, '140304-原材料-面条', '140304', NULL, 3432, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13465, 2620, '9月结转成本-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 2879.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13466, 2620, '9月结转成本-福州干货', 10575, '140307-原材料-福州干货', '140307', NULL, 62768.05, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13467, 2621, '收到9月现金到帐', 10548, '100202-银行存款-农业银行', '100202', 901, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13468, 2621, '收到9月现金到帐', 10562, '122105-其他应收款-待入账', '122105', NULL, 901, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13469, 2622, '5月总仓进货', 10575, '140307-原材料-福州干货', '140307', 57443.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13470, 2622, '5月总仓进货', 10561, '122104-其他应收款-总仓', '122104', NULL, 57443.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13471, 2623, '6月月结-蔬菜', 10584, '224104-其他应付款-月结款', '224104', 1170.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13472, 2623, '6月月结-蔬菜', 10548, '100202-银行存款-农业银行', '100202', NULL, 1170.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13473, 2623, '6月月结-面条', 10584, '224104-其他应付款-月结款', '224104', 1575, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13474, 2623, '6月月结-面条', 10548, '100202-银行存款-农业银行', '100202', NULL, 1575, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13475, 2624, '陈林报销9.11-17号日常报销-办公用品', 10596, '56010404-销售费用-办公费-办公用品', '56010404', 93.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13476, 2624, '陈林报销9.11-17号日常报销-打印纸', 10594, '56010402-销售费用-办公费-打印纸', '56010402', 118, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13477, 2624, '陈林报销9.11-17号日常报销-低值易耗品', 10598, '560119-销售费用-低值易耗品', '560119', 439, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13478, 2624, '陈林报销9.11-17号日常报销-电话费', 10593, '56010401-销售费用-办公费-电话费', '56010401', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13479, 2624, '陈林报销9.11-17号日常报销-海鲜', 10571, '140303-原材料-海鲜', '140303', 156, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13480, 2624, '陈林报销9.11-17号日常报销-面条', 10572, '140304-原材料-面条', '140304', 720, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13481, 2624, '陈林报销9.11-17号日常报销-设备', 10597, '560117-销售费用-设备-小器具', '560117', 980, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13482, 2624, '陈林报销9.11-17号日常报销-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 22.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13483, 2624, '陈林报销9.11-17号日常报销-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 16, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13484, 2624, '陈林报销9.11-17号日常报销-一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 41, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13485, 2624, '陈林报销9.11-17号日常报销-员工关怀', 10603, '560123-销售费用-员工关怀', '560123', 1934, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13486, 2624, '陈林报销9.11-17号日常报销-运费', 10510, '560111-销售费用-运输费', '560111', 646, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13487, 2624, '陈林报销9.11-17号日常报销-猪骨头', 10569, '140301-原材料-猪骨头', '140301', 220, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13488, 2624, '陈林报销9.11-17号日常报销', 10548, '100202-银行存款-农业银行', '100202', NULL, 5586.1, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13489, 2625, '11月进货', 10575, '140307-原材料-福州干货', '140307', 21716, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13490, 2625, '11月进货-退货', 10575, '140307-原材料-福州干货', '140307', NULL, 600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13491, 2625, '11月进货', 10561, '122104-其他应收款-总仓', '122104', NULL, 21116, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13492, 2626, '支付2月人员工资', 10580, '221101-应付职工薪酬-工资', '221101', 33591.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13493, 2626, '支付2月人员工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 33591.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13494, 2627, '支付全年广告费', 10514, '560115-销售费用-广告费', '560115', 2578.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13495, 2627, '支付全年广告费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2578.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13496, 2628, '11月单机会员充值', 10548, '100202-银行存款-农业银行', '100202', 2200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13497, 2628, '11月单机会员充值', 10579, '220302-预收账款-单机会员充值', '220302', NULL, 2200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13498, 2629, '4月店长报销备用金-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 174.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13499, 2629, '4月店长报销备用金-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 24, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13500, 2629, '4月店长报销备用金-低值易耗及一次性用品', 10598, '560119-销售费用-低值易耗品', '560119', 2043.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13501, 2629, '4月店长报销备用金-饮料', 10570, '140302-原材料-饮料', '140302', 246, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13502, 2629, '4月店长报销备用金-垃圾费', 10606, '560126-销售费用-垃圾费', '560126', 400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13503, 2629, '4月店长报销备用金-员工餐', 10608, '560128-销售费用-员工餐', '560128', 2130, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13504, 2629, '4月店长报销备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 1656.1, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13505, 2629, '4月店长报销备用金', 10559, '122102-其他应收款-备用金', '122102', NULL, 3361.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13506, 2630, '结转成本', 10496, '5401-主营业务成本', '5401', 5862.44, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13507, 2630, '结转成本', 10574, '140306-原材料-蔬菜', '140306', NULL, 985.05, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13508, 2630, '结转成本', 10572, '140304-原材料-面条', '140304', NULL, 2724, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13509, 2630, '结转成本', 10571, '140303-原材料-海鲜', '140303', NULL, 1149.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13510, 2630, '结转成本', 10569, '140301-原材料-猪骨头', '140301', NULL, 810, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13511, 2630, '结转成本', 10570, '140302-原材料-饮料', '140302', NULL, 194.19, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13512, 2631, '收到3月饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 3208.47, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13513, 2631, '收到3月饿了么收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 3208.47, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13514, 2632, '支付11月福州货款-冻货', 10575, '140307-原材料-福州干货', '140307', 30997.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13515, 2632, '支付11月福州货款-冻货', 10548, '100202-银行存款-农业银行', '100202', NULL, 30997.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13516, 2633, '支付10月工资', 10580, '221101-应付职工薪酬-工资', '221101', 23898, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13517, 2633, '支付10月工资', 10580, '221101-应付职工薪酬-工资', '221101', 834, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13518, 2633, '支付10月工资', 10637, '560213-管理费用-工资', '560213', 99, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13519, 2633, '支付10月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 23898, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13520, 2633, '支付10月工资', 10582, '224101-其他应付款-个人', '224101', NULL, 933, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13521, 2634, '农业银行9月结息', 10548, '100202-银行存款-农业银行', '100202', 14.41, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13522, 2634, '农业银行9月结息', 10530, '560301-财务费用-利息费用', '560301', -14.41, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13523, 2635, '摊销11月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16848.27, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13524, 2635, '摊销11月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16848.27, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13525, 2635, '摊销11月仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 166.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13526, 2635, '摊销11月仓库租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 166.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13527, 2636, '支付7-8月蔬菜费用', 10574, '140306-原材料-蔬菜', '140306', 3500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13528, 2636, '支付7-8月蔬菜费用', 10561, '122104-其他应收款-总仓', '122104', NULL, 3500, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13529, 2637, '摊销1月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16482, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13530, 2637, '摊销1月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16482, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13531, 2637, '摊销1月仓储租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 916.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13532, 2637, '摊销1月仓储租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13533, 2638, '支付12月税金', 10639, '560215-管理费用-税金', '560215', 1219.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13534, 2638, '支付12月税金', 10548, '100202-银行存款-农业银行', '100202', NULL, 1219.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13535, 2639, '收到会员消费返款', 10548, '100202-银行存款-农业银行', '100202', 12373.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13536, 2639, '收到会员消费返款', 10566, '122109-其他应收款-会员户', '122109', NULL, 12373.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13537, 2640, '慈溪店购入原材料', 10575, '140307-原材料-福州干货', '140307', 32525, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13538, 2640, '慈溪店购入原材料', 10561, '122104-其他应收款-总仓', '122104', NULL, 32525, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13539, 2641, '第2期  结转损益', 10488, '5001-主营业务收入', '5001', 150561.48, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13540, 2641, '第2期  结转损益', 10592, '530105-营业外收入-其他', '530105', 654.44, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13541, 2641, '第2期  结转损益', 10475, '3103-本年利润', '3103', NULL, 23905.84, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13542, 2641, '第2期  结转损益', 10496, '5401-主营业务成本', '5401', NULL, 50470.59, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13543, 2641, '第2期  结转损益', 10502, '560103-销售费用-修理费', '560103', NULL, 175, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13544, 2641, '第2期  结转损益', 10595, '56010403-销售费用-办公费-桶装水', '56010403', NULL, 16, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13545, 2641, '第2期  结转损益', 10596, '56010404-销售费用-办公费-办公用品', '56010404', NULL, 162, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13546, 2641, '第2期  结转损益', 10510, '560111-销售费用-运输费', '560111', NULL, 165, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13547, 2641, '第2期  结转损益', 10597, '560117-销售费用-设备-小器具', '560117', NULL, 1050, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13548, 2641, '第2期  结转损益', 10598, '560119-销售费用-低值易耗品', '560119', NULL, 148.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13549, 2641, '第2期  结转损益', 10600, '56012002-销售费用-其他-杂项', '56012002', NULL, 24.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13550, 2641, '第2期  结转损益', 10601, '560121-销售费用-厨房原材料-调料', '560121', NULL, 345.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13551, 2641, '第2期  结转损益', 10602, '560122-销售费用-一次性用品', '560122', NULL, 621.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13552, 2641, '第2期  结转损益', 10603, '560123-销售费用-员工关怀', '560123', NULL, 1344.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13553, 2641, '第2期  结转损益', 10604, '560124-销售费用-营业折扣', '560124', NULL, 148, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13554, 2641, '第2期  结转损益', 10606, '560126-销售费用-垃圾费', '560126', NULL, 400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13555, 2641, '第2期  结转损益', 10608, '560128-销售费用-员工餐', '560128', NULL, 5199, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13556, 2641, '第2期  结转损益', 10521, '560205-管理费用-水电费', '560205', NULL, 14873.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13557, 2641, '第2期  结转损益', 10618, '56020801-管理费用-摊销费-房租', '56020801', NULL, 16482, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13558, 2641, '第2期  结转损益', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13559, 2641, '第2期  结转损益', 10637, '560213-管理费用-工资', '560213', NULL, 33591.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13560, 2641, '第2期  结转损益', 10638, '560214-管理费用-提成', '560214', NULL, 996, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13561, 2641, '第2期  结转损益', 10531, '560302-财务费用-手续费', '560302', NULL, 179.32, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13562, 2642, '福州干货盘盈', 10575, '140307-原材料-福州干货', '140307', 255, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13563, 2642, '福州干货盘盈', 10420, '1901-待处理财产损溢', '1901', NULL, 255, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13564, 2643, '收到1月份支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 17297.83, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13565, 2643, '收到1月份支付宝收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 17297.83, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13566, 2644, '采购棒棒糖', 10604, '560124-销售费用-营业折扣', '560124', 1071, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13567, 2644, '采购棒棒糖', 10548, '100202-银行存款-农业银行', '100202', NULL, 1071, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13568, 2645, '利润分红（章，费用，10%）', 10481, '310405-利润分配-应付利润', '310405', 1611.25, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13569, 2645, '利润分红（章永刚）', 10481, '310405-利润分配-应付利润', '310405', 5800.51, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13570, 2645, '利润分红（夏克伟）', 10481, '310405-利润分配-应付利润', '310405', 5800.51, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13571, 2645, '利润分红（张竹挺）', 10481, '310405-利润分配-应付利润', '310405', 1450.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13572, 2645, '利润分红（陈林）', 10481, '310405-利润分配-应付利润', '310405', 1450.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13573, 2645, '利润分红', 10548, '100202-银行存款-农业银行', '100202', NULL, 16112.53, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13574, 2645, '结转利润分红', 10482, '310406-利润分配-未分配利润', '310406', 16112.53, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13575, 2645, '结转利润分红', 10481, '310405-利润分配-应付利润', '310405', NULL, 16112.53, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13576, 2646, '支付福州考察费餐费', 10501, '560102-销售费用-业务招待费', '560102', 772, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13577, 2646, '支付福州考察费餐费', 10548, '100202-银行存款-农业银行', '100202', NULL, 772, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13578, 2647, '计提10月工资', 10637, '560213-管理费用-工资', '560213', 24732, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13579, 2647, '计提10月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 24732, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13580, 2648, '支付6月员工餐', 10584, '224104-其他应付款-月结款', '224104', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13581, 2648, '支付6月员工餐', 10548, '100202-银行存款-农业银行', '100202', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13582, 2648, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13583, 2648, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13584, 2649, '9月结息', 10548, '100202-银行存款-农业银行', '100202', 58.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13585, 2649, '9月结息', 10530, '560301-财务费用-利息费用', '560301', -58.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13586, 2650, '结转成本', 10496, '5401-主营业务成本', '5401', 51545.39, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13587, 2650, '结转成本', 10569, '140301-原材料-猪骨头', '140301', NULL, 840, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13588, 2650, '结转成本', 10570, '140302-原材料-饮料', '140302', NULL, 431.77, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13589, 2650, '结转成本', 10574, '140306-原材料-蔬菜', '140306', NULL, 2260, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13590, 2650, '结转成本', 10572, '140304-原材料-面条', '140304', NULL, 2310, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13591, 2650, '结转成本', 10575, '140307-原材料-福州干货', '140307', NULL, 45703.62, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13592, 2651, '支付购买年货', 10600, '56012002-销售费用-其他-杂项', '56012002', 2140, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13593, 2651, '支付购买年货', 10548, '100202-银行存款-农业银行', '100202', NULL, 2140, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13594, 2652, '11月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 34780, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13595, 2652, '11月收入-微信', 10548, '100202-银行存款-农业银行', '100202', 25139.86, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13596, 2652, '11月收入-支付宝', 10548, '100202-银行存款-农业银行', '100202', 60605.49, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13597, 2652, '11月收入-美团', 10548, '100202-银行存款-农业银行', '100202', 11019.61, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13598, 2652, '11月收入-饿了吗', 10548, '100202-银行存款-农业银行', '100202', 5349.07, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13599, 2652, '11月收入-礼券', 10605, '560125-销售费用-礼券', '560125', 56, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13600, 2652, '11月收入-营业折扣', 10604, '560124-销售费用-营业折扣', '560124', 738, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13601, 2652, '11月收入-微信会员消费', 10561, '122104-其他应收款-总仓', '122104', 36903.57, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13602, 2652, '11月收入-微信会员消费-手续费', 10531, '560302-财务费用-手续费', '560302', 221.42, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13603, 2652, '11月收入-单机会员消费', 10579, '220302-预收账款-单机会员充值', '220302', 3032, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13604, 2652, '11月收入', 10488, '5001-主营业务收入', '5001', NULL, 177845.02, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13605, 2653, '4月面条款', 10572, '140304-原材料-面条', '140304', 2724, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13606, 2653, '4月虾干', 10571, '140303-原材料-海鲜', '140303', 1149.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13607, 2653, '4月蔬菜', 10574, '140306-原材料-蔬菜', '140306', 1057.05, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13608, 2653, '4月猪骨头', 10569, '140301-原材料-猪骨头', '140301', 810, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13609, 2653, '4月月结款', 10584, '224104-其他应付款-月结款', '224104', NULL, 5740.25, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13610, 2654, '11月农行短信费用', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13611, 2654, '11月农行短信费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13612, 2655, '第11期  结转损益', 10488, '5001-主营业务收入', '5001', 177845.02, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13613, 2655, '第11期  结转损益', 10495, '530104-营业外收入-盘盈收益', '530104', 1268.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13614, 2655, '第11期  结转损益', 10475, '3103-本年利润', '3103', NULL, 24117.56, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13615, 2655, '第11期  结转损益', 10496, '5401-主营业务成本', '5401', NULL, 60061.68, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13616, 2655, '第11期  结转损益', 10502, '560103-销售费用-修理费', '560103', NULL, 1400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13617, 2655, '第11期  结转损益', 10594, '56010402-销售费用-办公费-打印纸', '56010402', NULL, 128, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13618, 2655, '第11期  结转损益', 10595, '56010403-销售费用-办公费-桶装水', '56010403', NULL, 32, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13619, 2655, '第11期  结转损益', 10510, '560111-销售费用-运输费', '560111', NULL, 1992, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13620, 2655, '第11期  结转损益', 10514, '560115-销售费用-广告费', '560115', NULL, 727, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13621, 2655, '第11期  结转损益', 10598, '560119-销售费用-低值易耗品', '560119', NULL, 1330.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13622, 2655, '第11期  结转损益', 10600, '56012002-销售费用-其他-杂项', '56012002', NULL, 339.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13623, 2655, '第11期  结转损益', 10601, '560121-销售费用-厨房原材料-调料', '560121', NULL, 655.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13624, 2655, '第11期  结转损益', 10602, '560122-销售费用-一次性用品', '560122', NULL, 561.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13625, 2655, '第11期  结转损益', 10603, '560123-销售费用-员工关怀', '560123', NULL, 1119, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13626, 2655, '第11期  结转损益', 10604, '560124-销售费用-营业折扣', '560124', NULL, 738, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13627, 2655, '第11期  结转损益', 10605, '560125-销售费用-礼券', '560125', NULL, 56, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13628, 2655, '第11期  结转损益', 10606, '560126-销售费用-垃圾费', '560126', NULL, 400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13629, 2655, '第11期  结转损益', 10608, '560128-销售费用-员工餐', '560128', NULL, 4700, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13630, 2655, '第11期  结转损益', 10609, '560129-销售费用-经营期间购买的小设备', '560129', NULL, 417.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13631, 2655, '第11期  结转损益', 10521, '560205-管理费用-水电费', '560205', NULL, 11282.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13632, 2655, '第11期  结转损益', 10618, '56020801-管理费用-摊销费-房租', '56020801', NULL, 16848.27, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13633, 2655, '第11期  结转损益', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13634, 2655, '第11期  结转损益', 10637, '560213-管理费用-工资', '560213', NULL, 46830.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13635, 2655, '第11期  结转损益', 10638, '560214-管理费用-提成', '560214', NULL, 1516.72, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13636, 2655, '第11期  结转损益', 10639, '560215-管理费用-税金', '560215', NULL, 1219.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13637, 2655, '第11期  结转损益', 10640, '560216-管理费用-租金', '560216', NULL, 1500, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13638, 2655, '第11期  结转损益', 10531, '560302-财务费用-手续费', '560302', NULL, 223.42, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (13639, 2656, '支付章总一点点房租', 10489, '5051-其他业务收入', '5051', 39454.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13640, 2656, '支付章总一点点房租', 10548, '100202-银行存款-农业银行', '100202', NULL, 39454.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13641, 2657, '收到10月支付宝', 10548, '100202-银行存款-农业银行', '100202', 19168, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13642, 2657, '收到10月支付宝', 10562, '122105-其他应收款-待入账', '122105', NULL, 19062, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13643, 2657, '收到10月支付宝', 10488, '5001-主营业务收入', '5001', NULL, 106, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13644, 2658, '支付11月备用金报销-11.27-11.30', 10582, '224101-其他应付款-个人', '224101', 747.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13645, 2658, '支付11月备用金报销-11.27-11.30', 10548, '100202-银行存款-农业银行', '100202', NULL, 747.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13646, 2659, '收到7-11月扣除垫付费用后的消费反款余额', 10548, '100202-银行存款-农业银行', '100202', 382.57, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13647, 2659, '收到7-11月扣除垫付费用后的消费反款余额', 10561, '122104-其他应收款-总仓', '122104', NULL, 382.57, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13648, 2660, '支付10-12月税金-国税', 10462, '222126-应交税费-税金', '222126', 392.34, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13649, 2660, '支付10-12月税金-国税', 10548, '100202-银行存款-农业银行', '100202', NULL, 392.34, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13650, 2661, '计提1月份工资', 10637, '560213-管理费用-工资', '560213', 27242, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13651, 2661, '计提1月份工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 27242, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13652, 2662, '计提1月人员工资', 10637, '560213-管理费用-工资', '560213', 44427.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13653, 2662, '计提1月人员工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 44427.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13654, 2663, '支付董良峰1月备用金', 10582, '224101-其他应付款-个人', '224101', 2715.97, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13655, 2663, '支付董良峰1月备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 2715.97, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13656, 2664, '收到1月会员消费返款', 10548, '100202-银行存款-农业银行', '100202', 10975.52, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13657, 2664, '收到1月会员消费返款', 10566, '122109-其他应收款-会员户', '122109', NULL, 10975.52, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13658, 2665, '9月总仓进货', 10575, '140307-原材料-福州干货', '140307', 53268, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13659, 2665, '9月总仓进货', 10561, '122104-其他应收款-总仓', '122104', NULL, 53268, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13660, 2666, '支付6月员工工资', 10580, '221101-应付职工薪酬-工资', '221101', 22200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13661, 2666, '支付6月员工工资补发', 10580, '221101-应付职工薪酬-工资', '221101', 500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13662, 2666, '支付6月员工工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 22700, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13663, 2667, '计提9月人员工资', 10637, '560213-管理费用-工资', '560213', 47924.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13664, 2667, '计提9月人员工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 47924.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13665, 2667, '计提9月人员提成', 10638, '560214-管理费用-提成', '560214', 1738, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13666, 2667, '计提9月人员提成', 10581, '221102-应付职工薪酬-提成', '221102', NULL, 1738, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13667, 2668, '支付短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13668, 2668, '支付短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13669, 2669, '结转4月福州成本', 10496, '5401-主营业务成本', '5401', 42922.94, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13670, 2669, '结转4月福州成本', 10575, '140307-原材料-福州干货', '140307', NULL, 42922.94, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13671, 2670, '支付开门红包', 10603, '560123-销售费用-员工关怀', '560123', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13672, 2670, '支付开门红包', 10548, '100202-银行存款-农业银行', '100202', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13673, 2671, '10月余姚借款归还', 10548, '100202-银行存款-农业银行', '100202', 20000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13674, 2671, '10月余姚借款归还', 10560, '122103-其他应收款-余姚店', '122103', NULL, 20000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13675, 2672, '11月员工餐', 10608, '560128-销售费用-员工餐', '560128', 4700, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13676, 2672, '11月员工餐', 10582, '224101-其他应付款-个人', '224101', NULL, 4700, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13677, 2673, '支付10月电费', 10521, '560205-管理费用-水电费', '560205', 5107.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13678, 2673, '支付10月电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 5107.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13679, 2674, '支付7月电费', 10521, '560205-管理费用-水电费', '560205', 7159.04, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13680, 2674, '支付7月电费', 10561, '122104-其他应收款-总仓', '122104', NULL, 7159.04, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13681, 2675, '支付团建分摊费用', 10603, '560123-销售费用-员工关怀', '560123', 460, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13682, 2675, '支付团建分摊费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 460, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13683, 2675, '支付团建路费', 10613, '560133-销售费用-交通费', '560133', 347, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13684, 2675, '支付团建路费', 10548, '100202-银行存款-农业银行', '100202', NULL, 347, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13685, 2676, '支付圣诞节饼干费用', 10403, '1405-库存商品', '1405', 690, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13686, 2676, '支付圣诞节饼干费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 690, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13687, 2676, '结转库存商品', 10496, '5401-主营业务成本', '5401', 690, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13688, 2676, '结转库存商品', 10403, '1405-库存商品', '1405', NULL, 690, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13689, 2677, '支付11月水电', 10521, '560205-管理费用-水电费', '560205', 11078.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13690, 2677, '支付11月水电', 10548, '100202-银行存款-农业银行', '100202', NULL, 11078.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13691, 2678, '摊销1月份房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 4898.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13692, 2678, '摊销1月份房租', 10549, '112301-预付账款-房租', '112301', NULL, 4898.13, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13693, 2679, '1月面条款月结', 10572, '140304-原材料-面条', '140304', 3075, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13694, 2679, '1月海鲜款月结', 10571, '140303-原材料-海鲜', '140303', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13695, 2679, '1月蔬菜款月结', 10574, '140306-原材料-蔬菜', '140306', 2182.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13696, 2679, '1月员工餐款月结', 10608, '560128-销售费用-员工餐', '560128', 3849, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13697, 2679, '1月月结款', 10582, '224101-其他应付款-个人', '224101', NULL, 10406.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13698, 2680, '支付仓库租金（2018.7-2019.7）', 10550, '112302-预付账款-仓库租金', '112302', 2000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13699, 2680, '支付仓库租金（2018.7-2019.7）', 10548, '100202-银行存款-农业银行', '100202', NULL, 2000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13700, 2681, '支付3月餐费（未报销备用金）', 10582, '224101-其他应付款-个人', '224101', 1482, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13701, 2681, '支付3月餐费（未报销备用金）', 10548, '100202-银行存款-农业银行', '100202', NULL, 1482, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13702, 2682, '收到2.1-2.26现金收入', 10548, '100202-银行存款-农业银行', '100202', 4612, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13703, 2682, '2.27-2.28现金收入', 10562, '122105-其他应收款-待入账', '122105', 324, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13704, 2682, '2月现金收入', 10488, '5001-主营业务收入', '5001', NULL, 4936, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13705, 2682, '收到2.1-2.28收钱吧-微信', 10548, '100202-银行存款-农业银行', '100202', 18276.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13706, 2682, '收到2.1-2.28收钱吧-支付宝', 10562, '122105-其他应收款-待入账', '122105', 12118.03, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13707, 2682, '收到2.1-2.28收钱吧收入', 10531, '560302-财务费用-手续费', '560302', 109.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13708, 2682, '收到2.1-2.28收钱吧收入', 10488, '5001-主营业务收入', '5001', NULL, 30504.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13709, 2682, '收到2.1-2.28美团外卖收入', 10548, '100202-银行存款-农业银行', '100202', 11744.16, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13710, 2682, '收到2.1-2.27美团团购收入', 10548, '100202-银行存款-农业银行', '100202', 3162.56, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13711, 2682, '收到2.28美团团购收入', 10562, '122105-其他应收款-待入账', '122105', 152.91, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13712, 2682, '收到2.1-2.28美团收入', 10488, '5001-主营业务收入', '5001', NULL, 15059.63, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13713, 2682, '2月饿了么收入', 10562, '122105-其他应收款-待入账', '122105', 5673.56, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13714, 2682, '2月饿了么收入', 10488, '5001-主营业务收入', '5001', NULL, 5673.56, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13715, 2682, '2月会员消费收入', 10566, '122109-其他应收款-会员户', '122109', 7669.38, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13716, 2682, '2月会员消费收入', 10531, '560302-财务费用-手续费', '560302', 29.14, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13717, 2682, '2月会员消费收入', 10488, '5001-主营业务收入', '5001', NULL, 7698.52, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13718, 2682, '2月优免折扣', 10604, '560124-销售费用-营业折扣', '560124', 6875.07, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13719, 2682, '2月优免折扣', 10488, '5001-主营业务收入', '5001', NULL, 6875.07, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13720, 2682, '2月报损', 10604, '560124-销售费用-营业折扣', '560124', 6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13721, 2682, '2月报损', 10488, '5001-主营业务收入', '5001', NULL, 6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13722, 2683, '支付6月备用金报销款', 10559, '122102-其他应收款-备用金', '122102', 1837.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13723, 2683, '支付6月备用金报销款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1837.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13724, 2683, '7.9日凤爪款', 10576, '140308-原材料-凤爪', '140308', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13725, 2683, '7.9日凤爪款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13726, 2683, '公众号认证费', 10514, '560115-销售费用-广告费', '560115', 300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13727, 2683, '公众号认证费', 10548, '100202-银行存款-农业银行', '100202', NULL, 300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13728, 2684, '摊销9月租金', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16848.27, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13729, 2684, '摊销9月租金', 10549, '112301-预付账款-房租', '112301', NULL, 16848.27, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13730, 2684, '摊销9月仓储租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 916.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13731, 2684, '摊销9月仓储租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13732, 2685, '董店长报销备用金-办公用品', 10596, '56010404-销售费用-办公费-办公用品', '56010404', 162, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13733, 2685, '董店长报销备用金-低值易耗', 10598, '560119-销售费用-低值易耗品', '560119', 148.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13734, 2685, '董店长报销备用金-骨头', 10569, '140301-原材料-猪骨头', '140301', 780, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13735, 2685, '董店长报销备用金-海鲜', 10571, '140303-原材料-海鲜', '140303', 7.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13736, 2685, '董店长报销备用金-交通费', 10600, '56012002-销售费用-其他-杂项', '56012002', 24.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13737, 2685, '董店长报销备用金-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 345.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13738, 2685, '董店长报销备用金-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 16, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13739, 2685, '董店长报销备用金-维修费', 10502, '560103-销售费用-修理费', '560103', 175, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13740, 2685, '董店长报销备用金-小器具', 10597, '560117-销售费用-设备-小器具', '560117', 1050, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13741, 2685, '董店长报销备用金-一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 621.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13742, 2685, '董店长报销备用金-员工餐（1-5）', 10608, '560128-销售费用-员工餐', '560128', 1197, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13743, 2685, '董店长报销备用金-员工关怀', 10603, '560123-销售费用-员工关怀', '560123', 1344.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13744, 2685, '董店长报销备用金-运费', 10510, '560111-销售费用-运输费', '560111', 165, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13745, 2685, '董店长报销备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 4884.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13746, 2685, '董店长报销备用金', 10582, '224101-其他应付款-个人', '224101', NULL, 1152.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13747, 2686, '支付总仓货款', 10561, '122104-其他应收款-总仓', '122104', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13748, 2686, '支付总仓货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13749, 2687, '支付总仓货款', 10561, '122104-其他应收款-总仓', '122104', 3844.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13750, 2687, '支付总仓货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 3844.1, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13751, 2688, '计提4月工资', 10637, '560213-管理费用-工资', '560213', 26047, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13752, 2688, '计提4月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 26047, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13753, 2689, '支付余姚2月支付宝款', 10560, '122103-其他应收款-余姚店', '122103', 12891.64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13754, 2689, '支付余姚2月支付宝款', 10548, '100202-银行存款-农业银行', '100202', NULL, 12891.64, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13755, 2690, '支付开业广告费用', 10514, '560115-销售费用-广告费', '560115', 727, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13756, 2690, '支付开业广告费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 727, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13757, 2691, '计提7月工资', 10637, '560213-管理费用-工资', '560213', 31920, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13758, 2691, '计提7月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 31920, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13759, 2692, '11月原材料盘盈', 10575, '140307-原材料-福州干货', '140307', 1548.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13760, 2692, '11月原材料盘盈', 10495, '530104-营业外收入-盘盈收益', '530104', NULL, 1548.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13761, 2693, '计提4月税金', 10639, '560215-管理费用-税金', '560215', 2569.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13762, 2693, '计提4月税金', 10462, '222126-应交税费-税金', '222126', NULL, 2569.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13763, 2694, '支付12月水费', 10521, '560205-管理费用-水电费', '560205', 231, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13764, 2694, '支付12月电费', 10521, '560205-管理费用-水电费', '560205', 5591.38, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13765, 2694, '支付12月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 294.52, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13766, 2694, '支付12月水电费', 10562, '122105-其他应收款-待入账', '122105', NULL, 5528.06, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13767, 2694, '支付12月水电费', 10562, '122105-其他应收款-待入账', '122105', NULL, 0.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13768, 2694, '支付12月水电费', 10642, '571112-营业外支出-其他', '571112', 0.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13769, 2695, '支付3月未报销备用金', 10582, '224101-其他应付款-个人', '224101', 2561.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13770, 2695, '支付3月未报销备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 2561.06, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13771, 2695, '支付3月未报销餐费', 10582, '224101-其他应付款-个人', '224101', 1569, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13772, 2695, '支付3月未报销餐费', 10548, '100202-银行存款-农业银行', '100202', NULL, 1569, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13773, 2696, '农业银行9月短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13774, 2696, '农业银行9月短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13775, 2697, '7月饿了么营业款', 10548, '100202-银行存款-农业银行', '100202', 2982.45, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13776, 2697, '7月饿了么营业款', 10562, '122105-其他应收款-待入账', '122105', NULL, 2982.45, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13777, 2697, '7月支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 16268.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13778, 2697, '7月支付宝收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 16268.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13779, 2698, '支付7-9月税金', 10462, '222126-应交税费-税金', '222126', 7708.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13780, 2698, '支付7-9月税金', 10548, '100202-银行存款-农业银行', '100202', NULL, 7708.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13781, 2699, '退款', 10604, '560124-销售费用-营业折扣', '560124', 12, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13782, 2699, '退款', 10548, '100202-银行存款-农业银行', '100202', NULL, 12, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13783, 2700, '4月收到总仓货款回冲后结余', 10561, '122104-其他应收款-总仓', '122104', 8566.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13784, 2700, '4月收到总仓货款回冲后结余', 10548, '100202-银行存款-农业银行', '100202', NULL, 8566.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13785, 2701, '支付福州冻货货款', 10575, '140307-原材料-福州干货', '140307', 51992.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13786, 2701, '支付福州冻货货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 51992.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13787, 2702, '收到任徐侠备用金退回', 10548, '100202-银行存款-农业银行', '100202', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13788, 2702, '收到任徐侠备用金退回', 10559, '122102-其他应收款-备用金', '122102', NULL, 5000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13789, 2703, '确认2月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 26381, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13790, 2703, '确认2月收入-微信', 10562, '122105-其他应收款-待入账', '122105', 22508, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13791, 2703, '确认2月收入-支付宝', 10562, '122105-其他应收款-待入账', '122105', 52875.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13792, 2703, '确认2月收入-支付宝（余姚）', 10562, '122105-其他应收款-待入账', '122105', 12891.64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13793, 2703, '确认2月收入-支付宝（余姚）', 10560, '122103-其他应收款-余姚店', '122103', NULL, 12891.64, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13794, 2703, '确认2月收入-美团', 10548, '100202-银行存款-农业银行', '100202', 8910.81, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13795, 2703, '确认2月收入-饿了么', 10562, '122105-其他应收款-待入账', '122105', 3929, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13796, 2703, '确认2月收入-单机会员充值消费', 10579, '220302-预收账款-单机会员充值', '220302', 3392, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13797, 2703, '确认2月收入-礼券', 10604, '560124-销售费用-营业折扣', '560124', 148, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13798, 2703, '确认2月收入-会员充值消费', 10561, '122104-其他应收款-总仓', '122104', 32239.68, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13799, 2703, '确认2月收入-会员充值消费手续费', 10531, '560302-财务费用-手续费', '560302', 177.32, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13800, 2703, '确认2月收入', 10488, '5001-主营业务收入', '5001', NULL, 150561.48, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13801, 2704, '12月期末盘点数据有误-补录冲减12月成本', 10575, '140307-原材料-福州干货', '140307', 1368, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13802, 2704, '12月期末盘点数据有误-补录冲减12月成本', 10496, '5401-主营业务成本', '5401', NULL, 1368, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13803, 2705, '贴纸收入', 10548, '100202-银行存款-农业银行', '100202', 80, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13804, 2705, '贴纸收入', 10592, '530105-营业外收入-其他', '530105', NULL, 80, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13805, 2706, '9月单机会员充值', 10548, '100202-银行存款-农业银行', '100202', 1900, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13806, 2706, '9月单机会员充值', 10579, '220302-预收账款-单机会员充值', '220302', NULL, 1900, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13807, 2707, '慈溪店原材料福州冻货调出至总仓（11月）', 10561, '122104-其他应收款-总仓', '122104', 29457.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13808, 2707, '慈溪店原材料福州冻货调出至总仓（11月）', 10575, '140307-原材料-福州干货', '140307', NULL, 29457.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13809, 2708, '确认9月收入-9.1-9.10日现金营业款', 10548, '100202-银行存款-农业银行', '100202', 1144.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13810, 2708, '确认9月收入-9.1-9.10日现金营业款', 10488, '5001-主营业务收入', '5001', NULL, 1144.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13811, 2708, '确认9月收入-9.1-9.10日微信收入', 10548, '100202-银行存款-农业银行', '100202', 7127.49, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13812, 2708, '确认9月收入-9.1-9.10日微信手续费', 10531, '560302-财务费用-手续费', '560302', 14.31, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13813, 2708, '确认9月收入-9.1-9.10日微信收入', 10488, '5001-主营业务收入', '5001', NULL, 7141.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13814, 2708, '确认9月收入-9.1-9.10日支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 5833.86, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13815, 2708, '确认9月收入-9.1-9.10日支付宝手续费', 10531, '560302-财务费用-手续费', '560302', 35.32, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13816, 2708, '确认9月收入-9.1-9.10日支付宝收入', 10488, '5001-主营业务收入', '5001', NULL, 5869.18, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13817, 2708, '确认9月收入-9.1-9.10日美团外卖收入', 10548, '100202-银行存款-农业银行', '100202', 3524.21, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13818, 2708, '确认9月收入-9.1-9.10日美团外卖折扣', 10604, '560124-销售费用-营业折扣', '560124', 1698.02, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13819, 2708, '确认9月收入-9.1-9.10日美团外卖收入', 10488, '5001-主营业务收入', '5001', NULL, 4895.92, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13820, 2708, '8月美团外卖收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 326.31, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13821, 2708, '确认9月收入-9.1-9.10日饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 882.02, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13822, 2708, '确认9月收入-9.1-9.10日饿了么折扣', 10604, '560124-销售费用-营业折扣', '560124', 348.01, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13823, 2708, '确认9月收入-9.1-9.10日饿了么收入', 10488, '5001-主营业务收入', '5001', NULL, 1230.03, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13824, 2708, '确认9月收入-9月会员消费', 10566, '122109-其他应收款-会员户', '122109', 2015.35, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13825, 2708, '确认9月收入-9月会员消费', 10488, '5001-主营业务收入', '5001', NULL, 2015.35, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13826, 2709, '收到10月会员返款', 10548, '100202-银行存款-农业银行', '100202', 12237.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13827, 2709, '收到10月会员返款', 10561, '122104-其他应收款-总仓', '122104', NULL, 12237.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13828, 2709, '收到10-11月部分饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 4280.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13829, 2709, '收到10月饿了么收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 3566.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13830, 2709, '收到11月部分饿了么收入', 10488, '5001-主营业务收入', '5001', NULL, 713.46, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13831, 2709, '11月手续费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13832, 2709, '11月手续费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13833, 2709, '支付11月不锈钢立架费用', 10597, '560117-销售费用-设备-小器具', '560117', 1200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13834, 2709, '支付11月不锈钢立架费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 1200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13835, 2710, '支付刘冬冬监控费用', 10597, '560117-销售费用-设备-小器具', '560117', 1400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13836, 2710, '支付刘冬冬监控费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 1400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13837, 2711, '支付购进福州货款', 10575, '140307-原材料-福州干货', '140307', 13336, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13838, 2711, '支付购进福州货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 13336, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13839, 2711, '支付购买花生瓶', 10597, '560117-销售费用-设备-小器具', '560117', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13840, 2711, '支付购买花生瓶', 10548, '100202-银行存款-农业银行', '100202', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13841, 2712, '任徐侠借备用金', 10559, '122102-其他应收款-备用金', '122102', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13842, 2712, '任徐侠借备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 5000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13843, 2713, '1月购入饮料', 10570, '140302-原材料-饮料', '140302', 475.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13844, 2713, '1月购入饮料', 10582, '224101-其他应付款-个人', '224101', NULL, 475.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13845, 2714, '支付11月海鲜款-虾干', 10582, '224101-其他应付款-个人', '224101', 800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13846, 2714, '支付11月海鲜款-虾干', 10548, '100202-银行存款-农业银行', '100202', NULL, 800, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13847, 2714, '支付11月面条款', 10582, '224101-其他应付款-个人', '224101', 3660, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13848, 2714, '支付11月员面条款', 10548, '100202-银行存款-农业银行', '100202', NULL, 3660, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13849, 2714, '支付11月员员工餐款', 10582, '224101-其他应付款-个人', '224101', 4700, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13850, 2714, '支付11月员员工餐款', 10548, '100202-银行存款-农业银行', '100202', NULL, 4700, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13851, 2714, '支付11月蔬菜款', 10582, '224101-其他应付款-个人', '224101', 2500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13852, 2714, '支付11月蔬菜款', 10548, '100202-银行存款-农业银行', '100202', NULL, 2500, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13853, 2714, '少付11月蔬菜款13.6', 10582, '224101-其他应付款-个人', '224101', 13.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13854, 2714, '少付11月蔬菜款13.6', 10592, '530105-营业外收入-其他', '530105', NULL, 13.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13855, 2715, '8月会员消费返款', 10548, '100202-银行存款-农业银行', '100202', 6232.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13856, 2715, '8月会员消费返款', 10566, '122109-其他应收款-会员户', '122109', NULL, 6232.13, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13857, 2716, '计提10月税金', 10639, '560215-管理费用-税金', '560215', 2569.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13858, 2716, '计提10月税金', 10462, '222126-应交税费-税金', '222126', NULL, 2569.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13859, 2717, '收到12月会员消费反款', 10548, '100202-银行存款-农业银行', '100202', 46240, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13860, 2717, '收到12月会员消费反款', 10561, '122104-其他应收款-总仓', '122104', NULL, 46240, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13861, 2718, '银行结息', 10548, '100202-银行存款-农业银行', '100202', 25.93, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13862, 2718, '银行结息', 10530, '560301-财务费用-利息费用', '560301', NULL, 25.93, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13863, 2719, '店长跟换', 10559, '122102-其他应收款-备用金', '122102', 2000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13864, 2719, '店长跟换', 10559, '122102-其他应收款-备用金', '122102', NULL, 2000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13865, 2719, '钱箱备用金', 10563, '122106-其他应收款-钱箱备用金', '122106', 2000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13866, 2719, '钱箱备用金', 10592, '530105-营业外收入-其他', '530105', NULL, 2000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13867, 2719, '钱箱备用金退回', 10548, '100202-银行存款-农业银行', '100202', 1000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13868, 2719, '钱箱备用金退回', 10563, '122106-其他应收款-钱箱备用金', '122106', NULL, 1000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13869, 2720, '确认收入-现金', 10548, '100202-银行存款-农业银行', '100202', 17727, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13870, 2720, '确认收入-小白盒', 10548, '100202-银行存款-农业银行', '100202', 73685, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13871, 2720, '确认收入-小白盒手续费', 10531, '560302-财务费用-手续费', '560302', 132.49, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13872, 2720, '确认收入-美团外卖', 10548, '100202-银行存款-农业银行', '100202', 13640.69, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13873, 2720, '确认收入-会员卡消费', 10561, '122104-其他应收款-总仓', '122104', 31467.02, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13874, 2720, '确认收入-会员卡消费', 10531, '560302-财务费用-手续费', '560302', 119.58, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13875, 2720, '确认收入-饿了么', 10548, '100202-银行存款-农业银行', '100202', 5472.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13876, 2720, '确认收入-券', 10604, '560124-销售费用-营业折扣', '560124', 395, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13877, 2720, '确认收入-报损', 10604, '560124-销售费用-营业折扣', '560124', 168, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13878, 2720, '确认收入-优免', 10604, '560124-销售费用-营业折扣', '560124', 8883, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13879, 2720, '确认收入', 10488, '5001-主营业务收入', '5001', NULL, 151690.18, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13880, 2721, '收到3月会员消费返款', 10548, '100202-银行存款-农业银行', '100202', 28575.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13881, 2721, '收到3月会员消费返款', 10561, '122104-其他应收款-总仓', '122104', NULL, 28575.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13882, 2722, '支付12月税金-地税', 10639, '560215-管理费用-税金', '560215', 1219.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13883, 2722, '支付12月税金-地税', 10548, '100202-银行存款-农业银行', '100202', NULL, 1219.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13884, 2723, '2月单机会员充值-现金', 10548, '100202-银行存款-农业银行', '100202', 1700, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13885, 2723, '2月单机会员充值-现金', 10579, '220302-预收账款-单机会员充值', '220302', NULL, 1700, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13886, 2724, '标签贴收入', 10548, '100202-银行存款-农业银行', '100202', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13887, 2724, '标签贴收入', 10592, '530105-营业外收入-其他', '530105', NULL, 200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13888, 2725, '1月结转成本', 10496, '5401-主营业务成本', '5401', 55541.52, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13889, 2725, '1月结转成本-猪骨头', 10569, '140301-原材料-猪骨头', '140301', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13890, 2725, '1月结转成本-饮料', 10570, '140302-原材料-饮料', '140302', NULL, 719.52, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13891, 2725, '1月结转成本-海鲜', 10571, '140303-原材料-海鲜', '140303', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13892, 2725, '1月结转成本-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 2199.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13893, 2725, '1月结转成本-面条', 10572, '140304-原材料-面条', '140304', NULL, 3075, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13894, 2725, '1月结转成本-福州干货', 10575, '140307-原材料-福州干货', '140307', NULL, 46947.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13895, 2726, '一点点6月水费', 10548, '100202-银行存款-农业银行', '100202', 7574.88, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13896, 2726, '一点点6月水费', 10548, '100202-银行存款-农业银行', '100202', NULL, 7574.88, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13897, 2726, '支付旧巷南6月水费', 10521, '560205-管理费用-水电费', '560205', 105, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13898, 2726, '支付旧巷南6月电费', 10521, '560205-管理费用-水电费', '560205', 6233.22, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13899, 2726, '支付旧巷南6月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 6338.22, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13900, 2727, '9月盘盈（单价变动导致）', 10420, '1901-待处理财产损溢', '1901', 255, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13901, 2727, '9月盘盈（单价变动导致）', 10402, '1404-材料成本差异', '1404', NULL, 255, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13902, 2728, '支付9月1-10号妙食林员工餐', 10608, '560128-销售费用-员工餐', '560128', 5390, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13903, 2728, '支付9月10-30号妙食林员工餐', 10582, '224101-其他应付款-个人', '224101', NULL, 3390, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13904, 2728, '支付9月1-10号妙食林员工餐', 10548, '100202-银行存款-农业银行', '100202', NULL, 2000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13905, 2729, '补发高温补贴', 10603, '560123-销售费用-员工关怀', '560123', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13906, 2729, '补发高温补贴', 10548, '100202-银行存款-农业银行', '100202', NULL, 200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13907, 2730, '支付4月1-7号员工餐', 10608, '560128-销售费用-员工餐', '560128', 467, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13908, 2730, '支付4月1-7号员工餐', 10548, '100202-银行存款-农业银行', '100202', NULL, 467, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13909, 2731, '支付店长报销备用金', 10559, '122102-其他应收款-备用金', '122102', 2854.36, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13910, 2731, '支付店长报销备用金', 10603, '560123-销售费用-员工关怀', '560123', -107, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13911, 2731, '支付店长报销备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 2747.36, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13912, 2732, '支付铁艺架子', 10615, '560135-销售费用-装修费', '560135', 2000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13913, 2732, '支付铁艺架子', 10548, '100202-银行存款-农业银行', '100202', NULL, 2000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13914, 2733, '支付8月水电', 10521, '560205-管理费用-水电费', '560205', 13729.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13915, 2733, '支付2017.10-12月租金', 10549, '112301-预付账款-房租', '112301', 50544.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13916, 2733, '支付2017.10-12月租金及8月水电', 10548, '100202-银行存款-农业银行', '100202', NULL, 64274.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13917, 2734, '陈林退回备用金款项', 10548, '100202-银行存款-农业银行', '100202', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13918, 2734, '陈林退回备用金款项', 10559, '122102-其他应收款-备用金', '122102', NULL, 5000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13919, 2735, '11月成本结转', 10496, '5401-主营业务成本', '5401', 60061.68, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13920, 2735, '11月成本结转-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 2174, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13921, 2735, '11月成本结转-骨头', 10569, '140301-原材料-猪骨头', '140301', NULL, 808, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13922, 2735, '11月成本结转-海鲜', 10571, '140303-原材料-海鲜', '140303', NULL, 1185, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13923, 2735, '11月成本结转-面条', 10572, '140304-原材料-面条', '140304', NULL, 3660, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13924, 2735, '11月成本结转-福州干货', 10575, '140307-原材料-福州干货', '140307', NULL, 51893.66, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13925, 2735, '11月成本结转-福州干货', 10570, '140302-原材料-饮料', '140302', NULL, 341.02, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13926, 2736, '1月总仓进货-福州干货', 10575, '140307-原材料-福州干货', '140307', 36458.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13927, 2736, '1月总仓进货-福州干货运费', 10561, '122104-其他应收款-总仓', '122104', NULL, 36458.1, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13928, 2737, '收到9月会员消费', 10548, '100202-银行存款-农业银行', '100202', 27658.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13929, 2737, '收到9月会员消费', 10561, '122104-其他应收款-总仓', '122104', NULL, 27658.06, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13930, 2738, '支付4月报销备用金款', 10559, '122102-其他应收款-备用金', '122102', 1221.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13931, 2738, '支付4月报销备用金款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1221.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13932, 2738, '支付4月员工餐', 10559, '122102-其他应收款-备用金', '122102', 2140, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13933, 2738, '支付4月员工餐', 10548, '100202-银行存款-农业银行', '100202', NULL, 2120, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13934, 2738, '营业外收入', 10592, '530105-营业外收入-其他', '530105', -20, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13935, 2739, '勺子收入', 10548, '100202-银行存款-农业银行', '100202', 20, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13936, 2739, '勺子收入', 10592, '530105-营业外收入-其他', '530105', NULL, 20, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13937, 2740, '支付装修尾款-朱洪平', 10582, '224101-其他应付款-个人', '224101', 11000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13938, 2740, '支付装修费加装修平顶', 10519, '560203-管理费用-修理费', '560203', 2000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13939, 2740, '支付装修费尾款及加装修平顶', 10548, '100202-银行存款-农业银行', '100202', NULL, 13000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13940, 2741, '计提5月工资', 10637, '560213-管理费用-工资', '560213', 25533, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13941, 2741, '计提5月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 25533, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13942, 2742, '4月20号总仓进货借款', 10561, '122104-其他应收款-总仓', '122104', 25000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13943, 2742, '4月20号总仓进货借款', 10548, '100202-银行存款-农业银行', '100202', NULL, 25000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13944, 2743, '9月原材料成本差异（单价变动）', 10575, '140307-原材料-福州干货', '140307', 107.79, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13945, 2743, '9月原材料成本差异（单价变动）', 10402, '1404-材料成本差异', '1404', NULL, 107.79, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13946, 2744, '2月购进面条', 10572, '140304-原材料-面条', '140304', 2685, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13947, 2744, '2月购进虾干', 10571, '140303-原材料-海鲜', '140303', 1200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13948, 2744, '2月购进蔬菜', 10574, '140306-原材料-蔬菜', '140306', 1738.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13949, 2744, '2月员工餐', 10608, '560128-销售费用-员工餐', '560128', 4002, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13950, 2744, '2月垃圾费', 10606, '560126-销售费用-垃圾费', '560126', 400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13951, 2744, '2月待付款项', 10582, '224101-其他应付款-个人', '224101', NULL, 10025.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13952, 2745, '支付12月备用金报销', 10582, '224101-其他应付款-个人', '224101', 2299.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13953, 2745, '支付12月备用金报销', 10548, '100202-银行存款-农业银行', '100202', NULL, 2299.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13954, 2746, '6月饿了么入账', 10548, '100202-银行存款-农业银行', '100202', 3220.34, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13955, 2746, '6月饿了么入账', 10562, '122105-其他应收款-待入账', '122105', NULL, 3220.34, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13956, 2746, '6月支付宝入账', 10548, '100202-银行存款-农业银行', '100202', 17047.15, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13957, 2746, '6月支付宝入账', 10562, '122105-其他应收款-待入账', '122105', NULL, 17047.15, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13958, 2746, '6月会员消费返款', 10548, '100202-银行存款-农业银行', '100202', 7508.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13959, 2746, '6月会员消费返款', 10566, '122109-其他应收款-会员户', '122109', NULL, 7508.06, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13960, 2747, '结转成本', 10496, '5401-主营业务成本', '5401', 32444.25, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13961, 2747, '结转成本', 10569, '140301-原材料-猪骨头', '140301', NULL, 947.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13962, 2747, '结转成本', 10572, '140304-原材料-面条', '140304', NULL, 1755, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13963, 2747, '结转成本', 10574, '140306-原材料-蔬菜', '140306', NULL, 1407.17, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13964, 2747, '结转成本', 10575, '140307-原材料-福州干货', '140307', NULL, 25774.48, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13965, 2747, '结转成本', 10576, '140308-原材料-凤爪', '140308', NULL, 2560, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13966, 2748, '支付2月蔬菜款', 10582, '224101-其他应付款-个人', '224101', 1738.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13967, 2748, '支付2月蔬菜款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1738.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13968, 2749, '支付美团推广费', 10514, '560115-销售费用-广告费', '560115', 3000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13969, 2749, '支付美团推广费', 10548, '100202-银行存款-农业银行', '100202', NULL, 3000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13970, 2750, '支付10月面条款', 10584, '224104-其他应付款-月结款', '224104', 3760.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13971, 2750, '支付10月面条款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1215, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13972, 2750, '支付10月员工餐', 10548, '100202-银行存款-农业银行', '100202', NULL, 1360, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13973, 2750, '支付10月蔬菜', 10548, '100202-银行存款-农业银行', '100202', NULL, 1185.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13974, 2751, '计提员工提成', 10638, '560214-管理费用-提成', '560214', 698, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13975, 2751, '计提员工提成', 10581, '221102-应付职工薪酬-提成', '221102', NULL, 698, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13976, 2752, '收到9月饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 7457.19, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13977, 2752, '收到9月饿了么收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 7457.19, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13978, 2752, '收到9月支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 30690.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13979, 2752, '收到9月支付宝收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 30690.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13980, 2753, '陈林报销9月1-10号日常费用-打印纸', 10594, '56010402-销售费用-办公费-打印纸', '56010402', 118, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13981, 2753, '陈林报销9月1-10号日常费用-低值易耗品', 10598, '560119-销售费用-低值易耗品', '560119', 324.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13982, 2753, '陈林报销9月1-10号日常费用-海鲜', 10571, '140303-原材料-海鲜', '140303', 126, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13983, 2753, '陈林报销9月1-10号日常费用-垃圾费', 10606, '560126-销售费用-垃圾费', '560126', 400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13984, 2753, '陈林报销-9月1-10号日常费用-面条', 10572, '140304-原材料-面条', '140304', 1287, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13985, 2753, '陈林报销-9月1-10号日常费用-其他', 10600, '56012002-销售费用-其他-杂项', '56012002', 244.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13986, 2753, '陈林报销-9月1-10号日常费用-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 57.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13987, 2753, '陈林报销-9月1-10号日常费用-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 137, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13988, 2753, '陈林报销-9月1-10号日常费用-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 48, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13989, 2753, '陈林报销-9月1-10号日常费用-一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 1197.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13990, 2753, '陈林报销-9月1-10号日常费用-燕燕住院费', 10603, '560123-销售费用-员工关怀', '560123', 3500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13991, 2753, '陈林报销-9月1-10号日常费用-运费', 10510, '560111-销售费用-运输费', '560111', 554, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13992, 2753, '陈林报销-9月1-10号日常费用-伍总住宿', 10501, '560102-销售费用-业务招待费', '560102', 253, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13993, 2753, '陈林报销-9月1-10号日常费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 8247.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13994, 2754, '确认10月收入-现金（1-17）', 10548, '100202-银行存款-农业银行', '100202', 7396, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13995, 2754, '确认10月收入-收钱吧微信（1-17）', 10548, '100202-银行存款-农业银行', '100202', 23568.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13996, 2754, '确认10月收入-收钱吧支付宝（1-17）', 10562, '122105-其他应收款-待入账', '122105', 19062, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13997, 2754, '确认10月收入-美团', 10548, '100202-银行存款-农业银行', '100202', 7014.01, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13998, 2754, '确认10月收入-饿了么', 10562, '122105-其他应收款-待入账', '122105', 3566.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (13999, 2754, '确认10月收入-喵街收入', 10562, '122105-其他应收款-待入账', '122105', 220, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14000, 2754, '确认10月收入-报损', 10604, '560124-销售费用-营业折扣', '560124', 146, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14001, 2754, '确认10月收入-优免折扣', 10604, '560124-销售费用-营业折扣', '560124', 5369.08, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14002, 2754, '确认10月收入-优惠券收入', 10548, '100202-银行存款-农业银行', '100202', 1588.19, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14003, 2754, '确认10月收入-会员消费', 10561, '122104-其他应收款-总仓', '122104', 12237.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14004, 2754, '确认10月收入-会员消费', 10531, '560302-财务费用-手续费', '560302', 46.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14005, 2754, '确认10月收入', 10488, '5001-主营业务收入', '5001', NULL, 80214.28, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14006, 2755, '计提11月员工提成（净利润的5%）', 10638, '560214-管理费用-提成', '560214', 1516.72, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14007, 2755, '计提11月员工提成（净利润的5%）', 10581, '221102-应付职工薪酬-提成', '221102', NULL, 1516.72, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14008, 2756, '装修押金退回', 10548, '100202-银行存款-农业银行', '100202', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14009, 2756, '装修押金退回', 10554, '12210101-其他应收款-押金-装修押金', '12210101', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14010, 2757, '退还备用金', 10548, '100202-银行存款-农业银行', '100202', 2000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14011, 2757, '退还备用金', 10559, '122102-其他应收款-备用金', '122102', NULL, 2000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14012, 2757, '退还钱箱备用金', 10548, '100202-银行存款-农业银行', '100202', 1000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14013, 2757, '退还钱箱备用金', 10563, '122106-其他应收款-钱箱备用金', '122106', NULL, 1000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14014, 2758, '收到店长退回备用金', 10548, '100202-银行存款-农业银行', '100202', 3000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14015, 2758, '收到店长退回备用金', 10559, '122102-其他应收款-备用金', '122102', NULL, 3000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14016, 2759, '9月收入-现金收入', 10548, '100202-银行存款-农业银行', '100202', 52886, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14017, 2759, '9月收入-微信收入', 10548, '100202-银行存款-农业银行', '100202', 31484, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14018, 2759, '9月收入-支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 72842.04, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14019, 2759, '9月收入-美团收入', 10548, '100202-银行存款-农业银行', '100202', 11583.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14020, 2759, '9月收入-饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 9625.34, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14021, 2759, '9月收入-礼券', 10605, '560125-销售费用-礼券', '560125', 224, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14022, 2759, '9月收入-单机会员消费', 10579, '220302-预收账款-单机会员充值', '220302', 3134, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14023, 2759, '9月收入-微信会员消费', 10561, '122104-其他应收款-总仓', '122104', 30819.08, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14024, 2759, '9月收入-微信会员消费-手续费', 10531, '560302-财务费用-手续费', '560302', 184.92, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14025, 2759, '9月收入', 10488, '5001-主营业务收入', '5001', NULL, 212782.88, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14026, 2760, '支付58同城招聘年费', 10607, '560127-销售费用-网络招聘费', '560127', 2800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14027, 2760, '支付58同城招聘年费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2800, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14028, 2761, '摊销5月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16665.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14029, 2761, '摊销5月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16665.13, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14030, 2761, '摊销5月仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 916.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14031, 2761, '摊销5月仓库租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14032, 2762, '摊销4月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16665.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14033, 2762, '摊销4月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16665.13, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14034, 2762, '摊销4月仓储租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 916.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14035, 2762, '摊销4月仓储租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14036, 2763, '支付慈溪店门店备用金-许田科', 10559, '122102-其他应收款-备用金', '122102', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14037, 2763, '支付慈溪店门店备用金-许田科', 10548, '100202-银行存款-农业银行', '100202', NULL, 5000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14038, 2764, '10月盘点出现错误-11月盘盈', 10575, '140307-原材料-福州干货', '140307', 1099.04, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14039, 2764, '10月盘点出现错误-11月盘盈', 10574, '140306-原材料-蔬菜', '140306', 831.73, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14040, 2764, '10月盘点出现错误-11月盘盈', 10592, '530105-营业外收入-其他', '530105', NULL, 1930.77, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14041, 2765, '确认7月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 4567, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14042, 2765, '确认7月收入-现金', 10488, '5001-主营业务收入', '5001', NULL, 3982, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14043, 2765, '6月现金入账', 10562, '122105-其他应收款-待入账', '122105', NULL, 585, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14044, 2765, '确认7月收入-微信', 10548, '100202-银行存款-农业银行', '100202', 21329.89, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14045, 2765, '确认7月收入-微信手续费', 10531, '560302-财务费用-手续费', '560302', 42.17, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14046, 2765, '确认7月收入-微信', 10488, '5001-主营业务收入', '5001', NULL, 21372.06, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14047, 2765, '确认7月收入-支付宝', 10562, '122105-其他应收款-待入账', '122105', 16268.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14048, 2765, '确认7月收入-支付宝手续费', 10531, '560302-财务费用-手续费', '560302', 98.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14049, 2765, '确认7月收入-支付宝', 10488, '5001-主营业务收入', '5001', NULL, 16366.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14050, 2765, '确认7月收入-美团外卖', 10548, '100202-银行存款-农业银行', '100202', 12022.75, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14051, 2765, '6月美团外卖入账', 10562, '122105-其他应收款-待入账', '122105', NULL, 804.71, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14052, 2765, '确认7月收入-美团外卖折扣', 10604, '560124-销售费用-营业折扣', '560124', 4960.04, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14053, 2765, '确认7月收入-美团外卖', 10488, '5001-主营业务收入', '5001', NULL, 16178.08, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14054, 2765, '确认7月收入-美团团购', 10548, '100202-银行存款-农业银行', '100202', 4086.63, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14055, 2765, '确认7月收入-美团团购手续费', 10531, '560302-财务费用-手续费', '560302', 191.81, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14056, 2765, '确认7月收入-美团团购', 10488, '5001-主营业务收入', '5001', NULL, 3393.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14057, 2765, '6月美团营业额', 10562, '122105-其他应收款-待入账', '122105', NULL, 884.94, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14058, 2765, '确认7月收入-饿了么', 10562, '122105-其他应收款-待入账', '122105', 2982.45, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14059, 2765, '确认7月收入-饿了么折扣', 10604, '560124-销售费用-营业折扣', '560124', 937.15, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14060, 2765, '确认7月收入-饿了么', 10488, '5001-主营业务收入', '5001', NULL, 3919.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14061, 2765, '确认7月收入-会员消费', 10566, '122109-其他应收款-会员户', '122109', 7708, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14062, 2765, '确认7月收入-会员消费手续费', 10531, '560302-财务费用-手续费', '560302', 29.29, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14063, 2765, '确认7月收入-会员消费', 10488, '5001-主营业务收入', '5001', NULL, 7737.29, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14064, 2765, '确认7月收入-优免折扣', 10604, '560124-销售费用-营业折扣', '560124', 2522.25, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14065, 2765, '确认7月收入-优免折扣', 10488, '5001-主营业务收入', '5001', NULL, 2522.25, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14066, 2766, '收到慈溪店2月会员充值消费金', 10548, '100202-银行存款-农业银行', '100202', 32239.68, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14067, 2766, '收到慈溪店2月会员充值消费金', 10561, '122104-其他应收款-总仓', '122104', NULL, 32239.68, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14068, 2767, '摊销2月房租租金', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16482, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14069, 2767, '摊销2月房租租金', 10549, '112301-预付账款-房租', '112301', NULL, 16482, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14070, 2767, '摊销2月仓储租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 916.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14071, 2767, '摊销2月仓储租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14072, 2768, '支付3月未报销备用金费用', 10582, '224101-其他应付款-个人', '224101', 999, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14073, 2768, '支付3月未报销备用金费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 999, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14074, 2769, '收到吴莹雯暂借款', 10548, '100202-银行存款-农业银行', '100202', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14075, 2769, '收到吴莹雯暂借款', 10567, '122110-其他应收款-个人', '122110', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14076, 2770, '第10期  结转损益', 10488, '5001-主营业务收入', '5001', 216935.23, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14077, 2770, '第10期  结转损益', 10495, '530104-营业外收入-盘盈收益', '530104', 2974.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14078, 2770, '第10期  结转损益', 10475, '3103-本年利润', '3103', NULL, 48547.49, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14079, 2770, '第10期  结转损益', 10496, '5401-主营业务成本', '5401', NULL, 67967.71, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14080, 2770, '第10期  结转损益', 10593, '56010401-销售费用-办公费-电话费', '56010401', NULL, 200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14081, 2770, '第10期  结转损益', 10594, '56010402-销售费用-办公费-打印纸', '56010402', NULL, 129, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14082, 2770, '第10期  结转损益', 10595, '56010403-销售费用-办公费-桶装水', '56010403', NULL, 64, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14083, 2770, '第10期  结转损益', 10510, '560111-销售费用-运输费', '560111', NULL, 1672, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14084, 2770, '第10期  结转损益', 10514, '560115-销售费用-广告费', '560115', NULL, 20, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14085, 2770, '第10期  结转损益', 10598, '560119-销售费用-低值易耗品', '560119', NULL, 1074.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14086, 2770, '第10期  结转损益', 10601, '560121-销售费用-厨房原材料-调料', '560121', NULL, 359, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14087, 2770, '第10期  结转损益', 10602, '560122-销售费用-一次性用品', '560122', NULL, 1149.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14088, 2770, '第10期  结转损益', 10603, '560123-销售费用-员工关怀', '560123', NULL, 2260, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14089, 2770, '第10期  结转损益', 10605, '560125-销售费用-礼券', '560125', NULL, 1336, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14090, 2770, '第10期  结转损益', 10606, '560126-销售费用-垃圾费', '560126', NULL, 400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14091, 2770, '第10期  结转损益', 10608, '560128-销售费用-员工餐', '560128', NULL, 4750, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14092, 2770, '第10期  结转损益', 10609, '560129-销售费用-经营期间购买的小设备', '560129', NULL, 3356, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14093, 2770, '第10期  结转损益', 10521, '560205-管理费用-水电费', '560205', NULL, 10932.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14094, 2770, '第10期  结转损益', 10618, '56020801-管理费用-摊销费-房租', '56020801', NULL, 16848.27, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14095, 2770, '第10期  结转损益', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14096, 2770, '第10期  结转损益', 10637, '560213-管理费用-工资', '560213', NULL, 53889.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14097, 2770, '第10期  结转损益', 10638, '560214-管理费用-提成', '560214', NULL, 2603.37, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14098, 2770, '第10期  结转损益', 10639, '560215-管理费用-税金', '560215', NULL, 1219.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14099, 2770, '第10期  结转损益', 10531, '560302-财务费用-手续费', '560302', NULL, 214.42, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'1');
INSERT INTO `fxy_financial_voucher_details` VALUES (14100, 2771, '支付11月面条款', 10572, '140304-原材料-面条', '140304', 3660, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14101, 2771, '支付11月面条款', 10582, '224101-其他应付款-个人', '224101', NULL, 3660, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14102, 2771, '支付11月海鲜款', 10571, '140303-原材料-海鲜', '140303', 1185, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14103, 2771, '支付11月海鲜款', 10582, '224101-其他应付款-个人', '224101', NULL, 1185, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14104, 2771, '支付11月蔬菜款', 10574, '140306-原材料-蔬菜', '140306', 2128.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14105, 2771, '支付11月蔬菜款', 10582, '224101-其他应付款-个人', '224101', NULL, 2128.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14106, 2772, '10月材料成本差异', 10402, '1404-材料成本差异', '1404', 14, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14107, 2772, '10月材料成本差异', 10575, '140307-原材料-福州干货', '140307', NULL, 14, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14108, 2773, '3月库存盘点错误调整', 10575, '140307-原材料-福州干货', '140307', 4534.47, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14109, 2773, '3月库存盘点错误调整', 10402, '1404-材料成本差异', '1404', NULL, 4534.47, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14110, 2774, '支付3月水', 10521, '560205-管理费用-水电费', '560205', 273, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14111, 2774, '支付3月电', 10521, '560205-管理费用-水电费', '560205', 9408, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14112, 2774, '支付3月电', 10548, '100202-银行存款-农业银行', '100202', NULL, 9681, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14113, 2775, '支付6月工资', 10580, '221101-应付职工薪酬-工资', '221101', 37582, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14114, 2775, '支付6月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 37582, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14115, 2776, '支付7月水费', 10521, '560205-管理费用-水电费', '560205', 266, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14116, 2776, '支付7月电费', 10521, '560205-管理费用-水电费', '560205', 6200.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14117, 2776, '支付7月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 6466.06, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14118, 2777, '计提5月税金', 10639, '560215-管理费用-税金', '560215', 2569.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14119, 2777, '计提5月税金', 10462, '222126-应交税费-税金', '222126', NULL, 2569.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14120, 2778, '调整店长备用金挂账', 10559, '122102-其他应收款-备用金', '122102', 2862.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14121, 2778, '调整店长备用金挂账', 10559, '122102-其他应收款-备用金', '122102', NULL, 2862.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14122, 2778, '调整店长备用金挂账', 10559, '122102-其他应收款-备用金', '122102', 2000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14123, 2778, '调整店长备用金挂账', 10559, '122102-其他应收款-备用金', '122102', NULL, 2000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14124, 2779, '支付12月员工餐费用', 10582, '224101-其他应付款-个人', '224101', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14125, 2779, '支付12月饮料', 10582, '224101-其他应付款-个人', '224101', 430, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14126, 2779, '支付12月虾干', 10582, '224101-其他应付款-个人', '224101', 800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14127, 2779, '支付12月蔬菜花蛤', 10582, '224101-其他应付款-个人', '224101', 2000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14128, 2779, '支付12月面条', 10582, '224101-其他应付款-个人', '224101', 3330, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14129, 2779, '支付12月月结款', 10548, '100202-银行存款-农业银行', '100202', NULL, 11560, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14130, 2780, '确认12月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 30558, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14131, 2780, '确认12月收入-美团', 10548, '100202-银行存款-农业银行', '100202', 9907.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14132, 2780, '确认12月收入-微信', 10548, '100202-银行存款-农业银行', '100202', 19129.87, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14133, 2780, '确认12月收入-饿了么', 10548, '100202-银行存款-农业银行', '100202', 4900.86, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14134, 2780, '确认12月收入-支付宝', 10548, '100202-银行存款-农业银行', '100202', 60570.56, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14135, 2780, '确认12月收入-微信会员消费', 10561, '122104-其他应收款-总仓', '122104', 46240, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14136, 2780, '确认12月收入-微信会员消费-手续费', 10531, '560302-财务费用-手续费', '560302', 277.44, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14137, 2780, '确认12月收入-单机会员消费', 10579, '220302-预收账款-单机会员充值', '220302', 2274, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14138, 2780, '确认12月收入-礼券', 10604, '560124-销售费用-营业折扣', '560124', 589.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14139, 2780, '确认12月收入', 10488, '5001-主营业务收入', '5001', NULL, 174447.53, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14140, 2781, '12月自购蔬菜筒骨', 10574, '140306-原材料-蔬菜', '140306', 1080.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14141, 2781, '12月自购面条', 10572, '140304-原材料-面条', '140304', 2020, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14142, 2781, '12月员工餐', 10608, '560128-销售费用-员工餐', '560128', 830, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14143, 2781, '12月月结', 10584, '224104-其他应付款-月结款', '224104', NULL, 3930.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14144, 2782, '支付面条款', 10582, '224101-其他应付款-个人', '224101', 2778, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14145, 2782, '支付3月虾干', 10582, '224101-其他应付款-个人', '224101', 1000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14146, 2782, '支付3月蔬菜', 10582, '224101-其他应付款-个人', '224101', 1418.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14147, 2782, '支付3月未付款', 10548, '100202-银行存款-农业银行', '100202', NULL, 5196.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14148, 2783, '支付2月短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14149, 2783, '支付2月短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14150, 2784, '7月成本结转', 10496, '5401-主营业务成本', '5401', 23517.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14151, 2784, '7月成本结转-总部', 10575, '140307-原材料-福州干货', '140307', NULL, 19111.72, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14152, 2784, '7月成本结转-凤爪', 10576, '140308-原材料-凤爪', '140308', NULL, 1080, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14153, 2784, '7月成本结转-自采购', 10577, '140309-原材料-自采购', '140309', NULL, 386.33, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14154, 2784, '7月成本结转-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 1244.25, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14155, 2784, '7月成本结转-面条', 10572, '140304-原材料-面条', '140304', NULL, 1695, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14156, 2785, '预付总仓货款', 10561, '122104-其他应收款-总仓', '122104', 30000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14157, 2785, '预付总仓货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 30000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14158, 2786, '确认3月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 22506.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14159, 2786, '确认3月收入-美团收入', 10548, '100202-银行存款-农业银行', '100202', 58749.68, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14160, 2786, '确认3月收入-支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 13394.64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14161, 2786, '确认3月收入-饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 3056.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14162, 2786, '确认3月收入-微信收入', 10548, '100202-银行存款-农业银行', '100202', 5012.48, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14163, 2786, '确认3月收入-会员卡消费', 10561, '122104-其他应收款-总仓', '122104', 28575.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14164, 2786, '确认3月收入-会员卡消费手续费', 10531, '560302-财务费用-手续费', '560302', 157.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14165, 2786, '确认3月收入-单机会员消费', 10579, '220302-预收账款-单机会员充值', '220302', 263, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14166, 2786, '确认3月收入-礼券', 10604, '560124-销售费用-营业折扣', '560124', 750, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14167, 2786, '确认3月收入', 10488, '5001-主营业务收入', '5001', NULL, 132465.63, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14168, 2787, '11月员工餐费用', 10584, '224104-其他应付款-月结款', '224104', 2000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14169, 2787, '11月员工餐费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 2000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14170, 2787, '11月面条月结', 10584, '224104-其他应付款-月结款', '224104', 1755, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14171, 2787, '11月面条月结', 10548, '100202-银行存款-农业银行', '100202', NULL, 1755, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14172, 2787, '11月备用金报销', 10559, '122102-其他应收款-备用金', '122102', 3073.77, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14173, 2787, '11月备用金报销', 10548, '100202-银行存款-农业银行', '100202', NULL, 3073.77, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14174, 2787, '11月蔬菜、筒骨等', 10584, '224104-其他应付款-月结款', '224104', 1392.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14175, 2787, '11月蔬菜、筒骨等', 10548, '100202-银行存款-农业银行', '100202', NULL, 1392.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14176, 2787, '支付11月水费', 10521, '560205-管理费用-水电费', '560205', 469, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14177, 2787, '支付11月电费', 10521, '560205-管理费用-水电费', '560205', 5058.86, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14178, 2787, '支付11月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 5527.86, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14179, 2787, '支付11月工资', 10580, '221101-应付职工薪酬-工资', '221101', 25681, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14180, 2787, '支付11月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 25681, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14181, 2787, '支付12月凤爪', 10576, '140308-原材料-凤爪', '140308', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14182, 2787, '支付12月凤爪', 10548, '100202-银行存款-农业银行', '100202', NULL, 1600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14183, 2788, '7月摊销-房租物业费', 10618, '56020801-管理费用-摊销费-房租', '56020801', 10310.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14184, 2788, '7月摊销-房租物业费', 10549, '112301-预付账款-房租', '112301', NULL, 10310.13, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14185, 2788, '7月摊销-仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 166.63, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14186, 2788, '7月摊销-仓库租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 166.63, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14187, 2789, '代付一点点7月水电费', 10548, '100202-银行存款-农业银行', '100202', 8138.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14188, 2789, '代付一点点7月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 8138.1, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14189, 2790, '10月饮料-材料成本差异', 10402, '1404-材料成本差异', '1404', 2.32, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14190, 2790, '10月饮料-材料成本差异', 10570, '140302-原材料-饮料', '140302', NULL, 2.32, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14191, 2791, '变卖收银机', 10548, '100202-银行存款-农业银行', '100202', 2500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14192, 2791, '变卖收银机', 10489, '5051-其他业务收入', '5051', NULL, 2500, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14193, 2792, '一点点水电费', 10548, '100202-银行存款-农业银行', '100202', 8295.97, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14194, 2792, '一点点水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 8295.97, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14195, 2793, '支付8月备用金报销', 10559, '122102-其他应收款-备用金', '122102', 6692.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14196, 2793, '支付8月备用金报销', 10548, '100202-银行存款-农业银行', '100202', NULL, 6692.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14197, 2794, '5月面条', 10572, '140304-原材料-面条', '140304', 2310, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14198, 2794, '5月龙骨', 10569, '140301-原材料-猪骨头', '140301', 840, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14199, 2794, '5月蔬菜', 10574, '140306-原材料-蔬菜', '140306', 2260, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14200, 2794, '5月饮料', 10570, '140302-原材料-饮料', '140302', 615, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14201, 2794, '5月员工餐', 10608, '560128-销售费用-员工餐', '560128', 2600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14202, 2794, '5月月结款', 10584, '224104-其他应付款-月结款', '224104', NULL, 8625, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14203, 2795, '支付11月员工工资', 10580, '221101-应付职工薪酬-工资', '221101', 46830.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14204, 2795, '支付11月员工工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 46830.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14205, 2796, '支付任徐侠1月初备用金报销-猪骨头', 10569, '140301-原材料-猪骨头', '140301', 260, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14206, 2796, '支付任徐侠1月初备用金报销-一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 95, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14207, 2796, '支付任徐侠1月初备用金报销-员工福利', 10603, '560123-销售费用-员工关怀', '560123', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14208, 2796, '支付任徐侠1月初备用金报销-每日手册及打印费及下水道管', 10600, '56012002-销售费用-其他-杂项', '56012002', 53, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14209, 2796, '支付任徐侠1月初备用金报销', 10548, '100202-银行存款-农业银行', '100202', NULL, 608, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14210, 2797, '12月单机会员充值（赠送）', 10604, '560124-销售费用-营业折扣', '560124', 1400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14211, 2797, '12月单机会员充值（赠送）', 10579, '220302-预收账款-单机会员充值', '220302', NULL, 1400, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14212, 2798, '慈溪店购入原材料', 10575, '140307-原材料-福州干货', '140307', 32658.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14213, 2798, '慈溪店购入原材料', 10561, '122104-其他应收款-总仓', '122104', NULL, 32658.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14214, 2799, '支付3月余姚店支付宝款', 10560, '122103-其他应收款-余姚店', '122103', 3274.48, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14215, 2799, '支付3月余姚店支付宝款', 10548, '100202-银行存款-农业银行', '100202', NULL, 3274.48, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14216, 2800, '计提4月工资', 10637, '560213-管理费用-工资', '560213', 23611, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14217, 2800, '计提4月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 23611, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14218, 2801, '支付1月电费', 10521, '560205-管理费用-水电费', '560205', 14313.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14219, 2801, '支付1月水费', 10521, '560205-管理费用-水电费', '560205', 560, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14220, 2801, '支付1月电费水费', 10548, '100202-银行存款-农业银行', '100202', NULL, 14873.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14221, 2802, '7月总仓订货', 10575, '140307-原材料-福州干货', '140307', 10306.64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14222, 2802, '7月总仓订货', 10561, '122104-其他应收款-总仓', '122104', NULL, 10306.64, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14223, 2803, '收到11月饿了么', 10548, '100202-银行存款-农业银行', '100202', 3602.58, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14224, 2803, '收到11月饿了么', 10562, '122105-其他应收款-待入账', '122105', NULL, 3602.58, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14225, 2803, '收到11月会员消费', 10548, '100202-银行存款-农业银行', '100202', 14509.64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14226, 2803, '收到11月会员消费', 10561, '122104-其他应收款-总仓', '122104', NULL, 14509.64, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14227, 2804, '收到6月会员返款', 10548, '100202-银行存款-农业银行', '100202', 32322.28, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14228, 2804, '收到6月会员返款', 10561, '122104-其他应收款-总仓', '122104', NULL, 32322.28, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14229, 2805, '计提10月人员工资', 10637, '560213-管理费用-工资', '560213', 53889.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14230, 2805, '计提10月人员工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 53889.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14231, 2805, '计提10月人员提成', 10638, '560214-管理费用-提成', '560214', 2603.37, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14232, 2805, '计提10月人员提成', 10581, '221102-应付职工薪酬-提成', '221102', NULL, 2603.37, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14233, 2806, '支付7月总仓货款', 10561, '122104-其他应收款-总仓', '122104', 10306.64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14234, 2806, '支付7月总仓货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 10306.64, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14235, 2807, '确认4月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 19298, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14236, 2807, '确认4月收入-刷卡金额（小白盒）', 10548, '100202-银行存款-农业银行', '100202', 77207.82, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14237, 2807, '确认4月收入-会员卡消费', 10561, '122104-其他应收款-总仓', '122104', 29696.25, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14238, 2807, '确认4月收入-会员卡消费手续费', 10531, '560302-财务费用-手续费', '560302', 112.85, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14239, 2807, '确认4月收入-礼券', 10604, '560124-销售费用-营业折扣', '560124', 525, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14240, 2807, '确认4月收入-优免', 10604, '560124-销售费用-营业折扣', '560124', 6009.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14241, 2807, '确认4月收入-赠菜', 10604, '560124-销售费用-营业折扣', '560124', 123, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14242, 2807, '确认4月收入-报损', 10604, '560124-销售费用-营业折扣', '560124', 67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14243, 2807, '确认4月收入', 10488, '5001-主营业务收入', '5001', NULL, 133039.82, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14244, 2808, '支付9月员工工资', 10637, '560213-管理费用-工资', '560213', 8656, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14245, 2808, '支付9月员工工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 8656, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14246, 2809, '调整成本科目', 10577, '140309-原材料-自采购', '140309', 1969.15, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14247, 2809, '调整成本科目', 10570, '140302-原材料-饮料', '140302', NULL, 369.15, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14248, 2809, '调整成本科目', 10576, '140308-原材料-凤爪', '140308', NULL, 1600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14249, 2810, '支付1月进货款', 10561, '122104-其他应收款-总仓', '122104', 32525, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14250, 2810, '支付1月进货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 32525, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14251, 2811, '农行12月短信服务费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14252, 2811, '农行12月短信服务费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14253, 2812, '支付消杀年费', 10600, '56012002-销售费用-其他-杂项', '56012002', 1200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14254, 2812, '支付消杀年费', 10548, '100202-银行存款-农业银行', '100202', NULL, 1200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14255, 2813, '5月农行短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14256, 2813, '5月农行短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14257, 2814, '1月吴莹雯暂借款', 10567, '122110-其他应收款-个人', '122110', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14258, 2814, '1月吴莹雯暂借款', 10548, '100202-银行存款-农业银行', '100202', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14259, 2815, '支付10月推广费用', 10514, '560115-销售费用-广告费', '560115', 760, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14260, 2815, '支付10月推广费用', 10548, '100202-银行存款-农业银行', '100202', NULL, 760, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14261, 2816, '结转成本', 10496, '5401-主营业务成本', '5401', 38645.31, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14262, 2816, '结转成本', 10575, '140307-原材料-福州干货', '140307', NULL, 32984.48, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14263, 2816, '结转成本', 10574, '140306-原材料-蔬菜', '140306', NULL, 2100.76, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14264, 2816, '结转成本', 10577, '140309-原材料-自采购', '140309', NULL, 1540.07, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14265, 2816, '结转成本', 10572, '140304-原材料-面条', '140304', NULL, 2020, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14266, 2817, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14267, 2817, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14268, 2818, '4月成本结转', 10496, '5401-主营业务成本', '5401', 29230.19, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14269, 2818, '4月成本结转-福州干货', 10575, '140307-原材料-福州干货', '140307', NULL, 23620.32, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14270, 2818, '4月成本结转-面条', 10572, '140304-原材料-面条', '140304', NULL, 1755, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14271, 2818, '4月成本结转-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 1051.16, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14272, 2818, '4月成本结转-凤爪', 10576, '140308-原材料-凤爪', '140308', NULL, 2303.71, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14273, 2818, '4月成本结转-自采购', 10577, '140309-原材料-自采购', '140309', NULL, 500, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14274, 2819, '4月农行短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14275, 2819, '4月农行短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14276, 2820, '支付仓库年电费', 10521, '560205-管理费用-水电费', '560205', 4600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14277, 2820, '支付仓库年电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 4600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14278, 2821, '7月月结款-面条', 10572, '140304-原材料-面条', '140304', 2865, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14279, 2821, '7月月结款-蔬菜及香菇', 10574, '140306-原材料-蔬菜', '140306', 1385, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14280, 2821, '7月月结款-饮料', 10570, '140302-原材料-饮料', '140302', 600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14281, 2821, '7月月结款-筒骨和鸡架', 10569, '140301-原材料-猪骨头', '140301', 1680, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14282, 2821, '7月月结款-虾干', 10571, '140303-原材料-海鲜', '140303', 800, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14283, 2821, '7月月结款-员工餐', 10608, '560128-销售费用-员工餐', '560128', 3150, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14284, 2821, '7月月结款', 10584, '224104-其他应付款-月结款', '224104', NULL, 10480, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14285, 2822, '总仓进货暂借款35000', 10561, '122104-其他应收款-总仓', '122104', 35000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14286, 2822, '总仓进货暂借款35000', 10548, '100202-银行存款-农业银行', '100202', NULL, 35000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14287, 2823, '摊销10月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16848.27, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14288, 2823, '摊销10月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16848.27, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14289, 2823, '摊销10月仓储租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 916.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14290, 2823, '摊销10月仓储租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 916.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14291, 2824, '4月购入原材料', 10575, '140307-原材料-福州干货', '140307', 52141.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14292, 2824, '4月购入原材料', 10561, '122104-其他应收款-总仓', '122104', NULL, 52141.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14293, 2825, '确认8月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 2656, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14294, 2825, '确认8月收入-现金待入账', 10562, '122105-其他应收款-待入账', '122105', 580, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14295, 2825, '确认8月收入-现金', 10488, '5001-主营业务收入', '5001', NULL, 3236, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14296, 2825, '确认8月收入-微信', 10548, '100202-银行存款-农业银行', '100202', 22746.22, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14297, 2825, '确认8月收入-支付宝', 10562, '122105-其他应收款-待入账', '122105', 16012.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14298, 2825, '确认8月收入-收钱吧手续费', 10531, '560302-财务费用-手续费', '560302', 141.87, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14299, 2825, '确认8月收入-收钱吧收入', 10488, '5001-主营业务收入', '5001', NULL, 38900.29, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14300, 2825, '确认8月收入-美团外卖', 10548, '100202-银行存款-农业银行', '100202', 10226.03, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14301, 2825, '确认8月收入-美团外卖待入账', 10562, '122105-其他应收款-待入账', '122105', 326.31, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14302, 2825, '确认8月收入-美团外卖折扣', 10604, '560124-销售费用-营业折扣', '560124', 5126.99, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14303, 2825, '确认8月收入-美团外卖', 10488, '5001-主营业务收入', '5001', NULL, 15679.33, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14304, 2825, '确认8月收入-美团团购', 10548, '100202-银行存款-农业银行', '100202', 2964.34, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14305, 2825, '确认8月收入-美团团购待入账', 10562, '122105-其他应收款-待入账', '122105', 328.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14306, 2825, '确认8月收入-美团团购手续费', 10531, '560302-财务费用-手续费', '560302', 225.83, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14307, 2825, '确认8月收入-美团团购', 10488, '5001-主营业务收入', '5001', NULL, 3518.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14308, 2825, '确认8月收入-饿了么', 10562, '122105-其他应收款-待入账', '122105', 3931.59, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14309, 2825, '确认8月收入-饿了么折扣', 10604, '560124-销售费用-营业折扣', '560124', 1839.09, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14310, 2825, '确认8月收入-饿了么', 10488, '5001-主营业务收入', '5001', NULL, 5770.68, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14311, 2825, '确认8月收入-优免折扣', 10604, '560124-销售费用-营业折扣', '560124', 2635.57, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14312, 2825, '确认8月收入-优免折扣', 10488, '5001-主营业务收入', '5001', NULL, 2635.57, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14313, 2825, '确认8月收入-会员消费', 10566, '122109-其他应收款-会员户', '122109', 6232.13, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14314, 2825, '确认8月收入-会员消费', 10531, '560302-财务费用-手续费', '560302', 23.68, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14315, 2825, '确认8月收入-会员消费', 10488, '5001-主营业务收入', '5001', NULL, 6255.81, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14316, 2826, '剩余材料退总仓', 10561, '122104-其他应收款-总仓', '122104', 8833, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14317, 2826, '剩余材料退总仓', 10575, '140307-原材料-福州干货', '140307', NULL, 8833, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14318, 2827, '支付店铺改造费', 10615, '560135-销售费用-装修费', '560135', 16000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14319, 2827, '支付店铺改造费', 10548, '100202-银行存款-农业银行', '100202', NULL, 16000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14320, 2828, '计提6月工资', 10637, '560213-管理费用-工资', '560213', 22200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14321, 2828, '计提6月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 22200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14322, 2829, '支付1月餐费', 10584, '224104-其他应付款-月结款', '224104', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14323, 2829, '支付1月餐费', 10548, '100202-银行存款-农业银行', '100202', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14324, 2829, '1月面条月结', 10584, '224104-其他应付款-月结款', '224104', 2025, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14325, 2829, '1月面条月结', 10548, '100202-银行存款-农业银行', '100202', NULL, 2025, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14326, 2829, '1月蔬菜月结', 10584, '224104-其他应付款-月结款', '224104', 1255.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14327, 2829, '1月蔬菜月结', 10548, '100202-银行存款-农业银行', '100202', NULL, 1255.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14328, 2829, '支付1月备用金报销', 10559, '122102-其他应收款-备用金', '122102', 1101.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14329, 2829, '支付1月备用金报销', 10548, '100202-银行存款-农业银行', '100202', NULL, 1101.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14330, 2829, '支付2月凤爪款', 10576, '140308-原材料-凤爪', '140308', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14331, 2829, '支付2月凤爪款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14332, 2830, '收到8月饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 6898.06, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14333, 2830, '收到8月饿了么收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 6898.06, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14334, 2830, '收到8月现金待入账', 10548, '100202-银行存款-农业银行', '100202', 3196, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14335, 2830, '收到8月现金待入账', 10562, '122105-其他应收款-待入账', '122105', NULL, 3196, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14336, 2830, '收到8月支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 19729.84, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14337, 2830, '收到8月支付宝收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 19729.84, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14338, 2831, '总仓订货暂借款', 10561, '122104-其他应收款-总仓', '122104', 20000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14339, 2831, '总仓订货暂借款', 10548, '100202-银行存款-农业银行', '100202', NULL, 20000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14340, 2832, '农行12月结息', 10548, '100202-银行存款-农业银行', '100202', 36.54, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14341, 2832, '农行12月结息', 10530, '560301-财务费用-利息费用', '560301', -36.54, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14342, 2833, '慈溪店分摊广告费', 10514, '560115-销售费用-广告费', '560115', 2220, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14343, 2833, '慈溪店分摊广告费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2220, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14344, 2834, '支付冻货运费', 10575, '140307-原材料-福州干货', '140307', 900, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14345, 2834, '支付冻货运费', 10548, '100202-银行存款-农业银行', '100202', NULL, 900, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14346, 2835, '支付灯箱尾款', 10627, '56020907-管理费用-开办费-灯箱', '56020907', 450, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14347, 2835, '支付灯箱尾款', 10548, '100202-银行存款-农业银行', '100202', NULL, 450, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14348, 2836, '确认1月收入-现金', 10548, '100202-银行存款-农业银行', '100202', 22994, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14349, 2836, '确认1月收入-美团', 10548, '100202-银行存款-农业银行', '100202', 13169.72, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14350, 2836, '确认1月收入-微信', 10548, '100202-银行存款-农业银行', '100202', 14683.32, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14351, 2836, '确认1月收入-支付宝', 10548, '100202-银行存款-农业银行', '100202', 56684.98, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14352, 2836, '确认1月收入-饿了么', 10548, '100202-银行存款-农业银行', '100202', 4589.76, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14353, 2836, '确认1月收入-会员消费', 10561, '122104-其他应收款-总仓', '122104', 38913.97, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14354, 2836, '确认1月收入-会员消费手续费', 10531, '560302-财务费用-手续费', '560302', 214.03, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14355, 2836, '确认1月收入-单机会员消费', 10579, '220302-预收账款-单机会员充值', '220302', 1716, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14356, 2836, '确认1月收入-礼券及报损', 10604, '560124-销售费用-营业折扣', '560124', 333, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14357, 2836, '确认1月收入', 10488, '5001-主营业务收入', '5001', NULL, 153298.78, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14358, 2837, '支付5月员工餐费', 10584, '224104-其他应付款-月结款', '224104', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14359, 2837, '支付5月员工餐费', 10548, '100202-银行存款-农业银行', '100202', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14360, 2837, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14361, 2837, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14362, 2838, '预付总仓货款', 10561, '122104-其他应收款-总仓', '122104', 25000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14363, 2838, '预付总仓货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 25000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14364, 2838, '结息', 10548, '100202-银行存款-农业银行', '100202', 38.82, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14365, 2838, '结息', 10530, '560301-财务费用-利息费用', '560301', -38.82, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14366, 2839, '支付新店长备用金', 10559, '122102-其他应收款-备用金', '122102', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14367, 2839, '支付新店长备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 5000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14368, 2840, '收到货款', 10548, '100202-银行存款-农业银行', '100202', 1280, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14369, 2840, '收到货款', 10574, '140306-原材料-蔬菜', '140306', NULL, 1280, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14370, 2841, '支付1-3月国地税', 10462, '222126-应交税费-税金', '222126', 7708.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14371, 2841, '支付1-3月国地税', 10548, '100202-银行存款-农业银行', '100202', NULL, 7708.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14372, 2842, '店长报销备用金-打印纸', 10594, '56010402-销售费用-办公费-打印纸', '56010402', 168, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14373, 2842, '店长报销备用金-低值易耗', 10598, '560119-销售费用-低值易耗品', '560119', 910.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14374, 2842, '店长报销备用金-电话费', 10593, '56010401-销售费用-办公费-电话费', '56010401', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14375, 2842, '店长报销备用金-烟雾报警器', 10597, '560117-销售费用-设备-小器具', '560117', 600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14376, 2842, '店长报销备用金-拌面名片', 10600, '56012002-销售费用-其他-杂项', '56012002', 40, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14377, 2842, '店长报销备用金-胡椒粉', 10601, '560121-销售费用-厨房原材料-调料', '560121', 110, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14378, 2842, '店长报销备用金-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 80, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14379, 2842, '店长报销备用金-推广费', 10514, '560115-销售费用-广告费', '560115', 609.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14380, 2842, '店长报销备用-员工餐', 10608, '560128-销售费用-员工餐', '560128', 60, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14381, 2842, '店长报销备用-运费', 10510, '560111-销售费用-运输费', '560111', 124, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14382, 2842, '店长报销备用-凤爪', 10569, '140301-原材料-猪骨头', '140301', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14383, 2842, '店长报销备用金报销', 10559, '122102-其他应收款-备用金', '122102', NULL, 4502.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14384, 2843, '4月原材料盘盈-打包小袋', 10575, '140307-原材料-福州干货', '140307', 50, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14385, 2843, '4月原材料盘盈-越南虾', 10575, '140307-原材料-福州干货', '140307', 146.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14386, 2843, '4月原材料盘盈', 10592, '530105-营业外收入-其他', '530105', NULL, 196.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14387, 2843, '4月原材料报废', 10642, '571112-营业外支出-其他', '571112', 1550.03, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14388, 2843, '4月原材料报废', 10575, '140307-原材料-福州干货', '140307', NULL, 1550.03, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14389, 2844, '计提7月工资', 10637, '560213-管理费用-工资', '560213', 22700, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14390, 2844, '计提7月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 22700, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14391, 2845, '支付6月蔬菜', 10584, '224104-其他应付款-月结款', '224104', 3968, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14392, 2845, '支付6月面条', 10584, '224104-其他应付款-月结款', '224104', 2628, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14393, 2845, '支付6月员工餐', 10584, '224104-其他应付款-月结款', '224104', 3440, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14394, 2845, '支付6月月结款', 10548, '100202-银行存款-农业银行', '100202', NULL, 10036, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14395, 2846, '10月福州原材料盘盈', 10575, '140307-原材料-福州干货', '140307', 2974.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14396, 2846, '10月福州原材料盘盈', 10495, '530104-营业外收入-盘盈收益', '530104', NULL, 2974.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14397, 2847, '支付总仓货款', 10561, '122104-其他应收款-总仓', '122104', 23862, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14398, 2847, '支付总仓货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 23862, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14399, 2848, '员工年货款', 10603, '560123-销售费用-员工关怀', '560123', 763.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14400, 2848, '员工年货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 763.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14401, 2849, '调整1月成本（一次性勺子，冬装）', 10496, '5401-主营业务成本', '5401', 12185.53, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14402, 2849, '调整1月成本（一次性勺子，冬装）', 10575, '140307-原材料-福州干货', '140307', NULL, 12185.53, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14403, 2850, '7月员工餐', 10584, '224104-其他应付款-月结款', '224104', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14404, 2850, '7月员工餐', 10548, '100202-银行存款-农业银行', '100202', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14405, 2850, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14406, 2850, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14407, 2851, '支付1月水费', 10521, '560205-管理费用-水电费', '560205', 238, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14408, 2851, '支付1月电费', 10521, '560205-管理费用-水电费', '560205', 6356.86, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14409, 2851, '支付1月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 6594.86, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14410, 2852, '支付总仓仓库管理费', 10640, '560216-管理费用-租金', '560216', 3000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14411, 2852, '支付总仓仓库管理费', 10548, '100202-银行存款-农业银行', '100202', NULL, 3000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14412, 2853, '12月购进原材料-面条', 10572, '140304-原材料-面条', '140304', 3330, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14413, 2853, '12月购进原材料-海鲜', 10571, '140303-原材料-海鲜', '140303', 1178, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14414, 2853, '12月购进原材料-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 1622, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14415, 2853, '12月购进原材料-饮料', 10570, '140302-原材料-饮料', '140302', 430, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14416, 2853, '12月员工餐', 10608, '560128-销售费用-员工餐', '560128', 5000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14417, 2853, '12月月结未付款的款项', 10582, '224101-其他应付款-个人', '224101', NULL, 11560, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14418, 2854, '计提12月工资', 10637, '560213-管理费用-工资', '560213', 27832, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14419, 2854, '计提12月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 27832, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14420, 2855, '11月干面酱到货', 10575, '140307-原材料-福州干货', '140307', 2850, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14421, 2855, '11月干面酱到货', 10400, '1402-在途物资', '1402', NULL, 2850, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14422, 2856, '支付购买冰箱款', 10583, '224102-其他应付款-设备，装修', '224102', 4200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14423, 2856, '支付购买冰箱款', 10548, '100202-银行存款-农业银行', '100202', NULL, 4200, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14424, 2857, '收到7月饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 5185.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14425, 2857, '收到7月饿了么收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 5185.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14426, 2858, '11月1-30现金', 10548, '100202-银行存款-农业银行', '100202', 6050, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14427, 2858, '11月1-30微信', 10548, '100202-银行存款-农业银行', '100202', 25452.92, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14428, 2858, '11月1-30支付宝', 10562, '122105-其他应收款-待入账', '122105', 20098.54, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14429, 2858, '11月1-30会员消费', 10561, '122104-其他应收款-总仓', '122104', 14509.64, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14430, 2858, '11月1-30会员消费手续费', 10531, '560302-财务费用-手续费', '560302', 55.14, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14431, 2858, '11月1-30美团', 10548, '100202-银行存款-农业银行', '100202', 10373.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14432, 2858, '11月1-30饿了么', 10562, '122105-其他应收款-待入账', '122105', 3602.58, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14433, 2858, '11月1-30喵街', 10562, '122105-其他应收款-待入账', '122105', 296.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14434, 2858, '11月1-30报损', 10604, '560124-销售费用-营业折扣', '560124', 6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14435, 2858, '11月1-30优免折扣', 10604, '560124-销售费用-营业折扣', '560124', 8382.33, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14436, 2858, '11月1-30收入', 10488, '5001-主营业务收入', '5001', NULL, 88827.05, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14437, 2859, '7月进货', 10575, '140307-原材料-福州干货', '140307', 42927, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14438, 2859, '7月进货', 10561, '122104-其他应收款-总仓', '122104', NULL, 42927, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14439, 2860, '支付12月备用金报销', 10559, '122102-其他应收款-备用金', '122102', 2878.33, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14440, 2860, '支付12月备用金报销', 10548, '100202-银行存款-农业银行', '100202', NULL, 2878.33, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14441, 2861, '4月总仓进货', 10575, '140307-原材料-福州干货', '140307', 36848, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14442, 2861, '4月总仓进货', 10561, '122104-其他应收款-总仓', '122104', NULL, 36848, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14443, 2862, '支付3月未报销备用金款', 10582, '224101-其他应付款-个人', '224101', 2086.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14444, 2862, '支付3月未报销备用金款', 10548, '100202-银行存款-农业银行', '100202', NULL, 2086.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14445, 2863, '短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14446, 2863, '短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14447, 2864, '10月结转成本', 10496, '5401-主营业务成本', '5401', 67967.71, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14448, 2864, '10月结转成本-猪骨头', 10569, '140301-原材料-猪骨头', '140301', NULL, 308, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14449, 2864, '10月结转成本-饮料', 10570, '140302-原材料-饮料', '140302', NULL, 517.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14450, 2864, '10月结转成本-海鲜', 10571, '140303-原材料-海鲜', '140303', NULL, 810.91, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14451, 2864, '10月结转成本-面条', 10572, '140304-原材料-面条', '140304', NULL, 3930, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14452, 2864, '10月结转成本-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 2862, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14453, 2864, '10月结转成本-福州干货', 10575, '140307-原材料-福州干货', '140307', NULL, 59539.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14454, 2865, '地下仓库年费2019.7.21-2020.7.20', 10550, '112302-预付账款-仓库租金', '112302', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14455, 2865, '地下仓库年费2019.7.21-2020.7.20', 10548, '100202-银行存款-农业银行', '100202', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14456, 2865, '支付7月报销款', 10559, '122102-其他应收款-备用金', '122102', 1461.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14457, 2865, '支付7月报销款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1461.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14458, 2866, '支付开门红包', 10603, '560123-销售费用-员工关怀', '560123', 1854, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14459, 2866, '支付开门红包', 10548, '100202-银行存款-农业银行', '100202', NULL, 1854, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14460, 2867, '收到3小店货物', 10564, '122107-其他应收款-三小店', '122107', 10821, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14461, 2867, '收到3小店货物', 10548, '100202-银行存款-农业银行', '100202', NULL, 10821, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14462, 2868, '支付品牌使用费', 10641, '560217-管理费用-品牌使用费', '560217', 10000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14463, 2868, '支付品牌使用费', 10548, '100202-银行存款-农业银行', '100202', NULL, 10000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14464, 2869, '结转成本', 10496, '5401-主营业务成本', '5401', 23456.31, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14465, 2869, '结转成本', 10575, '140307-原材料-福州干货', '140307', NULL, 18634.91, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14466, 2869, '结转成本', 10572, '140304-原材料-面条', '140304', NULL, 2025, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14467, 2869, '结转成本', 10574, '140306-原材料-蔬菜', '140306', NULL, 1281.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14468, 2869, '结转成本', 10577, '140309-原材料-自采购', '140309', NULL, 342.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14469, 2869, '结转成本', 10573, '140305-原材料-花生', '140305', NULL, 35, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14470, 2869, '结转成本', 10576, '140308-原材料-凤爪', '140308', NULL, 1137.3, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14471, 2870, '支付福州货款', 10575, '140307-原材料-福州干货', '140307', 10325.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14472, 2870, '支付福州货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 10325.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14473, 2871, '支付转账手续费', 10531, '560302-财务费用-手续费', '560302', 3.94, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14474, 2871, '支付转账手续费', 10548, '100202-银行存款-农业银行', '100202', NULL, 3.94, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14475, 2872, '摊销12月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16848.27, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14476, 2872, '摊销12月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16848.27, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14477, 2872, '摊销12月仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 166.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14478, 2872, '摊销12月仓库租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 166.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14479, 2873, '结转成本', 10496, '5401-主营业务成本', '5401', 56550.14, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14480, 2873, '结转成本-面条', 10572, '140304-原材料-面条', '140304', NULL, 2865, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14481, 2873, '结转成本-蔬菜', 10574, '140306-原材料-蔬菜', '140306', NULL, 1385, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14482, 2873, '结转成本-海鲜', 10571, '140303-原材料-海鲜', '140303', NULL, 800, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14483, 2873, '结转成本-饮料', 10570, '140302-原材料-饮料', '140302', NULL, 600, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14484, 2873, '结转成本-骨头', 10569, '140301-原材料-猪骨头', '140301', NULL, 3280, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14485, 2873, '7月结转成本-福州干货', 10575, '140307-原材料-福州干货', '140307', NULL, 47620.14, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14486, 2874, '支付12月月结款', 10584, '224104-其他应付款-月结款', '224104', 3930.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14487, 2874, '支付12月月结款', 10548, '100202-银行存款-农业银行', '100202', NULL, 2020, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14488, 2874, '支付12月月结款', 10548, '100202-银行存款-农业银行', '100202', NULL, 830, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14489, 2874, '支付12月月结款', 10548, '100202-银行存款-农业银行', '100202', NULL, 1080.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14490, 2875, '4月月结款-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 1534.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14491, 2875, '4月月结款-面条', 10572, '140304-原材料-面条', '140304', 1755, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14492, 2875, '4月月结款-凤爪', 10576, '140308-原材料-凤爪', '140308', 1600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14493, 2875, '4月月结', 10584, '224104-其他应付款-月结款', '224104', NULL, 4889.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14494, 2875, '4月月结款-员工餐', 10608, '560128-销售费用-员工餐', '560128', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14495, 2875, '4月月结款-员工餐', 10584, '224104-其他应付款-月结款', '224104', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14496, 2876, '4月房租摊销', 10618, '56020801-管理费用-摊销费-房租', '56020801', 2498.46, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14497, 2876, '4月房租摊销', 10549, '112301-预付账款-房租', '112301', NULL, 2498.46, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14498, 2876, '4月仓库租金摊销', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 166.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14499, 2876, '4月仓库租金摊销', 10550, '112302-预付账款-仓库租金', '112302', NULL, 166.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14500, 2877, '7月月结款-面条', 10572, '140304-原材料-面条', '140304', 1695, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14501, 2877, '7月月结款-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 1354.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14502, 2877, '7月月结款', 10584, '224104-其他应付款-月结款', '224104', NULL, 3049.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14503, 2877, '7月员工餐', 10608, '560128-销售费用-员工餐', '560128', 1300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14504, 2877, '7月员工餐', 10584, '224104-其他应付款-月结款', '224104', NULL, 1300, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14505, 2878, '10月收入-现金收入', 10548, '100202-银行存款-农业银行', '100202', 49230, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14506, 2878, '10月收入-微信收入', 10548, '100202-银行存款-农业银行', '100202', 29044.96, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14507, 2878, '10月收入-支付宝收入', 10548, '100202-银行存款-农业银行', '100202', 74696.75, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14508, 2878, '10月收入-美团收入', 10548, '100202-银行存款-农业银行', '100202', 14696.49, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14509, 2878, '10月收入-饿了么收入', 10548, '100202-银行存款-农业银行', '100202', 9982.03, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14510, 2878, '10月收入-礼券', 10605, '560125-销售费用-礼券', '560125', 1336, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14511, 2878, '10月收入-单机会员消费', 10579, '220302-预收账款-单机会员充值', '220302', 2333, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14512, 2878, '10月收入-微信会员消费', 10561, '122104-其他应收款-总仓', '122104', 35403.58, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14513, 2878, '10月收入-微信会员消费手续费', 10531, '560302-财务费用-手续费', '560302', 212.42, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14514, 2878, '10月收入', 10488, '5001-主营业务收入', '5001', NULL, 216935.23, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14515, 2879, '支付福州干货货款', 10575, '140307-原材料-福州干货', '140307', 2180, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14516, 2879, '支付福州干货货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 2180, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14517, 2880, '卖原材料收入', 10548, '100202-银行存款-农业银行', '100202', 142, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14518, 2880, '卖原材料收入', 10562, '122105-其他应收款-待入账', '122105', 320, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14519, 2880, '卖原材料收入', 10642, '571112-营业外支出-其他', '571112', 0.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14520, 2880, '卖原材料收入', 10576, '140308-原材料-凤爪', '140308', NULL, 462.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14521, 2881, '支付总仓6月进货款', 10561, '122104-其他应收款-总仓', '122104', 15190.5, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14522, 2881, '支付总仓6月进货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 15190.5, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14523, 2881, '支付7月员工工资', 10580, '221101-应付职工薪酬-工资', '221101', 22200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14524, 2881, '7月补提工资', 10637, '560213-管理费用-工资', '560213', 500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14525, 2881, '7月员工工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 22700, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14526, 2882, '发放1月份工资', 10580, '221101-应付职工薪酬-工资', '221101', 27242, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14527, 2882, '发放1月份工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 27242, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14528, 2883, '摊销1月份仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 166.67, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14529, 2883, '摊销1月份仓库租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 166.67, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14530, 2884, '活动奖励', 10603, '560123-销售费用-员工关怀', '560123', 500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14531, 2884, '活动奖励', 10548, '100202-银行存款-农业银行', '100202', NULL, 500, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14532, 2885, '支付8月饮料月结', 10584, '224104-其他应付款-月结款', '224104', 1996.25, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14533, 2885, '支付8月饮料月结', 10600, '56012002-销售费用-其他-杂项', '56012002', 788.75, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14534, 2885, '支付5-8月饮料月结', 10548, '100202-银行存款-农业银行', '100202', NULL, 2785, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14535, 2886, '支付福州干货货款', 10575, '140307-原材料-福州干货', '140307', 5679.4, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14536, 2886, '支付福州干货货款', 10548, '100202-银行存款-农业银行', '100202', NULL, 5679.4, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14537, 2887, '原材料盘盈', 10575, '140307-原材料-福州干货', '140307', 4569.12, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14538, 2887, '原材料盘盈', 10495, '530104-营业外收入-盘盈收益', '530104', NULL, 4569.12, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14539, 2888, '税金不再计提回冲10-11月税金', 10462, '222126-应交税费-税金', '222126', 4746.66, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14540, 2888, '税金不再计提回冲10-11月税金', 10639, '560215-管理费用-税金', '560215', -4746.66, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14541, 2889, '摊销7月房租', 10618, '56020801-管理费用-摊销费-房租', '56020801', 16665.14, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14542, 2889, '摊销7月房租', 10549, '112301-预付账款-房租', '112301', NULL, 16665.14, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14543, 2889, '摊销7月仓库租金', 10619, '56020802-管理费用-摊销费-仓储租金', '56020802', 916.63, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14544, 2889, '摊销7月仓库租金', 10550, '112302-预付账款-仓库租金', '112302', NULL, 916.63, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14545, 2890, '支付1月工资', 10580, '221101-应付职工薪酬-工资', '221101', 44427.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14546, 2890, '支付1月工资', 10548, '100202-银行存款-农业银行', '100202', NULL, 44427.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14547, 2891, '收到12月现金', 10548, '100202-银行存款-农业银行', '100202', 523, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14548, 2891, '收到12月现金', 10562, '122105-其他应收款-待入账', '122105', NULL, 523, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14549, 2892, '4月店长备用金报销-自制泡萝卜，白醋', 10601, '560121-销售费用-厨房原材料-调料', '560121', 87.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14550, 2892, '4月店长备用金报销-蒸笼盖，保鲜膜，拖把', 10598, '560119-销售费用-低值易耗品', '560119', 123.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14551, 2892, '4月店长备用金报销-称量袋', 10577, '140309-原材料-自采购', '140309', 500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14552, 2892, '4月店长备用金报销-话费', 10593, '56010401-销售费用-办公费-电话费', '56010401', 300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14553, 2892, '4月店长备用金报销-总仓运费', 10510, '560111-销售费用-运输费', '560111', 60, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14554, 2892, '4月店长备用金报销', 10559, '122102-其他应收款-备用金', '122102', NULL, 1071.6, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14555, 2893, '8月农业银行短信服务费', 10531, '560302-财务费用-手续费', '560302', 2.01, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14556, 2893, '8月农业银行短信服务费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2.01, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14557, 2894, '收到3月现金营业款', 10548, '100202-银行存款-农业银行', '100202', 603, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14558, 2894, '收到3月现金营业款', 10562, '122105-其他应收款-待入账', '122105', NULL, 603, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14559, 2895, '10月单机会员充值', 10548, '100202-银行存款-农业银行', '100202', 1500, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14560, 2895, '10月单机会员充值', 10579, '220302-预收账款-单机会员充值', '220302', NULL, 1500, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14561, 2896, '支付余姚店借款', 10560, '122103-其他应收款-余姚店', '122103', 20000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14562, 2896, '支付余姚店借款', 10548, '100202-银行存款-农业银行', '100202', NULL, 20000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14563, 2897, '报销备用金-低值', 10598, '560119-销售费用-低值易耗品', '560119', 188.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14564, 2897, '报销备用金-办公', 10596, '56010404-销售费用-办公费-办公用品', '56010404', 214, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14565, 2897, '报销备用金-花生', 10573, '140305-原材料-花生', '140305', 35, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14566, 2897, '报销备用金-自购', 10601, '560121-销售费用-厨房原材料-调料', '560121', 63.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14567, 2897, '报销备用金-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 25.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14568, 2897, '报销备用金-修冰箱', 10502, '560103-销售费用-修理费', '560103', 100, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14569, 2897, '报销备用金-总仓运费', 10510, '560111-销售费用-运输费', '560111', 75, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14570, 2897, '报销备用金-生日福利', 10603, '560123-销售费用-员工关怀', '560123', 100, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14571, 2897, '报销备用金-员工餐', 10608, '560128-销售费用-员工餐', '560128', 300, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14572, 2897, '报销备用金-员工餐', 10559, '122102-其他应收款-备用金', '122102', NULL, 1101.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14573, 2898, '7月月结款-面条', 10584, '224104-其他应付款-月结款', '224104', 1695, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14574, 2898, '7月月结款-面条', 10548, '100202-银行存款-农业银行', '100202', NULL, 1695, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14575, 2898, '7月月结款-蔬菜筒骨', 10584, '224104-其他应付款-月结款', '224104', 1354.7, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14576, 2898, '7月月结款-蔬菜筒骨', 10548, '100202-银行存款-农业银行', '100202', NULL, 1354.7, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14577, 2899, '支付短信费', 10531, '560302-财务费用-手续费', '560302', 2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14578, 2899, '支付短信费', 10548, '100202-银行存款-农业银行', '100202', NULL, 2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14579, 2900, '支付8月结款', 10584, '224104-其他应付款-月结款', '224104', 7875, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14580, 2900, '支付8月结款-员工餐', 10548, '100202-银行存款-农业银行', '100202', NULL, 2440, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14581, 2900, '支付8月结款-面条', 10548, '100202-银行存款-农业银行', '100202', NULL, 2175, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14582, 2900, '支付8月结款-蔬菜', 10548, '100202-银行存款-农业银行', '100202', NULL, 3260, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14583, 2901, '支付6月水费', 10521, '560205-管理费用-水电费', '560205', 406, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14584, 2901, '支付6月电费', 10521, '560205-管理费用-水电费', '560205', 11524.8, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14585, 2901, '支付6月水电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 11930.8, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14586, 2902, '计提5月提成', 10638, '560214-管理费用-提成', '560214', 1086, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14587, 2902, '计提5月提成', 10581, '221102-应付职工薪酬-提成', '221102', NULL, 1086, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14588, 2903, '任徐侠报销12月备用金-保险柜及验钞机', 10609, '560129-销售费用-经营期间购买的小设备', '560129', 386, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14589, 2903, '任徐侠报销12月备用金-天元冻库租金', 10640, '560216-管理费用-租金', '560216', 890, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14590, 2903, '任徐侠报销12月备用金-低值易耗品', 10598, '560119-销售费用-低值易耗品', '560119', 277.1, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14591, 2903, '任徐侠报销12月备用金-猪骨头', 10569, '140301-原材料-猪骨头', '140301', 1160, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14592, 2903, '任徐侠报销12月备用金-海鲜', 10571, '140303-原材料-海鲜', '140303', 5.57, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14593, 2903, '任徐侠报销12月备用金-垃圾费', 10606, '560126-销售费用-垃圾费', '560126', 400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14594, 2903, '任徐侠报销12月备用金-广告', 10514, '560115-销售费用-广告费', '560115', 200, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14595, 2903, '任徐侠报销12月备用金-其他', 10600, '56012002-销售费用-其他-杂项', '56012002', 264, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14596, 2903, '任徐侠报销12月备用金-顾客投诉充值会员退款', 10604, '560124-销售费用-营业折扣', '560124', 474, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14597, 2903, '任徐侠报销12月备用金-调料', 10601, '560121-销售费用-厨房原材料-调料', '560121', 1394.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14598, 2903, '任徐侠报销12月备用金-桶装水', 10595, '56010403-销售费用-办公费-桶装水', '56010403', 32, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14599, 2903, '任徐侠报销12月备用金-管道疏通', 10509, '560110-销售费用-商品维修费', '560110', 600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14600, 2903, '任徐侠报销12月备用金-一次性用品', 10602, '560122-销售费用-一次性用品', '560122', 1579.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14601, 2903, '任徐侠报销12月备用金-员工餐', 10608, '560128-销售费用-员工餐', '560128', 92, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14602, 2903, '任徐侠报销12月备用金-员工关怀', 10603, '560123-销售费用-员工关怀', '560123', 1044.6, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14603, 2903, '任徐侠报销12月备用金-运费', 10510, '560111-销售费用-运输费', '560111', 1133, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14604, 2903, '任徐侠报销12月备用金', 10582, '224101-其他应付款-个人', '224101', NULL, 2299.2, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14605, 2903, '任徐侠报销12月备用金', 10548, '100202-银行存款-农业银行', '100202', NULL, 7632.47, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14606, 2904, '收到一点点电费', 10548, '100202-银行存款-农业银行', '100202', 9027.78, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14607, 2904, '收到一点点电费', 10548, '100202-银行存款-农业银行', '100202', NULL, 9027.78, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14608, 2905, '计提2月工资', 10637, '560213-管理费用-工资', '560213', 33591.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14609, 2905, '计提2月工资', 10580, '221101-应付职工薪酬-工资', '221101', NULL, 33591.9, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14610, 2906, '店长报销备用金-低值', 10598, '560119-销售费用-低值易耗品', '560119', 362.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14611, 2906, '店长报销备用金-修理费', 10502, '560103-销售费用-修理费', '560103', 250, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14612, 2906, '店长报销备用金健康证', 10600, '56012002-销售费用-其他-杂项', '56012002', 100, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14613, 2906, '店长报销备用金-话费', 10593, '56010401-销售费用-办公费-电话费', '56010401', 600, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14614, 2906, '店长报销备用金-运费', 10510, '560111-销售费用-运输费', '560111', 75, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14615, 2906, '店长报销备用金-垃圾费', 10606, '560126-销售费用-垃圾费', '560126', 400, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14616, 2906, '店长报销备用金-员工餐', 10608, '560128-销售费用-员工餐', '560128', 902.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14617, 2906, '店长报销备用金-自购', 10574, '140306-原材料-蔬菜', '140306', 188.23, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14618, 2906, '店长报销备用金', 10559, '122102-其他应收款-备用金', '122102', NULL, 2878.33, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14619, 2907, '收到1月会员消费反款', 10548, '100202-银行存款-农业银行', '100202', 38913.97, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14620, 2907, '收到1月会员消费反款', 10561, '122104-其他应收款-总仓', '122104', NULL, 38913.97, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14621, 2908, '确认收入-现金', 10548, '100202-银行存款-农业银行', '100202', 17919.9, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14622, 2908, '确认收入-小白盒', 10548, '100202-银行存款-农业银行', '100202', 82263.86, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14623, 2908, '确认收入-美团外卖', 10548, '100202-银行存款-农业银行', '100202', 16219.38, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14624, 2908, '确认收入-美团外卖手续费', 10531, '560302-财务费用-手续费', '560302', 5858.82, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14625, 2908, '确认收入-会员消费', 10561, '122104-其他应收款-总仓', '122104', 30621.44, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14626, 2908, '确认收入-会员消费', 10531, '560302-财务费用-手续费', '560302', 116.36, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14627, 2908, '确认收入-喵街收入', 10562, '122105-其他应收款-待入账', '122105', 445.2, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14628, 2908, '确认收入-报损', 10604, '560124-销售费用-营业折扣', '560124', 305, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14629, 2908, '确认收入-饿了么', 10562, '122105-其他应收款-待入账', '122105', 5185.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14630, 2908, '确认收入-饿了么', 10531, '560302-财务费用-手续费', '560302', 1137.14, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14631, 2908, '确认收入-优免折扣', 10604, '560124-销售费用-营业折扣', '560124', 11795.72, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14632, 2908, '确认收入-优惠券', 10604, '560124-销售费用-营业折扣', '560124', 1542.3, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14633, 2908, '确认收入', 10488, '5001-主营业务收入', '5001', NULL, 173410.42, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14634, 2909, '收到12.31-2美团收入', 10548, '100202-银行存款-农业银行', '100202', 1747.77, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14635, 2909, '收到12.31美团收入', 10562, '122105-其他应收款-待入账', '122105', NULL, 490.59, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14636, 2909, '收到1.1-2美团收入', 10488, '5001-主营业务收入', '5001', NULL, 1257.18, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14637, 2910, '支付设备尾款', 10583, '224102-其他应付款-设备，装修', '224102', 16000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14638, 2910, '支付设备尾款', 10548, '100202-银行存款-农业银行', '100202', NULL, 16000, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14639, 2911, '支付自采购原材料-海鲜', 10571, '140303-原材料-海鲜', '140303', 2290, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14640, 2911, '支付自采购原材料-蔬菜', 10574, '140306-原材料-蔬菜', '140306', 2000, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14641, 2911, '支付自采购原材料-猪骨头', 10569, '140301-原材料-猪骨头', '140301', 1770, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14642, 2911, '支付自采购原材料-饮料', 10570, '140302-原材料-饮料', '140302', 2840, NULL, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14643, 2911, '支付自采购原材料', 10582, '224101-其他应付款-个人', '224101', NULL, 8900, NULL, 0, NULL, 74, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14644, 2912, '提现', 10386, '1001-库存现金', '1001', 100, NULL, '', NULL, NULL, 73, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14645, 2912, '利息收入', 10547, '100201-银行存款-中国银行', '100201', NULL, 100, '', NULL, NULL, 73, NULL, NULL, NULL, NULL, b'0');
INSERT INTO `fxy_financial_voucher_details` VALUES (14646, NULL, '期初', 10386, '1001-库存现金', '1001', NULL, NULL, NULL, NULL, NULL, 73, NULL, NULL, NULL, NULL, b'0');
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_voucher_details_auxiliary
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_voucher_details_auxiliary`;
CREATE TABLE `fxy_financial_voucher_details_auxiliary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voucher_details_id` int(11) DEFAULT NULL COMMENT '凭证明细 Id',
  `accounting_category_id` int(11) DEFAULT NULL COMMENT '辅助类型 id',
  `accounting_category_details_id` int(11) DEFAULT NULL COMMENT '辅助项值 Id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `accounting_category_id_fk` (`accounting_category_id`) USING BTREE,
  KEY `details_id_fk` (`accounting_category_details_id`) USING BTREE,
  KEY `voucher_details_id_fk` (`voucher_details_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='凭证辅助项关联';

-- ----------------------------
-- Records of fxy_financial_voucher_details_auxiliary
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_voucher_template
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_voucher_template`;
CREATE TABLE `fxy_financial_voucher_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '模板名称',
  `is_default` bit(1) NOT NULL DEFAULT b'0',
  `type` tinyint(4) NOT NULL,
  `account_sets_id` int(11) NOT NULL,
  `debit_amount` double DEFAULT '0',
  `credit_amount` double DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `faas_sss` (`account_sets_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='凭证模板';

-- ----------------------------
-- Records of fxy_financial_voucher_template
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_voucher_template_details
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_voucher_template_details`;
CREATE TABLE `fxy_financial_voucher_template_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voucher_template_id` int(11) NOT NULL,
  `summary` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '摘要',
  `subject_id` int(11) DEFAULT NULL,
  `subject_name` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '科目名称',
  `debit_amount` double DEFAULT NULL COMMENT '借方金额',
  `credit_amount` double DEFAULT NULL COMMENT '贷方金额',
  `account_sets_id` int(11) DEFAULT NULL,
  `subject_code` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL,
  `auxiliary_title` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fxy_financial_voucher_details_subject_id_fk` (`subject_id`) USING BTREE,
  KEY `fxy_financial_voucher_details_voucher_template_id_fk` (`voucher_template_id`) USING BTREE,
  KEY `fxy_financial_vouchnt_sets_id_fk` (`account_sets_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='凭证模板明细';

-- ----------------------------
-- Records of fxy_financial_voucher_template_details
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fxy_financial_voucher_word
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_voucher_word`;
CREATE TABLE `fxy_financial_voucher_word` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(16) COLLATE utf8mb4_bin NOT NULL COMMENT '凭证字',
  `print_title` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '打印标题',
  `is_default` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否默认',
  `account_sets_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `fxy_financial_voucher_word_word_account_sets_id_uindex` (`word`,`account_sets_id`) USING BTREE,
  KEY `fxy_financial_voucher_word_fxy_financial_account_sets_id_fk` (`account_sets_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='凭证字';

-- ----------------------------
-- Records of fxy_financial_voucher_word
-- ----------------------------
BEGIN;
INSERT INTO `fxy_financial_voucher_word` VALUES (239, '记', '记账凭证', b'1', 73);
INSERT INTO `fxy_financial_voucher_word` VALUES (240, '收', '收款凭证', b'0', 73);
INSERT INTO `fxy_financial_voucher_word` VALUES (241, '付', '付款凭证', b'0', 73);
INSERT INTO `fxy_financial_voucher_word` VALUES (242, '转', '转账凭证', b'0', 73);
INSERT INTO `fxy_financial_voucher_word` VALUES (243, '记', '记账凭证', b'1', 74);
INSERT INTO `fxy_financial_voucher_word` VALUES (244, '收', '收款凭证', b'0', 74);
INSERT INTO `fxy_financial_voucher_word` VALUES (245, '付', '付款凭证', b'0', 74);
INSERT INTO `fxy_financial_voucher_word` VALUES (246, '转', '转账凭证', b'0', 74);
INSERT INTO `fxy_financial_voucher_word` VALUES (247, '记', '记账凭证', b'1', 75);
INSERT INTO `fxy_financial_voucher_word` VALUES (248, '收', '收款凭证', b'0', 75);
INSERT INTO `fxy_financial_voucher_word` VALUES (249, '付', '付款凭证', b'0', 75);
INSERT INTO `fxy_financial_voucher_word` VALUES (250, '转', '转账凭证', b'0', 75);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
