package tea.ui.member.profile;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class PhotoPicture extends TeaServlet
{

    public PhotoPicture()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                //response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&NextUrl=" + request.getRequestURI() + "?" + request.getQueryString());
                //return;
            }
            String member = request.getParameter("member");
            if (member == null)
            {
                member = teasession._rv._strR;
            } else
            {
                /*
                       tea.entity.node.Purview purview = tea.entity.node.Purview.find(teasession._rv.toString());
                       if (!teasession._rv._strR.equals(member) && !(purview.isJob() || purview.isResume() || purview.isApply() || purview.isCompany() || tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv.toString())))
                       {
                           response.sendError(403);
                           return;
                       }*/
            }
            Profile p = Profile.find(member);
            response.sendRedirect(p.getPhotopath(teasession._nLanguage));
//            outStream(response, tea.entity.member.Profile.find(member,community).getPhoto(teasession._nLanguage),"PhotoPicture.jpg");
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
