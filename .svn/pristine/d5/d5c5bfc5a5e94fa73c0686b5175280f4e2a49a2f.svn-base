<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.resource.Common" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="tea.entity.admin.sales.*" %>
<%@ page import="java.util.Date" %>
<%request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);

int lyid = Integer.parseInt(teasession.getParameter("memberly"));
String lctype = teasession.getParameter("lctype");

Latency ly = Latency.find(lyid);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
  <title>
  会员信息
  </title>
<script type="">
function che(){
  var a1 = document.getElementById('a1');
  var a2 = document.getElementById('a2');

  if(!a1.checked && !a2.checked){
    alert('请选择该会员是否通过审核');
    return false;
  }
  return true;

}
</script>
</head>
<body bgcolor="#ffffff">
<h1>
会员信息
</h1>
<form action="/servlet/EditLatency" name="form1">
<input type="hidden" name="lyid" value="<%=lyid%>"/>
<input type="hidden" name="nexturl" value="<%=request.getParameter("nexturl")%>"/>
<input type="hidden" name="act" value="sh"/>
<table border="0" width="80%" id="tablecenter">
  <tr>
    <td width="40%">用户名：</td><td><%=ly.getEmail()%></td>
  </tr>
  <tr>
    <td>性别：</td><td><%=ly.getSex()==0?"男":"女" %></td>
  </tr>
  <tr>
    <td>姓名：</td><td><%=ly.getFamily()+ly.getFirsts()%></td>
  </tr>
  <tr>
    <td>公司：</td><td><%=ly.getCorp()%></td>
  </tr>
  <tr>
    <td>所属行业：</td><td><%=Common.SALES_CALLING[ly.getCalling()]%></td>
  </tr>
  <tr>
    <td>职务：</td><td><%=Latency.DUTYS[ly.getDuty()]%></td>
  </tr>
  <tr>
    <td>部门：</td><td><%=ly.getDept()%></td>
  </tr>
  <tr>
    <td>公司地址：</td><td><%=ly.getCountry()%></td>
  </tr>
  <tr>
    <td>邮政编码：</td><td><%=ly.getPostalcode()%></td>
  </tr>
  <tr>
    <td>联系电话：</td><td><%=ly.getTelephone()%></td>
  </tr>
  <tr>
    <td>传真：</td><td><%if(ly.getInc_fax()!=null)out.print(ly.getInc_fax());else out.print("&nbsp;");%></td>
  </tr>
  <tr>
    <td>联系人手机：</td><td><%if(ly.getHandset()!=null)out.print(ly.getHandset());else out.print("&nbsp;");%></td>
  </tr>
  <tr>
    <td>省份：</td><td><%=Latency.PROVINCES[ly.getProvince()]%></td>
  </tr>
  <tr>
    <td>城市：</td><td><%=ly.getCity()%></td>
  </tr>
  <%if(lctype.equals("1")){%>
  <tr>
    <td colspan="2" align="center">
      <input type="radio" id="a1" name="audit" value="1" onclick="document.getElementById('accept').style.display='';"/>&nbsp;通过　<input type="radio" id="a2" name="audit" value="2" onclick="document.getElementById('accept').style.display='none';"/>&nbsp;不通过
    </td>
  </tr>
  <%}%>
  <tr id="accept" style="display:none;">
    <td colspan="2" align="center">
    分配该会员角色
    <select name="memrole">
      <option value="0">默认会员</option>
      <%
      StringBuffer sb2=new StringBuffer("/");
      String role = "/";
      AdminUsrRole aur_obj=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
     String[] rs=aur_obj.getRole().split("/");
      for (int i = 1; i < rs.length; i++)
      {
        AdminRole ar = AdminRole.find(Integer.parseInt(rs[i]));
        String cs[] =(rs[i]+ar.getConsign()).split("/");
        for (int j = 0; j < cs.length; j++)
        {
          int arid=Integer.parseInt(cs[j]);
          if(role.indexOf("/"+arid+"/")==-1&&sb2.indexOf("/"+arid+"/")==-1)
          {
            out.print("<option value="+arid+" >"+AdminRole.find(arid).getName());
            sb2.append(arid).append("/");
          }
        }
      }
      %>
    </select>　
    <input type="radio" name="guest" value="0" checked="checked"/>&nbsp;转入潜在客户　<input type="radio" name="guest" value="1"/>&nbsp;转入正式客户　
    </td>
  </tr>
  <tr>
    <td align="center" colspan="2"> <%if(lctype.equals("1")){%><input type="submit" value="确定" onclick="return che();"/>&nbsp;<%}%><input type="button" value="返回" onclick="javascript:window.history.back();"/></td>
  </tr>
</table>
</form>
</body>
</html>
