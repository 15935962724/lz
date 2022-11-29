package tea.ui.type.perform;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import tea.ui.*;
import tea.entity.admin.cebbank.*;
import java.math.*;

import jxl.write.*;
import tea.entity.admin.sales.*;
import tea.entity.admin.*;
import tea.entity.member.*;
import tea.entity.node.*;


public class ExportExcel extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("/tea/resource/Annuity");
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // response.setHeader("Expires", "0");
        // response.setHeader("Cache-Control", "no-cache");
        // response.setHeader("Pragma", "no-cache");

        request.setCharacterEncoding("UTF-8");

        TeaSession teasession = new TeaSession(request);
        String sql = request.getParameter("sql");
        String files = request.getParameter("files");
        String act = request.getParameter("act");

        response.setContentType("application/x-msdownload");
        response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(files + ".xls", "UTF-8"));
        javax.servlet.ServletOutputStream os = response.getOutputStream();
        try
        {
            jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
            jxl.write.WritableSheet ws = wwb.createSheet(files, 0);
            int i = 0;
            if ("OrderPiaoList".equals(act)) //订单统计
            {
                ws.addCell(new jxl.write.Label(0, 0, "订单号"));
                ws.addCell(new jxl.write.Label(1, 0, "姓名"));
                ws.addCell(new jxl.write.Label(2, 0, "手机"));
                ws.addCell(new jxl.write.Label(3, 0, "电话"));
                ws.addCell(new jxl.write.Label(4, 0, "证件"));
                ws.addCell(new jxl.write.Label(5, 0, "证件号"));
                ws.addCell(new jxl.write.Label(6, 0, "数量"));
                ws.addCell(new jxl.write.Label(7, 0, "总价"));

               java.util.Enumeration pen = PerformOrders.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
                	while(pen.hasMoreElements())
                	{
                		String poid = ((String)pen.nextElement());
                		PerformOrders  poobj = PerformOrders.find(poid); 

                    ws.addCell(new jxl.write.Label(0, i + 1, poid));
                    ws.addCell(new jxl.write.Label(1, i + 1, poobj.getNames()));
                    ws.addCell(new jxl.write.Label(2, i + 1, poobj.getYddh()));
                    ws.addCell(new jxl.write.Label(3, i + 1, poobj.getGddh()));
                    ws.addCell(new jxl.write.Label(4, i + 1, PerformOrders.ZJLX_TYPE[poobj.getZjlx()]));
                    ws.addCell(new jxl.write.Label(5, i + 1, poobj.getZjhm()));
                    ws.addCell(new jxl.write.Label(6, i + 1, String.valueOf(poobj.getQuantity())));
                    ws.addCell(new jxl.write.Label(7, i + 1, String.valueOf(poobj.getTotalprice().add(new BigDecimal(poobj.getFare())))));
                    i++;
                }
            }else if("WrongTickets".equals(act))//错票处理
            {
            	
            	 ws.addCell(new jxl.write.Label(0, 0, "票据编号"));
                 ws.addCell(new jxl.write.Label(1, 0, "演出名称"));
                 ws.addCell(new jxl.write.Label(2, 0, "演出场馆"));
                 ws.addCell(new jxl.write.Label(3, 0, "座位位置"));
                 ws.addCell(new jxl.write.Label(4, 0, "演出时间"));
                 ws.addCell(new jxl.write.Label(5, 0, "演出价格"));
                 ws.addCell(new jxl.write.Label(6, 0, "售票员"));
                                
            	 java.util.Enumeration pen = BouncePiao.find(sql.toString(),0,Integer.MAX_VALUE);
            	 {
            		 while(pen.hasMoreElements())
            	      	{
            	      		int orderdetails_id = ((Integer)pen.nextElement());
            	      		BouncePiao  bpobj = BouncePiao.find(orderdetails_id); 
            	      		PerformStreak psobj =PerformStreak.find(bpobj.getPsid());
            	      		Node nobj1 = Node.find(psobj.getNode());
            	      		Node nobj2 = Node.find(psobj.getVenues());
            	      		Venues vobj = Venues.find(psobj.getVenues());
            	      	
                            ws.addCell(new jxl.write.Label(0, i + 1, String.valueOf(orderdetails_id)));
                            ws.addCell(new jxl.write.Label(1, i + 1, nobj1.getSubject(teasession._nLanguage)));
                            ws.addCell(new jxl.write.Label(2, i + 1, nobj2.getSubject(teasession._nLanguage)));
                            ws.addCell(new jxl.write.Label(3, i + 1, bpobj.getWeizhi()));
                            ws.addCell(new jxl.write.Label(4, i + 1, BouncePiao.sdf2.format(bpobj.getPftime())));
                            ws.addCell(new jxl.write.Label(5, i + 1, String.valueOf(bpobj.getPrice())));
                            ws.addCell(new jxl.write.Label(6, i + 1, bpobj.getMember()));
                          
                            i++;
            	    
            	      	}
            	      		
            	 }
            }else if("WebDrawabill".equals(act))//网上预订票已出票统计表
            { 
            	 ws.addCell(new jxl.write.Label(0, 0, "票据编号"));
                 ws.addCell(new jxl.write.Label(1, 0, "演出名称"));
                 ws.addCell(new jxl.write.Label(2, 0, "演出场馆"));
                 ws.addCell(new jxl.write.Label(3, 0, "座位位置"));
                 ws.addCell(new jxl.write.Label(4, 0, "演出时间"));
                 ws.addCell(new jxl.write.Label(5, 0, "演出价格"));
                 ws.addCell(new jxl.write.Label(6, 0, "售票员"));
                 java.util.Enumeration e = OrderDetails.find2(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
                 BigDecimal  tp = new BigDecimal("0");
 
     			while(e.hasMoreElements())
     			{
     				int orid =((Integer)e.nextElement()).intValue();
     				OrderDetails odobj = OrderDetails.find(orid);
     				PerformOrders poobj =PerformOrders.find(odobj.getOrderid());
     				tp = tp.add(odobj.getTotalprice());
     				
     				
     				  ws.addCell(new jxl.write.Label(0, i + 1, String.valueOf(orid)));
                      ws.addCell(new jxl.write.Label(1, i + 1, odobj.getPerformname()));
                      ws.addCell(new jxl.write.Label(2, i + 1, odobj.getPsname()));
                      ws.addCell(new jxl.write.Label(3, i + 1, odobj.getRegion()+odobj.getLinage()+"排"+odobj.getSeat()+"号"));
                      ws.addCell(new jxl.write.Label(4, i + 1, odobj.getPstime()));
                      ws.addCell(new jxl.write.Label(5, i + 1, String.valueOf(odobj.getTotalprice())));
                      ws.addCell(new jxl.write.Label(6, i + 1, poobj.getAdminMember()));
                    
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
