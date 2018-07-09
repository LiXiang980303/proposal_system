CREATE TABLE IF NOT EXISTS `app_proposal_info` (
  `info_no` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '提案编号',
  `info_name` varchar(50) NOT NULL COMMENT '提案名称',
  `info_content` varchar(1000) NOT NULL COMMENT '提案内容',
  `writer` varchar(50) NOT NULL COMMENT '作者',
  `submit_time` timestamp DEFAULT CURRENT_TIMESTAMP COMMENT '提交日期',
  `end_time` timestamp DEFAULT CURRENT_TIMESTAMP COMMENT '截止日期',
  `update_time` timestamp DEFAULT CURRENT_TIMESTAMP COMMENT '更新日期',
  `status` varchar(11) DEFAULT NULL COMMENT '状态',
  `record_no` varchar(11) DEFAULT NULL COMMENT '备案',
  `record_user` varchar(11) DEFAULT NULL COMMENT '备案人',
  `priority` int(10) DEFAULT NULL COMMENT '优先级',
  `upgrade_user` varchar(11) DEFAULT NULL COMMENT '推荐人',
  `num_agree` int(10) DEFAULT NULL COMMENT '附议数',
  `num_disagree` int(10) DEFAULT NULL COMMENT '反对数',
  PRIMARY KEY (`info_no`),
  KEY `idx_appinfo_status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='提案表' AUTO_INCREMENT=2005 ;