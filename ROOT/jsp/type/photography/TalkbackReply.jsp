<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.db.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLConnection"%>
<%
	response.setHeader("Expires", "0");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");

	TeaSession teasession = new TeaSession(request);
	if (teasession._rv == null) {
		response.sendRedirect("/servlet/StartLogin?node="
				+ teasession._nNode + "&nexturl="
				+ request.getRequestURI() + "?"
				+ request.getQueryString());
		return;
	}


	Resource r = new Resource("/tea/ui/node/talkback/Talkbacks");

	String menuid = request.getParameter("id");

	int tkid = 0;
	if(teasession.getParameter("tkid")!=null && teasession.getParameter("tkid").length()>0){
		tkid = Integer.parseInt(teasession.getParameter("tkid"));
	}

	Talkback tkobj = Talkback.find(tkid);
	String nexturl = "/jsp/type/photography/TalkbackReply.jsp?tkid="+tkid;
	StringBuilder sql = new StringBuilder();
	StringBuilder param = new StringBuilder();

	sql.append(" AND talkback="+tkid);
	param.append("?id=").append(menuid);
	param.append("&tkid=").append(tkid);

	//回复内容
	 String talkbackreplytext=request.getParameter("talkbackreplytext");
	 if(talkbackreplytext!=null&&talkbackreplytext.length()>0)
	 {
		 talkbackreplytext =talkbackreplytext.trim();
		 sql.append(" AND  text LIKE ").append(DbAdapter.cite("%"+talkbackreplytext+"%"));
		 param.append("&talkbackreplytext=").append(java.net.URLEncoder.encode(talkbackreplytext,"UTF-8"));
	 }

	//回复人员
	 String member=request.getParameter("member");
	 if(member!=null&&member.length()>0)
	 {
		 member =member.trim();
		 sql.append(" AND  member in (select member from ProfileLayer where firstname LIKE  "+DbAdapter.cite("%"+member+"%")+") ");
		 param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
	 }


	 //状态
	 int hidden = -1;
	 if(request.getParameter("hidden")!=null && request.getParameter("hidden").length()>0){
		 hidden = Integer.parseInt(request.getParameter("hidden"));
	 }
	 if(hidden>=0){
		 sql.append(" AND hidden =").append(hidden);
		 param.append("&hidden=").append(hidden);
	 }
	//请求时间
	String time_c = teasession.getParameter("time_c");
	if(time_c!=null && time_c.length()>0)
	{
	  sql.append(" AND time >=").append(DbAdapter.cite(time_c+" 00:00 "));
	  param.append("&time_c=").append(time_c);
	}
	String time_d = teasession.getParameter("time_d");
	if(time_d!=null && time_d.length()>0)
	{
	  sql.append(" AND time <=").append(DbAdapter.cite(time_d+" 23:59"));
	  param.append("&time_d=").append(time_d);
	}



	int pos = 0, size = 10, count = 0;
	count = TalkbackReply.count(sql.toString());

	String o=request.getParameter("o");
	if(o==null)
	{
	  o="talkbackreply";
	}
	boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
	sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
	param.append("&o=").append(o).append("&aq=").append(aq);

	if (request.getParameter("pos") != null) {
		pos = Integer.parseInt(request.getParameter("pos"));
	}


	//sql.append(" ORDER BY talkback DESC");
%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script type="text/javascript">

function CheckAll()
{
	var checkname=document.getElementsByName("checkall");
	var fname=document.getElementsByName("tr_check");
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
//删除
function f_delete()
{
  if(submitCheckbox(form1.tr_check,"<%=r.getString(teasession._nLanguage, "请选择一条记录")%>"))
  {
		if(confirm('您确定要删除选中记录吗？'))
		{

			form1.action='/servlet/EditTalkbackReply';
			form1.act.value='delete';
			form1.nexturl.value=location.pathname+location.search;
    		form1.submit();
		}
  }
}
function f_audit()
{
  if(submitCheckbox(form1.tr_check,"<%=r.getString(teasession._nLanguage, "请选择一条记录")%>"))
  {
		if(confirm('您确定要审核选中记录吗？'))
		{
			form1.action='/servlet/EditTalkbackReply';
			form1.act.value='audit';
			form1.nexturl.value=location.pathname+location.search;
    		form1.submit();
		}
  }
}
function f_cancel_audit()
{
  if(submitCheckbox(form1.tr_check,"<%=r.getString(teasession._nLanguage, "请选择一条记录")%>"))
  {
		if(confirm('您确定要还原选中记录吗？'))
		{

			form1.action='/servlet/EditTalkbackReply';
			form1.act.value='cancel_audit';
			form1.nexturl.value=location.pathname+location.search;
    		form1.submit();
		}
  }
}
function f_refusal()
{
	if(submitCheckbox(form1.tr_check,"<%=r.getString(teasession._nLanguage, "请选择一条记录")%>"))
  {
		if(confirm('您确定要拒绝选中记录吗？'))
		{
			form1.action='/servlet/EditTalkbackReply';
			form1.act.value='refusal';
			form1.nexturl.value=location.pathname+location.search;
    		form1.submit();
		}
  }
}
function f_excel()
{
	if(confirm("您确定要导出数据吗?"))
    {
		form1.action='/servlet/EditExcel';
		form1.act.value='TalkbackReply';
		form1.submit();
	}
}
function f_submit()
{
	form1.action='?';
	form1.submit();
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
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "评论回复管理")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>


<h2><%=r.getString(teasession._nLanguage, "查询")%></h2>

<form name="form1" action="?" >
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="id" value="<%=menuid%>">
<input type="hidden" name="files" value="评论回复列表"/>
<input type="hidden" name="sql" value="<%=sql.toString() %>"/>

<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="nexturl" >
<input type="hidden" name="act" >
<input type="hidden" name="tkid" value="<%=tkid %>"/>



<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="right">回复内容 ：</td>
  <td><input type="text" name="talkbackreplytext" value="<%=TalkbackReply.getNULL(talkbackreplytext)%>"/></td>

   <td align="right">回复人员 ：</td>
  <td><input type="text" name="member" value="<%=TalkbackReply.getNULL(member) %>"/></td>

 </tr>
 <tr>

		  <td align="right">回复时间：</td>
	<td>
	 从&nbsp;
	        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
	        &nbsp;到&nbsp;
	        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />

	</td>
	   	<td align="right">状态：</td>
	   	<td>
		   	<select name="hidden">
		   		<option value="-1">--状态--</option>
		   		<%
		   			for(int i=0;i<Talkback.HIDDEN_TYPE.length;i++){
		   				out.print("<option value = "+i);
		   				if(hidden == i){
		   					out.print(" selected ");
		   				}
		   				out.print(">"+Talkback.HIDDEN_TYPE[i]);
		   				out.print("</option>");
		   			}
		   		%>

		   	</select>
	   	</td>
	   	<td><input type="button" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onclick="f_submit();"></td>
</tr>

</table>


<h2>
<%=r.getString(teasession._nLanguage, "列表")%>&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;条回复&nbsp;)&nbsp;

</h2>
<h2><input type ="button" value="　审核　" onclick="f_audit();">&nbsp;
<input type ="button" value="　拒绝　" onclick="f_refusal();">&nbsp;
<input type ="button" value="　还原　" onclick="f_cancel_audit();">&nbsp;
<input type ="button" value="批量删除" onclick="f_delete();">&nbsp;
<input type="button" value="导出EXCEL" onclick="f_excel();">&nbsp;
<input type="button" value="　返回　" onclick="window.open('/jsp/type/photography/TalkbackList.jsp','_self');"></h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
    <td nowrap>序号</td>
    <td nowrap><%=r.getString(teasession._nLanguage, "回复内容")%></td>
   <td nowrap>
     <a href="javascript:f_order('member');"><%=r.getString(teasession._nLanguage, "回复人员")%></a>
           <%
          if(o.equals("member"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
    </td>
    <td nowrap>
     <a href="javascript:f_order('time');"><%=r.getString(teasession._nLanguage, "回复时间")%></a>
           <%
          if(o.equals("time"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
    </td>
    <td nowrap>
     <a href="javascript:f_order('auditmember');"><%=r.getString(teasession._nLanguage, "处理人员")%></a>
           <%
          if(o.equals("auditmember"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
    </td>
    <td nowrap>
     <a href="javascript:f_order('audittime');"><%=r.getString(teasession._nLanguage, "处理时间")%></a>
           <%
          if(o.equals("audittime"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
    </td>
    <td nowrap>
    <a href="javascript:f_order('hidden');"><%=r.getString(teasession._nLanguage, "状态")%></a>
           <%
          if(o.equals("hidden"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
    </td>

    <td nowrap><%=r.getString(teasession._nLanguage, "操作")%></td>
  </tr>
<%


	Enumeration e = TalkbackReply.find(sql.toString(), pos, size);
	if (!e.hasMoreElements()) {
		out.print("<tr><td colspan='20' align='center'>暂无记录</td></tr>");
	}
	for (int i = 1; e.hasMoreElements(); i++) {
		int trid = ((Integer) e.nextElement()).intValue();
		TalkbackReply obj = TalkbackReply.find(trid);
		String trtext=obj.getText();
		tea.entity.member.Profile pobj = tea.entity.member.Profile.find(obj.getMember());
    	String pname = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
		String cname = obj.getMember();
		if(pname!=null && pname.length()>0){
			cname = pname;
		}

%>

	   <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
		   <td width=1><input type=checkbox name=tr_check value="<%=trid%>" style="cursor:pointer">
		   <td><%=i+pos%></td>
		    <td>
			    <%
			    	if(trtext!=null && trtext.length()>0){
			    		trtext=Report.getHtml2(trtext);
			    		if(trtext.length()>25){
			    			out.print("<textarea style=display:none id=content_"+trid+" >"+trtext+"</textarea><a href=\"javascript:var obj=window.open('','','height=250,width=500,left=400,top=300,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');obj.document.write(document.getElementById('content_"+trid+"').value);\" >"+trtext.replaceAll("&nbsp;","").substring(0,25)+"...</a>");//&#39;
			    		}else{
			    			out.print(trtext);
			    		}
			    	}
			    %>
		    </td>
		    <td><%if(obj.getMember()!=null&&obj.getMember().length()==32){out.print("游客");}else{out.print(cname);}%></td>
		    <td><%=obj.sdf2.format(obj.getTime()) %></td>
		    <td><%=obj.getNULL(obj.getAuditmember()) %></td>
		    <td><%if(obj.getAudittime()!=null){out.print(obj.sdf2.format(obj.getAudittime()));} %></td>
		    <td><%if(obj.getHidden()==0){out.print("<font color=red>"+obj.HIDDEN_TYPE[obj.getHidden()]+"</font>");}else if(obj.getHidden()==1){out.print("<font color=#00ab00>"+obj.HIDDEN_TYPE[obj.getHidden()]+"</fonr>");}else{out.print(obj.HIDDEN_TYPE[obj.getHidden()]);} %></td>

		    <td>
		    <%if(obj.getHidden()==0){out.print("<a href=\"/jsp/type/photography/EditTalkbackReply.jsp?act=audit&trid="+trid+"&tkid="+obj.getTalkback()+"&nexturl="+URLEncoder.encode(nexturl,"UTF-8")+"\">审核</a>");} %>&nbsp;
		    <%out.print("<a href=\"/jsp/type/photography/EditTalkbackReply.jsp?act=edit&trid="+trid+"&tkid="+obj.getTalkback()+"&nexturl="+URLEncoder.encode(nexturl,"UTF-8")+"\">编辑</a>"); %>
		   </td>
		</tr>
    <%
    	}
    %>

<%
     	if (count > size) {
     %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+ param.toString() + "&pos=", pos, count, size)%>    </td> </tr>
<%
	}
%>


</table>

</form>

<div id="head6"><img height="6" src="about:blank" alt=""></div>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>
