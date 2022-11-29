<%@page contentType="text/html; charset=UTF-8"%><%@page import="tea.entity.*" %><%@page import="tea.db.*" %><%@page import="java.util.*" %><%@page import="tea.entity.node.*" %><%


Http h=new Http(request,response);


int sum=0;
int pos0=h.getInt("pos0");
int pos1=h.getInt("pos1");
String wzname=h.get("wzname");

StringBuilder img=new StringBuilder(),list=new StringBuilder(),par=new StringBuilder();

par.append("?node="+h.node);
if(wzname!=null)
{
  par.append("&wzname="+Http.enc(wzname));
}

DbAdapter db=new DbAdapter();
try
{
  if(wzname==null)
  {
    String sql=" ORDER BY sequence";
    sum=InfraredGroup.count("");

    //图片
    img.append("<div id='JKDiv_0' style='display:none'><ul>");
    Iterator it=InfraredGroup.find(sql,pos0,12).iterator();
    while(it.hasNext())
    {
      InfraredGroup ig=(InfraredGroup)it.next();
      String url="?wzname="+Http.enc(ig.name);
      img.append("<li><span id='InfraredIDthumbs'><a href='"+url+"' target='_blank'><img src='"+(ig.picture<1?"/res/papc/404.jpg":Attch.find(ig.picture).path)+"' /></a></span>");
      img.append("<span id='InfraredIDsubject'><a href='"+url+"' target='_blank'>"+ig.name+"("+ig.count+")</a></span>");
      img.append("日期：<span id='InfraredIDpstime'>"+MT.f(ig.utime)+"</span></li>");
    }
    img.append("<li id='PageNum'>"+new tea.htmlx.FPNL(h.language,par.toString()+"&pos0=",pos0,sum,12));
    img.append("</ul></div>");

    //列表
    list.append("<div class='list' id='JKDiv_1' style='display:none'><ul>");
    it=InfraredGroup.find(sql,pos1,26).iterator();
    while(it.hasNext())
    {
      InfraredGroup ig=(InfraredGroup)it.next();
      String url="?wzname="+Http.enc(ig.name);
      list.append("<li><span id='InfraredIDsubject'><a href='"+url+"' target='_blank'>"+ig.name+"("+ig.count+")</a></span>");
      list.append("&nbsp;[<span id='InfraredIDpstime'>"+MT.f(ig.utime,1)+"</span>]</li>");
    }
    list.append("<li id='PageNum'>"+new tea.htmlx.FPNL(h.language,par.toString()+"&pos1=",pos1,sum,26));
    list.append("</ul></div>");
  }else
  {
    String sql=" pstime IS NOT NULL AND wzname LIKE "+DbAdapter.cite("%"+wzname+"%");
    db.executeQuery("SELECT COUNT(*) FROM infrared WHERE"+sql);
    db.next();
    sum=db.getInt(1);

    //图片
    img.append("<div id='JKDiv_0' style='display:none'><ul>");
    db.executeQuery("SELECT node,wzname,picture,pstime FROM infrared WHERE"+sql,pos0,12);
    while(db.next())
    {
      int node=db.getInt(1);
      String name=db.getString(2);
      String pic=db.getString(3);
      Date time=db.getDate(4);
      if(pic==null)pic="/../papc/404.jpg";
      String url="/html/"+h.community+"/infrared/"+node+"-"+h.language+".htm";
      img.append("<li><span id='InfraredIDthumbs'><a href='"+url+"' target='_blank'><img src='/res/attch"+pic.replaceFirst("TestData","170")+"' /></a></span>");
      img.append("<span id='InfraredIDsubject'><a href='"+url+"' target='_blank'>"+name+"</a></span>");
      img.append("日期：<span id='InfraredIDpstime'>"+MT.f(time)+"</span></li>");
    }
    img.append("<li id='PageNum'>"+new tea.htmlx.FPNL(h.language,par.toString()+"&pos0=",pos0,sum,12));
    img.append("</ul></div>");

    //列表
    list.append("<div class='list' id='JKDiv_1' style='display:none'><ul>");
    db.executeQuery("SELECT node,wzname,picture,pstime FROM infrared WHERE"+sql,pos1,26);
    while(db.next())
    {
      int node=db.getInt(1);
      String name=db.getString(2);
      String pic=db.getString(3);
      Date time=db.getDate(4);
      String url="/html/"+h.community+"/infrared/"+node+"-"+h.language+".htm";
      list.append("<li><span id='InfraredIDsubject'><a href='"+url+"' target='_blank'>"+name+"</a></span>");
      list.append("&nbsp;[<span id='InfraredIDpstime'>"+MT.f(time,1)+"</span>]</li>");
    }
    list.append("<li id='PageNum'>"+new tea.htmlx.FPNL(h.language,par.toString()+"&pos1=",pos1,sum,26));
    list.append("</ul></div>");
  }
}finally
{
  db.close();
}

img.append(list);

//out.print("document.write(\""+img.toString().replaceAll("\"","&quot;")+"\");");
out.print(img.toString());
%>
