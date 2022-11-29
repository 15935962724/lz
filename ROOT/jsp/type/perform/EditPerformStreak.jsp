<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.node.*" %><%@page  import="tea.entity.site.*" %><%@ page import="java.util.*" %><%@ page import="java.io.*" %>
<%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %>
<%@ page import="tea.htmlx.*"%>
<%

request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
Node node = Node.find(teasession._nNode);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String community=node.getCommunity();

String nexturl=teasession.getParameter("nexturl");

String act = teasession.getParameter("act");

int  psid = 0;
if(teasession.getParameter("psid")!=null && teasession.getParameter("psid").length()>0)
{
  psid = Integer.parseInt(teasession.getParameter("psid"));
}
PerformStreak psobj = PerformStreak.find(psid);

if("EditPerformStreak".equals(act))
{

  String psname = teasession.getParameter("psname");
  int venues = 0;
  if(teasession.getParameter("venues")!=null && teasession.getParameter("venues").length()>0)
  {
    venues = Integer.parseInt(teasession.getParameter("venues"));
  }
  int chevalue = 0;
  if(teasession.getParameter("chevalue")!=null && teasession.getParameter("chevalue").length()>0)
  {
    chevalue = Integer.parseInt(teasession.getParameter("chevalue"));
  }

  Date pftime =   TimeSelection.makeTime(teasession.getParameter("pftimeYear"),teasession.getParameter("pftimeMonth"),teasession.getParameter("pftimeDay"),teasession.getParameter("pftimeHour"),teasession.getParameter("pftimeMinute"));
  Date stardrawtime =   TimeSelection.makeTime(teasession.getParameter("stardrawtimeYear"),teasession.getParameter("stardrawtimeMonth"),teasession.getParameter("stardrawtimeDay"),teasession.getParameter("stardrawtimeHour"),teasession.getParameter("stardrawtimeMinute"));
  Date enddrawtime =   TimeSelection.makeTime(teasession.getParameter("enddrawtimeYear"),teasession.getParameter("enddrawtimeMonth"),teasession.getParameter("enddrawtimeDay"),teasession.getParameter("enddrawtimeHour"),teasession.getParameter("enddrawtimeMinute"));
  Date endbouncetime =   TimeSelection.makeTime(teasession.getParameter("endbouncetimeYear"),teasession.getParameter("endbouncetimeMonth"),teasession.getParameter("endbouncetimeDay"),teasession.getParameter("endbouncetimeHour"),teasession.getParameter("endbouncetimeMinute"));
  Date startonlinetime =   TimeSelection.makeTime(teasession.getParameter("startonlinetimeYear"),teasession.getParameter("startonlinetimeMonth"),teasession.getParameter("startonlinetimeDay"),teasession.getParameter("startonlinetimeHour"),teasession.getParameter("startonlinetimeMinute"));
  Date endonlinetime =   TimeSelection.makeTime(teasession.getParameter("endonlinetimeYear"),teasession.getParameter("endonlinetimeMonth"),teasession.getParameter("endonlinetimeDay"),teasession.getParameter("endonlinetimeHour"),teasession.getParameter("endonlinetimeMinute"));
  
  
  if(psobj.isExist())
  {
    psobj.set(teasession._nNode,psname,venues,chevalue,pftime,stardrawtime,enddrawtime,endbouncetime,startonlinetime,endonlinetime,teasession._rv.toString());
  }else
  {
	  psid= PerformStreak.create(teasession._nNode,psname,venues,chevalue,pftime,stardrawtime,enddrawtime,endbouncetime,startonlinetime,endonlinetime,teasession._strCommunity,teasession._rv.toString());
  }
  if(chevalue>0)
  {
	  PerformStreak.setTemplet(psid,chevalue,teasession._strCommunity);
  }
  
  
  
  out.print("<script>alert('场次添加成功！'); window.returnValue=1;window.close();</script>");
  return;

}else if("delete".equals(act))
{
	psobj.delete();//删除这个场次
	Vote.delete(psid);//删除这个场次的票种
	Discoun.delete(psid);//删除打折信息
	out.println("<script>alert('您已经删除这个场次!');</script>");
	out.println("<script>self.location='"+nexturl+"'</script>");
	return;
}
String psname = null;
int venues = 0;
int chevalue = 0;
Date pftime=null,stardrawtime=null,enddrawtime=null,endbouncetime=null,startonlinetime=null,endonlinetime=null;
if(psobj.isExist())
{
	psname = psobj.getPsname();
	venues = psobj.getVenues();
	chevalue =psobj.getChevalue();
	pftime=psobj.getPftime();
	stardrawtime=psobj.getStardrawtime();
	enddrawtime=psobj.getEnddrawtime();
	endbouncetime=psobj.getEndbouncetime();
	startonlinetime=psobj.getStartonlinetime();
	endonlinetime=psobj.getEndonlinetime();
	
}


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onload="f_onload();">
<script>
window.name='tar';
function f_onload()
{
	f_onchange_venues();
}
function f_submit()
{
  if(form1.psname.value=='')
  {
    alert('请添加场次名称!');
    document.form1.psname.focus();
    return false;
  }
  if(form1.venues.value==0)
  {
    alert('请添加演出场馆!');
    document.form1.venues.focus();
    return false;
  }
}
function f_venues()
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:557px;dialogHeight:405px;';
  var url = '/jsp/type/perform/inquiryVenues.jsp?community='+form1.community.value;
  var rs = window.showModalDialog(url,self,y);
  if(rs>0)
  { 
    form1.venues.value=rs;
    f_onchange_venues();
  }
}
//选择演出场馆 显示 这个场馆的场次名称
function f_onchange_venues()
{
	     sendx("/jsp/type/perform/PerformOrders_ajax.jsp?act=EditPerformStreak_f_onchange_venues&node="+form1.node.value+"&venues="+form1.venues.value+"&community="+form1.community.value+"&chevalue=<%=chevalue%>&psid=<%=psid%>",
		  function(data)
		  {
		    document.getElementById("showchevalue").innerHTML=data.trim();
		  } 
		  );
}        
</script>
<h1>演出管理--场次设置--添加场次</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <form name="form1" method="post" action="?"   target="tar"   onSubmit="return f_submit();">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <input type="hidden" name="act" value="EditPerformStreak">
  <input type="hidden" name="community" value="<%=teasession._strCommunity %>">
  <input type="hidden" name="psid" value="<%=psid %>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right"> &nbsp;*&nbsp;场次名称:</td>
      <td ><input type="text" size="60" class="edit_input" name="psname" value="<%if(psname!=null)out.print(psname); %>"  maxlength="60"></td>
      </tr>
      <tr>
        <td align="right">&nbsp;*&nbsp;演出场馆:</td>
        <td > 
			<select name="venues" onchange="f_onchange_venues();" >
			<option value="0">--请选择演出场馆--</option>
		<%
			Enumeration e = Node.find(" and community="+DbAdapter.cite(teasession._strCommunity)+" and type = 92 and hidden = 0 ",0,Integer.MAX_VALUE);
			while(e.hasMoreElements())
			{
				int nid = ((Integer)e.nextElement()).intValue();
				Node nobj = Node.find(nid);
				out.print("<option value="+nid);
				if(venues == nid)
				{
					out.print(" selected ");
				}
				out.print(">"+nobj.getSubject(teasession._nLanguage));
				out.print("</option>");
			}
		 %>
		</select>&nbsp;<img src="/tea/image/other/img-globe.gif" title="点击选择演出场馆信息" style="cursor:pointer" onclick="f_venues();">
       </td>
      </tr>      
      <tr>
        <td align="right">票价模板:</td>
        <td >
        <span id="showchevalue">
        <select name="chevalue">
        <option value="0">--选择票价场次--</option>
        	<%
        	/*
        	Enumeration esEnumeration = PerformStreak.find(teasession._strCommunity," and psid!="+psid+" and community ="+DbAdapter.cite(teasession._strCommunity)+" and node = "+teasession._nNode,0,Integer.MAX_VALUE);
        	while(esEnumeration.hasMoreElements())
        	{
        		int psid2 = ((Integer)esEnumeration.nextElement()).intValue();
        		PerformStreak psobj2 = PerformStreak.find(psid2);
        		out.print("<option value="+psid2);
        		if(chevalue==psid2)
        		{
        			out.print(" selected ");
        		}  
        		out.print(">"+psobj2.getPsname());
        		out.print("</option>");
        	} 
        	*/ 
        	%>
        	</select>
        	</span>
        	&nbsp;请选择其他场次做为本次设置的模板&nbsp;    
        </td>
      </tr>
      <tr>
        <td align="right">演出时间:</td>
        <td ><%=new tea.htmlx.TimeSelection("pftime",pftime,true,true)%></td>
      </tr>
      <tr>
        <td align="right">开始出票时间:</td>
        <td ><%=new tea.htmlx.TimeSelection("stardrawtime",stardrawtime,true,true)%></td>
      </tr>
      <tr>
        <td align="right">结束出票时间:</td>
        <td ><%=new tea.htmlx.TimeSelection("enddrawtime",enddrawtime,true,true)%></td>
      </tr>
      <tr>
        <td align="right">结束退票时间:</td>
        <td ><%=new tea.htmlx.TimeSelection("endbouncetime",endbouncetime,true,true)%></td>
      </tr>
      <tr>
        <td align="right">网上订票开始:</td>
        <td ><%=new tea.htmlx.TimeSelection("startonlinetime",startonlinetime,true,true)%></td>
      </tr>
      <tr>
        <td align="right">网上订票结束:</td>
        <td ><%=new tea.htmlx.TimeSelection("endonlinetime",endonlinetime,true,true)%></td>
      </tr>
  </table>
  <br>
  <INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="添加场次">&nbsp;
  <input type="button" value="关闭"  onClick="javascript:window.close();">

  </form>


  <div id="head6"><img height="6" src="about:blank"></div>

 

</body>
</html>

