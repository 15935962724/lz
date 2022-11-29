package tea.entity.member;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;

import tea.db.*;
import tea.entity.Attch;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Entity;
import tea.entity.Filex;
import tea.entity.MT;
import tea.entity.RV;
import tea.entity.Seq;
import tea.entity.bbs.BBSLevel;
import tea.entity.site.License;
import tea.entity.site.Subscriber;
import tea.entity.westrac.WestracIntegralLog;
import tea.html.Anchor;
import tea.html.Image;
import tea.html.Text;
import tea.service.SMS;

public class Profile extends Entity {
	public static String ORG_NATURE[] = { "", "国有经济", "集体经济", "私营/民营", "股份制", "三资", "其他" };
	public static String CARD_TYPE[] = { "居民身份证", "军官证/武警警官证/士兵证", "港澳居民往来内地通行证", "台湾居民来往大陆通行证", "外国护照" };

	public static final String AGE[] = { "N/A", "0-6", "7-12", "13-15", "16-18", "19-22", "23-25", "26-28", "29-35", "36-40", "41-45", "46-50", "51-55", "56-60", "60-" };
	public static final String AGE_EN[] = { "under20", "21-25", "26-30", "31-40", "41-50", "51-60", "above60" };

	public static final String INDUSTRY[] = { "Accounting/Banking/Finance", "Advertising/Marketing/PR", "Aerospace/Defense", "Agriculture/Mining", "Computer and Data Processing Service",
			"Consulting", "Education", "Engineering/Construction/Architecture", "Government/Military", " Healthcare/Medical/Pharmaceuticals", "Insurance/Real Estate/Property Mgmt",
			"Internet/Online Services", "Legal Services", "Manufacturing - Computer Related", "Manufacturing - Non-Computer Related", "Media/Publishing/Entertainment", "Non-Profit/Trade Association",
			" Packaged Goods", "Software Design/Development/Distribution", "Telecommunications", "Trade/Distribution - Retail", " Trade/Distribution - Wholesale", "Transportation/Logistics",
			"Travel/Tourism/Hospitality", "Utilities/Energy", "Other" };

	public static final String JOB[] = { "Chairman, Owner, Partner, President, CEO", "Director, Manager, GS 12/13, O3/O4", "Other Management Level Title", "Self-employed/Entrepreneur",
			"Salaried Professional", "Hourly employee", "Student/Intern", "Retired", "Not Employed", "Other" };

	// "CFO, CIO, COO, CTO, CMO, SES, O7+","VP, SVP, EVP, GS 14/15, O5/O6",

	public static final String POLITY_TYPE[] = { "Non-Party", "CPC", "League", "OtherParty", "Other" };
	public static Cache _cache = new Cache(100);
	public Hashtable _htLayer;

	public static final int ADDRESST_PUBLIC = 1;
	public int profile;
	public String code; // 会员编号
	public String member; // 用户名
	public String password; // 密码
	public String mobile; // 手机
	public String email; // 邮件
	public String emailbooking; // 订阅邮件
	public int bookingemail; // 订阅邮件
	private String creditcard; // 信用卡号
	public Date birth; // 出生日期
	public int type; // 0：前台用户，1：后台用户
	public int membertype; // 会员类型 - 0"普通会员",1 vip 2 服务商
	public static final String MEMBER_TYPE[] =
	/* {"普通会员","VIP","SVIP","服务商"}; */
	{ "普通会员", "VIP", "服务商","服务商子账户" };

	public String procurementUnit;// 采购单位

	public static String[] procurementUnitARR = { "欣科", "高科", "君安" };//

	private Date verifgtime; // 会员审核时间
	private String verifgmember; // 审核的管理员
	private boolean loaded;
	public boolean sex = true; // 性别 true:男 false:女
	public int polity; // 政治面貌
	private int adminUnit;
	public Date time; // 注册时间
	public String community;
	public String card; // 证件号码
	public int cardtype; // 证件类型
	private String caller; // 话务员
	public String qq;
	private String msnid; // msn的编号
	private boolean jobMailMsg;
	private boolean valid;
	private int famst; // 婚姻状况
	private Date famdt; // 当前婚姻状态的<BR>有效起始日期
	private int anzkd; // 子女数目
	private boolean zzgatwj; // 港澳台或外籍人士
	public boolean zznyhk; // 是否农业户口
	private String zzpridn; // 个人身份
	private String zzfmbkg; // 家庭出身
	public String zzracky; // SAP-民族分组
	private String referer;
	public int agent;
	public int rclass;
	private String question;
	private String answer;
	private int wagetype; // 工资标准
	private float integral; // 会员的总积分
	private float contributeintegral; // 投稿的积分
	private float myintegral; // 俱乐部会员使用的积分
	private int agio; // 折扣
	private String etime; // 入职时间
	public Date gtime; // 毕业时间
	private int bbslevel; // 积分等级 对应的积分是:integral
	private int point; // BBS总积分
	public String pinyin; // 姓名拼音/英文
	public int orgnature; // 公司性质
	private boolean locking; // 锁定
	private int nobanspeak; // 禁止发言 -- 0 可以发言 ，1 不能发言 论坛里面设置
	private int identitys; // 目前身份
	private int nocontributors; // 禁止投稿 --0 可以投稿，1 不能投稿
	private int industry; // 行业
	public int job; // 工作
	private String woid; // 注册选项
	private String bbspermissions; // bbs论坛 绑定用户权限
	private String medal = "|"; // 勋章
	private Date gag; // 禁言
	public boolean deleted; // 删除

	public String umember; // 最后一次修改人
	public Date utime; // 最后一修改时间
	private int logint; // 登陆次数
	public String[] lip = new String[2];
	public String lua;
	public Date[] ltime = new Date[2]; // 登录时间 0:本次 1:上次

	// 军事科学图书出版社
	public static final String[] INVOIVE_TYPE = { "个人", "企业" };
	public static final String[] INVOIVE_CONTENT = { "图书", "资料", "杂志" };
	public int isInvoive; // 是否开发票
	public int invoiveType; // 发票类型
	public int invoiveContent; // 发票内容
	public String unitName; // 发票单位
	public int invouveState; // 发票状态
	public int personState; // 收货人状态
	// 军事科学出版社
	private String jemail; //
	private String jmobbile; //
	private String jaddress; //
	public int jcity; //
	// ---威斯特注册信息使用
	private String tjmember; // 推荐人会员编号
	public String tjmobile; // 推荐人手机号
	private int sfshanggang; // 是否上岗证
	private String fazhengjiguan; // 发证机关
	private String caozuonianxian; // 操作年限
	private int xpinpai; // 现操作机型品牌
	private int xxinghao; // 型号
	private String xqita; // 其他

	private int cpinpai; // 曾操作机型品牌
	private int cxinghao; // 型号
	private String cqita; // 其他

	private String jzname; // 机主相关 姓名
	private String jzxinghao; // 机主相关 型号
	private String jzxuliehao; // 序列号
	private String jzlianxi; // 联系方式
	private String aihao; // 爱好
	private int remembertype; // 默认不推荐 0,推荐 1
	private int rememberorder; // 推荐顺序

	private String belsell; // 所属销售员
	// private String belsellphone; //所属销售员联系电话
	// 信息来源
	private int source; // 从何得知履友联盟？

	// 培训名称，培训地点，培训时间
	private String trainname;
	private String trainaddress;
	private String traintime;
	// 身份类型改为：机主、机手、设备管理人员、技术管理人员、与行业相关、对工程机械感兴趣者
	public static final String[] WST_TYPE = { "", "机主", "操作手", "设备管理人员", "技术管理人员", "与行业相关", "对工程机械感兴趣者" };
	private int wsttype; // 身份类型
	public static final String[] WST_MODEL = { "", "推土机", "挖掘机", "装载机", "平地机", "其他" };
	private String wstmodel; // 机种
	// verify核实后的身份类型:机主、机手、设备管理人员、技术管理人员、与行业相关、无效
	public static final String[] VERIFY_TYPE = { "未核实", "机主", "机手", "设备管理人员", "技术管理人员", "与行业相关", "无效" };
	private int verifytype;
	private int nomanager; // 判断是否为管理员

	// 高尔夫高级会员注册信息
	private String memberheight; // 身高
	private String ballage; // 打球年龄
	private String almostscore; // 差点or平均成绩
	private String likeitems; // 喜欢的;(木，球道，铁木，铁，推)
	private String handfoot; // 手尺
	private String gdistance; // 手碗到地面距离
	private String yhand; // 用手 右手，左手
	private String swingrhythm; // 挥杆节奏
	public String cardnumber; // 绑定的卡号，唯一的

	// 高尔夫高级会员 注册信息2
	// 告知我们您的所属企业及相关信息，为以后的会员企业服务做数据准备.

	private String woid2; // 注册选项

	private String entername; // 企业名称
	private String enterpic; // 企业logo或图片
	private String enterwebsite; // 企业网站
	private String entercontact; // 联系方式
	private String enteraddress; // 地址
	private String enterproduct; // 服务或产品
	private String enterweibo; // 企业微博
	private String personalweibo; // 个人微博
	private String entertext; // 企业介绍

	// 活跃活跃度记录
	private int smsint; // 短信来往次数;
	private int phoneint; // 电话来访次数
	private int eventint; // 参加活动次数
	private int tjmemberint; // 推荐会员次数
	// 活跃度 标记
	private int actives; // 活跃度 1不活跃，2 活跃，3种子会员

	// 会员导入类型
	private int imptype; // 0 默认注册会员，1导入会员 2同步会员
	public int leveltype; // 级别字段 备用
	// 只锁定不能查看电子报会员
	public int newlocking; // 锁定天数
	public Date newlockingdata; // 锁定到期日期

	public int pmmj;// 拍马网 是否名家

	public int emailflag;// 是否激活邮箱 0激活 1未激活

	public int qualification;// 资质是否已审核通过；0未通过，1通过

	public Date validity;// 资质有效期

	public String openid;// qq登陆id - 改用微信-openid

	public String wbuid;// 微博登陆id

	public String wxopenid;// 微信登陆id

	public int isvip;// 是否不用付款就可以发货 0不可 1可以

	public String hospitals = "|";// 代理商所属的医院

	// 微信签收
	public int particles_sign; // 粒子签收人 默认为0,1为签收人
	public int invoice_sign; // 发票签收人 默认为0,1为签收人
	// public int hospital; //签收人所属医院
	public String hospital; // 签收人所属医院(18.8.7改为int类型，主要是山东省医学影像所下的三个科室，目前是三个医院，需要从不同签收人改为同一个签收人）
	public String address; // 收货人地址
	public String userid; // 微信-企业号
	public String company; // 服务商公司名称
	public int tax; // 进项税返还政策
	public static String[] TAX = { "", "返还增值税专用发票（6%）", "返还增值税专用发票（6%）抵扣部分的50%", "返还增值税专用发票（3%）", "返还增值税专用发票（3%）抵扣部分的50%" };
	public int formula; // 应付服务费公式
	// public static String[]
	// FORMULA={"","（单价-120）*0.983*（开票金额/单价）/1.17","（单价-120）*0.9796*（开票金额/单价）/1.17"};
	public static String[] FORMULA = { "", "（单价-120）*0.984*（开票金额/单价）/1.16", "（单价-120）*0.9808*（开票金额/单价）/1.16" };

	public int issalesman;// 自营业务员
	public int parentpro;//父profile的profile
	public int agreednum;//服务商满意度次数  填一次自增   一季度清空一次   1 4 7 10 月1日清空为0   服务商手机下单 判断等于3不跳转  小于3跳转满意度调查

	public static final String ACTIVES_TYPE[] = { "", "不活跃", "活跃", "种子会员" };
	public static final String SOURCE_TYPE[] =
	// {"","培训","履友推荐","销售员推荐","威斯特网站","海报","其他宣传"};
	{ "", // 0
			"卡特/威斯特培训", // 1
			"朋友推荐", // 2
			"卡特/威斯特人员介绍", // 3
			"威斯特官网", // 4
			"海报", // 5
			"短信邀请", // 6
			"第一工程机械网", // 7
			"履友交流群", // 8
			"履友联盟微博", // 9
			"履友客户端", // 9
			"其他" // 10
	};

	public static final String SOURCE_TYPE_golf[] = { "", "培训", "俱乐部会员推荐", "销售员推荐", "时尚高尔夫网站", "海报", "其他宣传" };
	// 学历
	public static final String DEGREE_TYPE[] = { "无", "小学", "中学", "大专", "本科", "硕士", "博士", "其他" };

	public static final String IDENTITYS_TYPE[] = { "报社记者", "报社编辑", "通讯员", "其他" };
	public static final String WOID_TYPE[] = { "北京道教", "道教新闻", "北京宫观", "居士团体", "宗教法规", "法物流通", "道教文化", "书画艺术", "道教音乐", "道教学院", "道教人物", "《之道》期刊" };
	// 核能 太阳能 风能 生物质能 地热能 氢能 水电 石油天然气 洁净煤 电动车储能电池 储能技术 智能电网 节能减排 绿色建筑
	public static final String FIELD_TYPE[] = { "核能", "太阳能", "风能", "生物质能", "地热能", "氢能", "水电", "石油天然气", "洁净煤", "电动车储能电池", "储能技术", "智能电网", "节能减排", "绿色建筑" };
	public static final String FIELD_EN_TYPE[] = { "nenergy", "senergy", "wpower", "benergy", "genergy", "thydrogen", "welectricity", "oil", "cleanCoal", "evesb", "est", "tsg", "ecer", "tgb" };
	public static String[] ShouhuorenField = { "", "member", "password", "mobile", "membertype", "address" };
	public static String[] FuwushangField = { "", "member", "password", "mobile", "membertype", "procurementUnit" };
	public static String[] FuwushangField2 = { "", "member", "company", "tax", "formula", "agentPriceNew" };
	private int aaa;

	/**
	 * 根据puid查询关联服务商
	 * 
	 * @param puid
	 * @return
	 */
	public static List<Integer> JoinPro(int puid) {
		DbAdapter db = new DbAdapter();
		ArrayList<Integer> inds = new ArrayList<Integer>();
		try {
			db.executeQuery("select puid,profile from procurementunit_join where puid = " + puid);
			while (db.next()) {
				int i = 1;
				int puid1 = db.getInt(i++);
				int profile = db.getInt(i++);
				inds.add(profile);
			}
			return inds;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return null;
	}

	/**
	 * 添加关联服务商
	 * 
	 * @param puid
	 * @param profile
	 */
	public static void AddJoinHosp(int puid, int profile) {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("insert into procurementunit_join(puid,profile) values(" + puid + "," + profile + ")");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
	}

	/**
	 * 取消关联服务商
	 * 
	 * @param puid
	 * @param profile
	 */
	public static void RemoveJoinHosp(int puid, int profile) {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("delete procurementunit_join where puid=" + puid + " and profile=" + profile);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
	}

	public class Layer {
		public String _strFirstName; // 名
		public String _strLastName; // 姓
		public String _strOrganization; // 公司--单位--现通讯地址详细地址
		public String _strAddress; //
		public String paddress; // 住宅地址--家庭所在地详细地址
		public String ptelephone; // 住宅电话
		public String _strCity; // 城市
		public String _strState; // 省--现通讯地址-省市
		public String _strZip; // 邮编
		public String pzip; // 邮编
		public String _strCountry; // 国家
		public String _strTelephone; // 电话
		public String _strFax;
		public String _strWebPage;
		public String degree; // 学历
		public String _strPhotopath; // 照片
		public String photopath2; //
		public String _strJob; // 职位
		public String _strTitle; // 职称
		public String section; // 科室（部门）
		public String functions; // 工作职能
		public String _strStartUrl; // 起始URL
		public String school; // 毕业学院
		public String gblnd; // 出生国家
		public String gbort; // 出生地
		public String zzhkszd; // 户口所在地--家庭所在地
		public int province; // 城市
		public String introduce; // 简介
		public String club; // 球会名称,具乐部
		// public String degree; //教育程度
		// public String school; //毕业学校
		public String consignee; // 收货人
		public String banspeakreason; // 禁止发言的原因
		public String contributorsreason; // 禁止投稿原因
		public String field; // 清洁能源 感兴趣领域
		// 只锁定不能查看电子报会员

		public String newreason;

		Layer() {
		}
	}

	public String getField(int i) throws SQLException {
		return getLayer(i).field;
	}

	public String getConsignee(int i) throws SQLException {
		return getLayer(i).consignee;
	}

	public void setField(String name, int language) throws SQLException {
		setLayer("field", name, language);
	}

	public String getFirstName(int i) throws SQLException {
		return getLayer(i)._strFirstName;
	}

	public void setFirstName(String name, int language) throws SQLException {
		setLayer("firstname", name, language);
	}

	public void setLastName(String name, int language) throws SQLException {
		setLayer("lastname", name, language);
	}

	public void setFax(String fax, int language) throws SQLException {
		setLayer("fax", fax, language);
	}

	public int getAdminUnit() throws SQLException {
		load();
		return adminUnit;
	}

	public String getState(int i) throws SQLException {
		return getLayer(i)._strState;
	}

	public void setState(String _strState, int language) throws SQLException {
		setLayer("state", _strState, language);
	}

	public String getStartUrl(int language) throws SQLException {
		return getLayer(language)._strStartUrl;
	}

	public String getQuestion() {
		return question;
	}

	public String getAnswer() {
		return answer;
	}

	/*
	 * public String setState(String state) throws SQLException { return
	 * getLayer(i)._strState; }
	 */

	public void set(String email, Date birth, int type, String mobile, boolean sex, int language, String firstname, String lastname, String organization, String address, String city, String state,
			String zip, String country, String telephone, String fax, String webpage) throws SQLException {
		StringBuilder sql = new StringBuilder();
		StringBuilder sql2 = new StringBuilder();
		DbAdapter db = new DbAdapter();
		sql.append("UPDATE Profile SET birth=").append(DbAdapter.cite(birth));
		sql.append(",type=").append(type);
		sql.append(",email=").append(DbAdapter.cite(email));
		sql.append(",mobile=").append(DbAdapter.cite(mobile));
		sql.append(",sex=").append(DbAdapter.cite(sex));
		sql.append(" WHERE member=").append(DbAdapter.cite(member));
		sql2.append("UPDATE ProfileLayer SET firstname=").append(DbAdapter.cite(firstname));
		sql2.append(",lastname=").append(DbAdapter.cite(lastname));
		sql2.append(",organization=").append(DbAdapter.cite(organization));
		sql2.append(",address=").append(DbAdapter.cite(address));
		sql2.append(",city=").append(DbAdapter.cite(city));
		sql2.append(",state=").append(DbAdapter.cite(state));
		sql2.append(",zip=").append(DbAdapter.cite(zip));
		sql2.append(",country=").append(DbAdapter.cite(country));
		sql2.append(",telephone=").append(DbAdapter.cite(telephone));
		sql2.append(",fax=").append(DbAdapter.cite(fax));
		sql2.append(",webpage=").append(DbAdapter.cite(webpage));
		sql2.append(" WHERE member=").append(DbAdapter.cite(member)).append(" AND language=").append(language);
		try {
			db.executeUpdate(profile, sql.toString());
			int j = db.executeUpdate(profile, sql2.toString());
			if (j < 1) {
				db.executeUpdate(profile,
						"INSERT INTO ProfileLayer(member, language, firstname, lastname, organization, address, city, state, zip, country, telephone, fax, webpage)VALUES (" + DbAdapter.cite(member)
								+ ", " + language + "," + DbAdapter.cite(firstname) + ", " + DbAdapter.cite(lastname) + "," + DbAdapter.cite(organization) + ", " + DbAdapter.cite(address) + ", "
								+ DbAdapter.cite(city) + ", " + DbAdapter.cite(state) + ", " + DbAdapter.cite(zip) + ", " + DbAdapter.cite(country) + ", " + DbAdapter.cite(telephone) + ", "
								+ DbAdapter.cite(fax) + ", " + DbAdapter.cite(webpage) + ")");
			}
		} finally {
			db.close();
		}
		this.birth = birth;
		this.type = type;
		this.email = email;
		this.sex = sex;
		this.mobile = mobile;
		_htLayer.clear();
	}

	public static void setMember(String member, String membercode, String community) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(" update Profile set member = " + db.cite(member) + " where code = " + db.cite(membercode));
		} finally {
			db.close();
		}

	}

	public void setMember(String member) throws SQLException {
		System.out.println(this.member);
		this.member = member;
		System.out.println(this.member);
		_htLayer.clear();

	}

	public void set(String etime, int language, String job, String title, String functions, String photopath2) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("UPDATE Profile SET etime=" + db.cite(etime) + " WHERE member=" + DbAdapter.cite(member));
			db.executeUpdate("UPDATE ProfileLayer SET job=" + DbAdapter.cite(job) + ",title=" + DbAdapter.cite(title) + ",functions=" + DbAdapter.cite(functions) + ",photopath2="
					+ DbAdapter.cite(photopath2) + " WHERE member=" + DbAdapter.cite(member) + " AND language=" + language);
		} finally {
			db.close();
		}
		this.etime = etime;
		_htLayer.clear();
	}

	public void set(int isInvoive, int invoiveType, int invoiveContent, String unitName) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("UPDATE Profile SET isInvoive=" + isInvoive + ",invoiveType=" + invoiveType + ",invoiveContent=" + invoiveContent + ",unitName=" + DbAdapter.cite(unitName)
					+ " WHERE member=" + DbAdapter.cite(member));

		} finally {
			db.close();
		}
		this.isInvoive = isInvoive;
		this.invoiveType = invoiveType;
		this.invoiveContent = invoiveContent;
		this.unitName = unitName;

	}

	// String email,Date birth,int type,String mobile,boolean sex,int
	// language,String firstname,String lastname,String organization,String
	// address,String city,String state,String zip,String country,String
	// telephone,String fax,String webpage
	public void set() throws SQLException {
		StringBuilder sql = new StringBuilder();
		if (profile < 1)
			sql.append("INSERT INTO Profile(profile,member,password,community,email,mobile,sex,zzracky,polity,cardtype,card,jcity,zznyhk,job,orgnature,birth,gtime,agent,rclass,leveltype,cardnumber,type,deleted,time)VALUES("
					+ (profile = Seq.get())
					+ ","
					+ DbAdapter.cite(member)
					+ ","
					+ DbAdapter.cite(password)
					+ ","
					+ DbAdapter.cite(community)
					+ ","
					+ DbAdapter.cite(email)
					+ ","
					+ DbAdapter.cite(mobile)
					+ ","
					+ DbAdapter.cite(sex)
					+ ","
					+ DbAdapter.cite(zzracky)
					+ ","
					+ polity
					+ ","
					+ cardtype
					+ ","
					+ DbAdapter.cite(card)
					+ ","
					+ jcity
					+ ","
					+ DbAdapter.cite(zznyhk)
					+ ","
					+ job
					+ ","
					+ orgnature
					+ ","
					+ DbAdapter.cite(birth)
					+ ","
					+ DbAdapter.cite(gtime)
					+ ","
					+ agent
					+ ","
					+ rclass
					+ ","
					+ leveltype
					+ ","
					+ DbAdapter.cite(cardnumber) + "," + type + ",0," + DbAdapter.cite(time) + ")");
		else {
			sql.append("UPDATE Profile SET");
			sql.append(" type=").append(type);
			sql.append(",email=").append(DbAdapter.cite(email));
			sql.append(",mobile=").append(DbAdapter.cite(mobile));
			sql.append(",sex=").append(DbAdapter.cite(sex));
			sql.append(",zzracky=").append(DbAdapter.cite(zzracky));
			sql.append(",polity=").append(polity);
			sql.append(",cardtype=").append(cardtype);
			sql.append(",card=").append(DbAdapter.cite(card));
			sql.append(",jcity=").append(jcity);
			sql.append(",zznyhk=").append(DbAdapter.cite(zznyhk));
			sql.append(",job=").append(job);
			sql.append(",orgnature=").append(orgnature);
			sql.append(",birth=").append(DbAdapter.cite(birth));
			sql.append(",gtime=").append(DbAdapter.cite(gtime));
			sql.append(",agent=").append(agent);
			sql.append(",rclass=").append(rclass);
			sql.append(",leveltype=").append(leveltype);
			sql.append(",cardnumber=").append(DbAdapter.cite(cardnumber));
			sql.append(" WHERE profile=").append(profile);
		}
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(profile, sql.toString());
		} finally {
			db.close();
		}
	}

	public void set(int language, String f, String v) throws SQLException {
		StringBuilder sql = new StringBuilder();
		sql.append("UPDATE ProfileLayer SET " + f + "=" + DbAdapter.cite(v) + " WHERE member=").append(DbAdapter.cite(member)).append(" AND language=").append(language);
		DbAdapter db = new DbAdapter();
		try {
			int j = db.executeUpdate(profile, sql.toString());
		} finally {
			db.close();
		}
		_htLayer.clear();
	}

	public void setLayer(int language, String firstname, String lastname, String organization, int province, String address, String zip, String country, String telephone, String fax, String webpage)
			throws SQLException {
		StringBuilder sql = new StringBuilder();
		sql.append("UPDATE ProfileLayer SET firstname=").append(DbAdapter.cite(firstname));
		sql.append(",lastname=").append(DbAdapter.cite(lastname));
		sql.append(",organization=").append(DbAdapter.cite(organization));
		sql.append(",province=").append(province);
		sql.append(",address=").append(DbAdapter.cite(address));
		// sql.append(",city=").append(DbAdapter.cite(city));
		// sql.append(",state=").append(DbAdapter.cite(state));
		sql.append(",zip=").append(DbAdapter.cite(zip));
		sql.append(",country=").append(DbAdapter.cite(country));
		sql.append(",telephone=").append(DbAdapter.cite(telephone));
		sql.append(",fax=").append(DbAdapter.cite(fax));
		sql.append(",webpage=").append(DbAdapter.cite(webpage));
		sql.append(" WHERE member=").append(DbAdapter.cite(member)).append(" AND language=").append(language);
		DbAdapter db = new DbAdapter();
		try {
			int j = db.executeUpdate(profile, sql.toString());
			if (j < 1) {
				db.executeUpdate(
						profile,
						"INSERT INTO ProfileLayer(profile,member,language,firstname,lastname,organization,province,address,zip,country,telephone,fax,webpage)VALUES (" + profile + ","
								+ DbAdapter.cite(member) + "," + language + "," + DbAdapter.cite(firstname) + "," + DbAdapter.cite(lastname) + "," + DbAdapter.cite(organization) + "," + province
								+ "," + DbAdapter.cite(address) + "," + DbAdapter.cite(zip) + "," + DbAdapter.cite(country) + "," + DbAdapter.cite(telephone) + "," + DbAdapter.cite(fax) + ","
								+ DbAdapter.cite(webpage) + ")");
			}
		} finally {
			db.close();
		}
		_htLayer.clear();
	}

	public void setU(String umember, Date utime) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("UPDATE Profile SET umember=" + db.cite(umember) + ",utime=" + DbAdapter.cite(utime) + " WHERE member=" + DbAdapter.cite(member));
		} finally {
			db.close();
		}
		this.umember = umember;
		this.utime = utime;
	}

	public static String getMember(String code) throws SQLException {
		DbAdapter db = new DbAdapter();
		String member = "";
		try {
			db.executeQuery("select member from Profile where code  = " + db.cite(code));
			if (db.next()) {
				member = db.getString(1);
			}
		} finally {
			db.close();
		}
		return member;
	}

	// 判断高尔夫关联卡号唯一性
	public static boolean isCardnumber(String cardnumber) throws SQLException {
		DbAdapter db = new DbAdapter();
		boolean f = false;
		try {
			db.executeQuery("select member from Profile where cardnumber  = " + db.cite(cardnumber));
			if (db.next()) {
				f = true;
			}
		} finally {
			db.close();
		}
		return f;
	}

	// 判断身份证号是唯一
	public static boolean isCard(String community, String card) throws SQLException {
		DbAdapter db = new DbAdapter();
		boolean f = false;
		try {
			db.executeQuery("select member from Profile where community=" + db.cite(community) + " and  card = " + db.cite(card));
			if (db.next()) {
				f = true;
			}
		} finally {
			db.close();
		}
		return f;
	}

	// 通过身份证获取用户名
	public static String getCardMember(String community, String card) throws SQLException {
		DbAdapter db = new DbAdapter();
		String f = "";
		try {
			db.executeQuery("select member from Profile where community=" + db.cite(community) + " and  card = " + db.cite(card));
			if (db.next()) {
				f = db.getString(1);
			}
		} finally {
			db.close();
		}
		return f;
	}

	// 判断手机是否唯一
	public static boolean isMobile(String community, String mobile) throws SQLException {
		DbAdapter db = new DbAdapter();
		boolean f = false;
		try {
			db.executeQuery("select member from Profile where community=" + db.cite(community) + " and  mobile = " + db.cite(mobile));
			if (db.next()) {
				f = true;
			}
		} finally {
			db.close();
		}
		return f;
	}

	void load() {
	}

	public static ArrayList find1(String sql, int pos, int size) throws SQLException {
		// if(sql.length() < 1 || sql.startsWith(" AND "))
		// sql = tab(sql) + " WHERE 1=1" + sql;
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter();
		try {
			// System.out.println("SELECT p.profile,p.member,p.community,p.password,p.email FROM Profile p"
			// + tab(sql) + " WHERE 1=1" + sql);
			db.executeQuery(
					"SELECT p.profile,p.member,p.community,p.password,p.email,p.code,p.creditcard,p.birth,p.type,p.mobile,p.locking,p.sex,p.polity,p."
							+ "adminunit,p.deleted,p.time,p.qq,p.msnid,p.card,p.cardtype,p.jobmailmsg,p.valid,p.famst,p.famdt,p.anzkd,p.zzgatwj,p.zznyhk,p.zzpridn,p.zzfmbkg,p."
							+ "referer,p.agent,p.rclass,p.question,p.answer,p.wagetype,p.integral,p.agio,p.caller,p.etime,p.gtime,p.bbslevel,p.point,p.pinyin,p.orgnature,p.nobanspeak,p."
							+ " contributeintegral,p.identitys,p.nocontributors ,p.industry,p.job,p.woid,p.bbspermissions,p.medal,p.gag,p.umember,p.utime,p.lip0,p.lip1,p.lua,p.ltime0,p.ltime1,p."
							+ " tjmember,p.tjmobile,p.sfshanggang,p.fazhengjiguan,p.caozuonianxian,p.xpinpai,p.xxinghao,p.xqita,p.cpinpai,p.cxinghao,p.cqita,p."
							+ " jzname,p.jzxinghao,p.jzxuliehao,p.jzlianxi,p.aihao,p.zzracky,p.membertype,p.verifgtime,p.verifgmember,p.myintegral,p.remembertype,p.rememberorder,p."
							+ " belsell,p.source,p.trainname,p.trainaddress,p.traintime,p.wsttype,p.wstmodel,p.memberheight,p.ballage,p.almostscore,p.likeitems,p.handfoot,p.gdistance,p."
							+ " yhand,p.swingrhythm,p.cardnumber,p.woid2,p.entername,p.enterpic,p.enterwebsite,p.entercontact,p.enteraddress,p."
							+ " enterproduct,p.enterweibo,p.personalweibo,p.entertext,p.logint,p.smsint,p.phoneint,p.eventint,p.tjmemberint,p."
							+ "actives,p.imptype,p.leveltype,p.verifytype,p.nomanager,p.newlocking,p.newlockingdata,p.isInvoive,p.invoiveType,p.invoiveContent,p.unitName,p.invouveState,p.personState,p.jmobbile,p.jemail,p.jaddress,p.jcity,p.pmmj,p.emailflag,p.qualification,p.validity,p.emailbooking,p.bookingemail,p.openid,p.wbuid,p.wxopenid,p.isvip,p.hospitals,"
							+ " p.particles_sign,p.invoice_sign,p.hospital,p.userid,p.address,p.company,p.tax,p.formula,p.procurementUnit,p.issalesman,p.parentpro,p.agreednum FROM Profile p" + tab(sql) + " WHERE 1=1" + sql,
					pos, size);
			while (db.next()) {
				int j = 1;
				Profile t = new Profile(db.getInt(j++));
				t.member = db.getString(j++);
				t.community = db.getString(j++);
				t.password = db.getString(j++);
				t.email = db.getString(j++);
				t.code = db.getString(j++);
				t.creditcard = db.getString(j++);
				t.birth = db.getDate(j++);
				t.type = db.getInt(j++);
				t.mobile = db.getString(j++);
				t.locking = db.getInt(j++) != 0;
				t.sex = db.getInt(j++) != 0;
				t.polity = db.getInt(j++);
				t.adminUnit = db.getInt(j++);
				t.deleted = db.getInt(j++) != 0;
				t.time = db.getDate(j++);
				t.qq = db.getString(j++);
				t.msnid = db.getString(j++);
				t.card = db.getString(j++);
				t.cardtype = db.getInt(j++);
				t.jobMailMsg = db.getInt(j++) != 0;
				t.valid = db.getInt(j++) != 0;
				t.famst = db.getInt(j++);
				t.famdt = db.getDate(j++);
				t.anzkd = db.getInt(j++);
				t.zzgatwj = db.getInt(j++) != 0;
				t.zznyhk = db.getInt(j++) != 0;
				t.zzpridn = db.getString(j++);
				t.zzfmbkg = db.getString(j++);
				t.referer = db.getString(j++);
				t.agent = db.getInt(j++);
				t.rclass = db.getInt(j++);
				t.question = db.getString(j++);
				t.answer = db.getString(j++);
				t.wagetype = db.getInt(j++);
				t.integral = db.getFloat(j++);
				t.agio = db.getInt(j++);
				t.caller = db.getString(j++);
				t.etime = db.getString(j++);
				t.gtime = db.getDate(j++);
				t.bbslevel = db.getInt(j++);
				t.point = db.getInt(j++);
				t.pinyin = db.getString(j++);
				t.orgnature = db.getInt(j++);
				t.nobanspeak = db.getInt(j++);
				t.contributeintegral = db.getFloat(j++);
				t.identitys = db.getInt(j++);
				t.nocontributors = db.getInt(j++);
				t.industry = db.getInt(j++);
				t.job = db.getInt(j++);
				t.woid = db.getString(j++);
				t.bbspermissions = db.getString(j++);
				t.medal = db.getString(j++);
				t.gag = db.getDate(j++);
				t.umember = db.getString(j++);
				t.utime = db.getDate(j++);
				t.lip[0] = db.getString(j++);
				t.lip[1] = db.getString(j++);
				t.lua = db.getString(j++);
				t.ltime[0] = db.getDate(j++);
				t.ltime[1] = db.getDate(j++);
				//
				t.tjmember = db.getString(j++);
				t.tjmobile = db.getString(j++);
				t.sfshanggang = db.getInt(j++);

				t.fazhengjiguan = db.getString(j++);
				t.caozuonianxian = db.getString(j++);
				t.xpinpai = db.getInt(j++);
				t.xxinghao = db.getInt(j++);
				t.xqita = db.getString(j++);

				t.cpinpai = db.getInt(j++);
				t.cxinghao = db.getInt(j++);
				t.cqita = db.getString(j++);

				t.jzname = db.getString(j++);
				t.jzxinghao = db.getString(j++);
				t.jzxuliehao = db.getString(j++);
				t.jzlianxi = db.getString(j++);
				t.aihao = db.getString(j++);
				t.zzracky = db.getString(j++);
				t.membertype = db.getInt(j++);
				t.verifgtime = db.getDate(j++);
				t.verifgmember = db.getString(j++);
				t.myintegral = db.getFloat(j++);
				t.remembertype = db.getInt(j++);
				t.rememberorder = db.getInt(j++);
				t.belsell = db.getString(j++);
				t.source = db.getInt(j++);

				t.trainname = db.getString(j++);
				t.trainaddress = db.getString(j++);
				t.traintime = db.getString(j++);

				t.wsttype = db.getInt(j++);
				t.wstmodel = db.getString(j++);

				t.memberheight = db.getString(j++);
				t.ballage = db.getString(j++);
				t.almostscore = db.getString(j++);
				t.likeitems = db.getString(j++);
				t.handfoot = db.getString(j++);
				t.gdistance = db.getString(j++);
				t.yhand = db.getString(j++);
				t.swingrhythm = db.getString(j++);
				t.cardnumber = db.getString(j++);

				t.woid2 = db.getString(j++); // 注册选项

				t.entername = db.getString(j++); // 企业名称
				t.enterpic = db.getString(j++); // 企业logo或图片
				t.enterwebsite = db.getString(j++); // 企业网站
				t.entercontact = db.getString(j++); // 联系方式
				t.enteraddress = db.getString(j++); // 地址
				t.enterproduct = db.getString(j++); // 服务或产品
				t.enterweibo = db.getString(j++); // 企业微博
				t.personalweibo = db.getString(j++); // 个人微博
				t.entertext = db.getString(j++); // 企业介绍

				// 活跃度
				t.logint = db.getInt(j++); // 登陆次数
				t.smsint = db.getInt(j++); // 短信来往次数;
				t.phoneint = db.getInt(j++); // 电话来访次数
				t.eventint = db.getInt(j++); // 参加活动次数
				t.tjmemberint = db.getInt(j++); // 推荐会员次数
				t.actives = db.getInt(j++);
				t.imptype = db.getInt(j++);
				t.leveltype = db.getInt(j++);
				// 销售员电话
				// belsellphone=db.getString(j++);
				t.verifytype = db.getInt(j++);
				t.nomanager = db.getInt(j++);
				t.newlocking = db.getInt(j++);
				t.newlockingdata = db.getDate(j++);
				t.isInvoive = db.getInt(j++);
				t.invoiveType = db.getInt(j++);
				t.invoiveContent = db.getInt(j++);
				t.unitName = db.getString(j++);
				t.invouveState = db.getInt(j++);
				t.personState = db.getInt(j++);
				t.jmobbile = db.getString(j++);
				t.jemail = db.getString(j++);
				t.jaddress = db.getString(j++);
				t.jcity = db.getInt(j++);
				t.pmmj = db.getInt(j++);
				t.emailflag = db.getInt(j++);
				t.qualification = db.getInt(j++);
				t.validity = db.getDate(j++);
				t.emailbooking = db.getString(j++);
				t.bookingemail = db.getInt(j++);
				t.openid = db.getString(j++);
				t.wbuid = db.getString(j++);
				t.wxopenid = db.getString(j++);
				t.isvip = db.getInt(j++);
				t.hospitals = db.getString(j++);
				t.particles_sign = db.getInt(j++);
				t.invoice_sign = db.getInt(j++);
				t.hospital = db.getString(j++);
				t.userid = db.getString(j++);
				t.address = db.getString(j++);
				t.company = db.getString(j++);
				t.tax = db.getInt(j++);
				t.formula = db.getInt(j++);
				t.procurementUnit = db.getString(j++);
				t.issalesman = db.getInt(j++);
				t.parentpro = db.getInt(j++);
				t.agreednum = db.getInt(j++);
				al.add(t);
			}
		} finally {
			db.close();
		}
		return al;
	}

	public static boolean isExisted(String member) throws SQLException {
		boolean flag = false;
		if (!"".equals(member) && member != null) {
			if (OpenID.isOpen()) {
				flag = OpenID.find(member).isExists();
			} else {
				DbAdapter db = new DbAdapter();
				try {
					db.executeQuery("SELECT member FROM Profile WHERE LOWER(member)=" + DbAdapter.cite(member.toLowerCase())); // ORACLE区分大小写
					flag = db.next();
				} finally {
					db.close();
				}
			}
		}
		return flag;
	}

	// 2017-10-17日新增方法，小屈通知说，后台会员管理中不能添加相同姓名的用户，因此改为可以添加相同名字不同手机号的用户。
	public static boolean isExisted2(String member, String mobile) throws SQLException {
		boolean flag = false;
		if (!"".equals(member) && member != null) {

			DbAdapter db = new DbAdapter();
			try {
				db.executeQuery("SELECT member FROM Profile WHERE LOWER(member)=" + DbAdapter.cite(member.toLowerCase()) + " and mobile = " + DbAdapter.cite(mobile)); // ORACLE区分大小写
				flag = db.next();
			} finally {
				db.close();
			}

		}
		return flag;
	}

	// 通过手机查询出来用户名
	public static String getMember_moblie(String mobile) throws SQLException {
		String m = "";
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("select member from Profile where mobile = " + db.cite(mobile));
			if (db.next()) {
				m = db.getString(1);
			}

		} finally {
			db.close();
		}
		return m;

	}

	// 判断是否昵称重复
	public static boolean isFirstname(String community, String firstname) throws SQLException {
		boolean b = false;
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("select member from Profile where member in  (select member from ProfileLayer where firstname =" + db.cite(firstname) + " ) ");

			if (db.next()) {
				b = true;
			}
		} finally {
			db.close();
		}
		return b;
	}

	// public static boolean isExisted1(String member) throws SQLException
	// {
	// boolean flag = false;
	// StringBuilder sb = new StringBuilder();
	// sb.append("SELECT member FROM Profile WHERE member=").append(DbAdapter.cite(member));
	// DbAdapter db = new DbAdapter();
	// try
	// {
	// db.executeQuery(sb.toString());
	// SynRegMethod srm = new SynRegMethod();
	// String sendXML = srm.UWriteXML(member);
	// System.out.println("发送的注册XML：" + sendXML);
	// HttpRequester hreq = new HttpRequester(); //
	// Map param = new HashMap();
	// sendXML = java.net.URLEncoder.encode(sendXML,"gb2312");
	// param.put("request",sendXML);
	// HttpRespons hr =
	// hreq.sendGet("http://222.35.63.147/golden%5Ftest/GoldenPort.asp",param,null);
	//
	// //接收返回的XML 并判断其中相应的XML中RESULT的值
	// String getXML = hr.getContent();
	//
	// System.out.println("接收XML：" + getXML);
	//
	// Document document = DocumentHelper.parseText(getXML);
	// Element root = document.getRootElement();
	// String result = root.element("Result").getText();
	// System.out.println("result：" + result);
	// if(db.next() || "1".equals(result))
	// {
	// flag = true;
	// }
	// // flag = db.next();
	// } catch(Exception ex)
	// {
	// System.out.print(ex.toString());
	// } finally
	// {
	// db.close();
	// }
	// return flag;
	// }

	// 列出详细地址信息给其他人
	public int getType() throws SQLException {
		load();
		return type;
	}

	public int getRclass() throws SQLException {
		load();
		return rclass;
	}

	public int getWagetype() throws SQLException {
		load();
		return wagetype;
	}

	public int getAgio() throws SQLException {
		load();
		return agio;
	}

	public int getPersonState() throws SQLException {
		load();
		return personState;
	}

	public int getInvouveState() throws SQLException {
		load();
		return invouveState;
	}

	public String getLastName(int i) throws SQLException {
		return getLayer(i)._strLastName;
	}

	public String getWebPage(int i) throws SQLException {
		return getLayer(i)._strWebPage;
	}

	private Layer getLayer(int i) throws SQLException {
		Layer layer = (Layer) _htLayer.get(new Integer(i));
		if (layer == null) {
			layer = new Layer();
			int j = this.getLanguage(i);
			DbAdapter db = new DbAdapter();
			try {
				db.executeQuery("SELECT firstname,lastname,organization,address,city,state,zip,country,telephone,fax,"
						+ " webpage,degree,photopath,photopath2,job,title,functions,starturl,school,gblnd,gbort,zzhkszd,province,"
						+ " introduce,section,paddress,ptelephone,club,banspeakreason,contributorsreason,newreason,field,consignee FROM ProfileLayer WHERE profile=" + profile + " AND language=" + j);
				if (db.next()) {
					layer._strFirstName = db.getVarchar(j, i, 1);
					layer._strLastName = db.getVarchar(j, i, 2);
					layer._strOrganization = db.getVarchar(j, i, 3);
					layer._strAddress = db.getVarchar(j, i, 4);
					layer._strCity = db.getVarchar(j, i, 5);
					layer._strState = db.getVarchar(j, i, 6);
					layer._strZip = db.getString(7);
					layer._strCountry = db.getVarchar(j, i, 8);
					layer._strTelephone = db.getString(9);
					layer._strFax = db.getString(10);
					layer._strWebPage = db.getString(11);
					layer.degree = db.getString(12); // 学历
					layer._strPhotopath = db.getString(13); // 照片
					layer.photopath2 = db.getString(14); // 照片
					layer._strJob = db.getVarchar(j, i, 15);
					layer._strTitle = db.getVarchar(j, i, 16);
					layer.functions = db.getVarchar(j, i, 17);
					layer._strStartUrl = db.getString(18);
					layer.school = db.getVarchar(j, i, 19);
					layer.gblnd = db.getVarchar(j, i, 20);
					layer.gbort = db.getVarchar(j, i, 21);
					layer.zzhkszd = db.getVarchar(j, i, 22);
					layer.province = db.getInt(23);
					layer.introduce = db.getVarchar(j, i, 24);
					layer.section = db.getVarchar(j, i, 25);
					layer.paddress = db.getVarchar(j, i, 26);
					layer.ptelephone = db.getVarchar(j, i, 27);
					layer.club = db.getVarchar(j, i, 28);
					layer.banspeakreason = db.getVarchar(j, i, 29);
					layer.contributorsreason = db.getVarchar(j, i, 30);
					layer.newreason = db.getString(31);
					layer.field = db.getString(32);
					layer.consignee = db.getString(33);
				}
			} finally {
				db.close();
			}
			layer._strFirstName = MT.f(layer._strFirstName);
			layer._strLastName = MT.f(layer._strLastName);
			layer._strOrganization = MT.f(layer._strOrganization);
			layer._strAddress = MT.f(layer._strAddress);
			layer._strCity = MT.f(layer._strCity);
			layer._strState = MT.f(layer._strState);
			layer._strZip = MT.f(layer._strZip);
			layer.pzip = MT.f(layer.pzip);
			layer._strCountry = MT.f(layer._strCountry);
			layer._strTelephone = MT.f(layer._strTelephone);
			layer._strFax = MT.f(layer._strFax);
			layer._strWebPage = MT.f(layer._strWebPage);
			layer._strJob = MT.f(layer._strJob);
			layer.degree = MT.f(layer.degree);
			if (layer._strPhotopath == null || layer._strPhotopath.length() < 5) {
				// layer._strPhotopath = "/tea/image/public/defaultphoto.gif";
			}
			layer._strJob = MT.f(layer._strJob);
			layer._strTitle = MT.f(layer._strTitle);
			layer.functions = MT.f(layer.functions);
			layer._strStartUrl = MT.f(layer._strStartUrl);
			layer.school = MT.f(layer.school);
			layer.gblnd = MT.f(layer.gblnd);
			layer.gbort = MT.f(layer.gbort);
			layer.zzhkszd = MT.f(layer.zzhkszd);
			layer.section = MT.f(layer.section);
			layer.club = MT.f(layer.club);
			layer.paddress = MT.f(layer.paddress);
			layer.ptelephone = MT.f(layer.ptelephone);
			layer.banspeakreason = MT.f(layer.banspeakreason);
			layer.contributorsreason = MT.f(layer.contributorsreason);
			layer.newreason = MT.f(layer.newreason);
			layer.field = MT.f(layer.field);
			layer.consignee = MT.f(layer.consignee);
			_htLayer.put(new Integer(i), layer);
		}
		return layer;
	}

	private int getLanguage(int language) throws SQLException {
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT language FROM ProfileLayer WHERE profile=" + profile);
			while (db.next()) {
				v.addElement(new Integer(db.getInt(1)));
			}
		} finally {
			db.close();
		}
		if (v.indexOf(new Integer(language)) != -1) {
			return language;
		} else {
			if (language == 1) {
				if (v.indexOf(new Integer(2)) != -1) {
					return 2;
				}
			} else if (language == 2) {
				if (v.indexOf(new Integer(1)) != -1) {
					return 1;
				}
			}
			if (v.size() < 1) {
				return 0;
			}
		}
		return ((Integer) v.elementAt(0)).intValue();
	}

	private void setLayer(String field, Object value, int language) throws SQLException {
		String str = null;
		if (value instanceof String) {
			str = DbAdapter.cite((String) value);
		} else if (value instanceof Date) {
			str = DbAdapter.cite((Date) value);
		} else if (value instanceof byte[]) {
			str = DbAdapter.cite((byte[]) value);
		} else {
			if (value == null)
				value = "";
			str = DbAdapter.cite(value.toString());
		}
		DbAdapter db = new DbAdapter();
		try {
			int j = db.executeUpdate("UPDATE ProfileLayer SET " + field + "=" + str + " WHERE member=" + DbAdapter.cite(member) + " AND language=" + language);
			if (j < 1)
				db.executeUpdate("INSERT INTO ProfileLayer(profile,member,language," + field + ")VALUES(" + profile + "," + DbAdapter.cite(member) + "," + language + "," + str + ")");
		} finally {
			db.close();
		}
		_htLayer.clear();
	}

	public String getCity(int i) throws SQLException {
		return getLayer(i)._strCity;
	}

	public String getIntroduce(int i) throws SQLException {
		return getLayer(i).introduce;
	}

	public String getGblnd(int i) throws SQLException {
		return getLayer(i).gblnd;
	}

	public String getGbort(int i) throws SQLException {
		return getLayer(i).gbort;
	}

	public String getZzhkszd(int i) throws SQLException {
		return getLayer(i).zzhkszd;
	}

	public String getDegree(int language) throws SQLException {
		return getLayer(language).degree;
	}

	public int getProvince(int language) throws SQLException {
		return getLayer(language).province;
	}

	public void setDegree(String degree, int language) throws SQLException {
		setLayer("degree", degree, language);
	}

	public String getPhotopath(int language) throws SQLException {
		return getLayer(language)._strPhotopath;
	}

	public void setPhotopath(String _strPhotopath, int language) throws SQLException {
		setLayer("photopath", _strPhotopath, language);
	}

	public int getAge() throws SQLException {
		load();
		if (birth != null) {
			Calendar c = Calendar.getInstance();
			int year = c.get(c.YEAR);
			c.setTime(birth);
			return year - c.get(c.YEAR);
		}
		return 0; // _nAge;
	}

	public Date getBirth() throws SQLException {
		load();
		return birth;
	}

	public String getBirthToString() throws SQLException {
		load();
		if (birth == null) {
			return "";
		} else {
			return sdf.format(birth);
		}
	}

	public String getCountry(int i) throws SQLException {
		return getLayer(i)._strCountry;
	}

	public String getJob(int i) throws SQLException {
		return getLayer(i)._strJob;
	}

	public String getSchool(int language) throws SQLException {
		return getLayer(language).school;
	}

	public void setSchool(String school, int language) throws SQLException {
		setLayer("school", school, language);
	}

	public static String retrieveByEmail(String s) throws SQLException {
		StringBuilder sb = new StringBuilder();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT member,password FROM Profile WHERE email=" + DbAdapter.cite(s));
			while (db.next()) {
				sb.append(db.getString(1)).append("/").append(db.getString(2));
			}
		} finally {
			db.close();
		}
		return sb.toString();
	}

	public static void cancel(String member, String community) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("UPDATE Profile  SET password=" + DbAdapter.cite(Integer.toString((int) (Math.random() * 100000D))) + " WHERE member=" + DbAdapter.cite(member) + " AND community="
					+ DbAdapter.cite(community));
			db.executeUpdate("UPDATE Subscriber  SET options=0  WHERE rmember=" + DbAdapter.cite(member));
		} finally {
			db.close();
		}
	}

	public static void createProfileAndRole(String member, String community, String firstname, String email, String role, String password, boolean sex) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {

			db.executeUpdate("insert into profile(member,sex,community,password,email,time) values(" + db.cite(member) + ", " + db.cite(sex) + ", " + db.cite(community) + ", " + db.cite(password)
					+ ", " + db.cite(email) + ", " + db.cite(new Date()) + ")");
			db.executeUpdate("insert into profilelayer(member,firstname,language) values(" + db.cite(member) + ", " + db.cite(firstname) + ",1)");
			db.executeUpdate("insert into adminusrrole(member,role,community) values(" + db.cite(member) + ", " + db.cite(role) + ", " + db.cite(community) + ")");
		} finally {
			db.close();
		}
	}

	public String getEmail() throws SQLException {
		load();

		return email;
	}

	public static String getEmail(String code) throws SQLException {
		String e = "";
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("select email from Profile where code = " + db.cite(code));
			if (db.next()) {
				e = db.getString(1);
			}
		} finally {
			db.close();
		}
		return e;
	}

	public String getBbspermissions() throws SQLException {
		load();
		return this.bbspermissions;
	}

	public String getMedal() throws SQLException {
		load();
		return this.medal;
	}

	public Date getGag() throws SQLException {
		load();
		return this.gag;
	}

	public int getMembertype() throws SQLException {
		load();
		return this.membertype;
	}

	public int getPMMJ() throws SQLException {
		load();
		return this.pmmj;
	}

	public int getRemembertype() throws SQLException {
		load();
		return this.remembertype;
	}

	public int getRememberorder() throws SQLException {
		load();
		return this.rememberorder;
	}

	public String getTrainname() throws SQLException {
		load();
		return this.trainname;
	}

	public String getTrainaddress() throws SQLException {
		load();
		return this.trainaddress;
	}

	public String getTraintime() throws SQLException {
		load();
		return this.traintime;
	}

	public int getVerifytype() throws SQLException {
		load();
		return this.verifytype;
	}

	public int getNomanager() throws SQLException {
		load();
		return this.nomanager;
	}

	public int getWstType() throws SQLException {
		load();
		return this.wsttype;
	}

	public String getWstModel() throws SQLException {
		load();
		return this.wstmodel;
	}

	public String getMemberheight() throws SQLException {
		load();
		return this.memberheight;
	}

	public String getBallage() throws SQLException {
		load();
		return this.ballage;
	}

	public String getAlmostscore() throws SQLException {
		load();
		return this.almostscore;
	}

	public String getLikeitems() throws SQLException {
		load();
		return this.likeitems;
	}

	public String getHandfoot() throws SQLException {
		load();
		return this.handfoot;
	}

	public String getGdistance() throws SQLException {
		load();
		return this.gdistance;
	}

	public String getYhand() throws SQLException {
		load();
		return this.yhand;
	}

	public String getSwingrhythm() throws SQLException {
		load();
		return this.swingrhythm;
	}

	public String getwoid2() throws SQLException {
		load();
		return this.woid2;
	}

	public String getEntername() throws SQLException {
		load();
		return this.entername;
	}

	public String getEnterpic() throws SQLException {
		load();
		return this.enterpic;
	}

	public String getEnterwebsite() throws SQLException {
		load();
		return this.enterwebsite;
	}

	public String getEntercontact() throws SQLException {
		load();
		return this.entercontact;
	}

	public String getEnteraddress() throws SQLException {
		load();
		return this.enteraddress;
	}

	public String getEnterproduct() throws SQLException {
		load();
		return this.enterproduct;
	}

	public String getEnterweibo() throws SQLException {
		load();
		return this.enterweibo;
	}

	public String getPersonalweibo() throws SQLException {
		load();
		return this.personalweibo;
	}

	public String getEntertext() throws SQLException {
		load();
		return this.entertext;
	}

	public String getCardnumber() throws SQLException {
		load();
		return this.cardnumber;
	}

	public void setVerifytype(int verifytype) throws SQLException {
		set("verifytype", verifytype);
		this.verifytype = verifytype;
	}

	public void setNomanager(int nomanager) throws SQLException {
		set("nomanager", nomanager);
		this.nomanager = nomanager;
	}

	public String getBelsell() throws SQLException {
		load();
		return this.belsell;
	}

	public String getTjmobile() throws SQLException {
		load();
		return this.tjmobile;
	}

	public int getSource() throws SQLException {
		load();
		return this.source;
	}

	public int getLogint() throws SQLException {
		load();
		return this.logint;
	}

	public int getSmsint() throws SQLException {
		load();
		return this.smsint;
	}

	public int getPhoneint() throws SQLException {
		load();
		return this.phoneint;
	}

	public int getEventint() throws SQLException {
		load();
		return this.eventint;
	}

	public int getTjmemberint() throws SQLException {
		load();
		return this.tjmemberint;
	}

	public int getActives() throws SQLException {
		load();
		return this.actives;
	}

	public int getImptype() throws SQLException {
		load();
		return this.imptype;
	}

	public int getLeveltype() throws SQLException {
		load();
		return this.leveltype;
	}

	public int getNewlocking() throws SQLException {
		load();
		return this.newlocking;
	}

	public Date getNewlockingdata() throws SQLException {
		load();
		return this.newlockingdata;
	}

	public Date getVerifgtime() throws SQLException {
		load();
		return this.verifgtime;
	}

	public String getVerifgmember() throws SQLException {
		load();
		return this.verifgmember;
	}

	public String getFazhengjiguan() throws SQLException {
		load();
		return this.fazhengjiguan;
	}

	public String getTjmember() throws SQLException {
		load();
		return this.tjmember;
	}

	public int getSfshanggang() throws SQLException {
		load();
		return this.sfshanggang;
	}

	public String getCaozuonianxian() throws SQLException {
		load();
		return this.caozuonianxian;
	}

	public int getXpinpai() throws SQLException {
		load();
		return this.xpinpai;
	}

	public int getXxinghao() throws SQLException {
		load();
		return this.xxinghao;
	}

	public String getXqita() throws SQLException {
		load();
		return this.xqita;
	}

	public int getCpinpai() throws SQLException {
		load();
		return this.cpinpai;
	}

	public int getCxinghao() throws SQLException {
		load();
		return this.cxinghao;
	}

	public String getCqita() throws SQLException {
		load();
		return this.cqita;
	}

	public String getJzname() throws SQLException {
		load();
		return this.jzname;
	}

	public String getJzxinghao() throws SQLException {
		load();
		return this.jzxinghao;
	}

	public String getJzxuliehao() throws SQLException {
		load();
		return this.jzxuliehao;
	}

	public String getJzlianxi() throws SQLException {
		load();
		return this.jzlianxi;
	}

	public String getAihao() throws SQLException {
		load();
		return this.aihao;
	}

	public float getIntegral() throws SQLException {
		load();
		java.text.DecimalFormat numberformat = new java.text.DecimalFormat("0.00");
		String s = df.format(integral);
		s = s.replace(",", "");
		integral = Float.parseFloat(s);
		return integral;
	}

	public float getMyintegral() throws SQLException {
		load();
		java.text.DecimalFormat numberformat = new java.text.DecimalFormat("0.00");
		String s = df.format(myintegral);
		s = s.replace(",", "");
		myintegral = Float.parseFloat(s);
		return myintegral;
	}

	public float getContributeintegral() throws SQLException {
		load();
		java.text.DecimalFormat f = new java.text.DecimalFormat("0.00");
		String s = df.format(contributeintegral);
		s = s.replace(",", "");
		contributeintegral = Float.parseFloat(s);
		return contributeintegral;
	}

	public void setEmail(String email) throws SQLException {
		set("email", email);
		this.email = email;
	}

	public void setBbspermissions(String bbspermissions) throws SQLException {
		set("bbspermissions", bbspermissions);
		this.bbspermissions = bbspermissions;
	}

	public void setMedal(String medal) throws SQLException {
		set("medal", medal);
		this.medal = medal;
	}

	public void setGag(Date gag) throws SQLException {
		set("gag", gag);
		this.gag = gag;
	}

	public void setMembertype(int membertype) throws SQLException {
		set("membertype", membertype);
		this.membertype = membertype;
	}

	public void setPMMJ(int pmmj) throws SQLException {
		set("pmmj", pmmj);
		this.pmmj = pmmj;
	}

	public void setRemembertype(int remembertype) throws SQLException {
		set("remembertype", remembertype);
		this.remembertype = remembertype;
	}

	public void setRememberorder(int rememberorder) throws SQLException {
		set("rememberorder", rememberorder);
		this.rememberorder = rememberorder;
	}

	public void setBelsell(String belsell) throws SQLException {
		set("belsell", belsell);
		this.belsell = belsell;
	}

	public void setTjmobile(String tjmobile) throws SQLException {
		set("tjmobile", tjmobile);
		this.tjmobile = tjmobile;
	}

	public void setTrainname(String trainname) throws SQLException {
		set("trainname", trainname);
		this.trainname = trainname;
	}

	public void setTrainaddress(String trainaddress) throws SQLException {
		set("trainaddress", trainaddress);
		this.trainaddress = trainaddress;
	}

	public void setTraintime(String traintime) throws SQLException {
		set("traintime", traintime);
		this.traintime = traintime;
	}

	public void setMemberheight(String memberheight) throws SQLException {
		set("memberheight", memberheight);
		this.memberheight = memberheight;
	}

	public void setBallage(String ballage) throws SQLException {
		set("ballage", ballage);
		this.ballage = ballage;
	}

	public void setAlmostscore(String almostscore) throws SQLException {
		set("almostscore", almostscore);
		this.almostscore = almostscore;
	}

	public void setLikeitems(String likeitems) throws SQLException {
		set("likeitems", likeitems);
		this.likeitems = likeitems;
	}

	public void setHandfoot(String handfoot) throws SQLException {
		set("handfoot", handfoot);
		this.handfoot = handfoot;
	}

	public void setGdistance(String gdistance) throws SQLException {
		set("gdistance", gdistance);
		this.gdistance = gdistance;
	}

	public void setYhand(String yhand) throws SQLException {
		set("yhand", yhand);
		this.yhand = yhand;
	}

	public void setSwingrhythm(String swingrhythm) throws SQLException {
		set("swingrhythm", swingrhythm);
		this.swingrhythm = swingrhythm;
	}

	public void setWoid2(String woid2) throws SQLException {
		set("woid2", woid2);
		this.woid2 = woid2;
	}

	public void setEntername(String entername) throws SQLException {
		set("entername", entername);
		this.entername = entername;
	}

	public void setEnterpic(String enterpic) throws SQLException {
		set("enterpic", enterpic);
		this.enterpic = enterpic;
	}

	public void setEnterwebsite(String enterwebsite) throws SQLException {
		set("enterwebsite", enterwebsite);
		this.enterwebsite = enterwebsite;
	}

	public void setEntercontact(String entercontact) throws SQLException {
		set("entercontact", entercontact);
		this.entercontact = entercontact;
	}

	public void setEnteraddress(String enteraddress) throws SQLException {
		set("enteraddress", enteraddress);
		this.enteraddress = enteraddress;
	}

	public void setEnterproduct(String enterproduct) throws SQLException {
		set("enterproduct", enterproduct);
		this.enterproduct = enterproduct;
	}

	public void setEnterweibo(String enterweibo) throws SQLException {
		set("enterweibo", enterweibo);
		this.enterweibo = enterweibo;
	}

	public void setPersonalweibo(String personalweibo) throws SQLException {
		set("personalweibo", personalweibo);
		this.personalweibo = personalweibo;
	}

	public void setEntertext(String entertext) throws SQLException {
		set("entertext", entertext);
		this.entertext = entertext;
	}

	public void setCardnumber(String cardnumber) throws SQLException {
		set("cardnumber", cardnumber);
		this.cardnumber = cardnumber;
	}

	public void setSource(int source) throws SQLException {
		set("source", source);
		this.source = source;
	}

	public void setLogint(int logint) throws SQLException {
		set("logint", logint);
		this.logint = logint;
	}

	public void setLogin(String ip, String ua, Date time) throws SQLException {
		this.logint++;
		this.ltime[1] = this.ltime[0];
		this.ltime[0] = time;
		this.lip[1] = this.lip[0];
		this.lip[0] = ip;
		this.lua = ua;
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("UPDATE Profile SET logint=" + logint + ",lip0=" + DbAdapter.cite(lip[0]) + ",lip1=" + DbAdapter.cite(lip[1]) + ",lua=" + DbAdapter.cite(lua) + ",ltime0="
					+ DbAdapter.cite(ltime[0]) + ",ltime1=" + DbAdapter.cite(ltime[1]) + " WHERE member=" + DbAdapter.cite(member));
		} finally {
			db.close();
		}
	}

	public void setSmsint(int smsint) throws SQLException {
		set("smsint", smsint);
		this.smsint = smsint;
	}

	public void setPhoneint(int phoneint) throws SQLException {
		set("phoneint", phoneint);
		this.phoneint = phoneint;
	}

	public void setEventint(int eventint) throws SQLException {
		set("eventint", eventint);
		this.eventint = eventint;
	}

	public void setTjmemberint(int tjmemberint) throws SQLException {
		set("tjmemberint", tjmemberint);
		this.tjmemberint = tjmemberint;
	}

	public void setActives(int actives) throws SQLException {
		set("actives", actives);
		this.actives = actives;
	}

	public void setImptype(int imptype) throws SQLException {
		set("imptype", imptype);
		this.imptype = imptype;
	}

	public void setLeveltype(int leveltype) throws SQLException {
		set("leveltype", leveltype);
		this.leveltype = leveltype;
	}

	public void setNewlocking(int newlocking) throws SQLException {
		set("newlocking", newlocking);
		this.newlocking = newlocking;
	}

	public void setNewlockingdata(Date newlockingdata) throws SQLException {
		set("newlockingdata", newlockingdata);
		this.newlockingdata = newlockingdata;
	}

	public void setVerifgtime(Date verifgtime) throws SQLException {
		set("verifgtime", verifgtime);
		this.verifgtime = verifgtime;
	}

	public void setVerifgmember(String verifgmember) throws SQLException {
		set("verifgmember", verifgmember);
		this.verifgmember = verifgmember;
	}

	public void setZzracky(String zzracky) throws SQLException {
		set("zzracky", zzracky);
		this.zzracky = zzracky;
	}

	// old
	public void setWst(int membertype, int imptype, String code, String mobile, int wsttype, int xpinpai, String wstmodel, int source) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("UPDATE Profile SET membertype=" + membertype + ",imptype=" + imptype + ",code=" + DbAdapter.cite(code) + ",mobile=" + DbAdapter.cite(mobile) + ",wsttype=" + wsttype
					+ ",xpinpai=" + xpinpai + ",wstmodel=" + DbAdapter.cite(wstmodel) + ",source=" + source + " WHERE member=" + DbAdapter.cite(member));
		} finally {
			db.close();
		}
		this.membertype = membertype;
		this.imptype = imptype;
		this.code = code;
		this.mobile = mobile;
		this.wsttype = wsttype;
		this.xpinpai = xpinpai;
		this.wstmodel = wstmodel;
		this.source = source;
	}

	// new 2012 同步会员
	public void setWst(int membertype, int imptype, String code, String mobile, int wsttype, int xpinpai, String wstmodel, int source, String tjmember, String tjmobile) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("UPDATE Profile SET membertype=" + membertype + ",imptype=" + imptype + ",code=" + DbAdapter.cite(code) + ",mobile=" + DbAdapter.cite(mobile) + ",wsttype=" + wsttype
					+ ",xpinpai=" + xpinpai + ",wstmodel=" + DbAdapter.cite(wstmodel) + ",source=" + source + ",tjmember=" + DbAdapter.cite(tjmember) + ",tjmobile=" + DbAdapter.cite(tjmobile)
					+ " WHERE member=" + DbAdapter.cite(member));
		} finally {
			db.close();
		}
		this.membertype = membertype;
		this.imptype = imptype;
		this.code = code;
		this.mobile = mobile;
		this.wsttype = wsttype;
		this.xpinpai = xpinpai;
		this.wstmodel = wstmodel;
		this.source = source;
		this.tjmember = tjmember;
		this.tjmobile = tjmobile;
	}

	public void setWST(String tjmember, int sfshanggang, String fazhengjiguan, String caozuonianxian, int xpinpai, int xxinghao, String xqita, int cpinpai, int cxinghao, String cqita, String jzname,
			String jzxinghao, String jzxuliehao, String jzlianxi, String aihao, int wsttype, String wstmodel) throws SQLException {
		DbAdapter db = new DbAdapter();
		StringBuffer sp = new StringBuffer();
		try {
			sp.append("UPDATE Profile SET ");
			sp.append("tjmember=").append(DbAdapter.cite(tjmember));
			sp.append(",sfshanggang=").append(sfshanggang);
			sp.append(",fazhengjiguan=").append(DbAdapter.cite(fazhengjiguan));
			sp.append(",caozuonianxian=").append(DbAdapter.cite(caozuonianxian));
			sp.append(",xpinpai=").append(xpinpai);
			sp.append(",xxinghao=").append(xxinghao);
			sp.append(",xqita=").append(DbAdapter.cite(xqita));
			sp.append(",cpinpai=").append(cpinpai);
			sp.append(",cxinghao=").append(cxinghao);
			sp.append(",cqita=").append(DbAdapter.cite(cqita));

			sp.append(",jzname=").append(DbAdapter.cite(jzname));
			sp.append(",jzxinghao=").append(DbAdapter.cite(jzxinghao));
			sp.append(",jzxuliehao=").append(DbAdapter.cite(jzxuliehao));
			sp.append(",jzlianxi=").append(DbAdapter.cite(jzlianxi));
			sp.append(",aihao=").append(DbAdapter.cite(aihao));
			sp.append(",wsttype=").append(wsttype);
			sp.append(",wstmodel=").append(DbAdapter.cite(wstmodel));
			sp.append("  WHERE member=" + DbAdapter.cite(member));
			db.executeUpdate(sp.toString());

		} finally {
			db.close();
		}

		this.tjmember = tjmember;
		this.sfshanggang = sfshanggang;
		this.fazhengjiguan = fazhengjiguan;
		this.caozuonianxian = caozuonianxian;
		this.xpinpai = xpinpai;
		this.xxinghao = xxinghao;
		this.xqita = xqita;
		this.cpinpai = cpinpai;
		this.cxinghao = cxinghao;
		this.cqita = cqita;
		this.jzname = jzname;
		this.jzxinghao = jzxinghao;
		this.jzxuliehao = jzxuliehao;
		this.jzlianxi = jzlianxi;
		this.aihao = aihao;
		this.wsttype = wsttype;
		this.wstmodel = wstmodel;
	}

	public void setOrgnature(int orgnature) throws SQLException {
		set("orgnature", orgnature);
		this.orgnature = orgnature;
	}

	public void setCode(String code) throws SQLException {
		set("code", code);
		this.code = code;
	}

	public String getAddress(int i) throws SQLException {
		return getLayer(i)._strAddress;
	}

	public String getPAddress(int i) throws SQLException {
		return getLayer(i).paddress;
	}

	public void setAddress(String _strAddress, int language) throws SQLException {
		setLayer("address", _strAddress, language);
	}

	public void setConsignee(String consignee, int language) throws SQLException {
		setLayer("consignee", consignee, language);
	}

	public void setFunctions(String functions, int language) throws SQLException {
		setLayer("functions", functions, language);
	}

	public void setPAddress(String paddress, int language) throws SQLException {
		setLayer("paddress", paddress, language);
	}

	public void setPTelephone(String ptelephone, int language) throws SQLException {
		setLayer("ptelephone", ptelephone, language);
	}

	public void setZip(String zip, int language) throws SQLException {
		setLayer("zip", zip, language);
	}

	public void setPZip(String pzip, int language) throws SQLException {
		setLayer("pzip", pzip, language);
	}

	public void set__(String question, String answer) throws SQLException {
		set("question", question);
		set("answer", answer);
	}

	public String getZip(int i) throws SQLException {
		return getLayer(i)._strZip;
	}

	public String getPZip(int i) throws SQLException {
		return getLayer(i).pzip;
	}

	public void set(String field, Object value) throws SQLException {
		String str = null;
		if (value instanceof String) {
			str = DbAdapter.cite((String) value);
		} else if (value instanceof Date) {
			str = DbAdapter.cite((Date) value);
		} else if (value instanceof Boolean) {
			str = DbAdapter.cite(((Boolean) value).booleanValue());
		} else if (value != null) {
			str = DbAdapter.cite(value.toString());
		}
		DbAdapter db = new DbAdapter();
		try {
			// db.executeUpdate(profile,"UPDATE Profile SET " + field + "=" +
			// str + " WHERE member=" + DbAdapter.cite(member));
			db.executeUpdate(profile, "UPDATE Profile SET " + field + "=" + str + " WHERE profile=" + profile);
		} finally {
			db.close();
		}
		_cache.remove(profile);
	}

	public void setFamst(int famst) throws SQLException {
		set("famst", String.valueOf(famst));
		this.famst = famst;
	}

	public void setFamdt(Date famdt) throws SQLException {
		set("famdt", famdt);
		this.famdt = famdt;
	}

	public void setAnzkd(int anzkd) throws SQLException {
		set("anzkd", String.valueOf(anzkd));
		this.anzkd = anzkd;
	}

	public void setLocking(boolean locking) throws SQLException {
		set("locking", locking ? "1" : "0");
		this.locking = locking;
	}

	public void setNobanspeak(int nobanspeak) throws SQLException {
		set("nobanspeak", nobanspeak);
		this.nobanspeak = nobanspeak;
	}

	public void setNocontributors(int nocontributors) throws SQLException {
		set("nocontributors", nocontributors);
		this.nocontributors = nocontributors;
	}

	public void setIndustry(int industry) throws SQLException {
		set("industry", industry);
		this.industry = industry;
	}

	public void setWoid(String woid) throws SQLException {
		set("woid", woid);
		this.woid = woid;
	}

	public void setJob(int job) throws SQLException {
		set("job", job);
		this.job = job;
	}

	public void setIdentitys(int identitys) throws SQLException {
		set("identitys", identitys);
		this.identitys = identitys;
	}

	public void setClub(String club, int language) throws SQLException {
		setLayer("club", club, language);
	}

	public void setBanspeakreason(String banspeakreason, int language) throws SQLException {
		setLayer("banspeakreason", banspeakreason, language);
	}

	public void setNewreason(String newreason, int language) throws SQLException {
		setLayer("newreason", newreason, language);
	}

	public void setContributorsreason(String contributorsreason, int language) throws SQLException {
		setLayer("contributorsreason", contributorsreason, language);
	}

	public void setZzgatwj(boolean zzgatwj) throws SQLException {
		set("zzgatwj", Boolean.valueOf(zzgatwj));
		this.zzgatwj = zzgatwj;
	}

	public void setZznyhk(boolean zznyhk) throws SQLException {
		set("zznyhk", Boolean.valueOf(zznyhk));
		this.zznyhk = zznyhk;
	}

	public void setZzpridn(String zzpridn) throws SQLException {
		set("zzpridn", zzpridn);
		this.zzpridn = zzpridn;
	}

	public void setZzfmbkg(String zzfmbkg) throws SQLException {
		set("zzfmbkg", zzfmbkg);
		this.zzfmbkg = zzfmbkg;
	}

	public boolean changemobile(String s, String s1) throws SQLException {
		password = s;
		mobile = s1;
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try {
			// int ff = db.getInt("ProfileCMobile " + DbAdapter.cite(s) +
			// ", " +
			// DbAdapter.cite(s1) + ", " + DbAdapter.cite(member));
			int ff = 0;
			db.executeUpdate("SELECT member FROM Profile 	WHERE mobile=" + DbAdapter.cite(s1));
			if (db.next()) {
				ff = db.getInt("select 1");
			} else {
				db.executeUpdate("UPDATE Profile SET password=" + DbAdapter.cite(s) + ",  mobile=" + DbAdapter.cite(s1) + "  WHERE member=" + DbAdapter.cite(member));
				ff = db.getInt("select 0");
			}
			if (ff == 0) {
				flag = true;
			}
		} finally {
			db.close();
		}
		return flag;
	}

	/*
	 * public void set(int i, String s, String s1, String s2, String s3, String
	 * s4, String s5, String s6, String s7, String s8, String s9, String s10)
	 * throws SQLException { Layer layer = getLayer(i); layer._strFirstName = s;
	 * layer._strLastName = s1; layer._strOrganization = s3; layer._strAddress =
	 * s4; layer._strCity = s5; layer._strState = s6; layer._strZip = s7;
	 * layer._strCountry = s8; layer._strTelephone = s9; layer._strFax = s10;
	 * store(i); }
	 */
	/*
	 * public void set(int j, int k, String s, String s1, String s2, String s3,
	 * String s4, String s5, String s6, String s7, String s8, String s9, String
	 * s10, String s11) throws SQLException { type = j; getLayer(k)._strWebPage
	 * = s11; set(k, s, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10); }
	 */
	public Profile(int profile) {
		this.profile = profile;
		loaded = false;
		_htLayer = new Hashtable();
	}

	/**
	 * Profile
	 * 
	 * @param member
	 *            String
	 * @param password
	 *            String
	 * @param email
	 *            String
	 * @param cardtype
	 *            int
	 * @param card
	 *            String
	 * @param sex
	 *            int
	 */
	public Profile(String member, String password, String email, int cardtype, String card, int sex) {
		this.member = member;
		this.password = password;
		this.email = email;
		this.cardtype = cardtype;
		this.card = card;
		boolean sex1 = false;
		if (sex == 1) {
			sex1 = true;
		}
		this.sex = sex1;
	}

	private Profile(String member, String mobile, String msnid) throws SQLException {
		this.member = member;
		this.mobile = mobile;
		this.msnid = msnid;

	}

	public static Enumeration findByCommunityNew(String community, String st, int unit, boolean bool) throws SQLException {

		StringBuilder sql = new StringBuilder();
		sql.append("select member from Profile where profile in (SELECT aus.member FROM DeptSeq aus INNER JOIN AdminUsrRole aur ON aus.member=aur.member WHERE aur.community=")
				.append(DbAdapter.cite(community)).append(" AND aus.dept=").append(unit);
		sql.append(" AND aur.role!='/' AND ( aur.unit=" + unit + " OR aur.dept LIKE ").append(DbAdapter.cite("%/" + unit + "/%")).append(")");
		if (bool) {
			sql.append(" AND aur.options NOT LIKE '%/1/%'");
		}
		sql.append(")").append(st);
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery(sql.toString());
			while (db.next()) {

				v.addElement(db.getString(1));
			}
		} finally {
			db.close();
		}
		return v.elements();
	}

	public static Enumeration findByCommunityMem(String community, String st, boolean bool) throws SQLException {

		StringBuilder sql = new StringBuilder();
		sql.append("select member from Profile where profile in (SELECT aus.member FROM DeptSeq aus INNER JOIN AdminUsrRole aur ON aus.member=aur.member WHERE aur.community=").append(
				DbAdapter.cite(community));
		sql.append(" AND aur.role!='/'");
		if (bool) {
			sql.append(" AND aur.options NOT LIKE '%/1/%'");
		}
		sql.append(")").append(st);
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery(sql.toString());
			while (db.next()) {

				v.addElement(db.getString(1));
			}
		} finally {
			db.close();
		}
		return v.elements();
	}

	public void update(String member, String community, int sex, String card, int cardtype, String firstname, String mobile, String email, int language) throws SQLException {
		DbAdapter db = new DbAdapter();
		DbAdapter db1 = new DbAdapter();
		try {
			db.executeUpdate("UPDATE Profile SET mobile=" + DbAdapter.cite(mobile) + ",sex=" + sex + ",community=" + DbAdapter.cite(community) + ",card=" + DbAdapter.cite(card) + ",cardtype="
					+ cardtype + ",email= " + DbAdapter.cite(email) + " WHERE member=" + DbAdapter.cite(member));
			db.executeUpdate("UPDATE ProfileLayer SET firstname= " + DbAdapter.cite(firstname) + " WHERE member=" + DbAdapter.cite(member) + "and language=" + language);
			db1.executeQuery("SELECT Profile.mobile,Profile.sex,Profile.community,Profile.card,Profile.cardtype,Profile.email,ProfileLayer.firstname FROM Profile,ProfileLayer WHERE Profile.member="
					+ DbAdapter.cite(member) + "and ProfileLayer.member=" + DbAdapter.cite(member) + "and language = " + language);
			if (db1.next()) {
				this.member = member;
				this.mobile = db1.getString(1);
				this.sex = db1.getInt(2) != 0;
				this.community = db1.getString(3);
				this.card = db1.getString(4);
				this.cardtype = db1.getInt(5);
				this.email = db1.getString(6);
				new Layer()._strFirstName = db1.getString(7);
				_cache.clear();
			}
		} finally {
			db.close();
			db1.close();
		}
	}

	public static int findValid(String member) throws SQLException {
		int valid = -1;
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("select valid from Profile where member=" + db.cite(member));
			while (db.next()) {
				valid = db.getInt(1);
			}
		} finally {
			db.close();
		}
		return valid;
	}

	public static int findMob(String mob) throws SQLException {
		int profile = -1;
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("select profile from Profile where mobile=" + db.cite(mob));
			while (db.next()) {
				profile = db.getInt(1);
			}
		} finally {
			db.close();
		}
		return profile;
	}

	public static void create(String member, String community, String password, String mobile, boolean sex, String card, int cardtype, String firstname, String email, int language, String caller)
			throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("INSERT INTO Profile(member,community,password,mobile,sex,card,cardtype,email,caller) VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ","
					+ DbAdapter.cite(password) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(sex) + "," + DbAdapter.cite(card) + "," + cardtype + "," + DbAdapter.cite(email) + ","
					+ DbAdapter.cite(caller) + ")");

			db.executeUpdate("INSERT INTO ProfileLayer(member,language,firstname)VALUES(" + DbAdapter.cite(member) + "," + language + "," + DbAdapter.cite(firstname) + ")");

		} finally {
			db.close();
		}
		Subscriber.create(community, new RV(member), 0);
	}

	// 注册一个新的话务员
	public static void create(String member, int language, String site, String password, String mobile, String firstname, int sex, String community, int cardtype, String card, int type)
			throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			int i = 0, j = 0, h = 0;
			i = db.executeUpdate("INSERT INTO caller (member,site,type,regdate) VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(site) + " ," + type + ", getDate())");
			if (i > 0) {
				if (password == null) {
					j = db.executeUpdate("INSERT INTO Profile(member,password,mobile,sex,community,card,cardtype) VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite("1234") + ","
							+ DbAdapter.cite(mobile) + "," + sex + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(card) + "," + cardtype + ")");
				} else {
					j = db.executeUpdate("INSERT INTO Profile(member,password,mobile,sex,community,card,cardtype) VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(password) + ","
							+ DbAdapter.cite(mobile) + "," + sex + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(card) + "," + cardtype + ")");
				}
			}
			if (j > 0) {
				h = db.executeUpdate("INSERT INTO ProfileLayer(member,language,firstname) VALUES(" + DbAdapter.cite(member) + "," + language + "," + DbAdapter.cite(firstname) + ")");
			}
			if (j < 0 || h < 0) {
				db.executeQuery("DELETE FROM caller WHERE member=" + DbAdapter.cite(member));
				db.executeUpdate("DELETE FROM Profile where member=" + DbAdapter.cite(member));
			}
			// Caller call =new Caller(member);
			// call.load();
		} finally {
			db.close();
		}
	}

	public static boolean isLExisted(String member, int language) throws SQLException {
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try {
			db.getInt("SELECT member  FROM ProfileLayer  WHERE member=" + DbAdapter.cite(member) + " AND language=" + language);
			flag = db.next();
		} finally {
			db.close();
		}
		return flag;
	}

	public static void delete(String member, int language, String community) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("DELETE FROM Profile WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
			db.executeUpdate("DELETE FROM ProfileLayer WHERE member=" + DbAdapter.cite(member) + " AND language=" + language);
		} finally {
			db.close();
		}
		_cache.remove(member + ":" + community);
	}

	public static boolean isExist(String member, String password) throws SQLException {
		boolean flag = false;
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT * FROM Profile WHERE member=").append(DbAdapter.cite(member)).append("AND password=").append(DbAdapter.cite(password));
		System.out.println(sb.toString());

		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery(sb.toString());
			flag = db.next();
		} finally {
			db.close();
		}
		return flag;
	}

	public void set(String member, String community, String password, String mobile, int sex, String card, int cardtype, String firstname, String email, int language, String caller)
			throws SQLException {
		DbAdapter db = new DbAdapter();
		DbAdapter db1 = new DbAdapter();
		try {
			db.executeUpdate("UPDATE Profile SET password=" + DbAdapter.cite(password) + ",mobile=" + DbAdapter.cite(mobile) + ",sex=" + sex + ",card=" + DbAdapter.cite(card) + ",cardtype="
					+ cardtype + ",email=" + DbAdapter.cite(email) + ",caller=" + DbAdapter.cite(caller) + " WHERE member =" + DbAdapter.cite(member));
			db.executeUpdate("UPDATE ProfileLayer SET firstname=" + DbAdapter.cite(firstname) + " WHERE member=" + DbAdapter.cite(member));
			db1.executeQuery("SELECT Profile.password,Profile.mobile,Profile.sex,Profile.card,Profile.cardtype,Profile.email,Profile.caller,ProfileLayer.firstname FROM Profile,ProfileLayer where Profile.member="
					+ DbAdapter.cite(member) + "AND ProfileLayer.member=" + DbAdapter.cite(member));
			if (db1.next()) {
				this.member = member;
				this.password = db1.getString(1);
				this.mobile = db1.getString(2);
				if (db1.getInt(3) == 0) {
					this.sex = true;
				} else {
					this.sex = false;
				}
				this.card = db1.getString(4);
				this.cardtype = db1.getInt(5);
				this.email = db1.getString(6);
				this.caller = db1.getString(7);

				new Layer()._strFirstName = db1.getString(8);
				// this.setFirstName(db1.getString(8), language);

			}
		} finally {
			db.close();
			db1.close();
		}
		Subscriber.create(community, new RV(member), 0);
		find(member);
	}

	public void setMsnID(String msnid) throws SQLException {
		set("msnid", msnid);
		// DbAdapter db = new DbAdapter();
		// try
		// {
		// db.executeUpdate("UPDATE Profile SET msn=" + db.cite(msn) + ",msnid="
		// + db.cite(msnid) + " WHERE member=" + DbAdapter.cite(member));
		// } finally
		// {
		// db.close();
		// }
		this.msnid = msnid;
	}

	public int setPassword(String member, String newpassword) throws SQLException {

		DbAdapter db = new DbAdapter();
		int back = 0;
		try {
			back = db.executeUpdate("UPDATE Profile SET password= " + DbAdapter.cite(newpassword) + " where member=" + DbAdapter.cite(member));
			password = newpassword;
		} finally {
			db.close();
		}
		return back;
	}

	public static void create(String member, String password, String community, String email, Date birth, int type, int language, String firstName, String lastName, String organization,
			String address, String city, String state, String zip, String country, String telephone, String fax, String webpage, String mobile) throws SQLException {
		if (OpenID.isOpen()) {
			OpenID.create(member, password, email, community);
		}
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("INSERT INTO Profile(profile,member,password,community,email,birth,type,time,mobile)VALUES(" + Seq.get() + "," + DbAdapter.cite(member) + ", " + DbAdapter.cite(password)
					+ "," + DbAdapter.cite(community) + "," + DbAdapter.cite(email) + ", " + DbAdapter.cite(birth) + "," + type + "," + db.citeCurTime() + "," + DbAdapter.cite(mobile) + ")");
			db.executeUpdate("INSERT INTO ProfileLayer(member, language, firstname, lastname, organization, address, city, state, zip, country, telephone, fax, webpage)VALUES ("
					+ DbAdapter.cite(member) + ", " + language + "," + DbAdapter.cite(firstName) + ", " + DbAdapter.cite(lastName) + ", " + DbAdapter.cite(organization) + ", "
					+ DbAdapter.cite(address) + "," + DbAdapter.cite(city) + ", " + DbAdapter.cite(state) + ", " + DbAdapter.cite(zip) + "," + DbAdapter.cite(country) + ", "
					+ DbAdapter.cite(telephone) + ", " + DbAdapter.cite(fax) + ", " + DbAdapter.cite(webpage) + ")");
		} finally {
			db.close();
		}
		Subscriber.create(community, new RV(member), 0);
	}

	/**
	 * 添加或修改登录用户
	 * 
	 * @param member
	 * @param password
	 * @param community
	 * @param email
	 * @param type
	 * @param language
	 * @param firstName
	 * @param lastName
	 * @param telephone
	 * @param mobile
	 * @param sex
	 * @param job
	 * @param title
	 * @param section
	 * @throws SQLException
	 */
	public static void set(String member, String password, String community, String email, int type, int language, String firstName, String lastName, String telephone, String mobile, int sex,
			String job, String title, String section) throws SQLException {

		int profile = 0;
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT profile FROM Profile WHERE member=" + DbAdapter.cite(member));
			profile = db.next() ? db.getInt(1) : 0;
			if (profile < 1) {
				if (OpenID.isOpen()) {
					OpenID.create(member, password, email, community);
				}
				db.executeUpdate("INSERT INTO Profile(profile,member,password,community,email,type,time,mobile,sex)VALUES(" + Seq.get() + "," + DbAdapter.cite(member) + ", "
						+ DbAdapter.cite(password) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(email) + "," + type + "," + db.citeCurTime() + "," + DbAdapter.cite(mobile) + "," + sex
						+ ")");

				Subscriber.create(community, new RV(member), 0);
			} else {
				db.executeUpdate("UPDATE Profile SET sex=" + sex + ",community=" + DbAdapter.cite(community) + ",email=" + DbAdapter.cite(email) + ",type=" + type + ",mobile="
						+ DbAdapter.cite(mobile) + "WHERE profile=" + profile);
			}
			db.executeQuery("SELECT member FROM ProfileLayer WHERE member=" + DbAdapter.cite(member) + "and language=" + language);
			int isMember = db.next() ? 1 : 0;
			if (isMember < 1) {
				db.executeUpdate("INSERT INTO ProfileLayer(member, language, firstname, lastname, telephone,job,title,section)VALUES (" + DbAdapter.cite(member) + ", " + language + ","
						+ DbAdapter.cite(firstName) + ", " + DbAdapter.cite(lastName) + ", " + DbAdapter.cite(telephone) + "," + DbAdapter.cite(job) + "," + DbAdapter.cite(title) + ","
						+ DbAdapter.cite(section) + ")");
			} else {
				db.executeUpdate("UPDATE ProfileLayer SET language=" + language + ",firstname=" + DbAdapter.cite(firstName) + ",lastname=" + DbAdapter.cite(lastName) + ",telephone="
						+ DbAdapter.cite(telephone) + ",job=" + DbAdapter.cite(job) + ",title=" + DbAdapter.cite(title) + ",section=" + DbAdapter.cite(section) + " WHERE member="
						+ DbAdapter.cite(member) + "and language=" + language);
			}

		} finally {
			db.close();
		}

	}

	// public boolean create(String member, String Name, String Password, String
	// EmailAddress, String MobileNumber) throws SQLException
	// {
	// DbAdapter db = new DbAdapter();
	// try
	// {
	// db.executeUpdate("INSERT INTO Profile(member, password, age, type,time,mobile)VALUES ("
	// + DbAdapter.cite(member) + ", " + DbAdapter.cite(Password) + ", '0','1',"
	// + db.citeCurTime() + "," + DbAdapter.cite(MobileNumber) + ")");
	// db.executeUpdate("INSERT INTO ProfileLayer(member, language, firstname, lastname, email, organization, address, city, state, zip, country, telephone, fax, webpage)VALUES ("
	// + DbAdapter.cite(member) + ", 1," + DbAdapter.cite(Name) + ", '', " +
	// DbAdapter.cite(EmailAddress) + ",'', '', '', '','', '', '', '', '')");
	// } finally
	// {
	// db.close();
	// }
	// Subscriber.create(community, new RV(member), 0);
	// return true;
	// }

	public static Profile create(String member, String password, String community, String email, String domain) throws SQLException {
		if ("csvclub".equals(community)) {
			password = SMS.md5_16(password);
		}
		if (OpenID.isOpen()) {
			OpenID.create(member, password, email, domain);
		}
		int newid = Seq.get();
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(newid, "INSERT INTO Profile(profile,member,password,community,email,deleted,time)VALUES(" + newid + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(password) + ","
					+ DbAdapter.cite(community) + "," + DbAdapter.cite(email) + ",0," + db.citeCurTime() + ")");
		} finally {
			db.close();
		}
		Subscriber.create(community, new RV(member), 0);
		return find(newid);
	}

	// @author黄愉
	// 与上面的那个一样
	public static Enumeration findByAudit(String member) throws SQLException {
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT * FROM Profile WHERE member=" + member);
			while (db.next()) {
				String memberid = db.getString(2);
				String password = db.getString(3);
				String email = db.getString(24);
				int cardtype = Integer.parseInt(db.getString(13));
				String card = db.getString(12);
				int sex = Integer.parseInt(db.getString(8));
				v.addElement(new Profile(memberid, password, email, cardtype, card, sex));
			}
		} finally {
			db.close();
		}
		return v.elements();
	}

	// @author黄愉
	public static void update(String member, String community, String password, int sex, String card, int cardtype, String firstname, String telephone, String email, int language) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("UPDATE Profile SET member=" + DbAdapter.cite(member) + ",password=" + DbAdapter.cite(password) + ",sex=" + sex + ",community=" + DbAdapter.cite(community) + ",card="
					+ DbAdapter.cite(card) + ",cardtype=" + cardtype + ",email=" + DbAdapter.cite(email) + "WHERE member=" + DbAdapter.cite(member));
			db.executeUpdate("UPDATE ProfileLayer SET member=" + DbAdapter.cite(member) + ",language=" + language + ",firstname=" + DbAdapter.cite(firstname) + ",telephone="
					+ DbAdapter.cite(telephone) + "WHERE member=" + DbAdapter.cite(member) + "and language=" + language);
		} finally {
			db.close();
		}
	}

	public boolean isLayerExisted(int i) throws SQLException {
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try {
			db.getInt("SELECT member  FROM ProfileLayer  WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community) + " AND language=" + i);
			flag = db.next();
		} finally {
			db.close();
		}
		return flag;
	}

	public String getPassword() throws SQLException {
		load();
		return password;
	}

	public String getCreditcard() throws SQLException {
		load();
		if (creditcard.length() == 16) {
			return creditcard.substring(0, 4) + " " + creditcard.substring(4, 8) + " " + creditcard.substring(8, 12) + " " + creditcard.substring(12);
		}
		return creditcard;
	}

	public String getMobile() throws SQLException {
		load();
		return mobile;
	}

	public void setMobile(String mobile) throws SQLException {
		set("mobile", mobile);
		this.mobile = mobile;
	}

	public String getPassword(String mobile) throws SQLException {
		String password = "";
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT password FROM Profile WHERE mobile like " + DbAdapter.cite(mobile));
			if (db.next()) {
				password = db.getString(1);
			}
		} finally {
			db.close();
		}
		return password;
	}

	public String getMember() throws SQLException {
		load();
		return member;
	}

	public String getTelephone(int i) throws SQLException {
		return getLayer(i)._strTelephone;
	}

	public String getClub(int i) throws SQLException {
		return getLayer(i).club;
	}

	public String getBanspeakreason(int i) throws SQLException {
		return getLayer(i).banspeakreason;
	}

	public String getNewreason(int i) throws SQLException {
		return getLayer(i).newreason;
	}

	public String getContributorsreason(int i) throws SQLException {
		return getLayer(i).contributorsreason;
	}

	public String getPTelephone(int i) throws SQLException {
		return getLayer(i).ptelephone;
	}

	public void setTelephone(String _strTelephone, int language) throws SQLException {
		setLayer("telephone", _strTelephone, language);
	}

	public static int getMax() throws SQLException {
		int i = 0;
		DbAdapter db = new DbAdapter();
		try {
			i = db.getInt("SELECT MAX(profile) FROM Profile ");
		} finally {
			db.close();
		}
		return i;
	}

	public Text getAnchor() throws SQLException {
		String en = null;
		try {
			en = java.net.URLEncoder.encode(member, "UTF-8");
		} catch (UnsupportedEncodingException ex) {
			en = member;
		}
		Anchor anchor = new Anchor("/jsp/access/Glance.jsp?Member=" + en, member);
		Text text = new Text();
		if (OnlineList.find(member).isOnline()) {
			anchor.setId("MemberOnline");
			text.add(anchor);
			text.add(new Anchor("/servlet/Call?Receiver=" + en, new Image("/tea/image/Call.gif"), "_blank"));
		} else {
			anchor.setId("MemberOffline");
			text.add(anchor);
		}
		return text;
	}

	// 登陆！
	public static boolean isPassword(String member, String password) throws SQLException {
		boolean flag = false;
		String md5p = password;

		if (Profile.isExisted(member)) {
			Profile pobj = Profile.find(member);
			if (pobj.getPassword().length() == 32) // 说明是md5加密
			{
				md5p = SMS.md5(password);
			}
		}
		if (OpenID.isOpen()) {
			flag = OpenID.find(member).isExists(password);
		} else {
			DbAdapter db = new DbAdapter();
			try {
				db.executeQuery("SELECT member FROM Profile WHERE member=" + DbAdapter.cite(member) + " AND password=" + DbAdapter.cite(md5p));
				flag = db.next();
			} finally {
				db.close();
			}
		}
		return flag;
	}

	// 登陆！
	public static boolean isPassworddpx(String member, String password, int utype) throws SQLException {
		boolean flag = false;
		String md5p = password;

		if (Profile.isExisted(member)) {
			Profile pobj = Profile.find(member);
			if (pobj.getPassword().length() == 32) // 说明是md5加密
			{
				md5p = SMS.md5(password);
			}
		}
		if (OpenID.isOpen()) {
			flag = OpenID.find(member).isExists(password);
		} else {
			DbAdapter db = new DbAdapter();
			try {
				db.executeQuery("SELECT member FROM Profile WHERE member=" + DbAdapter.cite(member) + " AND password=" + DbAdapter.cite(md5p) + " AND type = " + utype);
				flag = db.next();
			} finally {
				db.close();
			}
		}
		return flag;
	}

	// 判断有没有这个会员编号
	public static boolean isCode(String code, String password) throws SQLException {
		boolean b = false;
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery(" select code from Profile where code = " + DbAdapter.cite(code) + " and password = " + DbAdapter.cite(password));
			if (db.next()) {
				b = true;
			}
		} finally {
			db.close();
		}
		return b;
	}

	public static boolean isCode(String code) throws SQLException {
		boolean b = false;
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery(" select code from Profile where code = " + DbAdapter.cite(code));
			if (db.next()) {
				b = true;
			}
		} finally {
			db.close();
		}
		return b;
	}

	// /唐嗣达 md5 email
	public static boolean isPasswordMd5(String member, String email) throws SQLException {
		boolean flag = false;
		member = member.toLowerCase();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT member FROM Profile WHERE member=" + DbAdapter.cite(member) + " AND email=" + DbAdapter.cite(email));
			flag = db.next();
		} finally {
			db.close();
		}
		return flag;
	}

	// 2008-10-27 添加
	public void set_anquan(String email, String mobile, String question, String answer) throws SQLException {

		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("UPDATE Profile SET email =" + db.cite(email) + ",mobile =" + db.cite(mobile) + ",question =" + db.cite(question) + ",answer =" + db.cite(answer) + " WHERE member="
					+ DbAdapter.cite(member));

		} finally {
			db.close();
		}
		this.email = email;
		this.mobile = mobile;
		this.question = question;
		this.answer = answer;
	}

	public static boolean ispasswordMD5(String member, String password) throws SQLException {
		return true;

	}

	public static String numtoid(String s) throws SQLException {
		String info = "";
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT member FROM Profile WHERE mobile=" + DbAdapter.cite(s));
			if (db.next()) {
				info = db.getString(1);
			}
		} finally {
			db.close();
		}
		return info;
	}

	public static String findByEmail(String email, String community) throws SQLException {
		// System.out.println("SELECT member FROM Profile WHERE email=" +
		// DbAdapter.cite(email) + " AND community=" +
		// DbAdapter.cite(community));
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT member FROM Profile WHERE email=" + DbAdapter.cite(email) + " AND community=" + DbAdapter.cite(community));
			if (db.next()) {
				return db.getString(1);
			}
		} finally {
			db.close();
		}
		return null;
	}

	public void setStartUrl(String strarturl, int language) throws SQLException {
		setLayer("starturl", strarturl, language);
	}

	public static String idtonum(String member, String community) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery(" SELECT mobile  FROM Profile  WHERE  member =" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
			if (db.next()) {
				return db.getString(1);
			}
		} catch (Exception ex) {
			System.out.println(ex.toString());
		} finally {
			db.close();
		}
		return "";
	}

	public static boolean isSMSPassword(String s, String s1) throws SQLException {
		boolean flag = false;
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery(" SELECT member FROM Profile  WHERE mobile=" + DbAdapter.cite(s) + "AND password=" + DbAdapter.cite(s1));
			flag = db.next();
		} finally {
			db.close();
		}
		return flag;
	}

	public String getFax(int i) throws SQLException {
		return getLayer(i)._strFax;
	}

	public static int countByCommunity(String community) throws SQLException {
		return countByCommunity(community, "");
	}

	public static int countByCommunity(String community, String sql) throws SQLException {
		return count(" AND community=" + DbAdapter.cite(community) + sql);
	}

	public static int count(String sql) throws SQLException {
		int i = 0;
		DbAdapter db = new DbAdapter();
		try {
			// System.out.println("SELECT COUNT(*) FROM Profile p" + tab(sql) +
			// " WHERE 1=1" + sql);
			i = db.getInt("SELECT COUNT(*) FROM Profile p" + tab(sql) + " WHERE 1=1" + sql);
		} finally {
			db.close();
		}
		return i;
	}

	public static int count(String community, String sql) throws SQLException {
		int i = 0;
		DbAdapter db = new DbAdapter();
		try {
			i = db.getInt("SELECT COUNT(*) FROM Profile WHERE community=" + db.cite(community) + sql);
		} finally {
			db.close();
		}
		return i;
	}

	public static Profile find(String member) throws SQLException {
		int profile = 0;
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT profile FROM Profile WHERE member=" + DbAdapter.cite(member));
			profile = db.next() ? db.getInt(1) : 0;
		} finally {
			db.close();
		}
		Profile t = Profile.find(profile);
		t.member = member;
		return t;
	}

	public static Profile findbyhospital0(String member, String hname) throws SQLException {
		int profile = 0;
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT profile FROM Profile WHERE member=" + DbAdapter.cite(member) + " and hospital=(select id from shophospital where name like " + Database.cite("%" + hname + "%")
					+ ")");
			profile = db.next() ? db.getInt(1) : 0;
		} finally {
			db.close();
		}
		Profile t = Profile.find(profile);
		t.member = member;
		return t;
	}

	// 8.7改hospital类型为String
	public static Profile findbyhospital(String member, String hname) throws SQLException {
		int profile = 0;
		DbAdapter db = new DbAdapter();
		try {
			// db.executeQuery("SELECT profile FROM Profile WHERE member=" +
			// DbAdapter.cite(member)+" and hospital like "+DbAdapter.cite("%"+tab2(hname)+"%"));
			db.executeQuery("SELECT profile FROM Profile WHERE member=" + DbAdapter.cite(member) + " and hospital = " + tab2(hname));
			Filex.logs("yt_nologin.txt", String.valueOf(tab2(hname)));
			profile = db.next() ? db.getInt(1) : 0;
		} finally {
			db.close();
		}
		Profile t = Profile.find(profile);
		t.member = member;
		return t;
	}

	public static Profile find(int profile) throws SQLException {
		Profile t = (Profile) _cache.get(profile);
		if (t == null) {
			ArrayList al = find1(" AND profile=" + profile, 0, 1);
			t = al.size() < 1 ? new Profile(profile) : (Profile) al.get(0);
			t.password = MT.f(t.password);
			t.code = MT.f(t.code);
			t.mobile = MT.f(t.mobile);
			t.email = MT.f(t.email);
			t.card = MT.f(t.card);
			t.zzpridn = MT.f(t.zzpridn);
			t.zzfmbkg = MT.f(t.zzfmbkg);
			t.referer = MT.f(t.referer);
			t.question = MT.f(t.question);
			t.answer = MT.f(t.answer);
			t.creditcard = MT.f(t.creditcard);
			t.pinyin = MT.f(t.pinyin);
			t.bbspermissions = MT.f(t.bbspermissions);
			t.openid = MT.f(t.openid);
			t.address = MT.f(t.address);
		}
		return t;
	}

	public static int count(Date date, Date date1) throws SQLException {
		int i = 0;
		DbAdapter db = new DbAdapter();
		try {
			i = db.getInt("SELECT COUNT(member)  FROM Profile  WHERE time>=" + DbAdapter.cite(date) + " AND time<=" + DbAdapter.cite(date1));
		} finally {
			db.close();
		}
		return i;
	}

	public static Enumeration findByDate(Date date, Date date1) throws SQLException {
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT member FROM Profile WHERE time>=" + DbAdapter.cite(date) + " AND time<=" + DbAdapter.cite(date1));
			while (db.next()) {
				v.addElement(db.getString(1));
			}
		} finally {
			db.close();
		}
		return v.elements();
	}

	public static int count(Date from, Date to, String member, String name) throws SQLException {
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		StringBuilder sb = new StringBuilder("SELECT COUNT(DISTINCT Profile.member) FROM Profile,ProfileLayer WHERE Profile.member=ProfileLayer.member");
		if (from != null) {
			sb.append(" AND Profile.time>=" + DbAdapter.cite(from));
		}
		if (to != null) {
			sb.append(" AND Profile.time<=" + DbAdapter.cite(to));
		}
		if (member != null) {
			sb.append(" AND Profile.member like " + DbAdapter.cite("%" + member + "%"));
		}
		if (name != null) {
			sb.append(" AND firstname like " + DbAdapter.cite("%" + name + "%"));
		}
		try {
			return db.getInt(sb.toString());
		} finally {
			db.close();
		}
	}

	public static Enumeration find(Date from, Date to, String member, String name, int pos, int pageSize) throws SQLException {
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		StringBuilder sb = new StringBuilder("SELECT Profile.member FROM Profile,ProfileLayer WHERE Profile.member=ProfileLayer.member");
		if (from != null) {
			sb.append(" AND Profile.time>=" + DbAdapter.cite(from));
		}
		if (to != null) {
			sb.append(" AND Profile.time<=" + DbAdapter.cite(to));
		}
		if (member != null) {
			sb.append(" AND Profile.member like " + DbAdapter.cite("%" + member + "%"));
		}
		if (name != null) {
			sb.append(" AND firstname like " + DbAdapter.cite("%" + name + "%"));
		}
		try {
			db.executeQuery(sb.toString());
			for (int index = 0; index < (pos * pageSize) && db.next(); index++) {
				if (index >= (pos - 1) * pageSize) {
					v.addElement(db.getString(1));
				}
			}
		} finally {
			db.close();
		}
		return v.elements();
	}

	public static Enumeration findByUnit(int adminUnit) throws SQLException {
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try {
			String sql;
			if (adminUnit == 0) {
				sql = "SELECT member FROM Profile WHERE adminunit=" + adminUnit + " OR adminunit NOT IN (SELECT id FROM AdminUnit)";
			} else {
				sql = "SELECT member FROM Profile WHERE adminunit=" + adminUnit;
			}
			db.executeQuery(sql);
			while (db.next()) {
				v.addElement(db.getString(1));
			}
		} finally {
			db.close();
		}
		return v.elements();
	}

	public static Enumeration findByCommunity(String community, String sql, int pos, int size) throws SQLException {
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT member FROM Profile WHERE community=" + DbAdapter.cite(community) + sql, pos, size);
			while (db.next()) {
				v.addElement(db.getString(1));
			}
		} finally {
			db.close();
		}
		return v.elements();
	}

	public static Enumeration find(String sql, int pos, int size) throws SQLException {
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT member FROM Profile p WHERE 1=1 " + sql, pos, size);
			while (db.next()) {
				v.addElement(db.getString(1));
			}
		} finally {
			db.close();
		}
		return v.elements();
	}

	static int tab2(String hname) {
		int sid = 0;

		DbAdapter db = new DbAdapter();

		try {
			// db.executeQuery("select id from shophospital where name like "+Database.cite("%"+hname+"%"));
			db.executeQuery("select id from shophospital where name = " + Database.cite(hname));
			Filex.logs("yt_nologin.txt", hname);
			sid = db.next() ? db.getInt(1) : 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return sid;
	}

	static String tab(String sql) {
		StringBuilder sb = new StringBuilder();
		if (sql.contains(" AND pl."))
			sb.append(" INNER JOIN ProfileLayer pl ON pl.profile=p.profile");
		if (sql.contains(" AND aur.") || sql.contains(" OR aur."))
			sb.append(" LEFT JOIN AdminUsrRole aur ON aur.member=p.profile");
		if (sql.contains(" AND ds."))
			sb.append(" INNER JOIN deptseq ds ON ds.member=p.profile");
		if (sql.contains(" AND sc.") || sql.contains(" BY sc."))
			sb.append(" LEFT JOIN SubContractor sc ON sc.subcontractor=p.profile");
		// 中国职业教育网
		if (sql.contains(" AND lmse."))
			sb.append(" INNER JOIN lmsexam lmse ON lmse.member=p.profile");
		return sb.toString();
	}

	// 会员编号
	public static Enumeration findCode(String sql, int pos, int size) throws SQLException {
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT code FROM Profile p WHERE 1=1 " + sql, pos, size);
			while (db.next()) {
				v.addElement(db.getString(1));
			}
		} finally {
			db.close();
		}
		return v.elements();
	}

	public static Enumeration find(String community, String sql, int pos, int size) throws SQLException {
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT member FROM Profile  WHERE community=" + DbAdapter.cite(community) + sql, pos, size);
			while (db.next()) {
				v.addElement(new RV(db.getString(1)));
			}
		} finally {
			db.close();
		}
		return v.elements();
	}

	public static Enumeration findByCommunity(String community) throws SQLException {
		return findByCommunity(community, "", 0, Integer.MAX_VALUE);
	}

	public void delete(int i) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			// db.executeUpdate("DELETE FROM ProfileLayer WHERE member=" +
			// DbAdapter.cite(member) + " AND language=" + i);
			// db.executeUpdate("DELETE FROM Profile WHERE member=" +
			// DbAdapter.cite(member) + " AND community=" +
			// DbAdapter.cite(community));
			db.executeUpdate("UPDATE Profile SET locking=1  WHERE member=  " + db.cite(member));

		} finally {
			db.close();
		}
		_htLayer.clear();
		_cache.remove(profile);
	}

	public void delete() throws SQLException {
		String tmp = member + "[于" + MT.f(new Date(), 1) + "删除]";
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(profile, "UPDATE Profile      SET deleted=1,member=" + DbAdapter.cite(tmp) + " WHERE profile=" + profile);
			db.executeUpdate(profile, "UPDATE ProfileLayer SET member=" + DbAdapter.cite(tmp) + " WHERE member=" + DbAdapter.cite(member));
			db.executeUpdate(profile, "DELETE FROM Message WHERE tmember=" + DbAdapter.cite("/" + member + "/"));
		} finally {
			db.close();
		}
		_cache.remove(profile);
	}

	public static void delete(String member) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			// db.executeUpdate("DELETE FROM ProfileLayer WHERE member=" +
			// DbAdapter.cite(member));
			// db.executeUpdate("DELETE FROM Profile WHERE member=" +
			// DbAdapter.cite(member));
			// db.executeUpdate("DELETE FROM AdminUsrRole WHERE member=" +
			// DbAdapter.cite(member));
			db.executeUpdate("UPDATE Profile SET locking=1  WHERE member=  " + db.cite(member));
		} finally {
			db.close();
		}
		_cache.clear();
	}

	public void delete(String community, int i) throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			// db.executeUpdate("DELETE FROM ProfileLayer WHERE member=" +
			// DbAdapter.cite(member) + " AND language=" + i);
			// db.executeUpdate("DELETE FROM Profile WHERE member=" +
			// DbAdapter.cite(member) + " AND community=" +
			// DbAdapter.cite(community));
			db.executeUpdate("UPDATE Profile SET locking=1  WHERE member=  " + db.cite(member));

		} finally {
			db.close();
		}
		_htLayer.clear();
		_cache.remove(member + ":" + community);
	}

	// 彻底删除

	public void deleteall() throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("DELETE FROM ProfileLayer WHERE member=" + DbAdapter.cite(member));
			db.executeUpdate("DELETE FROM Profile WHERE member=" + DbAdapter.cite(member));
			db.executeUpdate("DELETE FROM ProfileBBS WHERE member=" + DbAdapter.cite(member));
			db.executeUpdate("DELETE FROM ProfileBBSLayer WHERE member=" + DbAdapter.cite(member));
			db.executeUpdate("DELETE FROM ProfileGolf WHERE member=" + DbAdapter.cite(member));
			db.executeUpdate("DELETE FROM ProfileGrant WHERE member=" + DbAdapter.cite(member));
			db.executeUpdate("DELETE FROM ProfileJob WHERE member=" + DbAdapter.cite(member));

			WestracIntegralLog.delete(member); // 日志表
			db.executeUpdate("DELETE FROM Logs WHERE rmember=" + DbAdapter.cite(member) + " AND vmember=" + DbAdapter.cite(member));

			// 删除新闻表
			db.executeUpdate("DELETE from ReportLayer WHERE node IN ( select node from Node where rcreator=" + db.cite(member) + " or vcreator = " + db.cite(member) + ")");
			db.executeUpdate("DELETE from Report WHERE node IN ( select node from Node where rcreator=" + db.cite(member) + " or vcreator = " + db.cite(member) + ")");

			// 删除权限表
			db.executeUpdate("DELETE from AdminUsrRole WHERE member=" + db.cite(member));
			// 删除论坛表
			db.executeUpdate("DELETE from BBS WHERE node IN ( select node from Node where rcreator=" + db.cite(member) + " or vcreator = " + db.cite(member) + ")");

			db.executeUpdate("DELETE from BBSReplyLayer WHERE bbsreply IN ( select id from BBSReply where member=" + db.cite(member) + ")");
			db.executeUpdate("DELETE from BBSReply WHERE member= " + db.cite(member));

			// 删除商品表
			db.executeUpdate("DELETE from Goods WHERE node IN ( select node from Node where rcreator=" + db.cite(member) + " or vcreator = " + db.cite(member) + ")");
			// 简历表
			db.executeUpdate("DELETE from Job WHERE node IN ( select node from Node where rcreator=" + db.cite(member) + " or vcreator = " + db.cite(member) + ")");

			// 考勤表
			db.executeUpdate("DELETE from Manage WHERE member = " + db.cite(member));
			db.executeUpdate("DELETE from Outs WHERE member = " + db.cite(member));
			db.executeUpdate("DELETE from Leavec WHERE member = " + db.cite(member));

			// 信箱
			db.executeUpdate("DELETE from Message WHERE fmember = " + db.cite(member));
			db.executeUpdate("DELETE from MessageTo WHERE rmember = " + db.cite(member) + " OR vmember=" + db.cite(member));

			// 加盟店相关
			db.executeUpdate("DELETE from Orders WHERE member = " + db.cite(member));

			// 活动
			db.executeUpdate("DELETE from Event WHERE node IN ( select node from Node where rcreator=" + db.cite(member) + " or vcreator = " + db.cite(member) + ")");

			// 文件
			db.executeUpdate("DELETE from Files WHERE node IN ( select node from Node where rcreator=" + db.cite(member) + " or vcreator = " + db.cite(member) + ")");
			// 球场
			db.executeUpdate("DELETE from Golf WHERE node IN ( select node from Node where rcreator=" + db.cite(member) + " or vcreator = " + db.cite(member) + ")");

			// node表
			db.executeUpdate("DELETE from NodeLayer WHERE node IN ( select node from Node where rcreator=" + db.cite(member) + " or vcreator = " + db.cite(member) + ")");
			db.executeUpdate("DELETE from Node WHERE rcreator=" + db.cite(member) + " OR vcreator = " + db.cite(member));

		} finally {
			db.close();
		}
		_htLayer.clear();
		_cache.remove(member + ":" + community);
	}

	/**/
	public static String findByCard(String card) throws SQLException {

		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT member FROM Profile WHERE card=" + DbAdapter.cite(card));
			// System.out.println("SELECT member FROM Profile WHERE card='"+card+"'");
			if (db.next()) {
				return db.getString(1);
			}
		} catch (Exception exception1) {
			System.out.println(exception1.toString());
		} finally {
			db.close();
		}
		return null;
	}

	public static Enumeration findByCommunityLayer(String sql, int pos, int size) throws SQLException {
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT member FROM ProfileLayer " + sql);
			while (db.next()) {
				v.addElement(db.getString(1));
			}
		} finally {
			db.close();
		}
		return v.elements();
	}

	// @author huangyu ;
	public static Enumeration findmember(String firstname) throws SQLException {
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("SELECT member FROM ProfileLayer WHERE firstname=" + DbAdapter.cite(firstname));
			if (db.next()) {
				String member1 = db.getString(1);
				v.addElement(member1);
			}
		} finally {
			db.close();
		}
		return v.elements();
	}

	/* 10月11* */
	public String getName(int i) throws SQLException {
		return getLastName(i) + getFirstName(i);
	}

	public String getOrganization(int i) throws SQLException {
		return getLayer(i)._strOrganization;
	}

	public void setOrganization(String organization, int language) throws SQLException {
		setLayer("organization", organization, language);
	}

	// 科室 部门
	public void setSection(String section, int language) throws SQLException {
		setLayer("section", section, language);
	}

	public void setWebPage(String webpage, int language) throws SQLException {
		setLayer("webpage", webpage, language);
	}

	public int getProfile() {
		return profile;
	}

	public void setSex(boolean sex) throws SQLException {
		set("sex", Boolean.valueOf(sex));
		this.sex = sex;
	}

	public boolean isSex() throws SQLException {
		load();
		return this.sex;
	}

	public void setPolity(int polity) throws SQLException {
		set("polity", String.valueOf(polity));
		this.polity = polity;
	}

	/*
	 * public void setCommunity(String community) throws SQLException {
	 * DbAdapter db = new DbAdapter(); try {
	 * db.executeUpdate("UPDATE Profile SET community=" +
	 * DbAdapter.cite(community) + " WHERE member=" + DbAdapter.cite(member)); }
	 * finally { db.close(); } this.community = community; }
	 */
	public void setCard(String card) throws SQLException {
		set("card", card);
		this.card = card;
	}

	public void setCardType(int cardtype) throws SQLException {
		set("cardtype", String.valueOf(cardtype));
		this.cardtype = cardtype;
	}

	public void setJobMailMsg(boolean jobMailMsg) throws SQLException {
		set("jobmailmsg", Boolean.valueOf(jobMailMsg));
		this.jobMailMsg = jobMailMsg;
	}

	public void setValidate(boolean valid) throws SQLException {

		int i = 0;
		if (valid) {
			i = 1;
		} else {
			i = 0;
		}

		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate("UPDATE Profile SET valid=" + i + " WHERE member=" + db.cite(member));
			// System.out.println("UPDATE Profile SET valid=" + i +
			// " WHERE member=" + db.cite(member));
		} catch (Exception e) {

		} finally {
			db.close();
		}
		this.valid = valid;
		_cache.clear();
	}

	public void setPassword(String password) throws SQLException {
		if (OpenID.isOpen()) {
			OpenID.find(member).setPassword(password);
		}
		set("password", password);
		this.password = password;
	}

	public void setRclass(int rclass) throws SQLException // 添加考勤排班类型
	{
		set("rclass", String.valueOf(rclass));
		this.rclass = rclass;
	}

	public void setWagetype(int wagetype) throws SQLException // 添加 工资标准
	{
		set("wagetype", String.valueOf(wagetype));
		this.wagetype = wagetype;
	}

	// 积分变更
	public void setIntegral(float integral) throws SQLException {
		if (integral >= 0) {
			set("integral", String.valueOf(integral));
			this.integral = integral;
			// 更改等级
			int bid = 0;
			Enumeration e = BBSLevel.find(" AND point<=" + integral + " ORDER BY point DESC", 0, 1);
			if (e.hasMoreElements()) {
				BBSLevel bl = (BBSLevel) e.nextElement();
				bid = bl.getBbslevel();
			}
			set("bbslevel", String.valueOf(bid));

			// 如果是俱乐部会员，在去判断积分
			if (this.membertype == 1) {

				if (this.integral >= 2000 && this.integral < 5000) {
					int c1 = WestracIntegralLog.Count(this.community, " and member=" + DbAdapter.cite(this.member) + " and wlogtype=14 and integral=10 ");
					if (c1 == 0) {

						// set("myintegral",String.valueOf());
						setMyintegral((this.myintegral + 10));
						WestracIntegralLog.create(this.member, 14, null, 0, 10, null, new Date(), 0, this.community);
						// 发送短信

						String ctext = "您的论坛工分已经达到" + this.integral + "，特为您增加10履友积分，希望您更多地参与联盟活动中来！";
						SMSMessage.create(this.community, this.member, this.mobile, 1, ctext);

					}

				} else if (integral >= 5000 && integral < 10000) {
					int c2 = WestracIntegralLog.Count(this.community, " and member=" + DbAdapter.cite(this.member) + " and wlogtype=14 and integral=30 ");
					if (c2 == 0) {
						// set("myintegral",String.valueOf(this.myintegral +
						// 30));
						setMyintegral((this.myintegral + 30));
						WestracIntegralLog.create(this.member, 14, null, 0, 30, null, new Date(), 0, this.community);
						// 发送短信

						String ctext = "您的论坛工分已经达到" + this.integral + "，特为您增加30履友积分，希望您更多地参与联盟活动中来！";
						SMSMessage.create(this.community, this.member, this.mobile, 1, ctext);
					}
				} else if (this.integral >= 10000) {
					int c3 = WestracIntegralLog.Count(this.community, " and member=" + DbAdapter.cite(this.member) + " and wlogtype=14 and integral=50 ");
					// System.out.println("---" + c3);
					if (c3 == 0) {
						// set("myintegral",String.valueOf(this.myintegral +
						// 50));
						setMyintegral((this.myintegral + 50));
						WestracIntegralLog.create(this.member, 14, null, 0, 50, null, new Date(), 0, this.community);
						// 发送短信
						String ctext = "您的论坛工分已经达到" + this.integral + "，特为您增加50履友积分，希望您更多地参与联盟活动中来！";
						SMSMessage.create(this.community, this.member, this.mobile, 1, ctext);
					}
				}
			}

		}
		//
		// Date date_times = new Date();
		// IntegralCycle.create(member, integral, date_times);
	}

	public void setIntegral(float integral, int profile) throws SQLException {
		if (integral >= 0) {
			DbAdapter db = new DbAdapter();
			try {
				db.executeUpdate("UPDATE Profile SET integral=" + integral + " WHERE profile=" + profile);
			} finally {
				db.close();
			}
			this.integral = integral;
		}

	}

	public void setIntegral2(float integral) throws SQLException {
		if (myintegral >= 0) {
			DbAdapter db = new DbAdapter();
			try {
				db.executeUpdate("UPDATE Profile SET myintegral =" + myintegral + " WHERE member= " + db.cite(this.member));
			} finally {
				db.close();
			}
			this.myintegral = myintegral;
		}
	}

	// 投稿积分修改
	public void setContributeintegral(float contributeintegral) throws SQLException {
		if (contributeintegral >= 0) {
			DbAdapter db = new DbAdapter();
			try {
				db.executeUpdate("UPDATE Profile SET contributeintegral =" + contributeintegral + " WHERE member= " + db.cite(this.member));
			} finally {
				db.close();
			}
			this.contributeintegral = contributeintegral;
		}
	}

	// 修改俱乐部会员 积分
	public void setMyintegral(float myintegral) throws SQLException {
		if (myintegral >= 0) {
			DbAdapter db = new DbAdapter();
			try {
				db.executeUpdate("UPDATE Profile SET myintegral =" + myintegral + " WHERE member= " + db.cite(this.member));
			} finally {
				db.close();
			}
			this.myintegral = myintegral;
		}
	}

	// 定时更新履友生日 早晨 8点触发
	public static void sync() {

		try {
			/*License license = License.getInstance();
			if (license.getListenertype() != null && license.getListenertype().indexOf("/1/") != -1) {
			} else {
				return;
			}

			Timer timer = new Timer();
			timer.schedule(new TimerTask() {
				String last = null;

				public void run() {
					try {
						System.out.println("==启动扫描会员生日程序==时间：" + new Date().getHours());
						if (new Date().getHours() == 8) // 每天早晨8点更新
						{
							//

							Profile.SMSBirthday();
						}

					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}

				// },0,2* 60 * 1000);//2分钟扫描一次
			}, 0, 1 * 60 * 60 * 1000); // 1个小时扫描一次*/
		} catch (Exception ex) {
			ex.printStackTrace();
		}

	}

	// 定时计算所以用户的 成绩鉴定更新
	public static void SMSBirthday() throws SQLException {
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("select member from Profile where  membertype=1  ");
			while (db.next()) {
				String member = db.getString(1);
				Profile p = Profile.find(member);
				int c = WestracIntegralLog.Count(p.getCommunity(), " and member=" + DbAdapter.cite(member) + " and wlogtype=15 and integral=10 ");

				if (c == 0) {
					String b = p.getBirthToString();
					String d = Entity.sdf.format(new Date());
					if (b != null) {
						if (b.substring(5, b.length()).equals(d.substring(5, d.length()))) {
							System.out.println("生日发送会员:" + member);
							p.setMyintegral(p.getMyintegral() + 10);
							WestracIntegralLog.create(member, 15, null, 0, 10, "今天是您的生日，祝您生日快乐！同时为您增加10积分，感谢您对我们的支持！", new Date(), 0, p.getCommunity());
							// 发送短信加分
							String ctext = "尊敬的履友" + member + "，今天是您的生日，祝您生日快乐！同时为您增加10积分，感谢您对我们的支持！";
							SMSMessage.create(p.getCommunity(), member, p.getMobile(), 1, ctext);

						}
					}
				}

			}
		} finally {
			db.close();
		}
	}

	public void addIntegral(float integral, int profile) throws SQLException {
		if (integral >= 0) {
			DbAdapter db = new DbAdapter();
			try {
				db.executeUpdate("UPDATE Profile SET integral=integral+" + integral + " WHERE profile=" + profile);
			} finally {
				db.close();
			}

			set("integral", String.valueOf(this.integral + integral));
			this.integral = this.integral + integral;
		}
	}

	public void setIntegralnew(float integral, int type) throws SQLException {
		if (integral >= 0) {
			set("integral", String.valueOf(integral));
			this.integral = integral;
		}

		Date date_times = new Date();
		// IntegralCycle.create(member,integral,date_times,type,community);
	}

	public void setAgio(int agio) throws SQLException {
		set("agio", String.valueOf(agio));
		this.agio = agio;
	}

	public void setPinyin(String pinyin) throws SQLException {
		set("pinyin", pinyin);
		this.pinyin = pinyin;
	}

	public void setCreditcard(String creditcard) throws SQLException {
		set("creditcard", creditcard);
		this.creditcard = creditcard;
	}

	public void setCity(String city, int language) throws SQLException {
		setLayer("city", city, language);
	}

	public void setGblnd(String gblnd, int language) throws SQLException {
		setLayer("gblnd", gblnd, language);
	}

	public void setGbort(String gbort, int language) throws SQLException {
		setLayer("gbort", gbort, language);
	}

	public void setIntroduce(String introduce, int language) throws SQLException {
		setLayer("introduce", introduce, language);
	}

	// 职称
	public void setTitle(String title, int language) throws SQLException {
		setLayer("title", title, language);
	}

	public void setZzhkszd(String zzhkszd, int language) throws SQLException {
		setLayer("zzhkszd", zzhkszd, language);
	}

	public void setProvince(int province, int language) throws SQLException {
		setLayer("province", String.valueOf(province), language);
	}

	public void setBirth(Date birth) throws SQLException {
		set("birth", birth);
		this.birth = birth;
	}

	public void setJob(String _strJob, int language) throws SQLException {
		setLayer("job", _strJob, language);
	}

	public void setCountry(String country, int language) throws SQLException {
		setLayer("country", country, language);
	}

	public void setTime(Date time) throws SQLException {
		set("time", time);
		this.time = time;
	}

	public void setReferer(String referer) throws SQLException {
		set("referer", referer);
		this.referer = referer;
	}

	public void setAgent(int agent) throws SQLException {
		set("agent", String.valueOf(agent));
		this.agent = agent;
	}

	public void setType(int type) throws SQLException {
		set("type", String.valueOf(type));
		this.type = type;
	}

	public int getPolity() throws SQLException {
		load();
		return polity;
	}

	public Date getTime() throws SQLException {
		load();
		return time;
	}

	public int getBbslevel() throws SQLException {
		load();
		if (bbslevel == 0) {
			BBSLevel.refresh();
		}
		return bbslevel;
	}

	public boolean isLocking() throws SQLException {
		load();
		return locking;
	}

	public int getIsInvoive() throws SQLException {
		load();
		return isInvoive;
	}

	public int getNobanspeak() throws SQLException {
		load();
		return nobanspeak;
	}

	public int getNocontributors() throws SQLException {
		load();
		return nocontributors;
	}

	public int getIndustry() throws SQLException {
		load();
		return industry;
	}

	public String getWoid() throws SQLException {
		load();
		return woid;
	}

	public int getJob() throws SQLException {
		return job;
	}

	public int getIdentitys() throws SQLException {
		load();
		return identitys;
	}

	public String getTimeToString() throws SQLException {
		load();
		if (time == null) {
			return "";
		}

		return Profile.sdf.format(time);
	}

	public String getCommunity() throws SQLException {
		load();
		return community;
	}

	public String getCode() throws SQLException {
		load();
		return code;
	}

	public String getCard() throws SQLException {
		load();
		return card;
	}

	public int getCardType() throws SQLException {
		load();
		return cardtype;
	}

	public boolean isJobMailMsg() {
		return jobMailMsg;
	}

	public boolean isValidate() throws SQLException {
		// load();
		return valid;
	}

	public String getZzpridn() throws SQLException {
		load();
		return zzpridn;
	}

	public boolean isZznyhk() throws SQLException {
		load();
		return zznyhk;
	}

	public boolean isZzgatwj() throws SQLException {
		load();
		return zzgatwj;
	}

	public String getZzfmbkg() throws SQLException {
		load();
		return zzfmbkg;
	}

	public int getFamst() throws SQLException {
		load();
		return famst;
	}

	public Date getFamdt() throws SQLException {
		load();
		return famdt;
	}

	public int getAnzkd() throws SQLException {
		load();
		return anzkd;
	}

	// SAP-民族分组
	public String getZzracky() throws SQLException {
		load();
		return zzracky;
	}

	public String getReferer() throws SQLException {
		load();
		return referer;
	}

	public String getETimeToString() throws SQLException {
		load();
		if (etime == null) {
			return "";
		}
		return etime;
	}

	public String getPhotopath2(int language) throws SQLException {
		return getLayer(language).photopath2;
	}

	public String getTitle(int i) throws SQLException {
		return getLayer(i)._strTitle;
	}

	// 科室
	public String getSection(int i) throws SQLException {
		return getLayer(i).section;
	}

	public String getFunctions(int i) throws SQLException {
		return getLayer(i).functions;
	}

	public int getAgent() throws SQLException {
		load();
		return agent;
	}

	public String getMsn() throws SQLException {
		load();
		return qq;
	}

	public String getMsnID() throws SQLException {
		load();
		return msnid;
	}

	public int getPoint() throws SQLException {
		load();
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getVerify() throws SQLException {
		return Long.toString((this.getTime().getTime() - 946656000000L) * this.getProfile(), 36);
	}

	public String getJemail() throws SQLException {
		load();
		return this.jemail;
	}

	public void setJemail(String jemail) {
		this.jemail = jemail;
	}

	public String getJmobbile() throws SQLException {
		load();
		return this.jmobbile;
	}

	public void setJmobbile(String jmobbile) {
		this.jmobbile = jmobbile;
	}

	public String getJaddress() throws SQLException {
		load();
		return this.jaddress;
	}

	public void setJaddress(String jaddress) {
		this.jaddress = jaddress;
	}

	public int getJcity() throws SQLException {
		load();
		return this.jcity;
	}

	public void setJcity(int jcity) {
		this.jcity = jcity;
	}

	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{id:" + profile);
		sb.append(",username:" + Attch.cite(member));
		sb.append("}");
		return sb.toString();
	}

	/*
	 * 企业会员注册
	 */
	public static Profile createqi(String member, String password, String community, String email, String tel, String domain) throws SQLException {
		if ("csvclub".equals(community)) {
			password = SMS.md5_16(password);
		}
		if (OpenID.isOpen()) {
			OpenID.create(member, password, email, domain);
		}
		DbAdapter db = new DbAdapter(1);
		try {
			db.executeUpdate("INSERT INTO Profile(profile,member,password,community,email,recycle,membertype,mobile,time)VALUES(" + Seq.get() + "," + DbAdapter.cite(member) + ","
					+ DbAdapter.cite(password) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(email) + "," + 0 + "," + 1 + "," + DbAdapter.cite(tel) + "," + db.citeCurTime() + ")");
		} finally {
			db.close();
		}
		_cache.remove(member);
		Subscriber.create(community, new RV(member), 0);
		return find(member);
	}

	public void setEmailflag(int emailflag) throws SQLException {
		set("emailflag", String.valueOf(emailflag));
		this.emailflag = emailflag;
	}

	public void setqqopenid(String openid) throws SQLException {
		set("openid", openid);
		this.openid = openid;
	}

	public void setwxopenid(String openid) throws SQLException {
		set("wxopenid", openid);
		this.wxopenid = openid;
	}

	public void setwbopenid(String openid) throws SQLException {
		set("wbuid", openid);
		this.wbuid = openid;
	}

	/**
	 * 根据hospitalId 查找医院下的签收人
	 * 
	 * @param hospitalId
	 * @param type
	 *            0:粒子，1:发票
	 * @return list
	 * */
	public static List<Profile> getProfileByHospitalId0(int hospitalId, int type) {
		List<Profile> list = new ArrayList<Profile>();
		String qSql = "";
		if (hospitalId > 0) {
			if (type == 0)
				qSql = " AND particles_sign=1 AND hospital=" + hospitalId;
			else
				qSql = " AND invoice_sign=1 AND hospital=" + hospitalId;

			try {
				list = Profile.find1(qSql, 0, Integer.MAX_VALUE);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	/**
	 * 根据hospitalId 查找医院下的签收人
	 * 
	 * @param hospitalId
	 * @param type
	 *            0:粒子，1:发票
	 * @return list（8.7改hospital的类型为string）
	 * */
	public static List<Profile> getProfileByHospitalId(int hospitalId, int type) {
		List<Profile> list = new ArrayList<Profile>();
		String qSql = "";
		if (hospitalId > 0) {
			if (type == 0)
				qSql = " AND particles_sign=1 AND hospital like " + DbAdapter.cite("%" + hospitalId + "%");
			else
				qSql = " AND invoice_sign=1 AND hospital like " + DbAdapter.cite("%" + hospitalId + "%");

			try {
				list = Profile.find1(qSql, 0, Integer.MAX_VALUE);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	/**
	 * 根据openid 查找扫描签收人所在医院
	 * 
	 * @param openid
	 * @param type
	 *            0:粒子，1:发票
	 * @return hospital
	 * */
	public static int getHospitalByOpenId0(String openid, int type) {
		int hospital = 0;
		DbAdapter db = new DbAdapter();
		try {
			if (type == 0)
				db.executeQuery("select hospital from Profile where particles_sign=1 and openid=" + db.cite(openid) + "");
			else
				db.executeQuery("select hospital from Profile where invoice_sign=1 and openid=" + db.cite(openid) + "");
			while (db.next()) {
				hospital = db.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return hospital;
	}

	/**
	 * 根据openid 查找扫描签收人所在医院
	 * 
	 * @param openid
	 * @param type
	 *            0:粒子，1:发票
	 * @return hospital 8.7更改hospital类型为String
	 * */
	public static int getHospitalByOpenId(String openid, int type) {
		int hid = 0;
		String hospital = "";
		DbAdapter db = new DbAdapter();
		try {
			if (type == 0)
				db.executeQuery("select hospital from Profile where particles_sign=1 and openid=" + db.cite(openid) + "");
			else
				db.executeQuery("select hospital from Profile where invoice_sign=1 and openid=" + db.cite(openid) + "");
			while (db.next()) {
				hospital = db.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		if (hospital.length() > 0 && hospital.indexOf("|") == -1) {
			hid = Integer.parseInt(hospital);
		}
		return hid;
	}

	public static String getHospitalByOpenId2(String openid, int type) {

		String hospital = "";
		DbAdapter db = new DbAdapter();
		try {
			if (type == 0)
				db.executeQuery("select hospital from Profile where particles_sign=1 and openid=" + db.cite(openid) + "");
			else
				db.executeQuery("select hospital from Profile where invoice_sign=1 and openid=" + db.cite(openid) + "");
			while (db.next()) {
				hospital = db.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}

		return hospital;
	}

	/**
	 * 根据openid获取member
	 * 
	 * @param openid
	 * @return member
	 * */
	public static String getMemberByOpenId(String openid) {
		String member = "";
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("select member from Profile where  openid=" + db.cite(openid) + "");
			while (db.next()) {
				member = db.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return member;
	}

	/**
	 * 微信企业号 -通过userid 查找用户
	 * 
	 * @param userid
	 * @return profile
	 * */
	public static Profile getPByUserid(String userid) {
		Profile p = null;
		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("select member from Profile where  userid = " + db.cite(userid));
			while (db.next()) {
				String member = db.getString(1);
				p = Profile.find(member);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return p;
	}

	public static boolean flagopenid(String openid) {
		boolean flag = false;
		try {
			int count = Profile.count(" AND openid = " + DbAdapter.cite(openid));
			if (count > 0) {
				flag = true;
			} else {
				flag = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	public static boolean flaguid(String id) {
		boolean flag = false;
		try {
			int count = Profile.count(" AND wbuid = '" + id + "'");
			if (count > 0) {
				flag = true;
			} else {
				flag = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	public static boolean flagwxid(String id) {
		boolean flag = false;
		try {
			int count = Profile.count(" AND wxopenid = '" + id + "'");
			if (count > 0) {
				flag = true;
			} else {
				flag = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	public static Profile wbgetmember(String id) {
		Profile p = null;

		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("select member from Profile where  wbuid='" + id + "'  ");
			while (db.next()) {
				String member = db.getString(1);
				p = Profile.find(member);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return p;
	}

	public static Profile qqgetmember(String id) {
		Profile p = null;

		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("select member from Profile where  openid='" + id + "'  ");
			while (db.next()) {
				String member = db.getString(1);
				p = Profile.find(member);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return p;
	}

	public static Profile wxgetmember(String id) {
		Profile p = null;

		DbAdapter db = new DbAdapter();
		try {
			db.executeQuery("select member from Profile where  wxopenid='" + id + "'  ");
			while (db.next()) {
				String member = db.getString(1);
				p = Profile.find(member);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.close();
		}
		return p;
	}

	public void setByInterface() throws SQLException {
		String sql = "";
		if (profile < 1)
			sql= "INSERT INTO Profile(profile,member,password,mobile,code,hospitals,email,procurementUnit,tax,formula,issalesman,time)VALUES("
					+ (profile = Seq.get())
					+ ","
					+ DbAdapter.cite(member)
					+ ","
					+ DbAdapter.cite(password)
					+ ","
					+ DbAdapter.cite(mobile)
					+ ","
					+ DbAdapter.cite(code)
					+ ","
					+ DbAdapter.cite(hospitals)
					+ ","
					+ DbAdapter.cite(email)
					+ ","
					+ DbAdapter.cite(procurementUnit)
					+ ","
					+ tax
					+ ","
					+ formula
					+ ","
					+ issalesman
					+ ","
					+ DbAdapter.cite(time) + ")";
		else {
			sql = "update Profile set member =" + DbAdapter.cite(this.member) + ",mobile = " + DbAdapter.cite(mobile) + ",code=" + DbAdapter.cite(code)
					+ ",hospitals=" + DbAdapter.cite(hospitals) + ",email=" + DbAdapter.cite(email)+ ",procurementUnit=" + DbAdapter.cite(procurementUnit)
					+ ",tax=" + tax + ",formula=" + formula + ",issalesman=" + issalesman + ",time=" + DbAdapter.cite(time) +" where profile =" + this.profile;
		}
		DbAdapter db = new DbAdapter();
		try {
			db.executeUpdate(profile, sql.toString());
		} finally {
			db.close();
		}
	}

}
