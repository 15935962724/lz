<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/Hostel");
java.text.DateFormat df=java.text.DateFormat.getDateInstance();


String strid=request.getParameter("id");



StringBuffer sb =new StringBuffer();
int subject=0;
String tmp=request.getParameter("subject");
if(tmp!=null&&tmp.length()>0)
{
  subject=Integer.parseInt(tmp);
  sb.append(" AND Node.node="+tmp);
}
String kipdate=request.getParameter("kipdate");
if(kipdate!=null&&kipdate.length()>0)
{
  sb.append(" AND destinedate>="+DbAdapter.cite(kipdate));
}
String leavedate=request.getParameter("leavedate");
if(leavedate!=null&&leavedate.length()>0)
{
  sb.append(" AND destinedate <="+DbAdapter.cite(leavedate));
}

int roomprice=-1;
tmp=request.getParameter("roomprice");
if(tmp!=null &&tmp.length()>0)
{
  roomprice=Integer.parseInt(tmp);
  sb.append(" AND roomprice ="+roomprice);
}

int state=-1;
tmp=request.getParameter("state");
if(tmp!=null &&tmp.length()>0)
{
  state=Integer.parseInt(tmp);
  sb.append(" AND state ="+tmp);
}








%>
<html>
<head>
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
</head >
<body>

<h1><%=r.getString(teasession._nLanguage, "Auditing")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form action="?" name="p">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=strid%>"/>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td  nowrap="nowrap">日期:
        <input name="kipdate" type=text size="10" value="<%if(kipdate!=null)out.print(kipdate);%>"><img src="/tea/image/public/Calendar.gif" style="cursor:hand" align="absmiddle" width="34" height="21" onClick="showCalendar('p.kipdate')"> ---
        <input name="leavedate" size="10" value="<%if(leavedate!=null)out.print(leavedate);%>"><img src="/tea/image/public/Calendar.gif" style="cursor:hand"  align="absmiddle" width="34" height="21" onClick="showCalendar('p.leavedate')">　

        酒店:
        <select name="subject" onChange="fchange()">
          <option value="">------------------</option>
          <%
            StringBuffer script=new StringBuffer();
            java.util.Enumeration enumeration= Node.findByType(48,node.getCommunity());
            while(enumeration.hasMoreElements())
            {
              int id=((Integer)enumeration.nextElement()).intValue();
              Node node_temp=Node.find(id);
              out.print("<option value="+id);
              if(id==subject)
              out.print(" selected ");
              out.print(">"+node_temp.getSubject(teasession._nLanguage));
              ///// 房型////////
              script.append("\r\n case '"+id+"':\r\n");
              java.util.Enumeration rp_enumeration= RoomPrice.findByNode(id);
              while(rp_enumeration.hasMoreElements())
              {
                int rp_id=((Integer)rp_enumeration.nextElement()).intValue();
                RoomPrice rp=RoomPrice.find(rp_id);
                script.append("p.roomprice.add(new Option(\""+rp.getRoomtype(teasession._nLanguage)+"\","+rp_id+"));");
              }
              script.append("break;");
            }
            %>
        </select>
        房型:
        <select name="roomprice">
          <option value="">------------------</option>
        </select>
        <script type="">
          function fchange()
          {
            while(p.roomprice.length>1)
            {
              p.roomprice[1]=null;
            }
            switch(p.subject.value)
            {
              <%=script%>
            }
          }
          fchange();
          <%
          if(roomprice!=-1)out.print("p.roomprice.value="+roomprice);
          %>
          </script>
        状态:
        <select name="state">
          <option value="">------------</option>
          <%
          for(int i=0;i<Destine.STATE.length;i++)
          {
            out.print("<option value="+i);
            if(state==i)
            out.print(" selected ");
            out.print(">"+r.getString(teasession._nLanguage, Destine.STATE[i]));
          }
          %>
        </select>
        <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
      </td>
    </tr>
  </table>
</form>

<h2>列表</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetrss">
    <td width="1">&nbsp;</td>
    <td>日期/编号</TD>
    <td>酒店/房型</TD>
    <td>数量</TD>
    <td>入住人数</TD>
    <td>联系方式</TD>
    <td>联系人</TD>
    <td>入住日期</TD>
    <td>离开日期</TD>
    <td>状态</TD>
    <td>操作</TD>
  </tr>
  <%

  DbAdapter dbadapter =new DbAdapter();
  try
  {
  int language=teasession._nLanguage;
  dbadapter.executeQuery("SELECT DISTINCT Node.node,Destine.destine FROM Destine,Node WHERE Node.community="+dbadapter.cite(node.getCommunity())+" AND Node.node=Destine.node "+sb.toString());
  for(int i=1;dbadapter.next();i++)
  {
    int n_id=dbadapter.getInt(1);
    int d_id=dbadapter.getInt(2);
    Node node_temp=Node.find(n_id);
    Destine d=Destine.find(d_id);
    RoomPrice rp_enumer= RoomPrice.find(d.getRoomprice());
    %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=i%></td>
    <td><A href="/jsp/type/hostel/DestineView.jsp?node=<%=teasession._nNode%>&roomprice=<%=d.getRoomprice()%>&destine=<%=d.getDestine()%>"><%=d.getDestinedateToString()+" / "+d_id%></A></td>
    <td><a href="/servlet/Hostel?node=<%=node_temp._nNode%>"><%= node_temp.getSubject(teasession._nLanguage)%></A> / <%=rp_enumer.getRoomtype(teasession._nLanguage)%></td>
    <td><%=d.getRoomcount()%></td>
    <td><%=d.getHumancount()%></td>
    <td><%
              String phone=d.getLinkmanhandset();
              if(phone==null||phone.length()==0)
              phone=d.getLinkmanphone();
              out.print(phone);
              %>
    </td>
    <td><%=d.getLinkmanname(teasession._nLanguage)%></td>
    <td><%=d.getKipdateToString()%></td>
    <td><%=d.getLeavedateToString()%></td>
    <td><a href="/servlet/EditDestine?node=<%=teasession._nNode%>&destine=<%=d.getDestine()%>&state=ON"><%=r.getString(teasession._nLanguage,Destine.STATE[d.getState()])%></a></td>
    <td><input type="submit" onClick="location='/jsp/type/hostel/EditDestine.jsp?node=<%=teasession._nNode%>&destine=<%=d.getDestine()%>&roomprice=<%=d.getRoomprice()%>&edit=ON';" value="<%=r.getString(teasession._nLanguage,"Edit")%>">
      <input type="submit" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDeleteTree")%>')){window.open('/servlet/EditDestine?node=<%=teasession._nNode%>&destine=<%=d.getDestine()%>&delete=ON','_self')}" value="<%=r.getString(teasession._nLanguage,"Delete")%>">
      <input type="submit" onClick="location='/servlet/EditDestine?node=<%=teasession._nNode%>&destine=<%=d.getDestine()%>&auditing=ON';" value="<%=r.getString(teasession._nLanguage,"Auditing")%>"></td>
  </tr>
  <%}
  }finally
  {
    dbadapter.close();
  }%>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
