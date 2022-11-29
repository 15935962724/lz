package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

/**
 * 订单
 * @author guodh
 * */
public class ShopOrder {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private String orderId;			//订单编号
	private int member;				//用户ID
	private Double amount;			//订单金额
	private int payType;			//支付方式payType
	public static String [] payTypeARR= {"无","转账","支付宝","微信"};
	private int payment;			//支付类型 0:汇款；1：支付宝;2手机支付宝；3：块钱；4：块钱手机;5微信
	private Date createDate;		//下单时间
	private Date payTime;			//支付时间
	private int status;				//订单状态    0:未付款;1:确认发货（点击）;2:未出库;3:已出库;4:已完成;5:已取消;6:删除;7:已退货;-1：添加完成检验报告（待验收）;-2:出厂信息验收通过（待入库）;-3:出厂信息验收未通过;-4:出厂信息入库未通过（初审改为验收，复核改为入库）;-5:出厂信息入库通过（待出库）
	private int invoice;			//发票类型
	private String cancelReason;	//取消订单原因
	private boolean isPayment;      //是否付款
	private String remarks;			//备注
	private String userRemarks;		//备注用户
	private int invoiceStatus;      //状态为（0 未索要 1 已索要 2 编辑 3已完成）（0 未开发票  1 已开）
	private boolean isLzCategory;   //是否是粒子
	private String orderUnit;		//订货单位 订单统计查询字段

	private Date receiptTime;       //收货时间
	private String sign_user_openid;//扫码签收人 openid
	private Date askInvoiceDate;
	private Date canceltime;//取消时间
	private int cancelmember;//取消人
	//三期新增字段
	private Date returntime;        //确认退货时间
	private String oldorderid;      //原订单id
	private int noinvoicenum;       //未开票数量
	private float noinvoiceamount;  //未开票金额
	private int isinvoicenum;       //已开票数量
	private float isinvoiceamount;  //已开票金额
	
	private int matchnum;           //已回款粒子数
	
	private int isurged;            //是否已催促 开票0:否 1：是
	private Date urgedtime;         //催促开票时间
	
	private int isurgedreply;       //是否已催促回款 0：否 1：是
	private Date urgedtimereply;    //催促回款时间
	
	private int isclear;            //是否已清理（医院管理中，设置了未开票粒数、应收账款和日期节点后，日期节点（包含）之前的订单都标记为1）0:否 1：是
	private int ishidden;           //是否隐藏   0：否 1：是
	
	private int puid;//厂商id
	
	
	private int allocate;//是否调配 1是
	
	private int allocatetype;//是否同意调配 0同意调配 1不同意调配
	
	private int applyUnit;//医院 0为服务商 其他为医院id

    private int orderType;//订单类型 0粒子 1.tps设备其他 2.植入与设备
    private int isinvoice;//是否开票

    private String invoiceName;//名称
    private String invoiceDutyParagraph;//税号
    private String invoiceProvinces;//地址省
    private String invoiceAddress;//地址
    private String invoiceMobile;//电话
    private String invoiceOpeningBank;//开户行
    private String invoiceAccountNumber;//账号
    private String invoiceCostName;//费用名称


	private String name;//收件人姓名
	private String mobile;//手机号
	private int city;//城市
	private String address;//详细地址
	private String youbian;//邮编
	private String mail;//邮箱

	private int isbkinvoice;//是否补开发票

	private int jhpstastus;//激活码状态 0未发放 1部分成功 2全部成功
	public static String [] jhpstastusARR= {"未发放","部分成功","全部成功"};


	private int retype;//退票类型0实际退货 1需服务商匹配退货

	private int isbatche;//是否跳过分批
	private int issubmitinvoice;//是否可以申请开票    2不可开票


	public ShopOrder(int id){
		this.id = id;
	}
	
	public static ShopOrder find(int id){
		ShopOrder aShopPackage = (ShopOrder)c.get(id);
		if(aShopPackage == null){
			ArrayList<ShopOrder> list = find(" AND id = " + id, 0, 1);
			aShopPackage = list.size() < 1 ? new ShopOrder(id):list.get(0);
		}
		return aShopPackage;
	}
	
	public static ShopOrder findByOrderId(String orderId){
		ArrayList<ShopOrder> list = find(" AND order_id = " + DbAdapter.cite(orderId), 0, 1);
		ShopOrder aShopPackage = list.size() < 1 ? new ShopOrder(0):list.get(0);
		return aShopPackage;
	}
	
	public static ArrayList<ShopOrder> find(String sql,int pos,int size){
		ArrayList<ShopOrder> list = new ArrayList<ShopOrder>();
		DbAdapter db = new DbAdapter();
		String QSql = "select so.id,so.order_id,so.member,so.amount,so.payType,so.payment,so.createdate,so.paytime," +
				"so.status,so.invoice,so.cancelreason,so.isPayment,so.remarks,so.userRemarks,so.invoiceStatus," +
				"so.isLzCategory,so.orderUnit,so.receiptTime,so.sign_user_openid,askInvoiceDate,so.canceltime," +
				"so.cancelmember,so.returntime,so.oldorderid,so.noinvoicenum,so.noinvoiceamount,so.isinvoicenum," +
				"so.isinvoiceamount,so.matchnum,so.isurged,so.urgedtime,so.isurgedreply,so.urgedtimereply,so.isclear,so.ishidden,so.puid,so.allocate,so.allocatetype,so.applyUnit,so.isinvoice,so.invoiceName,so.invoiceDutyParagraph,so.invoiceProvinces,so.invoiceAddress,so.invoiceMobile,so.invoiceOpeningBank,so.invoiceAccountNumber,so.invoiceCostName,so.orderType,so.name,so.mobile,so.city,so.address,so.youbian,so.mail,so.isbkinvoice,so.jhpstastus,so.retype,so.isbatche,so.issubmitinvoice "+
				"from shoporder so "+tab(sql)+" where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				ShopOrder so = new ShopOrder(rs.getInt(i++));
				so.setOrderId(rs.getString(i++));
				so.setMember(rs.getInt(i++));
				so.setAmount(rs.getDouble(i++));
				so.setPayType(rs.getInt(i++));
				so.setPayment(rs.getInt(i++));
				so.setCreateDate(db.getDate(i++));
				so.setPayTime(db.getDate(i++));
				so.setStatus(rs.getInt(i++));
				so.setInvoice(rs.getInt(i++));
				so.setCancelReason(rs.getString(i++));
				so.setPayment(rs.getBoolean(i++));
				so.setRemarks(rs.getString(i++));
				so.setUserRemarks(rs.getString(i++));
				so.setInvoiceStatus(rs.getInt(i++));
				so.setLzCategory(rs.getBoolean(i++));
				so.setOrderUnit(rs.getString(i++));
				so.setReceiptTime(db.getDate(i++));
				so.setSign_user_openid(rs.getString(i++));
				so.setAskInvoiceDate(db.getDate(i++));
				so.setCanceltime(db.getDate(i++));
				so.setCancelmember(rs.getInt(i++));
				so.setReturntime(db.getDate(i++));
				so.setOldorderid(rs.getString(i++));
				so.setNoinvoicenum(rs.getInt(i++));
				so.setNoinvoiceamount(rs.getFloat(i++));
				so.setIsinvoicenum(rs.getInt(i++));
				so.setIsinvoiceamount(rs.getFloat(i++));
				so.setMatchnum(rs.getInt(i++));
				so.setIsurged(rs.getInt(i++));
				so.setUrgedtime(db.getDate(i++));
				so.setIsurgedreply(rs.getInt(i++));
				so.setUrgedtimereply(db.getDate(i++));
				so.setIsclear(rs.getInt(i++));
				so.setIshidden(rs.getInt(i++));
				so.setPuid(rs.getInt(i++));
				so.setAllocate(rs.getInt(i++));
				so.setAllocatetype(rs.getInt(i++));
				so.setApplyUnit(rs.getInt(i++));
				so.setIsinvoice(rs.getInt(i++));
				so.setInvoiceName(rs.getString(i++));
                so.setInvoiceDutyParagraph(rs.getString(i++));
                so.setInvoiceProvinces(rs.getString(i++));
                so.setInvoiceAddress(rs.getString(i++));
                so.setInvoiceMobile(rs.getString(i++));
                so.setInvoiceOpeningBank(rs.getString(i++));
                so.setInvoiceAccountNumber(rs.getString(i++));
                so.setInvoiceCostName(rs.getString(i++));
                so.setOrderType(rs.getInt(i++));
                so.setName(rs.getString(i++));
                so.setMobile(rs.getString(i++));
                so.setCity(rs.getInt(i++));
                so.setAddress(rs.getString(i++));
                so.setYoubian(rs.getString(i++));
                so.setMail(rs.getString(i++));
                so.setIsbkinvoice(rs.getInt(i++));
                so.setJhpstastus(rs.getInt(i++));
                so.setRetype(rs.getInt(i++));
                so.setIsbatche(rs.getInt(i++));
                so.setIssubmitinvoice(rs.getInt(i++));
				c.put(so.id, so);
				list.add(so);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}
	
	public static int count(String sql) throws SQLException{
//		String Qsql = "select count(0) from shoporder so "+tab(sql)+" where 1=1 " + sql;
//		System.out.println(Qsql);
		return DbAdapter.execute("select count(0) from shoporder so "+tab(sql)+" where 1=1 " + sql);
	}

	public static int sum(String sql) throws SQLException{
//		String Qsql = "select count(0) from shoporder so "+tab(sql)+" where 1=1 " + sql;
//		System.out.println(Qsql);
		return DbAdapter.execute("select sum(soda.quantity) from shoporder so "+tab(sql)+" where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into shoporder(id,order_id,member,amount,payType,payment,createdate,paytime,status,invoice,cancelreason,isPayment,remarks,userRemarks,invoiceStatus,isLzCategory,orderUnit,receiptTime,sign_user_openid,askInvoiceDate,canceltime,cancelmember,returntime,oldorderid,noinvoicenum,noinvoiceamount,isinvoicenum,isinvoiceamount,matchnum,isurged,urgedtime,isurgedreply,urgedtimereply,isclear,ishidden,puid,allocate,allocatetype,applyUnit,isinvoice,invoiceName,invoiceDutyParagraph,invoiceProvinces,invoiceAddress,invoiceMobile,invoiceOpeningBank,invoiceAccountNumber,invoiceCostName,orderType,name,mobile,city,address,youbian,mail,isbkinvoice,jhpstastus,retype,isbatche,issubmitinvoice) values("
				+ (this.id = Seq.get()) + "," + DbAdapter.cite(this.orderId) + "," + this.member + "," + this.amount + "," + this.payType + "," + this.payment + "," + DbAdapter.cite(this.createDate)
				+ "," + DbAdapter.cite(this.payTime) + "," + this.status + "," + this.invoice + "," + DbAdapter.cite(this.cancelReason) + "," + DbAdapter.cite(this.isPayment)
				+ ","+DbAdapter.cite(this.remarks)+","+DbAdapter.cite(this.userRemarks)+","+this.invoiceStatus+","+DbAdapter.cite(this.isLzCategory)+","+Database.cite(orderUnit)+","+Database.cite(receiptTime)
				+","+Database.cite(sign_user_openid)+","+DbAdapter.cite(this.askInvoiceDate)+","+DbAdapter.cite(this.canceltime)+","+this.cancelmember+","+DbAdapter.cite(this.returntime)+","+DbAdapter.cite(this.oldorderid)+","+this.noinvoicenum+","+this.noinvoiceamount+","+this.isinvoicenum+","+this.isinvoiceamount+","+this.matchnum+","+this.isurged+","+DbAdapter.cite(this.urgedtime)+","+this.isurgedreply+","+DbAdapter.cite(this.urgedtimereply)+","+this.isclear+","+this.ishidden+","+this.puid+","+allocate+","+allocatetype+","+applyUnit+","+isinvoice+","+Database.cite(invoiceName)+","+Database.cite(invoiceDutyParagraph)+","+Database.cite(invoiceProvinces)+","+Database.cite(invoiceProvinces)+","+Database.cite(invoiceMobile)+","+Database.cite(invoiceOpeningBank)+","+Database.cite(invoiceAccountNumber)+","+Database.cite(invoiceCostName)+","+orderType+","+Database.cite(name)+","+Database.cite(mobile)+","+city+","+Database.cite(address)+","+Database.cite(youbian)+","+Database.cite(mail)+","+isbkinvoice+","+jhpstastus+","+retype+","+isbatche+","+issubmitinvoice+")";
		}else{
			sql = "update shoporder set order_id="+ DbAdapter.cite(this.orderId) +",member="+this.member+",amount="+this.amount+",payType="+this.payType +",payment="+this.payment
			+",createdate="+DbAdapter.cite(this.createDate)+",paytime="+DbAdapter.cite(this.payTime)+",status="+this.status+",invoice="+this.invoice+",cancelreason="+ DbAdapter.cite(this.cancelReason)
			+",isPayment="+ DbAdapter.cite(this.isPayment) + ",remarks="+DbAdapter.cite(this.remarks)+",userRemarks="+DbAdapter.cite(this.userRemarks)+",invoiceStatus="+this.invoiceStatus
			+",isLzCategory="+DbAdapter.cite(this.isLzCategory)+",orderUnit="+Database.cite(orderUnit)+",receiptTime="+Database.cite(receiptTime)+",sign_user_openid="+Database.cite(sign_user_openid)
			+",askInvoiceDate="+DbAdapter.cite(this.askInvoiceDate)+",canceltime="+DbAdapter.cite(this.canceltime)+",cancelmember="+this.cancelmember+",returntime="+DbAdapter.cite(this.returntime)+",oldorderid="+DbAdapter.cite(this.oldorderid)
			+",noinvoicenum="+this.noinvoicenum+",noinvoiceamount="+this.noinvoiceamount+",isinvoicenum="+this.isinvoicenum+",isinvoiceamount="+this.isinvoiceamount+",matchnum="+this.matchnum+",isurged="+this.isurged+",urgedtime="+DbAdapter.cite(this.urgedtime)+",isurgedreply="+this.isurgedreply+",urgedtimereply="+DbAdapter.cite(this.urgedtimereply)+",isclear="+this.isclear+",ishidden="+this.ishidden+",puid="+this.puid+",allocate="+this.allocate+",allocatetype="+this.allocatetype+",applyUnit="+applyUnit+",isinvoice="+isinvoice+",invoiceName="+Database.cite(invoiceName)+",invoiceDutyParagraph="+Database.cite(invoiceDutyParagraph)+",invoiceProvinces="+Database.cite(invoiceProvinces)+",invoiceAddress="+Database.cite(invoiceAddress)+",invoiceMobile="+Database.cite(invoiceMobile)+",invoiceOpeningBank="+Database.cite(invoiceOpeningBank)+",invoiceAccountNumber="+Database.cite(invoiceAccountNumber)+",invoiceCostName="+Database.cite(invoiceCostName)+",orderType="+orderType+",name="+Database.cite(name)+",mobile="+Database.cite(mobile)+",city="+city+",address="+Database.cite(address)+",youbian="+Database.cite(youbian)+",mail="+Database.cite(mail)+",isbkinvoice="+isbkinvoice+",jhpstastus="+jhpstastus+",retype="+retype+",isbatche="+isbatche+",issubmitinvoice="+issubmitinvoice+" where id=" + this.id;
		}
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	public void delete(){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id,"delete from shoporder where id= " + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	public void set(String column,String value){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, "update shoporder set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND ml."))
            sb.append(" INNER JOIN ProfileLayer ml ON ml.member=so.member");
        if (sql.contains(" AND m."))
            sb.append(" INNER JOIN Profile m ON m.profile=so.member");
        if (sql.contains(" AND sod."))
            sb.append(" INNER JOIN ShopOrderDispatch sod ON sod.order_id=so.order_id");
        if(sql.contains(" AND se."))
        	sb.append(" INNER JOIN shopexchanged se ON se.order_id=so.order_id AND so.invoiceStatus=3 ");
		if(sql.contains(" AND soda."))
			sb.append(" INNER JOIN shoporderdata soda ON soda.order_id=so.order_id ");
		if(sql.contains(" AND spdb."))
			sb.append(" INNER JOIN ShopOrderDatasBatches spdb ON spdb.ordercode=so.order_id ");


        return sb.toString();
    }
	
	//下单时间如果超过了7天，订单状态自动变更为“已取消”
	public static void CancelOrderByTimer(int datatype){
		DbAdapter db = new DbAdapter(datatype);
		String sql = "";
		if(datatype==0)
			sql = "update shoporder set status=5 where status=0 AND isPayment=0 AND TIMESTAMPDIFF(day,createdate,NOW())>=7";
		else if(datatype==1)
			sql = "update shoporder set status=5 where status=0 AND isPayment=0 AND datediff(day,createdate,getdate())>=7";
		else if(datatype==2)
			sql = "update shoporder set status=5 where status=0 AND isPayment=0 AND to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd')-to_date(to_char(createdate,'yyyy-mm-dd'),'yyyy-mm-dd')>=7";
		try {
			db.executeUpdate(sql);
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
	}
	
	//发货时间如果超过了7天，订单状态自动变更为“已完成”，并且记录收货时间
	public static void AutoReceiptOrderByTimer(int datatype){
		DbAdapter db = new DbAdapter(datatype);
		String sql = "";
		if(datatype==0)
			sql = "update shoporder set status=4,receiptTime=NOW() where status=3 AND order_id in(select order_id from ShopOrderExpress where TIMESTAMPDIFF(day,time,NOW())>=7)";
		else if(datatype==1)
			sql = "update shoporder set status=4,receiptTime=getdate() where status=3 AND order_id in(select order_id from ShopOrderExpress where datediff(day,time,getdate())>=7)";
		else if(datatype==2)
			sql = "update shoporder set status=4,receiptTime=sysdate where status=3 AND order_id in(select order_id from ShopOrderExpress where to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd')-to_date(to_char(time,'yyyy-mm-dd'),'yyyy-mm-dd')>=7)";
		try {
			db.executeUpdate(sql);
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
	}
	
	/**
	 * 订单统计查询方法
	 * @param
	 * @param sql
	 * @param pos
	 * @param size
	 * @return
	 */
	public static ArrayList<ShopOrder> findOrders(int category,String sql,int pos,int size){
		ArrayList<ShopOrder> list = new ArrayList<ShopOrder>();
		DbAdapter db = new DbAdapter();
		//String QSql = "select so.id,so.order_id,so.member,so.amount,so.payType,so.payment,so.createdate,so.paytime,so.status,so.invoice,so.cancelreason,so.isPayment,so.remarks,so.userRemarks from shoporder so  where  so.status = 3 and order_id in (select order_id from shoporderdata sod where product_id in (select product from shopproduct sp where category in (select category from shopcategory where category="+category+")))"+sql;
		String QSql = "";
		if(category!=1){
			QSql = "select a.id,a.order_id,a.member,a.amount,a.payType,a.payment,a.createdate,a.paytime,a.status,a.invoice,a.cancelreason,a.isLzCategory,a.isPayment,a.remarks,a.userRemarks,a.orderUnit from (select ROW_NUMBER() over (PARTITION by so.id order by so.id) num ,so.id,so.order_id,so.member,so.amount,so.payType,so.payment,so.createdate,so.paytime,so.status,so.invoice,so.cancelreason,so.isLzCategory,so.isPayment,so.remarks,so.userRemarks,so.orderUnit from shoporder so inner join ShopOrderDispatch sodh on so.order_id = sodh.order_id  inner join shoporderdata sod on sod.order_id = so.order_id inner join shopproduct sp on sp.product = sod.product_id inner join ShopProduct_Model spm on spm.id = sp.model_id  where  so.status in(3,4) and so.islzcategory = 1 "+sql+" ) a where a.num = 1 order by a.createdate desc";
			//QSql = "select  so.id,so.order_id,so.member,so.amount,so.payType,so.payment,so.createdate,so.paytime,so.status,so.invoice,so.cancelreason,so.isPayment,so.remarks,so.userRemarks from shoporder so inner join ShopOrderDispatch sodh on so.order_id = sodh.order_id  inner join shoporderdata sod on sod.order_id = so.order_id inner join shopproduct sp on sp.product = sod.product_id inner join ShopProduct_Model spm on spm.id = sp.model_id  where  so.status = 4 and spm.category = 14102669 "+sql;
		}else{
			QSql = "select a.id,a.order_id,a.member,a.amount,a.payType,a.payment,a.createdate,a.paytime,a.status,a.invoice,a.cancelreason,a.isLzCategory,a.isPayment,a.remarks,a.userRemarks,a.orderUnit from (select ROW_NUMBER() over (PARTITION by so.id order by so.id) num ,so.id,so.order_id,so.member,so.amount,so.payType,so.payment,so.createdate,so.paytime,so.status,so.invoice,so.cancelreason,so.isLzCategory,so.isPayment,so.remarks,so.userRemarks,so.orderUnit from shoporder so inner join ShopOrderDispatch sodh on so.order_id = sodh.order_id  inner join shoporderdata sod on sod.order_id = so.order_id inner join shopproduct sp on sp.product = sod.product_id  where   so.status in(3,4) and so.islzcategory = 0  "+sql+" ) a where a.num = 1 order by a.createdate desc";// inner join ShopProduct_Model spm on spm.id = sp.model_id
			//QSql = "select  so.id,so.order_id,so.member,so.amount,so.payType,so.payment,so.createdate,so.paytime,so.status,so.invoice,so.cancelreason,so.isPayment,so.remarks,so.userRemarks from shoporder so inner join ShopOrderDispatch sodh on so.order_id = sodh.order_id  inner join shoporderdata sod on sod.order_id = so.order_id inner join shopproduct sp on sp.product = sod.product_id  where  so.status = 4 and so.islzcategory = 0 "+sql;
		}
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				ShopOrder so = new ShopOrder(rs.getInt(i++));
				so.setOrderId(rs.getString(i++));
				so.setMember(rs.getInt(i++));
				so.setAmount(rs.getDouble(i++));
				so.setPayType(rs.getInt(i++));
				so.setPayment(rs.getInt(i++));
				so.setCreateDate(db.getDate(i++));
				so.setPayTime(db.getDate(i++));
				so.setStatus(rs.getInt(i++));
				so.setInvoice(rs.getInt(i++));
				so.setCancelReason(rs.getString(i++));
				so.setLzCategory(rs.getBoolean(i++));
				so.setPayment(rs.getBoolean(i++));
				so.setRemarks(rs.getString(i++));
				so.setUserRemarks(rs.getString(i++));
				so.setOrderUnit(rs.getString(i++));
				c.put(so.id, so);
				list.add(so);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}
	
	public static int countOrders(int category,String sql) throws SQLException{
		return DbAdapter.execute("select count(0) from shoporder so where so.status = 3 and order_id in (select order_id from shoporderdata sod where product_id in (select product from shopproduct sp where category in (select category from shopcategory where category="+category+")))");
	}
	//改变旧订单的已开票金额、已开票数量、未开票金额、未开票数量
	public static void changeInvoiceNA(){
		//查询已完成开票的订单(旧的开票方式的）
		String sql=" and invoicestatus = 3  and order_id not in(select orderid from invoicedata)";//已开发票的订单
		ArrayList<ShopOrder> lstorder=ShopOrder.find(sql, 0, Integer.MAX_VALUE);
		
		//已开发票的订单
		for(int i=0;i<lstorder.size();i++){
			ShopOrder order=lstorder.get(i);
			ArrayList<ShopOrderData> lstdata=ShopOrderData.find(" and order_id="+Database.cite(order.getOrderId()), 0, Integer.MAX_VALUE);
			if(lstdata.size()>0){
				ShopOrderData data=lstdata.get(0);
				order.set("noinvoicenum", String.valueOf(0));
				order.set("noinvoiceamount", String.valueOf(0));
				order.set("isinvoicenum", String.valueOf(data.getQuantity()));
				order.set("isinvoiceamount", String.valueOf(data.getAgent_amount()));
			}
		}
		
		//未索要发票的订单
		String sql2=" and invoicestatus = 0 ";
		ArrayList<ShopOrder> lstorder2=ShopOrder.find(sql2, 0, Integer.MAX_VALUE);
		for(int i=0;i<lstorder2.size();i++){
			ShopOrder order=lstorder2.get(i);
			ArrayList<ShopOrderData> lstdata=ShopOrderData.find(" and order_id="+Database.cite(order.getOrderId()), 0, Integer.MAX_VALUE);
			if(lstdata.size()>0){
				ShopOrderData data=lstdata.get(0);
				order.set("noinvoicenum", String.valueOf(data.getQuantity()));
				order.set("noinvoiceamount", String.valueOf(data.getAgent_amount()));
				order.set("isinvoicenum", String.valueOf(0));
				order.set("isinvoiceamount", String.valueOf(0));
			}
		}
		//已申请未处理///管理员已保存，未完成
		/*String sql3=" and invoicestatus = 1 and order_id not in(select orderid from invoicedata)";
		ArrayList<ShopOrder> lstorder3=ShopOrder.find(sql3, 0, Integer.MAX_VALUE);
		for(int i=0;i<lstorder3.size();i++){
			ShopOrder order=lstorder3.get(i);
			order.set("noinvoicenum",String.valueOf(0));
			order.set("noinvoiceamount", String.valueOf(0));
			order.set("isinvoicenum", String.valueOf(0));
			order.set("isinvoiceamount", String.valueOf(0));
		}
		
		
		String sql4=" and  invoicestatus = 2 ";
		ArrayList<ShopOrder> lstorder4=ShopOrder.find(sql4, 0, Integer.MAX_VALUE);
		for(int i=0;i<lstorder4.size();i++){
			ShopOrder order=lstorder4.get(i);
			order.set("noinvoicenum", String.valueOf(0));
			order.set("noinvoiceamount", String.valueOf(0));
			order.set("isinvoicenum", String.valueOf(0));
			order.set("isinvoiceamount", String.valueOf(0));
		}*/
	}
	
	
	//查询订单id
	public static ArrayList<String> searchOrderid(String sql,int pos,int size) throws SQLException{
		ArrayList<String> list = new ArrayList<String>();
		DbAdapter db = new DbAdapter();
		String QSql = "select so.order_id from ShopOrder so where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				String orderid=rs.getString(i++);
				list.add(orderid);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}

	//查询已开票的总粒数
	public static int sumisinvoiquantity(String sql) throws SQLException{
		return DbAdapter.execute("select sum(isinvoicenum) from shoporder where 1=1 " + sql);
	}
	
	//查询未开票的总粒数
	public static int sumnoinvoiquantity(String sql) throws SQLException{
		return DbAdapter.execute("select sum(noinvoicenum) from shoporder where 1=1 " + sql);
	}
	
	//查询已回款的总粒数
	public static int summatchnum(String sql) throws SQLException{
		return DbAdapter.execute("select sum(matchnum) from shoporder where 1=1 " + sql);
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public int getPayType() {
		return payType;
	}

	public void setPayType(int payType) {
		this.payType = payType;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getInvoice() {
		return invoice;
	}

	public void setInvoice(int invoice) {
		this.invoice = invoice;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}

	public boolean isPayment() {
		return isPayment;
	}

	public void setPayment(boolean isPayment) {
		this.isPayment = isPayment;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getUserRemarks() {
		return userRemarks;
	}

	public void setUserRemarks(String userRemarks) {
		this.userRemarks = userRemarks;
	}

	public int getPayment() {
		return payment;
	}

	public void setPayment(int payment) {
		this.payment = payment;
	}

	public int getInvoiceStatus() {
		return invoiceStatus;
	}

	public void setInvoiceStatus(int invoiceStatus) {
		this.invoiceStatus = invoiceStatus;
	}

	public boolean isLzCategory() {
		return isLzCategory;
	}

	public void setLzCategory(boolean isLzCategory) {
		this.isLzCategory = isLzCategory;
	}

	public String getOrderUnit() {
		return orderUnit;
	}

	public void setOrderUnit(String orderUnit) {
		this.orderUnit = orderUnit;
	}

	public Date getReceiptTime() {
		return receiptTime;
	}

	public void setReceiptTime(Date receiptTime) {
		this.receiptTime = receiptTime;
	}

	public String getSign_user_openid() {
		return sign_user_openid;
	}

	public void setSign_user_openid(String sign_user_openid) {
		this.sign_user_openid = sign_user_openid;
	}

	public Date getAskInvoiceDate() {
		return askInvoiceDate;
	}

	public void setAskInvoiceDate(Date askInvoiceDate) {
		this.askInvoiceDate = askInvoiceDate;
	}

	public Date getCanceltime() {
		return canceltime;
	}

	public void setCanceltime(Date canceltime) {
		this.canceltime = canceltime;
	}

	public int getCancelmember() {
		return cancelmember;
	}

	public void setCancelmember(int cancelmember) {
		this.cancelmember = cancelmember;
	}

	public Date getReturntime() {
		return returntime;
	}

	public void setReturntime(Date returntime) {
		this.returntime = returntime;
	}

	public String getOldorderid() {
		return oldorderid;
	}

	public void setOldorderid(String oldorderid) {
		this.oldorderid = oldorderid;
	}

	public int getNoinvoicenum() {
		return noinvoicenum;
	}

	public void setNoinvoicenum(int noinvoicenum) {
		this.noinvoicenum = noinvoicenum;
	}

	public float getNoinvoiceamount() {
		return noinvoiceamount;
	}

	public void setNoinvoiceamount(float noinvoiceamount) {
		this.noinvoiceamount = noinvoiceamount;
	}

	public int getIsinvoicenum() {
		return isinvoicenum;
	}

	public void setIsinvoicenum(int isinvoicenum) {
		this.isinvoicenum = isinvoicenum;
	}

	public float getIsinvoiceamount() {
		return isinvoiceamount;
	}

	public void setIsinvoiceamount(float isinvoiceamount) {
		this.isinvoiceamount = isinvoiceamount;
	}

	public int getMatchnum() {
		return matchnum;
	}

	public void setMatchnum(int matchnum) {
		this.matchnum = matchnum;
	}

	public int getIsurged() {
		return isurged;
	}

	public void setIsurged(int isurged) {
		this.isurged = isurged;
	}

	public Date getUrgedtime() {
		return urgedtime;
	}

	public void setUrgedtime(Date urgedtime) {
		this.urgedtime = urgedtime;
	}

	public int getIsurgedreply() {
		return isurgedreply;
	}

	public void setIsurgedreply(int isurgedreply) {
		this.isurgedreply = isurgedreply;
	}

	public Date getUrgedtimereply() {
		return urgedtimereply;
	}

	public void setUrgedtimereply(Date urgedtimereply) {
		this.urgedtimereply = urgedtimereply;
	}

	public int getIsclear() {
		return isclear;
	}

	public void setIsclear(int isclear) {
		this.isclear = isclear;
	}

	public int getIshidden() {
		return ishidden;
	}

	public void setIshidden(int ishidden) {
		this.ishidden = ishidden;
	}

	public int getPuid() {
		return puid;
	}

	public void setPuid(int puid) {
		this.puid = puid;
	}

	public int getAllocate() {
		return allocate;
	}

	public void setAllocate(int allocate) {
		this.allocate = allocate;
	}

	public int getAllocatetype() {
		return allocatetype;
	}

	public void setAllocatetype(int allocatetype) {
		this.allocatetype = allocatetype;
	}

	public int getApplyUnit() {
		return applyUnit;
	}

	public void setApplyUnit(int applyUnit) {
		this.applyUnit = applyUnit;
	}


    public int getOrderType() {
        return orderType;
    }

    public void setOrderType(int orderType) {
        this.orderType = orderType;
    }

    public int getIsinvoice() {
        return isinvoice;
    }

    public void setIsinvoice(int isinvoice) {
        this.isinvoice = isinvoice;
    }

    public String getInvoiceName() {
        return invoiceName;
    }

    public void setInvoiceName(String invoiceName) {
        this.invoiceName = invoiceName;
    }

    public String getInvoiceDutyParagraph() {
        return invoiceDutyParagraph;
    }

    public void setInvoiceDutyParagraph(String invoiceDutyParagraph) {
        this.invoiceDutyParagraph = invoiceDutyParagraph;
    }

    public String getInvoiceProvinces() {
        return invoiceProvinces;
    }

    public void setInvoiceProvinces(String invoiceProvinces) {
        this.invoiceProvinces = invoiceProvinces;
    }

    public String getInvoiceAddress() {
        return invoiceAddress;
    }

    public void setInvoiceAddress(String invoiceAddress) {
        this.invoiceAddress = invoiceAddress;
    }

    public String getInvoiceMobile() {
        return invoiceMobile;
    }

    public void setInvoiceMobile(String invoiceMobile) {
        this.invoiceMobile = invoiceMobile;
    }

    public String getInvoiceOpeningBank() {
        return invoiceOpeningBank;
    }

    public void setInvoiceOpeningBank(String invoiceOpeningBank) {
        this.invoiceOpeningBank = invoiceOpeningBank;
    }

    public String getInvoiceAccountNumber() {
        return invoiceAccountNumber;
    }

    public void setInvoiceAccountNumber(String invoiceAccountNumber) {
        this.invoiceAccountNumber = invoiceAccountNumber;
    }

    public String getInvoiceCostName() {
        return invoiceCostName;
    }

    public void setInvoiceCostName(String invoiceCostName) {
        this.invoiceCostName = invoiceCostName;
    }

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public int getCity() {
		return city;
	}

	public void setCity(int city) {
		this.city = city;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getYoubian() {
		return youbian;
	}

	public void setYoubian(String youbian) {
		this.youbian = youbian;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public int getIsbkinvoice() {
		return isbkinvoice;
	}

	public void setIsbkinvoice(int isbkinvoice) {
		this.isbkinvoice = isbkinvoice;
	}

	public int getJhpstastus() {
		return jhpstastus;
	}

	public void setJhpstastus(int jhpstastus) {
		this.jhpstastus = jhpstastus;
	}

	public int getRetype() {
		return retype;
	}

	public void setRetype(int retype) {
		this.retype = retype;
	}

	public int getIsbatche() {
		return isbatche;
	}

	public void setIsbatche(int isbatche) {
		this.isbatche = isbatche;
	}

	public int getIssubmitinvoice() {
		return issubmitinvoice;
	}

	public void setIssubmitinvoice(int issubmitinvoice) {
		this.issubmitinvoice = issubmitinvoice;
	}
}
