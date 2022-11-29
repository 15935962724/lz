package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

/**
 * 产品规格/型号
 * @author guo
 * */
public class ShopProductModel {
	protected static Cache c = new Cache(50);
	
	private int id;
	private int category;		//产品小类-分类ID
	private String model;		//产品规格/型号
	
	public ShopProductModel(int id){
		this.id = id;
	}
	
	public static ShopProductModel find(int id){
		ShopProductModel spm = (ShopProductModel)c.get(id);
		if(spm == null){
			ArrayList<ShopProductModel> list = find(" AND id=" + id, 0, 1);
			spm = list.size() < 1 ? new ShopProductModel(id):list.get(0);
		}
		return spm;
	}

	public static ShopProductModel findCat(int cid){
		ShopProductModel spm = (ShopProductModel)c.get(0);
		if(spm == null){
			ArrayList<ShopProductModel> list = find(" AND category=" + cid, 0, 1);
			spm = list.size() < 1 ? new ShopProductModel(0):list.get(0);
		}
		return spm;
	}
	
	public static ArrayList<ShopProductModel> find(String sql,int pos,int size){
		ArrayList<ShopProductModel> list = new ArrayList<ShopProductModel>();
		String QSql = "select id,category,model from shopproduct_model where 1=1 " + sql;
		DbAdapter db = new DbAdapter();
		try {
		 	ResultSet rs = db.executeQuery(QSql, pos, size);
		 	while(rs.next()){
		 		int i = 1;
		 		ShopProductModel spm = new ShopProductModel(rs.getInt(i++));
		 		spm.setCategory(rs.getInt(i++));
		 		spm.setModel(rs.getString(i++));
		 		
		 		c.put(spm.getId(), spm);
		 		list.add(spm);
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
		return DbAdapter.execute("select count(0) from shopproduct_model where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into shopproduct_model(id,category,model) values(" + (this.id=Seq.get()) + "," + this.category + "," + DbAdapter.cite(this.model) + ")";
		}else{
			sql = "update shopproduct_model set category=" + this.category + ",model=" + DbAdapter.cite(this.model) + " where id=" + this.id;
		}
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
	}
	
	public void set(String column,String value){
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(this.id, "update shopproduct_model set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
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
			db.executeUpdate(id, "delete from shopproduct_model where id=" + id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(id);
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	
}
