<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script src="https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js"></script>
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
    .error {
      color: red;
      font-weight: bold;
   }
</style>
<!-- Message Modal -->
<div id="myModal" class="modal messageModal">
	<div class="modal-dialog modal-confirm">
		<div class="modal-content">
			<div class="modal-header justify-content-center">
				<div class="icon-box">
					<i class="material-icons">&#xe002;</i>
				</div>
				<button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true" id="close1">&times;</button>
				</div>
				<div class="modal-body text-center">
					<h4>${sessionScope.message }</h4>
					<button class="btn btn-success" data-bs-dismiss="modal" id="close2"><span>OK</span> <i class="material-icons">&#xE5C8;</i></button>
				</div>
		</div>
	</div>
</div> 
<!-- Message Modal Edge -->
<!-- Confirmed Payment-->
<div class="modal fade " tabindex="-1" data-bs-backdrop="static" id="purchasedConfirm">
    <div class="modal-dialog modal-dialog-centered ">
      <form class="modal-content rounded-0 paymentModal" id="paymentModal" action="${pageContext.servletContext.contextPath}/detail/Cart/Payment" method="post">
        <div class="modal-header bg-orange">
          <h5 class="modal-title bg-green text-white fw-bold border border-1 border-white px-2 py-1">Making Payment</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeConfirmed1"></button>
        </div>
        <div class="modal-body bg-black text-white">
          <div class="form-group">
              <label for="">Phone number</label>
              <input type="text" class="form-control rounded-0" name="phone">
          </div>
          <div class="form-group">
              <label for="">Your address</label>
              <input type="text" class="form-control rounded-0" name="address">
          </div>
          <div class="form-group">
              <label for="">Your Notes</label>
              <textarea id="" cols="30" rows="3" class="form-control rounded-0" name="notes"></textarea>
          </div>
        </div>
        <div class="modal-footer bg-orange">
          <button type="button" class="btn btn-secondary border border-2 border-white rounded-0" data-bs-dismiss="modal" id="closeConfirmed2">Close</button>
          <button class="btn btn-primary border border-2 border-white rounded-0">Accept</button>
        </div>
      </form>
    </div>
  </div>
<!-- Confirmed Payment Edge-->
<script>
    $('.paymentModal').validate( {
    rules: {
        phone: {
        required:true,
        minlength:8,
        maxlength:15
      },
      address: {
        required: true,
        minlength: 4,
        maxlength:50
      },
    },
    messages: {
        phone: {
        required:"Phone number is required",
        minlength:"Phone number must be at least 8 characters",
        maxlength:"Phone number can not exceed 15 characters"
      },
      address: {
        required: "Address is required",
        minlength: "Address must be at least 4 characters",
        maxlength: "Address can not exceed 50 characters"
      },
    },
    submitHandler: function(form) {
      form.submit();
    }
  })
</script>