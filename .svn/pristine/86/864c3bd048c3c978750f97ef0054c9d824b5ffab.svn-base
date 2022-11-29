package tea.entity.pm;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.Seq;

/**
 * 拍马网-个人中心-套单解套
 * @author guodh
 * @version v1 2014-09-25
 * */
public class PoSingleRelease extends Entity{
	
	private int id;
	private String name;			//姓名
	private String contactway;		//联系方式
	private int uploadFile;			//资料  对应attch
	private Date applyTime;			//申请时间
	private int member;				//用户
	
	private int type;				//类型 0套单解套,1交易计划,2数据分析
	
	public PoSingleRelease(int id){
		this.id = id;
	}
	
	public static PoSingleRelease find(int id) throws SQLException{
        PoSingleRelease t = (PoSingleRelease) _cache.get(id);
        if(t == null){
            ArrayList<PoSingleRelease> al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new PoSingleRelease(id) : (PoSingleRelease) al.get(0);
        }
        return t;
    }

	public static ArrayList<PoSingleRelease> find(String sql,int pos,int size){
		ArrayList<PoSingleRelease> sr = new ArrayList<PoSingleRelease>();
        DbAdapter db = new DbAdapter();
    	String q_sql = "select id,name,contactway,uploadfile,applytime,member,type from SingleRelease where 1=1 " + sql;
    	try {
    		java.sql.ResultSet rs = db.executeQuery(q_sql, pos, size);
    		while(rs.next()){
    			int i = 1;
    			PoSingleRelease _sr = new PoSingleRelease(rs.getInt(i++));
    			_sr.setName(rs.getString(i++));
    			_sr.setContactway(rs.getString(i++));
    			_sr.setUploadFile(rs.getInt(i++));
    			_sr.setApplyTime(db.getDate(i++));
    			_sr.setMember(rs.getInt(i++));
    			_sr.setType(rs.getInt(i++));
    			sr.add(_sr);
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
		int num = DbAdapter.execute("SELECT COUNT(0) FROM SingleRelease WHERE 1=1 ");
		return num;
	}
	
	public void set() throws SQLException{
        String sql;
        if(id < 1)
            sql = "INSERT INTO SingleRelease(id,name,contactWay,uploadFile,applyTime,member,type) VALUES("+ (id = Seq.get()) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(contactway) + "," + uploadFile + "," + DbAdapter.cite(applyTime) + "," + member + "," + type + ")";
        else
            sql = "UPDATE SingleRelease SET name=" + DbAdapter.cite(name) + ",contactWay=" + DbAdapter.cite(contactway) + ",uploadFile="+uploadFile + ",applyTime=" + DbAdapter.cite(applyTime) + ",type=" + type + " WHERE id=" + id;
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
            db.executeUpdate(id,"DELETE FROM SingleRelease WHERE id=" + id);
        } finally{
            db.close();
        }
        _cache.remove(id);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try{
            db.executeUpdate(id,"UPDATE SingleRelease SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
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

	public int getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(int uploadFile) {
		this.uploadFile = uploadFile;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
	
}
