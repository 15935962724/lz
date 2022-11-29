package tea.entity.cio;

import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.site.*;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

public class CioCompany extends Entity
{
    private static Cache _cache = new Cache(100);
    private int ciocompany;
    private String community;
    private String name;
    private boolean invite; //true:被邀请
    private boolean central; //0:地方 1:央企
    private boolean special; //true: 不受截止日期限制
    private boolean receipt; //是否已发回执(即:是否已审核)
    private String member; //参会企业序号,领导
    private String contact;
    private String tel;
    private String mobile;
    private String email;
    private String invoice;
    private String remark;
    private String attach;
    private Date time;
    private boolean exists;
    public CioCompany(int ciocompany) throws SQLException
    {
        this.ciocompany = ciocompany;
        load();
    }

    public CioCompany(int ciocompany,String community,String name,boolean invite,boolean central,boolean special,boolean receipt,String member,String contact,String tel,String mobile,String email,String invoice,String remark,String attach,Date time) throws SQLException
    {
        this.ciocompany = ciocompany;
        this.community = community;
        this.name = name;
        this.invite = invite;
        this.central = central;
        this.special = special;
        this.receipt = receipt;
        this.member = member;
        this.contact = contact;
        this.tel = tel;
        this.mobile = mobile;
        this.email = email;
        this.invoice = invoice;
        this.remark = remark;
        this.attach = attach;
        this.time = time;
        this.exists = true;
    }

    public static CioCompany find(int ciocompany) throws SQLException
    {
        CioCompany obj = (CioCompany) _cache.get(ciocompany);
        if(obj == null)
        {
            obj = new CioCompany(ciocompany);
            _cache.put(ciocompany,obj);
        }
        return obj;
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT community,name,invite,central,special,receipt,member,contact,tel,mobile,email,invoice,remark,attach,time FROM CioCompany WHERE ciocompany=" + ciocompany);
            if(db.next())
            {
                int j = 1;
                community = db.getString(j++);
                name = db.getString(j++);
                invite = db.getInt(j++) != 0;
                central = db.getInt(j++) != 0;
                special = db.getInt(j++) != 0;
                receipt = db.getInt(j++) != 0;
                member = db.getString(j++);
                contact = db.getString(j++);
                tel = db.getString(j++);
                mobile = db.getString(j++);
                email = db.getString(j++);
                invoice = db.getString(j++);
                remark = db.getString(j++);
                attach = db.getString(j++);
                time = db.getDate(j++);
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

    //批量添加央企
    public static void create(String community,String name,boolean central) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO CioCompany(community, name,central) VALUES (" + DbAdapter.cite(community) + ", " + DbAdapter.cite(name) + "," + DbAdapter.cite(central) + ")");
        } finally
        {
            db.close();
        }
    }

    //添加地方企业
    public static int create(int ciocompany,String community,String member,String name,String contact,String tel,String mobile,String email,String invoice,String remark,String attach) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO CioCompany(community,member, name,contact,tel,mobile,email,invoice,remark,attach,central)VALUES(" +
                             DbAdapter.cite(community) + "," + DbAdapter.cite(member) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(contact) + "," + DbAdapter.cite(tel) + "," + DbAdapter.cite(mobile) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(invoice) + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(attach) + "," + 0 + ")");
            j = db.getInt("SELECT MAX(ciocompany) FROM CioCompany");
            if(ciocompany != 0)
            {
                db.executeUpdate("UPDATE CioPart SET ciocompany=" + j + " WHERE ciocompany=" + ciocompany);
                db.executeUpdate("UPDATE CioPoll SET ciocompany=" + j + " WHERE ciocompany=" + ciocompany);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int count(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM CioCompany WHERE community=" + DbAdapter.cite(community) + sql);
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

    public static int findByMember(String member) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ciocompany FROM CioCompany WHERE member=" + DbAdapter.cite(member) + " OR ciocompany IN ( SELECT ciocompany FROM CioPart WHERE member=" + DbAdapter.cite(member) + " )");
            if(db.next())
            {
                j = db.getInt(1);
            } else
            {
                j = -(int) (Math.random() * 10000000);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ciocompany,name,invite,central,special,receipt,member,contact,tel,mobile,email,invoice,remark,attach,time FROM CioCompany WHERE ciocompany>0 AND community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                int ciocompany = db.getInt(j++);
                String name = db.getString(j++);
                boolean invite = db.getInt(j++) != 0;
                boolean central = db.getInt(j++) != 0;
                boolean special = db.getInt(j++) != 0;
                boolean receipt = db.getInt(j++) != 0;
                String member = db.getString(j++);
                String contact = db.getString(j++);
                String tel = db.getString(j++);
                String mobile = db.getString(j++);
                String email = db.getString(j++);
                String invoice = db.getString(j++);
                String remark = db.getString(j++);
                String attach = db.getString(j++);
                Date time = db.getDate(j++);
                CioCompany obj = new CioCompany(ciocompany,community,name,invite,central,special,receipt,member,contact,tel,mobile,email,invoice,remark,attach,time);
                _cache.put(ciocompany,obj);
                v.add(obj);
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public void set(String name,String contact,String tel,String mobile,String email,String remark,String attach) throws SQLException
    {
        this.time = new Date();
        StringBuilder sb = new StringBuilder();
        sb.append("UPDATE CioCompany SET name=").append(DbAdapter.cite(name)).append(",contact=").append(DbAdapter.cite(contact)).append(",tel=").append(DbAdapter.cite(tel)).append(",mobile=").append(DbAdapter.cite(mobile)).append(",email=").append(DbAdapter.cite(email)).append(",remark=").append(DbAdapter.cite(remark)).append(",time=").append(DbAdapter.cite(time));
        if(attach != null)
        {
            sb.append(",attach=").append(DbAdapter.cite(attach));
            this.attach = attach;
        }
        sb.append(" WHERE ciocompany=").append(ciocompany);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(sb.toString());
        } finally
        {
            db.close();
        }
        this.name = name;
        this.contact = contact;
        this.tel = tel;
        this.mobile = mobile;
        this.email = email;
        this.remark = remark;
    }

    public void set(boolean invite,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CioCompany SET invite=" + DbAdapter.cite(invite) + ",member=" + DbAdapter.cite(member) + " WHERE ciocompany=" + ciocompany);
        } finally
        {
            db.close();
        }
        this.invite = invite;
        this.member = member;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM CioCompany WHERE ciocompany=" + ciocompany);
        } finally
        {
            db.close();
        }
        _cache.remove(ciocompany);
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getName()
    {
        return name;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isInvite()
    {
        return invite;
    }

    public String getMember()
    {
        return member;
    }

    public String getTel()
    {
        return tel;
    }

    public String getRemark()
    {
        return remark;
    }

    public String getMobile()
    {
        return mobile;
    }

    public String getEmail()
    {
        return email;
    }

    public String getContact()
    {
        return contact;
    }

    public boolean isSpecial()
    {
        return special;
    }

    public String getTimeToString()
    {
        if(time == null)
        {
            return "";
        }
        return sdf2.format(time);
    }

    public Date getTime()
    {
        return time;
    }

    public String[] getAttach()
    {
        if(attach == null || attach.length() < 1)
        {
            return new String[0];
        }
        return attach.split(":");
    }

    public String getAttachToHtml() throws Exception
    {
        StringBuilder h = new StringBuilder();
        String as[] = getAttach();
        for(int i = 0;i < as.length;i++)
        {
            int j = as[i].lastIndexOf('/') + 1;
            String name = as[i].substring(j);
            String ex = name.substring(name.lastIndexOf('.') + 1).toLowerCase();
            h.append("<a href='/jsp/include/DownFile.jsp?uri=" + java.net.URLEncoder.encode(as[i],"UTF-8") + "&name=" + java.net.URLEncoder.encode(name,"UTF-8") + "'><img src='/tea/image/netdisk/" + ex + ".gif' align='top'/>" + name + "</a>　");
        }
        return h.toString();
    }

    public boolean isCentral()
    {
        return central;
    }

    public boolean isReceipt()
    {
        return receipt;
    }

    //是否已安排接送
    public boolean isClerk() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ciocompany FROM CioPart WHERE ciocompany=" + ciocompany + " AND cioclerkid>0");
            return db.next();
        } finally
        {
            db.close();
        }
    }

    //是否已安排住宿
    public boolean isRoom() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT ciocompany FROM CioPart WHERE ciocompany=" + ciocompany + " AND rname IS NOT NULL");
            return db.next();
        } finally
        {
            db.close();
        }
    }

    //是否已安排坐位
    public boolean isSeat() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT cp.ciocompany FROM CioPart cp INNER JOIN CioSeat cs ON cp.ciopart=cs.ciopart WHERE cp.ciocompany=" + ciocompany);
            return db.next();
        } finally
        {
            db.close();
        }
    }

    public String getInvoice()
    {
        return invoice;
    }

    public String getReceiptToHtml() throws SQLException
    {
        Community c = Community.find(community);
        StringBuilder h = new StringBuilder();
        h.append("<html>");
        h.append("<head>");
        h.append("<style>");
        try {
			h.append(c.getCss());
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        h.append("</style>");
        Enumeration dnse = DNS.findByCommunity(community,0);
        if(dnse.hasMoreElements())
        {
            String sn = (String) dnse.nextElement();
            h.append("<base href='http://").append(sn).append("' />");
        }
        h.append("<SCRIPT LANGUAGE=JAVASCRIPT SRC='/tea/tea.js' type='text/javascript'></SCRIPT>");
        h.append("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>");
        h.append("</head>");
        h.append("<body id='qiyelog_05'>");
        h.append("");
        h.append("<h1>确认参会信息</h1>");
        h.append("<div id='tes_body02'>");
        h.append("<div id='head6'><img height='6' src='about:blank'></div>");
        h.append("<br/>");
        h.append("<div id='div_001'>");
        h.append(name + ",参会负责人您好：</div>");
        h.append("<div id='div_002'>您的企业于" + this.getTimeToString() + "提交参会报名表,我们已确认了报名信息,您的参会信息如下,<br/>");
        h.append("其中各参会代表可以用下表中分配的代表号及密码登录本网站进行参会信息管理.");
        h.append("</div>");
        h.append("");
        h.append("");
        h.append("<h2>参会企业信息</h2>");
        h.append("<div id='qiy_xx'>");
        h.append("<table border='0' cellpadding='0' cellspacing='0' id='qiy_xx_table'>");
        h.append("  <tr>");
        h.append("    <td  nowrap colspan='3'>参会企业(集团)名称：<span id='table_tesspan'>");
        if(name != null)
        {
            h.append(name);
        }
        h.append("</td>");
        h.append("  </tr>");
        h.append("  <tr>");
        h.append("    <td id='td_01'>参会联系人：");
        if(contact != null)
        {
            h.append(contact);
        }
        h.append("</td>");
        h.append("    <td id='td_02' >联系人电话：");
        if(tel != null)
        {
            h.append(tel);
        }
        h.append("</td>");
        h.append("  </tr>");
        h.append("  <tr>");
        h.append("    <td id='td_01'>联系人手机：");
        if(mobile != null)
        {
            h.append(mobile);
        }
        h.append("</td>");
        h.append("    <td id='td_02'>E-Mail：");
        if(email != null)
        {
            h.append(email);
        }
        h.append("</td>");
        h.append("  </tr>");
        h.append("  <tr>");
        h.append("    <td colspan='3'>本企业关心的问题：<br/>");
        if(remark != null)
        {
            h.append(remark);
        }
        h.append("");
        h.append("  </tr>");
        h.append("  <tr>");
        h.append("    <td>上传参会相关文件：</td>");
        h.append("    <td colspan='3'>");
        String as[] = getAttach();
        for(int i = 0;i < as.length;i++)
        {
            int j = as[i].lastIndexOf('/') + 1;
            String aname = as[i].substring(j);
            String ex = aname.substring(aname.lastIndexOf('.') + 1).toLowerCase();
            //h.append("<a href='/jsp/include/DownFile.jsp?uri=" + java.net.URLEncoder.encode(as[i],"UTF-8") + "&name=" + java.net.URLEncoder.encode(aname,"UTF-8") + "'><img src='/tea/image/netdisk/" + ex + ".gif' align='top' />" + aname + "</a>　");
            h.append("<img src='/tea/image/netdisk/" + ex + ".gif' align='top' />" + aname + "　");
        }
        h.append("    </td>");
        h.append("  </tr>");
        h.append("</table>");
        h.append("</div>");
        h.append("");
        h.append("<h2>参会人员信息</h2>");
        h.append("<div id='canh_ry'>");
        h.append("<table border='0' cellpadding='0' cellspacing='0' id='canh_ry_table'>");
        h.append("  <tr id='tableonetr'>");
        h.append("    <td>姓名</td>");
        h.append("    <td>职位</td>");
        h.append("    <td>部门</td>");
        h.append("    <td>代表号</td>");
        h.append("    <td>密码</td>");
        h.append("  </tr>");
        Enumeration e = CioPart.find(ciocompany,"",0,Integer.MAX_VALUE);
        for(int i = 1;e.hasMoreElements();i++)
        {
            CioPart cp = (CioPart) e.nextElement();
            int cpid = cp.getCioPart();
            String cpmember = cp.getMember();
            Profile p = Profile.find(cpmember);
            h.append("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
            h.append("<td>" + i);
            h.append("<td>" + cp.getName());
            h.append("<td>" + cp.getJob());
            h.append("<td>" + cpmember);
            h.append("<td>" + p.getPassword());
        }
        h.append("</table>");
        h.append("</div>");
        h.append("<div id='tablebottom_02'>");
        h.append("如需对报名信息进行变更请联系<br/>");
        h.append("010-61392325<br/>");
        h.append("注： 因事不到等请提前通知我们,以便于安排工作,谢谢!</div>");
        h.append("<br>");
        h.append("<div id='head6'><img height='6' src='about:blank'></div>");
        h.append("</div>");
        h.append("</body>");
        h.append("</html>");
        return h.toString();
    }

    public int getCioCompany()
    {
        return ciocompany;
    }

    public void setSpecial(boolean special) throws SQLException
    {
        set_("special",special ? "1" : "0");
        this.special = special;
    }

    public void setName(String name) throws SQLException
    {
        set_("name",name);
        this.name = name;
    }

    public void setReceipt(boolean receipt) throws SQLException
    {
        set_("receipt",receipt ? "1" : "0");
        this.receipt = receipt;
    }

    private void set_(String field,String data) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE CioCompany SET " + field + "=" + DbAdapter.cite(data) + " WHERE ciocompany=" + ciocompany);
        } finally
        {
            db.close();
        }
    }
}
