package tea.entity.admin;

import java.io.*;
import java.util.Date;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.admin.Bulletin;
import java.sql.SQLException;

public class Applys extends Entity
{
    private int id;
    private int vehicle;
    private String chauffeur;
    private String man;
    private int unit;
    private Date times1;
    private Date times2;
    private String destination;
    private int mileage;
    private String findingmanid;
    private String attemper;
    private String cause;
    private String remark;
    private int type;
    private int uses;
    private String member;
    private Date times;

    private boolean exists;
    private static Cache _cache = new Cache(100);

    public Applys(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Applys find(int id) throws SQLException
    {
        return new Applys(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT vehicle,chauffeur,man,unit,times1,times2,destination,mileage,findingmanid,attemper,cause,remark,type,uses,member,times FROM Applys WHERE id =" + id);
            if(db.next())
            {
                vehicle = db.getInt(1);
                chauffeur = db.getVarchar(1,1,2);
                man = db.getVarchar(1,1,3);
                unit = db.getInt(4);
                times1 = db.getDate(5);
                times2 = db.getDate(6);
                destination = db.getVarchar(1,1,7);
                mileage = db.getInt(8);
                findingmanid = db.getVarchar(1,1,9);
                attemper = db.getVarchar(1,1,10);
                cause = db.getVarchar(1,1,11);
                remark = db.getVarchar(1,1,12);
                type = db.getInt(13);
                uses = db.getInt(14);
                member = db.getVarchar(1,1,15);
                times = db.getDate(16);
            } else
            {
                this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static int create(String vehicle,String chauffeur,String man,int unit,Date times1,Date times2,String destination,int mileage,String findingmanid,String attemper,String cause,String remark,int type,int uses,String community,RV _rv) throws SQLException
    {
        int id = 0;
        Date d = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Applys (vehicle,chauffeur,man,unit,times1,times2,destination,mileage,findingmanid,attemper,cause,remark,type,uses ,times,community,member)VALUES(" + DbAdapter.cite(vehicle) + "," + DbAdapter.cite(chauffeur) + "," + DbAdapter.cite(man) + "," + unit + "," + DbAdapter.cite(times1) + "," + DbAdapter.cite(times2) + "," + DbAdapter.cite(destination) + "," + mileage + "," + DbAdapter.cite(findingmanid) + "," + DbAdapter.cite(attemper) + "," + DbAdapter.cite(cause) + "," + DbAdapter.cite(remark) + "," + type + "," + uses + ","
                             + DbAdapter.cite(d) + "," + DbAdapter.cite(community) + ",'" + _rv + "')");
            id = db.getInt("SELECT MAX(id) FROM Applys");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public void set(String vehicle,String chauffeur,String man,int unit,Date times1,Date times2,String destination,int mileage,String findingmanid,String attemper,String cause,String remark,int type,int uses) throws SQLException
    {
        Date d = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Applys SET vehicle =" + DbAdapter.cite(vehicle) + ",chauffeur=" + DbAdapter.cite(chauffeur) + ",man=" + DbAdapter.cite(man) + ",unit=" + unit + ",times1=" + DbAdapter.cite(times1) + ",times2=" + DbAdapter.cite(times2) + ",destination=" + DbAdapter.cite(destination) + ",mileage=" + mileage + ",findingmanid=" + DbAdapter.cite(findingmanid) + ",attemper=" + DbAdapter.cite(attemper) + ",cause=" + DbAdapter.cite(cause) + ",remark=" + DbAdapter.cite(remark) + ",uses=" + uses + ",times=" + DbAdapter.cite(d) + "  WHERE id =" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));

    }

    public static java.util.Enumeration findByCommunity(String community,String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Applys WHERE community=" + DbAdapter.cite(community) + sql);

            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public void set(String types,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Applys SET " + types + "=" + type + " WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Applys WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

    public static int getCount(String community,int vehicle) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select count(id) from Applys where community = " + DbAdapter.cite(community) + " and vehicle=" + vehicle);
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;
    }

    public int getVehicle()
    {
        return vehicle;
    }

    public String getChauffeur()
    {
        return chauffeur;
    }

    public String getMan()
    {
        return man;
    }

    public int getUnit()
    {
        return unit;
    }

    public Date getTimes1()
    {
        return times1;
    }

    public Date getTimes2()
    {
        return times2;
    }

    public String getDestination()
    {
        return destination;
    }

    public int getMileage()
    {
        return mileage;
    }

    public String getFindingmanid()
    {
        return findingmanid;
    }

    public String getAttemper()
    {
        return attemper;
    }

    public String getCause()
    {
        return cause;
    }

    public String getRemark()
    {
        return remark;
    }

    public int getType()
    {
        return type;
    }

    public int getUses()
    {
        return uses;
    }

    public String getMember()
    {
        return member;
    }

    public Date getTimes()
    {
        return times;
    }

}
