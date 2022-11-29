package tea.entity.node;

import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.html.Span;
import tea.html.Text;
import java.sql.SQLException;

public class Register
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
	private String member;
	private boolean isfile;
	private boolean auditing;
	private String leaveDate;
	private String leaveTime;
	private String leaveFlight;
	private String leaveTrain;

	public static Register find(int node, int language) throws SQLException
	{
		Register obj = (Register) _cache.get(node + ":" + language);
		if (obj == null)
		{
			obj = new Register(node, language);
			_cache.put(node + ":" + language, obj);
		}
		return obj;
	}

	public Register(int node, int language) throws SQLException
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
				/*
				 * db.executeUpdate("RegisterEdit " + node + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(sex) + "," + DbAdapter.cite(birthday) + "," + DbAdapter.cite(blood) + "," + DbAdapter.cite(cardType) + "," + DbAdapter.cite(cardNum) + "," + DbAdapter.cite(workPlace) + "," + DbAdapter.cite(job) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(mobile) + "," +
				 * DbAdapter.cite(richDate) + "," + DbAdapter.cite(richTime) + "," + DbAdapter.cite(flightNum) + "," + DbAdapter.cite(trainNum) + "," + DbAdapter.cite(leaveDate) + "," + DbAdapter.cite(leaveTime) + "," + DbAdapter.cite(leaveFlight) + "," + DbAdapter.cite(leaveTrain) + "," +
				 *
				 * DbAdapter.cite(welcome) + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(addition) + "," + DbAdapter.cite(employee) + "," + (isfile ? "1" : "0") member );
				 */
				db.executeUpdate("UPDATE Register  SET  name     =" + DbAdapter.cite(name) + "     ,sex      =" + DbAdapter.cite(sex) + "      ,birthday =" + DbAdapter.cite(birthday) + " ,blood    =" + DbAdapter.cite(blood) + "    ,cardType =" + DbAdapter.cite(cardType) + " ,cardNum  =" + DbAdapter.cite(cardNum) + "  ,workPlace=" + DbAdapter.cite(workPlace) + ",job      =" + DbAdapter.cite(job) + "      ,email    =" + DbAdapter.cite(email) + "    ,address  =" + DbAdapter.cite(address)
						+ "  ,phone    =" + DbAdapter.cite(phone) + "    ,fax      =" + DbAdapter.cite(fax) + "      ,mobile   =" + DbAdapter.cite(mobile) + "   ,richDate =" + DbAdapter.cite(richDate) + " ,richTime =" + DbAdapter.cite(richTime) + " ,flightNum=" + DbAdapter.cite(flightNum) + ",trainNum =" + DbAdapter.cite(trainNum) + " ,leavedate	=" + DbAdapter.cite(leaveDate) + "	,leavetime	=" + DbAdapter.cite(leaveTime) + "	,leaveflight	=" + DbAdapter.cite(leaveFlight) + "	,leavetrain	="
						+ DbAdapter.cite(leaveTrain) + "	,welcome  =" + DbAdapter.cite(welcome) + "  ,subject  =" + DbAdapter.cite(subject) + "  ,addition =" + DbAdapter.cite(addition) + " ,employee =" + DbAdapter.cite(employee) + "  ,[isfile]	=" + (isfile ? "1" : "0") + "  WHERE node=" + node + "  AND language =" + language);
				this.loadBasic();
				_cache.put(node + ":" + language, this);

			}  finally
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
			/*
			 * db.executeUpdate("RegisterCreate " + node + "," + language + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(sex) + "," + DbAdapter.cite(birthday) + "," + DbAdapter.cite(blood) + "," + DbAdapter.cite(cardType) + "," + DbAdapter.cite(cardNum) + "," + DbAdapter.cite(workPlace) + "," + DbAdapter.cite(job) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(fax) + "," +
			 * DbAdapter.cite(mobile) + "," + DbAdapter.cite(richDate) + "," + DbAdapter.cite(richTime) + "," + DbAdapter.cite(flightNum) + "," + DbAdapter.cite(trainNum) + "," + DbAdapter.cite(leaveDate) + "," + DbAdapter.cite(leaveTime) + "," + DbAdapter.cite(leaveFlight) + "," + DbAdapter.cite(leaveTrain) + "," + DbAdapter.cite(welcome) + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(addition) + "," + DbAdapter.cite(employee) + "," + (isfile ? "1" : "0") );
			 */
			db.executeUpdate("   INSERT INTO Register(node,language,member,name,sex, birthday,blood,cardType,cardNum,workPlace,job,email,address,phone,fax,mobile,richDate,richTime,flightNum,trainNum, leavedate	,leavetime	,leaveflight	,leavetrain	,welcome,subject,addition,employee,[isfile],auditing) VALUES (" + node + "," + language + ", " + DbAdapter.cite(member) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(sex) + "," + DbAdapter.cite(birthday) + "," + DbAdapter.cite(blood) + ","
					+ DbAdapter.cite(cardType) + "," + DbAdapter.cite(cardNum) + "," + DbAdapter.cite(workPlace) + "," + DbAdapter.cite(job) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(richDate) + "," + DbAdapter.cite(richTime) + "," + DbAdapter.cite(flightNum) + "," + DbAdapter.cite(trainNum) + "," + DbAdapter.cite(leaveDate) + "	," + DbAdapter.cite(leaveTime)
					+ "	," + DbAdapter.cite(leaveFlight) + "	," + DbAdapter.cite(leaveTrain) + "	," + DbAdapter.cite(welcome) + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(addition) + "," + DbAdapter.cite(employee) + "," + (isfile ? "1" : "0") + ",0) ");
			this.loadBasic();
			_cache.put(node + ":" + language, this);
		}  finally
		{
			db.close();
		}
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT  name     ,sex      ,birthday ,blood    ,cardType ,cardNum  ,workPlace,job      ,email    ,address  ,phone    ,fax      ,mobile   ,richDate ,richTime ,flightNum,trainNum ,welcome  ,subject  ,addition ,employee ,[isfile],auditing,member,leavedate	,leavetime	,leaveflight	,leavetrain		FROM Register WHERE node= " + node + " AND language=" + language);
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
				auditing = db.getInt(23) != 0;
				this.member = db.getString(24);
				leaveDate = db.getVarchar(1, language, 25);
				leaveTime = db.getVarchar(1, language, 26);
				leaveFlight = db.getVarchar(1, language, 27);
				leaveTrain = db.getVarchar(1, language, 28);
				exists = true;
			} else
			{
				exists = false;
				name = sex =
				// birthday =
				blood = cardType = cardNum = workPlace = job = email = address = phone = fax = mobile = richDate = richTime = flightNum = trainNum = welcome = subject = addition = employee = "";
			}
		}  finally
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
		}
		return new java.text.SimpleDateFormat(pattern).format(birthday);
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

	public String getMember()
	{
		return member;
	}

	public boolean isFile()
	{
		return isfile;
	}

	public boolean isAuditing()
	{
		return auditing;
	}

	public String getLeaveDate()
	{
		return leaveDate;
	}

	public String getLeaveTime()
	{
		return leaveTime;
	}

	public String getLeaveFlight()
	{
		return leaveFlight;
	}

	public String getLeaveTrain()
	{
		return leaveTrain;
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

	public void setMember(String member)
	{
		this.member = member;
	}

	public void setFile(boolean isfile)
	{
		this.isfile = isfile;
	}

	public void setAuditing(boolean auditing) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Register SET auditing=" + (auditing ? "1" : "0") + " WHERE node= " + node + " AND language=" + language);
		}  finally
		{
			db.close();
		}
		this.auditing = auditing;
		_cache.put(node + ":" + language, this);
	}

	public void setLeaveDate(String leaveDate)
	{
		this.leaveDate = leaveDate;
	}

	public void setLeaveTime(String leaveTime)
	{
		this.leaveTime = leaveTime;
	}

	public void setLeaveFlight(String leaveFlight)
	{
		this.leaveFlight = leaveFlight;
	}

	public void setLeaveTrain(String leaveTrain)
	{
		this.leaveTrain = leaveTrain;
	}

	public static Text getDetail(Node node, Http h, int listing, String target) throws SQLException
	{
		Span span = null;
		StringBuilder sb = new StringBuilder();
		//java.util.Enumeration enumeration = ListingDetail.find(listing, 57, iLanguage); // Sound.getDetail(node, listing, iLanguage);
		/*
		 * tea.entity.node.ReisterDetail obj=tea.entity.node.ReisterDetail.find(node._node,iLanguage); while (enumeration.hasMoreElements()) { ListingDetail detail = (ListingDetail) enumeration.nextElement(); if (detail.getItemName().equals("name")) { value=(obj.getName()); } else if (detail.getItemName().equals("sex")) { value=(obj.getSex()); } else if (detail.getItemName().equals("birthday")) { value=(obj.getBirthday()); } else if
		 * (detail.getItemName().equals("blood")) { value=(obj.getBlood()); } else if (detail.getItemName().equals("cardType")) { value=(obj.getCardtype()); } else if (detail.getItemName().equals("cardNum")) { value=(obj.getCardnum()); } else if (detail.getItemName().equals("workPlace")) { value=(obj.getWorkplace()); } else if (detail.getItemName().equals("job")) { value=(obj.getJob()); } else if
		 * (detail.getItemName().equals("email")) { value=(obj.getEmail()); } else if (detail.getItemName().equals("address")) { value=(obj.getAddress()); } else if (detail.getItemName().equals("phone")) { value=(obj.getPhone()); } else if (detail.getItemName().equals("fax")) { value=(obj.getFax()); } else if (detail.getItemName().equals("mobile")) { value=(obj.getMobile()); } else if (detail.getItemName().equals("richDate")) {
		 * value=(obj.getRichdate()); } else if (detail.getItemName().equals("richTime")) { value=(obj.getRichtime()); } else if (detail.getItemName().equals("flightNum")) { value=(obj.getFlightnum()); } else if (detail.getItemName().equals("trainNum")) { value=(obj.getTrainnum()); } else if (detail.getItemName().equals("welcome")) { value=(obj.getWelcome()); } else if (detail.getItemName().equals("subject")) {
		 * value=(obj.getSubject()); } else if (detail.getItemName().equals("addition")) { value=(obj.getAddition()); } else if (detail.getItemName().equals("employee")) { value=(obj.getEmployee()); } if (detail.getAnchor() != 0) { Anchor anchor = new Anchor("Register?Node=" + node._nNode, value); if (newWindow) anchor.setTarget("_blank"); span = new Span(anchor); } else span = new Span(value); span.setId("RegisterID" +
		 * detail.getItemName()); sb.append(detail.getBeforeItem() + span + detail.getAfterItem()); }
		 */
		return new Text(sb.toString());
	}

}
