<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int crzzba=0;
String _strCrzzba=request.getParameter("crzzba");
if(_strCrzzba!=null)
{
  crzzba=Integer.parseInt(request.getParameter("crzzba"));
}
String nexturl=request.getParameter("nexturl");
if(nexturl==null)
nexturl=request.getRequestURI()+"?"+request.getQueryString();

String zzxm=null,zzpy=null,zzbm=null,zzsfzh=null,zzdz=null,zzyb=null,zzdh=null,zzsj=null,zzdzyj=null,zzjj=null,zzczfw=null,zzfy=null;
boolean zzht=false;
if(crzzba>0)
{
	Crzzba obj=Crzzba.find(crzzba);
	zzxm=obj.getZzxm();
	zzpy=obj.getZzpy();
	zzbm=obj.getZzbm();
	zzsfzh=obj.getZzsfzh();
	zzdz=obj.getZzdz();
	zzyb=obj.getZzyb();
	zzdh=obj.getZzdh();
	zzsj=obj.getZzsj();
	zzdzyj=obj.getZzdzyj();
	zzjj=obj.getZzjj();
	zzczfw=obj.getZzczfw();
	zzfy=obj.getZzfy();
	zzht=obj.isZzht();
}

%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script language="javascript">
//如果不是没include,就显示css
if(document.location.href.indexOf("EditCrzzba.jsp")!=-1)
{
  document.write("<link href=/res/<%=teasession._strCommunity%>/cssjs/community.css rel=stylesheet type=text/css>");
}

function submitLen(obj,len,text)
{
  if(obj.value.length>len)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
function checkform(Frm)
{
  	/*if(!isInt(Frm.text4.value))
	{
		alert("身份证号必须为数字！");
		Frm.text4.focus();
		return false;
	}*/
  return submitText(Frm.zzxm,"名称不能为空！")
  &&submitText(Frm.zzpy,"名称拼音不能为空！")
  &&submitText(Frm.zzsfzh,"身份证号不能为空！")
  &&submitText(Frm.zzdz,"地址不能为空！")
  &&submitText(Frm.zzyb,"邮政编码不能为空！")
  &&submitInteger(Frm.zzyb,"邮政编码必须为数字！")
  &&(Frm.zzsj.value.length<1 || submitInteger(Frm.zzsj,"移动电话必须为数字！"))
  &&submitText(Frm.zzdh,"联系电话不能为空！")
  &&submitText(Frm.zzczfw,"创作范围不能为空！")
  &&submitLen(Frm.zzczfw,100,"创作范围字数不能超过100汉字！")
  &&submitLen(Frm.zzfy,300,"附言的字数不应多于1000个字！");
}

</script>
</head>
<body>

<h1>作者信息备案</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM NAME="form_crz" ACTION="/servlet/EditCopyRight" METHOD="post" onSubmit="return checkform(this)">
  <input type="hidden" name="act" value="editcrzzba"/>
  <input type="hidden" name="zzqy" value="false">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="crzzba" value="<%=crzzba%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD ><font color=red>作者名称:</font></TD>
      <TD><INPUT name="zzxm" size="30" maxlength="50" value="<%if(zzxm!=null)out.print(zzxm);%>"></TD>
      <TD ><font color=red>名称拼音:</font></TD>
      <TD><INPUT name="zzpy" size="30" maxlength="50" value="<%if(zzpy!=null)out.print(zzpy);%>"></TD>
    </tr>
    <tr>
      <TD>作者笔名:</TD>
      <TD><INPUT name="zzbm" size="30" maxlength="50" value="<%if(zzbm!=null)out.print(zzbm);%>"></TD>
      <TD><font color=red>身份证号:</font></TD>
      <TD><INPUT name="zzsfzh" size="30" maxlength="17" value="<%if(zzsfzh!=null)out.print(zzsfzh);%>">
      </TD>
    </tr>
    <tr>
      <TD><font color=red>地&nbsp;&nbsp;&nbsp;&nbsp;址:</font></TD>
      <TD><INPUT name="zzdz" size="30" maxlength="100" value="<%if(zzdz!=null)out.print(zzdz);%>">
      <TD><font color=red>邮政编码:</font></TD>
      <TD><INPUT name="zzyb" size="30" maxlength="6" value="<%if(zzyb!=null)out.print(zzyb);%>">
    </tr>
    <tr>
      <TD><font color=red>联系电话:</font></TD>
      <TD><INPUT name="zzdh" size="30" maxlength="20" value="<%if(zzdh!=null)out.print(zzdh);%>"></TD>
      <TD>移动电话:</TD>
      <TD><INPUT name="zzsj" size="30" maxlength="11" value="<%if(zzsj!=null)out.print(zzsj);%>">
      </TD>
    </tr>
    <tr>
      <TD>电子邮件:</TD>
      <TD><INPUT name="zzdzyj" size="30" maxlength="100" value="<%if(zzdzyj!=null)out.print(zzdzyj);%>"></TD>
      <TD><font color=red>寄送合同:</font></TD>
      <TD>
        <input type="radio" name="zzht" value="true" <%if(zzht)out.print("checked");%>>是
        <input type="radio" name="zzht" value="false" <%if(!zzht)out.print("checked");%>>否
      </TD>
    </tr>
    <tr>
      <TD>作者简介:</TD>
      <TD colspan=3><input type="text" name="zzjj" maxlength="60" size="60" value="<%if(zzjj!=null)out.print(zzjj);%>"></TD>
    </tr>
    <tr>
      <TD colspan=4><br>
        <font color=red>创作范围：</font><br>
        <textarea name="zzczfw" cols="85" rows=3 ><%if(zzczfw!=null)out.print(zzczfw);%></textarea></TD>
    </tr>
    <tr>
      <TD colspan=4><br>
        附言：<br>
        <textarea name="zzfy" cols="85" rows=3 ><%if(zzfy!=null)out.print(zzfy);%></textarea></TD>
    </tr>
    <TR>
      <TD ><INPUT TYPE="SUBMIT" VALUE="提交"></TD>
      <TD ><INPUT TYPE="RESET" VALUE="重置"></TD>
    </TR>
  </TABLE>
</FORM>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

