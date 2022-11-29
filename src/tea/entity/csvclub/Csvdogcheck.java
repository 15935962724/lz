package tea.entity.csvclub;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;

public class Csvdogcheck extends Entity
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
    private String testicl_str; // /睾丸
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

    private Date breedexamdate; // 繁育考试日期

    private String breedexammajordomo; // 繁育考试总监

    private int breedexamid; // 繁育编号

    private Date addtime; // 添加日期

    private Date updatetime; // 修改日期

    private String community;

    /** *** 后添加的字段8****** */
    private int appetence; // 本能、自信和承受力

    private int muscle; // 肌肉

    private int bones; // 骨骼

    private int forelimb; // 前肢

    private String dogcolor; // 犬的颜色

    private String otherdogcolor; //其他颜色

    private boolean exists; // 是否存在
    /**********************************************************************************************
     * 在后来有添加的字段DNA提取时间，光片类型。是在检测的时候 很少用到 就没有特别在建一个表。 DNAtime X_ray 字段类型
     * 以下内容 与2008-05-03修改过
     **********************************************************************************************/
    private String DNAtime; // 提取DNA时间

    private int X_ray; // X光片类型编号
    //****关于繁育证书的补充说明*****2008年03月14日*****/
    private String walking_str; // 步态
    private String crossbone_str; // 十字骨
    private String trunk_str; // 躯干情况
    private String vein_str; // 性情
    private String appetence_str; // 本能、自信和承受力
    //****关于繁育证书的补充说明*****2008年05月03日*****/
    private String caipan_name;
    private Date caipan_addtime;
    private String toothdefects; ///牙齿评价
    private String tooths; //牙齿复选
    /**
     * 2008年7月4日12:40:36 添加一个申请人字段
     * 2008年7月7日12:40:36  addmember 改变含义 现犬主信息。
     * 2008年7月7日12:40:36  updatadoghost 改变含义 申请人信息。
     * **/
    private String addmember;

    /*2008年6月16日16:48:56**/
    public static final String DOGCOLORS[] =
            {"------", "直杖毛", "绒毛略多", "略卷", "黑褐色", "狼灰色"};

    public static final String X_RAYS[] =
            {"------","新拍髋肘光片", "无血统证书", "补拍髋", "补拍肘","转发繁育证书", "转发血统证书", "申请血统补做", "重拍髋", "重拍肘", "补拍髋肘", "转发血统繁育证书", "重拍髋肘", "暂无结果"}; // 光片类型

    public static final String WEIGHTS[] =
            {"------", "素沉淀", "很好", "好", "尚可", "不合格"}; // 色素沉淀

    public static final String EXCEEDINGLENGTHS[] =
            {"------", "正常", "短", "浓密"}; // 毛长

    public static final String TESTICLES[] =
            {"------", "有力度", "发育正常", "小", "不良"}; // 睾丸

    public static final String VEINS[] =
            {"------", "稳定", "自然", "安静", "充满激情", "弱"}; // 性情

    public static final String ATTENTIONS[] =
            {"------", "优良", "合格", "弱"}; // 注意力

    public static final String NEURALS[] =
            {"------", "稳定", "易过度兴奋", "不安定"}; // 神经类型

    public static final String NATURALS[] =
            {"------", "优良", "合格"}; // 自然程度

    public static final String GUNS[] =
            {"------", "优良", "合格", "不合格"}; // 枪声测试情况

    public static final String SEXCHARACTERS[] =
            {"------", "突出", "优良", "一般", "不明显"}; // 性别特征

    public static final String BUILDS[] =
            {"------", "有力度", "中等力度", "精干", "稍粗壮", "稍纤细"}; // 体格

    public static final String EXPRESSIVEFORCES[] =
            {"------", "充满活力", "形态好", "情绪不大好", "软弱"}; // 表现力

    public static final String TRUNKS[] =
            {"------", "比例正常", "略长", "稍短", "有力度", "营养良好", "略重", "营养一般", "腹线低", "略宽", "略窄", "肋部稍扁平"}; // 躯干情况

    public static final String POSTERIORLIMBS[] =
            {"------", "出色", "良好", "一般", "弱"}; // 后肢

    public static final String BACKS[] =
            {"------", "坚实", "坚实程度尚可", "稍微有点紧", "肩胛骨后面有点凹"}; // 背部

    public static final String ELBOWJOINTS[] =
            {"------", "出色", "良好", "一般"}; // 肘关节连接

    public static final String HINDFOOTS[] =
            {"------", "良好", "一般", "软弱", "向外旋"}; // 前足跖强度----修改后的名称 ----前系强度

    public static final String FACES[] =
            {"------", "笔直", "前肢向外分开", "不够直", "肘突出有点鼓"}; // 正面

    public static final String CROSSBONES[] =
            {"------", "长度正常", "稍短", "短", "位置正常", "水平", "轻度下垂", "下垂"}; // 十字骨------------尻部

    public static final String OSTEOARTHROSIS[] =
            {"------", "良好", "一般", "不够坚实"}; // 距骨关节强度---------飞节强度

    public static final String WALKINGS[] =
            {"------", "前后直", "前后肢夹", "步幅大", "稍有点撇", "稍有点桶状腿", "有顺拐倾向"}; // 步态

    public static final String WALKONGFRISTS[] =
            {"------", "出色", "良好", "一般", "欠自如"}; // 步幅前展

    public static final String WALKINGPEDALS[] =
            {"------", "很有力", "有力", "一般", "不稳固"}; // 步幅后蹬

    public static final String CLAWS[] =
            {"------", "色暗", "中等", "浅"}; // 爪

    public static final String TOES[] =
            {"------", "前后趾圆", "前后趾稍长", "前后趾有点叉开"}; // 趾

    public static final String HEADS[] =
            {"------", "非常有力度", "有力度", "稍欠力度感", "稍窄", "稍短", "稍长"}; // 头部

    public static final String EYECOLORS[] =
            {"------", "褐色", "黄色", "浅"}; // 眼睛颜色

    public static final String MAXILLAS[] =
            {"------", "有力度", "力度一般", "稍窄"}; // 上颚

    public static final String CHINS[] =
            {"------", "有力度", "力度一般", "力度稍差"}; // 下颚

    public static final String TOOTHS[] =
            {"------", "健康", "有力度", "无缝", "咬合齐整", "稍欠力度", "部分呈黄褐色"}; // 牙齿

    public static final String TOOTHDEFECTS[] =
            {"------", "健康", "有力度", "无缝", "咬合齐整", "稍欠力度", "部分呈黄褐色", "部分牙齿间有缝隙", "中间的切齿咬合不正确", "是年龄的原因:是", "是年龄的原因:否", "咬合不正确左右两侧是否有多余的Pl牙齿:Plo.li;Plo.re",
            "咬合不正确左右两侧是否有多余的Pl牙齿:Plu.li;Plu.re"}; // 牙齿缺陷

    public static final String APPETENCES[] =
            {"------", "优秀", "优良", "口松", "口不松", "无"}; // 本能、自信和承受力

    public static final String MUSCLES[] =
            {"------", "有力度", "力度尚可", "精干", "精干程度尚可"}; // 肌肉

    public static final String BONES[] =
            {"------", "有力度", "中等力度", "精干程度尚可", "稍粗", "稍细"}; // 骨骼

    public static final String FORELIMBS[] =
            {"------", "出色", "良好", "一般", "弱"}; // 站立和韧带强度-前肢

    public static final String ED_OTHERPRICE[] =
            {"0", "10", "20", "30", "40", "50"};

    public static final String DNAS[] =
            {"---", "DNA", "DNA.c", "DNA.gpr", "DNA.cgpr"};

    public Csvdogcheck(String earid) throws SQLException
    {
        this.earid = earid;
        load();
    }

    public static Csvdogcheck find(String earid) throws SQLException
    {
        return new Csvdogcheck(earid);
    }

    public Csvdogcheck(String blood, int x) throws SQLException
    {
        this.boolid = blood;
        load_blood();
    }

    public static Csvdogcheck find_blood(String blood) throws SQLException
    {
        return new Csvdogcheck(blood, 1);
    }


    public static Csvdogcheck find2(String hipid) throws SQLException
    {
        String i = null;
        return new Csvdogcheck(hipid, i);
    }

    public Csvdogcheck(String hipid, String i) throws SQLException
    {
        this.hipid = hipid;
        loadhipid();
    }

    //以hipid为主键的查询
    private void loadhipid() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter
                    .executeQuery("select idnum,boolid,earid,hipid,DNAid,breedtime,breedlevel,promotion,finallylevel,trainsc,updatadoghost,shoulder,chestlong,chestall,heavry,weight,exceedinglength,testicle,overall ,vein,attention,neural,natural ,guns ,TSB,sexcharacter,build,expressiveforce,trunk,posteriorlimb,back,elbowjoint,hindfoot ,face,crossbone,osteoarthrosis ,walking,walkongfrist,walkingpedals,claw,toe,head,eyecolor,maxilla,chin,tooth,toothdefect,itemgood,notion,breedexamaddrid,breedexamaddress,breedexamdate,breedexammajordomo,breedexamid,addtime,[updatetime],community,appetence,muscle,bones,forelimb,dogcolor,X_ray,walking_str,  crossbone_str,  trunk_str,  vein_str,  appetence_str,caipan_name,caipan_addtime,toothdefects,tooths ,testicl_str,otherdogcolor,addmember  from Csvdogcheck where hipid="
                                  + dbadapter.cite(hipid));
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
                breedexamdate = dbadapter.getDate(52); // 繁育考试日期
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
                X_ray = dbadapter.getInt(63);
                walking_str = dbadapter.getString(64);
                crossbone_str = dbadapter.getString(65);
                trunk_str = dbadapter.getString(66);
                vein_str = dbadapter.getString(67);
                appetence_str = dbadapter.getString(68);
                caipan_name = dbadapter.getString(69);
                caipan_addtime = dbadapter.getDate(70);
                toothdefects = dbadapter.getString(71); ///牙齿评价
                tooths = dbadapter.getString(72); //牙齿复选
                testicl_str = dbadapter.getString(73);
                otherdogcolor = dbadapter.getString(74);
                addmember = dbadapter.getString(75);
            }
        } finally
        {
            dbadapter.close();
        }
    }

    //以耳号做主键的 查询
    private void load() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter
                    .executeQuery("select idnum,boolid,earid,hipid,DNAid,breedtime,breedlevel,promotion,finallylevel,trainsc,updatadoghost,shoulder,chestlong,chestall,heavry,weight,exceedinglength,testicle,overall ,vein,attention,neural,natural ,guns ,TSB,sexcharacter,build,expressiveforce,trunk,posteriorlimb,back,elbowjoint,hindfoot ,face,crossbone,osteoarthrosis ,walking,walkongfrist,walkingpedals,claw,toe,head,eyecolor,maxilla,chin,tooth,toothdefect,itemgood,notion,breedexamaddrid,breedexamaddress,breedexamdate,breedexammajordomo,breedexamid,addtime,[updatetime],community,appetence,muscle,bones,forelimb,dogcolor,X_ray,walking_str,  crossbone_str,  trunk_str,  vein_str,  appetence_str,otherdogcolor,addmember from Csvdogcheck where earid=" +
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
                breedexamdate = dbadapter.getDate(52); // 繁育考试日期
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
                walking_str = dbadapter.getString(64);
                crossbone_str = dbadapter.getString(65);
                trunk_str = dbadapter.getString(66);
                vein_str = dbadapter.getString(67);
                appetence_str = dbadapter.getString(68);
                otherdogcolor = dbadapter.getString(69);
                addmember = dbadapter.getString(70);

            }
        } finally
        {
            dbadapter.close();
        }
    }

    //以耳号做主键的 查询
    private void load_blood() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter
                    .executeQuery("select idnum,boolid,earid,hipid,DNAid,breedtime,breedlevel,promotion,finallylevel,trainsc,updatadoghost,shoulder,chestlong,chestall,heavry,weight,exceedinglength,testicle,overall ,vein,attention,neural,natural ,guns ,TSB,sexcharacter,build,expressiveforce,trunk,posteriorlimb,back,elbowjoint,hindfoot ,face,crossbone,osteoarthrosis ,walking,walkongfrist,walkingpedals,claw,toe,head,eyecolor,maxilla,chin,tooth,toothdefect,itemgood,notion,breedexamaddrid,breedexamaddress,breedexamdate,breedexammajordomo,breedexamid,addtime,[updatetime],community,appetence,muscle,bones,forelimb,dogcolor,X_ray,walking_str,  crossbone_str,  trunk_str,  vein_str,  appetence_str,otherdogcolor from Csvdogcheck where boolid=" +
                                  dbadapter.cite(boolid));
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
                breedexamdate = dbadapter.getDate(52); // 繁育考试日期
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
                walking_str = dbadapter.getString(64);
                crossbone_str = dbadapter.getString(65);
                trunk_str = dbadapter.getString(66);
                vein_str = dbadapter.getString(67);
                appetence_str = dbadapter.getString(68);
                otherdogcolor  = dbadapter.getString(69);
            }
        } finally
        {
            dbadapter.close();
        }
    }

    // 只插入少量数据的类 犬的耳号，血统号，DNA号 ，髋肘号，DNA提取时间，光片类型，社区。（这个是第一次插入）
    public static void createX_ray(String idnum, String boolid, String earid, String hipid, String DNAid, Date DNAtime, int X_ray, String community) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into csvdogcheck (idnum,boolid,earid,hipid,DNAid,DNAtime,X_ray,community) values (" + dbadapter.cite(idnum)
                                    + ","
                                    + dbadapter.cite(boolid)
                                    + ","
                                    + dbadapter.cite(earid)
                                    + ","
                                    + dbadapter.cite(hipid)
                                    + ","
                                    + dbadapter.cite(DNAid)
                                    + ","
                                    + dbadapter.cite(DNAtime)
                                    + ","
                                    + X_ray + "," + dbadapter.cite(community) + ")");
        } finally
        {
            dbadapter.close();
        }
    }

    // 插入数据
    public static void create(String idnum, String boolid, String earid, String hipid, String DNAid, String breedtime, String breedlevel, String promotion, String finallylevel, String trainsc,
                              String updatadoghost, String shoulder, String chestlong, String chestall, String heavry, int weight, int exceedinglength, int testicle, String overall, int vein, int attention,
                              int natural, int neural, int guns, String TSB, int sexcharacter, int build, int expressiveforce, int trunk, int posteriorlimb, int back, int elbowjoint, int hindfoot, int face,
                              int crossbone, int osteoarthrosis, int walking, int walkongfrist, int walkingpedals, int claw, int toe, int head, int eyecolor, int maxilla, int chin, int tooth, int toothdefect,
                              String itemgood, String notion, String breedexamaddrid, String breedexamaddress,String breedexamdate, String breedexammajordomo, int breedexamid, Date addtime, Date updatetime,
                              String community, int appetence, int muscle, int bones, int forelimb, String dogcolor) throws SQLException
    {

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Csvdogcheck(idnum,boolid,earid,hipid,DNAid,breedtime,breedlevel,promotion,finallylevel,trainsc,updatadoghost,shoulder,chestlong,chestall,heavry,weight,exceedinglength,testicle,overall ,vein,attention,neural,natural ,guns ,TSB,sexcharacter,build,expressiveforce,trunk,posteriorlimb,back,elbowjoint,hindfoot ,face,crossbone,osteoarthrosis ,walking,walkongfrist,walkingpedals,claw,toe,head,eyecolor,maxilla,chin,tooth,toothdefect,itemgood,notion,breedexamaddrid,breedexamaddress,breedexamdate,breedexammajordomo,breedexamid,addtime,[updatetime]) VALUES("
                                    + dbadapter.cite(idnum)
                                    + ","
                                    + dbadapter.cite(boolid)
                                    + ","
                                    + dbadapter.cite(earid)
                                    + ","
                                    + dbadapter.cite(hipid)
                                    + ","
                                    + dbadapter.cite(DNAid)
                                    + ","
                                    + dbadapter.cite(breedtime)
                                    + ","
                                    + dbadapter.cite(breedlevel)
                                    + ","
                                    + dbadapter.cite(promotion)
                                    + ","
                                    + dbadapter.cite(finallylevel)
                                    + ","
                                    + dbadapter.cite(trainsc)
                                    + ","
                                    + dbadapter.cite(updatadoghost)
                                    + ","
                                    + dbadapter.cite(shoulder)
                                    + ","
                                    + dbadapter.cite(chestlong)
                                    + ","
                                    + dbadapter.cite(chestall)
                                    + ","
                                    + dbadapter.cite(heavry)
                                    + ","
                                    + weight
                                    + ","
                                    + exceedinglength
                                    + ","
                                    + testicle
                                    + ","
                                    + dbadapter.cite(overall)
                                    + ","
                                    + vein
                                    + ","
                                    + attention
                                    + ","
                                    + neural
                                    + ","
                                    + natural
                                    + ","
                                    + guns
                                    + ","
                                    + dbadapter.cite(TSB)
                                    + ","
                                    + sexcharacter
                                    + ","
                                    + build
                                    + ","
                                    + expressiveforce
                                    + ","
                                    + trunk
                                    + ","
                                    + posteriorlimb
                                    + ","
                                    + back
                                    + ","
                                    + elbowjoint
                                    + ","
                                    + hindfoot
                                    + ","
                                    + face
                                    + ","
                                    + crossbone
                                    + ","
                                    + osteoarthrosis
                                    + ","
                                    + walking
                                    + ","
                                    + walkongfrist
                                    + ","
                                    + walkingpedals
                                    + ","
                                    + claw
                                    + ","
                                    + toe
                                    + ","
                                    + head
                                    + ","
                                    + eyecolor
                                    + ","
                                    + maxilla
                                    + ","
                                    + chin
                                    + ","
                                    + tooth
                                    + ","
                                    + toothdefect
                                    + ","
                                    + dbadapter.cite(itemgood)
                                    + ","
                                    + dbadapter.cite(notion)
                                    + ","
                                    + dbadapter.cite(breedexamaddrid)
                                    + ","
                                    + dbadapter.cite(breedexamaddress)
                                    + ","
                                    + dbadapter.cite(breedexamdate)
                                    + ","
                                    + dbadapter.cite(breedexammajordomo)
                                    + ","
                                    + breedexamid
                                    + ","
                                    + dbadapter.cite(addtime) + "," + dbadapter.cite(updatetime) + "," + appetence + "," + muscle + "," + bones + "," + forelimb + "," + dbadapter.cite(dogcolor) + " )");
        } finally
        {
            dbadapter.close();
        }
    }


    // 插入数据 2008-3-14 修改创建字段，新添加了5个字段
    public static void create_new(String idnum, String boolid, String earid, String hipid, String DNAid, String breedtime, String breedlevel, String promotion, String finallylevel, String trainsc,
                                  String updatadoghost, String shoulder, String chestlong, String chestall, String heavry, int weight, int exceedinglength, int testicle, String overall, int vein, int attention,
                                  int natural, int neural, int guns, String TSB, int sexcharacter, int build, int expressiveforce, int trunk, int posteriorlimb, int back, int elbowjoint, int hindfoot, int face,
                                  int crossbone, int osteoarthrosis, int walking, int walkongfrist, int walkingpedals, int claw, int toe, int head, int eyecolor, int maxilla, int chin, int tooth, int toothdefect,
                                  String itemgood, String notion, String breedexamaddrid, String breedexamaddress, String breedexamdate, String breedexammajordomo, int breedexamid, Date addtime, Date updatetime,
                                  String community, int appetence, int muscle, int bones, int forelimb, String dogcolor, String walking_str, String crossbone_str, String trunk_str, String vein_str, String appetence_str) throws SQLException
    {

        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("INSERT INTO Csvdogcheck(idnum,boolid,earid,hipid,DNAid,breedtime,breedlevel,promotion,finallylevel,trainsc,updatadoghost,shoulder,chestlong,chestall,heavry,weight,exceedinglength,testicle,overall ,vein,attention,neural,natural ,guns ,TSB,sexcharacter,build,expressiveforce,trunk,posteriorlimb,back,elbowjoint,hindfoot ,face,crossbone,osteoarthrosis ,walking,walkongfrist,walkingpedals,claw,toe,head,eyecolor,maxilla,chin,tooth,toothdefect,itemgood,notion,breedexamaddrid,breedexamaddress,breedexamdate,breedexammajordomo,breedexamid,addtime,[updatetime],walking_str,  crossbone_str,  trunk_str,  vein_str,  appetence_str) VALUES("
                                    + dbadapter.cite(idnum)
                                    + ","
                                    + dbadapter.cite(boolid)
                                    + ","
                                    + dbadapter.cite(earid)
                                    + ","
                                    + dbadapter.cite(hipid)
                                    + ","
                                    + dbadapter.cite(DNAid)
                                    + ","
                                    + dbadapter.cite(breedtime)
                                    + ","
                                    + dbadapter.cite(breedlevel)
                                    + ","
                                    + dbadapter.cite(promotion)
                                    + ","
                                    + dbadapter.cite(finallylevel)
                                    + ","
                                    + dbadapter.cite(trainsc)
                                    + ","
                                    + dbadapter.cite(updatadoghost)
                                    + ","
                                    + dbadapter.cite(shoulder)
                                    + ","
                                    + dbadapter.cite(chestlong)
                                    + ","
                                    + dbadapter.cite(chestall)
                                    + ","
                                    + dbadapter.cite(heavry)
                                    + ","
                                    + weight
                                    + ","
                                    + exceedinglength
                                    + ","
                                    + testicle
                                    + ","
                                    + dbadapter.cite(overall)
                                    + ","
                                    + vein
                                    + ","
                                    + attention
                                    + ","
                                    + neural
                                    + ","
                                    + natural
                                    + ","
                                    + guns
                                    + ","
                                    + dbadapter.cite(TSB)
                                    + ","
                                    + sexcharacter
                                    + ","
                                    + build
                                    + ","
                                    + expressiveforce
                                    + ","
                                    + trunk
                                    + ","
                                    + posteriorlimb
                                    + ","
                                    + back
                                    + ","
                                    + elbowjoint
                                    + ","
                                    + hindfoot
                                    + ","
                                    + face
                                    + ","
                                    + crossbone
                                    + ","
                                    + osteoarthrosis
                                    + ","
                                    + walking
                                    + ","
                                    + walkongfrist
                                    + ","
                                    + walkingpedals
                                    + ","
                                    + claw
                                    + ","
                                    + toe
                                    + ","
                                    + head
                                    + ","
                                    + eyecolor
                                    + ","
                                    + maxilla
                                    + ","
                                    + chin
                                    + ","
                                    + tooth
                                    + ","
                                    + toothdefect
                                    + ","
                                    + dbadapter.cite(itemgood)
                                    + ","
                                    + dbadapter.cite(notion)
                                    + ","
                                    + dbadapter.cite(breedexamaddrid)
                                    + ","
                                    + dbadapter.cite(breedexamaddress)
                                    + ","
                                    + dbadapter.cite(breedexamdate)
                                    + ","
                                    + dbadapter.cite(breedexammajordomo)
                                    + ","
                                    + breedexamid
                                    + ","
                                    + dbadapter.cite(addtime) + "," + dbadapter.cite(updatetime) + "," + appetence + "," + muscle + "," + bones + "," + forelimb + "," + dbadapter.cite(dogcolor)
                                    + "," + dbadapter.cite(walking_str) + ",  " + dbadapter.cite(crossbone_str) + ",  " + dbadapter.cite(trunk_str) + ",  " + dbadapter.cite(vein_str) + ",  " + dbadapter.cite(appetence_str) + " )");
        } finally
        {
            dbadapter.close();
        }
    }

    // 修改数据
    public void set(String idnum, String boolid, String earid, String hipid, String DNAid, String breedtime, String breedlevel, String promotion, String finallylevel, String trainsc,
                    String updatadoghost, String shoulder, String chestlong, String chestall, String heavry, int weight, int exceedinglength, int testicle, String overall, int vein, int attention,
                    int natural, int neural, int guns, String TSB, int sexcharacter, int build, int expressiveforce, int trunk, int posteriorlimb, int back, int elbowjoint, int hindfoot, int face,
                    int crossbone, int osteoarthrosis, int walking, int walkongfrist, int walkingpedals, int claw, int toe, int head, int eyecolor, int maxilla, int chin, int tooth, int toothdefect,
                    String itemgood, String notion, String breedexamaddrid, String breedexamaddress, Date breedexamdate, String breedexammajordomo, int breedexamid, Date addtime, Date updatetime,
                    String community, int appetence, int muscle, int bones, int forelimb, String dogcolor) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdogcheck SET" + " idnum =" + dbadapter.cite(idnum) + " ,boolid =" + dbadapter.cite(boolid) + " ,earid =" + dbadapter.cite(earid) + " ,hipid ="
                                    + dbadapter.cite(hipid) + " ,DNAid =" + dbadapter.cite(DNAid) + " ,breedtime =" + dbadapter.cite(breedtime) + " ,breedlevel =" + dbadapter.cite(breedlevel) + " ,promotion ="
                                    + dbadapter.cite(promotion) + " ,finallylevel =" + dbadapter.cite(finallylevel) + " ,trainsc =" + dbadapter.cite(trainsc) + " ,updatadoghost =" + dbadapter.cite(updatadoghost)
                                    + " ,shoulder =" + dbadapter.cite(shoulder) + " ,chestlong =" + dbadapter.cite(chestlong) + " ,chestall =" + dbadapter.cite(chestall) + " ,heavry =" + dbadapter.cite(heavry)
                                    + " ,weight =" + weight + " ,exceedinglength =" + exceedinglength + " ,testicle =" + testicle + " ,overall =" + dbadapter.cite(overall) + " ,vein =" + vein + " ,attention =" + attention
                                    + " ,natural =" + natural + " ,neural =" + neural + " ,guns =" + guns + " ,TSB =" + dbadapter.cite(TSB) + " ,sexcharacter =" + sexcharacter + " ,build =" + build + " ,expressiveforce ="
                                    + expressiveforce + " ,trunk =" + trunk + " ,posteriorlimb =" + posteriorlimb + " ,back =" + back + " ,elbowjoint =" + elbowjoint + " ,hindfoot =" + hindfoot + " ,face =" + face
                                    + " ,crossbone =" + crossbone + " ,osteoarthrosis =" + osteoarthrosis + " ,walking =" + walking + " ,walkongfrist =" + walkongfrist + " ,walkingpedals =" + walkingpedals + " ,claw ="
                                    + claw + " ,toe =" + toe + " ,head =" + head + " ,eyecolor =" + eyecolor + " ,maxilla =" + maxilla + " ,chin =" + chin + " ,tooth =" + tooth + " ,toothdefect =" + toothdefect
                                    + " ,itemgood =" + dbadapter.cite(itemgood) + " ,notion =" + dbadapter.cite(notion) + " ,breedexamaddrid =" + dbadapter.cite(breedexamaddrid) + " ,breedexamaddress ="
                                    + dbadapter.cite(breedexamaddress) + " ,breedexamdate =" + dbadapter.cite(breedexamdate) + " ,breedexammajordomo =" + dbadapter.cite(breedexammajordomo) + " ,breedexamid ="
                                    + breedexamid + " ,addtime = " + dbadapter.cite(addtime) + " ,updatetime =" + dbadapter.cite(updatetime) + " ,community =" + dbadapter.cite(community)
                                    + " ,appetence =" + appetence + " ,muscle =" + muscle + " ,bones =" + bones + " ,forelimb =" + forelimb
                                    + " ,dogcolor =" + dbadapter.cite(dogcolor) + " WHERE hipid=" + dbadapter.cite(hipid));
        } finally
        {
            dbadapter.close();
        }
        this.idnum = idnum;
        this.boolid = boolid;
        this.earid = earid;
        this.hipid = hipid;
        this.DNAid = DNAid;
        this.breedtime = breedtime;
        this.breedlevel = breedlevel;
        this.promotion = promotion;
        this.finallylevel = finallylevel;
        this.trainsc = trainsc;
        this.updatadoghost = updatadoghost;
        this.shoulder = shoulder;
        this.chestlong = chestlong;
        this.chestall = chestall;
        this.heavry = heavry;
        this.weight = weight;
        this.exceedinglength = exceedinglength;
        this.testicle = testicle;
        this.overall = overall;
        this.vein = vein;
        this.attention = attention;
        this.natural = natural;
        this.neural = neural;
        this.guns = guns;
        this.TSB = TSB;
        this.sexcharacter = sexcharacter;
        this.build = build;
        this.expressiveforce = expressiveforce;
        this.trunk = trunk;
        this.posteriorlimb = posteriorlimb;
        this.back = back;
        this.elbowjoint = elbowjoint;
        this.hindfoot = hindfoot;
        this.face = face;
        this.crossbone = crossbone;
        this.osteoarthrosis = osteoarthrosis;
        this.walking = walking;
        this.walkongfrist = walkongfrist;
        this.walkingpedals = walkingpedals;
        this.claw = claw;
        this.toe = toe;
        this.head = head;
        this.eyecolor = eyecolor;
        this.maxilla = maxilla;
        this.chin = chin;
        this.tooth = tooth;
        this.toothdefect = toothdefect;
        this.itemgood = itemgood;
        this.notion = notion;
        this.breedexamaddrid = breedexamaddrid;
        this.breedexamaddress = breedexamaddress;
        this.breedexamdate = breedexamdate;
        this.breedexammajordomo = breedexammajordomo;
        this.breedexamid = breedexamid;
        this.addtime = addtime;
        this.updatetime = updatetime;
        this.community = community;
        this.appetence = appetence;
        this.muscle = muscle;
        this.bones = bones;
        this.forelimb = forelimb;
        this.dogcolor = dogcolor;

    }

    /////为新添加的字段修改其 连内容///////////////





    public void set_new(String idnum, String boolid, String earid, String hipid, String DNAid, String breedtime, String breedlevel, String promotion, String finallylevel, String trainsc,
                        String updatadoghost, String shoulder, String chestlong, String chestall, String heavry, int weight, int exceedinglength, int testicle, String overall, int vein, int attention,
                        int natural, int neural, int guns, String TSB, int sexcharacter, int build, int expressiveforce, int trunk, int posteriorlimb, int back, int elbowjoint, int hindfoot, int face,
                        int crossbone, int osteoarthrosis, int walking, int walkongfrist, int walkingpedals, int claw, int toe, int head, int eyecolor, int maxilla, int chin, int tooth, int toothdefect,
                        String itemgood, String notion, String breedexamaddrid, String breedexamaddress, Date breedexamdate, String breedexammajordomo, int breedexamid, Date addtime, Date updatetime,
                        String community, int appetence, int muscle, int bones, int forelimb, String dogcolor, String walking_str, String crossbone_str, String trunk_str, String vein_str, String appetence_str)

            throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("UPDATE Csvdogcheck SET" + " idnum =" + dbadapter.cite(idnum) + " ,boolid =" + dbadapter.cite(boolid) + " ,earid =" + dbadapter.cite(earid) + " ,hipid ="
                                    + dbadapter.cite(hipid) + " ,DNAid =" + dbadapter.cite(DNAid) + " ,breedtime =" + dbadapter.cite(breedtime) + " ,breedlevel =" + dbadapter.cite(breedlevel) + " ,promotion ="
                                    + dbadapter.cite(promotion) + " ,finallylevel =" + dbadapter.cite(finallylevel) + " ,trainsc =" + dbadapter.cite(trainsc) + " ,updatadoghost =" + dbadapter.cite(updatadoghost)
                                    + " ,shoulder =" + dbadapter.cite(shoulder) + " ,chestlong =" + dbadapter.cite(chestlong) + " ,chestall =" + dbadapter.cite(chestall) + " ,heavry =" + dbadapter.cite(heavry)
                                    + " ,weight =" + weight + " ,exceedinglength =" + exceedinglength + " ,testicle =" + testicle + " ,overall =" + dbadapter.cite(overall) + " ,vein =" + vein + " ,attention =" + attention
                                    + " ,natural =" + natural + " ,neural =" + neural + " ,guns =" + guns + " ,TSB =" + dbadapter.cite(TSB) + " ,sexcharacter =" + sexcharacter + " ,build =" + build + " ,expressiveforce ="
                                    + expressiveforce + " ,trunk =" + trunk + " ,posteriorlimb =" + posteriorlimb + " ,back =" + back + " ,elbowjoint =" + elbowjoint + " ,hindfoot =" + hindfoot + " ,face =" + face
                                    + " ,crossbone =" + crossbone + " ,osteoarthrosis =" + osteoarthrosis + " ,walking =" + walking + " ,walkongfrist =" + walkongfrist + " ,walkingpedals =" + walkingpedals + " ,claw ="
                                    + claw + " ,toe =" + toe + " ,head =" + head + " ,eyecolor =" + eyecolor + " ,maxilla =" + maxilla + " ,chin =" + chin + " ,tooth =" + tooth + " ,toothdefect =" + toothdefect
                                    + " ,itemgood =" + dbadapter.cite(itemgood) + " ,notion =" + dbadapter.cite(notion) + " ,breedexamaddrid =" + dbadapter.cite(breedexamaddrid) + " ,breedexamaddress ="
                                    + dbadapter.cite(breedexamaddress) + " ,breedexamdate =" + dbadapter.cite(breedexamdate) + " ,breedexammajordomo =" + dbadapter.cite(breedexammajordomo) + " ,breedexamid ="
                                    + breedexamid + " ,addtime = " + dbadapter.cite(addtime) + " ,updatetime =" + dbadapter.cite(updatetime) + " ,community =" + dbadapter.cite(community)

                                    + " ,appetence =" + appetence + " ,muscle =" + muscle + " ,bones =" + bones + " ,forelimb =" + forelimb
                                    + " ,dogcolor =" + dbadapter.cite(dogcolor) + ",walking_str =" + dbadapter.cite(walking_str) + " ,  crossbone_str =" + dbadapter.cite(crossbone_str) + ",  trunk_str =" + dbadapter.cite(trunk_str) + ",  vein_str =" + dbadapter.cite(vein_str) + ",  appetence_str=" + dbadapter.cite(appetence_str) + " WHERE hipid="
                                    + dbadapter.cite(hipid));
        } finally
        {
            dbadapter.close();
        }
        this.idnum = idnum;
        this.boolid = boolid;
        this.earid = earid;
        this.hipid = hipid;
        this.DNAid = DNAid;
        this.breedtime = breedtime;
        this.breedlevel = breedlevel;
        this.promotion = promotion;
        this.finallylevel = finallylevel;
        this.trainsc = trainsc;
        this.updatadoghost = updatadoghost;
        this.shoulder = shoulder;
        this.chestlong = chestlong;
        this.chestall = chestall;
        this.heavry = heavry;
        this.weight = weight;
        this.exceedinglength = exceedinglength;
        this.testicle = testicle;
        this.overall = overall;
        this.vein = vein;
        this.attention = attention;
        this.natural = natural;
        this.neural = neural;
        this.guns = guns;
        this.TSB = TSB;
        this.sexcharacter = sexcharacter;
        this.build = build;
        this.expressiveforce = expressiveforce;
        this.trunk = trunk;
        this.posteriorlimb = posteriorlimb;
        this.back = back;
        this.elbowjoint = elbowjoint;
        this.hindfoot = hindfoot;
        this.face = face;
        this.crossbone = crossbone;
        this.osteoarthrosis = osteoarthrosis;
        this.walking = walking;
        this.walkongfrist = walkongfrist;
        this.walkingpedals = walkingpedals;
        this.claw = claw;
        this.toe = toe;
        this.head = head;
        this.eyecolor = eyecolor;
        this.maxilla = maxilla;
        this.chin = chin;
        this.tooth = tooth;
        this.toothdefect = toothdefect;
        this.itemgood = itemgood;
        this.notion = notion;
        this.breedexamaddrid = breedexamaddrid;
        this.breedexamaddress = breedexamaddress;
        this.breedexamdate = breedexamdate;
        this.breedexammajordomo = breedexammajordomo;
        this.breedexamid = breedexamid;
        this.addtime = addtime;
        this.updatetime = updatetime;
        this.community = community;
        this.appetence = appetence;
        this.muscle = muscle;
        this.bones = bones;
        this.forelimb = forelimb;
        this.dogcolor = dogcolor;
        this.walking_str = walking_str;
        this.crossbone_str = crossbone_str;
        this.trunk_str = trunk_str;
        this.vein_str = vein_str;
        this.appetence_str = appetence_str;

    }

    // 枚举方法
    public static java.util.Enumeration findByCommunityTest(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT idnum FROM Csvdogcheck WHERE community=" + DbAdapter.cite(community) + sql);
            while (dbadapter.next())
            {
                vector.addElement(new Integer(dbadapter.getInt(1)));
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    ///正常的返回耳号的方法
    public static java.util.Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT earid FROM Csvdogcheck WHERE community=" + DbAdapter.cite(community) + sql);
            while (dbadapter.next())
            {
                vector.addElement(dbadapter.getString(1));
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    //取回hipid号的方法
    public static java.util.Enumeration findhipByCommunity(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT hipid FROM Csvdogcheck WHERE community=" + DbAdapter.cite(community) + sql);
            while (dbadapter.next())
            {
                vector.addElement(dbadapter.getString(1));
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }


    // 返回分页的页数根据耳号
    public static int countByCommunity(String community, String sql) throws SQLException
    {
        int i = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            i = dbadapter.getInt("SELECT count(earid) FROM Csvdogcheck WHERE community=" + dbadapter.cite(community) + sql);
        } finally
        {
            dbadapter.close();
        }
        return i;
    }

//	 返回分页的页数根据hipid
    public static int counthipByCommunity(String community, String sql) throws SQLException
    {
        int i = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            i = dbadapter.getInt("SELECT count(hipid) FROM Csvdogcheck WHERE community=" + dbadapter.cite(community) + sql);

        } finally
        {
            dbadapter.close();
        }
        return i;
    }

    //带分页的取回耳号方法
    public static java.util.Enumeration findByCommunity(String community, String sql, int pos, int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT earid FROM Csvdogcheck WHERE community=" + DbAdapter.cite(community) + sql);
            for (int l = 0; l < pos + size && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    vector.addElement(dbadapter.getString(1));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

//	带分页的取回hipid方法
    public static java.util.Enumeration findhipByCommunity(String community, String sql, int pos, int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT hipid FROM Csvdogcheck WHERE community=" + DbAdapter.cite(community) + sql);
            for (int l = 0; l < pos + size && dbadapter.next(); l++)
            {
                if (l >= pos)
                {
                    vector.addElement(dbadapter.getString(1));
                }
            }
        } finally
        {
            dbadapter.close();
        }
        return vector.elements();
    }

    // 相对应的血统号和耳号的ajax校验bean
    public static boolean isExisted(String bloodlineletterid, String earid) throws SQLException
    {
        boolean flag = false;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT earid FROM Csvdog WHERE bloodlineletterid=" + DbAdapter.cite(bloodlineletterid) + " and earid='" + earid + "'");
            flag = dbadapter.next();
        } finally
        {
            dbadapter.close();
        }
        return flag;
    }

    // /根据用户ID，返回这个用户注册的最后一条狗的髋肘号，1070167005
    public static String CsvdoghipByCommunity(String community, String members, String doghip) throws SQLException
    {
        String i = null;
        String b = null;
        String str = "1" + doghip;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            i = dbadapter.getString("select max (hipid) from csvdogcheck where community=" + dbadapter.cite(community) + "and idnum=" + dbadapter.cite(members) + " and hipid like " + DbAdapter.cite("%" + str + "%"));
 //           System.out.print("select max (hipid) from csvdogcheck where community=" + dbadapter.cite(community) + "and idnum=" + dbadapter.cite(members) + " and hipid like " + DbAdapter.cite("%" + str + "%"));

            if (i != null && i != "")
            {
                b = i.substring(7);
                i = "1" + doghip + b;
            } else

            {
                i = "1" + doghip + "000";
            }

        } finally
        {
            dbadapter.close();
        }
        return i;
    }

    // 根据用户ID，返回这个用户注册的最后一条狗的DNA号， 2070167005
    public static String CsvdogDNAByCommunity(String community, String members, String doghip) throws SQLException
    {
        // Stringbuffer i = null;
        String i = null;
        String b = null;
        String str = "2" + doghip;
        DbAdapter dbadapter = new DbAdapter();
        try

        {
            i = dbadapter.getString("select max (DNAid) from csvdogcheck where community=" + dbadapter.cite(community) + "and idnum=" + dbadapter.cite(members) + " and DNAid like " + DbAdapter.cite("%" + str + "%"));
  //          System.out.print("select max (DNAid) from csvdogcheck where community=" + dbadapter.cite(community) + "and idnum=" + dbadapter.cite(members) + " and DNAid like " + DbAdapter.cite("%" + str + "%"));

            if (i != null && i != "")
            {
                b = i.substring(7);
                i = "2" + doghip + b;
            } else
            {
                i = "2" + doghip + "000";
            }
        } finally
        {
            dbadapter.close();
        }
        return i;
    }

    // 得到会员编号00-N-00003 ----------------00003是要取得的会员编号
    public static String getmemberString(String membernumstr)
    {
        String str1 = "-N-";
        int num = membernumstr.length();
        int index = membernumstr.indexOf(str1);
        return membernumstr.substring(num - index - 2);
    }

    /******
     * 根据会员编号生成 国外的hipid号、、2008年6月18日15:50:55
     * *******/
    public static String Csvdoghip_f(String community, String members, String doghip) throws SQLException
    {

        ProfileCsv procsv = ProfileCsv.find(members);
        Profile pro = Profile.find(members);
        doghip=Csvdogcheck.getmemberString(procsv.getMembernumber());
        String i = null;
        String b = null;
        String str =""; //"3" +SeqTable.df2.format(pro.getProvince(1))+ doghip;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            i = dbadapter.getString("select max (hipid) from csvdogcheck where community=" + dbadapter.cite(community) + "and idnum=" + dbadapter.cite(members) + " and hipid like " + DbAdapter.cite("%" + str + "%"));
            if (i != null && i != "")
            {
                b = i.substring(7);
                i = "3" + doghip + b;
            } else

            {
                i = "3" + doghip + "000";
            }
        } finally
        {
            dbadapter.close();
        }
        return i;
    }


    ///******删除方法*********************//
    public void delete(String hipid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("delete csvdogcheck where hipid=" + dbadapter.cite(hipid));

        } finally
        {
            dbadapter.close();
        }
    }

    /*********************************
     * 由于需要 又添加了 根据对应的hip号 返回 idnum DNA Boolid earid

     * ******************/

    public static String CsvgethipIdnum(String hipid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        String str = null;
        try
        {
            str = dbadapter.getString("select idnum from csvdogcheck  where hipid=" + dbadapter.cite(hipid));

        } finally
        {
            dbadapter.close();

        }
        return str;
    }

    //根据hipid取得earid
    public static String Csvgethipearid(String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select earid from Csvdogcheck where hipid =" + dbadapter.cite(hipid));

        } catch (Exception ex1)
        {
            throw new SQLException(ex1.toString());
        } finally
        {
            dbadapter.close();

        }

        return str;
    }

    //根据hipid取得血统证书号
    public static String Csvgethipboolid(String hipid) throws SQLException
    {

        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select boolid from Csvdogcheck where hipid=" + dbadapter.cite(hipid));
        } catch (Exception ex1)
        {
            throw new SQLException(ex1.toString());
        } finally
        {
            dbadapter.close();

        }

        return str;
    }

    //根据hipid号取得DNA号
    public static String CsvgethipDNAid(String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select DNAid from Csvdogcheck where hipid=" + dbadapter.cite(hipid));
        } catch (Exception ex1)
        {
            throw new SQLException(ex1.toString());
        } finally
        {
            dbadapter.close();

        }

        return str;
    }

    //
    public static String CsvgetDNAidearid(String DNAid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select earid from Csvdogcheck where DNAid=" + dbadapter.cite(DNAid));
        } catch (Exception ex1)
        {
            throw new SQLException(ex1.toString());
        } finally
        {
            dbadapter.close();

        }

        return str;
    }

    ///通过用户名取得耳号
    public static String Csvgetearidname(String idnum) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select earid from Csvdogcheck where earid=" + dbadapter.cite(idnum));
        } catch (Exception ex1)
        {
            throw new SQLException(ex1.toString());
        } finally
        {
            dbadapter.close();
        }
        return str;
    }

    //生成新的繁育证书
    public static int newbreedid() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("select max(breedexamid) from csvdogcheck");
            if (dbadapter.next())
            {
                return dbadapter.getInt(1) + 1;
            } else
            {
                return 1;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    //
    public static void setone(String hipid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogcheck set breedtime='2009年7月31日' ,finallylevel='短期' where hipid= " + dbadapter.cite(hipid));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static void settwo(String hipid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogcheck set breedtime='2009年7月31日' where hipid= " + dbadapter.cite(hipid));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static String Csvcheckbox(String str, int values, String hipid)
    {
        boolean falg = false;

        try
        {
            falg = Csvdogcheck.gethipboolean(hipid);
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }
        if (falg && str.length() > 0)
        {
            String charflag[] = str.split(",");
            if (charflag != null)
            {
                for (int i = 0; i < charflag.length; i++)
                {
                    if (Integer.parseInt(charflag[i]) == values)
                    {
                        return "checked=checked";
                    }
                }
            }
        }
        return "";
    }


    public static boolean gethipboolean(String hipid) throws SQLException
    {
        DbAdapter dbadpter = new DbAdapter();
        try
        {
            dbadpter.executeQuery("select * from Csvdogcheck where hipid=" + dbadpter.cite(hipid));
            if (dbadpter.next())
            {
                return true;
            } else
            {
                return false;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadpter.close();
        }
    }

    /**************
     *
     *
     * private String caipan_name;
     *   private Date caipan_addtime;
     *   private String toothdefects;///牙齿评价
     * private String tooths;//牙齿复选

     *
     * **************/
    public void setCaipan_name(String caipan_name) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update csvdogcheck  set caipan_name=" + db.cite(caipan_name) + " where hipid=" + db.cite(hipid));
        } finally
        {
            db.close();
        }
    }

    public void setCaipan_addtime(String caipan_addtime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update csvdogcheck set  caipan_addtime=" + db.cite(caipan_addtime) + " where hipid=" + db.cite(hipid));
        } finally
        {
            db.close();
        }
    }


    public void setTooths(String tooths) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update csvdogcheck set  tooths=" + db.cite(tooths) + " where hipid=" + db.cite(hipid));
        } finally
        {
            db.close();
        }
    }

    public void setToothdefects(String toothdefects) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update csvdogcheck set toothdefects=" + db.cite(toothdefects) + " where hipid=" + db.cite(hipid));
        } finally
        {
            db.close();
        }
    }

    public void setTesticl_str(String testicl_str) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(" update csvdogcheck set testicl_str =" + db.cite(testicl_str) + "  where hipid=" + db.cite(hipid));
        } finally
        {
            db.close();
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

    public Date getBreedexamdate()
    {
        return breedexamdate;
    }
    public String getBreedexamdateToString()
    {
        if(breedexamdate!=null)
        {
            return Csvdogcheck.sdf.format(breedexamdate);
        }
        else
        {
            return "";
        }
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

    public String getCrossbone_str()
    {
        return crossbone_str;
    }

    public String getAppetence_str()
    {
        return appetence_str;
    }

    public String getTrunk_str()
    {
        return trunk_str;
    }

    public String getVein_str()
    {
        return vein_str;
    }

    public String getWalking_str()
    {
        return walking_str;
    }

    public String getCaipan_name()
    {
        return caipan_name;
    }

    public Date getCaipan_addtime()
    {
        return caipan_addtime;
    }

    public String getTooths()
    {
        return tooths;
    }

    public String getToothdefects()
    {
        return toothdefects;
    }

    public String getTesticl_str()
    {
        return testicl_str;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getOtherdogcolor()
    {
        return otherdogcolor;
    }

    public String getAddmember()
    {
        return addmember;
    }

    public int getX_ray()
    {
        return X_ray;
    }

    public String getDNAtime()
    {
        return DNAtime;
    }

    public void setDogcolor(String dogcolor) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update csvdogcheck set dogcolor ="+db.cite(dogcolor)+" where hipid="+ db.cite(hipid));
        }
        finally
        {
            db.close();
        }


    }

    public void setOtherdogcolor(String otherdogcolor) throws SQLException
    {
        DbAdapter db = new DbAdapter();
                try
                {
                    db.executeUpdate("update csvdogcheck set otherdogcolor ="+db.cite(otherdogcolor)+" where hipid="+ db.cite(hipid));
                }
                finally
                {
                    db.close();
                }

    }

    public static boolean falgaddmember(String hipid,String earid)throws SQLException
    {
        boolean falg = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select hipid from csvdogcheck where hipid="+db.cite(hipid)+" and earid="+db.cite(earid));
            if(db.next())
            {
                falg= true;
            }
            else
            {

                falg=false;
            }
        }
        finally
        {
            db.close();
        }
        return falg;
    }
    public static void setAddmember(String hipid,String earid,String addmember,String updatadoghost)throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update csvdogcheck set updatadoghost="+db.cite(updatadoghost)+",addmember="+db.cite(addmember)+" where hipid="+db.cite(hipid)+" and earid="+db.cite(earid));

        }
        finally
        {
            db.close();
        }
    }


    public static void setbreedall(String hipid,String earid,String breedtime,String breedlevel,String promotion,String finallylevel,String trainsc)throws SQLException
   {

       DbAdapter db = new DbAdapter();
       try
       {
           db.executeUpdate("update csvdogcheck set breedtime="+db.cite(breedtime)+",breedlevel="+db.cite(breedlevel)+",promotion="+db.cite(promotion)+",finallylevel="+db.cite(finallylevel)+",trainsc="+db.cite(trainsc)+" where hipid="+db.cite(hipid)+" and earid="+db.cite(earid));
       }
       finally
       {
           db.close();
       }
   }


}
