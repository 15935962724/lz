package tea.entity.bpicture;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;
import tea.db.*;
import tea.entity.*;

public class BkeyWord extends Entity
{
    private int id;
    private String wordname;
    private int fatherid;
    private int levelid;


    public BkeyWord(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static BkeyWord find(int id) throws SQLException
    {
        return new BkeyWord(id);
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,wordname,fatherid,levelid from BkeyWord where id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                wordname = db.getString(j++);
                fatherid = db.getInt(j++);
                levelid = db.getInt(j++);
            }
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findBykeyWord(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  id FROM BkeyWord WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public int getFatherid()
    {
        return fatherid;
    }

    public int getId()
    {
        return id;
    }

    public int getLevelid()
    {
        return levelid;
    }

    public String getWordname()
    {
        return wordname;
    }
}
