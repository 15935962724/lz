package tea.ui.node.type.golf;

import javax.servlet.*;
import javax.servlet.http.*;
import tea.ui.*;
import java.util.*;
import tea.htmlx.*;
import tea.entity.*;
import java.io.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.entity.admin.map.*;
import java.sql.SQLException;

public class EditGolf extends TeaServlet
{
    // String SEPARATOR = System.getProperty("file.separator");
    public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);

        Http h = new Http(request);
        HttpSession session = request.getSession();
        h.node = teasession._nNode;
        try
        {
            String nexturl = teasession.getParameter("nexturl");
            if(request.getParameter("mark") != null) // ���
            {
                java.io.PrintWriter out = response.getWriter();

                try
                {

                    String str = (String) session.getAttribute("tea.GolfMark");
                    if(str == null)
                    {
                        str = "/";
                    }
                    if(str.indexOf("/" + h.node + "/") != -1)
                    {
                        r.add("tea/ui/node/type/poll/VotePoll");
                        out.write("<script>alert('" + r.getString(h.language,"InfAlreadyVoted") + "');</script>");
                    } else
                    {
                        String info = "提交成功! 谢谢您的参与!";
                        out.write("<script>alert('" + info + "');var win=window.dialogArguments;var lo=win.location;lo.replace(lo.pathname+'?'+lo.search+'&top='+win.document.body.scrollTop+'#mark');</script>");
                        Golf court = Golf.find(h.node,h.language);
                        court.setMark(h.getInt("holisticMark"),h.getInt("relaxMark"),h.getInt("auraMark"),h.getInt("lamplightMark"),h.getInt("serveMark"),h.getInt("temperatureMark"),h.getInt("musicMark"),h.getInt("airMark"),h.getInt("crowdMark"),h.getInt("safetyMark"),h.getInt("drinkMark"),h.getInt("belleMark"),h.getInt("deliMark"),h.getInt("priceMark"));
                        session.setAttribute("tea.GolfMark",str + "/" + h.node);
                    }
                    out.write("<script>window.close();</script>");
                } finally
                {
                    out.close();
                }
                return;
            }
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String member = teasession._rv._strR;
//            if(teasession._rv == null)
//            {
//                h.login(response,teasession._rv == null ? false : true);
//            } else
//            {
//                session.setAttribute("member",member);
//            }

            //删除 球场
            String act = request.getParameter("act");
            if("del".equals(act))
            {
                Node n = Node.find(h.node);
                if(n.getType() == 62) //必须是高尔类
                {
                    n.delete(h.language);
                }
                response.sendRedirect(nexturl);
                return;
            }
            String name = teasession.getParameter("name");

            if(name == null || name.length() == 0)
            {
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + h.enc(r.getString(h.language,"InvalidSubject")));
                return;
            }
            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/golf/EditGolf.jsp?" + request.getQueryString());
            } else
            {
                Node node = Node.find(h.node);
                String text = teasession.getParameter("intro"); // synopsis");
                if(node.getType() == 1)
                {
                    int sequence = Node.getMaxSequence(h.node) + 10;
                    int options1 = 0;
                    long options = node.getOptions();
                    options &= 0xffdffbff;
                    int defautllangauge = node.getDefaultLanguage();
                    Category cat = Category.find(h.node); //62
                    h.node = Node.create(h.node,sequence,node.getCommunity(),new RV(member),cat.getCategory(),false,options,options1,defautllangauge,null,null,new java.util.Date(),0,0,0,0,null,h.language,name,"","",text,null,"",0,null,"","","","",null,null);
					node=Node.find(h.node);
				} else
                {
                    node.set(h.language,name,text);
                }
                Golf obj = Golf.find(h.node,h.language);

                String logo = teasession.getParameter("logo");
                boolean clearLogo = teasession.getParameter("ClearLogo") != null;
                if(clearLogo)
                {
                    logo = "";
                }
                obj.setLogo(logo);
                obj.setType(teasession.getParameter("type"));
                obj.setArea(teasession.getParameter("area"));
                obj.setMusicType(teasession.getParameter("musicType"));
                obj.setDeilStyle(teasession.getParameter("deilStyle"));
                obj.setCircumstance(teasession.getParameter("circumstance"));
                int options = 0;
                if(teasession.getParameter("depot") != null)
                {
                    options |= 1;
                }
                // if ( teasession.getParameter("ticket")!= null)
                // options |= 2;
                if(teasession.getParameter("open") != null)
                {
                    options |= 4;
                }
                if(teasession.getParameter("electron") != null)
                {
                    options |= 8;
                }
                obj.setOptions(options);
                obj.setTicket(teasession.getParameter("ticket"));
                obj.setSynopsis(teasession.getParameter("synopsis"));
                obj.setCapability(teasession.getParameter("capability"));
                obj.setPayment(teasession.getParameter("payment"));
                obj.setTrait(teasession.getParameter("trait"));
                obj.setDepreciate(teasession.getParameter("depreciate"));
                Date practiceHours = TimeSelection.makeTime(teasession.getParameter("StartYear"),teasession.getParameter("StartMonth"),teasession.getParameter("StartDay"));
                obj.setPracticeHours(practiceHours);
                obj.setAddress(teasession.getParameter("address"));
                obj.setPrincipal(teasession.getParameter("principal"));
                obj.setPhone(teasession.getParameter("phone"));
                obj.setFax(teasession.getParameter("fax"));
                obj.setPostalcode(teasession.getParameter("postalcode"));
                obj.setCooperate(teasession.getParameter("cooperate"));
                obj.setSponsor(teasession.getParameter("sponsor"));
                String starthour = teasession.getParameter("starthour");
                obj.setStartBusinessHours(starthour);
                obj.setEmail(teasession.getParameter("email"));
                obj.setConsume(teasession.getParameter("consume"));
                obj.setAcreage(teasession.getParameter("acreage"));
                obj.setAverageConsume(teasession.getParameter("averageConsume"));
                obj.setPrice(teasession.getParameter("price"));
                obj.setAmong(teasession.getParameter("among"));
                obj.setOperation(teasession.getParameter("operation"));
                obj.setLoo(teasession.getParameter("loo"));
                obj.setDestine(teasession.getParameter("destine"));
                obj.setBlock(teasession.getParameter("block"));
                obj.setCoverCharge(teasession.getParameter("coverCharge"));
                obj.setMember(teasession.getParameter("member"));
                // obj.setBrowse(teasession.getParameter("browse"));
                obj.setEmail(teasession.getParameter("email"));
                String map = teasession.getParameter("map");
                obj.setMap(map);
                obj.setStylist(teasession.getParameter("stylist"));
                obj.setCavity(teasession.getParameter("cavity"));
                obj.setHaulm(teasession.getParameter("haulm"));
                obj.setPLength(teasession.getParameter("plength"));
                obj.setPGrass(teasession.getParameter("pgrass"));
                obj.setCGrass(teasession.getParameter("cgrass"));
                obj.setMeGreen9W(teasession.getParameter("megreen9w"));
                obj.setMgGreen9W(teasession.getParameter("mggreen9w"));
                obj.setGgGreen9W(teasession.getParameter("gggreen9w"));
                obj.setViGreen9W(teasession.getParameter("vigreen9w"));
                obj.setMeGreen9H(teasession.getParameter("megreen9h"));
                obj.setMgGreen9H(teasession.getParameter("mggreen9h"));
                obj.setGgGreen9H(teasession.getParameter("gggreen9h"));
                obj.setViGreen9H(teasession.getParameter("vigreen9h"));
                obj.setMeGreen18W(teasession.getParameter("megreen18w"));
                obj.setMgGreen18W(teasession.getParameter("mggreen18w"));
                obj.setGgGreen18W(teasession.getParameter("gggreen18w"));
                obj.setViGreen18W(teasession.getParameter("vigreen18w"));
                obj.setMeGreen18H(teasession.getParameter("megreen18h"));
                obj.setMgGreen18H(teasession.getParameter("mggreen18h"));
                obj.setGgGreen18H(teasession.getParameter("gggreen18h"));
                obj.setViGreen18H(teasession.getParameter("vigreen18h"));
                obj.setMeExeunt(teasession.getParameter("meexeunt"));
                obj.setMgExeunt(teasession.getParameter("mgexeunt"));
                obj.setGgExeunt(teasession.getParameter("ggexeunt"));
                obj.setViExeunt(teasession.getParameter("viexeunt"));
                obj.setMeCaddie9(teasession.getParameter("mecaddie9"));
                obj.setMgCaddie9(teasession.getParameter("mgcaddie9"));
                obj.setGgCaddie9(teasession.getParameter("ggcaddie9"));
                obj.setViCaddie9(teasession.getParameter("vicaddie9"));
                obj.setMeCaddie9B(teasession.getParameter("mecaddie9b"));
                obj.setMgCaddie9B(teasession.getParameter("mgcaddie9b"));
                obj.setGgCaddie9B(teasession.getParameter("ggcaddie9b"));
                obj.setViCaddie9B(teasession.getParameter("vicaddie9b"));
                obj.setMeCaddie18(teasession.getParameter("mecaddie18"));
                obj.setMgCaddie18(teasession.getParameter("mgcaddie18"));
                obj.setGgCaddie18(teasession.getParameter("ggcaddie18"));
                obj.setViCaddie18(teasession.getParameter("vicaddie18"));
                obj.setMeCaddie18B(teasession.getParameter("mecaddie18b"));
                obj.setMgCaddie18B(teasession.getParameter("mgcaddie18b"));
                obj.setGgCaddie18B(teasession.getParameter("ggcaddie18b"));
                obj.setViCaddie18B(teasession.getParameter("vicaddie18b"));
                obj.setMeReserved(teasession.getParameter("mereserved"));
                obj.setMgReserved(teasession.getParameter("mgreserved"));
                obj.setGgReserved(teasession.getParameter("ggreserved"));
                obj.setViReserved(teasession.getParameter("vireserved"));
                obj.setMeBuggy9(teasession.getParameter("mebuggy9"));
                obj.setMgBuggy9(teasession.getParameter("mgbuggy9"));
                obj.setGgBuggy9(teasession.getParameter("ggbuggy9"));
                obj.setViBuggy9(teasession.getParameter("vibuggy9"));
                obj.setMeBuggy18(teasession.getParameter("mebuggy18"));
                obj.setMgBuggy18(teasession.getParameter("mgbuggy18"));
                obj.setGgBuggy18(teasession.getParameter("ggbuggy18"));
                obj.setViBuggy18(teasession.getParameter("vibuggy18"));
                obj.setMeDriving(teasession.getParameter("medriving"));
                obj.setMgDriving(teasession.getParameter("mgdriving"));
                obj.setGgDriving(teasession.getParameter("ggdriving"));
                obj.setViDriving(teasession.getParameter("vidriving"));
                obj.setMeClub(teasession.getParameter("meclub"));
                obj.setMgClub(teasession.getParameter("mgclub"));
                obj.setGgClub(teasession.getParameter("ggclub"));
                obj.setViClub(teasession.getParameter("viclub"));
                obj.setMeCommon(teasession.getParameter("mecommon"));
                obj.setMgCommon(teasession.getParameter("mgcommon"));
                obj.setGgCommon(teasession.getParameter("ggcommon"));
                obj.setViCommon(teasession.getParameter("vicommon"));
                obj.setMePro(teasession.getParameter("mepro"));
                obj.setMgPro(teasession.getParameter("mgpro"));
                obj.setGgPro(teasession.getParameter("ggpro"));
                obj.setViPro(teasession.getParameter("vipro"));
                obj.setMeSpiked(teasession.getParameter("mespiked"));
                obj.setMgSpiked(teasession.getParameter("mgspiked"));
                obj.setGgSpiked(teasession.getParameter("ggspiked"));
                obj.setViSpiked(teasession.getParameter("vispiked"));
                obj.setMeUmbrella(teasession.getParameter("meumbrella"));
                obj.setMgUmbrella(teasession.getParameter("mgumbrella"));
                obj.setGgUmbrella(teasession.getParameter("ggumbrella"));
                obj.setViUmbrella(teasession.getParameter("viumbrella"));
                obj.setMeFacilities(teasession.getParameter("mefacilities"));
                obj.setMgFacilities(teasession.getParameter("mgfacilities"));
                obj.setGgFacilities(teasession.getParameter("ggfacilities"));
                obj.setViFacilities(teasession.getParameter("vifacilities"));
                obj.setMeNonDesignatedW(teasession.getParameter("menondesignatedw"));
                obj.setMgNonDesignatedW(teasession.getParameter("mgnondesignatedw"));
                obj.setGgNonDesignatedW(teasession.getParameter("ggnondesignatedw"));
                obj.setViNonDesignatedW(teasession.getParameter("vinondesignatedw"));
                obj.setMeNonDesignatedH(teasession.getParameter("menondesignatedh"));
                obj.setMgNonDesignatedH(teasession.getParameter("mgnondesignatedh"));
                obj.setGgNonDesignatedH(teasession.getParameter("ggnondesignatedh"));
                obj.setViNonDesignatedH(teasession.getParameter("vinondesignatedh"));
                /*
                                 int[] standard = new int[18];
                                 String hole[] = obj.getHole();
                                 for(int i = 0;i < 18;i++)
                                 {
                    standard[i] = h.getInt("standard" + i);
                    if(standard[i] < 1)
                    {
                        standard[i] = 4;
                    }
                    obj.yardage[i] = h.getInt("yardage" + i);
                    boolean clearhole = teasession.getParameter("clearhole" + i) != null;
                    hole[i] = clearhole ? "" : teasession.getParameter("hole" + i);
                                 }
                                 obj.setHole(hole);

                                 obj.setStandard(standard);
                 */
                obj.url = teasession.getParameter("url");
               // obj.posid = teasession.getParameter("posid") + "-" + teasession.getParameter("seq");
                obj.posid = teasession.getParameter("posid");

                obj.set();
                if(map != null && map.length() > 0) //地图
                {
                    GMap.create(h.node,map,member);
                }
                delete(node);
                if(teasession.getParameter("GoBack") != null)
                {
                    response.sendRedirect("/servlet/EditNode?node=" + h.node);
                } else
                {
                    node.finished(h.node);
                    if(teasession.getParameter("GoNext") != null)
                    {
                        response.sendRedirect("/jsp/type/TypePicture.jsp?node=" + h.node);
                    } else
                    {
                        if(nexturl == null)
                        {
                            nexturl = "/servlet/Golf?node=" + h.node + "&edit=ON";
                        }
                        response.sendRedirect(nexturl);
                    }
                }
            }
        } catch(SQLException e)
        {
            e.printStackTrace();
        }
    }
}
