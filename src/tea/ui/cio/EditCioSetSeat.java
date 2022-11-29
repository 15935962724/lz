package tea.ui.cio;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.text.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.cio.*;
import tea.entity.site.*;
import jxl.*;
import jxl.write.*;

public class EditCioSetSeat extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(),"UTF-8"));
            return;
        }
        String act = teasession.getParameter("act");
        String nu = teasession.getParameter("nexturl");
        try
        {
            int iciop=0, isetRow = 0, isetCol = 0;

                String ciop = request.getParameter("ciopart");
                if(ciop != null&& ciop.length()>0)
                {
                    iciop = Integer.parseInt(ciop);
                }

                String setRow = request.getParameter("seatrow");
                if(setRow != null&&setRow.length()>0)
                {
                    isetRow = Integer.parseInt(setRow);
                }

                String setCol = request.getParameter("seatcol");
                if(setCol!=null && setCol.length()>0)
                {
                    isetCol = Integer.parseInt(setCol);
                }

            if("receipt".equals(act))
            {


                CioSeatSet.createSeat(iciop,isetRow,isetCol);
                response.sendRedirect("/jsp/cio/OkCioCompany2.jsp?type=seat");
                return;
            }

            if("upseat".equals(act))
            {
                CioSeatSet.upProSeat(isetRow,isetCol,iciop);
                response.sendRedirect("/jsp/cio/VIPBdView.jsp?type=seat");
                return;
            }
            if("setseat".equals(act))
            {
                int isr=CioSeatSet.sumRow(),isc=CioSeatSet.sumCol();
                String seatrow = request.getParameter("seatrow");
                if(seatrow!=null&&seatrow.length()>0)
                {
                    isr = Integer.parseInt(seatrow);
                }
                String seatcol = request.getParameter("seatcol");
                if(seatcol!=null&&seatcol.length()>0)
                {
                    isc = Integer.parseInt(seatcol);
                }
                String notseat = CioSeatSet.notSeat();
                String noseat = request.getParameter("noseat");
                if(noseat!=null&&noseat.length()>1)
                {
                    notseat= noseat;
                }
                if(isr<CioSeatSet.sumRow() || isc <CioSeatSet.sumCol())
                {
                    notseat="/";
                }
                CioSeatSet.updateSeat(isr,isc,notseat);
            }

        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect(nu);
    }
}
