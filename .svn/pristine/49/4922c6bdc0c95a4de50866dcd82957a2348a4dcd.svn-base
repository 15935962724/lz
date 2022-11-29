<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.*"%><%@page import="java.io.*"%><%@page import="tea.entity.*"%><%@page import="java.util.regex.*"%><%@page import="java.awt.image.*"%><%@page import="java.awt.color.*"%><%@page import="java.util.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.ui.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.entity.member.*"%><%!


Pattern P_LAY=Pattern.compile("<a id=pageLink href=(node_\\d+\\.htm)>([^<]+)</a>");
Pattern P_NEW=Pattern.compile("<a href=(content_\\d+\\.htm)>");
Pattern P_CONTENT_t=Pattern.compile(">\\[([^<]+)\\]<");//>[漫笔天下·民族国家的昨天·今天·明天]<
//Pattern P_CONTENT_s=Pattern.compile(">([^<]+)</strong><br>");//"> 藏胞归国参观团，带海外藏胞回家看看  </strong><br>民族报
Pattern P_CONTENT_s=Pattern.compile("class=\"font01\" align=center>([^<]+)</td> </TR>");//"> 藏胞归国参观团，带海外藏胞回家看看  </strong><br>服饰报
Pattern P_CONTENT_sh=Pattern.compile(">——([^<]+)<");//>——追忆上世纪三四十年代的边疆史地研究热<
Pattern P_CONTENT_a=Pattern.compile(">□ ([^<]+)<");//>□ 李明浩<
Pattern P_CONTENT_c=Pattern.compile("<founder-content>(.+)</founder-content>");//内容

public String read(File f)throws IOException
{
  byte by[]=new byte[(int)f.length()];
  FileInputStream fis=new FileInputStream(f);
  fis.read(by);
  fis.close();
  return new String(by,"utf-8");
}

%><%

//http://www.mzzjw.cn/zgmzb/html/2001-06/05/node_2.htm
//

TeaSession teasession=new TeaSession(request);


CommunityOption co=CommunityOption.find(teasession._strCommunity);
String path=co.get("e-news.path");
int node=co.getInt("e-news.node");

if("POST".equals(request.getMethod()))
{
  node=teasession._nNode;
  path=request.getParameter("path");
  File dir=new File(path);
  if(!dir.exists())
  {
    response.sendRedirect("/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+java.net.URLEncoder.encode("路径不正确!!!","UTF-8"));
    return ;
  }
  co.set("e-news.path",path);
  co.set("e-news.node",String.valueOf(node));
  out.print("<img src='/tea/image/public/load.gif' /><span id=s>扫描中...</script>");
  out.flush();
  Node n=Node.find(node);
  File f1[]=dir.listFiles();
  for(int i=0;i<f1.length;i++)
  {
    if(f1[i].isFile())continue;
    String year=f1[i].getName();
    int nid_year=Node.findBySyncId(year);
    if(nid_year==0)//年-月
    {
      out.print("<script>s.innerHTML='创建 "+year+" 栏目';</script>");
      out.flush();
      nid_year=Node.create(node,0,n.getCommunity(),new RV("webmaster"),0,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),null,null,Node.sdf.parse(year+"-01"),0,0,0,0,null,year,1,year,"","",null,null,0,null,null,null,null,null,null,null);
      n.finished(nid_year);
    }
    File f2[]=f1[i].listFiles();
    for(int x=0;x<f2.length;x++)
    {
      if(f2[x].isFile())continue;
      String dayname=f2[x].getName();
      String day=year+"/"+dayname;
      Date time=Node.sdf.parse(year+"-"+dayname);
      int nid_day=Node.findBySyncId(day);
      if(nid_day==0)//日
      {
        out.print("<script>s.innerHTML='创建 "+day+" 栏目';</script>");
        out.flush();
        nid_day=Node.create(nid_year,0,n.getCommunity(),new RV("webmaster"),0,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),null,null,time,0,0,0,0,"http://cfw.redcome.com/zgfsb/html/"+day+"/node_2.htm",day,1,dayname,"","",null,null,0,null,null,null,null,null,null,null);
      }
     // File f=new File(f2[x],"node_2.htm");
   File f=new File(f2[x],"node_93.htm");

      if(!f.exists())continue;
      String h=read(f);
      Matcher m=P_LAY.matcher(h);
      while(m.find())//版
      {
        String layout=day+"/"+m.group(1);
        String layname=m.group(2);
        int nid_lay=Node.findBySyncId(layout);
        if(nid_lay>0)
        {
          out.print("<script>s.innerHTML='"+layout+" 版,已存在 [跳过]';</script>");
          out.flush();
          continue;
        }else
        {
          out.print("<script>s.innerHTML='创建 "+layout+" 版';</script>");
          out.flush();
          nid_lay=Node.create(nid_day,0,n.getCommunity(),new RV("webmaster"),1,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),null,null,time,0,0,0,0,"http://cfw.redcome.com/zgmzb/html/"+layout,layout,1,layname,"","",null,null,0,null,null,null,null,null,null,null);
          n.finished(nid_lay);
        }
        //新闻
        String news=read(new File(dir,layout));
        Matcher m_new=P_NEW.matcher(news);
        while(m_new.find())
        {
          String newsid=day+"/"+m_new.group(1);
          int nid_39=Node.findBySyncId(newsid);
          if(nid_39==0)
          {
            String hc=read(new File(dir,newsid));

            String locus="",subject="",subhead="",author="",content="";
            Matcher m_c=P_CONTENT_t.matcher(hc);//地点

            if(m_c.find())
            {
              locus=m_c.group(1);
            }
            m_c=P_CONTENT_s.matcher(hc);//主题

            if(m_c.find())
            {
              subject=m_c.group(1).trim();
            }
            m_c=P_CONTENT_sh.matcher(hc);//副标题
            if(m_c.find())
            {
              subhead=m_c.group(1);
            }
            m_c=P_CONTENT_a.matcher(hc);//作者
            if(m_c.find())
            {
              author=m_c.group(1);
            }
            m_c=P_CONTENT_c.matcher(hc);//内容
            if(m_c.find())
            {
              content=m_c.group(1);
            }
            //out.print("s.innerHTML=\"创建 "+subject.replace('"','＂')+" 新闻\";");
            //out.flush();
            nid_39=Node.create(nid_lay,0,n.getCommunity(),new RV("webmaster"),39,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),null,null,time,0,0,0,0,"http://cfw.redcome.com/zgmzb/html/"+newsid,newsid,1,subject,"",content,null,null,0,null,null,null,null,null,null,null);
            Report.create(nid_39,0,0,time,1,null,locus,subhead,author,"","",0);
            n.finished(nid_39);
          }
        } //news end

      }
    }
  }
  out.print("<script>location.replace('/jsp/info/Succeed.jsp?community="+teasession._strCommunity+"');</script>");
  return;
}





int root=Community.find(teasession._strCommunity).getNode();

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>导入电子报</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1>导入电子报</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>

<form action="?" method="post" onsubmit="return submitText(this.path,'无效-路径')&&submitText(this.node,'无效-节点')">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>电子报纸的发布路径:</td>
    <td><input name="path" type="text" size="50" value="<%if(path!=null)out.print(path);%>" /></td>
  </tr>
  <tr>
    <td>复制到那个页面:</td>
    <td>
      <select name="node">
      <option value="">-------------------</option>
      <%
Enumeration e=Node.find(" AND path LIKE '/"+root+"/%' AND type=0",0,200);
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  Node n=Node.find(id);
  out.print("<option value="+id);
  if(node==id)out.print(" selected='true'");
  out.print(">"+n.getSubject(teasession._nLanguage));
}
      %>
      </select>
    </td>
  </tr>
</table>

<input type="submit" value="提交">
</form>

</body>
</html>
