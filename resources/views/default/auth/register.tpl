{include file='auth/header.tpl'}
<body class="register-page">
<div class="register-box">
    <div class="register-logo">
        <a href="../"><b>{$config['appName']}</b></a>
    </div>

    <div class="register-box-body">
        <p class="login-box-msg">来，注册个账号</p>

        <div class="form-group has-feedback">
            <input type="text" id="name" class="form-control" placeholder="昵称"/>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback">
            <input type="text" id="email" class="form-control" placeholder="邮箱"/>
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback">
            <input type="password" id="passwd" class="form-control" placeholder="密码"/>
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback">
            <input type="password" id="repasswd" class="form-control" placeholder="重复密码"/>
            <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
        </div>
		
		<div class="form-group has-feedback">
            	<select class="form-control" id="imtype">
				<option>选择您的联络方式</option>
				<option value="1">微信</option>
				<option value="2">QQ</option>
				<option value="3">Google+</option>
				</select>
        </div>
        
        <div class="form-group has-feedback">
            <input type="text" id="wechat" class="form-control" placeholder="在这输入联络方式账号"/>
            <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
        </div>
		
        <div class="form-group has-feedback">
            <input type="text" id="code" value="{$code}" class="form-control" placeholder="邀请码"/>
            <span class="glyphicon glyphicon-send form-control-feedback"></span>
        </div>


        <div class="form-group has-feedback">
            <p>注册即代表同意<a href="/tos">服务条款</a>，以及保证所录入信息的真实性，如有不实信息会导致账号被删除。</p>
        </div>

        <div class="form-group has-feedback">
            <button type="submit" id="reg" class="btn btn-primary btn-block btn-flat">同意服务条款并提交注册</button>
        </div>

        <div id="msg-success" class="alert alert-info alert-dismissable" style="display: none;">
            <button type="button" class="close" id="ok-close" aria-hidden="true">&times;</button>
            <h4><i class="icon fa fa-info"></i> 成功!</h4>
            <p id="msg-success-p"></p>
        </div>

        <div id="msg-error" class="alert alert-warning alert-dismissable" style="display: none;">
            <button type="button" class="close" id="error-close" aria-hidden="true">&times;</button>
            <h4><i class="icon fa fa-warning"></i> 出错了!</h4>
            <p id="msg-error-p"></p>
        </div>

        <a href="/auth/login" class="text-center">已经注册？请登录</a>
    </div><!-- /.form-box -->
</div><!-- /.register-box -->

<!-- jQuery 2.1.3 -->
<script src="/assets/public/js/jquery.min.js"></script>
<!-- Bootstrap 3.3.2 JS -->
<script src="/assets/public/js/bootstrap.min.js" type="text/javascript"></script>
<!-- iCheck -->
<script src="/assets/public/js/icheck.min.js" type="text/javascript"></script>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
        // $("#msg-error").hide(100);
        // $("#msg-success").hide(100);

    });
</script>
<script>
    $(document).ready(function(){
        function register(){
            $.ajax({
                type:"POST",
                url:"/auth/register",
                dataType:"json",
                data:{
                    email: $("#email").val(),
                    name: $("#name").val(),
                    passwd: $("#passwd").val(),
                    repasswd: $("#repasswd").val(),
					wechat: $("#wechat").val(),
					imtype: $("#imtype").val(),
                    code: $("#code").val(),
                    agree: $("#agree").val()
                },
                success:function(data){
                    if(data.ret == 1){
                        $("#msg-error").hide(10);
                        $("#msg-success").show(100);
                        $("#msg-success-p").html(data.msg);
                        window.setTimeout("location.href='/auth/login'", 2000);
                    }else{
                        $("#msg-success").hide(10);
                        $("#msg-error").show(100);
                        $("#msg-error-p").html(data.msg);
                    }
                },
                error:function(jqXHR){
                    $("#msg-error").hide(10);
                    $("#msg-error").show(100);
                    $("#msg-error-p").html("发生错误："+jqXHR.status);
                }
            });
        }
        $("html").keydown(function(event){
            if(event.keyCode==13){
                register();
            }
        });
        $("#reg").click(function(){
            register();
        });
        $("#ok-close").click(function(){
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function(){
            $("#msg-error").hide(100);
        });
    })
</script>
</body>
</html>
