package tea.ui.yl;

import org.json.JSONObject;
import tea.entity.Http;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Test extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act");
        PrintWriter out = response.getWriter();
        JSONObject jo = new JSONObject();
        //用于存放输出的信息
        String message = "操作执行成功！";
        try {
            //疏通测试
            if ("test".equals(act)) {
                String s = h.get("message");
                if (s == null || "".equals(s)) {
                    jo.put("status", "fail");//返回失败
                    jo.put("fail", "参数不能为空！");
                    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
                    String format = sf.format(new Date());
                    jo.put("OCC_TIME", format);//接口响应时间
                    return;
                } else {
                    jo.put("status", "success");//返回成功
                    jo.put("fail", "");
                    jo.put("requestMessage", s);
                    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
                    String format = sf.format(new Date());
                    jo.put("OCC_TIME", format);//接口响应时间
                    return;
                }

            } else {
                jo.put("status", "fail");//返回失败
                jo.put("fail", "参数不能为空！");
                SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
                String format = sf.format(new Date());
                jo.put("OCC_TIME", format);//接口响应时间
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            jo.put("status", "fail");
            jo.put("fail", "系统异常");
            SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
            String format = sf.format(new Date());
            jo.put("OCC_TIME", format);//接口响应时间
        } finally {
            out.print(jo);
        }


    }
}