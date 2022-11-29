package tea.entity.csvclub;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Csvdogover extends Entity
{
    /*************************
     * 光片检测一中的所有字段
     ***/
    private String CT_all_place; //髋臼总体印象位置深
    private String CT_all_flatness; //髋臼总体印象平坦
    private String CT_all_flatnesslt; //髋臼总体印象平坦轻
    private String CT_FTline_linear; //髋臼前缘的轮廓线状的
    private String CT_FTline_bones; //髋臼前缘的轮廓关节软骨不骨质硬化
    private String CT_FTline_boneslt; //髋臼前缘的轮廓关节软骨不骨质硬化轻
    private String CT_FW_passivation; //髋臼前外侧缘钝化
    private String CT_FW_allover; //髋臼前外侧缘遍平
    private String CT_FW_alloverlt; //髋臼前外侧缘遍平轻
    private String CT_FW_bonescj; //髋臼前外侧缘骨质沉积
    private String CT_FW_bonescjlt; //髋臼前外侧缘骨质沉积轻
    private String CL_WF_roundness; //;//股骨头_整体印象_球形
    private String CL_WF_small; //;//股骨头_整体印象_太小
    private String CL_WF_smalllt; //;//股骨头_整体印象_太小轻
    private String CL_WF_YLZZS; //股骨头_整体印象_衣领状增生
    private String CL_WF_YLZZSlt; //股骨头_整体印象_衣领状增生轻
    private String CL_WF_catface; //股骨头_整体印象_畸形
    private String CL_WF_catfacelt; //股骨头_整体印象_畸形轻
    private String CL_frogkick; //股骨头_蛙式体位
    private String CL_frogkick_liphyperplasia; //股骨头_蛙式体位_唇样增生
    private String CL_frogkick_liphyperplasialt; //股骨头_蛙式体位_唇样增生轻
    private String TBW_dark; //股骨头髋臼中的位置_深
    private String TBW_pine; //股骨头髋臼中的位置_松
    private String TBW_pinelt; //股骨头髋臼中的位置_松轻度
    private String TB_slightness; //股骨颈细长
    private String TB_column; //股骨颈圆柱状
    private String TB_columnlt; //股骨颈圆柱状轻
    private String TB_limitclearly; //股骨颈界限分明
    private String TB_outlineinfocus; //股骨颈轮廓清晰
    private String TB_inadequate; //股骨颈不够清晰
    private String TB_inadequatelt; //股骨颈不够清晰轻度
    private String TB_settle; //股骨颈沉淀
    private String TB_settlelt; //股骨颈沉淀轻度
    private String TB_rubroot; //股骨颈摩根线
    private String TB_rubrootlt; //股骨颈摩根线轻度
    private String CJ_extendback_concentric; //关节间隙伸展的后肢同心化
    private String CJ_extendback_notconcentric; //关节间隙伸展的后肢非同心化
    private String CJ_extendback_notconcentriclt; //关节间隙伸展的后肢非同心化轻
    private String CJ_concentric; //关节间隙弯曲的后肢同心化
    private String CJ_notconcentric; //关节间隙弯曲的后肢非同心化
    private String CJ_notconcentriclt; //关节间隙弯曲的后肢非同心化轻
    private String TBC_W_inner; //股骨头中心股骨头在髋臼内的位置是否位于髋臼背侧缘的内侧
    private String TBC_W_side; //股骨头中心股骨头在髋臼内的位置是否位于髋臼背侧缘的外侧
    private String TBC_W_sidelt; //股骨头中心股骨头在髋臼内的位置是否位于髋臼背侧缘的外侧轻
    /*   2007-08-07  由于客户请求变更所做的更改
         CT_all总体印象  ---------位置深 重度平坦 轻度平坦
     CT_FTline髋臼前缘的轮廓 -----------线状的  重度关节软骨不骨质硬化  轻度关节软骨不骨质硬化
     CT_FW髋臼前外侧缘------------ 钝化  重度遍平   轻度遍平
         ---------------------- 重度骨质沉积    轻度骨质沉积
     CL_WF整体印象--------------- 球形  重度太小    轻度太小
         --------------------------重度衣领状增生     轻度衣领状增生
        ------------------------------ 重度畸形     轻度畸形
     CL_frogkick蛙式体位   --------  蛙式体位  重度唇样增生      轻度唇样增生
     TBW股骨头髋臼中的位置     -------- 深 重度松   轻度松
     TB_股骨颈:
     TB_slightness  细长------------------细长  重度圆柱状      轻度圆柱状                                               v
     TB_limitclearly 界限分明------------------界限分明
     TB_outlineinfocus ------------- 轮廓清晰  重度不够清晰      轻度不够清晰
     --------------------  重度沉淀           轻度沉淀
    ------------------  重度摩根线           轻度摩根线
     关节间隙:
     CJ_back_concentric伸展的后肢 ------------同心化  重度非同心化   轻度 非同心化
     CJ_w_concentric弯曲的后肢 ------------同心化  重度非同心化    轻度 非同心化
     TBC_股骨头中心:
     股骨头在髋臼内的位置 是否位于髋臼背侧缘的内侧 重度 外侧     轻度 外侧
     ---------------------------- 重度位于髋臼的背侧缘   轻度位于髋臼的背侧缘
     private String wherepics; //按照位置和照片质量缺陷:wherepic
     private String anglechecks; //按照诺贝角度检测: 位于髋臼的背侧缘后四个都是位于
     */
    private String hipid; //
    private String community; //
    private int id; //
    private int vetvalues; //兽医的评价
    private int csvovers; //csv髋关节鉴定结果：
    private Date DateTimes; //签字时间
    private int ctalls = 0;
    private int ctftlines = 0;
    private String ctfws = null;
    private String clwfs = null;
    private int clfrogkicks = 0;
    private int tbws = 0;
    private int tbslightness = 0;
    private int tblimitclearlys = 0;
    private String tboutlineinfocus = null;
    private int cjbackconcentrics = 0;
    private int cjwconcentrics = 0;
    private String tbcs = null;
    private String wherepics; //按照位置和照片质量缺陷:wherepic
    private int anglechecks; //按照诺贝角度检测: 位于髋臼的背侧缘后四个都是位于
    private String member; //医生id代表的是医生的id


    public static final String CTALL[] =
        {"--------", "位置深", "重度平坦", "轻度平坦"};
    public static final String CTFTLINE[] =
        {"--------", "线状的", "重度关节软骨不骨质硬化", "轻度关节软骨不骨质硬化"};
    public static final String CTFW[] =
        {"--------", "钝化", "重度遍平", "轻度遍平", "重度骨质沉积", "轻度骨质沉积"};
    public static final String CLWF[] =
        {"--------", "球形", "重度太小", "轻度太小", "重度衣领状增生", "轻度衣领状增生", "重度畸形", "轻度畸形"};
    public static final String CLFROGKICK[] =
        {"--------", "蛙式体位", "重度唇样增生", "轻度唇样增生"};
    public static final String TBW[] =
        {"--------", "深", "重度松", "轻度松"};
    public static final String TBSLIGHTNESS[] =
        {"--------", "细长", "重度圆柱状", "轻度圆柱状"};
    public static final String TBLIMITCLEARLY[] =
        {"--------", "界限分明"};
    public static final String TBOUTLIINEINFOCU[] =
        {"--------", "轮廓清晰", "重度不够清晰", "轻度不够清晰", "重度沉淀", "轻度沉淀", "重度摩根线", "轻度摩根线"};
    public static final String CJBACKCONCENTRICE[] =
        {"--------", "同心化", "重度非同心化", "轻度非同心化"};
    public static final String CJWCONCENTRIC[] =
        {"--------", "同心化", "重度非同心化", "轻度非同心化"};
    public static final String TBC[] =
        {"--------", "是否位于髋臼背侧缘的内侧", "重度外侧", "轻度外侧", "重度位于髋臼的背侧缘", "轻度位于髋臼的背侧缘"};
    /*
      第二张表
     照片编号: XX-XX-XX-XXO_ladderstate_r
     瑞士评分法：Switzgrade
      勾突骨赘drawbone 其它骨赘otherbone 骨质硬化boneossify 阶梯状ladderstate 勾状突(肘)drawelbow 滑车(只适用于前后位的照片)tackle 分值cent 病重侧分数illness 平均分average
     右
     左
     其他评分法：other
      勾突骨赘 其它骨赘 骨质硬化 阶梯状 勾状突(肘) 滑车(只适用于前后位的照片) 分值 病重侧分数 平均分
     右
     左
     角度测量   anglemeasure
     肘突 勾突 尺骨 侥骨
     elbowsudden    draw udden      ulnasudden     yaosudden
     评注:
     annotate
     */
    private String S_drawbone_r;
    private String S_drawbone_l;
    private String S_otherbone_r;
    private String S_otherbone_l;
    private String S_boneossify_r;
    private String S_boneossify_l;
    private String S_ladderstate_r;
    private String S_ladderstate_l;
    private String S_drawelbow_r;
    private String S_drawelbow_l;
    private String S_tackle_r;
    private String S_tackle_l;
    private String S_cent_r;
    private String S_cent_l;
    private String S_illness_r;
    private String S_illness_l;
    private String S_average_r;
    private String S_average_l;
    private String S_hatstatesudden_r; //冠状突
    private String S_hatstatesudden_l;
    private String O_drawbone_r;
    private String O_drawbone_l;
    private String O_otherbone_r;
    private String O_otherbone_l;
    private String O_boneossify_r;
    private String O_boneossify_l;
    private String O_ladderstate_r;
    private String O_ladderstate_l;
    private String O_drawelbow_r;
    private String O_drawelbow_l;
    private String O_tackle_r;
    private String O_tackle_l;
    private String O_cent_r;
    private String O_cent_l;
    private String O_illnesO_r;
    private String O_illnesO_l;
    private String O_average_r;
    private String O_average_l;
    private String O_hatstatesudden_r;
    private String O_hatstatesudden_l;
    private String A_elbowsudden;
    private String A_drawudden;
    private String A_ulnasudden;
    private String A_yaosudden;
    private String annotate;

    /********************第三张表******************************/

    private String num; //
    private Date picdate; //
    private String OCD; //
    private String FCP; //
    private String IPA; //
    private String doubtillness; //
    private String boneillgrade; //
    private String ED_opinion; //
    private String remark; //
    private String othermark; //
    private int csvelbows; //csv周关节鉴定结果：
    private int oos;
    private String doubtillness_b;
    private String boneillgrade_b;
    private String o_drawbone_r;

    private boolean exists; // 是否存在

    public static final String WHEREPICS[] =
        {"-------", "不对称", "后肢伸展不足", "后肢内旋不足", "后肢内旋过度", "后肢相互不平行", "不清晰", "对比度不足", "骨盆前端不显示", "显影不足"}; //按照位置和照片质量缺陷:wherepic

    public static final String VETVALUES[] =
        {"--------", "无髋关节发育不良的迹象", "可疑", "轻度髋关节发育不良", "中度髋关节发育不良", "重度髋关节发育不良"}; //兽医的评价

    public static final String CSVOVERS[][] =
        {
        {"-------", ""},
        {"正常", "A1"},
        {"基本正常", "A2"},
        {"轻度髋关节病", "A3"},
        {"中度髋关节病", "A4"},
        {"重度髋关节病", "A5"}
    }; //csv髋关节鉴定结果：
    public static final String CSVELBOWS[][] =
        {
        {"-------", ""},
        {"正常", "ED1"},
        {"基本正常", "ED2"},
        {"轻度肘关节病", "ED3"},
        {"中度肘关节病", "ED4"},
        {"重度肘关节病", "ED5"}
    }; //csv肘关节鉴定结果：

    public static final String ANGLECHECKS[] =
        {"---------", "大于等于105度", "100度-105度", "90度-100度 ", "小于90度"}; // 按照诺贝角度检测: 位于髋臼的背侧缘后三个都是位于

    public static final String OOS[] =
        {"--------", "拍摄位置缺陷", "X光片质量缺陷"};


    public Csvdogover(String hipid) throws SQLException
    {
        this.hipid = hipid;
        load();
    }

    public static Csvdogover find(String hipid) throws SQLException
    {
        return new Csvdogover(hipid);
    }


    public void load() throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();

        try
        {
            dbadapter.executeQuery("select hipid,community,id,wherepics,csvelbows,vetvalues,csvovers,anglechecks,ctalls,ctftlines,ctfws,clwfs,clfrogkicks,tbws,tbslightness,tblimitclearlys,tboutlineinfocus,cjbackconcentrics,cjwconcentrics,tbcs,DateTimes,S_drawbone_r,S_drawbone_l,S_otherbone_r,S_otherbone_l,S_boneossify_r,S_boneossify_l,S_ladderstate_r,S_ladderstate_l,S_drawelbow_r,S_drawelbow_l, S_tackle_r, S_tackle_l, S_cent_r, S_cent_l, S_illness_r, S_illness_l, S_average_r, S_average_l, S_hatstatesudden_r, S_hatstatesudden_l, O_drawbone_r, O_drawbone_l, O_otherbone_r,O_otherbone_l, O_boneossify_r, O_boneossify_l, O_ladderstate_r, O_ladderstate_l, O_drawelbow_r, O_drawelbow_l, O_tackle_r, O_tackle_l, O_cent_r, O_cent_l, O_illnesO_r, O_illnesO_l, O_average_r, O_average_l, O_hatstatesudden_r, O_hatstatesudden_l,  A_elbowsudden, A_drawudden, A_ulnasudden, A_yaosudden, annotate, num, picdate, OCD, FCP, IPA, doubtillness, boneillgrade, ED_opinion, remark, othermark ,doubtillness_b, boneillgrade_b ,oos,member  from Csvdogover where hipid = "
                                   + dbadapter.cite(hipid));
            if (dbadapter.next())
            {

                hipid = dbadapter.getString(1);
                community = dbadapter.getString(2);
                id = dbadapter.getInt(3);
                wherepics = dbadapter.getString(4);
                csvelbows = dbadapter.getInt(5);
                vetvalues = dbadapter.getInt(6);
                csvovers = dbadapter.getInt(7);
                anglechecks = dbadapter.getInt(8);
                ctalls = dbadapter.getInt(9);
                ctftlines = dbadapter.getInt(10);
                ctfws = dbadapter.getString(11);
                clwfs = dbadapter.getString(12);
                clfrogkicks = dbadapter.getInt(13);
                tbws = dbadapter.getInt(14);
                tbslightness = dbadapter.getInt(15);
                tblimitclearlys = dbadapter.getInt(16);
                tboutlineinfocus = dbadapter.getString(17);
                cjbackconcentrics = dbadapter.getInt(18);
                cjwconcentrics = dbadapter.getInt(19);
                tbcs = dbadapter.getString(20);
                DateTimes = dbadapter.getDate(21);
                S_drawbone_r = dbadapter.getString(22);
                S_drawbone_l = dbadapter.getString(23);
                S_otherbone_r = dbadapter.getString(24);
                S_otherbone_l = dbadapter.getString(25);
                S_boneossify_r = dbadapter.getString(26);
                S_boneossify_l = dbadapter.getString(27);
                S_ladderstate_r = dbadapter.getString(28);
                S_ladderstate_l = dbadapter.getString(29);
                S_drawelbow_r = dbadapter.getString(30);
                S_drawelbow_l = dbadapter.getString(31);
                S_tackle_r = dbadapter.getString(32);
                S_tackle_l = dbadapter.getString(33);
                S_cent_r = dbadapter.getString(34);
                S_cent_l = dbadapter.getString(35);
                S_illness_r = dbadapter.getString(36);
                S_illness_l = dbadapter.getString(37);
                S_average_r = dbadapter.getString(38);
                S_average_l = dbadapter.getString(39);
                S_hatstatesudden_r = dbadapter.getString(40);
                S_hatstatesudden_l = dbadapter.getString(41);
                O_drawbone_r = dbadapter.getString(42);
                O_drawbone_l = dbadapter.getString(43);
                O_otherbone_r = dbadapter.getString(44);
                O_otherbone_l = dbadapter.getString(45);
                O_boneossify_r = dbadapter.getString(46);
                O_boneossify_l = dbadapter.getString(47);
                O_ladderstate_r = dbadapter.getString(48);
                O_ladderstate_l = dbadapter.getString(49);
                O_drawelbow_r = dbadapter.getString(50);
                O_drawelbow_l = dbadapter.getString(51);
                O_tackle_r = dbadapter.getString(52);
                O_tackle_l = dbadapter.getString(53);
                O_cent_r = dbadapter.getString(54);
                O_cent_l = dbadapter.getString(55);
                O_illnesO_r = dbadapter.getString(56);
                O_illnesO_l = dbadapter.getString(57);
                O_average_r = dbadapter.getString(58);
                O_average_l = dbadapter.getString(59);
                O_hatstatesudden_r = dbadapter.getString(60);
                O_hatstatesudden_l = dbadapter.getString(61);
                A_elbowsudden = dbadapter.getString(62);
                A_drawudden = dbadapter.getString(63);
                A_ulnasudden = dbadapter.getString(64);
                A_yaosudden = dbadapter.getString(65);
                annotate = dbadapter.getString(66);
                num = dbadapter.getString(67);
                picdate = dbadapter.getDate(68);
                OCD = dbadapter.getString(69);
                FCP = dbadapter.getString(70);
                IPA = dbadapter.getString(71);
                doubtillness = dbadapter.getString(72);
                boneillgrade = dbadapter.getString(73);
                ED_opinion = dbadapter.getString(74);
                remark = dbadapter.getString(75);
                othermark = dbadapter.getString(76);
                doubtillness_b = dbadapter.getString(77);
                boneillgrade_b = dbadapter.getString(78);
                oos = dbadapter.getInt(79);
                member = dbadapter.getString(80);
                exists = true;
            }
            else
            {
                exists = false;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();

        }
    }

    public static void createCheckinfo1(String hipid, String community, int vetvalues, int csvovers, Date DateTimes, int ctalls, int ctftlines, String ctfws, String clwfs, int clfrogkicks, int tbws, int tbslightness, int tblimitclearlys, String tboutlineinfocus, int cjbackconcentrics,
                                        int cjwconcentrics, String tbcs, String wherepics, int anglechecks, String member) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();

        try
        {
            //在添加第一个表的时候id字段没有添加 id设置为自增     member 代表的是医生的id

            dbadapter.executeUpdate("insert into csvdogover(hipid,community,  vetvalues, csvovers,DateTimes,ctalls,ctftlines,ctfws, clwfs, clfrogkicks, tbws, tbslightness, tblimitclearlys, tboutlineinfocus,cjbackconcentrics,cjwconcentrics,tbcs,wherepics,anglechecks,member) values (" +
                                    dbadapter.cite(hipid) + "," + dbadapter.cite(community) + "," + vetvalues + "," + csvovers + "," + dbadapter.cite( Csvdogover.sdf.format(DateTimes)) + "," + ctalls + "," + ctftlines + "," + dbadapter.cite(ctfws) + "," + dbadapter.cite(clwfs) + "," + clfrogkicks + "," + tbws + "," +
                                    tbslightness + "," + tblimitclearlys + "," + dbadapter.cite(tboutlineinfocus) + "," + cjbackconcentrics + "," + cjwconcentrics + "," + dbadapter.cite(tbcs) + "," + dbadapter.cite(wherepics) + "," + anglechecks + "," + dbadapter.cite(member) + ")");
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }

    public void setupdateCheckinfo1(String hipid, String community, int vetvalues, int csvovers, Date DateTimes, int ctalls, int ctftlines, String ctfws, String clwfs, int clfrogkicks, int tbws, int tbslightness, int tblimitclearlys, String tboutlineinfocus, int cjbackconcentrics,
                                    int cjwconcentrics, String tbcs, String wherepics, int anglechecks) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update csvdogover set hipid=" + dbadapter.cite(hipid) + ", community=" + dbadapter.cite(community) + ", vetvalues =" + vetvalues + ",  csvovers= " + csvovers + ",  DateTimes= " + dbadapter.cite(DateTimes) + ",  ctalls=" + ctalls + ", ctftlines= " + ctftlines +
                                    ",  ctfws=" + dbadapter.cite(ctfws) + ", clwfs= " + dbadapter.cite(clwfs) + ", clfrogkicks= " + clfrogkicks + ", tbws= " + tbws + ", tbslightness= " + tbslightness + ",  tblimitclearlys= " + tblimitclearlys + ",  tboutlineinfocus = " +
                                    dbadapter.cite(tboutlineinfocus) + ", cjbackconcentrics= " + cjbackconcentrics + ", cjwconcentrics = " + cjwconcentrics + ", tbcs = " + dbadapter.cite(tbcs) + ", wherepics=" + dbadapter.cite(wherepics) + ", anglechecks=" + anglechecks + " where hipid =" +
                                    dbadapter.cite(hipid));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }

    public static void createCheckinfo2(String S_drawbone_r, String S_drawbone_l, String S_otherbone_r, String S_otherbone_l, String S_boneossify_r, String S_boneossify_l, String S_ladderstate_r, String S_ladderstate_l, String S_drawelbow_r, String S_drawelbow_l, String S_tackle_r,
                                        String S_tackle_l, String S_cent_r, String S_cent_l, String S_illness_r, String S_illness_l, String S_average_r, String S_average_l, String S_hatstatesudden_r, String S_hatstatesudden_l, String O_drawbone_r, String O_drawbone_l, String O_otherbone_r,
                                        String O_otherbone_l, String O_boneossify_r, String O_boneossify_l, String O_ladderstate_r, String O_ladderstate_l, String O_drawelbow_r, String O_drawelbow_l, String O_tackle_r, String O_tackle_l, String O_cent_r, String O_cent_l, String O_illnesO_r,
                                        String O_illnesO_l, String O_average_r, String O_average_l, String O_hatstatesudden_r, String O_hatstatesudden_l, String A_elbowsudden, String A_drawudden, String A_ulnasudden, String A_yaosudden, String annotate, String hipid, String community, String member) throws
        SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into Csvdogover (S_drawbone_r,S_drawbone_l,S_otherbone_r,S_otherbone_l,S_boneossify_r,S_boneossify_l,S_ladderstate_r,S_ladderstate_l,S_drawelbow_r,S_drawelbow_l,S_tackle_r,S_tackle_l,S_cent_r,S_cent_l,S_illness_r,S_illness_l,S_average_r,S_average_l,S_hatstatesudden_r, S_hatstatesudden_l,O_drawbone_r,O_drawbone_l,O_otherbone_r,O_otherbone_l,O_boneossify_r,O_boneossify_l,O_ladderstate_r,O_ladderstate_l,O_drawelbow_r,O_drawelbow_l,O_tackle_r,O_tackle_l,O_cent_r,O_cent_l,O_illnesO_r,O_illnesO_l,O_average_r,O_average_l,O_hatstatesudden_r, O_hatstatesudden_l,A_elbowsudden,A_drawudden,A_ulnasudden,A_yaosudden,annotate,hipid,community,member)values (" +
                                    dbadapter.cite(S_drawbone_r) + "," + dbadapter.cite(S_drawbone_l) + "," + dbadapter.cite(S_otherbone_r) + "," + dbadapter.cite(S_otherbone_l) + "," + dbadapter.cite(S_boneossify_r) + "," + dbadapter.cite(S_boneossify_l) + "," + dbadapter.cite(S_ladderstate_r) +
                                    "," + dbadapter.cite(S_ladderstate_l) + "," +
                                    dbadapter.cite(S_drawelbow_r) + "," + dbadapter.cite(S_drawelbow_l) + "," + dbadapter.cite(S_tackle_r) + "," + dbadapter.cite(S_tackle_l) + "," + dbadapter.cite(S_cent_r) + "," + dbadapter.cite(S_cent_l) + "," + dbadapter.cite(S_illness_r) + "," +
                                    dbadapter.cite(S_illness_l) + "," + dbadapter.cite(S_average_r) + "," + dbadapter.cite(S_average_l) + "," + dbadapter.cite(S_hatstatesudden_r) + "," + dbadapter.cite(S_hatstatesudden_l) + "," +
                                    dbadapter.cite(O_drawbone_r) + "," + dbadapter.cite(O_drawbone_l) + "," + dbadapter.cite(O_otherbone_r) + "," + dbadapter.cite(O_otherbone_l) + "," + dbadapter.cite(O_boneossify_r) + "," + dbadapter.cite(O_boneossify_l) + "," + dbadapter.cite(O_ladderstate_r) +
                                    "," + dbadapter.cite(O_ladderstate_l) + "," +
                                    dbadapter.cite(O_drawelbow_r) + "," + dbadapter.cite(O_drawelbow_l) + "," + dbadapter.cite(O_tackle_r) + "," + dbadapter.cite(O_tackle_l) + "," + dbadapter.cite(O_cent_r) + "," + dbadapter.cite(O_cent_l) + "," + dbadapter.cite(O_illnesO_r) + "," +
                                    dbadapter.cite(O_illnesO_l) + "," + dbadapter.cite(O_average_r) + "," +
                                    dbadapter.cite(O_average_l) + "," + dbadapter.cite(O_hatstatesudden_r) + "," + dbadapter.cite(O_hatstatesudden_l) + "," + dbadapter.cite(A_elbowsudden) + "," + dbadapter.cite(A_drawudden) + "," + dbadapter.cite(A_ulnasudden) + "," + dbadapter.cite(A_yaosudden) +
                                    "," + dbadapter.cite(annotate) + "," +
                                    dbadapter.cite(hipid) + "," + dbadapter.cite(community) + "," + dbadapter.cite(member) + ")");

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }

    public void setupdateCheckinfo2(String S_drawbone_r, String S_drawbone_l, String S_otherbone_r, String S_otherbone_l, String S_boneossify_r, String S_boneossify_l, String S_ladderstate_r, String S_ladderstate_l, String S_drawelbow_r, String S_drawelbow_l, String S_tackle_r, String S_tackle_l,
                                    String S_cent_r, String S_cent_l, String S_illness_r, String S_illness_l, String S_average_r, String S_average_l, String S_hatstatesudden_r, String S_hatstatesudden_l, String O_drawbone_r, String O_drawbone_l, String O_otherbone_r, String O_otherbone_l,
                                    String O_boneossify_r, String O_boneossify_l, String O_ladderstate_r, String O_ladderstate_l, String O_drawelbow_r, String O_drawelbow_l, String O_tackle_r, String O_tackle_l, String O_cent_r, String O_cent_l, String O_illnesO_r, String O_illnesO_l,
                                    String O_average_r, String O_average_l, String O_hatstatesudden_r, String O_hatstatesudden_l, String A_elbowsudden, String A_drawudden, String A_ulnasudden, String A_yaosudden, String annotate, String hipid) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update Csvdogover set S_drawbone_r = " + dbadapter.cite(S_drawbone_r
                                    ) + ",S_drawbone_l = " + dbadapter.cite(S_drawbone_l
                                    ) + ",S_otherbone_r = " + dbadapter.cite(S_otherbone_r
                                    ) + ",S_otherbone_l = " + dbadapter.cite(S_otherbone_l
                                    ) + ",S_boneossify_r = " + dbadapter.cite(S_boneossify_r
                                    ) + ",S_boneossify_l = " + dbadapter.cite(S_boneossify_l
                                    ) + ",S_ladderstate_r = " + dbadapter.cite(S_ladderstate_r
                                    ) + ",S_ladderstate_l = " + dbadapter.cite(S_ladderstate_l
                                    ) + ",S_drawelbow_r = " + dbadapter.cite(S_drawelbow_r
                                    ) + ",S_drawelbow_l = " + dbadapter.cite(S_drawelbow_l
                                    ) + ",S_tackle_r = " + dbadapter.cite(S_tackle_r
                                    ) + ",S_tackle_l = " + dbadapter.cite(S_tackle_l
                                    ) + ",S_cent_r = " + dbadapter.cite(S_cent_r
                                    ) + ",S_cent_l = " + dbadapter.cite(S_cent_l
                                    ) + ",S_illness_r = " + dbadapter.cite(S_illness_r
                                    ) + ",S_illness_l = " + dbadapter.cite(S_illness_l
                                    ) + ",S_average_r = " + dbadapter.cite(S_average_r
                                    ) + ",S_average_l = " + dbadapter.cite(S_average_l
                                    ) + ",S_hatstatesudden_r = " + dbadapter.cite(S_hatstatesudden_r
                                    ) + ",S_hatstatesudden_l = " + dbadapter.cite(S_hatstatesudden_l
                                    ) + ",O_drawbone_r = " + dbadapter.cite(O_drawbone_r
                                    ) + ",O_drawbone_l = " + dbadapter.cite(O_drawbone_l
                                    ) + ",O_otherbone_r = " + dbadapter.cite(O_otherbone_r
                                    ) + ",O_otherbone_l = " + dbadapter.cite(O_otherbone_l
                                    ) + ",O_boneossify_r = " + dbadapter.cite(O_boneossify_r
                                    ) + ",O_boneossify_l = " + dbadapter.cite(O_boneossify_l
                                    ) + ",O_ladderstate_r = " + dbadapter.cite(O_ladderstate_r
                                    ) + ",O_ladderstate_l = " + dbadapter.cite(O_ladderstate_l
                                    ) + ",O_drawelbow_r = " + dbadapter.cite(O_drawelbow_r
                                    ) + ",O_drawelbow_l = " + dbadapter.cite(O_drawelbow_l
                                    ) + ",O_tackle_r = " + dbadapter.cite(O_tackle_r
                                    ) + ",O_tackle_l = " + dbadapter.cite(O_tackle_l
                                    ) + ",O_cent_r = " + dbadapter.cite(O_cent_r
                                    ) + ",O_cent_l = " + dbadapter.cite(O_cent_l
                                    ) + ",O_illnesO_r = " + dbadapter.cite(O_illnesO_r
                                    ) + ",O_illnesO_l = " + dbadapter.cite(O_illnesO_l
                                    ) + ",O_average_r = " + dbadapter.cite(O_average_r
                                    ) + ",O_average_l = " + dbadapter.cite(O_average_l
                                    ) + ",O_hatstatesudden_r = " + dbadapter.cite(O_hatstatesudden_r
                                    ) + ",O_hatstatesudden_l = " + dbadapter.cite(O_hatstatesudden_l
                                    ) + ",A_elbowsudden = " + dbadapter.cite(A_elbowsudden
                                    ) + ",A_drawudden = " + dbadapter.cite(A_drawudden
                                    ) + ",A_ulnasudden = " + dbadapter.cite(A_ulnasudden
                                    ) + ",A_yaosudden = " + dbadapter.cite(A_yaosudden
                                    ) + ",annotate = " + dbadapter.cite(annotate) + "  where hipid =" + dbadapter.cite(hipid)
                );

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }

    }

    public static void createCheckinfo3(String num, Date picdate, String OCD, String FCP, String IPA, String doubtillness, String boneillgrade, String ED_opinion, String remark, String othermark, String hipid, String community, int csvelbows, String doubtillness_b, String boneillgrade_b, int oos,
                                        String member) throws SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("insert into Csvdogover(num,picdate,OCD,FCP,IPA,doubtillness,boneillgrade,ED_opinion,remark,othermark,hipid,community,csvelbows,doubtillness_b,boneillgrade_b,oos,member) values (" + dbadapter.cite(num) + "," +
                                    dbadapter.cite(picdate) + "," +
                                    dbadapter.cite(OCD) + "," +
                                    dbadapter.cite(FCP) + "," +
                                    dbadapter.cite(IPA) + "," +
                                    dbadapter.cite(doubtillness) + "," +
                                    dbadapter.cite(boneillgrade) + "," +
                                    dbadapter.cite(ED_opinion) + "," +
                                    dbadapter.cite(remark) + "," +
                                    dbadapter.cite(othermark) + "," +
                                    dbadapter.cite(hipid) + "," +
                                    dbadapter.cite(community) + "," +
                                    csvelbows + "," + dbadapter.cite(doubtillness_b) + "," + dbadapter.cite(boneillgrade_b) + "," + oos + "," + dbadapter.cite(member) + ")");

        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    public static void setupdateCheckinfo3(String num, Date picdate, String OCD, String FCP, String IPA, String doubtillness, String boneillgrade, String ED_opinion, String remark, String othermark, String hipid, int csvelbows, String doubtillness_b, String boneillgrade_b, int oos) throws
        SQLException
    {
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeUpdate("update csvdogover set num =" + dbadapter.cite(num) + ",picdate =" + dbadapter.cite(picdate) +
                                    ",OCD =" + dbadapter.cite(OCD) +
                                    ",FCP =" + dbadapter.cite(FCP) +
                                    ",IPA =" + dbadapter.cite(IPA) +
                                    ",doubtillness =" + dbadapter.cite(doubtillness) +
                                    ",boneillgrade =" + dbadapter.cite(boneillgrade) +
                                    ",ED_opinion =" + dbadapter.cite(ED_opinion) +
                                    ",remark=" + dbadapter.cite(remark) +
                                    ",othermark=" + dbadapter.cite(othermark) +
                                    ",csvelbows=" + csvelbows + ",doubtillness_b = " + dbadapter.cite(doubtillness_b) + ",boneillgrade_b =" + dbadapter.cite(boneillgrade_b) + ",oos = " + oos +
                                    "   where hipid =" + dbadapter.cite(hipid));
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        } finally
        {
            dbadapter.close();
        }
    }

    /*****添加的方法是  通过传入的hipid号 来判断数据库中是否有这个字段 *********/
    public static boolean gethipboolean(String hipid) throws SQLException
    {
        DbAdapter dbadpter = new DbAdapter();
        try
        {
            dbadpter.executeQuery("select * from csvdogover where hipid=" + dbadpter.cite(hipid));
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

    //	带分页的取回hipid方法
    public static java.util.Enumeration findhipByCommunity(String community, String sql, int pos, int size) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            dbadapter.executeQuery("SELECT hipid FROM Csvdogover WHERE community=" + DbAdapter.cite(community) + sql);
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

    public static int counthipByCommunity(String community, String sql) throws SQLException
    {
        int i = 0;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            i = dbadapter.getInt("SELECT count(hipid) FROM Csvdogover WHERE community=" + dbadapter.cite(community) + sql);

        } finally
        {
            dbadapter.close();
        }
        return i;
    }


    //通过hipid返回髋诊断结果。
    public static String Csvgethipover(String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select csvovers from csvdogover where hipid =" + dbadapter.cite(hipid));

        } catch (Exception ex1)
        {
            throw new SQLException(ex1.toString());
        } finally
        {
            dbadapter.close();

        }

        return str;
    }


    //通过hipid返回肘诊断结果
    public static String Csvgetelbowover(String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select csvelbows from csvdogover where hipid =" + dbadapter.cite(hipid));

        } catch (Exception ex1)
        {
            throw new SQLException(ex1.toString());
        } finally
        {
            dbadapter.close();

        }

        return str;
    }


    //通过hipid返回鉴定日期
    public static String Csvgethipdate(String hipid) throws SQLException
    {
        String str = null;
        DbAdapter dbadapter = new DbAdapter();
        try
        {
            str = dbadapter.getString("select DateTimes from csvdogover where hipid =" + dbadapter.cite(hipid));

        } catch (Exception ex1)
        {
            throw new SQLException(ex1.toString());
        } finally
        {
            dbadapter.close();

        }

        return str;
    }

    /*****************修改分界线 在2007-8-07号 重新修改的方法*************************/
    ///////////////////////////////////////////////
    //第一个表单 修改时候的 显示方法。 单选
    public static String Csvradio(int getnum, int values)
    {
        if (getnum == values)
        {
            return "checked";
        } else
        {
            return "";
        }
    }

    //第一个表单 修改时候的 显示方法。 复选

    public static String Csvcheckbox(String str, int values, String hipid)
    {
        boolean falg = false;

        try
        {
            falg = Csvdogover.gethipboolean(hipid);
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


    public int getAnglechecks()
    {
        return anglechecks;
    }

    public int getCsvovers()
    {
        return csvovers;
    }

    public int getVetvalues()
    {
        return vetvalues;
    }

    public String getWherepics()
    {
        return wherepics;
    }

    public String getHipid()
    {
        return hipid;
    }

    public int getId()
    {
        return id;
    }

    public String getCommunity()
    {
        return community;
    }

    public String getAnnotate()
    {
        return annotate;
    }

    public String getBoneillgrade()
    {
        return boneillgrade;
    }

    public String getDoubtillness()
    {
        return doubtillness;
    }

    public String getNum()
    {
        return num;
    }

    public String getOthermark()
    {
        return othermark;
    }

    public Date getPicdate()
    {
        return picdate;
    }

    public String getRemark()
    {
        return remark;
    }

    public int getTbws()
    {
        return tbws;
    }

    public int getTbslightness()
    {
        return tbslightness;
    }

    public String getTboutlineinfocus()
    {
        return tboutlineinfocus;
    }

    public int getTblimitclearlys()
    {
        return tblimitclearlys;
    }

    public String getTbcs()
    {
        return tbcs;
    }

    public String getCtfws()
    {
        return ctfws;
    }

    public int getCtftlines()
    {
        return ctftlines;
    }

    public int getCtalls()
    {
        return ctalls;
    }

    public int getCjbackconcentrics()
    {
        return cjbackconcentrics;
    }

    public int getCjwconcentrics()
    {
        return cjwconcentrics;
    }

    public int getClfrogkicks()
    {
        return clfrogkicks;
    }

    public String getClwfs()
    {
        return clwfs;
    }

    public String getMember()
    {
        return member;
    }

    public String getO_boneossify_l()
    {
        return O_boneossify_l;
    }

    public String getO_boneossify_r()
    {
        return O_boneossify_r;
    }

    public String getA_drawudden()
    {
        return A_drawudden;
    }

    public Date getDateTimes()
    {
        return DateTimes;
    }

    public String getS_tackle_r()
    {
        return S_tackle_r;
    }

    public String getS_tackle_l()
    {
        return S_tackle_l;
    }

    public String getS_otherbone_r()
    {
        return S_otherbone_r;
    }

    public String getS_otherbone_l()
    {
        return S_otherbone_l;
    }

    public String getS_ladderstate_r()
    {
        return S_ladderstate_r;
    }

    public String getS_ladderstate_l()
    {
        return S_ladderstate_l;
    }

    public String getS_illness_r()
    {
        return S_illness_r;
    }

    public String getS_illness_l()
    {
        return S_illness_l;
    }

    public String getS_hatstatesudden_r()
    {
        return S_hatstatesudden_r;
    }

    public String getS_hatstatesudden_l()
    {
        return S_hatstatesudden_l;
    }

    public String getS_drawelbow_r()
    {
        return S_drawelbow_r;
    }

    public String getS_drawelbow_l()
    {
        return S_drawelbow_l;
    }

    public String getS_drawbone_r()
    {
        return S_drawbone_r;
    }

    public String getS_drawbone_l()
    {
        return S_drawbone_l;
    }

    public String getS_cent_r()
    {
        return S_cent_r;
    }

    public String getS_cent_l()
    {
        return S_cent_l;
    }

    public String getS_boneossify_r()
    {
        return S_boneossify_r;
    }

    public String getS_boneossify_l()
    {
        return S_boneossify_l;
    }

    public String getS_average_r()
    {
        return S_average_r;
    }

    public String getS_average_l()
    {
        return S_average_l;
    }

    public String getOCD()
    {
        return OCD;
    }

    public String getO_tackle_r()
    {
        return O_tackle_r;
    }

    public String getO_tackle_l()
    {
        return O_tackle_l;
    }

    public String getO_otherbone_r()
    {
        return O_otherbone_r;
    }

    public String getO_otherbone_l()
    {
        return O_otherbone_l;
    }

    public String getO_illnesO_r()
    {
        return O_illnesO_r;
    }

    public String getO_ladderstate_r()
    {
        return O_ladderstate_r;
    }

    public String getO_ladderstate_l()
    {
        return O_ladderstate_l;
    }

    public String getO_illnesO_l()
    {
        return O_illnesO_l;
    }

    public String getO_hatstatesudden_r()
    {
        return O_hatstatesudden_r;
    }

    public String getO_hatstatesudden_l()
    {
        return O_hatstatesudden_l;
    }

    public String getO_drawelbow_r()
    {
        return O_drawelbow_r;
    }

    public String getO_drawelbow_l()
    {
        return O_drawelbow_l;
    }

    public String getO_drawbone_r()
    {
        return O_drawbone_r;
    }

    public String getO_drawbone_l()
    {
        return O_drawbone_l;
    }

    public String getO_cent_r()
    {
        return O_cent_r;
    }

    public String getO_cent_l()
    {
        return O_cent_l;
    }

    public String getO_average_r()
    {
        return O_average_r;
    }

    public String getO_average_l()
    {
        return O_average_l;
    }

    public String getIPA()
    {
        return IPA;
    }

    public String getFCP()
    {
        return FCP;
    }

    public String getED_opinion()
    {
        return ED_opinion;
    }

    public String getA_yaosudden()
    {
        return A_yaosudden;
    }

    public String getA_ulnasudden()
    {
        return A_ulnasudden;
    }

    public String getA_elbowsudden()
    {
        return A_elbowsudden;
    }

    public String getTBW_pinelt()
    {
        return TBW_pinelt;
    }

    public String getTBW_pine()
    {
        return TBW_pine;
    }

    public String getTBW_dark()
    {
        return TBW_dark;
    }

    public String getTBC_W_sidelt()
    {
        return TBC_W_sidelt;
    }

    public String getTBC_W_inner()
    {
        return TBC_W_inner;
    }

    public String getTBC_W_side()
    {
        return TBC_W_side;
    }

    public String getTB_slightness()
    {
        return TB_slightness;
    }

    public String getTB_settlelt()
    {
        return TB_settlelt;
    }

    public String getTB_settle()
    {
        return TB_settle;
    }

    public String getTB_rubrootlt()
    {
        return TB_rubrootlt;
    }

    public String getTB_rubroot()
    {
        return TB_rubroot;
    }

    public String getTB_outlineinfocus()
    {
        return TB_outlineinfocus;
    }

    public String getTB_limitclearly()
    {
        return TB_limitclearly;
    }

    public String getTB_inadequatelt()
    {
        return TB_inadequatelt;
    }

    public String getTB_inadequate()
    {
        return TB_inadequate;
    }

    public String getTB_columnlt()
    {
        return TB_columnlt;
    }

    public String getTB_column()
    {
        return TB_column;
    }

    public String getCT_FW_passivation()
    {
        return CT_FW_passivation;
    }

    public String getCT_FW_bonescjlt()
    {
        return CT_FW_bonescjlt;
    }

    public String getCT_FW_bonescj()
    {
        return CT_FW_bonescj;
    }

    public String getCT_FW_alloverlt()
    {
        return CT_FW_alloverlt;
    }

    public String getCT_FW_allover()
    {
        return CT_FW_allover;
    }

    public String getCT_FTline_linear()
    {
        return CT_FTline_linear;
    }

    public String getCT_FTline_boneslt()
    {
        return CT_FTline_boneslt;
    }

    public String getCT_FTline_bones()
    {
        return CT_FTline_bones;
    }

    public String getCT_all_place()
    {
        return CT_all_place;
    }

    public String getCT_all_flatnesslt()
    {
        return CT_all_flatnesslt;
    }

    public String getCT_all_flatness()
    {
        return CT_all_flatness;
    }

    public String getCL_WF_YLZZSlt()
    {
        return CL_WF_YLZZSlt;
    }

    public String getCL_WF_YLZZS()
    {
        return CL_WF_YLZZS;
    }

    public String getCL_WF_smalllt()
    {
        return CL_WF_smalllt;
    }

    public String getCL_WF_small()
    {
        return CL_WF_small;
    }

    public String getCL_WF_roundness()
    {
        return CL_WF_roundness;
    }

    public String getCL_WF_catfacelt()
    {
        return CL_WF_catfacelt;
    }

    public String getCL_WF_catface()
    {
        return CL_WF_catface;
    }

    public String getCL_frogkick_liphyperplasialt()
    {
        return CL_frogkick_liphyperplasialt;
    }

    public String getCL_frogkick_liphyperplasia()
    {
        return CL_frogkick_liphyperplasia;
    }

    public String getCL_frogkick()
    {
        return CL_frogkick;
    }

    public String getCJ_notconcentric()
    {
        return CJ_notconcentric;
    }

    public String getCJ_extendback_notconcentriclt()
    {
        return CJ_extendback_notconcentriclt;
    }

    public String getCJ_extendback_notconcentric()
    {
        return CJ_extendback_notconcentric;
    }

    public String getCJ_extendback_concentric()
    {
        return CJ_extendback_concentric;
    }

    public String getCJ_notconcentriclt()
    {
        return CJ_notconcentriclt;
    }

    public String getPicdateToString()
    {
        if (picdate == null)
            return "";
        return sdf.format(picdate);
    }

    public String getCJ_concentric()
    {

        return CJ_concentric;
    }

    public int getCsvelbows()
    {
        return csvelbows;
    }

    public int getOos()
    {
        return oos;
    }

    public String getBoneillgrade_b()
    {
        return boneillgrade_b;
    }

    public String getDoubtillness_b()
    {
        return doubtillness_b;
    }

    public boolean isExists()
    {
        return exists;
    }

}
