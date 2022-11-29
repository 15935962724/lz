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
<script src="/tea/tea.js" type="text/javascript"></script>
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
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name=form1 METHOD=post action="/servlet/SalesImport" onSubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')">
  <input type=hidden name="community" value="<%=community%>"/>
  <input type=hidden name="identity" value="<%=identity%>"/>
  <textarea name=file style="display:none" ><%=content.replaceAll("</","&lt;/")%></textarea>
  <input type=hidden name="act" value="importworkproject"/>
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
  <h2>客户信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <!--名称-->
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1168575002906")%></td>
      <td><select name=name></select>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1168574945796")%>
        <!--电话--></td>
      <td><select name="tel" ></select></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1168574969234")%>
        <!--传真--></td>
      <td><select name="fax"></select></td>
    </tr>
    <tr>
      <td>URL</td>
      <td><select name="url"></select></td>
    </tr>
    <tr>
      <td>E-Mail</td>
      <td><select name="email" ></select></td>
    </tr>
  </table>
  <h2>其他信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>类型</td>
      <td ><select name="type" ></select>      </td>
      <td>职员数</td>
      <td><select name="employee" ></select></td>
    </tr>
    <tr>
      <td>行业</td>
      <td><select name="calling" ></select>      </td>
      <td>年收入</td>
      <td><select name="earning" ></select></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Text")%>
        <!--内容--></td>
      <td><select name="content" ></select></td>
    </tr>
    <tr>
      <td>开单地址 - 国家/地区</td>
      <td ><select name="country" ></select></td>
      <td> 发货地址 - 国家/地区 </td>
      <td ><select name="country2" ></select></td>
    </tr>
    <tr>
      <td> 开单地址 - 邮政编码 </td>
      <td><select name="postcode" ></select></td>
      <td> 发货地址 - 邮政编码 </td>
      <td><select name="postcode2" ></select></td>
    </tr>
    <tr>
      <td> 开单地址 - 州/省 </td>
      <td ><select name="state" ></select></td>
      <td> 发货地址 - 州/省 </td>
      <td><select name="state2" ></select></td>
    </tr>
    <tr>
      <td> 开单地址 - 城市 </td>
      <td><select name="city" ></select></td>
      <td> 发货地址 - 城市 </td>
      <td><select name="city2" ></select></td>
    </tr>
    <tr>
      <td>开单地址 - 街道</td>
      <td><select name="street" ></select></td>
      <td> 发货地址 - 街道 </td>
      <td><select name="street2" ></select></td>
    </tr>
  </table>
  <input type="button" value="<%=r.getString(teasession._nLanguage,"上一步")%>" onclick="window.open('/jsp/admin/workreport/ImportWorkproject2.jsp?community=<%=teasession._strCommunity%>&charset=<%=charset%>&identity=<%=identity%>','_self');" >
  <input type="submit" value="<%=r.getString(teasession._nLanguage,"开始导入")%>" >

</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



