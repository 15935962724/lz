<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"  %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Other");

CommunityOption obj=CommunityOption.find(teasession._strCommunity);
String ykpid=obj.get("ykpid");
if(ykpid==null)
{
  ykpid="";
}
int yktype=obj.getInt("yktype");
if(yktype==2)
{
  yktype=1;
}
String ykreurl=obj.get("ykreurl");
if(ykreurl==null)
{
  ykreurl="";
}




%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="form1.synchost.focus();">
<h1><%=r.getString(teasession._nLanguage, "优酷设置")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" action="/servlet/EditCommunityOption" target="_ajax" method="post">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="name" value="/ykpid/yktype/ykreurl">
<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"合作商编号")%></td>
    <td><input name="ykpid" value="<%=ykpid%>"></td>
    <td></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"类型")%></td>
    <td>
      <select name="yktype">
      <%
     for(int i=1 ;i<3;i++)
     {
        out.print("<option value="+i);
       if(yktype==i)
       {
         out.print("selected");

       }
         out.print(">");
         if(i==2)
         {
          out.print("转向url");
         }
         else
         {
          out.print("直接输出结果");
         }
        out.print("</option>");


     }

      %>

</select>

    </td>

      <td></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"回调的URL")%></td>
    <td><input name="ykreurl" value="<%=ykreurl%>" ></td>
    <td></td>
  </tr>
</table>
<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
