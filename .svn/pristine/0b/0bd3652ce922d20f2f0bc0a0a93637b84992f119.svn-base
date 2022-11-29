package tea.entity.node;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

/*
 Cspecies==species1
 Class==class1
 Order==order0
 Especies==species0
 NRname==rname
 Nname==rcode


 UPDATE Specimen SET status=1 WHERE status='有花有果';
 UPDATE Specimen SET status=2 WHERE status='有花无果';
 UPDATE Specimen SET status=3 WHERE status='无花有果';
 UPDATE Specimen SET status=4 WHERE status='无花无果';
 UPDATE Specimen SET status=5 WHERE status='有孢子囊';
 UPDATE Specimen SET status=6 WHERE status='无孢子囊';

 update specimen set language=1 where language is null;
 */
//2013-07-31 导入：3856条！ SID:567680-571538
//标本 type:105
public class Specimen extends Entity
{
    public int node; //SID+300000
    public int language = 1;
    public int sid;
    public String unit; //保存单位及其标本馆
    public String bbgdm; //标本馆代码
    public String[] species = new String[2]; //物种名称
    public String class1; //纲
    public String order0; //目
    public String family; //科
    public String genus; //属
    public String[] speciesup = new String[2]; //校对后物种名称
    public String mutation; //种下名称
    public String snumber; //标本号
    public String cperson; //采集人
    public Date ctime; //采集时间=Node.starttime
    public String cnumber; //采集号
    public String csite; //采集地（保护区小地名）
    public int reserve;
    public String rname; //保护区名称
    public String rcode; //保护区代码
    public String country; //国家
    public String province; //省
    public double lon; //经度
    public double lat; //纬度
    public String longitude; //经度
    public String latitude; //纬度
    public String elevation; //海拔
    public String vegetation; //植被类型
    public String environment; //生境
    public String host; //寄主
    public String sexual; //性别
    public String old; //年龄
    public String property; //标本属性
    public static final String[] SPECIMEN_TYPE =
            {"---","有花有果","有花无果","无花有果","无花无果","有孢子囊","无孢子囊"};
    public int status; //标本状态
    public String preserve; //保藏方式
    public String conlive; //实物状态
    public String share; //共享方式
    public String getway; //获取途径
    public String discribe; //描述
    public String uuser; //用户名称
    public int uid; //用户ID
    public static final String[] SPECIES_TYPE =
            {"---","植物","动物","菌物","树木年轮、木材","林木种子"};
    public int speciestype; //物种类型
    public Date enterdbdate; //标本入库时间
    public String firstlevel; //资源一级分类
    public String secondlevel; //资源二级分类
    public String zyglm; //资源归类码
    public String picture; //图片

    public Specimen(int node)
    {
        this.node = node;
    }

    public static Specimen find(int node) throws SQLException
    {
        Specimen t = (Specimen) _cache.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new Specimen(node) : (Specimen) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,sid,unit,bbgdm,species1,class1,order0,family,genus,species0,speciesup1,speciesup0,mutation,snumber,cperson,ctime,cnumber,csite,reserve,rname,rcode,country,province,lon,lat,longitude,latitude,elevation,vegetation,environment,host,sexual,old,property,status,preserve,conlive,share,getway,discribe,uuser,uid,speciestype,enterdbdate,firstlevel,secondlevel,zyglm,picture FROM specimen WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Specimen t = new Specimen(rs.getInt(i++));
                t.sid = rs.getInt(i++);
                t.unit = rs.getString(i++);
                t.bbgdm = rs.getString(i++);
                t.species[1] = rs.getString(i++);
                t.class1 = rs.getString(i++);
                t.order0 = rs.getString(i++);
                t.family = rs.getString(i++);
                t.genus = rs.getString(i++);
                t.species[0] = rs.getString(i++);
                t.speciesup[1] = rs.getString(i++);
                t.speciesup[0] = rs.getString(i++);
                t.mutation = rs.getString(i++);
                t.snumber = rs.getString(i++);
                t.cperson = rs.getString(i++);
                t.ctime = db.getDate(i++);
                t.cnumber = rs.getString(i++);
                t.csite = rs.getString(i++);
                t.reserve = rs.getInt(i++);
                t.rname = rs.getString(i++);
                t.rcode = rs.getString(i++);
                t.country = rs.getString(i++);
                t.province = rs.getString(i++);
                t.lon = rs.getDouble(i++);
                t.lat = rs.getDouble(i++);
                t.longitude = rs.getString(i++);
                t.latitude = rs.getString(i++);
                t.elevation = rs.getString(i++);
                t.vegetation = rs.getString(i++);
                t.environment = rs.getString(i++);
                t.host = rs.getString(i++);
                t.sexual = rs.getString(i++);
                t.old = rs.getString(i++);
                t.property = rs.getString(i++);
                t.status = rs.getInt(i++);
                t.preserve = rs.getString(i++);
                t.conlive = rs.getString(i++);
                t.share = rs.getString(i++);
                t.getway = rs.getString(i++);
                t.discribe = rs.getString(i++);
                t.uuser = rs.getString(i++);
                t.uid = rs.getInt(i++);
                t.speciestype = rs.getInt(i++);
                t.enterdbdate = db.getDate(i++);
                t.firstlevel = rs.getString(i++);
                t.secondlevel = rs.getString(i++);
                t.zyglm = rs.getString(i++);
                t.picture = rs.getString(i++);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM specimen WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int i = db.executeUpdate("INSERT INTO specimen(node,language,sid,unit,bbgdm,species1,class1,order0,family,genus,species0,speciesup1,speciesup0,mutation,snumber,cperson,ctime,cnumber,csite,reserve,rname,rcode,country,province,lon,lat,longitude,latitude,elevation,vegetation,environment,host,sexual,old,property,status,preserve,conlive,share,getway,discribe,uuser,uid,speciestype,enterdbdate,firstlevel,secondlevel,zyglm,picture)VALUES(" + node + "," + language + "," + sid + "," + DbAdapter.cite(unit) + "," + DbAdapter.cite(bbgdm) + "," + DbAdapter.cite(species[1]) + "," + DbAdapter.cite(class1) + "," + DbAdapter.cite(order0) + "," + DbAdapter.cite(family) + "," + DbAdapter.cite(genus) + "," + DbAdapter.cite(species[0]) + "," + DbAdapter.cite(speciesup[1]) + "," +
                                     DbAdapter.cite(speciesup[0]) +
                                     "," + DbAdapter.cite(mutation) + "," + DbAdapter.cite(snumber) + "," +
                                     DbAdapter.cite(cperson) + "," + DbAdapter.cite(ctime) + "," + DbAdapter.cite(cnumber) + "," + DbAdapter.cite(csite) + "," + reserve + "," + DbAdapter.cite(rname) + "," + DbAdapter.cite(rcode) + "," + DbAdapter.cite(country) + "," + DbAdapter.cite(province) + "," + lon + "," + lat + "," + DbAdapter.cite(longitude) + "," + DbAdapter.cite(latitude) + "," + DbAdapter.cite(elevation) + "," + DbAdapter.cite(vegetation) + "," + DbAdapter.cite(environment) + "," + DbAdapter.cite(host) + "," + DbAdapter.cite(sexual) + "," + DbAdapter.cite(old) + "," + DbAdapter.cite(property) + "," + status + "," + DbAdapter.cite(preserve) + "," + DbAdapter.cite(conlive) + "," + DbAdapter.cite(share) + "," + DbAdapter.cite(getway) + "," + DbAdapter.cite(discribe) + "," +
                                     DbAdapter.cite(uuser) + "," + uid + "," + speciestype + "," +
                                     DbAdapter.cite(enterdbdate) + "," + DbAdapter.cite(firstlevel) + "," + DbAdapter.cite(secondlevel) + "," + DbAdapter.cite(zyglm) + "," + DbAdapter.cite(picture) + ")");
            if(i < 1)
            {
                db.executeUpdate("UPDATE specimen SET sid=" + sid + ",unit=" + DbAdapter.cite(unit) + ",bbgdm=" + DbAdapter.cite(bbgdm) + ",species1=" + DbAdapter.cite(species[1]) + ",class1=" + DbAdapter.cite(class1) + ",order0=" + DbAdapter.cite(order0) + ",family=" + DbAdapter.cite(family) + ",genus=" + DbAdapter.cite(genus) + ",species0=" + DbAdapter.cite(species[0]) + ",speciesup1=" + DbAdapter.cite(speciesup[1]) + ",speciesup0=" + DbAdapter.cite(speciesup[0]) + ",mutation=" + DbAdapter.cite(mutation) + ",snumber=" + DbAdapter.cite(snumber) + ",cperson=" + DbAdapter.cite(cperson) + ",ctime=" + DbAdapter.cite(ctime) + ",cnumber=" + DbAdapter.cite(cnumber) + ",csite=" + DbAdapter.cite(csite) + ",reserve=" + reserve + ",rname=" + DbAdapter.cite(rname) + ",rcode=" + DbAdapter.cite(rcode) +
                                 ",country=" + DbAdapter.cite(country) + ",province=" + DbAdapter.cite(province) +
                                 ",lon=" + lon + ",lat=" + lat + ",longitude=" + DbAdapter.cite(longitude) + ",latitude=" + DbAdapter.cite(latitude) + ",elevation=" + DbAdapter.cite(elevation) + ",vegetation=" + DbAdapter.cite(vegetation) + ",environment=" + DbAdapter.cite(environment) + ",host=" + DbAdapter.cite(host) + ",sexual=" + DbAdapter.cite(sexual) + ",old=" + DbAdapter.cite(old) + ",property=" + DbAdapter.cite(property) + ",status=" + status + ",preserve=" + DbAdapter.cite(preserve) + ",conlive=" + DbAdapter.cite(conlive) + ",share=" + DbAdapter.cite(share) + ",getway=" + DbAdapter.cite(getway) + ",discribe=" + DbAdapter.cite(discribe) + ",uuser=" + DbAdapter.cite(uuser) + ",uid=" + uid + ",speciestype=" + speciestype + ",enterdbdate=" + DbAdapter.cite(enterdbdate) +
                                 ",firstlevel=" + DbAdapter.cite(firstlevel) +
                                 ",secondlevel=" + DbAdapter.cite(secondlevel) + ",zyglm=" + DbAdapter.cite(zyglm) + ",picture=" + DbAdapter.cite(picture) + " WHERE node=" + node);
            }
        } finally
        {
            db.close();
        }
        _cache.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM specimen WHERE node=" + node);
        _cache.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE specimen SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        _cache.remove(node);
    }

    public void set2(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE specimen SET " + f + "=" + DbAdapter.cite(v) + " WHERE sid=" + sid);
        _cache.remove(node);
    }

    //
    public static String getDetail(Node n,Http h,int listing,String target) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        String subject = n.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,105,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0 || name.startsWith("i_"))
                continue;

            String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/specimen/" + n._nNode + "-" + h.language + ".htm";
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            //int dq = detail.getQuantity(name);
            if(name.equals("subject"))
            {
                value = subject;
            } else if(name.equals("content"))
                value = n.getText(h.language);
            else if(name.equals("picture")) //第一张图
            {
                Iterator it = SPicture.find(" AND specimen=" + n._nNode,0,1).iterator();
                if(it.hasNext())
                {
                    SPicture t = (SPicture) it.next();
                    value = "<img src='/res/attch" + t.mulname.replaceFirst("TestData","600").replaceFirst("Multimedia","-") + "' />";
                } else if(istype == 1)
                {
                    value = "<img src='/res/" + n.getCommunity() + "/404.jpg' />";
                }
            } else if(name.equals("pictures")) //组图
            {
                StringBuilder sb = new StringBuilder();
                sb.append("<div><img src='/res/" + n.getCommunity() + "/404.jpg' id='preview' /></div>");
                sb.append("<div id='list'><a href='javascript:;' id='forward'></a><div id='items'>");
                Iterator it = SPicture.find(" AND specimen=" + n._nNode,0,200).iterator();
                while(it.hasNext())
                {
                    SPicture t = (SPicture) it.next();
                    sb.append("<img src='/res/attch" + t.mulname.replaceFirst("TestData","170").replaceFirst("Multimedia","-") + "' />");
                }
                sb.append("</div><a href='javascript:;' id='backward'></a></div>");
                value = sb.toString();
            } else if(name.equals("map")) //标本地图
            {
                value = "<iframe src='/jsp/type/specimen/GMapView.jsp?specimen=" + n._nNode + "' frameborder='0' scrolling='no' width='600' height='500'></iframe>";
            } else if(name.equals("identify")) //签定信息
            {
                StringBuilder sb = new StringBuilder();
                Iterator it = SIdentify.find(" AND node=" + n._nNode,0,200).iterator();
                while(it.hasNext())
                {
                    SIdentify t = (SIdentify) it.next();
                    Iterator ie = detail.keys();
                    while(ie.hasNext())
                    {
                        String iname = (String) ie.next(),ivalue = null;
                        int itype = detail.getIstype(iname);
                        if(itype == 0 || !iname.startsWith("i_"))
                            continue;
                        if("i_person".equals(iname))
                            ivalue = t.iperson;
                        else if("i_year".equals(iname))
                            ivalue = MT.f(t.iyear);
                        if(itype == 2 && MT.f(ivalue).length() < 1)
                            continue;
                        sb.append(detail.getBeforeItem(iname)).append("<span id='SpecimenID" + iname + "'>" + ivalue + "</span>").append(detail.getAfterItem(iname));
                    }
                }
                value = sb.toString();
            } else
            {
                Specimen t = Specimen.find(n._nNode);
                if(name.equals("species0"))
                    value = t.species[0];
                else if(name.equals("species1"))
                    value = t.species[1];
                else if(name.equals("rname")){
                	if (t.reserve>0) {
                		value = "<a href='/" + (h.status == 1 ? "xhtml" : "html") + "/papc/reserve/"+t.reserve+"-1.htm' >"+t.rname+"</a>";
					}else{
						value = t.rname;
					}
                    
                }else if(name.equals("speciesup0"))
                    value = t.speciesup[0];
                else if(name.equals("speciesup1"))
                    value = t.speciesup[1];
                else if(name.equals("status"))
                    value = SPECIMEN_TYPE[t.status];
                else if(name.equals("speciestype"))
                    value = SPECIES_TYPE[t.speciestype];
                else
                    try
                    {
                        Object tmp = Class.forName("tea.entity.node.Specimen").getField(name).get(t);
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
            htm.append(bi).append("<span id='SpecimenID" + name + "'>" + value + "</span>").append(ai);
        }
        return htm.toString();
    }

    public String imp() throws SQLException
    {
    	DateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    	String msg="";
        Enumeration e = Node.find(" AND n.type=1 AND n.path LIKE '" + Node.find(21).getPath() + "%' AND nl.subject=" + DbAdapter.cite(secondlevel),0,1);
        int father = e.hasMoreElements() ? ((Integer) e.nextElement()).intValue() : 36;

        Node n = Node.find(father);
        Category cat = Category.find(father); //105
        int options1 = n.getOptions1();
        if(node<1){
        	node = Node.create(father,0,n.getCommunity(),n.getCreator(),cat.getCategory(),(options1 & 2) != 0,n.getOptions(),options1,n.getDefaultLanguage(),ctime,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,n.getDefaultLanguage(),species[1],"","",null,null,"",0,null,"","","","",null,null);
            n.finished(node);
            set2("node",String.valueOf(node));
            msg="Sid:" + sid + " ^-^ 导入成功。。  节点为:" + node;
            System.out.println(msg);
            Filex.logs("impSpecimen"+sdf.format(new Date())+".txt", msg);
        }else{
        	msg="Sid:" + sid + " ^-^SID已存在    节点为:" + node;
        	Filex.logs("impSpecimen"+sdf.format(new Date())+".txt", msg);
        }

        if(longitude.startsWith("N"))
        {
            lon = Double.parseDouble(longitude.substring(1));
            set("lon",String.valueOf(lon));
        }
        if(latitude.startsWith("E"))
        {
            lat = Double.parseDouble(latitude.substring(1));
            set("lat",String.valueOf(lat));
        }
        Iterator it = Reserve.find(" AND code=" + DbAdapter.cite(rcode),0,1).iterator();
        if(it.hasNext())
        {
            Reserve r = (Reserve) it.next();
            set("reserve",String.valueOf(reserve = r.node));
        }
        set();
        return msg;
    }
}
