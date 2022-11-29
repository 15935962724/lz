<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*,tea.entity.node.*"%>
<%@page import="tea.entity.site.*,tea.db.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="java.text.*"%>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null) {
     response.sendRedirect("/servlet/Node?node=14856&language=1");
    return;
   }



  StringBuffer param = new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql = new StringBuffer();
  String strid=request.getParameter("id");
  param.append("&id=").append(strid);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<h1>我的评论</h1>
<FORM name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
  <td>酒店</td>
    <td>主题</td>
    <td>时间</td>
    <td>创建者</td>
    <td>回复</td>
    <td>操作</td>
  </tr>
  <%
     java.util.Enumeration e = Talkback.findEdNodes3(teasession._rv,0,Integer.MAX_VALUE);
     while(e.hasMoreElements()){
     int id = ((Integer)e.nextElement()).intValue();
     Talkback t = Talkback.find(id);
     %>

     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td><%=t.fHostel(t.getNode()) %></td>
      <td> <A HREF="/jsp/talkback/Talkback.jsp?node=<%=t.getNode()%>&talkback=<%=id%>&h=h" ID=TalkbackIndex>
        <%=t.getAnchor(teasession._nLanguage)%></a></td>
       <td><%=t.getTimeToString()%> </td>
       <td><%=t.getCreator()._strR%> </td>
       <TD> <%=TalkbackReply.countByTalkback(id)%></TD>
       <td>
         <INPUT TYPE=BUTTON VALUE="编辑" ID="CBEdit" CLASS="CB" onClick="window.open('/jsp/talkback/EditTalkback.jsp?node=<%=t.getNode()%>&Talkback=<%=id%>&nexturl=<%=request.getRequestURL()%>&h=h', '_self');">
           <INPUT TYPE=BUTTON  name="Delete" VALUE="删除" ID="CBDelete" CLASS="CB" onClick="if(confirm('您确实要删除次内容吗?')){window.open('/servlet/DeleteTalkback?node=<%=t.getNode()%>&Talkback=<%=id%>&Delete=ON&nexturl=<%=request.getRequestURL()%>&h=h', '_self'); this.disabled=true; };">
       </td>
     </tr>

     <%} %>
</table>
</form>
  <script language="JavaScript">
 anole('',1,'#F2F2F2','#DEEEDB','','');
  /*tr_tableid, // table id
  num_header_offset,// 表头行数
  str_odd_color, // 奇数行的颜色
  str_even_color,// 偶数行的颜色
  str_mover_color, // 鼠标经过行的颜色
  str_onclick_color // 选中行的颜色
  */
  </script>
</body>
</html>
</html>
