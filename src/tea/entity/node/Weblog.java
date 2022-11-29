package tea.entity.node;

import java.util.Calendar;
import tea.ui.*;
import tea.entity.*;
import tea.html.Text;
import tea.html.Anchor;
import tea.html.Span;
import tea.html.Image;
import tea.db.DbAdapter;
import java.sql.SQLException;

public class Weblog extends Entity
{
    private static Cache _cache = new Cache(100);
    private int node;

    public Weblog(int node)
    {
        this.node = node;
    }

    public static Weblog find(int node)
    {
        Weblog obj = (Weblog) _cache.get(new Integer(node));
        if(obj == null)
        {
            obj = new Weblog(node);
            _cache.put(new Integer(node),obj);
        }
        return obj;
    }

    public int getNode()
    {
        return node;
    }

    public static boolean exists(RV rv,java.util.Date time) throws SQLException
    {
        boolean bool = false;
        Calendar c = Calendar.getInstance();
        c.setTime(time);
        c.set(11,0);
        c.set(12,0);
        c.set(13,0);
        c.set(14,0);
        StringBuilder sql = new StringBuilder("SELECT node FROM Node WHERE type=82 AND rcreator=");
        sql.append(DbAdapter.cite(rv._strR)).append(" AND vcreator=").append(DbAdapter.cite(rv._strV)).append(" AND time>=");
        DbAdapter db = new DbAdapter();
        sql.append(DbAdapter.cite(c.getTime())).append(" AND time<");
        c.set(c.DAY_OF_MONTH,c.get(c.DAY_OF_MONTH) + 1);
        sql.append(DbAdapter.cite(c.getTime()));
        try
        {
            db.executeQuery(sql.toString());
            bool = (db.next());
        } finally
        {
            db.close();
        }
        return bool;
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        Weblog obj = Weblog.find(node._nNode);
        StringBuilder htm = new StringBuilder();
        // r.add("tea/resource/Landscape");
        Class c = obj.getClass();
        String subject = node.getSubject(h.language);

        Span span = null;
        ListingDetail detail = ListingDetail.find(listing,82,h.language);
        java.util.Iterator listingDetailEnumeration = detail.keys();
        while(listingDetailEnumeration.hasNext())
        {
            Anchor anchor;
            String name = (String) listingDetailEnumeration.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }

            if(name.equals("getSubject"))
            {
                value = (subject);
            } else if(name.equals("getTime"))
            {
                value = (node.getTimeToString());
            } else if(name.equals("getText"))
            {
                if((node.getOptions() & 0x40L) == 0)
                {
                    value = (tea.html.Text.toHTML(node.getText2(h.language)));
                } else
                {
                    value = (node.getText2(h.language));
                }
            } else if(name.equals("getAnchor"))
            {
                value = ("点击此处查看原文");
            } else if(name.equals("getFooter"))
            {
                value = ("<A ID=getFooterTalkbacks href=/servlet/Talkbacks?node=" + node._nNode + ">评论(" + Talkback.count(node._nNode) + ")</A> ┆ <A ID=getFooterRreader TARGET=_blank href=/jsp/type/weblog/WeblogRreader.jsp?node=" + node._nNode + ">阅读(" + node.getClick() + ")</A> ┆ <A ID=getFooterEdit href=/jsp/type/weblog/EditWeblog.jsp?node=" + node._nNode + ">编辑</A> ┆ <A ID=getFooterPrint TARGET=_blank href=/jsp/type/weblog/WeblogPrint.jsp?node=" + node._nNode + ">打印</A>");
            } else if(name.equals("getPicture"))
            {
                StringBuilder sb = new StringBuilder();
                java.util.Enumeration enumer = TypePicture.findByNode(node._nNode);
                while(enumer.hasMoreElements())
                {
                    int id = ((Integer) enumer.nextElement()).intValue();
                    TypePicture tp = TypePicture.findByPrimaryKey(id);
                    String img = new tea.html.Image(tp.getPicture(),tp.getPicname()).toString();
                    switch(detail.getAnchor(name))
                    {
                    case 2:
                        if(tp.getPicture2() != null && tp.getPicture2().length() > 0)
                        {
                            anchor = new Anchor("javascript:window.showModalDialog('" + tp.getPicture2() + "','self','edge:raised;status:0;help:0;resizable:1;dialogWidth:" + (tp.getWidth() + 9) + "px;dialogHeight:" + (tp.getHeight() + 27) + "px;')",img);
                            span = new Span(anchor);
                        } else
                        {
                            span = new Span(img);
                        }
                        break;
                    case 1:
                        anchor = new Anchor("/servlet/Weblog?node=" + node._nNode + "&language=" + h.language,subject);
                        anchor.setTarget(target);
                        span = new Span(anchor);
                        break;
                    default:
                        span = new Span(img);
                    }
                    span.setId("WeblogIDgetPicture");
                    sb.append(detail.getBeforeItem(name) + span + detail.getAfterItem(name));
                }
                htm.append(sb);
                continue;
            } else if(name.equals("getPictureName"))
            {
                StringBuilder sb = new StringBuilder();
                java.util.Enumeration enumer = TypePicture.findByNode(node._nNode);
                while(enumer.hasMoreElements())
                {
                    int id = ((Integer) enumer.nextElement()).intValue();
                    TypePicture tp = TypePicture.findByPrimaryKey(id);
                    switch(detail.getAnchor(name))
                    {
                    case 1:
                        anchor = new Anchor("/servlet/Weblog?node=" + node._nNode + "&language=" + h.language,tp.getPicname());
                        anchor.setTarget(target);
                        span = new Span(anchor);
                        break;
                    default:
                        span = new Span(tp.getPicname());
                    }
                    span.setId("WeblogIDgetPictureName");
                    sb.append(detail.getBeforeItem(name) + span + detail.getAfterItem(name));
                }
                htm.append(sb);
                continue;
            } else
            {
                try
                {
                    java.lang.reflect.Method m = c.getMethod(name,(java.lang.Class[])null);
                    Object o = m.invoke(obj,(Object[])null);
                    if(o instanceof String)
                    {
                        value = ((String) o);
                    } else if(o instanceof Integer)
                    {
                        value = (((Integer) o).toString());
                    }
                } catch(Exception e)
                {
                    e.printStackTrace();
                }
            }
            if(detail.getAnchor(name) != 0)
            {
                anchor = new Anchor("/servlet/Weblog?node=" + node._nNode + "&language=" + h.language,value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("WeblogID" + name);
            htm.append(detail.getBeforeItem(name) + span + detail.getAfterItem(name));
        }
        return htm.toString();
    }
}
