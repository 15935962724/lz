package tea.ui.node.type.interlocution;

import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import java.util.*;
import tea.entity.member.*;
import tea.ui.TeaSession;
import tea.entity.node.*;
import tea.htmlx.TimeSelection;
import tea.service.*;
import tea.entity.RV;

public class EditInterlocution extends tea.ui.TeaServlet
{
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);

            if ((node.getOptions1() & 1) == 0)
            {
                if (teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                if (!node.isCreator(teasession._rv) && !AccessMember.find(node._nNode, teasession._rv._strV).isProvider(73))
                {
                    response.sendError(403);
                    return;
                }
            } else if (teasession._rv == null)
            {
                teasession._rv = new RV("webmaster", "Home");
            }

            String text = teasession.getParameter("Text");
            String act = request.getParameter("act");
            if ("editreply".equals(act))
            {
            	//问题回复提交按钮
            	  HttpSession session = request.getSession();
            	 String vertify_alter = "验证码错误，请重新输入";
                 if((teasession.getParameter("vertify_alter") != null) && (teasession.getParameter("vertify_alter").length() > 0))
                 {
                     vertify_alter = teasession.getParameter("vertify_alter");
                 }
                 String sv = (String) session.getAttribute("sms.vertify");
                 String vertify = request.getParameter("vertify");
                 if(vertify != null)
                 {
                     if(!vertify.trim().equalsIgnoreCase(sv))
                     {
                         session.removeAttribute("vertify"); //退出session
                         java.io.PrintWriter out = response.getWriter();

                         out.print("<script  language='javascript'>alert('" + vertify_alter + "');window.location.href='/servlet/Node?node=" + teasession._nNode + "&language=" + teasession._nLanguage + "';</script> ");
                         out.close();
                         return;
                     }
                 } else
                 {
                     java.io.PrintWriter out = response.getWriter();

                     out.print("<script  language='javascript'>alert('" + vertify_alter + "');window.location.href='/servlet/Node?node=" + teasession._nNode + "&language=" + teasession._nLanguage + "';</script> ");
                     out.close();
                     return;
                 }



                if (Integer.parseInt(request.getParameter("TextOrHtml")) == 0)
                {
                    text = text.replaceAll("\r\n", "<BR>").replaceAll(" ", "&nbsp;");
                }
                boolean hidden = "true".equals(request.getParameter("hidden"));
                // boolean send = "true".equals(request.getParameter("send"));

                String send = request.getParameter("send");

                if (send != null)
                {
                    tea.entity.member.Profile profile1 = tea.entity.member.Profile.find(node.getCreator()._strR);
                    String s11 = profile1.getMember();
                    Message.create(teasession._strCommunity, teasession._rv._strV, s11, teasession._nLanguage, "回复:" + node.getSubject(teasession._nLanguage), "<font color=red>您的回复是：</font>" + text + "<hr>" + node.getText(teasession._nLanguage));
                }
                InterlocutionReply.create(teasession._nNode, teasession._nLanguage, teasession._rv._strV, text, hidden,teasession._strCommunity);
            } else if ("deletereply".equals(act))
            {
                String mbrs[] = request.getParameterValues("interlocutionreply");
                if (mbrs != null)
                {
                    for (int i = 0; i < mbrs.length; i++)
                    {
                        int interlocutionreply = Integer.parseInt(mbrs[i]);
                        InterlocutionReply obj = InterlocutionReply.find(interlocutionreply);
                        obj.delete();
                    }
                }
            } else if ("createtype".equals(act))
            {
                int nodes = teasession._nNode;
                int id = 0;
                String types = null;
                if (teasession.getParameter("createtype") != null && teasession.getParameter("createtype").length() > 0)
                {
                    types = teasession.getParameter("createtype");

                }
                if (teasession.getParameter("id") != null && teasession.getParameter("id").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("id"));
                }
                InterlocutionType intertype = InterlocutionType.find(id);

                boolean falg = intertype.isExists();

                if (falg) //
                {
                    intertype.setTypes(types);
                } else
                {
                    intertype.create(teasession._nNode, types);
                }

                response.sendRedirect("/jsp/type/interlocution/InterlocutionType.jsp");

                return;
            }

            else
            {
                String subject = teasession.getParameter("Subject");
                if (subject == null || subject.length() < 1)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "InvalidSubject"), "UTF-8"));
                    return;
                }
                if (teasession.getParameter("NewNode") != null)
                {
                    int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                    int options1 = node.getOptions1();
                    int defautllangauge = node.getDefaultLanguage();
                    Category obj = Category.find(teasession._nNode);
                    teasession._nNode = Node.create(teasession._nNode, sequence, node.getCommunity(), teasession._rv, obj.getCategory(),  (options1 & 2) != 0, node.getOptions(), options1, defautllangauge, null, null,  new java.util.Date(), 0, 0, 0, 0, null,teasession._nLanguage, subject, null,"", text, null, "", 0, null, "", "", "", "", null,null);
					node=Node.find(teasession._nNode);
                } else
                {
                    node.set(teasession._nLanguage, subject, text);
                }

                Interlocution obj = Interlocution.find(teasession._nNode, teasession._nLanguage);
                int hint = Integer.parseInt(request.getParameter("Hint"));
                String phone = request.getParameter("phone");
                String mobile = request.getParameter("mobile");
                String email = request.getParameter("email");
                String name = request.getParameter("name");
                String member = request.getParameter("member");
                int offerintegral = 0, nodestatic = 0;
                float integral = 0;
                if (teasession.getParameter("offerintegral") != null && teasession.getParameter("offerintegral").length() > 0)
                {
                    offerintegral = Integer.parseInt(teasession.getParameter("offerintegral"));
                }
                if (teasession.getParameter("integral") != null && teasession.getParameter("integral").length() > 0)
                {
                    integral = Float.parseFloat(teasession.getParameter("integral"));
                }
                if (teasession.getParameter("") != null && teasession.getParameter("nodestatic").length() > 0)
                {
                    nodestatic = Integer.parseInt(teasession.getParameter("nodestatic"));
                }

                String types = null;
                int type = 0;
                if(teasession.getParameter("types")!=null && teasession.getParameter("types").length()>0)
                {
                    types = teasession.getParameter("types");
                    type = Integer.parseInt(types);
                }

                boolean falg = Interlocution.option(node._nNode, teasession._nLanguage);

                if (integral < offerintegral && !falg)
                {
                    String nexturls = teasession.getParameter("nexturl");
                    if (nexturls != null)
                    {
                        response.sendRedirect(nexturls);
                    } else
                    {
                        response.sendRedirect("Interlocution?node=" + teasession._nNode);
                    }
                    return;
                }
                obj.set(hint, phone, mobile, email, name, offerintegral, nodestatic, member,type);

                delete(node);

                node.finished(teasession._nNode);

                boolean flag3 = teasession.getParameter("MsgOSendEmail") != null; // ????E-MAIL????
                if (flag3)
                {
                    tea.entity.member.Profile profile1 = tea.entity.member.Profile.find(node.getCreator()._strR);
                    String s11 = profile1.getEmail();
                    String Cc = request.getParameter("Cc");
                    String Bcc = request.getParameter("Bcc");
                    SendEmaily se = new SendEmaily(teasession._strCommunity);
                    se.sendEmail(email, s11, subject, text);
                }
                String nexturls = teasession.getParameter("nexturl");
                String urlnode = teasession.getParameter("urlnode");
                if (urlnode != null && urlnode.length()>0)
                {
                    //response.sendRedirect("/jsp/info/Alert_Interlocution.jsp?info=" + java.net.URLEncoder.encode("您的提问已经提交成功！", "UTF-8") + "&nexturl="+nexturls);
                    response.sendRedirect("/servlet/Folder?node="+urlnode+"&language=1&info=" + java.net.URLEncoder.encode("您的提问已经提交成功！", "UTF-8") + "&nexturl=/servlet/Interlocution?node=" + teasession._nNode);

                    return;
                }
            }
            String nexturl = teasession.getParameter("nexturl");
            if (nexturl != null)
            {
                response.sendRedirect(nexturl);
            } else
            {
                response.sendRedirect("Interlocution?node=" + teasession._nNode);
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
