<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.member.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="jxl.*"%><%@page import="java.io.*"%>
<%@page import="java.math.BigDecimal"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

String nexturl=teasession.getParameter("nexturl");
String act=teasession.getParameter("act");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<%!
public String cellToString(Cell c)
{
	String str=c.getContents();
	if(str==null||"null".equals(str))
	{
		str=null;
	}
	return str;
}
public java.util.Date cellToDate(Cell c)
{
	String str=c.getContents();
	if(str==null||"null".equals(str))
	{
		str=null;
	}
	java.util.Date d=null;
	try
	{
		d=Entity.sdf2.parse(str);
	}catch(Exception ex)
	{
		try
		{
			d=Entity.sdf.parse(str);
		}catch(Exception ex2)
		{
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy年MM月dd日");
			try
			{
				d=sdf.parse(str);
			}catch(Exception ex3)
			{
				sdf = new java.text.SimpleDateFormat("MM/dd/yyyy");
				try
				{
					d=sdf.parse(str);
				}catch(Exception ex4)
				{

				}
			}
		}
	}
	return d;
}
%>
<%
byte by[]=teasession.getBytesParameter("file");
if(by!=null)
{
	ByteArrayInputStream bais=new ByteArrayInputStream(by);
	try
	{
		Workbook wb=Workbook.getWorkbook(bais);
		Sheet s=wb.getSheet(0);
		if(teasession.getParameter("import")!=null)
		{
			out.println("总行数:"+s.getRows()+" 正在导入:<span id=c >0</span>");
			out.flush();
            int size=s.getRows()/100;
            if(size<1)
            size=1;
            Date time=new Date();
			if("importprofile9000".equals(act))//导入商品
			{
				for(int i=1;i<s.getRows();i++)
				{
                  String goodsnumber=null;//编号
                  String barcode =null;//条形码
                  String subject=null;//商品名字
                  String goodstype=null;//商品类别
                  String brand=null; //商品品牌
                  String measure =null;// 商品单位
                  String spec =null;// 商品规格
                  String used =null;//使用类型
                  String supplier =null;//供应商
                  String minQuantity =null;//库存数量
                  String lists = null;//进货价
                  String supplys=null;//供货价格
                  String prices =null;//销售价格
                  String father=null;//商品所在位置
                  String text = null;//商品内容
					for(int j=0;j<s.getColumns();j++)
					{
						switch(j)
						{
						case 0:
							goodsnumber=cellToString(s.getCell(j,i));
							break;
						case 1:
							barcode = cellToString(s.getCell(j,i));
							break;
						case 2:
							subject=cellToString(s.getCell(j,i));
							break;
                       case 3:
							goodstype=cellToString(s.getCell(j,i));
							break;
						case 4:
							brand=cellToString(s.getCell(j,i));
							break;
						case 5:
							measure=cellToString(s.getCell(j,i));
							break;
						case 6:
							spec=cellToString(s.getCell(j,i));
							break;
						case 7:
							used=cellToString(s.getCell(j,i));
							break;
						case 8:
							supplier=cellToString(s.getCell(j,i));
							break;
                        case 9:
						   minQuantity=cellToString(s.getCell(j,i));
							break;
                        case 10:
						   lists=cellToString(s.getCell(j,i));
							break;
                       case 11:
						   supplys=cellToString(s.getCell(j,i));
							break;
                       case 12:
						   prices=cellToString(s.getCell(j,i));
							break;
                      case 13:
						   father=cellToString(s.getCell(j,i));
							break;
                     case 14:
                            text= cellToString(s.getCell(j,i));
                           break;
						}
					}


                   int fatherid = 0;
                   if(father!=null &&father.length()>0)
                   {
                      fatherid=Integer.parseInt(father.trim());
                   }
                   Node node = Node.find(fatherid);
                   int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                   int options1 = node.getOptions1();
                   long options = node.getOptions();
                   Category c = Category.find(teasession._nNode);
                   int defautllangauge = node.getDefaultLanguage();
                 //  Brand b =Brand.find(Integer.parseInt(brand));

                 String gtidstr =null;
                 //                     //判断商品类别
                 if(GoodsType.getGT(teasession._strCommunity,goodstype)!=null)
                 {
                   gtidstr=GoodsType.getGT(teasession._strCommunity,goodstype);
                 }

                     //判断品牌
                     int bsss= 0;
                    if(Brand.getBranid(teasession._strCommunity,brand)>0)
                    {
                      bsss=Brand.getBranid(teasession._strCommunity,brand);
                    }else
                    {
                      bsss=Brand.create(null,teasession._strCommunity,0,0,0,teasession._nLanguage,brand,null);
                    }
                     //使用类型
                    int  used11111=1;
                     if("卡管理使用".equals(used))
                     {
                        used11111=2;
                     }



                     //判断供货商
                     int sups = 0;

                     if(Supplier.getSuid(teasession._strCommunity,supplier)>0)
                     {
                      sups= Supplier.getSuid(teasession._strCommunity,supplier);
                     }else
                     {
                      sups= Supplier.create(teasession._strCommunity,null,null,0,null,teasession._nLanguage,supplier,null);
                     }
                       
                     //插入Node表
                        if(Node.isNumber(goodsnumber)){
                          Node nboj = Node.find(Node.getGoodsNumber2(teasession._strCommunity,goodsnumber));
                          teasession._nNode=Node.getGoodsNumber2(teasession._strCommunity,goodsnumber);
                          nboj.set(teasession._nLanguage,subject,text);
                          nboj.setNumer(goodsnumber,teasession._nNode);
                        }else
                        {
                          teasession._nNode = Node.create(fatherid,sequence,teasession._strCommunity,teasession._rv,34,(options1 & 2) != 0,options,options1,defautllangauge,null,null,new java.util.Date(),0,0,0,0,"",null,teasession._nLanguage,subject,"",null,null,"",0,null,"","","","",null,null);
                          node.finished(teasession._nNode);
                          node.setNumer(goodsnumber,teasession._nNode);
                        }
//
  
                    //插入 Goods表80466
                    Goods gobj = Goods.find(teasession._nNode);
                    gobj.set(gtidstr,bsss,null,true,0,new java.math.BigDecimal("0"),used11111,false,0,0,0,0,0,0,0,teasession._nLanguage,measure,spec,null,null,null,null);
                    gobj.setBarcode(barcode);  
                    
                    System.out.println(i+":"+subject+"--"+teasession._rv._strR+"--"+teasession._rv._strV);
//
//
//				//插入 Commodity 表 供货商的表
                   int commodity=0;
                   if(Commodity.isSupplier(sups,teasession._nNode)){
                     Commodity cobj = Commodity.find_goods(teasession._nNode);
                     cobj.set(null,null,0,0,10,0,0,sups,0,0,teasession._nNode);
                     commodity =cobj.getCommodity();
                   }else
                   {
                      commodity =Commodity.create(null,null,0,0,10,0,0,sups,0,0,teasession._nNode);
                   }

                    //(int commodity, int currency, BigDecimal supply, BigDecimal list, BigDecimal price, BigDecimal price1, BigDecimal price2, BigDecimal price3, int options,BigDecimal point, int convertcurrency)
                    BigDecimal list = new BigDecimal(lists.trim());//进货价格
                    BigDecimal supply = new BigDecimal(supplys.trim());//供货价格
                    BigDecimal price = new BigDecimal(prices.trim());//供货价格


//                    if(list!=null){}else
//                    {
//                      list = price.multiply(new java.math.BigDecimal(0.3)).setScale(2, BigDecimal.ROUND_HALF_UP);
//                    }
//                     price= price.multiply(new java.math.BigDecimal(0.5)).setScale(2, BigDecimal.ROUND_HALF_UP);
                      BuyPrice bpobj = BuyPrice.find(commodity,1);
                     if(bpobj.isExists()){
                       bpobj.set(supply, list,price,  new BigDecimal (0),  new BigDecimal (0),  new BigDecimal (0), 0, new BigDecimal (0), 0);
                     }else
                     {
                       BuyPrice.create(commodity, 1,supply, list,price,  new BigDecimal (0),  new BigDecimal (0),  new BigDecimal (0), 0, new BigDecimal (0), 0);
                     }

					if(i%size==0)
					{
						out.print("<script>c.innerHTML="+(i)+"</script>");
						out.flush();
					}
				}

			}

			out.print("<script>window.open('/jsp/info/Succeed.jsp?nexturl='+encodeURIComponent(\""+nexturl+"\"),'_parent');</script>");
		}else
		{
			out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
		//	if("importprofile9000".equals(act))
			//{
				//out.print("<tr id=tableonetr><td nowrap>序号</td><td nowrap>卡号</td><td nowrap>密码</td></tr>");
		//	}
			for(int i=0;i<s.getRows()&&i<21;i++)
			{
				out.print("<tr onMouseOver=this.bgColor='#BCD1E9' onMouseOut=this.bgColor=''>");
				for(int j=0;j<s.getColumns();j++)
				{
					String str=s.getCell(j,i).getContents();
					out.print("<td>"+("null".equals(str)?"&nbsp;":str));
				}
				out.print("</tr>");
				if(i==20)
				{
					out.print("<tr><td colspan=8>总行数为:"+s.getRows()+".   只显示前20行.......</td></tr>");
				}
			}
			out.print("</table>");
		}
		wb.close();
	}catch(Exception ex)
	{
		out.print("<table style=color:#FF0000 border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
		out.print("<tr><td>错误:  可能有以下原因导致</td></tr>");
		out.print("<tr><td>1.文件格式错误</td></tr>");
		out.print("<tr><td>2.列没有匹配,请按照预览的格式进行调整.</td></tr>");
		out.print("<tr><td>&nbsp;</td></tr>");
		out.print("<tr><td>描述:</td></tr>");
		out.print("<tr><td>"+ex.getMessage()+"</td></tr>");
		out.print("</table>");
		ex.printStackTrace();
//		response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件格式错误.","UTF-8"));
		return;
	}finally
	{
		bais.close();
	}
}
%>

</body>
</html>
