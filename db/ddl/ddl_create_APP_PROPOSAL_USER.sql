CREATE TABLE IF NOT EXISTS `app_proposal_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(50) NOT NULL COMMENT '用户名',
  `login_name` varchar(50) NOT NULL COMMENT '登录名',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  `user_phone` bigint(20) DEFAULT NULL COMMENT '手机号',
  `sex` varchar(20) DEFAULT NULL COMMENT '性别',
  `birth` varchar(50) DEFAULT NULL COMMENT '出生年月',
  `address` varchar(100) DEFAULT NULL COMMENT '家庭住址',
  `refer` varchar(20) DEFAULT NULL COMMENT '推荐人',
  `industry_branch` varchar(100) DEFAULT NULL COMMENT '行业分会',
  `special_committee` varchar(100) DEFAULT NULL COMMENT '专委会',
  `verify` varchar(10) DEFAULT NULL COMMENT '审核通过：1-通过',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`user_id`),
  KEY `idx_appuser_loginname` (`login_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户表' AUTO_INCREMENT=2005 ;