package tea.entity.node;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import java.io.Writer;
import java.io.IOException;

//复制的临时表,用于:改节点号.
public class Clonetemp extends Entity
{
    // private static Cache _cache = new Cache(100);
    private int node;
    private String sessionid;
    private int newnode;
    private String listing;
    private String section;
    private String cssjs;

    private Clonetemp(int node,String sessionid) throws SQLException
    {
        this.node = node;
        this.sessionid = sessionid;
        load();
    }

    public Clonetemp(int node,String sessionid,int newnode,String listing,String section,String cssjs)
    {
        this.node = node;
        this.sessionid = sessionid;
        this.newnode = newnode;
        this.listing = listing;
        this.section = section;
        this.cssjs = cssjs;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT newnode,listing,section,cssjs FROM Clonetemp WHERE node=" + node + " AND sessionid=" + DbAdapter.cite(sessionid));
            if(db.next())
            {
                newnode = db.getInt(1);
                listing = db.getString(2);
                section = db.getString(3);
                cssjs = db.getString(4);
            }
        } finally
        {
            db.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Clonetemp WHERE node=" + node + " AND sessionid=" + DbAdapter.cite(sessionid));
        } finally
        {
            db.close();
        }
    }

    public static void create(int node,String sessionid,int newnode,String listing,String section,String cssjs) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Clonetemp(node,sessionid,newnode,listing,section,cssjs)VALUES(" + node + "," + DbAdapter.cite(sessionid) + "," + newnode + "," + DbAdapter.cite(listing) + "," + DbAdapter.cite(section) + "," + DbAdapter.cite(cssjs) + ")");
        } finally
        {
            db.close();
        }
    }

    public static int correct(String sessionid,Writer out) throws SQLException,IOException
    {
        if(out != null)
        {
            out.write("<script>$('dialog_content').innerHTML='开始替换节点号...';</script>");
            out.flush();
        }
        System.out.println("开始替换节点号...");
        Object objs[] = findBySessionid(sessionid).toArray();

        String listing_sql = "SELECT l.listing,ll.language,ll.beforelisting,ll.afterlisting FROM Listing l,ListingLayer ll,Clonetemp c WHERE l.listing=ll.listing AND l.node=c.newnode AND c.sessionid=" + DbAdapter.cite(sessionid);
        String section_sql = "SELECT s.section,sl.language,sl.text FROM Section s,SectionLayer sl,Clonetemp c WHERE s.section=sl.section AND s.node=c.newnode AND c.sessionid=" + DbAdapter.cite(sessionid);
        String cssjs_sql = "SELECT cj.cssjs FROM CssJs cj,Clonetemp c WHERE cj.node=c.newnode AND c.sessionid=" + DbAdapter.cite(sessionid);
        StringBuilder listing_sb = new StringBuilder();
        StringBuilder section_sb = new StringBuilder();

        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            System.out.print("\r\n列举");
            db.executeQuery(listing_sql);
            while(db.next())
            {
                int listing = db.getInt(1);
                int language = db.getInt(2);
                System.out.println("列举：" + listing);
                if(out != null)
                {
                    out.write("<script>$('dialog_content').innerHTML='列举：" + listing + "';</script>");
                    out.flush();
                }
                String beforelisting = db.getText(3);
                String afterlisting = db.getText(4);
                for(int index = 0;index < objs.length;index++)
                {
                    Clonetemp obj = (Clonetemp) objs[index];
                    beforelisting = beforelisting.replaceAll("ode=" + obj.getNode(),"ode=" + obj.getNewnode()).replaceAll("/" + obj.getNode() + "-1.htm","/" + obj.getNewnode() + "-1.htm").replaceAll("/" + obj.getNode() + ".htm","/" + obj.getNewnode() + ".htm");
                    afterlisting = afterlisting.replaceAll("ode=" + obj.getNode(),"ode=" + obj.getNewnode()).replaceAll("/" + obj.getNode() + "-1.htm","/" + obj.getNewnode() + "-1.htm").replaceAll("/" + obj.getNode() + ".htm","/" + obj.getNewnode() + ".htm");
                }
                listing_sb.append("," + listing);
                db2.setText2("ListingLayer",new String[]
                            {"beforelisting","afterlisting"},new String[]
                            {beforelisting,afterlisting},"listing=" + listing + " AND language=" + language);
            }
            System.out.print("\r\n段落");
            db.executeQuery(section_sql);
            while(db.next())
            {
                System.out.print(".");
                int section = db.getInt(1);
                int language = db.getInt(2);
                System.out.println("段落：" + section);
                if(out != null)
                {
                    out.write("<script>$('dialog_content').innerHTML='段落：" + section + "';</script>");
                    out.flush();
                }
                String text = db.getText(3);
                for(int index = 0;index < objs.length;index++)
                {
                    Clonetemp obj = (Clonetemp) objs[index];
                    text = text.replaceAll("ode=" + obj.getNode(),"ode=" + obj.getNewnode()).replaceAll("/" + obj.getNode() + "-1.htm","/" + obj.getNewnode() + "-1.htm").replaceAll("/" + obj.getNode() + ".htm","/" + obj.getNewnode() + ".htm");
                }
                section_sb.append("," + section);
                db2.setText2("SectionLayer","text",text,"section=" + section + " AND language=" + language);
            }
            /*
             * db.executeQuery(cssjs_sql); while (db.next()) { int cssjs = db.getInt(1); int root = db.getInt(2); for (int index = 0; index < objs.length; index++) { Clonetemp obj = (Clonetemp) objs[index]; if (root == obj.getNode()) { root = obj.getNewnode(); break; } } db2.executeUpdate("UPDATE CssJs SET root=" + root + " WHERE cssjs=" + cssjs); }
             */
            System.out.print("\r\n设置(" + objs.length + ")");
            for(int i = 0;i < objs.length;i++)
            {
                System.out.print(".");
                Clonetemp obj = (Clonetemp) objs[i];
                System.out.println("选取源：" + obj.node);
                if(out != null)
                {
                    out.write("<script>$('dialog_content').innerHTML='选取源：" + obj.node + "';</script>");
                    out.flush();
                }
                // String listing = obj.getListing();
                if(listing_sb.length() > 0)
                {
                    // 列举选取源
                    int count = db.executeUpdate("UPDATE PickFrom SET fromnode=" + obj.getNewnode() + " WHERE fromnode=" + obj.getNode() + " AND listing IN(" + listing_sb.substring(1) + ")");
                    // 列举选社区
                    // System.out.println("复制:" + obj.getNode() + " TO " + obj.getNewnode()+"\t结果:"+count);
                    if(i == 0)
                    {
                        db.executeUpdate("UPDATE PickFrom SET fromcommunity=" + DbAdapter.cite(Node.find(obj.getNewnode()).getCommunity()) + " WHERE fromcommunity=" + DbAdapter.cite(Node.find(obj.getNode()).getCommunity()) + " AND listing IN(" + listing_sb.substring(1) + ")");
                    }
                    // 列举隐藏
                    db.executeUpdate("UPDATE listinghide SET node=" + obj.getNewnode() + " WHERE node=" + obj.getNode() + " AND listing IN(" + listing_sb.substring(1) + ")");
                    // 同根
                    // db.executeUpdate("UPDATE Listing SET root=" + obj.getNewnode() + " WHERE root=" + obj.getNode() + " AND listing IN(" + listing_sb.substring(1) + ")");
                }

                // String section = obj.getSection();
                if(section_sb.length() > 0)
                {
                    // 段落隐藏
                    db.executeUpdate("UPDATE sectionhide SET node=" + obj.getNewnode() + " WHERE node=" + obj.getNode() + " AND section IN(" + section_sb.substring(1) + ")");
                    // 同根
                    // db.executeUpdate("UPDATE Section SET root=" + obj.getNewnode() + " WHERE root=" + obj.getNode() + " AND section IN(" + section_sb.substring(1) + ")");
                }

                // String cssjs = obj.getCssjs();
                // if (cssjs.length() > 0)
                {
                    // cssjs隐藏
                    db.executeUpdate("UPDATE CssJsHide SET node=" + obj.getNewnode() + " WHERE node=" + obj.getNode() + " AND cssjs IN(" + cssjs_sql + ")");
                    // 同根
                    // db.executeUpdate("UPDATE CssJs SET root=" + obj.getNewnode() + " WHERE root=" + obj.getNode() + " AND cssjs IN(" + cssjs_sql + ")");
                }
            }
        } finally
        {
            db.close();
            db2.close();
        }
        return deleteBySessionid(sessionid);
    }

    public static Vector findBySessionid(String sessionid) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,newnode,listing,section,cssjs FROM Clonetemp WHERE sessionid=" + DbAdapter.cite(sessionid));
            while(db.next())
            {
                int node = db.getInt(1);
                int newnode = db.getInt(2);
                String listing = db.getString(3);
                String section = db.getString(4);
                String cssjs = db.getString(5);
                vector.addElement(new Clonetemp(node,sessionid,newnode,listing,section,cssjs));
            }
        } finally
        {
            db.close();
        }
        return vector;
    }

    public static int deleteBySessionid(String sessionid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.executeUpdate("DELETE FROM Clonetemp WHERE sessionid=" + DbAdapter.cite(sessionid));
        } finally
        {
            db.close();
        }
    }

    /*
     * public static Clonetemp find(int node, String sessionid) throws SQLException { Clonetemp obj = (Clonetemp) _cache.get(node + ":" + sessionid); if (obj == null) { obj = new Clonetemp(node, sessionid); _cache.put(node + ":" + sessionid, obj); } return obj; }
     */
    public String getSessionid()
    {
        return sessionid;
    }

    public int getNode()
    {
        return node;
    }

    public int getNewnode()
    {
        return newnode;
    }

    public String getSection()
    {
        return section;
    }

    public String getListing()
    {
        return listing;
    }

    public String getCssjs()
    {
        return cssjs;
    }
}
