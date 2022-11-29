package tea.ui.node.type.event;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.Http;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.node.Category;
import tea.entity.node.Event;
import tea.entity.node.Node;
import tea.entity.westrac.EventaccoMember;
import tea.entity.westrac.Eventregistration;
import tea.entity.westrac.WestracIntegralLog;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditEvent extends TeaServlet
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
            if("WestracEventRegistra1".equals(act))
            {

            	int regid = 0;//管理员查看的参会表
            	if(teasession.getParameter("regid")!=null && teasession.getParameter("regid").length()>0)
            	{
            		regid = Integer.parseInt(teasession.getParameter("regid"));
            	}


            	Eventregistration regobj = Eventregistration.find(regid);
            	
            	String mobile= teasession.getParameter("mobile");

            	if(regid==0 &&Eventregistration.Count(teasession._strCommunity, " and node="+teasession._nNode+" and mobile="+DbAdapter.cite(mobile))>0)//不是修改的时候
            	{


             		 out.print("<script>alert('同一手机号不能重复报名');parent.window.history.go(-1);</script>");
             		 return;

            	}

            	String address = teasession.getParameter("address");

            	String email = teasession.getParameter("email");
            	int acco = 0;
            	if(teasession.getParameter("acco")!=null && teasession.getParameter("acco").length()>0)
            	{
            		acco = Integer.parseInt(teasession.getParameter("acco"));
            	}
            	int accoquantity = 0;
            	if(teasession.getParameter("accoquantity")!=null && teasession.getParameter("accoquantity").length()>0)
            	{
            		accoquantity = Integer.parseInt(teasession.getParameter("accoquantity"));
            	}
            	int stay = 0;
            	if(teasession.getParameter("stay")!=null && teasession.getParameter("stay").length()>0)
            	{
            		stay = Integer.parseInt(teasession.getParameter("stay"));
            	}

            	String acconame = teasession.getParameter("acconame");

            	int accorel = 0;
            	if(teasession.getParameter("accorel")!=null && teasession.getParameter("accorel").length()>0)
            	{
            		accorel = Integer.parseInt(teasession.getParameter("accorel"));
            	}
            	int accogender = 0;
            	if(teasession.getParameter("accogender")!=null && teasession.getParameter("accogender").length()>0)
            	{
            		accogender = Integer.parseInt(teasession.getParameter("accogender"));
            	}
            	int accoroom= 0;
            	if(teasession.getParameter("accoroom")!=null && teasession.getParameter("accoroom").length()>0)
            	{
            		accoroom = Integer.parseInt(teasession.getParameter("accoroom"));
            	}

            	String accocode = teasession.getParameter("accocode");

            	String accoother = teasession.getParameter("accoother");

            	int shuttle= 0;
            	if(teasession.getParameter("shuttle")!=null && teasession.getParameter("shuttle").length()>0)
            	{
            		shuttle = Integer.parseInt(teasession.getParameter("shuttle"));
            	}

            	int transport= 0;
            	if(teasession.getParameter("transport")!=null && teasession.getParameter("transport").length()>0)
            	{
            		transport = Integer.parseInt(teasession.getParameter("transport"));
            	}

            	String gotrainnumber = teasession.getParameter("gotrainnumber");
            	Date reachtime =null;
            	if( teasession.getParameter("reachtime")!=null &&  teasession.getParameter("reachtime").length()>0)
            	{
            		reachtime = Entity.sdf.parse(teasession.getParameter("reachtime"));
            	}
            	String reachtimedate = teasession.getParameter("reachtimedate");

            	String returnrainnumber = teasession.getParameter("returnrainnumber");
            	Date returntime =null;
            	if( teasession.getParameter("returntime")!=null &&  teasession.getParameter("returntime").length()>0)
            	{
            		returntime = Entity.sdf.parse(teasession.getParameter("returntime"));
            	}
            	String returntimedate = teasession.getParameter("returntimedate");

            	/*
            	int erid = 0;
            	if(teasession.getParameter("erid")!=null && teasession.getParameter("erid").length()>0)
            	{
	            	erid = Integer.parseInt(teasession.getParameter("erid"));
            	}
            	*/
            	// 是否安排餐饮

            	int catering = Integer.parseInt(teasession.getParameter("catering"));
            	String specials = teasession.getParameter("specials");//餐饮要求
            	int roomnumber =h.getInt("roomnumber");

            	String city = h.get("city1");

            	String show = teasession.getParameter("show");
            	Eventregistration erobj = Eventregistration.find(regid);
            	if(erobj.isExists())
            	{
            		erobj.set(teasession._nNode, "", mobile, address, email, acco, accoquantity, stay, acconame, accorel, accogender, accoroom,
            				accocode, accoother, shuttle, transport, gotrainnumber, reachtime, reachtimedate, returnrainnumber, returntime, returntimedate,
            				catering,specials,roomnumber,city);
            		erobj.setVerifg(erobj.getVerifg());

            		EventaccoMember.delete(regid);

            		for(int i=1;i<=accoquantity;i++)
            		{
            			EventaccoMember.create(h.get("acconame"+i), h.getInt("sex"+i), h.getInt("accorel"+i), h.get("cadr"+i), regid,teasession._nNode);
            		}

            	}else
            	{
            		regid=Eventregistration.create(teasession._nNode, "", mobile, address, email, acco, accoquantity, stay, acconame, accorel,
            				accogender, accoroom, accocode, accoother, shuttle, transport, gotrainnumber, reachtime, reachtimedate, returnrainnumber, returntime,
            				returntimedate, teasession._strCommunity, new Date(),catering,specials,roomnumber,city);



            		for(int i=1;i<=accoquantity;i++)
            		{
            			EventaccoMember.create(h.get("acconame"+i), h.getInt("sex"+i), h.getInt("accorel"+i), h.get("cadr"+i), regid,teasession._nNode);
            		}


            		if(show!=null && show.length()>0)
            		{ //前台过来的报名表
            			Eventregistration.find(regid).setVerifg(0);
            		}else
            		{
            			Eventregistration.find(regid).setVerifg(1);
            		}
            	}


            	if(erobj.isExists())
            	{

             		 out.print("<script>alert('活动报名用户信息修改完成');parent.window.close();</script>");

            	}else
            	{
            		//不是修改，直接添加报名表的，用户添加或管理员添加
            		//发送短信
            		//发送短信
 					String c = "感谢您报名参加我们的“"+Node.find(teasession._nNode).getSubject(teasession._nLanguage)+"”活动，我们会随后与您电话确认相关信息！";
 					SMSMessage.create(teasession._strCommunity,"webmaster",mobile,teasession._nLanguage,c);


            		out.print("<script>alert('用户报名表添加完成');parent.ymPrompt.close();</script>");
            		
            		 return;

            	}


            	if(nexturl!=null && nexturl.length()>0 && !"null".equals(nexturl))
            	{


            		 out.print("<script>window.open('" + nexturl+"','_parent');</script>");



	                 return;
            	}else
            	{

            		 out.print("<script>window.open('/html/"+teasession._strCommunity+"/event/"+teasession._nNode+"-"+teasession._nLanguage+".htm','_parent');</script>");

            	}



            }else if("WestracEventMemberListDeleteALL".equals(act))
            {
            	//报名会员批量删除
            	 String value[] = request.getParameterValues("checkeid");

		            if(value != null)
		            {

		            	//boolean f = false;
		                for(int index = 0;index < value.length;index++)
		                {

		                    int  eid =Integer.parseInt(value[index]);
		                    Eventregistration eobj = Eventregistration.find(eid);
		            	    Profile pobj = Profile.find(eobj.getMember());

		            	    eobj.delete(eid);
		                }

						out.print("<script  language='javascript'>alert('活动报名会员删除成功');window.open('"+nexturl+"','tar');</script> ");

		            }
            }
            if(teasession._rv==null )
            {
            	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
            	return;
            }

            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/event/EditEvent.jsp?node=" + teasession._nNode);
            }else if("WestracEventRegistra".equals(act))
            {

            	int regid = 0;//管理员查看的参会表
            	if(teasession.getParameter("regid")!=null && teasession.getParameter("regid").length()>0)
            	{
            		regid = Integer.parseInt(teasession.getParameter("regid"));
            	}

            	String member = teasession._rv.toString();

            	Eventregistration regobj = Eventregistration.find(regid);

            	if(regobj.isExists())
            	{
            		member= regobj.getMember();
            	}
            	//管理员创建报名
            	if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0)
            	{
            		member = teasession.getParameter("member");
            	}

            	Profile pobj = Profile.find(member);

            	if(regid==0 &&Eventregistration.isBool(teasession._nNode, member))//不是修改的时候
            	{


             		 out.print("<script>alert('用户不能重复报名');parent.window.history.go(-1);</script>");
             		 return;

            	}




            	String mobile= teasession.getParameter("mobile");

            	String address = teasession.getParameter("address");

            	String email = teasession.getParameter("email");
            	int acco = 0;
            	if(teasession.getParameter("acco")!=null && teasession.getParameter("acco").length()>0)
            	{
            		acco = Integer.parseInt(teasession.getParameter("acco"));
            	}
            	int accoquantity = 0;
            	if(teasession.getParameter("accoquantity")!=null && teasession.getParameter("accoquantity").length()>0)
            	{
            		accoquantity = Integer.parseInt(teasession.getParameter("accoquantity"));
            	}
            	int stay = 0;
            	if(teasession.getParameter("stay")!=null && teasession.getParameter("stay").length()>0)
            	{
            		stay = Integer.parseInt(teasession.getParameter("stay"));
            	}

            	String acconame = teasession.getParameter("acconame");

            	int accorel = 0;
            	if(teasession.getParameter("accorel")!=null && teasession.getParameter("accorel").length()>0)
            	{
            		accorel = Integer.parseInt(teasession.getParameter("accorel"));
            	}
            	int accogender = 0;
            	if(teasession.getParameter("accogender")!=null && teasession.getParameter("accogender").length()>0)
            	{
            		accogender = Integer.parseInt(teasession.getParameter("accogender"));
            	}
            	int accoroom= 0;
            	if(teasession.getParameter("accoroom")!=null && teasession.getParameter("accoroom").length()>0)
            	{
            		accoroom = Integer.parseInt(teasession.getParameter("accoroom"));
            	}

            	String accocode = teasession.getParameter("accocode");

            	String accoother = teasession.getParameter("accoother");

            	int shuttle= 0;
            	if(teasession.getParameter("shuttle")!=null && teasession.getParameter("shuttle").length()>0)
            	{
            		shuttle = Integer.parseInt(teasession.getParameter("shuttle"));
            	}

            	int transport= 0;
            	if(teasession.getParameter("transport")!=null && teasession.getParameter("transport").length()>0)
            	{
            		transport = Integer.parseInt(teasession.getParameter("transport"));
            	}

            	String gotrainnumber = teasession.getParameter("gotrainnumber");
            	Date reachtime =null;
            	if( teasession.getParameter("reachtime")!=null &&  teasession.getParameter("reachtime").length()>0)
            	{
            		reachtime = Entity.sdf.parse(teasession.getParameter("reachtime"));
            	}
            	String reachtimedate = teasession.getParameter("reachtimedate");

            	String returnrainnumber = teasession.getParameter("returnrainnumber");
            	Date returntime =null;
            	if( teasession.getParameter("returntime")!=null &&  teasession.getParameter("returntime").length()>0)
            	{
            		returntime = Entity.sdf.parse(teasession.getParameter("returntime"));
            	}
            	String returntimedate = teasession.getParameter("returntimedate");

            	/*
            	int erid = 0;
            	if(teasession.getParameter("erid")!=null && teasession.getParameter("erid").length()>0)
            	{
	            	erid = Integer.parseInt(teasession.getParameter("erid"));
            	}
            	*/
            	// 是否安排餐饮

            	int catering = Integer.parseInt(teasession.getParameter("catering"));
            	String specials = teasession.getParameter("specials");//餐饮要求
            	int roomnumber =h.getInt("roomnumber");

            	String city = h.get("city1");

            	String show = teasession.getParameter("show");
            	Eventregistration erobj = Eventregistration.find(regid);
            	if(erobj.isExists())
            	{
            		erobj.set(teasession._nNode, member, mobile, address, email, acco, accoquantity, stay, acconame, accorel, accogender, accoroom,
            				accocode, accoother, shuttle, transport, gotrainnumber, reachtime, reachtimedate, returnrainnumber, returntime, returntimedate,
            				catering,specials,roomnumber,city);
            		erobj.setVerifg(erobj.getVerifg());

            		EventaccoMember.delete(regid);

            		for(int i=1;i<=accoquantity;i++)
            		{
            			EventaccoMember.create(h.get("acconame"+i), h.getInt("sex"+i), h.getInt("accorel"+i), h.get("cadr"+i), regid,teasession._nNode);
            		}

            	}else
            	{
            		regid=Eventregistration.create(teasession._nNode, member, mobile, address, email, acco, accoquantity, stay, acconame, accorel,
            				accogender, accoroom, accocode, accoother, shuttle, transport, gotrainnumber, reachtime, reachtimedate, returnrainnumber, returntime,
            				returntimedate, teasession._strCommunity, new Date(),catering,specials,roomnumber,city);



            		for(int i=1;i<=accoquantity;i++)
            		{
            			EventaccoMember.create(h.get("acconame"+i), h.getInt("sex"+i), h.getInt("accorel"+i), h.get("cadr"+i), regid,teasession._nNode);
            		}


            		if(show!=null && show.length()>0)
            		{ //前台过来的报名表
            			Eventregistration.find(regid).setVerifg(0);
            		}else
            		{
            			Eventregistration.find(regid).setVerifg(1);
            		}
            	}

            	pobj.setMobile(mobile);
            	pobj.setEmail(email);






            	if(erobj.isExists())
            	{

             		 out.print("<script>alert('活动报名用户信息修改完成');parent.window.close();</script>");

            	}else
            	{
            		//不是修改，直接添加报名表的，用户添加或管理员添加
            		//发送短信
            		//发送短信
 					String c = "感谢您报名参加我们的“"+Node.find(teasession._nNode).getSubject(teasession._nLanguage)+"”活动，我们会随后与您电话确认相关信息！";
 					SMSMessage.create(teasession._strCommunity,pobj.getMember(),pobj.getMobile(),teasession._nLanguage,c);


            		if(teasession._rv.toString().equals(member))
            		{
            			 out.print("<script>alert('用户报名表添加完成');parent.ymPrompt.close();</script>");
            		}else
            		{
            			out.print("<script>alert('用户报名表添加完成');parent.window.close();</script>");
            		}


            		 return;

            	}


            	if(nexturl!=null && nexturl.length()>0 && !"null".equals(nexturl))
            	{


            		 out.print("<script>window.open('" + nexturl+"','_parent');</script>");



	                 return;
            	}else
            	{

            		 out.print("<script>window.open('/html/"+teasession._strCommunity+"/event/"+teasession._nNode+"-"+teasession._nLanguage+".htm','_parent');</script>");

            	}



            }else if("WestracEventMemberListDeleteALL".equals(act))
            {
            	//报名会员批量删除
            	 String value[] = request.getParameterValues("checkeid");

		            if(value != null)
		            {

		            	//boolean f = false;
		                for(int index = 0;index < value.length;index++)
		                {

		                    int  eid =Integer.parseInt(value[index]);
		                    Eventregistration eobj = Eventregistration.find(eid);
		            	    Profile pobj = Profile.find(eobj.getMember());

		            	    eobj.delete(eid);
		                }

						out.print("<script  language='javascript'>alert('活动报名会员删除成功');window.open('"+nexturl+"','tar');</script> ");

		            }
            }else if("WestracEventMemberListVerifgALL".equals(act))
            {
            	//报名会员批量审核
            	 String value[] = request.getParameterValues("checkeid");



		            if(value != null)
		            {
		            	String str = "";
		                for(int index = 0;index < value.length;index++)
		                {

		                    int  eid =Integer.parseInt(value[index]);
		                    Eventregistration eobj = Eventregistration.find(eid);

		            	    Profile pobj = Profile.find(eobj.getMember());
		            		Event evobj = Event.find(eobj.getNode(),teasession._nLanguage);
		            		Node nobj = Node.find(eobj.getNode());


		            	    if(eobj.getVerifg()==0)
		            	    {
		            	    	eobj.setVerifg(1);
		            	    	eobj.setVerifgTime(new Date());
		            	    	 str = "活动报名会员审核成功";
		            	    		pobj.setMyintegral(pobj.getMyintegral()+evobj.getIntegral());
		            	    		WestracIntegralLog.create(eobj.getMember(),7,nobj.getSubject(teasession._nLanguage),eobj.getNode(),evobj.getIntegral(),null,new Date(),0,teasession._strCommunity);



		            	    }else  if(eobj.getVerifg()==1)
		            	    {
		            	    	eobj.setVerifg(0);
		            	    	 str = "活动报名会员取消审核成功";

		            	    	 pobj.setMyintegral(pobj.getMyintegral()-evobj.getIntegral());
		            	 		WestracIntegralLog.create(eobj.getMember(),8,nobj.getSubject(teasession._nLanguage),eobj.getNode(),0,null,new Date(),-evobj.getIntegral(),teasession._strCommunity);





		            	    }
		                }

						out.print("<script  language='javascript'>alert('"+str+"');window.open('"+nexturl+"&verifg="+teasession.getParameter("verifg")+"','tar');</script> ");

						return;
		            }
            }else if("WestracEventEditAccompMember".equals(act))
            {
            	//编辑随行人员信息
            	int eid = Integer.parseInt(teasession.getParameter("eid"));

            	EventaccoMember eobj = EventaccoMember.find(eid);
            	String acconame = teasession.getParameter("acconame");
            	int accorel = Integer.parseInt(teasession.getParameter("accorel"));
            	int accogender = Integer.parseInt(teasession.getParameter("accogender"));

            	String  accocode = teasession.getParameter("accocode");
            	String accoother = teasession.getParameter("accoother");


            	eobj.set(acconame, accogender, accorel, accocode, eobj.getEregid());
            	//eobj.setAcco(eobj.getStay(),acconame, accorel,accogender, accoroom, accocode, accoother);


				out.print("<script  language='javascript'>alert('随行人员信息编辑');parent.window.close();</script> ");

				return;

            }else if("WestracEventAccompMemberDeleteALL".equals(act))
            {
            	//批量删除随行人员
            	 String value[] = request.getParameterValues("checkeid");

		            if(value != null)
		            {
		            	String str = "";
		                for(int index = 0;index < value.length;index++)
		                {

		                    int  eid =Integer.parseInt(value[index]);
		                    EventaccoMember eobj = EventaccoMember.find(eid);
		                    eobj.delete();

		                }
		            }

					out.print("<script  language='javascript'>alert('随行人员删除成功');window.open('"+nexturl+"','tar');</script> ");

					return;
            }
            else
            {
                Node node = Node.find(teasession._nNode);

                String subject = teasession.getParameter("subject");
                String text = teasession.getParameter("content");


                if(subject == null || subject.length() == 0)
                {
                    out.print("<script>parent.mt.show('您添加的活动，需要填写活动名称。');</script>");


                    return;
                }

                if(text == null || text.length() == 0)
                {
                    out.print("<script>parent.mt.show('您添加的活动，需要填写内容简介。');</script>");


                    return;
                }



                boolean newnode = teasession.getParameter("NewNode") != null;
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




                } else
                {
                    node.set(teasession._nLanguage, subject, text);
                }




                Event event = new Event(teasession._nNode, teasession._nLanguage);
                try
                {
                   // event.setTimeStart(TimeSelection.makeTime(teasession.getParameter("timeStartYear"), teasession.getParameter("timeStartMonth"), teasession.getParameter("timeStartDay"), teasession.getParameter("timeStartHour"), teasession.getParameter("timeStartMinute"))); // teasession.getParameter("timeStart"));
                  //  event.setTimeStop(TimeSelection.makeTime(teasession.getParameter("timeStopYear"), teasession.getParameter("timeStopMonth"), teasession.getParameter("timeStopDay"), teasession.getParameter("timeStopHour"), teasession.getParameter("timeStopMinute"))); // teasession.getParameter("timeStop"));

                	if(teasession.getParameter("timeStart")!=null)
                	{
                		event.setTimeStart(Entity.sdf.parse(teasession.getParameter("timeStart")));
                	}
                	if(teasession.getParameter("timeStop")!=null)
                	{
                		event.setTimeStop(Entity.sdf.parse(teasession.getParameter("timeStop")));
                	}

                	if(teasession.getParameter("timeHoldStart")!=null)
                	{
                		event.setTimeHoldStart(Entity.sdf.parse(teasession.getParameter("timeHoldStart")));
                	}
                	if(teasession.getParameter("timeHoldStop")!=null)
                	{
                		event.setTimeHoldStop(Entity.sdf.parse(teasession.getParameter("timeHoldStop")));
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
                event.setIntegral(integral);
                event.setNightShop(nightShop);
                event.setRequest(teasession.getParameter("request"));
                event.setPrescribe(teasession.getParameter("prescribe"));
                event.setSynopsis(teasession.getParameter("synopsis"));
                event.setOrganise(teasession.getParameter("organise"));
                event.setLinkman(teasession.getParameter("linkman"));
                event.setCorp(teasession.getParameter("corp"));
                event.setCarfare(teasession.getParameter("carfare"));
                event.setFeature(teasession.getParameter("feature"));

                //event.setDate(TimeSelection.makeTime(teasession.getParameter("IssueYear"), teasession.getParameter("IssueMonth"), teasession.getParameter("IssueDay"), teasession.getParameter("IssueHour"), teasession.getParameter("IssueMinute")));
                event.setDate(new Date());
                event.setSort(teasession.getParameter("sort"));
                int city = 0;
                if(teasession.getParameter("city")!=null && teasession.getParameter("city").length()>0)
                {
                	city = Integer.parseInt(teasession.getParameter("city"));
                }
                event.setCity(city);

                boolean cip = teasession.getParameter("ClearIntroPicture") != null;
                byte ip[] = teasession.getBytesParameter("introPicture");
                if (ip != null)
                {
                    event.setIntroPicture(write(node.getCommunity(), ip, ".gif"));
                } else if (cip)
                {
                    event.setIntroPicture("");
                }

                event.setFlyerData(teasession.getParameter("flyerData"));

                boolean cp1 = teasession.getParameter("ClearBigPicture") != null;
                byte lp1[] = teasession.getBytesParameter("bigPicture");
                if (lp1 != null)
                {
                    // event.setLocalePicture(write(realPath, lp1));
                    event.setBigPicture(write(node.getCommunity(), lp1, ".gif"));
                } else if (cp1)
                {
                    event.setBigPicture("");
                }

                boolean cp2 = teasession.getParameter("ClearPicture2") != null;
                if (cp2)
                {
                    event.setLocalePicture2("");
                } else
                {
                    byte lp2[] = teasession.getBytesParameter("localePicture2");
                    if (lp2 != null)
                    {
                        event.setLocalePicture2(write(node.getCommunity(), lp2, ".gif"));
                    }
                }

                boolean cp3 = teasession.getParameter("ClearPicture3") != null;
                if (cp3)
                {
                    event.setLocalePicture3("");
                } else
                {
                    byte lp3[] = teasession.getBytesParameter("localePicture3");
                    if (lp3 != null)
                    {
                        event.setLocalePicture3(write(node.getCommunity(), lp3, ".gif"));
                    }
                }


                 String subtitle=teasession.getParameter("subtitle");//活动副标题
                 event.setSubtitle(subtitle);
                 String lead=teasession.getParameter("lead");//导语
                 event.setLead(lead);
                 String province=teasession.getParameter("selProvince");//省
                 event.setProvince(province);
                 String city2=teasession.getParameter("selCity");//市

                 event.setCity2(city2);
                 String address=teasession.getParameter("address");//详细地址

                 event.setAddress(address);
                 String map = teasession.getParameter("map");
                 event.setMap(map);

                 int eventtype=0;//活动类别
                 if(teasession.getParameter("eventtype")!=null && teasession.getParameter("eventtype").length()>0)
                 {
                	 eventtype = Integer.parseInt(teasession.getParameter("eventtype"));
                 }
                 event.setEventtype(eventtype);

                 int catering=0;
                 if(teasession.getParameter("catering")!=null && teasession.getParameter("catering").length()>0){
                	 catering=Integer.parseInt(teasession.getParameter("catering"));//是否安排餐饮 0是，1 否
                 }
                 event.setCatering(catering);
                 int stay=0;
                 if(teasession.getParameter("stay")!=null && teasession.getParameter("stay").length()>0){
                	 stay= Integer.parseInt(teasession.getParameter("stay"));//是否安排住宿
                 }
                 event.setStay(stay);

                 int shuttle=0;
                 if(teasession.getParameter("shuttle")!=null && teasession.getParameter("shuttle").length()>0){
                	 shuttle=Integer.parseInt(teasession.getParameter("shuttle"));//是否安排接送
                 }
                 event.setShuttle(shuttle);



                if (event.exists())
                {
                    event.set();
                } else
                {
                    event.create();
                }
                Node.find(teasession._nNode).finished(teasession._nNode);

                super.delete(node);



                if(nexturl!=null && nexturl.length()>0)
                {
                	//response.sendRedirect(nexturl+"&adminrole="+teasession.getParameter("adminrole"));

                	 out.print("<script>window.open('" + nexturl+"&adminrole="+teasession.getParameter("adminrole")+ "','_parent');</script>");
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
            }
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
