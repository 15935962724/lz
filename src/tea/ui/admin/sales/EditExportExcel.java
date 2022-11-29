package tea.ui.admin.sales;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import tea.ui.*;
import tea.entity.admin.cebbank.*;
import java.math.*;

import jxl.write.*;
import tea.entity.admin.sales.*;
import tea.entity.admin.*;
import tea.entity.member.*;


public class EditExportExcel extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/resource/Annuity");
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // response.setHeader("Expires", "0");
        // response.setHeader("Cache-Control", "no-cache");
        // response.setHeader("Pragma", "no-cache");

        request.setCharacterEncoding("UTF-8");

        TeaSession teasession = new TeaSession(request);

        String sql = request.getParameter("sql");
        String files = request.getParameter("files");

        response.setContentType("application/x-msdownload");
        response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(files + ".xls", "UTF-8"));
        javax.servlet.ServletOutputStream os = response.getOutputStream();
        try
        {
            jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
            jxl.write.WritableSheet ws = wwb.createSheet(files, 0);
            int i = 0;
            if ("tasks".equals(files)) //我的任务
            {
                ws.addCell(new jxl.write.Label(0, 0, "任务主题"));
                ws.addCell(new jxl.write.Label(1, 0, "状态"));
                ws.addCell(new jxl.write.Label(2, 0, "优先级"));
                ws.addCell(new jxl.write.Label(3, 0, "到期日期"));

                java.util.Enumeration tame = Task.findByCommunity(teasession._strCommunity, sql);

                while (tame.hasMoreElements())
                {

                    int taid = ((Integer) tame.nextElement()).intValue();
                    Task taobj = Task.find(taid);
                    ws.addCell(new jxl.write.Label(0, i + 1, taobj.getMotif()));
                    ws.addCell(new jxl.write.Label(1, i + 1, Task.FETTLE[taobj.getFettle()]));
                    ws.addCell(new jxl.write.Label(2, i + 1, Task.PRI[taobj.getPri()]));
                    ws.addCell(new jxl.write.Label(3, i + 1, taobj.getAttime().toString()));
                    i++;
                }
            } else if ("document".equals(files)) //文档管理
            {
                ws.addCell(new jxl.write.Label(0, 0, "名称"));
                ws.addCell(new jxl.write.Label(1, 0, "下载文件名字"));
                ws.addCell(new jxl.write.Label(2, 0, "文件上传时间"));
                ws.addCell(new jxl.write.Label(3, 0, "备注"));
                ws.addCell(new jxl.write.Label(4, 0, "文件类型"));
                java.util.Enumeration dome = Document.findByCommunity(teasession._strCommunity, sql);
                while (dome.hasMoreElements())
                {
                    int doid = ((Integer) dome.nextElement()).intValue();
                    Document doobj = Document.find(doid);
                    ws.addCell(new jxl.write.Label(0, i + 1, doobj.getDocumentname()));
                    ws.addCell(new jxl.write.Label(1, i + 1, doobj.getFileold()));
                    ws.addCell(new jxl.write.Label(2, i + 1, doobj.getTimes().toString()));
                    ws.addCell(new jxl.write.Label(3, i + 1, doobj.getRemark()));
                    ws.addCell(new jxl.write.Label(4, i + 1, doobj.getFileold().substring(doobj.getFileold().lastIndexOf(".") + 1)));
                    i++;
                }
            } else if ("latency".equals(files)) //潜在客户管理
            {
                ws.addCell(new jxl.write.Label(0, 0, "客户名称"));
                ws.addCell(new jxl.write.Label(1, 0, "公司"));
                ws.addCell(new jxl.write.Label(2, 0, "电话"));
                java.util.Enumeration lame = Latency.findByCommunity(teasession._strCommunity, sql);
                while (lame.hasMoreElements())
                {
                    int laid = ((Integer) lame.nextElement()).intValue();
                    Latency laobj = Latency.find(laid);
                    ws.addCell(new jxl.write.Label(0, i + 1, laobj.getFamily() + " " + laobj.getFirsts()));
                    ws.addCell(new jxl.write.Label(1, i + 1, laobj.getCorp()));
                    ws.addCell(new jxl.write.Label(2, i + 1, laobj.getTelephone()));
                    i++;
                }

            } else if ("workation".equals(files))
            {
                ws.addCell(new jxl.write.Label(0, 0, "会员ID"));
                ws.addCell(new jxl.write.Label(1, 0, "姓"));
                ws.addCell(new jxl.write.Label(2, 0, "名"));
                ws.addCell(new jxl.write.Label(3, 0, "性别"));
                ws.addCell(new jxl.write.Label(4, 0, "生日"));
                ws.addCell(new jxl.write.Label(5, 0, "客户"));
                ws.addCell(new jxl.write.Label(6, 0, "工作电话"));
                ws.addCell(new jxl.write.Label(7, 0, "手机"));
                ws.addCell(new jxl.write.Label(8, 0, "E_mail"));

                java.util.Enumeration enumer = Worklinkman.find(teasession._strCommunity, "", 0, 10);
                ///java.util.Enumeration same = SalesLinkman.find(teasession._strCommunity, sql, 0, 20);
                while (enumer.hasMoreElements())
                {
                    String member = ((String) enumer.nextElement());
                    Worklinkman obj = Worklinkman.find(teasession._strCommunity, member);
                     Profile profile=Profile.find(member);

                    ws.addCell(new jxl.write.Label(0, i + 1, obj.getMember()));
                    ws.addCell(new jxl.write.Label(1, i + 1, profile.getLastName(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(2, i + 1, profile.getFirstName(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(3, i + 1, obj.isSex()?"Man":"Woman"));
                    ws.addCell(new jxl.write.Label(4, i + 1, profile.getBirthToString()));
                    ws.addCell(new jxl.write.Label(5, i + 1, Workproject.find(obj.getWorkproject()).getName(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(6, i + 1, obj.getWorktel()));
                    ws.addCell(new jxl.write.Label(7, i + 1, profile.getMobile()));
                    ws.addCell(new jxl.write.Label(8, i + 1, profile.getEmail()));
                    i++;
                }
            } else if ("affiliation".equals(files))
            {
                ws.addCell(new jxl.write.Label(0, 0, "名称"));
                ws.addCell(new jxl.write.Label(1, 0, "客户名称"));
                ws.addCell(new jxl.write.Label(2, 0, "电话"));
                ws.addCell(new jxl.write.Label(3, 0, "E-Mail"));
                ws.addCell(new jxl.write.Label(4, 0, "邮编"));
                ws.addCell(new jxl.write.Label(5, 0, "创建时间"));
                java.util.Enumeration same = SalesLinkman.find(teasession._strCommunity, sql, 0, 20);
                while (same.hasMoreElements())
                {
                    int said = ((Integer) same.nextElement()).intValue();
                    SalesLinkman saobj = SalesLinkman.find(said);
                    int client = saobj.getClient();
                    String kehuname = null;
                    if (client > 0)
                    {
                        kehuname = saobj.isClienttype() ? Workproject.find(client).getName(teasession._nLanguage) : Latency.find(client).getFamily();
                    }
                    ws.addCell(new jxl.write.Label(0, i + 1, saobj.getName(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(1, i + 1, kehuname));
                    ws.addCell(new jxl.write.Label(2, i + 1, saobj.getTel()));
                    ws.addCell(new jxl.write.Label(3, i + 1, saobj.getEmail()));
                    ws.addCell(new jxl.write.Label(4, i + 1, saobj.getPostcode()));
                    ws.addCell(new jxl.write.Label(5, i + 1, saobj.getTime().toString()));
                    i++;

                }
            } else if ("clientserver".equals(files))
            {
                ws.addCell(new jxl.write.Label(0, 0, "名称"));
                ws.addCell(new jxl.write.Label(1, 0, "电话"));
                ws.addCell(new jxl.write.Label(2, 0, "传真"));
                ws.addCell(new jxl.write.Label(3, 0, "E-Mail"));
                ws.addCell(new jxl.write.Label(4, 0, "邮编"));
                ws.addCell(new jxl.write.Label(5, 0, "创建时间"));
                java.util.Enumeration wome = Workproject.find(teasession._strCommunity, sql.toString(), 0, 20);
                while (wome.hasMoreElements())
                {
                    int woid = ((Integer) wome.nextElement()).intValue();
                    Workproject woobj = Workproject.find(woid);
                    ws.addCell(new jxl.write.Label(0, i + 1, woobj.getName(teasession._nLanguage)));
                    ws.addCell(new jxl.write.Label(1, i + 1, woobj.getTel()));
                    ws.addCell(new jxl.write.Label(2, i + 1, woobj.getFax()));
                    ws.addCell(new jxl.write.Label(3, i + 1, woobj.getEmail()));
                    ws.addCell(new jxl.write.Label(4, i + 1, woobj.getPostcode()));
                    ws.addCell(new jxl.write.Label(5, i + 1, woobj.getTime().toString()));
                    i++;
                }

            }//工作日志



            wwb.write();
            wwb.close();

            os.close();
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }


}
