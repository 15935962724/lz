package tea.entity.node;

import java.util.Date;
import tea.entity.Cache;
import java.sql.SQLException;
import tea.db.DbAdapter;

public class Orders
{
	private static Cache _cache = new Cache(100);
	private String member;
	private String address;
	private String postalcode;
	private String linkman;
	private String phone;
	private String payment;
	private int waittime;
	private String sendtime;
	private String invoice;
	private String tax;
	private String accounts;
	private String invoicerise;
	private String invoiceaddress;
	private String remark;
	private String mail;
	private Date time;
	private boolean exists;

	public Orders()
	{
	}

	public static Orders find(String member, Date time) throws SQLException
	{
		Orders obj = (Orders) _cache.get(member + ":" + String.valueOf(time.getTime()));
		if (obj == null)
		{
			obj = new Orders(member, time);
			_cache.put(member + ":" + String.valueOf(time.getTime()), obj);
		}
		return obj;
	}

	public Orders(String member, Date time) throws SQLException
	{
		this.member = member;
		this.time = time;
		loadBasic();
	}

	public void set() throws SQLException
	{
		DbAdapter db = null;
		try
		{
			if (this.isExists())
			{
				/*
				 * db = new DbAdapter(); db.executeUpdate("LFinancingEdit " + node + "," + DbAdapter.cite(id) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(essence) + "," + DbAdapter.cite(reside) + "," + DbAdapter.cite(area) + "," + DbAdapter.cite(synopsis) + "," + DbAdapter.cite(future) + "," + DbAdapter.cite(allmoney) + "," + DbAdapter.cite(financingmoney) + "," + DbAdapter.cite(investcallback) + "," + DbAdapter.cite(redound) + "," + DbAdapter.cite(yearrestrict) + "," +
				 * DbAdapter.cite(fashion) + "," + DbAdapter.cite(unitname) + "," + DbAdapter.cite(unitessence) + "," + DbAdapter.cite(unitsynopsis) + "," + DbAdapter.cite(linkman) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(postalcode) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(issuedate) + "," + language + "," + DbAdapter.cite(evolve) + "," + DbAdapter.cite(idcard) + "," + DbAdapter.cite(homeplace) + "," +
				 * DbAdapter.cite(website)); this.loadBasic(); _cache.put(node + ":" + language, this);
				 */
			} else
				create();
		} finally
		{
			if (db != null)
				db.close();
		}
	}

	public void create() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			/*
			 * db.executeUpdate("OrdersCreate " + DbAdapter.cite(member) + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(postalcode) + "," + DbAdapter.cite(linkman) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(payment) + "," + (waittime) + "," + DbAdapter.cite(sendtime) + "," + DbAdapter.cite(invoice) + "," + DbAdapter.cite(tax) + "," + DbAdapter.cite(accounts) + "," + DbAdapter.cite(invoicerise) + "," + DbAdapter.cite(invoiceaddress) + "," +
			 * DbAdapter.cite(remark) + "," + DbAdapter.cite(mail) );
			 */
			db.executeUpdate("INSERT Orders(member        ,time,address       ,postalcode    ,linkman       ,phone         ,payment       ,waittime      ,sendtime      ,invoice       ,tax           ,accounts      ,invoicerise   ,invoiceaddress,remark        ,mail          )VALUES(" + DbAdapter.cite(member) + "        ," + DbAdapter.cite(time) + "," + DbAdapter.cite(address) + "       ," + DbAdapter.cite(postalcode) + "    ," + DbAdapter.cite(linkman) + "       ," + DbAdapter.cite(phone) + "         ,"
					+ DbAdapter.cite(payment) + "       ," + (waittime) + "      ," + DbAdapter.cite(sendtime) + "      ," + DbAdapter.cite(invoice) + "       ," + DbAdapter.cite(tax) + "           ," + DbAdapter.cite(accounts) + "      ," + DbAdapter.cite(invoicerise) + "   ," + DbAdapter.cite(invoiceaddress) + "," + DbAdapter.cite(remark) + "        ," + DbAdapter.cite(mail) + "          )");
			PShoppingCarts.setStatus(member, true);
			this.loadBasic();
			_cache.put(member + ":" + String.valueOf(time.getTime()), this);
		} finally
		{
			db.close();
		}
	}

	public static java.util.Enumeration findByMember(String member) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		java.util.Vector vector = new java.util.Vector();
		try
		{
			db.executeQuery("SELECT time FROM Orders WHERE member=" + DbAdapter.cite(member));
			while (db.next())
				vector.addElement(db.getDate(1));
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	private void loadBasic() throws SQLException
	{
		// if (!_blLoaded)
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT   		address   ,postalcode,linkman   ,phone, 	payment   ,waittime  ,sendtime  ,invoice   ,tax,   	accounts  ,invoicerise  , 	invoiceaddress,	remark,	mail	FROM Orders WHERE member=" + DbAdapter.cite(member) + " AND time=" + DbAdapter.cite(time));
				if (db.next())
				{
					address = db.getVarchar(1, 1, 1);
					postalcode = db.getVarchar(1, 1, 2);
					// 已有语言,要显示出的语言,列的索引
					linkman = db.getVarchar(1, 1, 3);
					phone = db.getVarchar(1, 1, 4);
					payment = db.getVarchar(1, 1, 5);
					waittime = db.getInt(6);
					sendtime = db.getVarchar(1, 1, 7);
					invoice = db.getVarchar(1, 1, 8);
					tax = db.getVarchar(1, 1, 9);
					accounts = db.getVarchar(1, 1, 10);
					invoicerise = db.getVarchar(1, 1, 11);
					invoiceaddress = db.getVarchar(1, 1, 12);
					remark = db.getVarchar(1, 1, 13);
					mail = db.getVarchar(1, 1, 14);
					exists = true;
				} else
				{
					exists = false;
				}
			} finally
			{
				db.close();
			}
			// _blLoaded = true;
		}
	}

	public void setMember(String member)
	{
		this.member = member;
	}

	public void setAddress(String address)
	{
		this.address = address;
	}

	public void setPostalcode(String postalcode)
	{
		this.postalcode = postalcode;
	}

	public void setLinkman(String linkman)
	{
		this.linkman = linkman;
	}

	public void setPhone(String phone)
	{
		this.phone = phone;
	}

	public void setPayment(String payment)
	{
		this.payment = payment;
	}

	public void setWaittime(int waittime)
	{
		this.waittime = waittime;
	}

	public void setSendtime(String sendtime)
	{
		this.sendtime = sendtime;
	}

	public void setInvoice(String invoice)
	{
		this.invoice = invoice;
	}

	public void setTax(String tax)
	{
		this.tax = tax;
	}

	public void setAccounts(String accounts)
	{
		this.accounts = accounts;
	}

	public void setInvoicerise(String invoicerise)
	{
		this.invoicerise = invoicerise;
	}

	public void setInvoiceaddress(String invoiceaddress)
	{
		this.invoiceaddress = invoiceaddress;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}

	public void setMail(String mail)
	{
		this.mail = mail;
	}

	public void setTime(Date time)
	{
		this.time = time;
	}

	public String getMember()
	{
		return member;
	}

	public String getAddress()
	{
		return address;
	}

	public String getPostalcode()
	{
		return postalcode;
	}

	public String getLinkman()
	{
		return linkman;
	}

	public String getPhone()
	{
		return phone;
	}

	public String getPayment()
	{
		return payment;
	}

	public int getWaittime()
	{
		return waittime;
	}

	public String getSendtime()
	{
		return sendtime;
	}

	public String getInvoice()
	{
		return invoice;
	}

	public String getTax()
	{
		return tax;
	}

	public String getAccounts()
	{
		return accounts;
	}

	public String getInvoicerise()
	{
		return invoicerise;
	}

	public String getInvoiceaddress()
	{
		return invoiceaddress;
	}

	public String getRemark()
	{
		return remark;
	}

	public String getMail()
	{
		return mail;
	}

	public Date getTime()
	{
		return time;
	}

	public boolean isExists()
	{
		return exists;
	}

}
