package tea.entity.admin;

import java.sql.SQLException;
import java.text.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;

//上下班的登记表
public class DutyClass extends Entity
{
    private static Cache _cache = new Cache(100);
    private int did;
    private Date bookinday1;
    private Date bookinday2;
    private Date bookinday3;
    private Date bookinday4;
    private Date bookinday5;
    private Date bookinday6;
    private Date days;
    private String member;
    private boolean exists;

    public DutyClass(int did) throws SQLException
    {
        this.did = did;
        load();
    }

    public static DutyClass find(int did) throws SQLException
    {
        return new DutyClass(did);
    }

    public static DutyClass findByMember(String community, String member) throws SQLException
    {
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(System.currentTimeMillis());
        c.set(11, 0);
        c.set(12, 0);
        c.set(13, 0);
        c.set(14, 0);
        int did = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT did FROM DutyClass WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member) + " AND days=" + DbAdapter.cite(c.getTime()));
            if (db.next())
            {
                did = db.getInt(1);
            } else
            {
                db.executeUpdate("INSERT INTO DutyClass(community,member,days) VALUES(" + DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(c.getTime()) + ")");
                did = db.getInt("SELECT MAX(did) FROM DutyClass");
            }
        } finally
        {
            db.close();
        }
        return find(did);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT bookinday1,bookinday2,bookinday3,bookinday4,bookinday5,bookinday6,days,member FROM DutyClass WHERE did =" + did);
            if (db.next())
            {
                bookinday1 = db.getDate(1);
                bookinday2 = db.getDate(2);
                bookinday3 = db.getDate(3);
                bookinday4 = db.getDate(4);
                bookinday5 = db.getDate(5);
                bookinday6 = db.getDate(6);
                days = db.getDate(7);
                member = db.getString(8);
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

    public void set(String bookin, String community, RV _rv) throws SQLException
    {
        Date d = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE DutyClass SET " + bookin + " =" + DbAdapter.cite(d) + " ,community=" + DbAdapter.cite(community) + ",member='" + _rv + "'   WHERE did =" + did);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(did));
    }

    public void set(String b1, String b2, String b3, String b4, String b5, String b6) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE DutyClass SET bookinday1=" + DbAdapter.cite(b1) + ",bookinday2=" + DbAdapter.cite(b2) + ",bookinday3=" + DbAdapter.cite(b3) + ",bookinday4=" + DbAdapter.cite(b4) + ",bookinday5=" + DbAdapter.cite(b5) + ", bookinday6=" + DbAdapter.cite(b6) + " WHERE did =" + did);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(did));
    }

    public static String GetNowDate()
    {
        String temp_str = "";
        Date dt = new Date();
        // 最后的aa表示“上午”或“下午” HH表示24小时制 如果换成hh表示12小时制
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        temp_str = sdf.format(dt);
        return temp_str;
    }

    public static String GetNowTime()
    {
        String temp_str = "";
        Date dt = new Date();
        // 最后的aa表示“上午”或“下午” HH表示24小时制 如果换成hh表示12小时制
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        temp_str = sdf.format(dt);
        return temp_str;
    }

    public static String GetDay(String day) throws ParseException
    {
        DateFormat format = new SimpleDateFormat("yy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.setTime(format.parse(day));
        int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - 1;
        String resultString = "";
        switch (dayOfWeek)
        {
        case 0:
            resultString = "日"; // wednesday
            break;
        case 1:
            resultString = "一"; // sunday
            break;
        case 2:
            resultString = "二"; // monday
            break;
        case 3:
            resultString = "三"; // tuesday
            break;
        case 4:
            resultString = "四"; // thursday
            break;
        case 5:
            resultString = "五"; // saturday
            break;
        case 6:
            resultString = "六"; // friday
            break;
        default:
            resultString = "Error   Date";
            break;
        }
        return resultString;

    }

    public String parseDate(String thedate)
    {
        String strReturn = "";
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyyMMdd");
        String dateStringToParse = thedate;
        try
        {
            Date date = bartDateFormat.parse(dateStringToParse);
            SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd EEEE");
            strReturn = bartDateFormat2.format(date);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }

        return strReturn;
    }

    public static Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT did FROM DutyClass WHERE community=" + DbAdapter.cite(community) + sql);
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

    public static Enumeration findBy(String community, String sql) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select distinct member from DutyClass WHERE community=" + DbAdapter.cite(community) + sql);

            while (db.next())
            {
                vector.addElement(String.valueOf(db.getVarchar(1, 1, 1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static int getCou(String community, String member, int gdtimeid, String gdtime3, String gdtime5, int cou, String sql) throws SQLException, ParseException
    {

        int i = 0;
        DateFormat format = new SimpleDateFormat("HH:mm");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select bookinday1,bookinday2,bookinday3,bookinday4,bookinday5,bookinday6 from DutyClass where community=" + DbAdapter.cite(community) + " and member =" + DbAdapter.cite(member) + sql);

            while (db.next())
            {

                Enumeration au_e = RankClass.findByCommunity(community, "");
                RankClass raobj = RankClass.find(gdtimeid);
                if (db.getDate(1) != null &&  raobj.getEnrol1()!=null && raobj.getEnrol1().length() > 0) // 对上班的迟到次数统计
                {
                    Date a1 = format.parse(raobj.getEnrol1());
                    Date b1 = format.parse(db.getDate(1).toString().substring(10, 16));
                    if (cou == 13)
                    {
                        if (a1.compareTo(b1) == -1)
                        {
                            i++;
                        }
                    }
                    if (db.getDate(3) != null && raobj.getEnrol3()!=null && raobj.getEnrol3().length() > 0)
                    {
                        Date a3 = format.parse(raobj.getEnrol3());
                        Date b3 = format.parse(db.getDate(3).toString().substring(10, 16));
                        if (cou == 13)
                        {
                            if (a3.compareTo(b3) == -1)
                            {
                                i++;
                            }
                        }
                        if (db.getDate(5) != null &&  raobj.getEnrol5() !=null && raobj.getEnrol5().length() > 0)
                        {
                            Date a5 = format.parse(raobj.getEnrol5());
                            Date b5 = format.parse(db.getDate(5).toString().substring(10, 16));
                            if (cou == 13)
                            {
                                if (a5.compareTo(b5) == -1)
                                {
                                    i++;
                                }
                            }
                        }
                    }

                }
                if ((raobj.getEnrol5()!=null && raobj.getEnrol5().length() > 0) & raobj.getEnrol6()!=null && raobj.getEnrol6().length() > 0)
                { // 对上下班未登记的次数统计
                    if (db.getDate(1) == null)
                    {
                        if (cou == 0)
                        {
                            i++;
                        }
                    }
                    if (db.getDate(3) == null)
                    {
                        if (cou == 0)
                        {
                            i++;
                        }
                    }
                    if (db.getDate(5) == null)
                    {
                        if (cou == 0)
                        {
                            i++;
                        }
                    }
                    if (db.getDate(2) == null)
                    {
                        if (cou == 4)
                        {
                            i++;
                        }
                    }
                    if (db.getDate(4) == null)
                    {
                        if (cou == 4)
                        {
                            i++;
                        }
                    }
                    if (db.getDate(6) == null)
                    {
                        if (cou == 4)
                        {
                            i++;
                        }
                    }
                } else
                {
                    if (db.getDate(1) == null)
                    {
                        if (cou == 0)
                        {
                            i++;
                        }
                    }
                    if (db.getDate(3) == null)
                    {
                        if (cou == 0)
                        {
                            i++;
                        }
                    }
                    if (db.getDate(2) == null)
                    {
                        if (cou == 4)
                        {
                            i++;
                        }
                    }
                    if (db.getDate(4) == null)
                    {
                        if (cou == 4)
                        {
                            i++;
                        }
                    }
                }

                if (db.getDate(2) != null && raobj.getEnrol2() !=null && raobj.getEnrol2().length() > 0) // 对下班早退的统计
                {
                    Date a2 = format.parse(raobj.getEnrol2());
                    Date b2 = format.parse(db.getDate(2).toString().substring(10, 16));
                    if (cou == 246)
                    {
                        if (a2.compareTo(b2) == 1)
                        {
                            i++;
                        }
                    }
                    if (db.getDate(4) != null && raobj.getEnrol4()!=null &&  raobj.getEnrol4().length() > 0)
                    {
                        Date a4 = format.parse(raobj.getEnrol4());
                        Date b4 = format.parse(db.getDate(4).toString().substring(10, 16));
                        if (cou == 246)
                        {
                            if (a4.compareTo(b4) == 1)
                            {
                                i++;
                            }
                        }
                        if (db.getDate(6) != null && raobj.getEnrol6()!=null &&  raobj.getEnrol6().length() > 0)
                        {
                            Date a6 = format.parse(raobj.getEnrol6());
                            Date b6 = format.parse(db.getDate(6).toString().substring(10, 16));
                            if (cou == 246)
                            {
                                if (a6.compareTo(b6) == 1)
                                {
                                    i++;
                                }
                            }
                        }
                    }
                }

            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public static void deleteAll() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM DutyClass");
        } finally
        {
            db.close();
        }
    }

    /*
     * public static int getCou2(String community,String member,String gdtime,String gdtime2,int cou,int cou2,String sql) throws SQLException, ParseException {
     *
     * int i = 0; DateFormat format = new SimpleDateFormat("HH:mm"); DbAdapter db = new DbAdapter(); try { db.executeQuery("select bookinday1,bookinday2,bookinday1,bookinday4,bookinday5,bookinday6 from DutyClass where community="+DbAdapter.cite(community)+" and member ="+DbAdapter.cite(member)+sql); while(db.next()){
     *
     * Date a = format.parse(gdtime);//规定的时间 Date a2 = format.parse(gdtime2); Date b = format.parse(db.getDate(cou).toString().substring(10,16)); //员工上下班时间 Date b2 = format.parse(db.getDate(cou2).toString().substring(10,16)); if(a.compareTo(b)==1 || a2.compareTo(b2) == 1) { i++; } }} finally { db.close(); } return i; }
     */
    public Date getBinday1()
    {
        return bookinday1;
    }

    public Date getBinday2()
    {
        return bookinday2;
    }

    public Date getBinday3()
    {
        return bookinday3;
    }

    public Date getBinday4()
    {
        return bookinday4;
    }

    public Date getBinday5()
    {
        return bookinday5;
    }

    public Date getBinday6()
    {
        return bookinday6;
    }

    public Date getDays()
    {
        return days;
    }

    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }
}
