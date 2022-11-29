package tea.entity.csvclub;

import java.math.*;
import java.util.*;
import tea.entity.*;
import tea.ui.*;
import tea.db.*;
import java.sql.SQLException;

public class Csvtesting extends Entity
{
    private String xuetongzhengshuhao; //血统证书号
    private String jiuxuetongzshuhao; //旧血统证书号
    private String guowaizhengshu; //国外登记证书号
    private String erhao; //耳号
    private String yingwenxingming; //英文姓名
    private String zhongwenxingming; //中文姓名
    private String xingbie; //性别
    private String fuquanxuetong; //父犬血统证号
    private String muquanxuetong; //母犬血统证号
    private Date chushengriqi; //出生日期
    private String quanzhitupian; //犬只图片
    private String fanzhiren; //繁殖人
    private String fanzhirendizhi; //繁殖人住址
    private String quanzhuren; //犬主人
    private String quanzhurendizhi; //犬主人住址
    private String maozhi; //毛质
    private String yansebiaozhi; //颜色及标志
    private String teshubiaoji; //特殊标记
    private String kuanguanjie; //髋关节鉴定结果
    private String zhouguanjie; //肘关节鉴定结果
    private String dna; //DNA
    private String fanzhizige; //繁殖资格
    private String jinqinfanzhi; //近亲繁殖
    private String caipanpingjia; //裁判评价
    private String bisaijibie; //比赛级别
    private String bisaichengji; //比赛成绩
    private String kaoshijibie; //考试级别
    private String kaoshichengji; //考试成绩
    private String danghao; //档号
    private String xuexi; //血系
    private String fuwuquanpeiquanzhengming; //父母犬配犬证明号
    private String jinqinfanzhidayin; //近亲繁殖打印
    private String beizhu; //备注
    private Date lurushijian; //录入日期
    private Date xiugairiqi; //修改日期

    private boolean exists;


    public Csvtesting(String xuetongzhengshuhao) throws SQLException
    {
        this.xuetongzhengshuhao = xuetongzhengshuhao;
        load();
    }

    public static Csvtesting find(String xuetongzhengshuhao) throws SQLException
    {
        return new Csvtesting(xuetongzhengshuhao);
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select 血统证书号,旧血统证书号,国外登记证书号,耳号,英文姓名,中文姓名,性别,父犬血统证号," +
                            "母犬血统证号,出生日期,犬只图片,繁殖人,繁殖人住址,犬主人,犬主人住址,毛质,颜色及标志,特殊标记,髋关节鉴定结果," +
                            "肘关节鉴定结果,DNA,繁殖资格,近亲繁殖,裁判评价,比赛级别,比赛成绩,考试级别,考试成绩,档号,血系,父母犬配犬证明号," +
                            "近亲繁殖打印,备注,录入日期,修改日期 from 犬只测试表 where 血统证书号 = " + DbAdapter.cite(xuetongzhengshuhao));
            if (db.next())
            {
                xuetongzhengshuhao = db.getVarchar(1, 1, 1);
                jiuxuetongzshuhao = db.getVarchar(1, 1, 2);
                guowaizhengshu = db.getVarchar(1, 1, 3);
                erhao = db.getVarchar(1, 1, 4);
                yingwenxingming = db.getVarchar(1, 1, 5);
                zhongwenxingming = db.getVarchar(1, 1, 6);
                xingbie = db.getVarchar(1, 1, 7);
                fuquanxuetong = db.getVarchar(1, 1, 8);
                muquanxuetong = db.getVarchar(1, 1, 9);
                chushengriqi = db.getDate(10);
                quanzhitupian = db.getVarchar(1, 1, 11);
                fanzhiren = db.getVarchar(1, 1, 12);
                fanzhirendizhi = db.getVarchar(1, 1, 13);
                quanzhuren = db.getVarchar(1, 1, 14);
                quanzhurendizhi = db.getVarchar(1, 1, 15);
                maozhi = db.getVarchar(1, 1, 16);
                yansebiaozhi = db.getVarchar(1, 1, 17);
                teshubiaoji = db.getVarchar(1, 1, 18);
                kuanguanjie = db.getVarchar(1, 1, 19);
                zhouguanjie = db.getVarchar(1, 1, 20);
                dna = db.getVarchar(1, 1, 21);
                fanzhizige = db.getVarchar(1, 1, 22);
                jinqinfanzhi = db.getVarchar(1, 1, 23);
                caipanpingjia = db.getVarchar(1, 1, 24);
                bisaijibie = db.getVarchar(1, 1, 25);
                bisaichengji = db.getVarchar(1, 1, 26);
                kaoshijibie = db.getVarchar(1, 1, 27);
                kaoshichengji = db.getVarchar(1, 1, 28);
                danghao = db.getVarchar(1, 1, 29);
                xuexi = db.getVarchar(1, 1, 30);
                fuwuquanpeiquanzhengming = db.getVarchar(1, 1, 31);
                jinqinfanzhidayin = db.getVarchar(1, 1, 32);
                beizhu = db.getVarchar(1, 1, 33);
                lurushijian = db.getDate(34);
                xiugairiqi = db.getDate(35);

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

    public static java.util.Enumeration findByCommunity(String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select 血统证书号 from 犬只测试表 " + sql);

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

    public String getBisaichengji()
    {
        return bisaichengji;
    }

    public String getBisaijibie()
    {
        return bisaijibie;
    }

    public String getCaipanpingjia()
    {
        return caipanpingjia;
    }

    public Date getChushengriqi()
    {
        return chushengriqi;
    }

    public String getDanghao()
    {
        return danghao;
    }

    public String getDna()
    {
        return dna;
    }

    public String getErhao()
    {
        return erhao;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getFanzhiren()
    {
        return fanzhiren;
    }

    public String getFanzhirendizhi()
    {
        return fanzhirendizhi;
    }

    public String getFanzhizige()
    {
        return fanzhizige;
    }

    public String getFuquanxuetong()
    {
        return fuquanxuetong;
    }

    public String getFuwuquanpeiquanzhengming()
    {
        return fuwuquanpeiquanzhengming;
    }

    public String getGuowaizhengshu()
    {
        return guowaizhengshu;
    }

    public String getJinqinfanzhi()
    {
        return jinqinfanzhi;
    }

    public String getJinqinfanzhidayin()
    {
        return jinqinfanzhidayin;
    }

    public String getJiuxuetongzshuhao()
    {
        return jiuxuetongzshuhao;
    }

    public String getKaoshichengji()
    {
        return kaoshichengji;
    }

    public String getKaoshijibie()
    {
        return kaoshijibie;
    }

    public String getKuanguanjie()
    {
        return kuanguanjie;
    }

    public Date getLurushijian()
    {
        return lurushijian;
    }

    public String getMaozhi()
    {
        return maozhi;
    }

    public String getMuquanxuetong()
    {
        return muquanxuetong;
    }

    public String getQuanzhitupian()
    {
        return quanzhitupian;
    }

    public String getQuanzhuren()
    {
        return quanzhuren;
    }

    public String getQuanzhurendizhi()
    {
        return quanzhurendizhi;
    }

    public String getTeshubiaoji()
    {
        return teshubiaoji;
    }

    public String getXingbie()
    {
        return xingbie;
    }

    public Date getXiugairiqi()
    {
        return xiugairiqi;
    }

    public String getXuetongzhengshuhao()
    {
        return xuetongzhengshuhao;
    }

    public String getXuexi()
    {
        return xuexi;
    }

    public String getYansebiaozhi()
    {
        return yansebiaozhi;
    }

    public String getYingwenxingming()
    {
        return yingwenxingming;
    }

    public String getZhongwenxingming()
    {
        return zhongwenxingming;
    }

    public String getZhouguanjie()
    {
        return zhouguanjie;
    }


}

