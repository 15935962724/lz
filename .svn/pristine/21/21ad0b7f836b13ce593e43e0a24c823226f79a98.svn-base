<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.util.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%!
private void tree(Writer out,int node,int language,int step)throws Exception
{
  Enumeration e=Node.find(" AND father="+node,0,200);
  while(e.hasMoreElements())
  {
    int id=((Integer)e.nextElement()).intValue();
    int count=Node.count(" AND father="+id);

    Node n=Node.find(id);
    for(int loop=1;loop<step;loop++)
    {
      out.write("　");
    }
    if(step>0)
    {
      out.write("　");
    }
    if(count>0)
    {
      out.write("<a href=javascript:f_ex('" + id + "'," + step + "); ID=a" + step + "><img src=/tea/image/tree/tree_plus.gif align=absmiddle ID=img" + id + "></a>");
    }else
    {
      out.write("<img src=/tea/image/tree/tree_minus.gif align=absmiddle>");
    }
    out.write(" <a href=javascript:f_open('"+id+"')>"+ n.getSubject(language)+" ( "+count+" )</a>");
    out.write("<br/>");
    out.write("<Div id=\"divid"+id+"\" style=display:none>");
    out.write("</Div>");
  }
}
%>

<%
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if(request.getParameter("ajax")!=null)
{
  int father=Integer.parseInt(request.getParameter("father"));
  int step=Integer.parseInt(request.getParameter("step"));
  tree(out,father,teasession._nLanguage,step);
  return;
}

Node node=Node.find(teasession._nNode);

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script>
  if (top.location == self.location)
  {
    top.location="/jsp/access/AccessMemberFrame.jsp?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>";
  }

  function f_open(node)
  {
    window.open("/jsp/access/AccessMembers.jsp?community=<%=teasession._strCommunity%>&node="+node,"AccessMemberFrame");
  }

  function f_ex(j,step)
  {
    var divid=document.all("divid"+j);
    if(divid.style.display=="")
    {
      divid.style.display="none";
      document.all("img"+j).src="/tea/image/tree/tree_plus.gif";//+
    }else
    {
      divid.style.display="";
      document.all("img"+j).src="/tea/image/tree/tree_minus.gif";//-

      if(divid.innerHTML=="")
      {
        divid.innerHTML="　　<img src=/tea/image/public/load.gif>load...";

        sendx("?ajax=ON&community=<%=teasession._strCommunity%>&father="+j+"&step="+(step+1),function(data){divid.innerHTML=data;});
      }
    }
  }
  </script>
  <style type="">
  body
  {
  text-align: left;
  margin-left: 10px;
  margin-top: 10px;
  margin-right: 10px;
  margin-bottom: 10px;
  }
  </style>
</head>
<body>

<img src="/tea/image/other/img-globe.gif" width="16" height="16">
  <a href="javascript:f_open('<%=teasession._nNode%>');" ><%=node.getSubject(teasession._nLanguage)%></a>

  <div style="padding-left:3px">
  <%
  tree(out,teasession._nNode,teasession._nLanguage,0);
  %>
  </div>

</body>
</html>
