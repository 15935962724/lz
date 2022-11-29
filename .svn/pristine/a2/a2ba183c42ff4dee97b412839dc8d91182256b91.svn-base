package tea.entity.node;

import java.util.*;

import tea.db.*;
import tea.entity.admin.AdminRole;
import tea.entity.admin.AdminUsrRole;
import tea.resource.*;
import tea.entity.*;
import tea.entity.member.*;
import java.io.*;
import tea.html.*;
import java.sql.SQLException;
import java.util.regex.*;

public class Node extends Entity implements Cloneable
{
    public static Cache _cache = new Cache(2000);
    public static final String NODE_TYPE[] =
            {"Folder","Category","Page","Poll","Buy","Bid","Bargain","Presentation","Chat","Quiz", // 0
            "StampSet","Stamp","Book","News","Weather","Stock","Classified","Government","Institution","Group", // 1
            "School","Company","Media","Publisher","WebSite","Person","Author","Reporter","Expert","Career", // 2
            "Financing","Friend","Supply","Demand","Goods","Law","Recipe","Event","Sports","Report", // 3
            "Picture","Files","Application","SMS","NewsPaper","NightShop","Human","Enterprise","Hostel","Flight", // 4
            "Job","Investor","Resume","LFinancing","LInvestor","Perform","Sound","BBS","Register","ERegister", // 5
            "Gazetteer","EGazetteer","Golf","Download","Score","Service","SOrder","Admin","Waiter","Client", // 6
            "Express","Indict","Sale","MessageBoard","Contribute","Environmental","GreenManufacture","EarthKavass","Link","Travel", // 7
            "Literature","Landscape","Weblog","District","Interlocution","Scholar","Tender","BulletinBoard","Dish","Movie", // 8
            "Car","House","Venues","Logo","Photography","Album","Volunteer","Historical","People","Notices", // 9
            "Outside","Course","Reserve","Animal","Plant","Specimen","Materia","Infrared","SPicture","Subjects", //10
            "TrustProduct","TrustCompany","Services","Video","Meeting"}; //11
    public static final String APPLY_STYLE[] =
            {"None","ThisTreeAllNodes","ThisCommAllNodes","ThisRootAllNodes"};
    public static final int NODET_FOLDER = 0;
    public static final int NODET_CATEGORY = 1;
    public static final int NODET_PAGE = 2;
    public static final int NODET_POLL = 3;
    public static final int NODET_BUY = 4;
    public static final int NODET_BID = 5;
    public static final int NODET_BARGAIN = 6;
    public static final int NODET_PRESENTATION = 7;
    public static final int NODET_CHAT = 8;
    public static final int NODET_QUIZ = 9;
    public static final int NODET_STAMPSET = 10;
    public static final int NODET_STAMP = 11;
    public static final int NODET_BOOK = 12;
    public static final int NODET_NEWS = 13;
    public static final int NODET_WEATHER = 14;
    public static final int NODET_STOCK = 15;
    public static final int NODET_CLASSIFIED = 16;
    public static final int NODET_GOVERNMENT = 17;
    public static final int NODET_INSTITUTION = 18;
    public static final int NODET_GROUP = 19;
    public static final int NODET_SCHOOL = 20;
    public static final int NODET_COMPANY = 21;
    public static final int NODET_MEDIA = 22;
    public static final int NODET_PUBLISHER = 23;
    public static final int NODET_WEBSITE = 24;
    public static final int NODET_PERSON = 25;
    public static final int NODET_AUTHOR = 26;
    public static final int NODET_REPORTER = 27;
    public static final int NODET_EXPERT = 28;
    public static final int NODET_CAREER = 29;
    public static final int NODET_EMPLOYMENT = 30;
    public static final int NODET_FRIEND = 31;
    public static final int NODET_SUPPLY = 32;
    public static final int NODET_DEMAND = 33;
    public static final int NODET_GOODS = 34;
    public static final int NODET_LAW = 35;
    public static final int NODET_RECIPE = 36;
    public static final int NODET_EVENT = 37;
    public static final int NODET_SPORTS = 38;
    public static final int NODET_LAST = 38;
    public static final int NODEO_MASK = 0x7e000000;
    public static final int NODEO_SHOWHEADER1 = 0x40000000;
    public static final int NODEO_SHOWAD = 0x20000000;
    public static final int NODEO_SHOWHEADER2 = 0x10000000;
    public static final int NODEO_SHOWBODYLEFT = 0x8000000;
    public static final int NODEO_SHOWBODYRIGHT = 0x4000000;
    public static final int NODEO_SHOWFOOTER = 0x2000000;
    public static final int NODEO_SHOWPATH = 0x1000000;
    public static final int NODEO_SHOWSONS = 0x800000;
    public static final int NODEO_SHOWSUBJECT = 0x400000;
    public static final int NODEO_SHOWCREATOR = 0x200000;
    public static final int NODEO_SHOWGRANDSONS = 0x100000;
    public static final int NODEO_SHOWLOGIN = 0x80000;
    public static final int NODEO_SHOWFATHER = 0x40000;
    public static final int NODEO_POLL = 0x20000;
    public static final int NODEO_CHATROOM = 0x10000;
    public static final int NODEO_OPENTB = 32768;
    public static final int NODEO_PUBLICTB = 16384;
    public static final int NODEO_PERTB = 8192;
    public static final int NODEO_NEEDLOGIN = 4096;
    public static final int NODEO_PREVNEXT = 2048;
    public static final int NODEO_ALLOWSUB = 1024;
    public static final int NODEO_SHOWTALKBACK = 512;
    public static final int NODEO_ACCESSMEMBER = 256;
    public static final int NODEO_SHOWBRIEFING = 128;
    public static final int NODEO_TEXTORHTML = 64;
    public static final int CATEGORYO_OPEN = 1;
    public static final int CATEGORYO_NEEDGRANT = 2;
    public static final int PAGEO_LINK = 1;
    public static final int BUYO_FAST = 1;
    public static final int BUYO_FREESHIPPING = 2;
    public static final int BIDO_ONCE = 1;
    public static final int BARGAINO_ONCE = 1;
    public static final int POLLO_SHOWTIME = 0x40000000;
    public static final int POLLO_HIDERESULT = 0x20000000;
    public static final int POLLO_UNANONYMOUS = 0x10000000;
    public static final int POLLO_MULTIPLE = 0x8000000;
    public static final int POLLO_REMARK = 0x4000000;
    public static final int CHATO_SHOWTIME = 0x200000;
    public static final int CHATO_RECORDALL = 0x100000;
    public static final String SEARCH_AREA[] =
            {"ThisTree","ThisCommunity","AllCommunities"};
    public static final int SEARCHA_THISTREE = 0;
    public static final int SEARCHA_THISCOMM = 1;
    public static final int SEARCHA_ALLCOMMS = 2;
    public static final String SEARCH_CREATOR[] =
            {"DoNotCare","NodeRealCreator","NodeVirtualCreator","FatherRealCreator","FatherVirtualCreator","SonRealCreator","SonVirtualCreator","GrandsonRealCreator","GrandsonVirtualCreator"};
    public static final int SEARCHC_DONOTCARE = 0;
    public static final int SEARCHC_NODEREAL = 1;
    public static final int SEARCHC_NODEVIRTUAL = 2;
    public static final int SEARCHC_FATHERREAL = 3;
    public static final int SEARCHC_FATHERVIRTUAL = 4;
    public static final int SEARCHC_SONREAL = 5;
    public static final int SEARCHC_SONVIRTUAL = 6;
    public static final int SEARCHC_GRANDSONREAL = 7;
    public static final int SEARCHC_GRANDSONVIRTUAL = 8;
    public int _nNode;
    public int father;
    public String community;
    public int member; //创建者
    public RV creator;
    public Date time;
    public int type;
    public int sequence;
    public boolean hidden;
    public long options; //0x40:
    public int options1;
    public int defaultLanguage;
    public Date starttime;
    public Date stopTime;
    byte level; //缓存级别
    private String path;
    public Hashtable layer;
    private Vector languages;
    private int click;
    public int template;
    private int finished;
    public static final String SEARCH_BY[] =
            {"DoNotCare","ByAuthor"};
    public static final int SEARCHBY_DONOTCARE = 0;
    public static final int SEARCHBY_AUTHOR = 1;
    public int style; // 内容的相关范围
    public int recommended; // 是否推荐
    public int root; // 内容的同根
    public boolean mostly; // 是否关键//
    public boolean mostly1; // 是否关键//内部
    public boolean mostly2; // 是否关键//外部
    public String mark = "/";
    private int hot;
    private Date updatetime;
    public int kstyle; // 关键词的相关范围
    public int kroot; // 关键词的同根
    public int child; //子节点数量
    private boolean extend = true; // 节点权限是否继承
    private String categoryosubscribe; //是否显示发行管理
    public String syncid;
    private String goodsnumber;
    public static final String SOURCE_TYPE[] =
            {"","前台创建","后台创建","复制","移动","前台投稿"};
    public int source; //节点来源
    public int audits; //用于摄影类 审核   //0 未审核，1，已审核，2, 已拒绝---
    //新闻类投稿用到的  0 新建稿，1 待审核  2 已发布  3 已退稿   4 已删除
    //用于活动类   活动筹备中…、活动报名进行中…、活动报名已结束、正在进行，已举行

    //新闻审核用户和时间
    public String auditmember; //节点审核 用户
    public Date audittime; //节点审核时间

    //访问权限跳转节点，在编辑节点页面设置
    public String accessmembersnode;

    public static final String CATEGORYOS_SUBSCRIBE[] =
            {"报纸设置","报纸导入","策略设置","套餐设置","手机支付"};
    public static final String AUDIT_TYPE[] =
            {"新建稿","待审核","已发布","已退稿 ","已删除"};
    class NLayer
    {
        String subject;
        String keywords;
        String description;
        public String text;
        public String text2;
        public String picture;
        public int picture2;
        public String _strAlt;
        public int _nAlign;
        public String _strVoice;
        public String clickurl;
        public String _strSrcUrl;
        public String _strSrcUrlx;
        public int _nDirection;
        public String _strFileName;
        public String _strFile = "|";
        public String _strMms;
        public String _strRepic; //用到的是 投票中 相关图片
        public byte level; //缓存级别
    }


    public String getVoice(int i) throws SQLException
    {
        return getLayer(i,i)._strVoice;
    }

    public String getFile(int i) throws SQLException
    {
        return getLayer(i,i)._strFile;
    }


    public static int CategorySon(int i,int j) throws SQLException
    {
        int k = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node  FROM Node n, Category c  WHERE n.node=c.node  AND n.father=" + i + " AND c.category=" + j);
            if(db.next())
            {
                k = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return k;
    }

    public void increaseView() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("ViewCounterIncrease " + _nNode);
        } finally
        {
            db.close();
        }
    }

    public void NewTemplate(int node,int category,String name) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("insert into Template (node,category,name) values (" + node + "," + category + "," + DbAdapter.cite(name) + ")");
        } catch(Exception ex)
        {
            System.out.print(ex);
        } finally
        {
            db.close();
        }
    }

// 获取社区根 节点
    public static int getRoot(String community) throws SQLException
    {
        int id = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Node WHERE community = " + db.cite(community));
            if(db.next())
            {
                id = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return id;
    }


    public void DeleteTemplate(int id) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Template where id=" + id);
        } catch(Exception ex)
        {
            System.out.print(ex);
        } finally
        {
            db.close();
        }
    }

    public int getTemplate(int node) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("select template from Node where node=" + node);
        } catch(Exception ex)
        {
            System.out.print(ex);
        } finally
        {
            db.close();
        }
        return i;
    }

    public void setTemplate(int node,int template) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Node set template='" + template + "' where node=" + node);
        } catch(Exception ex)
        {
            System.out.print(ex);
        } finally
        {
            db.close();
        }
    }

    public int getFinished() throws SQLException
    {
        load();
        return finished;
    }

    public int getAudit() throws SQLException
    {
        load();
        return audits;
    }

    public String getAuditmember() throws SQLException
    {
        load();
        return auditmember;
    }

    public String getAccessmembersnode() throws SQLException
    {
        load();
        return accessmembersnode;
    }

    public Date getAudittime() throws SQLException
    {
        load();
        return audittime;
    }

    public void finished(int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"update Node set finished=1  where node=" + node);
        } finally
        {
            db.close();
        }
    }

//修改 审核状态
    private void setAudit(int audits) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Node set audits=" + audits + "  where node=" + _nNode);
        } finally
        {
            db.close();
        }
        this.audits = audits;

    }

    //修改审核用户
    private void setAuditmember(String auditmember) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Node set auditmember=" + DbAdapter.cite(auditmember) + "  where node=" + _nNode);
        } finally
        {
            db.close();
        }
        this.auditmember = auditmember;

    }

    //待删除
    private void setAccessmembersnode(String accessmembersnode) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Node set accessmembersnode=" + DbAdapter.cite(accessmembersnode) + "  where node=" + _nNode);
        } finally
        {
            db.close();
        }
        this.accessmembersnode = accessmembersnode;

    }

//修改审核时间
    private void setAudittime(Date audittime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Node set audittime=" + DbAdapter.cite(audittime) + "  where node=" + _nNode);
        } finally
        {
            db.close();
        }
        this.audittime = audittime;
    }

    //ajax
    public String setAudit_ajax(int audits,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Node set audits=" + audits + "  where node=" + node);
        } finally
        {
            db.close();
        }
        this.audits = audits;
        return "ssss";
    }

    public String hello(String ccc)
    {
        return "DWR配置成功！" + ccc;
    }

    public void setNumer(String goodsnumber,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Node set goodsnumber=" + db.cite(goodsnumber) + "  where node=" + node);
        } finally
        {
            db.close();
        }
        this.goodsnumber = goodsnumber;
    }

    public String getTimeToString() throws SQLException
    {
        load();
        if(time == null)
            return "";

        return sdf.format(time);

    }

    public String getStopTimeToString() throws SQLException
    {
        load();
        if(stopTime == null)
        {
            return "";
        }
        return sdf.format(stopTime);
    }

    public Date getTime() throws SQLException
    {
        load();
        return time;
    }

    public void setTime(Date date) throws SQLException
    {
        set("time",date);
        this.time = date;
    }

//判断是否有编号
    public static boolean isNumber(String goodsnumber) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        boolean f = false;
        try
        {
            db.executeQuery("SELECT node FROM Node WHERE goodsnumber=" + db.cite(goodsnumber));
            if(db.next())
            {
                f = true;
            }
        } finally
        {
            db.close();
        }
        return f;
    }

// 通过商品编号获取Node的id
    public static int getGoodsNumber2(String community,String goodsnumber) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int n = 0;
        try
        {
            db.executeQuery("SELECT node FROM Node WHERE community =" + db.cite(community) + " and goodsnumber=" + db.cite(goodsnumber));
            if(db.next())
            {
                n = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return n;
    }

    public void setUpdatetime(Date date) throws SQLException
    {
        set("updatetime",date);
        this.updatetime = date;
    }

    public static int countRequestNodes(RV rv) throws SQLException
    {
        int i = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.getInt("SELECT COUNT(DISTINCT(f.node)) " + getRequestNodesSql(rv));
        } finally
        {
            db.close();
        }
        return i;
    }

    public static int countSearch(String s,int i,int j,int k,int l,String s1,int i1,int j1,String s2,int k1,String s3) throws SQLException
    {
        int l1 = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            l1 = db.getInt("SELECT COUNT(DISTINCT n.node) " + getSearchSql(s,i,j,k,l,s1,i1,j1,s2,k1,s3));
        } finally
        {
            db.close();
        }
        return l1;
    }

    public static boolean isExisted(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Node WHERE node=" + i);
            return db.next();
        } finally
        {
            db.close();
        }
    }

    public static int findPrev(int i,int j,RV rv) throws SQLException
    {
        int k = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            k = db.getInt("SELECT  node " + getSonsSql(i,rv) + " AND node<" + j + " ORDER BY node DESC ");
            // System.out.println("SELECT  node " + getSonsSql(i,rv) + " AND node<" + j + " ORDER BY node DESC ");
        } finally
        {
            db.close();
        }
        return k;
    }

    public static boolean isExisted(String s) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            flag = db.getInt("SELECT COUNT(node) FROM Node WHERE community=" + DbAdapter.cite(s)) != 0;
        } finally
        {
            db.close();
        }
        return flag;
    }

    // cloneSons:-1:不复制节点, 0:所有节点,1:只有一个节点,2:只有子节点,3:结构,4:只有一个节点+结构
    public static int clone(int fromNode,int toNode,boolean cloneSections,boolean cloneListings,int cloneSons,RV rv,Writer out) throws SQLException,IOException,CloneNotSupportedException
    {
        int max = ((Integer) Node.find(" ORDER BY node DESC",0,1).nextElement()).intValue() + 1;
        String id = Long.toString(System.currentTimeMillis(),36) + String.valueOf(Math.random());
        if(cloneSons == 0 || cloneSons == 1 || cloneSons == 4)
            toNode = Node.clone(fromNode,toNode,rv);
        if(cloneSons == 4)
            cloneSons = 3;
        clone(fromNode,toNode,cloneSections,cloneListings,cloneSons,rv,max,id,out);
        Clonetemp.correct(id,out);
        return toNode;
    }

    private static void clone(int fromNode,int toNode,boolean cloneSections,boolean cloneListings,int cloneSons,RV rv,int max,String sessionid,Writer out) throws SQLException,IOException,CloneNotSupportedException
    {
        System.out.println("源节点:" + fromNode + "\t目标节点:" + toNode);
        Node node = find(fromNode);
        if(out != null)
        {
            out.write("<script>$('dialog_content').innerHTML='正在复制：" + fromNode + "、" + node.getSubject(1) + "';</script>");
            out.flush();
        }
        Node node1 = find(toNode);
        node1.setAudit(node.getAudit());
        node1.setSource(3);
        StringBuilder new_listing = new StringBuilder();
        StringBuilder new_section = new StringBuilder();
        StringBuilder new_cssjs = new StringBuilder();
        if(cloneSections) // 段落和CSSJS复制
        {
            Enumeration e1 = Section.findByNode(fromNode);
            while(e1.hasMoreElements())
            {
                int k = ((Integer) e1.nextElement()).intValue();
                Section obj = Section.find(k);
                new_section.append(obj.clone(toNode,obj.getStatus()).section).append(",");
            }
            if(new_section.length() > 2)
            {
                new_section.deleteCharAt(new_section.length() - 1);
            }
            Enumeration e2 = CssJs.findByNode(fromNode);
            while(e2.hasMoreElements())
            {
                int k = ((Integer) e2.nextElement()).intValue();
                CssJs obj = CssJs.find(k);
                new_cssjs.append(obj.clone(toNode,obj.getStatus()).cssjs).append(",");
            }
            if(new_cssjs.length() > 2)
            {
                new_cssjs.deleteCharAt(new_cssjs.length() - 1);
            }
        }
        if(cloneListings) // 列举复制
        {
            Enumeration e1 = Listing.findByNode(fromNode);
            while(e1.hasMoreElements())
            {
                int l = ((Integer) e1.nextElement()).intValue();
                Listing obj = Listing.find(l);
                new_listing.append(obj.clone(toNode,obj.getStatus()).listing).append(",");
            }
            if(new_listing.length() > 2)
            {
                new_listing.deleteCharAt(new_listing.length() - 1);
            }
        }
        Clonetemp.create(fromNode,sessionid,toNode,new_listing.toString(),new_section.toString(),new_cssjs.toString());
        if(cloneSons != -1 && cloneSons != 1)
        {
            StringBuilder sql = new StringBuilder();
            sql.append(" AND father=").append(fromNode).append(" AND node<").append(max);
            if(cloneSons == 3) // 复制结构
            {
                sql.append(" AND( type IN(0,1) OR node IN( SELECT node FROM Listing WHERE style=7) )");
            }
            sql.append(" AND hidden=0 ORDER BY time DESC");

            Enumeration e1 = Node.find(sql.toString(),0,Integer.MAX_VALUE);
            while(e1.hasMoreElements())
            {
                int j1 = ((Integer) e1.nextElement()).intValue();
                Node node2 = find(j1);
                RV rv1 = null;
                if(node2.getCreator()._strR.equals(node.getCreator()._strR))
                {
                    rv1 = node1.getCreator();
                } else
                {
                    rv1 = node2.getCreator();
                }
                int l1 = clone(j1,toNode,rv1);
                clone(j1,l1,true,true,cloneSons,rv,max,sessionid,out);
            }
        }
    }

    public static int create(int father,int sequence,String community,RV rv,int type,int typealias,boolean hidden,long options,int options1,int defaultlanguage,Date starttime,Date stoptime,Date time,int template,int style,int root,int kstyle,int kroot) throws SQLException
    {
        int j2 = 0;
        String path;
        if(father == 0)
        {
            path = "";
        } else
        {
            path = Node.find(father).getPath();
        }
        DbAdapter db = new DbAdapter();
        StringBuilder sql = new StringBuilder("INSERT INTO Node(father,sequence,community,rcreator,vcreator,time,type,hidden,options,options1,starttime,stoptime,path,typealias,defaultlanguage,click,template,finished,style,root,mostly,hot,updatetime,kstyle,kroot,extend)VALUES(");
        sql.append(father).append(",");
        sql.append(sequence).append(",");
        sql.append(DbAdapter.cite(community)).append(",");
        sql.append(DbAdapter.cite(rv._strR)).append(",");
        sql.append(DbAdapter.cite(rv._strV)).append(",");
        sql.append(db.cite(time)).append(",");
        sql.append(type).append(",");
        sql.append("1").append(",");
        sql.append(options).append(",");
        sql.append(options1).append(",");
        sql.append(db.cite(starttime)).append(",");
        sql.append(db.cite(stoptime)).append(",");
        sql.append(DbAdapter.cite(path)).append(",");
        sql.append(typealias).append(",");
        sql.append(defaultlanguage).append(",");
        sql.append(0).append(",");
        sql.append(template).append(",");
        sql.append(0).append(",");
        sql.append(style).append(",");
        sql.append(root).append(",");
        sql.append(0).append(",");
        sql.append(0).append(",");
        sql.append(db.cite(time)).append(",");
        sql.append(kstyle).append(",");
        sql.append(kroot).append(",");
        sql.append(1).append(")");
        try
        {
            db.executeUpdate(sql.toString());
            j2 = db.getInt("SELECT MAX(node) FROM Node");
            db.executeUpdate("UPDATE Node SET path='" + path + "/" + j2 + "' WHERE node=" + j2);
        } finally
        {
            db.close();
        }
        return j2;
    }

    public static int clone(int from,int tofather,RV rv) throws SQLException,CloneNotSupportedException
    {
        Node old = Node.find(from);
        old.load();
        Node obj = old.clone();
        obj.father = tofather;
        obj.creator = rv;
        obj.community = Node.find(tofather).getCommunity();
        obj.set();

        Vector ve = old.getLanguages();
        Iterator it = ve.iterator();
        while(it.hasNext())
        {
            int lang = ((Integer) it.next()).intValue();
            obj.setLayer(lang,old.getSubject(lang),old.getKeywords(lang),old.getDescription(lang),old.getText(lang),old.getPicture(lang),old.getAlt(lang),old.getAlign(lang),old.getVoice(lang),old.getClickUrl(lang),old.getSrcUrl(lang),old.getSrcUrlx(lang),old.getFileName(lang),old.getFile(lang),old.getMms(lang));
            int val = obj.getPicture2(lang);
            if(val > 0)
                obj.set("picture2",lang,String.valueOf(val));
        }

        java.sql.ResultSetMetaData rsmd;
        int count;
        DbAdapter db = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            if(obj.getType() != 3 && obj.getType() != 39)
            {
                try
                {
                    String tns[] =
                            {Node.NODE_TYPE[obj.getType()],Node.NODE_TYPE[obj.getType()] + "NLayer"};
                    for(int i = 0;i < 2;i++)
                    {
                        db.executeQuery("SELECT * FROM " + tns[i] + " WHERE node=" + from);
                        rsmd = db.getMetaData();
                        count = rsmd.getColumnCount();
                        while(db.next())
                        {
                            ArrayList al_name = new ArrayList(),al_value = new ArrayList();
                            StringBuilder sql = new StringBuilder("INSERT INTO ").append(tns[i]).append(" VALUES(").append(obj._nNode);
                            for(int j = 2;j <= count;j++)
                            {
                                sql.append(",").append(db.get(j,al_name,al_value));
                            }
                            sql.append(")");
                            db2.executeUpdate(sql.toString());
                            if(al_name.size() > 0) //大文本
                            {
                                String[] name = new String[al_name.size()],value = new String[al_value.size()];
                                al_name.toArray(name);
                                al_value.toArray(value);
                                db2.setText(tns[i],name,value," node=" + from);
                            }
                        }
                    }
                } catch(Exception e)
                {
                }
            }
            switch(obj.getType())
            {
            case 3:
                Poll.clone(from,obj._nNode);
                break;
            case 15: // 股票
                db.executeQuery("SELECT * FROM Stock2 WHERE node=" + from);
                rsmd = db.getMetaData();
                count = rsmd.getColumnCount();
                while(db.next())
                {
                    ArrayList al_name = new ArrayList(),al_value = new ArrayList();
                    StringBuilder sql = new StringBuilder("INSERT INTO Stock2 VALUES(").append(obj._nNode);
                    for(int j = 2;j <= count;j++)
                    {
                        sql.append(",").append(db.get(j,al_name,al_value));
                    }
                    sql.append(")");
                    db2.executeUpdate(sql.toString());
                    if(al_name.size() > 0) //大文本
                        System.out.println("Stock2 存在大文本...");
                }
                break;
            case 39:
                Report r = Report.find(from);
                Report re = r.clone();
                re.node = obj._nNode;
                re.exists = false;
                re.set();
                it = ve.iterator();
                while(it.hasNext())
                {
                    int lang = ((Integer) it.next()).intValue();
                    re.setLayer(lang,r.getPicture(lang),r.getLocus(lang),r.getSubhead(lang),r.getAuthor(lang),r.getKicker(lang),r.getEditmember(lang),r.getNewquota(lang),r.getQuotasource(lang),r.getSubjectfilename(lang),r.getSubheadfilename(lang),r.getAuthorfilename(lang),r.getExperts(lang),r.getProvidemember(lang),r.getSignature(lang));
                }
                break;
            case 63: // 下载
                db.executeQuery("SELECT * FROM DownloadAddress WHERE node=" + from);
                rsmd = db.getMetaData();
                count = rsmd.getColumnCount();
                while(db.next())
                {
                    ArrayList al_name = new ArrayList(),al_value = new ArrayList();
                    StringBuilder sql = new StringBuilder("INSERT INTO DownloadAddress VALUES(").append(obj._nNode);
                    for(int j = 2;j <= count;j++)
                    {
                        sql.append(",").append(db.get(j,al_name,al_value));
                    }
                    sql.append(")");
                    db2.executeUpdate(sql.toString());
                    if(al_name.size() > 0) //大文本
                        System.out.println("Stock2 存在大文本...");
                }
                break;
            }
        } catch(CloneNotSupportedException ex)
        {
            ex.printStackTrace();
        } finally
        {
            db.close();
            db2.close();
        }
        if(obj.getType() > 1024)
        {
            Enumeration e = DynamicValue.findByNode(from);
            while(e.hasMoreElements())
            {
                DynamicValue dv = (DynamicValue) e.nextElement();
                dv.clone(obj._nNode);
            }
        }
        // 节点图片集//////////////////////////////////////////////////
        Enumeration e = TypePicture.findByNode(from);
        while(e.hasMoreElements())
        {
            int id = ((Integer) e.nextElement()).intValue();
            TypePicture tp = TypePicture.findByPrimaryKey(id);
            TypePicture.create(obj._nNode,tp.getWidth(),tp.getHeight(),tp.getPicture(),tp.getPicname(),tp.getPicture2());
        }
        return obj._nNode;
    }


    public String getCommunity() throws SQLException
    {
        load();
        return community;
    }

    public int move(int newFather,boolean flag) throws SQLException
    {
        int j;
        String s = getPath();
        String s1 = find(getFather()).getPath();
        Node node = find(newFather); //新节点
        String s2 = node.getPath();
        DbAdapter db = new DbAdapter();
        try
        {
            if(flag) // 移动子节点,father数据
            {
                j = db.executeUpdate(_nNode,"UPDATE Node SET father=" + newFather + ",options=" + node.getOptions() + " WHERE father=" + _nNode);
                s1 = s;
            } else // 移动当前节点
            {
                j = db.executeUpdate(_nNode,"UPDATE Node SET father=" + newFather + ",options=" + node.getOptions() + ",path=" + DbAdapter.cite(s2 + _nNode + "/") + ",community=" + DbAdapter.cite(node.getCommunity()) + " WHERE node=" + _nNode);
            }
            j += db.executeUpdate(_nNode,"UPDATE Node SET options=" + node.getOptions() + ",path=REPLACE(path," + DbAdapter.cite(s1) + "," + DbAdapter.cite(s2) + "),community=" + DbAdapter.cite(node.getCommunity()) + " WHERE path LIKE " + DbAdapter.cite(s + "_%")); // 移动子节点
        } finally
        {
            db.close();
        }
        Node.find(_nNode).setSource(4);
        _cache.clear();
        return j;
    }

    public static int countSons(int father,RV rv) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(node) " + getSonsSql(father,rv) + " AND finished=1");
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int countByPath(String path) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(node) FROM Node WHERE finished=1 AND path LIKE " + DbAdapter.cite(path + "/%"));
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int getNode(String name,int father) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT node FROM Node WHERE father=" + father + " and exists (select node from NodeLayer nl where Node.node=nl.node and  nl.subject =" + db.cite(name) + " ) ");
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int countRequests(int i) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(node) " + getRequestsSql(i));
        } finally
        {
            db.close();
        }
        return j;
    }

    public static boolean allowSon(int i)
    {
        return i > 9;
    }

    public static Enumeration findTopSon(int father,int rowNum) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Node WHERE father=" + father,0,rowNum);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int countSon(int father) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(node) FROM Node WHERE father=" + father);
            while(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration findSearch(String s,int i,int j,int k,int l,String s1,int i1,int j1,String s2,int k1,String s3,int l1,int i2) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT n.node " + getSearchSql(s,i,j,k,l,s1,i1,j1,s2,k1,s3) + " ORDER BY n.node DESC ");
            for(int j2 = 0;j2 < l1 + i2 && db.next();j2++)
            {
                if(j2 >= l1)
                {
                    v.addElement(db.getInt(1));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    // /////酒店
    public static int createjd(int father,int sequence,String community,RV rv,int type,int typealias,boolean hidden,long options,int options1,int defaultlanguage,Date starttime,Date stoptime,Date time,int template,int style,int root,int kstyle,int kroot,String redirecturl) throws SQLException
    {
        int j2 = 0;
        String path;
        if(father == 0)
        {
            path = "";
        } else
        {
            path = Node.find(father).getPath();
        }
        DbAdapter db = new DbAdapter();
        StringBuilder sql = new StringBuilder("INSERT INTO Node(father,sequence,community,rcreator,vcreator,time,type,hidden,options,options1,starttime,stoptime,path,typealias,defaultlanguage,click,template,finished,style,root,mostly,hot,updatetime,kstyle,kroot,redirecturl,extend)VALUES(");
        sql.append(father).append(",");
        sql.append(sequence).append(",");
        sql.append(DbAdapter.cite(community)).append(",");
        sql.append(DbAdapter.cite(rv._strR)).append(",");
        sql.append(DbAdapter.cite(rv._strV)).append(",");
        sql.append(time).append(",");
        sql.append(type).append(",");
        sql.append("1").append(",");
        sql.append(options).append(",");
        sql.append(options1).append(",");
        sql.append(db.cite(starttime)).append(",");
        sql.append(db.cite(stoptime)).append(",");
        sql.append(DbAdapter.cite(path)).append(",");
        sql.append(typealias).append(",");
        sql.append(defaultlanguage).append(",");
        sql.append(0).append(",");
        sql.append(template).append(",");
        sql.append(0).append(",");
        sql.append(style).append(",");
        sql.append(root).append(",");
        sql.append(0).append(",");
        sql.append(0).append(",");
        sql.append(db.cite(time)).append(",");
        sql.append(kstyle).append(",");
        sql.append(kroot).append(",");
        sql.append(DbAdapter.cite(redirecturl)).append(",");
        sql.append(1).append(")");
        try
        {
            db.executeUpdate(sql.toString());
            j2 = db.getInt("SELECT MAX(node) FROM Node");
            db.executeUpdate("UPDATE Node SET path='" + path + "/" + j2 + "' WHERE node=" + j2);
        } finally
        {
            db.close();
        }
        return j2;
    }

    public static void uphidden(int node) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        DbAdapter db1 = new DbAdapter();
        DbAdapter db2 = new DbAdapter();
        try
        {
            db.executeUpdate("update node set hidden=3 where node=" + node);
            db1.executeQuery("select node from node where father in(select node from node where father=" + node + ")");
            while(db1.next())
            {
                db2.executeUpdate("update node set hidden=1 where node=" + db1.getInt(1));
            }

        } catch(Exception ex)
        {
            System.out.print(ex);
        } finally
        {
            db.close();
            db1.close();
            db2.close();
        }

    }

    // 修改酒店中的审核 node表中的 hidden
    public void sethidden(int node,int type) throws SQLException
    {

        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Node set hidden=" + type + "  where node=" + node);
        } catch(Exception ex)
        {
            System.out.print(ex);
        } finally
        {
            db.close();
        }
        this.hidden = hidden;
    }

    // chenjam
    public int hidden(int node) throws SQLException
    {
        int i = -1;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select hidden from node where node=" + node);
            while(db.next())
            {
                i = db.getInt(1);
            }
        } catch(Exception ex)
        {
            System.out.print(ex);
        } finally
        {
            db.close();
        }
        return i;
    }

    public static void selUpHid(int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db1 = new DbAdapter();
        try
        {
            db.executeQuery("select hidden from node where node in(select father from node where node in(select father from node where node=" + node + "))");
            while(db.next())
            {
                if(db.getInt(1) == 0)
                {
                    db1.executeUpdate("update node set hidden=0 where node=" + node);
                }
            }
        } catch(Exception ex)
        {
            System.out.print(ex);
        } finally
        {
            db.close();
            db1.close();
        }
    }

    public static void uphid(int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        DbAdapter db1 = new DbAdapter();
        try
        {
            db.executeQuery("select node from node where father in(select node from node where father=" + node + ")");
            while(db.next())
            {
                db1.executeUpdate("update node set hidden=0 where node=" + db.getInt(1));
            }
        } catch(Exception ex)
        {
            System.out.print(ex);
        } finally
        {
            db.close();
            db1.close();
        }

    }

    public static int createjd(int father,int sequence,String community,RV rv,int type,int typealias,boolean hidden,long options,int options1,int defaultlanguage,Date starttime,Date stoptime,int language,String subject,String keywords,String text,String picture,String alt,int align,String voice,String clickurl,String srcurl,String srcurlx,String filename,String file,Date time,int style,int root,int kstyle,int kroot,String mms,String redirecturl) throws SQLException
    {
        int _nNode = createjd(father,sequence,community,rv,type,typealias,hidden,options,options1,defaultlanguage,starttime,stoptime,time,0,style,root,kstyle,kroot,redirecturl);
        DbAdapter db = new DbAdapter();
        StringBuilder sql = new StringBuilder("INSERT INTO NodeLayer(node, language, subject, keywords, content, picture, alt, align, voice, clickurl, srcurl, srcurlx, filename, filedata,mms)VALUES(");
        sql.append(_nNode).append(",").append(language).append(",").append(DbAdapter.cite(subject)).append(",").append(DbAdapter.cite(keywords)).append(",' ',").append(DbAdapter.cite(picture)).append(",").append(DbAdapter.cite(alt)).append(",").append(align).append(",").append(DbAdapter.cite(voice)).append(",").append(DbAdapter.cite(clickurl)).append(",").append(DbAdapter.cite(srcurl)).append(",").append(DbAdapter.cite(srcurlx)).append(",").append(DbAdapter.cite(filename)).append(",").append(
                DbAdapter.cite(file)).append(",").append(DbAdapter.cite(mms)).append(")");
        try
        {
            db.executeUpdate(sql.toString());
            db.setText("NodeLayer","content",text,"node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
        return _nNode;
    }

    // public static int create(int father, int sequence, String community, RV rv, int type, boolean hidden, long options, int options1, int defaultlanguage, Date starttime, Date stoptime, int language, String subject, String keywords, String text, String picture, String alt, int align, String voice, String clickurl, String srcurl, String srcurlx, String filename, String file, Date time, int style, int root, int kstyle, int kroot, String mms, String redirecturl) throws SQLException
    // {
    // int _nNode = create(father, sequence, community, rv, type, hidden, options, options1, defaultlanguage, starttime, stoptime, time, 0, style, root, kstyle, kroot, redirecturl);
    // DbAdapter db = new DbAdapter();
    // StringBuilder sql = new StringBuilder("INSERT INTO NodeLayer(node, language, subject, keywords, content, picture, alt, align, voice, clickurl, srcurl, srcurlx, filename, filedata,mms)VALUES(");
    // sql.append(_nNode).append(",").append(language).append(",").append(DbAdapter.cite(subject)).append(",").append(DbAdapter.cite(keywords)).append(",' ',").append(DbAdapter.cite(picture)).append(",").append(DbAdapter.cite(alt)).append(",").append(align).append(",").append(DbAdapter.cite(voice)).append(",").append(DbAdapter.cite(clickurl)).append(",").append(DbAdapter.cite(srcurl)).append(",").append(DbAdapter.cite(srcurlx)).append(",").append(DbAdapter.cite(filename)).append(",").append(
    // DbAdapter.cite(file)).append(",").append(DbAdapter.cite(mms)).append(")");
    // try
    // {
    // db.executeUpdate(sql.toString());
    // db.setText("NodeLayer", "content", text, "node=" + _nNode + " AND language=" + language);
    // } finally
    // {
    // db.close();
    // }
    // return _nNode;
    // }
    //
    // public static int create(int father, int sequence, String community, RV rv, int type, boolean hidden, long options, int options1, int defaultlanguage, Date starttime, Date stoptime, Date time, int template, int style, int root, int kstyle, int kroot, String redirecturl) throws SQLException
    // {
    // int j2 = 0;
    // String path;
    // if (father == 0)
    // {
    // path = "";
    // } else
    // {
    // path = Node.find(father).getPath();
    // }
    // StringBuilder sql = new StringBuilder("INSERT INTO Node(father,sequence,community,rcreator,vcreator,time,type,hidden,options,options1,starttime,stoptime,path,defaultlanguage,click,template,finished,style,root,mostly,hot,updatetime,kstyle,kroot,redirecturl,extend)VALUES(");
    // sql.append(father).append(",");
    // sql.append(sequence).append(",");
    // sql.append(DbAdapter.cite(community)).append(",");
    // sql.append(DbAdapter.cite(rv._strR)).append(",");
    // sql.append(DbAdapter.cite(rv._strV)).append(",");
    // sql.append(DbAdapter.cite(time)).append(",");
    // sql.append(type).append(",");
    // sql.append(DbAdapter.cite(hidden)).append(",");
    // sql.append(options).append(",");
    // sql.append(options1).append(",");
    // sql.append(DbAdapter.cite(starttime)).append(",");
    // sql.append(DbAdapter.cite(stoptime)).append(",");
    // sql.append(DbAdapter.cite(path)).append(",");
    // sql.append(defaultlanguage).append(",");
    // sql.append(0).append(",");
    // sql.append(template).append(",");
    // sql.append(0).append(",");
    // sql.append(style).append(",");
    // sql.append(root).append(",");
    // sql.append(0).append(",");
    // sql.append(0).append(",");
    // sql.append(DbAdapter.cite(new Date())).append(",");
    // sql.append(kstyle).append(",");
    // sql.append(kroot).append(",");
    // sql.append(DbAdapter.cite(redirecturl)).append(",");
    // sql.append(1).append(")");
    // DbAdapter db = new DbAdapter();
    // try
    // {
    // db.executeUpdate(sql.toString());
    // j2 = db.getInt("SELECT MAX(node) FROM Node");
    // db.executeUpdate("UPDATE Node SET path='" + path + "/" + j2 + "' WHERE node=" + j2);
    // } finally
    // {
    // db.close();
    // }
    // return j2;
    // }

    public static int create(int father,int sequence,String community,RV rv,int type,boolean hidden,long options,int options1,int defaultlanguage,Date starttime,
                             Date stoptime,Date time,int style,int root,int kstyle,int kroot,String syncid,int language,String subject,String keywords,String description,String text,
                             String picture,String alt,int align,String voice,String clickurl,String srcurl,String srcurlx,String filename,String file,String mms) throws SQLException
    {
        Node n = new Node(0);
        n.father = father;
        n.sequence = sequence;
        n.community = community;
        n.member = Profile.find(rv._strR).getProfile();
        n.creator = rv;
        n.type = type;
        n.hidden = hidden;
        n.options = options;
        n.options1 = options1;
        n.defaultLanguage = defaultlanguage;
        n.starttime = starttime;
        n.stopTime = stoptime;
        n.time = time;
        n.style = style;
        n.root = root;
        n.kstyle = kstyle;
        n.kroot = kroot;
        n.syncid = syncid;
        n.set();

        n.setLayer(language,subject,keywords,description,text,picture,alt,align,voice,clickurl,srcurl,srcurlx,filename,file,mms);

        return n._nNode;
    }

    static String ID = "1310";
    private static int get() throws SQLException
    {
        return Integer.parseInt(ID + Seq.DF4.format(Seq.get(ID)));
    }

    void setChild(boolean b) throws SQLException
    {
        Enumeration e = Node.find(" AND node IN(" + path.substring(1).replace('/',',') + "0)",0,Integer.MAX_VALUE);
        DbAdapter db = new DbAdapter();
        try
        {
            db.setAutoCommit(false);
            while(e.hasMoreElements())
            {
                int node = ((Integer) e.nextElement()).intValue();
                Node n = Node.find(node);
                n.getPath();
                n.child += b ? 1 : -1;
                db.executeUpdate(node,"UPDATE Node SET child=" + n.child + " WHERE node=" + node);
            }
        } finally
        {
            db.setAutoCommit(true);
            db.close();
        }
    }

    public void set() throws SQLException
    {
        String sql;
        this.updatetime = new Date();
        if(_nNode < 1)
        {
            level = 2;
            _nNode = Seq.get();
            //do
            //{
            //    _nNode = get();
            //} while(Node.isExisted(_nNode));
            Node f = Node.find(father);
            path = (father > 0 ? f.getPath() : "/") + _nNode + "/";
            sql = "INSERT INTO Node(node,father,sequence,community,member,rcreator,vcreator,time,type,hidden,options,options1,starttime,stoptime,path,defaultlanguage,click,template,finished,style," +
                  "root,mostly,mostly1,mostly2,mark,hot,updatetime,kstyle,kroot,child,source,accessmembersnode,auditmember,audittime,extend,syncid)VALUES(" + _nNode + "," + father + "," + sequence + "," + DbAdapter.cite(community) + "," + member + "," + DbAdapter.cite(creator._strR) + "," + DbAdapter.cite(creator._strV) + "," + DbAdapter.cite(time) + "," + type + "," + DbAdapter.cite(hidden) + "," + options + "," + options1 + ","
                  + DbAdapter.cite(starttime) + "," + DbAdapter.cite(stopTime) + "," + DbAdapter.cite(path) + "," + defaultLanguage + "," + 0 + "," + template + "," + finished + "," + style + "," + root + "," + DbAdapter.cite(mostly) + "," + DbAdapter.cite(mostly1) + "," + DbAdapter.cite(mostly2) + "," + DbAdapter.cite(mark) + "," + hot + "," + DbAdapter.cite(updatetime) + "," + kstyle + "," + kroot + "," + child + "," + source + "," + DbAdapter.cite(accessmembersnode) + "," + DbAdapter.cite(auditmember) + "," + DbAdapter.cite(audittime) + "," + DbAdapter.cite(extend) + "," + DbAdapter.cite(syncid) + ")";
            if(father > 0)
                f.setChild(true);
        } else
        {
            sql = "UPDATE Node SET options=" + options + ",sequence=" + sequence + ",defaultlanguage=" + defaultLanguage + ",starttime=" + DbAdapter.cite(starttime) + ",stoptime=" + DbAdapter.cite(stopTime) + ",time=" + DbAdapter.cite(time) + ",style=" + style + ",root=" + root + ",mostly=" + DbAdapter.cite(mostly) + ",mostly1=" + DbAdapter.cite(mostly1) + ",mostly2=" + DbAdapter.cite(mostly2) + ",mark=" + DbAdapter.cite(mark) + ",hot=" + hot + ",updatetime=" + DbAdapter.cite(updatetime) + ",kstyle=" + kstyle + ",kroot=" + kroot + ",child=" + child + ",source=" + source + ",accessmembersnode=" + DbAdapter.cite(accessmembersnode) + ",auditmember=" + DbAdapter.cite(auditmember) + ",audittime=" + DbAdapter.cite(audittime) + " WHERE node=" + _nNode;
        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(_nNode,sql);
        } finally
        {
            db.close();
        }
    }

    public void setLayer(int language,String subject,String keywords,String description,String text,String picture,String alt,int align,String voice,String clickurl,String srcurl,String srcurlx,String filename,String filedata,String mms) throws SQLException
    {
        String[] arr = DbAdapter.split("NodeLayer","content",text,"node=" + _nNode + " AND language=" + language);
        StringBuilder sl = new StringBuilder("UPDATE NodeLayer SET subject=");
        sl.append(DbAdapter.cite(subject));
        sl.append(",keywords=").append(DbAdapter.cite(keywords));
        sl.append(",description=").append(DbAdapter.cite(description));
        sl.append(",content=").append(DbAdapter.cite(arr[0]));
        sl.append(",alt=").append(DbAdapter.cite(alt)).append(",align=").append(align).append(",clickurl=").append(DbAdapter.cite(clickurl)).append(",srcurl=").append(DbAdapter.cite(srcurl)).append(",srcurlx=").append(DbAdapter.cite(srcurlx));
        if(picture != null)
        {
            sl.append(",picture=").append(DbAdapter.cite(picture));
        }
        if(voice != null)
        {
            sl.append(",voice=").append(DbAdapter.cite(voice));
        }
        if(filedata != null)
        {
            sl.append(",filedata=").append(DbAdapter.cite(filedata));
            sl.append(",filename=").append(DbAdapter.cite(filename));
        } else
            filedata = "|";
        if(mms != null)
        {
            sl.append(",mms=").append(DbAdapter.cite(mms));
        }
        sl.append(" WHERE node=").append(_nNode).append(" AND language=").append(language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.setAutoCommit(false);
            int j = db.executeUpdate(_nNode,sl.toString());
            if(j < 1)
            {
                db.executeUpdate(_nNode,"INSERT INTO NodeLayer(node,language,subject,keywords,description,content,picture,alt,align,voice,clickurl,srcurl,srcurlx,filename,filedata,mms)VALUES(" + _nNode + "," + language + "," + DbAdapter.cite(subject) + "," + DbAdapter.cite(keywords) + "," + DbAdapter.cite(description) + "," + DbAdapter.cite(arr[0]) + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(alt) + "," + align + "," + DbAdapter.cite(voice) + "," + DbAdapter.cite(clickurl) + "," + DbAdapter.cite(srcurl) + "," + DbAdapter.cite(srcurlx) + "," + DbAdapter.cite(filename) + "," + DbAdapter.cite(filedata) + "," + DbAdapter.cite(mms) + ")");
            }
            for(int i = 1;i < arr.length;i++)
            {
                db.executeUpdate(_nNode,arr[i]);
            }
        } finally
        {
            db.setAutoCommit(true);
            db.close();
        }
        layer.clear();
        languages = null;
    }

    public static int create(int father,int sequence,String community,RV rv,int type,boolean hidden,long options,int options1,int defaultlanguage,Date starttime,Date stoptime,Date time,int template,int style,int root,int kstyle,int kroot,String syncid) throws SQLException
    {
        Node n = new Node(0);
        n.father = father;
        n.sequence = sequence;
        n.community = community;
        n.creator = rv;
        n.type = type;
        n.hidden = hidden;
        n.options = options;
        n.options1 = options1;
        n.defaultLanguage = defaultlanguage;
        n.starttime = starttime;
        n.stopTime = stoptime;
        n.time = time;
        n.template = template;
        n.style = style;
        n.root = root;
        n.kstyle = kstyle;
        n.kroot = kroot;
        n.syncid = syncid;
        n.set();
        return n._nNode;
    }

    /**
     * 获取审核状态
     * @param audit
     * @return
     */
    public String getAudit_str(int audit,Report robj)
    {

        String str = "";
        if(robj.getRefuse_audits() == 0)
        {
            if(audit == 0)
            {
                str = "等待一级初审";
            } else if(audit == 1)
            {
                str = "等待一级终审";
            } else if(audit == 2)
            {
                str = "等待二级初审";
            } else if(audit == 3)
            {
                str = "等待二级终审";
            } else if(audit == 4)
            {
                str = "审核通过";
            }
        } else
        {
            if(robj.getRefuse_audits() == 1)
            {
                str = "一级初审未通过";
            } else if(robj.getRefuse_audits() == 2)
            {
                str = "一级终审未通过";
            } else if(robj.getRefuse_audits() == 3)
            {
                str = "二级初审未通过";
            } else if(robj.getRefuse_audits() == 4)
            {
                str = "二级终审未通过";
            }
        }
        return str;
    }

    public int getDefaultLanguage() throws SQLException
    {
        load();
        return defaultLanguage;
    }

    private static String getSonsSql(int father,RV rv) throws SQLException
    {
        StringBuilder sb = new StringBuilder(" FROM Node  WHERE father=" + father + " AND finished=1");
        if(rv != null)
        {
            if(!find(father).isCreator(rv))
            {
                sb.append(" AND (((stoptime is null OR stoptime>" + DbAdapter.cite(new Date()) + ") AND hidden=0) " + " OR rcreator=" + DbAdapter.cite(rv._strR) + ") ");
            }
        } else
        {
            sb.append(" AND ((stoptime is null OR stoptime>" + DbAdapter.cite(new Date()) + ") AND hidden=0) ");
        }
        return sb.toString();
    }

    private static String getRequestsSql(int i) throws SQLException
    {
        Node n = Node.find(i);
        return " FROM Node WHERE path LIKE " + DbAdapter.cite(n.getPath() + "%") + " AND hidden=1 ";
    }

    public RV getCreator() throws SQLException
    {
        load();
        return creator;
    }

    public int getOptions1() throws SQLException
    {
        load();
        return options1;
    }

    public int getRecommended() throws SQLException
    {
        load();
        return recommended;
    }

    public static Enumeration findRequestNodes(RV rv,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT(f.node) " + getRequestNodesSql(rv),pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Node find(int _nNode)
    {
        Node obj = (Node) _cache.get(_nNode);
        if(obj == null)
        {
            obj = new Node(_nNode);
        }
        return obj;
    }

    //企业大全中的排序用到
    public static Enumeration findCompany(String sql,int pos,int size,String ordering) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select  n.node from Node n,Company c where n.node=c.node  " + sql + ordering);

            for(int i = 0;i < pos + size && db.next();i++)
            {
                if(i >= pos)
                {
                    v.addElement(new Integer(db.getInt(1)));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    //张金舒 通过商品的编号，获取商品的node节点
    public static int findNumber(String community,String number) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int n = 0;
        try
        {
            db.executeQuery("SELECT node FROM Node WHERE community =" + db.cite(community) + " AND goodsnumber=" + db.cite(number));
            if(db.next())
            {
                n = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return n;
    }

    public String getSubject(int language) throws SQLException
    {
        NLayer l = (NLayer) layer.get(language);
        return(l == null ? getLayer(language,language) : l).subject;
    }

    public void setSubject(String subject,int language) throws SQLException
    {
        set("subject",language,subject);
    }

    public void setAlt(String alt,int language) throws SQLException
    {
        set("alt",language,alt);
    }


    public void setFather(int father) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("update Node set father=" + father + " where node =  " + _nNode);
        } finally
        {
            db.close();
            layer.clear();
        }
        this.father = father;
    }

    public void set(String field,int language,String value) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            do
            {
                int j = db.executeUpdate("UPDATE NodeLayer SET " + field + "=" + DbAdapter.cite(value) + " WHERE node=" + _nNode + " AND language=" + language);
                if(j > 0)
                {
                    return;
                }
                db.executeUpdate("INSERT INTO NodeLayer(node,language, subject, keywords, content, picture,alt, align, voice, clickurl, srcurl, srcurlx, filename, filedata, mms)VALUES(" + _nNode + "," + language + "," + DbAdapter.cite(getSubject(language)) + "," + DbAdapter.cite(getKeywords(language)) + "," + DbAdapter.cite(getText(language)) + "," + DbAdapter.cite(getPicture(language)) + "," + DbAdapter.cite(getAlt(language)) + "," + getAlign(language) + ","
                                 + DbAdapter.cite(getVoice(language)) + "," + DbAdapter.cite(getClickUrl(language)) + "," + DbAdapter.cite(getSrcUrl(language)) + "," + DbAdapter.cite(getSrcUrlx(language)) + "," + DbAdapter.cite(getFileName(language)) + "," + DbAdapter.cite(getFile(language)) + "," + DbAdapter.cite(getMms(language)) + ")");

            } while(true);
        } finally
        {
            db.close();
            layer.clear();
        }
    }

    public void setContent(int language,String text) throws SQLException
    {
        String[] arr = DbAdapter.split("NodeLayer","content",text,"node=" + _nNode + " AND language=" + language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE NodeLayer SET content=" + db.cite(arr[0]) + " WHERE node=" + _nNode + " AND language=" + language);
            for(int i = 1;i < arr.length;i++)
            {
                db.executeUpdate(arr[i]);
            }
        } finally
        {
            db.close();
        }
    }

    public void set(int language,String subject,String text) throws SQLException
    {
        set("subject",language,subject);
        this.updatetime = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(_nNode,"UPDATE Node SET updatetime=" + db.cite(updatetime) + " WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
        this.setContent(language,text);
    }

    public void set(int language,String subject,String text,String fileName) throws SQLException
    {
        set("subject",language,subject);
        this.updatetime = new Date();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Node SET updatetime=" + db.cite(updatetime) + " WHERE node=" + _nNode);
            db.setText("NodeLayer","content",text,"node=" + _nNode + " AND language=" + language);
            db.setText("NodeLayer","filename",fileName,"node=" + _nNode + " AND language=" + language);
        } finally
        {
            db.close();
        }
    }

    public void setKeywords(String keywords,int language) throws SQLException
    {
        set("keywords",language,keywords);
    }

    public void setPicture(String picture,int language) throws SQLException
    {
        set("picture",language,picture);
    }

    public void setRepic(String _strRepic,int language) throws SQLException
    {
        set("repic",language,_strRepic);
    }

    public void setFile(String file,int language) throws SQLException
    {
        set("filedata",language,file);
    }

    public void setFileName(String fileName,int language) throws SQLException
    {
        set("filename",language,fileName);
    }


    public String getAlt(int i) throws SQLException
    {
        return getLayer(i,i)._strAlt;
    }

    public String getClickUrl(int i) throws SQLException
    {
        return getLayer(i,i).clickurl;
    }

    public String getSrcUrl(int i) throws SQLException
    {
        return getLayer(i,i)._strSrcUrl;
    }

    public String getSrcUrlx(int i) throws SQLException
    {
        return getLayer(i,i)._strSrcUrlx;
    }

    public int getDirection(int i) throws SQLException
    {
        return getLayer(i,i)._nDirection;
    }

    public String getFileName(int language) throws SQLException
    {
        return getLayer(language,language)._strFileName;
    }

    public String getMms(int language) throws SQLException
    {
        return getLayer(language,language)._strMms;
    }

    public void grant() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Node  SET hidden=0  WHERE node=" + _nNode);
        } catch(Exception ex)
        {
        } finally
        {
            db.close();
        }
        hidden = false;
    }


    public boolean isHidden() throws SQLException
    {
        load();
        return hidden;
    }

    public static int findNext(int father,int node,RV rv) throws SQLException
    {
        int k = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            k = db.getInt("SELECT  node " + getSonsSql(father,rv) + " AND node>" + node + " ORDER BY node ASC ");
        } finally
        {
            db.close();
        }
        return k;
    }

    //
    static HashMap hm = new HashMap();
    public void click() throws SQLException
    {
        ++click;
        //hm.put(_nNode,++click);
        //if(hm.size() > 100)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeUpdate("UPDATE Node SET click=click+1 WHERE node=" + _nNode);
            } finally
            {
                db.close();
            }
        }
    }

    public int getClick() throws SQLException
    {
        load();
        return click;
    }

    public int getFather() throws SQLException
    {
        load();
        return father;
    }

    // 根据关键字查找相关节点
    public ArrayList getCorrelation(int language,int type) throws SQLException
    {
        return getCorrelation(language,type,0,null);
    }

    public ArrayList getCorrelation(int language,int type,int top,Date time) throws SQLException
    {
        if(kstyle != 0)
        {
            String keyword = getKeywords(language);
            if(keyword != null && keyword.length() > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.append(" AND n.hidden=0 AND n.kstyle!=0 AND n.type=" + type + " AND n.community=" + DbAdapter.cite(getCommunity()) + " AND nl.language=" + language + " AND n.node!=" + _nNode);
                if(time != null)
                {
                    sb.append(" AND n.starttime>=" + DbAdapter.cite(time));
                }
                switch(kstyle)
                {
                case 1:
                    sb.append(" AND n.path LIKE '" + getPath() + "%'");
                    break;
                case 2:
                    sb.append(" AND n.community=" + DbAdapter.cite(community));
                    break;
                case 3:
                    sb.append(" AND n.path LIKE '" + Node.find(kroot).getPath() + "%'");
                    break;
                }
                sb.append(" AND (");
                StringTokenizer st = new StringTokenizer(keyword," ");
                sb.append(" nl.keywords LIKE " + DbAdapter.cite("%" + this.getSubject(language) + "%"));
                while(st.hasMoreTokens())
                {
                    sb.append(" OR nl.keywords LIKE " + DbAdapter.cite("%" + st.nextToken() + "%"));
                }
                sb.append(")");
                sb.append(" ORDER BY n.starttime DESC");
                return find1(sb.toString(),language,0,top);
            }
        }
        return new ArrayList(0);
    }

    public static Enumeration findSons(int father,RV rv,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node " + getSonsSql(father,rv) + " ORDER BY time DESC",pos,size);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int count(String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(n.node) FROM Node n" + tab(sql) + " WHERE 1=1" + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node FROM Node n" + tab(sql) + " WHERE 1=1" + sql,pos,size);
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND nl."))
            sb.append(" INNER JOIN NodeLayer nl ON nl.node=n.node");
        if(sql.contains(" AND c."))
            sb.append(" INNER JOIN Category c ON c.node=n.node");
        if(sql.contains(" AND pr."))
            sb.append(" INNER JOIN Product pr ON pr.node=n.node");
        if(sql.contains(" AND bl."))
            sb.append(" INNER JOIN Booklayer bl ON bl.node=n.node");
        if(sql.contains(" AND b."))
            sb.append(" INNER JOIN Book b ON b.node=n.node");
        if(sql.contains(" AND ns."))
            sb.append(" INNER JOIN NightShop ns ON ns.node=n.node");
        if(sql.contains(" AND sv."))
            sb.append(" INNER JOIN Service sv ON sv.node=n.node");
        return sb.toString();
    }

    //新闻方法
    public static int countReport(String community,String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(n.node) FROM Node n,Report r WHERE n.node=r.node  AND  community=" + db.cite(community) + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static Enumeration findReport(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node FROM Node n,Report r WHERE n.node=r.node AND  community=" + db.cite(community) + sql,pos,size);

            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    //zhangjinshu 2009-06-10
    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node FROM Node n,Goods g,NodeLayer nl WHERE n.node=g.node AND nl.node=n.node AND  community=" + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    public static int count(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(n.node) FROM Node n,Goods g,NodeLayer nl  WHERE n.node=g.node AND nl.node=n.node  AND  community=" + db.cite(community) + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int countCompany(String sql) throws SQLException
    {
        int count = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(n.node) from Node n,Company c where n.node=c.node" + sql);
            if(db.next())
            {
                count = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return count;
    }

    public static Enumeration findPhotography(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node FROM Node n,Photography p,NodeLayer nl,PhotographyLayer pl WHERE n.node=p.node AND nl.node=n.node AND p.node=pl.node " +
                            "  AND  community=" + db.cite(community) + sql + "  group by n.node  ",pos,size);
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int countPhotography(String community,String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(distinct(n.node)) FROM Node n,Photography p,NodeLayer nl ,PhotographyLayer pl  WHERE n.node=p.node AND nl.node=n.node AND p.node=pl.node AND  community=" + db.cite(community) + sql);
            if(db.next())
            {
                j = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration findPhotography_np(String community,String o,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node , " + o + " FROM Node n,Photography p,NodeLayer nl,PhotographyLayer pl WHERE n.node=p.node AND nl.node=n.node AND p.node=pl.node " +
                            "  AND  community=" + db.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.add(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }


    // @author huangyu:
    public static Enumeration findhy(String sql,int pos,int pageSize) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node,n.time,n.father FROM Node n WHERE 1=1" + sql);
            for(int l = 0;l < pos + pageSize && db.next();l++)
            {
                if(l >= pos)
                {
                    v.addElement(db.getInt(1));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findSons(int i,RV rv,int j,int k,int sorttype,int sort) throws SQLException
    {
        StringBuilder sql = new StringBuilder("SELECT node ");
        sql.append(getSonsSql(i,rv)).append(" ORDER BY ");

        switch(sorttype)
        {
        case 0:
            sql.append("time");
            break;
        case 1:
            sql.append("click");
            break;
        case 9:
            sql.append("sequence");
            break;
        case 10:
            sql.append("click");
            break;
        case 12:
            sql.append("path");
            break;
        case 13:
            sql.append("updatetime");
            break;
        default:
            sql.append("time");
        }
        if(sort <= 1)
        {
            sql.append(" ASC");
        } else
        {
            sql.append(" DESC");
        }

        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql.toString());
            for(int l = 0;l < j + k && db.next();l++)
            {
                if(l >= j)
                {
                    v.addElement(db.getInt(1));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findSons(int father) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Node WHERE father=" + father + " AND ((stoptime is null OR stoptime>" + db.citeCurTime() + ") AND hidden=0) " + " ORDER BY sequence");
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int findBySyncId(String syncid) throws SQLException
    {
        int node = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Node WHERE syncid=" + db.cite(syncid));
            if(db.next())
            {
                node = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return node;
    }

    // zhang_jinshu 08-12.29 update通过添加 标书节点 发布人
    public static int getNC(String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        int n = 0;
        try
        {
            db.executeQuery("SELECT node FROM Node WHERE community=" + db.cite(community) + " AND rcreator = " + db.cite(member) + " AND type = 21 ");
            if(db.next())
            {
                n = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return n;
    }

    public static Enumeration findAllSons(int father) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM Node WHERE father=" + father);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int getMaxSequence(int i) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT MAX(sequence) FROM Node WHERE father=" + i);
        } finally
        {
            db.close();
        }
        return j;
    }

    public static Enumeration findRequests(int i,int j,int k) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node " + getRequestsSql(i) + " ORDER BY time");
            for(int l = 0;l < j + k && db.next();l++)
            {
                if(l >= j)
                {
                    v.addElement(db.getInt(1));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public long getOptions() throws SQLException
    {
        load();
        return options;
    }

    public int getAlign(int i) throws SQLException
    {
        return getLayer(i,i)._nAlign;
    }

    private void load() throws SQLException
    {
        if(level != 2)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT father,sequence,community,member,rcreator,vcreator,time,type,hidden,options,options1,defaultlanguage,starttime,stoptime,path,click,finished,style," +
                                " root,mostly,mostly1,mostly2,mark,hot,updatetime,kstyle,kroot,child,extend,syncid,goodsnumber,categoryosubscribe,source,audits,auditmember,audittime,accessmembersnode,recommended FROM Node WHERE node=" + _nNode);
                if(db.next())
                {
                    int j = 1;
                    father = db.getInt(j++);
                    sequence = db.getInt(j++);
                    community = db.getString(j++);
                    member = db.getInt(j++);
                    creator = new RV(db.getString(j++),db.getString(j++));
                    time = db.getDate(j++);
                    type = db.getInt(j++);
                    hidden = db.getInt(j++) != 0;
                    options = db.getLong(j++);
                    options1 = db.getInt(j++);
                    defaultLanguage = db.getInt(j++);
                    starttime = db.getDate(j++);
                    stopTime = db.getDate(j++);
                    path = db.getString(j++);
                    click = db.getInt(j++);
                    finished = db.getInt(j++);
                    style = db.getInt(j++);
                    root = db.getInt(j++);
                    mostly = db.getInt(j++) != 0;
                    mostly1 = db.getInt(j++) != 0;
                    mostly2 = db.getInt(j++) != 0;
                    mark = db.getString(j++);
                    hot = db.getInt(j++);
                    updatetime = db.getDate(j++);
                    kstyle = db.getInt(j++);
                    kroot = db.getInt(j++);
                    child = db.getInt(j++);
                    extend = db.getInt(j++) != 0;
                    syncid = db.getString(j++);
                    goodsnumber = db.getString(j++);
                    categoryosubscribe = db.getString(j++);
                    source = db.getInt(j++);
                    audits = db.getInt(j++);
                    auditmember = db.getString(j++);
                    audittime = db.getDate(j++);
                    accessmembersnode = db.getString(j++);
                    recommended = db.getInt(j++);
                    _cache.put(_nNode,this);
                } else
                {
                    defaultLanguage = 1; // 简体中文
                    extend = true;
                }
            } finally
            {
                db.close();
            }
            level = 2;
        }
    }

    public static ArrayList find1(String sql,int language,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT n.node" + (pos == 0 ? ",n.type,n.starttime,nl.language,nl.subject,nl.description,nl.picture" : "") + " FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node WHERE n.finished=1" + sql,pos,size);
            while(db.next())
            {
                int j = 1;
                int id = db.getInt(j++);
                Node t;
                if(pos == 0)
                {
                    t = (Node) _cache.get(id);
                    if(t == null)
                    {
                        t = new Node(id);
                        Node._cache.put(id,t);
                        t.level = 1;
                    }
                    t.type = db.getInt(j++);
                    t.starttime = db.getDate(j++);
                    Node.NLayer l = (Node.NLayer) t.layer.get(language);
                    if(l == null)
                    {
                        l = t.new NLayer();
                        t.layer.put(language,l);
                        l.level = 1;
                    }
                    int lang = db.getInt(j++);
                    l.subject = db.getVarchar(lang,language,j++);
                    l.description = db.getVarchar(lang,language,j++);
                    l.picture = db.getString(j++);
                } else
                    t = Node.find(id);
                al.add(t);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    public boolean isCreator(RV rv) throws SQLException
    {
        if(rv == null)
        {
            return false;
        }
        RV rv1 = getCreator();
        if(rv1 == null)
        {
            return false;
        } else
        {
            return rv1._strR.equals(rv._strR) && rv1._strV.equals(rv._strV);
        }
    }

    public boolean isCreator(int member) throws SQLException
    {
        if(member < 1)
        {
            return false;
        }
        RV rv1 = getCreator();
        if(rv1 == null)
        {
            return false;
        }
        return rv1._strR.equals(Profile.find(member).getMember());
    }

    public String getPath() throws SQLException
    {
        load();
        return path;
    }

    public String getCategoryosubscribe() throws SQLException
    {
        load();
        return categoryosubscribe;
    }

    public int getSource() throws SQLException
    {
        load();
        return source;
    }

    public Vector getLanguages() throws SQLException
    {
        if(languages == null)
        {
            languages = new Vector();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT language FROM NodeLayer WHERE node=" + _nNode);
                while(db.next())
                {
                    languages.addElement(db.getInt(1));
                }
            } finally
            {
                db.close();
            }
        }
        return languages;
    }

    public int getType() throws SQLException
    {
        if(level == 0)
            load();
        return type;
    }

    public Date getStartTime() throws SQLException
    {
        if(level == 0)
            load();
        return starttime;
    }

    public Date getStopTime() throws SQLException
    {
        load();
        return stopTime;
    }

    private NLayer getLayer(int i,int j) throws SQLException
    {
        NLayer t = (NLayer) layer.get(i);
        if(t == null || t.level != 2)
        {
            t = new NLayer();
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT subject,alt,align,picture,picture2,voice,clickurl,srcurl,srcurlx,direction,filename,filedata,keywords,description,mms,repic FROM NodeLayer WHERE node=" + _nNode + " AND language=" + j);
                if(db.next())
                {
                    int z = 1;
                    t.subject = db.getVarchar(j,i,z++);
                    t._strAlt = db.getVarchar(j,i,z++);
                    t._nAlign = db.getInt(z++);
                    t.picture = db.getString(z++);
                    t.picture2 = db.getInt(z++);
                    t._strVoice = db.getString(z++);
                    t.clickurl = db.getString(z++);
                    t._strSrcUrl = db.getString(z++);
                    t._strSrcUrlx = db.getString(z++);
                    t._nDirection = db.getInt(z++);
                    t._strFileName = db.getVarchar(j,i,z++);
                    t._strFile = db.getString(z++);
                    t.keywords = db.getVarchar(j,i,z++);
                    t.description = db.getVarchar(j,i,z++);
                    t._strMms = db.getVarchar(j,i,z++);
                    t._strRepic = db.getVarchar(j,i,z++);
                }
            } finally
            {
                db.close();
            }
            if(i == j && t.subject == null && (j = getLanguage(_nNode,i)) != i)
            {
                return getLayer(i,j);
            }
            t.level = 2;
            layer.put(i,t);
        }
        return t;
    }

    private static String getRequestNodesSql(RV rv)
    {
        return " FROM Node n, Node f  WHERE n.hidden=1  AND n.father=f.node  AND f.rcreator=" + DbAdapter.cite(rv._strR);
    }

    private static String getSearchSql(String s,int i,int j,int k,int l,String s1,int i1,int j1,String s2,int k1,String s3) throws SQLException
    {
        StringBuilder stringbuffer = new StringBuilder(" FROM Node n ");
        StringBuilder stringbuffer1 = new StringBuilder(" WHERE 1=1 ");
        StringBuilder stringbuffer2 = new StringBuilder();
        if(j != 255)
        {
            stringbuffer1.append(" AND n.type=" + j);
        }
        if(k != 0)
        {
            stringbuffer1.append(" AND n.typealias=" + k);
        }
        if(s.length() != 0)
        {
            stringbuffer.append(", NodeLayer nl ");
            stringbuffer1.append(" AND nl.node=n.node  AND nl.language=" + i);
            stringbuffer2.append(" AND ( ");
            stringbuffer2.append(" ( ");
            stringbuffer2.append(" nl.subject LIKE " + DbAdapter.cite("%" + s + "%"));
            stringbuffer2.append(" ) ");
            if(j == 12)
            {
                stringbuffer.append(", Book b ");
                stringbuffer1.append(" AND b.node=n.node ");
                stringbuffer2.append(" OR ( b.isbn LIKE " + DbAdapter.cite("%" + s + "%") + " ) ");
            }
            stringbuffer2.append(" ) ");
        }
        if(k1 == 1)
        {
            stringbuffer.append(", Author a, AuthorLayer al ");
            stringbuffer1.append(" AND a.node=n.node  AND al.author=a.author  AND al.language=" + i + " AND al.name=" + DbAdapter.cite(s3));
        }
        if(i1 == 0)
        {
            Node node = find(j1);
            stringbuffer1.append(" AND n.community=" + DbAdapter.cite(node.getCommunity()) + " AND n.path LIKE " + DbAdapter.cite(node.getPath() + "%"));
        } else if(i1 == 1)
        {
            stringbuffer1.append(" AND n.community=" + DbAdapter.cite(s2));
        } else
        {
            stringbuffer.append(", Community c ");
            stringbuffer1.append(" AND n.community=c.community ");
            stringbuffer1.append(" AND c.type=1");
        }
        if(l == 1)
        {
            stringbuffer1.append(" AND n.rcreator=" + DbAdapter.cite(s1));
        } else if(l == 2)
        {
            stringbuffer1.append(" AND n.vcreator=" + DbAdapter.cite(s1));
        } else if(l == 3)
        {
            stringbuffer1.append(" AND n.node IN  (SELECT n.node " + stringbuffer.toString() + ", Node f " + stringbuffer1.toString() + stringbuffer2.toString() + " AND n.father=f.node " + " AND f.rcreator=" + DbAdapter.cite(s1) + ") ");
        } else if(l == 4)
        {
            stringbuffer1.append(" AND n.node IN  (SELECT n.node " + stringbuffer.toString() + ", Node f " + stringbuffer1.toString() + stringbuffer2.toString() + " AND n.father=f.node " + " AND f.vcreator=" + DbAdapter.cite(s1) + ") ");
        } else if(l == 5)
        {
            stringbuffer1.append(" AND n.node IN  (SELECT n.node " + stringbuffer.toString() + ", Node s " + stringbuffer1.toString() + stringbuffer2.toString() + "  AND n.node=s.father " + "  AND s.rcreator=" + DbAdapter.cite(s1) + ") ");
        } else if(l == 6)
        {
            stringbuffer1.append(" AND n.node IN  (SELECT n.node " + stringbuffer.toString() + ", Node s " + stringbuffer1.toString() + stringbuffer2.toString() + "  AND n.node=s.father " + "  AND s.vcreator=" + DbAdapter.cite(s1) + ") ");
        } else if(l == 7)
        {
            stringbuffer1.append(" AND n.node IN  (SELECT n.node " + stringbuffer.toString() + ", Node s, Node gs " + stringbuffer1.toString() + stringbuffer2.toString() + "  AND n.node=s.father " + "  AND s.node=gs.father " + "  AND gs.rcreator=" + DbAdapter.cite(s1) + ") ");
        } else if(l == 8)
        {
            stringbuffer1.append(" AND n.node IN  (SELECT n.node " + stringbuffer.toString() + ", Node s, Node gs " + stringbuffer1.toString() + stringbuffer2.toString() + "  AND n.node=s.father " + "  AND s.node=gs.father " + "  AND gs.vcreator=" + DbAdapter.cite(s1) + ") ");
        }
        return stringbuffer.toString() + stringbuffer1.toString() + stringbuffer2.toString();
    }

    public static int countMyNodes(String rcreator,int type) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT COUNT(node)  FROM Node  WHERE rcreator=" + DbAdapter.cite(rcreator) + " AND type=" + type);
        } finally
        {
            db.close();
        }
        return j;
    }

    public String getRealSubject(int i) throws SQLException
    {
        int j = _nNode;
        if((getOptions() & 0x40000) != 0)
        {
            if(getType() == 1)
            {
                j = getFather();
            } else
            {
                j = find(getFather()).getFather();
            }
        }
        return find(j).getSubject(i);
    }

    public void set(int sequence,long options,int defaultlanguage,Date starttime,Date stoptime,int language,String subject,String keywords,String description,String text,String picture,String alt,int align,String voice,String clickurl,String srcurl,String srcurlx,String filename,String filedata,Date time,int style,int root) throws SQLException
    {
        set(sequence,options,defaultlanguage,starttime,stoptime,language,subject,keywords,description,text,picture,alt,align,voice,clickurl,srcurl,srcurlx,filename,filedata,time,style,root,0,0,null);
    }

    public void set(int sequence,long options,int defaultlanguage,Date starttime,Date stoptime,int language,String subject,String keywords,String description,String text,String picture,String alt,int align,String voice,String clickurl,String srcurl,String srcurlx,String filename,String filedata,Date time,int style,int root,int kstyle,int kroot,String mms) throws SQLException
    {
        this.sequence = sequence;
        this.options = options;
        this.defaultLanguage = defaultlanguage;
        this.starttime = starttime;
        this.stopTime = stoptime;
        this.time = time;
        this.style = style;
        this.root = root;
        this.kstyle = kstyle;
        this.kroot = kroot;
        this.set();
        this.setLayer(language,subject,keywords,description,text,picture,alt,align,voice,clickurl,srcurl,srcurlx,filename,filedata,mms);
    }

    public void setHidden(boolean hidden) throws SQLException
    {
        set("hidden",(hidden ? "1" : "0"));
        this.hidden = hidden;
    }

    public void set(Date date,Date date1) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Node  SET starttime=" + db.cite(date) + ", stoptime=" + db.cite(date1) + " WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
        this.starttime = date;
        this.stopTime = date1;
    }

    //更换作者
    public void set(RV rv) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(_nNode,"UPDATE Node SET member=" + Profile.find(rv._strR).getProfile() + ",rcreator=" + DbAdapter.cite(rv._strR) + ", vcreator=" + DbAdapter.cite(rv._strV) + " WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
        this.creator = rv;
    }

    public void set(String field,Date value) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(_nNode,"UPDATE Node SET " + field + "=" + DbAdapter.cite(value) + " WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
    }

    public void set(String field,String value) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(_nNode,"UPDATE Node SET " + field + "=" + DbAdapter.cite(value) + " WHERE node=" + _nNode);
        } finally
        {
            _cache.remove(_nNode);
            db.close();
        }
    }

    //修改信息来源
    public void setSource(int source) throws SQLException
    {
        set("source",String.valueOf(source));
        this.source = source;
    }

    //修改是否显示发行管理
    public void setCategoryosubscribe(String categoryosubscribe) throws SQLException
    {
        set("categoryosubscribe",String.valueOf(categoryosubscribe));
        this.categoryosubscribe = categoryosubscribe;
    }

    //截取字符
    public static String bSubstring(String s,int length) throws Exception
    {

        byte[] bytes = s.getBytes("Unicode");
        int n = 0; // 表示当前的字节数
        int i = 2; // 要截取的字节数，从第3个字节开始
        for(;i < bytes.length && n < length;i++)
        {
            // 奇数位置，如3、5、7等，为UCS2编码中两个字节的第二个字节
            if(i % 2 == 1)
            {
                n++; // 在UCS2第二个字节时n加1
            } else
            {
                // 当UCS2编码的第一个字节不等于0时，该UCS2字符为汉字，一个汉字算两个字节
                if(bytes[i] != 0)
                {
                    n++;
                }
            }
        }
        // 如果i为奇数时，处理成偶数
        if(i % 2 == 1)

        {
            // 该UCS2字符是汉字时，去掉这个截一半的汉字
            if(bytes[i - 1] != 0)
                i = i - 1;
            // 该UCS2字符是字母或数字，则保留该字符
            else
                i = i + 1;
        }

        return new String(bytes,0,i,"Unicode");
    }

    public void setOptions(long options) throws SQLException
    {
        set("options",String.valueOf(options));
        this.options = options;
    }

    public void set(long options,int kstyle,int style,String accessmembersnode) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Node SET options=" + options + ",kstyle=" + kstyle + ",style=" + style + ", accessmembersnode=" + db.cite(accessmembersnode) + " WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
        this.options = options;
        this.kstyle = kstyle;
        this.style = style;
        this.accessmembersnode = accessmembersnode;
    }

    public void setOptions1(int options1) throws SQLException
    {
        set("options1",String.valueOf(options1));
        this.options1 = options1;
    }

    public Node(int i)
    {
        _nNode = i;
        level = 0;
        path = null;
        layer = new Hashtable();
        languages = null;
    }

    //更换作者：对本树所有节点生效
    public static void set(String s,String s1,RV rv,RV rv1) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"UPDATE Node SET rcreator=" + DbAdapter.cite(rv1._strR) + ", vcreator=" + DbAdapter.cite(rv1._strV) + " WHERE community=" + DbAdapter.cite(s) + " AND path LIKE " + DbAdapter.cite(s1 + "%") + " AND rcreator=" + DbAdapter.cite(rv._strR) + " AND vcreator=" + DbAdapter.cite(rv._strV));
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    //更换作者：对本社区所有节点生效
    public static void set(String s,RV rv,RV rv1) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(0,"UPDATE Node SET rcreator=" + DbAdapter.cite(rv1._strR) + ", vcreator=" + DbAdapter.cite(rv1._strV) + " WHERE community=" + DbAdapter.cite(s) + " AND rcreator=" + DbAdapter.cite(rv._strR) + " AND vcreator=" + DbAdapter.cite(rv._strV));
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public void setType(int type) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(_nNode,"UPDATE Node SET type=" + type + " WHERE father=" + _nNode);
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public void setStartTime(Date starttime) throws SQLException
    {
        set("starttime",starttime);
        this.starttime = starttime;
    }

    public static void setTypealias(int typealias,int node) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Node SET typealias=" + typealias + " WHERE node=" + node);
        } finally
        {
            db.close();
        }
        _cache.clear();
    }


    public void setStopTime(Date stoptime) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Node SET stoptime=" + db.cite(stoptime) + " WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
        _cache.clear();

    }


//编号
    public void setGoodsNumber(String goodsnumber) throws SQLException
    {
        set("goodsnumber",goodsnumber);
    }


    public boolean isLayerExisted(int language) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node FROM NodeLayer WHERE node=" + _nNode + " AND language=" + language);

            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public String getPicture(int language) throws SQLException
    {
        NLayer l = (NLayer) layer.get(language);
        return(l == null ? getLayer(language,language) : l).picture;
    }

    public int getPicture2(int language) throws SQLException
    {
        return getLayer(language,language).picture2;
    }

    public String getRepic(int i) throws SQLException
    {
        return getLayer(i,i)._strRepic;
    }

    public String getKeywords(int i) throws SQLException
    {
        return getLayer(i,i).keywords;
    }

    public String getDescription(int language) throws SQLException
    {
        NLayer l = (NLayer) layer.get(language);
        return(l == null ? getLayer(language,language) : l).description;
    }

    public String getAnchor(int language,int status) throws SQLException
    {
        if(ConnectionPool.isStatic)
            return "/" + (status == 0 ? "html" : "xhtml") + language + "/" + (getType() >= 1024 ? "node" : NODE_TYPE[getType()].toLowerCase()) + "/" + _nNode / 10000 + "/" + _nNode % 10000 + "-1.htm";
        else
            return "/" + (status == 0 ? "html" : "xhtml") + "/" + (getType() >= 1024 ? "node" : NODE_TYPE[getType()].toLowerCase()) + "/" + _nNode + "-1.htm";
    }

    private String getAnchor1(Http h) throws SQLException
    {
        String s1 = getSubject(h.language);
        if(s1 != null)
        {
            String p = getPicture(h.language);
            if(p != null && p.length() > 1)
            {
                s1 += new Image("/tea/image/picture.gif");
            }
        }
        return "<a href='/" + (h.status == 0 ? "html" : "xhtml") + "/" + h.community + "/" + (getType() >= 1024 ? "node" : NODE_TYPE[getType()].toLowerCase()) + "/" + _nNode + "-" + h.language + ".htm'>" + s1 + "</a>";
    }

    public Anchor getAnchor(int language) throws SQLException
    {
        return getAnchor(language,"_blank",null,Integer.MAX_VALUE);
    }

    public Anchor getAnchor(int language,String target,String key,int len) throws SQLException
    {
        String s1 = getSubject(language);
        if(s1 != null)
        {
            if(len > 0 && s1.length() > len)
            {
                s1 = s1.substring(0,len) + "...";
            }
            if(key != null)
            {
                s1 = s1.replaceAll(key,"<font color='red'>" + key + "</font>");
            }
            String p = getPicture(language);
            if(p != null && p.length() > 1)
            {
                s1 += new Image("/tea/image/picture.gif");
            }
            String v = getVoice(language);
            if(v != null && v.length() > 1)
            {
                s1 += new Image("/tea/image/voice.gif");
            }
            String f = getFile(language);
            if(f != null && f.length() > 1)
            {
                s1 += new Image("/tea/image/file.gif");
            }
        }
        Anchor anchor = new Anchor("/html/" + (getType() >= 1024 ? "node" : NODE_TYPE[getType()].toLowerCase()) + "/" + _nNode + "-" + language + ".htm",new Text(s1,isHidden()));
        anchor.setId(String.valueOf(getFather()));
        anchor.setTarget(target);
        return anchor;
    }

    public void deny() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Node WHERE path LIKE " + DbAdapter.cite(getPath() + "%"));
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    // public int getTypeAlias() throws SQLException
    // {
    // load();
    // return _nTypeAlias;
    // }

    public void delete(int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            //删除评论管理
            db.executeQuery("SELECT talkback FROM Talkback WHERE node=" + _nNode);
            while(db.next())
            {
                int t = db.getInt(1);
                db.executeQuery("SELECT talkback FROM TalkbackReply WHERE talkback=" + t);
                if(db.next())
                {
                    db.executeUpdate(_nNode,"DELETE FROM TalkbackReply WHERE talkback=" + t);
                }
            }
            db.executeUpdate(_nNode,"DELETE FROM Talkback WHERE node=" + _nNode);

            db.executeUpdate(_nNode,"DELETE FROM NodeLayer WHERE node=" + _nNode + " AND language=" + language);
            db.executeQuery("SELECT node FROM NodeLayer WHERE node=" + _nNode);
            if(!db.next())
            {
                db.executeQuery("SELECT node FROM Node WHERE path LIKE '" + this.getPath() + "%'");
                while(db.next())
                {
                    _cache.remove(db.getInt(1));
                }
                db.executeUpdate(_nNode,"UPDATE Node SET finished=2 WHERE path LIKE '" + this.getPath() + "%'");
                //db.executeUpdate(_nNode,"DELETE FROM Node WHERE node=" + _nNode);
            }
            try
            {
                db.executeUpdate(_nNode,"DELETE FROM " + Node.NODE_TYPE[type] + " WHERE node=" + _nNode + " AND language=" + language);
            } catch(Throwable ex)
            {
                ex.printStackTrace();
            }
        } finally
        {
            db.close();
        }
        _cache.remove(_nNode);
    }

    public static void delete(int node,int type,int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            if(type == 1 || type == 0)
            {

                db.executeUpdate("delete from NodeLayer where node in ( select node from Node where path like " + db.cite("%/" + node + "/%") + ") and language = " + language);
                db.executeUpdate("delete from Node where path like " + db.cite("%/" + node + "/%"));
                //System.out.println("delete from NodeLayer where node in ( select node from Node where path like "+db.cite("%/"+node+"/%")+") and language = "+language);
                //System.out.println("delete from Node where path like "+db.cite("%/"+node+"/%"));

            }
        } finally
        {
            db.close();
        }
        _cache.clear();
    }

    public void delete_nodeid(int language) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM NodeLayer WHERE node=" + _nNode + " AND language=" + language);
            db.executeUpdate("DELETE FROM Node WHERE node=" + _nNode);
        }

        finally
        {
            db.close();
        }
        _cache.remove(_nNode);
        _cache.clear();
    }

    // bool参数说明:控制最后一个路径是否有链接(如果为真则没有链接)
    public String getAncestor(int language,String target,boolean bool) throws SQLException
    {
        if(_nNode == 0)
        {
            return "";
        } else
        {
            if(bool)
            {
                bool = false;
                return find(getFather()).getAncestor(language,target,false) + ">" + getSubject(language);
            } else
            {
                Anchor anchor = new Anchor("/html/" + getCommunity() + "/" + (getType() >= 1024 ? "node" : NODE_TYPE[getType()].toLowerCase()) + "/" + _nNode + "-" + language + ".htm",new Text(getSubject(language)));
                return find(getFather()).getAncestor(language,target,false) + ">" + anchor;
            }
        }
    }

    public String getAncestor(int i) throws SQLException
    {
        return getAncestor(i,null);
    }

    public String getAncestor(int language,int status) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        String[] arr = getPath().split("/");
        for(int i = 1;i < arr.length;i++)
        {
            Node n = Node.find(Integer.parseInt(arr[i]));
            sb.append("<span id='PathID" + i + "'> > <a href='" + n.getAnchor(language,status) + "'>" + n.getSubject(language) + "</a></span>");
        }
        return sb.toString();
    }

    private static int ancestorindex = 0;
    public String getAncestor(int language,String target) throws SQLException
    {
        if(_nNode == 0)
        {
            ancestorindex = 0;
            return "";
        } else
        {
            StringBuilder sb = new StringBuilder(find(getFather()).getAncestor(language,target));
            Anchor a = new Anchor("/html/" + (getType() >= 1024 ? "node" : NODE_TYPE[getType()].toLowerCase()) + "/" + _nNode + "-" + language + ".htm",getSubject(language));
            a.setTarget(target);
            Span s = new Span(" > " + a);
            s.setId("PathID" + (++ancestorindex));
            sb.append(s.toString());
            return sb.toString();
        }
    }

    //内容管理中的后台栏目管理
    public String getAdminAncestor(int language) throws SQLException
    {
        if(_nNode == 0)
        {
            ancestorindex = 0;
            return "";
        } else
        {
            StringBuilder sb = new StringBuilder(find(getFather()).getAdminAncestor(language));

            Span s = new Span("> " + getSubject(language));

            s.setId("PathID" + (++ancestorindex));
            sb.append(s.toString());
            return sb.toString();
        }
    }

    public static String Html2Text(String inputString)
    {
        String htmlStr = inputString; //含html标签的字符串
        String textStr = "";
        java.util.regex.Pattern p_script;
        java.util.regex.Matcher m_script;
        java.util.regex.Pattern p_style;
        java.util.regex.Matcher m_style;
        java.util.regex.Pattern p_html;
        java.util.regex.Matcher m_html;

        try
        {
            String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; //定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script> }
            String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; //定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style> }
            String regEx_html = "<[^>]+>"; //定义HTML标签的正则表达式

            p_script = Pattern.compile(regEx_script,Pattern.CASE_INSENSITIVE);
            m_script = p_script.matcher(htmlStr);
            htmlStr = m_script.replaceAll(""); //过滤script标签

            p_style = Pattern.compile(regEx_style,Pattern.CASE_INSENSITIVE);
            m_style = p_style.matcher(htmlStr);
            htmlStr = m_style.replaceAll(""); //过滤style标签

            p_html = Pattern.compile(regEx_html,Pattern.CASE_INSENSITIVE);
            m_html = p_html.matcher(htmlStr);
            htmlStr = m_html.replaceAll(""); //过滤html标签

            textStr = htmlStr.replaceAll("&nbsp;","");

        } catch(Exception e)
        {
            System.err.println("Html2Text: " + e.getMessage());
        }

        return textStr; //返回文本字符串
    }


    public String getText(int i) throws SQLException
    {
        NLayer layer = getLayer(i,i);
        if(layer.text == null)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT language,content FROM NodeLayer WHERE node=" + _nNode + " ORDER BY " + (ConnectionPool._nType == 1 ? "DBO." : "") + "LAYER(language," + i + ")",0,1);
                if(db.next())
                {
                    layer.text = db.getText(db.getInt(1),i,2);
                }
            } finally
            {
                db.close();
            }
        }
        return layer.text;
    }

    public String getText2(int lang) throws SQLException
    {
        String value = getText(lang);
        if(style != 0)
        {
            NLayer layer = getLayer(lang,lang);
            if(layer.text2 == null)
            {
                int j = getLanguage(_nNode,lang);
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery("SELECT content2 FROM NodeLayer WHERE node=" + _nNode + " AND language=" + j);
                    if(db.next())
                    {
                        layer.text2 = db.getText(j,lang,1);
                    }
                } finally
                {
                    db.close();
                }
            }
            if(layer.text2 == null || layer.text2.length() == 0)
            {
                layer.text2 = getText(lang);
                String sql = null;
                switch(style)
                {
                case 1:
                    sql = " AND path LIKE '%/" + _nNode + "/%'";
                    break;
                case 2:
                    sql = " AND community=" + DbAdapter.cite(community);
                    break;
                case 3:
                    sql = " AND path LIKE '%/" + root + "/%'";
                    break;
                }
                DbAdapter db = new DbAdapter();
                try
                { // mssql:utf-8,无论中英文长度全都是2
                    db.executeQuery("SELECT n.node,n.type,nl.subject FROM Node n,NodeLayer nl WHERE n.node=nl.node AND " + db.length("nl.subject") + ">5 AND nl.language=" + lang + sql);
                    while(db.next())
                    {
                        int _nNode = db.getInt(1);
                        int type = db.getInt(2);
                        String subject = db.getVarchar(lang,lang,3);
                        if(layer.text2.indexOf(subject) != -1)
                        {
                            layer.text2 = (layer.text2.replaceAll(subject,"<a target='_blank' href='/html/" + getCommunity() + "/node/" + _nNode + "-" + lang + ".htm'>" + subject + "</a>"));
                        }
                    }
                    // db.executeUpdate("UPDATE Node SET
                    // content2="+DbAdapter.cite(layer.text2)+" WHERE " +
                    // sql);
                } finally
                {
                    db.close();
                }
                // return getText(i);
            }
            value = layer.text2;
        }
        String str[] = value.split("<div style=\"page-break-after: always\"><span style=\"display: none\">&nbsp;</span></div>");
        if(str.length > 1)
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder page = new StringBuilder();
            page.append("<span id='SPage'>");
            for(int i = 0;i < str.length;i++)
            {
                sb.append("<ins id='text_page'");
                if(i > 0)
                {
                    sb.append(" style='display:none'");
                }
                sb.append(">").append(str[i]).append("</ins>");

                if(i == 0 && str.length != 1)
                {
                    page.append("<a id='ContentPage' href='#' onclick='page(0)'>上一页</a> ");
                }
                if(str.length != 1)
                {
                    page.append("<a id='ContentPage' href='#' onclick='page(" + i + ")'>").append(i + 1).append("</a> ");
                }
                if(i == (str.length - 1) && str.length != 1)
                {
                    page.append("<a id='ContentPage' href='#' onclick='page(1)'>下一页</a> ");
                }
            }
            page.append("</span><script>page(0);</script>");
            value = sb.append(page).toString();

        }

        return value;
    }

    //英文字符分页
    public String getText2_en(int lang,int lang2) throws SQLException
    {
        String value = getText(lang);
        if(style != 0)
        {
            NLayer layer = getLayer(lang,lang);
            if(layer.text2 == null)
            {
                int j = getLanguage(_nNode,lang);
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery("SELECT content2 FROM NodeLayer WHERE node=" + _nNode + " AND language=" + j);
                    if(db.next())
                    {
                        layer.text2 = db.getText(j,lang,1);
                    }
                } finally
                {
                    db.close();
                }
            }
            if(layer.text2 == null || layer.text2.length() == 0)
            {
                layer.text2 = getText(lang);
                String sql = null;
                switch(style)
                {
                case 1:
                    sql = " AND path LIKE '%/" + _nNode + "/%'";
                    break;
                case 2:
                    sql = " AND community=" + DbAdapter.cite(community);
                    break;
                case 3:
                    sql = " AND path LIKE '%/" + root + "/%'";
                    break;
                }
                DbAdapter db = new DbAdapter();
                try
                { // mssql:utf-8,无论中英文长度全都是2
                    db.executeQuery("SELECT n.node,n.type,nl.subject FROM Node n,NodeLayer nl WHERE n.node=nl.node AND " + db.length("nl.subject") + ">5 AND nl.language=" + lang + sql);
                    while(db.next())
                    {
                        int _nNode = db.getInt(1);
                        int type = db.getInt(2);
                        String subject = db.getVarchar(lang,lang,3);
                        if(layer.text2.indexOf(subject) != -1)
                        {
                            layer.text2 = (layer.text2.replaceAll(subject,"<a target='_blank' href='/html/" + getCommunity() + "/node/" + _nNode + "-" + lang + ".htm'>" + subject + "</a>"));
                        }
                    }
                    // db.executeUpdate("UPDATE Node SET
                    // content2="+DbAdapter.cite(layer.text2)+" WHERE " +
                    // sql);
                } finally
                {
                    db.close();
                }
                // return getText(i);
            }
            value = layer.text2;
        }
        String str[] = value.split("<div style=\"page-break-after: always\"><span style=\"display: none\">&nbsp;</span></div>");
        if(str.length > 1)
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder page = new StringBuilder();
            page.append("<span id='SPage'>");
            for(int i = 0;i < str.length;i++)
            {
                sb.append("<ins id='text_page'");
                if(i > 0)
                {
                    sb.append(" style='display:none'");
                }
                sb.append(">").append(str[i]).append("</ins>");

                if(i == 0 && str.length != 1)
                {
                    if(lang2 == 0)
                    {
                        page.append("<a id='ContentPage' href='#' onclick='page(0)'>Previous Page</a> ");
                    } else
                    {
                        page.append("<a id='ContentPage' href='#' onclick='page(0)'>上一页</a> ");
                    }

                }
                if(str.length != 1)
                {
                    page.append("<a id='ContentPage' href='#' onclick='page(" + i + ")'>").append(i + 1).append("</a> ");
                }
                if(i == (str.length - 1) && str.length != 1)
                {
                    if(lang2 == 0)
                    {
                        page.append("<a id='ContentPage' href='#' onclick='page(1)'>Next Page</a> ");
                    } else
                    {
                        page.append("<a id='ContentPage' href='#' onclick='page(1)'>下一页</a> ");

                    }

                }
            }
            page.append("</span><script>page(0);</script>");
            value = sb.append(page).toString();

        }

        return value;
    }

//使用中的英文内容分页  是截取字符形式分页
    public String getText_for_en(int reportpos,int lang) throws SQLException
    {
        String value = getText(lang);
        if(style != 0)
        {
            NLayer layer = getLayer(lang,lang);
            if(layer.text2 == null)
            {
                int j = getLanguage(_nNode,lang);
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery("SELECT content2 FROM NodeLayer WHERE node=" + _nNode + " AND language=" + j);
                    if(db.next())
                    {
                        layer.text2 = db.getText(j,lang,1);
                    }
                } finally
                {
                    db.close();
                }
            }
            if(layer.text2 == null || layer.text2.length() == 0)
            {
                layer.text2 = getText(lang);
                String sql = null;
                switch(style)
                {
                case 1:
                    sql = " AND path LIKE '%/" + _nNode + "/%'";
                    break;
                case 2:
                    sql = " AND community=" + DbAdapter.cite(community);
                    break;
                case 3:
                    sql = " AND path LIKE '%/" + root + "/%'";
                    break;
                }
                DbAdapter db = new DbAdapter();
                try
                { // mssql:utf-8,无论中英文长度全都是2
                    db.executeQuery("SELECT n.node,n.type,nl.subject FROM Node n,NodeLayer nl WHERE n.node=nl.node AND " + db.length("nl.subject") + ">5 AND nl.language=" + lang + sql);
                    while(db.next())
                    {
                        int _nNode = db.getInt(1);
                        int type = db.getInt(2);
                        String subject = db.getVarchar(lang,lang,3);
                        if(layer.text2.indexOf(subject) != -1)
                        {
                            layer.text2 = (layer.text2.replaceAll(subject,"<a target='_blank' href='/html/" + getCommunity() + "/node/" + _nNode + "-" + lang + ".htm'>" + subject + "</a>"));
                        }
                    }
                    // db.executeUpdate("UPDATE Node SET
                    // content2="+DbAdapter.cite(layer.text2)+" WHERE " +
                    // sql);
                } finally
                {
                    db.close();
                }
                // return getText(i);
            }
            value = layer.text2;
        }

        String str = "<div style=\"page-break-after: always\"><span style=\"display: none\">&nbsp;</span></div>";

        String str_2 = "<div style=\"page-break-after: always;\"><span style=\"display: none;\">&nbsp;</span></div>";

        String str_3 = "<div style=\"page-break-after: always\"><span style=\"display: none\"> </span></div>";
        if((value != null) && (value.length() > 0) && (value.indexOf(str) == -1) && (value.indexOf(str_3) == -1))
        {
            str = str_2;
        } else if((value != null) && (value.length() > 0) && (value.indexOf(str) == -1) && (value.indexOf(str_2) == -1))
        {
            str = str_3;
        }
        // System.out.println(str);

        if(value != null && value.length() > 0 && value.indexOf(str) != -1)
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder page = new StringBuilder();

            String st[] = (str + value + str).split(str);

            sb.append(st[reportpos]);
            page.append("<div id ='ContentPageDIV'> ");
            // System.out.println((st.length));
            for(int i = 1;i < st.length;i++)
            {

                if(i == 1 && st.length != 1)
                {
                    page.append("<a id='ContentPage' href='/html/" + getCommunity() + "/report/" + _nNode + "-" + lang + ".htm?reportpos=" + (reportpos - 1) + "' >Previous Page</a> ");
                }
                if(st.length != 1)
                {

                    //   page.append("<a id='ContentPage' href='../report/"+_nNode+"-"+lang+".htm?reportpos="+i+"' >").append(i + 1).append("</a> ");
                    String cps = "ContentPage";
                    if(reportpos == i)
                    {
                        cps = "ContentPageCurrent";
                    }
                    page.append("<a id='" + cps + "'  ");
                    page.append("href='/html/" + this.getCommunity() + "/report/" + this._nNode + "-" + lang + ".htm?reportpos=" + i + "' >").append(i).append("</a> ");
                }

                if(i == (st.length - 1) && st.length != 1)
                {
                    page.append("<a id='ContentPage' href='/html/" + this.getCommunity() + "/report/" + _nNode + "-" + lang + ".htm?reportpos=");
                    if(reportpos >= (st.length - 1))
                    {
                        page.append((reportpos) + "'>Next Page</a> ");
                    } else
                    {
                        page.append((reportpos + 1) + "'>Next Page</a> ");
                    }
                }

            }
            page.append("</span><script>page(1);</script>");
            page.append("</div>");
            value = sb.append(page).toString();
        }

        return value;
    }


    public String getText_for(Http h,int reportpos) throws SQLException
    {
        String value = getText(h.language);
        if(style != 0)
        {
            NLayer layer = getLayer(h.language,h.language);
            if(layer.text2 == null)
            {
                int j = getLanguage(_nNode,h.language);
                DbAdapter db = new DbAdapter();
                try
                {
                    db.executeQuery("SELECT content2 FROM NodeLayer WHERE node=" + _nNode + " AND language=" + j);
                    if(db.next())
                    {
                        layer.text2 = db.getText(j,h.language,1);
                    }
                } finally
                {
                    db.close();
                }
            }
            if(layer.text2 == null || layer.text2.length() == 0)
            {
                layer.text2 = getText(h.language);
                String sql = null;
                switch(style)
                {
                case 1:
                    sql = " AND path LIKE '%/" + _nNode + "/%'";
                    break;
                case 2:
                    sql = " AND community=" + DbAdapter.cite(community);
                    break;
                case 3:
                    sql = " AND path LIKE '%/" + root + "/%'";
                    break;
                }
                DbAdapter db = new DbAdapter();
                try
                { // mssql:utf-8,无论中英文长度全都是2
                    db.executeQuery("SELECT n.node,n.type,nl.subject FROM Node n,NodeLayer nl WHERE n.node=nl.node AND " + db.length("nl.subject") + ">5 AND nl.language=" + h.language + sql);
                    while(db.next())
                    {
                        int _nNode = db.getInt(1);
                        int type = db.getInt(2);
                        String subject = db.getVarchar(h.language,h.language,3);
                        if(layer.text2.indexOf(subject) != -1)
                        {
                            layer.text2 = (layer.text2.replaceAll(subject,"<a target='_blank' href='/html/" + this.getCommunity() + "/node/" + _nNode + "-" + h.language + ".htm'>" + subject + "</a>"));
                        }
                    }
                    // db.executeUpdate("UPDATE Node SET
                    // content2="+DbAdapter.cite(layer.text2)+" WHERE " +
                    // sql);
                } finally
                {
                    db.close();
                }
                // return getText(i);
            }
            value = layer.text2;
        }
        if(value == null)
            return null;

        String str = "<div style=\"page-break-after: always;?\"><span style=\"display: ?none\">&nbsp;</span></div>";
        String[] arr = value.split(str);
        return arr.length > 1 ? arr[(reportpos = Math.min(arr.length,reportpos)) - 1] + "<div id='ContentPageDIV'>" + new tea.htmlx.FPNL2(h.language,getAnchor(h.language,h.status),reportpos,arr.length,1) + "</div>" : value;

        //String str_2 = "<div style=\"page-break-after: always;\"><span style=\"display: none;\">&nbsp;</span></div>";
        //String str_3 = "<div style=\"page-break-after: always\"><span style=\"display: none\"> </span></div>";
        //if((value != null) && (value.length() > 0) && (value.indexOf(str) == -1) && (value.indexOf(str_3) == -1))
        //{
        //    str = str_2;
        //} else if((value != null) && (value.length() > 0) && (value.indexOf(str) == -1) && (value.indexOf(str_2) == -1))
        //{
        //    str = str_3;
        //}
//        if(value != null && value.length() > 0 && arr.length > 1)
//        {
//            StringBuilder sb = new StringBuilder();
//            StringBuilder page = new StringBuilder();
//
//            String st[] = (str + value + str).split(str);
//
//            if(reportpos > (st.length - 1))
//            {
//                reportpos = (st.length - 1);
//            }
//
//            sb.append(st[reportpos]);
//
//            page.append("<div id ='ContentPageDIV'> ");
//            for(int i = 1;i < st.length;i++)
//            {
//                if(i == 1 && st.length != 1)
//                {
//                    page.append("<a id='ContentPage' href='/html/" + getCommunity() + "/report/" + _nNode + "-" + lang + ".htm?reportpos=" + (reportpos - 1) + "' >上一页</a> ");
//                }
//                if(st.length != 1)
//                {
//                    String cps = "ContentPage";
//                    if(reportpos == i)
//                    {
//                        cps = "ContentPageCurrent";
//                    }
//                    page.append("<a id='" + cps + "'  ");
//                    page.append("href='/html/" + getCommunity() + "/report/" + this._nNode + "-" + lang + ".htm?reportpos=" + i + "' >").append(i).append("</a> ");
//                    //page.append("<a id='ContentPage' href='../report/"+_nNode+"-"+lang+".htm?reportpos="+i+"' >").append(i + 1).append("</a> ");
//                }
//                if(i == (st.length - 1) && st.length != 1)
//                {
//                    page.append("<a id='ContentPage' href='/html/" + getCommunity() + "/report/" + _nNode + "-" + lang + ".htm?reportpos=");
//                    if(reportpos >= (st.length - 1))
//                    {
//                        page.append((reportpos) + "'>下一页</a> ");
//                    } else
//                    {
//                        page.append((reportpos + 1) + "'>下一页</a> ");
//                    }
//                }
//            }
//            page.append("</span><script>page(0);</script>");
//            page.append("</div>");
//            value = sb.append(page).toString();
//        }
//        return value;
    }

    public int getSequence() throws SQLException
    {
        load();
        return sequence;
    }

    public void setSequence(int sequence) throws SQLException
    {
        set("sequence",String.valueOf(sequence));
        this.sequence = sequence;
    }

    public static Enumeration findByType(int type,String community) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            StringBuilder select = new StringBuilder("SELECT DISTINCT Node.node");
            StringBuilder from = new StringBuilder();
            StringBuilder where = new StringBuilder();
            StringBuilder order = new StringBuilder();
            switch(type)
            {
            case 21: // 公司
                select.append(",Company.sequence");
                from.append(",Company");
                where.append(" AND Node.node=Company.node");
                order.append(" Company.sequence,");
                break;
            case 62: // 球场
                order.append(" NodeLayer.subject,");
                from.append(",NodeLayer");
                where.append(" AND Node.node=NodeLayer.node");
                select.append(",NodeLayer.subject");
                break;
                // default:
            }
            select.append(",Node.sequence");
            db.executeQuery(select.toString() + " FROM Node" + from.toString() + "  WHERE type=" + type + " AND community=" + DbAdapter.cite(community) + where.toString() + " ORDER BY" + order + " Node.sequence");

            for(int i = 0;i < 100 && db.next();i++)
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int countByType(int type,String community) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt("SELECT count(node) FROM Node  WHERE type=" + type + " AND community=" + DbAdapter.cite(community));
        } finally
        {
            db.close();
        }
    }

    public static Enumeration findThisTree(int i) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT node  FROM Node  WHERE path like '%/" + i + "/%'");
            for(;db.next();v.addElement(db.getInt(1)))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static int countSearchx(String s,int i,int j,int l,String s1,int i1,int j1,String s2,int k1,String s3,int l1,int i2,Date date,Date date1,int j2,int k2) throws SQLException
    {
        int l2 = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            l2 = db.getInt("SELECT COUNT(DISTINCT n.node) " + getSearchSqlx(s,i,j,l,s1,i1,j1,s2,k1,s3,l1,i2,date,date1,j2,k2));
        } finally
        {
            db.close();
        }
        return l2;
    }

    public static Enumeration findSearchx(String s,int i,int k,int l,String s1,int i1,int j1,String s2,int k1,String s3,int l1,int i2,int j2,int k2,Date date,Date date1,int l2,int i3) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT DISTINCT n.node " + getSearchSqlx(s,i,k,l,s1,i1,j1,s2,k1,s3,j2,k2,date,date1,l2,i3) + " ORDER BY n.node DESC ");
            for(int j3 = 0;j3 < l1 + i2 && db.next();j3++)
            {
                if(j3 >= l1)
                {
                    v.addElement(db.getInt(1));
                }
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    private static String getSearchSqlx(String s,int i,int j,int l,String s1,int i1,int j1,String s2,int k1,String s3,int l1,int i2,Date date,Date date1,int j2,int k2) throws SQLException
    {
        boolean flag = s.length() != 0;
        boolean flag1 = (i2 & 8) != 0;
        String s4 = " FROM Node n WHERE 1=1 ";
        if(j != 255)
        {
            s4 = s4 + " AND n.type=" + j;
        }
        if(i1 == 0)
        {
            Node node = find(j1);
            s4 = s4 + " AND n.community=" + DbAdapter.cite(node.getCommunity()) + " AND n.path LIKE " + DbAdapter.cite(node.getPath() + "%");
        } else if(i1 == 1)
        {
            s4 = s4 + " AND n.community=" + DbAdapter.cite(s2);
        } else if(i1 == 2)
        {
            s4 = s4 + " AND (EXISTS (SELECT DISTINCT c.community FROM Community c WHERE n.community=c.community AND c.type=1 )) ";
        }
        if(k2 == 0)
        {
            if(l != 0)
            {
                if(l == 1)
                {
                    s4 = s4 + " AND n.rcreator=" + DbAdapter.cite(s1);
                } else if(l == 2)
                {
                    s4 = s4 + " AND n.vcreator=" + DbAdapter.cite(s1);
                } else if(l == 3)
                {
                    s4 = s4 + " AND (n.rcreator=" + DbAdapter.cite(s1) + " OR n.vcreator=" + DbAdapter.cite(s1) + ")";
                }
            }
        } else if(k2 == 1)
        {
            s4 = s4 + " AND (EXISTS (SELECT DISTINCT talkbacker.node FROM Talkback talkbacker WHERE n.node=talkbacker.node AND talkbacker.language=" + i;
            if(l != 0)
            {
                if(l == 1)
                {
                    s4 = s4 + " AND talkbacker.rmember=" + DbAdapter.cite(s1);
                } else if(l == 2)
                {
                    s4 = s4 + " AND talkbacker.vmember=" + DbAdapter.cite(s1);
                } else if(l == 3)
                {
                    s4 = s4 + " AND (talkbacker.rmember=" + DbAdapter.cite(s1) + " OR talkbacker.vmember=" + DbAdapter.cite(s1) + ")";
                }
            }
            s4 = s4 + " ))";
        } else if(k2 == 2)
        {
            s4 = s4 + " AND (EXISTS (SELECT DISTINCT chater.node FROM Chat chater WHERE n.node=chater.node AND chater.language=" + i;
            if(l != 0)
            {
                if(l == 1)
                {
                    s4 = s4 + " AND chater.rmember=" + DbAdapter.cite(s1);
                } else if(l == 2)
                {
                    s4 = s4 + " AND chater.vmember=" + DbAdapter.cite(s1);
                } else if(l == 3)
                {
                    s4 = s4 + " AND (chater.rmember=" + DbAdapter.cite(s1) + " OR chater.vmember=" + DbAdapter.cite(s1) + ")";
                }
            }
            s4 = s4 + " ))";
        }
        if(j2 != -1)
        {
            DbAdapter db = new DbAdapter();
            if(j2 == 0)
            {
                s4 = s4 + " AND n.time>" + db.cite(date) + " AND n.time<" + db.cite(date1);
            } else if(j2 == 1)
            {
                s4 = s4 + " AND (EXISTS (SELECT DISTINCT newstime.node FROM News newstime, NewsLayer newslayertime WHERE n.node=newstime.node AND n.node=newslayertime.node AND newslayertime.language=" + i;
                s4 = s4 + " AND newstime.issuetime>" + db.cite(date) + " AND newstime.issuetime<" + db.cite(date1) + "))";
            } else if(j2 == 2)
            {
                s4 = s4 + " AND (EXISTS (SELECT DISTINCT talkbacktime.node FROM Talkback talkbacktime WHERE n.node=talkbacktime.node AND talkbacktime.language=" + i;
                s4 = s4 + " AND talkbacktime.time>" + db.cite(date) + " AND talkbacktime.time<" + db.cite(date1) + "))";
            } else if(j2 == 3)
            {
                s4 = s4 + " AND (EXISTS (SELECT DISTINCT chattime.node FROM Chat chattime WHERE n.node=chattime.node AND chattime.language=" + i;
                s4 = s4 + " AND chattime.time>" + db.cite(date) + " AND chattime.time<" + db.cite(date1) + "))";
            }
            db.close();
        }
        if(flag)
        {
            s4 = s4 + " AND ( (1=2) ";
            if(flag1 || j == 4 || j == 34)
            {
                s4 = s4 + " OR (EXISTS (SELECT DISTINCT commodity.node FROM Commodity commodity WHERE n.node=commodity.node ";
                s4 = s4 + " AND ( ( 1=2 ) ";
                s4 = makeSB(s4,l1,s,"commodity.sku");
                s4 = makeSB(s4,l1,s,"commodity.serialnumber");
                s4 = makeSB(s4,l1,s,"commodity.supplier");
                s4 = s4 + " ) ";
                s4 = s4 + " )) ";
            }
            if(flag1 || j == 12)
            {
                s4 = s4 + " OR (EXISTS (SELECT DISTINCT book.node FROM Book book, BookLayer booklayer WHERE n.node=book.node AND book.node=booklayer.node AND booklayer.language=" + i;
                s4 = s4 + " AND ( ( 1=2 ) ";
                s4 = makeSB(s4,l1,s,"book.isbn");
                s4 = s4 + " ) ";
                s4 = s4 + " )) ";
            }
            if(flag1 || j == 13)
            {
                s4 = s4 + " OR (EXISTS (SELECT DISTINCT news.node FROM News news, NewsLayer newslayer WHERE n.node=news.node AND n.node=newslayer.node AND newslayer.language=" + i;
                s4 = s4 + " AND ( ( 1=2 ) ";
                s4 = makeSB(s4,l1,s,"newslayer.reporter");
                s4 = makeSB(s4,l1,s,"newslayer.press");
                s4 = makeSB(s4,l1,s,"newslayer.location");
                s4 = s4 + " ) ";
                s4 = s4 + " )) ";
            }
            if(flag1 || j == 26)
            {
                s4 = s4 + " OR (EXISTS (SELECT DISTINCT author.node FROM Author author, AuthorLayer authorlayer WHERE n.node=author.node AND author.author=authorlayer.author AND authorlayer.language=" + i;
                s4 = s4 + " AND ( ( 1=2 ) ";
                s4 = makeSB(s4,l1,s,"authorlayer.name");
                s4 = s4 + " ) ";
                s4 = s4 + " )) ";
            }
            if(flag1 || (i2 & 0x10) != 0)
            {
                s4 = s4 + " OR (EXISTS (SELECT DISTINCT sec.node FROM Section sec, SectionLayer secl WHERE n.node=sec.node AND sec.section=secl.section AND secl.language=" + i;
                s4 = s4 + " AND ( ( 1=2 ) ";
                s4 = makeSB(s4,l1,s,"secl.text");
                s4 = s4 + " ) ";
                s4 = s4 + " )) ";
            }
            if(flag1 || (i2 & 0x20) != 0)
            {
                s4 = s4 + " OR (EXISTS (SELECT DISTINCT talkback.node FROM Talkback talkback WHERE n.node=talkback.node AND talkback.language=" + i;
                s4 = s4 + " AND ( ( 1=2 ) ";
                s4 = makeSB(s4,l1,s,"talkback.subject");
                s4 = makeSB(s4,l1,s,"talkback.content");
                s4 = s4 + " ) ";
                s4 = s4 + " )) ";
            }
            if(flag1 || (i2 & 0x40) != 0)
            {
                s4 = s4 + " OR (EXISTS (SELECT DISTINCT chat.node FROM Chat chat WHERE n.node=chat.node AND chat.language=" + i;
                s4 = s4 + " AND ( ( 1=2 ) ";
                s4 = makeSB(s4,l1,s,"chat.text");
                s4 = s4 + " ) ";
                s4 = s4 + " )) ";
            }
            s4 = s4 + " OR (EXISTS (SELECT DISTINCT nodelayer.node FROM NodeLayer nodelayer WHERE n.node=nodelayer.node AND nodelayer.language=" + i;
            s4 = s4 + " AND ( ( 1=2 ) ";
            if(flag1 || (i2 & 1) != 0)
            {
                s4 = makeSB(s4,l1,s,"nodelayer.subject");
            }
            if(flag1 || (i2 & 2) != 0)
            {
                s4 = makeSB(s4,l1,s,"nodelayer.keywords");
            }
            if(flag1 || (i2 & 4) != 0)
            {
                s4 = makeSB(s4,l1,s,"nodelayer.text");
            }
            s4 = s4 + " ) ";
            s4 = s4 + " )) ";
            s4 = s4 + " ) ";
        }
        return s4;
    }

    private static String makeSB(String s,int i,String s1,String s2) throws SQLException
    {
        s = s + "  OR ( ";
        if(i == 0)
        {
            StringTokenizer stringtokenizer = new StringTokenizer(s1,", +");
            for(int j = 0;stringtokenizer.hasMoreTokens();j++)
            {
                if(j == 0)
                {
                    s = s + " " + s2 + " LIKE " + DbAdapter.cite("%" + stringtokenizer.nextToken() + "%");
                } else
                {
                    s = s + " AND " + s2 + " LIKE " + DbAdapter.cite("%" + stringtokenizer.nextToken() + "%");
                }
            }
        } else if(i == 1)
        {
            StringTokenizer stringtokenizer1 = new StringTokenizer(s1,", +");
            for(int k = 0;stringtokenizer1.hasMoreTokens();k++)
            {
                if(k == 0)
                {
                    s = s + " " + s2 + " LIKE " + DbAdapter.cite("%" + stringtokenizer1.nextToken() + "%");
                } else
                {
                    s = s + " OR " + s2 + " LIKE " + DbAdapter.cite("%" + stringtokenizer1.nextToken() + "%");
                }
            }
        } else if(i == 2)
        {
            s = s + " " + s2 + " LIKE " + DbAdapter.cite("%" + s1 + "%");
        }
        s = s + " ) ";
        return s;
    }

    public static int getLanguage(int node,int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM NodeLayer WHERE node=" + node);
            while(db.next())
            {
                v.addElement(db.getInt(1));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(language) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(2) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(1) != -1)
                {
                    return 1;
                }
            }
            if(v.size() < 1)
            {
                return 0;
            }
        }
        return((Integer) v.elementAt(0)).intValue();
    }

    public int getStyle() throws SQLException
    {
        load();
        return style;
    }

    public int getRoot() throws SQLException
    {
        load();
        return root;
    }

    public boolean isExtend() throws SQLException
    {
        load();
        return extend;
    }

    public void setExtend(boolean extend) throws SQLException
    {
        set("extend",extend ? "1" : "0");
        this.extend = extend;
    }


    public void set(boolean mostly,boolean mostly1,boolean mostly2,String mark) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(_nNode,"UPDATE Node SET mostly=" + DbAdapter.cite(mostly) + ",mostly1=" + DbAdapter.cite(mostly1) + ",mostly2=" + DbAdapter.cite(mostly2) + ",mark=" + DbAdapter.cite(mark) + " WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
        this.mostly = mostly;
        this.mostly1 = mostly1;
        this.mostly2 = mostly2;
        this.mark = mark;
    }

    public void setHot() throws SQLException
    {
        this.hot++;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Node SET hot=" + (hot) + " WHERE node=" + _nNode);
        } finally
        {
            db.close();
        }
    }

    public boolean isMostly() throws SQLException
    {
        load();
        return mostly;
    }

    public boolean isMostly1() throws SQLException
    {
        load();
        return mostly1;
    }

    public boolean isMostly2() throws SQLException
    {
        load();
        return mostly2;
    }

    public int getHot() throws SQLException
    {
        load();
        return hot;
    }

    public String getMark() throws SQLException
    {
        load();
        return mark;
    }

    public Date getUpdatetime() throws SQLException
    {
        load();
        if(updatetime == null)
        {
            updatetime = time;
        }
        return updatetime;
    }

    public int getKstyle() throws SQLException
    {
        load();
        return kstyle;
    }

    public String getSyncId() throws SQLException
    {
        load();
        return syncid;
    }

    public String getNumber() throws SQLException
    {
        load();
        return goodsnumber;
    }

    public int getKroot() throws SQLException
    {
        load();
        return kroot;
    }

    public String getUpdatetimeToString() throws SQLException
    {
        String tmp = sdf2.format(getUpdatetime());
        return "<span id=\"date_hm\">" + tmp.substring(0,10) + "</span><span id=\"time_hm\">" + tmp.substring(10) + "</span>";
    }

    public String getTreeToHtml(int language,int dv) throws SQLException
    {
        String dvp = dv == 0 ? null : Node.find(dv).getPath();
        StringBuilder h = new StringBuilder();
        String js = "";
        int step = this.getPath().split("/").length - 1;
        Enumeration e = Node.find(" AND father=" + _nNode + " AND hidden=0 AND finished=1 ORDER BY sequence",0,200);
        while(e.hasMoreElements())
        {
            int id = ((Integer) e.nextElement()).intValue();
            Node n = Node.find(id);
            int t = n.getType();
            String p = n.getPath();
            h.append("<div id='nt_step_" + step + "' ntype='" + t + "' class='nt_step'");
            if(t == 1)
            {
                h.append(" ncategory='" + Category.find(id).getCategory() + "'");
            }
            h.append(">");
            if(t == 0)
            { //nt_ex(" + id + "," + step + ");
                h.append("<a href='###' onclick='tree(this,0);' id='n" + id + "'><img src='/tea/image/tree/tree_plus.gif' align='absmiddle' id='nti_" + id + "'/></a>");
            } else
            {
                h.append("<img src='/tea/image/tree/tree_minus.gif' align='absmiddle'>");
            }
            h.append("<span id='std'>");
            h.append(" <a href='###' onclick='return nt_open(" + id + ",this)'>" + n.getSubject(language) + "</a><span class='ntc'> ( " + n.child + " )</span>");
            h.append("</span>");
            h.append("<div id='ntd_" + id + "' style='display:none'></div></div>");
            if(dvp != null && dvp.startsWith(p))
            {
                js = "<script>nt_ex(" + id + "," + step + ");</script>";
            }
        }
        return h.append(js).toString();
    }

    public String getAdminTreeToHtml(int language,int dv,String member,String community) throws SQLException
    {

        String dvp = dv == 0 ? null : Node.find(dv).getPath();
        StringBuilder h = new StringBuilder();
        String js = "";
        int step = this.getPath().split("/").length - 1;
        Enumeration e = Node.find(" AND father=" + _nNode + " AND hidden=0 ORDER BY sequence",0,200);
        AdminUsrRole arobj = AdminUsrRole.find(community,member);
        while(e.hasMoreElements())
        {
            int id = ((Integer) e.nextElement()).intValue();
            Node n = Node.find(id);
            int t = n.getType();
            String p = n.getPath();
            int c = Node.count(" AND path LIKE " + DbAdapter.cite(p + "%") + " AND type>1 AND hidden=0");
            if(AdminRole.isEx(arobj.getRole(),id,member))
            {
                h.append("<div id='nt_step_" + step + "' ntype='" + t + "' class='nt_step'");
                if(t == 1)
                {
                    h.append(" ncategory='" + Category.find(id).getCategory() + "'");
                }
                h.append(">");
                if(t == 0)
                {
                    h.append("<a href='###' onclick='nt_ex(" + id + "," + step + ");' id='a" + step + "'><img src='/tea/image/tree/tree_plus.gif' align='absmiddle' id='nti_" + id + "'/></a>");
                } else
                {
                    h.append("<img src='/tea/image/tree/tree_minus.gif' align='absmiddle'>");
                }

                h.append("<span id ='std'>");
                h.append(" <a href='###' onclick='return nt_open(" + id + ",this)'>" + n.getSubject(language) + "</a><span class='ntc'> ( " + c + " )</span>");
                h.append("</span>");

                h.append("<div id='ntd_" + id + "' style='display:none'></div></div>");
                if(dvp != null && dvp.startsWith(p))
                {
                    js = "<script>nt_ex(" + id + "," + step + ");</script>";
                }
            }

        }
        return h.append(js).toString();
    }

    private static void tojs(PrintWriter fw,int id,int lang) throws SQLException
    {
        System.out.println("JS:" + id);
        Enumeration e = find(" AND father=" + id,0,100);
        if(e.hasMoreElements())
        {
            StringBuilder sb = new StringBuilder();
            sb.append("var node").append(id).append("=new Array(new Array('','--------------')");
            while(e.hasMoreElements())
            {
                id = ((Integer) e.nextElement()).intValue();
                Node n = Node.find(id);
                sb.append(",new Array('").append(id).append("','").append(n.getSubject(lang)).append("')");
                if(n.getType() < 2)
                {
                    tojs(fw,id,lang);
                }
            }
            sb.append(");\r\n\r\n");
            fw.write(sb.toString());
        }
    }

    public void toJavascript(int lang)
    {
        try
        {
            PrintWriter fw = new PrintWriter(Http.REAL_PATH + "/res/" + this.getCommunity() + "/cssjs/Node_" + _nNode + ".js","UTF-8");
            tojs(fw,_nNode,lang);
            StringBuilder sb = new StringBuilder();
            sb.append("var node=new Array(new Array('','--------------'));");
            sb.append("function selectnode(s0,s1,s2,dv)                                                                       \r\n");
            sb.append("{                                                                       \r\n");
            sb.append("	document.write(\"<select name='\"+s0+\"' onchange=\\\"addnode(this.value,'\"+s1+\"','\"+dv+\"');\\\"><option value=''>--------------</select>\");                                                                       \r\n");
            sb.append("	if(s1)                                                                       \r\n");
            sb.append("	{                                                                       \r\n");
            sb.append("	  document.write(\" <select name='\"+s1+\"' onchange=\\\"addnode(this.value,'\"+s2+\"','\"+dv+\"');\\\"><option value=''>--------------</select>\");                                                                       \r\n");
            sb.append("	  if(s2)                                                                       \r\n");
            sb.append("	     document.write(\" <select name='\"+s2+\"' ><option value=''>--------------</select>\");                                                                       \r\n");
            sb.append("	}                                                                       \r\n");
            sb.append("	addnode('" + _nNode + "',s0,dv);                                                                       \r\n");
            sb.append("}                                                                       \r\n");
            sb.append("function addnode(father,s,dv)                                                                       \r\n");
            sb.append("{                                                                       \r\n");
            sb.append("  var ob=document.all(s);                                                                       \r\n");
            sb.append("  if(ob)                                                                       \r\n");
            sb.append("  {                                                                       \r\n");
            sb.append("    var op=ob.options;                                                                       \r\n");
            sb.append("    while(op.length>0)                                                                       \r\n");
            sb.append("    {                                                                       \r\n");
            sb.append("      op[0]=null;                                                                       \r\n");
            sb.append("    }                                                                       \r\n");
            sb.append("    //if(father==null||father.length>0)                                                                       \r\n");
            sb.append("    {                                                                       \r\n");
            sb.append("    	//if(father==null)father='';                                                                       \r\n");
            sb.append("	        var c=eval('node'+father);                                                                       \r\n");
            sb.append("		for(var i=0;i<c.length;i++)                                                                       \r\n");
            sb.append("		{                                                                       \r\n");
            sb.append("		  op[i]=new Option(c[i][1],c[i][0]);                                                                       \r\n");
            sb.append("		  if( dv.indexOf('/'+c[i][0]+'/')!=-1 || dv==c[i][1] )                                                                       \r\n");
            sb.append("		  {                                                                       \r\n");
            sb.append("		    op[i].selected=true;                                                                       \r\n");
            sb.append("		  }                                                                       \r\n");
            sb.append("		}                                                                       \r\n");
            sb.append("		if(ob.onchange)ob.onchange();                                                                       \r\n");
            sb.append("	   }                                                                       \r\n");
            sb.append("  }                                                                       \r\n");
            sb.append("}                                                                       \r\n");
            fw.write(sb.toString());
            fw.close();
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    public Node clone() throws CloneNotSupportedException
    {
        Node n = (Node)super.clone();
        n._nNode = 0;
        return n;
    }
}
