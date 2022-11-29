<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=request.getParameter("id");
StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(menuid);

StringBuffer sql=new StringBuffer();

String labname=request.getParameter("labname");
if(labname!=null&&(labname=labname.trim()).length()>0)
{
  sql.append(" AND labname in (select member from Profilelayer where lastname like "+DbAdapter.cite("%"+labname+"%")+" or firstname like "+DbAdapter.cite("%"+labname+"%")+")");
  param.append("&labname="+java.net.URLEncoder.encode(labname,"UTF-8"));
}

String card=request.getParameter("card");
if(card!=null&&(card=card.trim()).length()>0)
{
  sql.append(" AND card in (select card from Profile where card like "+DbAdapter.cite("%"+card+"%")+")");
  param.append("&card="+java.net.URLEncoder.encode(card,"UTF-8"));
}

String time_s=request.getParameter("time_s");
if(time_s!=null&&(time_s=time_s.trim()).length()>0)
{
  sql.append(" AND changetime <=").append(DbAdapter.cite(time_s));
  param.append("&time_s="+java.net.URLEncoder.encode(time_s,"UTF-8"));
}

String time_j=request.getParameter("time_j");
if(time_j!=null&&(time_j=time_j.trim()).length()>0)
{
  sql.append(" AND changetime >=").append(DbAdapter.cite(time_j));
  param.append("&time_j="+java.net.URLEncoder.encode(time_j,"UTF-8"));
}

int count=Laborage.count(teasession._strCommunity,sql.toString());

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);


sql.append(" ORDER BY times desc  ");

%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
  </head>

  <script >
  function editimd(igd)
  {
    form1.laborage.value=igd;
    form1.action='/jsp/admin/laborage/EditLaborage.jsp';
    form1.submit();
  }
  function deleteimd(igd)
  {
    if(confirm('您确认要删除！'))
    {
      form1.laborage.value=igd;
      form1.act.value="delete";
      form1.action='/servlet/EditLaborage';
      form1.submit();
    }
  }

  function kind()
  {
    var m=0;
    flag=false;
    if(form1.lab.length)
    {
      for(i=0;i<form1.lab.length;i++)
      {
        if(form1.lab[i].checked)
        {
          flag=true;
          m++;
        }
      }
      if(!flag)
      {
        alert("你没有选中任何数据");
        return false;
      }
    }else
    {
      if(!form1.lab.checked)
      {
        alert("你没有选中任何数据");
        return false;
      }
    }

    //  return false;
    form1.act.value="kind";
    form1.action='/servlet/EditLaborage';
    form1.submit();
  }
  function CheckAll(){
	  var checkname=document.getElementsByName("checkall");   
	  var fname=document.getElementsByName("lab");
	  var lname=""; 
	  if(checkname[0].checked){
	      for(var i=0; i<fname.length; i++){ 
	        fname[i].checked=true; 
	  }   
	  }else{
	     for(var i=0; i<fname.length; i++){ 
	        fname[i].checked=false; 
	     } 
	  }
	  }
  </script>
  <body>

  <h1>员工工资管理</h1>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
    <h2>查询</h2>
    <form name=form1 METHOD=post  action="?">
      <input type="hidden" name="act" />
      <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>">
      <input type="hidden" name="laborage" />
      <input type="hidden" name="id" value="<%=menuid%>">
      <input type="hidden" name="files" value="importkind">
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
          <td>姓名<input type="text" style="width:80" name="labname" value="<%if(labname!=null)out.print(labname);%>"></td>
          <td>身份证号<input type="text" style="width:80" name="card" value="<%if(card!=null)out.print(card);%>"></td>
          <td>日期

         <input name="time_s" size="10"  value="<%if(time_s!=null)out.print(time_s);%>"><A href="###"><img onClick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
        -<input name="time_j" size="10"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onClick="showCalendar('form1.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>

          </td>
          <td><input type="submit" value="查询"/></td>
       </tr>
       </table>

      <h2>列表</h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

        <tr id="tableonetr">
         <td nowrap>序号</td>
          <td nowrap><input type="checkbox" name="checkall" onclick="CheckAll('lab','checkall')" /></td>
           <td nowrap>转账时间</td>
          <td nowrap>身份证号</td>
          <td nowrap>姓名</td>
          <td nowrap>部门</td>
          <td nowrap>人员类型</td>
          <td nowrap>出勤天数</td>
          <td nowrap >操作</td>
        </tr>
        <%
        java.util.Enumeration e = Laborage.find(teasession._strCommunity,sql.toString(),pos,10);
        for(int i=1;e.hasMoreElements();i++){

          int laborage = ((Integer)e.nextElement()).intValue();
          Laborage obj = Laborage.find(laborage);
          AdminUnit auobj = AdminUnit.find(obj.getBranch());
          AdminRole roobj = AdminRole.find(obj.getRole());
          Profile p = Profile.find(obj.getLabname());

          %>
          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">

            <td width="20" align="center" ><%=i%> </td>
              <td width="20" align="center"><input type="checkbox" name="lab" value="<%=laborage%>"/></td>
              <td align="center" ><%=obj.getChangetimeToString()%> </td>
              <td align="center" ><%=obj.getCard()%> </td>
              <td align="center" ><a href="/jsp/admin/laborage/showlaborage.jsp?laborage=<%=laborage%>" target="_blank"><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)%></a></td>
              <td align="center" ><%=auobj.getName()%></td>
              <td align="center" ><%=roobj.getName()%></td>
              <td align="center" ><%=obj.getDays()%></td>


              <td align="center" ><input  type ="button"  value="编辑" onClick="editimd('<%=laborage%>');">
                <input type=button value="删除"  onClick="deleteimd('<%=laborage%>');">            </td>
          </tr>
          <%
          }
          %>
          <tr><td>&nbsp;</td>
            <td colspan="8" >

<%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td>
          </tr>
      </table>

      <br>
      <input  type ="button" name="" value="添加员工工资" onClick="editimd(0);">
      <input  type ="button" name="" value="导出Excel" onClick="kind(0);">
</form>
<!--<input  type ="button" name="newbulletin" value="全部删除" onClick="if(confirm('确定删除?'))location='/jsp/admin/fileendorse/EditFileendorse.jsp';"  >-->

  <div id="head6"><img height="6" src="about:blank"></div>

  </body>
</HTML>



