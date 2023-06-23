
// $(document).ready(function() {
//   // Hacer la solicitud AJAX al punto final para obtener el correo del usuario
//   $.ajax({
//     url: '/api/obtener-correo-usuario/',
//     dataType: 'json',
//     success: function(data) {
//       var correo = data.correo;
//       // Utiliza el correo del usuario como necesites
//       console.log(correo);
//     },
//     error: function(xhr, status, error) {
//       console.error(error);
//     }
//   });
// });


document.addEventListener('DOMContentLoaded', function () {
  // Hacer la solicitud AJAX al punto final para obtener el correo del usuario
  fetch('/api/obtener-correo-usuario/')
    .then(function (response) {
      if (response.ok) {
        return response.json();
      } else {
        throw new Error('Error en la solicitud');
      }
    })
    .then(function (data) {
      var correo = data.correo;
      // Utiliza el correo del usuario como necesites
      console.log(correo);

      // Capturar el evento de clic en el botón "Comprar"
      document.getElementById('btn-buy').addEventListener('click', function () {
        // Llamar a la función enviar_cupon con el correo del usuario
        enviar_cupon(correo);
      });
    })
    .catch(function (error) {
      console.log(error);
    });
});

var csrftoken = getCookie('csrftoken');

// Configurar el token CSRF en todas las solicitudes AJAX
$.ajaxSetup({
  beforeSend: function(xhr, settings) {
    if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
      xhr.setRequestHeader('X-CSRFToken', csrftoken);
    }
  }
});

// Función para obtener el valor de la cookie por su nombre
function getCookie(name) {
  var cookieValue = null;
  if (document.cookie && document.cookie !== '') {
    var cookies = document.cookie.split(';');
    for (var i = 0; i < cookies.length; i++) {
      var cookie = cookies[i].trim();
      if (cookie.substring(0, name.length + 1) === (name + '=')) {
        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
        break;
      }
    }
  }
  return cookieValue;
}

// Función para verificar si el método es seguro para CSRF
function csrfSafeMethod(method) {
  // estos métodos HTTP no requieren CSRF
  return /^(GET|HEAD|OPTIONS|TRACE)$/.test(method);
}

function enviar_cupon() {
  // Obtener el valor del cupón ingresado
  const couponInput = document.getElementById("coupon-input");
  // Obtén el correo del usuario desde algún elemento del DOM (por ejemplo, un input)
  var correo = document.getElementById('correo').value;
  // Obtener el token CSRF de la cookie
  // Verificar si el elemento existe antes de acceder a su propiedad 'value'
  if (couponInput) {
    const couponCode = couponInput.value.trim();
    // Realiza una solicitud AJAX para enviar el correo con el cupón
    $.ajax({
      url: '/enviar-cupon/',
      type: 'POST',
      data: {
        correo: correo
      },
      success: function (response) {
        console.log('Cupón enviado correctamente');
      },
      error: function (xhr, status, error) {
        console.log('Error al enviar el cupón', error);
      }
    });
  }
}

//  Cart
let cartIcon = document.querySelector("#cart-icon");
let cart = document.querySelector(".cart");
let closeCart = document.querySelector("#close-cart");
// Open Cart
cartIcon.onclick = () => {
  cart.classList.add("active");
};
// Close Cart
closeCart.onclick = () => {
  cart.classList.remove("active");
};

// Cart Working JS
if (document.readyState == "loading") {
  document.addEventListener("DOMContentLoaded", ready);
} else {
  ready();
}

// Making Function
function ready() {
  // Reomve Items From Cart
  var reomveCartButtons = document.getElementsByClassName("cart-remove");
  console.log(reomveCartButtons);
  for (var i = 0; i < reomveCartButtons.length; i++) {
    var button = reomveCartButtons[i];
    button.addEventListener("click", removeCartItem);
  }
  // Quantity Changes
  var quantityInputs = document.getElementsByClassName("cart-quantity");
  for (var i = 0; i < quantityInputs.length; i++) {
    var input = quantityInputs[i];
    input.addEventListener("change", quantityChanged);
  }
  // Add To Cart
  var addCart = document.getElementsByClassName("add-cart");
  for (var i = 0; i < addCart.length; i++) {
    var button = addCart[i];
    button.addEventListener("click", addCartClicked);
  }
  // Buy Button Work
  document
    .getElementsByClassName("btn-buy")[0].addEventListener("click", buyButtonClicked)
    .addEventListener("click", buyButtonClicked);
}
// Enviar cupon
function sendCouponEmail() {
  // Datos para el correo (puedes ajustar estos valores según tus necesidades)
  const recipientEmail = correo;
  const couponCode = "DESCUENTO123";

  // URL del servidor de MailDev para enviar correos
  const serverURL = "http://localhost:1080/";

  // Configurar los datos del correo
  const emailData = {
    from: "tucorreo@tudominio.com",
    to: recipientEmail,
    subject: "¡Cupón de descuento especial!",
    text: `Estimado cliente,

    Gracias por tu compra. Aquí tienes un cupón de descuento especial: ${couponCode}.

    ¡Disfrútalo y vuelve pronto!

    Saludos,
    Tu tienda online`,
  };

  // Configurar la solicitud POST al servidor de MailDev
  const requestOptions = {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(emailData),
  };

  // Enviar la solicitud POST al servidor de MailDev
  fetch(serverURL, requestOptions)
    .then((response) => {
      if (response.ok) {
        console.log("Correo enviado con éxito");
      } else {
        console.log("Error al enviar el correo");
      }
    })
    .catch((error) => {
      console.log("Error en la solicitud de envío de correo", error);
    });
  document
    .getElementsByClassName("btn-buy")[0].addEventListener("click", buyButtonClicked)
    .addEventListener("click", buyButtonClicked);
}
// Buy Button
function buyButtonClicked() {

  var cartContent = document.getElementsByClassName("cart-content")[0];
  while (cartContent.hasChildNodes()) {
    cartContent.removeChild(cartContent.firstChild);
  }
  updatetotal();
  // Verificar si hay 4 productos en el carrito
  const cartBoxes = document.getElementsByClassName("cart-box");
  if (cartBoxes.length === 4) {
    sendCouponEmail(); // Llamada a la función para enviar el correo con el cupón de descuento
  }
  // window.location.href = "https://khipu.com/payment/process/KcfsL";
  
  window.location.href = "http://127.0.0.1:8000/webpay-plus-create";
}

// Reomve Items From Cart
function removeCartItem(event) {
  var buttonClicked = event.target;
  buttonClicked.parentElement.remove();
  updatetotal();
}
// Quantity Changes
function quantityChanged(event) {
  var input = event.target;
  if (isNaN(input.value) || input.value <= 0) {
    input.value = 1;
  }
  updatetotal();
}
// Add To cart
function addCartClicked(event) {
  var button = event.target;
  var shopProducts = button.parentElement;
  var title = shopProducts.getElementsByClassName("product-title")[0].innerText;
  var price = shopProducts.getElementsByClassName("price")[0].innerText;
  var productImg = shopProducts.getElementsByClassName("product-img")[0].src;
  addProductToCart(title, price, productImg);
  updatetotal();
}
function addProductToCart(title, price, productImg) {
  var cartShopBox = document.createElement("div");
  cartShopBox.classList.add("cart-box");
  var cartItems = document.getElementsByClassName("cart-content")[0];
  var cartItemsNames = cartItems.getElementsByClassName("cart-product-title");
  for (var i = 0; i < cartItemsNames.length; i++) {
    if (cartItemsNames[i].innerText == title) {
      alert("Ya has agregado este Item al carro");
      return;
    }
  }
  var cartBoxContent = `
                        <img src="${productImg}" alt="" class="cart-img">
                        <div class="detail-box">
                            <div class="cart-product-title">${title}</div>
                            <div class="cart-price">${price}</div>
                            <input type="number" value="1" class="cart-quantity">
                        </div>
                        <!-- Remove Cart -->
                        <i class='bx bxs-trash-alt cart-remove' ></i>`;
  cartShopBox.innerHTML = cartBoxContent;
  cartItems.append(cartShopBox);
  cartShopBox
    .getElementsByClassName("cart-remove")[0]
    .addEventListener("click", removeCartItem);
  cartShopBox
    .getElementsByClassName("cart-quantity")[0]
    .addEventListener("change", quantityChanged);

  console.log("Producto agregado al carrito:");
  console.log("Título:", title);
  console.log("Precio:", price);
  console.log("Imagen:", productImg);
}

// Update Total
function updatetotal() {
  var cartContent = document.getElementsByClassName("cart-content")[0];
  var cartBoxes = cartContent.getElementsByClassName("cart-box");
  var total = 0;
  var totalQuantity = 0;
  for (var i = 0; i < cartBoxes.length; i++) {
    var cartBox = cartBoxes[i];
    var priceElement = cartBox.getElementsByClassName("cart-price")[0];
    var quantityElement = cartBox.getElementsByClassName("cart-quantity")[0];
    var price = parseFloat(priceElement.innerText.replace("$", ""));
    var quantity = parseInt(quantityElement.value) || 0;
    total = total + price * quantity;
    totalQuantity += quantity;
  }
  // If price Contain some Cents Value
  total = (total).toFixed(3); //cambiado para clp
  document.getElementsByClassName("total-price")[0].innerText = "$" + total;
  document.getElementById("cantidad-valor").innerText = totalQuantity;

}



// Variables globales para almacenar el monto adicional y el tipo de entrega seleccionado
let extraCharge = 0;
let deliveryType = '';

// Función para actualizar el monto adicional y el tipo de entrega
function updateExtraCharge() {
  const radioButtons = document.querySelectorAll('input[name="delivery"]');
  for (const radioButton of radioButtons) {
    radioButton.addEventListener('change', function () {
      if (this.checked) {
        deliveryType = this.value;
        updateTotal();
      }
    });
  }
}

// Función para actualizar el total
function updateTotal() {
  let total = 0;

  // Obtener los precios y cantidades de los productos en el carrito
  const cartBoxes = document.getElementsByClassName('cart-box');
  for (const cartBox of cartBoxes) {
    const priceElement = cartBox.getElementsByClassName('cart-price')[0];
    const quantityElement = cartBox.getElementsByClassName('cart-quantity')[0];

    const price = parseFloat(priceElement.innerText.replace('$', ''));
    const quantity = parseFloat(quantityElement.value);

    total += price * quantity;
  }

  // Agregar el monto fijo del despacho si se selecciona la opción "Despacho"
  if (deliveryType === 'shipping') {
    total += 4990;
  }

  // Actualizar el valor del total en el HTML
  document.getElementsByClassName('total-price')[0].innerText = '$' + total.toFixed(2);
}

// Llamar a la función para manejar los eventos
updateExtraCharge();

// Capturar el evento de clic en el botón "Comprar"
// Capturar el evento de clic en el botón "Aplicar"
document.getElementById("apply-coupon-btn").addEventListener("click", applyCoupon);

// Función para aplicar el cupón de descuento
function applyCoupon() {
  // Obtener el valor del cupón ingresado
  const couponInput = document.getElementById("coupon-input");
  const couponCode = couponInput.value.trim();

// Declarar y asignar un valor inicial a appliedCoupons
let appliedCoupons = [];


  // Verificar si el cupón ya ha sido aplicado
  if (appliedCoupons.includes(couponCode)) {
    // Cupón ya aplicado, mostrar mensaje de error o realizar otra acción
    console.log("Este cupón ya ha sido utilizado");
    return;
  }
  // Aquí debes agregar la lógica para verificar el cupón y aplicar el descuento correspondiente
  // Puedes consultar una base de datos o una lista de cupones válidos para validar el código ingresado
  // Si el cupón es válido, puedes aplicar el descuento al total
  // Ejemplo:
  if (couponCode === "DESCUENTO10") {
    // Aplicar descuento del 10%
    const totalElement = document.getElementsByClassName("total-price")[0];
    const total = parseFloat(totalElement.innerText.replace("$", ""));
    const discountedTotal = total - (total * 0.1); // 10% de descuento
    totalElement.innerText = "$" + discountedTotal.toFixed(2);

    // Actualizar el valor del cupón en el campo de entrada
    couponInput.value = couponCode;
    // Agregar el cupón a la lista de cupones aplicados
    appliedCoupons.push(couponCode);

    // Desactivar el botón de aplicar cupón
    const applyButton = document.getElementById("apply-coupon-btn");
    applyButton.disabled = true;
  } else {
    // Cupón inválido, mostrar un mensaje de error o realizar otra acción
    console.log("Cupón inválido");
  }
}


// Obtener el descuento del cupón (puedes ajustar esta lógica según tus necesidades)
const couponDiscount = 0.1; // 10% de descuento

// Calcular el total con el descuento del cupón, si corresponde
const totalElement = document.getElementsByClassName("total-price")[0];
let total = parseFloat(totalElement.innerText.replace("$", ""));

if (couponDiscount > 0) {
  total -= total * couponDiscount;
}

// Mostrar el total actualizado en el HTML
totalElement.innerText = "$" + total.toFixed(2);
