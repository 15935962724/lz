package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import jxl.WorkbookSettings;
import jxl.*;
import jxl.biff.*;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifDirectory;
import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.metadata.MetadataException;
import net.mietian.convert.*;

//107
//第二次导入: 开始节点号：1829836
public class Infrared extends Entity
{
    public int node;
    public int language = 1;
    public int aid;
    public int typeid;
    public int redirecturl; //跳转网址
    public int templet;
    public String userip;
    public String wzjdr; //物种鉴定人
    public String remark; //备注说明
    public String pname; //照片名称
    public Date pstime; //拍摄时间==Node.StartTime
    public static String[] INFRARED_TYPE =
            {"---","A 鸟类","B 兽类"};
    public int type; //对象类别
    public String wzname; //物种名称==NodeLayer.Subject
    public String num; //动物数量
    public static String[] GENDER_TYPE =
            {"---","A 雌","B 雄","C 雌雄都有","D 难以辨认"};
    public int gender; //动物性别
    public String remark2; //备注
    public String bswdnum; //布设位点编号
    public String camnum; //相机编号
    public String sdnum; //存储卡编号
    public int picturesum; //
    public String thedate; //日期
    public String weather; //天气
    public String storagetime; //放置时间
    public int reserve;
    public String placenames; //小地名
    public String participants; //参加人员
    public String fillin; //填表人
    public String eastlongitude; //东经
    public String northlatitude; //北纬
    public float poster; //海拔/米
    public int slope; //坡度
    public String slopedirection; //坡向
    public String sjlx; //生境类型
    public String slqy; //森林起源
    public String xsj; //小生境
    public float qmgd; //乔木高度/米
    public float ybd; //郁闭度
    public int xj; //胸径/cm
    public String yssz; //优势树种
    public float gmgd; //灌木高度/米
    public float gmymd; //灌木郁闭度
    public String grlx; //干扰类型
    public String grqd; //干扰强度,C、弱
    public String grpl; //干扰频率,C、很少
    public String animalnameone; //动物名称1
    public String hjlxone; //痕迹类型1,B 脚印
    public String aremarkone; //备注1
    public String animalnametwo; //动物名称2
    public String hjlxtwo; //痕迹类型2
    public String aremarktwo; //备注2
    public String animalnamethree; //动物名称3
    public String hjlxthree; //痕迹类型3
    public String aremarkthree; //备注3
    public String animalnamefour; //动物名称4
    public String hjlxfour; //痕迹类型4
    public String aremarkfour; //备注4
    public String animalnamefive; //动物名称5
    public String hjlxfive; //痕迹类型5
    public String aremarkfive; //备注5
    public String remarkend; //备注
    public String bhqname; //自然保护区名称
    public String bhqnum; //自然保护区编号
    public String picture; //最终编号
    public int pagestyle; //表现方式
    public String imgurls;
    public int isrm;
    public String body;
	private String __private;
	protected String __protected;
    //

    public Infrared(int node)
    {
        this.node = node;
    }

    public static Infrared find(int node) throws SQLException
    {
        Infrared t = (Infrared) _cache.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new Infrared(node) : (Infrared) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,language,aid,typeid,redirecturl,templet,userip,wzjdr,remark,pname,pstime,type,wzname,num,gender,remark2,bswdnum,camnum,sdnum,picturesum,thedate,weather,storagetime,reserve,placenames,participants,fillin,eastlongitude,northlatitude,poster,slope,slopedirection,sjlx,slqy,xsj,qmgd,ybd,xj,yssz,gmgd,gmymd,grlx,grqd,grpl,animalnameone,hjlxone,aremarkone,animalnametwo,hjlxtwo,aremarktwo,animalnamethree,hjlxthree,aremarkthree,animalnamefour,hjlxfour,aremarkfour,animalnamefive,hjlxfive,aremarkfive,remarkend,bhqname,bhqnum,picture,pagestyle,imgurls,isrm,body FROM infrared WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Infrared t = new Infrared(rs.getInt(i++));
                t.language = rs.getInt(i++);
                t.aid = rs.getInt(i++);
                t.typeid = rs.getInt(i++);
                t.redirecturl = rs.getInt(i++);
                t.templet = rs.getInt(i++);
                t.userip = rs.getString(i++);
                t.wzjdr = rs.getString(i++);
                t.remark = rs.getString(i++);
                t.pname = rs.getString(i++);
                t.pstime = db.getDate(i++);
                t.type = rs.getInt(i++);
                t.wzname = rs.getString(i++);
                t.num = rs.getString(i++);
                t.gender = rs.getInt(i++);
                t.remark2 = rs.getString(i++);
                t.bswdnum = rs.getString(i++);
                t.camnum = rs.getString(i++);
                t.sdnum = rs.getString(i++);
                t.picturesum = rs.getInt(i++);
                t.thedate = rs.getString(i++);
                t.weather = rs.getString(i++);
                t.storagetime = rs.getString(i++);
                t.reserve = rs.getInt(i++);
                t.placenames = rs.getString(i++);
                t.participants = rs.getString(i++);
                t.fillin = rs.getString(i++);
                t.eastlongitude = rs.getString(i++);
                t.northlatitude = rs.getString(i++);
                t.poster = rs.getFloat(i++);
                t.slope = rs.getInt(i++);
                t.slopedirection = rs.getString(i++);
                t.sjlx = rs.getString(i++);
                t.slqy = rs.getString(i++);
                t.xsj = rs.getString(i++);
                t.qmgd = rs.getFloat(i++);
                t.ybd = rs.getFloat(i++);
                t.xj = rs.getInt(i++);
                t.yssz = rs.getString(i++);
                t.gmgd = rs.getFloat(i++);
                t.gmymd = rs.getFloat(i++);
                t.grlx = rs.getString(i++);
                t.grqd = rs.getString(i++);
                t.grpl = rs.getString(i++);
                t.animalnameone = rs.getString(i++);
                t.hjlxone = rs.getString(i++);
                t.aremarkone = rs.getString(i++);
                t.animalnametwo = rs.getString(i++);
                t.hjlxtwo = rs.getString(i++);
                t.aremarktwo = rs.getString(i++);
                t.animalnamethree = rs.getString(i++);
                t.hjlxthree = rs.getString(i++);
                t.aremarkthree = rs.getString(i++);
                t.animalnamefour = rs.getString(i++);
                t.hjlxfour = rs.getString(i++);
                t.aremarkfour = rs.getString(i++);
                t.animalnamefive = rs.getString(i++);
                t.hjlxfive = rs.getString(i++);
                t.aremarkfive = rs.getString(i++);
                t.remarkend = rs.getString(i++);
                t.bhqname = rs.getString(i++);
                t.bhqnum = rs.getString(i++);
                t.picture = rs.getString(i++);
                t.pagestyle = rs.getInt(i++);
                t.imgurls = rs.getString(i++);
                t.isrm = rs.getInt(i++);
                t.body = rs.getString(i++);
                _cache.put(t.node,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM infrared WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO infrared(node,language,aid,typeid,redirecturl,templet,userip,wzjdr,remark,pname,pstime,type,wzname,num,gender,remark2,bswdnum,camnum,sdnum,picturesum,thedate,weather,storagetime,reserve,placenames,participants,fillin,eastlongitude,northlatitude,poster,slope,slopedirection,sjlx,slqy,xsj,qmgd,ybd,xj,yssz,gmgd,gmymd,grlx,grqd,grpl,animalnameone,hjlxone,aremarkone,animalnametwo,hjlxtwo,aremarktwo,animalnamethree,hjlxthree,aremarkthree,animalnamefour,hjlxfour,aremarkfour,animalnamefive,hjlxfive,aremarkfive,remarkend,bhqname,bhqnum,picture,pagestyle,imgurls,isrm,body)VALUES(" + node + "," + language + "," + aid + "," + typeid + "," + redirecturl + "," + templet + "," + DbAdapter.cite(userip) + "," + DbAdapter.cite(wzjdr) + "," +
                                     DbAdapter.cite(remark) +
                                     "," + DbAdapter.cite(pname) + "," + DbAdapter.cite(pstime) + "," + type + "," + DbAdapter.cite(wzname) + "," + DbAdapter.cite(num) + "," + gender + "," + DbAdapter.cite(remark2) + "," + DbAdapter.cite(bswdnum) + ","
                                     + DbAdapter.cite(camnum) + "," + DbAdapter.cite(sdnum) + "," + picturesum + "," + DbAdapter.cite(thedate) + "," + DbAdapter.cite(weather) + "," + DbAdapter.cite(storagetime) + "," + reserve + "," + DbAdapter.cite(placenames) + "," + DbAdapter.cite(participants) + "," + DbAdapter.cite(fillin) + "," + DbAdapter.cite(eastlongitude) + "," + DbAdapter.cite(northlatitude) + "," + poster + "," + slope + "," + DbAdapter.cite(slopedirection) + "," + DbAdapter.cite(sjlx) + "," + DbAdapter.cite(slqy) + "," + DbAdapter.cite(xsj) + "," + qmgd + "," + ybd + "," + xj + "," + DbAdapter.cite(yssz) + "," + gmgd + "," + gmymd + "," + DbAdapter.cite(grlx) + "," + DbAdapter.cite(grqd) + "," + DbAdapter.cite(grpl) + "," + DbAdapter.cite(animalnameone) + "," +
                                     DbAdapter.cite(hjlxone) + "," + DbAdapter.cite(aremarkone) + "," + DbAdapter.cite(animalnametwo) + "," + DbAdapter.cite(hjlxtwo) + "," + DbAdapter.cite(aremarktwo) + "," + DbAdapter.cite(animalnamethree) + "," + DbAdapter.cite(hjlxthree) + "," + DbAdapter.cite(aremarkthree) +
                                     "," + DbAdapter.cite(animalnamefour) + "," + DbAdapter.cite(hjlxfour) + "," + DbAdapter.cite(aremarkfour) + "," + DbAdapter.cite(animalnamefive) + "," + DbAdapter.cite(hjlxfive) + "," + DbAdapter.cite(aremarkfive) + "," + DbAdapter.cite(remarkend) + "," + DbAdapter.cite(bhqname) + "," + DbAdapter.cite(bhqnum) + "," + DbAdapter.cite(picture) + "," + pagestyle + "," + DbAdapter.cite(imgurls) + "," + isrm + "," + DbAdapter.cite(body) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE infrared SET aid=" + aid + ",typeid=" + typeid + ",redirecturl=" + redirecturl + ",templet=" + templet + ",userip=" + DbAdapter.cite(userip) + ",wzjdr=" + DbAdapter.cite(wzjdr) + ",remark=" + DbAdapter.cite(remark) + ",pname=" + DbAdapter.cite(pname) + ",pstime=" + DbAdapter.cite(pstime) + ",type=" + type + ",wzname=" + DbAdapter.cite(wzname) + ",num=" + DbAdapter.cite(num) + ",gender=" + gender + ",remark2=" + DbAdapter.cite(remark2) + ",bswdnum=" + DbAdapter.cite(bswdnum) + ",camnum=" + DbAdapter.cite(camnum) + ",sdnum=" + DbAdapter.cite(sdnum) + ",picturesum=" + picturesum + ",thedate=" + DbAdapter.cite(thedate) + ",weather=" + DbAdapter.cite(weather) + ",storagetime=" + DbAdapter.cite(storagetime) + ",reserve=" +
                                 reserve + ",placenames=" + DbAdapter.cite(placenames) + ",participants=" + DbAdapter.cite(participants) + ",fillin=" + DbAdapter.cite(fillin) + ",eastlongitude=" + DbAdapter.cite(eastlongitude) + ",northlatitude=" + DbAdapter.cite
                                 (northlatitude) + ",poster=" + poster + ",slope=" + slope + ",slopedirection=" + DbAdapter.cite(slopedirection) + ",sjlx=" + DbAdapter.cite(sjlx) + ",slqy=" + DbAdapter.cite(slqy) + ",xsj=" + DbAdapter.cite(xsj) + ",qmgd=" + qmgd + ",ybd=" + ybd + ",xj=" + xj + ",yssz=" + DbAdapter.cite(yssz) + ",gmgd=" + gmgd + ",gmymd=" + gmymd + ",grlx=" + DbAdapter.cite(grlx) + ",grqd=" + DbAdapter.cite(grqd) + ",grpl=" + DbAdapter.cite(grpl) + ",animalnameone=" + DbAdapter.cite(animalnameone) + ",hjlxone=" + DbAdapter.cite(hjlxone) + ",aremarkone=" + DbAdapter.cite(aremarkone) + ",animalnametwo=" + DbAdapter.cite(animalnametwo) + ",hjlxtwo=" + DbAdapter.cite(hjlxtwo) + ",aremarktwo=" + DbAdapter.cite(aremarktwo) + ",animalnamethree=" +
                                 DbAdapter.cite(animalnamethree) + ",hjlxthree=" + DbAdapter.cite(hjlxthree) + ",aremarkthree=" + DbAdapter.cite(aremarkthree) + ",animalnamefour=" + DbAdapter.cite(animalnamefour) + ",hjlxfour=" + DbAdapter.cite(hjlxfour) + ",aremarkfour=" + DbAdapter.cite(aremarkfour) + ",animalnamefive="
                                 + DbAdapter.cite(animalnamefive) + ",hjlxfive=" + DbAdapter.cite(hjlxfive) + ",aremarkfive=" + DbAdapter.cite(aremarkfive) + ",remarkend=" + DbAdapter.cite(remarkend) + ",bhqname=" + DbAdapter.cite(bhqname) + ",bhqnum=" + DbAdapter.cite(bhqnum) + ",picture=" + DbAdapter.cite(picture) + ",pagestyle=" + pagestyle + ",imgurls=" + DbAdapter.cite(imgurls) + ",isrm=" + isrm + ",body=" + DbAdapter.cite(body) + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM infrared WHERE node=" + node);
        _cache.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE infrared SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        _cache.remove(node);
    }

    //
    public static String getDetail(Node n,Http h,int listing,String target) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        String subject = n.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,107,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;

            String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/infrared/" + n._nNode + "-" + h.language + ".htm";
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            //int dq = detail.getQuantity(name);
            if(name.equals("subject"))
                value = subject;
            else if(name.equals("content"))
                value = n.getText(h.language);
            else
            {
                Infrared t = Infrared.find(n._nNode);
                if(name.equals("thumbs"))
                {
                    value = t.picture;
                    if(value != null)
                    {
                        value = value.replaceFirst("TestData","170");
                        value = "<img src='/res/attch" + value.substring(0,value.length() - 3) + "jpg' />";
                    }
                } else if(name.equals("picture"))
                {
                    value = t.picture;
                    if(value != null)
                    {
                        if(value.endsWith(".flv"))
                            value = "<script>mt.embed('/tea/image/flv/CuPlayer4.swf',600,450,'CuPlayerSetFile=%2fInfrareds.do%3fact%3dplayer%26community%3d" + h.community + "%26node%3d" + t.node + "&CuPlayerPosition=top-right&CuPlayerWidth=600&CuPlayerHeight=450&CuPlayerAutoPlay=no');</script>";
                        else
                            value = "<img src='/res/attch" + value.replaceFirst("TestData","600") + "' />";
                    }
                } else if(name.equals("type"))
                {
                    value = Infrared.INFRARED_TYPE[t.type];
                } else if(name.equals("gender"))
                {
                    value = Infrared.GENDER_TYPE[t.gender];
                } else if(name.equals("reserve"))
                {
                    url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/reserve/" + t.reserve + "-" + h.language + ".htm";
                    value = "<a href='"+url+"'>"+Node.find(t.reserve).getSubject(h.language)+"</a>";
                } else
                    try
                    {
                        Object tmp = t.getClass().getField(name).get(t);
                        if(tmp != null)
                        {
                            if(tmp instanceof Date)
                                value = MT.f((Date) tmp);
                            else
                                value = tmp.toString();
                        }
                    } catch(Exception ex)
                    {
                    }
            }
            if(value == null)
                value = "";
            if(istype == 2 && value.length() < 1)
                continue;

            //限制字数
            value = detail.getOptionsToHtml(name,n,value);

            //显示连接的地方
            if(detail.getAnchor(name) != 0)
            {
                value = "<a href='" + url + "' target='" + target + "' title=\"" + subject.replace('"','\'') + "\">" + value + "</a>";
            }
            sb.append(bi).append("<span id='InfraredID" + name + "'>" + value + "</span>").append(ai);
        }
        return sb.toString();
    }

    static void find(HashMap hm,File f)
    {
        File[] fs = f.listFiles();
        for(int i = 0;i < fs.length;i++)
        {
            if(fs[i].isDirectory())
                find(hm,fs[i]);
            else
            {
                String name = fs[i].getName();
                name = name.substring(0,name.length() - 4);
                if(hm.get(name) != null)
                    System.out.println("重复：" + name);
                hm.put(name,fs[i]);
            }
        }
    }

    public static void main3(String[] args) throws Exception
    {
        System.out.println("扫描文件列表...");
        HashMap hm = new HashMap();
        find(hm,new File("D:/红外相机数据处理2012.12.4"));
        int last = 0;
        while(true)
        {
            System.out.println(last);
            Iterator it = Infrared.find(" AND node>" + last + " AND picture NOT LIKE '/TestData/infrared/%' ORDER BY node",0,1000).iterator();
            if(!it.hasNext())
                break;
            while(it.hasNext())
            {
                Infrared t = (Infrared) it.next();
                last = t.node;
                //图片更换了路径
                String old = t.picture;
                int i = t.picture.lastIndexOf('/');
                if(i != -1)
                {
                    t.picture = t.picture.substring(i + 1,t.picture.length() - 4).toUpperCase();
                }
                //
                File f = (File) hm.get(t.picture);
                if(f != null)
                {
                    t.picture = "/TestData/infrared" + f.getPath().substring(20).replace('\\','/').toLowerCase();
                    if(old.equals(t.picture))
                        continue;
                    Metadata md = JpegMetadataReader.readMetadata(f);
                    Directory exif = md.getDirectory(Class.forName("com.drew.metadata.exif.ExifDirectory"));
                    if(exif.containsTag(ExifDirectory.TAG_DATETIME))
                    {
                        t.pstime = exif.getDate(ExifDirectory.TAG_DATETIME);
                        Node.find(t.node).setStartTime(t.pstime);
                    }
                    t.set();
                }
            }
        }
    }

    public static void main(String[] args)
    {
        //System.out.println("文件：" + args[0]);
        HashMap hm = new HashMap();
        find(hm,new File("D:/红外相机20131115"));
        Workbook wb;
        try
        {
            File f = new File("D:/红外相机20131115/2010SNJ红外相机整理/2010SNJ红外相机数据整理1.xls"); //"E:/快盘/标本资源/野骆驼数据-添加字段/第一批2010.7-2011.5.xls"
            WorkbookSettings ws = new WorkbookSettings();
            ws.setCellValidationDisabled(true); //禁用数据"有效性"检查
            wb = Workbook.getWorkbook(f,ws);
            //System.out.println("导入：" + f.getPath() + " 用户：" + h.member);
        } catch(Throwable ex)
        {
            ex.printStackTrace();
            System.out.print("<script>mt.show('上传的文件格式不正确！');</script>");
            return;
        }
        //for(int j = 0;j < 20;j++)
        //    System.out.write("// 显示进度条  \n");
        Node n = Node.find(22);
        String tmp;
        try
        {
            String[] INFRARED_TYPE =
                    {"","鸟类","兽类","其它动物"};
            String[] GENDER_TYPE =
                    {"","雌","雄","雌雄都有","难以辨认"};
            Sheet s = wb.getSheet(0);
            for(int i = 1;i < s.getRows();i++)
            {
                int j = 0;
                String sync = "2013-11-21导入_" + s.getCell(8,i).getContents(); //I:picName
                Enumeration e = Node.find(" AND syncid=" + DbAdapter.cite(sync) + " AND type=107",0,1);
                int node = e.hasMoreElements() ? ((Integer) e.nextElement()).intValue() : 0;
                Infrared t = node > 0 ? Infrared.find(node) : new Infrared(0);
                System.out.println(i + "," + sync + "," + node);
                //
                tmp = s.getCell(j++,i).getContents(); //A
                t.bswdnum = s.getCell(j++,i).getContents(); //B:positionID
                t.camnum = s.getCell(j++,i).getContents(); //C:caremaID
                t.sdnum = s.getCell(j++,i).getContents(); //D:cardID
                j++;
                t.fillin = s.getCell(j++,i).getContents(); //F:downloaderName
                t.participants = s.getCell(j++,i).getContents(); //G:surveyor
                t.picturesum = Integer.parseInt(s.getCell(j++,i).getContents()); //H
                t.picture = s.getCell(j++,i).getContents(); //I:picName
                //
                DateCell dc = (DateCell) s.getCell(j++,i); //J:shootDate
                tmp = MT.f(dc.getDate());
                tmp += " " + s.getCell(j++,i).getContents(); //K:shootTime
                if(t.pstime == null)
                {
                    if(tmp.length() > 17)
                    {
                        t.pstime = Entity.sdf3.parse(tmp);
                    } else
                    {
                        t.pstime = Entity.sdf2.parse(tmp);
                    }
                }
                t.wzname = s.getCell(j++,i).getContents(); //L:speciesName
                t.num = s.getCell(j++,i).getContents(); //M:animalNum
                tmp = s.getCell(j++,i).getContents(); //N:animalSex
                t.gender = Arrayx.indexOf(GENDER_TYPE,tmp);
                if(t.gender == -1)
                {
                    System.out.println("动物性别：“" + tmp + "”不是预期值！");
                    return;
                }
                tmp = s.getCell(j++,i).getContents(); //O:objectClass
                t.type = Arrayx.indexOf(INFRARED_TYPE,tmp);
                if(t.type == -1)
                {
                    System.out.println("对象类别：“" + tmp + "”不是预期值！");
                    return;
                }
                t.placenames = s.getCell(j++,i).getContents(); //P 小地名
                t.bhqname = s.getCell(j++,i).getContents(); //Q 保护区名称
                t.reserve = Reserve.conv(t.bhqname);
                t.sjlx = s.getCell(j++,i).getContents(); //R 生境类型
                t.eastlongitude = s.getCell(j++,i).getContents(); //S
                t.northlatitude = s.getCell(j++,i).getContents(); //T
                tmp = s.getCell(j++,i).getContents(); //U 海拔/米
                if(tmp.endsWith(" m"))
                    tmp = tmp.substring(0,tmp.length() - 2);
                if(tmp.endsWith("m"))
                    tmp = tmp.substring(0,tmp.length() - 1);
                if(tmp.length() > 0)
                    t.poster = Float.parseFloat(tmp);
                //t.remark = s.getCell(j++,i).getContents(); //V

                File f = (File) hm.get(t.picture);
                //
                if(f != null)
                {
                    //t.picture = f.getPath().substring(12).replace('\\','/').toLowerCase();
                    t.picture = "/TestData/infrared/" + f.getPath().replace('\\','/').substring(3).toLowerCase();
                    if(t.pstime == null)
                        System.out.println(t.pstime + " IS NULL");
                    //Metadata md = JpegMetadataReader.readMetadata(f);
                    //Directory exif = md.getDirectory(ExifDirectory.class);
                    //t.pstime = exif.containsTag(ExifDirectory.TAG_DATETIME) ? exif.getDate(ExifDirectory.TAG_DATETIME) : null;
                    //System.out.println(MT.f(t.pstime));
                } else
                {
                    Filex.logs("infrared.txt","不存在：" + t.picture + "行：" + i);
                    System.out.print("---------" + t.picture);
                    //continue;
                }
                if(t.node < 1)
                {
                    Node.ID = Seq.SDF.format(t.pstime);
                    t.node = Node.create(n._nNode,i,n.getCommunity(),n.getCreator(),107,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),t.pstime,null,n.getTime(),n.getStyle(),n.getRoot(),n.getKroot(),n.getKroot(),sync,n.getDefaultLanguage(),t.wzname,null,null,"",null,null,0,null,null,null,null,null,null,null);
                    n.finished(t.node);
                    System.out.print("-----" + t.node + "-----");
                } else
                {
                    Node.find(t.node).setStartTime(t.pstime);
                }

                t.set();
            }
        } catch(Throwable ex)
        {
            ex.printStackTrace();
            //out.print("<script>mt.show('位置：" + name + "<br/><br/>错误：内容不正确！<br/>" + MT.f(ex.getMessage()) + "',1,'" + nexturl + "');</script>");
            return;
        }
    }

    public static void main2(String[] args)
    {
        HashMap hm = new HashMap();
        Workbook wb;
        try
        {
            File f = new File("Z:/res/attch/TestData/infrared/野骆驼/薛亚东.xls");
            WorkbookSettings ws = new WorkbookSettings();
            //ws.setCellValidationDisabled(true); //禁用数据"有效性"检查
            wb = Workbook.getWorkbook(f);
            //System.out.println("导入：" + f.getPath() + " 用户：" + h.member);
        } catch(Throwable ex)
        {
            System.out.print("<script>mt.show('上传的文件格式不正确！');</script>");
            return;
        }
        //for(int j = 0;j < 20;j++)
        //    System.out.write("// 显示进度条  \n");
        Node n = Node.find(22);
        String name = null;
        try
        {
            String[] INFRARED_TYPE =
                    {"","鸟类","兽类","其它动物"};
            String[] GENDER_TYPE =
                    {"","雌","雄","雌雄都有","难以辨认"};
            Sheet s = wb.getSheet(0);
            for(int i = 1;i < s.getRows();i++)
            {
                System.out.println(i);
                Infrared t = new Infrared(0);
                String sync = s.getCell(0,i).getContents();
                t.bswdnum = s.getCell(1,i).getContents();
                t.camnum = s.getCell(2,i).getContents();
                t.sdnum = s.getCell(3,i).getContents();
                t.fillin = s.getCell(5,i).getContents();
                t.participants = s.getCell(6,i).getContents();
                t.picture = s.getCell(8,i).getContents();
                String tmp = s.getCell(10,i).getContents();
                t.type = Arrayx.indexOf(INFRARED_TYPE,tmp);
                if(t.type == -1)
                {
                    System.out.println("对象类别：“" + tmp + "”不是预期值！");
                    return;
                }
                t.wzname = s.getCell(11,i).getContents();
                t.num = s.getCell(12,i).getContents();
                tmp = s.getCell(13,i).getContents();
                t.gender = Arrayx.indexOf(GENDER_TYPE,tmp);
                if(t.gender == -1)
                {
                    System.out.println("动物性别：“" + tmp + "”不是预期值！");
                    return;
                }
                t.num = s.getCell(13,i).getContents();
                File f = (File) hm.get(t.picture);
                //
                if(f != null)
                {
                    t.picture = f.getPath().substring(12).replace('\\','/').toLowerCase();
                    Metadata md = JpegMetadataReader.readMetadata(f);
                    Directory exif = md.getDirectory(Class.forName("com.drew.metadata.exif.ExifDirectory"));
                    t.pstime = exif.containsTag(ExifDirectory.TAG_DATETIME) ? exif.getDate(ExifDirectory.TAG_DATETIME) : null;
                    System.out.println(MT.f(t.pstime));
                }
                t.node = Node.create(n._nNode,i,n.getCommunity(),n.getCreator(),107,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),t.pstime,null,n.getTime(),n.getStyle(),n.getRoot(),n.getKroot(),n.getKroot(),"xls:" + sync,n.getDefaultLanguage(),t.wzname,null,null,"",null,null,0,null,null,null,null,null,null,null);
                n.finished(t.node);
                t.set();
            }
        } catch(Throwable ex)
        {
            ex.printStackTrace();
            //out.print("<script>mt.show('位置：" + name + "<br/><br/>错误：内容不正确！<br/>" + MT.f(ex.getMessage()) + "',1,'" + nexturl + "');</script>");
            return;
        }
    }
}
