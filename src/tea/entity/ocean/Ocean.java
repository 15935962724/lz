package tea.entity.ocean;

import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Vector;

import tea.db.DbAdapter;
import tea.entity.Entity;

public class Ocean extends Entity
{
    private int id;
    private int passport; //护照类型  0 成人 1 学生
    private String name;
    private boolean sex; //1：男  0：女
    private String card;
    private String telephone; //电话 固定电话
    private String mobile; //手机
    private String address; //
    private String zip; //邮编
    private String email;
    private String babyname;
    private Date babybirth;
    private String babyage;
    private int income;
    private String interest;
    private String other;
    private String oceanorder; ///订单号 200902190001  
    private String oceancard; ///卡号
    private int orderstatic; ///订单状态 0 没有完成交易  1 完成交易 2 完成制卡 3 完成发放
    //2009年2月10日17:04:01 唐嗣达
    private Date drawdates; //护照领取时间
    private String drawnames; //护照的领取人
    private String drawcards; //护照的证件号
    private int drawtype; //护照领取类型 0 本人，1 其他人
    private int cardtype; //身份证\军官证\护照可选
    private int applycard; // 0 新办卡 1续办卡
    private int applycard3; // 0 三年以下，1  三年以上
    private String picpath; //照片
    private int replacetype; // 0  不允许代领，1 允许代领
    private BigDecimal money; //资金
    private Date regdatetime; //注册日期
    private Date updatetime; //修改日期
    private String updatemember; //修改人
    private Date maketime; //制卡时间
	private int education;//教育程度
	private int occupation;//职业
	private int urban;//市区,城市
	private int learnway;//信息获知途径
	private String bobo_interest;//您和宝宝的兴趣爱好
	private String bobo_interest_qita;//您和宝宝的兴趣爱好 其他 

    private String beijingorder; //首信易支付的订单号20090219-2486-0001
    public static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // DateFormat.getDateInstance();
    public static final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm"); //<SPAN ID=time_hm></SPAN>

    public static final String PASSPORT[] =
            {"成人卡","学生卡"};
    public static final String INCOME[] =
            {"4000元以下","4000元—7000元","7000元—10000元","10000元以上"};
    public static final String INTEREST[] =
			{"儿童节欢乐庆典","环保主题绘画展","清凉海滨环保游","户外运动新奇体验（如自驾旅游、高尔夫等）","海洋小卫士科普夏令营、冬令营□","走入幕后，探秘海豚海狮生活区、鱼类养殖区","参与爱心助学公益活动"};

    public static final String CARDTYPE[] =
            {"身份证","军官证","护照"};
	public static final String EDUCATION[] = {"专科以下","专科","本科","研究生","博士生及以上"};
	public static final String OCCUPA_TION[] = {"政府公务员","事业单位","国有企业","外资企业","民营企业"};
	public static final String URBAN_TYPE[] = {"--请选择地区--","海淀","朝阳","东城","西城","崇文","宣武","石景山","丰台","昌平","通州","顺义","大兴"};
	public static final String LEARN_WAY[] ={"朋友介绍","馆内参观","网络宣传","媒体报道","宣传资料"};
	public static final String BOBO_INTEREST[] = {"音乐","文学","摄影","书法","绘画","棋牌","舞蹈","旅游","游泳","高尔夫","足球","篮球","网球","保龄球","乒乓球","羽毛球"};
    public Ocean(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Ocean find(int id) throws SQLException
    {
        return new Ocean(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id,passport,name,sex,card,telephone,mobile,address,zip,email,babyname,babybirth,babyage,income,interest,other,oceanorder,oceancard,orderstatic,"+
							" drawdates,drawnames,drawtype,cardtype,applycard,applycard3,picpath,replacetype,money,drawcards,regdatetime,updatetime,updatemember,maketime,beijingorder,"+
							" education,occupation,urban,learnway,bobo_interest,bobo_interest_qita from Ocean where id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                passport = db.getInt(j++); //护照类型
                name = db.getString(j++);
                sex = db.getInt(j++) != 0; //1：男  0：女 真男假女
                card = db.getString(j++);
                telephone = db.getString(j++); //电话
                mobile = db.getString(j++); //手机
                address = db.getString(j++); //
                zip = db.getString(j++); //邮编
                email = db.getString(j++);
                babyname = db.getString(j++);
                babybirth = db.getDate(j++);
                babyage = db.getString(j++);
                income = db.getInt(j++);
                interest = db.getString(j++);
                other = db.getString(j++);
                oceanorder = db.getString(j++);
                oceancard = db.getString(j++);
                orderstatic = db.getInt(j++);
                drawdates = db.getDate(j++); //护照领取时间
                drawnames = db.getString(j++); //护照的领取人
                drawtype = db.getInt(j++); //护照领取类型
                cardtype = db.getInt(j++); //身份证\军官证\护照可选
                applycard = db.getInt(j++); // 0 新办卡 1续办卡
                applycard3 = db.getInt(j++); // 0 三年以下，1  三年以上
                picpath = db.getString(j++); //照片
                replacetype = db.getInt(j++);
                money = db.getBigDecimal(j++,2);
                drawcards = db.getString(j++);
                regdatetime = db.getDate(j++); //
                updatetime = db.getDate(j++);
                updatemember = db.getString(j++);
                maketime = db.getDate(j++);
                beijingorder = db.getString(j++);
				education = db.getInt(j++);
				occupation= db.getInt(j++);
				urban = db.getInt(j++);
				learnway=db.getInt(j++);
				bobo_interest=db.getString(j++);
				bobo_interest_qita=db.getString(j++);

            }
        } finally
        {
            db.close();
        }
    }

    public static void set(int id,int passport,String name,int sex,String card,String telephone,String mobile,String address,String zip,String email,String babyname,Date babybirth,String babyage,
						   int income,String interest,String other,String oceanorder,String oceancard,int orderstatic,int cardtype,int applycard,int applycard3,String picpath,
						   int replacetype,BigDecimal money,String beijingorder,int education ,int occupation,int urban,int learnway,String bobo_interest,String bobo_interest_qita) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date regdate = new Date();
        try
        {
            db.executeQuery("Select id from Ocean where id=" + id);
            if(db.next())
            {
                db.executeUpdate("Update Ocean set passport=" + passport + ",name=" + db.cite(name) + ",sex=" + sex + ",card=" + db.cite(card) + ",telephone=" + db.cite(telephone) + ","+
								" mobile=" + db.cite(mobile) + ",address=" + db.cite(address) + ",zip=" + db.cite(zip) + ",email=" + db.cite(email) + ",babyname=" + db.cite(babyname) + ","+
								" babybirth=" + db.cite(babybirth) + ",babyage=" + db.cite(babyage) + ",income=" + income + ",interest=" + db.cite(interest) + ",other=" + db.cite(other) + ","+
								" oceanorder=" + db.cite(oceanorder) + ",oceancard=" + db.cite(oceancard) + ",orderstatic=" + orderstatic + ",cardtype=" + cardtype + ",applycard=" + (applycard) + ","+
								" applycard3=" + applycard3 + ",picpath=" + db.cite(picpath) + ",replacetype=" + replacetype + ",money=" + money + ",education="+education+",occupation="+occupation+",urban="+urban+","+
						        " learnway ="+learnway+",bobo_interest="+db.cite(bobo_interest)+",bobo_interest_qita="+db.cite(bobo_interest_qita)+" where id=" + id);
            
           Ocean.appendMethodB("Update Ocean set passport=" + passport + ",name=" + db.cite(name) + ",sex=" + sex + ",card=" + db.cite(card) + ",telephone=" + db.cite(telephone) + ","+
					" mobile=" + db.cite(mobile) + ",address=" + db.cite(address) + ",zip=" + db.cite(zip) + ",email=" + db.cite(email) + ",babyname=" + db.cite(babyname) + ","+
					" babybirth=" + db.cite(babybirth) + ",babyage=" + db.cite(babyage) + ",income=" + income + ",interest=" + db.cite(interest) + ",other=" + db.cite(other) + ","+
					" oceanorder=" + db.cite(oceanorder) + ",oceancard=" + db.cite(oceancard) + ",orderstatic=" + orderstatic + ",cardtype=" + cardtype + ",applycard=" + (applycard) + ","+
					" applycard3=" + applycard3 + ",picpath=" + db.cite(picpath) + ",replacetype=" + replacetype + ",money=" + money + ",education="+education+",occupation="+occupation+",urban="+urban+","+
			        " learnway ="+learnway+",bobo_interest="+db.cite(bobo_interest)+",bobo_interest_qita="+db.cite(bobo_interest_qita)+" where id=" + id);
            
            } else
            {
                db.executeUpdate("insert into Ocean(passport,name,sex,card,telephone,mobile,address,zip,email,babyname,babybirth,babyage,income,interest,other,oceanorder,oceancard,"+
								 " orderstatic,cardtype,applycard,applycard3,picpath,replacetype,money,regdatetime,beijingorder,education,occupation,urban,learnway,bobo_interest,bobo_interest_qita)values(" + passport + "," + db.cite(name) + "," + sex + ","+
								 " " + db.cite(card) + "," + db.cite(telephone) + "," + db.cite(mobile) + "," + db.cite(address) + "," + db.cite(zip) + "," + db.cite(email) + "," + db.cite(babyname) + ","+
								 " " + db.cite(babybirth) + "," + db.cite(babyage) + "," + income + "," + db.cite(interest) + "," + db.cite(other) + "," + db.cite(oceanorder) + "," + db.cite(oceancard) + ","+
								 " " + orderstatic + "," + cardtype + "," + applycard + "," + applycard3 + "," + db.cite(picpath) + "," + replacetype + "," + money +
                                 "," + db.cite(regdate) + "," + db.cite(beijingorder) + ","+education+","+occupation+","+urban+","+learnway+","+db.cite(bobo_interest)+","+db.cite(bobo_interest_qita)+"     )");
                
                
                Ocean.appendMethodB("insert into Ocean(passport,name,sex,card,telephone,mobile,address,zip,email,babyname,babybirth,babyage,income,interest,other,oceanorder,oceancard,"+
						 " orderstatic,cardtype,applycard,applycard3,picpath,replacetype,money,regdatetime,beijingorder,education,occupation,urban,learnway,bobo_interest,bobo_interest_qita)values(" + passport + "," + db.cite(name) + "," + sex + ","+
						 " " + db.cite(card) + "," + db.cite(telephone) + "," + db.cite(mobile) + "," + db.cite(address) + "," + db.cite(zip) + "," + db.cite(email) + "," + db.cite(babyname) + ","+
						 " " + db.cite(babybirth) + "," + db.cite(babyage) + "," + income + "," + db.cite(interest) + "," + db.cite(other) + "," + db.cite(oceanorder) + "," + db.cite(oceancard) + ","+
						 " " + orderstatic + "," + cardtype + "," + applycard + "," + applycard3 + "," + db.cite(picpath) + "," + replacetype + "," + money +
                         "," + db.cite(regdate) + "," + db.cite(beijingorder) + ","+education+","+occupation+","+urban+","+learnway+","+db.cite(bobo_interest)+","+db.cite(bobo_interest_qita)+"     )");
            }
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeQuery("SELECT id FROM Ocean WHERE 1=1 " + sql);
            for(int i = 0;i < pos + size && db.next();i++)
            {
                if(i >= pos)
                {
                    v.addElement(db.getInt(1));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }
    public static int count(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("Select count(id) from Ocean where 1=1 " + sql);
            if(db.next())
            {

                num = db.getInt(1);
                return num;
            } else
            {
                return num;
            }
        } finally
        {
            db.close();
        }
    }

    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("Delete  Ocean where id= " + id);

        } finally
        {
            db.close();
        }
    }

    public String getAddress()
    {
        return address;
    }

    public String getBabyage()
    {
        return babyage;
    }

    public Date getBabybirth()
    {
        return babybirth;
    }

    public String getBabybirthtoString()
    {
        if(babybirth != null)
        {
            return Ocean.sdf.format(babybirth);
        } else
        {
            return "";
        }
    }


    public String getBabyname()
    {
        return babyname;
    }

    public String getCard()
    {
        return card;
    }

    public String getEmail()
    {
        return email;
    }

    public int getId()
    {
        return id;
    }

    public int getIncome()
    {
        return income;
    }

    public String getInterest()
    {
        return interest;
    }

    public String getMobile()
    {
        return mobile;
    }

    public String getName()
    {
        return name;
    }

    public String getOceancard()
    {
        return oceancard;
    }

    public String getOceanorder()
    {
        return oceanorder;
    }

    public int getOrderstatic()
    {
        return orderstatic;
    }

    public String getOther()
    {
        return other;
    }

    public int getPassport()
    {
        return passport;
    }

    public boolean isSex()
    {
        return sex;
    }

    public String getZip()
    {
        return zip;
    }

    public String getTelephone()
    {
        return telephone;
    }

    public int getApplycard()
    {
        return applycard;
    }

    public int getApplycard3()
    {
        return applycard3;
    }

    public int getDrawtype()
    {
        return drawtype;
    }

    public String getDrawnames()
    {
        return drawnames;
    }

    public Date getDrawdates()
    {
        return drawdates;
    }

    public String getDrawdatestoString()
    {
        if(drawdates != null)
        {
            return Ocean.sdf.format(drawdates);
        } else
        {
            return "";
        }
    }

    public int getCardtype()
    {
        return cardtype;
    }

    public String getPicpath()
    {
        return picpath;
    }

    public int getReplacetype()
    {
        return replacetype;
    }

    public BigDecimal getMoney()
    {
        return money;
    }

    public String getDrawcards()
    {
        return drawcards;
    }

    public Date getRegdatetime()
    {
        return regdatetime;
    }

    public String getRegdatetimetoString()
    {
        if(regdatetime != null)
        {
            return Ocean.sdf.format(regdatetime);
        } else
        {
            return "";
        }
    }

    public String getUpdatemember()
    {
        return updatemember;
    }

    public Date getUpdatetime()
    {
        return updatetime;
    }

    public String getUpdatetimetoString()
    {
        if(updatetime != null)
        {
            return Ocean.sdf.format(updatetime);
        } else
        {
            return "";
        }
    }


    public Date getMaketime()
    {
        return maketime;
    }

    public String getBeijingorder()
    {
        return beijingorder;
    }

    public String getBobo_interest()
    {
        return bobo_interest;
    }

    public String getBobo_interest_qita()
    {
        return bobo_interest_qita;
    }

    public int getLearnway()
    {
        return learnway;
    }

    public int getOccupation()
    {
        return occupation;
    }

    public int getUrban()
    {
        return urban;
    }

    public int getEducation()
    {
        return education;
    }

    public String getMaketimetoString()
    {
        if(maketime != null)
        {
            return Ocean.sdf.format(maketime);
        } else
        {
            return "";
        }
    }

    public static boolean thinkId(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id from Ocean where id=" + id);
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

    public static String getEmail(String oceanorder) throws SQLException
    {
        String email = "";
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select email from Ocean where oceanorder=" + db.cite(oceanorder));
            if(db.next())
            {
                email = db.getString(1);
                return email;
            } else
            {
                return email;
            }
        } finally
        {
            db.close();
        }
    }

    public static int getIdtoBeijingorder(String beijingorder) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id from Ocean where beijingorder=" + db.cite(beijingorder));
            if(db.next())
            {
                id = db.getInt(1);
                return id;
            } else
            {
                return id;
            }
        } finally
        {
            db.close();
        }
    }


    public static boolean iscard(String card,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id from Ocean where  card=" + db.cite(card) + " " + sql);
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

    public static int getCardtoID(String card,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int id = 0;
        try
        {
            db.executeQuery("Select id from Ocean where  card=" + db.cite(card) + " " + sql);
            if(db.next())
            {
                id = db.getInt(1);
                return id;
            } else
            {
                return id;
            }
        } finally
        {
            db.close();
        }
    }

    public static int getOceanordertoID(String oceanorder,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int id = 0;
        try
        {
            db.executeQuery("Select id from Ocean where  oceanorder=" + db.cite(oceanorder) + " " + sql);
            if(db.next())
            {
                id = db.getInt(1);
                return id;
            } else
            {
                return id;
            }
        } finally
        {
            db.close();
        }
    }


    public static void updatetype(int id,int type,String updatesql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            //orderstatic; ///订单状态 0 没有完成交易  1 完成交易 2 完成制卡 3 完成发放
            db.executeUpdate("Update Ocean set orderstatic=" + type + " " + updatesql + " where id=" + id);
            Ocean.appendMethodB("Update Ocean set orderstatic=" + type + " " + updatesql + " where id=" + id);
            
        } finally
        {
            db.close();
        }
    }

    public static int getIdmax() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int max = 0;
        try
        {
            Date date = new Date();
            Calendar cal = Calendar.getInstance();
            int day = cal.get(Calendar.DAY_OF_MONTH);
            cal.set(Calendar.DATE,day + 1);
            String firstdate = Ocean.sdf.format(date);
            String lastdate = Ocean.sdf.format(cal.getTime());
            db.executeQuery("Select count(id) from Ocean where  regdatetime>" + db.cite(firstdate) + " and regdatetime<" + db.cite(lastdate));
            if(db.next())
            {
                max = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return max;
    }

    //根据订单号修改订单状态
    public static void updatetype(String oceanorder,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        { 
            //orderstatic; ///订单状态 0 没有完成交易  1 完成交易 2 完成制卡 3 完成发放
            db.executeUpdate("Update Ocean set orderstatic=" + type + " where oceanorder=" + db.cite(oceanorder));
            Ocean.appendMethodB("Update Ocean set orderstatic=" + type + " where oceanorder=" + db.cite(oceanorder));
        } finally
        {
            db.close();
        }
    }

    public static void updatetypebeijing(String beijingorder,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            //orderstatic; ///订单状态 0 没有完成交易  1 完成交易 2 完成制卡 3 完成发放
        	int t = 0;
        	db.executeQuery("select orderstatic from Ocean where  orderstatic=" + type + " and beijingorder=" + db.cite(beijingorder));
        	
        	if(db.next())
        	{
        		t =  db.getInt(1);
        	} 
        	
        	if(t!=1)
        	{
        		db.executeUpdate("Update Ocean set orderstatic=" + type + " where beijingorder=" + db.cite(beijingorder));
                Ocean.appendMethodB("Update Ocean set orderstatic=" + type + " where beijingorder=" + db.cite(beijingorder));
        	}
        } finally
        {
            db.close();
        }
    }
 
    public static void updateMaketime(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            Date date = new Date();
            //orderstatic; ///订单状态 0 没有完成交易  1 完成交易 2 完成制卡 3 完成发放
            db.executeUpdate("Update Ocean set maketime=" + db.cite(date) + " where id=" + id);
            Ocean.appendMethodB("Update Ocean set maketime=" + db.cite(date) + " where id=" + id);
        } finally
        {
            db.close();
        }

    }

    public static void deleteCard(String card,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Delete Ocean where card=" + db.cite(card) + "  " + sql);
        } finally
        {
            db.close();
        }

    } 
    /**
     * B方法追加文件：使用FileWriter
     */
    public static void appendMethodB(String content) {
        try { 
            //打开一个写文件器，构造函数中的第二个参数true表示以追加形式写文件
        	String filename = "D:/Ocean_"+Ocean.sdf.format(new Date())+".txt";
        	
            FileWriter writer = new FileWriter(filename, true);
            writer.write("时间:-"+Ocean.sdf2.format(new Date())+"-:"+content+"\n");
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        } 
    }
    public static void main(String[] args) {
        
        Ocean.appendMethodB("append end666.");
      
    }


}
