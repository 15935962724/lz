package tea.ui.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import com.sun.java.swing.plaf.windows.resources.windows;

import tea.db.DbAdapter;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.node.Book;
import tea.entity.node.Node;
import tea.entity.order.Order;
import tea.entity.order.OrderDedail;
import tea.entity.plane.PlaneBooking;
import tea.ui.TeaServlet;
import tea.ui.member.profile.newcaller;

/**
 * 
 * @描述：提交订单
 * @开发人员：
 * @开发时间：2014-2-3 上午9:47:13
 */

public class Orders extends TeaServlet {
	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		Http h = new Http(request);
		SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
		SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf3=new SimpleDateFormat("yyyy-MM");
        PrintWriter out=response.getWriter();
		
		String act = h.get("act");
		String member = h.username;
		String nexturl = h.get("nexturl");
		String snexturl = h.get("snexturl");
		String jinexturl = h.get("jinexturl");
		try {
		if(act.equals("FCsubmit")) {
			Profile p=Profile.find(h.username);
			Date date=h.getDate("date");
			String clock=h.get("clock");
			SimpleDateFormat sf1 = new SimpleDateFormat("HH:mm");
			int planeId=h.getInt("id",0);
			
				if(planeId>0){
					Order o=new Order(0);
					Date submitTime=new Date();
					  o.setCode("FC"+Order.sdf.format(submitTime)+(new java.util.Random().nextInt(900)+100));
					  o.setSubmitTime(submitTime);
					  o.setCustomer(h.get("name",""));
					  o.setSubmitMen(p.getMember());
					  o.setMobile(h.get("mobile", ""));
					  o.setReserveTime(date);
					  o.setBeginTime(sf1.parse(clock));
					  o.setStatus(1);
					  o.community=h.get("community");
					  o.planeId=planeId;
					  o.set();
					  /*OrderDedail od=new OrderDedail(0);
					    od.setSaleOrderId(o.getId());
					    od.setSaleOrderCode(o.getCode());
					    od.setGoodsCode(String.valueOf(planeId));
					    od.setGoodsTitle(pb.name);
					    od.set();*/
					  response.sendRedirect(nexturl+"?id="+o.getId());
					  return;
				}
			
			
			  //
		}else if(act.equals("JKsubmit")) {
			//Profile p=Profile.find(h.username);
			String name=h.get("name");
			int node=h.getInt("node",0);
			if(node>0){
				//PlaneBooking pb=PlaneBooking.find(planeId);
				Order o=new Order(0);
				Date submitTime=new Date();
				  o.setCode("JK"+Order.sdf.format(submitTime)+(new java.util.Random().nextInt(900)+100));
				  o.setSubmitTime(submitTime);
				  o.setSubmitMen(h.get("mobile"));
				  o.setCustomer(name);
				  o.setMobile(h.get("mobile"));
				  o.setAddress(h.get("address"));
				  o.setEmail(h.get("email"));
				  o.setUnitName(h.get("unitName"));
				  o.setIsInvoive(h.getInt("isInvoive"));
				  o.zipCode=h.get("zipCode");
				  o.goway=h.getInt("goway");
				  String startyear=h.get("startyear");
				  String startmonth=h.get("startmonth");
				  String stopyear=h.get("stopyear");
				  String stopmonth=h.get("stopmonth");
				  Date begintime=sdf3.parse(startyear+"-"+startmonth); 
				  Date endtime=sdf3.parse(stopyear+"-"+stopmonth); 
				  o.setBeginTime(begintime);
				  o.setEndTime(endtime);
				  o.setIsPay(0);
				  o.setTotalMoney(BigDecimal.valueOf(h.getDouble("tprice")));
				  o.setStatus(1);
				  o.community=h.get("community");
				  o.set();
				  OrderDedail od=new OrderDedail(0);
				    od.setSaleOrderId(o.getId());
				    od.setSaleOrderCode(o.getCode());
				    od.setGoodsCode(String.valueOf(node));
				    od.setNum(h.getInt("num"));
				    od.setGoodsTitle(Node.find(node).getSubject(h.language));
				    od.set();
				  
					response.reset();
					//response.sendRedirect(nexturl+"?id="+o.getId());
					request.getRequestDispatcher(nexturl+"?id="+o.getId()).forward(request, response);
					return;
				
			}else{
				return;
			}
			
			  //
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (h.member < 1) {
			response.sendRedirect("/servlet/StartLogin?nexturl="
					+ request.getRequestURI());
			return;
		}
		
		try {
			//提交订单
			if (act.equals("submit")) {
				out.println("<script src='/tea/mt.js' type='text/javascript'></script>");
				//out.println("<script src='/tea/view.js' type='text/javascript'></script>");
				BigDecimal totalmaney=new BigDecimal(0);
				String[] ps=h.getCook("cart","|").split("[|]");
				if(ps.length<1)
				{
				  out.print("<script>mt.show('购物车中没有商品，请添加商品后提交订单',1,'"+jinexturl+"')</script>");
				  return;
				}else
				{
				  Profile p=Profile.find(h.username);
				  
				  Order o=new Order(0);
				  if(p.getPersonState()==1){
					  o.setCustomer(p.getConsignee(h.language));
					  o.setMobile(p.getJmobbile());
					  o.setCity(p.getJcity());
					  o.setAddress(p.getJaddress());
					  o.setEmail(p.getJemail());
					  o.setSubmitMen(h.username);
				  }else{
					  out.print("<script>mt.show('对不起，请重新操作')</script>");
					  return;
				  }
				  if(p.getInvouveState()==1){
					  if(p.isInvoive==1){
						  o.isInvoive=p.isInvoive;
						  o.invoiveType=p.invoiveType;
						  o.invoiveContent=p.invoiveContent;
						  o.unitName=p.unitName;
					  }else{
						  o.isInvoive=p.isInvoive;
					  }
				  }else{
					  out.print("<script>mt.show('对不起，请重新操作')</script>");
					  return;
				  }
				  Date submitTime=new Date();
				  o.setCode("O"+Order.sdf.format(submitTime)+(new java.util.Random().nextInt(900)+100));
				  o.setSubmitTime(submitTime);
				  o.setTotalMoney(BigDecimal.valueOf(h.getDouble("totalmaney")));
				  o.setStatus(1);
				  o.community=h.get("community");
				  o.set();
				  for(int i=1;i<ps.length;i++)
				  {
				    String[] arr=ps[i].split("&");
				    Node n=Node.find(Integer.parseInt(arr[0]));
				    if(n.getTime()==null)continue;
				    Book b=Book.find(n._nNode); 
				    totalmaney=totalmaney.add(b.getPrice().multiply(new BigDecimal(Integer.valueOf(arr[1]))));
				    OrderDedail od=new OrderDedail(0);
				    od.setSaleOrderId(o.getId());
				    od.node=Integer.parseInt(arr[0]);
				    od.setSaleOrderCode(o.getCode());
				    od.setGoodsCode(b.getISBN());
				    od.setGoodsSort(b.getType());
				    od.setGoodsTitle(n.getSubject(h.language));
				    od.setNum(Integer.valueOf(arr[1]));
				    od.setMoney(b.getPrice());
				    od.set();
				  }
				  out.print("<script>cookie.set('cart','|');</script>");
				  out.print("<script>window.location.href='"+nexturl+"?jinexturl="+jinexturl+"&id="+Integer.parseInt(ps[1].split("&")[0])+"'</script>");
				  return;
				  
				}
			}else if(act.equals("FTsubmit")) {
				Profile p=Profile.find(h.username);
				Date reserveTime=h.getDate("reserveTime");
				Date beginTime=sdf.parse(h.get("beginTime"));
				Date endTime=sdf.parse(h.get("endTime"));
				int planeId=h.getInt("id",0);
				if(planeId>0){
					//PlaneBooking pb=PlaneBooking.find(planeId);
					Order o=new Order(0);
					Date submitTime=new Date();
					  o.setCode("FT"+Order.sdf.format(submitTime)+(new java.util.Random().nextInt(900)+100));
					  o.setSubmitTime(submitTime);
					  o.setSubmitMen(p.getMember());
					  o.setCustomer(p.getConsignee(h.language));
					  o.setMobile(p.getJmobbile());
					  o.setTotalMoney(BigDecimal.valueOf(h.getDouble("totalmaney")));
					  o.setReserveTime(reserveTime);
					  o.setBeginTime(beginTime);
					  o.setEndTime(endTime);
					  o.setPersonNum(h.getInt("personNum",0));
					  o.setStatus(1);
					  o.setPayType(h.getInt("paytype",0));
					  o.nowPayType=h.getInt("webpaytype",0);
					  o.setIsPay(0);
					  o.planeId=planeId;
					  o.community=h.get("community");
					  o.set();
					  /*OrderDedail od=new OrderDedail(0);
					    od.setSaleOrderId(o.getId());
					    od.setSaleOrderCode(o.getCode());
					    od.setGoodsCode(String.valueOf(planeId));
					    od.setGoodsTitle(pb.name);
					    od.set();*/
					  if (o.getPayType()==0) {
						  if(o.nowPayType==1){
							  response.sendRedirect(jinexturl+"?regid="+o.getId());
						  }
						
						return;
					}else{
						response.reset();
						//response.sendRedirect(nexturl+"?id="+o.getId());
						request.getRequestDispatcher(nexturl+"?id="+o.getId()).forward(request, response);
						return;
					}
				}else{
					return;
				}
				
				  //
			}else if(act.equals("excel")) {
				int status=h.getInt("state",0);
				//out.flush();
				//out.close();
				response.reset();
				response.setContentType("text/html; charset=UTF-8");
				ServletOutputStream s=response.getOutputStream();
				WritableWorkbook ww=Workbook.createWorkbook(s);
				WritableSheet sheet=ww.createSheet("坐班表", 0);
				response.setContentType("application/x-msdownload");
				String name="坐班表.xls";
				response.setHeader("Content-Disposition", "attachment; filename=\"" + new String(name.getBytes("GBK"),"ISO-8859-1") + "\"");
				WritableFont wf= new WritableFont(WritableFont.TIMES, 10,WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
				WritableCellFormat cf=new WritableCellFormat(wf);// 单元格定义
				try {
					cf.setAlignment(jxl.format.Alignment.LEFT);
				} catch (WriteException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} // 设置对齐方式
				// ws.getSettings().setPrintGridLines(true);//是否打印网格线
				int cols=3;
				for(int i=0;i<cols;i++){
					sheet.setColumnView(i, 20); // 设置列的宽度
				}
				String[] showcol=new String[]{"日期","上午","下午"};
				for(int i=0;i<cols;i++){
					try {
						sheet.addCell(new Label(i,0,showcol[i],cf));
					} catch (RowsExceededException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (WriteException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				int j=0;
				Calendar cal = Calendar.getInstance();  
				cal.setTime(new Date());
				
				for(int i=1;i<=7;i++){
					cal.add(Calendar.DAY_OF_YEAR, +1);
					String nextDate = sdf2.format(cal.getTime());
					Enumeration es= Order.find(" and code like "+DbAdapter.cite("FC%")+" and reserveTime="+DbAdapter.cite(nextDate)+" and beginTime<"+DbAdapter.cite(sdf.parse("12:00"))+" and status="+status, 0, Integer.MAX_VALUE);
					Enumeration ex= Order.find(" and code like "+DbAdapter.cite("FC%")+" and reserveTime="+DbAdapter.cite(nextDate)+" and beginTime>"+DbAdapter.cite(sdf.parse("12:00"))+" and status="+status, 0, Integer.MAX_VALUE);
					String sName="";
					String smobile="";
					String xName="";
					String xmobile="";
					String time=MT.f(cal.getTime());
					while(es.hasMoreElements()){
						Order o=Order.find((Integer)es.nextElement());
						sName=o.getCustomer();
						smobile="".equals(o.getMobile())?"":"("+o.getMobile()+")";
					}
					while(ex.hasMoreElements()){
						Order o=Order.find((Integer)ex.nextElement());
						xName=o.getCustomer();
						xmobile="".equals(o.getMobile())?"":"("+o.getMobile()+")";
					}
					
					try {
						
						sheet.addCell(new Label(0,j+1,time));
						sheet.addCell(new Label(1,j+1,sName+smobile));
						sheet.addCell(new Label(2,j+1,xName+xmobile));
						
					
					
					} catch (RowsExceededException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (WriteException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}


					j++;
				}
				ww.write();
				try {
					ww.close();
				} catch (WriteException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				s.close();
			}else if("verify".equals(act)){
				Profile p=Profile.find(h.username);
				if(p.getPersonState()!=1){
					out.print("您还没有保存收货人信息，请保存后提交订单!");
					return;
				}
				if(p.getInvouveState()!=1){
					out.print("您还没有保存发票信息，请保存后提交订单!");
					return;
				}
				String[] ps=h.getCook("cart","|").split("[|]");
				if(ps.length<1)
				{
				  out.print("购物车中没有商品，请添加商品后提交订单!");
				  return;
				}
				out.print("suc");
				return;
			}else{
				int id=h.getInt("id", 0);
				Order order=Order.find(id);
				if("cancel".equals(act)){
					if(id>0){
						
						order.set("cancel_man", h.username);
						order.set("cancel_time",new Date());
						order.set("status", String.valueOf(8));
						out.print("<script>parent.mt.show('订单取消成功！',1,'"+nexturl+"');</script>");
						return;
					}
				}else if("Fcancel".equals(act)){
					
					if(id>0){
						
						order.set("complete_man", h.username);
						order.set("complete_time",new Date());
						order.set("status", String.valueOf(3));
						out.print("<script>parent.mt.show('订单取消成功！',1,'"+nexturl+"');</script>");
						return;
					}
				}else if("Fcomf".equals(act)){
					if(id>0){
						
						order.set("complete_man", h.username);
						order.set("complete_time",new Date());
						order.set("status", String.valueOf(2));
						out.print("<script>parent.mt.show('确认成功！',1,'"+nexturl+"');</script>");
						return;
					}
				}else if("remittance".equals(act)){
					if(id>0){
						
						order.set("payee", h.username);
						order.set("payee_time",new Date());
						order.set("status", String.valueOf(4));
						out.print("<script>parent.mt.show('订单确认汇款成功！',1,'"+nexturl+"');</script>");
						return;
					}
				}//发货
				else if("delivery".equals(act)){
					if(id>0){
						
						order.set("send_man", h.username);
						order.set("send_time",new Date());
						order.set("status", String.valueOf(5));
						out.print("<script>parent.mt.show('订单确认发货成功！',1,'"+nexturl+"');</script>");
						return;
					}
				}
				else if("fill".equals(act)){
					BigDecimal freight=BigDecimal.valueOf(h.getDouble("freight"));
					
					if(id>0){
						
						order.set("freight", String.valueOf(freight));
						order.set("freigh_man", h.username);
						order.set("freight_time", new Date());
						order.set("status", String.valueOf(2));
						out.print("<script>parent.mt.show('订单填写运费成功！',1,'"+nexturl+"');</script>");
						return;
					}
				}
				else if("confirm".equals(act)){
					if(id>0){
						
						order.set("complete_man", h.username);
						order.set("complete_time", new Date());
						order.set("status", String.valueOf(7));
						out.print("<script>parent.mt.show('完成订单成功！',1,'"+nexturl+"');</script>");
						return;
					}
				}
			} 
			//response.sendRedirect("/html/jskxcbs/folder/1-1.htm?nexturl="+nexturl);
			//request.getRequestDispatcher(nexturl+"?jinexturl="+jinexturl).forward(request, response);
			//out.print("<script>window.location.href='"+nexturl+"?jinexturl="+jinexturl+"'</script>");
			response.sendRedirect(nexturl+"?jinexturl="+jinexturl);
		} catch (Exception e) {
          e.printStackTrace();
		}
	}

}
