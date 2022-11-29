package tea.ui.node.type.meeting;

import java.io.File;
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
import tea.entity.Entity;
import tea.entity.Http;
import tea.entity.admin.AdminUnit;
import tea.entity.node.Category;
import tea.entity.node.Listing;
import tea.entity.node.ListingCache;
import tea.entity.node.ListingDetail;
import tea.entity.node.Meeting;
import tea.entity.node.MeetingApplicants;
import tea.entity.node.MeetingInvite;
import tea.entity.node.Node;
import tea.entity.node.PickFrom;
import tea.entity.node.PickNode;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditMeeting extends TeaServlet
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
            if("edit".equals(act))
            {
                Node node = Node.find(teasession._nNode);

                String subject = teasession.getParameter("subject");
                String text = teasession.getParameter("content");


                if(subject == null || subject.length() == 0)
                {
                	info = "您添加的会议，需要填写会议名称。";
                    out.print("<script>mt.show('"+info+"');</script>");
                    out.close();
                    return;
                }

                if(text == null || text.length() == 0)
                {
                	info = "您添加的会议，需要填写内容简介。";
                    out.print("<script>mt.show('"+info+"');</script>");
                    out.close();
                    return;
                }

                boolean newnode = teasession.getParameter("NewNode") != null;
                int fileNode = 0;
                if (newnode)
                {
                    int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                    int options1 = 0;
                    String community = node.getCommunity();
                    long options = node.getOptions();
                    options &= 0xffdffbff;
                    int defautllangauge = node.getDefaultLanguage();
                    Category cat = Category.find(teasession._nNode); //37
                    teasession._nNode = Node.create(teasession._nNode, sequence, community, teasession._rv, cat.getCategory(), false, options, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null, teasession._nLanguage, subject, "","", text, null, "", 0, null, "", "", "", "", null, null);

                    Node node2 = Node.find(teasession._nNode);
                    long fileOptions = node2.getOptions();
                    fileOptions &= 0xffdffbff;
                    int fileSequence = Node.getMaxSequence(teasession._nNode) + 10;
                    //在当前会议下创建文件类 type=1
                    fileNode = Node.create(teasession._nNode, fileSequence, community, teasession._rv, 1, false, fileOptions, options1, defautllangauge, null, null, new java.util.Date(), 0, 0, 0, 0, null, teasession._nLanguage, subject+"-文件类", "","", "", null, "", 0, null, "", "", "", "", null, null);
                    //当前类为文件类
                    Category cat2 = Category.find(fileNode); //41
                    cat2.set(41,0,0,null,0);
                    
                    //为文件类创建列举
                    Listing fileListing = Listing.find(0);
                    fileListing.node = fileNode;
                    fileListing.type = 0;
                    fileListing.pick = 1;
                    fileListing.ectypal = 0;
                    fileListing.style = 0;
                    fileListing.styletype = 255;
                    fileListing.stylecategory = 39;
                    fileListing.sequence = 10;                    
                    fileListing.position = 2;
                    fileListing.quantity = 6;
                    fileListing.sonquantity = 3;
                    fileListing.columns = 1;
                    fileListing.updategap = 30;
                    fileListing.options = 517;
                    fileListing.target = "_self";
                    fileListing.time = Entity.sdf.parse(Entity.sdf.format(new Date()));
                    fileListing.set();
                    
                    int listing = fileListing.listing;
                    
                    fileListing.setLayer(teasession._nLanguage,subject+"-文件类列举",null,null,null,null
                            ,null,null,null,null,null,null,null
                            ,null,null,null,null,null
                            ,null,"<ul>",0,null,null,null,0,"</ul>","",0);
                    ListingCache.expire(listing);
                    
                    //创建列举   下载类所对应的源风格（本社区、所有公共社区、本树和本节点）、源站点、当前类节点
                    PickFrom.create(listing,3,teasession._strCommunity,fileNode);
                    //创建列举   下载类所对应的风格
                    PickNode.create(listing,0,41,0,teasession._rv._strR,teasession._rv._strV,0,0,0,0,"");
                    //添加课件名称列举
                    ListingDetail ld=ListingDetail.find(listing,41,teasession._nLanguage);
                    ld.set("subject",1,"","",1,1,50,"/",new Date(),0);
                    //添加下载列举
                    ListingDetail ld2=ListingDetail.find(listing,41,teasession._nLanguage);
                    ld2.set("down",1,"","",1,1,0,"/",new Date(),0);
                    
                } else
                {
                    node.set(teasession._nLanguage, subject, text);
                }

                Meeting meeting = new Meeting(teasession._nNode, teasession._nLanguage);
                try
                {
                   // meeting.setTimeStart(TimeSelection.makeTime(teasession.getParameter("timeStartYear"), teasession.getParameter("timeStartMonth"), teasession.getParameter("timeStartDay"), teasession.getParameter("timeStartHour"), teasession.getParameter("timeStartMinute"))); // teasession.getParameter("timeStart"));
                  //  meeting.setTimeStop(TimeSelection.makeTime(teasession.getParameter("timeStopYear"), teasession.getParameter("timeStopMonth"), teasession.getParameter("timeStopDay"), teasession.getParameter("timeStopHour"), teasession.getParameter("timeStopMinute"))); // teasession.getParameter("timeStop"));

                	if(teasession.getParameter("timeStart")!=null)
                	{
                		meeting.setTimeStart(Entity.sdf.parse(teasession.getParameter("timeStart")));
                	}
                	if(teasession.getParameter("timeStop")!=null)
                	{
                		meeting.setTimeStop(Entity.sdf.parse(teasession.getParameter("timeStop")));
                	}

                	if(teasession.getParameter("timeHoldStart")!=null)
                	{
                		meeting.setTimeHoldStart(Entity.sdf.parse(teasession.getParameter("timeHoldStart")));
                	}
                	if(teasession.getParameter("timeHoldStop")!=null)
                	{
                		meeting.setTimeHoldStop(Entity.sdf.parse(teasession.getParameter("timeHoldStop")));
                	}



                } catch (Exception ex1)
                {
                }

                //活动状态

               int d = Entity.compare_date(teasession.getParameter("timeStart"),Entity.sdf.format(new Date()));
			   Node nobj=Node.find(teasession._nNode);
               if(d==1)
               {
				   nobj.set("audits",String.valueOf(nobj.audits=0));
               }else if(d==-1 || d==0)
               {
            	    d = Entity.compare_date(teasession.getParameter("timeStop"),Entity.sdf.format(new Date()));
            	   if(d==-1)
            	   {
					   nobj.set("audits",String.valueOf(nobj.audits=2));

            		   //报名结束，显示是否进行
            		   int dc = Entity.compare_date(teasession.getParameter("timeHoldStart"),Entity.sdf.format(new Date()));
            		  //已经开始举行活动
            		   if(dc==0|| dc==-1 )
            		   {
						   nobj.set("audits",String.valueOf(nobj.audits=3));
            		   }

            		   int dc2 = Entity.compare_date(teasession.getParameter("timeHoldStop"),Entity.sdf.format(new Date()));

            		   if(dc2==-1)
            		   {
            			   //结束
						   nobj.set("audits",String.valueOf(nobj.audits=4));
            		   }


            	   }else
            	   {
					   nobj.set("audits",String.valueOf(nobj.audits=1));
            	   }
               }

                int nightShop = 0;
                if(teasession.getParameter("nightShop")!=null && teasession.getParameter("nightShop").length()>0)
                {
                	nightShop = Integer.parseInt(teasession.getParameter("nightShop"));
                }
                float integral = 0;
                if(teasession.getParameter("integral")!=null && teasession.getParameter("integral").length()>0)
                {
                	integral = Float.parseFloat(teasession.getParameter("integral"));
                }
                meeting.setIntegral(integral);
                meeting.setNightShop(nightShop);
                meeting.setRequest(teasession.getParameter("request"));
                meeting.setPrescribe(teasession.getParameter("prescribe"));
                meeting.setIssue(teasession.getParameter("issue"));
                meeting.setSynopsis(teasession.getParameter("synopsis"));
                meeting.setOrganise(teasession.getParameter("organise"));
                meeting.setLinkman(teasession.getParameter("linkman"));
                meeting.setCorp(teasession.getParameter("corp"));
                meeting.setCarfare(teasession.getParameter("carfare"));
                meeting.setFeature(teasession.getParameter("feature"));

                //meeting.setDate(TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"), teasession.getParameter("IssueHour"), teasession.getParameter("IssueMinute")));
                meeting.setDate(new Date());
                meeting.setSort(teasession.getParameter("sort"));
                int city = 0;
                if(teasession.getParameter("city")!=null && teasession.getParameter("city").length()>0)
                {
                	city = Integer.parseInt(teasession.getParameter("city"));
                }
                meeting.setCity(city);

                boolean cip = teasession.getParameter("ClearIntroPicture") != null;
                byte ip[] = teasession.getBytesParameter("introPicture");
                if (ip != null)
                {
                    meeting.setIntroPicture(write(node.getCommunity(), ip, ".gif"));
                } else if (cip)
                {
                    meeting.setIntroPicture("");
                }

                meeting.setFlyerData(teasession.getParameter("flyerData"));

                boolean cp1 = teasession.getParameter("ClearBigPicture") != null;
                byte lp1[] = teasession.getBytesParameter("bigPicture");
                if (lp1 != null)
                {
                    // meeting.setLocalePicture(write(realPath, lp1));
                    meeting.setBigPicture(write(node.getCommunity(), lp1, ".gif"));
                } else if (cp1)
                {
                    meeting.setBigPicture("");
                }

                boolean cp2 = teasession.getParameter("ClearPicture2") != null;
                if (cp2)
                {
                    meeting.setLocalePicture2("");
                } else
                {
                    byte lp2[] = teasession.getBytesParameter("localePicture2");
                    if (lp2 != null)
                    {
                        meeting.setLocalePicture2(write(node.getCommunity(), lp2, ".gif"));
                    }
                }

                boolean cp3 = teasession.getParameter("ClearPicture3") != null;
                if (cp3)
                {
                    meeting.setLocalePicture3("");
                } else
                {
                    byte lp3[] = teasession.getBytesParameter("localePicture3");
                    if (lp3 != null)
                    {
                        meeting.setLocalePicture3(write(node.getCommunity(), lp3, ".gif"));
                    }
                }


                 String subtitle=teasession.getParameter("subtitle");//活动副标题
                 meeting.setSubtitle(subtitle);
                 String lead=teasession.getParameter("lead");//导语
                 meeting.setLead(lead);
                 String province=teasession.getParameter("selProvince");//省
                 meeting.setProvince(province);
                 String city2=teasession.getParameter("selCity");//市

                 meeting.setCity2(city2);
                 String address=teasession.getParameter("address");//详细地址

                 meeting.setAddress(address);
                 String map = teasession.getParameter("map");
                 meeting.setMap(map);

                 int eventtype=0;//活动类别
                 if(teasession.getParameter("eventtype")!=null && teasession.getParameter("eventtype").length()>0)
                 {
                	 eventtype = Integer.parseInt(teasession.getParameter("eventtype"));
                 }
                 meeting.setEventtype(eventtype);

                 int catering=0;
                 if(teasession.getParameter("catering")!=null && teasession.getParameter("catering").length()>0){
                	 catering=Integer.parseInt(teasession.getParameter("catering"));//是否安排餐饮 0是，1 否
                 }
                 meeting.setCatering(catering);
                 int stay=0;
                 if(teasession.getParameter("stay")!=null && teasession.getParameter("stay").length()>0){
                	 stay= Integer.parseInt(teasession.getParameter("stay"));//是否安排住宿
                 }
                 meeting.setStay(stay);

                 int shuttle=0;
                 if(teasession.getParameter("shuttle")!=null && teasession.getParameter("shuttle").length()>0){
                	 shuttle=Integer.parseInt(teasession.getParameter("shuttle"));//是否安排接送
                 }
                 meeting.setShuttle(shuttle);



                if (meeting.exists())
                {
                    meeting.set();
                } else
                {
                    meeting.create();
                    meeting.setFiles(fileNode);//插入文件类
                }
                
                //创建或修改文件详细（在根节点下）
                int rootNode = Node.getRoot(teasession._strCommunity);
                int fileDetailListCount = Listing.count(" AND node="+rootNode+" and styletype=41");
                if(fileDetailListCount<1){
                	//为文件类创建列举
                    Listing fileDetailListing = Listing.find(0);
                    fileDetailListing.node = rootNode;
                    fileDetailListing.type = 0;
                    fileDetailListing.pick = 1;
                    fileDetailListing.ectypal = 0;
                    fileDetailListing.style = 2;
                    fileDetailListing.styletype = 41;
                    fileDetailListing.stylecategory = 39;
                    fileDetailListing.sequence = 10;                  
                    fileDetailListing.position = 2;
                    fileDetailListing.quantity = 1;
                    fileDetailListing.sonquantity = 3;
                    fileDetailListing.columns = 1;
                    fileDetailListing.updategap = 30;
                    fileDetailListing.options = 21;
                    fileDetailListing.sorttype = 12;
                    fileDetailListing.target = "_self";
                    fileDetailListing.time = Entity.sdf.parse(Entity.sdf.format(new Date()));
                    fileDetailListing.set();
                    
                    int detailListing = fileDetailListing.listing;
                    
                    fileDetailListing.setLayer(teasession._nLanguage,"文件类列举详细",null,null,null,null
                            ,null,null,null,null,null,null,null
                            ,null,null,null,null,null
                            ,null,"<ul>",0,null,null,null,0,"</ul>","",0);
                    ListingCache.expire(detailListing);
                    
                    //创建列举   下载类所对应的源风格（本社区、所有公共社区、本树和本节点）、源站点、当前类节点
                    PickFrom.create(detailListing,3,teasession._strCommunity,fileNode);
                    //创建列举   下载类所对应的风格
                    PickNode.create(detailListing,0,41,0,teasession._rv._strR,teasession._rv._strV,0,0,0,0,"");
                    //添加课件名称列举
                    ListingDetail ld=ListingDetail.find(detailListing,41,teasession._nLanguage);
                    ld.set("subject",1,"","",1,0,0,"/",new Date(),0);
                    //添加课件编号列举
                    ListingDetail ld2=ListingDetail.find(detailListing,41,teasession._nLanguage);
                    ld2.set("code",1,"","",1,0,0,"/",new Date(),0);
                    //添加图片列举
                    ListingDetail ld3=ListingDetail.find(detailListing,41,teasession._nLanguage);
                    ld3.set("picture",1,"","",1,0,0,"/",new Date(),0);
                    //添加下载列举
                    ListingDetail ld4=ListingDetail.find(detailListing,41,teasession._nLanguage);
                    ld4.set("down",1,"","",1,1,0,"/",new Date(),0);
                }
                
                Node.find(teasession._nNode).finished(teasession._nNode);

                super.delete(node);



                if(nexturl!=null && nexturl.length()>0)
                {
                	//response.sendRedirect(nexturl+"&adminrole="+teasession.getParameter("adminrole"));
                	out.print("<script>mt.show('" + info + "',1,\"" + nexturl+"&adminrole="+teasession.getParameter("adminrole") + "\");</script>");
                	//out.print("<script>window.open('" + nexturl+"&adminrole="+teasession.getParameter("adminrole")+ "','_parent');</script>");
                	out.close();
                	return;
                }else
                {
	                if (teasession.getParameter("GoBack") != null)
	                {
	                    response.sendRedirect("EditNode?node=" + teasession._nNode);
	                    return;
	                } else
	                {
	                    response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
	                    return;
	                }
                }
            }else if("invite".equals(act)){
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
            }else if("WestracMeetingMemberListVerifgALL".equals(act))
            {
            	//报名部门批量审核
            	 String value[] = request.getParameterValues("checkmid");

		            if(value != null)
		            {
		            	String str = "";
		                for(int index = 0;index < value.length;index++)
		                {

		                    int  id =Integer.parseInt(value[index]);
		                    MeetingInvite ymi = MeetingInvite.find(id);


		            	    if(ymi.getState()==1)
		            	    {
		            	    	ymi.setState(2);
		            	    	ymi.set();
		            	    	str = "会议报名部门审核成功";
		            	    }else  if(ymi.getState()==2)
		            	    {
		            	    	ymi.setState(1);
		            	    	ymi.set();
		            	    	str = "会议报名部门取消审核成功";
		            	    }
		                }

						out.print("<script  language='javascript'>alert('"+str+"');window.open('"+nexturl+"&state="+teasession.getParameter("state")+"','tar');</script> ");

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

						out.print("<script  language='javascript'>alert('会议报名部门删除成功');window.open('"+nexturl+"','tar');</script> ");
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

    private void del(String name)
    {
        File file = new File(name);
        if (file.exists())
        {
            file.delete();
        }
    }
}
