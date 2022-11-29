package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.ui.*;
import tea.entity.*;
import tea.html.Anchor;
import tea.html.Span;
import tea.html.Text;
import java.util.*;
import java.sql.SQLException;

public class Page extends Entity
{
    private int _nNode;
    private Hashtable _htLayer;
    public static Cache _cache = new Cache(100);

    class Layer
    {

        String _strRedirectUrl;

        Layer()
        {
        }
    }


    public String getRedirectUrl(int i) throws SQLException
    {
        return getLayer(i)._strRedirectUrl;
    }

    public void set(int i,String s) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM PageLayer WHERE node=" + _nNode + " AND language=" + i);
            if(db.next())
            {
                db.executeUpdate(_nNode,"UPDATE PageLayer SET redirecturl=" + DbAdapter.cite(s) + " WHERE node=" + _nNode + "  AND language=" + i);
            } else
            {
                db.executeUpdate(_nNode,"INSERT INTO PageLayer(node, language, redirecturl)VALUES(" + _nNode + ", " + i + ", " + DbAdapter.cite(s) + ")");
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    private Page(int i)
    {
        _nNode = i;
        _htLayer = new Hashtable();
    }

    public boolean isLayerExisted(int i) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM PageLayer WHERE node=" + _nNode + " AND language=" + i);
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = Node.getLanguage(_nNode,i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery(" SELECT redirecturl FROM PageLayer WHERE node=" + _nNode + " AND language=" + j);
                if(db.next())
                {
                    layer._strRedirectUrl = db.getString(1);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }


    public void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM PageLayer WHERE node=" + _nNode + " AND language=" + i);
        } finally
        {
            db.close();
        }
        _htLayer.remove(new Integer(i));
    }

    public static Page find(int i)
    {
        Page page = (Page) _cache.get(new Integer(i));
        if(page == null)
        {
            page = new Page(i);
            _cache.put(new Integer(i),page);
        }
        return page;
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        StringBuilder text = new StringBuilder();
        int _nNode = node._nNode;
        String subject = node.getSubject(h.language);

        Page obj = Page.find(_nNode);

        ListingDetail detail = ListingDetail.find(listing,2,h.language);
        java.util.Iterator e = detail.keys();

        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            int dq = detail.getQuantity(name);
            if(name.equals("Subject"))
            {
                value = subject;
            } else if(name.equals("Content"))
            {
                value = node.getText(h.language);
            } else if(name.equals("Picture"))
            {
                if(node.getPicture(h.language) != null && node.getPicture(h.language).length() > 0)
                {
                    value = "<img src =" + node.getPicture(h.language) + ">";
                }
            } else if(name.equals("RedirectUrl")) //
            {
                value = obj.getRedirectUrl(h.language);
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

            //限制字数
            value = detail.getOptionsToHtml(name,node,value);

            value = detail.getOptionsToHtml(name,node,value);
            //显示连接的地方s

            if(detail.getAnchor(name) == 1)
            {
                value = "<a href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/page/" + _nNode + "-" + h.language + ".htm' target='" + target + "' title=\"" + subject + "\">" + value + "</a>";
            }
            if(detail.getAnchor(name) == 2)
            {
                value = "<a href=" + obj.getRedirectUrl(h.language) + ">" + value + "</a>";
            }
            if(detail.getAnchor(name) == 3)
            {
                value = "<a href='###' onclick=\"mt.img('" + node.getPicture(h.language) + "')\">" + value + "</a>";
            }

            text.append(bi).append("<span id='VenuesID" + name + "'>" + value + "</span>").append(ai);
//            switch(detail.getAnchor(name))
//            {
//            case 0:
//                span = new Span(value);
//                break;
//            case 1:
//                Anchor anchor = new Anchor("/html/page/" + node._nNode + "-" + h.language + ".htm",value);
//                anchor.setTarget(target);
//                span = new Span(anchor);
//                break;
//            case 2: //
//                Anchor anchor2 = new Anchor(obj.getRedirectUrl(h.language),value);
//                anchor2.setTarget(target);
//                span = new Span(anchor2);
//                break;
//            }
//            span.setId("PageID" + name);
//            text.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
        }
        return text.toString();
    }
}
