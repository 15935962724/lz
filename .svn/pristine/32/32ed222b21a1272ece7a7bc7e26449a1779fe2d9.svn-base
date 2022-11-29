package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;
import util.Config;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/*
 * 君安问卷调查
 * */
public class Question {
    protected static Cache c = new Cache(50);
    private int id; //主键id
    private String orderId;//批号  订单号
    private Date beginTime;//开始日期
    private Date endTime;//结束日期
    private int gender;//性别  1男   2女
    private int age;//年龄
    private String yhjb;//原患疾病
    private int jws;//既往史
    private String yyyy;//用药原因
    private int yply;//药品来源
    private int num;//用量
    private int lhyyqk;//是否联合用药
    private String lhyyqktext;//联合用药情况
    private int sfgs;//是否改善
    private String yzqksm;//严重情况说明
    private int blfy;//不良反应
    private String blfytext;//不良反应详情
    private int profile;//用户id
    private String hospital_name;//医院名称
    private String hospital_ks;//医院科室
    private Date creatTime;//创建时间

    public Question(int id) {
        this.id = id;
    }


    /**
     * 根据id查询
     *
     * @param
     * @return
     */
    public static Question find(int id) throws SQLException {
        Question sf = (Question) c.get(id);
        if (sf == null) {
            List<Question> list = find(" AND id = " + id, 0, 1);
            sf = list.size() < 1 ? new Question(id) : list.get(0);
        }
        return sf;
    }

    /*
     * 查询条数
     * */
    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("SELECT COUNT(*) from tb_question WHERE 1=1 " + sql);

    }


    /**
     * 分页查询所有
     *
     * @param sql
     * @param pos
     * @param page_size
     * @return
     */
    public static List<Question> find(String sql, int pos, int page_size) throws SQLException {
        List<Question> sfList = new ArrayList<Question>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,orderId,beginTime,endTime,gender,age,yhjb,jws,yyyy,yply,num,lhyyqk,lhyyqktext,sfgs,yzqksm,blfy,blfytext,profile,hospital_name,hospital_ks,creatTime from tb_question where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()) {
                int i = 1;
                Question sf = new Question(rs.getInt(i++));
                sf.setOrderId(rs.getString(i++));
                sf.setBeginTime(rs.getDate(i++));
                sf.setEndTime(rs.getDate(i++));
                sf.setGender(rs.getInt(i++));
                sf.setAge(rs.getInt(i++));
                sf.setYhjb(rs.getString(i++));
                sf.setJws(rs.getInt(i++));
                sf.setYyyy(rs.getString(i++));
                sf.setYply(rs.getInt(i++));
                sf.setNum(rs.getInt(i++));
                sf.setLhyyqk(rs.getInt(i++));
                sf.setLhyyqktext(rs.getString(i++));
                sf.setSfgs(rs.getInt(i++));
                sf.setYzqksm(rs.getString(i++));
                sf.setBlfy(rs.getInt(i++));
                sf.setBlfytext(rs.getString(i++));
                sf.setProfile(rs.getInt(i++));
                sf.setHospital_name(rs.getString(i++));
                sf.setHospital_ks(rs.getString(i++));
                sf.setCreatTime(rs.getDate(i++));
                c.put(sf.id, sf);
                sfList.add(sf);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return sfList;
    }

    public int set() throws SQLException {
        String sql;
        if (id < 1) {
            sql = "INSERT INTO tb_question(id,orderId,beginTime,endTime,gender,age,yhjb,jws,yyyy,yply,num,lhyyqk,lhyyqktext,sfgs,yzqksm,blfy,blfytext,hospital_name,hospital_ks,creatTime,profile)VALUES(" + (id = Seq.get()) + ","+Database.cite(orderId)+"," + DbAdapter.cite(beginTime) + "," + DbAdapter.cite(endTime) + "," + gender + "," + age + "," + Database.cite(yhjb) + "," + jws + "," + Database.cite(yyyy) + "," + yply + "," + num + "," + lhyyqk + "," + Database.cite(lhyyqktext) + "," + sfgs + "," + Database.cite(yzqksm) + "," + blfy + "," + Database.cite(blfytext) + "," + Database.cite(hospital_name) + "," + Database.cite(hospital_ks) + "," + Database.cite(new Date()) + ","+profile+")";
        } else {
            sql = "UPDATE tb_question SET orderId=" + DbAdapter.cite(orderId) + ",beginTime=" + DbAdapter.cite(beginTime) + ",endTime=" + Database.cite(endTime) + ",gender=" + gender + ",age=" + age + ",yhjb=" + DbAdapter.cite(yhjb) + ",jws=" + jws + ",yyyy=" + Database.cite(yyyy) + ",yply=" + yply + ",num=" + num + ",lhyyqk=" + lhyyqk + ",lhyyqktext=" + Database.cite(lhyyqktext) + ",sfgs=" + sfgs + ",yzqksm=" + Database.cite(yzqksm) + ",blfy=" + blfy + ",blfytext=" + Database.cite(blfytext) + ",profile=" + profile + ",hospital_name=" + Database.cite(hospital_name) + ",hospital_ks=" + Database.cite(hospital_ks) + " WHERE id=" + id;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(id, sql);
        } finally {
            db.close();
        }
        c.remove(id);
        return id;
    }

    public static void delete(String ids) {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("DELETE FROM tb_question WHERE id in(" + ids + ")");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        String[] arr = ids.split(",");
        for (int i = 0; i < arr.length; i++) {
            c.remove(arr[i]);
        }
    }

    //每季度凌晨1点执行清除次数操作
    public static void clearQuestion() throws SQLException {
        ArrayList<ShopHospital> shopHospitals = ShopHospital.find(" AND questionnum>0 ", 0, Integer.MAX_VALUE);
        for (int i = 0; i <shopHospitals.size() ; i++) {
            ShopHospital hospital = shopHospitals.get(i);
            hospital.setQuestionnum(0);
            hospital.set();
        }

    }

    public static Cache getC() {
        return c;
    }

    public static void setC(Cache c) {
        Question.c = c;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getYhjb() {
        return yhjb;
    }

    public void setYhjb(String yhjb) {
        this.yhjb = yhjb;
    }

    public int getJws() {
        return jws;
    }

    public void setJws(int jws) {
        this.jws = jws;
    }

    public String getYyyy() {
        return yyyy;
    }

    public void setYyyy(String yyyy) {
        this.yyyy = yyyy;
    }

    public int getYply() {
        return yply;
    }

    public void setYply(int yply) {
        this.yply = yply;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public int getLhyyqk() {
        return lhyyqk;
    }

    public void setLhyyqk(int lhyyqk) {
        this.lhyyqk = lhyyqk;
    }

    public String getLhyyqktext() {
        return lhyyqktext;
    }

    public void setLhyyqktext(String lhyyqktext) {
        this.lhyyqktext = lhyyqktext;
    }

    public int getSfgs() {
        return sfgs;
    }

    public void setSfgs(int sfgs) {
        this.sfgs = sfgs;
    }

    public String getYzqksm() {
        return yzqksm;
    }

    public void setYzqksm(String yzqksm) {
        this.yzqksm = yzqksm;
    }

    public int getBlfy() {
        return blfy;
    }

    public void setBlfy(int blfy) {
        this.blfy = blfy;
    }

    public String getBlfytext() {
        return blfytext;
    }

    public void setBlfytext(String blfytext) {
        this.blfytext = blfytext;
    }

    public int getProfile() {
        return profile;
    }

    public void setProfile(int profile) {
        this.profile = profile;
    }

    public String getHospital_name() {
        return hospital_name;
    }

    public void setHospital_name(String hospital_name) {
        this.hospital_name = hospital_name;
    }

    public String getHospital_ks() {
        return hospital_ks;
    }

    public void setHospital_ks(String hospital_ks) {
        this.hospital_ks = hospital_ks;
    }

    public Date getCreatTime() {
        return creatTime;
    }

    public void setCreatTime(Date creatTime) {
        this.creatTime = creatTime;
    }
}
