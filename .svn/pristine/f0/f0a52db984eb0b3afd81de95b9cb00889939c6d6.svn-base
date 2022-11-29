package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.*;
import util.EmailEntity;
import util.EmailSend;
import util.XmlUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

/*
 * TPS订单
 * */
public class TpsOrder {
    protected static Cache c = new Cache(50);
    private int id; //主键id
    private int fws_id;//服务商id
    private int hospital_id;//医院id
    private int orderms;//订单支付  1抵扣   2付款
    private int status;//状态  （1已下单、2已推送、3已获取）
    private String order_id;// 订单号
    private String hpcs;//商品次数    几天、几次
    private String xdms;//下单模式    按天、按次
    private String jqm;//机器码     用户提交
    private String jhm;//激活码
    private Date createtime;//下单时间
    private Date jqmtime;//机器码提交时间
    private Date sendtime;//推送邮件时间
    private Date getjhmtime;//获取激活码接口时间
    private String email;//邮箱
    private int consignees_id;//收货人id
    private int send_tps_number;//推送数量
    private int jifen;//扣除积分


    public TpsOrder(int id) {
        this.id = id;
    }


    /**
     * 根据id查询
     *
     * @param
     * @return
     */
    public static TpsOrder find(int id) throws SQLException {
        TpsOrder sf = (TpsOrder) c.get(id);
        if (sf == null) {
            List<TpsOrder> list = find(" AND id = " + id, 0, 1);
            sf = list.size() < 1 ? new TpsOrder(id) : list.get(0);
        }
        return sf;
    }

    /*
     * 查询条数
     * */
    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("SELECT COUNT(*) from tb_tps_order WHERE 1=1 " + sql);
    }

    /*
     * 查询粒子数
     * */
    public static int sumNumber(int profile , String time) throws SQLException {
        return DbAdapter.execute("select SUM(da.quantity) from shopOrderData da , shopOrder so where da.order_id = so.order_id AND so.member="+profile+" AND  createdate>='"+time+"'  AND so.status!=5 AND so.status!=6 " );
    }

    /*
    * 查询tps消耗积分数
    *
    * */
    public static int jianNumber(int profile , String time) throws SQLException {
        return DbAdapter.execute("select SUM(jifen) from tb_tps_order  where fws_id="+profile+" AND  createtime>='"+time+"' " );
    }



    /**
     * 分页查询所有
     *
     * @param sql
     * @param pos
     * @param page_size
     * @return
     */
    public static List<TpsOrder> find(String sql, int pos, int page_size) throws SQLException {
        List<TpsOrder> sfList = new ArrayList<TpsOrder>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select id,fws_id,hospital_id,orderms,status,order_id,hpcs,xdms,jqm,jhm,createtime,jqmtime,sendtime,getjhmtime,email,consignees_id,send_tps_number,jifen from tb_tps_order where 1=1 " + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, page_size);
            while (rs.next()) {
                int i = 1;
                TpsOrder to = new TpsOrder(rs.getInt(i++));
                to.setFws_id(rs.getInt(i++));
                to.setHospital_id(rs.getInt(i++));
                to.setOrderms(rs.getInt(i++));
                to.setStatus(rs.getInt(i++));
                to.setOrder_id(rs.getString(i++));
                to.setHpcs(rs.getString(i++));
                to.setXdms(rs.getString(i++));
                to.setJqm(rs.getString(i++));
                to.setJhm(rs.getString(i++));
                to.setCreatetime(db.getDate(i++));
                to.setJqmtime(db.getDate(i++));
                to.setSendtime(db.getDate(i++));
                to.setGetjhmtime(db.getDate(i++));
                to.setEmail(rs.getString(i++));
                to.setConsignees_id(rs.getInt(i++));
                to.setSend_tps_number(rs.getInt(i++));
                to.setJifen(rs.getInt(i++));
                sfList.add(to);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return sfList;
    }

    public int set() throws SQLException {
        String sql;
        if (id < 1) {
            sql = "INSERT INTO tb_tps_order(id,fws_id,hospital_id,orderms,status,order_id,hpcs,xdms,jqm,jhm,createtime,jqmtime,sendtime,getjhmtime,email,consignees_id,send_tps_number,jifen)VALUES(" + (id = Seq.get()) + "," + fws_id + "," + hospital_id + "," + orderms + "," + status + "," + Database.cite(order_id) + "," + Database.cite(hpcs) + "," + Database.cite(xdms) + "," + Database.cite(jqm) + "," + Database.cite(jhm) + "," + Database.cite(createtime) + "," + Database.cite(jqmtime) + "," + Database.cite(sendtime) + "," + Database.cite(getjhmtime) + "," + Database.cite(email) + "," + consignees_id + ","+send_tps_number+","+jifen+")";
        } else {
            sql = "UPDATE tb_tps_order SET orderms=" + orderms + ",status=" + status + ",hpcs=" + Database.cite(hpcs) + ",xdms=" + Database.cite(xdms) + ",jqm=" + Database.cite(jqm) + ",jhm=" + DbAdapter.cite(jhm) + ",jqmtime=" + Database.cite(jqmtime) + ",sendtime=" + Database.cite(sendtime) + ",getjhmtime=" + Database.cite(getjhmtime) + ",email=" + Database.cite(email) + ",consignees_id=" + consignees_id + ",send_tps_number="+send_tps_number+",jifen="+jifen+" WHERE id=" + id;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(id, sql);
        } finally {
            db.close();
        }
        c.remove(id);
        return id;
    }

    public static void delete(String ids) {
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate("DELETE FROM tb_tps_order WHERE id in(" + ids + ")");
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


    /*
     *
     * 根据tps订单id推送邮件给厂家
     * */
    public static Boolean sendMailToFactory(int id) throws Exception {

        boolean flag = false;
        try {

        TpsOrder tpsOrder = TpsOrder.find(id);
        int sjNumber = 0;//时间天数
        int csNumber = 0;//次数天数
        String sjStr = "0";
        String csStr = "0";
        if (tpsOrder.getXdms().contains("时间")) {
            sjStr = tpsOrder.getSend_tps_number()+"";

        } else {
            csStr = tpsOrder.getSend_tps_number()+"";
        }
        Date createtime = tpsOrder.getCreatetime();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-HH-dd HH:mm:ss");
        String format = simpleDateFormat.format(createtime);
        ShopHospital hospital = ShopHospital.find(tpsOrder.getHospital_id());


        EmailEntity email = new EmailEntity();
        email.setUserName("15935962724@163.com");
        email.setPassword("ZhuGeSiMa123");
        email.setHost("smtp.163.com");
        email.setPort(25);
        email.setFromAddress("15935962724@163.com");
        email.setToAddress("lqylzy@qq.com");
        email.setSubject("获取激活码");
        Map<String, String> data = new HashMap<String, String>();
        data.put("System", "Apsaras Brachy 3");
        data.put("Time", format);
        data.put("HospitalName", hospital.getName());
        data.put("Deadline", sjStr);
        data.put("CaseNumber", csStr);
        data.put("SerialNumber", tpsOrder.getJqm());
        data.put("url", "https://www.brachysolution.com/sendKeyToLiZi.do ");
        data.put("orderItemId", id + "");
        String content = XmlUtil.mapToXmlRequest(data).toString();
        System.out.println(content);
        email.setContext(content);
        email.setContextType("text/html;charset=utf-8");
        flag = EmailSend.EmailSendTest(email);
        Filex.logs("nodelete/log/" + MT.f(new Date()) + ".txt", String.valueOf(id) + "---推送服务商邮件结果：" + flag);
        } catch (SQLException e) {
            flag = false;
            Filex.logs("nodelete/log/" + MT.f(new Date()) + ".txt", String.valueOf(id) +e.getMessage());
            e.printStackTrace();
        }
        return flag;
    }


    /*
     *
     * 根据tps订单id推送邮件给医生
     * */
    public static Boolean sendMailToHospital(int id) {
        boolean flag = false;
        try {
            TpsOrder tpsOrder = TpsOrder.find(id);
            EmailEntity email = new EmailEntity();
            email.setUserName("id219142128@163.com");
            email.setPassword("1993819");
            email.setHost("smtp.163.com");
            email.setPort(25);
            email.setFromAddress("id219142128@163.com");
            email.setToAddress(tpsOrder.getEmail());
            email.setSubject("发货通知");
            String content = "你购买的“放射植入治疗三维计划系统”产品，购买规格“"+tpsOrder.getHpcs()+"”，购买数量1，请下载附件获取你的激活码";
            System.out.println(content);
            email.setContext(content);
            email.setContextType("text/html;charset=utf-8");
            email.attachFile("nodelete/tpsid/" + id + ".txt"); // 往邮件中添加附件
            flag = EmailSend.EmailSendTest(email);
            Filex.logs("nodelete/log/" + MT.f(new Date()) + ".txt", String.valueOf(id) + "---推送医院邮件结果：" + flag);

            if (flag) {//推送成功
                tpsOrder.setSendtime(new Date());
                tpsOrder.setJhm(tpsOrder.getJhm());
                tpsOrder.setGetjhmtime(new Date());
                tpsOrder.setStatus(3);
                tpsOrder.set();
                tpsOrder.set();
            }
        } catch (SQLException e) {
            flag = false;
            Filex.logs("nodelete/log/" + MT.f(new Date()) + ".txt", String.valueOf(id) +e.getMessage());
            e.printStackTrace();
        }
        return flag;

    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFws_id() {
        return fws_id;
    }

    public void setFws_id(int fws_id) {
        this.fws_id = fws_id;
    }

    public int getHospital_id() {
        return hospital_id;
    }

    public void setHospital_id(int hospital_id) {
        this.hospital_id = hospital_id;
    }

    public int getOrderms() {
        return orderms;
    }

    public void setOrderms(int orderms) {
        this.orderms = orderms;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public String getHpcs() {
        return hpcs;
    }

    public void setHpcs(String hpcs) {
        this.hpcs = hpcs;
    }

    public String getXdms() {
        return xdms;
    }

    public void setXdms(String xdms) {
        this.xdms = xdms;
    }

    public String getJqm() {
        return jqm;
    }

    public void setJqm(String jqm) {
        this.jqm = jqm;
    }

    public String getJhm() {
        return jhm;
    }

    public void setJhm(String jhm) {
        this.jhm = jhm;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Date getJqmtime() {
        return jqmtime;
    }

    public void setJqmtime(Date jqmtime) {
        this.jqmtime = jqmtime;
    }

    public Date getSendtime() {
        return sendtime;
    }

    public void setSendtime(Date sendtime) {
        this.sendtime = sendtime;
    }

    public Date getGetjhmtime() {
        return getjhmtime;
    }

    public void setGetjhmtime(Date getjhmtime) {
        this.getjhmtime = getjhmtime;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getConsignees_id() {
        return consignees_id;
    }

    public void setConsignees_id(int consignees_id) {
        this.consignees_id = consignees_id;
    }

    public int getSend_tps_number() {
        return send_tps_number;
    }

    public void setSend_tps_number(int send_tps_number) {
        this.send_tps_number = send_tps_number;
    }

    public int getJifen() {
        return jifen;
    }

    public void setJifen(int jifen) {
        this.jifen = jifen;
    }
}
