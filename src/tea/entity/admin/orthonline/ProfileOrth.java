package tea.entity.admin.orthonline;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.member.Profile;
import tea.entity.site.Community;
import tea.resource.Resource;
import tea.ui.TeaSession;

public class ProfileOrth extends Entity
{

    private String member; //主键用户id

    private int jishuzhicheng1; //技术职称 1
    private int jishuzhicheng2; //技术职称 2
    private int jishuzhicheng3; //技术职称 3
    private int xingzhengzhicheng; //现任行政职务1
    private int xingzhengzhicheng2; //现任行政职务2

    private int zhuanyefangxiang1; //专业方向 第一专业
    private int zhuanyefangxiang2; //专业方向  第二专业
    private int zhuanyefangxiang3; //专业方向 第三专业

    private String zhiye;
    private String fzcp;
    private int point;
    private int doctorid; //doctor 表中对应的id
    public ProfileOrth(String  member) throws SQLException
    {
        this.member = member;
        load();
    }

    public static ProfileOrth find(String  member) throws SQLException
    {
        return new ProfileOrth(member);
    }



    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
	            db.executeQuery("SELECT member, jishuzhicheng1, jishuzhicheng2,jishuzhicheng3," +
	            		"xingzhengzhicheng,xingzhengzhicheng2,zhuanyefangxiang1, zhuanyefangxiang2," +
	            		"zhuanyefangxiang3,fzcp,point,doctorid,zhiye FROM ProfileOrth WHERE member =" + DbAdapter.cite(member));
            if(db.next())
            {
                 member=db.getString(1);
                 jishuzhicheng1 = db.getInt(2);
                 jishuzhicheng2=db.getInt(3);
				 jishuzhicheng3=db.getInt(4);
                 xingzhengzhicheng = db.getInt(5);
                 xingzhengzhicheng2=db.getInt(6);
                 zhuanyefangxiang1 = db.getInt(7);
                 zhuanyefangxiang2 = db.getInt(8);
                 zhuanyefangxiang3 = db.getInt(9);
                 fzcp=db.getString(10);
                 doctorid=db.getInt(12);
                 zhiye=db.getString(13);
             }else
             {
            	 member="";
             }
        } finally
        {
            db.close();
        }
    }

    public static int create( String member , int jishuzhicheng1,  int jishuzhicheng2,
    		int jishuzhicheng3,  int xingzhengzhicheng,  int xingzhengzhicheng2,
    		int zhuanyefangxiang1,   int zhuanyefangxiang2,   int zhuanyefangxiang3,
    		String fzcp,String zhiye, int point,  int doctorid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        //Date times = new Date();
		int i = 0;
        try
        {
            db.executeUpdate("INSERT INTO ProfileOrth ( member ,jishuzhicheng1, jishuzhicheng2, " +
            		"jishuzhicheng3, xingzhengzhicheng, xingzhengzhicheng2,zhuanyefangxiang1," +
            		"zhuanyefangxiang2,zhuanyefangxiang3, fzcp,zhiye, point, doctorid) " +
                   "VALUES (" + DbAdapter.cite(member) + "," + jishuzhicheng1 + "," + jishuzhicheng2 + ","
                   + jishuzhicheng3 + "," + xingzhengzhicheng + "," + xingzhengzhicheng2 + "," + zhuanyefangxiang1 + "," +
                + zhuanyefangxiang2 + "," + zhuanyefangxiang3 + "," +
                   DbAdapter.cite(fzcp) +  "," +
                   DbAdapter.cite(zhiye) +"," + point+ ","+doctorid+ ")");

			  i = db.getInt("SELECT MAX(doctorid) FROM ProfileOrth");
        } finally
        {
           db.close();
        }
		return i;
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
    public static boolean send(TeaSession teasession,Profile profile) throws SQLException,NoSuchAlgorithmException,UnsupportedEncodingException
    {
        int language = teasession._nLanguage;
        Resource r = new Resource("/tea/resource/Photography");
        //String sn = teasession.getRequest().getServerName();
        String sn=teasession.getRequest().getRequestURL().toString();
        sn=sn.substring(0,sn.indexOf("/",9));
        String MemberId = profile.getMember();
        String email = profile.getEmail();
        if(profile.getEmail()!=null && profile.getEmail().length()>0)
        {}else
        {
        	email = MemberId;
        }
        System.out.println(email);
        Community community = Community.find(teasession._strCommunity);
        String webn = community.getName(language);
        String dig = md5(MemberId + profile.getTime().getTime());

        String affirm = sn + "/jsp/user/ValidateProfile.jsp?community=" + community.community + "&membertype="+teasession.getParameter("membertype")+"&member=" + java.net.URLEncoder.encode(MemberId,"UTF-8") + "&validate=" + dig + "&validate2=" + System.currentTimeMillis();

        String communityemail = "你好,"+MemberId+"( "+email+" ): <BR><BR>" + "感谢您注册 <A href="+sn+">"+webn+"</A> 帐户。请按下面的说明操作，确认您注册了此帐户，如果您没有注册，请取消此帐户。<BR><BR><BR>" + "确认帐户<BR>" + "为了有助于防止未经授权的帐户创建，我们需要确认您的新帐户的电子邮件地址，这样还可以确保我们发送给您的重要信息能够到达您的帐户，此外，我们网站上的一些服务也可能需要经过确认的电子邮件地址 。<BR><BR>" + "若要确认此电子邮件地址，请选择并复制下列链接。打开浏览器窗口并将其粘贴到地址栏中，然后按键盘上的 Enter 或回车键，然后按照显示的指令操作。<BR><BR>" + "<A href=\""+affirm+"&affirm=ON\">"+affirm+"&affirm=ON</A><BR><BR><BR>"
        + "取消帐户<BR>" + "如果您没有将此电子邮件地址注册为帐户，并希望取消此帐户，请选择并复制下列链接。打开浏览器窗口并将其粘贴到地址栏中，然后按键盘上的 Enter 或回车键，然后按照显示的指令操作。<BR><BR>" + "<A href=\""+affirm+"&cancel=ON\">"+affirm+"&cancel=ON</A><BR><BR><BR>" + "要点<BR>" + "为了有助于保证您个人信息的安全，"+webn+" 建议您永远不要单击未经请求的电子邮件中的链接，该链接可能会要求您输入您的凭据（电子邮件和密码），不要单击此类链接，而要将其复制并粘贴到网络浏览器的地址栏中。我们也可能会向您发送包含链接的电子邮件，该链接是为了便于您使用而提供的。";

        if(community.getCommunityemail(teasession._nLanguage)!=null && community.getCommunityemail(teasession._nLanguage).length()>0)
        {
        	communityemail = community.getCommunityemail(teasession._nLanguage);

        	communityemail = communityemail.replaceAll("MemberId",MemberId);
        	communityemail = communityemail.replaceAll("email",email);

        	communityemail = communityemail.replaceAll("sn",sn);
        	communityemail = communityemail.replaceAll("webn",webn);
        	communityemail = communityemail.replaceAll("affirm_d",affirm);
        }

       // System.out.println(communityemail);

        String conent = community.getMailBefore(language) + communityemail + community.getMailAfter(language);

       // System.out.println(conent);

        String subject = webn + ":"+r.getString(teasession._nLanguage,"4822434848");

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
    public static void set(String member , int jishuzhicheng1,  int jishuzhicheng2,
    		int jishuzhicheng3,  int xingzhengzhicheng,  int xingzhengzhicheng2,
    		int zhuanyefangxiang1,   int zhuanyefangxiang2,   int zhuanyefangxiang3,
    		String fzcp, String zhiye,   int doctorid) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE ProfileOrth SET jishuzhicheng1=" + jishuzhicheng1 +
            		",jishuzhicheng2=" + jishuzhicheng2 +
            		" ,jishuzhicheng3=" + jishuzhicheng3+
            		 ", xingzhengzhicheng=" + xingzhengzhicheng+
            		 " ,xingzhengzhicheng2=" + xingzhengzhicheng2+
            		 ", zhuanyefangxiang1=" + zhuanyefangxiang1+
            		 " ,zhuanyefangxiang2=" + zhuanyefangxiang2+
            		 ", zhuanyefangxiang3=" + zhuanyefangxiang3+
            		 ",doctorid=" + doctorid+
            		 " ,fzcp=" + DbAdapter.cite(fzcp)+
            		 " ,zhiye=" + DbAdapter.cite(zhiye)+
            		 " WHERE member = " + DbAdapter.cite(member));
        } finally
        {
            db.close();
        }
    }


	public static boolean isExist(String member) throws SQLException
    {
        boolean flag = false;
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT * from ProfileOrth  WHERE member=");
        sb.append(DbAdapter.cite(member));

        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery(sb.toString());
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }




    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM  ProfileOrth WHERE doctorid = " + doctorid);

        } finally
        {
            db.close();
        }
    }

    public static int count(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(doctorid) FROM ProfileOrth  WHERE community=" + db.cite(community) + sql);
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

    public String getMember()
	{
		return member;
	}

	public void setMember(String member)
	{
		this.member = member;
	}

	public int getJishuzhicheng1()
	{
		return jishuzhicheng1;
	}

	public void setJishuzhicheng1(int jishuzhicheng1)
	{
		this.jishuzhicheng1 = jishuzhicheng1;
	}

	public int getJishuzhicheng2()
	{
		return jishuzhicheng2;
	}

	public void setJishuzhicheng2(int jishuzhicheng2)
	{
		this.jishuzhicheng2 = jishuzhicheng2;
	}

	public int getJishuzhicheng3()
	{
		return jishuzhicheng3;
	}

	public void setJishuzhicheng3(int jishuzhicheng3)
	{
		this.jishuzhicheng3 = jishuzhicheng3;
	}

	public int getXingzhengzhicheng()
	{
		return xingzhengzhicheng;
	}

	public void setXingzhengzhicheng(int xingzhengzhicheng)
	{
		this.xingzhengzhicheng = xingzhengzhicheng;
	}

	public int getXingzhengzhicheng2()
	{
		return xingzhengzhicheng2;
	}

	public void setXingzhengzhicheng2(int xingzhengzhicheng2)
	{
		this.xingzhengzhicheng2 = xingzhengzhicheng2;
	}

	public int getZhuanyefangxiang1()
	{
		return zhuanyefangxiang1;
	}

	public void setZhuanyefangxiang1(int zhuanyefangxiang1)
	{
		this.zhuanyefangxiang1 = zhuanyefangxiang1;
	}

	public int getZhuanyefangxiang2()
	{
		return zhuanyefangxiang2;
	}

	public void setZhuanyefangxiang2(int zhuanyefangxiang2)
	{
		this.zhuanyefangxiang2 = zhuanyefangxiang2;
	}

	public int getZhuanyefangxiang3()
	{
		return zhuanyefangxiang3;
	}

	public void setZhuanyefangxiang3(int zhuanyefangxiang3)
	{
		this.zhuanyefangxiang3 = zhuanyefangxiang3;
	}

	public String getFzcp()
	{
		return fzcp;
	}

	public void setFzcp(String fzcp)
	{
		this.fzcp = fzcp;
	}

	public int getPoint()
	{
		return point;
	}

	public void setPoint(int point)
	{
		this.point = point;
	}

	public int getDoctorid()
	{
		return doctorid;
	}

	public void setDoctorid(int doctorid)
	{
		this.doctorid = doctorid;
	}

	public String getZhiye()
	{
		return zhiye.trim();
	}

	public void setZhiye(String zhiye)
	{
		this.zhiye = zhiye;
	}
}
