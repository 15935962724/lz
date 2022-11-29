package tea.ui.node.type.meeting;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jxl.SheetSettings;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import tea.entity.Http;
import tea.entity.admin.AdminUnit;
import tea.entity.node.Meeting;
import tea.entity.node.MeetingApplicants;
import tea.entity.node.MeetingInvite;
import tea.entity.node.Node;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditMeetingInvite extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        java.io.PrintWriter out = response.getWriter();

        try
        {
            TeaSession teasession = new TeaSession(request);
            Http h = new Http(request);
            String act = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            String info = "操作执行成功！";
            out.println("<script>var mt=parent.mt;</script>");
            if("invite".equals(act)){
            	Meeting ym = Meeting.find(teasession._nNode,teasession._nLanguage);
            	if(ym.getTimeStop().getTime()>=new Date().getTime()){
            		String adminiunits = teasession.getParameter("adminunits");
                	String[] unitArr = adminiunits.split("/");
                	for(int i=0;i<unitArr.length;i++){
                		int adminunitid = Integer.parseInt(unitArr[i]);
                		MeetingInvite ymi = MeetingInvite.find(teasession._nNode,adminunitid);
                		ymi.setState(0);
                		ymi.setTime(new Date());
                		ymi.set();
                		info="会议报名部门邀请成功！";
                	}
            	}else{
            		info="抱歉，已过报名时间，不可再邀请！";
            	}
            	out.print("<script language='javascript'>alert('"+info+"');mt.refresh('"+nexturl+"');</script> ");
				return;
            }else if("inviteDel".equals(act)){
            	MeetingInvite ymi = MeetingInvite.find(Integer.parseInt(teasession.getParameter("miid")));
            	ymi.delete();
            	info = "会议报名部门取消邀请成功！";
            	out.print("<script language='javascript'>alert('"+info+"');mt.refresh('"+nexturl+"');</script> ");
            	return;
            }else if("Verifg".equals(act)){
            	int  id =Integer.parseInt(teasession.getParameter("id"));
            	int state = Integer.parseInt(teasession.getParameter("state"));
                MeetingInvite ymi = MeetingInvite.find(id);
                ymi.setState(state);
        	    ymi.set();
        	    out.print("<script language='javascript'>mt.closeRegistration();</script> ");
        	    return;
            }else if("WestracMeetingMemberListVerifg".equals(act))
            {
            	//确认会议报名部门
            	int id = Integer.parseInt(teasession.getParameter("id"));
            	MeetingInvite eobj = MeetingInvite.find(id);
            	//确认
            	if(eobj.getState()==1)
            	{
            		eobj.setState(2);
            		eobj.set();
            		info="会议报名确认通过！";
            	}else if(eobj.getState()==2)
            	{
            		eobj.setState(1);
            		eobj.set();
            		info="会议报名取消确认!";
            	}
            	out.print("<script language='javascript'>alert('"+info+"');mt.refresh('"+nexturl+"');</script> ");
            	return;
            	
            }else if("WestracMeetingInviteListDelete".equals(act))
            {
            	//删除会议邀请的部门
            	int id = Integer.parseInt(teasession.getParameter("id"));
            	MeetingInvite eobj = MeetingInvite.find(id);
            	ArrayList maList = MeetingApplicants.find(" AND node="+eobj.getNode()+" AND adminunitid="+eobj.getAdminunitid(), 0, Integer.MAX_VALUE);
                for(int i=0;i<maList.size();i++){
                	MeetingApplicants ma = (MeetingApplicants)maList.get(i);
                	ma.delete();
                }
            	eobj.delete();
            	out.print("<script language='javascript'>alert('"+info+"');mt.refresh('"+nexturl+"');</script> ");
            	return;
            }else if("WestracMeetingMemberListVerifgALL".equals(act))
            {
            	//报名部门批量审核
            	 String value[] = request.getParameterValues("checkmid");

		            if(value != null)
		            {
		                for(int index = 0;index < value.length;index++)
		                {

		                    int  id =Integer.parseInt(value[index]);
		                    MeetingInvite ymi = MeetingInvite.find(id);


		            	    if(ymi.getState()==1)
		            	    {
		            	    	ymi.setState(2);
		            	    	ymi.set();
		            	    	info = "会议报名部门审核成功";
		            	    }else  if(ymi.getState()==2)
		            	    {
		            	    	ymi.setState(1);
		            	    	ymi.set();
		            	    	info = "会议报名部门取消审核成功";
		            	    }
		                }

						//out.print("<script  language='javascript'>alert('"+str+"');window.open('"+nexturl+"&state="+teasession.getParameter("state")+"','tar');</script> ");
						out.print("<script language='javascript'>alert('"+info+"');mt.refresh('"+nexturl+"');</script> ");
						return;
		            }
            }else if("WestracInviteMemberListDeleteALL".equals(act))
            {
            	//报名部门批量删除
            	 String value[] = request.getParameterValues("checkmid");

		            if(value != null)
		            {

		            	//boolean f = false;
		                for(int index = 0;index < value.length;index++)
		                {
		                    int  id =Integer.parseInt(value[index]);
		                    MeetingInvite ymi = new MeetingInvite(id);
		                    //查询到所在部门的参会人员，并删除
		                    ArrayList ymaList = MeetingApplicants.find(" AND node="+ymi.getNode()+" AND adminunitid="+ymi.getAdminunitid(), 0, Integer.MAX_VALUE);
		                    for(int i=0;i<ymaList.size();i++){
		                    	MeetingApplicants yma = (MeetingApplicants)ymaList.get(i);
		                    	yma.delete();
		                    }		                    
		                    ymi.delete();
		                }
		                info = "会议报名部门删除成功！";
						//out.print("<script  language='javascript'>alert('会议报名部门删除成功');window.open('"+nexturl+"','tar');</script> ");
		                out.print("<script language='javascript'>alert('"+info+"');mt.refresh('"+nexturl+"');</script> ");
						return;
		            }
            }else if("exportReportExcel".equals(act)){
            	response.reset();
            	response.setContentType("text/html; charset=UTF-8");
                response.setHeader("Cache-Control","private");
                response.setContentType("application/octet-stream");
                //String fname = request.getPathInfo().substring(1);
                response.setHeader("Content-Disposition","attachment;filename=MeetingReport.xls");
                
                WritableCellFormat TE,AD,TH,ROOT,TD1,TD2;
                //主题
            	TE = new WritableCellFormat(new WritableFont(WritableFont.createFont("宋体"),12,WritableFont.BOLD));
            	TE.setBorder(Border.RIGHT,BorderLineStyle.THIN);
            	TE.setAlignment(Alignment.CENTRE);
            	TE.setVerticalAlignment(VerticalAlignment.CENTRE);
            	
            	//地址
            	AD = new WritableCellFormat(new WritableFont(WritableFont.createFont("宋体"),20,WritableFont.BOLD));
            	AD.setBorder(Border.ALL,BorderLineStyle.THIN);
            	AD.setAlignment(Alignment.CENTRE);
            	AD.setVerticalAlignment(VerticalAlignment.CENTRE);
            	
            	//标题
                TH = new WritableCellFormat(new WritableFont(WritableFont.createFont("宋体"),12,WritableFont.BOLD));
                TH.setBorder(Border.ALL,BorderLineStyle.THIN);
                TH.setAlignment(Alignment.CENTRE);
                TH.setVerticalAlignment(VerticalAlignment.CENTRE);
                TH.setWrap(true);
            	
            	//一级
            	ROOT = new WritableCellFormat(new WritableFont(WritableFont.createFont("黑体"),12,WritableFont.BOLD));
            	ROOT.setBorder(Border.RIGHT,BorderLineStyle.THIN);
            	ROOT.setAlignment(Alignment.LEFT);
            	ROOT.setVerticalAlignment(VerticalAlignment.CENTRE);
            	
                //序号和数据TD1
            	TD1 = new WritableCellFormat(new WritableFont(WritableFont.ARIAL,12));
            	TD1.setBorder(Border.ALL,jxl.format.BorderLineStyle.THIN); 
            	TD1.setAlignment(Alignment.CENTRE);
            	TD1.setVerticalAlignment(VerticalAlignment.CENTRE);
            	TD1.setWrap(true);
            	
            	//TD2
            	TD2 = new WritableCellFormat(new WritableFont(WritableFont.createFont("宋体"),12));
            	TD2.setBorder(Border.ALL,jxl.format.BorderLineStyle.THIN);
            	TD2.setAlignment(Alignment.LEFT);
            	TD2.setVerticalAlignment(VerticalAlignment.CENTRE);
            	
            	int node = Integer.parseInt(teasession.getParameter("node"));
            	Node nobj = Node.find(node);
            	Meeting ym = Meeting.find(node, teasession._nLanguage);
            	
            	OutputStream os = response.getOutputStream();
                WritableWorkbook ww = Workbook.createWorkbook(os);
                WritableSheet ws = ww.createSheet(nobj.getSubject(teasession._nLanguage)+"报表",0);
                
                SheetSettings ss =  ws.getSettings();//设置sheet表格式
                //ss.setHorizontalFreeze(2);//冻结前两行
                ss.setVerticalFreeze(2);
                
                int col = 0,row = 0;
                
                ws.setRowView(0,840);//第一行行高
                ws.setRowView(1,400);//第二行行高
                ws.setColumnView(0,15);
                ws.setColumnView(1,15);
                ws.setColumnView(2,6);
                ws.setColumnView(3,15);
                ws.setColumnView(4,18);
                ws.setColumnView(5,20);
                ws.setColumnView(6,18);
                
                ws.mergeCells(col,row,6,row);
                ws.addCell(new Label(col,row,nobj.getSubject(teasession._nLanguage)+"报表",TE));
                
                row++;
                //TH
                ws.addCell(new Label(col++,row,"部门",TH));
                ws.addCell(new Label(col++,row,"姓名",TH));
                ws.addCell(new Label(col++,row,"性别",TH));
                ws.addCell(new Label(col++,row,"联系电话",TH));
                ws.addCell(new Label(col++,row,"是否安排餐饮",TH));
                ws.addCell(new Label(col++,row,"是否安排住宿",TH));
                ws.addCell(new Label(col++,row,"是否安排接送",TH));
                ArrayList ymiList = MeetingInvite.find(" AND node="+node+" AND state=2 order by time desc", 0, Integer.MAX_VALUE);
                int index=row;
                for(int i=0;i<ymiList.size();i++){
                	MeetingInvite ymi = (MeetingInvite)ymiList.get(i);
                	AdminUnit au = AdminUnit.find(ymi.getAdminunitid());
                	ArrayList ymaList = MeetingApplicants.find(" AND node="+node+" AND adminunitid="+ymi.getAdminunitid()+" order by time desc", 0, Integer.MAX_VALUE);
                	if(ymaList!=null&&ymaList.size()>0){
                		for(int j=0;j<ymaList.size();j++){
                    		col=1;
                    		index++;
                    		MeetingApplicants yma = (MeetingApplicants)ymaList.get(j);
                         	ws.addCell(new Label(col++,index,yma.getName(),TD1));
                         	String sex = yma.getSex()==0?"女":"男";
                         	ws.addCell(new Label(col++,index,sex,TD1));
                         	ws.addCell(new Label(col++,index,yma.getTel(),TD1));
                         	String catering = yma.getCatering()==0?"是":"否";
                         	ws.addCell(new Label(col++,index,catering,TD1));
                         	String stay = yma.getSex()==0?yma.getHotelname()+"："+yma.getHoteladdress():"否";
                         	ws.addCell(new Label(col++,index,stay,TD1));
                         	String shuttle = yma.getShuttle()==0?"是":"否";
                         	ws.addCell(new Label(col++,index,shuttle,TD1));
                         }
                	}
                	col = 0;
                	row++;
                	ws.mergeCells(col,row,col,index);
                	ws.addCell(new Label(col,row,au.name,TD1));
                	row=index;
                	
                }
                /*ArrayList ymaList = MeetingApplicants.find(" AND node="+node+" order by adminunit,time", 0, Integer.MAX_VALUE);
                for(int i=0;i<ymaList.size();i++){
                	MeetingApplicants yma = (MeetingApplicants)ymaList.get(i);
                	
                }*/
                ww.write();
                ww.close();
           	 	os.close();
            	return;
            }
            out.print("<script>mt.show('" + info + "',1,\"" + nexturl + "\");</script>");
            /*if(nexturl!=null && nexturl.length()>0)
            {
            	//response.sendRedirect(nexturl+"&adminrole="+teasession.getParameter("adminrole"));

            	 out.print("<script>window.open('" + nexturl + "','_parent');</script>");
            	 out.close();

            	return;
            }*/
        } catch (Exception ex)
        {
            response.sendRedirect("/jsp/info/Error.jsp?info=" + ex.getMessage());
            ex.printStackTrace();
        }finally
        {
        	 out.close();
        }
    }

}
