package tea.statistics;

import com.alibaba.fastjson.JSON;
import tea.db.DbAdapter;

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

public class HospitalDetails extends HttpServlet {

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        System.out.println("");
        response.setContentType("text/html");
        response.setCharacterEncoding("utf-8");// 注意設置為utf-8否則前端接收到的中文為亂碼
        PrintWriter out = response.getWriter();
        DbAdapter dbAdapter = new DbAdapter();
        ResultSet resultSet = null;
        Integer thisYear = Integer.valueOf(request.getParameter("year"));
        System.out.println(thisYear+"年医院销量排行");
        String  sql = "select top 10 SOD.a_hospital,sum(OD.quantity) quantity from shopOrderData OD left join shopOrder O on OD.order_id = O.order_id\n" +
                "left join shopOrderDispatch SOD on O.order_id = SOD.order_id  where  DATENAME(year,O.createdate) = '"+thisYear+"' group by SOD.a_hospital order by quantity desc";

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
