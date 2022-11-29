package tea.statistics;

import com.alibaba.fastjson.JSON;
import tea.db.DbAdapter;
import util.Config;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderQuantityBillingQuantity extends HttpServlet {

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {

        response.setContentType("text/html");
        response.setCharacterEncoding("utf-8");// 注意設置為utf-8否則前端接收到的中文為亂碼
        PrintWriter out = response.getWriter();
        DbAdapter dbAdapter = new DbAdapter();
        ResultSet resultSet = null;
        Integer thisYear = Integer.valueOf(request.getParameter("year"));
        String puid = request.getParameter("puid");
        String sqlPuid = "";
        if (puid!=null && puid != ""){
            sqlPuid = "and puid = '"+Config.getString(puid)+"'";
        }
        System.out.println(thisYear+"年销量和开票数量同比");
        String sql = "select A.mon ,ISNULL(B.quantity, 0 ) as quantity,ISNULL(C.num,0)as num from (\n" +
                "SELECT '"+thisYear+"-01' AS mon UNION\n" +
                "SELECT '"+thisYear+"-02' AS mon UNION\n" +
                "SELECT '"+thisYear+"-03' AS mon UNION\n" +
                "SELECT '"+thisYear+"-04' AS mon UNION\n" +
                "SELECT '"+thisYear+"-05' AS mon UNION\n" +
                "SELECT '"+thisYear+"-06' AS mon UNION\n" +
                "SELECT '"+thisYear+"-07' AS mon UNION\n" +
                "SELECT '"+thisYear+"-08' AS mon UNION\n" +
                "SELECT '"+thisYear+"-09' AS mon UNION\n" +
                "SELECT '"+thisYear+"-10' AS mon UNION\n" +
                "SELECT '"+thisYear+"-11' AS mon UNION\n" +
                "SELECT '"+thisYear+"-12' AS mon) A left join (\n" +
                "select CONVERT(varchar(7),O.createdate,120) as years ,sum(OD.quantity) as quantity from shopOrderData OD left join shopOrder O on OD.order_id = O.order_id \n" +
                "where O.status = 4 and DATENAME(year,O.createdate) = '"+thisYear+"' "+sqlPuid+" group by CONVERT(varchar(7),O.createdate,120) \n" +
                ") B on A.mon = B.years left join (\n" +
                "select CONVERT(varchar(7),makeoutdate,120) as makeoutDate ,sum(num) num from invoice where status = 2 "+sqlPuid+" and DATENAME(year,makeoutdate) = '"+thisYear+"' group by CONVERT(varchar(7),makeoutdate,120) \n" +
                ") C on A.mon = C.makeoutDate order by A.mon";
        List list = new ArrayList();
        try {
                resultSet =  dbAdapter.executeQuerySql(sql);
                list = ResultSetUtil.selectAll(resultSet);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        System.out.println(JSON.toJSONString(list));
        out.write(JSON.toJSONString(list));

    }


    //Process the HTTP Post request 处理http请求
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
       doGet(request,response);
    }


}
