package tea.entity.csvclub;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Csvumpire extends Entity
{
    private int id;
    private String umpirename; //裁判的名字
    private int age; //年龄
    private int sex;
    private String nationality; //国籍
    private int grade;
    private String pic;
    private Date times;
    private String birth;

    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Csvumpire(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Csvumpire find(int id) throws SQLException
    {
        return new Csvumpire(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT umpirename,age,sex,nationality,grade,pic,times,birth FROM Csvumpire WHERE id =" + id);
            if (db.next())
            {
                umpirename = db.getVarchar(1, 1, 1);
                age = db.getInt(2);
                sex = db.getInt(3);
                nationality = db.getVarchar(1, 1, 4);
                grade = db.getInt(5);
                pic = db.getVarchar(1, 1, 6);
                times = db.getDate(7);
                birth = db.getString(8);
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

    public static void create(String umpirename, int age, int sex, String nationality, int grade, String pic, String community,String birth) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into Csvumpire (umpirename,age,sex,nationality,grade,pic,times,community,birth) values (" + DbAdapter.cite(umpirename) + "," + age + "," + sex + "," + DbAdapter.cite(nationality) + "," + grade + "," + DbAdapter.cite(pic) + "," + DbAdapter.cite(times) + "," + DbAdapter.cite(community) +","+ DbAdapter.cite(birth)+ " )");
        } finally
        {
            db.close();
        }
    }

    public void set(String umpirename, int age, int sex, String nationality, int grade, String pic,String birth) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvumpire set  umpirename=" + DbAdapter.cite(umpirename) + ",age=" + age + ",sex=" + sex + ",nationality=" + DbAdapter.cite(nationality) + ",grade=" + grade + ",pic=" + DbAdapter.cite(pic) +  ", birth="+DbAdapter.cite(birth)+" where id=" + id);
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
            db.executeUpdate("delete from Csvumpire where id=" + id);
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
            dbadapter.executeQuery("SELECT  id FROM Csvumpire WHERE community=" + DbAdapter.cite(community) + sql);

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

    public static java.util.Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  id FROM Csvumpire WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; dbadapter.next(); l++)
            {

                int id = dbadapter.getInt(1);
                vector.addElement(new Integer(id));

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
            dbadapter.executeQuery("SELECT COUNT(cs.id) FROM Csvumpire cs WHERE cs.community=" + dbadapter.cite(community) + sql);
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

    public String getUmpirename()
    {
        return umpirename;
    }

    public int getAge()
    {
        return age;
    }

    public int getSex()
    {
        return sex;
    }

    public String getNationality()
    {
        return nationality;
    }

    public int getGrade()
    {
        return grade;
    }

    public String getPic()
    {
        return pic;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getBirth()
    {
        return birth;
    }

    public String getBirthToString ()
    {
        if(birth==null)
        {
            return " ";
        }
        else
        {
            return Csvumpire.sdf.format(birth);
        }
    }


}
