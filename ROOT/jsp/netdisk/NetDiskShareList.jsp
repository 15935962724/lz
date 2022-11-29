<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%!
class DirFilter implements java.io.FilenameFilter {
  private java.util.regex.Pattern pattern;
  public DirFilter(String regex) {
    pattern = java.util.regex.Pattern.compile(regex);
  }
  public boolean accept(java.io.File dir, String name) {
    // Strip path information, search for regex:
    return pattern.matcher(new java.io.File(name).getName()).matches();
  }
}
java.util.Vector vector=new java.util.Vector();
public void find(java.io.File file,String filter)
{
    java.io.File path[] = file.listFiles(new DirFilter(filter));
    for(int i = 0; i < path.length; i++)
    {
      vector.addElement(path[i]);
      if(path[i].isDirectory())
        find(path[i],filter);
    }
}
public String getDir(String path,String url)throws java.io.IOException
{
  //String path=file.getCanonicalPath();
  StringBuffer sb=new StringBuffer("/");
  StringBuffer sb2=new StringBuffer("/<a href=\""+contextPath+url+"\">共享目录</a>/");
  java.util.StringTokenizer tokenizer=new java.util.StringTokenizer(path,"/");
  while(tokenizer.hasMoreTokens())
  {
    String label=tokenizer.nextToken();
    sb.append(label+"/");
    sb2.append(new tea.html.Anchor(contextPath+url+"?url="+sb.toString(),label)+"/");
  }
  return(sb2.toString());
}
String contextPath="";
%>
<%
r.add("/tea/resource/NetDisk");
boolean find=request.getParameter("find")!=null;
contextPath=request.getContextPath();

int count=NetDiskShare.countByMember(teasession._strCommunity,teasession._rv._strV);

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Sharelist")+" ("+count+")"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>路径:/<A href="#">共享根目录</A>/</td>
<td align="right" ><a href="javascript:location.reload()"><img src="/tea/image/other/refresh.gif" alt="刷新" border="0"></a><a href="/jsp/netdisk/NetDiskHelp.jsp" target="_blank"><img src="/tea/image/other/help.gif" alt="帮助" border="0"></a></td>
</tr>
</table>
<%
java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
String url=request.getParameter("url");
DbAdapter db=new DbAdapter();
try
{
  String last_member_name=null;
  db.executeQuery("SELECT DISTINCT NetDiskShare.member,NetDiskShare.path FROM NetDiskShare,SMSgroup,SMSPhoneBook WHERE( (NetDiskShare.type=0 AND SMSgroup.id=NetDiskShare.name AND SMSPhoneBook.groupid=NetDiskShare.name)OR (NetDiskShare.type=1 AND SMSPhoneBook.id=NetDiskShare.name ))AND SMSPhoneBook.memberx="+db.cite(teasession._rv._strR)+" AND SMSPhoneBook.community="+db.cite(teasession._strCommunity)+" ORDER BY NetDiskShare.member");
  for(int index=0;db.next();index++)
  {
    String member_name=db.getVarchar(1,1,1);
    String prefix="/res/"+teasession._strCommunity+"/netdiskmember/"+member_name;
    url=db.getVarchar(1,1,2);
    java.io.File root_file_obj=new java.io.File(getServletContext().getRealPath(prefix+url));
    if(!root_file_obj.exists())
    continue;
    if(!member_name.equals(last_member_name))
    {
      out.print("</table>");
      %>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
                <td><%=member_name%>: 　文件名&nbsp;&nbsp;</td>
                <td align=center class="huiditable">修改时间 </td>
              </tr>
              <%
last_member_name=member_name;
}
String name=root_file_obj.getName();
%>
<tr>
                <td class="huiditable">

                  <!--form action="/jsp/netdisk/NetDiskShareList2.jsp" onsubmit="" method="POST" name="formdelete<%=index%>"  STYLE="width:100px;float:left;padding:0px; margin:0px">
                    <input type="hidden" name="prefix" value="<%=prefix%>"/>
                    <input type="hidden" name="url" value="<%=url%>"/>
                    <a href="#" onClick="formdelete<%=index%>.submit();"/><img src="/tea/image/other/directory.gif"  align="ABSMIDDLE" border="0"><%=name%></A>
                    </form-->

<A href="/jsp/netdisk/NetDiskShareList2.jsp?prefix=<%=java.net.URLEncoder.encode(prefix,"UTF-8")%>&url=<%=java.net.URLEncoder.encode(url,"UTF-8")%>"><img src="/tea/image/other/directory.gif"  align="ABSMIDDLE" border="0"><%=name%></A>

                </td>
                <td align="center" class="huiditable"><%=sdf.format(new java.util.Date(root_file_obj.lastModified()))%></td>

              </tr>

<%
    }
  }catch(Exception e)
  {
    e.printStackTrace();
  }finally
  {
    db.close();
  }
%>
</table>

<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
