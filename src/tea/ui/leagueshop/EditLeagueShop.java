package tea.ui.leagueshop;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import java.math.BigDecimal;
import java.sql.SQLException;
import tea.entity.ocean.*;
import java.text.*;
import tea.entity.util.Spell;
import java.math.*;
import tea.db.*;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import tea.entity.util.ZoomOut;
import tea.entity.SeqTable;
import tea.entity.league.*;
import tea.entity.admin.AdminUnit;
import tea.entity.util.*;
import tea.db.*;
import tea.entity.node.*;

public class EditLeagueShop extends TeaServlet
{
    public void init() throws ServletException
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        tea.ui.TeaSession teasession = null;
        teasession = new tea.ui.TeaSession(request);
        ServletContext application = getServletContext();
        String act = teasession.getParameter("act");
        try
        {
            if("EditLeagueShopStatic".equals(act))
            {
                int id = 0,lsstatic2 = 0;
                if(teasession.getParameter("ids") != null && teasession.getParameter("ids").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("ids"));

                }
                if(teasession.getParameter("lsstatic2") != null && teasession.getParameter("lsstatic2").length() > 0)
                {
                    lsstatic2 = Integer.parseInt(teasession.getParameter("lsstatic2"));
                }
                LeagueShop lsobj = LeagueShop.find(id);
                lsobj.setLsstatic2(lsstatic2,teasession._rv.toString());
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=/jsp/leagueshop/LeagueShopStatic.jsp");
                return;
            }
            if(act.equals("LeagueShopDaoru")) //导入数据
            {
                int id = 0;
                int pid = 2009;
                String name = teasession.getParameter("name");
                String ename = "";
                String linkmanname = "";
                String tel = teasession.getParameter("tel");
                String fax = "";
                String address = teasession.getParameter("address");
                String content = "";
                int father = AdminUnit.Mid(teasession._strCommunity,"","Min");
                if(father != 0 && id == father) // 部门的上级不能是自已
                {
                    father = 0;
                }
                boolean usepic = teasession.getParameter("usepic") != null;
                AdminUnit obj_au = AdminUnit.find(id);
                String picture = "";
                byte by[] = null;
                if(by != null)
                {
                    picture = super.write(teasession._strCommunity,by,".gif");
                } else if(teasession.getParameter("clear") != null) // 清空
                {
                    picture = "";
                }

                Enumeration eu = LeagueShopDaoru.findByCommunity(teasession._strCommunity,"");
                for(int i = 0;eu.hasMoreElements();i++)
                {
                    int drid = Integer.parseInt(String.valueOf(eu.nextElement()));
                    LeagueShopDaoru drobj = LeagueShopDaoru.find(drid);
                    name = drobj.getLsname(); 
                    obj_au.set(father,name,ename,pid,1,linkmanname,tel,fax,teasession._strCommunity,teasession._rv.toString(),address,obj_au.getZip(),
                    		content,picture,usepic,obj_au.getOther(),obj_au.getOther2(),0,0);
                    int bumen = AdminUnit.Mid(teasession._strCommunity," and name=" + DbAdapter.cite(name),"Max");

                    String lsname = drobj.getLsname(); //加盟店名称
                    String community = teasession._strCommunity; //社区
                    String lsbusiness = drobj.getLsbusiness(); //营业执照
                    String health = drobj.getHealth(); //卫生登记证书
                    String legalperson = drobj.getLegalperson(); //法人
                    String buytype = drobj.getBuytype(); //经营性质
                    int province = Card.findcard("  and address=" + DbAdapter.cite(drobj.getProvince()));
                    int city = Card.findcard("  and  address like " + DbAdapter.cite("%" + drobj.getCity() + "%"));

                    String region = drobj.getRegion(); //区
                    String port = drobj.getPort(); //港
                    String number = drobj.getNumber(); //号
                    tel = drobj.getTel(); //营业电话号
                    String lsbuyname = drobj.getLsbuyname(); //加盟商姓名
                    int lsbuysex = 0;
                    if(drobj.getLsbuysex() != null && drobj.getLsbuysex().length() > 0)
                    {
                        if(drobj.getLsbuysex().equals("先生"))
                        {
                            lsbuysex = 0;
                        } else
                        {
                            lsbuysex = 1;
                        }
                    } else
                    {
                        lsbuysex = 1;

                    }

                    String lsbuytel = drobj.getLsbuytel(); //加盟商手机号
                    String lsbuyschool = drobj.getLsbuyschool(); //加盟商学历
                    String lsbuyjob = drobj.getLsbuyjob(); //加盟之前所从事的职业
                    String lsbuypost = drobj.getLsbuypost(); //加盟之前所从事行业的职务
                    int lsbuycsfalg = 0; //是否专职经营连锁店

                    if(drobj.getLsbuycsfalg() != null && drobj.getLsbuycsfalg().length() > 0)
                    {
                        if(drobj.getLsbuycsfalg().equals("是"))
                        {
                            lsbuycsfalg = 0;
                        } else
                        {
                            lsbuycsfalg = 1;
                        }
                    } else
                    {
                        lsbuycsfalg = 1;
                    }
                    String shopkeepername = drobj.getShopkeepername(); //店长姓名
                    int sksex = 0; ///店长性别  0 先生 1  女士
                    if(drobj.getSksex() != null && drobj.getSksex().length() > 0)
                    {
                        if(drobj.getSksex().equals("先生"))
                        {
                            sksex = 0;
                        } else
                        {
                            sksex = 1;
                        }

                    } else
                    {
                        sksex = 1;
                    }

                    String sktel = drobj.getSktel(); //手机电话
                    String skschool = drobj.getSkschool(); ///店长最高学历
                    String skjob = drobj.getSkjob(); ///
                    String skpost = drobj.getSkpost(); ///
                    int csarea = 0; //chain store连锁商店 区域 华北//"华东地区","华南地区","华中地区","华北地区","西北地区","西南地区","东北地区","台港澳地区"
                    if(drobj.getCsarea().equals("华东地区"))
                    {
                        csarea = 1;
                    } else if(drobj.getCsarea().equals("华南地区"))
                    {
                        csarea = 2;
                    } else if(drobj.getCsarea().equals("华中地区"))
                    {
                        csarea = 3;
                    } else if(drobj.getCsarea().equals("华北地区"))
                    {
                        csarea = 4;
                    } else if(drobj.getCsarea().equals("西北地区"))
                    {
                        csarea = 5;
                    } else if(drobj.getCsarea().equals("西南地区"))
                    {
                        csarea = 6;
                    } else if(drobj.getCsarea().equals("东北地区"))
                    {
                        csarea = 7;
                    } else if(drobj.getCsarea().equals("台港澳地区"))
                    {
                        csarea = 8;
                    } else
                    {
                        csarea = 0;
                    }

                    int lstype = 0; //唯美度
                    lstype = LeagueShopType.findid(" and  lstypename=" + DbAdapter.cite(drobj.getLstype()));

                    int lsstype = 0; //类型
                    lsstype = LeagueShopServer.find(teasession._strCommunity,"  and lssname=" + DbAdapter.cite(drobj.getLsstype()));
                    Date regdate = new Date(); //添加时间
                    Date adddate = new Date(); // drobj.getStartdate(); //加盟时间
                    Date startdate = new Date(); //drobj.getStartdate(); //开业时间
                    String bednum = drobj.getBednum(); //美容床数
                    String shoparea = drobj.getShoparea(); //经营面积
                    int spa = 0; //SPA
                    if(drobj.getSpa().equals("有"))
                    {
                        spa = 0;
                    } else
                    {
                        spa = 1;
                    }

                    String shopkeeper = drobj.getShopkeeper(); //店长
                    String adviser = drobj.getAdviser(); //前台顾问
                    String hairdresser = drobj.getHairdresser(); //美容师
                    String fixmember = drobj.getFixmember(); //固定
                    String movemember = drobj.getMovemember(); //流动顾客
                    int computernum = 0; //连锁店是否有电脑
                    if(drobj.getComputernum().equals("是"))
                    {
                        computernum = 0;
                    } else
                    {
                        computernum = 1;
                    }

                    int network = 0;
                    if(drobj.getNetwork().equals("是"))
                    {
                        network = 0;
                    } else
                    {
                        network = 1;
                    }

                    int internettype = 0;
                    if(drobj.getInternettype().equals("ADSL"))
                    {
                        csarea = 0;
                    } else if(drobj.getInternettype().equals("宽带"))
                    {
                        csarea = 1;
                    } else if(drobj.getInternettype().equals("拔号"))
                    {
                        csarea = 2;
                    } else if(drobj.getInternettype().equals("本店无法上网"))
                    {
                        csarea = 3;
                    }

                    int systemtype = 0; //会员系统
                    if(drobj.getSystemtype().equals("是"))
                    {
                        systemtype = 0;
                    } else
                    {
                        systemtype = 1;
                    }
                    LeagueShop lsobj = LeagueShop.find(id);
                    String brands = lsobj.getBrands();
                    LeagueShop.set(id,bumen,lsname,community,lsbusiness,health,legalperson,buytype,province,city,region,port,number,tel,lsbuyname,lsbuysex,lsbuytel,lsbuyschool,lsbuyjob,lsbuypost,lsbuycsfalg,shopkeepername,sksex,sktel,skschool,skjob,skpost,csarea,lstype,lsstype,regdate,adddate,startdate,bednum,shoparea,spa,shopkeeper,adviser,hairdresser,fixmember,movemember,computernum,network,internettype,systemtype,brands);

                }
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("导入成功！","UTF-8") + "&nexturl=/jsp/leagueshop/LeagueShopDaoru.jsp");
                return;
            }
            if(act.equals("EditLeagueShopImprest"))
            {
                int lsid = 0;
                if(teasession.getParameter("lsid") != null && teasession.getParameter("lsid").length() > 0)
                {
                    lsid = Integer.parseInt(teasession.getParameter("lsid"));
                }
                int id = 0;
                if(teasession.getParameter("idss") != null && teasession.getParameter("idss").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("idss"));
                }
                int lsistatic = 0;
                if(teasession.getParameter("lsistatic") != null && teasession.getParameter("lsistatic").length() > 0)
                {
                    lsistatic = Integer.parseInt(teasession.getParameter("lsistatic"));
                }
                String moneyss = "0";
                if(teasession.getParameter("yfmoney") != null && teasession.getParameter("yfmoney").length() > 0)
                {
                    moneyss = (teasession.getParameter("yfmoney"));
                }
                BigDecimal yfmoney = new BigDecimal(moneyss); //

                Date zzdate = null; //转账时间
                if(teasession.getParameter("zzdate") != null && teasession.getParameter("zzdate").length() > 0)
                {
                    zzdate = LeagueShop.sdf.parse(teasession.getParameter("zzdate"));
                }
                int payment = 0;
                if(teasession.getParameter("payment") != null && teasession.getParameter("payment").length() > 0)
                {
                    payment = Integer.parseInt(teasession.getParameter("payment"));
                }
                int type = 0; //0添加预付款
                if(teasession.getParameter("type") != null && teasession.getParameter("type").length() > 0)
                {
                    type = Integer.parseInt(teasession.getParameter("type"));
                }
				String info="";
				if(teasession.getParameter("info")!=null && teasession.getParameter("info").length()>0)
				{
					info=teasession.getParameter("info");
				}
				String summary = "";
				if(teasession.getParameter("summary")!=null && teasession.getParameter("summary").length()>0)
				{
					summary=teasession.getParameter("summary");
				}

                String regmember = teasession._rv.toString();
                LeagueShopImprest.set(id,lsid,yfmoney,zzdate,regmember,zzdate,teasession._strCommunity,payment,type,lsistatic,0,info,summary);
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=/jsp/leagueshop/LeagueShopImprestList2.jsp?lsid=" + lsid);
                return;
            }
            if(act.equals("EditLeagueAuditlist"))
            {
                int id = 0; //
                if(teasession.getParameter("idss") != null && teasession.getParameter("idss").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("idss"));
                } else
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("审核失败！","UTF-8") + "&nexturl=/jsp/leagueshop/LeagueShopAuditList.jsp");
                    return;
                }

                LeagueShopbackup obj = LeagueShopbackup.find(id);

                if(obj.isExists())
                {

                } else
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("没有要审核的信息！","UTF-8") + "&nexturl=/jsp/leagueshop/LeagueShopAuditList.jsp");
                    return;
                }
                int bumen = obj.getBumen(); //加盟店名称id,bumen,lsname,community,lsbusiness,health,legalperson,buytype,province,city,region,port,number,tel,lsbuyname,lsbuysex,lsbuytel,lsbuyschool,lsbuyjob,lsbuypost,lsbuycsfalg,shopkeepername,sksex,sktel,skschool,skjob,skpost,csarea,lstype,lsstype,regdate,adddate,startdate,bednum,shoparea,spa,shopkeeper,adviser,hairdresser,fixmember,movemember,computernum,network,internettype,systemtype
                String lsname = obj.getLsname(); //加盟店名称
                String community = teasession._strCommunity; //社区
                String lsbusiness = obj.getLsbusiness(); //营业执照
                String health = obj.getHealth(); //卫生登记证书
                String legalperson = obj.getLegalperson(); //法人
                String buytype = obj.getBuytype(); //经营性质
                int province = obj.getProvince(); //省
                int city = obj.getCity(); //市
                String region = obj.getRegion(); //区
                String port = obj.getPort(); //港
                String number = obj.getNumber(); //号
                String tel = obj.getTel(); //营业电话号
                String lsbuyname = obj.getLsbuyname(); //加盟商姓名
                int lsbuysex = obj.getLsbuysex(); //加盟商性别
                String lsbuytel = obj.getLsbuytel(); //加盟商手机号
                String lsbuyschool = obj.getLsbuytel(); //加盟商学历
                String lsbuyjob = obj.getLsbuyjob(); //加盟之前所从事的职业
                String lsbuypost = obj.getLsbuypost(); //加盟之前所从事行业的职务
                int lsbuycsfalg = obj.getLsbuycsfalg(); //是否专职经营连锁店
                String shopkeepername = obj.getShopkeepername(); //店长姓名
                int sksex = obj.getSksex(); ///店长性别  0 先生 1  女士
                String sktel = obj.getSktel(); //手机电话
                String skschool = obj.getSkschool(); ///店长最高学历
                String skjob = obj.getSkjob(); ///
                String skpost = obj.getSkpost(); ///
                int csarea = obj.getCsarea(); //chain store连锁商店 区域 华北
                int lstype = obj.getLstype(); //唯美度
                int lsstype = obj.getLsstype(); //类型
                Date regdate = obj.getRegdate(); //添加时间
                Date adddate = obj.getStartdate(); //加盟时间
                Date startdate = obj.getStartdate(); //开业时间
                String bednum = obj.getBednum(); //美容床数
                String shoparea = obj.getShoparea(); //经营面积
                int spa = obj.getSpa(); //SPA
                String shopkeeper = obj.getShopkeeper(); //店长
                String adviser = obj.getAdviser(); //前台顾问
                String hairdresser = obj.getHairdresser(); //美容师
                String fixmember = obj.getFixmember(); //固定
                String movemember = obj.getMovemember(); //流动顾客
                int computernum = obj.getComputernum(); //连锁店是否有电脑
                int network = obj.getNetwork();
                int internettype = obj.getInternettype(); //上网方式  ADSL,宽带,拔号,本店无法上网
                int systemtype = obj.getSystemtype(); //会员系统
				LeagueShop lsobj =LeagueShop.find(id);
				String brands =lsobj.getBrands();

                LeagueShop.set(id,bumen,lsname,community,lsbusiness,health,legalperson,buytype,province,city,region,port,number,tel,lsbuyname,lsbuysex,lsbuytel,lsbuyschool,lsbuyjob,lsbuypost,lsbuycsfalg,shopkeepername,sksex,sktel,skschool,skjob,skpost,csarea,lstype,lsstype,regdate,adddate,startdate,bednum,shoparea,spa,shopkeeper,adviser,hairdresser,fixmember,movemember,computernum,network,internettype,systemtype,brands);

                LeagueShopbackup.delete(id);
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("审核信息通过！","UTF-8") + "&nexturl=/jsp/leagueshop/LeagueShopAuditList.jsp");
                return;
            }
            if(act.equals("EditLeagueShop2")) //加盟店管理员修改加盟店信息
            {
                int id = 0; //
                if(teasession.getParameter("idss") != null && teasession.getParameter("idss").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("idss"));
                }
                int bumen = 0; //加盟店名称
                if(teasession.getParameter("bumen") != null && teasession.getParameter("bumen").length() > 0)
                {
                    bumen = Integer.parseInt(teasession.getParameter("bumen"));
                }

                String lsname = teasession.getParameter("lsname"); //加盟店名称
                String community = teasession._strCommunity; //社区
                String lsbusiness = teasession.getParameter("lsbusiness"); //营业执照
                String health = teasession.getParameter("health"); //卫生登记证书
                String legalperson = teasession.getParameter("legalperson"); //法人
                String buytype = teasession.getParameter("buytype"); //经营性质
                int province = 0; //省
                if(teasession.getParameter("s1") != null && teasession.getParameter("s1").length() > 0)
                {
                    province = Integer.parseInt(teasession.getParameter("s1"));
                }

                int city = 0; //市
                if(teasession.getParameter("s2") != null && teasession.getParameter("s2").length() > 0)
                {
                    city = Integer.parseInt(teasession.getParameter("s2"));
                }

                String region = teasession.getParameter("region"); //区
                String port = teasession.getParameter("port"); //港
                String number = teasession.getParameter("number"); //号
                String tel = teasession.getParameter("tel"); //营业电话号
                String lsbuyname = teasession.getParameter("lsbuyname"); //加盟商姓名
                int lsbuysex = 0; //加盟商性别
                if(teasession.getParameter("lsbuysex") != null && teasession.getParameter("lsbuysex").length() > 0)
                {
                    lsbuysex = Integer.parseInt(teasession.getParameter("lsbuysex"));
                }

                String lsbuytel = teasession.getParameter("lsbuytel"); //加盟商手机号
                String lsbuyschool = teasession.getParameter("lsbuyschool"); //加盟商学历
                String lsbuyjob = teasession.getParameter("lsbuyjob"); //加盟之前所从事的职业
                String lsbuypost = teasession.getParameter("lsbuypost"); //加盟之前所从事行业的职务
                int lsbuycsfalg = 0; //是否专职经营连锁店
                if(teasession.getParameter("lsbuycsfalg") != null && teasession.getParameter("lsbuycsfalg").length() > 0)
                {
                    lsbuycsfalg = Integer.parseInt(teasession.getParameter("lsbuycsfalg"));
                }

                String shopkeepername = teasession.getParameter("shopkeepername"); //店长姓名
                int sksex = 0; ///店长性别
                if(teasession.getParameter("sksex") != null && teasession.getParameter("sksex").length() > 0)
                {
                    sksex = Integer.parseInt(teasession.getParameter("sksex"));
                }
                String sktel = teasession.getParameter("sktel"); //手机电话
                String skschool = teasession.getParameter("skschool"); ///店长最高学历
                String skjob = teasession.getParameter("skjob"); ///
                String skpost = teasession.getParameter("skpost"); ///
                int csarea = 0; //chain store连锁商店 区域 华北
                if(teasession.getParameter("csarea") != null && teasession.getParameter("csarea").length() > 0)
                {
                    csarea = Integer.parseInt(teasession.getParameter("csarea"));
                }

                int lstype = 0; //唯美度
                if(teasession.getParameter("lstype") != null && teasession.getParameter("lstype").length() > 0)
                {
                    lstype = Integer.parseInt(teasession.getParameter("lstype"));
                }

                int lsstype = 0; //类型
                if(teasession.getParameter("lsstype") != null && teasession.getParameter("lsstype").length() > 0)
                {
                    lsstype = Integer.parseInt(teasession.getParameter("lsstype"));
                }

                Date regdate = new Date(); //添加时间
                Date adddate = null; //加盟时间
                if(teasession.getParameter("adddate") != null && teasession.getParameter("adddate").length() > 0)
                {
                    adddate = LeagueShop.sdf.parse(teasession.getParameter("adddate"));
                }

                Date startdate = null; //开业时间
                if(teasession.getParameter("startdate") != null && teasession.getParameter("startdate").length() > 0)
                {
                    startdate = LeagueShop.sdf.parse(teasession.getParameter("startdate"));
                }
                String bednum = teasession.getParameter("bednum"); //美容床数
                String shoparea = teasession.getParameter("shoparea"); //经营面积
                int spa = 0; //SPA
                if(teasession.getParameter("spa") != null && teasession.getParameter("spa").length() > 0)
                {
                    spa = Integer.parseInt(teasession.getParameter("spa"));
                }

                String shopkeeper = teasession.getParameter("shopkeeper"); //店长
                String adviser = teasession.getParameter("adviser"); //前台顾问
                String hairdresser = teasession.getParameter("hairdresser"); //美容师
                String fixmember = teasession.getParameter("fixmember"); //固定
                String movemember = teasession.getParameter("movemember"); //流动顾客
                int computernum = 0; //连锁店是否有电脑
                if(teasession.getParameter("computernum") != null && teasession.getParameter("computernum").length() > 0)
                {
                    computernum = Integer.parseInt(teasession.getParameter("computernum"));
                }

                int network = 0;
                if(teasession.getParameter("network") != null && teasession.getParameter("network").length() > 0)
                {
                    network = Integer.parseInt(teasession.getParameter("network"));
                }

                int internettype = 0; //上网方式
                if(teasession.getParameter("internettype") != null && teasession.getParameter("internettype").length() > 0)
                {
                    internettype = Integer.parseInt(teasession.getParameter("internettype"));
                }

                int systemtype = 0; //会员系统
                if(teasession.getParameter("systemtype") != null && teasession.getParameter("systemtype").length() > 0)
                {
                    systemtype = Integer.parseInt(teasession.getParameter("systemtype"));
                }

                LeagueShopbackup.set(id,bumen,lsname,community,lsbusiness,health,legalperson,buytype,province,city,region,port,number,tel,lsbuyname,lsbuysex,lsbuytel,lsbuyschool,lsbuyjob,lsbuypost,lsbuycsfalg,shopkeepername,sksex,sktel,skschool,skjob,skpost,csarea,lstype,lsstype,regdate,adddate,startdate,bednum,shoparea,spa,shopkeeper,adviser,hairdresser,fixmember,movemember,computernum,network,internettype,systemtype);

                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=/jsp/leagueshop/EditLeagueShop.jsp?lsaddtype=1");
                return;
            } else if(act.equals("EditLeagueShop"))
            {

                int id = 0; //
                if(teasession.getParameter("idss") != null && teasession.getParameter("idss").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("idss"));
                }
                int bumen = 0; //加盟店名称
                if(teasession.getParameter("bumen") != null && teasession.getParameter("bumen").length() > 0)
                {
                    bumen = Integer.parseInt(teasession.getParameter("bumen"));
                }
                if(id == 0)
                {
                    if(LeagueShop.lsbumenfalg(bumen))
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("此部门已经关联加盟店，请重新选择！","UTF-8") + "&nexturl=/jsp/leagueshop/EditLeagueShop.jsp");
                        return;
                    }
                } else
                {
                    int sum = 0;
                    sum = LeagueShop.count(teasession._strCommunity," and bumen=" + bumen + " and id=" + id);

                    if(sum != 1)
                    {
                        if(LeagueShop.lsbumenfalg(bumen))
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("此部门已经关联加盟店，请重新选择！","UTF-8") + "&nexturl=/jsp/leagueshop/EditLeagueShop.jsp");
                            return;
                        }
                    }
                }

                String lsname = teasession.getParameter("lsname"); //加盟店名称
                String community = teasession._strCommunity; //社区
                String lsbusiness = teasession.getParameter("lsbusiness"); //营业执照
                String health = teasession.getParameter("health"); //卫生登记证书
                String legalperson = teasession.getParameter("legalperson"); //法人
                String buytype = teasession.getParameter("buytype"); //经营性质

                int province = 0; //省
                if(teasession.getParameter("s1") != null && teasession.getParameter("s1").length() > 0)
                {
                    province = Integer.parseInt(teasession.getParameter("s1"));
                }

                int city = 0; //市
                if(teasession.getParameter("s2") != null && teasession.getParameter("s2").length() > 0)
                {
                    city = Integer.parseInt(teasession.getParameter("s2"));
                }

                String region = teasession.getParameter("region"); //区
                String port = teasession.getParameter("port"); //港
                String number = teasession.getParameter("number"); //号
                String tel = teasession.getParameter("tel"); //营业电话号
                String lsbuyname = teasession.getParameter("lsbuyname"); //加盟商姓名
                int lsbuysex = 0; //加盟商性别
                if(teasession.getParameter("lsbuysex") != null && teasession.getParameter("lsbuysex").length() > 0)
                {
                    lsbuysex = Integer.parseInt(teasession.getParameter("lsbuysex"));
                }

                String lsbuytel = teasession.getParameter("lsbuytel"); //加盟商手机号
                String lsbuyschool = teasession.getParameter("lsbuyschool"); //加盟商学历
                String lsbuyjob = teasession.getParameter("lsbuyjob"); //加盟之前所从事的职业
                String lsbuypost = teasession.getParameter("lsbuypost"); //加盟之前所从事行业的职务
                int lsbuycsfalg = 0; //是否专职经营连锁店
                if(teasession.getParameter("lsbuycsfalg") != null && teasession.getParameter("lsbuycsfalg").length() > 0)
                {
                    lsbuycsfalg = Integer.parseInt(teasession.getParameter("lsbuycsfalg"));
                }

                String shopkeepername = teasession.getParameter("shopkeepername"); //店长姓名
                int sksex = 0; ///店长性别
                if(teasession.getParameter("sksex") != null && teasession.getParameter("sksex").length() > 0)
                {
                    sksex = Integer.parseInt(teasession.getParameter("sksex"));
                }
                String sktel = teasession.getParameter("sktel"); //手机电话
                String skschool = teasession.getParameter("skschool"); ///店长最高学历
                String skjob = teasession.getParameter("skjob"); ///
                String skpost = teasession.getParameter("skpost"); ///
                int csarea = 0; //chain store连锁商店 区域 华北
                if(teasession.getParameter("csarea") != null && teasession.getParameter("csarea").length() > 0)
                {
                    csarea = Integer.parseInt(teasession.getParameter("csarea"));
                }

                int lstype = 0; //唯美度
                if(teasession.getParameter("lstype") != null && teasession.getParameter("lstype").length() > 0)
                {
                    lstype = Integer.parseInt(teasession.getParameter("lstype"));
                }

                int lsstype = 0; //类型
                if(teasession.getParameter("lsstype") != null && teasession.getParameter("lsstype").length() > 0)
                {
                    lsstype = Integer.parseInt(teasession.getParameter("lsstype"));
                }

                Date regdate = new Date(); //添加时间
                Date adddate = null; //加盟时间
                if(teasession.getParameter("adddate") != null && teasession.getParameter("adddate").length() > 0)
                {
                    adddate = LeagueShop.sdf.parse(teasession.getParameter("adddate"));
                }

                Date startdate = null; //开业时间
                if(teasession.getParameter("startdate") != null && teasession.getParameter("startdate").length() > 0)
                {
                    startdate = LeagueShop.sdf.parse(teasession.getParameter("startdate"));
                }
                String bednum = teasession.getParameter("bednum"); //美容床数
                String shoparea = teasession.getParameter("shoparea"); //经营面积
                int spa = 0; //SPA
                if(teasession.getParameter("spa") != null && teasession.getParameter("spa").length() > 0)
                {
                    spa = Integer.parseInt(teasession.getParameter("spa"));
                }

                String shopkeeper = teasession.getParameter("shopkeeper"); //店长
                String adviser = teasession.getParameter("adviser"); //前台顾问
                String hairdresser = teasession.getParameter("hairdresser"); //美容师
                String fixmember = teasession.getParameter("fixmember"); //固定
                String movemember = teasession.getParameter("movemember"); //流动顾客
                int computernum = 0; //连锁店是否有电脑
                if(teasession.getParameter("computernum") != null && teasession.getParameter("computernum").length() > 0)
                {
                    computernum = Integer.parseInt(teasession.getParameter("computernum"));
                }

                int network = 0;
                if(teasession.getParameter("network") != null && teasession.getParameter("network").length() > 0)
                {
                    network = Integer.parseInt(teasession.getParameter("network"));
                }

                int internettype = 0; //上网方式
                if(teasession.getParameter("internettype") != null && teasession.getParameter("internettype").length() > 0)
                {
                    internettype = Integer.parseInt(teasession.getParameter("internettype"));
                }

                int systemtype = 0; //会员系统
                if(teasession.getParameter("systemtype") != null && teasession.getParameter("systemtype").length() > 0)
                {
                    systemtype = Integer.parseInt(teasession.getParameter("systemtype"));
                }
				String brands = "";
				StringBuffer brandstr = new StringBuffer("/");
				int count = 0;
				count = Brand.countByCommunity(teasession._strCommunity,"");
				for(int i = 0;i < count;i++)
				{
					if(teasession.getParameter("brands" + i) != null && teasession.getParameter("brands" + i).length() > 0)
					{
						brandstr.append(teasession.getParameter("brands" + i)).append("/");
					}
				}
				brands = brandstr.toString();

                //sbusiness,health,legalperson,buytype,province,city,region,port,number,tel,lsbuyname,lsbuysex,lsbuytel,lsbuyschool,lsbuyjob,lsbuypost,lsbuycsfalg,shopkeepername,sksex,sktel
                if(lsname == null || lsbusiness == null || health == null || legalperson == null || buytype == null || province == 0 || city == 0 || region == null || port == null || number == null || tel == null || lsbuyname == null || lsstype == 0 || lstype == 0 || startdate == null || bednum == null)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("添加信息不完整请重新填写！","UTF-8") + "&nexturl=/jsp/leagueshop/EditLeagueShop.jsp");
                    return;
                }

                LeagueShop.set(id,bumen,lsname,community,lsbusiness,health,legalperson,buytype,province,city,region,port,number,tel,lsbuyname,lsbuysex,lsbuytel,lsbuyschool,lsbuyjob,lsbuypost,lsbuycsfalg,shopkeepername,sksex,sktel,skschool,skjob,skpost,csarea,lstype,lsstype,regdate,adddate,startdate,bednum,shoparea,spa,shopkeeper,adviser,hairdresser,fixmember,movemember,computernum,network,internettype,systemtype,brands);

                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=/jsp/leagueshop/LeagueShopLinkList.jsp");
                return;
            }

            if(act.equals("EditLeagueShopClass"))
            {
                int lssid = 0;
                if(teasession.getParameter("lssid") != null && teasession.getParameter("lssid").length() > 0)
                {
                    lssid = Integer.parseInt(teasession.getParameter("lssid"));
                }
                String lssname = teasession.getParameter("lssname");
                String lssmoney = teasession.getParameter("lssmoney");
                String lssarea = teasession.getParameter("lssarea");
                int lstypeid = 0;
                if(teasession.getParameter("lstypeid") != null && teasession.getParameter("lstypeid").length() > 0)
                {
                    lstypeid = Integer.parseInt(teasession.getParameter("lstypeid"));
                }

                LeagueShopServer.set(lssid,lstypeid,lssname,lssarea,lssmoney);
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=/jsp/leagueshop/EditLeagueShopClass.jsp");
                return;
            }

            if(act.equals("EditleagueShopClassType"))
            {
                int idtype = 0;
                if(teasession.getParameter("idtype") != null && teasession.getParameter("idtype").length() > 0)
                {
                    idtype = Integer.parseInt(teasession.getParameter("idtype"));
                }
                String lstypename = teasession.getParameter("lstypename");

                String brands = "";
                StringBuffer brandstr = new StringBuffer("/");
                int count = 0;
                count = Brand.countByCommunity(teasession._strCommunity,"");
                for(int i = 0;i < count;i++)
                {
                    if(teasession.getParameter("brands" + i) != null && teasession.getParameter("brands" + i).length() > 0)
                    {
                        brandstr.append(teasession.getParameter("brands" + i)).append("/");
                    }
                }
                brands = brandstr.toString();

                Date date = new Date();
                LeagueShopType.set(idtype,lstypename,date,teasession._rv.toString(),date,teasession._rv.toString(),teasession._strCommunity,brands);
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=/jsp/leagueshop/EditleagueShopClassType.jsp");
                return;
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            System.out.print(ex.toString());
        }
    }

    public EditLeagueShop()
    {
    }

    public void destroy()
    {
    }

}
