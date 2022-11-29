<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.convert.*"%>
<%@page import="com.jacob.com.*"%><%

Http h=new Http(request,response);
//TeaSession ts=new TeaSession(request);
//if(ts._rv==null)
//{
//  out.print("<script>top.location='/servlet/StartLogin'</script>");
//  return;
//}

Dispatch dp=Dispatch.get(Paper.P2F,"DefaultPrintingPreferences").toDispatch();
Conf co=Conf.find(h.community);

%><!DOCTYPE html><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>页面设置</h1>

<form name="form1" action="/Papers.do?repository=paper" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="act" value="printing"/>
<input type="hidden" name="nexturl"/>

<h2>布局</h2>
<table id="tablecenter">
  <tr>
    <td>Actual</td>
    <td><input type="checkbox" name="Actual"/>Actual</td>
  </tr>
  <tr>
    <td>方向</td>
    <td usemap="<%=Dispatch.get(dp,"Orientation")%>"><%
    int tf=co.getInt("Orientation");
    String[] PAPER_ORIENTATION={"","纵向","横向"};
    for(int i=1;i<PAPER_ORIENTATION.length;i++)
    {
      out.print("<input type='radio' name='Orientation' value='"+i+"' id='o"+i+"'");
      if(tf==i)out.print(" checked");
      out.print(" /><label for='o"+i+"'>"+PAPER_ORIENTATION[i]+"</label>　");
    }
    %></td>
  </tr>
  <tr>
    <td>页面大小</td>
    <td><input type="radio" name="type" value="0" id="_type0" onclick="mt.type(0)" checked /><label for="_type0">标准</label>　<input type="radio" name="type" value="1" id="_type1" onclick="mt.type(1)" /><label for="_type1">自定义</label></td>
  </tr>
  <tr id="type0">
    <td>纸张</td>
    <td><input name="FormName" value="<%=co.get("FormName")%>" usemap="<%=Dispatch.get(dp,"FormName")%>"/>Letter/信纸</td>
  </tr>
  <tr id="type1">
    <td>纸张</td>
    <td>宽<input name="PaperWidth" value="<%=co.get("PaperWidth")%>" usemap="<%=Dispatch.get(dp,"PaperWidth")%>"/> 高<input name="PaperLength" value="<%=co.get("PaperLength")%>" usemap="<%=Dispatch.get(dp,"PaperLength")%>"/></td>
  </tr>
  <tr>
    <td>分辨率</td>
    <td><input name="Resolution" value="<%=co.getInt("Resolution")%>" usemap="<%=Dispatch.get(dp,"Resolution")%>"/>dpi  72-600</td>
  </tr>
</table>


<br/>
<input class="but2" type="submit" value="提　交"/> <input class="but2" type="button" value="重　置" onclick="mt.reset()"/>
</form>

<script>
form1.nexturl.value=location.pathname+location.search;
form1.Actual.usemap=<%=Dispatch.get(dp,"Actual")%>;
form1.Actual.checked=<%=Dispatch.get(dp,"Actual")%>;

mt.type=function(j)
{
  for(var i=0;i<2;i++)
  {
    $$('type'+i).style.display=i==j?'':'none';
  }
};
mt.type(<%=co.getInt("type")%>);
mt.reset=function()
{
  var arr=form1.elements;
  for(var i=0;i<arr.length;i++)
  {
    var t=arr[i].getAttribute('usemap');
    if(arr[i].type=='text')
    arr[i].value=t;
  }
};
mt.focus();
</script>
</body>
</html>
