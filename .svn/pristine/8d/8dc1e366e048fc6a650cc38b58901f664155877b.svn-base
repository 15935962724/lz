package tea.entity.admin;

import java.io.*;
import java.util.Date;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;

import java.text.*;

public class Leavec extends Entity
{
    private int leaid; // 主键ID
    private String cause;
    private Date time_k;
    private Date time_j;
    private int classs;
    private int unit;
    private int type;
    private String name; // 用户的Name
    private Date days;
    private String member;
    private int un;
    private int cl;
    private int leavetype;
    public static final String LEAVE_TYPE[] =
                                             //{"-----","年假","婚假","国内外出差","探亲假","加班不修假","缺勤","学习公派","病假","迟到","其他"};
    {"-----","年假","婚假","出差","探亲假","加班不休假","病假","事假","其他"};


    private boolean exists;
    private static Cache _cache = new Cache(100);

    public Leavec(int leaid) throws SQLException
    {
        this.leaid = leaid;
        load();
    }

    public static Leavec find(int leaid) throws SQLException
    {
        return new Leavec(leaid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select cause,time_k,time_j,classs,unit,type,name,days,member,un,cl,leavetype from Leavec where leaid =" + leaid);
            if(db.next())
            {
                cause = db.getVarchar(1,1,1);
                time_k = db.getDate(2);
                time_j = db.getDate(3);
                classs = db.getInt(4);
                unit = db.getInt(5);
                type = db.getInt(6);
                name = db.getVarchar(1,1,7);
                days = db.getDate(8);
                member = db.getVarchar(1,1,9);
                un = db.getInt(10);
                cl = db.getInt(11);
                leavetype = db.getInt(12);

                this.exists = true;
            } else
            {
                this.exists = false;
            }
        } catch(Exception e)
        {e.printStackTrace();
        }finally
        {
            db.close();
        }
    }

    public static int create(String cause,Date time_k,Date time_j,int classs,int unit,String name,String community,RV _rv,
    		int un,int cl,int leavetype,int type) throws SQLException
    {
        int id = 0;
        String dd = DutyClass.GetNowDate();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Leavec(cause,time_k,time_j,classs,unit,name,days,community,member,un,cl,leavetype,type) VALUES" +
            		"(" + DbAdapter.cite(cause) + "," + DbAdapter.cite(time_k) + "," + DbAdapter.cite(time_j) + "," + classs + "," + unit + "," +
            				"" + DbAdapter.cite(name) + "," + DbAdapter.cite(dd) + "," + DbAdapter.cite(community) + ",'" + _rv + "'," + un + "," +
            						"" + cl + "," + leavetype + ",0)");
            id = db.getInt("SELECT MAX(leaid) FROM Leavec");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public void set(String cause,Date time_k,Date times_j,int classs,int unit,String name,String member,int un,int cl,int leavetype) throws SQLException
    {
        int id = 0;
        String dd = DutyClass.GetNowDate();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Leavec set cause=" + DbAdapter.cite(cause) + ", time_k=" + DbAdapter.cite(time_k) + ",times_j=" + DbAdapter.cite(times_j) + ",classs=" + classs + "，unit=" + unit + ",name=" + DbAdapter.cite(name) + ",member=" + DbAdapter.cite(member) + ",un=" + un + ",cl=" + cl + ",leavetype=" + leavetype + "  where leaid=  " + leaid);
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByCommunity(String community,String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT l.leaid FROM Leavec l Left JOIN AdminUsrRole aur ON l.community=" + DbAdapter.cite(community) + " AND aur.community=" + DbAdapter.cite(community) + " AND l.member=aur.member WHERE 1=1" + sql);

            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } catch(Exception e)
        {e.printStackTrace();
        }
        finally
        {
            db.close();
        }
        return vector.elements();
    }


    public static void delete(int leaid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Leavec where leaid=" + leaid);
        } finally
        {
            db.close();
        }
    }

    public void settype() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Leavec SET type=2 WHERE leaid =" + leaid);
        } finally
        {
            db.close();
        }
    }

    public void settypes(int leatype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Leavec SET type=" + leatype + " WHERE leaid=" + leaid);
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
            db.executeUpdate("DELETE FROM Leavec WHERE leaid=" + leaid);
        } finally
        {
            db.close();
        }
    }

    public static void deletes() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Leavec");
        } finally
        {
            db.close();
        }
    }

    public String getCause()
    {
        return cause;
    }

    public Date getTime_k()
    {
        return time_k;
    }

    public String getTime_kToString()
    {
        if(time_k == null)
        {
            return "";
        }
        return sdf2.format(time_k);
    }

    public Date getTime_j()
    {
        return time_j;
    }

    public String getTime_jToString()
    {
        if(time_j == null)
        {
            return "";
        }
        return sdf2.format(time_j);
    }

    public int getType()
    {
        return type;
    }

    public String getName()
    {
        return name;
    }

    public int getUnid()
    {
        return unit;
    }

    public int getClasss()
    {
        return classs;
    }

    public Date getDays()
    {
        return days;
    }

    public String getMember()
    {
        return member;
    }

    public int getUn()
    {
        return un;
    }

    public int getCl()
    {
        return cl;
    }

    public int getLeavetype()
    {
        return leavetype;
    }
}
