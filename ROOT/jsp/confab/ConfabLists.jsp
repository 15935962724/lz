<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.confab.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="java.util.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");

Resource r=new Resource();

boolean _bCount=request.getParameter("count")!=null;
boolean _bFather=request.getParameter("father")!=null;
int father=0;
if(_bFather)
father=Integer.parseInt(request.getParameter("father"));

DCommunity dc=DCommunity.find(community);
if(father==0)
{
  father=dc.getNode();
}


String nexturl=request.getParameter("nexturl");
if(nexturl==null)
nexturl=request.getRequestURI()+"?"+request.getQueryString();

int type=0;
if(request.getParameter("type")!=null)
type=Integer.parseInt(request.getParameter("type"));


%>
<!--
参数说明:
type: 类别,及动态类的ID
father: 父亲节点
count: 数量(布尔),有此参数表示只能创建一条
-->
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage,"1215591962600")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td width="1"></td>
    <td><%=r.getString(teasession._nLanguage,"index")%></td>
    <td><%=r.getString(teasession._nLanguage,"Name")%></td>
    <td></td>
  </tr>

<%
int sum=0;
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT node FROM Node WHERE type>=1024 AND community="+db.cite(community)+" AND path LIKE "+db.cite("%/"+father+"/%")+" AND vcreator="+db.cite(teasession._rv._strV));
  while(db.next())
  {
    int node_id=db.getInt(1);
    Node node_obj=Node.find(node_id);
    Dynamic d_obj=Dynamic.find(node_obj.getType());

    out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" >");
    out.print("<td width=1 >"+(++sum)+"</td>");
    out.print("<td><A target=_blank href=/jsp/type/dynamicvalue/DynamicValueViewTab.jsp?node="+node_id+"&community="+community+" >"+d_obj.getType()+"-"+node_id+"</A></td>");
    out.print("<td><A target=_blank href=/jsp/confab/ConfabView.jsp?node="+node_id+"&community="+community+" >"+node_obj.getSubject(teasession._nLanguage)+"</A></td><td>");

    java.util.Enumeration enumer_code=DynamicType.findByDynamic(node_obj.getType(),"code");
    if(enumer_code.hasMoreElements())
    {
      int dt_id=((Integer)enumer_code.nextElement()).intValue();
      DynamicValue dv=DynamicValue.find(node_id,teasession._nLanguage,dt_id);
      String code=dv.getValue();
      if(code==null||code.length()<1)
      out.print("<input type=button onclick=\" window.open('/jsp/confab/EditConfabDynamicValue.jsp?community="+community+"&node="+node_id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self'); \" VALUE="+r.getString(teasession._nLanguage, "Edit")+" > <input type='button' value="+r.getString(teasession._nLanguage, "CBDelete")+" onClick=\"if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDeleteTree")+"')){window.open('/servlet/DeleteNode?node="+node_id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"', '_self');this.disabled=true;}\" >");

    }
  }
}finally
{
  db.close();
}
out.print("</table><BR/>");

if(!_bCount || sum<1)
{
  if(_bFather)
  {
    Dynamic d_obj=Dynamic.find(type);
    out.println("<input type=button value=创建-"+d_obj.getName(teasession._nLanguage)+" onclick=\" window.open('/jsp/confab/EditConfabDynamicValue.jsp?NewNode=ON&community="+community+"&Type="+type+"&node="+father+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self');\" >");
  }else
  {
    java.util.Enumeration enumeration=Node.findAllSons(dc.getNode());
    while(enumeration.hasMoreElements())
    {
      int node_id=((Integer)enumeration.nextElement()).intValue();
      Category c_obj=Category.find(node_id);
      if(c_obj.getCategory()>=1024)
      {
        Dynamic d_obj=Dynamic.find(c_obj.getCategory());
        out.println("<input type=button value=创建-"+d_obj.getName(teasession._nLanguage)+" onclick=\" window.open('/jsp/confab/EditConfabDynamicValue.jsp?NewNode=ON&community="+community+"&Type="+c_obj.getCategory()+"&node="+node_id+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self');\" >");
      }
    }
  }
}

%>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


