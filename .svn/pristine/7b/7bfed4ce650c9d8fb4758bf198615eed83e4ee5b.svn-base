package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 君安分批记录表
 */
public class ShopOrderDatasBatches {
    protected static Cache c = new Cache(50);

    public int id;//
    public String batchnumber;//批次编号
    public int batchnumbercode;//批次编号
    public float activity;//活度
    public int number;//数量
    public String ordercode;//订单编号
    public String soid;//对应库存记录id
    public Date time;//时间

    public ShopOrderDatasBatches() {
    }

    public ShopOrderDatasBatches(int id) {
        this.id = id;
    }

    public static ShopOrderDatasBatches find(int id){
        ShopOrderDatasBatches aShopPackage = (ShopOrderDatasBatches)c.get(id);
        if(aShopPackage == null){
            List<ShopOrderDatasBatches> list = find(" AND id = " + id, 0, 1);
            aShopPackage = list.size() < 1 ? new ShopOrderDatasBatches(id):list.get(0);
        }
        return aShopPackage;
    }

    /**
     * 查询所有
     * @param sql
     * @param pos
     * @param size
     * @return
     */
    public static List<ShopOrderDatasBatches> find(String sql, int pos, int size){
        ArrayList<ShopOrderDatasBatches> soList = new ArrayList<ShopOrderDatasBatches>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,batchnumber,activity,number,ordercode,soid,time,batchnumbercode from ShopOrderDatasBatches where 1=1" + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, size);
            while (rs.next()){
                int i=1;
                ShopOrderDatasBatches so = new ShopOrderDatasBatches(rs.getInt(i++));
                so.batchnumber = db.getString(i++);
                so.activity = db.getFloat(i++);
                so.number = db.getInt(i++);
                so.ordercode = db.getString(i++);
                so.soid = db.getString(i++);
                so.time = db.getDate(i++);
                so.batchnumbercode = db.getInt(i++);
                c.put(so.id,so);
                soList.add(so);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return soList;
    }

    /**
     * 查询数量
     * @param sql
     * @return
     */
    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("select count(0) from ShopOrderDatasBatches where 1=1" + sql);
    }

    /**
     * 添加or修改库存信息
     * @throws SQLException
     */
    public void set() throws SQLException{
        String sql = "";
        if(this.id < 1){
            id = Seq.get();
            sql = "insert into ShopOrderDatasBatches(id,batchnumber,activity,number,ordercode,soid,time,batchnumbercode) values("+id+","+Database.cite(batchnumber)+","+activity+","+number+","+Database.cite(ordercode)+","+Database.cite(soid)+","+Database.cite(time)+","+batchnumbercode+")";
        }else{
            sql = "update ShopOrderDatasBatches set batchnumber="+Database.cite(batchnumber)+",activity="+activity+",number="+number+",ordercode="+Database.cite(ordercode)+",soid="+Database.cite(soid)+",time="+Database.cite(time)+",batchnumbercode="+batchnumbercode+" where id=" + this.id;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.id, sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            db.close();
        }
        c.remove(this.id);
    }

    public void delete(){
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.id,"delete from ShopOrderDatasBatches where id= " + this.id);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            db.close();
        }
        c.remove(this.id);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBatchnumber() {
        return batchnumber;
    }

    public void setBatchnumber(String batchnumber) {
        this.batchnumber = batchnumber;
    }

    public float getActivity() {
        return activity;
    }

    public void setActivity(float activity) {
        this.activity = activity;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getOrdercode() {
        return ordercode;
    }

    public void setOrdercode(String ordercode) {
        this.ordercode = ordercode;
    }

    public String getSoid() {
        return soid;
    }

    public void setSoid(String soid) {
        this.soid = soid;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getBatchnumbercode() {
        return batchnumbercode;
    }

    public void setBatchnumbercode(int batchnumbercode) {
        this.batchnumbercode = batchnumbercode;
    }
}
