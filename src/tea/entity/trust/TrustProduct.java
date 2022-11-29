package tea.entity.trust;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import javax.swing.text.TabableView;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Entity;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.node.ListingDetail;
import tea.entity.node.Node;
/**
 *
 * @author 张杰
 * @category 信托产品类
 */

public class TrustProduct extends Entity{
	protected static Cache c = new Cache(50);
    public int node;
    public String name;
    public int companyNode;//发行机构编号
    public String companyName;//发行机构
    public Date releaseTime;//发行时间
    public int city;//发行地区
    public int timeLimit1;//产品期限
    public int timeLimit2;
    public Double sizeOf;//投资规模
    public Double threshold;//投资门槛
    public float income1;
    public float income2;//预期年化收入
    public int field;//资金投向
    public int investmentWay;//投资方式
    public int distribution;//收效分配
    public String regulatory;//监管机构
    public String bankName;//托管银行
    public String bankNum;//银行账户
    public String earnings;//收益详情
    public int type;//产品类型
    public int state;//产品状态
    public int earningsType;//收益类型
    public String maneyUse;//资金用途
    public String measures;//风控措施
    public int conditions;//是否精选
    public int deleted;
    public static String[] FIELD={"----------","房地产","金融市场","工商企业","基础设施","其他"};
    public static String[] INVESTMENTWAY={"----------","信托贷款","股权投资","权益投资","其他投资","组合应用"};
    public static String[] DISTRIBUTION={"----------","按季付息","按半年付息","按年付息","到期还本付息"};
    public static String[] TYPE={"----------","集合信托"};
    public static String[] STATE={"----------","在售"};
    public static String[] EARNINGSTYPE={"----------","固定性"};


    public TrustProduct(int node)
    {
        this.node = node;
    }

    public static TrustProduct find(int node) throws SQLException
    {
    	TrustProduct t = (TrustProduct) c.get(node);
        if(t == null)
        {
             ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new TrustProduct(node) : (TrustProduct) al.get(0);
        }
        return t;
    }
    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND n."))
            sb.append(" INNER JOIN Node n ON n.node=tp.node");

        return sb.toString();
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT tp.node,name,companyNode,companyName,releaseTime,tp.city,timeLimit1,timeLimit2,sizeOf,threshold,income1,income2,field,investmentWay,distribution,regulatory,bankName,bankNum,earnings,tp.type,tp.state,earningsType,maneyUse,measures,conditions,deleted FROM TrustProduct tp "+tab(sql)+" WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                TrustProduct t = new TrustProduct(rs.getInt(i++));
                t.name = rs.getString(i++);
                t.companyNode = rs.getInt(i++);
                t.companyName = rs.getString(i++);
                t.releaseTime=rs.getDate(i++);
                t.city = rs.getInt(i++);
                t.timeLimit1 = rs.getInt(i++);
                t.timeLimit2 = rs.getInt(i++);
                t.sizeOf = rs.getDouble(i++);
                t.threshold = rs.getDouble(i++);
                t.income1 = rs.getFloat(i++);
                t.income2 = rs.getFloat(i++);
                t.field = rs.getInt(i++);
                t.investmentWay = rs.getInt(i++);
                t.distribution = rs.getInt(i++);
                t.regulatory = rs.getString(i++);
                t.bankName = rs.getString(i++);
                t.bankNum = rs.getString(i++);
                t.earnings = rs.getString(i++);
                t.type = rs.getInt(i++);
                t.state = rs.getInt(i++);
                t.earningsType = rs.getInt(i++);
                t.maneyUse = rs.getString(i++);
                t.measures = rs.getString(i++);
                t.conditions=rs.getInt(i++);
                t.deleted=rs.getInt(i++);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM TrustProduct tp "+tab(sql)+" WHERE deleted=0" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("INSERT INTO TrustProduct(node,name,companyNode,companyName,releaseTime,city,timeLimit1,timeLimit2,sizeOf,threshold,income1,income2,field,investmentWay,distribution,regulatory,bankName,bankNum,earnings,type,state,earningsType,maneyUse,measures,conditions,deleted)VALUES(" + node + "," + DbAdapter.cite(name) + "," + companyNode + "," + DbAdapter.cite(companyName) + "," + DbAdapter.cite(releaseTime) + "," + city + "," + timeLimit1+ "," + timeLimit2 + "," + sizeOf + "," + threshold + "," + income1+ "," + income2 + "," + field + "," +investmentWay + "," + distribution + "," +  DbAdapter.cite(regulatory) + "," + DbAdapter.cite(bankName) + "," +DbAdapter.cite(bankNum)  + "," + DbAdapter.cite(earnings) + "," + type +"," + state +"," + earningsType+ "," +DbAdapter.cite(maneyUse)  + "," + DbAdapter.cite(measures)+ ","+conditions+ ","+deleted + ")");
            if(j < 1)
                db.executeUpdate("UPDATE TrustProduct SET name=" + DbAdapter.cite(name) + ",companyNode=" + companyNode + ",companyName=" + DbAdapter.cite(companyName) + ",releaseTime=" + DbAdapter.cite(releaseTime) + ",city=" + city + ",timeLimit1=" + timeLimit1+ ",timeLimit2=" + timeLimit2 + ",sizeOf=" + sizeOf + ",threshold=" + threshold + ",income1=" +income1+ ",income2=" +income2 + ",field=" + field + ",investmentWay=" + investmentWay + ",distribution=" + distribution + ",regulatory=" + DbAdapter.cite(regulatory) + ",bankName=" + DbAdapter.cite(bankName) + ",bankNum=" + DbAdapter.cite(bankNum) + ",earnings=" + DbAdapter.cite(earnings) + ",type=" + type + ",state=" + state +",earningsType=" + earningsType +",maneyUse=" + DbAdapter.cite(maneyUse)+",measures=" + DbAdapter.cite(measures)+",conditions=" + conditions+",deleted=" + deleted + " WHERE node=" + node);
        } finally
        {
        	c.remove(node);
            db.close();
        }

    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("UPDATE TrustProduct SET deleted=1 WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE TrustProduct SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }

	public static String getDetail(Node n,Http h,int listing,String target) throws SQLException
	{
		StringBuilder htm = new StringBuilder();
		String subject = n.getSubject(h.language);
		ListingDetail detail = ListingDetail.find(listing,110,h.language);//97
		Iterator e = detail.keys();
		while(e.hasNext())
		{
			String name = (String) e.next(),value = null;
			int istype = detail.getIstype(name);
			if(istype == 0)
				continue;

			String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/trustproduct/" + n._nNode + "-" + h.language + ".htm";
			String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
			//int dq = detail.getQuantity(name);
			if(name.equals("subject"))
			{
				value = subject;
			} else if(name.equals("content"))
				value = n.getText(h.language);
			else
			{
				TrustProduct t = TrustProduct.find(n._nNode);
				if(name.equals("companyName"))
				{
					if(t.companyNode>0){
					  value = "<a id='cm' href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/trustcompany/" + t.companyNode + "-" + h.language + ".htm' >"+TrustCompany.find(t.companyNode).nameMsg+"</a>";
					}else {
						value="";
					}
				} else if(name.equals("releaseTime"))
				{
					value = MT.f(t.releaseTime);

				} else if(name.equals("city"))
				{
					value="<script language='javascript' src='/tea/city.js'></script><script>mt.city("+t.city+")</script>";
				} else if(name.equals("timeLimit"))
				{
					if(t.timeLimit2>0){
						value=t.timeLimit1+"月-"+t.timeLimit2+"月";
					}else{
						value=t.timeLimit1+"月";
					}

				} else if(name.equals("sizeOf"))
				{

					value = String.valueOf(t.sizeOf);
				} else if(name.equals("threshold"))
				{
					value = String.valueOf(t.threshold);
				} else if(name.equals("income"))
				{

					value=t.income1+"%至"+t.income2+"%";
				} else if(name.equals("field"))
				{
					value = TrustProduct.FIELD[t.field];
				} else if(name.equals("investmentWay"))
				{
					value = TrustProduct.INVESTMENTWAY[t.investmentWay];
				} else if(name.equals("distribution"))
				{
					value = TrustProduct.DISTRIBUTION[t.distribution];
				} else if(name.equals("regulatory"))
				{
					value = t.regulatory;
				} else if(name.equals("bankName"))
				{
					value = t.bankName;
				}else if(name.equals("bankNum"))
				{
					value = t.bankNum;
				}
				else if(name.equals("earnings"))
				{
					value = t.earnings;
				}
				else if(name.equals("type"))
				{
					value = TrustProduct.TYPE[t.type];
				}
				else if(name.equals("state"))
				{
					value = TrustProduct.STATE[t.state];
				}else if(name.equals("earningsType"))
				{
					value = TrustProduct.EARNINGSTYPE[t.earningsType];
				}
				else if(name.equals("maneyUse"))
				{
					value = t.maneyUse;
				}
				else if(name.equals("measures"))
				{
					value = t.measures;
				}else
					try
					{
						Object tmp = Class.forName("tea.entity.trust.TrustProduct").getField(name).get(t);
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
			htm.append(bi).append("<span id='TrustProductID" + name + "'>" + value + "</span>").append(ai);
		}
		return htm.toString();
	}

}
