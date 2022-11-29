<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="java.util.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

Resource r=new Resource();

String strid=request.getParameter("id");

String community=teasession._strCommunity;






CLicense obj=CLicense.find(community);
String type=obj.getType();
if(type==null)type="";
if("POST".equals(request.getMethod()))
{
  String types[]=request.getParameterValues("type");
  StringBuffer sb=new StringBuffer("/");
  if(types!=null)
  for(int index=0;index<types.length;index++)
  {
    sb.append(types[index]+"/");
  }
  obj.set(sb.toString());
  
  response.sendRedirect("/jsp/info/Succeed.jsp");
  return;
}
//int UNDONE_TYPE[] = {4,5,6,7, 9, 10, 11, 16, 17, 18, 19, 20, 22, 23, 24, 25, 26, 27, 32, 33, 35, 36, 38, 43, 46, 47, 67};

String def=request.getParameter("def");//默认选中.
if(def!=null)type=type+def;

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
<h1><%=r.getString(teasession._nLanguage, "CBEditListing")%></h1>
<div id="head6"><img height="6" alt=""></div>

<FORM name=form1 METHOD=POST action="?" >
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="id" value="<%=strid%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td rowspan="200"><%=r.getString(teasession._nLanguage, "Style")%>:</td>
  <%
  int j=2;
  for(int index=2;index<Node.NODE_TYPE.length;index++)
  {
	
    for (int i = 0; i <=CLicense.UNDONE_TYPE.length; i++)
    {
      if(i==CLicense.UNDONE_TYPE.length)
      {
        if(j>2&&(j-2)%8==0)
        {
          out.print("<tr>");
        }
        out.print("<td><input type=checkbox name=type VALUE="+index);
        if(type.indexOf("/"+(index)+"/")!=-1)
        {
          out.print(" checked ");
        }
        out.print(" >"+r.getString(teasession._nLanguage,Node.NODE_TYPE[index]));
        j++;
      }else
      if (index == CLicense.UNDONE_TYPE[i])
      {
        //out.print(" disabled style=\"display:none\" ");
        break;
      }
    }
  }
  int old=-1;
  Enumeration e=Dynamic.find("");
  for(int i=0;e.hasMoreElements();i++)
  {
    int id=((Integer)e.nextElement()).intValue();
    Dynamic d=Dynamic.find(id);
    if(old!=d.getSort())
    {
      old=d.getSort();
      i=0;
      out.print("<tr><td colspan=8>"+old);
    }
    if(i%8==0)
    {
      out.print("<tr>");
    }
    out.print("<td><input type=checkbox name=type VALUE="+id);
    if(type.indexOf("/"+id+"/")!=-1)
    {
      out.print(" checked ");
    }
    out.print(" >"+d.getName(teasession._nLanguage));
  }
%>
</table>
<input id="radio" type="checkbox" onclick="selectAll(form1.type,checked)" ><%=r.getString(teasession._nLanguage,"SelectAll")%>

<input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"/>
<input type="reset" >

<!--
<input type=button value="<%=r.getString(teasession._nLanguage,"动态类管理")%>" onclick="window.open('/jsp/community/Dynamics.jsp?community=<%=community%>','_self');"/>
-->
</FORM>

<br>
<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
