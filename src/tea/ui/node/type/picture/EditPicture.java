package tea.ui.node.type.picture;

import java.io.*;
import java.util.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.db.DbAdapter;
import tea.entity.RV;
import tea.entity.SeqTable;
import tea.entity.node.*;
import tea.entity.site.License;
import tea.entity.site.TypeAlias;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import javax.servlet.ServletContext;
import tea.entity.util.*;
import javax.imageio.*;
import java.awt.image.*;
import tea.entity.site.*;
import java.math.BigDecimal;


public class EditPicture extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        ServletContext application = getServletContext();
        try
        {
            TeaSession teasession = new TeaSession(request);
            /*
             * if (teasession._rv == null) { response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode); return; }
             */
            int father = teasession._nNode;

            String content = teasession.getParameter("content");
            String keywords = teasession.getParameter("keywords");
            String subject = teasession.getParameter("subject");
            String nexturl = teasession.getParameter("nexturl");
            int pictype = 0;


            boolean mostly = teasession.getParameter("mostly") != null;
            boolean mostly1 = teasession.getParameter("mostly1") != null;
            boolean mostly2 = teasession.getParameter("mostly2") != null;

            StringBuilder h = new StringBuilder("/");
            String ms[] = teasession.getParameterValues("mark");
            if(ms != null)
            {
                for(int i2 = 0;i2 < ms.length;i2++)
                {
                    h.append(ms[i2]).append("/");
                }
            }

            if(teasession.getParameter("pictype") != null && teasession.getParameter("pictype").length() > 0)
            {

                pictype = Integer.parseInt(teasession.getParameter("pictype"));
                String community = teasession.getParameter("community");
                String memberpic = teasession.getParameter("memberpic");

                if(memberpic != null && memberpic.length() > 0)
                {

                } else
                {
                    memberpic = teasession._rv._strR;
                }
                if(pictype == 1)
                {

                    int nodeid = 0;

                    if(teasession.getParameter("nodeid") != null && teasession.getParameter("nodeid").length() > 0)
                    {
                        nodeid = Integer.parseInt(teasession.getParameter("nodeid"));
                    }
                    Node node = Node.find(nodeid);

                    if((node.getOptions1() & 1) == 0)
                    {
                        if(memberpic == null)
                        {
                            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                            return;
                        }
                        if(!teasession._strCommunity.equals("bigpic"))
                        {
                            if(!node.isCreator(new tea.entity.RV(memberpic)) && !AccessMember.find(node._nNode,memberpic).isProvider(40))
                            {
                                response.sendError(403);
                                return;
                            }
                        }
                    } else
                    {
                        if(community == null)
                        {
                            teasession._rv = new tea.entity.RV("ANONYMITY","Home"); //
                        }
                    }

                    String repository = teasession.getParameter("repository");

                    File str[] = Picture.listFiles(new File(application.getRealPath("/res/" + teasession._strCommunity + "/" + repository))); //String str[] = teasession.getParameterValues("upload");

                    if(str != null)
                    {
                        SeqTable ss = new SeqTable();
                        int times = ss.getSeqNo(community + memberpic);
                        for(int i = 0;i < str.length;i++)
                        {
                            File srcold = str[i];
                            String namepic = srcold.getName();

                            System.out.print(application.getRealPath(repository + "/" + times + "/" + namepic));
                            File f = new File(application.getRealPath(repository + "/" + times + "/" + namepic));

                            File dirold = f.getParentFile();
                            if(!dirold.exists())
                            {
                                dirold.mkdirs();
                            }
//                            srcold.renameTo(f);
//                            System.out.println(srcold.getAbsolutePath()+"!!"+f.getAbsolutePath());
                            byte by1[] = new byte[102400];
                            java.io.FileInputStream fis1 = new FileInputStream(srcold);
                            java.io.FileOutputStream fos1 = new FileOutputStream(f);
                            int j1 = 0;
                            while((j1 = fis1.read(by1)) != -1)
                            {
                                fos1.write(by1,0,j1);
                            }
                            fis1.close();
                            fos1.close();

                            srcold.delete();



                            if(teasession.getParameter("NewNode") != null)
                            {
                                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                                long options = node.getOptions();
                                int options1 = node.getOptions1();
                                Category cat = Category.find(teasession._nNode);
                                teasession._nNode = Node.create(nodeid,sequence,node.getCommunity(),new tea.entity.RV(memberpic),cat.getCategory(),(options1 & 2) != 0,options,options1,node.getDefaultLanguage(),null,null,new java.util.Date(),0,0,0,0,null,teasession._nLanguage,namepic,keywords,"",content,null,"",0,null,"","","","",null,null);
                                node = Node.find(teasession._nNode);
                            } else
                            {
                                father = node.getFather();
                                node.set(teasession._nLanguage,subject,content);
                                node.setKeywords(keywords,teasession._nLanguage);
                            }

                            String s22 = teasession.getParameter("Author");
                            String s10 = null;
                            String s44 = teasession.getParameter("Class");
                            String s55 = teasession.getParameter("Address");
                            String s66 = teasession.getParameter("Note");
                            String s77 = teasession.getParameter("Save");
                            String s88 = String.valueOf(teasession._nNode); // teasession.getParameter("index");
                            Date date4 = new Date();
                            //TimeSelection.makeTime(teasession.getParameter("IssueYear"),teasession.getParameter("IssueMonth"),teasession.getParameter("IssueDay"),teasession.getParameter("IssueHour"),teasession.getParameter("IssueMinute"));
                            int width = 0;
                            int height = 0;
                            //图的处理
//                            byte bypic[] = teasession.getBytesParameter("picture");
//                            byte bytbn[] = teasession.getBytesParameter("small");

                            File fpic = new File(application.getRealPath("/res/" + node.getCommunity() + "/picture/" + teasession._nNode + ".jpg"));
                            File fpicdir = fpic.getParentFile();
                            if(!fpicdir.exists())
                            {
                                fpicdir.mkdirs();
                            }
                            BufferedImage bi = ImageIO.read(f);
                            width = bi.getWidth();
                            height = bi.getHeight();
                            //ImageIO.write(bi,"JPEG",fpic);
                            byte by[] = new byte[102400];
                            java.io.FileInputStream fis = new FileInputStream(f);
                            java.io.FileOutputStream fos = new FileOutputStream(fpic);
                            int j = 0;
                            while((j = fis.read(by)) != -1)
                            {
                                fos.write(by,0,j);
                            }
                            fis.close();
                            fos.close();
                            //f.renameTo(fpic);
                            //end//
                            BigDecimal price = new BigDecimal(0);
                            if(teasession.getParameter("price") != null && teasession.getParameter("price").length() > 0 && !"null".equals(teasession.getParameter("price")))
                            {
                                price = new BigDecimal(teasession.getParameter("price")); // 注册费用
                            }

                            /***
                             * 注意如果实现一次上传多个图片 times 要同一 方法应该写在循环的外面。
                             * **/



                            node.set(mostly,mostly1,mostly2,h.toString());



                            Picture picturer = Picture.find(teasession._nNode);

                            picturer.setname(teasession._nNode,s22,s44,s55,s66,s77,date4,s88,width,height,price,pictype,times,namepic);
                            node.finished(teasession._nNode);

                        }

                        if(nexturl != null && nexturl.length() > 0)
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("信息提交成功！","UTF-8") + "&nexturl=" + nexturl);
                        } else
                        {
                            response.sendRedirect("Node?node=" + teasession._nNode);
                        }
                        return;
                    }
                }
            }
            Node node = Node.find(teasession._nNode);
            if((node.getOptions1() & 1) == 0)
            {
                if(teasession._rv == null)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
                if(!node.isCreator(teasession._rv) && !AccessMember.find(node._nNode,teasession._rv._strV).isProvider(40))
                {
                    response.sendError(403);
                    return;
                }
            } else
            {
                if(teasession._rv == null)
                {
                    teasession._rv = new tea.entity.RV("ANONYMITY","Home");
                }
            }

            if(teasession.getParameter("NewNode") != null)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                long options = node.getOptions();
                int options1 = node.getOptions1();
                Category cat = Category.find(teasession._nNode);
                teasession._nNode = Node.create(teasession._nNode,sequence,node.getCommunity(),teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,node.getDefaultLanguage(),null,null,new java.util.Date(),0,0,0,0,null,teasession._nLanguage,subject,keywords,"",content,null,"",0,null,"","","","",null,null);
            } else
            {
                father = node.getFather();
                node.set(teasession._nLanguage,subject,content);
                node.setKeywords(keywords,teasession._nLanguage);
            }
            node.set(mostly,mostly1,mostly2,h.toString());

            String s22 = teasession.getParameter("Author");
            String s10 = null;
            String s44 = teasession.getParameter("Class");
            String s55 = teasession.getParameter("Address");
            String s66 = teasession.getParameter("Note");
            String s77 = teasession.getParameter("Save");
            String s88 = String.valueOf(teasession._nNode); // teasession.getParameter("index");
            Date date4 = TimeSelection.makeTime(teasession.getParameter("IssueYear"),teasession.getParameter("IssueMonth"),teasession.getParameter("IssueDay"),teasession.getParameter("IssueHour"),teasession.getParameter("IssueMinute"));
            int width = 0;
            int height = 0;

            //图的处理
            byte bypic[] = teasession.getBytesParameter("picture");
	        boolean flag = teasession.getParameter("flag") != null;//水印

            byte bytbn[] = teasession.getBytesParameter("small");
            File ftbn = new File(application.getRealPath("/res/" + node.getCommunity() + "/picture/small/" + teasession._nNode + ".jpg"));
            File dir = ftbn.getParentFile();
            if(!dir.exists())
            {
                dir.mkdirs();
            }
            File fpic = new File(application.getRealPath("/res/" + node.getCommunity() + "/picture/" + teasession._nNode + ".jpg"));

            if(teasession.getParameter("clearpicture") != null)
            {
                fpic.delete();
            } else if(bypic != null)
            {
                FileOutputStream fos = new FileOutputStream(fpic);
                fos.write(bypic);
                fos.close();
            }
			//
			//添加水印/////////////////
			  if(flag)
			  {
				  Watermark.mark(teasession._strCommunity,fpic);
			  }
            if(teasession.getParameter("clearsmall") != null)
            {
                ftbn.delete();
            } else if(bytbn != null)
            {
                FileOutputStream fos = new FileOutputStream(ftbn);
                fos.write(bytbn);
                fos.close();
            }
            if(fpic.exists()) //大图存在
            {
                BufferedImage bi = ImageIO.read(fpic);
                width = bi.getWidth();
                height = bi.getHeight();
                if(!ftbn.exists()) //小图不存在,则生成小图
                {
                    ZoomOut zo = new ZoomOut();
                    ImageIO.write(zo.imageZoomOut(bi,100,100),"PNG",ftbn);
                }
            }

            //end//
            BigDecimal price = new BigDecimal(0);
            if(teasession.getParameter("price") != null && teasession.getParameter("price").length() > 0)
            {
                price = new BigDecimal(teasession.getParameter("price")); // 注册费用
            }

            /***
             * 注意如果实现一次上传多个图片 times 要同一 方法应该写在循环的外面。
             * **/

            int times = 0;
            Picture picturer = Picture.find(teasession._nNode);
            picturer.set(teasession._nNode,s22,s44,s55,s66,s77,date4,s88,width,height,price,pictype,times);
            node.finished(teasession._nNode);

            if(nexturl != null && nexturl.length() > 0)
            {
                response.sendRedirect(nexturl);
                return;
            }
            if(teasession.getParameter("CBContinue") != null)
            {
                response.sendRedirect("/jsp/type/picture/EditPicture.jsp?NewNode=ON&node=" + father);
                return;
            }
            if(teasession.getParameter("GoSuper") != null)
            {
              //  response.sendRedirect("EditNode?node=" + teasession._nNode);
			    response.sendRedirect("/jsp/general/EditNode.jsp?node=" + teasession._nNode);
                return;
            }
            if(teasession.getParameter("GoFinish") != null)
            {
                response.sendRedirect("Node?node=" + teasession._nNode);
                return;
            }
        } catch(Exception ex)
        {
            response.sendError(400,ex.toString());
            ex.printStackTrace();
        }
    }
}
