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
管理员修改海洋护照信息
</h1>
<!--h1>2009年海洋护照登记表</h1>
<p>为了确保您能及时收到会员的活动信息，请您如实填写您的个人资料，北京海洋馆将对</p>
<p>您所填写的内容保密。申请海洋护照时，请出示本人身份证或有效证件：1.2米以上、18岁</p>
<p> 以下需办理学生护照。 </p-->
<form  name="form1" action="/servlet/EditOcean" method="POST" enctype="multipart/form-data">
<input  type="hidden" value="EditOceanRoll5" name="act">
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
    <td width="80" nowrap rowspan="3" class="tdte2" align="center"><img src="<%if(oce.getPicpath()!=null && oce.getPicpath().length()>0){out.print(oce.getPicpath()+"?"+System.currentTimeMillis());}else{out.print("/tea/image/oceanRoll/phonomember.jpg");}%>" width="100"></td>
  </tr>
  <tr>
    <td class="td01">您的姓名：</td>
    <td class="td02"><label>
     <input type="text" name="name" value="<%if(oce.getName()!=null){out.print(oce.getName());}%>">
    </label></td>
    <td nowrap class="td03">您的性别：</td>
    <td>男
  <input type="radio" name="sex" value="1" <%if((ids!=0)&&(oce.isSex())){out.print("checked");}else if(ids==0){out.print("checked");}%>>
  女
  <input type="radio" name="sex"  value="0" <%if((ids!=0)&&(!oce.isSex())){out.print("checked");}%>></td>
  </tr>
  <tr>
    <td nowrap class="td01">卡类型：</td>
    <td nowrap > 新办卡：<input type="radio" name="applycard" value="0"   checked="checked" <%if((oce.getApplycard()==0)){out.print("checked");}%>/>　续办卡：<input type="radio" name="applycard" <%if((oce.getApplycard()==1)){out.print("checked");}%> value="1"  /></td>
      <td nowrap colspan="2" > <input type="file" name="picture" value=""></td>
  </tr>
  <tr>
    <td nowrap  class="td01">证件类型：</td>
    <td class="td02"><select id="cdt" name="cardtype">
            <%
            for(int i=0;i<Ocean.CARDTYPE.length;i++)
            {
              out.print("<option value="+i);
              if(oce.getCardtype()==i)
              {
                out.print(" selected");
              }
              out.print(">"+Ocean.CARDTYPE[i]+"</option>");
            }
            %></select></td>
  <td class="td03">证件号码：</td>
    <td nowrap colspan="2" ><input type="text" name="card" maxlength="18" size="21" value="<%if(oce.getCard()!=null)out.print(oce.getCard());%>"></td>
  </tr>
  <tr>
    <td nowrap class="td01">您的移动电话：</td>
    <td><input type="text" name="mobile" value="<%if(oce.getMobile()!=null)out.print(oce.getMobile());%>"  mask="float" maxlength="11"></td>
    <td nowrap colspan="3" ></td>
  </tr>
   <tr>
    <td class="td01">固定电话：</td>
    <td colspan="4"><input type="text" name="telephone" value="<%if(oce.getTelephone()!=null)out.print(oce.getTelephone());%>"></td>
  </tr>

          <tr>
            <td  class="td01" valign="top">教育程度：</td>

            <%
               for(int i =0;i<Ocean.EDUCATION.length;i++)
               {
                 out.print("  <td >");
                 out.print("<input type=\"radio\" name=education value="+i);
                 if(oce.getEducation()==i)
                 {
                   out.print(" checked ");
                 }
                 out.print(" >&nbsp;");
                 out.print(Ocean.EDUCATION[i]);
                 out.print(" </td>");
               }
            %>

          </tr>
          <tr>
            <td  class="td01" valign="top">您的职业：</td>

            <%
            for(int i =0;i<Ocean.OCCUPA_TION.length;i++)
            {
              out.print("  <td >");
              out.print("<input type=\"radio\" name=\"occupation\" value="+i);
              if(oce.getOccupation()==i)
              {
                out.print(" checked ");
              }
              out.print(" >&nbsp;");
              out.print(Ocean.OCCUPA_TION[i]);
              out.print(" </td>");
            }
            %>

          </tr>
          <tr>
            <td  class="td01" valign="top">*居住城区：</td>

           <td>
           <select name="urban">
              <%
                 for(int i = 0;i<Ocean.URBAN_TYPE.length;i++)
                 {
                   out.print("<option value = "+i);
                   if(oce.getUrban()==i)
                   {
                     out.print(" selected ");
                   }
                   out.print(">"+Ocean.URBAN_TYPE[i]);
                   out.print("</option>");
                 }
              %>
           </select>
           </td>

          </tr>
  <tr>
    <td class="td01">您的邮寄地址：</td>
    <td colspan="4"><label>
     <textarea name="address" id="textarea" cols="45" rows="5"><%if(oce.getAddress()!=null){out.print(oce.getAddress());}%></textarea>
    </label></td>
  </tr>
   <tr>
    <td class="td01">邮政编码：</td>
    <td class="td02"><input type="text" name="zip" value="<%if(oce.getZip()!=null)out.print(oce.getZip());%>" mask="float" maxlength="6"></td>
    <td class="td03">电子邮箱：</td>
    <td colspan="2"><label>
      <input type="text" name="email" value="<%if(oce.getEmail()!=null)out.print(oce.getEmail());%>">
    </label></td>
  </tr>
  <tr>
  <!--
    <td nowrap class="td01">您宝宝的姓名：</td>
    <td class="td02"><label>
       <input type="text" name="babyname" value="<%if(oce.getBabyname()!=null)out.print(oce.getBabyname());%>">
    </label></td>
    -->
    <td class="td01">宝宝生日：</td>
    <td colspan="2"><input type="text" readonly="readonly" name="babybirth" value="<%if(oce.getBabybirthtoString()!=null){out.print(oce.getBabybirthtoString());}%>" onClick="new Calendar('1997', '2010', 0,'yyyy-MM-dd').show(this);" /></td>
  </tr>
  <!--
  <tr>
    <td class="td01">您宝宝的年龄：</td>
    <td class="td02"><label>
     <input type="text" name="babyage" value="<%if(oce.getBabyage()!=null)out.print(oce.getBabyage());%>" mask="float" maxlength="2"> 岁
    </label></td>
    <td colspan="3">&nbsp;</td>
  </tr>
  -->
 <tr>
            <td class="td01">家庭收入：</td>
            <td><label>
              <input type="radio" name="income"  value="0"   <%if(oce.getIncome()==0){out.print(" checked ");}%>>
              4000元以下</label></td>
              <td nowrap><input type="radio" name="income"  value="1" <%if(oce.getIncome()==1){out.print(" checked ");}%>>
                4000元—7000元</td>
                <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><input type="radio" name="income"  value="2"  <%if(oce.getIncome()==2){out.print(" checked ");}%>>&nbsp;7000元—10000元</td>
              <td><input type="radio" name="income"  value="3" <%if(oce.getIncome()==4){out.print(" checked ");}%>>10000元以上</td>
          </tr>
          <tr>
            <td  class="td01" valign="top">信息获知途径：</td>

           <td>
              <%
                 for(int i = 0;i<Ocean.LEARN_WAY.length;i++)
                 {
                   out.print("<input type=radio name=learnway  value="+i);
                   if(oce.getLearnway()==i)
                   {
                     out.print(" checked ");
                   }
                   out.print(" >&nbsp;");
                   out.print(Ocean.LEARN_WAY[i]);
                 }
              %>

           </td>

          </tr>
          <tr>
            <td  class="td01" valign="top">您和宝宝的兴趣爱好：</td>
            <td>
            <%
            for(int i = 0;i<8;i++)
            {
              out.print("<input type=checkbox name=bobo_interest"+i+"  value="+i);
              if(oce.getBobo_interest()!=null && oce.getBobo_interest().indexOf("/"+i+"/")!=-1)
              {
                out.print(" checked ");

              }
              out.print(" > &nbsp; ");
              out.print(Ocean.BOBO_INTEREST[i]);
            }
            %>
            </td>
          </tr>
           <tr>
            <td>&nbsp;</td>
            <td>
            <%
            for(int i = 8;i<Ocean.BOBO_INTEREST.length;i++)
            {
              out.print("<input type=checkbox name=bobo_interest"+i+"  value="+i);
               if(oce.getBobo_interest()!=null &&  oce.getBobo_interest().indexOf("/"+i+"/")!=-1)
              {
                out.print(" checked ");

              }
              out.print(" > &nbsp; ");
              out.print(Ocean.BOBO_INTEREST[i]);
            }
            %>
            </td>
          </tr>
           <tr>
            <td>&nbsp;</td>
            <td>其他:<input type="text" name="bobo_interest_qita" value="<%if(oce.getBobo_interest_qita()!=null)out.print(oce.getBobo_interest_qita());%>"/>
            </td>
          </tr>
          <tr>
            <td colspan="5">您感兴趣的海洋馆会员活动如下：</td>
            <td><label>
</label></td>
          </tr>
          <%
          for(int i=0;i<Ocean.INTEREST.length;i++)
          {

            out.print("<tr><td nowrap ></td><td nowrap colspan=5><label><input  type=checkbox name=interest"+i+" value="+i);
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
                      out.print(" checked ");
                    }
                  }
                }
              }
            }
            out.print("></label>　"+Ocean.INTEREST[i]+"</td></tr>");
          }
          %>
   <tr>
            <td class="td01" valign="top">其他：</td>
            <td  colspan="4">
              <label>
                <textarea name="other" cols="40" rows="4"><%if(oce.getOther()!=null)out.print(oce.getOther());%></textarea>
              </label></td>
          </tr>
          <tr>
            <td class="td01">是否允许代领：</td><td colspan="4">
              <label>
                是<input type="radio" name="replacetype" value="1" checked="checked" <%if(oce.getReplacetype()==1)out.print("checked");%>>  否<input type="radio" name="replacetype" value="0" <%if(oce.getReplacetype()==0&& ids!=0)out.print("checked");%>>
              </label>*代领人在领卡时需带办卡人所填相关证件</td>
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
<%@include file="/jsp/include/Canlendar4.jsp" %>
</body>
</html>
