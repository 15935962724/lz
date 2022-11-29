package tea.entity.trust;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import tea.db.DbAdapter;
import tea.entity.Attch;
import tea.entity.Cache;
import tea.entity.Entity;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.node.ListingDetail;
import tea.entity.node.Node;
/**
 *
 * @author 张杰
 * @category 信托公司类
 */

public class TrustCompany extends Entity{
	protected static Cache c = new Cache(50);
    public int node;
    public String name;
    public String nameMsg;
    public BigDecimal regMoney;//注册资本
    public Date time;//成立时间
    public int city;//地区
    public String legalPerson;//法人
    public String chairman;//董事长
    public String bigShareholders;//大股东
    public String scopeOf;//经营范围
    public int isListed;//是否上市
    public String background;//股东背景
    public int type;//股东背景
    public String logo;//图片
    public BigDecimal yield;//收益率
    public int deleted;
    public static String[] TYPE={"","房地产","金融市场","工商企业","基础设施","其他"};


    public TrustCompany(int node)
    {
        this.node = node;
    }

    public static TrustCompany find(int node) throws SQLException
    {
    	TrustCompany t = (TrustCompany) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new TrustCompany(node) : (TrustCompany) al.get(0);
        }
        return t;
    }
    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND n."))
            sb.append(" INNER JOIN Node n ON n.node=tc.node");

        return sb.toString();
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT tc.node,tc.name,nameMsg,regMoney,tc.time,tc.city,legalPerson,chairman,bigShareholders,scopeOf,isListed,background,tc.type,logo,yield,deleted FROM TrustCompany tc "+tab(sql)+" WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                TrustCompany t = new TrustCompany(rs.getInt(i++));
                t.name = rs.getString(i++);
                t.nameMsg = rs.getString(i++);
                t.regMoney = rs.getBigDecimal(i++);
                t.time=rs.getDate(i++);
                t.city = rs.getInt(i++);
                t.legalPerson = rs.getString(i++);
                t.chairman = rs.getString(i++);
                t.bigShareholders = rs.getString(i++);
                t.scopeOf = rs.getString(i++);
                t.isListed = rs.getInt(i++);
                t.background = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.logo = rs.getString(i++);
                t.yield = rs.getBigDecimal(i++);
                t.deleted = rs.getInt(i++);

                c.put(t.node,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM TrustCompany tc "+tab(sql)+" WHERE deleted=0" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("INSERT INTO TrustCompany(node,name,nameMsg,regMoney,time,city,legalPerson,chairman,bigShareholders,scopeOf,isListed,background,type,logo,yield,deleted)VALUES(" + node + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(nameMsg) + "," + regMoney + "," + DbAdapter.cite(time) + "," + city + "," + DbAdapter.cite(legalPerson) + "," + DbAdapter.cite(chairman) + "," + DbAdapter.cite(bigShareholders) + "," + DbAdapter.cite(scopeOf) + "," + isListed + "," +DbAdapter.cite(background) + "," + type + "," +  DbAdapter.cite(logo) + "," + yield + "," +deleted  +")");
            if(j < 1)
                db.executeUpdate("UPDATE TrustCompany SET name=" + DbAdapter.cite(name) + ",nameMsg=" + DbAdapter.cite(nameMsg) + ",regMoney=" + regMoney + ",time=" + DbAdapter.cite(time) + ",city=" + city + ",legalPerson=" + DbAdapter.cite(legalPerson) + ",chairman=" + DbAdapter.cite(chairman) + ",bigShareholders=" + DbAdapter.cite(bigShareholders) + ",scopeOf=" + DbAdapter.cite(scopeOf) + ",isListed=" + isListed + ",background=" + DbAdapter.cite(background) + ",type=" + type + ",logo=" + DbAdapter.cite(logo) + ",yield=" + yield +",deleted=" + deleted + " WHERE node=" + node);
        } finally
        {
        	c.remove(node);
            db.close();
        }

    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("UPDATE TrustCompany SET deleted=1 WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE TrustCompany SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }

	public static String getDetail(Node n,Http h,int listing,String target) throws SQLException
	{
		StringBuilder htm = new StringBuilder();
		String subject = n.getSubject(h.language);
		ListingDetail detail = ListingDetail.find(listing,111,h.language);//111
		Iterator e = detail.keys();
		while(e.hasNext())
		{
			String name = (String) e.next(),value = null;
			int istype = detail.getIstype(name);
			if(istype == 0)
				continue;

			String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/company/" + n._nNode + "-" + h.language + ".htm";
			String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
			//int dq = detail.getQuantity(name);
			if(name.equals("subject"))
			{
				value = subject;
			} else if(name.equals("content"))
				value = n.getText(h.language);
			else
			{
				TrustCompany t = TrustCompany.find(n._nNode);
				if(name.equals("nameMsg"))
				{
					value = t.nameMsg;

				} else if(name.equals("name"))
				{
					value = MT.f(t.name);

				} else if(name.equals("city"))
				{
					value="<script language='javascript' src='/tea/city.js'></script><script>mt.city('"+t.city+"')</script>";
				} else if(name.equals("time"))
				{
					value=MT.f(t.time);
				} else if(name.equals("legalPerson"))
				{

					value = t.legalPerson;
				} else if(name.equals("chairman"))
				{
					value = t.chairman;
				} else if(name.equals("bigShareholders"))
				{
					String temp=t.bigShareholders;
					value=temp;
				} else if(name.equals("isListed"))
				{
					value = t.isListed==1?"是":"否";
				} else if(name.equals("regMoney"))
				{
					value = String.valueOf(t.regMoney);
				} else if(name.equals("yield"))
				{
					value = t.yield+"%";
				} else if(name.equals("logo"))
				{
					value = "<img id='cp' src='"+((t.logo==null||"".equals(t.logo))?"/res/"+h.community+"/no.jpg":Attch.find(Integer.parseInt(t.logo)).path)+"'>";
				} else if(name.equals("background"))
				{
					value = t.background;
				}else if(name.equals("scopeOf"))
				{
					value = t.scopeOf;
				}
				else
					try
					{
						Object tmp = Class.forName("tea.entity.trust.TrustCompany").getField(name).get(t);
						if(tmp != null)
						{
							if(tmp instanceof Date)
								value = MT.f((Date) tmp);
							else
								value = tmp.toString();
						}
					} catch(Exception ex)
					{
					}
			}
			if(value == null)
				value = "";
			if(istype == 2 && value.length() < 1)
				continue;

			//限制字数
			value = detail.getOptionsToHtml(name,n,value);

			//显示连接的地方
			if(detail.getAnchor(name) != 0)
			{
				value = "<a href='" + url + "' target='" + target + "' title=\"" + subject.replace('"','\'') + "\">" + value + "</a>";
			}
			htm.append(bi).append("<span id='ProductID" + name + "'>" + value + "</span>").append(ai);
		}
		return htm.toString();
	}

}
