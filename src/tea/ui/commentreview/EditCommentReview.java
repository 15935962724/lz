package tea.ui.commentreview;

import java.io.IOException;
import java.util.Date;
import java.util.Enumeration;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jxl.format.UnderlineStyle;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.member.Message;
import tea.entity.member.Profile;
import tea.entity.node.Report;
import tea.entity.commentreview.CommentReview;
import tea.entity.pm.PoFamousComment;
import tea.entity.site.Community;
//import tea.service.Robot;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditCommentReview extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        r.add("/tea/resource/Photography");
        try
        {
            TeaSession teasession = new TeaSession(request);
           // Node node = Node.find(teasession._nNode);
            //boolean flagl = (node.getOptions() & 0x8000) != 0; //ANONYMITY评论
            int type = 0;
            if(null!=teasession.getParameter("type")&&!"".equals(teasession.getParameter("type"))){
            	type = Integer.parseInt(teasession.getParameter("type"));
            }

            String nexturl = teasession.getParameter("nexturl");

            /*
                if(teasession._rv == null)
                {
             if(!flagl)
             {
              outLogin(request,response,teasession);
              return;
             }
             teasession._rv = RV.ANONYMITY;
                }
             */

            String act = teasession.getParameter("act");
            if("EditCommentReview".equals(act)) //后台审核使用
            {
                String tmp = teasession.getParameter("hint");
                int hint = tmp == null ? 0 : Integer.parseInt(tmp);
                String subject = teasession.getParameter("subject");
                String content = teasession.getParameter("content");
                int state = Integer.parseInt(teasession.getParameter("state"));

                int crid = Integer.parseInt(teasession.getParameter("crid"));
                CommentReview tobj = CommentReview.find(crid);
                if(crid > 0)
                {
                    tobj.set(hint,tobj.country,teasession._nLanguage,subject,content,null,null,null,null);
                    tobj.setState(state);
                    tobj.set(teasession._rv.toString(),new Date());
                }

                java.io.PrintWriter out = response.getWriter();
                out.print("<script  language='javascript'>alert('操作成功');window.location.href='" + nexturl + "';</script> ");
                out.close();
                return;

            } else if("audit".equals(act)||"delete".equals(act)||"cancel_audit".equals(act)||"refusal".equals(act))
            {//后台审核和删除
            	String value[] = request.getParameterValues("commentreview");
                String nu = request.getParameter("nexturl");
                if(nu == null)
                {
                    nu = "/jsp/commentreview/CommentReviewList.jsp?type=" + type;
                }
                if(value != null)
                {
                	String next_str ="操作成功";
                	//boolean f = false;
                    for(int index = 0;index < value.length;index++)
                    {
                        int i = Integer.parseInt(value[index]);
                        CommentReview cr = CommentReview.find(i);
                        
                        if("delete".equals(act))
                        {
                            cr.delete();
                           // next_str ="删除操作成功";

                        }else if("audit".equals(act))//审核 显示
                        {
                        	if(cr.getState()==0)
                        	{
                        		// next_str ="审核操作成功";
                        		 cr.setState(1);
                        		 cr.set(teasession._rv.toString(),new Date());
                        	}else
                        	{
                        		next_str ="抱歉!您审核的评论里面有【已审核或已拒绝】的评论.\\n系统只能审核【未审核】的评论!";
                        	}
                        }else if("cancel_audit".equals(act))//还原
                        {
                        	if(cr.getState()!=0)
                        	{
                        		// next_str ="还原操作成功";
                        		 cr.setState(0);
                        		 cr.set("",null);
                        	}else
                        	{
                        		next_str ="抱歉!您还原的评论里面有【未审核】的评论.\\n系统只能还原【已审核或已拒绝】的评论!";
                        	}
                        } else if("refusal".equals(act))//拒绝
                        {
                        	if(cr.getState()==2)
                        	{
                        		next_str ="抱歉!您拒绝的评论里面有【拒绝】的评论.\\n系统只能拒绝【未拒绝】的评论!";
                        	}else
                        	{
                        		// next_str ="拒绝操作成功";
                        		 cr.setState(2);
                        		 cr.set(teasession._rv.toString(),new Date());
                        	}
                        }

                    }
    				java.io.PrintWriter out = response.getWriter();
    				out.print("<script  language='javascript'>alert('" + next_str + "');window.location.href='" + nu + "';</script> ");
    				out.close();
    				return;
                }


                response.sendRedirect(nu);
            } else if("CommentReviewList".equals(act))//导出评论 
			{
            	String sql = teasession.getParameter("sql");
            	String files = teasession.getParameter("files");
            	
            	response.setContentType("application/x-msdownload");
        		response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(files + ".xls", "UTF-8"));
            	javax.servlet.ServletOutputStream os = response.getOutputStream();
            	jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
    			jxl.write.WritableSheet ws = wwb.createSheet(files, 0);
                WritableFont wf = new WritableFont(WritableFont.TIMES, 10,WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
                WritableCellFormat wcf = new WritableCellFormat(wf); // 单元格定义
                
                wcf.setAlignment(jxl.format.Alignment.LEFT); // 设置对齐方式
               
                // ws.getSettings().setPrintGridLines(true);//是否打印网格线

    			int i = 0,j=0;
			    ws.setColumnView(0, 20); // 设置列的宽度
			    ws.setColumnView(1, 20); // 设置列的宽度
			    ws.setColumnView(2, 20); // 设置列的宽度
			    ws.setColumnView(3, 20); // 设置列的宽度
			    ws.setColumnView(4, 20); // 设置列的宽度
			    ws.setColumnView(5, 20); // 设置列的宽度
			    ws.setColumnView(6, 20); // 设置列的宽度
			    ws.setColumnView(7, 20); // 设置列的宽度
			    ws.setColumnView(8, 20); // 设置列的宽度

			    
	            // ws.addCell(new jxl.write.Label(j++,0,"主题",wcf));
	            ws.addCell(new jxl.write.Label(j++,0,"作品名",wcf));
	            ws.addCell(new jxl.write.Label(j++,0,"请求人员",wcf));
	            ws.addCell(new jxl.write.Label(j++,0,"请求时间",wcf));
	            ws.addCell(new jxl.write.Label(j++,0,"处理人员",wcf));
	            ws.addCell(new jxl.write.Label(j++,0,"处理时间",wcf));
	            ws.addCell(new jxl.write.Label(j++,0,"状态",wcf));
	            ws.addCell(new jxl.write.Label(j++,0,"评论内容",wcf));
            
	            //选中导出
	    
	            if(teasession.getParameter("commentreview")!=null && teasession.getParameter("commentreview").length()>0)
	            {
	            	String tal []  = teasession.getParameterValues("commentreview");
	            	
	            	for(int i2 =0;i2<tal.length;i2++)
	            	{
	            		int tkid = Integer.parseInt(tal[i2]);
	            		
	            		CommentReview obj = CommentReview.find(tkid);
	            		int fkeyid = obj.getFkeyid();
	            		String title = "";
	            		PoFamousComment pfc = new PoFamousComment();
	            		if(type==0){
	            			pfc = PoFamousComment.find(fkeyid);
	            		  	title = pfc.getTitle();
	            		}
	            		String member = obj.getCreator()._strR;
	            		tea.entity.member.Profile pobj = tea.entity.member.Profile.find(member);
	        	    	String pname = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
	        	    	if(pname!=null&&!"".equals(pname))
	        	    	{
	        	    		member = pname;
	        	    	}
	        	    	
	            		if(member!=null && member.length()==32)
	            		{
	            			member="游客";
	            		}
	            		String t = "";
	            		if(obj.getAudittime()!=null)
	            		{
	            			t = obj.sdf2.format(obj.getAudittime());
	            		}
	            		  //ws.addCell(new jxl.write.Label(0,i + 1,obj.getSubject(teasession._nLanguage)));
	                      ws.addCell(new jxl.write.Label(0,i + 1,title));
	                      ws.addCell(new jxl.write.Label(1,i + 1,member));
	                      ws.addCell(new jxl.write.Label(2,i + 1,obj.sdf2.format(obj.getTime()))); 
	                      ws.addCell(new jxl.write.Label(3,i + 1,obj.getAuditmember()));
	                      ws.addCell(new jxl.write.Label(4,i + 1,t));
	                      ws.addCell(new jxl.write.Label(5,i + 1,obj.STATE_TYPE[obj.getState()]));
	                      ws.addCell(new jxl.write.Label(6,i + 1,obj.getContent(teasession._nLanguage)));
	                      i++;
	            	}
	            }else//sql 语句导出
	            {
	            	Enumeration e = CommentReview.find(sql.toString(), 0, Integer.MAX_VALUE);
	            	while ( e.hasMoreElements()) {
	            		
	            		int tkid = ((Integer) e.nextElement()).intValue();
	            		
	            		CommentReview obj = CommentReview.find(tkid);
	            		int fkeyid = obj.getFkeyid();
	            		String title = "";
	            		PoFamousComment pfc = new PoFamousComment();
	            		if(type==0){
	            			pfc = PoFamousComment.find(fkeyid);
	            		  	title = pfc.getTitle();
	            		}
	            		String t = "";
	            		if(obj.getAudittime()!=null)
	            		{
	            			t = obj.sdf2.format(obj.getAudittime());
	            		}
	            		String member = obj.getCreator()._strR;
	            		tea.entity.member.Profile pobj = tea.entity.member.Profile.find(member);
	        	    	String pname = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
	        	    	if(pname!=null&&!"".equals(pname))
	        	    	{
	        	    		member = pname;
	        	    	}
	        	    	
	            		if(member!=null && member.length()==32)
	            		{
	            			member="游客";
	            		}
	            		 // ws.addCell(new jxl.write.Label(0,i + 1,obj.getSubject(teasession._nLanguage)));
	                      ws.addCell(new jxl.write.Label(0,i + 1,title));
	                      ws.addCell(new jxl.write.Label(1,i + 1,member));
	                      ws.addCell(new jxl.write.Label(2,i + 1,obj.sdf2.format(obj.getTime())));
	                      ws.addCell(new jxl.write.Label(3,i + 1,obj.getAuditmember()));
	                      ws.addCell(new jxl.write.Label(4,i + 1,t));
	                      ws.addCell(new jxl.write.Label(5,i + 1,obj.STATE_TYPE[obj.getState()]));
	                      ws.addCell(new jxl.write.Label(6,i + 1,obj.getContent(teasession._nLanguage)));
	                      i++;
	            	}
	            }
	            wwb.write();
                wwb.close();
                os.close();
                return;
		}else //前台评论使用
            {
            	int fkeyid = Integer.parseInt(teasession.getParameter("fkeyid"));
                PoFamousComment pfc = new PoFamousComment();
                if(type==0)
                	pfc = PoFamousComment.find(fkeyid);
            	if("CommentReviewAdmin".equals(act))
                {
                    int hint = Integer.parseInt(teasession.getParameter("hint"));
                    String subject = teasession.getParameter("subject");
                    String content = teasession.getParameter("content");

                    CommentReview.create(fkeyid,teasession._rv._strR,teasession._rv._strV,hint,0,1,request.getRemoteAddr(),type,teasession._nLanguage,subject,content,null,null,null,null,null,null,null,null,null);
                    java.io.PrintWriter out = response.getWriter();
                    out.print("<script  language='javascript'>alert('评论操作成功');window.location.href='" + nexturl + "';</script> ");
                    out.close();
                    return;

                }else if("fa".equals(act))
                {
                	java.io.PrintWriter out = response.getWriter();
                	
                	String nu = teasession.getParameter("nexturl");
                    if(nu == null)
                    {
                        nu = "/jsp/commentreview/CommentReviews.jsp?fkeyid=" + fkeyid;
                    }
                	
                	HttpSession session = request.getSession(true);
                    String userR = session.getId();
                    String userV = session.getId();
                    String tourist = teasession.getParameter("tourist"); //是否选中游客评论
                    if(tourist != null && tourist.length() > 0) //选中了直接评论
                    {
                        userR = "游客";
                        userV = "游客";
                    }  else if(teasession._rv != null)
                    {
                        userR = teasession._rv._strR;
                        userV = teasession._rv._strV;

                    } else
                    { //需要登录 评论

                        if(teasession._rv == null)
                        {
                            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                            return;
                        } else
                        {
                            userR = teasession._rv._strR;
                            userV = teasession._rv._strV;
                        }
                    }
                    
                    //判断验证码
                    String str = (String)session.getAttribute("sms.vertify");                    
                    String verify = teasession.getParameter("verify");
                    if((str != null || verify != null) && (str == null || !MT.dec(str).equalsIgnoreCase(verify)))
                    {
                    	//response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"4746026465"),"UTF-8") + "&nexturl=" + teasession.getParameter("nexturl"));
                    	out.print("<script  language='javascript'>alert('" + r.getString(teasession._nLanguage,"4746026465") + "!');window.location.href='" + nu + "';</script> ");
                        return;
                    }

                    int commentreview = 0;

                    if(teasession.getParameter("commentreview") != null && teasession.getParameter("commentreview").length() > 0)
                    {
                        commentreview = Integer.parseInt(teasession.getParameter("commentreview"));
                    }
                    if(commentreview > 0)
                    {
                        CommentReview obj = CommentReview.find(commentreview);
                        if(!obj.isCreator(teasession._rv))
                        {
                            response.sendError(403);
                            return;
                        }
                    }

                    if(request.getMethod().equals("GET"))
                    {
                        response.sendRedirect("/jsp/commentreview/EditCommentReview.jsp?node=" + teasession._nNode);
                        return;
                    }
                    int hint = 0;

                    if(teasession.getParameter("hint") != null && teasession.getParameter("hint").length() > 0)
                    {
                        hint = Integer.parseInt(teasession.getParameter("hint"));
                    }
                    String subject = teasession.getParameter("subject");
                    if(subject == null || subject.length() < 1)
                    {
                        outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidSubject"));
                        return;
                    }
                    String tmp = teasession.getParameter("country");
                    int country = tmp == null || tmp.length() < 1 ? 0 : Integer.parseInt(tmp);
                    String ip = request.getRemoteAddr();
                    String content = teasession.getParameter("content");
                    content = Report.getHtml2(content);

                    if(CommentReview.isADD(ip,content))
                    {

                        out.print("<script  language='javascript'>alert('您不能重复评论');window.location.href='" + nu + "';</script> ");
                        out.close();
                        return;
                    }

                    ///

                    Community community = Community.find(teasession._strCommunity);
                    /*
                         if(community.filtrate!=null && community.filtrate.length()>0){
                     if(Pattern.compile(community.filtrate.replace(',','|')).matcher(content).find())
                     {
                      super.outText(teasession,response,r.getString(teasession._nLanguage,"InvalidTextIllegal"));
                      return;
                     }
                         }
                     */

                    //
                    String picture = teasession.getParameter("picture");
                    if(teasession.getParameter("clearpicture") != null)
                    {
                        picture = "";
                    }
                    String voice = teasession.getParameter("voice");;
                    if(teasession.getParameter("clearvoice") != null)
                    {
                        voice = "";
                    }
                    String file = null;
                    String filename = teasession.getParameter("fileName");
                    byte abyte2[] = teasession.getBytesParameter("file");
                    if(abyte2 != null)
                    {
                        file = write(teasession._strCommunity,abyte2,"." + filename.substring(filename.lastIndexOf(".") + 1));
                    } else if(teasession.getParameter("clearfile") != null)
                    {
                        file = "";
                    }
                    //
                    String name = teasession.getParameter("name"); //姓名
                    String address = teasession.getParameter("address"); //地址
                    String zip = teasession.getParameter("zip"); //邮编
                    String telephone = teasession.getParameter("telephone"); //联系电话
                    String email = teasession.getParameter("email");
                    int state = 0;
                    // System.out.println((Node.find(node.getFather()).getOptions() & 0x10000000L)+"--"+Node.find(node.getFather()).getOptions());
                    /*if((Node.find(node.getFather()).getOptions() & 0x10000000L) != 0)  ---zcq add
                    {
                        state = 0;
                    }*/

                    if(commentreview == 0)
                    {
                        CommentReview.create(fkeyid,userR,userV,hint,country,state,ip,type,teasession._nLanguage,subject,content,name,address,zip,telephone,email,picture,voice,filename,file);
                    } else
                    {
                        CommentReview obj = CommentReview.find(commentreview);
                        obj.set(hint,country,teasession._nLanguage,subject,content,picture,voice,file,filename);
                    }
                    ///
                    String s8 = teasession.getParameter("cc");
                    String s9 = teasession.getParameter("bcc");
                    // s6 = "<a href='http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/servlet/Node?node=" + teasession._nNode + "'>" + s4 + "</a><br>" + s6;

                    boolean flag2 = teasession.getParameter("msgOsendmessage") != null; // 发送信息
                    boolean flag3 = teasession.getParameter("msgOsendemail") != null; // 同时按E-MAIL发送
                    String creator = "";
                    if(type==0)
                		creator = Profile.find(pfc.getMember()).getName(teasession._nLanguage);
                    
                    if(flag2)
                    {
                        Message.create(teasession._strCommunity,teasession._rv._strV,creator,teasession._nLanguage,subject,content);
                    }
                    if(flag3)
                    {
                        content = "&#37038;&#20214;&#26469;&#28304;:" + community.getName(teasession._nLanguage) + "<BR><BR>" + content; // 邮件来源
                        int k = Message.create(teasession._strCommunity,teasession._rv._strV,creator,teasession._nLanguage,subject,content);
                        try
                        {
                            //Robot.activateRoboty(teasession._nNode,k);
                        } catch(Exception _ex)
                        {
                        }
                    }
                    //delete(node); --- zcq add
                    
                    out.print("<script  language='javascript'>alert('" + r.getString(teasession._nLanguage,"5958149074") + "!');window.location.href='" + nu + "';</script> ");
                    out.close();
                    return;
                }
                

            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("您添加的评论出错了,请重新上传&nbsp;<a href=# onClick=\"javascript:history.back()\">返回</a>.","UTF-8"));
            //response.sendError(400,exception.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/commentreview/EditCommentReview");
    }
}
