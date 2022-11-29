package tea.ui.yl.shop;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;


import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.yl.shop.ShortState;
import tea.ui.TeaServlet;


public class ShortStatus extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
    	 response.setContentType("text/html; charset=UTF-8");
         Http h = new Http(request,response);
         try{
        	 String AccountID=h.get("AccountID");
        	 String MsgID=h.get("MsgID");
        	 String MobilePhone=h.get("MobilePhone");
        	 String ReportResultInfo=h.get("ReportResultInfo");
        	 String ReportState=h.get("ReportState");
        	 String SendResultInfo=h.get("SendResultInfo");
        	 String SendState=h.get("SendState");
        	 String SPNumber=h.get("SPNumber");
        	 String ReportTime=h.get("ReportTime","");
			 String SendedTime = h.get("SendedTime","");
        	 Filex.logs("ShortStatus.txt","AccountID="+AccountID+"&MsgID="+MsgID+"&MobilePhone="+MobilePhone+"&ReportResultInfo="+ReportResultInfo+"&ReportState="+ReportState+"&ReportTime="+ReportTime+"&SendedTime="+SendedTime+"&SendResultInfo="+SendResultInfo+"&SendState="+SendState+"&SPNumber="+SPNumber+"");
        	 //System.out.println(request.getRequestURL().toString()+request.getQueryString());
			 ShortState ss=new ShortState();
			 ss.setAccountID(AccountID);
			 ss.setMessageID(MsgID);
			 ss.setMobilePhone(MobilePhone);
			 ss.setReportResultInfo(ReportResultInfo);
			 ss.setReportState("true".equals(ReportState.toLowerCase())?1:0);
			 ss.setSendResultInfo(SendResultInfo);
			 ss.setSendState("true".equals(SendState.toLowerCase())?1:0);
			 ss.setSPNumber(SPNumber);
			 if(ReportTime.length()>1){
				 ss.setReportTime(ShortState.sdf.parse(ReportTime));
			 }
			 if(SendedTime.length()>1){
				 ss.setSendedTime(ShortState.sdf.parse(SendedTime));
			 }
			 ss.set();
         }catch(Exception e){
        	 e.printStackTrace();
         }
         
    }
 }
    
