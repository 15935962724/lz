package tea.entity.node;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Timer;
import java.util.TimerTask;

import javax.imageio.IIOException;
import javax.imageio.ImageIO;
import tea.ui.*;
import tea.db.DbAdapter;
import tea.entity.Arrayx;
import tea.entity.Cache;
import tea.entity.Entity;
import tea.entity.Filex;
import tea.entity.*;
import tea.entity.member.Profile;
import tea.html.Anchor;
import tea.html.Span;
import tea.resource.Resource;

public class Score
{
    private static Cache _cache = new Cache(100);
    public final static String TEE_TYPE[] =
            {"Black","Gold","Blue","White","Red"}; //黑 黄 蓝 白 红
    public int score;
    public String member; //用户
    public int node; //球场ID
    public String name; //球场名称
    public int tee; //发球台
    public boolean compete; //是否比赛
    public int sums; //总杆数
    public int cavity;
    public int standard[] = new int[18]; //标准杆
    public int fact[] = new int[18]; //实际杆 up+bunt
    public Date times; //打球日期

    public String caddy; //球童编号
    public String text;
    public boolean[] fairway = new boolean[18]; //第一杆上球道否
    public boolean[] hfinish = new boolean[18]; //本杆是否完成
    public int[] up = new int[18]; //上果岭杆数
    public int[] bunt = new int[18]; //推杆数
    private Date createTime;
    private Date alterTime;
    public float diff; //差点微分
    public float avgs; //差点指数
    public boolean calc; //是否用于计算
    private float par3c,par4c,par5c,parc = -1F;
    private int eagle,birdie,par,bogey,duble,paron;
    private int shows; //是否显示更新差点成绩

    //同步 信息
    public String creditcard; //信用卡ID
    public String posid; //设备编号
    //场地的序号
    private String fieldid,fieldid2;

    public boolean exists;
    public Score()
    {
    }


    public static Score find(int score) throws SQLException
    {
        Score obj = (Score) _cache.get(score);
        if(obj == null)
        {
            Iterator it = find(" AND score=" + score,0,1).iterator();
            obj = it.hasNext() ? (Score) it.next() : new Score();
            _cache.put(score,obj);
        }
        return obj;
    }

//    public Score(int score) throws SQLException
//    {
//        this.score = score;
//        standard = new int[18];
//        fact = new int[18];
//        up = new int[18];
//        bunt = new int[18];
//        for(int i = 0;i < 18;i++)
//        {
//            bunt[i] = up[i] = standard[i] = fact[i] = 0;
//        }
//        // Arrays.fill(standard,0);
//        loadBasic();
//    }

    public static void set(int score,String member,int node,String name,int tee,boolean compete,int sums,int cavity,int fact[],
                           boolean[] fairway,int[] up,int[] bunt,Date times,String caddy,String text,String creditcard,String posid,String fieldid,
                           String fieldid2,boolean hfinish[]) throws SQLException
    {

        float diff = calcDiff(node,tee,sums,fieldid,fieldid2); //计算差点微分

        float avgs = -10000f; //计算差点指数

        StringBuilder _fact = new StringBuilder();
        StringBuilder _fairway = new StringBuilder();
        StringBuilder _hfinish = new StringBuilder();
        StringBuilder _up = new StringBuilder();
        StringBuilder _bunt = new StringBuilder();
        if(score > 0)
        {
            for(int i = 0;i < 18;i++)
            {
                _fact.append(",fact" + (i + 1) + "=" + fact[i]);
                _fairway.append(",fairway" + (i + 1) + "=" + DbAdapter.cite(fairway[i]));
                _hfinish.append(",hfinish" + (i + 1) + "=" + DbAdapter.cite(hfinish[i]));
                _up.append(",up" + (i + 1) + "=" + up[i]);
                _bunt.append(",bunt" + (i + 1) + "=" + bunt[i]);
            }
            DbAdapter.execute("UPDATE Score SET member=" + DbAdapter.cite(member) +
                              ",node=" + node +
                              ",name=" + DbAdapter.cite(name) +
                              ",tee=" + tee +
                              ",compete=" + (compete ? "1" : "0") +
                              ",sums=" + sums + ",cavity=" + cavity +
                              _fact.toString() +
                              _fairway.toString() +
                              _hfinish.toString() +
                              _up.toString() +
                              _bunt.toString() +
                              ",diff=" + diff +
                              ",times=" + DbAdapter.cite(times) +
                              ",caddy=" + DbAdapter.cite(caddy) +
                              ",text=" + DbAdapter.cite(text) +
                              ",altertime=" + DbAdapter.cite(new Date()) +
                              ",fieldid=" + DbAdapter.cite(fieldid) +
                              ",fieldid2=" + DbAdapter.cite(fieldid2) +
                              ",avgs=" + avgs +
                              " WHERE score=" + score);

            _cache.remove(new Integer(score));
        } else
        {
            for(int i = 0;i < 18;i++)
            {
                _fact.append("," + fact[i]);
                _fairway.append("," + DbAdapter.cite(fairway[i]));
                _hfinish.append("," + DbAdapter.cite(hfinish[i]));

                _up.append("," + up[i]);
                _bunt.append("," + bunt[i]);
            }
            DbAdapter.execute(
                    "INSERT INTO Score(member,node,name,tee,compete,sums,cavity,fact1,fact2,fact3,fact4,fact5,fact6,fact7,fact8,fact9,fact10," +
                    "fact11,fact12,fact13,fact14,fact15,fact16,fact17,fact18,fairway1,fairway2,fairway3,fairway4,fairway5,fairway6,fairway7,fairway8," +
                    "fairway9,fairway10," +
                    "fairway11,fairway12,fairway13,fairway14,fairway15,fairway16,fairway17,fairway18,up1,up2,up3,up4,up5,up6,up7,up8,up9,up10," +
                    "up11,up12,up13,up14,up15,up16,up17,up18,bunt1,bunt2,bunt3,bunt4,bunt5,bunt6,bunt7,bunt8,bunt9,bunt10," +
                    "bunt11,bunt12,bunt13,bunt14,bunt15,bunt16,bunt17,bunt18,diff,times,caddy,text,creditcard,posid,fieldid,fieldid2,avgs," +
                    "hfinish1,hfinish2,hfinish3,hfinish4,hfinish5,hfinish6,hfinish7,hfinish8,hfinish9,hfinish10," +
                    "hfinish11,hfinish12,hfinish13,hfinish14,hfinish15,hfinish16,hfinish17,hfinish18)VALUES("
                    + DbAdapter.cite(member) + "," + node + "," + DbAdapter.cite(name) + "," + tee + " , " + (compete ? "1" : "0") + " , " + sums + ", " +
                    "" + cavity + _fact.toString() + _fairway.toString() + _up.toString() + _bunt.toString() + " , " + diff + " , " + DbAdapter.cite(times) + " ," +
                    "" + DbAdapter.cite(caddy) + " ," + DbAdapter.cite(text) + " ," + DbAdapter.cite(creditcard) + "," + DbAdapter.cite(posid) + "," +
                    "" + DbAdapter.cite(fieldid) + "," + DbAdapter.cite(fieldid2) + "," + avgs + _hfinish.toString() + " )");
            Golf.setHits(node, -1);
            score = Score.getScoreID(node,member,posid);
            System.out.println("成绩ID号：" + score);
        }

        //计算差点指数
        avgs = Score.getIndex(member);
        Score.setAvgs(avgs,score);

        System.out.println("如果是第一次成绩，则当前差点：次数是：" + Score.count(" and member =" + DbAdapter.cite(member)));
        if(Score.count(" and member =" + DbAdapter.cite(member)) == 5)
        {
            Score.setShows(1,score);
        }

        //鉴定和更新
        if(compete && Score.getIdentification(score) != -10000) //是比赛成绩
        {
            if(Score.isTime())
            {
                Score.setShows(1,score); //如果是最后一天 才更新差点指数
            }
            Score.setAvgs(Score.getIdentification(score),score);
        }

        if(member != null)
        {
            _cache.remove(member);
        }
    }

    //判断是否一月的最后一天
    public static boolean isTime() throws SQLException
    {
        boolean f = false;
        Date a = new Date();
        Calendar b = Calendar.getInstance();
        b.setTime(a);
        int lastDay = b.getActualMaximum(Calendar.DAY_OF_MONTH);
        int now = b.get(Calendar.DAY_OF_MONTH);
        if(now == lastDay)
        {
            f = true;
        }
        return f;
    }

    //定时更新
    public static void sync()
    {
        try
        {
            Timer timer = new Timer();
            timer.schedule(new TimerTask()
            {
                String last = null;
                public void run()
                {
                    try
                    {
                        if(isTime() && new Date().getHours() == 23) //每天晚上23点更新
                        {
                            //

                            Score.UpdateScore();
                        }

                    } catch(SQLException e)
                    {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }

                // },0,2* 60 * 1000);//2分钟扫描一次
            },0,1 * 60 * 60 * 1000); //1个小时扫描一次
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }

    }

    //定时计算所以用户的 成绩鉴定更新
    public static void UpdateScore() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT member FROM Score  group by member ");
            while(db.next())
            {
                String member = db.getString(1);
                db.executeQuery("SELECT score FROM Score  where member=" + DbAdapter.cite(member) + " order by createtime desc ",0,1);
                if(db.next())
                {
                    int score = db.getInt(1);
                    if(Score.getIdentification(score) != -10000)
                    {
                        System.out.println("-----------差点指数 鉴定更新方法启动--------------------");
                        System.out.println("鉴定更新后的差点指数为：" + Score.getIdentification(score));
                        Score.setAvgs(Score.getIdentification(score),score);
                    }
                }
            }
        } finally
        {
            db.close();
        }
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM score WHERE 1=1" + sql);
    }

    public static ArrayList findByMember(String member) throws SQLException // hidden 是否显示隐藏项
    {
        return find(" AND member=" + DbAdapter.cite(member),0,200);
    }

    //查询差点指数的历史记录
    public static String agrs(String sql) throws SQLException
    {
        StringBuffer sp = new StringBuffer();
        DbAdapter db = new DbAdapter();
        float avgs = -10000f;
        Date times = null;
        try
        {
            db.executeQuery("SELECT avgs ,createtime FROM Score WHERE " + sql + " order by createtime desc ",0,Integer.MAX_VALUE);
            //db.executeQuery("SELECT avgs ,createtime FROM Score WHERE "+sql+" order by createtime desc ",0,1);
            int i = 0;
            float ss = -10000f;
            while(db.next())
            {
                avgs = db.getFloat(1);
                times = db.getDate(2);
                if(avgs != ss) //重复
                {
                    sp.append("<time" + (i + 1) + ">" + Entity.sdf.format(times) + "</time" + (i + 1) + "><handicaptime" + (i + 1) + ">" + avgs + "</handicaptime" + (i + 1) + ">");
                    ss = avgs;
                    i++;
                }
            }
            if(i > 0)
            {
                for(int j = i;j < 5;j++)
                {
                    sp.append("<time" + (j + 1) + ">无</time" + (j + 1) + "><handicaptime" + (j + 1) + ">无</handicaptime" + (j + 1) + ">");
                }
            } else
            {
                for(int j = 0;j < 5;j++)
                {
                    sp.append("<time" + (j + 1) + ">无</time" + (j + 1) + "><handicaptime" + (j + 1) + ">无</handicaptime" + (j + 1) + ">");
                    // sp.append("因最近12个月内您提交的打球成绩少于5次，故暂无差点指数记录");
                }
            }

        } finally
        {
            db.close();
        }
        return sp.toString();
    }

    //判断在记录是否在两个小时之内
    public static int getScoreTime(int node,String member,String posid,Date times) throws SQLException
    {
        //SELECT * FROM Score WHERE  node =57 AND member ='01023491' AND posid='S13002080912180008'   AND times >= '2010-08-29 07:57:20'
        int sid = 0;
        int editTime = 0;
        int m = 1;
        SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SS");
        Date mydate = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(mydate);
        cal.add(Calendar.MINUTE,1); //减120分钟数
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT score FROM Score WHERE  node =" + node + " AND member =" + db.cite(member) + " AND posid=" + db.cite(posid) + "   AND createtime >= " + db.cite(times) + " AND createtime <=" + db.cite(cal.getTime()) + " order by createtime desc ");
            // System.out.println("SELECT score FROM Score WHERE  node ="+node+" AND member ="+db.cite(member)+" AND posid="+db.cite(posid)+"   AND createtime >= "+db.cite(times)+" AND createtime <="+db.cite(cal.getTime())+" order by createtime desc ");
            if(db.next())
            {
                sid = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return sid;

    }

    //获取 刚插入id
    public static int getScoreID(int node,String member,String posid) throws SQLException
    {
        int sid = 0;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT score FROM Score WHERE  node =" + node + " AND member =" + db.cite(member) + " AND posid=" + db.cite(posid) + "   order by createtime desc ",0,1);

            if(db.next())
            {
                sid = db.getInt(1);
            }
        } finally
        {
            db.close();
        }
        return sid;
    }

    //修改差点指数
    public static void setAvgs(float avgs,int score) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(" update Score set avgs=" + avgs + " where  score = " + score);
        } finally
        {
            db.close();
        }
    }

    //修改显示 差点成绩
    public static void setShows(int shows,int score) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(" update Score set shows=" + shows + " where  score = " + score);
        } finally
        {
            db.close();
        }
    }

    public static ArrayList find(String sql,int p,int size) throws SQLException // hidden 是否显示隐藏项
    {
        if(sql.indexOf(" ORDER BY ") == -1)
        {
            sql += " ORDER BY times DESC";
        }
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery(
                    "SELECT score,member,node,name,tee,compete,sums,cavity,standard1,standard2,standard3,standard4,standard5,standard6,standard7,standard8,standard9,standard10," +
                    "standard11,standard12,standard13,standard14,standard15,standard16,standard17,standard18,fact1,fact2,fact3,fact4,fact5,fact6,fact7,fact8,fact9,fact10," +
                    "fact11,fact12,fact13,fact14,fact15,fact16,fact17,fact18,fairway1,fairway2,fairway3,fairway4,fairway5,fairway6,fairway7,fairway8,fairway9,fairway10," +
                    "fairway11,fairway12,fairway13,fairway14,fairway15,fairway16,fairway17,fairway18,up1,up2,up3,up4,up5,up6,up7,up8,up9,up10," +
                    "up11,up12,up13,up14,up15,up16,up17,up18,bunt1,bunt2,bunt3,bunt4,bunt5,bunt6,bunt7,bunt8,bunt9,bunt10," +
                    "bunt11,bunt12,bunt13,bunt14,bunt15,bunt16,bunt17,bunt18,diff,calc,times,caddy,text,createtime,altertime,creditcard,posid,fieldid,fieldid2,avgs," +
                    "hfinish1,hfinish2,hfinish3,hfinish4,hfinish5,hfinish6,hfinish7,hfinish8,hfinish9,hfinish10," +
                    "hfinish11,hfinish12,hfinish13,hfinish14,hfinish15,hfinish16,hfinish17,hfinish18,shows FROM score WHERE 1=1" +
                    sql,p,size);

            while(db.next())
            {
                int j = 1;
                Score s = new Score();
                s.score = db.getInt(j++);
                s.member = db.getString(j++);
                s.node = db.getInt(j++);
                s.name = db.getString(j++);
                s.tee = db.getInt(j++);
                s.compete = db.getInt(j++) != 0;
                s.sums = db.getInt(j++);
                s.cavity = db.getInt(j++);
                for(int i = 0;i < 18;i++)
                {
                    s.standard[i] = db.getInt(j++);
                }
                for(int i = 0;i < 18;i++)
                {
                    s.fact[i] = db.getInt(j++);
                }
                for(int i = 0;i < 18;i++)
                {
                    s.fairway[i] = db.getInt(j++) != 0;
                }

                for(int i = 0;i < 18;i++)
                {
                    s.up[i] = db.getInt(j++);
                }
                for(int i = 0;i < 18;i++)
                {
                    s.bunt[i] = db.getInt(j++);
                }
                s.diff = db.getFloat(j++);
                s.calc = db.getInt(j++) != 0;
                s.times = db.getDate(j++);
                s.caddy = db.getString(j++);
                s.text = db.getString(j++);
                s.createTime = db.getDate(j++);
                s.alterTime = db.getDate(j++);
                s.creditcard = db.getString(j++);
                s.posid = db.getString(j++);
                s.fieldid = db.getString(j++);
                s.fieldid2 = db.getString(j++);
                s.avgs = db.getFloat(j++);

                for(int i = 0;i < 18;i++)
                {
                    s.hfinish[i] = db.getInt(j++) != 0;
                }
                s.shows = db.getInt(j++);
                s.exists = true;
                _cache.put(s.score,s);
                al.add(s);
            }
        } finally
        {
            db.close();
        }
        return al;
    }

    // 最近20次 getTemporarilyByNode
    public static float getIndex(String member) throws SQLException
    {
        // Float obj = (Float) _cache.get(member);
        //if(obj == null)
        // {
        // obj = getExponent(" AND member=" + DbAdapter.cite(member),member,true);
        // _cache.put(member,obj);
        //}
        return getExponent(" AND member=" + DbAdapter.cite(member),member,true);
    }

    public static float getMonthlyByNode_(String member) throws SQLException
    {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH,calendar.get(Calendar.MONTH) - 1);
        return getMonth(member,calendar.getTime());
    }

    public static float calcDiff(int gid,int tee,int sums,String fieldid,String fieldid2) throws SQLException
    {
        float difficulty = 0f,gradient = 0f;
        GolfSite gobj1 = GolfSite.find(GolfSite.getGSid(gid,fieldid));
        GolfSite gobj2 = GolfSite.find(GolfSite.getGSid(gid,fieldid2));

        if(gobj1.isExists() && gobj2.isExists())
        {
            // Golf g = Golf.find(gid,1);

            difficulty = gobj1.difficultys[tee] + gobj2.difficultys[tee]; // g.difficultys[tee];//球场难度系数= 前区和后区的相加
            //球场坡度系数 = （前区+后区）÷ 2
            gradient = (new BigDecimal(gobj1.gradients[tee]).add(new BigDecimal(gobj2.gradients[tee]))).divide(new BigDecimal("2")).floatValue(); //g.gradients[tee];

        }
        // 差点微分＝（调整后的总杆- USGA球场难度值）×113÷USGA球场坡度难度值 //保留一位小数

        System.out.println("球场node：" + gid);
        System.out.println("发球台：" + tee);
        System.out.println("总杆数：" + sums);
        System.out.println("球场难度系数：" + fieldid);
        System.out.println("球场难度系数：前区和后区的相加：" + difficulty);

        System.out.println("球场坡度系数：" + fieldid2);
        System.out.println("球场坡度系数：（前区+后区）÷ 2：" + gradient);
        System.out.println("球场坡度系数求整：" + new BigDecimal(gradient).setScale(0,BigDecimal.ROUND_HALF_UP));

        float bd = 0f;
        if(difficulty > 0 && gradient > 0)
        {
            bd = new BigDecimal(sums).subtract(new BigDecimal(difficulty)).multiply(new BigDecimal(113)).divide(new BigDecimal(gradient).setScale(1,BigDecimal.ROUND_HALF_UP),1,BigDecimal.ROUND_HALF_UP).floatValue();
        }

        //
        System.out.println("差点微分：" + bd);

        return bd;
    }

    //会员差点 -如果不更新，则 按上一次打印
    public static float getMemberAvgs(String member) throws SQLException
    {
        float f = -10000f;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select avgs from Score where member =" + db.cite(member) + " and shows=1 order by createtime desc  ",0,1);
            if(db.next())
            {
                f = db.getFloat(1);
            }
        } finally
        {
            db.close();
        }
        return f;
    }

    private static float getExponent(String sql,String member,boolean flag) throws SQLException // 得到差点指数
    {
        sql = sql.substring(4);
        ArrayList a1 = new ArrayList(),a2 = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT score,diff FROM Score WHERE " + sql + " AND compete=1 ORDER BY times DESC",0,20);
            while(db.next())
            {
                a1.add(new Arrayx(db.getInt(1),db.getFloat(2)));
            }
            int len = 20 - a1.size();
            if(len > 0)
            {
                db.executeQuery("SELECT score,diff FROM Score WHERE " + sql + " AND compete=0 ORDER BY times DESC",0,len);
                while(db.next())
                {
                    a2.add(new Arrayx(db.getInt(1),db.getFloat(2)));
                }
            }
        } finally
        {
            db.close();
        }
        //

        int len = a1.size() + a2.size();

        if(len >= 5)
        {
            int pick; // 用于计算差点指数的 最低的 pick 张
            if(len >= 20)
            {
                pick = 10;
            } else
            {
                switch(len)
                {
                case 19:
                    pick = 9;
                    break;
                case 18:
                    pick = 8;
                    break;
                case 17:
                    pick = 7;
                    break;
                case 16:
                case 15:
                    pick = 6;
                    break;
                case 14:
                case 13:
                    pick = 5;
                    break;
                case 12:
                case 11:
                    pick = 4;
                    break;
                case 10:
                case 9:
                    pick = 3;
                    break;
                case 8:
                case 7:
                    pick = 2;
                    break;
                default:
                    pick = 1;
                    break;
                }
            }
            StringBuilder sb = new StringBuilder();
            Arrayx[] ax = Arrayx.sort(a1); //由小到大排序
            float dc_sum = 0; // 差点微分累计
            for(int i = 0;i < ax.length && i < pick;i++)
            {
                dc_sum += ax[i].value;
                sb.append("," + ax[i].key);
            }
            //补al2
            len = pick - ax.length;
            if(len > 0)
            {
                ax = Arrayx.sort(a2);
                for(int i = 0;i < ax.length && i < len;i++)
                {
                    dc_sum += ax[i].value;
                    sb.append("," + ax[i].key);
                }
            }
            if(flag) //写缓存
            {
                db = new DbAdapter();
                try
                {
                    db.executeUpdate("UPDATE score SET calc=0 WHERE member=" + DbAdapter.cite(member));
                    db.executeUpdate("UPDATE score SET calc=1 WHERE score IN(" + sb.substring(1) + ")");
                } finally
                {
                    db.close();
                }
            }
            // 差点微分累计÷累计个数×0.96 (保留一位小数)
            System.out.println("差点微分累计:" + dc_sum);
            System.out.println("差点微分累计个数:" + pick);
            System.out.println("差点指数:" + new BigDecimal(dc_sum).divide(new BigDecimal(pick),4,4).multiply(new BigDecimal("0.96")).setScale(1,BigDecimal.ROUND_HALF_UP).floatValue());

            return new BigDecimal(dc_sum).divide(new BigDecimal(pick),4,4).multiply(new BigDecimal("0.96")).setScale(1,BigDecimal.ROUND_HALF_UP).floatValue();
        }
        return -10000f;
    }


    //鉴定更新差点方法
    public static float getIdentification(int score) throws SQLException
    {
        float f = -10000f;

        Score sobj = Score.find(score);
        //当前差点
        float lscd = Score.getMemberAvgs(sobj.member);

        //1、用当前差点 减去 第二低的打球计分卡的差点微分（只计算比赛成绩）
        float f2 = Score.getDiff_2(sobj.member,true);
        if(f2 != -10000) //说明有第二低差点微分
        {
            float f3 = new BigDecimal(lscd).subtract(new BigDecimal(f2)).floatValue();
            if(f3 >= 3)
            {
                //2、如果大于等于 3 用当前差点 减去第二张 打球积分卡的平均差点微分
                float f4 = (new BigDecimal(lscd).subtract(new BigDecimal(Score.getDiff_Average(sobj.member))).setScale(1,BigDecimal.ROUND_HALF_UP)).floatValue();
                //3、对照差点指数调整表 找出调整值
                if(Score.getDiff_Control(sobj.member,f4) != -10000)
                {
                    //4、当前差点 减去 对照表差点
                    f = (new BigDecimal(lscd).subtract(new BigDecimal(Score.getDiff_Control(sobj.member,f4))).setScale(1,BigDecimal.ROUND_HALF_UP)).floatValue();
                }
            }
        }
        //System.out.println("-----------差点指数 鉴定更新方法启动--------------------");
        //	System.out.println("鉴定更新后的差点指数为："+f);
        return f;
    }

    //比赛成绩第二低的
    public static float getDiff_2(String member,boolean bool) throws SQLException
    {
        float f = -10000f;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select diff from Score where member =" + db.cite(member) + " and compete=1 order by diff asc ");
            int c = 1;
            for(int i = 1;db.next();i++)
            {
                if(bool)
                {
                    if(i == 2)
                    {
                        f = db.getFloat(1);
                        break;
                    }
                } else
                {
                    c++;
                }
            }
            if(!bool)
            {
                f = c;
            }
        } finally
        {
            db.close();
        }
        return f;
    }

    //比赛成绩最低2张的 平均值
    public static float getDiff_Average(String member) throws SQLException
    {
        float f = -10000f;
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select diff from Score where member =" + db.cite(member) + " and compete=1 order by diff asc ");
            float ff1 = -10000f;
            float ff2 = -10000f;
            for(int i = 1;db.next();i++)
            {
                if(i == 1)
                {
                    ff1 = db.getFloat(1); //new BigDecimal(db.getFloat(1)).floatValue();

                } else if(i == 2)
                {
                    ff2 = db.getFloat(1); // new BigDecimal(db.getFloat(1)).floatValue();
                } else
                {
                    break;
                }
            }
            if(ff1 != -10000f && ff2 != -10000f)
            {
                f = (new BigDecimal(ff1).add(new BigDecimal(ff2)).divide(new BigDecimal(2),2,4)).floatValue();
            }
        } finally
        {
            db.close();
        }
        return f;
    }

    //更新成绩对照表
    public static float getDiff_Control(String member,float f4) throws SQLException
    {
        float f = -10000f;
        int int2 = (int) Score.getDiff_2(member,false); //比赛数量

        if(4.0f <= f4 && f4 <= 4.4f)
        {
            if(int2 == 2)
            {
                f = 1.0f;
            }
        } else if(4.5f <= f4 && f4 <= 4.9f)
        {
            if(int2 == 2)
            {
                f = 1.8f;
            } else if(int2 == 3)
            {
                f = 1.0f;
            }
        } else if(5.0f <= f4 && f4 <= 5.4f)
        {
            if(int2 == 2)
            {
                f = 2.6f;
            } else if(int2 == 3)
            {
                f = 1.9f;
            } else if(int2 == 4)
            {
                f = 1.0f;
            }

        } else if(5.5f <= f4 && f4 <= 5.9f)
        {
            if(int2 == 2)
            {
                f = 3.4f;
            } else if(int2 == 3)
            {
                f = 2.7f;
            } else if(int2 == 4)
            {
                f = 1.9f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 1.0f;
            }
        } else if(6.0f <= f4 && f4 <= 6.4f)
        {
            if(int2 == 2)
            {
                f = 4.1f;
            } else if(int2 == 3)
            {
                f = 3.5f;
            } else if(int2 == 4)
            {
                f = 2.8f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 1.9f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 1.0f;
            }
        } else if(6.5f <= f4 && f4 <= 6.9f)
        {
            if(int2 == 2)
            {
                f = 4.8f;
            } else if(int2 == 3)
            {
                f = 4.3f;
            } else if(int2 == 4)
            {
                f = 3.7f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 2.9f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 2.0f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 1.0f;
            }
        } else if(7.0f <= f4 && f4 <= 7.4f)
        {
            if(int2 == 2)
            {
                f = 5.5f;
            } else if(int2 == 3)
            {
                f = 5.0f;
            } else if(int2 == 4)
            {
                f = 4.5f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 3.8f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 3.0f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 2.1f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 1.0f;
            }
        } else if(7.5f <= f4 && f4 <= 7.9f)
        {
            if(int2 == 2)
            {
                f = 6.2f;
            } else if(int2 == 3)
            {
                f = 5.7f;
            } else if(int2 == 4)
            {
                f = 5.3f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 4.7f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 3.9f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 3.1f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 2.2f;
            } else if(int2 >= 40)
            {
                f = 1.0f;
            }
        } else if(8.0f <= f4 && f4 <= 8.4f)
        {
            if(int2 == 2)
            {
                f = 6.8f;
            } else if(int2 == 3)
            {
                f = 6.4f;
            } else if(int2 == 4)
            {
                f = 6.0f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 5.5f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 4.8f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 4.1f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 3.2f;
            } else if(int2 >= 40)
            {
                f = 2.2f;
            }
        } else if(8.5f <= f4 && f4 <= 8.9f)
        {
            if(int2 == 2)
            {
                f = 7.4f;
            } else if(int2 == 3)
            {
                f = 7.1f;
            } else if(int2 == 4)
            {
                f = 6.7f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 6.2f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 5.7f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 5.0f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 4.2f;
            } else if(int2 >= 40)
            {
                f = 3.3f;
            }
        } else if(9.0f <= f4 && f4 <= 9.4f)
        {
            if(int2 == 2)
            {
                f = 8.1f;
            } else if(int2 == 3)
            {
                f = 7.8f;
            } else if(int2 == 4)
            {
                f = 7.4f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 7.0f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 6.5f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 5.9f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 5.2f;
            } else if(int2 >= 40)
            {
                f = 4.4f;
            }
        } else if(9.5f <= f4 && f4 <= 9.9f)
        {
            if(int2 == 2)
            {
                f = 8.7f;
            } else if(int2 == 3)
            {
                f = 8.4f;
            } else if(int2 == 4)
            {
                f = 8.1f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 7.7f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 7.3f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 6.7f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 6.1f;
            } else if(int2 >= 40)
            {
                f = 5.4f;
            }
        } else if(10.0f <= f4 && f4 <= 10.4f)
        {
            if(int2 == 2)
            {
                f = 9.2f;
            } else if(int2 == 3)
            {
                f = 9.0f;
            } else if(int2 == 4)
            {
                f = 8.8f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 8.4f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 8.0f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 7.6f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 7.0f;
            } else if(int2 >= 40)
            {
                f = 6.4f;
            }
        } else if(10.5f <= f4 && f4 <= 10.9f)
        {
            if(int2 == 2)
            {
                f = 11.0f;
            } else if(int2 == 3)
            {
                f = 10.8f;
            } else if(int2 == 4)
            {
                f = 10.6f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 10.4f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 10.1f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 9.8f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 9.4f;
            } else if(int2 >= 40)
            {
                f = 8.9f;
            }
        } else if(11.0f <= f4 && f4 <= 11.4f)
        {
            if(int2 == 2)
            {
                f = 10.4f;
            } else if(int2 == 3)
            {
                f = 10.2f;
            } else if(int2 == 4)
            {
                f = 10.0f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 9.7f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 9.4f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 9.1f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 8.6f;
            } else if(int2 >= 40)
            {
                f = 8.1f;
            }
        } else if(11.5f <= f4 && f4 <= 11.9f)
        {
            if(int2 == 2)
            {
                f = 11.0f;
            } else if(int2 == 3)
            {
                f = 10.8f;
            } else if(int2 == 4)
            {
                f = 10.6f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 10.4f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 10.1f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 9.8f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 9.4f;
            } else if(int2 >= 40)
            {
                f = 8.9f;
            }
        } else if(12.0f <= f4 && f4 <= 12.4f)
        {
            if(int2 == 2)
            {
                f = 11.5f;
            } else if(int2 == 3)
            {
                f = 11.4f;
            } else if(int2 == 4)
            {
                f = 11.2f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 11.0f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 10.7f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 10.5f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 10.1f;
            } else if(int2 >= 40)
            {
                f = 9.7f;
            }
        } else if(12.5f <= f4 && f4 <= 12.9f)
        {
            if(int2 == 2)
            {
                f = 12.1f;
            } else if(int2 == 3)
            {
                f = 11.9f;
            } else if(int2 == 4)
            {
                f = 11.8f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 11.6f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 11.4f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 11.1f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 10.8f;
            } else if(int2 >= 40)
            {
                f = 10.5f;
            }
        } else if(13.0f <= f4 && f4 <= 13.4f)
        {
            if(int2 == 2)
            {
                f = 12.6f;
            } else if(int2 == 3)
            {
                f = 12.5f;
            } else if(int2 == 4)
            {
                f = 12.4f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 12.2f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 12.0f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 11.8f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 11.5f;
            } else if(int2 >= 40)
            {
                f = 11.2f;
            }
        } else if(13.5f <= f4 && f4 <= 13.9f)
        {
            if(int2 == 2)
            {
                f = 13.2f;
            } else if(int2 == 3)
            {
                f = 13.1f;
            } else if(int2 == 4)
            {
                f = 12.9f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 12.8f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 12.6f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 12.4f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 12.2f;
            } else if(int2 >= 40)
            {
                f = 11.9f;
            }
        } else if(14.0f <= f4 && f4 <= 14.4f)
        {
            if(int2 == 2)
            {
                f = 13.7f;
            } else if(int2 == 3)
            {
                f = 13.6f;
            } else if(int2 == 4)
            {
                f = 13.5f;
            } else if(int2 >= 5 && int2 <= 9)
            {
                f = 13.4f;
            } else if(int2 >= 10 && int2 <= 19)
            {
                f = 13.2f;
            } else if(int2 >= 20 && int2 <= 29)
            {
                f = 13.0f;
            } else if(int2 >= 30 && int2 <= 39)
            {
                f = 12.8f;
            } else if(int2 >= 40)
            {
                f = 12.6f;
            }
        }

        return f;
    }

    //临时差点指数
    public float getIndex()
    {
        return new BigDecimal(diff).multiply(new BigDecimal(0.96)).setScale(1,BigDecimal.ROUND_DOWN).floatValue();
    }

    public static float getMonth(String member,Date date) throws SQLException
    {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.MONDAY,1);
        c.set(Calendar.DAY_OF_MONTH,1);
        date = c.getTime();
        return getExponent(" AND member=" + DbAdapter.cite(member) + " AND times<" + DbAdapter.cite(date),member,false);
    }

//    public static Enumeration findByMember(String member,String community) throws SQLException,SQLException
//    {
//        tea.db.DbAdapter db = new tea.db.DbAdapter();
//        int nodecode = 0;
//        try
//        {
//            nodecode = db.getInt("SELECT node FROM Node WHERE Node.type=64 AND Node.community=" + DbAdapter.cite(community) + " AND rcreator=" + DbAdapter.cite(member) + " AND vcreator=" + DbAdapter.cite(member));
//        } finally
//        {
//            db.close();
//        }
//        return findByNode(nodecode,0);
//    }

    public static void delete(int score) throws SQLException
    {
        DbAdapter.execute("DELETE FROM Score WHERE score=" + score);
        _cache.remove(score);
    }

    public int getScore()
    {
        return score;
    }

    public int getNode()
    {
        return node;
    }

    public String getName()
    {
        return name;
    }

    public int getTee()
    {
        return tee;
    }

    public boolean isCompete()
    {
        return compete;
    }

    public int getSums()
    {
        return sums;
    }

    public int getCavity()
    {
        return cavity;
    }

    public int[] getStandard()
    {
        return standard;
    }

    public int[] getFact()
    {
        return fact;
    }

    public Date getTimes()
    {
        return times;
    }

    public String getFieldid()
    {
        return fieldid;
    }

    public String getFieldid2()
    {
        return fieldid2;
    }

    public float getAvgs()
    {
        return avgs;
    }

    public int getShows()
    {
        return shows;
    }

    public String getTimes(String pattern)
    {
        if(times == null)
        {
            return "";
        }
        return new java.text.SimpleDateFormat(pattern).format(times);
    }

    public String getTimesToString()
    {
        return times == null ? "--" : Entity.sdf2.format(times);
    }


    public static String getMaxTimesByNode(int node) throws SQLException
    {
        Date maxTime = null;
        tea.db.DbAdapter db = new tea.db.DbAdapter();
        try
        {
            // maxTime = db.getDate("SELECT MAX(times) FROM Score WHERE node=" +node);
            db.executeQuery("SELECT MAX(times) FROM Score WHERE node=" + node);
            if(db.next())
            {
                maxTime = db.getDate(1);
            }
        } catch(SQLException ex)
        {
        } finally
        {
            db.close();
        }
        if(maxTime == null)
        {
            return "";
        }
        return new java.text.SimpleDateFormat("yyyy-MM-dd").format(maxTime);
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getText()
    {
        return text;
    }

    public int[] getUp()
    {
        return up;
    }

    public int[] getBunt()
    {
        return bunt;
    }

    //平均推杆数
    public float getBuntC()
    {
        if(!exists)
        {
            return 0;
        }
        return new BigDecimal(Arrayx.sum(bunt,0,cavity)).divide(new BigDecimal(cavity),2,4).floatValue();
    }

    //首杆上球道率
    public float getFairwayC()
    {
        if(!exists)
        {
            return 0;
        }
        int sum = 0;
        for(int i = 0;i < cavity;i++)
        {
            if(fairway[i])
            {
                sum++;
            }
        }
        return new BigDecimal(sum * 100).divide(new BigDecimal(cavity),0,BigDecimal.ROUND_HALF_UP).floatValue();
    }

    /*
      在计算PAR ON果岭率的同时，增加下述几个计算值：
     1.P3平均on果岭数：标准杆为3杆的平均on果岭数，也就是标准杆为3杆的总on果岭数/标准杆为3杆的总洞数。以下类推。
     2.P4平均on果岭数：标准杆为4杆的平均on果岭数
     3.P5平均on果岭数：标准杆为5杆的平均on果岭数
     4.par on 果岭率：
     首先，
     PAR 3 洞：你打得杆数 － 推杆数 ＝ 1 或小于1，则为PAR ON
     PAR 4 洞：你打得杆数 － 推杆数 ＝ 2或小于2，则为PAR ON
     PAR 5 洞：你打得杆数 － 推杆数 ＝ 3或小于3，则为PAR ON
     而后，18洞中，PAR ON的次数/18即为par on 果岭率。
     该方法看似跟您上午的描述不同，但实质一样。
     */
    private void caclC()
    {
        if(parc == -1 && exists)
        {
            try
            {
                // Golf g = Golf.find(node,1);
                GolfSite gobj1 = GolfSite.find(GolfSite.getGSid(node,fieldid));
                GolfSite gobj2 = GolfSite.find(GolfSite.getGSid(node,fieldid2));
                int s3 = 0,p3 = 0,s4 = 0,p4 = 0,s5 = 0,p5 = 0;
                for(int i = 0;i < cavity;i++)
                {

                    //标准杆
                    int standard = 0;
                    if(i < 9)
                    {
                        standard = gobj1.getStandard(i + 1);
                    } else
                    {
                        standard = gobj2.getStandard(i - 8);

                    }

                    switch(standard)
                    {
                    case 3:
                        if(up[i] < 2)
                        {
                            paron++;
                        }
                        p3 += up[i];
                        s3++;
                        break;
                    case 4:
                        if(up[i] < 3)
                        {
                            paron++;
                        }
                        p4 += up[i];
                        s4++;
                        break;
                    case 5:
                        if(up[i] < 4)
                        {
                            paron++;
                        }
                        p5 += up[i];
                        s5++;
                        break;
                    }
                    int v = standard - fact[i]; //标准-实际

                    if(v > 1)
                    {
                        eagle++;
                    } else if(v == 1) //柏忌
                    {
                        birdie++;
                    } else if(v == 0)
                    {
                        par++;
                    } else if(v == -1)
                    {
                        bogey++;
                    } else if(v == -2) //双柏忌
                    {
                        duble++;

                    }
                }
                if(s3 > 0)
                {
                    par3c = new BigDecimal(p3).divide(new BigDecimal(s3),0,BigDecimal.ROUND_HALF_UP).floatValue();
                }
                if(s4 > 0)
                {
                    par4c = new BigDecimal(p4).divide(new BigDecimal(s4),0,BigDecimal.ROUND_HALF_UP).floatValue();
                }
                if(s5 > 0)
                {
                    par5c = new BigDecimal(p5).divide(new BigDecimal(s5),0,BigDecimal.ROUND_HALF_UP).floatValue();
                }
                parc = new BigDecimal(paron * 100).divide(new BigDecimal(cavity),0,BigDecimal.ROUND_HALF_UP).floatValue();
            } catch(Exception e)
            {
                // TODO: handle exception
            }
        }

    }


    public Date getCreateTime()
    {
        return createTime;
    }

    public Date getAlterTime()
    {
        return alterTime;
    }

    public int getParON()
    {
        caclC();
        return paron;
    }

    public int getEagle()
    {
        caclC();
        return eagle;
    }

    public int getBirdie()
    {
        caclC();
        return birdie;
    }

    public int getPar()
    {
        caclC();
        return par;
    }

    public int getBogey()
    {
        caclC();
        return bogey;
    }

    public int getDuble()
    {
        caclC();

        return duble;
    }

    public float getPar3C()
    {
        caclC();
        return par3c;
    }

    public float getPar4C()
    {
        caclC();
        return par4c;
    }

    public float getPar5C()
    {
        caclC();
        return par5c;
    }

    public float getParC()
    {
        caclC();
        return parc;
    }

    public static String getDetail(Node node,Http h,int iListing,String target) throws SQLException
    {
        StringBuilder sb = new StringBuilder();
        ListingDetail detail = ListingDetail.find(iListing,64,h.language);
        Iterator e = detail.keys();
        while(e.hasNext())
        {
            String itemname = (String) e.next(),name = null;
            int istype = detail.getIstype(itemname);
            if(istype == 0)
            {
                continue;
            }
            if("info".equals(itemname)) // 个人资料
            {
                name = ("<include src=\"/jsp/type/score/ScoreInfo.jsp?node=" + node._nNode + "\"/>");
            } else if(itemname.equals("history")) // 历史6个月的差点指数
            {
                name = ("<include src=\"/jsp/type/score/ScoreHistory.jsp?node=" + node._nNode + "\"/>");
            } else if(itemname.equals("grade")) // 查看最近的20次成绩列表。
            {
                name = ("<include src=\"/jsp/type/score/ScoreList.jsp?node=" + node._nNode + "\"/>");
            } else if(itemname.equals("manage")) // 成绩管理
            {
                name = ("<include src=\"/jsp/type/score/ScoreManage.jsp?node=" + node._nNode + "\"/>");
            } else if(itemname.equals("query")) // 查看会友成绩
            {
                name = ("<include src=\"/jsp/type/score/ScoreQuery.jsp?node=" + node._nNode + "\"/>");
            }
            Span span = null;
            if(detail.getAnchor(itemname) != 0)
            {
                Anchor anchor = new Anchor("/" + (h.status == 1 ? "xhtml" : "html") + "/" + h.community + "/score/" + node._nNode + "-" + h.language + ".htm",name);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(name);
            }
            span.setId("ScoreID" + itemname);
            sb.append(detail.getBeforeItem(itemname)).append(span).append(detail.getAfterItem(itemname));
        }
        return sb.toString();
    }


    public static BufferedImage bi1 = Filex.read(new byte[]
                                                 { -119,80,78,71,13,10,26,10,0,0,0,13,73,72,68,82,0,0,2, -28,0,0,1,24,8,2,0,0,0, -101,126,116, -51,0,0,8,67,73,68,65,84,120, -38, -19, -35, -37,118, -37,40,0,64,81, -5, -1, -65,57, -95,109, -44, -86,50,32, -124,46,8, -100, -20, -3,48, -53,118,28, -22,72,15,115, -106, -64, -24,17,0,0,6, -10,112,8,0,0, -79,2,0,32,86,0,0, -79,2,0,32,86,0,0, -60,10,0,32,86,0,0, -60,10,0,32,86,0,0, -60,10,0, -128,88,1,0, -60,10,0, -128,88,1,0, -60,10,0, -128,88,1,0, -24,24,43, -113,47,14,49,0,32,86,0,0, -79,34,86,0,0, -79,2,0,32,86,0,0, -79,34,86,0,0, -79,2,0, -120,21, -79,2,0, -120,21,0,0, -79,2,0, -120,21, -79,2,0, -120,21,0,64, -84, -120,21,0,64, -84,0,0, -120,21,0,64, -84, -120,21,0,64, -84,0,0,98,69, -84,0,0,98,5,0,64, -84,0,0,98,69, -84,0,0,98,5,0,64, -84,0,
                                                 0,
                                                 98,5,0,64, -84,0,0,98,69, -84,0,0,98,5,0,64, -84,0,0,98,69, -84,0,0,98,5,0,16,43, -53, -14, -120,42,100, -77,69, -60,10,0,112,83, -84,44, -77,35, -22, -113,66, -114, -120,21,0, -32, -114,88, -103, -126,67, -84,0,0,35, -58,74, -38,40,98,5,0, -8,86, -79, -78, -55,57,0,0,14, -58,74, -76, -88, -10,88, -84,56, -60,0,64
                                                 , -109,88,89, -117,18, -79,2,0, -116,18,43, -39,41,27, -79,2,0,12,17,43,105,121,100, -21,68, -84,0,0,99, -59,74, -80,41,28,0,48,96, -84,28,25,90, -84,0,0,98,5,0,16,43,98,5,0,16,43,0,0,98,5,0,16,43,98,5,0,16,43,0, -128,88,17,43,0, -128,88,1,0,56,23,43, -39, -51,106, -45,27,6, -119,21,0, -96,67, -84,84, -34,120,89, -84,0,0,3, -59,74,125,127, -120,21,0, -96,109, -84,100, -37, -91,114,14,72, -84,0,0,55, -59,74, -44,37,107,115,67,98,5,0, -24,19,43, -27,46, -39, -116, -107,77, -50,1,0, -48,51,86,28,98,0, -96,85, -84, -44,44, -80,21,43,0, -64, -72, -79,98, -127,45,0, -48,51,86,66, -59, -90,112,98,5,0, -24,25,43, -89, -122,22,43,0, -128,88,1,0, -60, -118,88,1,0, -60,10,0, -128,88,1,0, -60, -118,88,1,0, -60,10,0,32,86, -60,10,0,32,86,0,0, -60,10,0,
                                                 32,
                                                 86, -60,10,0, -48,39,86, -36,27,8,0,24,55,86,54, -17, -70,28, -118,55,94,22,43,0, -128,88,1,0,126,112, -84,100, -37,69, -84,0,0,99, -59,74, -76,60,101,111, -84,108,114,14,0, -128,83, -79,18,117, -119,43,43,0, -128,88,1,0, -88, -120,21,11,108,1,0, -79,2,0,112,52,86, -126,77, -31,0, -128, -63,99, -27, -44, -48,98,5,0,16,43,0, -128,88,17,43,0, -128,88,1,0,16,43,0
                                                 , -128,88,17,43,0, -128,88,1,0, -60, -118,88,1,0, -60,10,0, -64, -71,88, -39, -36, -63, -42,118, -5,0,64, -73,88,89, -69,13,80,101, -126, -120,21,0, -96,67, -84, -44, -9, -121,88,1,0, -38, -58,74, -74,93,42, -25, -128, -60,10,0, -48,45,86, -46,23, -59,10,0, -48,57,86, -42, -78,99,51,86,54,57,7,0, -64, -39,88,41,23,73,57,86,28,98,0, -96,109, -84, -108, -25,125, -60,10,0, -48,51,86, -46, -38, -120,54,92,41, -1, -82,88,1,0,26, -58, -54, -38, -6,18, -33,6,2,0, -122, -120, -107, -77,67, -117,21,0,64, -84,0,0,98,69, -84,0,0,98,5,0,64, -84,0,0,98,69, -84,0,0,98,5,0,16,43,98,5,0,16,43,0,0,98,5,0,16,43,98,5,0, -24,19,43, -39, -37,0, -71,55,16,0,48,68, -84,68, -87,49,61, -51, -66,40,86,0,0, -79,2,0, -120, -107, -14,91, -59,10,0, -16, -3,98,101, -109,
                                                 115,
                                                 0,0,92,16,43,115,85, -72, -78,2,0,12,23,43, -47,87, -127, -60,10,0,48,80, -84, -108, -21,68, -84,0,0,61,99,37, -83,13, -79,2,0, -116,18,43,107, -117,97,109,10,7,0,12,17,43,103, -121,22,43,0, -128,88,1,0, -60, -118,88,1,0, -60,10,0, -128,88,1,0, -60, -118,88,1,0, -60,10,0,32,86, -60,10,0,32,86,0,0, -82, -120, -107,116, -117, -3, -102,77,108, -59,10,0,112,71, -84, -92, -51,81, -103
                                                 ,32,98,5,0,104,30,43,83,109,44, -101, -93, -66,63, -60,10,0, -48,60,86, -46,64, -87, -100,3,18,43,0,64, -73,88,89, -5, -111,88,1,0, -6, -57, -54, -82,31, -43,112,14,0, -128, -98, -79, -30,16,3,0, -73, -58, -118,105,32,0, -32,109,98, -59,2,91,0,96, -72,88,9, -81, -117,81, -60,10,0, -48,63,86,14,14,45,86,0,0, -79,2,0, -120,21, -79,2,0, -120,21,0,0, -79,2,0, -120,21, -79,2,0, -120,21,0,64, -84, -120,21,0,64, -84,0,0, -120,21,0,64, -84, -120,21,0, -96,103, -84, -72,55,16,0,48,110, -84,68, -51, -111, -122, -117,88,1,0, -70, -59, -54,84,27,98,5,0,24,52,86, -46,34,17,43,0, -64, -73, -118, -107,77, -50,1,0, -48,51,86,28,98,0,64, -84,0,0,98,69, -84,0,0,98,5,0, -32,108, -84,4, -101, -62,1,0, -93, -59, -54, -63, -95, -59,10,0,32,86,0,0, -79,34,86,0,0,
                                                 -79,2,0,32,86,0,0, -79,34,86,0,0, -79,2,0, -120,21, -79,2,0, -120,21,0, -128,115, -79, -14,120,37,86,0, -128, -31,98, -27, -8, -48,98,5,0,104,26,43,39,83,67, -84,0,0, -51,99, -27, -16,28, -112,88,1,0, -18, -120, -107, -62,83, -79,2,0,116, -114, -107,114, -69,84, -58, -54,38, -25,0,0, -24,25,43,14,49,0, -48,42,86,76,3,1,0,111,19,43,22, -40,2,0, -61, -59,74,120,93,119,34,86,0, -128
                                                 , -31,98, -27, -44, -48,98,5,0,16,43,0, -128,88,17,43,0, -128,88,1,0,16,43,0, -128,88,17,43,0, -128,88,1,0, -60, -118,88,1,0, -60,10,0, -64, -71,88, -79, -125,45,0,48,110, -84, -72, -111,33,0,32,86,0,0, -60,10,0,32,86, -60,10,0, -16, -106, -79, -78, -55,57,0,0, -60,10,0,32,86, -60,10,0, -16, -114, -79, -30,16,3,0, -83,98,37, -40,20,14,0,24,60,86,78,13,45,86,0,0, -79,2,0, -120,21, -79,2,0, -120,21,0,0, -79,2,0, -120,21, -79,2,0, -120,21,0,64, -84, -120,21,0,64, -84,0,0,92,23,43,123, -17, -23,35,86,0, -128, -69,99,101, -33, -48,98,5,0, -72,45,86, -36,27,8,0,24,61,86, -10, -34, -44,80, -84,0,0, -73, -58,74, -31, -87,88,1,0,58, -57,74, -71,93, -60,10,0,112,119, -84, -108,39,125, -60,10,0, -48,57,86, -54,117,82,31,43, -101, -100,3,0, -32, -30,88,
                                                 -79, -64,22,0,24,46,86, -62, -42, -60, -112,88,1,0,58, -57, -54, -18, -95, -59,10,0,32,86,0,0, -79,34,86,0,0, -79,2,0,32,86,0,0, -79,34,86,0,0, -79,2,0, -120,21, -79,2,0, -120,21,0, -128, -85,99,37, -67,73, -48, -38, -74, -74,98,5,0, -72,59,86, -94, -2,40, -33, -35,80, -84,0,0, -73, -58, -54,84,30,98,5,0,24,52,86, -46,34,17,43,0, -128,88,1,0, -60, -118,88,1,0, -122, -12, -7, -7, -7,40
                                                 ,68,73, -10,107,62,98,5,0, -72, -83,84, -126,43,43,0, -64, -32, -102, -57,10,0,68, -98, -49, -25, -12, -33, -23, -127, -49, -7,67,62, -25, -127,63, -22,113, -20, -54, -57, -34,77, -31,0,96, -29,127,69,62, -25, -113, -7, -100,7, -2, -94,63,15,92,92,2, -96, -35,106, -125,99,63,29, -25,115, -66, -53, -15,60, -1, -121,92,123,28, -94, -47, -90, -89, -53,23, -41,30,95,51,13,4,0, -4, -76, -60, -52, -66,94, -114, -113,93,67, -119,21,0, -32,96, -75,44, -37, -94,48,107,19, -25,69,110, -123,107,57,104,10,17,35,86,0, -128, -105,76,73,75, -27, -17,87, -120,87, -106, -70,62, -97, -49,40,53,126, -65,115,126, -27, -15, -17,118,61, -53, -123,53, -107,121,36,86,0, -128, -1,125, -112, -87, -124, -81, -86, -8, -8, -8,72, -93,36, -70, -30,18, -3, -42, -14,59,74,
                                                 -13, -45,40,95, -94,6,42,76,30, -119,21,0,32, -77,36,118, -39,16, -45, -125, -33, -63, -111, -3, -83, -20,52, -48,28,31, -113, -41,27,33,79, -29, -92,87,98,10, -97,77, -84,0,0, -7,4,41,36, -59,114, -74,40, -5, -50, -27,101, -107, -16,117,85,38, -69, -58, -91, -26, -30, -118,88,1,0,66,40, -50, -20,44,19, -92, -68, -64,54, -115, -113, -24, -54,74,97, -16, -75,15,38,86,0, -128, -86,116, -40,53,13,20, -91, -52,114, -22
                                                 ,39,29,71, -84,0,0,27, -78,51,62, -107,43,75, -42,38, -116, -94,43,43, -27,111,3, -91, -125, -120,21,0,96,85,54,29, -46, -123, -79,97, -79, -124,118, -7, -74, -52, -106, -7, -117,124,73, -57, -55, -82, -34,21,43,0,64, -100,29,107, -3,49,23,76,125, -39, -52,43,112, -41,86, -79, -124, -83,85, -70,98,5,0,88,21,117,73,118,109, -54, -100,26, -53, -19,88, -90,23, -25,119,46,31, -108, -69,36,59, -15,36,86,0, -128,16, -42, -73, -125,91, -2,116,74, -112, -75, -37,59,23,126,125,94, -77,18, -59,77, -88, -8, -2, -111,88,1,0,50, -67, -110,78, -36, -52,61,81, -71, -125,109, -12,116,94, -92,50,47,94,41, -60, -115,88,1,0, -14, -91,18, -11, -54, -26,46, -8,103, -58,23,43,0, -64,5, -78, -13,53, -19, -2,21, -79,2,0, -20,54, -33, -59, -80, -75, -46,117,23, -89,
                                                 1,
                                                 0, -72, -92,42,78,14, -24, -85, -53,0, -64, -87, -116,104,58,25, -28, -54,10,0, -48, -68,42,26, -115,47,86,0, -128, -38, -128,104,81,42, -53, -53,54,54, -123,3,0, -82, -87, -118,59, -119,21,0, -96, -74,81,26, -107,74,121,112, -79,2,0,12,77, -84,0,0,98,5,0,64, -84,0,0, -33, -46,47,16, -70,13, -26, -112, -85, -34,31,0,0,0,0,73,69,78,68, -82,66,96, -126,}),bi2 = Filex.read(new byte[]
            { -119,80,78,71,13,10,26,10,0,0,0,13,73,72,68,82,0,0,0,12,0,0,0,10,8,3,0,0,0, -73, -14,79, -56,0,0,3,0,80,76,84,69, -1, -1, -1, -2, -1, -6, -1, -7, -7, -6, -22, -21, -4, -23, -21, -4, -25, -26, -6, -32, -33, -8, -39, -34, -11, -57, -54, -9, -62, -56, -12, -85, -76, -14, -85, -77, -11, -86, -81, -14, -86, -82, -15, -94, -89, -18, -119, -111, -19, -120, -114, -19, -124, -117, -17,125, -121, -17,123, -120, -19,103,114, -21,98,106, -27,63,75, -28,47,64, -28,43,57, -31,39,53, -31,28,46, -34,25,42, -32,24,37,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
            0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, -15, -117, -77,84,0,0,0,1,116,82,78,83,0,64, -26, -40,102,0,0,0,89,73,68,65,84,120, -38,53, -115,75,14, -128,32,16,67, -25,23, -64,65,19, -29, -3, -113, -55,2,3,3,2, -63, -73, -22, -21, -94,
            -27, -121,107, -121,13, -45, -83,82, -37,22,83,118, -47, -73, -70, -92, -117,7,20,61, -72,116,96,48,5,28, -91, -113, -50,8, -38, -52,19,68, -127,115, -27, -110,83,3, -95,48, -28,77,121, -18,75,16, -53, -87, -20, -93, -25,34, -4,79,63, -127, -42,25, -105,77,126, -8, -109,0,0,0,0,73,69,78,68, -82,66,96, -126,});

    public static String draw(String member,Date start,Date end,OutputStream out) throws SQLException,IOException
    {
        StringBuffer map = new StringBuffer();
        ArrayList al = Score.find(" AND member=" + DbAdapter.cite(member) + " AND times>" + DbAdapter.cite(start) + " AND times<" + DbAdapter.cite(MT.add(end,1)) + " ORDER BY times",0,1000);
        //al = test();
        Color green = new Color(0x0D,0x5A,0x24);
        //
        BufferedImage bi = new BufferedImage(740,280,BufferedImage.TYPE_INT_RGB);
        Graphics2D g = bi.createGraphics();
        g.drawImage(bi1,null,0,0);
        if(al.size() < 1)
        {
            g.setColor(Color.RED);
            g.drawString("无任何相关记录！",200,120);
        } else
        {
            int day = MT.day(end,start);
            float px = 650F / day;
            float py = 3.975F;
            int px0 = 210; //Y轴的0
            int px2 = day / 14;
            //平均线
            float avg = 0;
//            for(int i = 0;i < al.size();i++)
//            {
//                avg += ((Score) al.get(i)).diff;
//            }
//            avg = new BigDecimal(avg).divide(new BigDecimal(al.size()),1,4).floatValue();
            avg = Score.getIndex(member);
            int pxavg = px0 - (int) (avg * py);
            g.drawImage(bi2,null,680,pxavg - 5);
            g.setColor(Color.RED);
            g.drawLine(32,pxavg,680,pxavg);
            //
            Calendar c = Calendar.getInstance();
            c.setTime(start);
            SimpleDateFormat df1 = new SimpleDateFormat("MM"),df2 = new SimpleDateFormat("dd");
            for(int i = 0,j = 0,x1 = 0,y1 = 0;i < day;i++,c.add(Calendar.DAY_OF_MONTH,1))
            {
                int x = 32 + new BigDecimal(i).multiply(new BigDecimal(px)).setScale(0,BigDecimal.ROUND_HALF_UP).intValue();
                int d = c.get(Calendar.DAY_OF_MONTH);
                //
                if(j < al.size())
                {
                    Score s = (Score) al.get(j);
                    if(s.times.compareTo(c.getTime()) != 1)
                    {
                        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,RenderingHints.VALUE_ANTIALIAS_ON);
                        int x2 = x,y2 = px0 - (int) (s.getIndex() * py) - 1;
                        g.setColor(Color.BLACK);
                        if(j > 0)
                        {
                            g.drawLine(x1,y1,x2,y2);
                        }
                        map.append("<area shape='rect' coords='" + (x2 - 5) + ",0," + (x2 + 5) + ",250' onfocus='blur()' onmouseover=\"f_time('" + s.getTimesToString() + "')\" onmouseout='f_time()' />");
                        g.fillOval(x2 - 1,y2 - 1,3,3); //黑点
                        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,RenderingHints.VALUE_ANTIALIAS_DEFAULT);
                        g.setColor(green);
                        g.drawString(String.valueOf(s.diff),x2 - 5,y2 - 5);
                        x1 = x2;
                        y1 = y2;
                        j++;
                    }
                }
                //X轴日期
                if(d == 1 || (d % px2 == 0 && d + px2 < 32))
                {
                    g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,RenderingHints.VALUE_ANTIALIAS_DEFAULT);
                    g.setColor(Color.BLACK);
                    if(i > 0)
                    {
                        g.drawLine(x,d == 1 ? 235 : 240,x,250);
                    }
                    g.drawString(d == 1 ? c.get(Calendar.MONTH) + 1 + "月" : df2.format(c.getTime()),x - 6,268);
                }
            }
            g.setColor(Color.GRAY);
            g.drawString(Entity.sdf.format(start) + " — " + Entity.sdf.format(end),520,20);
        }
        g.dispose();
        try
        {
            ImageIO.write(bi,"png",out);
        } catch(IIOException ex)
        {} finally
        {
            out.close();
        }
        return map.toString();
    }

    //球场差点
    public static int getQccd(String member,int node,String fieldid,String fieldid2,int tee) throws SQLException
    {
        float cd = 0;
        try
        {
            float zs = Score.getMemberAvgs(member); //Score.getIndex(member);

            GolfSite gobj1 = GolfSite.find(GolfSite.getGSid(node,fieldid));
            GolfSite gobj2 = GolfSite.find(GolfSite.getGSid(node,fieldid2));
            //   float  difficulty =gobj1.difficultys[tee]+gobj2.difficultys[tee];// g.difficultys[tee];//球场难度系数= 前区和后区的相加
            float gradient = (new BigDecimal(gobj1.gradients[tee]).add(new BigDecimal(gobj2.gradients[tee]))).divide(new BigDecimal("2")).floatValue();

            System.out.println("坡度值：" + GolfSite.getGSid(node,fieldid) + "球场node号：" + node + "场地：" + fieldid);
            System.out.println("坡度值：" + GolfSite.getGSid(node,fieldid2) + "球场node号：" + node + "场地：" + fieldid2);
            System.out.println("gobj1.gradients[tee]发球台：" + gobj1.gradients[tee] + "::tee:" + tee);
            System.out.println("gobj2.gradients[tee]发球台：" + gobj2.gradients[tee]);
            //  .setScale(1,BigDecimal.ROUND_DOWN)

            // 差点微分累计÷累计个数×0.96 (保留一位小数)
            //   return new BigDecimal(dc_sum).divide(new BigDecimal(pick),4,4).multiply(new BigDecimal("0.96")).setScale(1,BigDecimal.ROUND_DOWN).floatValue();

            //球场差点（取整数）= 差点指数*发球台坡度难度值  除以 113

            cd = new BigDecimal(zs).multiply(new BigDecimal(gradient)).divide(new BigDecimal("113"),1,BigDecimal.ROUND_HALF_UP).setScale(0,BigDecimal.ROUND_HALF_UP).floatValue();

            System.out.println("差点指数：" + zs);
            System.out.println("发球台坡度难度值：" + gradient);
            System.out.println("没有四舍五入的差点：" + new BigDecimal(zs).multiply(new BigDecimal(gradient)).divide(new BigDecimal("113"),1,BigDecimal.ROUND_HALF_UP));
            System.out.println("差点：" + (int) cd);

        } catch(SQLException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return(int) cd;
    }

    public static ArrayList test()
    {
        ArrayList al = new ArrayList();
        try
        {
            Score s = new Score();
            s.times = tea.entity.Entity.sdf.parse("2010-01-01");
            s.diff = 15f;
            al.add(s);
            s = new Score();
            s.times = tea.entity.Entity.sdf.parse("2010-02-02");
            s.diff = 30f;
            al.add(s);
            s = new Score();
            s.times = tea.entity.Entity.sdf.parse("2010-03-3");
            s.diff = 20f;
            al.add(s);
            s = new Score();
            s.times = tea.entity.Entity.sdf.parse("2010-04-4");
            s.diff = 25f;
            al.add(s);
            s = new Score();
            s.times = tea.entity.Entity.sdf.parse("2010-05-5");
            s.diff = 10f;
            al.add(s);
            s = new Score();
            s.times = tea.entity.Entity.sdf.parse("2010-06-6");
            s.diff = 20f;
            al.add(s);
            s = new Score();
            s.times = tea.entity.Entity.sdf.parse("2010-07-7");
            s.diff = 20f;
            al.add(s);
            s = new Score();
            s.times = tea.entity.Entity.sdf.parse("2010-08-8");
            s.diff = 23f;
            al.add(s);
            s = new Score();
            s.times = tea.entity.Entity.sdf.parse("2010-09-9");
            s.diff = 8f;
            al.add(s);
            s = new Score();
            s.times = tea.entity.Entity.sdf.parse("2010-10-10");
            s.diff = 13f;
            al.add(s);
            s = new Score();
            s.times = tea.entity.Entity.sdf.parse("2010-11-30");
            s.diff = 0f;
            al.add(s);
        } catch(ParseException ex)
        {}
        return al;
    }

    //成绩录入
    public static String imp(String str) throws Exception
    {

        HashMap ht = MT.xml(str);
        //
        String inMode = (String) ht.get("inMode");
        String creditcard = (String) ht.get("number");
        String member = (String) ht.get("vipid");

        Enumeration e = Profile.find(" AND member=" + DbAdapter.cite(member),0,1);
        if(!e.hasMoreElements())
        {
            return "false您录入的会员不存在....";
        }
        member = (String) e.nextElement();

        String caddy = (String) ht.get("caddyid"); //球童编号4位

        String posid = (String) ht.get("posid"); //+ "-" + fieldid+"-"+fieldid2; //设备编号，可用来区分球场用
        String fieldid = MT.f((String) ht.get("fieldid")); //前九场
        String fieldid2 = MT.f((String) ht.get("fieldid2")); //后九场

        //return "false没找到差点数据!";
        //发球台
        String te = (String) ht.get("tee");
        if("金".equals(te))
        {
            te = "黄";
        }
        String[] TEE =
                {"黑","黄","蓝","白","红"};
        int tee = Arrayx.indexOf(TEE,te);

        Enumeration ne = Node.find(" AND n.type=62 AND EXISTS(SELECT node FROM Golf g WHERE g.node=n.node AND posid=" + DbAdapter.cite(posid) + ")",0,1);
        int node = ne.hasMoreElements() ? (Integer) ne.nextElement() : 0;

        if(node == 0) //没有这个球场
        {
            return "false系统找不到录入的球场信息，请设置后录入成绩";
        }
        GolfSite gobj1 = GolfSite.find(GolfSite.getGSid(node,fieldid));
        GolfSite gobj2 = GolfSite.find(GolfSite.getGSid(node,fieldid2));

        if(GolfSite.getGSid(node,fieldid) == 0)
        {
            return "false前九洞的场地编号不存在，不能录入成绩";
        }
        if(GolfSite.getGSid(node,fieldid2) == 0)
        {
            return "false后九洞的场地编号不存在，不能录入成绩";
        }

        if(gobj1.difficultys[tee] <= 0 || gobj1.difficultys[tee] <= 0)
        {
            return "false发球台数据错误，不能录入成绩";
        }
        if(gobj2.gradients[tee] <= 0 || gobj2.gradients[tee] <= 0)
        {
            return "false发球台数据错误，不能录入成绩";
        }

        boolean compete = false;
        if("1".equals((String) ht.get("event")) || "2".equals((String) ht.get("event")))
        {
            compete = true;
        }
        //"Y".equals((String) ht.get("event")); //是否为赛事成绩

        String eventid = (String) ht.get("eventid"); //赛事ID 预留

        Date times = new SimpleDateFormat("yyyyMMddHHmmss").parse((String) ht.get("datetime")); //成绩录入
        //
        int sums = 0;

        boolean[] fairway = new boolean[18]; //第一杆上球道否
        boolean[] hfinish = new boolean[18]; ////本杆是否完成
        int[] fact = new int[18],up = new int[18],bunt = new int[18];
        for(int i = 0;i < 18;i++)
        {
            fairway[i] = "Y".equals((String) ht.get("h" + (i + 1) + "way")); //第一杆是否上球道？Y、N
            //本杆是否完成
            hfinish[i] = "Y".equals((String) ht.get("H" + (i + 1) + "Finish"));

            up[i] = Integer.parseInt((String) ht.get("h" + (i + 1) + "on")); //球洞1 on果岭数
            bunt[i] = Integer.parseInt((String) ht.get("h" + (i + 1) + "push")); //球洞1 推杆数
            fact[i] = up[i] + bunt[i];
            sums += fact[i];
        }
        // Enumeration e2 = Profile.find(" AND creditcard=" + DbAdapter.cite(creditcard),0,1);
        // member = e2.hasMoreElements() ? (String) e2.nextElement() : null;


        String name = node > 0 ? Node.find(node).getSubject(1) : "";
        //判断在两个小时内要修改记录 之外要 打印记录
        int editTime = 0;
        int m = 120;
        SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss:SS");
        Date mydate = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(mydate);
        cal.add(Calendar.MINUTE, -m); //减120分钟数

        //editTime= Score.getScoreTime(node, member, posid, cal.getTime());


        Score.set(editTime,member,node,name,tee,compete,sums,18,fact,fairway,up,bunt,times,caddy,"",creditcard,posid,fieldid,fieldid2,hfinish);

        return Score.exp(str);
    }

    //查询成绩
    public static String exp(String str) throws Exception
    {
        HashMap hm = MT.xml(str);
        //会员
        String member = (String) hm.get("vipid");

        String creditcard = (String) hm.get("number");

        Enumeration e = Profile.find(" AND member=" + DbAdapter.cite(member),0,1);
        if(!e.hasMoreElements())
        {
            return "false您录入的会员不存在....";
        }
        member = (String) e.nextElement();

        //差点
        Iterator it = Score.find(" AND member=" + DbAdapter.cite(member) + " ORDER BY times DESC",0,1).iterator();
        if(!it.hasNext())
        {
            return "false没找到差点数据!";
        }
        StringBuffer sb = new StringBuffer("true");
        Score s = (Score) it.next();
        //
        int lang = 1;
        Profile p = Profile.find(member);
        Node n = Node.find(s.getNode());
        Golf g = Golf.find(s.getNode(),lang);

        GolfSite gobj1 = GolfSite.find(GolfSite.getGSid(s.getNode(),s.getFieldid()));
        GolfSite gobj2 = GolfSite.find(GolfSite.getGSid(s.getNode(),s.getFieldid2()));

        if(gobj1.difficultys[s.tee] <= 0 || gobj1.difficultys[s.tee] <= 0)
        {
            return "false球场难度系数没有设置，不能查询成绩！";
        }
        if(gobj2.gradients[s.tee] <= 0 || gobj2.gradients[s.tee] <= 0)
        {
            return "false球场坡度系数没有设置，不能查询成绩！";
        }
        //会员差点

        sb.append("<?xml version=\"1.0\" encoding=\"GBK\"?>\r\n");
        sb.append("<golfScore>");
        sb.append("<Number>" + p.getCreditcard() + "</Number>"); //差点会员卡号
        sb.append("<VIPNO>" + member + "</VIPNO>"); //会员编号
        sb.append("<name>" + p.getName(lang) + "</name>"); //会员姓名
        sb.append("<CaddyID>" + s.caddy + "</CaddyID>"); //球童编号
        sb.append("<courtName>" + n.getSubject(lang) + "</courtName>"); //球场名称
        sb.append("<dateTime>" + new SimpleDateFormat("yyyyMMddHHmmss").format(s.times) + "</dateTime>"); //打球时间
        sb.append("<sumRod>" + s.sums + "</sumRod>"); //本场总杆
        sb.append("<handicap>" + s.diff + "</handicap>"); //本场差点微分
        sb.append("<handicapIndex>" + Score.getMemberAvgs(member) + "</handicapIndex>"); //最近差点指数
        sb.append("<dBogey>" + s.getDuble() + "</dBogey>"); //双柏忌数量
        sb.append("<bogey>" + s.getBogey() + "</bogey>"); //柏忌数量
        sb.append("<par>" + s.getPar() + "</par>"); //标准杆数量
        sb.append("<birdie>" + s.getBirdie() + "</birdie>"); //小鸟球数量
        sb.append("<eagle>" + s.getEagle() + "</eagle>"); //老鹰球数量
        sb.append("<P3onRate>" + (int) s.getPar3C() + "</P3onRate>"); //标准杆为3杆的平均on果岭数
        sb.append("<P4onRate>" + (int) s.getPar4C() + "</P4onRate>"); //标准杆为4杆的平均on果岭数
        sb.append("<P5onRate>" + (int) s.getPar5C() + "</P5onRate>"); //标准杆为5杆的平均on果岭数
        sb.append("<ParOnRate>" + (int) s.getParC() + "</ParOnRate>"); //parOn率
        sb.append("<averPush>" + s.getBuntC() + "</averPush>"); //平均推杆数
        sb.append("<wayRate>" + (int) s.getFairwayC() + "</wayRate>"); //首杆上球道率

        Resource r = new Resource("/tea/resource/Score");
        String tee = r.getString(1,Score.TEE_TYPE[s.tee]);
        if(tee.equals("黄"))
        {
            tee = "金";
        }
        sb.append("<tee>" + tee + "</tee>"); //发球台
        // String posid = g.posid;
        //   sb.append("<fieldID>" + posid.charAt(posid.length() - 1) + "</fieldID>"); //场地编号
        sb.append("<fieldID>" + s.getFieldid() + "</fieldID>"); //场地编号
        sb.append("<fieldID2>" + s.getFieldid2() + "</fieldID2>"); //场地编号
        sb.append("<event>" + (s.isCompete() ? "Y" : "N") + "</event>"); //是否为赛事成绩
        sb.append("<eventName>" + "暂无" + "</eventName>"); //比赛名称

        //标准杆合计
        int totalpar = 0;

        //on果岭数合计
        int totalon = 0;
        //推杆数合计
        int totalpush = 0;
        //加杆数合计
        int totaladd = 0;
        //总杆数 合计
        int sumRod1 = 0;
        int sumRod2 = 0;

        //首杆是否上球道百分比
        int TotalWay = 0;
        for(int i = 0;i < 18;i++)
        {
            int j = s.up[i] + s.bunt[i];

            // sb.append("<H" + (i + 1) + "Par>" + g.standard[i] + "</H" + (i + 1) + "Par>"); //1号洞标准杆


            if(i < 9)
            {
                sb.append("<H" + (i + 1) + "Par>" + gobj1.getStandard(i + 1) + "</H" + (i + 1) + "Par>"); //1号洞标准杆
                totalpar = totalpar + gobj1.getStandard(i + 1);
                sumRod1 = sumRod1 + j;
                //  System.out.println("<H" + (i + 1) + "Par>" + gobj1.getStandard(i+1) + "</H" + (i + 1) + "Par>");

            } else
            {
                sb.append("<H" + (i + 1) + "Par>" + gobj2.getStandard(i - 8) + "</H" + (i + 1) + "Par>"); //1号洞标准杆
                totalpar = totalpar + gobj2.getStandard(i - 8);
                sumRod2 = sumRod2 + j;
            }

            sb.append("<H" + (i + 1) + "Way>" + (s.fairway[i] ? "Y" : "N") + "</H" + (i + 1) + "Way>"); //1号洞首杆是否上球道

            if(s.fairway[i])
            {
                TotalWay++;
            }

            sb.append("<H" + (i + 1) + "on>" + s.up[i] + "</H" + (i + 1) + "on>"); //1号洞on果岭数
            totalon = totalon + s.up[i];
            sb.append("<H" + (i + 1) + "Push>" + s.bunt[i] + "</H" + (i + 1) + "Push>"); //1号洞推杆数
            totalpush = totalpush + s.bunt[i];
            // sb.append("<H" + (i + 1) + "Add>" + (j - g.standard[i]) + "</H" + (i + 1) + "Add>"); //1号洞加杆数
            if(i < 9)
            {

                sb.append("<H" + (i + 1) + "Add>" + (j - gobj1.getStandard(i + 1)) + "</H" + (i + 1) + "Add>"); //1号洞加杆数
                totaladd = totaladd + (j - gobj1.getStandard(i + 1));

            } else
            {
                sb.append("<H" + (i + 1) + "Add>" + (j - gobj2.getStandard(i - 8)) + "</H" + (i + 1) + "Add>"); //1号洞加杆数
                totaladd = totaladd + (j - gobj2.getStandard(i - 8));
            }

            sb.append("<H" + (i + 1) + "Sum>" + j + "</H" + (i + 1) + "Sum>"); //1号洞总共打了多少杆
        }
        //最近5次差点指数 -历史记录



        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date times = new Date();
        Calendar c = Calendar.getInstance();
        c.setTime(times);
        c.add(Calendar.MONTH, -12);

        sb.append(Score.agrs("   avgs !=-10000 and shows=1 and  createtime >=" + DbAdapter.cite(c.getTime()) + " and  member =" + DbAdapter.cite(member)));
        //球会简介
        sb.append("<introduction>" + g.getSynopsis() + "</introduction>");
        //差点助理建议
        sb.append("<Proposal>0</Proposal>");
        //标准杆合计
        sb.append("<TotalPar>" + totalpar + "</TotalPar>"); //"+(String.valueOf(totalpar1)+String.valueOf(totalpar2))+(totalpar1+totalpar2)+"

        //果岭数
        sb.append("<Totalon>" + totalon + "</Totalon> ");
        //推杆数
        sb.append("<TotalPush>" + totalpush + "</TotalPush> ");
        //加杆数
        sb.append("<TotalAdd>" + totaladd + "</TotalAdd>");

        //总杆数(23+34)57
        sb.append("<sumRod2>(" + sumRod1 + "+" + sumRod2 + ")</sumRod2>");
        //System.out.println("<sumRod2>("+sumRod1+"+"+sumRod2+")</sumRod2>");
        //首杆上球道
        float ps = (float) TotalWay / 18;
        java.text.NumberFormat nf = java.text.NumberFormat.getPercentInstance();
        nf.setMinimumFractionDigits(0); // 小数点后保留几位
        String Way_str = nf.format(ps); // 要转化的数

        sb.append("<TotalWay>" + Way_str + "</TotalWay> ");

        sb.append("</golfScore>");

        System.out.println("查询使用-本场差点微分:" + s.diff);
        //  System.out.println(sb.toString());

        return sb.toString();
    }

    //查询球场差点
    public static String fieldid_exp(String str) throws Exception
    {
        HashMap hm = MT.xml(str);
        //会员
        String member = (String) hm.get("vipid");
        //设备编号
        String posID = (String) hm.get("posid");
        //场地
        String fieldid = (String) hm.get("field1");
        String fieldid2 = (String) hm.get("field2");
        //发球台
        String teename = (String) hm.get("tee");

        String[] TEE =
                       {"黑","黄","蓝","白","红"};
        if(teename.equals("金"))
        {
            teename = "黄";
        }

        int tee = Arrayx.indexOf(TEE,teename);

        String creditcard = (String) hm.get("number");
        Enumeration e = Profile.find(" AND member=" + DbAdapter.cite(member),0,1);
        if(!e.hasMoreElements())
        {
            return "false您录入的会员不存在....";
        }
        // member = (String) e.nextElement();

        //差点
        Iterator it = Score.find(" AND member=" + DbAdapter.cite(member) + " ORDER BY times DESC",0,1).iterator();
        if(!it.hasNext())
        {
            return "false没找到差点数据";
        }
        StringBuffer sb = new StringBuffer("true");
        Score s = (Score) it.next();

        if(s.getNode() == 0) //没有这个球场
        {
            return "false系统找不到查询的球场信息";
        }

        GolfSite gobj1 = GolfSite.find(GolfSite.getGSid(s.getNode(),fieldid));
        GolfSite gobj2 = GolfSite.find(GolfSite.getGSid(s.getNode(),fieldid2));

        if(GolfSite.getGSid(s.getNode(),fieldid) == 0)
        {
            return "false前九洞的场地编号不存在，不能查询差点";
        }
        if(GolfSite.getGSid(s.getNode(),fieldid2) == 0)
        {
            return "false后九洞的场地编号不存在，不能查询差点";
        }

        if(gobj1.difficultys[tee] <= 0 || gobj1.difficultys[tee] <= 0)
        {
            return "false发球台数据错误，不能查询差点";
        }
        if(gobj2.gradients[tee] <= 0 || gobj2.gradients[tee] <= 0)
        {
            return "false发球台数据错误，不能查询差点";
        }

        //球场差点
        System.out.println("s.getNode():" + s.getNode());
        int cd = Score.getQccd(member,s.getNode(),fieldid,fieldid2,tee);
        sb.append("<?xml version=\"1.0\" encoding=\"GBK\"?>\r\n");
        sb.append("<fieldSelect>");
        sb.append("<posID>" + posID + "</posID>");
        sb.append("<VIPNO>" + member + "</VIPNO>"); //会员编号
        sb.append("<qccd>" + cd + "</qccd>");
        sb.append("</fieldSelect>");
        return sb.toString();
    }

}
