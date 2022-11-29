package tea.entity.admin;

import java.sql.SQLException;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.io.*;
import tea.resource.*;

public class GoodsType
{
    private static Cache _cache = new Cache(500);

    class Layer
    {
        private String name;
        private String picture;
    }


    private Hashtable _htLayer;
    private int goodstype;
    private int sequence;
    private int typeState;
    private int father;
    private boolean exists;
    private String community;
    private String brand;
    private Date time; //修改时间

    public GoodsType(int goodstype) throws SQLException
    {
        _htLayer = new Hashtable();
        this.goodstype = goodstype;
        load();
    }

    public GoodsType(int goodstype,int father,int sequence,String community,String brand,int typeState)
    {
        this.goodstype = goodstype;
        this.father = father;
        this.sequence = sequence;
        this.community = community;
        this.brand = brand;
        this.typeState = typeState;
        this.exists = true;
        _htLayer = new Hashtable();
    }

    public static GoodsType find(int id) throws SQLException
    {
        GoodsType obj = (GoodsType) _cache.get(new Integer(id));
        if(obj == null)
        {
            obj = new GoodsType(id);
            _cache.put(new Integer(id),obj);
        }
        return obj;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM GoodsType WHERE goodstype=" + goodstype);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(goodstype));
    }

    public void setBrand(String brand) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsType SET brand=" + DbAdapter.cite(brand) + " WHERE goodstype=" + goodstype);
        } finally
        {
            db.close();
        }
        this.brand = brand;
    }

    public String getBrand()
    {
        return brand;
    }

    public String getBrandlist() throws SQLException
    {
        return getBrandlist(goodstype);
    }

    private String getBrandlist(int gt) throws SQLException
    {
        int father = getFather();
        if(father < 1)
        {
            return brand;
        }
        return brand + GoodsType.find(gt).getBrandlist(father).substring(1);
    }

    public String getPath() throws SQLException
    {
        String str = "/" + goodstype;
        int father = getFather();
        if(father > 0)
        {
            str = GoodsType.find(father).getPath() + str;
        }
        return str;
    }

    public void set(int sequence,int language,String name,String picture,int typeState) throws SQLException
    {
        time = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE GoodsType SET sequence=" + sequence + ",typeState =" + typeState + ",time=" + db.cite(time) + " WHERE goodstype=" + goodstype);
            int j = db.executeUpdate("UPDATE GoodsTypeLayer SET name=" + DbAdapter.cite(name) + ",picture=" + DbAdapter.cite(picture) + " WHERE goodstype=" + goodstype + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO GoodsTypeLayer (goodstype, language, name,picture)VALUES (" + goodstype + ", " + language + ", " + DbAdapter.cite(name) + "," + DbAdapter.cite(picture) + ")");
            }
        } finally
        {
            db.close();
        }
        this.sequence = sequence;
        this.typeState = typeState;
        _htLayer.clear();
    }

    public static int getRootId(String community) throws SQLException
    {
        int root = 1;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT goodstype FROM GoodsType WHERE father=0 AND community=" + DbAdapter.cite(community));
            if(db.next())
            {
                root = db.getInt(1);
            } else
            {
                root = db.getInt("SELECT goodstype FROM GoodsType WHERE father=0 AND community='[DEFAULT]'");
            }
        } finally
        {
            db.close();
        }
        if(root == 0)
        {
            root = init();
        }
        return root;
    }

    public static int create(int father,int sequence,String community,int language,String name,String picture,int typeState) throws SQLException
    {
        int goodstype = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO GoodsType( father,sequence,community,brand,typeState,time)VALUES (" + father + ", " + sequence + "," + DbAdapter.cite(community) + ",'/'," + typeState + "," + db.cite(new Date()) + ")");
            goodstype = db.getInt("SELECT MAX(goodstype) FROM GoodsType");
            db.executeUpdate("INSERT INTO GoodsTypeLayer (goodstype, language, name,picture)VALUES (" + goodstype + ", " + language + ", " + DbAdapter.cite(name) + "," + DbAdapter.cite(picture) + ")");
        } finally
        {
            db.close();
        }
        return goodstype;
    }

    public static Enumeration findByFather(int father) throws SQLException
    {
        return find(" AND father=" + (father) + " ORDER BY sequence",0,Integer.MAX_VALUE);
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT goodstype,father,sequence,community,brand,typeState FROM GoodsType WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.addElement(new GoodsType(db.getInt(1),db.getInt(2),db.getInt(3),db.getString(4),db.getString(5),db.getInt(6)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

	//判断名字类别中是否存在
	public static String getGT(String community,String gtname)throws SQLException
	{
		 DbAdapter db = new DbAdapter();
		 StringBuffer sp = new StringBuffer();
		 String gtn[] = gtname.split("/");
		 int root = GoodsType.getRootId(community);
		 	 int gid = 0;

	try
		 {
			 for(int i=1;i<gtn.length;i++)
			 {
				 String gn = gtn[i];

				 db.executeQuery("select goodstype from GoodsType where father ="+root+" and community="+db.cite(community)+" and goodstype in (select goodstype from GoodsTypeLayer where name ="+db.cite(gn)+")");
				 if(db.next())
				 {
					 if(i==1)
					{
						sp.append("/").append(root);
					}

					 sp.append("/").append(db.getInt(1));
					 gid = db.getInt(1);
					 root = db.getInt(1);
				 }else
				 {
					 if(i==1)
					 {
						 sp.append("/").append(root);
						   gid = root;
					 }

                     gid = GoodsType.create(gid,0,community,1,gn,null,0);
                     sp.append("/").append(gid);
					 root = gid;
				 }
			 }
			 sp.append("/");
		 }finally
		 {
			 db.close();
		 }
		 return sp.toString();
	}
    public static Enumeration findByBrand(int brand) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT goodstype FROM GoodsType WHERE brand LIKE " + DbAdapter.cite("%/" + brand + "/%") + " ORDER BY sequence");
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

    public static int countByFather(int father) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(goodstype) FROM GoodsType WHERE father=" + (father));
        } finally
        {
            db.close();
        }
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT father,sequence,community,brand,typeState,time FROM GoodsType WHERE goodstype=" + goodstype);
            if(db.next())
            {
                father = db.getInt(1);
                sequence = db.getInt(2);
                community = db.getString(3);
                brand = db.getString(4);
                typeState = db.getInt(5);
                time = db.getDate(6);
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

    public int getGoodstype()
    {
        return goodstype;
    }

    public String getName(int language) throws SQLException
    {
        return getLayer(language).name;
    }

    public String getAncestor(int language) throws SQLException
    {
        if(goodstype == 0)
        {
            return "";
        } else
        {
            return find(getFather()).getAncestor(language) + ">" + getName(language);
        }
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = this.getLanguage(i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name,picture FROM GoodsTypeLayer WHERE goodstype=" + goodstype + " AND language=" + j);
                if(db.next())
                {
                    layer.name = db.getVarchar(j,i,1);
                    layer.picture = db.getString(2);
                }
            } finally
            {
                db.close();
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }

    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM GoodsTypeLayer WHERE goodstype=" + goodstype);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public String getPicture(int language) throws SQLException
    {
        return getLayer(language).picture;
    }

    public int getSequence()
    {
        return sequence;
    }

    public int getTypeState()
    {
        return typeState;
    }

    public int getFather()
    {
        return father;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    public Date getTime()
    {
        return time;
    }

    private static void tojs(PrintWriter fw,int id,int lang) throws SQLException
    {
        Enumeration e = findByFather(id);
        if(e.hasMoreElements())
        {
            StringBuilder sb = new StringBuilder();
            sb.append("var goodstype").append(id).append("=new Array(new Array('','--------------')");
            while(e.hasMoreElements())
            {
                GoodsType obj = (GoodsType) e.nextElement();
                id = obj.getGoodstype();
                sb.append(",new Array('").append(id).append("','").append(obj.getName(lang)).append("')");
                tojs(fw,id,lang);
            }
            sb.append(");\r\n\r\n");
            fw.write(sb.toString());
        }
    }

    public static void toJavascript(String community,int lang)
    {
        try
        {
            int root = getRootId(community);
            PrintWriter fw = new PrintWriter(Common.REAL_PATH + "/res/" + community + "/cssjs/GoodsType.js","UTF-8");
            tojs(fw,root,lang);
            StringBuilder sb = new StringBuilder();
            sb.append("var goodstype=new Array(new Array('','--------------'));");
            sb.append("function selectgt(s0,s1,s2,dv)                                                                       \r\n");
            sb.append("{                                                                       \r\n");
            sb.append("	document.write(\"<select name='\"+s0+\"' onchange=\\\"addgt(this.value,'\"+s1+\"','\"+dv+\"');\\\"><option value=''>--------------</select>\");                                                                       \r\n");
            sb.append("	if(s1)                                                                       \r\n");
            sb.append("	{                                                                       \r\n");
            sb.append("	  document.write(\" <select name='\"+s1+\"' onchange=\\\"addgt(this.value,'\"+s2+\"','\"+dv+\"');\\\"><option value=''>--------------</select>\");                                                                       \r\n");
            sb.append("	  if(s2)                                                                       \r\n");
            sb.append("	     document.write(\" <select name='\"+s2+\"' ><option value=''>--------------</select>\");                                                                       \r\n");
            sb.append("	}                                                                       \r\n");
            sb.append("	addgt('" + root + "',s0,dv);                                                                       \r\n");
            sb.append("}                                                                       \r\n");
            sb.append("function addgt(father,s,dv)                                                                       \r\n");
            sb.append("{                                                                       \r\n");
            sb.append("  var ob=document.all(s);                                                                       \r\n");
            sb.append("  if(ob)                                                                       \r\n");
            sb.append("  {                                                                       \r\n");
            sb.append("    var op=ob.options;                                                                       \r\n");
            sb.append("    while(op.length>0)                                                                       \r\n");
            sb.append("    {                                                                       \r\n");
            sb.append("      op[0]=null;                                                                       \r\n");
            sb.append("    }                                                                       \r\n");
            sb.append("    //if(father==null||father.length>0)                                                                       \r\n");
            sb.append("    {                                                                       \r\n");
            sb.append("    	//if(father==null)father='';                                                                       \r\n");
            sb.append("	        var c=eval('goodstype'+father);                                                                       \r\n");
            sb.append("		for(var i=0;i<c.length;i++)                                                                       \r\n");
            sb.append("		{                                                                       \r\n");
            sb.append("		  op[i]=new Option(c[i][1],c[i][0]);                                                                       \r\n");
            sb.append("		  if( dv.indexOf('/'+c[i][0]+'/')!=-1 || dv==c[i][1] )                                                                       \r\n");
            sb.append("		  {                                                                       \r\n");
            sb.append("		    op[i].selected=true;                                                                       \r\n");
            sb.append("		  }                                                                       \r\n");
            sb.append("		}                                                                       \r\n");
            sb.append("		if(ob.onchange)ob.onchange();                                                                       \r\n");
            sb.append("	}                                                                       \r\n");
            sb.append("  }                                                                       \r\n");
            sb.append("}                                                                       \r\n");
            fw.write(sb.toString());
            fw.close();
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    // //////////////////////////////////////////////////////////////////////////////////////////////
    private static int init() throws SQLException
    {
        String DEFAULT_TYPE[][] =
                {
                {"0","1","根"},
                {"1","101000000","精细化学品"},
                {"101000000","101101000","皮肤用化学品"},
                {"101000000","101102000","彩妆化学品"},
                {"101000000","101103000","口腔用化学品"},
                {"101000000","101104000","芳香除臭化学品"},
                {"101000000","101105000","家居清洗用品"},
                {"101000000","101106000","驱虫灭害化学品"},
                {"101000000","101107000","瘦身化学品"},
                {"101000000","101108000","丰胸化学品"},
                {"101000000","101109000","其他日用化学品"},
                {"101000000","101110000","农药原药"},
                {"101000000","101111000","农药制剂"},
                {"101000000","101112000","化肥"},
                {"101000000","101113000","植物生长调节剂"},
                {"101000000","101114000","畜用药"},
                {"101000000","101115000","天然胶粘剂"},
                {"101000000","101116000","无机胶粘剂"},
                {"101000000","101117000","合成胶粘剂"},
                {"101000000","101118000","染料"},
                {"101000000","101119000","无机颜料"},
                {"101000000","101120000","有机颜料"},
                {"101000000","101121000","涂料"},
                {"101000000","101122000","油墨"},
                {"101000000","101123000","催化剂"},
                {"101000000","101124000","表面活性剂"},
                {"101000000","101125000","吸附剂"},
                {"101000000","101126000","合成材料助剂"},
                {"101000000","101127000","皮革化学品"},
                {"101000000","101128000","纺织染整助剂"},
                {"101000000","101129000","造纸化学品"},
                {"101000000","101130000","涂料助剂"},
                {"101000000","101131000","水处理化学品"},
                {"101000000","101132000","电子工业用助剂"},
                {"101000000","101133000","金属加工助剂"},
                {"101000000","101134000","石油产品添加剂"},
                {"101000000","101135000","信息用化学品"},
                {"101000000","101136000","其他助剂"},
                {"101000000","101137000","食品添加剂"},
                {"101000000","101138000","饲料添加剂"},
                {"101000000","101139000","化学试剂"},
                {"101000000","101140000","香料、香精"},
                {"101000000","101141000","工业用清洗剂"},
                {"101000000","101142000","生物化工"},
                {"101000000","101143000","原料药"},
                {"101000000","101144000","库存精细化学品"},
                {"101000000","101145000","精细化学品代理"},
                {"101000000","101146000","精细化工项目合作"},
                {"101000000","101147000","废催化剂"},
                {"101000000","101148000","其他未分类"},
                {"1","102000000","橡塑"},
                {"102000000","102101000","通用塑料"},
                {"102000000","102102000","工程塑料"},
                {"102000000","102103000","特种塑料"},
                {"102000000","102104000","再生塑料"},
                {"102000000","102105000","色母"},
                {"102000000","102106000","废塑料"},
                {"102000000","102107000","塑料薄膜"},
                {"102000000","102108000","塑料管"},
                {"102000000","102109000","塑料板"},
                {"102000000","102110000","塑料片"},
                {"102000000","102111000","泡沫塑料"},
                {"102000000","102112000","塑料容器"},
                {"102000000","102113000","塑料包装制品"},
                {"102000000","102114000","塑料工艺品"},
                {"102000000","102115000","家用塑料制品"},
                {"102000000","102116000","塑料建材"},
                {"102000000","102117000","工农业用塑料制品"},
                {"102000000","102118000","其他塑料制品"},
                {"102000000","102119000","塑料机械"},
                {"102000000","102120000","塑料加工"},
                {"102000000","102121000","天然橡胶"},
                {"102000000","102122000","合成橡胶"},
                {"102000000","102123000","废橡胶"},
                {"102000000","102124000","轮胎"},
                {"102000000","102125000","橡胶板"},
                {"102000000","102126000","橡胶管"},
                {"102000000","102127000","橡胶片"},
                {"102000000","102128000","工业用橡胶制品"},
                {"102000000","102129000","农业用橡胶制品"},
                {"102000000","102130000","生活日用橡胶制品"},
                {"102000000","102131000","文教用橡胶制品"},
                {"102000000","102132000","医用橡胶制品"},
                {"102000000","102133000","其他橡胶制品"},
                {"102000000","102134000","橡胶机械"},
                {"102000000","102135000","橡胶加工"},
                {"102000000","102136000","热塑性弹性体"},
                {"102000000","102137000","合成材料助剂"},
                {"102000000","102138000","其他未分类"},
                {"1","103000000","五金工具"},
                {"103000000","103101000","轴承"},
                {"103000000","103102000","弹簧"},
                {"103000000","103103000","紧固件、连接件"},
                {"103000000","103104000","密封件"},
                {"103000000","103105000","模具"},
                {"103000000","103106000","刀具、夹具"},
                {"103000000","103107000","气动元件"},
                {"103000000","103108000","液压元件"},
                {"103000000","103109000","机床附件"},
                {"103000000","103110000","门窗五金"},
                {"103000000","103111000","水暖五金"},
                {"103000000","103112000","卫浴用五金件"},
                {"103000000","103113000","管件"},
                {"103000000","103114000","锁具"},
                {"103000000","103115000","通用五金配件"},
                {"103000000","103116000","磨具"},
                {"103000000","103117000","磨料"},
                {"103000000","103118000","气焊、气割器材"},
                {"103000000","103119000","焊接材料与附件"},
                {"103000000","103120000","电子五金件"},
                {"103000000","103121000","船用五金配件"},
                {"103000000","103122000","二手电动工具"},
                {"103000000","103123000","库存五金、工具"},
                {"103000000","103124000","钳子"},
                {"103000000","103125000","扳手"},
                {"103000000","103126000","锯"},
                {"103000000","103127000","螺丝刀"},
                {"103000000","103128000","丝锥、板牙"},
                {"103000000","103129000","其他钳工工具"},
                {"103000000","103130000","锉"},
                {"103000000","103131000","剪"},
                {"103000000","103132000","刀"},
                {"103000000","103133000","刷"},
                {"103000000","103134000","匠作工具"},
                {"103000000","103135000","农用工具"},
                {"103000000","103136000","斧子"},
                {"103000000","103137000","锤子"},
                {"103000000","103138000","撬棍、起钉器"},
                {"103000000","103139000","凿"},
                {"103000000","103140000","组合工具"},
                {"103000000","103141000","气动工具"},
                {"103000000","103142000","喷涂工具"},
                {"103000000","103143000","工具包、工具箱"},
                {"103000000","103144000","金刚石工具"},
                {"103000000","103145000","打气筒"},
                {"103000000","103146000","装配电动工具"},
                {"103000000","103147000","磨抛光电动工具"},
                {"103000000","103148000","切削电动工具"},
                {"103000000","103149000","电烙铁"},
                {"103000000","103150000","机械零部件加工"},
                {"103000000","103151000","五金工具加工"},
                {"103000000","103152000","五金工具项目合作"},
                {"103000000","103153000","五金工具代理"},
                {"103000000","103154000","其他未分类"},
                {"1","104000000","化工"},
                {"104000000","104101000","单质"},
                {"104000000","104102000","气体"},
                {"104000000","104103000","氧化物"},
                {"104000000","104104000","无机酸"},
                {"104000000","104105000","无机碱"},
                {"104000000","104106000","无机盐"},
                {"104000000","104107000","非金属矿产"},
                {"104000000","104108000","烃类"},
                {"104000000","104109000","醇类"},
                {"104000000","104110000","醌类"},
                {"104000000","104111000","羧酸"},
                {"104000000","104112000","羧酸衍生物"},
                {"104000000","104113000","碳水化合物"},
                {"104000000","104114000","杂环化合物"},
                {"104000000","104115000","砜类"},
                {"104000000","104116000","胺类"},
                {"104000000","104117000","腈类"},
                {"104000000","104118000","醛类"},
                {"104000000","104119000","酮类"},
                {"104000000","104120000","酚类"},
                {"104000000","104121000","醚类"},
                {"104000000","104122000","磺酸"},
                {"104000000","104123000","磺酸衍生物"},
                {"104000000","104124000","重氮化合物"},
                {"104000000","104125000","偶氮化合物"},
                {"104000000","104126000","天然树脂"},
                {"104000000","104127000","合成树脂"},
                {"104000000","104128000","化学纤维"},
                {"104000000","104129000","其他聚合物"},
                {"104000000","104130000","玻璃"},
                {"104000000","104131000","陶瓷"},
                {"104000000","104132000","化学试剂"},
                {"104000000","104133000","火工产品"},
                {"104000000","104134000","传质设备"},
                {"104000000","104135000","反应设备"},
                {"104000000","104136000","干燥设备"},
                {"104000000","104137000","制冷设备"},
                {"104000000","104138000","分离设备"},
                {"104000000","104139000","混合设备"},
                {"104000000","104140000","粉碎设备"},
                {"104000000","104141000","传热设备"},
                {"104000000","104142000","储运设备"},
                {"104000000","104143000","输送设备"},
                {"104000000","104144000","结晶设备"},
                {"104000000","104145000","石油加工设备"},
                {"104000000","104146000","玻璃机械"},
                {"104000000","104147000","化工成套设备"},
                {"104000000","104148000","化工实验设备"},
                {"104000000","104149000","化工成型设备"},
                {"104000000","104150000","化工设备配件"},
                {"104000000","104151000","化工仪表"},
                {"104000000","104152000","化工管道及配件"},
                {"104000000","104153000","污水处理设备"},
                {"104000000","104154000","空气净化装置"},
                {"104000000","104155000","泵"},
                {"104000000","104156000","阀门"},
                {"104000000","104157000","实验室用品"},
                {"104000000","104158000","化工废料"},
                {"104000000","104159000","库存化工原料"},
                {"104000000","104160000","库存化工设备"},
                {"104000000","104161000","化工原料代理"},
                {"104000000","104162000","化工设备代理"},
                {"104000000","104163000","化工产品加工"},
                {"104000000","104164000","玻璃加工"},
                {"104000000","104165000","陶瓷加工"},
                {"104000000","104166000","化工项目合作"},
                {"104000000","104167000","二手化工设备"},
                {"104000000","104168000","其他未分类"},
                {"1","105000000","机械及行业设备"},
                {"105000000","105101000","塑料机械"},
                {"105000000","105102000","石油加工设备"},
                {"105000000","105103000","包装相关设备"},
                {"105000000","105104000","包装成型机械"},
                {"105000000","105105000","印刷机"},
                {"105000000","105106000","农业机械"},
                {"105000000","105107000","食品、饮料加工设备"},
                {"105000000","105108000","污水处理设备"},
                {"105000000","105109000","清洗、清理设备"},
                {"105000000","105110000","节能设备"},
                {"105000000","105111000","空气净化装置"},
                {"105000000","105112000","脱硫除尘设备"},
                {"105000000","105113000","消音降噪设备"},
                {"105000000","105114000","垃圾焚烧炉"},
                {"105000000","105115000","发电机、发电机组"},
                {"105000000","105116000","电动机"},
                {"105000000","105117000","低压电器"},
                {"105000000","105118000","高压电器"},
                {"105000000","105119000","配电输电设备"},
                {"105000000","105120000","纺织设备和器材"},
                {"105000000","105121000","皮革加工设备"},
                {"105000000","105122000","纸加工机械"},
                {"105000000","105123000","制鞋机械"},
                {"105000000","105124000","涂装设备"},
                {"105000000","105125000","造纸设备及配件"},
                {"105000000","105126000","服装加工设备"},
                {"105000000","105127000","整熨洗涤设备"},
                {"105000000","105128000","家具制造机械"},
                {"105000000","105129000","工艺礼品加工设备"},
                {"105000000","105130000","陶瓷生产加工机械"},
                {"105000000","105131000","电脑产品制造设备"},
                {"105000000","105132000","家电制造设备"},
                {"105000000","105133000","玩具加工设备"},
                {"105000000","105134000","其他行业专用设备"},
                {"105000000","105135000","机床"},
                {"105000000","105136000","阀门"},
                {"105000000","105137000","泵"},
                {"105000000","105138000","传动件"},
                {"105000000","105139000","液压机械及部件"},
                {"105000000","105140000","风机、排风设备"},
                {"105000000","105141000","压缩、分离设备"},
                {"105000000","105142000","减速机、变速机"},
                {"105000000","105143000","内燃机"},
                {"105000000","105144000","焊接材料与附件"},
                {"105000000","105145000","电焊、切割设备"},
                {"105000000","105146000","工程与建筑机械"},
                {"105000000","105147000","选矿设备"},
                {"105000000","105148000","冶炼设备"},
                {"105000000","105149000","电子产品制造设备"},
                {"105000000","105150000","工控系统及装备"},
                {"105000000","105151000","电热设备"},
                {"105000000","105152000","商业专用设备"},
                {"105000000","105153000","金融专用设备"},
                {"105000000","105154000","金属加工"},
                {"105000000","105155000","机械零部件加工"},
                {"105000000","105156000","换热、制冷空调设备"},
                {"105000000","105157000","工业锅炉及配件"},
                {"105000000","105158000","仪器仪表加工"},
                {"105000000","105159000","行业专用设备加工"},
                {"105000000","105160000","二手机床"},
                {"105000000","105161000","二手锅炉"},
                {"105000000","105162000","二手工程机械"},
                {"105000000","105163000","库存设备及工业用品"},
                {"105000000","105164000","机械项目合作"},
                {"105000000","105165000","工业制品代理"},
                {"105000000","105166000","其他未分类"},
                {"1","106000000","服饰"},
                {"106000000","106101000","正装鞋"},
                {"106000000","106102000","休闲鞋"},
                {"106000000","106103000","运动鞋"},
                {"106000000","106104000","拖鞋"},
                {"106000000","106105000","凉鞋"},
                {"106000000","106106000","靴子"},
                {"106000000","106107000","工作鞋"},
                {"106000000","106108000","其他功能鞋"},
                {"106000000","106109000","童鞋"},
                {"106000000","106110000","婴儿鞋"},
                {"106000000","106111000","成品鞋加工"},
                {"106000000","106112000","成品鞋代理"},
                {"106000000","106113000","皮革"},
                {"106000000","106114000","人造革"},
                {"106000000","106115000","合成革"},
                {"106000000","106116000","鞋底"},
                {"106000000","106117000","鞋材化工"},
                {"106000000","106118000","钟表"},
                {"106000000","106119000","皮革化学品"},
                {"106000000","106120000","鞋辅件"},
                {"106000000","106121000","鞋模"},
                {"106000000","106122000","鞋材、鞋件加工"},
                {"106000000","106123000","鞋材、鞋件代理"},
                {"106000000","106124000","制鞋机械"},
                {"106000000","106125000","皮革加工设备"},
                {"106000000","106126000","修鞋设备"},
                {"106000000","106127000","鞋机配件"},
                {"106000000","106128000","二手制鞋设备"},
                {"106000000","106129000","围巾"},
                {"106000000","106130000","披肩"},
                {"106000000","106131000","丝巾"},
                {"106000000","106132000","围巾帽子手套套件"},
                {"106000000","106133000","服饰手套"},
                {"106000000","106134000","运动手套"},
                {"106000000","106135000","工作手套"},
                {"106000000","106136000","运动帽"},
                {"106000000","106137000","职业帽"},
                {"106000000","106138000","时装帽"},
                {"106000000","106139000","生活帽"},
                {"106000000","106140000","民族帽"},
                {"106000000","106141000","童帽"},
                {"106000000","106142000","袜子"},
                {"106000000","106143000","领带"},
                {"106000000","106144000","领花、领结"},
                {"106000000","106145000","领带夹"},
                {"106000000","106146000","腰带"},
                {"106000000","106147000","腰带配件"},
                {"106000000","106148000","时尚配饰"},
                {"106000000","106149000","男包系列"},
                {"106000000","106150000","女包系列"},
                {"106000000","106151000","库存服饰"},
                {"106000000","106152000","服饰代理"},
                {"106000000","106153000","服饰加工"},
                {"106000000","106154000","服饰项目合作"},
                {"106000000","106155000","其他未分类"},
                {"1","107000000","电脑、软件"},
                {"107000000","107101000","CPU"},
                {"107000000","107102000","主板"},
                {"107000000","107103000","内存"},
                {"107000000","107104000","硬盘"},
                {"107000000","107105000","插卡类"},
                {"107000000","107106000","驱动器"},
                {"107000000","107107000","显示器"},
                {"107000000","107108000","鼠标、键盘"},
                {"107000000","107109000","机箱"},
                {"107000000","107110000","机箱电源"},
                {"107000000","107111000","风扇、散热片"},
                {"107000000","107112000","电源适配器"},
                {"107000000","107113000","电脑接口线"},
                {"107000000","107114000","台式机"},
                {"107000000","107115000","笔记本电脑"},
                {"107000000","107116000","服务器、工作站"},
                {"107000000","107117000","移动PC"},
                {"107000000","107118000","工控电脑产品"},
                {"107000000","107119000","网络设备、配件"},
                {"107000000","107120000","布线产品"},
                {"107000000","107121000","MP3"},
                {"107000000","107122000","便携式碟机"},
                {"107000000","107123000","数码摄像头"},
                {"107000000","107124000","数码相机"},
                {"107000000","107125000","数码摄像机"},
                {"107000000","107126000","数码录音笔"},
                {"107000000","107127000","MD"},
                {"107000000","107128000","MP4"},
                {"107000000","107129000","数码配件"},
                {"107000000","107130000","PDA"},
                {"107000000","107131000","复读机、学习机"},
                {"107000000","107132000","视讯会议系统"},
                {"107000000","107133000","打印机耗材"},
                {"107000000","107134000","移动存储"},
                {"107000000","107135000","光盘、磁盘"},
                {"107000000","107136000","电脑相关用品"},
                {"107000000","107137000","打印机"},
                {"107000000","107138000","扫描仪"},
                {"107000000","107139000","电脑读卡器"},
                {"107000000","107140000","条码设备"},
                {"107000000","107141000","UPS电源"},
                {"107000000","107142000","电脑游戏周边产品"},
                {"107000000","107143000","打字机、刻字机"},
                {"107000000","107144000","绘图机"},
                {"107000000","107145000","耳机"},
                {"107000000","107146000","音箱"},
                {"107000000","107147000","麦克风、话筒"},
                {"107000000","107148000","工具软件"},
                {"107000000","107149000","管理软件"},
                {"107000000","107150000","行业专用软件"},
                {"107000000","107151000","教育教学软件"},
                {"107000000","107152000","游戏娱乐软件"},
                {"107000000","107153000","软件开发"},
                {"107000000","107154000","软件代理"},
                {"107000000","107155000","信息技术项目合作"},
                {"107000000","107156000","二手电脑及配件"},
                {"107000000","107157000","电脑产品制造设备"},
                {"107000000","107158000","二手电子加工设备"},
                {"107000000","107159000","库存电脑产品"},
                {"107000000","107160000","电脑产品加工"},
                {"107000000","107161000","电脑维修、安装"},
                {"107000000","107162000","电脑产品代理"},
                {"107000000","107163000","电脑项目合作"},
                {"107000000","107164000","其他未分类"},
                {"1","108000000","商务服务"},
                {"108000000","108101000","公关服务"},
                {"108000000","108102000","摄影、摄像服务"},
                {"108000000","108103000","创意设计"},
                {"108000000","108104000","公司注册服务"},
                {"108000000","108105000","专利版权申请服务"},
                {"108000000","108106000","商标注册申请服务"},
                {"108000000","108107000","知识产权转让"},
                {"108000000","108108000","债权转让"},
                {"108000000","108109000","整体产权转让"},
                {"108000000","108110000","法律服务"},
                {"108000000","108111000","金融服务"},
                {"108000000","108112000","会计服务"},
                {"108000000","108113000","秘书服务"},
                {"108000000","108114000","物流服务"},
                {"108000000","108115000","配额"},
                {"108000000","108116000","进出口代理"},
                {"108000000","108117000","中介服务"},
                {"108000000","108118000","劳务输出"},
                {"108000000","108119000","移民、签证"},
                {"108000000","108120000","翻译"},
                {"108000000","108121000","招聘"},
                {"108000000","108122000","教育、培训"},
                {"108000000","108123000","宾馆服务"},
                {"108000000","108124000","餐饮服务"},
                {"108000000","108125000","旅游服务"},
                {"108000000","108126000","票务"},
                {"108000000","108127000","保险"},
                {"108000000","108128000","医疗保健服务"},
                {"108000000","108129000","保安及紧急服务"},
                {"108000000","108130000","家政服务"},
                {"108000000","108131000","维修、安装"},
                {"108000000","108132000","清洗、保洁服务"},
                {"108000000","108133000","拍卖"},
                {"108000000","108134000","租赁、典当"},
                {"108000000","108135000","其他未分类"},
                {"108000000","108136000","咨询、策划"},
                {"108000000","108137000","商展、会议"},
                {"108000000","108138000","广告服务"},
                {"1","109000000","服装"},
                {"109000000","109101000","女上装"},
                {"109000000","109102000","女裙"},
                {"109000000","109103000","女裤"},
                {"109000000","109104000","女士内衣"},
                {"109000000","109105000","女套装"},
                {"109000000","109106000","孕妇装"},
                {"109000000","109107000","儿童服装"},
                {"109000000","109108000","婴儿服装"},
                {"109000000","109109000","中老年服装"},
                {"109000000","109110000","服装辅料"},
                {"109000000","109111000","男上装"},
                {"109000000","109112000","男裤"},
                {"109000000","109113000","男士内衣"},
                {"109000000","109114000","制服、工作服"},
                {"109000000","109115000","民族服装"},
                {"109000000","109116000","运动服装"},
                {"109000000","109117000","礼服、婚纱"},
                {"109000000","109118000","舞台装"},
                {"109000000","109119000","特殊用途服装"},
                {"109000000","109120000","特殊尺寸服装、鞋帽"},
                {"109000000","109121000","服装展示道具"},
                {"109000000","109122000","整熨洗涤设备"},
                {"109000000","109123000","二手服装加工设备"},
                {"109000000","109124000","库存服装"},
                {"109000000","109125000","服装加工"},
                {"109000000","109126000","服装代理"},
                {"109000000","109127000","服装项目合作"},
                {"109000000","109128000","其他未分类"},
                {"1","110000000","汽摩及配件"},
                {"110000000","110101000","乘用车"},
                {"110000000","110102000","商用车"},
                {"110000000","110103000","其他专用汽车"},
                {"110000000","110104000","发动系统"},
                {"110000000","110105000","传动系统"},
                {"110000000","110106000","制动系统"},
                {"110000000","110107000","转向系统"},
                {"110000000","110108000","燃油系统"},
                {"110000000","110109000","冷却系统"},
                {"110000000","110110000","减震系统"},
                {"110000000","110111000","电源、点火系统"},
                {"110000000","110112000","车用仪表"},
                {"110000000","110113000","车灯"},
                {"110000000","110114000","轮胎"},
                {"110000000","110115000","车身及附件"},
                {"110000000","110116000","摩托车"},
                {"110000000","110117000","摩托车配附件"},
                {"110000000","110118000","交通安全设备"},
                {"110000000","110119000","二手汽车"},
                {"110000000","110120000","二手摩托车"},
                {"110000000","110121000","汽车影音"},
                {"110000000","110122000","汽车安全用品"},
                {"110000000","110123000","汽车装潢内饰用品"},
                {"110000000","110124000","汽车装潢外饰用品"},
                {"110000000","110125000","汽车小电器"},
                {"110000000","110126000","汽车锁"},
                {"110000000","110127000","汽车通讯"},
                {"110000000","110128000","检测设备"},
                {"110000000","110129000","维修设备"},
                {"110000000","110130000","防护保养品"},
                {"110000000","110131000","维护工具"},
                {"110000000","110132000","汽摩产品制造设备"},
                {"110000000","110133000","停车场设备"},
                {"110000000","110134000","加油站设备"},
                {"110000000","110135000","二手橡胶加工设备"},
                {"110000000","110136000","库存汽摩配件"},
                {"110000000","110137000","汽摩配件加工"},
                {"110000000","110138000","汽摩及配件代理"},
                {"110000000","110139000","其他未分类"},
                {"1","111000000","能源"},
                {"111000000","111101000","石油燃料"},
                {"111000000","111102000","润滑油（脂）"},
                {"111000000","111103000","石油产品添加剂"},
                {"111000000","111104000","石油蜡"},
                {"111000000","111105000","沥青"},
                {"111000000","111106000","石油焦"},
                {"111000000","111107000","溶剂油"},
                {"111000000","111108000","天然气"},
                {"111000000","111109000","燃气设备"},
                {"111000000","111110000","石油加工设备"},
                {"111000000","111111000","原煤"},
                {"111000000","111112000","煤制品"},
                {"111000000","111113000","太阳能设备"},
                {"111000000","111114000","沼气设备"},
                {"111000000","111115000","风能设备"},
                {"111000000","111116000","发电机、发电机组"},
                {"111000000","111117000","电池"},
                {"111000000","111118000","配电输电设备"},
                {"111000000","111119000","变压器"},
                {"111000000","111120000","桥架"},
                {"111000000","111121000","节能设备"},
                {"111000000","111122000","能源产品加工"},
                {"111000000","111123000","能源项目合作"},
                {"111000000","111124000","能源产品代理"},
                {"111000000","111125000","其他未分类"},
                {"1","112000000","安全、防护"},
                {"112000000","112101000","监控器材及系统"},
                {"112000000","112102000","防盗、报警器材及系统"},
                {"112000000","112103000","交通安全设备"},
                {"112000000","112104000","消防设备"},
                {"112000000","112105000","安全检查设备"},
                {"112000000","112106000","防伪技术产品"},
                {"112000000","112107000","电子巡更系统"},
                {"112000000","112108000","公共广播系统"},
                {"112000000","112109000","防雷避雷产品"},
                {"112000000","112110000","防静电产品"},
                {"112000000","112111000","军需用品"},
                {"112000000","112112000","救生器材"},
                {"112000000","112113000","自然灾害防护产品"},
                {"112000000","112114000","锁具"},
                {"112000000","112115000","门禁考勤器材及系统"},
                {"112000000","112116000","楼宇对讲设备"},
                {"112000000","112117000","智能卡"},
                {"112000000","112118000","作业保护"},
                {"112000000","112119000","运动护具"},
                {"112000000","112120000","防身用具"},
                {"112000000","112121000","防弹、防暴器材"},
                {"112000000","112122000","安全、防护用品代理"},
                {"112000000","112123000","库存安全防护产品"},
                {"112000000","112124000","安全防护产品项目合作"},
                {"112000000","112125000","安全、防护用品加工"},
                {"112000000","112126000","二手安防设备"},
                {"112000000","112127000","其他未分类"},
                {"1","113000000","交通运输"},
                {"113000000","113101000","非机动车"},
                {"113000000","113102000","非机动车配件"},
                {"113000000","113103000","商用车"},
                {"113000000","113104000","乘用车"},
                {"113000000","113105000","其他专用汽车"},
                {"113000000","113106000","摩托车"},
                {"113000000","113107000","拖拉机"},
                {"113000000","113108000","船舶"},
                {"113000000","113109000","船舶专用配件"},
                {"113000000","113110000","轨道交通设备器材"},
                {"113000000","113111000","飞机及配件"},
                {"113000000","113112000","交通安全设备"},
                {"113000000","113113000","停车场设备"},
                {"113000000","113114000","加油站设备"},
                {"113000000","113115000","航道设施"},
                {"113000000","113116000","运输搬运设备"},
                {"113000000","113117000","起重装卸设备"},
                {"113000000","113118000","通用输送设备"},
                {"113000000","113119000","仓储设备"},
                {"113000000","113120000","集装整理设备"},
                {"113000000","113121000","物流辅助器材"},
                {"113000000","113122000","物流服务"},
                {"113000000","113123000","物流管理软件"},
                {"113000000","113124000","二手交通工具"},
                {"113000000","113125000","二手物流设备"},
                {"113000000","113126000","交通工具项目合作"},
                {"113000000","113127000","交通运输产品加工"},
                {"113000000","113128000","交通工具代理"},
                {"113000000","113129000","库存交通工具"},
                {"113000000","113130000","其他未分类"},
                {"1","114000000","家用电器"},
                {"114000000","114101000","收音、录音机"},
                {"114000000","114102000","碟机"},
                {"114000000","114103000","电视机"},
                {"114000000","114104000","音响产品"},
                {"114000000","114105000","视听周边设备"},
                {"114000000","114106000","MP4"},
                {"114000000","114107000","家庭影院"},
                {"114000000","114108000","录像机"},
                {"114000000","114109000","空调"},
                {"114000000","114110000","电风扇"},
                {"114000000","114111000","饮水机"},
                {"114000000","114112000","电暖器、取暖器"},
                {"114000000","114113000","空气净化器"},
                {"114000000","114114000","湿度调节器"},
                {"114000000","114115000","家用吸尘器"},
                {"114000000","114116000","电驱蚊器"},
                {"114000000","114117000","遥控器"},
                {"114000000","114118000","氧气机"},
                {"114000000","114119000","家电制造设备"},
                {"114000000","114120000","二手家用电器"},
                {"114000000","114121000","库存家用电器"},
                {"114000000","114122000","家用电器产品代理"},
                {"114000000","114123000","家用电器加工"},
                {"114000000","114124000","家电项目合作"},
                {"114000000","114125000","其他未分类"},
                {"114000000","114126000","热水器"},
                {"114000000","114127000","洗衣机、干衣机"},
                {"114000000","114128000","浴霸"},
                {"114000000","114129000","电吹风"},
                {"114000000","114130000","干手机机"},
                {"114000000","114131000","柔巾机"},
                {"114000000","114132000","理发器"},
                {"114000000","114133000","给皂液机"},
                {"114000000","114134000","电熨斗"},
                {"114000000","114135000","冰箱、冷柜"},
                {"114000000","114136000","家用净水器"},
                {"114000000","114137000","电灶具"},
                {"114000000","114138000","电热壶、电热杯"},
                {"114000000","114139000","电饭煲、电饭锅"},
                {"114000000","114140000","多士炉、烤面包机"},
                {"114000000","114141000","微波炉"},
                {"114000000","114142000","抽油烟机"},
                {"114000000","114143000","消毒柜"},
                {"114000000","114144000","洗碗机"},
                {"114000000","114145000","烤箱"},
                {"114000000","114146000","排气、换气扇"},
                {"114000000","114147000","咖啡机"},
                {"114000000","114148000","榨汁机"},
                {"114000000","114149000","豆浆机"},
                {"114000000","114150000","煮蛋器"},
                {"114000000","114151000","垃圾处理机"},
                {"1","115000000","医药、保养"},
                {"115000000","115101000","中成药"},
                {"115000000","115102000","植物原药材"},
                {"115000000","115103000","动物原药材"},
                {"115000000","115104000","矿物原药材"},
                {"115000000","115105000","植物提取物"},
                {"115000000","115106000","中药饮片"},
                {"115000000","115107000","生物制品"},
                {"115000000","115108000","医药中间体"},
                {"115000000","115109000","原料药"},
                {"115000000","115110000","西药"},
                {"115000000","115111000","消毒防腐药剂"},
                {"115000000","115112000","酶(酵素)制剂"},
                {"115000000","115113000","畜用药"},
                {"115000000","115114000","保健用品"},
                {"115000000","115115000","保健食品"},
                {"115000000","115116000","保健茶"},
                {"115000000","115117000","药酒、保健酒"},
                {"115000000","115118000","功能饮料"},
                {"115000000","115119000","性保健品"},
                {"115000000","115120000","医用材料"},
                {"115000000","115121000","医疗设备"},
                {"115000000","115122000","医疗器具"},
                {"115000000","115123000","医用橡胶制品"},
                {"115000000","115124000","制药设备"},
                {"115000000","115125000","药用包装材料"},
                {"115000000","115126000","制药辅料"},
                {"115000000","115127000","医疗器械制造设备"},
                {"115000000","115128000","库存医药用品"},
                {"115000000","115129000","医疗保健服务"},
                {"115000000","115130000","医药项目合作"},
                {"115000000","115131000","保健项目合作"},
                {"115000000","115132000","二手制药设备"},
                {"115000000","115133000","二手医疗设备"},
                {"115000000","115134000","药品加工"},
                {"115000000","115135000","医疗器械加工"},
                {"115000000","115136000","保健用品加工"},
                {"115000000","115137000","医药代理"},
                {"115000000","115138000","医疗器械代理"},
                {"115000000","115139000","保健品代理"},
                {"115000000","115140000","其他未分类"},
                {"1","116000000","家具、家居用品"},
                {"116000000","116101000","箱包、袋、皮具"},
                {"116000000","116102000","餐具"},
                {"116000000","116103000","厨具"},
                {"116000000","116104000","炊具"},
                {"116000000","116105000","灶具"},
                {"116000000","116106000","厨房用纺织品"},
                {"116000000","116107000","个人护理用具"},
                {"116000000","116108000","塑料包装制品"},
                {"116000000","116109000","塑料工艺品"},
                {"116000000","116110000","清洁用具"},
                {"116000000","116111000","生活用纸"},
                {"116000000","116112000","钟表"},
                {"116000000","116113000","打火机及烟具"},
                {"116000000","116114000","保温容器"},
                {"116000000","116115000","雨具、太阳伞"},
                {"116000000","116116000","婴儿用品"},
                {"116000000","116117000","办公家具"},
                {"116000000","116118000","客厅家具"},
                {"116000000","116119000","餐厅家具"},
                {"116000000","116120000","卧室家具"},
                {"116000000","116121000","儿童家具"},
                {"116000000","116122000","门厅家具"},
                {"116000000","116123000","休闲家具"},
                {"116000000","116124000","酒店家具"},
                {"116000000","116125000","学校家具"},
                {"116000000","116126000","书房家具"},
                {"116000000","116127000","公共场所家具"},
                {"116000000","116128000","家具配件附件"},
                {"116000000","116129000","室内照明灯具"},
                {"116000000","116130000","床上用品"},
                {"116000000","116131000","日用挂摆饰"},
                {"116000000","116132000","家用塑料制品"},
                {"116000000","116133000","家用金属制品"},
                {"116000000","116134000","家用竹、木制品"},
                {"116000000","116135000","家用陶瓷、搪瓷制品"},
                {"116000000","116136000","家用玻璃制品"},
                {"116000000","116137000","衣架、衣夹"},
                {"116000000","116138000","家用衡器"},
                {"116000000","116139000","生活日用橡胶制品"},
                {"116000000","116140000","缝纫编织"},
                {"116000000","116141000","库存家居用品"},
                {"116000000","116142000","家居用品代理"},
                {"116000000","116143000","其他未分类"},
                {"1","117000000","照明"},
                {"117000000","117101000","白炽灯"},
                {"117000000","117102000","气体放电灯"},
                {"117000000","117103000","冷光源"},
                {"117000000","117104000","灯具配附件"},
                {"117000000","117105000","电光源材料"},
                {"117000000","117106000","插头"},
                {"117000000","117107000","插座"},
                {"117000000","117108000","绝缘材料"},
                {"117000000","117109000","其他未分类"},
                {"117000000","117110000","室外照明灯具"},
                {"117000000","117111000","室内照明灯具"},
                {"117000000","117112000","专门用途灯具"},
                {"117000000","117113000","车灯"},
                {"117000000","117114000","指示灯具"},
                {"117000000","117115000","手电筒"},
                {"117000000","117116000","电子加工"},
                {"117000000","117117000","二手照明器材"},
                {"117000000","117118000","照明器材代理"},
                {"117000000","117119000","照明器材项目合作"},
                {"117000000","117120000","库存照明器材"},
                {"1","118000000","建筑、建材"},
                {"118000000","118101000","建筑涂料"},
                {"118000000","118102000","建筑陶瓷"},
                {"118000000","118103000","建筑用粘合剂"},
                {"118000000","118104000","地板"},
                {"118000000","118105000","木质材料"},
                {"118000000","118106000","装饰线板"},
                {"118000000","118107000","地毯"},
                {"118000000","118108000","窗帘"},
                {"118000000","118109000","壁纸、壁布"},
                {"118000000","118110000","门"},
                {"118000000","118111000","窗"},
                {"118000000","118112000","门窗五金"},
                {"118000000","118113000","锁具"},
                {"118000000","118114000","石材石料"},
                {"118000000","118115000","耐火、防火材料"},
                {"118000000","118116000","防水、防潮材料"},
                {"118000000","118117000","保温、隔热材料"},
                {"118000000","118118000","隔音、吸声材料"},
                {"118000000","118119000","绝缘材料"},
                {"118000000","118120000","塑料建材"},
                {"118000000","118121000","金属建材"},
                {"118000000","118122000","特种建材"},
                {"118000000","118123000","建筑玻璃"},
                {"118000000","118124000","隔断与吊顶"},
                {"118000000","118125000","工地施工材料"},
                {"118000000","118126000","水泥"},
                {"118000000","118127000","陶瓷"},
                {"118000000","118128000","砖瓦及砌块"},
                {"118000000","118129000","混凝土制品"},
                {"118000000","118130000","石灰、石膏"},
                {"118000000","118131000","沥青"},
                {"118000000","118132000","砂浆"},
                {"118000000","118133000","钢结构"},
                {"118000000","118134000","管材"},
                {"118000000","118135000","管件"},
                {"118000000","118136000","厨房设施"},
                {"118000000","118137000","水暖五金"},
                {"118000000","118138000","卫浴用五金件"},
                {"118000000","118139000","淋浴房、淋浴器"},
                {"118000000","118140000","面盆及配件"},
                {"118000000","118141000","座厕及配件"},
                {"118000000","118142000","花洒及配件"},
                {"118000000","118143000","浴缸及配件"},
                {"118000000","118144000","台面"},
                {"118000000","118145000","楼宇设施"},
                {"118000000","118146000","管道系统"},
                {"118000000","118147000","室内照明灯具"},
                {"118000000","118148000","工程与建筑机械"},
                {"118000000","118149000","工程承包"},
                {"118000000","118150000","不动产"},
                {"118000000","118151000","活动房"},
                {"118000000","118152000","信报箱"},
                {"118000000","118153000","超市购物车"},
                {"118000000","118154000","陶瓷生产加工机械"},
                {"118000000","118155000","建材生产加工机械"},
                {"118000000","118156000","镜台"},
                {"118000000","118157000","作业保护"},
                {"118000000","118158000","匠作工具"},
                {"118000000","118159000","库存建材"},
                {"118000000","118160000","二手建材加工设备"},
                {"118000000","118161000","石材加工"},
                {"118000000","118162000","建材加工"},
                {"118000000","118163000","装饰建材代理"},
                {"118000000","118164000","建筑项目合作"},
                {"118000000","118165000","其他未分类"},
                {"1","119000000","电工电气"},
                {"119000000","119101000","开关"},
                {"119000000","119102000","低压电器"},
                {"119000000","119103000","高压电器"},
                {"119000000","119104000","电动机"},
                {"119000000","119105000","发电机、发电机组"},
                {"119000000","119106000","配电输电设备"},
                {"119000000","119107000","电线、电缆"},
                {"119000000","119108000","插座"},
                {"119000000","119109000","插头"},
                {"119000000","119110000","电池"},
                {"119000000","119111000","充电器"},
                {"119000000","119112000","绝缘材料"},
                {"119000000","119113000","电热设备"},
                {"119000000","119114000","工控系统及装备"},
                {"119000000","119115000","电工仪器仪表"},
                {"119000000","119116000","防静电产品"},
                {"119000000","119117000","连接器"},
                {"119000000","119118000","节电设备"},
                {"119000000","119119000","装配电动工具"},
                {"119000000","119120000","磨抛光电动工具"},
                {"119000000","119121000","切削电动工具"},
                {"119000000","119122000","焊接材料与附件"},
                {"119000000","119123000","天线"},
                {"119000000","119124000","电工电气产品加工"},
                {"119000000","119125000","库存电工电气产品"},
                {"119000000","119126000","电工电气产品代理"},
                {"119000000","119127000","电工电气项目合作"},
                {"119000000","119128000","二手电工电气产品"},
                {"119000000","119129000","电子工业用助剂"},
                {"119000000","119130000","其他未分类"},
                {"1","120000000","食品、饮料"},
                {"120000000","120101000","生鲜水果"},
                {"120000000","120102000","鲜活水产品"},
                {"120000000","120103000","粮食"},
                {"120000000","120104000","新鲜蔬菜"},
                {"120000000","120105000","食用菌"},
                {"120000000","120106000","禽类"},
                {"120000000","120107000","禽蛋"},
                {"120000000","120108000","咖啡豆、可可"},
                {"120000000","120109000","蔬菜制品"},
                {"120000000","120110000","茶叶"},
                {"120000000","120111000","米面类"},
                {"120000000","120112000","肉类"},
                {"120000000","120113000","粗加工水产品"},
                {"120000000","120114000","食用油"},
                {"120000000","120115000","糖类"},
                {"120000000","120116000","淀粉"},
                {"120000000","120117000","蜜制品"},
                {"120000000","120118000","果肉、粉、原浆"},
                {"120000000","120119000","酒类"},
                {"120000000","120120000","软饮料"},
                {"120000000","120121000","冲饮品"},
                {"120000000","120122000","冷饮"},
                {"120000000","120123000","调味品"},
                {"120000000","120124000","保健食品"},
                {"120000000","120125000","休闲食品"},
                {"120000000","120126000","方便食品"},
                {"120000000","120127000","罐头食品"},
                {"120000000","120128000","肉制品"},
                {"120000000","120129000","面包"},
                {"120000000","120130000","乳制品"},
                {"120000000","120131000","豆制品"},
                {"120000000","120132000","蛋制品"},
                {"120000000","120133000","食品、饮料加工设备"},
                {"120000000","120134000","食品添加剂"},
                {"120000000","120135000","食品饮料代理"},
                {"120000000","120136000","食品饮料项目合作"},
                {"120000000","120137000","食品饮料加工"},
                {"120000000","120138000","二手食品机械"},
                {"120000000","120139000","库存食品、饮料"},
                {"120000000","120140000","食品储运设备"},
                {"120000000","120141000","其他未分类"},
                {"1","121000000","办公、文教"},
                {"121000000","121101000","收纳用品"},
                {"121000000","121102000","装订用品"},
                {"121000000","121103000","涂改用品"},
                {"121000000","121104000","胶粘用品"},
                {"121000000","121105000","美术用品"},
                {"121000000","121106000","绘图文具"},
                {"121000000","121107000","会计用品"},
                {"121000000","121108000","裁剪用品"},
                {"121000000","121109000","计算器"},
                {"121000000","121110000","证卡、奖品"},
                {"121000000","121111000","文具配件"},
                {"121000000","121112000","书写板、擦"},
                {"121000000","121113000","教学模型、器材"},
                {"121000000","121114000","实验室用品"},
                {"121000000","121115000","实验室专用设备"},
                {"121000000","121116000","学校家具"},
                {"121000000","121117000","复读机、学习机"},
                {"121000000","121118000","PDA"},
                {"121000000","121119000","教育教学软件"},
                {"121000000","121120000","文教用橡胶制品"},
                {"121000000","121121000","文化办公设备"},
                {"121000000","121122000","办公家具"},
                {"121000000","121123000","办公用纸"},
                {"121000000","121124000","打印机耗材"},
                {"121000000","121125000","光学仪器"},
                {"121000000","121126000","摄影器材"},
                {"121000000","121127000","眼镜及配件"},
                {"121000000","121128000","相纸"},
                {"121000000","121129000","胶片、胶卷"},
                {"121000000","121130000","光学计量标准器具"},
                {"121000000","121131000","光学加工机械"},
                {"121000000","121132000","摄影、摄像服务"},
                {"121000000","121133000","办公挂摆饰"},
                {"121000000","121134000","翻译"},
                {"121000000","121135000","库存办公、文教用品"},
                {"121000000","121136000","二手办公设备"},
                {"121000000","121137000","办公文教用品加工"},
                {"121000000","121138000","办公文教用品代理"},
                {"121000000","121139000","办公、文教项目合作"},
                {"121000000","121140000","其他未分类"},
                {"121000000","121141000","摄像器材"},
                {"1","122000000","运动、休闲"},
                {"122000000","122101000","田径用品"},
                {"122000000","122102000","篮球用品"},
                {"122000000","122103000","足球用品"},
                {"122000000","122104000","排球用品"},
                {"122000000","122105000","网球用品"},
                {"122000000","122106000","羽毛球用品"},
                {"122000000","122107000","乒乓球用品"},
                {"122000000","122108000","高尔夫用品"},
                {"122000000","122109000","棒球、垒球用品"},
                {"122000000","122110000","台球用品"},
                {"122000000","122111000","保龄球用品"},
                {"122000000","122112000","曲棍球、橄榄球用品"},
                {"122000000","122113000","水上运动用品"},
                {"122000000","122114000","溜冰、滑雪用品"},
                {"122000000","122115000","极限运动用品"},
                {"122000000","122116000","射击、射箭用品"},
                {"122000000","122117000","击剑、武术用品"},
                {"122000000","122118000","举重用品"},
                {"122000000","122119000","马术用具"},
                {"122000000","122120000","沙狐球用品"},
                {"122000000","122121000","运动护具"},
                {"122000000","122122000","体育运动配套产品"},
                {"122000000","122123000","运动鞋"},
                {"122000000","122124000","运动服装"},
                {"122000000","122125000","运动帽"},
                {"122000000","122126000","太阳镜"},
                {"122000000","122127000","酒店客房用品"},
                {"122000000","122128000","酒店大堂用品"},
                {"122000000","122129000","餐饮设备"},
                {"122000000","122130000","桑拿、足浴设备"},
                {"122000000","122131000","酒店家具"},
                {"122000000","122132000","吧台"},
                {"122000000","122133000","宾馆服务"},
                {"122000000","122134000","健身器材"},
                {"122000000","122135000","户外用品"},
                {"122000000","122136000","烧烤用具"},
                {"122000000","122137000","行李车"},
                {"122000000","122138000","拉杆箱、行李箱"},
                {"122000000","122139000","旅行包"},
                {"122000000","122140000","票务"},
                {"122000000","122141000","旅游服务"},
                {"122000000","122142000","滑板车"},
                {"122000000","122143000","游艺设施"},
                {"122000000","122144000","棋牌"},
                {"122000000","122145000","乐器"},
                {"122000000","122146000","宠物用品"},
                {"122000000","122147000","飞镖"},
                {"122000000","122148000","垂钓用品"},
                {"122000000","122149000","水族器材"},
                {"122000000","122150000","宠物"},
                {"122000000","122151000","舞蹈、戏剧用品"},
                {"122000000","122152000","纪念品"},
                {"122000000","122153000","库存照明器材"},
                {"122000000","122154000","库存体育运动产品"},
                {"122000000","122155000","库存娱乐休闲产品"},
                {"122000000","122156000","二手体育休闲设施"},
                {"122000000","122157000","二手通用零部件"},
                {"122000000","122158000","娱乐休闲产品代理"},
                {"122000000","122159000","体育运动产品加工"},
                {"122000000","122160000","娱乐休闲产品加工"},
                {"122000000","122161000","体育运动项目合作"},
                {"122000000","122162000","娱乐休闲项目合作"},
                {"122000000","122163000","其他未分类"},
                {"1","123000000","电子元器件"},
                {"123000000","123101000","二极管"},
                {"123000000","123102000","三极管"},
                {"123000000","123103000","电容器"},
                {"123000000","123104000","电阻器"},
                {"123000000","123105000","电位器"},
                {"123000000","123106000","集成电路"},
                {"123000000","123107000","变压器"},
                {"123000000","123108000","稳压器"},
                {"123000000","123109000","继电器"},
                {"123000000","123110000","变频器"},
                {"123000000","123111000","连接器"},
                {"123000000","123112000","保险元器件"},
                {"123000000","123113000","调频器"},
                {"123000000","123114000","印刷线路板"},
                {"123000000","123115000","开关元件"},
                {"123000000","123116000","光电子、激光器件"},
                {"123000000","123117000","显示器件"},
                {"123000000","123118000","逆变器"},
                {"123000000","123119000","放大器"},
                {"123000000","123120000","整流器"},
                {"123000000","123121000","工业编码器"},
                {"123000000","123122000","场效应管"},
                {"123000000","123123000","传感器"},
                {"123000000","123124000","电感器"},
                {"123000000","123125000","绝缘材料"},
                {"123000000","123126000","磁性材料"},
                {"123000000","123127000","电子五金件"},
                {"123000000","123128000","电工陶瓷材料"},
                {"123000000","123129000","电磁铁"},
                {"123000000","123130000","屏蔽材料"},
                {"123000000","123131000","压电晶体材料"},
                {"123000000","123132000","覆铜板材料"},
                {"123000000","123133000","半导体材料"},
                {"123000000","123134000","电声配件"},
                {"123000000","123135000","扬声器"},
                {"123000000","123136000","录音磁头"},
                {"123000000","123137000","蜂鸣器"},
                {"123000000","123138000","受话器"},
                {"123000000","123139000","传声器"},
                {"123000000","123140000","电子加工"},
                {"123000000","123141000","电子产品制造设备"},
                {"123000000","123142000","开关"},
                {"123000000","123143000","电子元器件、材料代理"},
                {"123000000","123144000","库存电子元器件、材料"},
                {"123000000","123145000","电子项目合作"},
                {"123000000","123146000","其他未分类"},
                {"1","124000000","农业"},
                {"124000000","124101000","粮食"},
                {"124000000","124102000","米面类"},
                {"124000000","124103000","含油子仁、果仁、籽"},
                {"124000000","124104000","食用油"},
                {"124000000","124105000","新鲜蔬菜"},
                {"124000000","124106000","辛辣蔬菜"},
                {"124000000","124107000","食用菌"},
                {"124000000","124108000","蔬菜制品"},
                {"124000000","124109000","生鲜水果"},
                {"124000000","124110000","坚果、干果"},
                {"124000000","124111000","茶叶"},
                {"124000000","124112000","咖啡豆、可可"},
                {"124000000","124113000","牲畜"},
                {"124000000","124114000","禽类"},
                {"124000000","124115000","生皮、毛皮"},
                {"124000000","124116000","动物毛鬃"},
                {"124000000","124117000","羽毛、羽绒"},
                {"124000000","124118000","鲜活水产品"},
                {"124000000","124119000","粗加工水产品"},
                {"124000000","124120000","肉类"},
                {"124000000","124121000","肠衣"},
                {"124000000","124122000","禽蛋"},
                {"124000000","124123000","蛋制品"},
                {"124000000","124124000","淀粉"},
                {"124000000","124125000","烟草"},
                {"124000000","124126000","蜜制品"},
                {"124000000","124127000","棉类"},
                {"124000000","124128000","麻类"},
                {"124000000","124129000","蚕茧、蚕丝"},
                {"124000000","124130000","绿化苗木"},
                {"124000000","124131000","花卉"},
                {"124000000","124132000","花卉种子、种苗"},
                {"124000000","124133000","园艺用具"},
                {"124000000","124134000","庭院灯"},
                {"124000000","124135000","园林石工艺品"},
                {"124000000","124136000","雕塑"},
                {"124000000","124137000","长椅"},
                {"124000000","124138000","种子、种苗"},
                {"124000000","124139000","饲料"},
                {"124000000","124140000","饲料添加剂"},
                {"124000000","124141000","农药原药"},
                {"124000000","124142000","农药制剂"},
                {"124000000","124143000","化肥"},
                {"124000000","124144000","生物肥料"},
                {"124000000","124145000","植物生长调节剂"},
                {"124000000","124146000","畜用药"},
                {"124000000","124147000","农业用具"},
                {"124000000","124148000","渔业用具"},
                {"124000000","124149000","农业用橡胶制品"},
                {"124000000","124150000","工农业用塑料制品"},
                {"124000000","124151000","农业机械"},
                {"124000000","124152000","棉麻毛初加工设备"},
                {"124000000","124153000","二手农业机械"},
                {"124000000","124154000","植物提取物"},
                {"124000000","124155000","动物提取物"},
                {"124000000","124156000","植物原药材"},
                {"124000000","124157000","动物原药材"},
                {"124000000","124158000","原木"},
                {"124000000","124159000","竹木、藤苇、干草"},
                {"124000000","124160000","木炭"},
                {"124000000","124161000","农副产品加工"},
                {"124000000","124162000","农产品代理"},
                {"124000000","124163000","库存农产品"},
                {"124000000","124164000","农林牧渔项目合作"},
                {"124000000","124165000","其他未分类"},
                {"1","125000000","环保"},
                {"125000000","125101000","污水处理设备"},
                {"125000000","125102000","原水处理设备"},
                {"125000000","125103000","空气净化装置"},
                {"125000000","125104000","公共环卫设施"},
                {"125000000","125105000","消音降噪设备"},
                {"125000000","125106000","分析仪器"},
                {"125000000","125107000","过滤设备"},
                {"125000000","125108000","风机、排风设备"},
                {"125000000","125109000","清洗、清理设备"},
                {"125000000","125110000","化工废料"},
                {"125000000","125111000","废金属"},
                {"125000000","125112000","废纸"},
                {"125000000","125113000","纺织废料"},
                {"125000000","125114000","皮革废料"},
                {"125000000","125115000","废电子电器"},
                {"125000000","125116000","电子浆料"},
                {"125000000","125117000","水处理化学品"},
                {"125000000","125118000","空气处理化学品"},
                {"125000000","125119000","过滤材料"},
                {"125000000","125120000","填料"},
                {"125000000","125121000","环保项目合作"},
                {"125000000","125122000","环保设备代理"},
                {"125000000","125123000","环保设备加工"},
                {"125000000","125124000","二手环保设备"},
                {"125000000","125125000","其他未分类"},
                {"1","126000000","冶金矿产"},
                {"126000000","126101000","轻有色金属"},
                {"126000000","126102000","重有色金属"},
                {"126000000","126103000","稀有金属"},
                {"126000000","126104000","贵金属"},
                {"126000000","126105000","半金属"},
                {"126000000","126106000","有色金属合金"},
                {"126000000","126107000","有色金属加工材"},
                {"126000000","126108000","非金属矿产"},
                {"126000000","126109000","有色金属矿产"},
                {"126000000","126110000","黑色金属矿产"},
                {"126000000","126111000","非金属矿物制品"},
                {"126000000","126112000","地矿勘测设备"},
                {"126000000","126113000","矿山施工设备"},
                {"126000000","126114000","选矿设备"},
                {"126000000","126115000","矿业输送设备"},
                {"126000000","126116000","矿业装卸设备"},
                {"126000000","126117000","二手矿业设备"},
                {"126000000","126118000","矿物代理"},
                {"126000000","126119000","矿业项目合作"},
                {"126000000","126120000","普通钢材"},
                {"126000000","126121000","不锈钢材"},
                {"126000000","126122000","特殊钢材"},
                {"126000000","126123000","炉料"},
                {"126000000","126124000","磁性材料"},
                {"126000000","126125000","金属丝、绳"},
                {"126000000","126126000","金属网"},
                {"126000000","126127000","粉末冶金"},
                {"126000000","126128000","井盖"},
                {"126000000","126129000","废金属"},
                {"126000000","126130000","库存金属材料"},
                {"126000000","126131000","冶炼设备"},
                {"126000000","126132000","铸造及热处理设备"},
                {"126000000","126133000","金属成型设备"},
                {"126000000","126134000","二手冶炼设备"},
                {"126000000","126135000","金属材料代理"},
                {"126000000","126136000","冶炼加工"},
                {"126000000","126137000","冶金项目合作"},
                {"126000000","126138000","其他未分类"},
                {"1","127000000","通讯产品"},
                {"127000000","127101000","固定电话"},
                {"127000000","127102000","移动电话"},
                {"127000000","127103000","电话机配附件"},
                {"127000000","127104000","移动电话配附件"},
                {"127000000","127105000","手机饰品"},
                {"127000000","127106000","电话卡"},
                {"127000000","127107000","RF模块"},
                {"127000000","127108000","传真机"},
                {"127000000","127109000","寻呼机"},
                {"127000000","127110000","对讲机"},
                {"127000000","127111000","GPS系统"},
                {"127000000","127112000","天线"},
                {"127000000","127113000","传输、交换设备"},
                {"127000000","127114000","接续设备"},
                {"127000000","127115000","通信线缆"},
                {"127000000","127116000","布线产品"},
                {"127000000","127117000","接入设备"},
                {"127000000","127118000","网络测试设备"},
                {"127000000","127119000","无线网络设备"},
                {"127000000","127120000","VPN设备"},
                {"127000000","127121000","声讯系统"},
                {"127000000","127122000","短信系统"},
                {"127000000","127123000","通讯检测仪器"},
                {"127000000","127124000","通讯产品代理"},
                {"127000000","127125000","库存通讯产品"},
                {"127000000","127126000","库存通信器材"},
                {"127000000","127127000","二手通讯产品"},
                {"127000000","127128000","二手通信器材"},
                {"127000000","127129000","通讯产品加工"},
                {"127000000","127130000","其他未分类"},
                {"127000000","127131000","其他频率元件"},
                {"1","128000000","包装"},
                {"128000000","128101000","胶带"},
                {"128000000","128102000","标签、标牌"},
                {"128000000","128103000","托盘"},
                {"128000000","128104000","绳索、扎带"},
                {"128000000","128105000","包装相关设备"},
                {"128000000","128106000","包装成型机械"},
                {"128000000","128107000","包装检测设备"},
                {"128000000","128108000","二手包装机械"},
                {"128000000","128109000","包装印刷加工"},
                {"128000000","128110000","包装产品加工"},
                {"128000000","128111000","包装产品代理"},
                {"128000000","128112000","包装项目合作"},
                {"128000000","128113000","包装材料"},
                {"128000000","128114000","塑料包装制品"},
                {"128000000","128115000","纸类包装制品"},
                {"128000000","128116000","金属包装制品"},
                {"128000000","128117000","竹木包装制品"},
                {"128000000","128118000","布料包装制品"},
                {"128000000","128119000","复合材料包装制品"},
                {"128000000","128120000","包装制品配附件"},
                {"128000000","128121000","包装防伪"},
                {"128000000","128122000","其他未分类"},
                {"1","129000000","传媒"},
                {"129000000","129101000","书籍"},
                {"129000000","129102000","图片、画册"},
                {"129000000","129103000","挂历"},
                {"129000000","129104000","台历"},
                {"129000000","129105000","报纸"},
                {"129000000","129106000","期刊"},
                {"129000000","129107000","音像制品"},
                {"129000000","129108000","电子读物"},
                {"129000000","129109000","版权转让"},
                {"129000000","129110000","库存图书"},
                {"129000000","129111000","库存音像制品"},
                {"129000000","129112000","图书代理"},
                {"129000000","129113000","音像制品代理"},
                {"129000000","129114000","音像制品加工"},
                {"129000000","129115000","出版项目合作"},
                {"129000000","129116000","广告、展览器材"},
                {"129000000","129117000","广告礼品"},
                {"129000000","129118000","摄影、摄像服务"},
                {"129000000","129119000","二手广电设备"},
                {"129000000","129120000","影视节目合作"},
                {"129000000","129121000","舞台设备"},
                {"129000000","129122000","专业录音、放音设备"},
                {"129000000","129123000","摄影器材"},
                {"129000000","129124000","编辑制作设备"},
                {"129000000","129125000","播出、前端设备"},
                {"129000000","129126000","无线卫星设备"},
                {"129000000","129127000","无线微波设备"},
                {"129000000","129128000","有线光缆设备"},
                {"129000000","129129000","有线线缆设备"},
                {"129000000","129130000","IP设备"},
                {"129000000","129131000","接入设备"},
                {"129000000","129132000","公共广播系统"},
                {"129000000","129133000","电影放映设备"},
                {"129000000","129134000","影视节目制作"},
                {"129000000","129135000","其他未分类"},
                {"129000000","129136000","广告服务"},
                {"129000000","129137000","摄像器材"},
                {"1","130000000","纸业"},
                {"130000000","130101000","包装用纸"},
                {"130000000","130102000","生活用纸"},
                {"130000000","130103000","文化、印刷用纸"},
                {"130000000","130104000","办公用纸"},
                {"130000000","130105000","工业用纸"},
                {"130000000","130106000","壁纸、壁布"},
                {"130000000","130107000","其他用途纸"},
                {"130000000","130108000","色标、色卡"},
                {"130000000","130109000","废纸"},
                {"130000000","130110000","纸浆"},
                {"130000000","130111000","造纸化学品"},
                {"130000000","130112000","造纸设备及配件"},
                {"130000000","130113000","纸加工机械"},
                {"130000000","130114000","造纸检测仪器"},
                {"130000000","130115000","二手纸加工设备"},
                {"130000000","130116000","二手造纸设备"},
                {"130000000","130117000","纸加工"},
                {"130000000","130118000","纸品加工"},
                {"130000000","130119000","纸及纸品代理"},
                {"130000000","130120000","纸及纸品项目合作"},
                {"130000000","130121000","其他未分类"},
                {"1","131000000","玩具"},
                {"131000000","131101000","动物玩具"},
                {"131000000","131102000","娃娃"},
                {"131000000","131103000","玩具车"},
                {"131000000","131104000","玩具飞机"},
                {"131000000","131105000","玩具船"},
                {"131000000","131106000","玩具珠、球"},
                {"131000000","131107000","玩具枪"},
                {"131000000","131108000","玩具刀剑"},
                {"131000000","131109000","充气玩具"},
                {"131000000","131110000","木偶玩具"},
                {"131000000","131111000","玩具电话"},
                {"131000000","131112000","玩具乐器"},
                {"131000000","131113000","电子游戏机"},
                {"131000000","131114000","电子宠物"},
                {"131000000","131115000","童车"},
                {"131000000","131116000","面具"},
                {"131000000","131117000","圣诞用品"},
                {"131000000","131118000","益智玩具"},
                {"131000000","131119000","模型玩具"},
                {"131000000","131120000","模仿成套玩具"},
                {"131000000","131121000","动漫主题玩具"},
                {"131000000","131122000","游戏主题玩具"},
                {"131000000","131123000","影视主题玩具"},
                {"131000000","131124000","整人玩具"},
                {"131000000","131125000","魔术玩具"},
                {"131000000","131126000","婴儿玩具"},
                {"131000000","131127000","玩具配件"},
                {"131000000","131128000","玩具加工设备"},
                {"131000000","131129000","库存玩具"},
                {"131000000","131130000","玩具设计加工"},
                {"131000000","131131000","玩具代理"},
                {"131000000","131132000","玩具项目合作"},
                {"131000000","131133000","其他未分类"},
                {"131000000","131134000","游艺设施"},
                {"131000000","131135000","宠物玩具"},
                {"131000000","131136000","脚踏滑板车"},
                {"131000000","131137000","飞碟、飞盘"},
                {"131000000","131138000","陀螺、风车"},
                {"1","132000000"," 印刷"},
                {"132000000","132101000","文化、印刷用纸"},
                {"132000000","132102000","塑料薄膜"},
                {"132000000","132103000","镀锡钢板"},
                {"132000000","132104000","橡皮布"},
                {"132000000","132105000","版材"},
                {"132000000","132106000","胶片、胶卷"},
                {"132000000","132107000","油墨"},
                {"132000000","132108000","信息用化学品"},
                {"132000000","132109000","包装印刷加工"},
                {"132000000","132110000","商业印刷加工"},
                {"132000000","132111000","书刊印刷加工"},
                {"132000000","132112000","印前处理设备"},
                {"132000000","132113000","印刷机"},
                {"132000000","132114000","印后加工设备"},
                {"132000000","132115000","印刷机械专用配件"},
                {"132000000","132116000","印刷检测仪器"},
                {"132000000","132117000","二手印刷设备"},
                {"132000000","132118000","防伪技术产品"},
                {"132000000","132119000","色标、色卡"},
                {"132000000","132120000","印刷项目合作"},
                {"132000000","132121000","印刷耗材代理"},
                {"132000000","132122000","其他未分类"},
                {"1","133000000","纺织、皮革"},
                {"133000000","133101000","天然纺织原料"},
                {"133000000","133102000","化学纤维"},
                {"133000000","133103000","纱线"},
                {"133000000","133104000","棉类系列面料"},
                {"133000000","133105000","麻类系列面料"},
                {"133000000","133106000","毛纺系列面料"},
                {"133000000","133107000","丝绸系列面料"},
                {"133000000","133108000","混纺、交织类面料"},
                {"133000000","133109000","针织面料"},
                {"133000000","133110000","化纤面料、里料"},
                {"133000000","133111000","坯布"},
                {"133000000","133112000","非织造及工业用布"},
                {"133000000","133113000","色织、扎染、印花布"},
                {"133000000","133114000","其他面料"},
                {"133000000","133115000","反光材料"},
                {"133000000","133116000","纺织辅料"},
                {"133000000","133117000","纺织废料"},
                {"133000000","133118000","纺织设备和器材"},
                {"133000000","133119000","床上用品"},
                {"133000000","133120000","装饰用纺织品"},
                {"133000000","133121000","厨房用纺织品"},
                {"133000000","133122000","毯子"},
                {"133000000","133123000","毛巾"},
                {"133000000","133124000","纺织、编结工艺品"},
                {"133000000","133125000","皮革"},
                {"133000000","133126000","人造革"},
                {"133000000","133127000","合成革"},
                {"133000000","133128000","生皮、毛皮"},
                {"133000000","133129000","皮革化学品"},
                {"133000000","133130000","皮革废料"},
                {"133000000","133131000","箱包、袋、皮具"},
                {"133000000","133132000","皮革加工设备"},
                {"133000000","133133000","二手皮革加工设备"},
                {"133000000","133134000","库存纺织品"},
                {"133000000","133135000","库存皮革及制品"},
                {"133000000","133136000","二手纺织加工设备"},
                {"133000000","133137000","纺织品加工"},
                {"133000000","133138000","纺织加工"},
                {"133000000","133139000","皮革加工"},
                {"133000000","133140000","纺织、皮革制品代理"},
                {"133000000","133141000","纺织皮革相关项目合作"},
                {"133000000","133142000","其他未分类"},
                {"1","134000000","仪器、仪表"},
                {"134000000","134101000","量仪"},
                {"134000000","134102000","试验机"},
                {"134000000","134103000","分析仪器"},
                {"134000000","134104000","专用仪器仪表"},
                {"134000000","134105000","其他未分类"},
                {"134000000","134106000","二手仪器仪表"},
                {"134000000","134107000","光学仪器"},
                {"134000000","134108000","工业计时器"},
                {"134000000","134109000","计数器"},
                {"134000000","134110000","记录仪"},
                {"134000000","134111000","量具"},
                {"134000000","134112000","温度仪表"},
                {"134000000","134113000","压力仪表"},
                {"134000000","134114000","流量仪表"},
                {"134000000","134115000","物位仪表"},
                {"134000000","134116000","机械量仪表"},
                {"134000000","134117000","显示仪表"},
                {"134000000","134118000","控制（调节）仪表"},
                {"134000000","134119000","基地式仪表"},
                {"134000000","134120000","气动单元组合仪表"},
                {"134000000","134121000","电动单元组合仪表"},
                {"134000000","134122000","执行器"},
                {"134000000","134123000","集中控制装置"},
                {"134000000","134124000","自动化成套控制系统"},
                {"134000000","134125000","电工仪器仪表"},
                {"134000000","134126000","实验仪器装置"},
                {"134000000","134127000","电子测量仪器"},
                {"134000000","134128000","仪用电源"},
                {"134000000","134129000","仪器仪表配附件"},
                {"134000000","134130000","衡器"},
                {"134000000","134131000","计量标准器具"},
                {"1","135000000","礼品、工艺品、饰品"},
                {"135000000","135101000","时尚配饰"},
                {"135000000","135102000","金银珠宝首饰"},
                {"135000000","135103000","摆挂件饰品"},
                {"135000000","135104000","手机饰品"},
                {"135000000","135105000","广告礼品"},
                {"135000000","135106000","节庆用品"},
                {"135000000","135107000","字画、工艺画"},
                {"135000000","135108000","贺卡"},
                {"135000000","135109000","相框、画框"},
                {"135000000","135110000","钟表"},
                {"135000000","135111000","打火机及烟具"},
                {"135000000","135112000","蜡烛及烛台"},
                {"135000000","135113000","钥匙扣、链、绳带"},
                {"135000000","135114000","熏香及熏香炉"},
                {"135000000","135115000","古董和收藏品"},
                {"135000000","135116000","闪光用品"},
                {"135000000","135117000","纪念品"},
                {"135000000","135118000","装饰盒"},
                {"135000000","135119000","模型玩具"},
                {"135000000","135120000","乐器"},
                {"135000000","135121000","礼品袋"},
                {"135000000","135122000","旗帜"},
                {"135000000","135123000","盆景"},
                {"135000000","135124000","鲜花"},
                {"135000000","135125000","殡葬用品"},
                {"135000000","135126000","库存工艺礼品"},
                {"135000000","135127000","金属工艺品"},
                {"135000000","135128000","竹木工艺品"},
                {"135000000","135129000","玻璃工艺品"},
                {"135000000","135130000","水晶工艺品"},
                {"135000000","135131000","陶瓷工艺品"},
                {"135000000","135132000","塑料工艺品"},
                {"135000000","135133000","纺织、编结工艺品"},
                {"135000000","135134000","雕刻工艺品"},
                {"135000000","135135000","民间工艺品"},
                {"135000000","135136000","石料工艺品"},
                {"135000000","135137000","植物编织工艺品"},
                {"135000000","135138000","树脂工艺品"},
                {"135000000","135139000","宝石玉石工艺品"},
                {"135000000","135140000","天然工艺品"},
                {"135000000","135141000","仿生仿真工艺品"},
                {"135000000","135142000","仿古工艺品"},
                {"135000000","135143000","纸制工艺品"},
                {"135000000","135144000","宗教工艺品"},
                {"135000000","135145000","雕塑"},
                {"135000000","135146000","工艺原料"},
                {"135000000","135147000","工艺用五金工具"},
                {"135000000","135148000","工艺礼品加工设备"},
                {"135000000","135149000","二手塑料机械"},
                {"135000000","135150000","工艺礼品加工"},
                {"135000000","135151000","饰品加工"},
                {"135000000","135152000","工艺礼品代理"},
                {"135000000","135153000","工艺礼品项目合作"},
                {"135000000","135154000","其他未分类"},
                {"1","136000000","加工"},
                {"136000000","136101000","激光加工"},
                {"136000000","136102000","包装印刷加工"},
                {"136000000","136103000","纺织品加工"},
                {"136000000","136104000","工艺礼品加工"},
                {"136000000","136105000","家居用品加工"},
                {"136000000","136106000","冶炼加工"},
                {"136000000","136107000","机械零部件加工"},
                {"136000000","136108000","模具加工"},
                {"136000000","136109000","电工电气产品加工"},
                {"136000000","136110000","化工产品加工"},
                {"136000000","136111000","办公文教用品加工"},
                {"136000000","136112000","玩具设计加工"},
                {"136000000","136113000","食品饮料加工"},
                {"136000000","136114000","农副产品加工"},
                {"136000000","136115000","包装产品加工"},
                {"136000000","136116000","通讯产品加工"},
                {"136000000","136117000","电脑产品加工"},
                {"136000000","136118000","家用电器加工"},
                {"136000000","136119000","安全、防护用品加工"},
                {"136000000","136120000","汽摩配件加工"},
                {"136000000","136121000","交通运输产品加工"},
                {"136000000","136122000","建材加工"},
                {"136000000","136123000","药品加工"},
                {"136000000","136124000","体育运动产品加工"},
                {"136000000","136125000","环保设备加工"},
                {"136000000","136126000","能源产品加工"},
                {"136000000","136127000","其他未分类"},
                {"136000000","136128000","鞋材、鞋件加工"},
                {"136000000","136129000","医疗器械加工"},
                {"136000000","136130000","音像制品加工"},
                {"136000000","136131000","仪器仪表加工"},
                {"136000000","136132000","行业专用设备加工"},
                {"136000000","136133000","五金工具加工"},
                {"136000000","136134000","饰品加工"},
                {"136000000","136135000","服饰加工"},
                {"136000000","136136000","成品鞋加工"},
                {"136000000","136137000","喷涂加工"},
                {"136000000","136138000","石材加工"},
                {"136000000","136139000","竹木加工"},
                {"136000000","136140000","纸加工"},
                {"136000000","136141000","电子加工"},
                {"136000000","136142000","金属加工"},
                {"136000000","136143000","玻璃加工"},
                {"136000000","136144000","陶瓷加工"},
                {"136000000","136145000","塑料加工"},
                {"136000000","136146000","纺织加工"},
                {"136000000","136147000","皮革加工"},
                {"136000000","136148000","娱乐休闲产品加工"},
                {"136000000","136149000","保健用品加工"},
                {"136000000","136150000","商业印刷加工"},
                {"136000000","136151000","书刊印刷加工"},
                {"136000000","136152000","纸品加工"}
        };
        DbAdapter db = new DbAdapter();
        try
        {
            for(int i = 0;i < DEFAULT_TYPE.length;i++)
            {
                db.executeUpdate("INSERT INTO GoodsType(father,sequence,community,brand,typeState)VALUES(" + DEFAULT_TYPE[i][0] + ",0,'[DEFAULT]','/',0)");
			     int si = db.getInt("SELECT MAX(goodstype) FROM GoodsType");
                db.executeUpdate("INSERT INTO GoodsTypeLayer(goodstype, language, name,picture)VALUES(" + si + ",1, " + DbAdapter.cite(DEFAULT_TYPE[i][2]) + ",null)");
            }
        } finally
        {
            db.close();
        }
        return 1;
    }
}
