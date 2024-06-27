
// Show Hotels
function getHotels(){
    axios.get('http://egyvoyage2.somee.com/api/Hotel')
    .then(function (response) {
        let hotel = response.data;
        for (let i =0; i <hotel.length; i++) {
            // console.log(hotel[i].id)
            let content =`
            <div id="hotel${hotel[i].id}" class="col-sm-12 col-md-3 col-lg-4 pt-4">
                <a href="/admin/all-room.html?id=${hotel[i].id}&location=${hotel[i].location}" id=link>
                <div class="box mb-5">
                    <img style="height:250px; width:100%" id="hotel${hotel[i].id}" class="img-fluid" src="${hotel[i].image}" alt="">
                    <div class="text p-5">
                        <h4 class=" fs-5 fw-bold mb-3">${hotel[i].name}</h4>
                        <div class="rate mb-3 "><i class="filled fas fa-star me-2"></i><span class="hotel-rate">${hotel[i].rating} </span></div>
                            <span class="start">${hotel[i].location}</span>
                            <p class="mt-3">From<Span>$${hotel[i].price}</Span></p>
                </a>
                            <button onclick="addRoom(${hotel[i].id})" type="button" class="btn btn-primary px-3" id ="showBtn">Add Room</button>
                            <button style=" margin-left:10px;" onclick="edtHotel(${hotel[i].id})" type="button" class="btn btn-primary px-4" id ="edtBtn">Edit</button>    
                            <button onclick="deleteHotel(${hotel[i].id})" type="button" class="btn btn-danger px-3 ms-3">Delete</button>
                        </div>
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
getHotels()




// Edit Hotels
function edtHotel(Id){
    fetch(`http://egyvoyage2.somee.com/api/Hotel`)
    .then( (res)=> res.json())
    .then((response)=>{
        let hotel= response
        
        for (let i =0; i <hotel.length; i++) {
            if(hotel[i].id == Id){
                console.log(hotel[i])
                localStorage.setItem("id", Id)
                localStorage.setItem("name", hotel[i].name)    
                localStorage.setItem("description", hotel[i].description)   
                localStorage.setItem("location", hotel[i].location) 
                localStorage.setItem("cordinate", hotel[i].cordinate) 
                localStorage.setItem("map", hotel[i].map) 
                localStorage.setItem("rate", hotel[i].rating) 
                localStorage.setItem("day1", hotel[i].day1) 
                localStorage.setItem("day2",hotel[i].day2) 
                localStorage.setItem("day3", hotel[i].day3) 
                localStorage.setItem("image", hotel[i].image) 
            }
            window.location="/admin/edit-hotel.html"
        }
        
    })
    .catch(error =>{ 
        console.log(error); 
    })   
}


