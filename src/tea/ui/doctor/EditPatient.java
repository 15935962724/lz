package tea.ui.doctor;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.member.*;
import java.sql.SQLException;


public class EditPatient extends HttpServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        ServletContext application = getServletContext();
        Http h = new Http(request);
        String act = h.get("act");
        PrintWriter out = response.getWriter();
        try
        {
            if("exists".equals(act))
            {
                String name = h.get("name");
                String card = h.get("card");
                Enumeration e = Profile.find(" AND card=" + DbAdapter.cite(card),0,100);
                if(e.hasMoreElements())
                {
                    response.sendRedirect("/jsp/doctor/AddPatient.jsp?community=" + h.community + "&exists=1");
                } else
                {
                    response.sendRedirect("/jsp/doctor/EditPatient.jsp?community=" + h.community + "&name=" + h.enc(name) + "&card=" + h.enc(card));
                }
            } else
            if("profile".equals(act))
            {
                String member = h.get("member");
                String password = h.get("password");
                String email = h.get("email");
                if(Profile.isExisted(member))
                {
                    out.print("<script>parent.mt.show('“" + member + "”用户名已存在!');</script>");
                    return;
                } else
                {
                    Profile.create(member,password,h.community,email,request.getServerName());
                }
                Profile p = Profile.find(member);
                String name = h.get("name");
                boolean sex = h.getBool("sex");
                int cardtype = h.getInt("cardtype");
                String card = h.get("card");
                Date birth = h.getDate("birth");
                String state = h.get("state");
                String city = h.get("city");
                String job = h.get("job");
                String degree = h.get("degree");
                String address = h.get("address");
                String zip = h.get("zip");
                String telephone = h.get("telephone");
                String paddress = h.get("paddress");
                String pzip = h.get("pzip");
                String ptelephone = h.get("ptelephone");
                String mobile = h.get("mobile");
                p.setFirstName(name,h.language);
                p.setSex(sex);
                p.setCardType(cardtype);
                p.setCard(card);
                p.setBirth(birth);
                p.setState(state,h.language);
                p.setCity(city,h.language);
                p.setJob(job,h.language);
                p.setDegree(degree,h.language);
                p.setAddress(address,h.language);
                p.setZip(zip,h.language);
                p.setTelephone(telephone,h.language);
                p.setPAddress(paddress,h.language);
                p.setPZip(pzip,h.language);
                p.setPTelephone(ptelephone,h.language);
                p.setMobile(mobile);
            }
        } catch(SQLException ex)
        {
            ex.printStackTrace();
			response.sendError(500,ex.toString());
        } finally
        {
            out.flush(); //这是不能close();
        }
    }


}
