<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
    table>tbody>tr>td,table>tbody>tr>th{
    	vertical-align: middle
    }
</style>
<body>
    <div class="">
        <div class="col d-flex justify-content-between py-2 px-4 border border-2 border-dark" style="background:var(--myPurple)">
            <h4 class="text-white mb-0 px-3 py-2 rounded-2">Account Archive Management</h4>
            <div class="button-group d-flex">
                <a class="btn btn-danger d-flex align-items-center me-2" data-bs-toggle="modal" data-bs-target="#recoverSelectedAccount"><i class="material-icons me-1">&#xe9d8;</i> <span>Recover</span></a>
            </div>
        </div>
    </div>
    <div class="mt-3">
        <div class="table-responsive">
            <table class="table table-bordered border-2 border-dark" id="productTable" >
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
                <tbody class="bg-truewhite">
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
	                            <a class="font-green" data-bs-toggle="modal" data-bs-target="#recoverUserID" onclick="recoverUserID('${item.userID}')" style="cursor: pointer;" ><i class="material-icons fs-1"
	                                data-toggle="tooltip" title="Recover">&#xe9d8;</i></a>
	                        </td>
	                    </tr>
                	</c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
<!-- Recover Modal -->
<div id="recoverUserID" class="modal fade">
    <div class="modal-dialog border border-1 border-white">
        <div class="modal-content">
            <form>
                <div class="modal-header bg-blue text-white">
                    <h4 class="modal-title">Recover Account</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body bg-black">
                    <p class="text-white">Are you sure you want to recover this Account?</p>
                    <p class="text-warning">
                        <small>This action cannot be undone.</small>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                     <button type="button"
                        class="btn btn-success" id="acceptRecoverUserID">Recover</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Recover Modal Edge -->
<!-- Recover Selected ProductID Modal -->
<div id="recoverSelectedAccount" class="modal fade">
    <div class="modal-dialog border border-1 border-white">
        <div class="modal-content">
            <form>
                <div class="modal-header bg-blue text-white">
                    <h4 class="modal-title">Recover Account</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body bg-black">
                    <p class="text-white">Are you sure you want to recover these selected Account?</p>
                    <p class="text-warning">
                        <small>This action cannot be undone.</small>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                     <button type="button"
                        class="btn btn-success" id="acceptRecoverSelectedUserID">Recover</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Recover Selected ProductID Modal Edge -->
<script>
    $(document).ready(function(){
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

        $('#acceptRecoverSelectedUserID').click(function(){
            var userIDSelected = []
            $(checkboxes).filter(':checked').each(function(){
                var e = $(this).parent().attr('data-listUserID');
                userIDSelected.push(e);
            })
            location.href = '${pageContext.request.contextPath}/admin/account/recoverSelectedID/'+userIDSelected
        })
    })

    function recoverUserID(id){
        $('#acceptRecoverUserID').click(function(){
            location.href = '${pageContext.request.contextPath}/admin/account/recoverUserID/'+id
        })
    }
</script>