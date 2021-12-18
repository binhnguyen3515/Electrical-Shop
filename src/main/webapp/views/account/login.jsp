<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ" crossorigin="anonymous"></script>
    
    <base href="${pageContext.servletContext.contextPath}"/>
    <title>Document</title>
    <style>
        .card-body {
	        font-size: 14px;
        }
        a{
            color: rgb(31, 80, 160);;
            text-decoration: none;
        }
        a:hover{
            color: rgb(31, 80, 160);
            text-decoration: underline;
        }
        .card{
            border-color: transparent;
	        box-shadow: 0 4px 8px rgba(0,0,0,.05);
        }
    </style>
</head>
<body style="background: #F7F9FB;">
    <form method="post" action="" class="login-form g-3" novalidate>
        <div class="card mx-auto" style="max-width: 400px; background:#FFFFFF;margin-top: 200px;">
            <div class="card-title">
                <h4 class="px-4 pt-4">Login</h4>
            </div>
            <div class="card-body">
                <div class="form-group px-2">
                    <label for="validationCustom01" class="mb-1">User-ID</label>
                    <input type="text" name="userID" value="${login.userID}" placeholder="User-ID" class="form-control" id="validationCustom01" required autofocus>
                    <div class="invalid-feedback">
                        User-ID is required
                    </div>
                </div>
                <div class="form-group px-2 mt-3">
                    <div class="div d-flex justify-content-between">
                        <label for="validationCustom02" class="mb-1">Password</label>
                        <a data-bs-toggle="modal" data-bs-target="#forgotPassModal" style="cursor: pointer;text-decoration: underline;">Forgot Password?</a>
                    </div>
                    <input type="password" name="password" value="${login.password}" placeholder="Password" class="form-control" id="validationCustom02" required>
                    <div class="invalid-feedback">
                        Password is required
                    </div>
                </div>
                <div class="form-group px-2 mt-3">
                    <div class="form-check">
                        <input class="form-check-input" name="rememberMe" ${login.rememberMe?'checked':''} type="checkbox" id="validationFormCheck1">
                        <label class="form-check-label" for="validationFormCheck1">Remember me</label>
                    </div>
                </div>
                <div class="form-group px-2 mt-3">
                    <button type="submit" class="btn btn-primary py-2 w-100" formaction="${pageContext.servletContext.contextPath}/login">Login</button>
                </div>
                <div class="form-group px-2 mt-3 text-center">
                    Don't have an account? <a href="${pageContext.servletContext.contextPath}/sign-up">Create One</a>
                </div>
            </div>
        </div>
    </form>
    <div class="form-group text-center mt-4" style="font-size:14px;color: cadetblue;">
        Copyright &copy; 2021 - PS14048
    </div>
</body>
<!-- Forgot pass modal-->
<div class="modal fade" id="forgotPassModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header bg-warning">
          <h5 class="modal-title" id="staticBackdropLabel">Forgot Password?</h5>
          <button type="button" class="btn-close btn-danger" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
            <div class="modal-body bg-black">
              <input type="email" class="form-control fw-bold" id="sendEmailForNewPass" placeholder="Enter your email to receive new password" required>
              <small class="text-danger fw-bold" id="emailNotExist"></small>
              <small class="text-success fw-bold" id="emailExist"></small>
            </div>
            <div class="modal-footer bg-warning">
          <button type="button" class="btn btn-success" id="resetPassword">Reset</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <!-- Forgot pass modal Edge-->
<script>
	$(".login-form").submit(function(event) {
		var form = $(this);
        if (form[0].checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
		form.addClass('was-validated');
	});
    $(document).ready(function() {
        $('#resetPassword').click(function() {
            var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            var email = $('#sendEmailForNewPass').val();
            $('#emailNotExist').text('');
            if(email.trim().length==0){
                $('#emailNotExist').text('Email is required');
                return;
            }
            if(!email.trim().match(mailformat)){
                $('#emailNotExist').text('Email is invalid');
                return;
            }
            $.ajax({
                type: "POST",
                url:"${pageContext.servletContext.contextPath}/forgotPass/"+email,
                async:true,
                success: function(res){
                if(res === 'emailNotExist'){
                    $('#emailNotExist').text('Email not exist');
                }
                if(res === 'ok'){
                    $('#emailExist').text('Check your email for new Password');
                }
                console.log(res);
                }
            })
        })
    })
</script>
<c:if test="${sessionScope.message != null}">
    <jsp:include page="/views/messageModal/messageModal.jsp"></jsp:include>
    <script>
        $(document).ready(function(){
            $('#myModal').modal('show'); 

            $('#close1 ,#close2').click(function() {
                <% session.removeAttribute("message");%>
            })  
        })
    </script> 
</c:if>
</html>