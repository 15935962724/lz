package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

/**
 * 收货地址
 * @author guodh
 * */
public class ShopOrderAddress {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int member;				//用户ID
	private int hospitalId;			//医院ID
	private String consignees;		//收货人
	private int consignees_id;		//收货人ID
	private String hospital;		//医院
	private String address;			//详细地址
	private String mobile;			//手机
	private String telphone;		//固话
	private int city;				//所在地区
	private String department;		//科室
	private String zipcode;         //邮编
	
	private int sor_id;	//收人ID
	
	public ShopOrderAddress(int id){
		this.id = id;
	}
	
	public static ShopOrderAddress find(int id){
		ShopOrderAddress aShopPackage = (ShopOrderAddress)c.get(id);
		if(aShopPackage == null){
			ArrayList<ShopOrderAddress> list = find(" AND id = " + id, 0, 1);
			aShopPackage = list.size() < 1 ? new ShopOrderAddress(id):list.get(0);
		}
		return aShopPackage;
	}
	
	//获取收货人地址信息
	public static ShopOrderAddress getMember(int consignees_id){
		ArrayList<ShopOrderAddress> list = find(" AND consignees_id = " + consignees_id, 0, 1);
		ShopOrderAddress obj = list.size() < 1 ? new ShopOrderAddress(0):list.get(0);
		return obj;
	}
	
	public static ShopOrderAddress getObjByMember(int member){
		ArrayList<ShopOrderAddress> list = find(" AND member = " + member +" order by id desc", 0, 1);
		ShopOrderAddress obj = list.size() < 1 ? new ShopOrderAddress(0):list.get(0);
		return obj;
	}
	
	public static ShopOrderAddress getObjByMember(int member,int hosid){
		ArrayList<ShopOrderAddress> list = find(" AND member = " + member +" AND hospitalId = "+hosid+" order by id desc", 0, 1);
		ShopOrderAddress obj = list.size() < 1 ? new ShopOrderAddress(0):list.get(0);
		return obj;
	}
	
	public static ArrayList<ShopOrderAddress> find(String sql,int pos,int size){
		ArrayList<ShopOrderAddress> list = new ArrayList<ShopOrderAddress>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,member,consignees,consignees_id,hospital,address,mobile,telphone,city,department,zipcode,hospitalId,sor_id from shopOrderAddress where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				ShopOrderAddress sn = new ShopOrderAddress(rs.getInt(i++));
				sn.setMember(rs.getInt(i++));
				sn.setConsignees(rs.getString(i++));
				sn.setConsignees_id(rs.getInt(i++));
				sn.setHospital(rs.getString(i++));
				sn.setAddress(rs.getString(i++));
				sn.setMobile(rs.getString(i++));
				sn.setTelphone(rs.getString(i++));
				sn.setCity(rs.getInt(i++));
				sn.setDepartment(rs.getString(i++));
				sn.setZipcode(rs.getString(i++));
				sn.setHospitalId(rs.getInt(i++));
				sn.setSor_id(rs.getInt(i++));
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
		return DbAdapter.execute("select count(0) from shopOrderAddress where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into shopOrderAddress(id,member,consignees,consignees_id,hospital,address,mobile,telphone,city,department,zipcode,hospitalId,sor_id) values(" 
				+ (this.id = Seq.get()) + "," + this.member + "," + DbAdapter.cite(this.consignees) + "," + consignees_id + "," + DbAdapter.cite(this.hospital) + "," + DbAdapter.cite(this.address) + "," + DbAdapter.cite(this.mobile) + "," + DbAdapter.cite(this.telphone) + ","+city+","+DbAdapter.cite(department)+","+DbAdapter.cite(zipcode)+","+hospitalId+","+sor_id+")";
		}else{
			sql = "update shopOrderAddress set member="+this.member+",consignees="+DbAdapter.cite(this.consignees)+",consignees_id="+this.consignees_id+",hospital="+DbAdapter.cite(this.hospital)+",address="+DbAdapter.cite(this.address)+",mobile="+DbAdapter.cite(this.mobile)+",telphone="+DbAdapter.cite(this.telphone)+ ",city="+city+",department="+DbAdapter.cite(department)+",zipcode="+DbAdapter.cite(zipcode)+",hospitalId="+hospitalId+",sor_id="+sor_id+" where id=" + this.id;
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
			db.executeUpdate(this.id,"delete from shopOrderAddress where id= " + this.id);
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
			db.executeUpdate(this.id, "update shopOrderAddress set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
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

	public String getConsignees() {
		return consignees;
	}

	public void setConsignees(String consignees) {
		this.consignees = consignees;
	}

	public String getHospital() {
		return hospital;
	}

	public void setHospital(String hospital) {
		this.hospital = hospital;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getTelphone() {
		return telphone;
	}

	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}

	public int getCity() {
		return city;
	}

	public void setCity(int city) {
		this.city = city;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public int getHospitalId() {
		return hospitalId;
	}

	public void setHospitalId(int hospitalId) {
		this.hospitalId = hospitalId;
	}

	public int getSor_id() {
		return sor_id;
	}

	public void setSor_id(int sorId) {
		sor_id = sorId;
	}

	public int getConsignees_id() {
		return consignees_id;
	}

	public void setConsignees_id(int consignees_id) {
		this.consignees_id = consignees_id;
	}
	
}
