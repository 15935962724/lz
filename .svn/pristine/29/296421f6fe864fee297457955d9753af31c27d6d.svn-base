package tea.ui.node.type.quiz;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteQuizA extends TeaServlet
{

    public DeleteQuizA()
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
            int i = Integer.parseInt(request.getParameter("QuizA"));
            QuizA quiza = QuizA.find(i);
            QuizQ quizq = QuizQ.find(quiza.getQuizQ());
            Node node = Node.find(quizq.getNode());
            if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview()>2)
            {
                response.sendError(403);
                return;
            }
            quiza.delete(teasession._nLanguage);
            response.sendRedirect("EditQuiz?node=" + teasession._nNode);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
