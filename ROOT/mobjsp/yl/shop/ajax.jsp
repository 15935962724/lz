<%@page import="org.json.JSONArray" %>
<%@page import="org.json.JSONObject" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.node.UserForm" %>
<%@ page import="tea.entity.site.Community" %>
<%@ page import="tea.entity.yl.shop.*" %>
<%@ page import="tea.entity.yl.shopnew.BackInvoice" %>
<%@ page import="tea.entity.yl.shopnew.HangWith" %>
<%@ page import="tea.entity.yl.shopnew.Invoice" %>
<%@ page import="util.Config" %>
<%@ page import="util.DateUtil" %>
<%@ page import="java.io.PrintStream" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="util.KdApiOrderDistinguish" %>
<%@ page import="java.security.Security" %>
<%@ page import="tea.entity.weixin.WxUser" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    Http h = new Http(request, response);
    System.out.println("进来了");
    String act = h.get("act");
    String str = h.get("str");
    JSONObject jo = new JSONObject();
    if ("selhost".equals(act)) {
        String member = h.get("member");
        Profile p1 = Profile.find(member);
        StringBuffer mystr = new StringBuffer("<select name='company'><option value=''>全部</option>");
        String[] myhos = MT.f(p1.hospitals, "|").split("[|]");
        for (int i = 1; i < myhos.length; i++) {
            ShopHospital sh = ShopHospital.find(Integer.parseInt(myhos[i]));
            mystr.append("<option " + (str.equals(sh.getName()) ? " selected" : "") + " value='" + sh.getName() + "'>" + sh.getName() + "</option>");
        }
        mystr.append("</select>");
        out.print(mystr.toString());
    } else if ("savedeductprice".equals(act)) {

        try {
            int backid = h.getInt("backid");
            float deductprice = h.getFloat("deductprice");
            BackInvoice back = BackInvoice.find(backid);
		/* back.setDeductprice(deductprice);
		back.set(); */


            HangWith hw = HangWith.find(0);
            hw.setTime(new Date());
            hw.setDeductprice(deductprice);
            hw.setBid(back.getId());

		/*int rid = 0;
		String[] replyidarr=back.getReplyid().split(",");
	    for(int i=0;i<replyidarr.length;i++){
	    	int re=Integer.parseInt(replyidarr[i]);
	    	ReplyMoney reply=ReplyMoney.find(re);
	    	if(reply.getType()==0){//回款
	    		rid = reply.getId();
	    		break;
	    	}
	    }*/
            int member = h.member;
            hw.setMember(member);
            hw.setReplyPrice(back.getHangamount());//记录原始挂款
            //hw.setRid(rid);
            hw.set();

            jo.put("type", "0");
        } catch (Exception e) {
            e.printStackTrace();
            jo.put("type", "1");
            jo.put("mes", "系统异常");
        }
        out.print(jo);
        return;

    } else if ("savedeductionRecordType".equals(act)) {

        try {
            int backid = h.getInt("backid");
            int deductionRecordType = h.getInt("deductionRecordType");
            BackInvoice back = BackInvoice.find(backid);

            back.setDeductionRecordType(deductionRecordType);
            back.set();
            jo.put("type", "0");
        } catch (Exception e) {
            e.printStackTrace();
            jo.put("type", "1");
            jo.put("mes", "系统异常");
        }
        out.print(jo);
        return;

    } else if ("ylloginmobile1".equals(act)) {
        //2017-06-05新加的登陆。由原来的yllogin复制而来。主要修改验证码部分，验证码是通过手机短信获取到的。
        String hname = h.get("hname", "");
        String member = h.get("username1");
        String password = h.get("password");
        String verify = h.get("verify");

        verify = verify.toUpperCase();

        String str1 = h.getCook("verify", null);
        //System.out.println(MT.dec(str1));
        Filex.logs("20190916.txt","==="+str1);
        str1 = MT.dec(str1);
        //String str=h.get("pincode");
        if ((str1 != null || verify != null) && (str1 == null || !str1.equals(verify))) {
            jo.put("type", "1");
            jo.put("mes", "验证码错误！");
            out.print(jo.toString());
            //out.print("<script>mt.show('抱歉，验证码错误！');</script>");
            return;
        }
        h.setCook("verify", null, 0);
        //
        int eflag = Profile.count(" AND  email = " + Database.cite(member) + " AND password = " + Database.cite(password) + " AND deleted = 0");
        int mflag = Profile.count(" AND  mobile = " + Database.cite(member) + " AND password = " + Database.cite(password) + " AND deleted = 0");
        int uflag = Profile.count(" AND  member = " + Database.cite(member) + " AND password = " + Database.cite(password) + " AND deleted = 0");

        if (eflag == 0 && mflag == 0 && uflag == 0) {
            jo.put("type", "1");
            jo.put("mes", "用户名或密码错误！");
            out.print(jo.toString());
            //out.print("<script>mt.show('用户名或密码错误！');</script>");
            return;
        }
        Profile p = Profile.find(0);
        if (eflag > 0) {
            ArrayList al = Profile.find1(" AND email=" + Database.cite(member) + " AND deleted = 0", 0, 1);
            p = al.size() < 1 ? Profile.find(0) : (Profile) al.get(0);
        } else if (mflag > 0) {
            ArrayList al = Profile.find1(" AND mobile=" + Database.cite(member) + " AND deleted = 0", 0, 1);
            p = al.size() < 1 ? Profile.find(0) : (Profile) al.get(0);
        } else if (uflag > 0) {
            List al = new ArrayList();
            if (hname.length() > 0) {
                al = Profile.find1(" AND member=" + Database.cite(member) + " and hospital in (select id from shophospital where name like " + Database.cite("%" + hname + "%") + ")" + " AND deleted = 0", 0, 1);

            } else {
                al = Profile.find1(" AND member=" + Database.cite(member) + " AND deleted = 0", 0, 1);

            }

            p = al.size() < 1 ? Profile.find(0) : (Profile) al.get(0);
        }
        if (p.emailflag == 1) {
            String url = "/Members.do?act=resemail&member=" + p.member;
            //out.print("<script>mt.show(\"" + Res.get(h.language,"您不能登录！您还没有验证电子邮箱！<br/><br/>没有收到邮件？{0}重发邮件</a>","<a href=" + url + " target=_ajax>") + "\");</script>");
            jo.put("type", "3");
            jo.put("mes", "您不能登录！您还没有验证电子邮箱！");
            out.print(jo.toString());
            //out.print("<script>mt.show('用户名或密码错误！');</script>");
            return;
        }
        if (p.deleted) {
            //out.print("<script>mt.show('用户已被删除！');</script>");
            jo.put("type", "1");
            jo.put("mes", "用户已被删除！");
            out.print(jo.toString());
            return;
        }

        if (p.isLocking()) {
            jo.put("type", "1");
            jo.put("mes", "该用户已被锁定，暂时无法登录！");
            out.print(jo.toString());
            //out.print("<script>alert('该用户已被锁定，暂时无法登录！');</script>");
            return;
        }
        Filex.logs("yt_qianshou2.txt", "login:openid===" + p.openid);
        int webtype = h.getInt("webtype");//1电脑

        if(webtype==0){
            if (MT.f(p.openid).length() > 0) {
                String openid = h.getCook("openid", "");
                h.setCook("openid", p.openid, -1);
                Filex.logs("yt_qianshou2.txt", "login:openid2==="+openid);
                if(!"".equals(openid)){
                    //out.print("<script>alert('该用户已被绑定，暂时无法登录！');</script>");
                    jo.put("type", "1");
                    jo.put("mes", "该用户已被绑定，暂时无法登录！");
                    out.print(jo.toString());
                    //out.print("<script>alert('该用户已被锁定，暂时无法登录！');</script>");
                    return;
                }
            } else {
                //设置openid
                String openid = h.getCook("openid", "");
                Filex.logs("yt_qianshou2.txt", "login:openid3===" + openid);
                if (!"".equals(openid) && null != openid) {
                    boolean flag = Profile.flagopenid(openid);
                    if (!flag) {
                        p.set("openid", openid);
                    }
                }
            }
        }





        String auto = h.get("autologin", "");
        if (auto.length() > 0) {
            h.setCook("autologin", MT.enc(p.getLogint() + "|" + member + "|" + p.getPassword()), 7 * 60 * 24);
        }
        RV rv = new RV(member);
        Logs.create("Home", rv, 1, h.node, request.getRemoteAddr());
        //OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
        p.setLogin(request.getRemoteAddr(), request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"), new Date());
        Community c = Community.find(h.community);
        h.member = p.getProfile();
        session.setAttribute("member", h.member);
        if (c.isSession()) {
            //session.setAttribute("tea.RV",rv);
        } else {
            //h.setCook("member",MT.enc(p.getLogint() + "|" + h.member + "|" + p.getPassword()),h.getInt("expiry", -1));
            h.setCook("member", MT.enc(p.getLogint() + "|" + h.member + "|" + p.getPassword()), h.getInt("expiry", -1));
            Filex.logs("yt_nologin.txt", "members:" + p.getLogint() + "|" + h.member + "|" + p.getPassword() + "====" + h.getInt("expiry", -1));

        }
        Filex.logs("yt_qianshou2.txt", "login:nexturl===");
        jo.put("type", "0");
        out.print(jo.toString());
        //out.print("<script>top.location.replace('" + nexturl + "');</script>");//parent
        return;
    } else if ("checkInvoice".equals(act)) {//验证选择发票

        //int hospital = h.getInt("hospital");
        String hospital = h.get("hospital");
        ShopHospital sh = ShopHospital.find(hospital);
        String ids = h.get("ids");
        String idarr[] = ids.split(",");
        String nums = h.get("nums");
        String[] numarr = nums.split(",");
        Map map = new HashMap();
        for (int i = 0; i < numarr.length; i++) {
            map.put(idarr[i], numarr[i]);
        }

        float sum = 0;
        int fuflag = 0;
        int puid = 0;
        for (int i = 0; i < idarr.length; i++) {
            ShopOrder so = ShopOrder.find(Integer.parseInt(idarr[i]));
            if (i == 0) {
                puid = so.getPuid();
            }
            if (so.getAmount() < 0) {
                fuflag = 1;//有负的
            }
            int shpuid = ShopOrderData.findPuid(so.getOrderId());
            if (shpuid == Config.getInt("xinke")) {//等于欣科不用查询
                fuflag = 1;//有负的
            }
            sum += so.getAmount();

        }
        jo.put("type", "0");
        if (fuflag != 1) {//没选负的
            String sql = " AND member="+h.member+" AND puid = " + puid + " AND amount < 0 AND applyUnit = 0 AND status !=5 and order_id in(select order_id from shoporderdispatch where a_hospital_id = " + sh.getId() + ") AND (isclear=0 or isclear is null) AND noinvoicenum <> 0 ";
            List<ShopOrder> slist = ShopOrder.find(sql.toString() + " order by amount desc  ", 0, Integer.MAX_VALUE);


            if (slist.size() > 0) {

                ShopOrder so1 = slist.get(0);

                if (sum > so1.getAmount()) {
                    jo.put("type", "2");
                    jo.put("mes", "请选择负数订单申请发票！");
                } else {//最小欠款都不大于

                }
            }
        }

        out.print(jo);
    } else if ("saveadjustmentService".equals(act)) {
        int iid = h.getInt("iid");
        float adjustmentService = h.getFloat("adjustmentService");
        Invoice ie = Invoice.find(iid);
        ie.setAdjustmentService(adjustmentService);
        ie.set();
        jo.put("type", "0");
        out.print(jo);
    } else if ("getyzmlog".equals(act)) {
        //发送手机验证码
        StringBuffer sp = new StringBuffer();
        String mymob = h.get("mob");
        Filex.logs("yanzhengma.txt","发送验证码手机号，getyzmlog，mobile==="+mymob);
        int count = Profile.count(" AND deleted = 0 AND mobile = " + Database.cite(mymob));
        if (count == 0) {
            jo.put("type", "2");
            jo.put("mes", "手机号不存在！");
            out.print(jo);
            Filex.logs("yanzhengma.txt","手机号不存在==="+mymob);
            return;//手机号查询无用户返回
        }
        //发送手机验证码
        int b = (int) (Math.random() * 1000000);

        session.setAttribute(mymob + "_code", String.valueOf(b));

        String c = "您好，你正在使用验证码登陆，请在页面输入验证码为“" + b
                + "”";
        System.out.println(b);
        String rs = SMSMessage.create("Home", "webmaster", mymob,
                h.language, c);
        ArrayList arrayList = Profile.find1(" and mobile=" + Database.cite(mymob) + " AND deleted = 0 ", 0, Integer.MAX_VALUE);
        Profile profile = (Profile)arrayList.get(0);
        List<SecurityCode> securityCodes = SecurityCode.find(" AND pid=" + profile.profile, 0, 1);
        if(securityCodes.size()==0){
            Filex.logs("yanzhengma.txt","增加SecurityCode=="+b);
            SecurityCode so = SecurityCode.find(0);
            so.setPid(profile.profile);
            so.setCode(b);
            so.set();
        }else {
            Filex.logs("yanzhengma.txt","改变SecurityCode=="+b);
            SecurityCode so = securityCodes.get(0);
            so.setCode(b);
            so.set();
        }

           			/*int[] rs = SMessage.send(1, h.member, h.get("members", "|"), mob, 0, c, out);
           			Writer out1 = request.*/
                      /*if (rs == null)
                      	sp.append("t");*/
                      /*else
                      	sp.append("f");*/
        Filex.logs("yanzhengma.txt","已发送===session="+mymob+"_code,"+c);
        String str1 ="0";
        out.print(str1);
        /* Filex.logs("yanzhengma.txt",8"jo======"+jo.toString());*/
        return;
    } else if ("ylloginmobile2".equals(act)) {
        //2017-06-05新加的登陆。由原来的yllogin复制而来。主要修改验证码部分，验证码是通过手机短信获取到的。
        String mob = h.get("mob");

        String verid = MT.f(h.get("verid"), "");
        if(verid.equals("")){
            jo.put("type", "1");
            jo.put("mes", "请填写写验证码！");
            out.print(jo.toString());
            //out.print("<script>mt.show('手机验证码错误！');</script>");
            return;
        }
        String code = String.valueOf(session.getAttribute(mob
                + "_code"));
        Filex.logs("login_wx.txt","获取到的===——session名称"+mob+"_code");
        Filex.logs("login_wx.txt","点击登录：session的值1"+session.getAttribute(mob + "_code"));
        Filex.logs("login_wx.txt","点击登录：session的值2"+String.valueOf(session.getAttribute(mob + "_code")));
        /*if (!verid.equals(code)) {
            Filex.logs("login_wx.txt","点击登录：验证码错误，存："+code+",输入值："+verid);
            jo.put("type", "1");
            jo.put("mes", "手机验证码错误！");
            out.print(jo.toString());
            //out.print("<script>mt.show('手机验证码错误！');</script>");
            return;
        }*/
        /*ArrayList arrayList2 = SMSMessage.find(" AND mobile=" + Database.cite(mob) + " order by time desc ", 0, 20);
        for (int i = 0; i < arrayList2.size(); i++) {
            SMSMessage o = (SMSMessage)arrayList2.get(i);
            String content = o.getContent();
            if(content.contains("验证码")){//最新验证码
                if(!content.contains(verid)){//不包含这段验证码
                    Filex.logs("login_wx.txt","点击登录：验证码有误："+verid+"----"+content);
                    System.out.println("点击登录：验证码有误："+verid+"----"+content);
                    jo.put("type", "1");
                    jo.put("mes", "手机验证码错误！");
                    out.print(jo.toString());
                    //out.print("<script>mt.show('手机验证码错误！');</script>");
                    return;
                }else {
                    break;
                }
            }
        }*/
        int profile = Profile.findMob(mob);
        Profile p = Profile.find(profile);
        String member = p.getMember();
        ArrayList arrayList = Profile.find1(" AND mobile=" + Database.cite(mob) + " AND deleted=0 ", 0, 1);
        if(arrayList.size()>0){
            p = (Profile)arrayList.get(0);
            member = p.getMember();
            profile = p.profile;
        }else {
            jo.put("type", "1");
            jo.put("mes", "账户异常联系管理员处理！");
            out.print(jo.toString());
            return;
        }

        List<SecurityCode> securityCodes = SecurityCode.find(" AND pid=" + profile, 0, 1);
        if(securityCodes.size()==0){
            Filex.logs("denglu.txt","securityCodes没有验证码：profile="+profile);
            jo.put("type", "1");
            jo.put("mes", "系统故障联系管理员处理！");
            out.print(jo.toString());
            //out.print("<script>mt.show('手机验证码错误！');</script>");
            return;
        }
        String code1 = securityCodes.get(0).getCode()+"";
        if (!verid.equals(code1)) {
            Filex.logs("login_wx.txt","点击登录：验证码有误："+verid+"----"+code1);
            jo.put("type", "1");
            jo.put("mes", "手机验证码错误！");
            out.print(jo.toString());
            //out.print("<script>mt.show('手机验证码错误！');</script>");
            return;
        }


	/*if(p.emailflag==1){
		String url = "/Members.do?act=resemail&member="+p.member;
		//out.print("<script>mt.show(\"" + Res.get(h.language,"您不能登录！您还没有验证电子邮箱！<br/><br/>没有收到邮件？{0}重发邮件</a>","<a href=" + url + " target=_ajax>") + "\");</script>");
		jo.put("type", "3");
		jo.put("mes", "您不能登录！您还没有验证电子邮箱！");
		out.print(jo.toString());
		//out.print("<script>mt.show('用户名或密码错误！');</script>");
		return;
	}*/
        if (p.deleted) {
            //out.print("<script>mt.show('用户已被删除！');</script>");
            jo.put("type", "1");
            jo.put("mes", "用户已被删除！");
            out.print(jo.toString());
            return;
        }

        if (p.isLocking()) {
            jo.put("type", "1");
            jo.put("mes", "该用户已被锁定，暂时无法登录！");
            out.print(jo.toString());
            //out.print("<script>alert('该用户已被锁定，暂时无法登录！');</script>");
            return;
        }
        Filex.logs("yt_qianshou2.txt", "login:openid===" + p.openid);
        int webtype = h.getInt("webtype");//1电脑

        if(webtype==0){

            if (MT.f(p.openid).length() > 0) {
                String openid = h.getCook("openid", "");
                //h.setCook("openid", p.openid, -1);
                Filex.logs("yt_qianshou2.txt", "login:openid2==="+openid);
                //if(!"".equals(openid)){
                //out.print("<script>alert('该用户已被绑定，暂时无法登录！');</script>");
                jo.put("type", "1");
                jo.put("mes", "该用户已被绑定，暂时无法登录！");
                out.print(jo.toString());
                //out.print("<script>alert('该用户已被锁定，暂时无法登录！');</script>");
                return;
                // }
            } else {
                //设置openid
                String openid = h.getCook("openid", "");
                Filex.logs("yt_qianshou2.txt", "login:openid3===" + openid);
                if (!"".equals(openid) && null != openid) {
                    boolean flag = Profile.flagopenid(openid);
                    if (!flag) {
                        p.set("openid", openid);
                    }
                }
                String nickname = h.getCook("nickname", "");
                Filex.logs("weixinname.txt","profile="+p.profile+",name="+nickname);
                SecurityCode securityCode = securityCodes.get(0);
                securityCode.setNicheng(nickname);
                securityCode.set();

            }

        }

        String auto = h.get("autologin", "");
        if (auto.length() > 0) {
            h.setCook("autologin", MT.enc(p.getLogint() + "|" + member + "|" + p.getPassword()), 7 * 60 * 24);
        }
        RV rv = new RV(member);
        Logs.create("Home", rv, 1, h.node, request.getRemoteAddr());
        //OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
        p.setLogin(request.getRemoteAddr(), request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"), new Date());
        Community c = Community.find(h.community);
        h.member = p.getProfile();
        session.setAttribute("member", h.member);
        if (c.isSession()) {
            //session.setAttribute("tea.RV",rv);
        } else {
            //h.setCook("member",MT.enc(p.getLogint() + "|" + h.member + "|" + p.getPassword()),h.getInt("expiry", -1));
            h.setCook("member", MT.enc(p.getLogint() + "|" + h.member + "|" + p.getPassword()), h.getInt("expiry", -1));
            Filex.logs("yt_nologin.txt", "members:" + p.getLogint() + "|" + h.member + "|" + p.getPassword() + "====" + h.getInt("expiry", -1));

        }
        Filex.logs("yt_qianshou2.txt", "login:nexturl===");
        jo.put("type", "0");
        out.print(jo.toString());
        //out.print("<script>top.location.replace('" + nexturl + "');</script>");//parent
        return;
    } else if ("editShopOrderDatasBatches".equals(act)) {

        try {
            String ordercode = h.get("ordercode");
            String[] sids = h.getValues("sid");
            String[] batchnumbers = h.getValues("batchnumber");
            String[] activitys = h.getValues("activity");
            String[] numbers = h.getValues("number");
            String[] soids = h.getValues("soid");

            for (int i = 0; i < sids.length; i++) {
                int sid = Integer.parseInt(sids[i]);
                ShopOrderDatasBatches sod = ShopOrderDatasBatches.find(sid);
                sod.setOrdercode(ordercode);
                sod.batchnumber = batchnumbers[i];
                sod.activity = Float.parseFloat(activitys[i]);
                sod.number = Integer.parseInt(numbers[i]);
                sod.soid = soids[i];
                sod.set();
                //System.out.println(sid);
            }

            jo.put("type", "0");
        } catch (Exception e) {
            e.printStackTrace();
            jo.put("type", "1");
            jo.put("mes", "系统异常");
        }
        out.print(jo);
        return;

    } else if ("editShopOrderDatasBatchesph".equals(act)) {

        try {
            String ordercode = h.get("ordercode");
            String[] sids = h.getValues("sid");
            String[] batchnumbers = h.getValues("batchnumber");

            for (int i = 0; i < sids.length; i++) {
                int sid = Integer.parseInt(sids[i]);
                if(sid==0){
                    continue;
                }
                ShopOrderDatasBatches sod = ShopOrderDatasBatches.find(sid);
                sod.setOrdercode(ordercode);
                sod.batchnumber = batchnumbers[i];
                sod.set();
                //System.out.println(sid);
            }

            jo.put("type", "0");
        } catch (Exception e) {
            e.printStackTrace();
            jo.put("type", "1");
            jo.put("mes", "系统异常");
        }
        out.print(jo);
        return;

    } else if ("initbat".equals(act)) {
        JSONArray ja = new JSONArray();
        try {


            int num = h.getInt("num");
            String myyear = DateUtil.getSysYear();
            JaYearConfig jyc = JaYearConfig.findYear(myyear);
            String myyearstr = myyear.substring(2, 4);
            int jnnum = jyc.num;

            for (int i = 0; i < num; i++) {
                jnnum++;
                JSONObject jo1 = new JSONObject();
                String strcode = new DecimalFormat("0000").format(jnnum);
                jo1.put("num", i + 1);
                jo1.put("code", "JA-" + myyearstr + strcode);
                ja.put(jo1);
            }

        } catch (Exception e) {
            e.printStackTrace();
            jo.put("type", "1");
            jo.put("mes", "系统异常");
            out.print(jo);
            return;
        }
        out.print(ja);
        return;

    } else if ("editShopOrderDatasBatche".equals(act)) {

        try {
            String batchnumber = h.get("batchnumber");
            String soid = h.get("soid");
            int number = h.getInt("number");
            int sid = h.getInt("sid");
            float activity = h.getFloat("activity");
            String ordercode = h.get("ordercode");

            if(number==0){
                jo.put("type", "2");
                jo.put("mes", "请输入分批数量！");
                out.print(jo);
                return;
            }

            ShopOrderDatasBatches sod = ShopOrderDatasBatches.find(sid);
            sod.setOrdercode(ordercode);
            sod.batchnumber = batchnumber;
            sod.activity = activity;
            sod.number = number;
            sod.soid = soid;
            sod.ordercode = ordercode;
            if (sod.getId() == 0) {
                sod.time = new Date();

                int count = ShopBatchesData.count(" AND sbd.orderId =" + Database.cite(ordercode)+" AND (number-occupyNumber)<> 0 ");
                if (count > 0) {
                    jo = findBatchesYuLiu(h, jo);
                    if (jo.getInt("type") == 2) {//不足
                        jo.put("type", "2");
                        out.print(jo);
                        return;
                    }
                } else {
                    jo = findBatches(h, jo);
                    if (jo.getInt("type") == 2) {//不足
                        jo.put("type", "2");
                        jo.put("mes", "此活度此校准时间库存不足，请调配！");
                        out.print(jo);
                        return;
                    }
                }


                sod.setSoid(jo.getString("soid"));
            }
            sod.set();

            jo.put("type", "0");

            jo.put("obj", com.alibaba.fastjson.JSONObject.toJSON(sod));
        } catch (Exception e) {
            e.printStackTrace();
            jo.put("type", "3");
            jo.put("mes", "系统异常");
        }
        out.print(jo);
        return;
    } else if ("delShopOrderDatasBatche".equals(act)) {
        int sid = h.getInt("sid");
        ShopOrderDatasBatches sod = ShopOrderDatasBatches.find(sid);
        int flag = StockOperation.setStillBat(sod.getSoid());
        if (flag == 1) {
            jo.put("type", "2");
            out.print(jo);
            return;
        }
        sod.delete();
        jo.put("type", "0");
        out.print(jo);
        return;
    } else if ("editJihuoCode".equals(act)) {
        try {
            String[] codes = h.getValues("code");
            /* String[] mails = h.getValues("mail");*/
            String[] types = h.getValues("type");
            String[] type_child = h.getValues("type_child");
            for (int i = 0; i < codes.length; i++) {
                JihuoCode jihuo = JihuoCode.find(0);
                jihuo.setCode(codes[i]);
                List<JihuoCode> list = JihuoCode.find("AND code=" + DbAdapter.cite(codes[i]), 0, Integer.MAX_VALUE);
                if (list.size() == 0) {
                    /*jihuo.setMail(mails[i]);*/
                    jihuo.setType(Integer.valueOf(types[i]));
                    jihuo.setType_child(Integer.valueOf(type_child[i]));
                    jihuo.setUsetype(0);
                    jihuo.setMember(h.member);
                    jihuo.set();
                }
            }
            jo.put("type", "0");
            out.print(jo);
            return;

        } catch (Throwable e) {
            jo.put("type", "1");
            out.print(jo);
            return;
        }
    } else if ("editShopHospital".equals(act)) {
        try {

            String[] names = h.getValues("name");
            String[] h_codes = h.getValues("h_code");
            String[] htypes = h.getValues("htype");
            String[] hgraders = h.getValues("hgrader");
            String[] areas = h.getValues("area");

            for (int i = 0; i < names.length; i++) {
                ShopHospital sh = ShopHospital.find(names[i]);
                sh.setName(names[i]);
                sh.setH_code(h_codes[i]);
                sh.setHtype(htypes[i]);
                sh.setHgrader(hgraders[i]);
                sh.setArea_name(areas[i]);
                sh.setArea(ShopHospital.shmap.get(areas[i]));
                sh.set();

            }
            jo.put("type", "0");
            out.print(jo);
            return;

        } catch (Throwable e) {
            jo.put("type", "1");
            out.print(jo);
            return;
        }
    } else if ("saveTime".equals(act)) {
        String mes = h.get("mes");
        int tid = h.getInt("tid");
        Date calibrationDate = h.getDate("calibrationDate");
        double activity = h.getDouble("activity");
        ShopOrderData sod = ShopOrderData.find(tid);
        ShopOrder so = ShopOrder.findByOrderId(sod.getOrderId());
        Profile p1 = Profile.find(so.getMember());
        int issalesman = p1.issalesman;
        int type = 0;


        double perce = p1.membertype == 2 ? 0.03 : 0.01;

        int count = ProductStock.findStock(activity, perce, issalesman, calibrationDate, 1);
        if (sod.getQuantity() > count) {//库存不足
            type = 2;//
            jo.put("type", type);
            jo.put("mes", "系统异常，请重试！");
            out.print(jo);
            return;
        }
        jo.put("type", type);
        out.print(jo);
        return;

    } else if ("updateAllocate".equals(act)) {
        int type = 0;
        try {
            int typemy = h.getInt("type");//0
            int tid = h.getInt("tid");
            Date calibrationDate = h.getDate("calibrationDate");
            ShopOrderData sod = ShopOrderData.find(tid);
            ShopOrder so = ShopOrder.findByOrderId(sod.getOrderId());

            if (calibrationDate.equals(sod.getCalibrationDate())) {
                type = 2;//
                jo.put("type", type);
                jo.put("mes", "修改后的发货时间不能相同！");
                out.print(jo);
                return;
            }



            sod.setCalibrationDate(calibrationDate);
            sod.set();

            List<ShopOrderDatasBatches> sblist = ShopOrderDatasBatches.find(" AND ordercode=" + DbAdapter.cite(sod.getOrderId()), 0, Integer.MAX_VALUE);
            StockOperation.setStill(so.getId());//清楚占用库存
            for (int i = 0; i < sblist.size(); i++) {
                ShopOrderDatasBatches sod1 = sblist.get(i);
                ShopOrder so1 = ShopOrder.findByOrderId(sod.getOrderId());
                StockOperation.setStillBat(sod1.getSoid());//清楚占用库存
                sod1.delete();
            }

            List<ShopBatchesData> sbdlist = ShopBatchesData.find(" AND sbd.orderId = " + Database.cite(sod.getOrderId()) + " AND (number-occupyNumber)<> 0 AND ps.psid <> 0 ", 0, Integer.MAX_VALUE);
            for (int i = 0; i < sbdlist.size(); i++) {
                ShopBatchesData sbd = sbdlist.get(i);
                sbd.setOccupyNumber(sbd.number);
                sbd.set();//把之前预留记录补全
            }


            if (typemy == 1) {
                so.setAllocate(1);
                so.set();
            }else{
                so.setAllocate(0);
                so.set();
                Profile p1 = Profile.find(so.getMember());
                int issalesman = p1.issalesman;
                double perce = p1.membertype == 2 ? 0.03 : 0.01;

                int count = ProductStock.findStock(sod.getActivity(), perce, issalesman, calibrationDate, 0);
                if (sod.getQuantity() > count) {//库存不足
                    type = 2;//
                    jo.put("type", type);
                    jo.put("mes","库存不足！");
                    out.print(jo);
                    return;
                }


                StockOperation.setOrder(sod.getActivity(), sod.getQuantity(), perce, issalesman, so.getMember(), so.getId(),calibrationDate );

            }

        } catch (Throwable e) {
            e.printStackTrace();
            type = 2;//
            jo.put("mes","系统异常！");
        }

        jo.put("type", type);
        out.print(jo);
        return;
    } else if ("addCompany".equals(act)) {
        int type = 0;
        int member = h.getInt("member");
        int puid = h.getInt("puid");
        ProcurementUnitJoin puj = ProcurementUnitJoin.find(0);
        puj.profile = member;
        puj.puid = puid;
        puj.set();
        jo.put("type", type);
        out.print(jo);
        return;
    } else if ("delCompany".equals(act)) {
        int type = 0;
        int pid = h.getInt("pid");

        List<ShopHospital> shlist = ShopHospital.find(" AND pid = " + pid, 0, Integer.MAX_VALUE);
        for (int i = 0; i < shlist.size(); i++) {
            ShopHospital sh = shlist.get(i);
            sh.setPid(0);
            sh.set();
        }

        ProcurementUnitJoin puj = ProcurementUnitJoin.find(pid);
        puj.delete();


        jo.put("type", type);
        out.print(jo);
        return;
    } else if ("editShopHospitalProfile".equals(act)) {
        int type = 0;
        int pid = h.getInt("pid");
        ProcurementUnitJoin pu = ProcurementUnitJoin.find(pid);
        String oldhos = MT.f(pu.hoid);
        String newhos = "";
        String[] ids = h.getValues("dids");
        if (ids != null) {
            for (int i = 0; i < ids.length; i++) {
                ShopHospital sh = ShopHospital.find(Integer.parseInt(ids[i]));
                oldhos = oldhos.replace("," + ids[i], "");//选中了过滤
                sh.setPid(pid);
                newhos += "," + ids[i];
                sh.set();
            }

        }

        //清空
        List<ShopHospital> shlist = ShopHospital.find(" AND id in (0" + MT.f(oldhos, "0") + ")", 0, Integer.MAX_VALUE);
        for (int j = 0; j < shlist.size(); j++) {
            ShopHospital sh = shlist.get(j);
            sh.setPid(0);
            sh.set();
        }
        pu.hoid = newhos;
        pu.set();

        jo.put("type", type);
        out.print(jo);
        return;
    } else if ("findmodel".equals(act)) {
        int category = h.getInt("category");
        int product = h.getInt("product");
        ShopProduct sp = ShopProduct.find(product);
        JSONArray ja = new JSONArray();
        List<ShopProductModel> spmlist = ShopProductModel.find(" AND category = " + category, 0, 20);
        for (int j = 0; j < spmlist.size(); j++) {
            ShopProductModel spm = spmlist.get(j);
            ShopProduct sp1 = ShopProduct.find(sp.brand, spm.getId());
            System.out.println(sp1.toString());
            JSONObject jo1 = new JSONObject();
            jo1.put("modelid", spm.getId());
            jo1.put("model", spm.getModel());
            jo1.put("product", sp1.product);
            ja.put(jo1);
            //ja.put(com.alibaba.fastjson.JSONObject.toJSON(sp1));
            //out.print("<i onclick=parent.location='/html/folder/19081600-1.htm?product="+sp1.product+"' "+((spm.getId()==sp.model_id?"class='bgred'":""))+"><a >"+spm.getModel()+"</a></i>");
        }
        jo.put("type", "0");
        jo.put("ja", ja);
        out.print(jo);
        //System.out.println(ja.toString());
    } else if ("orderjiesuan".equals(act)) {
        try {
            String name = h.get("name");
            String mobile = h.get("mobile");
            String youbian = h.get("youbian");
            int city = h.getInt("city1");
            String address = h.get("address");
            int ismoren = h.getInt("ismoren");
            String mail = h.get("mail");
            Consignee consignee = Consignee.find(h.getInt("id"));
            if (ismoren == 0) {
                consignee.setIsmoren(ismoren);
            } else {
                List<Consignee> list = Consignee.find("AND member=" + h.member + "AND ismoren=" + 1, 0, Integer.MAX_VALUE);
                if (list.size() == 0) {
                    consignee.setIsmoren(ismoren);
                } else {
                    for (Consignee c : list) {
                        c.setIsmoren(0);
                        c.set();
                    }
                    consignee.setIsmoren(ismoren);
                }
            }
            consignee.setMember(h.member);
            consignee.setMobile(mobile);
            consignee.setName(name);
            consignee.setCity(city);
            consignee.setAddress(address);
            consignee.setYoubian(youbian);
            consignee.setMail(mail);
            consignee.set();
            List<Consignee> list = Consignee.find("AND member=" + h.member + " order by id desc", 0, Integer.MAX_VALUE);
            Consignee c = list.get(0);
            int insert_id = c.getId();
            jo.put("name", name);
            jo.put("mobile", mobile);
            jo.put("address", address);
            jo.put("mail", mail);
            if (0 != h.getInt("id")) {//是修改
                jo.put("isxiugai", "1");
                jo.put("id", String.valueOf(h.get("id")));
            } else {
                if (list.size() == 1) {//只有一条记录
                    jo.put("number1", "1");
                } else {
                    jo.put("number1", "0");
                }
                jo.put("isxiugai", "0");
                jo.put("id", String.valueOf(insert_id));
            }

            if (ismoren == 1) {
                jo.put("ismoren", "默认");
            } else {
                jo.put("ismoren", "");
            }
            String a = city + "";
            String b = a.substring(0, 2);
            jo.put("pro", b);
            jo.put("src", a);
            out.print(jo);
            return;
        } catch (Throwable e) {
            jo.put("type", "1");
            out.print(jo);
            return;
        }

    } else if ("type_child".equals(act)) {
        String id = "";
        String name = "";
        String arr[] = {};
        try {
            int category_id = h.getInt("id");
            List<ShopProductModel> list = ShopProductModel.find("AND category=" + category_id, 0, Integer.MAX_VALUE);
            if (list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    ShopProductModel sh = list.get(i);
                    id += sh.getId();
                    name += sh.getModel();
                    if (i == list.size() - 1) {
                        continue;
                    } else {
                        id += ",";
                        name += ",";
                    }

                }
            }
            jo.put("id", id);
            jo.put("name", name);
            out.print(jo);
            return;
        } catch (Throwable e) {
            jo.put("type", "1");
            out.print(jo);
            return;
        }
    } else if ("bianji_address".equals(act)) {//编辑手机版收货地址
        try {
            int address_id = h.getInt("id");
            Consignee c = Consignee.find(address_id);
            jo.put("id", address_id);
            jo.put("name", c.getName());
            jo.put("address", c.getAddress());
            jo.put("city", c.getCity());
            jo.put("ismoren", c.getIsmoren());
            jo.put("mobile", c.getMobile());
            jo.put("mail", c.getMail());
            jo.put("youbian", c.getYoubian());

            out.print(jo);
            return;
        } catch (Throwable e) {
            jo.put("type", "1");
            out.print(jo);
            return;

        }
    } else if ("xuanzhong_address".equals(act)) {//改变别的收货地址
        try {
            int address_id = h.getInt("id");
            Consignee c = Consignee.find(address_id);
            List<Consignee> list = Consignee.find("AND member=" + h.member, 0, Integer.MAX_VALUE);
            for (Consignee consignee : list) {
                consignee.setXuanzhong(0);
                consignee.set();
            }
            c.setXuanzhong(1);
            c.set();
            jo.put("id", address_id);
            jo.put("name", c.getName());
            jo.put("address", c.getAddress());
            jo.put("city", c.getCity());
            jo.put("ismoren", c.getIsmoren());
            jo.put("mobile", c.getMobile());
            jo.put("mail", c.getMail());
            jo.put("youbian", c.getYoubian());
            String a = c.getCity()+ "";
            String b = a.substring(0, 2);
            jo.put("pro", b);
            jo.put("src", a);

            out.print(jo);
            return;
        } catch (Throwable e) {
            jo.put("type", "1");
            out.print(jo);
            return;

        }
    }else if ("update_address".equals(act)) {//保存手机版收货地址
        try {
            int address_id = h.getInt("id");
            Consignee c = Consignee.find(address_id);
            List<Consignee> list = Consignee.find("AND member=" + h.member, 0, Integer.MAX_VALUE);
            for (Consignee consignee : list) {
                consignee.setXuanzhong(0);
                consignee.set();
            }
            String mobile = h.get("mobile");
            String address = h.get("address");
            String youbian = h.get("youbian");
            int city = h.getInt("city1");
            String name = h.get("name");
            String mail = h.get("mail");
            c.setMobile(mobile);
            c.setAddress(address);
            c.setYoubian(youbian);
            c.setCity(city);
            c.setName(name);
            c.setMail(mail);
            c.setXuanzhong(1);
            c.setMember(h.member);
            c.set();
            if (address_id == 0) {//新增
                List<Consignee> list1 = Consignee.find("AND member=" + h.member + "order by id desc", 0, Integer.MAX_VALUE);
                int id = list1.get(0).getId();
                jo.put("id", id);
            } else {//修改
                jo.put("id", address_id);
            }

            jo.put("name", c.getName());
            jo.put("address", c.getAddress());
            jo.put("city", c.getCity());
            jo.put("ismoren", c.getIsmoren());
            jo.put("mobile", c.getMobile());
            jo.put("mail", c.getMail());
            jo.put("youbian", c.getYoubian());
            String a = city + "";
            String b = a.substring(0, 2);
            jo.put("pro", b);
            jo.put("src", a);

            out.print(jo);
            return;
        } catch (Throwable e) {
            jo.put("type", "1");
            out.print(jo);
            return;

        }
    } else if ("xg_shr".equals(act)) {//改变收货人页面展示
        try {
            int member = h.member;
            List<Consignee> list = Consignee.find("AND member=" + member+"order by xuanzhong desc", 0, Integer.MAX_VALUE);
            String name = "";
            String mobile = "";
            String a = "";
            String b = "";
            String address = "";
            String id = "";
            String iszhuanzhong="";

            String moren = "";
            for (int i = 0; i < list.size(); i++) {
                Consignee c = list.get(i);
                name += c.getName();

                iszhuanzhong+=c.getXuanzhong();



                String city = String.valueOf(c.getCity());
                a += city;

                b += city.substring(0, 2);

                mobile += c.getMobile();

                address += c.getAddress();

                id += c.getId();

                moren+= c.getIsmoren();

                if (i != list.size()-1) {
                    name += ",";
                    a += ",";
                    b += ",";
                    mobile += ",";
                    address += ",";
                    id += ",";
                    iszhuanzhong+=",";
                    moren+=",";
                }

            }

            jo.put("pro", b);
            jo.put("src", a);
            jo.put("name", name);
            jo.put("mobile", mobile);
            jo.put("address", address);
            jo.put("id", id);
            jo.put("isxuanzhong",iszhuanzhong);
            jo.put("moren",moren);



            out.print(jo);
            return;
        } catch (Throwable e) {
            jo.put("type", "1");
            out.print(jo);
            return;
        }


    }else if("findcountCarts".equals(act)){//购物车商品数量
        Filex.logs("findcountCarts.txt","进购物车数量");
        String[] ps=h.getCook("cart","|").split("[|]");

        List<String> tpslist = new ArrayList<String>();

        List<String> sblist = new ArrayList<String>();


        int count = 0;

        for (int i = 1; i < ps.length; i++) {
            String[] arr=ps[i].split("&");
            int quantity = Integer.parseInt(arr[1]);
            //判断product_id是否商品的id，如果不是则为套装id
            int product_id=Integer.parseInt(arr[0]);
            ShopProduct sp1 = ShopProduct.find(product_id);
            ShopCategory sc1 = ShopCategory.find(sp1.category);

            if(sc1.path.indexOf(Config.getString("tps"))!=-1){//tps
                //tpslist.add(ps[i]);
                count++;
            }else{
                //sblist.add(ps[i]);
                count+=quantity;
            }
        }
        jo.put("count",count);
        Filex.logs("findcountCarts.txt","出购物车数量");
        out.print(jo);
    }else if("dele_address".equals(act)){
        String id = h.get("id");
        Consignee.delete(id);
        jo.put("isdelete","ok");
        out.print(jo);


    }else if("moren_address".equals(act)){
        int member = h.member;
        List<Consignee>list = Consignee.find("AND member="+member,0,Integer.MAX_VALUE);
        for (Consignee c : list) {
            c.setIsmoren(0);
            c.set();
        }
        int id = h.getInt("id");
        Consignee cs = Consignee.find(id);
        cs.setIsmoren(1);
        cs.set();
        jo.put("ismoren","ok");
        out.print(jo);
    }else if("logoutopenid".equals(act)){
        Profile p = Profile.find(h.member);
        p.set("openid","");
        p.set();

        //
        h.setCook("openid","",0);
        h.setCook("member","NULL",0);
        h.setCook("autologin","NULL",0);
        Cookie cook = new Cookie("editmode","");
        cook.setPath("/");
        cook.setMaxAge(0);
        response.addCookie(cook);
        if(h.member > 0)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE OnlineList SET member=''  WHERE member=" + DbAdapter.cite(h.username));
            } finally
            {
                db.close();
            }
        }
        String member = (String) session.getAttribute("username");

        System.out.println("用户网站退出：用户：" + session.getAttribute("username") + "--成功退出聊天室");

        if(application.getAttribute("myuser") != null)
        {
            Vector temp = (Vector) application.getAttribute("myuser");

            for(int i = 0;i < temp.size();i++)
            {
                UserForm mylist = (UserForm) temp.elementAt(i);
                if(mylist.username.equals(member))
                {
                    temp.removeElementAt(i);
                    session.setAttribute("username","null");
                }
                if(temp.size() == 0)
                {
                    application.removeAttribute("message");
                }
            }
        }

        session.removeAttribute("member");
        session.removeAttribute("messageclose"); //Reminder.jsp
        OnlineList obj = OnlineList.find(session.getId());
        obj.setMember(null);

        jo.put("type","1");
        out.print(jo);
    }else if("shouhuoren".equals(act)){

        try {

            String[] members = h.getValues("member");
            String[] passwords = h.getValues("password");
            String[] mobiles = h.getValues("mobile");
            String[] membertypes = h.getValues("membertype");
            String[] addresss = h.getValues("address");
            //String[] communitys = h.getValues("community");

            for (int i = 0; i < members.length; i++) {
                Profile sh = Profile.find(members[i]);
                if(sh.profile==0){
                    sh.member=members[i];
                    sh.password=passwords[i];
                    sh.mobile=mobiles[i];

                    sh.membertype=0;
                    //sh.address=addresss[i];

                    sh.community="Home";
                    sh.set();
                    sh.set("address",addresss[i]); //收货地址
                }


            }
            jo.put("type", "0");
            out.print(jo);
            return;

        } catch (Throwable e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            jo.put("type", "1");
            jo.put("mes",e.toString());
            out.print(jo);
            return;
        }

    }else if("send_email".equals(act)){
        String mail = h.get("mail");
        System.out.println(mail);
        int sum =Profile.count("AND email="+DbAdapter.cite(mail));
        if(sum>0){//邮箱已经被注册
            jo.put("type","0");
            jo.put("xiangxi","邮箱已被注册,请更换邮箱");
        }else {
            jo.put("type","1");
            int b = (int) (Math.random() * 1000000);
            session.setAttribute(mail+"_code",b+"");
            System.out.println(b+"------");
            boolean flag = Email.create(h.community,null,mail,"绑定邮箱验证码",b+"");
            if(!flag){
                jo.put("type","2");
            }
        }
        out.print(jo);
    }else if("fuwushang".equals(act)){


        try {

            String[] members = h.getValues("member");
            String[] passwords = h.getValues("password");
            String[] mobiles = h.getValues("mobile");
            String[] membertypes = h.getValues("membertype");
            String[] procurementUnits = h.getValues("procurementUnit");
            //String[] communitys = h.getValues("community");

            for (int i = 0; i < members.length; i++) {
                Profile sh = Profile.find(members[i]);
                if(sh.profile==0){
                    Profile p = Profile.create(members[i],passwords[i],"Home","",request.getServerName());
                    p.setMobile(mobiles[i]);

                    p.setMembertype(2);
                    p.setType(0);



                    String procurementUnit = "|";


                    String puids = "";

                    List<ProcurementUnit> lstp = ProcurementUnit.find(" and name="+DbAdapter.cite(procurementUnits[0]), 0, 1);
                    int fid=0;
                    if(lstp.size()>0){
                        fid=lstp.get(0).puid;
                    }
                    procurementUnit += fid+"|";
                    int puid = fid;

                    puids+= puid;
                    ProcurementUnitJoin puj = ProcurementUnitJoin.find(puid,p.profile);
                    if(puj.jid==0) {
                        puj.profile = p.profile;
                        puj.puid = puid;
                        puj.time = new Date();
                        puj.set();
                    }




                    p.set("procurementUnit",procurementUnit);






                }


            }
            jo.put("type", "0");
            out.print(jo);
            return;

        } catch (Throwable e) {
            jo.put("type", "1");
            out.print(jo);
            return;
        }


    }else if("fuwushang2".equals(act)){

// public static String [] FuwushangField2 = {"","member","company","tax","formula","agentPriceNew"};

        try {

            String[] members = h.getValues("member");
            String[] companys = h.getValues("company");
            String[] taxs = h.getValues("tax");
            String[] formulas = h.getValues("formula");
            String[] agentPriceNews = h.getValues("agentPriceNew");
            // String[] jids=new String[members.length];
            for(int i=0;i<companys.length;i++){
                Profile p=Profile.find(members[i]);
                List<ProcurementUnit> lstu=ProcurementUnit.find(" and name="+DbAdapter.cite("高科"), 0, 1);
                int puid=0;
                if(lstu.size()>0){
                    ProcurementUnit unit=lstu.get(0);
                    puid=unit.puid;
                }

                ProcurementUnitJoin join=ProcurementUnitJoin.find(puid, p.profile);
                if(join.company!=null&&join.company.length()>0){
                    //新加
                    ProcurementUnitJoin puj=new ProcurementUnitJoin(0);

                    puj.profile = p.profile;
                    puj.puid = puid;
                    puj.time = new Date();
                    puj.company=companys[i];
                    puj.tax=Integer.parseInt(taxs[i]);
                    puj.formula=Integer.parseInt(formulas[i]);
                    puj.agentPriceNew=Float.parseFloat(agentPriceNews[i]);
                    puj.set();
                }else{
                    join.company=companys[i];
                    join.tax=Integer.parseInt(taxs[i]);
                    join.formula=Integer.parseInt(formulas[i]);
                    join.agentPriceNew=Float.parseFloat(agentPriceNews[i]);
                    join.set();
                }



            }


            jo.put("type", "0");
            out.print(jo);
            return;

        } catch (Throwable e) {
            jo.put("type", "1");
            out.print(jo);
            return;
        }
    }else if("gkprice".equals(act)){

        try {

            String[] hospitalnames = h.getValues("hospitalname");
            String[] prices = h.getValues("price");
            String[] agentPrices = h.getValues("agentPrice");


            for (int i = 0; i < hospitalnames.length; i++) {
                ShopHospital sh=ShopHospital.find(hospitalnames[i]);
                int hospital=sh.getId();
                String sql = "  AND hospital_id = "+hospital + " AND product_id = 19092713";
                int hflag = ShopPriceSet.count(sql);

                if(hflag==0){
                    ShopPriceSet ss = new ShopPriceSet();
                    ss.hospital_id = hospital;
                    ss.memberType = 0;
                    ss.product_id = 19092713;
                    ss.price = Float.parseFloat(prices[i]);
                    ss.agentPrice = Float.parseFloat(agentPrices[i]);
                    ss.agentPriceNew = 0;
                    ss.set();
                }



            }
            jo.put("type", "0");
            out.print(jo);
            return;

        } catch (Throwable e) {
            jo.put("type", "1");
            out.print(jo);
            return;
        }



    }else if("select_product".equals(act)){//查询商品
        String name=MT.f(h.get("name"));
        jo.put("name",name);
        List<ShopProduct> sh_list = ShopProduct.find("AND state=0 AND name1 like '%" + MT.f(name) + "%'", 0, 1);
        if (sh_list.size() > 0) {//有数据，判断是哪个jsp
            jo.put("type","1");
            ShopProduct sh = sh_list.get(0);
            ShopCategory shopCategory = ShopCategory.find(sh.category);
            int categpry = shopCategory.father;
            int tps = Config.getInt("tps");
            int lizi = Config.getInt("lizi");
            int shebei = Config.getInt("shebei");
            if (categpry == tps) {//tps
                jo.put("url","/html/folder/19081308-1.htm?&product_name="+name);

            } else if (shebei == categpry) {//设备
                if (Config.getInt("category1") == sh.category) {
                    jo.put("url","/html/folder/19081608-1.htm?category="+sh.category+"&product_name="+name);
                }
                if (Config.getInt("category2") == sh.category) {
                    jo.put("url","/html/folder/19081628-1.htm?category="+sh.category+"&product_name="+name);

                }
                if (Config.getInt("category3") == sh.category) {
                    jo.put("url","/html/folder/19081641-1.htm?category="+sh.category+"&product_name="+name);

                }
                if (Config.getInt("category4") == sh.category) {
                    jo.put("url","/html/folder/19081642-1.htm?category="+sh.category+"&product_name="+name);

                }


            } else if (Config.getInt("category5") == sh.category){ //生产与测试不一致
                //else if (Config.getInt("category5") == categpry){//测试及开发
                jo.put("url","/html/folder/19081645-1.htm?category="+sh.category+"&product_name="+name);
            } else if(sh.category == lizi){//粒子
                jo.put("url","/html/folder/19080995-1.htm?product_name="+name);

            }else {//查出有产品没查出分类
                jo.put("url","/html/folder/19081608-1.htm?type=10&product_name="+name);
            }
        }else {
            jo.put("type","0");
        }
        out.print(jo);
        return;
    }else if("edit_PW".equals(act)){
        String old_pw = h.get("old_pw");
        String new_pw = h.get("new_pw");
        System.out.println(old_pw);
        System.out.println(new_pw);
        Profile profile = Profile.find(h.member);
        if(profile.getPassword().equals(old_pw)){//原密码一致可以修改
            profile.setPassword(new_pw);
            profile.set();
            jo.put("type","1");
        }else {
            jo.put("type","0");

        }

        out.print(jo);
    }else if("send_yzm".equals(act)){//新登录页发验证码   根据用户名
        StringBuffer sb = new StringBuffer();
        String name = h.get("user_name");
        Filex.logs("yanzhengma.txt","发送验证码用户名，send_yzm，member==="+name);
        int count = Profile.count("AND deleted=0 AND member=" + Database.cite(name));

        if(count==0){
            Filex.logs("yanzhengma.txt","发送验证码用户名，用户名不存在"+name);
            jo.put("type","2");
            jo.put("mes","用户名不存在");
            out.print(jo);
            return;
        }
        Profile profile = Profile.find(name);
        String mymob = profile.getMobile();

        //发送验证码
        Filex.logs("login_wx.txt","发验证码：手机号："+mymob );
        int b = (int)(Math.random()*1000000);
        session.setAttribute(name +"_code",String.valueOf(b));
        Filex.logs("yanzhengma.txt","发验证码：---"+String.valueOf(b) );
        String c = "您好，你正在使用验证码登陆，请在页面输入验证码为“" + b
                + "”";
        System.out.println(b);
        String rs = SMSMessage.create(h.community, "webmaster", mymob,
                h.language, c);
        List<SecurityCode> securityCodes = SecurityCode.find(" AND pid=" + profile.profile, 0, 1);
        if(securityCodes.size()==0){
            SecurityCode so = SecurityCode.find(0);
            so.setPid(profile.profile);
            so.setCode(b);
            so.set();
        }else {
            SecurityCode so = securityCodes.get(0);
            so.setCode(b);
            so.set();
        }
        /*SecurityCode so = SecurityCode.find(profile.profile);
        so.setPid(profile.profile);
        so.setCode(b);
        so.set();*/
           			/*int[] rs = SMessage.send(1, h.member, h.get("members", "|"), mob, 0, c, out);
           			Writer out1 = request.*/
                      /*if (rs == null)
                      	sp.append("t");*/
                      /*else
                      	sp.append("f");*/
        jo.put("type", "0");
        out.print(jo);
        return;

    }else if("yl_login_new".equals(act)){//2019-12-27  新登陆  用户名密码手机验证码登录

        //2017-06-05新加的登陆。由原来的yllogin复制而来。主要修改验证码部分，验证码是通过手机短信获取到的。
        String member = h.get("username1");
        String password1 = h.get("password");
        Profile p = Profile.find(member);

        if(!p.password.equals(password1)){
            jo.put("type", "1");
            jo.put("mes", "账户名密码错误！");
            out.print(jo.toString());
            //out.print("<script>mt.show('手机验证码错误！');</script>");
            return;
        }
        String mob = p.getMobile();

        String verid = MT.f(h.get("verid"), "");
        if(verid.equals("")){
            jo.put("type", "1");
            jo.put("mes", "请填写写验证码！");
            out.print(jo.toString());
            //out.print("<script>mt.show('手机验证码错误！');</script>");
            return;
        }
        String code = String.valueOf(session.getAttribute(member
                + "_code"));
        Filex.logs("login_wx.txt","获取到的===——session名称"+member+"_code");
        Filex.logs("login_wx.txt","点击登录：session的值1"+session.getAttribute(member + "_code"));
        Filex.logs("login_wx.txt","点击登录：session的值2"+String.valueOf(session.getAttribute(member + "_code")));
        Filex.logs("login_wx.txt","点击登录：页面输入值："+verid);
        List<SecurityCode> securityCodes = SecurityCode.find(" AND pid=" + p.profile, 0, 1);
        if(securityCodes.size()==0){
            Filex.logs("denglu.txt","securityCodes没有验证码：profile="+p.profile);
            jo.put("type", "1");
            jo.put("mes", "系统故障请联系管理员处理！");
            out.print(jo.toString());
            //out.print("<script>mt.show('手机验证码错误！');</script>");
            return;
        }
        String code1 = securityCodes.get(0).getCode()+"";
        if (!verid.equals(code1)) {
            Filex.logs("login_wx.txt","点击登录：验证码有误："+verid+"----"+code1);
            jo.put("type", "1");
            jo.put("mes", "手机验证码错误！");
            out.print(jo.toString());
            //out.print("<script>mt.show('手机验证码错误！');</script>");
            return;
        }
        /*ArrayList arrayList = SMSMessage.find(" AND mobile=" + Database.cite(mob) + " order by time desc ", 0, 10);
        for (int i = 0; i < arrayList.size(); i++) {
            SMSMessage o = (SMSMessage)arrayList.get(i);
            String content = o.getContent();
            if(content.contains("验证码")){//最新验证码
                if(!content.contains(verid)){//不包含这段验证码
                    Filex.logs("login_wx.txt","点击登录：验证码有误："+verid+"----"+content);
                    System.out.println("点击登录：验证码有误："+verid+"----"+content);
                    jo.put("type", "1");
                    jo.put("mes", "手机验证码错误！");
                    out.print(jo.toString());
                    //out.print("<script>mt.show('手机验证码错误！');</script>");
                    return;
                }else {
                    break;
                }
            }
        }*/

       /* if (!verid.equals(code)) {
            Filex.logs("login_wx.txt","点击登录：验证码有误："+verid+"----"+code);
            jo.put("type", "1");
            jo.put("mes", "手机验证码错误！");
            out.print(jo.toString());
            //out.print("<script>mt.show('手机验证码错误！');</script>");
            return;
        }*/



	/*if(p.emailflag==1){
		String url = "/Members.do?act=resemail&member="+p.member;
		//out.print("<script>mt.show(\"" + Res.get(h.language,"您不能登录！您还没有验证电子邮箱！<br/><br/>没有收到邮件？{0}重发邮件</a>","<a href=" + url + " target=_ajax>") + "\");</script>");
		jo.put("type", "3");
		jo.put("mes", "您不能登录！您还没有验证电子邮箱！");
		out.print(jo.toString());
		//out.print("<script>mt.show('用户名或密码错误！');</script>");
		return;
	}*/
        if (p.deleted) {
            //out.print("<script>mt.show('用户已被删除！');</script>");
            jo.put("type", "1");
            jo.put("mes", "用户已被删除！");
            out.print(jo.toString());
            return;
        }

        if (p.isLocking()) {
            jo.put("type", "1");
            jo.put("mes", "该用户已被锁定，暂时无法登录！");
            out.print(jo.toString());
            //out.print("<script>alert('该用户已被锁定，暂时无法登录！');</script>");
            return;
        }
        Filex.logs("yt_qianshou2.txt", "login:openid===" + p.openid);
        int webtype = h.getInt("webtype");//1电脑

        if(webtype==0){

            if (MT.f(p.openid).length() > 0) {
                String openid = h.getCook("openid", "");
                // h.setCook("openid", p.openid, -1);
                Filex.logs("yt_qianshou2.txt", "login:openid2==="+openid);
                //if(!"".equals(openid)){
                //out.print("<script>alert('该用户已被绑定，暂时无法登录！');</script>");
                jo.put("type", "1");
                jo.put("mes", "该用户已被绑定，暂时无法登录！");
                out.print(jo.toString());
                //out.print("<script>alert('该用户已被锁定，暂时无法登录！');</script>");
                return;
                //}
            } else {
                //设置openid
                String openid = h.getCook("openid", "");
                Filex.logs("yt_qianshou2.txt", "login:openid3===" + openid);
                if (!"".equals(openid) && null != openid) {
                    boolean flag = Profile.flagopenid(openid);
                    if (!flag) {
                        p.set("openid", openid);
                    }
                }
                String nickname = h.getCook("nickname", "");
                Filex.logs("weixinname.txt","profile="+p.profile+",name="+nickname);
                SecurityCode securityCode = securityCodes.get(0);
                securityCode.setNicheng(nickname);
                securityCode.set();
            }

        }

        String auto = h.get("autologin", "");
        if (auto.length() > 0) {
            h.setCook("autologin", MT.enc(p.getLogint() + "|" + member + "|" + p.getPassword()), 7 * 60 * 24);
        }
        RV rv = new RV(member);
        Logs.create("Home", rv, 1, h.node, request.getRemoteAddr());
        //OnlineList.create(session.getId(),h.community,member,request.getRemoteAddr());
        p.setLogin(request.getRemoteAddr(), request.getHeader("user-agent") + " Screen/" + request.getParameter("screen"), new Date());
        Community c = Community.find(h.community);
        h.member = p.getProfile();
        session.setAttribute("member", h.member);
        if (c.isSession()) {
            //session.setAttribute("tea.RV",rv);
        } else {
            //h.setCook("member",MT.enc(p.getLogint() + "|" + h.member + "|" + p.getPassword()),h.getInt("expiry", -1));
            h.setCook("member", MT.enc(p.getLogint() + "|" + h.member + "|" + p.getPassword()), h.getInt("expiry", -1));
            Filex.logs("yt_nologin.txt", "members:" + p.getLogint() + "|" + h.member + "|" + p.getPassword() + "====" + h.getInt("expiry", -1));

        }
        Filex.logs("yt_qianshou2.txt", "login:nexturl===");
        jo.put("type", "0");
        out.print(jo.toString());
        //out.print("<script>top.location.replace('" + nexturl + "');</script>");//parent
        return;

    }else if("checkNumber".equals(act)){
        String express_code = h.get("express_code");
        Filex.logs("checkNumber.txt","express_code==="+express_code);
        if(express_code.equals("")){
            Filex.logs("checkNumber.txt","运单号空");
            jo.put("type","0");
            out.print(jo);
            return;
        }
        KdApiOrderDistinguish kd = new KdApiOrderDistinguish();
        String result = kd.getOrderTracesByJson(express_code);
        if(result.contains("顺丰")){
            Filex.logs("checkNumber.txt","成功======="+result);
            jo.put("type","1");
        }else {
            Filex.logs("checkNumber.txt","失败======="+result);
            jo.put("type","3");
        }
        out.print(jo);
        return;
    }
%>
<%!
    public JSONObject findBatches(Http h, JSONObject jo) {
        String orderId = h.get("ordercode");
        ShopOrder so = ShopOrder.findByOrderId(orderId);
        try {
            int type = 0;
            Profile p1 = Profile.find(so.getMember());
            int issalesman = p1.issalesman;

            double perce = p1.membertype == 2 ? 0.03 : 0.01;
            double activity = h.getDouble("activity");
            int quantitynum = h.getInt("number");
            //Date expecteddelivery = new Date();
            Date expecteddelivery;
            List<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id = " + Database.cite(orderId), 0, 1);
            ShopOrderData sod = new ShopOrderData(0);
            if (sodlist.size() > 0) {
                sod = sodlist.get(0);
            }
            expecteddelivery = sod.getCalibrationDate();

            int count = 0;

            if (so.getAllocate() == 1) {//调配
                count = ProductStock.findStock(activity, perce, issalesman, expecteddelivery, 0);
            } else {
                count = ProductStock.findStock(activity, perce, issalesman, expecteddelivery, 1);
            }

            if (quantitynum > count) {//库存不足
                type = 2;//
                jo.put("type", type);
                //out.print(jo);
                return jo;
            }

            JSONObject myjo = StockOperation.set(activity, quantitynum, perce, issalesman, h.member, so.getId(), expecteddelivery);
            if (myjo.getInt("status") == 1) {
                type = 2;
            } else {
                jo.put("soid", myjo.get("soid"));
            }
            jo.put("type", type);
        } catch (Throwable e) {

        }
        //return myjson;
        return jo;
    }

    public JSONObject findBatchesYuLiu(Http h, JSONObject jo) {
        String orderId = h.get("ordercode");
        //Date date = new Date();
        Date date;
        String mes = "";
        int number = h.getInt("number");//分批数量

        int denumber = number;//剩余扣除数量

        int type = 0;
        String soid = "";
        try {
            ShopOrder so1 = ShopOrder.findByOrderId(orderId);
            List<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id = " + Database.cite(so1.getOrderId()), 0, 1);
            ShopOrderData sod = new ShopOrderData(0);
            if (sodlist.size() > 0) {
                sod = sodlist.get(0);
                date = sod.getCalibrationDate();
                List<ShopBatchesData> sbdlist = ShopBatchesData.find(" AND sbd.orderId = " + Database.cite(so1.getOrderId()) + " AND (number-occupyNumber)<> 0 AND ps.psid <> 0 order by sbd.time,sbd.id   ", 0, Integer.MAX_VALUE);
                int sum = 0;//分批数
                if(sbdlist.size()==0){
                    type = 2;
                    mes = "数据不完整，请重新分批！";

                }else{
                    for (int i = 0; i < sbdlist.size(); i++) {
                        ShopBatchesData sbd = sbdlist.get(i);
                        ProductStock ps = ProductStock.find(sbd.psid);
                        if ((sbd.getNumber() - sbd.getOccupyNumber()) > (ps.getAmount() + ps.getReserve())) {
                            type = 2;
                            mes = "数据异常！";
                            break;
                        }
                    }
                }
                if (type != 2) {
                    for (int i = 0; i < sbdlist.size(); i++) {

                        if (denumber == 0) {
                            break;
                        }

                        ShopBatchesData sbd = sbdlist.get(i);
                        ProductStock p = ProductStock.find(sbd.psid);
                        double act = ProductStock.getTimeAct(p.createtime, sod.getCalibrationDate(), p.activity);
                        //int number = sbd.getNumber();
                        if ((sbd.getNumber() - sbd.getOccupyNumber()) >= denumber) {//大于等于


                            p.setAmount(p.amount - denumber);
                            p.setOrdernum(p.getOrdernum() - denumber);//减去用户占用的库存
                            p.set();
                            StockOperation so = new StockOperation();
                            so.setAmount(denumber); // 数量
                            so.setDescribe("管理员分配,减库存数量:" + denumber + "支,库存剩余:" + (p.amount) + "支,预留剩余:" + p.reserve + "支" + "，用户占用库存：" + p.getOrdernum() + "支"); // 描述//so.setReserve(number); // 预留数量
                            // 计算有效期
                            Date date2 = StockOperation.getDate(sod.getActivity(), p, sod.getCalibrationDate());
                            so.setActivity((float) act);
                            so.setPsid(p.psid); // 库存id
                            so.setCid(14102669); // 类别id
                            so.setOid(so1.getId());
                            so.setMember(h.member);

                            so.setValid(date2);
                            so.setCalibrationtime(date);
                            so.setType(5);//管理员操作
                            so.setTime(new Date());
                            so.set();

                            sbd.setOccupyNumber(sbd.getOccupyNumber() + denumber);
                            sbd.set();
                            soid += "," + so.getSoid();

                            denumber = denumber - denumber;

                        } else {

                            //分批数量已经不大于剩余数量了

                            //把剩下的都扣完
                            int synum = (sbd.getNumber() - sbd.getOccupyNumber());


                            denumber = denumber - synum;

                            p.setOrdernum(p.getOrdernum() - synum);//减去用户占用的库存
                            p.setAmount(p.amount - synum);

                            //number = number-p.amount;

                            StockOperation so = new StockOperation();
                            so.setAmount(synum); // 数量
                            so.setDescribe("管理员分配,减库存数量:" + synum + "支,库存剩余:" + p.getAmount() + "支" + "，用户占用库存：" + p.getOrdernum() + "支"); // 描述//so.setReserve(number); // 预留数量
                            // 计算有效期
                            Date date2 = StockOperation.getDate(sod.getActivity(), p, sod.getCalibrationDate());


                            so.setActivity((float) act);
                            so.setPsid(p.psid); // 库存id
                            so.setCid(14102669); // 类别id
                            so.setOid(so1.getId());
                            so.setMember(h.member);
                            so.setValid(date2);
                            so.setCalibrationtime(date);
                            so.setType(5);//管理员操作
                            so.setTime(new Date());
                            so.set();
                            p.set();
                            soid += "," + so.getSoid();
                            sbd.setOccupyNumber(sbd.getOccupyNumber() + synum);
                            sbd.set();
                        }

                    }
                }
            } else {
                type = 2;
                mes = "库存数量不足，请查看库存！";
            }


        } catch (Throwable e) {
            System.out.println(e.toString());
            type = 2;
            mes = "库存操作异常！";
        }
        jo.put("soid", soid);
        jo.put("type", type);
        jo.put("mes", mes);
        return jo;
    }
%>
