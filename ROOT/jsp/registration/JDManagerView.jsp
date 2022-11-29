<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.db.*"%>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  int node = teasession._nNode;
  Hostel obj = Hostel.find(node, teasession._nLanguage);
  Hotel_application hos = Hotel_application.find(obj.getMember());
  Profile pro = Profile.find(obj.getMember());
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter_lxr">
  <tr>
    <TD>联系人：<%if(obj.getMember()!=null)out.println(obj.getMember()); %></td>
  </tr>
  <tr>
  <tr>
    <td>联系电话： <%if(hos.getPhone()!=null)out.println(hos.getPhone());%></td>
  </tr>
  <TD>传真： <%if(hos.getFax()!=null)out.println(hos.getFax());%></td>
</tr>
 <tr>
  <TD>电邮：<%if(pro.getEmail()!=null)out.println(pro.getEmail());%></td>
  </tr>
  <tr>
    <TD>手机： <%if(pro.getMobile()!=null)out.println(pro.getMobile());%></td>
  </tr>
    <tr>
    <TD>MSN： <%if(hos.getMsn()!=null)out.println(hos.getMsn());%></td>
  </tr>
  <tr>
    <TD>QQ： <%if(hos.getQq()!=null)out.println(hos.getQq());%></td>
  </tr>
</table>
