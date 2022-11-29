package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 君安按年份记录
 */
public class JaYearConfig {
    protected static Cache c = new Cache(50);

    public int id;//
    public String year;//
    public int num;//

    public JaYearConfig() {
    }

    public JaYearConfig(int id) {
        this.id = id;
    }

    public static JaYearConfig find(int id){
        JaYearConfig aShopPackage = (JaYearConfig)c.get(id);
        if(aShopPackage == null){
            List<JaYearConfig> list = find(" AND id = " + id, 0, 1);
            aShopPackage = list.size() < 1 ? new JaYearConfig(id):list.get(0);
        }
        return aShopPackage;
    }

    public static JaYearConfig findYear(String year){
        JaYearConfig aShopPackage = (JaYearConfig)c.get(0);
        if(aShopPackage == null){
            List<JaYearConfig> list = find(" AND year = " + Database.cite(year), 0, 1);
            aShopPackage = list.size() < 1 ? new JaYearConfig(0):list.get(0);
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
    public static List<JaYearConfig> find(String sql, int pos, int size){
        ArrayList<JaYearConfig> soList = new ArrayList<JaYearConfig>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,year,num from JaYearConfig where 1=1" + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, size);
            while (rs.next()){
                int i=1;
                JaYearConfig so = new JaYearConfig(rs.getInt(i++));
                so.year = rs.getString(i++);
                so.num = rs.getInt(i++);
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
        return DbAdapter.execute("select count(0) from JaYearConfig where 1=1" + sql);
    }

    /**
     * 添加or修改库存信息
     * @throws SQLException
     */
    public void set() throws SQLException{
        String sql = "";
        if(this.id < 1){
            id = Seq.get();
            sql = "insert into JaYearConfig(id,year,num) values("+id+","+Database.cite(year)+","+num+")";
        }else{
            sql = "update JaYearConfig set year="+Database.cite(year)+",num="+num+" where psid=" + this.id;
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }
}
