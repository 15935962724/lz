package tea.entity.site;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import java.awt.*;
import java.awt.image.*;
import javax.imageio.*;

public class Site
{
    protected static Cache c = new Cache(50);
    public int site;
    public String[] name = new String[2]; //名称
    public String[] summary = new String[2]; //简介
    public String domain; //域名
    public String term; //服务条款
    public String[] header = new String[2]; //页眉
    public String[] footer = new String[2]; //页脚
    //邮件
    public String mailserver; //邮件服务器
    public String mailuser; //邮件用户名
    public String mailpassword; //邮件密码
    public String[] register = new String[2]; //注册邮件
    //短信
    public static final String[] SMS_SERVICE =
            {"禁用","触发短信"};
    public int smsserver; //接口类型
    public String smsuser; //短信用户名
    public String smspassword; //短信密码
    public boolean smsremind; //短信提醒
    public int smscount; //已发条数
    //
    public String member; //会员表
    //public static String[] WPOSITION_TYPE ={"无", "右上", "中间", "右下", "平铺"};
    public int wposition; //水印位置
    public String wlogo; //水印
    public String[] homepage = new String[2]; //首页

    public Site(int site)
    {
        this.site = site;
        Arrays.fill(homepage,"/");
    }

    public static Site find(int site) throws SQLException
    {
        if(site == 0)
            return new Site(site);
        Site t = (Site) c.get(site);
        if(t == null)
        {
            ArrayList al = find(" AND site=" + site,0,1);
            t = al.size() < 1 ? new Site(site) : (Site) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT site,name0,name1,summary0,summary1,domain,term,header0,header1,footer0,footer1,mailserver,mailuser,mailpassword,register0,register1,smsserver,smsuser,smspassword,smsremind,smscount,member,wposition,wlogo,homepage0,homepage1 FROM site WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Site t = new Site(rs.getInt(i++));
                t.name[0] = rs.getString(i++);
                t.name[1] = rs.getString(i++);
                t.summary[0] = rs.getString(i++);
                t.summary[1] = rs.getString(i++);
                t.domain = rs.getString(i++);
                t.term = rs.getString(i++);
                t.header[0] = rs.getString(i++);
                t.header[1] = rs.getString(i++);
                t.footer[0] = rs.getString(i++);
                t.footer[1] = rs.getString(i++);
                t.mailserver = rs.getString(i++);
                t.mailuser = rs.getString(i++);
                t.mailpassword = rs.getString(i++);
                t.register[0] = rs.getString(i++);
                t.register[1] = rs.getString(i++);
                //
                t.smsserver = rs.getInt(i++);
                t.smsuser = rs.getString(i++);
                t.smspassword = rs.getString(i++);
                t.smsremind = rs.getBoolean(i++);
                t.smscount = rs.getInt(i++);
                //
                t.member = rs.getString(i++);
                t.wposition = rs.getInt(i++);
                t.wlogo = rs.getString(i++);
                t.homepage[0] = rs.getString(i++);
                t.homepage[1] = rs.getString(i++);
                c.put(t.site,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM site WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(site < 1)
                db.executeUpdate("INSERT INTO site(name0,name1,summary0,summary1,domain,term,header0,header1,footer0,footer1,mailserver,mailuser,mailpassword,register0,register1,smsserver,smsuser,smspassword,smsremind,smscount,member,wposition,wlogo,homepage0,homepage1)VALUES(" + DbAdapter.cite(name[0]) + "," + DbAdapter.cite(name[1]) + "," + DbAdapter.cite(summary[0]) + "," + DbAdapter.cite(summary[1]) + "," + DbAdapter.cite(domain) + "," + DbAdapter.cite(term) + "," + DbAdapter.cite(header[0]) + "," + DbAdapter.cite(header[1]) + "," + DbAdapter.cite(footer[0]) + "," + DbAdapter.cite(footer[1]) + "," + DbAdapter.cite(mailserver) + "," + DbAdapter.cite(mailuser) + "," + DbAdapter.cite(mailpassword) + "," + DbAdapter.cite(register[0]) + "," + DbAdapter.cite(register[1])
                                 + "," + smsserver + "," + DbAdapter.cite(smsuser) + "," + DbAdapter.cite(smspassword)+ "," + DbAdapter.cite(smsremind) + "," + smscount
                                 + "," + DbAdapter.cite(member) + "," + wposition + "," + DbAdapter.cite(wlogo) + "," +
                                 DbAdapter.cite(homepage[0]) + "," + DbAdapter.cite(homepage[1]) + ")");
            else
                db.executeUpdate("UPDATE site SET name0=" + DbAdapter.cite(name[0]) + ",name1=" + DbAdapter.cite(name[1]) + ",summary0=" + DbAdapter.cite(summary[0]) + ",summary1=" + DbAdapter.cite(summary[1]) + ",domain=" + DbAdapter.cite(domain) + ",term=" + DbAdapter.cite(term) + ",header0=" + DbAdapter.cite(header[0]) + ",header1=" + DbAdapter.cite(header[1]) + ",footer0=" + DbAdapter.cite(footer[0]) + ",footer1=" + DbAdapter.cite(footer[1])
                                 //
                                 + ",mailserver=" + DbAdapter.cite(mailserver) + ",mailuser=" + DbAdapter.cite(mailuser) + ",mailpassword=" + DbAdapter.cite(mailpassword) + ",register0=" + DbAdapter.cite(register[0]) + ",register1=" + DbAdapter.cite(register[1])
                                 //
                                 + ",smsserver=" + smsserver + ",smsuser=" + DbAdapter.cite(smsuser) + ",smspassword=" + DbAdapter.cite(smspassword) + ",smsremind=" + DbAdapter.cite(smsremind)+ ",smscount=" + smscount
                                 + ",member=" + DbAdapter.cite(member) + ",wposition=" + wposition + ",wlogo=" + DbAdapter.cite(wlogo) + ",homepage0=" + DbAdapter.cite(homepage[0]) + ",homepage1=" + DbAdapter.cite(homepage[1]) + " WHERE site=" + site);
        } finally
        {
            db.close();
        }
        c.remove(site);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM site WHERE site=" + site);
        c.remove(site);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE site SET " + f + "=" + DbAdapter.cite(v) + " WHERE site=" + site);
        c.remove(site);
    }

    //
    public void mark(File f)
    {
        if(wposition < 1)
            return;
        try
        {
            BufferedImage bi = ImageIO.read(f);
            int w = bi.getWidth(),h = bi.getHeight();
            if(w < 200 || h < 200)
                return;
            InputStream is = Class.forName("tea.db.DbAdapter").getResourceAsStream("/../../" + wlogo);
            BufferedImage bil = ImageIO.read(is);
            is.close();

            int wl = bil.getWidth(),hl = bil.getHeight();

            Graphics2D g = bi.createGraphics();
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP,0.5F));
            switch(wposition)
            {
            case 1:
                g.drawImage(bil,w - 20 - wl,20,null);
                break;
            case 2:
                g.drawImage(bil,w / 2 - wl / 2,h / 2 - hl / 2,null);
                break;
            case 3:
                g.drawImage(bil,w - 20 - wl,h - 20 - hl,null);
                break;
            }
            g.dispose();
            ImageIO.write(bi,"PNG",f);
            //
            Img img = new Img(f);
            img.quality = 95;
            img.start(f);
        } catch(Exception ex)
        {
            ex.printStackTrace();
            System.out.println("添加水印错误:" + ex.getMessage() + "\t" + f.getPath());
        }
    }

}
