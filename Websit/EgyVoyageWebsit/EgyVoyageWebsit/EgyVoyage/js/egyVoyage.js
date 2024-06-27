
async function readData () {
  console.log("Before Fetch");
  try {
    let response = await fetch ("http://egyvoyage2.somee.com/api/Hotel");
    let data = await response.json();
    for (let i =0; i < data.length; i++) {
      let content = `
        <div class="col-sm-12 col-md-6 col-lg-4">
        <a href="/hotel-details.html?id=${data[i].id}&location=${data[i].location}" id=liink>
          <div class="box mb-5">
            <img class="img-fluid hotel-image" src="${data[i].image}" alt="">
            <div class="text p-5">
              <h4 class="fw-bold fs-5 mb-3 main-head">${data[i].name}</h4>
              <div class="rate mb-3"><i class="filled fas fa-star"></i><span class="hotel-rate">${data[i].rating}</span></div>
              <span class="hotel-location">${data[i].location}</span>
              <p class="mt-3">From <Span class="hotel-price">$${data[i].price}</Span></p>
            </div>
          </div>
        </a>
      </div>
      `;
      document.querySelector(".main-hotels").innerHTML +=content;
    }
    console.log(data); 
  } catch(reason) {
    console.log(`Erorr ${reason}`);
  } finally {
    console.log("After Fetch")
  }
}
readData();

