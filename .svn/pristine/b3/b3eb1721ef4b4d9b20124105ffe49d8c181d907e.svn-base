package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class NodeFlow
{
    protected static Cache c = new Cache(50);
    public int flow;
    public int node; //节点号
    public int member; //操作人
    public static String[] STATE_TYPE =
            {"--",
            "上传资料", //1
            "修改资料", //2
            "分享到微博", //3
            "取消分享", //4
            "删除", //5
            "定时分享" //6
    };
    public int state; //状态
    public String content; //备注
    public Date time; //操作时间

    public NodeFlow(int flow)
    {
        this.flow = flow;
    }

    public static NodeFlow find(int flow) throws SQLException
    {
        NodeFlow t = (NodeFlow) c.get(flow);
        if(t == null)
        {
            ArrayList al = find(" AND flow=" + flow,0,1);
            t = al.size() < 1 ? new NodeFlow(flow) : (NodeFlow) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT flow,node,member,state,content,time FROM nodeflow WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                NodeFlow t = new NodeFlow(rs.getInt(i++));
                t.node = rs.getInt(i++);
                t.member = rs.getInt(i++);
                t.state = rs.getInt(i++);
                t.content = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.flow,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM nodeflow WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        String sql;
        if(flow < 1)
        {
            time = new Date();
            sql = "INSERT INTO nodeflow(flow,node,member,state,content,time)VALUES(" + (flow = Seq.get()) + "," + node + "," + member + "," + state + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(time) + ")";
        } else
            sql = "UPDATE nodeflow SET node=" + node + ",member=" + member + ",state=" + state + ",content=" + DbAdapter.cite(content) + ",time=" + DbAdapter.cite(time) + " WHERE flow=" + flow;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql);
        } finally
        {
            db.close();
        }
        c.remove(flow);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM nodeflow WHERE flow=" + flow);
        c.remove(flow);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE nodeflow SET " + f + "=" + DbAdapter.cite(v) + " WHERE flow=" + flow);
        c.remove(flow);
    }

    //
    public static NodeFlow findLast(String sql) throws SQLException
    {
        ArrayList al = find(sql + " ORDER BY flow DESC",0,1);
        return al.size() < 1 ? new NodeFlow(0) : (NodeFlow) al.get(0);
    }
}
