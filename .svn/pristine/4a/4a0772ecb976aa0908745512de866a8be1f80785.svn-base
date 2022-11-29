package tea.ui.site;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.site.*;
import tea.resource.Resource;

public class EditCommunityjob extends TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Resource r = new Resource("/tea/resource/Job");
            int occ = 0, jobcity = 0;
            String action = teasession.getParameter("action");
            if (action.equals("jobsystem")) // ////////////招聘系统节号设置
            {
                Communityjob obj = Communityjob.find(teasession._strCommunity);

                int resume = Integer.parseInt(teasession.getParameter("resume"));
                int job = Integer.parseInt(teasession.getParameter("job"));
                int company = Integer.parseInt(teasession.getParameter("company"));
                int talkbacks = Integer.parseInt(teasession.getParameter("talkbacks"));
                int maxsum = Integer.parseInt(teasession.getParameter("maxsum"));
                String jobmember = teasession.getParameter("jobmember");
                byte by[];
                String logo = null;
                if (teasession.getParameter("logoclear") == null)
                {
                    by = teasession.getBytesParameter("logo");
                    if (by != null)
                    {
                        logo = write(teasession._strCommunity, by, ".gif");
                    } else
                    {
                        logo = obj.getLogo();
                    }
                }
                String a0 = null, a1 = null, a2 = null, a3 = null;
                String an0 = null, an1 = null, an2 = null, an3 = null;
                if (teasession.getParameter("applytable0clear") == null)
                {
                    by = teasession.getBytesParameter("applytable0");
                    if (by != null)
                    {
                        an0 = teasession.getParameter("applytable0Name");
                        a0 = write(teasession._strCommunity, by, an0);
                    } else
                    {
                        a0 = obj.getApplytable();
                        an0 = obj.getApplytablename();
                    }
                }
                if (teasession.getParameter("applytable1clear") == null)
                {
                    by = teasession.getBytesParameter("applytable1");
                    if (by != null)
                    {
                        an1 = teasession.getParameter("applytable1Name");
                        a1 = write(teasession._strCommunity, by, an1);
                    } else
                    {
                        a1 = obj.getApplytable2();
                        an1 = obj.getApplytablename2();
                    }
                }
                if (teasession.getParameter("applytable2clear") == null)
                {
                    by = teasession.getBytesParameter("applytable2");
                    if (by != null)
                    {
                        an2 = teasession.getParameter("applytable2Name");
                        a2 = write(teasession._strCommunity, by, an2);
                    } else
                    {
                        a2 = obj.getApplytable3();
                        an2 = obj.getApplytablename3();
                    }
                }
                if (teasession.getParameter("applytable3clear") == null)
                {
                    by = teasession.getBytesParameter("applytable3");
                    if (by != null)
                    {
                        an3 = teasession.getParameter("applytable3Name");
                        a3 = write(teasession._strCommunity, by, an3);
                    } else
                    {
                        a3 = obj.getApplytable4();
                        an3 = obj.getApplytablename4();
                    }
                }

                int options = 0;
                if (teasession.getParameter("confederacy") != null)
                {
                    options |= 1;
                }
                int rolejob = Integer.parseInt(teasession.getParameter("rolejob"));
                int roleresume = Integer.parseInt(teasession.getParameter("roleresume"));
                int roleapp = Integer.parseInt(teasession.getParameter("roleapp"));
                int rolecom = Integer.parseInt(teasession.getParameter("rolecom"));
                obj.set(resume, job, company, maxsum, talkbacks, jobmember, logo, a0, an0, a1, an1, a2, an2, a3, an3, options, rolejob, roleresume, roleapp, rolecom);
            } else if (action.equals("occupation")) // /////////////////职业类别
            {
                if (request.getParameter("occupation") != null)
                {
                    occ = Integer.parseInt(request.getParameter("occupation"));
                } else
                {
                    occ = Occupation.getRootId(teasession._strCommunity);
                }
                String code = request.getParameter("code");
                String subject = request.getParameter("subject");
                boolean _bAdd = request.getParameter("add") != null;
                boolean _bAddsub = request.getParameter("addsub") != null;
                boolean _bEdit = request.getParameter("edit") != null;
                if (_bAdd || _bAddsub || _bEdit)
                {
                    Occupation occ_obj = Occupation.find(teasession._strCommunity, code);
                    if (code == null || (code = code.trim()).length() < 1 || ((_bAdd || _bAddsub) && occ_obj.isExists()) || (_bEdit && occ_obj.isExists() && occ_obj.getOccupation() != occ))
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1168216894046"), "UTF-8")); // 编号已经存在
                        return;
                    }
                }
                Occupation objOcc = Occupation.find(occ);
                if (_bAdd)
                {
                    occ = Occupation.create(objOcc.getFather(), code, subject, 0, teasession._strCommunity);
                } else if (_bEdit)
                {
                    objOcc.set(code, subject);
                } else if (_bAddsub)
                {
                    occ = Occupation.create(occ, code, subject, 0, teasession._strCommunity);
                } else if (request.getParameter("delbig") != null)
                {
                    occ = objOcc.getFather();
                    objOcc.delete();
                } else if (request.getParameter("bigup") != null)
                {
                    objOcc.setSequenceUp();
                } else if (request.getParameter("bigdown") != null)
                {
                    objOcc.setSequenceDown();
                }
            } else if (action.equals("jobcity")) // /////////////////工作地区设置
            {
                if (request.getParameter("jobcity") != null)
                {
                    jobcity = Integer.parseInt(request.getParameter("jobcity"));
                }
                String code = request.getParameter("code");
                String subject = request.getParameter("subject");
                boolean _bAdd = request.getParameter("add") != null;
                boolean _bAddsub = request.getParameter("addsub") != null;
                boolean _bEdit = request.getParameter("edit") != null;
                if (_bAdd || _bAddsub || _bEdit)
                {
                    Jobcity occ_obj = Jobcity.find(teasession._strCommunity, code);
                    if (code == null || (code = code.trim()).length() < 1 || ((_bAdd || _bAddsub) && occ_obj.isExists()) || (_bEdit && occ_obj.isExists() && occ_obj.getJobcity() != jobcity))
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "1168216894046"), "UTF-8")); // 编号已经存在
                        return;
                    }
                }
                Jobcity objOcc = Jobcity.find(jobcity);
                if (_bAdd)
                {
                    jobcity = Jobcity.create(objOcc.getFather(), code, subject, 0, teasession._strCommunity);
                } else if (_bEdit)
                {
                    objOcc.set(code, subject);
                } else if (_bAddsub)
                {
                    jobcity = Jobcity.create(jobcity, code, subject, 0, teasession._strCommunity);
                } else if (request.getParameter("delbig") != null)
                {
                    jobcity = objOcc.getFather();
                    objOcc.delete();
                } else if (request.getParameter("bigup") != null)
                {
                    objOcc.setSequenceUp();
                } else if (request.getParameter("bigdown") != null)
                {
                    objOcc.setSequenceDown();
                }
            }
            response.sendRedirect("/jsp/community/EditCommunityjob.jsp?community=" + teasession._strCommunity + "&occupation=" + occ + "&jobcity=" + jobcity);
        } catch (Exception e)
        {
            e.printStackTrace();
            response.sendError(400, e.getMessage());
        }

    }

    // Clean up resources
    public void destroy()
    {
    }
}
