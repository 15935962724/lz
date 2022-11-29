package tea.entity.netdisk;

import java.sql.*;

import tea.db.*;
import tea.entity.*;

public class FileCenterSet extends Entity
{
    private static Cache _cache = new Cache(100);
    private String community;
    private int newday;
    private String filecenter;
    private int denysms; //不发送短信的文件夹
    private boolean exists;

    public static FileCenterSet find(String community) throws SQLException
    {
        FileCenterSet obj = (FileCenterSet) _cache.get(community);
        if(obj == null)
        {
            obj = new FileCenterSet(community);
            _cache.put(community,obj);
        }
        return obj;
    }

    public FileCenterSet(String community) throws SQLException
    {
        this.community = community;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT newday,filecenter,denysms FROM FileCenterSet WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                newday = db.getInt(1);
                filecenter = db.getString(2);
                denysms = db.getInt(3);
                exists = true;
            } else
            {
                newday = 30;
                filecenter = "/";
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public void set(int newday,String filecenter,int denysms) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE FileCenterSet SET newday=" + newday + ",filecenter=" + DbAdapter.cite(filecenter) + ",denysms=" + denysms + " WHERE community=" + DbAdapter.cite(community));
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO FileCenterSet(community,newday,filecenter,denysms)VALUES(" + DbAdapter.cite(community) + "," + newday + "," + DbAdapter.cite(filecenter) + "," + denysms + ")");
            }
        } finally
        {
            db.close();
        }
        this.newday = newday;
        this.filecenter = filecenter;
        this.denysms = denysms;
        this.exists = true;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM FileCenterSet WHERE community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
        _cache.remove(community);
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getNewday()
    {
        return newday;
    }

    public int getDenysms()
    {
        return denysms;
    }

    public String getFileCenter()
    {
        return filecenter;
    }

}
