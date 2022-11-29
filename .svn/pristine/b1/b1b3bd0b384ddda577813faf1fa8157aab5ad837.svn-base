<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request);
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=h.get("community");
String nexturl=h.get("nexturl");
String dir=h.get("dir","flow");
int flow=h.getInt("flow");
int flowbusiness=h.getInt("flowbusiness");

String member=teasession._rv.toString();

Flowbusiness fb=Flowbusiness.find(flowbusiness);

Flow f=Flow.find(fb.getFlow());

Flowprocess fp=Flowprocess.find(fb.getFlow(),fb.getStep());
int flowprocess=fp.getFlowprocess();

Flowview fv=Flowview.find(flowbusiness,flowprocess,member);

if(request.getMethod().equals("POST"))
{
  if(request.getParameter("recovery")!=null)//收回委托
  {
    fv.setConsign(null,null);
  }else
  {
    String consign=request.getParameter("consign");
    if(!Profile.isExisted(consign))
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(consign+"会员不存在了.","UTF-8"));
      return;
    }
    int ctime=h.getInt("ctime");
    fv.setConsign(consign,ctime<1?null:MT.add(new Date(),ctime));

    StringBuffer sb=new StringBuffer();
    sb.append("委托人:").append(member).append("<br>");
    sb.append("第").append(fb.getStep()).append("步");
    if(f.getType()!=1)sb.append(fb.name);//如果不是自由流程
    String url="/jsp/admin/"+dir+"/FlowbusinessEdit.jsp?community="+community+"&flowbusiness="+flowbusiness+"&flow="+flow+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8");
    sb.append("<br><br><a href='"+url+"' class='Flowbusiness_here' target='m' onclick='opener=null;window.close();'>点这里进行办理</a>");

    Message.create(teasession._strCommunity,teasession._rv._strV,consign,teasession._nLanguage,"您有《"+fb.name+"》工作需要办理！",sb.toString());

    /*
    int currentlysetp=Integer.parseInt(request.getParameter("currentlysetp"));
    Flowview fvobj=Flowview.find(flowbusiness,currentlysetp);
    if(fvobj.isExists())
    {
      fvobj.set(teasession._rv.toString());
    }else
    {
      fvobj.create(flowbusiness,currentlysetp,currentlymember);
    }*/
  }
  response.sendRedirect(nexturl);
  return;
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="">
<h1>委托代办人</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<%--
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
Flowprocess currentlyobj=null;
java.util.Enumeration enumer=Flowprocess.find(flow," ORDER BY sequence");
for(int index=1;enumer.hasMoreElements();index++)
{
  int flowprocess=((Integer)enumer.nextElement()).intValue();
  Flowprocess obj=Flowprocess.find(flowprocess);

  Flowview fvobj=Flowview.find(flowbusiness,obj.getStep());


%>
<tr class="TableLine1">
  <td >第 <%=obj.getStep()%> 步</td>
  <td ><%=obj.getName(teasession._nLanguage)%>
    <%
    if(fb.getStep()==obj.getStep())
    {
      out.print("(当前步骤)");
      currentlyobj=obj;
    }
    %></td>
  <td nowrap><%if(fvobj.isExists()){out.print(fvobj.getMember());out.print(" [<font color=green>"+fvobj.getTimeToString()+"</font>]");}%><br></td>
</tr>
<%}
if(currentlyobj==null)
{
  currentlyobj=Flowprocess.find(0);
}
%>
</table>
--%>

<form name="form1" action="?" method="POST" >
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>"/>
<input type="hidden" name="flow" value="<%=flow%>"/>
<input type="hidden" name="dir" value="<%=dir%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<%
if(f.getType()!=1)//如果是自由流程
{
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr><td>委托代办人:</td>
    <td>
    <%
    String members[]=fp.getMember().split("/");
    for(int i=1;i<members.length;i++)
    {
      Profile p=Profile.find(members[i]);
      if(p.getTime()==null)continue;
      out.println("<input name='consign' checked type='radio' value=\""+members[i]+"\" id='seq"+i+"'><label for='seq"+i+"'>"+members[i]+"</label><br>");//+" ( "+p.getName(teasession._nLanguage)
    }
    out.print("<script>var o=form1.consign; if(!o.length)o=new Array(o); for(var i=0;i<o.length;i++) if(false");
    Enumeration e=Flowview.find(flowbusiness,flowprocess);
    while(e.hasMoreElements())
    {
      int flowview=((Integer)e.nextElement()).intValue();
      fv=Flowview.find(flowview);
      out.print("||o[i].value=='"+fv.getTransactor()+"'");
    }
    out.print(")o[i].disabled=true;</script>");
    %>
    </td>
  </tr>
  <tr><td>有效期</td><td><select name="ctime"><option value="0">--无--</option>
   <%
   for(int i=1;i<21;i++)
   {
     out.print("<option value="+i+">"+i+"天");
   }
   %></select></td></tr>
</table>
<%
}else
{
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>委托代办人:</td>
    <td><input type="text" value="" name="consign"/></td>
  </tr>
</table>
<%
}
%>
<input type="submit" value="提交"/>
<input type="button" value="返回" onclick="window.history.back();"/>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
