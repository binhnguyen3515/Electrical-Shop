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
        <div class="col d-flex justify-content-between py-2 px-4 border border-2 border-dark" style="background:var(--myGreen)">
            <h4 class="text-white mb-0 px-3 py-2 rounded-2">Product Archive Management</h4>
            <div class="button-group d-flex">
                <a class="btn btn-danger d-flex align-items-center me-2" data-bs-toggle="modal" data-bs-target="#deleteSelectedProduct"><i class="material-icons me-1">&#xe9d8;</i> <span>Recover</span></a>
            </div>
        </div>
    </div>
    <div class="mt-3">
        <div class="table-responsive">
            <table class="table table-bordered border-2 border-dark" id="productTable" >
                <thead class="text-dark" style="background: var(--myYellow)">
                    <tr>
                        <th><input type="checkbox" id="selectAll"></th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Brand</th>
                        <th>Type</th>
                        <th>Discount</th>
                        <th>Color</th>
                        <th>Price | Quantity</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody class="bg-truewhite">
                	<c:forEach var="item" items="${listProduct}">
                		<tr>
	                        <th data-productID="${item.productID}"><input type="checkbox"></th>
	                        <td><img src="${pageContext.servletContext.contextPath}/home/ProductImages/${item.category.name}/${item.picture }" height="60px"/></td>
	                        <td>${item.name }</td>
	                        <td>${item.brand }</td>
	                        <td>${item.category.name}</td>
	                        <td>${item.discount}%</td>
	                        <td>
	                        	
	                        	<c:forEach var="item2" items="${item.detailedProducts}">
	                        		<label class="btn bg-${fn:toLowerCase(item2.color)} mb-1  rounded-0 border border-dark" style="height: 30px; width: 30px;" data-toggle="tooltip" title="${item2.color }"> </label>
	                        	</c:forEach>
	                        </td>
	                        <td id="getArraysParent">
	                        	<c:forEach var="item1" items="${item.detailedProducts}">
	                        		<span class="badge bg-dark fs-6 mb-1" id="getArrays" data-toggle="tooltip" title="Color:${item1.color}, Quantity:${item1.quantity }" style="cursor: pointer;"
                                    data-colorArray="${item1.color}"
                                    data-priceArray="${item1.price}"
                                    data-quantityArray="${item1.quantity}"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${item1.price}"/></span>
	                        	</c:forEach>
	                        </td>
	                        <td>
	                            <a href="" class="font-purple" data-bs-toggle="modal" data-bs-target="#recoverProductIdModal" onclick="recoverProductID('${item.productID}')"><i class="material-icons fs-1"
	                                data-toggle="tooltip" title="Recover" >&#xe9d8;</i></a>
	                        </td>
	                    </tr>
                	</c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
<!-- Recover Modal -->
<div id="recoverProductIdModal" class="modal fade">
    <div class="modal-dialog border border-1 border-white">
        <div class="modal-content">
            <form>
                <div class="modal-header bg-blue text-white">
                    <h4 class="modal-title">Recover Product</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body bg-black">
                    <p class="text-white">Are you sure you want to recover this Product?</p>
                    <p class="text-warning">
                        <small>This action cannot be undone.</small>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                     <button type="button"
                        class="btn btn-success" id="acceptRecoverProductID">Recover</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Recover Modal Edge -->

<!-- Recover Selected ProductID Modal -->
<div id="deleteSelectedProduct" class="modal fade">
    <div class="modal-dialog border border-1 border-white">
        <div class="modal-content">
            <form>
                <div class="modal-header bg-blue text-white">
                    <h4 class="modal-title">Recover Product</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body bg-black">
                    <p class="text-white">Are you sure you want to recover these selected Product?</p>
                    <p class="text-warning">
                        <small>This action cannot be undone.</small>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                     <button type="button"
                        class="btn btn-success" id="acceptRecoverSelectedProductID">Recover</button>
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

        $('#acceptRecoverSelectedProductID').click(function(){
            var productIDSelected = []
            $(checkboxes).filter(':checked').each(function(){
                var e = $(this).parent().attr('data-productID');
                productIDSelected.push(e);
            })
            location.href = '${pageContext.request.contextPath}/admin/product/recoverSelected/'+productIDSelected
        })
    })

    function recoverProductID(id){
        $('#acceptRecoverProductID').click(function(){
            location.href = '${pageContext.request.contextPath}/admin/product/recoverProductID/'+id
        })
    }
</script>