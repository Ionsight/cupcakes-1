<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="includes/header.jspf" %>
<h2>Create your own cupcake</h2>
<form method="get" action="order">
    <div class="row">
        <div class="col s12 no-padding">
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam viverra ex velit, quis mollis mauris
                feugiatac. Mauris magna quam, volutpat non nisi a, feugiat mollis turpis. Suspendisse luctus tellus id
                metus iaculis, non ultrices tellus laoreet. Cras lectus purus, lobortis vel lobortis non, hendrerit quis
                nisi.</p>
        </div>
        <div class="input-field col s12 no-padding">
            <select id="bottom-select" name="bottom">
                <option value="" disabled selected>Choose</option>
                <c:forEach items="${bottoms}" var="bottom">
                    <option value="${bottom.getId()}"
                            data-name="<c:out value="${bottom.getName()}"/>"
                            data-description="<c:out value="${bottom.getDescription()}"/>"
                            data-price="<c:out value="${bottom.getPrice()}"/>">
                        <c:out value="${bottom.getName()}"/>
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="col s12 custom-preview-container" id="bottom-preview-container">
            <div class="row">
                <div class="col s4">
                    <img class="custom-image-preview" id="bottom-preview-image" src="" alt="The selected bottom.">
                </div>
                <div class="col s8">
                    <h3 class="custom-preview-name" id="bottom-preview-name"></h3>
                    <p class="custom-preview-description" id="bottom-preview-description"></p>
                    <p class="custom-preview-price" id="bottom-preview-price"></p>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col s12 no-padding">
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam viverra ex velit, quis mollis mauris
                feugiatac. Mauris magna quam, volutpat non nisi a, feugiat mollis turpis. Suspendisse luctus tellus id
                metus iaculis, non ultrices tellus laoreet. Cras lectus purus, lobortis vel lobortis non, hendrerit quis
                nisi.</p>
        </div>
        <div class="input-field col s12 no-padding">
            <select id="topping-select" name="topping">
                <option value="" disabled selected>Choose</option>
                <c:forEach items="${toppings}" var="topping">
                    <option value="${topping.getId()}"
                            data-name="<c:out value="${topping.getName()}"/>"
                            data-description="<c:out value="${topping.getDescription()}"/>"
                            data-price="<c:out value="${topping.getPrice()}"/>"
                    ><c:out value="${topping.getName()}"/></option>
                </c:forEach>
            </select>
        </div>
        <div class="col s12 custom-preview-container" id="topping-preview-container">
            <div class="row">
                <div class="col s4">
                    <img class="custom-image-preview" id="topping-preview-image" src="" alt="The selected topping.">
                </div>
                <div class="col s8">
                    <h3 class="custom-preview-name" id="topping-preview-name"></h3>
                    <p class="custom-preview-description" id="topping-preview-description"></p>
                    <p class="custom-preview-price" id="topping-preview-price"></p>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <input class="button-submit btn-large place-custom-order-submit" type="submit" value="Place order"> <span
            class="price">Your total is $<span
            id="custom-total">0</span>.</span>
    </div>
</form>
<script>

    var current_total = 0;
    var bottom_price = 0;
    var topping_price = 0;

    var bottom_select = $('#bottom-select');
    var topping_select = $('#topping-select');

    bottom_select.material_select();
    topping_select.material_select();

    bottom_select.on('change', function (e) {
        var option = $('#bottom-select option[value="' + bottom_select.val() + '"]');
        $('#bottom-preview-image').attr("src", "images/bottoms/" + option.attr("value") + ".jpg");
        $('#bottom-preview-name').text(option.data("name"));
        $('#bottom-preview-description').text(option.data("description"));
        $('#bottom-preview-price').text(option.data("price"));
        $("#bottom-preview-container").show(800);

        bottom_price = parseInt(option.data("price"));
        current_total = bottom_price + topping_price;
        $("#custom-total").text(current_total);
    });

    topping_select.on('change', function () {
        var option = $('#topping-select option[value="' + topping_select.val() + '"]');
        $('#topping-preview-image').attr("src", "images/toppings/" + option.attr("value") + ".jpg");
        $('#topping-preview-name').text(option.data("name"));
        $('#topping-preview-description').text(option.data("description"));
        $('#topping-preview-price').text(option.data("price"));
        $("#topping-preview-container").show(800);

        topping_price = parseInt(option.data("price"));
        current_total = bottom_price + topping_price;
        $("#custom-total").text(current_total);
    });

</script>
<%@ include file="includes/footer.jspf" %>