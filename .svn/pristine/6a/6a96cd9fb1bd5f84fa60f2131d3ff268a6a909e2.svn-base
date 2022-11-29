package tea.ui.citybcst;

import tea.ui.TeaServlet;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.text.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.citybcst.*;
import java.sql.*;


public class EditCityBcst extends TeaServlet
{
    public void init() throws ServletException
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        tea.ui.TeaSession teasession = null;
        teasession = new tea.ui.TeaSession(request);
        ServletContext application = getServletContext();
        String act = teasession.getParameter("act");

        try
        {
            if(act.equals("EditCitybroadcast"))
            {
                String firstname = teasession.getParameter("firstname");
                String sexs = teasession.getParameter("sex");
                int sex = 0;
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex"));
                }
                String age = teasession.getParameter("age");
                String card = teasession.getParameter("card");
                int city = 0;
                if(teasession.getParameter("city") != null && teasession.getParameter("city").length() > 0)
                {
                    city = Integer.parseInt(teasession.getParameter("city"));
                }
                int street = 0;
                if(teasession.getParameter("street") != null && teasession.getParameter("street").length() > 0)
                {
                    street = Integer.parseInt(teasession.getParameter("street"));
                }
                int community = 0;
                if(teasession.getParameter("community2") != null && teasession.getParameter("community2").length() > 0)
                {
                    community = Integer.parseInt(teasession.getParameter("community2"));
                }
                String addr = teasession.getParameter("addr");
                String zip = teasession.getParameter("zip");
                String telephone = teasession.getParameter("telephone");
                String zhiye = teasession.getParameter("zhiye");
                String email = teasession.getParameter("email");
                String intro = teasession.getParameter("intro");
                String other = teasession.getParameter("other");
                String other2 = teasession.getParameter("other2");
                String other3 = teasession.getParameter("other3");
                int id = 0;
                if(teasession.getParameter("ids") != null && teasession.getParameter("ids").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("ids"));
                }

                if(id != 0)
                {
                    CityBcst.set(id,firstname,sex,age,card,city,street,community,addr,zip,zhiye,telephone,email,intro,other,other2,other3);
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("修改成功!","UTF-8") + "&nexturl=/jsp/citybroadcast/Citybcst.jsp");
                    return;
                } else
                {
                    CityBcst.set(id,firstname,sex,age,card,city,street,community,addr,zip,zhiye,telephone,email,intro,other,other2,other3);
                    response.sendRedirect("/jsp/citybroadcast/CitybcstOver.jsp");
                    return;
                }
            }
        } catch(SQLException ex)
        {
        } catch(NumberFormatException ex)
        {
        }
    }

    public EditCityBcst()
    {
    }

    public void destroy()
    {
    }

}
