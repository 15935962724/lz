package tea.ui.node.type.nightshop;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.db.DbAdapter;
import tea.entity.Http;
import tea.entity.RV;
import tea.entity.node.Category;
import tea.entity.node.Event;
import tea.entity.node.NightShop;
import tea.entity.node.Node;
import tea.entity.node.Service;
import tea.htmlx.TimeSelection;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditNightShop extends TeaServlet {

	// String SEPARATOR = System.getProperty("file.separator");
	@Override
	public void init(javax.servlet.ServletConfig servletconfig) throws ServletException {
		super.init(servletconfig);
	}

	@Override
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		OutputStream file = null;
		try {
			Http h = new Http(request);
			if (request.getParameter("mark") != null) // ���
			{
				NightShop nightShop = NightShop.find(h.node, h.language);
				// org.apache.jasper.runtime.JspRuntimeLibrary.introspect(nightShop,
				// request);
				nightShop.setMark();
				// response.sendRedirect("/servlet/NightShop?node=" +
				// h.node);
				if (request.getParameter("nextUrl") != null) {
					response.sendRedirect(request.getParameter("nextUrl"));
				} else {
					response.getWriter().write("<script>window.close();</script>");
				}
				return;
			}
			// response.setContentType("text/html;charset=gb2312");
			if (h.member<1) {
				response.sendRedirect("/servlet/StartLogin?node=" + h.node);
                return;
			}
			if (request.getMethod().equals("GET")) {
				response.sendRedirect("/jsp/type/nightshop/EditNightShop.jsp?" + request.getQueryString());
			} else {
				String name = h.get("name");
				if (name == null || name.length() == 0) {
					response.sendRedirect("/jsp/error/Error.jsp");
				}
				Node node = Node.find(h.node);
				String text = h.get("intro"); // synopsis");
				boolean newnode = h.get("NewNode") != null;
				if (newnode) {
					int sequence = Node.getMaxSequence(h.node) + 10;
					int options1 = 0;
					int typealias = 0;
					String community = node.getCommunity();
					try {
						typealias = Integer.parseInt(h.get("TypeAlias"));
					} catch (Exception exception1) {
					}
					long options = node.getOptions();
					options &= 0xffdffbff;
					int defautllangauge = node.getDefaultLanguage();
					Category cat = Category.find(h.node); // 37
					h.node = Node.create(h.node, sequence, community, new RV(h.username), cat.getCategory(), false, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null, h.language, name, "","", text, null, "", 0, null, "", "", "", "", null, null);
				} else {
					node.set(h.language, name, text);
				}
				
				// 设置跳转参数
				String pid = "0";
				String cid = "0";
				String provinceidhidden = h.get("provinceidhidden");// 省
				String cityidhidden = h.get("cityidhidden");// 省

				if (provinceidhidden != null && !provinceidhidden.equals("0")) {
					pid = provinceidhidden;
				} 
				if (cityidhidden != null && !cityidhidden.equals("0")) {
					cid = cityidhidden;
				}

				NightShop obj = NightShop.find(h.node, h.language);
				String logo = h.get("logo");
				boolean clearLogo = h.get("ClearLogo") != null;
				obj.setType(h.get("type"));
				// obj.setArea(h.get("area"));

				// 设置省市区 商圈地标 2012- 03-13
				String provinceid = h.get("selProvince");// 省

				if (provinceid != null && provinceid.length() > 0) {
					obj.setProvinceid(provinceid);
				} else if(!pid.equals("0")){
					obj.setProvinceid(pid);
				}
				
				String cityid = h.get("selCity");// 市
				if (cityid != null && cityid.length() > 0) {
					obj.setCityid(cityid);
				} else if(!cid.equals("0")){
					obj.setCityid(cid);
				}



				String location = h.get("selLocation");
				obj.setLocation(location);
				String commericial = h.get("selCommericial");
				
				obj.setCommericial(commericial);
				String landmark = h.get("selLandmark");
				obj.setLandmark(landmark);
				// 设置省市区 商圈地标 2012- 03-13
				obj.setMusicType(h.get("musicType"));
				obj.setDeilStyle(h.get("deilStyle"));
				obj.setCircumstance(h.get("circumstance"));
				int nstype1 = 0, nstype2 = 0;
				if (h.get("xpinpai") != null && h.get("xpinpai").length() > 0) {
					nstype1 = Integer.parseInt(h.get("xpinpai"));
				}
				if (h.get("xxinghao") != null && h.get("xxinghao").length() > 0) {
					nstype2 = Integer.parseInt(h.get("xxinghao"));
				}
				obj.setNstype1(nstype1);
				obj.setNstype2(nstype2);

				int options = 0;
				if (h.get("depot") != null) {
					options |= 1;
				}
				// if ( h.get("ticket")!= null)
				// options |= 2;
				if (h.get("open") != null) {
					options |= 4;
				}
				if (h.get("electron") != null) {
					options |= 8;
				}
				String temp[]=h.getValues("serviceNode");
				String ser="|";
				if(temp!=null){
					for(int j=0;j<temp.length;j++){
						ser+=temp[j]+"|";
						Service s=Service.find(Integer.parseInt(temp[j]), 1);
						if(!s.serShops.contains(String.valueOf(h.node)))s.set("serShops", s.serShops+h.node+"|");
					}
					
				}
				if(obj.services!=null){
					String sers[]=obj.services.split("[|]");
					for(int i=1;i<sers.length;i++){
						if(!ser.contains(sers[i])){
							Service s=Service.find(Integer.parseInt(sers[i]), 1);
							s.set("serShops", s.serShops.replace("|"+h.node, ""));
						}
					}
				}
				String tempevent[]=h.getValues("EventNode");
				String event="|";
				if(tempevent!=null){
					for(int j=0;j<tempevent.length;j++){
						event+=tempevent[j]+"|";
						Event s=Event.find(Integer.parseInt(tempevent[j]), 1);
						if(s.serShops==null)s.serShops="|";
						if(!s.serShops.contains(String.valueOf(h.node)))s.set("serShops", s.serShops+h.node+"|");
					}
					
				}
				if(obj.activitys!=null){
					String acts[]=obj.activitys.split("[|]");
					for(int i=1;i<acts.length;i++){
						if(!event.contains(acts[i])){
							Event s=Event.find(Integer.parseInt(acts[i]), 1);
							s.set("serShops", s.serShops.replace("|"+h.node, ""));
						}
					}
				}
				obj.activitys=event;
				obj.services=ser;
				obj.serArea=h.get("serArea","");
				obj.setOptions(options);
				obj.setTicket(h.get("ticket"));
				obj.setSynopsis(h.get("synopsis"));
				obj.setCapability(h.get("capability"));
				obj.setPayment(h.get("payment"));
				obj.setTrait(h.get("trait"));
				obj.setDepreciate(h.get("depreciate"));
				Date practiceHours = TimeSelection.makeTime(h.get("StartYear"), h.get("StartMonth"),
						h.get("StartDay"));
				obj.setPracticeHours(practiceHours);
				obj.setAddress(h.get("address"));
				obj.setPrincipal(h.get("principal"));
				obj.setPhone(h.get("phone"));
				obj.setFax(h.get("fax"));
				obj.setPostalcode(h.get("postalcode"));
				obj.setCooperate(h.get("cooperate"));
				obj.setSponsor(h.get("sponsor"));
				String starthour = h.get("starthour");
				obj.setStartBusinessHours(starthour);
				obj.setEmail(h.get("email"));
				obj.setConsume(h.get("consume"));
				obj.setAcreage(h.get("acreage"));
				obj.setAverageConsume(h.get("averageConsume"));
				obj.setPrice(h.get("price"));
				obj.setAmong(h.get("among"));
				obj.setOperation(h.get("operation"));
				obj.setLoo(h.get("loo"));
				obj.setDestine(h.get("destine"));
				obj.setBlock(h.get("block"));
				obj.setCoverCharge(h.get("coverCharge"));
				obj.setMember(h.get("member"));
				// obj.setBrowse(h.get("browse"));
				obj.setEmail(h.get("email"));
				obj.setMap(h.get("map"));
				if (logo != null) {
					obj.setLogo(logo);
				} else if (clearLogo) {
					obj.setLogo(null);
				}
				obj.set();
				super.delete(node);

				StringBuilder sb = new StringBuilder();

				if (!pid.equals("0")) {
					sb.append("&provinceid=" + pid);
				}
				if (!cid.equals("0")) {
					sb.append("&cityid=" + cid);
				}

				if (h.get("nexturl") != null) {
					response.sendRedirect(h.get("nexturl") + sb.toString());
					return;
				} else {
					if (h.get("GoBack") != null) {
						response.sendRedirect("EditNode?node=" + h.node + sb.toString());
					} else {
						node.finished(h.node);
						response.sendRedirect("NightShop?node=" + h.node + "&edit=ON" + sb.toString());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (file != null) {
				file.close();
			}
		}
	}
}
