package tea.entity.member;

import java.util.*;

import tea.db.*;
import tea.entity.*;
import java.sql.SQLException;

public class Employment
{
	private static Cache _cache = new Cache(100);
	public static final String BRANC_TYPE[][] = { { "0001", "农、林、牧、渔业" }, { "0002", "采掘业" }, { "0003", "制造业" }, { "0004", "电力、煤气及水的生产" }, { "0005", "建筑业" }, { "0006", "地质勘察业、水利管理" }, { "0007", "交通运输、仓储及邮电" }, { "0008", "批发和零售贸易、餐饮" }, { "0009", "金融、保险业" }, { "0010", "房地产业" }, { "0011", "社会服务业" }, { "0012", "卫生、体育和社会福利" }, { "0013", "教育、文化艺术及广播" }, { "0014", "科学研究和综合技服业" }, { "0015", "国家，政党和社会团体" }, { "0016", "其他行业" } };
	public static final String ZZJLLX_TYPE[] = { "水利水电系统外经历-社会", "水利水电系统外经历-军队", "水利水电系统内经历" };
	public static final String ZZJRFS_TYPE[][] = { { "01", "应届毕业生分配" }, { "02", "招聘" }, { "03", "招工" }, { "04", "复员" }, { "05", "转业" }, { "06", "调入" }, { "07", "顶职" }, { "99", "其他" } };
	public static final String ZZPCYY_TYPE[][] = { { "01", "支援边远地区" }, { "02", "加强地方党政机关" }, { "03", "挂职锻炼" }, { "04", "基层实习" }, { "05", "派驻合作/合营/合资公司任职" }, { "06", "劳务派遣" }, { "07", "借调" }, { "08", "支援重点项目" }, { "99", "其他" } };
	public static final String ZZYGLX_TYPE[][] = { { "Z0", "企业劳动合同制" }, { "Z1", "企业聘用合同制" }, { "Z2", "雇员制" }, { "Z3", "社聘制-内部人力公司" }, { "Z4", "社聘制-外部人力公司" }, { "Z5", "社聘制-直接聘用" }, { "Z6", "合营/合资-合同制" }, { "Z7", "合营/合资-合营方人员" }, { "Z8", "合营/合资-社聘制直聘" }, { "Z9", "合营/合资-社聘制外聘" } };
	public static final String ZZDCYY_TYPE[] = { "调动", "离职", "退休", "内退" };

	private int id;
	private String orgName;
	private String orgInfo;
	private String workSite;
	private String department;
	private Date startDate;
	private Date endDate;
	private String function;
	private String reasonOfLeaving;
	private boolean exists;
	private int node;
	private int language;
	private String positionName;
	private String branc;
	private String zzmr;
	private String zzlxfs;
	private int zzjllx;
	private String zzjrfs;
	private int zzdcyy;
	private String zzyglx;
	private boolean zzjrll;
	private String zzpcyy;
	private String zzpcdw;

	public Employment()
	{
	}

	public static Employment find(int id) throws SQLException
	{
		Employment obj = (Employment) _cache.get(new Integer(id));
		if (obj == null)
		{
			obj = new Employment(id);
			_cache.put(new Integer(id), obj);
		}
		return obj;
	}

	public static Enumeration find(int node, int language) throws SQLException
	{
		Vector vector = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT id FROM Employment WHERE node=" + node + " AND language=" + language + " ORDER BY startdate");
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

    public static int count(int node, int language) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Employment WHERE node=" + node + " AND language=" + language);
            while (db.next())
            {
                i = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return i;
    }


	public Employment(int id) throws SQLException
	{
		this.id = id;
		loadBasic();
	}

	public boolean isExists() throws SQLException
	{
		return exists;
	}

	public void set() throws SQLException
	{
		if (this.isExists())
		{
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeUpdate("UPDATE Employment SET node=" + node + ",language=" + language + ",OrgName	=" + DbAdapter.cite(orgName) + ",OrgInfo	=" + DbAdapter.cite(orgInfo) + ",WorkSite=" + DbAdapter.cite(workSite) + ",Department=" + DbAdapter.cite(department) + ",PositionName=" + DbAdapter.cite(positionName) + "	,StartDate=" + db.cite(startDate) + ",EndDate	=" + db.cite(endDate) + ",func=" + DbAdapter.cite(function) + ",ReasonOfLeaving	=" + DbAdapter.cite(reasonOfLeaving) + "	,branc="
						+ DbAdapter.cite(branc) + ",zzmr =" + DbAdapter.cite(zzmr) + " ,zzlxfs=" + DbAdapter.cite(zzlxfs) + ",zzjllx=" + zzjllx + ",zzjrfs=" + DbAdapter.cite(zzjrfs) + ",zzpcdw=" + DbAdapter.cite(zzpcdw) + ",zzpcyy=" + DbAdapter.cite(zzpcyy) + ",zzjrll=" + (zzjrll ? "1" : "0") + ",zzyglx=" + DbAdapter.cite(zzyglx) + ",zzdcyy=" + (zzdcyy) + "  WHERE id=" + id);
			}  finally
			{
				db.close();
			}
		} else
		{
			create();
		}
		_cache.remove(new Integer(id));
	}

	public void create() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("INSERT INTO Employment(node,language,OrgName,OrgInfo ,WorkSite,Department,PositionName,StartDate,EndDate,func,ReasonOfLeaving	,branc,zzmr ,zzlxfs,zzjllx,zzjrfs,zzpcdw,zzpcyy,zzjrll,zzyglx,zzdcyy)VALUES(" + (node) + "		," + language + "	," + DbAdapter.cite(orgName) + "		," + DbAdapter.cite(orgInfo) + "		," + DbAdapter.cite(workSite) + "	," + DbAdapter.cite(department) + "	," + DbAdapter.cite(positionName) + "	," + db.cite(startDate) + "	," + db.cite(endDate) + "		,"
					+ DbAdapter.cite(function) + "	," + DbAdapter.cite(reasonOfLeaving) + "," + DbAdapter.cite(branc) + "," + DbAdapter.cite(zzmr) + " ," + DbAdapter.cite(zzlxfs) + "," + zzjllx + "," + DbAdapter.cite(zzjrfs) + "," + DbAdapter.cite(zzpcdw) + "," + DbAdapter.cite(zzpcyy) + "," + (zzjrll ? "1" : "0") + "," + DbAdapter.cite(zzyglx) + "," + (zzdcyy) + ")");
		}  finally
		{
			db.close();
		}
	}

	public void delete()
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("DELETE FROM Employment WHERE id=" + this.id);
		} catch (SQLException ex)
		{
			ex.printStackTrace();
		} finally
		{
			db.close();
		}
		_cache.remove(new Integer(id));
	}

	private void loadBasic() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeQuery("SELECT node,language,orgname,orginfo,worksite,department,positionname,startdate,enddate,func,reasonofleaving,branc,zzmr,zzlxfs,zzjllx,zzjrfs,zzpcdw,zzpcyy,zzjrll,zzyglx,zzdcyy FROM Employment WHERE id=" + this.id);
			if (db.next())
			{
				node = db.getInt(1);
				language = db.getInt(2);
				orgName = db.getVarchar(1, language, 3);
				orgInfo = db.getText(1, language, 4);
				workSite = db.getVarchar(1, language, 5);
				department = db.getVarchar(1, language, 6);
				positionName = db.getVarchar(1, language, 7);
				startDate = db.getDate(8);
				endDate = db.getDate(9);
				function = db.getText(1, language, 10);
				reasonOfLeaving = db.getVarchar(1, language, 11);
				branc = db.getString(12);
				zzmr = db.getVarchar(1, language, 13);
				zzlxfs = db.getVarchar(1, language, 14);
				zzjllx = db.getInt(15);
				zzjrfs = db.getVarchar(1, language, 16);
				zzpcdw = db.getVarchar(1, language, 17);
				zzpcyy = db.getString(18);
				zzjrll = db.getInt(19) != 0;
				zzyglx = db.getString(20);
				zzdcyy = db.getInt(21);
				exists = true;
			} else
			{
				exists = false;
				zzlxfs = zzmr = orgName = orgInfo = workSite = positionName = department = function = reasonOfLeaving = "";
			}
		}  finally
		{
			db.close();
		}
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public void setOrgName(String orgName)
	{
		this.orgName = orgName;
	}

	public void setOrgInfo(String orgInfo)
	{
		this.orgInfo = orgInfo;
	}

	public void setWorkSite(String workSite)
	{
		this.workSite = workSite;
	}

	public void setDepartment(String department)
	{
		this.department = department;
	}

	public void setStartDate(Date startDate)
	{
		this.startDate = startDate;
	}

	public void setEndDate(Date endDate)
	{
		this.endDate = endDate;
	}

	public void setFunction(String function)
	{
		this.function = function;
	}

	public void setReasonOfLeaving(String reasonOfLeaving)
	{
		this.reasonOfLeaving = reasonOfLeaving;
	}

	public void setNode(int node)
	{

		this.node = node;
	}

	public void setLanguage(int language)
	{
		this.language = language;
	}

	public void setPositionName(String positionName)
	{
		this.positionName = positionName;
	}

	public void setBranc(String branc)
	{
		this.branc = branc;
	}

	public void setZzmr(String zzmr)
	{
		this.zzmr = zzmr;
	}

	public void setZzlxfs(String zzlxfs)
	{
		this.zzlxfs = zzlxfs;
	}

	public void setZzjllx(int zzjllx)
	{
		this.zzjllx = zzjllx;
	}

	public void setZzjrfs(String zzjrfs)
	{
		this.zzjrfs = zzjrfs;
	}

	public void setZzdcyy(int zzdcyy)
	{
		this.zzdcyy = zzdcyy;
	}

	public void setZzjrll(boolean zzjrll)
	{
		this.zzjrll = zzjrll;
	}

	public void setZzpcdw(String zzpcdw)
	{
		this.zzpcdw = zzpcdw;
	}

	public void setZzpcyy(String zzpcyy)
	{
		this.zzpcyy = zzpcyy;
	}

	public void setZzyglx(String zzyglx)
	{
		this.zzyglx = zzyglx;
	}

	public int getId()
	{
		return id;
	}

	public String getOrgName()
	{
		return orgName;
	}

	public String getOrgInfo()
	{
		return orgInfo;
	}

	public String getWorkSite()
	{
		return workSite;
	}

	public String getDepartment()
	{
		return department;
	}

	public String getStartDate(String patterm)
	{
		if (startDate == null)
		{
			return "";
		}
		return (new java.text.SimpleDateFormat(patterm)).format(startDate);
	}

	public Date getStartDate()
	{
		return startDate;
	}

	public Date getEndDate()
	{
		return endDate;
	}

	public String getEndDate(String patterm)
	{
		if (endDate == null)
		{
			return "";
		}
		int year = Integer.parseInt((new java.text.SimpleDateFormat("yyyy")).format(endDate));
		if (year >= (3000 - 1))
		{
			return "至今";
		}
		return (new java.text.SimpleDateFormat(patterm)).format(endDate);
	}

	public String getFunction()
	{
		return function;
	}

	public String getReasonOfLeaving()
	{
		return reasonOfLeaving;
	}

	public int getNode()
	{

		return node;
	}

	public int getLanguage()
	{
		return language;
	}

	public String getPositionName()
	{
		return positionName;
	}

	public String getBranc()
	{
		return branc;
	}

	public String getZzmr()
	{
		return zzmr;
	}

	public String getZzlxfs()
	{
		return zzlxfs;
	}

	public int getZzjllx()
	{
		return zzjllx;
	}

	public String getZzjrfs()
	{
		return zzjrfs;
	}

	public int getZzdcyy()
	{
		return zzdcyy;
	}

	public String getZzyglx()
	{
		return zzyglx;
	}

	public boolean isZzjrll()
	{
		return zzjrll;
	}

	public String getZzpcyy()
	{
		return zzpcyy;
	}

	public String getZzpcdw()
	{
		return zzpcdw;
	}
}
