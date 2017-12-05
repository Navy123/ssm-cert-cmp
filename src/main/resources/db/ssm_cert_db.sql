/*
Navicat MySQL Data Transfer

Source Server         : local-mysql
Source Server Version : 50711
Source Host           : 127.0.0.1:3306
Source Database       : ssm_cert_db

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2017-09-12 20:22:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for affected_product
-- ----------------------------
DROP TABLE IF EXISTS `affected_product`;
CREATE TABLE `affected_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增长',
  `base_id` bigint(20) NOT NULL COMMENT '需要和base_info表保持一致，依靠程序逻辑控制',
  `cwe_id` varchar(255) NOT NULL COMMENT 'CVE编号,unique',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '条目创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '条目更新时间',
  `affected_os` text COMMENT '受影响的操作系统版本，暂定用符号“;”间隔，用户输入后，入库请用英文分号间隔用户的多个输入',
  `affected_soft` text COMMENT '受影响的软件; 暂定用符号“;”间隔；用户输入后，入库请用英文分号间隔用户的多个输入',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of affected_product
-- ----------------------------
INSERT INTO `affected_product` VALUES ('1', '8', 'CVE-ID-9658785', '2017-09-10 12:51:03', '2017-09-11 20:42:52', '测试,软件,硬件,andorid,ios,apple', 'microsoft,windows,ppt,word');
INSERT INTO `affected_product` VALUES ('2', '9', 'CVE-ID-2020-6895', '2017-09-10 12:53:32', '2017-09-11 20:42:59', 'os', 'soft');
INSERT INTO `affected_product` VALUES ('3', '10', 'CVE-ID-2013-5698', '2017-09-10 12:54:37', '2017-09-11 20:43:06', 'os', 'soft');
INSERT INTO `affected_product` VALUES ('4', '11', 'CVE-ID-2036-956', '2017-09-10 12:56:07', '2017-09-11 20:43:12', '系统', '软件');
INSERT INTO `affected_product` VALUES ('8', '15', 'CVE-ID-2036-95', '2017-09-10 12:59:16', '2017-09-11 20:43:18', '系统,系统,系统,系统', '软件,软件,软件,软件');
INSERT INTO `affected_product` VALUES ('12', '1', 'CVE-2017-4973', '2017-09-10 15:44:04', '2017-09-11 23:41:20', 'apache', 'soft,micro');
INSERT INTO `affected_product` VALUES ('13', '22', 'CVE-ID-2015', '2017-09-11 17:05:26', '2017-09-11 23:30:56', 'windows7,windows8', 'apache,tomcat');
INSERT INTO `affected_product` VALUES ('14', '4', 'CVE-2016-2175', '2017-09-11 20:22:34', '2017-09-11 20:41:32', 'soft', null);
INSERT INTO `affected_product` VALUES ('15', '5', 'CVE-ID-2018-5689', '2017-09-11 20:42:21', '2017-09-11 20:42:21', 'system', 'soft');
INSERT INTO `affected_product` VALUES ('16', '23', 'CVE-ID-12-23', '2017-09-11 23:36:55', '2017-09-11 23:40:31', 'windows,linux', 'apache');

-- ----------------------------
-- Table structure for base_info
-- ----------------------------
DROP TABLE IF EXISTS `base_info`;
CREATE TABLE `base_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表内自动编号，主键',
  `cve_id` varchar(255) NOT NULL COMMENT 'CVE编号,unique',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '条目创建时间，添加入库时写入添加时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '条目更新时间，更新时写入更新时间',
  `bug_type` enum('code','frame','lib','other') NOT NULL DEFAULT 'code' COMMENT '漏洞类型，分为源码、框架和库三种',
  `description` text COMMENT '对该漏洞的描述',
  `publish_time` date NOT NULL COMMENT '漏洞发布时间，用户输入',
  `modified_time` date NOT NULL COMMENT '漏洞更新时间，用户输入',
  `danger_level` enum('low','middle','high') NOT NULL DEFAULT 'low' COMMENT '漏洞的等级',
  `solution_opinion` text COMMENT '漏洞修改意见',
  `reference` varchar(255) DEFAULT NULL COMMENT '漏洞来源链接，长度暂定varchar(255)',
  `is_exist_patch` tinyint(1) NOT NULL COMMENT '数据库是否存在补丁信息，当用户增删补丁信息时，更新该字段值',
  `is_exist_product_list` tinyint(1) NOT NULL COMMENT '数据库是否存在受影响产品信息，当用户增删列表信息时，更新该字段值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of base_info
-- ----------------------------
INSERT INTO `base_info` VALUES ('1', 'CVE-2017-4973', '2017-09-07 20:52:58', '2017-09-11 23:41:20', 'lib', '在Pivotal Spring Web Flow (SWF)中通过2.4.4发现了一个问题。默认情况下禁用的MvcViewFactoryCreator useSpringBinding属性的值（即，设置为“false”）的应用程序在处理表单提交但没有要声明的子元素的视图状态中容易受到恶意EL表达式的影响显式数据绑定属性映射', '2017-06-04', '2017-09-10', 'low', '建议直接升级调用lib的版本到2.5.X', 'https://nvd.nist.gov/vuln/detail/CVE-2017-4971;https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-4971', '1', '1');
INSERT INTO `base_info` VALUES ('2', 'CVE-2016-0705', '2017-09-07 20:54:14', '2017-09-07 20:54:14', 'frame', '在1.0.2之前的1.0.1s和1.0.2之前，OpenSSL 1.0.1中的crypto / dsa / dsa_ameth.c中的dsa_priv_decode函数中的双重漏洞可能会导致远程攻击者导致拒绝服务（内存损坏）或可能存在未指定的其他通过格式不正确的DSA私钥影响。', '2016-03-03', '2017-05-09', 'high', 'OpenSSL 1.0.2 users should upgrade to 1.0.2g\r\nOpenSSL 1.0.1 users should upgrade to 1.0.1s\r\n', 'http://cve.scap.org.cn/CVE-2016-0705.html;https://nvd.nist.gov/vuln/detail/CVE-2016-0705;https://www.openssl.org/news/secadv/20160301.txt', '0', '1');
INSERT INTO `base_info` VALUES ('3', 'CVE-2016-1901', '2017-09-07 20:55:15', '2017-09-11 20:41:12', 'code', 'cgit 是一种git 代码浏览工具，类似gitweb ，但是更快速，openembedded ,freedeskop 等项目都在采用cgit。CGIT之前的authenticate_post函数中的整数溢出；在0.12之前允许远程攻击者通过Content-Length ——HTTP头中的一个大值，触发缓冲区溢出而产生未指定的影响。', '2016-01-12', '2016-12-07', 'high', '更新cgit版本，或者打补丁', 'http://cve.scap.org.cn/CVE-2016-1901.html; http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-1901; https://nvd.nist.gov/vuln/detail/CVE-2016-1901; https://git.zx2c4.com/cgit/refs/tags', '0', '0');
INSERT INTO `base_info` VALUES ('4', 'CVE-2016-2175', '2017-09-07 20:56:06', '2017-09-11 20:41:22', 'lib', 'PDFBox（一个BSD许可下的源码开放项目）是一个为开发人员读取和创建PDF文档而准备的纯Java类库。2.0.1之前的1.8.12和2.x之前的Apache PDFBox无法正确初始化XML解析器，这允许与上下文相关的攻击者通过精心制作的PDF进行XML外部实体（XXE）攻击。', '2016-06-01', '2017-01-06', 'low', '', 'reference', '0', '1');
INSERT INTO `base_info` VALUES ('5', 'CVE-ID-2018-5689', '2017-09-10 11:40:58', '2017-09-11 20:42:21', 'frame', '漏洞描述', '2017-09-10', '2017-09-20', 'high', '漏洞改进意见', '漏洞引用参考', '0', '1');
INSERT INTO `base_info` VALUES ('6', 'CVE-ID-2018-6589', '2017-09-10 12:35:28', '2017-09-11 20:42:33', 'code', '漏洞描述信息', '2017-09-01', '2018-09-06', 'low', '漏洞改进意见信息', '漏洞引用参考', '0', '0');
INSERT INTO `base_info` VALUES ('7', 'CVE-ID-2019-656', '2017-09-10 12:39:07', '2017-09-10 12:39:07', 'frame', '描述', '2017-09-19', '2017-09-07', 'low', '意见', '漏洞引用参考', '0', '0');
INSERT INTO `base_info` VALUES ('8', 'CVE-ID-9658785', '2017-09-10 12:51:03', '2017-09-11 20:42:52', 'code', '描述', '2017-09-22', '2017-09-26', 'middle', '意见', '参考', '0', '1');
INSERT INTO `base_info` VALUES ('9', 'CVE-ID-2020-6895', '2017-09-10 12:53:32', '2017-09-11 20:42:59', 'lib', '模式', '2017-09-06', '2017-09-20', 'middle', '意见', '参考引用', '0', '1');
INSERT INTO `base_info` VALUES ('10', 'CVE-ID-2013-5698', '2017-09-10 12:54:37', '2017-09-11 20:43:06', 'frame', '参考', '2017-09-13', '2017-09-29', 'middle', '参考', '参考', '0', '1');
INSERT INTO `base_info` VALUES ('11', 'CVE-ID-2036-956', '2017-09-10 12:56:07', '2017-09-11 20:43:12', 'lib', '漏洞描述', '2017-09-05', '2017-09-11', 'middle', '改进意见', '引用参考', '0', '1');
INSERT INTO `base_info` VALUES ('15', 'CVE-ID-2036-95', '2017-09-10 12:59:16', '2017-09-11 20:43:18', 'lib', '漏洞描述', '2017-09-16', '2017-09-19', 'high', '改进意见', 'ck', '0', '1');
INSERT INTO `base_info` VALUES ('22', 'CVE-ID-2015', '2017-09-11 17:04:26', '2017-09-11 23:30:56', 'lib', '漏洞描述测试', '2017-09-01', '2017-09-02', 'low', '漏洞改进意见测试', '测试', '0', '1');
INSERT INTO `base_info` VALUES ('23', 'CVE-ID-12-23', '2017-09-11 23:36:54', '2017-09-11 23:40:31', 'frame', '漏洞描述', '2017-09-01', '2017-09-11', 'low', '漏洞改进', '查看', '1', '1');

-- ----------------------------
-- Table structure for code_info
-- ----------------------------
DROP TABLE IF EXISTS `code_info`;
CREATE TABLE `code_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表内自动编号，主键',
  `base_id` bigint(20) NOT NULL COMMENT '需要和base_info表保持一致，依靠程序逻辑控制',
  `cve_id` varchar(255) NOT NULL COMMENT 'CVE编号',
  `code_position` varchar(255) NOT NULL COMMENT '代码位置',
  `code_section` varchar(255) NOT NULL COMMENT '漏洞代码描述',
  `Influence` varchar(10) NOT NULL COMMENT '受影响的平台与产品,链接到affected_product表中',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of code_info
-- ----------------------------
INSERT INTO `code_info` VALUES ('1', '6', 'CVE-ID-2018-6589', 'com.bupt.controller.admin.AdminController', '漏洞描信息', 'influence');
INSERT INTO `code_info` VALUES ('3', '8', 'CVE-ID-9658785', 'localtion', '', 'influence');
INSERT INTO `code_info` VALUES ('5', '3', 'CVE-2016-1901', 'weizhi', '', 'influence');

-- ----------------------------
-- Table structure for frame_info
-- ----------------------------
DROP TABLE IF EXISTS `frame_info`;
CREATE TABLE `frame_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '表内自动编号，主键',
  `base_id` bigint(20) NOT NULL COMMENT '需要和base_info表保持一致，依靠程序逻辑控制',
  `cve_id` varchar(255) NOT NULL COMMENT 'CVE编号',
  `frame_name` varchar(255) NOT NULL COMMENT '框架名',
  `frame_type` varchar(255) NOT NULL COMMENT '框架类型',
  `frame_language` varchar(255) NOT NULL COMMENT '框架语言类型',
  `influence` varchar(10) NOT NULL COMMENT '受影响的平台与产品,链接到affect_product表中',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of frame_info
-- ----------------------------
INSERT INTO `frame_info` VALUES ('1', '7', 'CVE-ID-2019-656', 'lib', 'lib', 'lib', 'influence');
INSERT INTO `frame_info` VALUES ('2', '10', 'CVE-ID-2013-5698', '框架', '框架', '框架', 'influence');
INSERT INTO `frame_info` VALUES ('5', '5', 'CVE-ID-2018-5689', '框架', '框架类型', 'Java', 'influence');
INSERT INTO `frame_info` VALUES ('6', '23', 'CVE-ID-12-23', '框架名', '框架类型', '框架语言', 'influence');

-- ----------------------------
-- Table structure for lib_info
-- ----------------------------
DROP TABLE IF EXISTS `lib_info`;
CREATE TABLE `lib_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增长',
  `base_id` bigint(20) NOT NULL COMMENT '需要和base_info表保持一致，依靠程序逻辑控制',
  `cve_id` varchar(255) NOT NULL COMMENT 'CVE编号,unique',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '条目创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '条目更新时间',
  `lib_name` varchar(255) NOT NULL COMMENT '库的名称',
  `lib_version` varchar(255) NOT NULL COMMENT '库的版本',
  `description` text COMMENT '对该库的说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lib_info
-- ----------------------------
INSERT INTO `lib_info` VALUES ('1', '1', 'CVE-2017-4971', '2017-09-07 21:00:26', '2017-09-11 23:41:20', 'spring-webflow-2.0.8.RELEASE.jar; org.springframework.webflow-2.0.5.RELEASE,spring-webflow-2.0.8.RELEASE.jar; org.springframework.webflow-2.0.5.RELEASE', 'Pivot Spring Web Flow 2.4.0－2.4.4\r\n较旧的不受支持的版本也受到影响,Pivot Spring Web Flow 2.4.0－2.4.4\r\n较旧的不受支持的版本也受到影响', '和Spring MVC、maven框架可以融合，引用方式不一样。,和Spring MVC、maven框架可以融合，引用方式不一样。');
INSERT INTO `lib_info` VALUES ('3', '9', 'CVE-ID-2020-6895', '2017-09-10 12:53:32', '2017-09-11 20:42:59', 'lib库名称', 'lib库版本号', '秒搜');
INSERT INTO `lib_info` VALUES ('4', '11', 'CVE-ID-2036-956', '2017-09-10 12:56:07', '2017-09-11 20:43:12', 'lib库', '3.26', '描述');
INSERT INTO `lib_info` VALUES ('6', '15', 'CVE-ID-2036-95', '2017-09-10 12:59:16', '2017-09-11 20:43:18', 'lib库名称', 'lib库版本号', 'lib库描述');
INSERT INTO `lib_info` VALUES ('9', '22', 'CVE-ID-2015-698', '2017-09-11 17:04:26', '2017-09-11 23:30:56', 'SpringMVC', '4.3.0', 'lib漏洞描述测试');
INSERT INTO `lib_info` VALUES ('12', '4', 'CVE-2016-2175', '2017-09-11 20:22:34', '2017-09-11 20:41:22', 'lib漏洞', 'lib版本库', '');

-- ----------------------------
-- Table structure for patch_info
-- ----------------------------
DROP TABLE IF EXISTS `patch_info`;
CREATE TABLE `patch_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增长',
  `base_id` bigint(20) DEFAULT NULL COMMENT '需要和base_info表保持一致，依靠程序逻辑控制',
  `cve_id` varchar(255) NOT NULL COMMENT 'CVE编号,unique',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '条目创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '条目更新时间',
  `description` text COMMENT '补丁描述',
  `patch_code` longtext COMMENT '漏洞验证信息，其实就是存储代码，这里可能要再设计',
  `reference` varchar(255) DEFAULT NULL COMMENT '漏洞poc链接',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of patch_info
-- ----------------------------
INSERT INTO `patch_info` VALUES ('1', '1', 'CVE-2017-4971', '2017-09-07 20:58:22', '2017-09-07 20:58:22', ' lib的源码级修改，路径如下：\r\nspring-webflow/src/main/java/org/springframework/webflow/mvc/view/AbstractMvcView.java\r\n', '@@ -31,6 +31,7 @@\r\n import org.springframework.binding.expression.Expression;\r\n import org.springframework.binding.expression.ExpressionParser;\r\n import org.springframework.binding.expression.ParserContext;\r\n+import org.springframework.binding.expression.beanwrapper.BeanWrapperExpressionParser;\r\n import org.springframework.binding.expression.support.FluentParserContext;\r\n import org.springframework.binding.expression.support.StaticExpression;\r\n import org.springframework.binding.mapping.MappingResult;\r\n@@ -78,6 +79,8 @@\r\n \r\n 	private ExpressionParser expressionParser;\r\n \r\n+	private final ExpressionParser emptyValueExpressionParser = new BeanWrapperExpressionParser();\r\n+\r\n 	private ConversionService conversionService;\r\n \r\n 	private Validator validator;\r\n @@ -482,7 +485,7 @@ protected void addDefaultMappings(DefaultMapper mapper, Set<String> parameterNam\r\n 	 */\r\n 	protected void addEmptyValueMapping(DefaultMapper mapper, String field, Object model) {\r\n 		ParserContext parserContext = new FluentParserContext().evaluate(model.getClass());\r\n-		Expression target = expressionParser.parseExpression(field, parserContext);\r\n+		Expression target = emptyValueExpressionParser.parseExpression(field, parserContext);\r\n 		try {\r\n 			Class<?> propertyType = target.getValueType(model);\r\n 			Expression source = new StaticExpression(getEmptyValue(propertyType));\r\n', 'https://github.com/spring-projects/spring-webflow/commit/57f2ccb66946943fbf3b3f2165eac1c8eb6b1523');
INSERT INTO `patch_info` VALUES ('2', '1', 'CVE-2017-4971', '2017-09-09 00:00:00', '2017-09-11 17:29:10', 'description2000000000000000000000000000', 'public static void main000000000000000000000000', 'https://00000000000000000000');
INSERT INTO `patch_info` VALUES ('3', '1', 'CVE-2017-4971', '2017-09-09 12:19:13', '2017-09-09 12:19:13', 'description3', 'public static void main', 'https://helloworld');
INSERT INTO `patch_info` VALUES ('4', '1', 'CVE-2017-4971', '2017-09-09 12:19:13', '2017-09-09 12:19:13', 'description4', 'public static void main', 'https://helloworld');
INSERT INTO `patch_info` VALUES ('5', '1', 'CVE-2017-4971', '2017-09-09 12:19:13', '2017-09-09 12:19:13', 'description5', 'public static void main', 'https://helloworld');
INSERT INTO `patch_info` VALUES ('6', '1', 'CVE-2017-4971', '2017-09-09 12:19:13', '2017-09-09 12:19:13', 'description6', 'public static void main', 'https://helloworld');
INSERT INTO `patch_info` VALUES ('7', '1', 'CVE-2017-4971', '2017-09-09 12:19:13', '2017-09-09 12:19:13', 'description7', 'public static void main', 'https://helloworld');
INSERT INTO `patch_info` VALUES ('8', '1', 'CVE-2017-4971', '2017-09-09 12:19:13', '2017-09-09 12:19:13', 'description8', 'public static void main', 'https://helloworld');
INSERT INTO `patch_info` VALUES ('9', '1', 'CVE-2017-4971', '2017-09-09 12:19:13', '2017-09-09 12:19:13', 'description9', 'public static void main', 'https://helloworld');
INSERT INTO `patch_info` VALUES ('10', '1', 'CVE-2017-4971', '2017-09-09 12:19:13', '2017-09-09 12:19:13', 'description10', 'public static void main', 'https://helloworld');
INSERT INTO `patch_info` VALUES ('11', '1', 'CVE-2017-4971', '2017-09-09 12:19:13', '2017-09-09 12:19:13', 'description11', 'public static void main', 'https://helloworld');
INSERT INTO `patch_info` VALUES ('22', '15', 'CVE-ID-2036-95', '2017-09-10 00:00:00', '2017-09-20 00:00:00', '补丁描述', '验证信息', 'poc连接');
INSERT INTO `patch_info` VALUES ('23', '15', 'CVE-ID-2036-95,CVE-ID-2036-95,CVE-ID-2036-95,CVE-ID-2036-95,CVE-ID-2036-95,CVE-ID-2036-95,CVE-ID-2036-95,CVE-ID-2036-95,CVE-ID-2036-95,CVE-ID-2036-95,CVE-ID-2036-95,CVE-ID-2036-95', '2017-09-01 00:00:00', '2017-09-10 22:16:00', '补丁描述', '验证信息', '漏洞poc连接,漏');
INSERT INTO `patch_info` VALUES ('24', '15', 'CVE-ID-2036-95', '2017-09-01 00:00:00', '2017-09-10 23:55:58', 'description', 'message', 'poc');
INSERT INTO `patch_info` VALUES ('25', '15', 'CVE-ID-2036-95', '2017-09-01 00:00:00', '2017-09-16 00:00:00', 'poc', 'poc', 'poc');
INSERT INTO `patch_info` VALUES ('26', '15', 'CVE-ID-2036-95', '2017-09-01 00:00:00', '2017-09-11 00:26:23', '补丁描述信息', '验证信息', 'poc连接');
INSERT INTO `patch_info` VALUES ('28', '1', 'CVE-2017-4973', '2017-09-05 00:00:00', '2017-09-04 00:00:00', '', '', '');
INSERT INTO `patch_info` VALUES ('32', '23', 'CVE-ID-12-23', '2017-09-01 00:00:00', '2017-09-11 23:38:22', '补丁描述', '验证信息', 'poc');
INSERT INTO `patch_info` VALUES ('33', '23', 'CVE-ID-12-23', '2017-08-30 00:00:00', '2017-09-06 00:00:00', '士大夫', '打分', '啊但是发');
