CREATE TABLE IF NOT EXISTS `app_proposal_comment` (
  `comment_no` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论编号',
  `info_no` bigint(20) NOT NULL COMMENT '提案编号',
  `comment_content` varchar(1000) NOT NULL COMMENT '评论内容',
  `comment_user` varchar(50) NOT NULL COMMENT '评论人',
  `comment_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  `status` varchar(11) DEFAULT NULL COMMENT '状态：1-附议，0-反对',
  PRIMARY KEY (`comment_no`),
  KEY `idx_appcomment_infono` (`info_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='提案评论表' AUTO_INCREMENT=2005 ;