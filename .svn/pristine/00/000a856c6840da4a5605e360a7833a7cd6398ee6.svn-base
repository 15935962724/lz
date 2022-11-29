package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


/**
 * 隐藏医院
 *
 * @author lzq
 */
public class HiddenHospital {


    private int id;
    //医院名称
    private String hospital_name;



    public HiddenHospital(int id) {
        this.id = id;
    }

    public static HiddenHospital find(int id) {

        ArrayList<HiddenHospital> list = find(" AND id = " + id, 0, 1);
        HiddenHospital activityWarning = list.size() < 1 ? new HiddenHospital(id) : list.get(0);
        return activityWarning;
    }

    public static ArrayList<HiddenHospital> find(String sql, int pos, int size) {
        ArrayList<HiddenHospital> list = new ArrayList<HiddenHospital>();
        DbAdapter db = new DbAdapter();
        String QSql = "select id,hospital_name from hiddenHospital where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(QSql, pos, size);
            while (rs.next()) {
                int i = 1;
                HiddenHospital h = new HiddenHospital(rs.getInt(i++));
                h.setHospital_name(rs.getString(i++));
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
        return DbAdapter.execute("select count(0) from hiddenHospital where 1=1 " + sql);
    }

    public void insert() {
       String sql = "insert into hiddenHospital(id,hospital_name) values(" + (id) + "," + DbAdapter.cite(hospital_name) +")";
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.id, sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
    }

    public void update() {
        String sql = "update hiddenHospital set hospital_name="+Database.cite(hospital_name)+" where id=" + this.id;
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.id, sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getHospital_name() {
        return hospital_name;
    }

    public void setHospital_name(String hospital_name) {
        this.hospital_name = hospital_name;
    }
}
