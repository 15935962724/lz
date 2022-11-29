<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.ui.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

Community c=Community.find(teasession._strCommunity);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
ul, li{list-style-type:disc;margin-top:10px;margin-bottom:2px;}
#tabletext{font-size:12px;}
-->
</style>
</head>
<body>



<form name="form1" action="/servlet/EditCompanyWindows" method="post">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<input type="hidden" name="act" value="dns" />

<table width="600" border="0" cellpadding="0" cellspacing="0" id="tabletext">
  <tr>
    <td width="9%" height="30" align="center"><img src="/tea/image/eyp/images/ico_2.jpg" width="29" height="25" /></td>
    <td width="91%" align="left" style="border-bottom:1px solid #65A4D7;"><strong>域名续费</strong></td>
  </tr>
  <tr>
    <td height="10" colspan="2" align="center"></td>
  </tr>
  <tr>
    <td colspan="2" align="right"><table width="100%" border="0" cellpadding="0" cellspacing="1" id="tablecenter">
      <tr>
        <td height="25" align="left">该第一站有效期：</td>
        <td height="25" align="left"><%=c.getStartTimeToString()%> 至 <%=c.getStopTimeToString()%></td>
      </tr>
      <tr>
        <td width="22%" align="left" bgcolor="#FFFFFF"><span>续费年限：</span></td>
        <td width="78%" height="25" align="left" bgcolor="#FFFFFF" style="padding-top:8px;padding-bottom:8px;"><span><font color="red">如果您已收到该会员的款项,请为该会员续费延期</font></span><br />
          <span>
            <input name="year" type="text" size="3" style="height:15px;width:20px;"/>年&nbsp;（请添写数字）&nbsp;<input type="submit" name="Submit" value="马上续费" />
          </span></td>
      </tr>
</table>
</td>
  </tr>

      <tr>
        <td height="30" align="center"><img src="/tea/image/eyp/images/ico_3.jpg" width="24" height="24" /></td>
        <td align="left" style="border-bottom:1px solid #65A4D7;"><strong>绑定域名</strong></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
        <td align="left"><ul>
          <li>
            您可以为当前第一站绑定域名，在绑定域名时，在绑定域名时，请确保域名的DNS服务器已设置为：<br />
            <font color="red">主DNS服务器：ns.qiqiwang.com</font><br />
            <font color="red">附DNS服务器：ns1.qiqiwang.com</font></li>
        </ul></td>
      </tr>
      <tr>
        <td height="30" colspan="2" align="right"><table width="100%" border="0" cellpadding="0" cellspacing="1" id="tablecenter">
          <tr>
            <td width="70%" height="25" align="center">己绑定域名</td>
            <td width="30%" align="center">删除</td>
          </tr>
          <%
          Enumeration e_dns=DNS.findByCommunity(teasession._strCommunity,teasession._nStatus);
          for(int j=1;e_dns.hasMoreElements();j++)
          {
            String dn=(String)e_dns.nextElement();
            //DNS dns=DNS.find(dn);
            out.print("<tr><td height=25 align=center>http://"+dn+"</td><td align=center>");
            if(j>1)
            {
              out.print("<a href=### onclick=if(confirm('确认删除?'))window.open(form1.action+'?act=dns&domain="+java.net.URLEncoder.encode(dn,"UTF-8")+"&del=&nexturl='+encodeURIComponent(location),'_self');><img src=/tea/image/eyp/images/delet.jpg></a>");
            }
          }
          %>
        </table>
          <table width="98%" border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td width="91%" height="30" align="center" bgcolor="#EEEEEE">添加绑定域名：http://
                <input name="domain" type="text" size="25"/>
                  <input type="submit" name="add" value="绑定" /></td>
            </tr>
          </table></td>
      </tr>
    </table>

</form>

</div>
  </div>
  <div id="edit_page2_bottom"></div>
