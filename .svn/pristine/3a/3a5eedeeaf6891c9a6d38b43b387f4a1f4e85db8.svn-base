<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String field=request.getParameter("field");

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity).append("&node=").append(teasession._nNode).append("&field=").append(field);

Resource r=new Resource();
r.add("/tea/resource/Company");

StringBuffer sql=new StringBuffer(" FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node WHERE n.type=21 AND n.community=");
sql.append(DbAdapter.cite(teasession._strCommunity)).append(" AND nl.language="+teasession._nLanguage);


int type=0;
String q=request.getParameter("q");
if(q!=null&&(q=q.trim()).length()>0)
{
  param.append("&q="+java.net.URLEncoder.encode(q,"UTF-8"));
  //type=Integer.parseInt(request.getParameter("type"));
  sql.append(" AND (nl.subject LIKE "+DbAdapter.cite("%"+q+"%"));
  if(type==1)
  {
    sql.append(" OR nl.content LIKE "+DbAdapter.cite("%"+q+"%"));
  }
  sql.append(")");
}

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
  pos=Integer.parseInt(_strPos);
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<FORM  enctype="multipart/form-data"  name=form1 METHOD=GET action="?" >
<input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<input type='hidden' name=community VALUE="<%=teasession._strCommunity%>">
<input type='hidden' name=field VALUE="<%=field%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Name")%>:<input type="TEXT" class="edit_input"  name="q" size="40" MAXLENGTH="255" VALUE="<%if(q!=null)out.print(q);%>"></td>
    <!--tr>
      <td><input name="type" type="radio" value="0" /><%=r.getString(teasession._nLanguage, "Subject")%>
          <input name="type" type="radio" value="1" /><%=r.getString(teasession._nLanguage, "Text")%>
      </td>
    </tr-->
      <td><input type="submit" value="GO" /></td>
    </tr>
  </table>

  <h2><span id="sum"></span></h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
  int count=0;
  DbAdapter db=new DbAdapter();
  try
  {
    count=db.getInt("SELECT COUNT(*) "+sql.toString());
    db.executeQuery("SELECT n.node,nl.subject,n.time "+sql.toString());
    for (int l = 0; l < pos + 25 && db.next(); l++)
    {
      if (l >= pos)
      {
        int node=db.getInt(1);

        String subject=db.getString(2);
        out.print(node+"---"+subject);
        java.util.Date time=db.getDate(3);
        out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" onclick=\"window.opener."+field+".value='"+node+"';window.close();\" >");
        out.print("<td>"+(l-pos+1)+"</td>");
        out.print("<td>"+subject+"</td>");
        out.print("<td>"+time+"</td>");
      }
    }
  }finally
  {
    db.close();
  }
  out.print("<SCRIPT>var sum=document.getElementById('sum');sum.innerHTML='"+count+"';</SCRIPT>");
  %>
  <tr><td colspan="3" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString()+ "&pos=", pos, count)%></td></tr>
  </table>
</form>


</body>
</html>

