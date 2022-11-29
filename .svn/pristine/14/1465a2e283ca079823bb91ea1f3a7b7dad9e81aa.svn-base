package tea.ui.node.type.people;

import java.awt.image.BufferedImage;
import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.node.*;

import javax.imageio.ImageIO;
import javax.servlet.*;
import javax.servlet.http.*;
import jxl.format.BorderLineStyle;
import jxl.write.WritableWorkbook;
import jxl.write.WritableCellFormat;
import jxl.format.Colour;
import jxl.write.WritableFont;
import jxl.format.Border;
import jxl.format.VerticalAlignment;
import jxl.write.DateFormat;
import jxl.write.WritableSheet;
import jxl.format.Alignment;
import jxl.write.Label;
import tea.entity.site.Community;
import tea.entity.util.ZoomOut;

public class Peoples extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        TeaSession ts = new TeaSession(request);
        if(ts._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + h.node);
            return;
        }
        h.username = ts._rv._strV;
        String act = h.get("act"),nexturl = h.get("nexturl");
        ServletContext application = this.getServletContext();
        if("exp".equals(act))
        {
            response.setHeader("Cache-Control","private");
            response.setHeader("Content-Disposition","attachment; filename=" + "Export.xls");
            try
            {
                WritableCellFormat HE,TH,TD,DF;
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

                WritableWorkbook ww = jxl.Workbook.createWorkbook(response.getOutputStream());
                WritableSheet ws = ww.createSheet("工作表",0);
                //
                for(int i = 0;i < 6;i++)
                {
                    ws.setColumnView(i,20);
                }
                int col = 0,row = 0;
                //HE
                ws.setRowView(0,500);
                ws.mergeCells(col,row,5,row);
                ws.addCell(new Label(col,row,Community.find(h.community).getName(h.language) + "——" + Node.find(h.node).getSubject(h.language),HE));
                row++;
                //TH
                ws.addCell(new Label(col++,row,"姓名",TH));
                ws.addCell(new Label(col++,row,"性别",TH));
                ws.addCell(new Label(col++,row,"单位名称",TH));
                ws.addCell(new Label(col++,row,"职务",TH));
                ws.addCell(new Label(col++,row,"手机",TH));
                ws.addCell(new Label(col++,row,"电话",TH));
                ws.getSettings().setVerticalFreeze(++row);

                Enumeration e = Node.find(h.key,0,Integer.MAX_VALUE);
                while(e.hasMoreElements())
                {
                    int nid = ((Integer) e.nextElement()).intValue();
                    Node n = Node.find(nid);
                    People t = People.find(nid,h.language);

                    col = 0;
                    ws.addCell(new Label(col++,row,n.getSubject(h.language)));
                    ws.addCell(new Label(col++,row,People.SEX_TYPE[t.sex]));
                    ws.addCell(new Label(col++,row,MT.f(t.org)));
                    ws.addCell(new Label(col++,row,MT.f(t.job)));
                    ws.addCell(new Label(col++,row,MT.f(t.mobile)));
                    ws.addCell(new Label(col++,row,MT.f(t.tel)));
                    row++;
                }
                //
                ww.write();
                ww.close();
            } catch(Throwable ex)
            {
                ex.printStackTrace();
            }
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            if("sequence".equals(act))
            {
                int sequence = h.getInt("sequence");
                if(sequence > 0)
                {
                    Node.find(h.getInt("node")).setSequence(sequence);
                } else
                {
                    int pos = h.getInt("pos");
                    String[] nodes = h.get("nodes").split("[|]");
                    for(int i = 1;i < nodes.length;i++)
                    {
                        Node n = Node.find(Integer.parseInt(nodes[i]));
                        n.setSequence(i + pos);
                        TeaServlet.delete(n);
                    }
                    return;
                }
            }
            if(!"POST".equals(request.getMethod()) || request.getHeader("referer") == null)
                act = null;
            out.print("<script>var mt=parent.mt;</script>");
            Node n = Node.find(h.node);
            if("edit".equals(act)) //编辑
            {
                String subject = h.get("subject");
                String keywords = h.get("keywords");
                String content = h.get("content");
                String picture = h.get("picture");
                if(picture != null && h.getBool("tbn"))
                {
                    File f = new File(getServletContext().getRealPath(picture));
                    Img img = new Img(f);
                    img.width = img.height = 300;
                    img.start(f);
                }
                if(h.getBool("srccopy"))
                    content = TeaServlet.copy(h.community,content);
                if(n.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(h.node) + 10;
                    long options = n.getOptions();
                    int options1 = n.getOptions1();
                    Category cat = Category.find(h.node); // 11
                    h.node = Node.create(h.node,sequence,n.getCommunity(),ts._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,h.language,null,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,subject,keywords,"",content,picture,"",0,null,"","","","",null,null);
                    //n = Node.find(h.node);
                    n.finished(h.node);
                } else
                {
                    n.set(h.language,subject,content);
                    if(picture != null || h.getBool("clear"))
                        n.setPicture(picture,h.language);
                }
                People t = People.find(h.node,h.language);
                t.sex = h.getInt("sex");
                t.org = h.get("org");
                t.job = h.get("job");
                t.mobile = h.get("mobile");
                t.tel = h.get("tel");
                t.email = h.get("email");
                t.nationality = h.get("nationality");
                t.birth = h.getDate("birth");
                t.place = h.get("place");
                t.degree = h.get("degree");
                t.school = h.get("school");
                t.set();
                if(nexturl == null)
                    nexturl = "/html/people/" + h.node + "-" + h.language + ".htm";
            } else if("del".equals(act))
            {
                n.delete(h.language);
            }
            TeaServlet.delete(n);
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
