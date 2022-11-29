package tea.entity.member;

import java.math.*;
import java.util.*;

import tea.db.DbAdapter;
import tea.entity.*;
import java.text.*;
import java.io.*;
import java.sql.SQLException;

public class SMSMoney extends Entity
{
	public static BigDecimal SMS_PRICE = new BigDecimal("0.1");

	public static DecimalFormat df = new DecimalFormat("0.00");

	private static Cache _cache = new Cache(100);
	private int smsmoney;
	private String member;
	private String community;
	private Date starttime;
	private Date endtime;
	private BigDecimal money; // 本次,充值金额
	private BigDecimal summoney;
	private int payout; // 本次,发送次数
	private boolean exists;

	public SMSMoney(int smsmoney) throws SQLException
	{
		this.smsmoney = smsmoney;
		load();
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT member,community,starttime,endtime,money,summoney,payout FROM SMSMoney WHERE smsmoney=" + smsmoney);
			if (db.next())
			{
				member = db.getString(1);
				community = db.getString(2);
				starttime = db.getDate(3);
				endtime = db.getDate(4);
				money = db.getBigDecimal(5, 2);
				summoney = db.getBigDecimal(6, 2);
				payout = db.getInt(7);
				exists = true;
			} else
			{
				exists = false;
				summoney = money = new BigDecimal(0);
			}
		}  finally
		{
			db.close();
		}
	}

	public static BigDecimal getBalance(String member, String community) throws SQLException
	{
		int k = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			k = db.getInt("SELECT MAX(smsmoney) FROM SMSMoney WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
		return find(k).getBalance();
	}

	public BigDecimal getPrevBalance() throws SQLException
	{
		int k = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			k = db.getInt("SELECT MAX(smsmoney) FROM SMSMoney WHERE smsmoney<" + smsmoney + " AND member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
		return find(k).getBalance();
	}

	// 总余额
	public BigDecimal getBalance() throws SQLException
	{
		// 取自动回复的次数
		SMSProfile sp = SMSProfile.find(member, community);
		int value = 0;
		StringBuilder sb = new StringBuilder();
		try
		{
			java.net.URL url = new java.net.URL("http://sms.redcome.com/servlet/GetReverseCount?subcode=" + sp.getCode() + "&password=" + sp.getPassword());
			java.io.InputStream is = url.openStream();
			while ((value = is.read()) != -1)
			{
				sb.append((char) value);
			}
			is.close();
		} catch (IOException ex)
		{
			throw new SQLException(ex.getMessage());
		}
		value = Integer.parseInt(sb.toString().trim());
		if (value > 0)
		{
			setPayout(payout + value);
		}
		return summoney.subtract(SMS_PRICE.multiply(new BigDecimal(payout)));
	}

	public BigDecimal getSummoney() throws SQLException
	{
		return summoney;
	}

	public static java.util.Enumeration findByMember(String member, String community) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT smsmoney FROM SMSMoney WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community));
			while (db.next())
			{
				vector.addElement(new java.lang.Integer(db.getInt(1)));
			}
		}  finally
		{
			db.close();
		}
		return vector.elements();
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM SMSMoney WHERE smsmoney=" + smsmoney);
		}  finally
		{
			db.close();
		}
		_cache.remove(new Integer(smsmoney));
	}

	public void set(String member, String community, java.util.Date starttime, java.util.Date endtime, BigDecimal money, BigDecimal summoney, int payout) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			int j = db.executeUpdate("UPDATE SMSMoney SET starttime=" + DbAdapter.cite(starttime) + ",endtime=" + DbAdapter.cite(endtime) + ",money=" + df.format(money) + ",summoney=" + df.format(summoney) + " WHERE smsmoney=" + smsmoney);
			if (j < 1)
			{
				db.executeUpdate("INSERT INTO SMSMoney(member,community,starttime,endtime,money,summoney,payout)VALUES(" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + DbAdapter.cite(starttime) + "," + DbAdapter.cite(endtime) + "," + df.format(money) + "," + df.format(summoney) + "," + payout + ")");
			} else
			{
				this.starttime = starttime;
				this.endtime = endtime;
				this.money = money;
				this.summoney = summoney;
			}
		}  finally
		{
			db.close();
		}
	}

	public static SMSMoney find(int smsmoney) throws SQLException
	{
		SMSMoney obj = (SMSMoney) _cache.get(new Integer(smsmoney));
		if (obj == null)
		{
			obj = new SMSMoney(smsmoney);
			_cache.put(new Integer(smsmoney), obj);
		}
		return obj;
	}

	public static SMSMoney find(String member, String community) throws SQLException
	{
		/*
		 * if ("webmaster".equals(member)) { community = "Home"; }
		 */
		int k = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			k = db.getInt("SELECT smsmoney FROM SMSMoney WHERE member=" + DbAdapter.cite(member) + " AND community=" + DbAdapter.cite(community) + " ORDER BY smsmoney DESC");
		} finally
		{
			db.close();
		}
		return find(k);
	}

	public int getSmsmoney()
	{
		return smsmoney;
	}

	public String getMember()
	{
		return member;
	}

	public Date getStarttime()
	{
		return starttime;
	}

	public String getStarttimeToString()
	{
		return sdf.format(starttime);
	}

	public Date getEndtime()
	{
		return endtime;
	}

	public String getEndtimeToString()
	{
		return sdf.format(endtime);
	}

	public BigDecimal getMoney()
	{
		return money;
	}

	public int getPayout()
	{
		return payout;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getCommunity()
	{
		return community;
	}

	public void setPayout(int payout) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE SMSMoney SET payout=" + payout + " WHERE smsmoney=" + smsmoney);
		}  finally
		{
			db.close();
		}
		this.payout = payout;
	}
}
