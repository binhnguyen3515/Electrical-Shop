<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
    .button-group a{
        font-size: larger;
    }
    table>tbody>tr>td,table>tbody>tr>th{
    	vertical-align: middle
    }
    input[type=number]:not(.bg-white,.bg-yellow)::placeholder{
        color: white;
    }
    input[type=number]:not(.bg-white,.bg-yellow,#productDiscount){
        color: var(--myWhite);
    }
    
    .disabledContent{
        pointer-events: none;
        opacity: 0.4;
    }
    .checkboxesColorParent{
        pointer-events: visible !important;
        background-color:var(--myGray);
    }
    .btn.btn-primary.btn-file{
		background-color: 	#d9534f !important;
		border-color: #d9534f !important;
	}
    .file-caption-name:not(.file-caption-disabled) {
    	background-color: 	#5cb85c !important;
	}
    .file-caption-name[placeholder] {
    	color:white !important;
    	font-weight: bold !important;
	}
	.file-drop-disabled.clearfix{
		background-color: var(--myWhite) !important;
	}
    #deleteByID,#deleteByID:hover{
        color: var(--myRed) !important;
    }
</style>
<body>
    <div class="">
        <div class="col d-flex justify-content-between py-2 px-4 border border-2 border-dark" style="background:var(--myBlue)">
            <h4 class="text-white mb-0 px-3 py-2 rounded-2">Product Management</h4>
            <div class="button-group d-flex">
                <a class="btn btn-danger d-flex align-items-center me-2" data-bs-toggle="modal" data-bs-target="#deleteSelectedProduct"><i class="material-icons me-1">&#xE15C;</i> <span>Delete</span></a>
                <a class="btn btn-success d-flex align-items-center" data-bs-toggle="modal" data-bs-target="#addProductModal" onclick="addProduct()"><i class="material-icons me-1">&#xe147;</i><span>Add New Product</span></a>
            </div>
        </div>
    </div>
    <div class="mt-3">
        <!-- <input type="text" id="min" placeholder="min price" name="min">
        <input type="text" id="max" placeholder="max price" name="max"> -->
        <div class="table-responsive mt-2">
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
	                            <a href="" class="text-warning" data-bs-toggle="modal" data-bs-target="#editProductModal" onclick="editProduct('${item.productID}')"><i class="material-icons"
	                                data-toggle="tooltip" title="Edit" >&#xE254;</i></a>
	                            <a href="" data-bs-toggle="modal" data-bs-target="#deleteProductIdModal" id="deleteByID" onclick="deleteProductID('${item.productID}')"><i class="material-iconstext-danger"><i class="material-icons"
	                                data-toggle="tooltip" title="Delete">&#xE872;</i></a>
	                        </td>
	                    </tr>
                	</c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
<!-- Modal Edit Product-->
<div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 1000px">
      <form method="POST" class="modal-content" enctype="multipart/form-data">
        <div class="modal-header bg-aqua">
          <h5 class="modal-title" id="exampleModalLabel">EDIT PRODUCT</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body bg-black text-white fw-bold border border-1 border-white" id="ajax-edit-results">
            <input type="hidden" value="" name="productID" id="productID">
            <div class="form-group row">
                <div class="col-3">
                    <label for="" class="form-label">Product Name</label>
                    <input type="text" placeholder="Enter product name?" class="form-control" name="name" id="productName">
                </div>
                <div class="col-3">
                    <label for="" class="form-label">Product Brand</label>
                    <input type="text" placeholder="Enter product brand?" class="form-control" name="brand" id="productBrand">
                </div>
                <div class="col-3">
                    <div class="mb-3">
                      <label for="" class="form-label">Category</label>
                      <select class="form-control" name="category.name" id="categoryName">
                        <c:forEach var="item" items="${listCategory}">
                        	<option value="${item.name}">${item.name}</option>
                        </c:forEach>
                      </select>
                    </div>
                </div>
                <div class="col-3">
                    <label for="" class="form-label">Product Discount</label>
                    <input type="number" placeholder="Enter discount?" class="form-control" name="discount" id="productDiscount" min="0" value="10" step="0.01" required> 
                </div>
            </div>
            <div class="form-group row">
                <div class="col">
                    <div class="mb-3">
                      <label for="" class="form-label">Product Description</label>
                      <textarea class="form-control" name="description" id="productDescription" rows="3"></textarea>
                    </div>
                </div>
            </div>
            <div class="form-group row" id="productDetailContent">
                <label for="" class="form-label">Pick product color</label>
            	<c:forEach var="item" items="${listColor}">
            		<div class="col-6">
	                    <div class="row">
	                        <div class="col-6">
	                            <div class="input-group">
                                    <div class="input-group-text checkboxesColorParent">
                                        <input type="checkbox" class="form-check-input checkboxesColor" data-color="bg-${item.color}" name="colors" value="${item.color}">
                                    </div>
	                                <span class="input-group-text">$</span>
	                                <input type="number" class="form-control bg-${item.color} fw-bold inputPrice" placeholder="Price?" name="prices" min="0">
	                            </div>
	                        </div>
	                        <div class="col-6">
	                            <div class="input-group">
	                                <input type="number" class="form-control bg-${item.color} fw-bold inputQuantity" placeholder="Quantity?" name="quantities" min="0">
	                                <span class="input-group-text">Quantity</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
            	</c:forEach>
            </div>
            <div class="form-group row mt-2">
                <div class="col">
                    <label for="">Choose Product Photos</label>
                    <input id="input-b6a" name="input-b6a[]" type="file" multiple>
                </div>
            </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-warning" data-bs-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary" id="submitEdit" formaction="${pageContext.servletContext.contextPath}/admin/product/update">Save changes</button>
        </div>
      </form>
    </div>
  </div>
<!-- Modal Edit Product Edge-->
<!-- Modal Add Product-->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 1000px">
      <form method="POST" class="modal-content" enctype="multipart/form-data">
        <div class="modal-header bg-aqua">
          <h5 class="modal-title" id="exampleModalLabel">ADD PRODUCT</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body bg-black text-white fw-bold border border-1 border-white" id="ajax-edit-results">
            <input type="hidden" value="" name="productID" id="productID">
            <div class="form-group row">
                <div class="col-3">
                    <label for="" class="form-label">Product Name</label>
                    <input type="text" placeholder="Enter product name?" class="form-control" name="name" id="productName">
                </div>
                <div class="col-3">
                    <label for="" class="form-label">Product Brand</label>
                    <input type="text" placeholder="Enter product brand?" class="form-control" name="brand" id="productBrand">
                </div>
                <div class="col-3">
                    <div class="mb-3">
                      <label for="" class="form-label">Category</label>
                      <select class="form-control" name="category.name" id="categoryName">
                        <c:forEach var="item" items="${listCategory}" begin="0" varStatus="loop">
                        	<option value="${item.name}" <c:if test="${loop.index == 0}">selected</c:if>>${item.name}</option>
                        </c:forEach>
                      </select>
                    </div>
                </div>
                <div class="col-3">
                    <label for="" class="form-label">Product Discount</label>
                    <input type="number" placeholder="Enter discount?" class="form-control" name="discount" id="productDiscount" value="0" step="0.01" required> 
                </div>
            </div>
            <div class="form-group row">
                <div class="col">
                    <div class="mb-3">
                      <label for="" class="form-label">Product Description</label>
                      <textarea class="form-control" name="description" id="productDescription" rows="3"></textarea>
                    </div>
                </div>
            </div>
            <div class="form-group row" id="productDetailContent">
                <label for="" class="form-label">Pick product color</label>
            	<c:forEach var="item" items="${listColor}">
            		<div class="col-6">
	                    <div class="row">
	                        <div class="col-6">
	                            <div class="input-group">
                                    <div class="input-group-text checkboxesColorParent">
                                        <input type="checkbox" class="form-check-input checkboxesColor" data-color="bg-${item.color}" name="colors" value="${item.color}">
                                    </div>
	                                <span class="input-group-text">$</span>
	                                <input type="number" class="form-control bg-${item.color} fw-bold inputPrice" placeholder="Price?" name="prices" min="0">
	                            </div>
	                        </div>
	                        <div class="col-6">
	                            <div class="input-group">
	                                <input type="number" class="form-control bg-${item.color} fw-bold inputQuantity" placeholder="Quantity?" name="quantities" min="0">
	                                <span class="input-group-text">Quantity</span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
            	</c:forEach>
            </div>
            <div class="form-group row mt-2">
                <div class="col">
                    <label for="">Choose Product Photos</label>
                    <input id="input-b7a" name="input-b7a[]" type="file" multiple>
                </div>
            </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-warning" data-bs-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary" id="submitEdit" formaction="${pageContext.servletContext.contextPath}/admin/product/add">Save changes</button>
        </div>
      </form>
    </div>
  </div>
<!-- Modal Add Product Edge-->
<!-- Delete Modal -->
<div id="deleteProductIdModal" class="modal fade">
    <div class="modal-dialog border border-1 border-white">
        <div class="modal-content">
            <form>
                <div class="modal-header bg-red text-white">
                    <h4 class="modal-title">Delete Product</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body bg-black">
                    <p class="text-white">Are you sure you want to delete this Product?</p>
                    <p class="text-warning">
                        <small>This action cannot be undone.</small>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">Cancel</button>
                     <button type="button"
                        class="btn btn-danger" id="acceptDeleteProductID">Delete</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Delete Modal Edge -->

<!-- Delete Selected ProductID Modal -->
<div id="deleteSelectedProduct" class="modal fade">
    <div class="modal-dialog border border-1 border-white">
        <div class="modal-content">
            <form>
                <div class="modal-header bg-red text-white">
                    <h4 class="modal-title">Delete Product</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body bg-black">
                    <p class="text-white">Are you sure you want to delete these selected Product?</p>
                    <p class="text-warning">
                        <small>This action cannot be undone.</small>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">Cancel</button>
                     <button type="button"
                        class="btn btn-danger" id="acceptDeleteSelectedProductID">Delete</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Delete Selected ProductID Modal Edge -->
<script>
    
    $(document).ready(function() {
        // $.fn.dataTable.ext.search.push(
        //     function( settings, data, dataIndex ) {
        //         var min = parseInt( $('#min').val(), 10 );
        //         var max = parseInt( $('#max').val(), 10 );
        //         var price = parseFloat( data[7] ) || 0; // use data for the price column
        
        //         if ( ( isNaN( min ) && isNaN( max ) ) ||
        //             ( isNaN( min ) && price <= max ) ||
        //             ( min <= price   && isNaN( max ) ) ||
        //             ( min <= price   && price <= max ) )
        //         {
        //             return true;
        //         }
        //         return false;
        //     }
        // );
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
        var table = $('#productTable').DataTable( {
    		"pageLenght": 5,
      	  "lengthMenu": [ 5, 10, 25, 40, 100 ]
      	} );
        // $('#min, #max').keyup( function() {
        //     table.draw();
        // } );
        $('.checkboxesColor').on('click',function(){
            if(this.checked){
                $(this).parent().parent().parent().parent().removeClass('disabledContent');
                $(this).parent().parent().find('.inputPrice').prop('required',true);
                $(this).parent().parent().parent().parent().children('.col-6').eq(1).find('.inputQuantity').prop('required',true);
            }else{
                $(this).parent().parent().parent().parent().addClass('disabledContent');
                $(this).parent().parent().find('.inputPrice').val("");
                $(this).parent().parent().parent().parent().children('.col-6').eq(1).find('.inputQuantity').val("");
                $(this).parent().parent().find('.inputPrice').prop('required',false);
                $(this).parent().parent().parent().parent().children('.col-6').eq(1).find('.inputQuantity').prop('required',false);
            }
        })
        $("#input-b6a").fileinput({
		        showUpload: false,
		        dropZoneEnabled: false,
		        maxFileCount: 5,
		        inputGroupClass: "input-group-lg"
	   	});
        $("#input-b7a").fileinput({
            showUpload: false,
            dropZoneEnabled: false,
            maxFileCount: 5,
            inputGroupClass: "input-group-lg"
        });

        $('#acceptDeleteSelectedProductID').click(function(){
            console.log("running");
            var productIDSelected = []
            $(checkboxes).filter(':checked').each(function(){
                var e = $(this).parent().attr('data-productID');
                productIDSelected.push(e);
            })
            location.href = '${pageContext.request.contextPath}/admin/product/deleteSelected/'+productIDSelected
        })
    })
    
    function deleteProductID(id){
        $('#acceptDeleteProductID').click(function(){
            location.href = '${pageContext.request.contextPath}/admin/product/delete/'+id
        })
    }

    function addProduct(){
        var checkboxesColor = $('.checkboxesColor');
        checkboxesColor.each(function(){
            $(this).prop('checked',false);
            if($(this).is(':checked')){
                $(this).parent().parent().parent().parent().removeClass('disabledContent');
            }else{
                $(this).parent().parent().parent().parent().addClass('disabledContent');
                $(this).parent().parent().find('.inputPrice').val("");
                $(this).parent().parent().parent().parent().children('.col-6').eq(1).find('.inputQuantity').val("");
            }
        })
    }
    function editProduct(id){
        var checkboxesColor = $('.checkboxesColor');
        checkboxesColor.each(function(){
            $(this).prop('checked',false);
            if($(this).is(':checked')){
                $(this).parent().parent().parent().parent().removeClass('disabledContent');
            }else{
                $(this).parent().parent().parent().parent().addClass('disabledContent');
                $(this).parent().parent().find('.inputPrice').val("");
                $(this).parent().parent().parent().parent().children('.col-6').eq(1).find('.inputQuantity').val("");
            }
        })
        $.ajax({
            type: "GET",
            url:'${pageContext.request.contextPath}/admin/product/edit/?productID='+id,
            dataType:'json',
            async: true,
            success:function(res){
                var colors = [];
                var prices = [];
                var quantities = [];
                //lấy colors làm mốc for in vì mảng colors có length tương đương quantities và prices
                for (const key in res.colors) {
                    colors.push('bg-'+res.colors[key]);
                    prices.push(res.prices[key]);
                    quantities.push(res.quantities[key]);
                }
                //kiểm tra quantities sau khi push dữ liệu vào
                // prices.forEach(e=>console.log(e))
                // checkboxesColor.each(function(){
                //     console.log("check:"+$(this).attr('data-color'));
                // })
                //so sánh checkboxesColor và colors, nếu trùng thì checkbox = checked, đồng thời set price và set quantity
                for (let i = 0; i < checkboxesColor.length; i++) {
                    for (let j = 0; j < colors.length; j++) {
                        var parents = $(checkboxesColor[i]).parent().parent();
                        if($(checkboxesColor[i]).attr('data-color')===colors[j]){
                            $(checkboxesColor[i]).parent().parent().parent().parent().removeClass('disabledContent');
                            $(checkboxesColor[i]).prop('checked',true);
                            parents.find('.inputPrice').val(prices[j]);
                            parents.parent().parent().children('.col-6').eq(1).find('.inputQuantity').val(quantities[j]);
                        }
                    }      
                }
                //set các giá trị còn lại
                $('#productID').val(res.productID);
                $('#productName').val(res.name);
                $('#productBrand').val(res.brand);
                $('#categoryName').val(res.categoryName).change();
                $('#productDiscount').val(parseFloat(res.discount));
                $('#productDescription').val(res.description);

            }
        })
    }
    
</script>