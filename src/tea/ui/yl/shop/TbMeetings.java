package tea.ui.yl.shop;

import org.json.JSONObject;
import tea.db.DbAdapter;
import tea.entity.Attch;
import tea.entity.Http;
import tea.entity.yl.shop.TbMeeting;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * 用户申请升级
 */
public class TbMeetings extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        JSONObject jo = new JSONObject();
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = resp.getWriter();
        if ("add_meeting".equals(act)) {//编辑会议
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";
            int meet_id = h.getInt("meet_id");

            String name = h.get("meet_name");
            String inform = h.get("inform");
            String zhaoshang = h.get("zhaoshang");
            String apply = h.get("apply");
            if (name == null || inform == null || zhaoshang == null || apply == null) {
                out.print("<script>mt.show('提交信息不完整,请重试！');</script>");
                return;
            } else {
                try {
                    ArrayList arrayList = Attch.find("AND path=" + DbAdapter.cite(inform), 0, 1);
                    Attch a = (Attch) arrayList.get(0);
                    int meet_informa = a.attch;
                    arrayList = Attch.find("AND path=" + DbAdapter.cite(zhaoshang), 0, 1);
                    a = (Attch) arrayList.get(0);
                    int meet_zs = a.attch;
                    arrayList = Attch.find("AND path=" + DbAdapter.cite(apply), 0, 1);
                    a = (Attch) arrayList.get(0);
                    int meet_apply = a.attch;
                    TbMeeting tb = TbMeeting.find(meet_id);
                    tb.setType(0);
                    tb.setName(name);
                    tb.setInform(meet_informa);
                    tb.setZhaoshang(meet_zs);
                    tb.setApply(meet_apply);
                    tb.setMember(h.member);
                    tb.set();


                } catch (SQLException e) {
                    e.printStackTrace();
                    out.print("<script>mt.show('系统异常,请重试！');</script>");
                }
                /* out.print("<script>mt.show('操作成功');parent.window.location.reload();</script>");*/
                out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
                /*out.print("<script>parent.window.location.reload();</script>");*/
                return;
            }


        } else if ("dele_meet".equals(act)) {
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message = "操作执行成功！";
            int id = h.getInt("meet_id");
            try {
                TbMeeting tb = TbMeeting.find(id);
                tb.setType(3);
                tb.set();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");

        } else if ("shenpi_meet".equals(act)) {//后台审批
            try {
                int id = h.getInt("id");
                int type = h.getInt("type");
                String desc = h.get("desc", "无");
                TbMeeting tb = TbMeeting.find(id);
                tb.setType(type);
                if(type==2){//退回原因
                    tb.setCause(desc);
                    tb.set();
                    jo.put("type", "0");
                    out.print(jo.toString());
                    return;
                }
                tb.set();
                jo.put("type", "0");
            } catch (SQLException e) {
                e.printStackTrace();
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
            }
            out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            String message="操作执行成功！";
            out.print("<script>mt.show('" + message + "',1,'" + nexturl + "');</script>");
            return;

        }

    }
}
