package tea.ui.node.type.score;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.entity.*;
import tea.db.*;
import tea.ui.*;
import java.sql.SQLException;
import java.sql.SQLException;

public class EditScore extends TeaServlet // HttpServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        HttpSession session = request.getSession(true);
        Http h = new Http(request);
        String act = h.get("act");
        if("img".equals(act)) //走势图
        {
            try
            {
                String str = Score.draw(teasession._rv.toString(),Entity.sdf.parse(request.getParameter("start")),Entity.sdf.parse(request.getParameter("end")),response.getOutputStream());
                session.setAttribute("score.map",str);
            } catch(Exception ex)
            {
                ex.printStackTrace();
            }
            return;
        }
        //
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            if("map".equals(act))
            {
                String map = (String) session.getAttribute("score.map");
                session.removeAttribute("score.map");
                out.print(map);
                return;
            }
            int _nScore = Integer.parseInt(teasession.getParameter("score"));
            String nexturl = request.getParameter("nexturl");
            if(request.getRequestURI().endsWith("DeleteScore"))
            {
                Score.delete(_nScore);
                if(nexturl != null && nexturl.length() > 0)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    response.sendRedirect("/jsp/type/score/ScoreManage.jsp?node=" + teasession._nNode);
                }
                return;
            }
            //
            int golf = Integer.parseInt(teasession.getParameter("golf"));
            String member = teasession.getParameter("member");
            String name = teasession.getParameter("name"); // 球场
            int tee = Integer.parseInt(teasession.getParameter("tee")); // 发球台
            boolean compete = (teasession.getParameter("compete") != null); // 是否是比赛
            int sums = (Integer.parseInt(teasession.getParameter("sums"))); // 总杆数
            int cavity = (Integer.parseInt(teasession.getParameter("cavity"))); // 洞数
            String tmp = teasession.getParameter("times");
            if(tmp!=null&&tmp.length()>0){}else
            {
                tmp = teasession.getParameter("timesYear") + "-" + teasession.getParameter("timesMonth") + "-" + teasession.getParameter("timesDay") + " " + teasession.getParameter("timesHour") + ":" + teasession.getParameter("timesMinute");
            }
            Date times = (tmp.length() < 11 ? Entity.sdf : Entity.sdf2).parse(tmp); // 打球日期
            String caddy = teasession.getParameter("caddy");
            String text = (teasession.getParameter("text"));
            int[] fact = new int[18],up = new int[18],bunt = new int[18];
            boolean[] fairway = new boolean[18];
            //if(teasession.getParameter("particular") == null) //输入详细实际杆
            {
                fact = Arrayx.parseInt(request.getParameterValues("fact"));
                //if(request.getParameter("particular_checkbox") != null)
                {
                    for(int i = 0;i < 18;i++)
                    {
                        fairway[i] = request.getParameter("fairway" + i) != null;
                    }
                    up = Arrayx.parseInt(request.getParameterValues("up"));
                    bunt = Arrayx.parseInt(request.getParameterValues("bunt"));
                }
            }
            String fieldid = teasession.getParameter("fieldid");
            String fieldid2 = teasession.getParameter("fieldid2");
            boolean[] hfinish = new boolean[18];////本杆是否完成


            Score.set(_nScore,member,golf,name,tee,compete,sums,cavity,fact,fairway,up,bunt,times,caddy,text,null,Golf.find(golf,teasession._nLanguage).posid, fieldid, fieldid2, hfinish);

            if(nexturl != null)
            {
                response.sendRedirect(nexturl);
            } else
            {
                out.println(new tea.html.Script("alert('成绩提交成功!');window.open('/jsp/type/score/EditScore.jsp?node=" + teasession._nNode + "','_self')"));
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
