package tea.entity.node;

//import org.apache.struts.action.*;
import java.sql.*;
import java.util.Date;
import tea.entity.integral.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.site.*;


public class InterlocutionReply extends tea.entity.Entity
{
    private int node;
    private int language;
    private static Cache _cache = new Cache(100);
    private boolean exists;
    private int id;
    private String member;
    private String text;
    private Date time;
    private boolean hidden;
    private int backstatic; //回复状态

    public static final String BACKSTATIC[] =
            {"其他答案", "最佳答案"};

    public static InterlocutionReply find(int id) throws SQLException
    {
        InterlocutionReply obj = (InterlocutionReply) _cache.get(new Integer(id));
        if (obj == null)
        {
            obj = new InterlocutionReply(id);
            _cache.put(new Integer(id), obj);
        }
        return obj;
    }

    public InterlocutionReply(int id) throws SQLException
    {
        this.id = id;
        loadBasic();
    }

    /*
     * public void set() throws SQLException { DbAdapter dbadapter = new DbAdapter(); try { dbadapter.executeUpdate("UPDATE InterlocutionReply SET hint=" + (hint) + " WHERE node=" + this.node + " AND language=" + this.language); _cache.remove(new Integer(id)); } finally { dbadapter.close(); } }
     */

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM InterlocutionReply WHERE id=" + this.id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }
    ///更改积分,回复问题 创建问题的同时也会对应的会员加积分
    public static void create(int node, int language, String member, String text, boolean hidden,String community) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        Date dates =  new Date();
        Communityintegral comm = Communityintegral.find(community); //取得本社区回答问题的分
        //IntegralCycle.create(member, comm.getQu_answer(), dates, 3,community);

        try
        {
            db.executeUpdate("INSERT INTO InterlocutionReply(node,language,member,text,hidden,time)VALUES(" + node + "," + language + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(text) + "," + DbAdapter.cite(hidden) + "," + db.citeCurTime() + ")");
            id = db.getInt("SELECT MAX(id) FROM InterlocutionReply");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public static int findLast(int node, int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT  id  FROM InterlocutionReply WHERE node=" + node + " AND language=" + language + " ORDER BY backstatic DESC");
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration find(int node, int language,int pos,int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeQuery("SELECT id  FROM InterlocutionReply WHERE node=" + node + " AND language=" + language + " and backstatic!=1 ORDER BY backstatic DESC",pos,size);
           // System.out.println("SELECT id  FROM InterlocutionReply WHERE node=" + node + " AND language=" + language + "and backstatic!=1 ORDER BY backstatic DESC");
            while (db.next())
            {

                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    public static java.util.Enumeration findold(int node, int language) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id  FROM InterlocutionReply WHERE node=" + node + " AND language=" + language + " ORDER BY backstatic DESC");
            while (db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration findgood(int node, int language) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id  FROM InterlocutionReply WHERE node=" + node + " AND language=" + language + "  and backstatic=1 ORDER BY backstatic DESC");
            while (db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    public static int count(int node, int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(id)  FROM InterlocutionReply WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,language,member,text,hidden,time,backstatic FROM InterlocutionReply WHERE id=" + id);
            if (db.next())
            {
                node = db.getInt(1);
                language = db.getInt(2);
                member = db.getString(3);
                text = db.getVarchar(language, language, 4);
                hidden = db.getInt(5) != 0;
                time = db.getDate(6);
                backstatic = db.getInt(7);
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

    public static void setBackstatic(int statics, int id, int integral, String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update InterlocutionReply set  backstatic = " + statics + " where id = " + id);
            if (db.next())
            {
                if (member != null && member.length() > 0)
                {
                    Profile probj = Profile.find(member);
                    probj.getIntegral();

                    if (integral > 0)
                    {
                        probj.setIntegral(integral + probj.getIntegral());
                    } else
                    {
                        probj.setIntegral(10 + probj.getIntegral());
                    }
                }
            }
        } finally
        {
            db.close();
        }
    }


    /**修改问答中心回复帖子的状态， 0 为其他答案，1为最佳答案***/
    public static void updateBack(int id, int backstatic, int nodeid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeUpdate("update InterlocutionReply set backstatic = " + backstatic + " where id =" + id + " and node=" + nodeid);

            db2.executeQuery("select id from  InterlocutionReply  where id =" + id);
            if (db2.next())
            {
                InterlocutionReply interobj = InterlocutionReply.find(id);
                interobj.setTime();
                Profile probj = Profile.find(interobj.getMember());

                Interlocution inter = Interlocution.find(interobj.node, interobj.language);
                Date dates = new Date();

                ///给成为最佳答案的会员帖子+10份 如果有悬赏的话 在加10份
                if (inter.getOfferintegral() > 0)
                {
                    probj.setIntegral(inter.getOfferintegral() + probj.getIntegral() + 10);
                   // IntegralCycle.create(interobj.getMember(), inter.getOfferintegral() + 10, dates, 3, probj.getCommunity());

                } else
                {
                    probj.setIntegral(10 + probj.getIntegral());
                   // IntegralCycle.create(interobj.getMember(), 10, dates, 3, probj.getCommunity());
                }
                inter.setNodestatic(1, interobj.getNode());

            }
        } finally
        {
            db2.close();
            db.close();
        }
    }

    /**判断是否有最佳答案,给出最佳答案的时候也就是结贴的时候***/
    public static boolean rebackstatic(int node, int id) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from InterlocutionReply where node =" + node + "and backstatic=1 ");
            if (db.next())
            {
                return false;
            } else
            {
                return true;
            }

        } finally
        {
            db.close();
        }
    }

    public void setTime() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update InterlocutionReply set time = " + db.citeCurTime() + " where id=" + id);
        } finally
        {
            db.close();
        }
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

    public int getId()
    {
        return id;
    }

    public String getMember()
    {
        return member;
    }

    public String getText()
    {
        return text;
    }

    public Date getTime()
    {
        return time;
    }

    public boolean isHidden()
    {
        return hidden;
    }

    public int getBackstatic()
    {
        return backstatic;
    }

    public String getTimeToString()
    {
        return sdf.format(time);
    }
}
