package tea.entity.cio;

import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;

public class CioPart extends Entity
{
    public static final String TOURISM_TYPE[] =
            {"-------","东部华侨城","大亚湾核电站","中兴通讯公司"};
    private static Cache _cache = new Cache(100);
    private int ciopart;
    private int ciocompany;
    private String name;
    private boolean sex; //1 先生，0女士。 true,false
    private String job;
    private String mobile;
    private String tel;
    private String dept;
    private String email;
    private String fax;
    private String address;
    private String zip;
    private boolean talk; //是否发言
    private String tourism; //是否参加旅游,1:东部华侨城 2:大亚湾核电站 3:中兴通讯公司
    private boolean room; //是否合住
    private boolean shuttle; //true:接机,false:不接
    private String member; //代表号
    private String cometrain; //到达航班/车次
    private Date cometime; //到港/到站日期
    private Date backroom; //退房日期
    private String backtrain; //返回航班/车次
    private Date backtime; //离开日期
    private int cioclerkid; //接送人姓名
    private String stel; //接送人电话
    private boolean seat;
    private boolean bd;
    private boolean vip;
    //
    private String rname; //酒店名
    private String rchamber; //房型
    private Date rstime; //入住时间
    private Date retime; //退房时间
    private boolean exists;
    public CioPart(int ciopart) throws SQLException
    {
        this.ciopart = ciopart;
        load();
    }

    public CioPart(int ciopart,int ciocompany,String name,boolean sex,String job,String mobile,String tel,String dept,String email,String fax,String address,String zip,boolean talk,String tourism,boolean room,boolean shuttle,String member,String cometrain,Date cometime,Date backroom,String backtrain,Date backtime,int cioclerkid,String stel,boolean seat,boolean bd,boolean vip,String rname,String rchamber,Date rstime,Date retime) throws SQLException
    {
        this.ciopart = ciopart;
        this.ciocompany = ciocompany;
        this.name = name;
        this.sex = sex;
        this.job = job;
        this.mobile = mobile;
        this.tel = tel;
        this.dept = dept;
        this.email = email;
        this.fax = fax;
        this.address = address;
        this.zip = zip;
        this.talk = talk;
        this.tourism = tourism;
        this.room = room;
        this.shuttle = shuttle;
        this.member = member;
        this.cometrain = cometrain;
        this.cometime = cometime;
        this.backroom = backroom;
        this.backtrain = backtrain;
        this.backtime = backtime;
        this.cioclerkid = cioclerkid;
        this.stel = stel;
        this.seat = seat;
        this.bd = bd;
        this.vip = vip;
        //
        this.rname = rname;
        this.rchamber = rchamber;
        this.rstime = rstime;
        this.retime = retime;
        this.exists = true;
    }

    public static CioPart find(int ciopart) throws SQLException
    {
        CioPart obj = (CioPart) _cache.get(ciopart);
        if(obj == null)
        {
            obj = new CioPart(ciopart);
            _cache.put(ciopart,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ciocompany,name,sex,job,mobile,tel,dept,email,fax,address,zip,talk,tourism,room,shuttle,member,cometrain,cometime,backroom,backtrain,backtime,cioclerkid,stel,seat,bd,vip,rname,rchamber,rstime,retime FROM CioPart WHERE ciopart=" + ciopart);
            if(db.next())
            {
                int j = 1;
                ciocompany = db.getInt(j++);
                name = db.getString(j++);
                sex = db.getInt(j++) != 0;
                job = db.getString(j++);
                mobile = db.getString(j++);
                tel = db.getString(j++);
                dept = db.getString(j++);
                email = db.getString(j++);
                fax = db.getString(j++);
                address = db.getString(j++);
                zip = db.getString(j++);
                talk = db.getInt(j++) != 0;
                tourism = db.getString(j++);
                room = db.getInt(j++) != 0;
                shuttle = db.getInt(j++) != 0;
                member = db.getString(j++);
                cometrain = db.getString(j++);
                cometime = db.getDate(j++);
                backroom = db.getDate(j++);
                backtrain = db.getString(j++);
                backtime = db.getDate(j++);
                //
                cioclerkid = db.getInt(j++);
                stel = db.getString(j++);
                seat = db.getInt(j++) != 0;
                bd = db.getInt(j++) != 0;
                vip = db.getInt(j++) != 0;
                //
                rname = db.getString(j++);
                rchamber = db.getString(j++);
                rstime = db.getDate(j++);
                retime = db.getDate(j++);
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

    public static int create(int ciocompany,String name,boolean sex,String job,String mobile,String tel,String dept,String email,String fax,String address,String zip,boolean talk,String tourism,boolean room,boolean shuttle) throws SQLException
    {
        String member;
        CioCompany cc = CioCompany.find(ciocompany);
        DecimalFormat df = new DecimalFormat("0000");
        for(int i = 1;true;i++)
        {
            member = cc.getMember() + df.format(i);
            if(!Profile.isExisted(member))
            {
                String pwd = String.valueOf(Math.random()).substring(2,8);
                Profile.create(member,pwd,cc.getCommunity(),email,null);
                break;
            }
        }
        String rchamber = "";
        if(room)
        {
            rchamber = "双人标准间";
        } else
        {
            rchamber = "单人标准间";
        }
        int ciopart = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO CioPart(ciocompany,name,sex,job,mobile,tel,dept,email,fax,address,zip,talk,tourism,room,shuttle)VALUES(" + ciocompany + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(sex) + "," + DbAdapter.cite(job) + "," + DbAdapter.cite(mobile) + ", " + DbAdapter.cite(tel) + "," + DbAdapter.cite(dept) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(address) + ", " + DbAdapter.cite(zip) + ", " + DbAdapter.cite(talk) + ", " + DbAdapter.cite(tourism) + ", " + DbAdapter.cite(room) + ", " + DbAdapter.cite(shuttle) + ")");
            ciopart = db.getInt("SELECT MAX(ciopart) FROM CioPart WHERE ciocompany=" + ciocompany);
            db.executeUpdate("UPDATE CioPart SET member=" + DbAdapter.cite(member) + ",rchamber=" + DbAdapter.cite(rchamber) + " WHERE ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
        return ciopart;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM CioPart WHERE ciocompany IN ( SELECT ciocompany FROM CioCompany WHERE community=" + DbAdapter.cite(community) + ")" + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration find(int ciocompany,String sql,int pos,int size) throws SQLException
    {
        return find(" AND ciocompany=" + ciocompany + sql,pos,size);
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ciopart,ciocompany,name,sex,job,mobile,tel,dept,email,fax,address,zip,talk,tourism,room,shuttle,member,cometrain,cometime,backroom,backtrain,backtime,cioclerkid,stel,seat,bd,vip,rname,rchamber,rstime,retime FROM CioPart WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                int ciopart = db.getInt(j++);
                int ciocompany = db.getInt(j++);
                String name = db.getString(j++);
                boolean sex = db.getInt(j++) != 0;
                String job = db.getString(j++);
                String mobile = db.getString(j++);
                String tel = db.getString(j++);
                String dept = db.getString(j++);
                String email = db.getString(j++);
                String fax = db.getString(j++);
                String address = db.getString(j++);
                String zip = db.getString(j++);
                boolean talk = db.getInt(j++) != 0;
                String tourism = db.getString(j++);
                boolean room = db.getInt(j++) != 0;
                boolean shuttle = db.getInt(j++) != 0;
                String member = db.getString(j++);
                String cometrain = db.getString(j++);
                Date cometime = db.getDate(j++);
                Date backroom = db.getDate(j++);
                String backtrain = db.getString(j++);
                Date backtime = db.getDate(j++);
                int cioclerkid = db.getInt(j++);
                String stel = db.getString(j++);
                boolean seat = db.getInt(j++) != 0;
                boolean bd = db.getInt(j++) != 0;
                boolean vip = db.getInt(j++) != 0;
                //
                String rname = db.getString(j++);
                String rchamber = db.getString(j++);
                Date rstime = db.getDate(j++);
                Date retime = db.getDate(j++);
                CioPart obj = new CioPart(ciopart,ciocompany,name,sex,job,mobile,tel,dept,email,fax,address,zip,talk,tourism,room,shuttle,member,cometrain,cometime,backroom,backtrain,backtime,cioclerkid,stel,seat,bd,vip,rname,rchamber,rstime,retime);
                _cache.put(ciopart,obj);
                v.add(obj);
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void set(String name,boolean sex,String job,String mobile,String tel,String dept,String email,String fax,String address,String zip,boolean talk,String tourism,boolean room,boolean shuttle) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CioPart SET name=" + DbAdapter.cite(name) + ",sex=" + DbAdapter.cite(sex) + ",job=" + DbAdapter.cite(job) + ",mobile=" + DbAdapter.cite(mobile) + ",tel=" + DbAdapter.cite(tel) + ",dept=" + DbAdapter.cite(dept) + ",email=" + DbAdapter.cite(email) + ",fax=" + DbAdapter.cite(fax) + ",address=" + DbAdapter.cite(address) + ",zip=" + DbAdapter.cite(zip) + ",talk=" + DbAdapter.cite(talk) + ",tourism=" + DbAdapter.cite(tourism) + ",room=" + DbAdapter.cite(room) + ",shuttle=" + DbAdapter.cite(shuttle) + " WHERE ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
        this.name = name;
        this.sex = sex;
        this.job = job;
        this.mobile = mobile;
        this.tel = tel;
        this.dept = dept;
        this.email = email;
        this.fax = fax;
        this.address = address;
        this.zip = zip;
        this.talk = talk;
        this.tourism = tourism;
        this.room = room;
        this.shuttle = shuttle;
    }

    public void set(String cometrain,Date cometime,Date backroom,String backtrain,Date backtime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CioPart SET cometrain=" + DbAdapter.cite(cometrain) + ",cometime=" + DbAdapter.cite(cometime) + ",backroom=" + DbAdapter.cite(backroom) + ",backtrain=" + DbAdapter.cite(backtrain) + ",backtime=" + DbAdapter.cite(backtime) + " WHERE ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
        this.cometrain = cometrain;
        this.cometime = cometime;
        this.backroom = backroom;
        this.backtrain = backtrain;
        this.backtime = backtime;
    }

    public void set(String rname,String rchamber,Date rstime,Date retime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CioPart SET rname=" + DbAdapter.cite(rname) + ",rchamber=" + DbAdapter.cite(rchamber) + ",rstime=" + DbAdapter.cite(rstime) + ",retime=" + DbAdapter.cite(retime) + " WHERE ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
        this.rname = rname;
        this.rchamber = rchamber;
        this.rstime = rstime;
        this.retime = retime;
    }

    public void set(String rname,String rchamber,Date rstime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CioPart SET rname=" + DbAdapter.cite(rname) + ",rchamber=" + DbAdapter.cite(rchamber) + ",rstime=" + DbAdapter.cite(rstime) + " WHERE ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
        this.rname = rname;
        this.rchamber = rchamber;
        this.rstime = rstime;
    }

    public void set1(boolean bd,boolean vip,boolean seat,int cioclerkid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CioPart SET bd=" + DbAdapter.cite(bd) + ",vip=" + DbAdapter.cite(vip) + ",seat=" + DbAdapter.cite(seat) + ",cioclerkid=" + cioclerkid + " WHERE ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
        this.bd = bd;
        this.vip = vip;
        this.seat = seat;
        this.cioclerkid = cioclerkid;
    }


    public void set(int cioclerkid,String stel) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CioPart SET shuttle=1, cioclerkid=" + cioclerkid + ",stel=" + DbAdapter.cite(stel) + " WHERE ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
        this.cioclerkid = cioclerkid;
        this.stel = stel;
    }

//    public void set(String name) throws SQLException,IOException
//    {
//        int j = 0;
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            j = db.executeUpdate("UPDATE CioPart SET secret=" + DbAdapter.cite(secret) + ",automessage=" + DbAdapter.cite(automessage) + " WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
//        } finally
//        {
//            db.close();
//        }
//        if(j < 1)
//        {
//            create(community,member,secret,balance,automessage,message);
//        }
//        this.secret = secret;
//        this.automessage = automessage;
//        this.exists = true;
//    }

//    public void setMessage(int i,String name) throws SQLException
//    {
//        int j = 0;
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            j = db.executeUpdate("UPDATE CioPart SET message" + i + "=" + DbAdapter.cite(name) + " WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
//        } finally
//        {
//            db.close();
//        }
//        message[i] = name;
//        if(j < 1)
//        {
//            create(community,member,secret,balance,automessage,message);
//        }
//    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM CioPart WHERE ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
        _cache.remove(ciopart);
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getName()
    {
        return name;
    }

    public String getZip()
    {
        return zip;
    }

    public String getTourism()
    {
        return tourism;
    }

    public String getTourismToHtml()
    {
        if(tourism == null)
        {
            return "";
        }
        StringBuilder h = new StringBuilder();
        String ts[] = tourism.split("/");
        for(int i = 1;i < ts.length;i++)
        {
            h.append(TOURISM_TYPE[i]).append(" ");
        }
        return h.toString();
    }

    public String getTel()
    {
        return tel;
    }

    public boolean isTalk()
    {
        return talk;
    }

    public boolean isSex()
    {
        return sex;
    }

    public boolean isRoom()
    {
        return room;
    }

    public boolean isBd()
    {
        return bd;
    }

    public boolean isSeat()
    {
        return seat;
    }


    public boolean isVip()
    {
        return vip;
    }


    public String getMobile()
    {
        return mobile;
    }

    public String getJob()
    {
        return job;
    }

    public String getFax()
    {
        return fax;
    }

    public String getEmail()
    {
        return email;
    }

    public String getDept()
    {
        return dept;
    }

    public int getCioCompany()
    {
        return ciocompany;
    }

    public String getAddress()
    {
        return address;
    }

    public String getMember()
    {
        return member;
    }

    public String getRchamber()
    {
        return rchamber;
    }

    public Date getRetime()
    {
        return retime;
    }

    public String getRetimeToString()
    {
        if(retime == null)
        {
            return "";
        }
        return sdf.format(retime);
    }


    public String getRname()
    {
        return rname;
    }

    public Date getRstime()
    {
        return rstime;
    }

    public boolean isShuttle()
    {
        return shuttle;
    }

    public String getRstimeToString()
    {
        if(rstime == null)
        {
            return "";
        }
        return sdf.format(rstime);
    }


    public String getSTel()
    {
        return stel;
    }

    public int getCioClerkid()
    {
        return cioclerkid;
    }

    public Date getBackRoom()
    {
        return backroom;
    }

    public String getBackRoomToString()
    {
        if(backroom == null)
        {
            return "";
        }
        return sdf.format(backroom);
    }


    public Date getBackTime()
    {
        return backtime;
    }

    public String getBackTimeToString()
    {
        if(backtime == null)
        {
            return "";
        }
        return sdf.format(backtime);
    }

    public int getBackTimeH()
    {
        if(backtime == null)
        {
            return 9;
        }
        Calendar c = Calendar.getInstance();
        c.setTime(backtime);
        return c.get(Calendar.HOUR);
    }

    public int getBackTimeM()
    {
        if(backtime == null)
        {
            return 0;
        }
        Calendar c = Calendar.getInstance();
        c.setTime(backtime);
        return c.get(Calendar.MINUTE);
    }


    public String getBackTrain()
    {
        return backtrain;
    }


    public Date getComeTime()
    {
        return cometime;
    }

    public String getComeTimeToString()
    {
        if(cometime == null)
        {
            return "";
        }
        return CioPart.sdf.format(cometime);
    }

    public int getComeTimeH()
    {
        if(cometime == null)
        {
            return 9;
        }
        Calendar c = Calendar.getInstance();
        c.setTime(cometime);
        return c.get(Calendar.HOUR);
    }

    public int getComeTimeM()
    {
        if(cometime == null)
        {
            return 0;
        }
        Calendar c = Calendar.getInstance();
        c.setTime(cometime);
        return c.get(Calendar.MINUTE);
    }

    public String getComeTrain()
    {
        return cometrain;
    }

    public int getCioPart()
    {
        return ciopart;
    }

    public void setMember(String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CioPart SET member=" + DbAdapter.cite(member) + " WHERE ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
        this.member = member;
    }

    public static Enumeration findCioPart(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ciopart FROM CioPart WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void setBd(boolean bd) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ciopart SET bd=" + DbAdapter.cite(bd) + " WHERE ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
        this.bd = bd;
    }

    public void setVip(boolean vip) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ciopart SET vip=" + DbAdapter.cite(vip) + " WHERE ciopart=" + ciopart);
        } finally
        {
            db.close();
        }
        this.vip = vip;
    }


}
