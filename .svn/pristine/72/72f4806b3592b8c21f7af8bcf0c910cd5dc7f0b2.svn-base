<%@page import="tea.entity.util.Card"%>
<%@page import="tea.entity.site.Html"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.member.*" %>
<%@page import="tea.entity.*"%>
<%@page import="java.util.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="jxl.*"%><%@page import="java.io.*"%><%@page import="tea.entity.women.Contributions"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

String nexturl=teasession.getParameter("nexturl");
String act=teasession.getParameter("act");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<%!
public String cellToString(Cell c)
{
	String str=c.getContents();
	if(str==null||"null".equals(str))
	{
		str=null;
	}
	return str;
}
public java.util.Date cellToDate(Cell c)
{
	String str=c.getContents();
	if(str==null||"null".equals(str))
	{
		str=null;
	}
	java.util.Date d=null;
	try
	{
		d=Entity.sdf2.parse(str);
	}catch(Exception ex)
	{
		try
		{
			d=Entity.sdf.parse(str);
		}catch(Exception ex2)
		{
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy年MM月dd日");
			try
			{
				d=sdf.parse(str);
			}catch(Exception ex3)
			{
				sdf = new java.text.SimpleDateFormat("MM/dd/yyyy");
				try
				{
					d=sdf.parse(str);
				}catch(Exception ex4)
				{

				}
			}
		}
	}
	return d;
}
%>
<%
byte by[]=teasession.getBytesParameter("file");//获得文件
if(by!=null)
{
	ByteArrayInputStream bais=new ByteArrayInputStream(by);
	try
	{
		Workbook wb=Workbook.getWorkbook(bais);
		Sheet s=wb.getSheet(0);
		if(teasession.getParameter("import")!=null)//点击 导入执行下面代码
		{
			out.println("总行数:"+s.getRows()+" 正在导入:<span id=c >0</span><br>");
			out.println("<span id=cc></span>"); 
			out.println("<span id=ccc></span><br>"); 
			out.flush();
            int size=s.getRows()/100;
            if(size<1)
            size=1;
            Date time=new Date();
            Event eobj = Event.find(teasession._nNode,teasession._nLanguage);
            StringBuffer sp = new StringBuffer();//判断没有的会员编号
            StringBuffer sp2 = new StringBuffer();//判断没有的用户名
			if("importprofile9000".equals(act))//导入
			{

				for(int i=1;i<s.getRows();i++)
				{
					String code = null;//会员编号
					String member=null;//用户名
					String membername =null;//姓名
					String sex = null;//性别
				
					String mobile=null;//手机
					String birth=null;//生日
					String city0=null;//现工作地（省）
					String city1=null;//现工作地（市）
					String address=null;//现工作地（详细地址）
					String zzracky=null;//民族
					String telephone=null;//固定电话
					String zzhkszd0=null;//家庭所在地(省)	
					String zzhkszd1=null;//家庭所在地（市）	
					String paddress=null;//家庭所在地（详细地址）
					String state0=null;//现通讯地址(省)	
					String state1=null;//现通讯地址（市）	
					String organization=null;//现通讯地址（详细地址）
					String zip=null;//邮编
					String email=null;//email
					String msn =null;//QQ
					String tjmember=null;//推荐人会员编号
					String tjmember2=null;//推荐人用户名
					
					
			
					
				     String memberheight=null;//身高
				     String ballage=null;//打球年龄
				     String almostscore=null;//差点or平均成绩
				     String likeitems=null;//喜欢的;(木，球道，铁木，铁，推)
				     String handfoot=null;//手尺
				     String gdistance=null;//手碗到地面距离
				     String yhand=null;//用手 右手，左手
				     String swingrhythm=null;//挥杆节奏
					
					
					String belsell=null;//所属销售人员
					
					 
					
				
					
					int a =0;
					for(int j=0;j<s.getColumns();j++)
					{
						
						switch(j)
							{
							case 0:
								code=cellToString(s.getCell(j,i));
								break;
							case 1:
								member=cellToString(s.getCell(j,i));							
								break;
							case 2:
								membername=cellToString(s.getCell(j,i));
								break;
							case 3:
								sex=cellToString(s.getCell(j,i));
								break;
							
							case 4:
								mobile=cellToString(s.getCell(j,i));
								break;
							case 5:
								birth=cellToString(s.getCell(j,i));
								break;
							case 6:
								city0=cellToString(s.getCell(j,i));
								break;
							case 7:
								city1=cellToString(s.getCell(j,i));
								break;
							case 8:
								address=cellToString(s.getCell(j,i));
								break;
							case 9:
								zzracky=cellToString(s.getCell(j,i));
								break;
							case 10:
								telephone=cellToString(s.getCell(j,i));
								break;
							case 11:
								zzhkszd0=cellToString(s.getCell(j,i));
								break;
							case 12:
								zzhkszd1=cellToString(s.getCell(j,i));
								break;
							case 13:
								paddress=cellToString(s.getCell(j,i));
								break;
							case 14:
								state0=cellToString(s.getCell(j,i));
								break;
							case 15:
								state1=cellToString(s.getCell(j,i));
								break;
							case 16:
								organization=cellToString(s.getCell(j,i));
								break;
							case 17:
								zip=cellToString(s.getCell(j,i));
								break;
							case 18:
								email=cellToString(s.getCell(j,i));
								break;
							case 19:
								msn=cellToString(s.getCell(j,i));
								break;
							case 20:
								tjmember=cellToString(s.getCell(j,i));
								break;
							case 21:
								tjmember2=cellToString(s.getCell(j,i));
								break;
							case 22:
								memberheight=cellToString(s.getCell(j,i));
								break;
							case 23:
								ballage=cellToString(s.getCell(j,i));
								break;
							case 24:
								almostscore=cellToString(s.getCell(j,i));
								break;
							case 25:
								likeitems=cellToString(s.getCell(j,i));
								break;
							case 26:
								handfoot=cellToString(s.getCell(j,i));
								break;
							case 27:
								gdistance=cellToString(s.getCell(j,i));
								break;
							case 28:
								yhand=cellToString(s.getCell(j,i));
								break;
							case 29:
								swingrhythm=cellToString(s.getCell(j,i));
								break;
							case 30:
								belsell=cellToString(s.getCell(j,i));


						} 
						a++;
				
					}
					
				   if(code!=null && code.length()>0)
				   {
					   //说明填写了会员编号
					   
					   if(!Profile.isExisted(Profile.getMember(code)))
					   {
						   sp.append(code).append("<br>");
							continue;
					   }
				   }else
				   {
					   //如果没有填写
					   //系统自动生成
					   java.text.DecimalFormat df=new java.text.DecimalFormat("000000");
		               	 
		               	 SeqTable seq = new SeqTable();
		               	 code= df.format(seq.getSeqNo(teasession._strCommunity));
				   }
				   
				   if(member!=null && member.length()>0)
				   {
					   if(!Profile.isExisted(member))
					   {
						    sp2.append(member).append("<br>");
							continue;
					   }
				   }else
				   {
					   //没有填写 直接用会员编号
					   member = code;
				   }
				   
				   

				   
				   if(!Profile.isCode(code)&& !Profile.isExisted(member))//用户名和会员编号都正确才能修改 
				   {
					   Profile.create(member,"123456",teasession._strCommunity,null,request.getServerName());
				   }
		              	 Profile pobj = Profile.find(member);
		              	 pobj.setMembertype(1);//直接是审核通过
		              	 
		              	  Http h=new Http(request);
		              	 pobj.setFirstName(membername, teasession._nLanguage);
		              	 
		              	 pobj.setSex(sex=="女"?true:false);
		              	
		              	 pobj.setMobile(mobile);
		              	 if(birth!=null && birth.length()>0){
		              		 if(birth.indexOf("/")!=-1)
		              		 {
		              			birth = birth.replaceAll("/","-");
		              		 }
		              		 
		              	 	pobj.setBirth(Entity.sdf.parse(birth));
		              	 }
		              	 
		              	 
		              	 
		              	 
		              	 //省市
		              	 if((city1!=null && city1.length()>0) && (city0!=null && city0.length()>0)){
		              		 int cid = Card.getCid(city1);
		              	 	pobj.setProvince(cid,teasession._nLanguage);
		              	 }
		              	 
		              	 pobj.setAddress(address, teasession._nLanguage);
		              	 
		              	 pobj.setCode(code);
		              	 pobj.setType(1);
		             
		              	 
		              	 session.setAttribute("member",member);
		              	 
		              	 
		              	 //选填项
		              	 int language= h.language;
		              	 
		              	 pobj.setZzracky(zzracky); 
		              	 pobj.setTelephone(telephone, language);
		              	 if(zzhkszd1!=null && zzhkszd1.length()>0 && zzhkszd0!=null && zzhkszd0.length()>0)
		              	 {
		              		
		              		int cid = Card.getCid(zzhkszd1);
		              		 pobj.setZzhkszd(String.valueOf(cid),language);
		              	 }
		              	
		              	 pobj.setPAddress(paddress,language);
		              	 
		              	 if(state0!=null && state0.length()>0 && state1!=null && state1.length()>0)
		              	 {
		              	 	
		              	 	int cid = Card.getCid(state1);
		              	 	pobj.setState(String.valueOf(cid), language);
		              	 }
		              	 
		              	 pobj.setOrganization(organization, language); 
		              	 pobj.setZip(zip, language);
		              	 pobj.setEmail(email);
		              	 pobj.setMsnID(msn);
		              	 pobj.setBelsell(belsell);
		              	 
		              	 
		              	 pobj.setMemberheight(memberheight);
		              	 pobj.setBallage(ballage);
		              	 pobj.setAlmostscore(almostscore);
		              	 pobj.setLikeitems(likeitems);
		              	 pobj.setHandfoot(handfoot);
		              	 pobj.setGdistance(gdistance);
		              	 pobj.setYhand(yhand);
		              	 pobj.setSwingrhythm(swingrhythm);
		              	 
		              	 
		              	  
		              	
		             	 pobj.setWST(tjmember, 0, null,null, 0, 0,null,0, 0,null, null, null,null, null,null);
		              	
						
		              	
		              	 
		              	 
						
						
			            	

						if(i%size==0)
						{
							out.print("<script>c.innerHTML="+(i)+"</script>");
							out.flush();
						}
	            	
	            	}
	            	if(sp2.toString()!=null && sp2.toString().length()>0)
					{
						out.print("<script>document.getElementById('ccc').innerHTML='不存在的用户名："+sp2.toString()+"'</script>");
						out.flush(); 
					}
	            	if(sp.toString()!=null && sp.toString().length()>0)
					{
						out.print("<script>document.getElementById('cc').innerHTML='不存在的会员编号："+sp.toString()+"'</script>");
						out.flush();
					}
	            	
	            	out.print("信息已经导入完毕，请点击<a href='###' onclick='window.close();'>这里</a>返回");
					out.flush();

				
					
				
				}
				
				


			
			
		}else//导入数据预览
		{
			out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");

			for(int i=0;i<s.getRows()&&i<21;i++)
			{
				out.print("<tr onMouseOver=this.bgColor='#BCD1E9' onMouseOut=this.bgColor=''>");
				for(int j=0;j<s.getColumns();j++)
				{
					String str=s.getCell(j,i).getContents();
					out.print("<td nowrap>"+("null".equals(str)?"&nbsp;":str));
				}
				out.print("</tr>");
				if(i==20)
				{
					out.print("<tr><td colspan=8>总行数为:"+s.getRows()+".   只显示前20行.......</td></tr>");
				}
			}
			out.print("</table>");
		}
		wb.close();
	}catch(Exception ex)
	{
		out.print("<table style=color:#FF0000 border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
		out.print("<tr><td>错误:  可能有以下原因导致</td></tr>");
		out.print("<tr><td>1.文件格式错误</td></tr>");
		out.print("<tr><td>2.列没有匹配,请按照预览的格式进行调整.</td></tr>");
		out.print("<tr><td>&nbsp;</td></tr>");
		out.print("<tr><td>描述:</td></tr>");
		out.print("<tr><td>"+ex.getMessage()+"</td></tr>");
		out.print("</table>");
		ex.printStackTrace();
//		response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件格式错误.","UTF-8"));
		return;
	}finally
	{
		bais.close();
	}
}
%>

</body>
</html>
