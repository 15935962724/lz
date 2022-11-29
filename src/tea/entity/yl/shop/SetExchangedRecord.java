package tea.entity.yl.shop;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

/**
 * 退换货后管理员修改粒子数量的记录
 * @author yantong
 * */
public class SetExchangedRecord {

	protected static Cache c = new Cache(50);
	
	private int id;				
	private int exchangeid;	//退货id
	private int num;//数量
	private int member;//修改人
	private Date createdate;  //修改时间  
	
	
	public SetExchangedRecord(int id){
		this.id = id;
	}
	
	public static SetExchangedRecord find(int id){
		SetExchangedRecord aShopPackage = (SetExchangedRecord)c.get(id);
		if(aShopPackage == null){
			ArrayList<SetExchangedRecord> list = find(" AND id = " + id, 0, 1);
			aShopPackage = list.size() < 1 ? new SetExchangedRecord(id):list.get(0);
		}
		return aShopPackage;
	}
	
	
	public static ArrayList<SetExchangedRecord> find(String sql,int pos,int size){
		ArrayList<SetExchangedRecord> list = new ArrayList<SetExchangedRecord>();
		DbAdapter db = new DbAdapter();
		String QSql = "select id,exchangeid,num,member,createdate from setExchangedrecord where 1=1 " + sql;
		try {
			db.executeQuery(QSql, pos, size);
			while(db.next()){
				int i = 1;
				SetExchangedRecord sn = new SetExchangedRecord(db.getInt(i++));
				sn.exchangeid=db.getInt(i++);
				sn.num=db.getInt(i++);
				sn.member=db.getInt(i++);
				sn.createdate=db.getDate(i++);
				c.put(sn.id, sn);
				list.add(sn);
			}
			db.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{

		}
		return list;
	}
	//查询时间最后的最后一条记录
	public static SetExchangedRecord findtop(String sql){
		DbAdapter db = new DbAdapter();
		SetExchangedRecord sn=new SetExchangedRecord(0);
		String QSql = "select top 1 * from setExchangedrecord where 1=1 " + sql;
		try {
			db.executeQuery(QSql);
			if(db.next()){
				sn.id=db.getInt(1);
				sn.exchangeid=db.getInt(2);
				sn.num=db.getInt(3);
				sn.member=db.getInt(4);
				sn.createdate=db.getDate(5);
				
			}
			db.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{

		}
		return sn;
	}
	
	public static int count(String sql) throws SQLException{
		return DbAdapter.execute("select count(0) from setExchangedrecord where 1=1 " + sql);
	}
	
	public void set() throws SQLException{
		String sql = "";
		if(this.id < 1){
			sql = "insert into setExchangedrecord(id,exchangeid,num,member,createdate) values(" 
				+ (this.id = Seq.get()) + "," + this.exchangeid + "," + this.num + "," + this.member + "," + DbAdapter.cite(this.createdate) + ")";
		}else{
			sql = "update setExchangedrecord set exchangeid="+this.exchangeid+",num="+this.num+",member="+this.member+",createdate="+DbAdapter.cite(this.createdate)+ " where id=" + id;
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
			db.executeUpdate(this.id,"delete from setExchangedrecord where id= " + this.id);
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
			db.executeUpdate(this.id, "update setExchangedrecord set " + column + "=" + DbAdapter.cite(value) + " where id=" + this.id);
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

	public int getExchangeid() {
		return exchangeid;
	}

	public void setExchangeid(int exchangeid) {
		this.exchangeid = exchangeid;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	
	
	
}
