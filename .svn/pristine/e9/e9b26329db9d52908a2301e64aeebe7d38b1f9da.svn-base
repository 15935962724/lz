package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

/**
 * 退换货
 * @author guodh
 * */
public class ShopExchangedDetail {

	protected static Cache c = new Cache(50);
	
	public int id;				
	public int exchanged_id;//退货单id
	public int product_id;//产品id
	public int type;				//类型：1退货，2换货
	public int quantity;			//数量
	public String description;		//问题描述
	public String picture;			//图片
	
	
	public ShopExchangedDetail(int id){
		this.id = id;
	}
	
	public static ShopExchangedDetail find(int id){
		ShopExchangedDetail sed = (ShopExchangedDetail)c.get(id);
		if(sed == null){
			ArrayList<ShopExchangedDetail> list = find(" AND id = " + id, 0, 1);
			sed = list.size() < 1 ? new ShopExchangedDetail(id):list.get(0);
		}
		return sed;
	}
	
	public static ArrayList<ShopExchangedDetail> find(String sql,int pos,int size){
		ArrayList<ShopExchangedDetail> list = new ArrayList<ShopExchangedDetail>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,exchanged_id,product_id,type,quantity,description,picture from ShopExchangedDetail where 1=1 " + sql;
		try {
			db.executeQuery(QSql, pos, size);
			while(db.next()){
				int i = 1;
				ShopExchangedDetail sn = new ShopExchangedDetail(db.getInt(i++));
				sn.exchanged_id=db.getInt(i++);
				sn.product_id=db.getInt(i++);
				sn.type=db.getInt(i++);
				sn.quantity=db.getInt(i++);
				sn.description=db.getString(i++);
				sn.picture=db.getString(i++);
				
				c.put(sn.id, sn);
				list.add(sn);
			}
			db.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return list;
	}
	
	public static int count(String sql) throws SQLException{
		return DbAdapter.execute("select count(0) from ShopExchangedDetail where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into ShopExchangedDetail(id,exchanged_id,product_id,type,quantity,description,picture) values(" 
				+ (this.id = Seq.get()) + "," + exchanged_id+ "," + product_id + "," + type + "," + quantity + "," + DbAdapter.cite(description) + "," + DbAdapter.cite(picture) + ")";
		}else{
			sql = "update ShopExchangedDetail set exchanged_id="+exchanged_id+",product_id="+product_id+",type="+type+",quantity="+quantity+",description="+DbAdapter.cite(description)+",picture=" + DbAdapter.cite(picture) + " where id=" + id;
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
			db.executeUpdate(this.id,"delete from ShopExchangedDetail where id= " + this.id);
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
			db.executeUpdate(this.id, "update ShopExchangedDetail set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	
}
