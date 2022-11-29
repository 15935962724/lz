package tea.entity.node;

import tea.entity.*;
import tea.html.Anchor;
import tea.html.Span;
import tea.html.Text;
import java.util.*;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.ui.TeaSession;

public class Sale
{
    private static Cache _cache = new Cache(100);
    private String capability;
    private String picture;
    private String price;
    private int area;
    private int node;
    private int language;
    private boolean exists;
    public final static String AREA_TYPE[] =
            {"All","Circle","Friend"};

    public Sale(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        loadBase();
    }

    public String getCapability()
    {
        return capability;
    }

    public String getPicture()
    {
        return picture;
    }

    public String getPrice()
    {
        return price;
    }

    public int getArea()
    {
        return area;
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

    public static Sale find(int node,int language) throws SQLException
    {
        Sale obj = (Sale) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new Sale(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public void set(String capability,String picture,String price,int area) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            /*
             * db.executeUpdate("SaleEdit " + node + "," + language + "," + DbAdapter.cite(capability) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(price) + "," + area);
             */
            db.executeQuery("SELECT node FROM Sale WHERE node=" + node + " AND language=" + language);
            if(db.next())
            {
                db.executeUpdate("UPDATE Sale   SET 	capability=" + DbAdapter.cite(capability) + ",	picture=" + DbAdapter.cite(picture) + ",	price=" + DbAdapter.cite(price) + ",	area=" + area + " WHERE node =" + node + " AND language=" + language);
            } else
            {
                db.executeUpdate("INSERT INTO Sale (node      ,language  ,capability,picture   ,price     ,area      )VALUES (" + node + " ," + language + "  ," + DbAdapter.cite(capability) + "," + DbAdapter.cite(picture) + "   ," + DbAdapter.cite(price) + " ," + area + " )");
            }

        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
    }

    private void loadBase() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT capability,picture   ,price     ,area   FROM Sale WHERE node=" + node + " AND language=" + language);
            if(db.next())
            {
                capability = db.getVarchar(language,language,1);
                picture = db.getString(2);
                price = db.getVarchar(language,language,3);
                area = db.getInt(4);
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

    public static String getDetail(Node node,Http h,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        Span span = null;
        StringBuilder sb = new StringBuilder();
        Sale sale = Sale.find(node._nNode,h.language);
        ListingDetail detail = ListingDetail.find(listing,72,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String itemname = (String) e.next(),value = null;
            if(itemname.equals("subject"))
            {
                value = (node.getSubject(h.language));
            } else if(itemname.equals("capability"))
            {
                value = (sale.getCapability());
            } else if(itemname.equals("text"))
            {
                if((node.getOptions() & 0x40L) == 0)
                {
                    value = (tea.html.Text.toHTML(node.getText2(h.language)));
                } else
                {
                    value = (node.getText2(h.language));
                }

                // value=(tea.entity.node.Node.find(node).getText(iLanguage));
            } else if(itemname.equals("price"))
            {
                value = (sale.getPrice());
            } else if(itemname.equals("area"))
            {
                r.add("tea/resource/Sale");
                value = (r.getString(h.language,AREA_TYPE[sale.getArea()]));
            } else if(itemname.equals("picture"))
            {
                String picture = sale.getPicture();
                if(picture != null && picture.length() > 0)
                {
                    tea.html.Image img = new tea.html.Image(picture,node.getSubject(h.language));
                    // img.setWidth(240);
                    // img.setHeight(160);
                    value = (new tea.html.Anchor(picture,img).toString());
                } else
                {
                    value = ("");
                }
            }
            if(detail.getAnchor(itemname) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/sale/" + node._nNode + "-" + h.language + ".htm",value);
                // Anchor anchor = new Anchor("/servlet/" + node, value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("SaleID" + value);
            sb.append(detail.getBeforeItem(itemname) + span + detail.getAfterItem(itemname));
        }
        return sb.toString();
    }

    public static Enumeration find(String community,String member) throws SQLException
    {
        Vector vector = new Vector();
        StringBuilder from = new StringBuilder("SELECT DISTINCT Node.node FROM Sale,Node");
        StringBuilder where = new StringBuilder(" WHERE Sale.node=Node.node AND Node.hidden=0 AND community=" + DbAdapter.cite(community) + " AND Sale.area=0");
        if(member != null)
        {
            from.append(",FriendList");
            where.append(" OR (Sale.area=2 AND FriendList.member=Node.rcreator AND FriendList.member2=" + DbAdapter.cite(member) + ")"); // ����
            where.append(" OR (Sale.area=1 AND FriendList.member=Node.rcreator AND FriendList.member2 IN(SELECT member FROM FriendList WHERE FriendList.member2=" + DbAdapter.cite(member) + "))"); // ����Ȧ
        }
        DbAdapter db = new DbAdapter();
        try
        {
            // System.out.println(from.toString() + where.toString());
            db.executeQuery(from.toString() + where.toString());
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
}
