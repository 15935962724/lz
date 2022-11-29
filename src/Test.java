import tea.entity.Arrayx;
import tea.entity.node.*;
import tea.entity.member.ProfileGolf;
import java.io.*;
import tea.db.DbAdapter;
import java.util.*;
import java.util.Date;
import java.net.*;
import java.sql.*;
import tea.entity.*;
import tea.entity.weibo.*;
import tea.entity.Http;
import tea.entity.stat.TaskMgr;
import sun.misc.*;

import net.mietian.common.*;
import com.sun.jna.*;
import com.sun.jna.platform.win32.WinDef.HWND;
import tea.entity.util.Card;
import java.sql.ResultSet;
import tea.entity.member.Profile;
import java.math.*;
import com.drew.metadata.*;
import com.drew.imaging.jpeg.*;
import com.drew.metadata.exif.*;
import tea.entity.weixin.WxUser;
import java.text.SimpleDateFormat;
import java.util.zip.*;
import tea.entity.Filex;
import net.mietian.convert.Zip;
import tea.entity.weixin.WeiXin;
import tea.entity.MT;
import java.util.regex.*;
import java.text.DecimalFormat;
import tea.entity.site.Html;
import org.json.JSONObject;
import org.dom4j.*;

//import com.sun.jna.platform.win32.User32;

//remark2:网站地址

public class Test
{
//4344
    public static void main(String args[]) throws Exception
    {
        //>1399601772453
		System.out.println(MT.f(new Date(1399566490839L),1));
		System.out.println(MT.f(new Date(1399601772453L),1));
//        for(int i = 0;i < li.size();i++)
//        {
//            System.out.println(li.get(i));
//        }

        //int len = "{\"button\":[]}".getBytes("utf-8").length;
        //System.out.println(len);
        //new Zip(new File("D:/aa.zip")).zip(new File[] {new File("D:/aa111.zip")});
        //WxUser.refresh("redribbon");//http://www.bjrroc.org/WxMessengers.do?type=390,400,730&community=redribbon&node=0
        //WxUser.find("redribbon",340772595).refresh();

        //String str=DbAdapter.cite(new Date(1385619014L*1000));
        //System.out.println(str);

//        DbAdapter db = new DbAdapter(),d2 = new DbAdapter();
//        try
//        {
//            db.setAutoCommit(false);
//            db.executeUpdate("UPDATE attch SET member=4 WHERE attch=13090004");
//            db.setAutoCommit(true);
//            d2.executeQuery("SELECT member FROM attch WHERE attch=13090004");
//            if(d2.next())
//            {
//                System.out.println(d2.getInt(1));
//            }
//        } finally
//        {
//            db.rollback();
//            db.close();
//        }

        Code c = new Code("Smoke");
        c.pack = "tea.entity.tobacco";
        c.isEDN = true;
        c.java_bean();
		c.jsp_list();
		c.jsp_edit();
		c.pack = "tea.ui.tobacco";
		c.java_servlet();
//		Files.start();
//        Node n = Node.find(68);
//        Date time = n.getTime();
//        File dir = new File("Z:/jiyintupu");
//        File[] fs = dir.listFiles();
//        for(int i = 0;i < fs.length;i++)
//        {
//            String name = fs[i].getName();
//            //if(name.endsWith(".htm"))
//            //    fs[i].renameTo(new File(dir,name.substring(0,name.length() - 3) + "doc"));
//            if(name.endsWith(".htm"))
//            {
//                //String title = name.substring(0,name.length() - 4);
//                String str = tea.entity.Filex.read(fs[i].getPath(),"GBK");
//                String title = "无标题";
//                int s = str.indexOf("<title>") + 7;
//                if(s > 10)
//                    title = str.substring(s,str.indexOf("</title>",s));
//                time = new Date(fs[i].lastModified());
//                int node = Node.create(n._nNode,i,n.getCommunity(),n.getCreator(),41,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),time,null,time,n.getStyle(),n.getRoot(),n.getKroot(),n.getKroot(),null,n.getDefaultLanguage(),title,null,null,"<div style='text-align:center;'><script>mt.embed('/res/papc/media/play.swf',660,500,'vcastr_file=/res/papc/media/flv2/" + Http.enc(name) + "&IsAutoPlay=1')</script></div>",null,null,0,null,null,null,null,null,null,null);
//                Files f = Files.find(node,1);
//                f.set(0,0,"","","",(int) fs[i].length(),0,0,"","","","/res/papc/files/jiyintupu/" + name.substring(0,name.length() - 3)+".doc",0,false,false,false,false,0,3153915);
//            }
//        }

//        DbAdapter db = new DbAdapter();
//        int i = 0,last = 0;
//        while(true)
//        {
//            System.out.println(i + "、" + last);
//            Iterator it = SPicture.find(" AND node>" + last + " ORDER BY node",0,1000).iterator();
//            if(!it.hasNext())
//                break;
//            for(;it.hasNext();i++)
//            {
//                SPicture t = (SPicture) it.next();
//                last = t.node;
//				db.executeUpdate("UPDATE NodeLayer SET subject=" + DbAdapter.cite(t.species1) + ",keywords=" + DbAdapter.cite(t.keyword) + ",content=" + DbAdapter.cite(t.remark) + " WHERE node=" + t.node);
////                File file = new File("H:" + t.mulname);
////                if(!file.exists())
////                    continue;
////                try
////                {
////                    Metadata md = JpegMetadataReader.readMetadata(file);
////                    Directory exif = md.getDirectory(ExifDirectory.class);
////                    if(exif.containsTag(ExifDirectory.TAG_DATETIME))
////                    {
////                        Date time = exif.getDate(ExifDirectory.TAG_DATETIME);
////                        if(time.getTime() < 0)
////                            continue;
////                        t.time = time;
////                        db.executeUpdate("UPDATE spicture SET time=" + DbAdapter.cite(t.time) + " WHERE node=" + t.node);
////                        db.executeUpdate("UPDATE Node     SET starttime=" + DbAdapter.cite(t.time) + ",time=" + DbAdapter.cite(t.time) + " WHERE node=" + t.node);
////                    }
////                } catch(Exception ex)
////                {
////                    Filex.logs("exif_err.txt","," + t.node + "," + t.mulname + "," + ex.getMessage());
////                    System.out.println(i + "、" + file + ":" + ex.getMessage());
////                }
//            }
//        }
//        db.close();


//        String str = "57°55'56.6\"";
//        String[] arr = str.split("[°º'\"]");
//        for(int i = 0;i < arr.length;i++)
//        {
//            System.out.println(i + ":" + arr[i]);
//        }
//
//        //118.04166666666667
//        double d = Integer.parseInt(arr[0]) + Double.parseDouble(arr[1])/60 + Double.parseDouble(arr[2])/3600;
//
//        int a1 = (int) d;
//        double m = (d - a1) * 60;
//        int a2 = (int) m;
//        double s = (m - a2) * 60;
//
//        str = a1 + "°" + a2 + "'" + s + "\"";
//        System.out.println(str);
//        System.out.println(d);

//		Course.start();
//        Code c = new Code("DLog");
//        c.pack = "tea.db";
//        c.isEDN = true;
//        c.java_bean();
//		c.java_servlet();
//        c.jsp_list();
//        c.jsp_edit();
        //c.jsp_listing();

//        Node n = Node.find(65);
//        int last = 0;
//        while(true)
//        {
//            System.out.println(last);
//            Iterator it = SPicture.find(" AND node>" + last + " ORDER BY node",0,1000).iterator();
//            if(!it.hasNext())
//                break;
//            for(int i = 0;it.hasNext();i += 1)
//            {
//                SPicture t = (SPicture) it.next();
//                last = t.node;
//                int node = Node.create(t.node,n._nNode,i,n.getCommunity(),n.getCreator(),108,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),t.time,null,t.time,n.getStyle(),n.getRoot(),n.getKroot(),n.getKroot(),null,n.getDefaultLanguage(),t.species1,null,null,t.remark,null,null,0,null,null,null,null,null,null,null);
//                //t.set("node",String.valueOf(node));
//                //Node.find(t.node).setStartTime(t.psdate);
//                //DbAdapter.execute("UPDATE specimen SET reserve=" + t.node + " WHERE rcode=" + DbAdapter.cite(t.code));
//            }
//        }
//        Iterator it = Plant.find(" ORDER BY node",0,Integer.MAX_VALUE).iterator();
//        while(it.hasNext())
//        {
//            Plant t = (Plant) it.next();
//			System.out.println(t.species[1]);
//            DbAdapter db = new DbAdapter();
//            try
//            {
//                db.executeQuery("SELECT Altitude,Endangered,Reason,Ndistribution,Idistribution,zyglm FROM binwei_P WHERE Cspecies=" + DbAdapter.cite(t.species[1]));
//                if(db.next())
//                {
//                    t.altitude = db.getString(1);
//                    t.endangered = db.getString(2);
//                    t.endanger = db.getString(3);
//                    t.ndistribution = db.getString(4);
//                    t.idistribution = db.getString(5);
//                    t.zyglm = db.getString(6);
//                    t.set();
//                }
//            } finally
//            {
//                db.close();
//            }
//        }
//		Node n=Node.find(49);
//        DbAdapter db = new DbAdapter(2);
//        db.executeQuery("SELECT id,title,pubdate,keywords FROM `dede_archives` WHERE typeid=2");
//        while(db.next())
//        {
//            int id = db.getInt(1);
//            String title = db.getString(2);
//            Date time = new Date(db.getLong(3) * 1000);
//            String keywords = db.getString(4);
//			int node =Node.create(n._nNode,0,n.getCommunity(),n.getCreator(),41,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),null,null,time,n.getStyle(),n.getRoot(),n.getKroot(),n.getKroot(),"arc:"+id,n.getDefaultLanguage(),title,keywords,null,null,null,null,0,null,null,null,null,null,null,null);
//			n.finished(node);
//        }
//		db.close();

//		DbAdapter db = new DbAdapter(0),d3 = new DbAdapter(3);
//		 db.executeQuery("SELECT node,syncid FROM Node WHERE type=41");
//		 while(db.next())
//		 {
//			 int id = db.getInt(1);
//			 String str = db.getString(2).substring(4);
//			 d3.executeQuery("SELECT url,filesize FROM dede_uploads WHERE arcid=" + str);
//			 if(d3.next())
//			 {
//				 String url = d3.getString(1).substring(20);
//				 url = "/res/papc/files/" + url;
//				 int filesize = d3.getInt(2);
//				 Node n = Node.find(id);
//				 n.setFile(url,1);
//
//				 DbAdapter d4 = new DbAdapter();
//				 try
//				 {
//					 d4.executeUpdate("UPDATE Files SET code='" + id + "',pconv=1,pcount=0,toolbar=3153915,namepath='"+url+"',filesize=" + filesize + " WHERE node=" + id + " AND language=" + 1);
// 				 } finally
//				 {
//					 d4.close();
//				 }
//
//			 }
//			 System.out.println(id + ";" + str);
//		 }
//		 db.close();

//
//vcastr_file=/papc/uploads/media/130110/1-1301101Q605.flv&IsAutoPlay=1" menu="false" quality="high" width="660" height="500

//        char st0 = '`',st1 = '`';
//		//char st0 = '[',st1 = ']';
//        DbAdapter db = new DbAdapter(2),d2 = new DbAdapter(2);
//        DatabaseMetaData dmd = db._con.getMetaData();
//        ResultSet rs = dmd.getTables("lms",null,null,new String[]{"TABLE"});
//        while(rs.next())
//        {
//            String tab = rs.getString(3);
//            System.out.println(tab);
//            ResultSet rc = dmd.getColumns("lms",null,tab,null);
//            while(rc.next())
//            {
//                String col = rc.getString(4);
//                int type = rc.getInt(5);
//                //mssql: 4:int identity  6:float  -4:image
//                //mysql: 4:int unsigned  7:float  91:date 93:datetime 5:smallint -7:bit
//                //if(type == 4 || type == 5 || type == 6 || type == -4 || type == 91 || type == -7)
//                //    continue;
//                //if(type == 4 || type == 5 || type == 7 || type == 91 || type == 93 || type == -7)
//                //    continue;
//				//System.out.println(col + ":" + type + ":" + rc.getString(6));
//                String sql = "SELECT COUNT(*) FROM " + st0 + tab + st1 + " WHERE " + st0 + col + st1 + " LIKE '15811276751'";
//                try
//                {
//                    db.executeQuery(sql);
//                    db.next();
//                    if(db.getInt(1) > 0)
//                    {
//                        System.out.println(sql);
//                    }
//                } catch(Exception ex)
//                {
//                    System.out.println(col + ":" + type + ":" + rc.getString(6));
//                    ex.printStackTrace();
//                }
//            }
//            rc.close();
//        }
//        rs.close();
//        db.close();
//        d2.close();

        //621356256000000000
        //System.out.println(tea.entity.MT.f(new Date(1394281608000L)));
        //pic("D:/~2/20140102164045.jpg");
        //aa();
        //Http.enc("");
        //boolean rs = WxUser.login("redribbon");
        //System.out.println(rs);
    }

    public static synchronized int create(String community,int type,String sorttype,String name) throws SQLException
    {
        long tid = Thread.currentThread().getId();
        int lucenelist = 0;
        DbAdapter db = new DbAdapter();
        System.out.println(tid + " START");
        try
        {
            db.executeUpdate("INSERT INTO lucenelist(community,type,sorttype,hours,name)VALUES(" + DbAdapter.cite(community) + "," + type + "," + DbAdapter.cite(sorttype) + ",0," + DbAdapter.cite(name) + ")");
            lucenelist = db.getInt("SELECT MAX(lucenelist) FROM lucenelist");
        } finally
        {
            db.close();
        }
        System.out.println(tid + " OK");
        return lucenelist;

    }


    public static void aa() throws IOException
    {
        String cookie = "Sun, 27 Apr 2014 07:27:38 GMT; ptui_loginuin=122518649; o_cookie=122518649; ptcz=bf4de0682841858072d914182a19267746aa8cc2b73adb63967de147436593dc; pt2gguin=o0122518649; pgv_info=ssid=s6241980464; ts_refer=www.baidu.com/s; pgv_pvid=8891771176; ts_uid=293025771; webwxuvid=1051403101; mm_lang=zh_CN; wxstaytime=1395991493; wxpluginkey=1395968176; wxuin=805905780; wxsid=YgvLNk5ZEoAscKRB; 1252057454=; slave_user=gh_9f2f0a42c3f9; slave_sid=UHdVbUh6ZjlLaGRCTWNWN05na3RaVjhqYlE2M21RX2NTemVtQ1ZGZjJ4UlpMX1d2T2JVTkNJb25CTGlsb0pQZlBKTWJ1djF1STBxaW1UUmdGSjZia2dVa1NybXBsWE9McEh4eTVmR0lfNEd6clZlZmlhdGsxaXhva0tCM2ppYkQ=; bizuin=2390204560";
        StringBuilder sb = new StringBuilder();
        int j = 3;
        sb.append("AppMsgId=&count=" + j);
        for(int i = 0;i < j;i++)
        {
            sb.append("&title" + i + "=title0"); //标题
            sb.append("&content" + i + "=content0"); //正文
            sb.append("&digest" + i + "=digest0"); //摘要
            sb.append("&author" + i + "=author0"); //作者（选填）
            sb.append("&fileid" + i + "=200093011"); //封面图片
            sb.append("&show_cover_pic" + i + "=1"); //封面图片显示在正文中
            sb.append("&sourceurl" + i + "=http://www.so.com"); //原文链接
        }
        //sb.append("&preusername=iwlk123"); //微信号预览
        //sb.append("&imgcode=&token=111083507&lang=zh_CN&random=0.5873699218500406&f=json&ajax=1&sub=preview&t=ajax-appmsg-preview&type=10");
        sb.append("&ajax=1&token=111083507&lang=zh_CN&random=0.16165229375474155&f=json&t=ajax-response&sub=create&type=10");
        Object t = (Object) Http.open("https://mp.weixin.qq.com/cgi-bin/operate_appmsg",cookie,sb.toString().getBytes());
        System.out.println(t);
        //{"ret":"0", "msg":"OK"}
    }

    public static void send() throws IOException
    {
        String cookie = "Sun, 27 Apr 2014 07:27:38 GMT; ptui_loginuin=122518649; o_cookie=122518649; ptcz=bf4de0682841858072d914182a19267746aa8cc2b73adb63967de147436593dc; pt2gguin=o0122518649; pgv_info=ssid=s6241980464; ts_refer=www.baidu.com/s; pgv_pvid=8891771176; ts_uid=293025771; webwxuvid=1051403101; mm_lang=zh_CN; wxstaytime=1395991493; wxpluginkey=1395968176; wxuin=805905780; wxsid=YgvLNk5ZEoAscKRB; 1252057454=; slave_user=gh_9f2f0a42c3f9; slave_sid=UHdVbUh6ZjlLaGRCTWNWN05na3RaVjhqYlE2M21RX2NTemVtQ1ZGZjJ4UlpMX1d2T2JVTkNJb25CTGlsb0pQZlBKTWJ1djF1STBxaW1UUmdGSjZia2dVa1NybXBsWE9McEh4eTVmR0lfNEd6clZlZmlhdGsxaXhva0tCM2ppYkQ=; bizuin=2390204560";
        StringBuilder sb = new StringBuilder();
        sb.append("type=10&appmsgid=200225451&sex=0&groupid=-1&synctxweibo=0&synctxnews=0&country=&province=&city=&imgcode=&token=1524896568&lang=zh_CN&random=0.31721752299927175&f=json&ajax=1&t=ajax-response");
        Object t = (Object) Http.open("https://mp.weixin.qq.com/cgi-bin/masssend",cookie,sb.toString().getBytes());
        System.out.println(t);
    }
}
//
