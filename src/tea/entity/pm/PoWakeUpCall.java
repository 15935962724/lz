package tea.entity.pm;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.Seq;

/**
 * 拍马网-个人中心-叫醒服务
 * @author guodh
 * @version v1 2014-09-25
 * */
public class PoWakeUpCall extends Entity{
	
	private int id;
	private String product;			//交易产品
	private double wakeupprice;		//叫醒价位
	private Date wakeuptime;		//叫醒时间
	private String remark;			//备注
	private String name;			//姓名
	private String contactway;		//联系方式
	private Date applyTime;			//申请时间
	private int member;				//用户
	
	public PoWakeUpCall(int id){
		this.id = id;
	}
	
	public static PoWakeUpCall find(int id) throws SQLException{
        PoWakeUpCall t = (PoWakeUpCall) _cache.get(id);
        if(t == null){
            ArrayList<PoWakeUpCall> al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new PoWakeUpCall(id) : (PoWakeUpCall) al.get(0);
        }
        return t;
    }

	public static ArrayList<PoWakeUpCall> find(String sql,int pos,int size){
		ArrayList<PoWakeUpCall> sr = new ArrayList<PoWakeUpCall>();
        DbAdapter db = new DbAdapter();
    	String q_sql = "select id,product,wakeupprice,wakeuptime,remark,name,contactway,applytime,member from wakeupcall where 1=1 " + sql;
    	try {
    		java.sql.ResultSet rs = db.executeQuery(q_sql, pos, size);
    		while(rs.next()){
    			int i = 1;
    			PoWakeUpCall _wuc = new PoWakeUpCall(rs.getInt(i++));
    			_wuc.setProduct(rs.getString(i++));
    			_wuc.setWakeupprice(rs.getDouble(i++));
    			_wuc.setWakeuptime(db.getDate(i++));
    			_wuc.setRemark(rs.getString(i++));
    			_wuc.setName(rs.getString(i++));
    			_wuc.setContactway(rs.getString(i++));
    			_wuc.setApplyTime(db.getDate(i++));
    			_wuc.setMember(rs.getInt(i++));
    			sr.add(_wuc);
    		}
    		rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			db.close();
		}
		return sr;
    }
	
	public static int count(String sql) throws SQLException{
		int num = DbAdapter.execute("SELECT COUNT(0) FROM wakeupcall WHERE 1=1 ");
		return num;
	}
	
	public void set() throws SQLException{
        String sql;
        if(id < 1){
            sql = "INSERT INTO wakeupcall(id,product,wakeupprice,wakeuptime,remark,name,contactway,applytime,member) VALUES("+ (id = Seq.get()) + "," + DbAdapter.cite(product) + "," + wakeupprice +","+DbAdapter.cite(wakeuptime) + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(contactway) + "," + DbAdapter.cite(applyTime) + "," + member + ")";
        }else{
            sql = "UPDATE wakeupcall SET " +
            "product = " + DbAdapter.cite(product) +
            ",wakeupprice = " + wakeupprice +
            ",wakeuptime = " + DbAdapter.cite(wakeuptime) +
            ",remark = " + DbAdapter.cite(remark) +
            ",name = " + DbAdapter.cite(name) +
            ",contactway = " + DbAdapter.cite(contactway) + 
            ",applyTime = " + DbAdapter.cite(applyTime) +
            ",member = " + member +
            " Where id= " +id;
        }
        DbAdapter db = new DbAdapter();
        try{
            db.executeUpdate(id,sql);
        } finally{
            db.close();
        }
        _cache.remove(id);
    }

    public void delete() throws SQLException{
        DbAdapter db = new DbAdapter();
        try{
            db.executeUpdate(id,"DELETE FROM wakeupcall WHERE id=" + id);
        } finally{
            db.close();
        }
        _cache.remove(id);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try{
            db.executeUpdate(id,"UPDATE wakeupcall SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally{
            db.close();
        }
        _cache.remove(id);
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public double getWakeupprice() {
		return wakeupprice;
	}

	public void setWakeupprice(double wakeupprice) {
		this.wakeupprice = wakeupprice;
	}

	public Date getWakeuptime() {
		return wakeuptime;
	}

	public void setWakeuptime(Date wakeuptime) {
		this.wakeuptime = wakeuptime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContactway() {
		return contactway;
	}

	public void setContactway(String contactway) {
		this.contactway = contactway;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

}
