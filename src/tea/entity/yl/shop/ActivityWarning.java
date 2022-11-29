package tea.entity.yl.shop;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import tea.db.DbAdapter;
import tea.entity.Database;
import tea.entity.Seq;


/**
 * 活度预警
 *
 * @author lzq
 */
public class ActivityWarning {


    private int id;
    private String name;//医院名称
    private String warning;//预警值
    private String warning2;//警戒值
    private String stop;//停货值
    private String yjptdh;//预警平台电话
    private String yjyydh;//预警医院电话


    public ActivityWarning(int id) {
        this.id = id;
    }

    public static ActivityWarning find(int id) {

        ArrayList<ActivityWarning> list = find(" AND id = " + id, 0, 1);
        ActivityWarning activityWarning = list.size() < 1 ? new ActivityWarning(id) : list.get(0);
        return activityWarning;
    }

    public static ArrayList<ActivityWarning> find(String sql, int pos, int size) {
        ArrayList<ActivityWarning> list = new ArrayList<ActivityWarning>();
        DbAdapter db = new DbAdapter();
        String QSql = "select id,name,warning,warning2,stop,yjptdh,yjyydh from activity_warning where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(QSql, pos, size);
            while (rs.next()) {
                int i = 1;
                ActivityWarning h = new ActivityWarning(rs.getInt(i++));
                h.setName(rs.getString(i++));
                h.setWarning(rs.getString(i++));
                h.setWarning2(rs.getString(i++));
                h.setStop(rs.getString(i++));
                h.setYjptdh(rs.getString(i++));
                h.setYjyydh(rs.getString(i++));
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
        return DbAdapter.execute("select count(0) from activity_warning where 1=1 " + sql);
    }

    public void insert() {
       String sql = "insert into activity_warning(id,name,warning,warning2,stop,yjptdh,yjyydh) values(" + (id) + "," + DbAdapter.cite(name) + "," + DbAdapter.cite(warning) +  ","+Database.cite(warning2)+","+Database.cite(stop)+","+Database.cite(yjptdh)+","+Database.cite(yjyydh)+")";
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
        String sql = "update activity_warning set name="+Database.cite(name)+",warning="+Database.cite(warning)+",warning2="+Database.cite(warning2)+",stop="+Database.cite(stop)+",yjptdh="+Database.cite(yjptdh)+",yjyydh="+Database.cite(yjyydh)+" where id=" + this.id;
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.id, sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
    }

    /*
    * 查询是否需要调过质量负责人
    * */
    public static Boolean jumpQualityDirecter(){
        ActivityWarning activityWarning = ActivityWarning.find(2022);
        return activityWarning.getStop().equals("1");
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getWarning() {
        return warning;
    }

    public void setWarning(String warning) {
        this.warning = warning;
    }

    public String getWarning2() {
        return warning2;
    }

    public void setWarning2(String warning2) {
        this.warning2 = warning2;
    }

    public String getStop() {
        return stop;
    }

    public void setStop(String stop) {
        this.stop = stop;
    }

    public String getYjptdh() {
        return yjptdh;
    }

    public void setYjptdh(String yjptdh) {
        this.yjptdh = yjptdh;
    }

    public String getYjyydh() {
        return yjyydh;
    }

    public void setYjyydh(String yjyydh) {
        this.yjyydh = yjyydh;
    }
}
