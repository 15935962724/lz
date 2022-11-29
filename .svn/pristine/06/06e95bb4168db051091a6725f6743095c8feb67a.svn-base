package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

/**
 * 收货人
 * @author guodh
 * */
public class ShopOrderRecipient {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int member;
	private String consignees;		//收货人
	private String mobile;			//手机
	private String telphone;		//固话
	
	public ShopOrderRecipient(int id){
		this.id = id;
	}
	
	public static ShopOrderRecipient find(int id){
		ShopOrderRecipient aShopPackage = (ShopOrderRecipient)c.get(id);
		if(aShopPackage == null){
			ArrayList<ShopOrderRecipient> list = find(" AND id = " + id, 0, 1);
			aShopPackage = list.size() < 1 ? new ShopOrderRecipient(id):list.get(0);
		}
		return aShopPackage;
	}
	
	public static ShopOrderRecipient getObjByMember(int member){
		ArrayList<ShopOrderRecipient> list = find(" AND member = " + member, 0, 1);
		ShopOrderRecipient obj = list.size() < 1 ? new ShopOrderRecipient(0):list.get(0);
		return obj;
	}
	
	public static ArrayList<ShopOrderRecipient> find(String sql,int pos,int size){
		ArrayList<ShopOrderRecipient> list = new ArrayList<ShopOrderRecipient>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,member,consignees,mobile,telphone from ShopOrderRecipient where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				ShopOrderRecipient sn = new ShopOrderRecipient(rs.getInt(i++));
				sn.setMember(rs.getInt(i++));
				sn.setConsignees(rs.getString(i++));
				sn.setMobile(rs.getString(i++));
				sn.setTelphone(rs.getString(i++));
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
		return DbAdapter.execute("select count(0) from ShopOrderRecipient where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into ShopOrderRecipient(id,member,consignees,mobile,telphone) values(" 
				+ (this.id = Seq.get()) + "," + this.member + "," + DbAdapter.cite(this.consignees) + "," + DbAdapter.cite(this.mobile) + "," + DbAdapter.cite(this.telphone) +")";
		}else{
			sql = "update ShopOrderRecipient set member="+this.member+",consignees="+DbAdapter.cite(this.consignees)+",mobile="+DbAdapter.cite(this.mobile)+",telphone="+DbAdapter.cite(this.telphone) +" where id=" + this.id;
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
	
	public static void delete(int id){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(id,"delete from ShopOrderRecipient where id= " + id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(id);
	}
	
	public void set(String column,String value){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, "update ShopOrderRecipient set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
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

	
}
