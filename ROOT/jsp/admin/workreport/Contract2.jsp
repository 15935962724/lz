<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*"  %><%@ page  import="tea.entity.admin.*" %><%@ page  import="tea.htmlx.*" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.admin.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
if("workproject".equals(teasession.getParameter("act")))
{
  int workproject = 0;
  if(teasession.getParameter("workproject")!=null && teasession.getParameter("workproject").length()>0)
  {
   workproject= Integer.parseInt(teasession.getParameter("workproject"));
  }
  int flowitem = 0;
  if(teasession.getParameter("flowitem")!=null && teasession.getParameter("flowitem").length()>0)
  {
    flowitem= Integer.parseInt(teasession.getParameter("flowitem"));
  }

  java.util.Enumeration e = Flowitem.find(teasession._strCommunity," AND type = 0 AND workproject="+workproject,0,Integer.MAX_VALUE);
  out.print("<select name=flowitem>");
  out.print(" <option value=0>请选择项目</option>");
  while(e.hasMoreElements())
  {
    int fid=((Integer)e.nextElement()).intValue();
    Flowitem fobj = Flowitem.find(fid);
    out.print("<option value="+fid);
    if(flowitem==fid)
    {
      out.print(" SELECTED ");
    }
    out.print(">"+fobj.getName(teasession._nLanguage));
    out.print("</option>");
  }
  out.print("</select>");
  return;
}

String nexturl = request.getParameter("nexturl");
String community=teasession._strCommunity;

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body >
<script type="">
function f_w(igd)
{
  sendx("?act=workproject&workproject="+form1.workproject.value+"&id="+form1.id.value+"&flowitem="+igd,
  function(data)
  {
    document.getElementById('show').innerHTML=data;
  }
  );
}
function f_x(igdnexturl)
{
  if(form1.workproject.value==0)
  {
    alert('请先选择客户才能创建项目！');
    form1.workproject.focus();
    return false;
  }
  window.open('/jsp/admin/workreport/EditFlowitem.jsp?community='+form1.community.value+'&contractnexturl='+form1.contractnexturl.value+'&workproject='+form1.workproject.value+'&nexturl='+igdnexturl,'_self');
}
function f_submit()
{
  if(form1.workproject.value==0)
  {
    alert('请选择客户！');
    form1.workproject.focus();
    return false;
  }
  if(form1.flowitem.value==0)
  {
    alert('请选择项目！');
    form1.flowitem.focus();
    return false;
  }
}
function f_ck()
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:757px;dialogHeight:550px;';
  var url = '/jsp/admin/workreport/wquery.jsp'
  var rs=  window.showModalDialog(url,self,y);
  if(rs!=null){
    form1.workproject.value = rs;
    f_w(rs);
  }
}
function f_xm()
{
  if(form1.workproject.value==0)
  {
    alert("请先选择客户！");
    form1.workproject.focus();
    return false;
  }
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:757px;dialogHeight:550px;';
  var url = '/jsp/admin/workreport/wquery2.jsp?workproject='+form1.workproject.value
  var rs=  window.showModalDialog(url,self,y);
  if(rs!=null)
  {
    form1.workproject.value = rs.split("/")[1];
    form1.flowitem.value = rs.split("/")[2];

  }
}
</script>

<h1>请选择客户和客户项目</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <form name=form1 method="GET" action="/jsp/admin/workreport/EditFlowitem.jsp" onsubmit="return f_submit();">
    <input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>
    <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
    <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
    <input type="hidden" name="contractnexturl" value="<%=nexturl%>"/>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td>
          <select name="workproject" onchange="f_w('');">
            <option value="0">请选择客户</option>
            <%
            java.util.Enumeration we =   Workproject.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
            while(we.hasMoreElements())
            {
              int wid = ((Integer)we.nextElement()).intValue();
              Workproject wobj =   Workproject.find(wid);
              out.print("<option value="+wid);
              //             if(workproject==wid)
              //             {
                //               out.print(" SELECTED ");
                //             }
                out.print(">"+wobj.getName(teasession._nLanguage));
                out.print("</option>");
              }
              %>
              </select>&nbsp;&nbsp;
              <input type="button" value="查找客户" onclick="f_ck();">
        </td>
        <td><input type="button" value="创建客户"  onclick="window.open('/jsp/admin/workreport/EditWorkproject.jsp?community=<%=community%>&workproject=0&nexturl=<%=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getContextPath(),"UTF-8")%>','_self');" ></td>
      </tr>
        <tr>
        <td>
        <span id="show">
          <select name="flowitem">
            <option value="0">请选择项目</option>
          </select>
        </span>&nbsp;&nbsp;<input type="button" value="查找项目" onclick="f_xm();">
        </td>
          <td><input type="button" value="创建项目"   onclick="f_x('<%=request.getRequestURI()+"?"+request.getContextPath()%>');" ></td>
      </tr>
    </table>
    <br>
   <input type="submit" value="提交" >&nbsp;
   <input type=button value="返回" onClick="javascript:history.back()">
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>



