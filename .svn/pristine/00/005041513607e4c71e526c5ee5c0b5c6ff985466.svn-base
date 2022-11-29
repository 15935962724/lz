package tea.entity.weixin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class WxCoupon extends Entity
{
    public int wxcoupon; //优惠券
    public long wxuser; //用户
    public String code; //序列号
    public String type; //类型
    public float money; //金额
    public int node;
    public Date starttime; //领取时间
    public Date stoptime; //结束时间

    public WxCoupon(int wxcoupon)
    {
        this.wxcoupon = wxcoupon;
    }

    public static WxCoupon find(int wxcoupon) throws SQLException
    {
        WxCoupon t = (WxCoupon) _cache.get(wxcoupon);
        if(t == null)
        {
            ArrayList al = find(" AND wxcoupon=" + wxcoupon,0,1);
            t = al.size() < 1 ? new WxCoupon(wxcoupon) : (WxCoupon) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT wxcoupon,wxuser,code,type,money,node,starttime,stoptime FROM wxcoupon WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WxCoupon t = new WxCoupon(rs.getInt(i++));
                t.wxuser = rs.getLong(i++);
                t.code = rs.getString(i++);
                t.type = rs.getString(i++);
                t.money = rs.getFloat(i++);
                t.node = rs.getInt(i++);
                t.starttime = db.getDate(i++);
                t.stoptime = db.getDate(i++);
                _cache.put(t.wxcoupon,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM wxcoupon WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(wxcoupon < 1)
        {
            Calendar c = Calendar.getInstance();
            c.add(Calendar.MONTH, -2);
            sql = "INSERT INTO wxcoupon(wxcoupon,wxuser,code,type,money,node,starttime,stoptime)VALUES(" + (wxcoupon = Seq.get(c.getTime())) + "," + wxuser + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(type) + "," + money + "," + node + "," + DbAdapter.cite(starttime) + "," + DbAdapter.cite(stoptime) + ")";
        } else
            sql = "UPDATE wxcoupon SET wxuser=" + wxuser + ",code=" + DbAdapter.cite(code) + ",type=" + DbAdapter.cite(type) + ",money=" + money + ",node=" + node + ",starttime=" + DbAdapter.cite(starttime) + ",stoptime=" + DbAdapter.cite(stoptime) + " WHERE wxcoupon=" + wxcoupon;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wxcoupon,sql);
        } finally
        {
            db.close();
        }
        _cache.remove(wxcoupon);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wxcoupon,"DELETE FROM wxcoupon WHERE wxcoupon=" + wxcoupon);
        } finally
        {
            db.close();
        }
        _cache.remove(wxcoupon);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wxcoupon,"UPDATE wxcoupon SET " + f + "=" + DbAdapter.cite(v) + " WHERE wxcoupon=" + wxcoupon);
        } finally
        {
            db.close();
        }
        _cache.remove(wxcoupon);
    }
}
