CREATE TABLE IF NOT EXISTS `app_proposal_user_refer` (
  `refer_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '推荐ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `refer_name` varchar(50) NOT NULL COMMENT '推荐人',
  `refer_department` varchar(50) NOT NULL COMMENT '单位',
  `refer_phone` bigint(20) DEFAULT NULL COMMENT '电话',
  `refer_job_title` varchar(50) DEFAULT NULL COMMENT '职称',
  `refer_job_position` varchar(50) DEFAULT NULL COMMENT '职务',
  `refer_post_code` varchar(20) DEFAULT NULL COMMENT '邮编',
  `refer_user` varchar(20) DEFAULT NULL COMMENT '被推荐人',
  `refer_reason` varchar(1000) DEFAULT NULL COMMENT '推荐原因',
  `status` varchar(10) DEFAULT NULL COMMENT '审核通过：1-通过',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  PRIMARY KEY (`refer_id`),
  KEY `idx_appuser_refer_referid` (`refer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户推荐表' AUTO_INCREMENT=2005 ;