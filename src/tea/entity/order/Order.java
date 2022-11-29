package tea.entity.order;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

import javax.swing.text.TabableView;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;
/**
 * 
 * @描述：订单表
 * @开发人员：
 * @开发时间：2014-1-26 下午12:07:14
 */
public class Order extends Entity{
	public static Cache c = new Cache(2000);
	    public static SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
	    // 数据库表字段:id 描述:记录编号
		protected int id;
		
		// 数据库表字段:code 描述:订单编号（'O'+年[4]+月[2]+日[2]+小时[2]+分钟[2]+秒[2]+随机数[3]）
		protected String code = null;
		public String community;
		// 数据库表字段:customer 描述:客户姓名
		protected String customer = null;

		// 数据库表字段:mobile 描述:客户手机
		protected String mobile = null;
		protected int city;
		// 数据库表字段:email 描述:邮箱
		protected String email = null;
		public String zipCode;//邮编
		public String journal;//期刊月份
		// 数据库表字段:address 描述:客户地址
		protected String address = null;
		public static final String[] INVOIVE_TYPE={"个人","企业"};
	    public static final String[] INVOIVE_CONTENT={"图书","资料","杂志"};
	    public int isInvoive;//是否开发票
	    public int invoiveType;//发票类型
	    public int invoiveContent;//发票内容
	    public String unitName;//发票单位
	    public int goway;//配送方式
		// 数据库表字段:total_money 描述:订单总金额
		protected BigDecimal totalMoney = null;
		private String moneyOrder=null;
		protected BigDecimal freight=null;//运费
		// 数据库表字段:status 描述:订单状态（1-新建 2-）
		public static final String[] ORDER_STATE1={"订单状态","等待计算运费","待汇款","已汇款","已确认汇款","已发货","已收货","已完成","已取消"};
		public static final String[] ORDER_STATE2={"订单状态","等待计算运费","待汇款","已汇款","已确认汇款","已发货","完成交易","完成交易","已取消"};
		protected int status;
		protected String submitMen= null;
		// 数据库表字段:submit_time 描述:提交时间
		protected Date submitTime = null;

		// 数据库表字段:complete_man 描述:完成人
		protected String completeMan = null;

		// 数据库表字段:complete_time 描述:完成人时间
		protected Date completeTime = null;
		
		// 数据库表字段:cancel_man 描述:取消人Id
		protected String cancelMan = null;

		// 数据库表字段:cancel_time 描述:取消时间
		protected Date cancelTime = null;

		// 数据库表字段:customer_remark 描述:客户备注
		protected String customerRemark = null;

		// 数据库表字段:send_man 描述:确认发货人
		protected String sendMan = null;

		// 数据库表字段:send_time 描述:发货时间
		protected Date sendTime = null;
		//填运费的人
		protected String freighMan=null;
		protected Date freightTime=null;
		protected String payee=null;
		protected Date payeeTime=null;
		//支付状态
		protected Integer isPay = null;
		//支付方式
		protected Integer payType = null;
		//现场支付方式
		public Integer nowPayType = null;
		// 数据库表字段:is_valid 描述:是否有效记录（1-无效 0-有效）
		protected Integer isValid = null;
		
		// 数据库表字段:invalid_date 描述:删除时间
		protected Date invalidDate = null;
		/**模拟飞机*/
		//飞机舱id
		public int planeId;
		//预约时间
		protected Date reserveTime=null;
		//开始时间
		protected Date beginTime=null;
		//结束时间
		protected Date endTime=null;
		//预约人数
		protected Integer personNum = null;
		
		//订单状态
		public static final String[] ORDER_STATE4={"--","新建","已完成","已取消"};
		public static final String[] ORDER_ISPAY={"未支付","已支付"};
		public static final String[] ORDER_PAYTYPE={"在线支付","现场支付"};
		public Order(){
			
		}
		public Order(int id){
			this.id=id;
		}

		public static Order find(int id){
			Order o = (Order) c.get(id);
	        if(o == null)
	        {
	        	o=new Order();
	            DbAdapter db= new DbAdapter();
	            try {
					db.executeQuery("select id,code,customer,mobile,city,address,total_money,status,submit_time,complete_man,complete_time,cancel_man,cancel_time,customer_remark,send_man,send_time," +
							"freigh_man,freight_time,payee,payee_time,is_valid,invalid_date,email,isInvoive,invoiveType,invoiveContent,unitName,submit_men,freight,moneyOrder,reserveTime,beginTime,endTime,personNum,isPay,payType,nowPayType,planeId,community,zipCode,goway,journal from SaleOrder where id="+id);
					if(db.next()){
						o.id=db.getInt(1);
						o.code=db.getString(2);
						o.customer=db.getString(3);
						o.mobile=db.getString(4);
						o.city=db.getInt(5);
						o.address=db.getString(6);
						o.totalMoney=db.getBigDecimal(7, 2);
						o.status=db.getInt(8);
						o.submitTime=db.getDate(9);
						o.completeMan=db.getString(10);
						o.completeTime=db.getDate(11);
						o.cancelMan=db.getString(12);
						o.cancelTime=db.getDate(13);
						o.customerRemark=db.getString(14);
						o.sendMan=db.getString(15);
						o.sendTime=db.getDate(16);
						o.freighMan=db.getString(17);
						o.freightTime=db.getDate(18);
						o.payee=db.getString(19);
						o.payeeTime=db.getDate(20);
						o.isValid=db.getInt(21);
						o.invalidDate=db.getDate(22);
						o.email=db.getString(23);
						o.isInvoive=db.getInt(24);
						o.invoiveType=db.getInt(25);
						o.invoiveContent=db.getInt(26);
						o.unitName=db.getString(27);
						o.submitMen=db.getString(28);
						o.freight=db.getBigDecimal(29, 2);
						o.moneyOrder=db.getString(30);
						o.reserveTime=db.getDate(31);
						o.beginTime=db.getDate(32);
						o.endTime=db.getDate(33);
						o.personNum=db.getInt(34);
						o.isPay=db.getInt(35);
						o.payType=db.getInt(36);
						o.nowPayType=db.getInt(37);
						o.planeId=db.getInt(38);
						o.community=db.getString(39);
						o.zipCode=db.getString(40);
						o.goway=db.getInt(41);
						o.journal=db.getString(42);
						c.put(id,o);
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}finally{
					db.close();
				}
	        }
	        
	        return o;
	    }
		public static Enumeration find(String sql, int pos, int size) throws SQLException {
			Vector v = new Vector();
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeQuery("SELECT o.id FROM SaleOrder o WHERE 1=1" + sql,pos,size);
	            while(db.next())
	            {
	                v.add(db.getInt(1));
	            }
	        } finally
	        {
	            db.close();
	        }
	        return v.elements();
		}
		private static String tab(String sql)
	    {
	        StringBuilder sb = new StringBuilder();
	        if(sql.contains(" AND od."))
	            sb.append(" INNER JOIN saleorderdedail od ON od.saleordercode=o.code");
			
	        return sb.toString();
	    }
		public static Enumeration findbyMember(String member,int pos,int size) throws SQLException{
			return find(" and submit_men="+DbAdapter.cite(member), pos, size);
		}
		public static int count(String sql) throws SQLException
	    {
	        return DbAdapter.execute("SELECT COUNT(*) FROM SaleOrder o "+tab(sql)+" WHERE 1=1" + sql);
	    }
		
		public void set(String f,String v) throws SQLException
	    {
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeUpdate(id,"UPDATE SaleOrder SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
	        } finally
	        {
	            db.close();
	        }
	        c.remove(id);
	    }
		public void set(String f,Date v) throws SQLException
	    {
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeUpdate(id,"UPDATE SaleOrder SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
	        } finally
	        {
	            db.close();
	        }
	        c.remove(id);
	    }
		public void set() throws SQLException
	    {
	        String sql;
	        if(id<1)
	        {
	            sql = "INSERT INTO SaleOrder(code,customer,community,mobile,city,email,zipCode,journal,isInvoive,invoiveType,invoiveContent,unitName,goway,address,total_money,status,submit_men,submit_time,complete_man,complete_time,cancel_man,cancel_time,customer_remark,send_man,send_time,freigh_man,freight_time,payee,payee_time,is_valid,invalid_date,reserveTime,beginTime,endTime,personNum,isPay,payType,nowPayType,planeId)VALUES(" + DbAdapter.cite(code) + ","
	        	+ DbAdapter.cite(customer)+ "," + DbAdapter.cite(community) + "," + DbAdapter.cite(mobile) + "," + city + "," + DbAdapter.cite(email)+ "," + DbAdapter.cite(zipCode)+ "," + DbAdapter.cite(journal)+ "," + isInvoive+ "," + invoiveType+ "," + invoiveContent+ "," + DbAdapter.cite(unitName)+ "," + goway+ "," + DbAdapter.cite(address) + "," + totalMoney+","+status + "," + DbAdapter.cite(submitMen) + "," + DbAdapter.cite(submitTime) + "," + DbAdapter.cite(completeMan) + "," + DbAdapter.cite(completeTime) + "," + DbAdapter.cite(cancelMan) + "," + 
	            		DbAdapter.cite(cancelTime) + "," + DbAdapter.cite(customerRemark) + "," + DbAdapter.cite(sendMan) + "," + DbAdapter.cite(sendTime) + "," + DbAdapter.cite(freighMan) + "," + DbAdapter.cite(freightTime) + "," + DbAdapter.cite(payee) + "," + DbAdapter.cite(payeeTime) + "," + 0 + "," + DbAdapter.cite(invalidDate)+ "," + DbAdapter.cite(reserveTime)+ "," + DbAdapter.cite(beginTime)+ "," + DbAdapter.cite(endTime)+ "," + personNum+ "," + isPay+ "," + payType +"," + nowPayType+"," + planeId + ")";
	        } else
	            sql = "UPDATE SaleOrder SET code=" + DbAdapter.cite(code)+ ",customer=" + DbAdapter.cite(customer)+ ",community=" + DbAdapter.cite(community)+ ",mobile=" + DbAdapter.cite(mobile)+",city="+city+ ",email=" + DbAdapter.cite(email)+ ",zipCode=" + DbAdapter.cite(zipCode)+ ",journal=" + DbAdapter.cite(journal)+",isInvoive="+isInvoive+",invoiveType="+invoiveType+",invoiveContent="+invoiveContent+ ",unitName=" + DbAdapter.cite(unitName)+",goway="+goway+ ",address=" + DbAdapter.cite(address)+ ",total_money=" + totalMoney+",status="+status+ ",submit_men=" + DbAdapter.cite(submitMen)+ ",submit_time=" + DbAdapter.cite(submitTime)+
	            ",complete_man=" + DbAdapter.cite(completeMan)+ ",complete_time=" + DbAdapter.cite(completeTime)+ ",cancel_man=" + DbAdapter.cite(cancelMan)+ ",cancel_time=" + DbAdapter.cite(cancelTime)+ ",customer_remark=" + DbAdapter.cite(customerRemark)+ ",send_man=" + DbAdapter.cite(sendMan)+",freight="+freight +
	            ",send_time=" + DbAdapter.cite(sendTime) +",freigh_man=" + DbAdapter.cite(freighMan) +",freight_time=" + DbAdapter.cite(freightTime)  + ",payee=" + DbAdapter.cite(payee) + ",payee_time=" + DbAdapter.cite(payeeTime) + ",is_valid=" + isValid + ",invalid_date=" + DbAdapter.cite(invalidDate)+ ",moneyOrder=" + DbAdapter.cite(moneyOrder)+ ",reserveTime=" + DbAdapter.cite(reserveTime)+ ",beginTime=" + DbAdapter.cite(beginTime)+ ",endTime=" + DbAdapter.cite(endTime)+ ",personNum=" + personNum+ ",isPay=" + isPay+ ",payType=" + payType+ ",nowPayType=" + nowPayType+ ",planeId=" + planeId + " WHERE id=" + id;
	        DbAdapter db = new DbAdapter();
	        try
	        {
	            db.executeUpdate(id,sql);
	            id = db.getInt("SELECT MAX(id) FROM SaleOrder ");
	        } finally
	        {
	            db.close();
	        }
	        c.remove(id);
	    }
		public Date getReserveTime() {
			return reserveTime;
		}
		public void setReserveTime(Date reserveTime) {
			this.reserveTime = reserveTime;
		}
		public Date getBeginTime() {
			return beginTime;
		}
		public void setBeginTime(Date beginTime) {
			this.beginTime = beginTime;
		}
		public Date getEndTime() {
			return endTime;
		}
		public void setEndTime(Date endTime) {
			this.endTime = endTime;
		}
		public Integer getPersonNum() {
			return personNum;
		}
		public void setPersonNum(Integer personNum) {
			this.personNum = personNum;
		}
		public void delete() throws SQLException
	    {
	        set("is_valid","1");
	        set("invalid_date",new Date());

	    }
		public Integer getId() {
			return id;
		}
		public void setId(Integer id) {
			this.id = id;
		}
		public String getCode() {
			return code;
		}
		public void setCode(String code) {
			this.code = code;
		}
		public String getCustomer() {
			return customer;
		}
		public void setCustomer(String customer) {
			this.customer = customer;
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
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
		}
		public BigDecimal getTotalMoney() {
			return totalMoney;
		}
		public void setTotalMoney(BigDecimal totalMoney) {
			this.totalMoney = totalMoney;
		}
		public int getStatus() {
			return status;
		}
		public void setStatus(int status) {
			this.status = status;
		}
		public Date getSubmitTime() {
			return submitTime;
		}
		public void setSubmitTime(Date submitTime) {
			this.submitTime = submitTime;
		}
		public String getCompleteMan() {
			return completeMan;
		}
		public void setCompleteMan(String completeMan) {
			this.completeMan = completeMan;
		}
		public Date getCompleteTime() {
			return completeTime;
		}
		public void setCompleteTime(Date completeTime) {
			this.completeTime = completeTime;
		}
		public String getCancelMan() {
			return cancelMan;
		}
		public void setCancelMan(String cancelMan) {
			this.cancelMan = cancelMan;
		}
		public Date getCancelTime() {
			return cancelTime;
		}
		public void setCancelTime(Date cancelTime) {
			this.cancelTime = cancelTime;
		}
		public String getCustomerRemark() {
			return customerRemark;
		}
		public void setCustomerRemark(String customerRemark) {
			this.customerRemark = customerRemark;
		}
		public String getSendMan() {
			return sendMan;
		}
		public void setSendMan(String sendMan) {
			this.sendMan = sendMan;
		}
		public Date getSendTime() {
			return sendTime;
		}
		public void setSendTime(Date sendTime) {
			this.sendTime = sendTime;
		}
		public String getFreighMan() {
			return freighMan;
		}
		public void setFreighMan(String freighMan) {
			this.freighMan = freighMan;
		}
		public Date getFreightTime() {
			return freightTime;
		}
		public void setFreightTime(Date freightTime) {
			this.freightTime = freightTime;
		}
		public String getPayee() {
			return payee;
		}
		public void setPayee(String payee) {
			this.payee = payee;
		}
		public Date getPayeeTime() {
			return payeeTime;
		}
		public void setPayeeTime(Date payeeTime) {
			this.payeeTime = payeeTime;
		}
		public Integer getIsValid() {
			return isValid;
		}
		public void setIsValid(Integer isValid) {
			this.isValid = isValid;
		}
		public Date getInvalidDate() {
			return invalidDate;
		}
		public void setInvalidDate(Date invalidDate) {
			this.invalidDate = invalidDate;
		}
		public int getIsInvoive() {
			return isInvoive;
		}
		public void setIsInvoive(int isInvoive) {
			this.isInvoive = isInvoive;
		}
		public int getInvoiveType() {
			return invoiveType;
		}
		public void setInvoiveType(int invoiveType) {
			this.invoiveType = invoiveType;
		}
		public int getInvoiveContent() {
			return invoiveContent;
		}
		public void setInvoiveContent(int invoiveContent) {
			this.invoiveContent = invoiveContent;
		}
		public String getUnitName() {
			return unitName;
		}
		public void setUnitName(String unitName) {
			this.unitName = unitName;
		}
		public String getSubmitMen() {
			return submitMen;
		}
		public void setSubmitMen(String submitMen) {
			this.submitMen = submitMen;
		}
		public void setId(int id) {
			this.id = id;
		}
		public BigDecimal getFreight() {
			return freight;
		}
		public void setFreight(BigDecimal freight) {
			this.freight = freight;
		}
		public String getMoneyOrder() {
			return moneyOrder;
		}
		public void setMoneyOrder(String moneyOrder) {
			this.moneyOrder = moneyOrder;
		}
		public Integer getIsPay() {
			return isPay;
		}
		public void setIsPay(Integer isPay) {
			this.isPay = isPay;
		}
		public Integer getPayType() {
			return payType;
		}
		public void setPayType(Integer payType) {
			this.payType = payType;
		}
		
}
