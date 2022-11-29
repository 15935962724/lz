package tea.entity.yl.shopnew;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;
import tea.entity.yl.shop.ProcurementUnitJoin;
import util.DateUtil;

/**
 * 发票主表
 * @author yt
 * */
public class Invoice {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private String invoiceno;				//发票号
	private int status;			            //状态 0:未开票  1：已审核 2:已开具 3:审核不通过 4:退票申请 中  5:同意退票 2：拒绝退票(同已开具发票)
	public static String[] STATUS={"未开票","已审核","已开具","审核不通过","退票申请中","同意退票"};
	private int member;		                //索要人
	private int hospitalid;		            //医院id
	private String hospital;		        //医院
	private String consigness;		        //收票人
	private String address;				    //收票地址
	private String telphone;			    //收票人电话
	private Date createdate;                //索要发票时间
	private int num;			            //开票数量
	private float amount;                   //开票金额
	private String remark;                  //备注
	private String membername;              //服务商名称
	private String courierno;               //快递单号
	private Date makeoutdate;               //开票日期
	private String internalremark;          //内部备注
	private String nominalremark;           //票面备注
	private String reason;                  //订单管理员拒绝开票原因
	private String backreason;              //服务商退票原因
	private String backcourierno;           //退票快递单号
	private String nobackreason;            //订单管理员拒绝退票原因
	private int matchstatus;                //回款是否匹配该发票 0：否 1：待审核  2：已匹配(指管理员审核通过）
	private int issign;                     //是否已签收
	private Date signdate;                  //签收日期
	private int signmember;                 //签收人id
	private String signopenid;              //签收人openid
	
	private int puid;						//厂商id
	private int mateType; 					//服务费发票匹配记录  0,未匹配  1,已匹配
	
	
	private int applyUnit;//申请医院 0为服务商 其他为医院id
	
	private int deductionstype;//扣款状态  0未扣款 1已扣款 未还款 2已扣款 已还款

	private float adjustmentService;//调整服务费

	private String activity;//开票活度

	public Invoice(int id){
		this.id = id;
	}
	
	public static Invoice find(int id){
		Invoice invoice = (Invoice)c.get(id);
		if(invoice == null){
			ArrayList<Invoice> list = find(" AND id = " + id, 0, 1);
			invoice = list.size() < 1 ? new Invoice(id):list.get(0);
		}
		return invoice;
	}
	
	
	public static ArrayList<Invoice> find(String sql,int pos,int size){
		ArrayList<Invoice> list = new ArrayList<Invoice>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,invoiceno,status,member,hospitalid,hospital,consigness,address,telphone," +
				"createdate,num,amount,remark,membername,courierno,makeoutdate,internalremark,nominalremark," +
				"reason,backreason,backcourierno,nobackreason,matchstatus,issign,signdate,signmember,signopenid,puid,mateType,deductionstype,applyUnit,adjustmentService,activity from invoice where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				Invoice invoice = new Invoice(rs.getInt(i++));
				invoice.setInvoiceno(rs.getString(i++));
				invoice.setStatus(rs.getInt(i++));
				invoice.setMember(rs.getInt(i++));
				invoice.setHospitalid(rs.getInt(i++));
				invoice.setHospital(rs.getString(i++));
				invoice.setConsigness(rs.getString(i++));
				invoice.setAddress(rs.getString(i++));
				invoice.setTelphone(rs.getString(i++));
				invoice.setCreatedate(db.getDate(i++));
				invoice.setNum(rs.getInt(i++));
				invoice.setAmount(rs.getFloat(i++));
				invoice.setRemark(rs.getString(i++));
				invoice.setMembername(rs.getString(i++));
				invoice.setCourierno(rs.getString(i++));
				invoice.setMakeoutdate(db.getDate(i++));
				invoice.setInternalremark(rs.getString(i++));
				invoice.setNominalremark(rs.getString(i++));
				invoice.setReason(rs.getString(i++));
				invoice.setBackreason(rs.getString(i++));
				invoice.setBackcourierno(rs.getString(i++));
				invoice.setNobackreason(rs.getString(i++));
				invoice.setMatchstatus(rs.getInt(i++));
				invoice.setIssign(rs.getInt(i++));
				invoice.setSigndate(db.getDate(i++));
				invoice.setSignmember(rs.getInt(i++));
				invoice.setSignopenid(rs.getString(i++));
				invoice.setPuid(rs.getInt(i++));
				invoice.setMateType(rs.getInt(i++));
				invoice.setDeductionstype(rs.getInt(i++));
				invoice.setApplyUnit(rs.getInt(i++));
				invoice.setAdjustmentService(rs.getInt(i++));
				invoice.setActivity(rs.getString(i++));
				c.put(invoice.id, invoice);
				list.add(invoice);
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
		return DbAdapter.execute("select count(0) from invoice where 1=1 " + sql);
	}
	
	public static int sumquantity(String sql) throws SQLException{
		return DbAdapter.execute("select sum(num) from invoice where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into invoice(id,invoiceno,status,member,hospitalid,hospital,consigness,address,telphone," +
					"createdate,num,amount,remark,membername,courierno,makeoutdate,internalremark,nominalremark,reason," +
					"backreason,backcourierno,nobackreason,matchstatus,issign,signdate,signmember,signopenid,puid,mateType,deductionstype,applyUnit,adjustmentService,activity) values("
				+ (this.id = Seq.get()) + "," + DbAdapter.cite(this.invoiceno) + "," + this.status + "," + this.member + "," 
					+ this.hospitalid + "," + DbAdapter.cite(this.hospital) + "," + DbAdapter.cite(this.consigness) + "," 
				+ DbAdapter.cite(this.address) + "," + DbAdapter.cite(this.telphone) + "," + DbAdapter.cite(this.createdate) 
				+ "," + this.num + "," + this.amount + "," + DbAdapter.cite(this.remark)+","+DbAdapter.cite(this.membername) 
				+ "," +DbAdapter.cite(this.courierno)+","+DbAdapter.cite(this.makeoutdate)+","+DbAdapter.cite(this.internalremark)+","
				+ DbAdapter.cite(this.nominalremark)+","+DbAdapter.cite(this.reason)+","+DbAdapter.cite(this.backreason)
				+","+DbAdapter.cite(this.backcourierno)+","+DbAdapter.cite(this.nobackreason)+","+this.matchstatus
				+","+this.issign+","+DbAdapter.cite(this.signdate)+","+this.signmember+","+DbAdapter.cite(this.signopenid)
				+ ","+this.puid+","+this.mateType+","+deductionstype+","+applyUnit+","+adjustmentService+","+ Database.cite(activity) +")";
		}else{
			sql = "update invoice set invoiceno=" + DbAdapter.cite(this.invoiceno) +",status="+this.status+",member="+this.member
					+",hospitalid="+this.hospitalid+",hospital="+DbAdapter.cite(this.hospital)+",consigness="+DbAdapter.cite(this.consigness)
					+",address="+DbAdapter.cite(this.address)+",telphone="+DbAdapter.cite(this.telphone)+",createdate= "+DbAdapter.cite(this.createdate)
					+",num="+ this.num + ",amount="+this.amount+",remark="+DbAdapter.cite(this.remark)+",membername="+DbAdapter.cite(membername) 
					+",courierno="+DbAdapter.cite(this.courierno)+",makeoutdate="+DbAdapter.cite(this.makeoutdate)
					+",internalremark="+DbAdapter.cite(this.internalremark)+",nominalremark="+DbAdapter.cite(this.nominalremark)
					+",reason="+DbAdapter.cite(this.reason)+",backreason="+DbAdapter.cite(this.backreason)+",backcourierno="
					+DbAdapter.cite(this.backcourierno)+",nobackreason="+DbAdapter.cite(this.nobackreason)+",matchstatus="+this.matchstatus
					+",issign="+this.issign+",signdate="+DbAdapter.cite(this.signdate)+",signmember="+this.signmember
					+",signopenid="+DbAdapter.cite(this.signopenid)
					+ ",puid="+this.puid+",mateType="+this.mateType+",deductionstype="+deductionstype+",applyUnit="+applyUnit+",adjustmentService="+adjustmentService+",activity="+Database.cite(activity)+" where id=" + this.id;
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

	/**
	 * 计提服务费
	 * @param tax    	// 税金类型
	 * @param id   		// 发票id
	 * @return
	 */
	public static Map<String,Double> getTaxAmount(int tax, int id, Double d1, Double d2) throws SQLException {


		Map<String,Double> gsmap = Invoice.updategs(id);
		d1 = gsmap.get("gs1");
		d2 = gsmap.get("gs2");
		//System.out.println("d1="+d1+"d2="+d2);

		HashMap<String, Double> map = new HashMap<String, Double>();
		//tax = tax==0?1:tax;
		Float taxamount = 0F;
		Invoice invoice = find(id);
		int phpuid = InvoiceData.getPuid(invoice.getId());
        //ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.member);
		ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.member,invoice.getHospitalid());

        // 计算服务费:(开票价格-底价)*0.9844*数量/1.13
        Double chargeamountsum = 0.0;

        try{
			if(puj.formula!=0){
				if(invoice.getNum()!=0){
					chargeamountsum = (invoice.getAmount()/invoice.getNum()-puj.agentPriceNew)*d1*invoice.getNum()/d2;
				}else{
					chargeamountsum = 0.0;
				}
			}
		}catch (Throwable e){
        	System.out.println(e.toString());
		}


		if(tax==1){
			taxamount=(float) (chargeamountsum/1.06*0.06);
		}else if(tax==2){
			taxamount=(float) ((chargeamountsum/1.06*0.06)/2);
		}else if(tax==3){
			taxamount=(float) (chargeamountsum/1.03*0.03);
		}else if(tax==4){
			taxamount=(float) ((chargeamountsum/1.03*0.03)/2);
		}

		if(invoice.getAdjustmentService()>0){//调整过
			map.put("chargeamountsum", Double.valueOf(invoice.getAdjustmentService()));
			map.put("taxamount",0.0);
		}else{
			map.put("chargeamountsum",chargeamountsum);
			map.put("taxamount", Double.valueOf(taxamount));
		}

		return map;
	}
	
	public void delete(){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id,"delete from invoice where id= " + this.id);
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
			db.executeUpdate(this.id, "update invoice set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	/**
	 * 计算服务费
	 * @param id
	 * @return
	 */
	public static float findfwf(int id) {
		float fwf = 0;
		try {
			Invoice t= Invoice.find(id);

			//ProcurementUnitJoin puj = ProcurementUnitJoin.find(t.getPuid(), t.getMember());
			ProcurementUnitJoin puj = ProcurementUnitJoin.find(t.getPuid(), t.getMember(),t.getHospitalid());
			Map<String,Double> imap =  Invoice.getTaxAmount(puj.tax, t.getId(), 0.9844, 1.13);
			double mysum = imap.get("chargeamountsum")+imap.get("taxamount");
			BigDecimal b2=new BigDecimal(mysum);
			double taxamount2=(double) b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();//服务费
			fwf = (float) taxamount2;
		}catch (Exception e) {

		}
		return fwf;
	}
	
	/**
	 * 计算天数
	 * @param id
	 * @return
	 */
	public static long finddaycha(int id) {
		Invoice t= Invoice.find(id);
		long daycha = 0;
		try {
			//makeoutdate 改为开票时间
			daycha = DateUtil.datesub(new Date(), t.getMakeoutdate());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return daycha;
	}


	public static Map<String,Double> updategs(int tid){
		Map<String,Double> gsmap = new HashMap<String, Double>();
		try{

		int phpuid = InvoiceData.getPuid(tid);
		Invoice t=Invoice.find(tid);
		ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, t.getMember(),t.getHospitalid());

		boolean flag = false;//true 新公式
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date fdate2019=sdf.parse("2019-04-01 00:00:00");//开始新公式

			if(t.getMakeoutdate()==null){
				t.setMakeoutdate(new Date());
			}

		if(t.getMakeoutdate().getTime()>=fdate2019.getTime()) {//最新公式
			flag = true;
		}
		double gs1 = 0.9844;
		double gs2 = 1.13;
		if(!flag){
			gs1 = ProcurementUnitJoin.gs1[puj.formula];
			gs2 = ProcurementUnitJoin.gs2[puj.formula];
		}
		gsmap.put("gs1",gs1);
		gsmap.put("gs2",gs2);

		}catch (Throwable e){
			System.out.println(e.toString());
		}

		return gsmap;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	public String getInvoiceno() {
		return invoiceno;
	}

	public void setInvoiceno(String invoiceno) {
		this.invoiceno = invoiceno;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	public int getHospitalid() {
		return hospitalid;
	}

	public void setHospitalid(int hospitalid) {
		this.hospitalid = hospitalid;
	}

	public String getHospital() {
		return hospital;
	}

	public void setHospital(String hospital) {
		this.hospital = hospital;
	}

	public String getConsigness() {
		return consigness;
	}

	public void setConsigness(String consigness) {
		this.consigness = consigness;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTelphone() {
		return telphone;
	}

	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getMembername() {
		return membername;
	}

	public void setMembername(String membername) {
		this.membername = membername;
	}

	public String getCourierno() {
		return courierno;
	}

	public void setCourierno(String courierno) {
		this.courierno = courierno;
	}
	
	public Date getMakeoutdate() {
		return makeoutdate;
	}

	public void setMakeoutdate(Date makeoutdate) {
		this.makeoutdate = makeoutdate;
	}

	public String getInternalremark() {
		return internalremark;
	}

	public void setInternalremark(String internalremark) {
		this.internalremark = internalremark;
	}

	public String getNominalremark() {
		return nominalremark;
	}

	public void setNominalremark(String nominalremark) {
		this.nominalremark = nominalremark;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getBackreason() {
		return backreason;
	}

	public void setBackreason(String backreason) {
		this.backreason = backreason;
	}

	public String getBackcourierno() {
		return backcourierno;
	}

	public void setBackcourierno(String backcourierno) {
		this.backcourierno = backcourierno;
	}

	public String getNobackreason() {
		return nobackreason;
	}

	public void setNobackreason(String nobackreason) {
		this.nobackreason = nobackreason;
	}

	public int getMatchstatus() {
		return matchstatus;
	}

	public void setMatchstatus(int matchstatus) {
		this.matchstatus = matchstatus;
	}

	public int getIssign() {
		return issign;
	}

	public void setIssign(int issign) {
		this.issign = issign;
	}

	public Date getSigndate() {
		return signdate;
	}

	public void setSigndate(Date signdate) {
		this.signdate = signdate;
	}

	public int getSignmember() {
		return signmember;
	}

	public void setSignmember(int signmember) {
		this.signmember = signmember;
	}

	public String getSignopenid() {
		return signopenid;
	}

	public void setSignopenid(String signopenid) {
		this.signopenid = signopenid;
	}

	public int getPuid() {
		return puid;
	}

	public void setPuid(int puid) {
		this.puid = puid;
	}

	public int getMateType() {
		return mateType;
	}

	public void setMateType(int mateType) {
		this.mateType = mateType;
	}

	public int getDeductionstype() {
		return deductionstype;
	}

	public void setDeductionstype(int deductionstype) {
		this.deductionstype = deductionstype;
	}

	public int getApplyUnit() {
		return applyUnit;
	}

	public void setApplyUnit(int applyUnit) {
		this.applyUnit = applyUnit;
	}

	public float getAdjustmentService() {
		return adjustmentService;
	}

	public void setAdjustmentService(float adjustmentService) {
		this.adjustmentService = adjustmentService;
	}

	public String getActivity() {
		return activity;
	}

	public void setActivity(String activity) {
		this.activity = activity;
	}
}
