package tea.ui.bpicture;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.bpicture.*;
import tea.entity.member.*;
import java.sql.*;
import java.util.Date;
import java.math.BigDecimal;
import tea.entity.admin.AdminUsrRole;
import javax.imageio.*;
import java.awt.image.*;
import tea.entity.util.*;
import tea.entity.node.Node;
import java.text.SimpleDateFormat;
import java.text.*;
import tea.service.SendEmaily;

public class EditBPperson extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");

        TeaSession teasession = new TeaSession(request);
        String act = teasession.getParameter("act");
        String member = teasession.getParameter("member");
        if(member == null)
        {
            member = teasession._rv._strR;
        }
        String pid = teasession.getParameter("pid");
        String url = teasession.getParameter("url");
        try
        {

            if(act.equals("reg")) //买家注册
            {
                int sex = Integer.parseInt(teasession.getParameter("sex"));
                String name = teasession.getParameter("name");
                String ename = teasession.getParameter("ename");

                String password = String.valueOf((int) (Math.random() * (999999 - 1) + 1));
                String MSN = teasession.getParameter("MSN");
//                String jobstyle = teasession.getParameter("jobstyle");
//                String jobother = teasession.getParameter("jobother");
//                String comstyle = teasession.getParameter("comstyle");
//                String comother = teasession.getParameter("comother");
//                String email = teasession.getParameter("email");
//                String comname = teasession.getParameter("comname");
//                String web = teasession.getParameter("web");
//                String city = teasession.getParameter("city");
//                String state = teasession.getParameter("state");
//                String addr = teasession.getParameter("addr");
//                String zip = teasession.getParameter("zip");
                String mobile = teasession.getParameter("mobile");
                String phone = teasession.getParameter("phone");

                int terms = 0;
                if(teasession.getParameter("terms").length() > 0 && teasession.getParameter("terms") != null)
                {
                    terms = Integer.parseInt(teasession.getParameter("terms"));
                }
                int regstyle = 1;
//                StringBuffer vector = new StringBuffer();
//                StringBuffer meteria = new StringBuffer();
//                int photoyear = -1;
//                if(regstyle == 0)
//                {
//                    String photoyears = teasession.getParameter("photoyear");
//
//                    if(photoyears != null)
//                    {
//                        photoyear = Integer.parseInt(photoyears);
//                    }
//
//                    String[] meterias = teasession.getParameterValues("meteria");
//                    if(meterias != null)
//                    {
//                        for(int i = 0;i < meterias.length;i++)
//                        {
//                            meteria.append(meterias[i]).append("/");
//                        }
//                    }
//                    String[] vectors = teasession.getParameterValues("vector");
//                    if(vectors != null)
//                    {
//                        for(int i = 0;i < vectors.length;i++)
//                        {
//                            vector.append(vectors[i]).append("/");
//                        }
//                    }
//                }
                String mailto = teasession.getParameter("mailto");
                int mt = 0;
                if(mailto != null)
                {
                    mt = Integer.parseInt(mailto);
                }
                try
                {
                    SendEmaily se = new SendEmaily(teasession._strCommunity);
//                    String sexs = sex == 0 ? "女士" : "先生";
                    StringBuffer sb = new StringBuffer();

                    sb.append("尊敬的用户："+name+"<br/>");
                    sb.append("　　您好！<br/>");
                    sb.append("　　感谢您注册成为B-Picure商业图片网的用户 。<br/>");
					sb.append("　　您的登录名："+member+"<br/>");
					sb.append("　　密码："+password+"<br/>");
					sb.append("　　密码和个人资料可以随时登录<a href='http://bp.redcome.com'>http://bp.redcome.com</a>进行更改 。<br/>");
					sb.append("　　以下权利能够帮助您更好的使用B-Picture商业图片网<br/>");
					sb.append("　　　　⑴&nbsp;<a href=\"http://bp.redcome.com/jsp/bpicture/buyer/ChangeLog.jsp?member=" + java.net.URLEncoder.encode(member,"utf-8") + "&back=1\">修改密码</a><br/>");
					sb.append("　　　　⑵&nbsp;<a href=\"http://bp.redcome.com\">我只是来看看</a><br/>");
					sb.append("　　　　⑶&nbsp;<a href=\"http://bp.redcome.com/servlet/Node?node=2201053&member=" + java.net.URLEncoder.encode(member,"utf-8") + "\">我想买图</a><br/>");
					sb.append("　　　　⑷&nbsp;<a href=\"http://bp.redcome.com/servlet/Node?node=2201052&member=" + java.net.URLEncoder.encode(member,"utf-8") + "\">我想卖图</a><br/>");
                    sb.append("　　B-Picture商业图片网拥有500万张正版图片 ，完全可以满足创意人 、媒体 、出版行业对图片的各种高质量要求 ，同时每周都会定期更新近万张图片 ，每次查找图片 ，都能给您带来崭新感受 。<br/>");
                    sb.append("　　为更好的享受B-Picture商业图片网为您提供的专项服务 ，请妥善保管您的登录名和密码 。<br/>");
                    sb.append("　　如有任何疑问或意见建议 ，欢迎您随时与我们联系 。您的愿望就是我们努力的目标 。<br/>");
                    sb.append("　　再次感谢您的加入 。<br/>");
                    sb.append("　　B-Picture商业图片网客户服务中心<br/>");
                    sb.append("　　<a href='http://bp.redcome.com'>http://bp.redcome.com</a><br/>");
                    sb.append("　　E －mail:Service@redcome.com<br/>");
                    sb.append("　　Tel: 010-84909966<br/>");


                    se.sendEmail(member,"B-picture商业图片网会员注册成功确认信",sb.toString());

                } catch(Exception ex)
                {
                    ex.printStackTrace();
                    url = "/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("邮件发送失败,请检查是否存在该邮箱！","UTF-8");
                    response.sendRedirect(url);
                    return;
                }
                Bperson.createBuy(name,ename,sex,member,member,password,MSN,mobile,phone,terms,regstyle,mt);
                response.sendRedirect("/jsp/bpicture/regist/RegSuccess.jsp?info=" + java.net.URLEncoder.encode("感谢您注册B-p,请到您的注册邮箱收取您的登录密码，根据您的需求进行相关操作！","utf-8") + "&but=0");
//              Bperson.create(name,sex,member,member,password,MSN,comstyle,comname,city,state,addr,zip,mobile,phone,terms,regstyle,photoyear,meteria.toString(),vector.toString(),mt);

//                if(regstyle == 0)
//                {
//                    url = "/jsp/bpicture/regist/RegisterSaleCon.jsp?member=" + member;
//                } else
//                {
//                    RV rv = new RV(member);
//                    HttpSession session = request.getSession(true);
//                    session.setAttribute("tea.RV",rv);
//                    session.setAttribute("LoginId",member);
//                    session.setAttribute("password",password);
//
//                    url = "/jsp/bpicture/index.jsp";
//                }
//                response.sendRedirect(url);
                return;
            } else if(act.equals("regbuy"))
            {
                String represent = teasession.getParameter("represent");
                String comstyle = teasession.getParameter("comstyle");
                String comname = teasession.getParameter("comname");
                String city = teasession.getParameter("city");
                String state = teasession.getParameter("state");
                String addr = teasession.getParameter("addr");
                String zip = teasession.getParameter("zip");
                if(teasession.getParameter("upd")!=null){
                    String MSN = teasession.getParameter("MSN");
                    Bperson.set(member,addr,city,state,zip,comname,comstyle,1,represent,",MSN='"+MSN+"'");
                    response.sendRedirect("/jsp/bpicture/buyer/ChangeContact.jsp");
                }else{
                    Bperson.set(member,addr,city,state,zip,comname,comstyle,1,represent,"");
                    RV rv = new RV(member);
                    HttpSession session = request.getSession(true);
                    session.setAttribute("tea.RV",rv);
                    session.setAttribute("LoginId",member);

                    response.sendRedirect("/jsp/bpicture/index.jsp");
                }
                return;
            } else if(act.equals("upper")) //贡献者家注册
            {
                String represent = teasession.getParameter("represent");
                int chequeTerms = 0;
                if(teasession.getParameter("chequeterms") != null && teasession.getParameter("chequeterms").length() > 0)
                {
                    chequeTerms = Integer.parseInt(teasession.getParameter("chequeterms"));
                }

                String comname = teasession.getParameter("comname");
                String comstyle = teasession.getParameter("comstyle");
                String city = teasession.getParameter("city");
                String state = teasession.getParameter("state");
                String addr = teasession.getParameter("addr");
                String zip = teasession.getParameter("zip");
                Bperson bp = Bperson.findmember(member);
                StringBuffer vector = new StringBuffer();
                StringBuffer meteria = new StringBuffer();
                int photoyear = -1;

                String photoyears = teasession.getParameter("photoyear");

                if(photoyears != null)
                {
                    photoyear = Integer.parseInt(photoyears);
                }

                String[] meterias = teasession.getParameterValues("meteria");
                if(meterias != null)
                {
                    for(int i = 0;i < meterias.length;i++)
                    {
                        meteria.append(meterias[i]).append("/");
                    }
                }
                String[] vectors = teasession.getParameterValues("vector");
                if(vectors != null)
                {
                    for(int i = 0;i < vectors.length;i++)
                    {
                        vector.append(vectors[i]).append("/");
                    }
                }
                ServletContext application = getServletContext();
                String cardtype = teasession.getParameter("cardtype");

                String idcard1 = "";
                String idcard2 = "";
                String cd1 = "",cd2="";
                   if(bp.getCard()!=null){
                     String cardArray[] = bp.getCard().split("!");
                     for(int z = 0; z < cardArray.length; z++){
                       if(z==1){
                         cd1 = cardArray[1];
                       }
                       if(z == 2){
                         cd2 = cardArray[2];
                       }
                     }
                   }

                if(cardtype.equals("1"))
                {
                    byte[] by1 = teasession.getBytesParameter("ID1");

                    if(by1 != null && by1.length > 0)
                    {

                        if(bp.getCard()!=null&&cd1.length()>0)
                        {
                            new File(application.getRealPath(bp.getCard().split("!")[1])).delete();
                        }

                        idcard1 = write(teasession._strCommunity,"salepic/" + member + "/checkStatus",by1,".jpg");
                    }
                    byte[] by2 = teasession.getBytesParameter("ID2");

                    if(by2 != null && by2.length > 0)
                    {
                        if(bp.getCard()!=null&&cd2.length()>0)
                        {
                            new File(application.getRealPath(bp.getCard().split("!")[2])).delete();
                        }

                        idcard2 = write(teasession._strCommunity,"salepic/" + member + "/checkStatus",by2,".jpg");
                    }
                } else
                {
                    byte[] by1 = teasession.getBytesParameter("armycard1");

                    if(by1 != null && by1.length > 0)
                    {
                        if(bp.getCard()!=null&&cd1.length()>0)
                        {
                            new File(application.getRealPath(bp.getCard().split("!")[1])).delete();
                        }

                        idcard1 = write(teasession._strCommunity,"salepic/" + member + "/checkStatus",by1,".jpg");
                    }
                    byte[] by2 = teasession.getBytesParameter("armycard2");

                    if(by2 != null && by2.length > 0)
                    {
                        if(bp.getCard()!=null&&cd2.length()>0)
                        {
                            new File(application.getRealPath(bp.getCard().split("!")[2])).delete();
                        }

                        idcard2 = write(teasession._strCommunity,"salepic/" + member + "/checkStatus",by2,".jpg");
                    }
                }
                String card = cardtype + "!" + idcard1 + "!" + idcard2; //身份证||军官证复印件路径

                if(card.length() < 3)
                {
                    card = Bperson.findmember(member).getCard();
                }
                String testpic = "";
                for(int i = 1;i <= 5;i++)
                {
                    byte[] by = teasession.getBytesParameter("testpic" + i);

                    if(by != null && by.length > 0)
                    {
                        if(bp.getTestpic() != null && bp.getTestpic().split("!")[i - 1] != null)
                        {
                            new File(application.getRealPath(bp.getTestpic().split("!")[i - 1])).delete();
                        }

                        testpic += write(teasession._strCommunity,"salepic/" + member + "/testpic",by,".jpg");
                    }
                    testpic += "!";
                }
                if(testpic.length() < 6)
                {
                    testpic = Bperson.findmember(member).getTestpic();
                }
                if(teasession.getParameter("upd") != null)
                {

                    String mobile = teasession.getParameter("mobile");
                    String phone = teasession.getParameter("phone");

                    String MSN = teasession.getParameter("MSN");

                    Bperson.setph(member,addr,city,state,zip,comname,comstyle,photoyear,vector.toString(),meteria.toString(),MSN,mobile,phone,card,testpic);
                    response.sendRedirect(url);
                } else
                {
                    AdminUsrRole.create(teasession._strCommunity,member,"/358/","/",0,null,null);

                    Bperson.set(member,addr,city,state,zip,comname,comstyle,0,represent,card,testpic,photoyear,vector.toString(),meteria.toString());

                    Bprice b = Bprice.find(member);
                    b.set(member,teasession._strCommunity,new BigDecimal(0));
                    if(teasession.getParameter("bts")==null){
                        RV rv = new RV(member);
                        HttpSession session = request.getSession(true);

                        session.setAttribute("tea.RV",rv);
                        session.setAttribute("LoginId",member);

                        response.sendRedirect("/jsp/bpicture/regist/RegSuccess.jsp?info=" + java.net.URLEncoder.encode("您的摄影师身份和样图资料已提交，请等待管理员进行审核，审核通过后会发送至您的邮箱请注意查收！","utf-8") + "&but=1");
                    }else{
                        response.sendRedirect("http://bp.redcome.com/jsp/bpicture");
                    }
                }
                return;
            } else if(act.equals("uplog")) //修改登陆信息
            {
                int sex = Integer.parseInt(request.getParameter("sex"));
                String name = request.getParameter("name");
                String ename = request.getParameter("ename");
//                String email = request.getParameter("email");
                Bperson.set(member,name,ename,sex);
                response.sendRedirect(url);
                return;
            } else if(act.equals("uppwd")) //修改密码
            {
                String password = request.getParameter("newpwd");
                Bperson.set(member,password);
                Profile p = Profile.find(member);
                p.setPassword(password);
                response.sendRedirect("/jsp/bpicture/buyer/ChangeLog.jsp?member="+java.net.URLEncoder.encode(member,"utf-8")+"&sucinfo="+java.net.URLEncoder.encode("密码修改成功！","utf-8"));
                return;
            } else if(act.equals("forgetpwd")) //找回密码
            {
                Profile p = Profile.find(member);
                String pwd = p.getPassword();

                try
                {
                    SendEmaily se = new SendEmaily(teasession._strCommunity);

                    StringBuffer sb = new StringBuffer();
                    sb.append("尊敬的&nbsp;" + member + "&nbsp;您好:<br/>　　该会员ID的密码为【" + pwd + "】。 请登陆 bp.redcome.com 后修改您的密码!<br/>　　B-picture商业图片网");
                    se.sendEmail(member,"B-picture商业图片网找回密码",sb.toString());

                } catch(Exception ex)
                {
                    ex.printStackTrace();
                    url = "/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("邮件发送失败","UTF-8");
                    response.sendRedirect(url);
                    return;
                }
                response.sendRedirect("/jsp/bpicture/regist/ForgetPwd.jsp?suc=1&member=" + member);
                return;
//            } else if(act.equals("upcontact")) //修改联系方式
//            {
//                String comname = teasession.getParameter("comname");
//                String comstyle = teasession.getParameter("comstyle");
//                String MSN = teasession.getParameter("MSN");
//                String city = teasession.getParameter("city");
//                String state = teasession.getParameter("state");
//                String addr = teasession.getParameter("addr");
//                String zip = teasession.getParameter("zip");
//                String mobile = teasession.getParameter("mobile");
//                String phone = teasession.getParameter("phone");
//
//                StringBuffer vector = new StringBuffer();
//                StringBuffer meteria = new StringBuffer();
//                int photoyear = -1;
//
//                String photoyears = teasession.getParameter("photoyear");
//
//                if(photoyears != null)
//                {
//                    photoyear = Integer.parseInt(photoyears);
//                }
//
//                String[] meterias = teasession.getParameterValues("meteria");
//                if(meterias != null)
//                {
//                    for(int i = 0;i < meterias.length;i++)
//                    {
//                        meteria.append(meterias[i]).append("/");
//                    }
//                }
//                String[] vectors = teasession.getParameterValues("vector");
//                if(vectors != null)
//                {
//                    for(int i = 0;i < vectors.length;i++)
//                    {
//                        vector.append(vectors[i]).append("/");
//                    }
//                }
//
//                Bperson.setph(member,addr,city,state,zip,comname,comstyle,photoyear,vector.toString(),meteria.toString(),MSN,mobile,phone);
//                response.sendRedirect(url);
//                return;
            } else if(act.equals("uppayment")) //修改付款方式
            {
                Bperson bp = Bperson.findmember(member);
                int ipayStyle = bp.getPayStyle();
                String payStyle = teasession.getParameter("paystyle");
                if(payStyle!=null){
                   ipayStyle = Integer.parseInt(payStyle);
                }
//                String moneytype = teasession.getParameter("moneytype");
//                int imt = Integer.parseInt(moneytype);

                //支票数据
                String cper = teasession.getParameter("cper");
                String bcper = bp.getChequePayee();
                if(cper!=null){
                    bcper = cper;
                }
                String bcity = bp.getChequeCity();
                String chequeCity = teasession.getParameter("chequecity");
                if(chequeCity!=null){
                    bcity = chequeCity;
                }
                String bcounty = bp.getChequeCounty();
                String chequeCounty = teasession.getParameter("chequecounty");
                if(chequeCounty!=null){
                    bcounty = chequeCounty;
                }
                String bcaddr = bp.getChequeaddr();
                String chequeaddr = teasession.getParameter("chequeaddr");
                if(chequeaddr!=null){
                    bcaddr = chequeaddr;
                }
                String bczip = bp.getChequeZip();
                String chequezip = teasession.getParameter("chequezip");
                if(chequezip!=null){
                    bczip = chequezip;
                }

                //发票数据
                String binvmen = bp.getInvmen();
                String invmen = teasession.getParameter("invmen");
                if(invmen!=null){
                    binvmen = invmen;
                }
                String binvaddr = bp.getInvaddr();
                String invaddr = teasession.getParameter("invaddr");
                if(invaddr!=null){
                    binvaddr = invaddr;
                }
                String binvzip = bp.getInvzip();
                String invzip = teasession.getParameter("invzip");
                if(invzip!=null){
                    binvzip = invzip;
                }
                String binvcomname = bp.getInvcomname();
                String invcomname = teasession.getParameter("invcomname");
                if(invcomname!=null){
                    binvcomname = invcomname;
                }

                //转帐数据
                String baccount = bp.getAccount();
                String account = teasession.getParameter("account");
                if(account!=null){
                    baccount = account;
                }
                String bbank = bp.getBank();
                String bank = teasession.getParameter("bank");
                if(bank!=null){
                    bbank = bank;
                }
                int baccountnum = 0;
                baccountnum = bp.getAccountnum();
                String accountnum = teasession.getParameter("accountnum");
                if(accountnum!=null){
                    baccountnum = Integer.parseInt(accountnum);
                }

                Bperson.set(member,bcper,bcity,bcounty,bcaddr,bczip,ipayStyle,binvmen,binvaddr,binvzip,binvcomname,baccount,bbank,baccountnum);
                response.sendRedirect(url);
                return;
            } else if(act.equals("create")) //创建图库
            {
                String lname = teasession.getParameter("lbname");
				String back = teasession.getParameter("back");
                if(BLightbox.isExisted(member,lname))
                {
                    response.sendRedirect("/jsp/bpicture/buyer/CreateLightbox.jsp?isext=" + java.net.URLEncoder.encode(lname,"utf-8")+"&back="+back);

                    return;
                } else
                {
                    BLightbox.create(lname,member);
                    response.sendRedirect("/jsp/bpicture/buyer/ViewLightbox.jsp?lightbox=" + java.net.URLEncoder.encode(lname,"utf-8")+"&back="+back);
                    return;
                }
            } else if(act.equals("rename")) //图库重命名
            {
                String oldname = teasession.getParameter("Lightboxes");
                String newname = teasession.getParameter("rename");
				String back = teasession.getParameter("back");
                if(BLightbox.isExisted(member,newname))
                {
                    response.sendRedirect("/jsp/bpicture/buyer/RenameLightbox.jsp?isext=" + java.net.URLEncoder.encode(newname,"utf-8")+"&back="+back);
                    return;
                } else
                {

                    String[] pic = BLightbox.find(BLightbox.findId(member,oldname)).getpicid().split(",");
                    BLightbox.set(member,oldname,newname);
                    for(int i = 1;i < pic.length;i++)
                    {
                        BLightbox.setLB(member,newname,Integer.parseInt(pic[i]),oldname);
                    }

                    response.sendRedirect("/jsp/bpicture/buyer/ViewLightbox.jsp?lightbox=" + java.net.URLEncoder.encode(newname,"utf-8")+"&back="+back);
                    return;
                }
            } else if(act.equals("del")) //删除图库
            {
                String lightbox = teasession.getParameter("Lightboxes");
				String back = teasession.getParameter("back");
                int lbid = BLightbox.findId(member,lightbox);
                BLightbox.delete(lbid);
                response.sendRedirect("/jsp/bpicture/buyer/ViewLightbox.jsp?&back="+back);
                return;
            } else if(act.equals("EditAuditPicture")) //审核图片
            {
                int nodes = 0;
                if(teasession.getParameter("nodes") != null && teasession.getParameter("nodes").length() > 0)
                {
                    nodes = Integer.parseInt(teasession.getParameter("nodes"));
                }

                int mediatype = 0;
                if(teasession.getParameter("mediatype") != null && teasession.getParameter("mediatype").length() > 0)
                {
                    mediatype = Integer.parseInt(teasession.getParameter("mediatype"));
                }
                int error = 0;
                if(teasession.getParameter("error") != null && teasession.getParameter("error").length() > 0)
                {
                    error = Integer.parseInt(teasession.getParameter("error"));
                }
                int passpage = 0;
                if(teasession.getParameter("passpage") != null && teasession.getParameter("passpage").length() > 0)
                {
                    passpage = Integer.parseInt(teasession.getParameter("passpage"));
                }
                String nexturl = teasession.getParameter("nexturl");

                if(passpage == 1)
                {
                    //图片审核通过后将读取出来的图片参数存库
                    ServletContext application = getServletContext();
                    ExifReader er = ExifReader.getInstance(application.getRealPath("/res/" + teasession._strCommunity + "/picture/" + nodes + ".jpg"));

                    try
                    {
                        String artist = er.getArtist();
                        String make = er.getMake();
                        String model = er.getModel();
                        String orientation = er.getOrientation();
                        String xresolution = er.getXResolution();
                        String yresolution = er.getYResolution();
                        String resolutionunit = er.getResolutionUnit();
                        Date datetime = null;
                        if(er.getDateTime().length() != 0)
                        {
                            datetime = BExifParam.sdf.parse(er.getDateTime());
                        }
                        String ycbcrpositioning = er.getYcbcrpositioning();
                        String exposuretime = er.getExposuretime();
                        String fnumber = er.getfnumber();
                        String gpsinfo = er.getGPSinfo();
                        Date dtoriginal = null;
                        if(er.getPhotoCreatTime().length() != 0)
                        {
                            dtoriginal = BExifParam.sdf.parse(er.getPhotoCreatTime());
                        }
                        Date stdigitized = null;
                        if(er.getDigitizedTime().length() != 0)
                        {
                            stdigitized = BExifParam.sdf.parse(er.getDigitizedTime());
                        }
                        String cbperpixel = er.getCbPerPixel();
                        String exposurebasvalue = er.getExposureValue();
                        String maxaperturevalue = er.getMaxApertureValue();
                        String meteringmode = er.getMeteringmode();
                        String lightsource = er.getLightSoure();
                        String flash = er.getFlash();
                        String focallength = er.getFocalLength();
                        String colorspace = er.getColorSpace();
                        String imagewidth = er.getImageWidth();
                        String imagelength = er.getImageLength();
                        BExifParam.create(nodes,artist,make,model,orientation,xresolution,yresolution,resolutionunit,datetime,ycbcrpositioning,exposuretime,fnumber,gpsinfo,dtoriginal,stdigitized,cbperpixel,exposurebasvalue,maxaperturevalue,meteringmode,lightsource,flash,focallength,colorspace,imagewidth,imagelength);
                    } catch(SQLException ex1)
                    {
                        ex1.getStackTrace();
                    } catch(ParseException ex1)
                    {
                        ex1.getStackTrace();
                    }
                }
                int statussss = 0;
                if(teasession.getParameter("statussss") != null && teasession.getParameter("statussss").length() > 0)
                {
                    statussss = Integer.parseInt(teasession.getParameter("statussss"));
                }

                String mediaref = "";
                if(teasession.getParameter("mediaref") != null && teasession.getParameter("mediaref").length() > 0)
                {
                    mediaref = teasession.getParameter("mediaref");
                }

                String members = "";
                if(teasession.getParameter("member") != null && teasession.getParameter("member").length() > 0)
                {
                    members = teasession.getParameter("member");
                }
                ServletContext application = getServletContext();
                Node n = Node.find(nodes);
                File fpic = new File(application.getRealPath("/res/" + n.getCommunity() + "/picture/" + nodes + ".jpg"));
                BufferedImage bi = ImageIO.read(fpic);
                ZoomOut zo = new ZoomOut();
                bi = zo.imageZoomOut(bi,450,450);
                ImageIO.write(bi,"JPEG",fpic);

                Date date = new Date();
                Baudit bobg = Baudit.find(nodes);
                Baudit.set(0,nodes,teasession._rv.toString(),teasession._strCommunity,mediaref,mediatype,bobg.getReceived(),error,date,passpage,passpage,statussss,0,member,"",0,0);
                String param = teasession.getParameter("param");
                response.sendRedirect("/jsp/bpicture/AuditPicture.jsp?community=" + teasession._strCommunity + param);
                return;
            }

            else if(act.equals("calprice")) //计算价格
            {

                int typepic = 0;
                if(teasession.getParameter("typepic") != null && teasession.getParameter("typepic").length() > 0)
                {
                    typepic = Integer.parseInt(teasession.getParameter("typepic"));
                }
                int nodes = 0;
                if(teasession.getParameter("nodes") != null && teasession.getParameter("nodes").length() > 0)
                {
                    nodes = Integer.parseInt(teasession.getParameter("nodes"));
                }

                int id = 0;
                if(teasession.getParameter("id") != null && teasession.getParameter("id").length() > 0)
                {
                    id = Integer.parseInt(teasession.getParameter("id"));
                }
                if(typepic == 1)
                {
                    String jiage = null;

                    if(teasession.getParameter("jiage") != null && teasession.getParameter("jiage").length() > 0)
                    {
                        jiage = (teasession.getParameter("jiage"));
                    }
                    int picsize = 0;
                    if(teasession.getParameter("picsize") != null && teasession.getParameter("picsize").length() > 0)
                    {
                        picsize = Integer.parseInt(teasession.getParameter("picsize"));
                    }
                    BigDecimal picprice = new BigDecimal(jiage); //图片的价格

                    Bimage bg = Bimage.find(id);

                    bg.setRF(id,nodes,picsize,picprice,teasession._rv.toString(),teasession._strCommunity);

					String back=teasession.getParameter("back");
                    if(back.equals("1"))
                    {
						response.sendRedirect("/jsp/bpicture/index.jsp?nu=bpicture");
                    } else
                    {
						response.sendRedirect("/jsp/bpicture/buyer/ShoppingCart.jsp");
                    }
					return;

                } else if(typepic == 2)
                {
                    String image_use = ""; //图片用途
                    if(teasession.getParameter("image_use") != null && teasession.getParameter("image_use").length() > 0)
                    {
                        image_use = (teasession.getParameter("image_use"));
                    }
                    String image_details = ""; //详情使用
                    if(teasession.getParameter("image_details") != null && teasession.getParameter("image_details").length() > 0)
                    {
                        image_details = (teasession.getParameter("image_details"));
                    }
                    String image_print = ""; //印数
                    if(teasession.getParameter("image_print") != null && teasession.getParameter("image_print").length() > 0)
                    {
                        image_print = (teasession.getParameter("image_print"));
                    }
                    String product_industry = ""; //产品业
                    if(teasession.getParameter("image_size") != null && teasession.getParameter("image_size").length() > 0)
                    {
                        product_industry = (teasession.getParameter("image_size"));
                    }
                    String print_run = ""; //打印张数
                    String inserts = "";
                    String placement = ""; //应用的位置
                    Date starting_date = new Date(); //开始时间
                    String duration = ""; //有效期
                    String territory = ""; //领土
                    String country = ""; //国家
                    String industry_details = ""; //行业信息
                    String image_size = ""; //

                    BigDecimal picprice = new BigDecimal(0); //图片的价格
                    if(teasession.getParameter("pcprice") != null && teasession.getParameter("pcprice").length() > 0)
                    {
                        picprice = new BigDecimal(teasession.getParameter("pcprice"));
                    }

                    Bimage bg = Bimage.find(id);
                    bg.setfalg(id,nodes,teasession._rv.toString(),teasession._strCommunity,image_use,image_details,image_print,print_run,inserts,placement,starting_date,duration,territory,country,product_industry,industry_details,picprice,image_size);

					String back=teasession.getParameter("back");
					 if(back.equals("1"))
					 {
						 response.sendRedirect("/jsp/bpicture/index.jsp?nu=bpicture");
					 } else
					 {
						 response.sendRedirect("/jsp/bpicture/buyer/ShoppingCart.jsp");
					 }
					 return;

                }
            }

        } catch(SQLException ex)
        {
            System.out.println("错误信息：" + ex.getMessage());
        }
    }
}

