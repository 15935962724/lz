<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.Resource" %><%@ page import="java.io.*" %><%@ page import="java.util.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8"); response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession.getParameter("community");
String nexturl=teasession.getParameter("nexturl");

int flow=Integer.parseInt(teasession.getParameter("flow"));

if("POST".equals(request.getMethod()))
{
  String info="修改",act=request.getParameter("act");
  if("del".equals(act))
  {
    Flow obj=Flow.find(flow);
    obj.delete();
    info="删除";
  }else if("clone".equals(act))
  {
    Flow.find(flow).clone(teasession._nLanguage);
    info="复制";
  }else
  {
    int prev=Integer.parseInt(teasession.getParameter("prev"));
    int type=Integer.parseInt(teasession.getParameter("type"));
    int dynamic=Integer.parseInt(teasession.getParameter("dynamic"));
    String name=teasession.getParameter("name");
    int itemtype=-1;
    String tmp=teasession.getParameter("itemtype");
    if(tmp!=null)
    {
      itemtype=Integer.parseInt(tmp);
    }
    boolean hiddenconsign=teasession.getParameter("hiddenconsign")!=null;
    String template=null;
    byte by[]=teasession.getBytesParameter("template");
    if(by!=null)
    {
      template=TeaServlet.write(community,by,".doc");
    }else if(teasession.getParameter("clear")!=null)
    {
      template="";
    }
    int filecenter=0;
    tmp=teasession.getParameter("filecenter");
    if(tmp!=null&&tmp.length()>0)
    {
      filecenter=Integer.parseInt(tmp);
    }
    if(flow==0)
    {
      Flow.create(community,prev,type,dynamic,itemtype,hiddenconsign,filecenter,teasession._nLanguage,name,template);
    }else
    {
      Flow obj=Flow.find(flow);
      obj.set(prev,type,dynamic,itemtype,hiddenconsign,filecenter,teasession._nLanguage,name,template);
    }
  }
  out.print("<script>alert('"+info+"成功！');window.open('"+nexturl+"','_parent');</script>");
  return;
}


Resource r=new Resource();

String name=null,template=null;
int prev=0,type=-1,dynamic=-1,itemtype=-1,filecenter=0;
boolean hiddenconsign=false;
int len=0;
if(flow!=0)
{
  Flow obj=Flow.find(flow);
  prev=obj.getPrev();
  name=obj.getName(teasession._nLanguage);
  type=obj.getType();
  dynamic=obj.getDynamic();
  itemtype=obj.getItemtype();
  hiddenconsign=obj.isHiddenConsign();
  template=obj.getTemplate(teasession._nLanguage);
  if(template!=null&&template.length()>0)
  {
    len=(int)new File(application.getRealPath(template)).length();
  }
  filecenter=obj.getFilecenter();
}else
{
  name="";
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
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

<h1>流程创建-<%=flow%></h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<BR>
<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-流程名称')&&submitText(this.type, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-流程类别')&&submitText(this.dynamic, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-流程表单')">
<input type=hidden name="flow" value="<%=flow%>">
<input type=hidden name="community" value="<%=community%>">
<input type=hidden name="nexturl" value="<%=nexturl%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>流程名称</td>
    <td nowrap><input name="name" type="text" value="<%=name%>" size="40"></td>
  </tr>
  <tr>
    <td>上级流程</td>
    <td nowrap><select name="prev">
      <option value="0">------------------------</option>
      <%
      Enumeration e=Flow.find(teasession._strCommunity,"");
      while(e.hasMoreElements())
      {
        int id=((Integer)e.nextElement()).intValue();
        out.print("<option value="+id);
        if(id==prev)
        out.print(" SELECTED ");
        out.print(" >"+Flow.find(id).getName(teasession._nLanguage));
      }
      %></select>
      </td>
  </tr>
  <tr>
    <td>流程类别</td>
    <td nowrap><select name="type">
      <option value="">------------------------</option>
      <%
      for(int i=0;i<Flow.FLOW_TYPE.length;i++)
      {
        out.print("<option value="+i);
        if(i==type)
        out.print(" SELECTED ");
        out.print(" >"+Flow.FLOW_TYPE[i]);
      }
      %></select>
      </td>
  </tr>
  <tr>
    <td>表单</td>
    <td nowrap>
      <select name="dynamic">
        <option value="">------------------------</option>
        <%
        java.util.Enumeration enumer=Dynamic.findByCommunity(community,2);
        while(enumer.hasMoreElements())
        {
          int dy=((Integer)enumer.nextElement()).intValue();
          out.print("<option value="+dy);
          if(dy==dynamic)
          out.println(" SELECTED ");
          out.println(" >"+ Dynamic.find(dy).getName(teasession._nLanguage));
        }
        %></select>
        </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Options")%></td>
    <td nowrap>
      <input type="checkbox" name="itemtype" value="1" id="itemtype" <%if(itemtype==1)out.print(" CHECKED "); %>><label for="itemtype">是否用于项目</label>
      <input type="checkbox" name="hiddenconsign" id="hiddenconsign" <%if(hiddenconsign)out.print(" CHECKED "); %>><label for="hiddenconsign">是否隐掉经办人的委托功能</label>
    </td>
  </tr>
  <tr>
    <td>正文模板</td>
    <td nowrap><input type="file" name="template" size="30">
    <%
    if(len > 0)
    {
      out.print("<a href="+template+" target=_blank>"+len + r.getString(teasession._nLanguage, "Bytes")+"</a>");
      out.print("<input type=checkbox name=clear onclick=form1.template.disabled=this.checked;>"+r.getString(teasession._nLanguage, "Clear"));
    }
    %>
    </td>
  </tr>
  <tr>
    <td>归案:</td>
    <td><input type="text" name="filecenter" value="<%if(filecenter>0)out.print(filecenter);%>">文件中心的文件夹ID</td>
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
