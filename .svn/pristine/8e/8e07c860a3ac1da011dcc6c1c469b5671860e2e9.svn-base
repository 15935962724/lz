<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="java.util.regex.*" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


int flowbusiness=h.getInt("flowbusiness");
int dynamictype=h.getInt("dynamictype");

String code=h.get("code");
if("ajax".equals(h.get("act")))
{
  out.print(DynamicValue.find(" AND node!="+-flowbusiness+" AND dynamictype IN(86,158,116,570) AND value="+DbAdapter.cite(code)).hasMoreElements());
  return;
}

String type=h.get("type");
int no=h.getInt("no");
if("POST".equals(request.getMethod()))
{
  FlowIssuecode t=FlowIssuecode.find(teasession._strCommunity,type);
  if(t.no<no)
  t.set("no",String.valueOf(no));

  out.print("<script>dialogArguments.document.form1.dynamictype"+dynamictype+".value='"+code+"';window.returnValue=true;window.close();</script>");
  return;
}

int year=Calendar.getInstance().get(Calendar.YEAR);

int i=code.indexOf('〔'),j=code.indexOf('〕',i+1);
if(i!=-1&&j!=-1&&j-i==5)
{
  type=code.substring(0,i);
  year=Integer.parseInt(code.substring(i+1,j));
  String str=code.endsWith("号")?code.substring(0,code.length()-1):code;
  no=Integer.parseInt(str.substring(j+1));
}else
{
  //CommunityOffice co=CommunityOffice.find(teasession._strCommunity);
  //sn=SeqTable.getSeqNo("flowbusiness.sn");
  //code="〔"+year+"〕"+sn+"号";
}


%><html>
<head>
<title>文件字号</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script LANGUAGE=JAVASCRIPT src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin-left: 0px;
 margin-top: 0px;
 margin-right: 0px;
 margin-bottom: 0px;
 border:0px;
 background-color:menu;
}
-->
</style>
</head>
<body>
<br/>
<form name="form1" action="?" method="post" onSubmit="return submitText(this.type,'“文件字”不能为空！')&&submitText(this.year,'“年度”不能为空！')&&submitText(this.no,'“序号”不能为空！');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>"/>
<input type="hidden" name="dynamictype" value="<%=dynamictype%>"/>
<input type="hidden" name="code" value="<%=code%>"/>
<table class="Views">
<tr><td>
文件字：<select name="type" onchange="form1.no.value=form1.type.options[form1.type.selectedIndex].getAttribute('no');f_cl()"><option value="">---------</option>
<%
java.util.Enumeration enumer=FlowIssuecode.find(" AND community="+DbAdapter.cite(teasession._strCommunity),0,100);
while(enumer.hasMoreElements())
{
  FlowIssuecode t=(FlowIssuecode)enumer.nextElement();
  out.print("<option value='"+t.name+"' no='"+(t.no+1)+"'");
  if(t.name.equals(type))out.print(" selected");
  out.print(">"+t.name);
}
%>
</select>
年度：<input name="year" onkeyup="f_cl()" onchange="f_cl()" value="<%=year%>" mask="int" size="5"/>
序号：<input name="no" onkeyup="f_cl()" onchange="f_cl()" value="<%=no%>" mask="int" size="5"/>
</td>
<tr><td>文　号：<span id="t_code"><%=code%></span>
<!--<tr class="Date"><td align="center"><input name="code" size="40" value=""/></td></tr>-->
</table>
<br/>
<input type="submit" value=" 确 定 "/>
<input type="button" value=" 取 消 " onclick="window.close();"/>
</form>
<script>
var doc=dialogArguments.document;
var dt=doc.form1.dynamictype<%=dynamictype%>;
var t_code=$('t_code');
function f_cl()
{
  form1.code.value=form1.type.value+'〔'+form1.year.value+'〕'+form1.no.value+'号';
  t_code.innerHTML='检测是否重复...';
  sendx('?act=ajax&flowbusiness='+form1.flowbusiness.value+'&code='+encodeURIComponent(form1.code.value),function(a){t_code.style.color=a.indexOf('true')==-1?'#0000FF':'#FF0000';t_code.innerHTML=form1.code.value;});
}
</script>

</body></html>
