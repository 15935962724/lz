package tea.ui.node.type.hostel;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*; //import java.util.*;
//import tea.ui.TeaServlet;
import tea.ui.*;
import tea.entity.node.*;
import java.util.Date;

public class EditHostel extends TeaServlet
{
    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if (teasession._rv == null)
        {
            response.sendRedirect(request.getContextPath() + "/servlet/StartLogin?node=" + teasession._nNode + "&NextUrl=" + request.getRequestURL().toString());
            return;
        }
        try
        {
            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/type/hostel/EditHostel.jsp?" + request.getQueryString());
            } else
            // post方式
            {
                  Node node = Node.find(teasession._nNode);
                  Hostel hostel = Hostel.find(teasession._nNode, teasession._nLanguage);
                  String name = teasession.getParameter("Name");//名称
                  int StarClass =0;
                  if(teasession.getParameter("StarClass")!=null && teasession.getParameter("StarClass").length()>0)
                      StarClass = Integer.parseInt(teasession.getParameter("StarClass"));
                  String phone = teasession.getParameter("Phone");//电话
                   String fax = teasession.getParameter("Fax");//传真
                    String contact = teasession.getParameter("Contact");//联系人
                  String address = teasession.getParameter("Address");//地址
                     String postalcode = teasession.getParameter("Postalcode");//邮编
                int city = Integer.parseInt(teasession.getParameter("city"));//城市
                int borough =Integer.parseInt(teasession.getParameter("borough")); //市区
                //地理位置:
               float placeh = 0;
               if(teasession.getParameter("placeh")!=null && teasession.getParameter("placeh").length()>0)
                   placeh = Float.parseFloat(teasession.getParameter("placeh"));
               float placef = 0;
              if(teasession.getParameter("placef")!=null && teasession.getParameter("placef").length()>0)
                  placef = Float.parseFloat(teasession.getParameter("placef"));
              float places = 0;
              if(teasession.getParameter("places")!=null && teasession.getParameter("places").length()>0)
                  places = Float.parseFloat(teasession.getParameter("places"));
              float placed = 0;
              if(teasession.getParameter("placed")!=null && teasession.getParameter("placed").length()>0)
                  placed = Float.parseFloat(teasession.getParameter("placed"));

              byte by[] = teasession.getBytesParameter("Picture"); //图片
              String picture = null;
              if (teasession.getParameter("ClearPicture") != null)
              {
                  picture = null;
              } else if (by != null)
              {
                  picture = super.write(node.getCommunity(), by, ".gif");
              } else
              {
                 picture = hostel.getPicture();
              }


              String logo = null;//Logo
               by = teasession.getBytesParameter("logo");
               if (teasession.getParameter("ClearLogo") != null)
               {
                   logo = null;
               } else if (by != null)
               {
                   logo = super.write(node.getCommunity(), by, ".gif");
               } else
               {
                   logo = hostel.getLogo();
               }

               String housexing = teasession.getParameter("housexing");
               String price = teasession.getParameter("price");
               Date timeyouxiao = null;
               if(teasession.getParameter("timeyouxiao")!=null && teasession.getParameter("timeyouxiao").length()>0)
                   timeyouxiao = Hostel.sdf.parse(teasession.getParameter("timeyouxiao"));


               Date timeyouxiao2 = null;
            if(teasession.getParameter("timeyouxiao2")!=null && teasession.getParameter("timeyouxiao2").length()>0)
                timeyouxiao2 = Hostel.sdf.parse(teasession.getParameter("timeyouxiao2"));

               String intro = teasession.getParameter("Intro"); //简介

               //酒店设施
               String diningroom = teasession.getParameter("diningroom");
               String commerce = teasession.getParameter("commerce");
               String amusement = teasession.getParameter("amusement");
               String emporium = teasession.getParameter("emporium");
               String elses = teasession.getParameter("elses");

               String DuoPicture = teasession.getParameter("DuoPicture");//多个图片
               String DuoHousexing = teasession.getParameter("DuoHousexing");//多个房型

               int payment = Integer.parseInt(teasession.getParameter("payment"));
               String paymenttext = teasession.getParameter("paymenttext_"+payment);
               String tupian = teasession.getParameter("tupian");
               String fangxing= teasession.getParameter("fangxing");
               String map = teasession.getParameter("map");

               String specialintro=teasession.getParameter("specialintro");
               String clew=teasession.getParameter("clew");
               Date time = new Date();

               //
               // 判断库中是否存在这条记录
               if (hostel.isExists()) // 修改记录
               {
                   node.set(teasession._nLanguage, name, teasession.getParameter("text"));
                   hostel.set(name, StarClass, phone, fax, contact, address, postalcode, city, borough, placeh, placef, places, placed, picture, logo, housexing, price, timeyouxiao, intro, diningroom, commerce, amusement, emporium, elses, DuoPicture, DuoHousexing, payment, paymenttext,specialintro,clew,teasession._rv.toString(),timeyouxiao2);
               } else // 插入记录
               {
                    teasession._nNode= Node.createjd(teasession._nNode, 0, teasession._strCommunity, teasession._rv, 48, 0, (node.getOptions1() & 2) != 0, node.getOptions(), 0, 0, null, null, 1, name, null, null, null, null, 0, null, null, null, null, null, null, time, 0, 0, 0, 0, null, null);
                    int c = Node.createjd(teasession._nNode, 0, teasession._strCommunity, teasession._rv, 1, 0, false, node.getOptions(), 0, 0, null, null, 1, name + "新闻", null, null, null, null, 0, null, null, null, null, null, null, time, 0, 0, 0, 0, null, null);
                    Category category = Category.find(c);
                    category.set(39, 0, 0);
                    node.finished(c);
                   Hostel.create(teasession._nNode, 1, name, StarClass, phone, fax, contact, address, postalcode, city, borough, placeh, placef, places, placed, picture, logo, housexing, price, timeyouxiao, intro, diningroom, commerce, amusement, emporium, elses, DuoPicture, DuoHousexing, payment, paymenttext, map,specialintro,clew,teasession._rv.toString(),timeyouxiao);
                   String a[] = tupian.split(",");
                   for (int j = 1; j < a.length; j++)
                   {
                       TypePicture tyobj = TypePicture.findByPrimaryKey(Integer.parseInt(a[j]));
                       tyobj.set(teasession._nNode);
                   }
                   String b[] =fangxing.split(",");
                   for(int i =1;i<b.length;i++)
                   {
                       RoomPrice rpobj = RoomPrice.find(Integer.parseInt(b[i]));
                       rpobj.set(teasession._nNode);
                   }

               }
               super.delete(node);
               if (teasession.getParameter("GoBack") != null) // 判断是否点击"上一步"
               {
                   response.sendRedirect("EditNode?node=" + teasession._nNode);
               } else // 完成
               {
                   node.finished(teasession._nNode);
                   response.sendRedirect("Hostel?node=" + teasession._nNode + "&edit=ON");
               }
            }
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
