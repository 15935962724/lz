 <%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.*"%>

<%@page import="tea.entity.member.*"%><%@page import="java.util.Enumeration"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Node nobj = Node.find(teasession._nNode);
String nexturl = request.getRequestURI()+"?"+request.getQueryString();

if("POST".equals(request.getMethod()))
{
	String time_c = teasession.getParameter("time_c");
	String time_d = teasession.getParameter("time_d");
	String content = teasession.getParameter("content");
	nobj.set(Entity.sdf.parse(time_c),Entity.sdf.parse(time_d));
	nobj.set(teasession._nLanguage,nobj.getSubject(teasession._nLanguage),content);

	int diff_data = Entity.countDays(time_c,time_d)+1;
	for(int i =1;i<=diff_data;i++)
	{
		String time_name = Entity.sdf.format(Entity.getDayTime(Entity.sdf.parse(time_c),i-1));

		int time_node = Node.getNode(time_name,teasession._nNode);
		System.out.println(i+":"+time_name);
		if(time_node>0)
		{
			Node time_nobj = Node.find(time_node);
			time_nobj.set(teasession._nLanguage,time_name,content);
		}else
		{

			//添加新闻类别
				int sequence = Node.getMaxSequence(i) + 10;

			 int j = Node.create(teasession._nNode,sequence,nobj.getCommunity(),teasession._rv,1,nobj.isHidden(),nobj.getOptions(),
			 								 nobj.getOptions1(),nobj.getDefaultLanguage() ,null,null,new java.util.Date(),0,teasession._nNode,
			 								 nobj.getKstyle(),nobj.getKroot(),null,teasession._nLanguage,time_name,null,null, content, null,null,
			 								 0,null,null,null,null,null,null,null);

	         	Node n = Node.find(j);
	         	n.finished(j);

	         	Category category = Category.find(j);
	         	category.set(39,0,0,null,0);

		}
	}
	out.print("<script  language='javascript'>alert('信息添加成功!');window.location.href='"+nexturl+"';</script> ");
    return;
}


//开始时间
String time_c = "";
if(nobj.getStartTime()!=null)
{
	time_c = nobj.sdf.format(nobj.getStartTime());
}
//截止时间
String time_d = "";
if(nobj.getStartTime()!=null)
{
	time_d = nobj.sdf.format(nobj.getStopTime());
}



%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>创建常规表演</title>
</head>
<script>
 function f_submt()
 {
 	if(form1.time_c.value==''){
 		alert('请选择开始时间!');
 		form1.time_c.focus();
 		return false;
 	}
 	if(form1.time_c.value==''){
 		alert('请选择截止时间!');
 		form1.time_c.focus();
 		return false;
 	}
 	form1.action="?";
 	form1.submit();
 }
</script>
<body id="bodynone">
  <h1>创建常规表演</h1>

  <form action="?" name="form1" method="POST">
  <input type ="hidden" name="node" value="<%=teasession._nNode %>">
  <input type ="hidden" name="id" value="<%=teasession.getParameter("id") %>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	     <td align="right">开始时间：</td>
	     <td>
		     <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');">
		     <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
	     </td>
	 </tr>
	  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	      <td align="right">截止时间：</td>
	      <td>
	      		<input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');" >
	        	<img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" />
	      </td>
	</tr>
	 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	      <td  align="right">常规表演：</td>
	      <td>
	      		 <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input">

	      		 	<%
	      		 	if(nobj.getText(teasession._nLanguage)!=null && nobj.getText(teasession._nLanguage).length()>0)
	      		 	{
	      		 		out.print(nobj.getText(teasession._nLanguage));
	      		 	}else
	      		 	{
	      		 	 %>
	      		 	 <table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=left
 width="99%" >
 <tr>
  <td width=137 align="center" nowrap ><strong>时间</strong></td>
  <td width=230 colspan=2 align="center"><strong>动物表演场数和时间</strong></td>
  <td width=222 colspan=2 align="center"><strong>潜水喂食表演场数和时间</strong></td>
 </tr>
 <tr>
  <td width=137 align="center" nowrap><strong>星期</strong></td>
  <td width=80 align="center" nowrap><strong>场数</strong></td>
  <td width=150 align="center" nowrap><strong>开始时间</strong></td>
  <td width=58 align="center"><strong>场数</strong></td>
  <td width=164 align="center"><strong>开始时间</strong></td>
 </tr>
 <tr >
  <td width=137 align="center" nowrap >星期一至星期五</td>
  <td width=80 align="center" nowrap >二场</td>
  <td width=150 nowrap >上午：11:00　下午：15:00
</td>
  <td width=58 rowspan=3 align="center" >两场</td>
  <td width=164 rowspan=3 >上午：10:00　下午：13:30<br>（周二清池，无表演）
</td>
 </tr>
 <tr >
  <td width=137 align="center" nowrap >星期六</td>
  <td width=80 rowspan=2 align="center" >三场</td>
  <td width=200 rowspan=2 > 上午：11:00　下午：13:30、16:00
 </td>
 </tr>
 <tr align="center" >
  <td width=137 nowrap >星期日</td>
 </tr>
</table>
<%} %>
	      		 </textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._nNode%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>

	      </td>

	</tr>

  </table>
  <br>
  <input type="button" value="提交" onclick="f_submt();">
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
