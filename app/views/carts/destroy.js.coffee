cart = document.getElementById('cart')
cart.removeChild(cart.firstChild)
notice = document.getElementById('notice')
notice.innerHTML = "<%= flash[:notice] %>"
notice.style.display = "block"

