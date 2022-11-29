package tea.ui.admin.erp;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import java.math.*;
import tea.ui.*;
import tea.entity.admin.erp.*;
import tea.db.*;
import tea.entity.node.*;
import tea.entity.site.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import tea.entity.admin.erp.icard.*;
import tea.entity.league.*;

/*
 DELETE FROM ICInventory
 DELETE FROM profile WHERE agent>0
 DELETE FROM ICSales
 DELETE FROM ICSaleslist
 DELETE FROM Paidinfull
 DELETE FROM GoodsDetails
 */
public class ICSync extends TeaServlet
{
	  public static Enumeration findBySql(String sql) throws SQLException
		{
			Vector v = new Vector();
			DbAdapter db = new DbAdapter(1);
			try
			{
				db.executeQuery("SELECT p.member FROM Profile p,ProfileLayer pl WHERE p.member=pl.member and  " + sql );
			   System.out.println("SELECT p.member FROM Profile p,ProfileLayer pl WHERE p.member=pl.member and  " + sql );
				while(db.next())
				{
					v.addElement(db.getString(1));
				}
			} finally
			{
				db.close();
			}
			return v.elements();
		}

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		String ua = request.getHeader("User-Agent");
		if(!ua.startsWith("Microsoft URL Control"))
		{
			response.sendError(404);
			return;
		}
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=gbk");
		String community = request.getParameter("community");
		String act = request.getParameter("act");
		String tmp = request.getParameter("no");
		int no = 0; //加盟店编号
		if(tmp != null && tmp.length() > 0)
		{
			no = Integer.parseInt(tmp);
		}
		PrintWriter out = response.getWriter();
		try
		{
			int node = Community.find(community).getNode();
			int lang = 1;
			Date last = LeagueShop.sdf3.parse(request.getParameter("last")); //new Date(0); //
			int max = 0;
			tmp = request.getParameter("max"); //上次传的最大ID(分多次更新是将用到)
			if(tmp != null)
			{
				max = Integer.parseInt(tmp);
			}
			if(act.equals("sync")) //待更新的项
			{
				out.println("time=" + LeagueShop.sdf3.format(new Date()));
				LeagueShop ls = LeagueShop.find(no);
				int type = ls.getLstype();
				int count = LeagueShopMsg.count(" AND leagueshoptype=" + type + " AND time>" + DbAdapter.cite(last));
				if(count > 0)
				{
					out.println("message=1");
				}
				String brands = ls.getBrands();
				if(brands != null && brands.length() > 1)
				{
					brands = brands.substring(1,brands.length() - 1).replace('/',',');
					//服务
					count = ShopService.count(community," AND time>" + DbAdapter.cite(last) + " AND brand IN(" + brands + ")");
					if(count > 0)
					{
						out.println("shopservice=" + count);
					}
					count = Node.count(" AND path LIKE '/" + node + "/%' AND type=34 AND updatetime>" + DbAdapter.cite(last) + " AND node IN(SELECT node FROM Goods WHERE brand IN(" + brands + "))");
					if(count > 0)
					{
						out.println("goods=" + count);
					}
				}
				count = ICardType.count(community," AND time>" + DbAdapter.cite(last));
				if(count > 0)
				{
					out.println("icardtype=" + count);
				}
				count = Paidinfull.count(community," AND updatetime>" + DbAdapter.cite(last));
				if(count > 0)
				{
					out.println("paidinfull=" + count);
				}
//                count = GoodsType.find(" AND community=" + DbAdapter.cite(GoodsType.find(GoodsType.getRootId(community)).getCommunity()) + " AND time>" + DbAdapter.cite(last),0,1);
//                if(e.hasMoreElements())
//                {
//                    out.println("goodstype");
//                }
//                e = Supplier.find(community," AND time>" + DbAdapter.cite(last),0,1);
//                if(e.hasMoreElements())
//                {
//                    out.println("supplier");
//                }
				count = SupplierBrandDiscounts.count(community," AND sb.time>" + DbAdapter.cite(last));
				if(count > 0)
				{
					out.println("discounts=" + count);
				}
				count = BatchPrice.count(community," AND joinname=" + no + " AND times>" + DbAdapter.cite(last));
				if(count > 0)
				{
					out.println("batchprice=" + count);
				}
			} else if(act.equals("leagueshop")) //加盟店校验
			{
				String name = request.getParameter("name");
				LeagueShop obj = LeagueShop.find(no);
				int s = obj.getLsstatic();
				boolean flag = obj.isExists() && name.equals(obj.getLsname());
				if(!flag)
				{
					out.println("lsstatic=-1");
					out.println("lsstaticname=编号或密码错误");
					return;
				}
				obj.getInsnumber(obj.getInstallnumber()+1);

				obj.setIp(request.getRemoteAddr());
				out.println("installnumber=" + obj.getInstallnumber());
				out.println("lsstatic=" + s);
				out.println("lsstaticname=" + LeagueShop.LSSTATIC[s]);
			} else if(act.equals("profile")) //会员
			{
				String id[] = request.getParameterValues("id");
				String name[] = request.getParameterValues("name");
				String sex[] = request.getParameterValues("sex");
				String card[] = request.getParameterValues("card"); //证件
				String tel[] = request.getParameterValues("tel");
				String email[] = request.getParameterValues("email");
				String addr[] = request.getParameterValues("addr");
				String time[] = request.getParameterValues("time");

				//
				String icardtype[] = request.getParameterValues("icardtype");
				String money[] = request.getParameterValues("money");
				String state[] = request.getParameterValues("state");
				String shine[] = request.getParameterValues("shine");
				String stab[] = request.getParameterValues("stab");
				String acne[] = request.getParameterValues("acne");
				String sensitive[] = request.getParameterValues("sensitive");
				String spotted[] = request.getParameterValues("spotted");
				String relaxation[] = request.getParameterValues("relaxation");
				String aging[] = request.getParameterValues("aging");

				/**************************************************/
				String bm[] = request.getParameterValues("bm");
				String bm2[] = request.getParameterValues("bm2");

				String password[] = request.getParameterValues("password");
				String sxrq[] = request.getParameterValues("sxrq");
				String zxfje[] = request.getParameterValues("zxfje");
				String zxfcs[] = request.getParameterValues("zxfcs");
				String txdz[] = request.getParameterValues("txdz");
				String price[] = request.getParameterValues("price");
				String cardname[] = request.getParameterValues("cardname");
				String birthday[] = request.getParameterValues("birthday");
				String klx[] = request.getParameterValues("klx");
				String czkjf[] = request.getParameterValues("czkjf");
				String ljyhje[] = request.getParameterValues("ljyhje");
				String ljsl[] = request.getParameterValues("ljsl");
				String jfsl[] = request.getParameterValues("jfsl");
				String cs[] = request.getParameterValues("cs");
				String sycs[] = request.getParameterValues("sycs");
				String ljjf[] = request.getParameterValues("ljjf");
				String jmkh[] = request.getParameterValues("jmkh");
				String zczje[] = request.getParameterValues("zczje");
			/**************************************************/

				for(int i = 0;i < id.length;i++)
				{
					boolean isSex = Integer.parseInt(sex[i]) == 1;
					Profile p = Profile.find(id[i]);
					if(!Profile.isExisted(id[i]))
					{
						Profile.create(id[i],community,password[i],tel[i],isSex,card[i],0,name[i],email[i],1,"");
						p.setAgent(no);
					} else
					{
						p.setFirstName(name[i],1);
						p.setSex(isSex);
						p.setMobile(tel[i]);
						p.setCard(card[i]);
						p.setEmail(email[i]);
					}
					p.setAddress(addr[i],1);
					if (password[i]==null) password[i]="";
					p.setPassword(password[i]);
					p.setState(bm[i], 1);
					p.setCity(bm2[i], 1);

					p.setTime(Profile.sdf3.parse(time[i]));
					ICard.set(id[i],Integer.parseInt(icardtype[i]),new BigDecimal(money[i]),
							Integer.parseInt(state[i]),Integer.parseInt(shine[i]),
							Integer.parseInt(stab[i]),Integer.parseInt(acne[i]),
							Integer.parseInt(sensitive[i]),Integer.parseInt(spotted[i]),
							Integer.parseInt(relaxation[i]),aging[i],
							 sxrq[i],
							 new BigDecimal(zxfje[i]),
							 Integer.parseInt(zxfcs[i]),
							 txdz[i],
							 new BigDecimal(price[i]),
							 cardname[i],birthday[i],
							 new BigDecimal(czkjf[i]),
							 new BigDecimal(ljyhje[i]),
							 new BigDecimal(ljsl[i]),
							 new BigDecimal(jfsl[i]),
							 Integer.parseInt(cs[i]),
							 Integer.parseInt(sycs[i]),
							 new BigDecimal(ljjf[i]),
							 jmkh[i],
							 new BigDecimal(zczje[i]));

				}
			}else if(act.equals("del_profile")) //会员
			{
				  String id  = request.getParameter("id");
				 if( Profile.isExisted(id))
				 {	Profile.delete(id);
				 ICard.delete(id);
				 }
				 else
					 out.println("false");
			}else if(act.equals("down_profile")) //会员
			{
			 String id  = request.getParameter("id");
			 Profile profile=Profile.find(id);
			 ICard   icard=ICard.find(id);


			  if( Profile.isExisted(id))
			  {
			out.println("exist=true");
			out.println("id=" + id);
			out.println("name="+profile.getFirstName(1));
			out.println("sex="+(profile.isSex()?"男":"女"));
			out.println("card="+profile.getCard()); //证件
			out.println("tel="+profile.getMobile());
			out.println("email="+profile.getEmail());
			out.println("addr="+profile.getAddress(1));
			out.println("time="+profile.getTimeToString());
			//
			out.println("bm="+profile.getState(1));
			out.println("bm2="+profile.getCity(1));

			out.println("icardtype="+icard.getIcardtype());
		   out.println("money="+icard.getMoney());
			out.println("state="+icard.getState());
		   out.println("shine="+icard.getShine());
			out.println("stab="+icard.getStab());
		   out.println("acne="+icard.getAcne());
			out.println("sensitive="+icard.getSensitive());
			out.println("spotted="+icard.getSpotted());
			out.println("relaxation="+icard.getRelaxation());
			out.println("aging="+icard.getAging());
		   /**************************************************/
			out.println("password="+profile.getPassword());
			out.println("sxrq="+icard.getSxrq());
			out.println("zxfje="+icard.getZxfje());
			out.println("zxfcs="+icard.getZxfcs());
			out.println("txdz="+icard.getTxdz());
			out.println("price="+icard.getPrice());
			out.println("cardname="+icard.getCardname());
			out.println("birthday="+icard.getBirthday());
			out.println("czkjf="+icard.getCzkjf());

			out.println("ljyhje="+icard.getLjyhje());
			out.println("ljsl="+icard.getLjsl());
			out.println("jfsl="+icard.getJfsl());
			out.println("cs="+icard.getCs());
			out.println("sycs="+icard.getSycs());
			out.println("ljjf="+icard.getLjjf());
			out.println("jmkh="+icard.getJmkh());
			out.println("zczje="+icard.getZczje());
			  }else
				out.println("exist=false");

		  }else if(act.equals("down_profiles")) //会员
		  {
			 String name  = request.getParameter("name");
			 String tel = request.getParameter("tel");
			 boolean flag1,flag2;
			 flag1=name!=null &&!name.equals("");
			 flag2=tel!=null &&!tel.equals("");

			 String sql="(";
			 if(flag1)
				sql=sql+" firstname like "+DbAdapter.cite(name);
			 if (flag1&&flag2) sql=sql+" or ";
			 if(flag2)
				sql= sql+" mobile like "+DbAdapter.cite(tel);

			 sql=sql+")";


			Enumeration profiles=ICSync.findBySql(sql);



			 while(profiles.hasMoreElements())
			  {String id=(String)profiles.nextElement();
				 Profile  profile=Profile.find(id);
				 ICard   icard=ICard.find(id);
			out.println("exist=true");
			out.println("id=" + profile.getMember());
			 out.println("name="+profile.getFirstName(1));
			out.println("sex="+(profile.isSex()?"男":"女"));
			 out.println("card="+profile.getCard()); //证件
			 out.println("tel="+profile.getMobile());
			 out.println("email="+profile.getEmail());
			 out.println("addr="+profile.getAddress(1));
			 out.println("time="+profile.getTimeToString());

			 out.println("bm="+profile.getState(1));
			 out.println("bm2="+profile.getCity(1));

			 //
			 out.println("icardtype="+icard.getIcardtype());
			out.println("money="+icard.getMoney());
			 out.println("state="+icard.getState());
			out.println("shine="+icard.getShine());
			 out.println("stab="+icard.getStab());
			out.println("acne="+icard.getAcne());
			 out.println("sensitive="+icard.getSensitive());
			 out.println("spotted="+icard.getSpotted());
			 out.println("relaxation="+icard.getRelaxation());
			 out.println("aging="+icard.getAging());
			/**************************************************/
			 out.println("password="+profile.getPassword());
			 out.println("sxrq="+icard.getSxrq());
			 out.println("zxfje="+icard.getZxfje());
			 out.println("zxfcs="+icard.getZxfcs());
			 out.println("txdz="+icard.getTxdz());
			 out.println("price="+icard.getPrice());
			 out.println("cardname="+icard.getCardname());
			 out.println("birthday="+icard.getBirthday());
			 out.println("czkjf="+icard.getCzkjf());

			 out.println("ljyhje="+icard.getLjyhje());
			 out.println("ljsl="+icard.getLjsl());
			 out.println("jfsl="+icard.getJfsl());
			 out.println("cs="+icard.getCs());
			 out.println("sycs="+icard.getSycs());
			 out.println("ljjf="+icard.getLjjf());
			 out.println("jmkh="+icard.getJmkh());
			 out.println("zczje="+icard.getZczje());
			 if(profiles.hasMoreElements())
			 {
				 out.println("#SPLIT");
			 }
			  }
		   }
			else if(act.equals("icinventory")) //库存
			{
				String id[] = request.getParameterValues("node");
				String quantity[] = request.getParameterValues("quantity");
				for(int i = 0;i < id.length;i++)
				{
					int nid = Integer.parseInt(id[i]);
					int j = Integer.parseInt(quantity[i]);
					Enumeration e = ICInventory.find(" AND leagueshop=" + no + " AND node=" + nid,0,1);
					if(e.hasMoreElements())
					{
						int ic = ((Integer) e.nextElement()).intValue();
						ICInventory obj = ICInventory.find(ic);
						obj.setQuantity(j);
					} else
					{
						ICInventory.create(no,nid,j);
					}
				}
			}
			else if(act.equals("icardtype")) //卡类型
			{
				//获取加盟店卡类型

				int lstypeid = LeagueShop.find(no).getLstype();

			//   Enumeration e = ICardType.find(community," AND lstypeid = "+lstypeid+" AND time>" + DbAdapter.cite(last),0,Integer.MAX_VALUE);
				Enumeration e = ICardType.find(community," AND lstypeid = "+lstypeid,0,Integer.MAX_VALUE);
				while(e.hasMoreElements())
				{
					int id = ((Integer) e.nextElement()).intValue();
					ICardType obj = ICardType.find(id);
					out.println("icardtype=" + obj.getICardType());
					out.println("mode=" + obj.getMode());
					out.println("modename=" + ICardType.MODE_TYPE[obj.getMode()]);
					out.println("name=" + obj.getName());
					out.println("integral=" + obj.getIntegral());
					out.println("discount=" + obj.getDiscount());
					if(e.hasMoreElements())
					{
						out.println("#SPLIT");
					}
				}
			} else if(act.equals("shopservice")) //服务
			{
				String brands = LeagueShop.find(no).getBrands();
				if(brands == null || brands.length() < 2)
				{
					return;
				}
				Enumeration e = ShopService.find(community," AND shopservice>" + max + " AND time>" + DbAdapter.cite(last) + " AND brand IN(" + brands.substring(1,brands.length() - 1).replace('/',',') + ") ORDER BY shopservice",0,10);
				while(e.hasMoreElements())
				{
					int id = ((Integer) e.nextElement()).intValue();
					ShopService ss = ShopService.find(id);
					out.println("id=" + id);
					out.println("no=" + ss.getNo());
					out.println("name=" + ss.getName());
					out.println("price=" + ss.getPrice());
					out.println("spec=" + ss.getSpec());
					out.println("dtype=" + (ss.isDType() ? 1 : 0));
					out.println("deduct=" + ss.getDeduct());
					out.println("point=" + ss.getPoint());
					out.println("brand=" + ss.getBrand());
					if(e.hasMoreElements())
					{
						out.println("#SPLIT");
					}
				}
			} else if(act.equals("goods")) //商品
			{
				String brands = LeagueShop.find(no).getBrands();
				if(brands == null || brands.length() < 2)
				{
					return;
				}
				Enumeration e = Node.find(" AND node>" + max + " AND path LIKE '/" + node + "/%' AND type=34 AND updatetime>" + DbAdapter.cite(last) + " AND node IN(SELECT node FROM Goods WHERE brand IN(" + brands.substring(1,brands.length() - 1).replace('/',',') + ")) ORDER BY node",0,10);
				while(e.hasMoreElements())
				{
					int nid = ((Integer) e.nextElement()).intValue();
					Node n = Node.find(nid);
					Goods g = Goods.find(nid);
					out.println("node=" + nid);
					out.println("no=" + n.getNumber()); //编号
					out.println("code=" + g.getBarcode()); //条形码
					out.println("brand=" + g.getBrand());
					out.println("goodstype=" + g.getGoodstype());
					BigDecimal price = g.getPrice();
					Enumeration ec = Commodity.findByGoods(nid);

					if(ec.hasMoreElements())
					{
						int cid = ((Integer) ec.nextElement()).intValue();
						Commodity c = Commodity.find(cid);
						BuyPrice bpobj = BuyPrice.find(cid, 1);
						price=bpobj.getPrice();
						out.println("supplier=" + c.getSupplier());
						out.println("mininventory=" + c.getMinQuantity()); //最小库存
					}
					out.println("name=" + n.getSubject(lang)); //名称
					out.println("measure=" + g.getMeasure(lang)); //计量单位
					out.println("spec=" + g.getSpec(lang)); //规格
					out.println("supply=" + g.getSupply()); //供货价
					out.println("list=" + g.getList()); //标价

				   // Enumeration ebp = BatchPrice.find(community," AND joinname=" + no + " AND node=" + nid,0,1);
				   // java.util.Enumeration  enumeration = tea.entity.node.Commodity.findByGoods(teasession._nNode);
				   // if(ebp.hasMoreElements())
					{
					   // price = BatchPrice.find(((Integer) ebp.nextElement()).intValue()).getPrice();
					//	 int cid = ((Integer)ebp.nextElement()).intValue();


					}
					out.println("price=" + price); //销售价
					out.println("dtype=" + (g.isDType() ? 1 : 0));
					out.println("deduct=" + g.getDeduct());
					out.println("point=" + g.getPoint());
					if(e.hasMoreElements())
					{
						out.println("#SPLIT");
					}
				}
			} else if(act.equals("paidinfull")) //进货单
			{
				String id[] = request.getParameterValues("id");

				String time_s[] = request.getParameterValues("time_s");
				String quantity[] = request.getParameterValues("quantity");

				String total[] = request.getParameterValues("total");
				String member[] = request.getParameterValues("member");
				String remarks[] = request.getParameterValues("remarks");
				String type[] = request.getParameterValues("type");
				String updatetime[] = request.getParameterValues("updatetime");
				//
				String goodsarr[] = request.getParameterValues("goodsarr");
				String supplyarr[] = request.getParameterValues("supplyarr"); //供货价
				String discountarr[] = request.getParameterValues("discountarr");
				String quantityarr[] = request.getParameterValues("quantityarr");
				String dsupplyarr[] = request.getParameterValues("dsupplyarr");
				String totalarr[] = request.getParameterValues("totalarr");
				String remarksarr[] = request.getParameterValues("remarksarr");
				StringBuffer sb = new StringBuffer();
				sb.append(" AND supplname=").append(no);
				sb.append(" AND purchase NOT IN('0'");
				if(id != null)
				{
					for(int i = 0;i < id.length;i++)
					{
						Date utime = Paidinfull.sdf3.parse(updatetime[i]);
						Date ctime = Paidinfull.sdf3.parse(time_s[i]);
						int t = Integer.parseInt(type[i]);
						Paidinfull p = Paidinfull.find(id[i]);
						if(!p.isExists())
						{
							Paidinfull.create(id[i],
									no,0,
									quantityarr[i],
									totalarr[i],
									quantity[i],
									total[i],
									ctime,
									member[i],
									community,
									remarks[i],
									goodsarr[i],
									discountarr[i],
									supplyarr[i],
									total[i],
									dsupplyarr[i],
									t,"","","",
									remarksarr[i],
									utime);
						} else if(utime.compareTo(p.getUpdateTime()) == 1)
						{
							p.set(p.getSupplname(),p.getWaridname(),quantityarr[i],totalarr[i],quantity[i],total[i],ctime,member[i],community,remarks[i],goodsarr[i],discountarr[i],supplyarr[i],total[i],dsupplyarr[i],p.getType(),p.getMember2(),p.getTelephone(),p.getAddress(),remarksarr[i],utime);
							p.setType(t);
							DbAdapter db = new DbAdapter();
							try
							{
								db.executeUpdate("DELETE FROM GoodsDetails WHERE paid=" + DbAdapter.cite(id[i]));
							} finally
							{
								db.close();
							}
						} else
						{
							continue;
						}
						String gs[] = goodsarr[i].split("/");
						String ss[] = supplyarr[i].split("/");
						String ds[] = discountarr[i].split("/");
						String qs[] = quantityarr[i].split("/");
						String dss[] = dsupplyarr[i].split("/");
						String ts[] = totalarr[i].split("/");
						String rs[] = (remarksarr[i] + "fill").split("/");
						for(int j = 1;j < gs.length;j++)
						{
							GoodsDetails.create(id[i],Integer.parseInt(gs[j]),ss[j],"10",dss[j],Integer.parseInt(qs[j]),ts[j],rs[j],community,0,0,ds[j]);
							GoodsDetails.setTime_s(id[i],ctime,0);
						}
						sb.append(",").append(DbAdapter.cite(id[i]));
					}
				}
				sb.append(") AND updatetime>").append(DbAdapter.cite(last));
				Enumeration e = Paidinfull.find(community,sb.toString(),0,Integer.MAX_VALUE);
				while(e.hasMoreElements())
				{
					String paid = (String) e.nextElement();
					Paidinfull pobj = Paidinfull.find(paid);
					//Goods g = Goods.find(nid);
					out.println("id=" + paid); //编号
					out.println("time_s=" + pobj.getTime_sToString()); //进货日期
					out.println("quantity=" + pobj.getQuantity()); //数量
					out.println("total=" + pobj.getTotal_2()); //进货金额
					out.println("type=" + pobj.getType()); //状态
					out.println("typename=" + Paidinfull.TYPE_NAME[pobj.getType()]); //状态明文
					out.println("member=" + pobj.getMember());
					out.println("remarks=" + pobj.getRemarks());
					out.println("updatetime=" + Paidinfull.sdf3.format(pobj.getUpdateTime()));
					//
					String gs = "/",ss = "/",ds = "/",qs = "/",dss = "/",ts = "/",rs = "/";
					Enumeration egd = GoodsDetails.find(community," AND paid=" + DbAdapter.cite(paid),0,Integer.MAX_VALUE);
					while(egd.hasMoreElements())
					{
						int gdid = ((Integer) egd.nextElement()).intValue();
						GoodsDetails gd = GoodsDetails.find(gdid);
						gs += gd.getNode() + "/";
						ss += gd.getSupply() + "/";
						ds += gd.getDiscount() + "/";
						qs += gd.getQuantity() + "/";
						dss += gd.getDsupply() + "/";
						ts += gd.getTotal() + "/";
						rs += gd.getRemarksarr().replace('/','／') + "/";
					}
					out.println("goodsarr=" + gs); //商品编号
					out.println("supplyarr=" + ss); //单价
					out.println("discountarr=" + ds); //折扣
					out.println("quantityarr=" + qs); //数量
					out.println("dsupplyarr=" + dss); //折后单价
					out.println("totalarr=" + ts); //金额
					out.println("remarksarr=" + rs);
					if(e.hasMoreElements())
					{
						out.println("#SPLIT");
					}
				}
			} else if(act.equals("icsales")) //销售单
			{
				String id[] = request.getParameterValues("id");
				String price[] = request.getParameterValues("price");
				String type[] = request.getParameterValues("type");
				String quantity[] = request.getParameterValues("quantity");
				String times[] = request.getParameterValues("time");
				//明细
				String nos[] = request.getParameterValues("nos");
				String nas[] = request.getParameterValues("nas");
				String ics[] = request.getParameterValues("ics");

				String qus[] = request.getParameterValues("qus");
				String prs[] = request.getParameterValues("prs");
				String dis[] = request.getParameterValues("dis");
				for(int i = 0;i < id.length;i++)
				{
				   String id_s= no+"-"+id[i];
				   System.out.println("id="+id_s);
					Date ut = LeagueShop.sdf3.parse(times[i]);
					boolean isNM = type[i].equals("1"); //是非会员
					boolean isNew = false;
					ICSales icsobj =ICSales.find(id_s);

					if(!icsobj.isExists())
					{
						ICSales.create(id_s,no,Integer.parseInt(quantity[i]),new BigDecimal(price[i]),isNM,ut);
						isNew = true;
					}

					if(!isNew)
					{
						continue;
					}
					String noarr[] = nos[i].split("/");
					String naarr[] = nas[i].split("/");
					String icarr[] = ics[i].split("/");
					String prarr[] = prs[i].split("/");
					String diarr[] = dis[i].split("/");
					String quarr[] = qus[i].split("/");
					for(int j = 1;j < noarr.length;j++)
					{
						ICSalesList.create(id_s,Node.findNumber(community,noarr[j]),noarr[j],naarr[j],isNM ? null : icarr[j],false,Integer.parseInt(quarr[j]),new BigDecimal(prarr[j]),new BigDecimal(diarr[j]));

					}
				}
			} else if(act.equals("goodstype")) //商品类别
			{
				Enumeration e = GoodsType.find(" AND community=" + DbAdapter.cite(GoodsType.find(GoodsType.getRootId(community)).getCommunity()) + " AND time>" + DbAdapter.cite(last),0,Integer.MAX_VALUE);
				while(e.hasMoreElements())
				{
					GoodsType dt = (GoodsType) e.nextElement();
					out.println("goodstype=" + dt.getGoodstype());
					out.println("father=" + dt.getFather());
					out.println("sequence=" + dt.getSequence());
					out.println("community=" + dt.getCommunity());
					out.println("brand=" + dt.getBrand());
					out.println("name=" + dt.getName(lang));
					out.println("picture=" + dt.getPicture(lang));
					if(e.hasMoreElements())
					{
						out.println("#SPLIT");
					}
				}
			} else if(act.equals("supplier")) //供货商
			{
				Enumeration e = Supplier.find(community," AND time>" + DbAdapter.cite(last),0,Integer.MAX_VALUE);
				while(e.hasMoreElements())
				{
					int id = ((Integer) e.nextElement()).intValue();
					Supplier obj = Supplier.find(id);
					out.println("supplier=" + obj.getSupplier());
					out.println("name=" + obj.getName(lang));
					out.println("fax=" + obj.getFax());
					out.println("tel=" + obj.getTel());
					out.println("member=" + obj.getMember());
					out.println("city=" + obj.getCard());
					out.println("address=" + obj.getAddress(lang));
					if(e.hasMoreElements())
					{
						out.println("#SPLIT");
					}
				}
			} else if(act.equals("discounts")) //商品打折
			{
				Enumeration e = SupplierBrandDiscounts.find(community," AND sb.time>" + DbAdapter.cite(last),0,Integer.MAX_VALUE);
				while(e.hasMoreElements())
				{
					int ids[] = (int[]) e.nextElement();
					SupplierBrandDiscounts obj = SupplierBrandDiscounts.find(ids[0],ids[1]);
					out.println("supplier=" + obj.getSupplier());
					out.println("brand=" + obj.getBrand());
					out.println("discounts=" + obj.getDiscounts());
					out.println("starttime=" + obj.getStartTimeToString());
					out.println("stoptime=" + obj.getStopTimeToString());
					out.println("member=" + obj.getMember());
					out.println("goodstype=" + obj.getGoodstype());
					out.println("goodstype2=" + obj.getGoodstype2());
					out.println("floor=" + obj.getFloor());
					if(e.hasMoreElements())
					{
						out.println("#SPLIT");
					}
				}
			} else if(act.equals("message")) //公告
			{
				int type = LeagueShop.find(no).getLstype();
				LeagueShopType lst = LeagueShopType.find(type);
				//
				for(int i = 0;i < 2;i++)
				{
					StringBuilder fg = new StringBuilder();
					fg.append(i == 0 ? "f" : "b");
					fg.append("gcontent=<html><head><script>window.onerror=function(){return true;}</script><style type='text/css'>").append(i == 0 ? lst.getFgStyle() : lst.getBgStyle());
					fg.append("</style><meta http-equiv='Content-Type' content='text/html; charset=GBK'></head><body scroll='no' oncontextmenu='return false;'><marquee direction='up' scrollamount='2' style='height:100%'>");
					Enumeration e = LeagueShopMsg.find(type," AND state=" + i + " ORDER BY time DESC",0,3);
					if(!e.hasMoreElements())
					{
						fg.append("暂无公告");
					} else
					{
						while(e.hasMoreElements())
						{
							LeagueShopMsg lsm = (LeagueShopMsg) e.nextElement();
							fg.append("<li class='subject' id='subject'>").append(lsm.getSubject()).append(" - ").append(lsm.getTimeToString()).append("</li>");
							fg.append("<li class='content' id='content'>").append(lsm.getContent()).append("</li>");
						}
					}
					fg.append("</marquee></body></html>");
					out.println(fg.toString().replaceAll("\r\n"," "));
				}
			} else if(act.equals("site"))
			{
				LeagueShop ls = LeagueShop.find(no);
				out.println("money=" + ls.getSummoney());
				out.println("brands=" + ls.getBrands());
			} else if(act.equals("batchprice"))
			{
				Enumeration e = BatchPrice.find(community," AND joinname=" + no + " AND times>" + DbAdapter.cite(last),0,Integer.MAX_VALUE);
				while(e.hasMoreElements())
				{
					int id = ((Integer) e.nextElement()).intValue();
					BatchPrice bp = BatchPrice.find(id);
					out.println("node=" + bp.getNode());
					out.println("price=" + bp.getPrice());
				}
			}
		} catch(Exception ex)
		{
			ex.printStackTrace();
			response.sendError(500,ex.toString());
		} finally
		{
			out.close();
		}
	}
}
