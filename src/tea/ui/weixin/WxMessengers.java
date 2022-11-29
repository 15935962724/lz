package tea.ui.weixin;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.member.Profile;
import tea.entity.node.Node;
import tea.entity.node.Report;
import tea.entity.weixin.*;
import tea.entity.yl.shop.ShopOrder;
import tea.entity.yl.shop.ShopOrderData;
import tea.entity.yl.shop.ShopOrderDispatch;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

//MicroMessenger/4.3.215
public class WxMessengers extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        Http h = new Http(request,response);
        String act = h.get("act");
        ServletContext appliction = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            if(act != null)
            {
                if("html".equals(act))
                {
                    StringBuffer sql = new StringBuffer(),par = new StringBuffer();

                    int menuid = h.getInt("id");
                    par.append("?id=" + menuid);

                    sql.append(" AND community=" + DbAdapter.cite(h.community) + " AND star IS NOT NULL");
                    par.append("&community=" + h.community);

                    int size = h.getInt("size");
                    par.append("&size=" + size);

                    int pos = h.getInt("pos");
                    par.append("&pos=");

                    int sum = WxMessenger.count(sql.toString());

                    int i = 0;
                    out.print("<table id='tablecenters' cellspacing='0'><tr id='tableonetrs'><td style='padding-left:15px'>发送方</td><td>内容</td><td class='times'>时间</td></tr>");
                    if(sum < 1)
                    {
                        out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
                    } else
                    {
                        sql.append(" ORDER BY wm.star DESC");
                        ArrayList al = WxMessenger.find(sql.toString(),pos,size);
                        while(i < al.size())
                        {
                            WxMessenger t = (WxMessenger) al.get(i);
                            WxUser wu = WxUser.find(t.community,t.fuser);
                            out.print("<tr class=" + (i++ % 2 == 0 ? "bgs" : "") + ">");
                            out.print("<td>" + wu.getAnchor());
                            out.print("<td>" + t.getContent());
                            out.print("<td class='times' nowrap>" + MT.f(t.time,1).substring(11));
                        }
                        if(sum > size)
                            out.print("<tr class=" + (i++ % 2 == 0 ? "bgs" : "") + "><td colspan='10' align='right' class='pat'>" + new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,size));
                    }
                    out.print("</table>");
                    return;
                }
                out.println("<script>var mt=parent.mt;</script>");
                if(h.member < 1)
                {
                    out.print("<script>top.location.replace('/servlet/StartLogin?community=" + h.community + "');</script>");
                    return;
                }
                String info = "操作执行成功！";
                String nexturl = h.get("nexturl");
                long wxmessenger = Long.parseLong(h.get("wxmessenger"));
                if("star".equals(act))
                {
                    WxMessenger wm = WxMessenger.find(wxmessenger);
                    wm.star = wm.star == null ? new Date() : null;
                    wm.set("star",wm.star);
                } else if("edit".equals(act))
                {

                }
                out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
            } else
            {
                int wxtype = h.getInt("wxtype");
                String echostr = h.get("echostr");
                if(echostr != null) // 提交时_验证
                {
                    String[] arr =
                            {h.get("nonce"),h.get("timestamp"),token,wxtype == 2 ? echostr : ""};
                    if(!sign(arr).equals(h.get(wxtype == 2 ? "msg_signature" : "signature")))
                    {
                        arr[2] = "weixin_token";
                        if(!sign(arr).equals(h.get("signature")))
                            return;
                    }
                    if(wxtype == 2) // 企业号
                        echostr = dec(echostr);
                    out.print(echostr);
                    return;
                }

                byte[] by = Filex.read(request.getInputStream());
                String str = new String(by,"utf-8");
                Filex.logs("WxMessenger_" + request.getServerName() + ".log","IP:" + request.getRemoteAddr() + "\nUA:" + request.getHeader("User-Agent") + "\n" + str);
                if(str.length() < 1)
                    return;
                XMLObject xml = new XMLObject(str).getXMLObject("xml");
                String encrypt = xml.getString("encrypt");
                if(encrypt != null)
                {
                    Filex.logs("WxMessenger_" + request.getServerName() + ".log","解密后：" + dec(encrypt));
                    xml = new XMLObject(dec(encrypt)).getXMLObject("xml");
                }
                String mtype = xml.getString("msgtype");
                WxUser fu = WxUser.find(xml.getString("fromusername"));
                fu.userid = xml.getString("tousername");
                if(fu.time == null)
                {
                    fu.community = h.community;
                    fu.set();
                    // fu.info();
                }
                h.key = fu.openid;
                String sn = "http://" + request.getServerName();
                WeiXin wx = WeiXin.find(h.community);
                StringBuilder sb = new StringBuilder();
                sb.append("<xml>");
                sb.append("  <ToUserName><![CDATA[" + fu.openid + "]]></ToUserName>");
                sb.append("  <FromUserName><![CDATA[" + xml.getString("tousername") + "]]></FromUserName>");
                sb.append("  <CreateTime>" + xml.getInt("createtime") + "</CreateTime>");
                if("CLICK".equals(xml.get("event"))) //事件
                {
                    mtype = "click";
                    int menu = xml.getInt("eventkey");
                    StringBuilder sql = new StringBuilder();
                    WxMenu wm = WxMenu.find(menu);
                    if(wm.type == 3) // 节点
                    {
                        int sum = 0;
                        sql.append("SELECT n.node,n.type,nl.subject,nl.picture,nl.content FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node WHERE n.finished=1 AND n.hidden=0");
                        sql.append(" AND n.node IN(" + wm.eventkey + "0)");
                        sb.append("  <Articles>");
                        DbAdapter db = new DbAdapter();
                        try
                        {
                            db.executeQuery(sql.toString(),0,10);
                            while(db.next())
                            {
                                int node = db.getInt(1);
                                int type = db.getInt(2);
                                String subject = db.getString(3);
                                String picture = type == 39 ? Report.find(node).getPicture(h.language) : null;
                                if(picture == null || picture.length() < 1)
                                {
                                    picture = db.getString(4);
                                    if(picture == null || picture.length() < 1)
                                        picture = "/tea/image/404.jpg";
                                    else if(picture.endsWith("#auto"))
                                        picture = picture.substring(0,picture.length() - 5);
                                    picture = Http.enc(picture).replaceAll("%2F","/");
                                }
                                String content = db.getText(5);
                                content = MT.f(content.replaceAll("<[^>]+>|&nbsp;",""),100);
                                sb.append("    <item>");
                                sb.append("      <Title><![CDATA[" + subject + "]]></Title>");
                                sb.append("      <Discription><![CDATA[" + content + "]]></Discription>");
                                sb.append("      <PicUrl>" + sn + picture + "</PicUrl>");
                                sb.append("      <Url>" + sn + "/xhtml/" + (type > 1023 ? "node" : Node.NODE_TYPE[type].toLowerCase()) + "/" + node + "-" + h.language + ".htm</Url>");
                                sb.append("    </item>");
                                sum++;
                            }
                            str = wx.notfound;
                        } catch(Throwable ex)
                        {
                            str = ex.toString();
                        } finally
                        {
                            db.close();
                        }
                        sb.append("  </Articles>");
                        if(sum < 1)
                        {
                            sb.append("  <MsgType>text</MsgType>");
                            sb.append("  <Content><![CDATA[" + str + "<a href=\"http://" + request.getServerName() + "#openid=" + fu.openid + "\"> </a>" + "]]></Content>");
                        } else
                        {
                            sb.append("  <MsgType>news</MsgType>");
                            sb.append("  <Content>content</Content>");
                            sb.append("  <ArticleCount>" + sum + "</ArticleCount>");
                        }
                    } else if("在线客服".equals(wm.eventkey))
                    {
                        sb.append("<MsgType>transfer_customer_service</MsgType>");
                    } else if("rule".equals(wm.eventkey))
                    {
                        sb.append(WxRule.find(h,wm.name));
                    } else
                    {
                        try
                        {
                            str = h.read("/jsp/weixin/WxMenuEvent.jsp?menu=" + menu);
                            if(str.startsWith("﻿"))
                                str = str.substring(1);
                        } catch(Throwable ex)
                        {
                            str = "<MsgType>text</MsgType><Content><![CDATA[" + ex.toString() + "]]></Content>";
                        }
                        if((str = str.trim()).length() < 1)
                        {
                            sb.append("<MsgType>text</MsgType>");
                            sb.append("<Content><![CDATA[" + menu + "]]></Content>");
                        } else
                            sb.append(str);
                    }
                } else if("event".equals(mtype))
                {
                    if("subscribe".equals(xml.get("event")) || "SCAN".equals(xml.get("event"))) // 订阅
                    {
                        fu.community = h.community;
                        if(fu.wxgroup == 80)
                        {
                            if(fu.dtime != null)
                            {
                                WxGroup wg = WxGroup.find(h.community,fu.wxgroup);
                                wg.set("cnt",String.valueOf(--wg.cnt));
                            }
                            fu.wxgroup = 0;
                        }
                        fu.set();
                        //
                        String tmp = xml.getString("eventkey");
                        
                        if(tmp.startsWith("lz")) // 粒子扫描签收
                        {
                        	String orderid = tmp.substring(2);
                            String info = "";
                            boolean flag = Profile.flagopenid(fu.openid);
                            if(flag){
                            	//判断签收人
                            	//根据openid 查找其所在的医院 -粒子签收
                            	int hospital = Profile.getHospitalByOpenId(fu.openid,0);
                            	if(hospital > 0){
	                            	//查找订单所属医院
	                            	ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderid);
	                            	//判断签收人和订单所属的医院是否相同
	                            	if(hospital == sod.getA_hospital_id()){
	                            		//签收成功
	                            		ShopOrder soObj = ShopOrder.findByOrderId(orderid);
	                            		if(soObj.getStatus() == 3){
		            		        		soObj.setStatus(4); 	//已完成（已签收）
		            		        		soObj.setReceiptTime(new Date());	//签收时间
		            		        		soObj.setSign_user_openid(fu.openid);	//签收人openid
		            		        		soObj.set();
		                            		info += "<a href='"+sn+"/jsp/yl/shop/ShopOrderDatasInfo.jsp?orderId="+orderid+"'>签收成功，点击查看详情！</a>";
	                            		}else{
	                            			info += "该订单已签收过，谢谢！";
	                            		}
	                            	}else{
	                            		info += "签收人不匹配，请与管理员联系-010-68533123";	//签收人不匹配
	                            	}
                            	}else{
                            		info += "您尚未成为签收人，请与管理员联系-010-68533123";
                            	}
                            }else{
//                            	info += "<a href='"+sn+"/mobjsp/yl/user/YlLoginWX.jsp?gonexturl="+Http.enc("/ShopOrders.do?act=lzsign&orderid="+orderid)+"'>点击绑定用户</a>";
                            	info += "<a href='"+sn+"/mobjsp/yl/user/login_mobile.html?nexturl="+Http.enc("/ShopOrders.do?act=lzsign&orderid="+orderid)+"'>点击绑定用户</a>";
                            }
                            
                            sb.append("  <MsgType>text</MsgType>");
                            sb.append("  <Content><![CDATA[" + info + "]]></Content>");
                        }else if(tmp.startsWith("invoice")){	//扫码发票签收
                        	String orderid = tmp.substring(7);
                            String info = "";
                            boolean flag = Profile.flagopenid(fu.openid);
                            if(flag){
                            	//判断签收人
                            	//根据openid 查找其所在的医院 -发票签收
                            	int hospital = Profile.getHospitalByOpenId(fu.openid,1);
                            	if(hospital > 0){
	                            	//查找订单所属医院
	                            	ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderid);
	                            	//判断签收人和订单所属的医院是否相同
	                            	if(hospital == sod.getA_hospital_id()){
	                            		//签收成功
	                            		if(sod.getStatus() == 1){
	                            			info += "该发票单已签收过，谢谢！";
	                            		}else{
	                            			sod.setStatus(1);					//签收
	                            			sod.setSign_user_openid(fu.openid);	//签收人
	                            			sod.setSing_date(new Date());		//签收时间
	                            			sod.set();
	                            			//根据订单id查询订单详情信息
	                            			StringBuffer sql=new StringBuffer();
	                            			sql.append(" AND order_id="+DbAdapter.cite(orderid));
	                            			List<ShopOrderData> sodList = ShopOrderData.find(sql.toString(),0,Integer.MAX_VALUE);
	                            			ShopOrderData orderData = sodList.get(0);
	                            			info += "订单号："+orderid+"\n发票号："+sod.getN_invoiceNo()+"\n金额："+orderData.getAmount();
	                            			info += "\n您的发票签收成功，如有疑问，请与管理员联系-010-68533123";
		                            		//info += "<a href='"+sn+"/jsp/yl/shop/ShopOrderDatasInfo.jsp?orderId="+orderid+"'>签收成功，点击查看详情！</a>";
	                            		}
	                            	}else{
	                            		info += "发票签收人不匹配，请与管理员联系-010-68533123";	//签收人不匹配
	                            	}
                            	}else{
                            		info += "您尚未成为签收人，请与管理员联系-010-68533123";
                            	}
                            }else{
                            	info += "<a href='"+sn+"/mobjsp/yl/user/YlLogin.jsp?gonexturl="+Http.enc("/ShopOrders.do?act=fpsign&orderid="+orderid)+"'>点击绑定用户</a>";
                            }
                            
                            sb.append("  <MsgType>text</MsgType>");
                            sb.append("  <Content><![CDATA[" + info + "]]></Content>");
                        } else
                        {
                            if(wx.welcome[wxtype].startsWith("|")) // 图文
                            {
                                String[] arr = wx.welcome[wxtype].split("[|]");
                                sb.append("  <MsgType>news</MsgType>");
                                sb.append("  <ArticleCount>" + (arr.length - 1) + "</ArticleCount>");
                                sb.append("<Articles>");
                                for(int i = 1;i < arr.length;i++)
                                {
                                    Node a = Node.find(Integer.parseInt(arr[i]));
                                    sb.append("<item><Title><![CDATA[" + a.getSubject(h.language) + "]]></Title><Description><![CDATA[" + a.getDescription(h.language) + "]]></Description><PicUrl><![CDATA[" + sn + MT.f(a.getPicture(h.language),"/tea/image/404.jpg") + "]]></PicUrl><Url><![CDATA[" + sn + "/xhtml/report/" + a._nNode + "-1.htm]]></Url></item>");
                                }
                                sb.append("</Articles>");
                            } else // 文字
                            {
                                sb.append("  <MsgType>text</MsgType>");
                                sb.append("  <Content><![CDATA[" + wx.welcome[wxtype] + "]]></Content>");
                                sb.append("  <FuncFlag>0</FuncFlag>");
                            }
                        }
                    } else if("unsubscribe".equals(xml.get("event"))) // 退订
                    {
                        fu.wxgroup = 80;
                        fu.dtime = new Date(xml.getInt("createtime") * 1000L);
                        fu.set();
                        //
                        WxGroup wg = WxGroup.find(h.community,fu.wxgroup);
                        wg.set("cnt",String.valueOf(++wg.cnt));
                    } else if("VIEW".equals(xml.get("event"))) //菜单
                    {
                        if(fu.wxgroup == 80)
                        {
                            Filex.logs("WxUser_80.txt",fu.toString());
                            fu.set("wxgroup",String.valueOf(fu.wxgroup = 0));
                        }
                    } else if("scancode_waitmsg".equals(xml.get("event"))) // 扫一扫
                    {
                    	
                        xml = xml.getXMLObject("scancodeinfo");
                        Filex.logs("wxScancode.txt","xml:" + xml);
                        String ScanType = xml.getString("scantype"); // qrcode
                        String scanresult = xml.getString("scanresult");
                        sb.append("  <MsgType>text</MsgType>");
                        sb.append("  <Content><![CDATA[<a href=\"" +  scanresult + "\">请点这里进行操作</a>" + "]]></Content>");
                    }
                } else
                {
                    WxUser tu = WxUser.find(xml.getString("tousername"));
                    if(tu.time == null)
                    {
                        tu.community = h.community;
                        tu.nickname = "官方";
                        tu.set();
                    }
                    //
                    WxMessenger t = new WxMessenger(Long.parseLong(xml.getString("msgid")));
                    t.community = h.community;
                    t.fuser = fu.wxuser;
                    t.tuser = tu.wxuser;
                    t.type = Arrayx.indexOf(WxMessenger.TYPE_CODE,mtype);
                    t.status = 4;
                    t.time = new Date(xml.getInt("createtime") * 1000L);
                    //
                    if(t.type == 1)
                    {
                        t.content = xml.getString("content");
                        if("客服".equals(t.content))
                        {
                            sb.append("  <MsgType>transfer_customer_service</MsgType>");
                        } else if("Hello2BizUser".equals(t.content))
                        {
                            sb.append("  <MsgType>text</MsgType>");
                            sb.append("  <Content><![CDATA[" + wx.welcome + "]]></Content>");
                        } else if("debug".equals(t.content))
                        {
                            sb.append("  <MsgType>text</MsgType>");
                            sb.append("  <Content><![CDATA[" + fu + "]]></Content>");
                        } else if("音乐".equals(t.content))
                        {
                            sb.append("  <MsgType><![CDATA[music]]></MsgType>");
                            sb.append("  <Music>");
                            sb.append("    <Title><![CDATA[如果爱老了]]></Title>");
                            sb.append("    <Description><![CDATA[作词：白金明 谭旋\r\n作曲：谭旋\r\n演唱：杨幂、刘恺威]]></Description>");
                            sb.append("    <MusicUrl><![CDATA[http://music.baidu.com/data/music/file?link=http://zhangmenshiting.baidu.com/data2/music/34234515/342340161363129261128.mp3?xcode=6d6be62be71949e3f08f3bb5c5f0aafe]]></MusicUrl>");
                            sb.append("    <HQMusicUrl><![CDATA[http://music.baidu.com/data/music/file?link=http://zhangmenshiting.baidu.com/data2/music/34234511/342340161363129261192.mp3?xcode=6d6be62be71949e3f08f3bb5c5f0aafe]]></HQMusicUrl>");
                            sb.append("  </Music>");
                        } else // 关键字回复
                        {
                            sb.append(WxRule.find(h,t.content));
                        }
                    } else
                    {
                        if(t.type == 2) // 图片
                        {
                            t.url = xml.getString("picurl");
                            t.content = xml.getString("mediaid");
                        } else if(t.type == 3) // 声音
                        {
                            t.content = xml.getString("mediaid");
                        } else if(t.type == 4) // 视频
                        {
                            t.content = xml.getString("mediaid");
                            t.url = xml.getString("thumbmediaid");
                        } else if(t.type == 5) // 地图
                        {
//                            t.x = Double.parseDouble(xml.getString("location_x"));
//                            t.y = Double.parseDouble(xml.getString("location_y"));
//                            t.scale = xml.getInt("scale");
//                            t.content = xml.getString("label");
//                            String str2 = (String) Http.open("http://apis.map.qq.com/ws/geocoder/v1/?location=" + t.x + "," + t.y + "&key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&get_poi=1",null);
//                            JSONObject jo2 = JSON.parseObject(str2);
//                            JSONObject jo3 = jo2.getJSONObject("result");
//
//                            String address = jo3.getString("address");
//                            List list = HotelMeal.find("",0,Integer.MAX_VALUE);
//                            boolean flags = false;
//                            for(int i = 0;i < list.size();i++)
//                            {
//                                HotelMeal hotelMeal = (HotelMeal) list.get(i);
//                                if(hotelMeal.lange == null || hotelMeal.lange.equals(""))
//                                    continue;
//                                double mi = HotelMeal.GetDistance(t.y,t.x,Double.parseDouble(hotelMeal.map.split(",")[0]),Double.parseDouble(hotelMeal.map.split(",")[1]));
//                                if(mi <= Double.parseDouble(hotelMeal.lange))
//                                {
//                                    flags = true;
//                                    break;
//                                }
//                            }
//                            String text = "";
//                            if(flags)
//                            {
//                                text = "这个地址在我们的送餐范围内，现在<a href=\"" + sn + "/mobjsp/hotel/Meals.jsp?hotel_id=15010117&show=1\">开始点餐</a>";
//                            } else
//                            {
//                                text = "这个地址不在我们的送餐范围内，敬请谅解。";
//                            }
//                            String content = "您发送的地址是：“" + address + "”" + text;
//                            sb.append("  <MsgType>text</MsgType>");
//                            sb.append("  <Content><![CDATA[" + content + "]]></Content>");

                        } else if(t.type == 6) // 链接
                        {
                            t.title = xml.getString("title");
                            t.content = xml.getString("description");
                            t.url = xml.getString("url");
                        } else
                        {
                            sb.append("  <MsgType>text</MsgType>");
                            sb.append("  <Content><![CDATA[" + wx.notfound + "<a href=\"http://" + request.getServerName() + "#openid=" + fu.openid + "\"> </a>" + "]]></Content>");
                        }
                    }
                    t.set();
                }
                sb.append("  <FuncFlag>0</FuncFlag>");
                sb.append("</xml>");
                if(encrypt != null)
                    sb = new StringBuilder(enc(sb.toString(),wx.appid[h.getInt("wxtype")]));
                out.print(sb.toString());
            }
        } catch(Throwable ex)
        {
            Filex.logs("WxMessenger_" + request.getServerName() + ".log",ex);
        } finally
        {
            out.close();
        }
    }

    static byte[] AES_KEY;
    static String token = "Token000abcdef"; // d3bb47dc46254d253cad2f3e60ecca73,weixin_token
    static
    {
        try
        {
            AES_KEY = new BASE64Decoder().decodeBuffer("EncodingAESKey000abcdefghijklmnopqrstuvwxyz" + "=");
        } catch(Throwable ex)
        {
        }
    }

    static String enc(String str,String appId) throws Exception
    {
        String timestamp = String.valueOf(System.currentTimeMillis() / 1000);
        String nonce = String.valueOf(tea.entity.util.SCA.random());

        // 拼装
        byte[] by = str.getBytes("utf-8");
        ByteArrayOutputStream ba = new ByteArrayOutputStream();
        for(int i = 0;i < 16;i++)
            // 随机数
            ba.write(by[i]);
        ba.write(Enc.enc(by.length));
        ba.write(by);
        ba.write(appId.getBytes("utf-8"));

        // 补位
        int BLOCK_SIZE = 32;
        int pad = BLOCK_SIZE - (ba.size() % BLOCK_SIZE);
        for(int i = 0;i < pad;i++)
            ba.write(pad);

        // 加密
        Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
        cipher.init(Cipher.ENCRYPT_MODE,new SecretKeySpec(AES_KEY,"AES"),
                    new IvParameterSpec(AES_KEY,0,16));
        by = cipher.doFinal(ba.toByteArray());
        String encrypt = new BASE64Encoder().encode(by).replaceAll("\r\n","");

        // 签名
        String[] arr =
                {token,timestamp,nonce,encrypt};

        return "<xml>\n" + "<Encrypt><![CDATA[" + encrypt + "]]></Encrypt>\n"
                + "<MsgSignature><![CDATA[" + sign(arr)
                + "]]></MsgSignature>\n" + "<TimeStamp>" + timestamp
                + "</TimeStamp>\n" + "<Nonce><![CDATA[" + nonce
                + "]]></Nonce>\n" + "</xml>";
    }

    static String sign(String[] arr)
    {
        StringBuffer sb = new StringBuffer();
        Arrays.sort(arr);
        for(int i = 0;i < arr.length;i++)
            sb.append(arr[i]);
        return Enc.SHA1(sb.toString());
    }

    static String dec(String encrypt) throws Exception
    {
        // 解密
        Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
        cipher.init(Cipher.DECRYPT_MODE,new SecretKeySpec(AES_KEY,"AES"),
                    new IvParameterSpec(AES_KEY,0,16));
        byte[] by = cipher.doFinal(new BASE64Decoder().decodeBuffer(encrypt));

        // 长度
        byte[] len = new byte[4];
        System.arraycopy(by,16,len,0,len.length);

        // 内容
        len = new byte[Enc.dec(len)];
        System.arraycopy(by,20,len,0,len.length);
        return new String(len,"UTF-8");
    }

}
