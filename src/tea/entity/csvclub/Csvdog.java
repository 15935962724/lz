package tea.entity.csvclub;

import java.math.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.resource.*;
import java.text.*;


/*2007年8月29号添加一个字段用于标识*/
///////http://127.0.0.1/jsp/csvclub/csvmating/PrintCsvstudbook2.jsp?blood=CSZ33701////////////////////
public class Csvdog extends Entity
{

    public static final String ZIMU[] =
            {"C","D","E","G","H","I","J","K","O","P","Q","R","T","U","V","W","X","Z"};

    public static final String ED_TYPE[] =
            {"ED1","ED2","ED3","ED4","ED5"}; //// 不用


    public static final String ED_TEXT[] =
            {"正常","基本正常","轻度肘关节病","中度肘关节病","重度肘关节病"}; ////不用
    public static final String ED_BLOOD[] =
            {"-------","红色血统证书","白色临时血统证书","白色终身血统证书","白色证书不能打耳号","作废","类型未确认"};
    public static final String ED_SEXS[] =
            {"公","母"};
    public static final String ED_OTHERPRICE[] =
            {"0","10","20","30","40","50"};

    public static final String KOERUNGS[] =
            {"否","是"};
    public static final String SCHH1S[] =
            {"否","是"};
    public static final String ITPS[] =
            {"是","打印","----"};
    private int id; //
    private int bloodtype;
    private String bloodlineletterid; // //血统证书号
    private String doghost; // // 犬主人用不到了-------.犬主人是否变更 代表原来的主人
    private String ename; // 英文姓名
    private String cname; // 中文姓名
    private Date birthdate; // 出生日期
    private int sex; // 性别
    private String earid; // 耳号
    private String hair; // 毛质
    private String color; // 颜色及标志
    private String specialmark; // 特殊标记
    private String hipcheck; // 髋关节鉴定结果
    private String elbowcheck; // 肘关节鉴定结果
    private String DNA; // DNA
    private String propagatetitle; // 繁殖资格 终生的==1、2年的==2、没有的空==0,取消==3  *Lebenszeit
    private String inbreeding; // 近亲繁殖
    private String fileid; // 档号
    private String gamerank; // 比赛级别
    private String gamegrade; // 比赛成绩
    private String examrank; // 考试级别
    private String examgrade; // 考试成绩
    private String f_bloodlineletterid; // 父血统证书号
    private String m_bloodlineletterid; // 母血统证书号
    private String fm_matingproveid; // 父母犬配犬证明号---------作废
    private String old_bloodlineletterid; // 旧血统证书号
    private String foreignloginletterid; // 国外登记证书号
    private String lettertype; // 证书类型
    private String umpirevalue; // 裁判评价
    private String mark; // 备注
    private String inbreedingprint; // 近亲繁殖打印
    private Date addtime; // 添加日期------填写日期 打印证书时候的时间
    private Date updatetime; // 修改日期]
    private String f_dogname; // 父犬姓名
    private String m_dogname; // 母犬姓名]
    private String f_hipcheck; // 父犬髋关节检测结果
    private String m_hipcheck; // 母犬髋关节检测结果
    private String propagatevaluenew; // 繁殖价值新
    private String propagatevalueold; // 繁殖价值旧
    private String community; // 社区
    private String member; // 用户id
    /** *************************************************************************** */
    private int city; // 新增加的字段城市 繁殖地点 目前还没有用到&***************
    private int num; // 新增加的字段会员编号
    private int itforeign; // 标识国外证书是否转发 1 标识转发了，0标识没有转发
    private String birthaddr; // 出生地点
    private String provenum; // 父母犬配犬证明号
    private int itp; // 标识是否在下一页面显示出来
    private int ite; // 标识耳号已经交费 0 或 空标识没有交费，1标识交费了的
    private int itb; // 标识血统证书已经缴费 0 或 空标识没有交费，1标识交费了的
    private String pic; // 犬的图片照片
    private String remark; // 备注
    private int breedstop; // 是否禁止繁育 0或null 表示不是禁止繁殖。1表示是禁止繁殖。
    private String breedpeople; // 繁殖人
    private String breedaddr; // 繁殖人地址
    private String linshihost; //
    ///**********2008-04-10****************//要注意的地方 要存进去的时候要 改变成日期格式
    private String provedatek; //load_blood() 只作血统的读取了
    private String provedatej; //load_blood()
    ///********koerung,schh1***************////
    private int koerung; //繁育考试
    private int schh1; //防卫一级考试
    private String provebtnum; //本胎数量
    private int dogstatic; //null 或空 为有效，1 死亡，2 遗失，3 其它原因
    private boolean exists; // 是否存在

    public Csvdog(String provenum,int num,int nums) throws SQLException
    {
        this.provenum = provenum;
        loadProveNum();

    }

    public static Csvdog find_prove(String provenum,int a,int b) throws SQLException
    {
        return new Csvdog(provenum,a,b);
    }


    public Csvdog(String earid,int num) throws SQLException
    {
        this.earid = earid;
        loadTemp(earid);
    }

    public static Csvdog find_temp(String earid,int num) throws SQLException
    {
        return new Csvdog(earid,num);
    }

    public Csvdog(String earid) throws SQLException
    {
        this.earid = earid;
        loadBasic();
    }

    public Csvdog(int temp,String earid) throws SQLException
    {
        this.earid = earid;
        loadtemp();
    }

    public static Csvdog findtemp(String earid,int temp) throws SQLException
    {
        try
        {
            return new Csvdog(temp,earid);
        } catch(SQLException ex)
        {
            return null;
        }
    }

    // 通过血统号 查找信息
    public Csvdog(String bloodlineletterid,String str) throws SQLException
    {
        this.bloodlineletterid = bloodlineletterid;
        load_blood();
    }

    public static Csvdog find_blood(String bloodlineletterid,String s) throws SQLException
    {
        return new Csvdog(bloodlineletterid,s);
    }

    public Csvdog(int csvdog,int item,BigDecimal money,int poyear,int outlay,java.util.Date time)
    {

    }

    public static Csvdog find(String earid) throws SQLException
    {
        return new Csvdog(earid);
    }

    // /对临时表的读取
    public void loadtemp() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select cname,ename,color from csvdogtemp where earid =" + DbAdapter.cite(earid));
            if(db.next())
            {
                cname = db.getString(1);
                ename = db.getString(2);
                color = db.getString(3);
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // 后添加的方法
    public void loadTemp(String proveNum) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select earid,bloodlineletterid,cname,sex,color,birthaddr,f_bloodlineletterid,m_bloodlineletterid, proveNum, itp, inbreeding,birthdate,ite,itb,ename,remark,breedstop,dogstatic from csvdog where earid =" + DbAdapter.cite(earid));
            if(db.next())
            {
                earid = db.getString(1);
                bloodlineletterid = db.getString(2);
                cname = db.getString(3);
                sex = db.getInt(4);
                color = db.getString(5);
                birthaddr = db.getString(6);
                f_bloodlineletterid = db.getString(7);
                m_bloodlineletterid = db.getString(8);
                provenum = db.getString(9);
                itp = db.getInt(10);
                inbreeding = db.getString(11);
                birthdate = db.getDate(12);
                ite = db.getInt(13);
                itb = db.getInt(14);
                ename = db.getString(15);
                remark = db.getString(16);
                breedstop = db.getInt(17);
                dogstatic = db.getInt(18);
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    //查找同胎犬只
    public void loadProveNum() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select earid,bloodlineletterid,cname,sex,color,birthaddr,f_bloodlineletterid,m_bloodlineletterid, proveNum, itp, inbreeding,birthdate,ite,itb,ename,remark,breedstop from csvdog where provenum =" + DbAdapter.cite(provenum));
            if(db.next())
            {
                earid = db.getString(1);
                bloodlineletterid = db.getString(2);
                cname = db.getString(3);
                sex = db.getInt(4);
                color = db.getString(5);
                birthaddr = db.getString(6);
                f_bloodlineletterid = db.getString(7);
                m_bloodlineletterid = db.getString(8);
                provenum = db.getString(9);
                itp = db.getInt(10);
                inbreeding = db.getString(11);
                birthdate = db.getDate(12);
                ite = db.getInt(13);
                itb = db.getInt(14);
                ename = db.getString(15);
                remark = db.getString(16);
                breedstop = db.getInt(17);
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db
                    .executeQuery("select bloodlineletterid,doghost,ename,cname,birthdate,sex ,earid,hair,color,specialmark,hipcheck,elbowcheck,DNA,propagatetitle ,inbreeding,fileid,gamerank,gamegrade,  examrank ,examgrade,f_bloodlineletterid,m_bloodlineletterid, fm_matingproveid ,old_bloodlineletterid, foreignloginletterid ,lettertype,umpirevalue,mark,inbreedingprint,addtime,updatetime,f_dogname,m_dogname,f_hipcheck, m_hipcheck ,propagatevaluenew,propagatevalueold,community,member,city,num,itforeign,proveNum,remark,breedstop,DNA,provenum,provedatek,provedatej,breedpeople,breedaddr,koerung,schh1,provebtnum,dogstatic,ite,itb from csvdog WHERE earid="
                                  + DbAdapter.cite(earid));
            if(db.next())
            {
                bloodlineletterid = db.getString(1); // //血统证书号
                doghost = db.getString(2); // // 犬主人
                ename = db.getString(3); // 英文姓名
                cname = db.getString(4); // 中文姓名
                birthdate = db.getDate(5); // 出生日期
                sex = db.getInt(6); // 性别
                earid = db.getString(7); // 耳号
                hair = db.getString(8); // 毛质
                color = db.getString(9); // 颜色及标志
                specialmark = db.getString(10); // 特殊标记
                hipcheck = db.getString(11); // 髋关节鉴定结果
                elbowcheck = db.getString(12); // 肘关节鉴定结果
                DNA = db.getString(13); // DNA
                propagatetitle = db.getString(14); // 繁殖资格
                inbreeding = db.getString(15); // 近亲繁殖
                fileid = db.getString(16); // 档号
                gamerank = db.getString(17); // 比赛级别
                gamegrade = db.getString(18); // 比赛成绩
                examrank = db.getString(19); // 考试级别
                examgrade = db.getString(20); // 考试成绩
                f_bloodlineletterid = db.getString(21); // 父血统证书号
                m_bloodlineletterid = db.getString(22); // 母血统证书号
                fm_matingproveid = db.getString(23); // 父母犬配犬证明号
                old_bloodlineletterid = db.getString(24); // 旧血统证书号
                foreignloginletterid = db.getString(25); // 国外登记证书号
                lettertype = db.getString(26); // 证书类型
                umpirevalue = db.getString(27); // 裁判评价
                mark = db.getString(28); // 备注
                inbreedingprint = db.getString(29); // 近亲繁殖打印
                addtime = db.getDate(30); // 添加日期
                updatetime = db.getDate(31); // 修改日期]
                f_dogname = db.getString(32); // 父犬姓名
                m_dogname = db.getString(33); // 母犬姓名]
                f_hipcheck = db.getString(34); // 父犬髋关节检测结果
                m_hipcheck = db.getString(35); // 母犬髋关节检测结果
                propagatevaluenew = db.getString(36); // 繁殖价值新
                propagatevalueold = db.getString(37); // 繁殖价值旧
                community = db.getString(38); // 社区
                member = db.getString(39); // 管理员
                city = db.getInt(40);
                num = db.getInt(41);
                itforeign = db.getInt(42);
                provenum = db.getString(43);
                remark = db.getString(44);
                breedstop = db.getInt(45);
                DNA = db.getString(46);
                provenum = db.getString(47);
                provedatek = db.getString(48);
                provedatej = db.getString(49);
                breedpeople = db.getString(50); // 繁殖人
                breedaddr = db.getString(51); // 繁殖人地址
                koerung = db.getInt(52); //繁育考试
                schh1 = db.getInt(53); //防卫一级考试
                provebtnum = db.getString(54); //本胎数量
                dogstatic = db.getInt(55);
                ite = db.getInt(56);
                itb = db.getInt(57);
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

    private void load_blood() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select earid,doghost,ename,cname,birthdate,sex ,earid,hair,color,specialmark,hipcheck,elbowcheck,DNA,propagatetitle ,inbreeding,fileid,gamerank,gamegrade,  examrank ,examgrade,f_bloodlineletterid,m_bloodlineletterid, fm_matingproveid ,old_bloodlineletterid, foreignloginletterid ,lettertype,umpirevalue,mark,inbreedingprint,addtime,updatetime,f_dogname,m_dogname,f_hipcheck, m_hipcheck ,propagatevaluenew,propagatevalueold,community,member,city,num,pic,remark,DNA,provenum,provedatek,provedatej,breedpeople,breedaddr,koerung,schh1,provebtnum,dogstatic,ite,itb from csvdog WHERE bloodlineletterid="
                            + DbAdapter.cite(bloodlineletterid));

            if(db.next())
            {
                earid = db.getString(1); // //耳号
                doghost = db.getString(2); // // 犬主人
                ename = db.getString(3); // 英文姓名
                cname = db.getString(4); // 中文姓名
                birthdate = db.getDate(5); // 出生日期
                sex = db.getInt(6); // 性别
                earid = db.getString(7); // 耳号
                hair = db.getString(8); // 毛质
                color = db.getString(9); // 颜色及标志
                specialmark = db.getString(10); // 特殊标记
                hipcheck = db.getString(11); // 髋关节鉴定结果
                elbowcheck = db.getString(12); // 肘关节鉴定结果
                DNA = db.getString(13); // DNA
                propagatetitle = db.getString(14); // 繁殖资格
                inbreeding = db.getString(15); // 近亲繁殖
                fileid = db.getString(16); // 档号
                gamerank = db.getString(17); // 比赛级别
                gamegrade = db.getString(18); // 比赛成绩
                examrank = db.getString(19); // 考试级别
                examgrade = db.getString(20); // 考试成绩
                f_bloodlineletterid = db.getString(21); // 父血统证书号
                m_bloodlineletterid = db.getString(22); // 母血统证书号
                fm_matingproveid = db.getString(23); // 父母犬配犬证明号
                old_bloodlineletterid = db.getString(24); // 旧血统证书号
                foreignloginletterid = db.getString(25); // 国外登记证书号
                lettertype = db.getString(26); // 证书类型
                umpirevalue = db.getString(27); // 裁判评价
                mark = db.getString(28); // 备注
                inbreedingprint = db.getString(29); // 近亲繁殖打印
                addtime = db.getDate(30); // 添加日期
                updatetime = db.getDate(31); // 修改日期]
                f_dogname = db.getString(32); // 父犬姓名
                m_dogname = db.getString(33); // 母犬姓名]
                f_hipcheck = db.getString(34); // 父犬髋关节检测结果
                m_hipcheck = db.getString(35); // 母犬髋关节检测结果
                propagatevaluenew = db.getString(36); // 繁殖价值新
                propagatevalueold = db.getString(37); // 繁殖价值旧
                community = db.getString(38); // 社区
                member = db.getString(39); // 管理员
                city = db.getInt(40);
                num = db.getInt(41);
                pic = db.getVarchar(1,1,42);
                remark = db.getString(43); //
                DNA = db.getString(44);
                provenum = db.getString(45);
                provedatek = db.getString(46);
                provedatej = db.getString(47);
                breedpeople = db.getString(48); // 繁殖人
                breedaddr = db.getString(49); // 繁殖人地址
                koerung = db.getInt(50); //繁育考试
                schh1 = db.getInt(51); //防卫一级考试
                provebtnum = db.getString(52); //本胎数量
                dogstatic = db.getInt(53);
                ite = db.getInt(54);
                itb = db.getInt(55);
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

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE Csvdog WHERE bloodlineletterid=" + bloodlineletterid);
        } finally
        {
            db.close();
        }

    }

    public static void create(String bloodlineletterid,String doghost,String ename,String cname,String birthdate,int sex,String earid,String hair,String color,String specialmark,String hipcheck,String elbowcheck,String DNA,String propagatetitle,String inbreeding,String fileid,String gamerank,String gamegrade,String examrank,String examgrade,String f_bloodlineletterid,String m_bloodlineletterid,String fm_matingproveid,String old_bloodlineletterid,
                              String foreignloginletterid,String lettertype,String umpirevalue,String mark,String inbreedingprint,String addtime,String updatetime,String f_dogname,String m_dogname,String f_hipcheck,String m_hipcheck,String propagatevaluenew,String propagatevalueold,String community,RV _rv,int city,int num) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Csvdog(bloodlineletterid,doghost,ename,cname,birthdate,sex ,earid,hair,color,specialmark,hipcheck,elbowcheck,DNA,propagatetitle ,inbreeding,fileid,gamerank,gamegrade,  examrank ,examgrade,f_bloodlineletterid,m_bloodlineletterid, fm_matingproveid ,old_bloodlineletterid, foreignloginletterid ,lettertype,umpirevalue,mark,inbreedingprint,addtime,updatetime,f_dogname,m_dogname,f_hipcheck, m_hipcheck ,propagatevaluenew,propagatevalueold,community,member,city,num,provenum) VALUES("
                             + DbAdapter.cite(bloodlineletterid)
                             + ","
                             + DbAdapter.cite(doghost)
                             + ","
                             + DbAdapter.cite(ename)
                             + ","
                             + DbAdapter.cite(cname)
                             + ","
                             + DbAdapter.cite(birthdate)
                             + ","
                             + (sex)
                             + ","
                             + DbAdapter.cite(earid)
                             + ","
                             + DbAdapter.cite(hair)
                             + ","
                             + DbAdapter.cite(color)
                             + ","
                             + DbAdapter.cite(specialmark)
                             + ","
                             + DbAdapter.cite(hipcheck)
                             + ","
                             + DbAdapter.cite(elbowcheck)
                             + ","
                             + DbAdapter.cite(DNA)
                             + ","
                             + DbAdapter.cite(propagatetitle)
                             + ","
                             + DbAdapter.cite(inbreeding)
                             + ","
                             + DbAdapter.cite(fileid)
                             + ","
                             + DbAdapter.cite(gamerank)
                             + ","
                             + DbAdapter.cite(gamegrade)
                             + ","
                             + DbAdapter.cite(examrank)
                             + ","
                             + DbAdapter.cite(examgrade)
                             + ","
                             + DbAdapter.cite(f_bloodlineletterid)
                             + ","
                             + DbAdapter.cite(m_bloodlineletterid)
                             + ","
                             + DbAdapter.cite(fm_matingproveid)
                             + ","
                             + DbAdapter.cite(old_bloodlineletterid)
                             + ","
                             + DbAdapter.cite(foreignloginletterid)
                             + ","
                             + DbAdapter.cite(lettertype)
                             + ","
                             + DbAdapter.cite(umpirevalue)
                             + ","
                             + DbAdapter.cite(mark)
                             + ","
                             + DbAdapter.cite(inbreedingprint)
                             + ","
                             + DbAdapter.cite(addtime)
                             + ","
                             + DbAdapter.cite(updatetime)
                             + ","
                             + DbAdapter.cite(f_dogname)
                             + ","
                             + DbAdapter.cite(m_dogname)
                             + ","
                             + DbAdapter.cite(f_hipcheck) + "," + DbAdapter.cite(m_hipcheck) + "," + DbAdapter.cite(propagatevaluenew) + "," + DbAdapter.cite(propagatevalueold) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(_rv.toString()) + "," + city + "," + num + "," + DbAdapter.cite(fm_matingproveid) + ")");
        } finally
        {
            db.close();
        }
    }

    //添加父母犬只
    // /对狗表信息的导入
    public static void createtesting(String blood,String host,String ename,String cname,Date birthdate,int sex,String earid,String hair,String color,String specialmark,String hipcheck,String elbowcheck,String propagatetitle,String inbreeding,String gamerank,String gamegrade,String examrank,String examgrade,String bloodf,String bloodm,String provenum,String oldblood,String foreignblood,String lettertype,String umpirevalue,String mark,Date lurushijian,Date xiugairiqi,
                                     String inbreedprint,String breedpeople,String breedaddr,String xuexi,String fileid,String DNA,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Csvdog( bloodlineletterid,  linshihost,  ename,  cname,  birthdate,  sex, earid,  hair, color, specialmark, hipcheck, elbowcheck, propagatetitle, inbreeding, gamerank, gamegrade,  examrank, examgrade,  f_bloodlineletterid, m_bloodlineletterid, provenum, old_bloodlineletterid, foreignloginletterid,  lettertype, umpirevalue, mark,  addtime,  updatetime, inbreedingprint, breedpeople, breedaddr, xuexi,  fileid,  DNA,member ) values(" + DbAdapter.cite(blood) + ", "
                             + DbAdapter.cite(host) + "," + DbAdapter.cite(ename) + ", " + DbAdapter.cite(cname) + "," + DbAdapter.cite(birthdate) + ", " + sex + "," + DbAdapter.cite(earid) + ", " + DbAdapter.cite(hair) + "," + DbAdapter.cite(color) + "," + DbAdapter.cite(specialmark) + "," + DbAdapter.cite(hipcheck) + "," + DbAdapter.cite(elbowcheck) + "," + DbAdapter.cite(propagatetitle) + "," + DbAdapter.cite(inbreeding) + "," + DbAdapter.cite(gamerank) + "," + DbAdapter.cite(gamegrade) + "," + DbAdapter.cite(examrank) + "," + DbAdapter.cite(examgrade) + "," + DbAdapter.cite(bloodf) + "," + DbAdapter.cite(bloodm) + ","
                             + DbAdapter.cite(provenum) + "," + DbAdapter.cite(oldblood) + "," + DbAdapter.cite(foreignblood) + "," + DbAdapter.cite(lettertype) + "," + DbAdapter.cite(umpirevalue) + "," + DbAdapter.cite(mark) + "," + DbAdapter.cite(lurushijian) + "," + DbAdapter.cite(xiugairiqi) + "," + DbAdapter.cite(inbreedprint) + "," + DbAdapter.cite(breedpeople) + "," + DbAdapter.cite(breedaddr) + "," + DbAdapter.cite(xuexi) + "," + DbAdapter.cite(fileid) + "," + DbAdapter.cite(DNA) + "," + DbAdapter.cite(member) + ")");
        } catch(Exception ex)
        {
            System.out.println(ex.toString());
            // throw new SQLException(ex.toString());
        } finally
        {

            db.close();
        }
    }

    public void set(String bloodlineletterid,String doghost,String ename,String cname,Date birthdate,int sex,String earid,String hair,String color,String specialmark,String hipcheck,String elbowcheck,String DNA,String propagatetitle,String inbreeding,String fileid,String gamerank,String gamegrade,String examrank,String examgrade,String f_bloodlineletterid,String m_bloodlineletterid,String fm_matingproveid,String old_bloodlineletterid,String foreignloginletterid,
                    String lettertype,String umpirevalue,String mark,String inbreedingprint,Date addtime,Date updatetime,String f_dogname,String m_dogname,String f_hipcheck,String m_hipcheck,String propagatevaluenew,String propagatevalueold,String community,RV _rv,int city,int num) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Csvdog SET" + "bloodlineletterid=" + DbAdapter.cite(bloodlineletterid) + ",doghost=" + DbAdapter.cite(doghost) + ",ename=" + DbAdapter.cite(ename) + ",cname=" + DbAdapter.cite(cname) + "birthdate=" + DbAdapter.cite(birthdate) + ",sex=" + (sex) + ",arid=" + DbAdapter.cite(earid) + "hair=" + DbAdapter.cite(hair) + ",color=" + DbAdapter.cite(color) + ",specialmark=" + DbAdapter.cite(specialmark) + ",hipcheck=" + DbAdapter.cite(hipcheck) + ",elbowcheck=" + DbAdapter.cite(elbowcheck) + ",DNA=" + DbAdapter.cite(DNA) + "propagatetitle="
                             + DbAdapter.cite(propagatetitle) + "inbreeding=" + DbAdapter.cite(inbreeding) + ",fileid=" + DbAdapter.cite(fileid) + ",gamerank=" + DbAdapter.cite(gamerank) + ",gamegrade=" + DbAdapter.cite(gamegrade) + ",examrank=" + DbAdapter.cite(examrank) + ",examgrade=" + DbAdapter.cite(examgrade) + ",f_bloodlineletterid=" + DbAdapter.cite(f_bloodlineletterid) + "m_bloodlineletterid=" + DbAdapter.cite(m_bloodlineletterid) + ",fm_matingproveid=" + DbAdapter.cite(fm_matingproveid) + "old_bloodlineletterid=" + DbAdapter.cite(old_bloodlineletterid)
                             + "foreignloginletterid=" + DbAdapter.cite(foreignloginletterid) + ",lettertype=" + DbAdapter.cite(lettertype) + ",umpirevalue=" + DbAdapter.cite(umpirevalue) + ",mark=" + DbAdapter.cite(mark) + ",inbreedingprint=" + DbAdapter.cite(inbreedingprint) + ",addtime=" + DbAdapter.cite(addtime) + ",updatetime=" + DbAdapter.cite(updatetime) + ",f_dogname=" + DbAdapter.cite(f_dogname) + ",m_dogname=" + DbAdapter.cite(m_dogname) + ",f_hipcheck=" + DbAdapter.cite(f_hipcheck) + ",m_hipcheck=" + DbAdapter.cite(m_hipcheck) + ",propagatevaluenew="
                             + DbAdapter.cite(propagatevaluenew) + ",propagatevalueold=" + DbAdapter.cite(propagatevalueold) + ",community=" + DbAdapter.cite(community) + ",member=" + DbAdapter.cite(_rv.toString()) + ",city=" + city + ",num=" + num + " WHERE bloodlineletterid=" + bloodlineletterid);
        } finally
        {
            db.close();
        }
        this.bloodlineletterid = bloodlineletterid;
        this.doghost = doghost;
        this.ename = ename;
        this.cname = cname;
        this.birthdate = birthdate;
        this.sex = sex;
        this.earid = earid;
        this.hair = hair;
        this.color = color;
        this.specialmark = specialmark;
        this.hipcheck = hipcheck;
        this.elbowcheck = elbowcheck;
        this.DNA = DNA;
        this.propagatetitle = propagatetitle;
        this.inbreeding = inbreeding;
        this.fileid = fileid;
        this.gamerank = gamerank;
        this.gamegrade = gamegrade;
        this.examrank = examrank;
        this.examgrade = examgrade;
        this.f_bloodlineletterid = f_bloodlineletterid;
        this.m_bloodlineletterid = m_bloodlineletterid;
        this.fm_matingproveid = fm_matingproveid;
        this.old_bloodlineletterid = old_bloodlineletterid;
        this.foreignloginletterid = foreignloginletterid;
        this.lettertype = lettertype;
        this.umpirevalue = umpirevalue;
        this.mark = mark;
        this.inbreedingprint = inbreedingprint;
        this.addtime = addtime;
        this.updatetime = updatetime;
        this.f_dogname = f_dogname;
        this.m_dogname = m_dogname;
        this.f_hipcheck = f_hipcheck;
        this.m_hipcheck = m_hipcheck;
        this.propagatevaluenew = propagatevaluenew;
        this.propagatevalueold = propagatevalueold;
        this.community = community;
        this.member = member;
        this.city = city;
        this.num = num;
    }

//    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int pageSize) throws SQLException
//    {
//        java.util.Vector vector = new java.util.Vector();
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            db.executeQuery("SELECT TOP " + (pos + pageSize) + " cd.earid FROM Csvdog cd,Profile p WHERE p.member=cd.member AND cd.community=" + DbAdapter.cite(community) + " AND p.community=" + DbAdapter.cite(community) + sql);
//            System.out.print("SELECT TOP " + (pos + pageSize) + " cd.earid FROM Csvdog cd,Profile p WHERE p.member=cd.member AND cd.community=" + DbAdapter.cite(community) + " AND p.community=" + DbAdapter.cite(community) + sql);
//            for (int l = 0; db.next(); l++)
//            {
//                if (l >= pos)
//                {
//                    String csvdog = db.getString(1);
//                    vector.addElement(csvdog);
//                }
//            }
//        } finally
//        {
//            db.close();
//        }
//        return vector.elements();
//    }
    public static java.util.Enumeration findByCommunity(String community,String sql,int pos,int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  cd.earid FROM Csvdog cd,Profile p WHERE p.member=cd.member AND cd.community=" + DbAdapter.cite(community) + " AND p.community=" + DbAdapter.cite(community) + sql);
            //System.out.print("SELECT TOP " + (pos + pageSize) + " cd.earid FROM Csvdog cd,Profile p WHERE p.member=cd.member AND cd.community=" + DbAdapter.cite(community) + " AND p.community=" + DbAdapter.cite(community) + sql);
            for(int l = 0;l < pos + pageSize && db.next();l++)
            {
                if(l >= pos)
                {
                    vector.addElement(String.valueOf(db.getString(1)));
                }
            }

        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    /**
     * 2008年6月23日12:49:36 枚举血统证书号
     * */

    public static java.util.Enumeration findByCommunity_blood(String community,String sql,int pos,int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  cd.bloodlineletterid FROM Csvdog cd,Profile p WHERE p.member=cd.member AND cd.community=" + DbAdapter.cite(community) + " AND p.community=" + DbAdapter.cite(community) + sql);
            //System.out.print("SELECT TOP " + (pos + pageSize) + " cd.earid FROM Csvdog cd,Profile p WHERE p.member=cd.member AND cd.community=" + DbAdapter.cite(community) + " AND p.community=" + DbAdapter.cite(community) + sql);
            for(int l = 0;l < pos + pageSize && db.next();l++)
            {
                if(l >= pos)
                {
                    vector.addElement(String.valueOf(db.getString(1)));
                }
            }

        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    // 枚举
    public static java.util.Enumeration findByCommunitynew(String community,String sql,int pos,int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  earid FROM Csvdog ,Profile  WHERE Profile.member=Csvdog.member " + sql);
            //System.out.print("SELECT TOP " + (pos + pageSize) + " cd.earid FROM Csvdog cd,Profile p WHERE p.member=cd.member AND cd.community=" + DbAdapter.cite(community) + " AND p.community=" + DbAdapter.cite(community) + sql);
            for(int l = 0;l < pos + pageSize && db.next();l++)
            {
                if(l >= pos)
                {
                    vector.addElement(String.valueOf(db.getString(1)));
                }
            }

        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    public static java.util.Enumeration findBydog(String community,String sql,int pos,int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT earid FROM Csvdog WHERE community=" + DbAdapter.cite(community) + sql);

            for(int l = 0;l < pos + pageSize && db.next();l++)
            {
                if(l >= pos)
                {
                    vector.addElement(String.valueOf(db.getString(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration findTempByCommunity(String community,String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT earid FROM Csvdog where " + sql);

            while(db.next())
            {
                vector.addElement(String.valueOf(db.getString(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    // ------------------------------判断狗的组别-------------------------------///--------------------------//
    public static String getBrigade(Date times,int se,Date time_k) throws SQLException
    {

        String sex = "";
        // Date date = new Date();
        if(se == 0)
        {
            sex = "公";
        }
        if(se == 1)
        {
            sex = "母";
        }
        Calendar calendar = Calendar.getInstance();

        calendar.setTime(time_k);
        long timethis = calendar.getTimeInMillis();

        calendar.setTime(times);
        long timeend = calendar.getTimeInMillis();
        long theday = (timethis - timeend) / (1000 * 60 * 60 * 24);
        int tday = (int) theday / 30;
        if(tday > 24 || tday == 24)
        {
            return "成年" + sex + "犬组";
        }
        if(18 < tday && tday < 24 || tday == 18)
        {
            return "青年" + sex + "犬组";
        }
        if(12 < tday && tday < 18 || tday == 12)
        {
            return "幼年" + sex + "犬组";
        }
        if(9 < tday && tday < 12 || tday == 9)
        {
            return "幼大" + sex + "犬组";
        }
        if(6 < tday && tday < 9 || tday == 6)
        {
            return "幼小" + sex + "犬组";
        }
        return "暂无";

    }

    public static String csvdogname(String hipid) throws SQLException
    {
        String str = null;
        DbAdapter db = new DbAdapter();
        try
        {
            str = db.getString("select cname from csvdog where earid in (select earid from csvdogcheck where hipid=" + DbAdapter.cite(hipid) + ")");
        } finally
        {
            db.close();
        }
        return str;
    }

    public static int count(String bloodlineletterid,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(community) FROM Csvdog WHERE bloodlineletterid=" + DbAdapter.cite(bloodlineletterid) + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {

            db.close();
        }
        return j;
    }

    public static int countint(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(*) FROM Csvdog cd,Profile p WHERE p.member=cd.member AND cd.community=" + DbAdapter.cite(community) + sql);

            if(db.next())
            {
                j = db.getInt(1);
            }

        } catch(Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int countintnew(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(*) FROM Csvdog ,Profile  WHERE Profile.member=Csvdog.member " + sql);

            if(db.next())
            {
                j = db.getInt(1);
            }

        } catch(Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
        return j;
    }

    ////2008年1月21日//////
    public static int countbloodint(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" Select count(*) from Csvdog where community =" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }


    // /通过用户名取得犬舍名称
    public static String getCsvhouse(String member) throws SQLException
    {
        String str = null;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select doghouseC from csvdoghouse where member=" + DbAdapter.cite(member));
            if(db.next())
            {
                str = db.getString(1);
            }

        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
        return str;
    }

    // 判断是否为近亲繁殖  2008-04-13
    public static String getNear(String blood1,String blood2) throws SQLException //比较血统证书号blood1公 ，blood2母
    {
        String str = "否";
        String bloodf_f = null;
        String bloodf_m = null;

        String bloodm_f = null;
        String bloodm_m = null;
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeQuery("select m_bloodlineletterid from csvdog where bloodlineletterid = " + DbAdapter.cite(blood1));
            if(db.next()) ///son血统证书号 与 母犬信息相同
            {
                str = db.getString(1);
                if(blood2 == str)
                {
                    str = "是";
                } else
                {
                    str = "否";
                }

            }
            db.executeQuery("select f_bloodlineletterid from csvdog where bloodlineletterid =" + DbAdapter.cite(blood2));
            while(db.next()) ///假如是父犬与血统证书号
            {
                str = db.getString(1);
                if(blood1 == str)
                {
                    str = "是";
                } else
                {
                    str = "否";
                }

            }
            db.executeQuery("select f_bloodlineletterid,m_bloodlineletterid from csvdog where bloodlineletterid = " + DbAdapter.cite(blood1));
            if(db.next()) ///假如是父犬与血统证书号
            {
                bloodf_f = db.getString(1);
                bloodf_m = db.getString(2);

                db2.executeQuery("select f_bloodlineletterid,m_bloodlineletterid from Csvdog where bloodlineletterid= " + DbAdapter.cite(blood2));
                if(db2.next())
                {
                    bloodm_f = db2.getString(1);
                    bloodm_m = db2.getString(2);
                    if(bloodf_f.equals(bloodm_f) || bloodf_m.equals(bloodm_m))
                    {
                        str = "是";
                    } else
                    {
                        str = "否";
                    }
                }
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
            db2.close();
        }
        return str;
    }

    // 5.犬主人是否变更

    public static String gethostbb(String earid) throws SQLException
    {
        String str;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select doghost from csvdog where earid =" + DbAdapter.cite(earid));
            if(db.next())
            {
                str = db.getString(1);
                if(str != null && str.length() > 0)
                {
                    return "已变更";
                } else
                {
                    return "未";
                }

            } else
            {
                return "未";
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // //查找犬的一代父母犬//////此方法无意义,小刘于2007-11-12注释
    // public static String getAncestry(String zidu, String blood, String community) throws SQLException
    // {
    // DbAdapter db = new DbAdapter();
    // String str = "";
    // try
    // {
    // db.executeQuery("select " + zidu + " from Csvdog where " + zidu + " = " + DbAdapter.cite(blood) + " and community=" + DbAdapter.cite(community));
    // if (db.next())
    // {
    // str = db.getString(1);
    // }
    // } catch (Exception ex)
    // {
    // throw new SQLException(ex.toString());
    // } finally
    // {
    // db.close();
    // }
    // return str;
    // }



    ///补做血统证书.判断证书类型,输入血统证书号，父母犬只信息
    /******
     *近亲5
     *24公20母。。。  3
     *************/


    public static int bloodbuzuo(String bloodf,String bloodm,String provenum) throws SQLException
    {
//        DbAdapter db = new DbAdapter();
//        int dog_fint = 0;
//        int dog_mint = 0;
//        try
//        {
//            Csvdog dog_f = Csvdog.find_blood(bloodf, "");
//            Csvdog dog_m = Csvdog.find_blood(bloodm, "");
//
//            if (dog_f.getPropagatetitle() != "")
//            {
//                dog_fint = Integer.parseInt(dog_f.getPropagatetitle());
//            } else
//            {
//                dog_fint = 0;
//            }
//
//            if (dog_m.getPropagatetitle() != "")
//            {
//                dog_mint = Integer.parseInt(dog_m.getPropagatetitle());
//            } else
//            {
//                dog_mint = 0;
//            }
//            if (dog_fint == 1 && dog_mint == 1)
//            {
//                return 1;
//            } else if (dog_fint == 1 && dog_mint != 1)
//            {
////                if (dog_mint == 2)
////                {
////                    Csvdogprove dogprove = Csvdogprove.find(provenum, 1);
////                    dogprove.getFmprovetime();
////                    dog_m.getProvedatej();
////                    if (dog_m.getProvedatej().compareTo(dogprove.getFmprovetime()) == -1)
////                    {
////                        return 1;
////                    } else
////                    {
////                        return 0;
////                    }
////                } else if (dog_mint == 3)
////                {
////                    return 0;
////                }
//            } else if (dog_fint != 1 && dog_mint == 1)
//            {
//
////                if (dog_fint == 2)
////                {
////                    Csvdogprove dogprove = Csvdogprove.find(provenum, 1);
////                    dogprove.getFmprovetime();
////                    dog_f.getProvedatej();
////                    if (dog_f.getProvedatej().compareTo(dogprove.getFmprovetime()) == -1)
////                    {
////                        return 1;
////                    } else
////                    {
////                        return 0;
////                    }
//                } else
//                {
////                    String near = Csvdog.getNear(bloodf, bloodm);
////                    if (near.equals("是"))
////                    {
////                        return 5;
////                    } else if (near.equals("否"))
////                    {
////                        Csvdogprove dogprove = Csvdogprove.find(provenum, 1);
////                        int dd1 = 0;
////
////                        dd1 = Csvdogblt.getDays(dog_f.getBirthdate());
////                        int dd2 = 0;
////                        dd2 = Csvdogblt.getDays(dog_m.getBirthdate());
////                        int dd3 = 0;
////                        dd3 = Csvdogblt.getDays(dogprove.getFmprovetime());
////
////                        if (dd1 < 24 || dd2 < 20)
////                        {
////                            return 3;
////                        } else if ((dd1 - dd3) > 23 && (dd2 - dd3) > 19)
////                        {
////                            return 2;
////                        }
////                    }
//                }
//            }
//        } finally
//        {
//            db.close();
//        }
        return 1;
    }

    // 自动生成血统号
    public static String getMarkblood(int bloodtype,int itforeign,int nums) throws SQLException
    {
        String str = null;
        String falg = null;
        int falgs = 0;
        int i = 0;
        String max = null;
        String mark = null;
        SeqTable seqtable = new SeqTable();

        DbAdapter db = new DbAdapter();
        try
        {
            if(bloodtype == 1 && itforeign == 1) // 粉红转发血统证书号
            {
                mark = "CSZ";
                db.executeQuery("select max (bloodlineletterid) from Csvdog where bloodlineletterid like " + DbAdapter.cite(mark + "%"));
                if(db.next())
                {
                    max = db.getString(1);
                }
                if(max != null && max.length() > 0)
                {
                    i = tea.entity.SeqTable.getSeqNo("CSZ800");
                    falgs = i;
                  //  mark = mark + seqtable.df5.format(falgs);
                }
            } else if(bloodtype == 1 && itforeign == 0) // 粉红血统证书 未转发的
            {
                mark = "CSZ";
                db.executeQuery("select max (bloodlineletterid) from Csvdog where bloodlineletterid like " + DbAdapter.cite(mark + "_____"));
                if(db.next())
                {
                    max = db.getString(1);
                }
                if(max != null && max.length() > 0)
                {
                    i = tea.entity.SeqTable.getSeqNo("CSZ");
                    falgs = i;
                   // mark = mark + seqtable.df5.format(falgs);
                }
            }

            else if(bloodtype != 1 && itforeign == 1) // /白色血统证书是转发
            {
                mark = "CSZW"; ///基本上不存在这样的情况
                db.executeQuery("select max (bloodlineletterid) from Csvdog where bloodlineletterid like " + DbAdapter.cite(mark + "______"));
                if(db.next())
                {
                    max = db.getString(1);
                }
                if(max != null && max.length() > 0)
                {
                    i = tea.entity.SeqTable.getSeqNo("CSZW800");
                    falgs = i;
                   // mark = mark + seqtable.df5.format(falgs);

                }
            } else if(bloodtype != 1 && itforeign != 1)
            {
                mark = "CSZW";
                db.executeQuery("select max (bloodlineletterid) from Csvdog where bloodlineletterid like " + DbAdapter.cite(mark + "_____"));

                if(db.next())
                {
                    max = db.getString(1);
                }
                if(max != null && max.length() > 0)
                {
                    i = tea.entity.SeqTable.getSeqNo("CSZ");
                    falgs = i;
                  //  mark = mark + seqtable.df5.format(falgs);

                }
            } else if(bloodtype == 5)
            {
                mark = "XXX";

            }
            return mark;

        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    /***************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
     * 由于临时表需要新加入的方法。
     *
     * 耳号earid，血统证书号bloodlineletterid，名字cname，性别sex，标识color，出生地点birthaddr，父血统号f_bloodlineletterid，母血统号m_bloodlineletterid，出生日期birthdate，近亲inbreeding。
     *
     * 添加日期2007-08-16 ***********************
     */
    // 1.插入狗表信息，第一次插入。
    public static void createDog(String earid,String bloodlineletterid,String ename,String cname,int sex,String color,String birthaddr,String f_bloodlineletterid,String m_bloodlineletterid,String proveNum,int itp,String inbreeding,Date birthdate,String community,String member,int citys) throws SQLException
    {
        int ite = 0;
        int itb = 0;
        String DNA = "0";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Csvdog (earid,bloodlineletterid,ename,cname,sex,color,birthaddr,f_bloodlineletterid,m_bloodlineletterid, proveNum, itp, inbreeding,birthdate,community,ite,itb,member,city,DNA) values (" + DbAdapter.cite(earid) + "," + DbAdapter.cite(bloodlineletterid) + "," + DbAdapter.cite(ename) + "," + DbAdapter.cite(cname) + "," + sex + "," + DbAdapter.cite(color) + "," + DbAdapter.cite(birthaddr) + "," + DbAdapter.cite(f_bloodlineletterid) + "," + DbAdapter.cite(m_bloodlineletterid) + "," + DbAdapter.cite(proveNum) + "," + itp
                             + "," + DbAdapter.cite(inbreeding) + "," + DbAdapter.cite(birthdate) + "," + DbAdapter.cite(community) + "," + ite + "," + itb + "," + DbAdapter.cite(member) + "," + citys + "," + DbAdapter.cite(DNA) + ")");
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    //*2008-04-12**//
    public static void setUpdatehost(String bloodlineletterid,String breedpeople,String breedaddr,String member,String provebtnum) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        //breedpeople繁殖人 ，breedaddr繁殖人地址
        try
        {
            db.executeUpdate("Update csvdog set provebtnum=" + db.cite(provebtnum) + " ,member =" + db.cite(member) + ",breedaddr=" + db.cite(breedaddr) + ",breedpeople =" + db.cite(breedpeople) + " where bloodlineletterid=" + db.cite(bloodlineletterid));
        } finally
        {
            db.close();
        }
    }

    ///
    public static void setColer(String hair,String color,String specialmark,String blood) throws SQLException
    {
//      private String hair; // 毛质
//      private String color; // 颜色及标志
//      private String specialmark; // 特殊标记
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update Csvdog set hair = " + db.cite(hair) + " ,color=" + db.cite(color) + " ,specialmark=" + db.cite(specialmark) + " where bloodlineletterid=" + db.cite(blood));
        } finally
        {
            db.close();
        }
    }

    public static void setDogfm(String bloodlineletterid,String doghost,String ename,String cname,String birthdate,int sex,String earid,String hair,String color,String specialmark,String hipcheck,String elbowcheck,String DNA,String propagatetitle,String inbreeding,String fileid,String gamerank,String gamegrade,String examrank,String examgrade,String f_bloodlineletterid,String m_bloodlineletterid,String fm_matingproveid,String old_bloodlineletterid,
                                String foreignloginletterid,String lettertype,String umpirevalue,String mark,String inbreedingprint,String addtime,String updatetime,String f_dogname,String m_dogname,String f_hipcheck,String m_hipcheck,String propagatevaluenew,String propagatevalueold,String community,RV _rv,int city,int num) throws SQLException

    {
        // ,hipcheck,elbowcheck,DNA,propagatetitle ,inbreeding,fileid,gamerank,gamegrade,  examrank ,examgrade,f_bloodlineletterid,m_bloodlineletterid, fm_matingproveid ,old_bloodlineletterid, foreignloginletterid ,lettertype,umpirevalue,mark,inbreedingprint,addtime,updatetime,f_dogname,m_dogname,f_hipcheck, m_hipcheck ,propagatevaluenew,propagatevalueold,community,member,city,num
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update csvdog set updatetime=" + DbAdapter.cite(updatetime) + ",  addtime=" + DbAdapter.cite(addtime) + ", inbreedingprint=" + DbAdapter.cite(inbreedingprint) + ", mark=" + DbAdapter.cite(mark) + ",f_dogname = " + DbAdapter.cite(f_dogname) + ",m_dogname = " + DbAdapter.cite(m_dogname) + ",propagatevalueold = " + DbAdapter.cite(propagatevalueold) + ",community =" + DbAdapter.cite(community) + ",propagatevaluenew = " + DbAdapter.cite(propagatevaluenew) + ",m_hipcheck = " + DbAdapter.cite(m_hipcheck) + ",f_hipcheck =" + DbAdapter.cite(f_hipcheck) + ",hipcheck =" + DbAdapter.cite(hipcheck) + ",elbowcheck=" + DbAdapter.cite(elbowcheck) + ",DNA =" + DbAdapter.cite(DNA) + ", gamegrade =" + DbAdapter.cite(gamegrade) + ",examrank = " + DbAdapter.cite(examrank) +
                             ",examgrade = " + DbAdapter.cite(examgrade) + ", gamerank = " + DbAdapter.cite(gamerank) + ",fileid = " + DbAdapter.cite(fileid) + ",old_bloodlineletterid = " + DbAdapter.cite(old_bloodlineletterid) + ",propagatetitle=" + DbAdapter.cite(propagatetitle) + " ,umpirevalue=" + DbAdapter.cite(umpirevalue) + ", lettertype="
                             + DbAdapter.cite(lettertype) + ", foreignloginletterid=" + DbAdapter.cite(foreignloginletterid) + " ,specialmark=" + DbAdapter.cite(specialmark) + ", hair=" + DbAdapter.cite(hair) + ", doghost=" + DbAdapter.cite(doghost) + ", earid=" + DbAdapter.cite(earid) + ",bloodlineletterid=" + DbAdapter.cite(bloodlineletterid) + ",ename=" + DbAdapter.cite(ename) + ",cname=" + DbAdapter.cite(cname) + ",sex=" + sex + ",color=" + DbAdapter.cite(color) + ",f_bloodlineletterid=" + DbAdapter.cite(f_bloodlineletterid) + ",m_bloodlineletterid=" + DbAdapter.cite(m_bloodlineletterid) + ", proveNum=" + DbAdapter.cite(fm_matingproveid) + ", inbreeding=" + DbAdapter.cite(inbreeding) + ",birthdate=" + DbAdapter.cite(birthdate) + " where bloodlineletterid =" +
                             DbAdapter.cite(bloodlineletterid));

        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // /在交费时提交按钮的修改。
    public static void setDog(String earid,String bloodlineletterid,String ename,String cname,int sex,String color,String birthaddr,String f_bloodlineletterid,String m_bloodlineletterid,String proveNum,int itp,String inbreeding,Date birthdate) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("update csvdog set earid=" + DbAdapter.cite(earid) + ",bloodlineletterid=" + DbAdapter.cite(bloodlineletterid) + ",ename=" + DbAdapter.cite(ename) + ",cname=" + DbAdapter.cite(cname) + ",sex=" + sex + ",color=" + DbAdapter.cite(color) + ",birthaddr=" + DbAdapter.cite(birthaddr) + ",f_bloodlineletterid=" + DbAdapter.cite(f_bloodlineletterid) + ",m_bloodlineletterid=" + DbAdapter.cite(m_bloodlineletterid) + ", proveNum=" + DbAdapter.cite(proveNum) + ", itp=" + itp + ", inbreeding=" + DbAdapter.cite(inbreeding) + ",birthdate="
                             + DbAdapter.cite(birthdate) + " where earid =" + DbAdapter.cite(earid) + "");

        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }

    }

    // 2.插入狗的临时表earid,bloodlineletterid,cname,sex,color,birthaddr,f_bloodlineletterid,m_bloodlineletterid, proveNum, itp, inbreeding
    public static void createDogTemp(String earid,String bloodlineletterid,String cname,int sex,String color,String birthaddr,String f_bloodlineletterid,String m_bloodlineletterid,String proveNum,int itp,String inbreeding,Date birthdate) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into csvdogtemp (earid,bloodlineletterid,cname,sex,color,birthaddr,f_bloodlineletterid,m_bloodlineletterid, proveNum, itp, inbreeding,birthdate) values (" + DbAdapter.cite(earid) + "," + DbAdapter.cite(bloodlineletterid) + "," + DbAdapter.cite(cname) + "," + sex + "," + DbAdapter.cite(color) + "," + DbAdapter.cite(birthaddr) + "," + DbAdapter.cite(f_bloodlineletterid) + "," + DbAdapter.cite(m_bloodlineletterid) + "," + DbAdapter.cite(proveNum) + "," + itp + "," + DbAdapter.cite(inbreeding) + "," + DbAdapter.cite(birthdate)
                             + ")");
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // 删除dog临时表中的信息。

    public static void deletedogtemp(String proveNum) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete csvdog where proveNum = " + DbAdapter.cite(proveNum));
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // /
    public static void deletetemp(String proveNum) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete csvdogtemp where proveNum = " + DbAdapter.cite(proveNum));
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // 根据判断显示出临时表中所对应的数值，
    public static int getearidtemp(String bb) throws SQLException
    {
        int sun = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select count(earid) from Csvdogtemp where itp = 1");
            if(db.next())
            {
                sun = db.getInt(1);
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
        return sun;
    }

    // /通过配犬证明判断csvdog表中是否 已经有数据了
    public static boolean altprove(String earid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select proveNum from csvdog where earid = " + DbAdapter.cite(earid));
            if(db.next())
            {
                return true;
            } else
            {
                return false;
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // /标识耳号已经交费 0 或 空标识没有交费，1标识交费了的
    public static void setEarid(String earid,String cname,String ename,String color) throws SQLException
    {
        // 标识耳号已经交费 0 或 空标识没有交费，1标识交费了的 ite
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update csvdog set ite = 1 ,cname = " + DbAdapter.cite(cname) + ",ename=" + DbAdapter.cite(ename) + ",color=" + DbAdapter.cite(color) + "  where earid =" + DbAdapter.cite(earid));
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // /标识耳号已经交费 0 或 空标识没有交费，1标识交费了的
    public static void setEaridj(String earid) throws SQLException
    {
        // 标识耳号已经交费 0 或 空标识没有交费，1标识交费了的 ite
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update csvdog set ite = 1 where earid =" + DbAdapter.cite(earid));
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // 标识血统证书已经缴费 0 或 空标识没有交费，1标识交费了的
    public static void setBlood(String blood) throws SQLException
    {
        // 标识耳号已经交费 0 或 空标识没有交费，1标识交费了的 ite
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update csvdog set itb = 1 where bloodlineletterid =" + DbAdapter.cite(blood));
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    public static boolean getfalg(String earid) throws SQLException
    {
        boolean falg = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select earid from Csvdog where earid =" + DbAdapter.cite(earid));
            if(db.next())
            {
                return true;
            } else
            {
                return false;
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }

    }

    // 判断 耳号 血统号 用户名 是否符合
    public static boolean Option(String earid,String blood,String member) throws SQLException
    {
        boolean falg = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select earid from Csvdog where earid =" + DbAdapter.cite(earid) + "  and bloodlineletterid = " + DbAdapter.cite(blood) + " and member = " + DbAdapter.cite(member));
            if(db.next())
            {
                return falg = true;
            } else
            {
                return falg = false;
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // 到等级耳号刺青页面必须先清除原有对应配犬证明中的犬只
    public static void getOptionprove(String provenum) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete Csvdog where proveNum=" + DbAdapter.cite(provenum));
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // 根据配犬证明号取得出生日期
    public static Date getBirtime(String proveNum) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select birthdate from csvdog where proveNum=" + DbAdapter.cite(proveNum));
            if(db.next())
            {
                return db.getDate(1);
            } else
            {
                return null;
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // 简单的耳号记录
    public static void creatTemp(String earid,String proveNum,String cname,String ename,String color) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Csvdogtemp (earid ,provenum,cname,ename,color) values(" + DbAdapter.cite(earid) + "," + DbAdapter.cite(proveNum) + "," + DbAdapter.cite(cname) + "," + DbAdapter.cite(ename) + "," + DbAdapter.cite(color) + ")");
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // //临时表
    public static java.util.Enumeration findTempdog(String community,String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT earid FROM CsvdogTemp where " + sql);
            while(db.next())
            {
                vector.addElement(String.valueOf(db.getString(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static String[][] fiveblood(String blood) throws SQLException
    {
        String matrix[][] = new String[16][2]; // 这里是声明数组
        matrix[0][0] = blood;
        DbAdapter db = new DbAdapter();
        try
        {
            for(int i = 0;i < 8;i++)
            {
                for(int j = 0;j < 2;j++)
                {
                    if(i == 0)
                    {
                        matrix[i + 1][0] = Csvdog.Fbackblood(matrix[0][0]);
                        matrix[i + 1][i + 1] = Csvdog.Mbackblood(matrix[0][0]);
                    }
                    if(j == 0 && i != 0)
                    {
                        matrix[i * 2][0] = Csvdog.Fbackblood(matrix[i][j]);
                        matrix[i * 2][j + 1] = Csvdog.Mbackblood(matrix[i][j]);
                    }
                    if(j == 1 && i != 0)
                    {
                        matrix[i * 2 + 1][0] = Csvdog.Fbackblood(matrix[i][j]);
                        matrix[i * 2 + 1][j] = Csvdog.Mbackblood(matrix[i][j]);
                    }
                }
            }
        } finally
        {
            db.close();
        }
        return matrix;
    }

    public static String Fbackblood(String blood) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select f_bloodlineletterid from csvdog where bloodlineletterid= " + DbAdapter.cite(blood));
            if(db.next())
            {
                db.getString(1);
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
        return "";
    }

    public static String Mbackblood(String blood) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select m_bloodlineletterid from csvdog where bloodlineletterid= " + DbAdapter.cite(blood));
            if(db.next())
            {
                return db.getString(1);
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
        return "";
    }

    // 查询犬的五代
    public static Enumeration findSons(String bool,int pos,int pageSize) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT f_bloodlineletterid " + getSonsSql(bool));
            for(int l = 0;l < pos + pageSize && db.next();l++)
            {
                if(l >= pos)
                {
                    vector.addElement(String.valueOf(db.getString(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration findSons_M(String bool,int pos,int pageSize) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT M_bloodlineletterid " + getSonsSql(bool));

            for(int l = 0;l < pos + pageSize && db.next();l++)
            {
                if(l >= pos)
                {
                    vector.addElement(String.valueOf(db.getString(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    private static String getSonsSql(String bool) throws SQLException
    {
        StringBuilder sb = new StringBuilder(" FROM Csvdog    ");

        sb.append(" WHERE  bloodlineletterid=" + DbAdapter.cite(bool));

        // sb.append(" WHERE m_bloodlineletterid="+DbAdapter.cite(bool));

        return sb.toString();
    }

    // 修改 是否是禁止繁殖
    public static void updatestop(String earid,int stop) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvdog set breedstop =" + stop + " where earid =" + DbAdapter.cite(earid));
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }

    }

    // 修改DNA
    public static void updateDNA(String earid,String DNA) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Csvdog set DNA=" + DbAdapter.cite(DNA) + "  where earid =" + DbAdapter.cite(earid));

        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    // /bloodlineletterid如英文名一样,血统号一样,耳号一样,血统号和国外号,旧号一样时old_bloodlineletterid; // 旧血统证书号 foreignloginletterid; // 国外登记证书号
    public static int AddOption(String blood,String earid,String ename) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        DbAdapter db3 = new DbAdapter();
        DbAdapter db4 = new DbAdapter();

        try
        {
            db.executeQuery("select bloodlineletterid from Csvdog where  bloodlineletterid=" + DbAdapter.cite(blood));
            if(db.next())
            {
                return 1;
            }
            db2.executeQuery("select bloodlineletterid from Csvdog where old_bloodlineletterid =" + DbAdapter.cite(blood));
            if(db2.next())
            {
                return 2;
            }
            db3.executeQuery("select bloodlineletterid from Csvdog where  foreignloginletterid = " + DbAdapter.cite(blood));
            if(db3.next())
            {
                return 3;
            }
            db4.executeQuery("select bloodlineletterid from Csvdog where ename = " + DbAdapter.cite(ename) + " or earid =" + DbAdapter.cite(earid));
            if(db4.next())
            {
                return 4;
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
            db2.close();
            db3.close();
            db4.close();
        }
        return 0;
    }

    public static ArrayList AddArray(String blood,String earid,String ename) throws SQLException
    {

        ArrayList ary = new ArrayList(2);

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select bloodlineletterid from Csvdog where  bloodlineletterid=" + DbAdapter.cite(blood));
            if(db.next())
            {
                ary.add(0,"1");
                ary.add(1,db.getString(1));
                return ary;
            }
            db.executeQuery("select bloodlineletterid from Csvdog where old_bloodlineletterid =" + DbAdapter.cite(blood));
            if(db.next())
            {
                ary.add(0,"2");
                ary.add(1,db.getString(1));
                return ary;
            }
            db.executeQuery("select bloodlineletterid from Csvdog where  foreignloginletterid = " + DbAdapter.cite(blood));
            if(db.next())
            {
                ary.add(0,"3");
                ary.add(1,db.getString(1));
                return ary;
            }
            db.executeQuery("select bloodlineletterid from Csvdog where ename = " + DbAdapter.cite(ename) + " or earid =" + DbAdapter.cite(earid));
            if(db.next())
            {
                ary.add(0,"4");
                ary.add(1,db.getString(1));
                return ary;
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
        ary.add(0,"0");
        return ary;
    }


    // /bloodlineletterid如英文名一样,血统号一样,耳号一样,血统号和国外号,旧号一样时old_bloodlineletterid; // 旧血统证书号 foreignloginletterid; // 国外登记证书号
    public static String AddbloodOption(String blood) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select bloodlineletterid from Csvdog where  bloodlineletterid=" + DbAdapter.cite(blood) + " or old_bloodlineletterid =" + DbAdapter.cite(blood) + " or foreignloginletterid = " + DbAdapter.cite(blood));
            if(db.next())
            {
                return db.getString(1);
            } else
            {
                return null;
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    //查找同胎犬只
    public static java.util.Enumeration findTempByProve(String community,String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT bloodlineletterid FROM Csvdog where " + sql);

            while(db.next())
            {
                vector.addElement(String.valueOf(db.getString(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    //查找同胎犬只  新方法
    public static java.util.Enumeration findTempByProvenew(String community,String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ename FROM Csvdog where " + sql);
            while(db.next())
            {
                vector.addElement(String.valueOf(db.getString(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static String proveDogshow(String provenum,String enames) throws SQLException
    {
        StringBuilder strs = new StringBuilder();
        if(provenum != null && provenum.length() > 0)
        {
            java.util.Enumeration enumer = Csvdog.findTempByProvenew(""," provenum =" + DbAdapter.cite(provenum));
            if(!enumer.hasMoreElements())
            {

            }
            for(int index = 1;enumer.hasMoreElements();index++)
            {
                String ename = enumer.nextElement().toString();
                if(enames.equals(ename))
                {

                } else
                {
                    if(index % 3 == 0)
                    {
                        strs.append("<br>");
                    }
                    if(ename != null)
                    {
                        String strsx[] = ename.split(" ");
                        strs.append(strsx[0]);
                        strs.append(" /");
                    }
                }
            }
        } else
        {
            return "";

        }
        return strs.toString();
    }


    /*******性别判断，判断血统证书号和输入的性别是否吻合2007 11-21*******/
    public static boolean Optionsex(String blood,int sex) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(" select earid from Csvdog where bloodlineletterid =" + DbAdapter.cite(blood) + "and sex =" + sex);
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

    public static String AddenameOption(String ename,String earid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {

            if(db.next())
            {
                return db.getString(1);
            } else
            {
                return null;
            }
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

////////修改配犬证明对应的状态
    public static void provestatic(String provenum,int bloodtype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update csvdog set ite=0 , itb=0, lettertype=" + bloodtype + " where provenum=" + db.cite(provenum));
        } finally
        {
            db.close();
        }
    }


    public static java.util.Enumeration AddenameOption(String community,String sql,int pos,int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select bloodlineletterid from Csvdog where community=" + DbAdapter.cite(community) + sql,pos,size);
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

    ///犬只祖籍
    public String getTreeToHtml(int count,int type) throws SQLException
    {
        StringBuilder h = new StringBuilder();
        tree5(this,count,0,type,h);
        return h.toString();
    }

    private void tree5(Csvdog cd,int count,int setp,int type,StringBuilder h) throws SQLException
    {
        String f = null,m = null;
        Csvdog cd_f = null,cd_m = null;
        if(cd != null && cd.isExists())
        {
            f = cd.getF_bloodlineletterid();
            m = cd.getM_bloodlineletterid();

            if(f != null)
            {
                cd_f = Csvdog.find_blood(f,"");
            }
            if(m != null)
            {
                cd_m = Csvdog.find_blood(m,"");
            }
        }
        //System.out.println(f+","+m+":"+setp);
        int row = (int) Math.pow(2,count - 1);
        row = row / (int) Math.pow(2,setp);
        setp++;
        //父亲////////////////////////////////////////////////

        h.append("<td rowspan=" + row + ">");
        if(cd_f == null || !cd_f.isExists())
        {
            //  out.write("暂无信息");
            h.append("暂无信息");
        } else
        {
            //out.write("<a href=/jsp/csvclub/CsvdogQueryresult_1.jsp?blood=" + f + ">" + cd_f.getEname() + "</a><br>");
            h.append("<a href=/jsp/csvclub/CsvdogQueryresult_1.jsp?blood=" + f + ">" + cd_f.getEname() + "</a><br>");
            //out.write(f);
            h.append(f);
            switch(type)
            {
            case 0:
                if(setp == 1)
                {
                    h.append("<br>英文姓名	父犬血统证书号<br>考试成绩 髋关节鉴定结果<br> 颜色及标志 DNA<br>繁育资格<br>国外登记证书号<br>裁判评价<br>同胎犬");

                }
                if(setp == 2)
                {
                    h.append("<br>英文姓名 髋关节鉴定结果 父犬血统证书号<br>比赛成绩（级别） DNA<br>考试成绩 繁殖资格<br>国外登记证书号<br>裁判评价<br>同胎犬");

                }
                if(setp == 3)
                {
                    h.append("<br>英文姓名<br>父犬血统正好<br>考试成绩 DNA<br>国外登记证书");

                }
                if(setp == 4)
                {
                    h.append("<br>英文姓名<br>父犬血统证书号<br>考试成绩");

                }
                break;
            case 1:

                break;
            case 2:

                break;
            case 3:
                break;

            case 4:

                break;
            }

        }
        h.append("</td>");
        if(setp < count)
        {
            tree5(cd_f,count,setp,type,h);
        } else
        {

            h.append("</tr><tr>");
        }

        //母亲////////////////////////////////////////////////
        h.append("<td rowspan=" + row + ">");
        if(cd_m == null || !cd_m.isExists())
        {

            h.append("暂无信息");
        } else
        {
            h.append("<a href=/jsp/csvclub/CsvdogQueryresult_1.jsp?blood=" + m + ">" + cd_m.getEname() + "</a><br>");
            h.append(m);
            switch(type)
            {
            case 0:
                if(setp == 1)
                {
                    h.append("<br>英文姓名 父犬血统证书号<br>考试成绩 髋关节鉴定结果<br> 颜色及标志 DNA<br>繁育资格<br>国外登记证书号<br>裁判评价<br>同胎犬");

                }
                if(setp == 2)
                {
                    h.append("<br>英文姓名 髋关节鉴定结果 父犬血统证书号<br>比赛成绩（级别） DNA<br>考试成绩 繁殖资格<br>国外登记证书号<br>裁判评价<br>同胎犬");

                }
                if(setp == 3)
                {
                    h.append("<br>英文姓名<br>父犬血统正好<br>考试成绩 DNA<br>国外登记证书");

                }
                if(setp == 4)
                {
                    h.append("<br>英文姓名<br>父犬血统证书号<br>考试成绩");

                }
                break;
            case 1:

                break;
            case 2:

                break;
            case 3:
                break;

            case 4:

                break;
            }
        }
        h.append("</td>");
        if(setp < count)
        {
            tree5(cd_m,count,setp,type,h);
        } else
        {
            h.append("</tr><tr>");
        }
    }


    public static boolean option_blood_earid(String blood,String earid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select * from Csvdog where bloodlineletterid = " + db.cite(blood) + " and earid = " + db.cite(earid));
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

    public int getIte()
    {
        return ite;
    }

    public int getItb()
    {
        return itb;
    }

    public String getProve()
    {
        return provenum;
    }

    public int getItp()
    {
        return itp;
    }

    public String getBirthaddr()
    {
        return birthaddr;
    }

    public int getItforeign()
    {
        return itforeign;
    }

    public int getBloodtype()
    {
        return bloodtype;
    }

    public int getId()
    {
        return id;
    }

    public String getBloodlineletterid()
    {
        return bloodlineletterid;
    }

    public String getDoghost()
    {
        return doghost;
    }

    public String getEname()
    {
        return ename;
    }

    public String getCname()
    {
        return cname;
    }

    public Date getDirthdate()
    {
        return birthdate;
    }

    public String getDirthdateToString()
    {
        if(birthdate == null)
        {
            return "";
        }
        return sdf.format(birthdate);
    }

    public int getSex()
    {
        return sex;
    }

    public String getEarid()
    {
        return earid;
    }

    public String getHair()
    {
        return hair;
    }

    public String getColor()
    {
        return color;
    }

    public String getSpecialmark()
    {
        return specialmark;
    }

    public String getHipcheck()
    {
        return hipcheck;
    }

    public String getElbowcheck()
    {
        return elbowcheck;
    }

    public String getDNA()
    {
        return DNA;
    }

    public String getPropagatetitle()
    {
        return propagatetitle;
    }

    public String getPropagatetitleShownew()
    {
        String strint = null;
        String strk = null;
        String strj = null;

        if(propagatetitle != null && propagatetitle.length() > 0)
        {
            strint = propagatetitle;
            if("1".equals(strint))
            {
                return "*Lebenszeit";
            } else if("2".equals(strint))
            {
                if(provedatek != null && provedatek.length() > 0)
                {
                    strk = provedatek.substring(0,4);
                }
                if(provedatej != null && provedatej.length() > 0)
                {
                    strj = provedatej.substring(2,4);
                }

                return "*" + strk + "-" + strj;
            } else
            {
                return "";
            }
        } else
        {
            return "";
        }
    }


    public String getPropagatetitleShow()
    {
        String strint = null;

        if(propagatetitle != null && propagatetitle.length() > 0)
        {
            strint = propagatetitle;
            if("1".equals(strint))
            {
                return "*Lebenszeit";
            } else if("2".equals(strint))
            {

                return provedatej.substring(0,10);
            } else
            {
                return "";
            }
        } else
        {
            return "";
        }
    }

    /************************
     * 判断繁育证书
     * ***/
    public String getPropagatetitleShowFalg()
    {
        String strint = null;
        Date dates = new Date();
        Date datej = null;
        if(propagatetitle != null && propagatetitle.length() > 0)
        {
            strint = propagatetitle;
            if("1".equals(strint))
            {
                return "1";
            } else if("2".equals(strint))
            {
                try
                {
                    datej = Csvdog.sdf.parse(provedatej);
                } catch(ParseException ex)
                {

                }
                if(dates.compareTo(datej) > 0)
                {
                    return "0"; ///不符合
                } else
                {
                    return "1"; //符合
                }
            } else
            {
                return "0"; ///不符合
            }
        } else
        {
            return "0"; ///不符合
        }
    }

    public String getInbreeding()
    {
        return inbreeding;
    }

    public String getFileid()
    {
        return fileid;
    }

    public String getGamerank()
    {
        return gamerank;
    }

    public String getGamegrade()
    {
        return gamegrade;
    }

    public String getExamrank()
    {
        return examrank;
    }

    public String getExamgrade()
    {
        return examgrade;
    }

    public String getF_bloodlineletterid()
    {
        return f_bloodlineletterid;
    }

    public String getM_bloodlineletterid()
    {
        return m_bloodlineletterid;
    }

    public String getFm_matingproveid()
    {
        return fm_matingproveid;
    }

    public String getOld_bloodlineletterid()
    {
        return old_bloodlineletterid;
    }

    public String getForeignloginletterid()
    {
        return foreignloginletterid;
    }

    public String getLettertype()
    {
        return lettertype;
    }

    public String getUmpirevalue()
    {
        return umpirevalue;
    }

    public String getMark()
    {
        return mark;
    }

    public String getInbreedingprint()
    {
        return inbreedingprint;
    }

    public Date getAddtime()
    {
        return addtime;
    }

    public String getAddtimeToString()
    {
        if(addtime == null)
        {
            return "";
        }
        return sdf.format(addtime);
    }

    public Date getUpdatetime()
    {
        return updatetime;
    }

    public String getUpdatetimeToString()
    {
        if(updatetime == null)
        {
            return "";
        }
        return sdf.format(updatetime);
    }

    public String getF_dogname()
    {
        return f_dogname;
    }

    public String getM_dogname()
    {
        return m_dogname;
    }

    public String getF_hipcheck()
    {
        return f_hipcheck;
    }

    public String getM_hipcheck()
    {
        return m_hipcheck;
    }

    public String getPropagatevaluenew()
    {
        return propagatevaluenew;
    }

    public String getPropagatevalueold()
    {
        return propagatevalueold;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getMember()
    {
        return member;
    }

    public int getCity()
    {
        return city;
    }

    public int getNum()
    {
        return num;
    }

    public Date getBirthdate()
    {
        return birthdate;
    }

    public String getBirthdateToString()
    {
        if(birthdate == null)
        {
            return "";
        }
        return Csvdog.sdf.format(birthdate);
    }


    public String getPic()
    {
        return pic;
    }

    public String getProvenum()
    {
        return provenum;
    }

    public String getRemark()
    {
        return remark;
    }

    public int getBreedstop()
    {
        return breedstop;
    }

    public String getLinshihost()
    {
        return linshihost;
    }

    public String getBreedpeople()
    {
        return breedpeople;
    }

    public String getBreedaddr()
    {
        return breedaddr;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getProvedatej()
    {
        return provedatej;
    }

    public String getProvedatek()
    {
        return provedatek;
    }

    public int getSchh1()
    {
        return schh1;
    }

    public int getKoerung()
    {
        return koerung;
    }

    public String getProvebtnum()
    {
        return provebtnum;
    }

    public int getDogstatic()
    {
        return dogstatic;
    }

    /////////////////////3-10 关于近亲血系的判断
    public static boolean isInbreeding(String blood,String inbreeds) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        boolean falg = false;

        try
        {
            db.executeQuery("select inbreeding from csvdog where bloodlineletterid = " + DbAdapter.cite(blood));
            if(db.next())
            {
                String str = db.getString(1);
                if(str != null && str.length() > 0)
                {
                    return true;
                } else
                {
                    return false;
                }

            } else
            {
                return false;
            }

        } finally
        {
            db.close();
        }
    }

    public void setInbreeding(String inbreeds) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update csvdog set  inbreeding = " + DbAdapter.cite(inbreeds) + " where bloodlineletterid = " + DbAdapter.cite(bloodlineletterid));
        } finally
        {
            db.close();
        }

    }

    //修改打印状态
    public static void optionprint(String blood,int itp) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date dates = new Date(); ///添加时间
        try
        {
            db.executeUpdate("update csvdog set addtime=" + db.cite(dates) + ",ite=1,itb=1,itp =" + itp + " where bloodlineletterid=" + db.cite(blood));
        } finally
        {
            db.close();
        }
    }

    // /自动生成耳号，
    public static String getMarkearid(int city,int num) throws SQLException
    {
        String str = null;
        String mark = null;
        String max = null;
        char seqs;
        String seqh = null;
        String seqt = null;
        char B;
        int a = 0;
        int xmax = 0;
        SeqTable seqtable = new SeqTable();
        str = Common.CSVDMCITYS[city][1].toString();

        mark = "C" + str;

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select max(earid) from csvdog where earid like " + DbAdapter.cite("%" + mark + "%"));
            if(db.next())
            {
                max = db.getString(1);
            }
            if(max != null && max.length() > 0)
            {
                seqs = max.charAt(2);
                seqh = max.substring(3);

                xmax = Integer.parseInt(seqh) + num;

                if(xmax > 9999)
                {
                    // a = Integer.parseInt(seqs);
                    B = (char) (seqs + 1);
                  //  mark = mark + B + seqtable.df4.format(Integer.parseInt(seqh) + num - 9999);
                    ;
                } else
                {
                   // mark = mark + seqs + seqtable.df4.format(Integer.parseInt(seqh) + num);
                }
            } else
            {
              //  mark = mark + "A" + seqtable.df4.format(num);

            }
            return mark;
        } catch(Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            db.close();
        }
    }

    /************************
     * 耳号自动生成
     ************************/
    public static String getMarkearid_new(int city) throws SQLException
    {
        String str = null;
        String min = null;
        String mark = null;
        str = Common.CSVDMCITYS[city][1].toString();
        mark = "C" + str;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select min(earid) from earlib where earid like " + DbAdapter.cite("%" + mark + "%"));
            if(db.next())
            {
                min = db.getString(1);
            }
            db.executeUpdate("delete earlib where earid=" + db.cite(min));
        } finally
        {
            db.close();
        }
        return min;
    }

//    public static String getMarkname_new(int num) throws SQLException
//    {
//
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            db.executeQuery("select min(earid) from earlib where earid like " + DbAdapter.cite("%" + mark + "%"));
//            if (db.next())
//            {
//                min = db.getString(1);
//            }
//            db.executeUpdate("delete earlib where earid="+db.cite(min));
//        } finally
//        {
//            db.close();
//        }
//    }
    //2008年6月10日11:24:24
    public static int falgCsvbloodtype(String bloodf,String bloodm,int datef,int datem,String near) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int type = 6;

        String hipidf = null;
        String hipidm = null;
        String elbowf = null;
        String elbowm = null;

        String DNAf = null;
        String DNAm = null;

        String runf = null;
        String runm = null;
        try
        {
            //a1,a2,a3,a4,a5,a6,
            //ED1,ED2,ED3,ED4,ED5,ED6,
            Csvdog dogf = Csvdog.find_blood(bloodf,"");
            hipidf = dogf.getHipcheck();
            elbowf = dogf.getElbowcheck();
            DNAf = dogf.getDNA();
            runf = dogf.getGamegrade();

            Csvdog dogm = Csvdog.find_blood(bloodm,"");
            hipidm = dogm.getHipcheck();
            elbowm = dogm.getElbowcheck();
            DNAm = dogm.getDNA();
            runm = dogm.getGamegrade();

            Csvdogcheck cf = Csvdogcheck.find_blood(bloodf);
            Csvdogover dogoverf = Csvdogover.find(cf.getHipid());
            //csvelbows,csvovers
            Csvdogcheck cm = Csvdogcheck.find_blood(bloodm);
            Csvdogover dogoverm = Csvdogover.find(cm.getHipid());

            if(near.equals("是"))
            {
                type = 5;
            }
            if(datef < 24 || datem < 20)
            {
                type = 4;
            }
            if((hipidf != null && hipidf.length() > 0) && (elbowf != null && elbowf.length() > 0) && (hipidm != null && hipidm.length() > 0) && (elbowm != null && elbowm.length() > 0))
            {
                if(hipidf.equals("a5") || hipidm.equals("a5") || elbowf.equals("ED4") || elbowf.equals("ED5") || elbowm.equals("ED4") || elbowm.equals("ED5"))
                {
                    type = 2;
                }
            } else
            {
                if((DNAf != null && DNAf.length() > 0) && (DNAm != null && DNAm.length() > 0) && (runf != null && runf.length() > 0) && (runm != null && runm.length() > 0) && (dogoverf.isExists() || dogoverm.isExists()))
                {
                    type = 3;
                } else
                {
                    type = 1;
                }
            }
        } finally
        {
            db.close();
        }
        return type;
    }

    /*
     2008年6月25日15:10:48 添加编辑犬舍信息
     */
    public void setMark(String mark) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update csvdog set mark=" + db.cite(mark) + " where member=" + member);
        } finally
        {
            db.close();
        }

    }

    /********
     * 2008年7月9日14:53:58 添加繁育证书的判断
     *
     * */
    public static String getblood3(String blood,String earid) throws SQLException
    {
        String str = "";
        DbAdapter db = new DbAdapter();
        try
        {
            if(blood != null && earid != null)
            {
                db.executeQuery("select bloodlineletterid from  csvdog where bloodlineletterid=" + db.cite(blood) + " or earid=" + db.cite(earid));
                if(db.next())
                {
                    str = db.getString(1);
                }

            } else if(blood != null)
            {
                db.executeQuery("select bloodlineletterid from  csvdog where bloodlineletterid=" + db.cite(blood));
                if(db.next())
                {
                    str = db.getString(1);
                }

            }

        } finally
        {
            db.close();
        }
        return str;
    }
}
