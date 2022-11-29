


//////////////////////////////////////////-------------销售单--------------------------------////////////////////////////////////////
//给商品细节表添加记录销售单
function gd_ajax(igd,t)
{
  sendx("/jsp/erp/Goods_ajax.jsp?type="+t+"&discount=5&act=gDetailspai&node="+igd+"&purchase="+form1.purchase.value,
  function(data)
  {
    if(data!=''&&data.length>1)
    {
      alert(data);
      return false;
    }
    l_ajax();
  }
  );
}
//选择商品中的ajax
function l_ajax(){
  sendx("/jsp/erp/paidinfull_ajax.jsp?act=EditPurchase&purid="+form1.purchase.value,
  function(data)
  {
    document.getElementById('show').innerHTML=data;
    f_show(form1.supplnamehidden.value,form1.purchase.value);
  }
  );

}

//ajax文件中的js方法
function f_quantity(igd2,igd3,floor,dis,f,gdid)
{

  var supply   =  document.all('supply'+igd2).value;        //<!--销售单价-->

  var discount =  document.all('discount'+igd2).value*0.1;  // <!--折扣-->
  var dsupply  =  document.all('dsupply'+igd2).value;       //<!--折后单价-->
  var quantity =  document.all('quantity'+igd2).value;      //数量quantity1获取的单个商品的数量
  var total_i    =  document.all('total'+igd2).value;         ///金额total1  <!--折扣乘以数量的价格总计-->
  var discount2 = document.all('discount2'+igd2).value;//商品打折


	   //判断输入的数量不能大于库存数量
//	   sendx("/jsp/erp/Goods_ajax.jsp?act=co_ajaxInventory&warid="+form1.waridname.value+"&gdid="+gdid,
//			  function(data){

//					 if(quantity>parseInt(data.trim()))
//					 {
//						 alert('您输入的销售商品数量大于了库存');
//						 document.all('quantity'+igd2).value = data.trim();
//						 document.all('quantity'+igd2).focus();
//						 quantity=data.trim();
//					 }
					 //如果不大于
					 if(f=='true'&&quantity*supply*discount>floor)
					 {
						 dsupply= supply*discount*dis*0.1;
						 total_i=quantity*supply*discount*dis*0.1;
						 discount2=dis*1;
					 }
					 else
					 {
						 dsupply= supply*discount;
						 total_i=quantity*supply*discount;
						 discount2="10";
					 }

					 document.all('dsupply'+igd2).value=(dsupply).toFixed(2);
					 document.all('total'+igd2).value=(total_i).toFixed(2);//打完折后的商品金额：显示的金额折后的获取的单个商品的 “数量乘以单价乘以” 打折数值 的金额
					 document.all('discount2'+igd2).value=discount2;
					 	   //修改商品中的供货价
					 sendx("/jsp/erp/Goods_ajax.jsp?act=Paidinfull&supply="+supply+"&quantity="+quantity+"&gdid="+gdid+"&discount="+document.all('discount'+igd2).value+"&dsupply="+dsupply+"&total_i="+total_i+"&discount2="+discount2,
					 function(data){f_total_2();});

					 var cs=0;
					 var cs2=0;
					 var ct2=0;
					 var cdz=0;

					 for(var i = 1;i<=igd3;i++)
					 {
						 var s = document.all('supply'+i).value;
						 var t = document.all('total'+i).value;//单个商品的价格
						 var s1q = document.all('quantity'+i).value; //单个商品的数量
						 var a = s*s1q;
						 cs =  parseInt(s1q)+parseInt(cs);//数量合计
						 cs2=  parseFloat(s)+parseFloat(cs2);//折前金额总计
						 cdz =  parseFloat(t)+parseFloat(cdz);//折后金额总计
					 }
					 document.form1.quantity.value=cs;//数量
					 document.form1.total.value=cs2.toFixed(2);//总计
					 document.form1.total_2.value=cdz.toFixed(2);//总计
}
//删除一个商品
function f_delete(igd)
{
  sendx("/jsp/erp/Goods_ajax.jsp?act=Gdelete&gdid="+igd,
  function(data)
  {
    if(data!=''&&data.length>0){
      alert(data);
      l_ajax();
    }
  }
  );
}
//修改备注文字
function f_rem(gdid,i)
{
  var remarksarr = document.all('remarksarr'+i).value;
  sendx("/jsp/erp/Goods_ajax.jsp?act=remarksarr&gdid="+gdid+"&remarksarr="+encodeURIComponent(remarksarr),
  function(data){}
  );
}

//选择价格
function f_jg(nid,igd,igd2,igd3,igd4,igd5)
{
  var rs = window.showModalDialog('/jsp/erp/Price.jsp?nodeid='+nid,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;scroll:1;dialogWidth:380px;dialogHeight:315px;');
  var c1 = igd2.split("/");

  if(rs!=null)
  {
    document.all('supply'+igd).value=rs;//选择的价格
    f_quantity(igd,igd2,igd3,igd4,igd5);
  }
}

//选择联系人 可以得到联系电话和地址
function f_member2()
{
  var a =form1.member2.value;
  if(a.split("/")[2]!=null){
    form1.telephone.value=a.split("/")[2];
  }
  if(a.split("/")[3]!=null){
    form1.address.value =a.split("/")[3];
  }
}
//显示下面的余额提示
function f_total_2()
{
  f_show(form1.supplnamehidden.value,form1.purchase.value);
}
function f_show(suppid,purchase)
{
  sendx('/jsp/erp/Goods_ajax.jsp?act=f_show&suppid='+suppid+'&purchase='+purchase,
  function(data)
  {
    document.getElementById('f_shows').innerHTML=data;
  }
  );
}


////////////////////////////--------------采购单----------------------------///////////////////

function f_xuanze_pur()
{
		if(form1.supplname.value==0)
				 {
				   alert('请选择供货商!');
				   form1.supplname.focus();
				   return false;
				 }
  var rs = window.showModalDialog('/jsp/erp/Goods.jsp?supplname='+form1.supplname.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
  if(rs!=null){
    gd_ajax_pur(rs);
  }
}


//给商品细节表添加记录
function gd_ajax_pur(igd)
{
  sendx("/jsp/erp/Goods_ajax.jsp?act=gDetails&supplname="+form1.supplname.value+"&type=2&node="+igd+"&purchase="+form1.purchase.value,
  function(data)
  {
    if(data!=''&&data.length>1)
    {
      alert(data);
      return false;
    }
    l_ajax_pur();
  }
  );
}
//选择商品中的ajax
function l_ajax_pur(){
var s ='purch_ajax2.jsp';
if(form1.flowtype.value==3)
{
	   s ='purch_ajax3.jsp';
} 

  sendx("/jsp/erp/"+s+"?act=EditPurchase&type=2&flowtype="+form1.flowtype.value+"&purid="+form1.purchase.value,
  function(data)
  {
    document.getElementById('show').innerHTML=data;
  }
  );
}
//选择不同的供货商
function f_supp()
{
	   if(window.document.getElementById('quantity')!=null){
			  if(confirm('此次调换供货商,系统将删除上次的商品,您确定调换供货商?')){
					   sendx("/jsp/erp/Goods_ajax.jsp?act=GoodsSupp&purchase="+form1.purchase.value,
					   function(data)
					   {
						 l_ajax_pur();
					   }
					   );
			  }
	   }
}
//删除一个商品
function f_delete_pur(igd)
{
  sendx("/jsp/erp/Goods_ajax.jsp?act=Gdelete&gdid="+igd,
  function(data)
  {
    if(data!=''&&data.length>0){
      alert(data);
      l_ajax_pur();
    }
  }
  );
}

//purch_ajax.jsp 中的方法
function f_quantity_pur(igd,igd2,igd3,ftype)
{

  var c1 = igd3.split("/");
  var supply   =  document.all('supply'+igd2).value;        //<!--销售单价-->

  var quantity =  document.all('quantity'+igd2).value;      //数量quantity1获取的单个商品的数量
  var total_i    =  document.all('total'+igd2).value;         ///金额total1  <!--折扣乘以数量的价格总计-->
//  alert(quantity>document.all('quantity22'+igd2).value);
 if(ftype==2)//实际数量不能大于采购数量
 {

	   if(Number(quantity)>Number(document.all('quantity22'+igd2).value))
	   {
			  alert('实际数量不能大于采购数量');
			  document.all('quantity'+igd2).value=document.all('quantity22'+igd2).value;
			  document.all('quantity'+igd2).focus();
			  return false;
	   }
 }
  //修改商品中的供货价
  sendx("/jsp/erp/Goods_ajax.jsp?act=List&nodeid="+c1[igd2]+"&list="+supply+"&quantity="+quantity+"&gdid="+igd,
  function(data){}
  );
  document.all('total'+igd2).value=quantity*supply;//显示的金额
  //显示的 数量
  //alert(document.form1.elements(s1).value);
  var cs=0;
  var cs2=0;
  for(var i = 1;i<c1.length-1;i++)
  {
    cs =  parseInt(document.all('quantity'+i).value)+parseInt(cs);//数量
    cs2=  parseFloat(document.all('total'+i).value)+parseFloat(cs2);//总计
    // alert( document.form1.elements('total'+i).value+cs2);
  }

  document.form1.quantity.value=cs;//数量
  document.form1.total.value=cs2;//总计
}
//部分到货方法
function f_quantity2(igd,igd2,igd3,ftype)
{


  var supply   =  document.all('supply'+igd2).value;        //<!--销售单价-->

  var quantitys =  document.all('quantity'+igd2).value;      //数量quantity1获取的单个商品的数量
   var quantity2 =  document.all('quantity2'+igd2).value;      //剩余数量
  var total_i    =  document.all('total'+igd2).value;         ///金额total1  <!--折扣乘以数量的价格总计-->


			  if(Number(quantity2)>Number(document.all('quantity22'+igd2).value)-Number(quantitys))
			  {
					 alert('您输入的剩余数量太大了');
					document.all('quantity2'+igd2).value=Number(document.all('quantity22'+igd2).value)-Number(quantitys);
					 document.all('quantity2'+igd2).focus();
					 return false;
			  }

  document.all('total'+igd2).value=quantity2*supply;//显示的金额

  var cs=0;
  var cs2=0;
  for(var i = 1;i<=igd3;i++)
  {
    cs =  parseInt(document.all('quantity2'+i).value)+parseInt(cs);//数量
    cs2=  parseFloat(document.all('total'+i).value)+parseFloat(cs2);//总计
  }

  document.form1.quantity.value=cs;//数量
  document.form1.total.value=cs2;//总计
}


////////////////////////////--------------总部退货单----------------------------///////////////////


        function f_xuanze_rg(purchaseid)
        {
          if(form1.waridname.value==0)
          {
            alert("请先选择仓库!");
            form1.waridname.focus();
            return false;
          }
          var rs = window.showModalDialog('/jsp/erp/rgGoods.jsp?purid='+purchaseid+'&waridname='+form1.waridname.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:655px;');
          if(rs!=null){
            gd_ajax_rg(rs.split("/")[1],rs.split("/")[2]);
          }
        }
 //给商品细节表添加记录
        function gd_ajax_rg(igd,purid12333232321)
        {
          sendx("/jsp/erp/Goods_ajax.jsp?act=gDetails&type=3&node="+igd+"&purchase="+form1.purchase.value+"&purid12333232321="+purid12333232321,
          function(data)
          {
            if(data!=''&&data.length>1)
            {
              alert(data);
              return false;
            }
            l_ajax_rg();
          }
          );
        }


         //选择商品中的ajax
       function l_ajax_rg(){
         sendx("/jsp/erp/rg_ajax.jsp?act=EditPurchase&type=3&purid="+form1.purchase.value,
         function(data)
         {
           document.getElementById('show').innerHTML=data;
         }
         );
       }



 //中的方法
  function f_quantity_rg(igd,igd2,igd3)
  {
    var supply   =  document.all('supply'+igd2).value;        //<!--销售单价-->
    var quantity =  document.all('quantity'+igd2).value;      //数量quantity1获取的单个商品的数量
    var total_i    =  document.all('total'+igd2).value;         ///金额total1  <!--折扣乘以数量的价格总计-->

	   //判断如果报损数量小于输入数量 则显示库存
   //  //修改剩余数量
		 sendx("/jsp/erp/Goods_ajax.jsp?act=co_ajaxInventory&warid="+form1.waridname.value+"&gdid="+igd,
				function(data){

					 if(quantity>parseInt(data.trim()))
					 {
							alert('您输入的退货数量大于了库存');
							document.all('quantity'+igd2).value = data.trim();
							document.all('quantity'+igd2).focus();
							quantity=data.trim();
					 }
					     //  //修改剩余数量
					sendx("/jsp/erp/Goods_ajax.jsp?act=distri_ajax&quantity="+quantity+"&list="+total_i+"&gdid="+igd,
					function(data){
						document.all('total'+igd2).value=quantity*supply;//显示的金额

						 var cs=0;
						 var cs2=0;
						 for(var i = 1;i<=igd3;i++)
						 {
						   cs =  parseInt(document.all('quantity'+i).value)+parseInt(cs);//数量
						   cs2=  parseFloat(document.all('total'+i).value)+parseFloat(cs2);//总计

						 }
						 document.form1.quantity.value=cs;//数量
						 document.form1.total.value=cs2;//总计

					 }
					);
			  }
	   );







  }

//删除一个商品
function f_delete_rg(igd)
{
  sendx("/jsp/erp/Goods_ajax.jsp?act=Gdelete&gdid="+igd,
  function(data)
  {
    if(data!=''&&data.length>0){
      alert(data);
      l_ajax_rg();
    }
  }
  );
}

/////////////////////////////////////////////////////////------------------------调拨单--------------------------//////////////////////////////////////////////////////////////////

function f_xuanze_co()
{
  if(form1.supplname.value==0)
  {
    alert('请选择调出仓库!');
    form1.supplname.focus();
    return false;
  }
  if(form1.waridname.value==0)
  {
    alert('请选择调入仓库!');
    form1.waridname.focus();
    return false;
  }
  var rs = window.showModalDialog('/jsp/erp/CalloutGoods2.jsp?waridname='+form1.supplname.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
  if(rs!=null){
    gd_ajax_co(rs);
  }
}
//给商品细节表添加记录
function gd_ajax_co(igd)
{
  sendx("/jsp/erp/Goods_ajax.jsp?act=gDetails&type=4&node="+igd+"&purchase="+form1.purchase.value,
  function(data)
  {
    if(data!=''&&data.length>1)
    {
      alert(data);
      return false;
    }
    l_ajax_co();
  }
  );
}

//选择商品中的ajax
function l_ajax_co(){
  sendx("/jsp/erp/co_ajax.jsp?type=4&purid="+form1.purchase.value,
  function(data)
  {
    document.getElementById('show').innerHTML=data;
  }
  );
}
//purch_ajax.jsp 中的方法
function f_quantity_co(igd,igd2,igd3)
{

  var supply   =  document.all('supply'+igd2).value;        //<!--销售单价-->
  var quantity =  document.all('quantity'+igd2).value;      //数量quantity1获取的单个商品的数量
  var total_i    =  document.all('total'+igd2).value;         ///金额total1  <!--折扣乘以数量的价格总计-->

  //判断如果调拨数量小于输入数量 则显示库存
   //  //修改剩余数量
  sendx("/jsp/erp/Goods_ajax.jsp?act=co_ajaxInventory&warid="+form1.supplname.value+"&gdid="+igd,
  function(data){
	   if(quantity>parseInt(data.trim()))
	   {
	          alert('您输入的调货数量大于了库存');
			  document.all('quantity'+igd2).value = data.trim();
			  document.all('quantity'+igd2).focus();
			  quantity=data.trim();

	   }
	     //  //修改剩余数量
  sendx("/jsp/erp/Goods_ajax.jsp?act=co_ajax&quantity="+quantity+"&gdid="+igd,
  function(data){
	   //alert(data);
	    document.all('total'+igd2).value=data.trim();//显示的金额
			   var cs=0;
		 var cs2=0;
		 for(var i = 1;i<=igd3;i++)
		 {
		   cs =  parseInt(document.all('quantity'+i).value)+parseInt(cs);//数量
		   cs2=  parseFloat(document.all('total'+i).value)+parseFloat(cs2);//总计

		 }

		 document.form1.quantity.value=cs;//数量
		 document.form1.total.value=cs2;//总计
   }
  );
   }
  );


}
 //删除一个商品
function f_delete_co(igd)
{
  sendx("/jsp/erp/Goods_ajax.jsp?act=Gdelete&gdid="+igd,
  function(data)
  {

    if(data!=''&&data.length>0){
      alert(data);
      l_ajax_co();
    }
  }
  );
}


/////////////////////////////////---------报损单--------//////////////////////////////////////////////////

function f_xuanze_loss()
{
  if(form1.waridname.value==0)
  {
    alert("请先选择报损仓库!");
    form1.waridname.focus();
    return false;
  }
  var rs = window.showModalDialog('/jsp/erp/CalloutGoods2.jsp?act=bs&supplname='+form1.supplname.value+'&waridname='+form1.waridname.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
  if(rs!=null){
    gd_ajax_loss(rs);
  }
}
//给商品细节表添加记录
function gd_ajax_loss(igd)
{
  sendx("/jsp/erp/Goods_ajax.jsp?&supplname="+form1.supplname.value+"&act=gDetails&type=5&node="+igd+"&purchase="+form1.purchase.value,
  function(data)
  {
    if(data!=''&&data.length>1)
    {
      alert(data);
      return false;
    }
    l_ajax_loss();
  }
  );
}
//选择商品中的ajax
function l_ajax_loss(){
  sendx("/jsp/erp/loss_ajax.jsp?type=5&purid="+form1.purchase.value,
  function(data)
  {
    document.getElementById('show').innerHTML=data;
  }
  );
}
//purch_ajax.jsp 中的方法
function f_quantity_loss(igd,igd2,igd3)
{

  var supply   =  document.all('supply'+igd2).value;        //<!--销售单价-->
  var quantity =  document.all('quantity'+igd2).value;      //数量quantity1获取的单个商品的数量
  var total_i    =  document.all('total'+igd2).value;         ///金额total1  <!--折扣乘以数量的价格总计-->

  //判断如果报损数量小于输入数量 则显示库存
   //  //修改剩余数量
  sendx("/jsp/erp/Goods_ajax.jsp?act=co_ajaxInventory&warid="+form1.waridname.value+"&gdid="+igd,
		 function(data){
			  if(quantity>parseInt(data.trim()))
			  {
					  alert('您输入的报损数量大于了库存');
					  document.all('quantity'+igd2).value = data.trim();
					  document.all('quantity'+igd2).focus();
					  quantity=data.trim();
			  }
				//  //修改剩余数量
			  sendx("/jsp/erp/Goods_ajax.jsp?act=co_ajax&quantity="+quantity+"&gdid="+igd,
					 function(data){
							//alert(data);
							 document.all('total'+igd2).value=data.trim();//显示的金额
							 var cs=0;
							 var cs2=0;
							 for(var i = 1;i<=igd3;i++)
							 {
								cs =  parseInt(document.all('quantity'+i).value)+parseInt(cs);//数量
								cs2=  parseFloat(document.all('total'+i).value)+parseFloat(cs2);//总计
							 }
							 document.form1.quantity.value=cs;//数量
							 document.form1.total.value=cs2;//总计
						}
			   );
		  }//function(data){
  );
}

 //删除一个商品
function f_delete_loss(igd)
{
  sendx("/jsp/erp/Goods_ajax.jsp?act=Gdelete&gdid="+igd,
  function(data)
  {

    if(data!=''&&data.length>0){
      alert(data);
      l_ajax_loss();
    }
  }
  );
}
//////////////////////////////----------------加盟店退货给总部------------------///////////////////////////////////

   function f_xuanze_rs(purchaseid)
    {

      var rs = window.showModalDialog('/jsp/erp/rsGoods.jsp?supplnamehidden='+form1.supplnamehidden.value+'&purid='+purchaseid,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:655px;');
        if(rs!=null){
         gd_ajax_rs(rs.split("/")[1],rs.split("/")[2]);
        }
      }
		  //给商品细节表添加记录
       function gd_ajax_rs(igd,purid12333232321)
       {
         sendx("/jsp/erp/Goods_ajax.jsp?act=gDetails&type=1&node="+igd+"&purchase="+form1.purchase.value+"&purid12333232321="+purid12333232321,
         function(data)
         {
           if(data!=''&&data.length>1)
           {
             alert(data);
           }
           l_ajax_rs();
         }
         );
       }

       //选择商品中的ajax
       function l_ajax_rs(){
         sendx("/jsp/erp/purch_ajax.jsp?act=EditPurchase&purid="+form1.purchase.value+"&refundtype="+form1.refundtype.value,
         function(data)
         {
           document.getElementById('show').innerHTML=data;
         }
         );
       }
	     //删除一个商品
        function f_delete_rs(igd)
        {
          sendx("/jsp/erp/Goods_ajax.jsp?act=Gdelete&gdid="+igd,
          function(data)
          {
            if(data!=''&&data.length>0){
              alert(data);
              l_ajax_rs();
            }
          }
          );
        }
		// 选择存放仓库
		   function f_w(igd)
			{
			   form1.w.value= document.all('waridname'+igd).value;
			}


