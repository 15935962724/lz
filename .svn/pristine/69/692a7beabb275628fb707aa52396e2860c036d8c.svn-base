<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="tea.entity.ocean.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");


TeaSession teasession = new TeaSession(request);
int ids = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}

Ocean oce = Ocean.find(ids);
%>
<html>
<head>
<link href="http://www.bj-sea.com/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">

  <%@include file="/jsp/include/Calendar3.jsp" %>
<title>海洋护照登记表</title>
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
function find_sub()
{
  if(form1.oceancard.value=="" ||form1.oceancard.value==null  )
  {
    alert("海洋护照编号不能为空，请重新填写！");
    return false;
  }
  return true;
}
</script>
</head>
<body>
<h1 style="display:block;width:100%;border-bottom:3px solid #ccc;">
管理员修改海洋护照编号
</h1>
<!--h1>2009年海洋护照登记表</h1>
<p>为了确保您能及时收到会员的活动信息，请您如实填写您的个人资料，北京海洋馆将对</p>
<p>您所填写的内容保密。申请海洋护照时，请出示本人身份证或有效证件：1.2米以上、18岁</p>
<p> 以下需办理学生护照。 </p-->
<form  name="form1" action="/servlet/EditOcean" method="POST" enctype="multipart/form-data">
<input  type="hidden" value="EditOceanRoll4" name="act">
<input  type="hidden" name="idss" value="<%=ids%>" >
<table width="496" border="0" id="tablecentermm">
<tr>
    <td nowrap colspan="5" class="tdte">订单号：
<%=oce.getOceanorder()%>　
<input type="button" value="导出word" onClick="window.open('/jsp/ocean/OceanWord.jsp?ids=<%=ids%>','_self')"></td>
  </tr>
  <tr>
    <td width="110" nowrap class="td01">购买类型：</td>
    <td colspan="3"   nowrap><%=Ocean.PASSPORT[oce.getPassport()]%> </td>
    <td width="80" nowrap rowspan="3" class="tdte2" align="center"><img src="<%if(oce.getPicpath()!=null && oce.getPicpath().length()>0){out.print(oce.getPicpath());}else{out.print("/tea/image/oceanRoll/phonomember.jpg");}%>" width="100"></td>
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
 <td colspan="3" align="right"><input type="file" name="picture" value=""></td>
  </tr>
  <tr>
    <td nowrap class="td01">您的移动电话：</td>
    <td><%if(oce.getMobile()!=null)out.print(oce.getMobile());%></td>
      <td class="td03">证件号码：</td>
    <td nowrap colspan="2" ><%if(oce.getCard()!=null)out.print(oce.getCard());%></td>
  </tr>
   <tr>
    <td class="td01">固定电话：</td>
    <td colspan="4"><%if(oce.getTelephone()!=null)out.print(oce.getTelephone());%></td>
  </tr>
   <tr>
    <td nowrap class="td01">教育程度：</td>
    <td nowrap><%=Ocean.EDUCATION[oce.getEducation()]%></td>

    <td class="td01">您的职业：</td>
    <td nowrap colspan="2"> <%=Ocean.OCCUPA_TION[oce.getOccupation()]%></td>
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
    <td colspan="4"><label>  <%=Ocean.INCOME[oce.getIncome()]%></label></td>
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
   <td class="td01">您感兴趣的海洋馆会员活动如下：</td>
   <td  colspan="4">
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
  <tr>
     <td class="td01">海洋护照编号：</td>
     <td colspan="4">
      <label>
      <input type="text" name="oceancard" value="<%=oce.getOceancard()%>">
      </label></td>
  </tr>
</table>
<div class="tijiaoa">  <input type="image" src="/res/bj-sea/u/0902/090219001.gif" value="提交" onClick="return find_sub()" style="width:100px;height:28px;border:0px;"/></div>
</form>
</body>
</html>
