<ul class="list-group">
    <li class="list-group-item active rounded-0" aria-current="true"><s:message code="sidebar.sortByRange"/></li>
    <li class="list-group-item rounded-0 priceRange" data-min="0" data-max="500000">0 - 500.000</li>
    <li class="list-group-item rounded-0 priceRange" data-min="500000" data-max="1000000">500.000 - 1.000.000</li>
    <li class="list-group-item rounded-0 priceRange" data-min="1000000" data-max="3000000">1.000.000 - 3.000.000</li>
    <li class="list-group-item rounded-0 priceRange" data-min="3000000" data-max="5000000">3.000.000 - 5.000.000</li>
    <li class="list-group-item rounded-0 priceRange" data-min="5000000" data-max="10000000">5.000.000 - 10.000.000</li>
    <li class="list-group-item rounded-0 priceRange" data-min="10000000" data-max="20000000">10.000.000 - 20.000.000</li>
    <li class="list-group-item rounded-0 priceRange" data-min="20000000" data-max="10000000000">Above 20.000.000</li>
</ul>
<ul class="list-group my-2">
  <li class="list-group-item active rounded-0" aria-current="true"><s:message code="sidebar.sortByCategories"/></li>
  <c:forEach var="item" items="${cateGoryList}">
    <li class="list-group-item rounded-0 sideMenuCategory" data-cateID="${item.categoryID}">${item.name}</li>
  </c:forEach>
</ul>
<ul class="list-group my-2">
   <li class="list-group-item active rounded-0" aria-current="true"><s:message code="sidebar.sortByName"/></li>
   <li class="list-group-item rounded-0 sizeMenuA-Z" data-a-z="nameDESC">Z -> A</li>
   <li class="list-group-item rounded-0 sizeMenuA-Z" data-a-z="nameASC">A -> Z</li>
</ul>
 <ul class="list-group my-2">
    <li class="list-group-item active rounded-0" aria-current="true"><s:message code="sidebar.sortByDiscount"/></li>
    <li class="list-group-item rounded-0 sizeMenuA-Z" data-a-z="discountDESC">High to low</li>
    <li class="list-group-item rounded-0 sizeMenuA-Z" data-a-z="discountASC">Low to high</li>
</ul>
 <ul class="list-group my-2 ">
     <li class="list-group-item rounded-0 active" aria-current="true"><s:message code="sidebar.sortByCustom"/></li>
     <li class="list-group-item rounded-0" id="min-max-Search">
         <form>
             <label for="">Min price</label><input type="number" class="form-control bg-gray fw-bold minPriceInput" required min="0">
             <label for="">Max price</label><input type="number" class="form-control bg-gray fw-bold maxPriceInput" required min="0">
             <div class="form-group">
                 <input class="btn mainColor text-white  mt-3 mx-auto w-100 fw-bold" type="button" id="searchBoxPriceRange" value="Seach">
             </div>
         </form>
     </li>
</ul>
<script>
    $(document).ready(function(){
        var dropdownCategories = $('.dropdownCategory,.sideMenuCategory');
        $(dropdownCategories).click(function(){
            var cateID = $(this).attr('data-cateID');
            var getNum = $('#inputGroupSelect02').val();
            window.location = "${pageContext.request.contextPath}/?sortBy="+cateID+"&showByNumber="+getNum+"&min="+"123696978966989"+"&max="+"123696978966989";
        })
        //price range
        var listPriceRange = $('.priceRange');
        $(listPriceRange).click(function(){
            console.log("running1");
            var minValue = $(this).attr('data-min');
            var maxValue = $(this).attr('data-max');
            var getNum = $('#inputGroupSelect02').val();
            window.location = "${pageContext.request.contextPath}/?sortBy=all"+"&showByNumber="+getNum+"&keywords="+"&min="+minValue+"&max="+maxValue;
        })
        $('#searchBoxPriceRange').click(function(){
            var minValue = $('.minPriceInput').val();
            var maxValue = $('.maxPriceInput').val();
            if(minValue < 0){
                $('.minPriceInput').val(0);
                minValue = 0;
                return;
            }
            if(maxValue < 0){
                $('.maxPriceInput').val(0);
                maxValue = 0;
                return;
            }
            console.log({minValue, maxValue});
            var getNum = $('#inputGroupSelect02').val();
            window.location = "${pageContext.request.contextPath}/?sortBy=all"+"&showByNumber="+getNum+"&keywords="+"&min="+minValue+"&max="+maxValue;
        })
        var sortByA_Z = $('.sizeMenuA-Z')
        $(sortByA_Z).click(function(){
            var sortByA_Z = $(this).attr('data-a-z');
            var getNum = $('#inputGroupSelect02').val();
            window.location = "${pageContext.request.contextPath}/?sortByA_Z="+sortByA_Z+"&showByNumber="+getNum;
        })
    })
</script>