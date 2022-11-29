package tea.entity.admin;

import java.util.*;
import tea.entity.*;
import tea.db.*;
import java.sql.SQLException;

public class SubsidyTime
{
    private int startSubsidyMonth;
    private int stopSubsidyMonth;
    private int startPayoutMonth;
    private int stopPayoutMonth;
    private int startSfaccountMonth;
    private int stopSfaccountMonth;
    private int startMonth;
    private int stopMonth;
    private String community;
    private static tea.entity.Cache _cache = new tea.entity.Cache(100);
    public static java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MM-dd");
    private int startPayoutDay;
    private int startSfaccountDay;
    private int startSubsidyDay;
    private int stopPayoutDay;
    private int stopSfaccountDay;
    private int stopSubsidyDay;

    public SubsidyTime(String community) throws SQLException
    {
        this.community = community;
        load();
    }

    public static SubsidyTime find(String community) throws SQLException
    {
        SubsidyTime obj = (SubsidyTime) _cache.get(community);
        if(obj == null)
        {
            obj = new SubsidyTime(community);
            _cache.put(community,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeQuery("SELECT startsubsidymonth,startsubsidyday  ,stopsubsidymonth,stopsubsidyday   ,startpayoutmonth,startpayoutday   ,stoppayoutmonth,stoppayoutday    ,startsfaccountmonth,startsfaccountday,stopsfaccountmonth,stopsfaccountday ,startmonth    ,stopmonth      FROM SubsidyTime WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                startSubsidyMonth = db.getInt(1);
                startSubsidyDay = db.getInt(2);
                stopSubsidyMonth = db.getInt(3);
                stopSubsidyDay = db.getInt(4);
                startPayoutMonth = db.getInt(5);
                startPayoutDay = db.getInt(6);
                stopPayoutMonth = db.getInt(7);
                stopPayoutDay = db.getInt(8);
                startSfaccountMonth = db.getInt(9);
                startSfaccountDay = db.getInt(10);
                stopSfaccountMonth = db.getInt(11);
                stopSfaccountDay = db.getInt(12);
                startMonth = db.getInt(13);
                stopMonth = db.getInt(14);
                // this.exists = true;
            } else
            {
                // this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public int getStartSubsidyMonth()
    {
        return startSubsidyMonth;
    }

    public void set(int startSubsidyMonth,int startSubsidyDay,int stopSubsidyMonth,int stopSubsidyDay,int startPayoutMonth,int startPayoutDay,int stopPayoutMonth,int stopPayoutDay,int startSfaccountMonth,int startSfaccountDay,int stopSfaccountMonth,int stopSfaccountDay,int startMonth,int stopMonth) throws SQLException
    {
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            db.executeQuery("SELECT community  FROM SubsidyTime WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                db.executeUpdate("UPDATE SubsidyTime SET startsubsidymonth=" + (startSubsidyMonth) + ",startsubsidyday=" + (startSubsidyDay) + ",stopsubsidymonth=" + (stopSubsidyMonth) + ",stopsubsidyday=" + (stopSubsidyDay) + ",startpayoutmonth=" + (startPayoutMonth) + ",startpayoutday=" + (startPayoutDay) + ",stoppayoutmonth=" + (stopPayoutMonth) + ",stoppayoutday=" + (stopPayoutDay) + ",startsfaccountmonth=" + (startSfaccountMonth) + ",startsfaccountday=" + (startSfaccountDay)
                                 + ",stopsfaccountmonth=" + (stopSfaccountMonth) + ",stopsfaccountday=" + (stopSfaccountDay) + ",startmonth=" + startMonth + ",stopmonth=" + stopMonth + " WHERE community=" + DbAdapter.cite(community));
            } else
            {
                db.executeUpdate("INSERT INTO SubsidyTime(community,startsubsidymonth,startsubsidyday,stopsubsidymonth,stopsubsidyday,startpayoutmonth,startpayoutday,stoppayoutmonth,stoppayoutday,startsfaccountmonth,startsfaccountday,stopsfaccountmonth,stopsfaccountday,startmonth,stopmonth)VALUES(" + DbAdapter.cite(community) + "," + (startSubsidyMonth) + "," + (startSubsidyDay) + "," + (stopSubsidyMonth) + "," + (stopSubsidyDay) + "," + (startPayoutMonth) + "," + (startPayoutDay) + ","
                                 + (stopPayoutMonth) + "," + (stopPayoutDay) + "," + (startSfaccountMonth) + "," + (startSfaccountDay) + "," + (stopSfaccountMonth) + "," + (stopSfaccountDay) + "," + startMonth + "," + stopMonth + ")");
            }
        } finally
        {
            db.close();
        }
        this.startSubsidyMonth = startSubsidyMonth;
        this.startSubsidyDay = startSubsidyDay;
        this.stopSubsidyMonth = stopSubsidyMonth;
        this.stopSubsidyDay = stopSubsidyDay;
        this.startPayoutMonth = startPayoutMonth;
        this.startPayoutDay = startPayoutDay;
        this.stopPayoutMonth = stopPayoutMonth;
        this.stopPayoutDay = stopPayoutDay;
        this.startSfaccountMonth = startSfaccountMonth;
        this.startSfaccountDay = startSfaccountDay;
        this.stopSfaccountMonth = stopSfaccountMonth;
        this.stopSfaccountDay = stopSfaccountDay;
        this.startMonth = startMonth;
        this.stopMonth = stopMonth;
    }

    public int getStopSubsidyMonth()
    {
        return stopSubsidyMonth;
    }

    public int getStartPayoutMonth()
    {
        return startPayoutMonth;
    }

    public int getStopPayoutMonth()
    {
        return stopPayoutMonth;
    }

    public int getStartSfaccountMonth()
    {
        return startSfaccountMonth;
    }

    public int getStopSfaccountMonth()
    {
        return stopSfaccountMonth;
    }

    public int getStartMonth()
    {
        return startMonth;
    }

    public int getStopMonth()
    {
        return stopMonth;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getStartPayoutDay()
    {
        return startPayoutDay;
    }

    public int getStartSfaccountDay()
    {
        return startSfaccountDay;
    }

    public int getStartSubsidyDay()
    {
        return startSubsidyDay;
    }

    public int getStopPayoutDay()
    {
        return stopPayoutDay;
    }

    public int getStopSfaccountDay()
    {
        return stopSfaccountDay;
    }

    public int getStopSubsidyDay()
    {
        return stopSubsidyDay;
    }
}
