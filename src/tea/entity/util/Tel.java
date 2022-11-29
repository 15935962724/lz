package tea.entity.util;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

public class Tel
{
    protected static Cache c = new Cache(50);
    public int tel; //号码段
    public String address; //地址
    public String type; //卡类型
    public String code; //区号
    public String zip; //邮政编码

    public Tel(int tel)
    {
        this.tel = tel;
    }

    public static Tel find(int tel) throws SQLException
    {
        Tel t = (Tel) c.get(tel);
        if(t == null)
        {
            ArrayList al = find(" AND tel=" + tel,0,1);
            t = al.size() < 1 ? new Tel(tel) : (Tel) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT tel,address,type,code,zip FROM tel WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Tel t = new Tel(rs.getInt(i++));
                t.address = rs.getString(i++);
                t.type = rs.getString(i++);
                t.code = rs.getString(i++);
                t.zip = rs.getString(i++);
                c.put(t.tel,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM tel WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("INSERT INTO tel(tel,address,type,code,zip)VALUES(" + tel + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(type) + "," + DbAdapter.cite(code) + "," + DbAdapter.cite(zip) + ")");
            if(j < 1)
                db.executeUpdate("UPDATE tel SET address=" + DbAdapter.cite(address) + ",type=" + DbAdapter.cite(type) + ",code=" + DbAdapter.cite(code) + ",zip=" + DbAdapter.cite(zip) + " WHERE tel=" + tel);
        } finally
        {
            db.close();
        }
        c.remove(tel);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM tel WHERE tel=" + tel);
        c.remove(tel);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE tel SET " + f + "=" + DbAdapter.cite(v) + " WHERE tel=" + tel);
        c.remove(tel);
    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("{id:" + tel);
        sb.append(",address:" + Attch.cite(address));
        sb.append(",type:" + Attch.cite(type));
        sb.append(",code:" + Attch.cite(code));
        sb.append(",zip:" + Attch.cite(zip));
        sb.append("}");
        return sb.toString();
    }

    //
    /*public static void main(String[] args) throws Exception
    {
        String[] arr =
                {"139","138","137","136","135","134","159","158","152","151","150", //移动:2G
                "157","188","187", //3G
                "130","131","132","155","156", //联通:2G
                "186","185", //3G
                "133","153", //电信:2G
                "189","180" //3G
        };
        for(int i = 0;i < arr.length;i++)
        {
            for(int j = 0;j < 10000;j++)
            {
                Tel t = Tel.find(Integer.parseInt(arr[i] + Seq.DF4.format(j)));
                if(t.address != null)
                    continue;
                try
                {
                    String htm = (String) Http.open("http://www.ip138.com:8080/search.asp?mobile=" + t.tel + "0000&action=mobile",null);
                    htm = htm.replaceAll("<!-- <td></td> -->","");
                    //Filex.logs("tel/" + t.tel + ".htm",htm);
                    //System.out.println(htm);
                    int s = htm.indexOf("class=tdc2>") + 11,e = htm.indexOf("<",s);

                    s = htm.indexOf("tdc2",e);
                    s = htm.indexOf(">",s) + 1;
                    e = htm.indexOf("<",s);
                    t.address = htm.substring(s,e).replaceAll("&nbsp;"," ").trim();

                    s = htm.indexOf("tdc2",e);
                    s = htm.indexOf(">",s) + 1;
                    e = htm.indexOf("<",s);
                    t.type = htm.substring(s,e).trim();

                    s = htm.indexOf("tdc2",e);
                    s = htm.indexOf(">",s) + 1;
                    e = htm.indexOf("<",s);
                    t.code = htm.substring(s,e).trim();

                    s = htm.indexOf("tdc2",e);
                    s = htm.indexOf(">",s) + 1;
                    e = htm.indexOf("<",s);
                    t.zip = htm.substring(s,e).trim();
                    t.set();
                    if(j % 100 == 0)
                        System.out.println(t);
                } catch(Throwable ex)
                {
                    j--;
                    ex.printStackTrace();
                }
            }
        }
        System.out.println("OK");
        //OS.exec("shutdown /s /f /t 0");
    }*/
}
