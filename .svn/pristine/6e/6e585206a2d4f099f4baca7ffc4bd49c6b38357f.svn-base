package tea.ui.ocean;

import java.io.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import tea.ui.*;
import java.math.*;
import jxl.write.*;
import tea.entity.ocean.*;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.resource.*;


public class EditOceanExcel extends TeaServlet
{


    protected void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        String sql = request.getParameter("sql");
        String files = request.getParameter("files");
        String action = request.getParameter("action");
        int count = 0;
        if(teasession.getParameter("count") != null && teasession.getParameter("count").length() > 0)
        {
            count = Integer.parseInt(teasession.getParameter("count"));
        }

        System.out.println("38---------");
        response.setHeader("Content-Disposition","attachment; filename=" + java.net.URLEncoder.encode(files + ".xls","UTF-8"));
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try
        {

            jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(baos);
            jxl.write.WritableSheet ws = wwb.createSheet(files,0);
            int pos = 0;
            if(teasession.getParameter("pos") != null && teasession.getParameter("pos").length() > 0)
            {
                pos = Integer.parseInt(teasession.getParameter("pos"));
            }
            int i = 0;

            if("EditOceanExcel".equals(action))
            {
                WritableFont wf = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD,false);
                WritableCellFormat wff = new WritableCellFormat(wf);
                wff.setAlignment(jxl.format.Alignment.CENTRE);

                ws.addCell(new jxl.write.Label(0,0,"海洋护照编号",wff));
                ws.addCell(new jxl.write.Label(1,0,"购买类型",wff));
                ws.addCell(new jxl.write.Label(2,0,"姓名",wff));
                ws.addCell(new jxl.write.Label(3,0,"性别",wff));
                ws.addCell(new jxl.write.Label(4,0,"身份证号码",wff));
                ws.addCell(new jxl.write.Label(5,0,"固定电话",wff));
                ws.addCell(new jxl.write.Label(6,0,"移动电话",wff));

	            ws.addCell(new jxl.write.Label(7,0,"教育程度",wff));
				ws.addCell(new jxl.write.Label(8,0,"您的职业",wff));
				ws.addCell(new jxl.write.Label(9,0,"居住城区",wff));



                ws.addCell(new jxl.write.Label(10,0,"通讯地址",wff));
                ws.addCell(new jxl.write.Label(11,0,"邮政编码",wff));
                ws.addCell(new jxl.write.Label(12,0,"电子邮箱",wff));
              //  ws.addCell(new jxl.write.Label(13,0,"宝宝的姓名",wff));
                ws.addCell(new jxl.write.Label(13,0,"宝宝的生日",wff));
               // ws.addCell(new jxl.write.Label(15,0,"宝宝的年龄",wff));
                ws.addCell(new jxl.write.Label(14,0,"全家收入",wff));
                ws.addCell(new jxl.write.Label(15,0,"领卡人",wff));
                ws.addCell(new jxl.write.Label(16,0,"领卡人证件",wff));
                ws.addCell(new jxl.write.Label(17,0,"领卡时间",wff));
                ws.addCell(new jxl.write.Label(18,0,"其他",wff));

                java.util.Enumeration dome = Ocean.findByCommunity(teasession._strCommunity,sql.toString(),pos,count);
                if(!dome.hasMoreElements())
                {

                } while(dome.hasMoreElements())
                {
                    int oid = Integer.parseInt(String.valueOf(dome.nextElement()));
                    Ocean obj = Ocean.find(oid);
                    String sex = obj.isSex() ? "男" : "女";
                    String lingkaren = "";
                    if(obj.getDrawtype() == 0)
                    {
                        lingkaren = "本　人：" + obj.getName();
                    } else
                    {
                        lingkaren = "代领人：" + obj.getDrawnames();
                    }
                    String lingrenzj = "";
                    if(obj.getDrawtype() == 0)
                    {
                        lingrenzj = obj.getCard();
                    } else
                    {
                        lingrenzj = obj.getDrawcards();
                    }
                    obj.getDrawdates();
                    ws.addCell(new jxl.write.Label(0,i + 1,obj.getOceancard(),wff));
                    ws.addCell(new jxl.write.Label(1,i + 1,Ocean.PASSPORT[obj.getPassport()],wff));
                    ws.addCell(new jxl.write.Label(2,i + 1,obj.getName(),wff));
                    ws.addCell(new jxl.write.Label(3,i + 1,sex,wff));
                    ws.addCell(new jxl.write.Label(4,i + 1,obj.getCard(),wff));
                    ws.addCell(new jxl.write.Label(5,i + 1,obj.getTelephone(),wff));
                    ws.addCell(new jxl.write.Label(6,i + 1,obj.getMobile(),wff));

					ws.addCell(new jxl.write.Label(7,i + 1,Ocean.EDUCATION[obj.getEducation()],wff));
					ws.addCell(new jxl.write.Label(8,i + 1,Ocean.OCCUPA_TION[obj.getOccupation()],wff));
					ws.addCell(new jxl.write.Label(9,i + 1,Ocean.URBAN_TYPE[obj.getUrban()],wff));

                    ws.addCell(new jxl.write.Label(10,i + 1,obj.getAddress(),wff));
                    ws.addCell(new jxl.write.Label(11,i + 1,obj.getZip(),wff));
                    ws.addCell(new jxl.write.Label(12,i + 1,obj.getEmail(),wff));
                  //  ws.addCell(new jxl.write.Label(13,i + 1,obj.getBabyname(),wff));
                    ws.addCell(new jxl.write.Label(13,i + 1,obj.getBabybirthtoString(),wff));
                    //ws.addCell(new jxl.write.Label(15,i + 1,obj.getBabyage(),wff));
                    ws.addCell(new jxl.write.Label(14,i + 1,Ocean.INCOME[obj.getIncome()],wff));
                    ws.addCell(new jxl.write.Label(15,i + 1,lingkaren,wff));
                    ws.addCell(new jxl.write.Label(16,i + 1,lingrenzj,wff));
                    ws.addCell(new jxl.write.Label(17,i + 1,obj.getDrawdatestoString(),wff));
                    ws.addCell(new jxl.write.Label(18,i + 1,obj.getOther(),wff));
                    i++;
                }
            } else if(action.equals("EditOceanExcel2"))
            {
                WritableFont wf = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD,false);
                WritableCellFormat wff = new WritableCellFormat(wf);
                wff.setAlignment(jxl.format.Alignment.CENTRE);

                ws.addCell(new jxl.write.Label(0,0,"订单号",wff));
                ws.addCell(new jxl.write.Label(1,0,"海洋护照编号",wff));
                ws.addCell(new jxl.write.Label(2,0,"制卡日期",wff));
                ws.addCell(new jxl.write.Label(3,0,"姓名",wff));
                ws.addCell(new jxl.write.Label(4,0,"购买类型",wff));

                java.util.Enumeration dome = Ocean.findByCommunity(teasession._strCommunity,sql.toString(),pos,count);
                if(!dome.hasMoreElements())
                {

                } while(dome.hasMoreElements())
                {
                    int oid = Integer.parseInt(String.valueOf(dome.nextElement()));
                    Ocean obj = Ocean.find(oid);

                    obj.getDrawdates();
                    ws.addCell(new jxl.write.Label(0,i + 1,obj.getOceanorder(),wff));
                    ws.addCell(new jxl.write.Label(1,i + 1,obj.getOceancard(),wff));
                    ws.addCell(new jxl.write.Label(2,i + 1,obj.getMaketimetoString(),wff));
                    ws.addCell(new jxl.write.Label(3,i + 1,obj.getName(),wff));
                    ws.addCell(new jxl.write.Label(4,i + 1,Ocean.PASSPORT[obj.getPassport()],wff));

                    i++;
                }

            }

            System.out.println("ok");
            wwb.write();
            wwb.close();

        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        byte by[] = baos.toByteArray();
        response.setContentLength(by.length);
        OutputStream os = response.getOutputStream();
        os.write(by);
        os.close();
        System.out.println("ok2:" + by.length);

    }


    public EditOceanExcel()
    {
    }
}
