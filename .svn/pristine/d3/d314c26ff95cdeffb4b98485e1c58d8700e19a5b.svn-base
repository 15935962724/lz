package tea.ui.netdisk;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.admin.*;
import tea.ui.*;
import tea.entity.netdisk.*;
import java.sql.SQLException;
import tea.entity.netdisk.*;

public class EditNetDisk extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("/tea/resource/NetDisk");
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getHeader("referer"), "UTF-8"));
                return;
            }
            ServletContext application = getServletContext();
            String act = teasession.getParameter("act");
            String base = teasession.getParameter("base");
            String path = teasession.getParameter("path");
            String nexturl = teasession.getParameter("nexturl");
            String prefix = teasession.getParameter("prefix");

            if (prefix == null)
            {
                if (nexturl != null && nexturl.indexOf("EditNetDiskMember.jsp") != -1)
                {
                    prefix = "/res/" + teasession._strCommunity + "/netdiskmember/" + teasession._rv._strR;
                } else
                {
                    prefix = "/res/" + teasession._strCommunity + "/netdisk/";
                }
            }


			try
		   {
			   String strpath =application.getRealPath("/res/" + teasession._strCommunity + "/netdisk/");

			   java.io.File myFilePath = new java.io.File(strpath);
			   if(!myFilePath.exists())
			   {
				   myFilePath.mkdir();
				   java.io.File myFilePath2 = new java.io.File(application.getRealPath(prefix));
				   if(!myFilePath2.exists())
				   {
					   myFilePath2.mkdir();
				   }
			   }

		   } catch(Exception e)
		   {

			   //message = "创建目录操作出错";

		   }

            File dir = new File(application.getRealPath(prefix + path));
            if ("upload".equals(act)) //上传
            {
                byte by[] = teasession.getBytesParameter("file");
                if (by == null)
                {
                    outText(response, teasession._nLanguage, r.getString(teasession._nLanguage, "InvalidFile"));
                    return;
                }
                int single = NetDiskSize.getSingleByMember(teasession._strCommunity, teasession._rv._strV);
                if (by.length / 1024 > single)
                {
                    outText(teasession, response, "上传的文件不能大于 " + single + "KB");
                    return;
                }
                String name = teasession.getParameter("fileName").replace('%', '％').replace('"', '“').replace('\'', '`');
                int j = name.lastIndexOf(".");
                name = name.substring(0, j + 1) + name.substring(j + 1).toLowerCase();
                if (name.endsWith(".jsp"))
                {
                    name += ".html";
                }
                String content = teasession.getParameter("content").replace('%', '％').replace('"', '“').replace('\'', '`');
                boolean decompression = teasession.getParameter("decompression") != null;
                if (decompression)
                {
                    File temp = File.createTempFile("000", ".rar");
                    FileOutputStream tempfos = new FileOutputStream(temp);
                    tempfos.write(by);
                    tempfos.close();

                    String str = decompression(temp, dir);
                    outText(teasession, response, str);
                    temp.delete();
                    return;
                } else
                {
                    File f = new File(application.getRealPath(prefix + path + name));
                    if (f.exists())
                    {
                        outText(teasession, response, r.getString(teasession._nLanguage, "FileExist"));
                        return;
                    }
                    FileOutputStream fos = new FileOutputStream(f);
                    fos.write(by);
                    fos.close();
                    NetDisk.create(teasession._strCommunity, path + name, teasession._rv._strV, true, content, (int) f.length());
                }
            } else if ("newfolder".equals(act))
            {
                String name = teasession.getParameter("name").replace('%', '％').replace('"', '“').replace('\'', '`');
                String content = teasession.getParameter("content").replace('%', '％').replace('"', '“').replace('\'', '`');
                path = path + name + "/";
                dir = new File(application.getRealPath(prefix + path));
                dir.mkdirs();
                NetDisk.create(teasession._strCommunity, path, teasession._rv._strV, false, content, 0);
            } else if ("delete".equals(act))
            {
                String ps[] = request.getParameterValues("paths");
                if (ps != null)
                {
                    for (int i = 0; i < ps.length; i++)
                    {
                        String err = checkSafety(teasession._strCommunity, ps[i], teasession._rv._strV, 3);
                        if (err != null)
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("没有删除权限:" + err, "UTF-8"));
                            return;
                        }
                        NetDisk obj = NetDisk.find(teasession._strCommunity, ps[i]);
                        obj.delete();
                        File file = new File(application.getRealPath(prefix + ps[i]));
                        del(file);
                    }
                }
            } else if ("rename".equals(act))
            {
                String name = request.getParameter("name").replace('%', '％').replace('"', '“').replace('\'', '`');
                String content = teasession.getParameter("content").replace('%', '％').replace('"', '“').replace('\'', '`');
                File f = new File(application.getRealPath(prefix + path));
                boolean b = f.renameTo(new File(f.getParent(), name));
                if (b)
                {
                    NetDisk obj = NetDisk.find(teasession._strCommunity, path);
                    obj.set(name, content);
                    path = obj.getParent();
                }
            } else if ("move".equals(act))
            {
                String ps[] = request.getParameterValues("paths");
                if (ps != null)
                {
                    for (int i = 0; i < ps.length; i++)
                    {
                        String err = checkSafety(teasession._strCommunity, ps[i], teasession._rv._strV, 3);
                        if (err != null)
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("没有移动权限:" + err, "UTF-8"));
                            return;
                        }
                        File f = new File(application.getRealPath(prefix + ps[i]));
                        boolean b = f.renameTo(new File(application.getRealPath(prefix + path + f.getName())));
                        System.out.println("移动:" + application.getRealPath(prefix + ps[i]) + "\t" + application.getRealPath(prefix + path + f.getName()) + "\t" + b);
                        if (b)
                        {
                            NetDisk obj = NetDisk.find(teasession._strCommunity, ps[i]);
                            obj.move(path);
                        }
                    }
                }
            } else if ("copy".equals(act))
            {
                String ps[] = request.getParameterValues("paths");
                if (ps != null)
                {
                    for (int i = 0; i < ps.length; i++)
                    {
                        String err = checkSafety(teasession._strCommunity, ps[i], teasession._rv._strV, 1);
                        if (err != null)
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("没有读取权限:" + err, "UTF-8"));
                            return;
                        }
                        NetDisk nd = NetDisk.find(teasession._strCommunity, ps[i]);
                        if (nd.isType())
                        {
                            nd.clone(path + nd.getName());
                        } else
                        {
                            Enumeration e = NetDisk.find(teasession._strCommunity, " AND path LIKE " + DbAdapter.cite(ps[i] + "%"), null, false);
                            while (e.hasMoreElements())
                            {
                                String str = (String) e.nextElement();
                                nd = NetDisk.find(teasession._strCommunity, str);
                                nd.clone(path + str.substring(ps[i].length()));
                            }
                        }
                    }
                }
            } else if ("comp".equals(act)) //压缩
            {
                String ps[] = request.getParameterValues("paths");
                if (ps != null)
                {
                    for (int i = 0; i < ps.length; i++)
                    {
                        File f = new File(application.getRealPath(prefix + ps[i]));
                        File zf = new File(f.getAbsolutePath() + ".zip");
                        if (zf.exists())
                        {
                            zf = File.createTempFile(f.getName() + "_", ".zip", f.getParentFile());
                        }
                        compress(f, zf);
                    }
                }
            } else if ("decomp".equals(act)) //解压
            {
                String ps[] = request.getParameterValues("paths");
                if (ps != null)
                {
                    for (int i = 0; i < ps.length; i++)
                    {
                        File f = new File(application.getRealPath(prefix + ps[i]));
                        String lc = f.getName();
                        if (f.isFile() && (lc.endsWith(".rar") || lc.endsWith(".zip")))
                        {
                            decompression(f, f.getParentFile());
                        }
                    }
                }
            } else if ("download".equals(act))
            {
                String err = checkSafety(teasession._strCommunity, path, teasession._rv._strV, 1);
                if (err != null)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("没有读取权限:" + err, "UTF-8"));
                    return;
                }
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(dir.getName(), "UTF-8"));
                byte by[] = new byte[(int) dir.length()];
                FileInputStream fis = new FileInputStream(dir);
                fis.read(by);
                fis.close();

                OutputStream os = response.getOutputStream();
                os.write(by);
                os.close();
                return;
            }
            if (nexturl == null)
            {
                response.sendRedirect("/jsp/netdisk/NetDisks.jsp?community=" + teasession._strCommunity + "&base=" + java.net.URLEncoder.encode(base, "UTF-8") + "&path=" + java.net.URLEncoder.encode(path, "UTF-8"));
            } else
            {
                response.sendRedirect(nexturl + "&path=" + java.net.URLEncoder.encode(path, "UTF-8"));
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    //判断子文件夹权限
    public static String checkSafety(String community, String ps, String member, int purview) throws SQLException
    {
        NetDisk obj = NetDisk.find(community, ps);
        if (obj.isType())
        {
            ps = obj.getParent();
        }
        Enumeration e = NetDisk.find(community, " AND type=0 AND path LIKE " + DbAdapter.cite(ps + "%"), null, false);
        while (e.hasMoreElements())
        {
            ps = (String) e.nextElement();
            int j = Safety.findByMember(community, ps, member);
            if (j < purview)
            {
                return ps;
            }
        }
        return null;
    }

    public static void del(File file)
    {
        File files[] = file.listFiles();
        if (files != null)
        {
            for (int index = 0; index < files.length; index++)
            {
                if (files[index].isDirectory())
                {
                    del(files[index]);
                } else
                {
                    files[index].delete();
                }
            }
        }
        file.delete();
    }

    public static void checkJsp(File file)
    {
        File files[] = file.listFiles();
        if (files != null)
        {
            for (int index = 0; index < files.length; index++)
            {
                if (files[index].isDirectory())
                {
                    checkJsp(files[index]);
                } else
                {
                    if (files[index].getName().endsWith(".jsp"))
                    {
                        files[index].renameTo(new File(files[index].getAbsolutePath() + ".html"));
                    }
                }
            }
        }
    }

    public static void compress(org.apache.tools.zip.ZipOutputStream zos, File file, String context) throws IOException
    {
        if (file.isFile())
        {
            byte by[] = new byte[(int) file.length()];
            FileInputStream is = new FileInputStream(file);
            is.read(by);
            is.close();

            org.apache.tools.zip.ZipEntry ze = new org.apache.tools.zip.ZipEntry(context + file.getName());
            zos.putNextEntry(ze);
            zos.write(by);
            zos.closeEntry();
        } else
        if (file.isDirectory())
        {
            zos.putNextEntry(new org.apache.tools.zip.ZipEntry(context + "/" + file.getName() + "/"));
            zos.closeEntry();
            File files[] = file.listFiles();
            if (files != null)
            {
                for (int index = 0; index < files.length; index++)
                {
                    compress(zos, files[index], context + "/" + file.getName() + "/");
                }
            }
        }
    }

    public static void compress(File dir, File file) throws IOException
    {
        org.apache.tools.zip.ZipOutputStream zos = new org.apache.tools.zip.ZipOutputStream(new FileOutputStream(file));
        compress(zos, dir, "");
        zos.close();

        /*
                 File parent = dir.getParentFile();
                 java.lang.Runtime rt = java.lang.Runtime.getRuntime();
                 Process p = rt.exec("\"" + EditNetDisk.class.getResource("/tea/ui/util/").toString().substring(6).replaceAll("/", "\\\\") + "rar\" a -r " + file.getAbsolutePath() + " " + dir.getAbsolutePath());
                 StringBuilder sb = new StringBuilder();
                 InputStream fis = p.getInputStream();
//                    fis.skip(100);
                 int value = 0;
                 while ((value = fis.read()) != -1)
                 {
            sb.append((char) value);
                 }
                 fis.close();
                 String result = new String(sb.toString().getBytes("ISO-8859-1"), "GBK");
                 int index = result.indexOf("正在更新");
                 if (index == -1)
                 {
            return "压缩失败";
                 } else
                 {
            index += 4;
            result = result.substring(index);
            result = result.replaceAll("\r\n", "<BR/>").replaceAll("\n", "<BR/>").replaceAll("\\\\", "/").replaceAll(parent.getAbsolutePath(), "");
            return result;
                 }*/
    }

    public static String decompression(File file, File dir) throws IOException
    {
        if (file.getName().toLowerCase().endsWith(".zip"))
        {
            StringBuilder result = new StringBuilder();
            try
            {
                org.apache.tools.zip.ZipFile zf = new org.apache.tools.zip.ZipFile(file);
                java.util.Enumeration enumer = zf.getEntries();
                while (enumer.hasMoreElements())
                {
                    org.apache.tools.zip.ZipEntry ze = (org.apache.tools.zip.ZipEntry) enumer.nextElement();
                    String zename = ze.getName();
                    //zename = new String(zename.getBytes("ISO-8859-1"), "UTF-8");
                    if (zename.endsWith(".jsp"))
                    {
                        zename += ".html";
                    }
                    System.out.println(zename);
                    result.append(zename + "<BR/>");
                    if (ze.isDirectory())
                    {
                        File file11 = new File(dir.getAbsolutePath() + "/" + zename);
                        file11.mkdirs();
                    } else
                    {
                        File file11 = new File(dir.getAbsolutePath() + "/" + zename).getParentFile();
                        if (!file11.exists())
                        {
                            file11.mkdirs();
                        }
                        byte zeby[] = new byte[(int) ze.getSize()];
                        InputStream is = zf.getInputStream(ze);
                        is.read(zeby);
                        is.close();
                        FileOutputStream fos = new FileOutputStream(dir.getAbsolutePath() + "/" + zename);
                        fos.write(zeby);
                        fos.close();
                    }
                }
                zf.close();
                result.append("全部完成");
                return result.toString();
            } catch (Exception e)
            {
                return (file.getName() + " 不是 ZIP 压缩文件");
            } finally
            {}
        } else
        {

            java.lang.Runtime rt = java.lang.Runtime.getRuntime();
            Process p = rt.exec("\"" + "unrar\" x -o+ -p- " + file.getAbsolutePath() + " " + dir.getAbsolutePath());
            StringBuilder sb = new StringBuilder();
            InputStream fis = p.getInputStream();
//                    fis.skip(100);
            int value = 0;
            while ((value = fis.read()) != -1)
            {
                sb.append((char) value);
            }
            fis.close();
            String result = new String(sb.toString().getBytes("ISO-8859-1"), "GBK");
            int index = result.indexOf("中解压");
            if (index == -1)
            {
                return (file.getName() + " 不是 RAR 压缩文件");
            } else
            {
                checkJsp(dir);
                index += 4;

                result = result.substring(index);
                result = result.replaceAll("\r\n", "<BR/>").replaceAll("\n", "<BR/>").replaceAll("\\\\", "/"); //.replaceAll(file.getAbsolutePath(), "");//
                return (result);
            }
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
