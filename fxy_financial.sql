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

 Date: 10/10/2021 23:15:03
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
-- Table structure for fxy_financial_report_template
-- ----------------------------
DROP TABLE IF EXISTS `fxy_financial_report_template`;
CREATE TABLE `fxy_financial_report_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `account_sets_id` int(11) DEFAULT NULL,
  `template_key` varchar(128) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '报表类型：0普通报表，1资产报表',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `fxy_report_template_account_sets_id_template_key_uindex` (`account_sets_id`,`template_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8;

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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fxy_financial_voucher_account_sets_id_fk` (`account_sets_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2913 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='凭证';

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

SET FOREIGN_KEY_CHECKS = 1;
