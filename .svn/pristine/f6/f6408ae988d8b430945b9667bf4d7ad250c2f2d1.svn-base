<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="jxl.format.UnderlineStyle" %>
<%@ page import="jxl.format.Colour" %>
<%@ page import="jxl.write.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

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


            //设置字体
            WritableFont font = new WritableFont(WritableFont.ARIAL,10,WritableFont.BOLD,false,UnderlineStyle.NO_UNDERLINE,Colour.BLACK);
            WritableCellFormat cFormat = new WritableCellFormat(font);


			int i = 0,j=0;
			if("SaleOrders_1s".equals(act))
			{

              ws.addCell(new jxl.write.Label(j++,0,"订单号"));
              ws.addCell(new jxl.write.Label(j++,0,"下单时间"));
              ws.addCell(new jxl.write.Label(j++,0,"下单会员"));
              ws.addCell(new jxl.write.Label(j++,0,"下单总价"));
              ws.addCell(new jxl.write.Label(j++,0,"省(洲)"));
              ws.addCell(new jxl.write.Label(j++,0,"收货地址"));
              ws.addCell(new jxl.write.Label(j++,0,"电子邮箱"));
              ws.addCell(new jxl.write.Label(j++,0,"收货人姓名"));
              ws.addCell(new jxl.write.Label(j++,0,"收货人单位"));
              ws.addCell(new jxl.write.Label(j++,0,"收货人邮编"));
              ws.addCell(new jxl.write.Label(j++,0,"收货人电话"));

              java.util.Enumeration e=Trade.find2(teasession._strCommunity,sql.toString(),0, Integer.MAX_VALUE);

              while(e.hasMoreElements())
              {
                String trade=(String)e.nextElement();
                Trade obj=Trade.find(trade);

                Profile p=Profile.find(obj.getCustomer().toString(),teasession._strCommunity);//obj.getTradeCode()

                ws.addCell(new jxl.write.Label(0,i + 1,trade));
                ws.addCell(new jxl.write.Label(1,i + 1,obj.getTime().toString()));
                ws.addCell(new jxl.write.Label(2,i + 1,p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)));
                ws.addCell(new jxl.write.Label(3,i + 1,String.valueOf(TradeItem.sumByTrade(trade))));
                ws.addCell(new jxl.write.Label(4,i + 1,String.valueOf(tea.entity.util.Card.find(Integer.parseInt(obj.getCity(teasession._nLanguage))))));
                ws.addCell(new jxl.write.Label(5,i + 1,obj.getAddress(teasession._nLanguage).replaceAll("</","&lt;/")));
                ws.addCell(new jxl.write.Label(6,i + 1,obj.getEmail()));
                ws.addCell(new jxl.write.Label(7,i + 1,p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)));
                ws.addCell(new jxl.write.Label(8,i + 1,obj.getOrganization(teasession._nLanguage)));
                ws.addCell(new jxl.write.Label(9,i + 1,obj.getZip(teasession._nLanguage)));
                ws.addCell(new jxl.write.Label(10,i + 1,obj.getTelephone(teasession._nLanguage)));
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



%>

