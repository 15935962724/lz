<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.resource.*" %><%@page import="java.util.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.DbAdapter" %><%@page import="java.net.URLEncoder"%>
<% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource();

String _strId=request.getParameter("id");

StringBuffer sql=new StringBuffer();
sql.append(" AND type=73 AND community=").append(DbAdapter.cite(teasession._strCommunity));
sql.append(" AND father ="+teasession._nNode);
StringBuffer param=new StringBuffer();
param.append("?id=").append(_strId);
param.append("&node=").append(teasession._nNode);
param.append("&community=").append(teasession._strCommunity);


String name = teasession.getParameter("name");
if(name!=null && name.length()>0)
{
	sql.append(" and n.node in (select node from MessageBoard where name  like "+DbAdapter.cite("%"+name+"%")+") ");
	param.append("&name=").append(URLEncoder.encode(name,"UTF-8"));
}

//留言时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND n.time >=").append(DbAdapter.cite(time_c+" 00:00"));
  param.append("&time_c=").append(time_c);
}

String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND n.time <=").append(DbAdapter.cite(time_d+" 23:59"));
  param.append("&time_d=").append(time_d);
}

//留言内容
String q=request.getParameter("q");
if(q!=null&&(q=q.trim()).length()>0)
{
  sql.append(" AND node IN (SELECT node FROM NodeLayer WHERE content LIKE "+DbAdapter.cite("%"+q+"%")+")");
  param.append("&q="+java.net.URLEncoder.encode(q,"UTF-8"));
}

//国家地区
String subject=request.getParameter("subject");
if(subject!=null&&(subject=subject.trim()).length()>0)
{
  sql.append(" AND node IN (SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  param.append("&subject="+java.net.URLEncoder.encode(subject,"UTF-8"));
}

//是否审核
int hidden = -1;
if(teasession.getParameter("hidden")!=null && teasession.getParameter("hidden").length()>0){
	hidden = Integer.parseInt(teasession.getParameter("hidden"));
}
if(hidden>=0){
	sql.append(" and hidden = ").append(hidden);
	param.append("&hidden=").append(hidden);
}
//是否回复

int replymanage = -1;
if(teasession.getParameter("replymanage")!=null && teasession.getParameter("replymanage").length()>0){
	replymanage = Integer.parseInt(teasession.getParameter("replymanage"));
}
if(replymanage>=0){

	if(replymanage==1){
		sql.append(" and  Exists  (select m.node from MessageBoardReply m where n.node = m.node) ");
	}else if(replymanage==0){
		sql.append(" and not Exists  (select m.node from MessageBoardReply m where n.node = m.node) ");
	}
	param.append("&replymanage=").append(replymanage);
}

int pos=0,pageSize=25;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

String nexturl=request.getRequestURI()+"?"+request.getQueryString();

int count=Node.count(sql.toString());

sql.append(" ORDER BY time DESC");

%>
<!--
参数:
father: 父节点
-->
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script>
   var cm = null;
  function c_seat(id,m,mem)
    {
      currentPos = 'othe';


      var url = "/jsp/admin/edn_ajax.jsp?community="+form2.community.value+"&act=meminfo&node="+mem+"&member=<%=teasession._rv.toString()%>";
      url = encodeURI(url);
      send_request(url);



      m.style.display='none';
      if(id!=cm)
      {
        m.style.display='';
        m.style.pixelLeft = getPos(id,"Left");
        m.style.pixelTop = getPos(id,"Top") + id.offsetHeight+3;
        cm=id;
      }else
      {
        m.style.display='none';
        cm=null;
      }



    }
   function getPos(el,sProp)
    {
      var iPos = 0 ;
      　　while (el!=null)   　　
      {
        iPos+=el["offset" + sProp];
        　el = el.offsetParent;
      }
      　　return iPos;
    }

   function f_excel()
   {

			if(confirm("您确定要导出数据吗?"))
		    {
				form2.action='/servlet/EditExcel';
				form2.act.value='WomenMessageBoardManage';
				form2.submit();
			}

   }
</script>
<body id="bodynone">
<h1>留言板管理</h1>
    <div id="head6"><img height="6" src="about:blank"></div>
   <br>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<input type="hidden" name="id" value="<%=_strId%>" />
<input type="hidden" name="sql" value="<%=sql.toString() %>">
<input type="hidden" name="files" value="留言列表"/>
<input type="hidden" name="act">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>

<table cellspacing="0" cellpadding="0"  id="tablecenter">
<tr>

	<td align="right">留言人：</td>
	<td><input type="text" name="name" value="<%if(name!=null)out.print(name); %>"></td>

	<td align="right">留言时间：</td>
	<td>

	        从&nbsp;
	        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');">
	        <img style="margin-bottom:-8px;"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
	        &nbsp;到&nbsp;
	        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');" >
	        <img style="margin-bottom:-8px;"   src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" />

	</td>
</tr>
<tr>
<td align="right">国家/地区：</td>
<td><input name="subject"  value="<%if(subject!=null)out.print(subject);%>" type="text">
<td align="right">留言内容：</td>
<td><input name="q"  value="<%if(q!=null)out.print(q);%>" type="text">
 </tr>
 <tr>
 <td align="right">审核状态：</td>
 <td><select name="hidden">
 	<option value="-1" <%if(hidden==-1)out.print(" selected "); %>>-审核状态-</option>
 	<option value="1" <%if(hidden==1)out.print(" selected "); %>>未批准</option>
 	<option value="0" <%if(hidden==0)out.print(" selected "); %>>已批准</option>
 </select></td>
  <td align="right">是否回复：</td>
 <td>
 <select name="replymanage">
 	<option value="-1" <%if(replymanage==0)out.print(" selected "); %>>-是否回复-</option>
 	<option value="0" <%if(replymanage==0)out.print(" selected "); %>>未回复</option>
 	<option value="1" <%if(replymanage==0)out.print(" selected "); %>>已回复</option>
 </select>
 </td>
 </tr>
  <td colspan="10" align="center"><input type="submit" value="查询"></td>
</td></tr></table>
</form>
<br>
<form id="form2">
<h2>列表 ( <%=count%> )&nbsp;&nbsp;<input type="button" value="删除选中记录" onClick="delSelect();">&nbsp;<input type="button" value="导出Excel表" onClick="f_excel();"></h2>

<input type="hidden" name="operate" value="delByCb"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="sql" value="<%=sql.toString() %>">
<input type="hidden" name="files" value="留言列表"/>
<input type="hidden" name="act">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
<td width="1"><input type="checkbox" name="selectAll" id="selectAll"  onclick="selectall()" /></td>
    <td nowrap>留言人</td>
     <td nowrap>国家/地区</td>
    <td nowrap>内容</td>
    <td nowrap>回复数</td>
    <td nowrap>留言时间</td>
    <td>&nbsp;</td>
</tr>
<%
Enumeration e=Node.find(sql.toString(),pos,pageSize);
if(!e.hasMoreElements())
{
    out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
}
for(int i=pos+1;e.hasMoreElements();i++)
{
  int id=((Integer)e.nextElement()).intValue();
  Node n=Node.find(id);
  MessageBoard obj = MessageBoard.find(id,teasession._nLanguage);
  int reply_count=MessageBoardReply.count(id,teasession._nLanguage);
 // String subject=n.getSubject(teasession._nLanguage);
  //if(q!=null&&q.length()>0)
  //{
   // subject=subject.replaceAll(q,"<font color='red'>"+q+"</font>");
 // }
  out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" >");
  out.print("<td width=1><input name='cb'  type='checkbox' value="+id+" ></td>");

  out.print("<td  id=mem"+id+"><a href=\"###\" onclick=\"c_seat(mem"+id+",othe,'"+id+"');\">");
  if(n.isHidden()){out.print("<font color=red><strike>");}
  out.print(obj.getName());
  if(n.isHidden()){out.print("</strike></font>");}
 out.print("</a>");

  if ((System.currentTimeMillis() - n.getTime().getTime() - 1000 * 60 * 60 * 24L) < 0 ||  (reply_count > 0 && (System.currentTimeMillis() - MessageBoardReply.find(MessageBoardReply.findLast(n._nNode, teasession._nLanguage)).getTime().getTime() - 1000 * 60 * 60 * 24L) < 0))
  out.print("<img src=/tea/image/public/new.gif>");
  out.print("</td>");
  out.print("<td>"+n.getSubject(teasession._nLanguage)+"</td>");
  out.print("<td>&nbsp;");
  String log_content=n.getText(teasession._nLanguage);
  if(log_content!=null)
  {
    log_content=Report.getHtml2(log_content);//log_content.replaceAll("<","&lt;");  log_content.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")
    if(log_content.length()>25){

        out.print("<textarea style=display:none id=content_"+id+" >"+log_content+"</textarea><a href=\"javascript:var obj=window.open('','','height=250,width=500,left=400,top=300,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');obj.document.write(document.getElementById('content_"+id+"').value);\" >"+log_content.replaceAll("&nbsp;","").substring(0,25)+"...</a>");//&#39;
    }
    else{
    out.print(log_content);
    }
  }
  out.println("<td>"+reply_count+"</td>");
  out.println("<td nowrap>"+Node.sdf2.format(n.getTime())+"</td>");
  out.println("<td nowrap><input type=button value="+r.getString(teasession._nLanguage,"回复管理")+" onClick=\"window.open('/jsp/type/messageboard/WomenMessageBoardReplyManage.jsp?community="+teasession._strCommunity+"&node="+id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"');\">");
  if(n.isHidden())
  {
     out.println("<input type=button NAME=Grant value="+r.getString(teasession._nLanguage,"Grant")+" onClick=\"window.open('/servlet/GrantNodeRequests?community="+teasession._strCommunity+"&node="+n.getFather()+"&Grant=ON&nodes="+id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self');\">");
  }else
  {
	  out.println("<input type=button NAME=Deny value="+r.getString(teasession._nLanguage,"隐藏")+" onClick=\"window.open('/servlet/GrantNodeRequests?community="+teasession._strCommunity+"&node="+n.getFather()+"&Deny=ON&nodes="+id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self');\">");
  }
     //        else
  //        out.println("<input type=button NAME=Deny value="+r.getString(teasession._nLanguage,"Deny")+" onClick=\"window.open('/servlet/GrantNodeRequests?community="+teasession._strCommunity+"&node="+n.getFather()+"&Deny=ON&noderequests="+id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"');\">");
  out.println("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onClick=\"if(confirm('"+r.getString(teasession._nLanguage,"ConfirmDelete")+"')){window.open('/servlet/DeleteNode?community="+teasession._strCommunity+"&node="+id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self'); this.disabled=true;}\"></td></tr>");
}
%>

 <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>


<script>
    function delSelect(){

        var el = document.forms[1].elements;
        var count = el.length;
        var flag = 0;
        for   (i=0;i<count;i++)
        {
          if   (el[i].type=="checkbox")
          {
            if(el[i].checked == true){
              flag = 1;
            }
          }
        }
        if(flag == 1){
        	var rs=window.confirm('<%=r.getString(teasession._nLanguage, "您确定删除吗？")%>');
           if(rs){
              // alert("删除成功");
	          form2.action ="/servlet/DeleteNode";
	          form2.submit();
            }
        }else if(flag == 0){
          alert("至少选择一项");
        }

    }
    function selectall(){
      var el = document.forms[1].elements;
      var count = el.length;
      if(document.getElementById("selectAll").value == "全选"){
        document.getElementById("selectAll").value = "全不选"
        for   (i=0;i<count;i++)
        {
          if   (el[i].type=="checkbox")
          {
            el[i].checked = true;
          }
        }
      }
      else{
        document.getElementById("selectAll").value = "全选"
        for   (i=0;i<count;i++)
        {
          if   (el[i].type=="checkbox")
          {
            el[i].checked = false;
          }
        }
      }
    }
</script>

</table>
<div id="othe" style="display:none;width:275px;height:170px;border:1px solid #ccc;position:absolute;z-index:99;background-color:#E0EDFE;">
    </div>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
