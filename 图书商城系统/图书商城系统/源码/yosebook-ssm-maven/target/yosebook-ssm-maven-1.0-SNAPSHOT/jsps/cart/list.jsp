<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>购物车</title>

<script src="<c:url value='/jquery/jquery-1.5.1.js'/>"></script>
<script src="<c:url value='/js/round.js'/>"></script>
<link rel="stylesheet" type="text/css"
    href="<c:url value='/jsps/css/cart/list.css'/>">
<script type="text/javascript">
	
	$(function(){
		showTotal();
		//给全选添加click事件
		$("#selectAll").click(function(){
			//获取全选的状态
			var bool = $("#selectAll").attr("checked");
			setItemCheckbox(bool);
			setJiesuan(bool);
			showTotal();
		});
		/*给所有条目的复选框添加click事件*/
		$(":checkbox[name=checkboxBtn]").click(function(){
			var all = $(":checkbox[name=checkboxBtn]").length;
			var select = $(":checkbox[name=checkboxBtn][checked=true]").length;
			if(all==select){
				$("#selectAll").attr("checked",true);
				setJiesuan(true);
			}else if(select == 0){
				$("#selectAll").attr("checked",false);
				setJiesuan(false);
			}else{
				$("#selectAll").attr("checked",false);
				setJiesuan(true);
			}
			showTotal();
		});
		
		$(".jian").click(function(){
			var id = $(this).attr("id").substring(0,32);
			var quantity = $("#"+id+"Quantity").val();
			if(quantity==1){
				if(confirm("您是否真要删除该条目？")){
					location = "/yosebook-ssm-maven/cartItem/batchDelete.do?cartItemIds="+id;
				}
			}else{
				sendUpdateQuantity(id,Number(quantity)-1);
			}
		});
		$(".jia").click(function(){
			var id = $(this).attr("id").substring(0,32);
			var quantity = $("#"+id+"Quantity").val();
			sendUpdateQuantity(id,Number(quantity)+1);
		}); 
	});
	
	function sendUpdateQuantity(id,quantity){
		$.ajax({
			async:false,
			cache:false,
			url:"/yosebook-ssm-maven/cartItem/updateQuantity.do",
			data:{cartItemId:id,quantity:quantity},
			type:"POST",
			dataType:"json",
			success:function(result){
				$("#"+id+"Quantity").val(result.quantity);
				$("#"+id+"Subtotal").text(result.subtotal);
				showTotal();
			}
		});
	}
	/*
	 * 计算总计
	 */
	 function showTotal() {
			var total = 0;
			/*
			1. 获取所有的被勾选的条目复选框！循环遍历之
			*/
			$(":checkbox[name=checkboxBtn][checked=true]").each(function() {
				//2. 获取复选框的值，即其他元素的前缀
				var id = $(this).val();
				//3. 再通过前缀找到小计元素，获取其文本
				var text = $("#" + id + "Subtotal").text();
				//4. 累加计算
				total += Number(text);
			});
			// 5. 把总计显示在总计元素上
			$("#total").text(round(total, 2));//round()函数的作用是把total保留2位
		}
	/*
		统一设置所有的复选按钮
	*/
	function setItemCheckbox(bool){
		$(":checkbox[name=checkboxBtn]").attr("checked",bool);
	}
	/*设置结算按钮样式*/
	function setJiesuan(bool){
		if(bool){
			$("#jiesuan").removeClass("kill").addClass("jiesuan");
			$("#jiesuan").unbind("click");//撤销当前元素所有的click事件
		}else{
			$("#jiesuan").removeClass("jiesuan").addClass("kill");
			$("#jiesuan").click(function(){
				return false;
			});
		}
	}
	/*批量删除*/
	function batchDelete(){
		var cartItemIdArray = new Array();
		$(":checkbox[name=checkboxBtn][checked=true]").each(function(){
			cartItemIdArray.push($(this).val());
		});
		location="/yosebook-ssm-maven/cartItem/batchDelete.do?cartItemIds="+cartItemIdArray.toString();
	}
	/*结算方法*/
	function jiesuan(){
		var cartItemIdArray = new Array();
		$(":checkbox[name=checkboxBtn][checked=true]").each(function() {
			cartItemIdArray.push($(this).val());//把被选中的条目放到数组中
		});
		//把数组变成字符串添加到hidden中
		$("#cartItemIds").val(cartItemIdArray.toString());
		//把总计的值保存到表中
		$("#hiddenTotal").val($("#total").text());
		//提交表单
		$("#jiesuanform").submit();
	}
</script>
</head>
<body>
<c:choose>
    <c:when test="${empty cartItemList }">
        <table width="95%" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td align="right"><img align="top"
                    src="<c:url value='/images/icon_empty.png'/>" /></td>
                <td><span class="spanEmpty">您的购物车中暂时没有商品</span></td>
            </tr>
        </table>
    </c:when>
    <c:otherwise>
    <table width="95%" align="center" cellpadding="0" cellspacing="0">
        <tr align="center" bgcolor="#efeae5">
            <td align="left" width="50px">
            <input type="checkbox"
                id="selectAll" checked="checked" /><label
                for="selectAll">全选</label></td>
            <td colspan="2">商品名称</td>
            <td>单价</td>
            <td>数量</td>
            <td>小计</td>
            <td>操作</td>
        </tr>
     <c:forEach items="${cartItemList }" var="cartItem">
        <tr align="center">
            <td align="left">
                <input value="${cartItem.cartItemId }" type="checkbox" name="checkboxBtn" checked="checked" />
            </td>
            <td align="left" width="70px">
                <a class="linkImage" href="<c:url value='/book/load.do?bid=${cartItem.book.bid }'/>">
                    <img border="0" width="54" align="top" src="<c:url value='/${cartItem.book.image_b }'/>" />
                </a>
            </td>
            <td align="left" width="400px"><a
                href="<c:url value='/book/load.do?bid=${cartItem.book.bid }'/>"><span>${cartItem.book.bname }</span></a></td>
            <td>
                <span>&yen;<span class="currPrice">${cartItem.book.currPrice }</span></span>
            </td>
            <td>
                <input class="jian" type="button" value="-" id="${cartItem.cartItemId }Jian"><input class="quantity" readonly="readonly" id="${cartItem.cartItemId }Quantity"
                type="text" value="${cartItem.quantity }" /><input class="jia" type="button" value="+" id="${cartItem.cartItemId }Jia">
            </td>
            <td width="100px">
                <span class="price_n">
                &yen;<span class="subTotal" id="${cartItem.cartItemId }Subtotal">${cartItem.subtotal }</span>
                </span>
            </td>
            <td>
                <a href="<c:url value='/cartItem/batchDelete.do?cartItemIds=${cartItem.cartItemId }'/>">删除</a>
            </td>
        </tr>
     </c:forEach>       
        <tr>
            <td colspan="4" class="tdBatchDelete"><a
                href="javascript:batchDelete();">批量删除</a></td>
            <td colspan="3" align="right" class="tdTotal"><span>总计：</span><span
                class="price_t">&yen;<span id="total"></span></span></td>
        </tr>
        <tr>
            <td colspan="7" align="right">
                <a href="javascript:jiesuan();" id="jiesuan" class="jiesuan">结    算</a>
            </td>
        </tr>
    </table>
    <form id="jiesuanform" action="<c:url value='/cartItem/loadCartItems.do'/>"
        method="post">
        <input type="hidden" name="cartItemIds" id="cartItemIds" />
        <input type="hidden" name="total" value="" id="hiddenTotal"/>
    </form>
      </c:otherwise>
</c:choose>  
</body>
</html>
