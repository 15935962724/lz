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

public class InvoicedGrew extends HttpServlet {

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
        System.out.println(year+"年开票数量占比");
        JSONObject jsonObject = new JSONObject();
        ResultSet resultSet = null;
        try {

            String sql = "select PU.name ,sum(I.num) as num from invoice I left join ProcurementUnit PU on I.puid = PU.puid where I.status = 2 and  DATENAME(year,I.makeoutdate) = '"+year+"' group by PU.name\n";
            resultSet = dbAdapter.executeQuerySql(sql);

            List<Integer> nums = new ArrayList<Integer>();
            List<String> names = new ArrayList<String>();
            while (resultSet.next()){
                nums.add(resultSet.getInt("num"));
                names.add(resultSet.getString("name"));
//
            }
            jsonObject.put("nums",nums);
            jsonObject.put("names",names);

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
