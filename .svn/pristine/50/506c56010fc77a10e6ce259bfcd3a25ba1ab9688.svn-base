package tea.entity.csvclub;

import java.math.*;
import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Huiyuan extends Entity
{
    private String suozaisheng; //所在省
    private String diqu; //所在地区
    private String huiyuanbianhuo; //会员号
    private String xingming; //[姓名 ]
    private String pinyin; //姓名拼写
    private String xinbie; //性别
    private Date chushengriqi; //出生日期
    private String shenfenzhenghao; //身份证号
    private String lianxidizhi; //联系地址
    private String youbian; //邮编
    private String dianhua; //联系电话
    private Date zhuceshijian; //会员注册时间
    private String quanshezhong; //犬舍中文名
    private String quansheyingwen; //犬舍英文
    private String quanshedizhi; //犬舍地址
    private Date quanshezhuceshijian; //犬舍注册时间
    private String jieshaoren; //介绍人
    private String beizhu; //备注
    private String quanshebianhao; //犬舍编号
    private BigDecimal nianfei; //会员年费交纳
    private BigDecimal F14;
    private BigDecimal F15;
    private BigDecimal F16;
    private BigDecimal F17;
    private BigDecimal F18;
    private BigDecimal F19;

//    [F14] [float] NULL ,
//            [F15] [float] NULL ,
//            [F16] [float] NULL ,
//            [F17] [float] NULL ,
//            [F18] [float] NULL ,
//	[F19;] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
//
    private BigDecimal F27;///-27
    private BigDecimal F28;///28
    private BigDecimal F29;///29
    private BigDecimal F30;///30
    private BigDecimal F31;///31
    private BigDecimal F32;///32/
    private BigDecimal F33;///33




    private BigDecimal quanshenianfei; //犬舍年费交纳
    private String membertype; //
    private String dogzhengshufafang; //犬舍证书发放情况
    private String memberfafangtime; //会员证发放


    private static Cache _cache = new Cache(100);
    private boolean exists;
    public Huiyuan(String huiyuanbianhuo) throws SQLException
    {
        this.huiyuanbianhuo = huiyuanbianhuo;
        load();
    }

    public static Huiyuan find(String huiyuanbianhuo) throws SQLException
    {
        return new Huiyuan(huiyuanbianhuo);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT 所在省,所在地区,会员号,姓名,姓名拼写,性别,出生日期,身份证号,联系地址,邮编,联系电话,会员注册时间,会员年费交纳,犬舍中文名,犬舍英文及拼音," +
                            "犬舍地址,犬舍注册时间,犬舍年费交纳,介绍人,备注,F14,F15,F16,F17,F18,F18,F27,F28,F29,F30,F31,F32 ,犬舍编号,犬舍证书发放情况,会员证发放,membertype,F19,F33 FROM huiyuan WHERE 会员号 =" + DbAdapter.cite(huiyuanbianhuo));
            if (db.next())
            {
                suozaisheng = db.getString(1);
                diqu = db.getString(2);
                huiyuanbianhuo = db.getString( 3);
                xingming = db.getString( 4);
                pinyin = db.getString(5);
                xinbie = db.getString(6);
                chushengriqi = db.getDate(7);
                shenfenzhenghao = db.getString(8);
                lianxidizhi = db.getString(9);
                youbian = db.getString(10);
                dianhua = db.getString(11);
                zhuceshijian = db.getDate(12);
                nianfei = db.getBigDecimal(13, 2);
                quanshezhong = db.getString(14);
                quansheyingwen = db.getString(15);
                quanshedizhi = db.getString(16);
                quanshezhuceshijian = db.getDate(17);
                quanshenianfei = db.getBigDecimal(18, 2);
                jieshaoren = db.getString(19);
                beizhu = db.getString(20);
                F14 = db.getBigDecimal(21, 2);
                F15 = db.getBigDecimal(22, 2);
                F16 = db.getBigDecimal(23, 2);
                F17 = db.getBigDecimal(24, 2);
                F18 = db.getBigDecimal(25, 2);
                F27 = db.getBigDecimal(26, 2);
                F28 = db.getBigDecimal(27, 2);
                F29 = db.getBigDecimal(28, 2);
                F30 = db.getBigDecimal(29, 2);
                F31 = db.getBigDecimal(30, 2);
                F32 = db.getBigDecimal(31, 2);
                quanshebianhao = db.getString(32);
                dogzhengshufafang = db.getString(33);
                memberfafangtime = db.getString(34);
                membertype = db.getString(35);
                F19 = db.getBigDecimal(36,2);
                F33 = db.getBigDecimal(37,2);

                exists = true;
            } else
            {
                exists = false;
            }
        } catch (Exception exception)
        {exception.printStackTrace();
            throw new SQLException(exception.toString());
        } finally
        {
            db.close();
        }
    }


    public static java.util.Enumeration findByCommunity(String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  会员号 FROM huiyuan " + sql);

            while (dbadapter.next())
            {

                String huiyuanbianhuo = dbadapter.getVarchar(1, 1, 1);
                vector.addElement(String.valueOf(huiyuanbianhuo));
            }

        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    public String getBeizhu()
    {
        return beizhu;
    }

    public Date getChushengriqi()
    {
        return chushengriqi;
    }

    public String getDianhua()
    {
        return dianhua;
    }

    public String getDiqu()
    {
        return diqu;
    }

    public String getHuiyuanbianhuo()
    {
        return huiyuanbianhuo;
    }

    public String getJieshaoren()
    {
        return jieshaoren;
    }

    public String getLianxidizhi()
    {
        return lianxidizhi;
    }

    public BigDecimal getNianfei()
    {
        return nianfei;
    }

    public String getPinyin()
    {
        return pinyin;
    }

    public String getQuanshedizhi()
    {
        return quanshedizhi;
    }

    public BigDecimal getQuanshenianfei()
    {
        return quanshenianfei;
    }

    public String getQuansheyingwen()
    {
        return quansheyingwen;
    }

    public String getQuanshezhong()
    {
        return quanshezhong;
    }

    public Date getQuanshezhuceshijian()
    {
        return quanshezhuceshijian;
    }

    public String getShenfenzhenghao()
    {
        return shenfenzhenghao;
    }

    public String getSuozaisheng()
    {
        return suozaisheng;
    }

    public String getXinbie()
    {
        return xinbie;
    }

    public String getXingming()
    {
        return xingming;
    }

    public String getYoubian()
    {
        return youbian;
    }

    public Date getZhuceshijian()
    {
        return zhuceshijian;
    }

    public BigDecimal getF14()
    {
        return F14;
    }

    public BigDecimal getF15()
    {
        return F15;
    }

    public BigDecimal getF16()
    {
        return F16;
    }

    public BigDecimal getF17()
    {
        return F17;
    }

    public BigDecimal getF18()
    {
        return F18;
    }

    public BigDecimal getF27()
    {
        return F27;
    }

    public BigDecimal getF28()
    {
        return F28;
    }

    public BigDecimal getF29()
    {
        return F29;
    }

    public BigDecimal getF30()
    {
        return F30;
    }

    public BigDecimal getF31()
    {
        return F31;
    }

    public BigDecimal getF32()
    {
        return F32;
    }

    public String getQuanshebianhao()
    {
        return quanshebianhao;
    }

    public String getDogzhengshufafang()
    {
        return dogzhengshufafang;
    }

    public String getMemberfafangtime()
    {
        return memberfafangtime;
    }

    public String getMembertype()
    {
        return membertype;
    }

    public boolean isExists()
    {
        return exists;
    }

    public BigDecimal getF19()
    {
        return F19;
    }

    public BigDecimal getF33()
    {
        return F33;
    }
}
