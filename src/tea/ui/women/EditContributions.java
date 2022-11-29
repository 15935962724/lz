package tea.ui.women;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.entity.Entity;
import tea.entity.admin.Leavec;
import tea.entity.women.Contributions;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;


public class EditContributions extends TeaServlet
{
	public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		try
		{ 
			TeaSession teasession = new TeaSession(request);
			String nexturl = teasession.getParameter("nexturl");
			String cid = teasession.getParameter("cid");
			Contributions cobj = Contributions.find(cid);
			
				if (teasession.getParameter("EditContributionsDetails") == null)
				{
					int cidtype = Integer.parseInt(teasession.getParameter("cidtype"));
					
					
					
					
					String name = teasession.getParameter("name");
					String mobile=teasession.getParameter("mobile");
					String invoice = teasession.getParameter("invoice");
					String address = teasession.getParameter("address");
					String zip = teasession.getParameter("zip");
					//是否要发票
					int isinvoice =Integer.parseInt(teasession.getParameter("isinvoice"));
					//收件人地址 
					String recipientname = teasession.getParameter("recipientname"); 
					
					//捐赠 详细信息 
					//汇款单登记日期
					Date paytimes = null;
				
					 if(teasession.getParameter("paytimesYear")!=null && teasession.getParameter("paytimesYear").length()>0)
			         {
						 paytimes = Entity.sdf2.parse(teasession.getParameter("paytimesYear") + "-" + teasession.getParameter("paytimesMonth") + "-" + teasession.getParameter("paytimesDay")+" "+teasession.getParameter("paytimesHour")+":"+teasession.getParameter("paytimesMinute"));
			         }
			 
					
					
					
					//财务登记日期
					Date financetime = null;
					 if(teasession.getParameter("financetimeYear")!=null && teasession.getParameter("financetimeYear").length()>0)
			         {
						 financetime = Entity.sdf2.parse(teasession.getParameter("financetimeYear") + "-" + teasession.getParameter("financetimeMonth") + "-" + teasession.getParameter("financetimeDay")+" "+teasession.getParameter("financetimeHour")+":"+teasession.getParameter("financetimeMinute"));
			         }
					//捐赠方式
					int donationmethods = -1;
					if(teasession.getParameter("donationmethods")!=null && teasession.getParameter("donationmethods").length()>0)
					{
						donationmethods =	Integer.parseInt(teasession.getParameter("donationmethods"));
					}
						 
						Integer.parseInt(teasession.getParameter("donationmethods"));
					
					String dmname = teasession.getParameter("dmname");
					//捐赠金额
					BigDecimal paymoney = new BigDecimal("0.00");
					if(teasession.getParameter("paymoney")!=null && teasession.getParameter("paymoney").length()>0){
						paymoney = new BigDecimal(teasession.getParameter("paymoney"));
					}
					int currency= Integer.parseInt(teasession.getParameter("currency"));
					String currencyname = teasession.getParameter("currencyname");
					
					//捐赠要求
					String donation_requested = teasession.getParameter("donation_requested");
					//指定地点
					String designated_place = teasession.getParameter("designated_place");
					// 冠名要求
					String naming_requirements = teasession.getParameter("naming_requirements");
					//收据编号
					String receiptno = teasession.getParameter("receiptno");
					//收据开具日期
					Date receipttime = null;
					
					if(teasession.getParameter("receipttimeYear")!=null && teasession.getParameter("receipttimeYear").length()>0)
			         {
						 receipttime = Entity.sdf2.parse(teasession.getParameter("receipttimeYear") + "-" + teasession.getParameter("receipttimeMonth") + "-" + teasession.getParameter("receipttimeDay")+" "+teasession.getParameter("receipttimeHour")+":"+teasession.getParameter("receipttimeMinute"));
			         }
					
					//是否邮寄
					int whetherthe_mail = Integer.parseInt(teasession.getParameter("whetherthe_mail"));
					//是否退信
					int bounce = Integer.parseInt(teasession.getParameter("bounce")); 
					
					//落实情况
					Date implementationtimes = null;
					if(teasession.getParameter("implementationtimes")!=null && teasession.getParameter("implementationtimes").length()>0){
						implementationtimes = Entity.sdf.parse(teasession.getParameter("implementationtimes"));
					}
					//落实地点
					//省-县
					String imp_ddress_city = teasession.getParameter("imp_ddress_city");
					//村
					String imp_ddress_village = teasession.getParameter("imp_ddress_village");
					//回馈情况
					String feedback = teasession.getParameter("feedback");
					//图片名称
					String imgname = teasession.getParameter("imgname");
					String imgpath = teasession.getParameter("imgpath");
					if(teasession.getParameter("clear_imgpath")!=null)
					{
						imgpath = "";
					}
					//备注
					String remarks = teasession.getParameter("remarks");
					
					if(!cobj.isExist()){
						HttpSession session = request.getSession(true);
						java.text.SimpleDateFormat sdf = new  java.text.SimpleDateFormat("yyyyMMdd");
						java.util.Date timestring = new java.util.Date();
						 cid = sdf.format(timestring)+session.getId().substring(0,4) + tea.entity.SeqTable.getSeqNo("contributionsid");
						Contributions.create(cid,name,mobile,invoice,address,zip,teasession._strCommunity,paymoney,1,donationmethods,isinvoice,recipientname); 
						cobj = Contributions.find(cid);
					}
					 
					 
					
					cobj.set(paytimes, financetime, donationmethods, dmname, currency, currencyname, donation_requested, 
							designated_place, receipttime, whetherthe_mail, bounce, implementationtimes, imp_ddress_city, 
							imp_ddress_village, feedback, imgname, imgpath, remarks,naming_requirements,isinvoice,recipientname);
					
					//修改基本信息 
					cobj.set(name, mobile, invoice, address, zip);
					
					 
					cobj.setAdminmember(teasession._rv._strR,new Date());// 管理员设置时间和用户
					cobj.setCidtype(cidtype,receiptno);//类型和编号
					java.io.PrintWriter out = response.getWriter();
					 
					out.println("<script type=\"text/javascript\" src=\"/tea/ym/ymPrompt.js\"></script>");
					out.println("<link rel=\"stylesheet\" id='skin' type=\"text/css\" href=\"/tea/ym/skin/bluebar/ymPrompt.css\" />");
					out.println("<script>");
					
					out.println("ymPrompt.win({message:'<br><center>信息已经提交成功,正转列表页面...</center>',title:'',width:'300',height:'50',titleBar:false});");
					out.println("setTimeout(\"window.location.href='"+nexturl+"'\", 2000);"); 
					out.println("</script>");   
					
				}
		} catch (Exception exception)
		{
			// response.sendError(400,"新闻添加错误,请检查您的网络是否正常");//exception.toString()
			// response.sendRedirect("/jsp/admin");
			response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您添加的捐款信息出错了,请重新上传&nbsp;<a href=# onClick=\"javascript:history.back()\">返回</a>.", "UTF-8"));
			System.out.println("您添加的捐款信息出错了,请检查您的网络是否正常");
			exception.printStackTrace();
		}
	}
}