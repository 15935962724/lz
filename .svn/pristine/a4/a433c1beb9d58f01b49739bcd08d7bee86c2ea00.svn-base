package tea.entity.site;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.resource.*;

public class Community extends Entity
{
	public static final String HOME = "Home";
	public static final int COMMUNITYT_PRIVATE = 0;
	public static final int COMMUNITYT_PUBLIC = 1;
	public static final int COMMUNITYT_JOIN = 2;
	public static final String STATE_TYPE[] =
			{"------------","开发中","使用中","用于演示","为客户保留","未使用"};
	public int id;
	public String community;
	public int type;
	private Hashtable _htLayer;
	public static Cache _cache = new Cache(100);
	public String webName;
	public String email;
	public String smtp;
	public String smtpname;
	public String smtpuser;
	public String smtppassword;
	//
	public static final String[] SMS_SERVICE =
			{"禁用","触发短信"};
	public int smsserver; //接口类型
	public String smsuser; //短信用户名
	public String smspassword; //短信密码
	public String smssignature; //短信签名
	public boolean smsremind; //短信提醒
	public int smscount; //已发条数
	public String tjbaidu; //|用户|密码|令牌|
	//
	public String filtrate;
	public int node; //首页
	public int login; //前台登陆节点
	public int bglogin; //后台登陆节点
	public boolean subdomain; //会话类型: cookie or session
	public boolean lunique; //唯一登陆
	public String desktop;
	public int dynamicdesktop;
	public int messageboard;
	public boolean regMail;
	public boolean regmap;
	public boolean publicity;
	public Date starttime;
	public Date stoptime;
	public int state;
	public int media; //媒体名称的id
	public int subjectnode; //新闻标题是否去重节点号
	private boolean exists;
	//private int ismedia; //是否是媒体名称
	//private int issubscribe;//是否使用电子报
	//  private int isintegral;// 是否使用新闻积分
	public static final String[] ISCHECK_TYPE =
			{"--","媒体名称","电子报节点权限","新闻节点是否要扣分","昵称不能重复","访问统计","开通手机版"};
	public String ischeck = "/"; //判断社区是否使用
	public int verify; //验证码类型
	public Date time; //创建时间
	class Layer
	{
		public int language;
		public String _strName;
		public String _strTerm;
		public String _strWelcome;
		public String _strMailBefore;
		public String _strMailAfter;
		public String _strJspBefore;
		public String _strJspAfter;
		public String smallmap;
		public String keywords;
		public String synopsis;
		public String pause;
		public String communityemail; // 社区注册确认邮件
		public String locus; //地点的别名
		private String tips; // 投稿页面使用的投稿提示
		private String ruleshelp; //投稿要求规则说明
		Layer()
		{
		}
	}


	public void set(int type,int state,int language,String name,String term,String welcome,String webName,String email,String smtp,String smtpname,String smtpuser,
					String smtppassword,String css,String filtrate,boolean regMail,boolean regmap,boolean publicity,String mailbefore,String mailafter,String jspbefore,
					String jspafter,String smallmap,String keywords,String synopsis) throws SQLException
	{
		Community c = Community.find(community);
		c.type = type;
		c.state = state;
		c.webName = webName;
		c.email = email;
		c.smtp = smtp;
		c.smtpname = smtpname;
		c.smtpuser = smtpuser;
		c.smtppassword = smtppassword;
		c.filtrate = filtrate;
		c.regMail = regMail;
		c.regmap = regmap;
		c.publicity = publicity;
		c.set();
		c.setLayer(language,name,term,welcome,mailbefore,mailafter,jspbefore,jspafter,smallmap,keywords,synopsis);
		/*
		   StringBuilder sql = new StringBuilder();
		   sql.append("UPDATE CommunityLayer SET name=").append(DbAdapter.cite(name));
		   sql.append(",term=").append(DbAdapter.cite(term));
		   sql.append(",welcome=").append(DbAdapter.cite(welcome));
		   sql.append(",mailbefore=").append(DbAdapter.cite(mailbefore));
		   sql.append(",mailafter=").append(DbAdapter.cite(mailafter));
		   sql.append(",jspbefore=").append(DbAdapter.cite(jspbefore));
		   sql.append(",jspafter=").append(DbAdapter.cite(jspafter));
		   if(smallmap != null)
		   {
			sql.append(",smallmap=").append(DbAdapter.cite(smallmap));
		   }
		   sql.append(",keywords=").append(DbAdapter.cite(keywords));
		   sql.append(",synopsis=").append(DbAdapter.cite(synopsis));
		   sql.append(" WHERE community=").append(DbAdapter.cite(community));
		   sql.append(" AND language=").append(j);
		   DbAdapter db = new DbAdapter(1);
		   try
		   {
			db.executeUpdate(0,"UPDATE Community SET type=" + type + ",state=" + state + ",webname=" + DbAdapter.cite(webName) + ",email= " + DbAdapter.cite(email) + ",smtp =" + DbAdapter.cite(smtp) + ",smtpname=" + DbAdapter.cite(smtpname) + ",smtpuser =" + DbAdapter.cite(smtpuser) + " ,smtppassword =" + DbAdapter.cite(smtppassword) + ",regmail=" + (regMail ? "1" : "0") + ",regmap=" + (regmap ? "1" : "0") + ",publicity=" + (publicity ? "1" : "0") + ",filtrate=" + DbAdapter.cite(filtrate) + " WHERE community=" + DbAdapter.cite(community));
			int count = db.executeUpdate(0,sql.toString());
			if(count < 1)
			{
			 db.executeUpdate(0,"INSERT INTO CommunityLayer (community, language, name, term, welcome,mailbefore,mailafter,jspbefore,jspafter,smallmap,keywords,synopsis)  VALUES (" + DbAdapter.cite(community) + ", " + j + ", " + DbAdapter.cite(name) + ", " + DbAdapter.cite(term) + ", " + DbAdapter.cite(welcome) + "," + DbAdapter.cite(mailbefore) + "," + DbAdapter.cite(mailafter) + "," + DbAdapter.cite(jspbefore) + ","
				  + DbAdapter.cite(jspafter) + "," + DbAdapter.cite(smallmap) + "," + DbAdapter.cite(keywords) + "," + DbAdapter.cite(synopsis) + ")");
			}
		   } finally
		   {
			db.close();
		   }
		 */
		//  setCss(community,css);
		set(css,language,jspbefore,jspafter);
		this.state = state;
		this.type = type;
		this.webName = webName;
		this.email = email;
		this.smtp = smtp;
		this.smtpname = smtpname;
		this.smtpuser = smtpuser;
		this.smtppassword = smtppassword;
		this.regMail = regMail;
		this.regmap = regmap;
		this.publicity = publicity;
		this.filtrate = filtrate;
		_htLayer.clear();
	}

	public void set() throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			int j = db.executeUpdate(0,"UPDATE Community SET type=" + type + ",node=" + node + ",state=" + state + ",webname=" + DbAdapter.cite(webName) + ",email=" + DbAdapter.cite(email)
									 + ",smtp=" + DbAdapter.cite(smtp) + ",smtpname=" + DbAdapter.cite(smtpname) + ",smtpuser=" + DbAdapter.cite(smtpuser) + ",smtppassword=" + DbAdapter.cite(smtppassword)
									 + ",regmail=" + DbAdapter.cite(regMail) + ",regmap=" + DbAdapter.cite(regmap) + ",publicity=" + DbAdapter.cite(publicity) + ",starttime=" + DbAdapter.cite(starttime) + ",ischeck=" + DbAdapter.cite(ischeck) + ",filtrate=" + DbAdapter.cite(filtrate)
									 + ",smsserver=" + smsserver + ",smsuser=" + DbAdapter.cite(smsuser) + ",smspassword=" + DbAdapter.cite(smspassword) + ",smssignature=" + DbAdapter.cite(smssignature) + ",smsremind=" + DbAdapter.cite(smsremind) + ",smscount=" + smscount+ ",tjbaidu=" + DbAdapter.cite(tjbaidu)
									 + " WHERE community=" + DbAdapter.cite(community));
			if(j < 1)
				db.executeUpdate(0,"INSERT INTO Community(id,community,type,node,state,webname,email,smtp,smtpname,smtpuser,smtppassword,regmail,regmap,publicity,starttime,ischeck,filtrate,time)VALUES(" + (id = Seq.get()) + "," + DbAdapter.cite(community) + "," + type + "," + node + "," + state + "," + DbAdapter.cite(webName) + "," + DbAdapter.cite(email) + "," + DbAdapter.cite(smtp) + "," + DbAdapter.cite(smtpname) + " ," + DbAdapter.cite(smtpuser) + "," + DbAdapter.cite(smtppassword) + "," + (regMail ? "1" : "0") + "," + (regmap ? "1" : "0") + "," + (publicity ? "1" : "0") + "," + db.citeCurTime() + ",'/'" + "," + DbAdapter.cite(filtrate) + "," + DbAdapter.cite(new Date()) + ")");
		} finally
		{
			db.close();
		}
	}

	public void setLayer(int language,String name,String term,String welcome,String mailbefore,String mailafter,String jspbefore,String jspafter,String smallmap,String keywords,String synopsis) throws SQLException
	{
		StringBuilder sql = new StringBuilder();
		sql.append("UPDATE CommunityLayer SET name=" + DbAdapter.cite(name));
		sql.append(",term=" + DbAdapter.cite(term));
		sql.append(",welcome=" + DbAdapter.cite(welcome));
		sql.append(",mailbefore=" + DbAdapter.cite(mailbefore));
		sql.append(",mailafter=" + DbAdapter.cite(mailafter));
		sql.append(",jspbefore=" + DbAdapter.cite(jspbefore));
		sql.append(",jspafter=" + DbAdapter.cite(jspafter));
		if(smallmap != null)
		{
			sql.append(",smallmap=" + DbAdapter.cite(smallmap));
		}
		sql.append(",keywords=" + DbAdapter.cite(keywords));
		sql.append(",synopsis=" + DbAdapter.cite(synopsis));
		sql.append(" WHERE community=" + DbAdapter.cite(community) + " AND language=" + language);
		DbAdapter db = new DbAdapter();
		try
		{
			int j = db.executeUpdate(0,sql.toString());
			if(j < 1)
				db.executeUpdate(0,"INSERT INTO CommunityLayer(community,language,name,term,welcome, mailbefore,mailafter,jspbefore,jspafter,smallmap,keywords,synopsis)VALUES(" + DbAdapter.cite(community) + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(term) + "," + DbAdapter.cite(welcome) + "," + DbAdapter.cite(mailbefore) + "," + DbAdapter.cite(mailafter) + "," + DbAdapter.cite(jspbefore) + "," + DbAdapter.cite(jspafter) + "," + DbAdapter.cite(smallmap) + "," + DbAdapter.cite(keywords) + "," + DbAdapter.cite(synopsis) + ")");
		} finally
		{
			db.close();
		}
		_htLayer.clear();
	}

	private Community(String s) throws SQLException
	{
		community = s;
		load();
		_htLayer = new Hashtable();
	}

	public static int create(String community,int type,int state,String member,int language,String name,String term,String welcome,String webName,String email,String smtp,String smtpname,String smtpuser,String smtppassword,String css,String filtrate,boolean regMail,boolean regmap,boolean publicity,String mailbefore,String mailafter,String jspbefore,String jspafter,String smallmap,String keywords,String synopsis) throws SQLException
	{
		int node = Node.create(0,0,community,new RV(member),0,false,1325924416,0,1,null,null,new java.util.Date(),0,0,0,0,null,language,name,null,null,null,null,null,0,null,null,null,null,null,null,"");

		Community c = Community.find(community);
		c.type = type;
		c.state = state;
		c.webName = webName;
		c.email = email;
		c.smtp = smtp;
		c.smtpname = smtpname;
		c.smtpuser = smtpuser;
		c.smtppassword = smtppassword;
		c.filtrate = filtrate;
		c.regMail = regMail;
		c.regmap = regmap;
		c.publicity = publicity;
		c.set();
		c.setLayer(language,name,term,welcome,mailbefore,mailafter,jspbefore,jspafter,smallmap,keywords,synopsis);
		_cache.remove(community);
		// NodeAccessManage.create(community, "0.0.0.0"); // 访问统计管理
		// Communityinfo.create(community);
		// update();
		return node;
	}

	/*
	 * public static void update() { try { StringBuilder param = new StringBuilder("<?xml version=\"1.0\" encoding=\"UTF-8\"?>"); param.append("<ROOT>"); String path = new java.io.File(tea.entity.site.Community.class.getResource("/").toURI()).getParentFile().getParentFile().getName(); param.append(" <IP>").append(java.net.InetAddress.getLocalHost().getHostAddress()).append("-").append(path).append("</IP>"); java.util.Enumeration enumer = find(" AND regmap=1", 0, Integer.MAX_VALUE); while
	 * (enumer.hasMoreElements()) { String id = (String) enumer.nextElement(); Community obj = Community.find(id); String url = ""; java.util.Enumeration dns_enumer = DNS.findByCommunity(id); if (dns_enumer.hasMoreElements()) { url = "http://" + dns_enumer.nextElement(); } param.append(" <COMMUNITY>"); param.append(" <NAME>").append(obj.getName(1)).append("</NAME>"); param.append(" <URL>").append(url).append("</URL>"); param.append(" <MCOUNT>").append(Profile.countByCommunity(id)).append("</MCOUNT>");
	 * param.append(" <ONLINE>").append(OnlineList.countByCommunity(id)).append("</ONLINE>"); param.append(" <NCOUNT>").append(Community.countByCommunity(id)).append("</NCOUNT>"); param.append(" </COMMUNITY>"); } param.append("</ROOT>"); // map.redcome.com // System.out.println(param.toString()); java.net.HttpURLConnection conn = (java.net.HttpURLConnection) new java.net.URL("http://" + License.getInstance().getRootSite() + "/").openConnection(); conn.setConnectTimeout(10000);
	 * conn.setRequestMethod("POST"); conn.setDoOutput(true); // conn.setDoInput(true); java.io.PrintStream ps = new java.io.PrintStream(conn.getOutputStream()); ps.print("info=" + java.net.URLEncoder.encode(param.toString(), "UTF-8")); ps.close(); java.io.InputStream is = conn.getInputStream(); is.close(); } catch (IOException ioe) { } catch (Exception ex) { ex.printStackTrace(); } }
	 */
	public boolean isLayerExisted(int i) throws SQLException
	{
		boolean flag = false;
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeQuery("SELECT community  FROM CommunityLayer  WHERE community=" + DbAdapter.cite(community) + " AND language=" + i);
			flag = db.next();
		} finally
		{
			db.close();
		}
		return flag;
	}

	public void set(String css,int language,String jspbefore,String jspafter)
	{
		String prefix = "/res/" + community + "/cssjs/";
		try
		{
			String path = prefix + "community.css";
			ArrayList al = Attch.find(" AND path=" + DbAdapter.cite(path) + " AND type='css'",0,1);
			Attch a = al.size() < 1 ? new Attch(Seq.get()) : (Attch) al.get(0);
			a.node = 0;
			a.type = "css";
			a.path = path;
			Filex.write(Http.REAL_PATH + a.path,css);
			a.set();
			if(jspbefore != null)
			{
				jspbefore = "if(top.location==self.location){ document.write(\"" + jspbefore.trim().replaceAll("\"","\\\\\"").replaceAll("\r\n","\");\r\ndocument.write(\"") + "\"); }";
				Filex.write(Http.REAL_PATH + prefix + "JspBefore_" + language + ".js",jspbefore);
			}
			if(jspafter != null)
			{
				jspafter = "if(top.location==self.location){ document.write(\"" + jspafter.trim().replaceAll("\"","\\\\\"").replaceAll("\r\n","\");\r\ndocument.write(\"") + "\"); }";
				Filex.write(Http.REAL_PATH + prefix + "JspAfter_" + language + ".js",jspafter);
			}
		} catch(Throwable ex)
		{
			ex.printStackTrace();
		}
	}

	public int getNode()
	{
		return node;
	}

	public String getTerm(int i) throws SQLException
	{
		return getLayer(i)._strTerm;
	}

	public String getWelcome(int i) throws SQLException
	{
		return getLayer(i)._strWelcome;
	}

	public String getMailBefore(int i) throws SQLException
	{
		return getLayer(i)._strMailBefore;
	}

	public String getMailAfter(int i) throws SQLException
	{
		return getLayer(i)._strMailAfter;
	}


	public String getJspBefore(int i) throws SQLException
	{
		return getLayer(i)._strJspBefore;
	}

	public String getJspBeforePath(int i) throws SQLException
	{
		return "/res/" + community + "/cssjs/JspBefore_" + getLayer(i).language + ".js";
	}

	public String getJspAfter(int i) throws SQLException
	{
		return getLayer(i)._strJspAfter;
	}

	public String getJspAfterPath(int i) throws SQLException
	{
		return "/res/" + community + "/cssjs/JspAfter_" + getLayer(i).language + ".js";
	}

	public String getSmallMap(int i) throws SQLException
	{
		return getLayer(i).smallmap;
	}

	public String getKeywords(int i) throws SQLException
	{
		return getLayer(i).keywords;
	}

	public String getSynopsis(int i) throws SQLException
	{
		return getLayer(i).synopsis;
	}

	private void load() throws SQLException
	{
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeQuery("SELECT id,type,node,state,webname,email,smtp,smtpname,smtpuser,smtppassword"
							+ ",smsserver,smsuser,smspassword,smssignature,smsremind,smscount,tjbaidu"
							+ ",filtrate,login,bglogin,subdomain,lunique,desktop"
							+ ",dynamicdesktop,messageboard,regmail,regmap,publicity,starttime,stoptime,ischeck,media,verify,subjectnode,time FROM Community WHERE community=" + DbAdapter.cite(community));
			if(db.next())
			{
				int j = 1;
				id = db.getInt(j++);
				type = db.getInt(j++);
				node = db.getInt(j++);
				state = db.getInt(j++);
				webName = db.getString(j++);
				email = db.getString(j++);
				smtp = db.getString(j++);
				smtpname = db.getString(j++);
				smtpuser = db.getString(j++);
				smtppassword = db.getString(j++);
				//
				smsserver = db.getInt(j++);
				smsuser = db.getString(j++);
				smspassword = db.getString(j++);
				smssignature = db.getString(j++);
				smsremind = db.getInt(j++) != 0;
				smscount = db.getInt(j++);
				tjbaidu = db.getString(j++);
				//
				filtrate = db.getString(j++);
				login = db.getInt(j++);
				bglogin = db.getInt(j++);
				subdomain = db.getInt(j++) != 0;
				lunique = db.getInt(j++) != 0;
				desktop = db.getString(j++);
				dynamicdesktop = db.getInt(j++);
				messageboard = db.getInt(j++);
				regMail = db.getInt(j++) != 0;
				regmap = db.getInt(j++) != 0;
				publicity = db.getInt(j++) != 0;
				starttime = db.getDate(j++);
				stoptime = db.getDate(j++);
				ischeck = db.getString(j++);
				media = db.getInt(j++);
				verify = db.getInt(j++);
				subjectnode = db.getInt(j++);
				time = db.getDate(j++);
				exists = true;
			} else
			{
				filtrate = "法轮功,李洪志";
				exists = false;
			}
		} finally
		{
			db.close();
		}
		if(smtp == null || smtp.indexOf(".") == -1)
		{
			smtp = "smtp.exmail.qq.com";
		}
		if(smtpname == null || smtpname.length() < 1)
		{
			smtpname = "怡康科技/EDN-Redcome.com";
		}
		if(smtpuser == null || smtpuser.indexOf("@") == -1)
		{
			smtpuser = "robot@redcome.com";
			smtppassword = "abcd1234";
		}
		if(ischeck == null)
			ischeck = "/";
	}

	public int getType()
	{
		return type;
	}

	public String getCss() throws SQLException,IOException
	{
		return Filex.read(Common.REAL_PATH + "/res/" + community + "/cssjs/community.css","UTF-8");
	}

	public String getName(int i) throws SQLException
	{
		return getLayer(i)._strName;
	}

	private Layer getLayer(int i) throws SQLException
	{
		Layer layer = (Layer) _htLayer.get(new Integer(i));
		if(layer == null)
		{
			layer = new Layer();
			layer.language = this.getLanguage(i);
			DbAdapter db = new DbAdapter(1);
			try
			{
				db.executeQuery("SELECT name,term,welcome,mailbefore,mailafter,jspbefore,jspafter,smallmap,keywords,synopsis,pause,communityemail,locus,tips,ruleshelp FROM CommunityLayer WHERE community=" + DbAdapter.cite(community) + " AND language=" + layer.language);
				if(db.next())
				{
					int j = 1;
					layer._strName = db.getVarchar(layer.language,i,j++);
					layer._strTerm = db.getText(layer.language,i,j++);
					layer._strWelcome = db.getText(layer.language,i,j++);
					layer._strMailBefore = db.getText(layer.language,i,j++);
					layer._strMailAfter = db.getText(layer.language,i,j++);
					layer._strJspBefore = db.getText(layer.language,i,j++);
					layer._strJspAfter = db.getText(layer.language,i,j++);
					layer.smallmap = db.getVarchar(layer.language,i,j++);
					layer.keywords = db.getVarchar(layer.language,i,j++);
					layer.synopsis = db.getVarchar(layer.language,i,j++);
					layer.pause = db.getText(layer.language,i,j++);
					layer.communityemail = db.getVarchar(layer.language,i,j++);
					layer.locus = db.getVarchar(layer.language,i,j++);
					layer.tips = db.getVarchar(layer.language,i,j++);
					layer.ruleshelp = db.getVarchar(layer.language,i,j++);
				} else
				{
					layer._strTerm = "您必须接受以下所有协议，才能申请成为我们的注册用户： <br>\r\n<div align=left>\r\n<br>\r\n1．本网站管理提供的服务将完全按其发布的会员服务内容以及双方所签署协议的约定，服务条款和操作规则严格执行。用户必须完全同意所有服务条款并完成注册程序，才能成为本网站管理的正式用户。<br>\r\n2．服务简介本网站管理运用自己的操作系统通过国际互联网提供网络服务。同时，用户必须：<br>\r\n  （1）自行配备上网的所需设备，包括个人电脑、调制解调器或其他上网装置。<br>\r\n  （2）自行负担上网所支付的与此服务有关的电话费用，网络费用等。<br>\r\n3．基于本网站管理所提供的网络服务的重要性，用户应同意：<br>\r\n  （1）对注册过程中的各项问题，提供真实、准确的回答；<br>\r\n  （2）不断更新资料，符合及时、详尽、准确的要求。本网站管理不公开用户的姓名、地址、电子邮件箱和笔名，除以下情况外：<br>\r\n  A．用户授权本网站管理公开这些信息。<br>\r\n  B．相应的法律程序要求本网站管理提供用户的个人资料。<br>\r\n4．用户在本网站管理上发布信息应遵循国家在网络安全方面制定的法律法规及管理条例，由此引发的一切后果将由用户自行承担。<br>\r\n5. 如果用户提供资料包含不正确的信息，本网站管理保留结束用户使用本公司所提供的网络服务资格权利。</div>";
				}
			} finally
			{
				db.close();
			}
			_htLayer.put(new Integer(i),layer);
		}
		return layer;
	}

	private int getLanguage(int language) throws SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeQuery("SELECT language FROM CommunityLayer WHERE community=" + DbAdapter.cite(community));
			while(db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		if(v.indexOf(new Integer(language)) != -1)
		{
			return language;
		} else
		{
			if(language == 1)
			{
				if(v.indexOf(new Integer(2)) != -1)
				{
					return 2;
				}
			} else if(language == 2)
			{
				if(v.indexOf(new Integer(1)) != -1)
				{
					return 1;
				}
			}
			if(v.size() < 1)
			{
				return 0;
			}
		}
		return((Integer) v.elementAt(0)).intValue();
	}

	public void delete(int i) throws SQLException
	{
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeUpdate("DELETE FROM CommunityLayer WHERE community=" + DbAdapter.cite(community) + "  AND language=" + i);
			db.executeQuery("SELECT community FROM CommunityLayer WHERE community=" + DbAdapter.cite(community));
			if(!db.next())
			{
				db.executeUpdate("DELETE FROM Community WHERE community=" + DbAdapter.cite(community));
				NodeAccessManage.deleteByCommunity(community);
				// Communityinfo.find(community).delete();
			}
		} finally
		{
			db.close();
		}
		_cache.remove(community);
		// update();
	}

	public static Community find(String name) throws SQLException
	{
		Community obj = (Community) _cache.get(name);
		if(obj == null)
		{
			obj = new Community(name);
			_cache.put(name,obj);
		}
		return obj;
	}

    public static Community find(int id) throws SQLException
    {
        String community = null;
        DbAdapter db = new DbAdapter(1);
        try
        {
            db.executeQuery("SELECT community FROM Community WHERE id=" + id);
            if(db.next())
            {
                community = db.getString(1);
            }
        } finally
        {
            db.close();
        }
        return find(community);
    }

	public static ArrayList find(String sql,int pos,int size) throws SQLException
	{
		ArrayList al = new ArrayList();
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeQuery("SELECT community FROM Community WHERE 1=1" + sql,pos,size);
			while(db.next())
			{
				al.add(Community.find(db.getString(1)));
			}
		} finally
		{
			db.close();
		}
		return al;
	}

	public static int count(String sql) throws SQLException
	{
		DbAdapter db = new DbAdapter(1);
		try
		{
			return db.getInt("SELECT COUNT(*) FROM Community WHERE 1=1" + sql);
		} finally
		{
			db.close();
		}
	}

	public static int countByCommunity(String community) throws SQLException
	{
		DbAdapter db = new DbAdapter(1);
		try
		{
			return db.getInt("SELECT COUNT(node)  FROM Node WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
	}

	public void setWebName(String webName)
	{
		this.webName = webName;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}


	private void setPause(int language,String pause) throws SQLException
	{
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeUpdate("UPDATE CommunityLayer SET pause=" + DbAdapter.cite(pause) + " WHERE community=" + DbAdapter.cite(community) + " AND language=" + language);
		} finally
		{
			db.close();
		}
		_htLayer.clear();
	}

	public void setStopTime(Date stoptime) throws SQLException
	{
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeUpdate("UPDATE Community SET stoptime=" + DbAdapter.cite(stoptime) + " WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
		this.stoptime = stoptime;
	}

	// public void setSynopsis(String synopsis)
	// //{
	// this.synopsis = synopsis;
	// }
	public void setSmtp(String smtp)
	{
		this.smtp = smtp;
	}

	public void setOther(int login,int bglogin,boolean subdomain,boolean lunique,String desktop,int dynamicdesktop,int messageboard) throws SQLException
	{
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeUpdate(0,"UPDATE Community SET login=" + login + ",bglogin=" + bglogin + ",subdomain=" + DbAdapter.cite(subdomain) + ",lunique=" + DbAdapter.cite(lunique) + ",desktop=" + DbAdapter.cite(desktop) + ",dynamicdesktop=" + dynamicdesktop + ",messageboard=" + messageboard + " WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
		this.login = login;
		this.bglogin = bglogin;
		this.subdomain = subdomain;
		this.lunique = lunique;
		this.desktop = desktop;
		this.dynamicdesktop = dynamicdesktop;
		this.messageboard = messageboard;
	}

	//计算当前时间的前后天数
	public static String getYear(int year,String operator) throws SQLException
	{
		java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy"); //yyyy-MM-dd
		Date times = new Date();
		String y = sf.format(times);
		GregorianCalendar gc = new GregorianCalendar();
		gc.setTime(times);
		if("+".equals(operator))
		{
			gc.add(1, +year);
		}
		if("-".equals(operator))
		{
			gc.add(1, -year);
		}
		gc.set(gc.get(Calendar.YEAR),gc.get(Calendar.MONTH),gc.get(Calendar.DATE));
		y = sf.format(gc.getTime());
		return y;
	}

//添加是否为媒体
	private void setIscheck(String ischeck) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Community SET ischeck=" + db.cite(ischeck) + " WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
		this.ischeck = ischeck;
	}

	//新闻标题去重 的节点号
	private void setSubjectnode(int subjectnode) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE Community SET subjectnode=" + subjectnode + " WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
		this.subjectnode = subjectnode;

	}

	public void set(String field,String value) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(0,"UPDATE Community SET " + field + "=" + DbAdapter.cite(value) + " WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
	}

	public void setLayer(int language,String field,String value) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate(0,"UPDATE CommunityLayer SET " + field + "=" + DbAdapter.cite(value) + " WHERE community=" + DbAdapter.cite(community) + " AND language=" + language);
		} finally
		{
			db.close();
		}
		_htLayer.clear();
	}

	//修改媒体默认名称id
	private void setMedia(int media) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{

			db.executeUpdate("UPDATE Community SET media=" + media + " WHERE community=" + DbAdapter.cite(community));
		} finally
		{
			db.close();
		}
		this.media = media;
	}

	private void setCommunityemail(String communityemail,int language) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE CommunityLayer SET communityemail=" + db.cite(communityemail) + " WHERE community=" + DbAdapter.cite(community) + " AND language=" + language);
		} finally
		{
			db.close();
		}
		_htLayer.clear();
	}

	//修改投稿提示
	private void setTips(String tips,int language) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE CommunityLayer SET tips=" + db.cite(tips) + " WHERE community=" + DbAdapter.cite(community) + " and language= " + language);
		} finally
		{
			db.close();
		}
		_htLayer.clear();
	}

	//修改投稿要求规则说明
	private void setRuleshelp(String ruleshelp,int language) throws SQLException
	{

		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE CommunityLayer SET ruleshelp=" + db.cite(ruleshelp) + " WHERE community=" + DbAdapter.cite(community) + " and language= " + language);
		} finally
		{
			db.close();
		}
		_htLayer.clear();
	}

	private void setLocus(String locus,int language) throws SQLException
	{
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("UPDATE CommunityLayer SET locus=" + db.cite(locus) + " WHERE community=" + DbAdapter.cite(community) + " AND language=" + language);
		} finally
		{
			db.close();
		}
		_htLayer.clear();
	}

	public void setSmtpUser(String smtpuser)
	{
		this.smtpuser = smtpuser;
	}

	public void setSmtpPassword(String smtppassword)
	{
		this.smtppassword = smtppassword;
	}

	public String getWebName()
	{
		return webName;
	}

	public Date getStartTime()
	{
		return starttime;
	}

	public String getStartTimeToString()
	{
		if(starttime == null)
		{
			return "";
		}
		return Community.sdf.format(starttime);
	}

	public Date getStopTime()
	{
		return stoptime;
	}

	public String getStopTimeToString()
	{
		if(stoptime == null)
		{
			return "";
		}
		return Community.sdf.format(stoptime);
	}

	public String getEmail()
	{
		return email;
	}

	public String getSmtp()
	{
		return smtp;
	}

	public int getLogin()
	{
		return login;
	}

	public int getBgLogin()
	{
		return bglogin;
	}

	public boolean isSession()
	{
		return subdomain;
	}

	public boolean isLUnique()
	{
		return lunique;
	}

	public String getDesktop()
	{
		return desktop;
	}

	public int getDynamicdesktop()
	{
		return dynamicdesktop;
	}

	public int getMessageboard()
	{
		return messageboard;
	}

	public int getState()
	{
		return state;
	}

	public boolean isRegMail()
	{
		return regMail;
	}

	public boolean isRegmap()
	{
		return regmap;
	}

	public String getSmtpName()
	{
		return smtpname;
	}

	public void setSmtpName(String smtpName)
	{
		this.smtpname = smtpName;
	}


	public String getPause(int language) throws SQLException
	{
		return getLayer(language).pause;
	}

	public String getCommunityemail(int language) throws SQLException
	{
		return getLayer(language).communityemail;
	}

	public String getTips(int language) throws SQLException
	{
		return getLayer(language).tips;
	}

	public String getRuleshelp(int language) throws SQLException
	{
		return getLayer(language).ruleshelp;
	}

	public String getLocus(int language) throws SQLException
	{
		return getLayer(language).locus;
	}

	public String getSmtpUser()
	{
		return smtpuser;
	}

	public String getSmtpPassword()
	{
		return smtppassword;
	}

	public boolean isPublicity()
	{
		return publicity;
	}

	public boolean isExists()
	{
		return exists;
	}

	public String getIscheck()
	{
		return ischeck;
	}

	public int getMedia()
	{
		return media;
	}

	public int getSubjectnode()
	{
		return subjectnode;
	}

	//
	public static String options(String value) throws SQLException
	{
		StringBuilder htm = new StringBuilder();
		DbAdapter db = new DbAdapter(1);
		try
		{
			db.executeQuery("SELECT community FROM Community");
			while(db.next())
			{
				String val = db.getString(1);
				htm.append("<option value='" + val + "'");
				if(val.equals(value))
					htm.append(" selected");
				htm.append(">" + val);
			}
		} finally
		{
			db.close();
		}
		return htm.toString();
	}
}
