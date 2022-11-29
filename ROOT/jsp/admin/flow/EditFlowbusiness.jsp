<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));
int flowitem=0;
if(teasession.getParameter("flowitem")!=null && teasession.getParameter("flowitem").length()>0)
{
  flowitem = Integer.parseInt(request.getParameter("flowitem"));
}
if(request.getMethod().equals("POST")||request.getParameter("delete")!=null)
{
  if(request.getParameter("delete")!=null)
  {
    Flowbusiness obj=Flowbusiness.find(flowbusiness);
    obj.delete();
  }else
  {
    int flow=Integer.parseInt(request.getParameter("flow"));
    String name=request.getParameter("name");
    String content=request.getParameter("content");
    java.util.Date ftime=Flowitem.sdf.parse(request.getParameter("ftimeYear")+"-"+request.getParameter("ftimeMonth")+"-"+request.getParameter("ftimeDay"));
    if(flowbusiness==0)
    {
      Flowbusiness.create(teasession._strCommunity,flowitem,flow,0,ftime,false,teasession._rv.toString(),teasession._nLanguage,name,content);
    }else
    {
      Flowbusiness obj=Flowbusiness.find(flowbusiness);
      obj.set(flowitem,ftime,teasession._nLanguage,name,content);
    }
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}


Resource r=new Resource();

String name=null,content=null;
int flow=-1;
java.util.Date ftime=null;
if(flowbusiness!=0)
{
  Flowbusiness obj=Flowbusiness.find(flowbusiness);
  name=obj.getName(teasession._nLanguage);
  content=obj.getContent(teasession._nLanguage);
  flow=obj.getFlow();
  ftime=obj.getFtime();
}else
{
  name=content="";
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function defaultfocus()
{
  form1.name.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>流程创建</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<BR>
<form name="form1" action="<%=request.getRequestURI()%>" method="post" onSubmit="return submitText(this.flow, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-流程名称')&&submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-工作事务名称')">
<input type=hidden name="flowbusiness" value="<%=flowbusiness%>"/>
<input type=hidden name="flowitem" value="<%=flowitem%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

       <tr>
         <td>流程名称</td>
         <td nowrap><select name="flow">
         <option value="">------------</option>
           <%
           java.util.Enumeration enumer=Flow.find(community,"");
           while(enumer.hasMoreElements())
           {
             int flow_id=((Integer)enumer.nextElement()).intValue();
             out.print("<option value="+flow_id);
             if(flow_id==flow)
             out.println(" SELECTED ");
             out.println(" >"+Flow.find(flow_id).getName(teasession._nLanguage));
           }
           %></select>
         </td>
       </tr>
       <tr>
       <tr>
        <td>工作事务名称</td>
         <td nowrap><input name="name" type="text" value="<%=name%>" size="40"></td>
       </tr>
              <tr>
        <td>工作事务说明</td>
         <td nowrap><textarea cols="30" name="content" rows="4"><%=content%></textarea></td>
       </tr>
              <tr>
         <td>预计完成时间</td>
         <td nowrap><%=new tea.htmlx.TimeSelection("ftime", ftime)%>
         </td>
       </tr>
  </table>
   <input type="submit" value="提交">
  <input type="reset" value="重置" onClick="defaultfocus();">
    <input type="button" value="返回" onClick="history.back();">
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>



