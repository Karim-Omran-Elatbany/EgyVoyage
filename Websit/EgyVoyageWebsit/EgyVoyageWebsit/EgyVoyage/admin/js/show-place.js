function getPlaces(){
    axios.get('http://egyvoyage2.somee.com/api/Place')
    .then(function (response) {
        let place= response.data;
        for (let i =0; i <place.length; i++) {
            console.log(place[i])
            let content =`
            <div id="place${place[i].id}" class="col-sm-12 col-md-4 col-lg-4 pt-3">
                <div  class="box mb-5">
                    <img style="height:250px; width:100%;"  class="img-fluid" src="${place[i].image}" alt="">
                    <div class="text p-5">
                        <h1 class=" fs-5 fw-bold mb-3">${place[i].name}</h1>
                        <div class="rate mb-3 "><i class="filled fas fa-star me-2"></i><span class="hotel-rate">${place[i].rating} </span></div>
                        <span class="start">${place[i].city}</span>
                        <p class="mt-3">From<Span>$${place[i].tourist_price}</Span></p>
                        <button onclick="edtPlace(${place[i].id})" type="button" class="btn btn-primary px-4" id ="edtBtn">Edit</button>    
                        <button onclick="deletePlace(${place[i].id})" type="button" class="btn btn-danger px-3 ms-3">Delete</button>
                    </div>
                </div>
            </div> `
            document.querySelector(".row").innerHTML += content;
        }     
    })
    .catch(function (error) {
        console.log(error);
    })
};
getPlaces()




// Edit Places
function edtPlace(id){
    axios.get('http://egyvoyage2.somee.com/api/Place')
    .then(function (response) {
        let place = response.data;
        for (let i =0; i <place.length; i++) {

            if(place[i].id == id){
            console.log(place[i].end)
            localStorage.setItem("id", id)
            localStorage.setItem("name", place[i].name)  
            localStorage.setItem("description", place[i].description)   
            localStorage.setItem("location", place[i].url_location) 
            localStorage.setItem("cordinate", place[i].cordinate) 
            localStorage.setItem("rate", place[i].rating) 
            localStorage.setItem("city", place[i].city) 
            localStorage.setItem("price", place[i].tourist_price)
            localStorage.setItem("Stime", place[i].start)
            localStorage.setItem("Etime", place[i].end)
            localStorage.setItem("image", place[i].image) 
            window.location="/admin/edit-place.html"
            break;
        }
        }
    })
    .catch(function (error) {
        console.log(error);
    })
};