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
   String member = teasession._rv._strV;

  StringBuffer sql = new StringBuffer(" AND member="+DbAdapter.cite(member));
  StringBuffer param = new StringBuffer("?community=").append(teasession._strCommunity);

  String strid=request.getParameter("id");
  param.append("&id=").append(strid);

  String kipDateFlag = request.getParameter("kipDateFlag");
  String leaveDateFlag = request.getParameter("leaveDateFlag");
  System.out.println("kipdateflag is : "+kipDateFlag);
    System.out.println("leaveDateFlag is : "+leaveDateFlag);
  int pos=0,count=0,pageSize=10;
  if(request.getParameter("pos")!=null&&request.getParameter("pos").length()>0)
  {
    pos=Integer.parseInt(request.getParameter("pos"));
  }
  if(kipDateFlag!=null&&kipDateFlag.length()>0)
  {
    System.out.println(kipDateFlag);
    sql.append(" AND kipdate>="+DbAdapter.cite(kipDateFlag));
     System.out.println(kipDateFlag);
    param.append("&kipDateFlag=").append(kipDateFlag);
  }
   if(leaveDateFlag!=null&&leaveDateFlag.length()>0)
  {
    sql.append(" AND leavedate<="+DbAdapter.cite(leaveDateFlag));
    param.append("&leaveDateFlag=").append(leaveDateFlag);
  }
    java.util.Enumeration e = Destine.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    count = Destine.count(teasession._strCommunity,sql.toString());
 %>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData<%=Common.CHATSET[teasession._nLanguage]%>.js"></script>
<script type="text/javascript">
function ShowCalendar(fieldname)
{
 window.showModalDialog("/jsp/registration/Calendar2.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:285px;dialogHeight:270px;dialogTop:"+200+"px;dialogLeft:"+300+"px");
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<h1>??????????????????</h1>
<FORM name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="id" value="<%=strid%>"/>
<h2>??????</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>?????????????????????
      <input class="text" readonly="readonly" type="text" maxLength="12" size="9" name="kipDateFlag" ID="Text3">
      <a href="javascript:ShowCalendar('form1.kipDateFlag')" target="_self"><img id="dimg3" style="POSITION:relative" src="/tea/image/public/Calendar2.gif" border="0" align="middle" alt=""></a>      ??????
      &nbsp;&nbsp; ??????
      <input class="text" readonly="readonly" type="text" maxLength="12" size="9" name="leaveDateFlag" ID="Text4">
      <a href="javascript:ShowCalendar('form1.leaveDateFlag')" target="_self"><img id="dimg4" style="POSITION: relative" src="/tea/image/public/Calendar2.gif" border="0" align="middle" alt=""></a>   &nbsp;&nbsp;
      <input type="submit" value=" GO "/>
    </td>
  </tr>
</table>
</form>
<h2>??????????????????(<%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>?????????</td>
    <td>??????</td>
    <td>????????????</td>
    <td>????????????</td>
    <td>?????????</td>
    <td>????????????</td>
  </tr>
  <%if(!e.hasMoreElements()){
  out.println("<tr><td colspan=6>??????????????????</td></tr>");
  }
    while (e.hasMoreElements()) {
    int destine = ((Integer)(e.nextElement())).intValue();
    Destine obj = Destine.find(destine);
    Hostel hos = Hostel.find(obj.getNode());
    Node nod = Node.find(obj.getNode());
    %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><a href="/jsp/registration/DestineView.jsp?node=<%=obj.getNode()%>&destine=<%=obj.getDestine()%>&roomprice=<%= obj.getRoomprice()%>"><%=obj.getDestine()%></a></td>
    <td><a href="/jsp/registration/HostelView.jsp?node=<%=obj.getNode()%>"><%=nod.getSubject(teasession._nLanguage) %></a></td>
    <td><%=obj.getKipdateToString() %></td>
    <td><%=obj.getLeavedateToString() %></td>
    <td><%=obj.getRoomcount() %></td>
    <td><%=hos.getPrice()%></td>
  </tr>
<%}%>
<tr>
<%if(count>pageSize){%>
  <td colspan="5" align="center">
  <%=new tea.htmlx.FPNL(1,param.toString()+"&pos=",pos,count,pageSize)%>
  </td><%}%>
</tr>
</table>
  <script language="JavaScript">
 anole('',1,'#F2F2F2','#DEEEDB','','');
  /*tr_tableid, // table id
  num_header_offset,// ????????????
  str_odd_color, // ??????????????????
  str_even_color,// ??????????????????
  str_mover_color, // ????????????????????????
  str_onclick_color // ??????????????????
  */
  </script>
</body>
</html>
</html>
