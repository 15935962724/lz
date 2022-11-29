package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Seq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class Consignee {
    protected static Cache c = new Cache(50);
    private int id; //主键id
    private int member;//账户id
    private String name;//收件人姓名
    private String mobile;//手机号
    private int city;//城市
    private String address;//详细地址
    private String youbian;//邮编
    private int ismoren; //是否默认1为默认
    private String mail;//邮箱
    private int xuanzhong;//手机版选中

    public Consignee(int id) {
        this.id = id;
    }

    /**
     * 根据id查询
     *
     * @param
     * @return
     */
    public static Consignee find(int id) throws SQLException {
        Consignee sf = (Consignee) c.get(id);
        if (sf == null) {
            List<Consignee> list = find(" AND id = " + id, 0, 1);
            sf = list.size() < 1 ? new Consignee(id) : list.get(0);
        }
        return sf;
    }


    /**
     * 分页查询所有
     *
     * @param sql
     * @param pos
     * @param page_size
     * @return
     */
    public static List<Consignee> find(String sql, int pos, int page_size) throws SQLException {
        List<Consignee> sfList = new ArrayList<Consignee>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,name,mobile,address,ismoren,member,youbian,city,mail,xuanzhong from tb_Consignee where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()) {
                int i = 1;
                Consignee sf = new Consignee(rs.getInt(i++));
                sf.setName(rs.getString(i++));
                sf.setMobile(rs.getString(i++));
                sf.setAddress(rs.getString(i++));
                sf.setIsmoren(rs.getInt(i++));
                sf.setMember(rs.getInt(i++));
                sf.setYoubian(rs.getString(i++));
                sf.setCity(rs.getInt(i++));
                sf.setMail(rs.getString(i++));
                sf.setXuanzhong(rs.getInt(i++));
                c.put(sf.id,sf);
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

    public int set() throws SQLException{
        String sql;
        if (id < 1){
            sql = "INSERT INTO tb_Consignee(id,name,mobile,address,ismoren,member,youbian,city,mail,xuanzhong)VALUES(" + (id = Seq.get()) +","+ DbAdapter.cite(name) +","+ DbAdapter.cite(mobile) +","+ DbAdapter.cite(address)+","+ismoren+ ","+member+","+DbAdapter.cite(youbian)+","+city+","+DbAdapter.cite(mail)+","+xuanzhong+")";
        } else {
            sql = "UPDATE tb_Consignee SET name=" + DbAdapter.cite(name) + ",mobile=" + DbAdapter.cite(mobile) + ",address=" + DbAdapter.cite(address) + ",ismoren=" + ismoren + ",member=" + member + ",youbian=" + DbAdapter.cite(youbian) + ",city=" + city + ",mail="+DbAdapter.cite(mail)+",xuanzhong="+xuanzhong+" WHERE id=" + id;
        }
        DbAdapter db = new DbAdapter();
        try{
            db.executeUpdate(id, sql);
        } finally{
            db.close();
        }
        c.remove(id);
        return id;
    }

    public static void delete(String ids){
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("DELETE FROM tb_Consignee WHERE id in(" + ids + ")");
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            db.close();
        }
        String[] arr = ids.split(",");
        for(int i=0;i<arr.length;i++){
            c.remove(arr[i]);
        }
    }

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

    public int getIsmoren() {
        return ismoren;
    }

    public void setIsmoren(int ismoren) {
        this.ismoren = ismoren;
    }

    public int getMember() {
        return member;
    }

    public void setMember(int member) {
        this.member = member;
    }

    public int getCity() {
        return city;
    }

    public void setCity(int city) {
        this.city = city;
    }

    public String getYoubian() {
        return youbian;
    }

    public void setYoubian(String youbian) {
        this.youbian = youbian;
    }

    public static Cache getC() {
        return c;
    }

    public static void setC(Cache c) {
        Consignee.c = c;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public int getXuanzhong() {
        return xuanzhong;
    }

    public void setXuanzhong(int xuanzhong) {
        this.xuanzhong = xuanzhong;
    }
}
