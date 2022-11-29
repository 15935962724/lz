package tea.entity.csvclub.testing;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Csvdogchecktesting extends Entity
{
    public static Cache _cache = new Cache(100);

    private String idnum;

    private String boolid; //

    private String earid; //

    private String hipid; //

    private String DNAid; //

    private String breedtime; // 繁育期限

    private String breedlevel; // 繁育级别

    private String promotion; // 晋级

    private String finallylevel; // 最终级别

    private String trainsc; // 训练成绩

    private String updatadoghost; // 变更犬主姓名

    private String shoulder; // 肩高

    private String chestlong; // 胸长

    private String chestall; // 胸围

    private String heavry; // 重量

    private int weight; // 色素沉淀

    private int exceedinglength; // 毛长

    private int testicle; // /睾丸

    private String overall; // 总体评价

    private int vein; // 性情

    private int attention; // 注意力

    private int neural; // 神经类型

    private int natural; // 自然程度

    private int guns; // 枪声测试情况

    private String TSB; // TSB结果

    private int sexcharacter; // 性别特征

    private int build; // 体格

    private int expressiveforce; // 表现力

    private int trunk; // 躯干情况

    private int posteriorlimb; // 后肢

    private int back; // 背部

    private int elbowjoint; // 肘关节连接

    private int hindfoot; // 前足跖强度

    private int face; // 正面

    private int crossbone; // 十字骨

    private int osteoarthrosis; // 距骨关节强度

    private int walking; // 步态

    private int walkongfrist; // 步幅前展

    private int walkingpedals; // 步幅后蹬

    private int claw; // 爪

    private int toe; // 趾

    private int head; // 头部

    private int eyecolor; // 眼睛颜色

    private int maxilla; // 上颚

    private int chin; // 下颚

    private int tooth; // 牙齿

    private int toothdefect; // 牙齿缺陷

    private String itemgood; // 其它优缺点

    private String notion; // 意见

    private String breedexamaddrid; // 繁育考试地区编号

    private String breedexamaddress; // 繁育考试地点

    private String breedexamdate; // 繁育考试日期

    private String breedexammajordomo; // 繁育考试总监

    private int breedexamid; // 繁育编号

    private Date addtime; // 添加日期

    private Date updatetime; // 修改日期

    private String community;

    private int appetence; // 本能、自信和承受力

    private int muscle; // 肌肉

    private int bones; // 骨骼

    private int forelimb; // 前肢

    private String dogcolor; // 犬的颜色

    private String DNAtime; // 提取DNA时间

    private int X_ray; // X光片类型编号

    public Csvdogchecktesting(String earid) throws SQLException
    {
        this.earid = earid;
        load();
    }

    public static Csvdogchecktesting find(String earid) throws SQLException
    {
        return new Csvdogchecktesting(earid);
    }

    //以耳号做主键的 查询
    private void load() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter
                .executeQuery("select idnum,boolid,earid,hipid,DNAid,breedtime,breedlevel,promotion,finallylevel,trainsc,updatadoghost,shoulder,chestlong,chestall,heavry,weight,exceedinglength,testicle,overall ,vein,attention,neural,natural ,guns ,TSB,sexcharacter,build,expressiveforce,trunk,posteriorlimb,back,elbowjoint,hindfoot ,face,crossbone,osteoarthrosis ,walking,walkongfrist,walkingpedals,claw,toe,head,eyecolor,maxilla,chin,tooth,toothdefect,itemgood,notion,breedexamaddrid,breedexamaddress,breedexamdate,breedexammajordomo,breedexamid,addtime,[updatetime],community,appetence,muscle,bones,forelimb,dogcolor,X_ray from Csvdogcheck where earid=" +
                              dbadapter.cite(earid));
            if (dbadapter.next())
            {
                idnum = dbadapter.getString(1);
                boolid = dbadapter.getString(2); //
                earid = dbadapter.getString(3); //
                hipid = dbadapter.getString(4); //
                DNAid = dbadapter.getString(5); //
                breedtime = dbadapter.getString(6); // 繁育期限
                breedlevel = dbadapter.getString(7); // 繁育级别
                promotion = dbadapter.getString(8); // 晋级
                finallylevel = dbadapter.getString(9); // 最终级别
                trainsc = dbadapter.getString(10); // 训练成绩
                updatadoghost = dbadapter.getString(11); // 变更犬主姓名
                shoulder = dbadapter.getString(12); // 肩高
                chestlong = dbadapter.getString(13); // 胸长
                chestall = dbadapter.getString(14); // 胸围
                heavry = dbadapter.getString(15); // 重量
                weight = dbadapter.getInt(16); // 色素沉淀
                exceedinglength = dbadapter.getInt(17); // 毛长
                testicle = dbadapter.getInt(18); // /睾丸
                overall = dbadapter.getString(19); // 总体评价
                vein = dbadapter.getInt(20); // 性情
                attention = dbadapter.getInt(21); // 注意力
                neural = dbadapter.getInt(22); // 神经类型
                natural = dbadapter.getInt(23); // 自然程度
                guns = dbadapter.getInt(24); // 枪声测试情况
                TSB = dbadapter.getString(25); // TSB结果
                sexcharacter = dbadapter.getInt(26); // 性别特征
                build = dbadapter.getInt(27); // 体格
                expressiveforce = dbadapter.getInt(28); // 表现力
                trunk = dbadapter.getInt(29); // 躯干情况
                posteriorlimb = dbadapter.getInt(30); // 后肢
                back = dbadapter.getInt(31); // 背部
                elbowjoint = dbadapter.getInt(32); // 肘关节连接
                hindfoot = dbadapter.getInt(33); // 前足跖强度
                face = dbadapter.getInt(34); // 正面
                crossbone = dbadapter.getInt(35); // 十字骨
                osteoarthrosis = dbadapter.getInt(36); // 距骨关节强度
                walking = dbadapter.getInt(37); // 步态
                walkongfrist = dbadapter.getInt(38); // 步幅前展
                walkingpedals = dbadapter.getInt(39); // 步幅后蹬
                claw = dbadapter.getInt(40); // 爪
                toe = dbadapter.getInt(41); // 趾
                head = dbadapter.getInt(42); // 头部
                eyecolor = dbadapter.getInt(43); // 眼睛颜色
                maxilla = dbadapter.getInt(44); // 上颚
                chin = dbadapter.getInt(45); // 下颚
                tooth = dbadapter.getInt(46); // 牙齿
                toothdefect = dbadapter.getInt(47); // 牙齿缺陷
                itemgood = dbadapter.getString(48); // 其它优缺点
                notion = dbadapter.getString(49); // 意见
                breedexamaddrid = dbadapter.getString(50); // 繁育考试地区编号
                breedexamaddress = dbadapter.getString(51); // 繁育考试地点
                breedexamdate = dbadapter.getString(52); // 繁育考试日期
                breedexammajordomo = dbadapter.getString(53); // 繁育考试总监
                breedexamid = dbadapter.getInt(54); // 繁育考试编号
                addtime = dbadapter.getDate(55); // 添加日期
                updatetime = dbadapter.getDate(56); // 修改日期
                community = dbadapter.getString(57); // 社区
                appetence = dbadapter.getInt(58); // 本能、自信和承受力、
                muscle = dbadapter.getInt(59); // 肌肉
                bones = dbadapter.getInt(60); // [骨骼]
                forelimb = dbadapter.getInt(61); // 前肢
                dogcolor = dbadapter.getString(62); // 犬的颜色
                X_ray = dbadapter.getInt(63); //光片备注
            }
        } finally
        {
            dbadapter.close();
        }
    }

    public Date getAdddatetime()
    {
        return addtime;

    }

    public String getAdddatetimeToString()
    {
        if (addtime == null)
            return "";
        return sdf.format(addtime);
    }

    public int getAttention()
    {
        return attention;
    }

    public int getBack()
    {
        return back;
    }

    public String getBoolid()
    {
        return boolid;
    }

    public String getBreedexamaddress()
    {
        return breedexamaddress;
    }

    public String getBreedexamaddrid()
    {
        return breedexamaddrid;
    }

    public String getBreedexamdate()
    {
        return breedexamdate;
    }

    public int getBreedexamid()
    {
        return breedexamid;
    }

    public String getBreedexammajordomo()
    {
        return breedexammajordomo;
    }

    public String getBreedlevel()
    {
        return breedlevel;
    }

    public String getBreedtime()
    {
        return breedtime;
    }

    public int getBuild()
    {
        return build;
    }

    public String getChestall()
    {
        return chestall;
    }

    public String getChestlong()
    {
        return chestlong;
    }

    public int getChin()
    {
        return chin;
    }

    public int getClaw()
    {
        return claw;
    }

    public int getCrossbone()
    {
        return crossbone;
    }

    public String getDNAid()
    {
        return DNAid;
    }

    public String getEarid()
    {
        return earid;
    }

    public int getElbowjoint()
    {
        return elbowjoint;
    }

    public int getExceedinglength()
    {
        return exceedinglength;
    }

    public int getExpressiveforce()
    {
        return expressiveforce;
    }

    public int getEyecolor()
    {
        return eyecolor;
    }

    public int getFace()
    {
        return face;
    }

    public String getFinallylevel()
    {
        return finallylevel;
    }

    public int getGuns()
    {
        return guns;
    }

    public int getHead()
    {
        return head;
    }

    public String getHeavry()
    {
        return heavry;
    }

    public int getHindfoot()
    {
        return hindfoot;
    }

    public String getHipid()
    {
        return hipid;
    }

    public String getIdnum()
    {
        return idnum;
    }

    public String getItemgood()
    {
        return itemgood;
    }

    public int getMaxilla()
    {
        return maxilla;
    }

    public int getNatural()
    {
        return natural;
    }

    public int getNeural()
    {
        return neural;
    }

    public String getNotion()
    {
        return notion;
    }

    public int getOsteoarthrosis()
    {
        return osteoarthrosis;
    }

    public String getOverall()
    {
        return overall;
    }

    public int getPosteriorlimb()
    {
        return posteriorlimb;
    }

    public String getPromotion()
    {
        return promotion;
    }

    public int getSexcharacter()
    {
        return sexcharacter;
    }

    public String getShoulder()
    {
        return shoulder;
    }

    public int getTesticle()
    {
        return testicle;
    }

    public int getToe()
    {
        return toe;
    }

    public int getTooth()
    {
        return tooth;
    }

    public int getToothdefect()
    {
        return toothdefect;
    }

    public String getTrainsc()
    {
        return trainsc;
    }

    public int getTrunk()
    {
        return trunk;
    }

    public String getTSB()
    {
        return TSB;
    }

    public String getUpdatadoghost()
    {
        return updatadoghost;
    }

    public Date getUpdatetime()
    {
        return updatetime;
    }

    public String getUpdatetimeToString()
    {
        if (updatetime == null)
            return "";
        return sdf.format(updatetime);
    }

    public int getVein()
    {
        return vein;
    }

    public int getWalking()
    {
        return walking;
    }

    public int getWalkingpedals()
    {
        return walkingpedals;
    }

    public int getWalkongfrist()
    {
        return walkongfrist;
    }

    public int getWeight()
    {
        return weight;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getAppetence()
    {
        return appetence;
    }

    public int getMuscle()
    {
        return muscle;
    }

    public int getBones()
    {
        return bones;
    }

    public int getForelimb()
    {
        return forelimb;
    }

    public String getDogcolor()
    {
        return dogcolor;
    }

    public Date getAddtime()
    {
        return addtime;
    }

    public Cache get_cache()
    {
        return _cache;
    }

    public int getX_ray()
    {
        return X_ray;
    }

    public String getDNAtime()
    {
        return DNAtime;
    }
}
