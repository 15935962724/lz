package tea.entity.yl.shop;

import org.json.JSONObject;
import tea.db.DbAdapter;
import tea.entity.Cache;
import tea.entity.Database;
import tea.entity.MT;
import tea.entity.Seq;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 库存操作记录
 */
public class StockOperation {
    protected static Cache c = new Cache(50);
    private int soid;       // 主键id
    private Date time;      // 时间
    private int psid;       // 库存id
    private int cid;        // 类别id
    private float activity; // 真实活度(计算后的活度)
    private int amount;     // 库存数量
    private int type;       // 类型 0减(用户购买) 1加(用户退货) 2录入(添加库存) 3修改(修改库存) 4删除(删除库存) 5管理员分配 6管理员取消分配 7取消分批
    private String[] typeArr={"用户购买","用户退货","添加库存","修改库存","删除库存","管理员分配","管理员取消分配","取消分批"};
    private int state;      // 状态 1查库存和预留 0只查库存
    private int member;     // 操作人
    private int oid;        // 订单id
    private String describe;// 描述
    private int reserve;    // 预留数量
    private Date valid;     // 有效期
    private int isRetreat;  // 是否退单

    private Date calibrationtime;//校准时间
    
    public StockOperation() {
    }

    public StockOperation(int soid) {
        this.soid = soid;
    }

    public static StockOperation find(int soid){
        StockOperation aShopPackage = (StockOperation)c.get(soid);
        if(aShopPackage == null){
            List<StockOperation> list = find(" AND soid = " + soid, 0, 1);
            aShopPackage = list.size() < 1 ? new StockOperation(soid):list.get(0);
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
    public static List<StockOperation> find(String sql,int pos,int size){
        ArrayList<StockOperation> soList = new ArrayList<StockOperation>();
        DbAdapter db = new DbAdapter();
        String SQsql = "select so.soid,so.time,so.psid,so.cid,so.activity,so.amount,so.type,so.state,so.member,so.oid,so.describe,so.reserve,so.valid,so.isRetreat,so.calibrationtime from stockOperation so "+tab(sql)+" where 1=1" + sql;
        try {
            ResultSet rs = db.executeQuery(SQsql, pos, size);
            while (rs.next()){
                int i=1;
                StockOperation so = new StockOperation(rs.getInt(i++));
                so.setTime(db.getDate(i++));
                so.setPsid(rs.getInt(i++));
                so.setCid(rs.getInt(i++));
                so.setActivity(rs.getFloat(i++));
                so.setAmount(rs.getInt(i++));
                so.setType(rs.getInt(i++));
                so.setState(rs.getInt(i++));
                so.setMember(rs.getInt(i++));
                so.setOid(rs.getInt(i++));
                so.setDescribe(rs.getString(i++));
                so.setReserve(rs.getInt(i++));
                so.setValid(rs.getDate(i++));
                so.setIsRetreat(rs.getInt(i++));
                so.setCalibrationtime(db.getDate(i++));
                c.put(so.soid,so);
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
        return DbAdapter.execute("select count(0) from stockOperation so "+tab(sql)+" where 1=1" + sql);
    }

    private static String tab(String sql)
    {
        StringBuilder sb = new StringBuilder();
        if (sql.contains(" AND ps."))
            sb.append(" INNER JOIN ProductStock ps ON ps.psid=so.psid");
        return sb.toString();
    }

    /**
     * 添加操作记录
     */
    public void set() throws SQLException {
        String sql = "insert into stockOperation(soid,time,psid,cid,activity,amount,type,state,member,oid,describe,reserve,valid,isRetreat,calibrationtime) values(" +
                (this.soid = Seq.get()) + "," +
                DbAdapter.cite(this.time) + "," +
                this.psid + "," +
                this.cid + "," +
                this.activity + "," +
                this.amount + "," +
                this.type + "," +
                this.state + "," +
                this.member + "," +
                this.oid + "," +
                DbAdapter.cite(this.describe) + "," +
                this.reserve + "," +
                DbAdapter.cite(this.valid) + "," +
                this.isRetreat +
                ","+Database.cite(calibrationtime)+")";
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(this.oid,sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        c.remove(this.soid);

    }

    /**
     * 记录订单操作库存记录: 下单
     * @param activity  活度
     * @param number    数量
     * @param perce     浮动
     * @param type      状态 1查库存和预留 0只查库存
     * @param member    用户
     * @param oid       订单编号
     * @return          0,库存/库存+预留 > 需求数量 1,库存/库存+预留 < 需求数量
     */
    public static JSONObject set(double activity, int number, double perce, int type, int member, int oid, Date date){
        JSONObject jo = new JSONObject();
        String soid = "";
        StockOperation so = new StockOperation();
        int stock = ProductStock.findStock(activity, perce, type,date,1);
        ShopOrder so1 = ShopOrder.find(oid);
        DbAdapter db = new DbAdapter();
        DecimalFormat df = new DecimalFormat("0.0000");// 保留小数点后四位
        df.setMaximumFractionDigits(4);
        double v1 = Double.parseDouble(df.format(activity + activity * perce)); // 浮动+
        double v2 = Double.parseDouble(df.format(activity - activity * perce)); // 浮动-
        if(stock >= number){ // 库存数量大于需求数量
            List<ProductStock> list = ProductStock.find("", 0, Integer.MAX_VALUE);// MAX_VALUE 不限制条数
            //int total = 0;
            if(type==1){ // 查库存和预留
                HashMap<Integer, Float> hm = new HashMap<Integer, Float>();
                for (ProductStock ps : list) {
                    Date createtime = ps.getCreatetime(); // 入库时间
                    //Date date = new Date(); // 当前时间
                    long time1 = createtime.getTime();
                    long time2 = date.getTime();
                    long T = (time2 - time1) / (1000 * 3600 * 24); // 获得从入库时间到现在的时间
                    //double pow = Math.pow(Math.E, -(0.693 / 59.6 * T)) * ps.getActivity(); // 获取当前活度
                    double powsum = Math.pow(0.9884, T);
                    BigDecimal b   =   new   BigDecimal(powsum);
                    double  f1   =   b.setScale(4,   RoundingMode.HALF_UP).doubleValue();
                    double pow  = (ps.getActivity()*f1);//公式修改
                    if(T==0){
                        pow = Double.valueOf(String.valueOf(ps.getActivity()));
                    }
                    System.out.println(pow+"==");
                    if(pow>v2 && pow<v1){ // 判断当前活度是否符合要求
                        hm.put(ps.psid, (float) pow);
                    }
                }
                ArrayList<Map.Entry<Integer, Float>> listMap = new ArrayList<Map.Entry<Integer, Float>>(hm.entrySet());
                // 通过比较器来实现排序
                Collections.sort(listMap, new Comparator<Map.Entry<Integer, Float>>() {
                    // 升序排序
                    @Override
                    public int compare(Map.Entry<Integer, Float> o1, Map.Entry<Integer, Float> o2) {
                        return o1.getValue().compareTo(o2.getValue());
                    }
                });
                for (Map.Entry<Integer, Float> fe : listMap) {
                    // 获取当前活度的预留数量
                    ProductStock p = ProductStock.find(fe.getKey());

                    int kou = 0;
                    if(so1.getAllocate()==1){//调配
                        kou = p.getOrdernum();
                    }

                    if((p.amount-kou)>0 || p.reserve>0){
                        if((p.reserve-kou) >= number){ // 当前数量>需求数量 记录库存操作,减预留库存,结束循环
                            //total += p.reserve;
                            try {
                                // 1,记录库存操作
                                soSet(type, member, oid, so, fe, p);

                                if(so1.getAllocate()!=1){//不调配操作库存
                                    p.setOrdernum(p.getOrdernum()-number);//减去用户占用的库存
                                }
                                so.setAmount(0); // 数量
                                so.setDescribe("管理员分配.减预留数量:" + number + "支,库存剩余:" + p.amount + "支,预留剩余:" + (p.reserve-number)+"支"+"，用户占用库存："+p.getOrdernum()+"支"); // 描述
                                so.setReserve(number); // 预留数量
                                // 计算有效期
                                Date date2 = getDate(activity, p,date);
                                so.setValid(date2);
                                so.setCalibrationtime(date);
                                so.setType(5);//管理员操作
                                so.set();
                                soid += ","+so.getSoid();
                                // 2,减库存
                                p.setReserve(p.reserve-number);



                                p.set();

                                // 3,结束循环
                                break;
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }else if(((p.amount+p.reserve)-kou)>=number){ // 库存+预留<需求数量 记录库存操作,清空预留库存,减库存,结束循环
                            //total += p.amount;
                            try {
                                // 1,记录库存操作
                                soSet(type, member, oid, so, fe, p);
                                if(so1.getAllocate()!=1) {//不调配操作库存
                                    p.setOrdernum(p.getOrdernum()-number);//减去用户占用的库存
                                }
                                if(p.reserve==0){
                                    so.setDescribe("管理员分配,减库存数量:" + (number - p.reserve) + "支,库存剩余:" + (p.amount - (number - p.reserve)) + "支,预留剩余:0支"+"，用户占用库存："+p.getOrdernum()+"支");
                                }else {
                                    so.setDescribe("管理员分配,减库存数量:" + (number - p.reserve) + "支,减预留数量:" + p.reserve + ",库存剩余:" + (p.amount - (number - p.reserve)) + "支,预留剩余:0支"+"，用户占用库存："+p.getOrdernum()+"支");
                                }
                                so.setReserve(p.reserve); // 预留数量
                                so.setAmount(number-p.reserve); // 数量
                                // 计算有效期
                                Date date2 = getDate(activity, p,date);
                                so.setValid(date2);
                                so.setCalibrationtime(date);
                                so.setType(5);//管理员操作
                                so.set();
                                soid += ","+so.getSoid();

                                // 2,减库存
                                p.setAmount(p.amount-(number-p.reserve));
                                p.setReserve(0);

                                p.set();

                                // 3,结束循环
                                break;
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }else if(number>((p.amount+p.reserve)-kou)){ //
                            try {
                                // 1,记录库存操作
                                soSet(type, member, oid, so, fe, p);
                                so.setReserve(p.reserve); // 预留数量
                                so.setAmount(p.amount); // 数量
                                // 需求数量减去当前库存数量和当前预留数量,进行下一轮
                                if(so1.getAllocate()!=1) {//不调配操作库存
                                    p.setOrdernum(p.getOrdernum()-number);//减去用户占用的库存
                                }
                                    number=number-p.amount-p.reserve;

                                if(p.reserve==0){
                                    so.setDescribe("管理员分配,减库存数量:" + p.amount + "支,库存剩余:0支,预留剩余:0支"+"，用户占用库存："+p.getOrdernum()+"支");
                                }else{
                                    so.setDescribe("管理员分配,减库存数量:" + p.amount + "支,减预留数量:" + p.reserve + ",库存剩余:0支,预留剩余:0支"+"，用户占用库存："+p.getOrdernum()+"支");
                                }

                                // 计算有效期
                                Date date2 = getDate(activity, p,date);
                                so.setValid(date2);
                                so.setCalibrationtime(date);
                                so.setType(5);//管理员操作
                                so.set();
                                soid += ","+so.getSoid();



                                // 2,减库存
                                p.setAmount(0);
                                p.setReserve(0);
                                p.set();


                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }
            }else if(type==0){ // 只查库存
                HashMap<Integer, Float> hm = new HashMap<Integer, Float>();
                for (ProductStock ps : list) {
                    Date createtime = ps.getCreatetime(); // 入库时间
                    //Date date = new Date(); // 当前时间
                    long time1 = createtime.getTime();
                    long time2 = date.getTime();
                    long T = (time2 - time1) / (1000 * 3600 * 24); // 获得从入库时间到现在的时间
                    //double pow = Math.pow(Math.E, -(0.693 / 59.6 * T)) * ps.getActivity(); // 获取当前活度
                    double powsum = Math.pow(0.9884, T);
                    BigDecimal b   =   new   BigDecimal(powsum);
                    double  f1   =   b.setScale(4,   RoundingMode.HALF_UP).doubleValue();
                    double pow  = (ps.getActivity()*f1);//公式修改
                    if(T==0){
                        pow = Double.valueOf(String.valueOf(ps.getActivity()));
                        //pow = activity;

                    }
                    System.out.println(pow+"==");
                    if(pow>v2 && pow<v1){ // 判断当前活度是否符合要求
                        hm.put(ps.psid, (float) pow);
                    }
                }
                ArrayList<Map.Entry<Integer, Float>> listMap = new ArrayList<Map.Entry<Integer, Float>>(hm.entrySet());
                // 通过比较器来实现排序
                Collections.sort(listMap, new Comparator<Map.Entry<Integer, Float>>() {
                    // 升序排序
                    @Override
                    public int compare(Map.Entry<Integer, Float> o1, Map.Entry<Integer, Float> o2) {
                        return o1.getValue().compareTo(o2.getValue());
                    }
                });
                for (Map.Entry<Integer, Float> fe : listMap) {
                    // 获取当前活度的库存数量
                    ProductStock p = ProductStock.find(fe.getKey());

                    int kou = 0;
                    if(so1.getAllocate()==1){//调配
                        kou = p.getOrdernum();
                    }

                    if((p.amount-kou)>0){
                        if((p.amount-kou) >= number){ // 当前数量>需求数量 记录库存操作,减库存,结束循环
                            //total += p.reserve;
                            try {
                                // 1,记录库存操作
                                soSet(type, member, oid, so, fe, p);
                                so.setAmount(number); // 数量
                                if(so1.getAllocate()!=1) {//不调配操作库存
                                    p.setOrdernum(p.getOrdernum()-number);//减去用户占用的库存
                                }
                                so.setDescribe("管理员分配,减库存数量:" + number + "支,库存剩余:" + (p.amount-number) + "支,预留剩余:" + p.reserve+"支"+"，用户占用库存："+p.getOrdernum()+"支"); // 描述
                                so.setReserve(0); // 预留数量
                                // 计算有效期
                                Date date2 = getDate(activity, p,date);
                                so.setValid(date2);
                                so.setCalibrationtime(date);
                                so.setType(5);//管理员操作
                                so.set();
                                soid += ","+so.getSoid();

                                // 2,减库存
                                p.setAmount(p.amount-number);

                                p.set();

                                // 3,结束循环
                                break;
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }else if(number>(p.amount-kou)){ //
                            try {
                                // 1,记录库存操作
                                soSet(type, member, oid, so, fe, p);
                                so.setReserve(0); // 预留数量
                                so.setAmount(p.amount); // 数量
                                // 需求数量减去当前库存数量,进行下一轮
                                if(so1.getAllocate()!=1) {//不调配操作库存
                                    p.setOrdernum(p.getOrdernum()-number);//减去用户占用的库存
                                }
                                number=number-p.amount;
                                so.setDescribe("管理员分配,减库存数量:" + p.amount + "支,库存剩余:0支,预留剩余:"+p.reserve+"支"+"，用户占用库存："+p.getOrdernum()+"支");

                                // 计算有效期
                                Date date2 = getDate(activity, p,date);
                                so.setValid(date2);
                                so.setCalibrationtime(date);
                                so.setType(5);//管理员操作
                                so.set();
                                soid += ","+so.getSoid();



                                // 2,减库存
                                p.setAmount(0);
                                p.set();


                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }
            }
            jo.put("status","0");
        }else { // 库存数量小于需求数量
            //return 1;
            jo.put("status","1");
        }
        jo.put("soid",soid);
        return jo;
    }

    /**
     * 用户退单,记录库存操作
     * @param oid // 订单id
     * @return
     */
    public static int setStill(int oid){
        //这里只清买的
        ShopOrder so1 = ShopOrder.find(oid);
            List<StockOperation> soList = find(" and isRetreat=0 and oid=" + oid+" AND type = 0", 0, Integer.MAX_VALUE);
        if(soList.size()>0){
            for (StockOperation so : soList) {
                try {
                    ProductStock ps = ProductStock.find(so.psid); // 根据记录中的库存id查询 需要退回的库存
                    /*if(so.getType()==5){//管理员调配
                        ps.setAmount(ps.amount+so.amount); // 还库存
                        ps.setReserve(ps.reserve+so.reserve); // 还预留
                        ps.setOrdernum(ps.getOrdernum()+so.amount);//加库存
                    }else{*/
                    if(so1.getAllocate()!=1){
                        ps.setOrdernum(ps.getOrdernum()-so.amount);//还库存
                    }
                    System.out.println("setStill===="+ps.getOrdernum()+"=="+so.amount);
                   // }
                    ps.set();
                    // 记录操作
                    StockOperation soNew = new StockOperation();
                    soNew.setTime(new Date()); // 时间
                    soNew.setPsid(so.psid); // 库存id
                    soNew.setCid(14102669); // 类别id
                    soNew.setActivity(so.activity); // 购买时的真实活度
                    soNew.setType(1); // 操作类型,退单
                    soNew.setMember(so.member); // 用户
                    soNew.setOid(oid); // 订单id
                    soNew.setAmount(so.amount); // 库存数量
                    soNew.setReserve(so.reserve); // 预留数量
                    soNew.setIsRetreat(1);  // 记录用户退单
                    so.setIsRetreat(1);  // 记录用户退单
                    so.updateRetreat(1,so.soid);
                    if(so.amount==0){
                        soNew.setDescribe("用户退单,增加预留数量:" + so.reserve + "支,库存剩余:" + ps.amount + "支,预留剩余:" + ps.reserve + "支"+"，用户占用库存："+ps.getOrdernum()+"支");
                    }else if(so.reserve==0){
                        soNew.setDescribe("用户退单,增加库存数量:" + so.amount + "支,库存剩余:" + ps.amount + "支,预留剩余:" + ps.reserve + "支"+"，用户占用库存："+ps.getOrdernum()+"支");
                    }else {
                        soNew.setDescribe("用户退单,增加库存数量:" + so.amount + "支,增加预留数量:" + so.reserve + "支,库存剩余:" + ps.amount + "支,预留剩余:" + ps.reserve + "支"+"，用户占用库存："+ps.getOrdernum()+"支");
                    }
                    soNew.set();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            return 0;
        }else {
            return 1;
        }
    }

    /**
     * 用户退单,记录库存操作
     * @return
     */
    public static int setStillBat(String soid){
        String [] soids = MT.f(soid,",").split(",");
        //List<StockOperation> soList = find(" and isRetreat=0 and oid=" + oid, 0, Integer.MAX_VALUE);
        if(soids.length>1){
           // for (StockOperation so : soList) {
                for (int i = 1; i < soids.length; i++) {
                    StockOperation so = StockOperation.find(Integer.parseInt(soids[i]));


                    ShopOrder so1 = ShopOrder.find(so.oid);
                    try {
                    ProductStock ps = ProductStock.find(so.psid); // 根据记录中的库存id查询 需要退回的库存
                    if(so.getType()==5){//管理员调配
                        ps.setAmount(ps.amount+so.amount); // 还库存
                        ps.setReserve(ps.reserve+so.reserve); // 还预留
                        if(so1.getAllocate()!=1){
                            ps.setOrdernum(ps.getOrdernum()+so.amount);//加库存
                        }
                    }else{
                        if(so1.getAllocate()!=1){
                            ps.setOrdernum(ps.getOrdernum()-so.amount);//还库存
                        }
                    }

                    System.out.println("setStillBat===="+ps.getOrdernum()+"=="+so.amount);

                    ShopBatchesData sbd = ShopBatchesData.find(so1.getOrderId(),so.psid);
                    sbd.setOccupyNumber(sbd.getOccupyNumber()-so.amount);
                    sbd.set();

                    ps.set();
                    // 记录操作
                    StockOperation soNew = new StockOperation();
                    soNew.setTime(new Date()); // 时间
                    soNew.setPsid(so.psid); // 库存id
                    soNew.setCid(14102669); // 类别id
                    soNew.setActivity(so.activity); // 购买时的真实活度
                    soNew.setType(6); // 操作类型,退单
                    soNew.setMember(so.member); // 用户
                    soNew.setOid(so.oid); // 订单id
                    soNew.setAmount(so.amount); // 库存数量
                    soNew.setReserve(so.reserve); // 预留数量
                    soNew.setIsRetreat(1);  // 记录用户退单
                    so.setIsRetreat(1);  // 记录用户退单
                    so.updateRetreat(1,so.soid);
                    if(so.amount==0){
                        soNew.setDescribe("管理员取消分批,增加预留数量:" + so.reserve + "支,库存剩余:" + ps.amount + "支,预留剩余:" + ps.reserve + "支"+"，用户占用库存："+ps.getOrdernum()+"支");
                    }else if(so.reserve==0){
                        soNew.setDescribe("管理员取消分批,增加库存数量:" + so.amount + "支,库存剩余:" + ps.amount + "支,预留剩余:" + ps.reserve + "支"+"，用户占用库存："+ps.getOrdernum()+"支");
                    }else {
                        soNew.setDescribe("管理员取消分批,增加库存数量:" + so.amount + "支,增加预留数量:" + so.reserve + "支,库存剩余:" + ps.amount + "支,预留剩余:" + ps.reserve + "支"+"，用户占用库存："+ps.getOrdernum()+"支");
                    }
                    soNew.set();
                } catch (SQLException e) {
                    e.printStackTrace();
                    return 1;
                }
            }
            return 0;
        }else {
            return 1;
        }
    }


    // 修改下单记录中的退单状态
    private void updateRetreat(int i,int soid) {
        String sql = "update stockOperation set isRetreat="+i+" where soid="+soid;
        DbAdapter db = new DbAdapter();
        try {
            db.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.close();
        }
        c.remove(this.soid);
    }

    // 记录库存操作
    private static void soSet(int type, int member, int oid, StockOperation so, Map.Entry<Integer, Float> fe, ProductStock p) {
        so.setTime(new Date()); // 操作时间
        so.setPsid(p.psid); // 库存id
        so.setCid(14102669); // 类别id
        System.out.println(fe.getValue()+"==soSet");
        DecimalFormat dff = new DecimalFormat("0.000");// 保留小数点后三位
        //dff.setRoundingMode(RoundingMode.FLOOR);
        dff.setRoundingMode(RoundingMode.HALF_UP);
        double d1 = Double.valueOf(String.valueOf(fe.getValue()));

        double format = Double.parseDouble(dff.format(d1));
        so.setActivity((float) format); // 真实活度
        so.setType(0); // 类型: 购买
        so.setState(type); // 状态
        so.setMember(member); // 用户
        so.setOid(oid); // 订单id
    }

    // 获取有效期
    public static Date getDate(double activity, ProductStock p,Date date) {
        //Date date = new Date();
        long time1 = p.createtime.getTime();
        long time2 = date.getTime();
        long T = (time2 - time1) / (1000 * 3600 * 24); // 获得从入库时间到现在的时间
        //double pow = Math.pow(Math.E, -(0.693 / 59.6*T))*p.getActivity(); // 获取当前活度 //修改为入库活度
        double powsum = Math.pow(0.9884, T);
        BigDecimal b   =   new   BigDecimal(powsum);
        double  f1   =   b.setScale(4,   RoundingMode.HALF_UP).doubleValue();
        double pow  = (activity*f1);//公式修改
        if(T==0){
            pow = Double.valueOf(String.valueOf(activity));
        }
        DecimalFormat dff = new DecimalFormat("0.000");// 保留小数点后三位
        //dff.setRoundingMode(RoundingMode.FLOOR);
        dff.setRoundingMode(RoundingMode.HALF_UP);
        double format = Double.parseDouble(dff.format(pow));
        int validity = ProductStock.validity(format); // 计算有效期
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar ca = Calendar.getInstance();
        ca.setTime(date);
        ca.add(Calendar.DATE,validity);
        date=ca.getTime();
        return date;
    }

    public static void main(String[] args) {
        //ProductStock p = ProductStock.find(19050079);
        //System.out.println(MT.f(getDate(0.459,p,new Date())));
        //ProductStock.findStock(0.47,0.03,0,new Date());
    }



    /**
     * 记录订单操作库存记录: 下单
     * @param activity  活度
     * @param number    数量
     * @param perce     浮动
     * @param type      状态 1查库存和预留 0只查库存
     * @param member    用户
     * @param oid       订单编号
     * @return          0,库存/库存+预留 > 需求数量 1,库存/库存+预留 < 需求数量
     */
    public static int setOrder(double activity, int number, double perce, int type, int member,int oid,Date date){
        StockOperation so = new StockOperation();
        int stock = ProductStock.findStock(activity, perce, type,date,0);
        ShopOrder so1 = ShopOrder.find(oid);
        DbAdapter db = new DbAdapter();
        DecimalFormat df = new DecimalFormat("0.0000");// 保留小数点后四位
        df.setMaximumFractionDigits(4);
        double v1 = Double.parseDouble(df.format(activity + activity * perce)); // 浮动+
        double v2 = Double.parseDouble(df.format(activity - activity * perce)); // 浮动-
        if(stock >= number){ // 库存数量大于需求数量
            List<ProductStock> list = ProductStock.find("", 0, Integer.MAX_VALUE);// MAX_VALUE 不限制条数
            //int total = 0;
            if(type==1){ // 查库存和预留
                HashMap<Integer, Float> hm = new HashMap<Integer, Float>();
                for (ProductStock ps : list) {
                    Date createtime = ps.getCreatetime(); // 入库时间
                    //Date date = new Date(); // 当前时间
                    long time1 = createtime.getTime();
                    long time2 = date.getTime();
                    long T = (time2 - time1) / (1000 * 3600 * 24); // 获得从入库时间到现在的时间
                    //double pow = Math.pow(Math.E, -(0.693 / 59.6 * T)) * ps.getActivity(); // 获取当前活度
                    double powsum = Math.pow(0.9884, T);
                    BigDecimal b   =   new   BigDecimal(powsum);
                    double  f1   =   b.setScale(4,   RoundingMode.HALF_UP).doubleValue();
                    double pow  = (ps.getActivity()*f1);//公式修改
                    if(T==0){
                        pow = Double.valueOf(String.valueOf(ps.getActivity()));
                    }
                    if(pow>v2 && pow<v1){ // 判断当前活度是否符合要求
                        hm.put(ps.psid, (float) pow);
                    }
                }
                ArrayList<Map.Entry<Integer, Float>> listMap = new ArrayList<Map.Entry<Integer, Float>>(hm.entrySet());
                // 通过比较器来实现排序
                Collections.sort(listMap, new Comparator<Map.Entry<Integer, Float>>() {
                    // 升序排序
                    @Override
                    public int compare(Map.Entry<Integer, Float> o1, Map.Entry<Integer, Float> o2) {
                        return o1.getValue().compareTo(o2.getValue());
                    }
                });
                for (Map.Entry<Integer, Float> fe : listMap) {
                    // 获取当前活度的预留数量
                    ProductStock p = ProductStock.find(fe.getKey());
                    if((p.amount-p.getOrdernum())>0 || p.reserve>0){
                        if(p.reserve >= number){ // 当前数量>需求数量 记录库存操作,减预留库存,结束循环
                            //total += p.reserve;
                            try {
                                // 1,记录库存操作
                                soSet(type, member, oid, so, fe, p);
                                so.setAmount(0); // 数量
                                // 2,减库存
                                p.setOrdernum(p.getOrdernum()+number);
                                so.setDescribe("用户购买,减预留数量:" + number + "支,库存剩余:" + p.amount + "支,预留剩余:" + (p.reserve)+"支"+"，用户占用库存："+p.getOrdernum()+"支"); // 描述
                                so.setReserve(number); // 预留数量
                                // 计算有效期
                                Date date2 = getDate(activity, p,date);
                                so.setValid(date2);
                                so.setCalibrationtime(date);
                                so.set();
                                //记录用户下单详情
                                ShopBatchesData sbd = ShopBatchesData.find(0);
                                sbd.setNumber(number);
                                sbd.setOrderId(so1.getOrderId());
                                sbd.setTime(new Date());
                                sbd.setPsid(p.getPsid());
                                sbd.set();

                                //p.setReserve(p.reserve-number);
                                p.set();

                                // 3,结束循环
                                break;
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }else if(((p.amount-p.getOrdernum())+p.reserve)>=number){ // 库存+预留<需求数量 记录库存操作,清空预留库存,减库存,结束循环
                            //total += p.amount;
                            try {
                                // 1,记录库存操作
                                soSet(type, member, oid, so, fe, p);
                                p.setOrdernum(p.getOrdernum()+number);
                                if(p.reserve==0){
                                    so.setDescribe("用户购买,减库存数量:" + (number - p.reserve) + "支,库存剩余:" + (p.amount) + "支,预留剩余:"+p.reserve+"支"+"，用户占用库存："+p.getOrdernum()+"支");
                                }else {
                                    so.setDescribe("用户购买,减库存数量:" + (number - p.reserve) + "支,减预留数量:" + p.reserve + ",库存剩余:" + (p.amount ) + "支,预留剩余:0支"+"，用户占用库存："+p.getOrdernum()+"支");
                                }
                                so.setReserve(p.reserve); // 预留数量
                                so.setAmount(number-p.reserve); // 数量
                                // 计算有效期
                                Date date2 = getDate(activity, p,date);
                                so.setValid(date2);
                                so.setCalibrationtime(date);
                                so.set();

                                // 2,减库存
                                //p.setAmount(p.amount-(number-p.reserve));
                                //p.setReserve(0);

                                p.set();
                                //记录用户下单详情
                                ShopBatchesData sbd = ShopBatchesData.find(0);
                                sbd.setNumber(number-p.reserve);
                                sbd.setOrderId(so1.getOrderId());
                                sbd.setTime(new Date());
                                sbd.setPsid(p.getPsid());
                                sbd.set();
                                // 3,结束循环
                                break;
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }else if(number>((p.amount-p.getOrdernum())+p.reserve)){ //
                            try {
                                // 1,记录库存操作
                                soSet(type, member, oid, so, fe, p);
                                so.setReserve(p.reserve); // 预留数量
                                so.setAmount(p.amount); // 数量
                                // 需求数量减去当前库存数量和当前预留数量,进行下一轮
                                number=number-p.amount-p.reserve;

                                // 2,减库存
                                //p.setAmount(0);
                                //p.setReserve(0);
                                p.setOrdernum(p.getOrdernum()+p.amount+p.reserve);
                                if(p.reserve==0){
                                    so.setDescribe("用户购买,减库存数量:" + p.amount + "支,库存剩余:"+p.amount+"支,预留剩余:"+p.reserve+"支"+"，用户占用库存："+p.getOrdernum()+"支");
                                }else{
                                    so.setDescribe("用户购买,减库存数量:" + p.amount + "支,减预留数量:" + p.reserve + ",库存剩余:"+p.amount+"支,预留剩余:"+p.reserve+"支"+"，用户占用库存："+p.getOrdernum()+"支");
                                }

                                // 计算有效期
                                Date date2 = getDate(activity, p,date);
                                so.setValid(date2);
                                so.setCalibrationtime(date);
                                so.set();


                                p.set();

                                //记录用户下单详情
                                ShopBatchesData sbd = ShopBatchesData.find(0);
                                sbd.setNumber(p.amount);
                                sbd.setOrderId(so1.getOrderId());
                                sbd.setTime(new Date());
                                sbd.setPsid(p.getPsid());
                                sbd.set();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }
            }else if(type==0){ // 只查库存
                HashMap<Integer, Float> hm = new HashMap<Integer, Float>();
                for (ProductStock ps : list) {
                    Date createtime = ps.getCreatetime(); // 入库时间
                    //Date date = new Date(); // 当前时间
                    long time1 = createtime.getTime();
                    long time2 = date.getTime();
                    long T = (time2 - time1) / (1000 * 3600 * 24); // 获得从入库时间到现在的时间
                    //double pow = Math.pow(Math.E, -(0.693 / 59.6 * T)) * ps.getActivity(); // 获取当前活度
                    double powsum = Math.pow(0.9884, T);
                    BigDecimal b   =   new   BigDecimal(powsum);
                    double  f1   =   b.setScale(4,   RoundingMode.HALF_UP).doubleValue();
                    double pow  = (ps.getActivity()*f1);//公式修改
                    if(T==0){
                        pow = Double.valueOf(String.valueOf(ps.getActivity()));
                    }

                    if(pow>v2 && pow<v1){ // 判断当前活度是否符合要求
                        hm.put(ps.psid, (float) pow);
                    }
                }
                ArrayList<Map.Entry<Integer, Float>> listMap = new ArrayList<Map.Entry<Integer, Float>>(hm.entrySet());
                // 通过比较器来实现排序
                Collections.sort(listMap, new Comparator<Map.Entry<Integer, Float>>() {
                    // 升序排序
                    @Override
                    public int compare(Map.Entry<Integer, Float> o1, Map.Entry<Integer, Float> o2) {
                        return o1.getValue().compareTo(o2.getValue());
                    }
                });
                for (Map.Entry<Integer, Float> fe : listMap) {
                    // 获取当前活度的库存数量
                    ProductStock p = ProductStock.find(fe.getKey());
                    if((p.amount-p.getOrdernum())>0){
                        if((p.amount-p.getOrdernum()) >= number){ // 当前数量>需求数量 记录库存操作,减库存,结束循环
                            //total += p.reserve;
                            try {
                                // 1,记录库存操作
                                soSet(type, member, oid, so, fe, p);
                                so.setAmount(number); // 数量
                                p.setOrdernum(p.getOrdernum()+number);
                                so.setDescribe("用户购买,减库存数量:" + number + "支,库存剩余:" + (p.amount) + "支,预留剩余:" + p.reserve+"支"+"，用户占用库存："+p.getOrdernum()+"支"); // 描述
                                so.setReserve(0); // 预留数量
                                // 计算有效期
                                Date date2 = getDate(activity, p,date);
                                so.setValid(date2);
                                so.setCalibrationtime(date);
                                so.set();

                                // 2,减库存
                                //p.setAmount(p.amount-number);

                                p.set();
                                //记录用户下单详情
                                ShopBatchesData sbd = ShopBatchesData.find(0);
                                sbd.setNumber(number);
                                sbd.setOrderId(so1.getOrderId());
                                sbd.setTime(new Date());
                                sbd.setPsid(p.getPsid());
                                sbd.set();
                                // 3,结束循环
                                break;
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }else if(number>(p.amount-p.getOrdernum())){ //
                            try {
                                // 1,记录库存操作
                                soSet(type, member, oid, so, fe, p);
                                so.setReserve(0); // 预留数量
                                so.setAmount(p.amount); // 数量
                                p.setOrdernum(p.getOrdernum()+p.amount);
                                so.setDescribe("用户购买,减库存数量:" + p.amount + "支,库存剩余:"+p.amount+"支,预留剩余:"+p.reserve+"支"+"，用户占用库存："+p.getOrdernum()+"支");

                                // 计算有效期
                                Date date2 = getDate(activity, p,date);
                                so.setValid(date2);
                                so.setCalibrationtime(date);
                                so.set();

                                // 需求数量减去当前库存数量,进行下一轮
                                number=number-p.amount;

                                // 2,减库存
                                //p.setAmount(0);

                                p.set();
                                //记录用户下单详情
                                ShopBatchesData sbd = ShopBatchesData.find(0);
                                sbd.setNumber(p.amount);
                                sbd.setOrderId(so1.getOrderId());
                                sbd.setTime(new Date());
                                sbd.setPsid(p.getPsid());
                                sbd.set();

                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }
            }
            return 0;
        }else { // 库存数量小于需求数量
            return 1;
        }
    }

    public int getSoid() {
        return soid;
    }

    public void setSoid(int soid) {
        this.soid = soid;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
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

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getMember() {
        return member;
    }

    public void setMember(int member) {
        this.member = member;
    }

    public int getOid() {
        return oid;
    }

    public void setOid(int oid) {
        this.oid = oid;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public int getReserve() {
        return reserve;
    }

    public void setReserve(int reserve) {
        this.reserve = reserve;
    }

    public String[] getTypeArr() {
        return typeArr;
    }

    public void setTypeArr(String[] typeArr) {
        this.typeArr = typeArr;
    }

    public Date getValid() {
        return valid;
    }

    public void setValid(Date valid) {
        this.valid = valid;
    }

    public int getIsRetreat() {
        return isRetreat;
    }

    public void setIsRetreat(int isRetreat) {
        this.isRetreat = isRetreat;
    }

	public Date getCalibrationtime() {
		return calibrationtime;
	}

	public void setCalibrationtime(Date calibrationtime) {
		this.calibrationtime = calibrationtime;
	}
    
}
