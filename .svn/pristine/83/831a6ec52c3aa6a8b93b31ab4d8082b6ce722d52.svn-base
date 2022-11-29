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
<form name=form1 METHOD=post action="/servlet/EditLatency" onSubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')">
  <input type=hidden name="community" value="<%=community%>"/>
  <input type=hidden name="identity" value="<%=identity%>"/>
  <textarea name=file style="display:none" ><%=content.replaceAll("</","&lt;/")%></textarea>
  <input type=hidden name="act" value="import"/>
  <h2>记录创建者</h2>
    <select name=member>
      <option value="-1">----------------</option>
      <%
      for(int i=0;i<titles.length;i++)
      {
    	  out.print("<option value="+i+">"+titles[i]+" ( "+(i+1)+" )");
      }
      %>
      </select>&nbsp;(这个选项是导入每条记录的创建者，如果不选择，系统默认为当前会员)
  <h2>潜在客户信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <!--名称-->
    <tr>
      <td><%=r.getString(teasession._nLanguage,"姓")%></td>
      <td><select name=family></select>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"名")%></td>
      <td><select name=firsts></select>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1168574945796")%>
        <!--电话--></td>
      <td><select name="telephone" ></select></td>
    </tr>
 	<tr>
      <td>E-Mail</td>
      <td><select name="email" ></select></td>
    </tr>
    <tr>
      <td>公司</td>
      <td><select name="corp" ></select></td>
    </tr>
      <tr>
      <td>分级</td>
      <td><select name="grade" ></select></td>
    </tr>

     <tr>
      <td>职务</td>
      <td><select name="duty" ></select></td>
    </tr>


  </table>
  <h2>其他信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

 	 <tr>
      <td>国家/地区：</td>
      <td><select name="country"></select></td>
    </tr>
     <tr>
      <td>邮政编码：</td>
      <td><select name="postalcode"></select></td>
    </tr>
     <tr>
      <td>洲/省：</td>
      <td><select name="province"></select></td>
    </tr>
      <tr>
      <td>城市：</td>
      <td><select name="city"></select></td>
    </tr>
        <tr>
      <td>街道：</td>
      <td><select name="street"></select></td>
    </tr>
 	<tr>
      <td>网址:</td>
      <td><select name="webaddress"></select></td>
    </tr>
	<tr>
		<td>员工数：</td>
		<td><select name="counts"></select></td>
	</tr>
	<tr>
		<td>潜在客户来源：</td>
		<td><select name="origin"></select></td>
	</tr>
	<tr>
		<td>年收入：</td>
		<td><select name="income"></select></td>
	</tr>
	<tr>
		<td>行业：</td>
		<td><select name="calling"></select></td>
	</tr>
	<tr>
		<td>备注：</td>
		<td><select name="remark"></select></td>
	</tr>
  </table>
  <input type="button" value="<%=r.getString(teasession._nLanguage,"上一步")%>" onclick="window.open('/jsp/admin/sales/import2.jsp?community=<%=teasession._strCommunity%>&charset=<%=charset%>&identity=<%=identity%>','_self');" >
  <input type="submit" value="<%=r.getString(teasession._nLanguage,"开始导入")%>" >

</form>
<br>
<div id="head6"><img height="6"></div>
</body>
</html>



