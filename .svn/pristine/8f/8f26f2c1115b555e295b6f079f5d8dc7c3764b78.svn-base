package tea.entity.admin.orthonline;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class CaseCollection extends Entity
{
    private int id; //
    private String community;
    private Date regtime;
    private String member;
    private String mobilephone; //community,regtime,member,mobilephone,casename,sex,age,chief,gjttpain,doingsxbw,gjttother,heartpain,weichangdao,otherpain,jointjixingbw,jointyatongbw,otheryichang,yingxiang,yichang,gjttnumfrist,chubuzhenduan,zzjingguo,gjttnumlast,taolun,yxfirstpath,yxlastpath,type,diannum
    private String casename; //标题名称
    private int sex; //性别
    private String age; //年龄
    private String chief; //主诉
    private String gjttpain; //疼痛情况
	private String doingsxbw; //活动受限情况
    private String gjttother; //其他情况
    private String heartpain; //心脑血管病史
    private String weichangdao; //胃肠道疾病史
    private String otherpain; //其他特殊病史或服药史
    private String jointjixingbw; //畸形情况
    private String jointyatongbw; //压痛情况
    private String otheryichang; //其他异常
    private String yingxiang; //影像学检查
    private String yichang; //有异常的实验室检查
    private int gjttnumfrist; //治疗前患者关节疼痛程度总体评估
    private String chubuzhenduan; //初步诊断
    private String zzjingguo; //诊治经过
    private int gjttnumlast; //治疗后患者关节疼痛程度总体评估
    private String taolun; //讨论
    private String yxfirstpath; //治疗前图片
    private String yxlastpath; //治疗后图片
    private int diannum;
    private int type;
    private String yxfirstpath2; //治疗前图片
    private String yxlastpath2; //治疗后图片
    private String yxfirstpath3; //治疗前图片
    private String yxlastpath3; //治疗后图片
    private String yxfirstpath4; //治疗前图片
    private String yxlastpath4; //治疗后图片
    private String yxfirstpath5; //治疗前图片
    private String yxlastpath5; //治疗后图片
	private String firstname; //firstname,address
    private String address;//医院名称
	private String yxfirstpathname; //治疗前图片
	private String yxlastpathname; //治疗后图片
	private String yxfirstpathname2; //治疗前图片
	private String yxlastpathname2; //治疗后图片
	private String yxfirstpathname3; //治疗前图片
	private String yxlastpathname3; //治疗后图片
	private String yxfirstpathname4; //治疗前图片
	private String yxlastpathname4; //治疗后图片
	private String yxfirstpathname5; //治疗前图片
    private String yxlastpathname5; //治疗后图片
    private String zhuanjiadp; //专家点评
    private Date updatetime;
    private String zjname; //专家名称
    private String zjyy; //专家所在医院
    
    //2009-09-28添加的
    private String result;//结果
    private String discuss;//讨论
    private String documents;//参考文献
    private String ana;//英雄语录(您执业生涯中的感言)

    private boolean exists;

    public static final String GJTTBUWEI[] =
            {"左","右","双侧"};
    public static final String NUM[] =
            {"0","1","2","3","4","5","6","7","8","9","10"};
    public static final String YOUWU[] =
            {"有","无"};
    public static final String SEXS[] =
            {"男","女"};
    public static final String YOUWUGUAN[] =
            {"有关","无关"};

    public static CaseCollection find(int id) throws SQLException
    {
        return new CaseCollection(id);
    }

    public CaseCollection(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,community,regtime,member,mobilephone,casename,sex,age,chief,gjttpain,doingsxbw,gjttother,heartpain,weichangdao,otherpain,jointjixingbw," +
            		"jointyatongbw,otheryichang,yingxiang,yichang,gjttnumfrist,chubuzhenduan,zzjingguo,gjttnumlast,taolun,yxfirstpath,yxlastpath,type,diannum,yxfirstpath2,yxlastpath2," +
            		"yxfirstpath3,yxlastpath3,yxfirstpath4,yxlastpath4,yxfirstpath5,yxlastpath5,firstname,address,yxfirstpathname,yxlastpathname,yxfirstpathname2,yxlastpathname2," +
            		"yxfirstpathname3,yxlastpathname3,yxfirstpathname4,yxlastpathname4,yxfirstpathname5," +
            		"yxlastpathname5,zhuanjiadp,updatetime,zjname,zjyy,result,discuss,documents,ana  from CaseCollection where id=" + id);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                community = db.getString(j++);
                regtime = db.getDate(j++);
                member = db.getString(j++);
                mobilephone = db.getString(j++);
                casename = db.getString(j++);
                sex = db.getInt(j++);
                age = db.getString(j++);
                chief = db.getString(j++);
                gjttpain = db.getString(j++);
                doingsxbw = db.getString(j++);
                gjttother = db.getString(j++);
                heartpain = db.getString(j++);
                weichangdao = db.getString(j++);
                otherpain = db.getString(j++);
                jointjixingbw = db.getString(j++);
                jointyatongbw = db.getString(j++);
                otheryichang = db.getString(j++);
                yingxiang = db.getString(j++);
                yichang = db.getString(j++);
                gjttnumfrist = db.getInt(j++);
                chubuzhenduan = db.getString(j++);
                zzjingguo = db.getString(j++);
                gjttnumlast = db.getInt(j++);
                taolun = db.getString(j++);
                yxfirstpath = db.getString(j++);
                yxlastpath = db.getString(j++);
                type = db.getInt(j++);
                diannum = db.getInt(j++);
                yxfirstpath2 = db.getString(j++); //
                yxlastpath2 = db.getString(j++);
                yxfirstpath3 = db.getString(j++);
                yxlastpath3 = db.getString(j++);
                yxfirstpath4 = db.getString(j++);
                yxlastpath4 = db.getString(j++);
                yxfirstpath5 = db.getString(j++);
                yxlastpath5 = db.getString(j++);
                firstname = db.getString(j++);
                address = db.getString(j++); //,firstname,address
                yxfirstpathname = db.getString(j++);
                yxlastpathname = db.getString(j++);
                yxfirstpathname2 = db.getString(j++);
                yxlastpathname2 = db.getString(j++);
                yxfirstpathname3 = db.getString(j++);
                yxlastpathname3 = db.getString(j++);
                yxfirstpathname4 = db.getString(j++);
                yxlastpathname4 = db.getString(j++);
                yxfirstpathname5 = db.getString(j++);
                yxlastpathname5 = db.getString(j++);
                zhuanjiadp = db.getString(j++);
                updatetime = db.getDate(j++);
                zjname = db.getString(j++); //专家名称
                zjyy = db.getString(j++); //专家所在医院
                result =db.getString(j++);
                discuss =db.getString(j++);
                documents =db.getString(j++);
                ana  = db.getString(j++);
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

    public static void set(int id,String community,Date regtime,String member,String mobilephone,String casename,int sex,String age,String chief,String gjttpain,String doingsxbw,
    		String gjttother,String heartpain,String weichangdao,String otherpain,String jointjixingbw,String jointyatongbw,String otheryichang,String yingxiang,String yichang,
    		int gjttnumfrist,String chubuzhenduan,String zzjingguo,int gjttnumlast,String taolun,String yxfirstpath,String yxlastpath,int type,String yxfirstpath2,String yxlastpath2,
    		String yxfirstpath3,String yxlastpath3,String yxfirstpath4,String yxlastpath4,String yxfirstpath5,String yxlastpath5,String firstname,String address,String yxfirstpathname,
    		String yxlastpathname,String yxfirstpathname2,String yxlastpathname2,String yxfirstpathname3,String yxlastpathname3,String yxfirstpathname4,String yxlastpathname4,
    		String yxfirstpathname5,String yxlastpathname5,String zhuanjiadp,String result ,String discuss ,String documents ,String ana,
    		String zjname,String zjyy) throws SQLException
    {
        DbAdapter db = new DbAdapter();
		Date date = new Date();
        try
        {
            db.executeQuery("select id from CaseCollection where id=" + id);
            if(db.next())
            {
                db.executeUpdate("Update CaseCollection set community=" + db.cite(community) + ",updatetime=" + db.cite(regtime) + ",member=" + db.cite(member) + ",mobilephone=" + db.cite(mobilephone) + ",casename=" + db.cite(casename) + ",sex=" + sex + ",age=" + db.cite(age) + ",chief=" + db.cite(chief) + ",gjttpain=" + db.cite(gjttpain) + ",doingsxbw=" + db.cite(doingsxbw) + ",gjttother=" + db.cite(gjttother) + ",heartpain=" + db.cite(heartpain) + ",weichangdao=" + db.cite(weichangdao) + ",otherpain=" + db.cite(otherpain) + ",jointjixingbw=" + db.cite(jointjixingbw) + ",jointyatongbw=" + db.cite(jointyatongbw) + ",otheryichang=" + db.cite(otheryichang) + ",yingxiang=" + db.cite(yingxiang) + ",yichang=" + db.cite(yichang) + ",gjttnumfrist=" + gjttnumfrist + ",chubuzhenduan=" +
                                 db.cite(chubuzhenduan) + ",zzjingguo=" + db.cite(zzjingguo) + ",gjttnumlast=" + gjttnumlast + ",taolun=" + db.cite(taolun) + ",yxfirstpath=" + db.cite(yxfirstpath) + ",yxlastpath=" + db.cite(yxlastpath) + ",type=" + type + ",yxfirstpath2=" + db.cite(yxfirstpath2) + ",yxlastpath2=" + db.cite(yxlastpath2) + ",yxfirstpath3=" + db.cite(yxfirstpath3) + ",yxlastpath3="
                                 + db.cite(yxlastpath3) + ",yxfirstpath4=" + db.cite(yxfirstpath4) + ",yxlastpath4=" + db.cite(yxlastpath4) + ",yxfirstpath5=" + db.cite(yxfirstpath5) + ",yxlastpath5=" + db.cite(yxlastpath5) + ",firstname=" + db.cite(firstname) + ",address=" + db.cite(address) + ",yxfirstpathname=" + db.cite(yxfirstpathname) + ",yxlastpathname=" + db.cite(yxlastpathname) + ",yxfirstpathname2=" + db.cite(yxfirstpathname2) + ",yxlastpathname2=" + db.cite(yxlastpathname2) + ",yxfirstpathname3=" + db.cite(yxfirstpathname3) + ",yxlastpathname3=" + db.cite(yxlastpathname3) + ",yxfirstpathname4=" + db.cite(yxfirstpathname4) + ",yxlastpathname4=" + db.cite(yxlastpathname4) + ",yxfirstpathname5=" + db.cite(yxfirstpathname5) + ",yxlastpathname5=" + db.cite(yxlastpathname5) +
                                 ",zhuanjiadp=" + db.cite(zhuanjiadp) + ",zjname="+db.cite(zjname)+" ,zjyy="+db.cite(zjyy)+",result="+db.cite(result )+",discuss="+db.cite(discuss)+",documents="+db.cite(documents)+",ana="+db.cite(ana)+"  where id =" + id);
            } else
            {
                db.executeUpdate("Insert into CaseCollection (community,regtime,member,mobilephone,casename,sex,age,chief,gjttpain,doingsxbw,gjttother,heartpain,weichangdao,otherpain,jointjixingbw,jointyatongbw,otheryichang,yingxiang,yichang,gjttnumfrist,chubuzhenduan,zzjingguo,gjttnumlast,taolun,yxfirstpath,yxlastpath,type,diannum,yxfirstpath2,yxlastpath2,yxfirstpath3,yxlastpath3,yxfirstpath4,yxlastpath4,yxfirstpath5,yxlastpath5,firstname,address,yxfirstpathname,yxlastpathname,yxfirstpathname2,yxlastpathname2,yxfirstpathname3,yxlastpathname3,yxfirstpathname4,yxlastpathname4,yxfirstpathname5,yxlastpathname5,zhuanjiadp,zjname,zjyy,result,discuss,documents,ana)values(" + db.cite(community) + "," + db.cite(date) + "," + db.cite(member) + "," + db.cite(mobilephone) + "," + db.cite(casename) + "," + sex + "," + db.cite(age) + "," +
                                 db.cite(chief) + "," + db.cite(gjttpain) + "," + db.cite(doingsxbw) + "," + db.cite(gjttother) + "," + db.cite(heartpain) + "," + db.cite(weichangdao) + "," +
                                 db.cite(otherpain) + "," + db.cite(jointjixingbw) + "," + db.cite(jointyatongbw) + "," + db.cite(otheryichang) + "," + db.cite(yingxiang) + "," + db.cite(yichang) + "," + gjttnumfrist + "," + db.cite(chubuzhenduan) + "," + db.cite(zzjingguo) + "," + gjttnumlast + "," + db.cite(taolun) + "," + db.cite(yxfirstpath) + "," + db.cite(yxlastpath
                                 ) + "," + type + "," + 0 + "," + db.cite(yxfirstpath2) + "," + db.cite(yxlastpath2) + "," + db.cite(yxfirstpath3) + "," + db.cite(yxlastpath3) + "," + db.cite(yxfirstpath4) + "," + db.cite(yxlastpath4) + "," + db.cite(yxfirstpath5) + "," + db.cite(yxlastpath5) + "," + db.cite(firstname) + "," + db.cite(address) + "," + db.cite(yxfirstpathname) +
                                 "," + db.cite(yxlastpathname) + "," + db.cite(yxfirstpathname2) + "," + db.cite(yxlastpathname2) + "," + db.cite(yxfirstpathname3) + "," + db.cite(yxlastpathname3) + "," + db.cite(yxfirstpathname4) + "," + db.cite(yxlastpathname4) + "," + db.cite(yxfirstpathname5) + "," + db.cite(yxlastpathname5) + "," + db.cite(zhuanjiadp) + ","+db.cite(zjname) +","+db.cite(zjyy)+","+db.cite(result)+","+db.cite(discuss)+","+db.cite(documents)+","+db.cite(ana)+" )");
            }
        } finally
        {
            db.close();
        }

    }

    public static Enumeration findByCommunity(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM CaseCollection WHERE community=" + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("Select count(id) from CaseCollection where community= " + db.cite(community) + "  " + sql);
            if(db.next())
            {
                num = db.getInt(1);
                return num;
            } else
            {
                return num;
            }
        } finally
        {
            db.close();
        }
    }

    public static int gettel(String mobilephone) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from CaseCollection where mobilephone=" + db.cite(mobilephone));
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;
    }

    public static int getMembers(String member) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id from CaseCollection where member=" + db.cite(member));
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;
    }

    //审核病例
    public static void setType(int id,int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Update CaseCollection set type=" + type + " where id=" + id);
        } finally
        {
            db.close();
        }
    }

    public static void delete(int id) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("Delete CaseCollection where id=" + id);
        } finally
        {
            db.close();
        }

    }
	//
	public static void setDiannum(int id)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int num=0;
		try
		{
			db.executeQuery("select diannum from CaseCollection where id="+id);
			if(db.next())
			{
				num=db.getInt(1)+1;
            } else
            {
                num = 1;
            }
            db.executeUpdate("Update CaseCollection set diannum=" + num + "   where  id =" + id);
		}
		finally
		{
			db.close();
		}

	}

	public static int  getId(String sql)throws SQLException
	{
		DbAdapter db = new DbAdapter();
		int num=0;
		try
		{
			db.executeQuery("select id from CaseCollection where 1=1  "+sql);
			if(db.next())
			{
				num=db.getInt(1);
			}
		}
		finally
		{
			db.close();
		}
		return num;
	}
    public static int sun(String sql) throws SQLException
    {
		DbAdapter db= new DbAdapter() ;
		int num=0;
		try
		{
			db.executeQuery("select sum(diannum) from CaseCollection where 1=1 "+sql);
			if(db.next())
			{
				num = db.getInt(1);
			}
		}
		finally
		{
			db.close();
		}
		return num;
    }


    public String getRegtimetoString()
    {
        if(regtime != null)
        {
            return CaseCollection.sdf.format(regtime);
        } else
        {
            return "";
        }
    }
    public String getAge()
    {
        return age;
    }

    public String getCasename()
    {
        return casename;
    }

    public String getChief()
    {
        return chief;
    }

    public String getChubuzhenduan()
    {
        return chubuzhenduan;
    }

    public String getDoingsxbw()
    {
        return doingsxbw;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getGjttnumfrist()
    {
        return gjttnumfrist;
    }

    public int getGjttnumlast()
    {
        return gjttnumlast;
    }

    public String getGjttother()
    {
        return gjttother;
    }

    public String getGjttpain()
    {
        return gjttpain;
    }

    public String getHeartpain()
    {
        return heartpain;
    }

    public String getJointjixingbw()
    {
        return jointjixingbw;
    }

    public int getId()
    {
        return id;
    }

    public String getJointyatongbw()
    {
        return jointyatongbw;
    }

    public String getMember()
    {
        return member;
    }

    public String getMobilephone()
    {
        return mobilephone;
    }

    public String getOtherpain()
    {
        return otherpain;
    }

    public String getOtheryichang()
    {
        return otheryichang;
    }

    public Date getRegtime()
    {
        return regtime;
    }

    public String getTaolun()
    {
        return taolun;
    }

    public int getType()
    {
        return type;
    }

    public String getWeichangdao()
    {
        return weichangdao;
    }

    public String getYichang()
    {
        return yichang;
    }

    public String getYingxiang()
    {
        return yingxiang;
    }

    public String getYxfirstpath()
    {
        return yxfirstpath;
    }

    public String getYxlastpath()
    {
        return yxlastpath;
    }

    public String getZzjingguo()
    {
        return zzjingguo;
    }

    public String getCommunity()
    {
        return community;
    }

    public int getSex()
    {
        return sex;
    }

    public int getDiannum()
    {
        return diannum;
    }

    public String getYxlastpath5()
    {
        return yxlastpath5;
    }

    public String getYxlastpath4()
    {
        return yxlastpath4;
    }

    public String getYxlastpath3()
    {
        return yxlastpath3;
    }

    public String getYxlastpath2()
    {
        return yxlastpath2;
    }

    public String getYxfirstpath5()
    {
        return yxfirstpath5;
    }

    public String getYxfirstpath4()
    {
        return yxfirstpath4;
    }

    public String getYxfirstpath3()
    {
        return yxfirstpath3;
    }

    public String getYxfirstpath2()
    {
        return yxfirstpath2;
    }

    public String getFirstname()
    {
        return firstname;
    }
    public String getAddress()
    {
        return address;
    }

    public String getYxfirstpathname()
    {
        return yxfirstpathname;
    }

    public String getYxfirstpathname2()
    {
        return yxfirstpathname2;
    }

    public String getYxfirstpathname3()
    {
        return yxfirstpathname3;
    }

    public String getYxfirstpathname4()
    {
        return yxfirstpathname4;
    }

    public String getYxfirstpathname5()
    {
        return yxfirstpathname5;
    }

    public String getYxlastpathname()
    {
        return yxlastpathname;
    }

    public String getYxlastpathname2()
    {
        return yxlastpathname2;
    }

    public String getYxlastpathname3()
    {
        return yxlastpathname3;
    }

    public String getYxlastpathname4()
    {
        return yxlastpathname4;
    }

    public String getYxlastpathname5()
    {
        return yxlastpathname5;
    }

    public String getZhuanjiadp()
    {
        return zhuanjiadp;
    }

    public Date getUpdatetime()
    {
        return updatetime;
    }

    public String getZjname() 
    {
        return zjname;
    }

    public String getZjyy()
    {
        return zjyy;
    }
    public String getResult()
    {
        return result;
    }
    public String getDiscuss()
    {
        return discuss;
    }
    public String getDocuments()
    {
    	return documents;
    }
    public String getAna()
    {
    	return ana;
    }
}
