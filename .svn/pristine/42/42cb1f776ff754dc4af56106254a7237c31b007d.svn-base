<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/jsp/include/ShowMax.jsp" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.resource.Resource" %>
<%@page import="java.io.*" %>
<%@page import="tea.entity.netdisk.*"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int filecenter = Integer.parseInt(teasession.getParameter("bullid"));

int root=AdminUnit.getRootId(teasession._strCommunity);
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
          <td align="center" width="50%"><b>已阅</b></td>
                   <td width="50%"  align="center"><b>未阅</b></td>
</tr>
<%
sequence=0;
tree(out,teasession._strCommunity,root,teasession._nLanguage,0,filecenter);
%>

<tr>

  <td colspan="4" align="center"><input type="button" value="返回" onclick="javascript:history.back();"/></td>
  </tr>
</table>
</body>
</html>
<%!
int sequence;
Resource r;
public void tree(Writer out,String community,int father,int language,int setp,int filecenter)throws Exception
{
 Enumeration e=FileCenterSafety.findByFileCenter(filecenter);
  for(int j=0;e.hasMoreElements();j++)
  {
    int id=((Integer)e.nextElement()).intValue();
    FileCenterSafety s=FileCenterSafety.find(id);

    StringBuffer name=new StringBuffer();
    StringBuffer member = new StringBuffer();
    for(int i=1;i<setp;i++)
    {
      name.append("　");
    }
    if(setp>0)
    {
    	name.append(" ├─");
    }
    name.append(s.getUnitToHtml());
int x=1,z = 1;
       out.write("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.write("<td><b>"+name.toString()+ "</b></br>");
   Enumeration e1=tea.entity.admin.AdminUnitSeq.findByCommunity(community,id,true);
   while(e1.hasMoreElements()){
           String _member = (String)e1.nextElement();
    if(Bulletin.showYreadPer(_member,filecenter)){
      if(z%3 == 0){
        out.write(_member+Bulletin.readDate(_member)+"</br>");
      }else if(z%3==1){
        out.write("　　　　"+_member+Bulletin.readDate(_member)+"　");
      }
      else{
        out.write(_member+Bulletin.readDate(_member)+"　");
      }
      z++;
    }
          }
          out.write("</td>");
    out.write("<td><b>"+name.toString()+ "</b></br>");
       Enumeration e2=tea.entity.admin.AdminUnitSeq.findByCommunity(community,id,true);
 while(e2.hasMoreElements()){
           String _member = (String)e2.nextElement();
    if(Bulletin.showNreadPer(_member,filecenter)){
      if(x%7==1){
        out.write("　　　　"+_member+" ");
      }else if(x%7==0){
        out.write(_member+"</br>");
      }else{
        out.write(_member+"　");
      }
      x++;
    }
          }

    tree(out,community,id,language,setp+1,filecenter);
  }
}
%>
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
