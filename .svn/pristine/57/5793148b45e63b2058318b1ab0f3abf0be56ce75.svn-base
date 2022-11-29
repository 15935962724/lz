<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
response.setCharacterEncoding("UTF-8");

TeaSession teasession =new TeaSession(request);

Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

if(teasession._rv==null)
{
  response.sendRedirect("/jsp/user/StartLogin.jsp?nexturl="+request.getRequestURI());
}
String member = request.getParameter("member");
if(member == null)
{
  member = teasession._rv._strR;
}

Bperson bp = Bperson.findmember(member);
String represent = "1";
if(bp.getRepresent()!=null){
  represent = bp.getRepresent();
}

String nexturl = request.getRequestURI();
if(teasession.getParameter("forword")!=null){
  nexturl = "/jsp/bpicture/saler/SalerManagement.jsp";
}


%>
<html>
<!-- Stock photography -->
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<title>个人信息显示</title>
<script src="/tea/tea.js" type="text/javascript"></script>

<style>
.big{text-align:left;font-size:14px;margin:10 30px;}
#table001{background:#F6F6F6;border-bottom:5px solid #eee;border-top:5px solid #eee;padding:6px;}
#table001 td{padding:5px;}
#email,#firstname,#oldpwd,#newpwd,#confirmpwd，#addr1,#state,#zip,#Company,#MobilePhone,#ContactPhone{width:300px;height:22px;font-size:12px;line-height:15px;border:1px solid #7F9DB9;}
#submit,.Button{width:70px;height:22px;font-size:12px;line-height:15px;border:1px solid #7F9DB9;background:#fff;padding-bottom:5px;*padding-bottom:0;}
</style>
</head>




<body style="margin:0;">
<div id="wai">

  <div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;个人信息显示</div>
  <h1>个人信息显示</h1>

  <div class="big"><strong>1. 基本信息</strong></div>

  <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="bg8" id="table001">

    <FORM METHOD=post ACTION="?"  id=frmContactDetails name="form1" enctype="multipart/form-data" onSubmit="return check(this);">

      <tr>
<td valign="top" align="right">您所代表的是</td>
<td>
</td>
<td><%if(represent.equals("1")){out.print("个人");}%>&nbsp;<br/>
 <%if(represent.equals("0")){out.print("公司");}%>&nbsp;</td>
</tr>

      <tr id="com1" <%if(represent.equals("1")){out.print("style=display:none;");}%>>
        <td width="300" align="right">公司名称</td>
        <td class="red">&nbsp;</td> <td>
          <%if(bp.getComName()!=null){out.print(bp.getComName());}%></td>
      </tr>
      <tr id="com2"  <%if(represent.equals("1")){out.print("style=display:none;");}%>>
        <td width="300" align="right">公司类型</td>
        <td class="red">&nbsp;</td> <td>

            <%
            for(int i=0;i<Common.COMPANYSTYLE.length;i++)
            {
              if(Common.COMPANYSTYLE[i][0].equals(bp.getComStyle())){
                out.print(Common.COMPANYSTYLE[i][1]);
              }
            }
            %>

        </td>
      </tr>

      <tr>
        <td width="300" align="right">所属地区</td>
        <td width="1%" class="red"></td> <td>

          <%
          for(int i=0;i<Common.CSVCITYS.length;i++)
          {
            if(Common.CSVCITYS[i][0].equals(bp.getState())){
              out.print(Common.CSVCITYS[i][1]);
            }
          }
          %>

       </td>
      </tr>
      <tr>
        <td width="300" align="right">城市</td>
        <td class="red">&nbsp;</td> <td>
          <%if(bp.getCity()!=null){out.print(bp.getCity());}%></td>
      </tr>
      <tr>
        <td width="300" align="right">地址 </td>
        <td width="1%"></td> <td>
          <%if(bp.getAddr()!=null){out.print(bp.getAddr());}%></td>
      </tr>
      <tr>
        <td width="300" align="right">邮编</td>
        <td width="1%" class="red"><b>&nbsp;</b></td> <td>
          <%if(bp.getZip()!=null){out.print(bp.getZip());}%></td>
      </tr>
      <tr>
        <td width="300" align="right">手机</td>
        <td width="1%" class="red"></td><td>
          <%if(bp.getMobile()!=null){out.print(bp.getMobile());}%></td>
      </tr>
      <tr>
        <td width="300" align="right">联系电话</td>
        <td width="1%"></td> <td>
          <%if(bp.getPhone()!=null){out.print(bp.getPhone());}%></td>
      </tr>
      <tr>
        <td width="300" align="right">MSN</td>
        <td class="red">&nbsp;</td> <td>
          <%if(bp.getMSN()!=null)out.print(bp.getMSN());%></td>
      </tr>
      <%if(bp.getRegStyle()==0){%>
      <tr>
        <td width="300" align="right">从事摄影年限</td>
        <td width="1%"></td> <td>
          <%
          for(int i=0;i<Common.PHOTOYEAR.length;i++)
          {
            if(Integer.parseInt(Common.PHOTOYEAR[i][0])==bp.getPhyear()){
              out.print(Common.PHOTOYEAR[i][1]);
            }
          }
          %>
          </td>
      </tr>
      <tr>
        <td width="300" align="right">主要摄影题材</td>
        <td width="1%"></td><td>
          <table style="font-size:12px;line-height:150%;">
            <tr>
            <%
            String met = "0";
            if(bp.getMeteria()!=null)
            {
              met = bp.getMeteria();
            }
            for(int i=0;i<Common.PHMETERIA.length;i++)
            {
              if(met.contains(Common.PHMETERIA[i][0])){
                out.print("<td>"+Common.PHMETERIA[i][1]+"</td>");
              }
              if(i==4)
              {
                out.print("</tr><tr>");
              }
            }
            %>
            </tr>
          </table>
                </td>
            </tr>
            <tr>
              <td width="300" align="right">作品主要载体</td>
              <td width="1%"></td> <td>
                <table style="font-size:12px;line-height:150%;">
                  <tr>
                  <%
                  String vet = "0";
                  if(bp.getVector()!=null)
                  {
                    vet = bp.getVector();
                  }
                  for(int i=0;i<Common.PHVECTOR.length;i++)
                  {
                    if(vet.contains(Common.PHVECTOR[i][0])){
                      out.print("<td>"+Common.PHVECTOR[i][1]+"</td>");
                    }
                    if(i==2)
                    {
                      out.print("</tr><tr>");
                    }
                  }
                  %>
                  </tr>
                </table>
                      </td>
                  </tr>
                  <tr>
                    <td align="right">证件类型</td><td width="1%"></td>
                    <td><%if(bp.getCard()==null){out.print("暂无");}if(bp.getCard()!=null&&bp.getCard().split("!")[0].equals("1")){out.print("身份证");}else{out.print("军官证");}%></td>
                  </tr>
                  <tr id="idcard" <%if(bp.getCard()!=null&&!bp.getCard().split("!")[0].equals("1")){out.print("style=\"display:none;\"");}%>>
                    <td align="right">身份证复印件</td><td width="1%"></td>

                    <td>
                    <%
                    String cd1 = "",cd2="";
                    if(bp.getCard()!=null){
                      String cardArray[] = bp.getCard().split("!");
                      for(int z = 0; z < cardArray.length; z++){
                        if(z==1){
                          cd1 = cardArray[1];
                        }
                        if(z == 2){
                          cd2 = cardArray[2];
                        }
                      }
                    }

                    %>
                      (正面)
                    <%if(bp.getCard()!=null&&bp.getCard().split("!")[0].equals("1")&&cd1.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getCard().split("!")[1]+"&name="+java.net.URLEncoder.encode("身份证复印件（正面）","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;身份证复印件（正面）</a>");} %><br />
                      (背面)
                      <%if(bp.getCard()!=null&&bp.getCard().split("!")[0].equals("1")&&cd2.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getCard().split("!")[2]+"&name="+java.net.URLEncoder.encode("身份证复印件（背面）","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;身份证复印件（背面）</a>");} %>
                      <br /><br />请上传身份证的正反两面复印件以便管理员进行审核</td>
                  </tr>
                  <tr id="armycard" <%if(bp.getCard()==null){out.print("style=\"display:none;\"");}if(bp.getCard()!=null&&!bp.getCard().split("!")[0].equals("2")){out.print("style=\"display:none;\"");}%>>
                    <td align="right">军官证复印件</td><td width="1%"></td>
                    <td>
                      (正面)
                      <%if(bp.getCard()!=null&&bp.getCard().split("!")[0].equals("2")&&cd1.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getCard().split("!")[1]+"&name="+java.net.URLEncoder.encode("军官证复印件（正面）","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;军官证复印件（正面）</a>");} %><br />
                      (背面)　
                      <%if(bp.getCard()!=null&&bp.getCard().split("!")[0].equals("2")&&cd2.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getCard().split("!")[2]+"&name="+java.net.URLEncoder.encode("军官证复印件（背面）","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;军官证复印件（背面）</a>");} %>
                      <br /><br />请上传军官证的正反两面复印件以便管理员进行审核</td>
                  </tr>
                  <tr>
                    <td align="right">上传样图</td><td width="1%"></td>
                    <td>
                    <%
                     String testpic1 = "",testpic2="",testpic3="",testpic4="",testpic5="";
                    if(bp.getTestpic()!=null){
                      String testpicArray[] = bp.getTestpic().split("!");
                      for(int z = 0; z < testpicArray.length; z++){
                        if(z==0){
                          testpic1 = testpicArray[0];
                        }
                        if(z == 1){
                          testpic2 = testpicArray[1];
                        }
                        if(z == 2){
                          testpic3 = testpicArray[2];
                        }
                        if(z == 3){
                          testpic4 = testpicArray[3];
                        }
                        if(z == 4){
                          testpic5 = testpicArray[4];
                        }
                      }
                    }
                    %>

                      <%if(bp.getTestpic()!=null&&testpic1.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getTestpic().split("!")[0]+"&name="+java.net.URLEncoder.encode("样图1","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;样图1</a>");} %>
                      <br />

                      <%if(bp.getTestpic()!=null&&testpic2.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getTestpic().split("!")[1]+"&name="+java.net.URLEncoder.encode("样图2","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;样图2</a>");} %>
                      <br />

                      <%if(bp.getTestpic()!=null&&testpic3.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getTestpic().split("!")[2]+"&name="+java.net.URLEncoder.encode("样图3","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;样图3</a>");} %>
                      <br />

                      <%if(bp.getTestpic()!=null&&testpic4.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getTestpic().split("!")[3]+"&name="+java.net.URLEncoder.encode("样图4","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;样图4</a>");} %>
                      <br />

                      <%if(bp.getTestpic()!=null&&testpic5.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getTestpic().split("!")[4]+"&name="+java.net.URLEncoder.encode("样图5","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;样图5</a>");} %>
                      <br /></td>
                  </tr>

                  <%}%>

    </FORM>

  </table>
  <div class="big"><strong>2. 付款信息</strong></div>
  <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="bg8" id="table001">
  <tr>
      <td width="300" align="right">
      付款方法
      </td><td width="1%"></td>
      <td>
      <%if(bp.getPayStyle()==0){
        out.print("支票");
      }else if(bp.getPayStyle()==1){
        out.print("转帐");
      }else{
        out.print("&nbsp;");
      }%>
      </td>
    </tr>

    <tr>
    <td colspan="2" height="5"></td>
    </tr>
    </table>

    <div id="cheque" <%if(bp.getPayStyle()!=0){out.print("style=\"display:none;\"");}%>>
    <h2>支票信息</h2>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="bg8" id="table001">
    <tr>
      <td width="300" align="right">
      支票收款人
      </td><td width="1%"></td>
      <td><%if(bp.getChequePayee()!=null)out.print(bp.getChequePayee());%></td>
    </tr>
    <tr>
      <td align="right">发送支票地址</td><td width="1%"></td>
      <td><%if(bp.getChequeCounty()!=null)out.print(bp.getChequeCounty());%></td>
    </tr>
    <tr>
      <td>　</td><td width="1%"></td>
      <td><%if(bp.getChequeCity()!=null)out.print(bp.getChequeCity());%></td>
    </tr>
    <tr>
      <td>　</td><td width="1%"></td>
      <td><%if(bp.getChequeAddr()!=null)out.print(bp.getChequeAddr());%></td>
    </tr>
    <tr>
      <td align="right">邮编</td><td width="1%"></td>
      <td><%if(bp.getChequeZip()!=null)out.print(bp.getChequeZip());%></td>
    </tr>

  </table>
  </div>

  <div id="transfer" <%if(bp.getPayStyle()!=1){out.print("style=\"display:none;\"");}%>>
    <h2>转帐信息</h2>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="bg8" id="table001">
    <tr>
      <td width="300" align="right">
      开户行
      </td><td width="1%"></td>
      <td><%if(bp.getBank()!=null)out.print(bp.getBank());%></td>
    </tr>
    <tr>
      <td align="right">户名</td><td width="1%"></td>
      <td><%if(bp.getAccount()!=null)out.print(bp.getAccount());%></td>
    </tr>
    <tr>
      <td align="right">帐号</td><td width="1%"></td>
      <td><%if(bp.getAccountnum()!=0)out.print(bp.getAccountnum());%></td>
    </tr>
  </table>
  </div>

  <div id="invoice" <%if(bp.getInvmen()!=null){out.print("style=\"\"");}else{out.print("style=\"display:none;\"");}%>>
    <h2>发票信息</h2>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="bg8" id="table001">
    <tr>
      <td width="300" align="right">
      收件人
      </td><td width="1%"></td>
      <td><%if(bp.getInvmen()!=null)out.print(bp.getInvmen());%></td>
    </tr>
    <tr>
      <td align="right">地址</td><td width="1%"></td>
      <td><%if(bp.getInvaddr()!=null)out.print(bp.getInvaddr());%></td>
    </tr>
    <tr>
      <td align="right">邮编</td><td width="1%"></td>
      <td><%if(bp.getInvzip()!=null)out.print(bp.getAccountnum());%></td>
    </tr>
    <tr>
      <td align="right">公司名</td><td width="1%"></td>
      <td><%if(bp.getInvcomname()!=null)out.print(bp.getInvcomname());%></td>
    </tr>



  </table>
  </div>
  <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="bg8" id="table001">
  <tr valign="bottom">
  <td width="300"  ></td>
  <td colspan="2">
    <input id="submit" type="button" value="返回" onclick="window.history.go(-1);"/>
  </td>
  </tr>
  </table>
</div>

</body>

<!-- Stock photography -->
</html>
