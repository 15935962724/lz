<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.node.*" %><%

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Http h=new Http(request);
Resource r = new Resource();
r.add("/tea/resource/Golf");

int count = GolfSite.count(teasession._strCommunity," and node = "+teasession._nNode);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/lightbox.js" type="text/javascript"></script>
<link href="/tea/lightbox.css" rel="stylesheet" type="text/css" />
</head>

<body>
<script>
	function f_sub(igd,igd2)
	{
		 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:657px;dialogHeight:400px;';
		 var url = '/jsp/type/golf/EditGolfSite.jsp?node='+igd+'&t='+new Date().getTime()+'&nexturl='+location.href+'&gsid='+igd2;
		 var rs = window.showModalDialog(url,self,y);

		 if(rs==1)//添加或修改成功以后
		 {
			 location.reload();
		 }
	}
	function f_delete(igd)
	{
		if(confirm('你确定要删除数据?'))
		{
				form1.action='/servlet/EidtGolfSite';
				form1.act.value='delete';
				form1.nexturl.value=location.pathname+location.search;
				form1.gsid.value=igd;
	    		form1.submit();
		}
	}
	function f_fqt(igd)
	{
		 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:657px;dialogHeight:400px;';
		 var url = '/jsp/type/golf/GolfTee.jsp?community='+form1.community.value+'&nexturl='+location.href+'&gsid='+igd;
		 var rs = window.showModalDialog(url,self,y);

		 if(rs==1)//添加或修改成功以后
		 {
			 location.reload();
		 }
	}
</script>
<h1>球场场地管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>
列表 &nbsp;<%=Node.find(teasession._nNode).getSubject(teasession._nLanguage) %>共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;个场地&nbsp;
<input type="button" value="添加场地" onclick="f_sub('<%=teasession._nNode %>','0');">&nbsp;
<input type="button" value="返回" onclick="window.open('<%=teasession.getParameter("nexturl") %>','_self');">

</h2>
<form name="form1" action="?">
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" >
<input type="hidden" name="act" >
<input type="hidden" name="gsid" >



<%

	Enumeration e = GolfSite.find(teasession._strCommunity," and node = "+teasession._nNode,0,100);
if(!e.hasMoreElements()){

	out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
	out.print("<tr onmouseover=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' >");
	out.print("<td colspan=10>暂无场地，请点击上面的添加场地按钮</td>");
	out.print("</tr>");
	out.print("</table>");
}
int is =1;
	while(e.hasMoreElements())
	{
		int gsid = ((Integer)e.nextElement()).intValue();
		GolfSite obj = GolfSite.find(gsid);

%>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
	 	<td colspan="10">
		 	<b>
		 	<font color="red"><%=is %>、</font>场地名称</b>：<font color="red"><%=obj.getGsname() %></font>&nbsp;&nbsp;&nbsp;&nbsp;
		 	<b>场地序号：</b><font color="red"><%=obj.getSeq()%></font>&nbsp;&nbsp;&nbsp;&nbsp;
		 	<input type="button" value="编辑场地" onclick="f_sub('<%=teasession._nNode %>','<%=gsid %>');">&nbsp;
		 	<input type="button" value="发球台" onclick="f_fqt('<%=gsid %>');">&nbsp;
		 	<input type="button" value="删除场地" onclick="f_delete('<%=gsid %>');">&nbsp;
	 	</td>
 	</tr>
 	<tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
 	  <td nowrap="nowrap">洞号：</td>
    <%

    for(int i=0;i<9;i++){
    	out.print("<td>"+(i+1)+"H ");
    }

 int x=0;

    %>
    <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td><%=r.getString(teasession._nLanguage, "Standard")%>：</td>
<%
      for(int index=x;index<9+x;index++)
      {
	      out.print("<td>"+obj.getStandard((index+1))+"</td>");

      }
      %>
    <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
      <td nowrap="nowrap">码数：</td>
      <%
      for(int index=x;index<9+x;index++)
      out.print("<td>"+obj.getYardage((index+1))+"</td>");
      %>
  <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
        <td nowrap="nowrap">球洞图：</td>
        <%
        for(int index=x;index<9+x;index++)
        {
          String hole=obj.getHole((index+1));
          out.print("<td>");
          if(hole!=null&&hole.length()>0)
          {
            out.println("<a  href='"+hole+"' rel='lightbox'   style='cursor:pointer'>查看球洞图</a>");
          }else{
        	  out.print("无");
          }
          out.print("</td>");
        }  %>
      </tr>
      <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
        <td nowrap="nowrap">果岭经纬度：</td>
	         <%
	      for(int index=x;index<9+x;index++)
	      out.print("<td>"+obj.getLatlong((index+1))+"</td>");
      %>
      </tr>
    </table>
<%
is++;
	} %>



</form>


</body>
</html>
