package tea.entity.westrac;

import tea.entity.site.*;
import java.sql.SQLException;
import java.util.*;
import java.text.*;
import java.io.*;

import tea.entity.lvyou.LvyouJobCatagory;
import tea.entity.member.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.util.*;
import tea.resource.*;
import tea.entity.admin.AdminUsrRole;
import java.net.*;

public class Westrac
{
    public static void start() throws SQLException
    {
        final CommunityOption co = CommunityOption.find("[SYSTEM]");
        String url = co.get("westracurl"); //"http://sys.d1cm.com/search.do?method=getmdata"
        Filex.logs("d1cm.txt","我开始：" + url);
        if(url == null)
            return;
        new Thread()
        {
            public void run()
            {
                try
                {
                    while(true)
                    {
                        String h = null;
                        try
                        {
                            Filex.logs("d1cm.txt","我还活者");

                            Thread.sleep(co.getInt("westracinter") * 1000);

                            String url = co.get("westracurl");
                            if(url == null)
                                continue;
                            h = (String) Entity.open(url);
                            sync(h,new Date());
                            if(h.length() > 0)
                            {
                                Filex.write(Common.REAL_PATH + "/res/westrac/imp_ok/" + System.currentTimeMillis() + ".xml",h);
                            }
                        } catch(Throwable ex)
                        {
                            if(h != null)
                                try
                                {
                                    Filex.write(Common.REAL_PATH + "/res/westrac/imp/err_" + System.currentTimeMillis() + ".xml",h);
                                } catch(Exception ex2)
                                {}
                            Filex.logs("d1cm.txt","同步用户　出错：" + ex.toString() + "　　　异常：" + ex.getClass().getName());
                            ex.printStackTrace();
                            //Thread.sleep(60000L);
                        }
                    }
                } catch(Throwable ex)
                {
                    ex.printStackTrace();
                } finally
                {
                    Filex.logs("d1cm.txt","我死了");
                }
            }
        }.start();
    }

    public static void main(String[] args) throws Exception
    {

        //"/home/edn/apache-tomcat-6.0.32/webapps/ROOT/res/westrac/imp_1116/"
//        File[] fs = new File("E:/TDDOWNLOAD/imp").listFiles();
//        for(int i = 0;i < fs.length;i++)
//        {
//            String h = Filex.read(fs[i].getPath(),"utf-8");
//            System.out.println(fs[i].getName());
//            sync(h,new Date(fs[i].lastModified()));
//            Thread.sleep(1000);
//        }
//        System.out.println("添加完成！");
        Profile p = Profile.find("member");
//        CommunityOption co = CommunityOption.find("[SYSTEM]");
//        String url = co.get("westracurl");
//        String h = (String) Entity.open(url);
//        Filex.write("d:/d1cm/" + System.currentTimeMillis() + ".htm",h);

        String h = Filex.read("D:/d1cm/1337940259687.htm","UTF-8");
        sync(h,new Date());
    }

    public static void sync(String h,Date time) throws Exception
    {
        // System.out.println("同步：" + MT.f(time,1) + " 长度：" + h.length());
        if(h.length() < 1)
            return;
        XMLObject xml = new XMLObject(h).getXMLObject("members");
        XMLArray arr = xml.getXMLArray("meber");
        if(arr == null)
            return;

        DecimalFormat df = new DecimalFormat("000000");

        for(int i = 0;i < arr.size();i++)
        {
            xml = arr.getXMLObject(i);
            String member = xml.getString("username");

            String community = "westrac";
            String password = Encrpt.decrypt(xml.getString("password"));
            Profile pobj;
            String code;
            boolean isNew = !Profile.isExisted(member);
            if(isNew)
            {
                Filex.logs("d1cm.txt","添加会员：" + member);
                pobj = Profile.create(member,password,community,"","");
                pobj.setTime(time);
                code = df.format(SeqTable.getSeqNo(community));
            } else
            {
                pobj = Profile.find(member);
                pobj.setPassword(password);
                code = pobj.getCode();
                Filex.logs("d1cm.txt","修改会员：" + member);
            }
            pobj.setFirstName(xml.getString("truename"),1);
            //会员类型
            int wsttype = 0;
            String tmp = xml.getString("mtype");
            ArrayList<LvyouJobCatagory> catatList =LvyouJobCatagory.find();
            for(int j = 1;j < catatList.size();j++)
            { LvyouJobCatagory cata=(LvyouJobCatagory)catatList.get(i);
                if(cata.getName().equals(tmp))
                {
                    wsttype = j;
                    break;
                }
            }
            /*
            for(int j = 1;j < Profile.WST_TYPE.length;j++)
            {
                if(Profile.WST_TYPE[j].equals(tmp))
                {
                    wsttype = j;
                    break;
                }
            }
            */
            //品牌
            int xpinpai = 0;
            tmp = xml.getString("brand"); //长度为0,返回的是null
            if(tmp != null)
            {
                String[] barr = tmp.split(",");
                tmp = barr[0].length() < 1 ? barr[1] : barr[0];
                Enumeration e = WomenOptions.find(" AND community="+DbAdapter.cite(community)+" AND type=0 AND woname LIKE " + DbAdapter.cite("%" + tmp + "%"),0,1);
                xpinpai = e.hasMoreElements() ? ((Integer) e.nextElement()).intValue() : 0;
            }
            //机种
            String wstmodel = xml.getString("productno");
            //你是怎么知道这次活动的
            int source = 0;
            tmp = xml.getString("source");
            for(int j = 1;j < Profile.SOURCE_TYPE.length;j++)
            {
                if(Profile.SOURCE_TYPE[j].equals(tmp))
                {
                    source = j;
                    break;
                }
            }
            //推荐人
            String tjmember = xml.getString("tuijian");
            //推荐人手机
            String tjmobile = Encrpt.decrypt(xml.getString("tuijianm"));

            pobj.setWst(1,2,code,Encrpt.decrypt(xml.getString("mobile")),wsttype,xpinpai,wstmodel,source,tjmember,tjmobile);

            if(isNew)
            {
                //角色
                AdminUsrRole aur = AdminUsrRole.find(community,member);
                aur.setRole(aur.getRole() + "7/");

                Communityintegral cobj = Communityintegral.find(community);
                pobj.setMyintegral(pobj.getMyintegral() + cobj.getRegpoint());
                WestracIntegralLog.create(pobj.getMember(),2,null,0,cobj.getRegpoint(),null,new Date(),0,community);

                //发送短信
                String c = "您好，您已成功注册为履友，您的会员ID是“" + pobj.getCode() + "”，为您增加" + cobj.getRegpoint() + "积分，请登录lvyou.westrac.com.cn,畅游我们的家！";
                if(pobj.getImptype() == 1)
                {
                    //说明是导入会员
                    c = "您好，您成为履友成员，您的ID号是“" + pobj.getCode() + "”,缺省密码是123456，为您增加" + cobj.getRegpoint() + "积分，请登录lvyou.westrac.com.cn绑定用户名,畅游我们的家！";
                }
                //
                SMSMessage.create(community,pobj.getMember(),pobj.getMobile(),1,c);
                Filex.logs("d1cm.txt","添加会员：" + member + " OK");
            }
        }
    }

}
