<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource"  %><%@ page  import="tea.entity.criterion.*"   %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

response.setContentType("application/x-msdownload");
request.setCharacterEncoding("UTF-8");
String name=request.getParameter("name");
//if(name==null)
name="工作表1";

String act=request.getParameter("act");
String sql=request.getParameter("sql");
String community=request.getParameter("community");

response.setHeader("Content-Disposition", "attachment; filename=" +java.net.URLEncoder.encode(name+".xls","UTF-8"));

jxl.write.WritableWorkbook wwb=jxl.Workbook.createWorkbook(response.getOutputStream());
jxl.write.WritableSheet ws=wwb.createSheet(name,0);

if("Itemoutlays2.jsp".equals(act))
{
  ws.addCell(new jxl.write.Label(0,0,"序号"));
  ws.addCell(new jxl.write.Label(1,0,"经费类别"));
  ws.addCell(new jxl.write.Label(2,0,"项目名称"));
  ws.addCell(new jxl.write.Label(3,0,"拨付金额"));
  ws.addCell(new jxl.write.Label(4,0,"拨付时间"));

  java.util.Enumeration enumer=Itemoutlay.find(community,sql,0,Integer.MAX_VALUE);
  for(int index=1;enumer.hasMoreElements();index++)
  {
    int itemoutlay=((Integer)enumer.nextElement()).intValue();
    Itemoutlay obj=Itemoutlay.find(itemoutlay);

    Outlay outlay=Outlay.find(obj.getOutlay());
    Item item=Item.find(obj.getItem());


    ws.addCell(new jxl.write.Number(0,index,index));
    ws.addCell(new jxl.write.Label(1,index,outlay.getType()));
    ws.addCell(new jxl.write.Label(2,index,item.getName()));
    ws.addCell(new jxl.write.Number(3,index,obj.getMoney().doubleValue()));
    ws.addCell(new jxl.write.Label(4,index,obj.getTimeToString()));
  }
}else
if("Outlays2.jsp".equals(act))
{
  ws.addCell(new jxl.write.Label(0,0,"序号"));
  ws.addCell(new jxl.write.Label(1,0,"经费类别"));
  ws.addCell(new jxl.write.Label(2,0,"经费数额"));
  ws.addCell(new jxl.write.Label(3,0,"拨付时间"));
  ws.addCell(new jxl.write.Label(4,0,"已划拨经费"));
  ws.addCell(new jxl.write.Label(5,0,"剩余经费"));

  java.util.Enumeration enumer=Outlay.find(community,sql.toString(),0,Integer.MAX_VALUE);
  for(int index=1;enumer.hasMoreElements();index++)
  {
    int outlay=((Integer)enumer.nextElement()).intValue();
    Outlay obj=Outlay.find(outlay);

    java.math.BigDecimal payment=Itemoutlay.findPaymentByOutlay(outlay);



    ws.addCell(new jxl.write.Number(0,index,index));
    ws.addCell(new jxl.write.Label(1,index,obj.getType()));
    ws.addCell(new jxl.write.Number(2,index,obj.getMoney().doubleValue()));
    ws.addCell(new jxl.write.Label(3,index,obj.getTimeToString()));
    ws.addCell(new jxl.write.Number(4,index,payment.doubleValue()));
    ws.addCell(new jxl.write.Number(5,index,obj.getMoney().subtract(payment).doubleValue()));
  }
}else
if("Itemoutlays3.jsp".equals(act))//项目经费明细表
{
  ws.addCell(new jxl.write.Label(0,0,"序号"));
  ws.addCell(new jxl.write.Label(1,0,"项目计划号"));
  ws.addCell(new jxl.write.Label(2,0,"项目名称"));
  ws.addCell(new jxl.write.Label(3,0,"项目类别"));
  ws.addCell(new jxl.write.Label(4,0,"总经费"));
  ws.addCell(new jxl.write.Label(5,0,"已拨经费"));
  ws.addCell(new jxl.write.Label(6,0,"项目目前状态"));
  ws.addCell(new jxl.write.Label(7,0,"项目"+Item.ROLE_PRINCIPAL));
  ws.addCell(new jxl.write.Label(8,0,"是否已拨足经费"));

  java.util.Enumeration enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
  for(int index=1;enumer.hasMoreElements();index++)
  {
    int item=((Integer)enumer.nextElement()).intValue();
    Item obj=Item.find(item);

    java.math.BigDecimal payment=Itemoutlay.findPaymentByItem(item);
/*
    String str;
    payment=payment.subtract(obj.getOutlay());
    if(payment.floatValue()<0.0F)
    {
      str=("否");
    }else
    {
      str=("是");
    }
*/
    ws.addCell(new jxl.write.Number(0,index,index));
    ws.addCell(new jxl.write.Label(1,index,obj.getCode()));
    ws.addCell(new jxl.write.Label(2,index,obj.getName()));
    ws.addCell(new jxl.write.Label(3,index,Item.ITEM_TYPE[obj.getType()]));
    ws.addCell(new jxl.write.Number(4,index,ItemBudget.getTotal(item).doubleValue()));
    ws.addCell(new jxl.write.Number(5,index,payment.doubleValue()));
    ws.addCell(new jxl.write.Label(6,index,Item.STATES_TYPE[obj.getStates()]));
    ws.addCell(new jxl.write.Label(7,index,obj.getPrincipal()));
    ws.addCell(new jxl.write.Label(8,index,obj.isAdequate()?"是":"否"));
  }
}else
if("Items.jsp".equals(act))//计划或正在执行的项目清单
{
  ws.addCell(new jxl.write.Label(0,0,"序号"));
  ws.addCell(new jxl.write.Label(1,0,"项目计划号"));
  ws.addCell(new jxl.write.Label(2,0,"项目名称"));
  ws.addCell(new jxl.write.Label(3,0,"项目类别"));
  ws.addCell(new jxl.write.Label(4,0,"计划年度"));
  ws.addCell(new jxl.write.Label(5,0,"编制单位"));
  ws.addCell(new jxl.write.Label(6,0,"备注"));

  java.util.Enumeration enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
  for(int index=1;enumer.hasMoreElements();index++)
  {
    int item=((Integer)enumer.nextElement()).intValue();
    Item obj=Item.find(item);

    Itemmember im_obj=Itemmember.find(obj.getSupermanager(),community);

    tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(im_obj.getOldunit());//obj.getEditgroup());
    String au_name="";
    if(au_obj.getName()!=null)
    au_name=(au_obj.getName());

    ws.addCell(new jxl.write.Number(0,index,index));
    ws.addCell(new jxl.write.Label(1,index,obj.getCode()));
    ws.addCell(new jxl.write.Label(2,index,obj.getName()));
    ws.addCell(new jxl.write.Label(3,index,Item.ITEM_TYPE[obj.getType()]));
    ws.addCell(new jxl.write.Number(4,index,obj.getPlanyear()));
    ws.addCell(new jxl.write.Label(5,index,au_name));
    ws.addCell(new jxl.write.Label(6,index,obj.getRemark()));
  }
}else
if("Itemstates.jsp".equals(act))//项目执行情况
{
  ws.addCell(new jxl.write.Label(0,0,"序号"));
  ws.addCell(new jxl.write.Label(1,0,"项目计划号"));
  ws.addCell(new jxl.write.Label(2,0,"项目名称"));
  ws.addCell(new jxl.write.Label(3,0,"编制单位"));
  ws.addCell(new jxl.write.Label(4,0,"总经费"));
  ws.addCell(new jxl.write.Label(5,0,"已拨经费"));
  ws.addCell(new jxl.write.Label(6,0,"目前状态"));
  ws.addCell(new jxl.write.Label(7,0,"项目主管"));
  ws.addCell(new jxl.write.Label(8,0,"是否已拨足经费"));
  ws.addCell(new jxl.write.Label(9,0,"是否延迟"));

  java.util.Enumeration enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
  for(int index=1;enumer.hasMoreElements();index++)
  {
    int item=((Integer)enumer.nextElement()).intValue();
    Item obj=Item.find(item);

    Itemmember im_obj=Itemmember.find(obj.getSupermanager(),community);

    tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(im_obj.getOldunit());//obj.getEditgroup());
    String au_name="";
    if(au_obj.getName()!=null)
    au_name=(au_obj.getName());

    ws.addCell(new jxl.write.Number(0,index,index));
    ws.addCell(new jxl.write.Label(1,index,obj.getCode()));
    ws.addCell(new jxl.write.Label(2,index,obj.getName()));
    ws.addCell(new jxl.write.Label(3,index,au_name));
    ws.addCell(new jxl.write.Number(4,index,obj.getOutlay().doubleValue()));
    ws.addCell(new jxl.write.Number(5,index,Itemoutlay.findPaymentByItem(item).doubleValue()));
    ws.addCell(new jxl.write.Label(6,index,Item.STATES_TYPE[obj.getStates()]));
    ws.addCell(new jxl.write.Label(7,index,obj.getPrincipal()));
    ws.addCell(new jxl.write.Label(8,index,obj.isAdequate()?"是":"否"));
    ws.addCell(new jxl.write.Label(9,index,obj.isDefer()?"是":"否"));
  }
}else
if("FinishedItems.jsp".equals(act))//已发布标准的项目
{
  ws.addCell(new jxl.write.Label(0,0,"序号"));
  ws.addCell(new jxl.write.Label(1,0,"项目计划号"));
  ws.addCell(new jxl.write.Label(2,0,"项目名称"));
  ws.addCell(new jxl.write.Label(3,0,"标准编号"));
  ws.addCell(new jxl.write.Label(4,0,"批准时间"));
  ws.addCell(new jxl.write.Label(5,0,"发布时间"));
  ws.addCell(new jxl.write.Label(6,0,"实施时间"));
  ws.addCell(new jxl.write.Label(7,0,"是否现行标准"));
  ws.addCell(new jxl.write.Label(8,0,"编制单位"));
  ws.addCell(new jxl.write.Label(9,0,"备注"));

  java.util.Enumeration enumer=Item.find(community,sql.toString(),0,Integer.MAX_VALUE);
  for(int index=1;enumer.hasMoreElements();index++)
  {
    int item=((Integer)enumer.nextElement()).intValue();
    Item obj=Item.find(item);

    Itemmember im_obj=Itemmember.find(obj.getSupermanager(),community);
    tea.entity.admin.AdminUnit au_obj=tea.entity.admin.AdminUnit.find(im_obj.getOldunit());//obj.getEditgroup());
    String au_name="";
    if(au_obj.getName()!=null)
    au_name=(au_obj.getName());

    ws.addCell(new jxl.write.Number(0,index,index));
    ws.addCell(new jxl.write.Label(1,index,obj.getCode()));
    ws.addCell(new jxl.write.Label(2,index,obj.getName()));
    ws.addCell(new jxl.write.Label(3,index,obj.getNumber()));
    ws.addCell(new jxl.write.Label(4,index,obj.getGranttimeToString()));
    ws.addCell(new jxl.write.Label(5,index,obj.getIssuetimeToString()));
    ws.addCell(new jxl.write.Label(6,index,obj.getActualizetimeToString()));
    ws.addCell(new jxl.write.Label(7,index,obj.isNonce()?"是":"否"));
    ws.addCell(new jxl.write.Label(8,index,au_name));
    ws.addCell(new jxl.write.Label(9,index,obj.getRemark()));
  }
}else
if("BudgetItems.jsp".equals(act))//项目经费预算
{
  ws.addCell(new jxl.write.Label(0,0,"序号"));
  ws.addCell(new jxl.write.Label(1,0,"计划号"));
  ws.addCell(new jxl.write.Label(2,0,"项目名称"));
  ws.addCell(new jxl.write.Label(3,0,"经费类别"));
  ws.addCell(new jxl.write.Label(4,0,"年度"));
  ws.addCell(new jxl.write.Label(5,0,"经费金额"));

  java.util.Enumeration enumer=ItemBudget.find(community,sql.toString(),0,Integer.MAX_VALUE);
  for(int index=1;enumer.hasMoreElements();index++)
  {
    int itembudget=((Integer)enumer.nextElement()).intValue();
    ItemBudget obj=ItemBudget.find(itembudget);
    int item=obj.getItem();
    Item item_obj=Item.find(item);

    ws.addCell(new jxl.write.Number(0,index,index));
    ws.addCell(new jxl.write.Label(1,index,item_obj.getCode()));
    ws.addCell(new jxl.write.Label(2,index,item_obj.getName()));
    ws.addCell(new jxl.write.Label(3,index,obj.isBudgettype()?"总经费预算":"年度经费预算"));
    ws.addCell(new jxl.write.Number(4,index,obj.getBudgetyear()));
    ws.addCell(new jxl.write.Number(5,index,obj.getBudgetoutlay().doubleValue()));
  }
}else
if("Itemoutlays.jsp".equals(act))//经费划拨
{
  ws.addCell(new jxl.write.Label(0,0,"序号"));
  ws.addCell(new jxl.write.Label(1,0,"计划号"));
  ws.addCell(new jxl.write.Label(2,0,"项目名称"));
  ws.addCell(new jxl.write.Label(3,0,"编制单位"));
  ws.addCell(new jxl.write.Label(4,0,"本经费来源"));
  ws.addCell(new jxl.write.Label(5,0,"拨付经费"));
  ws.addCell(new jxl.write.Label(6,0,"拨付年度"));
  ws.addCell(new jxl.write.Label(7,0,"拨付日期"));

  java.util.Enumeration enumer=Itemoutlay.find(community,sql.toString(),0,Integer.MAX_VALUE);
  for(int index=1;enumer.hasMoreElements();index++)
  {
    int itemoutlay=((Integer)enumer.nextElement()).intValue();
    Itemoutlay obj=Itemoutlay.find(itemoutlay);

    Item item=Item.find(obj.getItem());
    Outlay outlay_obj=Outlay.find(obj.getOutlay());

    Itemmember im_obj=Itemmember.find(item.getSupermanager(),community);
    String au_name=tea.entity.admin.AdminUnit.find(im_obj.getOldunit()).getName();//item.getEditgroup()
    if(au_name==null)au_name="";

    ws.addCell(new jxl.write.Number(0,index,index));
    ws.addCell(new jxl.write.Label(1,index,item.getCode()));
    ws.addCell(new jxl.write.Label(2,index,item.getName()));
    ws.addCell(new jxl.write.Label(3,index,au_name));
    ws.addCell(new jxl.write.Label(4,index,outlay_obj.getType()));
    ws.addCell(new jxl.write.Number(5,index,obj.getMoney().doubleValue()));
    ws.addCell(new jxl.write.Number(6,index,obj.getPoyear()));
    ws.addCell(new jxl.write.Label(7,index,obj.getTimeToString()));
  }
}
wwb.write();
wwb.close();

if(true)
return;
%>

