package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

/*
 Jid:1322
 Jid:1323
Jid:1324
 对应的Specimen不存在
 */
public class SIdentify
{
    protected static Cache c = new Cache(50);
    public int identify; //鉴定信息表
    public int jid;
    public int node; //标本ID 300000+SID
    public int sid;
    public String iperson; //鉴定人
    public Date iyear; //鉴定时间

    public SIdentify(int identify)
    {
        this.identify = identify;
    }

    public static SIdentify find(int identify) throws SQLException
    {
        SIdentify t = (SIdentify) c.get(identify);
        if(t == null)
        {
            ArrayList al = find(" AND identify=" + identify,0,1);
            t = al.size() < 1 ? new SIdentify(identify) : (SIdentify) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT identify,jid,node,sid,iperson,iyear FROM sidentify WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                SIdentify t = new SIdentify(rs.getInt(i++));
                t.jid = rs.getInt(i++);
                t.node = rs.getInt(i++);
                t.sid = rs.getInt(i++);
                t.iperson = rs.getString(i++);
                t.iyear = db.getDate(i++);
                c.put(t.identify,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM sidentify WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(identify < 1)
                db.executeUpdate("INSERT INTO sidentify(node,sid,iperson,iyear)VALUES(" + node + "," + sid + "," + DbAdapter.cite(iperson) + "," + DbAdapter.cite(iyear) + ")");
            else
                db.executeUpdate("UPDATE sidentify SET iperson=" + DbAdapter.cite(iperson) + ",iyear=" + DbAdapter.cite(iyear) + " WHERE identify=" + identify);
        } finally
        {
            db.close();
        }
        c.remove(identify);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM sidentify WHERE identify=" + identify);
        c.remove(identify);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE sidentify SET " + f + "=" + DbAdapter.cite(v) + " WHERE identify=" + identify);
        c.remove(identify);
    }

    public void imp() throws SQLException
    {
        Iterator it = Specimen.find(" AND sid=" + sid,0,1).iterator();
        if(it.hasNext())
        {
            Specimen s = (Specimen) it.next();
            set("node",String.valueOf(node = s.node));
        }
        System.out.println("Jid:" + jid + " Specimen:" + node);
    }

}
