package tea.ui.weixin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.Err;
import tea.entity.Http;
import tea.entity.weixin.WxActivity;
import tea.entity.weixin.WxActivityMem;
import tea.entity.weixin.WxActivityPrize;

public class WxActivityPrizes extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        PrintWriter out = response.getWriter();
        try
        {
        	int wxActivityPrize = h.getInt("wxActivityPrize");
            if("del".equals(act)) //删除
            {
            	WxActivityPrize t = WxActivityPrize.find(wxActivityPrize);
            	WxActivity activity = WxActivity.find(t.getActivityId());
            	long nowTimes = new Date().getTime();
            	if(nowTimes<activity.getStarttime().getTime()||nowTimes>activity.getStoptime().getTime()){//活动未开始或活动已经结束
            		List<WxActivityMem> activityMemList = WxActivityMem.find(" AND activityId="+t.getActivityId()+" AND activityPrizeId="+t.getId()+" AND status!=0", 0, Integer.MAX_VALUE);
            		if(activityMemList!=null&&activityMemList.size()>0){
            			out.print("本奖项已有人中奖，不能删除该奖项！");
            		}else{
            			t.delete();
            		}
            	}else{//活动正在进行中
            		out.print("活动正在进行中，不能删除奖项！");
            	}            	
                
                return;
            }
        	
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            String info = "操作执行成功！";
             
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id=ta>" + Err.get(h,ex) + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
