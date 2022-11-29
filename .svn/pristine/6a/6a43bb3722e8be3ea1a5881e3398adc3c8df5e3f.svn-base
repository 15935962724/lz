package tea.entity.node;

import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.html.Anchor;
import tea.html.Span;
import tea.html.Text;
import java.util.*;
import java.util.Date;
import java.util.Vector;
import java.sql.SQLException;

public class Literature
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int language;
    private String subhead;
    private int chapter;
    private int section;
    private int pos;
    private String cname;
    private String author;
    private String flash;
    private String sname;
    private boolean exists;

    public Literature(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        loadBasic();
    }

    public static Literature find(int _nNode,int language) throws SQLException
    {
        Literature node = (Literature) _cache.get(_nNode + ":" + language);
        if(node == null)
        {
            node = new Literature(_nNode,language);
            _cache.put(_nNode + ":" + language,node);
        }
        return node;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            // int j = dbadapter.getInt("NodeGetLanguage " + node + "," + language);
            int j = this.getLanguage(language);
            dbadapter.executeQuery("SELECT subhead,chapter,cname  ,section,sname  ,author ,pos    ,flash   FROM Literature  WHERE node=" + node + " AND language=" + j);
            if(dbadapter.next())
            {
                subhead = dbadapter.getVarchar(j,language,1);
                chapter = dbadapter.getInt(2);
                cname = dbadapter.getVarchar(j,language,3);
                section = dbadapter.getInt(4);
                sname = dbadapter.getVarchar(j,language,5);
                author = dbadapter.getVarchar(j,language,6);
                pos = dbadapter.getInt(7);
                flash = dbadapter.getVarchar(j,language,8);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            dbadapter.close();
        }
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT language FROM AdedLayer WHERE aded=" + node);
            while(dbadapter.next())
            {
                v.addElement(new Integer(dbadapter.getInt(1)));
            }
        } finally
        {
            dbadapter.close();
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

    public void set(String subhead,int chapter,String cname,int section,String sname,String author,int pos,String flash) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            // dbadapter.executeUpdate("LiteratureEdit " + node + "," +
            // language + "," + DbAdapter.cite(subhead) + "," +
            // chapter + "," + DbAdapter.cite(cname) + "," +
            // /section + "," + DbAdapter.cite(sname) + "," +
            // DbAdapter.cite(author) + "," + pos + "," + DbAdapter.cite(flash));
            dbadapter.executeQuery("SELECT node FROM Literature WHERE node=" + node + " AND language=" + language);
            if(dbadapter.next())
            {
                dbadapter.executeUpdate("UPDATE Literature SET subhead=" + DbAdapter.cite(subhead) + ",chapter=" + chapter + ",cname  =" + DbAdapter.cite(cname) + "  ,section=" + section + ",sname  =" + DbAdapter.cite(sname) + "  ,author =" + DbAdapter.cite(author) + " ,pos    =" + pos + "    ,flash  =" + DbAdapter.cite(flash) + "  WHERE node=" + node + " AND language=" + language);
            } else
            {
                dbadapter.executeUpdate("INSERT INTO Literature(node, language, subhead,chapter,cname  ,section,sname  ,author ,pos    ,flash  )VALUES(" + node + ", " + language + ", " + DbAdapter.cite(subhead) + "," + chapter + "," + DbAdapter.cite(cname) + "  ," + section + "," + DbAdapter.cite(sname) + "  ," + DbAdapter.cite(author) + " ," + pos + "    ," + flash + " )");
            }
            _cache.remove(node + ":" + language);
        } finally
        {
            dbadapter.close();
        }
    }

    public static String getDetail(Node node,int currentlynode,Http h,Listing listing,String target,tea.resource.Resource r) throws SQLException
    {
        StringBuilder text = new StringBuilder();
        Literature obj = Literature.find(node._nNode,h.language);
        Class c = obj.getClass();
        Span span = null;

        String subject = node.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing.getListing(),80,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            Anchor anchor = null;
            String itemname = (String) e.next(),value = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            if(itemname.equals("getSubject"))
            {
                value = (subject);
            } else if(itemname.equals("getText2"))
            {
                if((node.getOptions() & 0x40L) == 0)
                {
                    value = (tea.html.Text.toHTML(node.getText2(h.language)));
                } else
                {
                    value = (node.getText2(h.language));
                }
            } else // 分页
            if(itemname.equals("getDivide"))
            { // node
                tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
                try
                {
                    StringBuilder sql = new StringBuilder();
                    // 选取源
                    int ij = 0;
                    Iterator itpf = PickFrom.findByListing(listing.getListing()).iterator();
                    while(itpf.hasNext())
                    {
                        PickFrom pickfrom = (PickFrom) itpf.next();
                        int k = pickfrom.getFromStyle();
                        if(ij > 0)
                        {
                            sql.append(" OR ");
                        }
                        ij++;
                        sql.append(" (");
                        if(k == 0) // ������
                        {
                            sql.append(" n.community=" + DbAdapter.cite(pickfrom.getFromCommunity()));
                        } else if(k == 3) // ����
                        {
                            int k1 = (listing.getOptions() & 0x10) == 0 ? pickfrom.getFromNode() : currentlynode;
                            sql.append(" n.community=" + DbAdapter.cite(pickfrom.getFromCommunity()) + " AND n.path LIKE " + DbAdapter.cite(Node.find(k1).getPath() + "%"));
                        }
                        sql.append(" ) ");
                    }
                    ArrayList al = PickNode.find(" AND listing=" + listing.getListing(),0,200);
                    for(int i = 0;i < al.size();i++)
                    {
                        PickNode picknode = (PickNode) al.get(i);
                        int i2 = picknode.type;
                        if(i2 != 255)
                        {
                            sql.append(" AND n.type=" + i2);
                            //sql.append(" AND n.typealias=" + picknode.getTypeAlias());
                        }
                    }
                    int sum = dbadapter.getInt("SELECT DISTINCT COUNT(n.node) FROM Node n WHERE " + sql.toString());
                    sql.append(" ORDER BY ");
                    switch(listing.getSortType())
                    // ����ʱ��
                    {
                    case 0:
                        sql.append(" n.time ");
                        break;
                    case 1:

                        /*
                         * stringbuffer1.append(" , ViewCounter c "); stringbuffer2.append(" AND n.node=c.node "); stringbuffer.append(" c.counter ");
                         */
                        sql.append(" n.click ");
                        break;
                    case 9:
                        sql.append(" n.sequence ");
                        break;
                    case 10:
                        sql.append(" n.click ");
                        break;
                    case 12:
                        sql.append(" n.path ");
                        break;
                    }
                    dbadapter.executeQuery("SELECT DISTINCT n.node,n.time,n.click,n.sequence,n.path FROM Node n WHERE " + sql.toString());
                    int arr[] = new int[sum];
                    int index = -1;
                    StringBuilder select = new StringBuilder("<SELECT onChange=\"window.open('/servlet/Node?node='+this.value,'_self');\">");
                    for(int i = 0;dbadapter.next();i++)
                    {
                        arr[i] = dbadapter.getInt(1);
                        if(currentlynode == arr[i])
                        {
                            index = i;
                            select.append("<OPTION SELECTED VALUE=" + arr[i] + ">" + (i + 1));
                        } else
                        {
                            select.append("<OPTION VALUE=" + arr[i] + ">" + (i + 1));
                        }
                    }
                    String pageup = "";
                    if(index != -1 && currentlynode != arr[0])
                    {
                        Anchor anchor3 = new Anchor("/servlet/Literature?node=" + arr[index - 1] + "&language=" + h.language,r.getString(h.language,"PageUp"));
                        pageup = anchor3.toString() + " ";
                    }
                    String pagedown = "";
                    if(index != -1 && currentlynode != arr[arr.length - 1])
                    {
                        Anchor anchor3 = new Anchor("/servlet/Literature?node=" + arr[index + 1] + "&language=" + h.language,r.getString(h.language,"PageDown"));
                        pagedown = " " + anchor3.toString();
                    }
                    select.append("</SELECT>");
                    value = (pageup + select.toString() + pagedown);
                } catch(Exception ex)
                {
                    value = (null);
                    ex.printStackTrace();
                } finally
                {
                    dbadapter.close();
                }
            }
            if(itemname.equals("getFlash"))
            {
                if(obj.getFlash() != null && obj.getFlash().length() > 0)
                {
                    value = ("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\">\r\n" + "<param name=\"movie\" value=\"" + obj.getFlash() + "\">\r\n" + "<param name=\"quality\" value=\"high\">\r\n" + "<embed src=" + obj.getFlash() + " quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" ></embed>\r\n"
                             + "</object>");
                    // value=("<EMBED src=" + path + obj.getFlash() + " type=\"application/x-shockwave-flash\"></EMBED>");
                } else
                {
                    value = (null);
                }
            } else
            {
                try
                {
                    java.lang.reflect.Method m = c.getMethod(itemname,(java.lang.Class[])null);
                    Object o = m.invoke(obj,(Object[])null);
                    if(o instanceof String)
                    {
                        value = ((String) o);
                    } else if(o instanceof Integer)
                    {
                        value = (((Integer) o).toString());
                    }
                } catch(Exception ex)
                {
                }
            }
            if(currentlynode == node._nNode)
            {
                span = new Span(value);
                span.setId("LiteratureIDCurrentlyNode");
            } else if(detail.getAnchor(itemname) == 0)
            {
                span = new Span(value);
                span.setId("LiteratureID" + itemname);
            } else
            {
                String src = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/literature/" + node._nNode + "-" + h.language + ".htm";
                if(detail.getAnchor(itemname) > 8)
                {
                    src += "?listing=" + detail.getAnchor(itemname) + "&pos=" + 1;
                }
                anchor = new Anchor(src,value);
                anchor.setTarget(target);
                span = new Span(anchor);
                span.setId("LiteratureID" + itemname);
            }
            text.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
        }
        return text.toString();
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getSubhead()
    {
        return subhead;
    }

    public int getChapter()
    {
        return chapter;
    }

    public int getSection()
    {
        return section;
    }

    public int getPos()
    {
        return pos;
    }

    public String getCname()
    {
        return cname;
    }

    public String getAuthor()
    {
        return author;
    }

    public String getFlash()
    {
        return flash;
    }

    public String getSname()
    {
        return sname;
    }

    public boolean isExists()
    {
        return exists;
    }
}
