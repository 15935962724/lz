package tea.ui.lms;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.lms.*;
import tea.entity.member.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.poi.ss.usermodel.*;

public class LmsMemberCourses extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        response.setHeader("Content-Encoding","nogzip");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            out.println("<script>var mt=parent.mt,$$=parent.$$;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            String info = "操作执行成功！";
            if("imp".equals(act)) //导入
            {
                for(int j = 0;j < 20;j++)
                    out.write("// 显示进度条  \n");
                info = imp(h,out);
                if(!info.startsWith("操作"))
                    nexturl = "";
                if(info.startsWith("<br 2>"))
                {
                    out.print("<script>mt.show('" + info.substring(6) + "',2,'" + nexturl + "',500);$$('dl_ok').value=' 继 续 ';mt.ok=function(){var frm=parent.document.form2;frm.ignore.value=true;if(frm.onsubmit()!=false)frm.submit();return false;}</script>");
                    return;
                }
            } else
            {
                String key = h.get("lmsmembercourse","");
                int lmsmembercourse = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
                LmsMemberCourse t = LmsMemberCourse.find(lmsmembercourse);
                if("del".equals(act)) //删除
                {
                    t.delete();
                } else if("edit".equals(act)) //编辑
                {
                    if(h.getInt("type") == 0)
                        t.lmscourse0 = h.get("lmscourse","|");
                    else
                        t.lmscourse1 = h.get("lmscourse","|");
                    if(t.lmsmembercourse < 1)
                    {
                        t.member = Integer.parseInt(MT.dec(h.get("member")));
                        t.lmsplan = h.getInt("lmsplan");
                        t.time = new Date();
                    }
                    t.getPrice();
                    t.set();
                }
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "'," + (info.length() > 30 ? 500 : 320) + ");</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }

    public static String imp(Http h,Writer out) throws SQLException
    {
        int type = h.getInt("type");
        int lmsplan = h.getInt("lmsplan");
        LmsPrice pr = LmsPrice.find(lmsplan,0);
        if(pr.lmsprice < 1)
            return "抱歉，相关的费用没有配置，无法导入！";
        Workbook wbs = Lms.conv(Http.REAL_PATH + h.get("file"));
        if(wbs == null)
            return "抱歉，请上传xls、xlsx格式文件！";

        StringBuilder sb1 = new StringBuilder(),sb2 = new StringBuilder();
        ArrayList lpcs = LmsPlanCourse.find(" AND lmsplan=" + lmsplan + " ORDER BY starttime",0,Integer.MAX_VALUE);
        int a1 = 0,a2 = 0;
        Sheet s = wbs.getSheetAt(0);
        ArrayList lss = new ArrayList();
        for(int i = 3;i <= s.getLastRowNum();i++)
        {
            Row r = s.getRow(i);
            if(r == null)
                continue;
            int j = 0;
            String th = null;
            try
            {
                th = "姓名";
                String name = Lms.f(r,j++);
                //
                th = "证件号";
                String card = Lms.f(r,j++);
                if((MT.f(name) + MT.f(card)).length() < 1) //空白行（某此单元格中有空格），一班在未尾会出现。
                    continue;
                ArrayList al = Profile.find1(" AND deleted=0 AND type NOT IN(1,4) AND card=" + DbAdapter.cite(card),0,Integer.MAX_VALUE);
                if(al.size() != 1)
                    return "抱歉，学员“" + card + "”不存在！";
                Profile p = (Profile) al.get(0);
                String prefix = "抱歉，学员“<a href=/jsp/lms/LmsMemberCourseView.jsp?member=" + MT.enc(p.getProfile()) + " target=_blank>" + p.getName(h.member) + "</a><span class=info>(" + card + ")</span>";
                //
                LmsMemberCourse lmc = LmsMemberCourse.find(p.getProfile(),lmsplan);
                if(lmc.lmsmembercourse > 0)
                {
                    if(type == 2)
                        continue;
                    if(type == 3)
                        return "抱歉，学员“" + card + "”已存在！";
                    a2++;
                } else
                {
                    a1++;
                }
                lmc.time = new Date();
                //
                StringBuilder err = new StringBuilder();
                StringBuilder id0 = new StringBuilder("|");
                for(int x = 0;x < lpcs.size();x++)
                {
                    LmsPlanCourse lpc = (LmsPlanCourse) lpcs.get(x);
                    LmsCourse lc = LmsCourse.find(lpc.lmscourse);
                    th = lc.name;
                    if("报考".equals(Lms.f(r,j++)))
                    {
                        id0.append(lpc.lmscourse).append("|");
                        LmsScore ls = LmsScore.findLast(lmc.member,lmsplan,lpc.lmscourse);
                        if(ls.score >= 60)
                            err.append("、“" + lc.name + "<span class=info>(" + ls.score + ")</span>”");
                    }
                }
                StringBuilder id1 = new StringBuilder("|");
                for(int x = 0;x < lpcs.size();x++)
                {
                    LmsPlanCourse lpc = (LmsPlanCourse) lpcs.get(x);
                    LmsCourse lc = LmsCourse.find(lpc.lmscourse);
                    th = lc.name;
                    if("报考".equals(Lms.f(r,j++)))
                    {
                        id1.append(lpc.lmscourse).append("|");
                        if(id0.indexOf("|" + lpc.lmscourse + "|") != -1) //防止实践、机考重复报考，提示两次！
                            continue;
                        LmsScore ls = LmsScore.findLast(lmc.member,lmsplan,lpc.lmscourse);
                        if(ls.score >= 60)
                            err.append("、“" + lc.name + "<span class=info>(" + ls.score + ")</span>”");
                    }
                }
                if(err.length() > 0) //通过后，继续报考
                    sb2.append("<br 2>" + prefix + "已通过了" + err.substring(1) + "考试！");

                lmc.lmscourse0 = id0.toString();
                lmc.lmscourse1 = id1.toString();
                String info = time(lmc.lmsplan,lmc.lmscourse0) + time(lmc.lmsplan,lmc.lmscourse1);
                if(info.length() > 0)
                    sb1.append("<br 1>" + prefix + "报考时间" + info.substring(1) + "冲突！");

                lmc.getPrice();
                lss.add(lmc);
                if(out != null)
                {
                    out.write("<script>mt.progress(" + i + "," + s.getLastRowNum() + ",'姓名：" + name + "　报考：" + Math.max(0,lmc.lmscourse1.split("[|]").length - 1) + "课');</script>");
                    out.flush();
                }
            } catch(Throwable ex)
            {
                ex.printStackTrace();
                return "位置：" + (i + 1) + "x" + j + "<br/>列名：" + th + "<br/>错误：" + ex.toString();
            }
        }
        if(sb1.length() > 0)
            return sb1.substring(6);
        if(!h.getBool("ignore") && sb2.length() > 0)
            return sb2.append("<br 2>是否再次报考？").toString();
        for(int i = 0;i < lss.size();i++)
        {
            LmsMemberCourse lmc = (LmsMemberCourse) lss.get(i);
            lmc.set();
        }
        return "操作执行成功！<br/>新增：" + a1 + "条　替换：" + a2 + "条";
    }

    //同一时间考试
    static String time(int lmsplan,String course) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT starttime,MIN(lmscourse),MAX(lmscourse) FROM LmsPlanCourse WHERE lmsplan=" + lmsplan + " AND lmscourse IN(" + course.substring(1).replace('|',',') + "0)" + " GROUP BY starttime HAVING COUNT(*)>1");
            while(db.next())
            {
                sb.append("、“").append(MT.f(db.getDate(1),1) + "<span class=info>(" + LmsCourse.find(db.getInt(2)).name + "和" + LmsCourse.find(db.getInt(3)).name + ")</span>”");
            }
        } finally
        {
            db.close();
        }
        return sb.toString();
    }
}
