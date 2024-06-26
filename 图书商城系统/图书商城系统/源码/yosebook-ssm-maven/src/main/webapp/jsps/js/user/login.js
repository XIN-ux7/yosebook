$(function() {

	/*
	 *  输入框得到焦点时隐藏错误信息
	 */
	$(".input").focus(function() {
		var inputName = $(this).attr("name");
		$("#" + inputName + "Error").css("display", "none");
	});
	
	/*
	 * 输入框推动焦点时进行校验
	 */
	$(".input").blur(function() {
		var inputName = $(this).attr("name");
		invokeValidateFunction(inputName);
	})
});

/*
 * 输入input名称，调用对应的validate方法。
 * 例如input名称为：loginname，那么调用validateLoginname()方法。
 */
function invokeValidateFunction(inputName) {
	inputName = inputName.substring(0, 1).toUpperCase() + inputName.substring(1);
	var functionName = "validate" + inputName;
	return eval(functionName + "()");
}

/*
 * 校验登录名
 */
function validateLoginname() {
	var bool = true;
	$("#loginnameError").css("display", "none");
	var value = $("#loginname").val();
	if(!value) {// 非空校验
		$("#loginnameError").css("display", "");
		$("#loginnameError").text("用户名不能为空！");
		bool = false;
	} else if(value.length < 4 || value.length > 20) {//长度校验
		$("#loginnameError").css("display", "");
		$("#loginnameError").text("用户名长度必须在4 ~ 20之间！");
		bool = false;
	}
	return bool;
}

/*
 * 校验密码
 */
function validateLoginpass() {
	var bool = true;
	$("#loginpassError").css("display", "none");
	var value = $("#loginpass").val();
	if(!value) {// 非空校验
		$("#loginpassError").css("display", "");
		$("#loginpassError").text("密码不能为空！");
		bool = false;
	} else if(value.length < 4 || value.length > 20) {//长度校验
		$("#loginpassError").css("display", "");
		$("#loginpassError").text("密码长度必须在4 ~ 20之间！");
		bool = false;
	}
	return bool;
}


//删除！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
/*
 * 校验验证码
 */
// function validateVerifyCode() {
// 	var bool = true;
// 	$("#verifyCodeError").css("display", "none");
// 	var value = $("#verifyCode").val();
// 	if(!value) {//非空校验
// 		$("#verifyCodeError").css("display", "");
// 		$("#verifyCodeError").text("验证码不能为空！");
// 		bool = false;
// 	} else if(value.length != 4) {//长度不为4就是错误的
// 		$("#verifyCodeError").css("display", "");
// 		$("#verifyCodeError").text("错误的验证码！");
// 		bool = false;
// 	} else {//验证码是否正确
// 		$.ajax({
// 			cache: false,
// 			async: false,
// 			type: "POST",
// 			dataType: "json",
// 			data: {verifyCode: value},
// 			url: "/yosebook-ssm-maven/user/ajaxValidateVerifyCode.do",
// 			success: function(flag) {
// 				console.log(flag);
// 				console.log(value);
// 				if(!flag) {
// 					$("#verifyCodeError").css("display", "");
// 					$("#verifyCodeError").text("验证码错误！");
// 					bool = false;
// 				}
// 			}
// 		});
// 	}
// 	return bool;
// }
