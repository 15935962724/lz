package tea.ui.netdisk;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.admin.*;
import tea.entity.member.*;
import net.mietian.convert.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.netdisk.*;
import java.sql.SQLException;
import tea.entity.netdisk.*;
import java.text.*;

public class EditFileCenter extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/resource/NetDisk");
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getHeader("referer"),"UTF-8"));
                return;
            }
            ServletContext application = getServletContext();
            String act = teasession.getParameter("act");
            String base = teasession.getParameter("base");
            String tmp = teasession.getParameter("filecenter");
            if(tmp == null) //下载附件时,讯雷没有传此参数
            {
                return;
            }
            int filecenter = Integer.parseInt(tmp);
            String member = teasession._rv._strV;
            String nexturl = teasession.getParameter("nexturl");

            /////上传word///
            HttpSession session = request.getSession();
            String word = null;
            byte by[] = teasession.getBytesParameter("word");
            if(by != null)
            {
                word = write(teasession._strCommunity,"filecenter/" + member,by,".doc");
                session.setAttribute("tea.fcword",word);
                return;
            } else
            {
                word = (String) session.getAttribute("tea.fcword");
            }
            //
            if("upload".equals(act) || "edit".equals(act)) //上传
            {
                int father = filecenter;
                String subject = teasession.getParameter("subject");
                String code = teasession.getParameter("code");
                boolean valid = Boolean.parseBoolean(teasession.getParameter("valid"));
                Date make = null;
                try
                {
                    make = FileCenter.sdf.parse(teasession.getParameter("make")); //teasession.getParameter("makeYear") + "-" + teasession.getParameter("makeMonth") + "-" + teasession.getParameter("makeDay"));
                } catch(Exception ex2)
                {
                }
                String unit = teasession.getParameter("unit");
                String content = teasession.getParameter("content");
                if("edit".equals(act))
                {
                    FileCenter obj = FileCenter.find(filecenter);
                    obj.set(subject,code,valid,make,unit,word,content);
                    //移动附件//
                    String fcas[] = teasession.getParameter("fca").split("/");
                    for(int i = 1;i < fcas.length;i++)
                    {
                        FileCenterAttach fca = FileCenterAttach.find(Integer.parseInt(fcas[i]));
                        fca.delete();
                    }
                    father = obj.getFather();
                } else
                {
                    filecenter = FileCenter.create(teasession._strCommunity,filecenter,true,member,true,subject,code,valid,make,unit,word,content);
                    FileCenterSafety.create(teasession._strCommunity,filecenter,0,3,"/","/","/" + member + "/"); //给创建者授权
                }
                String arr[] = teasession.getParameterValues("file");
                if(arr != null)
                {
                    for(int i = 0;i < arr.length;i++)
                    {
                        String name = arr[i].substring(arr[i].lastIndexOf('/') + 1);
                        String ex = name.substring(name.lastIndexOf(".") + 1).toLowerCase();
                        FileCenterAttach.create(filecenter,member,name,ex,arr[i]);
                    }
                }
                //收件人
                String smsmember = teasession.getParameter("smsmember"); //会员
                String smsunit = teasession.getParameter("smsunit"); //部门
                //短信
                String sms = teasession.getParameter("sms");
                if(sms != null)
                {
                    StringBuffer mobs = new StringBuffer();
                    Enumeration e = AdminUsrRole.find(teasession._strCommunity,smsmember,"/",smsunit);
                    while(e.hasMoreElements())
                    {
                        String smsm = (String) e.nextElement();
                        Profile p = Profile.find(smsm);
                        String mob = p.getMobile();
                        if(mobs.indexOf(mob) == -1)
                        {
                            mobs.append(mob).append(",");
                        }
                    }
                    SMSMessage.create(teasession._strCommunity,member,mobs.toString(),teasession._nLanguage,sms);
                }
                //站内信
                String msg = teasession.getParameter("msg");
                if(msg != null)
                {
                    String msgsubject = msg;
                    if(msgsubject.length() > 40)
                    {
                        msgsubject = msgsubject.substring(0,40) + "...";
                    }
                    msg += "<br/><br/><br/><a href='/jsp/netdisk/FileCenterView.jsp?community=" + teasession._strCommunity + "&base=0&filecenter=" + filecenter + "'>点这里</a>";
                    Message.create(teasession._strCommunity,5,teasession._rv._strV,smsmember,"/",smsunit,0,null,teasession._nLanguage,msgsubject,msg);
                }
                if(teasession.getParameter("safety") != null)
                {
                    //session.setAttribute("tea.smsfc" + filecenter, sms); //重定向之后，再发短信
                    response.sendRedirect("/jsp/netdisk/EditFileCenterSafety2.jsp?community=" + teasession._strCommunity + "&base=" + base + "&filecenter=" + filecenter);
                    return;
                }
                //
                filecenter = father;
            } else if("safety".equals(act))
            {
                FileCenter obj = FileCenter.find(filecenter);
                if(obj.isExtend()) //把上级权限复制下来,并去掉继承///
                {
                    Enumeration e = FileCenterSafety.findByFileCenter(filecenter," AND purview>1");
                    while(e.hasMoreElements())
                    {
                        FileCenterSafety s = FileCenterSafety.find(((Integer) e.nextElement()).intValue());
                        FileCenterSafety.create(teasession._strCommunity,filecenter,0,s.getPurview(),s.getRole(),s.getUnit(),s.getMember());
                    }
                    obj.setExtend(false);
                }
                int filecentersafety = Integer.parseInt(teasession.getParameter("filecentersafety"));
                String role = teasession.getParameter("role");
                String unit = teasession.getParameter("unit");
                member = teasession.getParameter("member");
                member = "/" + member.replaceAll("; ","/");
                if(filecentersafety == 0)
                {
                    FileCenterSafety.create(teasession._strCommunity,filecenter,0,1,role,unit,member);
                } else
                {
                    FileCenterSafety s = FileCenterSafety.find(filecentersafety);
                    s.set(0,1,role,unit,member);
                }
//        String sms = (String) session.getAttribute("tea.smsfc" + filecenter); // teasession.getParameter("message");
//        if (sms != null)
//        {
//          session.removeAttribute("tea.smsfc" + filecenter);
//          String mobs = mobile(teasession._strCommunity, filecenter);
//          SMSMessage.create(teasession._strCommunity, member, mobs, teasession._nLanguage, sms);
//        }
                filecenter = obj.getFather();
            } else if("newfolder".equals(act))
            {
                String subject = teasession.getParameter("subject");
                String content = teasession.getParameter("content");
                filecenter = FileCenter.create(teasession._strCommunity,filecenter,true,member,false,subject,null,true,null,null,word,content);
            } else if("delete".equals(act))
            {
                String ps[] = request.getParameterValues("filecenters");
                if(ps != null)
                {
                    for(int i = 0;i < ps.length;i++)
                    {
                        int id = Integer.parseInt(ps[i]);
                        int err = checkSafety(id,teasession._rv._strV,4);
                        if(err != 0)
                        {
                            FileCenter obj = FileCenter.find(err);
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("没有删除权限:" + obj.getSubject(),"UTF-8"));
                            return;
                        }
                        FileCenter obj = FileCenter.find(id);
                        obj.delete();
                    }
                }
            } else if("move".equals(act))
            {
                String ps[] = request.getParameterValues("filecenters");
                if(ps != null)
                {
                    for(int i = 0;i < ps.length;i++)
                    {
                        int id = Integer.parseInt(ps[i]);
                        int err = checkSafety(id,teasession._rv._strV,4);
                        if(err != 0)
                        {
                            FileCenter obj = FileCenter.find(err);
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("没有移动权限:" + obj.getSubject(),"UTF-8"));
                            return;
                        }
                        FileCenter obj = FileCenter.find(id);
                        obj.move(filecenter);
                    }
                }
            } else if("copy".equals(act))
            {
                String ps[] = request.getParameterValues("filecenters");
                if(ps != null)
                {
                    for(int i = 0;i < ps.length;i++)
                    {
                        int id = Integer.parseInt(ps[i]);
                        int err = checkSafety(id,teasession._rv._strV,1);
                        if(err != 0)
                        {
                            FileCenter obj = FileCenter.find(err);
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("没有读取权限:" + obj.getSubject(),"UTF-8"));
                            return;
                        }
                        FileCenter obj = FileCenter.find(id);
                        obj.clone(teasession._strCommunity,filecenter);
                    }
                }
            } else if("download".equals(act))
            {
                int err = checkSafety(filecenter,teasession._rv._strV,1);
                if(err != 0)
                {
                    FileCenter obj = FileCenter.find(err);
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("没有读取权限:" + obj.getSubject(),"UTF-8"));
                    return;
                }
                response.setContentType("application/octet-stream");
                OutputStream os = response.getOutputStream();
                int fca_id = Integer.parseInt(request.getParameter("filecenterattach"));
                if(fca_id > 0)
                {
                    FileCenterAttach fca = FileCenterAttach.find(fca_id);
                    response.setHeader("Content-Disposition","attachment; filename=" + new String(fca.getName().getBytes("GBK"),"ISO-8859-1")); //java.net.URLEncoder.encode(fca.getName(), "UTF-8"));
                    File f = new File(application.getRealPath(fca.getPath()));
                    response.setContentLength((int) f.length());
                    if(f.exists())
                    {
                        Filex.piped(new FileInputStream(f),os);
                    }
                } else
                {
                    Zip z = new Zip(os);
                    FileCenter fc = FileCenter.find(filecenter);
                    response.setHeader("Content-Disposition","attachment; filename=" + new String(fc.getSubject().getBytes("GBK"),"ISO-8859-1") + ".zip");
                    ArrayList al = FileCenterAttach.find(" AND filecenter=" + filecenter,0,200);
                    File[] fs = new File[al.size()];
                    for(int i = 0;i < fs.length;i++)
                    {
                        int fcaid = ((Integer) al.get(i)).intValue();
                        FileCenterAttach fca = FileCenterAttach.find(fcaid);
                        fs[i] = new File(application.getRealPath(fca.getPath()));
                        z.rename.put(fs[i],fca.getName());
                    }
                    z.zip(fs);
                }
                os.close();
                return;
            }
            if(nexturl == null)
            {
                response.sendRedirect("/jsp/netdisk/FileCenters.jsp?community=" + teasession._strCommunity + "&base=" + base + "&filecenter=" + filecenter);
            } else
            {
                response.sendRedirect(nexturl + "&filecenter=" + filecenter);
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    //可查看{filecenter}的所有用户的手机列表
    public static String mobile(String community,int filecenter) throws SQLException
    {
        StringBuffer m = new StringBuffer();
        StringBuffer u = new StringBuffer();
        StringBuffer r = new StringBuffer();
        Enumeration e = FileCenterSafety.findByFileCenter(filecenter,"");
        while(e.hasMoreElements())
        {
            int id = ((Integer) e.nextElement()).intValue();
            FileCenterSafety s = FileCenterSafety.find(id);
            String sm = s.getMember();
            String su = s.getUnit();
            String sr = s.getRole();
            m.append(sm.substring(1));
            u.append(su.substring(1));
            r.append(sr.substring(1));
        }
        StringBuffer mobs = new StringBuffer();
        e = AdminUsrRole.find(community,m.toString(),r.toString(),u.toString());
        while(e.hasMoreElements())
        {
            String member = (String) e.nextElement();
            String mob = Profile.find(member).getMobile();
            if(mob != null && mob.length() > 10)
            {
                mobs.append(mob).append(",");
            }
        }
        return mobs.toString();
    }

    //判断子文件夹权限
    public static int checkSafety(int filecenter,String member,int purview) throws SQLException
    {
        FileCenter obj = FileCenter.find(filecenter);
//    if (obj.isType())
//    {
//      return checkSafety(obj.getFather(), member, purview);
//    }
        Enumeration e = FileCenter.find(obj.getCommunity()," AND type=0 AND path LIKE " + DbAdapter.cite(obj.getPath() + "%"),null,false);
        while(e.hasMoreElements())
        {
            int id = ((Integer) e.nextElement()).intValue();
            int j = FileCenterSafety.findByMember(id,member);
            if(j < purview)
            {
                return id;
            }
        }
        return 0;
    }

    public static void del(File file)
    {
        File files[] = file.listFiles();
        if(files != null)
        {
            for(int index = 0;index < files.length;index++)
            {
                if(files[index].isDirectory())
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

    //Clean up resources
    public void destroy()
    {
    }
}
