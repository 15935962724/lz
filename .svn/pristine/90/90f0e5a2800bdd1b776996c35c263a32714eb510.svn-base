package tea.entity.weixin;

import tea.ui.weixin.*;
import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.util.*;

public class WxRedGrab
{
    protected static Cache c = new Cache(50);
    public int wxredgrab;
    public int wxuser; //用户
    public int wxred; //红包
    public String code; //交易单号
    public float money; //金额
    public int status; //状态,1
    public String json;
    public String ip;
    public int ran;
    public Date time; //时间

    public WxRedGrab(int wxredgrab)
    {
        this.wxredgrab = wxredgrab;
    }

    public static WxRedGrab find(int wxredgrab) throws SQLException
    {
        WxRedGrab t = (WxRedGrab) c.get(wxredgrab);
        if(t == null)
        {
            ArrayList al = find(" AND wxredgrab=" + wxredgrab,0,1);
            t = al.size() < 1 ? new WxRedGrab(wxredgrab) : (WxRedGrab) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT wrg.wxredgrab,wrg.wxuser,wrg.wxred,wrg.code,wrg.money,wrg.status,wrg.json,wrg.ip,wrg.ran,wrg.time FROM wxredgrab wrg" + tab(sql) + " WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WxRedGrab t = new WxRedGrab(rs.getInt(i++));
                t.wxuser = rs.getInt(i++);
                t.wxred = rs.getInt(i++);
                t.code = rs.getString(i++);
                t.money = rs.getFloat(i++);
                t.status = rs.getInt(i++);
                t.json = rs.getString(i++);
                t.ip = rs.getString(i++);
                t.ran = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.wxredgrab,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM wxredgrab wrg" + tab(sql) + " WHERE 1=1" + sql);
    }

    public static float sum(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT SUM(money) FROM wxredgrab wrg" + tab(sql) + " WHERE 1=1" + sql);
    }

    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND wu."))
            sb.append(" INNER JOIN wxuser wu ON wu.wxuser=wrg.wxuser");
        return sb.toString();
    }

    public void set() throws SQLException
    {
        String sql;
        if(wxredgrab < 1)
            sql = "INSERT INTO wxredgrab(wxredgrab,wxuser,wxred,code,money,status,json,ip,ran,time)VALUES(" + (wxredgrab = Seq.get()) + "," + wxuser + "," + wxred + "," + DbAdapter.cite(code) + "," + money + "," + status + "," + DbAdapter.cite(json) + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(ran) + "," + DbAdapter.cite(time) + ")";
        else
            sql = "UPDATE wxredgrab SET wxuser=" + wxuser + ",wxred=" + wxred + ",code=" + DbAdapter.cite(code) + ",money=" + money + ",status=" + status + ",ip=" + DbAdapter.cite(ip) + ",ran=" + ran + ",time=" + DbAdapter.cite(time) + " WHERE wxredgrab=" + wxredgrab;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wxredgrab,sql);
        } finally
        {
            db.close();
        }
        c.remove(wxredgrab);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wxredgrab,"DELETE FROM wxredgrab WHERE wxredgrab=" + wxredgrab);
        } finally
        {
            db.close();
        }
        c.remove(wxredgrab);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wxredgrab,"UPDATE wxredgrab SET " + f + "=" + DbAdapter.cite(v) + " WHERE wxredgrab=" + wxredgrab);
        } finally
        {
            db.close();
        }
        c.remove(wxredgrab);
    }

    public static void ref()
    {
//        try
//        {
//            ArrayList al = WxUser.find(" AND weixinid IS NOT NULL AND wxgroup!=80 AND wxuser NOT IN(SELECT wxuser FROM wxredgrab WHERE time>" + DbAdapter.cite(new Date(),true) + " GROUP BY wxuser HAVING COUNT(*)>2) ORDER BY NEWID()",0,3);
//            for(int i = 0;i < al.size();i++)
//            {
//                WxUser wu = (WxUser) al.get(i);
//                wu.score = 100;
//                wu.nodes += MT.f(new Date(),1) + "|";
//                wu.set("nodes",wu.nodes);
//                wu.set("hits",String.valueOf(wu.hits = 3));
//
//                WxRedGrab t = new WxRedGrab(0);
//                t.wxred = Integer.parseInt(wu.weixinid);
//                t.wxuser = (int) wu.wxuser;
//
//                Filex.logs("WxRedGrab.ref.txt",wu.nickname + "　rs:" + WxRedGrabs.add(t,new PrintWriter(System.out)));
//            }
//        } catch(Throwable ex)
//        {
//            Filex.logs("WxRedGrab.ref.txt",ex);
//        }
    }

    //补发
    public static void retry() throws Exception
    {
        StringBuilder sb = new StringBuilder();
        ArrayList al = WxRed.find("",0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            WxRed wr = (WxRed) al.get(i);
            float total = WxRedGrab.sum(" AND wxred=" + wr.wxred + " AND money>0");
            if(wr.pline > wr.total - total)
                sb.append("\r\n---\r\n地区:" + (wr.city < 1 ? "全国" : Card.find(wr.city).name) + "\r\n发放:" + total + "\r\n剩余:" + (wr.total - total));
        }
        if(sb.length() > 0)
            Err.send("警界线",sb.toString());

//        al = WxRedGrab.find(" AND status=2 AND wxuser=1506247579",0,200);
//        for(int i = 0;i < al.size();i++)
//        {
//            WxRedGrab wrg = (WxRedGrab) al.get(i);
//            WxUser wu = WxUser.find(wrg.wxuser);
//            XMLObject xo = wu.sendRedPack("知识竞答","恭喜你，获得“工伤保险知识网上问答”红包！",wrg.money);
//            System.out.println(wrg.wxuser + ":" + xo);
//            if("FAIL".equals(xo.getString("return_code")))
//            {
//                xo = wu.sendRedPack("知识竞答","恭喜你，获得“工伤保险知识网上问答”红包！",wrg.money);
//            }
//            //XMLObject xo = wu.getRedPack("14344340918731506247579");
//            System.out.println(wrg.wxuser + ":" + xo);
//            wrg.status = 3;
//        }
    }

    public String toString()
    {
        try
        {
            return "{wxredgrab:" + wxredgrab + ",wxuser:" + WxUser.find(wxuser) + ",wxred:" + wxred + ",code:" + Attch.cite(code) + ",money:" + money + ",ip:" + Attch.cite(ip) + ",time:" + time + "}";
        } catch(SQLException ex)
        {
            return null;
        }
    }
}
