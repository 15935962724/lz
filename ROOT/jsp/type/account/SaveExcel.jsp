<%@include file="/jsp/Header.jsp"%>

<%@page import="jxl.Workbook"%><%@page import="jxl.write.*"%>
<%//response.setContentType("application/ms-excel;charset=GB2312");
//response.setHeader("Content-disposition","attachment; filename=data.xls");
        Vector v_stock;
        int c_stock;
        WritableWorkbook wwb;
        WritableSheet ws;
        v_stock = null;
        c_stock = 0;
        String picture1 = getServletContext().getRealPath("/tea/Application.xls");
        wwb = Workbook.createWorkbook(new File(picture1));
        ws = wwb.createSheet("Test Sheet 1", 0);
%>

