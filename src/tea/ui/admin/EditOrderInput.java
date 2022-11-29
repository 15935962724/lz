package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.math.BigDecimal;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import tea.entity.member.Profile;
import tea.entity.member.StoredValue;
import tea.entity.member.Trade;
import tea.entity.node.*;
import tea.entity.*;

public class EditOrderInput extends TeaServlet
{

	    //Initialize global variables
	    public void init() throws ServletException
	    {
	    }

	    //Process the HTTP Get request
	    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	    {
	        request.setCharacterEncoding("UTF-8");
	        tea.ui.TeaSession teasession = null;
	        teasession = new tea.ui.TeaSession(request);
	        try
	        {
	        	String act = request.getParameter("act");
	        	String nexul = request.getParameter("nexul");
	        	if("order_input".equals(act)){

		        	String code = request.getParameter("code");
		        	String node = request.getParameter("node");
		        	String sku = request.getParameter("sku");
		        	int number = Integer.parseInt(request.getParameter("number"));//数量
		        	//String dtime = request.getParameter("dtime");

		        	//OrderInput.create(teasession._rv.toString(), code, sku, number, dtime, node, teasession._strCommunity);
		        	Commodity c = Commodity.find_goods(Integer.parseInt(node));
		        	Buy.create(teasession._strCommunity, code, Integer.parseInt(node), c.getCommodity(), 1, number, teasession._rv.toString());


		        	response.sendRedirect("/jsp/admin/phoneorder/order_input.jsp?biaoshi=biao&code="+code);

	        	}

	        	if("order_list".equals(act))
	        	{



	                int supplier =11;//供货商 //Integer.parseInt(request.getParameter("supplier"));
	                BigDecimal total = new BigDecimal(request.getParameter("total")); // 总计
	                String point = teasession._rv.toString();//String.valueOf(total.intValue());//request.getParameter("point");//积分用户

	                BigDecimal freight =new BigDecimal(request.getParameter("freight")); // 运费

	                int currency = 1;//Integer.parseInt(request.getParameter("currency"));//货币类型
	                String state ="11";//request.getParameter("state");//
	                String city = request.getParameter("city");





	                String address = request.getParameter("address");
	                String email = request.getParameter("email");
	                String firstname = request.getParameter("firstname");
	                String lastname = request.getParameter("lastname");
	                String organization = request.getParameter("organization");
	                String zip = request.getParameter("zip");
	                String telephone = request.getParameter("telephone");
	                int ps = 0;//Integer.parseInt(request.getParameter("ps")); // 配送方式
	                int defray = 13;//Integer.parseInt(request.getParameter("defray")); // 支付方式
	                int fp = 0;//Integer.parseInt(request.getParameter("fp"));
	                String fptt = request.getParameter("fptt");
	                String remark = request.getParameter("remark");
	                String buys[] =request.getParameterValues("buys");
	                String spec[] =new String[buys.length]; //request.getParameterValues("spec");
	                String color[] =new String[buys.length];// request.getParameterValues("color");
	                String shopremark[] = new String[buys.length];//request.getParameterValues("shopremark");

	                //验证用户和 密码
	                //Buy b = Buy.find(Integer.parseInt(buys[0]));
	            	String code = request.getParameter("kahao");//卡号
	                String codepw = request.getParameter("codepw");

	                StoredValue sv_obj = StoredValue.find(code);
					if (!sv_obj.isExists() || !sv_obj.getPassword().equals(codepw))
					{
						response.sendRedirect("/jsp/info/Alert.jsp?community=" + teasession._strCommunity + "&info="
								+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "密码错误！请您重新输入"), "UTF-8") + "&nexturl=/jsp/admin/phoneorder/order_list.jsp");
						return;
					}

				    BigDecimal heji = new BigDecimal(0.0D);
	                heji = total.add(freight);
	                if(heji.compareTo(sv_obj.getOutlay())==1)
	                {
	                	 response.sendRedirect("/jsp/info/Alert.jsp?info="+ java.net.URLEncoder.encode("您卡中的余额不足，请充值后购买!","UTF-8"));
	 	                return;
	                }else
	                {
	                	//sv_obj.getOutlay().subtract(total.add(freight));

	                	sv_obj.setOutlay(sv_obj.getOutlay().subtract(total.add(freight)));//减掉费用
	                	//tea.entity.member.StoredValue.create(code, (total.add(freight)), null, null, null, null, "电话购物");

	                }
	                Profile p = Profile.find(code);
					if (!Profile.isExisted(code)) // 如果会员表中不存在福利卡,则播入使其充当会员ID
					{
						//Profile.create(code, teasession._strCommunity, String.valueOf(System.currentTimeMillis()));

					}
					  RV r = new RV(code);



	                p.setState(state, teasession._nLanguage);
	                p.setCity(city, teasession._nLanguage);
	                p.setAddress(address, teasession._nLanguage);
	                p.setEmail(email);
	                p.setFirstName(code, teasession._nLanguage);
	                p.setLastName(lastname, teasession._nLanguage);
	                p.setOrganization(organization, teasession._nLanguage);
	                p.setZip(zip, teasession._nLanguage);
	                p.setTelephone(telephone, teasession._nLanguage);

	                String trade=null;
	              //  String trade = Trade.createByBuys(teasession._strCommunity,  r, 0, point, supplier, total.add(freight), freight, currency, teasession._nLanguage, state, city, address,
                      //      email, firstname, lastname, organization, zip, telephone, remark, ps, defray, fp, fptt, buys, spec, color,shopremark);

	              //  Trade.set(trade, teasession._rv.toString());

	                //修改积分

	                //支付成功，生成订单跳转页面
	                response.sendRedirect("/jsp/admin/phoneorder/order_succeed.jsp?trade="+trade);
	                return;

	        	}

	        }catch (Exception ex)
	        {
	            ex.printStackTrace();
	        }


	    }

	    //Clean up resources
	    public void destroy()
	    {
	    }
}
