package tea.entity.member;

import java.net.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.site.*;
import tea.entity.node.*;
import java.sql.SQLException;
import java.io.IOException;

public class Subscibe extends Entity
{
    private static Cache _cache = new Cache(100);
    private String community;
    private String email;
    private Date times;
    private String node;
    private boolean exists;

    public Subscibe(String community,String email) throws SQLException
    {
        this.community = community;
        this.email = email;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT times,node FROM Subscibe WHERE community=" + DbAdapter.cite(community) + " AND email=" + DbAdapter.cite(email));
            if(db.next())
            {
                times = db.getDate(1);
                node = db.getString(2);
                exists = true;
            } else
            {
                node = "/";
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE  FROM Subscibe  WHERE community=" + DbAdapter.cite(community) + " AND email=" + DbAdapter.cite(email));
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + email);
    }

    public static void create(String community,String email,String node) throws SQLException
    {
        if(email.indexOf("@") == -1)
        {
            return;
        }
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("INSERT INTO Subscibe(community,email,times,node)VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(email) + "," + db.citeCurTime() + "," + DbAdapter.cite(node) + ")");
            if(j < 1)
            {
                db.executeUpdate("UPDATE Subscibe SET node=" + DbAdapter.cite(node) + " WHERE community=" + DbAdapter.cite(community) + " AND email=" + DbAdapter.cite(email));
            }
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + email);
    }

    public static int countByCommunity(String community) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(email) FROM Subscibe WHERE community=" + DbAdapter.cite(community) + " AND " + db.length("node") + ">1");
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

    public static int countByCommunity(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(email) FROM Subscibe WHERE community=" + DbAdapter.cite(community) + sql + " AND " + db.length("node") + ">1");
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

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT email FROM Subscibe WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                al.add(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public static Enumeration findByCommunity(String community,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT email FROM Subscibe WHERE community=" + DbAdapter.cite(community) + " AND " + db.length("node") + ">1",pos,size);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT email FROM Subscibe WHERE community=" + DbAdapter.cite(community) + sql + " AND " + db.length("node") + ">1",pos,size);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByNode(int node) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT email FROM Subscibe WHERE node LIKE " + DbAdapter.cite("%/" + node + "/%"));
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

//    public static Enumeration findByColumns(String community) throws SQLException
//    {
//        Vector v = new Vector();
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            db.executeQuery("SELECT n.node FROM Node n INNER JOIN Category c ON n.node=c.node WHERE c.category=39 AND n.community=" + db.cite(community));
//            while(db.next())
//            {
//                v.addElement(db.getInt(1));
//            }
//        } finally
//        {
//            db.close();
//        }
//        return v.elements();
//    }

    public static Subscibe find(String community,String email) throws SQLException
    {
        Subscibe obj = (Subscibe) _cache.get(community + ":" + email);
        if(obj == null)
        {
            obj = new Subscibe(community,email);
            _cache.put(community + ":" + email,obj);
        }
        return obj;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getEmail()
    {
        return email;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getNode()
    {
        return node;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getTimesToString()
    {
        if(times == null)
        {
            return "";
        }
        return sdf2.format(times);
    }

    public static void html(String community,Date time,int lang) throws SQLException,IOException
    {
        Community c = Community.find(community);
        Enumeration e = DNS.findByCommunity(community,0);
        String sn = "http://" + (e.hasMoreElements() ? (String) e.nextElement() : InetAddress.getLocalHost().getHostAddress()); //域名
        String sitename = c.getName(lang);
        Enumeration enumer = Subscibe.findByCommunity(community,0,Integer.MAX_VALUE);
        for(int p = 0;enumer.hasMoreElements();p++)
        {
            String email = (String) enumer.nextElement();

            Subscibe obj = Subscibe.find(community,email);
            String fathers[] = obj.getNode().split("/");
            boolean flag = false;
            StringBuffer sb = new StringBuffer();
            sb.append("<base href='").append(sn).append("?auto" + Node.sdf3.format(time) + "' />");
            sb.append(email).append("您好，感谢您的关注，你订阅<a target='_blank' href='" + sn + "'>").append(sitename).append("</a>网站的栏目，有如下更新，请您点击查看。<br>");
            sb.append("<table>");
            for(int i = 1;i < fathers.length;i++)
            {
                e = Node.find(" AND father=" + fathers[i] + " AND hidden=0 AND time>" + DbAdapter.cite(time) + " ORDER BY node DESC",0,50);
                if(e.hasMoreElements())
                {
                    flag = true;
                    int id = Integer.parseInt(fathers[i]);
                    Node n = Node.find(id);
                    sb.append("<tr><td>&nbsp;</td></tr>");
                    sb.append("<tr><th align='left'>").append(n.getSubject(lang)).append("</th></tr>");
                    while(e.hasMoreElements())
                    {
                        id = ((Integer) e.nextElement()).intValue();
                        n = Node.find(id);
                        Report r = Report.find(id);
                        int mid = r.getMedia();
                        String author = mid > 0 ? Media.find(mid).getName(lang) : r.getAuthor(lang);
                        String content = n.getText(lang);
                        content = content.replaceAll("<[^>]+>","").replaceAll("&nbsp;","");
                        if(content.length() > 100)
                        {
                            content = content.substring(0,100) + "...";
                        }
                        sb.append("<tr style='line-height:5px'><td>&nbsp;</td></tr>");
                        sb.append("<tr><td><a target='_blank' href='" + sn + "/html/"+community+"/report/" + id + "-" + lang + ".htm'>").append(n.getSubject(lang)).append("</a></td></tr>");
                        sb.append("<tr><td style='color:#666666'>").append(author).append(" - ").append(r.getIssueTimeToString()).append("</td></tr>");
                        sb.append("<tr><td>").append(content).append("</td></tr>");
                    }
                }
            }
            sb.append("</table>");
            if(flag)
            {
                long v = obj.getTimes().getTime() * email.length();
                sb.append("<br><br>如果您以后不想收到此邮件，请点击<a href='" + sn + "/servlet/Subscibes?community=" + community + "&email=" + email + "&v=" + v + "&act=cancel'>退订</a>。");
                sb.append(" <a href='" + sn + "/jsp/subscibe/EditSubscibe.jsp?community=" + community + "&email=" + email + "&v=" + v + "&nexturl=" + java.net.URLEncoder.encode("/jsp/info/Succeed.jsp?nexturl=/","UTF-8") + "'>管理</a>订阅的栏目。");
                sb.append(" 需要更多服务，请访问<a href='" + sn + "'>" + sitename + "</a>网站。");

                System.out.println("发送订阅:" + email);
                Email.create(community,null,email,"订阅:" + sitename,sb.toString());
            }
        }
    }


    public static void robot()
    {
        Calendar c = Calendar.getInstance();
        long hour = (24 - c.get(Calendar.HOUR_OF_DAY)) * 3600000L;
        Timer timer = new Timer();
        timer.schedule(new TimerTask()
        {
            public void run()
            {
                System.out.println("开始发送订阅...");
                long lo = System.currentTimeMillis();
                try
                {
					Iterator e = Community.find("",0,Integer.MAX_VALUE).iterator();
					while(e.hasNext())
					{
						Community cc=(Community)e.next();
						String community = cc.community;
                        CommunityOption co = CommunityOption.find(community);
                        int subday = co.getInt("subday");
                        Date sublast = co.getDate("sublast");
                        if(subday < 1 || sublast == null)
                        {
                            continue;
                        }
                        System.out.println("282:" + community + " 当前时间:" + Node.sdf3.format(new Date(lo)) + " " + lo + "-" + sublast.getTime() + "=" + (lo - sublast.getTime()));
                        if(subday <= (lo - sublast.getTime()) / 86400000)
                        {
                            html(community,sublast,1);
                            co.set("sublast",new Date(lo));
                        }
                    }
                } catch(Exception ex)
                {
                    ex.printStackTrace();
                }
                System.out.println("发送完成\t时:" + (System.currentTimeMillis() - lo));
            }
        },hour,86400000L);
    }


}
