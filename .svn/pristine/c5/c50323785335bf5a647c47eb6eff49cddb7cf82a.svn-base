<%@page contentType="text/html; charset=UTF-8"%><%@page import="tea.entity.*" %><%@page import="tea.db.*" %><%@page import="java.util.*" %><%@page import="tea.entity.node.*" %><%


Http h=new Http(request,response);
int sum=0;
int pos0=h.getInt("pos0");
int pos1=h.getInt("pos1");
String wzname=h.get("wzname","");
String bhqnameResquest = h.get("bhqname","");

StringBuilder img=new StringBuilder(),list=new StringBuilder(),par=new StringBuilder();
par.append("?bhqname="+bhqnameResquest);
if(wzname.length()>0){
	par.append("&wzname="+wzname);
}
%>
<div id="Briefing">
   <div class="reserveList">
          <div class="title"><span>红外相机数据库</span>
            <div class="arrangement">
            	<form name="form1" action="/html/papc/folder/13100959-1.htm" method="post">
					<table cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td class="th">
								保护区名称：
							</td>
							<td>
								<input name="bhqname" value="<%=bhqnameResquest %>" />
							</td>
							<td class="th">
								物种名称：
							</td>
							<td>
								<input name="wzname" value="<%=wzname %>" />
							</td>
							<td class="th">
								<input type="submit" value="查询" />
							</td>
						</tr>
					</table>
				</form>
            </div>
          </div>
<%


DbAdapter db=new DbAdapter();
try
{
  if(wzname==null || "".equals(wzname))
  {
    String sql = "select g.picture,i.wzname,count(i.wzname),max(i.pstime) " 
    				+ "from infrared i,infraredgroup g " 
    				+ "where i.bhqname like '%"+bhqnameResquest+"%' AND i.wzname = g.name "
	    			+ "group by i.wzname,g.picture ";
    db.executeQuery("select count(distinct i.wzname) from infrared i,infraredgroup g WHERE pstime IS NOT NULL AND i.bhqname like '%"+bhqnameResquest+"%' AND i.wzname = g.name");
    db.next();
    sum=db.getInt(1);
    //图片
    img.append("<div id='JKDiv_0'><ul>");
    //Iterator it=InfraredGroup.find(sql,pos0,12).iterator();
    java.sql.ResultSet rs = db.executeQuery(sql,pos0,12);
    while(rs.next())
    {
      int i = 1;
      int picture = rs.getInt(i++);
      String wzname1 = rs.getString(i++);
      int count1 = rs.getInt(i++);
      String date1 = rs.getString(i++);
      String url="?wzname="+Http.enc(wzname1)+"&bhqname="+Http.enc(bhqnameResquest);
      img.append("<li><span id='InfraredIDthumbs'><a href='"+url+"'><img src='"+(picture<1?"/res/papc/404.jpg":Attch.find(picture).path)+"' /></a></span>");
      img.append("<span id='InfraredIDsubject'><a href='"+url+"'>"+wzname1+"("+count1+")</a></span>");
      img.append("日期：<span id='InfraredIDpstime'>"+MT.f(date1)+"</span></li>");
    }
    if(sum > 12){
    	img.append("<li id='PageNum'>"+new tea.htmlx.FPNL(h.language,par.toString()+"&pos0=",pos0,sum,12));
    }
    img.append("</ul></div>");

  }else
  {
	String sql2 = "select i.node,i.wzname,i.picture,i.pstime from infrared i" 
				+ " where i.pstime IS NOT NULL AND i.wzname = '"+wzname+"' ";
    db.executeQuery("SELECT COUNT(node) FROM infrared WHERE pstime IS NOT NULL AND wzname = '"+wzname+"'");
    db.next();
    sum=db.getInt(1);

    //图片
    img.append("<div id='JKDiv_0'><ul>");
    java.sql.ResultSet rs2 = db.executeQuery(sql2,pos0,12);
    while(rs2.next())
    {
    	int node2=db.getInt(1);
        String name=db.getString(2);
        String pic=db.getString(3);
        Date time=db.getDate(4);
        if(pic==null)pic="/../papc/404.jpg";
        String url2="/html/"+h.community+"/infrared/"+node2+"-"+h.language+".htm";
        img.append("<li><span id='InfraredIDthumbs'><a href='"+url2+"' target='_blank'><img src='/res/attch"+pic.replaceFirst("TestData","170")+"' /></a></span>");
        img.append("<span id='InfraredIDsubject'><a href='"+url2+"' target='_blank'>"+name+"</a></span>");
        img.append("日期：<span id='InfraredIDpstime'>"+MT.f(time)+"</span></li>");
    }
    if(sum > 12){
    	img.append("<li id='PageNum'>"+new tea.htmlx.FPNL(h.language,par.toString()+"&pos0=",pos0,sum,12));
    }
    img.append("</ul></div>");

  }
}finally
{
  db.close();
}

img.append(list);

//out.print("document.write(\""+img.toString().replaceAll("\"","&quot;")+"\");");
out.print(img.toString());
%>

</div></div>
