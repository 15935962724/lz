package tea.ui.copyright;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.copyright.*;
import java.sql.SQLException;

public class EditCopyRight extends HttpServlet
{
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");

		TeaSession teasession = new TeaSession(request);
		String act = request.getParameter("act");
		String nexturl = request.getParameter("nexturl");
		try
		{
			if ("editcrzzba".equals(act)) // 稿酬
			{
				String zzxm = request.getParameter("zzxm");
				String zzbm = request.getParameter("zzbm");
				String zzjj = request.getParameter("zzjj");
				String zzsfzh = request.getParameter("zzsfzh");
				String zzdz = request.getParameter("zzdz");
				String zzyb = request.getParameter("zzyb");
				String zzdh = request.getParameter("zzdh");
				String zzsj = request.getParameter("zzsj");
				String zzdzyj = request.getParameter("zzdzyj");
				String zzczfw = request.getParameter("zzczfw");
				boolean zzht = "true".equals(request.getParameter("zzht"));
				String zzfy = request.getParameter("zzfy");
				boolean zzqy = "true".equals(request.getParameter("zzqy"));
				String zzpy = request.getParameter("zzpy");
				int crzzba = Integer.parseInt(request.getParameter("crzzba"));
				if (crzzba < 1)
				{
					Crzzba.create(teasession._strCommunity, zzxm, zzbm, zzjj, zzsfzh, zzdz, zzyb, zzdh, zzsj, zzdzyj, zzczfw, zzht, zzfy, zzqy, zzpy);
				} else
				{
					Crzzba obj = Crzzba.find(crzzba);
					obj.set(zzxm, zzbm, zzjj, zzsfzh, zzdz, zzyb, zzdh, zzsj, zzdzyj, zzczfw, zzht, zzfy, zzqy, zzpy);
				}
			} else if ("deletecrzzba".equals(act))
			{
				int crzzba = Integer.parseInt(request.getParameter("crzzba"));
				Crzzba obj = Crzzba.find(crzzba);
				obj.delete();
			} else if ("editcrbargain".equals(act)) // 影音制品著作权合同登记公告
			{
				String scrbid = request.getParameter("scrbid");
				String name = request.getParameter("name");
				String pubarea = request.getParameter("pubarea");
				String crto = request.getParameter("crto");
				String pubyear = request.getParameter("pubyear");
				String impower = request.getParameter("impower");
				String remark = request.getParameter("remark");
				boolean flag = "true".equals(request.getParameter("flag"));
				int crbargain = Integer.parseInt(request.getParameter("crbargain"));
				if (crbargain < 1)
				{
					Crbargain.create(teasession._strCommunity, scrbid, name, pubarea, crto, pubyear, impower, remark, flag);
				} else
				{
					Crbargain obj = Crbargain.find(crbargain);
					obj.set(scrbid, name, pubarea, crto, pubyear, impower, remark, flag);
				}
			} else if ("deletecrbargain".equals(act))
			{
				int crbargain = Integer.parseInt(request.getParameter("crbargain"));
				Crbargain obj = Crbargain.find(crbargain);
				obj.delete();
			} else if ("editcrbookin".equals(act)) // 计算机软件著作权登记公告
			{
				String scrbid = request.getParameter("scrbid");
				String classno = request.getParameter("classno");
				String swname = request.getParameter("swname");
				String shortname = request.getParameter("shortname");
				String author = request.getParameter("author");
				String nation = request.getParameter("nation");
				Date pubdate = null;
				try
				{
					pubdate = Crbookin.sdf.parse(request.getParameter("pubdate"));
				} catch (Exception ex)
				{
				}
				String pubarea = request.getParameter("pubarea");
				String price = request.getParameter("price");
				String pricedollar = request.getParameter("pricedollar");
				String version = request.getParameter("version");
				Date passdate = null;
				try
				{
					passdate = Crbookin.sdf.parse(request.getParameter("passdate"));
				} catch (Exception ex)
				{
				}
				String remark1 = request.getParameter("remark1");
				String remark2 = request.getParameter("remark2");
				int crbookin = Integer.parseInt(request.getParameter("crbookin"));
				if (crbookin < 1)
				{
					Crbookin.create(teasession._strCommunity, scrbid, classno, swname, shortname, version, author, nation, pubarea, pubdate, price, pricedollar, passdate, remark1, remark2);
				} else
				{
					Crbookin obj = Crbookin.find(crbookin);
					obj.set(classno, swname, shortname, version, author, nation, pubarea, pubdate, price, pricedollar, passdate, remark1, remark2);
				}
			} else if ("deletecrbookin".equals(act))
			{
				int crbookin = Integer.parseInt(request.getParameter("crbookin"));
				Crbookin obj = Crbookin.find(crbookin);
				obj.delete();
			} else if ("editcrbulletin".equals(act)) // 各类作品著作权登记公告
			{
				String scrbid = request.getParameter("scrbid");
				String ainame = request.getParameter("ainame");
				String writingname = request.getParameter("writingname");
				String writingtype = request.getParameter("writingtype");
				Date createdate = null;
				try
				{
					createdate = Crbulletin.sdf.parse(request.getParameter("createdate"));
				} catch (Exception ex)
				{
				}
				Date pubdate = null;
				try
				{
					pubdate = Crbulletin.sdf.parse(request.getParameter("pubdate"));
				} catch (Exception ex)
				{
				}
				int crbulletin = Integer.parseInt(request.getParameter("crbulletin"));
				if (crbulletin < 1)
				{
					Crbulletin.create(teasession._strCommunity, scrbid, ainame, writingname, writingtype, createdate, pubdate);
				} else
				{
					Crbulletin obj = Crbulletin.find(crbulletin);
					obj.set(scrbid, ainame, writingname, writingtype, createdate, pubdate);
				}
			} else if ("deletecrbulletin".equals(act))
			{
				int crbulletin = Integer.parseInt(request.getParameter("crbulletin"));
				Crbulletin obj = Crbulletin.find(crbulletin);
				obj.delete();
			} else if ("editcrcancel".equals(act)) // 计算机软件著作权登记撤销公告
			{
				String code = request.getParameter("code");
				String scrbid = request.getParameter("scrbid");
				String author = request.getParameter("author");
				String name = request.getParameter("name");
				String shortname = request.getParameter("shortname");
				String ver = request.getParameter("ver");
				String reason = request.getParameter("reason");
				Date canceldate = null;
				try
				{
					canceldate = Crbulletin.sdf.parse(request.getParameter("canceldate"));
				} catch (Exception ex)
				{
				}
				String path = request.getParameter("path");

				int crcancel = Integer.parseInt(request.getParameter("crcancel"));
				if (crcancel < 1)
				{
					Crcancel.create(teasession._strCommunity, code, scrbid, author, name, shortname, ver, reason, canceldate, path);
				} else
				{
					Crcancel obj = Crcancel.find(crcancel);
					obj.set(code, author, name, shortname, ver, reason, canceldate, path);
				}
			} else if ("deletecrcancel".equals(act))
			{
				int crcancel = Integer.parseInt(request.getParameter("crcancel"));
				Crcancel obj = Crcancel.find(crcancel);
				obj.delete();
			} else if ("editcrnotice".equals(act)) // 稿酬
			{
				String title = request.getParameter("title");
				String author1 = request.getParameter("author1");
				String author2 = request.getParameter("author2");
				String pubpaper = request.getParameter("pubpaper");
				String repubpaper = request.getParameter("repubpaper");
				String pubdate = request.getParameter("pubdate");
				String repubdate = request.getParameter("repubdate");
				String sfdr = request.getParameter("sfdr");
				int crnotice = Integer.parseInt(request.getParameter("crnotice"));
				if (crnotice < 1)
				{
					Crnotice.create(teasession._strCommunity, title, author1, author2, pubpaper, repubpaper, pubdate, repubdate, sfdr);
				} else
				{
					Crnotice obj = Crnotice.find(crnotice);
					obj.set(title, author1, author2, pubpaper, repubpaper, pubdate, repubdate, sfdr);
				}
			} else if ("deletecrnotice".equals(act))
			{
				int crnotice = Integer.parseInt(request.getParameter("crnotice"));
				Crnotice obj = Crnotice.find(crnotice);
				obj.delete();
			} else if ("editcrtransfer".equals(act)) // 计算机软件著作权转移备案公告
			{
				String scrbid = request.getParameter("scrbid");
				String droit = request.getParameter("droit");
				Date startdate = null;
				try
				{
					startdate = Crbulletin.sdf.parse(request.getParameter("startdate"));
				} catch (Exception ex)
				{
				}
				Date enddate = null;
				try
				{
					enddate = Crbulletin.sdf.parse(request.getParameter("enddate"));
				} catch (Exception ex)
				{
				}
				String heir = request.getParameter("heir");
				String heirnation = request.getParameter("repubdate");
				Date passdate = null;
				try
				{
					passdate = Crbulletin.sdf.parse(request.getParameter("passdate"));
				} catch (Exception ex)
				{
				}
				int crtransfer = Integer.parseInt(request.getParameter("crtransfer"));
				if (crtransfer < 1)
				{
					Crtransfer.create(teasession._strCommunity, scrbid, heir, heirnation, droit, startdate, enddate, passdate);
				} else
				{
					Crtransfer obj = Crtransfer.find(crtransfer);
					obj.set(scrbid, heir, heirnation, droit, startdate, enddate, passdate);
				}
			} else if ("deletecrtransfer".equals(act))
			{
				int crtransfer = Integer.parseInt(request.getParameter("crtransfer"));
				Crtransfer obj = Crtransfer.find(crtransfer);
				obj.delete();
			} else if ("editcrcourtclose".equals(act)) // 法院查封公告信息
			{
				String scrbid = request.getParameter("scrbid");
				String court = request.getParameter("court");
				String author = request.getParameter("author");
				String name = request.getParameter("name");
				String close = request.getParameter("close");
				String year = request.getParameter("year");
				String open = request.getParameter("open");
				String cancel = request.getParameter("cancel");
				String path = request.getParameter("path");
				int crcourtclose = Integer.parseInt(request.getParameter("crcourtclose"));
				if (crcourtclose < 1)
				{
					Crcourtclose.create(teasession._strCommunity, scrbid, court, author, name, close, year, open, cancel, path);
				} else
				{
					Crcourtclose obj = Crcourtclose.find(crcourtclose);
					obj.set(court, author, name, close, year, open, cancel, path);
				}
			} else if ("deletecrcourtclose".equals(act))
			{
				int crcourtclose = Integer.parseInt(request.getParameter("crcourtclose"));
				Crcourtclose obj = Crcourtclose.find(crcourtclose);
				obj.delete();
			} else if ("editcrupdate".equals(act)) // 变更补充公告信息
			{
				String proving = request.getParameter("proving");
				String scrbid = request.getParameter("scrbid");
				String applicant = request.getParameter("applicant");
				String name = request.getParameter("name");
				String shortname = request.getParameter("shortname");
				String ver = request.getParameter("ver");
				String type = request.getParameter("type");
				String item = request.getParameter("item");
				String beforeitem = request.getParameter("beforeitem");
				String afteritem = request.getParameter("afteritem");
				String time = request.getParameter("time");
				String path = request.getParameter("path");
				int crupdate = Integer.parseInt(request.getParameter("crupdate"));
				if (crupdate < 1)
				{
					Crupdate.create(teasession._strCommunity, scrbid, proving, applicant, name, shortname, ver, type, item, beforeitem, afteritem, time, path);
				} else
				{
					Crupdate obj = Crupdate.find(crupdate);
					obj.set(proving, applicant, name, shortname, ver, type, item, beforeitem, afteritem, time, path);
				}
			} else if ("deletecrupdate".equals(act))
			{
				int crupdate = Integer.parseInt(request.getParameter("crupdate"));
				Crupdate obj = Crupdate.find(crupdate);
				obj.delete();
			} else if ("editcrallow".equals(act)) // 许可合同公告信息
			{
				String code = request.getParameter("code");
				String scrbid = request.getParameter("scrbid");
				String name = request.getParameter("name");
				String font1 = request.getParameter("font1");
				String author = request.getParameter("author");
				String font2 = request.getParameter("font2");
				String droit = request.getParameter("droit");
				String area = request.getParameter("area");
				String font3 = request.getParameter("font3");
				String starttime = request.getParameter("starttime");
				String endtime = request.getParameter("starttime");
				String host = request.getParameter("host");
				String font4 = request.getParameter("font4");
				String user = request.getParameter("user");
				String font5 = request.getParameter("font5");
				String time = request.getParameter("time");
				String path = request.getParameter("path");
				int crallow = Integer.parseInt(request.getParameter("crallow"));
				if (crallow < 1)
				{
					Crallow.create(teasession._strCommunity, code, scrbid, name, font1, author, font2, droit, area, font3, starttime, endtime, host, font4, user, font5, time, path);
				} else
				{
					Crallow obj = Crallow.find(crallow);
					obj.set(code, name, font1, author, font2, droit, area, font3, starttime, endtime, host, font4, user, font5, time, path);
				}
			} else if ("deletecrallow".equals(act))
			{
				int crallow = Integer.parseInt(request.getParameter("crallow"));
				Crallow obj = Crallow.find(crallow);
				obj.delete();
			} else if ("editcrimpawn".equals(act)) // 质押公告信息
			{
				String code = request.getParameter("code");
				String scrbid = request.getParameter("scrbid");
				String name = request.getParameter("name");
				String shortname = request.getParameter("shortname");
				String mortgagor = request.getParameter("mortgagor");// 出质人
				String pawnee = request.getParameter("pawnee");// 质权人
				String ver = request.getParameter("ver");
				String time = request.getParameter("time");
				String cancel = request.getParameter("cancel");
				String states = request.getParameter("states");
				String path = request.getParameter("path");
				int crimpawn = Integer.parseInt(request.getParameter("crimpawn"));
				if (crimpawn < 1)
				{
					Crimpawn.create(teasession._strCommunity, code, scrbid, name, shortname, mortgagor, pawnee, ver, time, cancel, states, path);
				} else
				{
					Crimpawn obj = Crimpawn.find(crimpawn);
					obj.set(code, name, shortname, mortgagor, pawnee, ver, time, cancel, states, path);
				}
			} else if ("deletecrimpawn".equals(act))
			{
				int crimpawn = Integer.parseInt(request.getParameter("crimpawn"));
				Crimpawn obj = Crimpawn.find(crimpawn);
				obj.delete();
			} else if ("editcrtransfercontract".equals(act)) // 转让合同公告信息
			{
				String code = request.getParameter("code");
				String scrbid = request.getParameter("scrbid");
				String name = request.getParameter("name");
				String font1 = request.getParameter("font1");
				String author = request.getParameter("author");
				String font2 = request.getParameter("font2");
				String droit = request.getParameter("droit");
				String assignor = request.getParameter("assignor");
				String font3 = request.getParameter("font3");
				String alienee = request.getParameter("alienee");
				String font4 = request.getParameter("font4");
				String time = request.getParameter("time");
				String path = request.getParameter("path");
				int crtransfercontract = Integer.parseInt(request.getParameter("crtransfercontract"));
				if (crtransfercontract < 1)
				{
					Crtransfercontract.create(teasession._strCommunity, code, scrbid, name, font1, author, font2, droit, assignor, font3, alienee, font4, time, path);
				} else
				{
					Crtransfercontract obj = Crtransfercontract.find(crtransfercontract);
					obj.set(code, name, font1, author, font2, droit, assignor, font3, alienee, font4, time, path);
				}
			} else if ("deletecrtransfercontract".equals(act))
			{
				int crtransfercontract = Integer.parseInt(request.getParameter("crtransfercontract"));
				Crtransfercontract obj = Crtransfercontract.find(crtransfercontract);
				obj.delete();
			}
		} catch (Exception ex)
		{
			ex.printStackTrace();
			throw new ServletException(ex.getMessage());
		}
		response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + java.net.URLEncoder.encode(nexturl, "UTF-8"));
	}

	// Clean up resources
	public void destroy()
	{
	}
}