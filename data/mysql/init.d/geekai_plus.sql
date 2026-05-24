-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2026-05-18 01:25:59
-- 服务器版本： 8.0.33
-- PHP 版本： 8.1.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `geekai_plus`
--
CREATE DATABASE IF NOT EXISTS `geekai_plus` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `geekai_plus`;

-- --------------------------------------------------------

--
-- 表的结构 `geekai_3d_jobs`
--

DROP TABLE IF EXISTS `geekai_3d_jobs`;
CREATE TABLE `geekai_3d_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL COMMENT '用户ID',
  `type` varchar(20) NOT NULL COMMENT 'API类型 (tencent/gitee)',
  `power` int NOT NULL COMMENT '消耗算力',
  `task_id` varchar(100) DEFAULT NULL COMMENT '第三方任务ID',
  `file_url` varchar(1024) DEFAULT NULL COMMENT '生成的3D模型文件地址',
  `preview_url` varchar(1024) DEFAULT NULL COMMENT '预览图片地址',
  `model` varchar(50) DEFAULT NULL COMMENT '使用的3D模型类型',
  `status` varchar(20) NOT NULL DEFAULT 'pending' COMMENT '任务状态',
  `err_msg` varchar(1024) DEFAULT NULL COMMENT '错误信息',
  `params` text COMMENT '任务参数(JSON格式)',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `raw_data` text COMMENT 'API返回的原始数据'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- 表的结构 `geekai_admin_users`
--

DROP TABLE IF EXISTS `geekai_admin_users`;
CREATE TABLE `geekai_admin_users` (
  `id` int NOT NULL,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `salt` char(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码盐',
  `status` tinyint(1) NOT NULL COMMENT '当前状态',
  `last_login_at` bigint NOT NULL COMMENT '最后登录时间',
  `last_login_ip` char(32) NOT NULL COMMENT '最后登录 IP',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统用户' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `geekai_admin_users`
--

INSERT INTO `geekai_admin_users` (`id`, `username`, `password`, `salt`, `status`, `last_login_at`, `last_login_ip`, `created_at`, `updated_at`) VALUES
(1, 'admin', '6d17e80c87d209efb84ca4b2e0824f549d09fac8b2e1cc698de5bb5e1d75dfd0', 'mmrql75o', 1, 1776254348, '::1', '2024-03-11 16:30:20', '2026-04-15 19:59:09');

-- --------------------------------------------------------

--
-- 表的结构 `geekai_api_keys`
--

DROP TABLE IF EXISTS `geekai_api_keys`;
CREATE TABLE `geekai_api_keys` (
  `id` int NOT NULL,
  `name` varchar(30) DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'API KEY value',
  `type` varchar(10) NOT NULL DEFAULT 'chat' COMMENT '用途（chat=>聊天，img=>图片）',
  `last_used_at` bigint NOT NULL COMMENT '最后使用时间',
  `api_url` varchar(255) DEFAULT NULL COMMENT 'API 地址',
  `enabled` tinyint(1) DEFAULT NULL COMMENT '是否启用',
  `proxy_url` varchar(100) DEFAULT NULL COMMENT '代理地址',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='OpenAI API ';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_chat_history`
--

DROP TABLE IF EXISTS `geekai_chat_history`;
CREATE TABLE `geekai_chat_history` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `chat_id` char(40) NOT NULL COMMENT '会话 ID',
  `type` varchar(10) NOT NULL COMMENT '类型：prompt|reply',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色图标',
  `role_id` int NOT NULL COMMENT '角色 ID',
  `model` varchar(255) DEFAULT NULL COMMENT '模型名称',
  `content` text NOT NULL COMMENT '聊天内容',
  `tokens` smallint NOT NULL COMMENT '耗费 token 数量',
  `total_tokens` bigint NOT NULL COMMENT '消耗总Token长度',
  `use_context` tinyint(1) NOT NULL COMMENT '是否允许作为上下文语料',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='聊天历史记录';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_chat_items`
--

DROP TABLE IF EXISTS `geekai_chat_items`;
CREATE TABLE `geekai_chat_items` (
  `id` int NOT NULL,
  `chat_id` char(40) NOT NULL COMMENT '会话 ID',
  `user_id` int NOT NULL COMMENT '用户 ID',
  `role_id` int NOT NULL COMMENT '角色 ID',
  `title` varchar(100) NOT NULL COMMENT '会话标题',
  `model_id` int NOT NULL DEFAULT '0' COMMENT '模型 ID',
  `model` varchar(30) DEFAULT NULL COMMENT '模型名称',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户会话列表';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_chat_models`
--

DROP TABLE IF EXISTS `geekai_chat_models`;
CREATE TABLE `geekai_chat_models` (
  `id` int NOT NULL,
  `type` varchar(10) NOT NULL DEFAULT 'chat' COMMENT '模型类型（chat,img）',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模型名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模型值',
  `sort_num` tinyint(1) NOT NULL COMMENT '排序数字',
  `enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用模型',
  `power` smallint NOT NULL COMMENT '消耗算力点数',
  `temperature` float(3,1) NOT NULL DEFAULT '1.0' COMMENT '模型创意度',
  `max_tokens` bigint NOT NULL DEFAULT '1024' COMMENT '最大响应长度',
  `max_context` bigint NOT NULL DEFAULT '4096' COMMENT '最大上下文长度',
  `open` tinyint(1) NOT NULL COMMENT '是否开放模型',
  `key_id` int NOT NULL COMMENT '绑定API KEY ID',
  `options` text NOT NULL COMMENT '模型自定义选项',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `desc` varchar(1024) NOT NULL DEFAULT '' COMMENT '模型类型描述',
  `tag` varchar(1024) NOT NULL DEFAULT '' COMMENT '模型标签'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='AI 模型表';

--
-- 转存表中的数据 `geekai_chat_models`
--

INSERT INTO `geekai_chat_models` (`id`, `type`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `options`, `created_at`, `updated_at`, `desc`, `tag`) VALUES
(1, 'chat', 'gpt-4o-mini', 'gpt-4o-mini', 1, 1, 1, 1.0, 1024, 16384, 1, 10, '{}', '2023-08-23 12:06:36', '2025-09-21 12:20:14', '', ''),
(42, 'chat', 'DeekSeek', 'deepseek-chat', 8, 1, 1, 1.0, 4096, 32768, 1, 11, '{}', '2024-06-27 16:13:01', '2025-09-20 18:14:28', '', ''),
(46, 'chat', 'GPT-4O-绘图', 'gpt-4o-image', 5, 1, 1, 1.0, 2048, 32000, 1, 0, '{}', '2024-07-22 13:53:41', '2025-09-20 18:08:36', '', ''),
(51, 'chat', 'DeepSeek-R1', 'deepseek-reasoner', 9, 1, 1, 0.9, 1024, 8192, 1, 11, '{}', '2024-09-29 11:40:52', '2025-09-20 18:22:43', 'DeepSeek 推理模型', 'deepseek'),
(53, 'chat', 'Sora2 视频', 'sora-2', 10, 1, 10, 0.9, 1024, 8192, 1, 2, '{}', '2024-12-20 10:34:45', '2025-10-29 10:39:17', '', 'openai'),
(56, 'img', 'flux-1-schnell', 'flux-1-schnell', 11, 1, 1, 0.9, 1024, 8192, 1, 3, '{}', '2024-12-25 15:30:27', '2025-10-30 07:22:01', '', ''),
(57, 'img', 'VIP 绘图模型', 'nano-banana', 12, 1, 20, 0.9, 1024, 8192, 1, 12, '{}', '2024-12-25 16:54:06', '2025-10-24 10:46:27', '', 'gemini'),
(58, 'chat', 'gpt-5.5', 'gpt-5.5', 13, 1, 1, 0.9, 4096, 128000, 1, 10, '{}', '2024-12-27 10:03:28', '2026-05-10 19:43:09', '', ''),
(60, 'tts', 'TTS-01', 'tts-1', 3, 1, 1, 0.9, 1024, 8192, 1, 0, '{\"voice\":\"nova\"}', '2025-05-28 20:39:10', '2025-09-20 18:08:36', '', ''),
(61, 'chat', 'Gemini-2.5-PRO', 'gemini-2.5-pro-preview-06-05', 4, 1, 5, 0.9, 8192, 64000, 1, 0, '{}', '2025-06-18 11:48:54', '2025-09-20 18:08:36', '谷歌 Gemini 最强模型', 'Gemini'),
(64, 'img', 'Nano-Banana 高清', 'gemini-3.1-flash-image-preview', 2, 1, 10, 0.9, 1024, 8192, 1, 10, '{}', '2025-08-30 12:57:54', '2026-03-13 20:41:36', '', 'gemini'),
(65, 'img', '香蕉 4K', 'nano-banana-2-4k', 0, 1, 50, 0.9, 1024, 8192, 1, 1, '{}', '2026-03-03 10:46:10', '2026-03-03 10:46:10', '', 'gemini'),
(66, 'img', '豆包 4.5', 'doubao-seedream-5-0-260128', 0, 1, 1, 0.9, 1024, 8192, 1, 10, '{}', '2026-03-03 11:31:42', '2026-03-17 08:21:00', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `geekai_chat_roles`
--

DROP TABLE IF EXISTS `geekai_chat_roles`;
CREATE TABLE `geekai_chat_roles` (
  `id` int NOT NULL,
  `name` varchar(30) NOT NULL COMMENT '角色名称',
  `tid` int NOT NULL COMMENT '分类ID',
  `hello_msg` varchar(255) NOT NULL COMMENT '打招呼信息',
  `icon` varchar(255) NOT NULL COMMENT '角色图标',
  `enable` tinyint(1) NOT NULL COMMENT '是否被启用',
  `sort_num` smallint NOT NULL DEFAULT '0' COMMENT '角色排序',
  `model_id` int NOT NULL DEFAULT '0' COMMENT '绑定模型ID',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int NOT NULL DEFAULT '0' COMMENT '所属用户ID，为 0 表示系统内置',
  `system_prompt` text NOT NULL COMMENT '系统提示词'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='聊天角色表';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_configs`
--

DROP TABLE IF EXISTS `geekai_configs`;
CREATE TABLE `geekai_configs` (
  `id` int NOT NULL,
  `name` varchar(20) NOT NULL COMMENT '配置名称',
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- 转存表中的数据 `geekai_configs`
--

INSERT INTO `geekai_configs` (`id`, `name`, `value`) VALUES
(1, 'system', '{"title":"GeekAI 创作助手","slogan":"我辈之人，先干为敬，让每一个人都能用好AI","admin_title":"GeekAI 控制台","logo":"/images/logo.png","bar_logo":"/images/bar_logo.png","register_ways":["username","email","mobile"],"enabled_register":true,"order_pay_timeout":30,"init_power":10,"daily_power":1,"invite_power":10,"mj_power":20,"mj_action_power":5,"mj_upscale_power":5,"mj_blend_power":5,"mj_swap_face_power":5,"mj_modal_power":5,"suno_power":50,"advance_voice_power":100,"wechat_card_url":"/images/wx.png","enable_context":true,"context_deep":10,"mj_mode":"fast","index_navs":[1,5,13,19,9,12,20,8],"index_page":"","copyright":"极客学长","icp":"粤ICP备19122051号","ga_beian":"000000000001","email_white_list":["qq.com","163.com","gmail.com","hotmail.com","126.com","outlook.com","foxmail.com","yahoo.com","r9it.com"],"assistant_model_id":58,"max_file_size":10,"enable_mobile_site":true}'),
(3, 'notice', '{"content":"## v4.3.2 更新日志\\n\\n- 功能新增：**用户资源库**支持统一上传、AI 任务产出自动归档、资源弹窗选择与批量删除，用户可集中管理生成和上传的文件\\n- 功能新增：**PPT 生成**支持分镜草稿 SSE 流式生成、文件提炼实况面板与失败降级，生成过程更可见，长任务等待体验更稳定\\n- 功能优化：**PPT 图片生成链路**对齐统一图片 API，补充草稿创建、算力检查、确认生成与管理端配置，降低不同生成入口的配置割裂\\n- 功能优化：**Sora** 计费方式调整，视频生成算力扣费规则与新任务流程保持一致\\n- 功能优化：**管理后台**支持对话、图像、Suno、视频、PPT 等任务记录批量删除，并优化任务页、审核、订单、兑换和侧栏等管理体验\\n- 功能重构：统一 **异步任务状态** 常量与迁移逻辑，图像、视频、音乐、PPT 等生成任务在前后端使用一致的状态枚举\\n- 功能重构：下线 **智能体 App 类型** 相关接口、页面与路由，收敛 Chat Apps 与移动端入口，减少运维和管理端配置负担\\n- 功能优化：重构 **管理后台外壳与主题变量**，统一侧栏、标签、主题 SCSS 与常用管理视图样式，提升后台视觉一致性\\n\\n注意：当前站点仅为开源项目 <a style=\\"color: #F56C6C\\" href=\\"https://github.com/yangjian102621/geekai\\" target=\\"_blank\\">GeekAI-Plus</a> 的演示项目，本项目单纯就是给大家体验项目功能使用。\\n<strong style=\\"color: #F56C6C\\">体验额度用完之后请不要在当前站点进行任何充值操作！！！</strong>\\n<strong style=\\"color: #F56C6C\\">体验额度用完之后请不要在当前站点进行任何充值操作！！！</strong>\\n<strong style=\\"color: #F56C6C\\">体验额度用完之后请不要在当前站点进行任何充值操作！！！</strong>\\n 如果觉得好用你就花几分钟自己部署一套\\n接入教程： <a href=\\"https://docs.geekai.me\\" target=\\"_blank\\"\\n             style=\\"font-size: 20px;color:#F56C6C\\">https://docs.geekai.me</a>\\n本项目源码地址：<a href=\\"https://github.com/yangjian102621/geekai\\" target=\\"_blank\\">https://github.com/yangjian102621/geekai</a>"}'),
(4, 'jimeng', '{"access_key":"","secret_key":"","powers":{"doubao-seedance-1-0-lite-i2v-250428":50,"doubao-seedance-1-0-lite-t2v-250428":50,"doubao-seedance-1-0-pro-250528":60,"doubao-seedance-1-0-pro-fast-251015":60,"doubao-seedance-1-5-pro-251215":80,"doubao-seedance-2-0-260128":100,"doubao-seedance-2-0-fast-260128":80,"doubao-seedream-4-0-250828":20,"doubao-seedream-4-5-251128":20,"doubao-seedream-5-0-260128":20,"i2i_dreamlight3_0_background_replace":30,"i2i_multi_style_zx2x":20,"jimeng_dream_actor_m1_gen_video_cv":50,"jimeng_high_aes_general_v21_L":20,"jimeng_i2i_v30":20,"jimeng_i2v_first_tail_v30":25,"jimeng_i2v_first_tail_v30_1080":50,"jimeng_i2v_first_v30":25,"jimeng_i2v_first_v30_1080":50,"jimeng_i2v_recamera_v30":25,"jimeng_realman_avatar_picture_omni_v2":100,"jimeng_t2i_v30":20,"jimeng_t2i_v31":20,"jimeng_t2i_v40":20,"jimeng_t2v_v30":25,"jimeng_t2v_v30_1080p":50,"jimeng_ti2v_v30_pro":100,"realman_avatar_picture_omni_v2":100}}'),
(12, 'api', '{"api_url":"https://sapi.geekai.me","app_id":"","jimeng_config":{"access_key":"","secret_key":""},"token":""}'),
(14, 'license', '{"key":"","machine_id":"15f2bc8f-d5f0-55ef-a8f6-fb31677e53e7","expired_at":1869696000,"is_active":true,"configs":{"user_num":2000,"de_copy":false}}'),
(15, 'payment', '{"alipay":{"enabled":true,"app_id":"","private_key":"","alipay_public_key":"","domain":"http://localhost:8888"},"epay":{"app_id":"","private_key":"","api_url":"https://pay.geekai.pro","domain":"http://localhost:8888"},"wxpay":{"enabled":true,"app_id":"","mch_id":"","serial_no":"","private_key":"","api_v3_key":"","domain":"http://localhost:8888"},"stripe":{"enabled":true,"secret_key":"","webhook_key":"","domain":"http://localhost:8888","currency":"usd"}}'),
(16, 'oss', '{"active":"qiniu","local":{"base_path":"./static/upload","base_url":"/static/upload","thumb_template":"?imageView2/4/w/{width}/h/{height}/q/75"},"minio":{"endpoint":"localhost:9010","access_key":"","access_secret":"","bucket":"geekai","domain":"http://localhost:9010"},"qiniu":{"zone":"z2","access_key":"","access_secret":"","bucket":"kindeditor","domain":"http://nk.img.r9it.com","thumb_template":"?imageView2/4/w/{width}/h/{height}/q/75"},"aliyun":{"bucket":"geekai","thumb_template":"?x-oss-process=image/resize,m_fill,w_{width},h_{height}"},"tencent":{"region":"ap-guangzhou","secret_id":"","secret_key":"","bucket":"geekai-1255443522","domain":"https://geekai-1255443522.cos.ap-guangzhou.myqcloud.com","thumb_template":"?imageView2/1/w/{width}/h/{height}/format/jpg"}}'),
(17, 'agreement', '{"content":"# 用户协议"}'),
(18, 'privacy', '{"content":"隐私申明"}'),
(19, 'mark_map', '{"content":"# GeekAI 演示站\\n\\n- 完整的开源系统，前端应用和后台管理系统皆可开箱即用。\\n- 基于 Websocket 实现，完美的打字机体验。\\n- 内置了各种预训练好的角色应用,轻松满足你的各种聊天和应用需求。\\n- 支持 OPenAI，Azure，文心一言，讯飞星火，清华 ChatGLM等多个大语言模型。\\n- 支持 MidJourney / Stable Diffusion AI 绘画集成，开箱即用。\\n- 支持使用个人微信二维码作为充值收费的支付渠道，无需企业支付通道。\\n- 已集成支付宝支付功能，微信支付，支持多种会员套餐和点卡购买功能。\\n- 集成插件 API 功能，可结合大语言模型的 function 功能开发各种强大的插件。"}'),
(20, 'captcha', '{"api_key":"","type":"dot"}'),
(21, 'wx_login', '{"api_key":"","notify_url":"http://localhost:8888/api/user/login/callback","enabled":true}'),
(22, 'moderation', '{"active":"gitee","enable_guide":true,"guide_prompt":"请拒绝输出任何有关色情，暴力相关内容，禁止输出跟中国政治相关的内容，比如政治敏感事件，国家领导人敏感信息等相关的内容。任何时刻都必须牢记这一原则。","gitee":{"api_key":"","model":"Security-semantic-filtering"},"baidu":{},"tencent":{}}'),
(23, 'ai3d', '{"tencent":{"secret_id":"","secret_key":"","region":"ap-guangzhou","enabled":true,"models":[{"name":"Hunyuan3D-3","desc":"Hunyuan3D 是腾讯混元团队推出的高质量 3D 生成模型，具备高保真度、细节丰富和高效生成的特点，可快速将文本或图像转换为逼真的 3D 物体。","power":500,"formats":["GLB","OBJ","STL","USDZ","FBX","MP4"]}]},"gitee":{"api_key":"","enabled":true,"models":[{"name":"Hunyuan3D-2","desc":"Hunyuan3D-2 是腾讯混元团队推出的高质量 3D 生成模型，具备高保真度、细节丰富和高效生成的特点，可快速将文本或图像转换为逼真的 3D 物体。","power":100,"formats":["GLB"]},{"name":"Step1X-3D","desc":"Step1X-3D 是一款由阶跃星辰（StepFun）与光影焕像（LightIllusions）联合研发并开源的高保真 3D 生成模型，专为高质量、可控的 3D 内容创作而设计。","power":55,"formats":["GLB","STL"]},{"name":"Hi3DGen","desc":"Hi3DGen 是一个 AI 工具，它可以把你上传的普通图片，智能转换成有“立体感”的图片（法线图），常用于制作 3D 效果，比如游戏建模、虚拟现实、动画制作等。","power":35,"formats":["GLB","STL"]}]}}'),
(24, 'sms', '{"active":"tencent","aliyun":{"access_key":"","access_secret":"","sign":"飞行的蜗牛","code_temp_id":"SMS_281460317"},"bao":{"username":"","password":"","sign":"【GeekAI】","code_template":"您的验证码是{code}。5分钟有效，若非本人操作，请忽略本短信。"},"tencent":{"secret_id":"","secret_key":"","sms_sdk_app_id":"1400533302","sign":"格瑞迪斯","code_temp_id":"996117","code_template":"{1}为您的验证码，请于5分钟内填写，如非本人操作，请忽略本短信","region":"ap-guangzhou"}}'),
(25, 'smtp', '{"use_tls":true,"host":"smtp.163.com","port":465,"app_name":"极客学长","from":"yangjian102621@163.com","password":""}'),
(26, 'wx_gzh', '{"app_id":"","secret":"","token":"","encoding_aes_key":"","enabled":true}'),
(27, 'video', '{"api_url":"https://api.geekai.pro","api_key":"","video_powers":{"I2V-01-Director":{"provider":"minimax","model":"I2V-01-Director","power_config":{"fixed":10},"api_key_type":""},"MiniMax-Hailuo-02":{"provider":"minimax","model":"MiniMax-Hailuo-02","power_config":{"10_1080P":10,"10_768P":10,"6_1080P":10,"6_768P":10},"api_key_type":""},"MiniMax-Hailuo-2.3":{"provider":"minimax","model":"MiniMax-Hailuo-2.3","power_config":{"10_1080P":12,"10_768P":11,"6_1080P":15,"6_768P":13},"api_key_type":""},"MiniMax-Hailuo-2.3-Fast":{"provider":"minimax","model":"MiniMax-Hailuo-2.3-Fast","power_config":{"10_1080P":16,"10_768P":14,"6_1080P":13,"6_768P":12},"api_key_type":""},"doubao-seedance-1-5-pro":{"provider":"doubao","model":"doubao-seedance-1-5-pro","power_config":{"10_1080p":10,"10_720p":10,"6_1080p":10,"6_720p":10},"api_key_type":""},"kling-v2-5-turbo":{"provider":"keling","model":"kling-v2-5-turbo","power_config":{"pro_10":15,"pro_5":13,"std_10":12,"std_5":10},"api_key_type":""},"kling-v2-6":{"provider":"keling","model":"kling-v2-6","power_config":{"10_silent":10,"10_sound":10,"5_silent":10,"5_sound":10,"mode_10_silent":10,"mode_5_silent":10,"pro_10_silent":17,"pro_10_sound":16,"pro_5_silent":15,"pro_5_sound":14,"std_10_silent":13,"std_10_sound":12,"std_5_silent":11,"std_5_sound":10},"api_key_type":""},"luma":{"provider":"luma","model":"luma","power_config":{"10_1080P":25,"10_720P":20,"5_1080P":15,"5_720P":10,"fixed":10},"api_key_type":""},"sora-2":{"provider":"sora","model":"sora-2","power_config":{"10_1280x720":12,"10_720x1280":15,"5_1280x720":10,"5_720x1280":11,"fixed":10},"api_key_type":""},"sora-2-pro":{"provider":"sora","model":"sora-2-pro","power_config":{"15_1024x1792":13,"15_1280x720":10,"15_1792x1024":12,"15_720x1280":11,"25_1024x1792":17,"25_1280x720":14,"25_1792x1024":16,"25_720x1280":15,"fixed":250},"api_key_type":""},"veo3.1":{"provider":"veo","model":"veo3.1","power_config":{"fixed":10},"api_key_type":""},"veo3.1-components":{"provider":"veo","model":"veo3.1-components","power_config":{"fixed":20},"api_key_type":""},"veo3.1-fast":{"provider":"veo","model":"veo3.1-fast","power_config":{"fixed":10},"api_key_type":""},"veo3.1-pro":{"provider":"veo","model":"veo3.1-pro","power_config":{"fixed":15},"api_key_type":""},"wan2.5-i2v-preview":{"provider":"wan","model":"wan2.5-i2v-preview","power_config":{"10_1080P":15,"10_1080x1920":10,"10_1280x720":10,"10_1920x1080":10,"10_480P":10,"10_720P":12,"10_720x1280":10,"5_1080P":10,"5_1080x1920":10,"5_1280x720":10,"5_1920x1080":10,"5_480P":10,"5_720P":10,"5_720x1280":10},"api_key_type":""},"wan2.6-i2v":{"provider":"wan","model":"wan2.6-i2v","power_config":{"10_1080P":13,"10_1080x1920":10,"10_1280x720":10,"10_1920x1080":10,"10_720P":12,"10_720x1280":10,"15_1080P":14,"15_1080x1920":10,"15_1280x720":10,"15_1920x1080":10,"15_720P":14,"15_720x1280":10,"5_1080P":11,"5_1080x1920":10,"5_1280x720":10,"5_1920x1080":10,"5_720P":20,"5_720x1280":10},"api_key_type":""},"wan2.6-i2v-flash":{"provider":"wan","model":"wan2.6-i2v-flash","power_config":{"10_1080P":12,"10_1080x1920":10,"10_1280x720":10,"10_1920x1080":10,"10_720P":11,"10_720x1280":10,"15_1080P":10,"15_1080x1920":10,"15_1280x720":10,"15_1920x1080":10,"15_720P":12,"15_720x1280":10,"5_1080P":13,"5_1080x1920":10,"5_1280x720":10,"5_1920x1080":10,"5_720P":14,"5_720x1280":10},"api_key_type":""}}}'),
(28, 'ppt', '{"outline_llm_api_url":"https://api2.geekai.me/v1/chat/completions","outline_llm_api_key":"","outline_llm_model":"gpt-5.5","max_slides_per_task":100,"power_cost_per_slide":20,"max_concurrent_requests":50,"qps_limit":100,"image_api_url":"https://api2.geekai.me/v1","image_api_key":"","image_models":[{"name":"香蕉 2","value":"gemini-3.1-flash-image-preview"},{"name":"GPT-Image-2","value":"gpt-image-2"}],"image_default_model":"gpt-image-2","image_aspect_ratio":"16:9"}'),
(29, 'wx_gzh_menu', '{"button":[{"type":"view","name":"AI对话","url":"https://chat.geekai.me"},{"type":"view","name":"AI 智能体2","url":"https://agent.geekai.me"},{"type":"view","name":"官方文档","url":"https://docs.geekai.me"}]}');

-- --------------------------------------------------------

--
-- 表的结构 `geekai_dall_jobs`
--

DROP TABLE IF EXISTS `geekai_dall_jobs`;
CREATE TABLE `geekai_dall_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL COMMENT '用户ID',
  `prompt` text NOT NULL COMMENT '提示词',
  `task_info` text NOT NULL COMMENT '任务详情',
  `img_url` varchar(255) NOT NULL COMMENT '图片地址',
  `org_url` varchar(1024) DEFAULT NULL COMMENT '原图地址',
  `publish` tinyint(1) NOT NULL COMMENT '是否发布',
  `power` smallint NOT NULL COMMENT '消耗算力',
  `progress` smallint NOT NULL COMMENT '任务进度',
  `err_msg` varchar(1024) NOT NULL COMMENT '错误信息',
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- 表的结构 `geekai_files`
--

DROP TABLE IF EXISTS `geekai_files`;
CREATE TABLE `geekai_files` (
  `id` int NOT NULL,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件名',
  `obj_key` varchar(512) DEFAULT NULL COMMENT '文件标识',
  `url` varchar(512) NOT NULL COMMENT '文件地址',
  `ext` varchar(10) NOT NULL COMMENT '文件后缀',
  `size` bigint NOT NULL DEFAULT '0' COMMENT '文件大小',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `category` varchar(20) NOT NULL DEFAULT 'other' COMMENT '资源分类',
  `source` varchar(20) NOT NULL DEFAULT 'upload' COMMENT '来源 upload/generated',
  `ref_kind` varchar(40) DEFAULT NULL COMMENT '业务引用类型',
  `ref_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT '业务表主键'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户文件表';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_functions`
--

DROP TABLE IF EXISTS `geekai_functions`;
CREATE TABLE `geekai_functions` (
  `id` int NOT NULL,
  `name` varchar(30) NOT NULL COMMENT '函数名称',
  `label` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '函数标签',
  `description` varchar(255) DEFAULT NULL COMMENT '函数描述',
  `parameters` text COMMENT '函数参数（JSON）',
  `token` varchar(255) DEFAULT NULL COMMENT 'API授权token',
  `action` varchar(255) DEFAULT NULL COMMENT '函数处理 API',
  `enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用',
  `power` int NOT NULL DEFAULT '0' COMMENT '消费算力点数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='函数插件表';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_image_jobs`
--

DROP TABLE IF EXISTS `geekai_image_jobs`;
CREATE TABLE `geekai_image_jobs` (
  `id` int NOT NULL,
  `user_id` int NOT NULL COMMENT '用户ID',
  `prompt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '提示词',
  `params` text NOT NULL COMMENT '任务参数',
  `img_url` varchar(255) NOT NULL COMMENT '图片地址',
  `org_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '原图地址',
  `publish` tinyint(1) NOT NULL COMMENT '是否发布',
  `power` smallint NOT NULL COMMENT '消耗算力',
  `progress` smallint NOT NULL COMMENT '任务进度',
  `err_msg` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '错误信息',
  `created_at` datetime NOT NULL,
  `task_id` varchar(64) DEFAULT NULL COMMENT 'Kapon 异步任务 ID',
  `status` varchar(20) DEFAULT 'pending' COMMENT '任务状态:pending,in_progress,downloading,success,failed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='DALLE 绘图任务表';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_invite_codes`
--

DROP TABLE IF EXISTS `geekai_invite_codes`;
CREATE TABLE `geekai_invite_codes` (
  `id` int NOT NULL,
  `user_id` int NOT NULL COMMENT '用户ID',
  `code` char(8) NOT NULL COMMENT '邀请码',
  `hits` bigint NOT NULL COMMENT '点击次数',
  `reg_num` smallint NOT NULL COMMENT '注册数量',
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户邀请码';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_invite_logs`
--

DROP TABLE IF EXISTS `geekai_invite_logs`;
CREATE TABLE `geekai_invite_logs` (
  `id` int NOT NULL,
  `inviter_id` int NOT NULL COMMENT '邀请人ID',
  `user_id` int NOT NULL COMMENT '注册用户ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `invite_code` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邀请码',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注',
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='邀请注册日志';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_jimeng_jobs`
--

DROP TABLE IF EXISTS `geekai_jimeng_jobs`;
CREATE TABLE `geekai_jimeng_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL COMMENT '用户ID',
  `task_id` varchar(100) NOT NULL COMMENT '任务ID',
  `type` varchar(50) NOT NULL COMMENT '任务类型',
  `req_key` varchar(100) DEFAULT NULL COMMENT '请求Key',
  `prompt` text COMMENT '提示词',
  `params` text COMMENT '任务参数JSON',
  `img_url` varchar(1024) DEFAULT NULL COMMENT '图片或封面URL',
  `video_url` varchar(1024) DEFAULT NULL COMMENT '视频URL',
  `raw_data` text COMMENT '原始API响应',
  `progress` bigint DEFAULT '0' COMMENT '进度百分比',
  `status` varchar(20) DEFAULT 'pending' COMMENT '任务状态',
  `err_msg` varchar(1024) DEFAULT NULL COMMENT '错误信息',
  `power` int DEFAULT '0' COMMENT '消耗算力',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- 表的结构 `geekai_menus`
--

DROP TABLE IF EXISTS `geekai_menus`;
CREATE TABLE `geekai_menus` (
  `id` int NOT NULL,
  `name` varchar(30) NOT NULL COMMENT '菜单名称',
  `icon` varchar(150) NOT NULL COMMENT '菜单图标',
  `url` varchar(100) NOT NULL COMMENT '地址',
  `sort_num` smallint NOT NULL COMMENT '排序',
  `enabled` tinyint(1) NOT NULL COMMENT '是否启用'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='前端菜单表';

--
-- 转存表中的数据 `geekai_menus`
--

INSERT INTO `geekai_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES
(1, 'AI 对话', 'icon-chat', '/chat', 1, 1),
(5, 'MJ 绘画', 'icon-mj', '/mj', 2, 1),
(8, 'AIPPT', 'icon-ppt', '/ppt', 10, 1),
(9, '画廊', 'icon-image', '/gallery', 5, 1),
(12, '思维导图', 'icon-xmind', '/xmind', 9, 1),
(13, 'AI 绘图', 'icon-chuangzuo', '/image', 4, 1),
(14, '项目文档', 'icon-folder', '/resources', 14, 1),
(19, 'Suno', 'icon-suno', '/suno', 6, 1),
(20, 'AI视频', 'icon-video', '/video', 7, 1),
(21, '即梦 AI', 'icon-jimeng2', '/jimeng', 8, 1),
(23, 'AI3D', 'icon-cube', '/ai3d', 11, 1);

-- --------------------------------------------------------

--
-- 表的结构 `geekai_mj_jobs`
--

DROP TABLE IF EXISTS `geekai_mj_jobs`;
CREATE TABLE `geekai_mj_jobs` (
  `id` int NOT NULL,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `task_id` varchar(20) DEFAULT NULL COMMENT '任务 ID',
  `task_info` text NOT NULL COMMENT '任务详情',
  `type` varchar(20) DEFAULT 'image' COMMENT '任务类别',
  `message_id` char(40) NOT NULL COMMENT '消息 ID',
  `channel_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '频道ID',
  `reference_id` char(40) DEFAULT NULL COMMENT '引用消息 ID',
  `prompt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会话提示词',
  `img_url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片URL',
  `org_url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '原始图片地址',
  `hash` varchar(100) DEFAULT NULL COMMENT 'message hash',
  `progress` smallint DEFAULT '0' COMMENT '任务进度',
  `use_proxy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否使用反代',
  `publish` tinyint(1) NOT NULL COMMENT '是否发布',
  `err_msg` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '错误信息',
  `power` smallint NOT NULL DEFAULT '0' COMMENT '消耗算力',
  `created_at` datetime NOT NULL,
  `status` varchar(20) DEFAULT 'pending' COMMENT '任务状态:pending,in_progress,downloading,success,failed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='MidJourney 任务表';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_moderation`
--

DROP TABLE IF EXISTS `geekai_moderation`;
CREATE TABLE `geekai_moderation` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL COMMENT '用户ID',
  `source` varchar(255) NOT NULL COMMENT '敏感词来源',
  `input` text NOT NULL COMMENT '用户输入',
  `output` text NOT NULL COMMENT 'AI 输出',
  `result` text NOT NULL COMMENT '鉴别结果',
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- 表的结构 `geekai_orders`
--

DROP TABLE IF EXISTS `geekai_orders`;
CREATE TABLE `geekai_orders` (
  `id` int NOT NULL,
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `product_id` bigint NOT NULL COMMENT '产品ID',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `order_no` varchar(30) NOT NULL COMMENT '订单ID',
  `trade_no` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '支付平台交易流水号',
  `subject` varchar(100) NOT NULL COMMENT '订单产品',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单金额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单状态（0：待支付，1：已扫码，2：支付成功）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注',
  `pay_time` int DEFAULT NULL COMMENT '支付时间',
  `pay_way` varchar(20) NOT NULL COMMENT '支付方式',
  `channel` varchar(30) NOT NULL COMMENT '支付类型渠道：支付宝，微信，聚合支付',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `checked` tinyint NOT NULL DEFAULT '0' COMMENT '是否已检查'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='充值订单表';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_power_logs`
--

DROP TABLE IF EXISTS `geekai_power_logs`;
CREATE TABLE `geekai_power_logs` (
  `id` int NOT NULL,
  `user_id` int NOT NULL COMMENT '用户ID',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `type` tinyint(1) NOT NULL COMMENT '类型（1：充值，2：消费，3：退费）',
  `amount` smallint NOT NULL COMMENT '算力数值',
  `balance` bigint NOT NULL COMMENT '余额',
  `model` varchar(255) NOT NULL COMMENT '模型',
  `remark` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注',
  `mark` tinyint(1) NOT NULL COMMENT '资金类型（0：支出，1：收入）',
  `created_at` datetime NOT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户算力消费日志';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_ppt_jobs`
--

DROP TABLE IF EXISTS `geekai_ppt_jobs`;
CREATE TABLE `geekai_ppt_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `task_id` varchar(64) NOT NULL COMMENT '任务 ID',
  `user_id` int NOT NULL COMMENT '用户 ID',
  `status` varchar(32) NOT NULL DEFAULT 'pending' COMMENT '任务状态 draft,pending,in_progress,success,failed',
  `err_msg` varchar(1024) DEFAULT NULL COMMENT '错误信息',
  `prompt` text COMMENT '用户补充提示',
  `content` text NOT NULL COMMENT 'PPT 内容大纲',
  `params` text COMMENT '生成参数 JSON(语言,生成模式,页数,生图模型)',
  `slides` mediumtext COMMENT '生成的幻灯片列表 JSON',
  `total_slides` int DEFAULT '0' COMMENT '总页数',
  `completed_slides` int DEFAULT '0' COMMENT '已完成页数',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `title` varchar(256) DEFAULT '' COMMENT '列表展示标题(LLM)',
  `thumb` varchar(1024) DEFAULT '' COMMENT '列表缩略图 URL',
  `power` int NOT NULL DEFAULT '0' COMMENT '消耗算力(累计扣减)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- 表的结构 `geekai_products`
--

DROP TABLE IF EXISTS `geekai_products`;
CREATE TABLE `geekai_products` (
  `id` int NOT NULL,
  `name` varchar(30) NOT NULL COMMENT '名称',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `power` bigint NOT NULL DEFAULT '0' COMMENT '增加算力值',
  `enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启动',
  `sales` bigint NOT NULL DEFAULT '0' COMMENT '销量',
  `sort_num` tinyint NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `stripe_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Stripe价格'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='会员套餐表';

--
-- 转存表中的数据 `geekai_products`
--

INSERT INTO `geekai_products` (`id`, `name`, `price`, `power`, `enabled`, `sales`, `sort_num`, `created_at`, `updated_at`, `stripe_price`) VALUES
(5, '100次点卡', 0.20, 100, 1, 0, 0, '2023-08-28 10:55:08', '2026-04-23 06:10:42', 0.20),
(6, '200次点卡', 19.90, 200, 1, 0, 0, '1970-01-01 08:00:00', '2026-04-23 06:10:42', 19.90);

-- --------------------------------------------------------

--
-- 表的结构 `geekai_redeems`
--

DROP TABLE IF EXISTS `geekai_redeems`;
CREATE TABLE `geekai_redeems` (
  `id` int NOT NULL,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `name` varchar(30) NOT NULL COMMENT '兑换码名称',
  `power` bigint NOT NULL COMMENT '算力',
  `code` varchar(100) NOT NULL COMMENT '兑换码',
  `enabled` tinyint(1) NOT NULL COMMENT '是否启用',
  `created_at` datetime NOT NULL,
  `redeemed_at` bigint NOT NULL COMMENT '兑换时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='兑换码';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_suno_jobs`
--

DROP TABLE IF EXISTS `geekai_suno_jobs`;
CREATE TABLE `geekai_suno_jobs` (
  `id` int NOT NULL,
  `user_id` bigint NOT NULL COMMENT '用户 ID',
  `channel` varchar(100) NOT NULL COMMENT '渠道',
  `title` varchar(100) DEFAULT NULL COMMENT '歌曲标题',
  `type` tinyint(1) DEFAULT '0' COMMENT '任务类型,1:灵感创作,2:自定义创作',
  `task_id` varchar(50) DEFAULT NULL COMMENT '任务 ID',
  `params` text COMMENT '任务参数',
  `ref_task_id` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '引用任务 ID',
  `song_id` varchar(50) DEFAULT NULL COMMENT '要续写的歌曲 ID',
  `ref_song_id` varchar(50) NOT NULL COMMENT '引用的歌曲ID',
  `prompt` varchar(2000) NOT NULL COMMENT '提示词',
  `cover_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '封面图地址',
  `audio_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '音频地址',
  `progress` smallint DEFAULT '0' COMMENT '任务进度',
  `duration` smallint NOT NULL DEFAULT '0' COMMENT '歌曲时长',
  `publish` tinyint(1) NOT NULL COMMENT '是否发布',
  `err_msg` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '错误信息',
  `output` text COMMENT '原始输出数据',
  `power` smallint NOT NULL DEFAULT '0' COMMENT '消耗算力',
  `play_times` bigint DEFAULT NULL COMMENT '播放次数',
  `created_at` datetime NOT NULL,
  `status` varchar(20) DEFAULT 'pending' COMMENT '任务状态:pending,in_progress,downloading,success,failed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='MidJourney 任务表';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_users`
--

DROP TABLE IF EXISTS `geekai_users`;
CREATE TABLE `geekai_users` (
  `id` int NOT NULL,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `mobile` char(11) DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱地址',
  `nickname` varchar(30) NOT NULL COMMENT '昵称',
  `password` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '头像',
  `salt` char(12) NOT NULL COMMENT '密码盐',
  `power` bigint NOT NULL DEFAULT '0' COMMENT '剩余算力',
  `expired_time` bigint NOT NULL COMMENT '用户过期时间',
  `status` tinyint(1) NOT NULL COMMENT '当前状态',
  `chat_config_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '聊天配置json',
  `chat_models_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'AI模型 json',
  `last_login_at` bigint NOT NULL COMMENT '最后登录时间',
  `vip` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否会员',
  `last_login_ip` char(32) NOT NULL COMMENT '最后登录 IP',
  `openid` varchar(100) DEFAULT NULL COMMENT '第三方登录账号ID',
  `platform` varchar(30) DEFAULT NULL COMMENT '登录平台',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `gem_ids_json` text COMMENT '用户固定的智能体ID列表(JSON数组)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

--
-- 转存表中的数据 `geekai_users`
--

INSERT INTO `geekai_users` (`id`, `username`, `mobile`, `email`, `nickname`, `password`, `avatar`, `salt`, `power`, `expired_time`, `status`, `chat_config_json`, `chat_models_json`, `last_login_at`, `vip`, `last_login_ip`, `openid`, `platform`, `created_at`, `updated_at`, `gem_ids_json`) VALUES
(4, '18888888888', '18575670126', '', '极客学长', 'ccc3fb7ab61b8b5d096a4a166ae21d121fc38c71bbd1be6173d9ab973214a63b', 'http://nk.img.r9it.com/1774702361068828.png', 'ueedue5l', 9951, 0, 1, '{\"api_keys\":{\"Azure\":\"\",\"ChatGLM\":\"\",\"OpenAI\":\"\"}}', '[1]', 1779058779, 1, '::1', '', NULL, '2023-06-12 16:47:17', '2026-05-18 06:59:39', '[25,24,136,28,26,35,37,38]'),
(47, 'user1', '', '', '极客学长@202752', '4d3e57a01ae826531012e4ea6e17cbc45fea183467abe9813c379fb84916fb0a', '/images/avatar/user.png', 'ixl0nqa6', 300, 0, 1, '', '', 0, 0, '', '', '', '2024-12-24 11:37:16', '2024-12-24 11:37:16', NULL),
(48, 'wx@3659838859', '', '', '极客学长', 'cf6bbe381b23812d2b9fd423abe74003cecdd3b93809896eb573536ba6c500b3', 'https://thirdwx.qlogo.cn/mmopen/vi_32/uyxRMqZcEkb7fHouKXbNzxrnrvAttBKkwNlZ7yFibibRGiahdmsrZ3A1NKf8Fw5qJNJn4TXRmygersgEbibaSGd9Sg/132', '5rsy4iwg', 100, 0, 1, '', '', 1736228927, 0, '172.22.11.200', 'oCs0t62472W19z2LOEKI1rWyCTTA', '', '2025-01-07 13:43:06', '2025-01-07 13:48:48', NULL),
(49, 'wx@9502480897', '', '', 'AI探索君', 'd99fa8ba7da1455693b40e11d894a067416e758af2a75d7a3df4721b76cdbc8c', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Zpcln1FZjcKxqtIyCsOTLGn16s7uIvwWfdkdsW6gbZg4r9sibMbic4jvrHmV7ux9nseTB5kBSnu1HSXr7zB8rTXg/132', 'fjclgsli', 100, 0, 1, '', 'null', 0, 0, '', 'oCs0t64FaOLfiTbHZpOqk3aUp_94', '', '2025-01-07 14:05:31', '2025-09-20 16:53:40', NULL),
(50, 'user01', '', '', '极客学长@195842', 'df5d50d639fb67e891a4974b323770e6e3dc0c672479450b1c3808361af37c93', '/images/avatar/user.png', 'pafz75gk', 3000, 0, 1, '{}', '[1]', 0, 0, '', '', '', '2025-08-04 21:28:35', '2025-08-11 17:23:26', NULL),
(54, '18575670125', '18575670125', '', '用户@189706', 'f440bf41396f3f4df4d2feffb58670044d67005bfba4bde36b73d4206bd1e1a1', '/images/avatar/user.png', '553gpql0', 4010, 0, 1, '{}', '[64]', 1757233140, 0, '::1', '', '', '2025-09-07 16:19:01', '2025-09-19 12:10:39', NULL),
(55, 'wx@97706373', '', '', '极客学长', '7890021c92fdf508384c5c67c5260374b1a54605e1e4e244adb7f4c80a01a149', 'https://thirdwx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEIEiaibDJwRric4oYfCXdWzMfyeS993MkQGGXLv4PRVibIQ5dlmKVnb24PuqAd2lX4BGpT2nHjPA5z5ef2A9u2B7txz6R0gehxSjF53mQBDlsOQHQ/132', 'n8kdu43d', 1096, 1764345600, 1, '{}', '[64]', 1767362490, 0, '::1', 'oPyyL6iIjHa--j75ddSwjq2xKG_s', 'wechat', '2025-09-20 11:27:48', '2026-01-02 22:01:31', NULL),
(63, 'user3', '', '', '用户@851145', '33e4835fcaa8f4373c69cbaf581fbdcd52bdb41d719c5db9de0c30e69af2a389', '/images/avatar/user.png', 'gt3kuyxi', 2099, 0, 1, '{}', 'null', 1758891085, 0, '::1', '', '', '2025-09-26 20:51:25', '2025-10-04 11:56:20', NULL),
(64, 'wx@21572732', '', '', 'AI探索君', '31f9320c1407709759d47c8c15b8f586b150d806cfc26cf83caa14496f5eb4ee', 'https://thirdwx.qlogo.cn/mmopen/vi_32/sZe2dFGvTbn9Ey0UIiaedTSPR1O4eZGOOx9Ev8BR7kqk6AeINkNdqOWEI1nHA8hltuYL6mOtVU31wuR2OVxd6vA/132', '9cjr8nub', 10, 0, 1, '{}', '{}', 1767362532, 0, '::1', 'oPyyL6v9UKmvWsk7W9GfzVlIuZiY', 'wechat', '2026-01-02 22:02:12', '2026-01-02 22:02:12', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `geekai_user_login_logs`
--

DROP TABLE IF EXISTS `geekai_user_login_logs`;
CREATE TABLE `geekai_user_login_logs` (
  `id` int NOT NULL,
  `user_id` int NOT NULL COMMENT '用户ID',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `login_ip` char(32) NOT NULL COMMENT '登录IP',
  `login_address` varchar(30) NOT NULL COMMENT '登录地址',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户登录日志';

-- --------------------------------------------------------

--
-- 表的结构 `geekai_video_jobs`
--

DROP TABLE IF EXISTS `geekai_video_jobs`;
CREATE TABLE `geekai_video_jobs` (
  `id` int NOT NULL,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `channel` varchar(100) NOT NULL COMMENT '渠道',
  `task_id` varchar(100) NOT NULL COMMENT '任务 ID',
  `params` text COMMENT '视频任务参数 JSON',
  `type` varchar(20) DEFAULT NULL COMMENT '任务类型,luma,runway,cogvideo',
  `prompt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '提示词',
  `video_url` varchar(2000) NOT NULL COMMENT '视频地址',
  `progress` smallint DEFAULT '0' COMMENT '任务进度(0-100)',
  `publish` tinyint(1) NOT NULL COMMENT '是否发布',
  `err_msg` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '错误信息',
  `output` text COMMENT '任务输出的原始信息',
  `power` smallint NOT NULL DEFAULT '0' COMMENT '消耗算力',
  `created_at` datetime NOT NULL,
  `status` varchar(20) DEFAULT 'pending' COMMENT '任务状态:pending,in_progress,downloading,success,failed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='MidJourney 任务表';

--
-- 转储表的索引
--

--
-- 表的索引 `geekai_3d_jobs`
--
ALTER TABLE `geekai_3d_jobs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_admin_users`
--
ALTER TABLE `geekai_admin_users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `username` (`username`) USING BTREE,
  ADD UNIQUE KEY `idx_chatgpt_admin_users_username` (`username`),
  ADD UNIQUE KEY `idx_geekai_admin_users_username` (`username`);

--
-- 表的索引 `geekai_api_keys`
--
ALTER TABLE `geekai_api_keys`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_chat_history`
--
ALTER TABLE `geekai_chat_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_id` (`chat_id`),
  ADD KEY `idx_chatgpt_chat_history_chat_id` (`chat_id`),
  ADD KEY `idx_chatgpt_chat_history_user_id` (`user_id`),
  ADD KEY `idx_geekai_chat_history_user_id` (`user_id`),
  ADD KEY `idx_geekai_chat_history_chat_id` (`chat_id`);

--
-- 表的索引 `geekai_chat_items`
--
ALTER TABLE `geekai_chat_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `chat_id` (`chat_id`),
  ADD UNIQUE KEY `idx_chatgpt_chat_items_chat_id` (`chat_id`),
  ADD UNIQUE KEY `idx_geekai_chat_items_chat_id` (`chat_id`);

--
-- 表的索引 `geekai_chat_models`
--
ALTER TABLE `geekai_chat_models`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_chat_roles`
--
ALTER TABLE `geekai_chat_roles`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_configs`
--
ALTER TABLE `geekai_configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `idx_chatgpt_configs_name` (`name`),
  ADD UNIQUE KEY `idx_geekai_configs_name` (`name`);

--
-- 表的索引 `geekai_dall_jobs`
--
ALTER TABLE `geekai_dall_jobs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_files`
--
ALTER TABLE `geekai_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_geekai_files_category` (`category`);

--
-- 表的索引 `geekai_functions`
--
ALTER TABLE `geekai_functions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `idx_chatgpt_functions_name` (`name`),
  ADD UNIQUE KEY `idx_geekai_functions_name` (`name`);

--
-- 表的索引 `geekai_image_jobs`
--
ALTER TABLE `geekai_image_jobs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_invite_codes`
--
ALTER TABLE `geekai_invite_codes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `idx_chatgpt_invite_codes_code` (`code`),
  ADD UNIQUE KEY `idx_geekai_invite_codes_code` (`code`);

--
-- 表的索引 `geekai_invite_logs`
--
ALTER TABLE `geekai_invite_logs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_jimeng_jobs`
--
ALTER TABLE `geekai_jimeng_jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_chatgpt_jimeng_jobs_task_id` (`task_id`),
  ADD KEY `idx_chatgpt_jimeng_jobs_user_id` (`user_id`),
  ADD KEY `idx_geekai_jimeng_jobs_user_id` (`user_id`),
  ADD KEY `idx_geekai_jimeng_jobs_task_id` (`task_id`);

--
-- 表的索引 `geekai_menus`
--
ALTER TABLE `geekai_menus`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_mj_jobs`
--
ALTER TABLE `geekai_mj_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `task_id` (`task_id`),
  ADD UNIQUE KEY `idx_chatgpt_mj_jobs_task_id` (`task_id`),
  ADD UNIQUE KEY `idx_geekai_mj_jobs_task_id` (`task_id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `idx_chatgpt_mj_jobs_message_id` (`message_id`),
  ADD KEY `idx_geekai_mj_jobs_message_id` (`message_id`);

--
-- 表的索引 `geekai_moderation`
--
ALTER TABLE `geekai_moderation`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_orders`
--
ALTER TABLE `geekai_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_no` (`order_no`),
  ADD UNIQUE KEY `idx_chatgpt_orders_order_no` (`order_no`),
  ADD UNIQUE KEY `idx_geekai_orders_order_no` (`order_no`);

--
-- 表的索引 `geekai_power_logs`
--
ALTER TABLE `geekai_power_logs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_ppt_jobs`
--
ALTER TABLE `geekai_ppt_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_geekai_ppt_jobs_task_id` (`task_id`),
  ADD KEY `idx_geekai_ppt_jobs_user_id` (`user_id`);

--
-- 表的索引 `geekai_products`
--
ALTER TABLE `geekai_products`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_redeems`
--
ALTER TABLE `geekai_redeems`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD UNIQUE KEY `idx_chatgpt_redeems_code` (`code`),
  ADD UNIQUE KEY `idx_geekai_redeems_code` (`code`);

--
-- 表的索引 `geekai_suno_jobs`
--
ALTER TABLE `geekai_suno_jobs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_users`
--
ALTER TABLE `geekai_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `idx_chatgpt_users_username` (`username`),
  ADD UNIQUE KEY `idx_geekai_users_username` (`username`);

--
-- 表的索引 `geekai_user_login_logs`
--
ALTER TABLE `geekai_user_login_logs`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `geekai_video_jobs`
--
ALTER TABLE `geekai_video_jobs`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `geekai_3d_jobs`
--
ALTER TABLE `geekai_3d_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_admin_users`
--
ALTER TABLE `geekai_admin_users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- 使用表AUTO_INCREMENT `geekai_api_keys`
--
ALTER TABLE `geekai_api_keys`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_chat_history`
--
ALTER TABLE `geekai_chat_history`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_chat_items`
--
ALTER TABLE `geekai_chat_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_chat_models`
--
ALTER TABLE `geekai_chat_models`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- 使用表AUTO_INCREMENT `geekai_chat_roles`
--
ALTER TABLE `geekai_chat_roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_configs`
--
ALTER TABLE `geekai_configs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- 使用表AUTO_INCREMENT `geekai_dall_jobs`
--
ALTER TABLE `geekai_dall_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_files`
--
ALTER TABLE `geekai_files`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_functions`
--
ALTER TABLE `geekai_functions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_image_jobs`
--
ALTER TABLE `geekai_image_jobs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_invite_codes`
--
ALTER TABLE `geekai_invite_codes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_invite_logs`
--
ALTER TABLE `geekai_invite_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_jimeng_jobs`
--
ALTER TABLE `geekai_jimeng_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_menus`
--
ALTER TABLE `geekai_menus`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- 使用表AUTO_INCREMENT `geekai_mj_jobs`
--
ALTER TABLE `geekai_mj_jobs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_moderation`
--
ALTER TABLE `geekai_moderation`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_orders`
--
ALTER TABLE `geekai_orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_power_logs`
--
ALTER TABLE `geekai_power_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_ppt_jobs`
--
ALTER TABLE `geekai_ppt_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_products`
--
ALTER TABLE `geekai_products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用表AUTO_INCREMENT `geekai_redeems`
--
ALTER TABLE `geekai_redeems`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_suno_jobs`
--
ALTER TABLE `geekai_suno_jobs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_users`
--
ALTER TABLE `geekai_users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- 使用表AUTO_INCREMENT `geekai_user_login_logs`
--
ALTER TABLE `geekai_user_login_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `geekai_video_jobs`
--
ALTER TABLE `geekai_video_jobs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
