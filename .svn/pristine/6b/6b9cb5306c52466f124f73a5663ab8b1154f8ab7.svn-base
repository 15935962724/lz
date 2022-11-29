<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>

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

StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer();
//sql.append(" AND member=").append(DbAdapter.cite(teasession._rv._strV));
sql.append(" AND problemreport=1");

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

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

int count= 0;//Worklog.count(community,sql.toString());
count = Worklog.count(community," AND workproject="+workproject +" and problemreport="+1);
//out.print(sql.toString());
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
    //document.getElementById('tr_today_select').style.display='none';
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
<form name=form2 METHOD=get action="/jsp/admin/workreport/SendWorklog.jsp" >
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="action" value="exportworklogs"/>

<h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"></td>
     <td nowrap><!--时间--><%out.print(r.getString(teasession._nLanguage,"时间/提问人"));%></td>
     <td nowrap><%out.print(r.getString(teasession._nLanguage,"Text"));%></td>
     <td nowrap><%out.print(r.getString(teasession._nLanguage,"回复"));%></td>
     </tr>

     <%
     StringBuffer html=new StringBuffer();
     String date_cu=Worklog.sdf.format(new java.util.Date());
     java.util.Enumeration enumer=Worklog.find(community,sql.toString(),pos,30);
     if(enumer.hasMoreElements()){
       int j=1;
       for(int index=1;enumer.hasMoreElements();index++)
       {

         int worklog=((Integer)enumer.nextElement()).intValue();
         Worklog obj=Worklog.find(worklog);
           html.append("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" ");
           html.append("<td></td><td nowrap>&nbsp;"+j+"</td>");
           html.append("<td nowrap>&nbsp;"+obj.getTimeToString()+"/"+ obj.getMember() +"</td>");

           html.append("<td>&nbsp;");
           String log_content=obj.getContent(teasession._nLanguage).replaceAll("</","&lt;/");
           if(log_content.length()>25)
           html.append("<textarea style=display:none id=content_"+worklog+" >"+log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")+"</textarea>"+log_content);//&#39;
           else
           html.append(log_content);
           html.append("</td>");
           html.append("<td><input type=button value="+r.getString(teasession._nLanguage,"问题回复")+" onClick=\"window.open('/jsp/admin/workreport/Worklogs_7revert.jsp?community="+teasession._strCommunity+"&nexturl="+nexturl+"&worklog="+worklog+"','_blank');\"></td></tr>");
           j++;
       }
       out.print(html.toString());
     }
     else{
       out.print("<tr><td colspan=10 align=center><font color=red>暂无记录</font></td></tr>");
     }
     if(count>20){
       %>
       <tr>
         <td colspan="7" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,20)%>    </td>
       </tr><%} %>
</table>
</form>
<br>
<%--   <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>


