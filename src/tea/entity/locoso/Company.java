package tea.entity.locoso;

import java.sql.*;
import java.util.*;

import tea.db.*;

public class Company
{
    String id;
    int city;
    String category;
    String html;
    String name;
    String address;
    String zip;
    String tel;
    String email;
    String url;
    String intr; //企业简介
    String business; //经营范围
    String info; //企业个性信息
    String content; //企业详细信息
    String map;
    boolean exists;
    public Company(String id) throws SQLException
    {
        this.id = id;
        load();
    }

    public Company(String id,int city,String category,String html,String name,String address,String zip,String tel,String email,String url,String intr,String business,String info,String content,String map)
    {
        this.id = id;
        this.city = city;
        this.category = category;
        this.html = html;
        this.name = name;
        this.address = address;
        this.zip = zip;
        this.tel = tel;
        this.email = email;
        this.url = url;
        this.intr = intr;
        this.business = business;
        this.info = info;
        this.content = content;
        this.map = map;
        this.exists = true;
    }

    public static Company find(String id) throws SQLException
    {
        return new Company(id);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter(Locoso.ON);
        try
        {
            db.executeQuery("SELECT city,category,html,name,address,zip,tel,email,url,intr,business,info,content FROM company WHERE id=" + db.cite(id));
            if(db.next())
            {
                city = db.getInt(1);
                category = db.getString(2);
                html = db.getText(3);
                name = db.getString(4);
                address = db.getString(5);
                zip = db.getString(6);
                email = db.getString(7);
                url = db.getString(8);
                intr = db.getString(9);
                business = db.getString(10);
                info = db.getString(11);
                content = db.getString(12);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter(Locoso.ON);
        try
        {
            db.executeQuery("SELECT COUNT(id) FROM company WHERE 1=1" + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(Locoso.ON);
        try
        {
            db.executeQuery("SELECT id,city,category,html,name,address,zip,tel,email,url,intr,business,info,content,map FROM company WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                String id = db.getString(1);
                int city = db.getInt(2);
                String category = db.getString(3);
                String html = db.getString(4);
                String name = db.getString(5);
                String address = db.getString(6);
                String zip = db.getString(7);
                String tel = db.getString(8);
                String email = db.getString(9);
                String url = db.getString(10);
                String intr = db.getString(11);
                String business = db.getString(12);
                String info = db.getString(13);
                String content = db.getString(14);
                String map = db.getString(15);
                Company obj = new Company(id,city,category,html,name,address,zip,tel,email,url,intr,business,info,content,map);
                v.add(obj);
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static void create(String id,int city,String category,String html) throws SQLException
    {
        DbAdapter db = new DbAdapter(Locoso.ON);
        try
        {
            db.executeUpdate("INSERT INTO company(id,city,category,html)VALUES(" + db.cite(id) + "," + city + "," + db.cite(category) + "," + db.cite(html) + ")");
        } finally
        {
            db.close();
        }
    }

    public static void create(String id,int city,String category,String name,String address,String zip,String tel,String email,String url,String intr,String business,String info,String content,String map) throws SQLException
    {
        DbAdapter db = new DbAdapter(Locoso.ON);
        try
        {
            db.executeUpdate("INSERT INTO company(id,city,category, name,  address,  zip,  tel,  email,  url,  intr,  business,  info,  content, map)VALUES(" +
                             db.cite(id) + "," + city + "," + db.cite(category) + "," + db.cite(name) + "," + db.cite(address) + "," + db.cite(zip) + "," + db.cite(tel) + "," + db.cite(email) + "," + db.cite(url) + "," + db.cite(intr) + "," + db.cite(business) + "," + db.cite(info) + "," + db.cite(content) + "," + db.cite(map) + ")");
        } finally
        {
            db.close();
        }
    }

    public void setTel(String tel) throws SQLException
    {
        DbAdapter db = new DbAdapter(Locoso.ON);
        try
        {
            db.executeUpdate("UPDATE company SET tel=" + db.cite(tel) + " WHERE id=" + db.cite(id));
        } finally
        {
            db.close();
        }
        this.tel = tel;
    }

    public void set(String name,String address,String zip,String tel,String email,String url,String intr,String business,String info,String content) throws SQLException
    {
        DbAdapter db = new DbAdapter(Locoso.ON);
        try
        {
            db.executeUpdate("UPDATE company SET name=" + db.cite(name) + ",address=" + db.cite(address) + ",zip=" + db.cite(zip) + ",tel=" + db.cite(tel) + ",email=" + db.cite(email) + ",url=" + db.cite(url) + ",intr=" + db.cite(intr) + ",business=" + db.cite(business) + ",info=" + db.cite(info) + ",content=" + db.cite(content) + " WHERE id=" + db.cite(id));
        } finally
        {
            db.close();
        }
        this.name = name;
        this.address = address;
        this.zip = zip;
        this.tel = tel;
        this.email = email;
        this.url = url;
        this.intr = intr;
        this.business = business;
        this.info = info;
        this.content = content;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM company WHERE id=" + db.cite(id));
        } finally
        {
            db.close();
        }
    }

    public String getZip()
    {
        return zip;
    }

    public String getUrl()
    {
        return url;
    }

    public String getTel()
    {
        return tel;
    }

    public String getName()
    {
        return name;
    }

    public String getIntr()
    {
        return intr;
    }

    public String getInfo()
    {
        return info;
    }

    public String getId()
    {
        return id;
    }

    public String getHtml()
    {
        return html;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getEmail()
    {
        return email;
    }

    public String getContent()
    {
        return content;
    }

    public int getCity()
    {
        return city;
    }

    public String getCategory()
    {
        return category;
    }

    public String getBusiness()
    {
        return business;
    }

    public String getAddress()
    {
        return address;
    }

    public String getMap()
    {
        return map;
    }

}
