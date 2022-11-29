package tea.entity.criterion;

import java.util.Date;
import java.sql.SQLException;
import tea.db.DbAdapter;
import tea.entity.*;

public class Expertres extends Entity
{
	public static Cache _cache = new Cache(100);
	public static final String CALLING_TYPE[] = { "水泥", "钢铁", "石油", "玻璃" };
	public static final String SPECIALTY_TYPE[] = { "废水", "大气", "噪声", "固废", "生态", "土壤", "放射性" };
	private int expertres;
	private String name;
	private String unit;
	private int calling;
	private String specialty;
	private String duty;
	private String title;
	private String phone;
	private String mobile;
	private String email;
	private String zip;
	private String bookname;
	private String bookconcern;
	private Date issuetime;
	private String article;
	private String magazine;
	private Date appeartime;
	private Date birthtime;
	private String degree;
	private String experience;
	private String address;
	private String fax;

	public Expertres(int expertres) throws SQLException
	{
		this.expertres = expertres;
		load();
	}

	public static Expertres find(int expertres) throws SQLException
	{
		Expertres obj = (Expertres) _cache.get(new Integer(expertres));
		if (obj == null)
		{
			obj = new Expertres(expertres);
			_cache.put(new Integer(expertres), obj);
		}
		return obj;
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT name,unit,calling,specialty,duty,title,phone,mobile,email,zip,bookname,bookconcern,issuetime,article,magazine,appeartime,birthtime,degree,experience,address,fax FROM Expertres WHERE expertres=" + expertres);
			if (db.next())
			{
				name = db.getString(1);
				unit = db.getString(2);
				calling = db.getInt(3);
				specialty = db.getString(4);
				duty = db.getString(5);
				title = db.getString(6);
				phone = db.getString(7);
				mobile = db.getString(8);
				email = db.getString(9);
				zip = db.getString(10);
				bookname = db.getText(11);
				bookconcern = db.getString(12);
				issuetime = db.getDate(13);
				article = db.getString(14);
				magazine = db.getString(15);
				appeartime = db.getDate(16);
				birthtime = db.getDate(17);
				degree = db.getString(18);
				experience = db.getText(19);
				address = db.getString(20);
				fax = db.getString(21);
			}
		} finally
		{
			db.close();
		}
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE Expertres WHERE expertres=" + expertres);
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(expertres));
	}

	public static java.util.Enumeration find(String sql) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT expertres FROM Expertres WHERE 1=1 " + sql);
			while (db.next())
			{
				vector.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		return vector.elements();
	}

	public static int create(String name, String unit, int calling, String specialty, String duty, String title, String phone, String fax, String mobile, String email, String zip, String bookname, String bookconcern, Date issuetime, String article, String magazine, Date appeartime, Date birthtime, String degree, String experience, String address) throws SQLException
	{
		int expertres = 0;
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Expertres(name,unit,calling,specialty,duty,title,phone,fax,mobile,email,zip,bookname,bookconcern,issuetime,article,magazine,appeartime,birthtime,degree,experience,address) VALUES(" + DbAdapter.cite(name) + "," + DbAdapter.cite(unit) + "," + (calling) + "," + DbAdapter.cite(specialty) + "," + DbAdapter.cite(duty) + "," + DbAdapter.cite(title) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(mobile) + ","
					+ DbAdapter.cite(email) + "," + DbAdapter.cite(zip) + "," + DbAdapter.cite(bookname) + "," + DbAdapter.cite(bookconcern) + "," + DbAdapter.cite(issuetime) + "," + DbAdapter.cite(article) + "," + DbAdapter.cite(magazine) + "," + DbAdapter.cite(appeartime) + "," + DbAdapter.cite(birthtime) + "," + DbAdapter.cite(degree) + "," + DbAdapter.cite(experience) + "," + DbAdapter.cite(address) + ")");
			db.executeQuery("SELECT MAX(expertres) FROM Expertres");
			if (db.next())
			{
				expertres = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return expertres;
	}

	public void set(String name, String unit, int calling, String specialty, String duty, String title, String phone, String fax, String mobile, String email, String zip, String bookname, String bookconcern, Date issuetime, String article, String magazine, Date appeartime, Date birthtime, String degree, String experience, String address) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Expertres SET name=" + DbAdapter.cite(name) + ",unit=" + DbAdapter.cite(unit) + ",calling=" + calling + ",specialty=" + DbAdapter.cite(specialty) + ",duty=" + DbAdapter.cite(duty) + ",title =" + DbAdapter.cite(title) + ",phone=" + DbAdapter.cite(phone) + ",fax=" + DbAdapter.cite(fax) + ",mobile=" + DbAdapter.cite(mobile) + ",email =" + DbAdapter.cite(email) + ",zip=" + DbAdapter.cite(zip) + ",bookname=" + DbAdapter.cite(bookname) + ",bookconcern ="
					+ DbAdapter.cite(bookconcern) + ",issuetime=" + DbAdapter.cite(issuetime) + ",article=" + DbAdapter.cite(article) + ",magazine =" + DbAdapter.cite(magazine) + ",appeartime=" + DbAdapter.cite(appeartime) + ",birthtime=" + DbAdapter.cite(birthtime) + ",degree=" + DbAdapter.cite(degree) + ",experience=" + DbAdapter.cite(experience) + ",address=" + DbAdapter.cite(address) + " WHERE expertres=" + expertres);
		} finally
		{
			db.close();
		}
		this.name = name;
		this.unit = unit;
		this.calling = calling;
		this.specialty = specialty;
		this.duty = duty;
		this.title = title;
		this.phone = phone;
		this.fax = fax;
		this.mobile = mobile;
		this.email = email;
		this.zip = zip;
		this.bookname = bookname;
		this.bookconcern = bookconcern;
		this.issuetime = issuetime;
		this.article = article;
		this.magazine = magazine;
		this.appeartime = appeartime;
		this.birthtime = birthtime;
		this.degree = degree;
		this.experience = experience;
		this.address = address;
		// _cache.remove(new Integer(expertres));
	}

	public int getExpertres()
	{
		return expertres;
	}

	public String getName()
	{
		return name;
	}

	public String getUnit()
	{
		return unit;
	}

	public int getCalling()
	{
		return calling;
	}

	public String getSpecialty()
	{
		return specialty;
	}

	public String getDuty()
	{
		return duty;
	}

	public String getTitle()
	{
		return title;
	}

	public String getPhone()
	{
		return phone;
	}

	public String getMobile()
	{
		return mobile;
	}

	public String getEmail()
	{
		return email;
	}

	public String getZip()
	{
		return zip;
	}

	public String getBookname()
	{
		return bookname;
	}

	public String getBookconcern()
	{
		return bookconcern;
	}

	public Date getIssuetime()
	{
		return issuetime;
	}

	public String getArticle()
	{
		return article;
	}

	public String getMagazine()
	{
		return magazine;
	}

	public Date getAppeartime()
	{
		return appeartime;
	}

	public Date getBirthtime()
	{
		return birthtime;
	}

	public String getDegree()
	{
		return degree;
	}

	public String getExperience()
	{
		return experience;
	}

	public String getAddress()
	{
		return address;
	}

	public String getFax()
	{
		return fax;
	}
}
