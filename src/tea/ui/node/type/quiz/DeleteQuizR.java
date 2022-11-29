package tea.ui.node.type.quiz;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.node.AccessMember;
import tea.entity.node.Node;
import tea.entity.node.QuizR;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteQuizR extends TeaServlet
{

    public DeleteQuizR()
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
            int i = Integer.parseInt(request.getParameter("QuizR"));
            QuizR quizr = QuizR.find(i);
            Node node = Node.find(quizr.getNode());
            if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview()>2)
            {
                response.sendError(403);
                return;
            }
            quizr.delete(teasession._nLanguage);
            response.sendRedirect("EditQuiz?node=" + teasession._nNode);
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
