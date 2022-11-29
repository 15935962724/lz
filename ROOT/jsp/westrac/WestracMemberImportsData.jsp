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
		if(teasession.getParameter("imports")!=null&&"2".equals(teasession.getParameter("imports")))//点击 导入执行下面代码
		{
			out.println("总行数:"+s.getRows()+" 正在导入:<span id=c >0</span><br>");
			out.println("<span id=cc></span>"); 
			out.println("<span id=ccc></span><br>"); 
			out.println("<span id=cccc></span><br>"); 
			out.println("<span id=ccccc></span><br>"); 
			out.println("<span id=cccccc></span><br>"); 
			out.flush();
            int size=s.getRows()/100;
            if(size<1)
            size=1;
            Date time=new Date();
            Event eobj = Event.find(teasession._nNode,teasession._nLanguage);
            StringBuffer sp = new StringBuffer();//判断没有的会员编号
            StringBuffer sp2 = new StringBuffer();//判断没有的用户名
            StringBuffer sp3 =new StringBuffer();//有重复的身份证
            StringBuffer sp4 =new StringBuffer();//有重复的手机号
            StringBuffer sp5 =new StringBuffer();//姓名不能为空
			if("importprofile9000".equals(act))//导入
			{

				for(int i=1;i<s.getRows();i++)
				{
					String code = null;//会员编号
					String member=null;//用户名
					String membername =null;//姓名
					String sex = null;//性别
					String card =null;//身份证号
					String mobile=null;//手机
					String birth=null;//生日
					String city0=null;//现工作地（省）
					String city1=null;//现工作地（市）
					String address=null;//现工作地（详细地址）
					String verifytype=null;//审核后身份类型
					
					String zzracky=null;//民族
					
					String degree=null;//学历
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
					String sfshanggang=null;//是否有上岗证
					String fazhengjiguan=null;//发证机关
					String caozuonianxian=null;//操作年限
					String xpinpai=null;//现操作机型品牌
					String xxinghao=null;//现操作机型型号
					String xqita=null;//现操作机型其他
					String cpinpai=null;//曾操作机型品牌
					String cxinghao=null;//曾操作机型型号
					String cqita=null;//曾操作机型其他
					String jzname =null;//机主相关-姓名
					String jzxinghao=null;//机主相关-型号
					String jzxuliehao=null;//机主相关-序列号
					String jzlianxi=null;//机主相关-联系方式
					String aihao=null;//爱好
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
								card=cellToString(s.getCell(j,i));
								break;
							case 5:
								mobile=cellToString(s.getCell(j,i));
								break;
							case 6:
								birth=cellToString(s.getCell(j,i));
								break;
							case 7:
								city0=cellToString(s.getCell(j,i));
								break;
							case 8:
								city1=cellToString(s.getCell(j,i));
								break;
							case 9:
								address=cellToString(s.getCell(j,i));
								break;
							case 11:
								zzracky=cellToString(s.getCell(j,i));
								break;
							case 10:
								verifytype=cellToString(s.getCell(j,i));
								break;
							case 12:
								degree=cellToString(s.getCell(j,i));
								break;
							case 13:
								telephone=cellToString(s.getCell(j,i));
								break;
							case 14:
								zzhkszd0=cellToString(s.getCell(j,i));
								break;
							case 15:
								zzhkszd1=cellToString(s.getCell(j,i));
								break;
							case 16:
								paddress=cellToString(s.getCell(j,i));
								break;
							case 17:
								state0=cellToString(s.getCell(j,i));
								break;
							case 18:
								state1=cellToString(s.getCell(j,i));
								break;
							case 19:
								organization=cellToString(s.getCell(j,i));
								break;
							case 20:
								zip=cellToString(s.getCell(j,i));
								break;
							case 21:
								email=cellToString(s.getCell(j,i));
								break;
							case 22:
								msn=cellToString(s.getCell(j,i));
								break;
							case 23:
								tjmember=cellToString(s.getCell(j,i));
								break;
							case 24:
								tjmember2=cellToString(s.getCell(j,i));
								break;
							case 25:
								sfshanggang=cellToString(s.getCell(j,i));
								break;
							case 26:
								fazhengjiguan=cellToString(s.getCell(j,i));
								break;
							case 27:
								caozuonianxian=cellToString(s.getCell(j,i));
								break;
							case 28:
								xpinpai=cellToString(s.getCell(j,i));
								break;
							case 29:
								xxinghao=cellToString(s.getCell(j,i));
								break;
							case 30:
								xqita=cellToString(s.getCell(j,i));
								break;
							case 31:
								cpinpai=cellToString(s.getCell(j,i));
								break;
							case 32:
								cxinghao=cellToString(s.getCell(j,i));
								break;
							case 33:
								cqita=cellToString(s.getCell(j,i));
								break;
							case 34:
								jzname=cellToString(s.getCell(j,i));
								break;
							case 35:
								jzxinghao=cellToString(s.getCell(j,i));
								break;
							case 36:
								jzxuliehao=cellToString(s.getCell(j,i));
								break;
							case 37:
								jzlianxi=cellToString(s.getCell(j,i));
								break;
							case 38:
								aihao=cellToString(s.getCell(j,i));
								break;
							case 39:
								belsell=cellToString(s.getCell(j,i));


						} 
						a++;
				
					}
					
					
					//必须有姓名
					
					if(membername!=null && membername.length()>0){}else
					{
						if(sp5.toString()!=null && sp5.toString().length()>0){}else{
							sp5.append("姓名字段有空的记录，系统不做导入，请手动检查<br>");
						}
						continue; 
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
				   
				   //重复的身份证
				   if(Profile.isCard(teasession._strCommunity,card))
				   {
					   Profile p = Profile.find(Profile.getCardMember(teasession._strCommunity,card));
					   member = p.getMember();
					   code = p.getCode();
					   sp3.append(member).append("<br>");
					   
				   }
				   //重复的手机号
				      if(Profile.isMobile(teasession._strCommunity,mobile))
				   {
					   Profile p = Profile.find(Profile.getMember_moblie(mobile));
					   member = p.getMember();
					   code = p.getCode();
					   sp4.append(member).append("<br>");
					   
				   }
				   

				   
				   if(!Profile.isCode(code)&& !Profile.isExisted(member))//用户名和会员编号都正确才能修改 
				   {
					   Profile.create(member,"123456",teasession._strCommunity,null,request.getServerName());
				   }
		              	 Profile pobj = Profile.find(member);
		              	 
		              	 // pobj.setMembertype(1);//直接是审核通过
		              	 pobj.setMembertype(2);//导入时候 是未审核状态
		              	 pobj.setImptype(1);//会员导入类型
		              	 
		              	 
		              	  Http h=new Http(request);
		              	 pobj.setFirstName(membername, teasession._nLanguage);
		              	 
		              	 pobj.setSex(sex=="女"?true:false);
		              	 pobj.setCard(card);
		              	 pobj.setMobile(mobile);
		              	 System.out.println(birth);
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
		              	 
		              	 //核实后身份"机主","机手","设备管理人员","技术管理人员","与行业相关","无效"
		              	 int verifytypes=0;
		              	 if(verifytype.trim().equals("机主")){
		              	 	verifytypes=1;
		              	 }else if(verifytype.trim().equals("机手")){
		              	 	verifytypes=2;
		              	 }else if(verifytype.trim().equals("设备管理人员")){
		              	 	verifytypes=3;
		              	 }else if(verifytype.trim().equals("技术管理人员")){
		              	 	verifytypes=4;
		              	 }else if(verifytype.trim().equals("与行业相关")){
		              	 	verifytypes=5;
		              	 }else if(verifytype.trim().equals("无效")){
		              	 	verifytypes=6;
		              	 }else{
		              	 	verifytypes=0;
		              	 }
		              	 pobj.setVerifytype(verifytypes);
		              	 //选填项
		              	 int language= h.language;
		              	 
		              	 pobj.setZzracky(zzracky); 
		              	//{"无","小学","中学","大专","本科","硕士","博士","其他"};
		              	 String di= "0";
		              	 if("".equals(degree) || "无".equals(degree))
		              	 {
		              		di="0";
		              	 }else if("小学".equals(degree))
		              	 {
		              		di="1";
		              	 }else if("中学".equals(degree))
		              	 {
			              		di="2";
			              }else if("大专".equals(degree))
			              {
			              		di="3";
			              }else if("本科".equals(degree))
			              {
			              		di="4";
			              }else if("硕士".equals(degree))
			              {
			              		di="5";
			              }else if("博士".equals(degree))
			              {
			              		di="6";
			              }else if("其他".equals(degree))
			              {
			              		di="7";
			              }else 
			              {
			            	  di="7";
			              }
		              	  
		              	 pobj.setDegree(di,language);
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
		              	  
		              	 
		              	 int xpp = 0;
		              	 if(xpinpai!=null && xpinpai.length()>0)
		              	 {
		              		 xpp = WomenOptions.getWoid(teasession._strCommunity,xpinpai," and type =0 ");
		              	 }
		              	 int xxh = 0;
		              	 if(xxinghao!=null && xxinghao.length()>0)
		              	 {
		              		 xxh = WomenOptions.getWoid(teasession._strCommunity,xxinghao," and type !=0 ");
		              	 }
		              	 int cpp = 0;
		              	 if(xpinpai!=null && xpinpai.length()>0)
		              	 {
		              		cpp = WomenOptions.getWoid(teasession._strCommunity,cpinpai," and type =0 ");
		              	 }
		              	 int cxh = 0;
		              	 if(xxinghao!=null && xxinghao.length()>0)
		              	 {
		              		cxh = WomenOptions.getWoid(teasession._strCommunity,cxinghao," and type !=0 ");
		              	 }
		              	// int wsttype,String wstmodel;
                       
		              	 pobj.setWST(tjmember, "是".equals(sfshanggang)?0:1, fazhengjiguan, caozuonianxian, 
		              			 xpp, xxh,xqita, cpp, cxh,cqita, jzname, jzxinghao, jzxuliehao, jzlianxi,aihao,0,"");
						
		              	
		              	 
		              	 
						
						
			            	

						if(i%size==0)
						{
							out.print("<script>c.innerHTML="+(i)+"</script>");
							out.flush();
						}
	            	
	            	}
				if(sp5.toString()!=null && sp5.toString().length()>0)
				{
					out.print("<script>document.getElementById('cccccc').innerHTML='"+sp5.toString()+"'</script>");
					out.flush(); 
				}
				 
				if(sp4.toString()!=null && sp4.toString().length()>0)
				{
					out.print("<script>document.getElementById('ccccc').innerHTML='重复的手机号用户名：<br>"+sp4.toString()+"'</script>");
					out.flush(); 
				}
				if(sp3.toString()!=null && sp3.toString().length()>0)
				{
					out.print("<script>document.getElementById('cccc').innerHTML='重复的身份证用户名：<br>"+sp3.toString()+"'</script>");
					out.flush(); 
				}
				
				
	            	if(sp2.toString()!=null && sp2.toString().length()>0)
					{
						out.print("<script>document.getElementById('ccc').innerHTML='不存在的用户名：<br>"+sp2.toString()+"'</script>");
						out.flush(); 
					}
	            	if(sp.toString()!=null && sp.toString().length()>0)
					{
						out.print("<script>document.getElementById('cc').innerHTML='不存在的会员编号：<br>"+sp.toString()+"'</script>");
						out.flush();
					}
	            	
	            	out.print("信息已经导入完毕，请点击<a href='###' onclick='window.close();'>这里</a>返回");
					out.flush();

				
					
				
				}
				
				


			
			
		}else//导入数据预览
		{
			out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
			int ics = 0;

			for(int i=0;i<s.getRows()&&i<21;i++)
			{
				String membername =null;//姓名
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
		out.print("</table><script>parent.ymPrompt.close();</script>");
		ex.printStackTrace();
//		response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件格式错误.","UTF-8"));
		return;
	}finally
	{
		bais.close();
	}
}
%>
<script>parent.ymPrompt.close();</script>
</body>
</html>
