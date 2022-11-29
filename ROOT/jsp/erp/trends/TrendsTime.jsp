<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.node.*" %><%@page import="java.text.*" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.ui.*" %><%@page import="java.awt.*" %><%@page import="javax.imageio.*" %><%@page import="java.util.*" %><%@page import="java.awt.image.*" %><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
int leagueshop=Integer.parseInt(request.getParameter("leagueshop"));

Calendar c=Calendar.getInstance();



if(request.getParameter("img")!=null)
{
  response.setHeader("Content-Disposition", "attachment; filename=trends.png");
  int w=580,h=260;
  BufferedImage bi=new BufferedImage(w,h,BufferedImage.TYPE_INT_RGB);
  Graphics2D g=bi.createGraphics();
  g.setColor(Color.WHITE);
  g.fillRect(0,0,w,h);

  h-=60;

  SimpleDateFormat sdf=new SimpleDateFormat("yy-MM");
  SimpleDateFormat md=new SimpleDateFormat("MM-dd");
  int type=Integer.parseInt(request.getParameter("type"));

  c.add(c.DAY_OF_MONTH,-3);
  Date start=c.getTime();
  Date end=new Date();

  StringBuffer sql=new StringBuffer();
  sql.append(" AND icsales IN(SELECT icsales FROM ICSales WHERE leagueshop="+leagueshop+")");
  float max=0;
  int maxh=0;
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT SUM(quantity) FROM ICSalesList WHERE 1=1"+sql.toString()+" AND date>="+DbAdapter.cite(start)+" GROUP BY hour ORDER BY SUM(quantity) DESC");
    if(db.next())
    {
      maxh=db.getInt(1);
      max=(float)(h-20)/maxh;
    }
  }finally
  {
    db.close();
  }
  Color GRAY_E6=new Color(0xE6,0xE6,0xE6);
  g.setColor(Color.GRAY);
  for(int j=0;j<24;j++)
  {
    g.drawString(j+"",25*j,h+15);
  }
  if(maxh==0)
  {
    g.drawString("暂无消费记录",w/2-50,h/2);
  }else
  for(int j=1;j<6;j++)
  {
    float hh=maxh/5F*j;
    int y=h-(int)(hh*max);
    System.out.println(j+":"+y);
    g.setColor(GRAY_E6);
    g.drawLine(0,y,w,y);
    g.setColor(Color.GRAY);
    g.drawString(String.valueOf((int)hh),2,y-5);
  }
  g.drawLine(0,h,w,h);
  String DAY_TYPE[]={"后天","昨天","今天"};
  for(int i=0;i<3;i++)
  {
    g.setColor(ICPrice.COLOR_TYPE[i]);
    g.drawString("●"+DAY_TYPE[i],i*80,h+40);
    HashMap hm=f_hm(sql.toString()+" AND date="+DbAdapter.cite(c.getTime()),"hour");
    for(int j=0;j<24;j++)
    {
      Object tmp=hm.get(Integer.valueOf(j));
      int v=tmp==null?0:(int)(((Integer)tmp).intValue()*max);
      g.fillRect(25*j+i*6,h-v,6,v);
    }
    c.add(c.DAY_OF_MONTH,1);
  }
  g.dispose();
  ImageIO.write(bi,"PNG",response.getOutputStream());
  return;
}


%><%!
public HashMap f_hm(String sql,String f)throws Exception
{
  HashMap hm=new HashMap();
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT "+f+",SUM(quantity) FROM ICSalesList WHERE 1=1"+sql+" GROUP BY "+f);
    while(db.next())
    {
      hm.put(new Integer(db.getInt(1)),new Integer(db.getInt(2)));
    }
  }finally
  {
    db.close();
  }
  return hm;
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>id</title>
<script>
function f_date(type)
{
  var t=document.getElementById('t');
  t.src="?community=<%=teasession._strCommunity%>&leagueshop=<%=leagueshop%>&type="+type+"&img=on";
  return false;
}
</script>
</head>
<body id="bodynone" onload="f_date(0);">
<h1>走势图</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td colspan="2"><img id="t" src="/tea/image/public/load3.gif" ></td>
  </tr>
  <tr>
    <td><a href="###" onclick="window.open(t.src,'_self')">下载走势图</a></td>
    <!--
    <td>时间范围 <a href="###" onclick="f_date(0)">时统计</a> <a href="###" onclick="f_date(1)">天统计</a> <a href="###" onclick="f_date(2)">月统计</a> <a href="###" onclick="f_date(3)">年</a></td>
    -->
  </tr>
</table>

</body>
</html>
