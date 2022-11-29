package tea.ui.node.type.goods;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import tea.ui.*;
import java.util.Date;

import tea.htmlx.TimeSelection;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.member.*;
import tea.resource.*;
import java.math.*;

public class EditGoods extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
        try
        {
            Resource r = new Resource();
            TeaSession teasession = new TeaSession(request);

            if("delete".equals(teasession.getParameter("act")))
            {
                String nexturl = teasession.getParameter("nexturl");
                System.out.println(teasession.getParameterValues("nodeid"));
                String nodeid[] = teasession.getParameterValues("nodeid");
                for(int i = 0;i < nodeid.length;i++)
                {
                    Node nobj = Node.find(Integer.parseInt(nodeid[i]));
                    Goods gobj = Goods.find(Integer.parseInt(nodeid[i]));
                    nobj.delete(teasession._nLanguage);
                    gobj.delete();
                }
                response.sendRedirect(nexturl);
                return;
            }

            String subject = teasession.getParameter("subject");
            if(subject == null || (subject = subject.trim()).length() < 1)
            {
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidSubject"),"UTF-8"));
                return;
            }
            String text = teasession.getParameter("content");

            int father = teasession._nNode;
            String tmp = teasession.getParameter("father");
            if(tmp != null && tmp.length() > 0)
            {
                father = Integer.parseInt(tmp);
            }
            Node node = Node.find(teasession._nNode);
            //商品编号
            String number = teasession.getParameter("number");
			//条形码
			String barcode = teasession.getParameter("barcode");

            if(node.getType() == 1)
            {
                if(Node.isNumber(number))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"编号已经存在，请重新输入！"),"UTF-8"));
                    return;
                }

                int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                int options1 = node.getOptions1();
                long options = node.getOptions();
                int defautllangauge = node.getDefaultLanguage();
                Category cat = Category.find(father); //34
                teasession._nNode = Node.create(father,sequence,node.getCommunity(),teasession._rv,cat.getCategory(),(options1 & 2) != 0,options,options1,defautllangauge,null,null,new java.util.Date(),0,0,0,0,null,teasession._nLanguage,subject,"","",text,null,"",0,null,"","","","",null,null);
				node=Node.find(teasession._nNode);
                node.finished(teasession._nNode);
                node.setNumer(number,teasession._nNode);
            } else
            {
//                if(!node.getNumber().equals(number))
//                {
//                    if(Node.isNumber(number))
//                    {
//                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"商品编号已经存在，请重新输入！"),"UTF-8"));
//                        return;
//                    }
//                }
                if(father != teasession._nNode && father != node.getFather())
                {
                    node.move(father,false);
                }
                node.set(teasession._nLanguage,subject,text);
                node.setNumer(number,teasession._nNode);
            }
            Goods obj = Goods.find(teasession._nNode);
            String measure = teasession.getParameter("measure");
            String spec = teasession.getParameter("spec");
            String capability = teasession.getParameter("capability");
            int brand = 0;
            tmp = teasession.getParameter("brand");
            if(tmp != null && tmp.length() > 0)
            {
                brand = Integer.parseInt(tmp);
            }
            boolean state = "true".equals(teasession.getParameter("state"));
            String smallpicture = null;
            byte by[] = (teasession.getBytesParameter("smallpicture"));
            if(by != null)
            {
                smallpicture = (super.write(node.getCommunity(),by,".gif"));
            } else if(teasession.getParameter("clearsmallpicture") == null)
            {
                smallpicture = obj.getSmallpicture(teasession._nLanguage);
            }
            String bigpicture = null;
            by = (teasession.getBytesParameter("bigpicture"));
            if(by != null)
            {
                bigpicture = (super.write(node.getCommunity(),by,".gif"));
            } else if(teasession.getParameter("clearbigpicture") == null)
            {
                bigpicture = obj.getBigpicture(teasession._nLanguage);
            }
            String recommendpicture = null;
            by = (teasession.getBytesParameter("recommendpicture"));
            if(by != null)
            {
                recommendpicture = (super.write(node.getCommunity(),by,".gif"));
            } else if(teasession.getParameter("clearrecommendpicture") == null)
            {
                recommendpicture = obj.getCommendpicture(teasession._nLanguage);
            }
            int correspond = 0;
            tmp = teasession.getParameter("prorela1");
            if(tmp != null)
            {
                correspond = Integer.parseInt(tmp);
            }
            int correspond2 = 0;
            tmp = teasession.getParameter("prorela2");
            if(tmp != null)
            {
                correspond2 = Integer.parseInt(tmp);
            }
            int correspond3 = 0;
            tmp = teasession.getParameter("prorela3");
            if(tmp != null)
            {
                correspond3 = Integer.parseInt(tmp);
            }
            int correspond4 = 0;
            tmp = teasession.getParameter("prorela4");
            if(tmp != null)
            {
                correspond4 = Integer.parseInt(tmp);
            }
            int correspond5 = 0;
            tmp = teasession.getParameter("prorela5");
            if(tmp != null)
            {
                correspond5 = Integer.parseInt(tmp);
            }
            int correspond6 = 0;
            tmp = teasession.getParameter("prorela6");
            if(tmp != null)
            {
                correspond6 = Integer.parseInt(tmp);
            }
            BigDecimal price = BigDecimal.ZERO;
            tmp = teasession.getParameter("price");
            if(tmp != null && tmp.length() > 0)
            {
                price = new BigDecimal(tmp);
            }
            //
            int company = 0;
            tmp = teasession.getParameter("company");
            if(tmp != null && tmp.length() > 0)
            {
                company = Integer.parseInt(tmp);
            }
            //
            int used = 0;
            tmp = teasession.getParameter("used");
            if(tmp != null)
            {
                used = Integer.parseInt(tmp);
            }
            //提成
            boolean dtype = Boolean.parseBoolean(teasession.getParameter("dtype"));
            float deduct = 0F;
            tmp = teasession.getParameter("deduct");
            if(tmp != null && tmp.length() > 0)
            {
                deduct = Float.parseFloat(tmp);
            }
            String no = teasession.getParameter("no");
            String goodstype = teasession.getParameter("goodstype");
            obj.set(goodstype,brand,no,state,company,price,used,dtype,deduct,correspond,correspond2,correspond3,correspond4,correspond5,correspond6,teasession._nLanguage,measure,spec,capability,smallpicture,bigpicture,recommendpicture);
           obj.setBarcode(barcode);
			String gts[] = goodstype.split("/");
            for(int index = 1;index < gts.length;index++)
            {
                try
                {
                    int gt_id = Integer.parseInt(gts[index]);
                    if(gt_id > 0)
                    {
                        java.util.Enumeration enumeration = Attribute.findByGoodstype(gt_id);
                        int id = 0;
                        while(enumeration.hasMoreElements())
                        {
                            id = ((Integer) enumeration.nextElement()).intValue();
                            Attribute att_obj = Attribute.find(id);
                            String value = null;
                            if("file".equals(att_obj.getTypes()) || "img".equals(att_obj.getTypes()))
                            {
                                by = teasession.getBytesParameter("attribute" + id);
                                if(by != null)
                                {
                                    value = write(node.getCommunity(),by,".gif");
                                } else if(teasession.getParameter("clearattribute" + id) == null)
                                {
                                    continue;
                                    // value =
                                    // obj.getAttrvalue(teasession._nLanguage);
                                }
                            } else
                            // text
                            {
                                value = teasession.getParameter("attribute" + id);
                            }
                            AttributeValue av = AttributeValue.find(teasession._nNode,id);
                            av.set(teasession._nLanguage,value);
                        }
                    }
                } catch(Exception e)
                {
                }
            }
            super.delete(node);
            if(teasession.getParameter("GoBack") != null)
            {
                response.sendRedirect("EditNode?node=" + teasession._nNode);
            } else if(teasession.getParameter("GoodsType") != null)
            {
                response.sendRedirect("/jsp/type/goods/SelectGoodsType.jsp?node=" + teasession._nNode + "&community=" + node.getCommunity() + "&goodstype=" + goodstype);
            } else
            {
                String nu = teasession.getParameter("nexturl");
                if(nu == null)
                {
                    nu = "/servlet/Node?node=" + teasession._nNode + "&edit=ON";
                }
                if(teasession.getParameter("Gosubmit") != null) //点击下一步 跳出的添加供应商
                {
					java.io.PrintWriter out = response.getWriter();
					 //  out.println("<script  language='javascript'>window.open('/jsp/type/buy/Buys2.jsp?node=" + teasession._nNode + "&nexturl="+java.net.URLEncoder.encode(nu,"UTF-8")+"','_self');</script> ");

                     out.println("<script  language='javascript'>");

                     out.println("var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:1057px;dialogHeight:705px;';");
                     out.println(" var url ='/jsp/type/buy/Buys2.jsp?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(nu,"UTF-8") + "';");
                     out.println(" var rs =  window.showModalDialog(url,self,y); ");
                     out.println(" if(rs==1){window.open('" + nu + "','_self');}else if(rs==2){window.open('/jsp/type/goods/EditGoods.jsp?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(nu,"UTF-8") + "','_self');}else{window.open('" + nu + "','_self');} ");
                     out.println("</script>");



					out.flush();
					   out.close();

					 //response.sendRedirect("/jsp/type/buy/Buys2.jsp?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(nu,"UTF-8"));
                } else
                {
                    response.sendRedirect(nu);
					return;
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
