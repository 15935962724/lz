package tea.entity.yl.shopnew;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

/**
 * 催缴记录
 * @author yt
 * */
public class UrgedRecord {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int member;				        //催缴人
	private int fmember;			        //服务商
	private Date createdate;		        //催缴时间
	private String orderid;		            //订单id
	private String hospitalid;		        //医院id
	private int type;                       //催缴类型 0：催缴开票  1：催缴回款
	
	public UrgedRecord(int id){
		this.id = id;
	}
	
	public static UrgedRecord find(int id){
		UrgedRecord invoice = (UrgedRecord)c.get(id);
		if(invoice == null){
			ArrayList<UrgedRecord> list = find(" AND id = " + id, 0, 1);
			invoice = list.size() < 1 ? new UrgedRecord(id):list.get(0);
		}
		return invoice;
	}
	
	
	public static ArrayList<UrgedRecord> find(String sql,int pos,int size){
		ArrayList<UrgedRecord> list = new ArrayList<UrgedRecord>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,member,fmember,createdate,orderid,hospitalid,type" +
				" from urgedrecord where 1=1 " + sql;
		try {
			ResultSet rs = db.executeQuery(QSql, pos, size);
			while(rs.next()){
				int i = 1;
				UrgedRecord urge = new UrgedRecord(rs.getInt(i++));
				urge.setMember(rs.getInt(i++));
				urge.setFmember(rs.getInt(i++));
				urge.setCreatedate(db.getDate(i++));
				urge.setOrderid(rs.getString(i++));
				urge.setHospitalid(rs.getString(i++));
				urge.setType(rs.getInt(i++));
				c.put(urge.id, urge);
				list.add(urge);
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
		return DbAdapter.execute("select count(0) from urgedrecord where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into urgedrecord(id,member,fmember,createdate,orderid,hospitalid,type" +
				  ") values(" 
				+ (this.id = Seq.get()) + "," + this.member + "," + this.fmember + "," + DbAdapter.cite(this.createdate) + "," 
					+ DbAdapter.cite(this.orderid) + "," +DbAdapter.cite(this.hospitalid)+","+this.type+")";
		}else{
			sql = "update urgedrecord set member=" + this.member +",fmember="+this.fmember+",createdate="+DbAdapter.cite(this.createdate) 
					+",orderid="+DbAdapter.cite(this.orderid) +",hospitalid="+DbAdapter.cite(this.hospitalid)+",type="+this.type+"  where id=" + this.id;
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
			db.executeUpdate(this.id,"delete from urgedrecord where id= " + this.id);
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
			db.executeUpdate(this.id, "update urgedrecord set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
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

	public int getFmember() {
		return fmember;
	}

	public void setFmember(int fmember) {
		this.fmember = fmember;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public String getHospitalid() {
		return hospitalid;
	}

	public void setHospitalid(String hospitalid) {
		this.hospitalid = hospitalid;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	
	
	

	

	
	
	
	

}
