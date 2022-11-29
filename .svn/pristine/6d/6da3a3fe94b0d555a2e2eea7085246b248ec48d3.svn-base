package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

/**
 * 发票
 * @author guodh
 * */
public class ShopNvoice {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int member;				//用户ID
	private String company;			//医院名称
	private String openbank;		//开户行
	private String accountNo;		//账号
	private String taxpayerId;		//纳税人识别号
	private String telphone;		//电话
	private String zip;				//邮编
	private String address;			//地址
	private int type;				//发票类型；1增值税普通，2增值税专用
	private String consignees;      //发票接收人
	private String remark;			//备注
	
	public ShopNvoice(int id){
		this.id = id;
	}
	
	public static ShopNvoice find(int id){
		ShopNvoice aShopPackage = (ShopNvoice)c.get(id);
		if(aShopPackage == null){
			ArrayList<ShopNvoice> list = find(" AND id = " + id, 0, 1);
			aShopPackage = list.size() < 1 ? new ShopNvoice(id):list.get(0);
		}
		return aShopPackage;
	}
	
	public static ShopNvoice getObjByMember(int member){
		ArrayList<ShopNvoice> list = find(" AND member = " + member, 0, 1);
		ShopNvoice obj = list.size() < 1 ? new ShopNvoice(0):list.get(0);
		return obj;
	}
	
	public static ArrayList<ShopNvoice> find(String sql,int pos,int size){
		ArrayList<ShopNvoice> list = new ArrayList<ShopNvoice>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,member,company,openbank,accountno,taxpayerid,telphone,zip,address,type,consignees,remark from shopNvoice where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				ShopNvoice sn = new ShopNvoice(rs.getInt(i++));
				sn.setMember(rs.getInt(i++));
				sn.setCompany(rs.getString(i++));
				sn.setOpenbank(rs.getString(i++));
				sn.setAccountNo(rs.getString(i++));
				sn.setTaxpayerId(rs.getString(i++));
				sn.setTelphone(rs.getString(i++));
				sn.setZip(rs.getString(i++));
				sn.setAddress(rs.getString(i++));
				sn.setType(rs.getInt(i++));
				sn.setConsignees(rs.getString(i++));
				sn.setRemark(rs.getString(i++));
				
				c.put(sn.id, sn);
				list.add(sn);
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
		return DbAdapter.execute("select count(0) from shopNvoice where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into shopNvoice(id,member,company,openbank,accountno,taxpayerid,telphone,zip,address,type,consignees,remark) values(" 
				+ (this.id = Seq.get()) + "," + this.member + "," + DbAdapter.cite(this.company) + "," + DbAdapter.cite(this.openbank) + "," + DbAdapter.cite(this.accountNo) + "," + DbAdapter.cite(this.taxpayerId) + "," + DbAdapter.cite(this.telphone) + "," + DbAdapter.cite(this.zip) + "," + DbAdapter.cite(this.address) + "," + this.type+","+DbAdapter.cite(this.consignees)+","+DbAdapter.cite(this.remark) + ")";
		}else{
			sql = "update shopNvoice set member="+this.member+",company="+DbAdapter.cite(this.company)+",openbank="+DbAdapter.cite(this.openbank)+",accountno="+DbAdapter.cite(this.accountNo)+",taxpayerid="+DbAdapter.cite(this.taxpayerId)+",telphone="+DbAdapter.cite(this.telphone)+",zip="+DbAdapter.cite(this.zip)+",address="+DbAdapter.cite(this.address)+",type= "+ this.type +",consignees="+DbAdapter.cite(this.consignees)+",remark="+DbAdapter.cite(this.remark) + " where id=" + this.id;
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
			db.executeUpdate(this.id,"delete from shopNvoice where id= " + this.id);
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
			db.executeUpdate(this.id, "update shopNvoice set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
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

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getOpenbank() {
		return openbank;
	}

	public void setOpenbank(String openbank) {
		this.openbank = openbank;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public String getTaxpayerId() {
		return taxpayerId;
	}

	public void setTaxpayerId(String taxpayerId) {
		this.taxpayerId = taxpayerId;
	}

	public String getTelphone() {
		return telphone;
	}

	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getConsignees() {
		return consignees;
	}

	public void setConsignees(String consignees) {
		this.consignees = consignees;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
