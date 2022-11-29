package tea.ui.bpicture;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.bpicture.*;
import tea.entity.node.*;
import java.sql.*;

public class EditMoveLightbox extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");

        TeaSession teasession = new TeaSession(request);

         if(teasession._rv == null)
         {
             response.sendRedirect("/jsp/user/StartLogin.jsp?nexturl=" + request.getRequestURI());
         }
         String email = request.getParameter("email");
         if(email == null)
         {
             email = teasession._rv._strR;
         }
         String act = request.getParameter("act");
		 String pos = request.getParameter("pos");
         try
         {
             Bperson bp = Bperson.find(Bperson.findId(email));
             String lightbox = request.getParameter("lightbox");

             if(lightbox == null)
             {
                 lightbox = bp.getCurrentlightbox();
             }

             int lbidold = BLightbox.findId(email,lightbox);
             BLightbox blb = BLightbox.find(lbidold);

             String picidold = blb.getpicid();

                 String lb = request.getParameter("lbvalue");
                 String[] a = lb.split(",");
                 String lbnew = request.getParameter(a[0]);
                 String picid = a[1];
				 if(act.equals("move")){
                 String canPicid = picidold.replaceAll("," + picid,"");
                 BLightbox.canPic(lightbox,canPicid,email);
                 BLightbox.setLB(email,lbnew,Integer.parseInt(a[1]),lightbox);
                 BLightbox.setPic(lbnew,email,picid);
             }else{
                 int ipic = Integer.parseInt(picid);
                 if(!BLightbox.isExtCaption(email,ipic,lightbox)){
                     BLightbox.createCaption(lbnew,ipic,email,lightbox);
                 }else{

                     BLightbox.upCaption(lbnew,ipic,email,lightbox);
                 }
             }
             response.sendRedirect("/jsp/bpicture/buyer/ViewLightbox.jsp?pos="+pos);
         } catch(IOException ex)
         {
         } catch(SQLException ex)
         {
         }

    }
}



