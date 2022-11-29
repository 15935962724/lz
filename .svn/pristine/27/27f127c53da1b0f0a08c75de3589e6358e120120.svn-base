package tea.entity.node;

import java.io.*;
import java.security.*;
import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.bbs.*;
import tea.entity.lvyou.LvyouModels;
import tea.entity.member.*;
import tea.entity.site.*;
import tea.html.*;
import tea.entity.util.*;
import tea.ui.*;
import tea.entity.community.Medal;

public class BBS extends Entity
{
    private static Cache _cache = new Cache(100);
    private int hint;
    private int node;
    private int language;
    private String ip;
    public String name;
    public String phone;
    private String email;
    private String area;
    private String address;
    public boolean locking; //锁定
    private boolean parktop; //置顶//
    private boolean quintessence; //精华//
    private int best; //最佳的回复//////
    private int replycount; //回复条数
    private String replymember; //最后的回复人
    private Date replytime; //最后的回复日期
    private int search; //是否查阅 0 没有查阅，1 已经查阅
    private String searchmember; //查阅人员
    private Date searchtime; //查阅时间
    public String umember; //修改贴子的会员
    public int special; //贴子类型:默认;投票;
    //投票
    public int vote; //参与投票人数
    public boolean multiple; //多选投票
    public int expiration = 7; //记票天数
    public boolean visibility; //投票后结果可见
    public boolean overt; //公开投票参与人
    //活动
    public Date starttime; //开始时间
    public String place; //活动地点
    public String category; //活动类别
    public float cost; //每人花销
    public String city; //所在城市
    public int rnumber; //需要人数
    public static String[] SEX_TYPE =
            {"不限","男","女"};
    public int sex; //性别:不限;男;女;
    public Date exptime; //截止日期
    //招聘
    public static String[] WAGE_TYPE =
            {"面谈面议","1000以下","1000~1500","1500~2000","2000~3000","3000~4000","4000~6000","6000~8000","8000以上"};
    public int wage; //薪酬待遇
    public int icity; //工作地点
    public String professional; //专业技能
    public String requires; //要求
    //求职
    public int age; //年龄
    public int experience; //工作年限
    public int jobtype; //身份类型
    public int jobmodel; //操作机型
    private boolean exists;
    public static BBS find(int node,int language) throws SQLException
    {
        BBS obj = (BBS) _cache.get(node + ":" + language);
        if(obj == null)
        {
            obj = new BBS(node,language);
            _cache.put(node + ":" + language,obj);
        }
        return obj;
    }

    public BBS(int node,int language) throws SQLException
    {
        this.node = node;
        this.language = language;
        load();
    }

    public static int[] count(int father) throws SQLException
    {
        int[] j = new int[2];
        DbAdapter db = new DbAdapter();
        try
        {
            // 贴子数
            db.executeQuery("SELECT COUNT(*) FROM Node n WHERE n.father=" + father + " AND n.type=57 AND n.hidden=0");
            if(db.next())
                j[0] = db.getInt(1);
            // 回复数
            db.executeQuery("SELECT COUNT(*) FROM Node n INNER JOIN BBSReply br ON n.node=br.node WHERE n.father=" + father + " AND n.type=57 AND n.hidden=0");
            if(db.next())
                j[1] = db.getInt(1);
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int countByMember(String community,String member) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(node) FROM Node WHERE type=57 AND community=" + DbAdapter.cite(community) + " AND vcreator=" + DbAdapter.cite(member));
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

    public static Enumeration findByMember(String community,String member,int pos,int pagesize) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Node WHERE type=57 AND finished=1 AND community=" + DbAdapter.cite(community) + " AND vcreator=" + DbAdapter.cite(member) + " ORDER BY node DESC",pos,pagesize);
            while(db.next())
            {
                v.add(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int countByMemberMobile(String community,String member) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(b.node) FROM BBS b,Node n WHERE n.node=b.node and  b.ip='mobileqz' AND n.community=" + DbAdapter.cite(community) + "  AND n.vcreator=" + DbAdapter.cite(member));
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

    public static int findByMemberMobile(String community,String member) throws SQLException
    {
        int node = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT b.node FROM BBS b,Node n WHERE n.node=b.node and  b.ip='mobileqz' AND n.community=" + DbAdapter.cite(community) + " AND n.vcreator=" + DbAdapter.cite(member));
            if(db.next())
            {
                node = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return node;
    }

    public static int countByMemberMobile(String community,String member,String subject) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(b.node) FROM BBS b,Node n,NodeLayer nl WHERE n.node=b.node and n.node=nl.node and  b.ip='mobilezp' AND n.community=" + DbAdapter.cite(community) + "  AND n.vcreator=" + DbAdapter.cite(member) + "  AND nl.subject=" + DbAdapter.cite(subject));
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

    public static int findByMemberMobile(String community,String member,String subject) throws SQLException
    {
        int node = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT b.node FROM BBS b,Node n,NodeLayer nl WHERE n.node=b.node  and n.node=nl.node and  b.ip='mobilezp' AND n.community=" + DbAdapter.cite(community) + " AND n.vcreator=" + DbAdapter.cite(member) + "  AND nl.subject=" + DbAdapter.cite(subject));
            if(db.next())
            {
                node = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return node;
    }

    public void set(int hint,String ip,String name,String phone,String email,String area,String address,String umember,int special,boolean multiple,int expiration,boolean visibility,boolean overt,Date starttime,String place,String category,float cost,String city,int rnumber,int sex,Date exptime,int wage,int icity,String professional,String requires,int age,int experience,int jobtype,int jobmodel) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE BBS SET hint=" + (hint) + ",ip=" + DbAdapter.cite(ip) + ",name=" + DbAdapter.cite(name) + ",phone=" + DbAdapter.cite(phone) + ",email=" + DbAdapter.cite(email) + ",area=" + DbAdapter.cite(area) + ",address=" + DbAdapter.cite(address) + ",umember=" + DbAdapter.cite(umember) + ",special=" + special + ",multiple=" + DbAdapter.cite(multiple) + ",expiration=" + expiration + ",visibility=" + DbAdapter.cite(visibility) + ",overt=" + DbAdapter.cite(overt) + ",starttime=" + DbAdapter.cite(starttime) + ",place=" + DbAdapter.cite(place) + ",category=" + DbAdapter.cite(category) + ",cost=" + cost + ",city=" + DbAdapter.cite(city) + ",rnumber=" + rnumber + ",sex=" + sex + ",exptime=" + DbAdapter.cite(exptime) + ",wage=" + wage + ",icity=" + icity + ",professional=" +
                             DbAdapter.cite(professional) + ",requires=" + DbAdapter.cite(requires) + ",age=" + age + ",experience=" + experience + ",jobtype=" + jobtype + ",jobmodel=" + jobmodel + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        _cache.remove(node + ":" + language);
        this.hint = hint;
        this.ip = ip;
        this.email = email;
        this.phone = phone;
    }

    public static void delete(int nid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from BBS where node=" + nid);
        } finally
        {
            db.close();
        }

    }

    public static void create(int node,int language,int hint,String ip,String name,String phone,String email,String area,String address,int special,boolean multiple,int expiration,boolean visibility,boolean overt,Date starttime,String place,String category,float cost,String city,int rnumber,int sex,Date exptime,int wage,int icity,String professional,String requires,int age,int experience,int jobtype,int jobmodel) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO BBS(node,language,hint,ip,name,phone,email,area,address,locking,parktop,replycount,replytime,special,multiple,expiration,visibility,overt,starttime,place,category,cost,city,rnumber,sex,exptime,wage,icity,professional,requires,age,experience,jobtype,jobmodel)VALUES(" + node + "," + language + "," + (hint) + "," + DbAdapter.cite(ip) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(phone) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(area) + "," + DbAdapter.cite(address) + ",0,0,0," + DbAdapter.cite(new Date()) + "," + special + "," + DbAdapter.cite(multiple) + "," + expiration + "," + DbAdapter.cite(visibility) + "," + DbAdapter.cite(overt) + "," + DbAdapter.cite(starttime) + "," + DbAdapter.cite(place) + "," + DbAdapter.cite(category) +
                             "," + cost + "," +
                             DbAdapter.cite(city) +
                             "," +
                             rnumber + "," + sex + "," + DbAdapter.cite(exptime) + "," + wage + "," + icity + "," + DbAdapter.cite(professional) + "," + DbAdapter.cite(requires) + "," + age + "," + experience + "," + jobtype + "," + jobmodel + ")");
        } finally
        {
            db.close();
        }
    }

    private void load() throws SQLException
    {
        int j = Node.getLanguage(node,language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT hint,ip,name,phone,email,area,address,locking,parktop,quintessence,best,replycount,replymember,replytime,search,searchmember,searchtime,umember,special,vote,multiple,expiration,visibility,overt,starttime,place,category,cost,city,rnumber,sex,exptime,wage,icity,professional,requires,age,experience,jobtype,jobmodel FROM BBS WHERE node=" + node + " AND language=" + j);
            if(db.next())
            {
                int i = 1;
                hint = db.getInt(i++);
                ip = db.getString(i++);
                name = db.getVarchar(language,j,i++);
                phone = db.getString(i++);
                email = db.getString(i++);
                area = db.getVarchar(language,j,i++);
                address = db.getVarchar(language,j,i++);
                locking = db.getInt(i++) != 0;
                parktop = db.getInt(i++) != 0;
                quintessence = db.getInt(i++) != 0;
                best = db.getInt(i++);
                replycount = db.getInt(i++);
                replymember = db.getString(i++);
                replytime = db.getDate(i++);
                search = db.getInt(i++);
                searchmember = db.getString(i++);
                searchtime = db.getDate(i++);
                umember = db.getString(i++);
                special = db.getInt(i++);
                //
                vote = db.getInt(i++);
                multiple = db.getInt(i++) != 0;
                expiration = db.getInt(i++);
                visibility = db.getInt(i++) != 0;
                overt = db.getInt(i++) != 0;
                //
                starttime = db.getDate(i++);
                place = db.getString(i++);
                category = db.getString(i++);
                cost = db.getFloat(i++);
                city = db.getString(i++);
                rnumber = db.getInt(i++);
                sex = db.getInt(i++);
                exptime = db.getDate(i++);
                //
                wage = db.getInt(i++);
                icity = db.getInt(i++);
                professional = db.getString(i++);
                requires = db.getString(i++);
                //
                age = db.getInt(i++);
                experience = db.getInt(i++);
                jobtype = db.getInt(i++);
                jobmodel = db.getInt(i++);
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


    public int getHint()
    {
        return hint;
    }

    public int getNode()
    {
        return node;
    }

    public static int getCount(String member)
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT COUNT(*) FROM BBSReply WHERE member=" + DbAdapter.cite(member)) + db.getInt("SELECT COUNT(node) FROM Node WHERE type=57 AND rcreator=" + DbAdapter.cite(member));
        } catch(SQLException ex)
        {
            return 0;
        } finally
        {
            db.close();
        }
    }


    public int getLanguage()
    {
        return language;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getIp()
    {
        return ip;
    }

    public String getIpBlur()
    {
        String blur;
        int index = ip.lastIndexOf(".");
        blur = ip.substring(0,index + 1) + "*";
        return blur;
    }

    public String getName()
    {
        return name;
    }

    public String getPhone()
    {
        return phone;
    }

    public String getEmail()
    {
        return email;
    }

    public String getArea()
    {
        return area;
    }

    public String getAddress()
    {
        return address;
    }

    public boolean isParktop()
    {
        return parktop;
    }

    public boolean isQuintessence()
    {
        return quintessence;
    }

    public int getBest()
    {
        return best;
    }

    public int getReplyCount()
    {
        return replycount;
    }

    public String getReplyMember()
    {
        return replymember;
    }

    public int getSearch()
    {
        return search;
    }

    public String getSearchmember()
    {
        return searchmember;
    }

    public Date getSearchtime()
    {
        return searchtime;
    }

    public Date getReplyTime()
    {
        return replytime;
    }

    public String getReplyTimeToString()
    {
        if(replytime == null) //语言层不对,此时期为空
        {
            return "";
        }
        return sdf2.format(replytime);
    }

    public String getHtml(Http h) throws SQLException
    {
        Node obj = Node.find(node);
        String str = obj.getText2(language) + BBSAttach.toHtml(false,node);
        if(obj.getFileName(language) != null && obj.getFileName(language).length() > 1)
        {
            String wpath = obj.getFileName(language);
            try
            {
                str += "<br/><br/>下载：&nbsp;<a href=/jsp/include/DownFile.jsp?uri=" + java.net.URLEncoder.encode(wpath,"utf-8") + "&name=" + java.net.URLEncoder.encode("附件","utf-8") + "." + wpath.substring(wpath.lastIndexOf(".") + 1) + "><img src=\"/tea/image/netdisk/" + wpath.substring(wpath.lastIndexOf(".") + 1) + ".gif\" />&nbsp;附件</a>";
            } catch(UnsupportedEncodingException ex2)
            {
                ex2.getStackTrace();
            }
        }
        if(obj.getTime().compareTo(obj.getUpdatetime()) != 0)
        {
            str += "<br><span id='BBSIDeditalert'>[此贴子已经被 " + (this.umember == null || obj.getCreator()._strR.equals(this.umember) ? "作者" : this.umember) + " 于 " + obj.getUpdatetimeToString() + " 编辑过]</span>";
        }
        if(str.indexOf("[cc]") != -1 && str.indexOf("[/cc]") != -1) //有视频
        {
            StringBuffer sp = new StringBuffer();

            str = str.replace("[cc]","");
            str = str.replace("[/cc]","");

            sp.append("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0\" width=\"438\" height=\"387\" id=\"ccplayer\">");
            sp.append("&nbsp;&nbsp;");
            sp.append("<param name=\"movie\" value=\"http://union.bokecc.com/" + str + "\" />&nbsp;&nbsp;");
            sp.append("<param name=\"allowFullScreen\" value=\"true\" />&nbsp; &nbsp;");
            sp.append("<param name=\"allowScriptAccess\" value=\"always\" />&nbsp;&nbsp;");
            sp.append("<param name=\"quality\" value=\"high\" />&nbsp;&nbsp;");
            sp.append("<embed src=\"http://union.bokecc.com/" + str + "\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" width=\"438\" height=\"387\" allowFullscreen=\"true\" allowScriptAccess=\"always\"></embed>");
            sp.append("</object>");
            str = sp.toString();
        }
        if(str.indexOf("[img]") != -1 && str.indexOf("[/img]") != -1) //判断照片显示
        {
            if(str.indexOf("[align=center]") != -1 && str.indexOf("[/align]") != -1)
            {
                str = str.replace("[align=center]","<div align=center>");
                str = str.replace("[/align]","</div>");
            }
            str = str.replace("[img]","<div><img src=");
            str = str.replace("[/img]","></div>");
        }
        str = str.replace("　　","<br>　　");
        //
        StringBuilder st = new StringBuilder();
        if(this.special == 1)
        {
            boolean ise = false,isv = false;
            st.append("<form name='frmbp' action='/servlet/EditBBS' method='post' target='_ajax'><input type='hidden' name='node' value='" + node + "'/><input type='hidden' name='act' value='poll'/>");
            st.append("<b>" + (this.multiple ? "多" : "单") + "选投票</b>,共有 " + this.vote + " 人参与投票");
            if(this.visibility)
                st.append(",投票后结果可见");
            if(this.overt)
                st.append(" <a href='javascript:mt.bpv()'>查看投票参与人</a>");
            if(this.expiration > 0)
            {
                Calendar cal = Calendar.getInstance();
                cal.setTime(obj.getUpdatetime());
                cal.add(cal.DAY_OF_YEAR,this.expiration);
                long time = cal.getTime().getTime() - System.currentTimeMillis() + 10000;
                if(time > 0)
                {
                    cal.setTimeInMillis(time - 28800000);
                    st.append("<br/>距结束还有: <b>" + (cal.get(cal.DAY_OF_YEAR) - 1) + "天 " + cal.get(cal.HOUR_OF_DAY) + "小时 " + cal.get(cal.MINUTE) + "分钟</b>");
                } else
                    isv = true;
            }
            int sum = 0;
            ArrayList al = BBSPoll.find(" AND node=" + node,0,200);
            Iterator it = al.iterator();
            for(int i = 1;it.hasNext();i++)
            {
                BBSPoll bp = (BBSPoll) it.next();
                ise = ise || (h.username != null && bp.member.indexOf("|" + h.username + "|") != -1);
                sum += bp.hits;
            }
            st.append("<table>");
            it = al.iterator();
            for(int i = 1;it.hasNext();i++)
            {
                BBSPoll bp = (BBSPoll) it.next();
                st.append("<tr><td>");
                if(!ise && !isv)
                    st.append("<input name='question' type='" + (this.multiple ? "checkbox" : "radio") + "' value='" + bp.bbspoll + "' id='_question" + i + "'>");
                st.append("<label for='_question" + i + "'>" + i + "." + bp.question + "</label>");
                int per = sum < 1 ? 0 : bp.hits * 100 / sum;
                if(!this.visibility || ise)
                    st.append("<tr><td><div style='background:#FAFAFA;width:470px;margin-left:20px;float:left'><div style='background:#F2A61F;width:" + per + "%;'></div></div>" + per + "% (" + bp.hits + ")");
            }
            st.append("</table>");
            if(isv)
                st.append("该投票已过期！");
            else if(ise)
                st.append("您已经投过票，谢谢您的参与 ");
            else
            {
                st.append("<input name='multi' type='submit' value='提交' />");
                if(this.overt)
                    st.append("(此为公开投票，其他人可看到你的投票项目)");
            }
            st.append("</form><script>mt.bpv=function(){mt.show('/jsp/type/bbs/BBSPollViewInc.jsp?node=" + node + "',1,'参与投票的会员',400,300);};mt.disabled(frmbp.question);</script>");
            st.append(str);
        } else if(this.special == 2)
        {
            st.append("<table><tr><th>" + this.category +
                      "<tr><td>开始时间<td>" + MT.f(this.starttime,1) +
                      "<tr><td>活动地点<td>" + this.city + " " + this.place +
                      "<tr><td>每人花销<td>" + this.cost +
                      "<tr><td>性别<td>" + SEX_TYPE[this.sex]);
            if(this.exptime != null)
                st.append("<tr><td>征集截止日期<td>" + MT.f(this.exptime,1));
            st.append("</table>");
            st.append(str);
            int sum = BBSActivity.count(" AND node=" + node + " AND state=1");
            st.append("<table><tr><td>已报名人数:<td>" + sum + "个");
            if(obj.isCreator(h.member))
                st.append("<td><a href='javascript:mt.aview()'>查看</a>　<a href='javascript:mt.aexp()'>导出</a>");
            st.append("<td rowspan='2'>");
            Iterator it;
            if(h.username != null && (it = BBSActivity.find(" AND node=" + node + " AND member=" + DbAdapter.cite(h.username),0,1).iterator()).hasNext())
            {
                BBSActivity ba = (BBSActivity) it.next();
                st.append("<span style='border:1px solid #FF9999; background:#FFF7F7; color:#CC0000; padding:6px'>" + (ba.state == 1 ? "您已经参加了此活动" : "您的加入申请已发出，请等待发起者的审批") + "</span>");
            } else if(this.exptime != null && this.exptime.getTime() > System.currentTimeMillis())
                st.append("<input type='button' value='我参加' onclick='mt.hidden(document.frmact)' />");
            if(this.rnumber > 0)
                st.append("<tr><td>剩余名额:<td>" + Math.max(this.rnumber - sum,0) + "个<td>");

            st.append("</table><br/>");
            st.append("<form name='frmact' action='/servlet/EditBBS?node=" + node + "' method='post' target='_ajax' onSubmit=\"frmact.cost.alt=this.payment[1].checked?'支付':'';return mt.check(this)\" style='display:none'><input name='act' type='hidden' value='activityadd'><table>");
            if(this.cost > 0)
                st.append("  <tr><td>支付方式</td><td><input type='radio' name='payment' value='0' id='payment_0' checked><label for='payment_0'>承担自己应付的花销</label> <input type='radio' name='payment' value='1' id='payment_1'><label for='payment_1'>支付</label><input name='cost' mask='float' size='5'>元</td></tr>");
            st.append("  <tr><td>联系方式</td><td><input type='text' name='contact' value=\"" + (h.username != null ? Profile.find(h.username).getTelephone(h.language) : "") + "\" size='40' alt='联系方式'></td></tr>");
            st.append("  <tr><td>留言</td><td><input type='text' name='remark' size='40'></td></tr>");
            st.append("  <tr><td>&nbsp;</td><td><input type='submit' value='提交'></td></tr>");
            st.append("</table></form>");
            st.append("<script>mt.aview=function(){mt.show('/jsp/type/bbs/BBSActivitysInc.jsp?node=" + node + "',2,'活动报名者管理',600,400);};mt.aexp=function(){mt.post('/servlet/EditBBS?act=activityexp&node=" + node + "');}</script>");
            //会员列表
            StringBuilder a = new StringBuilder(),b = new StringBuilder();
            it = BBSActivity.find(" AND node=" + node,0,Integer.MAX_VALUE).iterator();
            while(it.hasNext())
            {
                BBSActivity ba = (BBSActivity) it.next();
                ProfileBBS pa = ProfileBBS.find(obj.getCommunity(),ba.member);
                (ba.state == 0 ? a : b).append("<span style='float:left;padding-right:5px;'><img src=" + pa.getPortrait(language) + " width='50' height='50' /><br>" + ba.member + "</span>");
            }
            if(a.length() > 0)
                st.append("<div style='clear:both; font-weight:bold'>最新报名会员</div>").append(a).append("<br/>");
            if(b.length() > 0)
                st.append("<div style='clear:both; font-weight:bold'>最新参加会员</div>").append(b).append("<br/>");
        } else if(this.special == 3)
        {
            st.append("<table>");
            st.append("<tr><td>联系姓名:<td>" + this.name);
            st.append("<tr><td>联系方式:<td>" + this.phone);
            st.append("<tr><td>薪酬待遇:<td>" + this.WAGE_TYPE[this.wage]);
            st.append("<tr><td>工作地点:<td>" + Card.find(this.icity).toString());
            st.append("<tr><td>操作机型:<td>" + this.professional);
            if(this.rnumber > 0)
                st.append("<tr><td>招聘人数:<td>" + this.rnumber);
            if(MT.f(this.requires).length() > 0)
                st.append("<tr><td>对机手的要求:<tr><td colspan='2' style='padding-left:20px'>" + this.requires.replaceAll("\n","<br/>"));
            st.append("</table><br/>").append(str);
        } else if(this.special == 4)
        {
            st.append("<table>");
            st.append("<tr><td>联系姓名:<td>" + this.name);
            if(this.sex > 0)
                st.append("(" + SEX_TYPE[sex] + ")");
            st.append("<tr><td>年　　龄:<td>" + this.age);
            st.append("<tr><td>联系方式:<td>" + this.phone);
            st.append("<tr><td>薪酬待遇:<td>" + this.WAGE_TYPE[this.wage]);
            st.append("<tr><td>工作地点:<td>" + Card.find(this.icity).toString());
            if(this.experience > 0)
                st.append("<tr><td>操作年限:<td>" + this.experience);
            if(this.jobtype > 0)
                st.append("<tr><td>身份类型:<td>" + JobType.find(this.jobtype).name);
            if(this.jobmodel > 0)
                //   st.append("<tr><td>操作机型:<td>" + Profile.WST_MODEL[this.jobmodel]);
                st.append("<tr><td>操作机型:<td>" + LvyouModels.find(this.jobmodel).getName());

            st.append("</table><br/>").append(str);
        } else
            st.append(str);

        //积分
        st.append("<br><div id='bbspoint'>");
        int sum = 0;
        Iterator it = BBSPoint.find(" AND node=" + node + " AND type IN(1,4,5,6,7,9,16,17)",0,200).iterator();
        while(it.hasNext())
        {
            BBSPoint bp = (BBSPoint) it.next();
            sum += bp.point;
            st.append(bp.type == 16 ? bp.content : bp.TYPE_NAME[bp.type]).append((bp.point < 0 ? "减" : "加") + "分:" + bp.point + "　");
        }
        st.append("总共加分:" + sum + "</div>");
        return st.toString();
    }

    //    int lastreply = -1;
//    public int getLastReply() throws SQLException
//    {
//        if(lastreply == -1)
//        {
//            DbAdapter db = new DbAdapter();
//            try
//            {
//                return db.getInt("SELECT id FROM BBSReply WHERE node=" + node + " ORDER BY id DESC");
//            } finally
//            {
//                db.close();
//            }
//        }
//        return lastreply;
//    }

    public static String getDetail(Node obj,Http h,int language,int listing,String target,tea.resource.Resource r) throws SQLException
    {
        Span span = null;
        StringBuilder sb = new StringBuilder();
        int node = obj._nNode;
//		if(node==32850)
//		{
//			System.out.println("===");
//		}
        String member = obj.getCreator()._strR;
        ProfileBBS pb = ProfileBBS.find(obj.getCommunity(),member);
        Profile p = Profile.find(member);
        BBS bbs = BBS.find(node,language);
        Class c = bbs.getClass();
        int best = bbs.getBest();
        r.add("/tea/resource/BBS");
        boolean isAno = RV.ANONYMITY.equals(obj.getCreator());
        ListingDetail detail = ListingDetail.find(listing,57,language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = "";
            int quantity = detail.getQuantity(name);
            int istype = detail.getIstype(name);
            String sid = name;
            if(istype == 0 || name.startsWith("b_") || name.startsWith("r_") || name.equals("celerity"))
            {
                continue;
            } else if(name.equals("news"))
            {
                int i = BBSReply.count(obj._nNode," AND time>" + DbAdapter.cite(new Date(),true));
                sid = (i > 0 ? "isnew" : "nonews");
                value = "";
            } else if(name.equals("hits"))
            {
                value = String.valueOf(obj.getClick());
            } else if(name.equals("hint"))
            {
                if(bbs.getHint() > 0)
                    value = "<img src='/tea/image/hint/" + bbs.getHint() + ".gif' />";
            } else if(name.equals("subject"))
            {
                String b = "common";
                if(bbs.isParktop()) // 置顶
                {
                    b = "parktop";
                } else
                if(bbs.isQuintessence()) // 加精
                {
                    b = "quintessence";
                } else if(Forum.find(h.community).getHot() < bbs.getReplyCount()) //热
                {
                    b = "hot";
                }
                b = "<span id='BBSID" + b + "'></span>";
                if(BBSAttach.count(" AND type=0 AND bbsid=" + node) > 0) //有附件
                {
                    b += "<span id='BBSIDattach'></span>";
                }
                if(quantity > 0)
                {
                    quantity += b.length();
                }
                value = b + obj.getSubject(language);
            } else if(name.equals("creator")) //
            {
                value = isAno ? r.getString(language,RV.ANONYMITY.toString()) : p.getName(h.language);
            } else if(name.equals("memberid")) //会员ID
            {
                value = isAno ? r.getString(language,RV.ANONYMITY.toString()) : "<a href='/jsp/type/bbs/ViewBBSProfile.jsp?member=" + Http.enc(member) + "'>" + member + "</a>";
            } else if(name.equals("sex"))
            {
                if(RV.ANONYMITY.equals(obj.getCreator()))
                {
                    value = ("*");
                } else
                {
                    value = (r.getString(language,p.isSex() ? "Man" : "Woman"));
                }
            } else if(name.equals("count"))
            {
                value = isAno ? "*" : String.valueOf(BBS.getCount(obj.getCreator()._strR));
            } else if(name.equals("register"))
            {
                value = ((p.getTime() != null) ? sdf2.format(p.getTime()) : "");
            } else if(name.equals("text"))
            {
                value = bbs.getHtml(h);
            } else if(name.equals("photo"))
            {
                value = "<img src=\"" + pb.getPortrait(language) + "\" />";
            } else if(name.equals("replycount"))
            {
                // int cc = BBSReply.count(node,language);
                value = String.valueOf(bbs.getReplyCount());
            } else if(name.equals("replybutton"))
            {
                value = (new tea.html.Button("",r.getString(language,"CBReply"),"window.location='/jsp/type/bbs/EditBBSReply.jsp?node=" + node + "';").toString());
            } else if(name.equals("friend"))
            {
                value = "<a href='/FriendLists.do?act=add&member=" + Http.enc(member) + "' target='_ajax'>加为好友</a>";
            } else if(name.startsWith("lastreplymember"))
            {
                //回复人昵称
                if(detail.getOptions(name).indexOf("/2/") != -1)
                {
                    if(bbs.getReplyMember() != null && bbs.getReplyMember().length() > 0)
                    {
                        ProfileBBS pb2 = ProfileBBS.find(obj.getCommunity(),bbs.getReplyMember());
                        value = pb2.getTitle(language);
                    } else
                    {
                        value = "游客";
                    }

                } else if(detail.getOptions(name).indexOf("/1/") != -1)
                {
                    if(bbs.replymember == null)
                    {
                        bbs.replymember = obj.getCreator()._strR;
                    }
                    Profile pp = Profile.find(bbs.getReplyMember());
                    value = pp.getName(h.language);
                } else if(detail.getOptions(name).indexOf("/3/") != -1)
                {
                    if(bbs.replymember == null)
                    {
                        bbs.replymember = obj.getCreator()._strR;
                    }

                    value = bbs.getReplyMember();
                }
            } else if(name.equals("lastreplytime"))
            {
                if(detail.getOptions(name).indexOf("/2/") != -1)
                {
                    value = bbs.getReplyTimeToString().substring(5,bbs.getReplyTimeToString().length());
                } else
                {
                    value = bbs.getReplyTimeToString();
                }

            } else if(name.equals("issue"))
            {
                value = (obj.getTimeToString());
            } else if(name.equals("level"))
            {
                if(RV.ANONYMITY.equals(obj.getCreator()))
                {
                    value = ("*");
                } else
                {
                    BBSLevel bl = BBSLevel.find(p.getBbslevel());
                    if(bl.isExists())
                    {
                        value = "<span id='name'>" + bl.getName() + "</span><span id='pic'><img src='" + bl.getPicture() + "'/></span>";
                    }
                }
            } else if(name.equals("point"))
            {
                value = isAno ? "*" : new DecimalFormat("#,##0").format(p.getIntegral());
            } else if(name.equals("medal"))
            {
                String[] arr = MT.f(p.getMedal(),"|").split("[|]");
                for(int i = 1;i < arr.length;i++)
                {
                    Medal m = Medal.find(Integer.parseInt(arr[i]));
                    if(m.picture == null)
                        continue;
                    value += "<img src='" + m.picture + "' title='" + m.name + "' />";
                }
            } else if(name.equals("position"))
            {
                if(member.equals(Communitybbs.find(h.community).getSuperhost()))
                    value = "超级版主";
                else if(AdminUsrRole.find(h.community,member).getBbsHost().indexOf("/" + obj.getFather() + "/") != -1)
                    value = "本区版主";
                else
                    value = isAno ? "未注册会员" : "普通会员";
            } else if(name.equals("bbshost"))
            {
                StringBuilder sb_bbshost = new StringBuilder();
                //版主昵称
                if(detail.getOptions(name).indexOf("/2/") != -1)
                {

                    Enumeration enumer = AdminUsrRole.findByBbshost(obj.getFather());
                    while(enumer.hasMoreElements())
                    {
                        String m = ((String) enumer.nextElement());
                        ProfileBBS pb2 = ProfileBBS.find(obj.getCommunity(),m);
                        sb_bbshost.append("<span id=bbshost_2>");
                        sb_bbshost.append(pb2.getTitle(language));
                        sb_bbshost.append("</span>");
                    }
                } else if(detail.getOptions(name).indexOf("/1/") != -1) //版主ID
                {

                    Enumeration enumer = AdminUsrRole.findByBbshost(obj.getFather());
                    while(enumer.hasMoreElements())
                    {
                        sb_bbshost.append("<span id=bbshost_1>");
                        sb_bbshost.append(enumer.nextElement());
                        sb_bbshost.append("</span>");
                    }
                }

                value = (sb_bbshost.toString());
            } else if(name.equals("ip"))
            {
                value = (bbs.getIp());
            } else if(name.equals("getTitle"))
            {
                value = (pb.getTitle(language));
            } else if(name.equals("getSignature"))
            {
                value = (pb.getSignature(language));
            } else if(name.equals("quote"))
            {
                value = "<a class='reply' href='/jsp/type/bbs/EditBBSReply.jsp?node=" + node + "&reply=1'>回复</a> <a class='quote' href='/jsp/type/bbs/EditBBSReply.jsp?node=" + node + "&quote=1'>引用</a>";
            } else if(name.equals("delete"))
            {
                if(h.username != null)
                {
                    boolean isD = h.username.equals(Communitybbs.find(h.community).getSuperhost()) //超级版主
                                  || AdminUsrRole.find(h.community,h.username).getBbsHost().indexOf("/" + obj.getFather() + "/") != -1;
                    if(new RV(h.username).equals(obj.getCreator()) || isD) //创建者
                    {
                        if(isD)
                        {
                            value += " <input type='button' value=" + r.getString(language,bbs.parktop ? "取消固顶" : "固顶") + " onclick=\"mt.post('/servlet/EditBBS?act=parktop&node=" + node + "')\" />";
                            value += " <input type='button' value=" + r.getString(language,bbs.quintessence ? "取消精华" : "精华") + " onclick=\"mt.post('/servlet/EditBBS?act=quintessence&node=" + node + "')\" />";
                            value += " <input type='button' value=" + r.getString(language,"锁定") + " onclick=\"mt.show('<input name=locking id=_locking0 type=radio value=0" + (bbs.locking ? "" : " checked") + " /><label for=_locking0>解锁</label>　<input name=locking id=_locking1 type=radio value=1" + (bbs.locking ? " checked" : "") + " /><label for=_locking1>锁定</label>',2);mt.ok=function(){mt.post('/servlet/EditBBS?act=locking&node=" + node + "&locking='+$('_locking1').checked)}\" />";
                            value += " <input type='button' value=" + r.getString(language,"移动") + " onclick=\"mt.show('/jsp/type/bbs/BBSMove.jsp?nodes=," + node + ",&forum=" + obj.getFather() + "&nexturl='+encodeURIComponent(location.href),1,'移动贴子',280,120)\" />";
                            value += " <input type='button' value=" + r.getString(language,"自定义") + " onclick=\"mt.show('操作理由：<input id=_content /><br/>增减工分：<input id=_point size=10 mask=float />（1-50分）',2);mt.ok=function(){ var c=$('_content').value,p=$('_point').value;if(c==''){alert('“操作理由”不能为空！');return false;} mt.post('/servlet/EditBBS?act=custom&node=" + node + "&content='+encodeURIComponent(c)+'&point='+p);}\" />";
                            value += " <input type='button' value=" + r.getString(language,"禁言") + " onclick=\"edn.gag('" + member + "')\" />";
                        }
                        value += " <input class='edit' type='button' value=" + r.getString(language,"CBEdit") + " onclick=\"window.open('/jsp/type/bbs/EditBBS.jsp?node=" + node + "','_self');\">"
                                + " <input class='del' type='button' value=" + r.getString(language,"CBDelete") + " onclick=\"mt.show('" + r.getString(language,"ConfirmDelete") + "',2);mt.ok=function(){mt.post('/servlet/EditBBS?act=del&node=" + node + "')}\" >";
                    }
                }
            } else if(name.equals("nmark"))
            {
                NMark nm = NMark.find(node);
                value = "<script>mt.nmark(" + node + "," + nm.good + "," + nm.poor + ")</script>";
            } else
            /*
             * if (name.equals("getName")) { if ("ANONYMITY".equals(obj.getCreator()._strR)) { value=(r.getString(language, "ANONYMITY")); } else { value=(profile.getLastName(language) + " " + profile.getFirstName(language)); } } else
             */
            {
                try
                {
                    java.lang.reflect.Method m = c.getMethod(name,(java.lang.Class[])null);
                    value = ((String) m.invoke(bbs,(Object[])null));
                } catch(Exception ex)
                {
                    continue;
                }
            }
            // if (value != null && value.length() > 0)
            {
                if(value != null && quantity > 0 && value.length() > quantity)
                {
                    value = value.substring(0,quantity) + " ...";
                }
                if(detail.getAnchor(name) != 0)
                {
                    Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/bbs/" + node + "-" + language + ".htm",value);
                    anchor.setTarget(target);
                    span = new Span(anchor);
                } else
                {
                    span = new Span(value);
                }
                span.setId("BBSID" + sid);
                sb.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
            }
        }
        // 最佳//////////////////////////////////////////////////////////////////////////////////////////
//        e = ListingDetail.find(listing, 57, language);
//        while (e.hasMoreElements())
//        {
//            ListingDetail detail = (ListingDetail)ListingDetail) e.nextElement();
//            String name = detail.getItemName();
//            String value = "";
//            if (!name.startsWith("b_"))
//            {
//                continue;
//            }
//
//        }

        // 回复//////////////////////////////////////////////////////////////////////////////////////////
        int pos = 1;
        int size = Integer.MAX_VALUE;
        if(detail.getIstype("r_pagination") != 0) // 是否显示分页
        {
            size = 10;
            try
            {
                if(h.get("pos") != null)
                {
                    pos = Integer.parseInt(h.get("pos"));
                }
            } catch(NumberFormatException ex1)
            {
            }
        }
        int floor = (pos - 1) * size; // 楼层数
        int count = BBSReply.count(node,h.username,language);
        Enumeration reply_enumer = BBSReply.find(node,h.username,language,floor,size);
        while(reply_enumer.hasMoreElements())
        {
            int brid = ((Integer) reply_enumer.nextElement()).intValue();
            BBSReply reply_obj = BBSReply.find(brid);
            p = Profile.find(reply_obj.getMember());
            pb = ProfileBBS.find(obj.getCommunity(),reply_obj.getMember());
            e = detail.keys();
            while(e.hasNext())
            {
                String name = (String) e.next(),value = "";
                int istype = detail.getIstype(name);
                String sid = name;
                if(istype == 0 || !name.startsWith("r_"))
                {
                    continue;
                } else if(name.equals("r_creator"))
                {
                    if(RV.ANONYMITY.toString().equals(reply_obj.getMember()))
                    {
                        value = (r.getString(language,RV.ANONYMITY.toString()));
                    } else
                    {
                        value = p.getName(h.language);
                    }
                } else if(name.equals("r_memberid"))
                {
                    if(RV.ANONYMITY.toString().equals(reply_obj.getMember()))
                    {
                        value = (r.getString(language,RV.ANONYMITY.toString()));
                    } else
                    {
                        value = "<a href='/jsp/type/bbs/ViewBBSProfile.jsp?member=" + Http.enc(reply_obj.getMember()) + "'>" + reply_obj.getMember() + "</a>";
                    }
                } else if(name.equals("r_sex"))
                {
                    if(RV.ANONYMITY.toString().equals(reply_obj.getMember()))
                    {
                        value = ("*");
                    } else
                    {
                        value = (r.getString(language,p.isSex() ? "Man" : "Woman"));
                    }
                } else if(name.equals("r_count"))
                {
                    if(RV.ANONYMITY.toString().equals(reply_obj.getMember()))
                    {
                        value = ("*");
                    } else
                    {
                        value = String.valueOf(BBS.getCount(reply_obj.getMember()));
                    }
                } else if(name.equals("r_register"))
                {
                    if(p.getTime() != null)
                    {
                        value = (sdf2.format(p.getTime()));
                    } else
                    {
                        value = (null);
                    }
                } else if(name.equals("r_subject"))
                {
                    value = reply_obj.getSubject(language);
                } else if(name.equals("r_text"))
                {
                    value = reply_obj.getHtml(language);
                } else if(name.equals("r_photo"))
                {
                    value = "<img src=\"" + pb.getPortrait(language) + "\">";
                } else if(name.equals("r_floor"))
                {
                    value = String.valueOf(++floor);
                } else if(name.equals("friend"))
                {
                    value = "<a href='/FriendLists.do?act=add&member=" + Http.enc(reply_obj.getMember()) + "' target='_ajax'>加为好友</a>";
                } else if(name.equals("r_issue"))
                {
                    value = sdf2.format(reply_obj.getTime());
                } else if(name.equals("r_level"))
                {
                    if(RV.ANONYMITY.toString().equals(reply_obj.getMember()))
                    {
                        value = ("*");
                    } else
                    {
                        BBSLevel bl = BBSLevel.find(p.getBbslevel());
                        if(bl.isExists())
                        {
                            value = "<span id='name'>" + bl.getName() + "</span><span id='pic'><img src='" + bl.getPicture() + "'/></span>";
                        }
                    }
                } else if(name.equals("r_point"))
                {
                    if(RV.ANONYMITY.toString().equals(reply_obj.getMember()))
                    {
                        value = ("*");
                    } else
                    {
                        value = new DecimalFormat("#,##0").format(p.getIntegral());
                    }
                } else if(name.equals("r_medal"))
                {
                    String[] arr = MT.f(p.getMedal(),"|").split("[|]");
                    for(int i = 1;i < arr.length;i++)
                    {
                        Medal m = Medal.find(Integer.parseInt(arr[i]));
                        if(m.picture == null)
                            continue;
                        value += "<img src='" + m.picture + "' title='" + m.name + "' />";
                    }
                } else if(name.equals("r_position"))
                {
                    if(reply_obj.getMember().equals(Communitybbs.find(h.community).getSuperhost()))
                        value = "超级版主";
                    else if(AdminUsrRole.find(h.community,reply_obj.getMember()).getBbsHost().indexOf("/" + obj.getFather() + "/") != -1)
                        value = "本区版主";
                    else
                        value = RV.ANONYMITY.toString().equals(reply_obj.getMember()) ? "未注册会员" : "普通会员";
                } else if(name.equals("r_ip"))
                {
                    value = reply_obj.getIp();
                } else if(name.equals("r_visible"))
                {
                    String delete = null;
                    if(h.username != null)
                    {
                        tea.entity.site.Communitybbs com_obj = tea.entity.site.Communitybbs.find(obj.getCommunity());
                        boolean _bCommunityMember = h.username.equals(com_obj.getSuperhost()); // 超级版主
                        AdminUsrRole aur_obj = AdminUsrRole.find(obj.getCommunity(),h.username);
                        if(aur_obj.getBbsHost().indexOf("/" + obj.getFather() + "/") != -1 || _bCommunityMember)
                        {
                            String nexturl = h.request.getRequestURI() + "?" + h.request.getQueryString();
                            delete = "<input type='button' value='" + r.getString(language,"CBSetVisible") + "' onclick=\"location='/jsp/type/bbs/SetBBSReplyVisible.jsp?replay=" + brid + "&node=" + node + "&nexturl=" + nexturl + "';\">";
                        }
                    }
                    value = delete;
                } else if(name.equals("r_quote"))
                {
                    value = "<a class='reply' href='/jsp/type/bbs/EditBBSReply.jsp?node=" + node + "&reply=" + brid + "'>回复</a> <a class='quote' href='/jsp/type/bbs/EditBBSReply.jsp?node=" + node + "&quote=" + brid + "'>引用</a>";
                } else if(name.equals("r_delete")) //删除
                {
                    if(h.username != null)
                    {
                        // 创建者
                        boolean isc = h.username.equals(reply_obj.getMember());
                        ///版主
                        AdminUsrRole aur_obj = AdminUsrRole.find(obj.getCommunity(),h.username);
                        boolean isd = h.username.equals(Communitybbs.find(obj.getCommunity()).getSuperhost()) || aur_obj.getBbsHost().indexOf("/" + obj.getFather() + "/") != -1;
                        if(isd && best == 0)
                        {
                            value += "<input class='best' type='button' value='" + r.getString(language,"1205209236781") + "' onclick=\"window.location='/servlet/EditBBSReply?replay=" + brid + "&node=" + node + "&best=ON&nexturl='+encodeURIComponent(location); \">";
                        }
                        if(isc || isd)
                        {
                            if(isd)
                                value += " <input type='button' value=" + r.getString(language,"禁言") + " onclick=\"edn.gag('" + reply_obj.getMember() + "')\" />";
                            value += " <input class='edit' type='button' value=" + r.getString(language,"CBEdit") + " onclick=\"window.open('/jsp/type/bbs/EditBBSReply.jsp?node=" + node + "&bbsreply=" + brid + "','_self');\">" +
                                    " <input class='del' type='button' value=" + r.getString(language,"CBDelete") + " onclick=\"mt.show('" + r.getString(language,"ConfirmDelete") + "',2);mt.ok=function(){mt.post('/servlet/EditBBSReply?act=del&node=" + node + "&bbsreply=" + brid + "')}\" >";
                        }
                    }
                } else if(name.equals("r_getTitle"))
                {
                    if(pb.getTitle(language) == null || pb.getTitle(language).length() == 0)
                    {
                        if(RV.ANONYMITY.toString().equals(reply_obj.getMember()))
                        {
                            value = (r.getString(language,RV.ANONYMITY.toString()));
                        } else
                        {
                            value = p.getName(h.language);
                        }
                    } else
                    {
                        value = pb.getTitle(language);
                    }
                } else if(name.equals("r_getSignature"))
                {
                    value = pb.getSignature(language);
                } else
                {
                    continue;
                }
                // if (value != null && value.length() > 0)
                {
                    if(detail.getAnchor(name) != 0)
                    {
                        Anchor a = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/bbs/" + node + "-" + language + ".htm",value);
                        a.setTarget(target);
                        span = new Span(a);
                    } else
                    {
                        span = new Span(value);
                    }
                    if(best == brid) //最佳答案//
                    {
                        sid = "b" + name.substring(1);
                    }
                    span.setId("BBSID" + sid);
                    sb.append(detail.getBeforeItem(name)).append(span).append(detail.getAfterItem(name));
                }
            }
        }
        if(detail.getIstype("r_pagination") != 0) // 是否显示分页
        {
            sb.append(detail.getBeforeItem("r_pagination")).append("<span id='BBSIDr_pagination'>").append(new tea.htmlx.FPNL2(h.language,obj.getAnchor(h.language,h.status),pos,count,size)).append("</span>").append(detail.getAfterItem("r_pagination"));
        }
        // 快速回复
        Date gag = h.username == null ? null : Profile.find(h.username).getGag();
        if(detail.getIstype("celerity") != 0 && !bbs.locking && (gag == null || gag.getTime() < System.currentTimeMillis()))
        {
            sb.append(detail.getBeforeItem("celerity"));
            BBSForum bf = BBSForum.find(obj.getFather());
            if(!bf.isAuth(obj.getCommunity(),h.username,bf.lreply,bf.rreply))
            {
                if(h.username == null)
                    sb.append("你需要登录后才可以回帖 <a href='/servlet/StartLogin?node=" + node + "'>登录</a>");
                else
                    sb.append("您的积分不足，无权回贴！");
            } else
            {
                span = new Span("<include src=\"/jsp/type/bbs/EditBBSReply_celerity.jsp?node=" + node + "\"/>");
                sb.append(span);
            }
            sb.append(detail.getAfterItem("celerity"));
        }
        return sb.toString();
    }

    private void set_(String f,String v) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE BBS SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node); // + " AND language=" + language
        } finally
        {
            db.close();
        }
    }

    public void setLocking(boolean locking) throws SQLException
    {
        set_("locking",locking ? "1" : "0");
        this.locking = locking;
    }

    public void setParktop(boolean parktop) throws SQLException
    {
        set_("parktop",parktop ? "1" : "0");
        this.parktop = parktop;
    }

    public void setQuintessence(boolean quintessence) throws SQLException
    {
        set_("quintessence",quintessence ? "1" : "0");
        this.quintessence = quintessence;
    }

    public void setBest(int best) throws SQLException
    {
        set_("best",String.valueOf(best));
        this.best = best;
    }

    public void setVote(int vote) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE BBS SET vote=" + vote + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        this.vote = vote;
    }

    public void set(String replymember,Date replytime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE BBS SET replycount=" + (++replycount) + ",replymember=" + db.cite(replymember) + ",replytime=" + db.cite(replytime) + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        this.replymember = replymember;
        this.replytime = replytime;
    }

    //最后回复人
    public void setLast() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            replycount = db.getInt("SELECT COUNT(id) FROM BBSReply WHERE node=" + node + " AND hidden=0");
            if(replycount < 1)
            {
                Node n = Node.find(node);
                replymember = n.getCreator()._strR;
                replytime = n.getTime();
            } else
            {
                db.executeQuery("SELECT member,time FROM BBSReply WHERE node=" + node + " AND hidden=0 ORDER BY time DESC");
                if(db.next())
                {
                    replymember = db.getString(1);
                    replytime = db.getDate(2);
                }
            }
            db.executeUpdate("UPDATE BBS SET replycount=" + replycount + ",replymember=" + DbAdapter.cite(replymember) + ",replytime=" + DbAdapter.cite(replytime) + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
    }

    //修改查阅
    public void setSearch(int search) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE BBS SET search=" + search + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        this.search = search;

    }

    //修改查阅日期和查阅会员
    public void setSearch(String searchmember,Date searchtime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE BBS SET searchmember=" + DbAdapter.cite(searchmember) + ",searchtime=" + DbAdapter.cite(searchtime) + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        this.searchmember = searchmember;
        this.searchtime = searchtime;
    }

    public static String md5(String info) throws NoSuchAlgorithmException
    {
        java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
        md.update(info.getBytes());
        byte by[] = md.digest();
        StringBuilder dig = new StringBuilder();
        for(int index = 0;index < by.length;index++)
        {
            dig.append(by[index]);
        }
        return dig.toString();
    }

    public static boolean send(Http h,Profile profile) throws SQLException,NoSuchAlgorithmException,UnsupportedEncodingException
    {
        int language = h.language;
        String sn = h.request.getServerName();
        String MemberId = profile.getMember();
        String email = profile.getEmail();
        Community community = Community.find(h.community);
        String webn = community.getName(language);
        String dig = md5(MemberId + profile.getTime().getTime());
        String affirm = "http://" + sn + "/servlet/EditProfileBBS?community=" + community.community + "&member=" + java.net.URLEncoder.encode(MemberId,"UTF-8") + "&validate=" + dig + "&validate2=" + System.currentTimeMillis();
        String conent = community.getMailBefore(language) + "你好," + MemberId + "( " + email + " ): <BR><BR>" + "感谢您注册 <A href=http://" + sn + ">" + webn + "</A> 帐户。请按下面的说明操作，确认您注册了此帐户，如果您没有注册，请取消此帐户。<BR><BR><BR>" + "确认帐户<BR>" + "为了有助于防止未经授权的帐户创建，我们需要确认您的新帐户的电子邮件地址，这样还可以确保我们发送给您的重要信息能够到达您的帐户，此外，我们网站上的一些服务也可能需要经过确认的电子邮件地址 。<BR><BR>" + "若要确认此电子邮件地址，请选择并复制下列链接。打开浏览器窗口并将其粘贴到地址栏中，然后按键盘上的 Enter 或回车键，然后按照显示的指令操作。<BR><BR>" + "<A href=\"" + affirm + "&affirm=ON\">" + affirm + "&affirm=ON</A><BR><BR><BR>"
                        + "取消帐户<BR>" + "如果您没有将此电子邮件地址注册为帐户，并希望取消此帐户，请选择并复制下列链接。打开浏览器窗口并将其粘贴到地址栏中，然后按键盘上的 Enter 或回车键，然后按照显示的指令操作。<BR><BR>" + "<A href=\"" + affirm + "&cancel=ON\">" + affirm + "&cancel=ON</A><BR><BR><BR>" + "要点<BR>" + "为了有助于保证您个人信息的安全，" + webn + " 建议您永远不要单击未经请求的电子邮件中的链接，该链接可能会要求您输入您的凭据（电子邮件和密码），不要单击此类链接，而要将其复制并粘贴到网络浏览器的地址栏中。我们也可能会向您发送包含链接的电子邮件，该链接是为了便于您使用而提供的。" + community.getMailAfter(language);
        String subject = webn + ":确认您的电子邮件地址";
        try
        {
            tea.service.SendEmaily se = new tea.service.SendEmaily(community.community);
            se.sendEmail(email,subject,conent);
            return true;
        } catch(Exception _ex)
        {
            return false;
        }
    }
    /*
     * public ActionErrors validate(ActionMapping actionMapping, HttpServletRequest httpServletRequest) { // @todo: finish this method, this is just the skeleton. return null; }
     *
     * public void reset(ActionMapping actionMapping, HttpServletRequest servletRequest) { }
     */
}
