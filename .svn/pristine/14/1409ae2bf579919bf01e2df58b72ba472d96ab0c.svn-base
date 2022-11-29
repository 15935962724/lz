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

  Date start=Node.sdf.parse(request.getParameter("start"));
  Date end=Node.sdf.parse(request.getParameter("end"));


  int day=(int)((end.getTime()-start.getTime())/86400000L);

  StringBuffer sql=new StringBuffer();
  sql.append(" AND icsales IN(SELECT icsales FROM ICSales WHERE leagueshop="+leagueshop+")");
  sql.append(" AND date>="+DbAdapter.cite(start)+" AND date<"+DbAdapter.cite(end));
  int max=0;
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT SUM(quantity) FROM ICSalesList WHERE 1=1 "+sql.toString()+" GROUP BY date ORDER BY SUM(quantity) DESC");
    if(db.next())
    {
      max=db.getInt(1);
    }
  }finally
  {
    db.close();
  }

  float mx=(float)w/(day-1);
  float my=(float)h/max;

  //画时间线
  Color GRAY_E6=new Color(0xE6,0xE6,0xE6);
  c.setTime(start);
  for(int j=0;j<day;j++)
  {
    Date time=c.getTime();
    int x=(int)(j*mx);
    int cday=c.get(Calendar.DAY_OF_MONTH);

    boolean flag=cday==1;
    if(day>200)flag=cday==1;//年
    else if(day>180)flag=cday==1||cday==15;//半年
    else if(day>90)flag=cday%15==0;//季
    else flag=cday%5==0;//月
    if(flag)
    {
      g.setColor(GRAY_E6);
      g.drawLine(x,1,x,h);
      g.setColor(Color.GRAY);
      g.drawString(md.format(time),x-15,h+15);
    }
    c.add(Calendar.DAY_OF_MONTH,1);
  }
  int my2=(int)max/5;
  for(int j=1;j<5;j++)
  {
    int y=h-(int)(my2*j*my);
    g.setColor(GRAY_E6);
    g.drawLine(1,y,w-2,y);
    g.setColor(Color.GRAY);
    g.drawString(my2*j+"",2,y-2);
  }
  g.setColor(Color.GRAY);
  g.drawRect(0,0,w-1,h+2);

  Stroke s1=g.getStroke();

  g.setStroke(new BasicStroke(3F));

  if(type==0)
  {
    Enumeration e=ICPrice.find(teasession._strCommunity,"",0,5);
    for(int i=0;e.hasMoreElements();i++)
    {
      ICPrice icp=(ICPrice)e.nextElement();
      HashMap hm=f_hm(sql.toString()+" AND price>="+icp.getStartPrice()+" AND price<"+icp.getEndPrice());
      int lx=0,ly=h;
      g.setColor(ICPrice.COLOR_TYPE[i]);
      g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_DEFAULT);
      g.drawString("●"+icp.getStartPrice()+"-"+icp.getEndPrice(),i*80,h+40);
      g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
      c.setTime(start);
      for(int j=0;j<day;j++)
      {
        Integer V=(Integer)hm.get(c.getTime());
        int v=V==null?0:V.intValue();
        int x=(int)(j*mx);
        int y=h-(int)(v*my);
        g.drawLine(lx,ly,x,y);
        //g.fillOval(x-1,y-1,4,4);
        //
        lx=x;
        ly=y;
        c.add(Calendar.DAY_OF_MONTH,1);
      }
    }
  }else
  {
    int root=GoodsType.getRootId(teasession._strCommunity);
    Enumeration e=GoodsType.find(" AND father="+root,0,5);
    for(int i=0;e.hasMoreElements();i++)
    {
      GoodsType gt=(GoodsType)e.nextElement();
      HashMap hm=f_hm(sql.toString()+" AND node IN(SELECT node FROM Goods WHERE goodstype LIKE '/"+root+"/"+gt.getGoodstype()+"/%')");
      int lx=0,ly=h;
      g.setColor(ICPrice.COLOR_TYPE[i]);
      g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_DEFAULT);
      g.drawString("●"+gt.getName(teasession._nLanguage),i*80,h+40);
      g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
      c.setTime(start);
      for(int j=0;j<day;j++)
      {
        Integer V=(Integer)hm.get(c.getTime());
        int v=V==null?0:V.intValue();
        int x=(int)(j*mx);
        int y=h-(int)(v*my);
        g.drawLine(lx,ly,x,y);
        //g.fillOval(x-1,y-1,4,4);
        //
        lx=x;
        ly=y;
        c.add(Calendar.DAY_OF_MONTH,1);
      }
    }
  }
  g.dispose();
  ImageIO.write(bi,"PNG",response.getOutputStream());
  return;
}


%><%!
public HashMap f_hm(String sql)throws Exception
{
  HashMap hm=new HashMap();
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT date,SUM(quantity) FROM ICSalesList WHERE 1=1"+sql+" GROUP BY date");
    while(db.next())
    {
      hm.put(db.getDate(1),new Integer(db.getInt(2)));
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
<title>价位管理</title>
<script>
function f_submit()
{
  if(!submitDate(form1.start,"无效-开始日期")||!submitDate(form1.end,"无效-终止日期"))return false;
  var t=document.getElementById('t');
  t.src="?community="+form1.community.value+"&leagueshop=<%=leagueshop%>&start="+form1.start.value+"&end="+form1.end.value+"&type="+form1.type.value+"&img=on";
  return false;
}
function f_date(i)
{
  form1.end.value="<%=Node.sdf.format(c.getTime())%>";
  var s;
  switch(i)
  {
    case 0:
    s="<%c.add(c.MONTH,-1);out.print(Node.sdf.format(c.getTime()));%>";
    break;
    case 1:
    s="<%c.add(c.MONTH,-2);out.print(Node.sdf.format(c.getTime()));%>";
    break;
    case 2:
    s="<%c.add(c.MONTH,-3);out.print(Node.sdf.format(c.getTime()));%>";
    break;
    case 3:
    s="<%c.add(c.MONTH,-6);out.print(Node.sdf.format(c.getTime()));%>";
    break;
  }
  form1.start.value=s;
  f_submit();
}
</script>
</head>
<body id="bodynone" onload="f_date(0);">
<h1>走势图</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap>日期:<input name="start" size="12" type="text"><img onclick="showCalendar('form1.start');" src="/tea/image/public/Calendar2.gif" align="top"/>
      - <input name="end" size="12" type="text"><img onclick="showCalendar('form1.end');" src="/tea/image/public/Calendar2.gif" align="top"/></td>
    <td nowrap>分类:<select name="type"><option value="0">价位</option><option value="1">类别</option></select></td>
    <td nowrap><input type="submit" value="查询" onclick="return f_submit();"/></td>
  </tr>
</table>
</form>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td colspan="2">
      <img id="t" src="/tea/image/public/load3.gif" ></td>
  </tr>
  <tr><td><a href="###" onclick="window.open(t.src,'_self')">下载走势图</a><td>时间范围 <a href="###" onclick="f_date(0)">1个月</a> <a href="###" onclick="f_date(1)">1季度</a> <a href="###" onclick="f_date(2)">半年</a> <a href="###" onclick="f_date(3)">1年</a></td></tr>
</table>

</body>
</html>
