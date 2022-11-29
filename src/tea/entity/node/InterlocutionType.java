package tea.entity.node;

import java.sql.*;

import tea.db.*;
import tea.entity.*;

public class InterlocutionType
{
    private static Cache _cache = new Cache(100);
    private int node;
    private int id;
    private String types;
    private boolean exists; // 是否存在

    public  static  InterlocutionType find(int id)throws SQLException
    {
        return new InterlocutionType(id);

    }
    public InterlocutionType(int id )throws SQLException
    {
        this.id=id;
        load();
    }

    private void load()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,node,types from InterlocutionType where id = "+id);

            if(db.next())
            {
                id = db.getInt(1);
                node = db.getInt(2);
                types = db.getString(3);
                exists = true;
            }
        }
        finally
        {
            db.close();
        }

    }

    public void create (int node ,String types) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into InterlocutionType (node,types) values ("+node+","+DbAdapter.cite(types)+" )");
        }
        finally
        {
            db.close();

        }
    }

    public void setTypes (String types)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update InterlocutionType set types = "+DbAdapter.cite(types)+ " where id ="+id );
        }
        finally
        {
            db.close();
        }

    }

    public void delete ()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from InterlocutionType where id ="+id );
        }
        finally
        {
            db.close();
        }

    }

    public static java.util.Enumeration findby(int node) throws SQLException
   {
       java.util.Vector vector = new java.util.Vector();
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("SELECT id  FROM InterlocutionType WHERE node="+node);
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

   public static java.util.Enumeration findall() throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id  FROM InterlocutionType");
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


    public String getTypes()
    {
        return types;
    }

    public int getId()
    {
        return id;
    }

    public int getNode()
    {
        return node;
    }
    public boolean isExists()
       {
           return exists;
    }

}
