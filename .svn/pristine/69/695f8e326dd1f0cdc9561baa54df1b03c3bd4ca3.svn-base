package tea.entity.node;

import java.io.*;

import tea.db.DbAdapter;
import tea.entity.Cache;
import java.sql.SQLException;

public class ERegister implements Serializable
{
	private static Cache _cache = new Cache(100);
	private String name;
	private String sex;
	private java.util.Date birthday;
	private String blood;
	private String cardType;
	private String cardNum;
	private String workPlace;
	private String job;
	private String email;
	private String address;
	private String phone;
	private String fax;
	private String mobile;
	private String richDate;
	private String richTime;
	private String flightNum;
	private String trainNum;
	private String welcome;
	private String subject;
	private String addition;
	private String employee;
	private int node;
	private int language;
	private boolean exists;
	private String nationality;
	private String middle;
	private String postal;
	private String place;
	private String date2;
	private String time;
	private String port;
	private String departure;
	private String airport;
	private String document;
	private String title;
	private String groups;
	private boolean isfile;
	private String expiration;
	private String departuredate2;
	private String departuretime;
	private String departureflight;
	private String departuretrain;
	private boolean auditing;
	private String member;

	public static ERegister find(int node, int language) throws SQLException
	{
		ERegister obj = (ERegister) _cache.get(node + ":" + language);
		if (obj == null)
		{
			obj = new ERegister(node, language);
			_cache.put(node + ":" + language, obj);
		}
		return obj;
	}

	public ERegister(int node, int language) throws SQLException
	{
		this.node = node;
		this.language = language;
		loadBasic();
	}

	public void set() throws SQLException
	{
		if (this.isExists())
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeUpdate("UPDATE ERegister SET name=" + DbAdapter.cite(name) + ",sex=" + DbAdapter.cite(sex) + ",birthday=" + DbAdapter.cite(birthday) + ",blood=" + DbAdapter.cite(blood) + ",cardType=" + DbAdapter.cite(cardType) + ",cardNum=" + DbAdapter.cite(cardNum) + ",workPlace=" + DbAdapter.cite(workPlace) + ",job=" + DbAdapter.cite(job) + ",email=" + DbAdapter.cite(email) + ",address=" + DbAdapter.cite(address) + ",phone=" + DbAdapter.cite(phone) + ",fax=" + DbAdapter.cite(fax)
						+ ",mobile=" + DbAdapter.cite(mobile) + ",richDate=" + DbAdapter.cite(richDate) + ",richTime=" + DbAdapter.cite(richTime) + ",flightNum=" + DbAdapter.cite(flightNum) + ",trainNum=" + DbAdapter.cite(trainNum) + ",welcome=" + DbAdapter.cite(welcome) + ",subject=" + DbAdapter.cite(subject) + ",addition=" + DbAdapter.cite(addition) + ",employee=" + DbAdapter.cite(employee) + ",nationality=" + DbAdapter.cite(nationality) + ",middle=" + DbAdapter.cite(middle) + ",postal="
						+ DbAdapter.cite(postal) + ",place=" + DbAdapter.cite(place) + ",date2=" + DbAdapter.cite(date2) + ",time=" + DbAdapter.cite(time) + ",port=" + DbAdapter.cite(port) + ",departure=" + DbAdapter.cite(departure) + ",airport=" + DbAdapter.cite(airport) + ",document=" + DbAdapter.cite(document) + ",title=" + DbAdapter.cite(title) + ",groups=" + DbAdapter.cite(groups) + ",isfile=" + (isfile ? "1" : "0") + ",expiration=" + DbAdapter.cite(expiration) + ",departuredate2="
						+ DbAdapter.cite(departuredate2) + ",departuretime=" + DbAdapter.cite(departuretime) + ",departureflight=" + DbAdapter.cite(departureflight) + ",departuretrain=" + DbAdapter.cite(departuretrain) + " WHERE node=" + node + " AND language=" + language);
			} finally
			{
				db.close();
			}
		} else
		{
			create();
		}
	}

	public void create() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO ERegister(node,language,member,name,sex, birthday,blood,cardType,cardNum,workPlace,job,email,address,phone,fax,mobile,richDate,richTime,flightNum,trainNum,welcome,subject,addition,employee,isfile,expiration      ,departuredate2   ,departuretime   ,departureflight ,departuretrain  ,auditing) VALUES (" + node + "," + language + ", " + DbAdapter.cite(member) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(sex) + "," + DbAdapter.cite(birthday) + ","
					+ DbAdapter.cite(blood) + "," + DbAdapter.cite(cardType) + "," + DbAdapter.cite(cardNum) + "," + DbAdapter.cite(workPlace) + "," + DbAdapter.cite(job) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(richDate) + "," + DbAdapter.cite(richTime) + "," + DbAdapter.cite(flightNum) + "," + DbAdapter.cite(trainNum) + "," + DbAdapter.cite(welcome) + ","
					+ DbAdapter.cite(subject) + "," + DbAdapter.cite(addition) + "," + DbAdapter.cite(employee) + "," + (isfile ? "1" : "0") + "," + DbAdapter.cite(expiration) + "      ," + DbAdapter.cite(departuredate2) + "   ," + DbAdapter.cite(departuretime) + "   ," + DbAdapter.cite(departureflight) + " ," + DbAdapter.cite(departuretrain) + " ,0 ) ");
		} finally
		{
			db.close();
		}
		_cache.remove(node + ":" + language);
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT name,sex,birthday,blood,cardType,cardNum,workPlace,job,email,address,phone,fax,mobile,richDate,richTime,flightNum,trainNum,welcome,subject,addition,employee,isfile,expiration,departuredate2,departuretime,departureflight,departuretrain,auditing,member FROME Register WHERE node=" + node + " AND language=" + language);
			if (db.next())
			{
				name = db.getVarchar(1, language, 1);
				sex = db.getVarchar(1, language, 2);
				birthday = db.getDate(3);
				blood = db.getVarchar(1, language, 4);
				cardType = db.getVarchar(1, language, 5);
				cardNum = db.getVarchar(1, language, 6);
				workPlace = db.getVarchar(1, language, 7);
				job = db.getVarchar(1, language, 8);
				email = db.getVarchar(1, language, 9);
				address = db.getVarchar(1, language, 10);
				phone = db.getVarchar(1, language, 11);
				fax = db.getVarchar(1, language, 12);
				mobile = db.getVarchar(1, language, 13);
				richDate = db.getVarchar(1, language, 14);
				richTime = db.getVarchar(1, language, 15);
				flightNum = db.getVarchar(1, language, 16);
				trainNum = db.getVarchar(1, language, 17);
				welcome = db.getVarchar(1, language, 18);
				subject = db.getVarchar(1, language, 19);
				addition = db.getVarchar(1, language, 20);
				employee = db.getVarchar(1, language, 21);
				isfile = db.getInt(22) != 0;
				expiration = db.getVarchar(1, language, 23);
				departuredate2 = db.getVarchar(1, language, 24);
				departuretime = db.getVarchar(1, language, 25);
				departureflight = db.getVarchar(1, language, 26);
				departuretrain = db.getVarchar(1, language, 27);
				auditing = db.getInt(28) != 0;
				member = db.getString(29);
				exists = true;
			} else
			{
				exists = false;
				name = nationality = sex =
				// birthday =
				blood = cardType = cardNum = workPlace = job = email = address = phone = fax = mobile = richDate = richTime = flightNum = trainNum = welcome = subject = addition = employee = "";
			}
		} finally
		{
			db.close();
		}
	}

	public int getNode()
	{
		return node;
	}

	public int getLanguage()
	{
		return language;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getAddition()
	{
		return addition;
	}

	public String getAddress()
	{
		return address;
	}

	public java.util.Date getBirthday()
	{
		return birthday;
	}

	public String getBirthday(String pattern)
	{
		if (birthday == null)
		{
			return "";
		} else
		{
			return new java.text.SimpleDateFormat(pattern).format(birthday);
		}

	}

	public String getBlood()
	{
		return blood;
	}

	public String getCardNum()
	{
		return cardNum;
	}

	public String getCardType()
	{
		return cardType;
	}

	public String getEmail()
	{
		return email;
	}

	public String getEmployee()
	{
		return employee;
	}

	public String getFax()
	{
		return fax;
	}

	public String getFlightNum()
	{
		return flightNum;
	}

	public String getJob()
	{
		return job;
	}

	public String getMobile()
	{
		return mobile;
	}

	public String getName()
	{
		return name;
	}

	public String getPhone()
	{
		return phone;
	}

	public String getRichDate()
	{
		return richDate;
	}

	public String getRichTime()
	{
		return richTime;
	}

	public String getSex()
	{
		return sex;
	}

	public String getSubject()
	{
		return subject;
	}

	public String getTrainNum()
	{
		return trainNum;
	}

	public String getWelcome()
	{
		return welcome;
	}

	public String getWorkPlace()
	{
		return workPlace;
	}

	public String getNationality()
	{
		return nationality;
	}

	public String getMiddle()
	{
		return middle;
	}

	public String getPostal()
	{
		return postal;
	}

	public String getPlace()
	{
		return place;
	}

	public String getDate()
	{
		return date2;
	}

	public String getTime()
	{
		return time;
	}

	public String getPort()
	{
		return port;
	}

	public String getDeparture()
	{
		return departure;
	}

	public String getAirport()
	{
		return airport;
	}

	public String getDocument()
	{
		return document;
	}

	public String getTitle()
	{
		return title;
	}

	public String getGroup()
	{
		return groups;
	}

	public boolean isFile()
	{
		return isfile;
	}

	public String getExpiration()
	{
		return expiration;
	}

	public String getDeparturedate2()
	{
		return departuredate2;
	}

	public String getDeparturetime()
	{
		return departuretime;
	}

	public String getDepartureflight()
	{
		return departureflight;
	}

	public String getDeparturetrain()
	{
		return departuretrain;
	}

	public boolean isAuditing()
	{
		return auditing;
	}

	public String getMember()
	{
		return member;
	}

	public void setWorkPlace(String workPlace)
	{
		this.workPlace = workPlace;
	}

	public void setTrainNum(String trainNum)
	{
		this.trainNum = trainNum;
	}

	public void setWelcome(String welcome)
	{
		this.welcome = welcome;
	}

	public void setSubject(String subject)
	{
		this.subject = subject;
	}

	public void setSex(String sex)
	{
		this.sex = sex;
	}

	public void setRichTime(String richTime)
	{
		this.richTime = richTime;
	}

	public void setRichDate(String richDate)
	{
		this.richDate = richDate;
	}

	public void setPhone(String phone)
	{
		this.phone = phone;
	}

	public void setNode(int node)
	{
		this.node = node;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public void setMobile(String mobile)
	{
		this.mobile = mobile;
	}

	public void setLanguage(int language)
	{
		this.language = language;
	}

	public void setJob(String job)
	{
		this.job = job;
	}

	public void setFlightNum(String flightNum)
	{
		this.flightNum = flightNum;
	}

	public void setFax(String fax)
	{
		this.fax = fax;
	}

	public void setEmployee(String employee)
	{
		this.employee = employee;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public void setCardType(String cardType)
	{
		this.cardType = cardType;
	}

	public void setCardNum(String cardNum)
	{
		this.cardNum = cardNum;
	}

	public void setBlood(String blood)
	{
		this.blood = blood;
	}

	public void setBirthday(java.util.Date birthday)
	{
		this.birthday = birthday;
	}

	public void setAddress(String address)
	{
		this.address = address;
	}

	public void setAddition(String addition)
	{
		this.addition = addition;
	}

	public void setNationality(String nationality)
	{
		this.nationality = nationality;
	}

	public void setMiddle(String middle)
	{
		this.middle = middle;
	}

	public void setPostal(String postal)
	{
		this.postal = postal;
	}

	public void setPlace(String place)
	{
		this.place = place;
	}

	public void setDate(String date2)
	{
		this.date2 = date2;
	}

	public void setTime(String time)
	{
		this.time = time;
	}

	public void setPort(String port)
	{
		this.port = port;
	}

	public void setDeparture(String departure)
	{
		this.departure = departure;
	}

	public void setAirport(String airport)
	{
		this.airport = airport;
	}

	public void setDocument(String document)
	{
		this.document = document;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public void setGroup(String groups)
	{
		this.groups = groups;
	}

	public void setFile(boolean isfile)
	{
		this.isfile = isfile;
	}

	public void setExpiration(String expiration)
	{
		this.expiration = expiration;
	}

	public void setDeparturedate2(String departuredate2)
	{
		this.departuredate2 = departuredate2;
	}

	public void setDeparturetime(String departuretime)
	{
		this.departuretime = departuretime;
	}

	public void setDepartureflight(String departureflight)
	{
		this.departureflight = departureflight;
	}

	public void setDeparturetrain(String departuretrain)
	{
		this.departuretrain = departuretrain;
	}

	public void setAuditing(boolean auditing) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE ERegister SET auditing=" + (auditing ? "1" : "0") + " WHERE node= " + node + " AND language=" + language);
		} finally
		{
			db.close();
		}
		this.auditing = auditing;
	}

	public void setMember(String member)
	{
		this.member = member;
	}
}
