<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.entity.site.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/NetDisk");

int base=Integer.parseInt(request.getParameter("base"));
int filecenter=Integer.parseInt(request.getParameter("filecenter"));

//权限校检
int purview=FileCenterSafety.findByMember(filecenter,teasession._rv._strV);
if(purview==-1)
{
  response.sendError(403);
  return;
}

FileCenter obj=FileCenter.find(filecenter);
String word=obj.getWord();
obj.set(1);//只要进入这个页面 表示已经查看
CommunityOffice co=CommunityOffice.find(teasession._strCommunity);


IfNotRead.create(filecenter,teasession._rv._strV);

String code=obj.getCode();
String unit=obj.getUnit();

%><HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script type="text/javascript" src="/tea/applet/office/ocx.js"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>
function f_action(v)
{
  form1.filecenterattach.value=v;
  form1.submit();
}
</script>
</HEAD>
<body>

<h1><%=r.getString(teasession._nLanguage, "内容查看")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=obj.getAncestor(base)%></td>
  </tr>
</table>

<form name="form1" action="/servlet/EditFileCenter">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act" value="download">
<input type="hidden" name="base" value="<%=base%>">
<input type="hidden" name="filecenter" value="<%=filecenter%>">
<input type="hidden" name="filecenterattach">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="right" width="80"><%=r.getString(teasession._nLanguage, "主　　题")%></td>
    <td colspan="3">&nbsp;<%=obj.getSubject()%></td>
    </tr>
  <tr>
    <td align="right" width="80">　<%=r.getString(teasession._nLanguage, "文件编号")%></td>
    <td><%if(code!=null)out.print(code);%></td>
    <td align="right" nowrap ><%=r.getString(teasession._nLanguage, "下发日期")%></td>
    <td><%=obj.getMakeToString()%></td>
  </tr>
  <tr>
    <td align="right" width="80"><%=r.getString(teasession._nLanguage, "编制部门")%></td>
    <td><%if(unit!=null)out.print(unit);%></td>
    <td align="right" ><%=r.getString(teasession._nLanguage, "有 效 性")%></td>
    <td><%=obj.isValid()?"有效":"无效"%> </td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="ContentTable">
<tr>
  <td  style="padding:20px">

      <p>
        <%--
      <script>
      var ocx=ActionX("<%=co.getProductCaption()%>","<%=co.getProductKey()%>");
      <%
      if(word==null||word.length()==0)
      {
        out.print("ocx.CreateNew('Word.Document');");
      }else
      {
        out.print("ocx.OpenFromURL('"+word+"');");
      }
      %>
      ocx.ActiveDocument.ActiveWindow.ActivePane.DisplayRulers = false;
      ocx.Menubar=false;
      ocx.Titlebar=false;
      ocx.Statusbar=false;
      ocx.Toolbars=false;
      </script>
      --%>
        <%=obj.getContent()%> </p>
      <p>&nbsp; </p></td>

    </tr></table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
int fcaid=0,count=1;
StringBuffer sb=new StringBuffer();
Enumeration e2=FileCenterAttach.findByFileCenter(filecenter);
while(e2.hasMoreElements())
{
  fcaid=((Integer)e2.nextElement()).intValue();
  FileCenterAttach fca=FileCenterAttach.find(fcaid);
  sb.append("<td><div id='downimg'>"+(count++)+".　<img src=/tea/image/netdisk/"+fca.getEx()+".gif align=absmiddle style=margin-right:5 onerror=src='/tea/image/netdisk/default.gif';onerror=null;></div><a id='down' href=javascript:");
  if(purview==0)
  {
    sb.append("alert('无权下载');");
  }else
  {
    sb.append("f_action("+fcaid+");");
  }
  sb.append(">"+fca.getName()+"</a></td>");
  sb.append("<td>上传者:"+fca.getMember()+"</td><tr>");
}
out.print("<tr><td style=padding:15px valign=top width=\"80\" nowrap rowspan="+count+">附件：</td>"+sb.toString());
if(fcaid>0)
{
  out.print("<tr><td colspan=3><div align=left >注：CEB格式需用Apabi Reader 浏览。　<a href='http://www.apabi.cn/Reader/PRCReaderSetup.exe'><img src='/jsp/img/apabi-reader.gif' alt=下载ceb格式文档阅读器 align=absmiddle ></a></div>");
}
%>
</table>


<input type="button" value="批量下载" onclick="f_action(0)"/>
<input type="button" value="返回" onClick="history.back();">
</form>

</body>
</html>
