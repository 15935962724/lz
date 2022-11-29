package tea.entity.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;

import tea.db.DbAdapter;
import tea.entity.*;

//订单
public class ShopTrade
{
    protected static Cache c = new Cache(50);
    public int trade;
    public String code; //订单编号
    public int member; //用户
    public String aname; //姓名
    public int acity; //省　　份
    public String aaddress; //地　　址
    public String amobile; //手机号码
    public String atel; //固定电话
    public String aemail; //电子邮件
    public String azip; //邮政编码
    public static String[] PPAYMENT_TYPE =
            {"线下支付"};
    public int ppayment; //支付方式
    public static String[] PTIME_TYPE =
            {"只工作日送货(双休日、假日不用送)", "工作日、双休日与假日均可送货", "只双休日、假日送货(工作日不用送)"};
    public int ptime; //送货日期
    public static String[] ITYPE_TYPE =
            {"普通发票", "增值税发票"};
    public int itype; //发票类型
    public static String[] IPAYABLE_TYPE =
            {"个人", "单位"};
    public int ipayable; //发票抬头
    public String ititname; //单位名称
    public String insrcode; //纳税人识别号
    public String iaddress; //注册地址
    public String itel; //注册电话
    public String ibank; //开户银行
    public String iaccount; //银行帐户
    public static String[] ICONTENT_TYPE =
            {"明细", "办公用品", "电脑配件", "耗材"};
    public int icontent; //发票内容
    public String remark;
    public static String[] STATE_TYPE =
            {"默认", "待确认", "准备发货", "确认收货", "已完成", "取消的订单", "拒收的订单"};
    public static String[] NEWSTATE_TYPE =
        	{"默认", "待审核", "待付款","申请取消","已取消","已完成"};
    public int state; //订单状态
    public static String[] PAY_TYPE =
            {"未支付", "已支付"};
    public int pay;
    public float coupon; //优惠金额
    public float total; //商品金额
    public float actually; //应付总额
    public Date time;

    public int tstateid;//退款状态

    public ShopTrade(int trade)
    {
        this.trade = trade;
    }

    public static ShopTrade find(int trade) throws SQLException
    {
        ShopTrade t = (ShopTrade) c.get(trade);
        if (t == null)
        {
            ArrayList al = find(" AND trade=" + trade, 0, 1);
            t = al.size() < 1 ? new ShopTrade(trade) : (ShopTrade) al.get(0);
        }
        return t;
    }

    public static ArrayList findByMember(String member, int pos, int size) throws SQLException
    {
        return find(" AND member=" + DbAdapter.cite(member), pos, size);
    }

    public static ArrayList find(String sql, int pos, int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT tr.trade,tr.code,tr.member,tr.aname,tr.acity,tr.aaddress,tr.amobile,tr.atel,tr.aemail,tr.azip,tr.ppayment,tr.ptime,tr.itype,tr.ipayable,tr.ititname,tr.insrcode,tr.iaddress,tr.itel,tr.ibank,tr.iaccount,tr.icontent,tr.remark,tr.state,tr.coupon,tr.total,tr.actually,tr.time,tr.tstateid FROM shoptrade tr" + tab(sql) + " WHERE 1=1" + sql, pos, size);
            while (rs.next())
            {
                int i = 1;
                ShopTrade t = new ShopTrade(rs.getInt(i++));
                t.code = rs.getString(i++);
                t.member = rs.getInt(i++);
                t.aname = rs.getString(i++);
                t.acity = rs.getInt(i++);
                t.aaddress = rs.getString(i++);
                t.amobile = rs.getString(i++);
                t.atel = rs.getString(i++);
                t.aemail = rs.getString(i++);
                t.azip = rs.getString(i++);
                t.ppayment = rs.getInt(i++);
                t.ptime = rs.getInt(i++);
                t.itype = rs.getInt(i++);
                t.ipayable = rs.getInt(i++);
                t.ititname = rs.getString(i++);
                t.insrcode = rs.getString(i++);
                t.iaddress = rs.getString(i++);
                t.itel = rs.getString(i++);
                t.ibank = rs.getString(i++);
                t.iaccount = rs.getString(i++);
                t.icontent = rs.getInt(i++);
                t.remark = rs.getString(i++);
                t.state = rs.getInt(i++);
                t.coupon = rs.getFloat(i++);
                t.total = rs.getFloat(i++);
                t.actually = rs.getFloat(i++);
                t.time = db.getDate(i++);
                t.tstateid = rs.getInt(i++);
                c.put(t.trade, t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
    	//System.out.println("SELECT COUNT(*) FROM shoptrade tr" + tab(sql) + " WHERE 1=1" + sql);
        return DbAdapter.execute("SELECT COUNT(*) FROM shoptrade tr" + tab(sql) + " WHERE 1=1" + sql);
    }

    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND m."))
            sb.append(" INNER JOIN Member m ON m.member=tr.member");
        if (sql.contains(" AND r."))
            sb.append(" INNER JOIN refundview r ON r.rid=tr.tstateid");
        return sb.toString();
    }

    public void set() throws SQLException
    {
        String sql;
        if (trade < 1)
            sql = "INSERT INTO shoptrade(trade,code,member,aname,acity,aaddress,amobile,atel,aemail,azip,ppayment,ptime,itype,ipayable,ititname,insrcode,iaddress,itel,ibank,iaccount,icontent,remark,state,time,tstateid,pay)VALUES(" + (trade = Seq.get()) + "," + DbAdapter.cite(code) + "," + member + "," + DbAdapter.cite(aname) + "," + acity + "," + DbAdapter.cite(aaddress) + "," + DbAdapter.cite(amobile) + "," + DbAdapter.cite(atel) + "," + DbAdapter.cite(aemail) + "," + DbAdapter.cite(azip) + "," + ppayment + "," + ptime + "," + itype + "," + ipayable + "," + DbAdapter.cite(ititname) + "," + DbAdapter.cite(insrcode) + "," + DbAdapter.cite(iaddress) + "," + DbAdapter.cite(itel) + "," + DbAdapter.cite(ibank) + "," + DbAdapter.cite(iaccount) + "," + icontent + "," + DbAdapter.cite(remark) + "," + state + "," +
                    DbAdapter.cite(time) + ","+tstateid+",0)";
        else
            sql = "UPDATE shoptrade SET code=" + DbAdapter.cite(code) + ",aname=" + DbAdapter.cite(aname) + ",acity=" + acity + ",aaddress=" + DbAdapter.cite(aaddress) + ",amobile=" + DbAdapter.cite(amobile) + ",atel=" + DbAdapter.cite(atel) + ",aemail=" + DbAdapter.cite(aemail) + ",azip=" + DbAdapter.cite(azip) + ",ppayment=" + ppayment + ",ptime=" + ptime + ",itype=" + itype + ",ipayable=" + ipayable + ",ititname=" + DbAdapter.cite(ititname) + ",insrcode=" + DbAdapter.cite(insrcode) + ",iaddress=" + DbAdapter.cite(iaddress) + ",itel=" + DbAdapter.cite(itel) + ",ibank=" + DbAdapter.cite(ibank) + ",iaccount=" + DbAdapter.cite(iaccount) + ",icontent=" + icontent + ",remark=" + DbAdapter.cite(remark) + ",state=" + state + ",coupon=" + coupon + ",total=" + total + ",actually=" + actually + ",time=" +
                  DbAdapter.cite(time) + ",tstateid="+tstateid+" WHERE trade=" + trade;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(trade, sql);
        } finally
        {
            db.close();
        }
        c.remove(trade);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(trade, "DELETE FROM shoptrade WHERE trade=" + trade);
        } finally
        {
            db.close();
        }
        c.remove(trade);
    }

    public void set(String f, String v) throws SQLException
    {
       // System.out.println("UPDATE shoptrade SET " + f + "=" + DbAdapter.cite(v) + " WHERE trade=" + trade);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(trade, "UPDATE shoptrade SET " + f + "=" + DbAdapter.cite(v) + " WHERE trade=" + trade);
        } finally
        {
            db.close();
        }
        c.remove(trade);
    }

    //
    public static ShopTrade getInstance(int member) throws SQLException
    {
        Iterator it = ShopTrade.find(" AND state=0 AND member=" + member, 0, 1).iterator();
        if (it.hasNext())
            return (ShopTrade) it.next();
        ShopTrade t = new ShopTrade(0);
        t.member = member;
        t.set();
        return getInstance(member);
    }

    public String getAnchor()
    {
        return "<a href='/my/TradeView.jsp?trade=" + trade + "'>" + code + "</a>";
    }
}
