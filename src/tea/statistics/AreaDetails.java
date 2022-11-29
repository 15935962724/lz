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

public class AreaDetails extends HttpServlet {

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
        System.out.println(thisYear+"年全国销量详情");
        String  sql = "select A.name,sum( OD.quantity) as quantity\n" +
                "from shopOrderData OD left join shopOrder O on OD.order_id  = O.order_id left join ShopOrderDispatch SOD on O.order_id = SOD.order_id\n" +
                "left join shopHospital H on SOD.a_hospital_id = H.id Left join Areas A on H.area = A.id\n" +
                "where  DATENAME(year,O.createdate) = '"+thisYear+"' group by A.name ";

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
