<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Http" %>
<%@page import="tea.entity.MT" %>
<%@page import="tea.entity.member.Profile" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="tea.entity.Database" %>
<%@ page import="tea.entity.yl.shop.Question" %>
<%@ page import="tea.entity.yl.shop.Agreed" %>
<%@ page import="tea.entity.yl.shop.ProcurementUnitJoin" %>
<%@ page import="java.util.List" %>
<%@ page import="IceInternal.Ex" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="tea.entity.Filex" %>
<%

    Http h = new Http(request, response);

    ArrayList<ShopHospital> shopHospitals = ShopHospital.find(" AND addflag=1 ", 0, Integer.MAX_VALUE);

    for (int i = 0; i <shopHospitals.size() ; i++) {
        ShopHospital hospital = shopHospitals.get(i);
        int id = hospital.getId();
        int count = Profile.count(" AND hospitals like '%" + id + "%'");
        if(count==0){
            Filex.logs("error_hos.txt ","医院："+hospital.getName()+"  id："+hospital.getId());
        }
    }

%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<!-- <script src="/tea/jquery.js" type="text/javascript"></script> -->
<script src="/tea/yl/top.js"></script>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src='/tea/laydate-master/laydate.dev.js'></script>
<script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>
<body>
</body>
</html>
