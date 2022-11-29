package tea.entity.node;

import java.io.*;
import java.sql.*;
import java.util.*;
import tea.db.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.admin.orthonline.NodePoints;
import tea.entity.site.Community;
import tea.html.*;
import tea.resource.*;
import tea.entity.convert.*;

public class Files extends Entity
{
    public static Cache _cache = new Cache(100);
    private int node;
    private int language;
    private int classes; //一级类型
    private int classesc; //二级类型
    private String code; //课件编号
    private String name; //课件名称
    private String namepath; //课件路径
    private String keyword; //关键字
    public int filesize; //课件大小
    private int grade; //课件评价
    private int pointlimit; //积分限制
    private String author; //课件作者
    private String linkurl; //课件来源
    private String note; //备注
    private int hits; //下载次数
    private int filecheckbox; //判断是否选择上传还是 填写路径
    public boolean pconv; //是否转换
    public int pcount; //页数
    public int toolbar; //工具栏
    public int pwidth; //页宽
    public int pheight; //页高
    public boolean outline; //拆分
    public boolean copy; //复制
    public boolean prints; //打印
    public String ptext; //文件内容
    
    private String unitname;  //作者所属部门名称
    
    private boolean exists;

    public static final String GRADE[] =
            {"不评级","★","★★","★★★","★★★★","★★★★★"}; //{"不评级","★★★★★","★★★★","★★★","★★","★"};


    public Files(int node,int language)
    {
        this.node = node;
        this.language = language;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node,language,classes,classesc,code,name,keyword,filesize,grade,pointlimit,author,linkurl,note,hits,namepath,filecheckbox,pconv,pcount,toolbar,pwidth,pheight,outline,copy,prints,ptext,unitname FROM Files WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                Files t = new Files(db.getInt(j++),db.getInt(j++));
                t.classes = db.getInt(j++);
                t.classesc = db.getInt(j++);
                t.code = db.getString(j++);
                t.name = db.getVarchar(1,t.language,j++);
                t.keyword = db.getVarchar(1,t.language,j++);
                t.filesize = db.getInt(j++);
                t.grade = db.getInt(j++);
                t.pointlimit = db.getInt(j++);
                t.author = db.getVarchar(1,t.language,j++);
                t.linkurl = db.getVarchar(1,t.language,j++);
                t.note = db.getText(1,t.language,j++);
                t.hits = db.getInt(j++);
                t.namepath = db.getString(j++);
                t.filecheckbox = db.getInt(j++);
                t.pconv = db.getInt(j++) != 0;
                t.pcount = db.getInt(j++);
                t.toolbar = db.getInt(j++);
                t.pwidth = db.getInt(j++);
                t.pheight = db.getInt(j++);
                t.outline = db.getInt(j++) != 0;
                t.copy = db.getInt(j++) != 0;
                t.prints = db.getInt(j++) != 0;
                t.ptext = db.getText(j++);
                t.unitname = db.getString(j++);
                t.exists = true;
                _cache.put(t.node + ":" + t.language,t);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Files WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
    }

    public static Files find(int node,int language) throws SQLException
    {
        Files t = (Files) _cache.get(node + ":" + language);
        if(t == null)
        {
            ArrayList al = find(" AND node=" + node + " AND language=" + language,0,1);
            t = al.size() < 1 ? new Files(node,language) : (Files) al.get(0);
        }
        return t;
    }

    public void set(int classes,int classesc,String code,String name,String keyword,int filesize,int grade,int pointlimit,String author,String linkurl,String note,String namepath,int filecheckbox,boolean pconv,boolean outline,boolean copy,boolean prints,int pcount,int toolbar,String unitname) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(node,"UPDATE Files SET classes=" + classes + ",classesc=" + classesc + ",code=" + DbAdapter.cite(code) + ",name=" + DbAdapter.cite(name) + "," + " keyword=" + db.cite(keyword) + ",filesize=" + filesize + ",grade=" + grade + ",pointlimit=" + pointlimit + ", author=" + DbAdapter.cite(author) + ",linkurl=" + DbAdapter.cite(linkurl) + ",note=" + DbAdapter.cite(note) + ",namepath=" + db.cite(namepath) + ",filecheckbox=" + filecheckbox + ",pconv=" + DbAdapter.cite(pconv) + ",outline=" + DbAdapter.cite(outline) + ",copy=" + DbAdapter.cite(copy) + ",prints=" + DbAdapter.cite(prints) + ",pcount=" + pcount + ",toolbar=" + toolbar +",unitname="+DbAdapter.cite(unitname) + " WHERE node=" + node + " AND language=" + language);
            if(j < 1)
            {
                db.executeUpdate(node,"INSERT INTO Files(node,language,classes,classesc,code,name,keyword,filesize,grade,pointlimit,author,linkurl,note,hits,namepath,filecheckbox,pconv,outline,copy,prints,pcount,toolbar,unitname)VALUES (" + node + "," + language + "," + classes + "," + classesc + " ," + DbAdapter.cite(code) + "," + DbAdapter.cite(name) + "," + db.cite(keyword) + "," + filesize + "," + grade + "," + pointlimit + "," + DbAdapter.cite(author) + " ," + DbAdapter.cite(linkurl) + "," + DbAdapter.cite(note) + ",0," + db.cite(namepath) + "," + filecheckbox + "," + DbAdapter.cite(pconv) + "," + DbAdapter.cite(outline) + "," + DbAdapter.cite(copy) + "," + DbAdapter.cite(prints) + "," + pcount + "," + toolbar +","+DbAdapter.cite(unitname) + ")");
            }
        } finally
        {
            db.close();
        }
        this.classes = classes;
        this.classesc = classesc;
        this.code = code;
        this.name = name;
        this.keyword = keyword;
        this.filesize = filesize;
        this.grade = grade;
        this.pointlimit = pointlimit;
        this.author = author;
        this.linkurl = linkurl;
        this.note = note;
        this.namepath = namepath;
        this.filecheckbox = filecheckbox;
        this.pconv = pconv;
        this.outline = outline;
        this.copy = copy;
        this.prints = prints;
        this.toolbar = toolbar;
        this.unitname = unitname;
        this.exists = true;
        _cache.clear();
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"UPDATE Files SET pcount=" + pcount + ",toolbar=" + toolbar + ",pwidth=" + pwidth + ",pheight=" + pheight + ",ptext=" + DbAdapter.cite(ptext) + ",outline=" + DbAdapter.cite(outline) + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
    }

    public void setHits(int hits) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"UPDATE Files SET hits=" + hits + " WHERE node=" + node + " AND language=" + language);
        } finally
        {
            db.close();
        }
        this.hits = hits;
    }

    public static String getDetail(Node obj,int listing,Http h,String target) throws SQLException,IOException
    {
        StringBuilder sb = new StringBuilder();
        int node = obj._nNode;
        Node nobj = Node.find(node);
        ListingDetail detail = ListingDetail.find(listing,41,h.language);
        java.util.Iterator e = detail.keys();
        String _strTitle = nobj.getSubject(h.language);
        while(e.hasNext())
        {
            String iname = (String) e.next(),value = null;
            int istype = detail.getIstype(iname);
            if(istype == 0)
            {
                continue;
            }
            if(iname.equals("subject"))
            {
                value = obj.getSubject(h.language);
            } else if(iname.equals("text"))
            {
                value = obj.getText(h.language);
            } else if(iname.equals("picture"))
            {
                value = obj.getPicture(h.language);
                if(value != null && value.length() > 0)
                    value = "<img src='" + value + "' />";
            } else if(iname.equals("voice"))
            {
                String str = obj.getVoice(h.language);
                value = (str != null && str.length() > 0) ? "<object style='display:none' classid='CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6' codebase='http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,4,7,1112'><param name='url' value='" + str + "'><param name='autoStart' value='true'><param name='playCount' value='0'></object>" : "";
            } else if(iname.equals("fathername"))
            {
                Node father = Node.find(nobj.getFather());
                value = father.getSubject(h.language);
            } else if(iname.equals("down"))
            {
                value = "<a href='/Filess.do?act=down&node=" + node + "'>下载</a>";
            } else
            {
                Files fs = Files.find(obj._nNode,h.language);
                if(iname.equals("classes"))
                {
                    if(fs.getClasses() > 0)
                    {
                        Classes cobj = Classes.find(fs.getClasses());
                        value = "<span id =\"classes1\">" + cobj.getName() + "</span>";
                        if(fs.getClassesc() > 0)
                        {
                            ClassesChild cobj2 = ClassesChild.find(fs.getClassesc());
                            value = value + "<span id =\"classes2\" >" + cobj2.getName() + "</span>";
                        }
                    }
                } else if(iname.equals("code"))
                {
                    value = fs.getCode();
                } else if(iname.equals("keyword"))
                {
                    value = fs.getKeyword();
                } else if(iname.equals("filesize"))
                {
                    value = MT.f(fs.filesize / 1024,2) + "KB";
                } else if(iname.equals("grade"))
                {
                    value = (Files.GRADE[fs.getGrade()]);
                } else if(iname.equals("pointlimit"))
                {
                    value = String.valueOf(fs.getPointlimit());
                } else if(iname.equals("file"))
                {
                    value = fs.getName();
                } else if(iname.equals("author"))
                {
                    value = fs.getAuthor();
                } else if(iname.equals("unitname"))
                {
                    value = fs.getUnitname();
                }else if(iname.equals("linkurl"))
                {
                    value = fs.getLinkurl();
                } else if(iname.equals("note"))
                {
                    value = fs.getNote();
                } //else if(iname.equals("issue"))
                // {
                //value = obj.getTimeToString();
                //}
                else if(iname.equals("download"))
                {
                    // value = "<a id='FileIDDown' href='/servlet/FileDownload?node=" + node + "&amp;language=" + h.language + "'>下载课件</a>";
                    if(fs.namepath != null && fs.namepath.length() > 0)
                    {

                        // String a =";/servlet/EditFile?node="+node+"&act=Dowfile
                        // value = "<a id='FileIDDown' href='/jsp/type/files/Dowfile.jsp?node="+node+"'>下载课件</a>";
                        NodePoints np = NodePoints.get(node);

                        if(Files.find(node,h.language).pconv)
                        {
                            value = "<a id ='FileIDShow' href='/html/" + h.community + "/files/" + node + "-1.htm');>在线播放</a> ";
                            //value = "<a id ='FileIDShow' href='###'  onclick=window.open('/jsp/type/files/Showfile.jsp?community=" + obj.getCommunity() + "&Node=" + node + "','_blank','height=450,width=600,menubar=no,scrollbars=no,resizable=no,location=no,status=no');>在线播放</a> ";
                            if(Community.find(nobj.getCommunity()).getIscheck() != null && Community.find(nobj.getCommunity()).getIscheck().indexOf("/3/") != -1)
                            {
                                value = "<a id ='FileIDShow' href='###' onclick=if(confirm('播放此文件件将扣除积分" + np.getLlwz() + "分,是否播放?'))window.open('/jsp/type/files/Showfile.jsp?community=" + obj.getCommunity() + "&Node=" + node + "','_blank','height=450,width=600,menubar=no,scrollbars=no,resizable=no,location=no,status=no');>在线播放</a> ";
                            }

                            if(Community.find(nobj.getCommunity()).getIscheck() != null && Community.find(nobj.getCommunity()).getIscheck().indexOf("/3/") != -1)
                            {
                                value += "&nbsp;&nbsp;<a id ='FileIDDown' href='###' onclick=if(confirm('下载此文件将扣除积分" + np.getXzzy() + "分,是否下载?'))window.open('/jsp/type/files/Dowfile.jsp?community=" + obj.getCommunity() + "&Node=" + node + "','_self');>下载课件</a> ";

                            } else

                            {
                                value += "&nbsp;&nbsp;<a id ='FileIDDown' href='###' onclick=window.open('/jsp/include/DownFile.jsp?uri=" + java.net.URLEncoder.encode(fs.namepath,"UTF-8") + "&name=" + java.net.URLEncoder.encode(fs.name,"UTF-8") + "','_self');>下载课件</a> ";
                            }
                        }

                        //	value ="<a  id ='FileIDDown'"
                        //window.showModalDialog('/jsp/add/AddToFavorite_1.jsp?Node=" + _nNode + "',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:800px;dialogHeight:700px;');";


//                   if(namepath.indexOf("http://") == 0)
//                   {
//                       String a = "http://hnny.skycn.com/down/DGen310412.zip";
//                       value = "<a id='FileIDDown' href='" + a + "'>下载课件</a>";
//                   } else
//                   {
//                       value = "<a id='FileIDDown' href='/jsp/include/DownFile.jsp?uri=" + java.net.URLEncoder.encode(this.namepath,"UTF-8") + "&name=" + java.net.URLEncoder.encode(name,"UTF-8") + "'>下载课件</a>";
//                   }
                    }
                } else if(iname.equals("hits"))
                {
                    value = String.valueOf(fs.getHits());
                } else if(iname.equals("read"))
                {
                    value = fs.pconv ? "<script>edn.paper(" + node + "," + fs.toolbar + "," + detail.getQuantity(iname) + "," + (fs.outline ? fs.pcount : 0) + ");</script>" : "";
                }
            }
            value = detail.getOptionsToHtml(iname,nobj,value); //限制字数
            switch(detail.getAnchor(iname))
            {
            case 1: //连接到节点
                value = "<a href='" + nobj.getAnchor(h.language,h.status) + "' target='" + target + "' title=\"" + MT.f(_strTitle) + "\">" + value + "</a>";
                break;
            case 2: //连接到下载
                value = "<a href='/servlet/FileDownload?node=" + node + "&amp;language=" + h.language + "'>" + value + "</a>";
                break;
            }
            sb.append(detail.getBeforeItem(iname)).append("<span id='FileID").append(iname).append("'>").append(value).append("</span>").append(detail.getAfterItem(iname));
        }
        return sb.toString();
    }

    public String getLinkurl()
    {
        return linkurl;
    }

    public int getClasses()
    {
        return classes;
    }

    public String getCode()
    {
        return code;
    }

    public int getLanguage()
    {
        return language;
    }

    public String getName()
    {
        return name;
    }

    public int getNode()
    {
        return node;
    }

    public String getNote()
    {
        return note;
    }

    public String getAuthor()
    {
        return author;
    }

    public int getHits()
    {
        return hits;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getClassesc()
    {
        return classesc;
    }

    public int getGrade()
    {
        return grade;
    }

    public String getKeyword()
    {
        return keyword;
    }

    public int getPointlimit()
    {
        return pointlimit;
    }

    public String getNamepath()
    {
        return namepath;
    }

    public int getFilecheckbox()
    {
        return filecheckbox;
    }

    public String getUnitname() {
		return unitname;
	}

	public void setUnitname(String unitname) {
		this.unitname = unitname;
	}

	//
    static int COUNT;
    static
    {
        try
        {
            COUNT = Node.count(" AND type=41");
        } catch(SQLException ex)
        {
        }
    }

    public static void start() throws SQLException
    {
        if(COUNT < 1)
            return;
        try
        {
            ArrayList al = Files.find(" AND pconv=1 AND pcount=0 ORDER BY node",0,100);
            for(int i = 0;i < al.size();i++)
            {
                Files t = (Files) al.get(i);
                File f = new File(Http.REAL_PATH + t.getNamepath());
                long cur = System.currentTimeMillis();
                try
                {
                    Filex.logs("files.log","节点号：" + t.node + "　文件：" + f.getPath() + "　数量：" + (i + "/" + al.size()));
                    Node n = Node.find(t.node);
                    String path = "/res/" + n.getCommunity() + "/paper/" + (n._nNode / 10000) + "-" + t.language + "/";
                    new File(Http.REAL_PATH + path).mkdir();
                    path += n._nNode;
                    /*if(f.getPath().endsWith(".pdf") && !"papc".equals(n.getCommunity()))
                    {
                        Pdf2 p = new Pdf2(f);
                        p.start(new File(Http.REAL_PATH + path + "_%.swf"));
                        //
                        File mf = new File(Http.REAL_PATH + path + ".js");
                        p.start(mf);
                        t.ptext = Filex.read(mf.getPath(),"UTF-8");
                        mf.delete();
                        t.pcount = p.totalPage;
                        t.pwidth = p.width;
                        t.pheight = p.height;
                        t.outline = true;
                    } else
                    {
                        Dispatch dp = Dispatch.get(Paper.P2F,"DefaultProfile").toDispatch();
                        Dispatch.put(dp,"Skin",Paper.getSkin(n.getCommunity()));

                        Dispatch.call(Paper.P2F,"ConvertFile",f.getPath(),Http.REAL_PATH + path + ".swf");
                        if(Dispatch.call(Paper.P2F,"MetadataFileCount").getInt() > 0)
                        {
                            File mf = new File(Http.REAL_PATH + path + ".xml");
                            t.ptext = Filex.read(mf.getPath(),"UTF-8");
                            t.ptext = t.ptext.substring(87,t.ptext.length() - 19);
                            mf.delete();
                        }
                        int count = Dispatch.call(Paper.P2F,"ThumbnailFileCount").getInt();
                        Filex.logs("files.log","　缩略图：" + count + "张");
                        String pic = n.getPicture(t.language);
                        if((MT.f(pic).length() < 1 || pic.endsWith("#auto")) && count > 0)
                        {
                            n.setPicture(path + "_1.jpg#auto",t.language);
                        }
                        t.pcount = Dispatch.call(Paper.P2F,"TotalPages").getInt();
//								String ext = f.getName();
//								ext = ext.substring(ext.lastIndexOf('.') + 1).toLowerCase();
//								//bcprov-jdk15-146.jar, fontbox-1.5.0.jar, pdfbox-1.5.0.jar
//								if("pdf".equals(ext))
//								{
//									try
//									{
//										PDDocument pd = PDDocument.load(f);
//										PDFTextStripper ts = new PDFTextStripper();
//										t.ptext = ts.getText(pd);
//										pd.close();
//									} catch(NoClassDefFoundError ex)
//									{
//										//加密的pdf 要用到org/apache/commons/logging/LogFactory类
//										//ex.printStackTrace();
//									}
//								}
                    }*/
                } catch(Throwable ex)
                {
                    t.pcount = -1;
                    Filex.logs("files.log","　错误：" + ex.toString());
                }
                t.set();
                Filex.logs("files.log","　页数：" + t.pcount + "　时间：" + (System.currentTimeMillis() - cur) / 1000 + "s");
            }
        } catch(Throwable ex)
        {
            Filex.logs("files.log",ex);
        }
    }
}
