package tea.ui.node.type.quiz;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.node.AccessMember;
import tea.entity.node.Node;
import tea.entity.node.QuizQ;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditQuizQ extends TeaServlet
{

    public EditQuizQ()
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
            new MultipartRequest(request);
            Node node = Node.find(teasession._nNode);
            if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview()>1)
            {
                response.sendError(403);
                return;
            }
            String s = teasession.getParameter("QuizQ");
            boolean flag = s == null;
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/type/quiz/EditQuizQ.jsp" + qs);
/*
                String s1 = "";
                String s3 = "";
                int i = 0;
                if (!flag)
                {
                    int j = Integer.parseInt(s);
                    QuizQ quizq = QuizQ.find(j);
                    s1 = quizq.getText(teasession._nLanguage);
                    s3 = quizq.getAlt(teasession._nLanguage);
                    i = quizq.getAlign(teasession._nLanguage);
                }
                Form form = new Form("foEdit", "POST", "EditQuizQ");
                form.setMultiPart(true);
                form.add(new HiddenField("Node", teasession._nNode));
                if (!flag)
                {
                    form.add(new HiddenField("QuizQ", s));
                }
                Table table = new Table();
                table.add(new PictureInput(teasession._nLanguage, "Picture", 0, s3, i));
                table.add(new FileInput(teasession._nLanguage, "Voice"));
                table.add(new FileInput(teasession._nLanguage, "File"));
                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Text") + ":"), true));
                row.add(new Cell(new TextArea("Text", s1, 6, 60)));
                table.add(row);
                form.add(table);
                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                PrintWriter printwriter = response.getWriter();
                printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                printwriter.print(form);
                printwriter.print(new Languages(teasession._nLanguage, request));
                printwriter.close();
 */
            } else
            {
                String s2 = teasession.getParameter("Text");
                byte abyte0[] = teasession.getBytesParameter("Picture");
                String s4 = teasession.getParameter("Alt");
                int k = Integer.parseInt(teasession.getParameter("Align"));
                byte abyte1[] = teasession.getBytesParameter("Voice");
                String s5 = teasession.getParameter("FileName");
                byte abyte2[] = teasession.getBytesParameter("File");
                if (flag)
                {
                    QuizQ.create(teasession._nNode, teasession._nLanguage, s2, abyte0, s4, k, abyte1, s5, abyte2);
                } else
                {
                    QuizQ quizq1 = QuizQ.find(Integer.parseInt(s));
                    quizq1.set(teasession._nLanguage, s2, teasession.getParameter("ClearPicture") != null, abyte0, s4, k, teasession.getParameter("ClearVoice") != null, abyte1, teasession.getParameter("ClearFile") != null, s5, abyte2);
                }
                response.sendRedirect("EditQuiz?node=" + teasession._nNode);
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
        super.r.add("tea/ui/node/type/quiz/EditQuizQ");
    }
}
