package tea.ui;

import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.site.Watermark;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.regex.Pattern;

public class Attchs extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");

        if("down".equals(act) || "open".equals(act))
        {
            response.setHeader("Cache-Control","private");
            response.setContentType("application/octet-stream");
            OutputStream os = response.getOutputStream();
            try
            {
                String tmp = h.get("attch"),str = MT.dec(tmp);
                Attch a = Attch.find(str.equals(tmp) ? 1 : Integer.parseInt(str));
                //域名
                String sn = request.getServerName();
                int j = sn.lastIndexOf(".",sn.length() - (Pattern.compile("(.com.cn|.net.cn|.org.cn)$").matcher(sn).find() ? 8 : 5));
                if(j != -1)
                    sn = sn.substring(j);
                int port = request.getServerPort();
                if(port != 80)
                    sn += ":" + port;
                //来源
                String ref = request.getHeader("Referer");
                if(sn != null && sn.length() < 8)
                {
                    Filex.logs("Attchs.log","来源：" + ref + " 参数：" + request.getQueryString());
                }
                ref = ref == null ? "NTKO OFFICE CONTROL AGENT".equals(request.getHeader("User-Agent")) ? sn : "" : ref.substring(7,ref.indexOf('/',8));
                if("219.141.230.138".equals(ref) || "123.127.213.10".equals(ref) || "10.1.229.23".equals(ref))
                    ref = sn;
                /*if(a.time == null || !ref.endsWith(sn))
                {
                    response.sendError(404);
                    return;
                }*/
//                if("docx".equals(a.type))
//                    response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
//                else if("xlsx".equals(a.type))
//                    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
//                else if("pptx".equals(a.type))
//                    response.setContentType("application/vnd.openxmlformats-officedocument.presentationml.presentation");
                //不加attachment
                //Win8+IE11: 链接要加target="_blank"，否则后转到about:blank页上
                //打开，会在浏览器中打开Excel
                //没有相关链的程序，和加attachment相同。
                //IE8: 打开此类文件前总是询问
                if("down".equals(act)){ //IE9下,有filename 没attachment，则弹出登陆框
                	if(a.path.indexOf(".pdf")<1)
                		response.setHeader("Content-Disposition","attachment; filename=\"" + new String(a.name.getBytes("GBK"),"ISO-8859-1") + "\"");
                }
                if(a.path != null)
                {
                    Filex.logs("Attchs.log", "hahahha ----："+a.path);
                   /* request.getRequestDispatcher(a.path).forward(request,response); //此处不能转码   2020.03.18安卓系统后缀名为文件名为attch.do*/
                    response.sendRedirect("http://www.brachysolution.com"+a.path);
                } else
                {
                    response.setContentLength((int) a.length);
                    String[] arr = a.content.split("[|]");
                    for(int i = 1;i < arr.length;i++)
                    {
                        a = Attch.find(Integer.parseInt(arr[i]));
                        os.write(Filex.read(Http.REAL_PATH + a.path));
                    }
                }
            } catch(SQLException ex)
            {
                ex.printStackTrace();
            } finally
            {
                os.close();
            }
            return;
        } else if("view".equals(act))
        {

        }

        PrintWriter out = response.getWriter();
        try
        {
            if(act == null)
            {
                act = request.getRequestURI();
                System.out.println("请求：" + request.getServerName() + act);
                if(h.par != null)
                {
                    Iterator it = h.par.keySet().iterator();
                    while(it.hasNext())
                    {
                        String str = (String) it.next();
                        System.out.println(" " + str + "：" + h.get(str));
                    }
                } else
                {
                    Enumeration e = request.getParameterNames();
                    while(e.hasMoreElements())
                    {
                        String name = (String) e.nextElement();
                        System.out.println(" " + name + "：" + request.getParameter(name));
                    }
                }
                //user-agent:netdisk;2.0.0.3;PC;PC-Windows;5.2.3790;uploadplugin
                String info = "";
                if("/rest/2.0/pcs/file".equals(act)) //重试67次
                {
                    //method=upload&app_id=250528&type=tmpfile&dir=%2F/1111/&filename=C0008B9A355B4323BB039F331D19BCB9
                    Attch a = Attch.find(h.getInt("Filedata.attch"));
                    File f1 = new File(Http.REAL_PATH + a.path);
                    a.md5 = Enc.MD5(Filex.read(f1.getPath()));
                    a.length = (int) f1.length();
                    //按内容的MD5存储
                    a.path = "/res/" + a.community + "/cloud/" + a.md5.substring(0,2) + "/" + a.md5;
                    File f2 = new File(Http.REAL_PATH + a.path);
                    if(!f2.exists())
                    {
                        f2.getParentFile().mkdirs();
                        f1.renameTo(f2);
                    }
                    a.set();
                    info = "{'md5':'" + a.md5 + "','request_id':" + a.attch + "}";
                } else if("/api/rapidupload".equals(act)) //250528
                {
                    //slice-md5:2c0407d53b9b97d4e60de03556a442a7
                    //content-length:16878448
                    //content-crc32:4123464015
                    //clienttype:6
                    //content-md5:ddd6164ec524d31dcab3c75c375641da
                    //path:/iwlk//IE8-WindowsServer2003-x86-CHS.exe
                    //version:2.0.0.3
                    //-8:文件名重复
                    // 0:文件已存在 {"errno":0,"info":{"path":"\/1111\/\/4195.2.txt","size":4194305,"ctime":1370413988,"mtime":1370413988,"md5":"f7b39651d1799ea9c7c83d78cac658f1","fs_id":103451847,"isdir":0,"category":4}}
                    info = "{'errno':404,'info':[]}";
                } else if("/api/precreate".equals(act)) //1
                {
                    //clienttype:6
                    //path://ip.cmd
                    //block_list:["6bbe70f90ce9722df1e9906ad68c0a8e"]
                    //version:2.0.0.3
                    //
                    String path = h.get("path");
                    //4194304拆分后的md5
                    String str = h.get("block_list");
                    String[] arr = str.substring(2,str.length() - 2).split("\",\"");
                    long cur = System.currentTimeMillis();
                    StringBuilder sb = new StringBuilder();
                    for(int i = 0;i < arr.length;i++)
                    {
                        if(Attch.find(arr[i]).attch < 1)
                            sb.append(",'" + arr[i] + "'");
                    }
                    System.out.println("时间: " + (System.currentTimeMillis() - cur));
                    info = "{'errno':0,'path':'" + path + "','block_list':[" + sb.substring(sb.length() < 1 ? 0 : 1) + "]}";
                } else if("/api/create".equals(act))
                {
                    //a=commit&norename&clienttype=6&version=2.0.0.3
                    //path=%2F1111%2F%2F1.txt&isdir=0&size=5&block_list=%5B%2207266acfeca8c420779bc14e20fccf7f%22%5D&method=POST
                    Attch a = new Attch(Seq.get());
                    if(h.getBool("isdir"))
                    {
                    } else
                    {
                        String str = h.get("block_list");
                        String[] arr = str.substring(2,str.length() - 2).split("\",\"");

                        StringBuilder sb = new StringBuilder("|");
                        for(int i = 0;i < arr.length;i++)
                        {
                            int attch = Attch.find(arr[i]).attch;
                            if(attch < 1)
                            {
                                info = "{'errno':2,'path':''}"; //返回错误,在8秒内客户端会重试3次
                                System.out.println("输出：" + info);
                                out.print(info.replace('\'','"'));
                                return;
                            }
                            sb.append(attch).append("|");
                        }
                        a.content = sb.toString();
                        a.name = h.get("path");
                        int j = a.name.lastIndexOf('/');
                        a.path3 = a.name.substring(0,j); //MAC地址
                        a.name = a.name.substring(j + 1);
                        a.type = a.name.substring(a.name.lastIndexOf('.') + 1).toLowerCase();
                        a.member = h.member;
                        a.community = h.community;
                        a.length = h.getInt("size");
                        //a.time = new Date();
                        a.set();
                    }
                    info = "{'errno':0,'fs_id':" + a.attch + ",'server_filename':'" + a.name + "','path':'/1111/1.txt','size':" + a.length + ",'ctime':1370364999,'mtime':1370364999,'isdir':0}";
                }
                info = info.replace('\'','"');
                System.out.println("输出：" + info);
                out.print(info);
                return;
            }
            if("fck".equals(act))
            {
                int func = h.getInt("CKEditorFuncNum");
                if(func > 0)
                {
                    out.print("<script>parent.CKEDITOR.tools.callFunction(" + func + ",'" + h.get("upload") + "','');</script>");
                } else
                {
                    String path = h.get("Filedata");
                    if(h.getBool("watermark")) //添加水印
                    {
                        File f = new File(h.REAL_PATH + path);
                        Watermark.mark(h.community,f);
                    }
                    out.print(path);
                }
                return;
            }
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            if("path".equals(act))
            {
                ArrayList al = Attch.find(" AND path3=" + DbAdapter.cite(h.get("path")),0,1);
                if(al.size() > 0)
                {
                    Attch a = (Attch) al.get(0);
                    out.print(a.toString3());
                }
                return;
            }
            if("upload".equals(act))
            {
                Attch a = Attch.find(h.getInt("file.attch"));
                out.print(a);
                return;
            } else if("file".equals(act))
            {
                Attch a = Attch.find(h.getInt("file.attch"));
                out.print(Http.enc(a.toString3()));
                return;
            } else
            {
                Attch t = Attch.find(h.getInt("attchid"));
                if("edit".equals(act))
                {
                    Attch a = Attch.find(h.getInt("file.attch"));
                    t.name = a.name;
                    t.length = a.length;
                    t.type = a.type;
                    //
                    if(!t.path.equals(a.path))
                    {
                        File f = new File(Http.REAL_PATH + t.path);
                        f.delete();
                        if(!new File(Http.REAL_PATH + a.path).renameTo(f))
                        {
                            t.path = a.path;
                        }
                    }
                    t.set();
                    DbAdapter db = new DbAdapter();
                    try
                    {
                        db.executeUpdate(0,"DELETE FROM attch WHERE attch=" + a.attch);
                    } finally
                    {
                        db.close();
                    }
                } else if("del".equals(act))
                {
                    t.delete();
                }
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + Err.get(h,ex) + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
