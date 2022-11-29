package tea.ui.node.type.lvyou;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.StringTokenizer;

import tea.db.DbAdapter;
import tea.entity.member.Logs;
import tea.entity.member.Profile;
import tea.entity.member.ProfileBBS;
import tea.entity.member.SMSMessage;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.*;
import tea.entity.node.BBS;
import tea.entity.node.Category;
import tea.entity.node.Node;
import tea.entity.node.Score;
import tea.entity.weibo.WAccount;
import tea.entity.weibo.WConfig;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.bbs.BBSForum;
import tea.entity.bbs.BBSPoint;
import tea.entity.lvyou.*;

//http://127.0.0.1:8080/servlet/GolfSynchronous?type=golfScore&xmlpassword=123456&xmlcontent=111
public class LvyouSynchronous extends TeaServlet {
	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		java.io.PrintWriter out = response.getWriter();
		TeaSession teasession = new TeaSession(request);
		try {
			String xmlpassword = teasession.getParameter("xmlpassword");
		//	out.print("xmlpassword:"+xmlpassword);
		    if (!"123456".equals(xmlpassword)) {
				out.print("false您的密码不正确，请确认密码!");
				return;
			}
			String xmlcontent = teasession.getParameter("xmlcontent");
			if (xmlcontent == null || xmlcontent.length() < 1) {
				out.print("false无效内容!");
				return;
			}

			 Http h = new Http(request,response);
			// xmlcontent = new
			// String(xmlcontent.getBytes("ISO-8859-1"),"utf-8");
			System.out.println(xmlcontent);
			String xmltype = teasession.getParameter("xmltype");
			System.out.println("====" + xmltype + "=========================");

			if ("reg".equals(xmltype)) // 注册
			{
				xmlcontent = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
						+ xmlcontent;
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String name = (String) ht.get("nm");
				String password = (String) ht.get("ps");
				String sex = (String) ht.get("sx");
				// out.println("sex"+sex);
				String mobile = (String) ht.get("mb");
				if (Profile.isExisted(id)) {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>false</rs>");
					out.print("<re>userexist</re></r>");
				} else if (mobileexists(mobile)) {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>false</rs>");
					out.print("<re>mobileexist</re><mb>0</mb></r>");
				} else {
					Profile p = Profile.create(id, password, "westrac", null,
							request.getServerName());
					p.setSex(sex.equals("1"));
					p.setFirstName(name, 1);
					p.setMobile(mobile);
					//p.setType(10);
					java.text.DecimalFormat df = new java.text.DecimalFormat("000000");
				//	 SeqTable seq = new SeqTable();

		                String code = df.format(SeqTable.getSeqNo("westrac"));
		                p.setCode(code);
		                p.setWST(id,h.getInt("sfshanggang"),h.get("fazhengjiguan"),h.get("caozuonianxian"),
	                            h.getInt("xpinpai"),h.getInt("xxinghao"),h.get("xqita"),h.getInt("cpinpai"),h.getInt("cxinghao"),
	                            h.get("cqita"),h.get("jzname"),h.get("jzxinghao"),h.get("jzxuliehao"),h.get("jzlianxi"),h.get("aihao"),
	                            h.getInt("wsttype"),h.get("wstmodel","|").substring(1).replace('|',','));
                    p.setMembertype(1);
                    p.setVerifgmember("mobile");
                    p.setMyintegral((float)30.0);
                    p.setVerifgtime(new Date());
                    p.setType(0);

                    ProfileBBS.create("westrac",id);

                  //  p.setDegree(0);
					ProfileLvyou pl = new ProfileLvyou();

					pl.set(id, "", "", "", "");
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>true</rs>");
					out.print("<re></re><mb>"+p.getProfile()+"</mb></r>");

				}

			} else if ("login".equals(xmltype)) // 登录验证
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {
					Profile p=Profile.find(id);
				    RV rv = new RV(id);
					Logs.create("westrac", rv, 99, 0, "履友客户端手机登录");
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>true</rs><mb>"+p.getProfile()+"</mb></r>");
				} else {


					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>false</rs><mb>0</mb></r>");
				}

			}else if ("findpassword".equals(xmltype)) // 登录验证
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				System.out.println(id);
				Profile p=Profile.find(id);
				System.out.println(p.getMobile());
				if (p.getMobile()!=null&&p.getMobile().trim().length()==11) {
					String mobile=p.getMobile();
SMSMessage.create("westrac",mobile,mobile,1,"履友提醒您：您的手机密码是“" + p.getPassword() + "”【履友客户端】");

					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>true</rs></r>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>false</rs><mb>0</mb></r>");
				}

			} else if ("downloadbysms".equals(xmltype)) // 登录验证
			{
				HashMap ht = MT.xml(xmlcontent);
				String mobile = (String) ht.get("mobile");

				if (mobile.length()==11) {



					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>true</rs></r>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>false</rs><mb>0</mb></r>");
				}

			}
			else if ("uplocation".equals(xmltype)) // 上传位置
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {
					String latitude = (String) ht.get("la");
					String longitude = (String) ht.get("lo");
					ProfileLvyou.set(id, longitude, latitude);

					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>true</rs>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}

			}

			else if ("changepassword".equals(xmltype)) // 登录验证
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				String newpassword = (String) ht.get("nps");
				if (Profile.isExist(id, password)) {
					Profile p = Profile.find(id);
					p.setPassword(newpassword);

					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>true</rs>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}

			} else if ("uphardware".equals(xmltype)) // 上传硬件信息
			{
				HashMap ht = MT.xml(xmlcontent);
				String info = (String) ht.get("in");
				//System.out.println(info);
				 RV rv = new RV("webmaster");
				Logs.create("westrac", rv, 95, 0, info);
			   // out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				// out.print("<rs>true</rs>");
				 out.print("1");

			}
			else if ("changemobile".equals(xmltype)) // 修改手机号
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				String mobile = (String) ht.get("mb");
				if (!Profile.isExist(id, password)) {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>false</rs>  <re>userexist</re></r>");
				} else if (mobileexists(mobile)) {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>false</rs>  <re>mobileexist</re></r>");
				} else {
					Profile p = Profile.find(id);
					p.setMobile(mobile);
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>true</rs></r>");
				}

			} else if ("getprovinces".equals(xmltype)) // 省份列表
			{
				out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				out.print("<l>");
				ArrayList<LvyouCity> provinces = LvyouCity.find1();
				for (int i = 0; i < provinces.size(); i++) {
					LvyouCity province = (LvyouCity) provinces.get(i);
					out.print("<i>" + province.getId() + "</i>");
					out.print("<n>" + province.getName() + "</n>");
				}
				out.print("</l>");
			} else if ("getcitis".equals(xmltype)) // 城市列表
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				int pid = Integer.parseInt(id.trim());
				out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				out.print("<l>");
				ArrayList<LvyouCity> provinces = LvyouCity.find2(pid);
				for (int i = 0; i < provinces.size(); i++) {
					LvyouCity province = (LvyouCity) provinces.get(i);
					out.print("<i>" + province.getId() + "</i>");
					out.print("<n>" + province.getName() + "</n>");
				}
				out.print("</l>");

			} else if ("getModels".equals(xmltype)) // 机种
			{
				out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				out.print("<l>");
				ArrayList<LvyouModels> provinces = LvyouModels.find();
				for (int i = 0; i < provinces.size(); i++) {
					LvyouModels province = (LvyouModels) provinces.get(i);
					out.print("<i>" + province.getId() + "</i>");
					out.print("<n>" + province.getName() + "</n>");
				}
				out.print("</l>");
			} else if ("getJobCatagory".equals(xmltype)) // 职位类别
			{
				out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				out.print("<l>");
				ArrayList<LvyouJobCatagory> provinces = LvyouJobCatagory.find();
				for (int i = 0; i < provinces.size(); i++) {
					LvyouJobCatagory province = (LvyouJobCatagory) provinces
							.get(i);
					out.print("<i>" + province.getId() + "</i>");
					out.print("<n>" + province.getName() + "</n>");
				}
				out.print("</l>");
			} else if ("upuserinfo".equals(xmltype)) // 上传用户信息
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {

					String name = (String) ht.get("nm");
					String sex = (String) ht.get("sx");
					String mobile = (String) ht.get("mb");
					String birth = (String) ht.get("bd");
					int province = Integer.parseInt(((String) ht.get("pv"))
							.trim());
					int state = Integer.parseInt(((String) ht.get("st"))
							.trim());
					int city = Integer.parseInt(((String) ht.get("ct")).trim());
					int certif = Integer.parseInt(((String) ht.get("cr"))
							.trim());
					String years = (String) ht.get("yr");
					int catagory = Integer.parseInt(((String) ht.get("ca"))
							.trim());
					String models = (String) ht.get("md");
					String introduction = (String) ht.get("in");

					Profile p = Profile.find(id);
					p.setFirstName(name, 1);
					p.setSex(sex.trim().equals("1"));
					p.setMobile(mobile);
					Date today =new Date();
					p.setTime(today);
					if (!birth.equals(""))
						p.setBirth(Entity.sdf.parse(birth));
					ProfileLvyou pl = new ProfileLvyou();
					pl.set(id, province, city, certif, years, catagory, models,
							introduction,state);

                    /**********上传到BBS********************/
					if(state==1){
					int hnode=115;
					int sequence = Node.getMaxSequence(hnode) + 10;

					 Node node=Node.find(hnode);
	                    int options1 = node.getOptions1();
	                    long options = node.getOptions();
	                    int defautllangauge = node.getDefaultLanguage();
	                    Category cat = Category.find(hnode);
	                    String subject=LvyouJobCatagory.find(catagory).getName()+"求职";
	                    String text="求职信息：<br>";
	                    text+="姓名:"+p.getName(1)+"<br>";
	                    text+="性别:"+(p.isSex()?"男":"女")+"<br>";
	                    text+="年龄:"+p.getAge()+"<br>";
	                    text+="联系方式："+p.getMobile()+"<br>";
	                    text+="工作地点："+LvyouCity.find(province).getName()+LvyouCity.find(city).getName()+"<br>";
	                    text+="工作年限："+years+"<br>";
	                    text+="上岗证："+(certif==1?"有":"无")+"<br>";
	                    text+="职位类别："+LvyouJobCatagory.find(catagory).getName()+"<br>";
	                    text+="操作机型：";
	                    String modeltext="";
	                    StringTokenizer st = new StringTokenizer(models,"/");
					 	while( st.hasMoreElements() ){
					 	String smid=st.nextToken().trim();
					 	if(!smid.equals("")){
						 int mid=Integer.parseInt(smid);
						 modeltext+=LvyouModels.find(mid).getName()+"/";
						}
					 	}
					 	text+=modeltext;
					 	text+="<br>";
	                    text+="个人简介："+introduction+"<br>";
	                    RV rv=new RV(id);
	                    if(BBS.countByMemberMobile("westrac", id)==0){
	                    hnode = Node.create(hnode,sequence,"westrac",rv,cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,null,new java.util.Date(),0,0,0,0,null,h.language,subject,"","",text,null,"",0,null,"","","","",null,null);
	                    node = Node.find(hnode);
	                    node.finished(hnode);

	                    BBS.create(hnode,1,0,"mobileqz",name,p.getMobile(),p.getEmail(),
	                    		LvyouCity.find(province).getName()+LvyouCity.find(city).getName(),
	                    		LvyouCity.find(province).getName()+LvyouCity.find(city).getName(),3,
	                    		false,0,
	                    		true,true,new Date(),"","",
	                    		(float)0.0,"",0,1,new Date(),
	                    		0,city,modeltext,"",0,0,0,0);

	                    BBS.find(hnode,1).setSearch(0);
	                    ProfileBBS pb = ProfileBBS.find("westrac",id);
	                    pb.set("post",String.valueOf(pb.post + 1));
	                    BBSForum bf = BBSForum.find(hnode);
	                    //更新积分
	                    BBSPoint bp = new BBSPoint(0);
	                    bp.member = id;
	                    bp.point =  bf.topic;
	                    bp.node = hnode;
	                    bp.type = 1;
	                    bp.set();
	                    }else
	                    { int nid=BBS.findByMemberMobile("westrac", id);
	                    	node = Node.find(nid);
	                        BBS bbs=BBS.find(nid, 1);
	                        node.set(sequence, options, node.getDefaultLanguage(), node.getStartTime(), node.getStopTime(),
	                        		h.language, subject, node.getKeywords(1), node.getDescription(1), text,
	                        		node.getPicture(h.language), node.getAlt(h.language), 0, "", "","", "", "", "",new Date(), node.getStyle(), node.getRoot());
	                       node.setUpdatetime(new Date());

	                        //    node.set(sequence,options,options1,defautllangauge,node.getStartTime(),null,h.language,subject,"","",text,null,"",0,null,"","","","",null,null);
		                   bbs.set(0,"mobileqz",name,p.getMobile(),p.getEmail(),
		                    		LvyouCity.find(province).getName()+LvyouCity.find(city).getName(),
		                    		LvyouCity.find(province).getName()+LvyouCity.find(city).getName(),id,3,
		                    		false,0,
		                    		true,true,new Date(),"","",
		                    		(float)0.0,"",0,1,new Date(),
		                    		0,city,modeltext,"",0,0,0,0);
		                    bbs.set(id, new Date());
		                  //  bbs.set(hint, ip, name, phone, email, area, address, umember, special, multiple, expiration, visibility, overt, starttime, place, category, cost, city, rnumber, sex, exptime, wage, icity, professional, requires, age, experience, jobtype, jobmodel)
		                     BBS.find(nid,1).setSearch(0);

	                    }
					}
	                    //发贴数量+1


					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>true</rs>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}

			} else if ("upcompanyinfo".equals(xmltype)) // 上传公司信息
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {

					String companyname = (String) ht.get("cn");
					String companyperson = (String) ht.get("cp");
					String companytelephone = (String) ht.get("ct");
					String companyinfo = (String) ht.get("ci");
					ProfileLvyou pl = new ProfileLvyou();
					pl.set(id, companyname, companyperson, companytelephone,
							companyinfo);

					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>true</rs>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}

			} else if ("getcompanyinfo".equals(xmltype)) // 获取公司信息
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				//String password = (String) ht.get("ps");
				//if (Profile.isExist(id, password)) {

					ProfileLvyou pl = new ProfileLvyou();
					pl = pl.find(id);

					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>true</rs>");
					out.print("<id>" + id + "</id>");
					out.print("<cn>" + pl.getCompanyname() + "</cn>");
					out.print("<ct>" + pl.getCompanytelephone() + "</ct>");
					out.print("<cp>" + pl.getCompanyperson() + "</cp>");
					out.print("<ci>" + pl.getCompanyinfo() + "</ci>");
					out.print("<la>" + pl.getLatitude() + "</la>");
					out.print("<lo>" + pl.getLongitude() + "</lo>");
					out.print("</l>");
			 /*	}
			   else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}*/

			} else if ("getuserinfo".equals(xmltype)) // 获取用户信息
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				//String password = (String) ht.get("ps");
				//if (Profile.isExist(id, password)) {

					ProfileLvyou pl = new ProfileLvyou();
					pl = pl.find(id);

					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>true</rs>");
					out.print("<p>");
					out.print("<id>" + pl.getMember() + "</id>");
					 Profile p=Profile.find(pl.getMember());
					out.print("<mb>" + p.getMobile() + "</mb>");
					out.print("<nm>" + pl.getName() + "</nm>");
					out.print("<sx>" + pl.getSex() + "</sx>");
					out.print("<bd>" + pl.getBirthToString() + "</bd>");
					out.print("<pv>" + pl.getProvince() + "</pv>");
					out.print("<ct>" + pl.getCity() + "</ct>");
					out.print("<pvn>" + LvyouCity.find(pl.getProvince()).getName() + "</pvn>");
					out.print("<ctn>" + LvyouCity.find(pl.getCity()).getName() + "</ctn>");
					out.print("<cr>" + pl.getCertification() + "</cr>");
					out.print("<yr>" + pl.getYears() + "</yr>");
					out.print("<ca>" + pl.getJobcategory() + "</ca>");
					out.print("<can>" + LvyouJobCatagory.find(pl.getJobcategory()).getName() + "</can>");
					out.print("<md>" + pl.getModels() + "</md>");
					out.print("<la>" + pl.getLatitude() + "</la>");
					out.print("<lo>" + pl.getLongitude() + "</lo>");
					out.print("<in>" + pl.getIntroduction() + "</in>");
					out.print("<st>" + pl.getState() + "</st>");
					out.print("<hp>" + "http://" + request.getServerName()
							+ ":" + request.getServerPort() + pl.getHeadpic()
							+ "</hp>");
					out.print("</p>");
					out.print("</l>");
				/*} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}*/

			} else if ("getcatagoryname".equals(xmltype)) // 取城市名
			{
				int id = Integer.parseInt(xmlcontent);
				LvyouJobCatagory city = LvyouJobCatagory.find(id);
				out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				out.print("<rs>" + city.getName() + "</rs>");

			} else if ("getmodelname".equals(xmltype)) // 取城市名
			{
				int id = Integer.parseInt(xmlcontent);
				LvyouModels city = LvyouModels.find(id);
				out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				out.print("<rs>" + city.getName() + "</rs>");

			} else if ("getcityname".equals(xmltype)) // 取城市名
			{
				int id = Integer.parseInt(xmlcontent.trim());
				LvyouCity city = LvyouCity.find(id);
				out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				out.print("<rs>" + city.getName() + "</rs>");
			} else if ("upheadpic".equals(xmltype)) // 取城市名
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {
					byte[] headpic = teasession.getBytesParameter("headpic");
					String name = teasession.getParameter("headpicName");
					String url = "";
					if (headpic != null) {
						url = super.write("westrac", "headpic", headpic, id
								+ name.substring(name.lastIndexOf(".")));
						ProfileLvyou.set(id, url);
					}
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>" + "http://" + request.getServerName()
							+ ":" + request.getServerPort() + url + "</rs></r>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<r><rs>false</rs></r>");
				}
			} else if ("getheadpic".equals(xmltype)) // 获取用户信息
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {

					ProfileLvyou pl = new ProfileLvyou();
					pl = pl.find(id);
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l>");
					out.print("<rs>" + "http://" + request.getServerName()
							+ ":" + request.getServerPort() + pl.getHeadpic()
							+ "</rs>");
					out.print("</l>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}

			} else if ("upjobinfo".equals(xmltype)) // 上传招聘信息
			{
				HashMap ht = MT.xml(xmlcontent);
				String member = (String) ht.get("ui");
				String password = (String) ht.get("ps");
				if (Profile.isExist(member, password)) {

					int id = Integer.parseInt(((String) ht.get("id")).trim());
					int province = Integer.parseInt(((String) ht.get("pv"))
							.trim());
					int city = Integer.parseInt(((String) ht.get("ct")).trim());
					int jobcatagory = Integer.parseInt(((String) ht.get("ca"))
							.trim());
					int pcount = Integer.parseInt(((String) ht.get("co"))
							.trim());
					String name = (String) ht.get("nm");
					String introduction = (String) ht.get("in");
					int state = Integer
							.parseInt(((String) ht.get("st")).trim());

					LvyouJob lj = new LvyouJob();
					lj.set(id, member, name, province, city, jobcatagory,
							pcount, introduction, state);
				    /**********上传到BBS********************/
					if(state==1){
					 int hnode=115;
					 int sequence = Node.getMaxSequence(hnode) + 10;

					 Node node=Node.find(hnode);
					 Profile p=Profile.find(member);
					 ProfileLvyou pl=ProfileLvyou.find(member);
	                    int options1 = node.getOptions1();
	                    long options = node.getOptions();
	                    int defautllangauge = node.getDefaultLanguage();
	                    Category cat = Category.find(hnode);
	                    String subject=pl.getCompanyname()+"招聘"+LvyouJobCatagory.find(jobcatagory).getName();
	                    String text="招聘信息：<br>";
	                    text+="公司名称:"+pl.getCompanyname()+"<br>";
	                    text+="联系人:"+pl.getCompanyperson()+"<br>";
	                    text+="联系方式:"+pl.getCompanytelephone()+"<br>";
	                    text+="工作地点："+LvyouCity.find(province).getName()+LvyouCity.find(city).getName()+"<br>";
	                    text+="职位类别："+LvyouJobCatagory.find(jobcatagory).getName()+"<br>";
	                    text+="招聘人数:"+pcount+"<br>";
	                    text+="职位要求:"+introduction+"<br>";
	                    RV rv=new RV(member);
	                    if(BBS.countByMemberMobile("westrac", member,subject)==0){
	                    hnode = Node.create(hnode,sequence,"westrac",rv,cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,null,new java.util.Date(),0,0,0,0,null,1,subject,"","",text,null,"",0,null,"","","","",null,null);
	                    node = Node.find(hnode);
	                    node.finished(hnode);

	                    BBS.create(hnode,1,0,"mobilezp",pl.getCompanyperson(),pl.getCompanytelephone(),p.getEmail(),
	                    		LvyouCity.find(province).getName()+LvyouCity.find(city).getName(),
	                    		LvyouCity.find(province).getName()+LvyouCity.find(city).getName(),4,
	                    		false,0,
	                    		true,true,new Date(),"","",
	                    		(float)0.0,"",0,1,new Date(),
	                    		0,lj.getCity(),"","",0,0,0,0);
	                    BBS.find(hnode,1).setSearch(0);
	                    //发贴数量+1
	                    ProfileBBS pb = ProfileBBS.find("westrac",member);
	                    pb.set("post",String.valueOf(pb.post + 1));
	                    BBSForum bf = BBSForum.find(hnode);
	                    //更新积分
	                    BBSPoint bp = new BBSPoint(0);
	                    bp.member = member;
	                    bp.point =  bf.topic;
	                    bp.node = hnode;
	                    bp.type = 1;
	                    bp.set();
	                    }else
	                    {
	                    	int nid=BBS.findByMemberMobile("westrac", member,subject);
	                    	node = Node.find(nid);
	                        BBS bbs=BBS.find(nid, 1);
	                        node.set(sequence, options, node.getDefaultLanguage(), node.getStartTime(), node.getStopTime(),
	                        		h.language, subject, node.getKeywords(1), node.getDescription(1), text,
	                        		node.getPicture(h.language), node.getAlt(h.language), 0, "", "","", "", "", "",new Date(), node.getStyle(), node.getRoot());
	                       node.setUpdatetime(new Date());

	                        //    node.set(sequence,options,options1,defautllangauge,node.getStartTime(),null,h.language,subject,"","",text,null,"",0,null,"","","","",null,null);
		                   bbs.set(0,"mobilezp",pl.getCompanyperson(),pl.getCompanytelephone(),p.getEmail(),
		                    		LvyouCity.find(province).getName()+LvyouCity.find(city).getName(),
		                    		LvyouCity.find(province).getName()+LvyouCity.find(city).getName(),member,4,
		                    		false,0,
		                    		true,true,new Date(),"","",
		                    		(float)0.0,"",0,1,new Date(),
		                    		0,lj.getCity(),"","",0,0,0,0);
		                    bbs.set(member, new Date());
		                  //  bbs.set(hint, ip, name, phone, email, area, address, umember, special, multiple, expiration, visibility, overt, starttime, place, category, cost, city, rnumber, sex, exptime, wage, icity, professional, requires, age, experience, jobtype, jobmodel)
		                     BBS.find(nid,1).setSearch(0);
	                    }
					}
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>true</rs>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}

			} else if ("getjobinfo".equals(xmltype)) // 获取工作信息
			{System.out.print("xmlcontent:"+xmlcontent);
				HashMap ht = MT.xml(xmlcontent);

			//	String member = (String) ht.get("ui");
				//String password = (String) ht.get("ps");
				//if (Profile.isExist(member, password)) {
					int id = Integer.parseInt(((String) ht.get("id")).trim());
					LvyouJob lj = LvyouJob.find(id);

					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					if (lj.getId() != 0) {
						out.print("<l>");
						out.print("<rs>true</rs>");
						out.print("<p>");
						out.print("<id>" + lj.getId() + "</id>");
						ProfileLvyou pl = new ProfileLvyou();
						pl = pl.find(lj.getMember());
						out.print("<cn>" + pl.getCompanyname() + "</cn>");
						out.print("<ca>" + lj.getJobcatagory() + "</ca>");
						out.print("<can>" + LvyouJobCatagory.find(lj.getJobcatagory()).getName() + "</can>");
						out.print("<pv>" + lj.getProvince() + "</pv>");
						out.print("<ct>" + lj.getCity() + "</ct>");
						out.print("<pvn>" + LvyouCity.find(lj.getProvince()).getName() + "</pvn>");
						out.print("<ctn>" + LvyouCity.find(lj.getCity()).getName() + "</ctn>");
						out.print("<mb>" + lj.getMember() + "</mb>");
						out.print("<co>" + lj.getPcount() + "</co>");
						out.print("<nm>" + lj.getName() + "</nm>");
						out.print("<in>" + lj.getIntroduction() + "</in>");
						out.print("<st>" + lj.getState() + "</st>");
						out.print("<la>" + pl.getLatitude() + "</la>");
						out.print("<lo>" + pl.getLongitude() + "</lo>");
						out.print("<it>" + lj.getIssueToString() + "</it>");
						out.print("</p>");
						out.print("</l>");
					} else
						out.print("<l><rs>false</rs></l>");
				/*} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}*/

			} else if ("findmyjob".equals(xmltype)) // 获取用户发布的工作列表
			{
				HashMap ht = MT.xml(xmlcontent);
				String member = (String) ht.get("ui");
		     	String password = (String) ht.get("ps");
				//if (Profile.isExist(member, password)) {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l>");
					out.print("<rs>true</rs>");
					String ordertype=(String) ht.get("ot");
					ArrayList<LvyouJob> jobs = LvyouJob.find(member,ordertype,Integer.parseInt(password));
					for (int i = 0; i < jobs.size(); i++) {
						LvyouJob job = (LvyouJob) jobs.get(i);
						out.print("<p>");
						out.print("<id>" + job.getId() + "</id>");
						ProfileLvyou pl = new ProfileLvyou();
						pl = pl.find(member);
						out.print("<cn>" + pl.getCompanyname() + "</cn>");
						out.print("<ca>" + job.getJobcatagory() + "</ca>");
						out.print("<can>" + LvyouJobCatagory.find(job.getJobcatagory()).getName() + "</can>");
						out.print("<pv>" + job.getProvince() + "</pv>");
						out.print("<ct>" + job.getCity() + "</ct>");
						out.print("<pvn>" + LvyouCity.find(job.getProvince()).getName() + "</pvn>");
						out.print("<ctn>" + LvyouCity.find(job.getCity()).getName() + "</ctn>");

						out.print("<co>" + job.getPcount() + "</co>");
						out.print("<nm>" + job.getName() + "</nm>");
						out.print("<in>" + job.getIntroduction() + "</in>");
						out.print("<st>" + job.getState() + "</st>");
						out.print("<it>" + job.getIssueToString() + "</it>");
						out.print("</p>");
					}
					out.print("</l>");
				/*
			} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}*/

			} else if ("deletejobinfo".equals(xmltype)) // 删除用户信息
			{
				HashMap ht = MT.xml(xmlcontent);
				String member = (String) ht.get("ui");
				String password = (String) ht.get("ps");
				if (Profile.isExist(member, password)) {

					int id = Integer.parseInt(((String) ht.get("id")).trim());

					LvyouJob lj = LvyouJob.find(id);
					if (lj.getMember().equals(member)) {
						LvyouJob.delete(id);

						out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
						out.print("<rs>true</rs>");
					} else {
						out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
						out.print("<rs>false</rs>");
					}
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}

			} else if ("upapplyjobs".equals(xmltype)) // 上传用户职位申请
			{
				HashMap ht = MT.xml(xmlcontent);
				String member = (String) ht.get("ui");
				String password = (String) ht.get("ps");
				if (Profile.isExist(member, password)) {


					String jobs=(String) ht.get("js");
					StringTokenizer st = new StringTokenizer(jobs,"/");
				 	while( st.hasMoreElements() ){
				 	String sjobid=st.nextToken().trim();
				 	if(!sjobid.equals("")){
					 int jobid=Integer.parseInt(sjobid);
					 LvyouApply.set(member, jobid);
					}
					}

					 out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					 out.print("<rs>true</rs>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}

			}
			else if ("delapplyjobs".equals(xmltype)) // 取消用户职位申请
			{
				HashMap ht = MT.xml(xmlcontent);
				String member = (String) ht.get("ui");
				String password = (String) ht.get("ps");
				if (Profile.isExist(member, password)) {


					String jobs=(String) ht.get("js");
					StringTokenizer st = new StringTokenizer(jobs,"/");
				 	while( st.hasMoreElements() ){
				 	String sjobid=st.nextToken().trim();
				 	if(!sjobid.equals("")){
					 int jobid=Integer.parseInt(sjobid);
					 LvyouApply.delete(member, jobid);
					}
					}

					 out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					 out.print("<rs>true</rs>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}

			}
			else if ("findappusers".equals(xmltype)) // 获取申请某职位的用户列表
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {
					int jobid = Integer.parseInt(((String) ht.get("ji")).trim());

			        String orderby= (String)ht.get("ob");
			        String ordertype=(String)ht.get("ot");
			        ProfileLvyou plv= ProfileLvyou.find(id);

					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>true</rs>");
					ArrayList<ProfileLvyou> jobs=LvyouApply.find(jobid,orderby,ordertype,plv.getLatitude(),plv.getLongitude());
					for (int i = 0; i < jobs.size(); i++) {
						ProfileLvyou pl=(ProfileLvyou)jobs.get(i);
					out.print("<p>");
					out.print("<id>" + pl.getMember() + "</id>");
					Profile p=Profile.find(pl.getMember());
					out.print("<mb>" + p.getMobile() + "</mb>");
					out.print("<nm>" + pl.getName() + "</nm>");
					out.print("<sx>" + pl.getSex() + "</sx>");
					out.print("<bd>" + pl.getBirthToString() + "</bd>");
					out.print("<pv>" + pl.getProvince() + "</pv>");
					out.print("<ct>" + pl.getCity() + "</ct>");
					out.print("<pvn>" + LvyouCity.find(pl.getProvince()).getName() + "</pvn>");
					out.print("<ctn>" + LvyouCity.find(pl.getCity()).getName() + "</ctn>");

					out.print("<cr>" + pl.getCertification() + "</cr>");
					out.print("<yr>" + pl.getYears() + "</yr>");
					out.print("<ca>" + pl.getJobcategory() + "</ca>");
					out.print("<can>" + LvyouJobCatagory.find(pl.getJobcategory()).getName() + "</can>");
					LvyouApply apply=LvyouApply.find(pl.getMember(), jobid);
					out.print("<pt>" + apply.getApptimeToString() + "</pt>");
					out.print("<md>" + pl.getModels() + "</md>");
					out.print("<la>" + pl.getLatitude() + "</la>");
					out.print("<lo>" + pl.getLongitude() + "</lo>");
					out.print("<in>" + pl.getIntroduction() + "</in>");
					out.print("<hp>" + "http://" + request.getServerName()
							+ ":" + request.getServerPort() + pl.getHeadpic()
							+ "</hp>");
					out.print("</p>");
					}

					out.print("</l>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}

			} else if ("findappjobs".equals(xmltype)) // 获取自己申请的职位列表
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {
					//String member = Integer.parseInt(((String) ht.get("ji")).trim());
					  ProfileLvyou plv= ProfileLvyou.find(id);
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>true</rs>");

			        String orderby= (String)ht.get("ob");
			        String ordertype=(String)ht.get("ot");
					ArrayList<LvyouJob> jobs=LvyouApply.find(id,orderby,ordertype,plv.getLatitude(),plv.getLongitude());
					for (int i = 0; i < jobs.size(); i++) {
						LvyouJob job = (LvyouJob) jobs.get(i);
						out.print("<p>");
						out.print("<id>" + job.getId() + "</id>");
						  ProfileLvyou pl= ProfileLvyou.find(job.getMember());
						out.print("<cn>" + pl.getCompanyname() + "</cn>");
						out.print("<ca>" + job.getJobcatagory() + "</ca>");
						out.print("<can>" + LvyouJobCatagory.find(job.getJobcatagory()).getName() + "</can>");

						out.print("<pv>" + job.getProvince() + "</pv>");
						out.print("<ct>" + job.getCity() + "</ct>");
						out.print("<pvn>" + LvyouCity.find(job.getProvince()).getName() + "</pvn>");
						out.print("<ctn>" + LvyouCity.find(job.getCity()).getName() + "</ctn>");

						out.print("<co>" + job.getPcount() + "</co>");
						out.print("<nm>" + job.getName() + "</nm>");
						out.print("<in>" + job.getIntroduction() + "</in>");
						out.print("<st>" + job.getState() + "</st>");
						out.print("<la>" + pl.getLatitude() + "</la>");
						out.print("<lo>" + pl.getLongitude() + "</lo>");
						out.print("<it>" + job.getIssueToString() + "</it>");
						out.print("</p>");
					}
					out.print("</l>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}

			}  else if ("findcountappusers".equals(xmltype)) // 获取申请某职位的用户数量
			{
				HashMap ht = MT.xml(xmlcontent);
			//	String id = (String) ht.get("id");
				//String password = (String) ht.get("ps");
				//if (Profile.isExist(id, password)) {
					int jobid = Integer.parseInt(((String) ht.get("ji")).trim());
			    	out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>true</rs>");
					int count=LvyouApply.count(jobid);
					out.print("<ct>" +count+"</ct>");
					out.print("</l>");
				/*} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}*/

			} else if ("findcountappjobs".equals(xmltype)) // 获取申请某职位的用户数量
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {
					int jobid = Integer.parseInt(((String) ht.get("ji")).trim());
			    	out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>true</rs>");
					int count=LvyouApply.count(id);
					out.print("<ct>" +count+"</ct>");
					out.print("</l>");

				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}

			}   else if ("upfavoritejobs".equals(xmltype)) // 上传用户职位收藏
			{
				HashMap ht = MT.xml(xmlcontent);
				String member = (String) ht.get("ui");
				String password = (String) ht.get("ps");
				if (Profile.isExist(member, password)) {


					String jobs=(String) ht.get("js");
					StringTokenizer st = new StringTokenizer(jobs,"/");
				 	while( st.hasMoreElements() ){
				 	String sjobid=st.nextToken().trim();
				 	if(!sjobid.equals("")){
					 int jobid=Integer.parseInt(sjobid);
					 LvyouFavorite.set(member, jobid);
					}
					}

					 out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					 out.print("<rs>true</rs>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}

			}
			else if ("delfavoritejobs".equals(xmltype)) // 取消用户职位收藏
			{
				HashMap ht = MT.xml(xmlcontent);
				String member = (String) ht.get("ui");
				String password = (String) ht.get("ps");
				if (Profile.isExist(member, password)) {


					String jobs=(String) ht.get("js");
					StringTokenizer st = new StringTokenizer(jobs,"/");
				 	while( st.hasMoreElements() ){
				 	String sjobid=st.nextToken().trim();
				 	if(!sjobid.equals("")){
					 int jobid=Integer.parseInt(sjobid);
					 LvyouFavorite.delete(member, jobid);
					}
					}

					 out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					 out.print("<rs>true</rs>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}

			}

			else if ("findfavusers".equals(xmltype)) // 获取收藏某职位的用户列表
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {
					int jobid = Integer.parseInt(((String) ht.get("ji")).trim());


					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>true</rs>");
					ArrayList<ProfileLvyou> jobs=LvyouFavorite.find(jobid);
					for (int i = 0; i < jobs.size(); i++) {
						ProfileLvyou pl=(ProfileLvyou)jobs.get(i);
					out.print("<p>");
					out.print("<id>" + pl.getMember() + "</id>");
					Profile p=Profile.find(pl.getMember());
					out.print("<mb>" + p.getMobile() + "</mb>");
					out.print("<nm>" + pl.getName() + "</nm>");
					out.print("<sx>" + pl.getSex() + "</sx>");
					out.print("<bd>" + pl.getBirthToString() + "</bd>");
					out.print("<pv>" + pl.getProvince() + "</pv>");
					out.print("<ct>" + pl.getCity() + "</ct>");
					out.print("<pvn>" + LvyouCity.find(pl.getProvince()).getName() + "</pvn>");
					out.print("<ctn>" + LvyouCity.find(pl.getCity()).getName() + "</ctn>");

					out.print("<cr>" + pl.getCertification() + "</cr>");
					out.print("<yr>" + pl.getYears() + "</yr>");
					out.print("<ca>" + pl.getJobcategory() + "</ca>");
					out.print("<can>" + LvyouJobCatagory.find(pl.getJobcategory()).getName() + "</can>");

					out.print("<md>" + pl.getModels() + "</md>");
					out.print("<la>" + pl.getLatitude() + "</la>");
					out.print("<lo>" + pl.getLongitude() + "</lo>");
					out.print("<in>" + pl.getIntroduction() + "</in>");
					out.print("<hp>" + "http://" + request.getServerName()
							+ ":" + request.getServerPort() + pl.getHeadpic()
							+ "</hp>");
					out.print("</p>");
					}
					out.print("</l>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}

			} else if ("findfavjobs".equals(xmltype)) // 获取自己收藏的职位列表
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {
					//String member = Integer.parseInt(((String) ht.get("ji")).trim());

					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>true</rs>");
					ProfileLvyou plv = ProfileLvyou.find(id);
					String orderby= (String)ht.get("ob");
			        String ordertype=(String)ht.get("ot");
					ArrayList<LvyouJob> jobs=LvyouFavorite.find(id,orderby,ordertype,plv.getLatitude(),plv.getLongitude());
					for (int i = 0; i < jobs.size(); i++) {
						LvyouJob job = (LvyouJob) jobs.get(i);
						out.print("<p>");
						out.print("<id>" + job.getId() + "</id>");
						ProfileLvyou pl = ProfileLvyou.find(job.getMember());

						out.print("<cn>" + pl.getCompanyname() + "</cn>");
						out.print("<ca>" + job.getJobcatagory() + "</ca>");
						out.print("<can>" + LvyouJobCatagory.find(job.getJobcatagory()).getName() + "</can>");
						out.print("<pv>" + job.getProvince() + "</pv>");
						out.print("<ct>" + job.getCity() + "</ct>");
						out.print("<pvn>" + LvyouCity.find(job.getProvince()).getName() + "</pvn>");
						out.print("<ctn>" + LvyouCity.find(job.getCity()).getName() + "</ctn>");
						out.print("<la>" + pl.getLatitude() + "</la>");
						out.print("<lo>" + pl.getLongitude() + "</lo>");
						out.print("<co>" + job.getPcount() + "</co>");
						out.print("<nm>" + job.getName() + "</nm>");
						out.print("<in>" + job.getIntroduction() + "</in>");
						out.print("<st>" + job.getState() + "</st>");
						out.print("<it>" + job.getIssueToString() + "</it>");

						out.print("</p>");
					}
					out.print("</l>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}

			}  else if ("findcountfavusers".equals(xmltype)) // 获取收藏某职位的用户数量
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {
					int jobid = Integer.parseInt(((String) ht.get("ji")).trim());
			    	out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>true</rs>");
					int count=LvyouFavorite.count(jobid);
					out.print("<ct>" +count+"</ct>");
					out.print("</l>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}

			} else if ("findcountfavjobs".equals(xmltype)) // 获取收藏某职位的用户数量
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {
					int jobid = Integer.parseInt(((String) ht.get("ji")).trim());
			    	out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>true</rs>");
					int count=LvyouFavorite.count(id);
					out.print("<ct>" +count+"</ct>");
					out.print("</l>");

				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}

			}   else if ("upreserveusers".equals(xmltype)) // 上传人才收藏
			{
				HashMap ht = MT.xml(xmlcontent);
				String member = (String) ht.get("ui");
				String password = (String) ht.get("ps");
				if (Profile.isExist(member, password)) {


					String jobs=(String) ht.get("js");
					StringTokenizer st = new StringTokenizer(jobs,"/");
				 	while( st.hasMoreElements() ){
				 	String reserve=st.nextToken().trim();
				 	if(!reserve.equals("")){
			 		 LvyouReserve.set(member, reserve);
					}
					}

					 out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					 out.print("<rs>true</rs>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}

			}
			else if ("delreserveusers".equals(xmltype)) // 取消用户职位收藏
			{
				HashMap ht = MT.xml(xmlcontent);
				String member = (String) ht.get("ui");
				String password = (String) ht.get("ps");
				if (Profile.isExist(member, password)) {


					String jobs=(String) ht.get("js");
					StringTokenizer st = new StringTokenizer(jobs,"/");
				 	while( st.hasMoreElements() ){
				 	String reserve=st.nextToken().trim();
				 	if(!reserve.equals("")){
				  	 LvyouReserve.delete(member, reserve);
					}
					}

					 out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					 out.print("<rs>true</rs>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}

			}

			else if ("findreserveusers".equals(xmltype)) // 获取收藏人才列表
			{
				HashMap ht = MT.xml(xmlcontent);
				String id = (String) ht.get("id");
				String password = (String) ht.get("ps");
				if (Profile.isExist(id, password)) {


					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>true</rs>");
					ProfileLvyou plv = ProfileLvyou.find(id);
					String orderby= (String)ht.get("ob");
			        String ordertype=(String)ht.get("ot");
					ArrayList<ProfileLvyou> jobs=LvyouReserve.find(id, orderby, ordertype, plv.getLatitude(), plv.getLongitude());
					for (int i = 0; i < jobs.size(); i++) {
						ProfileLvyou pl=(ProfileLvyou)jobs.get(i);
					out.print("<p>");
					out.print("<id>" + pl.getMember() + "</id>");
					out.print("<nm>" + pl.getName() + "</nm>");
					out.print("<sx>" + pl.getSex() + "</sx>");
					out.print("<bd>" + pl.getBirthToString() + "</bd>");
					out.print("<pv>" + pl.getProvince() + "</pv>");
					out.print("<ct>" + pl.getCity() + "</ct>");
					out.print("<pvn>" + LvyouCity.find(pl.getProvince()).getName() + "</pvn>");
					out.print("<ctn>" + LvyouCity.find(pl.getCity()).getName() + "</ctn>");

					out.print("<cr>" + pl.getCertification() + "</cr>");
					out.print("<yr>" + pl.getYears() + "</yr>");
					out.print("<ca>" + pl.getJobcategory() + "</ca>");
					out.print("<can>" + LvyouJobCatagory.find(pl.getJobcategory()).getName() + "</can>");
					out.print("<md>" + pl.getModels() + "</md>");
					out.print("<la>" + pl.getLatitude() + "</la>");
					out.print("<lo>" + pl.getLongitude() + "</lo>");
					out.print("<in>" + pl.getIntroduction() + "</in>");
					out.print("<hp>" + "http://" + request.getServerName()
							+ ":" + request.getServerPort() + pl.getHeadpic()
							+ "</hp>");
					out.print("</p>");
					}
					out.print("</l>");
				} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>false</rs></l>");
				}

			} else if ("searchjobinfo".equals(xmltype)) // 上传用户信息
			{
				HashMap ht = MT.xml(xmlcontent);
			//	String member = (String) ht.get("ui");
				//String password = (String) ht.get("ps");
				//if (Profile.isExist(member, password)) {

					String keyword = ((String) ht.get("kw")).trim();
					int province = Integer.parseInt(((String) ht.get("pv"))
							.trim());
					int city = Integer.parseInt(((String) ht.get("ct")).trim());
					int catagory = Integer.parseInt(((String) ht.get("ca"))
							.trim());
					int days = Integer.parseInt(((String) ht.get("dy"))
							.trim());
					int page = Integer.parseInt(((String) ht.get("pg"))
							.trim());
					int size = Integer.parseInt(((String) ht.get("sz"))
							.trim());
					int state = Integer.parseInt(((String) ht.get("st"))
							.trim());
					String orderby= (String)ht.get("ob");
			        String ordertype=(String)ht.get("ot");
			        String latitude= (String)ht.get("la");
			        String longitude=(String)ht.get("lo");
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l>");
					out.print("<rs>true</rs>");
					ArrayList<LvyouJob> jobs = LvyouJob.find(keyword, province, city, catagory, days,state,orderby,ordertype,latitude,longitude, page, size);
					for (int i = 0; i < jobs.size(); i++) {
						LvyouJob job = (LvyouJob) jobs.get(i);
						out.print("<p>");
						out.print("<id>" + job.getId() + "</id>");
						ProfileLvyou pl = new ProfileLvyou();
						pl = pl.find(job.getMember());
						out.print("<cn>" + pl.getCompanyname() + "</cn>");
						out.print("<ca>" + job.getJobcatagory() + "</ca>");
						out.print("<can>" + LvyouJobCatagory.find(job.getJobcatagory()).getName() + "</can>");
						out.print("<pv>" + job.getProvince() + "</pv>");
						out.print("<ct>" + job.getCity() + "</ct>");

						out.print("<pvn>" + LvyouCity.find(job.getProvince()).getName() + "</pvn>");
						out.print("<ctn>" + LvyouCity.find(job.getCity()).getName() + "</ctn>");

						out.print("<co>" + job.getPcount() + "</co>");
						out.print("<nm>" + job.getName() + "</nm>");
						out.print("<in>" + job.getIntroduction() + "</in>");
						out.print("<st>" + job.getState() + "</st>");
						out.print("<la>" + pl.getLatitude() + "</la>");
						out.print("<lo>" + pl.getLongitude() + "</lo>");
						out.print("<it>" + job.getIssueToString() + "</it>");
						out.print("</p>");
					}
					out.print("</l>");
				/*} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}*/

			}   else if ("searchuserinfo".equals(xmltype)) // 上传用户信息
			{
				HashMap ht = MT.xml(xmlcontent);
				//String member = (String) ht.get("ui");
				//String password = (String) ht.get("ps");
			//	if (Profile.isExist(member, password)) {

					String keyword = ((String) ht.get("kw")).trim();
					int province = Integer.parseInt(((String) ht.get("pv"))
							.trim());
					int city = Integer.parseInt(((String) ht.get("ct")).trim());
					int catagory = Integer.parseInt(((String) ht.get("ca"))
							.trim());
					int sex = Integer.parseInt(((String) ht.get("sx")).trim());
					// String day1 = (String) ht.get("d1");
					 //String day2 = (String) ht.get("d2");
					int days = Integer.parseInt(((String) ht.get("dy"))
							.trim());
					int page = Integer.parseInt(((String) ht.get("pg"))
							.trim());
					int size = Integer.parseInt(((String) ht.get("sz"))
							.trim());
					int state = Integer.parseInt(((String) ht.get("st"))
							.trim());
					String orderby= (String)ht.get("ob");
			        String ordertype=(String)ht.get("ot");
			        String latitude= (String)ht.get("la");
			        String longitude=(String)ht.get("lo");
					String models = (String) ht.get("md");
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<l><rs>true</rs>");
					ArrayList<ProfileLvyou> jobs=ProfileLvyou.find(keyword, province, city, catagory, sex, days, models,state,orderby,ordertype,latitude,longitude, page, size);
					for (int i = 0; i < jobs.size(); i++) {
						ProfileLvyou pl=(ProfileLvyou)jobs.get(i);

					out.print("<p>");
					out.print("<id>" + pl.getMember() + "</id>");
					Profile p=Profile.find(pl.getMember());
					out.print("<mb>" + p.getMobile() + "</mb>");
					out.print("<pt>" + p.getTimeToString() + "</pt>");
					out.print("<nm>" + pl.getName() + "</nm>");
					out.print("<sx>" + pl.getSex() + "</sx>");
					out.print("<bd>" + pl.getBirthToString() + "</bd>");
					out.print("<pv>" + pl.getProvince() + "</pv>");
					out.print("<ct>" + pl.getCity() + "</ct>");
					out.print("<pvn>" + LvyouCity.find(pl.getProvince()).getName() + "</pvn>");
					out.print("<ctn>" + LvyouCity.find(pl.getCity()).getName() + "</ctn>");

					out.print("<cr>" + pl.getCertification() + "</cr>");
					out.print("<yr>" + pl.getYears() + "</yr>");
					out.print("<ca>" + pl.getJobcategory() + "</ca>");
					out.print("<can>" + LvyouJobCatagory.find(pl.getJobcategory()).getName() + "</can>");
					out.print("<md>" + pl.getModels() + "</md>");
					out.print("<la>" + pl.getLatitude() + "</la>");
					out.print("<lo>" + pl.getLongitude() + "</lo>");
					out.print("<in>" + pl.getIntroduction() + "</in>");
					out.print("<hp>" + "http://" + request.getServerName()
							+ ":" + request.getServerPort() + pl.getHeadpic()
							+ "</hp>");
					out.print("</p>");
					}
					out.print("</l>");
				/*} else {
					out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
					out.print("<rs>false</rs>");
				}*/

			}  else if("waccountadd".equals(xmltype))
            { int member = h.getInt("member");
            String password = h.get("password");
                String userid = h.get("userid");
                int type = h.getInt("type");
                ArrayList al = WAccount.find(" AND member=" + member + " AND userid=" + DbAdapter.cite(userid) + " AND type=" + type,0,1);
                WAccount t = al.size() < 1 ? new WAccount(0) : (WAccount) al.get(0);
                t.member = member;
                t.userid = userid;
                t.name = h.get("name");
                t.type = type;
                t.nick = h.get("nick");
                t.token = h.get("token");
                //t.secret = h.get("secret");
                t.avatar = h.get("avatar");
                t.following = h.getInt("following");
                t.follower = h.getInt("follower");
                t.micro = h.getInt("micro");
                t.favorite = h.getInt("favorite");
                t.set();
                out.print("{code:200,waccount:" + t.waccount + "}");
            } else if("waccountdel".equals(xmltype))
            {int member = h.getInt("member");
                int waccount = h.getInt("waccount");
                WAccount t = WAccount.find(waccount);
                if(t.member == member)
                    t.delete();
                out.print("{code:200}");
            } else if("waccounts".equals(xmltype))
            {int member = h.getInt("member");
            //System.out.println("ANDROID 事件：" + act + " 104");
            ArrayList al = WAccount.find(" AND member=" + member + " ORDER BY follower DESC",0,200);
            out.print("[");
            for(int i = 0;i < al.size();i++)
            {
                if(i > 0)
                    out.print(",");
                WAccount t = (WAccount) al.get(i);
                out.print("{waccount:" + t.waccount);
                out.print(",userid:\"" + t.userid + "\"");
                out.print(",name:\"" + t.name + "\"");
                out.print(",type:" + t.type);
                out.print(",nick:\"" + t.nick + "\"");
                out.print(",token:\"" + t.token + "\"");
                //out.print(",secret:\"" + t.secret + "\"");
                out.print(",avatar:\"" + t.avatar + "\"");
                out.print("}");
            }
            out.print("]");
            //System.out.println("ANDROID 事件：" + act + " 123");
            }else  if("config".equals(xmltype))
            {
              //  LvyouWconfig c = LvyouWconfig.find(h.community);
              //  out.print("{code:200,sinaid:" + cite(c.sinaid) + ",sinakey:" + cite(c.sinakey) + ",sinasecret:" + cite(c.sinasecret) + ",qqid:" + cite(c.qqid) + ",qqkey:" + cite(c.qqkey) + ",qqsecret:" + cite(c.qqsecret) + ",login:" + c.login + "}");
              //  System.out.print("{code:200,sinaid:" + cite(c.sinaid) + ",sinakey:" + cite(c.sinakey) + ",sinasecret:" + cite(c.sinasecret) + ",qqid:" + cite(c.qqid) + ",qqkey:" + cite(c.qqkey) + ",qqsecret:" + cite(c.qqsecret) + ",login:" + c.login + "}");
                WConfig c = WConfig.find(h.community);
                out.print("{code:200,sinaid:" + cite(c.sinaid) + ",sinakey:" + cite(c.sinakey) + ",sinasecret:" + cite(c.sinasecret) + ",sinatoken:" + cite(c.sinatoken) + ",qqid:" + cite(c.qqid) + ",qqkey:" + cite(c.qqkey) + ",qqsecret:" + cite(c.qqsecret) + ",qqtoken:" + cite(c.qqtoken) + ",login:" + c.login + "}");

            }
			else {
				out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
				out.print("<r><rs>false</rs>");
				out.print("<re>无效请求类型</re></r>");
			}

		} catch (Exception ex) {
			out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
			out.print("<r><rs>false</rs>");
			out.print("<re>" + ex.getMessage() + "</re></r>");
			ex.printStackTrace();
		} finally {
			out.close();
		}
	}
	  public static String cite(String str)
	    {
	        return "\"" + str + "\"";
	    }

	public boolean mobileexists(String mobile) throws SQLException {
		DbAdapter db = new DbAdapter(1);
		try {
			db.executeQuery("SELECT member FROM Profile WHERE mobile="
					+ DbAdapter.cite(mobile));
			return db.next();
		} finally {
			db.close();
		}
	}
}
