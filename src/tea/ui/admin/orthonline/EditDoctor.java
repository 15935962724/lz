package tea.ui.admin.orthonline;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.admin.erp.*;
import javax.servlet.http.HttpSession;
import tea.entity.member.*;
import tea.entity.admin.*;
import tea.entity.node.*;
import tea.entity.admin.orthonline.*;


public class EditDoctor extends TeaServlet
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
//		if(teasession._rv == null)
//		{
//			response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
//			return;
//		}
		String act = teasession.getParameter("act");
		String community = teasession.getParameter("community");
		String nexturl = teasession.getParameter("nexturl");
		int doid = 0;
		if(teasession.getParameter("doid") != null && teasession.getParameter("doid").length() > 0)
		{
			doid = Integer.parseInt(teasession.getParameter("doid"));
		}

		try
		{
			Doctor doobj = Doctor.find(doid);
			if("EditDoctor".equals(act))
			{
				String xingming = teasession.getParameter("xingming"); //姓名
				String xingbie = teasession.getParameter("xingbie"); //性别
				String youxiaozhengjian = teasession.getParameter("youxiaozhengjian"); //有效证件
				String youxiaozhengjianhao = teasession.getParameter("youxiaozhengjianhao"); //有效证件号码
				//System.out.println(teasession.getParameter("chushengnianyueYear")+":"+teasession.getParameter("chushengnianyueMonth")+":"+teasession.getParameter("chushengnianyueDay"));
				Date chushengnianyue = null; //出生年月
				if(teasession.getParameter("chushengnianyueYear") != null && teasession.getParameter("chushengnianyueYear").length() > 0 && teasession.getParameter("chushengnianyueMonth") != null && teasession.getParameter("chushengnianyueMonth").length() > 0 && teasession.getParameter("chushengnianyueDay") != null && teasession.getParameter("chushengnianyueDay").length() > 0)
				{
					chushengnianyue = Doctor.sdf.parse(teasession.getParameter("chushengnianyueYear") + "-" + teasession.getParameter("chushengnianyueMonth") + "-" + teasession.getParameter("chushengnianyueDay"));
				}

				String gerenzhaopianname = null; //个人照片名称
				String gerenzhaopianpath = null; //个人照片地址

				if(teasession.getParameter("clear1") != null)
				{
					gerenzhaopianname = "";
					gerenzhaopianpath = "";
				} else if(teasession.getParameter("gerenzhaopianpath") != null)
				{
					gerenzhaopianpath = teasession.getParameter("gerenzhaopianpath");
					gerenzhaopianname = teasession.getParameter("gerenzhaopianpathName");

				} else
				{
					gerenzhaopianpath = doobj.getGerenzhaopianpath();
					gerenzhaopianname = doobj.getGerenzhaopianname();
				}

				String yszigezheng = teasession.getParameter("yszigezheng"); //医师资格证
				Date yszigezhengtime = null;
				if(teasession.getParameter("yszigezhengtimeYear") != null && teasession.getParameter("yszigezhengtimeYear").length() > 0 && teasession.getParameter("yszigezhengtimeMonth") != null && teasession.getParameter("yszigezhengtimeMonth").length() > 0 && teasession.getParameter("yszigezhengtimeDay") != null && teasession.getParameter("yszigezhengtimeDay").length() > 0)
				{
					yszigezhengtime = Doctor.sdf.parse(teasession.getParameter("yszigezhengtimeYear") + "-" + teasession.getParameter("yszigezhengtimeMonth") + "-" + teasession.getParameter("yszigezhengtimeDay")); //获取时间---医师资格证
				}

				String yszhiyezheng = teasession.getParameter("yszhiyezheng"); //医师执业证
				Date yszhiyezhengtime = null;
				if(teasession.getParameter("yszhiyezhengtimeYear") != null && teasession.getParameter("yszhiyezhengtimeYear").length() > 0 && teasession.getParameter("yszhiyezhengtimeMonth") != null && teasession.getParameter("yszhiyezhengtimeMonth").length() > 0 && teasession.getParameter("yszhiyezhengtimeDay") != null && teasession.getParameter("yszhiyezhengtimeDay").length() > 0)
				{
					yszhiyezhengtime = Doctor.sdf.parse(teasession.getParameter("yszhiyezhengtimeYear") + "-" + teasession.getParameter("yszhiyezhengtimeMonth") + "-" + teasession.getParameter("yszhiyezhengtimeDay")); //获取时间---医师执业证
				}

				int jishuzhicheng1 = Integer.parseInt(teasession.getParameter("jishuzhicheng1")); //技术职称1
				int jishuzhicheng2 = Integer.parseInt(teasession.getParameter("jishuzhicheng2")); //技术职称2
				int jishuzhicheng3 = Integer.parseInt(teasession.getParameter("jishuzhicheng3")); //技术职称3

				int xingzhengzhicheng = 0; //现任行政职务1
				if(teasession.getParameter("xingzhengzhicheng") != null && teasession.getParameter("xingzhengzhicheng").length() > 0)
				{
					xingzhengzhicheng = Integer.parseInt(teasession.getParameter("xingzhengzhicheng"));
				}
				int xingzhengzhicheng2 = 0; //现任行政职务2
				if(teasession.getParameter("xingzhengzhicheng2") != null && teasession.getParameter("xingzhengzhicheng2").length() > 0)
				{
					xingzhengzhicheng2 = Integer.parseInt(teasession.getParameter("xingzhengzhicheng2"));
				}

				int sheng = 0; //所属省份
				if(teasession.getParameter("sheng") != null && teasession.getParameter("sheng").length() > 0)
				{
					sheng = Integer.parseInt(teasession.getParameter("sheng"));
				}

				int shi = 0; //市（县）
				if(teasession.getParameter("shi") != null && teasession.getParameter("shi").length() > 0)
				{
					shi = Integer.parseInt(teasession.getParameter("shi"));
				}

				int gongzuodanwei = 0; //工作单位
				if(teasession.getParameter("gongzuodanwei") != null && teasession.getParameter("gongzuodanwei").length() > 0)
				{
					gongzuodanwei = Integer.parseInt(teasession.getParameter("gongzuodanwei"));
				}

				String gongzuodanwei2 = teasession.getParameter("gongzuodanwei2"); //请您填写您的单位名称:
				int gongzuodanwei2s = 0;
				if(teasession.getParameter("gongzuodanwei2s") != null && teasession.getParameter("gongzuodanwei2s").length() > 0)
				{
					gongzuodanwei2s = Integer.parseInt(teasession.getParameterValues("gongzuodanwei2s")[0]);
				}
				String yyjibie = teasession.getParameter("yyjibie"); //医院级别
				String yyxingzhi = teasession.getParameter("yyxingzhi"); //医院性质
				String suoshukeshi = teasession.getParameter("suoshukeshi"); //所属科室
				String danweidizhi = teasession.getParameter("danweidizhi"); //单位地址
				String youbian = teasession.getParameter("youbian"); //邮编编码
				String danweidianhua = teasession.getParameter("danweidianhua"); //单位电话
				String danweidianhua2 = teasession.getParameter("danweidianhua2"); //单位电话
				String shoujihao = teasession.getParameter("shoujihao"); //手 机 号
				String email = teasession.getParameter("email"); //Email地址
				String email2 = teasession.getParameter("email2"); //Email地址
				int zhuanyefangxiang1 = 0; //专业方向 第一专业
				if(teasession.getParameter("zhuanyefangxiang1") != null && teasession.getParameter("zhuanyefangxiang1").length() > 0)
				{
					zhuanyefangxiang1 = Integer.parseInt(teasession.getParameter("zhuanyefangxiang1"));
				}

				int zhuanyefangxiang2 = 0; //专业方向  第二专业
				if(teasession.getParameter("zhuanyefangxiang2") != null && teasession.getParameter("zhuanyefangxiang2").length() > 0)
				{
					zhuanyefangxiang2 = Integer.parseInt(teasession.getParameter("zhuanyefangxiang2"));
				}

				int zhuanyefangxiang3 = 0; //专业方向 第三专业
				if(teasession.getParameter("zhuanyefangxiang3") != null && teasession.getParameter("zhuanyefangxiang3").length() > 0)
				{
					zhuanyefangxiang3 = Integer.parseInt(teasession.getParameter("zhuanyefangxiang3"));
				}
				String zyfx1 = teasession.getParameter("zyfx1");
				String zyfx2 = teasession.getParameter("zyfx2");
				String zyfx3 = teasession.getParameter("zyfx3");

				String biyeyuanxiao1 = teasession.getParameter("biyeyuanxiao1"); //毕业院校名称--国内
				String biyeyuanxiao2 = teasession.getParameter("biyeyuanxiao2"); //毕业院校名称--国外
				//  Date biyeshijian1=Doctor.sdf.parse(teasession.getParameter("biyeshijian1Year") + "-" + teasession.getParameter("biyeshijian1Month") + "-" + teasession.getParameter("biyeshijian1Day")); //毕业或肄业时间--国内
				Date biyeshijian1 = null; //毕业或肄业时间--国外
				//Doctor.sdf.parse(teasession.getParameter("biyeshijian2Year") + "-" + teasession.getParameter("biyeshijian2Month") + "-" + teasession.getParameter("biyeshijian2Day"));
				if(teasession.getParameter("biyeshijian1Year") != null && teasession.getParameter("biyeshijian1Year").length() > 0 && teasession.getParameter("biyeshijian1Month") != null && teasession.getParameter("biyeshijian1Month").length() > 0 && teasession.getParameter("biyeshijian1Day") != null && teasession.getParameter("biyeshijian1Day").length() > 0)
				{
					biyeshijian1 = Doctor.sdf.parse(teasession.getParameter("biyeshijian1Year") + "-" + teasession.getParameter("biyeshijian1Month") + "-" + teasession.getParameter("biyeshijian1Day"));
				}

				Date biyeshijian2 = null; //毕业或肄业时间--国外
				//Doctor.sdf.parse(teasession.getParameter("biyeshijian2Year") + "-" + teasession.getParameter("biyeshijian2Month") + "-" + teasession.getParameter("biyeshijian2Day"));
				if(teasession.getParameter("biyeshijian2Year") != null && teasession.getParameter("biyeshijian2Year").length() > 0 && teasession.getParameter("biyeshijian2Month") != null && teasession.getParameter("biyeshijian2Month").length() > 0 && teasession.getParameter("biyeshijian2Day") != null && teasession.getParameter("biyeshijian2Day").length() > 0)
				{
					biyeshijian2 = Doctor.sdf.parse(teasession.getParameter("biyeshijian2Year") + "-" + teasession.getParameter("biyeshijian2Month") + "-" + teasession.getParameter("biyeshijian2Day"));
				}

				String zuigaoxuewei1 = teasession.getParameter("zuigaoxuewei1"); //最高学位--国内
				String zuigaoxuewei2 = teasession.getParameter("zuigaoxuewei2"); //最高学位--国外
				String zuigaoxueli1 = teasession.getParameter("zuigaoxueli1"); //最高学历--国内
				String zuigaoxueli2 = teasession.getParameter("zuigaoxueli2"); //最高学历--国外
				String gerenjianli = teasession.getParameter("gerenjianli"); //个人简历(从参加工作起)
				String jizhiqingkuang = teasession.getParameter("jizhiqingkuang"); //学会或社会兼职情况

				if(gongzuodanwei2 != null && gongzuodanwei2.length() > 0 && gongzuodanwei2s > 0) //说明是填写的医院
				{
					Provinces probj = Provinces.find(sheng);
					Provinces probj2 = Provinces.find(shi);
					int hid = Hospital.isHoname(gongzuodanwei2.trim(),probj.getProvincity(),probj2.getProvincity());
					if(hid > 0) //说明所填写的医院在医院总表中存在
					{
						gongzuodanwei = hid;
						gongzuodanwei2 = "";
						gongzuodanwei2s = 0;
					}else
					{
					  gongzuodanwei=  Hospital.create(gongzuodanwei2.trim(),probj.getProvincity(),probj2.getProvincity(),null,null,null,null,null,null,null,null);
						gongzuodanwei2 = "";
						gongzuodanwei2s = 0;

					}
				}

				if(doid > 0)
				{
					if(doobj.getGongzuodanwei() > 0) //如果之前
					{
						Hospital hobj = Hospital.find(doobj.getGongzuodanwei()); //修改之前的;
						DoctorRanking drobj = DoctorRanking.find(DoctorRanking.isDrid(community,hobj.getHoname().trim(),doobj.getSheng(),doobj.getShi()));
						drobj.setQuantity(drobj.getMrnumber() - 1,doobj.getSheng(),doobj.getShi(),yyjibie);
					} else //如果之前不是选中的
					{
						DoctorRanking drobj = DoctorRanking.find(DoctorRanking.isDrid(community,doobj.getGongzuodanwei2().trim(),doobj.getSheng(),doobj.getShi()));
						drobj.setQuantity(drobj.getMrnumber() - 1,doobj.getSheng(),doobj.getShi(),yyjibie);
					}
					//添加医生报名表数据
					String honame = null;
					if(gongzuodanwei > 0) //说明是选中的医院
					{
						Hospital hobj = Hospital.find(gongzuodanwei);
						honame = hobj.getHoname().trim();
					} else //不是选中的医院
					{
						honame = gongzuodanwei2.trim();
					}
					if(DoctorRanking.isDrid(community,honame,sheng,shi) > 0) //说明有这家医院
					{
						DoctorRanking drobj = DoctorRanking.find(DoctorRanking.isDrid(community,honame,sheng,shi));
						drobj.setQuantity(drobj.getMrnumber() + 1,sheng,shi,yyjibie);
					} else //没有这家医院 直接添加医院信息
					{
						DoctorRanking.create(honame,1,sheng,shi,community,yyjibie);
					}

					doobj.set(xingming,xingbie,youxiaozhengjian,youxiaozhengjianhao,chushengnianyue,
							  gerenzhaopianname,gerenzhaopianpath,yszigezheng,yszigezhengtime,yszhiyezheng,
							  yszhiyezhengtime,jishuzhicheng1,xingzhengzhicheng,sheng,shi,gongzuodanwei,
							  gongzuodanwei2,yyjibie,yyxingzhi,suoshukeshi,danweidizhi,youbian,danweidianhua,shoujihao,
							  email,zhuanyefangxiang1,zhuanyefangxiang2,zhuanyefangxiang3,biyeyuanxiao1,biyeyuanxiao2,
							  biyeshijian1,biyeshijian2,zuigaoxuewei1,zuigaoxuewei2,zuigaoxueli1,zuigaoxueli2,gerenjianli,
							  jizhiqingkuang,gongzuodanwei2s,jishuzhicheng2,jishuzhicheng3,xingzhengzhicheng2,danweidianhua2,email2,zyfx1,zyfx2,zyfx3);

				} else
				{
					
					doid = Doctor.create(xingming,xingbie,youxiaozhengjian,youxiaozhengjianhao,chushengnianyue,
										 gerenzhaopianname,gerenzhaopianpath,yszigezheng,yszigezhengtime,yszhiyezheng,
										 yszhiyezhengtime,jishuzhicheng1,xingzhengzhicheng,sheng,shi,gongzuodanwei,
										 gongzuodanwei2,yyjibie,yyxingzhi,suoshukeshi,danweidizhi,youbian,danweidianhua,shoujihao,
										 email,zhuanyefangxiang1,zhuanyefangxiang2,zhuanyefangxiang3,biyeyuanxiao1,biyeyuanxiao2,
										 biyeshijian1,biyeshijian2,zuigaoxuewei1,zuigaoxuewei2,zuigaoxueli1,zuigaoxueli2,gerenjianli,
										 jizhiqingkuang,community,gongzuodanwei2s,jishuzhicheng2,jishuzhicheng3,xingzhengzhicheng2,danweidianhua2,email2,zyfx1,zyfx2,zyfx3);
					//添加医生报名表数据
					String honame = null;
					if(gongzuodanwei > 0) //说明是选中的医院
					{
						Hospital hobj = Hospital.find(gongzuodanwei);
						honame = hobj.getHoname().trim();
					} else //不是选中的医院
					{
						honame = gongzuodanwei2.trim();
					}

					if(DoctorRanking.isDrid(community,honame,sheng,shi) > 0) //说明有这家医院
					{
						DoctorRanking drobj = DoctorRanking.find(DoctorRanking.isDrid(community,honame,sheng,shi));
						drobj.setQuantity(drobj.getMrnumber() + 1,sheng,shi,yyjibie);
					} else //没有这家医院 直接添加医院信息
					{
						DoctorRanking.create(honame,1,sheng,shi,community,yyjibie);
					}

				}

			} else if("delete".equals(act)) //删除
			{
				//Hospital hobj = Hospital.find(doobj.getGongzuodanwei());
				//hobj.setQuantity(hobj.getQuantity()-1);
				String hname = null;
				if(doobj.getGongzuodanwei() > 0)
				{
					Hospital hobj = Hospital.find(doobj.getGongzuodanwei());
					hname = hobj.getHoname().trim();

				} else
				{
					hname = doobj.getGongzuodanwei2();
				}
				if(DoctorRanking.isDrid(doobj.getCommunity(),hname,doobj.getSheng(),doobj.getShi()) > 0)
				{
					DoctorRanking drobj = DoctorRanking.find(DoctorRanking.isDrid(doobj.getCommunity(),hname,doobj.getSheng(),doobj.getShi()));
					drobj.setQuantity(drobj.getMrnumber() - 1,drobj.getSheng(),drobj.getShi(),drobj.getYyjibie());
				}

				doobj.delete();
				java.io.FileWriter fw = new java.io.FileWriter("C:\\test.txt",true);
				java.io.PrintWriter pw = new java.io.PrintWriter(fw);

				Provinces provinobj = Provinces.find(doobj.getSheng());
				Provinces provinobj2 = Provinces.find(doobj.getShi());
				pw.println("删除的用户："+teasession._rv.toString()+"**删除的医生:"+doobj.getXingming()+"**省份:"+provinobj.getProvincity()+"--"+provinobj2.getProvincity()+"**删除时间:"+Doctor.sdf.format(new Date()));
				pw.close();
				fw.close();

			}else if("DoctorEmail".equals(act))//给医生发送邮件
			{
                String doidstr = teasession.getParameter("doidstr");
                String sql = teasession.getParameter("sql");
                String subject = teasession.getParameter("subject");
                String content = teasession.getParameter("content");
                
                java.io.PrintWriter out = response.getWriter();
                if(doidstr.split("/") != null && doidstr.split("/").length > 0)
                {

                    for(int i = 1;i < doidstr.split("/").length;i++)
                    {
                        int did = Integer.parseInt(doidstr.split("/")[i]);
                        Doctor dobj = Doctor.find(did);
                        String ch = dobj.getXingming() + "医生您好:<br>";

                        tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
                        se.sendEmail(dobj.getEmail()+"@"+dobj.getEmail2(),subject,ch + content);

                    }
                } else
                {
                    java.util.Enumeration e = Doctor.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);

                    for(int i = 1;e.hasMoreElements();i++)
                    {
                        int doid2 = ((Integer) e.nextElement()).intValue();
                        Doctor doobj2 = Doctor.find(doid2);
                        String ch = doobj2.getXingming() + "医生您好:<br>";
                        tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
                        se.sendEmail(doobj2.getEmail()+"@"+doobj2.getEmail2(),subject,ch + content);

                    }
                }

                response.sendRedirect("/jsp/admin/orthonline/doctor.jsp");
                return;
			}else if("MemberEmail".equals(act))//判断会员发送
			{

                String doidstr = teasession.getParameter("doidstr");
                String sql = teasession.getParameter("sql");
                String subject = teasession.getParameter("subject");
                String content = teasession.getParameter("content");

                java.io.PrintWriter out = response.getWriter();
                if(doidstr.split("/") != null && doidstr.split("/").length > 0)
                {

                    for(int i = 1;i < doidstr.split("/").length;i++)
                    {
                        int pid = Integer.parseInt(doidstr.split("/")[i]);
                        Profile pobj = Profile.find(pid);

                        String ch =pobj.getMember()+ "您好:<br>";
						if((pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage))!=null && (pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)).length()>0)
						{
							ch = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage) + "您好:<br>";
						}
                        tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
						if(pobj.getEmail()!=null && pobj.getEmail().length()>0){
                            se.sendEmail(pobj.getEmail(),subject,ch + content);
                        }
                    }
                } else
                {
                    java.util.Enumeration e = Profile.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);

                    for(int i = 1;e.hasMoreElements();i++)
                    {
                        String member = ((String)e.nextElement());
                        Profile pobj = Profile.find(member);
                        String ch =member + "您好:<br>";
                        if((pobj.getLastName(teasession._nLanguage) + pobj.getFirstName(teasession._nLanguage)) != null && (pobj.getLastName(teasession._nLanguage) + pobj.getFirstName(teasession._nLanguage)).length() > 0)
                        {
                            ch = pobj.getLastName(teasession._nLanguage) + pobj.getFirstName(teasession._nLanguage) + "您好:<br>";
                        }
                        tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
                        if(pobj.getEmail() != null && pobj.getEmail().length() > 0)
                        {
                            se.sendEmail(pobj.getEmail(),subject,ch + content);
                        }
                    }
                }

                response.sendRedirect("/jsp/community/MemberManage.jsp"); 
                return;

			}
			else if("BirthdayLog".equals(act))//我与骨科分会同生日 登陆判断 是否是 1980 5 15 日的
			{
				String textfield = teasession.getParameter("textfield").trim();
				String textfield2 = teasession.getParameter("textfield2").trim();
				if(!Doctor.isExist(textfield,textfield2))
				{
					   response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您输入的姓名或证件号错误,请重新输入", "UTF-8"));
					   return;
				}
				if(!Doctor.isExist(textfield,textfield2," and chushengnianyue ="+DbAdapter.cite(Doctor.sdf.parse("1980-05-15"))))
				{
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("抱歉，您的生日与1980-05-15不符，请确认","UTF-8"));
                    return;
				}
				Doctor dobj2 = Doctor.find(Doctor.getPardaid("orthonline",textfield,textfield2));
				dobj2.setBirthdaylog(Doctor.sdf.parse("1980-05-15"));
				response.sendRedirect("/html/node/2208254-1.htm");
					   return;
			}

			if("下一步 预览".equals(teasession.getParameter("submitx")))
			{
				nexturl = "/jsp/admin/orthonline/DoctorShow.jsp?community=" + community + "&doid=" + doid;
			}

			response.sendRedirect(nexturl + "&community=" + community);
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
