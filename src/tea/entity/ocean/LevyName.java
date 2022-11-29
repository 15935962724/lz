package tea.entity.ocean;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;


public class LevyName extends Entity
{
    private int id;
    private String community; //id,community,dolphin,bigprincess,littleprincess,firstname,sex,card,tel,type,addtime,member,verifydate
    private String dolphin;
    private String bigprincess;
    private String littleprincess;
    private String firstname;
    private int sex; //1 男 0 女
    private String card;
    private String tel;
    private int type;
    private Date addtime;
    private String member;
    private Date verifydate;
    private String moral;
    private boolean exists;

    public static LevyName find(int id) throws SQLException
    {
        return new LevyName(id);
    }

    public LevyName(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select community,dolphin,bigprincess,littleprincess,firstname,sex,card,tel,type,addtime,member,verifydate,moral from LevyName where id=" + id);
            if(db.next())
            {
                int j = 1;
                community = db.getString(j++);
                dolphin = db.getString(j++);
                bigprincess = db.getString(j++);
                littleprincess = db.getString(j++);
                firstname = db.getString(j++);
                sex = db.getInt(j++);
                card = db.getString(j++);
                tel = db.getString(j++);
                type = db.getInt(j++);
                addtime = db.getDate(j++);
                member = db.getString(j++);
                verifydate = db.getDate(j++);
                moral = db.getString(j++);
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

    public static void set(int id,String community,String dolphin,String bigprincess,String littleprincess,String firstname,int sex,String card,String tel,int type,Date addtime,String member,Date verifydate,String moral) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from LevyName where id=" + id);
            if(db.next())
            {
                db.executeUpdate("Update LevyName set  community=" + db.cite(community) + ",dolphin=" + db.cite(dolphin) + ",bigprincess=" + db.cite(bigprincess) + ",littleprincess=" + db.cite(littleprincess) + ",firstname=" + db.cite(firstname) + ",sex=" + sex + ",card=" + db.cite(card) + ",tel=" + db.cite(tel) + ",type=" + type + ",addtime=" + db.cite(addtime) + ",member=" + db.cite(member) + ",verifydate=" + db.cite(verifydate) + ",moral=" + db.cite(moral) + " where id=" + id);
            } else
            {
                db.executeUpdate("Insert into LevyName(community,dolphin,bigprincess,littleprincess,firstname,sex,card,tel,type,addtime,member,verifydate,moral)values(" + db.cite(community) + "," + db.cite(dolphin) + "," + db.cite(bigprincess) + "," + db.cite(littleprincess) + "," + db.cite(firstname) + "," + sex + "," + db.cite(card) + "," + db.cite(tel) + "," + type + "," + db.cite(addtime) + "," + db.cite(member) + "," + db.cite(verifydate) + "," + db.cite(moral) + ")");
            }
        } finally
        {
            db.close();
        }

    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeQuery("SELECT id FROM LevyName WHERE 1=1 " + sql);
            for(int i = 0;i < pos + size && db.next();i++)
            {
                if(i >= pos)
                {
                    v.addElement(db.getInt(1));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    public static int count(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("Select count(id) from LevyName where community=" + db.cite(community) + "   " + sql);
            if(db.next())
            {

                num = db.getInt(1);
                return num;
            } else
            {
                return num;
            }
        } finally
        {
            db.close();
        }
    }

    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeUpdate("delete LevyName where id=" + id);
        } finally
        {
            db.close();
        }
    }


    public Date getAddtime()
    {
        return addtime;
    }

    public String getBigprincess()
    {
        return bigprincess;
    }

    public String getCard()
    {
        return card;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getDolphin()
    {
        return dolphin;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getFirstname()
    {
        return firstname;
    }

    public int getId()
    {
        return id;
    }

    public String getLittleprincess()
    {
        return littleprincess;
    }

    public String getMember()
    {
        return member;
    }

    public int getSex()
    {
        return sex;
    }

    public String getTel()
    {
        return tel;
    }

    public int getType()
    {
        return type;
    }

    public Date getVerifydate()
    {
        return verifydate;
    }

    public String getMoral()
    {
        return moral;
    }

}
