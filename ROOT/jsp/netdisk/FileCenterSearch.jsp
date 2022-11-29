<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/NetDisk");

String path="/";
int base=Integer.parseInt(request.getParameter("base"));
//if(base>0)
//{
//  FileCenter fc=FileCenter.find(base);
//  str=fc.getPath();
//}

int filecenter=Integer.parseInt(request.getParameter("filecenter"));
FileCenter fc=FileCenter.find(filecenter);
path=fc.getPath();

//获取第二级的ID
String str[]=path.split("/");
if(str.length>3)
{
  filecenter=Integer.parseInt(str[2]);
}

%><HTML>
  <HEAD>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</HEAD>
<body>

<h1><%=r.getString(teasession._nLanguage, "文件搜索")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="/jsp/netdisk/FileCenters.jsp">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act" value="search">
<input type="hidden" name="base" value="<%=filecenter%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" style="line-height:22px">
  <tr>
    <td>选择目录</td>
    <td>
    <select name="filecenter">
    <option value="<%=filecenter%>">---------------</option>
    <%
    Enumeration e=FileCenter.find(teasession._strCommunity," AND type=0 AND father="+filecenter,null,false);//
    while(e.hasMoreElements())
    {
      int id=((Integer)e.nextElement()).intValue();
      int purview=FileCenterSafety.findByMember(id,teasession._rv._strV);
      if(purview!=-1)
      {
        fc=FileCenter.find(id);
        String p=fc.getPath();
        out.print("<option value="+id);
//        if(id==filecenter)
//        {
//          out.print(" selected ");
//        }
        out.print(">"+fc.getSubject());//fc.getAncestor(-1)
      }
    }
    %>
    </select></td></tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%></td>
    <td><input name="q" size="40"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "内容")%></td>
    <td><input name="content" size="40"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "FileCenter.code")%></td>
    <td><input name="code" size="40"></td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage, "FileCenter.unit")%></td>
    <td>
      <select name="unit">
        <option value="" >--------------------------</option>
        <%
        Enumeration e_u=FileCenterUnit.findNameByCommunity(teasession._strCommunity);
        while(e_u.hasMoreElements())
        {
          String unit=(String)e_u.nextElement();
          out.print("<option value="+unit+">"+unit);
        }
        %>
        </select>
    </td>
  </tr>
  <tr class="FileCenter_adminunit">
    <td><%=r.getString(teasession._nLanguage, "部室")%></td>
    <td>
      <select name="adminunit">
        <option value="">--------------------------</option>
        <%
        Enumeration au_enumer=AdminUnit.findByCommunity(teasession._strCommunity,"");
        while(au_enumer.hasMoreElements())
        {
          AdminUnit _au=(AdminUnit)au_enumer.nextElement();
          int id=_au.getId();
          out.print("<option value="+id);
//          if(adminunit==id)
//          out.print(" selected ");
          out.println(" >"+_au.getPrefix()+_au.getName());
        }
        %>
        </select>
    </td>
  </tr>
  <tr>
    <td >修改时间:</td><td>
      <input type="text" name="time0" readonly size="11"><input type="button" value="..." onClick="showCalendar('form1.time0')"/>
      <input type="text" name="time1" readonly size="11"><input type="button" value="..." onClick="showCalendar('form1.time1')"/>
    </td>
  </tr>
  <tr style="display:none">
    <td>文件大小:</td><td>
      <input type="text" name="size0" size="5">
      -
      <input type="text" name="size1" size="5">
    K    </td></tr>
  <tr>
    <td>下发日期</td>
    <td>
    <select name="year">
    <%
    int year=Calendar.getInstance().get(Calendar.YEAR);
    for(int i=2000;i<2020;i++)
    {
      out.print("<option value="+i);
      if(year==i)out.print(" selected=''");
      out.print(">"+i);
    }
    %></select></td>
  </tr>
</table>
<input type="submit" value="搜索">
<input type="button" value="返回" onclick="history.back();">
</form>

</body>
</html>
