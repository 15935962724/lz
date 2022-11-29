package tea.ui.node.type.contribute;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

import tea.entity.custom.jjh.Voltype;
import tea.entity.custom.jjh.Volunteer;
import tea.entity.node.*;
import tea.entity.util.Card;
import tea.entity.*;
import java.text.*;

import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

public class EditContribute extends tea.ui.TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            if (teasession._rv == null)
            {
                teasession._rv = RV.ANONYMITY;
            }
            String act=teasession.getParameter("act");
            if("excel".equals(act)){
//				List list=Volunteer.findVolunteer("", 0, Integer.MAX_VALUE);
            	String sqls=teasession.getParameter("sqls");
            	Enumeration e=Node.find(sqls,0,Integer.MAX_VALUE);
//				pw.close();
				ServletOutputStream s=response.getOutputStream();
				WritableWorkbook ww=Workbook.createWorkbook(s);
				WritableSheet sheet=ww.createSheet("查询结果", 0);
				response.setContentType("application/x-msdownload");
				String name="捐赠信息表.xls";
				response.setHeader("Content-Disposition", "attachment; filename=\"" + new String(name.getBytes("GBK"),"ISO-8859-1") + "\"");
				WritableFont wf= new WritableFont(WritableFont.TIMES, 10,WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
				WritableCellFormat cf=new WritableCellFormat(wf);// 单元格定义
				cf.setAlignment(jxl.format.Alignment.LEFT); // 设置对齐方式
				// ws.getSettings().setPrintGridLines(true);//是否打印网格线

				String[] showcol=new String[]{"主题","捐赠项目/意向","类型","捐赠金额","时间","联系人","联系电话","地址","邮编","email","内容"};
				int cols=showcol.length;
				for(int i=0;i<cols;i++){
					sheet.setColumnView(i, 20); // 设置列的宽度
				}
				for(int i=0;i<cols;i++){
					sheet.addCell(new Label(i,0,showcol[i],cf));
				}
				int j=0;
				while(e.hasMoreElements()){
					int nodeid=(Integer)e.nextElement();
					Node node=Node.find(nodeid);
					Contribute con=Contribute.find(nodeid, teasession._nLanguage);
					String sub="";
					if(node.getSubject(teasession._nLanguage)!=null){
						sub=node.getSubject(teasession._nLanguage);
					}
					sheet.addCell(new Label(0,j+1,sub));
					String pro="";
					if(con.getProject()!=null){
						pro=con.getProject();
					}
					sheet.addCell(new Label(1,j+1,pro));
					String type=con.isClasses()==false?"个人":"单位";
					sheet.addCell(new Label(2,j+1,type));
					sheet.addCell(new Label(3,j+1,con.getMoneycount().toString()));
					String stime="";
					if(con.getTime()!=null){
						stime=Volunteer.sdf2.format(con.getTime());
					}
					sheet.addCell(new Label(4,j+1,stime));
					String linkman="";
					if(con.getLinkman()!=null){
						linkman=con.getLinkman();
					}
					sheet.addCell(new Label(5,j+1,linkman));
					String sphone="";
					if(con.getPhone()!=null){
						sphone=con.getPhone();
					}
					sheet.addCell(new Label(6,j+1,sphone));

					String sadd="";
					if(con.getAddress()!=null){
						sadd=con.getAddress();
					}
					sheet.addCell(new Label(7,j+1,sadd));

					String code="";
					if(con.getPostalcode()!=null){
						code=con.getPostalcode();
					}
					sheet.addCell(new Label(8,j+1,code));

					String ema="";
					if(con.getEmail()!=null){
						ema=con.getEmail();
					}
					sheet.addCell(new Label(9,j+1,ema));

					String txt="";
					if(node.getText(teasession._nLanguage)!=null){
						txt=node.getText(teasession._nLanguage);
					}
					sheet.addCell(new Label(10,j+1,txt));


					j++;
				}
//				sheet.addCell(new Label(0,j+1,"合计"));
				ww.write();
				ww.close();
				s.close();
            	return ;
            }
            Node node = Node.find(teasession._nNode);
            String subject = teasession.getParameter("Subject");
            String text = teasession.getParameter("Text");
            if (teasession.getParameter("NewNode") != null)
            {
                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                long options = node.getOptions();
                int options1 = node.getOptions1();
                int defautllangauge = node.getDefaultLanguage();
                Category obj = Category.find(teasession._nNode);
                teasession._nNode = Node.create(teasession._nNode, sequence, node.getCommunity(), teasession._rv, obj.getCategory(), (options1 & 2) != 0, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null, teasession._nLanguage, subject, null,"", text, null, "", 0, null, "", "", "", "", null,null);
            } else
            {
                node.set(teasession._nLanguage, subject, text);
            }
            Date time = null;
            try
            {
                time = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(teasession.getParameter("timeYear") + "-" + teasession.getParameter("timeMonth") + "-" + teasession.getParameter("timeDay"));
            } catch (ParseException ex1)
            {
                time = new Date();
            }
            Contribute obj = Contribute.find(teasession._nNode, teasession._nLanguage);
            String photo = null;
            byte by[] = teasession.getBytesParameter("photo");
            if (by != null)
            {
                photo = request.getContextPath() + super.write(node.getCommunity(), by, ".gif");
            } else
            {
                photo = teasession.getParameter("photopath");
            }
            int  belong=0;
            if(teasession.getParameter("belong")!=null&&teasession.getParameter("belong").length()!=0){
            	belong=Integer.parseInt(teasession.getParameter("belong"));
            }

            obj.set(teasession.getParameter("project"), Boolean.valueOf(teasession.getParameter("classes")).booleanValue(),belong , new java.math.BigDecimal(teasession.getParameter("moneycount")), time, photo, teasession.getParameter("linkman"), teasession.getParameter("linkman2"), teasession.getParameter("phone"), teasession.getParameter("phone2"), teasession.getParameter("address"), teasession.getParameter("address2"), teasession
                    .getParameter("postalcode"), teasession.getParameter("postalcode2"), teasession.getParameter("email"), teasession.getParameter("email2"));
            node.finished(teasession._nNode);
            delete(node);
            if(teasession.getParameter("nexturl")!=null&&teasession.getParameter("nexturl").length()>0){
            	response.sendRedirect(teasession.getParameter("nexturl"));
            }else{
            response.sendRedirect("Contribute?node=" + teasession._nNode);
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
