package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

/**
 * 产品套餐
 * @author guodh
 * */
public class ShopPackage {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int product_id;				//产品ID
	private String product_link_id;		//组合产品ID
	private String packageName;			//套餐名称
	private double setPrice;			//套餐价格
	private double price;				//原价
	private boolean isExist=false;
	
	public ShopPackage(int id){
		this.id = id;
	}
	
	public static ShopPackage find(int id){
		ShopPackage aShopPackage = (ShopPackage)c.get(id);
		if(aShopPackage == null){
			ArrayList<ShopPackage> list = find(" AND id = " + id, 0, 1);
			aShopPackage = list.size() < 1 ? new ShopPackage(id):list.get(0);
		}
		return aShopPackage;
	}
	
	public static ArrayList<ShopPackage> find(String sql,int pos,int size){
		ArrayList<ShopPackage> list = new ArrayList<ShopPackage>();
		DbAdapter db = new DbAdapter();
		String QSql = "select sp.id,sp.product_id,sp.product_link_id,sp.packagename,sp.setPrice,sp.price from shoppackage sp "+tab(sql)+" where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				ShopPackage sp = new ShopPackage(rs.getInt(i++));
				sp.setProduct_id(rs.getInt(i++));
				sp.setProduct_link_id(rs.getString(i++));
				sp.setPackageName(rs.getString(i++));
				sp.setSetPrice(rs.getDouble(i++));
				sp.setPrice(rs.getDouble(i++));
				sp.setExist(true);
				c.put(sp.id, sp);
				list.add(sp);
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
		return DbAdapter.execute("select count(0) from shoppackage sp "+tab(sql)+" where 1=1 " + sql);
	}
	
	private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND spd."))
            sb.append(" inner join ShopProduct spd on sp.product_id = spd.product ");
        return sb.toString();
    }
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into shoppackage(id,product_id,product_link_id,packagename,setPrice,price) values(" 
				+ (this.id = Seq.get()) + "," + this.product_id + "," + DbAdapter.cite(this.product_link_id) + "," + DbAdapter.cite(this.packageName) + "," + this.setPrice + "," + this.price + ")";
		}else{
			sql = "update shoppackage set product_id=" + this.product_id + ",product_link_id=" + DbAdapter.cite(this.product_link_id) + ",packagename=" + DbAdapter.cite(this.packageName) + ",setPrice=" + this.setPrice + ",price=" + this.price + " where id=" + this.id;
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
			db.executeUpdate(this.id,"delete from shoppackage where id= " + this.id);
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
			db.executeUpdate(this.id, "update shoppackage set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
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

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int productId) {
		product_id = productId;
	}

	public String getProduct_link_id() {
		return product_link_id;
	}

	public void setProduct_link_id(String productLinkId) {
		product_link_id = productLinkId;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public double getSetPrice() {
		return setPrice;
	}

	public void setSetPrice(double setPrice) {
		this.setPrice = setPrice;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public boolean isExist() {
		return isExist;
	}

	public void setExist(boolean isExist) {
		this.isExist = isExist;
	}
	
}
