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
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ResultSetUtil {


    public static List<Map<String, Object>> selectAll(ResultSet rs) {
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        try {
            // 获取结果集结构（元素据）
            ResultSetMetaData rmd = rs.getMetaData();
            // 获取字段数（即每条记录有多少个字段）
            int columnCount = rmd.getColumnCount();
            while (rs.next()) {
                // 保存记录中的每个<字段名-字段值>
                Map<String, Object> rowData = new HashMap<String, Object>();
                for (int i = 1; i <= columnCount; ++i) {
                    // <字段名-字段值>
                    rowData.put(rmd.getColumnName(i), rs.getObject(i));
                }
                // 获取到了一条记录，放入list
                list.add(rowData);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }


}
