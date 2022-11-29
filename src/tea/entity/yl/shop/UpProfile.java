package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 普通用户升级记录
 */
public class UpProfile {
    protected static Cache c = new Cache(50);
    private int upid;           // id
    private int profile;        // 用户id
    private int uptype;         // 升级类型 0:服务商 1:vip
    private int business;       // 营业执照
    private int license;        // 开户许可证
    private int other;          // 其他材料
    private int state;          // 申请状态 0:申请 1:成功 2:失败
    private Date uptime;        // 申请时间
    private Date extime;        // 审核时间
    private int member;         // 审核人
    private String describe;    // 描述
    private String email;     // 邮箱
    private String company;     // 服务商公司名称
    private int isdele;         //删除，用户页面看不到

    public UpProfile() {
    }

    public UpProfile(int upid) {
        this.upid = upid;
    }

    /**
     * 分页查询所有
     * @param sql
     * @param pos
     * @param size
     * @return
     */
    public static List<UpProfile> find(String sql,int pos,int size){
        ArrayList<UpProfile> upList = new ArrayList<UpProfile>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select upid,profile,uptype,business,license,other,state,uptime,extime,member,describe,company,isdele,email from upProfile where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, size);
            while (rs.next()){
                int i=1;
                UpProfile up = new UpProfile(rs.getInt(i++));
                up.setProfile(rs.getInt(i++));
                up.setUptype(rs.getInt(i++));
                up.setBusiness(rs.getInt(i++));
                up.setLicense(rs.getInt(i++));
                up.setOther(rs.getInt(i++));
                up.setState(rs.getInt(i++));
                up.setUptime(rs.getDate(i++));
                up.setExtime(rs.getDate(i++));
                up.setMember(rs.getInt(i++));
                up.setDescribe(rs.getString(i++));
                up.setCompany(rs.getString(i++));
                up.setIsdele(rs.getInt(i++));
                up.setEmail(rs.getString(i++));
                c.put(up.upid,up);
                upList.add(up);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return upList;
    }

    /**
     * 查询数量
     * @param sql
     * @return
     */
    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("select count(0) from upProfile where 1=1" + sql);
    }

    /**
     * 根据用户id查询
     * @param id
     * @return
     * @throws SQLException
     */
    public static UpProfile findByMember(int id) throws SQLException
    {
        UpProfile t = null;
        ArrayList<UpProfile> al = (ArrayList<UpProfile>) find(" AND member=" + id, 0, 1);
        t = al.size() < 1 ? new UpProfile(0) : (UpProfile) al.get(0);
        return t;
    }

    /**
     * 根据id查询
     * @param upid
     * @return
     */
    public static UpProfile find(int upid){
        UpProfile up = (UpProfile) c.get(upid);
        if(up == null){
            ArrayList<UpProfile> list = (ArrayList<UpProfile>) find(" AND upid = " + upid, 0, 1);
            up = list.size() < 1 ? new UpProfile(upid):list.get(0);
        }
        return up;
    }

    /**
     * 添加 || 修改
     */
    public void set() throws SQLException {
        String sql = "";
        if(this.upid<1){
            sql = "insert into upProfile(upid,profile,uptype,business,license,other,state,uptime,extime,member,describe,company,isdele,email) values("+
                    (this.upid = Seq.get()) + "," +
                    this.profile + "," +
                    this.uptype + "," +
                    this.business + "," +
                    this.license + "," +
                    this.other + "," +
                    this.state + "," +
                    DbAdapter.cite(this.uptime) + "," +
                    DbAdapter.cite(this.extime) + "," +
                    this.member + "," +
                    DbAdapter.cite(this.describe) + "," +
                    DbAdapter.cite(this.company)+","+
                    this.isdele+","+
                    DbAdapter.cite(this.email)
                    +")";
        }else{
            sql = "update upProfile set profile=" + this.profile
            + ",uptype=" + this.uptype
            + ",business=" + this.business
            + ",license=" + this.license
            + ",other=" + this.other
            + ",state=" + this.state
            + ",uptime=" + DbAdapter.cite(this.uptime)
            + ",extime=" + DbAdapter.cite(this.extime)
            + ",member=" + this.member
            + ",describe=" + DbAdapter.cite(this.describe)
            + ",company=" + DbAdapter.cite(this.company)
            + ",isdele="+this.isdele
            + ",email="+DbAdapter.cite(this.email)
            + " where upid=" + this.upid;

        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.upid,sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        c.remove(this.upid);
    }
    public int getUpid() {
        return upid;
    }

    public void setUpid(int upid) {
        this.upid = upid;
    }

    public int getProfile() {
        return profile;
    }

    public void setProfile(int profile) {
        this.profile = profile;
    }

    public int getUptype() {
        return uptype;
    }

    public void setUptype(int uptype) {
        this.uptype = uptype;
    }

    public int getBusiness() {
        return business;
    }

    public void setBusiness(int business) {
        this.business = business;
    }

    public int getLicense() {
        return license;
    }

    public void setLicense(int license) {
        this.license = license;
    }

    public int getOther() {
        return other;
    }

    public void setOther(int other) {
        this.other = other;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public Date getUptime() {
        return uptime;
    }

    public void setUptime(Date uptime) {
        this.uptime = uptime;
    }

    public Date getExtime() {
        return extime;
    }

    public void setExtime(Date extime) {
        this.extime = extime;
    }

    public int getMember() {
        return member;
    }

    public void setMember(int member) {
        this.member = member;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public int getIsdele() {
        return isdele;
    }

    public void setIsdele(int isdele) {
        this.isdele = isdele;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
