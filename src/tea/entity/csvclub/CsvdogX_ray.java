package tea.entity.csvclub;

import java.math.BigDecimal;
import java.util.Date;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.util.*;
import tea.entity.Entity;

public class CsvdogX_ray extends Entity
{
    private int id;
    private String uphipX_ray;
    private String upelbowX_ray;
    private String signhip;
    private String signelbow;
    private int hipnum;
    private int elbownum;
    private String sign;
    private String hipid;
    private String community;
    private String xray;
    private Date DNAt;
    private Date hiptime;
    private Date elbowstime;
    private String num; //流水号

    public Date getElbowstime()
    {
        return elbowstime;

    }

    private String getElbowstimeToString()
    {
        if (elbowstime == null)
            return "";
        return sdf.format(elbowstime);
    }

    public static final String X_RAYS[] =
        {"------", "无血统证书", "补拍髋", "补拍肘",

        "转发繁育证书", "转发血统证书", "申请血统补做", "重拍髋", "重拍肘", "补拍髋肘", "转发血统繁育证书", "重拍髋肘", "暂无结果"}; // 光片类型

    private String elbowtime;
    public CsvdogX_ray(String hipid) throws SQLException
    {
        this.hipid = hipid;
        load();
    }

    public static CsvdogX_ray find(String hipid) throws SQLException
    {
        return new CsvdogX_ray(hipid);
    }

    public void load() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select id,uphipX_ray,upelbowX_ray,signhip,signelbow,hipnum,elbownum,sign,hipid,community,xray,DNAt from csvdogX_ray where hipid =" + dbadapter.cite(hipid));

            if (dbadapter.next())
            {
                id = dbadapter.getInt(1);
                uphipX_ray = dbadapter.getString(2);
                upelbowX_ray = dbadapter.getString(3);
                signhip = dbadapter.getString(4);
                signelbow = dbadapter.getString(5);
                hipnum = dbadapter.getInt(6);
                elbownum = dbadapter.getInt(7);
                sign = dbadapter.getString(8);
                hipid = dbadapter.getString(9);
                community = dbadapter.getString(10);
                xray = dbadapter.getString(11);
                DNAt = dbadapter.getDate(12);

            }

        } finally
        {
            dbadapter.close();
        }

//            byte by[]=teasession.getBytesParameter("file");
//              String path= super.write(teasession._strCommunity,by,".gif");
    }

    /*******定义一个通过hipid号 返回 光片是否已经上传的方法***********/
    public static String CsvdogDNAByCommunity(String community, String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select sign from csvdogx_ray where community=" + dbadapter.cite(community) + " AND hipid=" + dbadapter.cite(hipid));
        } finally
        {
            dbadapter.close();
        }
        return str;
    }

    //   返回是否上传了 髋光片
    public static String CsvdoghipX(String community, String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select signhip from csvdogx_ray where community=" + dbadapter.cite(community) + " AND hipid=" + dbadapter.cite(hipid));
        } finally
        {
            dbadapter.close();
        }
        return str;
    }

    //返回是否上传了 肘光片
    public static String CsvdogelbowX(String community, String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select signelbow from csvdogx_ray where community=" + dbadapter.cite(community) + " AND hipid=" + dbadapter.cite(hipid));
        } finally
        {
            dbadapter.close();
        }
        return str;
    }

    /*****第一插入数据***在添加身体检查的时候，在csvdogxray表中新建一行数据 **/
    public static void createX_ray(String community, String hipid, int X_ray, Date DNAt) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into csvdogx_ray (community,hipid,xray,DNAt) values (" + dbadapter.cite(community) + ","
                                    + dbadapter.cite(hipid) + ","
                                    + X_ray + ","
                                    + dbadapter.cite(DNAt) +
                                    ")");
        } finally
        {
            dbadapter.close();
        }
    }

    //在光片检测中的上传光片时候 如果数据库没有这个hipid号 这重新插入一条数据
    public static void createX_two(String uphipX_ray, String upelbowX_ray, String signhip, String signelbow, String hipid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into csvdogX_ray (uphipX_ray,upelbowX_ray,signhip,signelbow,hipid) values(" + dbadapter.cite(uphipX_ray) + "," + dbadapter.cite(upelbowX_ray) + "," + dbadapter.cite(signhip) + "," + dbadapter.cite(signelbow) + "," + dbadapter.cite(hipid) + ")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }

    //**********数据的修改 上传文件的存放位置.
     public void setUpxray(String uphipX_ray, String upelbowX_ray, String signhip, String signelbow, String hipid) throws SQLException
     {
         Date timedate = new Date();
         Date timecreate = timedate;
         DbAdapter dbadapter = new DbAdapter();
         try
         {
             dbadapter.executeUpdate("update csvdogx_ray set uphipX_ray =" + dbadapter.cite(uphipX_ray) + " ,upelbowX_ray = " + dbadapter.cite(upelbowX_ray) + ",signhip=" + dbadapter.cite(signhip) + ",signelbow=" + dbadapter.cite(signelbow) + " where hipid =" + dbadapter.cite(hipid));

         } catch (Exception ex)
         {
             throw new SQLException(ex.toString());
         } finally
         {
             dbadapter.close();
         }
     }

    //修改髋上传时间
    public void sethiptime(String hipid) throws SQLException
    {
        Date timedate = new Date();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update csvdogx_ray set hiptime=" + dbadapter.cite(timedate) + "where hipid=" + dbadapter.cite(hipid));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close(); ;
        }
    }

    //修改肘上传时间
    public void setelbowtime(String hipid) throws SQLException
    {
        Date timedate = new Date();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update csvdogx_ray set elbowtime=" + dbadapter.cite(timedate) + "where hipid=" + dbadapter.cite(hipid));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close(); ;
        }
    }

    ///取得肘上传时间
    public static String getElbowtimes(String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select elbowtime from csvdogx_ray where hipid =" + dbadapter.cite(hipid));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return str;
    }

///通过hipid号 返回 图片的路径elbow
    public static String getelbowPicpath(String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select upelbowX_ray from csvdogx_ray where hipid = " + dbadapter.cite(hipid));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return str;
    }

    ///通过hipid号 返回 图片的路径hip
    public static String gethipPicpath(String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select uphipX_ray from csvdogx_ray where hipid = " + dbadapter.cite(hipid));

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return str;
    }

    ///查看数据库中是否有数据
    public static String getCsvdoghip(String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select * from csvdogx_ray where hipid = " + dbadapter.cite(hipid));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
        return str;
    }

    //根据编号返回髋肘号 id  ---hipid
    public static String getCsvHip(int id) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select hipid from CsvdogX_ray where id =" + id);
            if (dbadapter.next())
            {
                return dbadapter.getString(1);
            } else
            {
                return null;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }


    public Date getDNAt()
    {
        return DNAt;
    }

    public String getDNAToString()
    {
        if (DNAt == null)
            return "";
        return sdf.format(DNAt);
    }

    public String getHiptimeToString()
    {
        if (hiptime == null)
            return "";
        return sdf.format(hiptime);
    }

    public String getXray()
    {
        return xray;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getHipid()
    {
        return hipid;
    }

    public int getElbownum()
    {
        return elbownum;
    }

    public int getHipnum()
    {
        return hipnum;
    }

    public int getId()
    {
        return id;
    }

    public String getSign()
    {
        return sign;
    }

    public String getSignelbow()
    {
        return signelbow;
    }

    public String getSignhip()
    {
        return signhip;
    }

    public String getUpelbowX_ray()
    {
        return upelbowX_ray;
    }

    public String getUphipX_ray()
    {
        return uphipX_ray;
    }

    public String getNum()
    {
        return num;
    }

    public String getElbowtime()
    {
        return elbowtime;
    }

    public Date getHiptime()
    {
        return hiptime;
    }


}
