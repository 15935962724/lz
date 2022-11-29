package tea.ui.node.general;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.Node;
import tea.html.*;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class ReplaceCreator extends TeaServlet
{

    public ReplaceCreator()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            if(!teasession._rv.isOrganizer(node.getCommunity()) && !teasession._rv.isWebMaster())
            {
                response.sendError(403);
                return;
            }
            RV rv = node.getCreator();
            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/general/ReplaceCreator.jsp?node=" + teasession._nNode);
                /*
                 Form form = new Form("foReplace", "POST", "ReplaceCreator");
                 form.setOnSubmit("return(submitText(this.MemberId, '" + super.r.getString(teasession._nLanguage, "InvalidMemberId") + "')" + ");");
                 form.add(new HiddenField("Node", teasession._nNode));
                 form.add(new Text(RequestHelper.format(super.r.getString(teasession._nLanguage, "InfReplaceCreator"), hrefGlance(teasession._rv))));
                 form.add(new TextField("MemberId"));
                 form.add(new Break());
                 form.add(new Radio("ApplyTo", "ThisNode", true));
                 form.add(new Text(super.r.getString(teasession._nLanguage, "ApplyToThisNode")));
                 form.add(new Radio("ApplyTo", "ThisTree", false));
                 form.add(new Text(super.r.getString(teasession._nLanguage, "ApplyToThisTree")));
                 form.add(new Radio("ApplyTo", "ThisCommunity", false));
                 form.add(new Text(super.r.getString(teasession._nLanguage, "ApplyToThisCommunity")));
                 form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                 PrintWriter printwriter = response.getWriter();
                 printwriter.print(form);
                 printwriter.close();*/
            } else
            {
                String s = request.getParameter("MemberId").toLowerCase();
                RV rv1 = new RV(s);
                if(!rv1.isExisted())
                {
                    outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidMemberId"));
                    return;
                }
                String s1 = request.getParameter("ApplyTo");
                if(s1.equals("ThisNode"))
                {
                    node.set(rv1);
                } else
                if(s1.equals("ThisTree"))
                {
                    Node.set(node.getCommunity(),node.getPath(),rv,rv1);
                } else
                if(s1.equals("ThisCommunity"))
                {
                    Node.set(node.getCommunity(),rv,rv1);
                }
                response.sendRedirect("Node?node=" + teasession._nNode);
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
        super.r.add("tea/ui/node/general/ReplaceCreator");
    }
}
