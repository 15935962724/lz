package tea.entity.node;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class VoteCarfare extends Entity
{
    private int vcid; // 主键id
    private int vottid; //票种的ID
    private int carfare; //票价
    private int ckcarfare; //和票价关联的ID号

    private boolean exist; //
    public VoteCarfare(int vcid) throws SQLException
    {
        this.vcid = vcid;
        load();
    }

    public static VoteCarfare find(int vcid) throws SQLException
    {
        return new VoteCarfare(vcid);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT vottid,carfare,ckcarfare FROM VoteCarfare WHERE vcid=" + vcid);
            if(db.next())
            {
                vottid = db.getInt(1);
                carfare = db.getInt(2);
                ckcarfare = db.getInt(3);

                exist = true;
            } else
            {
                exist = false;
            }
        } finally
        {
            db.close();
        }
    }
	public static int getVcid(int voteid,int prsubid)throws SQLException
	{
        DbAdapter db = new DbAdapter();
        int i = 0;
        try
        {
            db.executeQuery("select vcid from VoteCarfare where vottid=" + voteid + "  and ckcarfare=" + prsubid);
            if(db.next())
            {
                i = db.getInt(1);
            }

        } finally
        {
            db.close();
        }
        return i;

	}

    public static void create(int vottid,int carfare,int ckcarfare) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("INSERT INTO VoteCarfare(vottid,carfare,ckcarfare) VALUES(" + vottid + "," + carfare + "," + ckcarfare + ")");

        } finally
        {
            db.close();
        }

    }

    public void set(int vottid,int carfare,int ckcarfare) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("UPDATE VoteCarfare SET vottid=" + vottid + ",carfare=" + carfare + ",ckcarfare=" + ckcarfare + " WHERE vcid=" + vcid);
        } finally
        {
            db.close();
        }
        this.vottid = vottid;
        this.carfare = carfare;
        this.ckcarfare = ckcarfare;

    }


    public static Enumeration find(String sql,int pos,int size)
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT vcid FROM VoteCarfare WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
            }
        } catch(Exception exception3)
        {
            System.out.print(exception3);
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static void delete(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  VoteCarfare WHERE 1=1 " + sql.toString());
        } finally
        {
            db.close();
        }
    }

    public int getCarfare()
    {
        return carfare;
    }

    public int getCkcarfare()
    {
        return ckcarfare;
    }

    public boolean isExist()
    {
        return exist;
    }

    public int getVottid()
    {
        return vottid;
    }


}
