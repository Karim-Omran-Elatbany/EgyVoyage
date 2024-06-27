const hotelData = JSON.parse(localStorage.getItem('hotelData'));
localStorage.clear();
console.log(hotelData);
for (let i = 0; i < hotelData.length; i++) {
  if (hotelData.length > 0) {
  let content = `
  <div class="col-sm-12 col-md-4 col-lg-4">
        <a href="/hotel-details.html?id=${hotelData[i].id}&location=${hotelData[i].location}" id=link>
        <div class="box mb-5">
          <img class="img-fluid hotel-image" src="${hotelData[i].image}" alt="">
          <div class="text p-5">
            <h4 class="fw-bold fs-5 mb-3 main-head">${hotelData[i].name}</h4>
            <div class="rate mb-3"><i class="filled fas fa-star"></i><span class="hotel-rate">${hotelData[i].rating}</span></div>
            <span class="hotel-location fs-5">${hotelData[i].location}</span>
            <p class="mt-3">From <Span class="hotel-price">$${hotelData[i].minprice}</Span></p>
          </div>
        </div>
      </a>
    </div>
  `
  document.querySelector("#search-hotel").innerHTML +=content;
  document.querySelector(".hotelAvaliable").style.display="none";
  }
}
