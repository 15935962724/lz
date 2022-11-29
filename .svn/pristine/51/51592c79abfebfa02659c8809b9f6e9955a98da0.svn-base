package tea.ui.netdisk;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.net.*;
import tea.entity.admin.*;
import tea.ui.*;
import net.mietian.convert.*;
import java.sql.SQLException;
import tea.entity.*;


public class EditMms extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/resource/NetDisk");
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        Http h = new Http(request);

        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + URLEncoder.encode(request.getHeader("referer"),"UTF-8"));
            return;
            
        }

        ServletContext application = getServletContext();
        String url = h.get("url","");

        String prefix = "/res/" + h.community + "/media/";
        String nexturl = h.get("nexturl");
        String act = h.get("act");
        File dir = new File(application.getRealPath(prefix + "/" + url));
        if(!dir.exists())
            dir.mkdirs();

        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        try
        {
            if(h.get("upload") != null)
            {
                String name = h.get("userfileName");
                if(name == null)
                {
                    outText(response,teasession._nLanguage,r.getString(teasession._nLanguage,"InvalidFile"));
                    return;
                }
                byte by[];
                if(name.endsWith(".jsp"))
                {
                    name = name + ".html";
                }
                by = teasession.getBytesParameter("userfile");
                int single = NetDiskSize.getSingleByMember(teasession._strCommunity,teasession._rv._strV);
                if(by.length / 1024 > single)
                {
                    outText(teasession,response,name + "\u4E0A\u4F20\u7684\u6587\u4EF6\u4E0D\u80FD\u5927\u4E8E " + single + "KB");
                    return;
                }
                boolean decompression = h.get("decompression") != null;
                if(decompression)
                {
                    File temp = File.createTempFile("000",".rar");
                    FileOutputStream tempfos = new FileOutputStream(temp);
                    tempfos.write(by);
                    tempfos.close();
                    String str = EditNetDisk.decompression(temp,dir);
                    outText(teasession,response,str);
                    temp.delete();
                    return;
                }
                File file = new File(application.getRealPath(prefix + "/" + url + name));
                if(!file.exists())
                {
                    FileOutputStream os = new FileOutputStream(file);
                    os.write(by);
                    os.close();
                } else
                {
                    outText(teasession,response,r.getString(teasession._nLanguage,"FileExist"));
                    return;
                }
            } else
            if(h.get("newfile") != null)
            {
                File file = new File(application.getRealPath(prefix + "/" + url + h.get("filename")));
                file.createNewFile();
            } else if("mkdir".equals(act)) //创建目录
            {
                String name = h.get("name");
                File file = new File(application.getRealPath(prefix + "/" + url + name));
                out.print("<script>parent.mt.show('目录“" + name + "”创建" + (file.mkdirs() ? "成功" : "失败") + "!',1,'location.reload()');</script>");
            } else if("upload".equals(act)) //上传
            {
                out.print(h.get("Filedata"));
            } else if("progress".equals(act)) //转换flv进度
            {
                String path = h.get("path");
                Video v = (Video) session.getAttribute(path);
                if(v == null)
                    out.print("clearInterval(inter);mt.show('转换成功!',1);mt.ok=function(){location='/jsp/netdisk/EditMms.jsp?community=" + h.community + "&url=" + h.enc(url) + "';}");
                else
                    out.print("progress.style.width='" + v.progress + "%';$('dialog_content').innerHTML='总时间:" + v.getDuration() + " 帧数:" + v.frame + " 大小:" + v.size + "K';");
            } else if("edit".equals(act))
            {
                String path = h.get("path");
                if(h.get("flv") != null)
                {
                    String full = application.getRealPath(path);
                    File avi = new File(full);
                    //FLV命名
                    String n = avi.getName();
                    n = n.substring(0,n.lastIndexOf('.') + 1);
                    File flv = new File(avi.getParentFile(),n + "flv");
                    if(flv.exists())
                        flv = new File(avi.getParentFile(),n + System.currentTimeMillis() + ".flv");
                    //
                    Video v = new Video(full);
                    v.width = h.getInt("w");
                    v.height = h.getInt("h");
                    v.qscale = h.getInt("qscale");
                    session.setAttribute(path,v);
                    boolean rs = v.start(flv.getPath());
                    if(!rs)
                    {
                        System.out.println(v.error);
                        Filex.write("err_flv.txt",v.error + "\t路径：" + full);
                        out.print("<script>parent.clearInterval(parent.inter);parent.mt.show('视频转换失败!');</script>");
                    } else
                        avi.delete();
                    session.removeAttribute(path);
                } else
                {
                    out.print("<script>parent.mt.show('上传成功!',1,'/jsp/netdisk/EditMms.jsp?community=" + h.community + "&url=" + h.enc(url) + "');</script>");
                }
            } else if("delete".equals(act))
            {
                boolean rs = true;
                File file = new File(application.getRealPath(prefix + h.get("file")));
                if(file.isDirectory())
                {
                    EditNetDisk.del(file);
                } else
                {
                    rs = file.delete();
                }
                out.print("<script>parent.mt.show('删除" + (rs ? "成功" : "错误") + "!',1,'location.reload()');</script>");
            } else if("rename".equals(act))
            {
                File file = new File(application.getRealPath(prefix + h.get("file")));
                String name = h.get("name");
                if(name.endsWith(".jsp"))
                {
                    name = name + ".html";
                }
                boolean rs = file.renameTo(new File(file.getParentFile(),name));
                out.print("<script>parent.mt.show('名称修改" + (rs ? "成功" : "错误") + "!',1,'location.reload()');</script>");
            } else if(h.get("conv") != null)
            {
                File file = new File(dir + File.separator + h.get("name"));
                String lc = file.getName().toLowerCase();
                if(file.isDirectory() || !lc.endsWith(".rar") && !lc.endsWith(".zip"))
                {
                    File cfile = new File(file.getAbsolutePath() + ".zip");
                    if(cfile.exists())
                    {
                        cfile = File.createTempFile(file.getName() + "_",".zip",file.getParentFile());
                    }
                    EditNetDisk.compress(file,cfile);
                    String str = cfile.getName() + " \u538B\u7F29\u6210\u529F.";
                    outText(teasession,response,str);
                } else
                {
                    String str = EditNetDisk.decompression(file,file.getParentFile());
                    outText(teasession,response,str);
                }

            }
        } catch(SQLException ex)
        {
            ex.printStackTrace();
			response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
//        if(nexturl == null)
//        {
//            response.sendRedirect("/jsp/netdisk/EditNetDisk.jsp?community=" + teasession._strCommunity + "&Node=" + teasession._nNode + "&url=" + URLEncoder.encode(url,"UTF-8"));
//        } else
//        {
//            response.sendRedirect(nexturl + "&url=" + URLEncoder.encode(url,"UTF-8"));
//        }
    }

}
