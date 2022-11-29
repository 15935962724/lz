package tea.entity.contract;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;


public class Iteminfo extends Entity
{
    private String itemid; /**项目ID*/
    private String itemtype; /**项目类型*/
    private String community; /**所在社区*/


    /**用项目ID查找相对应的记录 用load初始化 一个对像*/
    public Iteminfo(String itemid) throws SQLException
    {
        this.itemid = itemid;
        load();

    }

    public Iteminfo() throws SQLException
    {
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select itemid,itemtype,community from iteminfo where itemid=" + db.cite(itemid));
            if(db.next())
            {
                itemid = db.getString(1);
                itemtype = db.getString(2);
                community = db.getString(3);
            }
        } finally
        {
            db.close();
        }
    }

    /**实例化一个用项目ID查找到并用LOAD方法初始化的对像 并反回*/
    public static Iteminfo find(String itemid) throws SQLException
    {
        Iteminfo obj = new Iteminfo(itemid);
        return obj;
    }


    /**增加或修改方法*/
    public static void create(String itemid,String itemtype,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            if(itemid != null && !itemid.equals("null") && !itemid.equals(""))
            {
                /**如果数据库中有这条记录 则修改否则增加记录*/

                db.executeQuery("select * from iteminfo where itemid=" + db.cite(itemid));

                if(db.next())
                {
                    db.executeUpdate("update iteminfo set itemtype=" + db.cite(itemtype) + ", community=" + db.cite(community) + " where itemid=" + db.cite(itemid));
                }

            } else
            {
                db.executeUpdate("insert into iteminfo (itemid,itemtype,community) values(" + db.cite(String.valueOf(Integer.parseInt(Iteminfo.maxid()) + 1)) + "," + db.cite(itemtype) + "," + db.cite(community) + ")");
            }

        } finally
        {
            db.close();
        }
    }

    /**求当社区的记录总数*/
    public static int count(String community) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM iteminfo  where community=" + DbAdapter.cite(community));
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    /**反回以 当前社区为条件从POS开始的SIZE条记录生成的 枚举用以到前台去查找 并生成对像*/
    public static Enumeration find(String community,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT itemid  FROM iteminfo where community=" + db.cite(community),pos,size);
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

    /**反回以 当前社区为条件从POS开始的SIZE条记录生成的 List*/
    public static List find1(String community,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        Iteminfo it = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT itemid,itemtype,community  FROM iteminfo where community=" + db.cite(community),pos,size);
            while(db.next())
            {
                while(it != null)
                {
                    it = null;
                }
                it = new Iteminfo();
                it.setItemid(db.getString(1));
                it.setItemtype(db.getString(2));
                it.setCommunity(db.getString(3));
                v.add(it);
            }
        } finally
        {
            db.close();
        }
        return v;
    }

    /**删除 ID和参数相同的记录*/
    public static void del(String id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete iteminfo where itemid=" + db.cite(id));
        } finally
        {
            db.close();
        }
    }

    /**求相同的记录条数*/
    public static int findSame(String itemtype) throws SQLException
    {
        int num = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select count(*) from iteminfo where itemtype=" + db.cite(itemtype));
            if(db.next())
            {
                num = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return num;
    }

    /**求当前ID的最大值*/
    public static String maxid() throws SQLException
    {
        String id = "0";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select max(itemid) from iteminfo");
            if(db.next())
            {
                id = db.getString(1);
                if(id == null || id.equals(""))
                {
                    id = "0";
                }

            }
        } finally
        {
            db.close();
        }

        return id;
    }

    public String getItemid()
    {
        return itemid;
    }

    public String getItemtype()
    {
        return itemtype;
    }

    public String getCommunity()
    {
        return community;
    }

    public void setItemid(String itemid)
    {
        this.itemid = itemid;
    }

    public void setItemtype(String itemtype)
    {
        this.itemtype = itemtype;
    }

    public void setCommunity(String community)
    {
        this.community = community;
    }

}
