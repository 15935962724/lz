package tea.ui.citybcst;

import java.io.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import tea.ui.*;
import java.math.*;
import jxl.write.*;
import tea.entity.citybcst.*;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.resource.*;


public class EditCityBcstExcel extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/resource/Annuity");
    }

    protected void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        String sql = request.getParameter("sql");
        String files = request.getParameter("files");
        String action = request.getParameter("act");
        int count = 0;
        if(teasession.getParameter("count") != null && teasession.getParameter("count").length() > 0)
        {
            count = Integer.parseInt(teasession.getParameter("count"));
        }

        System.out.println("38---------");
        response.setHeader("Content-Disposition","attachment; filename=" + java.net.URLEncoder.encode(files + ".xls","UTF-8"));
        try
        {

            jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
            jxl.write.WritableSheet ws = wwb.createSheet(files,0);
            int pos = 0;
            if(teasession.getParameter("pos") != null && teasession.getParameter("pos").length() > 0)
            {
                pos = Integer.parseInt(teasession.getParameter("pos"));
            }
            int i = 0;

            if("Citybcst".equals(action))
            {
                WritableFont wf = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD,false);
                WritableCellFormat wff = new WritableCellFormat(wf);
                wff.setAlignment(jxl.format.Alignment.CENTRE);

                ws.addCell(new jxl.write.Label(0,0,"姓名",wff));
                ws.addCell(new jxl.write.Label(1,0,"性别",wff));
                ws.addCell(new jxl.write.Label(2,0,"年龄",wff));
				ws.addCell(new jxl.write.Label(3,0,"身份证号",wff));
                ws.addCell(new jxl.write.Label(4,0,"所在城区",wff));
                ws.addCell(new jxl.write.Label(5,0,"所在街道",wff));
                ws.addCell(new jxl.write.Label(6,0,"所在社区",wff));
                ws.addCell(new jxl.write.Label(7,0,"居住地址",wff));
                ws.addCell(new jxl.write.Label(8,0,"联系电话",wff));
				ws.addCell(new jxl.write.Label(9,0,"邮政编码",wff));
                ws.addCell(new jxl.write.Label(10,0,"简介",wff));

                java.util.Enumeration dome = CityBcst.findByCommunity2(sql.toString(),pos,count);
                if(!dome.hasMoreElements())
                {
                } while(dome.hasMoreElements())
                {
                    int cid = Integer.parseInt(String.valueOf(dome.nextElement()));
                    CityBcst cityobj = CityBcst.find(cid);
                    String sex = cityobj.getSex() == 1 ? "女" : "男";
                    Cityname obj1 = Cityname.find(cityobj.getCity());
                    Cityname obj2 = Cityname.find(cityobj.getStreet());
                    Cityname obj3 = Cityname.find(cityobj.getCommunity());

					String citystr1="";
					if(obj1.getCityname()==null && cityobj.getOther()!=null)
					{
						citystr1=cityobj.getOther();
					}
					else
					{
						citystr1=obj1.getCityname();
					}

					String citystr2="";
					if(obj2.getCityname()==null && cityobj.getOther2()!=null)
					{
						citystr2=cityobj.getOther2();
					}
					else
					{
						citystr2=obj2.getCityname();
					}

					String citystr3="";
					if(obj3.getCityname()==null && cityobj.getOther3()!=null)
					{
						citystr3=cityobj.getOther3();
					}
					else
					{
						citystr3=obj3.getCityname();
					}


                    ws.addCell(new jxl.write.Label(0,i + 1,cityobj.getFirstname()));
                    ws.addCell(new jxl.write.Label(1,i + 1,sex));
                    ws.addCell(new jxl.write.Label(2,i + 1,cityobj.getAge()));
                    ws.addCell(new jxl.write.Label(3,i + 1,cityobj.getCard()));
                    ws.addCell(new jxl.write.Label(4,i + 1,citystr1));
                    ws.addCell(new jxl.write.Label(5,i + 1,citystr2));
                    ws.addCell(new jxl.write.Label(6,i + 1,citystr3));
                    ws.addCell(new jxl.write.Label(8,i + 1,cityobj.getAddr()));
                    ws.addCell(new jxl.write.Label(9,i + 1,cityobj.getTelephone()));
					ws.addCell(new jxl.write.Label(10,i + 1,cityobj.getZip()));
					ws.addCell(new jxl.write.Label(11,i + 1,cityobj.getIntro()));
                    i++;
                }
            }
			wwb.write();
			wwb.close();
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }


    }


    public EditCityBcstExcel()
    {
    }
}
