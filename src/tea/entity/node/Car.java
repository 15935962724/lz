package tea.entity.node;

import java.math.*;
import java.sql.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.html.Anchor;
import tea.html.Span;

public class Car extends Entity
{
    private static Cache _cache = new Cache(100);
    private int node;
//    private String carname; //汽车名称
//    private String carcontent; //汽车描述 node,carpic,carstatic,carclass,carbrand,cartype,carprice,carmiles,caroil,caremission,carshape,wheelbase,maxoutput,outcapacity,engine,acrotorque,speedchanger,drive,volume,production
    private String carpic; //汽车图片
    private int carstatic; //车况（新/旧）
    private int carclass; //汽车品牌（国内/进口）
    private int carbrand; //汽车品牌
    private int cartype; //车型
    private BigDecimal carprice; //汽车价格
    private String carmiles; //首保里程
    private String caroil; //油耗
    private String caremission; //排放指标
    private String carshape; //外型 尺寸(cm)
    private String wheelbase; //轴距(cm)
    private String maxoutput; //最大功率(KW)
    private String outcapacity; //排量(毫升)
    private String engine; //发动机型式
    private String acrotorque; //最大扭矩(N.m)
    private String speedchanger; //变速器型式
    private String drive; //驱动形式
    private String volume; //后备箱体积(升)
    private String production; //生产状态

    public static final String CARSTATE[] =
            {"新车","旧车"};
    public static final String CARCLASS[] =
            {"国产品牌","外国品牌"};
    public static final String CARBRANDG[] =
            {"长安铃木","一汽轿车","南京菲亚特","东南汽车","一汽海马","北京吉普","华晨宝马","东风本田","东风标致","中华轿车","昌河汽车","北京奔驰","贵州云雀","中兴汽车","华北汽车","黑豹汽车","天马汽车","上海汇众","曙光汽车","江南汽车","扬子汽车","北汽制造","吉奥汽车","万丰汽车","庆铃汽车","四川丰田","双环汽车","富迪汽车","华翔富奇","中兴汽车","郑州日产","跃进新雅途","华晨金杯","江铃汽车","比亚迪汽车","东风风行","华泰汽车","通田汽车","哈飞汽车","上海华普","一汽华利","长安汽车","长丰三菱","猎豹汽车","上海大众","上海通用","一汽大众","江淮汽车","广州本田","北京现代","东风雪铁龙","长安福特","一汽奥迪","吉利汽车","奇瑞汽车","一汽丰田","东风日产","一汽马自达","长城汽车","天津一汽","东风悦达起亚","上汽通用五菱"};
    public static final String CARBRANDJ[] =
            {"摩根","萨博","吉普","精灵","土星","迷你","莲花","大发","水星","大宇","罗孚","道奇","双龙","无限","起亚","别克","本田","大众","福特","奔驰","雷诺","丰田","宝马","欧宝","日产","现代","悍马","标致","林肯","捷豹","路虎","奥迪","三菱","宾利","阿库拉","霍尔顿","布加迪","特威尔","西亚特","蓝旗亚","庞蒂克","迈巴赫","斯巴鲁","斯柯达","菲亚特","保时捷","雪佛兰","雪铁龙","沃尔沃","马自达","法拉利","玛莎拉蒂","凯迪拉克","劳斯莱斯","克莱斯勒","雷克萨斯","兰博基尼","沃克斯豪尔","阿斯顿·马丁","阿尔法罗米欧"};
    public static final String CARTYPE[] =
            {"微型","小型","中型","紧凑型","中大型","豪华型","SUV/Cross","MPV","跑车"};

    public static Car find(int node) throws SQLException
    {
        return new Car(node);
    }


    public Car(int node) throws SQLException
    {
        this.node = node;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select node,carpic,carstatic,carclass,carbrand,cartype,carprice,carmiles,caroil,caremission,carshape,wheelbase,maxoutput,outcapacity,engine,acrotorque,speedchanger,drive,volume,production from Car where node=" + node);
            if(db.next())
            {
                int j = 1;
                node = db.getInt(j++);
                carpic = db.getString(j++); //汽车图片
                carstatic = db.getInt(j++); //车况（新/旧）
                carclass = db.getInt(j++); //汽车品牌（国内/进口）
                carbrand = db.getInt(j++); //汽车品牌
                cartype = db.getInt(j++); //车型
                carprice = db.getBigDecimal(j++,2); //汽车价格
                carmiles = db.getString(j++); //首保里程
                caroil = db.getString(j++); //油耗
                caremission = db.getString(j++); //排放指标
                carshape = db.getString(j++); //外型 尺寸(cm)
                wheelbase = db.getString(j++); //轴距(cm)
                maxoutput = db.getString(j++); //最大功率(KW)
                outcapacity = db.getString(j++); //排量(毫升)
                engine = db.getString(j++); //发动机型式
                acrotorque = db.getString(j++); //最大扭矩(N.m)
                speedchanger = db.getString(j++); //变速器型式
                drive = db.getString(j++); //驱动形式
                volume = db.getString(j++); //后备箱体积(升)
                production = db.getString(j++); //生产状态
            }
        } finally
        {
            db.close();
        }
    }

    public static void set(int node,String carpic,int carstatic,int carclass,int carbrand,int cartype,BigDecimal carprice,String carmiles,String caroil,String caremission,String carshape,String wheelbase,String maxoutput,String outcapacity,String engine,String acrotorque,String speedchanger,String drive,String volume,String production) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select node from Car where node =" + node);
            if(db.next())
            {
                db.executeUpdate("Update Car set carpic=" + db.cite(carpic) + ",carstatic=" + carstatic + ",carclass=" + carclass + ",carbrand=" + carbrand + ",cartype=" + cartype + ",carprice=" + carprice + ",carmiles=" + db.cite(carmiles) + ",caroil=" + db.cite(caroil) + ",caremission=" + db.cite(caremission) + ",carshape=" + db.cite(carshape) + ",wheelbase=" + db.cite(wheelbase) + ",maxoutput=" + db.cite(maxoutput) + ",outcapacity=" + db.cite(outcapacity) + ",engine=" + db.cite(engine) + ",acrotorque=" + db.cite(acrotorque) + ",speedchanger=" + db.cite(speedchanger) + ",drive=" + db.cite(drive) + ",volume=" + db.cite(volume) + ",production=" + db.cite(production) + "  where node=" + node);
            } else
            {
                db.executeUpdate("Insert Into Car(node,carpic,carstatic,carclass,carbrand,cartype,carprice,carmiles,caroil,caremission,carshape,wheelbase,maxoutput,outcapacity,engine,acrotorque,speedchanger,drive,volume,production)values(" + node + "," + db.cite(carpic) + "," + carstatic + "," + carclass + "," + carbrand + "," + cartype + "," + carprice + "," + db.cite(carmiles) + "," + db.cite(caroil) + "," + db.cite(caremission) + "," + db.cite(carshape) + "," + db.cite(wheelbase) + "," + db.cite(maxoutput) + "," + db.cite(outcapacity) + "," + db.cite(engine) + "," + db.cite(acrotorque) + "," + db.cite(speedchanger) + "," + db.cite(drive) + "," + db.cite(volume) + "," + db.cite(production) + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public String getWheelbase()
    {
        return wheelbase;
    }

    public String getVolume()
    {
        return volume;
    }

    public String getSpeedchanger()
    {
        return speedchanger;
    }

    public String getProduction()
    {
        return production;
    }

    public String getOutcapacity()
    {
        return outcapacity;
    }

    public int getNode()
    {
        return node;
    }

    public String getMaxoutput()
    {
        return maxoutput;
    }

    public String getEngine()
    {
        return engine;
    }

    public String getDrive()
    {
        return drive;
    }

    public int getCartype()
    {
        return cartype;
    }

    public int getCarstatic()
    {
        return carstatic;
    }

    public String getCarshape()
    {
        return carshape;
    }

    public BigDecimal getCarprice()
    {
        return carprice;
    }

    public String getCarpic()
    {
        return carpic;
    }

    public String getCaroil()
    {
        return caroil;
    }

    public String getCarmiles()
    {
        return carmiles;
    }

    public String getCaremission()
    {
        return caremission;
    }

    public int getCarclass()
    {
        return carclass;
    }

    public int getCarbrand()
    {
        return carbrand;
    }

    public String getAcrotorque()
    {
        return acrotorque;
    }

    public Cache get_cache()
    {
        return _cache;
    }

    public String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        int _nNode = node._nNode;
        Span span = null;
        ListingDetail detail = ListingDetail.find(listing,90,h.language);
        java.util.Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            if(name.equals("index"))
            {
                value = String.valueOf(_nNode);
            } else if(name.equals("subject"))
            {
                value = (node.getSubject(h.language));
            } else if(name.equals("carpic"))
            {
                if(this.getCarpic() != null)
                {
                    value = ("<img name=picture" + node._nNode + " src='" + this.getCarpic() + "' >");
                }
            } else if(name.equals("carstatic"))
            {
                value = (String.valueOf(this.getCarstatic()));
            } else if(name.equals("carclass"))
            {

                value = (Car.CARCLASS[this.getCarclass()]);
            } else if(name.equals("carbrand"))
            {
                if(this.getCarclass() == 0)
                {
                    value = (Car.CARBRANDG[this.getCarbrand()]);
                } else
                {
                    value = (Car.CARBRANDJ[this.getCarbrand()]);
                }
            } else if(name.equals("cartype"))
            {
                value = (Car.CARTYPE[this.getCartype()]);
            } else if(name.equals("carprice"))
            {
                value = (String.valueOf(this.getCarprice()));
            } else if(name.equals("carmiles"))
            {
                value = (this.getCarmiles());
            } else if(name.equals("caroil"))
            {
                value = (this.getCaroil());
            } else if(name.equals("caremission"))
            {
                value = (this.getCaremission());
            } else if(name.equals("carshape"))
            {
                value = (this.getCarshape());
            } else if(name.equals("wheelbase"))
            {
                value = (this.getWheelbase());
            } else if(name.equals("maxoutput"))
            {
                value = (this.getMaxoutput());
            } else if(name.equals("outcapacity"))
            {
                value = (this.getOutcapacity());
            } else if(name.equals("engine"))
            {
                value = (this.getEngine());
            } else if(name.equals("acrotorque"))
            {
                value = (this.getAcrotorque());
            } else if(name.equals("speedchanger"))
            {
                value = (this.getSpeedchanger());
            } else if(name.equals("drive"))
            {
                value = (this.getDrive());
            } else if(name.equals("volume"))
            {
                value = (this.getVolume());
            } else if(name.equals("content"))
            {
                value = (node.getText(h.language));
            } else if(name.equals("production"))
            {
                value = (this.getProduction());
            } else if(name.equals("IssueTime"))
            {
                value = (node.getTimeToString());
            }
            if(detail.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/car/" + node._nNode + "-" + h.language + ".htm",value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("CarID" + name);
            htm.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
        }
        return htm.toString();
    }
}
