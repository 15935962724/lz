package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.ui.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.node.*;
import jxl.write.*;

public class NFasts extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        Http h = new Http(request);
        String act = h.get("act","");
        OutputStream out = response.getOutputStream();
        try
        {
            if("child".equals(act))
            {
                Enumeration ef = Node.find(" AND father=" + h.node + " ORDER BY node DESC",0,1);
                if(ef.hasMoreElements())
                    h.node = ((Integer) ef.nextElement()).intValue();
                response.sendRedirect("/html/node/" + h.node + "-" + h.language + ".htm");
                return;
            } else if("verify".equals(act))
            {
                int verify = h.getInt("verify",Community.find(h.community).verify);
                if(verify == 3)
                {
                    HttpSession session = request.getSession(true);
                    String rand = Img.verify(out,20);
                    session.setAttribute("sms.vertify",rand);
                } else
                {
                    String[] arr =
                            {"/tea/mt/blank.gif","/jsp/user/validate.jsp","/jsp/user/addValidate.jsp",""};
                    response.sendRedirect(arr[verify]);
                }
                return;
            }
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if("opiniondel".equals(act))
            {
                Node.find(h.getInt("node")).delete(h.language);
            } else if("opinionedit".equals(act))
            {
                int father = h.getInt("father");
                int node = h.getInt("node");
                int red = h.getInt("red");
                int blue = h.getInt("blue");

                if(node < 1)
                {
                    Date time = new Date();
                    Node f = Node.find(father);
                    node = Node.create(f._nNode,0,f.getCommunity(),teasession._rv,0,false,f.getOptions(),f.getOptions1(),f.getDefaultLanguage(),null,null,time,0,0,0,0,0,null);
                    red = Node.create(node,0,f.getCommunity(),teasession._rv,1,false,f.getOptions(),f.getOptions1(),f.getDefaultLanguage(),null,null,time,0,0,0,0,0,null);
                    blue = Node.create(node,0,f.getCommunity(),teasession._rv,1,false,f.getOptions(),f.getOptions1(),f.getDefaultLanguage(),null,null,time,0,0,0,0,0,null);
                    f.finished(node);
                    f.finished(red);
                    f.finished(blue);
                }
                Node.find(node).set(h.language,h.get("subject"),h.get("content"));
                Node.find(red).set(h.language,h.get("subject0"),h.get("content0"));
                Node.find(blue).set(h.language,h.get("subject1"),h.get("content1"));
                //nexturl="/jsp/admin/nfast/Opinions.jsp";
            }
            out.write(("<script>parent.mt.show('操作成功！',1,'" + h.get("nexturl","") + "');</script>").getBytes("utf-8"));
        } catch(Exception ex)
        {
  		    ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

}
