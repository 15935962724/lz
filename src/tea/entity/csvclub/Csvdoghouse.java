package tea.entity.csvclub;

import java.math.*;
import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import java.util.Vector;

public class Csvdoghouse extends Entity
{
    private static Cache _cache = new Cache(100);

    private boolean exists;
    private String member;
    private String community;
    private String dog;
    private String linkman; //联系人
    private String tel; //电话
    private String address; //地址
    private String email; //
    private boolean random;
    private int templet; //模板
    private int templetstyle;
    private String goodman;
    private String dogbig;
    private String dogsmall;
    private String doghouseC;
    private String doghouseE;
    private String doghousenum;
    private Date times;
    private int typemi; //开通犬舍服务
    private int typefi; //确认财务到帐的
    private String explain;
    private String zip;
    private String goodman_set;
    private String housenumber;
    private String pic;
    private int sequence; //顺序
    private Date updatetime;//更新时间 2008-01-22 犬舍新加字段


    public Csvdoghouse(String member, String community) throws SQLException
    {
        this.member = member;
        this.community = community;
        loadBasic();
    }

    public static Csvdoghouse find(String member, String community) throws SQLException
    {
        return new Csvdoghouse(member, community);
    }

    public Csvdoghouse(int csvtemplet, int item, BigDecimal money, int poyear, int outlay, java.util.Date time)
    {

    }

    private void loadBasic() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT dog,linkman,tel,address,email,random,templet,templetstyle,goodman,dogbig,dogsmall,doghouseC,doghouseE,doghousenum,times,explain,typemi,typefi,zip,goodman_set,housenumber,pic,sequence,updatetime FROM Csvdoghouse WHERE member=" + DbAdapter.cite(member) + " AND community=" +
                                   DbAdapter.cite(community));
            if (dbadapter.next())
            {
                dog = dbadapter.getString(1);
                linkman = dbadapter.getString(2);
                tel = dbadapter.getString(3);
                address = dbadapter.getString(4);
                email = dbadapter.getString(5);
                random = dbadapter.getInt(6) != 0;
                templet = dbadapter.getInt(7);
                templetstyle = dbadapter.getInt(8);
                goodman = dbadapter.getString(9);
                dogbig = dbadapter.getString(10);
                dogsmall = dbadapter.getString(11);
                doghouseC = dbadapter.getString(12);
                doghouseE = dbadapter.getString(13);
                doghousenum = dbadapter.getString(14);
                times = dbadapter.getDate(15);
                explain = dbadapter.getString(16);
                typemi = dbadapter.getInt(17);
                typefi = dbadapter.getInt(18);
                zip = dbadapter.getString(19);
                goodman_set = dbadapter.getString(20);
                housenumber = dbadapter.getVarchar(1, 1, 21);
                pic = dbadapter.getString(22);
                sequence = dbadapter.getInt(23);
                updatetime = dbadapter.getDate(24);
                exists = true;
            } else
            {
                exists = false;
                dogbig = dogsmall = "/";
            }
        } finally
        {
            dbadapter.close();
        }
    }

//删除犬舍
    public void delete() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("DELETE Csvdoghouse WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(member + ":" + community);
    }

    public static void create(String member, String community, String dog, String linkman, String tel, String address, String email, String doghouseC, String doghouseE, String explain, String zip) throws SQLException
    {
        Date times = new Date();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Csvdoghouse(member,community,dog,linkman,tel,address,email,dogbig,dogsmall,doghouseC,doghouseE,times,explain,zip) VALUES(" +
                                    dbadapter.cite(member) + "," + dbadapter.cite(community) + "," + dbadapter.cite(dog) + "," +
                                    dbadapter.cite(linkman) + "," + dbadapter.cite(tel) + "," +
                                    dbadapter.cite(address) + "," + dbadapter.cite(email) + ",'/','/'," + dbadapter.cite(doghouseC) + "," + dbadapter.cite(doghouseE) + "," + dbadapter.cite(times) + "," + dbadapter.cite(explain) + " ," + dbadapter.cite(zip) + ")");
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(member + ":" + community);
    }

    public static void create(String member, String community, String dog, String linkman, String tel, String address, String email, String explain) throws SQLException
    {
        Date times = new Date();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Csvdoghouse(member,community,dog,linkman,tel,address,email,dogbig,dogsmall,times,explain) VALUES(" +
                                    dbadapter.cite(member) + "," + dbadapter.cite(community) + "," + dbadapter.cite(dog) + "," +
                                    dbadapter.cite(linkman) + "," + dbadapter.cite(tel) + "," +
                                    dbadapter.cite(address) + "," + dbadapter.cite(email) + ",'/','/'," + dbadapter.cite(times) + "," + dbadapter.cite(explain) + ")");
        } finally
        {
            dbadapter.close();
        }
        _cache.remove(member + ":" + community);
    }

    public void set(String dog, String linkman, String tel, String address, String email, String doghouseC, String doghouseE, String explain, String zip) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdoghouse SET dog=" + dbadapter.cite(dog) + ",linkman=" + dbadapter.cite(linkman) + ",tel=" + dbadapter.cite(tel) + ",address=" + dbadapter.cite(address) +
                                    ",email=" + dbadapter.cite(email) +
                                    ", doghouseC=" + dbadapter.cite(doghouseC) + ", doghouseE =" + dbadapter.cite(doghouseE) + ",explain=" + dbadapter.cite(explain) + ",zip=" + dbadapter.cite(zip) + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
        } finally
        {
            dbadapter.close();
        }
        this.dog = dog;
        this.linkman = linkman;
        this.tel = tel;
        this.address = address;
        this.email = email;
        this.doghouseC = doghouseC;
        this.doghouseE = doghouseE;
        this.explain = explain;
        this.zip = zip;
    }

    public void set(String dog, String linkman, String tel, String address, String email, String explain) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdoghouse SET dog=" + dbadapter.cite(dog) + ",linkman=" + dbadapter.cite(linkman) + ",tel=" + dbadapter.cite(tel) + ",address=" + dbadapter.cite(address) +
                                    ",email=" + dbadapter.cite(email) +
                                    ",explain =" + dbadapter.cite(explain) +
                                    " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
        } finally
        {
            dbadapter.close();
        }
        this.dog = dog;
        this.linkman = linkman;
        this.tel = tel;
        this.address = address;
        this.email = email;
        this.explain = explain;

    }

    public void set(String doghousenum) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvdoghouse set doghousenum=" + DbAdapter.cite(doghousenum) + " where member=" + DbAdapter.cite(member) + " and community=" + DbAdapter.cite(community));
        } catch (Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
    }

    //导入数据时用到的
    public static void set(String doghousenum, String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        String community = "csvclub";
        try
        {
            db.executeUpdate("update Csvdoghouse set doghousenum=" + DbAdapter.cite(doghousenum) + " where member=" + DbAdapter.cite(member) + " and community=" + DbAdapter.cite(community));
        } catch (Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration find() throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT ct.csvtemplet FROM Csvdoghouse ct");
            while (dbadapter.next())
            {
                int csvtemplet = dbadapter.getInt(1);
                vector.addElement(new Integer(csvtemplet));
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }


    //判断一个用户只能有一个中文犬舍
    public static boolean isExisted(String doghouseC, String community) throws SQLException
    {
        boolean flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT doghouseC FROM Csvdoghouse WHERE community = " + dbadapter.cite(community) + " and doghouseC=" + DbAdapter.cite(doghouseC));

            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

    //判断一个用户只能有一个英文犬舍
    public static boolean isExistedE(String doghouseE, String community) throws SQLException
    {
        boolean flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT doghouseE FROM Csvdoghouse WHERE community = " + dbadapter.cite(community) + " and doghouseE=" + DbAdapter.cite(doghouseE));

            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

    //判断一个用户只能有一个犬舍
    public static boolean isExistedE_s(String member, String community) throws SQLException
    {
        boolean flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT member FROM Csvdoghouse WHERE community = " + dbadapter.cite(community) + " and member=" + DbAdapter.cite(member));

            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

//统计犬舍的数目
    public static int count(String community, String sql) throws SQLException
    {
        int j = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT COUNT(community) FROM Csvdoghouse WHERE community=" + DbAdapter.cite(community) + sql);
            if (dbadapter.next())
            {
                j = dbadapter.getInt(1);
            }
        } finally
        {
            dbadapter.close();
        }
        return j;
    }

//
    public void setRandom(boolean random) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdoghouse SET random=" + dbadapter.cite(random) + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
        } finally
        {
            dbadapter.close();
        }
        this.random = random;
    }

    public void setTemplet(int templet) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdoghouse SET templet=" + templet + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
        } finally
        {
            dbadapter.close();
        }
        this.templet = templet;
    }

    public void setTempletstyle(int templetstyle) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdoghouse SET templetstyle=" + templetstyle + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
        } finally
        {
            dbadapter.close();
        }
        this.templetstyle = templetstyle;
    }

    public void setGoodman(String goodman) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdoghouse SET goodman=" + DbAdapter.cite(goodman) + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
        } finally
        {
            dbadapter.close();
        }
        this.goodman = goodman;
    }

    public void setGoodman_set(String goodman_set) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdoghouse SET goodman_set=" + DbAdapter.cite(goodman_set) + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));

        } finally
        {
            dbadapter.close();
        }
        this.goodman_set = goodman_set;
    }

    public void setDogbig(String dogbig) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdoghouse SET dogbig=" + DbAdapter.cite(dogbig) + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
        } finally
        {
            dbadapter.close();
        }
        this.dogbig = dogbig;
    }

    public void setDogsmall(String dogsmall) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdoghouse SET dogsmall=" + DbAdapter.cite(dogsmall) + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
        } finally
        {
            dbadapter.close();
        }
        this.dogsmall = dogsmall;
    }

    public void setPic(String pic) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvdoghouse set pic =" + DbAdapter.cite(pic) + " where member=" + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }
    public void setUpdatetime(Date updatetime)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvdoghouse set updatetime="+DbAdapter.cite(updatetime)+" where member="+DbAdapter.cite(member));
        }
        finally
        {
            db.close();
        }
    }
    public void setSequence(int sequence) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db2.executeUpdate(" update Csvdoghouse set sequence=" + 0 + " where sequence=" + sequence);
            db.executeUpdate("update Csvdoghouse set sequence =" + sequence + " where member =" + DbAdapter.cite(member));
        } finally
        {
            db.close();
            db2.close();
        }
        this.sequence = sequence;
    }

    //
    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  member FROM Csvdoghouse WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0;  l < pos  + pageSize && dbadapter.next(); l++)
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


    //修改财务到帐的标示
    public void setFi(String type, int typezhi) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdoghouse SET " + type + "= " + typezhi + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));

        } finally
        {
            dbadapter.close();
        }
        //this.templet = templet;
    }

    //根据不同的用户名 返回犬舍的图片路径
    public static String getpicOption(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeQuery("select pic from Csvdoghouse where member = " + DbAdapter.cite(member));
            if (db.next())
            {
                return db.getString(1);
            } else
            {
                return "";
            }
        } finally
        {
            db.close();
        }
    }

/// 前台列表，显示前台的数据的排列规则
    public static java.util.Enumeration findpicCommunity(String community, String sql, int pos) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  TOP " + pos + "  member FROM Csvdoghouse WHERE community=" + DbAdapter.cite(community) + sql);

            for (int l = 0; dbadapter.next(); l++)
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

    //根据顺序显示前台的犬只
    public static String doghousenum(int sequence) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" select member from Csvdoghouse where sequence=" + sequence);
            if (db.next())
            {
                return db.getString(1);
            } else
            {
                return "webmaster";
            }
        } finally
        {
            db.close();
        }
    }

    public static java.util.Enumeration findbyhouse(String community, String sql, int pos, int pageSize) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT  p.member FROM ProfileLayer p,csvdoghouse c  where p.member = c.member " + sql);
            for (int l = 0; l < pos + pageSize && db.next(); l++)
            {
                if (l >= pos)
                {
                    v.addElement(db.getString(1));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();

    }
    public static int counthouse(String community,String sql)throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int count=0;
        try
        {
            db.executeQuery("SELECT count( p.member) FROM ProfileLayer p,csvdoghouse c  where p.member = c.member "+ sql);
            if(db.next())
            {

                count= db.getInt(1);
            }
        }
        finally
        {
            db.close();
        }
        return count;
    }
    public boolean isExists()
    {
        return exists;
    }

    public String getMember()
    {
        return member;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getDog()
    {
        return dog;
    }

    public String getLinkman()
    {
        return linkman;
    }

    public String getTel()
    {
        return tel;
    }

    public String getAddress()
    {
        return address;
    }

    public String getEmail()
    {
        return email;
    }

    public boolean isRandom()
    {
        return random;
    }

    public int getTemplet()
    {
        return templet;
    }

    public int getTempletstyle()
    {
        return templetstyle;
    }

    public String getGoodman()
    {
        return goodman;
    }

    public String getGoodman_set()
    {
        return goodman_set;
    }

    public String getDogbig()
    {
        return dogbig;
    }

    public String getDogsmall()
    {
        return dogsmall;
    }

    public String getDoghouseC()
    {
        return doghouseC;
    }

    public String getDoghouseE()
    {
        return doghouseE;
    }

    public String getDoghousenum()
    {
        return doghousenum;
    }

    public Date getTimes()
    {
        return times;
    }
    public String getTimesToString()
    {
        if(times==null)
        {
            return "";
        }
        return Csvdoghouse.sdf.format(times);
    }

    public String getExplain() //说明
    {
        return explain;
    }

    public int getTypemi()
    {
        return typemi;
    }

    public int getTypefi()
    {
        return typefi;
    }

    public String getZip()
    {
        return zip;
    }

    public String getHousenumber()
    {
        return housenumber;
    }

    public String getPic()
    {
        return pic;
    }

    public int getSequence()
    {
        return sequence;
    }
    public Date getUpdatetime()
    {
        return updatetime;
    }
    public String getUpdatetimeToString()
    {
        if(updatetime==null)
        {
            return "";
        }
        return Csvdoghouse.sdf.format(updatetime);
    }
    //生成会员编号 2008-04-24 输入的格式为 friststr=02-K-,membertype=A-,B-,C-,D-   07-K-A-0307

    public static String housenumber(String friststr,String membertype) throws SQLException
    {
        int numa = 0, numb = 0, numc = 0, numd = 0,max=0;
        String numas = "", numbs = "", numcs = "", numds = "";
        String strs="";
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeQuery("select max(doghousenum) from Csvdoghouse where doghousenum like  " + db.cite("%" + friststr + "A-" + "%"));
            if (db.next())
            {
                numas = db.getString(1);
            }
            db.executeQuery("select max(doghousenum) from Csvdoghouse where doghousenum like  " + db.cite("%" + friststr + "B-" + "%"));
            if (db.next())
            {
                numbs = db.getString(1);
            }
            db.executeQuery("select max(doghousenum) from Csvdoghouse where doghousenum like  " + db.cite("%" + friststr + "C-" + "%"));
            if (db.next())
            {
                numcs = db.getString(1);
            }
            db.executeQuery("select max(doghousenum) from Csvdoghouse where doghousenum like  " + db.cite("%" + friststr + "D-" + "%"));
            if (db.next())
            {
                numds = db.getString(1);
            }


            if (numas.startsWith(friststr + "A-"))
            {
                numa = Integer.parseInt(numas.substring(7));
            }
            if (numbs.startsWith(friststr + "B-"))
            {
                numb = Integer.parseInt(numbs.substring(7));
            }
            if (numcs.startsWith(friststr + "C-"))
            {
                numc = Integer.parseInt(numcs.substring(7));
            }
            if (numds.startsWith(friststr + "D-"))
            {
                numd = Integer.parseInt(numds.substring(7));
            }
            max = numa > numb ? numa : numb;
            max = numc > max ? numc : max;
            max = numd > max ? numd : max;
            strs =  friststr+membertype;//SeqTable.df4.format(max+1);
        }
        finally
        {
            db.close();
        }
        return strs;
    }
    /****************
     * 2008年6月11日13:38:19
     * private String doghouseC;
     * private String doghouseE;
     * **************/
    public void setDoghouseC(String doghouseC)throws SQLException
    {
        DbAdapter  db = new  DbAdapter();
        try
        {
            db.executeUpdate("Update Csvdoghouse set doghouseC="+db.cite(doghouseC)+" where member="+db.cite(member));
        }
        finally
        {
            db.close();
        }

    }

    public void setDoghouseE(String doghouseE)throws SQLException
       {
           DbAdapter  db = new  DbAdapter();
           try
           {
               db.executeUpdate("Update Csvdoghouse set doghouseE="+db.cite(doghouseE)+" where member="+db.cite(member));
           }
           finally
           {
               db.close();
           }

       }
       public void setAddress(String address)throws SQLException
       {
           DbAdapter  db = new  DbAdapter();
           try
           {
               db.executeUpdate("Update Csvdoghouse set address="+db.cite(address)+" where member="+db.cite(member));
           }
           finally
           {
               db.close();
           }

       }

}
