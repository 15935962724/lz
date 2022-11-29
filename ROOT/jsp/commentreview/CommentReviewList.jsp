<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.commentreview.CommentReview"%>
<%@page import="tea.entity.pm.PoFamousComment"%>
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

Http h=new Http(request);
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="
  + teasession._nNode + "&nexturl="
  + request.getRequestURI() + "?"
  + request.getQueryString());
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContentType();

Resource r = new Resource("/tea/ui/node/talkback/Talkbacks");

String menuid = request.getParameter("id");

Community c = Community.find(teasession._strCommunity);

StringBuilder sql = new StringBuilder();
StringBuilder param = new StringBuilder();

param.append("?id=").append(menuid);


int type = 0;
if(null!=teasession.getParameter("type")&&!"".equals(teasession.getParameter("type"))){
	type = Integer.parseInt(teasession.getParameter("type"));
}
sql.append(" AND type=").append(type);
param.append("&type=").append(type);

	/*
	//主题
	 String subjectname=request.getParameter("subjectname");
	 if(subjectname!=null&&subjectname.length()>0)
	 {
		 subjectname =subjectname.trim();
		 sql.append(" AND  subject LIKE ").append(DbAdapter.cite("%"+subjectname+"%"));
		 param.append("&subject=").append(java.net.URLEncoder.encode(subjectname,"UTF-8"));
	 }
         */
//姓名
String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name+"%"));
  param.append("&name=").append(Http.enc(name));
}

//国籍
String tmp=request.getParameter("country");
int country=tmp==null||tmp.length()<1?0:Integer.parseInt(tmp);
if(country>0)
{
  sql.append(" AND country=").append(country);
  param.append("&country=").append(country);
}

//地点
String address=request.getParameter("address");
if(address!=null&&(address=address.trim()).length()>0)
{
  sql.append(" AND address LIKE ").append(DbAdapter.cite("%"+address+"%"));
  param.append("&address=").append(java.net.URLEncoder.encode(address,"UTF-8"));
}

//关键字
String content=request.getParameter("content");
if(content!=null&&content.length()>0)
{
  content =content.trim();
  sql.append(" AND  content LIKE ").append(DbAdapter.cite("%"+content+"%"));
  param.append("&content=").append(java.net.URLEncoder.encode(content,"UTF-8"));
}

//创建者
String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
	if(type==0)
		sql.append(" AND fkeyid IN(SELECT id FROM FamousComment WHERE member="+DbAdapter.cite(member)+")");
  param.append("&member=").append(Http.enc(member));
}

//作品名 -title
String title=request.getParameter("title");
if(title!=null&&title.length()>0)
{
  title =title.trim();
  sql.append(" AND  fkeyid in ( SELECT id FROM FamousComment WHERE title like "+DbAdapter.cite("%"+title+"%")+")");
  param.append("&title=").append(java.net.URLEncoder.encode(title,"UTF-8"));
}
	 //状态
	 int state = -1;
	 if(request.getParameter("state")!=null && request.getParameter("state").length()>0){
		 state = Integer.parseInt(request.getParameter("state"));
	 }
	 if(state>=0){
		 sql.append(" AND state =").append(state);
		 param.append("&state=").append(state);
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



	int pos = 0, size = 15, count = 0;
	count = CommentReview.count(sql.toString());

	String o=request.getParameter("o");
	if(o==null)
	{
		if(type==0)
			o="commentreview";
	}
	boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
	sql.append(" ORDER BY ").append(o).append(" ").append(aq?"ASC":"DESC");
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
<script src="/tea/mt.js"></script>
<script src="/tea/country.js"></script>
<script type="text/javascript">

function CheckAll()
{
	var checkname=document.getElementsByName("checkall");
	var fname=document.getElementsByName("commentreview");
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
  if(submitCheckbox(form1.commentreview,"<%=r.getString(teasession._nLanguage, "请选择一条记录")%>"))
  {
		if(confirm('您确定要删除选中记录吗？'))
		{
			form1.action='/EditCommentReview.do';
			form1.act.value='delete';
			form1.nexturl.value=location.pathname+location.search;
    		form1.submit();
		}
  }
}
function f_audit()
{
  if(submitCheckbox(form1.commentreview,"<%=r.getString(teasession._nLanguage, "请选择一条记录")%>"))
  {
		if(confirm('您确定要审核选中记录吗？'))
		{
			form1.action='/EditCommentReview.do';
			form1.act.value='audit';
			form1.nexturl.value=location.pathname+location.search;
    		form1.submit();
		}
  }
}
function f_cancel_audit()
{
  if(submitCheckbox(form1.commentreview,"<%=r.getString(teasession._nLanguage, "请选择一条记录")%>"))
  {
		if(confirm('您确定要还原选中记录吗？'))
		{
			form1.action='/EditCommentReview.do';
			form1.act.value='cancel_audit';
			form1.nexturl.value=location.pathname+location.search;
    		form1.submit();
		}
  }
}
function f_refusal()
{
	if(submitCheckbox(form1.commentreview,"<%=r.getString(teasession._nLanguage, "请选择一条记录")%>"))
  {
		if(confirm('您确定要拒绝选中记录吗？'))
		{
			form1.action='/EditCommentReview.do';
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
		form1.action='/EditCommentReview.do';
		form1.act.value='CommentReviewList';
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

<h1><%=r.getString(teasession._nLanguage, "评论管理")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>


<h2><%=r.getString(teasession._nLanguage, "查询")%></h2>

<form name="form1" action="?" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="id" value="<%=menuid%>">
<input type="hidden" name="files" value="评论列表"/>
<input type="hidden" name="sql" value="<%=sql.toString() %>"/>
<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">
 <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
 <input type="hidden" name="act" >
<input type="hidden" name="nexturl" >
<input type="hidden" name="type" value="<%=type%>">



<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="right">作品名：</td>
  <td><input type="text" name="title" value="<%=CommentReview.getNULL(title) %>"/></td>
  <td align="right">关键字：</td>
  <td><input type="text" name="content" value="<%=CommentReview.getNULL(content) %>"/></td>
    <td align="right">状态：</td>
    <td>
      <select name="state">
        <option value="-1">--状态--</option>
        <%
        for(int i=0;i<CommentReview.STATE_TYPE.length;i++){
          out.print("<option value = "+i);
          if(state == i){
            out.print(" selected ");
          }
          out.print(">"+CommentReview.STATE_TYPE[i]);
          out.print("</option>");
        }
        %>

      </select>
    </td>
</tr>
<tr>
  <td align="right">姓名：</td>
  <td><input name="name" value="<%=MT.f(name)%>"/></td>
  <td align="right">国籍：</td>
  <td><script>mt.country('country','<%=country%>',"Nationality");</script></td>
  <td align="right">地点：</td>
  <td><input type="text" name="address" value="<%=CommentReview.getNULL(address)%>"/></td>
</tr>
<tr>

<td align="right">请求时间：</td>
<td>
从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly" style="cursor:pointer"  onclick="new Calendar().show('form1.time_c');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly" style="cursor:pointer" onClick="new Calendar().show('form1.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />

</td>
<td align="right">创建者：</td>
<td><select name="member"><option value="">--</option>
<%
Enumeration e=AdminUsrRole.find(teasession._strCommunity," AND role!='/'",0,1000);
while(e.hasMoreElements())
{
  String str=(String)e.nextElement();
  Profile p = Profile.find(str);
  out.print("<option value="+p.profile);
  if(str.equals(member))out.print(" selected");
  out.print(">"+str);
}
%>
</select></td>

<td><td><input type="button" value="<%=r.getString(teasession._nLanguage, "查询")%>" onClick="f_submit();"></td>
</tr>
<tr>

</tr>
</table>


<h2>
<%=r.getString(teasession._nLanguage, "列表")%>&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;条评论&nbsp;)&nbsp;
</h2>
<h2>
<input type ="button" value="　审核　" onClick="f_audit();">&nbsp;
<input type ="button" value="　拒绝　" onClick="f_refusal();">&nbsp;
<input type ="button" value="　还原　" onClick="f_cancel_audit();">&nbsp;
<input type ="button" value="批量删除" onClick="f_delete();">&nbsp;
<input type="button" value="导出EXCEL" onClick="f_excel();">
</h2>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
    <td nowrap>序号</td>
    <td nowrap><%=r.getString(teasession._nLanguage, "评论内容")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage, "作品名")%></td>
    <td nowrap>创建者</td>
    <td nowrap>姓名</td>
    <td nowrap>
    <a href="javascript:f_order('rmember');"><%=r.getString(teasession._nLanguage, "请求人员")%></a>
           <%
          if(o.equals("rmember"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
    </td>
    <td nowrap>
     <a href="javascript:f_order('time');"><%=r.getString(teasession._nLanguage, "请求时间")%></a>
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
    <a href="javascript:f_order('state');"><%=r.getString(teasession._nLanguage, "状态")%></a>
           <%
          if(o.equals("state"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
    </td>
    <%-- <td nowrap><%=r.getString(teasession._nLanguage, "Revert")%></td> --%>
    <td nowrap><%=r.getString(teasession._nLanguage, "操作")%></td>
  </tr>
<%

e=CommentReview.find(sql.toString(),pos,size);
if(!e.hasMoreElements())
{
  out.print("<tr><td colspan='20' align='center'>暂无记录</td></tr>");
}
for (int i = 1; e.hasMoreElements(); i++)
{
  int crid = ((Integer) e.nextElement()).intValue();
  CommentReview obj = CommentReview.find(crid);
  int fkeyid = obj.getFkeyid();
  String titleVal = "";
  PoFamousComment pfc = new PoFamousComment();
  if(type==0){
  	pfc = PoFamousComment.find(fkeyid);
  	titleVal = pfc.getTitle();
  }
  RV rv = obj.getCreator();
  String subject = obj.getSubject(teasession._nLanguage);
  String creator = rv._strR;
  tea.entity.member.Profile pobj = tea.entity.member.Profile.find(rv._strR);
  String pname = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
  if(pname!=null && pname.length()>0)
  {
    creator = pname;
  }

  if (creator == null)
  creator = "";
  //int contr = TalkbackReply.countByTalkback(crid);

  //Node n=Node.find(nodeid);

%>

	   <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
		   <td width=1><input type=checkbox name=commentreview value="<%=crid%>" style="cursor:pointer">
		   <td nowrap><%=i+pos%></td>
			<td nowrap><%

			String log_content=obj.getContent(teasession._nLanguage);
			  if(log_content!=null)
			  {
			    log_content=Report.getHtml2(log_content);//log_content.replaceAll("<","&lt;");  log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")
			    if(log_content.length()>25){

			        out.print("<textarea style=display:none id=content_"+crid+" >"+log_content+"</textarea><a href=\"javascript:var obj=window.open('','','height=250,width=500,left=400,top=300,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');obj.document.write(document.getElementById('content_"+crid+"').value);\" >"+log_content.replaceAll("&nbsp;","").substring(0,25)+"...</a>");//&#39;
			    }
			    else{
			    out.print(log_content);
			    }
			  }
			%></td><%-- /jsp/type/Consultant/ViewFamousCommentWeb.jsp?pfcid=<%=fkeyid%> --%>
		    <td nowrap><a href="/html/folder/14101875-1.htm?pfcid=<%=fkeyid%>" target="_blank"><%=titleVal%></a></td>
                    <td><%=Profile.find(pfc.getMember()).getName(teasession._nLanguage)%></td>
                    <td><%=obj.getName(h.language)%></td>
		    <td nowrap><%if(creator!=null&&creator.length()==32){out.print("游客");}else{out.print(creator);}%></td>
		    <td nowrap><%=obj.getTimeToString()%></td>
		    <td nowrap><%=obj.getNULL(obj.getAuditmember()) %></td>
		    <td nowrap><%if(obj.getAudittime()!=null){out.print(obj.sdf2.format(obj.getAudittime()));} %></td>
		    <td nowrap><%if(obj.getState()==0){out.print("<font color=red>"+obj.STATE_TYPE[obj.getState()]+"</font>");}else if(obj.getState()==1){out.print("<font color=#00ab00>"+obj.STATE_TYPE[obj.getState()]+"</font>");}else{out.print(obj.STATE_TYPE[obj.getState()]);} %></td>
		    <%-- <td nowrap><%if(contr>0){out.print("<a href=/jsp/type/photography/TalkbackReply.jsp?crid="+crid+">"+contr+"</a>");}else{out.print(contr);}%></td> --%>
		    <td nowrap>
		    <%if(obj.getState()==0){out.print("<a href=\"/jsp/commentreview/EditCommentReview.jsp?act=audit&crid="+crid+"&community="+teasession._strCommunity+"&nexturl="+URLEncoder.encode(nexturl,"UTF-8")+"\">审核</a>");} %>&nbsp;
		    <%out.print("<a href=\"/jsp/commentreview/EditCommentReview.jsp?act=edit&crid="+crid+"&community="+teasession._strCommunity+"&nexturl="+URLEncoder.encode(nexturl,"UTF-8")+"\">编辑</a>"); %>
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
