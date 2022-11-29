package tea.entity.yl.shop;

import tea.db.DbAdapter;
import tea.entity.Database;
import tea.entity.MT;
import tea.entity.Seq;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 库存管理
 */
public class ProductStock {

    public int psid; // 主键id
    public int cid; // 类别id;
    public String quality; // 质检号
    public String batch; // 批号
    public float activity; // 入库活度
    public int amount; // 库存
    public Date createtime; // 创建时间检验时间入库日期
    public int reserve; // 预留数量

    public Date time;//平台入库日期

    public int ordernum;//下单数量 新用于记录库存

    public static String [] ProductStockField = {"","quality","batch","createtime","activity","time","amount"};

    /**
     * 根据psid删除
     * @param psid
     */
    public static void del(int psid) {
        DbAdapter db = new DbAdapter();
        try {
            String sql= "delete from productStock where psid="+psid;
            db.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.close();
        }

    }

    /**
     * 根据活度区间查询区间数量
     * @param activity  活度
     * @param perce     上下浮动
     * @type type       状态 1,查库存和预留   0,只查库存
     * @return
     */
    public static int findStock(double activity,double perce,int type,Date date,int numtype){
        DbAdapter db = new DbAdapter();
        DecimalFormat df = new DecimalFormat("0.0000");// 保留小数点后四位
        df.setMaximumFractionDigits(4);
        double v1 = Double.parseDouble(df.format(activity + activity * perce));
        double v2 = Double.parseDouble(df.format(activity - activity * perce));
        System.out.println("v1="+v1+"---"+"v2="+v2);
        try {
            List<ProductStock> list = find(" AND amount > 0", 0, Integer.MAX_VALUE);// MAX_VALUE 不限制条数
            //System.out.println("list="+list.size());
            int total = 0;
            if(type==1){
                for (ProductStock p : list) {
                    Date createtime = p.getCreatetime(); // 入库时间
                    long time1 = createtime.getTime();
                    long time2 = date.getTime();
                    long T = (time2 - time1) / (1000 * 3600 * 24); // 获得从入库时间到现在的时间
                    //double pow = Math.pow(Math.E, -(0.693 / 59.6 * T)) * p.getActivity(); // 获取当前活度
                    double powsum = Math.pow(0.9884, T);
                    BigDecimal b   =   new   BigDecimal(powsum);
                    double  f1   =   b.setScale(4,   RoundingMode.HALF_UP).doubleValue();
                    double pow  = (p.getActivity()*f1);//公式修改
                    if(T==0){
                        pow = Double.valueOf(String.valueOf(p.getActivity()));
                    }
                    if(pow>v2 && pow<v1){ // 判断当前活度是否符合要求
                        total+=p.amount;
                        total+=p.reserve;
                        if(numtype==0){
                            total-=p.getOrdernum();//减去
                        }
                        System.out.println("---v1="+pow+"total="+total);
                    }
                }

            }else if(type==0){
                for (ProductStock p : list) {
                    Date createtime = p.getCreatetime(); // 入库时间
                    long time1 = createtime.getTime();
                    long time2 = date.getTime();
                    long T = (time2 - time1) / (1000 * 3600 * 24); // 获得从入库时间到现在的时间
                    //double pow = Math.pow(Math.E, -(0.693 / 59.6 * T)) * p.getActivity(); // 获取当前活度
                    double powsum = Math.pow(0.9884, T);
                    BigDecimal b   =   new   BigDecimal(powsum);
                    double  f1   =   b.setScale(4,   RoundingMode.HALF_UP).doubleValue();
                    double pow  = (p.getActivity()*f1);//公式修改
                    if(T==0){
                        pow = Double.valueOf(String.valueOf(p.getActivity()));
                    }
                    System.out.println("---v1="+v1+"v2="+v2+"pow"+pow);
                    if(pow>v2 && pow<v1){ // 判断当前活度是否符合要求
                        total+=p.amount;
                        System.out.println(p.getPsid()+"=="+p.amount+"=="+p.getOrdernum());
                        if(numtype==0){
                            total-=p.getOrdernum();//减去
                        }

                    }
                }
            }
            return total;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return 0;
    }

    public int getReserve() {
        return reserve;
    }

    public void setReserve(int reserve) {
        this.reserve = reserve;
    }

    public ProductStock() {
    }

    public ProductStock(int psid) {
        this.psid = psid;
    }

    /**
     * 查询所有
     * @param sql
     * @param pos
     * @param size
     * @return
     */
    public static List<ProductStock> find(String sql, int pos, int size){
        List<ProductStock> psList = new ArrayList<ProductStock>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select psid,cid,quality,batch,activity,amount,createtime,reserve,time,ordernum from productStock where 1=1" + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, size);
            while (rs.next()){
                int i = 1;
                ProductStock p = new ProductStock(rs.getInt(i++));
                p.setCid(rs.getInt(i++));
                p.setQuality(rs.getString(i++));
                p.setBatch(rs.getString(i++));
                p.setActivity(rs.getFloat(i++));
                p.setAmount(rs.getInt(i++));
                p.setCreatetime(rs.getDate(i++));
                p.setReserve(rs.getInt(i++));
                p.setTime(rs.getDate(i++));
                p.setOrdernum(rs.getInt(i++));
                psList.add(p);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        return psList;
    }

    /**
     * 根据id查询
     * @param psid
     * @return
     */
    public static ProductStock find(Integer psid){
        ProductStock ps = null;
        if(ps == null){
            ArrayList<ProductStock> list = (ArrayList<ProductStock>) find(" AND psid = " + psid, 0, 1);
            ps = list.size() < 1 ? new ProductStock(psid):list.get(0);
        }
        return ps;
    }

    /**
     * 根据id查询
     * @return
     */
    public static ProductStock find(String quality,String batch,float activity,Date createtime){
        ProductStock ps = null;
        if(ps == null){
            ArrayList<ProductStock> list = (ArrayList<ProductStock>) find(" AND quality = " + Database.cite(quality)+" AND batch = "+Database.cite(batch)+" AND activity ="+activity+" AND createtime = "+Database.cite(MT.f(createtime)), 0, 1);
            ps = list.size() < 1 ? new ProductStock(0):list.get(0);
        }
        return ps;
    }



    /**
     * 查询库存数量
     * @param sql
     * @return
     * @throws SQLException
     */
    public static int count(String sql) throws SQLException {
        return DbAdapter.execute("select count(0) from productStock where 1=1 " + sql);
    }

    /**
     * 添加or修改库存信息
     * @throws SQLException
     */
    public void set() throws SQLException{
        String sql = "";
        if(this.psid < 1){
            sql = "insert into productStock(psid,cid,quality,batch,activity,amount,createtime,reserve,time,ordernum) values(" + (this.psid = Seq.get()) + "," + this.cid + "," + DbAdapter.cite(this.quality) + "," + DbAdapter.cite(this.batch) + "," + this.activity + "," + this.amount +","+ DbAdapter.cite(this.createtime) + "," + this.reserve + ","+ Database.cite(time) +","+ordernum+")";
        }else{
            sql = "update productStock set cid=" + this.cid + ",quality="+DbAdapter.cite(this.quality)+",batch="+DbAdapter.cite(this.batch)+",activity="+this.activity+",amount="+this.amount+",createtime="+DbAdapter.cite(this.createtime)+",reserve="+this.reserve+",time="+Database.cite(time)+",ordernum="+ordernum+" where psid=" + this.psid;
        }
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.psid, sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            db.close();
        }
    }


    // 计算当前药品活度
    public static int validity(double format) {
        if(format>=0.280 && format<=0.304){
            return 30;
        }else if (format>=0.305 && format<=0.334){
            return 40;
        }else if (format>=0.335 && format<=0.374){
            return 45;
        }else if (format>=0.375 && format<=0.414){
            return 55;
        }else if (format>=0.415 && format<=0.454){
            return 65;
        }else if (format>=0.455 && format<=0.504){
            return 75;
        }else if (format>=0.505 && format<=0.554){
            return 80;
        }else if (format>=0.555 && format<=0.604){
            return 90;
        }else if (format>=0.605 && format<=0.664){
            return 100;
        }else if (format>=0.665 && format<=0.724){
            return 110;
        }else if (format>=0.725 && format<=0.784){
            return 115;
        }else if (format>=0.785 && format<=0.854){
            return 125;
        }else if (format>=0.855 && format<=0.924){
            return 130;
        }else if (format>=0.925 && format<=1){
            return 135;
        }
        return 0;
    }

    public int getPsid() {
        return psid;
    }

    public void setPsid(int psid) {
        this.psid = psid;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getQuality() {
        return quality;
    }

    public void setQuality(String quality) {
        this.quality = quality;
    }

    public String getBatch() {
        return batch;
    }

    public void setBatch(String batch) {
        this.batch = batch;
    }

    public float getActivity() {
        return activity;
    }

    public void setActivity(float activity) {
        this.activity = activity;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getOrdernum() {
        return ordernum;
    }

    public void setOrdernum(int ordernum) {
        this.ordernum = ordernum;
    }


    /**
     *
     * @param t1 入库时间
     * @param t2 当前时间
     * @param activity 入库活度
     * @return
     */
    public static double getTimeAct(Date t1,Date t2,float activity){
        Date createtime = t1;
        Date date = t2;
        long time1 = createtime.getTime();
        long time2 = date.getTime();
        long T = (time2 - time1) / (1000 * 3600 * 24); // 获得从入库时间到现在的时间
        //double pow = Math.pow(Math.E, -(0.693 / 59.6*T))*activity; // 获取当前活度
        double powsum = Math.pow(0.9884, T);
        BigDecimal b   =   new   BigDecimal(powsum);
        double  f1   =   b.setScale(4,   RoundingMode.HALF_UP).doubleValue();
        double pow  = (activity*f1);//公式修改
        if(T==0){
            pow = Double.valueOf(String.valueOf(activity));
        }
        DecimalFormat df = new DecimalFormat("0.000");// 保留小数点后三位
        //df.setRoundingMode(RoundingMode.FLOOR);
        df.setRoundingMode(RoundingMode.HALF_UP);
        double format = Double.parseDouble(df.format(pow));
        return format;
    }

    /**
     * 获取区间
     * @param activity
     * @param perce
     * @return
     */
    public static List<Double> getAct(double activity,double perce){
        List<Double> dlist = new ArrayList<Double>();
        DecimalFormat df = new DecimalFormat("0.0000");// 保留小数点后四位
        df.setMaximumFractionDigits(4);
        double v1 = Double.parseDouble(df.format(activity + activity * perce));
        double v2 = Double.parseDouble(df.format(activity - activity * perce));
        dlist.add(0,v1);
        dlist.add(1,v2);
        return dlist;
    }
}
