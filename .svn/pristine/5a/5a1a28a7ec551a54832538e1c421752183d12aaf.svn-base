<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.text.*" %><%@page import="java.util.*" %>
<%@page import="tea.entity.admin.orthonline.*"%> <%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
//if(teasession._rv==null)
//{
//  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
//  return;
//}

String act =teasession.getParameter("act");
int doid = 0;
if(teasession.getParameter("doid")!=null && teasession.getParameter("doid").length()>0)
{
  doid = Integer.parseInt(teasession.getParameter("doid"));
}
int shiid=0;
if(teasession.getParameter("shiid")!=null && teasession.getParameter("shiid").length()>0)
{
  shiid = Integer.parseInt(teasession.getParameter("shiid"));
}

Doctor doobj = Doctor.find(doid);


//选择市县ajax
if("city".equals(act))
{
  //是下拉框变灰的参数
  String bool = teasession.getParameter("bool");
  int sheng = 0;//省份id
  if(teasession.getParameter("sheng")!=null && teasession.getParameter("sheng").length()>0)
  {
     sheng = Integer.parseInt(teasession.getParameter("sheng"));
  }else
  {
    sheng = doobj.getSheng();
  }

String s ="";
if(sheng>0)
{
  s=" and type="+sheng;
}else
{
  s=" and type=-1";
}

  java.util.Enumeration e = Provinces.find(s+"  ORDER BY provincity ASC ");
  out.print("<select name=\"shi\"  onchange=f_shi(); ");
  if("true".equals(bool))
  {
    out.print(" disabled");
  }
  out.print(">");
  out.print("<option value=\"0\">请选择市/县</option>");
  while(e.hasMoreElements())
  {
    int pid = ((Integer)e.nextElement()).intValue();
    Provinces probj = Provinces.find(pid);
    out.print("<option value="+pid);

    if(shiid==0&&doobj.getShi()==pid)
    {
      out.print(" selected ");
    }else if(shiid>0 && shiid==pid)
    {
      out.print(" selected ");
    }

    out.print(">"+probj.getProvincity());
    out.print("</option>");
  }
  out.print("</select>");
  return;
}
if("gongzuodanwei".equals(act))
{
  int sheng = 0;//省份id
  if(teasession.getParameter("sheng")!=null && teasession.getParameter("sheng").length()>0)
  {
    sheng = Integer.parseInt(teasession.getParameter("sheng"));
  }else
  {
    sheng = doobj.getSheng();
  }
  int shi = Integer.parseInt(teasession.getParameter("shi"));//市
  if(shi>0)
  {
    shi = Integer.parseInt(teasession.getParameter("shi"));
  }else
  {
     shi = doobj.getShi();
  }
  int gongzuodanweids = 0;
  if(teasession.getParameter("gongzuodanweids")!=null&&teasession.getParameter("gongzuodanweids").length()>0)
  {
    gongzuodanweids = Integer.parseInt(teasession.getParameter("gongzuodanweids"));
  }
  if(gongzuodanweids>0)
  {

  }else
  {
    gongzuodanweids=doobj.getGongzuodanwei();
  }
  String xianshi = teasession.getParameter("xianshi");//no
  boolean f = false;
  Provinces pobj = Provinces.find(sheng);
  Provinces pobj2 = Provinces.find(shi);
  java.util.Enumeration e = Hospital.find(" AND provincial = "+DbAdapter.cite(pobj.getProvincity())+" AND city="+DbAdapter.cite(pobj2.getProvincity())+" ORDER BY honame ASC ");
  out.print("<select name=\"gongzuodanwei\" onchange=f_gongzuodanwei();>");

  out.print("<option value=\"0\">请选择医院</option>");
  while(e.hasMoreElements())
  {
    int hid = ((Integer)e.nextElement()).intValue();
    Hospital hobj = Hospital.find(hid);
    out.print("<option value="+hid);
    if(gongzuodanweids==hid)
    {
      out.print(" selected ");
    }
    out.print(">"+hobj.getHoname());
    out.print("</option>");
    f=true;
  }
  if(f&&"no".equals(xianshi))
  {
    out.print("<option value=-1 style=\"background-color:#FFFFFF; color:red\"><b>如果没有您选择的医院请点击这里</b></option>");
  }
  out.print("</select>");
  return;
}
if("addzip".equals(act))
{
  int gongzuodanwei = Integer.parseInt(teasession.getParameter("gongzuodanwei"));//医院
  if(gongzuodanwei>0)
  {
    gongzuodanwei = Integer.parseInt(teasession.getParameter("gongzuodanwei"));
  }else
  {
    gongzuodanwei  = doobj.getGongzuodanwei();
  }
  Hospital hobj = Hospital.find(gongzuodanwei);

    out.print("/"+hobj.getAddress()+"/"+hobj.getZip()+"/");

  return;
}
if("youxiaozhengjianhao".equals(act))
{
  String zj = teasession.getParameter("zj");
  String community = teasession.getParameter("community");
  if(Doctor.isZJ(community,zj))
  {
    out.print("此医师曾登记，请核实是否需要再登记!");
  }
  return;
}
//管理员账号判断
if("member".equals(act))
{
  String member = teasession.getParameter("member");
  String community =  teasession.getParameter("community");
  if(Doctoradmin.isProfile(community,member))
  {
    out.print("此账户已经存在,请重新选择");
  }
  return;
}
//管理员登陆判断
if("memberlog".equals(act))
{
  String member = teasession.getParameter("member");
  String paw = teasession.getParameter("paw");
  String community = teasession.getParameter("community");
  if(!Profile.isExist(member,paw))
  {
    out.print("用户名或密码有误,请重新填写");
  }else{
    RV rv = new RV(member);
    session.setAttribute("tea.RV", rv);
    Logs.create(community,rv,1,teasession._nNode,request.getRemoteAddr());
  }
  return;
}
if("parlog".equals(act))//医生登陆
{
  String xingming = teasession.getParameter("xingming");
  String zjhm = teasession.getParameter("zjhm");
  String community = teasession.getParameter("community");
  if(!Doctor.isPar(community,xingming,zjhm))
  {
    out.print("姓名或有效证件有误,请重新填写");
  }
  return;
}
//输入医院，就可以再下面显示
if("gongzuodanwei2".equals(act))
{
  String gzdw2 = teasession.getParameter("gzdw2").trim();
  if(gzdw2!=null && gzdw2.length()>0){//如果医院不为空的时候才执行语句
    int sheng = 0;
    if(teasession.getParameter("sheng")!=null && teasession.getParameter("sheng").length()>0)
    {
      sheng = Integer.parseInt(teasession.getParameter("sheng"));
    }
    int shi = 0;
    if(teasession.getParameter("shi")!=null && teasession.getParameter("shi").length()>0)
    {
      shi = Integer.parseInt(teasession.getParameter("shi"));
    }
    Provinces pobj = Provinces.find(sheng);
    Provinces pobj2 = Provinces.find(shi);
    int cuont = Hospital.count(" AND  honame LIKE "+DbAdapter.cite("%"+gzdw2+"%")+" AND provincial ="+DbAdapter.cite(pobj.getProvincity())+" AND city="+DbAdapter.cite(pobj2.getProvincity()));
    if(cuont>0)//如果输入的医院查询有记录才执行
    {
      out.print("<div id=xilidiv>");
      out.print("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"xiaoliajatable\">");
      java.util.Enumeration e = Hospital.find(" AND  honame LIKE "+DbAdapter.cite("%"+gzdw2+"%")+" AND provincial ="+DbAdapter.cite(pobj.getProvincity())+" AND city="+DbAdapter.cite(pobj2.getProvincity()),0,10);
      while(e.hasMoreElements())
      {
        int hid = ((Integer)e.nextElement()).intValue();
        Hospital hobj = Hospital.find(hid);
        out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\" style=\"cursor:pointer\" onclick=f_trdw('"+hobj.getHoname()+"');>");
        out.print("<td>");
        out.print(hobj.getHoname());
        out.print("</td>");
        out.print("</tr>");

      }
      out.print("</table>");
      out.print("</div>");
    }
  }
  return;
}
//医院合并
if("Merge2".equals(act))
{
  int hoid = Integer.parseInt(teasession.getParameter("hoid"));
  int hoid2 = Integer.parseInt(teasession.getParameter("hoid2"));


  Hospital hobj = Hospital.find(hoid);
  Doctor.setGZDW(hoid,hoid2);
  //先删除要合并的医院

  //
  int sheng = Provinces.getProid(" and provincity = "+DbAdapter.cite(hobj.getProvincial())+" and type = 0 ");
  int shi =Provinces.getProid(" and provincity = "+DbAdapter.cite(hobj.getCity())+" and type >0");

  Hospital hobj2 = Hospital.find(hoid2);
  //
  int sheng2 = Provinces.getProid(" and provincity = "+DbAdapter.cite(hobj2.getProvincial())+" and type = 0 ");
  int shi2 =Provinces.getProid(" and provincity = "+DbAdapter.cite(hobj2.getCity())+" and type >0");


  DoctorRanking drobj = DoctorRanking.find(DoctorRanking.isDrid(teasession._strCommunity,hobj.getHoname(),sheng,shi));//要删除医院排名表中的医院
  DoctorRanking drobj2 = DoctorRanking.find(DoctorRanking.isDrid(teasession._strCommunity,hobj2.getHoname(),sheng2,shi2));//要删除医院排名表中的医院


  drobj2.setQuantity(drobj.getMrnumber()+drobj2.getMrnumber(),drobj2.getSheng(), drobj2.getShi(),drobj2.getYyjibie());
  drobj.delete();

  hobj.delete();
  out.print("合并完成");
  return;
}


%>

