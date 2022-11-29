--收货人
create table tb_Consignee(
id int,
name nvarchar(500),
mobile nvarchar(500),
address nvarchar(500),
member int,
youbian nvarchar(500),
city int,
ismoren int
);
--激活码
create table tb_jihuoCode(
id int,
code nvarchar(500),
time DateTime,
usetype int,
type int,
member int
);
--增加邮箱
alter table tb_jihuoCode add mail varchar(500);
alter table tb_Consignee add mail varchar(500);
--激活码使用记录表
create table tb_jihuoUse(
id int,
codeid int,
orderid nvarchar(500),
productid int,
memberid int,
usetime DateTime,
);
--增加激活码类型子类别
alter table tb_jihuoCode add type_child int;
--增加收货人手机端选中列
alter table tb_Consignee add xuanzhong int;
alter table ShopOrder add isbkinvoice int;
alter table serviceCharge add puj_id int;
--会议
create table tb_meeting(
id int,
member int,
create_Data DateTime,
name nvarchar(500),
inform int,
zhaoshang int,
apply int,
type int
);
alter table tb_meeting add cause nvarchar(500);
alter table empowerRecord add contract int;
alter table empowerRecord add company_mail nvarchar(500);
alter table empowerRecord add number_mail nvarchar(500);
alter table upProfile add isdele int ;
alter table shopOrderData add getJihuo int ;
alter table ReplyMoney add add_type int ;
--保存签收人医院名称长度
ALTER TABLE shopOrderAddress ALTER COLUMN hospital VARCHAR(200);
create table tb_emailmessage(
id int,
email nvarchar(500),
time nvarchar(500)
);
alter table procurementunit_join add size nvarchar(500);
alter table procurementunit_join add floorPrice nvarchar(500);

create table tb_creatDetail(
id int,
pid int,
creatpid int
);
create table tb_securityCode(
id int,
pid int,
code int
);
alter table tb_securityCode add nicheng nvarchar(500);
create table tb_NcLzProduct(
id int,
puid int,
activity nvarchar(20),
activityScope nvarchar(20),
status int,
ncCode nvarchar(50),
member int
);
alter table procurementunit_join   add  crmid nvarchar(50);
alter table shopHospital add  hos_code nvarchar(20);
alter table shopHospital add hospiatl_name nvarchar(50);
alter table shopHospital add dep_code nvarchar(20);
alter table shopHospital add departments_name nvarchar(50);
alter table shopOrderData add ncPuidCode nvarchar(20);
alter table shopOrderData add crmOrderId nvarchar(20);

create table tb_modifyRecord (
id int,
order_id nvarchar(20),
content nvarchar(100),
member int,
modifyTime DateTime
);
alter table tb_modifyRecord add contentDetail nvarchar(100);

alter table shopHospital add questionnum int;
create table tb_question(
id int,
orderId nvarchar(20),
beginTime DateTime,
endTime DateTime,
gender int,
age int,
yhjb nvarchar(200),
jws int,
yyyy nvarchar(200),
yply int,
num int,
lhyyqk int,
lhyyqktext nvarchar(200),
sfgs int,
yzqksm nvarchar(200),
blfy int,
blfytext nvarchar(200),
profile int,
hospital_name nvarchar(200),
hospital_ks nvarchar(200),
creatTime DateTime
);

create table tb_agreed(
id int,
creatTime DateTime,
profile int,
myd nvarchar(100),
mydbz nvarchar(4000),
cpxq int,
cpxqsm nvarchar(3000),
idea nvarchar(3000)
)

    alter table profile add parentpro int;

--推送记录
    create table tb_sendlog(
    id int,
    order_id nvarchar(20),
    status int,
    content  nvarchar(500),
    modifyTime DateTime
);

alter table profile add agreednum int;
alter table tb_agreed add companyid int;
alter table tb_agreed add gsdz nvarchar(500);
alter table tb_agreed add cz nvarchar(500);

delete from Areas where name='北京市'
insert into Areas(id,name) values (7180,'北京市');

alter table tb_agreed add type int;

alter table shoporder add issubmitinvoice int;

alter table shopproduct add send_tps_number int;


create table tb_tps_order(
  id int NOT NULL PRIMARY KEY,
  order_id nvarchar(50),
  fws_id int,
  hospital_id int,
  orderms int,
  status int,
  hpcs nvarchar(100),
  xdms nvarchar(100),
  jqm nvarchar(100),
  createtime DateTime,
  jqmtime DateTime,
  sendtime DateTime,
  getjhmtime DateTime,
  jhm nvarchar(100),
  email nvarchar(100),
  consignees_id int,
  send_tps_number int,
  jifen int
);

alter table shopHospital add fsaqxkzrq DateTime;
alter table shopHospital add fsaqxkz int;
alter table shopHospital add fsxypsyxkzrq DateTime;
alter table shopHospital add fsxypsyxkz int;
alter table shopHospital add fszlxkzrq DateTime;
alter table shopHospital add fszlxkz int;
alter table shopHospital add zfspbrq DateTime;
alter table shopHospital add zfspb int;
alter table shopHospital add bq1 nvarchar(100);
alter table shopHospital add bq2 int;
alter table shopHospital add bqmci float;
alter table shopHospital add yjdhyy nvarchar(100);
alter table shopHospital add yjdhlz nvarchar(100);
alter table shopHospital add approvalStatus int;
alter table shopHospital add approvalProfile int;
alter table shopHospital add nobackreason nvarchar(500);

--活度预警
create table activity_warning(
id int NOT NULL PRIMARY KEY,
name nvarchar(50),
warning nvarchar(50),
warning2 nvarchar(50),
stop nvarchar(50),
yjptdh nvarchar(50),
yjyydh nvarchar(50)
);
--流程审批
create table approval_process(
id int NOT NULL PRIMARY KEY,
hid int,
create_profile int,
type int,
approval int,
approval_profile int,
attchid int,
yqlb int,
bq nvarchar(100),
yqrq DateTime,
reason nvarchar(500)
);

alter table approval_process add refuse_reason nvarchar(500);


--流程审批
create table hiddenHospital(
id int NOT NULL PRIMARY KEY,
hospital_name nvarchar(8000)
);

