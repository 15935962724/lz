<%@page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>

<div id="head6"><img height="6" src="about:blank"></div>
<%
request.setCharacterEncoding("UTF-8");
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv!=null)
{
  tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
  if(request.getMethod().equals("POST"))
  {
    String email=request.getParameter("email");
    tea.entity.member.Profile profile=tea.entity.member.Profile.find(teasession._rv._strV);
    profile.setEmail(email);

    String nickname=request.getParameter("nickname");
    tea.entity.member.BLOGProfile bp=tea.entity.member.BLOGProfile.find(profile.getMember());
    bp.set(nickname,null,0,0);

    tea.entity.site.BLOGCommunity community=tea.entity.site.BLOGCommunity.find(node.getCommunity());
    //创建节点
    int home=tea.entity.node.Node.create(community.getNode(),1,node.getCommunity(),teasession._rv,0,0,false,1577582592,0,teasession._nLanguage,null,null,teasession._nLanguage,nickname+" BLOG",teasession._rv._strV,"",null,"",0,null,"","","","",null,new java.util.Date(),0,0,0,0,"","");
    tea.entity.node.Node.find(home).finished(home);
    //tea.entity.member.Profile.find(teasession._rv._strV,node.getCommunity()).setStartUrl("/servlet/Node?node="+home,teasession._nLanguage);

    //创建CssJs
    tea.entity.node.CssJs cssjs =tea.entity.node.CssJs.find(community.getCssjs());
    System.out.println(cssjs.getCss(teasession._nLanguage));
    tea.entity.node.CssJs.create("",2,teasession._nNode,3,teasession._nLanguage,cssjs.getCss(teasession._nLanguage),cssjs.getJs(teasession._nLanguage),0);

    response.sendRedirect("/jsp/type/weblog/WeblogDesktop.jsp?node="+teasession._nNode);
    return;
  }



  tea.entity.node.Blog blog=tea.entity.node.Blog.find(node.getCommunity(),teasession._rv._strR);

  if(blog.isExists())
  {
    String url=request.getServerName();
    String urls[]= url.split("\\.");
    url=teasession._rv._strV;
    for(int index=1;index<urls.length;index++)
    {
      url+="."+urls[index];
    }
    if(request.getServerPort()!=80)
    {
      url+=":"+request.getServerPort();
    }
    tea.entity.member.BLOGProfile bp=tea.entity.member.BLOGProfile.find(teasession._rv._strV);
    %>
    我的主页:<A href="http://<%=url%>">http://<%=url%></A> <%=bp.getNickname(teasession._nLanguage)%>
    <%
  }else
  {
    %>
    <form name="form1" method="post" action="/jsp/user/WeblogRequest.jsp" onSubmit="return submitText(this.nickname,'无效博客名')&&submitEmail(this.email,'无效E-Mail')">
<input type=hidden name="Node" value="<%=teasession._nNode%>">
昵名:<input name="nickname" type="text">
Email:<input name="email" type="text">
<input name="" type="submit" value="立即申请博客">
</form>
    <%
  }
}
%>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>

