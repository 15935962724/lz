package tea.entity.csvclub;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.sql.SQLException;

public class Csvdogblt extends Entity
{

    private int id;
    private int age; //年龄
    private String hipid; //髋号
    private String breedletter; //繁育证书 暂时没有用到
    private int playresultif; //是否需要比赛成绩
    private int breedtitleif; //繁育短期
    private int stopbreedif; //禁止繁殖
    private int result; //结果
    private int play; //成绩
    private String community;

    public static final String PLAY[] =
        {"-----", "VA", "V", "SG", "G", "VV", "V", "A", "U", "WV", "EZ"};


    public static final String ALLS[] =
        {"否", "是"};

    public static final String RESULTS[] =
        {"-------", "终身繁育证书", "短期繁育证书", "不符合制作繁育证书"};

    public static Csvdogblt find(String hipid) throws SQLException
    {
        return new Csvdogblt(hipid);
    }

    public Csvdogblt(String hipid) throws SQLException
    {
        this.hipid = hipid;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id,age,hipid,breedletter,playresultif,breedtitleif,result,play,stopbreedif,community from Csvdogblt where hipid=" + dbadapter.cite(hipid));
            if (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                age = dbadapter.getInt(2);
                hipid = dbadapter.getString(3);
                breedletter = dbadapter.getString(4); //是否需要比赛成绩
                playresultif = dbadapter.getInt(5); //是否需要比赛成绩
                breedtitleif = dbadapter.getInt(6); //是否禁止繁止
                result = dbadapter.getInt(7); //结果符合不符合: 0 是符合，1是不符合
                play = dbadapter.getInt(8); //成绩
                stopbreedif = dbadapter.getInt(9); //是否禁止繁止
                community = dbadapter.getString(10);
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

//删除方法
    public void delete() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE Csvdogblt WHERE hipid="
                                    + hipid);
        } finally
        {
            dbadapter.close();
        }
        // _cache.remove(bloodlineletterid);
    }

    //插入方法
    public static void create(int age, String hipid, String breedletter, int playresultif, int breedtitleif, int result, int stopbreedif, int play, String community) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into Csvdogblt (age,hipid,breedletter,playresultif,breedtitleif,result,stopbreedif,play,community) values ( " + age + "," + dbadapter.cite(hipid) + "," + dbadapter.cite(breedletter) + "," + playresultif + "," + breedtitleif + "," + result + "," +
                                    stopbreedif + "," + play + "," + dbadapter.cite(community) + ")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }

    //修改方法
    public void setup(int age, String hipid, String breedletter, int playresultif, int breedtitleif, int result, int stopbreedif, int play) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogblt set age=" + age + ",hipid=" + hipid + ",breedletter=" + dbadapter.cite(breedletter) + ",playresultif=" + playresultif + ",breedtitleif=" + breedtitleif + ",result=" + result + ",stopbreedif=" + stopbreedif + ",play=" + play + "," +
                                    dbadapter.cite(community) + "where hipid =" + dbadapter.cite(hipid));
        } catch (Exception ex)
        {
            throw new SQLException();
        } finally
        {
            dbadapter.close();
        }

    }

    //枚举
    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT hipid FROM Csvdogblt WHERE community=" + DbAdapter.cite(community) + sql);
            for (int l = 0; l < pos + size && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    vector.addElement(dbadapter.getString(1));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    //枚举
    public static java.util.Enumeration findmemberCommunity(String community, String sql, int pos, int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT member FROM profilelayer WHERE community=" + DbAdapter.cite(community) + sql);
            for (int l = 0; l < pos + size && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    vector.addElement(dbadapter.getString(1));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public static int countByCommunity(String community, String sql) throws SQLException
    {
        int i = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            i = dbadapter.getInt("SELECT COUNT(member) FROM Profilelayer WHERE community=" + dbadapter.cite(community) + sql);

        } finally
        {
            dbadapter.close();
        }
        return i;
    }

    //根据输入的hipid号来判断 是否 需要比赛成绩。 年限以2003年为判断条件   1 代表是，0代表否 2代表要求有防伪一级
    public static int getYearhipid(String hipid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            Date dates = null;
            dbadapter.executeQuery("select birthdate from csvdog where earid in (select earid from csvdogcheck where hipid =" + dbadapter.cite(hipid) + " ) ");
            if (dbadapter.next())
            {
                dates = dbadapter.getDate(1);
            }
            java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy"); //年
            String formattedDate = formatter.format(dates);
            int ds = Integer.parseInt(formattedDate);

            java.text.SimpleDateFormat formattermm = new java.text.SimpleDateFormat("MM"); //月
            String formattedDatemm = formatter.format(dates);
            int dsmm = Integer.parseInt(formattedDate);

            if (ds > 2003)
            {
                if (ds > 2006 && dsmm > 6)
                {
                    return 2;
                } else
                {
                    return 1;
                }
            } else
            {
                return 0;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //根据输入的hipid号来返回比赛成绩 VA　Ｖ　G SG 不知道重那里去********************不明确

    public static String getrundog(String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select place from csvrundog where csvdogearid in (select earid  from csvdogcheck where hipid = " + dbadapter.cite(hipid) + " )");
            if (dbadapter.next())
            {
                str = "1";
            } else
            {
                str = null;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return str;
    }

    //判断是否属于繁育短期资格
    public static int getBreeds(String hipid) throws SQLException
    {
        int s = 1; //0代表是，1代表不是
        int hip = 0;
        int elbow = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            hip = dbadapter.getInt("select csvovers from csvdogover");
            elbow = dbadapter.getInt("select csvelbows from csvdogover");
            if (hip > 4 || elbow > 3)
            {
                return s = 1;
            } else if (hip <= 4 || elbow <= 3)
            {
                return s = 0;
            }
        } catch (Exception ex)
        {
            throw new SQLException();

        } finally
        {
            dbadapter.close();
        }
        return s;
    }


    //判断是否属于禁止繁育

    public static int getStops(String hipid) throws SQLException
    {
        int s = 1; //0代表是，1代表不是
        int hip = 0;
        int elbow = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            hip = dbadapter.getInt("select csvovers from csvdogover");
            elbow = dbadapter.getInt("select csvelbows from csvdogover");
            if (hip > 4 || elbow > 3)
            {
                return s = 1;
            } else if (hip <= 4 || elbow <= 3)
            {
                return s = 0;
            }

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());

        } finally
        {
            dbadapter.close();
        }
        return s;
    }


    ///相关时间上的计算
    public static int getDays(Date sd)
    {
        Date times = new Date();
        Calendar calendar = Calendar.getInstance();

        calendar.setTime(sd);
        long timethis = calendar.getTimeInMillis();
        calendar.setTime(times);
        long timeend = calendar.getTimeInMillis();
        long theday = (timeend - timethis) / (1000 * 60 * 60 * 24);
        int tday = (int) theday / 30;
        return tday;
    }

    ////根据0  或 1  还有年龄判断 这个够是否符合制作繁育证书0表示不符合1表示符合
    public static int gethipsx(int age, int sex)
    {
        int s = 0;

        if (sex == 0 && (age > 23))
        {
            s = 1;
        } else if (sex == 1 && age > 19)
        {
            s = 1;
        } else
        {
            s = 0;
        }
        return s;

    }

    //输入耳号返回，比赛成绩
    public static int csvdogrun(String earid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select  place  from CsvRundog where csvdogearid =" + dbadapter.cite(earid));
            if (dbadapter.next())
            {
                return dbadapter.getInt(1);
            } else
            {
                return 0;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //
    public static boolean Option(String hipid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select hipid from Csvdogblt where hipid = " + dbadapter.cite(hipid));
            if (dbadapter.next())
            {
                return true;
            } else
            {
                return false;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }

    public int getAge()
    {
        return age;
    }

    public String getBreedletter()
    {
        return breedletter;
    }

    public int getBreedtitleif()
    {
        return breedtitleif;
    }

    public String getHipid()
    {
        return hipid;
    }

    public int getId()
    {
        return id;
    }

    public int getPlayresultif()
    {
        return playresultif;
    }

    public int getResult()
    {
        return result;
    }

    public int getStopbreedif()
    {
        return stopbreedif;
    }

    public int getPlay()
    {
        return play;
    }

    public String getCommunity()
    {
        return community;
    }
}
