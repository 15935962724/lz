package tea.entity.criterion;

import java.math.*;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class Item extends Entity
{
	private static Cache _cache = new Cache(100);
	public Hashtable _htLayer;
	public static final String ITEM_TYPE[] = { "国家环境质量标准", "国家排放标准", "环境行业标准", "技术政策", "国家方法标准", "行业方法标准", "其它" };
	public static final String STATES_TYPE[] = { "创建", "初始化", "下达编制组", "开题阶段", "征求意见", "送审阶段", "报批阶段", "发布阶段", "完成", "中止", "起草阶段" };
	// 0 , 1 , 2, 3, 4, 5, 6, 7 8 9 10
	// 以前叫"编制组高级管理员",现改为"项目负责人"
	public static final String ROLE_SUPERMANAGER = "项目负责人";
	// 以前叫"编制组管理员",现改为"参编人员"
	public static final String ROLE_MANAGER = "参编人员";
	// 以前叫"编制组项目成员",现去掉了此角色
	public static final String ROLE_PERSONNEL = "编制组项目成员______www.redcome.com";
	// 以前叫"标准处管理员","经办人",,现改为"项目主管"
	public static final String ROLE_PRINCIPAL = "项目主管";
	// 以前叫"标准所管理员",现改为-技术审查员
	public static final String ROLE_DIRECTOR = "技术审查员";
	private Date time;
	private String code;
	private int type;
	private int states;
	private int item;
	private Date updatetime;
	private String community;
	private int planyear;
	private BigDecimal outlay;
	private String principal; // 经办人
	private Date inittime;
	private int editgroup;
	private String personnel; // 编制组项目成员
	private Date egtime;
	private boolean defer;
	private String numeral; // 标准编号
	private Date granttime; // 批准时间
	private Date issuetime; // 发布时间
	private Date actualizetime; // 实施时间
	private boolean nonce; // 是否现行标准
	private String informuri;
	private String openuri;
	private String summaryuri;
	private boolean openauditing;
	private boolean summaryauditing;
	private String ideauri;
	private boolean ideaauditing;
	private String explainuri;
	private boolean explainauditing;
	private String backdropuri;
	private boolean backdropauditing;
	private String ideainformuri;
	private String feedbackuri;
	private String formulatinguri;
	private boolean formulatingauditing;
	private String fexplainuri;
	private boolean fexplainauditing;
	private String fideauri;
	private boolean fideaauditing;
	private String fbackdropuri;
	private boolean fbackdropauditing;
	private String finformuri;
	private String fsummaryuri;
	private boolean fsummaryauditing;
	private String leveluri;
	private String lexplainuri;
	private String lbackdropuri;
	private String lweaveuri;
	private String lsinformuri;
	private String lssummaryuri;
	private String lginformuri;
	private String lgsummaryuri;
	private boolean lbackdropauditing;
	private boolean lexplainauditing;
	private boolean levelauditing;
	private String standarduri;
	private String sweaveuri;
	private String sbackdropuri;
	private String otheruri;
	private String other2uri;
	private String supermanager; // 编制组高级管理员
	private String manager; // 编制组管理员
	private String director; // 标准所管理员
	private Date opentime;
	private Date ideatime;
	private Date formulatingtime;
	private Date leveltime;
	private Date standardtime;
	private String plantask; // 计划任务书
	private String outlayapp; // 经费申请表
	private boolean adequate;
	private String drafturi;
	private String ideainform2uri; // 征求意见阶段-征求单位名单
	private String finform2uri; // 送审阶段-征求单位名单
	private String areporturi_3; // 审查意见
	private String areporturi_4; // 审查意见
	private String areporturi_5; // 审查意见
	private String areporturi_6; // 审查意见
	/*
	 * 在起草阶段，在编制组用户上报界面中，增加一个“申请进入下一阶段”按钮；审查员或项目主管的界面上，“转下阶段”缺省状态为禁止；当编制组用户申请进入下一阶段后，审查员或项目主管的界面上，“转下阶段”缺省状态为允许，审查员或项目主管点击“转下阶段”，项目进入下个阶段。
	 */
	private boolean draftnext;
	private boolean lweaveauditing; // 报批阶段-征求意见汇总处理表

	class Layer
	{
		private String draftname;
		private String other2name;
		private String othername;
		private String sbackdropname;
		private String sweavename;
		private String standardname;
		private String lgsummaryname;
		private String lginformname;
		private String lssummaryname;
		private String lsinformname;
		private String lweavename;
		private String lbackdropname;
		private String lexplainname;
		private String levelname;
		private String fsummaryname;
		private String finformname;
		private String fbackdropname;
		private String fideaname;
		private String fexplainname;
		private String formulatingname;
		private String feedbackname;
		private String ideainformname;
		private String ideainform2name;
		private String finform2name; // 送审阶段-征求单位名单
		private String backdropname;
		private String explainname;
		private String ideaname;
		private String summaryname;
		private String openname;
		private String informname;
		private String name;
		private String aim;
		private String content;
		private String remark;
		private String plantaskname; // 计划任务书,名
		private String areportname_3; // 审查意见
		private String areportname_4; // 审查意见
		private String areportname_5; // 审查意见
		private String areportname_6; // 审查意见
	}

	public Item(int item) throws SQLException
	{
		this.item = item;
		_htLayer = new Hashtable();
		loadBasic();
	}

	/*
	 * public Item(int item, String code, String name, int type, int states, String remark, java.util.Date updatetime) { this.item = item; this.code = code; // this.name = name; this.type = type; this.states = states; // this.remark = remark; this.updatetime = updatetime; }
	 */
	private Layer getLayer(int i) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(i));
		if (layer == null)
		{
			layer = new Layer();
			int j = 1; // db.getInt("ProfileGetLanguage " + DbAdapter.cite(_strMember) + ", " + i);
			DbAdapter db = new DbAdapter();
			try
			{
				db
						.executeQuery("SELECT name,remark,aim,content,openname,summaryname,informname,ideaname,explainname,backdropname,ideainformname,feedbackname,formulatingname,fexplainname,fideaname,fbackdropname,finformname,fsummaryname,levelname,lexplainname,lbackdropname,lweavename,lsinformname,lssummaryname,lginformname,lgsummaryname,standardname,sweavename,sbackdropname,othername,other2name,draftname,ideainform2name,finform2name,plantaskname,areportname_3,areportname_4,areportname_5,areportname_6 FROM ItemLayer WHERE item="
								+ item); // + " AND language=" + j);
				if (db.next())
				{
					layer.name = db.getVarchar(j, i, 1);
					layer.remark = db.getText(j, i, 2);
					layer.aim = db.getVarchar(j, i, 3);
					layer.content = db.getText(j, i, 4);
					layer.openname = db.getVarchar(j, i, 5);
					layer.summaryname = db.getVarchar(j, i, 6);
					layer.informname = db.getVarchar(j, i, 7);
					layer.ideaname = db.getVarchar(j, i, 8);
					layer.explainname = db.getVarchar(j, i, 9);
					layer.backdropname = db.getVarchar(j, i, 10);
					layer.ideainformname = db.getVarchar(j, i, 11);
					layer.feedbackname = db.getVarchar(j, i, 12);
					layer.formulatingname = db.getVarchar(j, i, 13);
					layer.fexplainname = db.getVarchar(j, i, 14);
					layer.fideaname = db.getVarchar(j, i, 15);
					layer.fbackdropname = db.getVarchar(j, i, 16);
					layer.finformname = db.getVarchar(j, i, 17);
					layer.fsummaryname = db.getVarchar(j, i, 18);
					layer.levelname = db.getVarchar(j, i, 19);
					layer.lexplainname = db.getVarchar(j, i, 20);
					layer.lbackdropname = db.getVarchar(j, i, 21);
					layer.lweavename = db.getVarchar(j, i, 22);
					layer.lsinformname = db.getVarchar(j, i, 23);
					layer.lssummaryname = db.getVarchar(j, i, 24);
					layer.lginformname = db.getVarchar(j, i, 25);
					layer.lgsummaryname = db.getVarchar(j, i, 26);
					layer.standardname = db.getVarchar(j, i, 27);
					layer.sweavename = db.getVarchar(j, i, 28);
					layer.sbackdropname = db.getVarchar(j, i, 29);
					layer.othername = db.getVarchar(j, i, 30);
					layer.other2name = db.getVarchar(j, i, 31);
					layer.draftname = db.getVarchar(j, i, 32);
					layer.ideainform2name = db.getVarchar(j, i, 33);
					layer.finform2name = db.getVarchar(j, i, 34);
					layer.plantaskname = db.getVarchar(j, i, 35);
					layer.areportname_3 = db.getVarchar(j, i, 36);
					layer.areportname_4 = db.getVarchar(j, i, 37);
					layer.areportname_5 = db.getVarchar(j, i, 38);
					layer.areportname_6 = db.getVarchar(j, i, 39);
				}
			} finally
			{
				db.close();
			}
			_htLayer.put(new Integer(i), layer);
		}
		return layer;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db
					.executeQuery("SELECT code,type,states,updatetime,community,planyear,outlay,principal,inittime,editgroup,personnel,egtime,defer,numeral,granttime,issuetime,actualizetime,nonce,openuri,summaryuri,informuri,summaryauditing,ideauri,ideaauditing,explainuri,explainauditing,backdropuri,backdropauditing,ideainformuri,feedbackuri,formulatinguri,formulatingauditing,fexplainuri,fexplainauditing,fideauri,fideaauditing,fbackdropuri,fbackdropauditing,finformuri,fsummaryuri,fsummaryauditing,leveluri,levelauditing,lexplainuri,lexplainauditing,lbackdropuri,lbackdropauditing,lweaveuri,lsinformuri,lssummaryuri,lginformuri,lgsummaryuri,standarduri,sweaveuri,sbackdropuri,otheruri,other2uri,supermanager,manager,director,opentime,ideatime,formulatingtime,leveltime,standardtime,outlayapp,plantask,adequate,drafturi,ideainform2uri,finform2uri,draftnext,areporturi_3,areporturi_4,areporturi_5,areporturi_6,openauditing,lweaveauditing FROM Item WHERE item="
							+ (item));
			if (db.next())
			{
				code = db.getString(1);
				type = db.getInt(2);
				states = db.getInt(3);
				updatetime = db.getDate(4);
				community = db.getString(5);
				planyear = db.getInt(6);
				if (planyear == 0)
				{
					planyear = 2006;
				}
				outlay = db.getBigDecimal(7, 2);
				principal = db.getString(8);
				inittime = db.getDate(9);
				editgroup = db.getInt(10);
				personnel = db.getString(11);
				egtime = db.getDate(12);
				defer = db.getInt(13) != 0;
				numeral = db.getString(14);
				granttime = db.getDate(15);
				issuetime = db.getDate(16);
				actualizetime = db.getDate(17);
				nonce = db.getInt(18) != 0;
				openuri = db.getString(19);
				summaryuri = db.getString(20);
				informuri = db.getString(21);
				summaryauditing = db.getInt(22) != 0;
				ideauri = db.getString(23);
				ideaauditing = db.getInt(24) != 0;
				explainuri = db.getString(25);
				explainauditing = db.getInt(26) != 0;
				backdropuri = db.getString(27);
				backdropauditing = db.getInt(28) != 0;
				ideainformuri = db.getString(29);
				feedbackuri = db.getString(30);
				formulatinguri = db.getString(31);
				formulatingauditing = db.getInt(32) != 0;
				fexplainuri = db.getString(33);
				fexplainauditing = db.getInt(34) != 0;
				fideauri = db.getString(35);
				fideaauditing = db.getInt(36) != 0;
				fbackdropuri = db.getString(37);
				fbackdropauditing = db.getInt(38) != 0;
				finformuri = db.getString(39);
				fsummaryuri = db.getString(40);
				fsummaryauditing = db.getInt(41) != 0;
				leveluri = db.getString(42);
				levelauditing = db.getInt(43) != 0;
				lexplainuri = db.getString(44);
				lexplainauditing = db.getInt(45) != 0;
				lbackdropuri = db.getString(46);
				lbackdropauditing = db.getInt(47) != 0;
				lweaveuri = db.getString(48);
				lsinformuri = db.getString(49);
				lssummaryuri = db.getString(50);
				lginformuri = db.getString(51);
				lgsummaryuri = db.getString(52);
				standarduri = db.getString(53);
				sweaveuri = db.getString(54);
				sbackdropuri = db.getString(55);
				otheruri = db.getString(56);
				other2uri = db.getString(57);
				supermanager = db.getString(58);
				manager = db.getString(59);
				director = db.getString(60);
				opentime = db.getDate(61);
				ideatime = db.getDate(62);
				formulatingtime = db.getDate(63);
				leveltime = db.getDate(64);
				standardtime = db.getDate(65);
				outlayapp = db.getString(66);
				plantask = db.getString(67);
				adequate = db.getInt(68) != 0;
				drafturi = db.getString(69);
				ideainform2uri = db.getString(70);
				finform2uri = db.getString(71);
				draftnext = db.getInt(72) != 0;
				areporturi_3 = db.getString(73);
				areporturi_4 = db.getString(74);
				areporturi_5 = db.getString(75);
				areporturi_6 = db.getString(76);
				openauditing = db.getInt(77) != 0; // 项目开题阶段-开题报告
				lweaveauditing = db.getInt(78) != 0; // 项目开题阶段-开题报告
			}
		} finally
		{
			db.close();
		}
		if (outlay == null)
		{
			outlay = new java.math.BigDecimal("0.00");
		}
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE Item WHERE item=" + item);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(item));
	}

	public static int create(String code, String name, int type, int states, String remark, String community) throws SQLException
	{
		int item = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Item( code  ,   type    ,states,updatetime ,community   ) VALUES(" + DbAdapter.cite(code) + "," + (type) + "," + states + "," + DbAdapter.cite(new java.util.Date()) + "," + DbAdapter.cite(community) + ")");
			item = db.getInt("SELECT MAX(item) FROM Item");
			db.executeUpdate("INSERT INTO ItemLayer(item,language,name,remark) VALUES(" + item + "," + 1 + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(remark) + ")");
		} finally
		{
			db.close();
		}
		return item;
	}

	public static int findItemByCode(String code) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			return db.getInt("SELECT item FROM Item WHERE code=" + DbAdapter.cite(code));
		} finally
		{
			db.close();
		}
	}

	public void set(String code, String name, int type, int states, String remark) throws SQLException
	{
		updatetime = new java.util.Date();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Item SET code=" + DbAdapter.cite(code) + ",type=" + (type) + ",states=" + (states) + ",updatetime=" + DbAdapter.cite(updatetime) + " WHERE item=" + item);
			db.executeUpdate("UPDATE ItemLayer SET name=" + DbAdapter.cite(name) + ",remark=" + DbAdapter.cite(remark) + " WHERE item=" + item);
		} finally
		{
			db.close();
		}
		this.code = code;
		// this.name = name;
		this.type = type;
		this.states = states;
		// this.remark = remark;
		_htLayer.clear();
	}

	// 项目初始化
	public void setInit(String name, int states, String content, int planyear, String principal, String plantask, String plantaskname) throws SQLException
	{
		inittime = new java.util.Date();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Item SET states=" + states + ", planyear = " + (planyear) + ", plantask = " + DbAdapter.cite(plantask) + ", principal = " + DbAdapter.cite(principal) + ", inittime = " + DbAdapter.cite(inittime) + " WHERE item = " + item);
			db.executeUpdate("UPDATE ItemLayer SET name=" + DbAdapter.cite(name) + ", content = " + DbAdapter.cite(content) + ", plantaskname = " + DbAdapter.cite(plantaskname) + " WHERE item = " + item);
		} finally
		{
			db.close();
		}
		this.states = states;
		this.planyear = planyear;
		this.principal = principal;
		// this.plantaskname = plantaskname;
		this.plantask = plantask;
		_htLayer.clear();
	}

	// 下达编制组 //状态, 部门, 参加人员, 高级管理员, 管理员
	public void setEg(int states, int editgroup, String personnel, String supermanager, String manager) throws SQLException
	{
		egtime = new java.util.Date();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Item SET states=" + states + ",editgroup = " + (editgroup) + ", personnel = " + DbAdapter.cite(personnel) + ",egtime = " + DbAdapter.cite(egtime) + ",supermanager = " + DbAdapter.cite(supermanager) + ",manager = " + DbAdapter.cite(manager) + " WHERE item = " + item);
		} finally
		{
			db.close();
		}
		this.states = states;
		this.editgroup = editgroup;
		this.personnel = personnel;
		this.supermanager = supermanager;
		this.manager = manager;
	}

	// 修改项目状态 //状态, 是否延迟
	public void set(int states, boolean defer) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Item SET states=" + states + ",defer = " + (defer ? "1" : "0") + " WHERE item = " + item);
		} finally
		{
			db.close();
		}
		this.states = states;
		this.defer = defer;
	}

	// 标准发布
	public void set(int states, String numeral, Date granttime, Date issuetime, Date actualizetime, boolean nonce) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Item SET states=" + states + ",numeral=" + DbAdapter.cite(numeral) + ",granttime=" + DbAdapter.cite(granttime) + ",issuetime=" + DbAdapter.cite(issuetime) + ",actualizetime=" + DbAdapter.cite(actualizetime) + ",nonce = " + (nonce ? "1" : "0") + " WHERE item = " + item);
		} finally
		{
			db.close();
		}
		this.states = states;
		this.numeral = numeral;
		this.granttime = granttime;
		this.issuetime = issuetime;
		this.actualizetime = actualizetime;
		this.nonce = nonce;
	}

	// 开题阶段
	public void set(String openuri, String openname, String summaryuri, String summaryname) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		StringBuilder sql = new StringBuilder();
		StringBuilder sqllayer = new StringBuilder();
		if (openuri != null)
		{
			sql.append(",openuri=" + DbAdapter.cite(openuri));
			this.openuri = openuri;
		}
		if (openname != null)
		{
			sqllayer.append(",openname=" + DbAdapter.cite(openname));
			// this.openname = openname;
		}
		if (summaryuri != null)
		{
			sql.append(",summaryuri=" + DbAdapter.cite(summaryuri));
			this.summaryuri = summaryuri;
		}
		if (summaryname != null)
		{
			sqllayer.append(",summaryname=" + DbAdapter.cite(summaryname));
			// this.summaryname = summaryname;
		}
		// this.opentime = null;

		try
		{
			db.executeUpdate("UPDATE Item SET opentime=" + DbAdapter.cite(opentime) + sql.toString() + " WHERE item = " + item);
			if (sqllayer.length() > 0)
			{
				db.executeUpdate("UPDATE ItemLayer SET " + sqllayer.substring(1) + " WHERE item = " + item);
				_htLayer.clear();
			}
		} finally
		{
			db.close();
		}
	}

	// 开题阶段-审核
	public void set_3(String informuri, String informname, String areporturi_3, String areportname_3, boolean openauditing, boolean summaryauditing) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		StringBuilder sql = new StringBuilder();
		StringBuilder sqllayer = new StringBuilder();
		sql.append("openauditing=" + DbAdapter.cite(openauditing));
		sql.append(",summaryauditing=" + DbAdapter.cite(summaryauditing));
		if (informuri != null)
		{
			sql.append(",informuri=" + DbAdapter.cite(informuri));
			this.informuri = informuri;
		}
		if (informname != null)
		{
			sqllayer.append(",informname=" + DbAdapter.cite(informname));
		}
		if (areporturi_3 != null)
		{
			sql.append(",areporturi_3=" + DbAdapter.cite(areporturi_3));
			this.areporturi_3 = areporturi_3;
		}
		if (areportname_3 != null)
		{
			sqllayer.append(",areportname_3=" + DbAdapter.cite(areportname_3));
		}
		opentime = new java.util.Date();

		try
		{
			db.executeUpdate("UPDATE Item SET " + sql.toString() + ",opentime=" + DbAdapter.cite(opentime) + " WHERE item = " + item);
			if (sqllayer.length() > 0)
			{
				db.executeUpdate("UPDATE ItemLayer SET " + sqllayer.substring(1) + " WHERE item = " + item);
				_htLayer.clear();
			}
		} finally
		{
			db.close();
		}
		this.summaryauditing = summaryauditing;
		this.openauditing = openauditing;
	}

	// 征求意见阶段
	public void set(String ideauri, String ideaname, String explainuri, String explainname, String backdropuri, String backdropname) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		StringBuilder sql = new StringBuilder();
		StringBuilder sqllayer = new StringBuilder();
		if (ideauri != null)
		{
			sql.append(",ideauri=" + DbAdapter.cite(ideauri));
			this.ideauri = ideauri;
		}
		if (ideaname != null)
		{
			sqllayer.append(",ideaname=" + DbAdapter.cite(ideaname));
		}
		if (explainuri != null)
		{
			sql.append(",explainuri=" + DbAdapter.cite(explainuri));
			this.explainuri = explainuri;
		}
		if (explainname != null)
		{
			sqllayer.append(",explainname=" + DbAdapter.cite(explainname));
		}
		if (backdropuri != null)
		{
			sql.append(",backdropuri=" + DbAdapter.cite(backdropuri));
			this.backdropuri = backdropuri;
		}
		if (backdropname != null)
		{
			sqllayer.append(",backdropname=" + DbAdapter.cite(backdropname));
		}
		// ideatime = null;

		try
		{
			db.executeUpdate("UPDATE Item SET ideatime=" + DbAdapter.cite(ideatime) + sql.toString() + " WHERE item = " + item);
			if (sqllayer.length() > 0)
			{
				db.executeUpdate("UPDATE ItemLayer SET " + sqllayer.substring(1) + " WHERE item = " + item);
				_htLayer.clear();
			}
		} finally
		{
			db.close();
		}
	}

	// 征求意见阶段-审核
	public void set_4(boolean ideaauditing, boolean explainauditing, boolean backdropauditing, String ideainformuri, String ideainformname, String ideainform2uri, String ideainform2name, String feedbackuri, String feedbackname, String areporturi, String areportname) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		StringBuilder sql = new StringBuilder();
		StringBuilder sqllayer = new StringBuilder();
		/*
		 * if (ideaauditing && explainauditing && backdropauditing) { sql.append(" ,states=5"); //审查通过后,项目状态由系统自动改为“送审阶段” }
		 */
		if (ideainformuri != null)
		{
			sql.append(",ideainformuri=" + DbAdapter.cite(ideainformuri));
			this.ideainformuri = ideainformuri;
		}
		if (ideainformname != null)
		{
			sqllayer.append(",ideainformname=" + DbAdapter.cite(ideainformname));
		}
		if (ideainform2uri != null)
		{
			sql.append(",ideainform2uri=" + DbAdapter.cite(ideainform2uri));
			this.ideainform2uri = ideainform2uri;
		}
		if (ideainform2name != null)
		{
			sqllayer.append(",ideainform2name=" + DbAdapter.cite(ideainform2name));
		}
		if (feedbackuri != null)
		{
			sql.append(",feedbackuri=" + DbAdapter.cite(feedbackuri));
			this.feedbackuri = feedbackuri;
		}
		if (feedbackname != null)
		{
			sqllayer.append(",feedbackname=" + DbAdapter.cite(feedbackname));
		}
		if (areporturi != null)
		{
			sql.append(",areporturi_4=" + DbAdapter.cite(areporturi));
			this.areporturi_4 = areporturi;
		}
		if (areportname != null)
		{
			sqllayer.append(",areportname_4=" + DbAdapter.cite(areportname));
		}
		ideatime = new java.util.Date();

		try
		{
			db.executeUpdate("UPDATE Item SET ideatime=" + DbAdapter.cite(ideatime) + ",ideaauditing=" + (ideaauditing ? "1" : "0") + ",explainauditing=" + (explainauditing ? "1" : "0") + ",backdropauditing=" + (backdropauditing ? "1" : "0") + sql.toString() + " WHERE item = " + item);
			if (sqllayer.length() > 0)
			{
				db.executeUpdate("UPDATE ItemLayer SET " + sqllayer.substring(1) + " WHERE item = " + item);
				_htLayer.clear();
			}
		} finally
		{
			db.close();
		}
		this.ideaauditing = ideaauditing;
		this.explainauditing = explainauditing;
		this.backdropauditing = backdropauditing;
	}

	// 送审阶段
	public void set(String formulatinguri, String formulatingname, String fexplainuri, String fexplainname, String fideauri, String fideaname, String fbackdropuri, String fbackdropname, String fsummaryuri, String fsummaryname) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		StringBuilder sql = new StringBuilder();
		StringBuilder sqllayer = new StringBuilder();
		if (formulatinguri != null)
		{
			sql.append("formulatinguri=" + DbAdapter.cite(formulatinguri));
			this.formulatinguri = formulatinguri;
		} else
		{
			sql.append("formulatinguri=formulatinguri");
		}
		if (formulatingname != null)
		{
			sqllayer.append(",formulatingname=" + DbAdapter.cite(formulatingname));
		}
		if (fexplainuri != null)
		{
			sql.append(",fexplainuri=" + DbAdapter.cite(fexplainuri));
			this.fexplainuri = fexplainuri;
		}
		if (fexplainname != null)
		{
			sqllayer.append(",fexplainname=" + DbAdapter.cite(fexplainname));
		}
		if (fideauri != null)
		{
			sql.append(",fideauri=" + DbAdapter.cite(fideauri));
			this.fideauri = fideauri;
		}
		if (fideaname != null)
		{
			sqllayer.append(",fideaname=" + DbAdapter.cite(fideaname));
		}
		if (fbackdropuri != null)
		{
			sql.append(",fbackdropuri=" + DbAdapter.cite(fbackdropuri));
			this.fbackdropuri = fbackdropuri;
		}
		if (fbackdropname != null)
		{
			sqllayer.append(",fbackdropname=" + DbAdapter.cite(fbackdropname));
		}
		if (fsummaryuri != null)
		{
			sql.append(",fsummaryuri=" + DbAdapter.cite(fsummaryuri));
			this.fsummaryuri = fsummaryuri;
		}
		if (fsummaryname != null)
		{
			sqllayer.append(",fsummaryname=" + DbAdapter.cite(fsummaryname));
		}
		// formulatingtime = null;

		try
		{
			db.executeUpdate("UPDATE Item SET " + sql.toString() + ",formulatingtime=" + DbAdapter.cite(formulatingtime) + " WHERE item = " + item);
			if (sqllayer.length() > 0)
			{
				db.executeUpdate("UPDATE ItemLayer SET " + sqllayer.substring(1) + " WHERE item = " + item);
				_htLayer.clear();
			}
		} finally
		{
			db.close();
		}
	}

	// 送审阶段-审核
	public void set_5(boolean formulatingauditing, boolean fexplainauditing, boolean fideaauditing, boolean fbackdropauditing, String finformuri, String finformname, String finform2uri, String finform2name, boolean fsummaryauditing, String areporturi_5, String areportname_5) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		StringBuilder sql = new StringBuilder();
		StringBuilder sqllayer = new StringBuilder();
		/*
		 * if (formulatingauditing && fexplainauditing && fideaauditing && fbackdropauditing && fsummaryauditing) { sql.append(",states=6"); //把状态改为"报批阶段" }
		 */
		if (finformuri != null)
		{
			sql.append(",finformuri=" + DbAdapter.cite(finformuri));
			this.finformuri = finformuri;
		}
		if (finformname != null)
		{
			sqllayer.append(",finformname=" + DbAdapter.cite(finformname));
		}
		if (finform2uri != null)
		{
			sql.append(",finform2uri=" + DbAdapter.cite(finform2uri));
			this.finform2uri = finform2uri;
		}
		if (finform2name != null)
		{
			sqllayer.append(",finform2name=" + DbAdapter.cite(finform2name));
		}
		if (areporturi_5 != null)
		{
			sql.append(",areporturi_5=" + DbAdapter.cite(areporturi_5));
			this.areporturi_5 = areporturi_5;
		}
		if (areportname_5 != null)
		{
			sqllayer.append(",areportname_5=" + DbAdapter.cite(areportname_5));
		}
		formulatingtime = new java.util.Date();

		try
		{
			db.executeUpdate("UPDATE Item SET formulatingauditing=" + (formulatingauditing ? "1" : "0") + ",fexplainauditing=" + (fexplainauditing ? "1" : "0") + ",fideaauditing=" + (fideaauditing ? "1" : "0") + ",fbackdropauditing=" + (fbackdropauditing ? "1" : "0") + ",fsummaryauditing=" + (fsummaryauditing ? "1" : "0") + sql.toString() + ",formulatingtime=" + DbAdapter.cite(formulatingtime) + " WHERE item = " + item);
			if (sqllayer.length() > 0)
			{
				db.executeUpdate("UPDATE ItemLayer SET " + sqllayer.substring(1) + " WHERE item = " + item);
				_htLayer.clear();
			}
		} finally
		{
			db.close();
		}
		this.formulatingauditing = formulatingauditing;
		this.fexplainauditing = fexplainauditing;
		this.fideaauditing = fideaauditing;
		this.fbackdropauditing = fbackdropauditing;
		this.fsummaryauditing = fsummaryauditing;
	}

	// 报批阶段
	public void set_6(String leveluri, String levelname, String lexplainuri, String lexplainname, String lbackdropuri, String lbackdropname, String lweaveuri, String lweavename) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		StringBuilder sql = new StringBuilder();
		StringBuilder sqllayer = new StringBuilder();
		if (leveluri != null)
		{
			sql.append(",leveluri=" + DbAdapter.cite(leveluri));
			this.leveluri = leveluri;
		}
		if (levelname != null)
		{
			sqllayer.append(",levelname=" + DbAdapter.cite(levelname));
			// this.levelname = levelname;
		}
		if (lexplainuri != null)
		{
			sql.append(",lexplainuri=" + DbAdapter.cite(lexplainuri));
			this.lexplainuri = lexplainuri;
		}
		if (lexplainname != null)
		{
			sqllayer.append(",lexplainname=" + DbAdapter.cite(lexplainname));
			// this.lexplainname = lexplainname;
		}
		if (lbackdropuri != null)
		{
			sql.append(",lbackdropuri=" + DbAdapter.cite(lbackdropuri));
			this.lbackdropuri = lbackdropuri;
		}
		if (lbackdropname != null)
		{
			sqllayer.append(",lbackdropname=" + DbAdapter.cite(lbackdropname));
		}
		if (lweaveuri != null)
		{
			sql.append(",lweaveuri=" + DbAdapter.cite(lweaveuri));
			this.lweaveuri = lweaveuri;
		}
		if (lweavename != null)
		{
			sqllayer.append(",lweavename=" + DbAdapter.cite(lweavename));
		}
		// leveltime = null;
		try
		{
			db.executeUpdate("UPDATE Item SET leveltime=" + DbAdapter.cite(leveltime) + sql.toString() + " WHERE item = " + item);
			if (sqllayer.length() > 0)
			{
				db.executeUpdate("UPDATE ItemLayer SET " + sqllayer.substring(1) + " WHERE item = " + item);
				_htLayer.clear();
			}
		} finally
		{
			db.close();
		}
	}

	// 报批阶段-审核
	public void set_6(boolean levelauditing, boolean lexplainauditing, boolean lbackdropauditing, String lsinformuri, String lsinformname, String lssummaryuri, String lssummaryname, String lginformuri, String lginformname, String lgsummaryuri, String lgsummaryname, String areporturi_6, String areportname_6) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		StringBuilder sql = new StringBuilder();
		StringBuilder sqllayer = new StringBuilder();
		/*
		 * if (levelauditing && lexplainauditing && lbackdropauditing) { sql.append(",states=7"); //审查通过后,项目状态由系统自动改为 标准发布 }
		 */
		if (lsinformuri != null)
		{
			sql.append(",lsinformuri=" + DbAdapter.cite(lsinformuri));
			this.lsinformuri = lsinformuri;
		}
		if (lsinformname != null)
		{
			sqllayer.append(",lsinformname=" + DbAdapter.cite(lsinformname));
			// this.lsinformname = lsinformname;
		}
		if (lssummaryuri != null)
		{
			sql.append(",lssummaryuri=" + DbAdapter.cite(lssummaryuri));
			this.lssummaryuri = lssummaryuri;
		}
		if (lssummaryname != null)
		{
			sqllayer.append(",lssummaryname=" + DbAdapter.cite(lssummaryname));
			// this.lssummaryname = lssummaryname;
		}
		if (lginformuri != null)
		{
			sql.append(",lginformuri=" + DbAdapter.cite(lginformuri));
			this.lginformuri = lginformuri;
		}
		if (lginformname != null)
		{
			sqllayer.append(",lginformname=" + DbAdapter.cite(lginformname));
			// this.lginformname = lginformname;
		}
		if (lgsummaryuri != null)
		{
			sql.append(",lgsummaryuri=" + DbAdapter.cite(lgsummaryuri));
			this.lgsummaryuri = lgsummaryuri;
		}
		if (lgsummaryname != null)
		{
			sqllayer.append(",lgsummaryname=" + DbAdapter.cite(lgsummaryname));
		}
		if (areporturi_6 != null)
		{
			sql.append(",areporturi_6=" + DbAdapter.cite(areporturi_6));
			this.areporturi_6 = areporturi_6;
		}
		if (areportname_6 != null)
		{
			sqllayer.append(",areportname_6=" + DbAdapter.cite(areportname_6));
		}
		leveltime = new java.util.Date();
		try
		{
			db.executeUpdate("UPDATE Item SET levelauditing=" + (levelauditing ? "1" : "0") + ",lexplainauditing=" + (lexplainauditing ? "1" : "0") + ",lbackdropauditing=" + (lbackdropauditing ? "1" : "0") + sql.toString() + ",leveltime=" + DbAdapter.cite(leveltime) + " WHERE item = " + item);
			if (sqllayer.length() > 0)
			{
				db.executeUpdate("UPDATE ItemLayer SET " + sqllayer.substring(1) + " WHERE item = " + item);
				_htLayer.clear();
			}
		} finally
		{
			db.close();
		}
		this.levelauditing = levelauditing;
		this.lexplainauditing = lexplainauditing;
		this.lbackdropauditing = lbackdropauditing;
	}

	// 标准阶段
	public void setStandard(String standarduri, String standardname, String sweaveuri, String sweavename, String sbackdropuri, String sbackdropname) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		StringBuilder sql = new StringBuilder();
		StringBuilder sqllayer = new StringBuilder();
		if (standarduri != null)
		{
			sql.append(",standarduri=" + DbAdapter.cite(standarduri));
			this.standarduri = standarduri;
		}
		if (standardname != null)
		{
			sqllayer.append(",standardname=" + DbAdapter.cite(standardname));
			// this.standardname = standardname;
		}
		if (sweaveuri != null)
		{
			sql.append(",sweaveuri=" + DbAdapter.cite(sweaveuri));
			this.sweaveuri = sweaveuri;
		}
		if (sweavename != null)
		{
			sqllayer.append(",sweavename=" + DbAdapter.cite(sweavename));
			// this.sweavename = sweavename;
		}
		if (sbackdropuri != null)
		{
			sql.append(",sbackdropuri=" + DbAdapter.cite(sbackdropuri));
			this.sbackdropuri = sbackdropuri;
		}
		if (sbackdropname != null)
		{
			sqllayer.append(",sbackdropname=" + DbAdapter.cite(sbackdropname));
			// this.sbackdropname = sbackdropname;
		}
		// standardtime = null;
		try
		{
			db.executeUpdate("UPDATE Item SET standardtime=" + DbAdapter.cite(standardtime) + sql.toString() + " WHERE item = " + item);
			if (sqllayer.length() > 0)
			{
				db.executeUpdate("UPDATE ItemLayer SET " + sqllayer.substring(1) + " WHERE item = " + item);
				_htLayer.clear();
			}
		} finally
		{
			db.close();
		}
	}

	// 其它阶段
	public void setOther(String otheruri, String othername, String other2uri, String other2name) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		StringBuilder sql = new StringBuilder();
		StringBuilder sqllayer = new StringBuilder();
		if (otheruri != null)
		{
			sql.append("otheruri=" + DbAdapter.cite(otheruri));
			this.otheruri = otheruri;
		} else
		{
			sql.append("otheruri=otheruri");
		}
		if (othername != null)
		{
			sqllayer.append(",othername=" + DbAdapter.cite(othername));
			// this.othername = othername;
		}
		if (other2uri != null)
		{
			sql.append(",other2uri=" + DbAdapter.cite(other2uri));
			this.other2uri = other2uri;
		}
		if (other2name != null)
		{
			sqllayer.append(",other2name=" + DbAdapter.cite(other2name));
			// this.other2name = other2name;
		}
		try
		{
			db.executeUpdate("UPDATE Item SET " + sql.toString() + " WHERE item = " + item);
			if (sqllayer.length() > 0)
			{
				db.executeUpdate("UPDATE ItemLayer SET " + sqllayer.substring(1) + " WHERE item = " + item);
				_htLayer.clear();
			}
		} finally
		{
			db.close();
		}
	}

	// 起草阶段
	public void setDraft(boolean draftnext, String drafturi, String draftname) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		StringBuilder sql = new StringBuilder();
		StringBuilder sqllayer = new StringBuilder();
		if (drafturi != null)
		{
			sql.append(",drafturi=" + DbAdapter.cite(drafturi));
			this.drafturi = drafturi;
		}
		if (draftname != null)
		{
			sqllayer.append(",draftname=" + DbAdapter.cite(draftname));
		}
		try
		{
			db.executeUpdate("UPDATE Item SET draftnext=" + (draftnext ? "1" : "0") + sql.toString() + " WHERE item = " + item);
			if (sqllayer.length() > 0)
			{
				db.executeUpdate("UPDATE ItemLayer SET " + sqllayer.substring(1) + " WHERE item = " + item);
				_htLayer.clear();
			}
		} finally
		{
			db.close();
		}
		this.draftnext = draftnext;
	}

	public static int countByStates(int states, String community, String sql) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(item) FROM Item WHERE states=" + (states) + " AND community=" + DbAdapter.cite(community) + sql);
			if (db.next())
			{
				return db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return 0;
	}

	public static java.util.Enumeration find(String community, String sql, int pos, int pageSize) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		/*
		 * if (sql.lastIndexOf("ORDER BY") == -1) { sql.append(" ORDER BY updatetime"); }
		 */
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT item FROM Item WHERE community=" + DbAdapter.cite(community) + sql);
			for (int l = 0; l < (pos + pageSize) && db.next(); l++)
			{
				if (l >= pos)
				{
					int item = db.getInt(1);
					vector.addElement(new Integer(item));
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static java.util.Enumeration findByInit(String community, String sql, int pos, int pageSize) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT item FROM Item WHERE states IN(0,1) AND community=" + DbAdapter.cite(community) + sql + " ORDER BY updatetime");
			for (int l = 0; l < (pos + pageSize) && db.next(); l++)
			{
				if (l >= pos)
				{
					int item = db.getInt(1);
					vector.addElement(new Integer(item));
				}
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	/*
	 * public static java.util.Enumeration findByMobile2(String mobile2, int pos, int pageSize) throws SQLException { java.util.Vector vector = new java.util.Vector(); DbAdapter db = new DbAdapter(); try { db.executeQuery("SELECT TOP " + (pos + pageSize) + " Item ,mobile , content, ip ,mobile2,idcard ,time,states FROM Item WHERE mobile2=" + DbAdapter.cite(mobile2) + " ORDER BY time"); for (int l = 0; db.next(); l++) { if (l >= pos) { int Item = db.getInt(1); String mobile = db.getString(2); String
	 * content = db.getString(3); String ip = db.getString(4); String idcard = db.getString(5); java.util.Date time = db.getDate(6); int states = db.getInt(7); Item obj = new Item(Item, mobile, content, ip, mobile2, idcard, time, states); _cache.put(new Integer(Item), obj); vector.addElement(obj); } }} finally { db.close(); } return vector.elements(); }
	 * 
	 * public static Item findByIpLast(String ip) throws SQLException { Item obj = null; DbAdapter db = new DbAdapter(); try { db.executeQuery("SELECT Item,mobile,content ,mobile2,idcard ,time ,states FROM Item WHERE ip=" + DbAdapter.cite(ip) + " ORDER BY time DESC"); if (db.next()) { int Item = db.getInt(1); String mobile = db.getString(2); String content = db.getString(3); String mobile2 = db.getString(4); String idcard = db.getString(5); java.util.Date time = db.getDate(6); int states =
	 * db.getInt(7); obj = new Item(Item, mobile, content, ip, mobile2, idcard, time, states); _cache.put(new Integer(Item), obj); }} finally { db.close(); } return obj; }
	 */
	public static Item find(int item) throws SQLException
	{
		Item obj = (Item) _cache.get(new Integer(item));
		if (obj == null)
		{
			obj = new Item(item);
			_cache.put(new Integer(item), obj);
		}
		return obj;
	}

	public Date getTime()
	{
		return time;
	}

	public String getCode()
	{
		return code;
	}

	public String getName() throws SQLException
	{
		return getLayer(1).name;
	}

	public String getPlantaskname() throws SQLException
	{
		return getLayer(1).plantaskname;
	}

	public int getType()
	{
		return type;
	}

	public int getStates()
	{
		return states;
	}

	public String getRemark() throws SQLException
	{
		return getLayer(1).remark;
	}

	public Date getUpdatetime()
	{
		return updatetime;
	}

	public String getCommunity()
	{
		return community;
	}

	public String getAim() throws SQLException
	{
		return getLayer(1).aim;
	}

	public String getContent() throws SQLException
	{
		return getLayer(1).content;
	}

	public int getPlanyear()
	{
		return planyear;
	}

	public BigDecimal getOutlay() throws SQLException
	{
		return ItemBudget.getTotal(item);
		// return outlay;
	}

	public String getPrincipal()
	{
		return principal;
	}

	public Date getInittime()
	{
		return inittime;
	}

	public int getEditgroup()
	{
		return editgroup;
	}

	public String getPersonnel()
	{
		return personnel;
	}

	public Date getEgtime()
	{
		return egtime;
	}

	public boolean isDefer()
	{
		return defer;
	}

	public String getNumber()
	{
		return numeral;
	}

	public Date getGranttime()
	{
		return granttime;
	}

	public String getGranttimeToString()
	{
		if (granttime == null)
		{
			return "";
		}
		return sdf.format(granttime);
	}

	public Date getIssuetime()
	{
		return issuetime;
	}

	public String getIssuetimeToString()
	{
		if (issuetime == null)
		{
			return "";
		}
		return sdf.format(issuetime);
	}

	public Date getActualizetime()
	{
		return actualizetime;
	}

	public String getActualizetimeToString()
	{
		if (actualizetime == null)
		{
			return "";
		}
		return sdf.format(actualizetime);
	}

	public boolean isNonce()
	{
		return nonce;
	}

	public String getInformuri()
	{
		return informuri;
	}

	public String getOpenuri()
	{
		return openuri;
	}

	public String getOpenname() throws SQLException
	{
		return getLayer(1).openname;
	}

	public String getInformname() throws SQLException
	{
		return getLayer(1).informname;
	}

	public String getSummaryname() throws SQLException
	{
		return getLayer(1).summaryname;
	}

	public String getSummaryuri()
	{
		return summaryuri;
	}

	public boolean isSummaryauditing()
	{
		return summaryauditing;
	}

	public String getIdeauri()
	{
		return ideauri;
	}

	public String getIdeaname() throws SQLException
	{
		return getLayer(1).ideaname;
	}

	public boolean isIdeaauditing()
	{
		return ideaauditing;
	}

	public String getExplainuri()
	{
		return explainuri;
	}

	public String getExplainname() throws SQLException
	{
		return getLayer(1).explainname;
	}

	public boolean isExplainauditing()
	{
		return explainauditing;
	}

	public String getBackdropuri()
	{
		return backdropuri;
	}

	public String getBackdropname() throws SQLException
	{
		return getLayer(1).backdropname;
	}

	public boolean isBackdropauditing()
	{
		return backdropauditing;
	}

	public String getIdeainformuri()
	{
		return ideainformuri;
	}

	public String getIdeainformname() throws SQLException
	{
		return getLayer(1).ideainformname;
	}

	public String getFeedbackuri()
	{
		return feedbackuri;
	}

	public String getFeedbackname() throws SQLException
	{
		return getLayer(1).feedbackname;
	}

	public String getFormulatinguri()
	{
		return formulatinguri;
	}

	public String getFormulatingname() throws SQLException
	{
		return getLayer(1).formulatingname;
	}

	public boolean isFormulatingauditing()
	{
		return formulatingauditing;
	}

	public String getFexplainuri()
	{
		return fexplainuri;
	}

	public String getFexplainname() throws SQLException
	{
		return getLayer(1).fexplainname;
	}

	public boolean isFexplainauditing()
	{
		return fexplainauditing;
	}

	public String getFideauri()
	{
		return fideauri;
	}

	public String getFideaname() throws SQLException
	{
		return getLayer(1).fideaname;
	}

	public boolean isFideaauditing()
	{
		return fideaauditing;
	}

	public String getFbackdropuri()
	{
		return fbackdropuri;
	}

	public String getFbackdropname() throws SQLException
	{
		return getLayer(1).fbackdropname;
	}

	public boolean isFbackdropauditing()
	{
		return fbackdropauditing;
	}

	public String getFinformuri()
	{
		return finformuri;
	}

	public String getFinformname() throws SQLException
	{
		return getLayer(1).finformname;
	}

	public String getFsummaryuri()
	{
		return fsummaryuri;
	}

	public String getFsummaryname() throws SQLException
	{
		return getLayer(1).fsummaryname;
	}

	public boolean isFsummaryauditing()
	{
		return fsummaryauditing;
	}

	public String getLeveluri()
	{
		return leveluri;
	}

	public String getLevelname() throws SQLException
	{
		return getLayer(1).levelname;
	}

	public String getLexplainuri()
	{
		return lexplainuri;
	}

	public String getLexplainname() throws SQLException
	{
		return getLayer(1).lexplainname;
	}

	public String getLbackdropuri()
	{
		return lbackdropuri;
	}

	public String getLbackdropname() throws SQLException
	{
		return getLayer(1).lbackdropname;
	}

	public String getLweaveuri()
	{
		return lweaveuri;
	}

	public String getLweavename() throws SQLException
	{
		return getLayer(1).lweavename;
	}

	public String getLsinformuri()
	{
		return lsinformuri;
	}

	public String getLsinformname() throws SQLException
	{
		return getLayer(1).lsinformname;
	}

	public String getLssummaryuri()
	{
		return lssummaryuri;
	}

	public String getLssummaryname() throws SQLException
	{
		return getLayer(1).lssummaryname;
	}

	public String getLginformuri()
	{
		return lginformuri;
	}

	public String getLginformname() throws SQLException
	{
		return getLayer(1).lginformname;
	}

	public String getLgsummaryuri()
	{
		return lgsummaryuri;
	}

	public String getLgsummaryname() throws SQLException
	{
		return getLayer(1).lgsummaryname;
	}

	public boolean isLbackdropauditing()
	{
		return lbackdropauditing;
	}

	public boolean isLexplainauditing()
	{
		return lexplainauditing;
	}

	public boolean isLevelauditing()
	{
		return levelauditing;
	}

	public String getStandarduri()
	{
		return standarduri;
	}

	public String getStandardname() throws SQLException
	{
		return getLayer(1).standardname;
	}

	public String getSweaveuri()
	{
		return sweaveuri;
	}

	public String getSweavename() throws SQLException
	{
		return getLayer(1).sweavename;
	}

	public String getSbackdropuri()
	{
		return sbackdropuri;
	}

	public String getSbackdropname() throws SQLException
	{
		return getLayer(1).sbackdropname;
	}

	public String getOtheruri()
	{
		return otheruri;
	}

	public String getOthername() throws SQLException
	{
		return getLayer(1).othername;
	}

	public String getOther2uri()
	{
		return other2uri;
	}

	public String getOther2name() throws SQLException
	{
		return getLayer(1).other2name;
	}

	// 项目负责人
	public String getSupermanager() throws SQLException
	{
		String supermanager = null;
		// 项目负责人角色的ID
		int adminrole_id_supermanager = tea.entity.admin.AdminRole.findByName(Item.ROLE_SUPERMANAGER, community);
		DbAdapter db = new DbAdapter();
		try
		{ // 拥有项目负责人角色并和项目在一个部门中.
			db.executeQuery("SELECT member FROM AdminUsrRole aur WHERE community=" + DbAdapter.cite(community) + " AND role LIKE " + DbAdapter.cite("%/" + adminrole_id_supermanager + "/%") + " AND unit=" + this.getEditgroup());
			if (db.next())
			{
				supermanager = db.getString(1);
			}
		} finally
		{
			db.close();
		}
		return supermanager;
	}

	public String getManager()
	{
		return manager;
	}

	public String getDirector()
	{
		return director;
	}

	public Date getOpentime()
	{
		return opentime;
	}

	public Date getIdeatime()
	{
		return ideatime;
	}

	public Date getFormulatingtime()
	{
		return formulatingtime;
	}

	public Date getLeveltime()
	{
		return leveltime;
	}

	public Date getStandardtime()
	{
		return standardtime;
	}

	public String getPlantask()
	{
		return plantask;
	}

	public String getOutlayapp()
	{
		return outlayapp;
	}

	public boolean isAdequate()
	{
		return adequate;
	}

	public String getDrafturi()
	{
		return drafturi;
	}

	public String getIdeainform2uri()
	{
		return ideainform2uri;
	}

	public String getFinform2uri()
	{
		return finform2uri;
	}

	public boolean isDraftnext()
	{
		return draftnext;
	}

	public String getAreporturi_3()
	{
		return areporturi_3;
	}

	public String getAreporturi_4()
	{
		return areporturi_4;
	}

	public String getAreporturi_5()
	{
		return areporturi_5;
	}

	public String getAreporturi_6()
	{
		return areporturi_6;
	}

	public boolean isOpenauditing()
	{
		return openauditing;
	}

	public boolean isLweaveauditing()
	{
		return lweaveauditing;
	}

	public String getAreportname_6() throws SQLException
	{
		return getLayer(1).areportname_6;
	}

	public String getAreportname_5() throws SQLException
	{
		return getLayer(1).areportname_5;
	}

	public String getAreportname_4() throws SQLException
	{
		return getLayer(1).areportname_4;
	}

	public String getAreportname_3() throws SQLException
	{
		return getLayer(1).areportname_3;
	}

	public String getFinform2name() throws SQLException
	{
		return getLayer(1).finform2name;
	}

	public String getIdeainform2name() throws SQLException
	{
		return getLayer(1).ideainform2name;
	}

	public String getDraftname() throws SQLException
	{
		return getLayer(1).draftname;
	}

	public String getUpdatetimeToString()
	{
		return sdf.format(updatetime);
	}

	public String getInittimeToString()
	{
		if (inittime == null)
		{
			return "";
		}
		return sdf.format(inittime);
	}

	public String getTimeToString()
	{
		if (time == null)
		{
			return "";
		}
		return sdf.format(time);
	}

	public static int countByCommunity(String community, int type) throws SQLException
	{
		int j = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(community) FROM Item WHERE community=" + DbAdapter.cite(community) + " AND type=" + type);
			if (db.next())
			{
				j = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return j;
	}

	public void setDirector(String director) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Item SET director=" + DbAdapter.cite(director) + " WHERE item = " + item);
		} finally
		{
			db.close();
		}
		this.director = director;
	}

	public void setPrincipal(String principal) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Item SET principal=" + DbAdapter.cite(principal) + " WHERE item = " + item);
		} finally
		{
			db.close();
		}
		this.principal = principal;
	}

	public void setStates(int states) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Item SET states=" + states + " WHERE item = " + item);
		} finally
		{
			db.close();
		}
		this.states = states;
	}

	// 是否现行标准
	public void setNonce(boolean nonce) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Item SET nonce=" + (nonce ? "1" : "0") + " WHERE item = " + item);
		} finally
		{
			db.close();
		}
		this.nonce = nonce;
	}

	public void setAdequate(boolean adequate) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Item SET adequate=" + (adequate ? "1" : "0") + " WHERE item=" + item);
		} finally
		{
			db.close();
		}
		this.adequate = adequate;
	}

	public static int clear(String community) throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			count = db.executeUpdate("DELETE FROM Item WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
		_cache.clear();
		return count;
	}
}
