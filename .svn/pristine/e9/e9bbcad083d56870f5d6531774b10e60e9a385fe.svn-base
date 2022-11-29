package tea.ui.node.type.chat;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;

import tea.entity.RV;
import tea.entity.node.Chat;
import tea.entity.util.ZoomOut;
import tea.html.HtmlElement;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class SendChat extends TeaServlet
{

    public SendChat()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try
        {
            TeaSession teasession = new TeaSession(request);
            String member = teasession.getParameter("member");
            if(teasession._rv == null && member == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String community = teasession.getParameter("community");
            HttpSession session = request.getSession();
            java.io.PrintWriter out = response.getWriter();
            Integer obj = (Integer) session.getAttribute("http.length");

            ServletContext application = this.getServletContext();

            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/chat/SendChat.jsp?" + request.getQueryString());

                /*             Form form = new Form("foSend", "POST", "SendChat");
                             form.setMultiPart(true);
                             form.setOnSubmit("this.To.value=parent.frChatMembers.foChatMembers.Member.value;this.Action.value=parent.frChatMembers.foChatMembers.Action.value;this.Text.value=this.Buffer.value;this.Buffer.value='';return(true);");
                             form.add(new HiddenField("Node", teasession._nNode));
                             form.add(new HiddenField("To", ""));
                             form.add(new HiddenField("Action", "0"));
                             Table table = new Table();
                             Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Text") + ":"), true));
                             Cell cell = new Cell(new TextField("Buffer", "", 40, 255));
                             cell.add(new Button("Submit", super.r.getString(teasession._nLanguage, "Submit"), "this.form.Buffer.focus();"));
                             cell.add(new Button(1, "Leave", super.r.getString(teasession._nLanguage, "Leave"), "window.location='LeaveChat'"));
                             row.add(cell);
                             table.add(row);
                             table.add(new FileInput(teasession._nLanguage, "Picture"));
                             table.add(new FileInput(teasession._nLanguage, "Voice"));
                             table.add(new FileInput(teasession._nLanguage, "File"));
                             form.add(new HiddenField("Text"));
                             form.add(table);
                 outText(teasession,response, "<HTML><HEAD><META HTTP-EQUIV=Content-Type CONTENT=\"text/html; charset=" + TeaServlet.CHARSET[teasession._nLanguage] + "\">" + "<LINK REL=StyleSheet HREF=/tea/tea.css TYPE=text/css MEDIA=screen>" + "<SCRIPT LANGUAGE=JAVASCRIPT SRC=/tea/tea.js></SCRIPT>" + "</HEAD>" + form.toString() + new Languages(teasession._nLanguage, request) + "</HTML>");
                 */
            } else
            {
                RV rv = new RV(teasession.getParameter("to"));
                int action = Integer.parseInt(teasession.getParameter("action"));
                String text = teasession.getParameter("buffer");
                tea.entity.RV currentlyrv;
                if(teasession._rv == null)
                {
                    currentlyrv = new RV(member,community);
                } else
                {
                    currentlyrv = teasession._rv;
                }
                String attach = teasession.getParameter("attach");

                if(attach != null && attach != null)
                {
                    File f = new File(getServletContext().getRealPath(attach));
                    BufferedImage bi = ImageIO.read(f);
                    if(bi != null)
                    {
                        ZoomOut zo = new ZoomOut();
                        bi = zo.imageZoomOut(bi,300,200);
                        ImageIO.write(bi,"JPEG",f);
                    }
                }

                if(text.trim().length() != 0)
                {
                    Chat.create(teasession._nNode,currentlyrv,action,rv,teasession._nLanguage,HtmlElement.htmlToText(text),attach);
                }

                response.sendRedirect("/jsp/type/chat/SendChat.jsp?node=" + teasession._nNode);
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
        super.r.add("tea/ui/node/type/chat/SendChat");
    }
}
