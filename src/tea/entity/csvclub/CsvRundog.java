package tea.entity.csvclub;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class CsvRundog extends Entity
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
    private int place; //级别
    private int attack; //防为扑咬
    private int family; //家族组
    private int doghouse; //犬舍组
    private int cause; //没有比赛的原因
    private int cancel; //是否退款
    private String blood; //血统证书号
    private int placenum; //比赛名次
    private int avgs; //预估的名次
    private int avg_play; //成绩预估
    private String dog_pic; //犬只赛事图片
    private int tracknum;//订单编号

    /**
     *2008年5月30日16:36:18
     * */
    private String membercharge;//缴费会员ID
    private String remark;//备注

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
            {"-----", "VA", "V", "SG", "G", "A", "U", "EZ", "T1", "T2", "T3", "T4"}; //1,2本部展
    public static final String PLACE_A[] =
            {"-----", "SG", "G", "A", "U", "EZ"}; ///3，4,5，6
    public static final String PLACE_B[] =
            {"-----", "VV", "V", "A", "U", "WV", "EZ"}; ///7，8,9,0
    public static final String PLACE_C[] =
            {"-----", "V", "SG", "G", "A", "U", "EZ"}; ///1，2


    public static final String CAUSE[] =
            {"------", "未来参赛", "退场", "请假"};
    //防扑咬
    public static final String ATTACK[] =
            {"没有参加", " 合格", "松口", "基本合格", "不松口", "不及格", "取消,由于不服从","暂无"};
    //通过表ID 获取数值
    public CsvRundog(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static CsvRundog find(int id) throws SQLException
    {
        return new CsvRundog(id);
    }

    //根据表 csvcompeteid 获取数值
    public static CsvRundog findse(int csvcompeteid, String str) throws SQLException
    {
        return new CsvRundog(csvcompeteid, str);
    }

    public CsvRundog(int csvcompeteid, String str) throws SQLException
    {
        this.csvcompeteid = csvcompeteid;
        loadse();
    }

    //根据member获取 数值
    public CsvRundog(String member) throws SQLException
    {
        this.member = member;
        loadmember();
    }

    //根据csvdogearid获取数值
    public CsvRundog(String csvdogearid, int a) throws SQLException
    {
        this.csvdogearid = csvdogearid;
        loadcsvdogearid();
    }

    public CsvRundog(String member, int csvcompeteid, int a) throws SQLException
    {
        this.member = member;
        this.csvcompeteid = csvcompeteid;
        loadmembercode();
    }

    public static CsvRundog findmember(String member) throws SQLException
    {
        return new CsvRundog(member);
    }

    public static CsvRundog findmembercode(String member, int csvcompeteid) throws SQLException
    {
        return new CsvRundog(member, csvcompeteid, 1);
    }

    public static CsvRundog findearid(String csvdogearid) throws SQLException
    {
        int bb = 0;
        return new CsvRundog(csvdogearid, bb);
    }


    public static CsvRundog findearid_all(String csvdogearid, int csvcompeteid, String xx) throws SQLException
    {
        return new CsvRundog(csvdogearid, csvcompeteid, xx);
    }

    public CsvRundog(String csvdogearid, int csvcompeteid, String xx) throws SQLException
    {
        this.csvcompeteid = csvcompeteid;
        this.csvdogearid = csvdogearid;

        loadmembercode();
    }


    public void loadcsvdogearid() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT csvcompeteid,csvdogearid,apply_type,exes_type,times,member,zubie,gilet,appraise,place,attack,family,doghouse,placenum,blood,avgs,avg_play,tracknum,membercharge,remark FROM CsvRundog where csvdogearid=" + DbAdapter.cite(csvdogearid));
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
                placenum = db.getInt(14);
                blood = db.getString(15);
                avgs = db.getInt(16);
                avg_play = db.getInt(17);
                tracknum = db.getInt(18);
                membercharge=db.getString(19);//,membercharge,remark
                remark=db.getString(20);
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


    public void loadcsvdogearid_front() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT csvcompeteid,csvdogearid,apply_type,exes_type,times,member,zubie,gilet,appraise,place,attack,family,doghouse,placenum,blood,avgs,avg_play,tracknum,membercharge,remark FROM CsvRundog where csvdogearid=" + DbAdapter.cite(csvdogearid) + " and csvcompeteid=" + csvcompeteid);
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
                placenum = db.getInt(14);
                blood = db.getString(15);
                avgs = db.getInt(16);
                avg_play = db.getInt(17);
                tracknum = db.getInt(18);
                membercharge=db.getString(19);//,membercharge,remark
                remark=db.getString(20);
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
            db.executeQuery("SELECT csvcompeteid,csvdogearid,apply_type,exes_type,times,member,zubie,gilet,appraise,place,attack,family,doghouse,placenum,blood,avgs,avg_play,tracknum,membercharge,remark FROM CsvRundog where csvcompeteid=" + csvcompeteid);
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
                placenum = db.getInt(14);
                blood = db.getString(15);
                avgs = db.getInt(16);
                avg_play = db.getInt(17);
                tracknum = db.getInt(18);
                membercharge=db.getString(19);//,membercharge,remark
                remark=db.getString(20);
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

    public void loadmember() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT csvcompeteid,csvdogearid,apply_type,exes_type,times,member,zubie,gilet,placenum,blood,avgs,avg_play,tracknum,membercharge,remark FROM CsvRundog where member=" + DbAdapter.cite(member));
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
                placenum = db.getInt(9);
                blood = db.getString(10);
                avgs = db.getInt(11);
                avg_play = db.getInt(12);
                tracknum = db.getInt(13);
                membercharge=db.getString(14);//,membercharge,remark
                remark=db.getString(15);
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

    public void loadmembercode() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT csvcompeteid,csvdogearid,apply_type,exes_type,times,member,zubie,gilet,placenum,blood,avgs,avg_play,tracknum,membercharge,remark FROM CsvRundog where member=" + DbAdapter.cite(member) + " and csvcompeteid=" + csvcompeteid);
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
                placenum = db.getInt(9);
                blood = db.getString(10);
                avgs = db.getInt(11);
                avg_play = db.getInt(12);
                tracknum = db.getInt(13);
                membercharge=db.getString(14);//,membercharge,remark
                remark=db.getString(15);
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


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT csvcompeteid,csvdogearid,apply_type,exes_type,times,member,zubie,gilet,appraise,place,attack,family,doghouse,cause,cancel,placenum,blood,avgs,avg_play,dog_pic,tracknum,membercharge,remark FROM CsvRundog where id=" + id);
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
                placenum = db.getInt(16);
                blood = db.getString(17);
                avgs = db.getInt(18);
                avg_play = db.getInt(19);
                dog_pic = db.getString(20);
                tracknum = db.getInt(21);
                membercharge=db.getString(22);//,membercharge,remark
                remark=db.getString(23);
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


    public static void create(int csvcompeteid, String csvdogearid, int apply_type, int exes_type, String member, String community, int zubie, String blood,int tracknum,String membercharge) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into CsvRundog (csvcompeteid,csvdogearid,apply_type,exes_type,member,community,times,zubie,blood,tracknum,membercharge) values (" + csvcompeteid + "," + DbAdapter.cite(csvdogearid) + "," + apply_type + "," + exes_type + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(times) + "," + zubie + "," + DbAdapter.cite(blood) + ","+tracknum+","+DbAdapter.cite(membercharge)+")");
        } finally
        {
            db.close();
        }
    }

    public void set(int csvcompeteid, String csvdogearid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update CsvRundog set  csvcompeteid=" + csvcompeteid + ",csvdogearid=" + DbAdapter.cite(csvdogearid) + " where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public void set(int zubie) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update CsvRundog set  zubie=" + zubie + " where id=" + id);

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public static void set(String member, String community, int type, int csvcompeteid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update CsvRundog set  exes_type=" + type + " where member=" + DbAdapter.cite(member) + " and community=" + DbAdapter.cite(community) + " and csvcompeteid=" + csvcompeteid);

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public static void setExes_type( int type,int id) throws SQLException
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("update CsvRundog set  exes_type=" + type + " where  id ="+id);

            } catch (Exception ex)
            {
                throw new SQLException(ex.toString());
            } finally
            {
                db.close();
            }
        }

    public static void set_code(String community, int csvcompeteid, int gilet, int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update CsvRundog set gilet =" + gilet + "  where  community =" + DbAdapter.cite(community) + " and csvcompeteid=" + csvcompeteid + " and id=" + id);

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    //给没有参赛的犬添加原因set_no
    public void set_no(int cause, int cancel) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update CsvRundog set cause =" + cause + ",cancel=" + cancel + "  where   id=" + id);

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
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

    public void detele() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from CsvRundog where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    //使关于赛事的记录 保存最后一次
    public static void detele(int csvcompeteid, String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from CsvRundog where csvcompeteid=" + csvcompeteid + " and member=" + DbAdapter.cite(member));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM CsvRundog WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; l < pos + pageSize && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    int id = dbadapter.getInt(1);
                    vector.addElement(new Integer(id));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration findBy(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  distinct(member) FROM CsvRundog WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; l < pos + pageSize && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    String member = dbadapter.getVarchar(1, 1, 1);
                    vector.addElement(String.valueOf(member));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    //*********04 月  03*******//

    public static java.util.Enumeration find_front_dog(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  csvdogearid FROM CsvRundog WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; l < pos + pageSize && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    String earid = dbadapter.getVarchar(1, 1, 1);
                    vector.addElement(String.valueOf(earid));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }


    //***************************88//
     public static java.util.Enumeration findBymemony(String community, String sql, int pos, int pageSize) throws SQLException
     {
         java.util.Vector vector = new java.util.Vector();
         DbAdapter dbadapter = new DbAdapter();
         try
         {
             dbadapter.executeQuery("SELECT  distinct(member),csvcompeteid FROM CsvRundog WHERE community=" + DbAdapter.cite(community) + sql);

             for (int l = 0; l < pos + pageSize && dbadapter.next(); l++)
             {
                 if (l >= pos)
                 {
                     String member = dbadapter.getString(1);
                     String csvcompeteid = dbadapter.getString(2);
                     vector.addElement(new String[]
                                       {member, csvcompeteid});
                 }
             }
         } finally
         {
             dbadapter.close();
         }
         return vector.elements();
     }


    public static java.util.Enumeration findByCsvcompeteid(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  distinct(csvcompeteid) FROM CsvRundog WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    int csvcompeteid = dbadapter.getInt(1);
                    vector.addElement(new Integer(csvcompeteid));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM CsvRundog WHERE community=" + DbAdapter.cite(community) + sql);

            while (dbadapter.next())
            {
                vector.addElement(new Integer(dbadapter.getInt(1)));
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration findByblood(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT blood FROM CsvRundog WHERE community=" + DbAdapter.cite(community) + sql);

            while (dbadapter.next())
            {
                String blood = dbadapter.getVarchar(1, 1, 1);
                vector.addElement(String.valueOf(blood));
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static int count(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(distinct(member)) FROM CsvRundog WHERE community=" + dbadapter.cite(community) + sql);
            if (dbadapter.next())
            {
                count = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return count;
    }

    public static int count_id(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM Csvcompete cs WHERE cs.community=" + dbadapter.cite(community) + " and times = (select max(times) from Csvcompete where community=" + dbadapter.cite(community) + ")");
            if (dbadapter.next())
            {
                count = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return count;
    }

    //通过用户显示狗的数目
    public static int countdog(String community, String sql, String member) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(cs.id) FROM CsvRundog cs WHERE cs.community=" + dbadapter.cite(community) + " and cs.member =" + dbadapter.cite(member) + sql);
            //System.out.print("SELECT COUNT(cs.id) FROM CsvRundog cs WHERE cs.community=" + dbadapter.cite(community) + " and cs.member =" + dbadapter.cite(member) + sql);

            if (dbadapter.next())
            {
                count = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return count;
    }

    //通过赛事显示狗的数目
    public static int countrundog(String community, String sql) throws SQLException
    {
        int count = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(cs.id) FROM CsvRundog cs WHERE cs.community=" + dbadapter.cite(community) + sql);

            if (dbadapter.next())
            {
                count = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return count;
    }

    //判断服务是否申请过
    public static boolean isExisted(int csvcompeteid, String member, String community) throws SQLException
    {
        boolean flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT id FROM CsvRundog WHERE community = " + dbadapter.cite(community) + " and csvcompeteid =" + csvcompeteid + " and member=" + DbAdapter.cite(member));

            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

//		  ------------------------------判断狗的组别-------------------------------///--------------------------//
    public static int getBrigade(Date times, int se, Date time_k) throws SQLException
    {

        String sex = "";
        //Date date = new Date();
        //if(se==0){sex="公";}
        //if(se==1){sex="母";}

        /** {"0", "幼小母犬组"},
            {"1", "成年公犬组"},
            {"2", "成年母犬组"},
            {"3", "青年公犬组"},
            {"4", "青年母犬组"},
            {"5", "幼年公犬组"},
            {"6", "幼年母犬组"},
            {"7", "幼大公犬组"},
            {"8", "幼大母犬组"},
            {"9", "幼小公犬组"},

         *
         * ***/

        Calendar calendar = Calendar.getInstance();

        calendar.setTime(time_k);
        long timethis = calendar.getTimeInMillis();

        calendar.setTime(times);
        long timeend = calendar.getTimeInMillis();
        long theday = (timethis - timeend) / (1000 * 60 * 60 * 24);
        int tday = (int) theday / 30;
        if ((tday > 24 )|| (tday==24))
        {
            if (se == 0)
                return 1;
            else
                return 2;
        }
        if ((18 < tday && tday < 24) || (tday==18))
        {
            if (se == 0)
                return 3;
            else
                return 4;
        }
        if ((12 < tday && tday < 18)|| (tday==12))
        {
            if (se == 0)
                return 5;
            else
                return 6;
        }
        if ((9 < tday && tday < 12)|| (tday==9))
        {
            if (se == 0)
                return 7;
            else
                return 8;
        }
        if ((6 < tday && tday < 9)|| (tday==6))
        {
            if (se == 0)
                return 9;
            else
                return 0;
        }
        return 10;

    }

    //给狗的背心编号系统自动产生
    public void set_gilet(int csvcompeteid, String community, int zubie) throws SQLException
    {
        int g = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select max(gilet) from CsvRundog where community=" + DbAdapter.cite(community) + " and csvcompeteid=" + csvcompeteid + " and zubie=" + zubie);
            if (db.next())
            {
                g = db.getInt(1);
            }
            g++;

            db.executeUpdate("update CsvRundog set gilet = " + g + " where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
        this.gilet = g;

    }

    // 录入犬的成绩 的
    public void set(String appraise, int place, int attack, int family, int doghouse, int placenum) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update CsvRundog set appraise=" + DbAdapter.cite(appraise) + ",place=" + place + ",attack=" + attack + ",family=" + family + ",doghouse=" + doghouse + ", placenum=" + placenum + " where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }

    }


    public void set_new(String appraise, int place, int attack, int family, int doghouse, int placenum, String dog_pic, String membercharge, String remark) throws SQLException
    {
        CsvRundog runobj = CsvRundog.find(id);
        Csvcompete coobj = Csvcompete.find(runobj.getCsvcompeteid());
        String placestr = null;
        if (runobj.getZubie() > 0 && runobj.getZubie() < 3)
        {
            if (coobj.getPlay_type() == 1)
            {
                for (int i = 0; i < CsvRundog.PLACE.length; i++)
                {

                    if (runobj.getPlace() == i)
                        placestr = CsvRundog.PLACE[i];
                }
            } else
            {
                for (int i = 0; i < CsvRundog.PLACE_C.length; i++)
                {

                    if (runobj.getPlace() == i)
                        placestr = CsvRundog.PLACE_C[i];
                }
            }
        } else if (runobj.getZubie() > 2 && runobj.getZubie() < 7)
        {
            for (int i = 0; i < CsvRundog.PLACE_A.length; i++)
            {
                if (runobj.getPlace() == i)
                    placestr = CsvRundog.PLACE_A[i];
            }
        } else
        {
            for (int i = 0; i < CsvRundog.PLACE_B.length; i++)
            {
                if (runobj.getPlace() == i)
                    placestr = CsvRundog.PLACE_B[i];
            }
        }
        //VA,V,SG,G

        String zm[] ={"VA","V","SG","G"}; //0,1,2,3
        int placeint = 99;
        int placeintj = 99;
        for(int i=0;i<zm.length;i++)
        {
            if(placestr.equals(zm[i]))
            {
                placeint=i;
            }
        }

        Csvdog dogobj=Csvdog.find_blood(runobj.getBlood(),"");


        for(int j=0;j<zm.length;j++)
        {
            if(placestr.equals(zm[j]))
           {
               placeintj=j;
           }
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update CsvRundog set appraise=" + DbAdapter.cite(appraise) + ",place=" + place + ",attack=" + attack + ",family=" + family + ",doghouse=" + doghouse + ", placenum=" + placenum + ", dog_pic=" + db.cite(dog_pic) + ",membercharge=" + db.cite(membercharge) + ",remark=" + db.cite(remark) + " where id=" + id);
            if(placeintj==99)
            {
                db.executeUpdate("update Csvdog set gamegrade="+DbAdapter.cite(placestr)+" where bloodlineletterid=" + db.cite(runobj.getBlood()));
            }
            else
            {
                if(placeint<placeintj)
                {
                    db.executeUpdate("update Csvdog set gamegrade="+DbAdapter.cite(placestr)+" where bloodlineletterid=" + db.cite(runobj.getBlood()));
                }
                else
                {

                }
            }

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }

    }


    //统计同一个父亲的犬的数量
    public static int getAncestry_count(String community, String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int counts = 0;
        try
        {
            db.executeQuery("select count(csvdogearid) from CsvRundog where  community=" + DbAdapter.cite(community) + sql);

            if (db.next())
            {
                counts = db.getInt(1);
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
        return counts;
    }

    //查询全部后代犬

    public static Enumeration findSons(String bool, int pos, int pageSize) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT bloodlineletterid " + getSonsSql(bool));
            for (int l = 0; l < pos + pageSize && db.next(); l++)
            {
                if (l >= pos)
                {
                    vector.addElement(String.valueOf(db.getString(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    private static String getSonsSql(String bool) throws SQLException
    {
        StringBuilder stringbuffer = new StringBuilder(" FROM Csvdog    ");
        Csvdog dobj = Csvdog.find_blood(bool, "");

        if (dobj.getSex() == 0)
        {
            stringbuffer.append(" WHERE  f_bloodlineletterid=" + DbAdapter.cite(bool));
        }
        if (dobj.getSex() == 1)
        {
            stringbuffer.append(" WHERE m_bloodlineletterid=" + DbAdapter.cite(bool));
        }

        return stringbuffer.toString();
    }

    /***************
     * 赛事预估
     *
     * *****/
    public static void playFuture(int csvcompeteid, String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db3 = new DbAdapter();
        int avgs = 0;
        int avg_play = 0;
        try
        {
            java.util.Enumeration come = CsvRundog.findByblood(community, " and csvcompeteid=" + csvcompeteid);
            if (!come.hasMoreElements())
            {

            }
            for (int index = 1; come.hasMoreElements(); index++)
            {
                String blood = String.valueOf(come.nextElement());
                db.executeQuery("select avg(placenum) from csvrundog  where blood =" + DbAdapter.cite(blood) + " and csvcompeteid !=" + csvcompeteid);
                if (db.next())
                {
                    avgs = db.getInt(1);
                    db.executeUpdate("update CsvRundog set avgs = " + avgs + " where blood =" + DbAdapter.cite(blood) + " and csvcompeteid =" + csvcompeteid);
                }
                db3.executeQuery("select avg(place) from csvrundog  where blood =" + DbAdapter.cite(blood) + " and csvcompeteid !=" + csvcompeteid);
                if (db3.next())
                {
                    avg_play = db3.getInt(1);
                    db3.executeUpdate("update CsvRundog set avg_play = " + avg_play + " where blood =" + DbAdapter.cite(blood) + " and csvcompeteid =" + csvcompeteid);

                }

            }
        } finally
        {
            db.close();
            db3.close();

        }
    }

    /***犬只是否参加过两场以上的比赛*****/
    public boolean numblood(String blood, int csvcompeteid) throws SQLException
    {
        boolean falg = false;
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("Select count(id) from csvRundog where blood =" + DbAdapter.cite(blood) + " and csvcompeteid!=" + csvcompeteid);
            if (db.next())
            {
                num = db.getInt(1);
                if (num < 2)
                {
                    falg = false;
                } else
                {
                    falg = true;
                }
            }
        } finally
        {
            db.close();
        }
        return falg;
    }
    /******CsvcompeteSeldog.jsp  显示 这个犬只是不是 已经参加过比赛*******/
    public static boolean show_tf(String csvdogearid, int csvcompeteid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select * from CsvRundog where csvdogearid = " + db.cite(csvdogearid) + " and csvcompeteid = " + csvcompeteid);
            if (db.next())
            {
                return true;
            } else
            {
                return false;
            }
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
    public String getTimesToString()
    {
        if (times != null)
        {
            return CsvRundog.sdf.format(times);
        } else
        {
            return "";
        }
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

    public int getPlacenum()
    {
        return placenum;
    }

    public String getBlood()
    {
        return blood;
    }

    public int getAvgs()
    {
        return avgs;
    }

    public int getAvg_play()
    {
        return avg_play;
    }

    public String getDog_pic()
    {
        return dog_pic;
    }

    public int getTracknum()
    {
        return tracknum;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getRemark()
    {
        return remark;
    }

    public String getMembercharge()
    {
        return membercharge;
    }

    public int getId()
    {
        return id;
    }
}
