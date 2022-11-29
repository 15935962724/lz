<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="tea.entity.Attch" %>
<%@page import="tea.entity.yl.shop.ImportExcel" %>
<%@page import="tea.entity.Http" %>
<%@page import="org.json.JSONObject" %>
<%@page import="org.json.JSONArray" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.io.File" %>
<%@page import="org.apache.poi.ss.usermodel.Row" %>
<%@page import="org.json.JSONObject" %>
<%@ page import="java.util.Map" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.yl.shop.ProductStock" %>
<%@ page import="tea.entity.yl.shop.JihuoCode" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }

    String currentProjectName = request.getRealPath("/");//获取当前项目名称

    System.out.println("===" + currentProjectName);

    int attchid = h.getInt("attchid");
    Attch attch = Attch.find(attchid);
//String filepath = "D:\\res\\test.xls";
    String filepath = currentProjectName + attch.path;

    ImportExcel ei = new ImportExcel(filepath, 0);
    JSONArray ja = new JSONArray();

    //System.out.println(ei.getDataRowNum()+"---"+ei.getLastDataRowNum()+"=="+ei.getLastCellNum()+"obj="+ei);


%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/jquery-1.11.1.min.js"></script>
<script src="/tea/yl/top.js"></script>
</head>
<body>
<div style='margin-top: 10px;'></div>

<form name="form1" action="?">
    <input type="hidden" name="community" value="<%=h.community%>"/>
</form>
    <%
	List<String> titlelist = new ArrayList();//标题

try{
	String mystr = "";
	int index =1 ;
	boolean itemflag = true;
	
	
	int itemcount = 0;
			for (int i = ei.getDataRowNum(); i <= 0; i++) {
				Row row = ei.getRow(i);
				JSONObject json = new JSONObject();
				for (int j = 0; j < ei.getLastCellNum(); j++) {
					Object val = ei.getCellValue(row, j);
					titlelist.add(val.toString());
				}
			}
}catch(Exception e){
	out.print("<script>layer.alert('请检查数据正确性！', {closeBtn: 0}, function(){parent.mtDiag.close();});</script>");
	return;
}
%>

<form name="form2" id="form2" action="/ShopHospitals.do" action="/" method="post">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act"/>

    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr>
                <td colspan='20'><span>列表<%= ei.getLastDataRowNum() %></span></td>
            </tr>
            </thead>
            <tr>
                <th>序号</th>
                <%
                    for (int i = 1; i < titlelist.size(); i++) {
                        out.print("<th>" + titlelist.get(i) + "</th>");
                    }
                %>
            </tr>

            <%
                int count = 0;
                if (ei.getLastDataRowNum() == 0) {
                    out.print("<tr><td colspan='100' class='noCont'>暂无记录!</td></tr>");
                } else {
                    for (int i = ei.getDataRowNum() + 1; i <= ei.getLastDataRowNum(); i++) {
                        Row row = ei.getRow(i);
                        JSONObject json = new JSONObject();

                        Object val1 = ei.getCellValue(row, 0);
                        if (MT.f(val1.toString()).length() == 0) {
                            continue;
                        }
                        out.print("<tr>");
                        out.print("<td>" + i + "</td>");
                        for (int j = 1; j < ei.getLastCellNum(); j++) {
                            if (j == 5||j==4) {
                                continue;
                            }
                            Object val = ei.getCellValue(row, j);
                            //System.out.println("i="+i+"，j="+j+"=="+val);
                            //out.print("<td ><input name='obj"+i+"-"+j+"' value='"+val+"' /></td>");


                            if (j > 1) {
                                if (j == 2) {
                                    String opstr = "";
                                    for (String key : JihuoCode.jtype.keySet()) {
                                        opstr += "<option value='" + JihuoCode.jtype.get(key) + "' " + (MT.f(val.toString()).indexOf(key) != -1 ? "selected='selected'" : "") + " >" + key + "</option>";
                                    }
                                    out.print("<td><select name=" + JihuoCode.JihuoCodeField[j] + " onchange=typeok(this)>" + opstr + "</select></td>");
                                } else if (j == 3) {
                                    out.print("<td><select name=" + JihuoCode.JihuoCodeField[j] + "></select></td>");
                                } else {
                                    out.print("<td style='position: relative;'  for='" + JihuoCode.JihuoCodeField[j] + "' ><input id='" + JihuoCode.JihuoCodeField[j] + i + j + "' name='" + JihuoCode.JihuoCodeField[j] + "'  value='" + val + "' /></td>");
                                }

                            } else {
                                out.print("<td style='position: relative;'  for='" + JihuoCode.JihuoCodeField[j] + "' ><input id='" + JihuoCode.JihuoCodeField[j] + i + j + "' name='" + JihuoCode.JihuoCodeField[j] + "'  value='" + val + "' /></td>");
                            }
                            count++;
                        }
                        out.print("</tr>");
                    }

                    out.print("<script>");
                    out.print("var validator2 = $('#form2').validate({");
                    out.print("rules: {");
                    //out.print("obj11: { required: true }");
                    for (int i = ei.getDataRowNum() + 1; i <= ei.getLastDataRowNum(); i++) {
                        for (int j = 1; j < ei.getLastCellNum(); j++) {

                            if (i == 1 && j == 1) {

                            } else {
                                out.print(",");
                            }
                            out.print(ShopHospital.ShopHospitalField[j] + ": {");
                            out.print("required: ");
                            if (j != 2 && j != 3 && j != 4) {
                                out.print("true");
                            } else {
                                out.print("false");
                            }
                            out.print("}");

                        }
                    }

                    out.print("},");
                    out.print("submitHandler: function(form) {");
                    out.print("mysub();");
                    //out.print("form2.submit();");
//out.print("console.log('123');");
                    out.print("}});");
                    out.print("</script>");
                }
                if (count == 0 && ei.getLastDataRowNum() != 0) {
                    out.print("<tr><td colspan='100' class='noCont'>暂无记录!</td></tr>");
                }
//System.out.println(ei.getLastDataRowNum()+"=="+ei.getDataRowNum());
            %>
        </table>
    </div>
    <span><input type="submit"/></span>
</form>

<script>
    function mysub() {
        //console.log(123);
        alert("1");
        fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=editJihuoCode", $("#form2").serialize(), function (data) {
            if (data.type > 0) {

                mtDiag.close();
                mtDiag.show(data.mes);
                return;
            } else {
                mtDiag.show('操作成功！', "alert", null, function (index) {
                    parent.location.reload();
                    parent.mtDiag.close();
                });
            }
        });
    }

    function typeok(obj) {

        var mysel = $(obj).parent().parent().find("[name='type_child']");

       /* console.log($(obj).value());*/
        var index = obj.selectedIndex;
        var text = obj.options[index].text;
        var value = obj.options[index].value;
        fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=type_child", {id: value}, function (data) {
            if (data.type > 0) {

            } else {

                var ids = data.id.toString();
                var names = data.name.toString();

                var id = ids.split(",");
                var name = names.split(",");
                for (y = 0; y < id.length; y++) {
                    var tamp = '<option value=\"';
                    for (j = 0; j < id.length; j++) {
                        tamp += id[y];
                        break;
                    }
                    tamp += '\">';
                    for (i = 0; i < name.length; i++) {
                        tamp += name[y];
                        break;
                    }
                    tamp += '</option>';
                    if (y == 0) {
                        mysel.html(tamp);
                    } else {
                        mysel.append(tamp);
                    }

                }
            }
        });


    }
</script>
<body>
<html>
