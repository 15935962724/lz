package tea.entity;

import tea.ui.*;
import tea.db.*;
import java.sql.SQLException;
import java.util.*;
import java.io.*;
import javax.servlet.http.*;

public class Table
{
    private static Cache c = new Cache(100);
    public static String CITY = "tcity";
    public static String GTYPE = "gtype";
    public int tid;
    public String name;
    public int sequence;
    public Table()
    {
    }

    public static Table find(String table,int tid) throws SQLException
    {
        Table t = (Table) c.get(table + ":" + tid);
        if(t == null)
        {
            ArrayList al = find(table,null," AND tid=" + tid,0,1);
            t = al.size() < 1 ? new Table() : (Table) al.get(0);
        }
        if(tid == 0)
        {
            t.sequence = DbAdapter.execute("SELECT MAX(sequence) FROM " + table) + 1;
        }
        return t;
    }

    public static ArrayList find(String table,String community,String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT tid,name,sequence FROM " + table + " WHERE " + (community == null ? "1=1" : "community=" + DbAdapter.cite(community)) + sql,pos,size);
            while(db.next())
            {
                Table t = new Table();
                int j = 1;
                t.tid = db.getInt(j++);
                t.name = db.getString(j++);
                t.sequence = db.getInt(j++);
                c.put(table + ":" + t.tid,t);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static String options(String table,String community,String dv) throws SQLException
    {
        boolean flag = dv != null && dv.length() > 0;
        StringBuffer sb = new StringBuffer();
        Iterator it = find(table,community,"",0,200).iterator();
        while(it.hasNext())
        {
            Table t = (Table) it.next();
            sb.append("<option value='" + t.tid + "'");
            if(flag && String.valueOf(t.tid).equals(dv))
            {
                sb.append(" selected=''");
                flag = false;
            }
            sb.append(">" + t.name);
        }
        if(flag)
        {
            sb.append("<option value=\"" + dv + "\" selected=''>" + dv);
        }
        return sb.toString();
    }

    public static int count(String table,String community,String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM " + table + " WHERE community=" + DbAdapter.cite(community) + sql);
    }

    public static void create(String table,String community,String name,int sequence) throws SQLException
    {
        DbAdapter.execute("INSERT INTO " + table + "(community,name,sequence)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(name) + "," + sequence + ")");
    }

    public static void set(String table,int tid,String name,int sequence) throws SQLException
    {
        DbAdapter.execute("UPDATE " + table + " SET name=" + DbAdapter.cite(name) + ",sequence=" + sequence + " WHERE tid=" + tid);
    }

    public static void delete(String table,int tid) throws SQLException
    {
        DbAdapter.execute("DELETE FROM " + table + " WHERE tid=" + tid);
    }

    public static String list(String table,Http h,String url) throws SQLException,IOException
    {
        String sql = "";
        String mid = h.get("id");
        StringBuffer par = new StringBuffer();
        par.append("?community=" + h.community + "&id=" + mid);
        par.append("&pos=");
        int pos = h.getInt("pos");

        int sum = Table.count(table,h.community,sql);
        StringBuffer sb = new StringBuffer();
        sb.append("<script>function f_edit(tid){ window.open('" + url + "?&community=" + h.community + "&tid='+tid,'_self');}\r\n");
        sb.append("function f_del(tid){if(confirm('确认删除?'))window.open('?id=" + mid + "&community=" + h.community + "&key=" + Http.enc(MT.enc("del")) + "&nexturl='+encodeURIComponent(location.href)+'&tid='+tid,'_self');}</script>\r\n");
        sb.append("<table id='tablecenter'><tr id='tableonetr'>");
        sb.append("<td>序号</td>");
        sb.append("<td>名称</td>");
        sb.append("<td>顺序</td>");
        sb.append("<td>操作</td>");
        sb.append("</tr>\r\n");

        Iterator e = Table.find(table,h.community,sql + " ORDER BY sequence",pos,10).iterator();
        for(int i = 1;e.hasNext();i++)
        {
            Table obj = (Table) e.next();
            sb.append("<tr onMouseOver=\"bgColor='#BCD1E9'\" onMouseOut=\"bgColor=''\">");
            sb.append("<td>" + i + "</td>");
            sb.append("<td>" + obj.name + "</td>");
            sb.append("<td>" + obj.sequence + "</td>");
            sb.append("<td><input type='button' onclick='f_edit(" + obj.tid + ")' value='编辑'> <input type='button' onclick='f_del(" + obj.tid + ");' value='删除'></td>");
            sb.append("</tr>\r\n");
        }
        sb.append("</table><br>");
        sb.append(new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,10).toString());
        sb.append("<input type='button' value='添加' onclick='f_edit(0)' />");
        return sb.toString();
    }

    public static void post(String table,Http h,HttpServletResponse response) throws SQLException,IOException
    {
        int tid = h.getInt("tid");
        String nexturl = h.get("nexturl");
        if("del".equals(h.key))
        {
            Table.delete(table,tid);
        } else if("POST".equals(h.request.getMethod()))
        {
            String name = h.get("name");
            int sequence = h.getInt("sequence");
            if(tid < 1)
            {
                Table.create(table,h.community,name,sequence);
            } else
            {
                Table.set(table,tid,name,sequence);
            }
            c.remove(table + ":" + tid);
        } else
        {
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            out.print("<script>alert('信息修改成功!');");
            if(nexturl != null)
            {
                out.print("window.open('" + nexturl + (nexturl.indexOf('?') == -1 ? '?' : '&') + "community=" + h.community + "','_self');");
            }
            out.print("</script>");
        } finally
        {
            out.flush();
            if(nexturl != null)
            {
                out.close();
            }
        }
    }
}
/*
 CREATE TABLE dbo.gtype
 (
 tid int NOT NULL IDENTITY (1, 1),
 community varchar(50) NULL,
 name varchar(50) NULL,
 sequence int NULL
 )  ON [PRIMARY]
 GO
 ALTER TABLE dbo.gtype ADD CONSTRAINT
 PK_gtype PRIMARY KEY CLUSTERED
 (
 tid
 ) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

 GO
 */
