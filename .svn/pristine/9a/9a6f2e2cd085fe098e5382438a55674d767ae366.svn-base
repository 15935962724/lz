package tea.entity.admin.earth;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.admin.*;
import tea.entity.node.*;
import tea.entity.member.*;
import java.net.*;
import java.io.*;

public class EarthNode extends Entity implements Serializable
{
    public static Cache _cache = new Cache(100);
    private int earthnode;
    private int node;
    private String community;
    private String subject;
    private String content;
    private Date time;
    private int hits;
    private boolean exists;

    public EarthNode(int earthnode) throws SQLException
    {
        this.earthnode = earthnode;
        load();
    }

    public static EarthNode find(int earthnode) throws SQLException
    {
        EarthNode obj = (EarthNode) _cache.get(new Integer(earthnode));
        if(obj == null)
        {
            obj = new EarthNode(earthnode);
            _cache.put(new Integer(earthnode),obj);
        }
        return obj;
    }

    public void set(String subject,String content,Date time,int hits) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("UPDATE earthnode SET subject=" + DbAdapter.cite(subject) + ",content=" + DbAdapter.cite(content) + ",time=" + DbAdapter.cite(time) + ",hits=" + hits + " WHERE earthnode=" + earthnode);
        } finally
        {
            db.close();
        }
        this.subject = subject;
        this.content = content;
        this.time = time;
        this.hits = hits;
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT node,community,subject,content,time,hits FROM earthnode WHERE earthnode=" + earthnode);
            if(db.next())
            {
                node = db.getInt(1);
                community = db.getString(2);
                subject = db.getString(3);
                content = db.getString(4);
                time = db.getDate(5);
                hits = db.getInt(6);
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
        int count = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM earthnode WHERE 1=1" + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT earthnode FROM earthnode WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int findByNode(int node,String community) throws SQLException
    {
        int earthnode = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT earthnode FROM earthnode WHERE node=" + node + " AND community=" + DbAdapter.cite(community));
            if(db.next())
            {
                earthnode = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return earthnode;
    }

    public static void create(int node,String community,String subject,String content,Date time,int hits) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("INSERT INTO earthnode(node,community,subject,content,time,hits)VALUES(" +
                             node + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(content) + "," + DbAdapter.cite(time) + "," + hits + ")");
        } finally
        {
            db.close();
        }
        //_cache.remove(new Integer(earthnode));
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("DELETE FROM earthnode WHERE earthnode=" + earthnode);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(earthnode));
    }

    public boolean isExists()
    {
        return exists;
    }

    public Date getTime()
    {
        return time;
    }

    public String getTimeToString()
    {
        return Entity.sdf.format(time);
    }

    public int getNode()
    {
        return node;
    }

    public int getHits()
    {
        return hits;
    }

    public int getEarthNode()
    {
        return earthnode;
    }

    public String getContent()
    {
        return content;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getSubject()
    {
        return subject;
    }

    //
    public static void sync()
    {
        try
        {
            final CommunityOption co = CommunityOption.find("[SYSTEM]");
            final String host = co.get("synchost");
            if(host != null)
            {
                final String sn = License.getInstance().getSerialNumber();
                final int port = co.getInt("syncport");
                int period = co.getInt("syncperiod");
                Timer timer = new Timer();
                timer.schedule(new TimerTask()
                {
                    public void run()
                    {
                        try
                        {
                            Date synctime = co.getDate("synctime");
                            String sql = " AND hidden=0 AND (updatetime>" + DbAdapter.cite(synctime) + " OR EXISTS(SELECT s.node FROM Supply s WHERE n.node=s.node AND s.audittime>" + DbAdapter.cite(synctime) + ") )";
                            int count = Node.count(sql);
                            if(count > 0)
                            {
                                System.out.println("Sync: 新加:" + count);
                                String synctype = co.get("synctype");
                                //if (synctype == null)
                                {
                                    StringBuilder sb = new StringBuilder();
                                    InputStream is = new URL("http://" + host + ":" + port + "/servlet/Syncs").openStream();
                                    int v;
                                    while((v = is.read()) != -1)
                                    {
                                        sb.append((char) v);
                                    }
                                    is.close();
                                    synctype = sb.toString();
                                    co.set("synctype",synctype);
                                }
                                synctype = synctype.substring(1,synctype.length() - 1).replace('/',',');
                                //
                                int lang = 1;
                                HashMap m = new HashMap();
                                //添加/编辑///////////////////////
                                Enumeration e = Node.find(sql + " AND type IN(" + synctype + ")",0,Integer.MAX_VALUE);
                                if(e.hasMoreElements())
                                {
                                    ArrayList al = new ArrayList();
                                    while(e.hasMoreElements())
                                    {
                                        int node = ((Integer) e.nextElement()).intValue();
                                        Node n = Node.find(node);
                                        String domain = "";
                                        Enumeration ed = DNS.findByCommunity(n.getCommunity(),1);
                                        if(ed.hasMoreElements())
                                        {
                                            domain = "http://" + (String) ed.nextElement();
                                        }
                                        int type = n.getType();
                                        HashMap d = new HashMap();
                                        d.put("domain",domain);
                                        d.put("syncid",sn + "." + node);
                                        d.put("father",new Integer(n.getFather()));
                                        d.put("time",n.getTime());
                                        d.put("creator",n.getCreator().toString());
                                        d.put("updatetime",n.getUpdatetime());
                                        d.put("type",new Integer(n.getType()));
                                        d.put("subject",n.getSubject(lang));
                                        d.put("content",n.getText(lang));
                                        switch(type)
                                        {
                                        case 21: //企业
                                            Company c = Company.find(node);
                                            d.put("contact",c.getContact(lang));
                                            d.put("email",c.getEmail(lang));
                                            d.put("organization",c.getOrganization(lang));
                                            d.put("address",c.getAddress(lang));
                                            d.put("city",new Integer(c.getCity(lang)));
                                            d.put("state",c.getState(lang));
                                            d.put("zip",c.getZip(lang));
                                            d.put("country",c.getCountry(lang));
                                            d.put("telephone",c.getTelephone(lang));
                                            d.put("fax",c.getFax(lang));
                                            d.put("webpage",c.getWebPage(lang));
                                            d.put("map",c.getMap(lang));
                                            d.put("eyp",c.getEyp(lang));
                                            break;
                                        case 32: //供求
                                            Supply s = Supply.find2(n.getCommunity(),node);
                                            d.put("company",new Integer(s.getCompany()));
                                            d.put("newstype",new Integer(s.getNewstype()));
                                            d.put("city",new Integer(s.getCity()));
                                            d.put("city1",new Integer(s.getCity1()));
                                            d.put("industrytype1",new Integer(s.getIndustrytype1()));
                                            d.put("industrytype2",new Integer(s.getIndustrytype2()));
                                            d.put("term",new Integer(s.getTerm()));
                                            d.put("picname",s.getPicname());
                                            d.put("picpath",s.getPicpath());
                                            d.put("website",s.getWebsite());
                                            break;
                                        case 34: //产品
                                            Goods g = Goods.find(node);
                                            d.put("goodstype",g.getGoodstype());
                                            d.put("brand",new Integer(g.getBrand()));
                                            d.put("no",g.getNo());
                                            d.put("measure",g.getMeasure(lang));
                                            d.put("spec",g.getSpec(lang));
                                            d.put("capability",g.getCapability(lang));
                                            d.put("smallpicture",g.getSmallpicture(lang));
                                            d.put("bigpicture",g.getBigpicture(lang));
                                            d.put("commendpicture",g.getCommendpicture(lang));
                                            d.put("company",new Integer(g.getCompany()));
                                            d.put("price",g.getPrice());
                                            break;
                                        case 39: //新闻
                                            Report r = Report.find(node);
                                            d.put("media",new Integer(r.getMedia()));
                                            d.put("classes",new Integer(r.getClasses()));
                                            d.put("issuetime",r.getIssueTime());
                                            d.put("picture",r.getPicture(lang));
                                            d.put("locus",r.getLocus(lang));
                                            d.put("subhead",r.getSubhead(lang));
                                            d.put("author",r.getAuthor(lang));
                                            d.put("logograph",r.getLogograph(lang));
                                            break;
                                        }
                                        al.add(d);
                                    }
                                    m.put("addnode",al);
                                }
                                //删除///////////////////////
                                e = Logs.find(" AND type=3 AND time>" + DbAdapter.cite(synctime) + " AND type IN(" + synctype + ")",0,Integer.MAX_VALUE);
                                if(e.hasMoreElements())
                                {
                                    ArrayList al = new ArrayList();
                                    while(e.hasMoreElements())
                                    {
                                        Logs log = (Logs) e.nextElement();
                                        al.add(sn + "." + log.getOpid());
                                    }
                                    m.put("delnode",al);
                                }
                                if(m.size() > 0)
                                {
                                    HttpURLConnection conn = (HttpURLConnection)new URL("http://" + host + ":" + port + "/servlet/Syncs").openConnection();
                                    conn.setDoOutput(true);
                                    ObjectOutputStream oos = new ObjectOutputStream(conn.getOutputStream());
                                    oos.writeObject(m);
                                    oos.close();
                                    InputStream is = conn.getInputStream();
                                    is.read();
                                    is.close();
                                }
                            }
                            co.set("synctime",new Date());
                        } catch(Exception ex)
                        {
                            ex.printStackTrace();
                        }
                    }
                },1000,period * 3600000L);
            }
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        }
    }
}
