<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.ui.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.entity.member.*"%><%
request.setCharacterEncoding("UTF-8");
String sn=request.getServerName();
String ip=request.getRemoteAddr();
String ua=request.getHeader("User-Agent");

if(!"GET".equals(request.getMethod()))return;

//判断博客跳转
/*
String blogurl = "/news.labournews.com.cn/opinion.labournews.com.cn/yc.labournews.com.cn/people.labournews.com.cn/ms.labournews.com.cn/Home.labournews.com.cn/bbs.labournews.com.cn/blog.labournews.com.cn/szb.labournews.com.cn/";

sn = sn.replaceAll("http://","");
if(blogurl.indexOf("/"+sn+"/")==-1&&!"www.labournews.com.cn".equals(sn)&&sn.indexOf("clssn.com")==-1)
{

	String url2 = "http://"+sn.substring(0,sn.indexOf("."))+sn.substring(sn.indexOf("."),sn.length())+"/sp1/"+sn.substring(0,sn.indexOf("."))+"/index.shtml";
	response.sendRedirect(url2);
	return;
}
*/
Http h=new Http(request);




//N校检S////
License license=License.getInstance();
String lsn=license.getSerialNumber();
if(lsn==null||lsn.length()<1)
{
  response.sendRedirect("/jsp/site/EditLicenseSN.jsp?community=Home");
  return;
}


//Mozilla/5.0 (Windows; U; Windows NT 5.2; zh-CN) AppleWebKit/525.13 (KHTML, like Gecko) Version/3.1 Safari/525.13
//Mozilla/5.0 (iPhone; U; CPU like Mac OS X; zh-cn) AppleWebKit/420.1 (KHTML, like Gecko) Version/3.0 Mobile/4A102 Safari/419.3
//via:WTP/1.1 BJBJ-PS-WAP4-GW05.bj4.monternet.com (Nokia WAP Gateway 4.0 CD3/ECD13_C/NWG4.0 CD3 ECD13_C 4.1.03)

////自动查找社区的域名

DNS obj=DNS.find(sn);
if(!obj.isExists())
{
  obj=DNS.find("%");
}
if(obj.isExists())
{
  String community=obj.getCommunity();
  int node=obj.getNode();
  String url=obj.getUrl();
  if(url==null||url.length()<1)
  {
    /////////判断客户端浏览器的语言
    String tmp=h.getCook("language",null);
    int lang=1;
    if(tmp!=null)
      lang=Integer.parseInt(tmp);
    else
    {
      String lan=request.getHeader("Accept-Language");
      if(lan!=null)
      {
        lan=lan.toLowerCase();//zh-CN, en-US
        if(lan.indexOf("zh-cn")!=-1)//简中
          lang=1;
        else if(lan.indexOf("zh-tw")!=-1)//简繁
          lang=2;
        else if(lan.indexOf("ja")!=-1)//日文
          lang=3;
        else if(lan.indexOf("ko")!=-1)//韩文
          lang=4;
        else if(lan.indexOf("fr")!=-1)//法文
          lang=5;
        else if(lan.indexOf("de")!=-1)//德文
          lang=6;
        else if(lan.indexOf("es")!=-1)//西班牙文
          lang=7;
        else if(lan.indexOf("pt")!=-1)//葡萄牙文
          lang=8;
        else if(lan.indexOf("it")!=-1)//意大利文
          lang=9;
        else if(lan.indexOf("en")!=-1)//英
          lang=0;
        Node n=Node.find(node);
        if(lang!=n.getDefaultLanguage())
        {
          DbAdapter db = new DbAdapter();
          try
          {
            db.executeQuery("SELECT language FROM NodeLayer WHERE node="+node+" AND language="+lang);
            if(!db.next())lang=n.getDefaultLanguage();
          }finally
          {
            db.close();
          }
        }
      }
    }
    //首页永远是中文版
    if(sn.equals("www.cslight.com"))lang=1;



    int status=0;
    tmp=h.getCook("status_del",null);
    if(tmp!=null)
      status=Integer.parseInt(tmp);
    else
    {
      String ac=request.getHeader("accept");
      if(ua==null)ua=request.getHeader("via");
      //(ua==null||ua.indexOf("iPad;") == -1)&&(
      if(ac!=null&&ac.indexOf(".wap.")!=-1||sn.startsWith("m.")||(ua!=null&&(ua.indexOf("Mobile")!=-1||ua.indexOf("WAP")!=-1||ua.indexOf("Configuration/CLDC")!=-1||ua.indexOf("UP.Browser/")!=-1||ua.startsWith("CECT")||ua.startsWith("LG"))))
      {
        Community c=Community.find(community);
        if(c.ischeck.contains("/6/"))status=1;//必须存在手机版，才显示手机版网页
      }
      if(sn.startsWith("m."))status=1;
      if(obj.getStatus()!=status)
      {
        Enumeration e=DNS.findByCommunity(community,status);
        if(e.hasMoreElements())
        {
          sn=(String)e.nextElement();
          response.sendRedirect("http://"+sn+":"+request.getServerPort());
          return;
        }
      }
      //按城市跳转///
      url=obj.getCityUrl(ip);
      if(url!=null)
      {
        response.sendRedirect(url);
        return;
      }
      request.setAttribute("status",String.valueOf(status));
      response.addCookie(new Cookie("status",String.valueOf(status)));
    }
    try
    {
      application.getRequestDispatcher("/"+(status==1?"xhtml":"html")+"/"+community+"/folder/"+node+"-"+lang+".htm").forward(request,response);
    }catch(IOException ex)
    {
    }
  }else/////url转向
  if(url.startsWith("/"))
  {
    %>
    <jsp:forward page="<%=url%>">
      <jsp:param name="community" value="<%=community%>"/>
    </jsp:forward>
    <%
  }else
  if(node==-1)
  {
    response.sendRedirect(url);
  }else
  {
    out.print("<frameset rows=245 cols=\"*\"><frame name=main src="+url+" frameborder=NO marginwidth=0 marginheight=0></frameset>");
  }
  return;
}




///会员注册 二级域名


  /*
  if(sn.indexOf("redcome.com")>0)
  {
    TeaSession teasession=new TeaSession(request);
    Profile p=Profile.find(sn.substring(0,sn.indexOf(".")));
    String webmasterurl=p.getStartUrl(teasession._nLanguage);
    if(webmasterurl!=null&&webmasterurl.length()>0)
    {

      }else
      {
        response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("此博客不存在.","UTF-8")+"&nexturl="+java.net.URLEncoder.encode("http://cnoocdemo.redcome.com/servlet/Node?Node=43020&Community=cnoocblog","UTF-8"));
      }
      return;
    }
*/




/////前缀为mail.的域名,全部跳转到81口上
if(sn.startsWith("mail."))
{
  response.sendRedirect("http://"+sn+":81/");
  return;
}
response.sendError(404);

if(true)
return;
%>
<!--h

//port="80"  URIEncoding="UTF-8"
maxThreads="1000"


-Xms256m -Xmx256m -XX:MaxNewSize=256m -XX:MaxPermSize=256m
-Xmx800m -XX:MaxPermSize=128m

linux:
export JAVA_OPTS='-Xms256m -Xmx512m'
-->

<!--=====Tomcat 添加 Host==========================================-->
<Host appBase="webapps" autoDeploy="false" deployXML="false" name="www.abc.com" unpackWARs="false">
<Alias></Alias>
<Context docBase="ROOT" path="" reloadable="true" useHttpOnly="true" />
</Host>

autoDeploy:默认true, 加载web.xml
reloadable:默认false, 加载classes和lib

<!--=====Weblogic web.xml==========================================-->
<!DOCTYPE web-app PUBLIC "-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN" "http://java.sun.com/dtd/web-app_2_3.dtd">
<web-app>
</web-app>
