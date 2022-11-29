package tea.entity.admin;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.GregorianCalendar;
import java.util.Hashtable;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;
import tea.entity.member.Profile;

//OA 流程 项目
public class Flowitem extends Entity
{
    private boolean exists;
    private static Cache _cache = new Cache(100);
    public static final String STATES_TYPE[] =
            {"新建中","运行中","已完成"};
    private String community;
    private int flowitem;
    private int workproject; // 客户
    private String manager; // 项目经理
    private String member; // 项目参与者
    private String creator;
    private Hashtable _htLayer;
    private java.util.Date ctime;
    private java.util.Date ftime;
    private int states = -1;

    public static final String ITEMGENRE_TYPE[] =
            {"-----------","洽谈中","进行中","维护中","已完成","已取消","搜索结果"}; // 项目类型

    private int itemgenre; // 项目类型
    private int cost; // 预计成本
    private int overallmoney; // 项目总金额

    private String pact; // 合同号
    private Date pacttime; //合同截止时间
    private BigDecimal vindicate; // 维护费
    private int period; //维护周期 0 代表年，1代表月，2代表一次性
    private Date nextcosttime; // 下次交费日期
    private int type; //标示 0 代表添加的项目
    private String pactfile;
    private String pactfilename;
    private int filecenter;
    //在文件中心生成的id
    private int fileid;
    //等交费的客户 临时表

//	其它成本:
    private BigDecimal otherexpenses = BigDecimal.ZERO;
//	   其它成本说明:
    private String otherexplain;
//	 市场费用:
    private BigDecimal marketcost = BigDecimal.ZERO;
//	   市场费用说明:
    private String marketexplain;
//	 预计利润:
    private BigDecimal profits = BigDecimal.ZERO;
    //盈利 0，非盈利的标示  1
    private int eatype;

    //最有交费日期
    private Date lastcosttime;
    
    class Layer
    {
        String name;
        String content;
        String otherexplain;
        String marketexplain;
    }


//    static
//    {
/////////
//    }

    public Flowitem(int flowitem) throws SQLException
    {
        this.flowitem = flowitem;
        _htLayer = new Hashtable();
        load();
    }

    public static Flowitem find(int flowitem) throws SQLException
    {
        Flowitem obj = (Flowitem) _cache.get(new Integer(flowitem));
        if(obj == null)
        {
            obj = new Flowitem(flowitem);
            _cache.put(new Integer(flowitem),obj);
        }
        return obj;
    }

    //
    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flowitem FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }

        return vector.elements();
    }

    //2009年6月8日11:44:40 小唐
    public static int setEatype(String community,String sql) throws SQLException
    {
        int c = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flowitem FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                int fid = db.getInt(1);
                Flowitem fobj = Flowitem.find(fid);
                //实际收入-市场费用-人员成本-其它成本-公司利润）
                java.math.BigDecimal bonus = Already.getAmountTotalSum(fid," and atype=0").subtract(Already.getAmountTotalSum(fid," and atype=1")).subtract(new java.math.BigDecimal(Worklog.getMembercost(community,fid))).subtract(Already.getAmountTotalSum(fid," and atype=2"));
                if(bonus.compareTo(new java.math.BigDecimal("0")) == 1 || bonus.compareTo(new java.math.BigDecimal("0")) == 0)
                {
                    fobj.setEatype(0);
                }

                if(bonus.compareTo(new java.math.BigDecimal("0")) == -1)
                {
                    fobj.setEatype(1);
                }
            }
        } finally
        {
            db.close();
        }

        return c;

    }

    //2009年6月8日11:41:55 小唐 修改
    public static void setEatype2(int flowitem) throws SQLException
    {
        int c = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            int fid = flowitem;
            Flowitem fobj = Flowitem.find(fid);
            //实际收入-市场费用-人员成本-其它成本-公司利润）Already.getAmountTotalSum(fid," and atype=0")  Already.getAmountTotalSum(fid," and atype=1 ")   Already.getAmountTotalSum(fid," and atype=2 ")
            java.math.BigDecimal bonus = Already.getAmountTotalSum(fid," and atype=0").subtract(Already.getAmountTotalSum(fid," and atype=1 ")).subtract(new java.math.BigDecimal(Worklog.getMembercost(fobj.getCommunity(),fid))).subtract(Already.getAmountTotalSum(fid," and atype=2 "));

            if(bonus.compareTo(new java.math.BigDecimal("0")) == 1 || bonus.compareTo(new java.math.BigDecimal("0")) == 0)
            {
                fobj.setEatype(0);
            }

            if(bonus.compareTo(new java.math.BigDecimal("0")) == -1)
            {
                fobj.setEatype(1);
            }
        } finally
        {
            db.close();
        }
    }


    public static Enumeration find2(String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flo2 FROM Flowitem2 WHERE 1=1 " + sql,pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }

        return vector.elements();
    }

    //维护费用合计 张金舒 2009-05-05
    public static java.math.BigDecimal getCost(String community,String sql) throws SQLException
    {
        java.math.BigDecimal cost = new java.math.BigDecimal("0");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT vindicate FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                cost = cost.add(db.getBigDecimal(1,2));
            }
        } finally
        {
            db.close();
        }
        return cost;

    }


    //修改项目记录，根据维护日期 添加项目记录 张金舒 2009-05-06
    public static void setPeriod(String community,int language) throws SQLException
    {
        java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy-MM-dd"); //yyyy-MM-dd
        GregorianCalendar gc = new GregorianCalendar();

        Date d = new Date();
        String times = sdf.format(new Date()); //当前日期

        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();

        try
        {
            db.executeQuery("SELECT flowitem FROM Flowitem WHERE type = 0  AND community =" + db.cite(community));
            while(db.next())
            {
                Flowitem fobj = Flowitem.find(db.getInt(1));
                Date d2 = fobj.getNextcosttime();
                if(fobj.getNextcosttime() != null && fobj.pacttime != null)
                {
                    if(fobj.getPeriod() == 1) //月
                    {
                        int ds = Flowitem.dispersionMonth2(times,fobj.getPacttimeToString());
                        for(int i = 1;i <= ds;i++)
                        {
                            gc.setTime(d2);
                            gc.add(2, +1);
                            gc.set(gc.get(Calendar.YEAR),gc.get(Calendar.MONTH),gc.get(Calendar.DATE));
                            d = gc.getTime();

                            if(!fobj.isFlo(db.getInt(1),sdf.format(d)) && d.compareTo(fobj.getPacttime()) != 1)
                            {
                                Flowitem.create(community,fobj.getWorkproject(),fobj.getManager(),fobj.getMember(),fobj.getCreator(),fobj.getFtime(),fobj.getLanguage(language),
                                                fobj.getName(language),fobj.getContent(language),fobj.getItemgenre(),fobj.getCost(),fobj.getOverallmoney(),fobj.getPact(),fobj.getVindicate(),d,
                                                fobj.getPeriod(),db.getInt(1),fobj.getPacttime(),fobj.getPactfile(),fobj.getPactfilename(),
                                                fobj.getFilecenter(),0,fobj.getOtherexpenses(),fobj.getOtherexplain(language),fobj.getMarketcost(),fobj.getMarketexplain(language),fobj.getProfits(),fobj.getLastcosttime());
                            }

                            //
                            d2 = d;
                        }

                    }
                    if(fobj.getPeriod() == 0) //年
                    {
                        gc.setTime(fobj.getNextcosttime());
                        gc.add(1, +1);
                        gc.set(gc.get(Calendar.YEAR),gc.get(Calendar.MONTH),gc.get(Calendar.DATE));
                        d = gc.getTime();
                        if(!fobj.isFlo(db.getInt(1),sdf.format(d)) && d.compareTo(fobj.getPacttime()) != 1)
                        {
                            Flowitem.create(community,fobj.getWorkproject(),fobj.getManager(),fobj.getMember(),fobj.getCreator(),fobj.getFtime(),
                                            fobj.getLanguage(language),fobj.getName(language),fobj.getContent(language),fobj.getItemgenre(),
                                            fobj.getCost(),fobj.getOverallmoney(),fobj.getPact(),fobj.getVindicate(),d,fobj.getPeriod(),
                                            db.getInt(1),fobj.getPacttime(),fobj.getPactfile(),fobj.getPactfilename(),fobj.getFilecenter(),0,
                                            fobj.getOtherexpenses(),fobj.getOtherexplain(language),fobj.getMarketcost(),fobj.getMarketexplain(language),fobj.getProfits(),fobj.getLastcosttime());
                        }
                    }
                    if(fobj.getPeriod() == 2) //一次性
                    {
                        fobj.delete5(db.getInt(1));
                    }
                    if(fobj.isFlo(db.getInt(1),sdf.format(fobj.getNextcosttime())))
                    {
                        fobj.delete2(db.getInt(1),fobj.getNextcosttime());
                    }
                    fobj.delete3(db.getInt(1),fobj.getPacttime());
                    fobj.delete4(db.getInt(1),fobj.getNextcosttime());

                }
            }
        } finally
        {
            db.close();
            db2.close();
        }
    }

    public boolean isFlo(int flowitem,String times) throws SQLException
    {
        boolean f = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flowitem FROM Flowitem WHERE  type =" + flowitem + " AND nextcosttime=" + db.cite(times));
            if(db.next())
            {
                f = true;
            }
        } finally
        {
            db.close();
        }
        return f;
    }


    public void delete2(int flowitem,Date times) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Flowitem WHERE type=" + flowitem + " AND nextcosttime=" + db.cite(times));
        } finally
        {
            db.close();
        }

    }

    public void delete3(int flowitem,Date pacttime) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Flowitem WHERE type=" + flowitem + " AND nextcosttime>" + db.cite(pacttime));
        } finally
        {
            db.close();
        }

    }

    public void delete4(int flowitem,Date pacttime) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Flowitem WHERE type=" + flowitem + " AND nextcosttime<" + db.cite(pacttime));

        } finally
        {
            db.close();
        }

    }

    public void delete5(int flowitem) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Flowitem WHERE type=" + flowitem);
        } finally
        {
            db.close();
        }

    }

    public static int dispersionMonth2(String strDate1,String strDate2)
    {
        int iMonth = 0;
        int flag = 0;
        try
        {
            Calendar objCalendarDate1 = Calendar.getInstance();
            objCalendarDate1.setTime(DateFormat.getDateInstance().parse(strDate1));

            Calendar objCalendarDate2 = Calendar.getInstance();
            objCalendarDate2.setTime(DateFormat.getDateInstance().parse(strDate2));

            if(objCalendarDate2.equals(objCalendarDate1))
            {
                return 0;
            }
            if(objCalendarDate1.after(objCalendarDate2))
            {
                Calendar temp = objCalendarDate1;
                objCalendarDate1 = objCalendarDate2;
                objCalendarDate2 = temp;
            }
            if(objCalendarDate2.get(Calendar.DAY_OF_MONTH) < objCalendarDate1.get(Calendar.DAY_OF_MONTH))
            {
                flag = 1;
            }

            if(objCalendarDate2.get(Calendar.YEAR) > objCalendarDate1.get(Calendar.YEAR))
            {
                iMonth = ((objCalendarDate2.get(Calendar.YEAR) - objCalendarDate1.get(Calendar.YEAR)) * 12
                          + objCalendarDate2.get(Calendar.MONTH) - flag) - objCalendarDate1.get(Calendar.MONTH);
            } else
            {
                iMonth = objCalendarDate2.get(Calendar.MONTH) - objCalendarDate1.get(Calendar.MONTH) - flag;
            }

        } catch(Exception e)
        {
        }
        return iMonth;
    }

    // 根据项目号取得客户号
    public static int findByFlowitem(String community,String sql) throws SQLException
    {
        int workproject = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT workproject FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                workproject = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return workproject;
    }

//项目合计汇总 2009年6月8日14:04:02 唐
    public static BigDecimal getCollect(String community,String field,String sql) throws SQLException
    {
        BigDecimal c = new BigDecimal("0");
        DbAdapter db = new DbAdapter();
        try
        {
            if(field.equals("overallmoney"))
            {
                db.executeQuery("SELECT SUM(overallmoney) FROM flowitem WHERE community=" + DbAdapter.cite(community) + sql);
                if(db.next())
                {
                    c = db.getBigDecimal(1,2);
                }
            } else
            {
                db.executeQuery("SELECT SUM(amount) FROM Already WHERE flowitem  in (select  flowitem FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql + ")" + " and atype=" + field);
                if(db.next())
                {
                    c = db.getBigDecimal(1,2);
                }
            }
        } finally
        {
            db.close();
        }
        return c;
    }

    //实时项目收益 项目合计汇总
    public static BigDecimal getCollect2(String community,String field,String sql) throws SQLException
    {
        BigDecimal c = new BigDecimal("0");
        DbAdapter db = new DbAdapter();
        try
        {
            if(field.equals("overallmoney"))
            {
                db.executeQuery("SELECT SUM(overallmoney) FROM flowitem WHERE flowitem  in (select  flowitem FROM Already where community=" + DbAdapter.cite(community) + sql + ")");
                if(db.next())
                {
                    c = db.getBigDecimal(1,2);
                }
            } else
            {
                db.executeQuery("SELECT SUM(amount) FROM Already WHERE  community=" + DbAdapter.cite(community) + sql + " and atype=" + field);
                if(db.next())
                {
                    c = db.getBigDecimal(1,2);
                }
            }
        } finally
        {
            db.close();
        }
        return c;
    }

//公司投入
    public static BigDecimal getNoCollect(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        BigDecimal m = new BigDecimal("0");
        try
        {

            db.executeQuery("SELECT flowitem FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                int fid = db.getInt(1);
                Flowitem fobj = Flowitem.find(fid);
                //公司投入=实际收入-市场费用-人员成本-其它成本）

                java.math.BigDecimal profits = Already.getAmountTotalSum(fid," and atype=0 ").subtract(Already.getAmountTotalSum(fid," and atype=1 ")).subtract(new java.math.BigDecimal(Worklog.getMembercost(community,fid))).subtract(Already.getAmountTotalSum(fid," and atype=2 "));
                profits = new java.math.BigDecimal("0").subtract(profits);
                m = m.add(profits);
            }

        } finally
        {
            db.close();
        }
        return m;
    }

//公司利润
    public static String[] getCompanyProfits(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        BigDecimal m = new BigDecimal("0");
        String[] sa = new String[2];
        //公司利润
        java.math.BigDecimal sp1 = new java.math.BigDecimal("0");
        //人员奖金
        java.math.BigDecimal sp2 = new java.math.BigDecimal("0");
        try
        {

            db.executeQuery("SELECT flowitem FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                int fid = db.getInt(1);
                Flowitem fobj = Flowitem.find(fid);
                //人员奖金=实际收入-市场费用-人员成本-其它成本-公司利润）
                java.math.BigDecimal bonus = new java.math.BigDecimal("0");
                //公司利润
                java.math.BigDecimal profits = new java.math.BigDecimal("0");
                java.math.BigDecimal gs = new java.math.BigDecimal("0");
                //自动计算：实际收入-市场费用-人员成本-其它成本
                gs = Already.getAmountTotalSum(fid," and atype=0 ").subtract(Already.getAmountTotalSum(fid," and atype=1 ")).subtract(new java.math.BigDecimal(Worklog.getMembercost(community,fid))).subtract(Already.getAmountTotalSum(fid," and atype=2 "));
                System.out.print(gs);
                //如果 gs> 预计利润 则 公司利润显示 是 预计利润 人员奖金 显示为 余数
                if(gs.compareTo(fobj.getProfits()) == 1)
                {
                    profits = fobj.getProfits();
                    bonus = Already.getAmountTotalSum(fid," and atype=0 ").subtract(Already.getAmountTotalSum(fid," and atype=1 ")).subtract(new java.math.BigDecimal(Worklog.getMembercost(community,fid))).subtract(Already.getAmountTotalSum(fid," and atype=2 ")).subtract(fobj.getProfits());
                } else if(gs.compareTo(fobj.getProfits()) == 0)
                {
                    profits = fobj.getProfits();
                } else if(gs.compareTo(fobj.getProfits()) == -1)
                {
                    profits = gs;
                }
                sp1 = sp1.add(profits);
                sp2 = sp2.add(bonus);
            }

            sa[0] = String.valueOf(sp1);
            sa[1] = String.valueOf(sp2);

        } finally
        {
            db.close();
        }
        return sa;
    }


    //项目的实际收入
    public static BigDecimal getAmountTotal(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        BigDecimal m = new BigDecimal("0");
        try
        {

            db.executeQuery("SELECT flowitem FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                int fid = db.getInt(1);
                m = m.add(Already.getAmountTotalSum(fid," and  atype=0"));
            }

        } finally
        {
            db.close();
        }
        return m;
    }

    //项目的实际收入
    public static BigDecimal getAmountTotal(String community,String sql,int atype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        BigDecimal m = new BigDecimal("0");
        try
        {

            db.executeQuery("SELECT flowitem FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                int fid = db.getInt(1);
                m = m.add(Already.getAmountTotalSum(fid," and  atype=0"));
            }

        } finally
        {
            db.close();
        }
        return m;
    }


    //人员成本
    public static BigDecimal getMembercost(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        BigDecimal m = new BigDecimal("0");
        try
        {

            db.executeQuery("SELECT flowitem FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                int fid = db.getInt(1);
                m = m.add(new BigDecimal(Worklog.getMembercost(community,fid)));
            }

        } finally
        {
            db.close();
        }
        return m;
    }

//人员奖金
    public static BigDecimal getBonus(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        BigDecimal m = new BigDecimal("0");
        try
        {

            db.executeQuery("SELECT flowitem FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                int fid = db.getInt(1);
                Flowitem fobj = Flowitem.find(fid);
                //人员奖金=实际收入-市场费用-人员成本-其它成本-公司利润）
                java.math.BigDecimal bonus = Already.getAmountTotalSum(fid," and atype=0 ").subtract(Already.getAmountTotalSum(fid," and atype=1 ")).subtract(new java.math.BigDecimal(Worklog.getMembercost(community,fid))).subtract(Already.getAmountTotalSum(fid," and atype=2 ")).subtract(fobj.getProfits());
                m = m.add(bonus);
            }
        } finally
        {
            db.close();
        }
        return m;
    }


    public static int count(String community,String sql) throws SQLException
    {
        int cout = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(flowitem) FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                cout = db.getInt(1);
            }
        } catch(SQLException ex)
        {
            ex.printStackTrace();
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
        return cout;
    }

    public static java.util.Enumeration find(String community,String sql) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flowitem FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration findzuijin(String community,String sql,String member) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        StringBuffer a = new StringBuffer("0");
        int num = 0;
        try
        {
            db.executeQuery("select  workproject,worklog from Worklog where member=" + db.cite(member) + " order by  worklog  desc");
            while(db.next())
            {
                num = db.getInt(1);
                if(a.indexOf("," + num) != -1)
                {

                } else
                {
                    a.append(",").append(num);
                }
            }
            String str[] = a.toString().split(",");
            int j = 0;
            for(int i = 1;i < str.length;i++)
            {
                if(j < 10)
                {
                    db.executeQuery("SELECT flowitem FROM Flowitem WHERE flowitem=" + Integer.parseInt(str[i]));
                    if(db.next())
                    {
                        vector.addElement(new Integer(str[i]));
                        j++;
                    }
                } else
                {
                    return vector.elements();
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration find1(String community,String sql,int pos,int size) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flowitem FROM Flowitem WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    public static java.util.Enumeration findByWorkproject(int workproject) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT flowitem FROM Flowitem WHERE workproject=" + workproject);
            while(db.next())
            {
                vector.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Flowitem WHERE flowitem=" + flowitem);
            db.executeUpdate("DELETE FROM FlowitemLayer WHERE flowitem=" + flowitem);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(flowitem));
    }

    public static void delete(int w) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Flowitem WHERE workproject=" + w);
            // db.executeUpdate("DELETE FROM FlowitemLayer WHERE flowitem=" + flowitem);
        } finally
        {
            db.close();
        }
        //_cache.remove(new Integer(flowitem));
    }


    public void set(String manager,int workproject,String member,String creator,java.util.Date ftime,int language,String name,String content,int itemgenre,int cost,int overallmoney,
                    String pact,java.math.BigDecimal vindicate,java.util.Date nextcosttime,int period,int type,Date pacttime,String pactfile,String pactfilename,
                    int filecenter,BigDecimal otherexpenses,String otherexplain,BigDecimal marketcost,String marketexplain,BigDecimal profits,Date lastcosttime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowitem SET workproject=" + workproject + ",manager=" + DbAdapter.cite(manager) + ",member =" + DbAdapter.cite(member) + ",creator =" + DbAdapter.cite(creator) +
                             ",ftime =" + DbAdapter.cite(ftime) + ",itemgenre=" + itemgenre + ",cost=" + cost + ",overallmoney=" + overallmoney + ",pact=" + DbAdapter.cite(pact) + ",vindicate=" + vindicate +
                             ",nextcosttime=" + DbAdapter.cite(nextcosttime) + ",period=" + period + ",type = " + type + ",pacttime=" + db.cite(pacttime) + ",pactfile=" + db.cite(pactfile) +
                             ",pactfilename=" + db.cite(pactfilename) + ",filecenter=" + filecenter + ",fileid=" + fileid + ",otherexpenses=" + otherexpenses + ",marketcost=" + marketcost +
                             ",profits=" + profits + ",lastcosttime=" + DbAdapter.cite(lastcosttime) + " WHERE flowitem=" + flowitem);

            int j = db.executeUpdate("UPDATE FlowitemLayer SET name=" + DbAdapter.cite(name) + ",content=" + DbAdapter.cite(content) + ",otherexplain=" + db.cite(otherexplain) + ",marketexplain=" + db.cite(marketexplain) + " WHERE flowitem=" + flowitem + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO FlowitemLayer(flowitem,language,name,content,otherexplain,marketexplain)VALUES(" + flowitem + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + "," + db.cite(otherexplain) + "," + db.cite(marketexplain) + "  )");
            }
        } finally
        {
            db.close();
        }
        this.workproject = workproject;
        this.manager = manager;
        this.member = member;
        this.ftime = ftime;
        this.pact = pact;
        this.vindicate = vindicate;
        this.nextcosttime = nextcosttime;
        this.cost = cost;
        this.itemgenre = itemgenre;
        this.creator = creator;
        this.overallmoney = overallmoney;
        this.period = period;
        this.type = type;
        this.pacttime = pacttime;
        this.pactfile = pactfile;
        this.pactfilename = pactfilename;
        this.filecenter = filecenter;
        this.otherexpenses = otherexpenses;
        this.otherexplain = otherexplain;
        this.marketcost = marketcost;
        this.marketexplain = marketexplain;
        this.profits = profits;
        this.lastcosttime = lastcosttime;

        _htLayer.clear();
        // _cache.remove(new Integer(flow));
    }

    public void setEatype(int eatype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowitem SET eatype=" + eatype + " WHERE flowitem=" + flowitem);
        } finally
        {
            db.close();
        }
        this.eatype = eatype;
        _htLayer.clear();
    }


    //chenjian
    public void setNameAndNext(String name,java.util.Date nextcosttime,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowitem SET nextcosttime=" + DbAdapter.cite(nextcosttime) + " WHERE flowitem=" + flowitem);
            db.executeUpdate("UPDATE FlowitemLayer SET name=" + DbAdapter.cite(name) + " WHERE flowitem=" + flowitem + " AND language=" + language);

        } finally
        {
            db.close();
        }
        this.nextcosttime = nextcosttime;

        _htLayer.clear();
        // _cache.remove(new Integer(flow));
    }

    public void setType(int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowitem SET type=" + type + " WHERE flowitem=" + flowitem);
        } finally
        {
            db.close();
        }
        this.type = type;
        _htLayer.clear();
    }

    public void setFileid(int fileid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flowitem SET fileid=" + fileid + " WHERE flowitem=" + flowitem);
        } finally
        {
            db.close();
        }
        this.fileid = fileid;
        _htLayer.clear();
    }


    public static void create(String community,int workproject,String manager,String member,String creator,java.util.Date ftime,int language,String name,String content,
                              int itemgenre,int cost,int overallmoney,String pact,java.math.BigDecimal vindicate,java.util.Date nextcosttime,int period,int type,
                              Date pacttime,String pactfile,String pactfilename,int filecenter,int fileid,BigDecimal otherexpenses,String otherexplain,
                              BigDecimal marketcost,String marketexplain,BigDecimal profits,Date lastcosttime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Flowitem(community,workproject,manager,member,creator,ctime,ftime,itemgenre,cost,overallmoney,pact,vindicate,nextcosttime,period,type,pacttime,pactfile," +
                             " pactfilename,filecenter,fileid,otherexpenses,marketcost,profits,lastcosttime) VALUES (" + DbAdapter.cite(community) + "," + workproject + "," + DbAdapter.cite(manager) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(creator) + "," + DbAdapter.cite(new java.util.Date()) + "," + DbAdapter.cite(ftime) + "," + itemgenre + "," + cost + "," + overallmoney + "," + DbAdapter.cite(pact) + "," + vindicate + ","
                             + DbAdapter.cite(nextcosttime) + "," + period + "," + type + "," + db.cite(pacttime) + "," + db.cite(pactfile) + "," + db.cite(pactfilename) + "," +
                             +(filecenter) + "," + fileid + "," + otherexpenses + "," + marketcost + "," + profits + "," + DbAdapter.cite(lastcosttime) + " )");
            int flowitem = db.getInt("SELECT MAX(flowitem) FROM Flowitem");
            Flowitem.setEatype2(flowitem);
            db.executeUpdate("INSERT INTO FlowitemLayer(flowitem,language,name,content,otherexplain,marketexplain)VALUES(" + flowitem + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(content) + "," + db.cite(otherexplain) + "," + db.cite(marketexplain) + "  )");
        } finally
        {
            db.close();
        }

    }


    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,workproject,manager,member,creator,ctime,ftime,itemgenre,cost,overallmoney,pact,vindicate,nextcosttime,period,type,pacttime,pactfile,pactfilename,filecenter,fileid,otherexpenses,marketcost,profits,eatype,lastcosttime  FROM Flowitem WHERE flowitem=" + flowitem);
            if(db.next())
            {
                community = db.getString(1);
                workproject = db.getInt(2);
                manager = db.getString(3);
                member = db.getString(4);
                creator = db.getString(5);
                ctime = db.getDate(6);
                ftime = db.getDate(7);
                itemgenre = db.getInt(8);
                cost = db.getInt(9);
                overallmoney = db.getInt(10);
                pact = db.getString(11);
                vindicate = db.getBigDecimal(12,2);
                nextcosttime = db.getDate(13);
                period = db.getInt(14);
                type = db.getInt(15);
                pacttime = db.getDate(16);
                pactfile = db.getString(17);
                pactfilename = db.getString(18);
                filecenter = db.getInt(19);
                fileid = db.getInt(20);
                otherexpenses = db.getBigDecimal(21,2);
                marketcost = db.getBigDecimal(22,2);
                profits = db.getBigDecimal(23,2);
                eatype = db.getInt(24);
                lastcosttime = db.getDate(25);
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


    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getMember()
    {
        return member;
    }

    public String getManager()
    {
        return manager;
    }

    public int getType()
    {
        return type;
    }

    public int getEatype()
    {
        return eatype;
    }


    public String getManagerToHtml(int language) throws SQLException
    {
        String ms[] = manager.split("/");
        StringBuilder sb = new StringBuilder();
        for(int i = 1;i < ms.length;i++)
        {
            Profile p = Profile.find(ms[i]);
            sb.append(p.getName(language)).append("( ").append(ms[i]).append(" )<br>");
        }
        return sb.toString();
    }

    public Date getFtime()
    {
        return ftime;
    }

    public String getFtimeToString()
    {
        return sdf.format(ftime);
    }

    public int getFlowitem()
    {
        return flowitem;
    }

    public Date getCtime()
    {
        return ctime;
    }

    public String getCtimeToString()
    {
        return sdf.format(ctime);
    }

    public String getCreator()
    {
        return creator;
    }

    public String getCreatorToHtml(int language) throws SQLException
    {
        String cs[] = creator.split("/");
        StringBuilder sb = new StringBuilder();
        for(int i = 1;i < cs.length;i++)
        {
            Profile p = Profile.find(cs[i]);
            sb.append(p.getName(language)).append("( ").append(cs[i]).append(" )<br>");
        }
        return sb.toString();
    }

    public String getName(int language) throws SQLException
    {
        return getLayer(language).name;
    }

    public String getContent(int language) throws SQLException
    {
        return getLayer(language).content;
    }

    public String getOtherexplain(int language) throws SQLException
    {
        return getLayer(language).otherexplain;
    }

    public String getMarketexplain(int language) throws SQLException
    {
        return getLayer(language).marketexplain;
    }


    public int getItemgenre()
    {
        return itemgenre;
    }

    public int getCost()
    {
        return cost;
    }

    public int getOverallmoney()
    {
        return overallmoney;
    }

    public String getPact()
    {
        return pact;
    }

    public BigDecimal getVindicate()
    {
        return vindicate;
    }

    public Date getNextcosttime()
    {
        return nextcosttime;
    }

    //2008-12.03 zhangjinshu添加
    public String getNextcosttimeToString()
    {
        if(nextcosttime == null)
        {
            return "";
        }
        return sdf.format(nextcosttime);
    }

    public Date getPacttime()
    {
        return pacttime;
    }

    public String getPacttimeToString()
    {
        if(pacttime == null)
        {
            return "";
        }
        return sdf.format(pacttime);
    }

    public int getPeriod()
    {
        return period;
    }

    public String getPactfile()
    {
        return pactfile;
    }

    public String getPactfilename()
    {
        return pactfilename;
    }

    public int getFilecenter()
    {
        return filecenter;
    }

    public int getFileid()
    {
        return fileid;
    }

    public BigDecimal getOtherexpenses()
    {
        return otherexpenses;
    }

    public BigDecimal getMarketcost()
    {
        return marketcost;
    }

    public BigDecimal getProfits()
    {
        return profits;
    }

    public Date getLastcosttime() {
		return lastcosttime;
	}

	public void setLastcosttime(Date lastcosttime) {
		this.lastcosttime = lastcosttime;
	}
	public String getLastcosttimeToString(){
	    return sdf.format(lastcosttime);
	}
	private Layer getLayer(int language) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(language));
        if(layer == null)
        {
            layer = new Layer();
            int j = this.getLanguage(language);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name,content,otherexplain,marketexplain FROM FlowitemLayer WHERE flowitem=" + flowitem + " AND language=" + j);
                if(db.next())
                {
                    layer.name = db.getVarchar(j,language,1);
                    layer.content = db.getText(j,language,2);
                    layer.otherexplain = db.getVarchar(j,language,3);
                    layer.marketexplain = db.getVarchar(j,language,4);

                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(language),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM FlowitemLayer WHERE flowitem=" + flowitem);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public int getStates() throws SQLException
    {
        if(states < 0)
        {
            // 事务中不存在:新建中
            java.util.Enumeration e = Flowbusiness.find(flowitem,"");
            if(!e.hasMoreElements())
            {
                states = 0;
            } else
            {
                states = 2;
                while(e.hasMoreElements())
                {
                    int id = ((Integer) e.nextElement()).intValue();
                    Flowbusiness fb = Flowbusiness.find(id);
                    if(fb.getStep() > 0) // 如果有些事务没有结束:运行中
                    {
                        states = 1;
                        break;
                    }
                }
            }
        }
        return states;
    }

    public int getWorkproject()
    {
        return workproject;
    }

    /**
     * 唐嗣达 2008年11月20日9:30:33
     * */
    public static boolean getflag(int workproject) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select * from Flowitem where  Workproject=" + workproject);
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
}
