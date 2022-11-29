<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.text.*"%>

<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.db.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>



<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
Node nobj = null;
Logo obj = new Logo();
String logoname = null,content=null;
String nid = teasession.getParameter("logoid");
if(nid != null){
  if(!nid.equals("")){
    nobj = Node.find(Integer.parseInt(teasession.getParameter("logoid")));
    obj = Logo.find(Integer.parseInt(teasession.getParameter("logoid")));
    logoname = nobj.getSubject(teasession._nLanguage);
    content=Logo.getHtml(nobj.getText(teasession._nLanguage));
  }
}
else{

}





//if(!"ON".equals(teasession.getParameter("NewNode")))
//{
//  if(teasession.getParameter("logoid") != null && !("").equals(teasession.getParameter("logoid"))){
//    nobj = Node.find(Integer.parseInt(teasession.getParameter("logoid")));
//    obj = Logo.find(Integer.parseInt(teasession.getParameter("logoid")));
//  }
//  else{
//    nobj = Node.find(teasession._nNode);
//    obj = Logo.find(teasession._nNode);
//  }
//  logoname = nobj.getSubject(teasession._nLanguage);
//  content=Logo.getHtml(nobj.getText(teasession._nLanguage));
//}



%>
<HTML>
<HEAD>

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>商标</title>
</HEAD>

<script type="text/javascript">

</script>
<BODY>
<h1>商标</h1>
<form name="form1" action="LogoServlet.jsp" method="POST" enctype=multipart/form-data >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="language" value="<%=teasession._nLanguage%>">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="act" value="EditLogo">
<input type="hidden" name="logoid" value="<%=teasession.getParameter("logoid")%>">
<table id="tablecenter">
  <tr>
    <td align="right">
      商标类别：
    </td>
    <td>
      <select style="width:480;" name="logotype">

      <%
      	 for(int i =1;i<Logo.LOGO_TYPE.length;i++)
      	 {

      		 out.print("<option value = "+i);
      		 if(obj.getLogotype()!=null && obj.getLogotype().length()>0&& Integer.parseInt(obj.getLogotype())==i)
      		 {
      			out.print(" selected ");
      		 }
      		 out.print(">"+Logo.LOGO_TYPE[i]);
      		 out.print("</option>");
      	 }
      %>

      </select>
    </td>
  </tr>
  <tr>
    <td align="right">
      商标名称：
    </td>
    <td>
      <input type="text" name="logoname" value="<%if(logoname!=null){out.print(logoname);}%>">
    </td>
  </tr>
  <tr>
    <td align="right">
      商标图形：
    </td>
    <td>
    <%

    int len=0;
    if(obj.getLogoimage()!=null && obj.getLogoimage().length()>0)
    {
    	len= (int)new java.io.File(application.getRealPath(obj.getLogoimage())).length();
    }

    %>
      <input type="file" name="logoimage" >
      <%
      if(len>0)
      {
        out.print("<a href='"+obj.getLogoimage()+"' target='_blank'>"+len +"&nbsp;字节</a>&nbsp;");
        out.print("<input id='checkbox' type='checkbox' name='clearlogoimage' onclick='form1.logoimage.disabled=this.checked'>&nbsp;清空");
      }
      %>
    </td>
  </tr>
  <tr>
    <td align="right">
      核定使用商标：
    </td>
    <td>
      <input type="text" size="60" name="logouse" value="<%if(obj.getLogouse()!=null){out.print(obj.getLogouse());}%>">
    </td>
  </tr>
  <tr>
    <td align="right">
      注册号：
    </td>
    <td>
      <input type="text" size="60" name="regnum" value="<%if(obj.getRegnum()!=null){out.print(obj.getRegnum());}%>">
    </td>
  </tr>
    <tr>
    <td nowrap align="right">注册时间：</td>
    <td nowrap>
	        <input id="regdate" name="regdate" size="7"  value="<%if(obj.getRegdateToString()!=null)out.print(obj.getRegdateToString()); %>" readonly="readonly">
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.regdate');" />

    </td>
  </tr>
  <tr>
    <td nowrap> </td>
    <td nowrap>
      <input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked">文本
      <input  id="radio" type="radio" name=TextOrHtml value=1 <%//if((node.getOptions() & 0x40) != 0)out.print(" CHECKED ");%> >HTML
      <input type="button" name="Pictureview" id="Pictureview" class="edit_button" VALUE="图片浏览" onClick="window.open('/servlet/InsertPicture?node=<%=teasession._nNode%>', '_blank');">
      <input  id="CHECKBOX" type="checkbox" name="nonuse" value="checkbox" onClick="f_editor(this)"><label for="nonuse">不使用多媒体编辑器</label>
      <input type="checkbox" name="srccopy"/>源网站的图片贴入本地
    </td>
  </tr>
  <tr>
    <td align="right">详细介绍：</td>
    <td>
      <textarea style="display:none" name="content" rows="12" cols="97" class="edit_input"><%if(content!=null){out.print(content);}%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="730" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>

</table>
<input type="button" value="完成" onclick="f_sub();">
<script>
  function f_sub(){
    <%if(teasession.getParameter("logoid") == null || teasession.getParameter("logoid").equals("")){%>
      form1.act.value = "add";
      form1.submit();
    <%}else{%>
      form1.submit();
    <%}%>
  }
</script>
<input type="button" value="返回" onclick="history.go(-1);">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</BODY>
</HTML>
