<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.member.*" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Workreport");


%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<base href="http://<%=request.getServerName()%>/"/>
<style>
<%=Community.find(teasession._strCommunity).getCss(application.getRealPath("/"))%>
</style>
<link href="http://<%=request.getServerName()%>/tea/CssJs/<%=teasession._strCommunity%>.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<div style="width:677px;">
<!--1170218830203=电话记录-->
<h1><%=r.getString(teasession._nLanguage,"1170218830203")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table  style="width:677px;">
<tr><td style="width:500px;" align="left">
     <%
     String worktels[]=request.getParameterValues("worktel");
     if(worktels!=null)
     {
       StringBuffer html=new StringBuffer();
       for(int index=0;index<worktels.length;index++)
       {
       int worktel=Integer.parseInt(worktels[index]);
       Worktel obj=Worktel.find(worktel);
       Profile worklinkman=Profile.find(obj.getWorklinkman());
       Profile p=Profile.find(obj.getMember());
       %>

         <table border="0" cellpadding="0" cellspacing="0" >
           <tr><td nowrap colspan="2"><%=obj.getCtimeToString()%></td>
             <td nowrap><%=worklinkman.getLastName(teasession._nLanguage)+worklinkman.getFirstName(teasession._nLanguage)%></td>
             <td nowrap>单位:<%if(obj.getWorkproject()>0)out.print(Workproject.find(obj.getWorkproject()).getName(teasession._nLanguage));%></td>
             <td nowrap><%=r.getString(teasession._nLanguage,obj.isTeltype()?"1170212958984":"1170212966468")%></td>
             <td nowrap>号码:<%=obj.getTelephone()%></td>
           </tr>
           <tr><td>&nbsp;</td></tr>
           <tr><td nowrap>通话内容:</td><td>&nbsp;</td></tr>
           <tr><td colspan="6"><%=obj.getContent(teasession._nLanguage).replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")%></td></tr>
             <tr><td>&nbsp;</td></tr>
            <tr><td nowrap><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)%></td>
         <td nowrap colspan="4">此内容通知以下人员:
           <%
           String is[]= obj.getImember().split("/");
           for(int i=0;i<is.length;i++)
           {
             if(is[i].length()>0)
             {
               p=Profile.find(is[i]);
               out.print(p.getLastName(teasession._nLanguage));
               out.print(p.getLastName(teasession._nLanguage));
               out.print(" ");
             }
           }
           %>
         </td>
         <td nowrap>
         <%
         if(obj.getCtime().getTime()!=obj.getUtime().getTime())
         {
           out.print("最后修改时间:");
           out.print(obj.getUtimeToString());
         }
         %>
         </td>
         </tr>
         </table>
         <br>
<hr size="1" />
<br>
<%    }
}
%>

</td>
<td valign="top">

<table width="100%"  border="0" cellpadding="5" cellspacing="0">
  <tr>
    <th  align="left" bgcolor="#999999" style="color:#FFFFFF;font-size:150%">常用网址链接</th>
    </tr>
  <tr>
    <td bgcolor="#CCCCCC">
    <ol>
      <li><a href="http://www.google.cn" target="_blank">GOOGLE中国</a>
        <li><a href="http://map.redcome.com" target="_blank">站点地图</a>
    </ol>
  </td>
    </tr>
</table>
<table width="100%"  border="0" cellpadding="5" cellspacing="0">
  <tr>
    <th  align="left" bgcolor="#999999" style="color:#FFFFFF;font-size:150%">公司公告</th>
    </tr>
  <tr>
    <td bgcolor="#CCCCCC">
    <ol>
      没有公告
    </ol>
  </td>
    </tr>
</table>


</td>
</tr>
</table>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</div>

</body>
</html>


<%--









<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="fload();">
<!--1170218830203=电话记录-->
<h1><%=r.getString(teasession._nLanguage,"1170218830203")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"></td>
     <!--时间-->
     <td nowrap><%=r.getString(teasession._nLanguage,"Time")%></td>
     <td nowrap><%=r.getString(teasession._nLanguage,"Text")%></td>
     <td nowrap><%=r.getString(teasession._nLanguage,"1168584443703")%></td>
     <td nowrap><%=r.getString(teasession._nLanguage,"1168584403266")%></td>
     <td nowrap><%=r.getString(teasession._nLanguage,"1168592903313")%></td>
     <td nowrap><%=r.getString(teasession._nLanguage,"1170213683406")%></td>
     <!--1170217759890=是否修改过/修改时间-->
     <td nowrap><%=r.getString(teasession._nLanguage,"1170217759890")%></td>
     </tr>

     <%
     String worktels[]=request.getParameterValues("worktel");
     if(worktels!=null)
     {
       StringBuffer html=new StringBuffer();
       for(int index=0;index<worktels.length;index++)
       {
         int worktel=Integer.parseInt(worktels[index]);
         Worktel obj=Worktel.find(worktel);

         html.append("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" >");

         html.append("<td width=\"1\">"+(index+1)+"</td>");


         html.append("<td noWrap>&nbsp;"+obj.getCtimeToString()+"</td>");

         html.append("<td>&nbsp;");
         String log_content=obj.getContent(teasession._nLanguage).replaceAll("</","&lt;/");
         if(log_content.length()>25)
         html.append("<textarea style=display:none id=content_"+worktel+" >"+log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")+"</textarea><a href=\"javascript:var obj=window.open('','','height=250,width=500,left=400,top=300,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');obj.document.write(document.getElementById('content_"+worktel+"').value);\" >"+log_content.substring(0,25)+"...</a>");//&#39;
         else
         html.append(log_content);
         html.append("</td>");

         html.append("<td>&nbsp;");
         if(obj.getWorkproject()>0)
         html.append(Workproject.find(obj.getWorkproject()).getName(teasession._nLanguage));
         html.append("</td>");

         html.append("<td>&nbsp;");
         if(obj.getWorklinkman()!=null)
         html.append(obj.getWorklinkman());
         html.append("</td>");

         html.append("<td>&nbsp;").append(r.getString(teasession._nLanguage,obj.isTeltype()?"1170212958984":"1170212966468")).append("</td>");//来电/去电

         html.append("<td>&nbsp;").append(obj.getImember()).append("</td>");



         html.append("<td>&nbsp;");
         if (obj.getCtime().getTime() != obj.getUtime().getTime())
         {
           html.append(obj.getUtimeToString()); //是否修改过/修改时间
         }

       }
       out.print(html.toString());
     }
%>
</table>





<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>












--%>


