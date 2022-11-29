package tea.ui.member.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.ui.TeaServlet;

public class EditCode extends TeaServlet
{
    private static final String CONTENT_TYPE = "text/html; charset=UTF-8";

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/general/EditNode").add("/tea/ui/node/type/sms/EditUser");
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String community = request.getParameter("community");
            if (community == null)
            {
                tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
                community = node.getCommunity();
            }
            /*
                         if (!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(community))
                         {
                response.sendError(403);
                return;
                         }*/
            if (request.getParameter("export") != null)
            {
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + "Export.xls");

                jxl.write.WritableWorkbook ww = jxl.Workbook.createWorkbook(response.getOutputStream());
                jxl.write.WritableSheet ws = ww.createSheet("Sheet1", 0);
                ws.addCell(new jxl.write.Label(0, 0, "卡号"));
                ws.addCell(new jxl.write.Label(1, 0, "密码"));
                ws.addCell(new jxl.write.Label(2, 0, "面值"));
                int i = 1;
                java.util.Date time = new java.util.Date(Long.parseLong(request.getParameter("time")));
                for (java.util.Enumeration enumer = Code.find(community, time, 0, Integer.MAX_VALUE); enumer.hasMoreElements(); i++)
                {
                    Code obj = (Code) enumer.nextElement();

                    ws.addCell(new jxl.write.Label(0, i, obj.getSymbol() + obj.getCode()));
                    ws.addCell(new jxl.write.Label(1, i, obj.getPassword()));
                    ws.addCell(new jxl.write.Label(2, i, String.valueOf(obj.getParvalue())));
                }
                ww.write();
                ww.close();
            } else
            if (request.getParameter("code") != null)
            {
                String validate = request.getParameter("validate").trim();
                javax.servlet.http.HttpSession session = request.getSession(true);
                if (validate.equals(session.getAttribute("sms.vertify")))
                {
                    String code = request.getParameter("code").trim();
                    char ch = code.charAt(0);
                    String password = request.getParameter("password").trim();
                    Code obj = Code.find(code.substring(1));
                    if (obj.isExists() && obj.isFull())
                    {
                        outText(teasession, response, "该卡已被充过");
                        return;
                    } else
                    if (obj.isExists() && ch == obj.getSymbol() && password.equalsIgnoreCase(obj.getPassword()))
                    {
                        obj.set(teasession._rv._strV);
                        SClient sc = SClient.find(community, teasession._rv._strV);
                        sc.setPrice(obj.getParvalue());
//                        ProfileMoney pm = ProfileMoney.find(community, teasession._rv._strV);
//                        pm.set(obj.getParvalue());
                        response.sendRedirect("/jsp/info/Succeed.jsp?community=" + community + "&info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "SuccessMoney") + obj.getParvalue(), "UTF-8"));
                        return;
                    } else
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?community=" + community + "&info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "CodeOrPassError"), "UTF-8"));
                        return;
                    }
                } else
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?community=" + community + "&info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "ConfirmCodeError"), "UTF-8"));
                    return;
                }
            } else
            {
                java.math.BigDecimal parvalue = new java.math.BigDecimal(request.getParameter("parvalue"));
                Code.create(parvalue, Integer.parseInt(request.getParameter("quantity")), community);
            }
            response.sendRedirect("/jsp/profile/EditCode.jsp?community=" + community);
        } catch (Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500, ex.getMessage());
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
