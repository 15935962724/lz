package tea.entity.csvclub;

import java.sql.*;
import tea.db.DbAdapter;



public class Dogname
{
    private int id;
    private String cname;
    private String ename;
    private int sex;
    private int times;




    public Dogname(int id)throws SQLException
    {
        this.id=id;
        load();
    }
    public static Dogname find(int id)throws SQLException
    {
        return new Dogname(id);
    }
    public void load()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,ename,cname,sex,times from dogname where id="+id);
            if(db.next())
            {
                id=db.getInt(1);
                ename= db.getString(2);
                cname= db.getString(3);
                sex=db.getInt(4);
                times=db.getInt(5);
            }
            db.executeUpdate("Update dogname set times="+(times+1) + " where id="+id);
        } finally
        {
            db.close();
        }

    }

    public String getCname()
    {
        return cname;
    }

    public String getEname()
    {
        return ename;
    }

    public int getId()
    {
        return id;
    }

    public int getSex()
    {
        return sex;
    }

    public int getTimes()
    {
        return times;
    }

}
