package tea.ui.yl.shop;

import com.alibaba.fastjson.JSON;
import com.google.common.collect.Lists;
import org.apache.poi.ss.usermodel.Row;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import tea.db.DbAdapter;
import tea.entity.Database;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.yl.shop.ProductStock;
import tea.entity.yl.shop.ShopOrder;
import tea.entity.yl.shop.StockOperation;
import util.DateUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class ProductStocks extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        JSONObject jo = new JSONObject();
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        PrintWriter out = resp.getWriter();

        // 查询所有
        if("findPSList".equals(act)){
            try {
                int page_size = h.getInt("page_size");
                int pos = h.getInt("pos");

                StringBuffer sql = new StringBuffer();
                String quality = h.get("quality");

                if (!"".equals(quality) && quality != null) {
                    sql.append(" and quality="+DbAdapter.cite(quality));
                }

                String batch = h.get("batch");

                if (!"".equals(batch) && batch != null) {
                    sql.append(" and batch="+DbAdapter.cite(batch));
                }
                Date t0=h.getDate("t0");
                if(t0!=null)
                {
                    sql.append(" AND createtime>"+DbAdapter.cite(t0));
                }
                Date t1=h.getDate("t1");
                if(t1!=null)
                {
                    sql.append(" AND createtime<"+DbAdapter.cite(t1));
                }

                String mydate = h.get("mydate",MT.f(new Date()));

                Date mydate1 = new Date();

                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        mydate1 = simpleDateFormat.parse(mydate);
                    } catch (Throwable e) {
                        e.printStackTrace();
                    }

                double actq = h.getDouble("activity");

                List<Double> dlist = ProductStock.getAct(actq,0.03);
                if(actq!=0){
                    sql.append(" AND cast((select activity * power(0.9884,datediff(day,createtime,"+Database.cite(MT.f(mydate))+")))   as   numeric(5,3)) >="+dlist.get(1)+" AND cast((select activity * power(0.9884,datediff(day,createtime,getdate())))   as   numeric(5,3)) < "+dlist.get(0));
                }

                double activity1 = h.getDouble("activity1");
                double activity2 = h.getDouble("activity2");

                if(activity1!=0){
                    sql.append(" AND cast((select activity * power(0.9884,datediff(day,createtime,"+Database.cite(MT.f(mydate))+")))   as   numeric(5,3)) >="+activity1);
                }
                if(activity2!=0){
                    sql.append(" AND cast((select activity * power(0.9884,datediff(day,createtime,"+Database.cite(MT.f(mydate))+")))   as   numeric(5,3)) <="+activity2);
                }

                String[] SQL = {" AND  (amount+reserve) > 0 ", "   "};
                int tab = h.getInt("tab", 0);
                sql.append(SQL[tab]);

                int sum = ProductStock.count(sql.toString());
                sql.append(" order by cast((select activity * power(0.9884,datediff(day,createtime,"+Database.cite(MT.f(mydate))+")))   as   numeric(5,3)) ");
                List<ProductStock> psList = ProductStock.find(sql.toString(), pos, page_size);
                // sum = 0;
                //int sum = psList.size();
                int is_load_finish = sum <= pos + page_size ? 1 : 0;
                if (sum == 0)
                    is_load_finish = 0;
                    StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");

                //jo.put("actq0",dlist.get(0));
                //jo.put("actq1",dlist.get(1));

                if (sum > 0) {
                    JSONArray ja = new JSONArray();

                    try {


                        for (int i = 0; i < psList.size(); i++) {
                            ProductStock p = psList.get(i);
                            float activity = p.getActivity();
                            if(p.getCreatetime()==null){
                                p.setCreatetime(new Date());
                            }
                            Date createtime = p.getCreatetime();
                            Date date = mydate1;
                            long time1 = createtime.getTime();
                            long time2 = date.getTime();
                            long T = (time2 - time1) / (1000 * 3600 * 24); // 获得从入库时间到现在的时间
                            //double pow = Math.pow(Math.E, -(0.693 / 59.6*T))*activity; // 获取当前活度
                            double powsum = Math.pow(0.9884, T);
                            BigDecimal b   =   new   BigDecimal(powsum);
                            double  f1   =   b.setScale(4,   RoundingMode.HALF_UP).doubleValue();
                            double pow  = (p.getActivity()*f1);//公式修改




                            if(T==0){
                                if(T==0){
                                    pow = Double.valueOf(String.valueOf(p.getActivity()));
                                }
                            }
                            DecimalFormat df = new DecimalFormat("0.000");// 保留小数点后三位
                            //df.setRoundingMode(RoundingMode.FLOOR);
                            df.setRoundingMode(RoundingMode.HALF_UP);

                            double format = Double.parseDouble(df.format(pow));
                            int validity = ProductStock.validity(format); // 计算有效期
                            JSONObject jo2 = new JSONObject();
                            jo2.put("obj", JSON.toJSON(p));
                            jo2.put("pow", format);
                            jo2.put("validity",validity);
                            ja.put(jo2);
                        }
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                    jsonSb.append(ja);
                } else {
                    jsonSb.append("\"\"");
                }
                jsonSb.append(",\"type\":\"0\",\"dlist0\":\""+dlist.get(0)+"\",\"dlist1\":\""+dlist.get(1)+"\"}");

                out.print(jsonSb.toString());
                return;
            } catch (Throwable e) {

                Filex.logs("member.txt", "Members:" + act + "e" + e);
                e.printStackTrace();
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
                out.print(jo.toString());
                return;
            }
            // 修改||添加库存
        }else if("editPS".equals(act)){
            try {

                boolean flag = true;
                    if(MT.f(h.get("quality")).length()==0){
                        flag = false;
                    }
                    if(MT.f(h.get("batch")).length()==0){
                        flag = false;
                    }
                    if(MT.f(h.get("activity")).length()==0){
                        flag = false;
                    }
                    if(MT.f(h.get("createtime")).length()==0){
                        flag = false;
                    }
                    if(MT.f(h.get("amount")).length()==0){
                        flag = false;
                    }
                    if(MT.f(h.get("time")).length()==0){
                        flag = false;
                    }
                if(flag==false){
                    jo.put("type", "2");
                    jo.put("mes", "必填字段不能为空！");
                    out.print(jo.toString());
                    return;
                }

                int psid = h.getInt("psid");
                ProductStock p = ProductStock.find(psid);
                p.setCid(14102669); // 固定为:放射性碘 I-125 粒子
                p.setQuality(h.get("quality"));
                p.setBatch(h.get("batch"));
                p.setActivity(h.getFloat("activity"));
                p.setAmount(h.getInt("amount"));
                p.setCreatetime(h.getDate("createtime"));
                p.setTime(h.getDate("time"));
                p.setOrdernum(h.getInt("ordernum"));
                /*if(h.getInt("reserve")>p.getAmount()){ 先不做验证
                    jo.put("type", "1");
                    jo.put("mes", "预留数量不能大于库存数量！");
                    out.print(jo.toString());
                    return;
                }*/
                //p.setReserve(h.getInt("reserve"));
                p.set();
                // 记录操作
                StockOperation so = new StockOperation();
                so.setTime(new Date());
                so.setPsid(p.getPsid());
                so.setCid(14102669);
                so.setActivity(p.getActivity());
                so.setAmount(p.getAmount());
                so.setMember(h.member);
                so.setOid(0);
                so.setReserve(p.getReserve());

                if(p == null){ // 添加库存
                    so.setType(2);
                    if(p.getReserve() > 0){
                        so.setDescribe("添加库存数量:" + p.getAmount() + "支,添加预留数量:" + p.getReserve()+"支");
                        so.setState(1);
                    }else{
                        so.setDescribe("添加库存,添加数量:" + p.getAmount()+"支");
                        so.setState(0);
                    }
                }else{ // 修改库存
                    so.setType(3);
                    if(p.getReserve() > 0){
                        so.setDescribe("修改库存数量:" + p.getAmount() + "支,修改预留数量:" + p.getReserve()+"支");
                        so.setState(1);
                    }else{
                        so.setDescribe("修改库存数量:" + p.getAmount()+"支");
                        so.setState(0);
                    }
                }
                so.set();
                jo.put("type", "0");
            } catch (Exception e) {
                e.printStackTrace();
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
            }
            out.print(jo.toString());
            return;
            // 根据id查询
        }else if("findPS".equals(act)){
            try {
                int psid = h.getInt("psid");
                ProductStock p = ProductStock.find(psid);
                jo.put("type","0");
                jo.put("obj",JSON.toJSON(p));
            } catch (Exception e) {
                e.printStackTrace();
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
            }
            out.print(jo.toString());
            return;

            // 修改预留数量
        }else if("editRes".equals(act)){

            try {
                int psid = h.getInt("psid");
                int reserve = h.getInt("reserve");
                ProductStock p = ProductStock.find(psid);
                /*if(reserve>p.getAmount()){
                    jo.put("type", "1");
                    jo.put("mes", "预留数量不能大于库存数量！");
                    out.print(jo.toString());
                    return;
                }*/
                p.setReserve(reserve);
                p.set();
                // 记录操作
                StockOperation so = new StockOperation();
                so.setTime(new Date());
                so.setPsid(p.getPsid());
                so.setCid(14102669);
                so.setActivity(p.getActivity());
                so.setAmount(p.getAmount());
                so.setMember(h.member);
                so.setOid(0);
                so.setReserve(p.getReserve());
                so.setType(3);
                so.setDescribe("修改预留数量:" + p.getReserve());
                so.setState(1);
                so.set();

                jo.put("type","0");
                jo.put("obj",JSON.toJSON(p));
            } catch (SQLException e) {
                e.printStackTrace();
                jo.put("type", "2");
                jo.put("mes", "系统异常，请重试！");
            }
            out.print(jo.toString());
            return;
            // 根据psid删除
        }else if("delPS".equals(act)){
            try {
                int psid = h.getInt("psid");
                // 记录操作
                ProductStock p = ProductStock.find(psid);
                StockOperation so = new StockOperation();
                so.setTime(new Date());
                so.setPsid(p.getPsid());
                so.setCid(14102669);
                so.setActivity(p.getActivity());
                so.setAmount(p.getAmount());
                so.setMember(h.member);
                so.setOid(0);
                so.setReserve(p.getReserve());
                so.setType(4);
                so.setDescribe("删除库存");
                if(p.getReserve() > 0){
                    so.setState(1);
                }else{
                    so.setState(0);
                }
                so.set();

                ProductStock.del(psid);
                jo.put("type", "0");
                jo.put("mes","操作执行成功!");
                out.println(jo);
                return;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                out.close();
            }
        }else if("findProductStockCount".equals(act)) {
        	try {
        		Profile p1 = Profile.find(h.member);
        		
        		String orderId = h.get("orderId");
        		ShopOrder so1 = ShopOrder.findByOrderId(orderId);
        		if(so1.getId()>0) {
        			p1 = Profile.find(so1.getMember());
        		}

        		int issalesman = p1.issalesman;
        		Date expecteddelivery = h.getDate("expecteddelivery");
        		if(expecteddelivery==null) {
        			expecteddelivery = new Date();
        		}
        		int count =  ProductStock.findStock(h.getDouble("activity"),h.getDouble("perce"),issalesman,expecteddelivery,0);
        		jo.put("type", "0");
        		jo.put("count", count);
        	}catch (Exception e) {
        		jo.put("type", "1");
        	}
        	out.println(jo.toString());
            return;
        }else if("findProductStockCountBack".equals(act)) {//后台查询库存
            try {
                Profile p1 = Profile.find(h.member);

                String orderId = h.get("orderId");
                ShopOrder so1 = ShopOrder.findByOrderId(orderId);
                if(so1.getId()>0) {
                    p1 = Profile.find(so1.getMember());
                }

                int issalesman = p1.issalesman;
                Date expecteddelivery = h.getDate("expecteddelivery");
                if(expecteddelivery==null) {
                    expecteddelivery = new Date();
                }
                int count =  ProductStock.findStock(h.getDouble("activity"),h.getDouble("perce"),issalesman,expecteddelivery,1);
                jo.put("type", "0");
                jo.put("count", count);
            }catch (Exception e) {
                jo.put("type", "1");
            }
            out.println(jo.toString());
            return;
        }else if("editPSList".equals(act)){//批量添加库存
            try {

                String [] qualitys = h.getValues("quality");
                String [] batchs = h.getValues("batch");
                String [] createtimes = h.getValues("createtime");
                String [] activitys = h.getValues("activity");
                String [] amounts = h.getValues("amount");
                String [] times = h.getValues("time");
                //ProductStock.ProductStockField[j]

                boolean flag = true;
                for (int i = 0; i < qualitys.length ;i++) {
                    if(MT.f(qualitys[i]).length()==0){
                        flag = false;
                        break;
                    }
                    if(MT.f(batchs[i]).length()==0){
                        flag = false;
                        break;
                    }
                    if(MT.f(createtimes[i]).length()==0){
                        flag = false;
                        break;
                    }
                    if(MT.f(activitys[i]).length()==0){
                        flag = false;
                        break;
                    }
                    if(MT.f(amounts[i]).length()==0){
                        flag = false;
                        break;
                    }
                    if(MT.f(times[i]).length()==0){
                        flag = false;
                        break;
                    }
                }
                if(flag==false){
                    jo.put("type", "2");
                    jo.put("mes", "必填字段不能为空！");
                    out.print(jo.toString());
                    return;
                }


                for (int i = 0; i < qualitys.length ;i++) {

                    String quality = qualitys[i];
                    String batch = batchs[i];
                    float activity = Float.parseFloat(activitys[i]);
                    Date cdate = DateUtil.strToDateLong(createtimes[i]);
                    ProductStock p = ProductStock.find(quality,batch,activity,cdate);

                    p.setCid(14102669); // 固定为:放射性碘 I-125 粒子
                    p.setQuality(qualitys[i]);
                    p.setBatch(batchs[i]);
                    p.setActivity(Float.parseFloat(activitys[i]));
                    p.setAmount((int)Float.parseFloat(amounts[i]));
                    //Date cdate = DateUtil.strToDateLong(createtimes[i]);
                    p.setCreatetime(cdate);
                    Date time = DateUtil.strToDateLong(times[i]);
                    p.setTime(time);

                /*if(h.getInt("reserve")>p.getAmount()){ 先不做验证
                    jo.put("type", "1");
                    jo.put("mes", "预留数量不能大于库存数量！");
                    out.print(jo.toString());
                    return;
                }*/
                    p.setReserve(0);
                    p.set();
                    // 记录操作
                    StockOperation so = new StockOperation();
                    so.setTime(new Date());
                    so.setPsid(p.getPsid());
                    so.setCid(14102669);
                    so.setActivity(p.getActivity());
                    so.setAmount(p.getAmount());
                    so.setMember(h.member);
                    so.setOid(0);
                    so.setReserve(p.getReserve());

                    //if(p == null){ // 添加库存
                        so.setType(2);
                        if(p.getReserve() > 0){
                            so.setDescribe("添加库存数量:" + p.getAmount() + "支,添加预留数量:" + p.getReserve()+"支");
                            so.setState(1);
                        }else{
                            so.setDescribe("添加库存,添加数量:" + p.getAmount()+"支");
                            so.setState(0);
                        }
                   //}
                    so.set();
                }

                int isclaer = h.getInt("isclaer" );
                if(isclaer==0){
                    int daycount = ProductStock.count(" AND time = "+ Database.cite(MT.f(new Date())));
                    if(daycount>0){//有今天库存
                        List<ProductStock> pslist = ProductStock.find(" AND time <> "+ Database.cite(MT.f(new Date())),0,Integer.MAX_VALUE);
                        for (int x = 0; x < pslist.size(); x++) {
                            ProductStock p = pslist.get(x);
                            p.setAmount(0);
                            p.set();

                            // 记录操作
                            StockOperation so = new StockOperation();
                            so.setTime(new Date());
                            so.setPsid(p.getPsid());
                            so.setCid(14102669);
                            so.setActivity(p.getActivity());
                            so.setAmount(p.getAmount());
                            so.setMember(h.member);
                            so.setOid(0);
                            so.setReserve(p.getReserve());
                            so.setType(3);
                            so.setDescribe("导入时检查过期库存，设置数量为0");
                            so.setState(0);
                            so.set();

                        }
                    }
                }



                //for(){}

                //int psid = h.getInt("psid");

                jo.put("type", "0");
            } catch (Exception e) {
                e.printStackTrace();
                jo.put("type", "2");
                jo.put("mes", "数据异常，请检查后重试！");
            }
            out.print(jo.toString());
            return;
            // 根据id查询
        }else if ("daochu".equals(act)) {//导出商品库存
            List<String> headerList = Lists.newArrayList();
            headerList.add("序号");
            headerList.add("产品名称");
            headerList.add("质检号");
            headerList.add("批号");
            headerList.add("检验时间");
            headerList.add("入库时间");
            headerList.add("入库活度(mCi)");
            headerList.add("当前活度(mCi)");
            headerList.add("库存数量/支");
            headerList.add("有效期(天)");
            ExportExcel ee = new ExportExcel("商品库存", headerList, "商品库存");

            int count = 1;
            List<List<String>> dataList = Lists.newArrayList();



            int page_size = h.getInt("page_size");
            int pos = h.getInt("pos");

            StringBuffer sql = new StringBuffer();
            String quality = h.get("quality");

            if (!"".equals(quality) && quality != null) {
                sql.append(" and quality="+DbAdapter.cite(quality));
            }

            String batch = h.get("batch");

            if (!"".equals(batch) && batch != null) {
                sql.append(" and batch="+DbAdapter.cite(batch));
            }
            Date t0=h.getDate("t0");
            if(t0!=null)
            {
                sql.append(" AND createtime>"+DbAdapter.cite(t0));
            }
            Date t1=h.getDate("t1");
            if(t1!=null)
            {
                sql.append(" AND createtime<"+DbAdapter.cite(t1));
            }

            double actq = h.getDouble("activity");

            List<Double> dlist = ProductStock.getAct(actq,0.03);
            if(actq!=0){
                sql.append(" AND cast((select activity * power(0.9884,datediff(day,createtime,getdate())))   as   numeric(5,3)) >="+dlist.get(1)+" AND cast((select activity * power(0.9884,datediff(day,createtime,getdate())))   as   numeric(5,3)) < "+dlist.get(0));
            }


            String[] SQL = {" AND  (amount+reserve) > 0 ", "   "};
            int tab = h.getInt("tab", 0);
            sql.append(SQL[tab]);

            int sum = 0;
            try {
                sum = ProductStock.count(sql.toString());
            } catch (SQLException e) {
                e.printStackTrace();
            }

            sql.append(" order by cast((select activity * power(0.9884,datediff(day,createtime,getdate())))   as   numeric(5,3)) ");
            // sum = 0;
            int is_load_finish = sum <= pos + page_size ? 1 : 0;
            if (sum == 0)
                is_load_finish = 0;
            StringBuilder jsonSb = new StringBuilder("{\"is_load_finish\":\"" + is_load_finish + "\",\"sum\":\"" + sum + "\",\"data_list\":");

            if (sum > 0) {
                JSONArray ja = new JSONArray();

                try {
                    List<ProductStock> psList = ProductStock.find(sql.toString(),0,Integer.MAX_VALUE);
                    for (int i = 0; i < psList.size(); i++) {
                        ProductStock p = psList.get(i);
                        float activity = p.getActivity();
                        if (p.getCreatetime() == null) {
                            p.setCreatetime(new Date());
                        }
                        Date createtime = p.getCreatetime();
                        Date date = new Date();
                        long time1 = createtime.getTime();
                        long time2 = date.getTime();
                        long T = (time2 - time1) / (1000 * 3600 * 24); // 获得从入库时间到现在的时间
                        //double pow = Math.pow(Math.E, -(0.693 / 59.6 * T)) * activity; // 获取当前活度
                        double powsum = Math.pow(0.9884, T);
                        BigDecimal b   =   new   BigDecimal(powsum);
                        double  f1   =   b.setScale(4,   RoundingMode.HALF_UP).doubleValue();
                        double pow  = (p.getActivity()*f1);//公式修改
                        if (T == 0) {
                            if (T == 0) {
                                pow = Double.valueOf(String.valueOf(p.getActivity()));
                            }
                        }
                        DecimalFormat df = new DecimalFormat("0.000");// 保留小数点后三位
                        //df.setRoundingMode(RoundingMode.FLOOR);
                        df.setRoundingMode(RoundingMode.HALF_UP);

                        double format = Double.parseDouble(df.format(pow));
                        int validity = ProductStock.validity(format); // 计算有效期
                        List<String> dataRowList = Lists.newArrayList();
                        dataRowList.add(i+1+"");
                        dataRowList.add("放射性碘 I-125 粒子");
                        dataRowList.add(p.getQuality());
                        dataRowList.add(p.getBatch());
                        dataRowList.add(createtime+"");
                        dataRowList.add(p.getTime()+"");
                        dataRowList.add(p.getActivity()+"");
                        dataRowList.add(format+"");
                        dataRowList.add(p.amount+"");
                        dataRowList.add(validity+"");
                        dataList.add(dataRowList);

                    }

                    for (int i = 0; i < dataList.size(); i++) {
                        Row row = ee.addRow();
                        for (int j = 0; j < dataList.get(i).size(); j++) {
                            ee.addCell(row, j, dataList.get(i).get(j));
                        }
                    }
                    ee.write(req, resp, "商品库存.xlsx");
                    ee.dispose();





                }catch (Throwable e){
                    System.out.println(e.toString());
                }
            }
            return;
        }



    }



}
