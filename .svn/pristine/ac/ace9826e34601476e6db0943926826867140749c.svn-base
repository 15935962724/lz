<%@page import="java.net.URLEncoder"%>
<%@page import="tea.entity.volunteer.Volunteer"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %><%@ page import="tea.db.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@page import="tea.entity.node.*" %><%@page import="tea.entity.women.*" %>
<%@ page import="java.util.*" %><%@page import="tea.entity.RV" %>
<%@page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);




String act = request.getParameter("act");

if("BjrrocEventRegName".equals(act))
{
	String community = teasession._strCommunity;

	if(teasession._rv==null)
	{
		out.println("您还没有登录，没有权限查看，请登录");
		return;
	}
	  String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

	StringBuffer sql=new StringBuffer(" and community = ").append(DbAdapter.cite(community));
	StringBuffer param=new StringBuffer();


	param.append("?community="+teasession._strCommunity).append("&node=").append(teasession._nNode);
	param.append("&id=").append(request.getParameter("id"));

		sql.append(" and exists (select member from Volunteer v where v.member = p.member  ) ");
		


		String firstname=teasession.getParameter("firstname");
		if(firstname!=null && firstname.length()>0)
		{
		  firstname=firstname.trim();
		  
		  sql.append(" and  exists (select member from ProfileLayer pl where p.member=pl.member and pl.firstname like "+DbAdapter.cite("%"+firstname+"%")+" ) ");
		  param.append("&firstname=").append(java.net.URLEncoder.encode(firstname,"UTF-8")); 
		}




	int pos=0,size = 10;
	if(request.getParameter("pos")!=null)
	{
	  pos=Integer.parseInt(request.getParameter("pos"));
	}
	param.append("&pos=").append(pos);

	int count = Profile.count(sql.toString());


	
	

	Event eobj = Event.find(teasession._nNode,teasession._nLanguage);

	



%>



<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;位注册志愿者&nbsp;)&nbsp;&nbsp;</h2>



<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
 <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
      <td nowrap>会员ID
      </td><td nowrap>姓名</td>
      <td nowrap>性别</td>
   
      
      <td nowrap>手机号</td>
  

      <TD NOWRAP>所在区县</TD>
       <TD NOWRAP>用户状态</TD> 
     
     

</tr>
<%
java.util.Enumeration eu = Profile.find(sql.toString(),pos,size);
if(!eu.hasMoreElements())
{
	out.print("<tr><td colspan=20 align=center><input type=button value=快速注册  onclick=f_r();></td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
	
  String member = String.valueOf(eu.nextElement());
  Profile pobj = Profile.find(member);
  Volunteer vt  =  Volunteer.find(member);
  Profile pro = Profile.find(member);
  String sexy = pro.isSex()?"男":"女";
  String cstring = null;
  if(pobj.getCity(teasession._nLanguage).matches("\\d+"))     //正则表达式 详细见java.util.regex 类 Pattern
  {
	  cstring = Volunteer.CITYS[Integer.parseInt(pobj.getCity(teasession._nLanguage))];
  }else
  {
	  cstring =pobj.getCity(teasession._nLanguage);
  }
 
 

  
  %>
<tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="" style="cursor:pointer" title="点击前面的选择框，就可以报名" >
   <td width=1><input type=checkbox name=membercheckbox value="<%=member%>"  <%if(eobj.getRegmember()!=null && eobj.getRegmember().length()>0 && eobj.getRegmember().indexOf("/"+member+"/")!=-1){out.print(" checked ");} %> style="cursor:pointer" onclick="f_checkbox('<%=member%>');"></td>
     
      <td nowrap="nowrap"><%=member%></td>
    <td nowrap="nowrap"><%=pro.getName(teasession._nLanguage)%></td>
    <td nowrap="nowrap"><%=sexy%></td>
  
    <td nowrap><%=pro.getMobile()%></td>

     <td><%=cstring %></td>
     <td><%
     	if(vt.getMembertype()==0)
     	{
     		out.println("新注册用户");
     	}else if(vt.getMembertype()==1)
     	{
     		out.println("老用户登记");
     	}else if(vt.getMembertype()==2)
     	{
     		out.println("老用户未登记");
     	}else if(vt.getMembertype()==3)
     	{
     		out.println("网站导入");
     	}
     %></td>

  </tr>
  <%
  }
  %>
  <% 
  	if(count>size){
  %>
  <tr><td colspan="20"  align="center" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
<%} %>
  </table>
<%}else if("BjrrocEventRegCheckbox".equals(act))	
{
	String member = teasession.getParameter("member");
	Node nobj = Node.find(teasession._nNode);
	Event eobj =Event.find(teasession._nNode,teasession._nLanguage);
	String str = "<font color=green>志愿者"+member+"报名成功</font>";
	if(eobj.getRegmember()!=null && eobj.getRegmember().length()>0 && eobj.getRegmember().split("/").length>1)
	{ 
		if(eobj.getRegmember().indexOf("/"+member+"/")!=-1)//有
		{
			String s = eobj.getRegmember().replaceAll("/"+member,"");
			eobj.setRegmember(s);
			eobj.setRegmember();
			str =  "<font color=red>志愿者"+member+"报名取消</font>";
			
			Profile pobj = Profile.find(member);
			
			pobj.setIntegral(pobj.getIntegral() - eobj.getIntegral());
			
		}else
		{
			String s = eobj.getRegmember()+member+"/";
			eobj.setRegmember(s);
			eobj.setRegmember();
			Profile pobj = Profile.find(member);
			
			pobj.setIntegral(pobj.getIntegral() + eobj.getIntegral());
		}
	}else
	{
		eobj.setRegmember("/"+member+"/");
		eobj.setRegmember();
	}
	out.println(str);
	return;
	
	
	
}
%>
