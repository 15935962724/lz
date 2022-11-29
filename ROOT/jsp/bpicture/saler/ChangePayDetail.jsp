<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.io.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession = new TeaSession(request);
String member = teasession.getParameter("member");
if(member == null){
  member = teasession._rv._strR;
}
Bperson b = Bperson.findmember(member);
String nexturl = "/jsp/bpicture/saler/ChangePayment.jsp";
if(teasession.getParameter("forword")!=null){
  nexturl = "/jsp/bpicture/saler/SalerManagement.jsp";
}
%>
<HTML>
  <HEAD>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <title>B-picture</title>
    <style>
    #table002{background:#F6F6F6;border-bottom:10px solid #eee;border-top:10px solid #eee;padding:6px;width:95%;margin-top:10px;}
    #table002 #yi td,#er{padding:6px 15px;}
    #paymentbychequepayee,#paymentbychequeaddress1,#paymentbychequecity,#paymentbychequecounty,#paymentbychequezip{width:200px;height:23px;border:1px solid #7F9DB9;background:#fff;line-height:23px;*line-height:18px;}
    #paymentmethodcheque,#paymentmethodfundstransfer,#moneytype{border:0;}
    #btnSubmitQuery,#btnReset{border:1px solid #7F9DB9;background:#fff;margin-top:10px;height:23px;line-height:20px;*line-height:17px;padding-bottom:5px;*paddding-bottom:0;}
    #register{border:0;width:100%;}
    </style>
    <SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
    <script type="">
    function checked(form)
    {
      if(document.getElementById('invoice').style.display==''){
        return submitText(form.invmen,'无效-收件人');
      }
      if(document.getElementById('cheque').style.display==''){
        return submitText(form.cper,'无效-支票收款人');
      }
      if(document.getElementById('transfer').style.display==''){
        return submitText(form.account,'无效-收款人')
        &&submitText(form.bank,'无效-开户行')
        &&submitText(form.accountnum,'无效-帐号')
        &&submitInteger(form.accountnum,'无效-帐号');
      }
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
  </HEAD>
  <body style="margin:0;">
  <div id="wai">
    <div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;<a href="http://bp.redcome.com/jsp/bpicture/" target="_top">管理中心</a>&nbsp;>&nbsp;付款信息管理</div>
    <h1>付款信息管理</h1>
    <form name="register" method="post" action="/servlet/EditBPperson" id="register" onSubmit="return checked(this);" enctype="multipart/form-data">
    <input type="hidden" name="act" value="uppayment"/>
    <input type="hidden" name="url" value="<%=nexturl%>"/>
    <table id="table002">
      <tr id="yi">
        <td width="15%"></td>
        <td colspan="4"></td>
      </tr>

      <tr id="yi">
        <td colspan="5">
          <b>付款方法</b></td>
      </tr>
      <tr>
        <td id="er" nowrap="nowrap">您想被如何支付?</td>
        <td width="2%"><input id="paymentmethodcheque" type="radio" name="paystyle" value="0" onclick="checard(0);" <%if(b.getPayStyle()==0)out.print("checked");%> /></td>
          <td colspan="3"><label for="paymentmethodcheque">支票</label></td>
      </tr>
      <tr>
        <td></td>
        <td><input id="paymentmethodfundstransfer" type="radio" name="paystyle" value="1"  onclick="checard(1);" <%if(b.getPayStyle()==1)out.print("checked");%> /></td>
          <td colspan="3"><label for="paymentmethodfundstransfer">转帐（直接进入您的银行帐户）</label></td>
      </tr>
      <tr>
        <td></td>
        <td colspan="4"><input type="button" value="发票信息管理" onclick="showhid();"/></td>
      </tr>
      <tr>
        <!--<td id="er">货币类型</td>

        <td colspan="4">
          <input id="moneytype" type="radio" name="moneytype" value="1" <%if(b.getMoneytype()==1)out.print("checked");%> />&nbsp;&nbsp;&nbsp;人民币<br />
          <input id="moneytype" type="radio" name="moneytype" value="2" <%if(b.getMoneytype()==2)out.print("checked");%> />&nbsp;&nbsp;&nbsp;美元<br />
          <input id="moneytype" type="radio" name="moneytype" value="3" <%if(b.getMoneytype()==3)out.print("checked");%> />&nbsp;&nbsp;&nbsp;英镑<br />
          <input id="moneytype" type="radio" name="moneytype" value="4" <%if(b.getMoneytype()==4)out.print("checked");%> />&nbsp;&nbsp;&nbsp;欧元<br />
          <input id="moneytype" type="radio" name="moneytype" value="5" <%if(b.getMoneytype()==5)out.print("checked");%> />&nbsp;&nbsp;&nbsp;其他
        </td>
      </tr>-->

      <tr id="yi">
        <td colspan="5">注意：当输入以下信息仅使用字母或数字。使用任何特殊字符或符号可能会导致延迟付款。</td>
      </tr>
    </table>

    <div id="invoice" style="display:none;">
      <table id="table002">
        <tr id="yi">
          <td height="45" colspan="5"><strong>发票信息</strong></td>
        </tr>
        <tr>
          <td align="right" width="175" id="er">收件人</td>
          <td colspan="4"><font color="#0066CB">*</font><input name="invmen" type="text" value="<%if(b.getInvmen()!=null)out.print(b.getInvmen());%>" maxlength="80" id="paymentbychequepayee" class="margin inputfield" />
            &nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>

        <tr>
          <td align="right" id="er">
            地址</td>
            <td colspan="4">
              <font color="#0066CB"></font>&nbsp;&nbsp;<input name="invaddr" type="text" value="<%if(b.getInvaddr()!=null)out.print(b.getInvaddr());%>" maxlength="35" id="paymentbychequecity" class="inputfield" />      </td>
        </tr>
        <tr>
          <td align="right" id="er">邮编</td>
          <td colspan="4"><font color="#0066CB"></font>
            &nbsp;&nbsp;<input name="invzip" type="text" value="<%if(b.getInvzip()!=null)out.print(b.getInvzip());%>" maxlength="35" id="paymentbychequecounty" class="inputfield" /></td>
        </tr>
        <tr>
          <td align="right" id="er">公司名</td>
          <td colspan="4"><font color="#0066CB"></font>
            &nbsp;&nbsp;<input name="invcomname" type="text" value="<%if(b.getInvcomname()!=null)out.print(b.getInvcomname());%>" maxlength="35" id="paymentbychequecounty" class="inputfield" /></td>
        </tr>
      </table>
    </div>

    <div id="cheque" <%if(b.getPayStyle()!=0){out.print("style=\"display:none;\"");}%>>
      <table id="table002">
        <tr id="yi">
          <td height="45" colspan="5"><strong>支票付款</strong></td>
        </tr>
        <tr>
          <td width="175" align="right" id="er">支票收款人</td>
          <td colspan="4"><font color="#0066CB">*</font><input name="cper" type="text" value="<%if(b.getChequePayee()!=null)out.print(b.getChequePayee());%>" maxlength="80" id="paymentbychequepayee" class="margin inputfield" />
          &nbsp;&nbsp;&nbsp;&nbsp;我们将发票提供给谁？通常为您个人的姓名或您所属公司的名称.</td>
        </tr>

        <tr>
          <td id="er" align="right">
            所属地区</td>
            <td colspan="4">
              <font color="#0066CB"></font>&nbsp;&nbsp;<input name="chequecity" type="text" value="<%if(b.getChequeCounty()!=null)out.print(b.getChequeCounty());%>" maxlength="35" id="paymentbychequecity" class="inputfield" />      </td>
        </tr>
        <tr>
          <td id="er" align="right">城市</td>
          <td colspan="4"><font color="#0066CB"></font>
            &nbsp;&nbsp;<input name="chequecounty" type="text" value="<%if(b.getChequeCity()!=null)out.print(b.getChequeCity());%>" maxlength="35" id="paymentbychequecounty" class="inputfield" /></td>
        </tr>
        <tr>
          <td id="er" align="right">邮编</td>
          <td colspan="4"><font color="#0066CB"></font>&nbsp;&nbsp;<input name="chequezip" type="text" value="<%if(b.getChequeZip()!=null)out.print(b.getChequeZip());%>" maxlength="25" id="paymentbychequezip" class="inputfieldsmall" /></td>
        </tr>
        <tr>
          <td id="er" align="right">地址 </td>
          <td colspan="4"><font color="#0066CB"></font>
            &nbsp;&nbsp;<input name="chequeaddr" type="text" value="<%if(b.getChequeAddr()!=null)out.print(b.getChequeAddr());%>" maxlength="35" id="paymentbychequeaddress1" class="inputfield" /></td>
        </tr>
        <!--<tr id="trfile">
          <td colspan="3"  id="er">身份验证图片</td>
          <td width="14%" valign="middle"><a style="position:absolute"><img src="/tea/image/netdisk/deplacer.gif" align="absmiddle">添加图片</a>  <input id="card" type="file" name=card style="position:absolute;width:10;cursor:hand;filter:Alpha(opacity=0)" onChange="f_click(this)"/> 　</td>
            <td width="53%" id="fi">&nbsp;
              <%if(b.getCard()!=null){out.print("<a href=/jsp/include/DownFile.jsp?uri="+b.getCard()+"&name=身份证复印件."+b.getCard().substring(b.getCard().lastIndexOf(".")+1)+"><img src=\"/tea/image/netdisk/"+b.getCard().substring(b.getCard().lastIndexOf(".")+1)+".gif\" />身份证复印件</a>");} %></td>
</tr>-->
  <tr>
        <td></td><td colspan="3"><input type="submit" name="btnSubmitQuery" value="保存" id="btnSubmitQuery" title="保存" />
    <input type="reset" name="btnReset" value="重置" id="btnReset" title="重置" /></td>
        </tr>
      </table>
    </div>

    <div id="transfer" <%if(b.getPayStyle()!=1){out.print("style=\"display:none;\"");}%>>
      <table id="table002">
        <tr id="yi">
          <td height="45" colspan="5"><strong>转帐</strong></td>
        </tr>
        <tr>
          <td width="175" id="er" align="right">收款人（户名）</td>
          <td colspan="4"><font color="#0066CB">*</font><input name="account" type="text" value="<%if(b.getAccount()!=null)out.print(b.getAccount());%>" maxlength="80" id="paymentbychequepayee" class="margin inputfield" />
            &nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>

        <tr>
          <td id="er" align="right">
            开户行</td>
            <td colspan="4">
              <font color="#0066CB">*</font><input name="bank" type="text" value="<%if(b.getBank()!=null)out.print(b.getBank());%>" maxlength="35" id="paymentbychequecity" class="inputfield" />      </td>
        </tr>
        <tr>
          <td id="er" align="right">帐号</td>
          <td colspan="4"><font color="#0066CB">*</font><input name="accountnum" type="text" value="<%if(b.getAccountnum()!=0)out.print(b.getAccountnum());%>" maxlength="35" id="paymentbychequecounty" class="inputfield" /></td>
        </tr>
        <tr>
        <td></td><td colspan="3"><input type="submit" name="btnSubmitQuery" value="保存" id="btnSubmitQuery" title="保存" />
    <input id="btnSubmitQuery" type="button" value="返回" onclick="window.history.go(-1);"/></td>
        </tr>
      </table>
    </div>





    </form>
  </div>
  <script type="">
  //    function f_click(obj)
  //    {
    //      if(!obj)obj=this;
    //
    //      //
    //      var td = document.getElementById("fi");
    //      var path=obj.value;
    //      var name=path.substring(path.lastIndexOf("\\")+1);
    //      var ex=name.substring(name.lastIndexOf(".")+1);
    //      td.innerHTML="<img src=/tea/image/netdisk/"+ex+".gif width='16' height='16' onerror=onerror=null;src='/tea/image/netdisk/defaut.gif'>"+name+"　<a href=javascript:f_del();><b>移除</b></a>";
    //
    //    }
    //    function f_del()
    //    {
      //      var obj = document.getElementById("card");
      //      obj.outerHTML = obj.outerHTML;
      //      document.getElementById("fi").innerHTML="&nbsp;";
      //    }
      function checard(value)
      {
        if(value=='0')
        {
          document.getElementById('cheque').style.display='';
          document.getElementById('transfer').style.display='none';
        }else{
          document.getElementById('cheque').style.display='none';
          document.getElementById('transfer').style.display='';
        }
      }
      function showhid()
      {
        if(document.getElementById('invoice').style.display==""){
          document.getElementById('invoice').style.display="none";
        }else{
          document.getElementById('invoice').style.display="";
        }
      }
      </script>
      </body>
</HTML>

