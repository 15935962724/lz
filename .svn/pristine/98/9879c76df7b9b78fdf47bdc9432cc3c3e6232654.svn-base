package tea.statistics;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import tea.db.DbAdapter;
import tea.entity.site.DNS;
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

public class PlatformData  extends HttpServlet {

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        System.out.println("近两年销量情况");
        response.setContentType("text/html");
        response.setCharacterEncoding("utf-8");// 注意設置為utf-8否則前端接收到的中文為亂碼
        PrintWriter out = response.getWriter();
        DbAdapter dbAdapter = new DbAdapter();
        ResultSet resultSet = null;
        Integer year = Integer.valueOf(request.getParameter("year"));
        JSONArray jsonArray = new JSONArray();
        for(int i = year-2; i <= year; i++) {
            Integer years = i;
            String sql = "select A.mon ,ISNULL(B.quantity, 0 ) as quantity from (\n" +
                    "SELECT '"+years+"-01' AS mon UNION\n" +
                    "SELECT '"+years+"-02' AS mon UNION\n" +
                    "SELECT '"+years+"-03' AS mon UNION\n" +
                    "SELECT '"+years+"-04' AS mon UNION\n" +
                    "SELECT '"+years+"-05' AS mon UNION\n" +
                    "SELECT '"+years+"-06' AS mon UNION\n" +
                    "SELECT '"+years+"-07' AS mon UNION\n" +
                    "SELECT '"+years+"-08' AS mon UNION\n" +
                    "SELECT '"+years+"-09' AS mon UNION\n" +
                    "SELECT '"+years+"-10' AS mon UNION\n" +
                    "SELECT '"+years+"-11' AS mon UNION\n" +
                    "SELECT '"+years+"-12' AS mon) A \n" +
                    "left join(\n" +
                    "select CONVERT(varchar(7),O.createdate,120) as years ,sum(OD.quantity) as quantity from shopOrderData OD \n" +
                    "left join shopOrder O on O.order_id = OD.order_id \n" +
                    "where DATENAME(year,O.createdate) = '"+years+"'\n" +
                    "group by CONVERT(varchar(7),O.createdate,120) \n" +
                    ") B on A.mon = B.years order by A.mon";

            try {
                JSONObject jsonObject = new JSONObject();
                List<Integer> data = new ArrayList<Integer>();
                resultSet = dbAdapter.executeQuerySql(sql);
                while (resultSet.next()){
                    data.add(resultSet.getInt("quantity"));
                }
                jsonObject.put("name",years);
                jsonObject.put("data",data);
                jsonArray.add(jsonObject);

            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
        out.write(jsonArray.toJSONString());

    }


    //Process the HTTP Post request 处理http请求
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
       doGet(request,response);
    }


}
