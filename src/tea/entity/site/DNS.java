package tea.entity.site;

import java.io.*;
import java.net.*;
import java.sql.SQLException;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.node.access.*;

public class DNS extends Entity
{
    private static Cache _cache = new Cache(100);
    private String domainname;
    private String community;
    private int status;
    private int node;
    private String url;
    public String gkey; //google 地图KEY
    private boolean main;
    private Date time;
    private boolean exists;
    protected boolean cityExists;

    public DNS(String domainname) throws SQLException
    {
        this.domainname = domainname;
        load();
    }

    public synchronized static DNS find(String domainname) throws SQLException
    {
        DNS obj = (DNS) _cache.get(domainname);
        if(obj == null)
        {
            obj = new DNS(domainname);
            _cache.put(domainname,obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate(0,"DELETE FROM DNS WHERE domainname=" + DbAdapter.cite(domainname));
        } finally
        {
            db.close();
        }
        _cache.remove(domainname);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT community,status,url,node,main,gkey,time FROM DNS WHERE domainname=" + DbAdapter.cite(domainname));
            if(db.next())
            {
                community = db.getString(1);
                status = db.getInt(2);
                url = db.getString(3);
                node = db.getInt(4);
                main = db.getInt(5) != 0;
                gkey = db.getString(6);
                time = db.getDate(7);
                exists = true;
                db.executeQuery("SELECT domainname FROM DNSCity WHERE domainname=" + DbAdapter.cite(domainname));
                cityExists = db.next();
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
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM DNS WHERE 1=1" + sql);
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
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT domainname FROM DNS WHERE 1=1" + sql,pos,size);
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

    public static Enumeration findByCommunity(String community,int status) throws SQLException
    {
        return find(" AND domainname!='%' AND community=" + DbAdapter.cite(community) + " AND status=" + status + " ORDER BY main DESC",0,200);
    }

    public static boolean isDN(String dn,String community) throws SQLException
    {
        if("127.0.0.1".equals(dn) || "localhost".equals(dn) || dn.startsWith("192.168.") || dn.startsWith("127."))
        {
            return true;
        }
        DNS dns = DNS.find(dn);
        if(!dns.isExists())
        { // 泛域名
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeQuery("SELECT community,node FROM DNS WHERE " + DbAdapter.cite(dn) + " LIKE domainname");
                return(db.next());
            } finally
            {
                db.close();
            }
        }
        if(!community.equals(dns.getCommunity()))
        {
            Community c = Community.find(community);
            Community urlc = Community.find(dns.getCommunity());
            return(c.getType() == 2 && urlc.getType() == 2);
        }
        return true;
    }

    public String getCityUrl(String ip) throws SQLException
    {
        String url = null;
        if(cityExists)
        {
            ip = NodeAccessWhere.findByIp(ip);
            DbAdapter db = new DbAdapter(1);
            try
            {
                db.executeQuery("SELECT d.url FROM DNSCity d INNER JOIN Card c ON d.city=c.card WHERE d.domainname=" + db.cite(domainname) + " AND " + db.cite(ip) + " LIKE " + db.concat("'%'","c.address","'%'"));
                if(db.next())
                {
                    url = db.getString(1);
                }
            } finally
            {
                db.close();
            }
        }
        return url;
    }


    public boolean isOK()
    {
        if("%".equals(domainname))
        {
            return true;
        }
        try
        {
            String local = InetAddress.getLocalHost().getHostAddress();
            InetAddress ias[] = InetAddress.getAllByName(domainname);
            for(int j = 0;j < ias.length;j++)
            {
                if(local.equals(ias[j].getHostAddress()))
                {
                    return true;
                }
            }
        } catch(Exception e)
        {
        }
        return false;
    }

    public void set(String community,int status,String url,int node,boolean main,String gkey) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            int j = db.executeUpdate(0,"UPDATE DNS SET community=" + DbAdapter.cite(community) + ",status=" + status + ",url=" + DbAdapter.cite(url) + ",node=" + node + ",main=" + DbAdapter.cite(main) + ",gkey=" + DbAdapter.cite(gkey) + " WHERE domainname=" + DbAdapter.cite(domainname));
            if(j < 1)
            {
                db.executeUpdate(0,"INSERT INTO DNS(domainname,community,status,url,node,main,gkey,time)VALUES(" + DbAdapter.cite(domainname) + "," + DbAdapter.cite(community) + "," + status + "," + DbAdapter.cite(url) + "," + node + "," + DbAdapter.cite(main) + "," + DbAdapter.cite(gkey) + "," + db.citeCurTime() + ")");
            }
        } finally
        {
            db.close();
        }
        this.community = community;
        this.status = status;
        this.url = url;
        this.node = node;
        this.main = main;
        this.gkey = gkey;
        this.time = time;
        this.exists = true;
        sync(null);
    }

    public String getDomainname()
    {
        return domainname;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getNode()
    {
        return node;
    }

    public boolean isExists()
    {
        return exists;
    }

    public boolean isMain()
    {
        return main;
    }

    public String getUrl()
    {
        return url;
    }

    public Date getTime()
    {
        return time;
    }

    public int getStatus()
    {
        return status;
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }

    //动态DNS相关///////////////////////////////////////////////////
    static String host[] = new String[2];
    public static void start()
    {
        try
        {
            final CommunityOption co = CommunityOption.find("[SYSTEM]");
            host[0] = co.get("ddnshost0");
            host[1] = co.get("ddnshost1");
            if(host[0] != null || host[1] != null)
            {
                Timer timer = new Timer();
                timer.schedule(new TimerTask()
                {
                    String last = null;
                    public void run()
                    {
                        //Date time = co.getDate("ddnstime");
                        //int count = DNS.count(" AND time>" + DbAdapter.cite(time));
                        //if(!ip.equals(last) || count > 0) //如果IP更改 || 新添加了
                        last = sync(last);
                    }
                },5000L,20000L);
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

//	//判断是否接受参数
//	public static void start_url()
//	{
//        try
//        {
//            Timer timer = new Timer();
//            timer.schedule(new TimerTask()
//            {
//                String last = null;
//                public void run()
//                {
//                    try
//                    {
//                        System.out.println("监控启动");
//                        HttpURLConnection conn = (HttpURLConnection)new URL("http://127.0.0.1:80/servlet/Ajax?act=URLReader").openConnection();
//                        System.out.println(conn.getInputStream());
//                        ObjectInputStream ois = new ObjectInputStream(conn.getInputStream());
//
//                        HashMap m = (HashMap) ois.readObject();
//
//                        ois.close();
//
//                    } catch(Exception ex)
//                    {
//                        // TODO Auto-generated catch block
//                        ex.printStackTrace();
//                    }
//                }
//            },0,60 * 100);
//        } catch(Exception ex)
//        {
//            ex.printStackTrace();
//        }
//
//	}

    private static String sync(String ip)
    {
        if(host[0] != null || host[1] != null)
        {
            try
            {
                InetAddress ia = InetAddress.getLocalHost();
                String newip = ia.getHostAddress();
                if(!newip.equals(ip))
                {
                    System.out.println("更改动态DNS");
                    System.out.println("源地址:" + ip + " 新地址:" + newip);
                    ip = newip;
                    for(int i = 0;i < host.length;i++)
                    {
                        try
                        {
                            System.out.println("连接:" + host[i]);
                            HttpURLConnection conn = (HttpURLConnection)new URL("http://" + host[i] + "/servlet/NsUpdate").openConnection();
                            Enumeration e = DNS.find("",0,Integer.MAX_VALUE);
                            while(e.hasMoreElements())
                            {
                                String name = (String) e.nextElement();
                                conn.addRequestProperty("name",name);
                            }
                            InputStream is = conn.getInputStream();
                            boolean rs = '1' == is.read();
                            is.close();
                            System.out.println("结果:" + rs);
                            break;
                        } catch(Exception ex)
                        {
                            ex.printStackTrace();
                        }
                    }
                }
            } catch(UnknownHostException ex)
            {
                ex.printStackTrace();
            }
        }
        return ip;
    }
}
