<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
//tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
//tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String member=request.getParameter("member");
String from=request.getParameter("from");
String to=request.getParameter("to");
int address=0;
if(request.getParameter("address")!=null)
address=Integer.parseInt(request.getParameter("address"));

String community=node.getCommunity();
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function ShowCalendar(fieldname)
{
  eval(fieldname).value='';
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
function selectall(obj)
{
  for(var index=0;index<form2.elements.length;index++)
  {
    if(form2.elements[index].type=="checkbox")
    {
      form2.elements[index].checked=obj.checked;
    }
  }
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "客户管理")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td >
<form name="form1" action="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
用户ID<input type="text" name="member" size="15" value="<%=getNull(member)%>">
地址<select name="address_father" onchange="fonchange(this)"><!-- onchange="fonchange()">address_father-->
<%
StringBuffer script_address=new StringBuffer();
StringBuffer address_secondly=new StringBuffer();
java.util.Enumeration az_enumer=tea.entity.admin.Area.findByFather(tea.entity.admin.Area.getRootId(node.getCommunity()));
while(az_enumer.hasMoreElements())
{
  int id=((Integer)az_enumer.nextElement()).intValue();
  tea.entity.admin.Area a_obj     =   tea.entity.admin.Area.find(id);
  script_address.append("\r\ncase '"+id+"':\r\n");
  java.util.Enumeration a2_enumer=tea.entity.admin.Area.findByFather(id);
  while(a2_enumer.hasMoreElements())
  {
    int id2=((Integer)a2_enumer.nextElement()).intValue();
    tea.entity.admin.Area a2_obj     =   tea.entity.admin.Area.find(id2);
    script_address.append("form1.address.add(new Option('"+a2_obj.getName()+"','"+id2+"'));");
  }
  script_address.append("break;");
  %>
          <option value="<%=id%>" <%//=getSelect(id==so_obj.getAddress())%>><%= a_obj.getName()%></option>
      <%}%>
        </select>
        <select name="address" >
          <option value="0">-----请选择----</option>
        </select>
        <script type="">
        function fonchange(obj)
        {
          switch(obj.options[obj.selectedIndex].value)
          {
            <%=script_address%>
          }
        }
        fonchange(form1.address_father);
        for(var index=0;index<form1.address.length;index++)
        {
          if(form1.address.options[index].value==<%=address%>)
          {
            form1.address.options[index].selected=true;
            break;
          }
        }
        </script>
注册时间 FROM<input type="text" ondblclick="ShowCalendar('form1.from');" readonly="readonly" name="from" value="<%=getNull(from)%>" size="15"><input type="button" name="Submit" value="..." onclick="ShowCalendar('form1.from');">
TO<input type="text"  ondblclick="ShowCalendar('form1.to');"  readonly="readonly" name="to" value="<%=getNull(to)%>" size="15"><input type="button" name="Submit" value="..." onclick="ShowCalendar('form1.to');">
<input type="submit" name="Submit" value="GO">
</form></td></tr>
</table>

<form action="/jsp/user/EjSendMail.jsp" name="form2">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
    <td><input  id="CHECKBOX" type="CHECKBOX" value="" onclick="selectall(this);"/>全选</td>
    <td>用户ID</td>
    <td>地址</td>
    <td>注册时间</td>
    <td>余额</td>
    <td>操作</td>
  </tr>
  <%
  java.util.Date from_date=null,to_date=null;
  java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd");
  try
  {
    if(from!=null)
    {
      from_date=sdf.parse(from);
    }
    if(to!=null)
    {
      to_date=sdf.parse(to);
    }
  }catch(Exception e)
  {}
  java.util.Enumeration enumer=tea.entity.member.SClient.find(member,address,from_date,to_date);
  while(enumer.hasMoreElements())
  {
    String member_temp=enumer.nextElement().toString();
    tea.entity.member.SClient sclient=tea.entity.member.SClient.find(community,member_temp) ;
    tea.entity.member.Profile profile=tea.entity.member.Profile.find(member_temp);
    //member_temp=new String(member_temp.getBytes("ISO-8859-1"));
  %>
<tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
    <td><input  id="CHECKBOX" type="CHECKBOX" name="mail" value="<%=profile.getEmail()%>"/></td>
    <td><%=member_temp%></td>
    <td><%=tea.entity.admin.Area.find(sclient.getArea()).getName()%></td>
    <td><%=profile.getTimeToString()%></td>
    <td><%=sclient.getPrice()%></td>
    <td><input type="button" name="Submit" value="编辑" onclick="window.location='/jsp/user/EjRegister.jsp?node=<%=teasession._nNode%>&member=<%=member_temp%>'">
    </td>
  </tr>
<%}
%>
</table>
<br>
<%--input type="button" value="充值" onclick="window.location='/jsp/type/sorder/EditSClientPrice.jsp';"/--%>
<input type="submit" value="发信" >
<input type="button" value="创建" onclick="window.location='/jsp/user/EjRegister.jsp?node=<%=teasession._nNode%>'">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
  </body>
  </html>

