package tea.entity.csvclub;

import java.math.*;
import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Csvcompete extends Entity
{

    private int id;//自增id
    private String compete_name;///赛事名称
    private Date time_k;//开始时间
    private Date time_j;//结束时间
    private int locus;//省
    private String umpire;/////载判
    private String link;//页面连接
    private BigDecimal exes;///费用
    private BigDecimal home_exes;///家族组费用
    private BigDecimal doghouse_exes;///犬舍组费用
    private int compete_type;/// {"-----", "繁殖展", "培训展", "防卫扑咬"};赛事类型
    private String intro;// 备注
    private Date times;//添加时间
    private String addrinfo;///地区详细信息
    private int play_type;//赛事项目类型{"----","本部展","地方展","服从防卫"};
    private String compete_num;//赛事编号
    private String compete_pic;//赛事图片

    public static final String PLAY_TYPE[]= {"----","本部展","地方展","服从防卫"};
    public static final String COMPETE_TYPE[] =
                                                {"-----", "繁殖展", "培训展", "防卫扑咬","搜救犬考试","导盲犬考试","敏捷犬考试"};
    private static Cache _cache = new Cache(100);
    private boolean exists;

    public Csvcompete(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Csvcompete find(int id) throws SQLException
    {
        return new Csvcompete(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  compete_name,time_k,time_j,locus,umpire,link,exes,home_exes,doghouse_exes,compete_type,intro,times,addrinfo,play_type,compete_num, compete_pic FROM Csvcompete WHERE id =" + id);
            if (db.next())
            {
                compete_name = db.getVarchar(1, 1, 1);
                time_k = db.getDate(2);
                time_j = db.getDate(3);
                locus = db.getInt(4);
                umpire = db.getString(5);
                link = db.getVarchar(1, 1, 6);
                exes = db.getBigDecimal(7, 2);
                home_exes = db.getBigDecimal(8, 2);
                doghouse_exes = db.getBigDecimal(9, 2);
                compete_type = db.getInt(10);
                intro = db.getVarchar(1, 1, 11);
                times = db.getDate(12);
                addrinfo = db.getString(13);
                play_type = db.getInt(14);
                compete_num = db.getString(15);
                compete_pic = db.getString(16);

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

    public static void create(String compete_name, Date time_k, Date time_j, int locus, String umpire, String link, BigDecimal exes, BigDecimal home_exes, BigDecimal doghouse_exes, int compete_type, String intro, String community,String addrinfo) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into Csvcompete (compete_name,time_k,time_j,locus,umpire,link,exes,home_exes,doghouse_exes,compete_type,intro,times,community,addrinfo) values (" + DbAdapter.cite(compete_name) + "," + DbAdapter.cite(time_k) + "," + DbAdapter.cite(time_j) + "," + locus + "," + DbAdapter.cite(umpire) + "," + DbAdapter.cite(link) + "," + exes + "," + home_exes + "," + doghouse_exes + "," + compete_type + "," + DbAdapter.cite(intro) + "," + DbAdapter.cite(times) + "," + DbAdapter.cite(community)+ ","+DbAdapter.cite(addrinfo)+ " )");
        } finally
        {
            db.close();
        }
    }

    public static void create_new(String compete_name, Date time_k, Date time_j, int locus, String umpire, String link, BigDecimal exes, BigDecimal home_exes, BigDecimal doghouse_exes, int compete_type, String intro, String community, String addrinfo,String compete_num,String compete_pic) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date times = new Date();
        try
        {
            db.executeUpdate("insert into Csvcompete (compete_name,time_k,time_j,locus,umpire,link,exes,home_exes,doghouse_exes,compete_type,intro,times,community,addrinfo,compete_num,compete_pic) values (" + DbAdapter.cite(compete_name) + "," + DbAdapter.cite(time_k) + "," + DbAdapter.cite(time_j) + "," + locus + "," + DbAdapter.cite(umpire)  + "," + DbAdapter.cite(link) + "," + exes + "," + home_exes + "," + doghouse_exes + "," + compete_type + "," + DbAdapter.cite(intro) + "," + DbAdapter.cite(times) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(addrinfo) + ","+db.cite(compete_num) +", " +db.cite(compete_pic)+ " )");
        } finally
        {
            db.close();
        }
    }


    public void set(String compete_name, Date time_k, Date time_j, int locus, String umpire, String link, BigDecimal exes, BigDecimal home_exes, BigDecimal doghouse_exes, int compete_type, String intro,String addrinfo) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvcompete set  compete_name=" + DbAdapter.cite(compete_name) + ",time_k=" + DbAdapter.cite(time_k) + ",time_j=" + DbAdapter.cite(time_j) + ",locus=" + locus + ",umpire=" + DbAdapter.cite(umpire )+ ",link=" + DbAdapter.cite(link) + ",exes=" + exes + ",home_exes=" + home_exes + ",doghouse_exes=" + doghouse_exes + ",compete_type=" + compete_type + ",intro=" + DbAdapter.cite(intro) +",addrinfo="+DbAdapter.cite(addrinfo)+ " where id=" + id);
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public void set_new(String compete_name, Date time_k, Date time_j, int locus, String umpire, String link, BigDecimal exes, BigDecimal home_exes, BigDecimal doghouse_exes, int compete_type, String intro,String addrinfo,String compete_num,String compete_pic ) throws SQLException
   {
       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("update Csvcompete set  compete_name=" + DbAdapter.cite(compete_name) + ",time_k=" + DbAdapter.cite(time_k) + ",time_j=" + DbAdapter.cite(time_j) + ",locus=" + locus + ",umpire=" +DbAdapter.cite( umpire) + ",link=" + DbAdapter.cite(link) + ",exes=" + exes + ",home_exes=" + home_exes + ",doghouse_exes=" + doghouse_exes + ",compete_type=" + compete_type + ",intro=" + DbAdapter.cite(intro) +",addrinfo="+DbAdapter.cite(addrinfo)+", compete_num= "+ db.cite(compete_num)+", compete_pic = "+db.cite(compete_pic)+  " where id=" + id);
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
            db.executeUpdate("delete from Csvcompete where id=" + id);
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
            dbadapter.executeQuery("SELECT id FROM Csvcompete WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; l < pos + pageSize && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    int id = dbadapter.getInt(1);
                    vector.addElement(new Integer(id));
                }
            }
        } catch (SQLException ex)
        {
            throw new SQLException(ex.toString());
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
            dbadapter.executeQuery("SELECT id FROM Csvcompete WHERE community=" + DbAdapter.cite(community) + sql);

            while (dbadapter.next())
            {
                int id = dbadapter.getInt(1);
                vector.addElement(new Integer(id));

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
            dbadapter.executeQuery("SELECT COUNT(cs.id) FROM Csvcompete cs WHERE cs.community=" + dbadapter.cite(community) + sql);
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
    public static void  setPlay_type(int play_type,int id)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Csvcompete set play_type="+play_type+" where id ="+id);
        }
        finally
        {
             db.close();
        }
    }

    public static String Csvcheckbox(String str, int values, int id)
    {
        boolean falg = false;

        try
        {
            falg = Csvcompete.getidboolean(id);
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }
        if (falg && str.length() > 0)
        {
            String charflag[] = str.split(",");
            if (charflag != null)
            {
                for (int i = 0; i < charflag.length; i++)
                {
                    if (Integer.parseInt(charflag[i]) == values)
                    {
                        return "checked=checked";
                    }
                }
            }
        }
        return "";
    }

    public static boolean getidboolean(int id) throws SQLException
    {
        DbAdapter dbadpter = new DbAdapter();
        try
        {
            dbadpter.executeQuery("select * from Csvumpire where id=" + id);
            if (dbadpter.next())
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
            dbadpter.close();
        }
    }
/////时间2008-05-16
    public static int getID_date(int city,String address,Date date,Date dates)throws SQLException
    {
        int csvcompeteid=0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from csvcompete where locus = "+city+" and compete_name like "+db.cite("%"+address+"%")+" and "+db.cite(date)+" < time_k and "+db.cite(dates)+" >time_k "  );
  //          System.out.print("select id from csvcompete where locus = "+city+" and compete_name like "+db.cite("%"+address+"%")+" and "+db.cite(date)+" < time_k and "+db.cite(dates)+" >time_k "  );

            if(db.next())
            {
                csvcompeteid = db.getInt(1);
            }
        }
        finally
        {
            db.close();
        }
        return csvcompeteid;
    }

    public String getCompete_name()
    {
        return compete_name;
    }

    public Date getTime_k()
    {
        return time_k;
    }

    public String getTime_ktoString()
    {
        if (time_k == null)
            return "";
        return sdf.format(time_k);
    }

    public Date getTime_j()
    {
        return time_j;
    }

    public String getTime_jtoString()
    {
        if (time_j == null)
            return "";
        return sdf.format(time_j);
    }

    public int getLocus()
    {
        return locus;
    }

    public String getLink()
    {
        return link;
    }

    public String getUmpire()
    {
        return umpire;
    }

    public BigDecimal getDoghouse_exes()
    {
        return doghouse_exes;
    }

    public BigDecimal getExes()
    {
        return exes;
    }

    public BigDecimal getHome_exes()
    {
        return home_exes;
    }

    public int getCompete_type()
    {
        return compete_type;
    }

    public String getIntro()
    {
        return intro;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getAddrinfo()
    {
        return addrinfo;
    }

    public int getPlay_type()
    {
        return play_type;
    }

    public String getCompete_pic()
    {
        return compete_pic;
    }

    public String getCompete_num()
    {
        return compete_num;
    }

    public String getTimestoString()
    {
        if (times == null)
            return "";
        return sdf.format(times);
    }
}
