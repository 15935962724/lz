<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.*" %><%@page import="tea.entity.node.*" %><%@page import="java.text.*" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.ui.*" %><%@page import="java.awt.*" %><%@page import="javax.imageio.*" %><%@page import="java.util.*" %><%@page import="java.awt.image.*" %><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);

int w=580,h=260;
BufferedImage bi=new BufferedImage(w,h,BufferedImage.TYPE_INT_RGB);
Graphics2D g=bi.createGraphics();
g.setColor(Color.WHITE);
g.fillRect(0,0,w,h);

g.setColor(Color.GRAY);
g.drawRect(0,0,w-1,200);
h-=62;

SimpleDateFormat sdf=new SimpleDateFormat("yy-MM");
Calendar c=Calendar.getInstance();

Date start=Node.sdf.parse("2009-1-6");
Date end=new Date();

int day=(int)((end.getTime()-start.getTime())/86400000L);

StringBuffer sql=new StringBuffer();
sql.append(" FROM ICSales ic INNER JOIN LeagueShop ls ON ic.leagueshop=ls.id WHERE ls.community="+DbAdapter.cite(teasession._strCommunity)+" AND ic.time>"+DbAdapter.cite(start)+" AND ic.time<"+DbAdapter.cite(end));
float max=15F;

float len=(float)w/day;
float my=(float)h/max;

//画时间线
c.setTime(start);
for(int j=0;j<day;j++)
{
  int x=(int)(j*len);
  int cday=c.get(Calendar.DAY_OF_MONTH);
  if(cday==1)
  {
    g.drawLine(x,0,x,h);
    g.drawString(sdf.format(c.getTime()),x-15,h+15);
  }
  c.add(Calendar.DAY_OF_MONTH,1);
}

Stroke s1=g.getStroke();
g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
g.setStroke(new BasicStroke(3F));


Enumeration e=ICPrice.find(teasession._strCommunity,"",0,200);
for(int i=0;e.hasMoreElements()&&i<1;i++)
{
  ICPrice icp=(ICPrice)e.nextElement();
  HashMap hm=new HashMap();
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT date,SUM(quantity) FROM ICSalesList WHERE date>="+DbAdapter.cite(start)+" AND date<"+DbAdapter.cite(end)+" AND price>="+icp.getStartPrice()+" AND price<"+icp.getEndPrice()+" GROUP BY date");
    while(db.next())
    {
      hm.put(db.getDate(1),new Integer(db.getInt(2)));
    }
  }finally
  {
    db.close();
  }
  g.fillOval(0,h+50,10,10);
  int lx=0,ly=h;
  g.setColor(ICPrice.COLOR_TYPE[i]);
  c.setTime(start);
  for(int j=0;j<day;j++)
  {
    Integer V=(Integer)hm.get(c.getTime());
    int v=V==null?0:V.intValue();
    int x=(int)(j*len);
    int y=h-(int)(v*my);
    g.drawLine(lx,ly,x,y);
//    g.fillOval(x-1,y-1,4,4);
    //
    lx=x;
    ly=y;
    c.add(Calendar.DAY_OF_MONTH,1);
  }
}

g.dispose();
ImageIO.write(bi,"PNG",response.getOutputStream());

if(true)return;
%>
