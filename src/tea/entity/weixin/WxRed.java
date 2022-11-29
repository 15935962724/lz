package tea.entity.weixin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.util.*;

public class WxRed extends Entity
{
    protected static Cache _caches = new Cache(100);
    public int wxred; //红包
    public String community; //社区
    public int city; //城市
    public int limit; //每天上限
    public int total; //共充值
    public static final int[] PROBABILITY =
            {0,1,2,5,10,20,50}; //元
    public int[] probability = new int[7]; //中奖概率
    public int pline; //警界线
    public boolean hidden; //隐藏
    public WxRed(int wxred)
    {
        this.wxred = wxred;
    }

    public static WxRed find(int wxred) throws SQLException
    {
        ArrayList al = find(" AND wxred=" + wxred,0,1);
        return al.size() < 1 ? new WxRed(wxred) : (WxRed) al.get(0);
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        String key = sql + "/" + pos + "," + size;
        ArrayList al = (ArrayList) _caches.get(key);
        if(al != null)
            return al;
        al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT wxred,community,city,limit,total,probability1,probability2,probability3,probability4,probability5,probability6,pline,hidden FROM wxred WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                WxRed t = new WxRed(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.city = rs.getInt(i++);
                t.limit = rs.getInt(i++);
                t.total = rs.getInt(i++);
                t.probability[1] = rs.getInt(i++);
                t.probability[2] = rs.getInt(i++);
                t.probability[3] = rs.getInt(i++);
                t.probability[4] = rs.getInt(i++);
                t.probability[5] = rs.getInt(i++);
                t.probability[6] = rs.getInt(i++);
                t.pline = rs.getInt(i++);
                t.hidden = rs.getBoolean(i++);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        _caches.put(key,al);
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM wxred WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(wxred < 1)
            sql = "INSERT INTO wxred(wxred,community,city,limit,total,probability1,probability2,probability3,probability4,probability5,probability6,pline,hidden)VALUES(" + (wxred = Seq.get()) + "," + DbAdapter.cite(community) + "," + city + "," + limit + "," + total + "," + probability[1] + "," + probability[2] + "," + probability[3] + "," + probability[4] + "," + probability[5] + "," + probability[6] + "," + pline +","+DbAdapter.cite(hidden)+ ")";
        else
            sql = "UPDATE wxred SET community=" + DbAdapter.cite(community) + ",city=" + city + ",limit=" + limit + ",total=" + total + ",probability1=" + probability[1] + ",probability2=" + probability[2] + ",probability3=" + probability[3] + ",probability4=" + probability[4] + ",probability5=" + probability[5] + ",probability6=" + probability[6] + ",pline=" + pline+ ",hidden=" + DbAdapter.cite(hidden) + " WHERE wxred=" + wxred;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wxred,sql);
        } finally
        {
            db.close();
        }
        _caches.clear();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wxred,"DELETE FROM wxred WHERE wxred=" + wxred);
        } finally
        {
            db.close();
        }
        _caches.clear();
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(wxred,"UPDATE wxred SET " + f + "=" + DbAdapter.cite(v) + " WHERE wxred=" + wxred);
        } finally
        {
            db.close();
        }
        _caches.clear();
    }

    public static String options(String sql,int dv) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        ArrayList al = find(sql,0,200);
        for(int i = 0;i < al.size();i++)
        {
            WxRed wr = (WxRed) al.get(i);
            sb.append("<option value=" + wr.wxred);
            if(wr.wxred == dv)
                sb.append(" selected");
            sb.append(">" + (wr.city < 1 ? "全国" : Card.find(wr.city).name));
        }
        return sb.toString();
    }

}
