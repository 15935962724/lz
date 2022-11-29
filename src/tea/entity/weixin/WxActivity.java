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
 * 微信活动
 */
public class WxActivity extends Entity
{
    private int id; //微活动
    private String community; //社区
    public static String[] TYPEARR = {"微活动类型","刮刮卡","幸运水果机","幸运大转盘","砸金蛋"};
    private int type;//微活动类型
    private String name;//刮刮卡名称
    private String keyword;//活动关键字
    private Date starttime; //活动开始时间
    private Date stoptime; //活动结束时间 
    private int attch;//活动展示图片
    private String info;//活动简介
    private boolean showNum;//是否显示奖品数量
    private int totalOfPerson;//每人参与的总次数
    private int numOfDay;//每人每天可参与次数
    private int maxNumOfDay;//每天最多出奖数量
    private boolean hidden; //显示/隐藏
    private Date time;//创建时间
    

    public WxActivity(int id)
    {
        this.id = id;
    }

    public static WxActivity find(int id) throws SQLException
    {
        WxActivity t = (WxActivity) _cache.get(id);
        if(t == null)
        {
            ArrayList al = find(" AND id=" + id,0,1);
            t = al.size() < 1 ? new WxActivity(id) : (WxActivity) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT id,community,type,name,keyword,starttime,stoptime,attch,info,showNum,totalOfPerson,numOfDay,maxNumOfDay,hidden,time FROM WxActivity WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WxActivity t = new WxActivity(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.keyword = rs.getString(i++);
                t.starttime = db.getDate(i++);
                t.stoptime = db.getDate(i++);
                t.attch = rs.getInt(i++);
                t.info = rs.getString(i++);
                t.showNum = rs.getBoolean(i++);
                t.totalOfPerson = rs.getInt(i++);
                t.numOfDay = rs.getInt(i++);
                t.maxNumOfDay = rs.getInt(i++);
                t.hidden = rs.getBoolean(i++);
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

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM WxActivity WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(id < 1)
        {
            Calendar c = Calendar.getInstance();
            c.add(Calendar.MONTH, -2);
            sql = "INSERT INTO WxActivity(id,community,type,name,keyword,starttime,stoptime,attch,info,showNum,totalOfPerson,numOfDay,maxNumOfDay,hidden,time)VALUES(" + (id = Seq.get(c.getTime())) +","+DbAdapter.cite(community) +","+type
            	+","+DbAdapter.cite(name) + ","+DbAdapter.cite(keyword) + ","+DbAdapter.cite(starttime) + ","+DbAdapter.cite(stoptime) + ","+attch +","+DbAdapter.cite(info) + ","+DbAdapter.cite(showNum) +","+totalOfPerson
            	+","+numOfDay +","+maxNumOfDay +","+DbAdapter.cite(hidden) +","+DbAdapter.cite(time)+ ")";
        } else
            sql = "UPDATE WxActivity SET community="+DbAdapter.cite(community) + ",name="+DbAdapter.cite(name) + ",keyword="+DbAdapter.cite(keyword) + ",starttime="+DbAdapter.cite(starttime) + ",stoptime="+DbAdapter.cite(stoptime)
            	+ ",attch="+attch +",info="+DbAdapter.cite(info) + ",showNum="+DbAdapter.cite(showNum) +",totalOfPerson="+totalOfPerson +",numOfDay="+numOfDay +",maxNumOfDay="+maxNumOfDay +",hidden="+DbAdapter.cite(hidden) +",time="+DbAdapter.cite(time)
            	+ " WHERE id=" + id;
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
            db.executeUpdate(id,"DELETE FROM WxActivity WHERE id=" + id);
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
            db.executeUpdate(id,"UPDATE WxActivity SET " + f + "=" + DbAdapter.cite(v) + " WHERE id=" + id);
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
	public String getCommunity() {
		return community;
	}
	public void setCommunity(String community) {
		this.community = community;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public Date getStarttime() {
		return starttime;
	}
	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}
	public Date getStoptime() {
		return stoptime;
	}
	public void setStoptime(Date stoptime) {
		this.stoptime = stoptime;
	}
	public int getAttch() {
		return attch;
	}
	public void setAttch(int attch) {
		this.attch = attch;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public boolean isShowNum() {
		return showNum;
	}
	public void setShowNum(boolean showNum) {
		this.showNum = showNum;
	}
	public int getTotalOfPerson() {
		return totalOfPerson;
	}
	public void setTotalOfPerson(int totalOfPerson) {
		this.totalOfPerson = totalOfPerson;
	}
	public int getNumOfDay() {
		return numOfDay;
	}
	public void setNumOfDay(int numOfDay) {
		this.numOfDay = numOfDay;
	}
	public int getMaxNumOfDay() {
		return maxNumOfDay;
	}
	public void setMaxNumOfDay(int maxNumOfDay) {
		this.maxNumOfDay = maxNumOfDay;
	}
	public boolean isHidden() {
		return hidden;
	}
	public void setHidden(boolean hidden) {
		this.hidden = hidden;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
}