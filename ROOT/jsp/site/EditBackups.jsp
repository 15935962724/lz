<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.util.regex.*"%><%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%><%@page import="java.io.*"%><%@page import="tea.entity.site.*"%><%!

public static String f(String s)
{
  if(s==null||s.length()<1)return s;
  s=s.replace('\\','/');
  if(!s.endsWith("/"))s+="/";
  return s;
}

%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int backups=1;
Backups t=Backups.find(backups);

String act=h.get("act");
if("logs".equals(act))
{
  int type=h.getInt("type");
  out.print("<html><head><link href='/res/"+h.community+"/cssjs/community.css' rel='stylesheet' type='text/css' /><script src='/tea/mt.js' type='text/javascript'></script></head><body class='iframe'>");
  if(type==200)
  {
    out.print("<table style='width:400px;' id='tablecenter'><tr id='tableonetr'><td>文件名</td><td>大小</td></tr>");
    if(t.path==null)
    {
      out.print("<tr><td colspan='3' align='center'>暂无备份！</td>");
      return;
    }
    File f=new File(t.path);
    if(t.path.length()>0&&f.exists())
    {
      //String tmp=ConnectionPool._strUrl[0];tmp.substring(tmp.lastIndexOf(":")+1)
      final String[] ns=new String[10];
      for(int i=0;i<2;i++)
      {
        if(i==1)i=8;
        ns[i]=ConnectionPool._strUserId[i];
        if(ns[i]==null)continue;
        if(ConnectionPool._nType==0)
        {
          Matcher m=Pattern.compile("/([^?/]+)\\?").matcher(ConnectionPool._strUrl[i]);
          if(m.find())ns[i]=m.group(1);
        }
        ns[i]+="_";
      }
      File[] fs=f.listFiles(new FilenameFilter(){public boolean accept(File dir, String name){for(int i=0;i<ns.length;i++)return ns[i]!=null&&name.startsWith(ns[0]);return false;}});
      for(int i=0;i<fs.length;i++)
      {
        out.print("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>");
        out.print("<td>"+fs[i].getName()+"<td>"+MT.f(fs[i].length()/1048576F)+" MB");
        f=null;
      }
    }
    if(f!=null)out.print("<tr><td colspan='3' align='center'>暂无备份！</td>");
    out.print("</table>");
  }else
  out.print("<br/><textarea cols='68' rows='12' wrap='off'>"+Filex.read(application.getRealPath("/res/backups"+type+".log"),"utf-8")+"</textarea>");
  out.print("<br/><input type='button' value='关闭' onclick='parent.mt.close()' />");
  out.print("<script>mt.fit(false,400);</script>");
  return;
}else if("test".equals(act))
{
  out.print("<script>parent.mt.show('<textarea cols=35 rows=5 wrap=off>"+MT.f(t.test(h.getInt("type"))).replaceAll("\r|\n","&#13;")+"</textarea>');</script>");
  return;
}

Backups.Scheme ftp=t.parse(t.ftp),smb=t.parse(t.smb),ssh=t.parse(t.smb);
if("POST".equals(request.getMethod()))
{
  t.bweek=h.get("bweek","|");
  t.bhour=h.getInt("bhour");
//  t.bdatabase=f(h.get("bdatabase"));
//  if(ConnectionPool._nType==0&&!new File(t.bdatabase).isDirectory())
//  {
//    out.print("<script>parent.mt.show('“数据库”设置不正确');</script>");
//    return;
//  }
  t.path=f(h.get("path"));
  File f=new File(t.path);
  f.mkdirs();
  if(!f.exists())
  {
    //out.print("<script>parent.mt.show('“备份路径”设置不正确');</script>");
    //return;
  }
  t.retain=h.getInt("retain");
  t.type=h.getInt("type");

  String shell=h.get("shell");
  if(shell!=null)
  {
    String file=application.getRealPath("/res/backups.cmd");
    Filex.write(file,shell,"utf-8");
    if(!OS.isWin)new ProcessBuilder(new String[]{"/bin/chmod","777",file}).start();
  }
  t.shost=h.get("shost");
  t.suser=h.get("suser");
  String tmp=h.get("spassword");
  if(!"******".equals(tmp))t.spassword=tmp;
  t.spath=h.get("spath");
  if(!t.spath.endsWith("/"))t.spath+="/";
  //
  t.cuser=h.get("cuser");
  tmp=h.get("cpassword");
  if(!"******".equals(tmp))t.cpassword=tmp;
  //ftp
  String pwd=h.get("ftppwd");
  pwd=!"******".equals(pwd)?pwd:ftp.pwd;
  t.ftp="ftp://"+h.get("ftpuser")+":"+pwd+"@"+h.get("ftphost")+h.get("ftppath");
  //smb
  pwd=h.get("smbpwd");
  pwd=!"******".equals(pwd)?pwd:smb.pwd;
  t.smb="smb://"+h.get("smbuser")+":"+pwd+"@"+h.get("smbhost")+h.get("smbpath");
  t.set();

  out.print("<script>parent.mt.show('数据修改成功!');</script>");
  return;
}
//t.bdatabase=MT.f(t.bdatabase);
t.path=MT.f(t.path);



%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function f_logs(t,n)
{
  mt.show("/jsp/site/EditBackups.jsp?community=<%=h.community%>&act=logs&type="+t,1,n,500);
}
function f_test(t)
{
  mt.show("连接中。。。",0);
  window.open("/jsp/site/EditBackups.jsp?community=<%=h.community%>&act=test&type="+t+"&t="+new Date().getTime(),"_ajax");
}
function f_submit()
{
  if(!form1.ftppath.value.endsWith("/"))form1.ftppath.value+="/";
  if(!form1.smbpath.value.endsWith("/"))form1.smbpath.value+="/";
}
</script>
</head>
<body>
<h1>备份数据库</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/jsp/site/EditBackups.jsp" method="post" target="_ajax" onsubmit="return mt.check(this)&&f_submit()">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="backups" value="<%=backups%>"/>

<h2>备份时间</h2>
<table id="tablecenter">
  <tr>
    <td>星期</td>
    <td>
      <%
      t.bweek=MT.f(t.bweek);
      String[] arr={"日","一","二","三","四","五","六"};
      for(int i=0;i<7;i++)
      {
        out.print("<input type='checkbox' name='bweek' value='"+i+"' id='bw"+i+"'");
        if(t.bweek.indexOf(String.valueOf(i))!=-1)out.print(" checked");
        out.print("><label for='bw"+i+"'>星期"+arr[i]+"</label> ");
      }
      %>
      </td>
  </tr>
  <tr>
    <td>几点</td>
    <td>
      <select name="bhour">
      <%
      for(int i=0;i<24;i++)
      {
        out.print("<option value="+i);
        if(t.bhour==i)out.print(" selected");
        out.print(">"+i);
      }
      %>
      </select>
      </td>
  </tr>
</table>
<h2>备份数据库</h2>
<table id="tablecenter">
  <tr>
    <td>数据库</td>
    <td><%=ConnectionPool._strUrl[0]%></td>
  </tr>
  <tr>
    <td>备份路径</td>
    <td><input name="path" value="<%=t.path%>" size="80" alt="备份路径"/></td>
  </tr>
  <tr>
    <td>保留最近多少天内的备份文件</td>
    <td><input name="retain" value="<%=MT.f(t.retain)%>" mask="int" size="10" alt="保留个数"/> <a href="###" onclick="f_logs(200,'备份信息')">查看日志</a></td>
  </tr>
</table>

<h2>同步到异机</h2>
<table id="tablecenter">
  <tr>
    <td>方式</td>
    <td><%=h.radios(Backups.TYPE_NAME,"type",t.type)%>
  </tr>
<tbody id="tb0" style="display:none">
  <tr>
</tbody>
<tbody id="tb1" style="display:none">
  <tr>
    <td>FTP主机</td>
    <td><input name="ftphost" size="40" value="<%=MT.f(ftp.host)%>" /> <a href="###" onclick="f_logs(1,'同步信息')">查看日志</a></td>
  </tr>
  <tr>
    <td>FTP用户</td>
    <td><input name="ftpuser" size="40" value="<%=MT.f(ftp.user)%>" /> <a href="javascript:f_test(1)">测试连接</a></td>
  </tr>
  <tr>
    <td>FTP密码</td>
    <td><input name="ftppwd" size="40" type="password" value="<%=MT.f(ftp.pwd).length()>0?"******":""%>"/></td>
  </tr>
  <tr>
    <td>FTP路径</td>
    <td><input name="ftppath" size="40" value="<%=MT.f(ftp.path)%>"/></td>
  </tr>
</tbody>
<tbody id="tb2" style="display:none">
  <tr>
    <td>SMB主机</td>
    <td><input name="smbhost" size="40" value="<%=MT.f(smb.host)%>" /> <a href="###" onclick="f_logs(2,'同步信息')">查看日志</a></td>
  </tr>
  <tr>
    <td>SMB用户</td>
    <td><input name="smbuser" size="40" value="<%=MT.f(smb.user)%>" /> <a href="javascript:f_test(2)">测试连接</a></td>
  </tr>
  <tr>
    <td>SMB密码</td>
    <td><input name="smbpwd" size="40" type="password" value="<%=MT.f(smb.pwd).length()>0?"******":""%>"/></td>
  </tr>
  <tr>
    <td>SMB路径</td>
    <td><input name="smbpath" size="40" value="<%=MT.f(smb.path)%>"/></td>
  </tr>
</tbody>
<tbody id="tb3" style="display:none">
  <tr>
    <td>主机</td>
    <td><input name="shost" size="40" value="<%=MT.f(t.shost)%>" /> <a href="###" onclick="f_logs(2,'同步信息')">查看日志</a></td>
  </tr>
  <tr>
    <td>用户</td>
    <td><input name="suser" size="40" value="<%=MT.f(t.suser)%>" /> <a href="javascript:f_test(3)">测试连接</a></td>
  </tr>
  <tr>
    <td>密码</td>
    <td><input name="spassword" size="40" type="password" value="<%=MT.f(t.spassword).length()>0?"******":""%>"/></td>
  </tr>
  <tr>
    <td>路径</td>
    <td><input name="spath" size="40" value="<%=MT.f(t.spath)%>"/></td>
  </tr>
</tbody>
</table>

<h2>云盘</h2>
<table id="tablecenter">
  <tr>
    <td>用户</td>
    <td><input name="cuser" size="40" value="<%=MT.f(t.cuser)%>" /></td>
  </tr>
  <tr>
    <td>密码</td>
    <td><input name="cpassword" size="40" type="password" value="<%=MT.f(t.cpassword).length()>0?"******":""%>"/></td>
  </tr>
</table>
<%
if(h.debug)
{
  String shell=Filex.read(application.getRealPath("/res/backups.cmd"),"utf-8");
%>
<h2>附加命令</h2>
<table id="tablecenter">
  <tr>
    <td>命令</td>
    <td><textarea name="shell" cols="50" rows="5"><%=shell%></textarea></td>
  </tr>
</table>
<%
}
%>
<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
var t=form1.type,tlast;
for(var i=0;i<t.length;i++)
{
  t[i].onclick=function(){if(tlast)tlast.display='none';tlast=$('tb'+this.value).style;tlast.display='';}
}
form1.type[<%=t.type%>].click();
</script>
</body>
</html>
