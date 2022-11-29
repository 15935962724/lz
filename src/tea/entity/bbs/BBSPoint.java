package tea.entity.bbs;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.member.Profile;

public class BBSPoint
{
    protected static Cache c = new Cache(50);
    public int bbspoint; //论坛积分
    public String member; //用户
    public static String[] TYPE_NAME =
            {"--","发帖","回复","删贴","移贴","精华","热帖","上传附件","下载附件","发起活动","参加活动","线索真实","形成商机","线索更改减分","商机更改减分","自定义","手动管理积分","置顶"};
    //{"--","1  ","2   ","3  ","4   ","5  ","6   ","7     ","8      ","9      ","10     ",     "11",     "12",      "13"  ,        "14", "15"   ,16          ,17   };
    public int type; //类型
    public int node; //节点
    public int point; //积分
    public String content;
    public Date time; //积分日期

    public BBSPoint(int bbspoint)
    {
        this.bbspoint = bbspoint;
    }

    public static BBSPoint find(int bbspoint) throws SQLException
    {
        BBSPoint t = (BBSPoint) c.get(bbspoint);
        if(t == null)
        {
            ArrayList al = find(" AND bbspoint=" + bbspoint,0,1);
            t = al.size() < 1 ? new BBSPoint(bbspoint) : (BBSPoint) al.get(0);
        }
        return t;
    }

    public static BBSPoint find(int node,int type) throws SQLException
    {
        ArrayList al = find(" AND node=" + node + " AND type=" + type,0,1);
        return al.size() < 1 ? new BBSPoint(0) : (BBSPoint) al.get(0);
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT bbspoint,member,type,node,point,content,time FROM BBSPoint WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                BBSPoint t = new BBSPoint(rs.getInt(i++));
                t.member = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.node = rs.getInt(i++);
                t.point = rs.getInt(i++);
                t.content = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.bbspoint,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM BBSPoint WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        if(point == 0)
            return;
        if(time == null)
            time = new Date();
        if(content == null)
            content = Node.find(node).getSubject(1);
		c.remove(bbspoint);
        DbAdapter db = new DbAdapter();
        try
        {
            if(bbspoint < 1)
                db.executeUpdate("INSERT INTO BBSPoint(bbspoint,member,type,node,point,content,time)VALUES(" + (bbspoint = Seq.get()) + "," + DbAdapter.cite(member) + "," + type + "," + node + "," + point + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(time) + ")");
            else
                db.executeUpdate("UPDATE BBSPoint SET member=" + DbAdapter.cite(member) + ",type=" + type + ",node=" + node + ",point=" + point + ",content=" + DbAdapter.cite(content) + ",time=" + DbAdapter.cite(time) + " WHERE bbspoint=" + bbspoint);
        } finally
        {
            db.close();
        }
        Profile p = Profile.find(member);
        p.setIntegral(p.getIntegral() + point);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM BBSPoint WHERE bbspoint=" + bbspoint);
        c.remove(bbspoint);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE BBSPoint SET " + f + "=" + DbAdapter.cite(v) + " WHERE bbspoint=" + bbspoint);
        c.remove(bbspoint);
    }


}
