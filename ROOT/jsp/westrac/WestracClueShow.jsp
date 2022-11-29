<%@page import="tea.entity.util.Card"%>
<%@page import="tea.entity.westrac.WestracClue"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String nexturl = teasession.getParameter("nexturl");

Http h = new Http(request);
int wcid = h.getInt("wcid");

WestracClue wcobj = WestracClue.find(wcid);


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
</head>

<body>


<form name="formwc" method="POST" action="/servlet/EditWestracClue" >



 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
      <td colspan="2" >个人基本信息</td>
   
    </tr>
  
  
    
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;姓名：</td>
      <td><%=Entity.getNULL(wcobj.getWcname()) %></td>
    </tr> 
     
      <tr>
      <td align="right"><span id="btid">*</span>&nbsp;移动电话：</td>
      <td><%=Entity.getNULL(wcobj.getMobile()) %></td>
    </tr>
    <tr>
      <td colspan="2" >销售线索信息</td>
   
    </tr>
	 <tr>
      <td align="right">所属行业：</td>
      <td><%=WestracClue.INDUSTRYS_TYPE[wcobj.getIndustrys()] %></td>
    </tr>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;购买人名称：</td>
      <td><%=Entity.getNULL(wcobj.getClientname()) %></td>
    </tr>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;联系人姓名：</td>
      <td><%=Entity.getNULL(wcobj.getContactname()) %></td>
    </tr>
     <tr>
      <td align="right">公司电话：</td>
      <td><%=Entity.getNULL(wcobj.getPhone()) %></td>
    </tr>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;移动电话：</td>
      <td><%=Entity.getNULL(wcobj.getClientmobile()) %></td>
    </tr>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;购买人所在地：</td>
      <td><%
      if(wcobj.getCity()!=null && wcobj.getCity().length()>0)
      {
    	  Card cobj = Card.find(Integer.parseInt(wcobj.getCity()));
    	  
    		out.print(cobj.toString2());
      }
      	
      %>
      
     </td>
    </tr>
     <tr>
      <td align="right">预计购买日期：</td>
      <td><%if(wcobj.getBuytime()!=null)out.print(Entity.sdf.format(wcobj.getBuytime())); %>
        </td>
    </tr>
     <tr>
      <td align="right">购买需求描述：</td>
      <td><%=Entity.getNULL(wcobj.getRemarks()) %></td>
    </tr>
  </table>

<br>
  <center> 

 <INPUT TYPE="button"  VALUE="返回" onclick="parent.ymPrompt.close();">&nbsp;


  
  
</center></form>


</body>
</html>

