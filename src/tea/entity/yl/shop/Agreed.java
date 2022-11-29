package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;
import tea.entity.member.Profile;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/*
 * 服务商满意度调查
 * */
public class Agreed {
    protected static Cache c = new Cache(50);
    private int id; //主键id
    private int profile;//用户id
    private Date creatTime;//创建时间
    private String myd;//满意度            19个  ，相隔      很好 好 一般 不满意  1 2 3 4   3、4有备注
    private String mydbz;//满意度备注         19个  ，相隔
    private int cpxq;//产品需求      1有  2无
    private String cpxqsm; //产品需求说明
    private String idea;//意见 建议
    private int companyid;//公司id
    private String gsdz;//公司地址      医院名
    private String cz;//传真           科室
    private int type;// 0 同福服务商   1 高科医生

    public static String [] TIMU ={"产品交付的及时性（运输效率）","交付的产品与订单的一致性","产品数量的正确性","随货资料与产品的一致性","交付产品的活度","产品的外观、尺寸","产品质量的稳定性","与市场同类产品比较","技术人员的业务能力","技术人员的服务水平","提供技术支持的结果","客服务人员的态度","客诉反馈的及时性","问题处理措施的有效性","市场服务人员的态度","拜访或电话拜访频率","沟通和解决问题的能力","财务票据办理的及时性","其他财务问题响应速度"};
    public static String [] DAAN ={"很好","好","一般","不满意"};


    public Agreed(int id) {
        this.id = id;
    }


    /**
     * 根据id查询
     *
     * @param
     * @return
     */
    public static Agreed find(int id) throws SQLException {
        Agreed sf = (Agreed) c.get(id);
        if (sf == null) {
            List<Agreed> list = find(" AND id = " + id, 0, 1);
            sf = list.size() < 1 ? new Agreed(id) : list.get(0);
        }
        return sf;
    }

    /*
     * 查询条数
     * */
    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("SELECT COUNT(*) from tb_agreed WHERE 1=1 " + sql);

    }


    /**
     * 分页查询所有
     *
     * @param sql
     * @param pos
     * @param page_size
     * @return
     */
    public static List<Agreed> find(String sql, int pos, int page_size) throws SQLException {
        List<Agreed> sfList = new ArrayList<Agreed>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,profile,creatTime,myd,mydbz,cpxq,cpxqsm,idea,companyid,gsdz,cz,type from tb_agreed where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()) {
                int i = 1;
                Agreed sf = new Agreed(rs.getInt(i++));
                sf.setProfile(rs.getInt(i++));
                sf.setCreatTime(rs.getDate(i++));
                sf.setMyd(rs.getString(i++));
                sf.setMydbz(rs.getString(i++));
                sf.setCpxq(rs.getInt(i++));
                sf.setCpxqsm(rs.getString(i++));
                sf.setIdea(rs.getString(i++));
                sf.setCompanyid(rs.getInt(i++));
                sf.setGsdz(rs.getString(i++));
                sf.setCz(rs.getString(i++));
                sf.setType(rs.getInt(i++));
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
            sql = "INSERT INTO tb_agreed(id,profile,creatTime,myd,mydbz,cpxq,cpxqsm,idea,companyid,gsdz,cz,type)VALUES(" + (id = Seq.get()) + ","+profile+"," + DbAdapter.cite(creatTime) + "," + DbAdapter.cite(myd) + "," + Database.cite(mydbz) + "," +cpxq+ "," + Database.cite(cpxqsm) + "," + Database.cite(idea) + ","+companyid+","+Database.cite(gsdz)+","+Database.cite(cz)+","+type+")";
        } else {
            sql = "UPDATE tb_agreed SET profile=" + profile + ",creatTime=" + DbAdapter.cite(creatTime) + ",myd=" + Database.cite(myd) + ",mydbz=" + Database.cite(mydbz) + ",cpxq=" + cpxq + ",cpxqsm=" + DbAdapter.cite(cpxqsm) + ",idea=" + Database.cite(idea) + ",companyid="+companyid+",gsdz="+Database.cite(gsdz)+",cz="+Database.cite(cz)+",type="+type+" WHERE id=" + id;
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
            db.executeUpdate("DELETE FROM tb_agreed WHERE id in(" + ids + ")");
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
    public static void clearAgreed() throws SQLException {
        List<Profile> arrayList = Profile.find1(" AND agreednum>0 ", 0, Integer.MAX_VALUE);
        for (int i = 0; i <arrayList.size() ; i++) {
            Profile profile = arrayList.get(i);
            profile.set("agreednum","0");
        }


    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProfile() {
        return profile;
    }

    public void setProfile(int profile) {
        this.profile = profile;
    }

    public Date getCreatTime() {
        return creatTime;
    }

    public void setCreatTime(Date creatTime) {
        this.creatTime = creatTime;
    }

    public String getMyd() {
        return myd;
    }

    public void setMyd(String myd) {
        this.myd = myd;
    }

    public String getMydbz() {
        return mydbz;
    }

    public void setMydbz(String mydbz) {
        this.mydbz = mydbz;
    }

    public int getCpxq() {
        return cpxq;
    }

    public void setCpxq(int cpxq) {
        this.cpxq = cpxq;
    }

    public String getCpxqsm() {
        return cpxqsm;
    }

    public void setCpxqsm(String cpxqsm) {
        this.cpxqsm = cpxqsm;
    }

    public String getIdea() {
        return idea;
    }

    public void setIdea(String idea) {
        this.idea = idea;
    }

    public int getCompanyid() {
        return companyid;
    }

    public void setCompanyid(int companyid) {
        this.companyid = companyid;
    }

    public String getGsdz() {
        return gsdz;
    }

    public void setGsdz(String gsdz) {
        this.gsdz = gsdz;
    }

    public String getCz() {
        return cz;
    }

    public void setCz(String cz) {
        this.cz = cz;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
