package tea.entity.site;

import java.sql.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;

public class CommunityOffice extends Entity
{
    private static Cache _cache = new Cache(100);
    private String community;
    private String productCaption;
    private String productKey;
    private String template;
    public String issued; //发文代号
    private boolean exists;

    public static CommunityOffice find(String community) throws SQLException
    {
        CommunityOffice obj = (CommunityOffice) _cache.get(community);
        if(obj == null)
        {
            obj = new CommunityOffice(community);
            _cache.put(community,obj);
        }
        return obj;
    }

    public CommunityOffice(String community) throws SQLException
    {
        this.community = community;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT productcaption,productkey,template,issued FROM CommunityOffice WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                productCaption = db.getString(1);
                productKey = db.getString(2);
                template = db.getString(3);
                issued = db.getString(4);
                exists = true;
            } else
            {
                productCaption = "北京怡康科技有限公司";
                productKey = "C0C721E12E94305F3FDCFF43A09BD496FB9A8DBF";
                template = "/tea/applet/office/default.doc";
                issued = "怡康科技";
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public void set(String productCaption,String productKey,String template,String issued) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.executeUpdate("UPDATE CommunityOffice SET productcaption=" + db.cite(productCaption) + ",productkey=" + db.cite(productKey) + ",template=" + db.cite(template) + ",issued=" + db.cite(issued) + " WHERE community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
        if(j < 1)
        {
            exists = true;
            create(community,productCaption,productKey,template,issued);
        }
        this.productCaption = productCaption;
        this.productKey = productKey;
        this.template = template;
        this.issued = issued;
    }

    public static void create(String community,String productCaption,String productKey,String template,String issued) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO CommunityOffice(community,productcaption,productkey,template,issued)VALUES(" + DbAdapter.cite(community) + "," + db.cite(productCaption) + "," + db.cite(productKey) + "," + db.cite(template) + "," + db.cite(issued) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(community);
    }

    public static Enumeration find(String sql,int pos,int pagesize) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community FROM CommunityOffice WHERE 1=1" + sql);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM CommunityOffice WHERE community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
        _cache.remove(community);
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getProductKey()
    {
        return productKey;
    }

    public String getProductCaption()
    {
        return productCaption;
    }

    public String getTemplate()
    {
        return template;
    }
}
