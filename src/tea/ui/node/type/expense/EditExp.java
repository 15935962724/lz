package tea.ui.node.type.expense;

import tea.ui.*;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import java.sql.SQLException;

public class EditExp extends TeaServlet
{
   public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        Expenserecord exp=new Expenserecord();
        TeaSession teasession = new TeaSession(request);//teasession：系统封装的session
        String flag=teasession.getParameter("opt");
        String destine=teasession.getParameter("destine");
        if(flag!=null){
            if (flag.equals("audit"))//修改审核标志操作
            {
                String audit = teasession.getParameter("yn");
                exp.sqlExe("update expenserecord set audit=" + audit+"where destine="+destine);
                response.sendRedirect("/jsp/type/expenserecord/audit.jsp");
            }
            if(flag.equals("exp")){//执行增加修改操作
                int date;
                exp.setDestine(Integer.parseInt(teasession.getParameter("destine")));
                exp.setKipdate(teasession.getParameter("kipDateFlag"));
                exp.setLeavedate(teasession.getParameter("leaveDateFlag"));
                exp.setRoomcount(Integer.parseInt(teasession.getParameter("roomcount")));
                exp.setRoomprice(Integer.parseInt(teasession.getParameter("roomtype")));
                exp.setMoney(Float.parseFloat(teasession.getParameter("money")));

                if(teasession.getParameter("audit")==null){
                   date=0;
                }else{
                    date=Integer.parseInt(teasession.getParameter("audit"));

                }
                exp.setAudit(date);
                try
                {
                    exp.set();
                    response.sendRedirect("/jsp/type/expenserecord/explist.jsp");
                } catch (SQLException se)
                {
                    se.printStackTrace();
                }
            }
        }
   }
}
