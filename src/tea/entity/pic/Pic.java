package tea.entity.pic;

import java.util.*;
import java.sql.SQLException;
import tea.db.*;
import tea.entity.*;
import tea.entity.site.*;
import java.text.*;

public class Pic
{
    protected static Cache c = new Cache(50);
    public int pic;
    public String member; //摄影师
    public static String[] STATE_TYPE =
            {"待审核","已审核,待编辑","审核未通过","已上线","撤图待审","撤图已批","撤图未批","删除"};
    public int state; //图片状态
    public String code; //编号
    public String name; //名称
    public Date time; //上传日期
    public int people; //图片上的人数
    public static String[] PORTRAIT_TYPE =
            {"有","没有","不需要"};
    public int portrait; //肖像权
    public static String[] PROPERTY_TYPE =
            {"有","没有","不需要"};
    public int property; //物产权
    public static String[] PIC_TYPE =
            {"RM","RF","新闻图片"};
    public static String[] PIC_DIR =
            {"rm","rf","news"};
    public int type; //图片类型
    public static String[] SORT_TYPE =
            {"摄影","插画"};
    public int sort; //图片分类
    public boolean cut; //图片是否载剪
    public boolean exclusive; //是否独家
    public static String[] CATE_TYPE =
            {"照片","插图"};
    public int cate; //这是什么图片
    public static String[] MEDIA_TYPE =
            {"---------","数码JPG格式","数码RAW格式","35mm胶片","120胶片","4X5以上胶片","其它"};
    public int media; //原始介质
    public String mother;
    public static String[] COLOR_TYPE =
            {"黑白","彩色"};
    public int color; //图片颜色
    public static String[] DIREC_TYPE =
            {"横图","竖图","正图","全景图"};
    public int direc; //图片方向
    public static String[] COUNTRY_TYPE =
            {"国内","国外"};
    public boolean country; //国家
    public String title; //标题
    public String bkey; //基本关键字
    public String mkey; //主要关键字
    public String gkey; //综合关键字
    public String content; //说明
    public String location; //位置
    public Date rtime; //发布日期
    public int hits; //浏览次数
    public int width;
    public int height;
    public int score; //评分
    public String news; //新闻图片分类
    //
    public String omember; //审核人
    public Date otime; //审核日期
    public String oremark; //审核备注
    //新闻
    public String ntime; //新闻时间
    public String nlocation; //新闻地址
    public String npeople; //新闻人物
    //撤图
    public Date ctime; //撤图申请时间
    public String creason; //撤图原因
    public String cremark; //撤图备注
    //
    private String path0; //原图
    public String path1; //1号图
    public String path2; //2号图


    public Pic(int pic)
    {
        this.pic = pic;
    }

    public static Pic find(int pic) throws SQLException
    {
        Pic t = (Pic) c.get(pic);
        if(t == null)
        {
            ArrayList al = find(" AND pic=" + pic,0,1);
            t = al.size() < 1 ? new Pic(pic) : (Pic) al.get(0);
        }
        return t;
    }

    public static ArrayList find(String sql,int pos,int size) throws SQLException
    {
        ArrayList al = new ArrayList();
        DbAdapter db = new DbAdapter();
        try
        {
            java.sql.ResultSet rs = db.executeQuery("SELECT pic,member,state,code,name,time,people,portrait,property,type,sort,cut,exclusive,cate,media,mother,color,direc,country,title,bkey,mkey,gkey,content,location,rtime,hits,width,height,score,news,omember,otime,oremark,ntime,nlocation,npeople,ctime,creason,cremark FROM pic WHERE 1=1" + sql,pos,size);
            while(rs.next())
            {
                int i = 1;
                Pic t = new Pic(rs.getInt(i++));
                t.member = rs.getString(i++);
                t.state = rs.getInt(i++);
                t.code = rs.getString(i++);
                t.name = rs.getString(i++);
                t.time = db.getDate(i++);
                t.people = rs.getInt(i++);
                t.portrait = rs.getInt(i++);
                t.property = rs.getInt(i++);
                t.type = rs.getInt(i++);
                t.sort = rs.getInt(i++);
                t.cut = rs.getBoolean(i++);
                t.exclusive = rs.getBoolean(i++);
                t.cate = rs.getInt(i++);
                t.media = rs.getInt(i++);
                t.mother = rs.getString(i++);
                t.color = rs.getInt(i++);
                t.direc = rs.getInt(i++);
                t.country = rs.getBoolean(i++);
                t.title = rs.getString(i++);
                t.bkey = rs.getString(i++);
                t.mkey = rs.getString(i++);
                t.gkey = rs.getString(i++);
                t.content = rs.getString(i++);
                t.location = rs.getString(i++);
                t.rtime = db.getDate(i++);
                t.hits = rs.getInt(i++);
                t.width = rs.getInt(i++);
                t.height = rs.getInt(i++);
                t.score = rs.getInt(i++);
                t.news = rs.getString(i++);
                t.omember = rs.getString(i++);
                t.otime = db.getDate(i++);
                t.oremark = rs.getString(i++);
                t.ntime = rs.getString(i++);
                t.nlocation = rs.getString(i++);
                t.npeople = rs.getString(i++);
                t.ctime = db.getDate(i++);
                t.creason = rs.getString(i++);
                t.cremark = rs.getString(i++);
                t.path1 = t.getPath(t.type,t.country,"1");
                t.path2 = t.getPath(t.type,t.country,"2");
                c.put(t.pic,t);
                al.add(t);
            }
            rs.close();
        } finally
        {
            db.close();
        }
        return al;
    }

    public String getPath0() throws SQLException
    {
        return getPath(type,country,"原图");
    }

    final static DecimalFormat df3 = new DecimalFormat("000"),df4 = new DecimalFormat("0000");
    final static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    public String getPath(int type,boolean country,String size) throws SQLException
    {
        String dir = "wi" + (country ? 'f' : 'l') + (type == 2 ? sdf.format(new Date()) : "p" + df3.format(pic / 1000));
        return(size.length() == 1 ? "/res/pic" : CommunityOption.find("[SYSTEM]").get("picpath")) + "/" + Pic.PIC_DIR[type] + "/" + dir + "/" + size + "/" + dir + df4.format(pic % 1000) + ".jpg";
    }

    public static int count(String sql) throws SQLException
    {
        return DbAdapter.execute("SELECT COUNT(*) FROM pic WHERE 1=1" + sql);
    }

    public void set() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE pic SET state=" + state + ",code=" + DbAdapter.cite(code) + ",name=" + DbAdapter.cite(name) + ",time=" + DbAdapter.cite(time) + ",people=" + people + ",portrait=" + portrait + ",property=" + property + ",type=" + type + ",sort=" + sort + ",cut=" + DbAdapter.cite(cut) + ",exclusive=" + DbAdapter.cite(exclusive) + ",cate=" + cate + ",media=" + media + ",mother=" + DbAdapter.cite(mother) + ",color=" + color + ",direc=" + direc + ",country=" + DbAdapter.cite(country) + ",title=" + DbAdapter.cite(title) + ",bkey=" + DbAdapter.cite(bkey) + ",mkey=" + DbAdapter.cite(mkey) + ",gkey=" + DbAdapter.cite(gkey) + ",content=" + DbAdapter.cite(content) + ",location=" + DbAdapter.cite(location) + ",rtime=" + DbAdapter.cite(rtime) + ",hits=" + hits +
                             ",width=" + width + ",height=" + height + ",score=" + score + ",news=" + DbAdapter.cite(news) + ",omember=" + DbAdapter.cite(omember) + ",otime=" + DbAdapter.cite(otime) + ",oremark=" + DbAdapter.cite(oremark) + ",ntime=" + DbAdapter.cite(ntime) + ",nlocation=" + DbAdapter.cite
                             (nlocation) + ",npeople=" + DbAdapter.cite(npeople) + ",ctime=" + DbAdapter.cite(ctime) + ",creason=" + DbAdapter.cite(creason) + ",cremark=" + DbAdapter.cite(cremark) + " WHERE pic=" + pic);
        } finally
        {
            db.close();
        }
        c.remove(pic);
    }

    public void delete() throws SQLException
    {
        DbAdapter.execute("DELETE FROM pic WHERE pic=" + pic);
        c.remove(pic);
    }

    public void set(String f,String v) throws SQLException
    {
        DbAdapter.execute("UPDATE pic SET " + f + "=" + DbAdapter.cite(v) + " WHERE pic=" + pic);
        c.remove(pic);
    }

    public void setHits() throws SQLException
    {
        hits++;
        DbAdapter.execute("UPDATE pic SET hits=" + hits + " WHERE pic=" + pic);
    }

    //
    public static synchronized int create(String member,String name,int width,int height) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO pic(member,state,name,time,width,height,hits)VALUES(" + DbAdapter.cite(member) + ",0," + DbAdapter.cite(name) + "," + DbAdapter.cite(new Date()) + "," + width + "," + height + ",0)");
            return db.getInt("SELECT MAX(pic) FROM pic");
        } finally
        {
            db.close();
        }
    }

}
