package tea.ui;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.net.*;
import tea.entity.*;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.ui.*;
import tea.http.*;
import tea.entity.util.*;
import java.sql.SQLException;
import tea.entity.citybcst.Cityname;
import tea.entity.league.*;
import tea.entity.site.*;
import tea.entity.admin.*;
import tea.service.SMS;
import tea.entity.pic.*;
import javax.imageio.*;
import java.awt.image.BufferedImage;

public class Ajax extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        String act = request.getParameter("act");
        request.setCharacterEncoding("upload".equals(act) ? "GBK" : "UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        ServletContext application = getServletContext();
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        Http h = new Http(request, response);
        try
        {
            if("sendx".equals(act))
            {
                String url = request.getParameter("url");
                String content = (String) Entity.open(url);
                out.print(content);
            } else if("script".equals(act))
            {
                String url = request.getParameter("url");
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                final PrintWriter pw = new PrintWriter(new OutputStreamWriter(baos,"UTF-8"));
                HttpServletResponse rep = new HttpServletResponseWrapper(response)
                {
                    public PrintWriter getWriter()
                    {
                        return pw;
                    }
                };
                RequestDispatcher rd = application.getRequestDispatcher(url);
                rd.forward(request,rep);
                pw.close();
                String content = new String(baos.toByteArray(),"UTF-8");
                content = "document.writeln(\"" + content.replaceAll("\"","\\\\\"").replaceAll("\r\n","\");\ndocument.writeln(\"") + "\");";
                out.print(content);
            } else if("9000key".equals(act))
            {
                String hardid = request.getParameter("hardid");
                String code = StoredValue.findByHardid(hardid);
                if(code != null && Profile.isExisted(code))
                {
                    out.print(code);
                }
            } else if("checkmember".equals(act))
            {
                String member = request.getParameter("member");
                out.print(Profile.isExisted(member));
            } else if("header".equals(act))
            {
                Enumeration e = request.getHeaderNames();
                while(e.hasMoreElements())
                {
                    String name = (String) e.nextElement();
                    String value = request.getHeader(name);
                    out.println(name + ": " + value + "<br/>");
                }
            } else if("click".equals(act))
            {
                StringBuilder sb = new StringBuilder();
                sb.append("var arr=new Array();");
                String ns[] = request.getParameterValues("node");
                for(int i = 0;i < ns.length;i++)
                {
                    Node n = Node.find(Integer.parseInt(ns[i]));
                    sb.append("arr['N").append(ns[i]).append("']=").append(n.getClick()).append(";");
                }
                out.print(sb.toString());
            } else if("http.length".equals(act))
            {
                Integer obj = (Integer) session.getAttribute(act);
                out.print(obj == null ? 0 : obj.intValue());

            } else if("nslookup".equals(act))
            {
                String host = request.getParameter("host");
                String arr[] = host.split(",+");
                for(int i = 0;i < arr.length;i++)
                {
                    try
                    {
                        InetAddress ia[] = InetAddress.getAllByName(arr[i]);
                        for(int j = 0;j < ia.length;j++)
                        {
                            out.print(ia[j].getHostAddress() + ",");
                        }
                    } catch(UnknownHostException ex)
                    {}
                    out.println();
                }
            } else if("weather".equals(act)) //天气
            {
                int node = Integer.parseInt(request.getParameter("node"));
                int listing = Integer.parseInt(request.getParameter("listing"));
                int language = Integer.parseInt(request.getParameter("language"));
                Node n = Node.find(node);
                Listing l = Listing.find(listing);
                String html = Weather.getDetail(n,language,listing,l.getTarget());
                out.print("document.write(\"" + html.replace("\n"," ").replaceAll("\"","\\\\\"") + "\");");
            } else if("phrase".equals(act)) //关键字提取
            {
                String phrase = request.getParameter("phrase");
                out.print(Phrase.findKey(phrase));
            }
//			else if("upload".equals(act)) //多线程上传,只接收不用返回
//            {
//                String file = teasession.getParameter("upload");
//                System.out.println("OK " + file + ":" + request.getQueryString());
//                if(file == null)
//                    return;
//                File f = new File(application.getRealPath(file));
//                BufferedImage bi = ImageIO.read(f);
//                int pic = Pic.create(request.getParameter("member"),f.getName(),bi.getWidth(),bi.getHeight());
//                Pic t = Pic.find(pic);
//                //
//                File f0 = new File(t.getPath0());
//                f0.getParentFile().mkdirs();
//                f.renameTo(f0);
//                t.code = f0.getName();
//                t.set("code",t.code.substring(0,t.code.length() - 4));
//                //2号图
//                File f2 = new File(application.getRealPath(t.path2));
//                f2.getParentFile().mkdirs();
//                bi = Img.scale(bi,600,600,false);
//                ImageIO.write(bi,"JPEG",f2);
//                //1号图
//                File f1 = new File(application.getRealPath(t.path1));
//                f1.getParentFile().mkdirs();
//                bi = Img.scale(bi,170,170,false);
//                ImageIO.write(bi,"JPEG",f1);
//            }
            else if("uploadid".equals(act))
            {
                String uploadid = request.getParameter("uploadid");
                String pro = (String) session.getAttribute(uploadid);
                if(pro != null)
                {
                    out.print(pro);
                }
            } else if("dynamictype_binding".equals(act)) //编辑动态类->绑定
            {
                int dynamic = Integer.parseInt(request.getParameter("dynamic"));
                int language = Integer.parseInt(request.getParameter("language"));
                Enumeration e = DynamicType.findByDynamic(dynamic);
                while(e.hasMoreElements())
                {
                    int id = ((Integer) e.nextElement()).intValue();
                    DynamicType dt = DynamicType.find(id);
                    out.print("op[op.length]=new Option(\"" + dt.getName(language) + "\"," + id + ");");
                }
            } else if("waiter".equals(act)) //作业员编号,是否重复...
            {
                int node = Integer.parseInt(request.getParameter("node"));
                String code = request.getParameter("code");
                int j = Waiter.findByCode(code);
                out.print(j > 0 && j != node);
            } else if("pic".equals(act))
            {
                String url = request.getParameter("url");
                File f = new File(application.getRealPath("/res/pic/" + url + ".jpg"));
                f.getParentFile().mkdirs();
                Html2Pic.toPic("http://127.0.0.1/jsp/include/Pic.jsp?url=http://" + url,f);
            } else if("cityname".equals(act))
            {
                String value = request.getParameter("value");
                Enumeration eu2 = Cityname.findByCommunity(" and fatherid=" + value,0,100);
                out.print("new Array(");
                for(int i = 0;eu2.hasMoreElements();i++)
                {
                    int id2 = Integer.parseInt(String.valueOf(eu2.nextElement()));
                    Cityname cityobj2 = Cityname.find(id2);
                    if(i > 0)
                    {
                        out.print(",");
                    }
                    out.print("new Array(" + id2 + ",\"" + cityobj2.getCityname() + "\")");
                }
                out.print(")");
            } else if("leagueshop".equals(act))
            {
                String value = request.getParameter("value");
                Enumeration eu3 = LeagueShopServer.findByCommunity(""," and lstypeid=" + value,0,100);
                out.print("new Array(");
                for(int i = 0;eu3.hasMoreElements();i++)
                {
                    int id2 = Integer.parseInt(String.valueOf(eu3.nextElement()));
                    LeagueShopServer obj2 = LeagueShopServer.find(id2);
                    if(i > 0)
                    {
                        out.print(",");
                    }
                    out.print("new Array(" + id2 + ",\"" + obj2.getLssname() + "\")");
                }
                out.print(")");
            } else if("report".equals(act))
            {
                String value = request.getParameter("value");
                Enumeration er = ClassesChild.findByCommunity(""," and class_id=" + value,0,100);
                out.print("new Array(");
                for(int i = 0;er.hasMoreElements();i++)
                {
                    int id2 = Integer.parseInt(String.valueOf(er.nextElement()));
                    ClassesChild obj2 = ClassesChild.find(id2);
                    if(i > 0)
                    {
                        out.print(",");
                    }
                    out.print("new Array(" + id2 + ",\"" + obj2.getName() + "\")");
                }
                out.print(")");
            } else if("sub_f_login".equals(act)) //订阅登录判断
            {

                String member = request.getParameter("member");
                String pass = request.getParameter("pass");
                if(!Profile.isPassword(member,pass))
                {
                    out.print("您的用户名或密码错误！");
                    return;
                }
                //---添加Cookie--------//////////
                Profile p = Profile.find(member);
                Cookie cs = new Cookie("tea.RV",java.net.URLEncoder.encode(member + "," + SMS.md5(String.valueOf(p.getTime().getTime())),"UTF-8"));
                cs.setPath("/");
                String sn = request.getServerName();
                int j = sn.indexOf(".");
                if(j != -1 && sn.charAt(sn.length() - 1) > 96)
                {
                    cs.setDomain(sn.substring(j));
                }
                response.addCookie(cs);

            }else if("checkmob".equals(act)){//验证手机
              	 String mob = h.get("mob");
              	 int flag = Profile.count(" AND deleted = 0 AND mobile = "+Database.cite(mob));
              	 //int flag = Member.count(" and username = "+Database.cite(mob));
              	 if(flag>0){
              		 out.print("t");
              		 return;
              	 }else{
              		 out.print("");
              		return;
              	 }
               }else if ("getyzm".equals(act)) {
           		//发送手机验证码
           		StringBuffer sp = new StringBuffer();
           		String mymob = h.get("mob");
           			//发送手机验证码
           			int b = (int) (Math.random() * 1000000);

           			session.setAttribute(mymob + "_code", String.valueOf(b));

           			String c = "您好，感谢您注册医疗会员，请在页面输入验证码为“" + b
           					+ "”";
           			System.out.println(b);
           			String rs = SMSMessage.create(h.community,"webmaster", mymob,
           					h.language, c);
           			/*int[] rs = SMessage.send(1, h.member, h.get("members", "|"), mob, 0, c, out);
           			Writer out1 = request.*/
                      /*if (rs == null)
                      	sp.append("t");*/
                      /*else
                      	sp.append("f");*/
           			
           		out.print(sp);
           		return;
           	} else
            {
                TeaSession teasession = new TeaSession(request);
                if(teasession._rv == null)
                {
                    return;
                }
                if("openidproxy".equals(act))
                {
                    String sn = request.getServerName();
                    if(OpenID.isOpen())
                    {
                        OpenID oid = OpenID.find(teasession._rv.toString());
                        String str = oid.getProxy();
                        if(str != null)
                        {
                            sn = str;
                        }
                    }
                    out.print(sn);
                } else if("menu".equals(act))
                {
                    String q = request.getParameter("q");
                    out.print(AdminFunction.getSysMenu(teasession,q));
                } else if("lastlogin".equals(act))
                {
                    out.print(Entity.sdf2.format(Logs.getLastLogin(teasession._rv.toString())));
                } else
                {
                    Node node = Node.find(teasession._nNode);
                    if(request.getParameter("sclient_balance") != null)
                    {
                        String community = request.getParameter("community");
                        if(community == null)
                        {
                            community = node.getCommunity();
                        }
                        String member = request.getParameter("member");
                        SClient sc = SClient.find(community,member);
                        out.print(sc.getPrice());
                    }
                }
            }
        } catch(Throwable ex)
        {
            ex.printStackTrace();
        } finally
        {
            out.flush(); //这是不能close();
        }
    }
}
