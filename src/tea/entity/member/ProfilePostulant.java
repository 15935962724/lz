package tea.entity.member;

import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class ProfilePostulant extends Entity
{
	public static Cache _cache = new Cache(100);
	public static final String CITY_TYPE[][] = { { "东城区", "和平里街道", "东直门街道", "安定门街道", "交道口街道", "景山街道", "东华门街道", "建国门街道", "朝阳门街道", "东四街道", "北新桥街道" }, { "西城区", "什刹海街道", "金融街街道", "月坛街道", "展览路街道", "新街口街道", "德胜街道", "西长安街街道" }, { "崇文区", "前门街道", "崇外街道", "东花市街道", "天坛街道", "体育馆路街道", "龙潭街道", "永外街道", "永定门外街道" }, { "宣武区", "广外街道", "广内街道", "牛街街道", "白纸坊街道", "大栅栏街道", "椿树街道", "陶然亭街道", "天桥街道" },
			{ "朝阳区", "东坝乡", "常营地区", "十八里店地区", "东风地区", "豆各庄乡", "小红门地区", "管庄地区街道办事处", "黑庄户乡", "平房地区", "王四营乡", "崔各庄乡", "南皋乡", "来广营地区", "洼里地区", "金盏地区", "朝外街道", "建外街道", "呼家楼街道", "八里庄街道", "三里屯街道", "团结湖街道", "双井街道", "劲松街道", "垡头街道", "左家庄街道", "小关街道", "和平街街道", "酒仙桥街道", "潘家园街道", "安贞街道", "麦子店街道", "六里屯街道", "香河园街道", "亚运村街道", "南磨房地区", "高碑店地区", "将台地区", "太阳宫地区", "大屯地区", "望京街道", "三间房地区", "管庄地区", "奥运村地区", "机场街道", "三间房地区com:", "东湖街道办事处筹备处" },
			{ "海淀区", "马连洼街道", "西三旗街道", "花园路街道", "上地街道", "永定路街道", "清华园街道", "燕园街道", "温泉镇", "万寿路街道", "羊坊店街道", "甘家口街道", "（西）八里庄街道", "紫竹院街道", "北下关街道", "学院路街道", "中关村街道", "海淀街道", "青龙桥街道", "清河街道", "香山街道", "万柳地区", "田村路街道", "北太平庄街道", "东升地区", "曙光街道", "西北旺镇", "苏家坨镇" }, { "丰台区", "马家堡街道", "和义街道", "丰台街道", "卢沟桥街道", "太平桥街道", "新村街道", "南苑街道", "东高地街道", "大红门街道", "右安门街道", "西罗园街道", "东铁匠营街道", "长辛店街道", "云岗街道", "方庄街道", "宛平城街道" },
			{ "石景山区", "老山街道", "八角街道", "八宝山街道", "苹果园街道", "古城街道", "鲁谷社区行政事务管理中心", "五里坨街道", "金顶街街道", "广宁街道" }, { "门头沟区", "大台街道", "城子街道", "大峪街道", "东辛房街道", "王平地区", "龙泉镇", "永定镇", "斋堂镇", "雁翅镇", "军庄镇" }, { "房山区", "良乡地区", "城关街道", "新镇街道", "东风街道", "迎风街道", "星城街道", "周口店地区", "向阳街道", "琉璃河地区", "阎村镇", "青龙湖镇", "长阳镇", "大安山乡", "河北镇", "石楼镇", "长沟镇", "窦店镇", "韩村河" }, { "通州区", "北苑街道", "玉桥街道", "中仓街道", "新华街道", "潞城镇", "永顺镇" }, { "昌平区", "城北街道", "马池口镇", "沙河镇", "南口镇", "城南街道", "十三陵镇", "小汤山镇", "回龙观镇", "阳坊镇", "东小口镇", "北七家镇" },
			{ "大兴区", "清源街道", "兴丰街道", "林校路街道", "旧宫镇", "亦庄镇", "黄村镇", "西红门地区" }, { "怀柔区", "泉河街道", "龙山街道", "庙城镇", "杨宋镇", "北房镇", "汤河口镇", "雁栖镇" }, { "顺义区", "胜利街道", "光明街道", "杨镇地区", "天竺地区", "牛栏山地区", "马坡地区", "李桥镇", "南彩镇", "北小营镇", "石园街道", "仁和地区", "天竺镇", "后沙峪地区", "南法信地区", "高丽营镇", "张镇", "天房镇" }, { "密云县", "鼓楼街道", "西田各庄镇", "太师屯镇", "不老屯镇", "十里堡镇", "溪翁庄镇", "古北口镇", "穆家峪镇", "檀营乡", "巨各庄镇", "果园街道", "密云镇" }, { "平谷区", "兴谷街道", "滨河街道", "渔阳地区" }, { "延庆县", "延庆镇" } };
	public static final String SIGNUP_TYPE[] = { "网上报名", "电话报名", "寄信报名" };
	private int cityzone;
	private int street;
	private String comm;
	private String saddress; // 备用地址
	private String event; // 能否经常参加活动 必填【能、周末、否、其他（留言）】
	private String info; // 能否经常提供信息 必填【能、周末、否、其他（留言）】
	private int stype; // 报名方式(网上报名,电话报名,邮件报名)
	private String remark;
	private boolean auditing;
	private String member;
	private String community;
	private boolean exists;
	private String code;
	private int point;

	public ProfilePostulant(String _strMember, String community) throws SQLException
	{
		this.member = _strMember;
		this.community = community;
		load();
	}

	private void load() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT cityzone,street,comm,saddress,event,info,stype,remark,auditing,code,point FROM ProfilePostulant WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
			if (dbadapter.next())
			{
				cityzone = dbadapter.getInt(1);
				street = dbadapter.getInt(2);
				comm = dbadapter.getString(3);
				saddress = dbadapter.getString(4);
				event = dbadapter.getString(5);
				info = dbadapter.getString(6);
				stype = dbadapter.getInt(7);
				remark = dbadapter.getString(8);
				auditing = dbadapter.getInt(9) != 0;
				code = dbadapter.getString(10);
				point = dbadapter.getInt(11);
				exists = true;
			} else
			{
				exists = false;
			}
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
	}

	public static void create(String member, String community, int cityzone, int street, String comm, String saddress, String event, String info, int stype, String remark) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("INSERT INTO ProfilePostulant(member,community,cityzone,street,comm,saddress,event,info,stype,remark)VALUES(" + DbAdapter.cite(member) + ", " + DbAdapter.cite(community) + ", " + cityzone + ", " + (street) + ", " + DbAdapter.cite(comm) + ", " + DbAdapter.cite(saddress) + ", " + DbAdapter.cite(event) + ", " + DbAdapter.cite(info) + ", " + stype + ", " + DbAdapter.cite(remark) + ")");
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
		_cache.remove(member + ":" + community);
	}

	public void set(int cityzone, int street, String comm, String saddress, String event, String info, int stype, String remark) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("UPDATE ProfilePostulant SET cityzone=" + cityzone + ",street=" + (street) + ",comm=" + DbAdapter.cite(comm) + ",saddress=" + DbAdapter.cite(saddress) + ",event=" + DbAdapter.cite(event) + ",info=" + DbAdapter.cite(info) + ",stype=" + stype + ",remark=" + DbAdapter.cite(remark) + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
		this.cityzone = cityzone;
		this.street = street;
		this.comm = comm;
		this.saddress = saddress;
		this.event = event;
		this.info = info;
		this.stype = stype;
		this.remark = remark;
	}

	public static ProfilePostulant find(String _strMember, String community) throws SQLException
	{
		ProfilePostulant profile = (ProfilePostulant) _cache.get(_strMember + ":" + community);
		if (profile == null)
		{
			profile = new ProfilePostulant(_strMember, community);
			_cache.put(_strMember + ":" + community, profile);
		}
		return profile;
	}

	public static java.util.Enumeration find(String community, String sql, int pos, int pagesize) throws SQLException
	{
		java.util.Vector v = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT member FROM ProfilePostulant WHERE community=" + DbAdapter.cite(community) + sql);
			for (int l = 0; l < pos + pagesize && db.next(); l++)
			{
				if (l >= pos)
				{
					v.addElement(db.getString(1));
				}
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public static int count(String community, String sql) throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT COUNT(member) FROM ProfilePostulant WHERE community=" + DbAdapter.cite(community) + sql);
			if (db.next())
			{
				count = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return count;
	}

	public int getCityzone()
	{
		return cityzone;
	}

	public int getStreet()
	{
		return street;
	}

	public String getComm()
	{
		return comm;
	}

	public String getSaddress()
	{
		return saddress;
	}

	public String getEvent()
	{
		return event;
	}

	public String getInfo()
	{
		return info;
	}

	public int getStype()
	{
		return stype;
	}

	public String getRemark()
	{
		return remark;
	}

	public boolean isAuditing()
	{
		return auditing;
	}

	public String getMember()
	{
		return member;
	}

	public String getCommunity()
	{
		return community;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getCode()
	{
		return code;
	}

	public int getPoint()
	{
		return point;
	}

	public static boolean isExists(String code, String community) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeQuery("SELECT member FROM ProfilePostulant WHERE community=" + DbAdapter.cite(community) + " AND code=" + DbAdapter.cite(code));
			return dbadapter.next();
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
	}

	public void delete() throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("DELETE FROM ProfilePostulant WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
		_cache.remove(member + ":" + community);
		exists = false;
	}

	public void setPoint(int point) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("UPDATE ProfilePostulant SET point=" + point + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
		this.point = point;
	}

	public void setAuditing(boolean auditing) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("UPDATE ProfilePostulant SET auditing=" + DbAdapter.cite(auditing) + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
		this.auditing = auditing;
	}

	public void setCode(String code) throws SQLException
	{
		DbAdapter dbadapter = new DbAdapter();
		try
		{
			dbadapter.executeUpdate("UPDATE ProfilePostulant SET code=" + DbAdapter.cite(code) + " WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
		} catch (Exception exception1)
		{
			throw new SQLException(exception1.toString());
		} finally
		{
			dbadapter.close();
		}
		this.code = code;
	}
}
