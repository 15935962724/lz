<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.resource.Resource"  %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.util.*" %>
<%@page import="java.util.*"%>
<%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int adword = Integer.parseInt(teasession.getParameter("adword"));

Adword obj = Adword.find(adword);

Resource r=new Resource();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_move(obj1,obj2)
{
	var i=-1;
	while((i=obj1.selectedIndex)!=-1)
	{
		var o=obj1.options[i];
		var j=obj2.length;
		obj2.options[j]=new Option(o.text,o.value);
		//obj2.options[j].selected=true;
		obj1.options[i]=null;
	}
	if(i==obj1.options.length)
	{
	  i--;
	}
	if(i!=-1)
	obj1.selectedIndex=i;
}
function f_submit(obj1,obj2)
{
   var v="/"
   if(!obj1.disabled)
   for(var i=0;i<obj1.length;i++)
   {
     v=v+obj1.options[i].value+"/";
   }
   obj2.value=v;
}

function submitCheck()
{

  return true;
}

function f_load__(obj0,obj1,obj2,obj3)
{
	if(obj0.value=="/")
	{
		obj3.checked=true;
		obj3.onclick();
	}else
	{
		var v=obj0.value.split("/");
		for(var i=0;i<v.length;i++)
		{
			for(var j=0;j<obj1.length;j++)
			{
				if(obj1[j].value==v[i])
				{
					var o=obj1.options[j];
					obj2.options[obj2.options.length]=new Option(o.text,o.value);
					obj1.options[j]=null;
					break;
				}
			}
		}
	}
}
function f_load()
{
	form1.region1.focus();
	f_load__(form1.region0,form1.region1,form1.region2,form1.region3);
	f_load__(form1.language0,form1.language1,form1.language2,form1.language3);
}
</script>
</head>
<body onload="f_load();">

为广告命名 > <b>目标客户</b> > 制作广告 > 选择关键字 > 定价 > 审核与保存
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" method="post" action="/servlet/EditAdword" onsubmit="f_submit(this.region2,this.region0);f_submit(this.language2,this.language0);" >
<input type=hidden name=community value="<%=teasession._strCommunity%>">
<input type=hidden name=adword value="<%=adword%>">
<input type=hidden name=act value=editadwordtarget >
<input type=hidden name=region0 value="<%=obj.getRegion()%>" >
<input type=hidden name=language0 value="<%=obj.getLanguage()%>" >
<input type=hidden name=nexturl value="/jsp/adword/EditAdwordShow.jsp">

<h2>按地区确定目标客户　　<input type=checkbox name=region3 onclick="form1.region1.disabled=form1.region2.disabled=this.checked;" >所有地区</h2>

在左侧突出显示您希望显示广告的城市和地区，然后单击“添加”。选择所需地区（数量不限）。
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>适用区域</td>
  <td></td>
  <td>所选地区</td>
</tr>
<tr>
<td>
<select name="region1" multiple size="8" style="width:150px" ondblclick="f_move(form1.region1,form1.region2);">
<%
Enumeration e=Card.find(" AND card<100",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
	Card c=(Card)e.nextElement();
	out.print("<option value="+c.getCard());

	out.print(" >"+c.getAddress());
}
%>
</select>
</td>
<td>
<input type=button value=添加 onclick="f_move(form1.region1,form1.region2);"><br>
<input type=button value=删除 onclick="f_move(form1.region2,form1.region1);">
</td>
<td>
<select name="region2" multiple size="8" style="width:150px" ondblclick="f_move(form1.region2,form1.region1);">
</select>
</td>
</tr>
</table>


<h2>按语言确定目标客户　　<input name="language3" type=checkbox onclick="form1.language1.disabled=form1.language2.disabled=this.checked;" >所有语言</h2>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>适用语言</td>
  <td></td>
  <td>所选语言</td>
</tr>
<tr>
<td>
<select name="language1" multiple size="8" style="width:150px" ondblclick="f_move(form1.language1,form1.language2);">
<%
for(int i=0;i<Adword.LANGUAGE_TYPE.length;i++)
{
	out.print("<option value="+Adword.LANGUAGE_TYPE[i][0]+" >"+Adword.LANGUAGE_TYPE[i][1]);
}
%>
</select>
</td>
<td>
<input type=button value=添加 onclick="f_move(form1.language1,form1.language2);"><br>
<input type=button value=删除 onclick="f_move(form1.language2,form1.language1);">
</td>
<td>
<select name="language2" multiple size="8" style="width:150px"  ondblclick="f_move(form1.language2,form1.language1);">
</select>
</td>
</tr>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage,"返回")%>" onclick="form1.nexturl.value='/jsp/adword/EditAdwordName.jsp';" >
<input type="submit" value="<%=r.getString(teasession._nLanguage,"继续")%>" >

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

