

package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.member.Message;
import java.text.*;
import java.math.BigDecimal;
import tea.entity.csvclub.Finance;
import tea.entity.csvclub.Csvjoinoutlay;
import tea.entity.node.Node;
import tea.entity.member.Profile;
import tea.entity.member.ProfileCsv;
import tea.entity.csvclub.Csvpresent;



public class EditLaborage extends TeaServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        tea.ui.TeaSession teasession = null;
        teasession = new tea.ui.TeaSession(request);

        try
        {
            String act = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            String str = null;
            int laborage = 0;
            if(request.getParameter("laborage")!=null && request.getParameter("laborage").length()>0)
                laborage = Integer.parseInt(request.getParameter("laborage"));
          Laborage lobj = Laborage.find(laborage);

           if("EditLaborage".equals(act))
           {
               String Submit1 = request.getParameter("Submit1");
               Date changetime =null;
               if(request.getParameter("changetime")!=null && request.getParameter("changetime").length()>0)
                   changetime = Laborage.sdf.parse(request.getParameter("changetime"));
               String labname = request.getParameter("labname");
               String card = request.getParameter("card");
               int branch = Integer.parseInt(request.getParameter("branch"));
               String bankaccounts = request.getParameter("bankaccounts");
               int role = Integer.parseInt(request.getParameter("role"));
               int bank = Integer.parseInt(request.getParameter("bank"));
               int months = Integer.parseInt(request.getParameter("months"));
               int days = Integer.parseInt(request.getParameter("days"));
               BigDecimal basiclab = new BigDecimal(request.getParameter("basiclab"));
               BigDecimal dropheat = new BigDecimal(0);
               if (request.getParameter("dropheat") != null && request.getParameter("dropheat").length() > 0)
                   dropheat = new BigDecimal(request.getParameter("dropheat"));
               BigDecimal mess = new BigDecimal(0);
               if (request.getParameter("mess") != null && request.getParameter("mess").length() > 0)
                   mess = new BigDecimal(request.getParameter("mess"));
               BigDecimal rests = new BigDecimal(0);
               if (request.getParameter("rests") != null && request.getParameter("rests").length() > 0)
                   rests = new BigDecimal(request.getParameter("rests"));
               BigDecimal shouldlab = new BigDecimal(0);
               if (request.getParameter("shouldlab") != null && request.getParameter("shouldlab").length() > 0)
                   shouldlab = new BigDecimal(request.getParameter("shouldlab"));

               BigDecimal actuary = new BigDecimal(0);
               if (request.getParameter("actuary") != null && request.getParameter("actuary").length() > 0)
                   actuary = new BigDecimal(request.getParameter("actuary"));

               BigDecimal provide = new BigDecimal(0);
               if (request.getParameter("provide") != null && request.getParameter("provide").length() > 0)
                   provide = new BigDecimal(request.getParameter("provide"));

               BigDecimal medical = new BigDecimal(0);
               if (request.getParameter("medical") != null && request.getParameter("medical").length() > 0)
                   medical = new BigDecimal(request.getParameter("medical"));

               BigDecimal idleness = new BigDecimal(0);
               if (request.getParameter("idleness") != null && request.getParameter("idleness").length() > 0)
                   idleness = new BigDecimal(request.getParameter("idleness"));

               BigDecimal accumulation = new BigDecimal(0);
               if (request.getParameter("accumulation") != null && request.getParameter("accumulation").length() > 0)
                   accumulation = new BigDecimal(request.getParameter("accumulation"));

               BigDecimal housingacc = new BigDecimal(0);
               if (request.getParameter("housingacc") != null && request.getParameter("housingacc").length() > 0)
                   housingacc = new BigDecimal(request.getParameter("housingacc"));

               BigDecimal supplyprovidebase = new BigDecimal(0);
               if (request.getParameter("supplyprovidebase") != null && request.getParameter("supplyprovidebase").length() > 0)
                   supplyprovidebase = new BigDecimal(request.getParameter("supplyprovidebase"));
               int service = 0;
               if (request.getParameter("service") != null && request.getParameter("service").length() > 0)
                   service = Integer.parseInt(request.getParameter("service"));

               BigDecimal supplyprovide = new BigDecimal(0);
               if (request.getParameter("supplyprovide") != null && request.getParameter("supplyprovide").length() > 0)
                   supplyprovide = new BigDecimal(request.getParameter("supplyprovide"));

               BigDecimal supplymedical = new BigDecimal(0);
               if (request.getParameter("supplymedical") != null && request.getParameter("supplymedical").length() > 0)
                   supplymedical = new BigDecimal(request.getParameter("supplymedical"));

               BigDecimal agiobase = new BigDecimal(0);
               if (request.getParameter("agiobase") != null && request.getParameter("agiobase").length() > 0)
                   agiobase = new BigDecimal(request.getParameter("agiobase"));

               BigDecimal labor = new BigDecimal(0);
               if (request.getParameter("labor") != null && request.getParameter("labor").length() > 0)
                   labor = new BigDecimal(request.getParameter("labor"));
               float cess = 0;
               if (request.getParameter("cess") != null && request.getParameter("cess").length() > 0)
                   cess = Float.parseFloat(request.getParameter("cess"));

               BigDecimal eraagio = new BigDecimal(0);
               if (request.getParameter("eraagio") != null && request.getParameter("eraagio").length() > 0)
                   eraagio = new BigDecimal(request.getParameter("eraagio"));

               BigDecimal bucklefund = new BigDecimal(0);
               if (request.getParameter("bucklefund") != null && request.getParameter("bucklefund").length() > 0)
                   bucklefund = new BigDecimal(request.getParameter("bucklefund"));

               BigDecimal factlab = new BigDecimal(0);
               if (request.getParameter("factlab") != null && request.getParameter("factlab").length() > 0)
                   factlab = new BigDecimal(request.getParameter("factlab"));
               String content = request.getParameter("content");
               int iftype = 0;
               if (request.getParameter("iftype") != null && request.getParameter("iftype").length() > 0)
                   iftype = Integer.parseInt(request.getParameter("iftype"));
               String cyclostylename = request.getParameter("cyclostylename");

               if ("保存并继续添加".equals(Submit1))
               {
                   nexturl = "/jsp/admin/laborage/EditLaborage.jsp";
               }
               if(laborage>0)
               {
                   lobj.set(changetime,labname,card,branch,role,bank,bankaccounts,months,days,basiclab,dropheat,mess,rests,shouldlab,actuary,provide,medical,idleness,accumulation,housingacc,supplyprovidebase,service,supplyprovide,supplymedical,agiobase,labor,cess,eraagio,bucklefund,factlab,content,iftype,cyclostylename,teasession._rv.toString());
                    str ="员工工资-修改-成功!";
               }else{
                    Laborage.create(changetime,labname,card,branch,role,bank,bankaccounts,months,days,basiclab,dropheat,mess,rests,shouldlab,actuary,provide,medical,idleness,accumulation,housingacc,supplyprovidebase,service,supplyprovide,supplymedical,agiobase,labor,cess,eraagio,bucklefund,factlab,content,iftype,cyclostylename,teasession._rv.toString(),teasession._strCommunity);
                   str ="员工工资-添加-成功!";
                }

           }
           if("delete".equals(act))
           {
               lobj.delete();
               str ="员工工资-删除-成功!";
           }
           if("kind".equals(act))
           {
              //  String sql = request.getParameter("sql");
		String files =request.getParameter("files");
                String lab[] = request.getParameterValues("lab");

                 response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("员工工资表" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();

                try
                {
                    jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                    jxl.write.WritableSheet ws = wwb.createSheet(files, 0);

                    // if ("CsvMember".equals(files))//会员二审的信息
                    // {
                    ws.addCell(new jxl.write.Label(0, 0, "转账日期"));
                    ws.addCell(new jxl.write.Label(1, 0, "姓名"));
                    ws.addCell(new jxl.write.Label(2, 0, "身份证号"));
                    ws.addCell(new jxl.write.Label(3, 0, "部门"));
                    ws.addCell(new jxl.write.Label(4, 0, "人员类型"));
                    ws.addCell(new jxl.write.Label(5, 0, "银行"));
                    ws.addCell(new jxl.write.Label(6, 0, "帐号"));
                    ws.addCell(new jxl.write.Label(7, 0, "出勤月数"));
                    ws.addCell(new jxl.write.Label(8, 0, "出勤天数"));
                    ws.addCell(new jxl.write.Label(9, 0, "基本工资"));
                    ws.addCell(new jxl.write.Label(10, 0, "降暑费"));
                    ws.addCell(new jxl.write.Label(11, 0, "伙食补贴"));
                    ws.addCell(new jxl.write.Label(12, 0, "其他"));
                    ws.addCell(new jxl.write.Label(13, 0, "应发工资"));
                    ws.addCell(new jxl.write.Label(14, 0, "保险基数"));
                    ws.addCell(new jxl.write.Label(15, 0, "基本养老保险"));
                    ws.addCell(new jxl.write.Label(16, 0, "基本医疗保险"));
                    ws.addCell(new jxl.write.Label(17, 0, "失业金"));
                    ws.addCell(new jxl.write.Label(18, 0, "公积金基数"));
                    ws.addCell(new jxl.write.Label(19, 0, "住房公积金"));
                    ws.addCell(new jxl.write.Label(20, 0, "补充养老保险基数"));

                    ws.addCell(new jxl.write.Label(21, 0, "工龄"));
                    ws.addCell(new jxl.write.Label(22, 0, "补充养老保险"));
                    ws.addCell(new jxl.write.Label(23, 0, "补充医疗保险"));
                    ws.addCell(new jxl.write.Label(24, 0, "扣税基数"));
                    ws.addCell(new jxl.write.Label(25, 0, "劳保"));
                    ws.addCell(new jxl.write.Label(26, 0, "税率"));
                    ws.addCell(new jxl.write.Label(27, 0, "代扣税"));
                    ws.addCell(new jxl.write.Label(28, 0, "扣款合计"));
                    ws.addCell(new jxl.write.Label(29, 0, "实发工资"));
                    ws.addCell(new jxl.write.Label(30, 0, "备注"));


                    for (int i = 0; i < lab.length; i++)
                    {
                        //int fiid = ((Integer) fime.nextElement()).intValue();
                       // Finance fiobj = Finance.find(fiid);
                       Laborage obj = Laborage.find(Integer.parseInt(lab[i]));
                       Profile p = Profile.find(obj.getLabname());
                       AdminUnit auobj = AdminUnit.find(obj.getBranch());
                       AdminRole roobj = AdminRole.find(obj.getRole());


                       ws.addCell(new jxl.write.Label(0, i + 1, obj.getChangetimeToString()));
                       ws.addCell(new jxl.write.Label(1, i + 1, p.getLastName(teasession._nLanguage) + p.getFirstName(teasession._nLanguage)));
                       ws.addCell(new jxl.write.Label(2, i + 1, obj.getCard()));
                       ws.addCell(new jxl.write.Label(3, i + 1, auobj.getName()));
                       ws.addCell(new jxl.write.Label(4, i + 1, roobj.getName()));
                       ws.addCell(new jxl.write.Label(5, i + 1, Laborage.BANK_TYPE[obj.getBank()]));
                       ws.addCell(new jxl.write.Label(6, i + 1, obj.getBankaccounts()));
                       ws.addCell(new jxl.write.Label(7, i + 1, String.valueOf(obj.getMonths())));
                       ws.addCell(new jxl.write.Label(8, i + 1, String.valueOf(obj.getDays())));
                       ws.addCell(new jxl.write.Label(9, i + 1, obj.getBasiclab().toString()));
                       ws.addCell(new jxl.write.Label(10, i + 1, obj.getDropheat().toString()));
                       ws.addCell(new jxl.write.Label(11, i + 1, obj.getMess().toString()));
                       ws.addCell(new jxl.write.Label(12, i + 1, obj.getRests().toString()));
                       ws.addCell(new jxl.write.Label(13, i + 1, obj.getShouldlab().toString()));
                       ws.addCell(new jxl.write.Label(14, i + 1, obj.getActuary().toString()));
                       ws.addCell(new jxl.write.Label(15, i + 1, obj.getProvide().toString()));
                       ws.addCell(new jxl.write.Label(16, i + 1, obj.getMedical().toString()));
                       ws.addCell(new jxl.write.Label(17, i + 1, obj.getIdleness().toString()));
                       ws.addCell(new jxl.write.Label(18, i + 1, obj.getAccumulation().toString()));
                       ws.addCell(new jxl.write.Label(19, i + 1, obj.getHousingacc().toString()));
                       ws.addCell(new jxl.write.Label(20, i + 1, obj.getSupplyprovidebase().toString()));

                       ws.addCell(new jxl.write.Label(21, i + 1, String.valueOf(obj.getService())));
                       ws.addCell(new jxl.write.Label(22, i + 1, obj.getSupplyprovide().toString()));
                       ws.addCell(new jxl.write.Label(23, i + 1, obj.getSupplymedical().toString()));
                       ws.addCell(new jxl.write.Label(24, i + 1, obj.getAgiobase().toString()));
                       ws.addCell(new jxl.write.Label(25, i + 1, obj.getLabor().toString()));
                       ws.addCell(new jxl.write.Label(26, i + 1, String.valueOf(obj.getCess())));
                       ws.addCell(new jxl.write.Label(27, i + 1, obj.getEraagio().toString()));
                       ws.addCell(new jxl.write.Label(28, i + 1, obj.getBucklefund().toString()));
                       ws.addCell(new jxl.write.Label(29, i + 1, obj.getFactlab().toString()));
                       ws.addCell(new jxl.write.Label(30, i + 1, obj.getContent()));




                        // i++;
                    }
                    // }
                    wwb.write();
                    wwb.close();
                    os.close();
                } catch (Exception ex)
                {
                        ex.printStackTrace();
                }


           }
           
           java.io.PrintWriter out = response.getWriter();

  		  out.print("<script  language='javascript'>alert('"+str+"');window.location.href='"+nexturl+"';</script> ");
              out.close();
              return;
           
        //   response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode(str,"UTF-8")+"&nexturl="+nexturl);
        //   return;
        }catch (Exception ex)
        {
            ex.printStackTrace();
        }


    }

    //Clean up resources
    public void destroy()
    {
    }
}

