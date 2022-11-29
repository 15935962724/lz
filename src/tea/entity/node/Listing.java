package tea.entity.node;

import java.util.*;
import java.util.regex.*;
import tea.db.*;
import tea.entity.*;
import tea.html.*;
import tea.htmlx.*;
import tea.ui.*;
import java.sql.SQLException;

public class Listing extends Entity implements Cloneable
{
    public static Cache _cache = new Cache(1000);
    public static final String ALLCOMMS = "";
    public static final int ALLTYPES = 255;
    public static final String LISTING_TYPE[] =
            {"Listing","Briefcase","SMSListing","1246417610909","Search"};
    public static final int LISTINGT_LISTING = 0;
    public static final int LISTINGT_BRIEFCASE = 1;
    public static final int LISTINGI_MANUAL = 0;
    public static final int LISTINGI_AUTOMATIC = 1;
    public static final String LISTING_POSITION[] =
            {"Body1","Body2","Body3","AdLeft","AdRight","Header","Footer"};
    public static final String LISTING_HideSyle[] =
            {"HidenAll","HidenInSub","HidenInLocation","NoHiden"};
    public static final int LISTINGP_LEFT = 0;
    public static final int LISTINGP_CENTER = 1;
    public static final int LISTINGP_RIGHT = 2;
    public static final int LISTINGP_ADLEFT = 3;
    public static final int LISTINGP_ADRIGHT = 4;
    public static final int LISTINGP_HEADER1 = 5;
    public static final int LISTINGP_HEADER2 = 6;
    public static final int LISTINGO_SHOWALWAYS = 1;
    public static final int LISTINGO_NEWWINDOW = 2;
    public static final int LISTINGO_SHOWNEWEST = 4;
    public static final int LISTINGO_SHOWSONS = 8;
    public static final int LISTINGO_CURRENTNODE = 16;
    public static final int LISTINGO_NODEBRIEFING = 256;
    public static final int LISTINGO_NODESUBJECT = 512;
    public static final int LISTINGO_NODECREATOR = 1024;
    public static final int LISTINGO_NODEDETAIL = 2048;
    public static final int LISTINGO_SONBRIEFING = 0x10000;
    public static final int LISTINGO_SONSUBJECT = 0x20000;
    public static final int LISTINGO_SONCREATOR = 0x40000;
    public static final int LISTINGO_SONDETAIL = 0x80000;
    public static final String LISTING_SORTTYPE[] =
            {"CreateTime","ViewCount","TalkbackCount","PollCount","BuyCount","BidCount","BargainCount","ChatCount","NewsIssueTime","Sequence","Click","CompanyDistinction","Path","UpdateTime","BBS"};
    public static final String SHARE_DETAIL[] =
            {"ListingONodeSubject","Description","ListingONodeBriefing","Listing0NodeCreator","ListingOSonCount","Listing0AllCount","ListingOShowSons","ListingOSonSubject","ListingOSonCreator","ListingOSonTime","ListingOSonDetail","ListingOSonMore","IssueTime","UpdateTime","Talkbacks","EditTalkback","ChatRoom","ForwardNode","ReplyNode","EditNode","DeleteNode","CBRefresh","CBArchive","SetVisible","Path","Click","NodeOPrevNext","Correlation","File","Voice","Picture","MMS","TSubject",
            "TContent","TTime","TCreator","TReplyCount","ListingOEonCall","NodeCount","Divide","ListingONodeFather","NodeOPoll","NodeComment","NewNodeComment"};
    public static final int LISTINGS_CREATETIME = 0;
    public static final int LISTINGS_VIEWCOUNT = 1;
    public static final int LISTINGS_TALKBACKCOUNT = 2;
    public static final int LISTINGS_POLLCOUNT = 3;
    public static final int LISTINGS_BUYCOUNT = 4;
    public static final int LISTINGS_BIDCOUNT = 5;
    public static final int LISTINGS_BARGAINCOUNT = 6;
    public static final int LISTINGS_CHATCOUNT = 7;
    public static final int LISTINGS_NEWSISSUETIME = 8;
    public static final int LISTINGS_SEQUENCE = 9;
    public static final String LISTING_SORTDIR[] =
            {"Ascending","Descending"};
    public static final int LISTINGSD_ASCENDING = 0;
    public static final int LISTINGSD_DESCENDIGN = 1;
    public static final String SQL_SORTDIR[] =
            {" ASC "," DESC "," ASC "," DESC "};
    public static final String LISTING_PICTPOS[] =
            {"TOP","BOTTOM","LEFT","RIGHT"};
    public static final int LISTINGPP_TOP = 0;
    public static final int LISTINGPP_BOTTOM = 1;
    public static final int LISTINGPP_LEFT = 2;
    public static final int LISTINGPP_RIGHT = 3;
    public int listing;
    public int type; //类型:  0列举 1公文包 2短信列举 3半自动列举  4查询
    public int pick; //手动选项
    public int style;
    public int styletype; //类型
    public int stylecategory; //类别
    public int node;
    public int status;
    public int position;
    public int sequence;
    public int visible;
    public int quantity;
    public int sonquantity;
    public int columns;
    public int options;
    public String mark;
    public int detailoptions;
    public int sorttype;
    public int sortdir;
    public int updategap;
    public String target;
    public int term; //
    public int archive;
    public int ectypal;
    public boolean setkey; //
    public int termdate; //列举节点
    public Date time;
    public boolean _blLoaded;
    public Hashtable _htLayer;
    public Hashtable _htCacheLayer;
    public boolean exists;

    class Layer
    {
        public String _strName;
        public String _strMore;
        public String _strTalkbacks;
        public String _strEditTalkback;
        public String _strChatRoom;
        public String _strForwardNode;
        public String _strReplyNode;
        public String _strBeforeItemPicture;
        public String _strBeforeItem;
        public String _strAfterItem;

        public String _strSeparatorDetail;

        public String _strBeforeListing;
        public int _nPicturePosition;
        public String _strPicture;
        public String _strClickUrl;
        public String _strAlt;
        public int _nAlign;
        public String _strAfterListing;
        private String columnAfter;
        private boolean layerExisted;
        public int isshowlayer;
        Layer()
        {
        }
    }


    public int getSequence() throws SQLException
    {
        load();
        return sequence;
    }

    public int getListing() throws SQLException
    {
        return listing;
    }

    public int getStyle() throws SQLException
    {
        load();
        return style;
    }

    public int getStyleType() throws SQLException
    {
        load();
        return styletype;
    }

    public int getStyleCategory() throws SQLException
    {
        load();
        return stylecategory;
    }

//    public static int countNodes(RV rv) throws SQLException
//    {
//        int i = 0;
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            i = db.getInt("SELECT COUNT(DISTINCT l.node) " + getNodesSql(rv));
//        } finally
//        {
//            db.close();
//        }
//        return i;
//    }

    public int getPicturePosition(int i) throws SQLException
    {
        return getLayer(i,i)._nPicturePosition;
    }

    public int getUpdateGap() throws SQLException
    {
        load();
        return updategap;
    }

    public String getBeforeItemPicture(int i) throws SQLException
    {
        return getLayer(i,i)._strBeforeItemPicture;
    }

    public int getColumns() throws SQLException
    {
        load();
        return columns;
    }

    public int getPick() throws SQLException
    {
        load();
        return pick;
    }

    public String getMark() throws SQLException
    {
        load();
        return mark;
    }

    public Listing clone(int node,int status) throws SQLException,CloneNotSupportedException
    {
        load();
        Listing l = clone();
        l.node = node;
        l.status = status;
        l.set();

        Iterator it = getLanguages().iterator();
        while(it.hasNext())
        {
            int lang = ((Integer) it.next()).intValue();
            l.setLayer(lang,this.getName(lang),this.getMore(lang),this.getTalkbacks(lang),this.getEditTalkback(lang),this.getChatRoom(lang),this.getForwardNode(lang),this.getReplyNode(lang),this.getBeforeItemPicture(lang),this.getBeforeItem(lang),this.getAfterItem(lang),null,this.getSeparatorDetail(lang),null,null,null,null,null,null,this.getBeforeListing(lang),this.getPicturePosition(lang),this.getPicture(lang),this.getClickUrl(lang),this.getAlt(lang),this.getAlign(lang),this.getAfterListing(lang),this.getColumnAfter(lang),this.getIsshowlayer(lang));
        }

        it = Listinghide.find(" AND listing=" + listing,0,200).iterator();
        while(it.hasNext())
        {
            Listinghide lh = ((Listinghide) it.next()).clone();
            lh.listing = l.listing;
            lh.set(lh.hiden);
        }

        it = ListingDetail.find(" AND listing=" + listing,0,200).iterator();
        while(it.hasNext())
        {
            ListingDetail ld = (ListingDetail) it.next();
            ld.listing = l.listing;
            Iterator ns = ld.keys();
            while(ns.hasNext())
            {
                String name = (String) ns.next();
                ld.set(name,ld.getIstype(name),ld.getBeforeItem(name),ld.getAfterItem(name),ld.getSequence(name),ld.getAnchor(name),ld.getQuantity(name),ld.getOptions(name),ld.getTime(name),ld.getCkhref(name));
            }
        }

        Node fn = Node.find(this.node); //源
        Node dn = Node.find(node); //目的

        it = PickManual.find(" AND listing=" + listing,0,Integer.MAX_VALUE).iterator();
        while(it.hasNext())
        {
            PickManual pm = ((PickManual) it.next()).clone();
            pm.listing = l.listing;
            pm.set();
        }
        //
        it = PickFrom.findByListing(listing).iterator();
        while(it.hasNext())
        {
            PickFrom pf = (PickFrom) it.next();
            int fnid = pf.getFromNode();
            if(fnid == this.node) //选取源==源节点
            {
                fnid = node;
            } else if(fnid == fn.getFather()) //选取源==源节点的父节点
            {
                fnid = dn.getFather();
            } else if(fnid == Node.find(fn.getFather()).getFather()) //选取源==源节点的父节点的父节点
            {
                fnid = Node.find(dn.getFather()).getFather();
            }
            PickFrom.create(l.listing,pf.getFromStyle(),pf.getFromCommunity(),fnid);
        }
        it = PickNode.findByListing(listing).iterator();
        while(it.hasNext())
        {
            PickNode pn = (PickNode) it.next();
//            String s1 = teasession._rv._strR;
//            String s2 = teasession._rv._strV;
//            if (!pn.getRCreator().equals(node.getCreator()._strR))
//            {
//                s1 = pn.getRCreator();
//                s2 = pn.getVCreator();
//            }
            PickNode.create(l.listing,pn.nodeStyle,pn.type,pn.creatorStyle,pn.rcreator,pn.vcreator,pn.startStyle,pn.startTerm,pn.stopStyle,pn.stopTerm,pn.parameter);
        }
        return l;
    }

    public Vector getLanguages() throws SQLException
    {
        Vector _vLanguages = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM ListingLayer WHERE listing=" + listing);
            while(db.next())
            {
                _vLanguages.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return _vLanguages;
    }

    public String getBeforeListing(int i) throws SQLException
    {
        return getLayer(i,i)._strBeforeListing;
    }

    public static int countManualListing(String community,int type,String sql) throws SQLException
    {
        StringBuilder sb = new StringBuilder("SELECT COUNT(l.listing)"); //DISTINCT
        sb.append(" FROM Listing l, PickManual p,Node n  WHERE l.pick=0 AND l.ectypal=0 AND l.listing=p.listing AND l.node=n.node AND n.hidden=0");
        sb.append(" AND p.community IN(").append(DbAdapter.cite(community)).append(",").append(DbAdapter.cite("")).append(")");
        sb.append(" AND p.type IN(").append(type).append(",255)");
        sb.append(sql);
        //sql.append(" AND p.classes=").append(classes);

        DbAdapter db = new DbAdapter();
        try
        {
            return db.getInt(sb.toString());

        } finally
        {
            db.close();
        }
    }

    public static Enumeration findManualListing(String community,int type,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        StringBuilder sb = new StringBuilder("SELECT l.listing ,n.hot "); //DISTINCT
        sb.append(" FROM Listing l, PickManual p,Node n  WHERE l.pick=0 AND l.ectypal=0 AND l.listing=p.listing AND l.node=n.node AND n.hidden=0");
        sb.append(" AND p.community IN(").append(DbAdapter.cite(community)).append(",").append(DbAdapter.cite("")).append(")");
        sb.append(" AND p.type IN(").append(type).append(",255)");
        sb.append(sql);
        //sb.append(" AND p.classes=").append(classes);
        sb.append(" ORDER BY n.hot DESC");
//        } else
//        {
//            sql.append(" FROM Listing l, PickManual p,Node n,ListingLayer ll  WHERE l.pick=0 AND l.ectypal=0 AND l.listing=p.listing AND l.node=n.node AND n.hidden=0 AND (p.community=");
//            sql.append(DbAdapter.cite(s));
//            sql.append(" OR p.community=");
//            sql.append(DbAdapter.cite(""));
//            sql.append(" ) AND (p.type=");
//            sql.append(j);
//            sql.append(" OR p.type=255 ) AND p.classes=").append(classes);
//            sql.append(" AND ll.listing=l.listing AND ll.language=").append(language);
//            sql.append(" AND ( ");
//            java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(keyword," ");
//            sql.append(" ll.name LIKE ");
//            sql.append(DbAdapter.cite("%" + tokenizer.nextToken() + "%"));
//            while(tokenizer.hasMoreTokens())
//            {
//                sql.append(" OR ll.name LIKE ").append(DbAdapter.cite("%" + tokenizer.nextToken() + "%"));
//            }
//            sql.append(" ) ORDER BY n.hot DESC");
//        }
//        if (i == 9)
//        {
//            System.out.println(sql.toString());
//        }
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sb.toString(),pos,size);
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

    private static int create(int status,int type,int pick,int style,int styletype,int stylecategory,int detailoptions,int node,int position,int sequence,int visible,int quantity,int sonquantity,int columns,int options,String mark,int sorttype,int sortdir,int updategap,String target,int term,int archive,int ectypal,int language,String name,String more,String talkbacks,String edittalkback,String chatroom,String forwardnode,String replynode,String beforeitempicture,String beforeitem,String afteritem,String beforedetail,String separatordetail,String afterdetail,String beforechild,String afterchild,String beforechilddetail,String separatorchilddetail,String afterchilddetail,String beforelisting,int pictureposition,String picture,String clickurl,String alt,int align,String afterlisting,
                              Date time,String columnafter,int isshowlayer) throws SQLException
    {
        int newid = Seq.get();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(newid,"INSERT INTO Listing(listing,status,type,pick,style,styletype,stylecategory,detailoptions,node,sequence,position,visible,quantity,sonquantity,columns,options,mark,sorttype,sortdir,updategap,time,target,term,archive,ectypal)VALUES(" + newid + "," + status + "," + type + "," + pick + "," + style + "," + styletype + "," + stylecategory + "," + detailoptions + "," + node + "," + sequence + "," + position + ", " + visible + "," + quantity + "," + sonquantity + "," + columns + "," + options + "," + db.cite(mark) + ", " + sorttype + ", " + sortdir + "," + updategap + "," + db.cite(time) + "," + DbAdapter.cite(target) + "," + term + "," + archive + "," + ectypal + ")");
            String[] arr1 = DbAdapter.split("ListingLayer","beforelisting",beforelisting,"listing=" + newid + " AND language=" + language);
            String[] arr2 = DbAdapter.split("ListingLayer","afterlisting",afterlisting,"listing=" + newid + " AND language=" + language);
            db.executeUpdate(newid,"INSERT INTO ListingLayer(listing, language, name, more, talkbacks,edittalkback, chatroom, forwardnode, replynode,beforeitempicture, beforeitem, afteritem,beforedetail, separatordetail, afterdetail,beforechild, afterchild,beforechilddetail, separatorchilddetail, afterchilddetail, beforelisting, pictureposition, picture, clickurl, alt, align, afterlisting, columnafter, isshowlayer)VALUES ("
                             + newid + "," + language + "," + DbAdapter.cite(name) + ", " + DbAdapter.cite(more) + "," + DbAdapter.cite(talkbacks) + ", " + DbAdapter.cite(edittalkback) + "," + DbAdapter.cite(chatroom) + ", " + DbAdapter.cite(forwardnode) + ", " + DbAdapter.cite(replynode) + "," + DbAdapter.cite(beforeitempicture) + ", " + DbAdapter.cite(beforeitem) + ", " + DbAdapter.cite(afteritem) + "," + DbAdapter.cite(beforedetail) + ", " + DbAdapter.cite(separatordetail) + ", " + DbAdapter.cite(afterdetail) + "," + DbAdapter.cite(beforechild) + ", " + DbAdapter.cite(afterchild) + "," + DbAdapter.cite(beforechilddetail) + ", " + DbAdapter.cite(separatorchilddetail) + ", " + DbAdapter.cite(afterchilddetail) + "," + DbAdapter.cite(arr1[0]) + "," + pictureposition + ", " +
                             DbAdapter.cite(picture) + ", " + DbAdapter.cite(clickurl) + ", " + DbAdapter.cite(alt) + ", " + align + "," + DbAdapter.cite(arr2[0]) + "," + DbAdapter.cite(columnafter) + ", " + isshowlayer + ")");
            for(int i = 1;i < arr1.length;i++)
            {
                db.executeUpdate(newid,arr1[i]);
            }
            for(int i = 1;i < arr2.length;i++)
            {
                db.executeUpdate(newid,arr2[i]);
            }
        } finally
        {
            db.close();
        }
        return newid;
    }

    public void set() throws SQLException
    {
        String sql;
        if(listing < 1)
            sql = "INSERT INTO Listing(listing,status,type,pick,style,styletype,stylecategory,detailoptions,node,sequence,position,visible,quantity,sonquantity,columns,options,mark,sorttype,sortdir,updategap,time,target,term,archive,ectypal)VALUES(" + (listing = Seq.get()) + "," + status + "," + type + "," + pick + "," + style + "," + styletype + "," + stylecategory + "," + detailoptions + "," + node + "," + sequence + "," + position + ", " + visible + "," + quantity + "," + sonquantity + "," + columns + "," + options + "," + DbAdapter.cite(mark) + ", " + sorttype + ", " + sortdir + "," + updategap + "," + DbAdapter.cite(time) + "," + DbAdapter.cite(target) + "," + term + "," + archive + "," + ectypal + ")";
        else
            sql = "UPDATE Listing SET type=" + type + ",pick=" + pick + ",style=" + style + ",styletype=" + styletype + ",stylecategory=" + stylecategory + ",detailoptions=" + detailoptions + ",sequence=" + sequence + ",position=" + position + ",visible=" + visible + ",quantity=" + quantity + ",sonquantity=" + sonquantity + ",columns=" + columns + ",options=" + options + ",mark=" + DbAdapter.cite(mark) + ",sorttype=" + sorttype + ",sortdir=" + sortdir + ",updategap=" + updategap + ",time=" + DbAdapter.cite(time) + ",target=" + DbAdapter.cite(target) + ",term=" + term + ",archive=" + archive + ",ectypal=" + ectypal + " WHERE listing=" + listing;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(listing,sql);
        } finally
        {
            db.close();
        }
    }

    public void setLayer(int language,String name,String more,String talkbacks,String edittalkback,String chatroom,String forwardnode,String replynode,String beforeitempicture,String beforeitem,String afteritem,String beforedetail,String separatordetail,String afterdetail,String beforechild,String afterchild,String beforechilddetail,String separatorchilddetail,String afterchilddetail,String beforelisting,int pictureposition,String picture,String clickurl,String alt,int align,String afterlisting,String columnafter,int isshowlayer) throws SQLException
    {
        String[] arr1 = DbAdapter.split("ListingLayer","beforelisting",beforelisting,"listing=" + listing + " AND language=" + language);
        String[] arr2 = DbAdapter.split("ListingLayer","afterlisting",afterlisting,"listing=" + listing + " AND language=" + language);
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE ListingLayer SET name=" + DbAdapter.cite(name));
        sql.append(",more=" + DbAdapter.cite(more));
        sql.append(",talkbacks=" + DbAdapter.cite(talkbacks));
        sql.append(",edittalkback=" + DbAdapter.cite(edittalkback));
        sql.append(",chatroom=" + DbAdapter.cite(chatroom));
        sql.append(",forwardnode=" + DbAdapter.cite(forwardnode));
        sql.append(",replynode=" + DbAdapter.cite(replynode));
        sql.append(",beforeitem=" + DbAdapter.cite(beforeitem));
        sql.append(",afteritem=" + DbAdapter.cite(afteritem));
        sql.append(",beforedetail=" + DbAdapter.cite(beforedetail));
        sql.append(",separatordetail=" + DbAdapter.cite(separatordetail));
        sql.append(",afterdetail=" + DbAdapter.cite(afterdetail));
        sql.append(",beforechild=" + DbAdapter.cite(beforechild));
        sql.append(",afterchild=" + DbAdapter.cite(afterchild));
        sql.append(",beforechilddetail=" + DbAdapter.cite(beforechilddetail));
        sql.append(",separatorchilddetail=" + DbAdapter.cite(separatorchilddetail));
        sql.append(",afterchilddetail=" + DbAdapter.cite(afterchilddetail));
        sql.append(",beforelisting=" + DbAdapter.cite(arr1[0]));
        sql.append(",pictureposition=" + pictureposition);
        sql.append(",clickurl=" + DbAdapter.cite(clickurl));
        sql.append(",alt=" + DbAdapter.cite(alt));
        sql.append(",align=" + align);
        sql.append(",afterlisting=" + DbAdapter.cite(arr2[0]));
        sql.append(",columnafter=" + DbAdapter.cite(columnafter));
        sql.append(",isshowlayer=" + isshowlayer);
        if(beforeitempicture != null)
        {
            sql.append(",beforeitempicture=" + DbAdapter.cite(beforeitempicture));
        }
        if(picture != null)
        {
            sql.append(",picture=" + DbAdapter.cite(picture));
        }
        sql.append(" WHERE listing=" + listing + "  AND language=" + language);
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate(listing,sql.toString());
            if(j < 1)
                db.executeUpdate(listing,
                                 "INSERT INTO ListingLayer(listing,language,name,more,talkbacks,edittalkback,chatroom,forwardnode,replynode,beforeitempicture,beforeitem,afteritem,beforedetail,separatordetail,afterdetail,beforechild,afterchild,beforechilddetail,separatorchilddetail,afterchilddetail,beforelisting,pictureposition,picture,clickurl,alt,align,afterlisting,columnafter,isshowlayer)VALUES("
                                 + listing + "," + language + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(more) + "," + DbAdapter.cite(talkbacks) + "," + DbAdapter.cite(edittalkback) + "," + DbAdapter.cite(chatroom) + "," + DbAdapter.cite(forwardnode) + "," + DbAdapter.cite(replynode) + "," + DbAdapter.cite(beforeitempicture) + "," + DbAdapter.cite(beforeitem) + "," + DbAdapter.cite(afteritem)
                                 + "," + DbAdapter.cite(beforedetail) + "," + DbAdapter.cite(separatordetail) + "," + DbAdapter.cite(afterdetail) + "," + DbAdapter.cite(beforechild) + "," + DbAdapter.cite(afterchild) + "," + DbAdapter.cite(beforechilddetail) + "," + DbAdapter.cite(separatorchilddetail) + "," + DbAdapter.cite(afterchilddetail) + "," + DbAdapter.cite(arr1[0]) + "," + pictureposition
                                 + "," + DbAdapter.cite(picture) + "," + DbAdapter.cite(clickurl) + "," + DbAdapter.cite(alt) + "," + align + "," + DbAdapter.cite(arr2[0]) + "," + DbAdapter.cite(columnafter) + "," + isshowlayer + ")");
            for(int i = 1;i < arr1.length;i++)
            {
                db.executeUpdate(listing,arr1[i]);
            }
            for(int i = 1;i < arr2.length;i++)
            {
                db.executeUpdate(listing,arr2[i]);
            }
        } finally
        {
            db.close();
        }
        _htLayer.clear();
    }

    public void set(String field,String value) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(listing,"UPDATE Listing SET " + field + "=" + DbAdapter.cite(value) + " WHERE listing=" + listing);
        } finally
        {
            db.close();
        }
    }

    public void set(int termdate) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Listing SET termdate =" + termdate + "   WHERE listing=" + listing);
        } finally
        {
            db.close();
        }
        this.termdate = termdate;
    }

    //批量修改的方法
    public void setVolumeUpdateListing(String target,int sorttype,int sortdir,int ltype) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Listing SET target =" + DbAdapter.cite(target) + ",sorttype= " + sorttype + ",sortdir=" + sortdir + ",type=" + ltype + " WHERE listing=" + listing);

        } finally
        {
            db.close();
        }
        this.target = target;
        this.sorttype = sorttype;
        this.sortdir = sortdir;
        this.type = ltype;
    }

    //日期加减
    public boolean isDate(String basicDate,int n)
    {
        java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
        Date tmpDate = null;
        try
        {
            tmpDate = df.parse(basicDate);
        } catch(Exception e)
        {
            //   日期型字符串格式错误
        }
        long nDay = (tmpDate.getTime() / (24 * 60 * 60 * 1000) + 1 + n) * (24 * 60 * 60 * 1000);

        tmpDate.setTime(nDay);

        String firstString = df.format(new Date()); //当天日期
        String secondString = df.format(tmpDate); //要停止的日期

        Date firstDate = null;
        Date secondDate = null;
        try
        {
            firstDate = df.parse(firstString);
            secondDate = df.parse(secondString);
        } catch(Exception e)
        {
            //   日期型字符串格式错误
        }
        int nDay2 = (int) ((secondDate.getTime() - firstDate.getTime()) / (24 * 60 * 60 * 1000));
        boolean f = false;

        if(nDay2 >= 0)
        {
            //说明还没有到不显示的日期 继续显示
            f = true;
        } else if(nDay2 < 0)
        {
            f = false;
        }
        return f;
    }


    public String getTalkbacks(int i) throws SQLException
    {
        return getLayer(i,i)._strTalkbacks;
    }

    public String getMore(int i) throws SQLException
    {
        return getLayer(i,i)._strMore;
    }

    public static int getMaxSequence(int node) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            j = db.getInt("SELECT MAX(sequence) FROM Listing WHERE node=" + node);
        } finally
        {
            db.close();
        }
        return j;
    }


    public int getSortDir() throws SQLException
    {
        load();
        return sortdir;
    }

    public String getClickUrl(int i) throws SQLException
    {
        return getLayer(i,i)._strClickUrl;
    }

    private String[] getItemsSql(RV rv,Http h,int i) throws SQLException
    {
        load();
        long l = System.currentTimeMillis();
        int lid = ectypal > 0 ? ectypal : listing;
        StringBuilder sql1 = new StringBuilder(" FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node AND nl.language=" + (h.language == 2 ? 1 : h.language));
        String hidden = ((this.getOptions() & 0x100) == 0) ? " n.hidden=0 AND " : ""; // 显示隐藏节点

        StringBuilder sql2 = new StringBuilder(" WHERE");

        ArrayList pfs = PickFrom.findByListing(lid);
        ArrayList pns = PickNode.findByListing(lid);
        if(type == 1 || pick == 0 || pfs.size() == 0 || pns.size() == 0)
        {
            sql1.append(" ,Listed l ");
            sql2.append(" n.node=l.node AND l.listing=").append(lid).append(" AND(l.stoptime IS NULL OR l.stoptime>").append(DbAdapter.cite(new Date())).append(")");
        } else
        {
            boolean flag = false;
            StringBuilder sqlpf = new StringBuilder();
            sqlpf.append(" (");
            if(type == 3)
            {
                sql1.append(" LEFT JOIN Listed l ON l.listing=" + lid + " AND n.node=l.node");
                sqlpf.append("(l.listed>0 AND(l.stoptime IS NULL OR l.stoptime>").append(DbAdapter.cite(new Date())).append("))");
            }
            Iterator it = pfs.iterator();
            while(it.hasNext())
            {
                PickFrom pf = (PickFrom) it.next();
                int k = pf.getFromStyle();
                if(sqlpf.length() > 10)
                {
                    sqlpf.append(" OR ");
                }
                sqlpf.append(" (");
                if(k == 0) // 源风格:本社区
                {
                    sqlpf.append(" n.community=" + DbAdapter.cite(pf.getFromCommunity()));
                } else if(k == 2) // 源风格:本节点
                {
                    int j1 = (options & 0x10) == 0 ? pf.getFromNode() : i;
                    if(pns.size() > 0)
                    {
                        PickNode pn = (PickNode) pns.get(0);
                        if(pn.nodeStyle == 1) // 节点类型:父亲
                        {
                            j1 = Node.find(j1).getFather();
                        }
                    }
                    sqlpf.append(" n.father=" + j1);
                    flag = true;
                } else if(k == 3) // 源风格:本树
                {
                    int k1 = (options & 0x10) == 0 ? pf.getFromNode() : i;
                    if(pns.size() > 0)
                    {
                        PickNode pn = (PickNode) pns.get(0);
                        if(pn.nodeStyle == 1) // 节点类型:父亲
                        {
                            k1 = Node.find(k1).getFather();
                        }
                    }
                    sqlpf.append(" n.path LIKE '" + Node.find(k1).getPath() + "%'");
                }
                sqlpf.append(" ) ");
            }
            sqlpf.append(" ) ");
            //选取节点
            StringBuilder sqlpn = new StringBuilder();
            Iterator epn = pns.iterator();
            while(epn.hasNext())
            {
                PickNode pn = (PickNode) epn.next();
                String s = pn.rcreator;
                String s1 = pn.vcreator;
                if(s.length() == 0 && s1.length() == 0 && rv != null)
                {
                    s = rv._strR;
                    s1 = rv._strV;
                }
                if(s.length() <= 0)
                {
                    s = rv != null ? rv._strR : null;
                }
                StringBuilder stringbuffer7 = new StringBuilder();
                if(pn.type != 255)
                {
                    stringbuffer7.append(" AND n.type=" + pn.type);
                    if(pn.type == 94) //摄影类别显示审核通过的
                    {
                        stringbuffer7.append(" AND  n.audits= 1  ");
                    } else if(pn.type == 107 || pn.type == 108)
                    {
                        stringbuffer7.append(" AND n.starttime IS NOT NULL");
                    }
//                    if(pn.type==39)//只有新闻
//                    {
//                    	//只能显示发生时间是当天的
//                        //stringbuffer7.append(" AND n.node in (SELECT node FROM Report WHERE issuetime <="+DbAdapter.cite(Entity.sdf.format(new Date()))+")  ");
//                        stringbuffer7.append(" AND EXISTS (SELECT r.node FROM Report r WHERE n.node = r.node  AND issuetime<="+DbAdapter.cite(Entity.sdf.format(new Date()))+")");
//
//                    }
                    //参数
                    if(pn.parameter != null && pn.parameter.length() > 0)
                    {
                        stringbuffer7.append(" AND n.node IN(SELECT node FROM " + Node.NODE_TYPE[pn.type] + " WHERE 1=1");
                        String[] arr = pn.parameter.split(",");
                        for(int j = 0;j < arr.length;j++)
                        {
                            String val = h.get(arr[j],"");
                            if(val.length() > 0)
                                stringbuffer7.append(" AND " + arr[j] + DbAdapter.cite(val));
                        }
                        stringbuffer7.append(")");
                    }
                }
                if(pn.type == 57 && pn.bbstype > 0) //说明是帖子,//是否要显示精华贴子
                {
                    stringbuffer7.append(" AND n.node in (SELECT node FROM BBS WHERE   quintessence=1)  ");

                }

                //起始风格
                if(pn.startStyle == 1)
                {
                    stringbuffer7.append(" AND n.time>" + DbAdapter.cite(new Date(l - (long) (pn.startTerm * 60 * 60) * 1000L)));
                } else if(pn.startStyle == 2)
                {
                    stringbuffer7.append(" AND n.time>" + DbAdapter.cite(new Date(l + (long) (pn.startTerm * 60 * 60) * 1000L)));
                }

                //结束风格：
                if(pn.stopStyle == 1)
                {
                    stringbuffer7.append(" AND n.time<" + DbAdapter.cite(new Date(l - (long) (pn.stopTerm * 60 * 60) * 1000L)));
                } else if(pn.stopStyle == 2)
                {
                    stringbuffer7.append(" AND n.time<" + DbAdapter.cite(new Date(l + (long) (pn.stopTerm * 60 * 60) * 1000L)));
                }

                /*
                     //结束风格：
                     if(k2 == 1)
                     {
                 stringbuffer7.append(" AND n.stoptime<" + DbAdapter.cite(new Date(l - (long) (l2 * 60 * 60) * 1000L)));
                     } else if(k2 == 2)
                     {
                 stringbuffer7.append(" AND n.stoptime>" + DbAdapter.cite(new Date(l + (long) (l2 * 60 * 60) * 1000L)));
                     }
                 */




                // 创建者风格
                if(pn.creatorStyle == 1)
                {
                    stringbuffer7.append(" AND n.rcreator=" + DbAdapter.cite(s));
                } else if(pn.creatorStyle == 2)
                {
                    stringbuffer7.append(" AND n.vcreator=" + DbAdapter.cite(s1));
                } else if(pn.creatorStyle == 3)
                {
                    stringbuffer7.append(" AND n.rcreator=" + DbAdapter.cite(s) + " AND n.vcreator=" + DbAdapter.cite(s1));
                }
                if(sqlpn.length() > 5) //如果不是第一次
                {
                    sqlpn.append(" OR");
                }
                if(pn.nodeStyle == 0 || pn.nodeStyle == 1) // 节点类型:自已
                {
                    if(stringbuffer7.length() > 4)
                    {
                        sqlpn.append("(").append(stringbuffer7.substring(4)).append(")"); //去掉AND
                    }
                } else if(pn.nodeStyle == 1) // 节点类型:父亲
                {
                    sqlpn.append(" n.father IN (SELECT n.node  FROM Node n  WHERE " + hidden + " n.finished=1 " + (flag ? "" : sqlpf.toString()) + stringbuffer7 + ") ");
                } else if(pn.nodeStyle == 2) // 节点类型:儿子
                {
                    sqlpn.append(" n.node IN (SELECT f.node  FROM Node n, Node f  WHERE " + hidden + " and n.finished=1  AND n.father=f.node " + (flag ? "" : sqlpf.toString()) + stringbuffer7 + ") ");
                } else if(pn.nodeStyle == 3) // 节点类型:孙子
                {
                    sqlpn.append(" n.node IN (SELECT gf.node  FROM Node n, Node f, Node gf  WHERE " + hidden + " and n.finished=1 AND n.father=f.node  AND f.father=gf.node " + (flag ? "" : sqlpf.toString()) + stringbuffer7 + ") ");
                }

            }

            //
            StringBuilder stringbuffer5 = new StringBuilder();
            StringBuilder stringbuffer6 = new StringBuilder();
            ArrayList pes = PickNews.findByListing(lid);
            if(pes.size() > 0)
            {
                PickNews pe = (PickNews) pes.get(0);
                stringbuffer5.append(", News ne ");
                stringbuffer6.append(" AND n.node=ne.node ");
                if(pe.issueTerm != 0)
                {
                    stringbuffer6.append(" AND ne.issuetime>=" + DbAdapter.cite(new Date(l - (long) (pe.issueTerm * 60 * 60) * 1000L)));
                }
            }
            //
            sql2.append(sqlpf);
            if(sqlpn.length() > 0)
            {
                sql2.append(" AND (").append(sqlpn).append(")");
            }
            sql1.append(stringbuffer5);
            sql2.append(stringbuffer6);
        }
        if((getOptions() & 0x100) == 0) // 显示隐藏节点
        {
            sql2.append(" AND n.hidden=0");
        }
        sql2.append(" AND n.finished=1");

        /**
         * 2012-10-18 zhangjinshu  --注释掉
         */
        /*
           if(rv == null) // 会员是否在登陆状态
           {
         sql2.append(" AND ").append(DbAdapter.bitand("n.options",0x100)).append(" = 0 ");
           }
         */
        String order = null;
        switch(sorttype)
        {
        case 0: // 创建时间
            order = " n.time ";
            break;
        case 1: // 显示计数
            order = " n.click ";
            break;
        case 2: // 讨论计数
            sql1.append(" , TalkbackCounter c ");
            sql2.append(" AND n.node=c.node ");
            order = " c.counter ";
            break;
        case 3: // 投票计数
            sql1.append(" , PollCounter c ");
            sql2.append(" AND n.node=c.node ");
            order = (" c.counter ");
            break;
        case 4: // 购买计数
            sql1.append(" , Goods g ");
            sql2.append(" AND g.node=n.node");
            order = (" g.hits ");
            break;
        case 5: // 竞拍计数
            sql1.append(" , BidCounter c ");
            sql2.append(" AND n.node=c.node ");
            order = (" c.counter ");
            break;
        case 6: // 议价计数
            sql1.append(" , BargainCounter c ");
            sql2.append(" AND n.node=c.node ");
            order = (" c.counter ");
            break;
        case 7: // 聊天计数
            sql1.append(" , ChatCounter c ");
            sql2.append(" AND n.node=c.node ");
            order = (" c.counter ");
            break;
        case 8: // 新闻发布时间
            Calendar c = Calendar.getInstance();
            c.add(Calendar.DAY_OF_YEAR,1);
            sql2.append(" AND n.starttime<" + DbAdapter.cite(c.getTime(),true));
            order = " n.starttime ";
            break;
        case 9: // 顺序
            order = " n.sequence ";
            break;
        case 10: // 访问量
            order = " n.click ";
            break;
        case 11: // 公司级别
            sql1.append(" , Company c");
            sql2.append(" AND n.node=c.node ");
            order = " c.sequence ";
            break;
        case 12: // 路径
            order = " n.path ";
            break;
        case 13: // 节点更新时间
            order = " n.updatetime ";
            break;
        case 14: // 贴子
            sql1.append(" ,BBS b ");
            sql2.append(" AND b.node=n.node");
            String ob = h.get("orderby");
            if(ob == null)
            {
                ob = "replytime";
            }
            order = (" b.parktop DESC," + ob + " ");
            break;
        }
        StringBuilder o = new StringBuilder();
        o.append(" ORDER BY ").append(order).append(SQL_SORTDIR[sortdir]).append(",n.node ").append(SQL_SORTDIR[sortdir]);
        if(term != 0)
        {
            sql2.append(" AND ").append(order).append(">");
            if(sorttype == 10)
            {
                sql2.append(term);
            } else
            {
                Calendar c = Calendar.getInstance();
                c.setTimeInMillis(System.currentTimeMillis());
                c.set(Calendar.DAY_OF_YEAR,c.get(Calendar.DAY_OF_YEAR) - term);
                sql2.append(DbAdapter.cite(c.getTime()));
            }
        }
        return new String[]
                {sql1.append(sql2).toString(),o.toString()};
    }

    private static String getBriefcaseSql(RV rv)
    {
        return " FROM Listing l, Node n  WHERE l.node=n.node  AND l.type=1 AND n.rcreator=" + DbAdapter.cite(rv._strR);
    }

    private static String getBriefcaseSql(int i)
    {
        return " FROM Listing WHERE type=1 AND node=" + i;
    }

    public Object[] findItems(RV rv,Http h,int i,int pos,int size) throws SQLException
    {
        String[] sql = getItemsSql(rv,h,i);
        String s4 = sql[0];

        if((options & 0x400) != 0) // 区分语言
        {
            if(h.language == 2)
            {
                s4 += " AND n.defaultlanguage=1";
            } else
            {
                s4 += " AND n.defaultlanguage=" + h.language;
            }
        }
        boolean bmk2 = (options & 0x200) != 0;
        boolean bmk8 = (options & 0x800) != 0;
        if(bmk2 && bmk8) //
        {
        } else if(bmk2) // 只显示不关键
        {
            s4 += " AND n.mostly=0";
        } else if(bmk8) // 只显示关键
        {
            s4 += " AND n.mostly=1";
        }
        if((options & 0x1000) != 0) // 只显示内部
        {
            s4 += " AND n.mostly1=1";
        }
        if((options & 0x2000) != 0) // 只显示外部
        {
            s4 += " AND n.mostly2=1";
        }
        if(mark != null && mark.length() > 2) // mark!=null&&
        {
            String ms[] = mark.split("/");
            s4 += " AND n.mark!='/' AND(";
            for(int j = 1;j < ms.length;j++)
            {
                if(j > 1)
                {
                    s4 += " OR";
                }
                s4 += " n.mark LIKE '%/" + ms[j] + "/%'";
            }
            s4 += ")";
        }

        // /新闻资讯////////START/////////////////
        String s2 = null,s = null;
        boolean searchListing = false;
        String list[] = h.getValues("Listing");
        if(list != null)
        {
            for(int loop = 0;loop < list.length;loop++)
            {
                if(Integer.parseInt(list[loop]) == this.listing)
                {
                    searchListing = true;
                    break;
                }
            }
            if(searchListing)
            {
                StringBuilder s_1 = new StringBuilder();
                StringBuilder s_2 = new StringBuilder();
                s_1.append(" AND n.node IN ( SELECT nl.node FROM NodeLayer nl INNER JOIN Report r ON nl.node=r.node");
                s_2.append(" WHERE n.node=nl.node AND nl.language=").append(h.language);

                s = h.get("keyword");
                String s1 = h.get("media");
                s2 = h.get("radiobutton");
                String begin_date = h.get("begin_date");
                String end_date = h.get("end_date");
                String s3 = h.get("IssueMonth");
                String mediaid = h.get("mediaid"); // 新闻资讯
                // 媒体
                String classid = h.get("classid"); // 新闻资讯
                // 类别
                boolean flag = false;
                if(s != null && (s = s.trim()).length() > 0)
                {
                    java.util.StringTokenizer tokenizer = new java.util.StringTokenizer(s," ");
                    String keywods = "";
                    if(tokenizer.hasMoreTokens())
                    {
                        keywods = "\"" + tokenizer.nextToken() + "\"";
                    } while(tokenizer.hasMoreTokens())
                    {
                        keywods += " OR \"" + tokenizer.nextToken() + "\"";
                    }
                    s_2.append(" AND( CONTAINS(nl.subject," + DbAdapter.cite(keywods) + ")");
                    if(s2 != null && s2.equals("2"))
                    {
                        s_2.append(" OR CONTAINS(nl.content," + DbAdapter.cite(keywods) + ")");
                    }
                    s_2.append(") ");
                }
                if(mediaid != null && mediaid.length() > 0)
                {
                    s_2.append(" and r.media_id = " + DbAdapter.cite(mediaid));
                }
                if(classid != null && classid.length() > 0)
                {
                    s_2.append(" and r.class_id = " + DbAdapter.cite(classid));
                }
                if(begin_date != null && begin_date.length() > 0)
                {
                    s_2.append(" and r.issuetime >= " + DbAdapter.cite(begin_date));
                }
                if(end_date != null && end_date.length() > 0)
                {
                    s_2.append(" and r.issuetime < " + DbAdapter.cite(end_date));
                }
                if(s3 != null)
                {
                    int k = Integer.parseInt(s3);
                    Calendar calendar = Calendar.getInstance();
                    Date date2 = new Date(calendar.getTime().getTime());
                    calendar.set(5,5 - k);
                    Date date3 = new Date(calendar.getTime().getTime());
                    s_2.append(" and n.time < " + DbAdapter.cite(date2) + " and n.time > " + DbAdapter.cite(date3));
                }
            }
        }
        // //////////////END/////////////////////////////
        // 检索列举
        String tmp = h.get("id");
        if(tmp != null)
        {
            int id = Integer.parseInt(tmp);
            Search search = Search.find(id);
            if(search.exists() && search.isSearchListing(this.listing))
            {
                StringBuilder s_1 = new StringBuilder();
                StringBuilder s_2 = new StringBuilder();
                s_1.append(" AND n.node IN ( SELECT nl.node FROM NodeLayer nl");
                s_2.append(" WHERE n.node=nl.node AND nl.language=").append(h.language);
                if(search.getType() == 52)
                {
                    s_1.append(",Apply,Resume ");
                    s_2.append(" AND n.node=" + Node.NODE_TYPE[search.getType()] + ".node AND res.language=" + h.language);
                } else if(search.getType() != 255)
                {
                    s_1.append("," + Node.NODE_TYPE[search.getType()]);
                    if(search.getType() != 39)
                    {
                        s_2.append("  AND " + Node.NODE_TYPE[search.getType()] + ".language=" + h.language);
                    }
                    s_2.append(" AND " + Node.NODE_TYPE[search.getType()] + ".node=n.node ");
                    // s_2.append(" AND " + Node.NODE_TYPE[search.getType()] + ".language=" + h.language + " AND " + Node.NODE_TYPE[search.getType()] + ".node=n.node");
                }
                for(int loop = 1;loop < 5;loop++)
                {
                    String field = search.getField(loop,h.language);
                    if(field.length() > 0 && !field.equals("None"))
                    {
                        String value = h.get(field);
                        if(value != null && value.length() > 0)
                        {
                            value = value.trim(); // tea.html.HtmlElement.htmlToText(value.trim());
                            if(field.equals("all")) // 所有
                            {
                                // SearchField searchField = new SearchField();
                                s_2.append(" AND ( nl.subject LIKE " + DbAdapter.cite("%" + value + "%") + " OR nl.content LIKE " + DbAdapter.cite("%" + value + "%"));
                                if(search.getType() != 255)
                                {
                                    java.util.Enumeration enumeration2 = Field.findByType(search.getType());
                                    while(enumeration2.hasMoreElements())
                                    {
                                        Field fieldObj = (Field) enumeration2.nextElement();
                                        if(fieldObj.getDataType().equals("varchar") || fieldObj.getDataType().equals("char") || fieldObj.getDataType().equals("text"))
                                        {
                                            s_2.append(" OR " + Node.NODE_TYPE[search.getType()] + ".[" + fieldObj.getName() + "] like " + DbAdapter.cite("%" + value + "%"));
                                        }
                                    }
                                }
                                s_2.append(")");

                            } else if(field.equals("subject") || field.equals("keywords"))
                            {
                                s_2.append(" AND nl.[" + field + "] LIKE " + DbAdapter.cite("%" + value + "%"));
                            } else if(field.equals("content"))
                            {
                                s_2.append(" AND nl.content LIKE " + DbAdapter.cite("%" + value + "%"));
                            } else if(field.equals("path"))
                            {
                                s_2.append(" AND n.path LIKE " + DbAdapter.cite("%/" + value + "/%"));
                            } else
                            {
                                Field fieldobj = Field.find(search.getType(),field);
                                if(fieldobj.exists())
                                {
                                    if(fieldobj.getDataType().equals("datetime"))
                                    {
                                        s_2.append(" AND datename(yy," + field + ")+datename(mm," + field + ")+datename(dd," + field + ") =" + value);
                                    } else
                                    {
                                        s_2.append(" AND  " + Node.NODE_TYPE[search.getType()] + ".[" + field + "] like " + DbAdapter.cite("%" + value + "%"));
                                    }
                                }
                            }
                        }
                    }
                }
                if(search.getType() == 50)
                {
                    String locid = h.get("locid");
                    String allCorp = h.get("orgid");
                    if(locid != null && locid.length() > 0)
                    {
                        s_2.append(" AND n.node in (select ns.node from node ns,job j where j.node=ns.node and j.locid like '%/'+cast((select distinct code from jobcity where subject='" + locid + "') as varchar(10) )+'/%')");
                    }
                    if(allCorp != null && allCorp.length() > 0)
                    {
                        s_2.append(" AND n.node in (select ns.node from node ns,job j where j.node=ns.node and j.orgid=" + allCorp + ")");
                    }
                }
                // 大于
                String field = search.getField(5,h.language);
                if(field.length() > 0 && !field.equals("None"))
                {
                    String value = h.get(field + "Big");
                    Field fieldobj = Field.find(search.getType(),field);
                    if(value != null && value.length() > 0 && (fieldobj.exists() || "time".equals(field) || "updatetime".equals(field)))
                    {
                        if(field.equals("time") || field.equals("updatetime"))
                        {
                            s_2.append(" AND n.[" + field + "]>=" + DbAdapter.cite(value));
                        } else if(fieldobj.getDataType().equals("datetime"))
                        {
                            s_2.append(" AND datename(yy," + field + ")+datename(mm," + field + ")+datename(dd," + field + ") >= " + value);
                        } else
                        {
                            s_2.append(" AND " + field + " >= " + value);
                        }
                    }
                }
                // 小于
                field = search.getField(6,h.language);
                if(field.length() > 0 && !field.equals("None"))
                {
                    Field fieldobj = Field.find(search.getType(),field);
                    String value = h.get(field + "Small");
                    if((fieldobj.exists() || "time".equals(field) || "updatetime".equals(field)) && value != null && value.length() > 0)
                    {
                        if(field.equals("time") || field.equals("updatetime"))
                        {
                            s_2.append(" AND n.[" + field + "]<" + DbAdapter.cite(value));
                        } else if(fieldobj.getDataType().equals("datetime"))
                        {
                            s_2.append(" AND datename(yy," + field + ")+datename(mm," + field + ")+datename(dd," + field + ") < " + value);
                        } else
                        {
                            s_2.append(" AND " + field + " < " + value);
                        }
                    }
                }
                // 等于
                field = search.getField(9,h.language);
                if(field.length() > 0 && !field.equals("None"))
                {
                    Field fieldobj = Field.find(search.getType(),field);
                    String value = h.get(field + "Amount");
                    if((fieldobj.exists() || "creator".equals(field) || "time".equals(field) || "updatetime".equals(field)) && value != null && value.length() > 0)
                    {
                        if("apply".equals(field))
                        {
                            s_2.append(" AND Apply.resumenode=nl.node AND Apply.corpnode=" + DbAdapter.cite(value));
                        } else if(field.equals("creator"))
                        {
                            s_2.append(" AND n.rcreator=" + DbAdapter.cite(value) + " AND n.vcreator=" + DbAdapter.cite(value));
                        } else if(field.equals("time") || field.equals("updatetime"))
                        {
                            // s_2.append(" AND n.[" + field + "]=" + DbAdapter.cite(value));
                            s_2.append(" AND Report.issuetime=" + DbAdapter.cite(value));
                        } else if(fieldobj.getDataType().equals("datetime"))
                        {
                            s_2.append(" AND datename(yy," + field + ")+datename(mm," + field + ")+datename(dd," + field + ") = " + value);
                        } else
                        {
                            s_2.append(" AND " + Node.NODE_TYPE[search.getType()] + "." + field + " = " + DbAdapter.cite(value));
                        }
                    }
                }
                // 排序
//                field = search.getField(7, h.language);
//                if (field.length() > 0 && !field.equals("None"))
//                {
//                    stringbuffer = new StringBuilder(); //
//                    if (!field.equals("menuOrder"))
//                    {
//                        stringbuffer.append(Node.NODE_TYPE[search.getType()] + "." + field);
//                    } else if (h.get("menuOrder") != null)
//                    {
//                        stringbuffer.append(Node.NODE_TYPE[search.getType()] + "." + h.get("menuOrder"));
//                    }
//                }
                s_2.append(")");
                s4 = s4 + s_1.toString() + s_2.toString();

            }
        }
        boolean flag = ListingDetail.find(listing, -1,h.language).getIstype("Divide") != 0 || ListingDetail.find(listing, -1,h.language).getIstype("NodeCount") != 0;
        int len = Integer.MAX_VALUE;

        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            if(flag)
            {
                len = db.getInt("SELECT COUNT(n.node) " + s4);
                if((options & 0x80) != 0)
                {
                    len = len + db.getInt("select count(1) from translation where tonode=" + h.node);
                }
            } else
                pos = 0;
//            if(21506 == listing)
//            {
//                Filex.logs("listing.txt","SELECT n.node " + s4 + sql[1]);
//            }
            String sql2 = "";
            if((options & 0x80) != 0)
            {
                sql2 = Translation.inTranslation(h.node);
            }
            db.executeQuery("SELECT n.node" + (pos == 0 ? ",n.type,n.starttime,nl.language,nl.subject,nl.description,nl.picture" : "") + s4 + sql2 + sql[1],pos,size);
            while(db.next())
            {
                int j = 1;
                int id = db.getInt(j++);
                Node t;
                if(pos == 0)
                {
                    t = (Node) Node._cache.get(id);
                    if(t == null)
                    {
                        t = new Node(id);
                        Node._cache.put(id,t);
                        t.level = 1;
                    }
                    t.type = db.getInt(j++);
                    t.starttime = db.getDate(j++);
                    Node.NLayer l = (Node.NLayer) t.layer.get(h.language);
                    if(l == null)
                    {
                        l = t.new NLayer();
                        t.layer.put(h.language,l);
                        l.level = 1;
                    }
                    int lang = db.getInt(j++);
                    l.subject = db.getVarchar(lang,h.language,j++);
                    l.description = db.getVarchar(lang,h.language,j++);
                    l.picture = db.getString(j++);
                } else
                    t = Node.find(id);
                al.add(t);
            }
        } catch(Throwable ex)
        {
            System.out.println("Listing:出错了: ^_^  列举号:" + this.listing + " SQL:" + "SELECT n.node " + s4 + sql[1]);
            ex.printStackTrace();
        } finally
        {
            db.close();
        }
        return new Object[]
                {new Integer(len),al};
    }

//    public static Enumeration findNodes(RV rv,int pos,int size) throws SQLException
//    {
//        Vector vector = new Vector();
//        DbAdapter db = new DbAdapter();
//        try
//        {
//            db.executeQuery("SELECT DISTINCT l.node " + getNodesSql(rv),pos,size);
//            while(db.next())
//            {
//                vector.addElement(new Integer(db.getInt(1)));
//            }
//        } finally
//        {
//            db.close();
//        }
//        return vector.elements();
//    }

    public int getPosition() throws SQLException
    {
        load();
        return position;
    }

    public static Listing find(int i)
    {
        Listing listing = (Listing) _cache.get(new Integer(i));
        if(listing == null)
        {
            listing = new Listing(i);
        }
        return listing;
    }

    public static ArrayList find(Node node,int status,int position,boolean flag) throws SQLException
    {
        ArrayList v = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT listing FROM Listing l INNER JOIN Node n ON l.node=n.node");
        sql.append(" WHERE l.status=").append(status);
        if(position != -1)
        {
            sql.append(" AND l.position=").append(position);
        } else
        {
            sql.append(" AND l.type=0 AND l.pick=0"); //NodeLists.jsp
        }
        sql.append(" AND (");
        //本节点///////////////////////////////////////////////
        sql.append("(");
        if(flag)
        {
            sql.append(" l.style=0 AND");
        }
        sql.append(" l.node=").append(node._nNode).append(")");
        //本树,类型为...///////////////////////////////////////////////
        sql.append(" OR ( l.style=2 AND ( l.styletype=255 OR ( l.styletype=").append(node.getType());
        if(node.getType() == 1)
        {
            Category c = Category.find(node._nNode);
            sql.append(" AND l.stylecategory=").append(c.getCategory());
        }
        sql.append(" ) ) AND '").append(node.getPath()).append("' LIKE ").append(DbAdapter.concat("n.path","'%'"));
        sql.append(")");
        //
        sql.append(")");
        if(flag)
        {
            sql.append(" AND l.listing NOT IN (SELECT DISTINCT l.listing FROM Listing l INNER JOIN listinghide lh ON l.listing=lh.listing INNER JOIN Node n ON n.node=lh.node WHERE ( lh.hiden=0 AND " + DbAdapter.cite(node.getPath()) + " LIKE " + DbAdapter.concat("n.path","'%'") + ") OR (lh.hiden=2 AND lh.node=" + node._nNode + ") OR (lh.hiden=1 AND " + DbAdapter.cite(node.getPath()) + " LIKE " + DbAdapter.concat("n.path","'_%'") + "))");
        }
        sql.append(" ORDER BY l.sequence");
//		System.out.println(sql.toString());
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql.toString());
            while(db.next())
            {
                v.add(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v;
    }

    public String getSeparatorDetail(int i) throws SQLException
    {
        return getLayer(i,i)._strSeparatorDetail;
    }

    public String getAlt(int i) throws SQLException
    {
        return getLayer(i,i)._strAlt;
    }

    public static Enumeration findBriefcase(RV rv) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listing " + getBriefcaseSql(rv));
            for(;db.next();v.addElement(new Integer(db.getInt(1))))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findBriefcase(int i) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT listing " + getBriefcaseSql(i));
            for(;db.next();v.addElement(new Integer(db.getInt(1))))
            {
                ;
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public String getEditTalkback(int i) throws SQLException
    {
        return getLayer(i,i)._strEditTalkback;
    }

    public static int count(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT COUNT(*) FROM Listing WHERE 1=1" + sql);
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

    public static Enumeration find(String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT l.listing FROM Listing l" + tab(sql) + " WHERE 1=1" + sql,pos,size);
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

    static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if(sql.contains(" AND ll."))
            sb.append(" INNER JOIN ListingLayer ll ON ll.listing=l.listing");
        if(sql.contains(" AND n."))
            sb.append(" INNER JOIN Node n ON n.node=l.node");
        return sb.toString();
    }

    public static Enumeration findByNode(int i) throws SQLException
    {
        return find(" AND node=" + i,0,Integer.MAX_VALUE);
    }

    public int getNode() throws SQLException
    {
        load();
        return node;
    }

    public String getAfterItem(int i) throws SQLException
    {
        return getLayer(i,i)._strAfterItem;
    }

    public int getVisible() throws SQLException
    {
        load();
        return visible;
    }

    public int getOptions() throws SQLException
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
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT type,pick,style,styletype,stylecategory,node,status,sequence,position,visible,quantity,sonquantity,columns,options,mark,sorttype,sortdir,updategap,detailoptions,time,target,term,archive,ectypal,termdate FROM Listing WHERE listing=" + listing);
                if(db.next())
                {
                    int j = 1;
                    type = db.getInt(j++);
                    pick = db.getInt(j++);
                    style = db.getInt(j++);
                    styletype = db.getInt(j++);
                    stylecategory = db.getInt(j++);
                    node = db.getInt(j++);
                    status = db.getInt(j++);
                    sequence = db.getInt(j++);
                    position = db.getInt(j++);
                    visible = db.getInt(j++);
                    quantity = db.getInt(j++);
                    sonquantity = db.getInt(j++);
                    columns = db.getInt(j++);
                    options = db.getInt(j++);
                    mark = db.getString(j++);
                    sorttype = db.getInt(j++);
                    sortdir = db.getInt(j++);
                    updategap = db.getInt(j++);
                    detailoptions = db.getInt(j++);
                    time = db.getDate(j++);
                    target = db.getString(j++);
                    term = db.getInt(j++);
                    archive = db.getInt(j++);
                    ectypal = db.getInt(j++);
                    termdate = db.getInt(j++);
                    exists = true;
                    _cache.put(listing,this);
                } else
                {
                    exists = false;
                }
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public int getType() throws SQLException
    {
        load();
        return type;
    }

    public int getTermdate() throws SQLException
    {
        load();
        return termdate;
    }


    public int getDetailOptions() throws SQLException
    {
        load();
        return detailoptions;
    }

    public String getName(int i) throws SQLException
    {
        return getLayer(i,i)._strName;
    }

    public int getIsshowlayer(int i) throws SQLException
    {
        return getLayer(i,i).isshowlayer;
    }

    private Layer getLayer(int i,int j) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            layer.layerExisted = j == i;
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT name,more,talkbacks,edittalkback, chatroom,forwardnode,replynode,beforeitem,afteritem,separatordetail,beforelisting,afterlisting,columnafter,beforeitempicture,pictureposition,picture,clickurl,alt,align,isshowlayer FROM ListingLayer WHERE listing=" + listing + " AND language=" + j);
                if(db.next())
                {
                    layer._strName = db.getVarchar(j,i,1);
                    layer._strMore = db.getVarchar(j,i,2);
                    layer._strTalkbacks = db.getVarchar(j,i,3);
                    layer._strEditTalkback = db.getVarchar(j,i,4);
                    layer._strChatRoom = db.getVarchar(j,i,5);
                    layer._strForwardNode = db.getVarchar(j,i,6);
                    layer._strReplyNode = db.getVarchar(j,i,7);
                    layer._strBeforeItem = db.getText(j,i,8);
                    layer._strAfterItem = db.getText(j,i,9);
                    layer._strSeparatorDetail = db.getText(j,i,10);
                    layer._strBeforeListing = db.getText(j,i,11);
                    layer._strAfterListing = db.getText(j,i,12);
                    layer.columnAfter = db.getVarchar(j,i,13);
                    // //////图相关信息
                    layer._strBeforeItemPicture = db.getString(14);
                    layer._nPicturePosition = db.getInt(15);
                    layer._strPicture = db.getString(16);
                    layer._strClickUrl = db.getString(17);
                    layer._strAlt = db.getString(18);
                    layer._nAlign = db.getInt(19);
                    layer.isshowlayer = db.getInt(20);
                    //layer._strBeforeDetail = db.getText(j, i, 10);
                    //layer._strAfterDetail = db.getText(j, i, 12);
                    //layer._strBeforeChild = db.getText(j, i, 13);
                    //layer._strAfterChild = db.getText(j, i, 14);
                    //layer._strBeforeChildDetail = db.getText(j, i, 15);
                    //layer._strSeparatorChildDetail = db.getText(j, i, 16);
                    //layer._strAfterChildDetail = db.getText(j, i, 17);
                }
            } finally
            {
                db.close();
            }
            if(i == j && layer._strName == null)
            {
                return getLayer(i,getLanguage(i));
            }
            _htLayer.put(new Integer(i),layer);
        }
        return layer;
    }


    private int getLanguage(int language) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT language FROM ListingLayer WHERE listing=" + listing);
            while(db.next())
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        if(v.indexOf(new Integer(language)) != -1)
        {
            return language;
        } else
        {
            if(language == 1)
            {
                if(v.indexOf(new Integer(2)) != -1)
                {
                    return 2;
                }
            } else if(language == 2)
            {
                if(v.indexOf(new Integer(1)) != -1)
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

//    private static String getNodesSql(RV rv)
//    {
//        return " FROM Listing l, Node n  WHERE l.node=n.node  AND n.rcreator=" + DbAdapter.cite(rv._strR);
//    }

    public String getChatRoom(int i) throws SQLException
    {
        return getLayer(i,i)._strChatRoom;
    }

    private void set(int type,int pick,int style,int styletype,int stylecategory,int detailoptions,int position,int sequence,int visible,int quantity,int sonquantity,int columns,int options,String mark,int sorttype,int sortdir,int updategap,String target,int term,int archive,int ectypal,int language,String name,String more,String talkbacks,String edittalkback,String chatroom,String forwardnode,String replynode,String beforeitempicture,String beforeitem,String afteritem,String beforedetail,String separatordetail,String afterdetail,
                     String beforechild,String afterchild,String beforechilddetail,String separatorchilddetail,String afterchilddetail,String beforelisting,int pictureposition,String picture,String clickurl,String alt,int align,String afterlisting,Date time,String columnafter,int isshowlayer) throws SQLException
    {
        int j = 0;
        String[] arr1 = DbAdapter.split("ListingLayer","beforelisting",beforelisting,"listing=" + listing + " AND language=" + language);
        String[] arr2 = DbAdapter.split("ListingLayer","afterlisting",afterlisting,"listing=" + listing + " AND language=" + language);
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE ListingLayer SET name=" + DbAdapter.cite(name));
        sql.append(",more=" + DbAdapter.cite(more));
        sql.append(",talkbacks=" + DbAdapter.cite(talkbacks));
        sql.append(",edittalkback=" + DbAdapter.cite(edittalkback));
        sql.append(",chatroom=" + DbAdapter.cite(chatroom));
        sql.append(",forwardnode=" + DbAdapter.cite(forwardnode));
        sql.append(",replynode=" + DbAdapter.cite(replynode));
        sql.append(",beforeitem=" + DbAdapter.cite(beforeitem));
        sql.append(",afteritem=" + DbAdapter.cite(afteritem));
        sql.append(",beforedetail=" + DbAdapter.cite(beforedetail));
        sql.append(",separatordetail=" + DbAdapter.cite(separatordetail));
        sql.append(",afterdetail=" + DbAdapter.cite(afterdetail));
        sql.append(",beforechild=" + DbAdapter.cite(beforechild));
        sql.append(",afterchild=" + DbAdapter.cite(afterchild));
        sql.append(",beforechilddetail=" + DbAdapter.cite(beforechilddetail));
        sql.append(",separatorchilddetail=" + DbAdapter.cite(separatorchilddetail));
        sql.append(",afterchilddetail=" + DbAdapter.cite(afterchilddetail));
        sql.append(",beforelisting=" + DbAdapter.cite(arr1[0]));
        sql.append(",pictureposition=" + pictureposition);
        sql.append(",clickurl=" + DbAdapter.cite(clickurl));
        sql.append(",alt=" + DbAdapter.cite(alt));
        sql.append(",align=" + align);
        sql.append(",afterlisting=" + DbAdapter.cite(arr2[0]));
        sql.append(",columnafter=" + DbAdapter.cite(columnafter));
        sql.append(",isshowlayer=" + isshowlayer);
        if(beforeitempicture != null)
        {
            sql.append(",beforeitempicture=" + DbAdapter.cite(beforeitempicture));
        }
        if(picture != null)
        {
            sql.append(",picture=" + DbAdapter.cite(picture));
        }
        sql.append(" WHERE listing=" + listing + "  AND language=" + language);
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(listing,"UPDATE Listing SET type=" + type + ",pick=" + pick + ",style=" + style + ",styletype=" + styletype + ",stylecategory=" + stylecategory + ",detailoptions=" + detailoptions + ",sequence=" + sequence + ",position=" + position + ",visible=" + visible + ",quantity=" + quantity + ",sonquantity=" + sonquantity + ",columns=" + columns + ",options=" + options + ",mark=" + DbAdapter.cite(mark) + ",sorttype=" + sorttype + ",sortdir=" + sortdir + ",updategap=" + updategap + ",time=" + db.cite(time) + ",target=" + DbAdapter.cite(target) + ",term=" + term + ",archive=" + archive + ",ectypal=" + ectypal + " WHERE listing=" + listing);
            j = db.executeUpdate(listing,sql.toString());
            if(j < 1)
            {
                db.executeUpdate(listing,"INSERT INTO ListingLayer (listing, language, name, more, talkbacks,edittalkback, chatroom, forwardnode, replynode,beforeitempicture, beforeitem, afteritem,beforedetail, separatordetail, afterdetail,beforechild, afterchild,beforechilddetail, separatorchilddetail, afterchilddetail, beforelisting, pictureposition, picture, clickurl, alt, align, afterlisting, columnafter, isshowlayer)VALUES (" + listing + "," + language + "," + DbAdapter.cite(name) + ", "
                                 + DbAdapter.cite(more) + "," + DbAdapter.cite(talkbacks) + ", " + DbAdapter.cite(edittalkback) + "," + DbAdapter.cite(chatroom) + ", " + DbAdapter.cite(forwardnode) + ", " + DbAdapter.cite(replynode) + "," + DbAdapter.cite(beforeitempicture) + ", " + DbAdapter.cite(beforeitem) + ", " + DbAdapter.cite(afteritem) + "," + DbAdapter.cite(beforedetail) + ", " + DbAdapter.cite(separatordetail) + ", " + DbAdapter.cite(afterdetail) + "," + DbAdapter.cite(beforechild) + ", "
                                 + DbAdapter.cite(afterchild) + "," + DbAdapter.cite(beforechilddetail) + ", " + DbAdapter.cite(separatorchilddetail) + ", " + DbAdapter.cite(afterchilddetail) + ",' '," + pictureposition + ", " + DbAdapter.cite(picture) + ", " + DbAdapter.cite(clickurl) + ", " + DbAdapter.cite(alt) + ", " + align + ",' '," + DbAdapter.cite(columnafter) + ", " + isshowlayer + ")");
            }
            for(int i = 1;i < arr1.length;i++)
            {
                db.executeUpdate(listing,arr1[i]);
            }
            for(int i = 1;i < arr2.length;i++)
            {
                db.executeUpdate(listing,arr2[i]);
            }
        } finally
        {
            db.close();
        }
        this.type = type;
        this.pick = pick;
        this.style = style;
        this.styletype = styletype;
        this.stylecategory = stylecategory;
        this.detailoptions = detailoptions;
        this.sequence = sequence;
        this.position = position;
        this.visible = visible;
        this.quantity = quantity;
        this.sonquantity = sonquantity;
        this.columns = columns;
        this.options = options;
        this.mark = mark;
        this.sorttype = sorttype;
        this.sortdir = sortdir;
        this.updategap = updategap;
        this.time = time;
        this.target = target;
        this.term = term;
        this.archive = archive;
        this.ectypal = ectypal;
        _htLayer.clear();
    }

    public Date getTime() throws SQLException
    {
        load();
        return time;
    }

    private Listing(int i)
    {
        listing = i;
        _blLoaded = false;
        _htLayer = new Hashtable();
        _htCacheLayer = new Hashtable();
    }

    public static boolean isBriefcaseExisted(RV rv) throws SQLException
    {
        boolean flag = false;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  listing " + getBriefcaseSql(rv));
            flag = db.next();
        } finally
        {
            db.close();
        }
        return flag;
    }

    public boolean isLayerExisted(int i) throws SQLException
    {
        return getLayer(i,i).layerExisted;
    }

    public boolean isExisted() throws SQLException
    {
        load();
        return exists;
    }

    public int getTerm() throws SQLException
    {
        load();
        return term;
    }

    public String getReplyNode(int i) throws SQLException
    {
        return getLayer(i,i)._strReplyNode;
    }

    public String getPicture(int i) throws SQLException
    {
        return getLayer(i,i)._strPicture;
    }

    public int getQuantity() throws SQLException
    {
        load();
        return quantity;
    }

    public int getSonQuantity() throws SQLException
    {
        load();
        return sonquantity;
    }

    public String getBeforeItem(int i) throws SQLException
    {
        return getLayer(i,i)._strBeforeItem;
    }

    public String getAfterListing(int i) throws SQLException
    {
        return getLayer(i,i)._strAfterListing;
    }

    public String getForwardNode(int i) throws SQLException
    {
        return getLayer(i,i)._strForwardNode;
    }

    public void delete(int i) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(listing,"DELETE FROM ListingLayer WHERE listing=" + listing + " AND language=" + i);
            db.executeQuery("SELECT listing  FROM ListingLayer WHERE listing=" + listing);
            if(!db.next())
            {
                db.executeUpdate(listing,"DELETE FROM Listing WHERE listing=" + listing);
                exists = false;
            }
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(listing));
    }

    public int getSortType() throws SQLException
    {
        load();
        return sorttype;
    }

    public Listing()
    {
    }

    public String getTarget() throws SQLException
    {
        load();
        return target;
    }

    public int getArchive() throws SQLException
    {
        load();
        return archive;
    }

    public int getEctypal() throws SQLException
    {
        load();
        return ectypal;
    }

    public String getColumnAfter(int i) throws SQLException
    {
        return getLayer(i,i).columnAfter;
    }

    public int getStatus() throws SQLException
    {
        load();
        return status;
    }

    public Listing clone() throws CloneNotSupportedException
    {
        Listing t = (Listing)super.clone();
        t.listing = 0;
        return t;
    }

}
