<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8"); %>
<%
TeaSession teasession=new TeaSession(request);
//if(teasession._rv == null)
//{
//  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
//  return;
//}
int hidden=0;
if(request.getParameter("hidden")!=null)
{
  hidden=Integer.parseInt(request.getParameter("hidden"));
}
tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");

//SupplierMember sm=SupplierMember.find(teasession._strCommunity,teasession._rv._strV);

String locid = teasession.getParameter("locid");
String all  = teasession.getParameter("all");

%>


<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>



<FORM NAME=foEdit METHOD=GET ACTION="/servlet/Folder?node=8632&language=1"><INPUT TYPE="HIDDEN" NAME="listing" VALUE="946"/>

  <INPUT TYPE="HIDDEN" NAME="id" VALUE="947"/><table border="0" cellpadding="0" cellspacing="0" ><tr><td>选择职位地区
    <SELECT NAME="locid" STYLE="width:150px;margin-left:17px">
      <OPTION VALUE="" SELECTED >——选择城市或地区——</OPTION>
     <%

    java.util.Enumeration e=Jobcity.findByFather(Jobcity.getRootId(teasession._strCommunity));
    while(e.hasMoreElements())
    {
      int occ=((Integer)e.nextElement()).intValue();
      Jobcity occ_obj=Jobcity.find(occ);
      out.print("<option value="+occ_obj.getCode());
      if(occ_obj.getCode().equals(locid))
         out.print(" selected");
      out.print(">"+occ_obj.getSubject());
      out.print("</option>");
    }
    //allaa
     %>

    </SELECT></td>
    <td>选择招聘机构<jsp:include flush="true" page="/jsp/type/job/AllCorp.jsp"/></td>

</td></tr><tr><td>输出查找关键字<input type=text name="all" value="<%if(all!=null)out.print(all);%>" style="width:150px" style="margin:5px;"/></td><td><INPUT TYPE="SUBMIT" VALUE="查询"  style="margin:2px 4px 6px 3px;" id="jians"/></td></tr></table></FORM>





