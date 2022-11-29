package tea.ui.admin.orthonline;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.entity.admin.erp.*;
import javax.servlet.http.HttpSession;
import tea.entity.member.*;
import tea.entity.admin.*;
import tea.entity.node.*;
import tea.entity.admin.orthonline.*;
import tea.entity.util.ZoomOut;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;


public class EditCaseCollection extends TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        String act = teasession.getParameter("act");
        String community = teasession.getParameter("community");
        String nexturl = teasession.getParameter("nexturl");

        try
        {
            ServletContext application = getServletContext();
            if("shenhe".equals(act))
            {
                int id = 0;
                if(teasession.getParameter("ids") != null && teasession.getParameter("ids").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("ids"));
                }
                Date regtime = new Date();

                String mobilephone = "";
                if(teasession.getParameter("mobilephone") != null && teasession.getParameter("mobilephone").length() > 0)
                {
                    mobilephone = teasession.getParameter("mobilephone"); //
                } else
                {
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<script>alert('请填写手机号!');	window.location.href='/servlet/Node?node=" + teasession._nNode + "&ids=" + id + "';</script>");
                    out.flush();
                    out.close();
                    return;
                }
                if(id == 0)
                {
                    id = CaseCollection.gettel(mobilephone);
                    if(id != 0)
                    {

                        java.io.PrintWriter out = response.getWriter();
                        out.println("<script>alert('此手机号已经提交过病例!');	window.location.href='/servlet/Node?node=" + teasession._nNode + "&ids=" + id + "';</script>");
                        out.flush();
                        out.close();
                        return;
                    }
                }
                int sex = 0;
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex"));
                }

                String casename = teasession.getParameter("casename"); //标题名称
                String age = teasession.getParameter("age");
                String chief = teasession.getParameter("chief"); //主诉
                String gjttpain = teasession.getParameter("gjttpain"); //关节疼痛部位

                String heartpain = ""; //冠心病史
                if(teasession.getParameter("heartpain") != null && teasession.getParameter("heartpain").length() > 0)
                {
                    heartpain = (teasession.getParameter("heartpain"));
                }
                String weichangdao = ""; //胃肠道疾病
                if(teasession.getParameter("weichangdao") != null && teasession.getParameter("weichangdao").length() > 0)
                {
                    weichangdao = (teasession.getParameter("weichangdao"));
                }
                String otherpain = teasession.getParameter("otherpain"); //其他特殊病史或服药史otherpain,jointjixingbw,otherjiancha,chubuzhenduan,zzjingguo
                String jointjixingbw = teasession.getParameter("jointjixingbw"); //关节畸形部位
                String jointyatongbw = teasession.getParameter("jointyatongbw"); //关节畸形有无
                String chubuzhenduan = teasession.getParameter("chubuzhenduan"); //关节畸形有无
                int gjttnumfrist = 0; //关节畸形有无
                if(teasession.getParameter("gjttnumfrist") != null && teasession.getParameter("gjttnumfrist").length() > 0)
                {
                    gjttnumfrist = Integer.parseInt(teasession.getParameter("gjttnumfrist"));
                }

                int gjttnumlast = 0; //关节畸形有无
                if(teasession.getParameter("gjttnumlast") != null && teasession.getParameter("gjttnumlast").length() > 0)
                {
                    gjttnumlast = Integer.parseInt(teasession.getParameter("gjttnumlast"));
                }
                String yxfirstpath = teasession.getParameter("yxfirstpath");
                String yxlastpath = teasession.getParameter("yxlastpath");
                String yxfirstpath2 = teasession.getParameter("yxfirstpath2");
                String yxlastpath2 = teasession.getParameter("yxlastpath2");
                String yxfirstpath3 = teasession.getParameter("yxfirstpath3");
                String yxlastpath3 = teasession.getParameter("yxlastpath3");
                String yxfirstpath4 = teasession.getParameter("yxfirstpath4");
                String yxlastpath4 = teasession.getParameter("yxlastpath4");
                String yxfirstpath5 = teasession.getParameter("yxfirstpath5");
                String yxlastpath5 = teasession.getParameter("yxlastpath5");

                String yxfirstpathname = teasession.getParameter("yxfirstpathname");
                String yxlastpathname = teasession.getParameter("yxlastpathname");
                String yxfirstpathname2 = teasession.getParameter("yxfirstpathname2");
                String yxlastpathname2 = teasession.getParameter("yxlastpathname2");
                String yxfirstpathname3 = teasession.getParameter("yxfirstpathname3");
                String yxlastpathname3 = teasession.getParameter("yxlastpathname3");
                String yxfirstpathname4 = teasession.getParameter("yxfirstpathname4");
                String yxlastpathname4 = teasession.getParameter("yxlastpathname4");
                String yxfirstpathname5 = teasession.getParameter("yxfirstpathname5");
                String yxlastpathname5 = teasession.getParameter("yxlastpathname5");
                String zhuanjiadp = teasession.getParameter("zhuanjiadp");
        	    String result= teasession.getParameter("result");//结果
			    String discuss = teasession.getParameter("discuss");//讨论
			    String documents = teasession.getParameter("documents");//参考文献
			    String ana = teasession.getParameter("ana");//英雄语录(您执业生涯中的感言)
                CaseCollection ccobj = CaseCollection.find(id);
                String member = ccobj.getMember();

                if(ccobj.isExists())
                {
                    //1
                    if(yxfirstpath != null && yxfirstpath.length() > 0)
                    {
                        yxfirstpath = yxfirstpath;
                        File fpic = new File(application.getRealPath(yxfirstpath));
                        if(yxfirstpathname.length() == 0)
                        {
                            yxfirstpathname = fpic.getName();
                        }

                        BufferedImage bi = ImageIO.read(fpic);
                        ZoomOut zo = new ZoomOut();
                        BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
                        BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
                        java.awt.Graphics2D g = zbi2.createGraphics();
                        g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
                        g.dispose();
                        try
                        {
                            ImageIO.write(zbi2,"JPEG",fpic);
                        } catch(Exception ex)
                        {
                            ImageIO.write(zbi2,"BMP",fpic);
                        }

                    } else
                    {
                        yxfirstpath = ccobj.getYxfirstpath();
                    }
                    if(yxlastpath != null && yxlastpath.length() > 0)
                    {
                        yxlastpath = yxlastpath;
                        File fpic = new File(application.getRealPath(yxlastpath));
                        if(yxlastpathname.length() == 0)
                        {
                            yxlastpathname = fpic.getName();
                        }

                        BufferedImage bi = ImageIO.read(fpic);
                        ZoomOut zo = new ZoomOut();
                        BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
                        BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
                        java.awt.Graphics2D g = zbi2.createGraphics();
                        g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
                        g.dispose();
                        try
                        {
                            ImageIO.write(zbi2,"JPEG",fpic);
                        } catch(Exception ex)
                        {
                            ImageIO.write(zbi2,"BMP",fpic);
                        }

                    } else
                    {
                        yxlastpath = ccobj.getYxlastpath();

                    }
                    ///2
                    if(yxfirstpath2 != null && yxfirstpath2.length() > 0)
                    {
                        yxfirstpath2 = yxfirstpath2;
                        File fpic = new File(application.getRealPath(yxfirstpath2));
                        if(yxfirstpathname2.length() == 0)
                        {
                            yxfirstpathname2 = fpic.getName();
                        }

                        BufferedImage bi = ImageIO.read(fpic);
                        ZoomOut zo = new ZoomOut();
                        BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
                        BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
                        java.awt.Graphics2D g = zbi2.createGraphics();
                        g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
                        g.dispose();
                        try
                        {
                            ImageIO.write(zbi2,"JPEG",fpic);
                        } catch(Exception ex)
                        {
                            ImageIO.write(zbi2,"BMP",fpic);
                        }

                    } else
                    {
                        yxfirstpath2 = ccobj.getYxfirstpath2();

                    }
                    if(yxlastpath2 != null && yxlastpath2.length() > 0)
                    {
                        yxlastpath2 = yxlastpath2;
                        File fpic = new File(application.getRealPath(yxlastpath2));
                        if(yxlastpathname2.length() == 0)
                        {
                            yxlastpathname2 = fpic.getName();
                        }

                        BufferedImage bi = ImageIO.read(fpic);
                        ZoomOut zo = new ZoomOut();
                        BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
                        BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
                        java.awt.Graphics2D g = zbi2.createGraphics();
                        g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
                        g.dispose();
                        try
                        {
                            ImageIO.write(zbi2,"JPEG",fpic);
                        } catch(Exception ex)
                        {
                            ImageIO.write(zbi2,"BMP",fpic);
                        }

                    } else
                    {
                        yxlastpath2 = ccobj.getYxlastpath2();

                    }
                    ///3
                    if(yxfirstpath3 != null && yxfirstpath3.length() > 0)
                    {
                        yxfirstpath3 = yxfirstpath3;
                        File fpic = new File(application.getRealPath(yxfirstpath3));
                        if(yxfirstpathname3.length() == 0)
                        {
                            yxfirstpathname3 = fpic.getName();
                        }

                        BufferedImage bi = ImageIO.read(fpic);
                        ZoomOut zo = new ZoomOut();
                        BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
                        BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
                        java.awt.Graphics2D g = zbi2.createGraphics();
                        g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
                        g.dispose();
                        try
                        {
                            ImageIO.write(zbi2,"JPEG",fpic);
                        } catch(Exception ex)
                        {
                            ImageIO.write(zbi2,"BMP",fpic);
                        }

                    } else
                    {
                        yxfirstpath3 = ccobj.getYxfirstpath3();

                    }
                    if(yxlastpath3 != null && yxlastpath3.length() > 0)
                    {
                        yxlastpath3 = yxlastpath3;
                        File fpic = new File(application.getRealPath(yxlastpath3));
                        if(yxlastpathname3.length() == 0)
                        {
                            yxlastpathname3 = fpic.getName();
                        }

                        BufferedImage bi = ImageIO.read(fpic);
                        ZoomOut zo = new ZoomOut();
                        BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
                        BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
                        java.awt.Graphics2D g = zbi2.createGraphics();
                        g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
                        g.dispose();
                        try
                        {
                            ImageIO.write(zbi2,"JPEG",fpic);
                        } catch(Exception ex)
                        {
                            ImageIO.write(zbi2,"BMP",fpic);
                        }

                    } else
                    {
                        yxlastpath3 = ccobj.getYxlastpath3();

                    }

                    ///4
                    if(yxfirstpath4 != null && yxfirstpath4.length() > 0)
                    {
                        yxfirstpath4 = yxfirstpath4;
                        File fpic = new File(application.getRealPath(yxfirstpath4));
                        if(yxfirstpathname4.length() == 0)
                        {
                            yxfirstpathname4 = fpic.getName();
                        }

                        BufferedImage bi = ImageIO.read(fpic);
                        ZoomOut zo = new ZoomOut();
                        BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
                        BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
                        java.awt.Graphics2D g = zbi2.createGraphics();
                        g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
                        g.dispose();
                        try
                        {
                            ImageIO.write(zbi2,"JPEG",fpic);
                        } catch(Exception ex)
                        {
                            ImageIO.write(zbi2,"BMP",fpic);
                        }

                    } else
                    {
                        yxfirstpath4 = ccobj.getYxfirstpath4();
                    }
                    if(yxlastpath4 != null && yxlastpath4.length() > 0)
                    {
                        yxlastpath4 = yxlastpath4;
                        File fpic = new File(application.getRealPath(yxlastpath4));
                        if(yxlastpathname4.length() == 0)
                        {
                            yxlastpathname4 = fpic.getName();
                        }

                        BufferedImage bi = ImageIO.read(fpic);
                        ZoomOut zo = new ZoomOut();
                        BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
                        BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
                        java.awt.Graphics2D g = zbi2.createGraphics();
                        g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
                        g.dispose();
                        try
                        {
                            ImageIO.write(zbi2,"JPEG",fpic);
                        } catch(Exception ex)
                        {
                            ImageIO.write(zbi2,"BMP",fpic);
                        }

                    } else
                    {
                        yxlastpath4 = ccobj.getYxlastpath4();
                    }
                    ///5
                    if(yxfirstpath5 != null && yxfirstpath5.length() > 0)
                    {
                        yxfirstpath5 = yxfirstpath5;
                        File fpic = new File(application.getRealPath(yxfirstpath5));
                        if(yxfirstpathname5.length() == 0)
                        {
                            yxfirstpathname5 = fpic.getName();
                        }

                        BufferedImage bi = ImageIO.read(fpic);
                        ZoomOut zo = new ZoomOut();
                        BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
                        BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
                        java.awt.Graphics2D g = zbi2.createGraphics();
                        g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
                        g.dispose();
                        try
                        {
                            ImageIO.write(zbi2,"JPEG",fpic);
                        } catch(Exception ex)
                        {
                            ImageIO.write(zbi2,"BMP",fpic);
                        }
                    } else
                    {
                        yxfirstpath5 = ccobj.getYxfirstpath5();
                    }
                    if(yxlastpath5 != null && yxlastpath5.length() > 0)
                    {
                        yxlastpath5 = yxlastpath5;
                        File fpic = new File(application.getRealPath(yxlastpath5));
                        if(yxlastpathname5.length() == 0)
                        {
                            yxlastpathname5 = fpic.getName();
                        }

                        BufferedImage bi = ImageIO.read(fpic);
                        ZoomOut zo = new ZoomOut();
                        BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
                        BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
                        java.awt.Graphics2D g = zbi2.createGraphics();
                        g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
                        g.dispose();
                        try
                        {
                            ImageIO.write(zbi2,"JPEG",fpic);
                        } catch(Exception ex)
                        {
                            ImageIO.write(zbi2,"BMP",fpic);
                        }

                    } else
                    {
                        yxlastpath5 = ccobj.getYxlastpath5();
                    }

                }
                String firstname = teasession.getParameter("firstname");
                String address = teasession.getParameter("address");

                String doingsxbw = teasession.getParameter("doingsxbw"); //活动受限
                String gjttother = teasession.getParameter("gjttother");
                String otheryichang = teasession.getParameter("otheryichang");
                String yingxiang = teasession.getParameter("yingxiang");
                String yichang = teasession.getParameter("yichang");
                String zzjingguo = teasession.getParameter("zzjingguo");
                String taolun = teasession.getParameter("taolun");
				String zjname = teasession.getParameter("zjname");
				String zjyy = teasession.getParameter("zjyy");
				
	
			    CaseCollection.set(id,teasession._strCommunity,regtime,member,mobilephone,casename,sex,age,chief,gjttpain,doingsxbw,gjttother,heartpain,weichangdao,otherpain,
                		jointjixingbw,jointyatongbw,otheryichang,yingxiang,yichang,gjttnumfrist,chubuzhenduan,zzjingguo,gjttnumlast,taolun,yxfirstpath,yxlastpath,
                		0,yxfirstpath2,yxlastpath2,yxfirstpath3,yxlastpath3,yxfirstpath4,yxlastpath4,yxfirstpath5,yxlastpath5,firstname,address,yxfirstpathname,
                		yxlastpathname,yxfirstpathname2,yxlastpathname2,yxfirstpathname3,yxlastpathname3,yxfirstpathname4,yxlastpathname4,yxfirstpathname5,
                		yxlastpathname5,zhuanjiadp,zjname,zjyy,result,discuss,documents,ana);
                CaseCollection.setType(id,1);
                java.io.PrintWriter out = response.getWriter();
                out.println("<script>alert('审核信息通过！');	window.location.href='/jsp/admin/orthonline/CaseCollection.jsp?type=0';</script>");
                out.flush();
                out.close();
                return;
            }

            if("updateEditCaseCollection".equals(act))
            {
                int id = 0;
                if(teasession.getParameter("ids") != null && teasession.getParameter("ids").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("ids"));
                }

                String member = "";
                if(teasession.getParameter("member") != null && teasession.getParameter("member").length() > 0)
                {
                    member = teasession.getParameter("member"); //
                } else
                {
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<script>alert('请填写用户ID!');	window.location.href='/jsp/admin/orthonline/CaseCollection.jsp?type=0';</script>");
                    out.flush();
                    out.close();
                    return;
                }

                String password = "";
                if(teasession.getParameter("password") != null && teasession.getParameter("password").length() > 0)
                {
                    password = teasession.getParameter("password"); //
                }
                String mobilephone = "";
                if(teasession.getParameter("mobilephone") != null && teasession.getParameter("mobilephone").length() > 0)
                {
                    mobilephone = teasession.getParameter("mobilephone"); //
                }
                if(!Profile.isExisted(member))
                {
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<script>alert('用户不存在，无法修改病例资料！');	window.location.href='/servlet/Node?node=" + teasession._nNode + "&ids=" + id + "';</script>");
                    out.flush();
                    out.close();
                    return;
                }
                if(!Profile.isPassword(member,password))
                {
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<script>alert('用户名与密码不符，请重新填写！');	window.location.href='/servlet/Node?node=" + teasession._nNode + "&ids=" + id + "';</script>");
                    out.flush();
                    out.close();
                    return;
                }
                if(id == 0)
                {
                    id = CaseCollection.getMembers(member);
                    if(id != 0)
                    {
                        java.io.PrintWriter out = response.getWriter();
                        out.println("<script>alert('修改病例信息！');	window.location.href='/servlet/Node?node=" + teasession._nNode + "&ids=" + id + "';</script>");
                        out.flush();
                        out.close();
                        return;
                    } else
                    {
                        java.io.PrintWriter out = response.getWriter();
                        out.println("<script>alert('您没有提交过病例，请重新填写！');	window.location.href='/servlet/Node?node=" + teasession._nNode + "&ids=" + id + "';</script>");
                        out.flush();
                        out.close();
                        return;
                    }
                }
            }
            if("EditCaseCollection".equals(act))
            {
                int id = 0;
                if(teasession.getParameter("ids") != null && teasession.getParameter("ids").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("ids"));
                }
                Date regtime = new Date();
                String firstname = teasession.getParameter("firstname");
                String password = teasession.getParameter("password");
                String mobilephone = "";
                if(teasession.getParameter("mobilephone") != null && teasession.getParameter("mobilephone").length() > 0)
                {
                    mobilephone = teasession.getParameter("mobilephone"); //
                } else
                {
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<script>alert('请填写手机号!');	window.location.href='/servlet/Node?node=" + teasession._nNode + "&ids=" + id + "';</script>");
                    out.flush();
                    out.close();
                    return;
                }
                int sex = 0;
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex"));
                }
                String member = "";
                if(teasession.getParameter("member") != null && teasession.getParameter("member").length() > 0)
                {
                    member = teasession.getParameter("member");
                    if(Profile.isExisted(member))
                    {
                        if(!Profile.isPassword(member,password))
                        {
                            java.io.PrintWriter out = response.getWriter();
                            out.println("<script>alert('您填写的用户名与密码不符，请重新填写！');	window.location.href='/servlet/Node?node=" + teasession._nNode + "&ids=" + id + "';</script>");
                            out.flush();
                            out.close();
                            return;
                        }
                    } else
                    {
                        Profile.create(member,teasession._nLanguage,"",password,mobilephone,firstname,sex,teasession._strCommunity,0,"",1);
                    }
                } else
                {
                    java.io.PrintWriter out = response.getWriter();
                    out.println("<script>alert('请填写用户名!');	window.location.href='/servlet/Node?node=" + teasession._nNode + "';</script>");
                    out.flush();
                    out.close();
                    return;
                }

                if(id == 0)
                {
                    id = CaseCollection.getMembers(member);
                    if(id != 0)
                    {
    
                        java.io.PrintWriter out = response.getWriter();
                        out.println("<script>alert('此手机号已经提交过病例!');	window.location.href='/servlet/Node?node=" + teasession._nNode + "&ids=" + id + "';</script>");
                        out.flush();
                        out.close();
                        return;
                    }
                }
                String casename = teasession.getParameter("casename"); //标题名称
                String age = teasession.getParameter("age");
                String chief = teasession.getParameter("chief"); //主诉
                String gjttpain = teasession.getParameter("gjttpain"); //关节疼痛部位

                String heartpain = ""; //冠心病史
                if(teasession.getParameter("heartpain") != null && teasession.getParameter("heartpain").length() > 0)
                {
                    heartpain = (teasession.getParameter("heartpain"));
                }
                String weichangdao = ""; //胃肠道疾病
                if(teasession.getParameter("weichangdao") != null && teasession.getParameter("weichangdao").length() > 0)
                {
                    weichangdao = (teasession.getParameter("weichangdao"));
                }
                String otherpain = teasession.getParameter("otherpain"); //其他特殊病史或服药史otherpain,jointjixingbw,otherjiancha,chubuzhenduan,zzjingguo
                String jointjixingbw = teasession.getParameter("jointjixingbw"); //关节畸形部位
                String jointyatongbw = teasession.getParameter("jointyatongbw"); //关节畸形有无
                String chubuzhenduan = teasession.getParameter("chubuzhenduan"); //关节畸形有无
                int gjttnumfrist = 0; //关节畸形有无
                if(teasession.getParameter("gjttnumfrist") != null && teasession.getParameter("gjttnumfrist").length() > 0)
                {
                    gjttnumfrist = Integer.parseInt(teasession.getParameter("gjttnumfrist"));
                }

                int gjttnumlast = 0; //关节畸形有无
                if(teasession.getParameter("gjttnumlast") != null && teasession.getParameter("gjttnumlast").length() > 0)
                {
                    gjttnumlast = Integer.parseInt(teasession.getParameter("gjttnumlast"));
                }
                String yxfirstpath = teasession.getParameter("yxfirstpath");
                String yxlastpath = teasession.getParameter("yxlastpath");
                String yxfirstpath2 = teasession.getParameter("yxfirstpath2");
                String yxlastpath2 = teasession.getParameter("yxlastpath2");
                String yxfirstpath3 = teasession.getParameter("yxfirstpath3");
                String yxlastpath3 = teasession.getParameter("yxlastpath3");
                String yxfirstpath4 = teasession.getParameter("yxfirstpath4");
                String yxlastpath4 = teasession.getParameter("yxlastpath4");
                String yxfirstpath5 = teasession.getParameter("yxfirstpath5");
                String yxlastpath5 = teasession.getParameter("yxlastpath5");
                CaseCollection ccobj = CaseCollection.find(id);

                String yxfirstpathname = teasession.getParameter("yxfirstpathname");
                String yxlastpathname = teasession.getParameter("yxlastpathname");
                String yxfirstpathname2 = teasession.getParameter("yxfirstpathname2");
                String yxlastpathname2 = teasession.getParameter("yxlastpathname2");
                String yxfirstpathname3 = teasession.getParameter("yxfirstpathname3");
                String yxlastpathname3 = teasession.getParameter("yxlastpathname3");
                String yxfirstpathname4 = teasession.getParameter("yxfirstpathname4");
                String yxlastpathname4 = teasession.getParameter("yxlastpathname4");
                String yxfirstpathname5 = teasession.getParameter("yxfirstpathname5");
                String yxlastpathname5 = teasession.getParameter("yxlastpathname5");
                String zhuanjiadp = teasession.getParameter("zhuanjiadp");
    		    String result= teasession.getParameter("result");//结果
			    String discuss = teasession.getParameter("discuss");//讨论
			    String documents = teasession.getParameter("documents");//参考文献
			    String ana = teasession.getParameter("ana");//英雄语录(您执业生涯中的感言)

				if(ccobj.isExists())
			   {
				   //1
				   if(yxfirstpath != null && yxfirstpath.length() > 0)
				   {
					   yxfirstpath = yxfirstpath;
					   File fpic = new File(application.getRealPath(yxfirstpath));
					   if(yxfirstpathname.length() == 0)
					   {
						   yxfirstpathname = fpic.getName();
					   }

					   BufferedImage bi = ImageIO.read(fpic);
					   ZoomOut zo = new ZoomOut();
					   BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
					   BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
					   java.awt.Graphics2D g = zbi2.createGraphics();
					   g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
					   g.dispose();
					   try
					   {
						   ImageIO.write(zbi2,"JPEG",fpic);
					   } catch(Exception ex)
					   {
						   ImageIO.write(zbi2,"BMP",fpic);
					   }

				   } else
				   {
					   yxfirstpath = ccobj.getYxfirstpath();
				   }
				   if(yxlastpath != null && yxlastpath.length() > 0)
				   {
					   yxlastpath = yxlastpath;
					   File fpic = new File(application.getRealPath(yxlastpath));
					   if(yxlastpathname.length() == 0)
					   {
						   yxlastpathname = fpic.getName();
					   }

					   BufferedImage bi = ImageIO.read(fpic);
					   ZoomOut zo = new ZoomOut();
					   BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
					   BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
					   java.awt.Graphics2D g = zbi2.createGraphics();
					   g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
					   g.dispose();
					   try
					   {
						   ImageIO.write(zbi2,"JPEG",fpic);
					   } catch(Exception ex)
					   {
						   ImageIO.write(zbi2,"BMP",fpic);
					   }

				   } else
				   {
					   yxlastpath = ccobj.getYxlastpath();

				   }
				   ///2
				   if(yxfirstpath2 != null && yxfirstpath2.length() > 0)
				   {
					   yxfirstpath2 = yxfirstpath2;
					   File fpic = new File(application.getRealPath(yxfirstpath2));
					   if(yxfirstpathname2.length() == 0)
					   {
						   yxfirstpathname2 = fpic.getName();
					   }

					   BufferedImage bi = ImageIO.read(fpic);
					   ZoomOut zo = new ZoomOut();
					   BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
					   BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
					   java.awt.Graphics2D g = zbi2.createGraphics();
					   g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
					   g.dispose();
					   try
					   {
						   ImageIO.write(zbi2,"JPEG",fpic);
					   } catch(Exception ex)
					   {
						   ImageIO.write(zbi2,"BMP",fpic);
					   }

				   } else
				   {
					   yxfirstpath2 = ccobj.getYxfirstpath2();

				   }
				   if(yxlastpath2 != null && yxlastpath2.length() > 0)
				   {
					   yxlastpath2 = yxlastpath2;
					   File fpic = new File(application.getRealPath(yxlastpath2));
					   if(yxlastpathname2.length() == 0)
					   {
						   yxlastpathname2 = fpic.getName();
					   }

					   BufferedImage bi = ImageIO.read(fpic);
					   ZoomOut zo = new ZoomOut();
					   BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
					   BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
					   java.awt.Graphics2D g = zbi2.createGraphics();
					   g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
					   g.dispose();
					   try
					   {
						   ImageIO.write(zbi2,"JPEG",fpic);
					   } catch(Exception ex)
					   {
						   ImageIO.write(zbi2,"BMP",fpic);
					   }

				   } else
				   {
					   yxlastpath2 = ccobj.getYxlastpath2();

				   }
				   ///3
				   if(yxfirstpath3 != null && yxfirstpath3.length() > 0)
				   {
					   yxfirstpath3 = yxfirstpath3;
					   File fpic = new File(application.getRealPath(yxfirstpath3));
					   if(yxfirstpathname3.length() == 0)
					   {
						   yxfirstpathname3 = fpic.getName();
					   }

					   BufferedImage bi = ImageIO.read(fpic);
					   ZoomOut zo = new ZoomOut();
					   BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
					   BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
					   java.awt.Graphics2D g = zbi2.createGraphics();
					   g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
					   g.dispose();
					   try
					   {
						   ImageIO.write(zbi2,"JPEG",fpic);
					   } catch(Exception ex)
					   {
						   ImageIO.write(zbi2,"BMP",fpic);
					   }

				   } else
				   {
					   yxfirstpath3 = ccobj.getYxfirstpath3();

				   }
				   if(yxlastpath3 != null && yxlastpath3.length() > 0)
				   {
					   yxlastpath3 = yxlastpath3;
					   File fpic = new File(application.getRealPath(yxlastpath3));
					   if(yxlastpathname3.length() == 0)
					   {
						   yxlastpathname3 = fpic.getName();
					   }

					   BufferedImage bi = ImageIO.read(fpic);
					   ZoomOut zo = new ZoomOut();
					   BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
					   BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
					   java.awt.Graphics2D g = zbi2.createGraphics();
					   g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
					   g.dispose();
					   try
					   {
						   ImageIO.write(zbi2,"JPEG",fpic);
					   } catch(Exception ex)
					   {
						   ImageIO.write(zbi2,"BMP",fpic);
					   }

				   } else
				   {
					   yxlastpath3 = ccobj.getYxlastpath3();

				   }
				   ///4
				   if(yxfirstpath4 != null && yxfirstpath4.length() > 0)
				   {
					   yxfirstpath4 = yxfirstpath4;
					   File fpic = new File(application.getRealPath(yxfirstpath4));
					   if(yxfirstpathname4.length() == 0)
					   {
						   yxfirstpathname4 = fpic.getName();
					   }

					   BufferedImage bi = ImageIO.read(fpic);
					   ZoomOut zo = new ZoomOut();
					   BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
					   BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
					   java.awt.Graphics2D g = zbi2.createGraphics();
					   g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
					   g.dispose();
					   try
					   {
						   ImageIO.write(zbi2,"JPEG",fpic);
					   } catch(Exception ex)
					   {
						   ImageIO.write(zbi2,"BMP",fpic);
					   }

				   } else
				   {
					   yxfirstpath4 = ccobj.getYxfirstpath4();
				   }
				   if(yxlastpath4 != null && yxlastpath4.length() > 0)
				   {
					   yxlastpath4 = yxlastpath4;
					   File fpic = new File(application.getRealPath(yxlastpath4));
					   if(yxlastpathname4.length() == 0)
					   {
						   yxlastpathname4 = fpic.getName();
					   }

					   BufferedImage bi = ImageIO.read(fpic);
					   ZoomOut zo = new ZoomOut();
					   BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
					   BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
					   java.awt.Graphics2D g = zbi2.createGraphics();
					   g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
					   g.dispose();
					   try
					   {
						   ImageIO.write(zbi2,"JPEG",fpic);
					   } catch(Exception ex)
					   {
						   ImageIO.write(zbi2,"BMP",fpic);
					   }

				   } else
				   {
					   yxlastpath4 = ccobj.getYxlastpath4();
				   }
				   ///5
				   if(yxfirstpath5 != null && yxfirstpath5.length() > 0)
				   {
					   yxfirstpath5 = yxfirstpath5;
					   File fpic = new File(application.getRealPath(yxfirstpath5));
					   if(yxfirstpathname5.length() == 0)
					   {
						   yxfirstpathname5 = fpic.getName();
					   }
					   BufferedImage bi = ImageIO.read(fpic);
					   ZoomOut zo = new ZoomOut();
					   BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
					   BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
					   java.awt.Graphics2D g = zbi2.createGraphics();
					   g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
					   g.dispose();
					   try
					   {
						   ImageIO.write(zbi2,"JPEG",fpic);
					   } catch(Exception ex)
					   {
						   ImageIO.write(zbi2,"BMP",fpic);
					   }
				   } else
				   {
					   yxfirstpath5 = ccobj.getYxfirstpath5();
				   }
				   if(yxlastpath5 != null && yxlastpath5.length() > 0)
				   {
					   yxlastpath5 = yxlastpath5;
					   File fpic = new File(application.getRealPath(yxlastpath5));
					   if(yxlastpathname5.length() == 0)
					   {
						   yxlastpathname5 = fpic.getName();
					   }
					   BufferedImage bi = ImageIO.read(fpic);
					   ZoomOut zo = new ZoomOut();
					   BufferedImage zbi = zo.imageZoomOut(bi,1024,1024);
					   BufferedImage zbi2 = new BufferedImage(zbi.getWidth(),zbi.getHeight(),BufferedImage.TYPE_INT_RGB);
					   java.awt.Graphics2D g = zbi2.createGraphics();
					   g.drawImage(zbi,0,0,zbi.getWidth(),zbi.getHeight(),null);
					   g.dispose();
					   try
					   {
						   ImageIO.write(zbi2,"JPEG",fpic);
					   } catch(Exception ex)
					   {
						   ImageIO.write(zbi2,"BMP",fpic);
					   }
				   } else
				   {
					   yxlastpath5 = ccobj.getYxlastpath5();
				   }
			   }
                String address = teasession.getParameter("address");
                String doingsxbw = teasession.getParameter("doingsxbw"); //活动受限
                String gjttother = teasession.getParameter("gjttother");
                String otheryichang = teasession.getParameter("otheryichang");
                String yingxiang = teasession.getParameter("yingxiang");
                String yichang = teasession.getParameter("yichang");
                String zzjingguo = teasession.getParameter("zzjingguo");
                String taolun = teasession.getParameter("taolun");
                /**新添图片名称字段以及评论**/
				String zjname = teasession.getParameter("zjname");
				String zjyy = teasession.getParameter("zjyy");

                CaseCollection.set(id,teasession._strCommunity,regtime,member,mobilephone,casename,sex,age,chief,gjttpain,doingsxbw,gjttother,heartpain,weichangdao,otherpain,
                		jointjixingbw,jointyatongbw,otheryichang,yingxiang,yichang,gjttnumfrist,chubuzhenduan,zzjingguo,gjttnumlast,taolun,yxfirstpath,yxlastpath,0,yxfirstpath2,
                		yxlastpath2,yxfirstpath3,yxlastpath3,yxfirstpath4,yxlastpath4,yxfirstpath5,yxlastpath5,firstname,address,yxfirstpathname,yxlastpathname,yxfirstpathname2,
                		yxlastpathname2,yxfirstpathname3,yxlastpathname3,yxfirstpathname4,yxlastpathname4,yxfirstpathname5,yxlastpathname5,zhuanjiadp,zjname,zjyy,result,discuss,documents,ana);

                java.io.PrintWriter out = response.getWriter();
                out.println("<script>alert('您的病例已提交成功，24小时后会显示在最新病例栏中！');	window.location.href='/servlet/Node?node=" + teasession._nNode + "&ids=" + id + "';</script>");
                out.flush();
                out.close();
                return;
            }
            response.sendRedirect(nexturl);
            return;
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

// Clean up resources
    public void destroy()
    {
    }
}
