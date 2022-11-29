package tea.entity.node;

import java.sql.*;

import tea.db.*;
import tea.entity.*;
import java.util.Vector;
import java.util.Enumeration;

public class ClassesChild extends Entity
{

    private int classc_id;//classc_id,class_id,community,name,language
    private int class_id;
    private String community;
    private String name;
    private int language;
    private boolean exists;

    public static ClassesChild find(int classc_id) throws SQLException
    {
        return new ClassesChild(classc_id);
    }

    public ClassesChild(int classc_id) throws SQLException
    {
        this.classc_id = classc_id;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select classc_id,class_id,community,name,language from  ClassesChild where classc_id=" + classc_id);
			if(db.next())
            {
                classc_id = db.getInt(1);
                class_id = db.getInt(2);
                community = db.getString(3);
                name = db.getString(4);
                language = db.getInt(5);
            }
        } finally
        {
			db.close();
        }
    }

	public static void set(int classc_id,int class_id,String community,String name,int language)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("select classc_id from ClassesChild where classc_id="+classc_id);
			if(db.next())
			{
				db.executeUpdate("Update ClassesChild set class_id="+class_id+",community="+db.cite(community)+",name="+db.cite(name)+",language="+language+"  where classc_id="+classc_id);
			}
			else
			{
				db.executeUpdate("Insert into ClassesChild (class_id,community,name,language)values("+class_id+","+db.cite(community)+","+db.cite(name)+","+language+")");
			}
		}
		finally
		{
			db.close();
		}
	}

	public static int count(String community ,String sql)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int count=0;
		try
		{
			db.executeQuery("select count(class_id) from ClassesChild where community="+db.cite(community)+"  "+sql.toString());
			if(db.next())
			{
				count=db.getInt(1);
			}
		}
		finally
		{
			db.close();
		}
		return count;
	}

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT classc_id FROM ClassesChild WHERE 1=1   " + sql,pos,size);
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

	public static boolean getfalg(int class_id,String name) throws SQLException
	{
        boolean falg = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select classc_id from ClassesChild where class_id=" + class_id + "  and name=" + db.cite(name));
            if(db.next())
            {
                falg = true;
            } else
            {
                falg = false;
            }
        } finally
        {
            db.close();
        }
        return falg;
    }

	public static void delete(int classc_id)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("delete ClassesChild where  classc_id="+classc_id);
		}
		finally
		{
			db.close();
		}
	}
    public int getClass_id()
    {
        return class_id;
    }

    public int getClassc_id()
    {
        return classc_id;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getName()
    {
        return name;
    }
}
