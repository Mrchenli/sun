CREATE DATABASE /*!32312 IF NOT EXISTS*/`active_web` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `active_web`;

/*Data for the table `act_ru_variable` */

/*Table structure for table `pur_order` */

DROP TABLE IF EXISTS `pur_order`;

CREATE TABLE `pur_order` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT '采购单编号，由uuid生成',
  `name` varchar(100) NOT NULL COMMENT '采购单名称',
  `price` float DEFAULT NULL COMMENT '采购金额',
  `content` varchar(100) DEFAULT NULL COMMENT '采购内容',
  `createtime` date DEFAULT NULL COMMENT '创建采购单开始时间',
  `status` varchar(20) DEFAULT NULL COMMENT ' 采购单是否通过审核',
  `user_id` varchar(32) DEFAULT NULL COMMENT '创建采购单的用户id',
  `processInstance_id` varchar(64) DEFAULT NULL COMMENT '流程实例id',
  `endtime` date DEFAULT NULL COMMENT '采购单结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pur_order` */

insert  into `pur_order`(`id`,`name`,`price`,`content`,`createtime`,`status`,`user_id`,`processInstance_id`,`endtime`) values ('4d280d49-a07a-4965-941e-9cb907961a12','购买电脑',5000,'','2019-12-29',NULL,'zhengweiwei','1205',NULL),('e5869ab7-db9d-4f94-be56-d51c171b1d00','sun',5000,'13','2019-12-29',NULL,'maguo','1101',NULL);

/*Table structure for table `pur_order_audit` */

DROP TABLE IF EXISTS `pur_order_audit`;

CREATE TABLE `pur_order_audit` (
  `id` varchar(36) NOT NULL COMMENT '编号',
  `user_id` varchar(20) NOT NULL COMMENT '用户id',
  `order_id` varchar(36) DEFAULT NULL COMMENT '采购单id',
  `audit_info` varchar(500) DEFAULT NULL COMMENT '审核意见',
  `audit_type` varchar(36) DEFAULT NULL COMMENT '审核类型 1、部门经理审核 2、校长审核 3、财务审核',
  `STATUS` char(1) DEFAULT NULL COMMENT '审核状态 1、通过 0、不通过',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pur_order_audit` */

insert  into `pur_order_audit`(`id`,`user_id`,`order_id`,`audit_info`,`audit_type`,`STATUS`,`createtime`) values ('45fc5adb-26e9-413f-ad21-10cce29b26f8','wangfurong','4d280d49-a07a-4965-941e-9cb907961a12','','secondAudit','0','2019-12-30 15:35:37'),('56fe847f-aa96-4c88-85ec-8f570921c9be','marry','4d280d49-a07a-4965-941e-9cb907961a12','','firstAudit','1','2019-12-30 15:35:14'),('7037b1a2-339e-4cfe-b965-f7e791d8ee38','limei','4d280d49-a07a-4965-941e-9cb907961a12','','thirdAudit','1','2019-12-30 15:36:39'),('730de0f0-f8fe-453a-832f-caab9e2312b0','wangfurong','4d280d49-a07a-4965-941e-9cb907961a12','','secondAudit','1','2019-12-30 15:36:27'),('75febf19-f5fd-4b0f-892b-96911b353b0d','zhengweiwei','4d280d49-a07a-4965-941e-9cb907961a12','','firstAudit','1','2019-12-30 15:36:16');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
