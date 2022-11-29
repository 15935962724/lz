<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setHeader("Expires", "0");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");

	TeaSession teasession = new TeaSession(request);
	if (teasession._rv == null) {
		response.sendRedirect("/servlet/StartLogin?node="
				+ teasession._nNode);
		return;
	}

	//场次id号
	int psid = Integer.parseInt(teasession.getParameter("psid"));

	PerformStreak psobj = PerformStreak.find(psid);

	//添加区域视图图片
	String act = teasession.getParameter("act");
	if ("SeatPic".equals(act) && "POST".equals(request.getMethod())) 
	{

		String filepath = teasession.getParameter("file");
		String filename = teasession.getParameter("fileName");
		if (filepath == null) {
			out.print("<script>alert('您上传的文件不正确,请重新上传!');history.back();</script>");
			return;
		}
		SeatPic.create(psid, filename, filepath,teasession._strCommunity, teasession._rv.toString(),2);
	}
	
	if("f_delete".equals(act))
	{
		  int spid = Integer.parseInt(teasession.getParameter("spid"));
          SeatPic spobj = SeatPic.find(spid);
          spobj.delete();
	}
%> 
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>示意图管理</title>
</head>
<body id="bodynone"  >
<script>
window.name='tar';
function f_delete(igd)
{
	if(confirm('您确定要删除这个图片吗?')){
    form1.spid.value=igd;
    form1.act.value='f_delete';
    form1.submit();
  }
}
//关闭
function f_x()
{

	window.returnValue=1;
	window.close();
}
</script>
<form name="form1" method="post" action="?"  target="tar"  enctype="multipart/form-data">
  <input type="hidden" name="act" value="SeatPic">
  <input type="hidden" name="psid" value="<%=psid%>">
  <input type="hidden" name="spid" >
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

			<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
				<tr id="tableonetr">
					<td>
						示意图管理
					</td>
				</tr>
				<%
					java.util.Enumeration e = SeatPic.find(teasession._strCommunity," AND type = 2 AND node = " + psid+ " order by times desc  ", 0, Integer.MAX_VALUE);
					if(!e.hasMoreElements())
					{
						 out.print("<tr><td colspan=2 align=center>暂无记录</td></tr>");
					}
					for (int i = 1; e.hasMoreElements(); i++) {
						int spid = ((Integer) e.nextElement()).intValue();
						SeatPic spobj = SeatPic.find(spid);
				%>
				<tr>
					<td  ><%=i%>:&nbsp;<%=spobj.getPicname()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#" onclick="f_delete('<%=spid%>');">删除</a>
					</td>
				</tr>
				<%
					}
				%>
				<tr>
                <td>上传示意图：<input type="file" name="file"   onchange='form1.submit();' ></td>
				</tr>
			</table>
 <input type="button" value="关闭"  onClick="f_x();">
		</form>

</body>
</html>
