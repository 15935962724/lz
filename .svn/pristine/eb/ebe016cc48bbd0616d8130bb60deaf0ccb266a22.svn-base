package tea.ui.node.type.hostel;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletResponse;
import tea.ui.TeaSession;
import tea.ui.TeaServlet;
import tea.entity.node.HotelMethod;


public class AddDestineInfo extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");

        //创建TeaSession实例
        TeaSession teasession = new TeaSession(request);

        try
        {

               //从JSP取得添加信息所需要的参数
               int node = Integer.parseInt(teasession.getParameter("nodeid"));
               int destine = Integer.parseInt(teasession.getParameter("destine"));
               String hotelName = teasession.getParameter("hotelname");
               String rcreator = teasession.getParameter("rcreator");
               String[] doMethod = request.getParameterValues("domethod");
               String remark = teasession.getParameter("remark");

               //将字符数组遍历出来并转为字符串形式的信息
               StringBuilder sb = new StringBuilder();

               for (int i = 0; i < doMethod.length; i++)
               {
                   if(i < doMethod.length - 1){
                       sb.append(doMethod[i]);
                       sb.append("/");
                   }
                   if (i == doMethod.length - 1)
                   {
                       sb.append(doMethod[i]);
                   }
               }

               //NEW一个DAO对象，并调用其create方法对数据库执行插入操作
               HotelMethod hm = new HotelMethod();

               int isSuccess = hm.create(destine, node, hotelName, rcreator, sb.toString(), remark);

               //如果成功则跳转至sucess.jsp页面，失败则跳转至failed.jsp页面并输出其错误信息
               if(isSuccess == 1){
                   response.sendRedirect("/jsp/registration/addinfosuc.jsp");
               }else {
                   System.out.println("添加失败");
               }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
