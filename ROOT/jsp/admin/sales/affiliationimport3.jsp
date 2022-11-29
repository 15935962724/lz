<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.htmlx.*"%><%@page import="tea.ui.TeaSession"%><%

request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

byte by[]=teasession.getBytesParameter("file");//csv格式的文件
String charset=teasession.getParameter("charset");//文件的具体编码格式

if(by==null||by.length<1)
{
	response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLDecoder.decode(r.getString(teasession._nLanguage,"InvalidFile"),"UTF-8"));
	return;
}

String identity=request.getParameter("identity");//匹配类型

String content=new String(by,charset).trim();//调整编码格式的吧

String rows[]=content.split("\n");

String titles[]=rows[0].split(",");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_load()
{
  form1.member.focus();
  var s=document.getElementsByTagName("SELECT");
  var op=form1.member.options;
  for(var i=0;i<op.length;i++)
  {
    //s[j].options[0]=new Options('---------------','-1');
    for(var j=1;j<s.length;j++)
	{
	  s[j].options[i]=new Option(op[i].text,op[i].value);
	}
  }
}
</script>
</head>
<body onLoad="f_load();">

<h1><%=r.getString(teasession._nLanguage,"步骤 3（共 3 步）：映射字段")%></h1>
<div id="head6"><img height="6"></div>
<br>
<form name=form1 METHOD=post action="/servlet/EditAffilationimport" onSubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')">
  <input type=hidden name="community" value="<%=community%>"/>
  <input type=hidden name="identity" value="<%=identity%>"/>
  <textarea name=file style="display:none" ><%=content.replaceAll("</","&lt;/")%></textarea>
  <input type=hidden name="act" value="import"/>
  <h2>记录所有人</h2>
    <select name=member>
      <option value="-1">----------------</option>
      <%
      for(int i=0;i<titles.length;i++)
      {
    	  out.print("<option value="+i+">"+titles[i]+" ( "+(i+1)+" )");
      }
      %>
      </select>
  <h2>联系人信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <!--名称-->
    <tr>
      <td><%=r.getString(teasession._nLanguage,"姓名")%></td>
      <td><select name=name></select>
      </td>
    </tr>
 
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1168574945796")%>
        <!--电话--></td>
      <td><select name="tel" ></select></td>
    </tr>
    <tr>
      <td>手机</td>
      <td><select name="mobile" ></select></td>
    </tr>
 	<tr>
      <td>E-Mail</td>
      <td><select name="email" ></select></td>
    </tr>
    <tr>
      <td>客户</td>
       <input type=hidden name=clienttype value="false" >
      <td><select name="client" ></select></td>
    </tr>
      <tr>
      <td>直属上司</td>
      <td><select name="supervisor" ></select></td>
    </tr>
     
     <tr>
      <td>职务</td>
      <td><select name="job" ></select></td>
    </tr>

  
  </table>
  <h2>地址信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	
 	 <tr>
      <td>邮寄地址 - 国家/地区：</td>
      <td><select name="country"></select></td>
       <td>其他地址 - 国家/地区：</td>
      <td><select name="country2"></select></td>
    </tr>
     <tr>
      <td>邮寄地址 - 邮政编码 ：</td>
      <td><select name="postcode"></select></td>
      <td>其他地址 - 邮政编码 ：</td>
      <td><select name="postcode2"></select></td>
    </tr>
     <tr>
      <td>邮寄地址 - 州/省：</td>
      <td><select name="state"></select></td>
      <td>其他地址 - 州/省：</td>
      <td><select name="state2"></select></td>
    </tr>
      <tr>
      <td>邮寄地址 - 城市：</td>
      <td><select name="city"></select></td>
      <td>其他地址 - 城市：</td>
      <td><select name="city2"></select></td>
    </tr>
        <tr>
      <td>邮寄地址 - 街道：</td>
      <td><select name="street"></select></td>
      <td>其他地址 - 街道：</td>
      <td><select name="street2"></select></td>
    </tr>
    </table>
    <h2>其他信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
      <td>传真:</td>
      <td><select name="fax"></select></td>
      <td>潜在客户来源：</td>
		<td><select name="origin"></select></td>
    </tr>
	<tr>
		<td>家庭电话：</td>
		<td><select name="hometel"></select></td>
		<td>出生日期：</td>
		<td><select name="birth"></select></td>
	</tr>
	<tr>
		<td>其他电话：</td>
		<td><select name="othertel"></select></td>
		<td>部门：</td>
		<td><select name="unit"></select></td>
	</tr>
	<tr>
		<td>助理：</td>
		<td><select name="assistant"></select></td>
		<td>助理电话：</td>
		<td><select name="assistanttel"></select></td>
	</tr>
	<tr>
		<td>备注：</td>
		<td><select name="content"></select></td>
	</tr>
  </table>
  <input type="button" value="<%=r.getString(teasession._nLanguage,"上一步")%>" onclick="window.open('/jsp/admin/sales/affiliationimport2.jsp?community=<%=teasession._strCommunity%>&charset=<%=charset%>&identity=<%=identity%>','_self');" >
  <input type="submit" value="<%=r.getString(teasession._nLanguage,"开始导入")%>" >

</form>
<br>
<div id="head6"><img height="6"></div>
</body>
</html>



