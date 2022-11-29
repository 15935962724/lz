<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.site.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

final String RELATION_TYPE[]={"等于","大于","小于","大于等于","小于等于","不等于","开始为","包含","结束为"};

StringBuffer rt=new StringBuffer();
for(int i=0;i<RELATION_TYPE.length;i++)
{
  rt.append("<option value=").append(i);
  if(i==7)
  rt.append(" SELECTED ");
  rt.append(">").append(RELATION_TYPE[i]);
}

String community=teasession._strCommunity;

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
function defaultfocus()
{
  form1.flow.focus();
}
function f_submit()
{
  var param="/jsp/admin/flow/QueryResults.jsp?";
  var el=form1.elements;
  for(var i=0;i<el.length;i++)
  {
    if(el[i].name.length>0&&el[i].value.length>0)
    param=param+"&"+el[i].name+"="+encodeURIComponent(el[i].value);
  }
  window.opener.location=param;
  window.close();
  return false;
}

function f_display(v)
{
  var tr=document.getElementsByTagName("TR");
  for(var i=0;i<tr.length;i++)
  {
    if(!isNaN(parseInt(tr[i].id)))
    {
     tr[i].style.display=(tr[i].id==v?"":"none");
    }
  }
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>流程查询</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<BR>
<form name="form1" method="post" onSubmit="return submitText(this.flow, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-流程名称')&&f_submit();">
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="act" value="queryflow"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
    <td>流程名称</td>
    <td nowrap><select name="flow" onchange="f_display(this.value);">
        <option value="">------------</option>
           <%
StringBuffer sb=new StringBuffer();
java.util.Enumeration e=Flow.find(community,"");
for(int index=1;e.hasMoreElements();index++)
{
  int flow=((Integer)e.nextElement()).intValue();
  Flow obj=Flow.find(flow);
  out.print("<option value="+flow+" >"+obj.getName(teasession._nLanguage));
  int dynamic=obj.getDynamic();
  
  Dynamic d=Dynamic.find(dynamic);
  java.util.Enumeration e2=DynamicType.findByDynamic(dynamic);
  sb.append("<tr style=display:none id=").append(flow).append("><td colspan=2>表单数据信息（表单名称：").append(d.getName(teasession._nLanguage)).append(" ）</td></tr> \r\n");
  while(e2.hasMoreElements())
  {
     int dynamictype=((Integer)e2.nextElement()).intValue();
     DynamicType dt_obj=DynamicType.find(dynamictype);
	 sb.append("<tr style=display:none id=").append(flow).append("><td>").append(dt_obj.getName(teasession._nLanguage)).append("</td><td><select name=dt_rt>").append(rt.toString()).append("</select><input type=text name=dt").append(dynamictype).append(" ></td></tr> \r\n");    
  }
}
           %></select>
         </td>
       </tr>
       <%=sb.toString()%>
  </table>
  
           <input type="submit" value="提交">
           <input type="reset" value="重置" onClick="defaultfocus();">
           <input type="button" value="关闭" onClick="window.close();">
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>


