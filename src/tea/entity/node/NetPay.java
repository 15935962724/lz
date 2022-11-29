package tea.entity.node;

import java.util.*;
import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class NetPay extends tea.entity.Entity
{
	private boolean exists;
	private String account;
	private float money;
	private Date date;

	public String getAccount()
	{
		return account;
	}

	public void setAccount(String account)
	{
		this.account = account;
	}

	public NetPay(String account) throws SQLException
	{
		this.account = account;
		loadBasic();
	}

	public static NetPay find(String account) throws SQLException
	{
		return new NetPay(account);
	}

	public float getMoney()
	{
		return money;
	}

	public Date getDate()
	{
		return date;
	}

	public boolean exists()
	{
		return exists;
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT money,date FROM NetPay WHERE account=" + DbAdapter.cite(account));
			if (db.next())
			{
				money = db.getByte(1);
				date = db.getDate(2);
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

	public static void create(String account, float money, java.util.Date date) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO NetPay (account,money,date)VALUES(" + DbAdapter.cite(account) + "," + money + "," + DbAdapter.cite(date) + ")");
		} finally
		{
			db.close();
		}
	}
}
