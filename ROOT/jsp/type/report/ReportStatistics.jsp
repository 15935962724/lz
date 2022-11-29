<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*" %><%@page import="jxl.write.*" %><%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.Resource"%><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.regex.Pattern" %><%@page import="java.util.regex.Matcher" %><%@page import="java.util.*" %><%@page import="java.net.*" %>
<%@page import="jxl.format.UnderlineStyle" %>
<%@page import="jxl.write.WritableCellFormat" %>
<%@page import="jxl.write.WritableFont" %>
<%@page import="tea.entity.admin.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


StringBuffer sql=new StringBuffer(" AND hidden=0 AND finished=1");
StringBuffer param=new StringBuffer();

param.append("?id=").append(request.getParameter("id"));

//栏目
String father = teasession.getParameter("father");
if(father!=null && father.length()>0)
{
	father = father.trim();
	sql.append(" and  n.father in (select node from NodeLayer where subject = "+DbAdapter.cite(father)+" ) ");
	param.append("&father=").append(URLEncoder.encode(father,"UTF-8"));
}
//文章标题
String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
	subject = subject.trim();
	sql.append(" and exists (select node from NodeLayer nl where nl.node = n.node and nl.subject like "+DbAdapter.cite("%"+subject+"%")+" )");
	//sql.append(" and  nl.subject like "+DbAdapter.cite("%"+subject+"%")+"   ");
	param.append("&subject=").append(URLEncoder.encode(subject,"UTF-8"));
}

 //作者
 String author = teasession.getParameter("author");
if(author!=null && author.length()>0)
{
	author = author.trim();
	//sql.append(" and  rl.author like "+DbAdapter.cite("%"+author+"%")+"   ");
	sql.append(" and exists (select node from ReportLayer rl where rl.node = n.node and rl.author like "+DbAdapter.cite("%"+author+"%")+" )");
	param.append("&author=").append(URLEncoder.encode(author,"UTF-8"));
}
//发生日期

String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
 // sql.append(" AND r.issuetime >=").append(DbAdapter.cite(time_c+" 00:00"));
 sql.append(" AND n.time >=").append(DbAdapter.cite(time_c+" 00:00"));
  param.append("&time_c=").append(time_c);
}

String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
//  sql.append(" AND r.issuetime <=").append(DbAdapter.cite(time_d+" 23:59"));
 sql.append(" AND n.time  <=").append(DbAdapter.cite(time_d+" 23:59"));
  param.append("&time_d=").append(time_d);
}

//创建者
String member = teasession.getParameter("member");
if(member!=null && member.length()>0)
{
	sql.append(" and n.rcreator like "+DbAdapter.cite("%"+member+"%")+" ");
	param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}
//稿件类别
int manuscripttype = -1;
if(teasession.getParameter("manuscripttype")!=null && teasession.getParameter("manuscripttype").length()>0)
{
	manuscripttype = Integer.parseInt(teasession.getParameter("manuscripttype"));
}
if(manuscripttype>=0){
	sql.append(" and r.manuscripttype = ").append(manuscripttype);
	param.append("&manuscripttype=").append(manuscripttype);
}

//专家
 String experts = teasession.getParameter("experts");
if(experts!=null && experts.length()>0)
{
	experts = experts.trim();
	//sql.append(" and  rl.author like "+DbAdapter.cite("%"+author+"%")+"   ");
	sql.append(" and exists (select node from ReportLayer rl where rl.node = n.node and rl.experts like "+DbAdapter.cite("%"+experts+"%")+" )");
	param.append("&experts=").append(URLEncoder.encode(experts,"UTF-8"));
}
//新闻提供者
String providemember = teasession.getParameter("providemember");
if(providemember!=null && providemember.length()>0)
{
	providemember = providemember.trim();
	//sql.append(" and  rl.author like "+DbAdapter.cite("%"+author+"%")+"   ");
	sql.append(" and exists (select node from ReportLayer rl where rl.node = n.node and rl.providemember like "+DbAdapter.cite("%"+providemember+"%")+" )");
	param.append("&providemember=").append(URLEncoder.encode(providemember,"UTF-8"));
}
//编辑
String editmember = teasession.getParameter("editmember");
if(editmember!=null && editmember.length()>0)
{
	editmember = editmember.trim();
	sql.append(" and exists (select node from ReportLayer rl where rl.node = n.node and rl.editmember like "+DbAdapter.cite("%"+editmember+"%")+" )");
	param.append("&editmember=").append(URLEncoder.encode(editmember,"UTF-8"));
}
//自定义新闻分类
int markname = 0;
if(teasession.getParameter("markname")!=null && teasession.getParameter("markname").length()>0)
{
	markname = Integer.parseInt(teasession.getParameter("markname"));
}

if(markname>0)
{
	 sql.append(" and n.mark like ").append(DbAdapter.cite("/"+markname+"/"));
	 param.append("&markname=").append(markname);
}

//创建者部门
String tmp=teasession.getParameter("aunits");
int auid=tmp==null?0:Integer.parseInt(tmp);
if(auid>0)
{
  StringBuffer sb=new StringBuffer();
  sb.append(" and n.rcreator in (");
  sb.append("SELECT aus.member FROM AdminUnitSeq aus INNER JOIN AdminUsrRole aur ON ");
  if(auid!=0)
  {
    sb.append("aus.unit=" + auid + " AND ");
  }
  sb.append("aus.member=aur.member WHERE aur.community=").append(DbAdapter.cite(teasession._strCommunity));
  sb.append(" AND aur.role!='/' ");
  if(auid!=0)
  {
    sb.append(" AND ( aur.unit=" + auid + " OR aur.dept LIKE ").append(DbAdapter.cite("%/" + auid + "/%"));
    sb.append(" )");
  }
  sb.append(" ) ");
  sql.append(sb.toString());
  param.append("&aunits=").append(auid);
}

int pos=0,size=40;
if (request.getParameter("pos") != null) {
	  pos = Integer.parseInt(request.getParameter("pos"));
}
int count=Node.countReport(teasession._strCommunity,sql.toString());

String o=request.getParameter("o");
if(o==null)
{
  o="n.time";
}
boolean aq=java.lang.Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"ASC":"DESC");
param.append("&o=").append(o).append("&aq=").append(aq);

Pattern p=Pattern.compile("(<img )",Pattern.CASE_INSENSITIVE);
if(teasession.getParameter("act")!=null&&teasession.getParameter("act").equals("excel"))
{Enumeration e=Node.findReport(teasession._strCommunity,sql.toString(),0,count);
javax.servlet.ServletOutputStream os = response.getOutputStream();
jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
jxl.write.WritableSheet ws = wwb.createSheet("查询结果", 0);
response.setContentType("application/x-msdownload");
response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("查询结果" + ".xls", "UTF-8"));


WritableFont wf = new WritableFont(WritableFont.TIMES, 10,WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
WritableCellFormat wcf = new WritableCellFormat(wf); // 单元格定义

wcf.setAlignment(jxl.format.Alignment.LEFT); // 设置对齐方式

// ws.getSettings().setPrintGridLines(true);//是否打印网格线

int sumlen=0,sumimg=0;
ws.setColumnView(0, 20); // 设置列的宽度
ws.setColumnView(1, 20); // 设置列的宽度
ws.setColumnView(2, 20); // 设置列的宽度
ws.setColumnView(3, 20); // 设置列的宽度
ws.setColumnView(4, 20); // 设置列的宽度
ws.setColumnView(5, 20); // 设置列的宽度
ws.setColumnView(6, 20); // 设置列的宽度
ws.setColumnView(7, 20); // 设置列的宽度

int i=0,j=0;
ws.addCell(new jxl.write.Label(j++,0,"文章栏目",wcf));
ws.addCell(new jxl.write.Label(j++,0,"文章标题",wcf));
ws.addCell(new jxl.write.Label(j++,0,"作者",wcf));
ws.addCell(new jxl.write.Label(j++,0,"稿件类别",wcf));
ws.addCell(new jxl.write.Label(j++,0,"发生日期",wcf));
ws.addCell(new jxl.write.Label(j++,0,"文章字数",wcf));
ws.addCell(new jxl.write.Label(j++,0,"图片数",wcf));
ws.addCell(new jxl.write.Label(j++,0,"创建者",wcf));

for(int x=pos+1;e.hasMoreElements();x++)
{
  int nodeid=((Integer)e.nextElement()).intValue();
  Node nobj=Node.find(nodeid);
  Report robj = Report.find(nodeid);
  Profile pobj = Profile.find(nobj.getCreator()._strR);
  String content=nobj.getText(teasession._nLanguage);
  String fathername=Node.find(nobj.getFather()).getSubject(teasession._nLanguage);
	String nodesubject=nobj.getSubject(teasession._nLanguage);
	String nodeauthor=robj.getAuthor(teasession._nLanguage);
	String type=Report.MANUSCRIPT_TYPE[robj.getManuscripttype()];
	String time=robj.getIssueTimeToString();

	 int len=0;
	 if(content!=null && content.length()>0){
	  content = Node.Html2Text(content);
	 //out.print( content);
	  len=content.getBytes().length/2;
	 }
	 out.print(len);
	 sumlen+=len;

		int img=0;
		  Matcher m=p.matcher(nobj.getText(teasession._nLanguage));
		  while(m.find())
		  {
		    img++;
		  }
	   sumimg+=img;
	    ws.addCell(new jxl.write.Label(0,i + 1,fathername));
        ws.addCell(new jxl.write.Label(1,i + 1,nodesubject));
        ws.addCell(new jxl.write.Label(2,i + 1, nodeauthor));
        ws.addCell(new jxl.write.Label(3,i + 1,type));
        ws.addCell(new jxl.write.Label(4,i + 1,time));
        ws.addCell(new jxl.write.Label(5,i + 1,String.valueOf(len)));
        ws.addCell(new jxl.write.Label(6,i + 1,String.valueOf(img)));
        ws.addCell(new jxl.write.Label(7,i + 1,nobj.getCreator()._strR));

        i++;
}
ws.addCell(new jxl.write.Label(0,i + 1,"合计"));
ws.addCell(new jxl.write.Label(5,i + 1,String.valueOf(sumlen)));
ws.addCell(new jxl.write.Label(6,i + 1,String.valueOf(sumimg)));

wwb.write();
wwb.close();
os.close();

}


%>
<html>
<head>
<title>文章信息统计</title>


<style type="text/css">
#gzd{position:absolute;position: relative;}
#xilidiv{display:block;position: relative;position:absolute;height: auto;width: 154px;left: 0px;top: 19px;z-index:1;}
#tablecenter #xiaoliajatable{background:#ffffff;width: 154px;}
#tablecenter #xiaoliajatable td{padding:4px 5px 2px 5px;height:18px;border-collapse:collapse;border:1px solid #9BB7CC;border-top:0;}
</style>

<script src="/tea/tea.js" type="text/javascript" ></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" type="text/css" rel="stylesheet">
<script>
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
function export2excel()
{if(confirm("您确定要导出数据吗?")){

  form1.act.value="excel";
  form1.submit();
}
}
function search()
{

  form1.act.value="";
  form1.submit();

}
function f_gz2()
{

  if (event.keyCode==38||event.keyCode==40)return;
  sendx("/jsp/type/report/Report_ajax.jsp?act=reportstatistics&cxxw="+encodeURIComponent(form1.father.value),
  function(data)
  {
    document.getElementById("cxshow").innerHTML=data;
  }
  );
}
function f_trdw(igd)
{
  form1.father.value=igd;
  document.getElementById("xilidiv").style.display='none';//隐藏div
}

</script>
</head>
<body >
<h1>文章信息统计</h1>
<h2>查询</h2>
<form name="form1" METHOD=GET action="?">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="act" VALUE="">
<input type="hidden" name="id" VALUE="<%=request.getParameter("id")%>">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  	<td align="right">文章栏目：</td>
  	<td>
  	<span id="gzd">
	   <span id="gzd"><span id="gztext">
	   		<input type="text" name="father" value="<%if(father!=null)out.print(father); %>" onKeyUp="f_gz2();" autoComplete="off">
	   	</span></span>
	  	<span id="cxshow">&nbsp;</span>
  	 </span>
  	</td>
  	<td align="right">文章标题：</td>
  	<td><input type="text" name="subject" value="<%if(subject!=null)out.print(subject); %>"></td>
  	<td align="right">作者：</td>
  	<td><input type="text" name="author" value="<%if(author!=null)out.print(author); %>"></td>
  </tr>
  <tr>
  	<td align="right">发生日期：</td>
  	<td> 从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" /></td>
  	<td align="right">创建者：</td>
  	<td><input type="text" name="member" value="<%if(member!=null)out.print(member); %>"></td>
  	<td align="right">稿件类别：</td>
  	<td nowrap>
      <select  name="manuscripttype">
      <option value="-1">------</option>
        <%

        for(int i=0;i<Report.MANUSCRIPT_TYPE.length;i++)
        {

          out.print("<option value="+i);
          if(manuscripttype==i)
          {
            out.print(" selected ");
          }
          out.print(">"+Report.MANUSCRIPT_TYPE[i]+"</option>");
        }
        %>
        </select>

    </td>
  </tr>
  <tr>
  <td align="right">专家：</td>
  <td><input type="text" name="experts" value="<%if(experts!=null)out.print(experts); %>"></td>
   <td align="right">新闻提供者：</td>
  <td><input type="text" name="providemember" value="<%if(providemember!=null)out.print(providemember); %>"></td>
  <td align="right">编辑：</td>
  <td><input type="text" name="editmember" value="<%if(editmember!=null)out.print(editmember); %>"></td>

  	</tr>
  	<tr>
  	 <td align="right">自定义新闻分类：</td>
     <td>
     <select name="markname">
     <option value="0">-新闻分类-</option>
     	<%
     	ArrayList me=Mark.find(" and community="+DbAdapter.cite(teasession._strCommunity),0,50);
     	for(int i=0;i<me.size();i++)
     	{
     	  Mark obj=(Mark)me.get(i);
     	  int id=obj.getMark();
     	  out.print("<option value="+id);
     	  if(markname==id)
     	  {
     		  out.print(" selected ");
     	  }
     	  out.print(">"+obj.getName());
     	  out.print("</option>");
     	}
     	%>
     	</select>
     </td>
     <td align="right">创建者所在部门：</td>
     <td>
     	<select name="aunits">
     		<option value="0" <%out.print(auid==0?"selected":""); %>>--请选择--</option>
     		<%
     			Enumeration en=AdminUnit.findByCommunity(teasession._strCommunity, " and father =2 ORDER BY sequence ", 0, 15);
     			while(en.hasMoreElements()){
     				AdminUnit au=(AdminUnit)en.nextElement();
     				out.print("<option value='"+au.getId()+"'");
     				if(auid==au.getId())
     					out.print("selected");
     			    out.print(">"+au.getName()+"</option>");
     			}
     		%>
     	</select>
     </td>
  	<td colspan="20" align="center"><input type="button" value="查询" onclick="search()"></td>
  </tr>
  </table>
  <h2>列表&nbsp;共有数据&nbsp;<%=count %>&nbsp;条</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	  <tr>
		<td nowrap>文章栏目</td>
		<td nowrap>文章标题</td>
		<%--<td nowrap>作者</td> --%>
		<td nowrap>稿件类别</td>
		<td nowrap><a href="###" onclick="f_order('n.time');">发生日期
  	<%
  	if(o.equals("n.time"))
  	{
  	  if(aq)
  	  out.print("<img src=\"/tea/image/pic_time_1.gif\" >");
  	  else
  		  out.print("<img src=\"/tea/image/pic_time_0.gif\" >");
  	}
  	%>
  	</a></td>
		<td nowrap>文章字数</td>
		<td nowrap>图片数</td>
			<td nowrap>创建者</td>
	</tr>

	<%
	 int sumlen=0,sumimg=0;
		Enumeration e=Node.findReport(teasession._strCommunity,sql.toString(),pos,size);
	 if(!e.hasMoreElements())
	   {
	       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
	   }
	for(int x=pos+1;e.hasMoreElements();x++)
	{
	  int nodeid=((Integer)e.nextElement()).intValue();
	  Node nobj=Node.find(nodeid);
	  Report robj = Report.find(nodeid);
	  Profile pobj = Profile.find(nobj.getCreator()._strR);
	  String content=nobj.getText(teasession._nLanguage);
	  System.out.println("nodeid:"+nodeid);
	%>
	<tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
		<td><%=Node.find(nobj.getFather()).getAnchor(teasession._nLanguage) %></td>
		<td><%=nobj.getAnchor(teasession._nLanguage,"_blank",null,20)%></td>
		<%--<td><%=robj.getAuthor(teasession._nLanguage) %></td> --%>
		<td><%=Report.MANUSCRIPT_TYPE[robj.getManuscripttype()] %></td>
		<td><%=nobj.getTimeToString() %></td>
		<td>
			<%

			  int len=0;


			  if(content!=null && content.length()>0){
				  content = Node.Html2Text(content);
				  //out.print( content);
			    len=content.getBytes().length/2;
			  }
			  out.print(len);
			  sumlen+=len;
			%>
		</td>
		<td>
			<%
			int img=0;
			  Matcher m=p.matcher(nobj.getText(teasession._nLanguage));
			  while(m.find())
			  {
			    img++;
			  }

			  //

			  sumimg+=img;
			  out.print(img);
			%>
		</td>
		<td><%=nobj.getCreator()._strR%></td>
	</tr>
	<%} %>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td align="right">合计：</td>
<td><%=sumlen %></td>
<td><%=sumimg %></td>
<td>&nbsp;</td>
</tr>
 <%if (count > size) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,size)%>    </td> </tr>
      <%}  %>
  </table>
  <input type="button" name="excel" value="导出到excel" onclick="export2excel()"/>

</FORM>
</body>
</html>

