package tea.entity.photography;


import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;

import javax.imageio.ImageIO;
import tea.ui.*;
import tea.db.DbAdapter;
import tea.entity.*;
import tea.entity.Entity;
import tea.entity.admin.mov.MemberOrder;
import tea.entity.member.Profile;
import tea.entity.node.ListingDetail;
import tea.entity.node.Node;
import tea.entity.util.ZoomOut;
import tea.resource.Resource;

public class Photography extends Entity
{

    private static Cache _cache = new Cache(100);
    private Hashtable _htLayer;
    private int node;

    private int categories; //类型

    private int votenumber; //作品投票数量
    private boolean exists;
    public static final String AUDIT_TYPE[] =
            {"未审核","已审核","已拒绝","不审核"};

    public static final String CAMERABRAND_TYPE[] =
            {"Canon","Sony","Nikon","SAMSUNG","Fujifilm","OLYMPUS","Kodak","Panasonic","Ricoh","Pentax","Lycra","Hasselbald","Mamiya","Others"};
    //{"佳能","索尼","尼康","三星","富士","奥林巴斯","柯达","松下","理光","宾得","莱卡","哈苏","玛米亚","其他"};

    public int camerabrandtype; //相机品牌id

    class Layer
    {
        private String byname;
        private String camerabrand; //相机品牌名称
        private String picname; //上传文件名称
        private String picpath; //上传文件路径
        private String abbpicname; // 缩略图名称
        private String abbpicpath; // 缩略图路径
        private String auditmember; //审核人员
        private Date audittime; //审核时间
    }


    public static final String CATEGORIES_TYPE[] =
            {"人物","自然风光","城市"};

    public static Photography find(int node) throws SQLException
    {
        Photography obj = (Photography) _cache.get(new Integer(node));
        if(obj == null)
        {
            obj = new Photography(node);
            _cache.put(new Integer(node),obj);
        }
        return obj;
    }

    public Photography(int node) throws SQLException
    {
        this.node = node;
        _htLayer = new Hashtable();
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT categories,votenumber,camerabrandtype FROM Photography WHERE node=" + node);
            if(db.next())
            {
                categories = db.getInt(1);
                votenumber = db.getInt(2);
                camerabrandtype = db.getInt(3);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    private Layer getLayer(int language) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(language));
        if(layer == null)
        {
            layer = new Layer();
            int j = Node.getLanguage(node,language);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT byname,camerabrand,picname,picpath,abbpicname,abbpicpath,auditmember,audittime FROM PhotographyLayer WHERE node=" + node + " AND language=" + j);
                if(db.next())
                {
                    layer.byname = db.getString(1);
                    layer.camerabrand = db.getVarchar(j,language,2);
                    layer.picname = db.getVarchar(j,language,3);
                    layer.picpath = db.getVarchar(j,language,4);
                    layer.abbpicname = db.getText(j,language,5);
                    layer.abbpicpath = db.getText(j,language,6);
                    layer.auditmember = db.getString(7);
                    layer.audittime = db.getDate(8);
                } else
                {
                    layer.picname = "";
                    layer.picpath = "";
                    layer.abbpicname = "";
                    layer.abbpicpath = "";
                    layer.auditmember = "";
                    layer.audittime = null;
                }
            } finally
            {
                db.close();
            }
        }
        return layer;
    }


    public static void create(int node,int language,int categories,int votenumber,String byname,String camerabrand,String picname,String picpath,String abbpicname,String abbpicpath) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Photography(node,categories,votenumber)VALUES(" + node + "," + categories + "," + votenumber + ")");
            db.executeUpdate("INSERT INTO PhotographyLayer(node,language,byname,camerabrand,picname,picpath,abbpicname,abbpicpath)VALUES" +
                             "(" + node + ", " + language + ", " + DbAdapter.cite(byname) + ", " + DbAdapter.cite(camerabrand) + ", " + DbAdapter.cite(picname) + ", " + DbAdapter.cite(picpath) + "," +
                             " " + DbAdapter.cite(abbpicname) + "," + DbAdapter.cite(abbpicpath) + "   )");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(node));
    }

    public void set(int language,int categories,int votenumber,String byname,String camerabrand,String picname,String picpath,String abbpicname,String abbpicpath) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        sb.append("UPDATE PhotographyLayer SET");
        sb.append(" byname=").append(DbAdapter.cite(byname));
        sb.append(",camerabrand=").append(DbAdapter.cite(camerabrand));
        sb.append(",picname=").append(DbAdapter.cite(picname));
        sb.append(",picpath=").append(DbAdapter.cite(picpath));
        sb.append(",abbpicname=").append(DbAdapter.cite(abbpicname));
        sb.append(",abbpicpath=").append(DbAdapter.cite(abbpicpath));

        sb.append(" WHERE node=").append(node).append(" AND language=").append(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Photography SET categories=" + categories + ",votenumber=" + votenumber + "  WHERE node=" + node);
            int j = db.executeUpdate(sb.toString());
            if(j < 1)
            {

                db.executeUpdate("INSERT INTO PhotographyLayer(node,language,byname,camerabrand,picname,picpath,abbpicname,abbpicpath)VALUES" +
                                 "(" + node + ", " + language + ", " + DbAdapter.cite(byname) + ", " + DbAdapter.cite(camerabrand) + ", " + DbAdapter.cite(picname) + ", " + DbAdapter.cite(picpath) + "," +
                                 " " + DbAdapter.cite(abbpicname) + "," + DbAdapter.cite(abbpicpath) + "   )");
            }
        } finally
        {
            db.close();
        }

        this.categories = categories;
        this.votenumber = votenumber;
        _htLayer.clear();
    }


    public void set(String auditmember,Date audittime,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE PhotographyLayer SET auditmember=" + db.cite(auditmember) + " , audittime=" + db.cite(audittime) + " WHERE node=" + node + " and language= " + language);
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void setCamerabrandType(int camerabrandtype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Photography SET camerabrandtype =" + camerabrandtype + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        this.camerabrandtype = camerabrandtype;
    }


    public void delete(int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(" DELETE FROM Photography   WHERE node=" + node);
            db.executeUpdate(" DELETE FROM PhotographyLayer   WHERE node=" + node + " AND language = " + language);

        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    //修改投票数
    public void setVotenumber(int votenumber) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Photography SET votenumber=" + votenumber + " WHERE node = " + node);
        } finally
        {
            db.close();
        }
        this.votenumber = votenumber;
    }

    //复制文件
    public void copyFile(final String srcFile,final String destFile)
    {
        new Thread()
        {
            public void run()
            {
                //准备复制文件
                int byteread = 0; //读取的位数
                InputStream in = null;
                OutputStream out = null;
                try
                {
                    //打开原文件
                    in = new FileInputStream(srcFile);
                    //打开连接到目标文件的输出流
                    out = new FileOutputStream(destFile);
                    byte[] buffer = new byte[1024];
                    //一次读取1024个字节，当byteread为-1时表示文件已经读完
                    while((byteread = in.read(buffer)) != -1)
                    {
                        //将读取的字节写入输出流
                        out.write(buffer,0,byteread);
                    }
                    // System.out.println("复制单个文件" + srcFileName + "至" + destFileName + "成功！");

                } catch(Exception e)
                {
                    System.out.println("复制文件失败：" + e.getMessage());

                } finally
                {
                    //关闭输入输出流，注意先关闭输出流，再关闭输入流
                    if(out != null)
                    {
                        try
                        {
                            out.close();
                        } catch(IOException e)
                        {
                            e.printStackTrace();
                        }
                    }
                    if(in != null)
                    {
                        try
                        {
                            in.close();
                        } catch(IOException e)
                        {
                            e.printStackTrace();
                        }
                    }
                }

                //压缩
                File f = new File(destFile);
                try
                {
                    BufferedImage bi2 = ImageIO.read(f);
                    if(bi2 != null)
                    {
                        ZoomOut zo = new ZoomOut();
                        bi2 = zo.imageZoomOut(bi2,300,220);
                        ImageIO.write(bi2,"JPEG",f);
                    }

                } catch(IOException e)
                {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }

            }
        }.start();

    }

    //计算投票百分比
    public static String getPicicon(String community,int votenumber) throws SQLException
    {
        int sum = PhotographyPoll.count(community,"");

        String sb = "0%";
        float p = (float) votenumber / sum;
        java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();
        nf.setMinimumFractionDigits(0); // 小数点后保留几位
        String str = nf.format(p); // 要转化的数

        if(p > 0)
        {
            sb = str;
        }
        return sb;
    }

    //摄影会员统计
    public static String getMembericon(String community,String sql,int count) throws SQLException
    {
        int sum = MemberOrder.countMP(community," and m.verifg =1 " + sql);

        String sb = "0%";
        float p = (float) count / sum;
        java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();
        nf.setMinimumFractionDigits(0); // 小数点后保留几位
        String str = nf.format(p); // 要转化的数

        if(p > 0)
        {
            sb = str;
        }
        return sb;
    }

    //摄影列举

    public String getDetail(Node node,Http h,int listing,String target) throws SQLException
    {
        StringBuilder text = new StringBuilder();
        int _nNode = node._nNode;
        String subject = node.getSubject(h.language);
        ListingDetail detail = ListingDetail.find(listing,94,h.language);
        Resource r = new Resource("/tea/resource/Photography");
        java.util.Iterator e = detail.keys();

        while(e.hasNext())
        {
            String name = (String) e.next(),value = "";
            int istype = detail.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            String bi = detail.getBeforeItem(name),ai = detail.getAfterItem(name);
            int dq = detail.getQuantity(name);
            if("name".equals(name))
            {
                value = subject;
            } else if("byname".equals(name))
            {
                if(detail.getQuantity(name) > 0)
                {
                    try
                    {
                        value = "<a href=/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/folder/" + detail.getQuantity(name) + "-" + h.language + ".htm?member=" + java.net.URLEncoder.encode(node.getCreator().toString(),"UTF-8") + ">" + this.getByname(h.language) + "</a>";
                    } catch(UnsupportedEncodingException e1)
                    {
                        // TODO Auto-generated catch block
                        e1.printStackTrace();
                    }
                } else
                {
                    value = this.getByname(h.language);
                }

            } else if("camerabrand".equals(name))
            {

                //value = this.getCamerabrand(h.language);
                value = r.getString(h.language,Photography.CAMERABRAND_TYPE[this.getCamerabrandtype()]);
            } else if("categories".equals(name))
            {
                value = Node.find(categories).getSubject(h.language); //Photography.CATEGORIES_TYPE[this.getCategories()];
            } else if("caption".equals(name))
            {
                value = node.getText(h.language);
            } else if("picpath".equals(name))
            {
                String p = this.getPicpath(h.language);
                if(p != null && p.length() > 0)
                {
                    value = "<img  src=\"" + p + "\" />";
                } else
                {
                    value = "";
                }
            } else if("abbpicpath".equals(name))
            {
                String p = this.getAbbpicpath(h.language);
                if(p != null && p.length() > 0)
                {
                    value = "<img  src=\"" + p + "\" />";
                } else
                {
                    value = "";
                }
            } else if("member".equals(name)) //创建用户
            {
                Profile p = Profile.find(node.getCreator().toString());
                String nString = p.getLastName(h.language) + p.getFirstName(h.language);
                if(nString != null && nString.length() > 0)
                {
                    value = nString;
                } else
                {
                    value = node.getCreator().toString();
                }
            } else if("votenumber".equals(name))
            {

                value = String.valueOf(this.getVotenumber());

            } else if("vote".equals(name))
            { //投票按钮

                SimpleDateFormat sdf3 = new SimpleDateFormat("yyyyMMddHHmmss");

//				  /sdf3.format(new Date())

                value = "<input type=button value=" + r.getString(h.language,"Vote") + " onclick=f_vote('" + _nNode + "','" + sdf3.format(new Date()) + "','" + h.language + "');>";

            } else if("related".equals(name)) //作品相关
            {

                value = "<include src=\"/jsp/type/photography/PhotograpRelated.jsp?node=" + _nNode + "\"/>";

            } else if("enlargepic".equals(name)) //点击查看大图
            {
                // <a title="我的图片 " href="images/01.jpg" rel="lightbox"><img src="images/mini_01.jpg" name="picboder" width="60" height="60" border="0" id="picboder"/></a></td>



                value = "<a title=" + subject + " href=" + this.getPicpath(h.language) + "  rel=\"lightbox\">" + r.getString(h.language,"Enlarge") + " </a> "; //点击查看大图
            }
            if(value == null)
            {
                value = "";
            }
            if(istype == 2 && value.length() < 1)
            {
                continue;
            }
            String title = value.replace('"','_');

            //限制字数
            if(!"byname".equals(name))
            {
                value = detail.getOptionsToHtml(name,node,value);
            }
            //显示连接的地方
            if(detail.getAnchor(name) != 0)
            {
                value = "<a href='/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/photography/" + _nNode + "-" + h.language + ".htm' target='" + target + "' style=\"cursor:pointer\" title=\"" + subject + "\">" + value + "</a>";
            }

            text.append(bi).append("<span id='PhotographyID" + name + "'>" + value + "</span>").append(ai);

        }
        return text.toString();
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getCategories()
    {
        return categories;
    }

    public int getVotenumber()
    {
        return votenumber;
    }

    public String getByname(int lang) throws SQLException
    {
        return getLayer(lang).byname;
    }

    public String getCamerabrand(int lang) throws SQLException
    {
        return getLayer(lang).camerabrand;
    }

    public String getPicname(int lang) throws SQLException
    {
        return getLayer(lang).picname;
    }

    public String getPicpath(int lang) throws SQLException
    {
        return getLayer(lang).picpath;
    }

    public String getAbbpicname(int lang) throws SQLException
    {
        return getLayer(lang).abbpicname;
    }

    public String getAbbpicpath(int lang) throws SQLException
    {
        return getLayer(lang).abbpicpath;
    }

    public String getAuditmember(int lang) throws SQLException
    {
        return getLayer(lang).auditmember;
    }

    public Date getAudittime(int lang) throws SQLException
    {
        return getLayer(lang).audittime;
    }

    public int getCamerabrandtype()
    {
        return camerabrandtype;
    }


}
