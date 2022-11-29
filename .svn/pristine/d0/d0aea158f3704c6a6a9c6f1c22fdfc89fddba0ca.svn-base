<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<jsp:directive.page import="tea.resource.Common"/><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
//if(teasession._rv==null)
//{
//  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
//  return;
//}
Resource r=new Resource();
String memberid =request.getParameter("memberid");
if(request.getParameter("delete")!=null && request.getParameter("delete").length()>0)
{

  if(memberid!=null)
  {
    Profile obj = Profile.find(memberid);
    //obj.setpwd();
    obj.setPassword("");
    response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode("密码清除成功","UTF-8")+"&nexturl=/jsp/csvclub/csvmember/Csvmembers_2.jsp");
    return;
  }
}

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();//and (linetype=-1 or linetype =1)

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}
String members = request.getParameter("members");

if(members!=null && members.length()>0)
{

  sql.append(" and member like '%"+members+"%'");
  param.append("&member="+java.net.URLEncoder.encode(members,"UTF-8"));
}



int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);
int count=Profile.countByCommunity(teasession._strCommunity,sql.toString());

String order=request.getParameter("order");
if(order==null)
order="integral";
param.append("&order="+order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc="+desc);

sql.append(" ORDER BY "+order+" "+desc);


%>


  <script>
  function sub(s,i)
  {

    //currentPos = member;
    //send_request("/jsp/csvclub/Csv_ajax.jsp?no=no&s="+s);
    var mt=document.all("mt"+i);
    sendx("/jsp/csvclub/Csv_ajax.jsp?no=no&s="+s,function(d)
    {
      mt.innerHTML=d;
    });
  }
  </script>
<form method="POST" action="/servlet/EditExportExcelCsv" name="form_zong">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="Node" value="<%=teasession._nNode%>"/>
<input type=hidden name="csvservice" value="0"/>
<input type=hidden name="action" value="Csvmembers_2">
<input type=hidden name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
  java.util.Enumeration prme = Profile.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
  if(!prme.hasMoreElements())
  {
    out.print("<tr><td colspan=3>暂无记录</td></tr>");
  }
  for(int index=1;prme.hasMoreElements();index++)
  {
    String member = ((String)prme.nextElement());
    Profile probj = Profile.find(member);
 //   ProfileCsv procsv = ProfileCsv.find(member);
    %>
    <tr>
      <td id="img_no"><img alt="" src="/res/csvclub/u/0801/no_<%=index%>.gif" /> &nbsp;&nbsp;</td>
      <td nowrap id="member_name">&nbsp;&nbsp;<a target="_blank" href="/jsp/integral/Memberdetail2.jsp?member=<%=member %>"><%=probj.getFirstName(teasession._nLanguage) %></a>&nbsp;&nbsp;</td>
      <td nowrap id="index_info">&nbsp;&nbsp;<a target="_blank" href="/jsp/integral/Memberdetail2.jsp?member=<%=member %>">[详细信息]</a></td>
    </tr>
    <%
    }
    %>
</table>
</form>




