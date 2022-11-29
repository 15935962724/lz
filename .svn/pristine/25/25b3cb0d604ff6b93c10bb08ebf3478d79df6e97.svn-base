package tea.ui.node.type.resume;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import jxl.write.*;
import tea.entity.node.*;
import tea.entity.member.*;
import java.sql.SQLException;
import tea.htmlx.*;
import tea.resource.*;
import tea.ui.*;

public class ExportResume extends HttpServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    public static String TITLE[][] =
            {
            {"姓名", "性别", "年龄", "国籍", "学历", "毕业学校", "期望工作地区", "工作经验", "现从事职业", "专业", "电子邮箱", "更新日期"},
            {"姓名", "性别", "年龄", "应聘职位", "学历", "毕业学校", "现从事行业", "工作经验", "期望工作职业", "专业", "电子邮箱", "申请日期"}
    };
    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        TeaSession teasession = new TeaSession(request);
        try
        {
            String action = request.getParameter("act");
            WritableWorkbook workbook = null;
            if (action.equals("down")) //下载
            {
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-disposition", "attachment; filename=Resume-" + String.valueOf(System.currentTimeMillis()) + ".xls");
                workbook = jxl.Workbook.createWorkbook(response.getOutputStream());
            } else
            if (action.equals("send")) //发送
            {
//                java.io.File file = new java.io.File(this.getServletContext().getRealPath("/tea/Resume-" + String.valueOf(System.currentTimeMillis()) + ".xls"));
//                for (int index=0;file.exists();index++)
//                {
//                    file = new java.io.File(this.getServletContext().getRealPath("/tea/Resume-" + String.valueOf(System.currentTimeMillis())+"-"+index + ".xls"));
//                }
                java.io.File file = new java.io.File(this.getServletContext().getRealPath("/tea/" + request.getParameter("filename")));
                workbook = jxl.Workbook.createWorkbook(file);
            }
//            response.setContentType("application/octet-stream");
//            response.setHeader("Content-Disposition", "; filename=book.xls");
            WritableSheet sheet = workbook.createSheet("book1", 0);
            int index = 0, applyAmount = 0;
            try
            {
                applyAmount = Integer.parseInt(teasession.getParameter("applyAmount"));
            } catch (NumberFormatException ex1)
            {
            }
            if (applyAmount != 0)
            {
                index = 1;
            }
            for (int len = 0; len < TITLE[index].length; len++)
            {
                Label label = new Label(len, 0, this.TITLE[index][len]);
                sheet.addCell(label);
            }
            String rs[] = request.getParameterValues("resumes");
            for (int len = 1; len <= rs.length; len++)
            {
                int node_id = Integer.parseInt(rs[len - 1]);
                Node node = Node.find(node_id);
                if (node.getCreator() == null)
                {
                    continue;
                }
                Resume summary = Resume.find(node_id, teasession._nLanguage);
                String member = node.getCreator()._strV;

                Profile profile = Profile.find(member);

                sheet.addCell(new Label(0, len, profile.getFirstName(teasession._nLanguage)));

                sheet.addCell(new Label(1, len, profile.isSex() ? "男" : "女"));

                sheet.addCell(new jxl.write.Number(2, len, (profile.getAge())));
                if (index == 0) //简历导出
                {
                    sheet.addCell(new Label(3, len, profile.getState(teasession._nLanguage)));
                } else //应聘导出
                {
                    sheet.addCell(new Label(3, len, tea.entity.node.Node.find(applyAmount).getSubject(1)));
                }
                sheet.addCell(new Label(4, len, DegreeSelection.getDegree(profile.getDegree(teasession._nLanguage))));
                sheet.addCell(new Label(5, len, profile.getSchool(teasession._nLanguage)));
                if (index == 0) //简历导出
                {
                    sheet.addCell(new Label(6, len, summary.getExpectcity().replaceAll("&", ",")));
                } else //应聘导出
                {
                    sheet.addCell(new Label(6, len, summary.getNowmaincareer())); //+ TradeSelection.getTrade(summary.getNowtrade())
                }
                sheet.addCell(new jxl.write.Number(7, len, summary.getExperience()));

                if (index == 0) //简历导出
                {
                    sheet.addCell(new Label(8, len, summary.getNowmaincareer()));
                } else //应聘导出
                {
                    StringTokenizer tokenizer = new StringTokenizer(getNull(summary.getExpectcareer()), "&");
                    StringBuilder sb = new StringBuilder();
                    while (tokenizer.hasMoreTokens())
                    {
                        sb.append(tokenizer.nextToken() + " ");
                    }
                    sheet.addCell(new Label(8, len, summary.getNowmaincareer() + sb.toString()));
                }
                StringBuilder sb = new StringBuilder();
                java.util.Enumeration enumerationEducate = Educate.find(summary.getNode(), teasession._nLanguage);
                while (enumerationEducate.hasMoreElements())
                {
                    Educate educate = Educate.find(((Integer) enumerationEducate.nextElement()).intValue());
                    sb.append(tea.htmlx.MajorSelection.getMajor(educate.getMajorCategory()) + " ");
                }
                sheet.addCell(new Label(9, len, sb.toString()));

                sheet.addCell(new Label(10, len, profile.getEmail()));
                if (index == 0) //简历导出
                {
                    sheet.addCell(new Label(11, len, Node.find(summary.getNode()).getTimeToString()));
                } else //应聘导出
                {
                    sheet.addCell(new Label(11, len, JobApply.find(applyAmount, summary.getNode()).getTimeToString()));
                }
            }
            workbook.write();
            workbook.close();

        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    public String getByte(String values[], int language) throws ServletException, IOException
    {
        String name = "/res/" + System.currentTimeMillis() + Math.random() + ".xls";
        try
        {
//            TeaSession teasession = new TeaSession(request);
//            String action = request.getParameter("act");
            WritableWorkbook workbook = null;
//            if (action.equals("down")) //下载
//            {
//                response.setContentType("application/x-msdownload");
//                response.setHeader("Content-disposition", "attachment; filename=Resume-" + String.valueOf(System.currentTimeMillis()) + ".xls");
//                workbook = jxl.Workbook.createWorkbook(response.getOutputStream());
//            } else
//            if (action.equals("send")) //发送
            File f = new File(Common.REAL_PATH + name);
            workbook = jxl.Workbook.createWorkbook(f);
//            response.setContentType("application/octet-stream");
//            response.setHeader("Content-Disposition", "; filename=book.xls");
            WritableSheet sheet = workbook.createSheet("book1", 0);
            int index = 0, applyAmount = 0;
            try
            {
//                applyAmount = Integer.parseInt(teasession.getParameter("applyAmount"));
            } catch (NumberFormatException ex1)
            {
            }
            if (applyAmount != 0)
            {
                index = 1;
            }
            for (int len = 0; len < TITLE[index].length; len++)
            {
                Label label = new Label(len, 0, this.TITLE[index][len]);
                sheet.addCell(label);
            }
            //          String values[] = request.getParameterValues("Node");
            for (int len = 1; len <= values.length; len++)
            {
                int node_id = Integer.parseInt(values[len - 1]);
                Node node = Node.find(node_id);
                if (node.getCreator() == null)
                {
                    continue;
                }
                Resume summary = Resume.find(node_id, language);
                String member = node.getCreator()._strV;

                Profile profile = Profile.find(member);

                sheet.addCell(new Label(0, len, profile.getFirstName(language)));

                sheet.addCell(new Label(1, len, profile.isSex() ? "男" : "女"));

                sheet.addCell(new jxl.write.Number(2, len, (profile.getAge())));
                if (index == 0) //简历导出
                {
                    sheet.addCell(new Label(3, len, profile.getState(language)));
                } else //应聘导出
                {
                    sheet.addCell(new Label(3, len, tea.entity.node.Node.find(applyAmount).getSubject(language)));
                }
                sheet.addCell(new Label(4, len, DegreeSelection.getDegree(profile.getDegree(language))));
                sheet.addCell(new Label(5, len, profile.getSchool(language)));
                if (index == 0) //简历导出
                {
                    sheet.addCell(new Label(6, len, summary.getExpectcity().replaceAll("&", ",")));
                } else //应聘导出
                {
                    sheet.addCell(new Label(6, len, summary.getNowmaincareer())); //+ TradeSelection.getTrade(summary.getNowtrade())
                }
                sheet.addCell(new jxl.write.Number(7, len, summary.getExperience()));

                if (index == 0) //简历导出
                {
                    sheet.addCell(new Label(8, len, summary.getNowmaincareer()));
                } else //应聘导出
                {
                    StringTokenizer tokenizer = new StringTokenizer(getNull(summary.getExpectcareer()), "&");
                    StringBuilder sb = new StringBuilder();
                    while (tokenizer.hasMoreTokens())
                    {
                        sb.append(tokenizer.nextToken() + " ");
                    }
                    sheet.addCell(new Label(8, len, summary.getNowmaincareer() + sb.toString()));
                }
                StringBuilder sb = new StringBuilder();
                java.util.Enumeration enumerationEducate = Educate.find(summary.getNode(), language);
                while (enumerationEducate.hasMoreElements())
                {
                    Educate educate = Educate.find(((Integer) enumerationEducate.nextElement()).intValue());
                    sb.append(tea.htmlx.MajorSelection.getMajor(educate.getMajorCategory()) + " ");
                }
                sheet.addCell(new Label(9, len, sb.toString()));

                sheet.addCell(new Label(10, len, profile.getEmail()));
                if (index == 0) //简历导出
                {
                    sheet.addCell(new Label(11, len, Node.find(summary.getNode()).getTimeToString()));
                } else //应聘导出
                {
                    sheet.addCell(new Label(11, len, JobApply.find(applyAmount, summary.getNode()).getTimeToString()));
                }
            }
            workbook.write();
            workbook.close();
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
        return name;
    }

    //Clean up resources
    public void destroy()
    {
    }

    public String getNull(String str)
    {
        return str == null ? "" : str;
    }
}
