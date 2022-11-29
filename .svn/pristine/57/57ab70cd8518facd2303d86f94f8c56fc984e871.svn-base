package tea.entity.stat;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.util.Card;

//襄樊==>襄阳
//update card set name='襄阳' where card=4206;
//UPDATE ip SET card=4206 WHERE district LIKE '湖北省襄阳市%';
public class Ip
{
    protected static Cache c = new Cache(50);
    public long onip;
    public long offip;
    public String district;
    public String address;
    public int card;

    public Ip(long onip)
    {
        this.onip = onip;
    }

    public static Ip find(long onip) throws SQLException
    {
        Ip t = (Ip) c.get(onip);
        if(t == null)
        {
            ArrayList al = find(" AND onip=" + onip,0,1);
            t = al.size() < 1 ? new Ip(onip) : (Ip) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT onip,offip,district,address,card FROM ip WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Ip t = new Ip(rs.getLong(i++));
                t.offip = rs.getLong(i++);
                t.district = rs.getString(i++);
                t.address = rs.getString(i++);
                t.card = rs.getInt(i++);
                c.put(t.onip,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM ip WHERE 1=1" + sql);
    }

    public void set(DbAdapter db) throws SQLException
    {
//        try
//        {
//            FileWriter fw = new FileWriter("D:/ip_" + onip / 1000000000 + ".sql",true);
//            fw.write("INSERT INTO ip(onip,offip,district,address)VALUES(" + onip + "," + offip + "," + DbAdapter.cite(district) + "," + DbAdapter.cite(address) + ");\r\nGO\r\n");
//            fw.close();
//        } catch(IOException ex)
//        {
//            ex.printStackTrace();
//        }
        int i = db.executeUpdate("INSERT INTO ip(onip,offip,district,address)VALUES(" + onip + "," + offip + "," + DbAdapter.cite(district) + "," + DbAdapter.cite(address) + ")");
        if(i < 1)
        {
            db.executeUpdate("UPDATE ip SET onip=" + onip + ",offip=" + offip + ",district=" + DbAdapter.cite(district) + ",address=" + DbAdapter.cite(address) + " WHERE onip=" + onip);
        }
        c.remove(onip);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM ip WHERE onip=" + onip);
        c.remove(onip);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE ip SET " + f + "=" + DbAdapter.cite(v) + " WHERE onip=" + onip);
        c.remove(onip);
    }

    //
    public static Ip find(String ipaddr) throws SQLException
    {
        long ip = conv(ipaddr);
        ArrayList al = find(" AND onip<=" + ip + " and offip>=" + ip + " ORDER BY onip DESC",0,1);
        return al.size() < 1 ? new Ip(ip) : (Ip) al.get(0);
    }

    public static String findByIp(String ipaddr) throws SQLException
    {
        String str = "未知";
        long ip = conv(ipaddr);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT district,address FROM ip WHERE onip<=" + ip + " and offip>=" + ip + " ORDER BY onip DESC",0,1);
            if(db.next())
            {
                str = db.getString(1);
                String addr = db.getString(2);
                if(addr != null)
                    str += " " + addr;
            }
        } finally
        {
            db.close();
        }
        return str;
    }

    public static long conv(String str)
    {
        int j = str.indexOf(',');
        if(j > 0)
            str = str.substring(0,j);

        long ip = 0;
        long[] a =
                {24,16,8,0};
        String[] arr = str.split("[.]");
        for(int i = 0;i < arr.length;i++)
        {
            ip += Long.parseLong(arr[i]) << a[i];
        }
        return ip;
    }

    public static String conv(long ip)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(String.valueOf(ip >>> 24));
        sb.append(".");
        sb.append(String.valueOf((ip & 0x00FFFFFF) >>> 16));
        sb.append(".");
        sb.append(String.valueOf((ip & 0x0000FFFF) >>> 8));
        sb.append(".");
        sb.append(String.valueOf(ip & 0x000000FF));
        return sb.toString();
    }

    //导入  2012-11-26更新lvyou.westrac.com.cn
    //     2014年6月10日  控烟
    public static void ref() throws IOException,SQLException
    {
        String str = null;
        Ip t = new Ip(0);
        DbAdapter db = new DbAdapter();
        BufferedReader br = new BufferedReader(new FileReader("D:/~2/ip.txt"));
        try
        {
            db.setAutoCommit(false);
            for(int i = 0;(str = br.readLine()) != null && str.length() > 0;i++)
            {
                String[] arr = (str).split(" +",4);
                if(arr[2].equals("CZ88.NET"))
                    continue;
                int j = arr[2].indexOf('市',2);
                if(j != -1)
                    arr[2] = arr[2].substring(0,j + 1);
                if(arr[2].length() > 5)
                {
                    j = arr[2].indexOf('州',arr[2].charAt(2) == '省' ? 5 : 4);
                    if(j != -1)
                        arr[2] = arr[2].substring(0,j + 1);
                }
                if(i % 10000 == 0)
                {
                    System.out.println(i);
                    db.commit();
                }
                if(arr[2].equals(t.district))
                {
                    t.offip = conv(arr[1]);
                } else
                {
                    if(t.offip > 0)
                        t.set(db);
                    t = new Ip(0);
                    t.onip = conv(arr[0]);
                    t.offip = conv(arr[1]);
                    t.district = arr[2];
                    //if(arr.length > 3)
                    //    t.address = arr[3].equals("CZ88.NET") ? null : arr[3];
                }
            }
            t.set(db);
            db.setAutoCommit(true);
        } catch(Throwable ex)
        {
            System.out.println(str + ":" + ex.toString());
            ex.printStackTrace();
        } finally
        {
			br.close();
            db.close();
        }
    }

    public static void card() throws SQLException
    {
        ArrayList al = Card.find(" AND card<99",0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            Card t = (Card) al.get(i);
            System.out.println(t.name);
            DbAdapter.execute("UPDATE ip SET card=" + t.card + " WHERE district LIKE " + DbAdapter.cite(t.name + "%"));
            ArrayList al2 = Card.find(" AND card LIKE '" + t.card + "__'",0,Integer.MAX_VALUE);
            for(int j = 0;j < al2.size();j++)
            {
                Card c = (Card) al2.get(j);
                System.out.println("　　" + c.name);
                DbAdapter.execute("UPDATE ip SET card=" + c.card + " WHERE card=" + t.card + " AND district LIKE " + DbAdapter.cite("%" + c.name + "%"));
            }
        }
    }

//    public static void main(String[] args) throws Exception
//    {
//        ref();
////        Date time = MT.SDF[1].parse("2014-04-04 00:00");
////        System.out.println(time.getTime());
////		time = MT.SDF[1].parse("2014-04-03 00:00");
////        System.out.println(time.getTime());
////        System.out.println(MT.f(new Date(time.getTime() / 86400000 * 86400000),1)); //86400000
//        //System.out.println("重庆市万州区王家坡".indexOf('市',3));
//        //Stat.parse();
//    }
}
