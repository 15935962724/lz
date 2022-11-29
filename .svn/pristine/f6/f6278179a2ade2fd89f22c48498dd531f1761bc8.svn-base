package tea.entity.admin;

import java.sql.*;
import java.util.*;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;

public class AdminUsrRole
{
	public static Cache _cache = new Cache(100);
	public static final String CLASSES_TYPE[] =
			{"1169018015265","1169018023296","1169018028562"}; // 无,本部门,所有部门
	public String community;
	public int member;
	public String role = "/";
	public String zone;
	public String brand; // 商标 注:前缀'/0/'表示所有品牌.
	public String bbshost= "/"; // 版主
	public String bbsexpert; //专家
	public int unit; //主部门
	public String dept = "/"; //部门
	public String company; // 招聘公司
	public String classes = "/"; // 职位级别
	public String cachet; //印章
	public String golf; //分球会授权:会员可以管理的球场
	public int sequence; // 顺序
	public String options; //选项:1.不显示到组织机构中
	public String contentfunction; //内容菜单管理权限
	public String bbs;
	private boolean exists;

	public AdminUsrRole(String community,int member) throws SQLException
	{
		this.community = community;
		this.member = member;
	}

	public static AdminUsrRole find(String community,String member) throws SQLException
	{
		return find(community,Profile.find(member).getProfile());
	}

	public static AdminUsrRole find(String community,int member) throws SQLException
	{
		AdminUsrRole t = (AdminUsrRole) _cache.get(community + ":" + member);
		if(t == null)
		{
			ArrayList al = find(" AND community=" + DbAdapter.cite(community) + " AND member=" + member+" ORDER BY sequence",0,1);
			t = al.size() < 1 ? new AdminUsrRole(community,member) : (AdminUsrRole) al.get(0);
		}
		return t;
	}

	public void delete() throws SQLException
	{
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeUpdate("DELETE FROM AdminUsrRole WHERE community=" + db.cite(community) + " AND member=" + member);
		} finally
		{
			db.close();
		}
		_cache.remove(community + ":" + member);
	}

	public static Enumeration findByCommunity(String community,String sql) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeQuery("SELECT member FROM AdminUsrRole WHERE community=" + DbAdapter.cite(community) + " AND " + db.length("role") + ">2 " + sql + " ORDER BY sequence");
			while(db.next())
			{
				v.addElement(db.getString(1));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public static void create(String community,int member,String role,String zone,int unit,String classes,String options) throws SQLException
	{
		int sequence = (int) (System.currentTimeMillis() / 1000);
		String sql = "INSERT INTO AdminUsrRole(community,member,role,zone,unit,classes,options,sequence) VALUES (" + DbAdapter.cite(community) + "," + member + "," + DbAdapter.cite(role) + "," + DbAdapter.cite(zone) + "," + unit + "," + DbAdapter.cite(classes) + "," + DbAdapter.cite(options) + "," + sequence + ")";
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeUpdate(0,sql);
		} finally
		{
			db.close();
		}
		_cache.remove(community + ":" + member);
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeQuery("SELECT role,zone,brand,bbshost,bbsexpert,unit,dept,company,classes,cachet,golf,options,sequence,contentfunction,bbs FROM AdminUsrRole WHERE community=" + DbAdapter.cite(community) + " AND member=" + member);
			if(db.next())
			{
				role = cite(db.getString(1));
				zone = cite(db.getString(2));
				brand = cite(db.getString(3));
				bbshost = cite(db.getString(4));
				bbsexpert = cite(db.getString(5));
				unit = db.getInt(6);
				dept = cite(db.getString(7));
				company = cite(db.getString(8));
				classes = cite(db.getString(9));
				cachet = cite(db.getString(10));
				golf = cite(db.getString(11));
				options = cite(db.getString(12));
				sequence = db.getInt(13);
				contentfunction = db.getString(14);
				bbs = db.getString(15);
				exists = true;
			} else
			{
				role = bbs = dept = zone = brand = bbshost = bbsexpert = company = classes = cachet = golf = options = "/";
				exists = false;
			}
		} finally
		{
			db.close();
		}
	}

	private static String cite(String s)
	{
		return(s == null || s.length() < 1) ? "/" : s;
	}

	public static ArrayList find(String sql,int pos,int size) throws SQLException
	{
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT community,member,role,zone,brand,bbshost,bbsexpert,unit,dept,company,classes,cachet,golf,options,sequence,contentfunction,bbs FROM AdminUsrRole WHERE 1=1" + sql,pos,size);
			while(db.next())
			{
				int j = 1;
				AdminUsrRole t = new AdminUsrRole(db.getString(j++),db.getInt(j++));
				t.role = cite(db.getString(j++));
				t.zone = cite(db.getString(j++));
				t.brand = cite(db.getString(j++));
				t.bbshost = cite(db.getString(j++));
				t.bbsexpert = cite(db.getString(j++));
				t.unit = db.getInt(j++);
				t.dept = cite(db.getString(j++));
				t.company = cite(db.getString(j++));
				t.classes = cite(db.getString(j++));
				t.cachet = cite(db.getString(j++));
				t.golf = cite(db.getString(j++));
				t.options = cite(db.getString(j++));
				t.sequence = db.getInt(j++);
				t.contentfunction = db.getString(j++);
				t.bbs = db.getString(j++);
				t.exists = true;
				_cache.put(t.community + ":" + t.member,t);
				al.add(t);
			}
		} finally
		{
			db.close();
		}
		return al;
	}

	public static Enumeration find(String community,String member,String role,String unit) throws SQLException
	{
		StringBuilder sb = new StringBuilder();
		if(member.length() > 2)
		{
			sb.append(" OR member IN ('" + member.substring(1,member.length() - 1).replaceAll("/","','") + "')");
		}
		if(unit.length() > 2)
		{
			sb.append(" OR unit IN (" + unit.substring(1,unit.length() - 1).replace('/',',') + ")");
		}
//    String bs[] = bulletinid.split("/");
//    for (int i = 1; i < bs.length; i++)
//    {
//      sql.append(" OR classes LIKE ").append("'%/").append(bs[i]).append("/%'");
//    }
		String srs[] = role.split("/");
		for(int i = 1;i < srs.length;i++)
		{
			sb.append(" OR role LIKE '%/" + srs[i] + "/%'");
		}
		if(sb.length() > 0) //如果没有条件，表示全部
		{
			sb.insert(0," AND (1=0").append(")");
		}
		return find(community,sb.toString(),0,Integer.MAX_VALUE);
	}

	public static Enumeration findByUnit(int unit,String community) throws SQLException
	{
		String sql = " AND role!='/' AND unit=" + unit;
		return find(community,sql,0,Integer.MAX_VALUE);
	}

	//内容菜单管理权限添加
	public void setContentfunction(String contentfunction) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE AdminUsrRole SET contentfunction=" + db.cite(contentfunction) + "  WHERE community=" + DbAdapter.cite(community) + " AND member=" + member);
		} finally
		{
			db.close();
		}
		this.contentfunction = contentfunction;
	}

	public static Enumeration findByRole(int adminrole) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeQuery("SELECT member FROM AdminUsrRole WHERE role LIKE " + DbAdapter.cite("%/" + adminrole + "/%"));
			while(db.next())
			{
				v.addElement(db.getString(1));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public String getMember() throws SQLException
	{
		return Profile.find(member).getMember();
	}

	public String getRole()
	{
		return role;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getZone()
	{
		return zone;
	}

	public static Enumeration findByBrand(String community,int brand) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter(1);
		String sql = "SELECT member FROM AdminUsrRole WHERE community=" + DbAdapter.cite(community) + " AND " + db.length("brand") + ">2";
		if(brand != 0)
		{
			sql += " AND brand LIKE " + DbAdapter.cite("%/" + brand + "/%");
		}
		try
		{
			db.executeQuery(sql);
			while(db.next())
			{
				v.addElement(db.getString(1));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public static Enumeration findByBbshost(int node) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeQuery("SELECT member FROM AdminUsrRole WHERE bbshost LIKE '%/" + node + "/%'");
			while(db.next())
			{
				v.addElement(db.getString(1));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public boolean isProvider(int i) throws SQLException
	{
		return options != null && options.indexOf("/" + i + "/") != -1;
	}

	public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeQuery("SELECT member FROM AdminUsrRole WHERE community=" + DbAdapter.cite(community) + sql + " ORDER BY sequence",pos,size);
			while(db.next())
			{
				v.addElement(Profile.find(db.getInt(1)).getMember());
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	public static int count(String community,String sql) throws SQLException
	{
		int count = 0;
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeQuery("SELECT COUNT(*) FROM AdminUsrRole WHERE community=" + DbAdapter.cite(community) + sql);
			// System.out.println("SELECT COUNT(*) FROM AdminUsrRole WHERE community=" + DbAdapter.cite(community) + sql);
			if(db.next())
			{
				count = db.getInt(1);
			}
		} finally
		{
			db.close();
		}
		return count;
	}

	private void set_(String field,String value) throws SQLException
	{
		StringBuilder sql = new StringBuilder();
		if(exists)
		{
			sql.append("UPDATE AdminUsrRole SET ").append(field).append("=").append(DbAdapter.cite(value)).append(" WHERE community=").append(DbAdapter.cite(community)).append(" AND member=").append(member);
		} else
		{
			sql.append("INSERT INTO AdminUsrRole(community,member,").append(field).append(",sequence)VALUES(").append(DbAdapter.cite(community)).append(",").append(member).append(",").append(DbAdapter.cite(value)).append(",").append(System.currentTimeMillis() / 1000).append(")");
		}
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeUpdate(0,sql.toString());
		} finally
		{
			db.close();
		}
		this.exists = true;
	}

	public void setBrand(String brand) throws SQLException
	{
		set_("brand",brand);
		this.brand = brand;
	}

	public void setCachet(String cachet) throws SQLException
	{
		set_("cachet",cachet);
		this.cachet = cachet;
	}

	public void setOptions(String options) throws SQLException
	{
		set_("options",options);
		this.options = options;
	}

	public void setBbs(String bbs) throws SQLException
	{
		set_("bbs",bbs);
		this.bbs = bbs;
	}

	public void setRole(String role) throws SQLException
	{
		set_("role",role);
		this.role = role;
	}

	public void setGolf(String golf) throws SQLException
	{
		set_("golf",golf);
		this.golf = golf;
	}

	public void setBbsHost(String bbshost) throws SQLException
	{
		set_("bbshost",bbshost);
		this.bbshost = bbshost;
	}

	public void setUnit(int unit) throws SQLException
	{
		set_("unit",String.valueOf(unit));
		this.unit = unit;
	}

	public void setCompany(String company) throws SQLException
	{
		set_("company",company);
		this.company = company;
	}

	public void setClasses(String classes) throws SQLException
	{
		set_("classes",classes);
		this.classes = classes;
	}

	public void setSequence(int sequence) throws SQLException
	{
		set_("sequence",String.valueOf(sequence));
		this.sequence = sequence;
	}

	public void setDept(String dept) throws SQLException
	{
		set_("dept",dept);
		this.dept = dept;
	}

	public void setBbsExpert(String bbsexpert) throws SQLException
	{
		set_("bbsexpert",bbsexpert);
		this.bbsexpert = bbsexpert;
	}

    public String getAdminfunction(String ip) throws SQLException
    {
        boolean isE = ip.startsWith("192.") || ip.startsWith("10.");
        StringBuilder ids = new StringBuilder();
        ArrayList al = AdminRole.find(" AND community=" + DbAdapter.cite(community) + (MT.f(role).length() > 1 ? " AND id IN(" + role.substring(1).replace('/',',') + "0)" : " AND type=2"),0,200);
        for(int i = 0;i < al.size();i++)
        {
            AdminRole ar_obj = (AdminRole) al.get(i);
            ids.append(isE && ar_obj.distinguish ? ar_obj.getEthernet() : ar_obj.getAdminfunction());
        }
        return ids.toString();
    }

	public String getBrand()
	{
		return brand;
	}

	public String getBbsHost()
	{
		return bbshost;
	}

	public int getUnit()
	{
		return unit;
	}

	public String getCachet()
	{
		return cachet;
	}

	public String getOptions()
	{
		return options;
	}

	public String getCommunity()
	{
		return community;
	}

	public String getCompany()
	{
		return company;
	}

	public String getClasses() throws SQLException
	{
		StringBuilder sb = new StringBuilder("/");
		if(classes.length() > 2)
		{
			StringBuilder sql = new StringBuilder("SELECT id FROM AdminUnit WHERE");
			sql.append(" community=").append(DbAdapter.cite(community)).append(" AND(");
			String s[] = classes.split("/");
			for(int i = 1;i < s.length;i++)
			{
				if(i > 1)
				{
					sql.append(" OR");
				}
				sql.append(" path LIKE '%/").append(s[i]).append("/%'");
			}
			sql.append(")");
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery(sql.toString());
				while(db.next())
				{
					sb.append(db.getInt(1)).append("/");
				}
			} finally
			{
				db.close();
			}
		}
		return sb.toString();
	}

	public int getSequence()
	{
		return sequence;
	}

	public String getDept()
	{
		return dept;
	}

	public String getBbs()
	{
		return this.bbs;
	}

	public String getBbsExpert()
	{
		return bbsexpert;
	}

	public String getContentfunction()
	{
		if(contentfunction == null)
		{
			contentfunction = "/";
		}
		return contentfunction;
	}
}
