package tea.entity.site;

import java.sql.*;

import tea.db.*;
import tea.entity.*;

public class CommunityAdminList
{
    private static Cache _cache = new Cache(100);
    public static final String ALL_FIELD[] =
            {"/father/time/subject/content/","/category/typealias/","/redirecturl/","/","Buy","Bid","Bargain","Presentation","Chat","Quiz", //0
            "StampSet","Stamp","Book","News","Weather","Stock","Classified","Government","Institution","Group", //1
            "School","Company","Media","Publisher","WebSite","Person","Author","Reporter","Expert","Career","Financing", //2
            "Friend","Supply","Demand","Goods","Law","Recipe","Event","Sports","/media_id/class_id/picture/locus/logograph/issuetime/subhead/author/","Picture", //3
            "/classes/code/name/author/address/note/hits/","Application","SMS","/subtitle/author/editor/issue/edition/column/pubdate/","NightShop","Human","Enterprise","Hostel","Flight", //4
            "Job","Investor","Resume","LFinancing","LInvestor","Perform","Sound","BBS","Register","ERegister", //5
            "Gazetteer","EGazetteer","Court","Download","Score","Service","SOrder","Admin","Waiter","Client", //6
            "Express","Indict","Sale","MessageBoard","Contribute","Environmental","GreenManufacture","EarthKavass","AmityLink","Travel", //7
            "Literature","Landscape","Weblog","District","Interlocution","/media/subhead/author/locus/file/time/","/media/subhead/author/locus/file/time/",
            "","","","","","","","","","","","","","","","","","","",""};

    private String community;
    private int type;
    private String field;
    private String sorttype;
    private boolean sortdir;
    private boolean exists;
    public CommunityAdminList(String community,int type) throws SQLException
    {
        this.community = community;
        this.type = type;
        load();
    }

    public static CommunityAdminList find(String community,int type) throws SQLException
    {
        CommunityAdminList obj = (CommunityAdminList) _cache.get(community + ":" + type);
        if(obj == null)
        {
            obj = new CommunityAdminList(community,type);
            _cache.put(community + ":" + type,obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM CommunityAdminList WHERE community=" + db.cite(community) + " AND type=" + type);
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + type);
    }

    public void set(String field,String sorttype,boolean sortdir) throws SQLException
    {
        if(exists)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE CommunityAdminList SET field=" + DbAdapter.cite(field) + ",sorttype=" + DbAdapter.cite(sorttype) + ",sortdir=" + DbAdapter.cite(sortdir) + " WHERE community=" + db.cite(community) + " AND type=" + type);
            } finally
            {
                db.close();
            }
            this.field = field;
            this.sorttype = sorttype;
            this.sortdir = sortdir;
        } else
        {
            create(community,type,field,sorttype,sortdir);
            exists = true;
        }
    }

    public static void create(String community,int type,String field,String sorttype,boolean sortdir) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO CommunityAdminList(community,type,field,sorttype,sortdir)VALUES(" + DbAdapter.cite(community) + "," + type + "," + db.cite(field) + "," + db.cite(sorttype) + "," + db.cite(sortdir) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(community + ":" + type);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT field,sorttype,sortdir FROM CommunityAdminList WHERE community=" + DbAdapter.cite(community) + " AND type=" + type);
            if(db.next())
            {
                field = db.getString(1);
                sorttype = db.getString(2);
                sortdir = db.getInt(3) != 0;
                exists = true;
            } else
            {
                field = "/father/subject/time/";//海油搜索用到的 //issuetime/class_id/media_id
                sorttype = "node";
                sortdir = true;
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

//    public String getAllField()
//    {
//        String af = "/";
//        if (type.equals("adminunit"))
//        {
//            af = "/type/etype/father/linkmantype/address/";
//        } else if (type.equals("message"))
//        {
//            af = "/subject/fcommunity/content/time/";
//        }
//        return af;
//    }

    public int getType()
    {
        return type;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getField()
    {
        return field;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getSortType()
    {
        return sorttype;
    }

    public boolean isSortDir()
    {
        return sortdir;
    }

    //  public static Enumeration findByMember(String community, String type) throws SQLException
//  {
//    StringBuilder sql = new StringBuilder();
//    sql.append("SELECT adminlist FROM CommunityAdminList WHERE community=").append(DbAdapter.cite(community)).append(" AND type=").append(DbAdapter.cite(type));
//    Vector v = new Vector();
//    DbAdapter db = new DbAdapter(1);
//    try
//    {
//      db.executeQuery(sql.toString());
//      while (db.next())
//      {
//        v.addElement(new Integer(db.getInt(1)));
//      }
//    } finally
//    {
//      db.close();
//    }
//    return v.elements();
//  }

}
