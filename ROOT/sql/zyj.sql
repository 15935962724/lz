
-- 添加排序字段
alter table procurementunit add sort int default 0;

-- 添加医院,厂商关联表
create table hospitals_join(
puid int,
hid int
);

-- 短信提醒表  添加厂商关联字段
alter table ShopSMSSetting add puid int;

-- 医院添加医院编号
alter table shopHospital add h_code varchar(50);

-- 更改全部订单关联厂商为欣科(19041186)
update shopOrder set puid=19041186 where id in(select id from shopOrder);

-- 君安公司活度库存表
create table productStock(
  psid int not null PRIMARY KEY,
  cid int,
  quality varchar(50),
  batch varchar(50),
  activity float,
  amount int,
  createtime datetime
);


alter table ProductStock add time datetime;

alter table ProductStock add ordernum int;

-- 添加君安公司活度表 预留数量字段
alter table productStock add reserve int;

-- 服务费发票管理表
create table serviceCharge(
  sid int not null PRIMARY KEY,
  invoiceCode varchar(50),
  profile int,
  money float,
  time datetime
);

-- 服务商服务费发票管理添加 厂商关联id
alter table serviceCharge add puid int;

-- 服务商服务费发票管理添加 记录id



-- 服务商服务费发票管理添加 类型 0,新增 1,结余 默认为新增
alter table serviceCharge add type int default 0;

-- 服务商服务费发票管理添加 状态 0,未使用 1,已使用 默认未使用
alter table serviceCharge add state int default 0;

-- 库存操作记录表
create table stockOperation(
  soid int not null PRIMARY KEY,-- id
  time datetime,                -- 时间
  psid int,                     -- 库存id
  cid int,                      -- 类别id
  activity float,               -- 真实活度
  amount int,                   -- 数量
  type int,                     -- 类型 0减 1加 2录入 3修改 4删除
  state int,                     -- 状态 1,查库存和预留   0,只查库存
  member int,                   -- 操作人
  oid int,                      -- 订单id
  describe varchar(200)        -- 描述
);
-- 库存操记录表添加预留数量字段
alter table stockOperation add reserve int;

-- 库存操记录表添加有效期字段
alter table stockOperation add valid datetime;

-- 库存操作记录表添加是否退单 0,未退 1,已退
alter table stockOperation add isRetreat int DEFAULT 0;

-- 匹配服务费记录表
create table serviceFeeRecord(
  fid int not null PRIMARY KEY, --id
  profile int,                  --服务商id
  totalMoney float,             --发票总金额
  invoiceArray varchar(200),    --发票id集合
  describe varchar(200),        --描述
  time datetime,                --时间
  member int,                   --操作人
  puid int                      --厂商id
);

-- 服务费详细表
create table serviceFeeInfo(
  zid int not null PRIMARY KEY ,  --id
  fid int,                        --父表id
  oid int,                        --订单id
  money float                     --计提服务费=税金+服务费
);
-- 发票表添加匹配状态 0,未匹配  1,已匹配
alter table invoice add mateType int default 0;

-- 服务费详细表 添加税金类型,税金
alter table serviceFeeInfo add tax int;
alter table serviceFeeInfo add taxMoney float;


-- 库存操作记录表添加校准时间
alter table stockOperation add calibrationtime datetime;

-- 普通用户升级记录
create table upProfile(
  upid int not null PRIMARY KEY , --id
  profile int,                    --用户id
  uptype int,                     --升级类型 0:服务商 1:vip
  business int,                   --营业执照
  license int,                    --开户许可证
  other int,                      --其他材料
  state INT,                      --申请状态 0:申请 1:成功 2:失败
  uptime datetime,                --申请升级时间
  extime DATETIME,                --审核时间
  member int,                     --审核人
  describe varchar(200)           --描述
);

-- 用户升级记录添加邮件字段
alter table upProfile add email varchar(200);
alter table upProfile add company varchar(200);

-- 服务商医院授权申请记录
create table empowerRecord(
  eid int not null PRIMARY KEY ,  --id
  upid int,                       --用户升级记录id
  hospital int,                   --医院id
  stateTime DATETIME,             --授权有效期开始时间
  endTime DATETIME,               --授权有效期截止时间
  profile int,                    --服务商id
  client VARCHAR(50),             --委托人
  state INT,                      --授权状态 0:申请 1:成功 2:失败 3:资料完善审核通过
  describe varchar(200),          --描述
  radiation datetime,             --辐射安全许可证正本的截止日期
  credentials INT,                --6种证件
  empowerTime DATETIME,           --申请时间
  examineTime DATETIME,           --审核时间
  perfect INT                     --资料完善审核,审核通过后给医院下单 0: 未提交医院资质   1,提交医院资质未审核  2,提交医院资质审核通过  3,提交医院资质审核不通过
);

-- 服务商医院授权申请记录添加:委托人身份证复印件,辐射安全许可证,辐射安全许可证正本的开始日期,放射诊疗许可证,授权申请书,放射性药品使用许可证,转入/转出审批表,粒子/发票签收人
alter table empowerRecord add clientID int default 0;
alter table empowerRecord add radiationCard int default 0;
alter table empowerRecord add radiate int default 0;
alter table empowerRecord add empower int default 0;
alter table empowerRecord add radiateCard int default 0;
alter table empowerRecord add raditaionStart DATETIME;
alter table empowerRecord add turnApproval int DEFAULT 0;
alter table empowerRecord add signFor int DEFAULT 0;



-- 医院表添加 是否有服务商  是否有vip字段 0,无  1,有
alter table shophospital add upEmpower int default 0;
alter table shophospital add vipEmpower int default 0;

-- 服务商粒子,发票签收人信息
create table signFor(
  sid int not null PRIMARY KEY ,  --id
  eid int,                        --医院授权记录id
  hospital int,                   --医院id
  perfile INT,                    --服务商id
  department int,                 --科室
  signatory VARCHAR(50),          --签收人
  mobile varchar(500),            --手机号
  address varchar(500),           --详细地址
  signType int                    --签收类型 0,粒子 1,发票 2,发票+粒子
);
