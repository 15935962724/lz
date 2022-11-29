package tea.entity.admin.sales;

import java.io.*;
import java.util.Date;
import tea.db.DbAdapter;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.admin.Applys;
import tea.entity.admin.Bulletin;

public class Saleschance extends Entity
{
	// 定义变量，容器
	public static Cache _cache = new Cache(100);
	private int id;
	private String bschanceholder;// 客户机会所有者
	private String bschancename;// 客户机会名称
	private int clientname;// 客户名称
	private boolean clienttype;// true:客户,false:潜在客户
	private int type;// 类型和对应的数据用int
	private Date dates;// 时间
	private int moment;// 阶段
	private String chance;// 机会
	private String money;// 资金
	private int latencyclient;// 潜在客户
	private String nexts;// 下一步
	private String remark;// 备注
	private boolean exists;// 暂时没用到
	private String community;// 社区
	private String member;// 管理者 高级用户名
	private String bsupdatename;// 修改人记录
	private Date timelook;// 查看时间
	private Date timeupdate;// 修改时间
	private Date timecreate;// 创建时间

	// 定义字符串数组
	public static final String CLIENTTYPES[] = { "潜在客户", "客户" };
	public static final String TIMES[] = { "结束时间", "创建时间" };
	public static final String MOMENTS[] = { "-无-", "预期", "评价", "需求分析", "值建议", "选择决策者", "感性分析", "建议书/报价", "协商/审核", "已结束并赢得客户", "已结束但客户流失" };
	public static final String TYPES[] = { "-无-", "现有业务", "新业务" };
	public static final String ORIGIN[] = { "-无-", "广告", "职员引介", "外部引介", "合作伙伴", "公共关系", "研讨会-内部", "研讨会-合作伙伴", "贸易展览", "Web", "口头传达", "其他" };

	public Saleschance(int id) throws SQLException
	{
		this.id = id;
		load();
	}

	public static Saleschance find(int id) throws SQLException
	{
		return new Saleschance(id);
	}

	// 返回数据库中对应的全部字段
	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT bschanceholder,bschancename,clientname,type,dates,moment,chance,money,latencyclient,nexts,remark,community,member,bsupdatename,timelook,timeupdate,clienttype FROM Saleschance WHERE id=" + id);
			if (db.next())
			{
				bschanceholder = db.getString(1);
				bschancename = db.getString(2);
				clientname = db.getInt(3);
				type = db.getInt(4);
				dates = db.getDate(5);
				moment = db.getInt(6);
				chance = db.getString(7);
				money = db.getString(8);
				latencyclient = db.getInt(9);
				nexts = db.getString(10);
				remark = db.getString(11);
				community = db.getString(12);
				member = db.getString(13);
				bsupdatename = db.getString(14);
				timelook = db.getDate(15);
				timeupdate = db.getDate(16);
				clienttype = db.getInt(17) != 0;
				exists = true;
			} else
			{
				exists = false;
			}
		}  finally
		{
			db.close();
		}

	}

	// 插入数据
	public static int create(String bschanceholder, String bschancename, int clientname, boolean clienttype, int type, Date dates, int moment, String chance, String money, int latencyclient, String nexts, String remark, String community, RV _rv, String bsupdatename, Date timelook, Date timeupdate, Date timecreate) throws SQLException
	{
		Date timedate = new Date();
		timecreate = timedate;
		int id = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Saleschance(bschanceholder,bschancename,clientname,clienttype,type,dates,moment,chance,money,latencyclient,nexts,remark,community,member,bsupdatename,timelook,timeupdate,timecreate)VALUES" + "(" + DbAdapter.cite(bschanceholder) + "," + DbAdapter.cite(bschancename) + "," + clientname + "," + DbAdapter.cite(clienttype) + "," + type + "," + db.citeCurTime() + "," + moment + "," + DbAdapter.cite(chance) + "," + DbAdapter.cite(money) + "," + latencyclient + "," + DbAdapter.cite(nexts) + ","
					+ DbAdapter.cite(remark) + "," + DbAdapter.cite(community) + ",'" + _rv + "'," + DbAdapter.cite(bsupdatename) + "," + DbAdapter.cite(timelook) + "," + DbAdapter.cite(timeupdate) + "," + DbAdapter.cite(timecreate) + ")");
			id = db.getInt("SELECT MAX(id) FROM Saleschance");
		}  finally
		{
			db.close();
		}
		_cache.remove(new Integer(id));
		return id;
	}

	// 修改数据
	public void setUpdate(String bschanceholder, String bschancename, int clientname, boolean clienttype, int type, Date dates, int moment, String chance, String money, int latencyclient, String nexts, String remark, String community, RV _rv, String bsupdatename, Date timelook, Date timeupdate) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Saleschance SET bschanceholder=" + DbAdapter.cite(bschanceholder) + ",bschancename=" + DbAdapter.cite(bschancename) + ",clientname=" + clientname + ",clienttype=" + DbAdapter.cite(clienttype) + ",type=" + type + ",dates=" + DbAdapter.cite(dates) + ",moment=" + moment + ",chance=" + DbAdapter.cite(chance) + ",latencyclient=" + latencyclient + ",nexts=" + DbAdapter.cite(nexts) + ",money=" + DbAdapter.cite(money) + ",remark=" + DbAdapter.cite(remark) + " ,community=" + DbAdapter.cite(community) + ",member='" + _rv
					+ "' ,bsupdatename=" + DbAdapter.cite(bsupdatename) + " ,timelook=" + DbAdapter.cite(timelook) + " ,timeupdate=" + DbAdapter.cite(timeupdate) + " WHERE id =" + id);
		}  finally
		{
			db.close();
		}
		_cache.remove(new Integer(id));
	}

	// 删除
	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Saleschance WHERE id=" + id);
			System.out.print("DELETE FROM Saleschance WHERE id=" + id);} finally
		{
			db.close();
		}
		_cache.remove(new Integer(id));
	}

	// 修改查看时间，因为调用的比较多
	public void setTimelook() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Saleschance SET timelook=" + db.citeCurTime() + " WHERE id=" + id);} finally
		{
			db.close();
		}
		this.timelook = timelook;
	}

	// 枚举
	public static java.util.Enumeration findByCommunity(String community, String sql) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT id FROM Saleschance WHERE community=" + DbAdapter.cite(community) + sql);

			while (db.next())
			{
				vector.addElement(new Integer(db.getInt(1)));
			}} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static int count(String community, String sql) throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			count = db.getInt("SELECT COUNT(id) FROM Saleschance WHERE community=" + DbAdapter.cite(community) + sql);} finally
		{
			db.close();
		}
		return count;
	}

	public String getbschanceholder()
	{
		return bschanceholder;
	}

	public String getbscname()
	{

		return bschancename;
	}

	public int getClientname()
	{
		return clientname;

	}

	public int getType()
	{

		return type;
	}

	public Date getDates()
	{
		return dates;
	}

	public String getDatesToString()
	{
		if (dates == null)
			return "";
		return sdf.format(dates);
	}

	public int getMoment()
	{

		return moment;
	}

	public String getMoney()
	{/*
		 * java.math.BigDecimal bd=new java.math.BigDecimal(222); bd.add(arg0) bd.divide(arg0) bd.multiply(arg0) bd.subtract(arg0)
		 */
		return money;
	}

	public int getLatencyclient()
	{
		return latencyclient;
	}

	public String getNexts()
	{
		return nexts;
	}

	public String getRemark()
	{
		return remark;
	}

	public String getCommunity()
	{

		return community;
	}

	public boolean getexists()
	{
		return exists;
	}

	public String getMember()
	{

		return member;
	}

	public String getChance()
	{
		return chance;

	}

	public String getBsupdatename()
	{
		return bsupdatename;
	}

	public Date getTimelook()
	{
		return timelook;
	}

	public String getTimelookToString()
	{
		if (timelook == null)
			return "";
		return sdf.format(timelook);
	}

	public Date getTimeupdate()
	{
		return timeupdate;
	}

	public String getTimeupdateToString()
	{
		if (timeupdate == null)
			return "";
		return sdf.format(timeupdate);
	}

	public Date getTimecreate()
	{
		return timecreate;
	}

	public String getTimecreateToString()
	{
		if (timecreate == null)
			return "";
		return sdf.format(timecreate);
	}

	public boolean getClienttype()
	{

		return clienttype;
	}
}
