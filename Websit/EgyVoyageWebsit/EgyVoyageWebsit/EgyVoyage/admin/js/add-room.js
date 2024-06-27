
// function addRoom(id){
//     localStorage.setItem("id", id)
//     window.location="/admin/add-room.html"
// }

// const addrombtn= document.getElementById('addBtn');
// addrombtn.addEventListener('click', function(event) {
//     event.preventDefault(); 
//     let id = localStorage.getItem('id')
//     let name = document.getElementById('nameOfRoom').value
//     let category = document.getElementById('categoryOfRoom').value
//     let price = document.getElementById('priceOfRoom').value
//     let guest = document.getElementById('guestOfRoom').value
//     let freewifi = document.getElementById('checkbox3').value
//     let smoking = document.getElementById('checkbox2').value
//     let breakfast = document.getElementById('checkbox1').value
//     let image= document.getElementById('imgOfRoom').files[0]
//     console.log(id ,freewifi , breakfast , smoking )
    
//     let formData = new FormData()
//     formData.append("Name", name )
//     formData.append("category", category )
//     formData.append("price", price)
//     formData.append("HotelId", id)
//     formData.append("capacity", guest )
//     formData.append("imagefile", image )
//     formData.append("freeWifi", freewifi )
//     formData.append("smoking", smoking )
//     formData.append("breakfast", breakfast )
    

//     fetch("http://egyvoyage.somee.com/api/Room", {
//         method: "POST",
//         body: formData ,
//     })
//     .then((res) =>
//     { 
//         console.log(res)
//         // clearData()
//         // showSuccessAlert("Place added successfully")               
//     })
//     .catch(error =>{
//         console.log(error)
//     })
// });










// function check() {
//     document.getElementById("checkbox").checked = true;
//     document.getElementById("checkbox").checked = false;
// }

// function addRoom(id){
//     localStorage.setItem("id", id)
//     window.location="/admin/add-room.html"
// }

// const addrombtn= document.getElementById('add-room-btn');
// addrombtn.addEventListener('click', function(evnt) {
//     evnt.preventDefault(); 
//     let id = localStorage.getItem('id')
//     let name = document.getElementById('nameOfRoom').value
//     let price = document.getElementById('priceOfRoom').value
//     let category = document.getElementById('categoryOfRoom').value
//     let capacity = document.getElementById('guestOfRoom').value
//     let freewifi = document.getElementById('checkbox3').checked
//     let smoking = document.getElementById('checkbox2').checked
//     let breakfast = document.getElementById('checkbox1').checked
//     let image= document.getElementById('imgOfRoom').files[0]
    


    
    
//     let formData = new FormData()
//     formData.append("Name", name )
//     formData.append("category", category )
//     formData.append("price", price)
//     formData.append("HotelId", id)
//     formData.append("capacitycity", capacity )
//     formData.append("imagefile", image )
//     formData.append("freeWifi", freewifi )
//     formData.append("smoking", smoking )
//     formData.append("breakfast", breakfast )
    

//     fetch("http://egyvoyage2.somee.com/api/Room", {
//         method: "POST",
//         body: formData ,
//     })
//     .then((res) =>
//     { 
//         console.log(res)
//         clearData()
//         showSuccessAlert("Room added successfully")               
//     })
//     .catch(error =>{
//         console.log(error)
//     })
// });

// function clearData(){
//     document.getElementById('nameOfRoom').value=''
//     document.getElementById('priceOfRoom').value=''
//     document.getElementById('categoryOfRoom').value=''
//     document.getElementById('guestOfRoom').value=''
//     document.getElementById('checkbox3').checked=''
//     document.getElementById('checkbox2').checked=''
//     document.getElementById('checkbox1').checked =''
//     document.getElementById('imgOfRoom').value=''
// }

// function showSuccessAlert(alart){
//     const alertPlaceholder = document.getElementById('success-alart')
//     const appendAlert = (message, type) => {
//     const wrapper = document.createElement('div')
//     wrapper.innerHTML = [
//     `<div class="alert alert-${type} alert-dismissible" role="alert">`,
//         `  <div>${message}</div>`,
//         '  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
//     '</div>'
//     ].join('')
//     alertPlaceholder.append(wrapper)
// }
// appendAlert(alart, 'success')       
// }




function check() {
    document.getElementById("checkbox").checked = true;
    document.getElementById("checkbox").checked = false;
}

function addRoom(id){
    localStorage.setItem("id", id)
    window.location="/admin/add-room.html"
}
document.getElementById('addRoomForm').addEventListener('submit', function(event) {
    event.preventDefault();
    const inputs = document.querySelectorAll('#addRoomForm input[required]');
    let isValid = true;
    inputs.forEach(input => {
        const messageElement = input.nextElementSibling;
        if (!input.value.trim()) {
            messageElement.textContent = 'Please fill in this field';
            messageElement.style.color = 'red';
            isValid = false;
        } else {
            messageElement.textContent = '';
        }
        });

    if (!isValid) {
        return;
    }

    let id = localStorage.getItem("id")
    // Form data
    const formData = new FormData();
    formData.append("Name",  document.getElementById('nameOfRoom').value )
    formData.append("category", document.getElementById('categoryOfRoom').value)
    formData.append("price", document.getElementById('priceOfRoom').value)
    formData.append("HotelId", id)
    formData.append("capacity", document.getElementById('guestOfRoom').value)
    formData.append("imagefile", document.getElementById('imgOfRoom').files[0] )
    formData.append("freeWifi", document.getElementById('checkbox3').checked )
    formData.append("smoking", document.getElementById('checkbox2').checked )
    formData.append("breakfast", document.getElementById('checkbox1').checked)
    
    

    // Fetch API
    fetch("http://egyvoyage2.somee.com/api/Room", {
        method: "POST",
        body: formData,
    })
    // .then(response => response.json())
    .then(data => {
        console.log(data);
        localStorage.setItem("name", document.getElementById('nameOfRoom').value)
            let room = localStorage.getItem('name')
        clearForm();
        showAlert("success",`${room} has been added successfully`);
        scroll()
    })
    .catch(error => {
        console.error('Error:', error);
        showAlert("danger",`Failed to add ${room} , Try Again`);
        scroll()
    });
});

function clearForm() {
    document.getElementById('addRoomForm').reset();
}

function scroll(){
    window.scrollTo({
        top:0,
        behavior: "smooth",
    })
}

function showAlert(type,message) {
    const alertPlaceholder = document.getElementById('alert');
    alertPlaceholder.innerHTML = `
    <div class="alert alert-${type} alert-dismissible fade show" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    `;
}