<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String act = teasession.getParameter("act");
//座位设置 中 添加 总排数和总列数
if("form1_right_seat".equals(act))
{
  Seat sobj = Seat.find(teasession._nNode);
  int linage = 0;
  if(teasession.getParameter("linage")!=null && teasession.getParameter("linage").length()>0)
  {
    linage = Integer.parseInt(teasession.getParameter("linage"));
  }
  int row = 0;
  if(teasession.getParameter("row")!=null && teasession.getParameter("row").length()>0)
  {
    row = Integer.parseInt(teasession.getParameter("row"));
  }

  if(sobj.isExists())//如果有这个 node号 修改
  {
    sobj.set(linage,row);
  }
  else
  {
    Seat.create(teasession._nNode,linage,row,teasession._strCommunity,teasession._rv.toString());
  }
  return;
}else if("form2_right_seat".equals(act))//座位编辑
{
  //&seid="+form1.seid.value+"&region="+encodeURIComponent(form1.region.value)+"&linagenumber="+from1.linagenumber.value+"&seatnumber="+from1.seatnumber.value+"&picid="+encodeURIComponent(from1.picid.value),
 //坐标编号
 int seid = 0;
 if(teasession.getParameter("seid")!=null && teasession.getParameter("seid").length()>0)
 {
   seid = Integer.parseInt(teasession.getParameter("seid"));
 }
 //区域
 String region= teasession.getParameter("region");
 //排号
 int linagenumber =0;
 if(teasession.getParameter("linagenumber")!=null && teasession.getParameter("linagenumber").length()>0)
 {
   linagenumber = Integer.parseInt(teasession.getParameter("linagenumber"));
 }
 //座号
 int seatnumber = 0;
 if(teasession.getParameter("seatnumber")!=null && teasession.getParameter("seatnumber").length()>0)
 {
   seatnumber = Integer.parseInt(teasession.getParameter("seatnumber"));
 }
 //视图 图片
 int picid = 0;
 if(teasession.getParameter("picid")!=null && teasession.getParameter("picid").length()>0)
 {
   picid = Integer.parseInt(teasession.getParameter("picid"));
 }

 SeatEditor seobj = SeatEditor.find(seid,teasession._nNode);
 if(seobj.isExists())
 {
   seobj.set(region,linagenumber,seatnumber,picid);
 }else
 {
   SeatEditor.create(seid,teasession._nNode,region,linagenumber,seatnumber,picid,teasession._strCommunity,teasession._rv.toString());
 }
 out.print("<font  color=red>添加成功！</font>");
 return;
}else if("form1_delete".equals(act))
{
	//删除坐标编号
	 int seid = 0;
	 if(teasession.getParameter("seid")!=null && teasession.getParameter("seid").length()>0)
	 {
	   seid = Integer.parseInt(teasession.getParameter("seid"));
	 } 
	  SeatEditor seobj = SeatEditor.find(seid,teasession._nNode);
	  seobj.delete();
	  return;
}  


%>

