package tea.ui.women;

import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.util.*;
import java.io.*;
import tea.ui.*;
import tea.db.*;
import java.util.*;
import tea.entity.women.*;
import jxl.*;
import jxl.write.*;
import jxl.format.Colour;
import jxl.format.Alignment;
import jxl.format.*;

public class Donations extends HttpServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);

        String act = h.get("act");
        if(act.startsWith("exp"))
        {
            OutputStream os = response.getOutputStream();
            try
            {
                if("expdon".equals(act))
                {
                    response.setHeader("Content-Disposition","attachment; filename=" + new String("捐赠信息表.xls".getBytes("GBK"),"ISO-8859-1"));
                    //Profile p = Profile.find(member);


                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                    WritableSheet ws = wwb.createSheet("操作人母亲水窖项目办人员",0);
                    for(int i = 0;i < 11;i++)
                        ws.setColumnView(i,12);
                    ws.setColumnView(5,20);

                    int j = 0;
                    WritableCellFormat cf = new WritableCellFormat();
                    cf.setAlignment(Alignment.CENTRE);
                    cf.setBackground(Colour.RED);
                    ws.addCell(new Label(0,j++,"落实省(区)",cf));

                    cf = new WritableCellFormat();
                    cf.setAlignment(Alignment.CENTRE);
                    cf.setBackground(Colour.YELLOW);
                    ws.addCell(new Label(j++,0,"发票编号",cf));
                    ws.addCell(new Label(j++,0,"捐赠时间",cf));
                    ws.addCell(new Label(j++,0,"捐赠者",cf));
                    ws.addCell(new Label(j++,0,"捐赠金额",cf));

                    cf = new WritableCellFormat();
                    cf.setAlignment(Alignment.CENTRE);
                    ws.addCell(new Label(j++,0,"地址",cf));
                    ws.addCell(new Label(j++,0,"邮编",cf));
                    ws.addCell(new Label(j++,0,"电话",cf));
                    ws.addCell(new Label(j++,0,"指定地点",cf));
                    ws.addCell(new Label(j++,0,"指定冠名",cf));
                    ws.addCell(new Label(j++,0,"备注",cf));

                    Iterator it = Donation.find(h.key,0,Integer.MAX_VALUE).iterator();
                    for(int i = 1;it.hasNext();i++)
                    {
                        Donation t = (Donation) it.next();
                        j = 0;
                        ws.addCell(new Label(j++,i,MT.f(t.province)));
                        ws.addCell(new Label(j++,i,MT.f(t.invoice)));
                        ws.addCell(new Label(j++,i,MT.f(t.dtime)));
                        ws.addCell(new Label(j++,i,MT.f(t.donors)));
                        ws.addCell(new jxl.write.Number(j++,i,t.money));
                        ws.addCell(new Label(j++,i,MT.f(t.address)));
                        ws.addCell(new Label(j++,i,MT.f(t.zip)));
                        ws.addCell(new Label(j++,i,MT.f(t.tel)));
                        ws.addCell(new Label(j++,i,MT.f(t.location)));
                        ws.addCell(new Label(j++,i,MT.f(t.named)));
                        ws.addCell(new Label(j++,i,MT.f(t.remark)));
                    }
                    wwb.write();
                    wwb.close();
                } else if("exppra".equals(act))
                {
                    response.setHeader("Content-Disposition","attachment; filename=" + new String("落实信息表.xls".getBytes("GBK"),"ISO-8859-1"));

                    WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                    WritableSheet ws = wwb.createSheet("操作人项目执行方",0);
                    for(int i = 0;i < 7;i++)
                        ws.setColumnView(i,12);
                    ws.setColumnView(7,20);

                    int j = 0;
                    WritableCellFormat cf0 = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,12));
                    cf0.setAlignment(Alignment.CENTRE);
                    cf0.setVerticalAlignment(VerticalAlignment.CENTRE);
                    cf0.setBorder(Border.ALL,BorderLineStyle.THIN);
                    cf0.setBackground(Colour.TURQUOISE);

                    WritableCellFormat cf1 = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,12));
                    cf1.setAlignment(Alignment.CENTRE);
                    cf1.setVerticalAlignment(VerticalAlignment.CENTRE);
                    cf1.setBorder(Border.ALL,BorderLineStyle.THIN);
                    cf1.setBackground(Colour.YELLOW);

                    ws.mergeCells(0,0,0,1);
                    ws.addCell(new Label(0,0,"发票编号",cf0));

                    ws.mergeCells(1,0,1,1);
                    ws.addCell(new Label(1,0,"捐赠时间",cf0));

                    ws.mergeCells(2,0,2,1);
                    ws.addCell(new Label(2,0,"捐赠者",cf0));

                    ws.mergeCells(3,0,6,0);
                    ws.addCell(new Label(3,0,"落实情况",cf1));

                    ws.addCell(new Label(3,1,"省(区)",cf0));
                    ws.addCell(new Label(4,1,"市(县)",cf1));
                    ws.addCell(new Label(5,1,"乡(镇)",cf1));
                    ws.addCell(new Label(6,1,"村",cf1));

                    ws.mergeCells(7,0,7,1);
                    ws.addCell(new Label(7,0,"落实照片编号",cf1));

                    Iterator it = Donation.find(h.key,0,Integer.MAX_VALUE).iterator();
                    for(int i = 2;it.hasNext();i++)
                    {
                        Donation t = (Donation) it.next();
                        j = 0;
                        ws.addCell(new Label(j++,i,MT.f(t.invoice)));
                        ws.addCell(new Label(j++,i,MT.f(t.dtime)));
                        ws.addCell(new Label(j++,i,MT.f(t.donors)));
                        ws.addCell(new Label(j++,i,MT.f(t.province)));
                        ws.addCell(new Label(j++,i,MT.f(t.city)));
                        ws.addCell(new Label(j++,i,MT.f(t.town)));
                        ws.addCell(new Label(j++,i,MT.f(t.village)));
                    }
                    wwb.write();
                    wwb.close();
                }
            } catch(IOException ex)
            {
            } catch(Exception ex)
            {
                ex.printStackTrace();
            }
            os.close();
            return;
        }
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            if("map".equals(act))
            {
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery("SELECT province,COUNT(province) FROM Donation WHERE " + db.length("city") + ">0 GROUP BY province");
                    while(db.next())
                    {
                        String pro = db.getString(1);
                        int sum = db.getInt(2);
                        out.print("var c=$('_C" + pro + "');if(c)c.setAttribute('altx','　地区：" + pro + "<br>　落实：" + sum + "');");
                    }
                } finally
                {
                    db.close();
                }
                out.print("var dm=$('DonationMap').getElementsByTagName('AREA');" +
                          "for(var i=0;i<dm.length;i++)" +
                          "{" +
                          "  dm[i].onmousemove=function(a){mt.tip(a,this.getAttribute('altx')||'暂无');};" +
                          "  dm[i].onmouseout=function(){mt.tip.bg.display='none'};" +
                          "  dm[i].href='###';" +
                          "}");
                return;
            }
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                out.print("<script>top.location='/servlet/StartLogin?node=" + teasession._nNode + "';</script>");
                return;
            }
            h.username = teasession._rv.toString();

            out.print("<script>var mt=parent.mt,$=parent.$,up=parent.up;</script>");
            String nexturl = h.get("nexturl");
            if("impdon".equals(act))
            {
                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");
                Workbook wb;
                try
                {
                    File f = new File(application.getRealPath(h.get("file")));
                    wb = Workbook.getWorkbook(f);
                    System.out.println("捐赠导入：" + f.getPath() + " 用户：" + h.username);
                } catch(Exception ex)
                {
                    out.print("<script>mt.show('上传的文件格式不正确！');</script>");
                    return;
                }
                out.print("<script>$('dialog_header').innerHTML='检测信息数据';</script>");
                ArrayList A1 = new ArrayList();
                Sheet s = wb.getSheet(0);
                int rows = s.getRows();
                for(int i = 1;i < rows;i++)
                {
                    int j = 0;
                    //发票编号
                    String tmp = f(s.getCell(++j,i));
                    if(tmp.length() < 1)
                    {
                        for(int x = 0;x < 11;x++)
                            if(f(s.getCell(x++,i)).length() > 0)
                            {
                                out.print("<script>mt.show('" + l(j,i) + "“发票编号”不能为空！');</script>");
                                return;
                            }
                        continue;
                    }
                    //进度
                    if(i == 1 || i % 100 == 0)
                    {
                        out.print("<script>mt.progress(" + i + "," + rows + ",'总行：" + rows + "　目前：" + i + "　编号：" + tmp + "');</script>");
                        out.flush();
                    }
                    Donation t = Donation.find(tmp);
                    t.invoice = tmp;
                    //落实省(区)
                    j = -1;
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() > 0)
                    {
                        if(tmp.length() < 2)
                        {
                            out.print("<script>mt.show('" + l(j,i) + "“" + tmp + "”不能小于2个字符！');</script>");
                            return;
                        }
                        tmp = tmp.substring(0,(tmp.startsWith("黑龙江") || tmp.startsWith("内蒙古") ? 3 : 2));
                        if(Card.count(" AND card<100 AND address LIKE " + Database.cite(tmp + "%"))<1)
                        {
                            out.print("<script>mt.show('" + l(j,i) + "“" + tmp + "”不存在此省！');</script>");
                            return;
                        }
                        t.province = tmp;
                    }
                    //跳过
                    ++j;

                    //捐赠时间
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() < 1)
                    {
                        out.print("<script>mt.show('" + l(j,i) + "“捐赠时间”不能为空！');</script>");
                        return;
                    }
                    try
                    {
                        t.dtime = Entity.sdf.parse(tmp.replace('.','-'));
                    } catch(Exception ex)
                    {
                        out.print("<script>mt.show('" + l(j,i) + "“捐赠时间”内容或格式不正确！');</script>");
                        return;
                    }

                    //捐赠者
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() < 1)
                    {
                        out.print("<script>mt.show('" + l(j,i) + "“捐赠者”不能为空！');</script>");
                        return;
                    }
                    t.donors = tmp;
                    //捐赠金额
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() < 1)
                    {
                        out.print("<script>mt.show('" + l(j,i) + "“捐赠金额”不能为空！');</script>");
                        return;
                    }
                    try
                    {
                        t.money = Float.parseFloat(tmp.replaceAll(",",""));
                    } catch(Exception ex)
                    {
                        out.print("<script>mt.show('" + l(j,i) + "“捐赠金额”内容不正确！');</script>");
                        return;
                    }
                    //
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() > 0)
                        t.address = tmp;
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() > 0)
                        t.zip = tmp;
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() > 0)
                        t.tel = tmp;
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() > 0)
                        t.location = tmp;
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() > 0)
                        t.named = tmp;
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() > 0)
                        t.remark = tmp;
                    A1.add(t);
                }
                out.print("<script>$('dialog_header').innerHTML='保存信息数据';</script>");
                rows = A1.size();
                int add = 0,set = 0;
                for(int i = 0;i < rows;i++)
                {
                    Donation t = (Donation) A1.get(i);
                    if(i % 100 == 0)
                    {
                        out.print("<script>mt.progress(" + i + "," + rows + ",'总行：" + rows + "　目前：" + i + "　编号：" + t.invoice + "');</script>");
                        out.flush();
                    }
                    t.omember = h.username;
                    t.otime = new Date();
                    if(t.donation < 1)
                    {
                        add++;
                        t.time = t.otime;
                    } else
                        set++;
                    t.set();
                }
                out.print("<script>mt.show('数据导入成功！<br/>新增：" + add + "条　更新：" + set + "条',1,'" + nexturl + "');</script>");
                return;
            } else if("imppar".equals(act))
            {
                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");
                Workbook wb;
                try
                {
                    File f = new File(application.getRealPath(h.get("file")));
                    wb = Workbook.getWorkbook(f);
                    System.out.println("捐赠导入：" + f.getPath() + " 用户：" + h.username);
                } catch(Exception ex)
                {
                    out.print("<script>mt.show('上传的文件格式不正确！');</script>");
                    return;
                }
                String[] names = h.getValues("name");
                out.print("<script>$('dialog_header').innerHTML='检测信息数据';</script>");
                ArrayList A1 = new ArrayList();
                Sheet s = wb.getSheet(0);
                int rows = s.getRows();
                for(int i = 2;i < rows;i++)
                {
                    int j = -1;
                    //发票编号
                    String tmp = f(s.getCell(++j,i));
                    if(tmp.length() < 1)
                    {
                        for(int x = 0;x < 8;x++)
                            if(f(s.getCell(x++,i)).length() > 0)
                            {
                                out.print("<script>mt.show('" + l(j,i) + "“发票编号”不能为空！');</script>");
                                return;
                            }
                        continue;
                    }
                    //进度
                    if(i == 1 || i % 100 == 0)
                    {
                        out.print("<script>mt.progress(" + i + "," + rows + ",'总行：" + rows + "　目前：" + i + "　编号：" + tmp + "');</script>");
                        out.flush();
                    }
                    Donation t = Donation.find(tmp);
                    t.invoice = tmp;
                    j = 3;

                    //市(县)
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() < 1)
                    {
                        out.print("<script>mt.show('" + l(j,i) + "“市(县)”不能为空！');</script>");
                        return;
                    }
                    t.city = tmp;
                    //乡(镇)
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() < 1)
                    {
                        out.print("<script>mt.show('" + l(j,i) + "“乡(镇)”不能为空！');</script>");
                        return;
                    }
                    t.town = tmp;
                    //村
                    tmp = f(s.getCell(++j,i));
                    if(tmp.length() < 1)
                    {
                        out.print("<script>mt.show('" + l(j,i) + "“村”不能为空！');</script>");
                        return;
                    }
                    t.village = tmp;
                    //落实照片编号
                    tmp = f(s.getCell(++j,i)).toLowerCase();
                    if(tmp.length() > 0)
                    {
                        //删除扩展名
                        int l = tmp.length() - 4;
                        if(l > 0 && tmp.charAt(l) == '.')
                            tmp = tmp.substring(0,l);
                        if(names == null || Arrayx.indexOf(names,tmp) == -1)
                        {
                            out.print("<script>mt.show('" + l(j,i) + "您浏览的照片中，缺少“" + tmp + "”文件！');</script>");
                            return;
                        }
                        t.photoid = tmp;
                    }
                    A1.add(t);
                }
                out.print("<script>$('dialog_header').innerHTML='保存信息数据';</script>");
                StringBuilder sb = new StringBuilder("|");
                rows = A1.size();
                for(int i = 0;i < rows;i++)
                {
                    Donation t = (Donation) A1.get(i);
                    if(i % 100 == 0)
                    {
                        out.print("<script>mt.progress(" + i + "," + rows + ",'总行：" + rows + "　目前：" + i + "　编号：" + t.invoice + "');</script>");
                        out.flush();
                    }
                    t.omember = h.username;
                    t.otime = new Date();
                    if(t.donation < 1)
                        t.time = t.otime;
                    t.set();
                    sb.append(t.donation + "|");
                }
                if(names != null)
                {
                    out.print("<script>$('dialog_header').innerHTML='上传落实照片';up.set('postParams',{donation:'" + sb.toString() + "'});up.start();</script>");
                } else
                    out.print("<script>up.complete();</script>");
                return;
            } else if("upload".equals(act)) //和上面，是一个表单
            {
                String donation = h.get("donation");
                String name = h.get("fileName");
                Iterator it = Donation.find(" AND donation IN(" + donation.substring(1,donation.length() - 1).replace('|',',') + ") AND photoid=" + DbAdapter.cite(name.substring(0,name.length() - 4)),0,1).iterator();
                while(it.hasNext())
                {
                    Donation t = (Donation) it.next();
                    t.set("photo",h.get("file"));
                }
            } else
            {
                int donation = h.getInt("donation");
                Donation t = Donation.find(donation);
                if("del".equals(act))
                {
                    t.delete();
                } else if("edit".equals(act))
                {
                    if(h.getBool("invoice"))
                    {
                        t.invoice = h.get("invoice");
                        int j = Donation.find(t.invoice).donation;
                        if(j > 0 && j != donation)
                        {
                            out.print("<script>mt.show('“" + t.invoice + "”已经存在！');</script>");
                            return;
                        }
                        t.dtime = h.getDate("dtime");
                        t.donors = h.get("donors");
                        t.money = h.getFloat("money");
                        t.address = h.get("address");
                        t.zip = h.get("zip");
                        t.tel = h.get("tel");
                        t.location = h.get("location");
                        t.named = h.get("named");
                        t.remark = h.get("remark");
                        t.province = h.get("province");
                    }
                    t.city = h.get("city");
                    t.town = h.get("town");
                    t.village = h.get("village");
                    String tmp = h.get("photo");
                    if(tmp != null)
                    {
                        File f = new File(application.getRealPath(tmp));
                        Img img = new Img(f);
                        img.width = img.height = 800;
                        img.start(f);
                        t.photo = tmp;
                    }
                    t.omember = h.username;
                    t.otime = new Date();
                    if(t.time == null)
                        t.time = t.otime;
                    t.set();
                }
            }
            out.print("<script>mt.show('数据操作成功！',1,'" + nexturl + "');</script>");
        } catch(Exception ex)
        {
            //out.print("<script>mt.show(\"出现未知错误！<textarea cols=29 rows=3>" + ex.toString() + "</textarea>\");</script>");
            ex.printStackTrace();
			response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

    private String f(Cell c)
    {
        return c.getContents().trim();
    }

    private String l(int j,int i)
    {
        return "第" + (j > 25 ? "A" : "") + (char) (j % 26 + 'A') + (i + 1) + "行：";
    }
}
