package tea.entity.stat;

import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;
import java.util.regex.*;
import tea.db.*;
import tea.entity.*;

public class SPage
{
    protected static Cache c = new Cache(50);
    public int spage; //受访页面
    public String community; //站点
    public int node; //网页
    public int[] pv = new int[6]; //浏览量
    public int[] uv = new int[6]; //访客数
    public int[] ip = new int[6]; //IP数
    public int[] entrance = new int[6]; //入口页次数
    public int[] outward = new int[6]; //贡献下游流量
    public int[] exit = new int[6]; //退出页次数
    public int[] stay = new int[6]; //平均停留时长
    public int[] rate = new int[6]; //退出率=该页面的退出次数/该页面的PV数。
    public Date time; //时间

    public SPage(int spage)
    {
        this.spage = spage;
    }

    public static SPage find(int spage) throws SQLException
    {
        SPage t = (SPage) c.get(spage);
        if(t == null)
        {
            ArrayList al = find(" AND spage=" + spage,0,1);
            t = al.size() < 1 ? new SPage(spage) : (SPage) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT spage,community,node,pv,uv,ip,time FROM spage WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                SPage t = new SPage(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.node = rs.getInt(i++);
                t.pv[0] = rs.getInt(i++);
                t.uv[0] = rs.getInt(i++);
                t.ip[0] = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.spage,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM spage WHERE 1=1" + sql);
    }

    public void set(DbAdapter db) throws SQLException
    {
        if(spage < 1)
            db.executeUpdate("INSERT INTO spage(community,node,pv,uv,ip,time)VALUES(" + DbAdapter.cite(community) + "," + node + "," + pv + "," + uv + "," + ip + "," + DbAdapter.cite(time) + ")");
        else
            db.executeUpdate("UPDATE spage SET community=" + DbAdapter.cite(community) + ",node=" + node + ",pv=" + pv + ",uv=" + uv + ",ip=" + ip + ",time=" + DbAdapter.cite(time) + " WHERE spage=" + spage);
        c.remove(spage);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM spage WHERE spage=" + spage);
        c.remove(spage);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE spage SET " + f + "=" + DbAdapter.cite(v) + " WHERE spage=" + spage);
        c.remove(spage);
    }

    //
    public static String chart(String tab,String name,String sql,int group) throws SQLException
    {
        HashMap<String,String> FTV = new HashMap(9);
        FTV.put("01-01","元旦节");
        FTV.put("02-14","情人节");
        FTV.put("03-08","妇女节");
        FTV.put("03-15","权益日");
        FTV.put("04-01","愚人节");
        FTV.put("05-01","劳动节");
        FTV.put("10-01","国庆节");
        FTV.put("12-24","平安夜");
        FTV.put("12-25","圣诞节");
        //
        String[] cols = tab.split(","),names = name.split(",");
        int[] LEN =
                {10,7};

        //
        HashMap hm = new HashMap();
        String expr = DbAdapter.format("time",LEN[group]);
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT " + expr + " expr");
        for(int i = 1;i < cols.length;i++)
        {
            sb.append(",SUM(" + cols[i] + ")");
        }
        sb.append(" FROM " + cols[0] + " WHERE 1=1" + sql + " GROUP BY " + expr + " ORDER BY expr");
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery(sb.toString(),0,Integer.MAX_VALUE);
            for(int i = 1;rs.next();i++)
            {
                int[] arr = new int[cols.length];
                for(int j = 1;j < arr.length;j++)
                    arr[j] = rs.getInt(j + 1);
                hm.put(rs.getString(1),arr);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        //
        long et = 0L;
        Calendar st = Calendar.getInstance();
        Matcher m = Pattern.compile("\\d{4}-\\d{2}-\\d{2}").matcher(sql);
        if(m.find())
            st.setTime(MT.d(m.group(0)));
        if(m.find())
            et = MT.d(m.group(0)).getTime();
        //
        StringBuilder lab = new StringBuilder();
        StringBuilder[] val = new StringBuilder[9];
        int[] def =
                {0,0,0,0,0,0,0,0,0,0};
        SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd HH".substring(0,LEN[group]));
        while(st.getTimeInMillis() < et)
        {
            String tip = SDF.format(st.getTime());
            int[] arr = (int[]) hm.get(tip);
            if(arr == null)
                arr = def;
            if(group == 0) // 节假日
            {
                String ftv = FTV.get(tip.substring(5));
                if(ftv == null)
                {
                    int week = st.get(Calendar.DAY_OF_WEEK) - 1;
                    if(week == 0)
                        ftv = "星期日";
                    else if(week == 6)
                        ftv = "星期六";
                }
                if(ftv != null)
                    tip += " " + ftv;
            }
            //
            lab.append(",'" + tip + "'");
            for(int j = 1;j < cols.length;j++)
            {
                if(val[j] == null)
                    val[j] = new StringBuilder();
                val[j].append(",");
                if(j == 4) //跳出率
                    val[j].append("'" + arr[j] / 100F + "%'");
                else if(j == 5) //访问时长
                    val[j].append("'" + MT.ss(arr[j]) + "'");
                else
                    val[j].append(arr[j]);
            }
            if(group == 0)
                st.add(Calendar.DAY_OF_YEAR,1);
            else
                st.add(Calendar.MONTH,1);
        }
        // 走势图
        StringBuilder js = new StringBuilder();
        js.append("{");
        //
        js.append("  xAxis:[{data:[" + lab.substring(1) + "]}],");
        js.append("  series:");
        js.append("  [");
        for(int i = 1;i < cols.length;i++)
        {
            js.append(i == 1 ? ' ' : ',');
            js.append("    {");
            js.append("      name:'" + names[i] + "',");
            js.append("      type:'line',");
            js.append("      data:[" + val[i].substring(1) + "]");
            js.append("    }");
        }
        js.append("  ]");
        js.append("}");
        return js.toString();
    }
}
