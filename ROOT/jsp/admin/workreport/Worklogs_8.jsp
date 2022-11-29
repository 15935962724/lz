<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.admin.sales.*"%>
<%@page import="java.util.*"%>

<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

       ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Date timek = null, timej = null;
  if (teasession.getParameter("timek") != null && teasession.getParameter("timek").length() > 0)
    timek = Task.sdf.parse(teasession.getParameter("timek"));
  if (teasession.getParameter("timej") != null && teasession.getParameter("timej").length() > 0)
    timej = Task.sdf.parse(teasession.getParameter("timej"));
  int fettles = 0;
  if (teasession.getParameter("fettles") != null && teasession.getParameter("fettles").length() > 0)
    fettles = Integer.parseInt(teasession.getParameter("fettles"));


StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer();

String menu_id=(request.getParameter("id"));


int workproject=0;
String _strWorkproject=request.getParameter("workproject");

if(_strWorkproject!=null&&_strWorkproject.length()>0)
{
  workproject=Integer.parseInt(_strWorkproject);
  sql.append(" AND workproject=").append(workproject);
  param.append("&workproject=").append(workproject);
}

String worklinkman=request.getParameter("worklinkman");
if(worklinkman!=null&&worklinkman.length()>0)
{
  sql.append(" AND worklinkman=").append(DbAdapter.cite(worklinkman));
  param.append("&worklinkman=").append(worklinkman);
}

int worktype=0;
String _strWorktype=request.getParameter("worktype");
if(_strWorktype!=null&&_strWorktype.length()>0)
{
  worktype=Integer.parseInt(_strWorktype);
  sql.append(" AND worktype=").append(worktype);
  param.append("&worktype=").append(worktype);
}


DbAdapter db = new DbAdapter();
try {

  String time_s=request.getParameter("time_s");
  if(time_s!=null&&(time_s=time_s.trim()).length()>0)
  {
    try
    {
      java.util.Date time=Worklog.sdf.parse(time_s);
      sql.append(" AND time >=").append(db.cite(time));
      param.append("&time_s=").append(java.net.URLEncoder.encode(time_s,"UTF-8"));
    }catch(java.text.ParseException pe)
    {}
  }
  String time_e=request.getParameter("time_e");
  if(time_e!=null&&(time_e=time_e.trim()).length()>0)
  {
    try
    {
      java.util.Date time=Worklog.sdf.parse(time_e);
      sql.append(" AND time <").append(db.cite(time));
      param.append("&time_e=").append(java.net.URLEncoder.encode(time_e,"UTF-8"));
    }catch(java.text.ParseException pe)
    {}
  }
}
catch (Exception ex) {
  ex.printStackTrace();
}
finally{
  db.close();
}
String content=request.getParameter("content");
if(content!=null&&(content=content.trim()).length()>0)
{
  sql.append(" AND content LIKE ").append(DbAdapter.cite("%"+content+"%"));
  param.append("&content=").append(java.net.URLEncoder.encode(content,"UTF-8"));
}


int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

int count= 0 ;//Worklog.count(community,sql.toString());

param.append("&pos=").append(pos);

String order=request.getParameter("order");
if(order==null)
order="time";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);
sql.append(" ORDER BY ").append(order).append(" ").append(desc);

String nexturl=request.getRequestURI()+"?"+request.getQueryString();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function fload()
{
  var tr_today=document.all('tr_today');
  if(tr_today==null)
  {
    document.getElementById('tr_today_select').style.display='none';
  }else
  {
    if(!tr_today.length)
    {
      tr_today.parentElement.moveRow(tr_today.rowIndex,1);
    }else
    {
      for(var i=0;i<tr_today.length;i++)
      {
        var obj=tr_today[i];
        obj.parentElement.moveRow(obj.rowIndex,1);
      }
    }
  }
}
function submitCheck()
{
    if(form2.worklog.checked)
        return true;
	for(var i=0;i<form2.worklog.length;i++)
	{
		if(form2.worklog[i].checked)
			return true;
	}
	alert('无效选择');
	return false;
}
</script>
</head>
<body onload="fload();">
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="action" value="exportworklogs"/>
<h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr id="tableonetr">
    <td nowrap>时间/沟通人</td>
    <td nowrap>标题</td>
    <td nowrap>内容</td>
    <td nowrap>下一步工作</td>
  </tr>

<%

  int workproject1 = Integer.parseInt(request.getParameter("workproject"));

  String sql1 = " and clientname = '"+ workproject1 + "'" ;
  java.util.Enumeration lame = Saleschance.findByCommunity(teasession._strCommunity, sql1);

  if(lame.hasMoreElements()){
    while (lame.hasMoreElements()) {
      int laid = ((Integer) lame.nextElement()).intValue();
      Saleschance tsdbj = Saleschance.find(laid);
      String name;
      String ming;
      if (tsdbj.getClienttype()) {
        name = Workproject.find(tsdbj.getClientname()).getName(teasession._nLanguage);
        ming = Workproject.find(tsdbj.getClientname()).getName(teasession._nLanguage);
        count += 1;
      }
      else {
        name = Latency.find(tsdbj.getClientname()).getFamily();
        ming = Latency.find(tsdbj.getClientname()).getFirsts();
      }
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td nowrap><%=tsdbj.getDates()%>/<%=tsdbj.getbschanceholder() %></td>
        <td nowrap><%=tsdbj.getbscname()%></td>
        <td nowrap><%=tsdbj.getRemark()%></td>
        <td nowrap><%=tsdbj.getNexts() %></td>
      </tr>
      <%}
      }
      else{
         out.print("<tr><td colspan=10 align=center><font color=red>暂无记录</font></td></tr>");
     }
     if(count>20){
       %>
       <tr>
         <td colspan="7" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,20)%>    </td>
       </tr><%} %>
  <input type="hidden" name="sql" value="<%=sql1%>">
  <input type="hidden" name="files" value="saleschance">

</table>

<br>
<%--   <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>



