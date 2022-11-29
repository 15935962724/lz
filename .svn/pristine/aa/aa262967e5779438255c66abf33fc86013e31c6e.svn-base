package tea.ui.member.node;

import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.lang.reflect.Field;
import java.lang.reflect.*;
import tea.ui.TeaServlet;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.weixin.*;
import tea.entity.member.*;
import org.json.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.streaming.*;

public class Nodes extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        response.setHeader("Content-Encoding","nogzip");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            if("month".equals(act))
            {
                Calendar c = Calendar.getInstance();
                c.add(Calendar.DAY_OF_YEAR, -30);
                Date time = c.getTime();
                String[] arr = h.getValues("nodes");
                for(int i = 0;i < arr.length;i++)
                {
                    Node n = Node.find(Integer.parseInt(arr[i]));
                    int j = Node.count(" AND time>" + DbAdapter.cite(time) + " AND path LIKE " + DbAdapter.cite(n.getPath() + "%"));
                    out.print("$$('month_" + n._nNode + "').innerHTML=" + j + ";");
                }
                return;
            } else if("click".equals(act))
            {
                Node n = Node.find(h.node);
                n.click();
                out.print("<script>var t=parent.$$('NodeIDClick');if(t&&t.getAttribute('label')==" + h.node + ")t.innerHTML=" + n.getClick() + ";else parent.cook.set('n" + h.node + "_hits','" + n.getClick() + "')</script>");
                //DecimalFormat df = new DecimalFormat("#,##0");
                //out.print("document.write('" + df.format(n.getClick()) + "');");
                return;
            } else if("stat".equals(act))
            {
                DecimalFormat df = new DecimalFormat("#,##0");
                Date time = new Date();

                Calendar c = Calendar.getInstance();
                c.add(Calendar.DAY_OF_YEAR, -1);
                Date yester = c.getTime();

                c.setTime(time);
                c.set(Calendar.DAY_OF_MONTH,1);
                Date month = c.getTime();

                StringBuilder sb = new StringBuilder();
                DbAdapter db = new DbAdapter(8);
                try
                {
                    //总访问量
                    db.executeQuery("SELECT COUNT(*) FROM NodeAccessLastHistory WHERE node=" + h.node + " AND time>" + DbAdapter.cite(month,true));
                    db.next();
                    sb.append("本月访问量：" + df.format(db.getInt(1)) + "，");

                    db.executeQuery("SELECT COUNT(*) FROM NodeAccessLastHistory WHERE node=" + h.node + " AND time>" + DbAdapter.cite(yester,true) + " AND time<" + DbAdapter.cite(time,true));
                    db.next();
                    sb.append("昨日访问量：" + df.format(db.getInt(1)) + "，");

                    db.executeQuery("SELECT COUNT(*) FROM NodeAccessLastHistory WHERE node=" + h.node + " AND time>" + DbAdapter.cite(time,true));
                    db.next();
                    sb.append("今日访问量：" + df.format(db.getInt(1)) + "");
                } finally
                {
                    db.close();
                }
                out.print("document.write('" + sb.toString() + "');");
                return;
            }
            if("appmsg".equals(act)) //微信消息格式
            {
                String[] ids = h.get("nodes").split("[|]");
                out.print("<table class=appmsg>");
                for(int i = 1;i < ids.length;i++)
                {
                    Node a = Node.find(Integer.parseInt(ids[i]));
                    String pic = MT.f(a.getPicture(h.language),"/tea/image/404.jpg");
                    if(i == 1)
                        out.print("<tr class=first><td colspan=2><img src=" + pic + "><span>" + a.getSubject(h.language) + "</span>");
                    else
                        out.print("<tr><td class=title>" + a.getSubject(h.language) + "<td class=thumb><img src=" + pic + " class1=thumb>");
                    out.print("<a href=### onclick=mt.del(this) id=" + a._nNode + ">删除</a>");
                }
                out.print("</table>");
                return;
            } 
            if(h.member < 1)
            {
                response.sendRedirect("/servlet/StartLogin?community=" + h.community);
                return;
            }
//            response.sendRedirect("/jsp/node/Nodes.jsp?" + request.getQueryString());
            out.println("<script>var mt=parent.mt,$=parent.$;</script>");
            String info = "操作执行成功！";
            if("clone".equals(act))
            {
                int template = h.getInt("template");
                String listing = request.getParameter("listing");
                String section = request.getParameter("section");
                if(template > 0)
                {
                    if(!Node.isExisted(template))
                    {
                        out.print("<script>mt.show('“" + template + "”不存在！');</script>");
                        return;
                    }
                    boolean cs = h.getBool("clonesections");
                    boolean cl = h.getBool("clonelistings");
                    int co = h.getInt("clonesons", -1);
                    Node.clone(template,h.node,cs,cl,co,new RV(Profile.find(h.username).getMember()),out);
                } else if(listing != null && (listing = listing.trim()).length() > 0) // 列举复制
                {
                    int i = Integer.parseInt(listing);
                    Listing obj = Listing.find(i);
                    if(!obj.isExisted())
                    {
                        out.print("<script>mt.show('列举“" + i + "”不存在！');</script>");
                        return;
                    }
                    obj.clone(h.node,h.status);
                } else if(section != null && (section = section.trim()).length() > 0) // 段落复制
                {
                    int i = Integer.parseInt(section);
                    Section obj = Section.find(i);
                    if(obj.time == null)
                    {
                        out.print("<script>mt.show('段落“" + i + "”不存在！');</script>");
                        return;
                    }
                    obj.clone(h.node,h.status);
                } else if(request.getParameter("cssjs") != null) // CssJs复制
                {
                    int i = h.getInt("cssjs");
                    CssJs obj = CssJs.find(i);
                    if(!obj.isExists())
                    {
                        out.print("<script>mt.show('Css/Js“" + i + "”不存在！');</script>");
                        return;
                    }
                    obj.clone(h.node,h.status);
                }
            } else if("hidden".equals(act)) //显示/隐藏
            {
                String[] arr = h.getValues("nodes");
                for(int i = 0;i < arr.length;i++)
                {
                    Node n = Node.find(Integer.parseInt(arr[i]));
                    n.setHidden(h.getBool("hidden"));
                    n.setUpdatetime(new Date());
                    TeaServlet.delete(n);
                }
            } else if("del".equals(act)) //删除
            {
                String[] arr = h.getValues("nodes");
                for(int i = 0;i < arr.length;i++)
                {
                    Node n = Node.find(Integer.parseInt(arr[i]));
                    n.delete(h.language);
                    n = Node.find(n.getFather());
                    n.setUpdatetime(new Date());
                    TeaServlet.delete(n);
                }
            } else if("weixin".equals(act)) //微信群发
            {
/*                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");
                String[] arr = h.getValues("nodes");
                if(arr.length > 8)
                {
                    out.print("<script>mt.show('你最多只可以加入8条图文消息！');</script>");
                    return;
                }
                StringBuilder sb = new StringBuilder();
                WeiXin wx = WeiXin.find(h.community);
                sb.append("AppMsgId=&count=" + arr.length);
                String base = "http://" + request.getServerName() + ":" + request.getServerPort();
                for(int i = 0;i < arr.length;i++)
                {
                    Node n = Node.find(Integer.parseInt(arr[i]));
                    out.print("<script>mt.progress(" + i + "," + arr.length + ",'发布：" + n.getSubject(h.language) + "');</script>");
                    out.flush();
                    boolean show = true;
                    Report r = Report.find(n._nNode);
                    String pic = r.getPicture(h.language);
                    if(pic == null || pic.length() < 1)
                    {
                        pic = n.getPicture(h.language);
                        if(pic == null || pic.length() < 1)
                        {
                            pic = "/tea/image/404.jpg";
                            show = false;
                        } else if(pic.endsWith("#auto"))
                        {
                            pic = pic.substring(0,pic.length() - 5);
                            show = false;
                        }
                    }
                    int picid = wx.filetransfer(0,pic.contains("://") ? pic : application.getRealPath(pic));
                    //
                    sb.append("&title" + i + "=" + Http.enc(n.getSubject(h.language))); //标题
                    String str = n.getText(h.language);
                    str = str.replaceAll("src=\"/","src=\"" + base + "/");
                    sb.append("&content" + i + "=" + Http.enc(str)); //正文
                    sb.append("&digest" + i + "=" + Http.enc(n.getDescription(h.language))); //摘要
                    String author = "";
                    if(n.getType() == 39)
                        author = r.getAuthor(h.language);
                    sb.append("&author" + i + "=" + Http.enc(author)); //作者（选填）
                    sb.append("&fileid" + i + "=" + picid); //封面图片
                    sb.append("&show_cover_pic" + i + "=" + (show ? 1 : 0)); //封面图片显示在正文中
                    sb.append("&sourceurl" + i + "=" + base + "/xhtml/" + h.community + "/node/" + arr[i] + "-" + h.language + ".htm"); //原文链接
                }
                sb.append("&lang=zh_CN&random=" + Math.random() + "&f=json&ajax=1&type=10");
                boolean isPre = h.getBool("type");
                if(isPre) //预览
                {
                    sb.append("&imgcode=&sub=preview&t=ajax-appmsg-preview&preusername=" + h.get("username")); //微信号预览
                } else //保存
                {
                    sb.append("&t=ajax-response&sub=create");
                }
                String htm = (String) wx.open(0,"operate_appmsg",sb.toString());
                System.out.println(htm);
                JSONObject jo = new JSONObject(htm); //{"ret":"0", "msg":"preview send success!", "appMsgId":"200235615", "fakeid":""}
                int err = jo.getInt("ret");
                if(err != 0)
                {
                    HashMap<Integer,String> hm = new HashMap();
                    hm.put(64502,"你输入的微信号不存在，请重新输入！");
                    hm.put(64503,"你输入的微信号不是你的好友！");
                    hm.put(10703,"对方关闭了接收消息！");
                    info = hm.get(err);
                    if(info == null)
                        info = err + "：" + jo.getString("msg");
                    out.print("<script>mt.show('" + info + "');</script>");
                    return;
                }
                //
                if(!isPre)
                {
                    //素材列表
                    htm = (String) wx.open(0,"appmsg?begin=0&count=10&t=media/appmsg_list&type=10&action=list&lang=zh_CN",null);
                    int j = htm.indexOf("wx.cgiData = {") + 13;
                    htm = htm.substring(j,htm.indexOf("};",j) + 1);
                    jo = new JSONObject(htm);
                    jo = jo.getJSONArray("item").getJSONObject(0);
                    //群发消息
                    htm = (String) wx.open(0,"masssend","type=10&appmsgid=" + jo.getInt("app_id") + "&sex=0&groupid=-1&synctxweibo=0&synctxnews=0&country=&province=&city=&imgcode=&lang=zh_CN&random=0.31721752299927175&f=json&ajax=1&t=ajax-response");
                    jo = new JSONObject(htm);
                    err = jo.getInt("ret");
                    if(err != 0)
                    {
                        out.print("<script>mt.show('" + (err == 64004 ? "今天的群发数量已到，无法群发！" : err + "：" + jo.getString("msg")) + "');</script>");
                        return;
                    }
                }*/
            } else if("exp".equals(act))
            {
                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");
                //
                int type = h.getInt("type"),sum = h.getInt("sum");
                Field[] fs = Class.forName("tea.entity.node." + Node.NODE_TYPE[type]).getDeclaredFields();
                long cur = System.currentTimeMillis();
                //标题
                Workbook wb = new SXSSFWorkbook(1000);
                Sheet ws = wb.createSheet();
                Row wr = ws.createRow(0);
                for(int j = 0;j < fs.length;j++)
                {
                    int mod = fs[j].getModifiers();
                    if((mod & Modifier.STATIC) != 0 || (mod & Modifier.PUBLIC) == 0)
                        continue;
                    Cell wd = wr.createCell(j);
                    wd.setCellValue(fs[j].getName());
                }
                ws.createFreezePane(0,1);
                Enumeration e = Node.find(h.key,0,Integer.MAX_VALUE);
                for(int i = 0;e.hasMoreElements();i++)
                {
                    int node = ((Integer) e.nextElement()).intValue();
                    if(i % 200 == 0)
                    {
                        out.print("<script>mt.progress(" + i + "," + sum + ");</script>");
                        out.flush();
                    }
                    wr = ws.createRow(i + 1);

                    Infrared t = Infrared.find(node);
                    for(int j = 0;j < fs.length;j++)
                    {
                        int mod = fs[j].getModifiers();
                        if((mod & Modifier.STATIC) != 0 || (mod & Modifier.PUBLIC) == 0)
                            continue;
                        Object tmp = fs[j].get(t);
                        if(tmp == null)
                            continue;
                        if(tmp instanceof Date)
                            tmp = MT.f((Date) tmp,1);
                        else if(type == 107)
                        {
                            if("picture".equals(fs[j].getName()))
                                tmp = "http://" + request.getServerName() + "/res/attch" + ((String) tmp).replaceFirst("TestData","600");
                        }
                        //
                        Cell wd = wr.createCell(j);
                        wd.setCellValue(tmp.toString());
                    }
                }
                String path = "/res/" + h.community + "/tmp/" + System.currentTimeMillis() + ".xlsx";
                File f = new File(application.getRealPath(path));
                f.getParentFile().mkdirs();
                OutputStream os = new FileOutputStream(f);
                wb.write(os);
                os.close();
                info = "导出完成！<br/>耗时：" + MT.ss((int) (System.currentTimeMillis() - cur) / 1000) + "<br/>大小：" + MT.f(f.length() / 1024F) + "K　<a href=" + path + ">下载</a>";
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
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
