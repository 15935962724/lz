package tea.ui.node.access;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.*;
import tea.entity.node.Node;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class PayAccess1 extends TeaServlet
{

    public PayAccess1()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        TeaSession teasession;
        try
        {
            teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            int i;
            BigDecimal bigdecimal;
            int j;
            int k;
            String s;
            int l;
            BigDecimal bigdecimal1;
            i = Integer.parseInt(request.getParameter("Currency"));
            bigdecimal = new BigDecimal(request.getParameter("Price"));
            j = Integer.parseInt(request.getParameter("Shipping"));
            k = Shipping.PAYMETHOD_OFFLINE;
            s = null;
            if (j != 0)
            {
                Shipping shipping = Shipping.find(j);
                k = shipping.getPayMethod();
                s = shipping.getParameters();
            }
            l = Integer.parseInt(teasession.getParameter("Coupon"));
            Coupon.find(l);
            bigdecimal1 = null;
            try
            {
                bigdecimal1 = new BigDecimal(teasession.getParameter("Discount"));
            } catch (Exception _ex)
            {}
            if (bigdecimal1 == null)
            {
                outText(response, teasession._nLanguage, super.r.getString(teasession._nLanguage, "InvalidDiscount"));
                return;
            }
            String s1;
            String s2;
            String s3;
            String s4;
            String s5;
            String s6;
            String s7;
            String s8;
            String s9;
            String s10;
            String s11;
            boolean flag;
            s1 = null;
            s2 = null;
            s3 = null;
            s4 = null;
            s5 = null;
            s6 = null;
            s7 = null;
            s8 = null;
            s9 = null;
            s10 = null;
            s11 = null;
            flag = false;
            if (i != 0 || k != Shipping.PAYMETHOD_ITRANSACT)
            {
                //break MISSING_BLOCK_LABEL_348;
            }
            String s12 = request.getParameter("signature");
            if (s12 == null || !s12.startsWith("-----BEGIN PGP SIGNED MESSAGE-----"))
            {
                return;
            }
            flag = true;
            s1 = request.getParameter("email");
            s2 = request.getParameter("first_name");
            s3 = request.getParameter("last_name");
            s4 = "";
            s5 = request.getParameter("address");
            s6 = request.getParameter("city");
            s7 = request.getParameter("state");
            s8 = request.getParameter("zip");
            s9 = request.getParameter("country");
            s10 = request.getParameter("phone");
            s11 = "";
            //break MISSING_BLOCK_LABEL_458;
            s1 = request.getParameter("bEmail");
            s2 = request.getParameter("bFirstName");
            s3 = request.getParameter("bLastName");
            s4 = request.getParameter("bOrganization");
            s5 = request.getParameter("bAddress");
            s6 = request.getParameter("bCity");
            s7 = request.getParameter("bState");
            s8 = request.getParameter("bZip");
            s9 = request.getParameter("bCountry");
            s10 = request.getParameter("bTelephone");
            s11 = request.getParameter("bFax");
            java.io.PrintWriter printwriter = response.getWriter();
            Node node = Node.find(teasession._nNode);
            tea.entity.RV rv = node.getCreator();
            int i1 = 0;//Trade.createByAccess(rv, teasession._rv, teasession._nNode, bigdecimal, flag, teasession._nLanguage, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, i, j, l, bigdecimal1, teasession._nLanguage, null, null);
            if (i1 != 0)
            {
                response.sendRedirect("/jsp/access/PayAccess1.jsp?node=" + teasession._nNode + "&Trade=" + i1 + "&Currency=" + i + "&Shipping=" + k + "&Parameters=" + s);
            }
            printwriter.close();
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/access/PayAccess1");
    }
}
