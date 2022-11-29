<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.util.*"%>
<%
//            if(!node.isCreator(teasession._rv))
//            {
//                response.sendError(403);
//                return;
//            }

request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Resource r = new Resource();
boolean _bNew=request.getParameter("NewNode")!=null;
r.add("/tea/resource/Company");
int father = 0;
if(teasession.getParameter("father")!=null && teasession.getParameter("father").length()>0)
  father = Integer.parseInt(teasession.getParameter("father"));

String act = teasession.getParameter("act");




int nids = 0;
//if(!"user".equals(act)){//判断是否登陆
//  java.util.Enumeration enode = Node.find(" and rcreator="+DbAdapter.cite(teasession._rv.toString())+" and type = 21  order by time desc ",0,Integer.MAX_VALUE);
//  while (enode.hasMoreElements())
//  {
//    nids = ((Integer)enode.nextElement()).intValue();
//  }
//}

String Name =null,Address=null,Zip=null,WebPage=null,Country=null,Contact=null,Telephone=null,Fax=null,Email=null,Text=null;
int father1 = 0,father2=0,City2=0,maplen=0;


Node n = Node.find(nids);
Company csy = Company.find(nids);
if(nids>0)//用户有企业信息 修改
{
  Name= n.getSubject(teasession._nLanguage);
  father2= n.getFather();
  City2= csy.getCity(teasession._nLanguage);
  Address = csy.getAddress(teasession._nLanguage);
  Zip = csy.getZip(teasession._nLanguage);
  WebPage = csy.getWebPage(teasession._nLanguage);
  Country = csy.getCountry(teasession._nLanguage);
  Contact = csy.getContact(teasession._nLanguage);
  Telephone = csy.getTelephone(teasession._nLanguage);
  Fax = csy.getFax(teasession._nLanguage);
  Email = csy.getEmail(teasession._nLanguage);
  Text = n.getText(teasession._nLanguage);
  Node  nn = Node.find(father2);
  father1= nn.getFather();
  if(csy.getLicense(teasession._nLanguage)!=null)
  {
    maplen=(int)new java.io.File(application.getRealPath(csy.getLicense(teasession._nLanguage))).length();
  }
}

//     f1.append("var c0=new Array(new Array(0,'----------')");
//java.util.Enumeration e1 = Node.find(" and hidden =0 and type = 21 ",0,Integer.MAX_VALUE);
int last = 0;
StringBuffer f1=new StringBuffer();
StringBuffer f2=new StringBuffer();
DbAdapter db = new DbAdapter();
try
{  //"+Community.find(teasession._strCommunity).getNode()+"
  db.executeQuery("SELECT node FROM Node WHERE path LIKE '/441/%' AND type=1 AND hidden=0 AND node IN ( select node from Category WHERE Category=21) ORDER BY father");
   out.print("SELECT node FROM Node WHERE path LIKE '/"+Community.find(teasession._strCommunity).getNode()+"/%' AND type=1 AND hidden=0 AND node IN ( select node from Category WHERE Category=21) ORDER BY father");
  while(db.next())
  {

    int nid = db.getInt(1);
    Node nodeobj=Node.find(nid);
    int fid=nodeobj.getFather();
    String ns=nodeobj.getSubject(teasession._nLanguage);
    if(last!=fid)
    {
      last=fid;
      if(Node.find(fid).getSubject(teasession._nLanguage)!=null && Node.find(fid).getSubject(teasession._nLanguage).length()>0){
        f1.append("<option value='"+fid+"'");
        System.out.println(nid+"---"+father);
        if(nid==father)//Node.find(father).getFather()
        {
          f1.append(" selected='true'");
        }
        f1.append(">").append(Node.find(fid).getSubject(teasession._nLanguage));
      }

      f2.append("break;\r\n");
      f2.append("case ").append(fid).append(":");
    }
    f2.append("op[op.length]=new Option(\""+nodeobj.getSubject(teasession._nLanguage)+"\","+nid+");");
  }
}finally
{
  db.close();
}
  tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<script language="javascript" src="/tea/load.js"  type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="jspbefore" style="display:none">
<script>if(top.location==self.location)jspbefore.style.display='';</script>
<%=community.getJspBefore(teasession._nLanguage)%>
</div>

<script type="">

function f_ajax(obj,sid)
{

  if(form1.MemberId.value=='')
  {
    domain.innerHTML='(<font color=red>注：您的电子邮箱将作为您的登陆账号及本站与您的主要联系方式，请输入正确的邮箱地址。</font>)';
    return false;
  }else
  {
    var   strReg="";
    var   r;
    var str = form1.MemberId.value;
    strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
    r=str.search(strReg);
    if(r==-1){
      domain.innerHTML='<font color=red>用户名格式不正确!</font>';
      return false;
    }
  }
  var value = obj.value;
  var name = obj.name;
  var ps = form1.EnterPassword.value;
  currentPos = sid;
  send_request("/jsp/user/EditCompany_ajax.jsp?value="+value+"&name="+name+"&ps="+ps);
}

function f_submit()
{
  if(form1.MemberId.value=='')
  {
      domain.innerHTML='(<font color=red>注：您的电子邮箱将作为您的登陆账号及本站与您的主要联系方式，请输入正确的邮箱地址。</font>)';
     return false;
  }
   if(form1.EnterPassword.value=='')
  {
     epd.innerHTML='<font color=red>密码不能为空!</font>';
     // f_ajax(form1.EnterPassword,'epd');
     return false;
  }
   if(form1.ConfirmPassword.value=='')
  {
     //alert("确认密码不能为空!");
      cpd.innerHTML='<font color=red>确认密码不能为空!</font>';
   //  f_ajax(form1.ConfirmPassword,'cpd');
     return false;
  }
var epd =form1.EnterPassword.value;
var cf =form1.ConfirmPassword.value;

  if(epd!=cf)
  {
   // alert("");
    cpd.innerHTML='<font color=red>两次输入的密码不一致，请重新输入!</font>';
   // f_ajax(form1.ConfirmPassword,'cpd');
    return false;

  }
  if(form1.Name.value=='')
  {
    //alert("企业名字不能为空!");
    sName.innerHTML='<font color=red>企业名称不能为空!</font>';
    return false;
  }else
  {
     sName.innerHTML='<font color=green>企业名称填写正确!</font>';
  }

   if(form1.father1.value=='0')
  {
     sfather1.innerHTML='<font color=red>请选择所属行业!</font>';
     return false;
  }else
  {
    //alert(form1.father2.length);
    if(form1.father2.length>1)
    {
      if(form1.father2.value=='0')
      {
        sfather1.innerHTML='<font color=red>请选择二级所属行业!</font>';
        return false;
      }
//      }else
//      {
//        sfather1.innerHTML='<font color=green>所属行业选择正确!</font>';
//      }
    }
    sfather1.innerHTML='<font color=green>所属行业选择正确!</font>';
  }


   if(form1.City2.value=='')
  {
       sCity2.innerHTML='<font color=red>请选择所属地区!</font>';
       return false;
  }
  else
  {
    sCity2.innerHTML='<font color=green>所属地区选择正确!</font>';
  }


  if(form1.Address.value=='')
  {
     sAddress.innerHTML='<font color=red>企业地址不能为空!</font>';
    return false;
  }else
  {
    sAddress.innerHTML='<font color=green>企业地址填写正确!</font>';
  }
   if(form1.Zip.value=='')
  {
      sZip.innerHTML='<font color=red>邮编不能为空!</font>';
     return false;
  }else
  {
    if(form1.Zip.value.length>6 || form1.Zip.value.length<6){
        sZip.innerHTML='<font color=red>邮编必须是6位数字!</font>';
      return false;
    }
    if(isNaN(document.all.form1.Zip.value))
    {
      sZip.innerHTML='<font color=red>你输入非法字符，邮编必须是数字!</font>';
      return false;
    }
    sZip.innerHTML='<font color=green>邮编填写正确!</font>';

  }
   if(form1.WebPage.value=='')
  {

      sWebPage.innerHTML='<font color=red>企业网址不能为空!</font>';
     return false;
  }else
  {
    sWebPage.innerHTML='<font color=green>企业网址填写正确!</font>';
  }
  if(form1.Country.value=='')
  {
    sCountry.innerHTML='<font color=red>网站说明不能为空!</font>';
    return false;
  }else
  {
    sCountry.innerHTML='<font color=green>网站说明填写正确!</font>';
  }



  if(form1.Telephone.value=='')
  {
    sTelephone.innerHTML='<font color=red>电话不能为空!</font>';
   return false;
  }
  if(form1.Telephone.value.length!=8 && form1.Telephone.value.length!=11 && form1.Telephone.value.length!=12)
  {
     sTelephone.innerHTML='<font color=red>电话号位数不正确!</font>';
    return false;
  }
  if(isNaN(document.all.form1.Telephone.value))
  {
    sTelephone.innerHTML='<font color=red>你输入非法字符，电话必须是数字!</font>';
    return false;
  }else
  {
    sTelephone.innerHTML='<font color=green>电话号填写正确!</font>';
  }

   if(form1.Fax.value=='')
  {
    sFax.innerHTML='<font color=red>传真不能为空!</font>';
    return false;
  }else
  if(form1.Fax.value.length!=8 && form1.Fax.value.length!=11)
  {
     sFax.innerHTML='<font color=red>传真位数不正确!</font>';
    return false;
  }else if(isNaN(document.all.form1.Fax.value))
  {
    sFax.innerHTML='<font color=red>你输入非法字符，传真必须是数字!</font>';
    return false;
  }else
  {
    sFax.innerHTML='<font color=green>传真填写正确!</font>';
  }

//   if(form1.Email.value=='')
//  {
//     sEmail.innerHTML='<font color=red>邮箱不能为空!</font>';
//     return false;
//  }else
//  {
//    var   strReg="";
//    var   r;
//    var str = form1.Email.value;
//    strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
//    r=str.search(strReg);
//    if(r==-1){
//      sEmail.innerHTML='<font color=red>邮箱格式不正确!</font>';
//      return false;
//    }else
//    {
//      sEmail.innerHTML='<font color=green>邮箱填写正确!</font>';
//    }
//
//  }
  if(form1.Text.value=='')
  {
    sText.innerHTML='<font color=red>企业简介不能为空!</font>';
    return false;
  }else
  {
     sText.innerHTML='<font color=green>企业简介填写正确!</font>';
  }

}


function f_submit_2()
{
  if(form1.MemberId.value=='')
  {
      alert("用户名不能为空!");
     return false;
  }else
  {
    var   strReg="";
    var   r;
    var str = form1.MemberId.value;
    strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
    r=str.search(strReg);
    if(r==-1){
    alert("用户名格式不正确!");
     return false;
    }
  }
   if(form1.EnterPassword.value=='')
  {
    alert("密码不能为空!");
     return false;
  }
var epd =form1.EnterPassword.value;
var cf =form1.ConfirmPassword.value;

  if(epd!=cf)
  {
    alert("两次输入的密码不一致，请重新输入!");
    return false;
  }
  if(form1.Name.value=='')
  {
    alert("企业名称不能为空!");
    return false;
  }
   if(form1.father1.value=='0')
  {
     alert("请选择所属行业!");
     return false;
  }else
  {
    if(form1.father2.length>1)
    {
      if(form1.father2.value=='0')
      {
          alert("请选择二级所属行业!");
        return false;
      }
    }
  }


  if(form1.City2.value=='')
  {
    alert("请选择所属地区!");
    return false;
  }
  if(form1.Address.value=='')
  {
    alert("企业地址不能为空!");
    return false;
  }
   if(form1.Zip.value=='')
  {
       alert("邮编不能为空!");
     return false;
  }else
  {
    if(form1.Zip.value.length>6 || form1.Zip.value.length<6){
      alert("邮编必须是6位数字!");
      return false;
    }
    if(isNaN(document.all.form1.Zip.value))
    {
      alert("你输入非法字符，邮编必须是数字!");
      return false;
    }
  }
   if(form1.WebPage.value=='')
  {
    alert("企业网址不能为空!");
    return false;
  }
  if(form1.Country.value=='')
  {
    alert("邮编不能为空!");
    return false;
  }
  if(form1.Telephone.value=='')
  {
    alert("电话不能为空!");
    return false;
  }
  if(form1.Telephone.value.length!=8 && form1.Telephone.value.length!=11 && form1.Telephone.value.length!=12)
  {
     alert("电话号位数不正确!");
    return false;
  }
  if(isNaN(document.all.form1.Telephone.value))
  {
     alert("你输入非法字符，电话必须是数字!");
    return false;
  }
   if(form1.Fax.value=='')
  {
    alert("传真不能为空!");
    return false;
  }else
  if(form1.Fax.value.length!=8 && form1.Fax.value.length!=11)
  {
      alert("传真位数不正确!");
    return false;
  }else if(isNaN(document.all.form1.Fax.value))
  {
      alert("你输入非法字符，传真必须是数字!");
    return false;
  }
//   if(form1.Email.value=='')
//  {
//     alert("邮箱不能为空!");
//     return false;
//  }else
//  {
//    var   strReg="";
//    var   r;
//    var str = form1.Email.value;
//    strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
//    r=str.search(strReg);
//    if(r==-1){
//       alert("邮箱格式不正确!");
//      return false;
//    }
//
//  }
  if(form1.Text.value=='')
  {
    alert("企业简介不能为空");
    return false;
  }
}


</script>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="bigborder">
<h1 align="center">基本信息</h1>
<%if("user".equals(act)){ %>
<div id="log_top">

	<table>
		<tr><td id="log_top_img"><img src="/res/lib/u/0805/080565365.gif">　</td><td>相关条款</td><td id="log_top_img"><img src="/res/lib/u/0805/080565366.gif">　</td><td><font>基本信息</font></td><td id="log_top_img"><img src="/res/lib/u/0805/080565364.gif">　</td><td>注册成功</td></tr>
	</table>
</div>
<div id="log_top_title2"><span id="title_span01">基本信息<font>>></font></span><span id="title_span02">打<font>*</font>为必填项</span></div>
<div id="log_top_title3">请认真、仔细地填写以下信息，严肃的商业信息有助于您获得别人的信任，结交潜在的商业伙伴，获得商业机会！</div>

<%} %>
<!--<%=r.getString(teasession._nLanguage, "Company")%>-->
<FORM  enctype="multipart/form-data"  name=form1 METHOD=POST action="/servlet/EditCompany2" onSubmit="return f_submit_2(this);">
<input type="hidden" name="act" value="<%=act%>" />
<input type="hidden" name="nids" value="<%=nids%>"/>
<%
   if(nids==0)//添加
   {
     out.print("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
   }
%>
  <table border="0" cellpadding="0" cellspacing="0" id="log_tablecenter">
  <%
      if("user".equals(act)){
  %>
   <tr>
      <td id="log_tab_td01" nowrap  rowspan="2">电子邮件地址</td><td id="log_tab_td02"  rowspan="2">*</td><td id="log_tab_td03">
     <input type="TEXT" class="edit_input"   name=MemberId value="" size=40 maxlength=40  onchange="f_ajax(this,'domain');"  ></td>
      <td  id="log_tab_td04">电子邮件地址只能包含字母、数字、句点(.)、连字符(-)或下划线(_)。</td>
      </tr>
	  <tr><td colspan="2"><span id="domain">&nbsp;</span></td></tr>

    <tr>
      <td id="log_tab_td01"><%=r.getString(teasession._nLanguage, "密码设置")%></td><td id="log_tab_td02">*</td><td id="log_tab_td03">
     <input type="password" class="edit_input"  name=EnterPassword value="" size=40 maxlength=16 onChange="f_ajax(this,'epd');"><span id="epd">&nbsp;</span></td> <td  id="log_tab_td04">至少六个字符不能包括空格。</td>
    </tr>
    <tr>
      <td id="log_tab_td01"><%=r.getString(teasession._nLanguage, "密码确认")%></td><td id="log_tab_td02">*</td><td id="log_tab_td03">
     <input type="password" class="edit_input"  name=ConfirmPassword value="" size=40 maxlength=16 onChange="f_ajax(this,'cpd');"><span id="cpd">&nbsp;</span></td>  <td  id="log_tab_td04"> </td>
    </tr>
    <%
      }
    %>
    <tr>
      <td id="log_tab_td01">企业名称</td><td id="log_tab_td02">*</td><td id="log_tab_td03">
        <input type="TEXT" class="edit_input"  name="Name" size="40" maxlength="255" value="<%if(Name!=null)out.print(Name);%>" onChange="f_submit();"><span id="sName">&nbsp;</span> </td>
       <td  id="log_tab_td04">国内注册企业请用中文填写在工商局注册的全称。如：中龙网库。</td>
    </tr>
    <tr>
      <td id="log_tab_td01">所属行业</td><td id="log_tab_td02">*</td>
       <td id="log_tab_td03"><div class="xlk sb">
            <select name="father1" onchange="f_ch()">
              <option value="0">------</option>
              <%=f1.toString()%>
            </select><div class="xlan"></div>
            </div>
        <div class="xlk sb"> <select name="father2" >
              <option value="0">------</option>
            </select>
            <div class="xlan"></div></div><span id="sfather1">&nbsp;</span>
            <script type="">
            function f_ch()
            {
              var op=form1.father2.options;
              while(op.length>1)
              {
                op[1]=null;
              }
              switch(parseInt(form1.father1.value))
              {
                case 0:
                <%=f2.toString()%>
                break;
              }
            }
            f_ch();
            form1.father2.value="<%=father2%>";
            </script>
          </td>



 <td  id="log_tab_td04">建议根据公司经营范围，选择所属行业</td>
    </tr>
     <tr>
      <td id="log_tab_td01">所属地区</td><td id="log_tab_td02">*</td><td id="log_tab_td03">
      <script type="">selectcard("City1","City2","City3","<%=City2%>");</script><span id="sCity2">&nbsp;</span>
<script type="">
function f_city()
{
  form1.Zip.value="100000";
  telprefix.innerHTML="86 10";
}
form1.City3.attachEvent("onchange",f_city);
</script>
</td>
 <td  id="log_tab_td04">请选择公司所在地</td>
    </tr>
     <tr>
      <td id="log_tab_td01">企业地址</td><td id="log_tab_td02">*</td><td id="log_tab_td03">
        <input type="TEXT" class="edit_input"  name="Address" size="40" MAXLENGTH="255" VALUE="<%if(Address!=null)out.print(Address);%>" onChange="f_submit();">
      <span id="sAddress">&nbsp;</span>
      </td>
      <td  id="log_tab_td04">选择省市后，只需要填写区、街道、门牌或信箱号就可以了，如"海淀区长春桥路5号"。注意：不要再次输入省市名称!</td>
    </tr>

      <tr>
      <td id="log_tab_td01">邮　　编</td><td id="log_tab_td02">*</td><td id="log_tab_td03">
         <input type="TEXT" class="edit_input"  name="Zip" size="40" MAXLENGTH="255" VALUE="<%if(Zip!=null)out.print(Zip);%>" onChange="f_submit();">
          <span id="sZip">&nbsp;</span>
      </td>
      <td  id="log_tab_td04">邮政编码只能使用数字！请输入6位邮政编码.</td>
    </tr>
       <tr>
      <td id="log_tab_td01">企业网址</td><td id="log_tab_td02">*</td><td id="log_tab_td03">
        <input type="TEXT" class="edit_input"  name="WebPage" size="40" MAXLENGTH="255" VALUE="<%if(WebPage!=null)out.print(WebPage);%>" onChange="f_submit();">
      <span id="sWebPage">&nbsp;</span>
      </td>
      <td  id="log_tab_td04">重要信息！输入的企业网址，有助于网库为您进行推广.</td>
    </tr>
      <tr>
      <td id="log_tab_td01">网站说明</td><td id="log_tab_td02">*</td><td id="log_tab_td03">
        <input type="TEXT" class="edit_input"  name="Country" size="40" MAXLENGTH="255" VALUE="<%if(Country!=null)out.print(Country);%>" onChange="f_submit();">
         <span id="sCountry">&nbsp;</span>
      </td>
      <td  id="log_tab_td04">网库提供的个性功能，您可以任意输入一句话作为网站描述。(如：提供最专业咨询服务)当您的企业信息被检索到时，该文字将出现在企业名称右侧。</td>
    </tr>
     <tr>
      <td id="log_tab_td01">图片上传</td><td id="log_tab_td02"></td>
      <td id="log_tab_td03"><input type="file"  name="license" class="" onChange="f_submit();" />

      <%if(maplen>0){%>
      <a href="<%=csy.getLicense(teasession._nLanguage)%>" target="_blank"><%=maplen %></a>   <%} %>
        <input type=checkbox name=checkbox1 onclick='form1.license.disabled=this.checked'>清除


         <span id="sLicense">&nbsp;</span>
</td>
      <td  id="log_tab_td04">将企业网站的首页缩略图上传,如不上传，暂忽略，请致电010-88877250</td>
    </tr>
	<tr>
	<td></td><td></td><td>(<font color="red">图片大小：100*100 格式的jpg或gif</font>)</td>
	</tr>
     <tr>
      <td id="log_tab_td01">联 系 人</td><td id="log_tab_td02"></td><td id="log_tab_td03"><input type="TEXT" class="edit_input"  name=Contact size="40" MAXLENGTH="255" VALUE="<%if(Contact!=null)out.print(Contact);%>"></td>
      <td  id="log_tab_td04"></td>
    </tr>

 <tr>
      <td id="log_tab_td01">电　　话</td><td id="log_tab_td02">*</td><td id="log_tab_td03">
        <span id="telprefix"></span>
        <input type="TEXT" class="edit_input"  name="Telephone" size="40" MAXLENGTH="255" VALUE="<%if(Telephone!=null)out.print(Telephone);%>" onChange="f_submit();">
       <span id="sTelephone">&nbsp;</span>
      </td>
      <td  id="log_tab_td04">例如 01012345678</td>
    </tr>

     <tr>
      <td id="log_tab_td01">传　　真</td><td id="log_tab_td02">*</td><td id="log_tab_td03">
        <input type="TEXT" class="edit_input"  name="Fax" size="40" MAXLENGTH="255" VALUE="<%if(Fax!=null)out.print(Fax);%>" onChange="f_submit();">
         <span id="sFax">&nbsp;</span>
      </td>
     <td  id="log_tab_td04">例如 01012345678</td>
    </tr>
    <%--
     <tr>
      <td id="log_tab_td01">邮　　箱</td><td id="log_tab_td02">*</td><td id="log_tab_td03">
        <input type="TEXT" class="edit_input"  name="Email" size="40" MAXLENGTH="255" VALUE="<%if(Email!=null)out.print(Email);%>" onChange="f_submit();">
       <span id="sEmail">&nbsp;</span>
      </td>
      <td  id="log_tab_td04"></td>
    </tr>
--%>
     <tr>
      <td id="log_tab_td01">企业简介</td><td id="log_tab_td02">*</td>
      <td id="log_tab_td03">
        <textarea name="Text" id="log_tab_text" rows="8" cols="70" class="edit_input" onChange="f_submit();"><%if(Text!=null)out.print(Text);%></textarea>      </td> <span id="sText">&nbsp;</span>
      <td  id="log_tab_td04"></td>
    </tr>
  </table>
<input type="submit" id="submit_next" value="<%if("user".equals(act)){out.print("下一步");}else{out.print("提交");}%>">

</FORM>

<div id="head6"><img height="6" src="about:blank"></div></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
<div id="jspafter" style="display:none">
<script>if(top.location==self.location)jspafter.style.display='';</script>
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
</body>
</html>
