package tea.entity.node;

import java.sql.*;
import java.util.*;
import java.util.Date;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import java.util.regex.Pattern;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import tea.entity.member.Logs;
import java.util.regex.Matcher;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

public class Logo extends Entity
{
    private static Cache _cache = new Cache(2000);
    private Hashtable _htLayer;
    private int node;
    private int logoid;
    private int language;
    private String logotype; //商标类
    private String logoname; //商标名称
    private String logoimage; //商标图形
    private String logouse; //核定使用商标
    private String regnum; //注册号
    private String logointroduce; //介绍
    private Date regdate; //注册时间
    private String community;
    private boolean exists;

    public static final String[] LOGO_TYPE =
                                             {
                                             "",
                                             "第1类：化学制品",
                                             "第2类：颜料，染料和防腐制品",
                                             "第3类：洗涤用品，化妆品",
                                             "第4类：工业用油脂，燃料和照明材料",
                                             "第5类：药品",
                                             "第6类：普通金属及其制品",
                                             "第7类：机器、机床、发动机",
                                             "第8类：手工用具和器械",
                                             "第9类：科研仪器及器械",
                                             "第10类：医疗仪器、器械及用品",
                                             "第11类：照明、加温、冷藏、干燥、通风、供水及卫生设备装置",
                                             "第12类：车辆，陆、空、海用运载器",
                                             "第13类：火器，军火，爆炸物，焰火",
                                             "第14类：贵重金属、珠宝、首饰和钟表",
                                             "第15类：机械钢琴及其附件，八音盒，电动和电子乐器",
                                             "第16类：纸，办公用品",
                                             "第17类：电绝缘，隔热或隔音材料",
                                             "第18类：皮革，人造皮革",
                                             "第19类：非金属建筑材料",
                                             "第20类：家具及其部件不属别类的塑料制品",
                                             "第21类：小件手工操作器具、玻璃器皿、瓷器",
                                             "第22类：绳缆及帆篷制品，纺织用纤维原料",
                                             "第23类：纺织用纱、线",
                                             "第24类：不属别类的布料及纺织品",
                                             "第25类：服装，鞋，帽",
                                             "第26类：缝纫用品和饰带品",
                                             "第27类：铺地板或装饰墙壁制品",
                                             "第28类：运动及文体娱乐器械",
                                             "第29类：肉类食品，蔬菜，园艺食品",
                                             "第30类：日用或贮藏用的来自植物内的食品，及调味佐料",
                                             "第31类：田地产物，牲畜及植物，及动物饲料",
                                             "第32类：不含酒精的饮料及啤酒",
                                             "第33类：含酒精的饮料（啤酒除外）",
                                             "第34类：烟草，烟具，火柴",
                                             "第35类：广告、实业经营，实业管理，办公事务",
                                             "第36类：保险，金融，货币事务，不动产事务",
                                             "第37类：房屋建筑，修理，安装服务",
                                             "第38类：电信",
                                             "第29类：运输，商品包装和贮藏，旅行安排",
                                             "第40类：材料处理",
                                             "第41类：教育，提供培训，娱乐，文体活动",
                                             "第42类：科学技术研究与服务，计算机硬件与软件的设计与开发，法律服务",
                                             "第43类：提供食物和饮料服务；临时住宿",
                                             "第44类：医疗、卫生和美容服务",
                                             "第45类：为保护财产和人身安全的服务"
    };

    public static final String[] LOGO_CONTENT =
                                                {
                                                "用于工业、科学、摄影、农业、园艺、森林的化学品，未加工人造合成树脂，未加工塑料物质，肥料，灭火用合成物，淬火和金属焊接用制剂，保存食品用化学品，鞣料，工业粘合剂。",
                                                "颜料，清漆，漆，防锈剂和木材防腐剂，着色剂，媒染剂，未加工的天然树脂，画家、装饰家、印刷商和艺术家用金属箔及金属粉 。",
                                                "洗衣用漂白剂及其他物料，清洁、擦亮、去渍及研磨用制剂，肥皂，香料，香精油，化妆品，发水，牙膏。",
                                                "工业用油及油脂，润滑剂，吸收、喷洒和粘结灰尘用品，燃料（包括马达用的汽油）和照明材料，蜡烛，灯芯。",
                                                "药品，兽药及卫生用品，医用营养品，婴儿食品，膏药，绷敷材料，填塞牙孔和牙模用料，消毒剂，消灭有害动物制剂，杀真菌剂，除莠剂。",
                                                "普通金属及其合金，金属建筑材料，可移动金属建筑物，铁轨用金属材料，非电气用缆索和金属线，小五金具，金属官，保险箱，不属别类的普通金属制品，矿砂。",
                                                "机器和机床，马达和发动机（陆地车辆用的除外），机器传动用联轴节和传动机件（陆地车辆用的除外），非手动农业工具，孵化器。",
                                                "手工用具和器械（手工操作的），刀、叉和勺餐具，佩刀，剃刀。",
                                                "科学、航海、测地、电气、摄影、电影、光学、衡具、量具、信号、检验（监督）、救护（营救）和教学用具及仪器，录制、通讯、重放声音和形象的器具，磁性数据载体，录音盘，自动售货器和投币启动装置的机械结构，现金收入记录机，计算机和数据处理装置，灭火器械。",
                                                "外科、医疗、牙科和兽医用仪器及器械，假肢，假眼和假牙，矫形用品，缝合用材料。",
                                                "照明、加温、蒸汽、烹调、冷藏、干燥、通风、供水以及卫生设备装置。",
                                                "车辆，陆、空、海用运载器。",
                                                "火器，军火及子弹，爆炸物，烟火。",
                                                "贵重金属及其合金以及不属别类的贵重金属制品或镀有贵重金属的物品，珠宝，首饰，宝石，钟表和计时器。",
                                                "乐器。 ",
                                                "不属别类的纸、纸板及其制品，印刷品，装订用品，照片，文具用品，文具或家庭用粘合剂，美术用品，画笔，打字机和办公用品（家具除外），教育或教学用品（仪器除外），包装用塑料物品（不属别类的），纸牌，印刷铅字，印版。 ",
                                                "不属别类的橡胶，古塔胶，树胶，石棉，云母以及这些原材料的制品，生产用半成品塑料制品，包装、填充和绝缘用材料,非金属软管。",
                                                "皮革及人造皮革，不属别类的皮革及人造皮革制品，毛皮，箱子及旅行袋，雨伞，阳伞以及手杖，鞍和马具。 ",
                                                "非金属的建筑材料，建筑用非金属刚性管，沥青，柏油，可移动非金属建筑物，非金属碑。",
                                                "家具，玻璃镜子，镜框，不属别类的木、软木、苇、藤、柳条、角、骨、象牙、鲸骨、贝壳、瑚珀、珍珠母、海泡石制品，这些材料的代用品或塑料制品。",
                                                "家庭或 、厨房用具及容器（非贵重金属所制，也非镀有贵重金属的），梳子及海绵，刷子（画笔除外），制刷材料，清扫用具，钢丝绒，未加工或半加工玻璃（ 建筑用玻璃除外），不属别类的玻璃器皿，瓷器及陶器 。",
                                                "缆，绳，网，遮蓬，帐篷，防水遮布，帆，袋（不属别类的），衬垫及填充料（橡胶或塑料除外），纺织用纤维原料。",
                                                "纺织用纱、线。",
                                                "不属别类的布料及纺织品，床单和桌布。",
                                                "服装，鞋，帽。",
                                                "花边及刺绣，饰带及编带，纽扣，领钩扣，饰针及缝针，假花。",
                                                "地毯，地席，席类，油毡及其他铺地板用品，非纺织品墙帷。",
                                                "娱乐品，玩具，不属别类的体育及运动用品，圣诞树用装饰品。",
                                                "肉，鱼，家禽及野味，肉汁，腌渍、干制及煮熟的水果和蔬菜，果冻，果酱水果沙司，蛋，奶及乳制品，食用油和油脂。",
                                                "咖啡，茶，可可，糖，米，食用淀粉，西米，咖啡代用品，面粉及谷类制品面包，糕点及糖果，冰制食品，蜂蜜，糖浆，鲜酵母，发酵粉，食盐，芥末，醋，沙司。",
                                                "农业、园艺、林业产品及不属别类的谷物，牲畜，新鲜水果和蔬菜，种籽，草木及花卉，动物饲料，麦芽。",
                                                "啤酒，矿泉水和汽水以及其他不含酒精的饮料，水果饮料及果汁，糖浆及其他供饮料用的制剂。",
                                                "含酒精用的饮料（啤酒除外）。	",
                                                "烟草，烟具，火柴。",
                                                "广告，实业经营，实业管理，办公事务。",
                                                "保险，金融，货币事务，不动产事务。",
                                                "房屋建筑，修理，安装服务。",
                                                "电信。",
                                                "运输，商品包装和贮藏，旅行安排。",
                                                "材料处理。",
                                                "教育，提供培训，娱乐，文体活动。",
                                                "科学技术服务和与这相关的研究与设计服务；工业分析与研究；计算机硬件与软件的设计与开发；法律服务。",
                                                "提供食物与饮料服务；临时住宿。",
                                                "医疗服务；兽医服务；人或动物的卫生和美容服务；农业、园艺或林业服务。 ",
                                                "由他人提供的为满足个人需要的私人和社会服务；为保护财产和人身安全的服务。"
    };

    public static Logo find(int node) throws SQLException
    {
        Logo obj = (Logo) _cache.get(new Integer(node));
        if(obj == null)
        {
            obj = new Logo(node);
            _cache.put(new Integer(node),obj);
        }
        return obj;
    }

    public Logo(int node) throws SQLException
    {
        this.node = node;
        _htLayer = new Hashtable();
        load();
    }

    public Logo()
    {
        _htLayer = new Hashtable();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language,logotype,logoname,logoimage,logouse,regnum,logointroduce,regdate,community FROM Logo WHERE node=" + node);
            if(db.next())
            {
                language = db.getInt(1);
                logotype = db.getString(2);
                logoname = db.getString(3);
                logoimage = db.getString(4);
                logouse = db.getString(5);
                regnum = db.getString(6);
                logointroduce = db.getString(7);
                regdate = db.getDate(8);
                community = db.getString(9);
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

    public void set(String logotype,String logoimage,String logouse,String regnum,Date regdate) throws SQLException //去掉了name和简介  name和简介存放于nodeLayer表中
    {
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("UPDATE Logo SET logotype=" + DbAdapter.cite(logotype) + ",logoimage="
                             + DbAdapter.cite(logoimage) + ",logouse=" + DbAdapter.cite(logouse) + ",regnum="
                             + DbAdapter.cite(regnum) + ",regdate=" + DbAdapter.cite(regdate) + "WHERE node=" + node);

        } finally
        {
            db.close();
        }
        this.logotype = logotype;
        this.logoimage = logoimage;
        this.logouse = logouse;
        this.regnum = regnum;
        this.regdate = regdate;
        _htLayer.clear();
    }

    public void set(String community,int language,String logotype,String logoname,String logoimage,String logouse,String regnum,String logointroduce,Date regdate) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE Logo SET logotype=" + DbAdapter.cite(logotype) + ",logoname=" + DbAdapter.cite(logoname) + ",logoimage=" + DbAdapter.cite(logoimage) + ",logouse=" + DbAdapter.cite(logouse) + ",regnum=" + DbAdapter.cite(regnum) + ",logointroduce=" + DbAdapter.cite(logointroduce) + ",regdate=" + DbAdapter.cite(regdate) + "WHERE node=" + logoid);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO Logo(community,language,logotype,logoname,logoimage,logouse,regnum,logointroduce,regdate)values(" + DbAdapter.cite(community) + "," + language + "," + DbAdapter.cite(logotype) + "," + DbAdapter.cite(logoname) + "," + DbAdapter.cite(logoimage) + "," + DbAdapter.cite(logouse) + "," + DbAdapter.cite(regnum) + "," + DbAdapter.cite(logointroduce) + "," + DbAdapter.cite(regdate) + ")");
            }
        } finally
        {
            db.close();
        }
        this.logotype = logotype;
        this.logoname = logoname;
        this.logoimage = logoimage;
        this.logouse = logouse;
        this.regnum = regnum;
        this.logointroduce = logointroduce;
        this.regdate = regdate;

        this.exists = true;
        _htLayer.clear();
    }

    public static void create(int node,String logotype,String logoimage,String logouse,String regnum,Date regdate,String community) throws SQLException //去掉了name和简介  name和简介存放于nodeLayer表中
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Logo(node,logotype,logoimage,logouse,regnum,regdate,community)"
                             + " VALUES(" + node + "," + db.cite(logotype) + "," + db.cite(logoimage) + "," + db.cite(logouse) + "," + db.cite(regnum) + "," + db.cite(regdate) + "," + db.cite(community) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(node));
    }

//	public static void create(int node,String community,int language,String logotype,String logoname,String logoimage,String logouse,String regnum,String logointroduce,Date regdate) throws SQLException
//	{
//		DbAdapter db = new DbAdapter();
//		try
//		{
//			db.executeUpdate("INSERT INTO Logo(node,community,language,logotype,logoname,logoimage,logouse,regnum,logointroduce,regdate)values("+node+","+DbAdapter.cite(community)+","+language+","+DbAdapter.cite(logotype)+","+DbAdapter.cite(logoname)+","+DbAdapter.cite(logoimage)+","+DbAdapter.cite(logouse)+","+DbAdapter.cite(regnum)+","+DbAdapter.cite(logointroduce)+","+DbAdapter.cite(regdate)+")");
//		} finally
//		{
//			db.close();
//		}
//		//_cache.remove(new Integer(logoid));
//	}
    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(" DELETE FROM Logo WHERE node=" + node);
        } finally
        {
            db.close();
        }
    }

    //过滤字符
    public static String getHtml(String htmlStr) throws SQLException
    {
        String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; //定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script> }
        java.util.regex.Matcher m_script;
        java.util.regex.Pattern p_script = java.util.regex.Pattern.compile(regEx_script,java.util.regex.Pattern.CASE_INSENSITIVE);

        m_script = p_script.matcher(htmlStr);
        htmlStr = m_script.replaceAll(""); //过滤script标签

        return htmlStr;
    }

    public static Enumeration findAllLogo(int _nLanguage,String community) throws SQLException
    {

        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        String sql = "SELECT * FROM Logo WHERE language = " + _nLanguage + " and community = " + DbAdapter.cite(community);
        try
        {
            db.executeQuery(sql);
            Logo obj = null;
            while(db.next())
            {
                obj = new Logo();
                obj.logoid = db.getInt(1);
                obj.language = db.getInt(2);
                obj.logotype = db.getString(3);
                obj.logoname = db.getString(4);
                obj.logoimage = db.getString(5);
                obj.community = db.getString(6);
                obj.logouse = db.getString(7);
                obj.regnum = db.getString(8);
                obj.logointroduce = db.getString(9);
                obj.regdate = db.getDate(10);

                vector.addElement(obj);
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration findAllLogo(int _nLanguage,String community,int pos,int size) throws SQLException
    {

        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        String sql = "SELECT * FROM Logo WHERE language = " + _nLanguage + " and community = " + DbAdapter.cite(community);
        try
        {
            db.executeQuery(sql,pos,size);
            Logo obj = null;
            while(db.next())
            {
                obj = new Logo();
                obj.logoid = db.getInt(1);
                obj.language = db.getInt(2);
                obj.logotype = db.getString(3);
                obj.logoname = db.getString(4);
                obj.logoimage = db.getString(5);
                obj.community = db.getString(6);
                obj.logouse = db.getString(7);
                obj.regnum = db.getString(8);
                obj.logointroduce = db.getString(9);
                obj.regdate = db.getDate(10);

                vector.addElement(obj);
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    public static Enumeration findByLogo(Logo logo,int _nLanguage,Date dstart,Date dend) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT * FROM Logo WHERE 1= 1 ");
        sb.append(" AND language = ").append(_nLanguage);
        if(logo.getLogotype() != null && !logo.getLogotype().equals(""))
            sb.append(" AND Logotype = ").append(DbAdapter.cite(logo.getLogotype()));
        if(logo.getLogoname() != null && !logo.getLogoname().equals(""))
            sb.append(" AND Logoname = ").append(DbAdapter.cite(logo.getLogoname()));
        if(logo.getRegnum() != null && !logo.getRegnum().equals(""))
            sb.append(" AND regnum = ").append(DbAdapter.cite(logo.getRegnum()));
        if(dstart != null && !dstart.equals(""))
            sb.append(" AND regdate > ").append(DbAdapter.cite(dstart));
        if(dend != null && !dend.equals(""))
            sb.append(" AND regdate < ").append(DbAdapter.cite(dend));
        Logo obj = new Logo();
        try
        {
            db.executeQuery(sb.toString());
            while(db.next())
            {
                obj = new Logo();
                obj.logoid = db.getInt(1);
                obj.language = db.getInt(2);
                obj.logotype = db.getString(3);
                obj.logoname = db.getString(4);
                obj.logoimage = db.getString(5);
                obj.community = db.getString(6);
                obj.logouse = db.getString(7);
                obj.regnum = db.getString(8);
                obj.logointroduce = db.getString(9);
                obj.regdate = db.getDate(10);

                vector.addElement(obj);
            }
        } finally
        {
            db.close();
        }

        return vector.elements();
    }

    public static java.util.Enumeration find(String community,String sql,int pos,int size) throws SQLException //常用
    {
        java.util.Vector v = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT Logo.node FROM Logo,NodeLayer WHERE Logo.node = NodeLayer.node AND community =  " + db.cite(community) + sql + " ORDER BY Logo.node DESC",pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Logo,NodeLayer WHERE Logo.node = NodeLayer.node AND community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }

        return i;
    }

    public void change() throws SQLException
    { //集佳导入 更改图片路径
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        String sql = "select id,logoimage from sheet1$";
        db.executeQuery(sql);
        try
        {
            db.executeQuery(sql);
            while(db.next())
            {
                int id = db.getInt(1);
                String li = db.getString(2);
                String sql2 = "update sheet1$ set logoimage = " + db.cite("/res/unitalen/1007/tuxin/" + li) + " where id=" + id;
                db2.execute(sql2);
            }
        } finally
        {
            db.close();
            db2.close();
        }
    }

    public ArrayList getAll()
    { //集佳导入 获取临时表数据
        String sql = "select logotype,logoname,logoimage,logouse,regnum,regdate from sheet1$";
        DbAdapter db = new DbAdapter();
        ArrayList ar = new ArrayList();
        try
        {
            db.executeQuery(sql);
            Logo logo = null;
            while(db.next())
            {
                logo = new Logo();
                logo.setLogotype(db.getString(1));
                logo.setLogoname(db.getString(2));
                logo.setLogoimage(db.getString(3));
                logo.setLogouse(db.getString(4));
                logo.setRegnum(db.getString(5));
                logo.setRegdate(db.getDate(6));

                ar.add(logo);
            }
            return ar;
        } catch(SQLException ex)
        {
            ex.printStackTrace();
            return null;
        }
    }

    public ArrayList getAll(int cp,int size) throws SQLException
    {
//		String sql = "SELECT * from "
//					 +"(SELECT TOP "+size+" * FROM ("
//					 +"SELECT TOP "+cp*size+" * from sheet1$ ORDER BY id ASC) as a ORDER BY id DESC) as b ORDER BY id ASC";
        String sql = "select top " + size + " * from sheet1$ where (id < ALL ( select top (" + size * (cp - 1) + ") id from sheet1$ order by id desc)) order by id desc";
        DbAdapter db = new DbAdapter();
        ArrayList ar = new ArrayList();
        try
        {
            db.executeQuery(sql);
            Logo logo = null;
            while(db.next())
            {
                logo = new Logo();
                logo.setLogotype(db.getString(1));
                logo.setLogoname(db.getString(2));
                logo.setLogoimage(db.getString(3));
                logo.setLogouse(db.getString(4));
                logo.setRegnum(db.getString(5));
                //logo.setRegdate(db.getDate(6));

                ar.add(logo);
            }
            return ar;
        } catch(SQLException ex)
        {
            ex.printStackTrace();
            return null;
        }
    }

    public void pageHTML(int size,int num,int cp,HttpServletResponse response) throws SQLException,IOException
    {

        int[] r = countTmp(size,num,cp);
        PrintWriter out = response.getWriter();
        out.print("<div style='top:200;position:absolute'>");
        out.print("<a href='?page=1'>最前</a>&nbsp;&nbsp;");
        if(cp != 1)
        {
            out.print("<a href='?page=" + (cp - 1) + "'>上一页</a>&nbsp;&nbsp;");
        } else
        {
            //out.print("<a href='javascript:;' onclick='tip1()'>上一页</a>&nbsp;&nbsp;");
        }
        for(int i = 0;i < r.length;i++)
        {
            if(r[i] == cp)
            {
                out.print(r[i]);
            } else
            {
                if(1 <= r[i] && r[i] <= 9)
                {
                    out.print("&nbsp;<a href='?page=" + r[i] + "'>&nbsp;" + r[i] + "</a>&nbsp;");
                } else
                {
                    out.print("&nbsp;<a href='?page=" + r[i] + "'>" + r[i] + "</a>&nbsp;");
                }
            }
        }
        if(cp != 55)
        {
            out.print("&nbsp;<a href='?page=" + (cp + 1) + "'>下一页</a>");
        }
        out.print("&nbsp;&nbsp;<a href='?page=55'>最后</a>");
        out.print("</div>");
    }

    public int[] countTmp(int size,int num,int cp) throws SQLException
    {
        int i = 0;

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM sheet1$");
            if(db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        int a = i / size;
        if(i % size != 0)
        {
            a += 1;
        }
        int[] result = new int[num];
        if(cp < 5)
        {
            for(int n = 0;n < 10;n++)
            {
                result[n] = n + 1;
            }
        }
        if(cp >= 5 && cp <= a - 5)
        {
            for(int n = 0;n < 10;n++)
            {
                result[n] = cp - 5 + 1 + n;
            }

        }
        if(cp > a - 5)
        {
            for(int n = 0;n < 10;n++)
            {
                result[n] = a - 10 + 1 + n;
            }

        }
        return result;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getLogoimage()
    {
        return logoimage;
    }

    public String getLogointroduce()
    {
        return logointroduce;
    }

    public String getLogoname()
    {
        return logoname;
    }

    public String getLogotype()
    {
        return logotype;
    }

    public String getLogouse()
    {
        return logouse;
    }

    public int getLogoid()
    {
        return logoid;
    }

    public Date getRegdate()
    {
        return regdate;
    }

    public String getRegdateToString()
    {
        if(regdate == null)
            return "";
        return sdf.format(regdate);
    }

    public String getRegnum()
    {
        return regnum;
    }

    public void setRegnum(String regnum)
    {
        this.regnum = regnum;
    }

    public void setRegdate(Date regdate)
    {
        this.regdate = regdate;
    }

    public void setLogoid(int logoid)
    {
        this.logoid = logoid;
    }

    public void setLogouse(String logouse)
    {
        this.logouse = logouse;
    }

    public void setLogotype(String logotype)
    {
        this.logotype = logotype;
    }

    public void setLogoname(String logoname)
    {
        this.logoname = logoname;
    }

    public void setLogointroduce(String logointroduce)
    {
        this.logointroduce = logointroduce;
    }

    public void setLogoimage(String logoimage)
    {
        this.logoimage = logoimage;
    }

    public void setLanguage(int language)
    {
        this.language = language;
    }

    public void setExists(boolean exists)
    {
        this.exists = exists;
    }

    public void setCommunity(String community)
    {
        this.community = community;
    }


    public String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        StringBuilder text = new StringBuilder();

        int _nNode = node._nNode;
        String subject = node.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,93,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = "";
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            int dq = detail.getQuantity(name);
            if(name.equals("logotype")) //商标类别
            {
                if(this.getLogotype() != null && this.getLogotype().length() > 0)
                {
                    value = Logo.LOGO_TYPE[Integer.parseInt(this.getLogotype())];
                }
            } else if(name.equals("logoname")) //商标名称
            {
                value = subject;
            } else if(name.equals("logoimage")) //商标图形
            {
                if(this.getLogoimage() != null && this.getLogoimage().length() > 0)
                {
                    value = "<a href =" + this.getLogoimage() + "  target=_blank><img onerror=\"this.style.display='none';\" src=\"" + this.getLogoimage() + "\" /></a>";
                } else
                {
                    value = "";
                }
            } else if(name.equals("logouse")) //核定使用商标
            {
                value = this.getLogouse();
            } else if(name.equals("regnum")) //注册号
            {
                value = this.getRegnum();
            } else if(name.equals("text")) //详细介绍
            {
                if(detail.getQuantity(name) == 0)
                {
                    if((node.getOptions() & 0x40L) == 0)
                    {
                        value = (tea.html.Text.toHTML(node.getText2(h.language)));
                    } else
                    {
                        value = (node.getText2(h.language));
                    }
                } else
                {
                    value = (node.getText(h.language));
                }

                value = value.replace("　　","<br>　　");
                value = Report.getHtml(value.toString());
            } else if(name.equals("regdate")) //注册时间
            {
                value = this.getRegdateToString();
            }

            if(value == null)
            {
                value = "";
            }
            if(istype == 2 && value.length() < 1)
            {
                continue;
            }

            String title = value.replace('"','_');

            //显示连接的地方
            value = detail.getOptionsToHtml(name,node,value);
            if(detail.getAnchor(name) != 0)
            {
                value = "<a href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/logo/" + _nNode + "-" + h.language + ".htm' target='" + target + "' title=\"" + subject + "\">" + value + "</a>";
            }
            text.append(bi).append("<span id='LogoID" + name + "'>" + value + "</span>").append(ai);
        }
        return text.toString();
    }


}
