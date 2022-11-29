package tea.entity.member;

import java.io.*;
import java.math.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.util.*;
import tea.translator.*;

public class Trade extends Entity implements Serializable
{
    public static final int TRADES_NEW = 0; // 新订单
    public static final int TRADES_CANCEL = 1; // 取消订单
    // public static final int TRADES_INCEPT = 2; //接收
    public static final int TRADES_CONFIRMED = 2; // 确认
    // public static final int TRADES_PAYMENT = 3; //付款
    public static final int TRADES_UNSHIPPED = 3; // 准备发货
    // public static final int TRADES_APPROVED_SHIPPED = 5; //已经发货
    public static final int TRADES_REJECTED = 4; // 拒收
    public static final int TRADES_FINISHED = 5; // 完成
    // public static final int TRADES_RECONFIRM = 3;
    public static final int TRADES_REFUND = 6;
    // public static final int TRADES_PENDING_REFUND = 7;
    // public static final int TRADES_IGNORED_REFUND = 8;
    public static final int TRADES_APPROVED_REFUND = 7;
    // public static final int TRADES_PENDING = 10;
    public static final String TRADE_STATUS[] =
            {"NewOrder","CancelOrder","Confirmed","Unshipped","Rejected","Finished","Refund","ApprovedRefund"};
    public static final int TRADEO_CREAD = 1;
    public static final int TRADEO_VREAD = 2;
    public static final int TRADEO_PAID = 4;
    public static final int TRADEO_SPLIT = 8;
    public static final String TRADE_TYPE[] =
            {"Custom","Buy","Bid","Bargain","Access","PaymentTrade","PaymentList","PaymentAd"};
    public static final int TRADET_CUSTOM = 0;
    public static final int TRADET_BUY = 1;
    public static final int TRADET_BID = 2;
    public static final int TRADET_BARGAIN = 3;
    public static final int TRADET_ACCESS = 4;
    public static final int TRADET_TRADE = 5;
    public static final int TRADET_LIST = 6;
    public static final int TRADET_AD = 7;
    // //////////////////////////////////////////////////////////////////////////////////////////
    private static final java.text.SimpleDateFormat ymd = new java.text.SimpleDateFormat("yyyyMMdd");
    private static Cache _cache = new Cache(100);
    private String trade;
    private String community;
    private RV customer;
    private int status;
    private String point; // 商场积分,这里是卡号
    private int supplier;
    private BigDecimal total; // 总金额
    private BigDecimal freight; // 运费
    private int currency; // 货币
    private int language;
    // 收货地址
    private String state;
    private String city;
    private String address;
    private String email;
    private String firstname;
    private String lastname;
    private String organization;
    private String zip;
    private String telephone;
    private String remark; // 消费者备注
    private String remark2; // 供货商备注
    private String rejectedtype; //拒收类型
    private String rejectedwhy; //拒收原因
    public static final String PS_TYPE[] =
            {"平邮","快递","EMS"}; //
    private int ps; // 配送方式
    public static final String DEFRAY_TYPE[] =
            {"浦发银行","快钱","云网","网银在线","首信","","","","","","双象卡","电话银行","银行电汇"};
    //{"支付宝", "快钱", "云网", "网银在线", "首信", "", "", "", "", "", "双象卡", "电话银行", "银行电汇"};
    private int defray; // 支付方式
    public static final String PAYSTATE_TYPE[] =
            {"未支付","已支付未审核","财务已审核"};
    private int paystate; // 支付状态
    public static final String FP_TYPE[] =
            {"无","增值税","普通发票"};
    private int fp; //发票
    private String fptt; //发票抬头
    private String proof; // 支付证明//如果是邮局汇款或银行电汇,则是汇款号
    private Date time;
    private Date stime; // 发货时间
    private Date ftime; // 预计到达时间
    private BigDecimal rtotal; //退款总金额
    public static final String REFUND_TYPE[] =
            {"汇款","双象卡","转账"};
    private int rtype;
    private Date rtime; //退款日期
    private String rproof; //退款证明

    public Trade(String trade) throws SQLException
    {
        this.trade = trade;
        load();
    }

    public static Trade find(String trade) throws SQLException
    {
        Trade obj = (Trade) _cache.get(trade);
        if(obj == null)
        {
            obj = new Trade(trade);
            // _cache.put(trade, obj);
        }
        return obj;
    }

    /**********确定订单缴费 修改 状态，积分也在这里被确认*************/


    public void set(RV rv,int status,int paystate) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE trade SET status=" + status + ",paystate=" + paystate + " WHERE trade=" + DbAdapter.cite(trade));
        } finally
        {
            db.close();
        }
        this.status = status;
        this.paystate = paystate;
        if(rv != null)
        {
            TradeMember.create(trade,status,paystate,rv.toString()); //会员操作记录
        }
    }

    public void set(Date stime,Date ftime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE trade SET stime=" + DbAdapter.cite(stime) + ",ftime=" + DbAdapter.cite(ftime) + " WHERE trade=" + DbAdapter.cite(trade));
        } finally
        {
            db.close();
        }
        this.stime = stime;
        this.ftime = ftime;
    }

    public void customerRead() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE trade SET options=options|" + 1 + " WHERE trade=" + DbAdapter.cite(trade));
        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(trade) FROM trade WHERE community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT trade FROM trade WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration find2(String community,String sql,int pos,int pageSize) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT trade FROM trade WHERE community=" + DbAdapter.cite(community) + sql);
            for(int index = 0;index < pos + pageSize && db.next();index++)
            {
                if(index >= pos)
                {

                    {
                        v.addElement(db.getString(1));
                    }
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }



    public int getNext(boolean flag,RV rv,int i,int j,String community) throws SQLException
    {
        int k = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            k = db.getInt("SELECT trade " + getSql(flag,rv,i,j,community) + " AND trade>" + trade + " ORDER BY trade ASC ");
        } finally
        {
            db.close();
        }
        return k;
    }

    public Date getTime() throws SQLException
    {
        return time;
    }

    public String getTimeToString() throws SQLException
    {
        return sdf2.format(time);
    }

    public String getTimeToString2() throws SQLException
    {
        return ymd.format(time);
    }

    public Date getStime() throws SQLException
    {
        return stime;
    }

    public String getStimeToString() throws SQLException
    {
        if(stime == null)
        {
            return "";
        }
        return sdf.format(stime);
    }

    public Date getFtime() throws SQLException
    {
        return ftime;
    }

    public String getFtimeToString() throws SQLException
    {
        if(ftime == null)
        {
            return "";
        }
        return sdf.format(ftime);
    }

    public RV getCustomer() throws SQLException
    {
        return customer;
    }

    public static String createByBuys(String community,RV _customer,int status,String point,int supplier,BigDecimal total,BigDecimal freight,int language,String state,String city,String address,String email,String firstname,String lastname,String organization,String zip,
                                      String telephone,int ps,int defray,int fp,String fptt,String buys[]) throws SQLException
    {
        Date time = new Date();
        String trade = ymd.format(time) + SeqTable.getSeqNo("trade");
        DbAdapter db = new DbAdapter();
        try
        {
            db.setAutoCommit(false);
            db
                    .executeUpdate("INSERT INTO trade (trade,community,rcustomer,vcustomer,status,point,supplier,total,freight,language,state,city,address,email,firstname,lastname,organization,zip,telephone,ps,defray,paystate,fp,fptt,time,clanguage)VALUES(" + DbAdapter.cite(trade) + "," + DbAdapter.cite(community)
                                   + "," + DbAdapter.cite(_customer._strR) + "," + DbAdapter.cite(_customer._strV) + "," + status + "," + DbAdapter.cite(point) + "," + supplier + "," + total + "," + freight + "," + language + "," + DbAdapter.cite(state) + "," + DbAdapter.cite(city) + "," +
                                   DbAdapter.cite(address) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(firstname) + "," + DbAdapter.cite(lastname) + "," + DbAdapter.cite(organization) + "," + DbAdapter.cite(zip) + "," + DbAdapter.cite(telephone) + "," + ps + "," + defray + ",0," +
                                   fp + "," + DbAdapter.cite(fptt) + "," + DbAdapter.cite(time) + "," + language + "  )");
            int k1;
            for(int i = 0;i < buys.length;i++)
            {
                k1 = Integer.parseInt(buys[i]);

                Buy buy = Buy.find(k1);
                int commodity = buy.getCommodity();
                BuyPrice bp_obj = BuyPrice.find(commodity,buy.getCurrency());
                int l1 = buy.getNode();
                int j2 = buy.getQuantity();
                db.executeUpdate("INSERT INTO tradeitem (trade,time,node,subject,price,quantity )VALUES( " + DbAdapter.cite(trade) + "," + DbAdapter.cite(time) + ", " + l1 + "," + DbAdapter.cite(Node.find(l1).getSubject(language)) + ", " + bp_obj.getPrice() + "," + j2 + ")");
                // 更改购买表中的总量
                db.executeUpdate("UPDATE Commodity SET inventory=inventory-" + j2 + " WHERE goods=" + l1);
                db.executeUpdate("UPDATE Buy SET status=" + 2 + " WHERE buy =" + k1);
            }
            db.commit();
        } catch(Exception ex)
        {
            try
            {
                db.rollback();
            } catch(Exception _ex)
            {
            }
            throw new SQLException(ex.toString());
        } finally
        {
            try
            {
                db.setAutoCommit(true);
            } catch(Exception _ex)
            {
            }
            db.close();
        }
        // 会员操作记录
        TradeMember.create(trade,status,0,_customer.toString());
        return trade;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(
                    "SELECT community,rcustomer,vcustomer,status,point,supplier,total,freight,currency,language,state,city,address,email,firstname,lastname,organization,zip,telephone,remark,remark2,ps,defray,paystate,fp,fptt,proof,time,stime,ftime,rejectedtype,rejectedwhy,rtotal,rtype,rtime,rproof FROM trade WHERE trade=" +
                    DbAdapter.cite(trade));
            if(db.next())
            {
                community = db.getString(1);
                customer = new RV(db.getString(2),db.getString(3));
                status = db.getInt(4);
                point = db.getString(5);
                supplier = db.getInt(6);
                total = db.getBigDecimal(7,2);
                freight = db.getBigDecimal(8,2);
                currency = db.getInt(9);
                language = db.getInt(10);
                state = db.getVarchar(language,1,11);
                city = db.getVarchar(language,1,12);
                address = db.getVarchar(language,1,13);
                email = db.getString(14);
                firstname = db.getVarchar(language,1,15);
                lastname = db.getVarchar(language,1,16);
                organization = db.getVarchar(language,1,17);
                zip = db.getVarchar(language,1,18);
                telephone = db.getVarchar(language,1,19);
                remark = db.getText(language,1,20);
                remark2 = db.getText(language,1,21);
                ps = db.getInt(22);
                defray = db.getInt(23);
                paystate = db.getInt(24);
                fp = db.getInt(25);
                fptt = db.getString(26);
                proof = db.getVarchar(language,1,27);
                time = db.getDate(28);
                stime = db.getDate(29);
                ftime = db.getDate(30);
                rejectedtype = db.getVarchar(language,1,31);
                rejectedwhy = db.getVarchar(language,1,32);
                rtotal = db.getBigDecimal(33,2);
                rtype = db.getInt(34);
                rtime = db.getDate(35);
                rproof = db.getVarchar(language,1,36);
            }
        } finally
        {
            db.close();
        }
    }

    public int getPrev(boolean flag,RV rv,int i,int j,String community) throws SQLException
    {
        int k = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            k = db.getInt("SELECT  trade " + getSql(flag,rv,i,j,community) + " AND trade<" + trade + " ORDER BY trade DESC ");
        } finally
        {
            db.close();
        }
        return k;
    }

    //---->孙宏亮增加的方法<---//
    public static Map totalSum(String community,String sql) throws SQLException
    {
        BigDecimal sum = null;
        Map map = new HashMap();
        int count = 0;
        DbAdapter db = new DbAdapter();
        String message = "";
        try
        {
            db.executeQuery("select sum(total) as sum,count(trade) as count from trade where community=" + db.cite(community) + sql);
            if(db.next())
            {
                sum = db.getBigDecimal(1,2);
                count = db.getInt(2);
                map.put("sum",sum);
                map.put("count",new Integer(count));
            } else
            {
                map.put("message",message);
            }

        } finally
        {
            db.close();
        }

        return map;
    }


    public int getStatus() throws SQLException
    {
        return status;
    }

    public int getOldStatus() throws SQLException
    {
        int oldstatus = status;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT status FROM trademember WHERE trade=" + DbAdapter.cite(trade) + " ORDER BY time DESC");
            while(db.next() && status == oldstatus)
            {
                oldstatus = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return oldstatus;
    }

    public String getZip(int i) throws SQLException
    {
        return zip;
    }

    public String getTrade()
    {
        return trade;
    }

    public int getSupplier() throws SQLException
    {
        return supplier;
    }

    public String getState(int i) throws SQLException
    {
        return Translator.getInstance().translate(state,language,i);
    }

    public int getPs() throws SQLException
    {
        return ps;
    }

    public String getPoint() throws SQLException
    {
        return point;
    }

    public String getOrganization(int i) throws SQLException
    {
        return Translator.getInstance().translate(organization,language,i);
    }

    public int getFp() throws SQLException
    {
        return fp;
    }

    public String getEmail() throws SQLException
    {
        return email;
    }

    public int getDefray() throws SQLException
    {
        return defray;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getCity(int i) throws SQLException
    {
        return Translator.getInstance().translate(city,language,i);
    }

    public String getCityToString(int i) throws SQLException
    {
        String str = city;
        try
        {
            str = Card.find(Integer.parseInt(city)).toString();
        } catch(Exception ex)
        {
        }
        return Translator.getInstance().translate(str,language,i);
    }

    public String getAddress(int i) throws SQLException
    {
        return Translator.getInstance().translate(address,language,i);
    }

    public String getFirstName(int i) throws SQLException
    {
        return Translator.getInstance().translate(firstname,language,i);
    }

    public String getTelephone(int i) throws SQLException
    {
        return telephone;
    }

    public void vendorRead() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Trade  SET options=options|" + 2 + " WHERE trade=" + DbAdapter.cite(trade));
        } finally
        {
            db.close();
        }
    }

    private static String getSql(boolean flag,RV rv,int type,String community)
    {
        if(flag)
        {
            return " FROM Trade  WHERE rcustomer=" + DbAdapter.cite(rv._strR) + " AND trade IN (SELECT trade FROM TradeItem) " + " AND type=" + type + " AND community=" + DbAdapter.cite(community);
        } else
        {
            return " FROM Trade  WHERE rvendor=" + DbAdapter.cite(rv._strR) + " AND trade IN (SELECT trade FROM TradeItem) " + " AND type=" + type + " AND community=" + DbAdapter.cite(community);
        }
    }

    private static String getSql(boolean flag,RV rv,int type,int status,String community)
    {
        return getSql(flag,rv,type,community) + " AND status=" + status;
    }

    public void set(RV rv,int status,int language,String state,String city,String address,String email,String firstname,String lastname,String organization,String zip,String telephone,String remark,String remark2,int ps,int defray,int paystate,int fp,String fptt,String proof,
                    Date stime,Date ftime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE trade SET language=").append(language);
        sql.append(",state=").append(DbAdapter.cite(state));
        sql.append(",city=").append(DbAdapter.cite(city));
        sql.append(",address=").append(DbAdapter.cite(address));
        sql.append(",email=").append(DbAdapter.cite(email));
        sql.append(",firstname=").append(DbAdapter.cite(firstname));
        sql.append(",lastname=").append(DbAdapter.cite(lastname));
        sql.append(",organization=").append(DbAdapter.cite(organization));
        sql.append(",zip=").append(DbAdapter.cite(zip));
        sql.append(",telephone=").append(DbAdapter.cite(telephone));
        sql.append(",ps=").append(ps);
        sql.append(",defray=").append(defray);
        sql.append(",fp=").append(fp);
        sql.append(",fptt=").append(DbAdapter.cite(fptt));
        if(remark != null)
        {
            sql.append(",remark=").append(DbAdapter.cite(remark));
            this.remark = remark;
        }
        if(remark2 != null)
        {
            sql.append(",remark2=").append(DbAdapter.cite(remark2));
            this.remark2 = remark2;
        }
        if(status != -1)
        {
            sql.append(",status=").append(status);
            this.status = status;
        }
        if(paystate != -1)
        {
            sql.append(",paystate=").append(paystate);
            this.paystate = paystate;
        }
        if(proof != null)
        {
            sql.append(",proof=").append(DbAdapter.cite(proof));
            this.proof = proof;
        }
        if(stime != null)
        {
            sql.append(",stime=").append(DbAdapter.cite(stime));
            this.stime = stime;
        }
        if(ftime != null)
        {
            sql.append(",ftime=").append(DbAdapter.cite(ftime));
            this.ftime = ftime;
        }
        sql.append(" WHERE trade=").append(DbAdapter.cite(trade));
        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
        this.language = language;
        this.state = state;
        this.city = city;
        this.address = address;
        this.email = email;
        this.firstname = firstname;
        this.lastname = lastname;
        this.organization = organization;
        this.zip = zip;
        this.telephone = telephone;
        this.ps = ps;
        this.defray = defray;
        this.fp = fp;
        this.fptt = fptt;
        TradeMember.create(trade,this.status,this.paystate,rv.toString()); //会员操作记录
    }

    /*
     * public void set(int i, int j, String s, String s1, String s2, String s3, String s4, String s5, String s6, String s7, String s8, String s9, String s10, String s11, String s12, String s13, String s14, String s15, String s16, String s17, String s18, String s19, String s20, String s21, BigDecimal
     * bigdecimal, BigDecimal bigdecimal1, BigDecimal bigdecimal2, int k, String s22, boolean flag, byte abyte0[]) throws SQLException { Date date = new Date(System.currentTimeMillis()); DbAdapter db = new DbAdapter(); try { db.executeUpdate("UPDATE Trade SET status=" + i + ", " + " time=" +
     * DbAdapter.cite(date) + ", " + " blanguage=" + j + ", " + " bemail=" + DbAdapter.cite(s) + ", " + " bfirstname=" + DbAdapter.cite(s1) + ", " + " blastname=" + DbAdapter.cite(s2) + ", " + " borganization=" + DbAdapter.cite(s3) + ", " + " baddress=" + DbAdapter.cite(s4) + ", " + " bcity=" +
     * DbAdapter.cite(s5) + ", " + " bstate=" + DbAdapter.cite(s6) + ", " + " bzip=" + DbAdapter.cite(s7) + ", " + " bcountry=" + DbAdapter.cite(s8) + ", " + " btelephone=" + DbAdapter.cite(s9) + ", " + " bfax=" + DbAdapter.cite(s10) + ", " + " semail=" + DbAdapter.cite(s11) + ", " + " sfirstname=" +
     * DbAdapter.cite(s12) + ", " + " slastname=" + DbAdapter.cite(s13) + ", " + " sorganization=" + DbAdapter.cite(s14) + ", " + " saddress=" + DbAdapter.cite(s15) + ", " + " scity=" + DbAdapter.cite(s16) + ", " + " sstate=" + DbAdapter.cite(s17) + ", " + " szip=" + DbAdapter.cite(s18) + ", " + "
     * scountry=" + DbAdapter.cite(s19) + ", " + " stelephone=" + DbAdapter.cite(s20) + ", " + " sfax=" + DbAdapter.cite(s21) + ", " + " sh=" + bigdecimal + ", " + " tax=" + bigdecimal1 + ", " + " discount=" + bigdecimal2 + ", " + " clanguage=" + k + ", " + " ctext=" + DbAdapter.cite(s22) + (flag ? ",
     * cvoice=null " : abyte0 == null ? "" : ", cvoice=" + DbAdapter.cite(abyte0)) + " WHERE trade=" + DbAdapter.cite(trade) + " AND status=" + status);
      } finally { db.close(); } _blLoaded = false; }
     *
     * public void set(int i, int j, String s, String s1, String s2, String s3, String s4, String s5, String s6, String s7, String s8, String s9, String s10, String s11, String s12, String s13, String s14, String s15, String s16, String s17, String s18, String s19, String s20, String s21, int k,
     * String s22, boolean flag, byte abyte0[], String explained) throws SQLException // , // int // payType { Date date = new Date(System.currentTimeMillis()); DbAdapter db = new DbAdapter(); try { db.executeUpdate("UPDATE Trade SET status=" + i + ", " + " time=" + DbAdapter.cite(date) + ", " + "
     * blanguage=" + j + ", " + " bemail=" + DbAdapter.cite(s) + ", " + " bfirstname=" + DbAdapter.cite(s1) + ", " + " blastname=" + DbAdapter.cite(s2) + ", " + " borganization=" + DbAdapter.cite(s3) + ", " + " baddress=" + DbAdapter.cite(s4) + ", " + " bcity=" + DbAdapter.cite(s5) + ", " + "
     * bstate=" + DbAdapter.cite(s6) + ", " + " bzip=" + DbAdapter.cite(s7) + ", " + " bcountry=" + DbAdapter.cite(s8) + ", " + " btelephone=" + DbAdapter.cite(s9) + ", " + " bfax=" + DbAdapter.cite(s10) + ", " + " semail=" + DbAdapter.cite(s11) + ", " + " sfirstname=" + DbAdapter.cite(s12) + ", " + "
     * slastname=" + DbAdapter.cite(s13) + ", " + " sorganization=" + DbAdapter.cite(s14) + ", " + " saddress=" + DbAdapter.cite(s15) + ", " + " scity=" + DbAdapter.cite(s16) + ", " + " sstate=" + DbAdapter.cite(s17) + ", " + " szip=" + DbAdapter.cite(s18) + ", " + " scountry=" + DbAdapter.cite(s19) + ", " + "
     * stelephone=" + DbAdapter.cite(s20) + ", " + " sfax=" + DbAdapter.cite(s21) + ", " + " clanguage=" + k + ", " + " ctext=" + DbAdapter.cite(s22) + (flag ? ", cvoice=null " : abyte0 == null ? "" : ", cvoice=" + DbAdapter.cite(abyte0)) + ",explained=" + DbAdapter.cite(explained) + " WHERE trade=" +
     * DbAdapter.cite(trade) + " AND status=" + status); // ", paytype=" + payType +
      } finally { db.close(); } _blLoaded = false; }
     */

    public void set(int status,int vlanguage,String vtext,boolean flag,byte abyte0[]) throws SQLException
    {
        Date date = new Date(System.currentTimeMillis());
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE trade SET status=" + status + ", " + " time=" + DbAdapter.cite(date) + ", " + " vlanguage=" + vlanguage + ", " + " vtext=" + DbAdapter.cite(vtext) + (flag ? ", vvoice=null " : abyte0 == null ? "" : ", vvoice=" + DbAdapter.cite(abyte0)) + " WHERE trade="
                             + DbAdapter.cite(trade) + " AND status=" + status);
        } finally
        {
            db.close();
        }
    }

    //收货地址
    public void set(RV rv,int status,int language,String address,String email,String firstname,String lastname,String organization,String zip,String telephone) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE trade SET language=").append(language);
        sql.append(",address=").append(DbAdapter.cite(address));
        sql.append(",email=").append(DbAdapter.cite(email));
        sql.append(",firstname=").append(DbAdapter.cite(firstname));
        sql.append(",lastname=").append(DbAdapter.cite(lastname));
        sql.append(",organization=").append(DbAdapter.cite(organization));
        sql.append(",zip=").append(DbAdapter.cite(zip));
        sql.append(",telephone=").append(DbAdapter.cite(telephone));
        if(status != -1)
        {
            sql.append(",status=").append(status);
            this.status = status;
            // 会员操作记录
            TradeMember.create(trade,status,paystate,rv.toString());
        }
        sql.append(" WHERE trade=").append(DbAdapter.cite(trade));
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
        this.language = language;
        this.address = address;
        this.email = email;
        this.firstname = firstname;
        this.lastname = lastname;
        this.organization = organization;
        this.zip = zip;
        this.telephone = telephone;
    }

    //财务确认
    public void set(RV rv,int paystate,String proof) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE trade SET paystate=").append(paystate);
        if(proof != null)
        {
            sql.append(",proof=").append(DbAdapter.cite(proof));
            this.proof = proof;
        }
        sql.append(" WHERE trade=").append(DbAdapter.cite(trade));
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
        this.paystate = paystate;
        TradeMember.create(trade,status,paystate,rv.toString()); //会员操作记录
    }

    //准备发货
    public void set(RV rv,int status,String remark2,Date stime,Date ftime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE trade SET remark2=").append(DbAdapter.cite(remark2));
        sql.append(",stime=").append(DbAdapter.cite(stime));
        sql.append(",ftime=").append(DbAdapter.cite(ftime));
        if(status != -1)
        {
            sql.append(",status=").append(status);
            this.status = status;
            // 会员操作记录
            TradeMember.create(trade,status,paystate,rv.toString());
        }
        sql.append(" WHERE trade=").append(DbAdapter.cite(trade));

        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
        this.remark2 = remark2;
        this.stime = stime;
        this.ftime = ftime;
    }

    //拒收订单
    public void set(RV rv,String rejectedtype,String rejectedwhy) throws SQLException
    {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE trade SET rejectedtype=").append(DbAdapter.cite(rejectedtype));
        sql.append(",rejectedwhy=").append(DbAdapter.cite(rejectedwhy));
        sql.append(",status=").append(TRADES_REJECTED);
        sql.append(" WHERE trade=").append(DbAdapter.cite(trade));
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
        this.rejectedtype = rejectedtype;
        this.rejectedwhy = rejectedwhy;
        this.status = TRADES_REJECTED;
        TradeMember.create(trade,status,paystate,rv.toString()); // 会员操作记录
    }

    //退款订单//退款总金额,退款日期,退款证明
    public void set(RV rv,int status,BigDecimal rtotal,int rtype,Date rtime,String rproof) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE trade SET rtotal=").append(rtotal);
        sql.append(",rtype=").append(rtype);
        sql.append(",rtime=").append(DbAdapter.cite(rtime));
        sql.append(",rproof=").append(DbAdapter.cite(rproof));
        sql.append(",status=").append(status);
        sql.append(" WHERE trade=").append(DbAdapter.cite(trade));

        try
        {
            db.executeUpdate(sql.toString());
        } finally
        {
            db.close();
        }
        this.rtotal = rtotal;
        this.rtype = rtype;
        this.rtime = rtime;
        this.rproof = rproof;
        this.status = status;
        TradeMember.create(trade,status,paystate,rv.toString()); // 会员操作记录
    }

    // 支付状态
    public void setPaystate(int paystate) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE trade SET paystate=" + paystate + " WHERE trade=" + DbAdapter.cite(trade));
        } finally
        {
            db.close();
        }
        this.paystate = paystate;
    }

    public String getLastName(int i) throws SQLException
    {
        return Translator.getInstance().translate(lastname,language,i);
    }

    public String getProof()
    {
        return proof;
    }

    public int getCurrency()
    {
        return currency;
    }

    public int getPaystate()
    {
        return paystate;
    }

    public BigDecimal getFreight()
    {
        return freight;
    }

    public BigDecimal getTotal() throws SQLException
    {
        return total;
    }

    public String getFptt()
    {
        return fptt;
    }

    public String getRproof()
    {
        return rproof;
    }

    public Date getRtime()
    {
        return rtime;
    }

    public String getRtimeToString()
    {
        return sdf2.format(rtime);
    }

    public BigDecimal getRtotal()
    {
        return rtotal;
    }

    public int getRtype()
    {
        return rtype;
    }

    public String getRejectedWhy(int _nLanguage)
    {
        return Translator.getInstance().translate(rejectedwhy,language,_nLanguage);
    }

    public String getRejectedType(int _nLanguage)
    {
        return Translator.getInstance().translate(rejectedtype,language,_nLanguage);
    }

    public String getRemark(int i) throws SQLException
    {
        return Translator.getInstance().translate(remark,language,i);
    }

    public String getRemark2(int i) throws SQLException
    {
        return Translator.getInstance().translate(remark2,language,i);
    }
}
