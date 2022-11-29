package tea.entity.node;

import java.sql.*;
import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;

public class Venues extends Entity
{
    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;

    private int node;
    private String address; //地址
    private String linkman; //联系人
    private String contactway; //联系方式
    private String aunit; //所属单位
    private String intropicname; //介绍图片 名称
    private String intropicpath; //介绍图片 路径
    private int seating; //座位数

    private boolean exists;

    public static Venues find(int node) throws SQLException
    {
        Venues obj = (Venues) _cache.get(new Integer(node));
        if(obj == null)
        {
            obj = new Venues(node);
            _cache.put(new Integer(node),obj);
        }
        return obj;
    }

    public Venues(int node) throws SQLException
    {
        this.node = node;
        _htLayer = new Hashtable();
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT address,linkman,contactway,aunit,intropicname,intropicpath,seating FROM Venues WHERE node=" + node);
            if(db.next())
            {
                address = db.getString(1);
                linkman = db.getString(2);
                contactway = db.getString(3);
                aunit = db.getString(4);
                intropicname = db.getString(5);
                intropicpath = db.getString(6);
                seating = db.getInt(7);
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

    public static void create(int node,String address,String linkman,String contactway,String aunit,String intropicname,String intropicpath,int seating) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Venues(node,address,linkman,contactway,aunit,intropicname,intropicpath,"
                             + " seating )VALUES(" + node + "," + db.cite(address) + "," + db.cite(linkman) + "," + db.cite(contactway) + "," + db.cite(aunit) + "," + db.cite(intropicname) + "," + db.cite(intropicpath) + "," + seating + " )");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(node));
    }

    public void set(String address,String linkman,String contactway,String aunit,String intropicname,String intropicpath,int seating) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("UPDATE Venues SET address=" + db.cite(address) + ",linkman=" + db.cite(linkman) + ",contactway=" + db.cite(contactway) + ","
                             + " aunit=" + db.cite(aunit) + ",intropicname=" + db.cite(intropicname) + ",intropicpath=" + db.cite(intropicpath) + ",seating=" + seating + "  WHERE node = " + node);

        } finally
        {
            db.close();
        }
        this.address = address;
        this.linkman = linkman;
        this.contactway = contactway;
        this.aunit = aunit;
        this.intropicname = intropicname;
        this.intropicpath = intropicpath;
        this.seating = seating;
        _htLayer.clear();
    }

    public static Enumeration find(String community,String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Venues WHERE community= " + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  Venues WHERE node = " + node);

        } finally
        {
            db.close();
        }
    }

    public String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        StringBuilder text = new StringBuilder();

        int _nNode = node._nNode;
        String subject = node.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,92,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = "";
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            int dq = detail.getQuantity(name);
            if(name.equals("name")) //场馆名称
            {
                value = subject;
            } else if(name.equals("address")) //地址
            {
                value = this.address;
            } else if(name.equals("text")) //简介
            {
                if(detail.getQuantity(name) == 0)
                {
                    if((node.getOptions() & 0x40L) == 0)
                    {
                        value = (tea.html.Text.toHTML(node.getText2(h.language)));
                    } else
                    {
                        value = (node.getText2(h.language));
                    }
                } else
                {
                    value = (node.getText(h.language));
                }
            } else if(name.equals("linkman"))
            {
                value = this.linkman;
            } else if(name.equals("contactway"))
            {
                value = this.contactway;
            } else if(name.equals("aunit"))
            {
                value = (this.aunit);
            } else if(name.equals("intropic"))
            {
                String p = this.intropicpath;
                if(p != null && p.length() > 0)
                {
                    value = "<img onerror=\"this.style.display='none';\" src=\"" + p + "\" />";
                } else
                {
                    value = "";
                }
            } else if(name.equals("seating"))
            {

                value = String.valueOf(this.seating);
            }
            if(value == null)
            {
                value = "";
            }
            if(istype == 2 && value.length() < 1)
            {
                continue;
            }
            String title = value.replace('"','_');

            //显示连接的地方
            value = detail.getOptionsToHtml(name,node,value);
            if(detail.getAnchor(name) != 0)
            {
                value = "<a href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/venues/" + _nNode + "-" + h.language + ".htm' target='" + target + "' title=\"" + subject + "\">" + value + "</a>";
            }
            text.append(bi).append("<span id='VenuesID" + name + "'>" + value + "</span>").append(ai);
        }
        return text.toString();
    }


    public String getAddress()
    {
        return address;
    }

    public String getAunit()
    {
        return aunit;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getContactway()
    {
        return contactway;
    }

    public String getIntropicname()
    {
        return intropicname;
    }

    public String getIntropicpath()
    {
        return intropicpath;
    }

    public String getLinkman()
    {
        return linkman;
    }

    public int getSeating()
    {
        return seating;
    }
}
