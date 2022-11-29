<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.entity.site.*"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession.getParameter("community");

Blog blog=Blog.find(community,teasession._rv._strR);
//System.out.println("Home:"+blog.getHome()+":"+node.getCommunity());
Node node=Node.find(blog.getHome());
if(request.getMethod().equals("POST"))
{
  if(request.getParameter("revert")!=null)
  {
    blog.revert();
  }else
  {
    CssJs cssjs_obj=CssJs.find(Integer.parseInt(teasession.getParameter("templet1")));
    tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
    try
    {
      dbadapter.executeQuery("SELECT TOP 1 CssJs.cssjs FROM CssJs WHERE CssJs.node="+node._nNode);
      if(dbadapter.next())
      {
        int cssjs=dbadapter.getInt(1);
        CssJs cj_obj=CssJs.find(cssjs);
        //cj_obj.set(2,node._nNode,3,teasession._nLanguage,cssjs_obj.getName(teasession._nLanguage),cssjs_obj.getCss(teasession._nLanguage),cssjs_obj.getJs(teasession._nLanguage));
        cj_obj.set(2,node._nNode,3,false,"",teasession._nLanguage,cssjs_obj.getName(teasession._nLanguage),cssjs_obj.getCss(teasession._nLanguage),cssjs_obj.getJs(teasession._nLanguage));
      }else
      {
        //CssJs.create(0,2,3,0,node._nNode,teasession._nLanguage,cssjs_obj.getName(teasession._nLanguage),cssjs_obj.getCss(teasession._nLanguage),cssjs_obj.getJs(teasession._nLanguage));
        CssJs.create(0,2,3,0,node._nNode,false,"",teasession._nLanguage,cssjs_obj.getName(teasession._nLanguage),cssjs_obj.getCss(teasession._nLanguage),cssjs_obj.getJs(teasession._nLanguage));
        dbadapter.executeUpdate("CssJsHiden " + cssjs_obj.getCssJs() + ", " + node._nNode + ", " + 0);//在本树隐藏
      }
    }catch(Exception e)
    {
    }finally
    {
      dbadapter.close();
    }
  }
  response.sendRedirect("/jsp/info/Succeed.jsp");//?nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}

tea.resource.Resource r=new tea.resource.Resource();
%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "博客模板定义")%> </h1>

<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>
<p> 模板是由一组CSS文件组成，这些CSS文件定义了您的博客页面的外观，您可以选择我们为您已经设计好的各种模板，也可以自己定义这些CSS文件,选择‘首页’ 、‘索引页’、‘单篇文章’将分别编辑相应的页面CSS源码。 <br/>
  <br>
  为您的博客选择一个新的模板<br>
  您可以在这个下拉列表中选择一个您满意的模板，选择后，左边的图示将自动更换成你选择的模板对应的效果图，点击他还可以查看放大的图片.</p>
  </td></tr></table>
<form name="form1" method="post"  action="<%=request.getRequestURI()%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>
  <select name="templet0" onchange="fonchange();">
    <option value="0">-------------------</option>
    <%
    StringBuffer script=new StringBuffer();
    tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
    try
    {
      java.util.Enumeration enumer=Template2.findByCommunity(community);
      while(enumer.hasMoreElements())
      {
        int temp_id=((Integer)enumer.nextElement()).intValue();
        Template2 temp_obj=Template2.find(temp_id);
        out.print("<option value="+temp_id);
        out.print(" >"+temp_obj.getName());

        script.append("case "+temp_id+":\r\n");
        dbadapter.executeQuery("SELECT CssJs.cssjs FROM CssJs,CssJsHide WHERE CssJsHide.cssjs=CssJs.cssjs AND  CssJsHide.node=CssJs.node AND CssJs.node="+temp_id+" AND style=0 AND hiden=0");
        while(dbadapter.next())
        {
          int cssjs=dbadapter.getInt(1);
          CssJs cj_obj=CssJs.find(cssjs);
          script.append("form1.templet1.options[form1.templet1.options.length]=new Option('"+cj_obj.getName(teasession._nLanguage)+"',"+cssjs+");");
        }
        script.append("break;\r\n");
      }
    }finally
    {
      dbadapter.close();
    }
    %>
</select>
  <select name="templet1">
    <option value="0">-------------------</option>
  </select>

  <script type="">
  function fonchange()
  {
    while(form1.templet1.options.length>1)
    {
      form1.templet1.options[1]=null;
    }
    switch(parseInt(form1.templet0.value))
    {
      <%=script.toString()%>
    }
  }
  </script>
</td><td>
  <input name="" type="submit" value="提交" onclick="if(form1.templet1.value==0){alert('无效选择.');return false;}">
</td></tr>
</table>
<!--input name="revert" type="submit" value="还原默认样式"-->
</form>
<br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr><td>注意: 如果更改样或还原默认样式,则DIY样式被删除
</td></tr>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

