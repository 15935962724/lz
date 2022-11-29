<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="tea.entity.ocean.*"%><%@page import="tea.entity.site.*"%>
<%
TeaSession teasession =new TeaSession(request);
String ids[]=request.getParameterValues("ids");



String oceancard =teasession.getParameter("oceancard");
response.setHeader("Content-Disposition", "attachment; filename=exp.doc");



%>
<html>
<head>
<base href="http://<%=request.getServerName()+":"+request.getServerPort()%>/"/>
<style type="text/css">
tea/CssJs/bj-sea.css
</style>
<script type="">
function find_x(aa)
{
  if(aa!=1)
  {
    document.getElementById('dada').style.display="";
  }else
  {
    document.getElementById('dada').style.display="none";
  }
}
</script>
<title>
海洋护照发放表
</title>
</head>
<body bgcolor="#ffffff">
<h1>
海洋护照发放表
</h1>
<%

for(int iiii=0;iiii<ids.length;iiii++)
{
Ocean oce = Ocean.find(Integer.parseInt(ids[iiii]));
if(iiii>0)out.print("<hr>");
%>
<form action="">
<table border="1" id="tablecenter">
<tr>
    <td nowrap colspan="5" class="tdte">订单号：
<%=oce.getOceanorder()%>　
</td>
  </tr>
  <tr>
    <td width="110" nowrap class="td01">购买类型：</td>
    <td colspan="3"   nowrap><%=Ocean.PASSPORT[oce.getPassport()]%> </td>
    <td width="80" nowrap rowspan="3" class="tdte2"><img src="<%if(oce.getPicpath()!=null && oce.getPicpath().length()>0){out.print(oce.getPicpath());}else{out.print("/tea/image/oceanRoll/phonomember.jpg");}%>" width="100" height="117"></td>
  </tr>
  <tr>
    <td class="td01">您的姓名：</td>
    <td class="td02"><label>
      <%if(oce.getName()!=null){out.print(oce.getName());}%>
    </label></td>
    <td nowrap class="td03">您的性别：</td>
    <td><%out.print(oce.isSex()?"男":"女");%></td>
  </tr>
  <tr>
    <td nowrap class="td01">办理情况：</td>
    <td nowrap colspan="3" ><%if(oce.getApplycard()==0){out.print("新办卡");}else{out.print("续办卡");};%></td>
  </tr>
  <tr>
    <td nowrap  class="td01">证件类型：</td>
    <td class="td02"><%=Ocean.CARDTYPE[oce.getCardtype()]%></td>
    <td class="td03">证件号码：</td>
    <td nowrap colspan="2" ><%if(oce.getCard()!=null)out.print(oce.getCard());%></td>
  </tr>
  <tr>
    <td nowrap class="td01">您的移动电话：</td>
    <td colspan="4"><%if(oce.getMobile()!=null)out.print(oce.getMobile());%></td>
  </tr>
   <tr>
    <td class="td01">固定电话：</td>
    <td colspan="4"><%if(oce.getTelephone()!=null)out.print(oce.getTelephone());%></td>
  </tr>
  <tr>
    <td nowrap class="td01">教育程度：</td>
    <td  colspan="4"><%=Ocean.EDUCATION[oce.getEducation()]%></td>
  </tr>
  <tr>
    <td class="td01">您的职业：</td>
    <td  colspan="4"> <%=Ocean.OCCUPA_TION[oce.getOccupation()]%></td>
  </tr>
   <tr>
    <td class="td01">居住城区：</td>
    <td colspan="4"><label><%=Ocean.URBAN_TYPE[oce.getUrban()]%></label></td>
  </tr>
  <tr>
    <td class="td01">您的通讯地址：</td>
    <td colspan="4"><label>
      <%if(oce.getAddress()!=null)out.print(oce.getAddress());%>
    </label></td>
  </tr>

   <tr>
    <td class="td01">邮政编码：</td>
    <td class="td02"><%if(oce.getZip()!=null)out.print(oce.getZip());%></td>
    <td class="td03">电子邮箱：</td>
    <td colspan="2"><label>
      <%if(oce.getEmail()!=null)out.print(oce.getEmail());%>
    </label></td>
  </tr>
  <tr>
  <!--
    <td nowrap class="td01">您宝宝的姓名：</td>
    <td class="td02"><label>
      <%if(oce.getBabyname()!=null)out.print(oce.getBabyname());%>
    </label></td>
    -->
    <td class="td01">宝宝生日：</td>
    <td colspan="2"><%if(oce.getBabybirthtoString()!=null)out.print(oce.getBabybirthtoString());%></td>
  </tr>
  <!--
  <tr>
    <td class="td01">您宝宝的年龄：</td>
    <td class="td02"><label>
      <%if(oce.getBabyage()!=null)out.print(oce.getBabyage());%>
    </label></td>
    <td colspan="3">&nbsp;</td>
  </tr>
  -->
  <tr>
    <td class="td01">您全家月收入：</td>
    <td colspan="4"><label> <%=Ocean.INCOME[oce.getIncome()] %></label></td>
  </tr>
   <tr>
    <td class="td01">信息获知途径：</td>
    <td colspan="4"><label>  <%=Ocean.LEARN_WAY[oce.getLearnway()]%></label></td>
  </tr>
  <tr>
    <td class="td01">您和宝宝的兴趣爱好：</td>
    <td colspan="4"><label> <%
    for(int i = 1;i<oce.getBobo_interest().split("/").length;i++)
    {
      out.print(Ocean.BOBO_INTEREST[Integer.parseInt(oce.getBobo_interest().split("/")[i])]+"&nbsp;");
    }
    %></label></td>
    </tr>
    <%
    if(oce.getBobo_interest_qita()!=null && oce.getBobo_interest_qita().length()>0)
    {
      out.print("<tr>");
      out.print("<td>&nbsp;</td>");
      out.print("<td colspan=4>");
      out.print("其他:&nbsp;");
      out.print(oce.getBobo_interest_qita());
      out.print("</td>");
      out.print("</tr>");
    }
    %>

  <tr>
   <td colspan="5" class="tdte4">您感兴趣的海洋馆会员活动如下：

  <%
  for(int i=0;i<Ocean.INTEREST.length;i++)
  {
    oce.getInterest();
    if(oce.getInterest()!=null && oce.getInterest().length()>0)
    {
      String spit[] = oce.getInterest().split(",");
      if(spit.length!=-1)
      {
        for(int j=0;j<spit.length;j++)
        {
          if((spit[j]).length()>0)
          {
            int aa = Integer.parseInt(spit[j]);
            if(aa==i)
            {
              out.print("<div>"+Ocean.INTEREST[i]+"</div>");
              out.print("");
            }
          }
        }
      }
    }

  }
  %>
  </td></tr>
 <tr>
<td></td>   <td colspan="4">其他：
        <label>
          <%
          if(oce.getOther()!=null)out.print(oce.getOther());%>
        </label></td>
    </tr>
  <tr>
    <td class="td01">是否允许代领：</td>
    <td colspan="4">
      <label>
      <%if(oce.getReplacetype()==0){out.print("否");}else{out.print("是");}%>
      </label></td>
  </tr>
</table>
</form>
<%}%>

</body>
</html>
