package tea.entity.node;

import java.util.*;
import tea.db.DbAdapter;
import tea.entity.*;
import java.util.*;
import java.sql.SQLException;

//酒店的预定/////////////////////////////////
public class Destine extends Entity
{

    public static final String AFFIRM[] =
            {"NoNeed","Mobile","Phone","Fax","Email"};
    class Layer
    {
        public Layer()
        {
        }

        public String address;
        public String humanname;
        public String linkmanname;
        public String request;
    }


    private Hashtable _htLayer;
    private static Cache _cache = new Cache(100);
    private int node;
    private int roomcount;
    private int humancount;
    private String handset;
    private String phone;
    private String earlyarrive;
    private String eveningarrive;
    private String guesttype;
    private int paymenttype;
    private boolean linkmansex;
    private boolean sex; // add 入住人的sex
    private String linkmanhandset;
    private String linkmanphone;
    private String linkmanmail;
    private String linkmanfax;
    private int linkmanaffirm;
    private boolean othersend;
    private String otherpostalcode;

    private int otheraddbed;
    private boolean _blLoaded;
    private Date leavedate;
    private Date kipdate;
    private Date destinedate;
    private int destine;
    private int state; //订单的受理情况
    private int dstate;
    private int roomprice;
    private String member;
    private String community;
    private boolean exists;
    private String idea; //订单审核的意见
    private int ideatype; //审核的状态 同意0，不同意 1
    private String inform; //对订单的督促通知
    private Date informtimes; //订单时间

    private static final java.text.SimpleDateFormat ymd = new java.text.SimpleDateFormat("yyyyMMdd");
    public static final String STATE[] =
            {"未受理","已受理","入住正常","LESSSHOW","延住","NOSHOW"}; //{"NotAuditing", "WhenHousing", "AlreadyHousing", "NotHousing"};

    public Destine(int destine)
    {
        this.destine = destine;
        _htLayer = new Hashtable();
        load();
    }

    public static Destine find(int destine) throws SQLException
    {
//        Destine node = (Destine) _cache.get(new Integer(destine));
//        if (node == null)
//        {
//            node = new Destine(destine);
//            _cache.put(new Integer(destine), node);
//        }
        return new Destine(destine);
    }

    public int getNode() throws SQLException
    {
        return node;
    }

    public int getRoomcount() throws SQLException
    {
        return roomcount;
    }

    public int getHumancount() throws SQLException
    {
        return humancount;
    }

    public String getHandset() throws SQLException
    {
        return handset;
    }

    public String getPhone() throws SQLException
    {
        return phone;
    }

    public Date getKipdate()
    {
        return kipdate;
    }

    public Date getLeaveDate()
    {
        return leavedate;
    }

    public String getKipdateToString()
    {
        return sdf.format(kipdate);
    }

    public String getLeavedateToString()
    {
        return sdf.format(leavedate);
    }

    public String getEarlyarrive()
    {
        return earlyarrive;
    }

    public String getEveningarrive()
    {
        return eveningarrive;
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Destine  WHERE destine=" + destine);
        } finally
        {
            db.close();
        }
    }

    public String getGuesttype()
    {
        return guesttype;
    }

    public int getPaymenttype()
    {
        return paymenttype;
    }

    public String getLinkmanname(int language) throws SQLException
    {
        return getLayer(language).linkmanname;
    }

    public boolean isLinkmansex()
    {
        return linkmansex;
    }

    public boolean isSex()
    {
        return sex;
    }

    public String getLinkmanhandset()
    {
        return linkmanhandset;
    }

    public String getLinkmanphone()
    {
        return linkmanphone;
    }

    public String getLinkmanmail()
    {
        return linkmanmail;
    }

    public String getLinkmanfax()
    {
        return linkmanfax;
    }

    public int getLinkmanaffirm()
    {
        return linkmanaffirm;
    }

    public boolean isOthersend()
    {
        return othersend;
    }

    public String getOtherpostalcode()
    {
        return otherpostalcode;
    }

    private Layer getLayer(int i) throws SQLException
    {
        Layer layer = (Layer) _htLayer.get(new Integer(i));
        if(layer == null)
        {
            layer = new Layer();
            int j = this.getLanguage(i);
            DbAdapter db = new DbAdapter();
            try
            {
                db.executeQuery("SELECT humanname,linkmanname,address,request FROM DestineLayer WHERE destine=" + destine + " AND language=" + j);
                if(db.next())
                {
                    layer.humanname = db.getVarchar(j,i,1);
                    layer.linkmanname = db.getVarchar(j,i,2);
                    layer.address = db.getVarchar(j,i,3);
                    layer.request = db.getVarchar(j,i,4);
                }
            } finally
            {
                db.close();
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
            db.executeQuery("SELECT language FROM DestineLayer WHERE destine=" + destine);
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

    public String getAddress(int language) throws SQLException
    {
        return getLayer(language).address;
    }

    public String getRequest(int language) throws SQLException
    {
        return getLayer(language).request;
    }

    public int getOtheraddbed()
    {
        return otheraddbed;
    }

    public String getHumanname(int language) throws SQLException
    {
        return getLayer(language).humanname;
    }

    public void set(int roomprice,int roomcount,String handset,String phone,Date kipdate,Date leavedate,String eveningarrive,int paymenttype,boolean linkmansex,String linkmanhandset,String linkmanphone,String linkmanmail,String linkmanfax,int linkmanaffirm,boolean othersend,String otherpostalcode,int otheraddbed,int state,String member,int language,String humanname,String linkmanname,String address,
                    String request,int dstate,boolean sex) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Destine SET roomprice=" + (roomprice) + ",roomcount=" + roomcount + ",handset=" + DbAdapter.cite(handset) + ",phone=" + DbAdapter.cite(phone) + ",kipdate=" + db.cite(kipdate) + ",leavedate=" + db.cite(leavedate)
                             + ",eveningarrive=" + DbAdapter.cite(eveningarrive) + ",paymenttype=" + (paymenttype) + ",linkmansex=" + (linkmansex ? "1" : "0") + ",linkmanhandset=" + DbAdapter.cite(linkmanhandset) + ",linkmanphone=" + DbAdapter.cite(linkmanphone) + ",linkmanmail=" + DbAdapter.cite(linkmanmail) + ",linkmanfax=" + DbAdapter.cite(linkmanfax)
                             + ",linkmanaffirm=" + (linkmanaffirm) + ",othersend=" + (othersend ? "1" : "0") + ",otherpostalcode=" + DbAdapter.cite(otherpostalcode) + ",otheraddbed=" + (otheraddbed) + ",state=" + (state) + ",member=" + DbAdapter.cite(member) + ",community=" + DbAdapter.cite(community) + ", sex=" + (sex ? "1" : "0") + " WHERE destine=" + (destine));
            int j = db.executeUpdate("UPDATE DestineLayer SET destine=" + (destine) + ",language=" + language + ",humanname=" + DbAdapter.cite(humanname) + ",linkmanname=" + DbAdapter.cite(linkmanname) + ",address=" + DbAdapter.cite(address) + ",request=" + DbAdapter.cite(request) + " WHERE destine=" + destine + " AND language=" + language);

            if(j < 1)
            {
                db.executeUpdate("INSERT INTO DestineLayer(destine,language,humanname,linkmanname,address,request)VALUES(" + (destine) + "," + language + "," + DbAdapter.cite(humanname) + "," + DbAdapter.cite(linkmanname) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(request) + ")");
            }
        } finally
        {
            db.close();
        }
        this.node = node;
        this.roomprice = roomprice;
        this.destinedate = destinedate;
        this.roomcount = roomcount;
        this.humancount = humancount;
        this.handset = handset;
        this.phone = phone;
        new Layer().humanname = humanname;
        new Layer().linkmanname = linkmanname;
        new Layer().address = address;
        new Layer().request = request;
        this.kipdate = kipdate;
        this.leavedate = leavedate;
        this.eveningarrive = eveningarrive;
        this.paymenttype = paymenttype;
        this.linkmansex = linkmansex;
        this.linkmanhandset = linkmanhandset;
        this.linkmanphone = linkmanphone;
        this.linkmanmail = linkmanmail;
        this.linkmanfax = linkmanfax;
        this.linkmanaffirm = linkmanaffirm;
        this.othersend = othersend;
        this.otherpostalcode = otherpostalcode;
        this.otheraddbed = otheraddbed;
        this.state = state;
        this.dstate = dstate;
        this.member = member;
        _htLayer.clear();
    }

    public static int create(int node,int roomprice,int roomcount,String handset,String phone,Date kipdate,Date leavedate,String eveningarrive,int paymenttype,boolean linkmansex,String linkmanhandset,String linkmanphone,String linkmanmail,String linkmanfax,int linkmanaffirm,boolean othersend,String otherpostalcode,int otheraddbed,int state,String member,String community,int language,String humanname,String linkmanname,
                             String address,String request,boolean sex) throws SQLException
    {
        Date destinedate = new Date();
        int k4 = 0;
        String destine = ymd.format(destinedate) + SeqTable.getSeqNo("trade");
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Destine(destine,node,roomprice,destinedate,roomcount,handset,phone,kipdate,leavedate,eveningarrive,paymenttype,linkmansex,linkmanhandset,linkmanphone,linkmanmail,linkmanfax,linkmanaffirm,othersend,otherpostalcode,otheraddbed,state,member,community,sex)VALUES(" + destine + "," +
                             (node) + "," + (roomprice) + "," + db.cite(destinedate) + "," + roomcount + "," + DbAdapter.cite(handset) + "," + DbAdapter.cite(phone) + "," + db.cite(kipdate) + ","
                             + db.cite(leavedate) + "," + DbAdapter.cite(eveningarrive) + "," + (paymenttype) + "," + (linkmansex ? "1" : "0") + "," + DbAdapter.cite(linkmanhandset) + "," + DbAdapter.cite(linkmanphone) + "," + DbAdapter.cite(linkmanmail) + "," + DbAdapter.cite(linkmanfax) + "," + (linkmanaffirm) + "," + (othersend ? "1" : "0") + "," + DbAdapter.cite(otherpostalcode) + "," + (otheraddbed) + "," + (state) + ","
                             + DbAdapter.cite(member) + "," + DbAdapter.cite(community) + "," + (sex ? "1" : "0") + ")");
            k4 = db.getInt("SELECT MAX(destine) FROM Destine");
            db.executeUpdate("INSERT INTO DestineLayer(destine,language,humanname,linkmanname,address,request)VALUES(" + k4 + "," + language + "," + DbAdapter.cite(humanname) + "," + DbAdapter.cite(linkmanname) + "," + DbAdapter.cite(address) + "," + DbAdapter.cite(request) + ")");
        } finally
        {
            db.close();
        }
        _cache.remove(new Integer(k4));
        return k4;
    }

    private void load()
    {
        if(!_blLoaded)
        {
            DbAdapter db = new DbAdapter();
            try
            {
                //添加一个sex字段
                db.executeQuery("SELECT node,roomprice,destinedate,roomcount,humancount,handset,phone,kipdate,leavedate,earlyarrive,eveningarrive,guesttype,paymenttype,linkmansex,linkmanhandset,linkmanphone,linkmanmail,linkmanfax,linkmanaffirm,othersend,otherpostalcode,otheraddbed,state,member,community,dstate,sex,idea,ideatype,inform,informtimes FROM Destine WHERE destine=" + destine);
                if(db.next())
                {
                    node = db.getInt(1);
                    roomprice = db.getInt(2);
                    destinedate = db.getDate(3);
                    roomcount = db.getInt(4);
                    humancount = db.getInt(5);
                    handset = db.getString(6);
                    phone = db.getString(7);
                    kipdate = db.getDate(8);
                    leavedate = db.getDate(9);
                    earlyarrive = db.getString(10);
                    eveningarrive = db.getString(11);
                    guesttype = db.getString(12);
                    paymenttype = db.getInt(13);
                    linkmansex = db.getInt(14) != 0;
                    linkmanhandset = db.getString(15);
                    linkmanphone = db.getString(16);
                    linkmanmail = db.getString(17);
                    linkmanfax = db.getString(18);
                    linkmanaffirm = db.getInt(19);
                    othersend = db.getInt(20) != 0;
                    otherpostalcode = db.getString(21);
                    otheraddbed = db.getInt(22);
                    state = db.getInt(23);
                    member = db.getString(24);
                    community = db.getString(25);
                    dstate = db.getInt(26);
                    sex = db.getInt(27) != 0;
                    idea = db.getString(28);
                    ideatype = db.getInt(29);
                    inform = db.getString(30);
                    informtimes = db.getDate(31);
                    /*
                     * //入住信息 this.roomcount = db.getInt(1); //房间数量 this.humancount = db.getInt(2); //入住人数 // this.humanname = db.getVarchar(language, language, 3); //入住人 this.handset = db.getString(4); //手机号码 this.phone = db.getString(5); //电话号
                     *
                     *
                     * this.kipDate = db.getDate(7); //住店日期 this.leaveDate = db.getDate(8); //离开日期
                     *
                     * this.earlyarrive = db.getString(9); //最早到达时间 this.eveningarrive = db.getString(10); //最晚到达时间 this.guesttype = db.getString(11); //客人类型 this.paymenttype = db.getInt(12); //付款类型 //联系人信息 this.linkmanname = db.getVarchar(language, language, 13); this.linkmanSex = db.getInt(14) != 0; this.linkmanHandset = db.getString(15); this.linkmanPhone = db.getString(16); this.linkmanMail = db.getString(17); this.linkmanFax = db.getString(18); this.linkmanAffirm = db.getInt(19); //其它信息
                     * this.otherSend = db.getInt(20) != 0; this.otherPostalcode = db.getString(21); this.otherAddress = db.getVarchar(language, language, 22); this.otherRequest = db.getVarchar(language, language, 23); this.otherAddBed = db.getInt(24); //语言 this.language = db.getInt(25);
                     *
                     * this.node = db.getInt(26); this.destineDate = db.getDate(27); this.state = db.getInt(28); member = db.getString(29);
                     */
                    // 如果"离开日期" 小于或等于今天 并且 状态为“等待入住”则 把状态改为"未入住"     ( 1 等待入住 /2 入住 /3 未入住)( 0 未受理订单 1 受理订单 2 过期订单)
                    if(sdf.format(leavedate).equals(sdf.format(new Date())) && state == 1 && dstate == 3)
                    {
                        setState(3);
                        setDstate(2);
                    }
                    exists = true;
                } else
                {
                    exists = false;
                    leavedate = kipdate = new Date();
                }
                /*
                 * else { this.humanname =""; this.handset = ""; //手机号码 this.phone =""; //电话号 this.roomtype = ""; //房间类型 this.earlyarrive = ""; //最早到达时间 this.eveningarrive = ""; //最晚到达时间 this.guesttype = db.getString(11); //客人类型 this.paymenttype = db.getString(12); //付款类型 //联系人信息 this.linkmanname = db.getString(13); this.linkmanFax = db.getBoolean(14) != 0; this.linkmanHandset = db.getString(15); this.linkmanPhone = db.getString(16); this.linkmanMail = db.getString(17); this.linkmanFax =
                 * db.getString(18); this.linkmanAffirm = db.getString(19); //其它信息 this.otherSend = db.getString(20) != 0; this.otherPostalcode = db.getString(21); this.otherAddress = db.getString(22); this.otherRequest = db.getString(23); this.otherAddBed = db.getString(24); //语言 this.language = db.getString(25); }
                 */

            } catch(Exception ex)
            {
                ex.printStackTrace();
            } finally
            {
                db.close();
            }
            _blLoaded = true;
        }
    }

    public static int countByMember(String community,String member) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(node) FROM Destine WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
            if(db.next())
            {
                return db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return 0;
    }

    //会员的订单数量：　
    public static int countByMember(String community,String member,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(destine) FROM Destine WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member) + sql);
            if(db.next())
            {
                return db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return 0;
    }

    public static int count(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(*) FROM Destine WHERE community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                return db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return 0;
    }

    public static int countBy(String community,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(*) FROM Destine d,Node n  WHERE d.node=n.node and d.community=" + DbAdapter.cite(community) + sql);
            if(db.next())
            {
                return db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return 0;
    }

    public static int countBuffer(String community,int i,String sql) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(*) FROM Destine d,Node n  WHERE d.node=n.node and d.community=" + DbAdapter.cite(community) + " and d.state=" + i + sql);

            if(db.next())
            {
                return db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return 0;
    }


    public static Enumeration find(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT destine FROM Destine WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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

    public static Enumeration findMasterDes(String community,String sql,String city,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select destine from destine where node in(select node from hostel where city in(" + city + ")) and community=" + DbAdapter.cite(community) + sql,pos,size);
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


    public static Enumeration findBy(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT  d.destine FROM Destine d,Node n WHERE d.node=n.node  and d.community=" + DbAdapter.cite(community) + sql,pos,size);
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


    //统计酒店显示
    public static Enumeration findTj(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT distinct node FROM Destine WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
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


//统计酒店订单数量
    public static int countTj(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(*) FROM Destine where 1=1 " + sql);

            if(db.next())
            {
                j = db.getInt(1);
            }

        } catch(Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
        return j;
    }

    //@author huangyu
    public static int countHO(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(sql);
            if(db.next())
            {
                j = db.getInt(1);
            }

        } catch(Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
        return j;
    }


    public static int countTj2(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(distinct  node) FROM Destine where 1=1 " + sql);

            if(db.next())
            {
                j = db.getInt(1);
            }

        } catch(Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
        return j;
    }

    public static int countMember(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(distinct member) FROM Destine where 1=1 " + sql);

            if(db.next())
            {
                j = db.getInt(1);
            }

        } catch(Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
        return j;
    }

//@author huangyu
    public static Enumeration find(String community) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT distinct node FROM Destine WHERE community=" + DbAdapter.cite(community));

            for(int k = 0;db.next();k++)
            {
                v.addElement(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    //@author huagnyu:
    public static int countint(String sql) throws SQLException
    {
        int j = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT count(*) FROM Destine where 1=1 " + sql);

            if(db.next())
            {
                j = db.getInt(1);
            }

        } catch(Exception e)
        {
            throw new SQLException(e.toString());
        } finally
        {
            db.close();
        }
        return j;
    }

    //@author huangyu :找到会员：
    public static Enumeration findmember(String community,String sql,int pos,int size) throws SQLException
    {
        Vector v = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT distinct member FROM Destine WHERE community=" + DbAdapter.cite(community) + sql,pos,size);
            while(db.next())
            {
                v.addElement(db.getString(1));
            }
        } finally
        {
            db.close();
        }
        return v.elements();
    }

    public static Enumeration findByMember(String community,String member) throws SQLException
    {
        Vector vector = new Vector();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT destine FROM Destine WHERE community=" + DbAdapter.cite(community) + " AND member=" + DbAdapter.cite(member));
            while(db.next())
            {
                vector.add(new Integer(db.getInt(1)));
            }
        } finally
        {
            db.close();
        }
        return vector.elements();
    }

    public String getDestineCode()
    {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
        return sdf.format(getDestinedate()) + String.valueOf(getDestine());
    }

    public void setState(int state) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Destine SET state=" + state + " WHERE destine=" + destine);
        } finally
        {
            db.close();
        }
        this.state = state;
    }

    public void setDstate(int dstate) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Destine SET dstate=" + dstate + " WHERE destine=" + destine);
        } finally
        {
            db.close();
        }
        this.dstate = dstate;
    }

    //2-29 ZHANGJINSHU 添加 // 审核订单中添加意见
    public void setIdea(String idea,int ideatype,int state) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Destine SET state=" + state + ", idea=" + db.cite(idea) + " ,ideatype=" + ideatype + " WHERE destine=" + destine);
        } finally
        {
            db.close();
        }
        this.idea = idea;
        this.ideatype = ideatype;
    }

    public void setInform(String inform) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        Date destinetime = new Date();
        try
        {
            db.executeUpdate("UPDATE Destine SET inform =" + db.cite(inform) + ",informtimes=" + db.cite(destinetime) + "  WHERE  destine= " + destine);
        } finally
        {
            db.close();
        }
        this.inform = inform;
        this.informtimes = informtimes;
    }

    public Date getDestinedate()
    {
        return destinedate;
    }

    public String getDestinedateToString()
    {
        if(destinedate == null)
        {
            return "";
        }
        return sdf.format(destinedate);
    }

    public int getDestine()
    {
        return destine;
    }

    public int getState()
    {
        return state;
    }

    public int getDstate()
    {
        return dstate;
    }


    public int getRoomprice()
    {
        return roomprice;
    }

    public String getMember()
    {
        return member;
    }

    public String getCommunity()
    {
        return community;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getIdea()
    {
        if(idea == null)
        {
            return "";
        }
        return idea;
    }

    public int getIdeatype()
    {
        return ideatype;
    }

    public String getInform()
    {
        return inform;
    }

    public Date getInformtimes()
    {
        return informtimes;
    }

    public String getInformtimesToString()
    {
        if(informtimes == null)
        {
            return "";
        }
        return sdf.format(informtimes);
    }
}
