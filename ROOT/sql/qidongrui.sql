
alter table profile add procurementUnit nvarchar(500);



create table procurementUnit(
puid int,
name nvarchar(500),
time datetime,
img int,
deleted int
);


alter table shoporder add puid int;


alter table ShopExchanged add puid int;


alter table invoice add puid int;



alter table ReplyMoney add puid int;


alter table charge add puid int;


alter table BackInvoice add puid int;


create table procurementunit_join(
jid int,
puid int,
profile int,
company nvarchar(500),
tax int,
formula int,
time datetime
);

alter table shopproduct add puid int;



alter table shopPriceSet add agentPriceNew float;

alter table procurementunit_join add agentPriceNew float;



alter table profile add issalesman int;



alter table ShopOrderExpress add express_img nvarchar(500);


alter table ShopOrder add allocate int;
alter table ShopOrder add allocatetype int;


alter table ShopOrderdata add expectedDelivery datetime;
alter table ShopOrderdata add expectedActivity float;



-- 添加排序字段
alter table procurementunit add fullname nvarchar(500);
alter table procurementunit add fullnameen nvarchar(500);
alter table procurementunit add mobile nvarchar(500);
alter table procurementunit add person nvarchar(500);
alter table procurementunit add email nvarchar(500);
alter table procurementunit add zipcode nvarchar(500);
alter table procurementunit add fax nvarchar(500);


update BackInvoice set puid = 0;
update charge set puid = 0;
update ReplyMoney set puid = 0;
update invoice set puid = 0;
update shoporder set puid = 0;
update ShopExchanged set puid = 0;





alter table procurementunit_join add invoicePuid int;



alter table backinvoice add qianinvoiceid nvarchar(500);
alter table backinvoice add qianamount float;


alter table invoice add deductionstype int;


alter table backinvoice add huanid nvarchar(500);
alter table backinvoice add huanamount float;


alter table backinvoice add applyUnit int;


alter table invoice add applyUnit int;
alter table shoporder add applyUnit int;

update invoice set applyUnit = 0;
update shoporder set applyUnit = 0;

alter table BackInvoice add deductprice float;

create table HangWith(
id int,
rid int,
deductprice float,
time datetime,
member int
);

alter table HangWith add replyPrice float;



create table DeductionRecord(
id int,
bid int,
deductprice float,
iid int,
time datetime
);


alter table BackInvoice add deductionRecordType int;


alter table HangWith add bid int;



alter table ProcurementUnit add address nvarchar(500);
alter table ProcurementUnit add telephone nvarchar(500);
alter table ProcurementUnit add website nvarchar(500);
alter table ProcurementUnit add telephoneReturn nvarchar(500);


alter table Invoice add adjustmentService float;



alter table ShopHospital add invoicePuid int;
alter table ShopHospital add productPuid int;



create table ShopOrderDatasBatches(
id int,
batchnumber varchar(500),
activity float,
number int,
ordercode varchar(500),
soid varchar(500),
time datetime
);



alter table ShopOrderDatasBatches add batchnumbercode int;


create table JaYearConfig(
id int,
year int,
num int
)


alter table serviceFeeRecord add oids varchar(500);


create table ShopBatchesData(
id int,
orderId varchar(500),
psid int,
number int,
time datetime
)


alter table ProcurementUnit_Join add oids varchar(500);


alter table ShopHospital add pid int;


update ShopHospital set pid = 0 where id <> 0;



alter table ShopBatchesData add occupyNumber int;





update ShopHospital set productPuid = 19041186,invoicePuid = 0 where productPuid is null  and addflag = 1;



alter table ShopOrder add orderType int;
alter table ShopOrder add isinvoice int;

alter table ShopOrder add invoiceName varchar(500);
alter table ShopOrder add invoiceDutyParagraph varchar(500);
alter table ShopOrder add invoiceProvinces varchar(500);
alter table ShopOrder add invoiceAddress varchar(500);
alter table ShopOrder add invoiceMobile varchar(500);
alter table ShopOrder add invoiceOpeningBank varchar(500);
alter table ShopOrder add invoiceAccountNumber varchar(500);
alter table ShopOrder add invoiceCostName varchar(500);






alter table ShopOrder add name varchar(500);
alter table ShopOrder add mobile varchar(500);
alter table ShopOrder add city int;
alter table ShopOrder add address varchar(500);
alter table ShopOrder add youbian varchar(500);
alter table ShopOrder add mail varchar(500);


alter table ShopOrder add jhpstastus int;


--alter table ShopOrder add retype int;


create table operationMes(
id int,
member int,
act nvarchar(100),
par nvarchar(1000),
requesturl nvarchar(100),
time datetime
)

alter table ShopOrder add isbatche int;

alter table Invoice add activity nvarchar(100);



















