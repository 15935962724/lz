package tea.entity.csvclub;

import java.math.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import java.util.*;

public class Csvleaveword extends Entity
{
    private int id;
    private String subject;
    private String content;
    private Date appear_time;
    private int type;
    private String ip;
    private String member;
    private String community;

    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Csvleaveword(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public Csvleaveword(String member, String community) throws SQLException
    {
        this.member = member;
        this.community = community;
        load_member();
    }

    public static Csvleaveword find(String member, String community) throws SQLException
    {
        return new Csvleaveword(member, community);
    }

    public static Csvleaveword find(int id) throws SQLException
    {
        return new Csvleaveword(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT subject,content,appear_time,type,ip,member FROM Csvleaveword WHERE id =" + id);
            if (db.next())
            {
                subject = db.getVarchar(1, 1, 1);
                content = db.getVarchar(1, 1, 2);
                appear_time = db.getDate(3);
                type = db.getInt(4);
                ip = db.getString(5);
                member = db.getVarchar(1, 1, 6);
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

    //通过member获取信息
    public void load_member() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  subject,content,appear_time,type,ip,member,id FROM Csvleaveword WHERE member =" + DbAdapter.cite(member) + " and community=" + DbAdapter.cite(community));
            if (db.next())
            {
                subject = db.getVarchar(1, 1, 1);
                content = db.getVarchar(1, 1, 2);
                appear_time = db.getDate(3);
                type = db.getInt(4);
                ip = db.getString(5);
                member = db.getVarchar(1, 1, 6);
                id = db.getInt(7);
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

    public static void create(String subject, String content, int type, String ip, String member, String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date appear_time = new Date();
        try
        {
            db.executeUpdate("insert into Csvleaveword (subject,content,type,ip,member,community,appear_time) values (" + DbAdapter.cite(subject) + "," + DbAdapter.cite(content) + "," + type + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(member) + " ," + DbAdapter.cite(community) + "," + DbAdapter.cite(appear_time) + ")");
        } finally
        {
            db.close();
        }
    }


    public void set(String subject, String content, int type, String ip) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date appear_time = new Date();
        try
        {
            db.executeUpdate("update Csvleaveword set  subject=" + DbAdapter.cite(subject) + ",content=" + DbAdapter.cite(content) + ",type=" + type + ",ip=" + DbAdapter.cite(ip) + ",appear_time=" + DbAdapter.cite(appear_time) + " where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public void detele() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Csvleaveword where id=" + id);
            db.executeUpdate("delete from Csvrevert where r_le_id=" + id); // 删除回复
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }


    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  id FROM Csvleaveword WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; l < pos + pageSize && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    int id = dbadapter.getInt(1);
                    vector.addElement(new Integer(id));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static int count(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(cs.id) FROM Csvleaveword cs WHERE cs.community=" + dbadapter.cite(community) + sql);
            if (dbadapter.next())
            {
                count = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return count;
    }

    public Date getAppear_time()
    {
        return appear_time;
    }

    public String getAppear_timetoString()
    {
        if (appear_time == null)
            return "";

        return sdf.format(appear_time);
    }

    public String getContent()
    {
        return content;
    }

    public String getIp()
    {
        return ip;
    }

    public String getMember()
    {
        return member;
    }

    public String getSubject()
    {
        return subject;
    }

    public int getType()
    {
        return type;
    }

    public int getId()
    {
        return id;
    }

    ///////////////////////-----------回复表Csvrevert中的--------------------------///////////////--------------
    private int r_id;
    private String r_content;
    private Date r_times;
    private String r_ip;
    private int r_le_id;
    private String r_member;

    public Csvleaveword(int r_id, String str) throws SQLException
    {
        this.r_id = r_id;
        r_load();
    }

    public static Csvleaveword findr(int r_id) throws SQLException
    {
        String str = "";
        return new Csvleaveword(r_id, str);
    }

    public void r_load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT r_content,r_times,r_ip,r_le_id,r_member FROM Csvrevert WHERE r_id =" + r_id);
            if (db.next())
            {
                r_content = db.getVarchar(1, 1, 1);
                r_times = db.getDate(2);
                r_ip = db.getString(3);
                r_le_id = db.getInt(4);
                r_member = db.getVarchar(1, 1, 5);
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

    public static void r_create(String r_content, String r_ip, int r_le_id, String r_member, String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date r_times = new Date();
        try
        {
            db.executeUpdate("insert into Csvrevert (r_content,r_times,r_ip,r_le_id,r_member,r_community) values (" + DbAdapter.cite(r_content) + "," + DbAdapter.cite(r_times) + "," + DbAdapter.cite(r_ip) + "," + r_le_id + "," + DbAdapter.cite(r_member) + " ," + DbAdapter.cite(community) + ")");
        } finally
        {
            db.close();
        }
    }

    public void r_detele() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Csvrevert where r_id=" + r_id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findBy_R(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  r_id FROM Csvrevert WHERE r_community=" + DbAdapter.cite(community) + sql);

            //for (int l = 0; dbadapter.next(); l++)
            //// {
            // if (l >= pos)
            // {
            while (dbadapter.next())
            {
                int id = dbadapter.getInt(1);
                vector.addElement(new Integer(id));
            }
            //  }
            // }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static int count_r(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(cs.r_id) FROM Csvrevert cs WHERE cs.r_community=" + dbadapter.cite(community) + sql);
            if (dbadapter.next())
            {
                count = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return count;
    }

    public String getR_Content()
    {
        return r_content;
    }

    public Date getR_Times()
    {
        return r_times;
    }

    public String getR_Ip()
    {
        return r_ip;
    }

    public int getR_Le_Id()
    {
        return r_le_id;
    }

    public String getR_Member()
    {
        return r_member;
    }
}
