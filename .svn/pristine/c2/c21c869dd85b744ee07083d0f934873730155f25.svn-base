package tea.entity.csvclub.testing;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;


public class Csvdogprovetesting extends Entity
{
    //配犬证明编号	配犬日期	公犬血统证书号	母犬血统证书号	母犬主人犬舍	母犬主人	母犬主人地区	公犬主人	收到时间	备注	是否合格

    private String provenum;
    private Date fmprovetime;
    private String fblood;
    private String mblood;
    private String fmember;
    private String mmember;
    private String mhouse;
    private String fhouse;
    private Date dzdate;
    private int provestatic;
    private int hege;
    private String member;
    private String remark;

    public Csvdogprovetesting(String provenum)throws SQLException
    {
        this.provenum = provenum;
        load();
    }

    public static Csvdogprovetesting find(String provenum)throws SQLException
    {
        return new Csvdogprovetesting(provenum);

    }

    public Csvdogprovetesting(String provenum,String a)throws SQLException
   {
       this.provenum = provenum;
       load_all();
   }

   public static Csvdogprovetesting find(String provenum,String a)throws SQLException
   {
       return new Csvdogprovetesting(provenum,a);

   }

    public void load()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select 配犬证明编号,配犬日期,公犬血统证书号,母犬血统证书号,母犬主人犬舍,母犬主人,母犬主人地区,公犬主人,收到时间,备注,是否合格 from proveinfo where 配犬证明编号="+db.cite(provenum));
            if(db.next())
            {
                provenum = db.getString(1);
                fmprovetime=db.getDate(2);
                fblood= db.getString(3);
                mblood = db.getString(4);
                fmember = db.getString(5);
                mmember = db.getString(6);
                mhouse = db.getString(7);
                fhouse = db.getString(8);
                dzdate = db.getDate(9);
                provestatic = db.getInt(10);
                hege = db.getInt(11);
                remark = db.getString(12);

            }
            else
            {

            }

        }
        finally
        {
            db.close();
        }

    }

    public void load_all()throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            //配犬编号	姓名	状态

            db.executeQuery("select 配犬编号,姓名,状态 from proveall where 配犬编号="+db.cite(provenum) );
            if(db.next())
            {
                provenum = db.getString(1);
                member = db.getString(2);
            }
        }
        finally
        {
            db.close();
        }

    }

    public static java.util.Enumeration Proveall( String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT 配犬编号 FROM proveall" + sql);
            while (db.next())
            {
                vector.addElement(String.valueOf(db.getString(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    public static java.util.Enumeration Provemember( String sql) throws SQLException
        {
            java.util.Vector vector = new java.util.Vector();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT distinct vipid FROM csvdogprove " + sql);
                while (db.next())
                {
                    vector.addElement(String.valueOf(db.getString(1)));
                }
            } finally
            {
                db.close();
            }
            return vector.elements();
        }



    //时间类型转换
    public static void Option() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        while (true)
        {
            try
            {
                int i = 0;
                db.executeQuery(" select  配犬日期,父母犬配犬证明号 from dog_prove where 配犬日期 !=''  and   provedate  is null ");
                while (db.next())
                {
                    try
                    {
                        String dates = db.getString(1);
                        String id = db.getString(2);
                        db2.executeUpdate("update dog_prove set provedate='" + dates + "' where 父母犬配犬证明号=" + DbAdapter.cite(id));
                    } catch (Exception ex)
                    {
                        System.out.println(ex.toString());
                    }
                    i++;
                }
                if (i == 0)
                {
                    //db.executeUpdate(" update dog_prove set 配犬日期 = dog_prove ");
                    db.close();
                    return;
                }

            } catch (Exception ex)
            {
                throw new SQLException(ex.toString());
            }
        }
    }

    public Date getDzdate()
    {
        return dzdate;
    }

    public String getFblood()
    {
        return fblood;
    }

    public String getFmember()
    {
        return fmember;
    }

    public String getFhouse()
    {
        return fhouse;
    }

    public Date getFmprovetime()
    {
        return fmprovetime;
    }

    public int getHege()
    {
        return hege;
    }

    public String getMblood()
    {
        return mblood;
    }

    public String getMhouse()
    {
        return mhouse;
    }

    public String getMmember()
    {
        return mmember;
    }

    public String getProvenum()
    {
        return provenum;
    }

    public int getProvestatic()
    {
        return provestatic;
    }

    public String getRemark()
    {
        return remark;
    }

    public String getMember()
    {
        return member;
    }

}
