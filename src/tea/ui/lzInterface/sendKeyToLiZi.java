package tea.ui.lzInterface;

import com.alibaba.fastjson.JSON;
import org.json.JSONObject;
import tea.entity.Database;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.yl.shop.ShopHospital;
import tea.entity.yl.shop.TpsOrder;
import util.DateUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Date;

public class sendKeyToLiZi extends HttpServlet {
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        InputStreamReader insr = new InputStreamReader(request.getInputStream(),"utf-8");
        String result = "";
        int respInt = insr.read();
        while(respInt!=-1) {
            result +=(char)respInt;
            respInt = insr.read();
        }
        com.alibaba.fastjson.JSONObject jsonObject = JSON.parseObject(result);
        PrintWriter out = response.getWriter();
        JSONObject jo = new JSONObject();
        int orderItemId = jsonObject.getInteger("orderItemId");//tpsOrder 订单id
        String code = jsonObject.getString("code");//激活码
        try {

            if (orderItemId > 0) {//订单id不为空

                if (!"".equals(code)) {//激活码不是空

                    int count = TpsOrder.count(" AND id=" + orderItemId);
                    if (count == 0) {

                        jo.put("status", "400");
                        jo.put("message", "orderItemId"+orderItemId+",已阻断！");

                    } else {

                        count = TpsOrder.count(" AND id=" + orderItemId + " AND jhm is not null ");
                        if(count>0){

                            jo.put("status", "400");
                            jo.put("message", "orderItemId"+orderItemId+",已阻断！");
                        }else {

                            OutputFile.creatTxtFile("nodelete/tpsid/", orderItemId + "");
                            OutputFile.writeTxtFile("nodelete/tpsid/" + orderItemId + ".txt", code);

                            TpsOrder tpsOrder = TpsOrder.find(orderItemId);
                            tpsOrder.setJhm(code);
                            tpsOrder.set();
                            //推送给客户激活码
                            Boolean aBoolean = TpsOrder.sendMailToHospital(orderItemId);


                            if(!aBoolean){//没推送成功，删除txt  返回错误

                                jo.put("status", "400");
                                jo.put("message", "orderItemId"+orderItemId+",已阻断！");
                                tpsOrder.setJhm(null);
                                tpsOrder.set();
                                File file = new File("nodelete/tpsid/" + orderItemId + ".txt");
                                // 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
                                if (file.exists() && file.isFile()) {
                                    if (file.delete()) {
                                        Filex.logs("nodelete/log/"+ MT.f(new Date())+".txt",String.valueOf(orderItemId)+"--- 删除文件");
                                    } else {
                                        Filex.logs("nodelete/log/"+ MT.f(new Date())+".txt",String.valueOf(orderItemId)+"--- 删除文件失败");
                                    }
                                } else {
                                    Filex.logs("nodelete/log/"+ MT.f(new Date())+".txt",String.valueOf(orderItemId)+"--- 文件不存在 ");
                                }
                            }else {
                                jo.put("msg","操作成功");
                                jo.put("status","200");
                            }

                        }


                    }

                } else {
                    jo.put("status", "400");
                    jo.put("message", "orderItemId"+orderItemId+",已阻断！");
                }

            } else {
                jo.put("status", "400");
                jo.put("message", "orderItemId"+orderItemId+",已阻断！");
            }

        } catch (Exception e) {
            e.printStackTrace();
            jo.put("status", "400");
            jo.put("message", "orderItemId"+orderItemId+",已阻断！");
        } finally {
            String backTime = DateUtil.getStringFromDate(new Date(), "yyyy-MM-dd HH:mm:ss");
            //jo.put("occTime", backTime);//接口响应时间
            Filex.logs("log_interface/hospital/hospital_" + MT.f(new Date()) + ".log", "响应报文：" + jo.toString());
            out.print(jo);
        }
    }
}
