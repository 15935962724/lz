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

</head>
<body class="OceanPassport">
<script type="">
window.history.forward(1);

</script>
<div class="body">
  <table class="Flow3">
    <tr>
      <td class="td01"></td><td class="td02">服务条款</td><td class="td03">填写登记表</td><td class="td04">确认订单</td><td class="td05">支付费用（首信易支付）</td>
    </tr></table>
    <div class="Ocean">
      <div class="Ocean_top"></div><div class="Ocean_con"><div class="Ocean_bottom">
        <form  name="form1" action="/jsp/ocean/EditOceanRoll_2.jsp" method="get" enctype="multipart/form-data">
        <input  type="hidden" value="EditOceanRoll2" name="act">
        <input  type="hidden" name="ids" value="<%=ids%>" >

        <table border="0" class="Orders">
          <tr>
            <td colspan="3" class="tetd02"></td>
            <td  nowrap class="td04">订单号：<%=oce.getOceanorder()%>
            </td>
          </tr>
          <tr>
            <td nowrap class="td01" >购买类型：</td>
            <td colspan="2"   nowrap>北京市海洋馆护照</td>
            <td nowrap rowspan="3" class="tetd01"><img src="<%if(oce.getPicpath()!=null && oce.getPicpath().length()>0){out.print(oce.getPicpath());}else{out.print("/\\tea/\\image/\\oceanRoll/\\phonomember.jpg");}%>" width="100" alt=""></td>
          </tr>
          <tr>
            <td nowrap class="td01" >护照价格：</td>
            <td colspan="2"   nowrap>￥<%=oce.getMoney()%></td>
            <tr>
              <tr>
                <td nowrap class="td01">办理情况：</td>
                <td colspan="2"   nowrap><%=Ocean.PASSPORT[oce.getPassport()]%>
                </td>

              </tr>
              <tr>
                <td class="td01">您的姓名：</td>
                <td><label>
                  <%if(oce.getName()!=null){out.print(oce.getName());}%>
</label></td>
<td nowrap class="td03">您的性别：</td>
<td><%out.print(oce.isSex()?"男":"女");%></td>
              </tr>
              <tr>
                <td nowrap class="td01">卡类型：</td>
                <td nowrap><%if(oce.getApplycard()==0){out.print("新办卡");}else{out.print("续办卡  海洋护照编号："+oce.getOceancard());}%></td>
                <td nowrap></td>
                <td nowrap></td>
              </tr>
              <tr>
                <td nowrap class="td01">证件类型：</td>
                <td nowrap ><%=Ocean.CARDTYPE[oce.getCardtype()]%></td>
                <td nowrap  class="td03">证件号码：</td>
                <td ><%if(oce.getCard()!=null)out.print(oce.getCard());%></td>
              </tr>
              <tr>
                <td nowrap class="td01">您的移动电话：</td>
                <td nowrap ><%if(oce.getMobile()!=null)out.print(oce.getMobile());%></td>
                <td nowrap class="td03">固定电话：</td>
                <td nowrap ><%if(oce.getTelephone()!=null)out.print(oce.getTelephone());%></td>
              </tr>
              <tr>
                <td nowrap class="td01">教育程度：</td>
                <td nowrap><label> <%=Ocean.EDUCATION[oce.getEducation()]%></label></td>

                <td nowrap class="td01">您的职业：</td>
                <td nowrap><label> <%=Ocean.OCCUPA_TION[oce.getOccupation()]%></label></td>
              </tr>
              <tr>
                <td nowrap class="td01">居住城区：</td>
                <td colspan="3"><label> <%=Ocean.URBAN_TYPE[oce.getUrban()]%></label></td>
              </tr>


              <tr>
                <td nowrap class="td01">您的邮寄地址：</td>
                <td colspan="3"><label>
                  <%if(oce.getAddress()!=null)out.print(oce.getAddress());%>
</label></td>
              </tr>
              <tr>
                <td nowrap class="td01">邮政编码：</td>
                <td> <%if(oce.getZip()!=null)out.print(oce.getZip());%></td>
                <td nowrap class="td03">电子邮箱：</td>
                <td><label>
                  <%if(oce.getEmail()!=null)out.print(oce.getEmail());%>
</label></td>
              </tr>
              <tr>
                <td nowrap class="td01">您全家月收入：</td>
                <td nowrap><label>
                  <%=Ocean.INCOME[oce.getIncome()]%></label></td>

                <td nowrap class="td01">信息获知途径：</td>
                <td nowrap><label> <%=Ocean.LEARN_WAY[oce.getLearnway()]%></label></td>
              </tr>
              <tr>
                <td nowrap class="td01">您和宝宝的兴趣爱好：</td>
                <td colspan="3">
                  <label>
                  <%
                      for(int i = 1;i<oce.getBobo_interest().split("/").length;i++)
                      {
                        out.print(Ocean.BOBO_INTEREST[Integer.parseInt(oce.getBobo_interest().split("/")[i])]+"&nbsp;");
                      }
                  %>
                  </label>
                </td>
              </tr>
              <%
                if(oce.getBobo_interest_qita()!=null && oce.getBobo_interest_qita().length()>0)
                {
                  out.print("<tr>");
                  out.print("<td>&nbsp;</td>");
                   out.print("<td>");
                   out.print("其他:&nbsp;");
                   out.print(oce.getBobo_interest_qita());
                  out.print("</td>");
                  out.print("</tr>");
                }
              %>

              <tr>
                <td colspan="4">您感兴趣的会员活动和您希望我们举办的活动如下：</td>
              </tr>
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
                          out.print("<tr><td></td><td nowrap colspan=3>"+Ocean.INTEREST[i]+"</td>");
                          out.print("</tr>");
                        }
                      }
                    }
                  }
                }

              }
              %>
              <tr>
                <td nowrap class="td01">是否允许代领:</td><td colspan="3">
                  <label>
                    <%if(oce.getReplacetype()==0){out.print("否");}else{out.print("是");}%>
                  </label></td>
              </tr>

              <tr>
                <td colspan="4" align="center" class="tetd03"><input type="submit" value="" class="Confirmed"/>
                  　<input type="button" value=""  onclick="window.open('/jsp/ocean/EditOceanRoll.jsp?oceanorder=<%=oce.getOceanorder()%>&ids=<%=ids%>','_self');" class="Re_fill"/></td>
              </tr>

        </table>
        </form>
      </div>
    </div>
</div>
<div class="footer">Copyright(c)2001-2005 北京海洋馆·版权所有 地址：北京海淀区高粱桥斜街乙18号（北京动物园北门内）<br/>
定票热线：（010）62123910 网址：www.BJ-sea.com</div>
</div>
</body>
</html>
