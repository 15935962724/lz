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
int bpid = Bperson.findId(member);
Bperson bp = Bperson.find(bpid);
String represent = "1";
if(bp.getRepresent()!=null){
  represent = bp.getRepresent();
}

String nexturl = request.getRequestURI();
if(teasession.getParameter("forword")!=null){
  nexturl = "/jsp/bpicture/saler/SalerManagement.jsp";
}

String viewInfo = teasession.getParameter("viewinfo");
%>
<html>
<!-- Stock photography -->
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<title>更改联络资料</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">

function check(form)
{
  alert(from.act.value);
  return submitjob(form.state,'请选择所属地区')
  &&submitInteger(form.zip,'无效-邮编')
  &&submitText(form.mobile,'无效-手机')
  &&submitInteger(form.mobile,'无效-手机')
  &&submitLength(11,12,form.mobile,'无效-手机');
}
function submitInteger(text, alerttext)
{if(text.value.length>0){
  if (isNaN(parseInt(text.value)))
  {
    alert(alerttext);
    text.focus();
    return false;
  }
  text.value=parseInt(text.value);
  return true;
}
return true;
}
function submitjob(text,alerttext)
{
  if(text.value.length==0||text.value=='00')
  {
    alert(alerttext);
    text.focus();
    return false;
  }
  return true;
}
</script>
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
<%
String titleName = "更改联系方式";
if(viewInfo!=null){
  titleName = "个人信息显示";

}

%>
  <div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;<%=titleName%></div>
  <h1><%=titleName%></h1>

  <div class="big"><strong>1. 联络资料</strong></div>

  <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="bg8" id="table001">
    <tr>
      <td colspan=4 ><br>
        <span class="eleven">星号 (<span class="red">*</span>) 表示必填字段.</span>
    </tr>
    <FORM METHOD=post ACTION="/servlet/EditBPperson"  id=frmContactDetails name="form1" enctype="multipart/form-data" onSubmit="return check(this);">
    <input type="hidden" name="upd" value="upd"/>
      <input type="hidden" name="act" <%if(bp.getRegStyle()==0){out.print("value=upper");}else{out.print("value=regbuy");}%>>
      <input type="hidden" name="url" value="<%=nexturl%>"/>
      <input type="hidden" name="member" value="<%=bp.getMember()%>"/>
      <tr>
<td valign="top" align="right">您所代表的是</td>
<td>
</td>
<td><input id="rep1" type="radio" name="represent" value="1" <%if(represent.equals("1")){out.print("checked");}%> onclick="showcom('1')"/>&nbsp;个人<br/>
<input id="rep2" type="radio" name="represent" value="0" <%if(represent.equals("0")){out.print("checked");}%> onclick="showcom('2')"/>&nbsp;公司</td>
</tr>

      <tr id="com1" <%if(represent.equals("1")){out.print("style=display:none;");}%>>
        <td width="300" align="right">公司名称</td>
        <td class="red">&nbsp;</td> <td>
          <input type="text" name="comname" maxlength="50" size=23 value="<%if(bp.getComName()!=null){out.print(bp.getComName());}%>" style="width:345"></td>
      </tr>
      <tr id="com2"  <%if(represent.equals("1")){out.print("style=display:none;");}%>>
        <td width="300" align="right">公司类型</td>

        <td class="red">&nbsp;</td> <td>
          <select name="comstyle">
            <option value="">请选择...</option>
            <%
            for(int i=0;i<Common.COMPANYSTYLE.length;i++)
            {
              if(Common.COMPANYSTYLE[i][0].equals(bp.getComStyle())){
                out.print("<option value="+Common.COMPANYSTYLE[i][0]+" selected>"+Common.COMPANYSTYLE[i][1]);
              }else{
                out.print("<option value="+Common.COMPANYSTYLE[i][0]+" >"+Common.COMPANYSTYLE[i][1]);
              }
            }
            %>
            </select>
        </td>
      </tr>

      <tr>
        <td width="300" align="right">所属地区</td>
        <td width="1%" class="red"><b>*</b></td> <td>
          <select id="city" name="state">
          <%
          for(int i=0;i<Common.CSVCITYS.length;i++)
          {
            if(Common.CSVCITYS[i][0].equals(bp.getState())){
              out.print("<option value="+Common.CSVCITYS[i][0]+" selected>"+Common.CSVCITYS[i][1]);
            }else{
              out.print("<option value="+Common.CSVCITYS[i][0]+">"+Common.CSVCITYS[i][1]);
            }
          }
          %>
          </select>
       </td>
      </tr>
      <tr>
        <td width="300" align="right">城市</td>
        <td class="red">&nbsp;</td> <td>
          <input type="text" name="city" id="state" maxlength="50" size=23 value="<%if(bp.getCity()!=null){out.print(bp.getCity());}%>" style="width:345"></td>
      </tr>
      <tr>
        <td width="300" align="right">地址 </td>
        <td width="1%"></td> <td>
          <input type="text" name="addr" id="addr1" maxlength="50" size=23 value="<%if(bp.getAddr()!=null){out.print(bp.getAddr());}%>" style="width:345"></td>
      </tr>
      <tr>
        <td width="300" align="right">邮编</td>
        <td width="1%" class="red"><b>&nbsp;</b></td> <td>
          <input type="text" name="zip" id="zip" maxlength="25" size=23 value="<%if(bp.getZip()!=null){out.print(bp.getZip());}%>" style="width:345"></td>
      </tr>
      <tr>
        <td width="300" align="right">手机</td>
        <td width="1%" class="red"><b>*</b></td><td>
          <input type="text" name="mobile" id="MobilePhone" maxlength="50" size=23 value="<%if(bp.getMobile()!=null){out.print(bp.getMobile());}%>" style="width:345"></td>
      </tr>
      <tr>
        <td width="300" align="right">联系电话</td>
        <td width="1%"></td> <td>
          <input type="text" name="phone" id="ContactPhone" maxlength="50" size=23 value="<%if(bp.getPhone()!=null){out.print(bp.getPhone());}%>" style="width:345"></td>
      </tr>
      <tr>
        <td width="300" align="right">MSN</td>
        <td class="red">&nbsp;</td> <td>
          <input type="text" name="MSN" id="state" maxlength="50" size=23 value="<%if(bp.getMSN()!=null)out.print(bp.getMSN());%>" style="width:345"></td>
      </tr>
      <%if(bp.getRegStyle()==0){%>
      <tr>
        <td width="300" align="right">从事摄影年限</td>
        <td width="1%"></td> <td>
          <select id="state" name="photoyear">
          <%
          for(int i=0;i<Common.PHOTOYEAR.length;i++)
          {
            if(Integer.parseInt(Common.PHOTOYEAR[i][0])==bp.getPhyear()){
              out.print("<option value="+Common.PHOTOYEAR[i][0]+" selected>"+Common.PHOTOYEAR[i][1]);
            }else{
              out.print("<option value="+Common.PHOTOYEAR[i][0]+" >"+Common.PHOTOYEAR[i][1]);
            }
          }
          %>
          </select></td>
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
                out.print("<td><input type=checkbox name=meteria value="+Common.PHMETERIA[i][0]+" checked>"+Common.PHMETERIA[i][1]+"</td>");
              }else{
                out.print("<td><input type=checkbox name=meteria value="+Common.PHMETERIA[i][0]+" >"+Common.PHMETERIA[i][1]+"</td>");
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
                      out.print("<td><input type=checkbox name=vector value="+Common.PHVECTOR[i][0]+" checked>"+Common.PHVECTOR[i][1]+"</td>");
                    }else{
                      out.print("<td><input type=checkbox name=vector value="+Common.PHVECTOR[i][0]+" >"+Common.PHVECTOR[i][1]+"</td>");
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
                    <td><input id="idnum" type="radio" name="cardtype" value="1" <%if(bp.getCard()==null){out.print("checked");}if(bp.getCard()!=null&&bp.getCard().split("!")[0].equals("1")){out.print("checked");}%> onclick="checard('1');"/>&nbsp;身份证　　<input id="armynum" type="radio" name="cardtype" <%if(bp.getCard()!=null&&bp.getCard().split("!")[0].equals("2")){out.print("checked");}%> value="2" onclick="checard('2');"/>&nbsp;军官证</td>
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
                      <input type="file"  name="ID1"/>(正面)
                    <%if(bp.getCard()!=null&&bp.getCard().split("!")[0].equals("1")&&cd1.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getCard().split("!")[1]+"&name="+java.net.URLEncoder.encode("身份证复印件（正面）","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;身份证复印件（正面）</a>");} %><br />
                      <input type="file" name="ID2"/>(背面)
                      <%if(bp.getCard()!=null&&bp.getCard().split("!")[0].equals("1")&&cd2.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getCard().split("!")[2]+"&name="+java.net.URLEncoder.encode("身份证复印件（背面）","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;身份证复印件（背面）</a>");} %>
                      <br /><br />请上传身份证的正反两面复印件以便管理员进行审核</td>
                  </tr>
                  <tr id="armycard" <%if(bp.getCard()==null){out.print("style=\"display:none;\"");}if(bp.getCard()!=null&&!bp.getCard().split("!")[0].equals("2")){out.print("style=\"display:none;\"");}%>>
                    <td align="right">军官证复印件</td><td width="1%"></td>
                    <td>
                      <input type="file"  name="armycard1"/>(正面)
                      <%if(bp.getCard()!=null&&bp.getCard().split("!")[0].equals("2")&&cd1.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getCard().split("!")[1]+"&name="+java.net.URLEncoder.encode("军官证复印件（正面）","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;军官证复印件（正面）</a>");} %><br />
                      <input type="file"  name="armycard2"/>(背面)　
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
                    <input type="file" name="testpic1"/>
                      <%if(bp.getTestpic()!=null&&testpic1.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getTestpic().split("!")[0]+"&name="+java.net.URLEncoder.encode("样图1","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;样图1</a>");} %>
                      <br />
                      <input type="file" name="testpic2"/>
                      <%if(bp.getTestpic()!=null&&testpic2.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getTestpic().split("!")[1]+"&name="+java.net.URLEncoder.encode("样图2","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;样图2</a>");} %>
                      <br />

                      <input type="file" name="testpic3"/>
                      <%if(bp.getTestpic()!=null&&testpic3.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getTestpic().split("!")[2]+"&name="+java.net.URLEncoder.encode("样图3","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;样图3</a>");} %>
                      <br />
                      <input type="file" name="testpic4"/>
                      <%if(bp.getTestpic()!=null&&testpic4.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getTestpic().split("!")[3]+"&name="+java.net.URLEncoder.encode("样图4","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;样图4</a>");} %>
                      <br />
                      <input type="file" name="testpic5"/>
                      <%if(bp.getTestpic()!=null&&testpic5.length()>0){out.print("<a href=/jsp/include/DownFile.jsp?uri="+bp.getTestpic().split("!")[4]+"&name="+java.net.URLEncoder.encode("样图5","utf-8")+".jpg><img src=\"/tea/image/netdisk/jpg.gif\" />&nbsp;样图5</a>");} %>
                      <br /></td>
                  </tr>

                  <%}%>
                  <tr valign="bottom">

                    <td colspan="2" ></td><td>
                    <%if(viewInfo !=null){%>
                    <input id="submit" type="button" value="返回" onclick="window.history.go(-1);"/>
                    <%}else{%>
                    <input id="submit" type="submit" name="submit" value="保存" class="button">&nbsp;<input id="submit" type="button" value="返回" onclick="window.history.go(-1);"/>
                    <%}%>
                    </td></tr>
    </FORM>

  </table>
</div>
<script type="">
 function checard(value)
  {
    if(value=='1')
    {
      document.getElementById('idcard').style.display='';
      document.getElementById('armycard').style.display='none';
    }else{
      document.getElementById('idcard').style.display='none';
      document.getElementById('armycard').style.display='';
    }
  }

      function showcom(value)
  {
    if(value=='1')
    {
      document.getElementById('com1').style.display='none';
      document.getElementById('com2').style.display='none';
    }else{
      document.getElementById('com1').style.display='';
      document.getElementById('com2').style.display='';
    }
  }

  var vi = '<%=viewInfo%>';
  if(vi!='null'){
    var len=document.form1.elements.length;
    var i;
    for (i=0;i<len-1;i++){

      document.form1.elements[i].disabled=true;
    }
  }

</script>
</body>

<!-- Stock photography -->
</html>
