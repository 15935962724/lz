package tea.entity.node;

import java.sql.*;
import java.util.*;
import tea.entity.member.*;
import tea.db.*;
import tea.entity.*;

public class Caller extends Entity
{
    private String member;
    private String site;
    private int type;
    private boolean exists;
    private static Cache c = new Cache(100);

    private Caller(String member)
    {
        this.member = member;
        load();
    }

    public static Caller find(String member)
    {
        member = member.trim().toLowerCase();
        Caller caller = (Caller) c.get(member);
        if(caller == null)
        {
            caller = new Caller(member);
            c.put(member,caller);
        }
        return caller;
    }


    public Caller(String member,String site)
    {
        this.member = member;
        this.site = site;
        load();
    }

    //注册一个新的话务员
    public static void create(String member,int language,String site,String password,String mobile,String firstname,int sex,String community,int cardtype,String card,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = 0,j = 0,h = 0;
            i = db.executeUpdate("INSERT INTO caller (member,site,type,regdate) VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(site) + " ," + type + ", getDate())");
            if(i > 0)
            {
                if(password == null)
                {
                    j = db.executeUpdate("INSERT INTO Profile(member,password,mobile,sex,community,card,cardtype) VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite("1234") + "," + DbAdapter.cite(mobile) + "," + sex + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(card) + "," + cardtype + ")");
                } else
                {
                    j = db.executeUpdate("INSERT INTO Profile(member,password,mobile,sex,community,card,cardtype) VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(password) + "," + DbAdapter.cite(mobile) + "," + sex + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(card) + "," + cardtype + ")");
                }
            }
            if(j > 0)
            {
                h = db.executeUpdate("INSERT INTO ProfileLayer(member,language,firstname) VALUES(" + DbAdapter.cite(member) + "," + language + "," + DbAdapter.cite(firstname) + ")");
            }
            if(j < 0 || h < 0)
            {
                db.executeQuery("DELETE FROM caller WHERE member=" + DbAdapter.cite(member));
                db.executeUpdate("DELETE FROM Profile where member=" + DbAdapter.cite(member));
            }
            Caller call = new Caller(member);
            call.load();
        } finally
        {
            db.close();
        }
    }

    public static void update(String member,int language,String site,String password,String mobile,String firstname,int sex,String community,int cardtype,String card) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Caller call = new Caller(member);
        try
        {
            if(isExisted(member))
            {
                db.executeUpdate("UPDATE caller SET site=" + DbAdapter.cite(site) + "where member=" + DbAdapter.cite(member) + "");
                call.setSite(site);
                Profile p = Profile.find(member);
                p.setPassword(password);
                p.setSex(sex != 0);
                p.setCard(card);
                p.setCardType(cardtype);
                p.setFirstName(firstname,language);
                p.setMobile(mobile);
                //  new Profile().update(member,password,"",sex,card,cardtype,firstname,mobile,"",language);
            } else
            {
                create(member,language,site,password,mobile,firstname,sex,community,cardtype,card,0);
            }
        } finally
        {
            db.close();
        }
        call.load();
        System.out.println("Caller .getsite is : s" + call.getSite());
    }

//话务员审核

    public void set(int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update caller set type=" + type + " where member= " + db.cite(member));
        } finally
        {
            db.close();
        }
        this.type = type;
    }

    public static void uptype(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update caller set type=3 where member= " + db.cite(member));
        } finally
        {
            db.close();
        }

    }


    public static int count(String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Caller WHERE 1=1" + sql);
            if(db.next())
            {
                return i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public static Enumeration findcaller() throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member FROM caller");
            while(db.next())
            {
                String member = db.getString(1);
                String site = db.getString(2);
                Caller obj = Caller.find(member,site);
                v.addElement(obj);
            }
        } catch(Exception ex)
        {
            System.out.print(ex.toString());
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findbymember(String sql)
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT * FROM caller where 1=1=" + sql);
            while(db.next())
            {
                String member_1 = db.getString(1);
                String site = db.getString(2);
                Caller obj = Caller.find(member_1,site);
                v.addElement(obj);
            }
        } catch(Exception ex)
        {
            System.out.print(ex.toString());
        } finally
        {
            db.close();
        }
        return v.elements();

    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  member FROM Caller WHERE 1=1" + sql,pos,size);
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


    public static boolean isExisted(String member) throws SQLException
    {
        boolean flag = false;
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT member FROM caller WHERE member=").append(DbAdapter.cite(member));
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery(sb.toString());
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public static boolean isExistedType(String member) throws SQLException
    {
        boolean flag = false;
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT member FROM caller WHERE type = 1 and member=").append(DbAdapter.cite(member));
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery(sb.toString());
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }


    public static void delete(String member,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM caller where member=" + DbAdapter.cite(member) + "");
            db.executeUpdate("DELETE FROM Profile where member=" + DbAdapter.cite(member) + "");
            db.executeUpdate("DELETE FROM ProfileLayer where member=" + DbAdapter.cite(member) + " and language=" + language + "");
            db.executeUpdate("DELETE FROM AdminUsrRole WHERE member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }

    public static boolean isExist(String member) throws SQLException
    {
        boolean flag = false;
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT caller.member,Profile.member,ProfileLayer.member FROM caller,Profile,ProfileLayer WHERE caller.member=").append(DbAdapter.cite(member)).append("and Profile.member=").append(DbAdapter.cite(member)).append("and ProfileLayer.member=").append(DbAdapter.cite(member));
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery(sb.toString());
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public static boolean isExist(String member,String password) throws SQLException
    {
        boolean flag = false;
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT caller.member,Profile.member,Profile.password,ProfileLayer.member FROM caller,Profile,ProfileLayer WHERE caller.member=").append(DbAdapter.cite(member)).append("and Profile.member=").append(DbAdapter.cite(member)).append("and Profile.password=").append(DbAdapter.cite(password)).append("and ProfileLayer.member=").append(DbAdapter.cite(member));
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery(sb.toString());
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;

    }

    /**
     * find
     *
     * @param member String
     * @param name String
     * @return Caller
     */
    private static Caller find(String member,String site)
    {
        Caller obj = (Caller) c.get(member + ":" + site);
        if(obj == null)
        {
            //obj = new Hotel_application(memberid,nodeid,telephone,introduce,documents,firstname,password,cardtype,card,managertype);
            obj = new Caller(member,site);
            c.put(member + ":" + site,obj);
        }
        return obj;
    }

    public void load()
    {
        DbAdapter db = new DbAdapter();
        try
        {
            //添加一个sex字段
            db.executeQuery("SELECT caller.member,caller.site,Profile.password,caller.type FROM Caller,Profile WHERE caller.member=" + DbAdapter.cite(member));
            Profile pro = Profile.find(member);
            if(db.next())
            {
                member = db.getString(1);
                site = db.getString(2);
                pro.setPassword(member,pro.getPassword());
                type = db.getInt(4);
                exists = true;
            } else
            {
                exists = false;
            }

        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }

    }

    public String getMember()
    {
        load();
        return member;
    }

    public String getSite()
    {
        load();
        return site;
    }

    public void setMember(String member)
    {
        this.member = member;
    }

    public void setSite(String site)
    {
        this.site = site;
    }

    public int getType()
    {
        load();
        return type;
    }
}
