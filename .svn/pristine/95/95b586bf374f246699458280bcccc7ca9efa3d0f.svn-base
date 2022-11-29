package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * 服务费详细表
 */
public class ServiceFeeInfo {
    protected static Cache c = new Cache(50);
    private int zid;        // 主键
    private int fid;        // 父id
    private int oid;        // 订单id
    private float money;    // 计提服务费(订单金额)
    private int tax;        // 税金类型
    private float taxMoney; // 税金

    public ServiceFeeInfo() {
    }

    public ServiceFeeInfo(int zid) {
        this.zid = zid;
    }

    /**
     * 根据id查询
     * @param zid
     * @return
     */
    public static ServiceFeeInfo find(int zid){
        ServiceFeeInfo sf = (ServiceFeeInfo) c.get(zid);
        if(sf==null){
            ArrayList<ServiceFeeInfo> list = (ArrayList<ServiceFeeInfo>) find(" AND zid = " + zid, 0, 1);
            sf = list.size() < 1 ? new ServiceFeeInfo(zid):list.get(0);
        }
        return sf;
    }


    /**
     * 分页查询所有
     * @param sql
     * @param pos
     * @param page_size
     * @return
     */
    public static ArrayList<ServiceFeeInfo> find(String sql, int pos, int page_size){
        ArrayList<ServiceFeeInfo> sfList = new ArrayList<ServiceFeeInfo>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select zid,fid,oid,money,tax,taxMoney from serviceFeeInfo where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()){
                int i = 1;
                ServiceFeeInfo sf = new ServiceFeeInfo(rs.getInt(i++));
                sf.setFid(rs.getInt(i++));
                sf.setOid(rs.getInt(i++));
                sf.setMoney(rs.getFloat(i++));
                sf.setTax(rs.getInt(i++));
                sf.setTaxMoney(rs.getInt(i++));
                c.put(sf.zid,sf);
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

    // 保存记录
    public void set() throws SQLException {
        String sql = "insert into serviceFeeInfo(zid,fid,oid,money,tax,taxMoney) values("+
                (this.zid = Seq.get()) + "," +
                this.fid + "," +
                this.oid + "," +
                this.money + "," +
                this.tax + "," +
                this.taxMoney
                +")";
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.zid,sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        c.remove(this.zid);

    }

    public int getZid() {
        return zid;
    }

    public void setZid(int zid) {
        this.zid = zid;
    }

    public int getFid() {
        return fid;
    }

    public void setFid(int fid) {
        this.fid = fid;
    }

    public int getOid() {
        return oid;
    }

    public void setOid(int oid) {
        this.oid = oid;
    }

    public float getMoney() {
        return money;
    }

    public void setMoney(float money) {
        this.money = money;
    }

    public int getTax() {
        return tax;
    }

    public void setTax(int tax) {
        this.tax = tax;
    }

    public float getTaxMoney() {
        return taxMoney;
    }

    public void setTaxMoney(float taxMoney) {
        this.taxMoney = taxMoney;
    }
}
