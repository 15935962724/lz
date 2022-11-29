package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Database;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;


/**
 * 流程审批
 *
 * @author lzq
 */
public class ApprovalProcess {


    private int id;
    private int hid;//医院id
    private int create_profile;//创建人id
    private int type;//流程类型   0 医院延期  1 医院超量
    private int approval;//审批状态   0 未提交  1 审批中  2 已拒绝 3 已完成
    private int approval_profile;//当前审批人  1   2  3  4
    private int attchid;//文件id
    private int yqlb;//延期类别  哪一个文件需要延期   0 1 2 3	public static String[] dqzjArr = {"辐射安全许可证","放射性药品使用许可证","放射诊疗许可证","转让审批表"};
    private String bq;//补充多少量
    private Date yqrq;//延期日期
    private String reason;//申请原因
    private String refuse_reason;//拒绝原因





    public ApprovalProcess(int id) {
        this.id = id;
    }

    public static ApprovalProcess find(int id) {

        ArrayList<ApprovalProcess> list = find(" AND id = " + id, 0, 1);
        ApprovalProcess activityWarning = list.size() < 1 ? new ApprovalProcess(id) : list.get(0);
        return activityWarning;
    }

    public static ArrayList<ApprovalProcess> find(String sql, int pos, int size) {
        ArrayList<ApprovalProcess> list = new ArrayList<ApprovalProcess>();
        DbAdapter db = new DbAdapter();
        String QSql = "select id,hid,create_profile,type,approval,approval_profile,attchid,yqlb,bq,yqrq,reason,refuse_reason from approval_process where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(QSql, pos, size);
            while (rs.next()) {
                int i = 1;
                ApprovalProcess h = new ApprovalProcess(rs.getInt(i++));
                h.setHid(rs.getInt(i++));
                h.setCreate_profile(rs.getInt(i++));
                h.setType(rs.getInt(i++));
                h.setApproval(rs.getInt(i++));
                h.setApproval_profile(rs.getInt(i++));
                h.setAttchid(rs.getInt(i++));
                h.setYqlb(rs.getInt(i++));
                h.setBq(rs.getString(i++));
                h.setYqrq(db.getDate(i++));
                h.setReason(rs.getString(i++));
                h.setRefuse_reason(rs.getString(i++));
                list.add(h);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return list;
    }

    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("select count(0) from approval_process where 1=1 " + sql);
    }


    public void set() throws SQLException {
        String sql = "";
        if(id<1){
            sql = "insert into approval_process(id,hid,create_profile,type,approval,approval_profile,attchid,yqlb,bq,yqrq,reason,refuse_reason) values(" + (this.id = Seq.get()) + "," + hid + "," + create_profile +  ","+type+","+approval+","+approval_profile+","+attchid+","+yqlb+","+Database.cite(bq)+","+Database.cite(yqrq)+","+Database.cite(reason)+","+Database.cite(refuse_reason)+")";
        }else {
             sql = "update approval_process set hid=" + hid + ",create_profile=" + create_profile + ",type=" +type + ",approval=" + approval + ",approval_profile=" + approval_profile + ",attchid=" + attchid + ",yqlb="+yqlb+",bq="+Database.cite(bq)+",yqrq="+Database.cite(yqrq)+",reason="+Database.cite(reason)+",refuse_reason="+Database.cite(refuse_reason)+" where id=" + this.id;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.id, sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
    }


    public int getHid() {
        return hid;
    }

    public void setHid(int hid) {
        this.hid = hid;
    }

    public int getCreate_profile() {
        return create_profile;
    }

    public void setCreate_profile(int create_profile) {
        this.create_profile = create_profile;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getApproval() {
        return approval;
    }

    public void setApproval(int approval) {
        this.approval = approval;
    }

    public int getApproval_profile() {
        return approval_profile;
    }

    public void setApproval_profile(int approval_profile) {
        this.approval_profile = approval_profile;
    }

    public int getAttchid() {
        return attchid;
    }

    public void setAttchid(int attchid) {
        this.attchid = attchid;
    }

    public int getYqlb() {
        return yqlb;
    }

    public void setYqlb(int yqlb) {
        this.yqlb = yqlb;
    }

    public String getBq() {
        return bq;
    }

    public void setBq(String bq) {
        this.bq = bq;
    }

    public Date getYqrq() {
        return yqrq;
    }

    public void setYqrq(Date yqrq) {
        this.yqrq = yqrq;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getRefuse_reason() {
        return refuse_reason;
    }

    public void setRefuse_reason(String refuse_reason) {
        this.refuse_reason = refuse_reason;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
