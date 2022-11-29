<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}


String nexturl = request.getRequestURI()+"?"+request.getQueryString();
StringBuffer sql = new StringBuffer(" and type = 55 and hidden = 0 and community= "+DbAdapter.cite(teasession._strCommunity));
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);

String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  subject = subject.trim();
  sql.append(" AND node in (SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  param.append("&subject = ").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}
int venues = 0;
if(teasession.getParameter("venues")!=null)
{
	venues = Integer.parseInt(teasession.getParameter("venues"));
}
if(venues>0)
{
	sql.append(" AND node in (SELECT node FROM PerformStreak WHERE  venues = "+venues+") ");
	param.append("&venues=").append(venues);
}


String time_c =teasession.getParameter("time_c");
String time_d=teasession.getParameter("time_d");

if(time_c!=null && time_c.length()>0)
{
	sql.append(" AND node in ( SELECT node FROM  PerformStreak WHERE pftime >= "+DbAdapter.cite(time_c)+" ");
	if(time_d!=null && time_d.length()>0)
	{
		sql.append(" AND pftime <= "+DbAdapter.cite(time_d)+" ");
		param.append("&time_d=").append(time_d);
	}
	sql.append(" ) ");
	param.append("&time_c=").append(time_c);
}else if(time_d!=null && time_d.length()>0)
{
	sql.append(" AND node in (SELECT node FROM PerformStreak WHERE pftime  <="+DbAdapter.cite(time_d)+" ) ");
	param.append("&time_d=").append(time_d);
}

int pos = 0, pageSize = 20, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos")); 
}
count = Node.count(sql.toString());

tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);

sql.append(" order by time desc ");


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>演出信息管理</title>
</head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<body id="bodynone"  >
<script>
function f_edit(igd)
{
  form1.node.value=igd;
  form1.action = '/jsp/type/perform/EditPerform.jsp';
  form1.submit();
}
function f_delete(igd,name)
{
  if(confirm('您确定要删除演出【'+name+'】的信息吗?'))
  {
    form1.node.value=igd;
    form1.act.value='delete';
    form1.action = '/servlet/EditPerform';
    form1.submit();
  }
}
//设置座位
function f_seat(igd)
{
  window.open('/jsp/type/venues/Seatindex.jsp?nid='+form1.igd+'&community='+form1.community.value,'Seatindex','width=900,height=800,scrollbars=1,top=200,left=200');
}

function f_venues()
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:557px;dialogHeight:405px;';
  var url = '/jsp/type/perform/inquiryVenues.jsp';
  var rs = window.showModalDialog(url,self,y);
  if(rs>0)
  {
    form1.venues.value=rs;
    
  }
}

</script>

<h1>演出信息管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <h2>查询</h2>

<form name="form1" action="/jsp/type/perform/Perform.jsp" method="GET">
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="act">
  <input type="hidden" name="node" value="<%=teasession._nNode %>">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >

  <table border="0" cellpadding="0" cellspacing="0" id="tableSearch">
    <tr>
      <td align="right">演出名称:</td>
      <td><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>" size="45"></td>
    <td align="right">演出场馆:</td>
        <td > 
			<select name="venues" >
			<option value="0">--请选择演出场馆--</option>
		<%
			 java.util.Enumeration ve = Node.find(" and community="+DbAdapter.cite(teasession._strCommunity)+" and type = 92 and hidden = 0 ",0,Integer.MAX_VALUE);
			while(ve.hasMoreElements())
			{
				int nid = ((Integer)ve.nextElement()).intValue();
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
		</select>&nbsp;<img src="/tea/image/other/img-globe.gif" title="点击选择演出场馆信息" style="cursor:pointer" onClick="f_venues();">
       </td>
		</tr>
	<tr> 
	<td align="right">演出时间:</td>
	<td>  从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;"   style="cursor:pointer" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;"   style="cursor:pointer" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
</td>
      <td align="center" colspan="2"><input type="submit" value="" class="SearchInput"/></td>
    </tr>
  </table>

  <h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;个演出&nbsp;)</h2>



  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR id="tableonetr">
      <TD nowrap>序号</TD>
      <TD nowrap>演出名称</TD>
      <TD nowrap>演员</TD>
      <TD nowrap>导演</TD>
      <TD nowrap>操作</TD>
    </TR>
    <%
    java.util.Enumeration  e =Node.find(sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无演出信息</td></tr>");
    }

    for(int i =1;e.hasMoreElements();i++)
    {
      int nid =((Integer)e.nextElement()).intValue();
      Node nobj = Node.find(nid);
      Perform pfobj = Perform.find(nid,teasession._nLanguage);

      // hobj.setQuantity(hobj.getQuantity()+1);
      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td width="1"><%=i+pos %></td>
        <td><a href="#" ><%=nobj.getSubject(teasession._nLanguage)%></a></td>
        <td><%=pfobj.getSort() %></td>
        <td><%=pfobj.getDirect() %></td>
        <td>
        <a href="javascript:f_edit('<%=nid%>');">基本信息</a>&nbsp;
        <a href="#" onClick="window.open('/jsp/type/perform/PerformStreak.jsp?community=<%=teasession._strCommunity%>&node=<%=nid%>','_self')">场次设置</a>&nbsp;
        <a href="/jsp/type/venues/GMapPreview.jsp?community=<%=teasession._strCommunity%>&node=<%=nid%>"  target=_blank>售票统计</a>&nbsp;
           <a href="javascript:f_delete('<%=nid%>','<%=nobj.getSubject(teasession._nLanguage)%>');"  >删除</a>&nbsp;

        </td>
      </tr>
      <%} %>
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
<br>
  <input type="button" value="" class="CreateInput" onClick="window.open('/jsp/type/perform/EditPerform.jsp?NewNode=ON&node=<%=teasession.getParameter("node") %>&community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>','_self');"/>
  </form>


  <div id="head6"><img height="6" src="about:blank"></div>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
