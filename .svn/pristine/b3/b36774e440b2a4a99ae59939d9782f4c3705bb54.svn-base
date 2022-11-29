package tea.entity.volunteer;

import java.util.Date;
import tea.db.DbAdapter;
import java.util.Vector;
import java.sql.SQLException;
import java.util.Enumeration;
import tea.entity.Entity;

public class Volunteerinto extends Entity
{
    private int id; //id,month,name.sex,age,zhiye,city,model telephone,email,xuanyan
    private String name;
    private String month;
    private String xuanyan;
    private String sex;
    private String age;
    private String zhiye;
    private String city;
    private String model;
    private String telephone;
    private String email;
    private String F12;
    private String F13;
    private String F14;
    private String F15;
    private String F16;
    private String F17;
    private String F18;
    private String F19;
    private String F20;
    private String F21;

    public static Volunteerinto find(int id) throws SQLException
    {
        return new Volunteerinto(id);
    }

    public Volunteerinto(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,name,month,xuanyan,sex,age,zhiye,city,model,telephone,email,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21 from Volunteerinto where id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                name = db.getString(j++);
                month = db.getString(j++);
                xuanyan = db.getString(j++);
                sex = db.getString(j++);
                age = db.getString(j++);
                zhiye = db.getString(j++);
                city = db.getString(j++);
                model = db.getString(j++);
                telephone = db.getString(j++);
                email = db.getString(j++);
                F12 = db.getString(j++);
                F13 = db.getString(j++);
                F14 = db.getString(j++);
                F15 = db.getString(j++);
                F16 = db.getString(j++);
                F17 = db.getString(j++);
                F18 = db.getString(j++);
                F19 = db.getString(j++);
                F20 = db.getString(j++);
                F21 = db.getString(j++);
            }
        } finally //
        {
            db.close();
        }
    }


    public static Enumeration findByname(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);

        try
        {
            db.executeQuery("select id from Volunteerinto where  1=1  " + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select count(id) from  Volunteerinto  where  1=1 " + sql);
            if(db.next())
            {
                return db.getInt(1);
            } else
            {
                return 0;
            }
        } finally
        {
            db.close();
        }
    }

    public String getmonth()
    {
        return month;
    }

    public int getId()
    {
        return id;
    }

    public String getname()
    {
        return name;
    }

    public String getXuanyan()
    {
        return xuanyan;
    }

    public String getZhiye()
    {
        return zhiye;
    }

    public String getTelephone()
    {
        return telephone;
    }

    public String getSex()
    {
        return sex;
    }

    public String getModel()
    {
        return model;
    }

    public String getEmail()
    {
        return email;
    }

    public String getCity()
    {
        return city;
    }

    public String getAge()
    {
        return age;
    }

    public String getF12()
    {
        return F12;
    }

    public String getF13()
    {
        return F13;
    }

    public String getF14()
    {
        return F14;
    }

    public String getF15()
    {
        return F15;
    }

    public String getF16()
    {
        return F16;
    }

    public String getF17()
    {
        return F17;
    }

    public String getF18()
    {
        return F18;
    }

    public String getF19()
    {
        return F19;
    }

    public String getF20()
    {
        return F20;
    }

    public String getF21()
    {
        return F21;
    }
}
