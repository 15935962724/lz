package tea.ui.bpicture;


import java.io.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import tea.ui.*;
import java.math.*;
import jxl.write.*;
import tea.resource.Common;
import tea.entity.member.Profile;
import tea.entity.cio.*;

public class EditBpicExcel  extends TeaServlet
{

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/resource/Annuity");
    }
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        String sql = request.getParameter("sql");
        String files = request.getParameter("files");
        String act = request.getParameter("act");
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
            if("OkCioCompany3".equals(act)) //过生日的会员导出
            {
                WritableFont wf = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD,false);
                WritableCellFormat wff = new WritableCellFormat(wf);
                wff.setAlignment(jxl.format.Alignment.CENTRE);

                ws.addCell(new jxl.write.Label(0,0,"姓名",wff));
                ws.addCell(new jxl.write.Label(1,0,"性别",wff));
                ws.addCell(new jxl.write.Label(2,0,"职务",wff));
                ws.addCell(new jxl.write.Label(3,0,"企业（集团）名称",wff));
                ws.addCell(new jxl.write.Label(4,0,"部门或子企业",wff));
                ws.addCell(new jxl.write.Label(5,0,"是否发言",wff));
                ws.addCell(new jxl.write.Label(6,0,"观光意向",wff)); //
                ws.addCell(new jxl.write.Label(7,0,"是否合住",wff)); //
                ws.addCell(new jxl.write.Label(8,0,"代表号",wff)); //
                ws.addCell(new jxl.write.Label(9,0,"到达航班/车次",wff)); //
                ws.addCell(new jxl.write.Label(10,0,"返回航班/车次",wff)); //
                ws.addCell(new jxl.write.Label(11,0,"接送人姓名",wff)); //
                ws.addCell(new jxl.write.Label(12,0,"酒店名",wff)); //
                ws.addCell(new jxl.write.Label(13,0,"房型",wff)); //
                ws.addCell(new jxl.write.Label(14,0,"入住时间",wff)); //
                i = 0;
                Enumeration e=CioPart.find(sql.toString(),0,Integer.MAX_VALUE);
                while(e.hasMoreElements())
                {
                    CioPart cp = (CioPart) e.nextElement();
                    CioCompany cc2 = CioCompany.find(cp.getCioCompany());
                    int cpid = cp.getCioPart();
                    CioClerk cck=CioClerk.find(cp.getCioClerkid());
                    String sexy = cp.isSex() ? "先生" : "女士";
                    String talks = cp.isTalk() ? "发言" : "不发言";
                    String tourisms = cp.getTourismToHtml();
                    String rooms = cp.isRoom() ? "合住" : "不合住";

                    StringBuilder datestr = new StringBuilder();
                    datestr.append(cp.getRstimeToString());
                    if(cp.getRstimeToString() != null && cp.getRstimeToString().length() > 0)
                    {
                        datestr.append("到");
                    }
                    datestr.append(cp.getRetimeToString());
                    ws.addCell(new jxl.write.Label(0,i + 1,cp.getName()));
                    ws.addCell(new jxl.write.Label(1,i + 1,sexy));
                    ws.addCell(new jxl.write.Label(2,i + 1,cp.getJob()));
                    ws.addCell(new jxl.write.Label(3,i + 1,cc2.getName()));
                    ws.addCell(new jxl.write.Label(4,i + 1,cp.getDept()));
                    ws.addCell(new jxl.write.Label(5,i + 1,talks));
                    ws.addCell(new jxl.write.Label(6,i + 1,tourisms));
                    ws.addCell(new jxl.write.Label(7,i + 1,rooms));
                    ws.addCell(new jxl.write.Label(8,i + 1,cp.getMember()));
                    ws.addCell(new jxl.write.Label(9,i + 1,cp.getComeTrain()));
                    ws.addCell(new jxl.write.Label(10,i + 1,cp.getBackTrain()));
                    ws.addCell(new jxl.write.Label(11,i + 1,cck.getSname()));
                    ws.addCell(new jxl.write.Label(12,i + 1,cp.getRname()));
                    ws.addCell(new jxl.write.Label(13,i + 1,cp.getRchamber()));
                    ws.addCell(new jxl.write.Label(14,i + 1,datestr.toString()));
                    i++;
                }
            }
            System.out.println("ok");
                wwb.write();
                wwb.close();

            } catch (Exception ex)
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
}
