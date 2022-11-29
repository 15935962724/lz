package tea.ui.node.type.quiz;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditQuizA extends TeaServlet
{

    public EditQuizA()
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
            int i = Integer.parseInt(teasession.getParameter("QuizQ"));
            QuizQ quizq = QuizQ.find(i);
            Node node = Node.find(quizq.getNode());
            if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview()>1)
            {
                response.sendError(403);
                return;
            }
            String s = teasession.getParameter("QuizA");
            boolean flag = s == null;
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/type/quiz/EditQuizA.jsp" + qs);
/*
                int j = 0;
                String s1 = "";
                String s3 = "";
                int l = 0;
                if (!flag)
                {
                    int i1 = Integer.parseInt(s);
                    QuizA quiza = QuizA.find(i1);
                    j = quiza.getScore();
                    s1 = quiza.getText(teasession._nLanguage);
                    s3 = quiza.getAlt(teasession._nLanguage);
                    l = quiza.getAlign(teasession._nLanguage);
                }
                Form form = new Form("foEdit", "POST", "EditQuizA");
                form.setMultiPart(true);
                form.setOnSubmit("return(submitInteger(this.Score,'" + super.r.getString(teasession._nLanguage, "InvalidScore") + "')" + ")");
                form.add(new HiddenField("Node", teasession._nNode));
                form.add(new HiddenField("QuizQ", i));
                if (!flag)
                {
                    form.add(new HiddenField("QuizA", s));
                }
                Table table = new Table();
                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Score") + ":"), true));
                row.add(new Cell(new TextField("Score", j)));
                table.add(row);
                table.add(new PictureInput(teasession._nLanguage, "Picture", 0, s3, l));
                table.add(new FileInput(teasession._nLanguage, "Voice"));
                table.add(new FileInput(teasession._nLanguage, "File"));
                Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Text") + ":"), true));
                row1.add(new Cell(new TextArea("Text", s1, 6, 60)));
                table.add(row1);
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
                int k = 0;
                try
                {
                    k = Integer.parseInt(teasession.getParameter("Score"));
                } catch (Exception _ex)
                {
                    outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidScore"));
                    return;
                }
                String s2 = teasession.getParameter("Text");
                byte abyte0[] = teasession.getBytesParameter("Picture");
                String s4 = teasession.getParameter("Alt");
                int j1 = Integer.parseInt(teasession.getParameter("Align"));
                byte abyte1[] = teasession.getBytesParameter("Voice");
                String s5 = teasession.getParameter("FileName");
                byte abyte2[] = teasession.getBytesParameter("File");
                if (flag)
                {
                    QuizA.create(i, k, teasession._nLanguage, s2, abyte0, s4, j1, abyte1, s5, abyte2);
                } else
                {
                    QuizA quiza1 = QuizA.find(Integer.parseInt(s));
                    quiza1.set(k, teasession._nLanguage, s2, teasession.getParameter("ClearPicture") != null, abyte0, s4, j1, teasession.getParameter("ClearVoice") != null, abyte1, teasession.getParameter("ClearFile") != null, s5, abyte2);
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
        super.r.add("tea/ui/node/type/quiz/EditQuizA");
    }
}
