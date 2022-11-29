package tea.statistics;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
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

public class SalesRanking extends HttpServlet {

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

        Integer year = Integer.valueOf(request.getParameter("year"));
        System.out.println(year+"年销量排行");
       JSONObject jsonObject = new JSONObject();

            String sql = "select top 10 A.member ,B.quantity from Profile A left join " +
                    "(select P.umember, sum(OD.quantity) as quantity from shopOrderData OD " +
                    "left join shopOrder O on OD.order_id = O.order_id " +
                    "left join Profile P on O.member = P.profile where  DATENAME(year,O.createdate) = '"+year+"' GROUP BY P.umember ) " +
                    "B on A.profile = B.umember order by quantity desc";
        try {
            ResultSet resultSet =  dbAdapter.executeQuerySql(sql);
            List<String> members = new ArrayList<String>();
            List<Integer> quantity = new ArrayList<Integer>();
            while (resultSet.next()){
                members.add(resultSet.getString("member"));
                quantity.add(resultSet.getInt("quantity"));
            }
            jsonObject.put("members",members);
            jsonObject.put("quantity",quantity);
            jsonObject.put("title",year+"年销量排行");

        } catch (SQLException e) {
            e.printStackTrace();
        }
        out.write(jsonObject.toString());

    }


    //Process the HTTP Post request 处理http请求
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
       doGet(request,response);
    }


}
