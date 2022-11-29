package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;
import tea.entity.yl.shopnew.Invoice;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 服务费发票
 */
public class ServiceInvoice {
    protected static Cache c = new Cache(50);

    private int sid;                // 主键
    private String invoiceCode;     // 发票号
    private int profile;            // 服务商(关联用户id)
    private float money;            // 金额
    private Date time;              // 时间
    private int puid;               // 厂商关联id
    private int type;               // 类型 0,新增 1,结余
    private int fid;                // 记录id
    private int state;              // 状态 0,未使用 1,已使用
    private int puj_id;             //服务商公司对应ProcurementUnitJoin   jid

    public ServiceInvoice() {
    }
    public ServiceInvoice(int sid) {
        this.sid = sid;
    }


    /**
     * 查询所有
     * @param sql

     * @param pos
     * @param page_size
     * @return
     */
    public static List<ServiceInvoice> find(String sql, int pos, int page_size) {
        ArrayList<ServiceInvoice> siList = new ArrayList<ServiceInvoice>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select sid,invoiceCode,profile,money,time,puid,type,fid,state,puj_id from serviceCharge where 1=1"+ sql;
        try {
            ResultSet rs = db.executeQuery(SQsql,pos,page_size);
            while (rs.next()){
                int i = 1;
                ServiceInvoice si = new ServiceInvoice(rs.getInt(i++));
                si.setInvoiceCode(rs.getString(i++));
                si.setProfile(rs.getInt(i++));
                si.setMoney(rs.getFloat(i++));
                si.setTime(rs.getDate(i++));
                si.setPuid(rs.getInt(i++));
                si.setType(rs.getInt(i++));
                si.setFid(rs.getInt(i++));
                si.setState(rs.getInt(i++));
                si.setPuj_id(rs.getInt(i++));
                c.put(si.sid,si);
                siList.add(si);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return siList;
    }

    /**
     * 根据id查询
     * @param sid
     * @return
     */
    public static ServiceInvoice find(int sid){
        ServiceInvoice si = (ServiceInvoice) c.get(sid);
        if(si == null){
            ArrayList<ServiceInvoice> list = (ArrayList<ServiceInvoice>) find(" AND sid = " + sid, 0, 1);
            si = list.size() < 1 ? new ServiceInvoice(sid):list.get(0);
        }
        return si;
    }

    // 添加||修改发票
    public void set() throws SQLException {
        String sql = "";
        if(this.sid < 1){
            sql = "insert into serviceCharge(sid,invoiceCode,profile,money,time,puid,type,fid,state,puj_id) values("
                    + (this.sid = Seq.get()) + ","
                    + DbAdapter.cite(this.invoiceCode) + ","
                    + this.profile + ","
                    + this.money + ","
                    + DbAdapter.cite(this.time) + ","
                    + this.puid + ","
                    + this.type + ","
                    + this.fid + ","
                    + this.state +","
                    +this.puj_id+
            ")";
        }else{
            sql = "update serviceCharge set invoiceCode=" + DbAdapter.cite(this.invoiceCode) +
                    ",profile=" + this.profile +
                    ",money=" + this.money +
                    ",time=" + DbAdapter.cite(this.time) +
                    ",puid=" + this.puid +
                    ",type=" + this.type +
                    ",fid=" + this.fid +
                    ",state=" + this.state +
                    ",puj_id="+this.puj_id+
                    " where sid=" + this.sid;
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
     * 删除
     * @param sid
     */
    public static void delete(int sid){
        String sql = "delete from serviceCharge where sid=" + sid;
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
    }

    /**
     * 查询发票数量
     * @param sql
     * @return
     * @throws SQLException
     */
    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("select count(0) from serviceCharge where 1=1 " + sql);
    }

    /**
     *
     * @return
     */
    public static ServiceInvoice findOldSi(int invoiceid){
        ServiceInvoice si = ServiceInvoice.find(0);
        Invoice invoice = Invoice.find(invoiceid);//发票

        List<ServiceInvoice> invoiceList = ServiceInvoice.find(" AND oids like "+ Database.cite("%"+invoiceid+"%"),0,1);
        if(invoiceList.size()>0){
            si = invoiceList.get(0);
        }
        return si;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public String getInvoiceCode() {
        return invoiceCode;
    }

    public void setInvoiceCode(String invoiceCode) {
        this.invoiceCode = invoiceCode;
    }

    public int getProfile() {
        return profile;
    }

    public void setProfile(int profile) {
        this.profile = profile;
    }

    public float getMoney() {
        return money;
    }

    public void setMoney(float money) {
        this.money = money;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getPuid() {
        return puid;
    }

    public void setPuid(int puid) {
        this.puid = puid;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getFid() {
        return fid;
    }

    public void setFid(int fid) {
        this.fid = fid;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getPuj_id() {
        return puj_id;
    }

    public void setPuj_id(int puj_id) {
        this.puj_id = puj_id;
    }
}
