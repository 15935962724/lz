<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="org.apache.lucene.index.*"%>
<%@page import="org.apache.lucene.search.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.admin.earth.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%@page import="java.util.*"%>
<%!
java.util.Random ran=new java.util.Random();

//标红,英文字母不区大小写
public String mark(String key,String content)
{
  StringBuffer sb=new StringBuffer(content.length());
  try
  {
    key=key.replaceAll("[\\\\]","").replaceAll("[|]","").replaceAll("[\\\\^]","").replaceAll("\\s+","|");
    java.util.regex.Matcher m=java.util.regex.Pattern.compile(key,java.util.regex.Pattern.CASE_INSENSITIVE).matcher(content);
    int index=0;
    while(m.find())
    {
      sb.append(content.substring(index,m.start()));
      sb.append("<FONT color='red'>"+m.group()+"</FONT>");
      index=m.end();
    }
    sb.append(content.substring(index));
    return sb.toString();
  }catch(Exception ex)
  {
    ex.printStackTrace();
    return content;
  }
}
%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
String q=request.getParameter("q");
if(q==null)
	q="";

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
  pos=Integer.parseInt(_strPos);
}

Resource r=new Resource("/tea/resource/Lucene");

String qs[]=null;
StringBuffer sql=new StringBuffer();
if(q!=null&&(q=q.trim()).length()>0)
{
  qs=q.split(" ");
  sql.append(" AND(");
  for(int i=0;i<qs.length;i++)
  {
    if(i>0)
    {
      sql.append(" AND");
    }
    sql.append(" (  subject LIKE ").append(DbAdapter.cite("%"+q+"%"));
    //sql.append(" OR content LIKE ").append(DbAdapter.cite("%"+q+"%"));
    sql.append(" )");
  }
  sql.append(")");
  param.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
}

int count=0;
String _strCount=request.getParameter("count");
if(_strCount!=null)
count=Integer.parseInt(_strCount);
else
count=EarthNode.count(sql.toString());

param.append("&count=").append(count);

param.append("&pos=");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<style>
#titl{font-size:14px;color:#00c;}
#titl a{font-size:14px;color:#00c;}
#titi{font-size:12px;color:#666;}
#titi a{font-size:12px;color:#666;}
body{background:url(/res/ROOT/u/0709/070921023.jpg) no-repeat right top;
background-attachment:fixed;}
</style>
</head>
<body>
<table STYLE="margin-left:10px;">
<%
    if(count<1)
    out.print("无记录...");
    else
    {
      int ch=150;
      Enumeration e=EarthNode.find(sql.toString(),pos,15);
      while(e.hasMoreElements())
      {
        int id=((Integer)e.nextElement()).intValue();
        EarthNode obj=EarthNode.find(id);
        int node=obj.getNode();
        String subject=obj.getSubject();
        String content=obj.getContent();
        String community=obj.getCommunity();

        int i=content.indexOf(q)-10;
        if(i<0)
        i=0;
        ch=i+ch;
        if(ch>content.length())
        ch=content.length();
        content=content.substring(i,ch);
        if(qs!=null)
        {
          for(int ir=0;ir<qs.length;ir++)
          {
            subject=subject.replace(qs[ir],"<font style=\"color:#f00;font-size:14px;\">"+qs[ir]+"</font>");
            content=content.replace(qs[ir],"<font color=#FF0000>"+qs[ir]+"</font>");
          }
        }

        String url;
        Enumeration e2=DNS.findByCommunity(community,teasession._nStatus);
        if(e2.hasMoreElements())
        {
          String sn=(String)e2.nextElement();
          url="http://"+sn+"/servlet/Node?node="+node+"&Language=1";
        }else
        {
          url="javascript:alert('该域名已经存在了.');";
        }
        out.print("<tr><td id=titl><a href="+url+" target=_blank>"+subject+"</a></td></tr>");
        out.print("<tr><td id=titi>"+content+"...</td></tr>");
        out.print("<tr><td id=titi><a href="+url+" target=_blank>/servlet/Node?node="+node+"</a> - "+obj.getTimeToString()+" - 关注度:"+obj.getHits()+"</td></tr>");
        out.print("<tr><td>&nbsp;</td></tr>");
      }
    }
    out.print("<tr><td>"+new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,15)+" 相关结果数:"+count+"</td></tr>");
%>
</table>

</body>
</html>



