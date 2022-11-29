package tea.ui.admin.mov;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.admin.AdminUsrRole;
import tea.entity.admin.mov.Describes;
import tea.entity.admin.mov.MemberOrder;
import tea.entity.admin.mov.MemberPay;
import tea.entity.admin.mov.MemberRecord;
import tea.entity.admin.mov.MemberType;
import tea.entity.admin.mov.RegisterInstall;
import tea.entity.integral.IntegralRecord;
import tea.entity.member.Profile;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditMemberType extends TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
		  response.setContentType("text/html;charset=UTF-8");
        TeaSession teasession = new TeaSession(request);
        Resource r=new Resource("/tea/resource/Photography");
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        String act = teasession.getParameter("act");
        String nexturl = teasession.getParameter("nexturl");
        String community = teasession.getParameter("community");
        try 
        {
            int membertype = 0;
            if(teasession.getParameter("membertype") != null && teasession.getParameter("membertype").length() > 0)
            {
                membertype = Integer.parseInt(teasession.getParameter("membertype"));
            }

            MemberType myobj = MemberType.find(membertype);

            if("EidtMemberType".equals(act))
            {
                String membername = teasession.getParameter("membername");
                String role = teasession.getParameter("role");
                int above = 0;
                if(teasession.getParameter("above") != null && teasession.getParameter("above").length() > 0)
                {
                    above = Integer.parseInt(teasession.getParameter("above"));
                }
                int roletype = 0;
                if(teasession.getParameter("roletype") != null && teasession.getParameter("roletype").length() > 0)
                {
                    roletype = Integer.parseInt(teasession.getParameter("roletype"));
                }
                StringBuffer strabove = new StringBuffer();;

                String lowers[] = teasession.getParameterValues("lowers");
                StringBuffer strlowers = new StringBuffer();;
                if(lowers != null && lowers.length > 0)
                {
                    strlowers.append("/");
                    for(int i = 0;i < lowers.length;i++)
                    {
                        strlowers.append(lowers[i]).append("/");
                    }
                }

                String fileurl = teasession.getParameter("fileurl");
                String caption = teasession.getParameter("caption");
                //是否邮件认证
                int appemail = 0;
                if(teasession.getParameter("appemail") != null && teasession.getParameter("appemail").length() > 0)
                {
                    appemail = Integer.parseInt(teasession.getParameter("appemail"));
                }
                int skips = 0;
                if(teasession.getParameter("skips") != null && teasession.getParameter("skips").length() > 0)
                {
                    skips = Integer.parseInt(teasession.getParameter("skips"));
                }

                if(membertype > 0)
                {
                    myobj.set(membername,role,above,strlowers.toString(),fileurl,caption,skips,teasession._rv.toString(),community,roletype,appemail);
                    myobj.setType(1);

                } else
                {
                    MemberType.create(membername,role,above,strlowers.toString(),fileurl,caption,skips,teasession._rv.toString(),community,roletype,appemail);
                }
            }else if("EditMember".equals(act))
            {
            	String memberorder = teasession.getParameter("memberorder");

            	MemberOrder moobj = MemberOrder.find(memberorder);
            	
            	String firstname = teasession.getParameter("firstname");//昵称
            	String telephone = teasession.getParameter("telephone");//联系电话
            	int sex = Integer.parseInt(teasession.getParameter("sex"));//性别
            	boolean b = true;
            	if(sex==1)
            	{
            		b= false;
            	}
            	 
            	String Country = teasession.getParameter("Country");//国籍
            	String address = teasession.getParameter("address");//现居住城市--以前的地址
            	int member_audit = 0;
            	if(teasession.getParameter("member_audit")!=null && teasession.getParameter("member_audit").length()>0)
            	{
            		member_audit = Integer.parseInt(teasession.getParameter("member_audit"));
            	}
            	//目前身份
            	String identitys=teasession.getParameter("identitys");
            	  
            	 
            	if(memberorder!=null && memberorder.length()>0)
            	{
            		if(member_audit>0){ 
            			moobj.setVerifg(member_audit);//审核
            		}
            		String mname = "";
            		if(moobj.getMember()!=null && moobj.getMember().length()>0)
            		{
            			mname = moobj.getMember();
            		}else
            		{
            			mname = teasession._rv._strR;
            		}
            		Profile pobj = Profile.find(mname);
            		pobj.setFirstName(firstname, teasession._nLanguage);
            		pobj.setTelephone(telephone, teasession._nLanguage);
            		pobj.setSex(b);
            		pobj.setCountry(Country, teasession._nLanguage);
            		pobj.setAddress(address,teasession._nLanguage);
            		
            		
            	}
            	
            	if(member_audit==0)//说明是编辑提示修改
            	{
            		java.io.PrintWriter out = response.getWriter();
					out.print("<script  language='javascript'>alert('" + r.getString(teasession._nLanguage, "4998537487") + "');window.location.href='" + nexturl + "';</script> ");
					out.close();
					return;
            	}
            	
            	
            }
            else if("MemberList".equals(teasession.getParameter("memberlist_act")))
            {
            	

				  String value[] = request.getParameterValues("memberorder");
		            
		            if(value != null)
		            {
		            	String next_str ="操作成功";
		            	//boolean f = false;
		                for(int index = 0;index < value.length;index++)
		                {

		                    String memberorder =value[index];
		            	    MemberOrder  moobj = MemberOrder.find(memberorder);
		            	    Profile pobj = Profile.find(moobj.getMember());
		            	    
		            	    
		                    if("member_delete".equals(act))
		                    {

		                    	  Profile.find(moobj.getMember()).delete(teasession._strCommunity,teasession._nLanguage);
		                    	  moobj.delete();//订单表
		                    	  //删除权限表
		                    	  AdminUsrRole.find(teasession._strCommunity, moobj.getMember()).delete();
		                    	  IntegralRecord.delete(moobj.getMember());

		                         
		                    }else if("member_audit".equals(act))//审核 显示
		                    {
		                    	if(moobj.getVerifg()==0)
		                    	{
		                    		moobj.setVerifg(1);
		                    	}else
		                    	{
		                    		next_str ="抱歉!您审核的会员里面有【已审核】的会员.\\n系统只能审核【未审核】的会员!";
		                    	}
		                    }else if("member_cancel_audit".equals(act))//还原
		                    {
		                    	if(moobj.getVerifg()==0)
		                    	{
		                    		next_str ="抱歉!您还原的会员里面有【未审核】的会员.\\n系统只能还原【已审核或已拒绝】的会员!";
		                    	}else 
		                    	{
		                    		moobj.setVerifg(0);
		                    		
		                    	}
		                    }else if("member_refusal".equals(act))//拒绝作品
		                    {
		                    	if(moobj.getVerifg()==2)
		                    	{
		                    		next_str ="抱歉!您拒绝的会员里面有【已拒绝】的会员.\\n系统只能拒绝【已审核或未审核】的会员!";
		                    	}else 
		                    	{
		                    		moobj.setVerifg(2);
		                    		
		                    	}
		                    }else if("member_proxymember".equals(act))//设置代理
		                    {
		                    	if(moobj.getProxymembertype2()==0)
		                    	{
		                    		moobj.setProxymembertype2(1);
		                    	}else
		                    	{
		                    		moobj.setProxymembertype2(0); 
		                    	} 
		                    	
		                    	
		                    }
		                }
						java.io.PrintWriter out = response.getWriter();
						out.print("<script  language='javascript'>alert('" + next_str + "');window.location.href='" + nexturl + "&id="+teasession.getParameter("id")+"';</script> ");
						out.close();
						return;
		            } 
            }
            else if("delete".equals(act))
            {
                RegisterInstall riobj = RegisterInstall.find(membertype);
                myobj.delete();
                riobj.delete(); //会员注册里面的
                MemberOrder.delete(membertype); //删除订单表中的数据
                MemberPay.delete(membertype); //删除缴费表中的数据
                Describes dobj = Describes.find(membertype);
                dobj.delete(); //删除会员设置中的字段描述信息
                //删除会员注册 类型的表中的信息  表 MemberRecord
                MemberRecord.delete(membertype);

            } else if("type".equals(act))
            {
                MemberOrder.DELETETYPE();
                myobj.setType(Integer.parseInt(teasession.getParameter("type")));
            } else if("RegisterInstall".equals(act)) //会员类型的注册设置
            {
                int clause = Integer.parseInt(teasession.getParameter("clause")); //A.是否需要条款声明
                //B.注册信息选项
                String register[] = teasession.getParameterValues("register");
                StringBuffer str_register = new StringBuffer();;
                if(register != null && register.length > 0)
                {
                    str_register.append("/");
                    for(int i = 0;i < register.length;i++)
                    {
                        str_register.append(register[i]).append("/");
                    }
                }
                String inspect[] = teasession.getParameterValues("inspect");
                StringBuffer str_inspect = new StringBuffer();;
                if(inspect != null && inspect.length > 0)
                {
                    str_inspect.append("/");
                    for(int i = 0;i < inspect.length;i++)
                    {
                        str_inspect.append(inspect[i]).append("/");
                    }
                }

                //C.用户名限制
                int restrictions = Integer.parseInt(teasession.getParameter("restrictions"));
                //D.是否关联填写类别信息
                int related = Integer.parseInt(teasession.getParameter("related"));
                int relatednews = Integer.parseInt(teasession.getParameter("relatednews"));
                int fathernode = 0;
                if(teasession.getParameter("fathernode") != null && teasession.getParameter("fathernode").length() > 0)
                {
                    fathernode = Integer.parseInt(teasession.getParameter("fathernode"));
                }
                if(related == 0)
                {
                    relatednews = 0;
                    fathernode = 0;
                }

                // E.生成注册按钮路径
                String buttonurl = teasession.getParameter("buttonurl"); //
                //F.是否需要审核
                int verify = Integer.parseInt(teasession.getParameter("verify"));
                //E.生成审核菜单路径
                String menuurl = teasession.getParameter("menuurl");

                //是否缴费
                int payment = Integer.parseInt(teasession.getParameter("payment"));

                java.math.BigDecimal paymoney = new java.math.BigDecimal(0);
                if(teasession.getParameter("paymoney") != null && teasession.getParameter("paymoney").length() > 0)
                {
                    paymoney = new BigDecimal(teasession.getParameter("paymoney"));
                }

                int paytime = 0; //Integer.parseInt(teasession.getParameter("paytime"));
                String paycontent = teasession.getParameter("paycontent");

                if(payment == 0)
                {
                    MemberPay.WholeDelete(membertype);
                }

                //描述字段
                String member = teasession.getParameter("member");
                String password = teasession.getParameter("password");
                String confirmpassword = teasession.getParameter("confirmpassword");
                String email = teasession.getParameter("email");
                String firstname = teasession.getParameter("firstname");
                String sex = teasession.getParameter("sex");
                String card = teasession.getParameter("card");
                String birthyear = teasession.getParameter("birthyear");
                String state = teasession.getParameter("state");
                String address = teasession.getParameter("address");
                String phonenumber = teasession.getParameter("phonenumber");
                String zip = teasession.getParameter("zip");
                String telephone = teasession.getParameter("telephone");
                String fax = teasession.getParameter("fax");
                //职称
                String position = teasession.getParameter("position");
                //单位
                String organization = teasession.getParameter("organization");
                //科室 部门
                String section = teasession.getParameter("section");
                //学历
                String degree = teasession.getParameter("degree");
                String vertify = teasession.getParameter("vertify");
                //国籍
                String country = teasession.getParameter("Country");
                String identitys=teasession.getParameter("identitys");//目前身份
                
               
                 
                RegisterInstall riobj = RegisterInstall.find(membertype);
                Describes dbobj = Describes.find(membertype);
                if(riobj.isMemberType())
                {
                    riobj.set(clause,str_register.toString(),restrictions,related,relatednews,buttonurl,verify,menuurl,teasession._rv.toString(),community,str_inspect.toString(),
                    		payment,paymoney,paytime,paycontent,fathernode);
                    if(Describes.isMembertype(membertype))
                    {
                        dbobj.set(member,password,confirmpassword,email,firstname,sex,card,birthyear,state,address,phonenumber,zip,telephone,fax,vertify,position,organization,
                        		section,degree,country,identitys);
                    } else
                    {
                        Describes.create(membertype,member,password,confirmpassword,email,firstname,sex,card,birthyear,state,address,phonenumber,zip,telephone,fax,vertify,position,
                        		organization,section,degree,country,identitys);
                    }
                } else
                {
                    RegisterInstall.create(clause,str_register.toString(),restrictions,related,relatednews,buttonurl,verify,menuurl,teasession._rv.toString(),community,membertype,str_inspect.toString(),payment,paymoney,paytime,paycontent,fathernode);
                    Describes.create(membertype,member,password,confirmpassword,email,firstname,sex,card,birthyear,state,address,phonenumber,zip,telephone,fax,vertify,position,
                    		organization,section,degree,country,identitys);
                }
            }

            response.sendRedirect(nexturl + "&community=" + community);
            return;

        } catch(Exception ex)
        {
            ex.printStackTrace();
        }

    }

    // Clean up resources
    public void destroy()
    {
    }
}
