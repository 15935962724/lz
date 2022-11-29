package tea.ui.weixin;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import org.json.*;
import tea.entity.weixin.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.cluster.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.xssf.usermodel.*;
import org.apache.poi.poifs.filesystem.*;

public class WxCoupons extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        PrintWriter out = response.getWriter();
        try
        {
            String info = "操作执行成功！";
            out.println("<script>var mt=parent.mt;</script>");
            if("steering".equals(act)) //邮政:投票
            {
                String openid = h.getCook("openid",null);
                if(openid == null)
                    return;
                synchronized(WxCoupon.class)
                {
                    WxUser wu = WxUser.find(openid);
                    int sum = WxCoupon.count(" AND wxuser=" + wu.wxuser);
                    if(sum > 1)
                    {
                        info = "抱歉，优惠券每人最多领取2个！";
                    } else if(WxCoupon.count(" AND wxuser=" + wu.wxuser + " AND node=" + h.node) > 0)
                    {
                        info = "抱歉，此优惠券您已领过了！";
                    } else
                    {
                        String sql = " AND wxuser=0";
                        int no = Cluster.getInstance().no;
                        if(no > 0)
                            sql += " AND " + DbAdapter.mod("wxcoupon","2") + (no == 3 ? "=" : "!=") + "0";
                        Filex.logs("WxCoupons.txt",sql);
                        ArrayList al = WxCoupon.find(sql,0,1); //dbms_random.value()
                        WxCoupon wc = al.size() < 1 ? new WxCoupon(0) : (WxCoupon) al.get(0);
                        if(wc.wxcoupon < 1)
                        {
                            info = "抱歉，优惠券已领完！";
                        } else
                        {
                            wc.wxuser = wu.wxuser;
                            wc.node = h.node;
                            wc.starttime = new Date();
                            wc.set();
                            info = "恭喜您获得" + wc.money + "元直减红包，序列号为" + wc.code + "，请点击http://t.cn/RZrfjxs，注册登录后领取使用。路径如下：注册登录—个人中心—我的优惠券—添加优惠券—输入序列号后即可使用，祝您购酒愉快。";
                            JSONObject jo = wu.send("text",info);
                            if(jo.getInt("errcode") == 0)
                                info = "领取成功，已下发到您的微信！";
                        }
                    }
                }
                out.print("<script>mt.show('" + info + "',1,\"window.WeixinJSBridge.call('closeWindow')\");</script>");
                return;
            }
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            if("imp".equals(act)) //导入
            {
                info = imp(h.get("file"),out);
            } else if("clear".equals(act)) //清空
            {
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeUpdate(0,"TRUNCATE TABLE wxcoupon");
                } finally
                {
                    db.close();
                }
//update wxuser set nodes='|';
//update node set hot=0;
//update WxCoupon set STARTTIME=null,NODE=0,WXUSER=0;

            } else
            {
                int rule = h.getInt("rule");
                WxCoupon t = WxCoupon.find(rule);
                if("del".equals(act)) //删除
                {
                    t.delete();
                } else if("edit".equals(act)) //编辑
                {
                }
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id=ta>" + Err.get(h,ex) + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    public static String imp(String file,PrintWriter out) throws SQLException
    {
        Workbook wbs;
        try
        {
            FileInputStream is = new FileInputStream(Http.REAL_PATH + file);
            try
            {
                wbs = new HSSFWorkbook(is); //xls
            } catch(OfficeXmlFileException ex)
            {
                is.close();
                is = new FileInputStream(Http.REAL_PATH + file);
                wbs = new XSSFWorkbook(is); //xlsx
            }
            is.close();
        } catch(Throwable ex)
        {
            ex.printStackTrace();
            return "上传的文件格式不正确！";
        }
        int x = 0;
        Sheet s = wbs.getSheetAt(0);
        for(int i = 1;i <= s.getLastRowNum();i++)
        {
            Row r = s.getRow(i);
            if(r == null)
                continue;
            if(i % 100 == 0)
            {
                out.write("<script>mt.progress(" + i + "," + s.getLastRowNum() + ");</script>");
                out.flush();
            }
            int j = 0;
            WxCoupon wc = new WxCoupon(0);
            wc.code = r.getCell(j++).toString();
            if(WxCoupon.count(" AND code=" + DbAdapter.cite(wc.code)) > 0)
                continue;
            wc.money = Float.parseFloat(r.getCell(j++).toString());
            wc.type = r.getCell(j++).toString();
            String str = r.getCell(j++).toString();
            System.out.println(i + "、" + str);
            wc.stoptime = MT.d(str);
            wc.set();
            x++;
        }
        return "成功导入：" + x + "条！";
    }
}
