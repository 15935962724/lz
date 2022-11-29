<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page import="tea.entity.admin.office.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer(" and examinetype=1 and sealtype=0");



int cachet=0;
if(request.getParameter("cachet")!=null && request.getParameter("cachet").length()>0)
   cachet = Integer.parseInt(request.getParameter("cachet"));
if(cachet!=0)
{
  sql.append(" AND cachet="+cachet);
  param.append("&cachet="+(cachet));
}

String time_k=request.getParameter("time_k");
if(time_k!=null&&(time_k=time_k.trim()).length()>0)
{
  sql.append(" AND usetime >=" +DbAdapter.cite(time_k));
  param.append("&time_k="+java.net.URLEncoder.encode(time_k,"UTF-8"));
}

String time_j=request.getParameter("time_j");
if(time_j!=null&&(time_j=time_j.trim()).length()>0)
{
  sql.append(" AND usetime <=" +DbAdapter.cite(time_j));
  param.append("&time_j="+java.net.URLEncoder.encode(time_j,"UTF-8"));
}


String _strId=request.getParameter("id");



int count=Sealapply.count(teasession._strCommunity,sql.toString());
int size=10;
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

String order=request.getParameter("order");
if(order==null)
order="times";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
//param.append("&desc=").append(desc);

//sql.append(" ORDER BY ").append(order).append(" ").append(desc);
String o=request.getParameter("o");
if(o==null)
{
  o="sealapply";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
param.append("&o=").append(o).append("&aq=").append(aq);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

</head>
<script>

	function editimd(type,igd)
	{
	  if(confirm('您确定要执行此操作吗？'))
	  {
            form1.sealapply.value=igd;
            form1.act.value='stamp';
            form1.sealtype.value=type;
            form1.action='/servlet/EditSealapply';
            form1.submit();
          }
	}


        function f_order(v)
        {
          var aq=form1.aq.value=="true";
          if(form1.o.value==v)
          {
            form1.aq.value=!aq;
          }else
          {
            form1.o.value=v;
          }
          form1.action="?";
          form1.submit();
        }

</script>
<body>

<h1>盖章审核</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>查询</h2>
<form name=form1 METHOD=get action="?">

  <input type="hidden" name="sealapply" />
  <input type=hidden name="act"/>
  <input type="hidden" name="sealtype"/>
  <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>"/>
  <input type="hidden" name="o" VALUE="<%=o%>">
  <input type="hidden" name="aq" VALUE="<%=aq%>">
        <input type="hidden" name="id" value="<%=request.getParameter("id")%>">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>名称
    <select name="cachet">
    <option value="">-------</option>
   	<%
                java.util.Enumeration ce = Cachet.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
   		while(ce.hasMoreElements())
   		{
   			int ceid = ((Integer)ce.nextElement()).intValue();
   			Cachet caobj = Cachet.find(ceid);

   			out.print("<option value="+ceid);
                        if(cachet==ceid)
                            out.print(" selected");
   			out.print(">"+caobj.getName()+caobj.getType());
   			out.print("</option>");
   		}
  	%>

    </select>

    </td>
    <td>使用时间
		<input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"><A href="###"><img onClick="showCalendar('form1.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
		-<input name="time_j" size="7"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onClick="showCalendar('form1.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
	</td>
      <td><input type="submit" value="查询"/></td>
  </tr>
</table>


<h2>列表</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
  <td nowrap>序号</td>
     <td nowrap><a href="javascript:f_order('cachet');">印章名称</a> <%
          if(o.equals("cachet"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
    <td nowrap ><a href="javascript:f_order('usetime');">使用时间</a> <%
          if(o.equals("usetime"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
    <td nowrap><a href="javascript:f_order('usecausation');">事由</a> <%
          if(o.equals("usecausation"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>

    <td nowrap="nowrap"><a href="javascript:f_order('member');">申请人</a> <%
          if(o.equals("member"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
     <td nowrap="nowrap"><a href="javascript:f_order('auditingmember');">批准人</a> <%
          if(o.equals("auditingmember"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
    <td>操作</td>
  </tr>

   <%
   int index =pos+1;
        java.util.Enumeration e = Sealapply.find(teasession._strCommunity,sql.toString(),pos,size);
        if(!e.hasMoreElements())
        {
          out.print("<tr><td colspan=8 align=center>暂无记录</td></tr>");
        }
        while(e.hasMoreElements())
        {
           int said = ((Integer)e.nextElement()).intValue();
             Sealapply saobj = Sealapply.find(said);
             Cachet caobj = Cachet.find(saobj.getCachet());
             Profile pobj = Profile.find(saobj.getMember());
              Profile pobj2 = Profile.find(saobj.getAuditingmember());
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td align="center"><%=index%></td>
         <td nowrap><%=caobj.getName()+caobj.getType()%></td>
         <td align="center" nowrap><%=saobj.getUsetimeToString()%></td>
         <td align="center" nowrap><%=saobj.getUsecausation()%></td>
           <td align="center" nowrap><%=pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage) %></td>
         <td align="center" nowrap><%=pobj2.getLastName(teasession._nLanguage)+pobj2.getFirstName(teasession._nLanguage) %></td>
        <td align="center" nowrap>
          <input type=button value="<%=r.getString(teasession._nLanguage,"盖章")%>"  onClick="editimd('1','<%=said%>');">
      </td>
 </tr>
<%
index++;
        }if(count>size){
        %>
        <tr>
          <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td>
        </tr><%
        }
         %>
</table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
