<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
    .modal-confirm {		
        color: #434e65;
        width: 525px;
    }
    .modal-confirm .modal-content {
        padding: 20px;
        font-size: 16px;
        border-radius: 5px;
        border: none;
    }
    .modal-confirm .modal-header {
        background: #8a253e;
        border-bottom: none;   
        position: relative;
        text-align: center;
        margin: -20px -20px 0;
        border-radius: 5px 5px 0 0;
        padding: 35px;
    }
    .modal-confirm h4 {
        text-align: center;
        font-size: 36px;
        margin: 10px 0;
    }
    .modal-confirm .form-control, .modal-confirm .btn {
        min-height: 40px;
        border-radius: 3px; 
    }
    .modal-confirm .close {
        position: absolute;
        top: 15px;
        right: 15px;
        color: #fff;
        text-shadow: none;
        opacity: 0.5;
    }
    .modal-confirm .close:hover {
        opacity: 0.8;
    }
    .modal-confirm .icon-box {
        color: #fff;		
        width: 95px;
        height: 95px;
        display: inline-block;
        border-radius: 50%;
        z-index: 9;
        border: 5px solid #fff;
        padding: 15px;
        text-align: center;
    }
    .modal-confirm .icon-box i {
        font-size: 64px;
        margin: -4px 0 0 -4px;
    }
    .modal-confirm.modal-dialog {
        margin-top: 80px;
    }
    .modal-confirm .btn, .modal-confirm .btn:active {
        color: #fff;
        border-radius: 4px;
        background: #eeb711 !important;
        text-decoration: none;
        transition: all 0.4s;
        line-height: normal;
        border-radius: 30px;
        margin-top: 10px;
        padding: 6px 20px;
        border: none;
    }
    .modal-confirm .btn:hover, .modal-confirm .btn:focus {
        background: #eda645 !important;
        outline: none;
    }
    .modal-confirm .btn span {
        margin: 1px 3px 0;
        float: left;
    }
    .modal-confirm .btn i {
        margin-left: 1px;
        font-size: 20px;
        float: right;
    }
    .trigger-btn {
        display: inline-block;
        margin: 100px auto;
    }
    /*Css animation for close table body*/
    .flip{
	transform:rotate(-180deg);
    }
    .bxs-down-arrow{
        transition:0.4s;
    }
    thead tr th{
        vertical-align:middle;
    }
    /*box-shadow effect*/
    .tablePerInvoice thead tr:hover{
        background: var(--myPurple) !important;
    }
</style>
<body>
    <div class="">
        <div class="col d-flex justify-content-between py-2 px-4 border border-2 border-dark" style="background:var(--myOrange)">
            <h4 class="text-dark mb-0 px-3 py-2 rounded-2">Invoice Management</h4>
            <div class="button-group d-flex">
                <a id="sendPending" class="btn btn-dark d-flex align-items-center me-2"><i class="material-icons me-1">&#xe000;</i> <span>Pending</span></a>
                <a id="sendPaid" class="btn btn-success d-flex align-items-center"><i class="material-icons me-1">&#xe263;</i><span>Paid</span></a>
            </div>
        </div>
    </div>
    <div class="mt-3">
        <div class="row row-cols-lg-auto g-3 align-items-center mt-1">
            <div class="mt-1" style="min-width: 590px;">
                <form class="badge bg-blue fs-6 dateForm">
                    <label for="">Search By Date</label>
                    <input type="date" name="dateA" value="${dateA}" id="dateA">
                    <input type="date" name="dateB" value="${dateB}" id="dateB">
                    <button class="btn btn-danger btn-sm" id="searchByDate" type="button">Submit</button>
                </form>
            </div>
            <div class="mt-1" style="min-width: 432px;">
                <form class="badge bg-blue fs-6 nameForm">
                    <label for="">Search By Name</label>
                    <input type="text" placeholder="Enter name?" name="customerName" value="${customerName}" id="customerName">
                    <button class="btn btn-danger btn-sm" id="searchByName" type="button">Submit</button>
                </form>
            </div>
        </div>
    </div>
    <div class="mt-3">
        <div class="table-responsive">
            <table class="table table-borderless" id="invoiceTable" >
                <thead class="thisHeader">
                    <tr><th></th></tr>
                </thead>
                <tbody>
                    <c:forEach var="invoice" items="${listInvoice}" varStatus="parentLoop">
                        <tr class="border-0 m-0 p-0">
                            <th class="border-0 m-0 p-0">
                                <div class="table-responsive">
                                    <table class="table tablePerInvoice" >
                                        <thead class="text-dark">
                                            <tr class="bg-black text-white">
                                                <th colspan="2">Invoice ID: <span class="badge bg-warning text-dark fs-6">${invoice.invoiceID}</span></th>
                                                <th>Customer: <span class="badge bg-warning text-dark fs-6">${invoice.user.fullname}</span></th>
                                                <th>SDT: <span class="badge bg-warning text-dark fs-6">${invoice.phone}</span></th>
                                                <th>Date : <span class="badge bg-warning text-dark fs-6"><fmt:formatDate pattern = "dd-MM-yyyy" value = "${invoice.date}" /></span></th>
                                                <th colspan="3">Status: <span data-Status="${invoice.invoiceID}" class="statusClass
                                                    <c:if test="${invoice.status == 'Pending'}"> badge bg-danger text-white fs-6</c:if>
                                                    <c:if test="${invoice.status == 'Paid'}"> badge bg-success text-white fs-6</c:if>
                                                    ">${invoice.status}</span></th>
                                                <th class="text-end"><a onclick="confirmThisInvoice('${invoice.invoiceID}',this)" style="cursor:pointer" class="btn btn-primary <c:if test="${invoice.status == 'Paid'}">disabled</c:if>">Confirmed?</a><div class="btn btn-success ms-1" onclick="closeBody('${parentLoop.index}',this)"><i class='bx bxs-down-arrow' ></i></div></th>
                                                </tr>
                                        </thead>
                                        <tbody data-parentLoop="${parentLoop.index}" class="invoiceBody bg-white">
                                            <tr class="bg-aqua">
                                                <th>#</th><th>Category</th><th>Name</th><th>Color</th><th class="text-end">Price</th><th class="text-end">Quantity</th><th class="text-end">Total Price</th><th class="text-end">Discount</th><th class="text-end">Total Price After Discount</th>
                                            </tr>
                                            <c:forEach var="detail" items="${invoice.detailedInvoices}" varStatus="loop">
                                                <tr>
                                                    <th>${loop.index+1}</th>
                                                    <th>${detail.detailedProduct.product.category.name}</th>
                                                    <th>${detail.detailedProduct.product.name}</th>
                                                    <th>${detail.color}</th>
                                                    <th class="text-end"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${detail.detailedProduct.price}"/></th>
                                                    <th class="text-end">${detail.quantity}</th>
                                                    <th class="text-end"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${detail.detailedProduct.price * detail.quantity}"/></th>
                                                    <th class="text-end">${detail.detailedProduct.product.discount}%</th>
                                                    <th class="text-end"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${detail.price * detail.quantity}"/></th>
                                                </tr>
                                            </c:forEach>
                                            <tr class="bg-gray">
                                                <th colspan="7"><span class="badge bg-purple text-white fs-6">Notes: ${invoice.customernotes}</span></th>
                                                <th class="text-end"><span class="badge bg-dark fs-6">Total</span></th>
                                                <th class="text-end"><span class="badge bg-dark fs-6 text-warning"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${invoice.totalpayment}"/></span></th>
                                            </tr>
                                        </tbody>
                                        <!-- <tr class="bg-white border-0"><th colspan="9" class="border-0"></th></tr> -->
                                    </table>
                                </div>
                            </th>
                        </tr>   
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
<!-- Message Modal -->
<div id="myConfirmModal" class="modal confirmModal">
	<div class="modal-dialog modal-confirm">
		<div class="modal-content">
			<div class="modal-header justify-content-center">
				<div class="icon-box">
					<i class="material-icons">&#xe002;</i>
				</div>
				<button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body text-center">
					<h4>Are you sure you want to accept payment from this invoice?</h4>
					<button class="btn btn-success" data-bs-dismiss="modal" id="acceptInvoice"><span>OK</span> <i class="material-icons">&#xE5C8;</i></button>
				</div>
		</div>
	</div>
</div> 
<!-- Message Modal Edge -->

<script>
    var listTableBodies = $('.invoiceBody');
    $(document).ready(function() {
        $('[data-toggle="tooltip"]').tooltip();
        $(".thisHeader").toggle();
        var table = $('#invoiceTable').DataTable( {
    		"pageLenght": 4,
      	    "lengthMenu": [ 4, 8, 10, 40, 100 ],
            "searching":false
      	} );
        $(listTableBodies).toggle();
        $('#sendPending').click(function() {
            // location.href = '${pageContext.request.contextPath}/admin/invoice/?status=Pending&customerName=${customerName}&dateA=${dateA}&dateB=${dateB}';
            location.href = '${pageContext.request.contextPath}/admin/invoice/?condition=status&status=Pending';
        })
        $('#sendPaid').click(function() {
            // location.href = '${pageContext.request.contextPath}/admin/invoice/?status=Paid&customerName=${customerName}&dateA=${dateA}&dateB=${dateB}';
            location.href = '${pageContext.request.contextPath}/admin/invoice/?condition=status&status=Paid';
        })
        $('#searchByName').click(function() {
            var name = $('#customerName').val();
            // location.href = '${pageContext.request.contextPath}/admin/invoice/?status=${stats}&customerName='+name;
            location.href = '${pageContext.request.contextPath}/admin/invoice/?condition=name&customerName='+name;
        })
        $('#searchByDate').click(function() {
            var dateA= $('#dateA').val();
            var dateB= $('#dateB').val();
            if(dateA === ""){ 
                dateA = "2021-01-01"
            }
            if(dateB === ""){
                dateB = new Date().toISOString().slice(0, 10);
            }
            location.href = '${pageContext.request.contextPath}/admin/invoice/?condition=date&dateA='+dateA+'&dateB='+dateB;
        })

    })
    function closeBody(index,obj) {
        $(listTableBodies).each(function(){
            if($(this).attr('data-parentLoop') === index){
                $(this).toggle();
                $(obj).children().toggleClass('flip');
                $(obj).toggleClass('bg-red');
            }
        })
    }
    function confirmThisInvoice(invoiceID,thisBtn){
        var listStatus = $('.statusClass');
        $('#myConfirmModal').modal('show');
        $('#acceptInvoice').click(function(){
            $.ajax({
                type: "POST",
                url:'${pageContext.request.contextPath}/admin/invoice/'+invoiceID,
                async: true,
                success: function(res){
                    console.log(res);
                    $(listStatus).each(function(){
                        if($(this).attr('data-Status') === res){
                            $(this).text('Paid');
                            $(this).removeClass('bg-danger');
                            $(this).addClass('bg-success');
                            $(thisBtn).addClass('disabled');
                        }
                    })
                }
            })
        })
    }
</script>
