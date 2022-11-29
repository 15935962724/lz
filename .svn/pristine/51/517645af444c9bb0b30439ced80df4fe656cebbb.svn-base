package tea.entity.weixin;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.Seq;

/** 
 * @author zcq
 * @version 创建时间：2015-5-26 下午03:50:52 
 * 用户微信活动表
 */
public class WxActivityMem extends Entity
{
    private int id; //用户微活动联合id
    private int activityId;//微活动id
    private int member;//用户id
    private String tel;//用户手机号
    private int activityPrizeId;//中奖id 0为未中奖
    public static String[] STATUSARR = {"未中奖","未奖领","已领取"};
    private int status;//领奖状态-0：未中奖；1：未奖领；2：已领取
    private Date time;//创建时间
    

    public WxActivityMem(int id)
    {
        this.id = id;
    }

    public static WxActivityMem find(int id) throws SQLException
    {
        WxActivityMem t = (WxActivityMem) _cache.get(id);
        if(t == null)
        {
            ArrayList al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new WxActivityMem(id) : (WxActivityMem) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT wam.id,wam.activityId,wam.member,wam.tel,wam.activityPrizeId,wam.status,wam.time FROM WxActivityMem wam "+tab(sql)+" WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WxActivityMem t = new WxActivityMem(rs.getInt(i++));
                t.activityId = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.tel = rs.getString(i++);
                t.activityPrizeId = rs.getInt(i++);
                t.status = rs.getInt(i++);
                t.time = db.getDate(i++);
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
    
    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND pf."))
			sb.append(" inner join profile pf on pf.profile = wam.member ");
        return sb.toString();
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM WxActivityMem wam "+tab(sql)+" WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(id < 1)
        {
            Calendar c = Calendar.getInstance();
            c.add(Calendar.MONTH, -2);
            sql = "INSERT INTO WxActivityMem(id,activityId,member,tel,activityPrizeId,status,time)VALUES(" + (id = Seq.get(c.getTime())) +","+activityId
            	+ ","+member +","+DbAdapter.cite(tel) +","+activityPrizeId +","+status +","+DbAdapter.cite(time)+ ")";
        } else
            sql = "UPDATE WxActivityMem SET activityId="+activityId + ",member="+member + ",tel="+DbAdapter.cite(tel)+",activityPrizeId="+activityPrizeId +",status="+status
                +",time="+DbAdapter.cite(time) + " WHERE id=" + id;
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
    
    public static void deleteByActivityId(int activityId) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM WxActivityMem WHERE activityId=" + activityId);
        } finally
        {
            db.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,"DELETE FROM WxActivityMem WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(id);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(id,"UPDATE WxActivityMem SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
        } finally
        {
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
	public int getActivityId() {
		return activityId;
	}
	public void setActivityId(int activityId) {
		this.activityId = activityId;
	}
	public int getMember() {
		return member;
	}
	public void setMember(int member) {
		this.member = member;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public int getActivityPrizeId() {
		return activityPrizeId;
	}	
	public void setActivityPrizeId(int activityPrizeId) {
		this.activityPrizeId = activityPrizeId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
}