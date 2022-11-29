package tea.ui.node.type.hostel;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.node.*;
import tea.ui.*;
import tea.htmlx.TimeSelection;
import tea.entity.member.Message;
import java.text.*;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import tea.entity.member.*;
import java.lang.*;

public class EditDestine extends TeaServlet
{
    //Initialize global variables
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            int destine = 0;
            TeaSession tes = new TeaSession(request);
            String nu = "/jsp/type/hostel/Destines.jsp?node=" + tes._nNode;
            if (tes.getParameter("destine") != null)
            {
                destine = Integer.parseInt(tes.getParameter("destine"));
            }

            String nexturl = tes.getParameter("nexturl");
            String act = tes.getParameter("act");
             Destine destine_obj = Destine.find(destine);
            if("deal".equals(act))
            {
                String idea= tes.getParameter("idea");
                int ideatype = Integer.parseInt(tes.getParameter("ideatype"));
                int emiletype = Integer.parseInt(tes.getParameter("emiletype"));
                int statetype = Integer.parseInt(tes.getParameter("state"));
                destine_obj.setIdea(idea,ideatype,statetype);
                if (emiletype == 0) //同意发送Emile信件
                {
                    tea.service.SendEmaily se = new tea.service.SendEmaily(tes._strCommunity);
                    se.sendEmail(destine_obj.getLinkmanmail(), "黄金假日酒店预定信息", destine_obj.getIdea());
                }
                System.out.println(nexturl);
                  response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("操作成功!", "UTF-8") + "&nexturl=" + nexturl);
                  return ;
            }
            if("orderdeal".equals(act))
            {
                String inform = tes.getParameter("inform");
                int emiletype = Integer.parseInt(tes.getParameter("emiletype"));
                destine_obj.setInform(inform);
                Profile p = Profile.find(destine_obj.getMember());
              // System.out.print(p.getEmail()+"------");p.getEmail()
                if(emiletype == 0)
                {
                    tea.service.SendEmaily se = new tea.service.SendEmaily(tes._strCommunity);
                    se.sendEmail(p.getEmail(), "黄金假日酒店订单督促通知", destine_obj.getInform());
                }
                response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("操作成功!", "UTF-8") + "&nexturl=" + nexturl);
                  return ;
            }
            if("kind".equals(act))
            {
                String sql = tes.getParameter("sql");

             response.setContentType("application/x-msdownload");
             response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("酒店订单" + ".xls", "UTF-8"));
             javax.servlet.ServletOutputStream os = response.getOutputStream();


             try
               {
                   jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                   jxl.write.WritableSheet ws = wwb.createSheet("酒店订单", 0);
                   //加粗字体
//                   WritableFont font1=new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD);
//                   //font1.setColour(Colour.RED);
//                   WritableCellFormat format1 = new WritableCellFormat(font1);
//                   format1.setAlignment(jxl.format.Alignment.CENTRE);
//                   format1.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);


                   WritableFont font2 = new WritableFont(WritableFont.createFont("宋体"), 16, WritableFont.BOLD);
                   WritableCellFormat format2 = new WritableCellFormat(font2);
                   format2.setAlignment(jxl.format.Alignment.CENTRE);
                   format2.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);

                   //标题加粗
//                  / ws.mergeCells(1, 0, 5, 0);

                   ws.addCell(new jxl.write.Label(0, 0, "订单会员"));
                   ws.addCell(new jxl.write.Label(1, 0, "所定酒店"));
                   ws.addCell(new jxl.write.Label(2, 0, "订单编号"));
                   ws.addCell(new jxl.write.Label(3, 0, "订单日期"));
                   ws.addCell(new jxl.write.Label(4, 0, "订单状态"));

                   java.util.Enumeration e = Destine.find(tes._strCommunity, sql.toString(), 0, Integer.MAX_VALUE);
                   int index = 1;
                   for (int i = 0; e.hasMoreElements(); i++)
                   {
                       int id = ((Integer) e.nextElement()).intValue();
                       Destine d = Destine.find(id);
                       Node n = Node.find(d.getNode());
                       Profile p = Profile.find(d.getMember());
                       ws.addCell(new jxl.write.Label(0, i + 1, p.getLastName(tes._nLanguage) + p.getFirstName(tes._nLanguage)));
                       ws.addCell(new jxl.write.Label(1, i + 1, n.getSubject(tes._nLanguage)));
                       ws.addCell(new jxl.write.Label(2, i + 1, String.valueOf(id)));
                       ws.addCell(new jxl.write.Label(3, i + 1, d.getDestinedateToString()));
                       ws.addCell(new jxl.write.Label(4, i + 1, Destine.STATE[d.getState()]));
                       index++;
                   }
                   wwb.write();
                   wwb.close();
                   os.close();
               } catch (Exception ex)
               {
                       ex.printStackTrace();
               }
                return ;

            }

            if("orderstatistics".equals(act))
            {
                String sql = tes.getParameter("sql");

                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("酒店订单统计" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();

                try
                {
                    jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                    jxl.write.WritableSheet ws = wwb.createSheet("酒店订单统计", 0);
                    WritableFont font2 = new WritableFont(WritableFont.createFont("宋体"), 16, WritableFont.BOLD);
                    WritableCellFormat format2 = new WritableCellFormat(font2);
                    format2.setAlignment(jxl.format.Alignment.CENTRE);
                    format2.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);

                    ws.addCell(new jxl.write.Label(0, 0, "所定酒店"));
                    ws.addCell(new jxl.write.Label(1, 0, "订单总数"));
                    ws.addCell(new jxl.write.Label(2, 0, "已受理数"));
                    ws.addCell(new jxl.write.Label(3, 0, "未受理数"));
                    ws.addCell(new jxl.write.Label(4, 0, "过期订单数"));

                    java.util.Enumeration e = Destine.findTj(tes._strCommunity, sql.toString(), 0,Integer.MAX_VALUE);
                    int dingdan = 0, yshouli = 0, wshouli = 0, gshouli = 0,index=1;
                    for(int i  =0;e.hasMoreElements();i++)
                    {
                        int id = ((Integer) e.nextElement()).intValue();
                        Node n = Node.find(id);
                        dingdan = Destine.countTj(" and node=" + id);
                        yshouli = Destine.countTj("  and node=" + id + " and state=1");
                        wshouli = Destine.countTj(" and node=" + id + " and state=0");
                        gshouli = Destine.countTj(" and node=" + id + " and (state=2 or state=3 )");

                        ws.addCell(new jxl.write.Label(0, i + 1, n.getSubject(tes._nLanguage)));
                        ws.addCell(new jxl.write.Label(1, i + 1, String.valueOf(dingdan)));
                        ws.addCell(new jxl.write.Label(2, i + 1, String.valueOf(yshouli)));
                        ws.addCell(new jxl.write.Label(3, i + 1, String.valueOf(wshouli)));
                        ws.addCell(new jxl.write.Label(4, i + 1, String.valueOf(gshouli)));
                        index++;
                    }
                    wwb.write();
                    wwb.close();
                    os.close();
              } catch (Exception ex)
              {
                      ex.printStackTrace();
              }
               return ;

            }
            if("membership".equals(act))
            {
                String sql = tes.getParameter("sql");
                System.out.println("EditDestine/Servlet sql is : "+sql);
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("会员统计" + ".xls", "UTF-8"));
                javax.servlet.ServletOutputStream os = response.getOutputStream();
                try
                {
                    jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
                    jxl.write.WritableSheet ws = wwb.createSheet("会员统计", 0);
                    WritableFont font2 = new WritableFont(WritableFont.createFont("宋体"), 16, WritableFont.BOLD);
                    WritableCellFormat format2 = new WritableCellFormat(font2);
                    format2.setAlignment(jxl.format.Alignment.CENTRE);
                    format2.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);

                    ws.addCell(new jxl.write.Label(0, 0, "会员ID"));
                    ws.addCell(new jxl.write.Label(1, 0, "登陆次数"));
                    ws.addCell(new jxl.write.Label(2, 0, "下订单数"));
                    ws.addCell(new jxl.write.Label(3, 0, "已受理订单数"));
                    java.util.Enumeration e = Destine.findmember(tes._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
                    int index=1;
                    for(int i  =0;e.hasMoreElements();i++)
                    {
                        String mem = e.nextElement().toString();
                        int logs = Logs.count(mem, 1); //1 是登陆状态
                        int orders = Destine.countByMember(tes._strCommunity, mem, "");
                        int has = Destine.countByMember(tes._strCommunity, mem, " AND dstate = " + 1);

                        ws.addCell(new jxl.write.Label(0, i + 1, mem));
                        ws.addCell(new jxl.write.Label(1, i + 1, String.valueOf(logs)));
                        ws.addCell(new jxl.write.Label(2, i + 1, String.valueOf(orders)));
                        ws.addCell(new jxl.write.Label(3, i + 1, String.valueOf(has)));

                        index++;
                    }
                    wwb.write();
                    wwb.close();
                    os.close();
              } catch (Exception ex)
              {
                      ex.printStackTrace();
              }
               return ;

            }
            if (tes.getParameter("edit") != null && tes.getParameter("edit").equals("ON")) //通过审核
            {

                destine_obj.setState(1);
            } else  if (tes.getParameter("state") != null && tes.getParameter("state").equals("ON")) //把状态改为已入住
            {
               // Destine destine_obj = Destine.find(destine);
                destine_obj.setState(2);
            } else
            if (tes.getParameter("delete") != null && tes.getParameter("delete").equals("ON")) //删除记录
            {
               // Destine destine_obj = Destine.find(destine);
                destine_obj.delete();
            } else
            {
                java.util.Date kipdate = Destine.sdf.parse(request.getParameter("kipDateFlag"));
                java.util.Date leavedate = Destine.sdf.parse(request.getParameter("leaveDateFlag"));
                Destine.sdf.parse(request.getParameter("leaveDateFlag"));
                if (kipdate.compareTo(new Date(System.currentTimeMillis())) < 0)
                {
                    outText(tes, response, "无效住店日期");
                    return;
                }
                if (leavedate.compareTo(kipdate) < 0)
                {
                    outText(tes, response, "无效离开日期");
                    return;
                }
                StringBuilder humanname = new StringBuilder();
                String humanNames[] = request.getParameterValues("TxtName");
                for (int i = 0; i < humanNames.length; i++)
                {
                    if (humanNames[i].length() > 0)
                    {
                        humanname.append(humanNames[i] + ",");
                    }
                }
                int roomcount = Integer.parseInt(request.getParameter("roomcount"));
                String eveningarrive = request.getParameter("eveningarrive");
                int roomprice = Integer.parseInt(request.getParameter("roomprice"));
                //入住人信息humanname=='request.getParameter("TxtName")'
                boolean sex =new Boolean( request.getParameter("sex")).booleanValue();
                String handset = request.getParameter("handset");
                String phone = request.getParameter("phone");
                int paymenttype = Integer.parseInt(request.getParameter("paymenttype"));

                //联系人信息
                String linkmanname = request.getParameter("linkmanname");
                boolean linkmansex = new Boolean(request.getParameter("linkmansex")).booleanValue();
                String linkmanhandset = request.getParameter("linkmanhandset");
                String linkmanphone = request.getParameter("linkmanphone");
                String linkmanmail = request.getParameter("linkmanmail");
                String linkmanfax = request.getParameter("linkmanfax");
                int linkmanaffirm = Integer.parseInt(request.getParameter("linkmanaffirm"));
                //特殊要求
                String request_str = request.getParameter("otherrequest");
                int otheraddbed = Integer.parseInt(request.getParameter("otheraddbed"));
                //酒店说明
                boolean othersend = request.getParameter("othersend") != null;//我需要
                String otherpostalcode = request.getParameter("otherpostalcode");
                String address = request.getParameter("otheraddress");
                int state = 0;

                if (destine>0)
                {
                    destine_obj.set(roomprice, roomcount, handset, phone, kipdate, leavedate,eveningarrive,  paymenttype, linkmansex, linkmanhandset, linkmanphone, linkmanmail, linkmanfax, linkmanaffirm, othersend, otherpostalcode, otheraddbed, destine_obj.getState(), tes._rv.toString(),
                                    tes._nLanguage, humanname.toString(), linkmanname, address, request_str,destine_obj.getDstate(),sex);
                } else
                {
                    destine = Destine.create(tes._nNode, roomprice, roomcount, handset, phone, kipdate, leavedate, eveningarrive, paymenttype, linkmansex, linkmanhandset, linkmanphone, linkmanmail, linkmanfax, linkmanaffirm, othersend, otherpostalcode,
                                             otheraddbed, state, tes._rv.toString(), tes._strCommunity, tes._nLanguage, humanname.toString(), linkmanname, address, request_str,sex);

                }
                nu = "/jsp/type/hostel/DesSuc.jsp";
               // nu = "/jsp/type/hostel/DestineView.jsp?node=" + tes._nNode + "&destine=" + destine + "&roomprice=" + roomprice;
            }
            response.sendRedirect(nu);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}

