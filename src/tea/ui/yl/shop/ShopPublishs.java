package tea.ui.yl.shop;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.yl.shop.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;
import jxl.write.*;


public class Publishs extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        if ("exp".equals(act))
        {
            try
            {
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment; filename=" + new String("导出.xls".getBytes("GBK"), "ISO-8859-1"));
                WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream());
                int last = 0;
                for (int tab = 0; true; tab++)
                {
                    Iterator it = Coupon.find(" AND coupon>" + last + " ORDER BY coupon", 0, 10000).iterator();
                    if (!it.hasNext())
                        break;
                    WritableSheet ws = wwb.createSheet("工作表-" + last, tab);
                    ws.setColumnView(0, 20);
                    ws.setColumnView(1, 20);
                    ws.setColumnView(2, 20);
                    ws.setColumnView(3, 20);
                    ws.setRowView(0, 500);
                    ws.mergeCells(0, 0, 4, 0);
                    WritableCellFormat cf = new WritableCellFormat(new WritableFont(WritableFont.ARIAL, 20, WritableFont.BOLD));
                    ws.addCell(new Label(0, 0, Site.find(1).name, cf));
                    int j = 0;
                    cf = new WritableCellFormat();
                    cf.setBackground(Colour.GRAY_25);
                    ws.addCell(new Label(j++, 1, "序号", cf));
                    ws.addCell(new Label(j++, 1, "代理商", cf));
                    ws.addCell(new Label(j++, 1, "密码", cf));
                    ws.addCell(new Label(j++, 1, "是否已使", cf));
                    for (int i = 2; it.hasNext(); i++)
                    {
                        Coupon t = (Coupon) it.next();
                        last = t.coupon;
                        j = 0;
                        ws.addCell(new Label(j++, i, Publish.DF8.format(t.coupon)));
                        ws.addCell(new Label(j++, i, t.member));
                        ws.addCell(new Label(j++, i, t.password));
                        ws.addCell(new Label(j++, i, t.trade > 0 ? "是" : "否"));
                    }
                }
                wwb.write();
                wwb.close();
            } catch (Exception ex)
            {
                ex.printStackTrace();
            }
            return ;
        }
        ServletContext application = this.getServletContext();
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,$=parent.$,doc=parent.document;</script>");
            if (h.member < 1)
            {
                out.println("<script>mt.show('您还没有登陆或登陆已超时！请重新登陆',2,'/my/Login.jsp');</script>");
                return;
            }
            int publish = h.getInt("publish");
            if ("edit".equals(act))
            {
                Publish t = Publish.find(publish);
                t.type = h.getInt("type");
                t.member = h.member;
                t.quantity = h.getInt("quantity");
                t.scode = h.getInt("scode");
                t.ecode = h.getInt("ecode");
                t.vtime = h.getDate("vtime");
                t.time = new Date();
                t.set();
                //
                int hits = 0;
                for (int i = 0; i < t.quantity; i++)
                {
                    String tmp;
                    do
                    {
                        hits++;
                        tmp = String.valueOf(Math.random());
                        if (tmp.length() < 14)
                            tmp += "00000000";
                        tmp = tmp.substring(2, 14);
                    } while (Coupon.find(" AND password=" + Database.cite(tmp), 0, 1).size() > 0);
                    Coupon c = new Coupon(0);
                    c.publish = t.publish;
                    c.password = tmp;
                    c.set();
                }
                //
                t.scode = ((Coupon) Coupon.find(" AND publish=" + t.publish + " ORDER BY coupon", 0, 1).get(0)).coupon;
                t.ecode = ((Coupon) Coupon.find(" AND publish=" + t.publish + " ORDER BY coupon DESC", 0, 1).get(0)).coupon;
                t.set();
                System.out.println("发行:" + t.quantity + "\t重复:" + (hits - t.quantity));
            } else if ("member".equals(act))
            {
                int member = h.getInt("member");
                int quantity = h.getInt("quantity");
                if (Member.find(member).time == null)
                {
                    out.print("<script>alter('“" + member + "”不存在！');</script>");
                    return;
                }
                Coupon.setMember(member, quantity);
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch (Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
