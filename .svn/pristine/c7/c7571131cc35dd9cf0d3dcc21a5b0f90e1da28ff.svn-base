package tea.entity.bpicture;


import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class Baudit extends Entity
{
    private static Cache _cache = new Cache(100);
    private int id; ///meiyong
    private int node; //审核的对应图片 x
    private String auditmember; //审核的人
    private String community;
    private String mediaref; //Media ref. 媒体引用
    private int mediatype; // 媒体类型  上传的方式
    private Date received; //接收日期
    private int error; //错误
    private Date dateaudit; //质量检测日期
    private int passpage; //通过
    private int times; //次数
    private int status; //状态    3等待删除
    private int resubmit; //重新提交申请
    private String member; //图片的上传者
    private int zoom; //被放大过多少次.
    private String classific; //图片分类
    private int photography; //是否肖像权 1：是  2：不是        摄影图
    private int design; //是否物产权                          设计图
    private int touse; //照片/插图  1：照片 2:插图
    private int cutimg; //是否剪切图
    private int cuted; //是否修改过
    private int color; //彩色 或 是灰白
    private String basicKey; //基本关键字
    private String mainKey; //主要关键字
    private String inteKey; //综合关键字
    private String intro; //说明
    private String location; //位置
    private Date adopDate; //采用日期
    private int property; //授权类型 1：免版税  2:版权管理 3:权利保护
    private int bpseudonymid;
    private String fdoc;
    private int auditCopyright; // 图片版权审核 0：未通过  1：通过
    private int medium; //原始介质
    private int yncompression; //是否被压缩
    private boolean exists;


    public static String[] MEDIATYPE =
            {"---------","在线上传","光盘快递","图片快递"};
    public static String[] PASSPAGE =
            {"---------","通过","没通过"};
    public static String[] ERROR =
            {"---------","有错误","没有错误"};
    public static String[] STATUS =
            {"---------","失败的QC-重新媒体","其他问题"};
    public static String[] MEDIUM =
            {"请选择","数码JPG格式","数码RAW格式","35mm胶片","120胶片","4X5以上胶片"};


    public Baudit(int node) throws SQLException
    {
        this.node = node;
        load();
    }

    public static Baudit find(int node) throws SQLException
    {
//        Baudit obj = (Baudit) _cache.get(node);
//        if(obj == null)
//        {
//            obj = new Baudit(node);
//            _cache.put(node,obj);
//        }
        return new Baudit(node);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select id,node,auditmember,community,mediaref,mediatype,received,error,dateaudit,passpage,times,status,resubmit,member,zoom,classific,photography,design,touse,cutimg,cuted,basickey,mainkey,intekey,intro,location,adopdate,property,bpseudonymid,fdoc,color,auditcopyright,medium,yncompression from Baudit where node=" + node);
            if(db.next())
            {
                int j = 1;
                id = db.getInt(j++);
                node = db.getInt(j++);
                auditmember = db.getString(j++);
                community = db.getString(j++);
                mediaref = db.getString(j++);
                mediatype = db.getInt(j++);
                received = db.getDate(j++);
                error = db.getInt(j++);
                dateaudit = db.getDate(j++);
                passpage = db.getInt(j++);
                times = db.getInt(j++);
                status = db.getInt(j++);
                resubmit = db.getInt(j++);
                member = db.getString(j++);
                zoom = db.getInt(j++);
                classific = db.getString(j++);
                photography = db.getInt(j++);
                design = db.getInt(j++);
                touse = db.getInt(j++);
                cutimg = db.getInt(j++);
                cuted = db.getInt(j++);
                basicKey = db.getString(j++);
                mainKey = db.getString(j++);
                inteKey = db.getString(j++);
                intro = db.getString(j++);
                location = db.getString(j++);
                adopDate = db.getDate(j++);
                property = db.getInt(j++);
                bpseudonymid = db.getInt(j++);
                fdoc = db.getString(j++);
                color = db.getInt(j++);
                auditCopyright = db.getInt(j++);
                medium = db.getInt(j++);
                yncompression = db.getInt(j++);
                exists = true;
                _cache.clear();
            } else
            {
                exists = false;
            }

        } finally
        {
            db.close();

        }
    }

    public static void set(int id,int node,String auditmember,String community,String mediaref,int mediatype,Date received,int error,Date dateaudit,int passpage,int times,int status,int resubmit,String member,String classific,int color,int medium) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id from Baudit where node=" + node);
            if(db.next())
            {
                db.executeUpdate("UPDATE [Baudit] SET [node]=" + node + ",[auditmember]=" + db.cite(auditmember) + " ,[community]=" + db.cite(community) + ",[mediaref]=" + db.cite(mediaref) + ",[mediatype]=" + mediatype + ",[received]=" + db.cite(received) + ", [error]=" + error + ",[dateaudit]=" + db.cite(dateaudit) + ", [passpage]=" + passpage + ",[status]=" + status + ",[resubmit]=" + resubmit + ",member=" + db.cite(member) + ",medium=" + medium + " WHERE node= " + node);

            } else
            {
                db.executeUpdate("INSERT INTO Baudit([node],[auditmember],[community],[mediaref],[mediatype],[received],[error],[dateaudit],[passpage],[times],[status],[resubmit],[member],classific,color,medium)VALUES(" + node + "," + db.cite(auditmember) + "," + db.cite(community) + "," + db.cite(mediaref) + "," + mediatype + "," + db.cite(received) + "," + error + "," + db.cite(dateaudit) + "," + passpage + "," + times + "," + status + "," + resubmit + "," + db.cite(member) + "," + db.cite(classific) + "," + color + "," + medium + ")");
            }
        } finally
        {
            db.close();
        }
    }

    public static void set(int node,int yncompression) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("Select id from Baudit where node=" + node);
            if(db.next())
            {
                db.executeUpdate("UPDATE [Baudit] SET yncompression=" + yncompression + " WHERE node= " + node);

            }
        } finally
        {
            db.close();
        }
    }

    public static void del(String community,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Baudit where node=" + node);

        } finally
        {
            db.close();
        }
    }

    /*****
     * 删除图片信息 社区，图片节点，详细路径 唐嗣达 2009年2月1日17:11:24
     * ******/

    public static void delete(String community,int node,File fpic) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("delete from Baudit where node=" + node);
            db.executeUpdate("delete from Bimage where node=" + node);
            db.executeUpdate("delete from picture where node=" + node);
            db.executeUpdate("delete from Blimit where node=" + node);
            db.executeUpdate("delete from exifparam where node=" + node);
            db.executeUpdate("update lightbox set picid=REPLACE(picid,'," + node + "','')");

            fpic.delete();
        } finally
        {
            db.close();
        }
    }

    //图片编辑删除
    public static void deletePic(int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {

            db.executeUpdate("delete from Baudit where node=" + node);
            db.executeUpdate("delete from Bimage where node=" + node);
            db.executeUpdate("delete from picture where node=" + node);
            db.executeUpdate("delete from Blimit where node=" + node);
            db.executeUpdate("delete from exifparam where node=" + node);
            db.executeUpdate("update lightbox set picid=REPLACE(picid,'," + node + "','')");

        } finally
        {
            db.close();
        }
    }


    //图片管理
    public static void setImg(int node,String classific,int photography,int design,int touse,int cutimg,int cuted,String basicKey,String MainKey,String inteKey,String intro,String location,String adopDate,int property,int bpseudonymid,String fdoc,int color,int medium) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE [Baudit] SET [classific]=" + db.cite(classific) + ",[photography]=" + photography + " ,[design]=" + design + ",[touse]=" + touse + ",[cutimg]=" + cutimg + ",[cuted]=" + cuted + ", [basicKey]=" + db.cite(basicKey) + ",[MainKey]=" + db.cite(MainKey) + ", [inteKey]=" + db.cite(inteKey) + ",[intro]=" + db.cite(intro) + ",[location]=" + db.cite(location) + ",[adopDate]=" + db.cite(adopDate) + ",[property]=" + property + ",bpseudonymid=" + bpseudonymid + ",fdoc=" + db.cite(fdoc) + ",color=" + color + ",medium=" + medium + " WHERE [node]= " + node);
        } finally
        {
            db.close();
        }
    }

    public static void setImg(int node,String classific) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE node set classific=" + db.cite(classific) + " WHERE [node]= " + node);
        } finally
        {
            db.close();
        }
    }


    /**
     * 添加一个综合结算通过次数 错误总数
     * */
    public static int allTimes(String str,String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int num = 0;
        try
        {
            db.executeQuery("select " + str + " from Baudit where community=" + db.cite(community) + " " + sql);
            if(db.next())
            {
                num = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return num;
    }

//    public static String allTimestoString(String str,String community,String sql) throws SQLException
//    {
//        DbAdapter db = new DbAdapter();
//        String ss = null;
//        try
//        {
//            db.executeQuery("select " + str + " from Baudit where community=" + db.cite(community) + " " + sql);
//            if(db.next())
//            {
//                ss = db.getString(1);
//            }
//        } finally
//        {
//            db.close();
//        }
//        return ss;
//    }
    public static java.util.Enumeration findBytimes(String community,String sql,int pos,int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT distinct  times FROM Baudit WHERE community=" + DbAdapter.cite(community) + sql);
            for(int l = 0;l < pos + pageSize && db.next();l++)
            {
                if(l >= pos)
                {
                    vector.addElement(String.valueOf(db.getString(1)));
                }
            }

        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static java.util.Enumeration deleteNode() throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select node from baudit where passpage=3");
            while(db.next())
            {
                vector.addElement(Integer.valueOf(db.getInt(1)));
            }

        } finally
        {
            db.close();
        }
        return vector.elements();
    }


    public static java.util.Enumeration findByCommunity(String community,String sql,int pos,int pageSize) throws SQLException
    {
        java.util.Vector vector = new java.util.Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  node FROM Baudit WHERE community=" + DbAdapter.cite(community) + sql);
            for(int l = 0;l < pos + pageSize && db.next();l++)
            {
                if(l >= pos)
                {
                    vector.addElement(db.getInt(1));
                }
            }

        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public static Enumeration findImgNode(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  node FROM Baudit WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    public static int count(String community,String sql) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  count(node) FROM Baudit WHERE community=" + DbAdapter.cite(community) + sql);
            while(db.next())
            {
                i = db.getInt(1);

            }

        } finally
        {
            db.close();
        }
        return i;
    }


    public String getAuditmember()
    {
        return auditmember;
    }

    public int getNode()
    {
        return node;
    }

    public String getCommunity()
    {
        return community;
    }

    public Date getDateaudit()
    {
        return dateaudit;
    }

    public String getDateaudittoString()
    {
        if(dateaudit != null)
        {
            return Baudit.sdf.format(dateaudit);
        }
        return "";

    }


    public int getTimes()
    {
        return times;
    }

    public int getError()
    {
        return error;
    }

    public int getId()
    {
        return id;
    }

    public int getPasspage()
    {
        return passpage;
    }

    public Date getReceived()
    {
        return received;
    }

    public String getReceivedtoString()
    {
        if(received != null)
        {
            return Baudit.sdf.format(received);
        }
        return "";
    }

    public int getStatus()
    {
        return status;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getMediatype()
    {
        return mediatype;
    }

    public String getMediaref()
    {
        return mediaref;
    }

    public int getResubmit()
    {
        return resubmit;
    }

    public String getMember()
    {
        return member;
    }

    public int getZoom()
    {
        return zoom;
    }

    public Date getAdopDate()
    {
        return adopDate;
    }

    public String getAdopDateToString()
    {
        String adopDate1 = "";
        if(adopDate != null)
        {
            adopDate1 = Baudit.sdf.format(adopDate);
        }
        return adopDate1;
    }


    public String getBasicKey()
    {
        return basicKey;
    }

    public String getClassific()
    {
        return classific;
    }

    public int getCuted()
    {
        return cuted;
    }

    public int getCutimg()
    {
        return cutimg;
    }

    public int getDesign()
    {
        return design;
    }

    public String getInteKey()
    {
        return inteKey;
    }

    public String getIntro()
    {
        return intro;
    }

    public String getLocation()
    {
        return location;
    }

    public String getMainKey()
    {
        return mainKey;
    }

    public int getPhotography()
    {
        return photography;
    }

    public int getTouse()
    {
        return touse;
    }

    public int getProperty()
    {
        return property;
    }

    public int getBpseudonymid()
    {
        return bpseudonymid;
    }

    public String getFdoc()
    {
        return fdoc;
    }

    public int getColor()
    {
        return color;
    }

    public int getAuditCopyright()
    {
        return auditCopyright;
    }

    public int getMedium()
    {
        return medium;
    }

    public int getYncompression()
    {
        return yncompression;
    }

    public static void addZoom(int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int zoom = 0;
        try
        {

            db.executeQuery("Select zoom from Baudit where node=" + node);
            if(db.next())
            {
                zoom = db.getInt(1);
                zoom++;
            } else
            {
                zoom = 1;
            }
            db.executeUpdate("Update Baudit set zoom=" + zoom + " from Baudit where node=" + node);
        } finally
        {
            db.close();
        }
    }

    public static void setPg(int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();

        try
        {
            db.executeUpdate("Update Baudit set passpage=3 from Baudit where node=" + node);
        } finally
        {
            db.close();
        }
    }
}
