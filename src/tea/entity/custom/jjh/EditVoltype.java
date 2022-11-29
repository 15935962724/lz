package tea.entity.custom.jjh;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import tea.db.DbAdapter;
import tea.entity.Http;
import tea.entity.node.Media;
import tea.ui.*;

public class EditVoltype extends TeaServlet {


    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
		Http h=new Http(request);
//        TeaSession teasession = new TeaSession(request);
        if(h.member == 0)
        {
            outLogin(request,response,h);
            return;
        }
        PrintWriter out = response.getWriter();

        try
        {
            String nu = h.get("nexturl");
            String act = h.get("act");
            if("del".equals(act))
            {
            	int vtid=h.getInt("vtid",0);
                Voltype vt = Voltype.findVoltype(vtid);
                vt.delVtype();
            } else if("edit".equals(act))
            {
            	int vtid=h.getInt("vtid",0);
            	String vtname=h.get("vtname");
            	Voltype vt=new Voltype(vtid,vtname);
            	vt.setVtype();
            }
            response.sendRedirect(nu);
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        } finally
        {

            out.close();
        }
    }

}


