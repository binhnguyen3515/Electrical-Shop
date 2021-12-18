<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js"></script>
<style>
  .error {
      color: red;
      font-weight: bold;
   }
   #favListTable tbody tr th{
    vertical-align: middle;
   }
   /* custom scrollbar*/
  .modal-body::-webkit-scrollbar{
      width: 0.5rem;
    }
  .modal-body::-webkit-scrollbar-track{
  background: var(--myBlack);
  }
  .modal-body::-webkit-scrollbar-thumb{
  background: var(--myOrange);
  }
  /* custom scrollbar edge*/
</style>
<!--Profile User Modal-->
<div id="profileModal" class="modal fade" tabindex="-1" data-bs-backdrop="static" aria-hidden="true">
  <form:form action="${pageContext.servletContext.contextPath}/updateProfile" modelAttribute="profile" method="post" enctype="multipart/form-data" class="modal-dialog modal-dialog-centered updateProfile" style="max-width: 600px" >
    <div class="modal-content border border-1 border-white">
      <div class="modal-header bg-purple text-white">
        <h5 class="modal-title">Profile Info</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body bg-black text-white">
        <div class="form-group row">
          <div class="col-4">
            <div class="form-group">
              <label for="">Current Avatar</label>
              <c:if test="${not empty sessionScope.loginInfo}">
              	<img src="${pageContext.servletContext.contextPath}/home/userAvatar/${sessionScope.loginInfo.photo}" alt="" height="165px" width="165px" style="border: 5px solid #60b7f1;">
              </c:if>
            </div>
          </div>
          <div class="col-8">
            <div class="form-group">
              <form:input path="userID" type="hidden" id="userID" value="${sessionScope.loginInfo.userID}"/>
              <form:input path="role" type="hidden" value="${sessionScope.loginInfo.role}"/>
              <label for="">Name</label>
              <form:input path="fullname" value="${sessionScope.loginInfo.fullname}" class="form-control bg-white fw-bold" placeholder="Enter your name?"/>
            </div>
            <div class="form-group my-1">
              <label for="">Password</label>
              <form:input path="password" value="${sessionScope.loginInfo.password}" class="form-control bg-white fw-bold" placeholder="Enter your password?" type="password"/>
           </div>
            <div class="form-group my-1">
                <label for="">Email</label>
                <form:input path="email" value="${sessionScope.loginInfo.email}" class="form-control bg-white fw-bold" placeholder="Enter your email?"/>
            </div>
          </div>
        </div>
        
       
       <div class="form-group my-1">
          <label for="">Phone</label>
          <form:input path="phone" value="${sessionScope.loginInfo.phone}" class="form-control bg-white fw-bold" placeholder="Enter your phone?"/>
       </div>
       <div class="form-group my-1">
          <label for="">Address</label>
          <form:input path="address" value="${sessionScope.loginInfo.address}" class="form-control bg-white fw-bold" placeholder="Enter your address?"/>
        
       </div>
       <div class="form-group my-1">
          <label for="">Gender</label>
          <div class="form-control bg-yellow text-dark fw-bold">
              <form:radiobuttons path="gender" items="${listGender}" class="ms-2 me-1 " demiliter=" "/>
          </div>
       </div>
       <div class="form-group">
           <label for="">Choose New Avatar</label>
           <input id="input-b6a" name="input-b6a[]" type="file" multiple>
       </div>
      </div>
      <div class="modal-footer bg-gray">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        <button class="btn btn-success">Save Changes</button>
      </div>
    </div>
  </form:form>
</div>
<!--Profile User Modal Edge-->

<!-- Your order table-->
<div class="modal fade " tabindex="-1" data-bs-backdrop="static" id="yourOrders">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" style="min-width: 1500px;">
    <form class="modal-content rounded-0" id="paymentModal" action="${pageContext.servletContext.contextPath}/detail/Cart/Payment" method="post">
      <div class="modal-header bg-black border border-1 border-white">
        <h3 class="modal-title text-white fw-bold px-2 py-1">Shopping Log</h3>
        <button type="button" class="btn-close bg-danger" data-bs-dismiss="modal" aria-label="Close" id="closeConfirmed3"></button>
      </div>
      <div class="modal-body bg-gray">
            <div class="card border-0">
              <div class="card-header bg-blue border border-2 border-dark rounded-0">
                <div class="card-title d-flex align-items-center text-white">
                  <img src="${pageContext.servletContext.contextPath}/home/userAvatar/${sessionScope.loginInfo.photo}" class="rounded-circle border border-3 border-white" height="60px" width="60px" >
                  <h3 class="mb-0 mx-3">[${sessionScope.loginInfo.userID}]</h3>
                  <h3 class="mb-0">[${sessionScope.loginInfo.fullname}]</h3>
                </div>
              </div>
                <c:catch>
                <div class="card-body p-0">
                  <table class="table table-borderless mb-0">
                      <thead class="bg-gray"><tr><th colspan="8"></th></tr></thead>
                      <c:choose>
                        <c:when test="${not empty sessionScope.logStatus && sessionScope.logStatus == 'There is no item in your payment history'}">
                          <h3>${sessionScope.logStatus}</h3>
                        </c:when>
                        <c:when test="${not empty sessionScope.logStatus && sessionScope.logStatus == 'hasItem'}">
                          <c:forEach items="${listPayment}" var="item" varStatus="loop">
                            <thead>
                                <tr class="bg-black text-white">
                                    <th colspan="2">Invoice ID: <span class="badge bg-warning text-dark fs-6">${item.invoiceID}</span></th>
                                    <th colspan="2">Date : <span class="badge bg-warning text-dark fs-6"><fmt:formatDate pattern = "dd-MM-yyyy" value = "${item.date}" /></span></th>
                                    <th colspan="3"></th>
                                    <th colspan="1" class="text-end <c:if test="${item.status == 'Pending'}">bg-danger</c:if>
                                      <c:if test="${item.status == 'Paid'}">bg-success</c:if>">Status: ${item.status}</th>
                                  </tr>
                            </thead>
                            <tbody>
                                <tr class="bg-aqua">
                                  <th>#</th><th>Category</th><th>Name</th><th>Color</th><th class="text-end">Price</th><th class="text-end">Quantity</th><th class="text-end">Discount</th><th class="text-end">Total Price After Discount</th>
                                </tr>
                                <c:forEach var="item2" items="${listPayment.get(loop.index).getDetailedInvoices()}" varStatus="loop2">
                                <tr>
                                    <th>${loop2.index+1}</th>
                                    <th>${item2.detailedProduct.product.category.name}</th>
                                    <th>${item2.detailedProduct.product.name}</th>
                                    <th>${item2.color}</th>
                                    <th class="text-end"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${item2.detailedProduct.price}"/></th>
                                    <th class="text-end">${item2.quantity}</th>
                                    <th class="text-end">${item2.detailedProduct.product.discount}%</th>
                                    <th class="text-end"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${item2.price * item2.quantity}"/></th>
                                </tr>
                                </c:forEach>
                                <tr class="bg-green text-white">
                                  <th class="text-end" colspan="7">Total:</th><th class="text-end"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${item.totalpayment}"/></th>
                                </tr>
                                <tr class="bg-gray"><th colspan="8"></th></tr>
                            </tbody>
                      </c:forEach>
                        </c:when>
                      </c:choose>
                  </table>
                </div>
              </c:catch>
              
            </div>
      </div>
      <div class="modal-footer bg-black">
        <button type="button" class="btn btn-warning border border-2 border-white rounded-0" data-bs-dismiss="modal" id="closeConfirmed4">Close</button>
      </div>
    </form>
  </div>
</div>
<!-- Your order table Edge-->
<!-- Your favorite List-->
<div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" id="yourFavoriteList">
  <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered" style="min-width: 800px;">
    <div class="modal-content border border-1 border-white">
      <div class="modal-header bg-dark text-white ">
        <h5 class="modal-title">Your Favorite Product List</h5>
        <button type="button" class="btn-close btn-danger text-danger" data-bs-dismiss="modal" aria-label="Close" id="closeConfirmed5"></button>
      </div>
      <div class="modal-body bg-gray">
        <table class="table mb-0" id="favListTable">
          <c:catch>
            <c:choose>
              <c:when test="${not empty sessionScope.favoriteListLog && sessionScope.favoriteListLog == 'There is no item in your favorite product list'}">
                <thead class="mainColor text-white">
                  <h3>${sessionScope.favoriteListLog}</h3>
                </thead>
              </c:when>  
                <c:when test="${not empty sessionScope.favoriteListLog && sessionScope.favoriteListLog == 'has List'}">
                <thead class="mainColor text-white">
                  <tr><th>#</th><th>Picture</th><th>Name</th><th>Brand</th><th class="text-end">Action</th></tr>
                </thead>
                <tbody class="bg-white">
                  <c:forEach var="favList" items="${sessionScope.favoriteList}" varStatus="loopFav">
                    <tr>
                      <th>${loopFav.index+1}</th>
                      <th><img src="${pageContext.servletContext.contextPath}/home/ProductImages/${favList.product.category.name}/${favList.product.picture }" height="60px"/></th>
                      <th>${favList.product.name}</th>
                      <th>${favList.product.brand}</th>
                      <th class="text-end">
                          <a class="btn btn-danger" onclick="removeFromFavList('${favList.product.productID}',this)" id="removeFromFavList">Remove</a>
                          <a class="btn btn-success" href="${pageContext.servletContext.contextPath}/detail/${favList.product.productID}">Search</a>
                      </th>
                    </tr>
                  </c:forEach>
                </tbody>
              </c:when>
            </c:choose>
          </c:catch>
        </table>
      </div>
      <div class="modal-footer bg-dark">
        <button type="button" class="btn btn-warning" data-bs-dismiss="modal" id="closeConfirmed6">Close</button>
        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div>
  </div>
</div>
<!-- Your favorite List Edge-->

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
  $('.updateProfile').validate( {
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
    console.log('${sessionScope.loginInfo.gender}');
    if('${sessionScope.loginInfo.gender}' === 'true'){
        $('#gender1').prop('checked',false);
        $('#gender2').prop('checked',true);
    }else{
        $('#gender1').prop('checked',true);
        $('#gender2').prop('checked',false);
    }
    
    $("#input-b6a").fileinput({
		        showUpload: false,
		        dropZoneEnabled: false,
		        maxFileCount: 1,
		        inputGroupClass: "input-group-md"
	  });
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
  
  function removeFromFavList(id,obj){
    $(obj).parent().parent().remove();
    $.ajax({
        type: "Get",
        url:"${pageContext.servletContext.contextPath}/detail/Cart/removeFromFavList/"+id,
        async: true,
        success:function(data){
            console.log('data: '+data);
            if(data === 'ok'){
                $('#yourOrders').modal('show');
            }
        }
    })
  }
</script>
<!--Profile Modal Edge-->

<!-- Input File-->

<!-- alternatively you can use the font awesome icon library if using with `fas` theme (or Bootstrap 4.x) by uncommenting below. -->
<!-- link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" crossorigin="anonymous" -->

<!-- the fileinput plugin styling CSS file -->
<link href="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />

<!-- if using RTL (Right-To-Left) orientation, load the RTL CSS file after fileinput.css by uncommenting below -->
<!-- link href="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/css/fileinput-rtl.min.css" media="all" rel="stylesheet" type="text/css" /-->

<!-- piexif.min.js is needed for auto orienting image files OR when restoring exif data in resized images and when you
    wish to resize images before upload. This must be loaded before fileinput.min.js -->
<script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/plugins/piexif.min.js" type="text/javascript"></script>

<!-- sortable.min.js is only needed if you wish to sort / rearrange files in initial preview. 
    This must be loaded before fileinput.min.js -->
<script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/plugins/sortable.min.js" type="text/javascript"></script>

<!-- bootstrap.bundle.min.js below is needed if you wish to zoom and preview file content in a detail modal -->

<!-- the main fileinput plugin script JS file -->
<script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/fileinput.min.js"></script>
<!-- Input File Edge -->

