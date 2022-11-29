package tea.entity.yl.shopnew;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

/**
 *账款暂扣记录
 * @author qdr
 * */
public class DeductionRecord {

	protected static Cache c = new Cache(50);

	private int id;

	private int bid;
	private float deductprice;
	private int iid;
	private Date time;


	public DeductionRecord(int id){
		this.id = id;
	}
	
	public static DeductionRecord find(int id){
		DeductionRecord invoice = (DeductionRecord)c.get(id);
		if(invoice == null){
			ArrayList<DeductionRecord> list = find(" AND id = " + id, 0, 1);
			invoice = list.size() < 1 ? new DeductionRecord(id):list.get(0);
		}
		return invoice;
	}

	public static DeductionRecord findByIid(int id){
		DeductionRecord invoice = (DeductionRecord)c.get(id);
		if(invoice == null){
			ArrayList<DeductionRecord> list = find(" AND iid = " + id, 0, 1);
			invoice = list.size() < 1 ? new DeductionRecord(id):list.get(0);
		}
		return invoice;
	}
	
	
	public static ArrayList<DeductionRecord> find(String sql, int pos, int size){
		ArrayList<DeductionRecord> list = new ArrayList<DeductionRecord>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,bid,deductprice,iid,time" +
				" from DeductionRecord where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				DeductionRecord deductionRecord = new DeductionRecord(rs.getInt(i++));
				deductionRecord.bid = db.getInt(i++	);
				deductionRecord.deductprice = db.getFloat(i++);
				deductionRecord.iid = db.getInt(i++);
				deductionRecord.time = db.getDate(i++);
				c.put(deductionRecord.id, deductionRecord);
				list.add(deductionRecord);
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
		return DbAdapter.execute("select count(0) from deductionRecord where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			this.id = Seq.get();
			sql = "insert into deductionRecord(id,bid,deductprice,iid,time" +
				  ") values(" 
				+ id + ","+bid+","+deductprice+","+iid+","+DbAdapter.cite(time)+")";
		}else{
			sql = "update deductionRecord set bid="+bid+",deductprice="+deductprice+",iid="+iid+",time="+DbAdapter.cite(time)+"  where id=" + this.id;
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
			db.executeUpdate(this.id,"delete from deductionRecord where id= " + this.id);
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
			db.executeUpdate(this.id, "update deductionRecord set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
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


	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public float getDeductprice() {
		return deductprice;
	}

	public void setDeductprice(float deductprice) {
		this.deductprice = deductprice;
	}

	public int getIid() {
		return iid;
	}

	public void setIid(int iid) {
		this.iid = iid;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}
	

}
