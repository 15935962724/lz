package tea.ui.node.type.chat;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditChat extends TeaServlet
{

    public EditChat()
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
            Node node = Node.find(teasession._nNode);
            if (!node.isCreator(teasession._rv) && AccessMember.find(teasession._nNode, teasession._rv._strV).getPurview()<2)
            {
                response.sendError(403);
                return;
            }
            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/chat/EditChat.jsp?" + request.getQueryString());
/*
                int i = node.getOptions1();
                Form form = new Form("foEdit", "POST", "EditChat");
                form.add(new HiddenField("Node", teasession._nNode));
                Table table = new Table();
                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Options") + ":"), true));
                Cell cell = new Cell(new CheckBox("ChatORecordAll", (i & 0x100000) != 0));
                cell.add(new Text(super.r.getString(teasession._nLanguage, "ChatORecordAll")));
                cell.add(new CheckBox("ChatOShowTime", (i & 0x200000) != 0));
                cell.add(new Text(super.r.getString(teasession._nLanguage, "ChatOShowTime")));
                row.add(cell);
                table.add(row);
                form.add(table);
                form.add(new Go(teasession._nLanguage, 1));
                PrintWriter printwriter = response.getWriter();
                printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                printwriter.print(form);
                printwriter.print(new Languages(teasession._nLanguage, request));
                printwriter.close();*/
            } else
            {
                int j = 0;
                if (request.getParameter("ChatORecordAll") != null)
                {
                    j |= 0x100000;
                }
                if (request.getParameter("ChatOShowTime") != null)
                {
                    j |= 0x200000;
                }
                node.setOptions1(j);
                if (request.getParameter("GoBack") != null)
                {
                    response.sendRedirect("EditNode?node=" + teasession._nNode);
                } else
                if (request.getParameter("GoFinish") != null)
                {
                    response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
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
        super.r.add("tea/ui/node/type/chat/EditChat");
    }
}
