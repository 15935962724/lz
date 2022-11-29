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
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>
window.onBeforePrint=function()
{
  print.style.display="none";
}

window.onAfterPrint=function()
{
  print.style.display="";
}
</script>
<style>
*{font-size:9pt;}
img{border:0px;float:right;}
span {white-space: nowrap;}
body{ background-image:url(); background-position:center top; background-repeat:repeat-y;margin: 0px;text-align:center}
div#language{margin-top:15px; padding-top:10px; }
form{margin: 0px;	padding: 0px;}
p{ margin:0px; padding:5px 0px 5px 0px}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body >
<input type="hidden" name="keywords" value="<%=keywords%>"/>
<img src="/servlet/QRCodeImg?content=<%=URLEncoder.encode(qrc.toString(),"UTF-8")%>&size=50" id="erwei">
<%
java.util.Enumeration enumeration=DynamicType.findByDynamic(node.getType());
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
      DynamicValue av = DynamicValue.find(node._nNode, teasession._nLanguage, id);
      String v;
      if(av.isExists())
      {
        v=av.getValue();
      }else
      {
        v=obj.getContent(teasession._nLanguage);
      }
      if(v==null||v.length()==0)
      {
        v="　";
      }
      if("radio".equals(obj.getType()))
      {
        StringBuffer sb = new StringBuffer();
        java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(obj.getContent(teasession._nLanguage), "/");
        for(int index = 0; tokenizer.hasMoreTokens(); index++)
        {
          String str = tokenizer.nextToken();
          boolean bool=str.equals(v);// || index == 0;
          tea.html.Radio select = new tea.html.Radio("dynamictype" + id, str,bool);
          select.setDisabled(!bool);
          String strid = String.valueOf(id) + "_" + index;
          select.setId(strid);
          sb.append(select).append("<label for=" ).append( strid ).append( ">" ).append( str ).append( "</label> ");
        }
        out.print(sb.toString());
      }else if("file".equals(obj.getType()))
      {
        out.print("<U>"+r.getString(teasession._nLanguage, "Download")+":<A href="+v+" >"+obj.getName(teasession._nLanguage)+"</A></U>");
      }else if("img".equals(obj.getType()))
      {
        out.print("<IMG SRC="+v+">");
      }else
      if("code".equals(obj.getType()))
      {
        out.print("<U><SPAN id=code >"+v+"</SPAN></U>");
      }else
      {
        out.print("<U>"+v+"</U>");
      }
      out.print(obj.getAfter(teasession._nLanguage));
    }
}%>

<input type="button" id="print" value="打印" onClick="window.print();"/>
</body>
</html>
