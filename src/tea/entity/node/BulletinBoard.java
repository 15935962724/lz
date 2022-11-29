package tea.entity.node;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.html.*;
import java.sql.SQLException;

public class BulletinBoard
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int language;
    private boolean exists;

    public static BulletinBoard find(int node) throws SQLException
    {
        BulletinBoard obj = (BulletinBoard) _cache.get(new Integer(node));
        if(obj == null)
        {
            obj = new BulletinBoard(node);
            _cache.put(new Integer(node),obj);
        }
        return obj;
    }

    public BulletinBoard(int node) throws SQLException
    {
        this.node = node;
        load();
    }

    private void load() throws SQLException
    {
        int j = Node.getLanguage(node,language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT * FROM BulletinBoard WHERE node=" + node + " AND language=" + j);
            if(db.next())
            {
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

    public void set(int hint,String phone,String mobile,String email,String name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM BulletinBoard  WHERE node=" + node + " AND language=" + language);
            if(db.next())
            {
                db.executeUpdate("UPDATE BulletinBoard SET hint  =" + hint + "  ,phone =" + DbAdapter.cite(phone) + " ,mobile=" + DbAdapter.cite(mobile) + ",email =" + DbAdapter.cite(email) + " ,name  =" + DbAdapter.cite(name) + "  WHERE  node=" + node + " AND language=" + language);
            } else
            {
                db.executeUpdate("INSERT INTO BulletinBoard(node    ,language,hint    ,phone   ,mobile  ,email   ,name    )VALUES(" + node + "    ," + language + "," + hint + "    ," + DbAdapter.cite(phone) + "   ," + DbAdapter.cite(mobile) + "  ," + DbAdapter.cite(email) + "   ," + DbAdapter.cite(name) + " )");
            }
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    public static String getDetail(Node node,int language,int listing,String target,tea.resource.Resource r,RV rv) throws SQLException
    {
        Span span = null;
        StringBuilder sb = new StringBuilder();
        ListingDetail ld = ListingDetail.find(listing,73,language);
        java.util.Iterator e = ld.keys();
        while(e.hasNext())
        {
            String name = (String) e.next();
            String value = null;
            if(name.startsWith("r_"))
            {
                continue;
            } else if(name.equals("subject"))
            {
                value = (node.getSubject(language));
            } else if(name.equals("text"))
            {
                value = (node.getText2(language));
            }
            if(value != null && ld.getQuantity(name) > 0 && value.length() > ld.getQuantity(name))
            {
                value = value.substring(0,ld.getQuantity(name)) + " ...";
            }
            if(ld.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/servlet/BulletinBoard?node=" + node._nNode + "&language=" + language,value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("BulletinBoardID" + name);
            sb.append(ld.getBeforeItem(name)).append(span).append(ld.getAfterItem(name));
        }
        return sb.toString();
    }

    public int getNode()
    {
        return node;
    }

    public int getLanguage()
    {
        return language;
    }


    public boolean isExists()
    {
        return exists;
    }
}
