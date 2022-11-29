<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int bullid = Integer.parseInt(teasession.getParameter("bullid"));
Bulletin obj =  Bulletin.find(bullid);
String[] dep = obj.getTUnit().split("/");


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
    <td align="center" colspan="2" width="50%"><b>已阅</b></td>
    <td width="50%" colspan="2" align="center"><b>未阅</b></td>

    <%
    String[] mem= obj.getTo(teasession._nLanguage).split(";");
    if(mem.length>0){

      %>
      <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
        <td colspan="2">
        <%
         for(int i = 0; i < mem.length;i++)
    {

        int j = 1, p = 0;
        mem[i] = mem[i].replace(" ","");
        if(Bulletin.showYreadPer(mem[i],bullid)){
          if(j%3 == 0){
            out.print(mem[i]+Bulletin.readDate(mem[i], bullid)+"<br/>");
          }else{
            out.print(mem[i]+Bulletin.readDate(mem[i], bullid)+"　");
          }
          j++;




        }
        if(j == 1){
          out.print("　");
        }

    }
        %>
        </td>
        <td colspan="2">
        <%
         for(int i = 0; i < mem.length;i++)
    {
      mem[i] = mem[i].replace(" ","");
      int k = 1, q = 0;
      if(Bulletin.showNreadPer(mem[i],bullid)){
        if(k%7 == 0){
          out.print(mem[i]+"<br/>");
        }else{
          out.print(mem[i]+"　");
        }
        k++;
      }


      if(k == 1){
        out.print(" ");
      }
    }
      %>
      </td>
      </tr>

      <%

    }
    %>

    <%
    for(int i = 1; i < dep.length; i++)
    {
      Enumeration enumer =tea.entity.admin.AdminUnitSeq.findByCommunity(teasession._strCommunity,Integer.parseInt(dep[i]),true);
      if(enumer.hasMoreElements())
      {
        AdminUnit au=AdminUnit.find(Integer.parseInt(dep[i]));
        %>
        <tr>
          <td colspan="4" bgcolor="#F5F5F5"><%="<b>"+au.getName()+"</b>" %></td>
        </tr>
        <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
          <td colspan="2">
          <%


          int j = 1, p = 0;
          while(enumer.hasMoreElements())
          {
            String _member = (String)enumer.nextElement();
            Profile pro = Profile.find(_member);
            if(Bulletin.showYreadPer(_member,bullid)){
              if(j%3 == 0){
                out.print(pro.getName(1)+Bulletin.readDate(_member, bullid)+"<br/>");
              }else{
                out.print(pro.getName(1)+Bulletin.readDate(_member, bullid)+"　");
              }
              j++;
            }



          }
          if(j == 1){
            out.print("　");
          }
          %>
          </td>
          <td colspan="2">
          <%
          Enumeration enumer1 =tea.entity.admin.AdminUnitSeq.findByCommunity(teasession._strCommunity,Integer.parseInt(dep[i]),true);
          int k = 1, q = 0;
          while(enumer1.hasMoreElements())
          {
            String _member = (String)enumer1.nextElement();
            Profile pro = Profile.find(_member);
            if(Bulletin.showNreadPer(_member,bullid)){
              if(k%7 == 0){
                out.print(pro.getName(1)+"<br/>");
              }else{
                out.print(pro.getName(1)+"　");
              }
              k++;
            }

          }
          if(k == 1){
            out.print(" ");
          }
          %>
          </td>
        </tr>

        <%
        }
      }
      %>
      <tr>

        <td colspan="4" align="center" bgcolor="#F5F5F5"><input type="button" value="返回" onclick="javascript:history.back();"/></td>
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
