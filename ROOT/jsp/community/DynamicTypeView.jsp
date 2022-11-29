<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.node.*" %>
<%@page  import="tea.entity.site.*" %>
<%@ page import="tea.ui.*" %>
<jsp:directive.page import="tea.entity.member.Profile"/>
<jsp:directive.page import="tea.html.Text"/>
<%!
public String getText(DynamicType obj,Resource r, TeaSession teasession) throws java.sql.SQLException
{
  int dynamictype=obj.getDynamictype();
  if ("radio".equals(obj.getType()))
  {
    StringBuffer sb = new StringBuffer();
    java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(obj.getContent(teasession._nLanguage), "/");
    for (int index = 0; tokenizer.hasMoreTokens(); index++)
    {
      String str = tokenizer.nextToken();
      tea.html.Radio select = new tea.html.Radio("dynamictype" + dynamictype, str, index == 0);
      String id = String.valueOf(dynamictype) + "_" + index;
      select.setId(id);
      sb.append(select + "<label for=" + id + ">" + str + "</label> ");
    }
    return sb.toString();
  }else
  {
    String value=null;
    switch (obj.getDefaultvalue())
    {
      case 1:
      value = obj.sdf.format(new java.util.Date());
      break;
      case 2:
      if (teasession._rv != null)
      {

        tea.entity.member.Profile probj = Profile.find(teasession._rv.toString());

        value = probj.getLastName(teasession._nLanguage)+probj.getFirstName(teasession._nLanguage);
        break;
      }
      default:
      value=obj.getContent(teasession._nLanguage);
    }
    if(value.length()==0)value="　　　　　　　　　　";
    return "UL"+value+"UL";
  }
}
%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

Resource r=new Resource("/tea/resource/Dynamic");

String community=teasession._strCommunity;
int dynamic=Integer.parseInt(request.getParameter("dynamic"));
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<style>
*{font-size:9pt;}
img{border:0px;}
span {white-space: nowrap;}
<%--body{ background-image:url(../img/pdfbf.gif); background-position:center top; background-repeat:repeat-y;margin: 0px;text-align:center}--%>
div#language{margin-top:15px; padding-top:10px; }
form{margin: 0px;	padding: 0px;}
p{ margin:0px; padding:5px 0px 5px 0px}
</style>
</head>
<body >
<%
int id=0;
java.util.Enumeration enumeration=DynamicType.findByDynamic(dynamic);
while(enumeration.hasMoreElements())
{
  id=((Integer)enumeration.nextElement()).intValue();
  DynamicType obj=DynamicType.find(id);

  if(obj.isHidden())
  {
    out.print(obj.getBefore(teasession._nLanguage));
    out.print(obj.getText(teasession));
    out.print(obj.getAfter(teasession._nLanguage));
  }
}%>
</body>
</html>

