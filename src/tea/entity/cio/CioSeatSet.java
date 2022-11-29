package tea.entity.cio;

import java.sql.*;

import tea.db.*;
import tea.entity.*;
import java.util.Enumeration;
import java.util.Date;
import java.util.Vector;

public class CioSeatSet extends Entity
{
    private static Cache _cache = new Cache(100);
    private int id;
    private String sname; //接送人姓名
    private String stel; //接送人电话
    private boolean exists;

    public CioSeatSet(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public CioSeatSet(int id,String sname,String stel) throws SQLException
    {
        this.id = id;
        this.sname = sname;
        this.stel = stel;
        this.exists = true;
    }

    public static CioSeatSet find(int id) throws SQLException
    {
        CioSeatSet obj = (CioSeatSet) _cache.get(id);
        if(obj == null)
        {
            obj = new CioSeatSet(id);
            _cache.put(id,obj);
        }
        return obj;
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,sname,stel from CioClerk where id=" + id);
            if(db.next())
            {
                id = db.getInt(1);
                sname = db.getString(2);
                stel = db.getString(3);
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

    public static Enumeration sumRow1() throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select sumrow from CioClerk WHERE ciopart=0");
            while(db.next()){

                    v.add(db.getInt(1));
                }

        } finally
        {
            db.close();
        }
        return v.elements();
    }


   public static Enumeration noProSeat() throws SQLException
   {
       Vector v = new Vector();
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeQuery("Select seatrow,seatcol from cioseat WHERE ciopart!=0 ");
           while(db.next()){

                   v.add("new Array("+db.getInt(1)+","+db.getInt(2)+")");
               }

       } finally
       {
           db.close();
       }
       return v.elements();
   }



    public static void createSeat(int ciop,int row,int col) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Insert into  cioseat values(" + ciop + ",null,null,null,"+row+", "+col+")");
            db.executeUpdate("update ciopart set seat=1 where ciopart="+ciop);
        } finally
        {
            db.close();
        }
    }

    public static Enumeration fingSeat() throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select sumrow from cioseat WHERE ciopart=0 ");
            while(db.next()){

                    v.add(db.getString(1));
                }

        } finally
        {
            db.close();
        }
        return v.elements();
    }



    public static void updateSeat(int seatrow,int seatcol, String noseat)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update cioseat set sumrow="+seatrow+", sumcol="+seatcol+", notseat="+db.cite(noseat)+" where ciopart=0");
        }
        finally
        {
            db.close();
        }
    }

    public static void del(int del)throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("delete from cioseat where ciopart="+del);
       }
       finally
       {
           db.close();
       }
   }


    public static void upProSeat(int seatrow,int seatcol,int ciop)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update cioseat set seatrow="+seatrow+", seatcol="+seatcol+" where ciopart="+ciop);
        }
        finally
        {
            db.close();
        }
    }


    public static int sumCol()throws SQLException
    {
        int i=0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select sumcol from cioseat where ciopart=0;");
            while(db.next())
            {
                i = db.getInt(1);
            }
        }
        finally
        {
            db.close();
        }
        return i;
    }

    public static String notSeat()throws SQLException
    {
        String i="";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select notseat from cioseat where ciopart=0;");
            while(db.next())
            {
                i = db.getString(1);
            }
        }
        finally
        {
            db.close();
        }
        return i;
    }


    public static int sumRow()throws SQLException
    {
        int i=0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select sumrow from cioseat where ciopart=0;");
            while(db.next())
            {
                i = db.getInt(1);
            }
        }
        finally
        {
            db.close();
        }
        return i;
    }

    public static int seatRow(int ciop)throws SQLException
    {
        int i=0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select seatrow from cioseat where ciopart="+ciop);
            while(db.next())
            {
                i = db.getInt(1);
            }
        }
        finally
        {
            db.close();
        }
        return i;
    }
    public static int seatCol(int ciop)throws SQLException
    {
        int i=0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select seatcol from cioseat where ciopart="+ciop);
            while(db.next())
            {
                i = db.getInt(1);
            }
        }
        finally
        {
            db.close();
        }
        return i;
    }




    public boolean isExists()
    {
        return exists;
    }

    public int getId()
    {
        return id;
    }

    public String getSname()
    {
        return sname;
    }

    public String getStel()
    {
        return stel;
    }

}
