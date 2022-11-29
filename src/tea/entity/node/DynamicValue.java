package tea.entity.node;

import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.html.*;
import tea.resource.*;
import tea.entity.site.*;
import java.util.*;
import java.text.*;
import java.sql.SQLException;

public class DynamicValue extends Entity
{
    private static Cache _cache = new Cache(100);
    private int dynamicvalue;
    private int node;
    private int language;
    private int dynamictype;
    private String value;
    private boolean exists;

    private DynamicValue(int node,int language,int dynamictype,String value) throws SQLException
    {
        this.node = node;
        this.language = language;
        this.dynamictype = dynamictype;
        this.value = value;
        this.exists = true;
    }

    public DynamicValue(int node,int language,int dynamictype) throws SQLException
    {
        this.node = node;
        this.dynamictype = dynamictype;
        this.language = language;
        load();
    }

    public static DynamicValue find(int node,int language,int dynamictype) throws SQLException
    {
        DynamicValue obj = (DynamicValue) _cache.get(node + ":" + language + ":" + dynamictype);
        if(obj == null)
        {
            obj = new DynamicValue(node,language,dynamictype);
            _cache.put(node + ":" + language + ":" + dynamictype,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        int j = this.getLanguage(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT value FROM DynamicValue WHERE dynamictype=" + dynamictype + " AND node=" + node + " AND language=" + j);
            if(db.next())
            {
                value = db.getText(j,language,1);
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

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM DynamicValue WHERE node=" + node + " AND dynamictype=" + dynamictype);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public void set(String value) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE DynamicValue SET value=" + DbAdapter.cite(value) + " WHERE node=" + node + " AND dynamictype=" + dynamictype + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO DynamicValue (dynamictype, node, language, value)VALUES(" + dynamictype + ", " + node + ", " + language + ", " + DbAdapter.cite(value) + ")");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language + ":" + dynamictype);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM DynamicValue WHERE node=" + node + " AND dynamictype=" + dynamictype + " AND language=" + language);
        _cache.remove(node + ":" + language + ":" + dynamictype);
    }

    public void clone(int newnode) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO DynamicValue (dynamictype, node, language, value)VALUES(" + dynamictype + ", " + newnode + ", " + language + ", " + DbAdapter.cite(value) + ")");
        } finally
        {
            db.close();
        }
    }

    //chenjian
    public static int buffer(int node) throws SQLException
    {
        int k = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            k = db.getInt("SELECT DISTINCT n.node FROM Node n,NodeLayer nl WHERE n.hidden=0 AND n.type>=1024 AND n.node=nl.node AND n.node IN (SELECT dv.node FROM DynamicType dt,DynamicValue dv WHERE dv.dynamictype=dt.dynamictype AND dt.type='code' AND (dv.value IS NULL OR DATALENGTH(dv.value)<1)) and n.node=" + node);
        } finally
        {
            db.close();
        }
        return k;
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public int getDynamictype()
    {
        return dynamictype;
    }

    public String getValue()
    {
        return value;
    }

    public Date getTime()
    {
        try
        {
            return sdf.parse(value);
        } catch(ParseException ex)
        {
            return null;
        }
    }

    public int getDynamicvalue()
    {
        return dynamicvalue;
    }

    public boolean isExists()
    {
        return exists;
    }

    public static String getDetail(Node node,Http h,int listing,String target,Resource r) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        String subject = node.getSubject(h.language);

        Span span = null;
        ListingDetail detail = ListingDetail.find(listing,node.getType(),h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String itemname = (String) e.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            Anchor anchor;
            if(itemname.equals("getSubject"))
            {
                value = (subject);
            } else if(itemname.equals("getTime"))
            {
                value = (node.getTimeToString());
            } else if(itemname.equals("getText"))
            {
                if(detail.getQuantity(itemname) == 0)
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
            } else
            {
                int dt = 0;
                try
                {
                    dt = Integer.parseInt(itemname);
                } catch(NumberFormatException ex)
                {
                    continue;
                }
                DynamicType dt_obj = DynamicType.find(dt);
                if(!dt_obj.isExists())
                {
                    continue;
                }
                DynamicValue obj = DynamicValue.find(node._nNode,h.language,dt);
                if(("file".equals(dt_obj.getType()) || "img".equals(dt_obj.getType())) && obj.getValue() != null && obj.getValue().length() > 0)
                {
                    value = ("<img src='" + obj.getValue() + "' onerror=\"this.style.display='none';document.getElementById('BUT" + dt + "').style.display=''; \" /><input id='BUT" + dt + "' type='button' style=\"display:none\" value=\"下载附件\" onclick=\"window.open('" + obj.getValue() + "');\" />");
                } else
                {
                    value = (obj.getValue());
                }
            }
            if(istype == 2 && (value == null || value.length() < 1))
            {
                continue;
            }
            int dq = detail.getQuantity(itemname);
            if(dq > 0 && value != null && value.length() > dq)
            {
                value = value.substring(0,dq) + "...";
            }
            if(detail.getAnchor(itemname) != 0)
            {
                anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/node/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("DynamicID" + itemname);
            sb.append(detail.getBeforeItem(itemname)).append(span).append(detail.getAfterItem(itemname));
        }
        return sb.toString();
    }


    public static Enumeration findByCommunity(String community) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node FROM Node n WHERE n.hidden=0 AND n.type>=1024 AND n.community=" + DbAdapter.cite(community));
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

    public static Enumeration find(String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,language,dynamictype,value FROM DynamicValue WHERE 1=1" + sql);
            while(db.next())
            {
                int node = db.getInt(1);
                int language = db.getInt(2);
                int dt = db.getInt(3);
                String value = db.getString(4);
                v.addElement(new DynamicValue(node,language,dt,value));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByNode(int node) throws SQLException
    {
        return find(" AND node=" + node);
    }

    public static Enumeration findBy(String sql) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM DynamicValue WHERE 1=1 " + sql);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    //////////////////////////////////
    public ArrayList findMulti(String sql) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT seqid,member,value FROM DynamicValueMulti WHERE dynamictype=" + dynamictype + " AND node=" + node + " AND language=" + language + sql);
            while(db.next())
            {
                int id = db.getInt(1);
                String member = db.getString(2);
                String value = db.getString(3);
                al.add(new Multi(id,member,value));
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public Enumeration findMulti(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT seqid,member,value FROM DynamicValueMulti WHERE dynamictype=" + dynamictype + " AND node=" + node + " AND language=" + language + sql,pos,size);
            while(db.next())
            {
                int id = db.getInt(1);
                String member = db.getString(2);
                String value = db.getString(3);
                v.addElement(new Multi(id,member,value));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

//  public void addMulti(String member, String value) throws SQLException
//  {
//    DbAdapter db = new DbAdapter();
//    try
//    {
//      int seqid = 1 + db.getInt("SELECT MAX(seqid) FROM DynamicValueMulti WHERE dynamictype=" + dynamictype + " AND node=" + node + " AND language=" + language);
//      db.executeUpdate("INSERT INTO DynamicValueMulti(dynamictype,node,language,seqid,member,value)VALUES(" + dynamictype + ", " + node + ", " + language + ", " + seqid + "," + DbAdapter.cite(member) + ", " + DbAdapter.cite(value) + ")");
//    } finally
//    {
//      db.close();
//    }
//  }

    //seqid: 0:创建,-1:按member修改,>0:按seqid修改
    public void setMulti(int seqid,String member,String value) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            if(seqid != 0)
            {
                j = db.executeUpdate("UPDATE DynamicValueMulti SET value=" + DbAdapter.cite(value) + " WHERE dynamictype=" + dynamictype + " AND node=" + node + " AND language=" + language + " AND " + (seqid == -1 ? "member=" + DbAdapter.cite(member) : "seqid=" + seqid));
            }
            if(j < 1)
            {
                if(seqid < 1)
                {
                    seqid = 1 + db.getInt("SELECT MAX(seqid) FROM DynamicValueMulti WHERE dynamictype=" + dynamictype + " AND node=" + node + " AND language=" + language);
                }
                db.executeUpdate("INSERT INTO DynamicValueMulti(dynamictype,node,language,seqid,member,value)VALUES(" + dynamictype + ", " + node + ", " + language + ", " + seqid + "," + DbAdapter.cite(member) + ", " + DbAdapter.cite(value) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public void delMulti(int seqid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM DynamicValueMulti WHERE dynamictype=" + dynamictype + " AND node=" + node + " AND language=" + language + " AND seqid=" + seqid);
            db.executeUpdate("UPDATE DynamicValueMulti SET seqid=seqid-1 WHERE dynamictype=" + dynamictype + " AND node=" + node + " AND language=" + language + " AND seqid>" + seqid);
        } finally
        {
            db.close();
        }
    }

    public class Multi
    {
        int seqid;
        String member;
        String value;
        boolean exists;
        Multi(int seqid,String member,String value)
        {
            this.seqid = seqid;
            this.member = member;
            this.value = value;
            this.exists = true;
        }

        Multi(int seqid) throws SQLException
        {
            this.seqid = seqid;
            load();
        }

        private void load() throws SQLException
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT member,value FROM DynamicValueMulti WHERE dynamictype=" + dynamictype + " AND node=" + node + " AND language=" + language + " AND seqid=" + seqid);
                if(db.next())
                {
                    member = db.getString(1);
                    value = db.getString(2);
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

        public int getSeqID()
        {
            return seqid;
        }

        public String getValue()
        {
            return value;
        }

        public String getMember()
        {
            return member;
        }
    }
}
