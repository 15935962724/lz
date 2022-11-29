package tea.entity.custom.jjh;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.*;
import jxl.write.*;

import tea.entity.Http;
import tea.entity.RV;
import tea.entity.member.Logs;
import tea.entity.node.AccessMember;
import tea.entity.node.Category;
import tea.entity.node.Node;
import tea.entity.util.Card;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditVolunteer extends TeaServlet{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		response.setContentType("text/html;charset=UTF-8");
		Http h=new Http(request);
		//TeaSession tea=new TeaSession(request);
		if(h.member==0){
			outLogin(request,response,h);
            return;
		}
		String nexturl=h.get("nextUrl"),act=h.get("act");
//		PrintWriter pw=response.getWriter();
//		pw.println("<script>var pmt=parent.mt,doc=parent.document;</script>");
//        pw.println("<script>var mt=parent.mt,doc=parent.document;</script>");
		String txtreturn="";
		try{
			if("edit".equals(act)){
				 Node node=Node.find(h.node);
				 int vid=h.getInt("vid",0);
				 if(vid==0){
					 int sequence = Node.getMaxSequence(h.node) + 10;
	                 int  options1 = 0;
	                 long options=node.getOptions();
	                 Category cat=Category.find(h.node);
	                 h.node=Node.create(h.node,sequence,h.community,new RV(h.username),cat.getCategory(),false,options,options1,node.getDefaultLanguage(),null,null,new Date(),0,0,0,0,null,h.language,"","","",null,"",null,0,null,"","","","","","");
				 }else{
					 AccessMember obj_am = AccessMember.find(node._nNode, new RV(h.username));
	                    if (!node.isCreator(new RV(h.username)) && obj_am.getPurview() < 2)
	                    {
	                        response.sendError(403);
	                        return;
	                    }

				 }
				 String vname=h.get("vname");
				 int vsex=h.getInt("vsex");
				 int vnation=h.getInt("vnation");
				 int vprovince=h.getInt("vprovince");
				 int vtype=h.getInt("vtype",0);
				 String vnum=h.get("vnum");
				 String vuwork=h.get("vuwork");
				 String vphone=h.get("vphone");
				 Date vtime=h.getDate("vtime");
				 Volunteer v=new Volunteer( vid,h.node, vname, vsex, vnation, vprovince, vtype, vnum, vuwork, vphone, vtime);
				 v.setVolunteer();
				 delete(node);
				 node.finished(h.node);
				 if(vid==0){
					 txtreturn="<script>pmt.show('添加志愿者信息成功！',1,'" + nexturl + "');</script>";
//					 pw.print("<script>pmt.show('添加志愿者信息成功！',1,'" + nexturl + "');</script>");
				 }else{
//					 pw.print("<script>pmt.show('修改志愿者信息成功！',1,'" + nexturl + "');</script>");
					 txtreturn="<script>pmt.show('修改志愿者信息成功！',1,'" + nexturl + "');</script>";
				 }
			}else if("del".equals(act)){
				int vid=h.getInt("vid",0);
				 Volunteer v=Volunteer.getVolunteer(vid);
				Node node=Node.find(h.node);
				node.delete(h.language);
				Logs.create(h.community,new RV(h.username),3,h.node,"志愿者"+v.getVname());
	            delete(node);

				 v.delVolunteer();
//				 pw.print("<script>pmt.show('志愿者信息删除成功！',1,'" + nexturl + "');</script>");
				 txtreturn="<script>pmt.show('志愿者信息删除成功！',1,'" + nexturl + "');</script>";
			}else if("delAll".equals(act)){
				String nodess=h.get("nodess");
				if(nodess!=null&&nodess.trim().length()>0&&(!"/".equals(nodess.trim()))){
					String[] nodes=nodess.split("/");
					for(int i=0;i<nodes.length;i++){
						if(nodes[i]!=null&&nodes[i].length()>0){
							int nodeid=Integer.parseInt(nodes[i]);
							Node node=Node.find(nodeid);
							node.delete(h.language);
							Logs.create(h.community,new RV(h.username),3,nodeid,"志愿者");
				            delete(node);
				            List list=Volunteer.findVolunteer(" and node="+nodeid, 0, 10);
				            if(list.size()>0){
				            Iterator it=list.iterator();
				            while(it.hasNext()){
				            	Volunteer vol=(Volunteer)it.next();
				            	vol.delVolunteer();
				            }
				            }
						}
					}

				}


//				 pw.print("<script>pmt.show('志愿者信息删除成功！',1,'" + nexturl + "');</script>");
				 txtreturn="<script>pmt.show('志愿者信息删除成功！',1,'" + nexturl + "');</script>";
			}else if("Excel".equals(act)){
				String sql=h.get("vid");
				List list=Volunteer.findVolunteer(sql, 0, Integer.MAX_VALUE);
//				pw.close();
				ServletOutputStream s=response.getOutputStream();
				WritableWorkbook ww=Workbook.createWorkbook(s);
				WritableSheet sheet=ww.createSheet("查询结果", 0);
				response.setContentType("application/x-msdownload");
				String name="志愿者信息表.xls";
				response.setHeader("Content-Disposition", "attachment; filename=\"" + new String(name.getBytes("GBK"),"ISO-8859-1") + "\"");
				WritableFont wf= new WritableFont(WritableFont.TIMES, 10,WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
				WritableCellFormat cf=new WritableCellFormat(wf);// 单元格定义
				cf.setAlignment(jxl.format.Alignment.LEFT); // 设置对齐方式
				// ws.getSettings().setPrintGridLines(true);//是否打印网格线
				int cols=9;
				for(int i=0;i<cols;i++){
					sheet.setColumnView(i, 20); // 设置列的宽度
				}
				String[] showcol=new String[]{"姓名","省份","性别","民族","类别","身份证号","所在单位","联系电话","注册时间"};
				for(int i=0;i<cols;i++){
					sheet.addCell(new Label(i,0,showcol[i],cf));
				}
				int j=0;
				Iterator it=list.iterator();
				while(it.hasNext()){
					Volunteer v=(Volunteer) it.next();
					String sex=v.getVsex()==0?"男":"女";
					sheet.addCell(new Label(0,j+1,v.getVname()));
					String pri="";
					if(v.getVprovince()==71){
						pri="台湾省";
					}else if(v.getVprovince()==81){
						pri="香港特区";
					}else if(v.getVprovince()==82){
						pri="澳门特区";
					}else{
						pri=Card.find(v.getVprovince()).toString();
					}
					sheet.addCell(new Label(1,j+1,pri));
					sheet.addCell(new Label(2,j+1,sex));
					String vn="";
					if(v.getVnation()!=0){
						vn=Volunteer.nations[v.getVnation()-1];
					}
					sheet.addCell(new Label(3,j+1,vn));
					Voltype vol=Voltype.findVoltype(v.getVtype());
					sheet.addCell(new Label(4,j+1,vol.getVtname()));
					String pid=v.getVnum()==null?"":v.getVnum();
					sheet.addCell(new Label(5,j+1,pid));
					String vuwork=v.getVuwork()==null?"":v.getVuwork();
					sheet.addCell(new Label(6,j+1,vuwork));
					String vphone=v.getVphone()==null?"":v.getVphone();
					sheet.addCell(new Label(7,j+1,vphone));
					String vtime=v.getVtime()==null?"":Volunteer.sdf2.format(v.getVtime());
					sheet.addCell(new Label(8,j+1,vtime));


					j++;
				}
				ww.write();
				ww.close();
				s.close();
				return ;
			}
			PrintWriter pw=response.getWriter();
			pw.println("<script>var pmt=parent.mt,doc=parent.document;</script>");
			if(txtreturn.trim().length()>0){
				pw.print(txtreturn);
			}
			pw.close();
			return;
		}catch(Throwable ex){
//			pw.print("<script>pmt.show(\"<textarea cols=29 rows=3>" + ex.toString() + "</textarea>\",1,'出现未知错误！');</script>");
			ex.printStackTrace();
		}finally{
//			pw.close();
		}
	}

}
