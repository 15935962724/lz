package tea.ui.node.type;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.ui.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.node.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Infrareds extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        response.setContentType("text/html; charset=UTF-8");
        response.setHeader("Content-Encoding","nogzip");
        Http h = new Http(request,response);
        String act = h.get("act"),nexturl = h.get("nexturl","");
        ServletContext application = this.getServletContext();
        PrintWriter out = response.getWriter();
        try
        {
            if("player".equals(act))
            {
                String ref = request.getHeader("Referer");
                if(ref == null || ref.indexOf(request.getServerName()) == -1)
                    return;
                Infrared t = Infrared.find(h.node);
                String value = "/res/attch" + Http.enc(t.picture.replaceFirst("TestData","600")).replaceAll("%2F","/");
                out.println("<content>");
                out.println("<CuPlayerFile>" + value + "</CuPlayerFile>");
                out.println("<CuPlayerImage>" + value.substring(0,value.length() - 3) + "jpg</CuPlayerImage>");
                out.println("<CuPlayerLogo>/res/" + h.community + "/logo_flv.png</CuPlayerLogo>");
                out.println("</content>");
                return;
            }
            out.println("<script>var mt=parent.mt;</script>");
            if(h.member < 1)
            {
                out.print("<script>mt.show('对不起，您还没有登陆，请先登陆！',2,'/servlet/StartLogin?node=" + h.node + "');</script>");
                return;
            }
            String info = "操作执行成功！";
            if("sequence".equals(act))
            {
                int sequence = h.getInt("sequence");
                if(sequence > 0)
                {
                    InfraredGroup ig = InfraredGroup.find(h.get("infraredgroup"));
                    ig.set("sequence",String.valueOf(ig.sequence = sequence));
                } else
                {
                    int pos = h.getInt("pos");
                    String[] arr = h.get("infraredgroups").split("[|]");
                    for(int i = 1;i < arr.length;i++)
                    {
                        InfraredGroup ig = InfraredGroup.find(Integer.parseInt(arr[i]));
                        ig.set("sequence",String.valueOf(ig.sequence = i + pos));
                    }
                    return;
                }
            } else if("gedit".equals(act))
            {
                InfraredGroup ig = InfraredGroup.find(h.getInt("infraredgroup"));
                int attch = h.getInt("picture.attch");
                if(h.getBool("clear"))
                    ig.picture = 0;
                else if(attch > 0)
                    ig.picture = attch;
                ig.time = new Date();
                ig.set();
            } else if("exp".equals(act))
            {
                //数据类型不能加“[]” ntext/text改为Memo
                String sql = "CREATE TABLE infrared" +
                             "(" +
                             "	node int NOT NULL," +
                             "	aid int NULL," +
                             "	typeid smallint NULL," +
                             "	redirecturl smallint NULL," +
                             "	templet smallint NULL," +
                             "	userip Memo  NULL," +
                             "	wzjdr varchar(100)  NULL" +
//                             "	remark ntext  NULL," +
//                             "	pname varchar(100)  NULL," +
//                             "	pstime datetime NULL," +
//                             "	type tinyint NULL," +
//                             "	wzname nvarchar(200)  NULL," +
//                             "	num varchar(10)  NULL," +
//                             "	gender tinyint NULL," +
//                             "	remark2 ntext  NULL," +
//                             "	bswdnum varchar(255)  NULL," +
//                             "	camnum varchar(100)  NULL," +
//                             "	sdnum varchar(100)  NULL," +
//                             "	thedate varchar(100)  NULL," +
//                             "	weather varchar(100)  NULL," +
//                             "	storagetime varchar(100)  NULL," +
//                             "	reserve int NULL," +
//                             "	placenames nvarchar(200)  NULL," +
//                             "	participants nvarchar(200)  NULL," +
//                             "	fillin varchar(100)  NULL," +
//                             "	eastlongitude varchar(100)  NULL," +
//                             "	northlatitude varchar(100)  NULL," +
//                             "	poster float NULL," +
//                             "	slope int NULL," +
//                             "	slopedirection varchar(10)  NULL," +
//                             "	sjlx varchar(200)  NULL," +
//                             "	slqy varchar(200)  NULL," +
//                             "	xsj varchar(200)  NULL," +
//                             "	qmgd float NULL," +
//                             "	ybd float NULL," +
//                             "	xj int NULL," +
//                             "	yssz varchar(100)  NULL," +
//                             "	gmgd float NULL," +
//                             "	gmymd float NULL," +
//                             "	grlx varchar(100)  NULL," +
//                             "	grqd varchar(20)  NULL," +
//                             "	grpl varchar(20)  NULL," +
//                             "	animalnameone varchar(255)  NULL," +
//                             "	hjlxone varchar(100)  NULL," +
//                             "	aremarkone ntext  NULL," +
//                             "	animalnametwo varchar(255)  NULL," +
//                             "	hjlxtwo varchar(100)  NULL," +
//                             "	aremarktwo ntext  NULL," +
//                             "	animalnamethree varchar(255)  NULL," +
//                             "	hjlxthree varchar(100)  NULL," +
//                             "	aremarkthree ntext  NULL," +
//                             "	animalnamefour varchar(255)  NULL," +
//                             "	hjlxfour varchar(100)  NULL," +
//                             "	aremarkfour ntext  NULL," +
//                             "	animalnamefive varchar(255)  NULL," +
//                             "	hjlxfive varchar(100)  NULL," +
//                             "	aremarkfive ntext  NULL," +
//                             "	remarkend ntext  NULL," +
//                             "	bhqname varchar(255)  NULL," +
//                             "	bhqnum varchar(100)  NULL," +
//                             "	picture image NULL," +
//                             "	pagestyle smallint NULL," +
//                             "	imgurls varchar(250)  NULL," +
//                             "	isrm smallint NULL," +
//                             "	body ntext  NULL," +
//                             "	exist bit NULL," +
//                             "	language tinyint NULL," +
//                             "	picturesum int NULL," +
//                             "  CONSTRAINT PK_infrared PRIMARY KEY CLUSTERED " +
//                             "  (" +
//                             "	  node ASC" +
//                             "  )" +
                             ")";

                DbAdapter db = new DbAdapter(3);
                try
                {
                    try
                    {
                        db.executeUpdate("DROP TABLE infrared");
                    } catch(SQLException ex1)
                    {
                    }
                    db.executeUpdate(sql);

                    int sum = Node.count(h.key);
                    Enumeration e = Node.find(h.key,0,Integer.MAX_VALUE);
                    for(int i = 1;e.hasMoreElements();i++)
                    {
                        int node = ((Integer) e.nextElement()).intValue();
                        if(i % 100 == 0)
                        {
                            out.print("<script>mt.progress(" + i + "," + sum + ");</script>");
                            out.flush();
                        }
                        Infrared t = Infrared.find(node);
                        db.executeUpdate("INSERT INTO infrared(node)VALUES(" + node + ")");
//                        db.executeUpdate("INSERT INTO infrared(node,language,aid,typeid,redirecturl,templet,userip,wzjdr,remark,pname,pstime,type,wzname,num,gender,remark2,bswdnum,camnum,sdnum,picturesum,thedate,weather,storagetime,reserve,placenames,participants,fillin,eastlongitude,northlatitude,poster,slope,slopedirection,sjlx,slqy,xsj,qmgd,ybd,xj,yssz,gmgd,gmymd,grlx,grqd,grpl,animalnameone,hjlxone,aremarkone,animalnametwo,hjlxtwo,aremarktwo,animalnamethree,hjlxthree,aremarkthree,animalnamefour,hjlxfour,aremarkfour,animalnamefive,hjlxfive,aremarkfive,remarkend,bhqname,bhqnum,picture,pagestyle,imgurls,isrm,body)VALUES(" + node + "," + t.language + "," + t.aid + "," + t.typeid + "," + t.redirecturl + "," + t.templet + "," + DbAdapter.cite(t.userip) + "," + DbAdapter.cite(t.wzjdr) + "," +
//                                         DbAdapter.cite(t.remark) +
//                                         "," + DbAdapter.cite(t.pname) + "," + DbAdapter.cite(t.pstime) + "," + t.type + "," + DbAdapter.cite(t.wzname) + "," + DbAdapter.cite(t.num) + "," + t.gender + "," + DbAdapter.cite(t.remark2) + "," + DbAdapter.cite(t.bswdnum) + ","
//                                         + DbAdapter.cite(t.camnum) + "," + DbAdapter.cite(t.sdnum) + "," + t.picturesum + "," + DbAdapter.cite(t.thedate) + "," + DbAdapter.cite(t.weather) + "," + DbAdapter.cite(t.storagetime) + "," + t.reserve + "," + DbAdapter.cite(t.placenames) + "," + DbAdapter.cite(t.participants) + "," + DbAdapter.cite(t.fillin) + "," + DbAdapter.cite(t.eastlongitude) + "," + DbAdapter.cite(t.northlatitude) + "," + t.poster + "," + t.slope + "," + DbAdapter.cite(t.slopedirection) + "," + DbAdapter.cite(t.sjlx) + "," + DbAdapter.cite(t.slqy) + "," + DbAdapter.cite(t.xsj) + "," + t.qmgd + "," + t.ybd + "," + t.xj + "," + DbAdapter.cite(t.yssz) + "," + t.gmgd + "," + t.gmymd + "," + DbAdapter.cite(t.grlx) + "," + DbAdapter.cite(t.grqd) + "," + DbAdapter.cite(t.grpl) +
//                                         "," +
//                                         DbAdapter.cite(t.animalnameone) + "," +
//                                         DbAdapter.cite(t.hjlxone) + "," + DbAdapter.cite(t.aremarkone) + "," + DbAdapter.cite(t.animalnametwo) + "," + DbAdapter.cite(t.hjlxtwo) + "," + DbAdapter.cite(t.aremarktwo) + "," + DbAdapter.cite(t.animalnamethree) + "," + DbAdapter.cite(t.hjlxthree) + "," + DbAdapter.cite(t.aremarkthree) +
//                                         "," + DbAdapter.cite(t.animalnamefour) + "," + DbAdapter.cite(t.hjlxfour) + "," + DbAdapter.cite(t.aremarkfour) + "," + DbAdapter.cite(t.animalnamefive) + "," + DbAdapter.cite(t.hjlxfive) + "," + DbAdapter.cite(t.aremarkfive) + "," + DbAdapter.cite(t.remarkend) + "," + DbAdapter.cite(t.bhqname) + "," + DbAdapter.cite(t.bhqnum) + "," + DbAdapter.cite(t.picture) + "," + t.pagestyle + "," + DbAdapter.cite(t.imgurls) + "," + t.isrm + "," + DbAdapter.cite(t.body) + ")");
                    }
                } finally
                {
                    db.close();
                }
            } else
            {
                Node n = Node.find(h.node);
                if("del".equals(act)) //删除
                {
                    n.delete(h.language);
                } else if("hidden".equals(act)) //发布
                {
                    n.setHidden(!n.isHidden());
                } else if("edit".equals(act)) //编辑
                {
                    String subject = h.get("wzname");
                    String content = h.get("content");
                    Date psdate = h.getDate("psdate");
                    if(n.getType() == 1)
                    {
                        int sequence = Node.getMaxSequence(h.node) + 10;
                        int options1 = n.getOptions1();
                        Category cat = Category.find(h.node); //103
                        h.node = Node.create(h.node,sequence,n.getCommunity(),new RV(h.username),cat.getCategory(),(options1 & 2) != 0,n.getOptions(),options1,h.language,psdate,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,h.language,subject,"","",content,null,"",0,null,"","","","",null,null);
                        n.finished(h.node);
                    } else
                    {
                        n.set(h.language,subject,content);
                        n.setStartTime(psdate);
                    }
                    Infrared t = Infrared.find(h.node);
                    //t.aid = h.getInt("aid");
                    //t.typeid = h.getInt("typeid");
                    //t.redirecturl = h.getInt("redirecturl");
                    //t.templet = h.getInt("templet");
                    //t.userip = h.get("userip");
                    t.wzjdr = h.get("wzjdr");
                    t.remark = h.get("remark");
                    t.pname = h.get("pname");
                    t.pstime = h.getDate("pstime");
                    t.type = h.getInt("type");
                    t.wzname = h.get("wzname");
                    t.num = h.get("num");
                    t.gender = h.getInt("gender");
                    t.remark2 = h.get("remark2");
                    t.bswdnum = h.get("bswdnum");
                    t.camnum = h.get("camnum");
                    t.sdnum = h.get("sdnum");
                    t.thedate = h.get("thedate");
                    t.weather = h.get("weather");
                    t.storagetime = h.get("storagetime");
                    t.placenames = h.get("placenames");
                    t.participants = h.get("participants");
                    t.fillin = h.get("fillin");
                    t.eastlongitude = h.get("eastlongitude");
                    t.northlatitude = h.get("northlatitude");
                    t.poster = h.getFloat("poster");
                    t.slope = h.getInt("slope");
                    t.slopedirection = h.get("slopedirection");
                    t.sjlx = h.get("sjlx");
                    t.slqy = h.get("slqy");
                    t.xsj = h.get("xsj");
                    t.qmgd = h.getFloat("qmgd");
                    t.ybd = h.getFloat("ybd");
                    t.xj = h.getInt("xj");
                    t.yssz = h.get("yssz");
                    t.gmgd = h.getFloat("gmgd");
                    t.gmymd = h.getFloat("gmymd");
                    t.grlx = h.get("grlx");
                    t.grqd = h.get("grqd");
                    t.grpl = h.get("grpl");
                    t.animalnameone = h.get("animalnameone");
                    t.hjlxone = h.get("hjlxone");
                    t.aremarkone = h.get("aremarkone");
                    t.animalnametwo = h.get("animalnametwo");
                    t.hjlxtwo = h.get("hjlxtwo");
                    t.aremarktwo = h.get("aremarktwo");
                    t.animalnamethree = h.get("animalnamethree");
                    t.hjlxthree = h.get("hjlxthree");
                    t.aremarkthree = h.get("aremarkthree");
                    t.animalnamefour = h.get("animalnamefour");
                    t.hjlxfour = h.get("hjlxfour");
                    t.aremarkfour = h.get("aremarkfour");
                    t.animalnamefive = h.get("animalnamefive");
                    t.hjlxfive = h.get("hjlxfive");
                    t.aremarkfive = h.get("aremarkfive");
                    t.remarkend = h.get("remarkend");
                    t.bhqname = h.get("bhqname");
                    t.bhqnum = h.get("bhqnum");
                    t.picture = h.get("picture");
                    //t.pagestyle = h.getInt("pagestyle");
                    //t.imgurls = h.get("imgurls");
                    //t.isrm = h.getInt("isrm");
                    //t.body = h.get("body");
                    t.set();

                    if(nexturl.length() < 1)
                        nexturl = "/html/infrared/" + h.node + "-" + h.language + ".htm";
                }
                TeaServlet.delete(n);
            }
            out.print("<script>mt.show('" + info + "',1,'" + nexturl + "');</script>");
        } catch(Throwable ex)
        {
            out.print("<textarea id='ta'>" + ex.toString() + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
            ex.printStackTrace();
        } finally
        {
            out.close();
        }
    }
}
