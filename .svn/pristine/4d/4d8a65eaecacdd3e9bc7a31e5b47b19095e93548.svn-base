<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="tea.entity.ocean.*"%><%@page import="tea.entity.site.*"%>
<%@page import="jxl.CellType"%>
<%@page import="jxl.Sheet"%>
<%@page import="jxl.Workbook"%>
<%@page import="jxl.write.Label"%>
<%@page import="jxl.write.WritableCellFormat"%>
<%@page import="jxl.write.WritableFont"%>
<%@page import="jxl.format.UnderlineStyle"%>
<%@page import="jxl.format.Colour"%>


<%


request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);

if(request.getParameter("ids")!=null && request.getParameter("ids").length()>0)
{}
else
{
  response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("请选择要导出的数据.", "UTF-8") + "&nexturl=/jsp/ocean/OceanRollList1.jsp");
  return;
}
String files ="护照信息表";
response.setContentType("application/x-msdownload");
response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(files + ".xls", "UTF-8"));
javax.servlet.ServletOutputStream os = response.getOutputStream();


String ids[]=request.getParameterValues("ids");


try{

  jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
  jxl.write.WritableSheet ws = wwb.createSheet(files, 0);



  int i = 0,j=0;


  ws.addCell(new jxl.write.Label(j++,0,"订单号"));
  ws.addCell(new jxl.write.Label(j++,0,"购买类型"));
  ws.addCell(new jxl.write.Label(j++,0,"姓名"));
  ws.addCell(new jxl.write.Label(j++,0,"性别"));
  ws.addCell(new jxl.write.Label(j++,0,"办理情况"));
  ws.addCell(new jxl.write.Label(j++,0,"证件类型"));
  ws.addCell(new jxl.write.Label(j++,0,"证件号码"));
  ws.addCell(new jxl.write.Label(j++,0,"移动电话"));
  ws.addCell(new jxl.write.Label(j++,0,"固定电话"));
  ws.addCell(new jxl.write.Label(j++,0,"通讯地址"));
  ws.addCell(new jxl.write.Label(j++,0,"邮政编码"));
  ws.addCell(new jxl.write.Label(j++,0,"电子邮箱"));
 // ws.addCell(new jxl.write.Label(j++,0,"宝宝的姓名"));
  ws.addCell(new jxl.write.Label(j++,0,"宝宝生日"));
//  ws.addCell(new jxl.write.Label(j++,0,"宝宝的年龄"));
  ws.addCell(new jxl.write.Label(j++,0,"全家月收入"));
  ws.addCell(new jxl.write.Label(j++,0,"感兴趣的海洋馆会员活动"));
  ws.addCell(new jxl.write.Label(j++,0,"其他"));
  ws.addCell(new jxl.write.Label(j++,0,"是否允许代领"));

  ws.addCell(new jxl.write.Label(j++,0,"教育程度"));
  ws.addCell(new jxl.write.Label(j++,0,"您的职业"));
  ws.addCell(new jxl.write.Label(j++,0,"居住城区"));
  ws.addCell(new jxl.write.Label(j++,0,"信息获知途径"));
  ws.addCell(new jxl.write.Label(j++,0,"您和宝宝的兴趣爱好"));

  for(int iiii=0;iiii<ids.length;iiii++)
  {
    Ocean oce = Ocean.find(Integer.parseInt(ids[iiii]));
    String oce_applycard="";
    if(oce.getApplycard()==0)
    {
      oce_applycard="新办卡";
    }else
    {
      oce_applycard="续办卡";
    }


  String coe_interest="";
  for(int i_intecest=0;i_intecest<Ocean.INTEREST.length;i_intecest++)
  {
    oce.getInterest();
    if(oce.getInterest()!=null && oce.getInterest().length()>0)
    {
      String spit[] = oce.getInterest().split(",");
      if(spit.length!=-1)
      {
        for(int j_intecest=0;j_intecest<spit.length;j_intecest++)
        {
          if((spit[j_intecest]).length()>0)
          {
            int aa = Integer.parseInt(spit[j_intecest]);
            if(aa==i_intecest)
            {
              coe_interest=Ocean.INTEREST[i_intecest]+"/";

            }
          }
        }
      }
    }
  }
  String bobo_interest = "";
  for(int i2 = 1;i2<oce.getBobo_interest().split("/").length;i2++)
  {
     bobo_interest = bobo_interest+ Ocean.BOBO_INTEREST[Integer.parseInt(oce.getBobo_interest().split("/")[i2])]+",";
  }
    if(oce.getBobo_interest_qita()!=null && oce.getBobo_interest_qita().length()>0)
    {
      bobo_interest = bobo_interest+oce.getBobo_interest_qita();
    }

  String coe_replacetype ="";
  if(oce.getReplacetype()==0){coe_replacetype="否";}else{coe_replacetype="是";}
    ws.addCell(new jxl.write.Label(0,i + 1,oce.getOceanorder()));
    ws.addCell(new jxl.write.Label(1,i + 1,Ocean.PASSPORT[oce.getPassport()]));
    ws.addCell(new jxl.write.Label(2,i + 1,oce.getName()));
    ws.addCell(new jxl.write.Label(3,i + 1,oce.isSex()?"男":"女"));
    ws.addCell(new jxl.write.Label(4,i + 1,oce_applycard));
    ws.addCell(new jxl.write.Label(5,i + 1,Ocean.CARDTYPE[oce.getCardtype()]));
    ws.addCell(new jxl.write.Label(6,i + 1,oce.getCard()));
    ws.addCell(new jxl.write.Label(7,i + 1,oce.getMobile()));
    ws.addCell(new jxl.write.Label(8,i + 1,oce.getTelephone()));
    ws.addCell(new jxl.write.Label(9,i + 1,oce.getAddress()));
    ws.addCell(new jxl.write.Label(10,i + 1,oce.getZip()));
    ws.addCell(new jxl.write.Label(11,i + 1,oce.getEmail()));
    ws.addCell(new jxl.write.Label(12,i + 1,oce.getBabyname()));
    //ws.addCell(new jxl.write.Label(13,i + 1,oce.getBabybirthtoString()));
    ws.addCell(new jxl.write.Label(13,i + 1,oce.getBabyage()));
   // ws.addCell(new jxl.write.Label(15,i + 1,Ocean.INCOME[oce.getIncome()] ));
    ws.addCell(new jxl.write.Label(14,i + 1,coe_interest));
    ws.addCell(new jxl.write.Label(15,i + 1,oce.getOther()));
    ws.addCell(new jxl.write.Label(16,i + 1,coe_replacetype));

    ws.addCell(new jxl.write.Label(17,i + 1,Ocean.EDUCATION[oce.getEducation()]));
    ws.addCell(new jxl.write.Label(18,i + 1,Ocean.OCCUPA_TION[oce.getOccupation()]));
    ws.addCell(new jxl.write.Label(19,i + 1,Ocean.URBAN_TYPE[oce.getUrban()]));
    ws.addCell(new jxl.write.Label(20,i + 1,Ocean.LEARN_WAY[oce.getLearnway()]));
    ws.addCell(new jxl.write.Label(21,i + 1,bobo_interest));


    i++;
  }


  wwb.write();
  wwb.close();
  os.close();
} catch(Exception ex)
{
  ex.printStackTrace();
}









%>

