package tea.ui.site;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import tea.entity.site.*;
import tea.ui.*;
import java.io.*;
import jxl.write.*;
import java.util.*;
import tea.entity.*;
import tea.entity.admin.*;
import jxl.Workbook;
import jxl.format.*;
import javax.servlet.*;
import jxl.Sheet;
import tea.db.DbAdapter;

public class EditHelp extends HttpServlet
{

    protected void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String referer = request.getHeader("referer");
        if(referer == null || referer.indexOf(".jsp?") == -1)
        {
            response.sendError(403);
            return;
        }
        Http h = new Http(request,response);
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        ServletContext application = this.getServletContext();
        String act = h.get("act");
        if("exp".equals(act))
        {
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition","attachment; filename=" + new String("系统帮助.xls".getBytes("GBK"),"ISO-8859-1"));
            try
            {
                WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                WritableSheet ws = wwb.createSheet("工作表",0);
                for(int i = 0;i < 4;i++)
                    ws.setColumnView(i,20);
                ws.setRowView(0,500);
                ws.mergeCells(0,0,4,0);
                WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                cf.setAlignment(Alignment.CENTRE);
                ws.addCell(new Label(0,0,Community.find(teasession._strCommunity).getName(teasession._nLanguage) + "——系统帮助",cf));
                int j = 0;
                cf = new WritableCellFormat();
                cf.setBackground(Colour.GRAY_25);
                ws.addCell(new Label(j++,1,"菜单",cf));
                ws.addCell(new Label(j++,1,"主题",cf));
                ws.addCell(new Label(j++,1,"关键词",cf));
                ws.addCell(new Label(j++,1,"内容",cf));
                Enumeration it = Help.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
                for(int i = 2;it.hasMoreElements();i++)
                {
                    int help = ((Integer) it.nextElement()).intValue();
                    Help t = Help.find(help);
                    AdminFunction af = AdminFunction.find(t.id);
                    if(!af.isExists())
                        continue;
                    j = 0;
                    ws.addCell(new Label(j++,i,af.getName(teasession._nLanguage)));
                    ws.addCell(new Label(j++,i,t.getSubject(teasession._nLanguage)));
                    ws.addCell(new Label(j++,i,t.getKeywords(teasession._nLanguage)));
                    ws.addCell(new Label(j++,i,t.getContent(teasession._nLanguage)));
                }
                wwb.write();
                wwb.close();
            } catch(Exception ex)
            {}
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            out.print("<script>var mt=parent.mt;</script>");
            String nexturl = h.get("nexturl");
            if("del".equals(act))
            {
                String tmp = h.get("help");
                String[] arr = "0".equals(tmp) ? h.getValues("helps") : new String[]
                               {tmp};
                for(int i = 0;i < arr.length;i++)
                {
                    Help obj = Help.find(Integer.parseInt(arr[i]));
                    obj.delete();
                }
            } else if("edithelp".equals(act))
            {
                int help = h.getInt("help");
                int type = 0; //Integer.parseInt(h.get("type"));
                int id = h.getInt("menuid");
                String subject = h.get("subject");
                String keywords = h.get("keywords");
                String content = h.get("content");
                if(help < 1)
                {
                    Help.create(teasession._strCommunity,type,id,teasession._nLanguage,subject,keywords,content);
                } else
                {
                    Help obj = Help.find(help);
                    obj.set(type,id,teasession._nLanguage,subject,keywords,content);
                }
            } else if("imp".equals(act))
            {
                Workbook wb;
                try
                {
                    wb = Workbook.getWorkbook(new File(application.getRealPath(h.get("file"))));
                } catch(Exception ex)
                {
                    out.print("<script>mt.show('上传的文件格式不正确！');</script>");
                    return;
                }
                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");
                Sheet s = wb.getSheet(0);
                int sum = s.getRows();
                int add = 0,set = 0,skip = 0;
                for(int i = 2;i < sum;i++)
                {
                    //进度
                    i -= 2;
                    if(i % 100 == 0)
                    {
                        out.print("<script>mt.progress(" + i + "," + (sum - 2) + ");</script>");
                        out.flush();
                    }
                    i += 2;
                    //
                    int j = 0;
                    String menu = s.getCell(j++,i).getContents();
                    Enumeration e = AdminFunction.find(h.community," AND id IN(SELECT adminfunction FROM AdminFunctionLayer WHERE name=" + DbAdapter.cite(menu) + ")",0,1);
                    if(!e.hasMoreElements())
                    {
                        skip++;
                        continue;
                    }
                    int menuid = ((Integer) e.nextElement()).intValue();
                    //
                    String subject = s.getCell(j++,i).getContents();
                    String keywords = s.getCell(j++,i).getContents();
                    String content = s.getCell(j++,i).getContents();
                    e = Help.findByCommunity(h.community," AND id=" + menuid + " AND help IN(SELECT help FROM HelpLayer WHERE subject=" + DbAdapter.cite(subject) + ")",0,1);
                    if(e.hasMoreElements())
                    {
                        int helpid = ((Integer) e.nextElement()).intValue();
                        Help t = Help.find(helpid);
                        t.set(t.getType(),menuid,h.language,subject,keywords,content);
                        set++;
                    } else
                    {
                        Help.create(h.community,0,menuid,h.language,subject,keywords,content);
                        add++;
                    }
                }
                out.print("<script>mt.show('操作执行成功！<br/>　添加：" + add + "条<br/>　修改：" + set + "条<br/>　跳过：" + skip + "条',1,'" + nexturl + "');</script>");
                return;
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Exception ex)
        {
            ex.printStackTrace();
			response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }
}
