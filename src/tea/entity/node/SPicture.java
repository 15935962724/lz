package tea.entity.node;

import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;

import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifDirectory;
import com.drew.metadata.Directory;
import com.drew.imaging.jpeg.JpegMetadataReader;

//node<=20277 是错误的
//2013-07-31 导入：23123条！ PID:1-23122
//type:108
public class SPicture
{
    protected static Cache c = new Cache(50);
    public int node; //标本图片+950000
    public int pid;
    public int specimen; //标本ID
    public int reserve; //保护区
    public int sid;
    public String rname; //保护区名称
    public String species1; //中文名称==NodeLayer.subject
    public String mulname; //文件名
    public String multype; //多媒体类型
    public String keyword; //主题词==NodeLayer.keywords
    public String copyrightowner; //版权人
    public String remark; //备注==NodeLayer.content
    public String zyglm; //资源归类码
    public Date time; //拍摄时间==Node.starttime

    public SPicture(int node)
    {
        this.node = node;
    }

    public static SPicture find(int node) throws SQLException
    {
        SPicture t = (SPicture) c.get(node);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node,0,1);
            t = al.size() < 1 ? new SPicture(node) : (SPicture) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT node,pid,specimen,reserve,sid,rname,species1,mulname,multype,keyword,copyrightowner,remark,zyglm,time FROM spicture WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                SPicture t = new SPicture(rs.getInt(i++));
                t.pid = rs.getInt(i++);
                t.specimen = rs.getInt(i++);
                t.reserve = rs.getInt(i++);
                t.sid = rs.getInt(i++);
                t.rname = rs.getString(i++);
                t.species1 = rs.getString(i++);
                t.mulname = rs.getString(i++);
                t.multype = rs.getString(i++);
                t.keyword = rs.getString(i++);
                t.copyrightowner = rs.getString(i++);
                t.remark = rs.getString(i++);
                t.zyglm = rs.getString(i++);
                t.time = rs.getDate(i++);
                c.put(t.node,t);
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
        return DbAdapter.execute("SELECT COUNT(*) FROM spicture WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE spicture SET specimen=" + specimen + ",sid=" + sid + ",rname=" + DbAdapter.cite(rname) + ",species1=" + DbAdapter.cite(species1) + ",mulname=" + DbAdapter.cite(mulname) + ",multype=" + DbAdapter.cite(multype) + ",keyword=" + DbAdapter.cite(keyword) + ",copyrightowner=" + DbAdapter.cite(copyrightowner) + ",remark=" + DbAdapter.cite(remark) + ",zyglm=" + DbAdapter.cite(zyglm) + ",time=" + DbAdapter.cite(time) +",reserve="+reserve+ " WHERE node=" + node);
            if(j < 1)
                db.executeUpdate("INSERT INTO spicture(node,specimen,reserve,sid,rname,species1,mulname,multype,keyword,copyrightowner,remark,zyglm,time)VALUES(" + node + "," + specimen + "," + reserve + "," + sid + "," + DbAdapter.cite(rname) + "," + DbAdapter.cite(species1) + "," + DbAdapter.cite(mulname) + "," + DbAdapter.cite(multype) + "," + DbAdapter.cite(keyword) + "," + DbAdapter.cite(copyrightowner) + "," + DbAdapter.cite(remark) + "," + DbAdapter.cite(zyglm) + "," + DbAdapter.cite(time) + ")");
        } finally
        {
            db.close();
        }
        c.remove(node);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM spicture WHERE node=" + node);
        c.remove(node);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE spicture SET " + f + "=" + DbAdapter.cite(v) + " WHERE node=" + node);
        c.remove(node);
    }

    public void set2(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE spicture SET " + f + "=" + DbAdapter.cite(v) + " WHERE pid=" + pid);
        c.remove(node);
    }

    //
    public static String getDetail(Node n,Http h,int listing,String target) throws SQLException
    {
        StringBuilder htm = new StringBuilder();
        String subject = n.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,108,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = detail.getIstype(name);
            if(istype == 0)
                continue;

            String url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/spicture/" + n._nNode + "-" + h.language + ".htm";
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            //int dq = detail.getQuantity(name);
            if(name.equals("subject"))
                value = subject;
            else if(name.equals("keywords"))
                value = n.getKeywords(h.language);
            else if(name.equals("content"))
                value = n.getText(h.language);
            else if(name.equals("starttime"))
                value = MT.f(n.getStartTime(),1);
            else
            {
                SPicture t = SPicture.find(n._nNode);
                if(name.equals("specimen"))
                {
                    url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/specimen/" + t.specimen + "-" + h.language + ".htm";
                    value = Node.find(t.specimen).getSubject(h.language);
                } else if(name.equals("reserve"))
                {
                    url = "/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/reserve/" + t.reserve + "-" + h.language + ".htm";
                    value = Node.find(t.reserve).getSubject(h.language);
                } else if(name.equals("thumbs"))
                    value = "<img src='/res/attch" + t.mulname.replaceFirst("TestData","170").replaceFirst("Multimedia","-") + "' />";
                else if(name.equals("picture"))
                    value = "<img src='/res/attch" + t.mulname.replaceFirst("TestData","600").replaceFirst("Multimedia","-") + "' />";
                else
                    try
                    {
                        Object tmp = Class.forName("tea.entity.node.SPicture").getField(name).get(t);
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
            htm.append(bi).append("<span id='SPictureID" + name + "'>" + value + "</span>").append(ai);
        }
        return htm.toString();
    }

    public String imp() throws SQLException
    {
    	String msg="";
        if(time == null)
        {
            File f = new File(mulname);
            if(f.exists())
            {
                try
                {
                    Metadata md = JpegMetadataReader.readMetadata(f);
                    Directory exif = md.getDirectory(Class.forName("com.drew.metadata.exif.ExifDirectory"));
                    if(exif.containsTag(ExifDirectory.TAG_DATETIME))
                    {
                        time = exif.getDate(ExifDirectory.TAG_DATETIME);
                        if(time.getTime() == -62170185600000L) //0002-11-30 00:00:-62170185600000
                            time = null;
                    }
                } catch(Exception ex)
                {
                    String err = node + "," + f.getPath() + "," + ex.getMessage();
                    Filex.logs("err_pic_exif.txt",err);
                }
            }
        }
        int father = 65;
        Node n = Node.find(father);
        Category cat = Category.find(father);
        int options1 = n.getOptions1();
        Iterator it = Specimen.find(" AND sid=" + sid,0,1).iterator();
        String content="";
        if(it.hasNext())
        {
            Specimen s = (Specimen) it.next();
            specimen = s.node;
            zyglm=s.zyglm;
            time=s.ctime;
            reserve=s.reserve;
            content=s.SPECIMEN_TYPE[s.status];
            if(species1 == null)
                species1 = s.species[1];
        }

        if(node<1){
        	node = Node.create(father,0,n.getCommunity(),n.getCreator(),cat.getCategory(),(options1 & 2) != 0,n.getOptions(),options1,n.getDefaultLanguage(),time,null,new Date(),n.getStyle(),n.getRoot(),n.getKstyle(),n.getKroot(),null,n.getDefaultLanguage(),species1,keyword,"",content,null,"",0,null,"","","","",null,null);
            n.finished(node);
            set2("node",String.valueOf(node)); //mulname
            String logString="Pid:" + pid + " ^-^ 导入成功。。  节点为:" + node;
            msg=logString;
            Filex.logs("Spicture.txt", logString);
            System.out.println(logString);
        }else{
        	String logString="Pid:" + pid + " ^-^PID已存在    节点为:" + node;
        	msg=logString;
        	System.out.println();
        	Filex.logs("Spicture.txt", logString);
        }

        //
        if(mulname.length() > 2)
        {
            mulname = mulname.substring(2).replace('\\','/'); //去掉盘符
            int j = mulname.lastIndexOf('.');
            if(j != -1)
                mulname = mulname.substring(0,j) + mulname.substring(j).toLowerCase(); //扩展名转小写
        }
        //
        set();
        return msg;
    }

    /*public static void main(String[] args) throws Exception
    {
        int last = 0;
        while(true)
        {
            System.out.println(last);
            Iterator it = SPicture.find(" AND node>" + last + " AND time IS NULL ORDER BY node",0,1000).iterator();
            if(!it.hasNext())
                break;
            while(it.hasNext())
            {
                SPicture t = (SPicture) it.next();
                last = t.node;

                File f = new File("D:" + t.mulname);
                if(f.exists())
                {
                    try
                    {
                        Metadata md = JpegMetadataReader.readMetadata(f);
                        Directory exif = md.getDirectory(Class.forName("com.drew.metadata.exif.ExifDirectory"));
                        if(exif.containsTag(ExifDirectory.TAG_DATETIME))
                        {
                            Date time = exif.getDate(ExifDirectory.TAG_DATETIME);
                            if(time.getTime() != -62170185600000L) //0002-11-30 00:00:-62170185600000
                            {
                                t.time = time;
                                Node.find(t.node).setStartTime(t.time);
                                DbAdapter.execute("UPDATE spicture SET time=" + DbAdapter.cite(t.time) + " WHERE node=" + t.node);
                            }
                        }
                    } catch(Exception ex)
                    {
                        String err = t.node + "," + f.getPath() + "," + ex.getMessage();
                        Filex.logs("err_pic.txt",err);
                    }
                }
            }
        }
    }*/

}
