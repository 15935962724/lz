package tea.entity.yl.shop;

import java.util.Date;

public class TestStockOperation {
    public static void main(String[] args) {
        // 测试 下单 库存操作记录
        //test01();

        // 测试用户退单  库存操作记录
        test02();
    }

    private static void test02() {
        int i = StockOperation.setStill(19050075);
        System.out.println(i);
    }


    private static void test01() {
       /* int set = StockOperation.set(0.98, 100, 0.03, 1, 14100001,19050075,new Date());
        System.out.println(set);*/
    }

}
