package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Filex;
import tea.entity.Seq;

/**
 * 订单表附加
 * @author zcq
 * */
public class ShopOrderDispatch {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private String order_id;			//订单编号
	private String n_company;           //开票单位
	private String n_openbank;          //开户行
	private String n_accountNo;         //账号
	private String n_taxpayerid;        //纳税人识别号
	private String n_telphone;          //电话
	private String n_zip;               //邮编
	private int n_type;	                //发票类型：1普通，2专用
	private String n_invoiceNo;         //发票号
	private Date n_invoiceTime;         //开票日期
	private String n_expressNo;         //快递单号
	private String n_consignees;        //发票接收人
	private String n_address;           //地址
	
	private String n_remark;			//备注
	
	private Date n_invoiceTimeNew;      //新的开票日期（退货重新开的）
	private String n_invoiceNoNew;      //新的发票号（退货重新开的）
	
	private String sign_user_openid;	//扫码签收人 openid
	private Date sing_date;				//签收日期
	private int status;					//0寄出，1签收
	
	//收货人信息
	private String a_consignees;
	private int a_hospital_id;
	private String a_hospital;
	private String a_department;
	private String a_address;
	private String a_mobile;
	private String a_telphone;
	private String a_zipcode;
	//17年12.7加 后台取消开票后，设置取消开票时间和取消开票人
	private Date caninvotime;//取消开票时间
	private int caninvomember;//取消开票人
	
	public ShopOrderDispatch(int id){
		this.id = id;
	}
	
	public ShopOrderDispatch(String order_id){
		this.order_id = DbAdapter.cite(order_id);
	}
	
	public static ShopOrderDispatch find(int id){
		ShopOrderDispatch aShopPackage = (ShopOrderDispatch)c.get(id);
		if(aShopPackage == null){
			ArrayList<ShopOrderDispatch> list = find(" AND id = " + id, 0, 1);
			aShopPackage = list.size() < 1 ? new ShopOrderDispatch(id):list.get(0);
		}
		return aShopPackage;
	}
	
	public static ShopOrderDispatch findByOrderId(String order_id){
		ArrayList<ShopOrderDispatch> list = find(" AND order_id = " + DbAdapter.cite(order_id), 0, 1);
		ShopOrderDispatch aShopPackage = list.size() < 1 ? new ShopOrderDispatch(order_id):list.get(0);
		return aShopPackage;
	}
	
	public static ArrayList<ShopOrderDispatch> find(String sql,int pos,int size){
		ArrayList<ShopOrderDispatch> list = new ArrayList<ShopOrderDispatch>();
		DbAdapter db = new DbAdapter();
		String QSql = "select sod.id,sod.order_id,sod.n_company,sod.n_openbank,sod.n_accountNo,sod.n_taxpayerid,sod.n_telphone,sod.n_zip,sod.n_type,sod.n_invoiceNo,sod.n_invoiceTime,sod.n_expressNo,sod.n_consignees,sod.n_address,sod.a_consignees,sod.a_hospital,sod.a_address,sod.a_mobile,sod.a_telphone,sod.a_zipcode,sod.n_invoiceTimeNew,sod.n_invoiceNoNew,sod.a_hospital_id,sod.sign_user_openid,sod.sing_date,sod.status,sod.n_remark,sod.a_department,sod.caninvotime,sod.caninvomember from ShopOrderDispatch sod where 1=1 " + sql;
		if(sql.indexOf("PO1708010005")>-1){
			Filex.logs("ytlz.txt", "PO1708010005==="+QSql);
		}
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				if(sql.indexOf("PO1708010005")>-1){
					Filex.logs("ytlz.txt", "PO1708010005 WHILE====");
				}
				int i = 1;
				ShopOrderDispatch sod = new ShopOrderDispatch(rs.getInt(i++));
				sod.setOrder_id(rs.getString(i++));
				sod.setN_company(rs.getString(i++));
				sod.setN_openbank(rs.getString(i++));
				sod.setN_accountNo(rs.getString(i++));
				sod.setN_taxpayerid(rs.getString(i++));
				sod.setN_telphone(rs.getString(i++));
				sod.setN_zip(rs.getString(i++));
				sod.setN_type(rs.getInt(i++));
				sod.setN_invoiceNo(rs.getString(i++));
				sod.setN_invoiceTime(db.getDate(i++));
				sod.setN_expressNo(rs.getString(i++));
				sod.setN_consignees(rs.getString(i++));
				sod.setN_address(rs.getString(i++));
				sod.setA_consignees(rs.getString(i++));
				sod.setA_hospital(rs.getString(i++));
				sod.setA_address(rs.getString(i++));
				sod.setA_mobile(rs.getString(i++));
				sod.setA_telphone(rs.getString(i++));
				sod.setA_zipcode(rs.getString(i++));
				sod.setN_invoiceTimeNew(db.getDate(i++));
				sod.setN_invoiceNoNew(rs.getString(i++));
				sod.setA_hospital_id(rs.getInt(i++));
				sod.setSign_user_openid(rs.getString(i++));
				sod.setSing_date(db.getDate(i++));
				sod.setStatus(rs.getInt(i++));
				sod.setN_remark(rs.getString(i++));
				sod.setA_department(rs.getString(i++));
				sod.setCaninvotime(db.getDate(i++));
				sod.setCaninvomember(rs.getInt(i++));
				
				c.put(sod.id, sod);
				if(sql.indexOf("PO1708010005")>-1){
					Filex.logs("ytlz.txt", "PO1708010005 ADD===="+sod.id);
				}
				list.add(sod);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		if(sql.indexOf("PO1708010005")>-1){
			Filex.logs("ytlz.txt", "PO1708010005 SIZE===="+list.size());
		}
		
		return list;
	}
	
	public static int count(String sql) throws SQLException{
		return DbAdapter.execute("select count(0) from ShopOrderDispatch sod where 1=1 " + sql);
	}
	
	//查询医院名称
	public static ArrayList<String> searchHospital(String sql,int pos,int size) throws SQLException{
		ArrayList<String> list = new ArrayList<String>();
		DbAdapter db = new DbAdapter();
		String QSql = "select sod.a_hospital from ShopOrderDispatch sod where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				String hospital=rs.getString(i++);
				list.add(hospital);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into ShopOrderDispatch(id,order_id,n_company,n_openbank,n_accountNo,n_taxpayerid,n_telphone,n_zip,n_type,n_invoiceNo,n_invoiceTime,n_expressNo,n_consignees,n_address,a_consignees,a_hospital,a_department,a_address,a_mobile,a_telphone,a_zipcode,n_invoiceTimeNew,n_invoiceNoNew,a_hospital_id,sign_user_openid,sing_date,status,n_remark,caninvotime,caninvomember) values(" 
				+ (this.id = Seq.get()) + ","+order_id + ","+DbAdapter.cite(this.n_company) + ","+DbAdapter.cite(this.n_openbank) + ","+DbAdapter.cite(this.n_accountNo) + ","+DbAdapter.cite(this.n_taxpayerid)
				+ ","+DbAdapter.cite(this.n_telphone) + ","+DbAdapter.cite(this.n_zip) + ","+this.n_type + ","+DbAdapter.cite(this.n_invoiceNo) + ","+DbAdapter.cite(this.n_invoiceTime) + ","+DbAdapter.cite(this.n_expressNo) + ","+DbAdapter.cite(this.n_consignees) + ","+DbAdapter.cite(this.n_address) + ","+DbAdapter.cite(this.a_consignees) + ","+DbAdapter.cite(this.a_hospital) + ","+DbAdapter.cite(this.a_department)
				+ ","+DbAdapter.cite(this.a_address) + ","+DbAdapter.cite(this.a_mobile) + ","+DbAdapter.cite(this.a_telphone) + ","+DbAdapter.cite(this.a_zipcode) + ","+DbAdapter.cite(this.n_invoiceTimeNew)+ ","+DbAdapter.cite(this.n_invoiceNoNew)+ ","+this.a_hospital_id+ ","+DbAdapter.cite(this.sign_user_openid)+ ","+DbAdapter.cite(this.sing_date) + ","+status+ ","+DbAdapter.cite(this.n_remark)+","+DbAdapter.cite(this.caninvotime) +","+this.caninvomember+ ")";
		}else{
			sql = "update ShopOrderDispatch set n_company="+DbAdapter.cite(this.n_company)+",n_openbank="+DbAdapter.cite(this.n_openbank)+",n_accountNo="+DbAdapter.cite(this.n_accountNo)+",n_taxpayerid="+DbAdapter.cite(this.n_taxpayerid)
				+",n_telphone="+DbAdapter.cite(this.n_telphone)+",n_zip="+DbAdapter.cite(this.n_zip)+",n_type="+this.n_type+",n_invoiceNo="+DbAdapter.cite(this.n_invoiceNo)+",n_invoiceTime="+DbAdapter.cite(this.n_invoiceTime)+",n_expressNo="+DbAdapter.cite(this.n_expressNo)+",n_consignees="+DbAdapter.cite(this.n_consignees)+",n_address="+DbAdapter.cite(this.n_address)
				+",a_consignees="+DbAdapter.cite(this.a_consignees)+",a_hospital="+DbAdapter.cite(this.a_hospital)+",a_department="+DbAdapter.cite(this.a_department)+",a_address="+DbAdapter.cite(this.a_address)+",a_mobile="+DbAdapter.cite(this.a_mobile)+",a_telphone="+DbAdapter.cite(this.a_telphone)+",a_zipcode="+DbAdapter.cite(this.a_zipcode)+",n_invoiceTimeNew="+DbAdapter.cite(this.n_invoiceTimeNew)+",n_invoiceNoNew="+DbAdapter.cite(this.n_invoiceNoNew)+",a_hospital_id="+this.a_hospital_id
				+",sign_user_openid="+DbAdapter.cite(this.sign_user_openid)+",sing_date="+DbAdapter.cite(this.sing_date)+",status="+status+",n_remark="+DbAdapter.cite(this.n_remark)+",caninvotime="+DbAdapter.cite(this.caninvotime)+",caninvomember="+this.caninvomember+ " where id=" + this.id;
		}
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, sql);
		} catch (SQLException e) {
			e.printStackTrace();
			Filex.logs("ytnotfp.txt", "报错：");
		}finally{
			Filex.logs("ytnotfp.txt", "保存发票成功："+this.n_invoiceNo+"--"+this.n_expressNo+"--"+this.n_invoiceTime);
			db.close();
		}
		c.remove(this.id);
	}
	
	public void delete(){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id,"delete from ShopOrderDispatch where id= " + this.id);
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
			db.executeUpdate(this.id, "update ShopOrderDispatch set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getN_company() {
		return n_company;
	}
	public void setN_company(String n_company) {
		this.n_company = n_company;
	}
	public String getN_openbank() {
		return n_openbank;
	}
	public void setN_openbank(String n_openbank) {
		this.n_openbank = n_openbank;
	}
	public String getN_accountNo() {
		return n_accountNo;
	}
	public void setN_accountNo(String n_accountNo) {
		this.n_accountNo = n_accountNo;
	}
	public String getN_taxpayerid() {
		return n_taxpayerid;
	}
	public void setN_taxpayerid(String n_taxpayerid) {
		this.n_taxpayerid = n_taxpayerid;
	}
	public String getN_telphone() {
		return n_telphone;
	}
	public void setN_telphone(String n_telphone) {
		this.n_telphone = n_telphone;
	}
	public String getN_zip() {
		return n_zip;
	}
	public void setN_zip(String n_zip) {
		this.n_zip = n_zip;
	}
	public int getN_type() {
		return n_type;
	}
	public void setN_type(int n_type) {
		this.n_type = n_type;
	}
	public String getN_invoiceNo() {
		return n_invoiceNo;
	}
	public void setN_invoiceNo(String n_invoiceNo) {
		this.n_invoiceNo = n_invoiceNo;
	}
	public Date getN_invoiceTime() {
		return n_invoiceTime;
	}
	public void setN_invoiceTime(Date n_invoiceTime) {
		this.n_invoiceTime = n_invoiceTime;
	}
	public String getN_expressNo() {
		return n_expressNo;
	}
	public void setN_expressNo(String n_expressNo) {
		this.n_expressNo = n_expressNo;
	}
	public String getN_consignees() {
		return n_consignees;
	}
	public void setN_consignees(String n_consignees) {
		this.n_consignees = n_consignees;
	}
	public String getN_address() {
		return n_address;
	}
	public void setN_address(String n_address) {
		this.n_address = n_address;
	}
	public String getA_consignees() {
		return a_consignees;
	}
	public void setA_consignees(String a_consignees) {
		this.a_consignees = a_consignees;
	}
	public String getA_hospital() {
		return a_hospital;
	}
	public void setA_hospital(String a_hospital) {
		this.a_hospital = a_hospital;
	}
	public String getA_address() {
		return a_address;
	}
	public void setA_address(String a_address) {
		this.a_address = a_address;
	}
	public String getA_mobile() {
		return a_mobile;
	}
	public void setA_mobile(String a_mobile) {
		this.a_mobile = a_mobile;
	}
	public String getA_telphone() {
		return a_telphone;
	}
	public void setA_telphone(String a_telphone) {
		this.a_telphone = a_telphone;
	}
	public String getA_zipcode() {
		return a_zipcode;
	}
	public void setA_zipcode(String a_zipcode) {
		this.a_zipcode = a_zipcode;
	}

	public Date getN_invoiceTimeNew() {
		return n_invoiceTimeNew;
	}

	public void setN_invoiceTimeNew(Date nInvoiceTimeNew) {
		n_invoiceTimeNew = nInvoiceTimeNew;
	}

	public String getN_invoiceNoNew() {
		return n_invoiceNoNew;
	}

	public void setN_invoiceNoNew(String nInvoiceNoNew) {
		n_invoiceNoNew = nInvoiceNoNew;
	}

	public String getA_department() {
		return a_department;
	}

	public void setA_department(String aDepartment) {
		a_department = aDepartment;
	}

	public int getA_hospital_id() {
		return a_hospital_id;
	}

	public void setA_hospital_id(int aHospitalId) {
		a_hospital_id = aHospitalId;
	}

	public String getSign_user_openid() {
		return sign_user_openid;
	}

	public void setSign_user_openid(String sign_user_openid) {
		this.sign_user_openid = sign_user_openid;
	}

	public Date getSing_date() {
		return sing_date;
	}

	public void setSing_date(Date sing_date) {
		this.sing_date = sing_date;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getN_remark() {
		return n_remark;
	}

	public void setN_remark(String n_remark) {
		this.n_remark = n_remark;
	}

	public Date getCaninvotime() {
		return caninvotime;
	}

	public void setCaninvotime(Date caninvotime) {
		this.caninvotime = caninvotime;
	}

	public int getCaninvomember() {
		return caninvomember;
	}

	public void setCaninvomember(int caninvomember) {
		this.caninvomember = caninvomember;
	}
	
	

}
