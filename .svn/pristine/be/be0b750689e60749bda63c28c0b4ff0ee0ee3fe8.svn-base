<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.resource.Resource" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();
r.add("/tea/ui/node/type/weather/EditWeather");

if(request.getMethod().equals("POST")||request.getParameter("delete")!=null)
{
  if(request.getParameter("delete")!=null)
  {
    int node=Integer.parseInt(request.getParameter("node"));
    Communityweather obj=Communityweather.find(node);
    obj.delete();
  }else
  {
    int type=Integer.parseInt(request.getParameter("type"));
    int node=Integer.parseInt(request.getParameter("node"));
    int area=Integer.parseInt(request.getParameter("area"+type+"1"));
    if(!teasession._strCommunity.equals(Node.find(node).getCommunity()))
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1170051362789"),"UTF-8"));
      return;
    }

    Communityweather obj=Communityweather.find(node);
    if(obj.isExists())
    {
      obj.set(area);
    }else
    {
      Communityweather.create(teasession._strCommunity,area,node);
    }
    //更新天气///////////////////
    Weather.uptime(node);
  }
  response.sendRedirect(request.getRequestURI()+"?community="+teasession._strCommunity);
  return;
}


StringBuffer sb00=new StringBuffer();
StringBuffer sb01=new StringBuffer();
for(int i=0;i<Communityweather.AREA_TYPE.length;i++)
{
  sb00.append("area00.options[area00.options.length]=new Option(\""+Communityweather.AREA_TYPE[i][0]+"\",\""+Communityweather.AREA_CODE[i][0]+"\");");

  sb01.append("case "+Communityweather.AREA_CODE[i][0]+":");
  for(int j=1;j<Communityweather.AREA_TYPE[i].length;j++)
  {
    sb01.append("area01.options[area01.options.length]=new Option(\""+Communityweather.AREA_TYPE[i][j]+"\",\""+Communityweather.AREA_CODE[i][j]+"\");");
  }
  sb01.append("break;\r\n");
}

StringBuffer sb10=new StringBuffer();
StringBuffer sb11=new StringBuffer();
for(int i=0;i<Communityweather.AREA_TYPE2.length;i++)
{
  sb10.append("area10.options[area10.options.length]=new Option(\""+Communityweather.AREA_TYPE2[i][0]+"\",\""+Communityweather.AREA_CODE2[i][0]+"\");");

  sb11.append("case "+Communityweather.AREA_CODE2[i][0]+":");
  for(int j=1;j<Communityweather.AREA_TYPE2[i].length;j++)
  {
    sb11.append("area11.options[area11.options.length]=new Option(\""+Communityweather.AREA_TYPE2[i][j]+"\",\""+Communityweather.AREA_CODE2[i][j]+"\");");
  }
  sb11.append("break;\r\n");
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_sb00()
{
  var area00=form1.area00;
  <%=sb00.toString()%>
}
function f_sb01()
{
  var area00=form1.area00;
  var area01=form1.area01;
  while(area01.options.length>1)
  {
    area01.options[1]=null;
  }
  switch(parseInt(area00.value))
  {
    <%=sb01.toString()%>
  }
}
function f_sb10()
{
  var area10=form1.area10;
  <%=sb10.toString()%>
}
function f_sb11()
{
  var area10=form1.area10;
  var area11=form1.area11;
  while(area11.options.length>1)
  {
    area11.options[1]=null;
  }
  switch(parseInt(area10.value))
  {
    <%=sb11.toString()%>
  }
}
function f_type()
{
  var area00=form1.area00;
  var area01=form1.area01;

  var area10=form1.area10;
  var area11=form1.area11;

    var type=form1.type;
    if(type[0].checked)
    {
      //disabled
      area00.style.display='';
      area01.style.display='';

      area10.style.display='none';
      area11.style.display='none';
    }else
    {
      area00.style.display='none';
      area01.style.display='none';

      area10.style.display='';
      area11.style.display='';
    }
}

function f_edit(value)
{
  var area00=form1.area00;
  var area01=form1.area01;

  var area10=form1.area10;
  var area11=form1.area11;

  var type=form1.type;
  if(type[0].checked)
  {
    for(var i=0;i<area00.options.length;i++)
    {
      area00.options[i].selected=true;
      f_sb01();
      for(var j=1;j<area01.options.length;j++)
      {
        if(parseInt(area01.options[j].value)==value)
        {
          area01.options[j].selected=true;
          break;
        }
      }
    }
  }else
  {
    for(var i=0;i<area10.options.length;i++)
    {
      area10.options[i].selected=true;
      f_sb11();
      for(var j=1;j<area11.options.length;j++)
      {
        if(parseInt(area11.options[j].value)==value)
        {
          area11.options[j].selected=true;
          break;
        }
      }
    }
  }
  f_type();
}

function f_submit()
{
  var area;
  var type=form1.type;
  if(type[0].checked)
  {
    area=form1.area01;
  }else
  {
    area=form1.area11;
  }
  return submitInteger(area,'<%=r.getString(teasession._nLanguage,"1170051216602")%>')&&submitInteger(form1.node,'<%=r.getString(teasession._nLanguage,"InvalidNodeNumber")%>');
}

function f_load()
{
  f_sb00();
  f_sb10();
  f_type();
}
</script>
</head>
<body onload="f_load();">

<h1><%=r.getString(teasession._nLanguage, "Weather")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="?" onSubmit="return f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage,"Type")%></td>
    <td><%=r.getString(teasession._nLanguage,"1170051216602")%></td>
    <td><%=r.getString(teasession._nLanguage,"Node")%></td>
    <td></td>
    </tr>
    <%
java.util.Enumeration e=Communityweather.findByCommunity(teasession._strCommunity,0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  Communityweather obj=(Communityweather)e.nextElement();
  out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" >");
  int type=-1;
  String _strArea="";
  for(int i=0;i<Communityweather.AREA_CODE.length;i++)
  {
    for(int j=1;j<Communityweather.AREA_CODE[i].length;j++)
    {
      if(Communityweather.AREA_CODE[i][j]==obj.getArea())
      {
        _strArea=Communityweather.AREA_TYPE[i][j];
        type=0;
        break;
      }
    }
  }
  if(type==-1)
  {
    for(int i=0;i<Communityweather.AREA_CODE2.length;i++)
    {
      for(int j=1;j<Communityweather.AREA_CODE2[i].length;j++)
      {
        if(Communityweather.AREA_CODE2[i][j]==obj.getArea())
        {
          _strArea=Communityweather.AREA_TYPE2[i][j];
          type=1;
          break;
        }
      }
    }
  }
  out.print("<td>"+r.getString(teasession._nLanguage,(type==0?"1170051131477":"1170051146211")));
  out.print("<td>"+_strArea);
  out.print("<td>"+obj.getNode());
//  out.print("<td><input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=\"form1.type["+type+"].checked=true; f_edit("+obj.getArea()+"); form1.node.value="+obj.getNode()+";  \"  >");
  out.print("<td><input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=\" if(confirm('"+r.getString(teasession._nLanguage,"ConfirmDelete")+"')){window.open('"+request.getRequestURI()+"?community="+teasession._strCommunity+"&node="+obj.getNode()+"&delete=on', '_self');this.disabled=true;};  \"  >");
}
%>
</table>


<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Type")%></td>
    <td><input type="radio" name="type" value="0" checked="checked" onclick="f_type();"><%=r.getString(teasession._nLanguage,"1170051131477")%> <input type="radio" name="type" value="1"  onclick="f_type();"><%=r.getString(teasession._nLanguage,"1170051146211")%></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"1170051216602")%></td>
    <td>
      <select name="area00" onchange="f_sb01();"><option value="">-----------</option></select>
      <select name="area01"><option value="">-----------</option></select>

      <select name="area10" onchange="f_sb11();"><option value="">-----------</option></select>
      <select name="area11"><option value="">-----------</option></select>
  </td>
  </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage,"Node")%></td>
    <td><input name="node" value="" ></td>
  </tr>

</table>

<input type="submit"  class="edit_input"  name="Submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>


