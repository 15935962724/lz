package tea.entity.node;

import java.util.*;
import tea.entity.*;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.ui.*;
import tea.html.Text;
import tea.html.Anchor;
import tea.html.Span;


public class Indict
{
    private int node;
    private int language;
    private String appellee;
    private int sorder;
    private String handler;
    private String result;
    private Date time;
    private boolean exists;
    private static Cache _cache = new Cache(100);

    public Indict(int _nNode,int _nLanguage) throws SQLException
    {
        node = _nNode;
        language = _nLanguage;
        loadBasic();
    }

    public static Indict find(int _nNode,int _nLanguage) throws SQLException
    {
        Indict objIndict = (Indict) _cache.get(_nNode + ":" + _nLanguage);
        if(objIndict == null)
        {
            objIndict = new Indict(_nNode,_nLanguage);
            _cache.put(_nNode + ":" + _nLanguage,objIndict);
        }
        return objIndict;
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT appellee,sorder  ,handler ,result  ,time     FROM Indict  WHERE node=" + node + " AND language=" + language);
            if(db.next())
            {
                appellee = db.getVarchar(language,language,1);
                sorder = db.getInt(2);
                handler = db.getVarchar(language,language,3);
                result = db.getVarchar(language,language,4);
                time = db.getDate(5);
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

    public void set(String appellee,int sorder) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            // db.executeUpdate("IndictEdit " + node + "," + language + "," +
            // DbAdapter.cite(appellee) + "," + sorder);
            db.executeQuery("SELECT node FROM Indict WHERE node=" + node + " AND language=" + language);
            if(db.next())
            {
                db.executeUpdate("UPDATE Indict SET appellee=" + DbAdapter.cite(appellee) + ",sorder=" + sorder + " WHERE node=" + node + " AND language=" + language);
            } else
            {
                db.executeUpdate("INSERT INTO Indict(node,language,appellee,sorder)VALUES(" + node + "," + language + "," + DbAdapter.cite(appellee) + "," + sorder + ")");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public void set(String handler,String result) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Indict SET handler=" + DbAdapter.cite(handler) + ",result=" + DbAdapter.cite(result) + ",time=" + db.citeCurTime() + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getAppellee()
    {
        return appellee;
    }

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        Span span = null;
        StringBuilder sb = new StringBuilder();
        Indict indict = Indict.find(node._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,71,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("subject"))
            {
                value = (node.getSubject(h.language));
            } else if(name.equals("appellee")) // 被上诉人
            {
                value = (indict.getAppellee());
            } else if(name.equals("text")) // 上诉内容
            {
                if((node.getOptions() & 0x40L) == 0)
                {
                    value = (tea.html.Text.toHTML(node.getText2(h.language)));
                } else
                {
                    value = (node.getText2(h.language));
                }
            } else if(name.equals("sorder")) // 发在订单
            {
                value = String.valueOf(indict.getSorder());
            } else if(name.equals("handler")) // 处理人(法官)
            {
                value = (indict.getHandler());
            } else if(name.equals("result")) // 处理结果
            {
                value = (indict.getResult());
            } else if(name.equals("time")) // 上诉时间
            {
                value = (node.getTimeToString());
            } else if(name.equals("handlertime")) // 投诉的处理时间
            {
                value = (indict.getTime("yyyy-MM-dd hh:mm"));
            } else if(name.equals("plaintiff")) // 投诉人
            {
                value = (node.getCreator().toString());
            } else if(name.equals("handlerbutton")) // 处理铵钮
            {
                value = (new tea.html.Button("IndictNamehandlerbutton",r.getString(h.language,"CBEdit"),"window.location='/jsp/type/indict/BgEditIndict.jsp?node=" + node._nNode + "'").toString());
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/indict/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("IndictID" + name);
            sb.append(detail.getBeforeItem(name) + span + detail.getAfterItem(name));
        }
        return sb.toString();
    }

    public int getSorder()
    {
        return sorder;
    }

    public String getHandler()
    {
        return handler;
    }

    public String getResult()
    {
        return result;
    }

    public String getTime(String pattern)
    {
        if(time != null)
        {
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(pattern);
            return sdf.format(time);
        } else
        {
            return "";
        }
    }

    public Date getTime()
    {
        return time;
    }

    public boolean isExists()
    {
        return exists;
    }
}
