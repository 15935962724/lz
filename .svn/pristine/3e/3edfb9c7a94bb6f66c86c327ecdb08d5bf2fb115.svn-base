package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;
import util.Config;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;


public class Areas {

    private int id; //省份的id
    private String name;//省份中午名称




    public Areas(int id) {
        this.id = id;
    }









    public static List<Areas> find(String sql, int pos, int page_size) throws SQLException {
        List<Areas> sfList = new ArrayList<Areas>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,name from Areas where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()) {
                int i = 1;
                Areas sf = new Areas(rs.getInt(i++));
                sf.setName(rs.getString(i++));
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

/*    public int set() throws SQLException {
        String sql;
        if (id < 1) {
            sql = "INSERT INTO tb_jihuoCode(id,code,time,usetype,type,member,mail,type_child)VALUES("+(id=Seq.get())+","+DbAdapter.cite(code)+","+DbAdapter.cite(new Date())+","+usetype+","+type+","+member+","+DbAdapter.cite(mail)+","+type_child+")";
        } else {
            sql = "UPDATE tb_jihuoCode SET code=" + DbAdapter.cite(code) + ",time=" + DbAdapter.cite(new Date()) + ",usetype=" +usetype+ ",type=" + type + ",member=" + member + ",mail="+DbAdapter.cite(mail)+",type_child="+type_child+" WHERE id=" + id;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(id, sql);
        } finally {
            db.close();
        }
        c.remove(id);
        return id;
    }*/

 /*   public static void delete(String ids) {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("DELETE FROM tb_jihuoCode WHERE id in(" + ids + ")");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        String[] arr = ids.split(",");
        for (int i = 0; i < arr.length; i++) {
            c.remove(arr[i]);
        }
    }
*/
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
