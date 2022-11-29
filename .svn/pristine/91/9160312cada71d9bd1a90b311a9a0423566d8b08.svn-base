package tea.entity.site;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class FRes
{
    protected static Cache c = new Cache(50);
    public int fres; //资源文件
    public String community; //社区
    public String member; //用户
    public int node;
    public static String[] FRES_TYPE =
            {"默认","文章标题","副标题","作者图片","节点图片","内容图片"};
    public int type; //图片类型
    public String path; //路径
    public String alt; //节点主题
    public Date time; //上传时间

    public FRes(int fres)
    {
        this.fres = fres;
    }

    public static FRes find(int fres) throws SQLException
    {
        FRes t = (FRes) c.get(fres);
        if(t == null)
        {
            ArrayList al = find(" AND fres=" + fres,0,1);
            t = al.size() < 1 ? new FRes(fres) : (FRes) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT fres,community,member,node,type,path,alt,time FROM FRes WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                FRes t = new FRes(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.member = rs.getString(i++);
                t.node = rs.getInt(i++);
                t.type = rs.getInt(i++);
                t.path = rs.getString(i++);
                t.alt = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.fres,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM FRes WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO FRes(fres,community,member,node,alt,type,path,time)VALUES(" + fres + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + node + "," + DbAdapter.cite(alt) + "," + type + "," + DbAdapter.cite(path) + "," + DbAdapter.cite(time) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE FRes SET member=" + DbAdapter.cite(member) + ",node=" + node + ",alt=" + DbAdapter.cite(alt) + ",type=" + type + ",path=" + DbAdapter.cite(path) + ",time=" + DbAdapter.cite(time) + " WHERE fres=" + fres);
            }
        } finally
        {
            db.close();
        }
        c.remove(fres);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM FRes WHERE fres=" + fres);
        c.remove(fres);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE FRes SET " + f + "=" + DbAdapter.cite(v) + " WHERE fres=" + fres);
        c.remove(fres);
    }
}
