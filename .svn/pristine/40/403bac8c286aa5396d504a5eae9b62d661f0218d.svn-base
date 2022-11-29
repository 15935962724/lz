package tea.entity.csvclub.testing;

import java.math.*;
import tea.db.*;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

public class CsvRundog_testing
{


    private int id;
    private int csvcompeteid;
    private String csvdogearid;
    private int apply_type;
    private int exes_type;
    private Date times;
    private String member;
    private int zubie;
    private int gilet;
    private String appraise; //评价
    private int place; //名次
    private int attack; //防扑咬
    private int family; //家族组
    private int doghouse; //犬舍组
    private int cause; //没有比赛的原因
    private int cancel; //是否退款
    private static Cache _cache = new Cache(100);
    private boolean exists;

    //组别
    public static final String GROUP[][] =
        {
        {"0", "幼小母犬组"},
        {"1", "成年公犬组"},
        {"2", "成年母犬组"},
        {"3", "青年公犬组"},
        {"4", "青年母犬组"},
        {"5", "幼年公犬组"},
        {"6", "幼年母犬组"},
        {"7", "幼大公犬组"},
        {"8", "幼大母犬组"},
        {"9", "幼小公犬组"},
        {"10", "暂无"},

    };
    //比赛成绩
    public static final String PLACE[] =
        {"-----", "VA", "V", "SG", "G", "VV", "V", "A", "U", "WV", "EZ"};
    public static final String CAUSE[] =
        {"------", "未来参赛", "退场", "请假"};
    //防扑咬
    public static final String ATTACK[] =
        {"没有参加", " 合格", "松口", "基本合格", "不松口", "不及格", "取消,由于不服从"};
    //通过表ID 获取数值 public CsvRundog_testing()
    // {


    public CsvRundog_testing(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static CsvRundog_testing find(int id) throws SQLException
    {
        return new CsvRundog_testing(id);
    }

    //根据表 csvcompeteid 获取数值
    public static CsvRundog_testing findse(int csvcompeteid, String str) throws SQLException
    {
        return new CsvRundog_testing(csvcompeteid, str);
    }

    public CsvRundog_testing(int csvcompeteid, String str) throws SQLException
    {
        this.csvcompeteid = csvcompeteid;
        loadse();
    }

    //根据member获取 数值
    public CsvRundog_testing(String member) throws SQLException
    {
        this.member = member;
        loadmember();
    }

    public static CsvRundog_testing findmember(String member) throws SQLException
    {
        return new CsvRundog_testing(member);
    }

    //根据csvdogearid获取数值
    public CsvRundog_testing(String csvdogearid, int a) throws SQLException
    {
        this.csvdogearid = csvdogearid;
        loadcsvdogearid();
    }

    public static CsvRundog_testing findearid(String csvdogearid) throws SQLException
    {
        int bb = 0;
        return new CsvRundog_testing(csvdogearid, bb);
    }

    public void loadcsvdogearid() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT csvcompeteid,csvdogearid,apply_type,exes_type,times,member,zubie,gilet,appraise,place,attack,family,doghouse FROM CsvRundog where csvdogearid=" + DbAdapter.cite(csvdogearid));
            if (db.next())
            {
                csvcompeteid = db.getInt(1);
                csvdogearid = db.getString(2);
                apply_type = db.getInt(3);
                exes_type = db.getInt(4);
                times = db.getDate(5);
                member = db.getVarchar(1, 1, 6);
                zubie = db.getInt(7);
                gilet = db.getInt(8);
                appraise = db.getVarchar(1, 1, 9);
                place = db.getInt(10);
                attack = db.getInt(11);
                family = db.getInt(12);
                doghouse = db.getInt(13);
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


    public void loadse() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT csvcompeteid,csvdogearid,apply_type,exes_type,times,member,zubie,gilet,appraise,place,attack,family,doghouse FROM CsvRundog where csvcompeteid=" + csvcompeteid);
            if (db.next())
            {
                csvcompeteid = db.getInt(1);
                csvdogearid = db.getString(2);
                apply_type = db.getInt(3);
                exes_type = db.getInt(4);
                times = db.getDate(5);
                member = db.getVarchar(1, 1, 6);
                zubie = db.getInt(7);
                gilet = db.getInt(8);
                appraise = db.getVarchar(1, 1, 9);
                place = db.getInt(10);
                attack = db.getInt(11);
                family = db.getInt(12);
                doghouse = db.getInt(13);
                exists = true;
            } else
            {
                exists = false;
            }
        } catch (Exception exception)
        {
            throw new SQLException(exception.toString());
        } finally
        {
            db.close();
        }
    }

    public void loadmember() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT csvcompeteid,csvdogearid,apply_type,exes_type,times,member,zubie,gilet FROM CsvRundog where member=" + DbAdapter.cite(member));
            if (db.next())
            {
                csvcompeteid = db.getInt(1);
                csvdogearid = db.getString(2);
                apply_type = db.getInt(3);
                exes_type = db.getInt(4);
                times = db.getDate(5);
                member = db.getVarchar(1, 1, 6);
                zubie = db.getInt(7);
                gilet = db.getInt(8);

                exists = true;
            } else
            {
                exists = false;
            }
        } catch (Exception exception)
        {
            throw new SQLException(exception.toString());
        } finally
        {
            db.close();
        }
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT csvcompeteid,csvdogearid,apply_type,exes_type,times,member,zubie,gilet,appraise,place,attack,family,doghouse,cause,cancel FROM CsvRundog where id=" + id);
            if (db.next())
            {
                csvcompeteid = db.getInt(1);
                csvdogearid = db.getString(2);
                apply_type = db.getInt(3);
                exes_type = db.getInt(4);
                times = db.getDate(5);
                member = db.getVarchar(1, 1, 6);
                zubie = db.getInt(7);
                gilet = db.getInt(8);
                appraise = db.getVarchar(1, 1, 9);
                place = db.getInt(10);
                attack = db.getInt(11);
                family = db.getInt(12);
                doghouse = db.getInt(13);
                cause = db.getInt(14);
                cancel = db.getInt(15);
                exists = true;
            } else
            {
                exists = false;
            }
        } catch (Exception exception)
        {
            throw new SQLException(exception.toString());
        } finally
        {
            db.close();
        }

    }


    public static void create(int csvcompeteid, String csvdogearid, int apply_type, int exes_type, String member, String community, int zubie) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into CsvRundog (csvcompeteid,csvdogearid,apply_type,exes_type,member,community,times,zubie) values (" + csvcompeteid + "," + DbAdapter.cite(csvdogearid) + "," + apply_type + "," + exes_type + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(times) + "," +
                             zubie + ")");
        } catch (Exception exception)
        {
            throw new SQLException(exception.toString());
        } finally
        {
            db.close();
        }
    }


    public static void set(int csvcompeteid, String csvdogearid, String member, String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update CsvRundog set csvdogearid=" + DbAdapter.cite(csvdogearid) + " where csvcompeteid=" + csvcompeteid + " and member=" + DbAdapter.cite(member) + " and community=" + DbAdapter.cite(community));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public int getApply_type()
    {
        return apply_type;
    }

    public int getCsvcompeteid()
    {
        return csvcompeteid;
    }

    public String getCsvdogearid()
    {
        return csvdogearid;
    }

    public int getExes_type()
    {
        return exes_type;
    }

    public String getMember()
    {
        return member;
    }

    public Date getTimes()
    {
        return times;
    }

    public int getZubie()
    {
        return zubie;
    }

    public int getGilet()
    {

        return gilet;
    }

    public String getAppraise()
    {
        return appraise;
    }

    public int getAttack()
    {
        return attack;
    }

    public int getDoghouse()
    {
        return doghouse;
    }

    public int getFamily()
    {
        return family;
    }

    public int getPlace()
    {
        return place;
    }

    public int getCause()
    {
        return cause;
    }

    public int getCancel()
    {
        return cancel;
    }


}
