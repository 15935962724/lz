package tea.ui.volunteer;

import javax.imageio.ImageIO;
import javax.servlet.*;
import javax.servlet.http.*;

import java.awt.image.BufferedImage;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import java.math.BigDecimal;
import java.sql.SQLException;
import tea.entity.volunteer.*;
import java.text.*;
import tea.entity.util.Spell;
import tea.entity.util.ZoomOut;

public class EditVolunteer extends TeaServlet
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
        int membertype = 0;
        if(teasession.getParameter("membertype") != null && teasession.getParameter("membertype").length() > 0)
        {
            membertype = Integer.parseInt(teasession.getParameter("membertype"));
        }
        try
        {
            /*导入 没有意义的方法
               if("Volunteerleading".equals(act))
               {

                   int count = Volunteerinto.count("");
                   java.util.Enumeration eu = Volunteerinto.findByname("",0,count);

                   for(int i = 0;eu.hasMoreElements();i++)
                   {
                       int id = Integer.parseInt(String.valueOf(eu.nextElement()));
                       Volunteerinto vol = Volunteerinto.find(id);

                       StringBuffer strs = new StringBuffer(",");
                       if(vol.getF12() != null)
                       {
                           strs.append("一月进医院").append(",");
                       }
                       if(vol.getF13() != null)
                       {
                           strs.append("二月进影院").append(",");
                       }
                       if(vol.getF14() != null)
                       {
                           strs.append("三月进车站").append(",");
                       }
                       if(vol.getF15() != null)
                       {
                           strs.append("四月进学校").append(",");
                       }
                       if(vol.getF16() != null)
                       {
                           strs.append("五月进社区").append(",");
                       }
                       if(vol.getF17() != null)
                       {
                           strs.append("六月进公园").append(",");
                       }
                       if(vol.getF18() != null)
                       {
                           strs.append("七月进工地").append(",");
                       }
                       if(vol.getF19() != null)
                       {
                           strs.append("八月进宾馆").append(",");
                       }
                       if(vol.getF20() != null)
                       {
                           strs.append("九月进商场").append(",");
                       }
                       if(vol.getF21() != null)
                       {
                           strs.append("十月进单位").append(",");
                       }
                       String member = "";
                       SeqTable seq = new SeqTable();
                       final java.text.DecimalFormat df5 = new java.text.DecimalFormat("00000");
                       if(vol.getname() != null)
                       {
                           member = member = Spell.getSpell(vol.getname().replaceAll(" ","").toLowerCase()).replaceAll(" ","") + df5.format(seq.getSeqNo(teasession._strCommunity));
                       }
                       int age = 0;
                       Date date = new Date();
                       Calendar cal = Calendar.getInstance();
                       cal.setTime(date);
                       if(teasession.getParameter("age") != null && teasession.getParameter("age").length() > 0)
                       {
                           age = Integer.parseInt(teasession.getParameter("age"));

                           int year = cal.get(Calendar.YEAR);
                           year = year - age;
                           cal.set(cal.YEAR,year);
                       }
                       boolean sex = vol.getSex().equals("男") ? true : false;
                       Profile.create(member,member,teasession._strCommunity,vol.getEmail(),date,1,teasession._nLanguage,vol.getname(),"","","",vol.getCity(),"","","",vol.getTelephone(),"","",vol.getModel());
                       Profile pro = Profile.find(member);
                       pro.setMobile(vol.getModel());
                       pro.setCity(vol.getCity(),teasession._nLanguage);
                       pro.setBirth(cal.getTime());
                       pro.setProvince(1,teasession._nLanguage);
                       pro.setSex(sex);
                       Volunteer.set(member,teasession._strCommunity,",3,4,2,2,2,1,1,1,1,1,",vol.getXuanyan(),vol.getZhiye(),strs.toString(),membertype);
                       Volunteer.typeIf(member);
                       Volunteer.typeMonth(member,vol.getmonth());
                   }
                   response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("导入成功！","UTF-8"));
                   return;
               }
             */
            if("EditVolunteer".equals(act))
            {

                String member = teasession.getParameter("member");

                /*
                                 if(teasession._rv != null)
                                 {
                    member = teasession._rv._strR;
                                 }
                 */

                String tongguo = teasession.getParameter("tongguo");

                String password = teasession.getParameter("EnterPassword");
                String firstname = teasession.getParameter("firstname");

                String isfalg = teasession.getParameter("falg");
                if("new".equals(isfalg))
                {
                    SeqTable seq = new SeqTable();
                    final java.text.DecimalFormat df5 = new java.text.DecimalFormat("00000");
                    if(firstname != null)
                    {
                        member = member = Spell.getSpell(firstname.replaceAll(" ","").toLowerCase()).replaceAll(" ","") + df5.format(seq.getSeqNo(teasession._strCommunity));
                    }
                }

                boolean sex = Integer.parseInt(teasession.getParameter("sex")) != 0 ? true : false;
                String telephone = teasession.getParameter("telephone");
                String email = teasession.getParameter("email");
                String mobile = teasession.getParameter("mobile");
                String xuanyan = teasession.getParameter("xuanyan");
                String zhiye = teasession.getParameter("zhiye");
                String city = teasession.getParameter("city");
                String card = teasession.getParameter("card");

                //标题图片
                String picture = teasession.getParameter("picture");

                if(teasession.getParameter("clearpicture") != null)
                {
                    picture = "";
                } else if(picture == null)
                {
                    Profile p = Profile.find(member);
                    picture = p.getPhotopath(teasession._nLanguage); //pro.setPhotopath(picture,teasession._nLanguage);
                }
                // System.out.println(picture);

                int province = 0;
                if(teasession.getParameter("province") != null && teasession.getParameter("province").length() > 0)
                {
                    province = Integer.parseInt(teasession.getParameter("province"));
                }
                String way = "";
                StringBuffer ways = new StringBuffer(",");
                for(int i = 0;i < Volunteer.WAY.length;i++)
                {
                    if(teasession.getParameter("way" + i) != null)
                    {
                        ways.append(Volunteer.WAY[i]).append(",");
                    }
                }
                way = ways.toString();
                Date date = new Date();
                String answer = "";
                StringBuffer str = new StringBuffer(",");
                String s = "";
                for(int i = 1;i < 13;i++)
                {
                    s = teasession.getParameter("wt" + i);
                    if(s != null)
                    {
                        str.append(s).append(",");
                    }
                }
                answer = str.toString();

                String birth = teasession.getParameter("birth");

                if(!Profile.isExisted(member))
                {
                    Profile.create(member,password,teasession._strCommunity,email,Entity.sdf.parse(birth),1,teasession._nLanguage,firstname,"","","",city,"","","",telephone,"","",mobile);
                    Profile pro = Profile.find(member);
                    pro.setMobile(mobile);
                    pro.setCity(city,teasession._nLanguage);
                    pro.setBirth(Entity.sdf.parse(birth));
                    pro.setProvince(province,teasession._nLanguage);
                    pro.setSex(sex);
                    pro.setCard(card);

                    pro.setPhotopath(picture,teasession._nLanguage);

                    Volunteer.set(member,teasession._strCommunity,answer,xuanyan,zhiye,way,membertype);
                    //if(tongguo.equals("tongguo"))
                    //{
                    Volunteer.typeIf(member);
                    //}
                    String subject = "";
                    
                    StringBuffer sb = new StringBuffer();
                    sb.append("亲爱的"+firstname+"    同学/先生/女士<br>，");
                    sb.append("　　你好，你已成功加入首都红丝带防艾志愿者团队，你可以随时登录交流地（http://www.bjrroc.org/html/node/34726-1.htm）参与各个话题的讨论，还可以参与各区县组织的活动，发贴和参与活动都是可以得积分的，积分越高级别就越高，积分高的志愿者我们会在志愿者中心进行公开表彰，真心期待你的参与！");
                    sb.append("<br><br>");
                    sb.append("　　　　志愿防艾  重我做起！");
                    sb.append("<br><br>");
                    sb.append("　　　　首都红丝带网");
                    tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
                    se.sendEmail(pro.getEmail(),subject,sb.toString());

                    response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(teasession._strCommunity,"UTF-8"));
                } else
                {
                    Profile pro = Profile.find(member);
                    pro.setFirstName(firstname,teasession._nLanguage);
                    pro.setEmail(email);
                    pro.setTelephone(telephone,teasession._nLanguage);
                    pro.setMobile(mobile);
                    pro.setCity(city,teasession._nLanguage);
                    pro.setBirth(Entity.sdf.parse(birth));
                    pro.setProvince(province,teasession._nLanguage);
                    pro.setSex(sex);
                    pro.setCard(card);
                    pro.setPhotopath(picture,teasession._nLanguage);

                    Volunteer.set(member,teasession._strCommunity,answer,xuanyan,zhiye,way,membertype);

                    // if("tongguo".equals(tongguo))//审核通过，默认是不用审核的
                    // {
                    Volunteer.typeIf(member);
                    //}

                    response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode(teasession._strCommunity,"UTF-8"));
                    //   response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("您的信息已提交成功，组委会工作人员会在三个工作日内对您的信息进行审核，请您继续关注首都红丝带网站查看志愿者的相关信息，谢谢您的参与！","UTF-8"));
                }
                return;
            } else if("EditVolunteer2".equals(act))
            {
                String nexturl = teasession.getParameter("nexturl");

                String member = teasession.getParameter("member");

                System.out.println(nexturl);

                String password = teasession.getParameter("EnterPassword");
                String firstname = teasession.getParameter("firstname");

                String isfalg = teasession.getParameter("falg");

                boolean sex = Integer.parseInt(teasession.getParameter("sex")) != 0 ? true : false;
                String telephone = teasession.getParameter("telephone");
                String email = teasession.getParameter("email");
                String mobile = teasession.getParameter("mobile");
                String xuanyan = teasession.getParameter("xuanyan");
                String zhiye = teasession.getParameter("zhiye");
                String city = teasession.getParameter("city");
                String card = teasession.getParameter("card");

                //标题图片
                String picture = teasession.getParameter("picture");

                if(teasession.getParameter("clearpicture") != null)
                {
                    picture = "";
                } else if(picture == null)
                {
                    Profile p = Profile.find(member);
                    picture = p.getPhotopath(teasession._nLanguage); //pro.setPhotopath(picture,teasession._nLanguage);
                }
                // System.out.println(picture);

                int province = 0;
                if(teasession.getParameter("province") != null && teasession.getParameter("province").length() > 0)
                {
                    province = Integer.parseInt(teasession.getParameter("province"));
                }
                String way = "";
                StringBuffer ways = new StringBuffer(",");
                for(int i = 0;i < Volunteer.WAY.length;i++)
                {
                    if(teasession.getParameter("way" + i) != null)
                    {
                        ways.append(Volunteer.WAY[i]).append(",");
                    }
                }
                way = ways.toString();

                Date date = new Date();
                String answer = teasession.getParameter("answer");

                String birth = teasession.getParameter("birth");

                if(!Profile.isExisted(member))
                {
                    Profile.create(member,password,teasession._strCommunity,email,Entity.sdf.parse(birth),1,teasession._nLanguage,firstname,"","","",city,"","","",telephone,"","",mobile);
                    Profile pro = Profile.find(member);
                    pro.setMobile(mobile);
                    pro.setCity(city,teasession._nLanguage);
                    pro.setBirth(Entity.sdf.parse(birth));
                    pro.setProvince(province,teasession._nLanguage);
                    pro.setSex(sex);
                    pro.setCard(card);

                    pro.setPhotopath(picture,teasession._nLanguage);

                    Volunteer.set(member,teasession._strCommunity,answer,xuanyan,zhiye,way,membertype);
                    //if(tongguo.equals("tongguo"))
                    //{
                    Volunteer.typeIf(member);
                    //}

                    //response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("您的信息已提交成功，组委会工作人员会在三个工作日内对您的信息进行审核，请您继续关注首都红丝带网站查看志愿者的相关信息，谢谢您的参与！","UTF-8"));
                } else
                {
                    Profile pro = Profile.find(member);
                    pro.setFirstName(firstname,teasession._nLanguage);
                    pro.setEmail(email);
                    pro.setTelephone(telephone,teasession._nLanguage);
                    pro.setMobile(mobile);
                    pro.setCity(city,teasession._nLanguage);
                    pro.setBirth(Entity.sdf.parse(birth));
                    pro.setProvince(province,teasession._nLanguage);
                    pro.setSex(sex);
                    pro.setCard(card);
                    pro.setPhotopath(picture,teasession._nLanguage);

                    Volunteer.set(member,teasession._strCommunity,answer,xuanyan,zhiye,way,membertype);

                    // if("tongguo".equals(tongguo))//审核通过，默认是不用审核的
                    // {
                    Volunteer.typeIf(member);
                    //}

                    // response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("您的信息已提交成功，组委会工作人员会在三个工作日内对您的信息进行审核，请您继续关注首都红丝带网站查看志愿者的相关信息，谢谢您的参与！","UTF-8"));
                }
                response.sendRedirect(nexturl);
                return;
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }

    }

    public void destroy()
    {
    }
}
