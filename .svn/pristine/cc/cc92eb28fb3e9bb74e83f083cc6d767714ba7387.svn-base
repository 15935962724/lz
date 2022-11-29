package tea.entity.bpicture;


import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;


public class Bimage extends Entity
{
    private static Cache _cache = new Cache(100);
    private int id;
    private int node; //哪一张图片 可重复
    private String member; //购买者的id
    private String community; //社区
    private String image_use; //图片用途 image_use,image_details,image_print,print_run,inserts,placement,starting_date,duration,territory,country,product_industry,industry_details,picprice，image_size
    private String image_details; //详情使用
    private String image_print; //印数
    private String print_run; //打印张数
    private String inserts;
    private String placement; //应用的位置
    private Date starting_date; //开始时间
    private String duration; //有效期
    private String territory; //领土
    private String country; //国家
    private String product_industry; //产品业
    private String industry_details; //行业信息
    private BigDecimal picprice; //图片的价格
    private String image_size; //印数
    /**
     * 2008年11月19日12:32:11添加   免税价格计算字段 图片选择的大小* **/
    private int picsize; //选择的大小 extralarge,large,medium,smalls,extrasmall
    private int picsalestype; //图片的买卖状态 //0  默认没有被买，1 财务确认。
    private Date picsalesdate; //图片缴费时间
    private String pricemember; //财务审核人员
    private int psize; //订购图片大小
    private int isorder; //是否订购的图片 0 不是  1是
    private Date orderdate; //订购日期

    private boolean exists;

    public Bimage(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Bimage find(int id) throws SQLException
    {
//        Bimage obj = (Bimage) _cache.get(id);
//        if(obj == null)
//        {
//            obj = new Bimage(id);
//            _cache.put(id,obj);
//        }
        return new Bimage(id);
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,node,member,community,image_use,image_details,image_print,print_run,inserts,placement,starting_date,duration,territory,country,product_industry,industry_details,picprice,image_size,picsize,picsalestype,picsalesdate,pricemember,psize,isorder,orderdate from Bimage where id =" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                node = db.getInt(j++);
                member = db.getString(j++);
                community = db.getString(j++);
                image_use = db.getString(j++);
                image_details = db.getString(j++);
                image_print = db.getString(j++);
                print_run = db.getString(j++);
                inserts = db.getString(j++);
                placement = db.getString(j++);
                starting_date = db.getDate(j++);
                duration = db.getString(j++);
                territory = db.getString(j++);
                country = db.getString(j++);
                product_industry = db.getString(j++);
                industry_details = db.getString(j++);
                picprice = db.getBigDecimal(j++,2);
                image_size = db.getString(j++);
                picsize = db.getInt(j++);
                picsalestype = db.getInt(j++);
                picsalesdate = db.getDate(j++);
                pricemember = db.getString(j++);
                psize = db.getInt(j++);
                isorder = db.getInt(j++);
                orderdate = db.getDate(j++);
                exists = true;
                _cache.clear();
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public void set(int id,int node,String member,String community,String image_use,String image_details,String image_print,String print_run,String inserts,String placement,Date starting_date,String duration,String territory,String country,String product_industry,String industry_details,BigDecimal picprice,String image_size) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id   FROM Bimage   WHERE id=" + id);
            if(db.next())
            {
                db.executeUpdate("UPDATE Bimage SET node=" + node + ",member=" + db.cite(member) + ", community=" + db.cite(community) + ", image_use=" + db.cite(image_use) + ",image_details=" + db.cite(image_details) + ",image_print=" + db.cite(image_print) + ",print_run=" + db.cite(print_run) + ",inserts=" + db.cite(inserts) + ",placement=" + db.cite(placement) + ",starting_date=" + db.cite(starting_date) + ",duration=" + db.cite(duration) + ",territory=" + db.cite(territory) + ",country=" + db.cite(country) + ",product_industry=" + db.cite(product_industry) + ",industry_details=" + db.cite(industry_details) + ",picprice=" + picprice + ",image_size=" + db.cite(image_size) + " WHERE id=" + id);
            } else
            {
                db.executeUpdate("INSERT INTO Bimage ([node],[member],[community],[image_use],[image_details],[image_print],[print_run],[inserts],[placement],[starting_date],[duration],[territory],[country],[product_industry],[industry_details],[picprice],image_size)VALUES(" + node + "," + db.cite(member) + "," + db.cite(community) + "," + db.cite(image_use) + "," + db.cite(image_details) + "," + db.cite(image_print) + "," + db.cite(print_run) + "," + db.cite(inserts) + "," + db.cite(placement) + "," + db.cite(starting_date) + "," + db.cite(duration) + "," + db.cite(territory) + "," + db.cite(country) + "," + db.cite(product_industry) + "," + db.cite(industry_details) + "," + picprice + "," + db.cite(image_size) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public void setfalg(int id,int node,String member,String community,String image_use,String image_details,String image_print,String print_run,String inserts,String placement,Date starting_date,String duration,String territory,String country,String product_industry,String industry_details,BigDecimal picprice,String image_size) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id   FROM Bimage   WHERE  node=" + node + " and member=" + db.cite(member));
            if(db.next())
            {
                db.executeUpdate("UPDATE Bimage SET node=" + node + ",member=" + db.cite(member) + ", community=" + db.cite(community) + ", image_use=" + db.cite(image_use) + ",image_details=" + db.cite(image_details) + ",image_print=" + db.cite(image_print) + ",print_run=" + db.cite(print_run) + ",inserts=" + db.cite(inserts) + ",placement=" + db.cite(placement) + ",starting_date=" + db.cite(starting_date) + ",duration=" + db.cite(duration) + ",territory=" + db.cite(territory) + ",country=" + db.cite(country) + ",product_industry=" + db.cite(product_industry) + ",industry_details=" + db.cite(industry_details) + ",picprice=" + picprice + ",image_size=" + db.cite(image_size) + " WHERE id=" + id);
            } else
            {
                db.executeUpdate("INSERT INTO Bimage ([node],[member],[community],[image_use],[image_details],[image_print],[print_run],[inserts],[placement],[starting_date],[duration],[territory],[country],[product_industry],[industry_details],[picprice],image_size)VALUES(" + node + "," + db.cite(member) + "," + db.cite(community) + "," + db.cite(image_use) + "," + db.cite(image_details) + "," + db.cite(image_print) + "," + db.cite(print_run) + "," + db.cite(inserts) + "," + db.cite(placement) + "," + db.cite(starting_date) + "," + db.cite(duration) + "," + db.cite(territory) + "," + db.cite(country) + "," + db.cite(product_industry) + "," + db.cite(industry_details) + "," + picprice + "," + db.cite(image_size) + ")");
            }
        } finally
        {
            db.close();
        }
    }


    public void setRF(int id,int node,int picsize,BigDecimal picprice,String member,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from Bimage   where node=" + node + " and member =" + db.cite(member));
            if(db.next())
            {
                int aa = db.getInt(1);
                db.executeUpdate("Update Bimage set picsize=" + picsize + ",picprice=" + picprice + " where id=" + aa);
            } else
            {
                db.executeUpdate("insert into Bimage (node,picsize,picprice,member,community)values(" + node + "," + picsize + "," + picprice + "," + db.cite(member) + "," + db.cite(community) + ")");

            }
        } finally
        {
            db.close();
        }
    }


    public static void create(int node,int picsize,BigDecimal picprice,String member,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Bimage (node,picsize,picprice,member,community)values(" + node + "," + picsize + "," + picprice + "," + db.cite(member) + "," + db.cite(community) + ")");
        } finally
        {
            db.close();
        }

    }

    public static void createOrder(int node,int picsize,BigDecimal picprice,String member,String community,int psize,int order) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date od = new Date();
        try
        {
            db.executeUpdate("insert into Bimage (node,picsize,picprice,member,community,psize,isorder,orderdate)values(" + node + "," + picsize + "," + picprice + "," + db.cite(member) + "," + db.cite(community) + ","+psize+","+order+","+db.cite(od)+")");
        } finally
        {
            db.close();
        }
    }


    public static void delete(int node,String member,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("delete from bimage where node=" + node + " and member=" + db.cite(member) + " and community=" + db.cite(community));
        } finally
        {
            db.close();
        }

    }


    //判断购买者是否已经预订或购买过此图片
    public static boolean falgSale(int node,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from Bimage where node=" + node + " and member =" + db.cite(member)+" and picsalestype = 0 and picsize != 6");
            if(db.next())
            {
                /*** 相关判断  续费 等以后在添加* **/
                return false;
            } else
            {
                return true;
            }
        } finally
        {
            db.close();
        }
    }


    public static int countPic(String email,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select count(*) from bimage where member=" + db.cite(email) + " " + sql);
            while(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }


    public static int countNoPrice(String email) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select count(*) from bimage where member=" + db.cite(email) + " and picprice=0");
            while(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public static int countAll(String community,String str) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select count(*) from bimage where community=" + db.cite(community) + " " + str);
            //System.out.println("select count(*) from bimage where community="+db.cite(community)+" "+str);
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }

    public static BigDecimal getsum(String str,String sql) throws SQLException
    {

        BigDecimal bd = new BigDecimal(0);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" select " + str + " from Bimage where 1=1 " + sql);
            if(db.next())
            {
                bd = db.getBigDecimal(1,2);
            }

        } finally
        {
            db.close();

        }
        return bd;
    }

    public static Enumeration noPriceImage(String email,String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {

            db.executeQuery("select node from bimage where member=" + db.cite(email) + " and picprice=0 " + sql);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    public static BigDecimal countSumMoney(String sql) throws SQLException
    {

        BigDecimal sum = new BigDecimal("0");
        DbAdapter db = new DbAdapter();
        try
        {
            //System.out.print("select sum(picprice) from bimage where 1=1 " + sql + " and picprice!=0");
            db.executeQuery("select sum(picprice) from bimage where 1=1 " + sql + " and picprice!=0");
            if(db.next())
            {
                sum = db.getBigDecimal(1,2);
            }
        } finally
        {
            db.close();
        }

        return sum;
    }

    public static int countOrfer(String sql) throws SQLException
       {
           int i = 0;
           DbAdapter db = new DbAdapter();
           try
           {
               db.executeQuery("select count(*) from bimage where 1=1"+sql);
               while(db.next())
               {
                   i = db.getInt(1);
               }
           } finally
           {
               db.close();
           }
           return i;
    }
    public static Enumeration findShopping(String sql) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter(1);
        try
        {

            db.executeQuery("SELECT id FROM bimage WHERE 1=1" + sql);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    public static java.util.Enumeration findByCommunity(String community,String sql,int pos,int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM bimage WHERE  community=" + DbAdapter.cite(community) + sql);
            for(int l = 0;l < pos + pageSize && db.next();l++)
            {
                if(l >= pos)
                {
                    vector.addElement(new Integer(db.getString(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static boolean falgfind(String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter(1);
        try
        {

            db.executeQuery("SELECT id FROM bimage WHERE 1=1 and " + sql);
            if(db.next())
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

    public String getCommunity()
    {
        return community;
    }

    public String getCountry()
    {
        return country;
    }

    public String getDuration()
    {
        return duration;
    }

    public String getImage_details()
    {
        return image_details;
    }

    public String getImage_print()
    {
        return image_print;
    }

    public String getImage_use()
    {
        return image_use;
    }

    public String getIndustry_details()
    {
        return industry_details;
    }

    public String getInserts()
    {
        return inserts;
    }

    public String getMember()
    {
        return member;
    }

    public int getNode()
    {
        return node;
    }

    public BigDecimal getPicprice()
    {
        return picprice;
    }

    public String getPlacement()
    {
        return placement;
    }

    public String getPrint_run()
    {
        return print_run;
    }

    public String getProduct_industry()
    {
        return product_industry;
    }

    public Date getStarting_date()
    {
        return starting_date;
    }

    public String getStarting_datetoString()
    {
        if(starting_date != null)
        {
            return Bimage.sdf.format(starting_date);
        } else
        {
            return "";
        }
    }

    public String getTerritory()
    {
        return territory;
    }

    public int getId()
    {
        return id;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getImage_size()
    {
        return image_size;
    }

    public int getPicsize()
    {
        return picsize;
    }

    public int getPicsalestype()
    {
        return picsalestype;
    }

    public Date getPicsalesdate()
    {
        return picsalesdate;
    }

    public String getPricemember()
    {
        return pricemember;
    }

    public int getIsorder()
    {
        return isorder;
    }

    public int getPsize()
    {
        return psize;
    }

    public Date getOrderdate()
    {
        return orderdate;
    }

    public String getOrderToString()
    {
        String dt = "";
        if(orderdate!=null){
            dt = this.sdf.format(orderdate);
        }
        return dt;
    }

    public String getPicsalesdateToString()
    {
        if(picsalesdate != null)
        {
            return Bimage.sdf.format(picsalesdate);
        } else
        {
            return "";
        }
    }

    public static void enterPrice(int id,String pricemember) throws SQLException
    {
//        private int picsalestype;//图片的买卖状态 //0  默认没有被买，1 财务确认。
//    private Date picsalesdate;//图片缴费时间
        DbAdapter db = new DbAdapter();
        Date date = new Date();
        try
        {
            db.executeUpdate("Update Bimage set picsalestype=1,picsalesdate=" + db.cite(date) + ",pricemember=" + db.cite(pricemember) + "  where id=" + id);
        } finally
        {
            db.close();
        }
    }
}
