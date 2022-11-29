package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

/**
 * 匹配服务费记录表
 */
public class ServiceFeeRecord {
    protected static Cache c = new Cache(50);
    private int fid;            // 主键
    private int profile;        // 服务商id
    private float totalMoney;   // 发票总金额
    private ArrayList<Integer> invoiceArray; // 发票id集合
    private String describe;    // 描述
    private Date time;          // 操作时间
    private int member;         // 操作人
    private int puid;           // 厂商
    private String oids;//发票id

    public ServiceFeeRecord() {
    }

    public ServiceFeeRecord(int fid) {
        this.fid = fid;
    }

    /**
     * 分页查询所有
     * @param sql
     * @param pos
     * @param page_size
     * @return
     */
    public static ArrayList<ServiceFeeRecord> find(String sql, int pos, int page_size){
        ArrayList<ServiceFeeRecord> sflist = new ArrayList<ServiceFeeRecord>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select fid,profile,totalMoney,invoiceArray,describe,time,member,puid,oids from serviceFeeRecord where 1=1" + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()){
                int i = 1;
                ServiceFeeRecord sfr = new ServiceFeeRecord(rs.getInt(i++));
                sfr.setProfile(rs.getInt(i++));
                sfr.setTotalMoney(rs.getFloat(i++));
                String string = rs.getString(i++);
                ArrayList<Integer> list = new ArrayList<Integer>();
                String[] split = string.split(",");
                for (String s : split) {
                    list.add(Integer.parseInt(s));
                }
                sfr.setInvoiceArray(list);
                sfr.setDescribe(rs.getString(i++));
                sfr.setTime(rs.getDate(i++));
                sfr.setMember(rs.getInt(i++));
                sfr.setPuid(rs.getInt(i++));
                sfr.setOids(rs.getString(i++));
                c.put(sfr.fid,sfr);
                sflist.add(sfr);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return sflist;
    }

    /**
     * 根据id查询
     * @param fid
     * @return
     */
    public static ServiceFeeRecord find(int fid){
        ServiceFeeRecord sfr = (ServiceFeeRecord) c.get(fid);
        if(sfr==null){
            ArrayList<ServiceFeeRecord> list = (ArrayList<ServiceFeeRecord>) find(" AND fid = " + fid, 0, 1);
            sfr = list.size() < 1 ? new ServiceFeeRecord(fid):list.get(0);
        }
        return sfr;
    }

    /**
     * 添加记录
     */
    public void set() throws SQLException {
        String oids1 = "";
        for (int i = 0; i < this.invoiceArray.size(); i++) {
            if(i==0){
                oids1+=this.invoiceArray.get(i);
            }else{
                oids1+=",";
                oids1+=this.invoiceArray.get(i);
            }
        }
        String sql = "insert into serviceFeeRecord(fid,profile,totalMoney,invoiceArray,describe,time,member,puid,oids) values("+
                (this.fid = Seq.get()) + "," +
                this.profile + "," +
                this.totalMoney + "," +
                DbAdapter.cite(oids1) + "," +
                DbAdapter.cite(this.describe) + "," +
                DbAdapter.cite(this.time) + "," +
                this.member +","+
                this.puid
                +","+ Database.cite(oids) +")";
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.fid,sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        c.remove(this.fid);

    }
    

    public int getFid() {
        return fid;
    }

    public void setFid(int fid) {
        this.fid = fid;
    }

    public int getProfile() {
        return profile;
    }

    public void setProfile(int profile) {
        this.profile = profile;
    }

    public float getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(float totalMoney) {
        this.totalMoney = totalMoney;
    }

    public ArrayList<Integer> getInvoiceArray() {
        return invoiceArray;
    }

    public void setInvoiceArray(ArrayList<Integer> invoiceArray) {
        this.invoiceArray = invoiceArray;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getMember() {
        return member;
    }

    public void setMember(int member) {
        this.member = member;
    }

    public int getPuid() {
        return puid;
    }

    public void setPuid(int puid) {
        this.puid = puid;
    }

    public String getOids() {
        return oids;
    }

    public void setOids(String oids) {
        this.oids = oids;
    }
}
