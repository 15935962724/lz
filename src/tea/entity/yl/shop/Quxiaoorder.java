package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

/**
 * 取消订单
 * @author yantong
 * */
public class Quxiaoorder {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private String orderid;			//订单编号
	private int status;				//用户ID
	public static String[] STATUS={"待审核","审核通过","审核不通过"};
	private Date createdate;        //创建时间
	private int member;             //创建人
	private String reason;          //拒绝原因
	
	public Quxiaoorder(int id){
		this.id = id;
	}
	
	public static Quxiaoorder find(int id){
		Quxiaoorder aShopPackage = (Quxiaoorder)c.get(id);
		if(aShopPackage == null){
			ArrayList<Quxiaoorder> list = find(" AND id = " + id, 0, 1);
			aShopPackage = list.size() < 1 ? new Quxiaoorder(id):list.get(0);
		}
		return aShopPackage;
	}
	
	public static Quxiaoorder findByOrderId(String orderId){
		ArrayList<Quxiaoorder> list = find(" AND orderid = " + DbAdapter.cite(orderId), 0, 1);
		Quxiaoorder aShopPackage = list.size() < 1 ? new Quxiaoorder(0):list.get(0);
		return aShopPackage;
	}
	
	public static ArrayList<Quxiaoorder> find(String sql,int pos,int size){
		ArrayList<Quxiaoorder> list = new ArrayList<Quxiaoorder>();
		DbAdapter db = new DbAdapter();
		String QSql = "select so.id,so.orderid,so.status,so.createdate,so.member,so.reason" +
				" from quxiaoorder so "+tab(sql)+" where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				Quxiaoorder so = new Quxiaoorder(rs.getInt(i++));
				so.setOrderid(rs.getString(i++));
				so.setStatus(rs.getInt(i++));
				so.setCreatedate(db.getDate(i++));
				so.setMember(rs.getInt(i++));
				so.setReason(rs.getString(i++));
				c.put(so.id, so);
				list.add(so);
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
//		String Qsql = "select count(0) from shoporder so "+tab(sql)+" where 1=1 " + sql;
//		System.out.println(Qsql);
		return DbAdapter.execute("select count(0) from quxiaoorder so "+tab(sql)+" where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into quxiaoorder(id,orderid,status,createdate,member,reason) values(" 
				+ (this.id = Seq.get()) + "," + DbAdapter.cite(this.orderid) + "," + this.status + "," + DbAdapter.cite(this.createdate) + "," + this.member+","+DbAdapter.cite(this.reason)
				+")";
		}else{
			sql = "update quxiaoorder set orderid="+ DbAdapter.cite(this.orderid) +",status="+this.status+",createdate="+DbAdapter.cite(this.createdate)+",member="+this.member +",reason="+DbAdapter.cite(reason)+" where id=" + this.id;
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
			db.executeUpdate(this.id,"delete from quxiaoorder where id= " + this.id);
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
			db.executeUpdate(this.id, "update quxiaoorder set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
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
        if (sql.contains(" AND ml."))
            sb.append(" INNER JOIN ProfileLayer ml ON ml.member=so.member");
        if (sql.contains(" AND m."))
            sb.append(" INNER JOIN Profile m ON m.profile=so.member");
        if (sql.contains(" AND sod."))
            sb.append(" INNER JOIN ShopOrderDispatch sod ON sod.order_id=so.orderid");
        if(sql.contains(" AND se."))
        	sb.append(" INNER JOIN shopexchanged se ON se.order_id=so.order_id AND so.invoiceStatus=3 ");
        return sb.toString();
    }
	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
	
	
	

	
	
	
	
	

}
