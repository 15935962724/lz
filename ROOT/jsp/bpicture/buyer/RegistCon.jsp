<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.bpicture.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.resource.*" %>
<%
TeaSession teasession =new TeaSession(request);
Community community=Community.find(teasession._strCommunity);
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
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
%>
<HTML>
  <HEAD>
    <SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script type="">

      function checked(form)
{

 if(document.getElementById('rep1').checked)
 {
   if(document.getElementById('idnum').checked){
   return submitterms(form.chequeterms,'无效-协议')
   &&checkImg(form.ID1,'身份证复印件格式不正确，请重新选择！')
   &&checkImg(form.ID2,'身份证复印件格式不正确，请重新选择！')
   &&checkImg(form.testpic1,'无效-图片格式')
   &&checkImg(form.testpic2,'无效-图片格式')
   &&checkImg(form.testpic3,'无效-图片格式')
   &&checkImg(form.testpic4,'无效-图片格式')
   &&checkImg(form.testpic5,'无效-图片格式');
   }else{
   return submitterms(form.chequeterms,'无效-协议')
   &&checkImg(form.armycard1,'军官证复印件格式不正确，请重新选择！')
   &&checkImg(form.armycard2,'军官证复印件格式不正确，请重新选择！')
   &&checkImg(form.testpic1,'无效-图片格式')
   &&checkImg(form.testpic2,'无效-图片格式')
   &&checkImg(form.testpic3,'无效-图片格式')
   &&checkImg(form.testpic4,'无效-图片格式')
   &&checkImg(form.testpic5,'无效-图片格式');
   }

 }else{

   if(document.getElementById('idnum').checked){
    return submitText(form.comname,'无效-公司名称')&&submitjob(form.comstyle,'请选择公司类型')&&submitterms(form.chequeterms,'无效-协议')
   &&checkImg(form.ID1,'无效-图片格式')
   &&checkImg(form.ID2,'无效-图片格式')
   &&checkImg(form.testpic1,'无效-图片格式')
   &&checkImg(form.testpic2,'无效-图片格式')
   &&checkImg(form.testpic3,'无效-图片格式')
   &&checkImg(form.testpic4,'无效-图片格式')
   &&checkImg(form.testpic5,'无效-图片格式');
   }else{

    return submitText(form.comname,'无效-公司名称')
   &&submitjob(form.comstyle,'请选择公司类型')
   &&submitterms(form.chequeterms,'无效-协议')
   &&checkImg(form.armycard1,'无效-图片格式')
   &&checkImg(form.armycard2,'无效-图片格式')
   &&checkImg(form.testpic1,'无效-图片格式')
   &&checkImg(form.testpic2,'无效-图片格式')
   &&checkImg(form.testpic3,'无效-图片格式')
   &&checkImg(form.testpic4,'无效-图片格式')
   &&checkImg(form.testpic5,'无效-图片格式');
   }

 }

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

    function checkImg(text,alerttext)
    {
      if(text.value.length>0){
        var i=text.value.lastIndexOf(".");
        var ext=text.value.substring(i);
        var  ext1=ext.toLowerCase();
        if(ext1!=".jpg" && ext1!=".jpeg" && ext1!=".gif" && ext1!=".bmp")
        {
          alert(alerttext);
          text.focus();
          return false;
        }
        return true;
      }
      return true;
    }

    function submitterms(text,alerttext)
    {
      if(!text.checked){
        alert(alerttext);
        text.focus();
        return false;
      }
      return true;
    }
    </script>
    <style>
    #dv1{width:100%;text-align:right;font-size:12px;height:55px;background:url(/res/bigpic/u/0812/081255616.jpg) no-repeat 10 5;color:#0000CC;}
    .lzj_a{margin:0 10px;color:#0000CC; text-decoration:none;margin-top:8px;}
    #tablecenter001{border-top:1px solid #67A7E4;background:#D6E6FF;font-size:12px;color:#000;height:28px;line-height:28px;padding-left:15px;}
    #tablecenter001 a{color:#0000ff;}
    .t{margin:12px 0;height:20px;line-height:20px;width:100%;font-size:14px;font-weight:bold;background:url(/res/bigpic/u/0812/081243709.gif) no-repeat 25 2;padding-left:45px;}
    .top{border-top:1px solid #cccccc;margin-top:19px;}
    .top td{font-size:12px;line-height:150%;}
    .top td a{color:#0000CC;}
    /**/
    .lzj_001{display:block;height:25px;	line-height:25px;text-indent: 3em;}
    .lzj_002{display:block;height:25px;line-height:25px;font-weight:bold;text-indent: 1em;}
    .lzj_zj{background:#F6F6F6;border-top:10px solid #eeeeee;border-bottom:10px solid #eeeeee;font-size:12px;line-height:150%;width:700px;margin:0 auto;}
    .lzj_zj table td{font-size:12px;}
    #legalentity,.inputfield,#0001,#0002,#state,#addr,#zip,#mobile,#phone,#chequepayee,#sheing,#chequecounty,#chequeaddr,#chequezip{width:300px;height:22px;border:1px solid #809EBA;background:#fff;line-height:22px;font-size:12px;}
    #textarea{width:300px;height:50px;}
    #lzj_an{width:45px;height:23px;background:url(/res/bigpic/u/0812/081243710.jpg) no-repeat;border:0;margin:0 10px;}
    </style>
  </HEAD>
  <body style="margin:0;padding:0;">
  <div id="jspbefore">
  </div>
  <div style="text-align:left;" id="li_biao">　><a href="http://bp.redcome.com">首页</a>>供应商信息</div>
  <div style="text-align:left;" class="t">完善资料</div>
  <!---->
  <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td>
        <div class="lzj_zj">

          <form name="form1" method="post" action="/servlet/EditBPperson" enctype="multipart/form-data" onSubmit="return checked(this);">
          <input type="hidden" name="member" value="<%=member%>"/>
          <input type="hidden" name="act" value="upper"/>
          <input type="hidden" name="bts" value="bts"/>
          <input type="hidden" name="url" value="<%=request.getRequestURI()%>"/>

          <div id="lzj_gxz">
            <span class="lzj_002">为了进一步完善卖家注册，B-p提醒您，您需要：</span>
            <span class="lzj_001">	签署 <a href="#" onclick="window.open('/servlet/Node?node=2199994','_blank');">《供应商协议》</a></span>
            <span class="lzj_001">	提供您得联系地址并选择付薪方式</span>
          </div>
          <!--注册-->
          <table width="100%" border="0" align="center" cellpadding="5" cellspacing="0">
            <tr>
              <td height="40" colspan="2"><b></b></td>
            </tr>
            <tr>
              <td height="40" colspan="2"><b>——完善供应商资料———————————————————————————————————</b></td>
            </tr>
            <tr>
              <td colspan="2"><span style="color:#0265CB;"><b>*</b></span> 为必填项，B-p承诺将尊重并维护您的信息安全。详见 <a href="#" onclick="window.open('/servlet/Node?node=2198281','_blank');">《隐私政策》</a></td>
            </tr>
            <tr>
              <td align="right" valign="top">您所代表的是</td>
              <td><input id="rep1" type="radio" name="represent" value="1" <%if(represent.equals("1")){out.print("checked");}%> onclick="showcom('1')"/>&nbsp;个人<br/>
                <input id="rep2" type="radio" name="represent" value="0" <%if(represent.equals("0")){out.print("checked");}%> onclick="showcom('2')"/>&nbsp;公司</td>
            </tr>
            <tr>
              <td align="right">接受并同意<a href="#" onclick="window.open('/servlet/Node?node=2199994','_blank');">《供应商协议》</a></td>
              <td>注册成为B-p的签约供应商，您需要接受并同意
                <a href="#" onclick="window.open('/servlet/Node?node=2199994','_blank');">《供应商协议》</a>.</td>
            </tr>
            <tr>
              <td align="right">&nbsp;<span style="color:#0265CB;"><b>*</b></span></td>
              <td><input id="agreement" type="checkbox" name="chequeterms"  value="1"/>
                <label for="agreement">我接受并同意<a href="#" onclick="window.open('/servlet/Node?node=2199994','_blank');">《供应商协议》</a></label></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr id="com1" <%if(represent.equals("1")){out.print("style=display:none;");}%>>
              <td align="right">公司名称&nbsp;<span style="color:#0265CB;"><b>*</b></span></td>
              <td><input name="comname" type="text" maxlength="80" id="comname" class="inputfield" value="<%if(bp.getComName()!=null)out.print(bp.getComName());%>" /></td>
            </tr>
            <tr id="com2" <%if(represent.equals("1")){out.print("style=display:none;");}%>>
              <td align="right">公司类型&nbsp;<span style="color:#0265CB;"><b>*</b></span></td>
              <td><select name="comstyle" id="selCompanyType">
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
                </select></td>
            </tr>
            <tr>
              <td width="39%" align="right">所属于地区</td>
              <td>
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
              <td align="right">城市</td>
              <td><input name="city" type="text" maxlength="35" id="city" class="inputfield" value="<%if(bp.getCity()!=null)out.print(bp.getCity());%>"/></td>
            </tr>
            <tr>
              <td align="right">地址</td>
              <td><input name="addr" type="text" maxlength="35" id="addr" class="inputfield" value="<%if(bp.getAddr()!=null)out.print(bp.getAddr());%>"/></td>
            </tr>
            <tr>
              <td align="right">邮编</td>
              <td><input name="zip" type="text" maxlength="25" id="zip" class="inputfieldsmall" value="<%if(bp.getZip()!=null)out.print(bp.getZip());%>" /></td>
            </tr>
            <tr>
      <td align="right">从事摄影年限</td>

      <td> <select id="state" name="photoyear">
            <%
                for(int i=0;i<Common.PHOTOYEAR.length;i++)
                {
                  out.print("<option value="+Common.PHOTOYEAR[i][0]+" >"+Common.PHOTOYEAR[i][1]);
                }
                %>
          </select></td>
    </tr>
    <tr>
      <td align="right">主要摄影题材</td>

      <td> <table style="font-size:12px;line-height:150%;">
      <tr>

            <%
                for(int i=0;i<Common.PHMETERIA.length;i++)
                {

                  out.print("<td><input type=checkbox name=meteria value="+Common.PHMETERIA[i][0]+" >"+Common.PHMETERIA[i][1]+"</td>");
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
      <td align="right">作品主要载体</td>

      <td> <table style="font-size:12px;line-height:150%;">
      <tr>

            <%
                for(int i=0;i<Common.PHVECTOR.length;i++)
                {
                  out.print("<td><input type=checkbox name=vector value="+Common.PHVECTOR[i][0]+" >"+Common.PHVECTOR[i][1]+"</td>");
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
      <td colSpan="3">&nbsp;</td>
    </tr>
            <tr>
              <td align="right">证件类型</td>
              <td><input id="idnum" type="radio" name="cardtype" value="1" checked="checked" onclick="checard('1');"/>&nbsp;身份证　　<input id="armynum" type="radio" name="cardtype" value="2" onclick="checard('2');"/>&nbsp;军官证</td>
            </tr>
            <tr id="idcard">
              <td align="right">身份证复印件</td>
              <td><input type="file" name="ID1"/>(正面)<br />
                <input type="file" name="ID2"/>(反面)　<br />请上传身份证的正反两面复印件以便管理员进行审核</td>
            </tr>
            <tr id="armycard" style="display:none;">
              <td align="right">军官证复印件</td>
              <td><input type="file" name="armycard1"/>(正面)<br />
                <input type="file" name="armycard2"/>(反面)　<br />请上传军官证的正反两面复印件以便管理员进行审核</td>
            </tr>
            <tr>
              <td align="right">上传样图</td>
              <td><input type="file" name="testpic1"/><br />
                <input type="file" name="testpic2"/><br />
                <input type="file" name="testpic3"/><br />
                <input type="file" name="testpic4"/><br />
                <input type="file" name="testpic5"/><br /></td>
            </tr>
            <tr>
              <td colspan="2" align="center"><input type="submit" name="NextBtn2" value="完成" id="lzj_an"/>
            </tr>
          </table>
          </form>
        </div>
              </td>
    </tr>
  </table>

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
  </script>
  </body>
</HTML>

