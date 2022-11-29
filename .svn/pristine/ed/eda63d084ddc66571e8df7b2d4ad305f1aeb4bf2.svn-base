package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.ui.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.kids.*;
import jxl.write.*;
import jxl.format.*;

public class Kids extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        Http h = new Http(request);
        String act = h.get("act","");
        if(act.endsWith("exp"))
        {
            OutputStream out = response.getOutputStream();
            response.setContentType("application/octet-stream");
            try
            {
                if("r1exp".equals(act))
                {
                    response.setHeader("Content-Disposition","attachment; filename=" + new String("预约参观.xls".getBytes("GBK"),"ISO-8859-1"));
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(out);
                    WritableSheet ws = wwb.createSheet("工作表",0);
                    ws.setColumnView(0,20);
                    ws.setColumnView(1,20);
                    ws.setColumnView(2,20);
                    ws.setColumnView(3,20);

                    ws.setRowView(0,500);
                    ws.mergeCells(0,0,4,0);
                    WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                    ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language),cf));
                    int j = 0;
                    cf = new WritableCellFormat();
                    cf.setBackground(Colour.GRAY_25);
                    ws.addCell(new Label(j++,1,"姓名",cf));
                    ws.addCell(new Label(j++,1,"电话",cf));
                    ws.addCell(new Label(j++,1,"园所",cf));
                    ws.addCell(new Label(j++,1,"参观时间",cf));
                    ws.addCell(new Label(j++,1,"预约时间",cf));
                    ws.addCell(new Label(j++,1,"预约者IP",cf));
                    Iterator it = KReserve.find(h.key,0,Integer.MAX_VALUE).iterator();
                    for(int i = 2;it.hasNext();i++)
                    {
                        KReserve t = (KReserve) it.next();
                        j = 0;
                        ws.addCell(new Label(j++,i,t.name));
                        ws.addCell(new Label(j++,i,t.tel));
                        ws.addCell(new Label(j++,i,t.course));
                        ws.addCell(new Label(j++,i,MT.f(t.vtime)));
                        ws.addCell(new Label(j++,i,MT.f(t.time,1)));
                        ws.addCell(new Label(j++,i,t.ip));
                    }
                    wwb.write();
                    wwb.close();
                } else if("r2exp".equals(act))
                {
                    response.setHeader("Content-Disposition","attachment; filename=" + new String("试听预约.xls".getBytes("GBK"),"ISO-8859-1"));
                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(out);
                    WritableSheet ws = wwb.createSheet("工作表",0);
                    ws.setColumnView(0,20);
                    ws.setColumnView(1,20);
                    ws.setColumnView(2,20);
                    ws.setColumnView(3,20);

                    ws.setRowView(0,500);
                    ws.mergeCells(0,0,4,0);
                    WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                    ws.addCell(new Label(0,0,Community.find(h.community).getName(h.language),cf));
                    int j = 0;
                    cf = new WritableCellFormat();
                    cf.setBackground(Colour.GRAY_25);
                    ws.addCell(new Label(j++,1,"家长姓名",cf));
                    ws.addCell(new Label(j++,1,"电话",cf));
                    ws.addCell(new Label(j++,1,"邮箱",cf));
                    ws.addCell(new Label(j++,1,"宝宝姓名",cf));
                    ws.addCell(new Label(j++,1,"宝宝年龄",cf));
                    ws.addCell(new Label(j++,1,"住址",cf));
                    ws.addCell(new Label(j++,1,"课程",cf));
                    ws.addCell(new Label(j++,1,"试听时间",cf));
                    ws.addCell(new Label(j++,1,"预约时间",cf));
                    ws.addCell(new Label(j++,1,"预约者IP",cf));
                    Iterator it = KReserve.find(h.key,0,Integer.MAX_VALUE).iterator();
                    for(int i = 2;it.hasNext();i++)
                    {
                        KReserve t = (KReserve) it.next();
                        j = 0;
                        ws.addCell(new Label(j++,i,t.name));
                        ws.addCell(new Label(j++,i,t.tel));
                        ws.addCell(new Label(j++,i,t.email));
                        ws.addCell(new Label(j++,i,t.baby));
                        ws.addCell(new jxl.write.Number(j++,i,t.age));
                        ws.addCell(new Label(j++,i,t.address));
                        ws.addCell(new Label(j++,i,t.course));
                        ws.addCell(new Label(j++,i,MT.f(t.ltime)));
                        ws.addCell(new Label(j++,i,MT.f(t.time,1)));
                        ws.addCell(new Label(j++,i,t.ip));
                    }
                    wwb.write();
                    wwb.close();
                }
            } catch(WriteException ex)
            {
                ex.printStackTrace();
            } catch(SQLException ex)
            {
                ex.printStackTrace();
                response.sendError(500,ex.toString());
            } finally
            {
                out.close();
            }
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            boolean isERR = !"POST".equals(request.getMethod()) || request.getHeader("referer") == null || "application/x-www-form-urlencoded".equals(request.getContentType());
            if("radd".equals(act))
            {
                KReserve t = new KReserve(0);
                t.type = h.getInt("type");
//                if(t.type < 1)
//                    return;
                if(isERR)
                    t.type = 0;
                t.name = h.get("name");
                if(t.name == null || t.name.length() < 1) // == t.name.getBytes("utf-8").length)
                {
                    out.print("<script>parent.mt.show('“姓名”输入的不正确！');</script>");
                    return;
                }
                t.tel = h.get("tel");
                t.email = h.get("email");
                t.baby = h.get("baby");
                t.age = h.getInt("age");
                t.address = h.get("address");
                t.course = h.get("course");
                t.vtime = h.getDate("vtime");
                t.ltime = h.getDate("ltime");
                t.ip = request.getRemoteAddr();
                t.time = new Date();
                t.set();
                out.print("<script>parent.mt.show('预约成功！');parent.mt.clear(parent.document);</script>");
                return;
            }
            if(isERR)
                return;
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if("rdel".equals(act))
            {
                new KReserve(h.getInt("reserve")).delete();
            }
            out.print("<script>parent.mt.show('操作成功！',1,'" + h.get("nexturl","") + "');</script>");
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
