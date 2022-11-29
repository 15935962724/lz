package tea.ui.yl.shop;

import tea.SeqShop;
import tea.entity.*;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.*;
import tea.entity.yl.shopnew.ChangeLiziData;
import util.CommonUtils;
import util.Config;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ShopExchangeds extends HttpServlet
{
	public static SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        Http h = new Http(request, response);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        Filex.logs("tuihuo.txt",request.getRequestURL()+"");
		Filex.logs("tuihuo.txt","act="+act);
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        CommonUtils utils = new CommonUtils();
        if (h.member <1 )
        {
        	response.sendRedirect("/servlet/StartLogin?community="+h.community);
        	return;
        }
        try
        {
            
            if ("add".equals(act))
            {
            	out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            	String code=h.get("oid");

                ArrayList<ShopExchanged> shopExchangeds = ShopExchanged.find(" AND order_id=" + Database.cite(code)+" order by time desc ", 0, Integer.MAX_VALUE);
                if(shopExchangeds.size()>0){
                    ShopExchanged shopExchanged = shopExchangeds.get(0);
                    Date createDate = shopExchanged.time;
                    Date date = new Date(System.currentTimeMillis() - 5 * 60 * 1000);
                    if(date.before(createDate)){
                        out.print("<script>mt.show('对不起！此医院退货提交频繁，请关闭页面5分钟后重新提交！',1,'" + nexturl + "');</script>");
                        return;
                    }
                }
                int product_id=h.getInt("product_id");
            	int type=h.getInt("type");
            	int quantity=h.getInt("quantity");
            	String description=h.get("description");
            	String[] pics=h.getValues("picture");
            	if(pics!=null){
					if(1==h.getInt("mobile_tuihuo")&&pics.length>0&&!"".equals(pics)){//手机版退货图片上传
						List<Attch> list = Attch.find("AND path="+Database.cite(h.get("picture")),0,Integer.MAX_VALUE);
						if(list.size()>0){
							Attch a = list.get(0);
							Filex.logs("tuihuo.txt","手机图片attch="+a.attch);
							pics[0]=String.valueOf(a.attch);
						}
					}
				}
				Filex.logs("tuihuo.txt","orderid="+code);
            	ShopOrder so = ShopOrder.findByOrderId(code);
            	String picture="";
            	if(pics!=null){
            		for(int i=0;i<pics.length;i++){
            			picture=picture+"|"+pics[i];
            		}
            	}
            	ShopExchanged se=new ShopExchanged(0);
            	se.description=description;
            	Date date=new Date();
            	se.exchanged_code="GRN"+sdf.format(date)+(new java.util.Random().nextInt(900)+100);  
            	se.orderId=code;
            	se.picture=picture;
            	se.product_id=product_id;
            	se.status=0;
            	se.type=type;
            	se.quantity=quantity;
            	se.member=h.member;
            	se.time=date;
            	se.expressNo=h.get("expressNo");
            	//int mypuid = ShopOrderData.findPuid(code);
            	int mypuid = ShopOrder.findByOrderId(code).getPuid();
            	se.puid = mypuid;//直接取开票单位
            	//se.puid = so.getPuid();
            	boolean flg = h.getBool("pro_type");
            	if(flg)
            		se.pro_type = 1;
            	else
            		se.pro_type = 0;
            	se.set();
            	if(se.pro_type == 1){
            		//订单附加表
	        		ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(code);
	        		//获取短信内容
	        		String content = utils.getSms_content("thsq");

					//ProcurementUnit pu = ProcurementUnit.find(se.puid);
					mypuid = ShopOrderData.findPuid(so.getOrderId());
					ProcurementUnit pu = ProcurementUnit.find(mypuid);

					content = utils.replaceMob(content, "", code, "", "",sod.getA_hospital(),sod.getA_consignees(),"",MT.f(pu.getTelephone()));
					//content = utils.replace(content, "", code, "", "",sod.getA_hospital(),sod.getA_consignees(),"");
	    			content = content.replace("mob", MT.f(pu.getMobile()));
	    			
	    			String user = Profile.find(h.member).getMember();

					//int mypuid1 = se.puid;//默认开票单位
					//查看开票单位 不是同辐
					/*if(Config.getInt("tongfu")==mypuid1){
						mypuid1 = ShopOrderData.findPuid(se.orderId);
					}*/

					ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+mypuid,0,1);
					if(list.size() > 0){
						ShopSMSSetting sms = list.get(0);
						List<String> mobiles = ShopSMSSetting.getUserMobile(sms.thsq);
						if(!"".equals(MT.f(mobiles.toString())))
							SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
					}
	        		Profile profile = Profile.find(h.member);
	        		if(!"".equals(MT.f(profile.mobile,"")))
	    				SMSMessage.create(h.community, user, profile.mobile, h.language, content);
            	}
            	out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
            	return;
            }else if ("madd".equals(act))
            {
            	out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
            	String code=h.get("oid");
            	//是否已经提交过
            	ShopExchanged seObj = ShopExchanged.findByOrderId(code);
            	if(seObj.id > 0){
            		out.print("<script>parent.mt.show('不能重复提交！',1,'" + nexturl + "');</script>");
                	return;
            	}
            	int product_id=h.getInt("product_id");
            	int type=h.getInt("type");
            	int quantity=h.getInt("quantity");
            	String description=h.get("description");
            	String[] pics=h.getValues("picture.attch");
            	String picture="";
            	if(pics!=null){
            		for(int i=0;i<pics.length;i++){
            			picture=picture+"|"+pics[i];
            		}
            	}
            	ShopExchanged se=new ShopExchanged(0);
            	se.description=description;
            	Date date=new Date();
            	se.exchanged_code="GRN"+sdf.format(date)+(new java.util.Random().nextInt(900)+100);  
            	se.orderId=code;
            	se.picture=picture;
            	se.product_id=product_id;
            	se.status=0;
            	se.type=type;
            	se.quantity=quantity;
            	se.member=h.member;
            	se.time=date;
            	se.expressNo=h.get("expressNo");
            	boolean flg = h.getBool("pro_type");
            	if(flg)
            		se.pro_type = 1;
            	else
            		se.pro_type = 0;
            	
            	se.set();
            	if(se.pro_type == 1){
	        		//获取短信内容
					ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(code);
					//获取短信内容
					String content = utils.getSms_content("thsq");
					int mypuid = ShopOrderData.findPuid(sod.getOrder_id());
					ProcurementUnit pu = ProcurementUnit.find(mypuid);
					//ProcurementUnit pu = ProcurementUnit.find(se.puid);
					content = utils.replaceMob(content, "", code, "", "",sod.getA_hospital(),sod.getA_consignees(),"",MT.f(pu.getTelephone()));

					content = content.replace("mob", MT.f(pu.getMobile()));

	    			String user = Profile.find(h.member).getMember();


					//int mypuid = se.puid;//默认开票单位
					//查看开票单位 不是同辐
					if(Config.getInt("tongfu")==mypuid){
						mypuid = ShopOrderData.findPuid(se.orderId);
					}

					ArrayList<ShopSMSSetting> list = ShopSMSSetting.find(" and puid="+mypuid,0,1);
					if(list.size() > 0){
						ShopSMSSetting sms = list.get(0);
						List<String> mobiles = ShopSMSSetting.getUserMobile(sms.thsq);
						if(!"".equals(MT.f(mobiles.toString())))
							SMSMessage.create(h.community, user, mobiles.toString(), h.language, content);
					}



	        		Profile profile = Profile.find(h.member);
	        		if(!"".equals(MT.f(profile.mobile,"")))
	    				SMSMessage.create(h.community, user, profile.mobile, h.language, content);
            	}
            	out.print("<script>parent.mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
            	return;
            } else if ("del".equals(act))
            {
                
            } else if ("upload".equals(act))
            {
            	int battch = h.getInt("file.attch");
        		out.print(battch+"|"+Attch.find(battch).path);
        		return;
            }else if("yesexchange".equals(act)){
            	String orderId = h.get("orderId");
            	ShopExchanged shopexchanged=ShopExchanged.findByOrderId(orderId);
        		//shopexchanged.set("exchangedstatus", "1");//服务商确认
        		//shopexchanged.set("exchangedtime", MT.f(new Date(),1));
        		shopexchanged.exchangedstatus=1;
        		shopexchanged.exchangedtime=new Date();
        		shopexchanged.set();
        		//积分和负数订单
        		if(shopexchanged.type==1){
        			ShopOrder so2 = ShopOrder.findByOrderId(shopexchanged.orderId);
        			//退货减积分
        			try{
        				ShopOrderData sod = ShopOrderData.find(" AND order_id = "+Database.cite(shopexchanged.orderId)+" and product_id = "+shopexchanged.product_id, 0, 1).get(0);
        				double prices = sod.getUnit() * shopexchanged.exchangednum;
        				int status= ShopMyPoints.creatPoint(shopexchanged.member,"退货减积分"+(int)prices,(-(int)prices), null);
        			}catch(Exception e){
        				
        			}

        			if(shopexchanged.exchangednum!=0){
						//退货增加负数数量和负数金额的订单，同时记录当前时间
						//增加shoporder表记录
						ShopOrder neworder=ShopOrder.find(0);
						neworder.setOrderId("PO"+SeqShop.get());
						neworder.setMember(shopexchanged.member);
						neworder.setCreateDate(new Date());//当前确认时间
						neworder.setStatus(7);
						neworder.setReturntime(new Date());
						neworder.setOldorderid(shopexchanged.orderId);
						neworder.setLzCategory(so2.isLzCategory());
						neworder.setPuid(so2.getPuid());
						neworder.set();
						//增加shoporderdata表记录
						List<ShopOrderData> lstolddata=ShopOrderData.find(" and order_id = "+Database.cite(shopexchanged.orderId), 0, Integer.MAX_VALUE);
						if(lstolddata.size()>0){
							ShopOrderData olddata=lstolddata.get(0);//每个订单只有一种产品，所以只取一个
							double danjia=so2.getAmount()/olddata.getQuantity();
							//neworder.setAmount(-(danjia*sec.quantity));//设置订单的amount
							neworder.set("amount", String.valueOf(-(danjia*shopexchanged.exchangednum)));
							neworder.set("noinvoicenum", String.valueOf(-shopexchanged.exchangednum));//未开票数量也为负数
							ShopOrderData newdata=ShopOrderData.find(0);
							newdata.setOrderId(neworder.getOrderId());
							newdata.setProductId(olddata.getProductId());
							newdata.setUnit(olddata.getUnit());
							newdata.setQuantity(-shopexchanged.exchangednum);//负数的退货数量
							newdata.setAmount(-(olddata.getUnit()*shopexchanged.exchangednum));//负数的退货金额
							newdata.setCalibrationDate(olddata.getCalibrationDate());
							newdata.setActivity(olddata.getActivity());
							newdata.setAgent_price_s(olddata.getAgent_price_s());
							newdata.setAgent_price(olddata.getAgent_price());
							newdata.setAgent_amount(-(olddata.getAgent_price()*shopexchanged.exchangednum));//负数的开票金额
							newdata.set();
						}
						//增加ShopOrderDispatch表记录
						ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(neworder.getOrderId());
						ShopOrderDispatch sodold = ShopOrderDispatch.findByOrderId(shopexchanged.orderId);
						//添加收货人地址信息
						sod.setA_consignees(MT.f(sodold.getA_consignees()));
						sod.setA_address(MT.f(sodold.getA_address()));
						sod.setA_mobile(MT.f(sodold.getA_mobile()));
						sod.setA_hospital_id(sodold.getA_hospital_id());
						sod.setA_telphone(MT.f(sodold.getA_telphone()));
						sod.setA_zipcode(MT.f(sodold.getA_zipcode()));

						sod.setA_hospital(MT.f(sodold.getA_hospital())); 		//医院
						sod.setA_department(MT.f(sodold.getA_department()));	//科室
						sod.set();
					}
					//退货导致未开票粒子数减少
					ShopOrderDispatch orderdispatch=ShopOrderDispatch.findByOrderId(orderId);
					ChangeLiziData.jiannoinvoice(orderdispatch.getA_hospital_id(), shopexchanged.exchangednum, new Date(), h.member, shopexchanged.id);
					}


        		out.print("<script>parent.mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
            	return;
            }else if("submit_dele".equals(act)){//取消退货
                int sid = h.getInt("seid");
                ShopExchanged shopExchanged = ShopExchanged.find(sid);
                shopExchanged.delete();
                out.print("<script>parent.mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
                return;
            }
            out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
        } catch (Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
