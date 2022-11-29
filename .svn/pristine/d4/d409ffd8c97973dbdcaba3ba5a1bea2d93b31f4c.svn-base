package tea.entity.yl.shop;

import java.math.BigDecimal;
import java.text.DecimalFormat;

import util.Config;

public class qdr {
	public static void main(String[] args) {
		//System.out.println(Config.getString("gaoke")+"===");
		//System.out.println(Math.pow(Math.E,-0.05813758389261744966442953020134));
		//System.out.println(StockOperation.setStill(19050252));
		/*BigDecimal b2=new BigDecimal(23.33333);
		double taxamount2=b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
		System.out.println(taxamount2);*/
		/*String str = ",";
		String [] strs = str.split(",");
		System.out.println(strs.length);*/
		double f1 = 480000.0;
		double f2 = 442314.9;
		BigDecimal b2=new BigDecimal(f1-f2);
		double taxamount2=b2.setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue();
		DecimalFormat df = new DecimalFormat("######0.00"); 
		
		/*BigDecimal b2=new BigDecimal(480000.0-442314.9);
		float taxamount2=(float) b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();//服务费
*/		System.out.println(taxamount2+"==="+df.format(taxamount2)+"==="+(f1-f2));
	}
}
