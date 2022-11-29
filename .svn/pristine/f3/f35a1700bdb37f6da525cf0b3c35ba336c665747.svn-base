package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Home;
import tea.html.*;
import tea.htmlx.FileInput;
import tea.htmlx.Languages;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditHome extends TeaServlet
{

    public EditHome()
    {
    }

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
            if (!teasession._rv.isReal())
            {
                response.sendError(403);
                return;
            }
            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/profile/EditHome.jsp?" +request.getQueryString());

                /*
                                Form form = new Form("foEdit", "POST", "EditHome");
                                form.setMultiPart(true);
                                Table table = new Table();
                                table.add(new FileInput(teasession._nLanguage, "Picture"));
                                table.add(new FileInput(teasession._nLanguage, "Voice"));
                                table.add(new FileInput(teasession._nLanguage, "File"));
                                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Content") + ":"), true));
                                row.add(new Cell(new TextArea("Content", home.getContent(teasession._nLanguage), 8, 60)));
                                table.add(row);
                                form.add(table);
                                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(form);
                                printwriter.print(new Script("document.foEdit.Content.focus();"));
                                printwriter.print(new Languages(teasession._nLanguage, request));
                                printwriter.close();*/
            } else
            {
                Home home = Home.find(teasession._strCommunity, teasession._rv._strR);
                String content = teasession.getParameter("Content");
                String picture;
                if (teasession.getParameter("ClearPicture") != null)
                {
                    picture = "";
                } else
                {
                    byte abyte0[] = teasession.getBytesParameter("Picture");
                    if (abyte0 != null)
                    {
                        picture = super.write(teasession._strCommunity, abyte0,".gif");
                    } else
                    {
                        picture = home.getPicture(teasession._nLanguage);
                    }
                }
                String voice;
                if (teasession.getParameter("ClearVoice") != null)
                {
                    voice = "";
                } else
                {
                    byte abyte0[] = teasession.getBytesParameter("Voice");
                    if (abyte0 != null)
                    {
                        voice = super.write(teasession._strCommunity, abyte0,".gif");
                    } else
                    {
                        voice = home.getVoice(teasession._nLanguage);
                    }
                }

                String file, filename;
                if (teasession.getParameter("ClearFile") != null)
                {
                    file = filename = "";
                } else
                {
                    byte abyte0[] = teasession.getBytesParameter("File");
                    if (abyte0 != null)
                    {
                        filename = teasession.getParameter("FileName");
                        file = super.write(teasession._strCommunity, abyte0,".gif");
                    } else
                    {
                        file = home.getFile(teasession._nLanguage);
                        filename = home.getFileName(teasession._nLanguage);
                    }
                }
                home.set(teasession._nLanguage, content, picture, voice, file, filename);
                response.sendRedirect("Profile");
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
        super.r.add("tea/ui/member/profile/EditHome");
    }
}
