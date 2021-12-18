<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js"></script>
<style>
    .button-group a{
        font-size: larger;
    }
    table>tbody>tr>td,table>tbody>tr>th{
    	vertical-align: middle
    }
    .error {
      color: red;
      font-weight: bold;
   }
</style>
<body>
    <div class="">
        <div class="col d-flex justify-content-between py-2 px-4 border border-2 border-dark" style="background:var(--myAqua)">
            <h4 class="text-dark mb-0 px-3 py-2 rounded-2">User Management</h4>
            <div class="button-group d-flex">
                <a class="btn btn-danger d-flex align-items-center me-2" data-bs-toggle="modal" data-bs-target="#deleteSelectedUserID"><i class="material-icons me-1">&#xE15C;</i> <span>Delete</span></a>
                <a class="btn btn-success d-flex align-items-center" data-bs-toggle="modal" data-bs-target="#addNewAccount"><i class="material-icons me-1">&#xe147;</i><span>Add New Account</span></a>
            </div>
        </div>
    </div>
    <div class="mt-3">
        <div class="table-responsive">
            <table class="table table-bordered border-1 border-dark" id="productTable" >
                <thead class="text-dark" style="background: var(--myYellow)">
                    <tr>
                        <th><input type="checkbox" id="selectAll"></th>
                        <th>Photo</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody class="bg-white text-dark fw-bold">
                	<c:forEach var="item" items="${listAccount}">
                		<tr>
	                        <th data-listUserID="${item.userID}"><input type="checkbox"></th>
	                        <td><img src="${pageContext.servletContext.contextPath}/home/userAvatar/${item.photo }" height="60px" width="60px" class="border border-2 border-dark"/></td>
	                        <td>${item.fullname }</td>
	                        <td>${item.email }</td>
	                        <td>${item.phone}</td>
	                        <td>${item.address}</td>
	                        <td>${item.role}</td>
	                        <td>
	                            <a class="text-warning" onclick="editUser('${item.userID}')" style="cursor: pointer;"><i class="material-icons"
	                                data-toggle="tooltip" title="Edit">&#xE254;</i></a>
	                            <a class="text-danger" data-bs-toggle="modal" data-bs-target="#deleteUserID" onclick="deleteUserID('${item.userID}')" style="cursor: pointer;" ><i class="material-icons"
	                                data-toggle="tooltip" title="Delete">&#xE872;</i></a>
	                        </td>
	                    </tr>
                	</c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
<!--Add New User Modal-->
<div id="addNewAccount" class="modal fade" tabindex="-1" data-bs-backdrop="static" aria-hidden="true">
    <form:form action="${pageContext.servletContext.contextPath}/admin/account/addNewAccount" modelAttribute="User" method="post" enctype="multipart/form-data" class="modal-dialog modal-dialog-centered" style="max-width: 600px" >
      <div class="modal-content border border-1 border-white">
        <div class="modal-header bg-purple text-white">
          <h5 class="modal-title">Add New Account</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body bg-black text-white">
          <div class="form-group">
            <label for="">Name</label>
            <form:input path="fullname" class="form-control bg-white fw-bold" placeholder="Enter your name?"/>
          </div>
          <div class="form-group my-1">
            <label for="">Password</label>
            <form:input path="password" class="form-control bg-white fw-bold" placeholder="Enter your password?" type="password"/>
         </div>
         <div class="form-group my-1">
            <label for="">Email</label>
            <form:input path="email" class="form-control bg-white fw-bold" placeholder="Enter your email?"/>
         </div>
         <div class="form-group my-1">
            <label for="">Phone</label>
            <form:input path="phone" class="form-control bg-white fw-bold" placeholder="Enter your phone?"/>
         </div>
         <div class="form-group my-1">
            <label for="">Address</label>
            <form:input path="address" class="form-control bg-white fw-bold" placeholder="Enter your address?"/>
         </div>
         <div class="form-group row my-1">
            <div class="col-6">
                <label for="">Gender</label>
                <div class="form-control bg-yellow text-dark fw-bold">
                    <form:radiobuttons path="gender" items="${listGender}" class="ms-2 me-1 " demiliter=" "/>
                </div>
            </div>
            <div class="col-6">
                <label for="">Role</label>
                <form:select path="role" class="form-control bg-yellow text-dark fw-bold">
				    <form:options items="${listRole}" itemValue="role" itemLabel="name"/>
				</form:select>
            </div>
         </div>
         <div class="form-group">
             <label for="">Avatar</label>
             <input id="input-b6a" name="input-b6a[]" type="file" multiple required>
         </div>
        </div>
        <div class="modal-footer bg-gray">
          <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
          <button class="btn btn-success">Add Account</button>
        </div>
      </div>
    </form:form>
  </div>
<!--Add New User Modal Edge-->
<!--Edit User Modal-->
<div id="editUser" class="modal fade" tabindex="-1" data-bs-backdrop="static" aria-hidden="true">
    <form:form action="${pageContext.servletContext.contextPath}/admin/account/updateUser" modelAttribute="UserEdit" method="post" enctype="multipart/form-data" class="modal-dialog modal-dialog-centered" style="max-width: 600px" >
      <div class="modal-content border border-1 border-white">
        <div class="modal-header bg-purple text-white">
          <h5 class="modal-title">Edit Account</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body bg-black text-white">
          <div class="form-group">
            <form:input path="userID" type="hidden" id="userID"/>
            <label for="">Name</label>
            <form:input path="fullname" class="form-control bg-white fw-bold" placeholder="Enter your name?"/>
          </div>
          <div class="form-group my-1">
            <label for="">Password</label>
            <form:input path="password" class="form-control bg-white fw-bold" placeholder="Enter your password?" type="password"/>
         </div>
         <div class="form-group my-1">
            <label for="">Email</label>
            <form:input path="email" class="form-control bg-white fw-bold" placeholder="Enter your email?"/>
         </div>
         <div class="form-group my-1">
            <label for="">Phone</label>
            <form:input path="phone" class="form-control bg-white fw-bold" placeholder="Enter your phone?"/>
         </div>
         <div class="form-group my-1">
            <label for="">Address</label>
            <form:input path="address" class="form-control bg-white fw-bold" placeholder="Enter your address?"/>
         </div>
         <div class="form-group row my-1">
            <div class="col-6">
                <label for="">Gender</label>
                <div class="form-control bg-yellow text-dark fw-bold">
                    <form:radiobuttons path="gender" items="${listGender}" class="ms-2 me-1 " demiliter=" "/>
                </div>
            </div>
            <div class="col-6">
                <label for="">Role</label>
                <form:select path="role" class="form-control bg-yellow text-dark fw-bold">
				    <form:options items="${listRole}" itemValue="role" itemLabel="name"/>
				</form:select>
            </div>
         </div>
         <div class="form-group">
                <form:input path="photo" type="hidden"/>
             <label for="">Avatar</label>
             <input id="input-b7a" name="input-b7a[]" type="file" multiple>
         </div>
        </div>
        <div class="modal-footer bg-gray">
          <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
          <button class="btn btn-success">Update Account</button>
        </div>
      </div>
    </form:form>
  </div>
<!--Edit User Modal Edge-->
<!-- Delete Modal -->
<div id="deleteUserID" class="modal fade">
    <div class="modal-dialog border border-1 border-white">
        <div class="modal-content">
            <form>
                <div class="modal-header bg-red text-white">
                    <h4 class="modal-title">Delete Account</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body bg-black">
                    <p class="text-white">Are you sure you want to delete this account?</p>
                    <p class="text-warning">
                        <small>This action cannot be undone.</small>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">Cancel</button>
                     <button type="button"
                        class="btn btn-danger" id="acceptDeleteUserID">Delete</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Delete Modal Edge -->

<!-- Delete SelectedID Modal -->
<div id="deleteSelectedUserID" class="modal fade">
    <div class="modal-dialog border border-1 border-white">
        <div class="modal-content">
            <form>
                <div class="modal-header bg-red text-white">
                    <h4 class="modal-title">Delete Account</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body bg-black">
                    <p class="text-white">Are you sure you want to delete these account?</p>
                    <p class="text-warning">
                        <small>This action cannot be undone.</small>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">Cancel</button>
                     <button type="button"
                        class="btn btn-danger" id="acceptDeleteSelectedUserID">Delete</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Delete SelectedID Modal Edge -->
<script>
    $('#User').validate( {
    rules: {
      fullname: {
        required:true,
        minlength:6,
        maxlength:30
      },
      password: {
        required: true,
        minlength: 3,
        maxlength:30
      },
      email: {
        required: true,
        email: true
      },
      phone: {
        required: true,
        maxlength:15
      },  
    },
    messages: {
      fullname: {
        required:"Full name is required",
        minlength:"Name must be at least 6 characters",
        maxlength:"Name can not exceed 30 characters"
      },
      password: {
        required: "Password is required",
        minlength: "Password must be at least 3 characters",
        maxlength: "Password can not exceed 30 characters"
      },
      email: {
        required: "Email is required",
        email: "Email is invalid"
      },
      phone: {
        required: "Phone number is required",
        maxlength:"Phone number can not exceed 30 characters"
      },  
    },
    submitHandler: function(form) {
      form.submit();
    }
    
  })
  $('#UserEdit').validate( {
    rules: {
      fullname: {
        required:true,
        minlength:6,
        maxlength:30
      },
      password: {
        required: true,
        minlength: 3,
        maxlength:30
      },
      email: {
        required: true,
        email: true
      },
      phone: {
        required: true,
        maxlength:15
      },  
    },
    messages: {
      fullname: {
        required:"Full name is required",
        minlength:"Name must be at least 6 characters",
        maxlength:"Name can not exceed 30 characters"
      },
      password: {
        required: "Password is required",
        minlength: "Password must be at least 3 characters",
        maxlength: "Password can not exceed 30 characters"
      },
      email: {
        required: "Email is required",
        email: "Email is invalid"
      },
      phone: {
        required: "Phone number is required",
        maxlength:"Phone number can not exceed 30 characters"
      },  
    },
    submitHandler: function(form) {
      form.submit();
    }
    
  })
    $(document).ready(function() {
        $('[data-toggle="tooltip"]').tooltip();
        var checkboxes = $('table tbody tr input[type=checkbox]');
        $('#selectAll').on('click',function(){
            if(this.checked){
                checkboxes.prop('checked',true);
            }else{
                checkboxes.prop('checked',false);
            }
        })
        checkboxes.click(function(){
            if(checkboxes.length === checkboxes.filter(':checked').length){
                $('#selectAll').prop('checked',true);
            }else{
                $('#selectAll').prop('checked',false);
            }
        })
        $('#productTable').dataTable( {
    		"pageLenght": 5,
      	  "lengthMenu": [ 5, 10, 25, 40, 100 ]
      	} );

        $("#input-b6a").fileinput({
            showUpload: false,
            dropZoneEnabled: false,
            maxFileCount: 1,
            inputGroupClass: "input-group-lg"
	   	});
        $("#input-b7a").fileinput({
            showUpload: false,
            dropZoneEnabled: false,
            maxFileCount: 1,
            inputGroupClass: "input-group-lg"
	   	});

        $('#acceptDeleteSelectedUserID').click(function(){
            var selectedUserID = [];
            $(checkboxes).filter(':checked').each(function(){
                selectedUserID.push($(this).parent().attr('data-listUserID'));
            })
            location.href = '${pageContext.request.contextPath}/admin/account/deleteSelectedUserID/'+selectedUserID
        })
    })

    function deleteUserID(id){
        $('#acceptDeleteUserID').click(function(){
            location.href = '${pageContext.request.contextPath}/admin/account/deleteUserID/'+id;
        })
    }

    function editUser(id){
        $('#editUser').modal('show');
        $.ajax({
            type: "post",
            dataType:'json',
            url:'${pageContext.request.contextPath}/admin/account/edit/'+id,
            async: true,
            success: function(res){
                console.log(res);
                $('#userID').val(res.userID);
                $('input[name=fullname]').val(res.fullname);
                $('input[name=email]').val(res.email);
                if(res.gender === true){
                    $('#gender3').prop('checked',false);
                    $('#gender4').prop('checked',true);
                }else{
                    $('#gender3').prop('checked',true);
                    $('#gender4').prop('checked',false);
                }
                $('input[name=address]').val(res.address);
                $('input[name=password]').val(res.password);
                $('input[name=phone]').val(res.phone);
                $('input[name=photo]').val(res.photo);
                var options = $('select option');
                $(options).each(function(){
                    if(res.role === $(this).val()){
                        $(this).prop('selected',true);
                    }
                })
            }
        })
    }
</script>