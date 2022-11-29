package tea.ui.ocean;

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

public class EditOcean extends TeaServlet
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
            if(act.equals("Oceanfafang"))
            {
                int ids = 0;
                if(teasession.getParameter("ids") != null && teasession.getParameter("ids").length() > 0)
                {
                    ids = Integer.parseInt(teasession.getParameter("ids"));
                }
                String drawnames = teasession.getParameter("drawnames");
                String drawcards = teasession.getParameter("drawcards");
                int drawtype = 0;
                if(teasession.getParameter("drawtype") != null && teasession.getParameter("drawtype").length() > 0)
                {
                    drawtype = Integer.parseInt(teasession.getParameter("drawtype"));
                }
                Ocean.updatetype(ids,3,",drawnames=" + DbAdapter.cite(drawnames) + ",drawcards=" + DbAdapter.cite(drawcards) + ",drawtype=" + drawtype + ",drawdates=" + DbAdapter.cite(new Date()));
                String member = null;
                if(teasession._rv!=null)
                {
                	member = teasession._rv._strR;
                }
                Ocean.appendMethodB("member:"+member+"Oceanfafang===订单："+Ocean.find(ids).getOceanorder()+"orderstatic=3,drawnames"+drawnames+"drawcards"+drawcards+"drawtype"+drawtype+"drawdates"+Ocean.sdf2.format(new Date())+" ");



                response.sendRedirect("/jsp/ocean/OceanSuccess2.jsp?ids=" + ids);

                return;
            } else
            if(act.equals("EditOceanRoll"))
            {
                int id = 0;
                if(teasession.getParameter("ids") != null && teasession.getParameter("ids").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("ids"));
                }

                String beijingorder = "";
                String oceanorder = teasession.getParameter("oceanorder");
                if(!Ocean.thinkId(id)) //判断是不是存在
                {

                    final java.text.DecimalFormat df2 = new java.text.DecimalFormat("00");
                    final java.text.DecimalFormat df4 = new java.text.DecimalFormat("0000");
                    Calendar calendarSys = new java.util.GregorianCalendar(); //取当前时间
                    java.util.Date d = new java.util.Date(System.currentTimeMillis());
                    calendarSys.setTime(d); //转换后，取年，月，日
                    int year = calendarSys.get(Calendar.YEAR);
                    int month = calendarSys.get(Calendar.MONTH);
                    int aDate = calendarSys.get(Calendar.DATE); //这里转化为你想用的格式

                    String datastr = year + df2.format(month + 1) + df2.format(aDate);
                    //int idmax = Ocean.getIdmax() + 1;
                    int idmax = SeqTable.getSeqNo(datastr + "-2486-");
                    String v_oid = datastr + "-2486-" + df4.format(idmax); //订单号
                    oceanorder = datastr + df4.format(idmax);
                    beijingorder = v_oid;
                } else
                {
                    oceanorder = teasession.getParameter("oceanorder");
                }
                int passport = 0; //护照类型
                BigDecimal money = new BigDecimal("0");
                if(teasession.getParameter("passport") != null && teasession.getParameter("passport").length() > 0)
                {
                    passport = Integer.parseInt(teasession.getParameter("passport"));
                    if(passport == 0)
                    {
                        money = new BigDecimal("380");
                    } else
                    {
                        money = new BigDecimal("170");
                    }
                }
                String name = teasession.getParameter("name");
                int sex = 1;
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex")); //1：男  0：女
                }
                String card = teasession.getParameter("card");
                String telephone = teasession.getParameter("telephone"); //电话 固定电话
                String mobile = teasession.getParameter("mobile"); //手机
                String address = teasession.getParameter("address"); //
                String zip = teasession.getParameter("zip"); //邮编
                String email = teasession.getParameter("email");
                String babyname = teasession.getParameter("babyname");

                boolean falgstr = Ocean.iscard(card," and orderstatic>0");
                boolean falgstr2 = Ocean.iscard(card," and orderstatic=0");
                if(falgstr && id == 0)
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您已经提交过申请，并且资金已经提交成功，相关信息请到查询页面进行查找！","UTF-8") + "&nexturl=/jsp/ocean/OceanSearch.jsp");
                    return;
                }
//                else if(falgstr2 && id == 0)
//                {
//                    Ocean.deleteCard(card,"  and orderstatic=0 ");
//                }


                int cardtype = 0; //身份证\军官证\护照可选
                if(teasession.getParameter("cardtype") != null && teasession.getParameter("cardtype").length() > 0)
                {
                    cardtype = Integer.parseInt(teasession.getParameter("cardtype"));
                }
                int applycard = 0; // 0 新办卡 1续办卡
                if(teasession.getParameter("applycard") != null && teasession.getParameter("applycard").length() > 0)
                {
                    applycard = Integer.parseInt(teasession.getParameter("applycard"));
                }
                if(applycard == 1)
                {
                    String oceancard = teasession.getParameter("oceancard");
                    if(oceancard != null && oceancard.length() > 0)
                    {

                    } else
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("续办卡请您填写原卡号！","UTF-8") + "&nexturl=/jsp/ocean/EditOceanRoll.jsp");
                        return;
                    }
                }
                int applycard3 = 0; // 0 三年以下，1  三年以上
                if(teasession.getParameter("applycard3") != null && teasession.getParameter("applycard3").length() > 0)
                {
                    applycard3 = Integer.parseInt(teasession.getParameter("applycard3"));
                }
                byte bypic[] = teasession.getBytesParameter("picture");

                String picpath = ""; //照片
                int width = 0;
                int height = 0;
                File fpic = new File(application.getRealPath("/res/" + teasession._strCommunity + "/ocean/" + oceanorder + ".jpg"));
                File fpicdir = fpic.getParentFile();
                picpath = "/res/" + teasession._strCommunity + "/ocean/" + oceanorder + ".jpg";
                if(Ocean.thinkId(id))
                {
                    Ocean oce = Ocean.find(id);

                    if(bypic != null)
                    {
                        picpath = "/res/" + teasession._strCommunity + "/ocean/" + oceanorder + ".jpg";
                    } else
                    {
                        picpath = oce.getPicpath();
                    }
                }

                if(!fpicdir.exists())
                {
                    fpicdir.mkdirs();
                }
                if(teasession.getParameter("clearpicture") != null)
                {
                    picpath = "";
                    fpic.delete();
                } else if(bypic != null)
                {
                    FileOutputStream fos = new FileOutputStream(fpic);
                    fos.write(bypic);
                    fos.close();
                }
//2011-04-15 liu 注释~
//				else if(bypic == null && id == 0 )
//                {
//                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("由于您是第一次申请海洋护照，请上传您的照片！","UTF-8") + "&nexturl=/jsp/ocean/EditOceanRoll.jsp");
//                    return;
//
//                }

                if(bypic != null)
                {
                    //70*94   分辨率大于164*145小于194*176即可
                    BufferedImage bi = ImageIO.read(fpic);
                    width = bi.getWidth();
                    height = bi.getHeight();
                    if((width > 144 && width < 177) && (height > 163 && height < 195))
                    {
                        try
                        {
                            ZoomOut zo = new ZoomOut();
                            BufferedImage zbi = zo.imageZoomOut(bi,176,194);
                            BufferedImage zbi2 = new BufferedImage(BufferedImage.TYPE_INT_RGB,zbi.getHeight(),zbi.getWidth());
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
                        } catch(Exception ex1)
                        {
                            //response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您上传的照片不符合要求，请您重新上传！","UTF-8") + "&nexturl=/jsp/ocean/EditOceanRoll.jsp");
                           // return;
						   System.out.println("照片容错!"+"width:"+width+"-height:"+height);
                        }
                    } else
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您上传的照片不符合要求，请您重新上传！","UTF-8") + "&nexturl=/jsp/ocean/EditOceanRoll.jsp");
                        return;
                    }

                }
                Date babybirth = null;
                if(teasession.getParameter("babybirth") != null && teasession.getParameter("babybirth").length() > 0)
                {
                    babybirth = Ocean.sdf.parse(teasession.getParameter("babybirth"));
                }

                teasession.getParameter("babybirth");
                String babyage = teasession.getParameter("babyage");
                if(teasession.getParameter("babyage") != null && teasession.getParameter("babyage").length() > 0)
                {
                    babyage = (teasession.getParameter("babyage").replaceAll("岁",""));
                }
                int income = 0;
                if(teasession.getParameter("income") != null && teasession.getParameter("income").length() > 0)
                {
                    income = Integer.parseInt(teasession.getParameter("income"));
                }

                int replacetype = 0;
                if(teasession.getParameter("replacetype") != null && teasession.getParameter("replacetype").length() > 0)
                {
                    replacetype = Integer.parseInt(teasession.getParameter("replacetype"));
                }

                String interest = "";
                StringBuffer interests = new StringBuffer(",");

                for(int i = 0;i < Ocean.INTEREST.length;i++)
                {
                    interest = teasession.getParameter("interest" + i);
                    if(teasession.getParameter("interest" + i) != null && teasession.getParameter("interest" + i).length() > 0)
                    {
                        interests.append(interest).append(",");
                    }
                }
                interest = interests.toString();

                String other = teasession.getParameter("other");

                String oceancard = teasession.getParameter("oceancard");
                int orderstatic = 0;
                if(teasession.getParameter("orderstatic") != null && teasession.getParameter("orderstatic").length() > 0)
                {
                    orderstatic = Integer.parseInt(teasession.getParameter("orderstatic"));
                }
				/**
                 * private int education;//教育程度
                 * private int occupation;//职业
                 * private int urban;//市区,城市
                 * private int learnway;//信息获知途径
                 * private String bobo_interest;//您和宝宝的兴趣爱好
                 * private String bobo_interest_qita;//您和宝宝的兴趣爱好 其他

				*/

				int education = 0;
				if(teasession.getParameter("education")!=null && teasession.getParameter("education").length()>0)
				{
					 education = Integer.parseInt(teasession.getParameter("education"));
				}
                int occupation = 0;
                if(teasession.getParameter("occupation") != null && teasession.getParameter("occupation").length() > 0)
                {
                    occupation = Integer.parseInt(teasession.getParameter("occupation"));
                }
                int urban = 0;
                if(teasession.getParameter("urban") != null && teasession.getParameter("urban").length() > 0)
                {
                    urban = Integer.parseInt(teasession.getParameter("urban"));
                }
                int learnway = 0;
                if(teasession.getParameter("learnway") != null && teasession.getParameter("learnway").length() > 0)
                {
                    learnway = Integer.parseInt(teasession.getParameter("learnway"));
                }
//				String bobo_interest = "/";
//			   if(teasession.getParameter("bobo_interest")!=null && teasession.getParameter("bobo_interest").length()>0)
//			   {
//				   String bo_in[] = teasession.getParameterValues("bobo_interest");
//
//                       for(int i = 0;i < bo_in.length;i++)
//                       {
//                           bobo_interest = bobo_interest + bo_in[i] + "/";
//                       }
//			   }
			   String bobo_interest = "";
			   StringBuffer bobo_interest2 = new StringBuffer("/");

			   for(int i = 0;i < Ocean.BOBO_INTEREST.length;i++)
			   {
				   bobo_interest = teasession.getParameter("bobo_interest" + i);
				   if(teasession.getParameter("bobo_interest" + i) != null && teasession.getParameter("bobo_interest" + i).length() > 0)
				   {
					   bobo_interest2.append(bobo_interest).append("/");
				   }
			   }
			   bobo_interest = bobo_interest2.toString();







				 String bobo_interest_qita = teasession.getParameter("bobo_interest_qita");



                Ocean.set(id,passport,name,sex,card,telephone,mobile,address,zip,email,babyname,babybirth,babyage,income,interest,other,
                		oceanorder,oceancard,orderstatic,cardtype,
						  applycard,applycard3,picpath,replacetype,money,beijingorder,education,occupation,urban,learnway,
						  bobo_interest,bobo_interest_qita);


                int getid = Ocean.getOceanordertoID(oceanorder,"");
                response.sendRedirect("/jsp/ocean/EditOceanRoll_1.jsp?ids=" + getid);
                return;
            } else if(act.equals("EditOceanRoll2"))
            {
                String oceancard = teasession.getParameter("oceancard");
                int id = 0;
                if(teasession.getParameter("idss") != null && teasession.getParameter("idss").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("idss"));
                }

                if(oceancard != null && oceancard.length() > 0)
                {
                    Ocean.updatetype(id,2," , oceancard =" + DbAdapter.cite(oceancard) + " ");
                    Ocean.updateMaketime(id);


                    String member = null;
                    if(teasession._rv!=null)
                    {
                    	member = teasession._rv._strR;
                    }
                    Ocean.appendMethodB("member:"+member+"EditOceanRoll2===订单："+id+"==="+2+"==oceancard"+oceancard);


                    Ocean oce = Ocean.find(id);



                    tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
                    StringBuffer strs = new StringBuffer();

                    strs.append("您好！").append("<br>");
                    strs.append("　　您的海洋护照已经制作成功，请牢记您的订单编号" + oce.getOceanorder() + "，次日起，可携带本人身份证到指定地点领取。如需代领，请代领人持海洋护照卡卡主身份证、订单编号领取。").append("<br>");
					strs.append("　　领卡地点：北京市海淀区高梁桥斜街乙18号北京海洋馆售票处1号窗口（北京动物园北门售票处）").append("<br>");
					strs.append("　　联系电话：010-62176655-6738、6799、6792、6771").append("<br>");
                    se.sendEmail(oce.getEmail(),"您的海洋护照已经制作成功！",strs.toString());
					System.out.println(oce.getEmail());
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("海洋护照编号与会员关联成功 !","UTF-8") + "&nexturl=/jsp/ocean/OceanRollList1.jsp");
                    return;
                } else
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交失败请重新填写!","UTF-8") + "&nexturl=/jsp/ocean/OceanRollList1.jsp");
                    return;
                }
            } else if(act.equals("EditOceanRoll5"))
            {
                String oceancard = teasession.getParameter("oceancard");
                int id = 0;
                if(teasession.getParameter("idss") != null && teasession.getParameter("idss").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("idss"));
                }
                Ocean oce = Ocean.find(id);
                int passport = oce.getPassport(); //护照类型
                BigDecimal money = money = oce.getMoney(); //护照金额

                String name = teasession.getParameter("name");
                int sex = 1;
                if(teasession.getParameter("sex") != null && teasession.getParameter("sex").length() > 0)
                {
                    sex = Integer.parseInt(teasession.getParameter("sex")); //1：男  0：女
                }

                String card = teasession.getParameter("card");
                String telephone = teasession.getParameter("telephone"); //电话 固定电话
                String mobile = teasession.getParameter("mobile"); //手机
                String address = teasession.getParameter("address"); //
                String zip = teasession.getParameter("zip"); //邮编
                String email = teasession.getParameter("email");
                String babyname = teasession.getParameter("babyname");
                String beijingorder = oce.getBeijingorder();
                String oceanorder = oce.getOceanorder();
                int orderstatic = oce.getOrderstatic();
                int applycard3 = oce.getApplycard3();

                int cardtype = 0; //身份证\军官证\护照可选
                if(teasession.getParameter("cardtype") != null && teasession.getParameter("cardtype").length() > 0)
                {
                    cardtype = Integer.parseInt(teasession.getParameter("cardtype"));
                }
                int applycard = 0; // 0 新办卡 1续办卡
                if(teasession.getParameter("applycard") != null && teasession.getParameter("applycard").length() > 0)
                {
                    applycard = Integer.parseInt(teasession.getParameter("applycard"));
                }
                Date babybirth = null;
                if(teasession.getParameter("babybirth") != null && teasession.getParameter("babybirth").length() > 0)
                {
                    babybirth = Ocean.sdf.parse(teasession.getParameter("babybirth"));
                }

                byte bypic[] = teasession.getBytesParameter("picture");
                String picpath = oce.getPicpath();
                int width = 0;
                int height = 0;
                File fpic = new File(application.getRealPath(picpath));
                File fpicdir = fpic.getParentFile();
                picpath = oce.getPicpath();
                if(!fpicdir.exists())
                {
                    fpicdir.mkdirs();
                }
                if(bypic != null)
                {
                    FileOutputStream fos = new FileOutputStream(fpic);
                    fos.write(bypic);
                    fos.close();
                }
                if(bypic != null)
                {
                    //70*94   分辨率大于164*145小于194*176即可
                    BufferedImage bi = ImageIO.read(fpic);
                    width = bi.getWidth();
                    height = bi.getHeight();
                    if((width > 144 && width < 177) && (height > 163 && height < 195))
                    {
                        try
                        {
                            ZoomOut zo = new ZoomOut();
                            BufferedImage zbi = zo.imageZoomOut(bi,176,194);
                            BufferedImage zbi2 = new BufferedImage(BufferedImage.TYPE_INT_RGB,zbi.getHeight(),zbi.getWidth());
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
                        } catch(Exception ex1)
                        {
							System.out.println("照片容错!"+"width:"+width+"-height:"+height);
                           // response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您上传的照片不符合要求，请您重新上传！","UTF-8") + "&nexturl=/jsp/ocean/EditOceanRoll.jsp");
                            //return;
                        }
                    } else
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您上传的照片不符合要求，请您重新上传！","UTF-8") + "&nexturl=/jsp/ocean/EditOceanRoll.jsp");
                        return;
                    }

                }
                String babyage = teasession.getParameter("babyage");
                if(teasession.getParameter("babyage") != null && teasession.getParameter("babyage").length() > 0)
                {
                    babyage = (teasession.getParameter("babyage").replaceAll("岁",""));
                }
                int income = 0;
                if(teasession.getParameter("income") != null && teasession.getParameter("income").length() > 0)
                {
                    income = Integer.parseInt(teasession.getParameter("income"));
                }
                int replacetype = 0;
                if(teasession.getParameter("replacetype") != null && teasession.getParameter("replacetype").length() > 0)
                {
                    replacetype = Integer.parseInt(teasession.getParameter("replacetype"));
                }

                String interest = "";
                StringBuffer interests = new StringBuffer(",");

                for(int i = 0;i < Ocean.INTEREST.length;i++)
                {
                    interest = teasession.getParameter("interest" + i);
                    if(teasession.getParameter("interest" + i) != null && teasession.getParameter("interest" + i).length() > 0)
                    {
                        interests.append(interest).append(",");
                    }
                }
                interest = interests.toString();

                String other = teasession.getParameter("other");

				int education = 0;
				if(teasession.getParameter("education")!=null && teasession.getParameter("education").length()>0)
				{
					 education = Integer.parseInt(teasession.getParameter("education"));
				}
				int occupation = 0;
				if(teasession.getParameter("occupation") != null && teasession.getParameter("occupation").length() > 0)
				{
					occupation = Integer.parseInt(teasession.getParameter("occupation"));
				}
				int urban = 0;
				if(teasession.getParameter("urban") != null && teasession.getParameter("urban").length() > 0)
				{
					urban = Integer.parseInt(teasession.getParameter("urban"));
				}
				int learnway = 0;
				if(teasession.getParameter("learnway") != null && teasession.getParameter("learnway").length() > 0)
				{
					learnway = Integer.parseInt(teasession.getParameter("learnway"));
				}
				 String bobo_interest = "/";
				 if(teasession.getParameter("bobo_interest")!=null && teasession.getParameter("bobo_interest").length()>0)
				 {
					 String bo_in[] = teasession.getParameterValues("bobo_interest");
					 for(int i =0;i<bo_in.length;i++)
					 {
						 bobo_interest =bobo_interest +bo_in[i]+"/";
					 }
				 }
				 String bobo_interest_qita = teasession.getParameter("bobo_interest_qita");

                if(oceancard != null && oceancard.length() > 0)
                {

                    Ocean.set(id,passport,name,sex,card,telephone,mobile,address,zip,email,babyname,babybirth,babyage,income,interest,other,oceanorder,oceancard,orderstatic,cardtype,
							  applycard,applycard3,picpath,replacetype,money,beijingorder,education,occupation,urban,learnway,bobo_interest,bobo_interest_qita);




                    Ocean.updatetype(id,oce.getOrderstatic()," , oceancard =" + DbAdapter.cite(oceancard) + " ");



                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("海洋护照信息修改成功 !","UTF-8") + "&nexturl=/jsp/ocean/OceanRollList5.jsp");
                    return;
                } else
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("海洋护照信息修改失败，请重新修改!","UTF-8") + "&nexturl=/jsp/ocean/OceanRollList5.jsp");
                    return;
                }

            } else if(act.equals("EditOceanRoll4"))
            {
                String oceancard = teasession.getParameter("oceancard");
                int id = 0;
                if(teasession.getParameter("idss") != null && teasession.getParameter("idss").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("idss"));
                }
                Ocean oce = Ocean.find(id);
                String card = oce.getCard();

                byte bypic[] = teasession.getBytesParameter("picture");
                String picpath = oce.getPicpath();
                int width = 0;
                int height = 0;
                File fpic = new File(application.getRealPath(picpath));
                File fpicdir = fpic.getParentFile();
                if(Ocean.thinkId(id))
                {
                    if(bypic != null)
                    {
                        picpath = "/res/" + teasession._strCommunity + "/ocean/" + card + ".jpg";
                    } else
                    {
                        picpath = oce.getPicpath();
                    }
                }
                if(!fpicdir.exists())
                {
                    fpicdir.mkdirs();
                }
                if(bypic != null)
                {
                    FileOutputStream fos = new FileOutputStream(fpic);
                    fos.write(bypic);
                    fos.close();
                }
                if(bypic != null)
                {
                    //70*94   分辨率大于164*145小于194*176即可
                    BufferedImage bi = ImageIO.read(fpic);
                    width = bi.getWidth();
                    height = bi.getHeight();

                    if((width > 144 && width < 177) && (height > 163 && height < 195))
                    {
                        ZoomOut zo = new ZoomOut();
                        ImageIO.write(zo.imageZoomOut(bi,180,196),"JPEG",fpic);
                    } else
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您上传的照片不符合要求，请您重新上传！","UTF-8") + "&nexturl=/jsp/ocean/EditOceanRoll4.jsp?ids=" + id);
                        return;
                    }
                }

                if(oceancard != null && oceancard.length() > 0)
                {
                    Ocean.updatetype(id,oce.getOrderstatic()," , oceancard =" + DbAdapter.cite(oceancard) + " ");
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("海洋护照编号修改成功 !","UTF-8") + "&nexturl=/jsp/ocean/OceanRollList4.jsp");
                    return;
                } else
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("海洋护照编号修改失败，请重新修改!","UTF-8") + "&nexturl=/jsp/ocean/OceanRollList4.jsp");
                    return;
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            System.out.print(ex.toString());
			response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您添加的内容有错误的地方,请重新添加!","UTF-8") + "&nexturl=/jsp/ocean/EditOceanRoll.jsp");
            return;
        }
    }

    public EditOcean()
    {
    }

    public void destroy()
    {
    }

}
