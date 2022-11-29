package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

/**
 * 产品咨询
 * @author guodh
 * */
public class ShopAdvisory {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int product_id;			//产品ID
	private int member;				//用户ID
	private String depict;			//咨询详情
	private Date createdate;		//咨询提交时间
	private String replycont;		//回复
	private int replyMember;		//回复人
	private Date replyTime;			//回复时间
	private int isDelete;			//是否删除 0正常，1删除
	
	public ShopAdvisory(int id){
		this.id = id;
	}
	
	public static ShopAdvisory find(int id){
		ShopAdvisory aShopPackage = (ShopAdvisory)c.get(id);
		if(aShopPackage == null){
			ArrayList<ShopAdvisory> list = find(" AND id = " + id, 0, 1);
			aShopPackage = list.size() < 1 ? new ShopAdvisory(id):list.get(0);
		}
		return aShopPackage;
	}
	
	public static ArrayList<ShopAdvisory> find(String sql,int pos,int size){
		ArrayList<ShopAdvisory> list = new ArrayList<ShopAdvisory>();
		DbAdapter db = new DbAdapter();
		String QSql = "select sa.id,sa.product_id,sa.member,sa.depict,sa.createdate,sa.replycont,sa.replymember,sa.replytime,sa.isdelete from shopadvisory sa "+tab(sql)+" where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				ShopAdvisory sa = new ShopAdvisory(rs.getInt(i++));
				sa.setProduct_id(rs.getInt(i++));
				sa.setMember(rs.getInt(i++));
				sa.setDepict(rs.getString(i++));
				sa.setCreatedate(db.getDate(i++));
				sa.setReplycont(rs.getString(i++));
				sa.setReplyMember(rs.getInt(i++));
				sa.setReplyTime(db.getDate(i++));
				sa.setIsDelete(rs.getInt(i++));
				
				c.put(sa.id, sa);
				list.add(sa);
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
		return DbAdapter.execute("select count(0) from shopadvisory sa "+tab(sql)+" where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into shopadvisory(id,product_id,member,depict,createdate,replycont,replymember,replytime,isdelete) values(" 
				+ (this.id = Seq.get()) + "," + this.product_id + "," + this.member + "," + DbAdapter.cite(this.depict) + "," + DbAdapter.cite(this.createdate) + "," + DbAdapter.cite(this.replycont) + "," + this.replyMember + "," + DbAdapter.cite(this.replyTime) + "," + this.isDelete + ")";
		}else{
			sql = "update shopadvisory set product_id=" + this.product_id + ",member=" + this.member + ",depict=" + DbAdapter.cite(this.depict) + ",createdate=" + DbAdapter.cite(this.createdate) + ",replycont=" + DbAdapter.cite(this.replycont) + ",replymember=" + this.replyMember + ",replytime=" + DbAdapter.cite(this.replyTime) + ",isdelete=" + this.isDelete + " where id=" + this.id;
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
			db.executeUpdate(this.id,"delete from shopadvisory where id= " + this.id);
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
			db.executeUpdate(this.id, "update shopadvisory set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		c.remove(this.id);
	}
	
	private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND m."))
            sb.append(" INNER JOIN Profile m ON m.profile=sa.member");
        return sb.toString();
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

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	public String getDepict() {
		return depict;
	}

	public void setDepict(String depict) {
		this.depict = depict;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public String getReplycont() {
		return replycont;
	}

	public void setReplycont(String replycont) {
		this.replycont = replycont;
	}

	public int getReplyMember() {
		return replyMember;
	}

	public void setReplyMember(int replyMember) {
		this.replyMember = replyMember;
	}

	public Date getReplyTime() {
		return replyTime;
	}

	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}

	public int getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}

}
