package tea.ui.yl.shop;

import com.alibaba.fastjson.JSON;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.json.JSONArray;
import org.json.JSONObject;
import tea.SeqShop;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.admin.orthonline.Hospital;
import tea.entity.member.ModifyRecord;
import tea.entity.member.Profile;
import tea.entity.yl.shop.*;
import tea.entity.yl.shopnew.Invoice;
import tea.entity.yl.shopnew.InvoiceData;
import tea.entity.yl.shopnew.SetDataRecord;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 医院
 * */
public class ShopHospitals extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("text/html; charset=UTF-8");
		Http h = new Http(req, resp);
		JSONObject jo = new JSONObject();
		String act = h.get("act"), nexturl = h.get("nexturl", "");
		try {
			if ("hospitalexp".equals(act)) {
				resp.setContentType("application/x-msdownload");
				resp.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("已设置代理商医院" + ".xls", "UTF-8"));
				javax.servlet.ServletOutputStream os = resp.getOutputStream();
				jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
				jxl.write.WritableSheet ws = wwb.createSheet("已设置代理商医院", 0);
				int index = 0;
				ws.addCell(new jxl.write.Label(index++, 0, "医院名称"));
				ws.addCell(new jxl.write.Label(index++, 0, "服务商"));
				ws.addCell(new jxl.write.Label(index++, 0, "价格"));

				String sql = h.get("sql");
				List<Profile> lstp = Profile.find1(sql, 0, Integer.MAX_VALUE);
				int hang = 0;
				for (int i = 0; i < lstp.size(); i++) {
					Profile profile = lstp.get(i);
					String hospitals = profile.hospitals;
					String[] hospitalarr = hospitals.split("[|]");
					for (int j = 1; j < hospitalarr.length; j++) {
						String hid = hospitalarr[j];
						if (hid != "") {
							ShopHospital hospital = ShopHospital.find(Integer.parseInt(hid));
							hang++;
							index = 0;
							float price = 0;
							// 医院开票价
							/*
							 * List<ShopOrderDispatch>
							 * lstdis=ShopOrderDispatch.find
							 * (" and a_hospital_id="+hospital.getId(), 0,
							 * Integer.MAX_VALUE); float price=0; for(int
							 * a=0;a<lstdis.size();a++){ ShopOrderDispatch
							 * dispatch=lstdis.get(a); String
							 * orderid=dispatch.getOrder_id(); ShopOrder
							 * order=ShopOrder.findByOrderId(orderid);
							 * if(order.getStatus()!=5&&order.getStatus()!=6){
							 * List<ShopOrderData>
							 * lstodata=ShopOrderData.find(" and order_id="
							 * +DbAdapter.cite(order.getOrderId()), 0, 1);
							 * if(lstodata.size()>0){ ShopOrderData
							 * odata=lstodata.get(0);
							 * price=odata.getAgent_price(); if(price!=0){
							 * break; }
							 * 
							 * }
							 * 
							 * } }
							 */
							List<ShopProduct> lstproduct = ShopProduct.find(" and yucode=" + Database.cite("GMS-6711<0.8"), 0, 1);
							int productid = 0;
							if (lstproduct.size() > 0) {
								ShopProduct product = lstproduct.get(0);
								productid = product.product;
							}
							List<ShopPriceSet> lstset = ShopPriceSet.find(" and hospital_id=" + hospital.getId() + " and product_id=" + productid, 0, Integer.MAX_VALUE);
							if (lstset.size() > 0) {
								ShopPriceSet set = lstset.get(0);
								price = set.agentPrice;
							}
							ws.addCell(new jxl.write.Label(index++, hang, MT.f(hospital.getName())));
							ws.addCell(new jxl.write.Label(index++, hang, MT.f(profile.getMember())));
							ws.addCell(new jxl.write.Label(index++, hang, MT.f(price, 2)));
						}

					}

				}
				wwb.write();
				wwb.close();
				os.close();
				return;

			}
		} catch (Exception e) {
			// TODO: handle exception
		}

		PrintWriter out = resp.getWriter();

		if ("checkinvoice".equals(act)) {
			int hospitalid = h.getInt("hospitalid");
			Date timespot = h.getDate("timespot");
			String date = MT.f(timespot);
			// 查找当前医院的发票
			List<ShopOrder> lst = ShopOrder.find(" and order_id in(select order_id from shoporderdispatch where a_hospital_id=" + hospitalid + ")and createdate<" + Database.cite(date), 0,
					Integer.MAX_VALUE);
			for (int i = 0; i < lst.size(); i++) {
				ShopOrder order = lst.get(i);
				String orderid = order.getOrderId();
				List<InvoiceData> lstdata = InvoiceData.find(" and orderid=" + Database.cite(orderid) + " and status = 0 ", 0, Integer.MAX_VALUE);
				if (lstdata.size() > 0) {
					out.print("1");
					break;
				}
			}
			return;
		} else if ("findShopHospital".equals(act)) {
			try {
				int page_size = h.getInt("page_size");
				int pos = h.getInt("pos");
				// String parameterStr = YlUtil.getAllPar(req, h);

				StringBuffer sql = new StringBuffer("");
				String name = h.get("name");
				if (!"".equals(name) && name != null) {
					sql.append(" AND name like'%" + name + "%'");
				}
				String area = h.get("area");
				if (!"".equals(area) && area != null) {
					sql.append(" AND area ='" + area + "'");
				}
				String htype = h.get("htype");
				if (!"".equals(htype) && htype != null) {
					sql.append(" AND htype ='" + htype + "'");
				}
				String hgrader = h.get("hgrader");
				if (!"".equals(hgrader) && hgrader != null) {
					sql.append(" AND hgrader ='" + hgrader + "'");
				}
				String deadline = h.get("deadline");
				if (!"".equals(deadline) && deadline != null) {
					sql.append(" AND datediff(d,getdate(),expirationDate) <= " + deadline);
				}

				int issign = h.getInt("issign", -1);
				if (issign != -1) {
					sql.append(" and issign=" + issign);
				}

				int sum = ShopHospital.count(sql.toString());

				// int sum = 0;
				int is_load_finish = sum <= pos + page_size ? 1 : 0;
				if (sum == 0)
					is_load_finish = 0;
				StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");
				if (sum > 0) {
					// jsonSb.append(ja.get("tblist"));
					JSONArray ja = new JSONArray();

					try {
						List<ShopHospital> list = ShopHospital.find(sql.toString(), pos, page_size);
						for (int i = 0; i < list.size(); i++) {
							ShopHospital sh = list.get(i);
							JSONObject jo2 = new JSONObject();
							jo2.put("obj", JSON.toJSON(sh));
							ja.put(jo2);
						}
					} catch (Exception e) {

					}
					jsonSb.append(ja);
				} else {
					jsonSb.append("\"\"");
				}
				jsonSb.append(",\"type\":\"0\"}");
				out.print(jsonSb.toString());
				return;
			} catch (Exception e) {
				Filex.logs("member.txt", "Members:" + act + "e" + e);
				jo.put("type", "2");
				jo.put("mes", "系统异常，请重试！");
				out.print(jo.toString());
				return;
			}
		} else if ("findhosids".equals(act)) {
			try {
				StringBuffer sql = new StringBuffer("");
				Profile profile = Profile.find(h.member);
				String[] hoarr = profile.hospitals.split("\\|");
				int sum = hoarr.length;
				int is_load_finish = 0;
				if (sum == 0)
					is_load_finish = 0;
				StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");
				if (sum > 0) {
					JSONArray ja = new JSONArray();
					try {
						if (hoarr.length < 1) {
						} else {
							for (int i = 1; i < hoarr.length; i++) {
								ShopHospital s1 = ShopHospital.find(Integer.parseInt(hoarr[i]));
								JSONObject jo2 = new JSONObject();
								jo2.put("obj", JSON.toJSON(s1));
								ja.put(jo2);
							}
						}
					} catch (Exception e) {

					}
					jsonSb.append(ja);
				} else {
					jsonSb.append("\"\"");
				}
				jsonSb.append(",\"type\":\"0\"}");
				out.print(jsonSb.toString());
				return;
			} catch (Exception e) {
				Filex.logs("member.txt", "Members:" + act + "e" + e);
				jo.put("type", "2");
				jo.put("mes", "系统异常，请重试！");
				out.print(jo.toString());
				return;
			}
		} else if ("findpusids".equals(act)) {
			try {
				StringBuffer sql = new StringBuffer();
				Profile p = Profile.find(h.member);
				if (p.membertype == 2||p.membertype==3) {
					sql.append(" AND profile = " + h.member);
				}

				int hosid = h.getInt("hosid");
				if (hosid > 0) {
					String prostr = "";
					List<Integer> pros = ProcurementUnit.findHospJoin(hosid);
					for (int i = 0; i < pros.size(); i++) {
						if (i > 0) {
							prostr += ",";
						}
						prostr += pros.get(i);
					}
					if (prostr.length() > 0) {
						sql.append(" AND puid in (" + prostr + ")");
					}
				}
				// String pustr = "";
				if (p.membertype == 2||p.membertype==3) {
					// List<ProcurementUnitJoin> pujlist =
					// ProcurementUnitJoin.find(sql.toString(), 0,
					// Integer.MAX_VALUE);
					ShopHospital sh = ShopHospital.find(hosid);

					// int sum = pujlist.size();
					int sum = 1;
					int is_load_finish = 0;
					if (sum == 0) {
						is_load_finish = 0;
					}
					StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");
					if (sum > 0) {
						JSONArray ja = new JSONArray();
						try {
							/*
							 * if(pujlist.size()<1) { }else {
							 */
							// for(int i=0;i<pujlist.size();i++){
							// ProcurementUnitJoin puj = pujlist.get(i);
							ProcurementUnit pu = ProcurementUnit.find(sh.getProductPuid());
							JSONObject jo2 = new JSONObject();
							jo2.put("obj", JSON.toJSON(pu));
							ja.put(jo2);
							// pustr += "<option>"+pu.getName()+"</option>";
							/*
							 * } }
							 */
						} catch (Exception e) {

						}
						jsonSb.append(ja);
					} else {
						jsonSb.append("\"\"");
					}
					jsonSb.append(",\"type\":\"0\"}");
					out.print(jsonSb.toString());

				} else {

					List<ProcurementUnit> pujlist = ProcurementUnit.find(sql.toString(), 0, Integer.MAX_VALUE);

					int sum = pujlist.size();
					int is_load_finish = 0;
					if (sum == 0) {
						is_load_finish = 0;
					}
					StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");
					if (sum > 0) {
						JSONArray ja = new JSONArray();
						try {
							if (pujlist.size() < 1) {
							} else {
								for (int i = 0; i < pujlist.size(); i++) {
									ProcurementUnit pu = pujlist.get(i);
									JSONObject jo2 = new JSONObject();
									jo2.put("obj", JSON.toJSON(pu));
									ja.put(jo2);
									// pustr +=
									// "<option>"+pu.getName()+"</option>";
								}
							}
						} catch (Exception e) {

						}
						jsonSb.append(ja);
					} else {
						jsonSb.append("\"\"");
					}
					jsonSb.append(",\"type\":\"0\"}");
					out.print(jsonSb.toString());

				}

				return;
			} catch (Exception e) {
				Filex.logs("member.txt", "Members:" + act + "e" + e);
				jo.put("type", "2");
				jo.put("mes", "系统异常，请重试！");
				out.print(jo.toString());
				return;
			}
		} else if ("findproduct".equals(act)) {
			try {
				StringBuffer sql = new StringBuffer(" AND profile = " + h.member);
				int pusid = h.getInt("pusid");

				int category = h.getInt("category");
				List<ShopProductModel> spmlist = ShopProductModel.find(" AND category = " + category, 0, 100);
				/*
				 * if(spmlist.size()>0){ for(int i=0;i<spmlist.size();i++){
				 * ShopProductModel spm = spmlist.get(i); ShopProduct sp =
				 * ShopProduct.findpuid(pusid,spm.getId()); if(sp.product>0) {
				 * 
				 * }
				 * //out.println("<i "+(spm.getId()==p.model_id?"class='bgred'"
				 * :""
				 * )+"><a href='/html/folder/19041058-1.htm?product="+sp.product
				 * +"' target='_parent'>"+spm.getModel()+"</a></i>"); }
				 * 
				 * }
				 */

				int sum = spmlist.size();

				int is_load_finish = 0;
				if (sum == 0)
					is_load_finish = 0;
				StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");
				if (sum > 0) {
					JSONArray ja = new JSONArray();
					try {
						if (spmlist.size() < 1) {
						} else {
							for (int i = 0; i < spmlist.size(); i++) {
								ShopProductModel spm = spmlist.get(i);
								ShopProduct sp = ShopProduct.findpuid(pusid, spm.getId());
								JSONObject jo2 = new JSONObject();
								if (sp.product > 0) {
									System.out.println(sp);
									jo2.put("product", sp.product);
									jo2.put("model", spm.getModel());

									// jo2.put("obj", );
									ja.put(jo2);
								}
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
					jsonSb.append(ja);
				} else {
					jsonSb.append("\"\"");
				}
				jsonSb.append(",\"type\":\"0\"}");
				out.print(jsonSb.toString());
				return;
			} catch (Exception e) {
				Filex.logs("member.txt", "Members:" + act + "e" + e);
				jo.put("type", "2");
				jo.put("mes", "系统异常，请重试！");
				out.print(jo.toString());
				return;
			}
		} else if ("findHosp".equals(act)) {
			try {
				int hid = h.getInt("hid");
				ShopHospital sh = ShopHospital.find(hid);
				jo.put("type", "0");
				jo.put("obj", JSON.toJSON(sh));
			} catch (Exception e) {
				e.printStackTrace();
				jo.put("type", "2");
				jo.put("mes", "系统异常，请重试！");
			}
			out.print(jo.toString());
			return;
		} else if ("editHosp".equals(act)) {
			try {
				int hid = h.getInt("hid");
				ShopHospital sh = ShopHospital.find(hid);

				sh.setName(h.get("name"));
				sh.setArea(h.get("area"));
				sh.setArea_name(h.get("area_name"));
				sh.setHtype(h.get("htype"));
				sh.setHgrader(h.get("hgrader"));
				sh.setAddflag(h.getInt("addflag"));
				sh.setCreatetime(new Date());
				sh.setIssign(h.getInt("issign"));
				String noreplywarnstr = h.get("noreplywarn", "-1");
				float noreplywarn = -1;
				if (noreplywarnstr != "-1") {
					noreplywarn = h.getFloat("noreplywarn");
				}
				String noreplyalarmstr = h.get("noreplyalarm", "-1");
				float noreplyalarm = -1;
				if (noreplyalarmstr != "-1") {
					noreplyalarm = h.getFloat("noreplyalarm");
				}

				sh.setNoreplywarn(noreplywarn);
				sh.setNoreplyalarm(noreplyalarm);
				sh.setNoinvoicewarn(h.getInt("noinvoicewarn", -1));
				sh.setNoinvoicealarm(h.getInt("noinvoicealarm", -1));
				// 三期新加（未开票粒子数、已开票粒子数、应收账款的初始值为-1）
				sh.setOldnoinvoice(-1);
				sh.setOldisinvoice(-1);
				sh.setOldnoreply(-1.0);
				sh.set();

				jo.put("type", "0");
			} catch (Exception e) {
				e.printStackTrace();
				jo.put("type", "2");
				jo.put("mes", "系统异常，请重试！");
			}
			out.print(jo.toString());
			return;
		} else if ("getpage".equals(act)) {
			// org.json.JSONObject jo = new org.json.JSONObject();
			int pos = h.getInt("pos");
			int sum = h.getInt("sum");
			int size = h.getInt("size");
			// String par = h.get("par");
			String par = "";
			par = URLDecoder.decode(par, "UTF-8");
			par = par.toString().replaceFirst("pos=", "&");
			if (par.indexOf("?") != -1) {
				par += "&pos=";
			} else {
				par += "?pos=";
			}
			String str = new tea.htmlx.FPNL(1, par, pos, sum, size).toString();
			jo.put("data", str);
			if (str.length() > 0) {
				jo.put("type", "0");
			} else {
				jo.put("type", "1");
			}
			out.println(jo.toString());
			return;
		}
		try {

			out.println("<script>var mt=parent.mt,doc=parent.document;</script>");
			int id = h.getInt("id");
			if ("edit".equals(act)) {
				nexturl = "/jsp/yl/shop/ShopHospitals.jsp";
				ShopHospital sh = ShopHospital.find(id);
				sh.setName(h.get("name"));
				String s = h.get("name");
				if (id == 0) {// 新增
					ArrayList<ShopHospital> shopHospitals = ShopHospital.find(" AND name=" + DbAdapter.cite(s), 0, Integer.MAX_VALUE);
					if (shopHospitals.size() > 0) {// 已存在
						out.print("<script>mt.show('添加失败，医院名已存在！');</script>");
						return;
					}
				}
				sh.setArea(h.get("area"));
				sh.setArea_name(h.get("area_name"));
				sh.setHtype(h.get("htype"));
				sh.setHgrader(h.get("hgrader"));
				sh.setAddflag(h.getInt("addflag"));
				sh.setCreatetime(new Date());
				sh.setIssign(h.getInt("issign"));
				String noreplywarnstr = h.get("noreplywarn", "-1");
				String h_code = h.get("h_code");
				sh.setH_code(h_code);
				float noreplywarn = -1;
				if (noreplywarnstr != "-1") {
					noreplywarn = h.getFloat("noreplywarn");
				}
				String noreplyalarmstr = h.get("noreplyalarm", "-1");
				float noreplyalarm = -1;
				if (noreplyalarmstr != "-1") {
					noreplyalarm = h.getFloat("noreplyalarm");
				}

				sh.setNoreplywarn(noreplywarn);
				sh.setNoreplyalarm(noreplyalarm);
				sh.setNoinvoicewarn(h.getInt("noinvoicewarn", -1));
				sh.setNoinvoicealarm(h.getInt("noinvoicealarm", -1));
				// 三期新加（未开票粒子数、已开票粒子数、应收账款的初始值为-1）
				sh.setOldnoinvoice(-1);
				sh.setOldisinvoice(-1);
				sh.setOldnoreply(-1.0);
				sh.set();

			} else if ("editendtime".equals(act)) {
				ShopHospital sh = ShopHospital.find(id);
				int oldisinvoice = h.getInt("oldisinvoice", -1);// 已开票粒数
				int oldnoinvoice = h.getInt("oldnoinvoice", -1);// 未开票粒数

				Date timespot = h.getDate("timespot");// 未开票粒子数时间节点

				sh.setOldnoinvoice(oldnoinvoice);
				sh.setOldisinvoice(oldisinvoice);
				sh.setTimespot(timespot);

				sh.set();
				if (oldnoinvoice > -1) {
					// 改变订单开始
					int fmember = 0;// 服务商id
					List<ShopOrder> lstshoporder = ShopOrder.find(" and order_id in(select order_id from shoporderdispatch where a_hospital_id=" + sh.getId() + ") order by createdate desc", 0, 1);
					if (lstshoporder.size() > 0) {
						fmember = lstshoporder.get(0).getMember();
					}
					String orderunit = "";// 服务商名称
					double agentprice = 0;// 服务商价格
					float agentprice2 = 0;// 服务商开票价格
					double agentprice3 = 0;// 医院开票价格

					List<ShopProduct> lstShopProduct = ShopProduct.find(" and yucode=" + DbAdapter.cite("GMS-6711<0.8"), 0, Integer.MAX_VALUE);
					ShopProduct p = new ShopProduct(0);
					if (lstShopProduct.size() > 0) {
						p = lstShopProduct.get(0);
					}
					ShopPriceSet sps1 = ShopPriceSet.find(sh.getId(), p.product, 0); // 代理商显示价
					// ShopPriceSet sps1 = ShopPriceSet.find(1,p.product,0);
					// //代理商显示价
					agentprice = sps1.price;
					ShopPriceSet sps = ShopPriceSet.find(sh.getId(), p.product, 0); // 代理商医院开票价
					if (sps.price > 0) {
						agentprice3 = sps.price; // 医院的开票价
					}
					if (sps.agentPrice > 0) {
						agentprice2 = sps.agentPrice; // 代理商开票价
					}
					if (timespot != null && oldnoinvoice >= 0) {
						// 查询日期节点之前的所有订单
						List<ShopOrder> lstorder = ShopOrder.find(
								" and order_id in(select order_id from shoporderdispatch where a_hospital_id=" + sh.getId() + ")and createdate <=" + DbAdapter.cite(MT.f(timespot)), 0,
								Integer.MAX_VALUE);
						if (lstorder.size() > 0) {
							Profile profile = Profile.find(fmember);
							orderunit = profile.getMember();

							for (int i = 0; i < lstorder.size(); i++) {
								ShopOrder order = lstorder.get(i);
								order.set("isclear", "1");

							}
						}
						// 生成订单
						ShopOrder so = ShopOrder.find(0);
						so.setOrderId("PO" + SeqShop.get());
						so.setMember(fmember);
						so.setAmount(agentprice * oldnoinvoice);
						so.setPayType(0);
						so.setPayment(false);
						so.setCreateDate(timespot);
						so.setStatus(4);
						so.setLzCategory(true);
						so.setOrderUnit(orderunit);
						so.setRemarks(sh.getName() + "医院截止至" + MT.f(timespot) + "未开票数量：" + oldnoinvoice);
						so.setInvoiceStatus(0);
						so.setNoinvoicenum(oldnoinvoice);
						so.setNoinvoiceamount(agentprice2 * oldnoinvoice);
						so.setIsinvoicenum(0);
						so.setIsinvoiceamount(0);
						so.setIshidden(1);
						so.set();
						ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
						// 添加收货人地址信息
						sod.setA_hospital_id(sh.getId());
						sod.setA_hospital(sh.getName()); // 医院
						sod.set();
						// 添加订单附加表
						ShopOrderData sodata = new ShopOrderData(0);
						sodata.setOrderId(so.getOrderId());
						sodata.setProductId(0);
						sodata.setQuantity(oldnoinvoice);
						sodata.setUnit(agentprice3);
						sodata.setAmount((double) agentprice3 * oldnoinvoice);
						sodata.setAgent_price_s((float) agentprice);
						sodata.setAgent_price(agentprice2);
						sodata.setAgent_amount(agentprice2 * oldnoinvoice);
						sodata.set();
					}
				}

				// 增加三期预设数据改变记录
				int ordernum = 0;
				List<SetDataRecord> lstre = SetDataRecord.find(" and hospitalid = " + id, 0, Integer.MAX_VALUE);
				SetDataRecord record = new SetDataRecord(0);
				record.setHospitalid(id);
				record.setIsback(0);
				record.setNoinvoice(oldnoinvoice);
				record.setTimespot(timespot);
				record.setNoreply(-1.0);
				record.setMember(h.member);
				record.setCreatedate(new Date());
				record.setIsinvoice(oldisinvoice);
				record.setOrdernum(lstre.size() + 1);
				record.set();
			} else if ("editendtime2".equals(act)) {
				// 后台提交应收账款
				ShopHospital sh = ShopHospital.find(id);
				Double oldnoreply = h.getDouble("oldnoreply");// 应收账款
				Date timespot2 = h.getDate("timespot2");// 应收账款时间节点
				sh.setOldnoreply(oldnoreply);
				sh.setTimespot2(timespot2);
				sh.setOldnoreplynew(oldnoreply);
				sh.setCreplytime(new Date());
				sh.set();

				// 增加三期预设数据改变记录
				int ordernum = 0;
				List<SetDataRecord> lstre = SetDataRecord.find(" and hospitalid = " + id, 0, Integer.MAX_VALUE);
				SetDataRecord record = new SetDataRecord(0);
				record.setHospitalid(id);
				record.setIsback(3);// 应收账款增加
				record.setNoreply(oldnoreply);
				record.setNoinvoice(-1);
				record.setIsinvoice(-1);
				record.setTimespot2(timespot2);
				record.setMember(h.member);
				record.setCreatedate(new Date());
				record.setStatus(0);// 后台编辑
				record.setOrdernum(lstre.size() + 1);
				record.set();

			} else if ("delendtime".equals(act)) {
				// 清除未开票粒子数等
				// 先改变医院
				ShopHospital sh = ShopHospital.find(id);
				sh.setOldnoinvoice(-1);
				sh.setOldisinvoice(-1);
				sh.setTimespot(null);
				sh.set();
				// 改变订单
				List<ShopOrder> lstorder = ShopOrder.find(" and ishidden=1 and order_id in(select order_id from shoporderdispatch where a_hospital_id=" + sh.getId() + ")", 0, Integer.MAX_VALUE);
				// 删除生成的订单
				if (lstorder.size() > 0) {
					ShopOrder order = lstorder.get(0);
					ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(order.getOrderId());
					sod.delete();
					List<ShopOrderData> lstdata = ShopOrderData.find(" and order_id=" + Database.cite(order.getOrderId()), 0, Integer.MAX_VALUE);
					if (lstdata.size() > 0) {
						ShopOrderData data = lstdata.get(0);
						data.delete();
					}
					order.delete();
				}
				// 修改isclear=1的订单
				List<ShopOrder> lstorder2 = ShopOrder.find(" and isclear=1 and order_id in(select order_id from shoporderdispatch where a_hospital_id=" + sh.getId() + ")", 0, Integer.MAX_VALUE);
				for (int i = 0; i < lstorder2.size(); i++) {
					ShopOrder order = lstorder2.get(i);
					order.set("isclear", "0");
				}
				// 增加三期预设数据改变记录
				List<SetDataRecord> lstre = SetDataRecord.find(" and hospitalid = " + id, 0, Integer.MAX_VALUE);
				SetDataRecord record = new SetDataRecord(0);
				record.setHospitalid(id);
				record.setIsback(1);// 退回粒子数操作
				record.setNoinvoice(-1);
				record.setNoreply(-1.0);
				record.setTimespot(null);

				record.setMember(h.member);
				record.setCreatedate(new Date());
				record.setIsinvoice(-1);
				record.setOrdernum(lstre.size() + 1);
				record.set();

			} else if ("delendtime2".equals(act)) {
				// 清除应收账款
				// 先改变医院
				ShopHospital sh = ShopHospital.find(id);

				sh.setOldnoreply(-1.0);
				sh.setTimespot2(null);
				sh.setOldnoreplynew(-1.0);// 最新应收账款
				sh.setCreplytime(null);
				sh.set();
				// 增加三期预设数据改变记录
				List<SetDataRecord> lstre = SetDataRecord.find(" and hospitalid = " + id, 0, Integer.MAX_VALUE);
				SetDataRecord record = new SetDataRecord(0);
				record.setHospitalid(id);
				record.setIsback(2);// 退回账款操作
				record.setNoreply(-1.0);
				record.setNoinvoice(-1);
				record.setTimespot2(null);
				record.setMember(h.member);
				record.setCreatedate(new Date());
				record.setStatus(0);// 后台编辑
				record.setOrdernum(lstre.size() + 1);
				record.set();

			} else if ("del".equals(act)) {
				// ShopHospital sh = ShopHospital.find(id);
				ShopHospital.delete(id);
			} else if ("setExpirationDate".equals(act)) {
				ShopHospital sh = ShopHospital.find(id);
				Date expirationDate = h.getDate("expirationDate");
				sh.set("expirationDate", expirationDate);
			} else if ("setissign".equals(act)) {
				// 改变签收设置
				String ids = h.get("id");
				if (ids.indexOf(",") > -1) {
					// 批量提交
					String[] idsarr = ids.split(",");
					for (int i = 0; i < idsarr.length; i++) {
						int ids2 = Integer.parseInt(idsarr[i]);
						ShopHospital sh = ShopHospital.find(ids2);

						int s = sh.getIssign();
						if (s == 0) {
							sh.set("issign", "1");
						} else {
							sh.set("issign", "0");
						}
					}
				} else {
					// 单独提交
					int ids2 = Integer.parseInt(ids);
					ShopHospital sh = ShopHospital.find(ids2);

					int s = sh.getIssign();
					if (s == 0) {
						sh.set("issign", "1");
					} else {
						sh.set("issign", "0");
					}
				}
			} else if ("stoporder".equals(act)) {
				ShopHospital hospital = ShopHospital.find(id);
				hospital.set("isstoporder", "1");

			} else if ("nostoporder".equals(act)) {
				ShopHospital hospital = ShopHospital.find(id);
				hospital.set("isstoporder", "0");
			} else if ("editName".equals(act)) {
				ShopHospital hospital = ShopHospital.find(id);
				String newname = h.get("name");// 名称
				int attch = h.getInt("namefile.attch");
				HospitalNameChange hc = HospitalNameChange.find(0);
				hc.setHospitalid(id);
				hc.setNewname(newname);
				hc.setOldname(hospital.getName());
				hc.setMember(h.member);
				hc.setCreatedate(new Date());
				// hc.set();
				// 查询当前医院的订单,然后更改订单的医院名字
				StringBuffer orderId = new StringBuffer("");
				List<ShopOrderDispatch> lstorder = ShopOrderDispatch.find(" and a_hospital_id = " + id, 0, Integer.MAX_VALUE);
				for (int i = 0; i < lstorder.size(); i++) {
					ShopOrderDispatch dis = lstorder.get(i);
					String orderid = dis.getOrder_id();
					orderId.append(orderid + ",");
					dis.set("a_hospital", newname);
				}
				hc.setOrderId(orderId.toString());
				// 查询当前医院的发票
				StringBuffer invoiceId = new StringBuffer("");
				List<Invoice> lstinvoice = Invoice.find(" and hospitalid=" + id, 0, Integer.MAX_VALUE);
				for (int i = 0; i < lstinvoice.size(); i++) {
					Invoice invoice = lstinvoice.get(i);
					int invoiceid = invoice.getId();
					invoiceId.append(invoiceid + ",");
					invoice.set("hospital", newname);
				}
				hc.setInvoiceid(invoiceId.toString());
				hc.set();
				hospital.set("name", newname);
				hospital.set("namefile", attch);
				// 查询医院签收人，更改签收人表中的医院名称
				ArrayList<ShopOrderAddress> shopOrderAddresses = ShopOrderAddress.find("AND hospitalId = " + id, 0, Integer.MAX_VALUE);
				for (int i = 0; i < shopOrderAddresses.size(); i++) {
					ShopOrderAddress sh = shopOrderAddresses.get(i);
					sh.setHospital(newname);
					sh.set();
				}

			} else if ("uploadfile".equals(act)) {
				int attchid = h.getInt("execl.attch");
				nexturl += "?attchid=" + attchid;
				out.print("<script>location='" + nexturl + "';</script>");
				// out.print("<script>mt.show('操作执行成功！',1,'" + nexturl +
				// "');</script>");
				return;
			} else if ("uploadfile_shou".equals(act)) {
				int attchid = h.getInt("execl.attch");
				nexturl += "?attchid=" + attchid;
				out.print("<script>location='" + nexturl + "';</script>");
				// out.print("<script>mt.show('操作执行成功！',1,'" + nexturl +
				// "');</script>");
				return;
			} else if ("uploadfile_fu".equals(act)) {
				int attchid = h.getInt("execl.attch");
				nexturl += "?attchid=" + attchid;
				out.print("<script>location='" + nexturl + "';</script>");
				// out.print("<script>mt.show('操作执行成功！',1,'" + nexturl +
				// "');</script>");
				return;
			} else if ("uploadfile_gkprice".equals(act)) {
				int attchid = h.getInt("execl.attch");
				nexturl += "?attchid=" + attchid;
				out.print("<script>location='" + nexturl + "';</script>");
				// out.print("<script>mt.show('操作执行成功！',1,'" + nexturl +
				// "');</script>");
				return;
			}else if("crm_exp".equals(act)){//医院
				importCrmExcel(h);
			}else if("crm_expFu".equals(act)){//服务商
				importCrmExcel2(h);
			}else if("updateHospitalZz".equals(act)){//改变 医院资质

				int hid = h.getInt("hid"); // 医院
				int fsaqxkz = h.getInt("fsaqxkz.attch"); // 辐射安全许可证
				Date fsaqxkzrq = h.getDate("fsaqxkzrq"); // 辐射安全许可证日期
				int fsxypsyxkz = h.getInt("fsxypsyxkz.attch"); // 放射性药品使用许可证
				Date fsxypsyxkzrq = h.getDate("fsxypsyxkzrq"); // 放射性药品使用许可证日期
				int fszlxkz = h.getInt("fszlxkz.attch"); // 放射诊疗许可证
				Date fszlxkzrq = h.getDate("fszlxkzrq"); // 放射诊疗许可证日期
				int zfspb = h.getInt("zfspb.attch"); // 转让审批表
				Date zfspbrq = h.getDate("zfspbrq"); // 转让审批表日期
                String bq1 = h.get("bq1");
				Boolean dataIsOk = true;

				try {
					bq1 = bq1.replaceAll(",","");
                    Long aLong = Long.valueOf(bq1);
                }catch (Exception e){
					dataIsOk = false;
				}

				if(!dataIsOk){//数据有问题
					out.print("<script>mt.show('数据有误请重新输入！',1,'" + nexturl + "');</script>");
					return;
				}

                /*int bq2 = h.getInt("bq2");
				float bqChangeMci = 0.0f;
                if(!bq1.equals("")&&bq2>0) {
					bqChangeMci = ShopHospital.bqChangeMci(bq1, bq2);
				}*/
                float bqChangeMci = ShopHospital.getMciByBq(bq1);
                String yjdhyy = h.get("yjdhyy");
                String yjdhlz = h.get("yjdhlz");

                ShopHospital hospital = ShopHospital.find(hid);
                if(fsaqxkz>0) {
                    hospital.setFsaqxkz(fsaqxkz);
                }
                hospital.setFsaqxkzrq(fsaqxkzrq);
                if(fsxypsyxkz>0) {
                    hospital.setFsxypsyxkz(fsxypsyxkz);
                }
                hospital.setFsxypsyxkzrq(fsxypsyxkzrq);
                if(fszlxkz>0) {
                    hospital.setFszlxkz(fszlxkz);
                }
                hospital.setFszlxkzrq(fszlxkzrq);
                if(zfspb>0) {
                    hospital.setZfspb(zfspb);
                }
                hospital.setZfspbrq(zfspbrq);
                hospital.setBq1(bq1);
                //hospital.setBq2(bq2);
                hospital.setBqmci(bqChangeMci);
                hospital.setYjdhyy(yjdhyy);
                hospital.setYjdhlz(yjdhlz);
                hospital.setApprovalStatus(1);
                hospital.setApprovalProfile(2);
                hospital.set();


                ModifyRecord.creatModifyRecord(hospital.getId()+"","提交",h.member,"医院资质提交");


            }else if("certificationPass".equals(act)){//资质审核通过   审批人往下流转

                ShopHospital hospital = ShopHospital.find(id);
                int approvalProfile = hospital.getApprovalProfile();
                hospital.setApprovalProfile(approvalProfile+1);
				//质量管理员 审批完成 判断是否跳过负责人审批
				//客服审核完成   判断是否跳过
                int num = 0; //1都跳   2跳质量管理   3跳质量负责
                if(approvalProfile == 2 || approvalProfile == 3){
                    ActivityWarning activityWarning = ActivityWarning.find(2022);
					if(approvalProfile == 2) {
						if (activityWarning.getName().equals("1")) {
							num = 2;
							if (activityWarning.getStop().equals("1")) {
								num = 1;
							}
						}
					}

                    if(approvalProfile == 3 ) {
						if (activityWarning.getStop().equals("1")) {
							num = 3;
						}
					}



                }
                hospital.set();
                ModifyRecord.creatModifyRecord(hospital.getId()+"",ShopHospital.approvalRole[approvalProfile]+"审批",h.member,ShopHospital.approvalRole[approvalProfile]+"审批通过");

                if(num == 3 ){
					hospital.setApprovalStatus(3);
					hospital.setApprovalProfile(4);
					hospital.set();
					ModifyRecord.creatModifyRecord(hospital.getId()+"",ShopHospital.approvalRole[4]+"审批",h.member,ShopHospital.approvalRole[4]+"审批通过");
				}
				if(num == 2 ){
					hospital.setApprovalStatus(1);
					hospital.setApprovalProfile(3);
					hospital.set();
					ModifyRecord.creatModifyRecord(hospital.getId()+"",ShopHospital.approvalRole[3]+"审批",h.member,ShopHospital.approvalRole[3]+"审批通过");
				}
                if(num == 1 ){
					hospital.setApprovalStatus(1);
					hospital.setApprovalProfile(3);
					hospital.set();
					ModifyRecord.creatModifyRecord(hospital.getId()+"",ShopHospital.approvalRole[3]+"审批",h.member,ShopHospital.approvalRole[3]+"审批通过");
					hospital.setApprovalStatus(3);
					hospital.setApprovalProfile(4);
					hospital.set();
					ModifyRecord.creatModifyRecord(hospital.getId()+"",ShopHospital.approvalRole[4]+"审批",h.member,ShopHospital.approvalRole[4]+"审批通过");
				}


            }else if("certificationRefuse".equals(act)){//资质审核拒绝

                ShopHospital hospital = ShopHospital.find(id);
                int approvalProfile = hospital.getApprovalProfile();
                hospital.setApprovalProfile(0);//审批人回到初始节点 无人审批状态
                hospital.setApprovalStatus(2);//已拒绝
                String nobackreason = h.get("nobackreason");//拒绝理由
                hospital.setNobackreason(nobackreason);
                hospital.set();
                ModifyRecord.creatModifyRecord(hospital.getId()+"",ShopHospital.approvalRole[approvalProfile]+"审批",h.member,ShopHospital.approvalRole[approvalProfile]+"审批拒绝，拒绝原因："+nobackreason);

            }else if("editActivityWarning".equals(act)){//编辑医院预警信息
				String warning = h.get("warning");
				String warning2 = h.get("warning2");
				String stop = h.get("stop");
				Boolean dataIsOk = true;

				try {
					if(!warning.equals("")) {
						warning = warning.replaceAll(",", "");
						Long integer = Long.valueOf(warning);
					}
					if(!warning2.equals("")) {
						warning2 = warning2.replaceAll(",", "");
						Long integer1 = Long.valueOf(warning2);
					}
					if(!stop.equals("")) {
						stop = stop.replaceAll(",", "");
						Long integer2 = Long.valueOf(stop);
					}


				}catch (Exception e){
					dataIsOk = false;
				}

				if(!dataIsOk){//数据有问题
					out.print("<script>mt.show('数据有误请重新输入！',1,'" + nexturl + "');</script>");
					return;
				}
				ShopHospital hospital = ShopHospital.find(id);
				int count = ActivityWarning.count(" AND id=" + hospital.getId());
				ActivityWarning activityWarning = ActivityWarning.find(hospital.getId());
				activityWarning.setWarning(h.get("warning"));
				activityWarning.setWarning2(h.get("warning2"));
				activityWarning.setStop(h.get("stop"));
				activityWarning.setName(hospital.getName());
				activityWarning.setYjptdh(h.get("yjptdh"));
				activityWarning.setYjyydh(h.get("yjyydh"));
				if(count==0){
					activityWarning.insert();
				}else {
					activityWarning.update();
				}

			}else if("updateJumpQualityDirecter".equals(act)){//编辑跳过质量负责人
				ActivityWarning activityWarning = ActivityWarning.find(2022);
				activityWarning.setStop(h.get("isjump"));
				activityWarning.setName(h.get("isjump2"));
				activityWarning.update();
			}else if("daySendMessageMax".equals(act)){
				int maxNumber = h.getInt("maxNumber");
				ActivityWarning activityWarning = ActivityWarning.find(2023);
				activityWarning.setStop(maxNumber+"");
				activityWarning.update();
			}

			out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}

	/**
	 * 为医院类增加crm编码
	 * 导入excel
	 * */
	private void importCrmExcel(Http h) throws SQLException, InvalidFormatException, IOException{
		int attch= h.getInt("execl.attch");
		Attch a = Attch.find(attch);
		String filePath = Http.REAL_PATH+a.path;
		File f=new File(filePath);
		ImportExcel ei = new ImportExcel(filePath, 0);
		int tohang = ei.getDataRowNum()+1;
		for (int i = tohang; i <= ei.getLastDataRowNum(); i++) {
			Row row = ei.getRow(i);
			int j = 0;
			Object cellValue = ei.getCellValue(row, j++);
			String str = String.valueOf(cellValue);
			String s = str.replace(".", "");//去 .
			String[] split = s.split("E");//取E前面的
			ShopHospital hospital = ShopHospital.find(Integer.parseInt(split[0]));
			String hos_name = String.valueOf(ei.getCellValue(row, j++));
			if(hospital.getName().equals(hos_name)){//药事平台的医院id查出来的医院名  与  表格中获取的值一致 保存crmcode
				String crm_code = String.valueOf(ei.getCellValue(row, j++));
				hospital.setHos_code(crm_code);
				hospital.set();
			}

		}

		f.delete();
		a.delete();

	}


	/**
	 * 为服务商增加crm编码
	 * 导入excel
	 * */
	private void importCrmExcel2(Http h) throws SQLException, InvalidFormatException, IOException{
		int attch= h.getInt("execl.attch");
		Attch a = Attch.find(attch);
		String filePath = Http.REAL_PATH+a.path;
		File f=new File(filePath);
		ImportExcel ei = new ImportExcel(filePath, 0);
		int tohang = ei.getDataRowNum()+1;
		for (int i = tohang; i <= ei.getLastDataRowNum(); i++) {
			Row row = ei.getRow(i);
			int j = 0;
			Object cellValue = ei.getCellValue(row, j++);
			String str = String.valueOf(cellValue);
			String s = str.replace(".", "");//去 .
			String[] split = s.split("E");//取E前面的
			Profile profile = Profile.find(Integer.parseInt(split[0]));
			String s2 = String.valueOf(ei.getCellValue(row, j + 4));
			profile.setCode(s2);

		}

		f.delete();
		a.delete();

	}
}
