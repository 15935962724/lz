package tea.ui.weixin;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.Err;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.nba.PointGift;
import tea.entity.weixin.WxActivity;
import tea.entity.weixin.WxActivityMem;
import tea.entity.weixin.WxActivityPrize;

public class WxActivitys extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        PrintWriter out = response.getWriter();
        try
        {
        	int wxActivity = h.getInt("wxActivity");
        	
        	if("scratchCard".equals(act)||"fruitMachine".equals(act)||"smashEggs".equals(act)||"turntable".equals(act)){
        		String json = "";
        		WxActivity t=WxActivity.find(wxActivity);
        		Date nowDate = new Date();
        		long nowTimes = nowDate.getTime();
        		if(nowTimes<t.getStarttime().getTime()){
        			//out.print("未开始");
        			json = "{abnormalUrl:'/jsp/weixin/WxAbnormal.jsp?status=1&type="+t.getType()+"'}";
        			out.print(json);
        			//request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=1&type=1").forward(request, response);
        			//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=1&type=1");
        			return;
        		}else if(nowTimes>t.getStoptime().getTime()){
        			//out.print("已结束");
        			json = "{url:'/jsp/weixin/WxAbnormal.jsp?status=2&type="+t.getType()+"'}";
        			out.print(json);
        			//request.getRequestDispatcher("/jsp/weixin/WxAbnormal.jsp?status=2&type=1").forward(request, response);
        			//response.sendRedirect("/jsp/weixin/WxAbnormal.jsp?status=2&type=1");
        			return;
        		}
        	}
        	
        	if("scratchCard".equals(act)||"fruitMachine".equals(act)||"smashEggs".equals(act)){
        		String json = "";
        		/*Lottery lottery = new Lottery(wxActivity,h.member);
        		WxActivityPrize p = lottery.awardPrizeByActivityId();*/
        		WxActivityPrize p = WxActivityPrize.awardPrizeByActivityId(wxActivity, h.member);
        		PointGift pg = PointGift.find(p.getPgId());
        		
        		json = "{id:"+p.getId()+",name:'"+MT.f(p.getName())+"',seq:"+p.getSequence()+",winActivityMemId:"+p.getWinActivityMemId()+",pgId:"+p.getPgId()+",pgName:'"+MT.f(pg.getgName())+"'}";
        		
        		out.print(json);
        		return;
        	}else if("turntable".equals(act)){
        		Object[][] prizeArr = new  Object[][]{//最多六个奖项
        				{1,346,377},
        				{2,109,137},
        				{3,223,252},
        				{4,49,79},
        				{5,166,193},
        				{6,283,313}
        		};
        		
        		Object[][] noPrizeArr = new  Object[][]{
        				{1,18,48,"不要灰心"},
        				{2,80,108,"祝您好运"},
        				{3,138,165,"再接再厉"},
        				{4,194,222,"运气先攒着"},
        				{5,253,282,"要加油哦"},
        				{6,314,345,"谢谢参与"}
        		};
        		
        		String json = "";
        		/*Lottery lottery = new Lottery(wxActivity,h.member);
        		WxActivityPrize p = lottery.awardPrizeByActivityId();*/
        		//去抽奖
        		WxActivityPrize p = WxActivityPrize.awardPrizeByActivityId(wxActivity, h.member);
        		String prizeName = "";
        		String pgName = "";
        		int angel = 0;
        		if(p.getId()>0){//有奖
        			PointGift pg = PointGift.find(p.getPgId());
        			pgName = MT.f(pg.getgName());
        			int prizeSeq = p.getSequence();
        			Object prizeObject[] = prizeArr[prizeSeq-1];
        			prizeName = MT.f(p.getName());
        			angel = new Random().nextInt((Integer)prizeObject[2]-(Integer)prizeObject[1])+(Integer)prizeObject[1];
        		}else{
        			int noPrizeIndex = new Random().nextInt(6);//大于等于0小于6的int数
        			Object noPrizeObject[] = noPrizeArr[noPrizeIndex];
        			prizeName = (String) noPrizeObject[3];
        			angel = new Random().nextInt((Integer)noPrizeObject[2]-(Integer)noPrizeObject[1])+(Integer)noPrizeObject[1];
        		}
        		
        		
        		json = "{id:"+p.getId()+",name:'"+prizeName+"',winActivityMemId:"+p.getWinActivityMemId()+",pgId:"+p.getPgId()+",pgName:'"+pgName+"',angle:"+angel+"}";
        		
        		out.print(json);
        		return;
        	}else if("savePrizeMem".equals(act)){
        		int winActivityMemId = h.getInt("winActivityMemId");
        		
        		//修改 中奖人 信息
        		WxActivityMem activityMem = WxActivityMem.find(winActivityMemId);
        		activityMem.setTel(h.get("tel"));
        		activityMem.setTime(new Date());
        		activityMem.setStatus(1);//领奖状态-0：未中奖；1：未奖领；2：已领
        		activityMem.set();
        		
        		return;				
        	}
        	
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            String info = "操作执行成功！";
            WxActivity t = WxActivity.find(wxActivity);
            if("del".equals(act)) //删除
            {
            	String[] arr = wxActivity > 0 ? new String[]{String.valueOf(wxActivity)} : h.getValues("wxActivitys");
				for (int i = 0; i < arr.length; i++)
				{
					//先根据id查找到WxActivity
					WxActivity a=WxActivity.find(Integer.parseInt(arr[i]));
					
					long nowTimes = new Date().getTime();
	            	if(nowTimes<a.getStarttime().getTime()||nowTimes>a.getStoptime().getTime()){//活动未开始或活动已经结束
	            		List<WxActivityMem> activityMemList = WxActivityMem.find(" AND activityId="+a.getId()+" AND status!=0", 0, Integer.MAX_VALUE);
	            		if(activityMemList!=null&&activityMemList.size()>0){
	            			info = "本活动已有人中奖，不能删除该活动！";
	            		}else{
	            			WxActivityMem.deleteByActivityId(a.getId());
	            			a.delete();
	            		}
	            	}else{//活动正在进行中
	            		info = "活动正在进行中，不能删除活动！";
	            	}
					
				}
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
            	t.setCommunity(h.community);
            	t.setType(h.getInt("type"));
                t.setName(h.get("name"));
                t.setKeyword(h.get("keyword"));
                t.setStarttime(h.getDate("starttime"));
                t.setStoptime(h.getDate("stoptime"));
                t.setAttch(h.getInt("attch.attch"));
                t.setInfo(h.get("info"));
                t.setShowNum(h.getBool("showNum"));
                t.setTotalOfPerson(h.getInt("totalOfPerson"));
                t.setNumOfDay(h.getInt("numOfDay"));
                t.setMaxNumOfDay(h.getInt("maxNumOfDay"));
                t.setHidden(h.getBool("hidden"));
                if(wxActivity<1){
                	t.setTime(new Date());
                }
                t.set();
            	
            	String[] prize_name_arr = h.getValues("prize_name");
                if(prize_name_arr.length<1){
                	info = "奖项数量不能为空！";
                }else{
                	/*List<WxActivityPrize> actyPrizeList = WxActivityPrize.find(" AND activityId="+t.getId(), 0, Integer.MAX_VALUE);
                	for(WxActivityPrize p:actyPrizeList){
                		p.delete();
                	}*/
                	
                	String[] prize_id_arr = h.getValues("prize_id");
                	String[] prize_pgId_arr = h.getValues("prize_pgId");
                	String[] prize_num_arr = h.getValues("prize_num");
                	String[] prize_probability_arr = h.getValues("prize_probability");
                	
                	for(int i=0;i<prize_name_arr.length;i++){
                		int prizeId = Integer.parseInt(prize_id_arr[i]);
                		String prizeName = prize_name_arr[i];
                		int prizePgiId = Integer.parseInt(prize_pgId_arr[i]);
                		int prizeNum = Integer.parseInt(prize_num_arr[i]);
                		DecimalFormat df = new DecimalFormat(".0000");
                		double prizeProbability = Double.parseDouble(df.format(Double.parseDouble(prize_probability_arr[i])));
                		WxActivityPrize actyPrice = WxActivityPrize.find(prizeId);
                		actyPrice.setActivityId(t.getId());
                		actyPrice.setName(prizeName);
                		actyPrice.setPgId(prizePgiId);
                		actyPrice.setNum(prizeNum);
                		actyPrice.setProbability(prizeProbability/100);
                		actyPrice.setSequence(i+1);
                		if(actyPrice.getId()<1)
                			actyPrice.setTime(new Date());
                		actyPrice.set();
                	}
                	
                	/*//根据微活动id重新设置单一类型奖品库
                	WxGetGift gg = new WxGetGift(t.getId());
                	gg.reSetGifts();*/
                }
            	
            	
            } 
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
