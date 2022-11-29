package tea.ui.member.email;

import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.mail.internet.*;
import tea.entity.RV;
import tea.entity.member.EmailBox;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Email extends TeaServlet
{

    public Email()
    {
    }

    void outPart(PrintWriter out, Part part, String s, String s1) throws Exception
    {
        out.println("<!--" + part.getContentType() + "-->");
        String html = null;
        if (part.isMimeType("multipart/alternative"))
        {
            Multipart multipart = (Multipart) part.getContent();
            for (int i = 0; i < multipart.getCount(); i++)
            {
                Part p = multipart.getBodyPart(i);
                if (p.isMimeType("text/plain"))
                {
                    if (html == null)
                    {
                        html = "<PRE>" + (String) p.getContent() + "</PRE>";
                    }
                } else if (p.isMimeType("text/html"))
                {
                    html = (String) p.getContent();
                }
            }
        } else
        if (part.isMimeType("multipart/*")) //multipart/mixed //multipart/related
        {
            Multipart multipart = (Multipart) part.getContent();
            for (int i = 0; i < multipart.getCount(); i++)
            {
                Part p = multipart.getBodyPart(i);
                outPart(out, p, s, s1 + "," + i);
            }
            out.print("<script>");
            out.print("var is=document.getElementsByTagName('IMG');");
            out.print("for(var i=0;i<is.length;i++)");
            out.print("{");
            out.print("  var p=is[i].src;");
            out.print("  if(p.indexOf('cid:')==0)");
            out.print("  {");
            out.print("    is[i].src='" + s + "&cid='+p.substring(4);");
            out.print("  }");
            out.print("}");
            out.print("</script>");
        } else
        if (part.isMimeType("message/rfc822"))
        {
            outPart(out, (Part) part.getContent(), s, s1);
        } else if (part.isMimeType("application/*")) //application/octet-stream
        {
            html = "<a href=" + s + "&part=" + s1 + ">" + part.getFileName() + "</a>";
        } else if (part.isMimeType("image/*"))
        {
        } else if (part.isMimeType("text/plain"))
        {
            html = "<PRE>" + (String) part.getContent() + "</PRE>";
        } else
        {
            html = (String) part.getContent();
        }
        if (html != null)
        {
            out.print(EmailBox.decode(html));
        }
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String s = request.getParameter("emailbox");
            int i = Integer.parseInt(request.getParameter("emailno"));
            String s1 = request.getParameter("part");
            String cid = request.getParameter("cid");
            int eb = 0;
            if(s!=null && s.length()>0)
            {
            	eb = Integer.parseInt(s);
            }
            EmailBox emailbox = EmailBox.find(eb);//EmailBox.find(teasession._strCommunity, teasession._rv._strR, s);
            Folder folder = emailbox.openFolder();
            if (folder != null)
            {
                try
                {
                    Message m = folder.getMessage(i);
                    String s4 = "?emailbox=" + s + "&emailno=" + i;
                    if (s1 == null && cid == null)
                    {
                        PrintWriter out = response.getWriter();
                        outPart(out, m, s4, "");
                        out.close();
                    } else
                    {
                        MimeBodyPart bp = null;
                        if (cid != null)
                        {
                            Multipart mp = (Multipart) m.getContent();
                            for (int j = 0; j < mp.getCount(); j++)
                            {
                                bp = (MimeBodyPart) mp.getBodyPart(j);
                                if (cid.equals(bp.getContentID()))
                                {
                                    break;
                                }
                            }
                        } else
                        {
                            StringTokenizer stringtokenizer = new StringTokenizer(s1, ",");
                            if (stringtokenizer.hasMoreTokens())
                            {
                                int j = Integer.parseInt(stringtokenizer.nextToken());
                                Multipart multipart = (Multipart) m.getContent();
                                bp = (MimeBodyPart) multipart.getBodyPart(j);
                            }
                        }
                        InputStream is = (InputStream) bp.getContent();
                        response.setContentType(bp.getContentType());
                        response.setHeader("Content-Disposition", "; filename=" + java.net.URLEncoder.encode(EmailBox.decode(bp.getFileName()), "UTF-8"));
                        byte by[] = new byte[8192];
                        try
                        {
                            OutputStream out = response.getOutputStream();
                            int l;
                            while ((l = is.read(by)) != -1)
                            {
                                out.write(by, 0, l);
                            }
                            out.close();
                        } catch (Exception exception2)
                        {
                            exception2.printStackTrace();
                        }
                    }
                    emailbox.closeFolder();
                } catch (Exception exception1)
                {
                    exception1.printStackTrace();
                }
            }
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/member/email/EmailBoxs").add("tea/ui/member/email/Emails").add("tea/ui/member/email/Email");
    }
}
