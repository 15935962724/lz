package tea.ui.node.type.weblog;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaSession;
import tea.ui.TeaServlet;
import tea.entity.node.*;
import tea.htmlx.TimeSelection;

public class EditWeblog extends TeaServlet
{
    public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);
            if (teasession.getParameter("webloginfo") != null) // 编辑博客基本信息
            {
                if (teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                String member = teasession._rv.toString();
                String subject = teasession.getParameter("subject");
                String email = teasession.getParameter("email");
                boolean sex = new Boolean(teasession.getParameter("sex")).booleanValue();
                Blog blog = Blog.find(node.getCommunity(), member);
                java.util.Date birthday = Blog.sdf.parse(teasession.getParameter("birthdayYear") + "-" + teasession.getParameter("birthdayMonth") + "-" + teasession.getParameter("birthdayDay"));
                String state = teasession.getParameter("State");
                String city = teasession.getParameter("City");
                node = Node.find(blog.getHome());
                node.setSubject(subject, teasession._nLanguage);
                tea.entity.member.Profile profile = tea.entity.member.Profile.find(member);
                profile.setSex(sex);
                profile.setEmail(email);
                profile.setBirth(birthday);
                profile.setState(state, teasession._nLanguage);
                profile.setCity(city, teasession._nLanguage);

                tea.entity.member.BLOGProfile bp = tea.entity.member.BLOGProfile.find(member);
                String nickname = teasession.getParameter("nickname");
                byte by[] = teasession.getBytesParameter("picture");
                String picture;
                if (by == null)
                {
                    picture = bp.getPicture();
                } else
                {
                    picture = super.write(node.getCommunity(), by, ".gif");
                }
                int width = Integer.parseInt(teasession.getParameter("width"));
                int height = Integer.parseInt(teasession.getParameter("height"));
                bp.set(nickname, picture, width, height);
                response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "UpdateSuccessful"), "UTF-8"));
            } else
            {
                // 创建/编辑博客文章
                if ((node.getOptions1() & 1) == 0)
                {
                    if (teasession._rv == null)
                    {
                        response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                        return;
                    }
                    AccessMember obj_am = AccessMember.find(node._nNode, teasession._rv._strV);
                    if (!node.isCreator(teasession._rv) && !obj_am.isProvider(82))
                    {
                        response.sendError(403);
                        return;
                    }
                }

                String subject = teasession.getParameter("Subject");
                String text = teasession.getParameter("Text");
                String Keywords = teasession.getParameter("Keywords");
                Date date4 = TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"), teasession.getParameter("IssueHour"), teasession.getParameter("IssueMinute"));

                if (teasession.getParameter("NewNode") != null)
                {
                    int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                    int options1 = node.getOptions1();
                    Category cat = Category.find(teasession._nNode); //82
                    teasession._nNode = Node.create(teasession._nNode, sequence, node.getCommunity(), teasession._rv, cat.getCategory(), (options1 & 2) != 0, node.getOptions(), options1, node.getDefaultLanguage(), null, null, date4, 0, 0, 0, 0,  null, teasession._nLanguage, subject, Keywords,"", text, null, "", 0, null, "", "", "", "", null, null);
                    node.finished(teasession._nNode);
                } else
                {
                    node.set(teasession._nLanguage, subject, text);
                    node.setKeywords(Keywords, teasession._nLanguage);
                    node.setTime(date4);
                }
                delete(node);
                if (teasession.getParameter("GoPicture") != null) // 图片
                {
                    response.sendRedirect("/jsp/type/TypePicture.jsp?node=" + teasession._nNode);
                } else if (teasession.getParameter("nexturl") != null)
                {
                    response.sendRedirect(teasession.getParameter("nexturl"));
                } else
                // 完成
                {
                    response.sendRedirect("Weblog?node=" + teasession._nNode);
                }
            }
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
