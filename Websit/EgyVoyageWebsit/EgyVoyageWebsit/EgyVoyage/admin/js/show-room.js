function showRoom(){
    window.location="/admin/all-room.html"
}


const url = window.location.href;
function extractParamValue(url) {
    return function(parameterName) {
        const queryString = url.split('?')[1];
        if (queryString) {
            const queryParams = new URLSearchParams(queryString);
            if (queryParams.has(parameterName)) {
                return queryParams.get(parameterName);
            }
        }
        return null;
    };
}
let getParamValue = extractParamValue(url);
const idValue = getParamValue('id');
const locationValue = getParamValue('location');




function getRooms() {
    
    axios.get('http://egyvoyage2.somee.com/api/Room')
    .then(function (response) {
        let room = response.data
        for (let i = 0; i < room.length; i++) {
            if(room[i].hotel_id == idValue){
                let content = `
                <div id="room${room[i].id}" class=" row">
                    <div class="col-lg-12 mb-5">
                        <div class="room-prop">
                            <h4 class="mb-4 primary-heading fs-5">${room[i].name}</h4>
                            <h6 class="room-price mb-5"><span>${room[i].price}</span>$ /night</h6>
                            <div class="text">
                                <ul class="list-unstyled d-flex justify-content-between  mb-5 f">
                                    <li><i class="fa-solid fa-bed me-2 text-black-0"></i><span id="beds-number"> ${room[i].category}</span></li>
                                    <li><i class="fa-solid fa-people-group me-2"></i><span id="guests-number">Max Guests : ${room[i].capacity}</span></li>
                                    <li><i class="fa-regular fa-square me-2"></i><span id="space">30</span><span>sqm</span></li>
                                    <li><i class="fa-solid fa-city me-2"></i><span id="view-prop">City View</span></li>
                                </ul>
                                <div class="amenities d-flex">
                                    <div class="image"><img src=${room[i].image} class=" m" alt=""></div>
                                    <ul class="list-unstyled d-flex ">
                                        <li data-amenity="Free Wifi" style="height:70px;"><i class="fa-solid fa-wifi me-4"></i>Free Wifi</li>
                                        <li data-amenity="Smoking" style="height:70px;"><i class="fa-solid fas fa-smoking me-4"></i>Smoking</li>
                                        <li data-amenity="None Smoking" style="height:70px;"><i class="fa-solid fas fa-smoking-ban me-4"></i>None Smoking</li>
                                        <li data-amenity="Breakfast" style="height:70px;"><i class="fa-solid fas fa-utensils me-4"></i>Breakfast</li>
                                    </ul>
                                </div>
                                <div class="row">
                                    <button onclick=" edtroom(${room[i].id})"  type="button" class="btn btn-primary px-4" id ="edtBtn">Edit</button>    
                                    <button onclick="deleteRoom(${room[i].id})" type="button" class="btn btn-danger px-3 ms-3">Delete</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                ` 
                document.querySelector(".Room").innerHTML += content;
            }
        }
        getAmenities();
    }) .catch(function (error) {
        console.log(error);
    })
}


function getAmenities() {
    axios.get('http://egyvoyage2.somee.com/api/Room')
    .then(function (response) {
        const rooms = response.data;
        rooms.forEach(room => {
            const amenities = { 
                'Free Wifi': room.freeWifi,
                'Smoking': room.smoking,
                'None Smoking':! room.smoking,
                'Breakfast': room.breakfast,
            };
            const roomElement = document.querySelector(`#room${room.id} .amenities ul`);
            if (roomElement) {
                roomElement.querySelectorAll('li').forEach(item => {
                    const amenity = item.getAttribute('data-amenity');
                    if (amenities[amenity]) {
                        item.style.display = 'block';
                    } else {
                        item.style.display = 'none';
                    }
                });
            }
        });
        localStorage.clear()
    })
    .catch(function (error) {
        console.log(error);
    });
}
getRooms();





// Edit Rooms
function edtroom(id){
    axios.get('http://egyvoyage2.somee.com/api/Room')
    .then(function (response) {
        let room = response.data;
        // console.log(room)
        for (let i =0; i <room.length; i++) {
            if(room[i].id == id){
                // console.log(room[i])

                localStorage.setItem("id", room[i].id)
                localStorage.setItem("hotelId" , room[i].hotel_id)
                localStorage.setItem("hotelName" , room[i].hotelname)
                localStorage.setItem("name", room[i].name)  
                localStorage.setItem("price", room[i].price)
                localStorage.setItem("guest", room[i].capacity)
                localStorage.setItem("breakfast", room[i].breakfast)
                localStorage.setItem("freeWifi", room[i].freeWifi)
                localStorage.setItem("smoking", room[i].smoking)
                localStorage.setItem("category", room[i].category)
                localStorage.setItem("image", room[i].image)
                // console.log(room[i].image)
                window.location="/admin/edit-room.html"
                break;
            }
        }
    })
    .catch(function (error) {
        console.log(error);
    })
};





