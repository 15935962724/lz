package tea.ui.node.type.subscribe;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.admin.sales.Task;
import tea.entity.subscribe.PackageOrder;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditPackageOrderExcel extends TeaServlet{
	
	

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {

        request.setCharacterEncoding("UTF-8");

        TeaSession teasession = new TeaSession(request);

        String sql = request.getParameter("sql");
        String files = request.getParameter("files");
        String act = teasession.getParameter("act");

        response.setContentType("application/x-msdownload");
        response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(files + ".xls", "UTF-8"));
        javax.servlet.ServletOutputStream os = response.getOutputStream();
        try
        {
            jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
            jxl.write.WritableSheet ws = wwb.createSheet(files, 0);
            int i = 0;
            
            if ("PaymentOrders".equals(act)) //导出订单 电子报
            {
                ws.addCell(new jxl.write.Label(0, 0, "订单编号"));
                ws.addCell(new jxl.write.Label(1, 0, "下单时间"));
                ws.addCell(new jxl.write.Label(2, 0, "下单用户"));
                ws.addCell(new jxl.write.Label(3, 0, "套餐名称"));
                ws.addCell(new jxl.write.Label(4, 0, "套餐价格"));
                ws.addCell(new jxl.write.Label(5, 0, "付款状态"));
                ws.addCell(new jxl.write.Label(6, 0, "付款方式"));
                ws.addCell(new jxl.write.Label(7, 0, "付款时间"));
                ws.addCell(new jxl.write.Label(8, 0, "需要开票"));
                ws.addCell(new jxl.write.Label(9, 0, "发票开具状态"));
                ws.addCell(new jxl.write.Label(10, 0, "手动付款操作人"));
                ws.addCell(new jxl.write.Label(11, 0, "手动付款操作时间"));
                ws.addCell(new jxl.write.Label(12, 0, "生效状态"));
                ws.addCell(new jxl.write.Label(13, 0, "手动生效操作时间"));
                ws.addCell(new jxl.write.Label(14, 0, "手动生效操作时间"));
                  

            	java.util.Enumeration e = PackageOrder.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);

                while (e.hasMoreElements())
                {
                	
          		  String porder = ((String)e.nextElement());
        		  PackageOrder pobj = PackageOrder.find(porder);
        		  String type = "";
        		if(pobj.getType()==0)
        		{
        			type=	"未付款";
        		}else if(pobj.getType()==1)
        		{
        			type=	"已付款";
        		}        	 	  
                    ws.addCell(new jxl.write.Label(0, i + 1, porder));
                    ws.addCell(new jxl.write.Label(1, i + 1, pobj.getOrderstimeToString()));
                    ws.addCell(new jxl.write.Label(2, i + 1, pobj.getMember()));
                    ws.addCell(new jxl.write.Label(3, i + 1, pobj.getSname()));
                    ws.addCell(new jxl.write.Label(4, i + 1, "￥"+pobj.getMarketprice()+"/＄"+pobj.getPromotionsprice() ));
                    ws.addCell(new jxl.write.Label(5, i + 1, type));
                    ws.addCell(new jxl.write.Label(6, i + 1, pobj.getPayname()));
                    ws.addCell(new jxl.write.Label(7, i + 1, pobj.getPaytimeToString()));
                    ws.addCell(new jxl.write.Label(8, i + 1, pobj.WHETHERMAIL_TYPE[pobj.getWhethermail()] ));
                    ws.addCell(new jxl.write.Label(9, i + 1, pobj.ISSUED_TYPE[pobj.getIssued()]));
                    ws.addCell(new jxl.write.Label(10, i + 1, pobj.getPaymentmember()));
                    ws.addCell(new jxl.write.Label(11, i + 1, pobj.getPaymenttimeToString()));
                    ws.addCell(new jxl.write.Label(12, i + 1, pobj.EFFECT_TYPE[pobj.getEffect()]));
                    ws.addCell(new jxl.write.Label(13, i + 1, pobj.getEffectmember()));
                    ws.addCell(new jxl.write.Label(14, i + 1, pobj.getEffecttimeToString()));
                    
                    i++;
                }
            } 
  
            wwb.write();
            wwb.close();

            os.close();
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }


}
