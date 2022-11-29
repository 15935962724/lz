package tea.entity.admin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;

public class SupSupplier implements Cloneable
{
    public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public static Cache c = new Cache(50);
    public static final int DEPT_CORP = 1000; //股份公司
    public static final int RECOM = 3; //大于等于此数，自动成为股份合格供应商
    public int supplier;
    public boolean basevisible = true; //前台展示
    public static String[] SUPPLIER_TYPE =
            //{"--","供设备","供物资","供设备及物资"};
            {"--","设备制造商","设备代理商","物资制造商","物资代理商"};
    public String type = "|"; //类别
    public static String[] PROPERTYS_TYPE =
            {"--","国有经济","集体经济","个体工商户","国有独资","股份公司","有限责任公司","合伙企业","乡镇企业","个人独资","事业法人","中外合资经营","中外合作经营","外商独资经营"};
    public int propertys; //企业性质
    public String name; //企业名称
    public String ename; //英文名称
    public String license; //营业执照编号
    public String settlement; //结算名称
    public String governing; //主管单位
    public static String[] POSITION_TYPE =
            {"--","生产商","经销商"}; //,"回收商"
    public int position; //身份标识
    public Date ctime; //成立时间
    public int country = 1; //国家
    public int city; //城市
    public String address; //详细地址
    public String zip; //邮编
    public String tel; //公司电话
    public String fax; //公司传真
    public String email; //电子邮箱
    public String website = "无"; //公司网址
    public boolean contentvisible = true; //前台展示
    public String content; //企业简介
    public int picture;
    public boolean personvisible; //前台展示
    public float capital; //注册资金（万元）
    public String currency; //币种
    public String legalname; //法定代表人
    public String legalidcard; //法人身份证号
    public int legalcopy; //法人身份证复印件
    public String former; //公司曾用名称
    public String subordinate; //附属单位名称
    //public String[] agentname = new String[3]; //业务经办人
    //public String[] agentidcard = new String[3]; //经办人身份证号
    //public String[] agentcopy = new String[3]; //经办人身份证复印件
    //public String[] agentauth = new String[3]; //经办人授权证明
    //public String[] agenttel = new String[3]; //业务经办人电话
    //public String[] agentemail = new String[3]; //E-Mail
    public boolean qualificationvisible = true; //前台展示
    public String qualification = "|"; //供货范围
    public String brand; //品牌
    public boolean accountvisible; //前台展示
    public String bank; //开户银行
    public String bankcode; //开户行号
    public String account; //账号
    public String tax; //税号
    public String financialcoding; //财务编码
    public String financialarea; //财务地区编码
    public String financialcategory; //财务类别编码
    public boolean cervisible = true; //前台展示
    //private String[] cername = new String[13]; //证件名称
    //private String[] cercode = new String[13]; //证件编号
    //private Date[] certime = new Date[13]; //发放时间
    //private String[] cerorg = new String[13]; //发放单位
    //private Date[] cerdeadline = new Date[13]; //有效期
    //private String[] cerpicture = new String[13]; //附件
    //private String[] crethumbs = new String[13]; //缩略图
    public String dept = "|";
    public String dept2 = "|"; //"资格审查"通过的工程局
    //
    public int integrity; //完整度
    public int umember; //最后修改人
    public Date utime; //最后修改时间
    public static final String[] STATE_TYPE =
            {"--"
            ,"待审" //1
            ,"通过" //2
            ,"回退" //3
    };
    public int state; //申报状态
    private int recom; //推荐至股份,推荐者的部门ID
    public Date stime; //申报时间
    //动态评价
    public int star; //星级
    public int comment; //评论数
    //年度评价
    //public float average; //平均值
    public int hits; //企业展示次数
    public boolean hidden; //显示/隐藏
    public int clone; //复制的谁
    public boolean deleted; //是否已删除
    public Date time;

    public SupSupplier(int supplier)
    {
        this.supplier = supplier;
    }

    public static SupSupplier find(int supplier) throws SQLException
    {
        SupSupplier t = (SupSupplier) c.get(supplier);
        if(t == null)
        {
            ArrayList al = find(" AND supplier=" + supplier,0,1);
            t = al.size() < 1 ? new SupSupplier(supplier) : (SupSupplier) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT sp.supplier,sp.basevisible,sp.type,sp.propertys,sp.name,sp.ename,sp.license,sp.settlement,sp.governing,sp.position,sp.ctime,sp.country,sp.city,sp.address,sp.zip,sp.tel,sp.fax,sp.email,sp.website,sp.contentvisible,sp.content,sp.picture,sp.personvisible,sp.capital,sp.currency,sp.legalname,sp.legalidcard,sp.legalcopy,sp.former,sp.subordinate,sp.qualificationvisible,sp.qualification,sp.brand,sp.accountvisible,sp.bank,sp.bankcode,sp.account,sp.tax,sp.financialcoding,sp.financialarea,sp.financialcategory,sp.cervisible,sp.dept,sp.dept2,sp.integrity,sp.umember,sp.utime,sp.state,sp.recom,sp.stime,sp.star,sp.comment,sp.hits,sp.hidden,sp.clone,sp.deleted,sp.time FROM supsupplier sp" + tab(sql) + " WHERE " +
                    (size == 1 ? "1=1" : "sp.deleted=0") + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                SupSupplier t = new SupSupplier(rs.getInt(i++));
                t.basevisible = rs.getBoolean(i++);
                t.type = rs.getString(i++);
                t.propertys = rs.getInt(i++);
                t.name = rs.getString(i++);
                t.ename = rs.getString(i++);
                t.license = rs.getString(i++);
                t.settlement = rs.getString(i++);
                t.governing = rs.getString(i++);
                t.position = rs.getInt(i++);
                t.ctime = db.getDate(i++);
                t.country = rs.getInt(i++);
                t.city = rs.getInt(i++);
                t.address = rs.getString(i++);
                t.zip = rs.getString(i++);
                t.tel = rs.getString(i++);
                t.fax = rs.getString(i++);
                t.email = rs.getString(i++);
                t.website = rs.getString(i++);
                t.contentvisible = rs.getBoolean(i++);
                t.content = rs.getString(i++);
                t.picture = rs.getInt(i++);
                t.personvisible = rs.getBoolean(i++);
                t.capital = rs.getFloat(i++);
                t.currency = rs.getString(i++);
                t.legalname = rs.getString(i++);
                t.legalidcard = rs.getString(i++);
                t.legalcopy = rs.getInt(i++);
                t.former = rs.getString(i++);
                t.subordinate = rs.getString(i++);
                t.qualificationvisible = rs.getBoolean(i++);
                t.qualification = rs.getString(i++);
                t.brand = rs.getString(i++);
                t.accountvisible = rs.getBoolean(i++);
                t.bank = rs.getString(i++);
                t.bankcode = rs.getString(i++);
                t.account = rs.getString(i++);
                t.tax = rs.getString(i++);
                t.financialcoding = rs.getString(i++);
                t.financialarea = rs.getString(i++);
                t.financialcategory = rs.getString(i++);
                t.cervisible = rs.getBoolean(i++);
                t.dept = rs.getString(i++);
                t.dept2 = rs.getString(i++);
                t.integrity = rs.getInt(i++);
                t.umember = rs.getInt(i++);
                t.utime = db.getDate(i++);
                t.state = rs.getInt(i++);
                t.recom = rs.getInt(i++);
                t.stime = db.getDate(i++);
                t.star = rs.getInt(i++);
                t.comment = rs.getInt(i++);
                t.hits = rs.getInt(i++);
                t.hidden = rs.getBoolean(i++);
                t.clone = rs.getInt(i++);
                t.deleted = rs.getBoolean(i++);
                t.time = db.getDate(i++);
                c.put(t.supplier,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM supsupplier sp" + tab(sql) + " WHERE sp.deleted=0" + sql);
    }

    public void set() throws SQLException
    {
        if(supplier < 2)
        {
            StringBuilder sb = new StringBuilder();
            sb.append("supplier为" + supplier + "！");
            StackTraceElement ste[] = Thread.currentThread().getStackTrace();
            for(int i = 1;i < ste.length;i++)
                sb.append("\r\n  " + ste[i].toString());
            sb.append("\r\n");
            Filex.logs("supplier.log",sb.toString());
        }
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate(supplier,"INSERT INTO supsupplier(supplier,basevisible,type,propertys,name,ename,license,settlement,governing,position,ctime,country,city,address,zip,tel,fax,email,website,contentvisible,content,picture,personvisible,capital,currency,legalname,legalidcard,legalcopy,former,subordinate,qualificationvisible,qualification,brand,accountvisible,bank,bankcode,account,tax,financialcoding,financialarea,financialcategory,cervisible,dept,dept2,integrity,umember,utime,state,recom,stime,star,comment,hits,hidden,clone,deleted,time)VALUES("
                                     + supplier + "," + DbAdapter.cite(basevisible) + "," + DbAdapter.cite(type) + "," + propertys + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(ename) + "," + DbAdapter.cite(license) + "," + DbAdapter.cite(settlement) + "," + DbAdapter.cite(governing) + "," + position + "," + DbAdapter.cite(ctime) + "," + country + "," + city + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(zip) + "," + DbAdapter.cite(tel) + "," + DbAdapter.cite(fax) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(website) + "," + DbAdapter.cite(contentvisible) + "," + DbAdapter
                                     .cite(content) + "," + picture + "," + DbAdapter.cite(personvisible) + "," + capital + "," + DbAdapter.cite(currency) + "," + DbAdapter.cite(legalname) + "," + DbAdapter.cite(legalidcard) + "," + legalcopy + "," + DbAdapter.cite(former) + "," + DbAdapter.cite(subordinate) + "," + DbAdapter.cite(qualificationvisible) + "," + DbAdapter.cite(qualification) + "," + DbAdapter.cite(brand) + "," + DbAdapter.cite(accountvisible) + "," + DbAdapter.cite(bank) + "," + DbAdapter
                                     .cite(bankcode) + "," + DbAdapter.cite(account) + "," + DbAdapter.cite(tax) + "," + DbAdapter.cite(financialcoding) + "," + DbAdapter.cite(financialarea) + "," + DbAdapter.cite(financialcategory) + "," + DbAdapter.cite(cervisible) + "," + DbAdapter.cite(dept) + "," + DbAdapter.cite(dept2) + "," + integrity + "," + umember + "," + DbAdapter.cite(utime) + "," + state + "," + recom + "," + DbAdapter.cite(stime) + "," + star + "," + comment + "," + hits + "," + DbAdapter.cite(hidden) + "," + clone + "," + DbAdapter.cite(deleted) + "," + DbAdapter.cite(time) + ")");
            if(i < 1)
            {
                db.executeUpdate(supplier,"UPDATE supsupplier SET basevisible=" + DbAdapter.cite(basevisible) + ",type=" + DbAdapter.cite(type) + ",propertys=" + propertys + ",name=" + DbAdapter.cite(name) + ",ename=" + DbAdapter.cite(ename) + ",license=" + DbAdapter.cite(license) + ",settlement=" + DbAdapter.cite(settlement) + ",governing=" + DbAdapter.cite(governing) + ",position=" + position + ",ctime=" + DbAdapter.cite(ctime) + ",country=" + country + ",city=" + city + ",address=" + DbAdapter.cite(address) + ",zip=" + DbAdapter.cite(zip) + ",tel=" + DbAdapter.cite(tel) + ",fax=" + DbAdapter.cite(fax) + ",email=" + DbAdapter.cite(email) + ",website=" + DbAdapter.cite(website) + ",contentvisible=" + DbAdapter.cite(contentvisible) + ",content=" + DbAdapter.cite(content) + ",picture=" +
                                 picture + ",personvisible=" + DbAdapter.cite(personvisible) + ",capital=" + capital + ",currency=" + DbAdapter.cite(currency) + ",legalname=" + DbAdapter.cite(legalname) + ",legalidcard=" + DbAdapter.cite(legalidcard) + ",legalcopy=" + legalcopy + ",former=" + DbAdapter.cite(former) + ",subordinate=" + DbAdapter.cite(subordinate)
                                 + ",qualificationvisible=" + DbAdapter.cite(qualificationvisible) + ",qualification=" + DbAdapter.cite(qualification) + ",brand=" + DbAdapter.cite(brand) + ",accountvisible=" + DbAdapter.cite(accountvisible) + ",bank=" + DbAdapter.cite(bank) + ",bankcode=" + DbAdapter.cite(bankcode) + ",account=" + DbAdapter.cite(account) + ",tax=" + DbAdapter.cite(tax) + ",financialcoding=" + DbAdapter.cite(financialcoding) + ",financialarea=" + DbAdapter.cite(financialarea) + ",financialcategory=" +
                                 DbAdapter.cite(financialcategory) + ",cervisible=" + DbAdapter.cite(cervisible) + ",dept=" + DbAdapter.cite(dept) + ",dept2=" + DbAdapter.cite(dept2) + ",integrity=" + integrity + ",umember=" + umember + ",utime=" + DbAdapter.cite(utime) + ",state=" + state + ",recom=" + recom + ",stime=" + DbAdapter.cite(stime) + ",star=" + star + ",comment=" + comment + ",hits=" + hits + ",hidden=" + DbAdapter.cite(hidden) + ",clone=" + clone + ",deleted=" + DbAdapter.cite(deleted) + ",time=" + DbAdapter.cite(time) + " WHERE supplier=" + supplier);
            }
        } finally
        {
            db.close();
        }
        c.remove(supplier);
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(supplier,"DELETE FROM supsupplier WHERE supplier=" + supplier);
        } finally
        {
            db.close();
        }
        c.remove(supplier);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(supplier,"UPDATE supsupplier SET " + f + "=" + DbAdapter.cite(v) + " WHERE supplier=" + supplier);
        } finally
        {
            db.close();
        }
        c.remove(supplier);
    }

    public void set(String f,Date v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(supplier,"UPDATE supsupplier SET " + f + "=" + DbAdapter.cite(v) + " WHERE supplier=" + supplier);
        } finally
        {
            db.close();
        }
        c.remove(supplier);
    }

    //
    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND sf."))
            sb.append(" INNER JOIN SupFlow sf ON sf.supplier=sp.supplier");
        if(sql.contains(" AND sr."))
            sb.append(" LEFT JOIN SupReview sr ON sr.supplier=sp.supplier");
        if(sql.contains(" AND ss."))
            sb.append(" INNER JOIN SupScore ss ON ss.supplier=sp.supplier");
        if(sql.contains(" AND sa."))
            sb.append(" INNER JOIN SupAgent sa ON sa.supplier=sp.supplier");
        if(sql.contains(" AND m."))
            sb.append(" INNER JOIN Profile m ON sp.supplier=m.profile");
        if(sql.contains(" AND m2."))
            sb.append(" INNER JOIN Profile m2 ON sf.member=m2.profile");
        if(sql.contains(" AND ssd.") || sql.contains(" AND(ssd."))
            sb.append(" LEFT JOIN SupSupplierDept ssd ON ssd.supplier=sp.supplier");
        return sb.toString();
    }

    /*public String getIntegrity() throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        integrity = 0;
        if(MT.f(content).length() > 199)
            integrity += 20;
        else
            sb.append("、<a href=#content>企业简介</a>");

        if(account != null)
            integrity += 40;
        else
            sb.append("、<a href=#base>企业基本情况</a>");

        if(SupCertificate.count(" AND supplier=" + supplier + " AND name='营业执照'") > 0)
            integrity += 20;
        else
            sb.append("、<a href=#cert>企业资质</a>");

        if(SupSupply.count(" AND supplier=" + supplier) > 0)
            integrity += 10;
        else
            sb.append("、<a href=#supply>供货记录</a>");

        if(dept.length() > 1)
            integrity += 10;
        else
            sb.append("、<a href=#depts>合作单位</a>");

        integrity = integrity * 100 / 100;
        set("integrity",String.valueOf(integrity));
        return sb.length() > 0 ? sb.substring(1) : "";
    }

    public String getQualification(String sp) throws SQLException
    {
        StringBuilder qua = new StringBuilder();
        String[] arr = qualification.split("[|]");
        for(int i = 1;i < arr.length;i++)
        {
            SupQualification q = SupQualification.find(Integer.parseInt(arr[i]));
            qua.append(q.name).append(sp);
        }
        return qua.toString();
    }

    public String getDept(String sp) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        String[] arr = dept.split("[|]");
        for(int i = 1;i < arr.length;i++)
        {
            Dept q = Dept.find(Integer.parseInt(arr[i]));
            sb.append(q.sname).append(sp);
        }
        return sb.toString();
    }

    public void setFlow(Http h,int dept,int state) throws SQLException
    {
        SupFlow sf = new SupFlow(0);
        sf.supplier = supplier;
        sf.type = 1;
        sf.dept = dept;
        sf.state = state;
        sf.member = h.member;
        sf.role = Integer.parseInt(h.getCook("role","0"));
        sf.set();
    }

    //最新加入供应商
    public static void cache() throws SQLException,IOException
    {
        StringBuilder htm = new StringBuilder();
        htm.append("var latest=[ ");
        Iterator it = SupSupplier.find(" AND deleted=0 AND supplier NOT IN(242825,242824) ORDER BY supplier DESC",0,30).iterator();
        while(it.hasNext())
            htm.append((SupSupplier) it.next()).append(",");
        htm.setCharAt(htm.length() - 1,']');
        htm.append(";");
        Filex.write(Http.REAL_PATH + "/res/china-latin2013/cache/latest.js",htm.toString());
    }

    public SupSupplier clone() throws CloneNotSupportedException
    {
        SupSupplier t = (SupSupplier)super.clone();
        t.clone = supplier;
        t.time = null;
        t.hits = 0;
        //
        t.umember = 0;
        t.utime = null;
        //
        t.star = 0;
        t.comment = 0;
        t.state = 0;
        //
        return t;
    }

    public String toString()
    {
        StringBuilder htm = new StringBuilder();
        try
        {
            htm.append("\r\n{id:" + supplier);
            htm.append(",type:'" + type + "'");
            htm.append(",name:'" + MT.f(name) + "'");

            htm.append(",picture:'" + MT.f(picture < 1 ? "/res/GYS/structure/404.jpg" : Attch.find(picture).path) + "'");
            //htm.append(",adpic:'" + MT.f(adpic,"/res/GYS/structure/404.jpg") + "'");
            htm.append(",sq:[ '" + getQualification("','"));
            int len = htm.length();
            htm.setCharAt(len - 2,' ');
            htm.setCharAt(len - 1,']');
            htm.append("}");
        } catch(SQLException ex)
        {
            ex.printStackTrace();
        }
        return htm.toString();
    }

    public void setState() throws SQLException
    {
        int year = Calendar.getInstance().get(Calendar.YEAR);
        String sql = "SELECT COUNT(*) FROM supflow WHERE supplier=" + supplier + " AND last=1 AND type=1 AND deleted=0 AND YEAR(time)=" + year;
        DbAdapter db = new DbAdapter();
        try
        {
            if(db.getInt(sql) < 1)
                state = 0;
            else if(db.getInt(sql + " AND state =3") > 0)
                state = 3;
            else if(db.getInt(sql + " AND state =4") > 0)
                state = 4;
            else
                state = 1;
            db.executeUpdate(supplier,"UPDATE supsupplier SET state=" + state + " WHERE supplier=" + supplier);
        } finally
        {
            db.close();
        }
    }

    //"资格审查"通过的工程局
    public String getDept2() throws SQLException
    {
        StringBuilder sb = new StringBuilder("|");
        //int year = Calendar.getInstance().get(Calendar.YEAR);   AND YEAR(time)=" + year
        Iterator it = SupFlow.find(" AND supplier=" + supplier + " AND last=1 AND state=15 AND deleted=0",0,200).iterator();
        while(it.hasNext())
        {
            SupFlow t = (SupFlow) it.next();
            sb.append(t.dept).append("|");
        }
        return sb.toString();
    }

    //"参加打分"的工程局
    public String getDept3() throws SQLException
    {
        StringBuilder sb = new StringBuilder("|");
        int year = Calendar.getInstance().get(Calendar.YEAR);
        Iterator it = SupScore.find(" AND supplier=" + supplier + " AND year=" + year,0,200).iterator();
        while(it.hasNext())
        {
            SupScore t = (SupScore) it.next();
            sb.append(t.dept).append("|");
        }
        return sb.toString();
    }

    public static String options(int dept) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("<option value='0'>--");
        //sb.append("<option value=" + SupSupplier.DEPT_CORP);
        //if(SupSupplier.DEPT_CORP == dept)
        //    sb.append(" selected");
        //sb.append(">" + Dept.find(SupSupplier.DEPT_CORP).sname);
        Iterator it = Dept.find(" AND community='GYS' AND options LIKE '%|1|%'",0,200).iterator();
        while(it.hasNext())
        {
            Dept t = (Dept) it.next();
            sb.append("<option value=" + t.dept);
            if(t.dept == dept)
                sb.append(" selected");
            sb.append(">" + t.sname);
        }
        return sb.toString();
    }

    public String getName(int year,int dept) throws SQLException
    {
        SupReview sr = SupReview.find(supplier,year);
        StringBuilder sb = new StringBuilder();
        sb.append(name);
        if(sr.rdept.contains("|" + dept + "|"))
        {
            sb.append(" <font style='color:red' title='推荐者：");
            String[] arr = sr.rdept.split("[|]");
            for(int i = 1;i < arr.length;i++)
            {
                sb.append(Dept.find(Integer.parseInt(arr[i])).sname).append("；");
            }
            sb.append("'>[推荐]</font>");
        }
        return sb.toString();
    }

    public String getType()
    {
        StringBuilder sb = new StringBuilder();
        String[] arr = type.split("[|]");
        for(int i = 1;i < arr.length;i++)
        {
            sb.append(SUPPLIER_TYPE[Integer.parseInt(arr[i])]).append("；");
        }
        return sb.toString();
    }

    //对不起，由于您产品不符申报要求，不能申报成为股份合格供应商
    public boolean isErr() throws SQLException
    {
        if(Profile.find(supplier).getSource() == 1) //邀请注册的跳过限制
            return false;

        //设备_不能包含
        if(type.contains("|1|") || type.contains("|2|"))
        {
            StringBuilder sql = new StringBuilder();
            sql.append(" AND qualification IN(" + qualification.substring(1).replace('|',',') + "0) AND(1=0");
            int[] arr =
                    {209,225,252,267};
            for(int i = 0;i < arr.length;i++)
            {
                sql.append(" OR path LIKE " + DbAdapter.cite("%|" + arr[i] + "|%"));
            }
            sql.append(")");
            if(SupQualification.count(sql.toString()) > 0)
                return true;
        }

        //物资_必须包含
        if(type.contains("|3|") || type.contains("|4|"))
        {
            StringBuilder sql = new StringBuilder();
            sql.append(" AND qualification IN(" + qualification.substring(1).replace('|',',') + "0) AND(1=0");
            int[] arr =
                    {300,308,317,323,363,344};
            for(int i = 0;i < arr.length;i++)
            {
                sql.append(" OR path LIKE " + DbAdapter.cite("%|" + arr[i] + "|%"));
            }
            sql.append(")");
            return SupQualification.count(sql.toString()) < 1;
        }
        return false;
    }

    //评价单位及评分
    public String getScore(int year,String sp) throws SQLException
    {
        StringBuilder htm = new StringBuilder(),sb = new StringBuilder();
        // AND dept IN(" + dept.substring(1).replace('|',',') + "0)
        ArrayList al = SupScore.find(" AND supplier=" + supplier + " AND year=" + year,0,200);
        for(int j = 0;j < al.size();j++)
        {
            SupScore ss = (SupScore) al.get(j);
            htm.append(sp + "<a href='/jsp/sup/SupScoreView.jsp?score=" + ss.score + "'>" + Dept.find(ss.dept).sname + " " + ss.total + "分</a>");
            sb.append(ss.dept).append(",");
        }
        al = Dept.find(" AND dept NOT IN(" + sb.toString() + "0) AND dept IN(" + (SupSpecify.getDept(year,supplier).substring(1) + dept.substring(1)).replace('|',',') + "0)",0,200);
        for(int j = 0;j < al.size();j++)
        {
            Dept d = (Dept) al.get(j);
            htm.append(sp + d.sname + "[未评]");
        }
        return htm.substring(htm.length() < 1 ? 0 : sp.length());
    }*/

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}
