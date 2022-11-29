<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %><%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.bbs.*" %><%@page import="tea.entity.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %><%@page import="java.util.Enumeration"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Http h=new Http(request,response);

String _strId=request.getParameter("id");
//删除附件
if(request.getParameter("delfile")!=null)
{
  int nodes = Integer.parseInt(request.getParameter("node"));
  Node node = Node.find(nodes);
  node.setFileName("",teasession._nLanguage);
  String delpath = getServletContext().getRealPath(request.getParameter("filename"));
  new File(delpath).delete();
}


Resource r=new Resource("/tea/resource/BBS");


String from=request.getParameter("from");
String to=request.getParameter("to");
String creator=request.getParameter("creator");
String keywords=request.getParameter("keywords");

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null&&tmp.length()>0)
{
  pos=Integer.parseInt(tmp);
}

StringBuffer par=new StringBuffer();
par.append(request.getRequestURI()+"?community="+teasession._strCommunity);
par.append("&id="+_strId);

StringBuffer info=new StringBuffer();

StringBuffer sql=new StringBuffer();
sql.append(" AND community=").append(DbAdapter.cite(teasession._strCommunity));
sql.append(" AND type=57 AND finished=1");

//判断权限



AdminUsrRole arobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
if(Profile.find(teasession._rv._strR).getBbspermissions()!=null&&Profile.find(teasession._rv._strR).getBbspermissions().length()>0)
{


		StringBuffer sb = new StringBuffer(" and   ");
		String bbsp = Profile.find(teasession._rv._strR).getBbspermissions();
		for(int i=1;i<bbsp.split("/").length;i++){

			int bbs = Integer.parseInt(bbsp.split("/")[i]);

			sb.append(" or path like ").append(DbAdapter.cite("%/"+bbs+"/%"));


		}

		 if(" and   ".equals(sb.toString()))
         {
         			sql.append(sb.toString().replaceAll("and",""));
         }else
         {
         		sql.append(sb.toString().replaceAll(" and    or"," and (")+")");
         }



}



int father=0;
tmp=request.getParameter("father");
if(tmp!=null&&tmp.length()>0)
{
  father=Integer.parseInt(tmp);
  sql.append(" AND father=").append(father);
  par.append("&father=").append(father);
  info.append("在<b color='red'>").append(Node.find(father).getSubject(teasession._nLanguage)).append("</b>版面下，");
}
if(from!=null&&from.length()>0)
{
  sql.append(" AND time>=").append(DbAdapter.cite(from));
  par.append("&from=").append(from);
  info.append("发表日期大于<b color='red'>").append(from).append("</b>，");
}
if(to!=null&&to.length()>0)
{
  sql.append(" AND time<").append(DbAdapter.cite(to));
  par.append("&to=").append(to);
  info.append("发表日期小于<b color='red'>").append(to).append("</b>，");
}
//查阅状态
int search = -1;
if(teasession.getParameter("search")!=null && teasession.getParameter("search").length()>0)
{
	search = Integer.parseInt(teasession.getParameter("search"));
}
if(search>=0)
{
	 sql.append(" and node in (select node from BBS where search ="+search+" )");
	 par.append("&search=").append(search);
}

if(creator!=null&&creator.length()>0)
{
  sql.append(" AND vcreator LIKE ").append(DbAdapter.cite("%"+creator+"%"));
  par.append("&creator=").append(java.net.URLEncoder.encode(creator,"UTF-8"));
}
if(keywords!=null&&keywords.length()>0)
{
  sql.append(" AND node IN (SELECT node FROM NodeLayer WHERE subject LIKE ").append(DbAdapter.cite("%"+keywords+"%")).append(" OR content LIKE ").append(DbAdapter.cite("%"+keywords+"%")).append(")");
  par.append("&keywords=").append(java.net.URLEncoder.encode(keywords,"UTF-8"));
}
par.append("&pos=");


//版块的下拉菜单
tea.html.DropDown select=new tea.html.DropDown("father",father);
select.addOption("","----------------");
AdminUsrRole aur_obj=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);
Communitybbs com_obj=Communitybbs.find(teasession._strCommunity);
boolean _bCommunityMember=  teasession._rv._strR.equals(  com_obj.getSuperhost());
sql.append(" AND (0!=0");
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT n.node FROM Node n INNER JOIN Category c ON n.node=c.node WHERE n.type=1 AND n.community="+db.cite(teasession._strCommunity)+" AND c.category=57");
  while(db.next())
  {
    int id=db.getInt(1);
    if(aur_obj.getBbsHost().indexOf("/"+id+"/")!=-1||aur_obj.getBbsExpert().indexOf("/"+id+"/")!=-1||_bCommunityMember)
    {
      select.addOption(id,Node.find(id).getSubject(teasession._nLanguage));
      sql.append(" OR father="+id);
    }
  }
}finally
{
  db.close();
}
sql.append(")");


int count=Node.count(sql.toString());



info.append("共查询到<b color='red'>").append(count).append("</b>条贴子。");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script SRC="/tea/tea.js" type="text/javascript"></script>
<script SRC="/tea/mt.js" type="text/javascript"></script>
<script type="text/javascript">
function f_act(act)
{
  if(!submitCheckbox(form2.nodes,'无效选择!'))return false;
  switch(act)
  {
    case "reply":
    if(!form2.nodes.length)form2.nodes=new Array(form2.nodes);
    for(var index=0;index<form2.nodes.length;index++){if(form2.nodes[index].checked)window.open("/jsp/type/bbs/BBSReplyManage.jsp?node="+form2.nodes[index].value,"_self");}
    return true;
    case "move":
    mt.show('/jsp/type/bbs/BBSMove.jsp?community=<%=teasession._strCommunity%>&nodes='+mt.value(form2.nodes,',')+'&nexturl='+encodeURIComponent(form2.nexturl.value),1,'移动贴子',280,120);
    return;
    case "del":
    if(!confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'))return false;
    break;
    case "hidden_s":
    var rs=window.confirm('<%=r.getString(teasession._nLanguage, "您确定要审核吗？")%>');
    if(!rs)return;
    break;
  }
  form2.act.value=act;
  form2.submit();
}

function f_member(igd)
{

	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:550px;dialogHeight:220px;';
	 var url = '/jsp/type/bbs/BBSMember.jsp?member='+encodeURIComponent(igd)+'&t='+new Date().getTime();
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1){
		 window.location.reload();
	 }

}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "帖子管理")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2><%=r.getString(teasession._nLanguage, "查询")%></h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>

<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr><td nowrap><%=r.getString(teasession._nLanguage,"BBSSpace")%>：<%=select.toString()%></td>
<td nowrap>时间：<input type="text" name="from" value="<%if(from!=null)out.print(from);%>" readonly size="9"><input onClick="showCalendar('form1.from')" type="button" value="" class="Calendar">
  <input readonly name="to"  value="<%if(to!=null)out.print(to);%>" type="text" size="9"><input onClick="showCalendar('form1.to')" type="button" value="" class="Calendar"></td>
<td></td></tr><tr><td nowrap><%=r.getString(teasession._nLanguage,"Poster")%>：<input name="creator"  value="<%if(creator!=null)out.print(creator);%>" type="text" size="10"></td>
<td nowrap><%=r.getString(teasession._nLanguage,"Keywords")%>：<input name="keywords"  value="<%if(keywords!=null)out.print(keywords);%>" type="text" ></td>
<tr>
<td>查阅状态：
<select name="search">
<option value="-1">-查阅状态-</option>
<option value="0" <%if(search==0)out.print(" selected "); %>>-未查阅-</option>
<option value="1" <%if(search==1)out.print(" selected "); %>>-已查阅-</option>

</select></td>
<td nowrap><input type="submit" value="查询"></td>
</tr>
</tr>
</table>
</form>
<br>

<h2><%=r.getString(teasession._nLanguage, "列表")%>&nbsp;<%=info.toString()%>&nbsp;
  <input type="button" onClick="f_act('search')" value="<%=r.getString(teasession._nLanguage,"查阅")%>">
  <input type="button" onClick="f_act('reply')" value="<%=r.getString(teasession._nLanguage,"ReplyManage")%>">
  <input type="button" onClick="f_act('parktop')" value="<%=r.getString(teasession._nLanguage,"Parktop")%>">
  <input type="button" onClick="f_act('quintessence')" value="<%=r.getString(teasession._nLanguage,"Quintessence")%>">
  <input type="button" onClick="f_act('move')" value="<%=r.getString(teasession._nLanguage,"移动")%>">
  <input type="button" onClick="f_act('del')" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>">
  <input type='button' onclick="f_act('hidden_s');" value='审核/隐藏'>
</h2>

<form name="form2" action="/servlet/EditBBS" target="_ajax" onSubmit="">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>
<input type="hidden" name="forum" value="0"/>
<input type="hidden" name="act" />
<input type="hidden" name="nexturl" />

<table cellspacing="0" cellpadding="0" id="tablecenter">
<tr id="tableonetr">
 <td width=1><input type="CHECKBOX" onClick="selectAll(form2.nodes,this.checked);"/></td>
	<td>板块</td>
	<td>主题</td>
	<td>发贴人</td>
	<TD>查阅状态</TD>
    <TD>查阅用户</TD>
	<td>上传附件</td>
	<td>回复数量</td>
	<td>创建日期</td>
	<td>操作</td>
</tr>
<%

if(count>0)
{
  sql.append(" ORDER BY node DESC");

  java.util.Enumeration e=Node.find(sql.toString(),pos,25);
  while(e.hasMoreElements())
  {
    int nodeid=((Integer)e.nextElement()).intValue();
    Node obj=Node.find(nodeid);
   String crmember = obj.getCreator()._strR;

    if("<ANONYMITY>".equals(crmember))
    {
    	crmember= "匿名";
    }
    BBS bbs=BBS.find(nodeid,teasession._nLanguage);
   // String subject=obj.getAnchor()//obj.getAnchor(teasession._nLanguage);//obj.getAnchor(teasession._nLanguage);//obj.getSubject(teasession._nLanguage);
    String fileName = obj.getFileName(teasession._nLanguage);
    out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.print("<td width=1><input name=nodes type=checkbox value="+nodeid+" ></td>");
    out.print("<td><a href='/html/category/"+obj.getFather()+"-"+teasession._nLanguage+".htm' target='_blank'>");
    out.print(Node.find(obj.getFather()).getSubject(teasession._nLanguage));
    out.print("</a></td>");
	out.print("<td>");

    if(bbs.isParktop())
    {
      out.print("[<font color='red'>" + r.getString(teasession._nLanguage, "Parktop") + "</font>]");
    }
    if(bbs.isQuintessence())
    {
      out.print("[<font color='red'>" + r.getString(teasession._nLanguage, "Quintessence") + "</font>]");
    }
    //if(keywords!=null&&keywords.length()>0)
    //{
     // subject=subject.replaceAll(keywords,"<font color='red'>"+keywords+"</font>");
   // }


    out.print("<a href='/html/bbs/"+nodeid+"-"+teasession._nLanguage+".htm' target='_blank'>"+obj.getSubject(teasession._nLanguage)+"</a>");
    if(obj.isHidden())
    {
    	 out.print("[<font color='#D3D3D3'>" + r.getString(teasession._nLanguage, "隐藏") + "</font>]");
    }
    out.print("</td>");
    out.print("<td>");
    out.print("<a href=### title=点击设置用户禁止发言  onclick=f_member('"+crmember+"'); >");
    out.print(crmember);
    out.print("</a>");
    out.print("</td>");
    out.print("<td>");
    if(bbs.getSearch()==0){out.print("<font color=red>未查阅</font>");}else{out.print("已查阅");}
    out.print("</td>");
    out.print("<td>");
    if(bbs.getSearch()==1&&bbs.getSearchmember()!=null)out.print(bbs.getSearchmember());
    out.print("</td>");
    out.print("<td nowrap>"+Attch.f(obj.getFile(teasession._nLanguage),"；"));
//    if(fileName!=null&&fileName.length()>0)
//    {
//      out.print("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(fileName,"utf-8")+"&name="+java.net.URLEncoder.encode("附件","utf-8")+"."+fileName.substring(fileName.lastIndexOf(".")+1)+"><img src=\"/tea/image/netdisk/"+fileName.substring(fileName.lastIndexOf(".")+1)+".gif\" />附件</a>");
//      out.print("　<a href='"+par.toString()+"&node="+nodeid+"&delfile=true&filename="+java.net.URLEncoder.encode(fileName,"utf-8")+"' onclick=return(confirm('"+r.getString(teasession._nLanguage,"ConfirmDelete")+"'))>删除</a>");
//    }
    out.print("&nbsp;</td>");
    out.print("<td><a href=/jsp/type/bbs/BBSReplyManage.jsp?community="+teasession._strCommunity+"&node="+nodeid+"  title=点击进入跟帖管理>"+BBSReply.count(nodeid,teasession._nLanguage)+"</a></td>");
    out.print("<td>"+obj.getTimeToString()+"</td>");
    out.print("<td><a href='/jsp/type/bbs/BBSView.jsp?node="+nodeid+"&nexturl="+Http.enc(par.toString())+"'>查阅</a></td>");
    out.print("</tr>");
  }
  if(count>25)
  out.print("<tr><td align=center colspan=10>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(), pos,count)+"</td></tr>");
}else
{
  out.print("<tr><td align=center colspan=6>暂无记录");
}
%>
  </table>

</form>

<script>
form2.nexturl.value=location.pathname+location.search;
</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
