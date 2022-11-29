<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.bpicture.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.resource.*" %>
<%
TeaSession teasession =new TeaSession(request);
Community community=Community.find(teasession._strCommunity);
String email = request.getParameter("email");
if(email == null)
{
  email = teasession._rv._strR;
}
int bpid = Bperson.findId(email);

Bperson bp = Bperson.find(bpid);

Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
%>
<HTML>
  <HEAD>
    <SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
    <script type="">
    function checked(form)
    {
      return submitText(form.represent,'无效-代表名')
      &&submitterms(form.chequeterms,'无效-协议')
      &&submitText(form.chequepayee,'无效-支票收款人')
      &&checkImg(form.card,'无效-图片格式');
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
    <%=community.getJspBefore(teasession._nLanguage)%>
  </div>
 <div style="text-align:left;" id="li_biao">　><a href="http://bp.redcome.com">首页</a>>卖家注册</div>
    <div class="t">卖家注册</div>
    <!---->
    <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td>
          <div class="lzj_zj">

            <form name="form1" method="post" action="/servlet/EditBPperson" enctype="multipart/form-data" onSubmit="return checked(this);">
            <input type="hidden" name="email" value="<%=email%>"/>
            <input type="hidden" name="act" value="upper"/>
            <input type="hidden" name="pid" value="<%=bpid%>"/>

            <div id="lzj_gxz">
              <span class="lzj_002">为了完成您的注册作为一个卖家，请您:</span>
              <span class="lzj_001">确定 <a href="#" onclick="window.showModalDialog('/servlet/Node?node=2198280','_blank','dialogWidth:450px;dialogHeight:600px;dialogLeft:750px;dialogTop:240px;help:no');">卖家合同</a> 由B-picture平台出售图片，并获得65 ％的佣金.</span>
              <span class="lzj_001">请提供您的支票地址，以支票缴款.</span>
              <span class="lzj_002">如果您没有这些细节，您可以通过&nbsp;<font color="#0000EE">我的Bpicture</font>&nbsp;进行信息的修改.</span>
            </div>
            <!--注册-->
            <table width="100%" border="0" align="center" cellpadding="5" cellspacing="0">
              <tr>
                <td height="40" colspan="2"><b>&nbsp;&nbsp;&nbsp;&nbsp;注册</b></td>
              </tr>
              <tr>
              <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;我们需要这方面的资料。为了尊重您的
              隐私和储存您的详细信息安全。详见 <a href="#" onclick="window.showModalDialog('/servlet/Node?node=2198281','_blank','dialogWidth:1000px;dialogHeight:600px;dialogLeft:750px;dialogTop:240px;help:no');">隐私政策</a></td>
              </tr>
              <tr>
                <td height="30" colspan="2"><b>&nbsp;&nbsp;&nbsp;&nbsp;您的B-picture合同</b></td>
              </tr>
              <tr>
                <td width="25%" align="right" valign="top">您代表谁? </td>
                <td width="75%">如果您是代表公司，输入其名称.</td>
              </tr>
              <tr>
              <td align="right">&nbsp;</td>
                <td>如果您是个人摄影师，输入您的姓名.</td>
              </tr>
              <tr>
              <td align="right">&nbsp;<span style="color:#0265CB;"><b>*</b></span></td>
                <td><input name="represent" type="text" maxlength="80" id="legalentity" tabindex="100" title="Who do you represent?" class="margin inputfield" /></td>
              </tr>
              <tr>
                <td align="right">同意卖家合同：</td>
              <td>注册成为B-picture的卖家 ，您将同意
              <a href="#" onclick="window.showModalDialog('/servlet/Node?node=2198280','_blank','dialogWidth:450px;dialogHeight:600px;dialogLeft:750px;dialogTop:240px;help:no');">卖家合同</a>. 任何你所销售的图像，您将收到65 ％的利润.</td>
            </tr>
              <tr>
                <td align="right">&nbsp;<span style="color:#0265CB;"><b>*</b></span></td>
                <td><input id="agreement" type="checkbox" name="chequeterms" tabindex="110" value="1"/>
                  <label for="agreement">我同意B-picture的卖家合同</label></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>

              <tr>
                <td height="40" colspan="2"><b>&nbsp;&nbsp;&nbsp;&nbsp;联系信息</b></td>
              </tr>
              <tr>
                <td align="right">公司名称：</td>
                <td><input name="comname" type="text" maxlength="80" id="comname" tabindex="10" title="Your company name" class="inputfield" value="<%=bp.getComName()%>" /></td>
              </tr>
              <tr>
                <td width="39%" align="right">省 / 市:</td>
        <td>
          <select id="city" name="city">
          <%
          for(int i=0;i<Common.CSVCITYS.length;i++)
          {
            if(Common.CSVCITYS[i][0].equals(bp.getCity())){
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
                <td align="right">区 / 县：</td>
                <td><input name="state" type="text" maxlength="35" id="state" tabindex="30" title="County or state" class="inputfield" value="<%=bp.getState()%>"/></td>
              </tr>
              <tr>
                <td align="right">地址：</td>
                <td><input name="addr" type="text" maxlength="35" id="addr" tabindex="40" title="Contact address line 1" class="inputfield" value="<%=bp.getAddr()%>" /></td>
              </tr>
              <tr>
                <td align="right">邮编：</td>
                <td><input name="zip" type="text" value="<%=bp.getZip()%>" maxlength="25" id="zip" tabindex="50" title="Postcode or Zip" class="inputfieldsmall" /></td>
              </tr>
              <tr>
                <td align="right">手机：</td>
                <td><input name="mobile" type="text" maxlength="50" id="mobile" tabindex="60" title="Your mobile phone number" class="inputfieldsmall" value="<%=bp.getMobile()%>" /></td>
              </tr>
              <tr>
                <td align="right">联系电话：</td>
                <td><input name="phone" type="text" value="<%=bp.getPhone()%>" maxlength="50" id="phone" tabindex="70" title="Your telephone number" class="inputfieldsmall" /></td>
              </tr>
              <tr>
                <td align="right">支票收款人：</td>
                <td>我们应该向谁使用支票？通常
                  您的姓名或公司的名称.</td>
              </tr>
              <tr>
                <td align="right">&nbsp;<span style="color:#0265CB;"><b>*</b></span></td>
                <td><input name="chequepayee" type="text" maxlength="80" id="chequepayee" tabindex="80" title="Cheque payee" class="margin inputfield" /></td>
              </tr>
              <tr>
                <td align="right">发送支票..：</td>
                <td><input id="samecontact" type="checkbox" name="samecontact" onClick="check(this.checked);" tabindex="90" />
                  如果这是一样的上述联系地址.</td>
              </tr>
              <tr>
                <td align="right">省 / 市：</td>
                <td><input type="text" name="chequecity" id="sheing" tabindex="100"/></td>
              </tr>
              <tr>
                <td align="right">区 / 县：</td>
                <td><input name="chequecounty" type="text" maxlength="35" id="chequecounty" tabindex="110" title="County or state" class="inputfield" /></td>
              </tr>
              <tr>
                <td align="right">地址：</td>
                <td><input name="chequeaddr" type="text" maxlength="35" id="chequeaddr" tabindex="1200" title="Address to send cheques, line 1" class="inputfield" /></td>
              </tr>
              <tr>
                <td align="right">邮编：</td>
                <td><input name="chequezip" type="text" maxlength="25" id="chequezip" tabindex="130" title="Postcode or zip" /></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td align="right">身份认证：</td>
                <td><input type="file" name="card"/>　说明：请上传一张身份证的图片以便管理员进行审核</td>
              </tr>
              <tr>
                <td height="40" colspan="2"><b>&nbsp;&nbsp;&nbsp;&nbsp;关于你的工作</b></td>
              </tr>
              <tr>
                <td align="right">其他机构所提交的图像?</td>
                <td><textarea name="textarea" rows="4" cols="12" id="textarea" tabindex="340" title="Tell us which agencies here" class="inputfield" style="FONT-SIZE: 14px; FONT-FAMILY: MS sans serif, Arial, Helvetica"></textarea></td>
              </tr>
              <tr>
                <td colspan="2" align="center"><input type="submit" name="NextBtn2" value="注册" id="lzj_an"/>
                &nbsp;
                <input type="reset" name="btnReset" value="重置" id="lzj_an"/></td>
              </tr>
            </table>

            </form>
          </div>
</td>
      </tr>
    </table>
<div id="jspafter">
      <%=community.getJspAfter(teasession._nLanguage)%>
    </div>
    <script type="">
    function check(a)
    {
      if(a)
      {
        document.form1.chequecity.value=document.form1.city.value;
        document.form1.chequecounty.value=document.form1.state.value;
        document.form1.chequeaddr.value=document.form1.addr.value;
        document.form1.chequezip.value=document.form1.zip.value;
      }else{
        document.form1.chequecity.value='';
        document.form1.chequecounty.value='';
        document.form1.chequeaddr.value='';
        document.form1.chequezip.value='';
      }
    }
    </script>
    </body>
</HTML>

