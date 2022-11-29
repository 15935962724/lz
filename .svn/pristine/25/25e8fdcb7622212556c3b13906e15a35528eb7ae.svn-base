<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%><%@ page import="java.io.*" %><%@ page import="jxl.*" %><%@ page import="tea.ui.node.general.*" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Http h=new Http(request,response);


String community=teasession._strCommunity;


String act=h.get("act");

Resource r=new Resource("/tea/resource/fun");

Node node=Node.find(h.node);

int root=AdminFunction.getRootId(teasession._strCommunity,teasession._nStatus);

AccessMember am=AccessMember.find(teasession._nNode,teasession._rv);

%><html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_click(obj,loop)
{
  var flag=obj.checked;
  try
  {
    var p=obj.parentNode.previousSibling.previousSibling;
    p.checked=true;
    f_click(p,true);

    if(!loop)
    {
      var is=obj.nextSibling.nextSibling.getElementsByTagName("INPUT");
      for(var i=0;i<is.length;i++)
      {
        is[i].checked=flag;
      }
    }
  }catch(e)
  {}
}
</script>
</head>
<body style="text-align:left">
<%
if("head".equals(act))
{
  out.print(NodeServlet.getButton(node,h, am,request));
}
%>

<h1 ID="h1_teshu"><%=r.getString(teasession._nLanguage, "MenuManage")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2><%=r.getString(teasession._nLanguage, "ChoiceMenus")%></h2>


<form name="form1" action="/servlet/EditAdminPopedom" method="post">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="status" value="<%=teasession._nStatus%>">
<input type="hidden" name="act" value="editfunction"/>
<input type="hidden" name="sub" value="8"/>
<input type="hidden" name="menutype" value="0"/>
<input type="hidden" name="id" value="<%=AdminFunction.getRootId(teasession._strCommunity, teasession._nStatus)%>"/>
<%
if("head".equals(act))
{
  out.print("<input type='hidden' name='nexturl' value=\""+request.getRequestURI()+"?"+request.getQueryString()+"\"/>");
}
Workbook wb = Workbook.getWorkbook(new File(Common.REAL_PATH + "/jsp/admin/popedom/Menu.xls"));
try
{
  Sheet s = wb.getSheet(teasession._nStatus);
  int max = s.getRows();
  for (int i = 1; i < max; i++)
  {
    String str = s.getCell(0, i).getContents();
    String name = s.getCell(1, i).getContents();
    String url = s.getCell(2, i).getContents();
    String content = s.getCell(3, i).getContents();
    if(name.length()<1)continue;//没有跳过
    if (str.length() < 1)
    {

       out.print("</div></div></div></div><div><hr>");
    }
    if (str.equals("↑")) //同级菜单
    {
      out.print("<br>");
    } else if (str.equals("→")) //子菜单
    {
      out.print("<div style=padding-left:15px>");
    } else if (str.startsWith("←")) //上级
    {
      for (int j = 0; j < str.length(); j++)
      {
        out.print("</div>");
      }
    }
    out.append("<input name='rows' type='checkbox' value='" + i + "' onclick='f_click(this)'><a href=\"" + url + "\" title=\"" + content + "\" target='_blank'>").append(name).append("</a>");
  }
} finally
{
  wb.close();
}
%>
<br>

<div id="af_submit" style="z-index:150;right:1px;position:absolute;top:100px;">
<input type="submit" value="添加为后台菜单">
<%
if(!"head".equals(act))out.print("<input type='button' value='"+r.getString(teasession._nLanguage, "CBBack")+"' onclick='history.back();'>");
%>
</div>
<script>var af_submit=$("af_submit");setInterval('af_submit.style.top=document.body.scrollTop+150;',100);</script>

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
