package tea.entity.bpicture;


import java.sql.*;

import tea.db.*;
import tea.entity.*;


public class Blimit  extends  Entity
{
    private int id;
    private int node;
    private String territory;//
    private String country;
    private String image_use;
    private String image_details;
    private String product_industry;
    private String industry_details;
    private String showinfo;
    private boolean exists;
    public Blimit(int id)throws SQLException
    {
        this.id=id;
        load();
    }
    public static Blimit find(int id)throws SQLException
    {
        return new Blimit(id);
    }
    public void load()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select node,territory,country,image_use,image_details,product_industry,industry_details,showinfo from Blimit where id="+id);
            if(db.next())
            {
                int j=1;
                node = db.getInt(j++);
                territory = db.getString(j++);
                country = db.getString(j++);
                image_use = db.getString(j++);
                image_details = db.getString(j++);
                product_industry = db.getString(j++);
                industry_details = db.getString(j++);
                showinfo = db.getString(j++);
                exists = true;
            }
            else
            {
                exists=false;
            }

        }
        finally
        {
            db.close();
        }
    }

    public static void set(int id,int node,String territory,String country,String image_use,String image_details,String product_industry,String industry_details,String showinfo)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select * from Blimit where id="+id);
            if(db.next())
            {
                db.executeUpdate("Update Blimit set territory="+db.cite(territory)+",country="+db.cite(country)+",image_use="+db.cite(image_use)+",image_details="+db.cite(image_details)+",product_industry="+db.cite(product_industry)+",industry_details="+db.cite(industry_details)+",showinfo="+db.cite(showinfo)+" where id="+id);
            }
            else
            {
                db.executeUpdate("Insert into Blimit(node,territory,country,image_use,image_details,product_industry,industry_details,showinfo)values("+node+","+db.cite(territory)+","+db.cite(country)+","+db.cite(image_use)+","+db.cite(image_details)+","+db.cite(product_industry)+","+db.cite(industry_details)+","+db.cite(showinfo)+")");
            }
        }
        finally
        {
            db.close();
        }
    }

    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete Blimit where id=" + id);
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByCommunity(String community,String sql,int pos,int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Blimit WHERE  1=1 " + sql);
            for(int l = 0;l < pos + pageSize && db.next();l++)
            {
                if(l >= pos)
                {
                    vector.addElement(new Integer(db.getInt(1)));
                }
            }

        } finally
        {
            db.close();
        }
        return vector.elements();
    }
    public static int count(String community,String sql) throws SQLException
       {
           int count=0;
           DbAdapter db = new DbAdapter();
           try
           {
               db.executeQuery("SELECT count(id) FROM Blimit WHERE  1=1 " + sql);
               if(db.next())
               {
                   count=db.getInt(1);
               }

           } finally
           {
               db.close();
           }
           return count;
       }

    public String getCountry()
    {
        return country;
    }

    public int getId()
    {
        return id;
    }

    public String getImage_details()
    {
        return image_details;
    }

    public String getImage_use()
    {
        return image_use;
    }

    public String getIndustry_details()
    {
        return industry_details;
    }

    public int getNode()
    {
        return node;
    }

    public String getProduct_industry()
    {
        return product_industry;
    }

    public String getTerritory()
    {
        return territory;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getShowinfo()
    {
        return showinfo;
    }

}
