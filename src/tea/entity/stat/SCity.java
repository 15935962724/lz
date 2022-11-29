package tea.entity.stat;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import java.text.SimpleDateFormat;

public class SCity
{
    protected static Cache c = new Cache(50);
    public int scity; //地区分布
    public String community; //站点
    public String city; //地区
    public int pv;
    public int uv;
    public int ip;
    public Date time; //时间

    public SCity(int scity)
    {
        this.scity = scity;
    }

    public static SCity find(int scity) throws SQLException
    {
        SCity t = (SCity) c.get(scity);
        if(t == null)
        {
            ArrayList al = find(" AND scity=" + scity,0,1);
            t = al.size() < 1 ? new SCity(scity) : (SCity) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT scity,community,city,pv,uv,ip,time FROM scity WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                SCity t = new SCity(rs.getInt(i++));
                t.community = rs.getString(i++);
                t.city = rs.getString(i++);
                t.pv = rs.getInt(i++);
                t.uv = rs.getInt(i++);
                t.ip = rs.getInt(i++);
                t.time = db.getDate(i++);
                c.put(t.scity,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM scity WHERE 1=1" + sql);
    }

    public void set(DbAdapter db) throws SQLException
    {
        if(scity < 1)
            db.executeUpdate("INSERT INTO scity(community,city,pv,uv,ip,time)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(city) + "," + pv + "," + uv + "," + ip + "," + DbAdapter.cite(time) + ")");
        else
            db.executeUpdate("UPDATE scity SET community=" + DbAdapter.cite(community) + ",city=" + DbAdapter.cite(city) + ",pv=" + pv + ",uv=" + uv + ",ip=" + ip + ",time=" + DbAdapter.cite(time) + " WHERE scity=" + scity);
        c.remove(scity);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM scity WHERE scity=" + scity);
        c.remove(scity);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE scity SET " + f + "=" + DbAdapter.cite(v) + " WHERE scity=" + scity);
        c.remove(scity);
    }

    //
    public static String chart(Http h) throws SQLException
    {
        int tab = h.getInt("tab");
        int type = h.getInt("type");
        String[] COLOR =
                {"FFA333","009149","0058C6"};
        int[] LEN =
                {10,7},LEN2 =
                        {5,0};

        StringBuilder lab = new StringBuilder();
        StringBuilder[] val = new StringBuilder[3];
        int[] total = new int[3];

        Calendar st = Calendar.getInstance(),et = Calendar.getInstance();
        Date stt = h.getDate("st");
        if(stt == null)
        {
            if(tab == 0) //天
            {
                st.add(Calendar.MONTH, -1);
                st.set(Calendar.HOUR_OF_DAY,0);
            }
            st.set(Calendar.MINUTE,0);
            st.set(Calendar.SECOND,0);
            stt = st.getTime();
        }
        st.setTime(stt);
        Date ett = h.getDate("et");
        if(ett != null)
            et.setTime(ett);

        int max = 50;
//
        HashMap hm = new HashMap();
        String expr = DbAdapter.format("time",LEN[tab]);
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT " + expr + " expr,SUM(pv),SUM(uv),SUM(ip) FROM scity WHERE community=" + DbAdapter.cite(h.community) + " AND city=" + DbAdapter.cite(h.get("city")) + " AND time>=" + DbAdapter.cite(st.getTime()) + " AND time<" + DbAdapter.cite(et.getTime()) + " GROUP BY " + expr + " ORDER BY expr",0,Integer.MAX_VALUE);
            for(int i = 1;rs.next();i++)
            {
                int[] arr =
                        {rs.getInt(2),rs.getInt(3),rs.getInt(4)};
                hm.put(rs.getString(1),arr);
                max = Math.max(max,arr[0]);
            }
            rs.close();
        } finally
        {
            db.close();
        }

        SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd HH".substring(0,LEN[tab]));
        while(st.getTimeInMillis() < et.getTimeInMillis())
        {
            String tip = SDF.format(st.getTime());
            int[] arr = (int[]) hm.get(tip);
            if(arr == null)
                arr = new int[]
                      {0,0,0};

            lab.append(",'" + tip.substring(LEN2[tab]) + "'");
            tip += "<br>浏览次数(PV): " + MT.f(arr[0]) + " <br>独立访客(UV): " + MT.f(arr[1]) + " <br>　　　　(IP): " + MT.f(arr[2]);
            for(int j = 0;j < val.length;j++)
            {
                if(val[j] == null)
                    val[j] = new StringBuilder();
                val[j].append(type == 0 ? "," + arr[j] : ",{'top':" + arr[j] + ",'tip':'" + tip + "'}");
                total[j] += arr[j];
            }

            if(tab == 0)
                st.add(Calendar.DAY_OF_YEAR,1);
            else
                st.add(Calendar.MONTH,1);
        }
        String[] LAB =
                {"浏览次数(PV)","独立访客(UV)","IP"};
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("  'elements':");
        sb.append("  [");
        for(int j = 0;j < val.length;j++)
        {
            if(j > 0)
                sb.append(",");
            sb.append("    {");
            sb.append("      'type':'" + (type == 0 ? "line" : "bar_glass") + "',");
            sb.append("      'values':[" + val[j].substring(1) + "],");
            sb.append("      'text':'" + LAB[j] + "(" + total[j] + ")',");
            sb.append("      'tip':'#label#<br>金额：#val#万元<br>总计：#total#万元<br>占比：#percent#',");
            sb.append("      'colour':'" + COLOR[j] + "',");
            sb.append("      'on-show':");
            sb.append("      {");
            sb.append("        'type': 'pop-up',");
            sb.append("        'cascade': 1");
            sb.append("      }");
            sb.append("    }");
        }
        sb.append("  ],");
        sb.append("  'x_axis':");
        sb.append("  {");
        sb.append("    'labels':");
        sb.append("    {");
        if(lab.length() > 300)
            sb.append("      'rotate':" + (360 - 90) + ",");
        else if(lab.length() > 200)
            sb.append("      'rotate':" + (360 - 35) + ",");
        sb.append("      'labels':[" + lab.substring(1) + "],");
        sb.append("      'size':12");
        sb.append("    },");
        sb.append("    'colour':'#000000',");
        sb.append("    'grid-colour':'#E4E4E4'");
        sb.append("  },");
        sb.append("  'y_axis':");
        sb.append("  {");
        sb.append("    'max':" + max + ",");
        sb.append("    'steps':" + max / 10 + ",");
        sb.append("    'colour':'#000000',");
        sb.append("    'grid-colour':'#E4E4E4'");
        sb.append("  },");
        //sb.append("  'title':{'text':'" + TAB[tab] + "','style':'font-size:20px;'},");
        sb.append("  'bg_colour':'#FFFFFF',");
        sb.append("  'tooltip':{'stroke':1}");
        sb.append("}");
        return sb.toString();
    }
}
