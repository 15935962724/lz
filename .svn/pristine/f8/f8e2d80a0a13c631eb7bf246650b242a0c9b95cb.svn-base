package tea.ui.node.type.quiz;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Node;
import tea.entity.node.QuizR;
import tea.html.Anchor;
import tea.html.Image;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class AnswerQuiz extends TeaServlet
{

    public AnswerQuiz()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            StringBuilder sb = new StringBuilder("?");
            java.util.Enumeration enumer = request.getParameterNames();
            while (enumer.hasMoreElements())
            {
                String str = enumer.nextElement().toString();
                sb.append(str + "=" + request.getParameter(str) + "&");
            }
            sb.setLength(sb.length() - 1);
            response.sendRedirect("/jsp/type/quiz/AnswerQuiz.jsp" + sb.toString());

//            TeaSession teasession = new TeaSession(request);
//            int i = 0;
//            String as[] = request.getParameterValues("QuizQ");
//            if (as != null)
//            {
//                for (int j = 0; j < as.length; j++)
//                {
//                    try
//                    {
//                        i += Integer.parseInt(request.getParameter(as[j]));
//                    } catch (Exception _ex)
//                    {}
//                }
//            }
//            int k = 0;
//            QuizR quizr = null;
//            for (Enumeration enumeration = QuizR.findByNode(teasession._nNode); enumeration.hasMoreElements(); )
//            {
//                k = ((Integer) enumeration.nextElement()).intValue();
//                quizr = QuizR.find(k);
//                if (i > quizr.getFloorScore() && i <= quizr.getCeilScore())
//                {
//                    break;
//                }
//            }
//
//            Node node = Node.find(teasession._nNode);
//            PrintWriter printwriter = response.getWriter();
//            printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
//            if (quizr != null)
//            {
//                if (quizr.getPictureFlag())
//                {
//                    printwriter.print(new Image("QuizRPicture?node=" + teasession._nNode + "&QuizR=" + k, quizr.getAlt(teasession._nLanguage), quizr.getAlign(teasession._nLanguage)));
//                }
//                printwriter.print(quizr.getText(teasession._nLanguage));
//                if (quizr.getVoiceFlag())
//                {
//                    printwriter.print(new Anchor("QuizRVoice?node=" + teasession._nNode + "&QuizR=" + k, r.getCommandImg(teasession._nLanguage, "Play")));
//                }
//                if (quizr.getFileFlag())
//                {
//                    printwriter.print(new Anchor("QuizRFile?node=" + teasession._nNode + "&QuizR=" + k, r.getCommandImg(teasession._nNode, "Download")));
//                }
//            }
//            long l = node.getOptions();
//            if ((l & 0x8000) != 0)
//            {
//                printwriter.print(new Anchor("Talkbacks?node=" + teasession._nNode, r.getCommandImg(teasession._nLanguage, "Talkbacks")));
//            }
//            if ((l & 0x10000) != 0)
//            {
//                printwriter.print(new Anchor("ChatFrameSet?node=" + teasession._nNode, "_blank", r.getCommandImg(teasession._nLanguage, "ChatRoom")));
//            }
//            printwriter.print(new Languages(teasession._nLanguage, request));
//            printwriter.close();
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/node/type/quiz/AnswerQuiz");
    }
}
