package tea.ui.node;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.entity.site.*;
import jxl.format.*;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.*;
import jxl.write.Number;
import java.sql.SQLException;

public class Exports extends HttpServlet
{
    WritableCellFormat HE,TH,TD,DF;
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        Http h = new Http(request,response);
        String act = h.get("act");
        response.setHeader("Cache-Control","private");
        response.setContentType("application/octet-stream");
        String fname = request.getPathInfo().substring(1);
        response.setHeader("Content-Disposition","attachment");
        OutputStream os = response.getOutputStream();
        try
        {
            if(!"POST".equals(request.getMethod()) || request.getHeader("referer") == null)
                return;
            if(act != null)
            {
                //页眉
                HE = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,20,WritableFont.BOLD));
                HE.setAlignment(Alignment.CENTRE);
                //标题
                TH = new WritableCellFormat();
                TH.setBorder(Border.ALL,BorderLineStyle.THIN);
                TH.setBackground(Colour.LIGHT_TURQUOISE2);
                TH.setAlignment(Alignment.CENTRE);
                TH.setVerticalAlignment(VerticalAlignment.CENTRE);
                TH.setWrap(true);
                //
                TD = new WritableCellFormat();
                TD.setWrap(true);
                //
                DF = new WritableCellFormat(new DateFormat("yyyy-MM-dd HH:mm"));

                WritableWorkbook ww = jxl.Workbook.createWorkbook(os);
				Class.forName("tea.ui.node.Exports").getMethod(act,Class.forName("tea.entity.Http"),Class.forName("jxl.write.WritableWorkbook")).invoke(this,h,ww);
                ww.write();
                ww.close();
            }
        } catch(Throwable ex)
        {
            response.setHeader("Content-Disposition","");
            Throwable ca = ex.getCause();
            if(ca != null)
                ex = ca;
            os.write(("<textarea id='ta'>" + ex.toString() + "</textarea><script>parent.mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>").getBytes("UTF-8"));
            ex.printStackTrace();
        } finally
        {
            os.close();
        }
    }

    //下载统计表
    public void fdown(Http h,WritableWorkbook ww) throws WriteException,SQLException
    {
        WritableSheet ws = ww.createSheet("工作表",0);
        for(int i = 0;i < 10;i++)
        {
            if(i == 1)
                continue;
            ws.setColumnView(i,20);
        }

        int col = 0,row = 0;
        //HE
        ws.setRowView(0,500);
        ws.mergeCells(col,row,9,row);
        ws.addCell(new Label(col,row,Community.find(h.community).getName(h.language) + "——下载统计表",HE));
        row++;
        //TH
        ws.addCell(new Label(col++,row,"文件",TH));
        ws.addCell(new Label(col++,row,"文件大小",TH));
        ws.addCell(new Label(col++,row,"用户名",TH));
        ws.addCell(new Label(col++,row,"E-Mail",TH));
        ws.addCell(new Label(col++,row,"手机号",TH));
        ws.addCell(new Label(col++,row,"电话",TH));
        ws.addCell(new Label(col++,row,"单位",TH));
        ws.addCell(new Label(col++,row,"职务",TH));
        ws.addCell(new Label(col++,row,"IP地址",TH));
        ws.addCell(new Label(col++,row,"时间",TH));
        ws.getSettings().setVerticalFreeze(++row);
        //
        Iterator it = FDown.find(h.key,0,Integer.MAX_VALUE).iterator();
        for(;it.hasNext();row++)
        {
            FDown t = (FDown) it.next();
            Node n = Node.find(t.node);
            Profile m = Profile.find(t.member);
            Files f = Files.find(t.node,h.language);

            col = 0;
            ws.addCell(new Label(col++,row,n.getSubject(h.language)));
            ws.addCell(new Number(col++,row,f.filesize));
            ws.addCell(new Label(col++,row,m.getMember()));
            ws.addCell(new Label(col++,row,m.getEmail()));
            ws.addCell(new Label(col++,row,m.getMobile()));
            ws.addCell(new Label(col++,row,m.getTelephone(h.language)));
            ws.addCell(new Label(col++,row,m.getOrganization(h.language)));
            ws.addCell(new Label(col++,row,m.getJob(h.language)));
            ws.addCell(new Label(col++,row,t.ip));
            ws.addCell(new DateTime(col++,row,t.time,DF));
        }
    }

    //课程——参加人员
    public void courseplan(Http h,WritableWorkbook ww) throws WriteException,SQLException
    {
        WritableSheet ws = ww.createSheet("工作表",0);
        for(int i = 0;i < 15;i++)
        {
            if(i == 5 || i == 10)
                continue;
            ws.setColumnView(i,20);
        }

        int col = 0,row = 0;
        //HE
        ws.setRowView(0,500);
        ws.mergeCells(col,row,14,row);
        ws.addCell(new Label(col,row,Community.find(h.community).getName(h.language) + "——参加人员",HE));
        row++;
        //TH
        ws.addCell(new Label(col++,row,"课程名称",TH));
        ws.addCell(new Label(col++,row,"用户名",TH));
        ws.addCell(new Label(col++,row,"姓名",TH));
        ws.addCell(new Label(col++,row,"单位",TH));
        ws.addCell(new Label(col++,row,"职务",TH));
        ws.addCell(new Label(col++,row,"性别",TH));
        ws.addCell(new Label(col++,row,"手机号",TH));
        ws.addCell(new Label(col++,row,"邮箱",TH));
        ws.addCell(new Label(col++,row,"支付方式",TH));
        ws.addCell(new Label(col++,row,"付款状态",TH));
        ws.addCell(new Label(col++,row,"收费",TH));
        ws.addCell(new Label(col++,row,"收款人",TH));
        ws.addCell(new Label(col++,row,"付款时间",TH));
        ws.addCell(new Label(col++,row,"付款备注",TH));
        ws.addCell(new Label(col++,row,"报名时间",TH));
        ws.getSettings().setVerticalFreeze(++row);
        //
        Iterator it = CoursePlan.find(h.key,0,Integer.MAX_VALUE).iterator();
        for(;it.hasNext();row++)
        {
            CoursePlan t = (CoursePlan) it.next();
            Node n = Node.find(t.node);
            Profile m = Profile.find(t.member);
            col = 0;
            ws.addCell(new Label(col++,row,n.getSubject(h.language)));
            ws.addCell(new Label(col++,row,m.getMember()));
            ws.addCell(new Label(col++,row,m.getName(h.language)));
            ws.addCell(new Label(col++,row,m.getOrganization(h.language)));
            ws.addCell(new Label(col++,row,m.getJob(h.language)));
            ws.addCell(new Label(col++,row,m.isSex() ? "男" : "女"));
            ws.addCell(new Label(col++,row,m.getMobile()));
            ws.addCell(new Label(col++,row,m.getEmail()));
            ws.addCell(new Label(col++,row,CoursePlan.PAYMENT_TYPE[t.payment]));
            ws.addCell(new Label(col++,row,CoursePlan.ISPAY_TYPE[t.ispay]));
            if(t.ispay == 2)
            {
                ws.addCell(new Number(col++,row,t.price));
                ws.addCell(new Label(col++,row,Profile.find(t.paymember).getMember()));
                ws.addCell(new DateTime(col++,row,t.paytime,DF));
                ws.addCell(new Label(col++,row,t.paynote));
            }
            col += 4;
            ws.addCell(new DateTime(col++,row,t.time,DF));
        }
    }


}
