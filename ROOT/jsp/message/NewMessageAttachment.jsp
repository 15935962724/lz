<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.confab.*" %>
<%@ page  import="tea.resource.Resource" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.admin.*"%>
<%@ page import="tea.entity.member.*" %>
<%@page import="java.net.URLEncoder"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int message=Integer.parseInt(teasession.getParameter("message"));

Message m=Message.find(message);
if("POST".equals(request.getMethod()))
{
  int part=Integer.parseInt(teasession.getParameter("part"));
  if(teasession.getParameter("delete")!=null)
  {
    m.deleteAttachmentPart(part);
  }else
  {
    byte by[]=teasession.getBytesParameter("file");
    if(by!=null)
    {
      String path=TeaServlet.write(teasession._strCommunity,by,".gif");
      String name=teasession.getParameter("fileName");
      //int part=(int)(System.currentTimeMillis()/1000);
      m.createAttachment(part,name,path);
    }
  }
}

Resource r=new Resource();

int part=0;

%>
<HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/load.js"  type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<style type="text/css">
<!--
body
{
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	text-align: left;
}
-->
</style>
<script type="">
var attach=parent.document.getElementById('attach');
function f_delete(id)
{
  if(confirm('确认删除?'))
  {
    form1.part.value=id;
    return true;
  }
  return false;
}
</script>
</head>
<body id="tablecenter">
<FORM name="form1" METHOD="post" action="?" enctype="multipart/form-data">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<input type="hidden" name="message" value="<%=message%>" />
<input type="hidden" name="part" value="1" />

<input type="button" style="position:absolute" value="上传附件">  <input type="file" name="file" style="position:absolute;width:10;cursor:hand;filter:Alpha(opacity=0)" onchange="form1.submit();"/>

<table border="0" cellpadding="0" cellspacing="0" >
<%
int i=1;
Enumeration e= m.findAttachment();
while(e.hasMoreElements())
{
  part=((Integer)e.nextElement()).intValue();
  String name=m.getAttachmentFileName(part,teasession._nLanguage);
  String path=m.getAttachmentFilePath(part);
  String ext=name.substring(name.lastIndexOf(".")+1);
  out.println("<tr><td style=font-size:9pt align=center>"+i);
  out.println("<td style=font-size:9pt align=center><a href=/jsp/include/DownFile.jsp?uri="+URLEncoder.encode(path,"UTF-8")+"&name="+URLEncoder.encode(name,"UTF-8")+"><img src=/tea/image/netdisk/"+ext+".gif onerror=\"src='/tea/image/netdisk/defaut.gif';onerror=null;\">"+name+"</a>");
  out.println("<td style=font-size:9pt align=center><input type=submit name=delete value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=f_delete("+part+"); ></td></tr>");
  i++;
}
out.print("<script>form1.part.value="+(part+1)+"; attach.style.height='"+(i*25)+"px';</script>");
%>
</table>
</FORM>

</body>
</html>
