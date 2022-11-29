package tea.entity.csvclub;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Csvdogtesting extends Entity
{
    private int id; //id
    private String blood; //血统证书号
    private String host; //犬主人
    private String ename; //英文姓名
    private String cname; //中文姓名
    private Date birthdate; //出生日期
    private String sex; //性别
    private String earid; //耳号
    private String hair; // 毛质
    private String color; // 颜色及标志
    private String specialmark; // 特殊标记
    private String hipcheck; // 髋关节鉴定结果
    private String elbowcheck; // 肘关节鉴定结果
    private String propagatetitle; // 繁殖资格
    private String inbreeding; // 近亲繁殖
    private String gamerank; // 比赛级别
    private String gamegrade; // 比赛成绩
    private String examrank; // 考试级别
    private String examgrade; // 考试成绩
    private String bloodf; //父犬血统证号
    private String bloodm; //母犬血统证号
    private String provenum; //父母犬配犬证明号
    private String oldblood; //旧血统证书号
    private String foreignblood; //国外登记证书号
    private String lettertype; //证书类型
    private String umpirevalue; //裁判评价
    private String mark; //备注
    private Date lurushijian; //录入日期
    private Date xiugairiqi; //修改日期
    private String inbreedprint; // 近亲繁殖打印
    private String breedpeople; //繁殖人
    private String breedaddr; //繁殖人地址
    private String xuexi; //血系
    private String fileid; // 档号
    private String DNA;

    private boolean exists;


    public Csvdogtesting(String blood) throws SQLException
    {
        this.blood = blood;
        load();
    }

    public static Csvdogtesting find(String blood) throws SQLException
    {
        return new Csvdogtesting(blood);
    }


    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,血统证书号,犬主人,英文姓名,中文姓名,出生日期,性别,耳号,毛质,颜色及标志,特殊标记,髋关节鉴定结果,肘关节鉴定结果,繁殖资格,近亲繁殖,比赛级别,比赛成绩,考试级别,考试成绩,父犬血统证号,母犬血统证号,父母犬配犬证明号,旧血统证书号,国外登记证书号,证书类型,裁判评价,备注,添加日期,修改日期,近亲繁殖打印,繁殖人,繁殖人住址,血系,档号,DNA  from dog where 血统证书号 = " + DbAdapter.cite(blood));
            if (db.next())
            {
                id = db.getInt(1); //id
                blood = db.getVarchar(1, 1, 2); //血统证书号
                host = db.getVarchar(1, 1, 3); //犬主人
                ename = db.getVarchar(1, 1, 4); //英文姓名
                cname = db.getVarchar(1, 1, 5); //中文姓名
                birthdate = db.getDate(6); //出生日期
                sex = db.getVarchar(1, 1, 7); //性别
                earid = db.getVarchar(1, 1, 8); //耳号
                hair = db.getVarchar(1, 1, 9); // 毛质
                color = db.getVarchar(1, 1, 10); // 颜色及标志
                specialmark = db.getString(11); // 特殊标记
                hipcheck = db.getVarchar(1, 1, 12); // 髋关节鉴定结果
                elbowcheck = db.getVarchar(1, 1, 13); // 肘关节鉴定结果
                propagatetitle = db.getVarchar(1, 1, 14); // 繁殖资格
                inbreeding = db.getVarchar(1, 1, 15); // 近亲繁殖
                gamerank = db.getVarchar(1, 1, 16); // 比赛级别
                gamegrade = db.getVarchar(1, 1, 17); // 比赛成绩
                examrank = db.getVarchar(1, 1, 18); // 考试级别
                examgrade = db.getVarchar(1, 1, 19); // 考试成绩
                bloodf = db.getVarchar(1, 1, 20); //父犬血统证号
                bloodm = db.getVarchar(1, 1, 21); //母犬血统证号
                provenum = db.getVarchar(1, 1, 22); //父母犬配犬证明号
                oldblood = db.getVarchar(1, 1, 23); //旧血统证书号
                foreignblood = db.getVarchar(1, 1, 24); //国外登记证书号
                lettertype = db.getVarchar(1, 1, 25); //证书类型
                umpirevalue = db.getVarchar(1, 1, 26); //裁判评价
                mark = db.getVarchar(1, 1, 27); //备注
                lurushijian = db.getDate(28); //添加日期
                xiugairiqi = db.getDate(29); //修改日期
                inbreedprint = db.getVarchar(1, 1, 30); //近亲繁殖打印
                breedpeople = db.getVarchar(1, 1, 31); //繁殖人
                breedaddr = db.getVarchar(1, 1, 32); //繁殖人地址
                xuexi = db.getVarchar(1, 1, 33); //血系
                fileid = db.getVarchar(1, 1, 34); //,档号
                DNA = db.getVarchar(1, 1, 35); //,DNA,

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

    //时间类型转换
    public static void Option() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeQuery("if   exists(select   *   from   syscolumns   where   [name]='birth'   and   OBJECTPROPERTY(id,'IsUserTable')=1   and   object_name(id)='dog')  select   'name字段已存在!'     else      begin   alter   table   dog       add   [birth]   datetime end  ");

        } finally
        {

        } while (true)
        {
            try
            {
                int i = 0;
                db.executeQuery(" select top 50000 出生日期,id from dog where 出生日期 !=''  and   birth  is null ");
                while (db.next())
                {
                    try
                    {
                        String dates = db.getString(1);
                        int id = db.getInt(2);
                        db2.executeUpdate("update dog set birth='" + dates + "' where id=" + id);
                    } catch (Exception ex)
                    {
                        System.out.println(ex.toString());
                    }
                    i++;
                }
                if (i == 0)
                {
                    db.executeUpdate(" update dog set 出生日期 = birth ");
                    db.close();
                    return;
                }

            } catch (Exception ex)
            {
                throw new SQLException(ex.toString());
            }
        }
    }

    public static java.util.Enumeration findByCommunity(String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select 血统证书号 from dog " + sql);

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

    public static java.util.Enumeration findCsvdogByCommunity(String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT  会员号 FROM  " + sql);

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

    public Date getBirthdate()
    {
        return birthdate;
    }

    public String getBlood()
    {
        return blood;
    }

    public String getBloodf()
    {
        return bloodf;
    }

    public String getBloodm()
    {
        return bloodm;
    }

    public String getCname()
    {
        return cname;
    }

    public String getColor()
    {
        return color;
    }

    public String getEarid()
    {
        return earid;
    }

    public String getElbowcheck()
    {
        return elbowcheck;
    }

    public String getEname()
    {
        return ename;
    }

    public String getExamgrade()
    {
        return examgrade;
    }

    public String getExamrank()
    {
        return examrank;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getForeignblood()
    {
        return foreignblood;
    }

    public String getGamegrade()
    {
        return gamegrade;
    }

    public String getGamerank()
    {
        return gamerank;
    }

    public String getHair()
    {
        return hair;
    }

    public String getHipcheck()
    {
        return hipcheck;
    }

    public int getId()
    {
        return id;
    }

    public String getInbreeding()
    {
        return inbreeding;
    }

    public String getLettertype()
    {
        return lettertype;
    }

    public Date getLurushijian()
    {
        return lurushijian;
    }

    public String getMark()
    {
        return mark;
    }

    public String getMemeber()
    {
        return host;
    }

    public String getOldblood()
    {
        return oldblood;
    }

    public String getPropagatetitle()
    {
        return propagatetitle;
    }

    public String getProvenum()
    {
        return provenum;
    }

    public String getSex()
    {
        return sex;
    }

    public String getSpecialmark()
    {
        return specialmark;
    }

    public String getUmpirevalue()
    {
        return umpirevalue;
    }

    public Date getXiugairiqi()
    {
        return xiugairiqi;
    }

    public String getXuexi()
    {
        return xuexi;
    }

    public String getInbreedprint()
    {
        return inbreedprint;
    }

    public String getBreedpeople()
    {
        return breedpeople;
    }

    public String getBreedaddr()
    {
        return breedaddr;
    }

    public String getFileid()
    {
        return fileid;
    }

    public String getHost()
    {
        return host;
    }

    public String getDNA()
    {
        return DNA;
    }
}
