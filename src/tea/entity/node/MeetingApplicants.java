package tea.entity.node;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;
import tea.entity.Seq;

@SuppressWarnings({ "rawtypes", "unchecked" })
public class MeetingApplicants extends Entity
{
    private static Cache _cache = new Cache(100);
    private int id;
    private int node;
    private int adminunitid;
    private int profile;
    private String name;  //姓名
    private int sex;
    private String tel;
    private int catering;  //是否安排餐饮 0是，1 否
    private int stay;  //是否安排住宿
    private String hotelname;  //酒店名称
    private String hoteladdress;  //酒店地址
    private int shuttle;  //是否安排接送
    private Date time; //邀请时间
    private boolean exist;

    public MeetingApplicants(int id) throws SQLException
    {
        this.id = id;
    }
    
    public MeetingApplicants(int node,int profile) throws SQLException
    {
        this.node = node;
        this.profile = profile;
    }
    
    public static MeetingApplicants find(int id) throws SQLException
    {
        MeetingApplicants obj = (MeetingApplicants) _cache.get(id);
        if(obj == null)
        {
			ArrayList al = find(" AND id="+id,0,1);
            obj =al.size() < 1 ?  new MeetingApplicants(id) : (MeetingApplicants) al.get(0);
        }
        return obj;
    }
    
    public static MeetingApplicants find(int node,int profile) throws SQLException
    {
        ArrayList al = find(" AND node="+node+" AND profile="+profile,0,1);
        MeetingApplicants obj =al.size() < 1 ?  new MeetingApplicants(node,profile) : (MeetingApplicants) al.get(0);
        return obj;
    }
    
    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM MeetingApplicants ma "+tab(sql)+" WHERE 1=1" + sql);
    }

	public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT ma.id,ma.node,ma.adminunitid,ma.profile,ma.name,ma.sex,ma.tel,ma.catering,ma.stay,ma.hotelname,ma.hoteladdress,ma.shuttle,ma.time FROM MeetingApplicants ma "+tab(sql)+" WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                MeetingApplicants t = new MeetingApplicants(rs.getInt(i++));
                t.node = rs.getInt(i++);
                t.adminunitid = rs.getInt(i++);
                t.profile = rs.getInt(i++);
                t.name = db.getString(i++);
                t.sex = rs.getInt(i++);
                t.tel = rs.getString(i++);
                t.catering = rs.getInt(i++);
                t.stay = rs.getInt(i++);
                t.hotelname = rs.getString(i++);
                t.hoteladdress = rs.getString(i++);
                t.shuttle = rs.getInt(i++);
                t.time = db.getDate(i++);                
                t.exist = true;
                _cache.put(t.id,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }
    
    public void set() throws SQLException
    {
        String sql;
        if(id < 1)
            sql = "INSERT INTO MeetingApplicants(id,node,adminunitid,profile,name,sex,tel,catering,stay,hotelname,hoteladdress,shuttle,time)VALUES(" + (id = Seq.get()) + "," + node + "," + adminunitid +","+profile + "," + DbAdapter.cite(name) + "," + sex + "," + DbAdapter.cite(tel) + "," + catering + "," + stay + "," + DbAdapter.cite(hotelname) + "," + DbAdapter.cite(hoteladdress)+ "," + shuttle + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE MeetingApplicants SET node=" + node + ",adminunitid=" + adminunitid +",profile="+profile + ",name=" + DbAdapter.cite(name) + ",sex=" + sex + ",tel=" + DbAdapter.cite(tel) + ",catering=" + catering + ",stay=" + stay + ",hotelname=" + DbAdapter.cite(hotelname) + ",hoteladdress=" + DbAdapter.cite(hoteladdress) + ",shuttle=" + shuttle + ",time=" + DbAdapter.cite(time) + " WHERE id=" + id;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(id);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM MeetingApplicants WHERE id=" + id);
        }

        finally
        {
            db.close();
        }
        _cache.remove(id);
    }
    
    private static String tab(String sql){
    	StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND m."))
            sb.append(" INNER JOIN Meeting m on m.node=ma.node");
        return sb.toString();
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getNode() {
		return node;
	}

	public void setNode(int node) {
		this.node = node;
	}

	public int getAdminunitid() {
		return adminunitid;
	}

	public void setAdminunitid(int adminunitid) {
		this.adminunitid = adminunitid;
	}

	public int getProfile() {
		return profile;
	}

	public void setProfile(int profile) {
		this.profile = profile;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public int getCatering() {
		return catering;
	}

	public void setCatering(int catering) {
		this.catering = catering;
	}

	public int getStay() {
		return stay;
	}

	public void setStay(int stay) {
		this.stay = stay;
	}

	public String getHotelname() {
		return hotelname;
	}

	public void setHotelname(String hotelname) {
		this.hotelname = hotelname;
	}

	public String getHoteladdress() {
		return hoteladdress;
	}

	public void setHoteladdress(String hoteladdress) {
		this.hoteladdress = hoteladdress;
	}

	public int getShuttle() {
		return shuttle;
	}

	public void setShuttle(int shuttle) {
		this.shuttle = shuttle;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public boolean isExist() {
		return exist;
	}

	public void setExist(boolean exist) {
		this.exist = exist;
	}

}
