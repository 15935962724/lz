<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Node node=Node.find(teasession._nNode);

String subject=node.getSubject(teasession._nLanguage);
String community=node.getCommunity();
Cebbank cebbankobj= Cebbank.find(node._nNode);
String keywords="";//主合同编号
if(node.getType()!=1025)
try
{
  int nodeid=Integer.parseInt(node.getKeywords(teasession._nLanguage));
  //System.out.println(nodeid);
  DbAdapter db = new DbAdapter();
  try
  {
    db.executeQuery("SELECT dv.value FROM DynamicValue dv,DynamicType dt  WHERE dv.node="+nodeid+" AND dt.type='code' AND dt.dynamictype=dv.dynamictype AND NOT dv.value IS NULL");
    if (db.next())
    {
      keywords=db.getString(1);
    }
  } catch (Exception exception)
  {
    exception.printStackTrace();
  } finally
  {
    db.close();
  }
}catch(Exception e)
{}

Resource r=new Resource();

///QRCode//////////////////
StringBuffer qrc=new StringBuffer();
qrc.append(r.getString(teasession._nLanguage,"MemberId")).append(":").append(node.getCreator()).append("\r\n");
Enumeration e=DynamicType.findByDynamic(node.getType()," AND qrc=1",0,100);
while(e.hasMoreElements())
{
  int dt_id=((Integer)e.nextElement()).intValue();
  DynamicType dt=DynamicType.find(dt_id);
  DynamicValue dv=DynamicValue.find(teasession._nNode,teasession._nLanguage,dt_id);
  qrc.append(dt.getName(teasession._nLanguage)).append(":").append(dv.getValue()).append("\r\n");
}

%><html>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="" src="/tea/tea.js"></script>
<script>
window.onbeforeprint=function()
{
  print_hidden.style.display="none";
}

window.onafterprint=function()
{
  print_hidden.style.display="";
}
</script>
<style>
img{border:0px;}
span {white-space: nowrap;}
body{ background-image:url(); background-position:center top; background-repeat:repeat-y;margin: 0px;text-align:center}
div#language{margin-top:15px; padding-top:10px; }
form{margin: 0px;	padding: 0px;}
p{ margin:0px; padding:5px 0px 5px 0px}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</HEAD>
<body >
<input type="hidden" name="keywords" value="<%=keywords%>"/>
<img src="/servlet/QRCodeImg?content=<%=URLEncoder.encode(qrc.toString(),"UTF-8")%>&size=50" width="45" id="erwei">
<%
Enumeration enumeration=DynamicType.findByDynamic(node.getType());
int id=0;
while(enumeration.hasMoreElements())
{
    id=((Integer)enumeration.nextElement()).intValue();
    DynamicType obj=DynamicType.find(id);
//if("code".equals(obj.getType()))
//{
//}
    if(obj.isHidden())
    {
      out.print(obj.getBefore(teasession._nLanguage));
      out.print(obj.getHtml(teasession,node._nNode));
      out.print(obj.getAfter(teasession._nLanguage));
    }
}%>

<div id="print_hidden">
<input type="button" value="打印" onClick="window.print();"/>
<script>
if(history.length>0)
{
  document.write("<input type='button' value='返回' onClick='history.back();'>");
}else
{
  document.write("<input type='button' value='关闭' onClick='window.close();'>");
}
</script>

</div>

</body>
</html>
