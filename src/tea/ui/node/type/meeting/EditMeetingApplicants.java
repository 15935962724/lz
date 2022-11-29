package tea.ui.node.type.meeting;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import tea.entity.Http;
import tea.entity.member.Profile;
import tea.entity.member.SMessage;
import tea.entity.node.Meeting;
import tea.entity.node.MeetingApplicants;
import tea.entity.node.MeetingInvite;

public class EditMeetingApplicants extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        java.io.PrintWriter out = response.getWriter();

        try
        {
        	out.println("<script>var mt=parent.mt;</script>");
        	String info = "操作执行成功！";
        	
            Http h = new Http(request,response);
            String act = h.get("act");
            String nexturl = h.get("nexturl");
            int id = h.getInt("id");
            MeetingApplicants yma = MeetingApplicants.find(id);
            if(act.equals("registration")){
            	int node = h.getInt("node");
            	int adminunitid = h.getInt("adminunitid");
            	int state = h.getInt("state");
            	int num = h.getInt("num");
            	if(num>0){
            		for(int i=0;i<num;i++){
            			String name = h.get("name"+i);
                		int sex = h.getInt("sex"+i);
                		String tel = h.get("tel"+i);
                		String pwd = tel.substring(5);
            			
                		Profile.set(tel, pwd, h.community, "", 0, h.language, name, "", "",tel,sex,"","","");
                		Profile p = Profile.find(tel);
                		
                		yma = MeetingApplicants.find(node, p.profile);
                		
            			yma.setNode(node);
            			yma.setAdminunitid(adminunitid);
            			yma.setName(name);
            			yma.setSex(sex);
            			yma.setTel(tel);
            			yma.setCatering(Integer.parseInt(h.get("catering"+i)));
            			int stayVal = Integer.parseInt(h.get("stay"+i));
            			yma.setStay(stayVal);
            			if(stayVal==0){
            				yma.setHotelname(h.get("hotelname"+i));
                			yma.setHoteladdress(h.get("hoteladdress"+i));
            			}            			
            			yma.setShuttle(Integer.parseInt(h.get("shuttle"+i)));
            			yma.setTime(new Date());
            			yma.set();
            			
            		}
            		MeetingInvite ymi = MeetingInvite.find(node, adminunitid);
            		ymi.setState(state);
            		ymi.set();
            		out.print("<script language='javascript'>mt.closeRegistration();</script> ");
            	}else{
            		out.print("<script language='javascript'>alert('报名人数不能小于1！');</script> ");
            	}
    			return;
            }else if(act.equals("edit"))
            {
            	Meeting ym = Meeting.find(h.getInt("node"), h.language);
            	if(ym.getTimeStop().getTime()>=new Date().getTime()){
            		String name = h.get("name");
            		int sex = h.getInt("sex");
            		String tel = h.get("tel");
            		String pwd = tel.substring(5);
            		
            		Profile.set(tel, pwd, h.community, "", 0, h.language, name, "", "",tel,sex,"","","");
            		Profile p = Profile.find(tel);
            		
            		if(!yma.isExist())
            			yma = MeetingApplicants.find(h.getInt("node"), p.profile);
            		
            		yma.setNode(h.getInt("node"));
                	yma.setAdminunitid(h.getInt("adminunitid"));
                    yma.setName(name);
                    yma.setSex(sex);
                    yma.setTel(tel);
                    yma.setCatering(h.getInt("catering"));
                    
                    int stay = h.getInt("stay");
                    yma.setStay(stay);
                    if(stay==0){
                    	yma.setHotelname(h.get("hotelname"));
                    	yma.setHoteladdress(h.get("hoteladdress"));
                    }
                    yma.setShuttle(h.getInt("shuttle"));
                    yma.setCatering(h.getInt("catering"));
                    yma.setCatering(h.getInt("catering"));
                    yma.setProfile(p.profile);
                    yma.setTime(new Date());
                    yma.set();
                    
                    //str="操作成功";
            	}else{
            		info="抱歉，已过报名时间，不可再报名！";
            	}
            	out.print("<script language='javascript'>alert('"+info+"');mt.refresh('"+nexturl+"');</script> ");
				return;
            }else if(act.equals("edit2"))
            {
            	Meeting ym = Meeting.find(h.getInt("node"), h.language);
            	if(ym.getTimeStop().getTime()>=new Date().getTime()){
            		String name = h.get("name");
            		int sex = h.getInt("sex");
            		String mobile = h.get("tel");
            		String pwd = mobile.substring(5);
            		
            		String email = h.get("email");//邮箱
        	    	String telephone = h.get("telephone");//固话
        	    	String job = h.get("job");//职务
        	    	String title = h.get("title");//职称
        	    	String section = h.get("section");//工作单位
            		
        	    	Profile.set(mobile, pwd, h.community, email, 0, h.language, name, "", telephone,mobile,sex,job,title,section);
            		Profile p = Profile.find(mobile);
            		
            		if(!yma.isExist())
            			yma = MeetingApplicants.find(h.getInt("node"), p.profile);
            		
            		yma.setNode(h.getInt("node"));
                	yma.setAdminunitid(h.getInt("adminunitid"));
                    yma.setName(name);
                    yma.setSex(sex);
                    yma.setTel(mobile);
                    
                    yma.setProfile(p.profile);
                    yma.setTime(new Date());
                    yma.set();
                    
                    //str="操作成功";
            	}else{
            		info="抱歉，已过报名时间，不可再报名！";
            	}
            	out.print("<script language='javascript'>alert('"+info+"');mt.refresh('"+nexturl+"');</script> ");
				return;
            }else if(act.equals("del")){
            	yma.delete();
            	int count = MeetingApplicants.count(" AND adminunitid="+yma.getAdminunitid());
            	if(count==0){
            		MeetingInvite ymi = MeetingInvite.find(yma.getNode(), yma.getAdminunitid());
            		ymi.setState(0);
            		ymi.set();
            	}
            	out.print("<script language='javascript'>alert('"+info+"');mt.refresh('"+nexturl+"');</script> ");
				return;
            }else if("uploadParticipants".equals(act)){
            	String destFile = h.get("destFile");
            	String filePath = this.getServletContext().getRealPath(destFile);
				List<String[]> list = readExcel(filePath);
            	for(int i=1;i<list.size();i++){
            	    String[] str = (String[])list.get(i);
            	    if(!str[6].equals("")){//手机号不为空则发送
//            	    	String result = SMessage.create(h.community,"webmaster","|","13581504421",h.language,"test");
//            	    	System.out.println(result);
            	    	
            	    	int sex="男".equals(str[1])?1:0;
            	    	String email = str[7];//邮箱
            	    	String name = str[0];//姓名
            	    	String telephone = str[5];//固话
            	    	String mobile = str[6];//手机号码（登录用户名member）
            	    	String pwd = str[6].substring(5);
            	    	String job =str[2];//职务
            	    	String title = str[3];//职称
            	    	String section = str[4];//工作单位
            	    	
            	    	Profile.set(mobile, pwd, h.community, email, 0, h.language, name, "", telephone,mobile,sex,job,title,section);
            	    	Profile p = Profile.find(mobile);
            	    	
            	    	MeetingApplicants ma = MeetingApplicants.find(h.getInt("node"), p.profile);
            	    	
            	    	ma.setNode(h.getInt("node"));
            	    	ma.setAdminunitid(h.getInt("adminunitid"));
            	    	ma.setName(name);
            	    	ma.setSex(sex);
            	    	ma.setTel(mobile);
            	    	ma.setProfile(p.profile);
            	    	ma.setTime(new Date());
            	    	ma.set();
            	    }
            	    //for(int j=0;j<str.length;j++){
            	     //System.out.println(str[0]+"=="+str[6]);
            	    //}
            	}
            	
            }
            out.print("<script>mt.show('" + info + "',1,\"" + nexturl + "\");</script>");
            /*if(nexturl!=null && nexturl.length()>0)
            {
            	//response.sendRedirect(nexturl+"&adminrole="+teasession.getParameter("adminrole"));

            	 //out.print("<script>window.open('" + nexturl + "','_parent');</script>");
            	 out.print("<script>mt.show('" + info + "',1,\"" + nexturl + "\");</script>");
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
    
	private List<String[]> readExcel(String filePath) throws Exception, IOException{
    	
    	List<String[]> list = new ArrayList<String[]>();
    	
    	Workbook rwb = null;
    	Cell cell = null;

    	//创建输入流
    	InputStream stream = new FileInputStream(filePath);
    	//获取Excel文件对象
    	rwb = Workbook.getWorkbook(stream);

    	//获取文件的指定工作表 默认的第一个
    	Sheet sheet = rwb.getSheet(0); 

    	//行数(表头的目录不需要，从1开始)
    	for(int i=1; i<sheet.getRows(); i++){

    	 //创建一个数组 用来存储每一列的值
    	 String[] str = new String[sheet.getColumns()];
    	 //列数
    	 for(int j=0; j<sheet.getColumns(); j++){

    	  //获取第i行，第j列的值
    	  cell = sheet.getCell(j,i);   
    	  str[j] = cell.getContents();
    	 
    	 }
    	 //把刚获取的列存入list
    	 list.add(str);
    	}
    	
    	return list;
    }
}
