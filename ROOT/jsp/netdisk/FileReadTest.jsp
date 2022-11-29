<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.db.*"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int filecenter = Integer.parseInt(teasession.getParameter("bullid"));
FileCenter obj=FileCenter.find(filecenter);
int purview=FileCenterSafety.findByMember(filecenter,teasession._rv._strV);
%>
<html>
<head>
<title>
FileYNread
</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body bgcolor="#ffffff">
<h1>察看阅读情况</h1>
<table align="center" id="tablecenter" border="0" cellpadding="0" cellspacing="0">
  <tr>


  <td align="center" width="50%"><b>已阅<%=purview %></b></td>
  <td align="center" width="50%"><b>未阅</b></td>
</tr>
<%
Enumeration e=FileCenterSafety.findByFileCenter(filecenter);
for(int j=1;e.hasMoreElements();j++)
{
  int id=((Integer)e.nextElement()).intValue();
  FileCenterSafety s=FileCenterSafety.find(id);
  if(s.getPurview(obj.getPath())==1){
    String[] unit = s.getUnit().split("/");
    for(int i = 1; i < unit.length; i++){
      Enumeration enumer =tea.entity.admin.AdminUnitSeq.findByCommunity(teasession._strCommunity,Integer.parseInt(unit[i]),true);
      if(enumer.hasMoreElements()){
        out.print("<tr><td colspan=2 bgcolor=#F5F5F5>"+Bulletin.unitName(Integer.parseInt(unit[i]))+"</td></tr>");
        out.print("<tr><td>");
        int m = 1, p = 0;
        while(enumer.hasMoreElements())
        {
          String _member = (String)enumer.nextElement();
          if(Bulletin.showYreadPer(_member,filecenter)){
            if(j%4 == 0){
              out.print(_member+Bulletin.readDate(_member)+"<br/>");
            }else{
              out.print(_member+Bulletin.readDate(_member)+"　");
            }
            p++;
          }


          m++;
        }
        if(p == 0){
          out.print("　");
        }
        out.print("</td><td>"); Enumeration enumer1 =tea.entity.admin.AdminUnitSeq.findByCommunity(teasession._strCommunity,Integer.parseInt(unit[i]),true);
        int k = 1, q = 0;
        while(enumer1.hasMoreElements())
        {
          String _member = (String)enumer1.nextElement();
          if(Bulletin.showNreadPer(_member,filecenter)){
            if(k%7 == 0){
              out.print(_member+"<br/>");
            }else{
              out.print(_member+"　");
            }
            q++;
          }
          k++;
        }
        if(q == 0){
          out.print(" ");
        }
        out.print("</td></tr>");
      }
    }
  }
}
%>
<tr>
  <td colspan="2" align="center"><input type="button" value="返回" onclick="javascript:history.back();"/></td>
</tr>
</table>
</body>
</html>
<script language="JavaScript">
 anole('',1,'white','white','#BCD1E9','');
 /*tr_tableid, // table id
 num_header_offset,// 表头行数
 str_odd_color, // 奇数行的颜色
 str_even_color,// 偶数行的颜色
 str_mover_color, // 鼠标经过行的颜色
 str_onclick_color // 选中行的颜色
 */
</script>

