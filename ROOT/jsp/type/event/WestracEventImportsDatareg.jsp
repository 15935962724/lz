<%@page import="tea.entity.util.Card"%>

<%@page import="tea.entity.westrac.WestracIntegralLog"%>
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
            StringBuffer sp = new StringBuffer();
            StringBuffer sp2 = new StringBuffer();
			if("importprofile9000".equals(act))//导入
			{

				for(int i=1;i<s.getRows();i++)
				{
					String code = null;//会员编号
					String member=null;//用户名
					String mobile = null;//手机号
					String city0=null;//工作地省
					String city1=null;//现工作地市
					String address=null;//现工作地详细地址
					
					
					
					String catering=null;//是否安排餐饮
					String specials=null;//特殊要求
			
					String  stay =null;//是否需要安排住宿
					String roomnumber =null;//房间数
					String accoroom=null;//房间类型
					String accoother =null;//其他要求
				
					String  shuttle=null;//是否需要安排接送
					String  transport=null;//交通工具
					String  gotrainnumber=null;//去程&nbsp;车次
					String  reachtime=null;//到达日期
					String  reachtimedate=null;//      到达时间
					String  returnrainnumber=null;//返程&nbsp;车次
					String  returntime=null;//到达日期
					String  returntimedate=null;//到达时间
					String  confirmtype=null;//是否到会
				
					
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
							mobile=cellToString(s.getCell(j,i));
							break;
						case 3:
							city0=cellToString(s.getCell(j,i));
							break;
						case 4:
							city1=cellToString(s.getCell(j,i));
							break;
						case 5:
							address=cellToString(s.getCell(j,i));
							break;
						case 6:
							catering=cellToString(s.getCell(j,i));
							break;
						case 7:
							specials=cellToString(s.getCell(j,i));
							break;
						case 8:
							stay=cellToString(s.getCell(j,i));
							break;
						case 9:
							roomnumber=cellToString(s.getCell(j,i));
							break;
						case 10:
							accoroom=cellToString(s.getCell(j,i));
							break;
						case 11:
							accoother=cellToString(s.getCell(j,i));
						case 12:
							shuttle=cellToString(s.getCell(j,i));
							break;
						case 13:
							transport=cellToString(s.getCell(j,i));
							break;
						case 14:
							gotrainnumber=cellToString(s.getCell(j,i));
							break;
						case 15:
							reachtime=cellToString(s.getCell(j,i));
							break;
						case 16:
							reachtimedate=cellToString(s.getCell(j,i));
							break;
						case 17:
							returnrainnumber=cellToString(s.getCell(j,i));
							break;
						case 18:
							returntime=cellToString(s.getCell(j,i));
							break;
						case 19:
							returntimedate=cellToString(s.getCell(j,i));
							break;
						case 20:
							confirmtype=cellToString(s.getCell(j,i));
							break;
						

						}
						a++;
					}
					
				
					if(!Profile.isExisted(member))
					{
						sp.append(member).append("<br>");
						continue;
					}  
					
					int regid = Eventregistration.getErid(teasession._nNode,member,teasession._strCommunity);
					
					Eventregistration erobj = Eventregistration.find(regid);
					
					
					if(erobj.isExists())
					{
						sp2.append(member).append("<br>");
						continue;
					}
					//现工作地
					int city = 0;
					 if((city1!=null && city1.length()>0) && (city0!=null && city0.length()>0))
					 {
						 city = Card.getCid(city1);
	              	 }
					
					 //是否安排餐饮
					 int catering_int =0;//是
					 if("否".equals(catering))
					 {
						 catering_int = 1;
						 specials=null;
					 }
					
					
					//是否需要安排住宿
					
					int stay_int = 0;
					int roomnumber_int=0,accoroom_int=0;
					if("否".equals(stay))
					{
						  stay_int=1;
						  roomnumber_int=0;//房间数
						
						  accoroom_int=0;//房间类型
						  accoother=null;//其他要求
					}else
					{
						roomnumber_int = Integer.parseInt(roomnumber);
						accoroom_int = Integer.parseInt(accoroom);
					}
					 
					
					int shuttle_int = 0;
					int transport_int = 0;
					Date reachtime_date = null,returntime_date=null;
					
					
					if("否".equals(shuttle))
					{
						shuttle_int = 1;
						gotrainnumber=null;
						reachtimedate=null;
						returnrainnumber=null;
						returntimedate=null;
						
					}else
					{
						if("火车".equals(transport))
						{
							transport_int=0;
						}else if("飞机".equals(transport))
						{
							transport_int=1;
						}else if("长途汽车".equals(transport))
						{
							transport_int=2;
						}
						if(reachtime!=null && reachtime.length()>0)
						{
							reachtime_date = Entity.sdf.parse(reachtime);
						}
						if(returntime!=null && returntime.length()>0)
						{
							returntime_date = Entity.sdf.parse(returntime);
						}
					}
					 
					int confirmtype_int=0;
					if("是".equals(confirmtype))
					{
						confirmtype_int = 1;
						//
						//到会
						Profile p = Profile.find(member);
						Event ev = Event.find(teasession._nNode,teasession._nLanguage);
						Node nobj = Node.find(teasession._nNode);
						p.setMyintegral(p.getMyintegral()+ev.getIntegral()); 
						WestracIntegralLog.create(member,0,nobj.getSubject(teasession._nLanguage),teasession._nNode,ev.getIntegral(),null,new Date(),0,teasession._strCommunity);
						
						
						
					}else
					{
						confirmtype_int=2; 
						
						Profile p = Profile.find(member);
						Event ev = Event.find(teasession._nNode,teasession._nLanguage);
						Node nobj = Node.find(teasession._nNode);
						 
						p.setMyintegral(p.getMyintegral()-ev.getIntegral());
						WestracIntegralLog.create(member,1,nobj.getSubject(teasession._nLanguage),teasession._nNode,0,null,new Date(),-ev.getIntegral(),teasession._strCommunity);
					}
					
	            		regid=Eventregistration.create(teasession._nNode, member, mobile, address, null, 1, 0, 
	            				stay_int, null, 0, 
	            				0, accoroom_int, null, accoother, shuttle_int, transport_int, gotrainnumber, 
	            				reachtime_date, reachtimedate, returnrainnumber, returntime_date, 
	            				returntimedate, teasession._strCommunity, new Date(),catering_int,specials,roomnumber_int,String.valueOf(city));
	            		
	            		
	            		
	            			Eventregistration.find(regid).setVerifg(1);
	            			Eventregistration.find(regid).setConfirmtype(confirmtype_int);
	            		
	            		Profile pobj = Profile.find(member);
		            	
		            	pobj.setMobile(mobile); 
		        
		            	
		            	
		            	

						if(i%size==0)
						{
							out.print("<script>c.innerHTML="+(i)+"</script>");
							out.flush();
						}

		            	
					
	            	
	            	}
	            	if(sp2.toString()!=null && sp2.toString().length()>0)
					{
						out.print("<script>document.getElementById('ccc').innerHTML='已经报名的会员："+sp2.toString()+"'</script>");
						out.flush(); 
					}
	            	if(sp.toString()!=null && sp.toString().length()>0)
					{
						out.print("<script>document.getElementById('cc').innerHTML='不存在的会员："+sp.toString()+"'</script>");
						out.flush();
					}
	            	
	            	out.print("信息已经导入完毕，请点击<a href='###' onclick='window.close();'>这里</a>返回");
					out.flush();
					
					
			
    
			

		//	out.print("<script>alert('信息导入成功!');window.open('"+nexturl+"','_parent');</script>"); 
				
					
				
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
