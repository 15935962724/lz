package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

/**
 * 积分规则
 * */
public class ShopIntegralRules {

protected static Cache c = new Cache(50);
	
	private int id;		
	private String item;		//积分项
	private int integral;		//积分
	
	public ShopIntegralRules(int id){
		this.id = id;
	}
	
	public static ShopIntegralRules find(int id){
		ShopIntegralRules aHospital = (ShopIntegralRules)c.get(id);
		if(aHospital == null){
			ArrayList<ShopIntegralRules> list = find(" AND id = " + id, 0, 1);
			aHospital = list.size() < 1 ? new ShopIntegralRules(id):list.get(0);
		}
		return aHospital;
	}
	
	public static ShopIntegralRules findByItem(int id){
		ShopIntegralRules aHospital = (ShopIntegralRules)c.get(id);
		if(aHospital == null){
			ArrayList<ShopIntegralRules> list = find(" AND item = " + id, 0, 1);
			aHospital = list.size() < 1 ? new ShopIntegralRules(0):list.get(0);
		}
		return aHospital;
	}
	
	public static ArrayList<ShopIntegralRules> find(String sql,int pos,int size){
		ArrayList<ShopIntegralRules> list = new ArrayList<ShopIntegralRules>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,item,integeral from shopIntegralRules where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				ShopIntegralRules h = new ShopIntegralRules(rs.getInt(i++));
				h.item = rs.getString(i++);
				h.integral = rs.getInt(i++);
				
				c.put(h.id, h);
				list.add(h);
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
		return DbAdapter.execute("select count(0) from shopIntegralRules where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into shopIntegralRules(id,item,integeral) values(" + (this.id = Seq.get()) + "," + DbAdapter.cite(this.item) + "," + this.integral + ")";
		}else{
			sql = "update shopIntegralRules set item="+ DbAdapter.cite(this.item) +",integeral=" + this.integral + " where id=" + this.id;
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
			db.executeUpdate(id,"delete from shopIntegralRules where id= " + id);
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
			db.executeUpdate(this.id, "update shopIntegralRules set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
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

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public int getIntegral() {
		return integral;
	}

	public void setIntegral(int integral) {
		this.integral = integral;
	}

}
