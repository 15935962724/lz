<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="java.awt.image.*" %>
<%@page import="javax.imageio.*" %>
<%@page import="java.math.BigDecimal" %>
<%@ page import="tea.html.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="tea.htmlx.*"%>
<%
TeaSession teasession = new TeaSession(request);
StringBuffer sql = new StringBuffer();


int nodes =0;
if(teasession.getParameter("nodes")!=null && teasession.getParameter("nodes").length()>0)
{
  nodes = Integer.parseInt(teasession.getParameter("nodes"));
}
String picture="/res/"+teasession._strCommunity+"/picture/"+nodes+".jpg";

String pathname="";
Baudit baudit =  Baudit.find(nodes);
File exla=new File(application.getRealPath(picture));
if(exla.isFile())
{
  pathname=exla.getPath();
}
//String strAbsPath=new java.io.File(application.getRealPath(request.getRequestURI())).getParent();
StringBuffer param = new StringBuffer();
String update = request.getParameter("update");
if(update!=null&&update.length()>0)
{
  param.append("&update="+update);
}
String member = request.getParameter("member");
if(member!=null&&member.length()>0)
{
  param.append("&member="+member);
}
String firstname = request.getParameter("firstname");
if(firstname!=null&&firstname.length()>0)
{
  param.append("&firstname="+firstname);
}
String pos = request.getParameter("pos");
if(pos!=null&&pos.length()>0)
{
  param.append("&pos="+pos);
}

String pg = request.getParameter("passpage");
if(pg!=null&&pg.length()>0)
{
  param.append("&passpage="+pg);
}



%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <script type="" LANGUAGE=JAVASCRIPT>
  function f_submit()
  {
    if(form1.mediaref.value==null || form1.mediaref.value=="")
    {
      alert("请填写媒体引用");
      return false;
    }
    if(form1.mediatype.value==0)
    {
      alert("无效媒体类型！");
      return false;
    }
      if(form1.error.value==0)
    {
      alert("选择是否错误！");
      return false;
    }
      if(form1.passpage.value==0)
    {
      alert("请选择是否通过审核！");
      return false;
    }
  }

  </script>
  <title>审核图片信息</title>
</head>
<body>
<div id="wai">
<h1>审核图片信息</h1>
<form  action="/servlet/EditBPperson"   method="post" name="form1" onSubmit="return f_submit();">
<input type="hidden"  value="EditAuditPicture" name="act"/>
<input  type="hidden" value="<%=nodes%>" name="nodes">
<input type="hidden" value="<%=baudit.getMember()%>" name="member" />
<input type="hidden" name="param" value="<%=param.toString()%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <!--<tr><td>媒体引用</td><td>-->
    <input type="hidden" name="mediaref" size="12" value="<%if(baudit.getMediaref()!=null && baudit.getMediaref().length()>0){out.print(baudit.getMediaref());}%>xxxx" />
  <tr><td width="300" align="right">上传类型</td><td>
    <select name="mediatype">
    <%
    for(int i=0;i<Baudit.MEDIATYPE.length;i++)
    {
      out.print("<option value="+i);
      if(i/*baudit.getMediatype()*/==1)
      {
        out.print(" selected");
      }
      out.print(">"+Baudit.MEDIATYPE[i]+"</option>");
    }
    %>
    </select>
  </td></tr>
  <tr><td align="right">错误</td><td>
    <select name="error">
    <%
    for(int i=0;i<Baudit.ERROR.length;i++)
    {
      out.print("<option value="+i);
      if(i/*baudit.getError()*/==2)
      {
        out.print(" selected");
      }
      out.print(">"+Baudit.ERROR[i]+"</option>");
    }
    %>
    </select>
    </td></tr>
  <tr><td align="right">通过</td><td>
    <select name="passpage">
    <%
    for(int i=0;i<Baudit.PASSPAGE.length;i++)
    {
      out.print("<option value="+i);
      if(i/*baudit.getPasspage()*/==1)
      {
        out.print(" selected");
      }
      out.print(">"+Baudit.PASSPAGE[i]+"</option>");
    }
    %>
    </select>
  </td></tr>
  <tr><td align="right">状态</td><td>
    <select name="statussss">
    <%
    for(int i=0;i<Baudit.STATUS.length;i++)
    {
      out.print("<option value="+i);
      if(i/*baudit.getStatus()*/==2)
      {
        out.print(" selected");
      }
      out.print(">"+Baudit.STATUS[i]+"</option>");
    }
    %>
    </select></td></tr>
    <tr><td><img alt="" width="240" src="<%=picture%>" /></td><td>路径：<%=pathname%></td></tr>
  <tr><td align="right"><input  type="submit"  value="审核" /></td><td><input  onclick="window.history.back();" type="button"  value="返回" /></td></tr>
</table>
</form>
</div>
</body>
</html>
