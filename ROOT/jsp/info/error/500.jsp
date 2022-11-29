<%@page contentType="text/html;charset=UTF-8" session="false"%><%@page import="tea.entity.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%><%
//request.setCharacterEncoding("UTF-8");

String community=null;
Cookie[] cs=request.getCookies();
if(cs!=null)for(int i=0;i<cs.length;i++)if("community".equals(cs[i].getName()))community=cs[i].getValue();


//Enumeration e=request.getAttributeNames();
//while(e.hasMoreElements())
//{
//  String n=(String)e.nextElement();
//  System.out.println("===>"+n+":"+request.getAttribute(n).getClass().getName());
//}

String ua=request.getHeader("user-agent");
Throwable ex=(Throwable)request.getAttribute("javax.servlet.error.exception");
if(ex!=null&&ua!=null&&ua.contains("Windows NT 5.2"))
{
  out.print("<!--");
  out.println("toString："+ex.toString());
  ex.printStackTrace(new PrintWriter(out));
  out.print("-->");
}

String info=Err.get(null,ex).replaceAll("<","&lt;").replaceAll("\n","<br/>");
if(info==null)
info="您要访问的网页存在问题，因此无法显示。";


%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>错误信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table id="tablecenter" cellspacing="0">
<tr>
  <td id="info"><%=info%></td>
</tr>
</table>

<script>
if(name=='_ajax')alert($$('info').innerHTML.replace(/<br>/ig,'\n'));
</script>
</body>
</html>
