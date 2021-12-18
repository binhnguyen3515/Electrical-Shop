<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <!-- Input File-->
    
    <!-- default icons used in the plugin are from Bootstrap 5.x icon library (which can be enabled by loading CSS below) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.min.css" crossorigin="anonymous">
    
    <!-- alternatively you can use the font awesome icon library if using with `fas` theme (or Bootstrap 4.x) by uncommenting below. -->
    <!-- link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" crossorigin="anonymous" -->
    
    <!-- the fileinput plugin styling CSS file -->
    <link href="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
    
    <!-- if using RTL (Right-To-Left) orientation, load the RTL CSS file after fileinput.css by uncommenting below -->
    <!-- link href="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/css/fileinput-rtl.min.css" media="all" rel="stylesheet" type="text/css" /-->
    
    <!-- the jQuery Library -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>
    
    <!-- piexif.min.js is needed for auto orienting image files OR when restoring exif data in resized images and when you
        wish to resize images before upload. This must be loaded before fileinput.min.js -->
    <script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/plugins/piexif.min.js" type="text/javascript"></script>
    
    <!-- sortable.min.js is only needed if you wish to sort / rearrange files in initial preview. 
        This must be loaded before fileinput.min.js -->
    <script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/plugins/sortable.min.js" type="text/javascript"></script>
    
    <!-- bootstrap.bundle.min.js below is needed if you wish to zoom and preview file content in a detail modal
        dialog. bootstrap 5.x or 4.x is supported. You can also use the bootstrap js 3.3.x versions. -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    
    <!-- the main fileinput plugin script JS file -->
    <script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/fileinput.min.js"></script>
    <!-- Input File Edge -->
    <base href="${pageContext.servletContext.contextPath}"/>
    <title>Document</title>
</head>
<style>
    .input-group,.file-preview {
        background-color:white
    }
    .btn.btn-primary.btn-file{
        background-color: blueviolet !important;
        border-color: violet !important;
    }
    
</style>
<body style="background: darkgrey">
    <form:form method="post" modelAttribute="User" enctype="multipart/form-data" class="card mt-3 mx-auto" style="max-width: 600px;">
        <div class="card-title mb-0">
            <h3 class="bg-primary text-white p-3 text-center mb-0">Registration Form</h3>
        </div>
        <div class="card-body bg-dark text-warning fw-bold">
            <div class="form-group row">
                <div class="col-6">
                    <label for="">UserID</label>
                    <form:input path="userID" class="form-control" placeholder="Enter UserID?"/>
                    <form:errors path="userID" class="text-danger fw-bold"></form:errors>
                </div>
                <div class="col-6">
                    <label for="">Password</label>
                    <form:input path="password" type="password" class="form-control" placeholder="Enter Password?" />
                    <form:errors path="password" class="text-danger fw-bold"></form:errors>
                </div>
            </div>
            <div class="form-group row mt-1">
                <div class="col-6">
                    <label for="">Full name</label>
                    <form:input path="fullname" class="form-control" placeholder="Enter Your Name?" />  
                    <form:errors path="fullname" class="text-danger fw-bold"></form:errors>  
                </div>
                <div class="col-6">
                    <label for="">Phone</label>
                    <form:input path="phone" type="text" class="form-control" placeholder="Enter Phone Number?" />
                    <form:errors path="phone" class="text-danger fw-bold"></form:errors>
                </div>
            </div>
            <div class="form-group mt-1">
                <label for="">Email</label>
                <form:input path="email" type="email" class="form-control" placeholder="Enter Email?" />
                <form:errors path="email" class="text-danger fw-bold"></form:errors>
            </div>
            <div class="form-group mt-1">
                <label for="">Address</label>
                <form:input path="address" type="text" class="form-control" placeholder="Enter Address?" />
                <form:errors path="address" class="text-danger fw-bold"></form:errors>
            </div>
            <div class="form-group mt-1">
                <label for="">Gender</label>
                <div class="form-control bg-yellow text-dark fw-bold">
                    <form:radiobuttons path="gender" items="${listGender}" class="ms-2 me-1 " demiliter=" "/>
                </div>
                <form:errors path="gender" class="text-danger fw-bold"></form:errors>
            </div>
            <div class="form-group row mt-1">
                <label for="">Photo</label>
                <input id="input-b6a" name="input-b6a[]" type="file" multiple required>
            </div>
        </div>
        <div class="card-footer bg-primary">
            <div class="form-group text-end">
                <a href="${pageContext.servletContext.contextPath}" class="btn btn-danger border border-1 border-light">Home</a>
                <button class="btn btn-success border border-1 border-light">Sign-Up</button>
            </div>
        </div>
    </form:form>
</body>

<c:if test="${sessionScope.message != null}">
    <jsp:include page="/views/messageModal/messageModal.jsp"></jsp:include>
    <script>
        $(document).ready(function() {
            $('#myModal').modal('show'); 
        })
        $('#close1 ,#close2').click(function() {
            <% session.removeAttribute("message");%>
        })   
    </script> 
</c:if>
<script>
    $(document).ready(function() {
        $("#input-b6a").fileinput({
            showUpload: false,
            dropZoneEnabled: false,
            maxFileCount: 1,
            inputGroupClass: "input-group-md"
	   	}); 
    })
</script>
</html>