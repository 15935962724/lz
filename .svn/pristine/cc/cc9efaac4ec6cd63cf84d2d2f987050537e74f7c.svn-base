package tea.ui.node.type.career;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditCareer extends TeaServlet
{

    public EditCareer()
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
            if (!node.isCreator(teasession._rv) && !AccessMember.find(teasession._nNode, teasession._rv._strV).isProvider(29))
            {
                response.sendError(403);
                return;
            }
            Career career = Career.find(teasession._nNode);
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/type/career/EditCareer.jsp" + qs);
                /*
                                Form form = new Form("foEdit", "POST", "EditCareer");
                                form.add(new HiddenField("Node", teasession._nNode));
                                Table table = new Table();
                                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "TimeType") + ":"), true));
                                DropDown dropdown = new DropDown("TimeType", Integer.toString(career.getTimeType()));
                                for(int j = 0; j < Career.CAREER_TIMETYPE.length; j++)
                                    dropdown.addOption(Integer.toString(j), super.r.getString(teasession._nLanguage, Career.CAREER_TIMETYPE[j]));

                                row.add(new Cell(dropdown));
                                table.add(row);
                                Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Salary") + ":"), true));
                                row1.add(new Cell(new TextField("Salary", career.getSalary(teasession._nLanguage))));
                                table.add(row1);
                                Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Location") + ":"), true));
                                row2.add(new Cell(new TextField("Location", career.getLocation(teasession._nLanguage))));
                                table.add(row2);
                                Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Skill") + ":"), true));
                                row3.add(new Cell(new TextField("Skill", career.getSkill(teasession._nLanguage))));
                                table.add(row3);
                                Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Target") + ":"), true));
                                row4.add(new Cell(new TextField("Target", career.getTarget(teasession._nLanguage))));
                                table.add(row4);
                                form.add(table);
                                form.add(new Go(teasession._nLanguage, 1));
                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                                printwriter.print(form);
                                printwriter.print(new Languages(teasession._nLanguage, request));
                                printwriter.close();*/
            } else
            {
                int i = Integer.parseInt(request.getParameter("TimeType"));
                String s = request.getParameter("Salary");
                String s1 = request.getParameter("Location");
                String s2 = request.getParameter("Skill");
                String s3 = request.getParameter("Target");
                career.set(i, teasession._nLanguage, s, s1, s2, s3);
                if (request.getParameter("GoBack") != null)
                {
                    response.sendRedirect("EditNode?node=" + teasession._nNode);
                } else
                if (request.getParameter("GoFinish") != null)
                {
                    node.finished(teasession._nNode);
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
        super.r.add("tea/ui/node/type/career/EditCareer");
    }
}
