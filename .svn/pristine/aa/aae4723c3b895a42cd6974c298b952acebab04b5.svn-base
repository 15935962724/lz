package tea.ui.bpicture;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.bpicture.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.htmlx.*;
import java.util.Date;
import java.sql.*;
import java.text.*;
import java.math.BigDecimal;
import javax.imageio.*;
import java.awt.image.*;
import tea.entity.util.*;

import javax.servlet.ServletContext;
import java.awt.Font;
import tea.entity.site.Watermark;

public class EditBPicture extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");

        TeaSession teasession = new TeaSession(request);

        if(teasession._rv == null)
        {
            response.sendRedirect("/jsp/user/StartLogin.jsp?nexturl=" + request.getRequestURI());
        }
        ServletContext application = getServletContext();
        String act = teasession.getParameter("act");
        try
        {
            if(act.equals("upone"))
            {

                String node = teasession.getParameter("node");
                int nod = Integer.parseInt(node);

                if(teasession.getParameter("delImage") != null && teasession.getParameter("delImage").length() > 0)
                {
                    //删除图片
                    Baudit.setPg(nod);
                    response.sendRedirect("/jsp/bpicture/saler/Saler_my_images.jsp");
                    return;
                }

                int deleteid = 0; //删除
                if(teasession.getParameter("deleteid") != null && teasession.getParameter("deleteid").length() > 0)
                {
                    deleteid = Integer.parseInt(teasession.getParameter("deleteid"));

                }
                if(deleteid == 1)
                {

                    int bbbb = Blimit.count(""," and node =" + node);
                    for(int j = 0;j < bbbb;j++)
                    {
                        String it = null;
                        it = teasession.getParameter("xianzhiid" + j);
                        if(it != null)
                        {
                            int deletenum = Integer.parseInt(it);
                            Blimit.delete(deletenum);
                        }
                    }
                    response.sendRedirect("/jsp/bpicture/saler/Saler_EditImage.jsp?node=" + nod);
                    return;
                }

                String[] classific = teasession.getParameterValues("classific");
                String classic = "/";
                if(classific != null)
                {
                    for(int i = 0;i < classific.length;i++)
                    {
                        classic += classific[i] + "/";
                    }
                }

                int photography = Integer.parseInt(teasession.getParameter("photography"));
                int design = Integer.parseInt(teasession.getParameter("design"));
                int property = Integer.parseInt(teasession.getParameter("property"));
                int touse = Integer.parseInt(teasession.getParameter("touse"));
                int mediumtype = Integer.parseInt(teasession.getParameter("medium"));
                int color = Integer.parseInt(teasession.getParameter("color"));
                int cutimg = Integer.parseInt(teasession.getParameter("cutimg"));
                int cuted = Integer.parseInt(teasession.getParameter("cuted"));
//              int bpseudonymid = Integer.parseInt(teasession.getParameter("bpseudonymid"));//摄影师ID
                String ename = teasession.getParameter("bpseudonymid");
                String basicKey = teasession.getParameter("basickey").trim();
                String caption = teasession.getParameter("caption").trim();

                byte[] by = teasession.getBytesParameter("fdoc");
                Baudit ba = Baudit.find(nod);
                Picture picobj = Picture.find(nod);
                String path = ba.getFdoc();
                if(by != null)
                {
                    if(ba.getFdoc() != null)
                    {
                        boolean a = new File(application.getRealPath(ba.getFdoc())).delete();
                    }
                    String value = teasession.getParameter("filevalue");
                    String ex = value.substring(value.lastIndexOf(".") + 1).toLowerCase();
                    path = write(teasession._strCommunity,"salepic/" + teasession._rv + "/" + nod,by,"." + ex);
                }

                if(basicKey == null || basicKey.length() == 0)
                {
                    basicKey = "";
                } else
                {
                    if(!basicKey.contains(","))
                    {
                        basicKey += ",";
                    }

                    basicKey = basicKey.replaceAll("，",",");
                }

                String mainKey = teasession.getParameter("mainkey").trim();
                if(mainKey == null || mainKey.length() == 0)
                {
                    mainKey = "";
                } else
                {
                    if(!mainKey.contains(","))
                    {
                        mainKey += ",";
                    }

                    mainKey = mainKey.replaceAll("，",",");
                }

                String inteKey = teasession.getParameter("intekey").trim();
                if(inteKey == null || inteKey.length() == 0)
                {
                    inteKey = "";
                } else
                {
                    if(!inteKey.contains(","))
                    {
                        inteKey += ",";
                    }
                    inteKey = inteKey.replaceAll("，",",");
                }

                String intro = teasession.getParameter("intro").trim();
                String location = teasession.getParameter("location").trim();
                if(location == null)
                {
                    location = ",";
                }

                String adopDate = null;
                if(teasession.getParameter("adopDate") != null && teasession.getParameter("adopDate").length() > 0)
                {
                    adopDate = teasession.getParameter("adopDate");
                }

                Node n = Node.find(nod);
//                if(property == 1)
//                {
//
//                    File fpic = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/" + picobj.get_nName()));
//                    File extralarge = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/extralarge/" + nod + ".jpg"));
//                    if(!extralarge.isFile())
//                    {
//                        File extralargedir = extralarge.getParentFile();
//                        if(!extralargedir.exists())
//                        {
//                            extralargedir.mkdirs();
//                        }
//
//                        if(!extralarge.isFile())
//                        {
//                            byte byx[] = new byte[102400];
//                            java.io.FileInputStream fis = new FileInputStream(fpic);
//                            java.io.FileOutputStream fos = new FileOutputStream(extralarge);
//                            int j = 0;
//                            while((j = fis.read(byx)) != -1)
//                            {
//                                fos.write(byx,0,j);
//                            }
//                            fis.close();
//                            fos.close();
//                        }
//                        BufferedImage bi = ImageIO.read(fpic);
//                        File f = File.createTempFile("edn",".tmp");
//                        ImageIO.write(bi,"JPEG",f);
//                        bi = null;
//                        bi = ImageIO.read(f);
//                        ZoomOut zo = new ZoomOut();
//
//                        File large = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/large/" + nod + ".jpg"));
//                        File largedir = large.getParentFile();
//                        if(!largedir.exists())
//                        {
//                            largedir.mkdirs();
//                        }
//                        if(!large.isFile())
//                        {
//                            bi = zo.imageZoomOut(bi,4180,4180);
//                            ImageIO.write(bi,"JPEG",large);
//                        }
//                        File medium = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/medium/" + nod + ".jpg"));
//                        File mediumdir = medium.getParentFile();
//                        if(!mediumdir.exists())
//                        {
//                            mediumdir.mkdirs();
//                        }
//                        if(!medium.isFile())
//                        {
//                            bi = zo.imageZoomOut(bi,3238,3238);
//                            ImageIO.write(bi,"JPEG",medium);
//                        }
//                        File smalls = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/smalls/" + nod + ".jpg"));
//                        File msmallsdir = smalls.getParentFile();
//                        if(!msmallsdir.exists())
//                        {
//                            msmallsdir.mkdirs();
//                        }
//                        if(!smalls.isFile())
//                        {
//                            bi = zo.imageZoomOut(bi,1637,1637);
//                            ImageIO.write(bi,"JPEG",smalls);
//                        }
//
//                        File extrasmall = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/extrasmall/" + nod + ".jpg"));
//                        File extrasmalldir = extrasmall.getParentFile();
//                        if(!extrasmalldir.exists())
//                        {
//                            extrasmalldir.mkdirs();
//                        }
//                        if(!extrasmall.isFile())
//                        {
//                            bi = zo.imageZoomOut(bi,786,786);
//                            ImageIO.write(bi,"JPEG",extrasmall);
//                        }
//
//                        File ftbn = new File(application.getRealPath("/res/" + n.getCommunity() + "/picture/small/" + nod + ".jpg"));
//                        File dir = ftbn.getParentFile();
//                        if(!dir.exists())
//                        {
//                            dir.mkdirs();
//                        }
//                        if(!ftbn.isFile())
//                        {
//                            bi = zo.imageZoomOut(bi,160,160);
//                            ImageIO.write(bi,"JPEG",ftbn);
//                        }
//                    }
//                } else
//                {
//                    File fpic = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/" + picobj.get_nName()));
//                    File ftbn = new File(application.getRealPath("/res/" + n.getCommunity() + "/picture/small/" + nod + ".jpg"));
//                    if(!ftbn.isFile())
//                    {
//                        BufferedImage bi = ImageIO.read(fpic);
//                        File f = File.createTempFile("edn",".tmp");
//
//                        ImageIO.write(bi,"JPEG",f);
//                        bi = null;
//                        bi = ImageIO.read(f);
//                        ZoomOut zo = new ZoomOut();
//
//                        File dir = ftbn.getParentFile();
//                        if(!dir.exists())
//                        {
//                            dir.mkdirs();
//                        }
//                        if(!ftbn.isFile())
//                        {
//                            bi = zo.imageZoomOut(bi,160,160);
//                            ImageIO.write(bi,"JPEG",ftbn);
//                        }
//                    }
//                }

                n.setSubject(caption,teasession._nLanguage);
                Baudit.setImg(nod,classic,photography,design,touse,cutimg,cuted,basicKey,mainKey,inteKey,intro,location,adopDate,property,0,path,color,mediumtype);

                if(ba.getMember() != null)
                {
                    Profile pf = Profile.find(ba.getMember());
                    pf.setLastName(ename,teasession._nLanguage);
                }else{
                    Profile pf = Profile.find(teasession._rv._strR);
                    pf.setLastName(ename,teasession._nLanguage);
                }

                n.setUpdatetime(new Date());
                Picture.setMainWords(nod,mainKey);
                String showinfo = teasession.getParameter("xianzhi");
                if(teasession.getParameter("xianzhi") != null && teasession.getParameter("xianzhi").length() > 0)
                {
                    showinfo = teasession.getParameter("xianzhi");

                    int id = 0;
                    if(teasession.getParameter("ids") != null && teasession.getParameter("ids").length() > 0)
                    {
                        id = Integer.parseInt(teasession.getParameter("ids"));
                    }
                    String territory = teasession.getParameter("territory"); //
                    String country = teasession.getParameter("country");
                    String image_use = teasession.getParameter("image_use"); //////image_use
                    String image_details = teasession.getParameter("image_details"); //////image_details
                    String product_industry = teasession.getParameter("image_size"); ////image_size
                    String industry_details = teasession.getParameter("industry_details");

                    Blimit.set(id,nod,territory,country,image_use,image_details,product_industry,industry_details,showinfo);

                    response.sendRedirect("/jsp/bpicture/saler/Saler_EditImage.jsp?node=" + nod);
                    return;
                }
                response.sendRedirect("/jsp/bpicture/saler/Saler_EditImage.jsp?node=" + nod);
                return;
            }

            if(act.equals("upmore"))
            {
                int len = Integer.parseInt(teasession.getParameter("cj"));
                String pos = teasession.getParameter("pos");

                String pageSize = teasession.getParameter("pagesize");
                for(int z = 0;z < len;z++)
                {
                    String node = teasession.getParameter("node" + z);
                    int nod = Integer.parseInt(node);

                    String[] classific = teasession.getParameterValues("classific" + z);
                    String classic = "/";
                    if(classific != null)
                    {
                        for(int i = 0;i < classific.length;i++)
                        {
                            classic += classific[i] + "/";
                        }
                    }
                    int photography = Integer.parseInt(teasession.getParameter("photography" + z));
                    int design = Integer.parseInt(teasession.getParameter("design" + z));
                    int property = Integer.parseInt(teasession.getParameter("property" + z));
                    int touse = Integer.parseInt(teasession.getParameter("touse" + z));
                    int mediumtype = Integer.parseInt(teasession.getParameter("medium" + z));
                    int color = Integer.parseInt(teasession.getParameter("color" + z));
                    int cutimg = Integer.parseInt(teasession.getParameter("cutimg" + z));
                    int cuted = Integer.parseInt(teasession.getParameter("cuted" + z));
//                    int bpseudonymid = Integer.parseInt(teasession.getParameter("bpseudonymid" + z));//摄影师ID
                    String ename = teasession.getParameter("bpseudonymid" + z);
                    String basicKey = teasession.getParameter("basickey" + z).trim();
                    String caption = teasession.getParameter("caption" + z).trim();

                    String price = "0";
                    if(teasession.getParameter("picprice" + z) != null && teasession.getParameter("picprice" + z).length() > 0)
                    {
                        price = teasession.getParameter("picprice" + z);
                    }

                    BigDecimal picprice = new BigDecimal(price);
                    byte[] by = teasession.getBytesParameter("fdoc" + z);

                    Baudit ba = Baudit.find(nod);
                    String path = ba.getFdoc();
                    if(by != null)
                    {

                        if(ba.getFdoc() != null)
                        {
                            new File(application.getRealPath(ba.getFdoc())).delete();
                        }
                        String value = teasession.getParameter("filevalue" + z);
                        String ex = value.substring(value.lastIndexOf(".") + 1).toLowerCase();
                        path = write(teasession._strCommunity,"salepic/" + teasession._rv + "/" + nod,by,"." + ex);
                    }

                    if(basicKey == null || basicKey.length() == 0)
                    {
                        basicKey = "";
                    } else
                    {
                        if(!basicKey.contains(","))
                        {
                            basicKey += ",";
                        }

                        basicKey = basicKey.replaceAll("，",",");
                    }

                    String mainKey = teasession.getParameter("mainkey" + z).trim();

                    if(mainKey == null || mainKey.length() == 0)
                    {
                        mainKey = "";
                    } else
                    {
                        if(!mainKey.contains(","))
                        {
                            mainKey += ",";
                        }

                        mainKey = mainKey.replaceAll("，",",");
                    }

                    String inteKey = teasession.getParameter("intekey" + z).trim();
                    if(inteKey == null || inteKey.length() == 0)
                    {
                        inteKey = "";
                    } else
                    {
                        if(!inteKey.contains(","))
                        {
                            inteKey += ",";
                        }

                        inteKey = inteKey.replaceAll("，",",");
                    }

                    String intro = teasession.getParameter("intro" + z).trim();
                    String location = teasession.getParameter("location" + z).trim();
                    if(location == null)
                    {
                        location = ",";
                    }

                    String adopDate = null;
                    if(teasession.getParameter("adopDate" + z) != null && teasession.getParameter("adopDate" + z).length() > 0)
                    {
                        adopDate = teasession.getParameter("adopDate" + z);
                    }
                    Picture picobj = Picture.find(nod);
                    Node n = Node.find(nod);
//                    if(property == 1)
//                    {
//                        File fpic = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/" + picobj.get_nName()));
//                        //File fpic = new File(application.getRealPath("/res/" + n.getCommunity() + "/picture/" + nod + ".jpg"));
//                        File extralarge = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/extralarge/" + nod + ".jpg"));
//                        if(!extralarge.isFile())
//                        {
//                            File extralargedir = extralarge.getParentFile();
//                            if(!extralargedir.exists())
//                            {
//                                extralargedir.mkdirs();
//                            }
//
//                            if(!extralarge.isFile())
//                            {
//                                byte byx[] = new byte[102400];
//                                java.io.FileInputStream fis = new FileInputStream(fpic);
//                                java.io.FileOutputStream fos = new FileOutputStream(extralarge);
//                                int j = 0;
//                                while((j = fis.read(byx)) != -1)
//                                {
//                                    fos.write(byx,0,j);
//                                }
//                                fis.close();
//                                fos.close();
//                            }
//                            BufferedImage bi = ImageIO.read(fpic);
//                            File f = File.createTempFile("edn",".tmp");
//                            ImageIO.write(bi,"JPEG",f);
//                            bi = null;
//                            bi = ImageIO.read(f);
//                            ZoomOut zo = new ZoomOut();
//
//                            File large = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/large/" + nod + ".jpg"));
//                            File largedir = large.getParentFile();
//                            if(!largedir.exists())
//                            {
//                                largedir.mkdirs();
//                            }
//                            if(!large.isFile())
//                            {
//                                bi = zo.imageZoomOut(bi,4180,4180);
//                                ImageIO.write(bi,"JPEG",large);
//                            }
//                            File medium = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/medium/" + nod + ".jpg"));
//                            File mediumdir = medium.getParentFile();
//                            if(!mediumdir.exists())
//                            {
//                                mediumdir.mkdirs();
//                            }
//                            if(!medium.isFile())
//                            {
//                                bi = zo.imageZoomOut(bi,3238,3238);
//                                ImageIO.write(bi,"JPEG",medium);
//                            }
//                            File smalls = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/smalls/" + nod + ".jpg"));
//                            File msmallsdir = smalls.getParentFile();
//                            if(!msmallsdir.exists())
//                            {
//                                msmallsdir.mkdirs();
//                            }
//                            if(!smalls.isFile())
//                            {
//                                bi = zo.imageZoomOut(bi,1637,1637);
//                                ImageIO.write(bi,"JPEG",smalls);
//                            }
//
//                            File extrasmall = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/extrasmall/" + nod + ".jpg"));
//                            File extrasmalldir = extrasmall.getParentFile();
//                            if(!extrasmalldir.exists())
//                            {
//                                extrasmalldir.mkdirs();
//                            }
//                            if(!extrasmall.isFile())
//                            {
//                                bi = zo.imageZoomOut(bi,786,786);
//                                ImageIO.write(bi,"JPEG",extrasmall);
////                            ImageIO.write(bi,"JPEG",fpic);
//                            }
//
//                            File ftbn = new File(application.getRealPath("/res/" + n.getCommunity() + "/picture/small/" + nod + ".jpg"));
//                            File dir = ftbn.getParentFile();
//                            if(!dir.exists())
//                            {
//                                dir.mkdirs();
//                            }
//                            if(!ftbn.isFile())
//                            {
//                                bi = zo.imageZoomOut(bi,160,160);
//                                ImageIO.write(bi,"JPEG",ftbn);
//                            }
//                        }
//                    } else
//                    {
//                        File fpic = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/" + picobj.get_nName()));
//                        File ftbn = new File(application.getRealPath("/res/" + n.getCommunity() + "/picture/small/" + nod + ".jpg"));
//                        if(!ftbn.isFile())
//                        {
//                            BufferedImage bi = ImageIO.read(fpic);
//                            File f = File.createTempFile("edn",".tmp");
//                            ImageIO.write(bi,"JPEG",f);
//                            bi = null;
//                            bi = ImageIO.read(f);
//                            ZoomOut zo = new ZoomOut();
//
//                            File dir = ftbn.getParentFile();
//                            if(!dir.exists())
//                            {
//                                dir.mkdirs();
//                            }
//                            if(!ftbn.isFile())
//                            {
//                                bi = zo.imageZoomOut(bi,160,160);
//                                ImageIO.write(bi,"JPEG",ftbn);
//                            }
//                        }
//                    }

                    n.setSubject(caption,teasession._nLanguage);

                    Baudit.setImg(nod,classic,photography,design,touse,cutimg,cuted,basicKey,mainKey,inteKey,intro,location,adopDate,property,0,path,color,mediumtype);

                    if(ba.getMember() != null)
                    {
                        Profile pf = Profile.find(ba.getMember());
                        pf.setLastName(ename,teasession._nLanguage);
                    } else
                    {
                        Profile pf = Profile.find(teasession._rv._strR);
                        pf.setLastName(ename,teasession._nLanguage);
                    }

                    n.setUpdatetime(new Date());
                    Picture.setMainWords(nod,mainKey);
                    Picture.setPrice(nod,picprice);

                }
                response.sendRedirect("/jsp/bpicture/saler/Saler_my_images.jsp?pos=" + pos + "&npgs=" + pageSize);
                return;
            }

            if(act.equals("compression"))
            {
                String[] nodeArray = teasession.getParameterValues("yncompression");
                for(int i = 0; i < nodeArray.length; i++){
                    String node = nodeArray[i];
                    int nod = Integer.parseInt(node);
                    Picture picobj = Picture.find(nod);
                    Baudit ba = Baudit.find(nod);
                    Node n = Node.find(nod);

                    int property = ba.getProperty();
                    if(property == 1)
                    {
                        File fpic = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/" + picobj.get_nName()));
                        //File fpic = new File(application.getRealPath("/res/" + n.getCommunity() + "/picture/" + nod + ".jpg"));
                        File extralarge = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/extralarge/" + nod + ".jpg"));

                        BufferedImage bi = ImageIO.read(fpic);
                        File f = File.createTempFile("edn",".tmp");
                        ImageIO.write(bi,"JPEG",f);
                        bi = null;
                        bi = ImageIO.read(f);
                        ZoomOut zo = new ZoomOut();

                        if(!extralarge.isFile())
                        {
                            File extralargedir = extralarge.getParentFile();
                            if(!extralargedir.exists())
                            {
                                extralargedir.mkdirs();
                            }

                            if(!extralarge.isFile())
                            {
                                bi = zo.imageZoomOut(bi,5160,5160);
                                ImageIO.write(bi,"JPEG",extralarge);
                            }


                            File large = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/large/" + nod + ".jpg"));
                            File largedir = large.getParentFile();
                            if(!largedir.exists())
                            {
                                largedir.mkdirs();
                            }
                            if(!large.isFile())
                            {
                                bi = zo.imageZoomOut(bi,3975,3975);
                                ImageIO.write(bi,"JPEG",large);
                            }
                            File medium = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/medium/" + nod + ".jpg"));
                            File mediumdir = medium.getParentFile();
                            if(!mediumdir.exists())
                            {
                                mediumdir.mkdirs();
                            }
                            if(!medium.isFile())
                            {
                                bi = zo.imageZoomOut(bi,2820,2820);
                                ImageIO.write(bi,"JPEG",medium);
                            }
                            File smalls = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/smalls/" + nod + ".jpg"));
                            File msmallsdir = smalls.getParentFile();
                            if(!msmallsdir.exists())
                            {
                                msmallsdir.mkdirs();
                            }
                            if(!smalls.isFile())
                            {
                                bi = zo.imageZoomOut(bi,1257,1257);
                                ImageIO.write(bi,"JPEG",smalls);
                            }

                            File extrasmall = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/extrasmall/" + nod + ".jpg"));
                            File extrasmalldir = extrasmall.getParentFile();
                            if(!extrasmalldir.exists())
                            {
                                extrasmalldir.mkdirs();
                            }
                            if(!extrasmall.isFile())
                            {
                                bi = zo.imageZoomOut(bi,727,727);
                                ImageIO.write(bi,"JPEG",extrasmall);
                                //                            ImageIO.write(bi,"JPEG",fpic);
                            }

                            File ftbn = new File(application.getRealPath("/res/" + n.getCommunity() + "/picture/small/" + nod + ".jpg"));
                            File dir = ftbn.getParentFile();
                            if(!dir.exists())
                            {
                                dir.mkdirs();
                            }
                            if(!ftbn.isFile())
                            {
                                bi = zo.imageZoomOut(bi,160,160);
                                ImageIO.write(bi,"JPEG",ftbn);

                            }
                        }
                    } else
                    {
                        File fpic = new File(application.getRealPath("/res/" + n.getCommunity() + "/salepic/" + ba.getMember() + "/" + ba.getTimes() + "/" + picobj.get_nName()));
                        File ftbn = new File(application.getRealPath("/res/" + n.getCommunity() + "/picture/small/" + nod + ".jpg"));
                        if(!ftbn.isFile())
                        {
                            BufferedImage bi = ImageIO.read(fpic);
                            File f = File.createTempFile("edn",".tmp");
                            ImageIO.write(bi,"JPEG",f);
                            bi = null;
                            bi = ImageIO.read(f);
                            ZoomOut zo = new ZoomOut();

                            File dir = ftbn.getParentFile();
                            if(!dir.exists())
                            {
                                dir.mkdirs();
                            }
                            if(!ftbn.isFile())
                            {
                                bi = zo.imageZoomOut(bi,160,160);
                                ImageIO.write(bi,"JPEG",ftbn);
                            }
                        }
                    }
					Watermark.mark(teasession._strCommunity,new java.io.File(application.getRealPath("/res/" + n.getCommunity() + "/picture/" + nod + ".jpg")));

                    Baudit.set(nod,1);
                }
                response.sendRedirect("/jsp/bpicture/Audit_Compression.jsp");
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
}

