package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SignFor {
    protected static Cache c = new Cache(50);
    private int sid;            // id
    private int hospital;       // 医院id
    private int perfile;        // 服务商id
    private int department;     // 科室
    public static final String DEPARTMENT_ARR[] =
            {"","核医学科","介入科","泌尿外科","放射科","CT室","磁共振室","超声室","肿瘤放疗科","肿瘤化疗与放射病科","心血管内科","呼吸内科","内分泌科","肾内科","血液内科","消化科","风湿免疫科","神经内科","急诊科","皮肤科","职业病科",
                    "儿科","普通外科","骨科","胸外科","心脏外科","神经外科","运动医学研究所","生殖医学中心","眼科","耳鼻喉科","口腔科","疼痛医学中心",
                    "超声诊断科","检验科","药剂科","手术室","采购供应科"};

    private String signatory;   // 签收人
    private String mobile;      // 手机号
    private String address;     // 详细地址
    private int signType;       // 签收类型 0,粒子 1,发票 2,发票+粒子
    private int eid;            // 授权申请记录id

    public SignFor() {
    }

    public SignFor(int sid) {
        this.sid = sid;
    }

    /**
     * 分页查询所有
     * @param sql
     * @param pos
     * @param size
     * @return
     */
    public static List<SignFor> find(String sql,int pos,int size){
        ArrayList<SignFor> list = new ArrayList<SignFor>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select sid,hospital,perfile,department,signatory,mobile,address,signType,eid from signFor where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, size);
            while (rs.next()){
                int i = 1;
                SignFor sf = new SignFor(rs.getInt(i++));
                sf.setHospital(rs.getInt(i++));
                sf.setPerfile(rs.getInt(i++));
                sf.setDepartment(rs.getInt(i++));
                sf.setSignatory(rs.getString(i++));
                sf.setMobile(rs.getString(i++));
                sf.setAddress(rs.getString(i++));
                sf.setSignType(rs.getInt(i++));
                sf.setEid(rs.getInt(i++));
                c.put(sf.sid,sf);
                list.add(sf);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }

        return list;
    }

    /**
     * 根据id查询
     * @param sid
     * @return
     */
    public static SignFor find(Integer sid){
        SignFor sf = (SignFor) c.get(sid);
        if(sf==null){
            ArrayList<SignFor> list = (ArrayList<SignFor>) find(" and sid=" + sid, 0, 1);
            sf = list.size() < 1 ? new SignFor(sid) : list.get(0);
        }
        return sf;
    }

    /**
     * 根据id删除
     * @param sid
     */
    public static void del(int sid) throws SQLException {
        DbAdapter.execute("delete signFor where sid="+sid);
    }

    /**
     * 添加 || 修改
     */
    public void set() throws SQLException {
        String sql = "";
        if(this.sid<1){
            sql = "insert into signFor(sid,hospital,perfile,department,signatory,mobile,address,signType,eid) values("+
                    (this.sid = Seq.get()) + "," +
                    this.hospital + "," +
                    this.perfile + "," +
                    this.department + "," +
                    DbAdapter.cite(this.signatory) + "," +
                    DbAdapter.cite(this.mobile) + "," +
                    DbAdapter.cite(this.address) + "," +
                    this.signType + "," +
                    this.eid
                    +")";
        }else{
            sql = "update signFor set hospital="+this.hospital+",perfile="+this.perfile+
            ",department="+this.department+",signatory="+DbAdapter.cite(this.signatory)+
            ",mobile="+DbAdapter.cite(this.mobile)+",address="+DbAdapter.cite(this.address)+
            ",signType="+this.signType+",eid="+this.eid+" where sid="+sid;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.sid,sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        c.remove(this.sid);
    }

    /**
     * 查询数量
     * @param sql
     * @return
     */
    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("select count(0) from signFor where 1=1" + sql);
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public int getHospital() {
        return hospital;
    }

    public void setHospital(int hospital) {
        this.hospital = hospital;
    }

    public int getPerfile() {
        return perfile;
    }

    public void setPerfile(int perfile) {
        this.perfile = perfile;
    }

    public int getDepartment() {
        return department;
    }

    public void setDepartment(int department) {
        this.department = department;
    }

    public String getSignatory() {
        return signatory;
    }

    public void setSignatory(String signatory) {
        this.signatory = signatory;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getSignType() {
        return signType;
    }

    public void setSignType(int signType) {
        this.signType = signType;
    }

    public int getEid() {
        return eid;
    }

    public void setEid(int eid) {
        this.eid = eid;
    }
}
