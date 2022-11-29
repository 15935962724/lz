package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.site.*;
import java.util.regex.*;
import tea.entity.admin.*;
import tea.entity.admin.ig.*;

public class EditIg extends TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8"));
                return;
            }
            // ////默认的动态桌面///////
            String member;
            String _strRole = request.getParameter("role");
            int role = 0;
            if(_strRole != null)
            {
                role = Integer.parseInt(_strRole);
            }
            if(role > 0)
            {
                if(!teasession._rv.isOrganizer(teasession._strCommunity))
                {
                    response.sendError(403);
                    return;
                } else
                {
                    member = Igtab.DEFAULT_MEMBER + role;
                }
            } else
            {
                member = teasession._rv.toString();
            }
            // /////
            int igtab = 0;
            String _strIgtab = request.getParameter("igtab");
            if(_strIgtab != null)
            {
                igtab = Integer.parseInt(_strIgtab);
            } else
            {
                // System.out.println(igtab);
            }
            String at = request.getParameter("at");
            String ct = request.getParameter("ct");
            String dt = request.getParameter("dt");
            String mp = request.getParameter("mp");
            String dp = request.getParameter("dp");
            String mz = request.getParameter("mz");
            String mc = request.getParameter("mc");
            String mt = request.getParameter("mt");
            if(at != null) // 添加标签
            {
                igtab = Igtab.create(member,"为此标签命名");
                response.sendRedirect("/jsp/admin/DynamicDesktop.jsp?community=" + teasession._strCommunity + "&igtab=" + igtab + "&role=" + role);
            } else if(ct != null) // 切换标签
            {
                response.sendRedirect("/jsp/admin/DynamicDesktop.jsp?community=" + teasession._strCommunity + "&igtab=" + ct + "&role=" + role);
            } else if(dt != null) // 删除标签
            {
                Igtab obj = Igtab.find(Integer.parseInt(dt));
                obj.delete();
                response.sendRedirect("/jsp/admin/DynamicDesktop.jsp?community=" + teasession._strCommunity + "&igtab=0&role=" + role);
            } else if(mp != null) // 移动内容
            {
                Igtab obj = Igtab.find(igtab);
                obj.setMp(":" + mp);
            } else if(mt != null) // 移动到另一个标签
            {
                String str[] = mt.split(":");
                // //先删除
                Igtab obj = Igtab.find(igtab);
                mp = obj.getMp();
                Matcher m = Pattern.compile(":" + str[0] + "_(\\d+)").matcher(mp);
                if(m.find())
                {
                    int i = Integer.parseInt(m.group(1));
                    mp = mp.replaceFirst(":" + str[0] + "_" + i,"");
                    obj.setMp(mp);
                    // //再添加
                    obj = Igtab.find(Integer.parseInt(str[1]));
                    mp = obj.getMp();
                    if(mp == null || mp.indexOf(":" + str[0] + "_") == -1)
                    {
                        obj.setMp(mp + ":" + str[0] + "_" + i);
                    }
                }
            } else if(dp != null) // 删除内容
            {
                Igtab obj = Igtab.find(igtab);
                mp = obj.getMp();
                if(mp.startsWith(dp + "_"))
                {
                    mp = mp.substring(dp.length());
                } else
                {
                    mp = mp.replaceFirst(":" + dp + "_",":_");
                }
                obj.setMp(mp);
            } else if(mz != null) // 内容最小化相关
            {
                int i = mz.indexOf("_");
                if(i != -1)
                {
                    int igd = Integer.parseInt(mz.substring(0,i));
                    int min = Integer.parseInt(mz.substring(i + 1));
                    Igtab obj = Igtab.find(igtab);
                    mz = obj.getMz();
                    if(mz == null)
                    {
                        mz = "";
                    }
                    if(min == 1) // 如果是最小化,则写入库中,否则删除
                    {
                        mz = ":" + igd + "_1" + mz;
                    } else
                    {
                        mz = mz.replaceFirst(":" + igd + "_1","");
                    }
                    obj.setMz(mz);
                }
            } else if(mc != null) // 显示数量
            {
                int i = mc.indexOf("_");
                if(i != -1)
                {
                    int igd = Integer.parseInt(mc.substring(0,i));
                    int count = Integer.parseInt(mc.substring(i + 1));
                    Igtab obj = Igtab.find(igtab);
                    mc = obj.getMc();
                    if(mc == null)
                    {
                        mc = "";
                    }
                    mc = ":" + igd + "_" + count + mc.replaceFirst(":" + igd + "_\\d+","");
                    obj.setMc(mc);
                }
                response.sendRedirect(request.getParameter("url"));
            } else
            {
                Enumeration e = request.getParameterNames();
                while(e.hasMoreElements())
                {
                    String name = (String) e.nextElement();
                    String value = request.getParameter(name);
                    if(name.startsWith("rt_")) // 重命名标签
                    {
                        Igtab obj = Igtab.find(Integer.parseInt(name.substring(3)));
                        obj.set(value);
                    }
                    // System.out.println(name + ":" + value);
                }
            }
            String act = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            if("selectigdirectory".equals(act))
            {
                int igdirectory = Integer.parseInt(request.getParameter("igdirectory"));
                Igtab obj = Igtab.find(igtab);
                mp = obj.getMp();
                obj.setMp(mp + ":" + igdirectory + "_3");
                response.sendRedirect("/jsp/admin/DynamicDesktop.jsp?community=" + teasession._strCommunity + "&igtab=" + igtab + "&role=" + role);
            } else if("reset".equals(act)) // 还原默认桌面///
            {
                member = request.getParameter("member");
                Enumeration e = Igtab.findByMember(member);
                while(e.hasMoreElements())
                {
                    int id = ((Integer) e.nextElement()).intValue();
                    Igtab obj = Igtab.find(id);
                    obj.delete();
                }
                Enumeration es = Subscriber.findJoined(new RV(member));
                while(es.hasMoreElements())
                {
                    String community = (String) es.nextElement();
                    StringBuilder sb = new StringBuilder();
                    int index = 0;
                    AdminFunction root = AdminFunction.getRoot(community,teasession._nStatus);
                    String popedom = AdminUsrRole.find(community,member).getAdminfunction(request.getRemoteAddr());
                    Enumeration enumer = AdminFunction.findByFather(root.id);
                    while(enumer.hasMoreElements())
                    {
                        int id = ((Integer) enumer.nextElement()).intValue();
                        AdminFunction obj_af = AdminFunction.find(id);
                        if(obj_af.getType() == 0 && popedom.indexOf("/" + id + "/") != -1)
                        {
                            Enumeration e2 = AdminFunction.findByFather(id);
                            while(e2.hasMoreElements())
                            {
                                id = ((Integer) e2.nextElement()).intValue();
                                if(popedom.indexOf("/" + id + "/") != -1)
                                {
                                    sb.append(":").append(id).append("_").append((index++ % 3) + 1);
                                }
                            }
                        }
                    }
                    if(sb.length() > 0)
                    {
                        Community c = Community.find(community);
                        int id = Igtab.create(member,c.getName(teasession._nLanguage));
                        Igtab obj = Igtab.find(id);
                        obj.setMp(sb.toString());
                    }
                }
                //response.sendRedirect(nexturl);
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
