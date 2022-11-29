package tea.entity.cluster;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import java.util.regex.*;

public class DML
{
    protected static Cache c = new Cache(50);
    public int dml;
    public int opid;
    public String content;
    public String trace;
    public String state = "|";
    public Date time;

    public DML(int dml)
    {
        this.dml = dml;
    }

    public static DML find(int dml) throws SQLException
    {
        DML t = (DML) c.get(dml);
        if(t == null)
        {
            ArrayList al = find(" AND dml=" + dml,0,1);
            t = al.size() < 1 ? new DML(dml) : (DML) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT dml,opid,content,trace,state,time FROM dml WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                DML t = new DML(rs.getInt(i++));
                t.opid = rs.getInt(i++);
                t.content = rs.getString(i++);
                t.trace = rs.getString(i++);
                t.state = rs.getString(i++);
                t.time = db.getDate(i++);
                c.put(t.dml,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM dml WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            set(db);
        } finally
        {
            db.close();
        }
    }

    static int seq = 1;
    public void set(DbAdapter db) throws SQLException
    {
        dml = Seq.get("sql"); //
        if(trace == null)
        {
            StringBuilder sb = new StringBuilder();
            Thread th = Thread.currentThread();
            sb.append(th.getName());
            StackTraceElement[] ste = th.getStackTrace();
            for(int i = 3;i < ste.length && i < 12;i++)
                sb.append("\r\n" + ste[i].toString());
            trace = sb.toString();
        }
        state = "|" + Cluster.getInstance().no + "|";
        String[] arr = DbAdapter.split("dml","content",content,"dml=" + dml);
        //
        db.executeUpdate("INSERT INTO dml(dml,opid,content,trace,state,time)VALUES(" + dml + "," + opid + "," + DbAdapter.cite(arr[0]) + "," + DbAdapter.cite(trace) + "," + DbAdapter.cite(state) + "," + DbAdapter.cite(new Date()) + ")");
        for(int i = 1;i < arr.length;i++)
        {
            db.executeUpdate(arr[i]);
        }
        c.remove(dml);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM dml WHERE dml=" + dml);
        c.remove(dml);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE dml SET " + f + "=" + DbAdapter.cite(v) + " WHERE dml=" + dml);
        c.remove(dml);
    }

    public String toString()
    {
        return "{\"dml\":" + dml + ",\"opid\":" + opid + ",\"content\":" + Attch.cite(content) + ",\"state\":" + Attch.cite(state) + ",\"time\":" + time.getTime() + "}";
    }

    /*public static void main(String args[]) throws Exception
    {
        if(args.length < 1)
        {
            System.out.println("导入SQL日志，方便分析！");
            System.out.println("\r\nDML path type");
            System.out.println("\r\n　　path 文件路径");
            System.out.println("\r\n　　type 类型 1 或 2");
            return;
        }
        parse(args[0],Integer.parseInt(args[1]));
    }*/

    public static void parse(String path,int tt) throws Exception
    {
        Pattern[] PS =
                {null,Pattern.compile("SELECT.+FROM (.+) WHERE",Pattern.CASE_INSENSITIVE),Pattern.compile("INSERT INTO ([^(]+)\\(",Pattern.CASE_INSENSITIVE),Pattern.compile("UPDATE (.+) SET",Pattern.CASE_INSENSITIVE),Pattern.compile("DELETE FROM (.+) WHERE",Pattern.CASE_INSENSITIVE)};

        //SELECT content,COUNT(content),SUM(opid) FROM dml GROUP BY content ORDER BY COUNT(content) DESC
        BufferedReader bis = new BufferedReader(new FileReader(path));
        String str;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("TRUNCATE TABLE dml");
            db.setAutoCommit(false);
            for(int i = 0;(str = bis.readLine()) != null;i++)
            {
                try
                {
                    String[] arr = str.split(",",3);
                    if(tt == 1)
                    {
                        DML d = new DML(0);
                        d.time = new Date(Long.parseLong(arr[0]));
                        d.opid = Integer.parseInt(arr[1]);
                        d.content = arr[2];
                        d.content = d.content; //.replaceAll("=\\d+","={d}").replaceAll("/[\\d/]+/","{path}");
                        d.trace = "";
                        for(int j = 1;j < PS.length;j++)
                        {
                            Matcher m = PS[j].matcher(arr[2]);
                            if(m.find())
                            {
                                d.trace = j + ":" + m.group(1);
                                break;
                            }
                        }
                        d.set(db);
                    } else if(tt == 2)
                    {
                        String tab = "null";
                        int type = 0; //1:查询;2:插入;3:修改;4:删除;
                        for(int j = 1;j < PS.length;j++)
                        {
                            Matcher m = PS[j].matcher(arr[2]);
                            if(m.find())
                            {
                                tab = m.group(1);
                                type = j;
                                break;
                            }
                        }
                        int time = Integer.parseInt(arr[1]);
                        int j = db.executeUpdate("UPDATE dml2 SET hits=hits+1,time=time+" + time + " WHERE tab=" + DbAdapter.cite(tab) + " AND type=" + type);
                        if(j < 1)
                            db.executeUpdate("INSERT INTO dml2(tab,type,hits,time)VALUES(" + DbAdapter.cite(tab) + "," + type + "," + 1 + "," + time + ")");
                    }
                    if(i % 1000 == 0)
                    {
                        db.commit();
                        System.out.println(i);
                    }
                } catch(Throwable ex)
                {
                    System.out.println(ex.toString() + ":" + str);
                }
            }
        } finally
        {
            db.setAutoCommit(true);
            db.close();
        }
        bis.close();
    }

}
