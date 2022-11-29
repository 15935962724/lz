package tea.entity.node;

import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.Cache;
import java.sql.SQLException;

public class EGazetteer
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
    private String business;
    private String organise;
    private String type;
    private String oaddress;
    private String ophone;
    private String ofax;
    private String oemail;
    private String arrivalDate;
    private String arrivalFlight;
    private String arrivalTrain;
    private String leaveDate;
    private String leaveFlight;
    private String remark;
    private String leaveTrain;
    private String name2;
    private String nationality;
    private Date expiration;
    private boolean isfile;
    private String appear;
    private boolean auditing;
    private String leaveTime;
    private String arrivalTime;
    private String member;
    public static EGazetteer find(int node, int language) throws SQLException
    {
        EGazetteer obj = (EGazetteer) _cache.get(node + ":" + language);
        if (obj == null)
        {
            obj = new EGazetteer(node, language);
            _cache.put(node + ":" + language, obj);
        }
        return obj;
    }

    public EGazetteer(int node, int language) throws SQLException
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
               /* db.executeUpdate("EGazetteerEdit " +
                                        (node) + "," +
                                        (language) + "," +
                                        DbAdapter.cite(name) + "," +
                                        DbAdapter.cite(name2) + "," +
                                        DbAdapter.cite(sex) + "," +
                                        DbAdapter.cite(birthday) + "," +
                                        DbAdapter.cite(nationality) + "," +
                                        DbAdapter.cite(expiration) + "," +
                                        DbAdapter.cite(blood) + "," +
                                        DbAdapter.cite(cardType) + "," +
                                        DbAdapter.cite(cardNum) + "," +
                                        DbAdapter.cite(address) + "," +
                                        DbAdapter.cite(phone) + "," +
                                        DbAdapter.cite(fax) + "," +
                                        DbAdapter.cite(mobile) + "," +
                                        DbAdapter.cite(email) + "," +
                                        DbAdapter.cite(business) + "," +
                                        DbAdapter.cite(type) + "," +
                                        DbAdapter.cite(organise) + "," +
                                        DbAdapter.cite(oaddress) + "," +
                                        DbAdapter.cite(ophone) + "," +
                                        DbAdapter.cite(ofax) + "," +
                                        DbAdapter.cite(oemail) + "," +
                                        DbAdapter.cite(this.arrivalDate) + "," +
                                        DbAdapter.cite(this.arrivalTime) + "," +
                                        DbAdapter.cite(this.arrivalFlight) + "," +
                                        DbAdapter.cite(this.arrivalTrain) + "," +
                                        DbAdapter.cite(this.leaveDate) + "," +
                                        DbAdapter.cite(this.leaveTime) + "," +
                                        DbAdapter.cite(this.leaveFlight) + "," +
                                        DbAdapter.cite(this.leaveTrain) + "," +
                                        DbAdapter.cite(this.remark) + "," +
                                        DbAdapter.cite(welcome) + "," +
                                        (isfile ? "1" : "0") + "," +
                                        DbAdapter.cite(appear)
                    );*/
            	db.executeUpdate("UPDATE EGazetteer SET	name  ="+DbAdapter.cite(name)+"  ,name2         ="+DbAdapter.cite(name2)+" , sex ="+ DbAdapter.cite(sex)+", birthday="+DbAdapter.cite(birthday)+",nationality	="+DbAdapter.cite(nationality)+",expiration="+ DbAdapter.cite(expiration)+",blood ="+DbAdapter.cite(blood)+"    ,    	cardType     ="+DbAdapter.cite(cardType)+"  ,cardNum="+DbAdapter.cite(cardNum)+" ,address ="+ DbAdapter.cite(address)+" , 	phone ="+DbAdapter.cite(phone) +"  ,	fax ="+ DbAdapter.cite(fax)+" ,	mobile="+DbAdapter.cite(mobile)+"       ,	email  ="+DbAdapter.cite(email)+"  ,	business  ="+DbAdapter.cite(business)+" ,	type  ="+DbAdapter.cite(type) +" ,	organise  ="+ DbAdapter.cite(organise)+"  ,	oaddress ="+DbAdapter.cite(oaddress)+"     ,	ophone       ="+DbAdapter.cite(ophone) +"       ,	ofax ="+DbAdapter.cite(ofax) +"  ,	oemail ="+DbAdapter.cite(oemail)+"  ,	arrivadate   ="+DbAdapter.cite(this.arrivalDate)+"   ,	arrivatime   ="+ DbAdapter.cite(this.arrivalTime) +"   	,	arrivalflight="+DbAdapter.cite(this.arrivalFlight)+",	arrivaltrain ="+DbAdapter.cite(this.arrivalTrain)+" ,	leavedate    ="+ DbAdapter.cite(this.leaveDate)+"    ,	leavetime    ="+DbAdapter.cite(this.leaveTime)+"   ,	leaveflight  ="+DbAdapter.cite(this.leaveFlight)+"  ,	leavetrain   ="+ DbAdapter.cite(this.leaveTrain)+"   ,	remark	     ="+ DbAdapter.cite(this.remark)+"       ,	welcome      ="+DbAdapter.cite(welcome) +"  ,[isfile]		="+(isfile ? "1" : "0")+",appear		="+DbAdapter.cite(appear)+"  WHERE node="+node+" AND language="+language);
                this.loadBasic();
                _cache.put(node + ":" + language, this);
            } finally
            {
                db.close();
            }
        } else
            create();
    }

    public void create() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
           /* db.executeUpdate("EGazetteerCreate " +
                                    (node) + "," +
                                    (language) + "," +
                                    DbAdapter.cite(member) + "," +
                                    DbAdapter.cite(name) + "," +
                                    DbAdapter.cite(name2) + "," +
                                    DbAdapter.cite(sex) + "," +
                                    DbAdapter.cite(birthday) + "," +
                                    DbAdapter.cite(nationality) + "," +
                                    DbAdapter.cite(expiration) + "," +
                                    DbAdapter.cite(blood) + "," +
                                    DbAdapter.cite(cardType) + "," +
                                    DbAdapter.cite(cardNum) + "," +
                                    DbAdapter.cite(address) + "," +
                                    DbAdapter.cite(phone) + "," +
                                    DbAdapter.cite(fax) + "," +
                                    DbAdapter.cite(mobile) + "," +
                                    DbAdapter.cite(email) + "," +
                                    DbAdapter.cite(business) + "," +
                                    DbAdapter.cite(type) + "," +
                                    DbAdapter.cite(organise) + "," +
                                    DbAdapter.cite(oaddress) + "," +
                                    DbAdapter.cite(ophone) + "," +
                                    DbAdapter.cite(ofax) + "," +
                                    DbAdapter.cite(oemail) + "," +
                                    DbAdapter.cite(this.arrivalDate) + "," +
                                    DbAdapter.cite(this.arrivalTime) + "," +
                                    DbAdapter.cite(this.arrivalFlight) + "," +
                                    DbAdapter.cite(this.arrivalTrain) + "," +
                                    DbAdapter.cite(this.leaveDate) + "," +
                                    DbAdapter.cite(this.leaveTime) + "," +
                                    DbAdapter.cite(this.leaveFlight) + "," +
                                    DbAdapter.cite(this.leaveTrain) + "," +
                                    DbAdapter.cite(this.remark) + "," +
                                    DbAdapter.cite(welcome) + "," +
                                    (isfile ? "1" : "0") + "," +
                                    DbAdapter.cite(appear)
                );*/
        	db.executeUpdate("INSERT INTO EGazetteer(node ,language ,name  ,name2 ,sex   ,birthday ,nationality,expiration,blood ,cardType,cardNum ,address ,phone,fax  ,mobile ,email ,business ,type,organise     ,oaddress     ,ophone ,ofax,oemail ,arrivadate   ,arrivatime,arrivalflight,arrivaltrain ,leavedate,leavetime,leaveflight ,leavetrain   ,remark,welcome,[isfile],appear	,auditing  )VALUES("+node +"        ,"+language+"    ,"+   DbAdapter.cite(name)+"     ,"+  DbAdapter.cite(name2)+"     ,"+  DbAdapter.cite(sex)+"          ,"+ DbAdapter.cite(birthday)+"   ,"+ DbAdapter.cite(nationality)+","+DbAdapter.cite(expiration)+"  ,"+DbAdapter.cite(blood)+"        ,"+ DbAdapter.cite(cardType)+"     ,"+ DbAdapter.cite(cardNum)+"     ,"+DbAdapter.cite(address)+"      ,"+DbAdapter.cite(phone)+"        ,"+DbAdapter.cite(fax)+"          ,"+ DbAdapter.cite(mobile)+"       ,"+ DbAdapter.cite(email)+"        ,"+ DbAdapter.cite(business)+"     ,"+DbAdapter.cite(type)+"         ,"+DbAdapter.cite(organise)+"     ,"+DbAdapter.cite(organise)+"     ,"+ DbAdapter.cite(ophone) +"       ,"+DbAdapter.cite(ofax)+"         ,"+DbAdapter.cite(oemail)+"       ,"+ DbAdapter.cite(this.arrivalDate)+"   ,"+ DbAdapter.cite(this.arrivalTime)+","+DbAdapter.cite(this.arrivalFlight)+","+ DbAdapter.cite(this.arrivalTrain)+" ,"+  DbAdapter.cite(this.leaveDate)+"    ,"+DbAdapter.cite(this.leaveTime)+","+ DbAdapter.cite(this.leaveFlight)+"  ,"+ DbAdapter.cite(this.leaveTrain)+"   ,"+ DbAdapter.cite(this.remark) +","+DbAdapter.cite(welcome)+"     ,"+ (isfile ? "1" : "0")+","+ DbAdapter.cite(appear)+",0)");
            this.loadBasic();
            _cache.put(node + ":" + language, this);
        } finally
        {
            db.close();
        }
    }

    private void loadBasic() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  name         ,sex          ,birthday     ,blood        ,cardType     ,cardNum      ,address      ,phone        ,fax          ,mobile       ,email        ,business     ,type         ,organise     ,oaddress     ,ophone       ,ofax         ,oemail       ,arrivadate   ,arrivalflight,arrivaltrain ,leavedate    ,leaveflight  ,leavetrain ,remark  ,welcome   ,name2,nationality,expiration ,[isfile]  ,appear,auditing,arrivatime,leavetime,member	FROM EGazetteer WHERE node= " + node + " AND language=" + language);
            if (db.next())
            {
                name = db.getVarchar(1, language, 1);
                sex = db.getVarchar(1, language, 2);
                birthday = db.getDate(3);
                blood = db.getVarchar(1, language, 4);
                cardType = db.getVarchar(1, language, 5);
                cardNum = db.getVarchar(1, language, 6);
                address = db.getVarchar(1, language, 7);
                phone = db.getVarchar(1, language, 8);
                fax = db.getVarchar(1, language, 9);
                mobile = db.getVarchar(1, language, 10);
                email = db.getVarchar(1, language, 11);
                business = db.getVarchar(1, language, 12);
                type = db.getVarchar(1, language, 13);
                organise = db.getVarchar(1, language, 14);
                oaddress = db.getVarchar(1, language, 15);
                ophone = db.getVarchar(1, language, 16);
                ofax = db.getVarchar(1, language, 17);
                oemail = db.getVarchar(1, language, 18);
                this.arrivalDate = db.getVarchar(1, language, 19);
                arrivalFlight = db.getVarchar(1, language, 20);
                this.arrivalTrain = db.getVarchar(1, language, 21);
                this.leaveDate = db.getVarchar(1, language, 22);
                this.leaveFlight = db.getVarchar(1, language, 23);
                this.leaveTrain = db.getVarchar(1, language, 24);
                remark = db.getVarchar(1, language, 25);
                welcome = db.getVarchar(1, language, 26);
                name2 = db.getVarchar(1, language, 27);
                nationality = db.getVarchar(1, language, 28);
                expiration = db.getDate(29);
                isfile = db.getInt(30) != 0;
                appear = db.getVarchar(1, language, 31);
                auditing = db.getInt(32) != 0;
                this.arrivalTime = db.getVarchar(1, language, 33);
                this.leaveTime = db.getVarchar(1, language, 34);
                this.member = db.getString(35);
                exists = true;
            } else
            {
                exists = false;
                name = name2 = nationality = appear =
                    sex =
//                    birthday =
                    blood =
                    cardType =
                    cardNum =
                    address =
                    phone =
                    fax =
                    mobile =
                    email =
                    business =
                    type =
                    organise =
                    oaddress =
                    ophone =
                    ofax =
                    oemail =
//                    arriva =
                    arrivalFlight =
                    arrivalTrain =
//                    leave =
                    leaveFlight =
                    leaveTrain =
                    remark =
                    welcome = "";
            }
        } finally
        {
            db.close();
        }
    }

    public int getNode()
    {
        return node; }

    public int getLanguage()
    {
        return language; }

    public boolean isExists()
    {
        return exists; }

    public String getAddition()
    {
        return addition; }

    public String getAddress()
    {
        return address; }

    public java.util.Date getBirthday()
    {
        return birthday; }

    public java.lang.String getBirthday(String pattern)
    {
        if (birthday == null)
            return "";
        else
            return new java.text.SimpleDateFormat(pattern).format(birthday);
    }

    public String getBlood()
    {
        return blood; }

    public String getCardNum()
    {
        return cardNum; }

    public String getCardType()
    {
        return cardType; }

    public String getEmail()
    {
        return email; }

    public String getEmployee()
    {
        return employee; }

    public String getFax()
    {
        return fax; }

    public String getFlightNum()
    {
        return flightNum; }

    public String getJob()
    {
        return job; }

    public String getMobile()
    {
        return mobile; }

    public String getName()
    {
        return name; }

    public String getPhone()
    {
        return phone; }

    public String getRichDate()
    {
        return richDate; }

    public String getRichTime()
    {
        return richTime; }

    public String getSex()
    {
        return sex; }

    public String getSubject()
    {
        return subject; }

    public String getTrainNum()
    {
        return trainNum; }

    public String getWelcome()
    {
        return welcome; }

    public String getWorkPlace()
    {
        return workPlace; }

    public String getBusiness()
    {
        return business; }

    public String getOrganise()
    {
        return organise; }

    public String getType()
    {
        return type; }

    public String getOaddress()
    {
        return oaddress; }

    public String getOphone()
    {
        return ophone; }

    public String getOfax()
    {
        return ofax; }

    public String getOemail()
    {
        return oemail; }

    public String getArrivalDate()
    {

        return arrivalDate; }

    /* public String getArrival(String pattern)
     {
         if (arrival == null)
             return "";
         else
             return new java.text.SimpleDateFormat(pattern).format(arrival);
     }*/

    public String getArrivalFlight()
    {

        return arrivalFlight; }

    public String getArrivalTrain()
    {

        return arrivalTrain; }

    public String getLeaveDate()
    {

        return leaveDate; }

    /*
        public String getLeave(String pattern)
        {
            if (leave == null)
                return ""
                    ;
            else
                return new java.text.SimpleDateFormat(pattern).format(leave);
        }*/

    public String getLeaveFlight()
    {
        return leaveFlight; }

    public String getRemark()
    {
        return remark; }

    public String getLeaveTrain()
    {

        return leaveTrain; }

    public String getName2()
    {
        return name2; }

    public String getNationality()
    {
        return nationality; }

    public Date getExpiration()
    {
        return expiration; }

    public String getExpiration(String pattern)
    {
        if (expiration == null)
            return "";
        else
            return new java.text.SimpleDateFormat(pattern).format(expiration);
        // return expiration;
    }

    public boolean isFile()
    {
        return isfile; }

    public String getAppear()
    {
        return appear; }

    public boolean isAuditing()
    {
        return auditing; }

    public String getLeaveTime()
    {

        return leaveTime; }

    public String getArrivalTime()
    {

        return arrivalTime; }

    public String getMember()
    {
        return member; }

    public void setWorkPlace(String workPlace)
    {
        this.workPlace = workPlace; }

    public void setTrainNum(String trainNum)
    {
        this.trainNum = trainNum; }

    public void setWelcome(String welcome)
    {
        this.welcome = welcome; }

    public void setSubject(String subject)
    {
        this.subject = subject; }

    public void setSex(String sex)
    {
        this.sex = sex; }

    public void setRichTime(String richTime)
    {
        this.richTime = richTime; }

    public void setRichDate(String richDate)
    {
        this.richDate = richDate; }

    public void setPhone(String phone)
    {
        this.phone = phone; }

    public void setNode(int node)
    {
        this.node = node; }

    public void setName(String name)
    {
        this.name = name; }

    public void setMobile(String mobile)
    {
        this.mobile = mobile; }

    public void setLanguage(int language)
    {
        this.language = language; }

    public void setJob(String job)
    {
        this.job = job; }

    public void setFlightNum(String flightNum)
    {
        this.flightNum = flightNum; }

    public void setFax(String fax)
    {
        this.fax = fax; }

    public void setEmployee(String employee)
    {
        this.employee = employee; }

    public void setEmail(String email)
    {
        this.email = email; }

    public void setCardType(String cardType)
    {
        this.cardType = cardType; }

    public void setCardNum(String cardNum)
    {
        this.cardNum = cardNum; }

    public void setBlood(String blood)
    {
        this.blood = blood; }

    public void setBirthday(java.util.Date birthday)
    {
        this.birthday = birthday; }

    public void setAddress(String address)
    {
        this.address = address; }

    public void setAddition(String addition)
    {
        this.addition = addition; }

    public void setBusiness(String business)
    {
        this.business = business; }

    public void setOrganise(String organise)
    {
        this.organise = organise; }

    public void setType(String type)
    {
        this.type = type; }

    public void setOaddress(String oaddress)
    {
        this.oaddress = oaddress; }

    public void setOphone(String ophone)
    {
        this.ophone = ophone; }

    public void setOfax(String ofax)
    {
        this.ofax = ofax; }

    public void setOemail(String oemail)
    {
        this.oemail = oemail; }

    public void setArrivalDate(String arrivalDate)
    {

        this.arrivalDate = arrivalDate; }

    public void setArrivalFlight(String arrivalFlight)
    {

        this.arrivalFlight = arrivalFlight; }

    public void setArrivalTrain(String arrivalTrain)
    {

        this.arrivalTrain = arrivalTrain; }

    public void setLeaveDate(String leaveDate)
    {

        this.leaveDate = leaveDate; }

    public void setLeaveFlight(String leaveFlight)
    {
        this.leaveFlight = leaveFlight; }

    public void setRemark(String remark)
    {
        this.remark = remark; }

    public void setLeaveTrain(String leaveTrain)
    {

        this.leaveTrain = leaveTrain; }

    public void setName2(String name2)
    {
        this.name2 = name2; }

    public void setNationality(String nationality)
    {
        this.nationality = nationality; }

    public void setExpiration(Date expiration)
    {
        this.expiration = expiration; }

    public void setFile(boolean isfile)
    {
        this.isfile = isfile; }

    public void setAppear(String appear)
    {
        this.appear = appear; }

    public void setAuditing(boolean auditing) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE EGazetteer SET auditing=" + (auditing ? "1" : "0") + " WHERE node= " + node + " AND language=" + language);
            this.auditing = auditing;
            _cache.put(node + ":" + language, this);
        } finally
        {
            db.close();
        }
    }

    public void setLeaveTime(String leaveTime)
    {

        this.leaveTime = leaveTime; }

    public void setArrivalTime(String arrivalTime)
    {

        this.arrivalTime = arrivalTime; }

    public void setMember(String member)
    {
        this.member = member; }
}
