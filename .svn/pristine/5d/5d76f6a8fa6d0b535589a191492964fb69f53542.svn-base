package tea.ui.tobacco;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.tobacco.*;
import javax.servlet.*;
import javax.servlet.http.*;
import net.mietian.convert.*;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import tea.entity.member.Profile;

public class Smokes extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        if(act.startsWith("exp"))
        {
            response.setHeader("Cache-Control","private");
            try
            {
                OutputStream os = response.getOutputStream();
                if("exp2".equals(act))
                {
                    response.setHeader("Content-Disposition","attachment; filename=\"" + new String("导出.zip".getBytes("GBK"),"ISO-8859-1") + "\"");
                    Zip z = new Zip(os);
                    System.out.println(h.key);
                    ArrayList al = Smoke.find(h.key,0,Integer.MAX_VALUE);
                    for(int i = 0;i < al.size();i++)
                    {
                        Smoke t = (Smoke) al.get(i);
                        if(t.code == null)
                        {
                            Filex.logs("Smoke_null.txt","id:" + t.smoke);
                        }
                        Attch a = Attch.find(t.attch);
                        File f = new File(application.getRealPath(t.type == 2 ? a.path4 : a.path2));
                        z.rename.put(f,t.code + "." + a.type);
                        al.set(i,f);
                    }
                    File[] fs = new File[al.size()];
                    al.toArray(fs);
                    z.zip(fs);
                } else if("exp".equals(act))
                {
                    response.setHeader("Content-Disposition","attachment; filename=\"" + new String("导出.xlsx".getBytes("GBK"),"ISO-8859-1") + "\"");

                    int type = h.getInt("type");
                    Workbook wb = new SXSSFWorkbook(1000);
                    Sheet ws = wb.createSheet();
                    //格式
                    //ws.setDefaultRowHeight((short) (2 * 256));
                    //ws.setDefaultColumnWidth(4000);
                    if(type == 1)
                        ws.setColumnHidden(2,true);
                    CellStyle cs = wb.createCellStyle();
                    cs.setDataFormat((short) 22);
                    //标题
                    Row wr = ws.createRow(0);
                    String[] th =
                            {"编号","姓名","缩略图","手机号","类型","内容","时间","处理人","处理时间","赞","踩"};
                    for(int j = 0;j < th.length;j++)
                    {
                        Cell wd = wr.createCell(j);
                        wd.setCellValue(th[j]);
                        ws.setColumnWidth(j,4000);
                    }
                    ws.createFreezePane(0,1);
                    ArrayList al = Smoke.find(h.key,0,Integer.MAX_VALUE);
                    for(int i = 0;i < al.size();i++)
                    {
                        Smoke t = (Smoke) al.get(i);
                        wr = ws.createRow(i + 1);
                        int j = 0;
                        wr.createCell(j++).setCellValue(t.code);
                        wr.createCell(j++).setCellValue(t.name);
                        wr.createCell(j++).setCellValue(t.attch < 1 ? null : "http://" + request.getServerName() + Attch.find(t.attch).path4);
                        wr.createCell(j++).setCellValue(t.mobile);
                        wr.createCell(j++).setCellValue(Smoke.MATTER_TYPE[t.type][t.matter]);
                        wr.createCell(j++).setCellValue(t.content);
                        Cell wd = wr.createCell(j++);
                        wd.setCellValue(t.time);
                        wd.setCellStyle(cs);
                        wr.createCell(j++).setCellValue(t.smember < 1 ? null : Profile.find(t.smember).getMember());
                        //
                        wd = wr.createCell(j++);
                        wd.setCellValue(t.stime);
                        wd.setCellStyle(cs);
                        wr.createCell(j++).setCellValue(t.positive);
                        wr.createCell(j++).setCellValue(t.derogatory);
                    }
                    wb.write(os);
                }
                os.close();
            } catch(Throwable ex)
            {
                ex.printStackTrace();
            } finally
            {
            }
            return;
        }
        PrintWriter out = response.getWriter();
        try
        {
            if("positive".equals(act))
            {
                int smoke = h.getInt("smoke");
                Smoke t = Smoke.find(smoke);
                t.positive += h.getInt("value");
                if(t.positive < 0)
                    t.positive = 0;
                t.set("positive",String.valueOf(t.positive));
                out.print(t.positive);
                return;
            } else if("derogatory".equals(act))
            {
                int smoke = h.getInt("smoke");
                Smoke t = Smoke.find(smoke);
                t.derogatory += h.getInt("value");
                if(t.derogatory < 0)
                    t.derogatory = 0;
                t.set("derogatory",String.valueOf(t.derogatory));
                out.print(t.derogatory);
                return;
            } else if("quality".equals(act)) //画质
            {
                String ref = request.getHeader("referer");
                if(ref == null)
                    return;
                Attch a = Attch.find(h.getInt("?a"));
                int len = a.path2.length() - 5;
                StringBuilder sb = new StringBuilder(a.path2);
                out.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                out.print("<ckplayer>");
                sb.setCharAt(len,'2'); //高清
                out.print("<xl_gq><urls>" + sb.toString() + "</urls><seleted>false</seleted><enableds>true</enableds></xl_gq>");
                sb.setCharAt(len,'3'); //标清
                out.print("<xl_bq><urls>" + sb.toString() + "</urls><seleted>true</seleted><enableds>true</enableds></xl_bq>");
                sb.setCharAt(len,'4'); //流畅
                out.print("<xl_qx><urls>" + sb.toString() + "</urls><seleted>false</seleted><enableds>true</enableds></xl_qx>");
                out.print("</ckplayer>");
                return;
            } else if("related".equals(act))
            {
                out.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                out.print("<ckplayer>");
                out.print("<related_setup>120,90,40,#FFFFFF,#FFCC33,0.8,1,精彩视频推荐：,140,100,25,75,15,10</related_setup>");
                out.print("<relatedlist>");
                ArrayList al = Smoke.find(" AND type=3 AND state=2 ORDER BY positive DESC",0,6);
                for(int i = 0;i < al.size();i++)
                {
                    Smoke t = (Smoke) al.get(i);
                    Attch a = Attch.find(t.attch);
                    out.print("<related>");
                    out.print("<img>" + a.path4 + "</img>");
                    out.print("<url>/html/folder/14050066-1.htm?smoke=" + t.smoke + "</url>");
                    out.print("<title>" + MT.f(t.content,20) + "</title>");
                    out.print("</related>");
                }
                out.print("</relatedlist>");
                out.print("</ckplayer>");
                return;
            }
            out.println("<script>var mt=parent.mt,$=parent.$$;</script>");
            if("upload".equals(act))
            {
                Attch at = Attch.find(h.getInt("file.attch"));
                out.print(at);
                return;
            }
            if("add".equals(act))
            {
                Smoke t = new Smoke(0);
                t.name = h.get("name");
                t.idcard = h.get("idcard");
                t.address = h.get("address");
                t.mobile = h.get("mobile");
                t.type = h.getInt("type");
                t.state = 1;
                t.ip = request.getRemoteAddr();
                t.useragent = request.getHeader("user-agent");
                if(t.useragent != null && t.useragent.length() > 800)
                    t.useragent = t.useragent.substring(0,780) + "...";
                t.time = new Date();
                String[] arr = h.getValues("content");
                String[] attch = h.getValues("attch");
                for(int i = 0;i < arr.length;i++)
                {
                    t.content = arr[i];
                    t.matter = h.getInt("matter" + i);
                    if(t.type == 1) //文字
                    {
                        if(t.content.length() < 1)
                            continue;
                        //Filex.logs("Smoke.txt","是否存在: AND type=1 AND content=" + DbAdapter.cite(t.content));
                        if(Smoke.count(" AND type=1 AND content=" + DbAdapter.cite(t.content)) > 0)
                        {
                            out.print("<script>mt.show('尊敬的用户：非常抱歉，已有用户提交相同文字作品，感谢您的参与！',2,'window.mt.close()');$('dl_ok').value='继续上传作品';$('dl_cancel').value='返回首页';mt.cancel=function(){parent.location='/'};</script>");
                            return;
                        }
                    } else //图片、视频
                    {
                        if(attch[i].length() < 1)
                            continue;
                        t.attch = Integer.parseInt(attch[i]);
                        Attch a = Attch.find(t.attch);
                        if(t.type == 2)
                        {
                            Img img = new Img(Http.REAL_PATH + a.path);
                            img.width = 600;
                            int len = a.path.length() - 4;
                            a.path4 = a.path.substring(0,len) + "_3" + a.path.substring(len);
                            img.start(Http.REAL_PATH + a.path4);
                            a.set("path4",a.path4);
                        } else
                            a.set("content",a.path);
                    }
                    //t.code = String.valueOf(Seq.get("smoke." + t.type));
                    t.smoke = 0;
                    t.set();
                }
                out.print("<script>mt.show('尊敬的用户：您已成功提交作品，感谢您的参与！',1,'" + nexturl + "');</script>");
                return;
            }
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            int smoke = h.getInt("smoke");
            if("edit".equals(act)) //编辑
            {
                Smoke t = Smoke.find(smoke);
                t.name = h.get("name");
                t.idcard = h.get("idcard");
                t.address = h.get("address");
                t.mobile = h.get("mobile");
                t.type = h.getInt("type");
                t.content = h.get("content");
                t.matter = h.getInt("matter");
                if(t.type > 1)
                {
                    t.attch = h.getInt("attch");
                    if(t.attch > 0)
                    {
                        Attch a = Attch.find(t.attch);
                        if(a.path4 == null)
                        {
                            if(t.type == 2)
                            {
                                Img img = new Img(Http.REAL_PATH + a.path);
                                img.width = 600;
                                int len = a.path.length() - 4;
                                a.path4 = a.path.substring(0,len) + "_3" + a.path.substring(len);
                                img.start(Http.REAL_PATH + a.path4);
                                a.set("path4",a.path4);
                            } else
                                a.set("content",a.path);
                        }
                    }
                }
                if(t.smoke < 1)
                {
                    //t.code = String.valueOf(Seq.get("smoke." + t.type));
                    t.state = 1;
                    t.ip = request.getRemoteAddr();
                    t.useragent = request.getHeader("user-agent");
                    t.time = new Date();
                }
                t.set();
            } else
            {
                String[] ids = smoke < 1 ? h.getValues("smokes") : new String[]
                               {String.valueOf(smoke)};
                if("del".equals(act)) //删除
                {
                    for(int i = 0;i < ids.length;i++)
                    {
                        Smoke t = Smoke.find(Integer.parseInt(ids[i]));
                        t.delete();
                    }
                } else if("state".equals(act)) //状态
                {
                    int state = h.getInt("state");
                    for(int i = 0;i < ids.length;i++)
                    {
                        Smoke t = Smoke.find(Integer.parseInt(ids[i]));
                        t.state = state;
                        if(t.state == 3)
                        {
                            t.code = null;
                        } else if(t.state == 2 && t.code == null)
                        {
                            //t.code = String.valueOf(Seq.get("smoke." + t.type));
                            int j = 1;
                            while(Smoke.count(" AND state=2 AND type=" + t.type + " AND code=" + j) > 0)
                                j++;
                            t.code = String.valueOf(j);
                        }
                        t.smember = h.member;
                        t.stime = new Date();
                        t.set();
                    }
                }
            }
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
