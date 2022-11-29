<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
 
Node node = Node.find(teasession._nNode);


if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(94))
{
  response.sendError(403);
  return; 
}


Resource r=new Resource("/tea/resource/Photography");
String nexturl = request.getRequestURL() + "?node="+teasession._nNode + request.getContextPath();


StringBuffer sql = new StringBuffer(" and n.audit=1 and n.path like "+DbAdapter.cite("%/"+teasession._nNode+"/%")+" and n.type = 94 ");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
param.append("&node=").append(teasession._nNode);

// 作品名称
String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0){
	subject = subject.trim();
	sql.append(" AND nl.subject like ").append(DbAdapter.cite("%"+subject+"%"));
	param.append("&subject=").append(URLEncoder.encode(subject,"UTF-8"));
}
//作者
String byname = teasession.getParameter("byname");
if(byname!=null && byname.length()>0){
	byname = byname.trim();
	sql.append(" AND  pl.byname like ").append(DbAdapter.cite("%"+byname+"%"));
	param.append("&byname=").append(URLEncoder.encode(byname,"UTF-8"));
}

//类型
int categories = -1;
if(teasession.getParameter("categories")!=null && teasession.getParameter("categories").length()>0){
	categories = Integer.parseInt(teasession.getParameter("categories"));
}
if(categories>=0){
	
	sql.append(" AND  p.categories ="+categories);
	param.append("&categories=").append(categories);
}

//上传时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND n.time >=").append(DbAdapter.cite(time_c+" 00:00 "));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND n.time <=").append(DbAdapter.cite(time_d+" 23:59"));
  param.append("&time_d=").append(time_d);
}



int pos = 0, pageSize = 15, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count = Node.countPhotography(teasession._strCommunity,sql.toString());

String o=request.getParameter("o");
if(o==null)
{
  o="n.time";
}

boolean aq=Boolean.parseBoolean(request.getParameter("aq"));

sql.append(" group by n.node , ").append(o);
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"ASC":"DESC");


param.append("&o=").append(o).append("&aq=").append(aq);

//sql.append(" order by time desc ");




 
%>

<html>
<head>
<title>投票统计</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">

function CheckAll()
{
	var checkname=document.getElementsByName("checkall");   
	var fname=document.getElementsByName("nid");
	var lname=""; 
	if(checkname[0].checked){
	    for(var i=0; i<fname.length; i++){ 
	      fname[i].checked=true; 
	}   
	}else{
	   for(var i=0; i<fname.length; i++){ 
	      fname[i].checked=false; 
	   } 
	}
}





function f_excel()
		{
			if(confirm("您确定要导出数据吗?"))
		    {
				form1.action='/servlet/EditExcel';
				form1.act.value='Photography';
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
function f_a()
{
	form1.action ="?";
	form1.submit();
}
</script>

<h1>投票统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="POST" >
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>  
<input type="hidden" name="act">
<input type="hidden" name="Photographyact" value="Photography">
<input type="hidden" name="onclick_act">
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<input type="hidden" name="files" value="投票作品统计"/>
<input type="hidden" name="sql" value="<%=sql.toString() %>"/>
<input type="hidden" name="voteact" value="votenumber"/>
<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">

<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td  align="right">作品名称：</td>
		<td><input type="text" name="subject" value="<%=Entity.getNULL(subject) %>"/></td>
		<td  align="right">作者：</td>
		<td><input type="text" name="byname" value="<%=Entity.getNULL(byname) %>"/></td>
		<td align="right">类型</td>
		<td>
		<select name="categories">
			<option value="-1">-类型-</option>
			<%
			
			java.util.Enumeration e_1 = Node.find(" and father = "+teasession._nNode,0,Integer.MAX_VALUE);
					while(e_1.hasMoreElements()){
						int fnid = ((Integer)e_1.nextElement()).intValue();
						Node fobj = Node.find(fnid);
						out.print("<option value="+fnid);
						if(categories == fnid){
							out.print(" selected ");
						}
						out.print(">"+fobj.getSubject(teasession._nLanguage));
						out.print("</option>"); 
					}
			%>
		</select>
		</td>
	</tr>
	<tr>
	<td align="right">上传时间：</td>
	<td>
		从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly" style="cursor:pointer"  onclick="new Calendar().show('form1.time_c');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly" style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
	</td>
	
     <td><input type="submit" value="查询" onclick="f_a();"></td>
	</tr> 
 </table>
 <%
 	if((subject!=null&&subject.length()>0) || (byname!=null&&byname.length()>0) || categories!=-1 || (time_c!=null&&time_c.length()>0) || (time_d!=null&&time_d.length()>0)){
 		out.print("<h2>");
 		out.println("您查询条件是：");
 		if(subject!=null&&subject.length()>0){
 			out.print("作品名称：<font color=\"#000000\" size=\"3\">"+subject+"</font>");
 		}
 		out.print("&nbsp;");
 		if(byname!=null&&byname.length()>0){
 			out.print("作者：<font color=\"#000000\" size=\"3\">"+byname+"</font>");
 		}
 		out.print("&nbsp;");
 		if(categories>=0){
 			out.print("类型：<font color=\"#000000\" size=\"3\">"+Node.find(categories).getSubject(teasession._nLanguage)+"</font>");
 		}
 		out.print("&nbsp;");
 		if(time_c!=null&&time_c.length()>0){
 			out.print("开始时间：<font color=\"#000000\" size=\"3\">"+time_c+"</font>");
 		}
 		out.print("&nbsp;");
 		if(time_d!=null&&time_d.length()>0){
 			out.print("截止时间：<font color=\"#000000\" size=\"3\">"+time_d+"</font>");
 		}
 		
 		out.print("</h2>");
 		
 	}
 %>
<h2>投票作品列表&nbsp;(&nbsp;目前的总票数是&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;)&nbsp;<input type="button" value="导出EXCEL" onclick="f_excel();"></h2>

 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
	       <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
	       <td nowrap>序号</td>
	      <td nowrap> <a href="javascript:f_order('nl.subject');">作品名称</a>
	       <%
	          if(o.equals("nl.subject"))
	          {
	            if(aq)
	            out.print("↓");
	            else
	            out.print("↑");
	          }
          %>
	      </td>
	      <td nowrap>缩略图</td>
	       <td nowrap><a href="javascript:f_order('pl.byname');">作者</a>
	        <%
          if(o.equals("pl.byname"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
	       </td>
	       <td nowrap><a href="javascript:f_order('p.categories');">类型</a>
	         <%
          if(o.equals("p.categories"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
	       </td>
	       <td nowrap><a href="javascript:f_order('n.time');">上传时间</a>
	        <%
          if(o.equals("n.time"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
	       </td>
	       <td nowrap>投票图示 </td>
	       <td nowrap><a href="javascript:f_order('p.votenumber');">票数</a>
	        <%
          if(o.equals("p.votenumber"))
          {
            if(aq)
            out.print("↓"); 
            else
            out.print("↑");
          }
          %>
	       </td>
	  
    </tr>
    
    <%
    Enumeration e = Node.findPhotography_np(teasession._strCommunity, o,sql.toString(),pos,pageSize);
	    if (!e.hasMoreElements()) {
			out.print("<tr><td colspan='20' align='center'>暂无记录</td></tr>");
		}
    	for(int i=1;e.hasMoreElements();i++)
    	{
    		int nid = ((Integer)e.nextElement()).intValue();
    		Node nobj = Node.find(nid);
    		Photography pobj =  Photography.find(nid);

    		Profile pfobj = Profile.find(nobj.getCreator().toString());
    	
    %>
    
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
   <td width=1><input type=checkbox name=nid value="<%=nid%>" style="cursor:pointer"></td>
    <td><%=i+pos%></td>
    <td><%=Node.getNULL(nobj.getSubject(teasession._nLanguage)) %></td>
    <td><img width="30" src="<%=pobj.getAbbpicpath(teasession._nLanguage) %>"/></td>
    <td><%=Node.getNULL(pobj.getByname(teasession._nLanguage))%></td>
      <td><%=Node.find(nobj.getFather()).getSubject(teasession._nLanguage) %></td>
   <td><%=Entity.sdf2.format(nobj.getTime()) %></td>
   <td>
	   <div style="width:100%;height:5px;border:1px solid #333;">
	   	    <div style="width:<%=Photography.getPicicon(teasession._strCommunity,pobj.getVotenumber()) %>;background:#333;height:5px"></div>
	   </div>
   </td> 
   <td><%=pobj.getVotenumber() %></td>
   

   
    </tr>
<%} %>
     <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
