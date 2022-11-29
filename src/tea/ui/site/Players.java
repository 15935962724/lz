package tea.ui.site;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.site.*;
import tea.entity.node.*;

//http://www.ckplayer.com/article6.php?id=14#13
public class Players extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            String ref = request.getHeader("referer");
            //user-agent：AppleCoreMedia/1.0.0.10B146 (iPhone; U; CPU OS 6_1_2 like Mac OS X; zh_cn)
            String ua = request.getHeader("user-agent");
            if(ua == null)
            {
                StringBuilder sb = new StringBuilder();
                Enumeration e = request.getHeaderNames();
                while(e.hasMoreElements())
                {
                    String name = (String) e.nextElement();
                    sb.append("\r\n　　" + name + "：" + request.getHeader(name));
                }
                Filex.logs("UA_NULL.txt",sb.toString());
            } else if(ua.startsWith("AppleCoreMedia/") || ref == null)
                ref = "http://" + request.getServerName() + "/";
            if(ref == null)
                return;
            if("conf".equals(act))
            {
                String url = "Players";
                if("tobacco".equals(h.community)) //无烟北京
                {
                    url = "Smokes";
                }
                int width = h.getInt("width",400);
                Community c = Community.find(h.community);
                int player = c.id;
                Player t = Player.find(player);
                out.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                out.println("<ckplayer>");
                out.println("  <style>");
                out.println("    <cpath></cpath>");
                out.println("    <language></language>");
                int j = ref.indexOf('/',8);
                ref = ref.substring(j).startsWith("/tea/") ? ref.substring(0,j + 1) : ref;
                out.print("    <flashvars>{b->1}{my_url->" + ref + "}{f->/res/276_2.mp4}");
                //前置广告 6.3:有广告就自动播放
                if(t.fronttype > 0)
                {
                    out.print("{l->");
                    String[] arr = t.front0.split("[|]");
                    for(int i = 1;i < arr.length;i++)
                    {
                        if(i > 1)
                            out.print("|");
                        out.print(Attch.find(Integer.parseInt(arr[i])).path);
                    }
                    out.println("}");
                    out.println("{r->" + t.front1.substring(1,t.front1.length() - 1) + "}");
                    out.println("{t->" + t.front2.substring(1,t.front2.length() - 1) + "}");
                }
                //暂停广告
                if(t.pausetype > 0)
                {
                    out.print("{d->");
                    String[] arr = t.pause0.split("[|]");
                    for(int i = 1;i < arr.length;i++)
                    {
                        if(i > 1)
                            out.print("|");
                        out.print(Attch.find(Integer.parseInt(arr[i])).path);
                    }
                    out.println("}");
                    out.println("{u->" + t.pause1.substring(1,t.pause1.length() - 1) + "}");
                }
                out.println("</flashvars>");
                int proportion = 0; //0:保持 3:铺满(手动调节不管用)
                int s13 = 2000; //视频缓冲时间,200==1s
                out.println("    <setup>1,1,1,1,1,2," + t.frontorder + ",1," + t.marqueetype + "," + proportion + ",0,1," + s13 + "," + proportion + ",2," + (t.pausetype == 2 ? 1 : 0) + ",0,1,1,1,0,10,3,0,1,2,3000,0,0,0,0,1,1,1,1,1,1,250,1000,90</setup>");
                out.println("    <pm_bg>0x000000,100,230,180</pm_bg>");
                //out.println("    <mylogo>" + (t.buffer != 1 ? "chinapost.swf" : Attch.find(t.buffer).path) + "</mylogo>"); //style.swf
                out.println("    <mylogo>" + (t.buffer < 1 ? "null" : c.webName + ".swf") + "</mylogo>"); //style.swf
                out.println("    <pm_mylogo>1,1,-100,-55</pm_mylogo>");
                //6.4:支持网址,如果不是网址且不存在,会卡在这里
                out.println("    <logo>" + (width < 400 || t.logo < 1 ? "null" : Attch.find(t.logo).path) + "</logo>");
                out.println("    <pm_logo>" + t.pm_logo + "</pm_logo>");
                out.println("    <control_rel>related.swf,/" + url + ".do?act=related,0</control_rel>");
                out.println("    <control_pv>Preview.swf,105,2000</control_pv>");
                out.println("    <pm_repc></pm_repc>");
                out.println("    <pm_spac>|</pm_spac>");
                out.println("    <pm_fpac>file->f</pm_fpac>");
                //前置广告
                out.println("    <pm_advtime>2,0,-110,10,0,300,0</pm_advtime>"); //倒计时文本位置
                out.println("    <pm_advstatus>1,2,2,-200,-40</pm_advstatus>"); //静音按钮
                out.println("    <pm_advjp>" + (t.fronttype == 2 ? "1" : "0") + ",0,2,2,-100,-40</pm_advjp>"); //跳过按钮
                //暂停广告
                out.println("    <pm_padvc>2,0,-10,-10</pm_padvc>"); //关闭按钮
                out.println("    <pm_advms>2,2,-46,-56</pm_advms>");
                out.println("    <pm_zip>1,1,-20,-8,1,0,0</pm_zip>");
                out.println("    <pm_advmarquee>1,2,50,-60,50,18,0,0x000000,50,0,20,1,15,2000</pm_advmarquee>");
                //滚动广告
                out.println("    <advmarquee><![CDATA[{font color='#FFFFFF' size='12'}" + t.marquee + "{/font}]]></advmarquee>");
                out.println("    <myweb></myweb>");
                out.println("    <cpt_lights>1</cpt_lights>");
                out.println("    <cpt_share>/res/" + h.community + "/player/share.xml</cpt_share>");
                if(Player.VER == 6.4F)
                {
                    out.println("    <mainfuntion></mainfuntion>");
                    out.println("    <flashplayer></flashplayer>");
                    out.println("    <calljs>ckplayer_status,ckadjump,playerstop,ckmarqueeadv</calljs>");
                    if(width > 399)
                    {
                        out.println("    <cpt>right.swf,2,1,0,0,2,0</cpt>"); //右边开关灯，调整，分享按钮的插件
                        out.println("    <cpt>definition.swf,2,2,-170,-26,2,1</cpt>"); //清晰度切换插件
                    }
                } else
                {
                    //带清晰度最小宽：290
                    //带右侧栏最小高：280
                    if(width > 399)
                        out.println("    <cpt>right.swf,2,1,-75,-100,2,0</cpt>"); //右边开关灯，调整，分享按钮的插件
                    out.println("    <cpt>bili.swf,1,1,-180,-100,3</cpt>"); //比例选择
                    //
                    if(h.getBool("quality"))
                    {
                        out.println("    <cpt>selected_btn.swf,2,2,-160,-24,2</cpt>"); //清晰度按钮
                        out.println("    <cpt>selected_view.swf,1,1,-180,-100,3</cpt>"); //清晰度选着
                        out.println("    <dizhi>/" + url + ".do?act=quality&</dizhi>");
                    }
                }
                out.println("    <cpt>share.swf,1,1,-180,-100,3,0</cpt>"); //分享插件
                out.println("    <cpt>adjustment.swf,1,1,-180,-100,3,0</cpt>"); //调整大小和颜色的插件
                out.println("    <author>" + MT.f(c.getName(h.language),30) + ",http://" + c.getWebName() + "</author>"); //风格作者的昵称和链接地址，昵称和链接地址之间用逗号隔开
                //风格
                out.println("    <pr_clock2>{font color='#FFFFFF' size='12' face='Arial'}[$Time]" + (width < 250 ? "" : " | [$TimeAll][$Timewait]") + "{/font}</pr_clock2>"); //这里显示播放时间和总时间
//                out.println("    <controlbar>images_buttom_bg.png</controlbar>"); //控制栏背景图片
//                out.println("    <cplay>images_Play_out.png,images_Play_on.png</cplay>"); //播放按钮
//                out.println("    <cpause>images_Pause_out.png,images_Pause_on.png</cpause>"); //暂停按钮
//                out.println("    <pausec>images_Pause_Scgedyke.png,images_Pause_Scgedyke_on.png</pausec>"); //播放器中间暂停按钮
//                out.println("    <sound>images_Sound_out.png,images_Sound_on.png</sound>"); //静音按钮
//                out.println("    <mute>images_Mute_out.png,images_Mute_on.png</mute>"); //取消静音按钮
//                out.println("    <full>images_Full_out.png,images_Full_on.png</full>"); //全屏按钮
//                out.println("    <general>images_General_out.png,images_General_on.png</general>"); //取消全屏按钮
//                out.println("    <cvolume>images_Volume_back.png,images_Volume_on.png,images_Volume_Float.png,images_Volume_Float_on.png</cvolume>"); //音量调节框的四个图片
//                out.println("    <schedule>images_Schedule_bg.png,images_Schedule_load.png,images_Schedule_play.png,images_Schedule.png,images_Schedule_on.png</schedule>"); //进度栏的五个图片
//                out.println("    <fast>images_Fashf_out.png,images_Fashf_on.png,images_Fashr_out.png,images_Fashr_on.png</fast>"); //快进和快退按钮
//                out.println("    <advmute>images_v_off_out.png,images_v_off_on.png,images_v_on_out.png,images_v_on_on.png</advmute>"); //前置广告时静音按钮
//                out.println("    <advjump>images_adv_skip_out.png,images_adv_skip_on.png</advjump>"); //前置广告时路过按钮
//                out.println("    <advclose>images_close_adv_out.png,images_close_adv_on.png</advclose>"); //关闭滚动文字广告按钮
//                out.println("    <padvclose>pause_adv_close_out.png,pause_adv_close_on.png</padvclose>"); //关闭暂停广告按钮
//                out.println("    <pm_tween>50,300,300</pm_tween>");
//                out.println("    <buffer>buffer.swf</buffer>"); //缓冲时显示的图标，不使用设置成null
//                out.println("    <pm_load>1,1,-50,10,1,0,0</pm_load>"); //提示加载视频百分比的文本框
//                out.println("    <pm_buffer>1,1,-20,-35</pm_buffer>"); //缓冲时显示的图标(buffer图标)的坐标
//                out.println("    <pm_buffertext>1,1,-13,-25,0,40,0</pm_buffertext>"); //缓冲文本框(提示加载百分比)的坐标
//                out.println("    <pm_ctbar>1,2,0,-30,0,30,0</pm_ctbar>"); //控制栏的参数
//                out.println("    <pm_sch>1,2,15,-37,15,5,0,14,9</pm_sch>"); //进度条的参数
//                out.println("    <pm_play>0,2,0,-30,35,30</pm_play>"); //播放按钮的位置
//                out.println("    <pm_clock>0,2,100,-25,2,0,0</pm_clock>");
//                out.println("    <pm_clock2>0,2,40,-25,0,0,0</pm_clock2>"); //当前播放时间和总时间的位置
//                out.println("    <pr_clock></pr_clock>");
//                out.println("    <pm_full>2,2,-35,-30,35,30</pm_full>"); //全屏和取消全屏按钮的坐标
//                out.println("    <pm_vol>2,2,-95,-18,53,4,6,12</pm_vol>"); //音量调节框的坐标
//                out.println("    <pm_sound>2,2,-130,-30,35,30</pm_sound>"); //静音和取消静音的坐标
//                out.println("    <pm_fastf>2,2,-13,-39,13,9</pm_fastf>"); //快进按钮的坐标
//                out.println("    <pm_fastr>0,2,0,-39,13,9</pm_fastr>"); //快退按钮的坐标
//                out.println("    <pm_pa>1,1,-30,-46,60,60,0,2,10,-120</pm_pa>"); //中间暂停按钮的坐标控制
//                out.println("    <pm_bg>0x000000,100,230,180</pm_bg>"); //播放器整体的背景配置
//                out.println("    <pm_video>0,0,0,35,0x000000,0,0,0,0,0</pm_video>"); //视频固定区域
//                out.println("    <pm_pr>0x000000,0303030,0xffffff,0,30,80,10</pm_pr>"); //鼠标经过按钮或进度栏显示一个文字提示框
//                out.println("    <pm_advbg>0x000,100</pm_advbg>"); //播放前置广告时底部颜色和透明度
//                out.println("    <pm_start>8,5,0xFFFFFF,100</pm_start>"); //进度栏提示点宽，高，颜色,透明度
//                out.println("    <pm_sce>3,0x6E6E6E,100,0xFF0000,100</pm_sce>"); //当控制栏隐藏时在底部显示一个进度条
//                out.println("    <cpt>sch_lf.png,0,2,15,-37,0,1</cpt>"); //进度栏左边做圆边的一个像宽度的图片
//                out.println("    <cpt>sch_lr.png,2,2,-16,-37,0,1</cpt>"); //进度栏右边做圆边的一个像宽度的图片
                out.println("  </style>");
                out.println("</ckplayer>");
                return;
            } else if("quality".equals(act)) //画质
            {
                if(Player.VER == 6.4F)
                {
                    Attch a = Attch.find(h.getInt("attch"));
                    if(a.path2 == null)
                        out.print(Video.HOST + a.path);
                    else
                        switch(h.getInt("quality"))
                        {
                        case 0: //html5
                            response.sendRedirect(Video.HOST + a.path3);
                            break;
                        case 1:
                            out.print("{deft->高清|流畅|标清}{defa->1|3|2}" + Video.HOST + a.path);
                            break;
                        case 2:
                            out.print("{deft->标清|流畅|高清}{defa->2|3|1}" + Video.HOST + a.path2);
                            break;
                        case 3:
                            out.print("{deft->流畅|标清|高清}{defa->3|2|1}" + Video.HOST + a.path3);
                            break;
                        }
                } else
                {
                    Attch a = Attch.find(h.getInt("?a"));
                    out.println("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                    out.print("<ckplayer>");
                    //高清
                    out.print("  <xl_gq><urls>" + Video.HOST + a.path + "</urls><seleted>false</seleted><enableds>true</enableds></xl_gq>");
                    //标清
                    out.print("  <xl_bq><urls>" + Video.HOST + a.path2 + "</urls><seleted>true</seleted><enableds>true</enableds></xl_bq>");
                    //流畅
                    out.print("  <xl_qx><urls>" + Video.HOST + a.path3 + "</urls><seleted>false</seleted><enableds>true</enableds></xl_qx>");
                    out.print("</ckplayer>");
                }
                return;
            }
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                return;
            }
            int player = h.getInt("player");
            Player t = Player.find(player);
            if("del".equals(act)) //删除
            {
                t.delete();
            } else if("edit".equals(act)) //编辑
            {
                int attch = h.getInt("logo.attch");
                if(attch > 0)
                    t.logo = attch;
                attch = h.getInt("buffer.attch");
                if(attch > 0)
                    t.buffer = attch;
                StringBuilder ids = new StringBuilder();
                for(int i = 0;i < 4;i++)
                {
                    ids.append(",").append(h.getInt("pm_logo" + i));
                }
                t.pm_logo = ids.substring(1);
                //前置广告
                t.fronttype = h.getInt("fronttype");
                t.frontorder = h.getInt("frontorder");
                t.front0 = t.front1 = t.front2 = "|";
                String[] front0 = h.getValues("front0"),front1 = h.getValues("front1"),front2 = h.getValues("front2");
                for(int i = 0;i < front0.length;i++)
                {
                    attch = h.getInt("front0_" + i + ".attch");
                    if(attch > 0)
                        front0[i] = String.valueOf(attch);
                    if(front0[i].length() < 1)
                        continue;
                    t.front0 += front0[i] + "|";
                    t.front1 += front1[i] + "|";
                    t.front2 += front2[i] + "|";
                }
                //暂停广告
                t.pausetype = h.getInt("pausetype");
                t.pause0 = t.pause1 = "|";
                String[] pause0 = h.getValues("pause0"),pause1 = h.getValues("pause1");
                for(int i = 0;i < pause0.length;i++)
                {
                    attch = h.getInt("pause0_" + i + ".attch");
                    if(attch > 0)
                        pause0[i] = String.valueOf(attch);
                    if(pause0[i].length() < 1)
                        continue;
                    t.pause0 += pause0[i] + "|";
                    t.pause1 += pause1[i] + "|";
                }
                //滚动广告
                t.marqueetype = h.getInt("marqueetype");
                t.marquee = h.get("marquee");
                //分享
                t.share_uuid = h.get("share_uuid");
                t.set();
                t.cache();
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
