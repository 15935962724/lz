package tea.ui.node.type.quiz;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditQuiz extends TeaServlet
{

    public EditQuiz()
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
            if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview()>1)
            {
                response.sendError(403);
                return;
            }
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/type/quiz/EditQuiz.jsp" + qs);
                /*
                                Table table = new Table();
                                int i;
                                for(Enumeration enumeration = QuizQ.findByNode(teasession._nNode); enumeration.hasMoreElements(); table.add(new Row(new Cell(new Anchor("EditQuizA?node=" + teasession._nNode + "&QuizQ=" + i, super.r.getCommandImg(teasession._nLanguage, "NewQuizA"))))))
                                {
                                    i = ((Integer)enumeration.nextElement()).intValue();
                                    QuizQ quizq = QuizQ.find(i);
                                    Text text = new Text();
                                    text.add(new Text(quizq.getText(teasession._nLanguage)));
                                    text.add(new Anchor("EditQuizQ?node=" + teasession._nNode + "&QuizQ=" + i, super.r.getCommandImg(teasession._nLanguage, "Edit")));
                                    if(quizq.isLayerExisted(teasession._nLanguage))
                                        text.add(new Anchor("DeleteQuizQ?node=" + teasession._nNode + "&QuizQ=" + i, super.r.getCommandImg(teasession._nLanguage, "Delete"), "return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "'));"));
                                    table.add(new Row(new Cell(text)));
                                    Table table2 = new Table();
                                    Row row1;
                                    for(Enumeration enumeration2 = QuizA.findByQuizQ(i); enumeration2.hasMoreElements(); table2.add(row1))
                                    {
                                        int k = ((Integer)enumeration2.nextElement()).intValue();
                                        QuizA quiza = QuizA.find(k);
                                        row1 = new Row(new Cell(new Text(quiza.getText(teasession._nLanguage))));
                                        row1.add(new Cell(new Text(Integer.toString(quiza.getScore()))));
                                        row1.add(new Cell(new Anchor("EditQuizA?node=" + teasession._nNode + "&QuizQ=" + i + "&QuizA=" + k, super.r.getCommandImg(teasession._nLanguage, "Edit"))));
                                        if(quiza.isLayerExisted(teasession._nLanguage))
                                            row1.add(new Cell(new Anchor("DeleteQuizA?node=" + teasession._nNode + "&QuizQ=" + i + "&QuizA=" + k, super.r.getCommandImg(teasession._nLanguage, "Delete"), "return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "'));")));
                                    }

                                    table.add(new Row(new Cell(table2)));
                                }

                                Table table1 = new Table();
                                table1.setTitle(super.r.getString(teasession._nLanguage, "FloorScore") + "\n" + super.r.getString(teasession._nLanguage, "CeilScore") + "\n" + super.r.getString(teasession._nLanguage, "Result") + "\n");
                                Row row;
                                for(Enumeration enumeration1 = QuizR.findByNode(teasession._nNode); enumeration1.hasMoreElements(); table1.add(row))
                                {
                                    int j = ((Integer)enumeration1.nextElement()).intValue();
                                    QuizR quizr = QuizR.find(j);
                                    row = new Row(new Cell(new Text(Integer.toString(quizr.getFloorScore()))));
                                    row.add(new Cell(new Text(Integer.toString(quizr.getCeilScore()))));
                                    row.add(new Cell(new Text(quizr.getText(teasession._nLanguage))));
                                    row.add(new Cell(new Anchor("EditQuizR?node=" + teasession._nNode + "&QuizR=" + j, super.r.getCommandImg(teasession._nLanguage, "Edit"))));
                                    if(quizr.isLayerExisted(teasession._nLanguage))
                                        row.add(new Cell(new Anchor("DeleteQuizR?node=" + teasession._nNode + "&QuizR=" + j, super.r.getCommandImg(teasession._nLanguage, "Delete"), "return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "'));")));
                                }

                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                                printwriter.print(table);
                                printwriter.print(new Anchor("EditQuizQ?node=" + teasession._nNode, super.r.getCommandImg(teasession._nLanguage, "NewQuizQ")));
                                printwriter.print(table1);
                                printwriter.print(new Anchor("EditQuizR?node=" + teasession._nNode, super.r.getCommandImg(teasession._nLanguage, "NewQuizR")));
                                Form form = new Form("foEdit", "POST", "EditQuiz");
                                form.add(new HiddenField("Node", teasession._nNode));
                                form.add(new Go(teasession._nLanguage, 1));
                                printwriter.print(form);
                                printwriter.print(new Languages(teasession._nLanguage, request));
                                printwriter.close();
                 */
            } else
            if (request.getParameter("GoBack") != null)
            {
                response.sendRedirect("EditNode?node=" + teasession._nNode);
            } else
            if (request.getParameter("GoFinish") != null)
            {
                response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
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
        super.r.add("tea/ui/node/type/quiz/EditQuiz");
    }
}
