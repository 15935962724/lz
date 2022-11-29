package tea.entity.admin.sales;

import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;

/**
 *
 * 需要添加的字段 部门dept： 传真： 确认口令：称谓： 潜在客户类别 ： 注册时间： 修改更改的字段 职务duty： 省份province：
 */

public class Latency extends Entity
{
    private int id;
    private String holder;
    private int states;
    private String family;
    private String firsts;
    private String telephone;
    private String email;
    private String corp;
    private int grade;
    private int duty;
    private String country;
    private int postalcode;
    private int province;
    private String city;
    private String street;
    private String webaddress;
    private int counts;
    private int origin;
    private int income; // 货币类型
    private int calling;
    private String remark;
    private Date times;
    private String member;
    private Date times1;
    private String member1;

    private int latencytype;
    private Date latecyDate;
    private int sex;
    private String pwd;
    private String dept;
    private String inc_fax;
    private String handset;
	private int type;//表示是否还是潜在客户，0 默认是潜在客户 1 是成为客户
	private int audit;//0没审核 1审核通过 2审核没通过

    private boolean exists;
    private static Cache _cache = new Cache(100);
    public static final String HOLDER[] =
                                          {"--------", "未处理", "以联系", "不合格", "合格"};
    public static final String GRADE[] =
                                         {"------", "热", "暖", "冷"};
    public static final String ORIGIN[] =
                                          {"-------", "广告", "职员引介", "外部引介", "合作伙伴", "公共关系", "研讨会-内部", "研讨会-合作伙伴", "贸易展览", "Web", "口头传达", "其他"};
    public static final String LYTYPES[] =
                                           {"-------", "企业用户", "个人用户", "合作伙伴", "其他"};

    public static final String PROVINCES[] =
                                             {"请选择下面的一项", "北京市", "天津市", "河北省", "山西省", "辽宁省", "吉林省", "上海市", "江苏省", "浙江省", "安徽省", "福建省", "江西省", "山东省", "河南省", "内蒙古自治区", "黑龙江省", "湖北省", "湖南省", "广东省", "广西壮族自治区", "海南省", "四川省", "重庆市", "贵州省", "云南省", "西藏自治区", "陕西省", "甘肃省", "青海省", "宁夏回族自治区", "新疆维吾尔自治区", "香港特别行政区", "澳门特别行政区", "台湾地区", "东南亚", "欧洲", "南美洲", "澳洲", "非洲", "美国", "加拿大", "新加坡", "韩国", "其他"};

    public static final String DUTYS[] =
                                         {"请选择下面的一项", "开发工程师", "系统工程师", "架构师", "业务咨询师", "技术咨询师", "媒体/分析师", "教授/教师", "销售人员", "学生", "项目经理", "IT项目经理", "市场/销售经理", "技术开发总监", "IT部门总监", "市场/销售总监", "信息技术总监", "首席技术执行官", "首席信息执行官", "首席财务执行官", "首席执行官", "其他"};

    public static final String SEXS[] =
                                        {"先生", "女士"};

    public Latency(int id) throws SQLException
    {
        this.id = id;
        load();
    }

    public static Latency find(int id) throws SQLException
    {
        return new Latency(id);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select holder,states,family,firsts,telephone,email,corp,grade,duty,country,postalcode,province,city,street,webaddress,counts,origin,income,calling,remark,times,member,times1,member1,latencytype,latecyDate,sex,pwd,dept,inc_fax,handset,type,audit from Latency where id=" + id);
            if (db.next())
            {
                holder = db.getVarchar(1, 1, 1);
                states = db.getInt(2);
                family = db.getVarchar(1, 1, 3);
                firsts = db.getVarchar(1, 1, 4);
                telephone = db.getString(5);
                email = db.getString(6);
                corp = db.getVarchar(1, 1, 7);
                grade = db.getInt(8);
                duty = db.getInt(9);
                country = db.getVarchar(1, 1, 10);
                postalcode = db.getInt(11);
                province = db.getInt(12);
                city = db.getVarchar(1, 1, 13);
                street = db.getVarchar(1, 1, 14);
                webaddress = db.getString(15);
                counts = db.getInt(16);
                origin = db.getInt(17);
                income = db.getInt(18);
                calling = db.getInt(19);
                remark = db.getVarchar(1, 1, 20);
                times = db.getDate(21);
                member = db.getVarchar(1, 1, 22);
                times1 = db.getDate(23);
                member1 = db.getVarchar(1, 1, 24);
                latencytype = db.getInt(25);
                latecyDate = db.getDate(26);
                sex = db.getInt(27);
                pwd = db.getString(28);
                dept = db.getString(29);
                inc_fax = db.getString(30);
                handset = db.getString(31);
				type=db.getInt(32);
				audit = db.getInt(33);

            } else
            {
                this.exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static int create(String holder, int states, String family, String firsts, String telephone, String email, String corp, int grade, int duty, String country, int postalcode, int province, String city, String street, String webaddress, int counts, int origin, int income, int calling, String remark, String community, RV _rv) throws SQLException
    {
        int id = 0;
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("INSERT INTO Latency(holder,states,family,firsts,telephone,email,corp,grade,duty,country,postalcode,province,city,street,webaddress,counts,origin,income,calling,remark,times,community,member)VALUES(" + DbAdapter.cite(holder) + "," + states + "," + DbAdapter.cite(family) + "," + DbAdapter.cite(firsts) + "," + DbAdapter.cite(telephone) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(corp) + "," + grade + "," + duty + "," + DbAdapter.cite(country) + "," + postalcode + "," + province + "," + DbAdapter.cite(city) + ","
                             + DbAdapter.cite(street) + "," + DbAdapter.cite(webaddress) + "," + counts + "," + origin + "," + income + "," + calling + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(times) + "," + DbAdapter.cite(community) + ",'" + _rv + "'  )  ");
            id = db.getInt("SELECT MAX(id) FROM Latency");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public static int createTemp(int latencytype, String email, String pwd, int sex, String family, String firsts, String corp, int calling, int duty, String dept, String country, int postalcode, String telephone, String inc_fax, String handset, int province, String city, String community, RV _rv) throws SQLException
    {
        int id = 0;
        Date times = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Latency(latencytype,email,pwd,sex,family,firsts,corp,calling,duty,dept,country,postalcode,telephone,inc_fax,handset,province,city,community, member,latecyDate,audit) values(" + latencytype + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(pwd) + "," + sex + "," + DbAdapter.cite(family) + "," + DbAdapter.cite(firsts) + "," + DbAdapter.cite(corp) + "," + calling + "," + duty + "," + DbAdapter.cite(dept) + "," + DbAdapter.cite(country) + "," + postalcode + "," + DbAdapter.cite(telephone) + "," + DbAdapter.cite(inc_fax)
                             + "," + DbAdapter.cite(handset) + "," + province + "," + DbAdapter.cite(city) + "," + DbAdapter.cite(community) + ",'" + _rv + "'" + "," + DbAdapter.cite(times) + ",0)");
            id = db.getInt("SELECT MAX(id) FROM Latency");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
        return id;
    }

    public static boolean createProfile(String member, String community, String password, Date birth, int type, int language, String firstName, String lastName, String email, String organization, String address, String city, String state, String zip, String country, String telephone, String fax, String webpage, String mobile) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeUpdate("INSERT INTO Profile(member,community, password, birth, type,time,mobile,email)VALUES (" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ", " + DbAdapter.cite(password) + ", " + DbAdapter.cite(birth) + "," + type + "," + db.citeCurTime() + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(email) + ")");
            db.executeUpdate("INSERT INTO ProfileLayer(member,community, language, firstname, lastname, organization, address, city, state, zip, country, telephone, fax, webpage)VALUES (" + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + ", " + language + "," + DbAdapter.cite(firstName) + ", " + DbAdapter.cite(lastName) + ", " + DbAdapter.cite(organization) + ", " + DbAdapter.cite(address) + "," + DbAdapter.cite(city) + ", " + DbAdapter.cite(state) + ", "
                             + DbAdapter.cite(zip) + "," + DbAdapter.cite(country) + ", " + DbAdapter.cite(telephone) + ", " + DbAdapter.cite(fax) + ", " + DbAdapter.cite(webpage) + ")");
        } finally
        {
            db.close();
        }
        Subscriber.create(community, new RV(member), 0);
        return true;
    }

    public void set(String holder, int states, String family, String firsts, String telephone, String email, String corp, int grade, int duty, String country, int postalcode, int province, String city, String street, String webaddress, int counts, int origin, int income, int calling, String remark, String community, RV _rv) throws SQLException
    {
        Date times1 = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Latency SET holder=" + DbAdapter.cite(holder) + ",states=" + states + ",family=" + DbAdapter.cite(family) + ",firsts=" + DbAdapter.cite(firsts) + ",telephone=" + DbAdapter.cite(telephone) + ",email=" + DbAdapter.cite(email) + ",corp =" + DbAdapter.cite(corp) + ",grade=" + grade + ",duty=" + duty + ",country=" + DbAdapter.cite(country) + ",postalcode=" + postalcode + ",province=" + province + ",city=" + DbAdapter.cite(city) + ",street=" + DbAdapter.cite(street) + ",webaddress=" + DbAdapter.cite(webaddress) + ",counts=" + counts
                             + ",origin=" + origin + ",income=" + income + ",calling=" + calling + ",remark=" + DbAdapter.cite(remark) + ",times1=" + DbAdapter.cite(times1) + ",community=" + DbAdapter.cite(community) + ",member1='" + _rv + "' WHERE id =" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));

    }

    // 校验
    public static boolean EmailOption(String Email) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select email from Latency where email=" + DbAdapter.cite(Email));
            if (db.next())
            {
                return true;
            } else
            {
                return false;
            }
        } catch (Exception ex)
        {
            throw new SQLException(ex.toString());
        }
    }

    public static java.util.Enumeration findByCommunity(String community, String sql) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Latency WHERE community=" + DbAdapter.cite(community) + sql);

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

	public static java.util.Enumeration find(String community, String sql, int pos, int page) throws SQLException
	{
		java.util.Vector vector = new java.util.Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT id FROM Latency WHERE community=" + DbAdapter.cite(community) + sql,pos,page);

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

	public static int count(String community, String sql) throws SQLException
	{
		int i = 0;
		DbAdapter db = new DbAdapter(1);
		try
		{
			i = db.getInt("SELECT COUNT(*) FROM Latency WHERE community="+db.cite(community) + sql);
		} finally
		{
			db.close();
		}
		return i;
	}



    public static int findByName(String community, String name) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Latency WHERE community=" + DbAdapter.cite(community) + " and  member=" + DbAdapter.cite(name));
            if (db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;
    }

    public static int findByTel(String community, String tel) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT id FROM Latency WHERE community=" + DbAdapter.cite(community) + " and  telephone=" + DbAdapter.cite(tel));
            if (db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;
    }
	//zhangjinshu 2009-05-12 修改是否是潜在客户的数值
    public void setType(int type) throws SQLException
    {
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Latency SET type = "+type+" WHERE id = "+id);
		} finally
		{
			db.close();
		}
    }

	public void setAudit(int audit) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Latency SET audit = "+audit+" WHERE id = "+id);
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
            db.executeUpdate("DELETE FROM Latency WHERE id=" + id);
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(id));
    }

	public static void delete(String email) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Latency WHERE email=" + db.cite(email));
			db.executeUpdate("DELETE FROM profile WHERE member=" + db.cite(email));
			db.executeUpdate("DELETE FROM profilelayer WHERE member=" + db.cite(email));
			db.executeUpdate("DELETE FROM worklinkman WHERE member=" + db.cite(email));
			db.executeUpdate("DELETE FROM workproject WHERE member=" + db.cite(email));
		} finally
		{
			db.close();
		}
	}


    public String getHolder()
    {
        return holder;
    }

    public int getStates()
    {
        return states;
    }

    public String getFamily()
    {
        return family;
    }

    public String getFirsts()
    {
        return firsts;
    }

    public String getTelephone()
    {
        return telephone;
    }

    public String getEmail()
    {
        return email;
    }

    public String getCorp()
    {
        return corp;
    }

    public int getGrade()
    {
        return grade;
    }

    public int getDuty()
    {
        return duty;
    }

    public String getCountry()
    {
        return country;
    }

    public int getPostalcode()
    {
        return postalcode;
    }

    public int getProvince()
    {
        return province;
    }

    public String getCity()
    {
        return city;
    }

    public String getStreet()
    {
        return street;
    }

    public String getWebaddress()
    {
        return webaddress;
    }

    public int getCounts()
    {
        return counts;
    }

    public int getOrigin()
    {
        return origin;
    }

    public int getIncome()
    {
        return income;
    }

    public int getCalling()
    {
        return calling;
    }

    public String getRemark()
    {
        return remark;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getMember()
    {
        return member;
    }

    public Date getTimes1()
    {
        return times1;
    }

    public String getMember1()
    {
        return member1;
    }

    public int getLatencytype()
    {
        return latencytype;
    }

    public Date getLatecyDate()
    {
        return latecyDate;
    }

	public String getLatecyDateToSting()
	{
		String ld = "";
		if(latecyDate!=null){
			ld = Latency.sdf2.format(latecyDate);
		}
		return ld;
	}


    public String getPassword()
    {
        return pwd;
    }

    public int getSex()
    {
        return sex;
    }

    public String getPwd()
    {
        return pwd;
    }

    public String getInc_fax()
    {
        return inc_fax;
    }

    public String getHandset()
    {
        return handset;
    }

    public String getDept()
    {
        return dept;
    }
	public int getType()
	{
		return type;
	}

    public int getAudit()
    {
        return audit;
    }
}
