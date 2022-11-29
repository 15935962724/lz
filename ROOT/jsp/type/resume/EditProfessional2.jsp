<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Node node=Node.find(teasession._nNode);


int professional=0;
if(teasession.getParameter("professional")!=null)
professional=Integer.parseInt(teasession.getParameter("professional"));

String community=request.getParameter("community");
if(community==null)
{
  community=teasession._strCommunity;
}
Professional obj=Professional.find(professional);
if(!node.isCreator(teasession._rv)||(professional!=0&&obj.getNode()!=teasession._nNode))
{
  response.sendError(403);
  return;
}
String nexturl=request.getParameter("nexturl");
String nexturl2 = request.getRequestURI()+"?nexturl="+nexturl+""+request.getContextPath();


if(request.getMethod().equals("POST"))
{


    java.text.DateFormat df=java.text.DateFormat.getDateInstance();
    java.util.Date begda=df.parse(request.getParameter("begdaYear")+"-"+request.getParameter("begdaMonth")+"-"+request.getParameter("begdaDay"));
    java.util.Date endda=df.parse(request.getParameter("enddaYear")+"-"+request.getParameter("enddaMonth")+"-"+request.getParameter("enddaDay"));
    String zzglb=request.getParameter("zzglb");
    int zrzjb=Integer.parseInt(request.getParameter("zrzjb"));
    String zzgdm=request.getParameter("zzgdm");
    String zfzdw=request.getParameter("zfzdw");
    java.util.Date zqzsj=df.parse(request.getParameter("zqzsjYear")+"-"+request.getParameter("zqzsjMonth")+"-"+request.getParameter("zqzsjDay"));
    String zzsbh=request.getParameter("zzsbh");
    String zjddw=request.getParameter("zjddw");
    String zqdzgtj=request.getParameter("zqdzgtj");
    String zqtbz=request.getParameter("zqtbz");
    if(professional==0)
    {
       Professional.create(teasession._nNode,teasession._nLanguage,begda,endda,zzglb,zrzjb,zzgdm,zfzdw,zqzsj,zzsbh,zjddw,zqtbz,zqdzgtj);
    }else
    {
      obj.set(begda,endda,zzglb,zrzjb,zzgdm,zfzdw,zqzsj,zzsbh,zjddw,zqtbz,zqdzgtj);
    }
//  response.sendRedirect(request.getRequestURI()+"?node="+teasession._nNode+"&community="+community+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
//  return;

  response.sendRedirect(nexturl+"&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8")+"&node="+teasession._nNode);
  return;
}

 if(request.getParameter("delete")!=null)
  {
    obj.delete();
    response.sendRedirect(nexturl+"&nexturl=" + java.net.URLEncoder.encode(nexturl,"UTF-8")+"&node="+teasession._nNode);
  return;
  }

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function submitZSBH(str,text){
  if(""==str.value || str.value.length < 8){
    alert(text);
    return false;
  }
  for(var i=0;i<str.value.length;i++){
    var c = str.value.charAt(i);
    alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    alpha += "abcdefghijklmnopqrstuvwxyz";
    alpha += "0123456789";
    alpha += "()-";
    if(alpha.indexOf(c)==-1){
      alert(text);
      return false;
    }
  }
  return true;
}
function check(){
return submitText(form1.zfzdw, '<%=r.getString(teasession._nLanguage,"无效 发证单位")%>')&&
submitZSBH(form1.zzsbh, '<%=r.getString(teasession._nLanguage,"无效 证书编号必须大于8位")%>')&&
submitText(form1.zjddw, '<%=r.getString(teasession._nLanguage,"无效 鉴定单位")%>');
}

function submitSelect(obj,text)
{
  if(obj.selectedIndex==0)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
function fchange(value,obj)
{
  while(obj.options.length>0)
  {
    obj.options[0]=null;
  }
  switch(value)
  {
    case '01':
    <%
    for(int index=0;index<Professional.ZZGDM1_TYPE.length;index++)
    {
      out.print("obj.options[obj.options.length]=new Option('"+Professional.ZZGDM1_TYPE[index][1]+"','"+Professional.ZZGDM1_TYPE[index][0]+"');");
    }
    %>
    break;
    case '02':
    <%
    for(int index=0;index<Professional.ZZGDM2_TYPE.length;index++)
    {
      out.print("obj.options[obj.options.length]=new Option('"+Professional.ZZGDM2_TYPE[index][1]+"','"+Professional.ZZGDM2_TYPE[index][0]+"');");
    }
    %>
    break;
  }
}
function fload()
{
  fchange(form1.zzglb.value,document.form1.zzgdm);
  for(var i=0;i<form1.zzgdm.options.length;i++)
  {
    if(form1.zzgdm.options[i].value=="<%=obj.getZzgdm()%>")
    {
      form1.zzgdm.options[i].selected=true;
      break;
    }
  }
}

function f_add()
{
  form1.nexturl.value="<%=nexturl2%>";
  form1.action='?';
  if(check()){
    form1.submit();
  }
}
function f_add2()
{
   form1.nexturl.value="<%=nexturl%>";
  form1.action='?';
  if(check()){
    form1.submit();
  }
}
</script>
  </HEAD>
  <body onload="fload();" >

<h1><%=r.getString(teasession._nLanguage,"1167537038468")%><!--职业资格--></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

    <form name="form1" method="post" action="?"  onsubmit="" id="form1">
    <input type="hidden" name="professional" value="<%=professional%>" />
    <input type="hidden" name="Node" value="<%=teasession._nNode%>" />
    <input type="hidden" name="nexturl"  />
    <input type="hidden" name="community" value="<%=community%>" />


<h2><%=r.getString(teasession._nLanguage,"1167471137156")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr>
                <td valign="baseline" align="right" width="140">
                  <strong><%=r.getString(teasession._nLanguage,"1167471168140")%><!--开始时间--></strong></td>
                <td><%=new tea.htmlx.TimeSelection("begda", obj.getBegda())%></td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong></strong></span>

                  <strong><%=r.getString(teasession._nLanguage,"1167471229125")%><!--结束时间--></strong></td>
                <td><%=new tea.htmlx.TimeSelection("endda", obj.getEndda())%></td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong></strong></span><strong><%=r.getString(teasession._nLanguage,"1167537287453")%><!--职业资格类别--></strong></td>
                <td>
                  <select name="zzglb" onchange="fchange(this.value,document.form1.zzgdm);">
    <%
    for(int index=0;index<Professional.ZZGLB_TYPE.length;index++)
    {
      out.print("<option value="+Professional.ZZGLB_TYPE[index][0]);
      if(Professional.ZZGLB_TYPE[index][0].equals(obj.getZzglb()))
      out.print(" SELECTED");
      out.print(" >"+Professional.ZZGLB_TYPE[index][1]);
    }
    %>
    </select></td>
              </tr>

              <tr>
                <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"1167537108875")%><!--认证级别--></strong></td>
                <td><font size="2">
 <select name="zrzjb">
    <%
    for(int index=0;index<Professional.ZRZJB_TYPE.length;index++)
    {
      out.print("<option value="+index);
      if(index==obj.getZrzjb())
      out.print(" SELECTED");
      out.print(" >"+Professional.ZRZJB_TYPE[index]);
    }
    %>
    </select>
                </font></td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong></strong></span><strong>职业资格</strong></td>
                <td> <select name="zzgdm" >
    <%--
    for(int index=0;index<Professional.ZZGDM1_TYPE.length;index++)
    {
      out.print("<option value="+Professional.ZZGDM1_TYPE[index][0]);
      if(Professional.ZZGDM1_TYPE[index][0].equals(obj.getZzgdm()))
      out.print(" SELECTED");
      out.print(" >"+Professional.ZZGDM1_TYPE[index][1]);
    }
    --%>
    </select></td>
              </tr>

              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167537129406")%><!--发证单位--></strong></td>
                <td><input class="edit_input" name="zfzdw" id="zfzdw" type="text" maxlength="60" size="40"  value="<%if(obj.getZfzdw()!=null)out.print(obj.getZfzdw());%>"/></td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"1167537397406")%><!--取证时间--></strong></td>
                <td><%=new tea.htmlx.TimeSelection("zqzsj", obj.getZqzsj())%></td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167537435265")%><!--证书编号--></strong></td>
                <td><input class="edit_input" name="zzsbh" id="zzsbh" type="text" maxlength="60" size="40"  value="<%if(obj.getZzsbh()!=null)out.print(obj.getZzsbh());%>"/></td>
              </tr>
			                <tr>
                <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167537462265")%><!--鉴定单位--></strong></td>
                <td><input class="edit_input" name="zjddw" id="zjddw" type="text" maxlength="60" size="40"  value="<%if(obj.getZjddw()!=null)out.print(obj.getZjddw());%>"/></td>
              </tr>
			  			                <tr>
                <td align="right" valign="baseline"><span class="alert"><strong></strong></span><strong><%=r.getString(teasession._nLanguage,"1167537492531")%><!--取得资格途径--></strong></td>
                <td><select name="zqdzgtj">
    <%
    for(int index=0;index<Professional.ZQDZGTJ_TYPE.length;index++)
    {
      out.print("<option value="+Professional.ZQDZGTJ_TYPE[index][0]);
      if(Professional.ZQDZGTJ_TYPE[index][0].equals(obj.getZqdzgtj()))
      out.print(" SELECTED");
      out.print(" >"+Professional.ZQDZGTJ_TYPE[index][1]);
    }
    %>
    </select></td>
              </tr>
              <tr>
                <td valign="top" align="right"><strong><B><%=r.getString(teasession._nLanguage,"1167536241906")%><!--备注--></B>
                </strong></td>
                <td><input class="edit_input" name="zqtbz" id="zqtbz" type="text" maxlength="60" size="40"  value="<%if(obj.getZqtbz()!=null)out.print(obj.getZqtbz());%>"/></td></tr>

<%--
	<tr>
		<td colspan="2"><div align="center">
<!--保存&amp;新增职业资格-->
                  <input   type="submit"  value="<%=r.getString(teasession._nLanguage,"1167532473640")%>" onClick="return (submitText(document.form1.zfzdw,'<%=r.getString(teasession._nLanguage,"1167537583312")%>')&&submitText(document.form1.zzsbh,'<%=r.getString(teasession._nLanguage,"1167537607718")%>')&&submitText(document.form1.zjddw,'<%=r.getString(teasession._nLanguage,"1167537626015")%>'));"  />



        </div></td>
	</tr>
        --%>
</table>



  <br>
   <input   type="button" name="btnSave" value="<%=r.getString(teasession._nLanguage,"保存")%>" onclick="f_add2();"  />
                  <input   type="button" name="btnSave" value="<%=r.getString(teasession._nLanguage,"保存&新添加职业资格")%>" onclick="f_add();"   />
                  <input type=button value=" 返 回 " onClick="javascript:window.location.href='/jsp/type/resume/EditResume2.jsp?node=<%=teasession._nNode%>';">
<!--上一步-->
<%--
<input type="button"  name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"1167472219140")%>" onClick="window.open('/jsp/type/resume/EditAward.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
<input type="button"  name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"CBNext")%>" onClick="window.open('/jsp/type/resume/EditLang.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
<input type="button"  name="btnSaveAndNext" value="<%=r.getString(teasession._nLanguage,"GoFinish")%>" onClick="window.open('<%=nexturl%>','_self')"   />
--%>



  </form>


  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>

