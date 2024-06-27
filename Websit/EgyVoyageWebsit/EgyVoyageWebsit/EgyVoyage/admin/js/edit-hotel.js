// document.getElementById('nameOfHotel').value = localStorage.getItem("name")
// document.getElementById('ratingOfhotel').value = localStorage.getItem("rate")
// document.getElementById('descOfHotel').value = localStorage.getItem("description")
// document.getElementById('locationOfhotel').value = localStorage.getItem("location")
// document.getElementById('cordinateOfhotel').value = localStorage.getItem("cordinate")
// document.getElementById('mapOfhotel').value = localStorage.getItem("map")
// document.getElementById('firstOfhotel').value = localStorage.getItem("day1")
// document.getElementById('secondOfhotel').value = localStorage.getItem("day2")
// document.getElementById('thirdOfhotel').value = localStorage.getItem("day3")
// document.getElementById('img').files[0] = localStorage.getItem("image")



// let editHotelBtn= document.getElementById('addBtn');
// editHotelBtn.addEventListener('click', function(event) {
//     event.preventDefault(); 
//     let id = localStorage.getItem("id") 
//     let Name = document.getElementById('nameOfHotel').value
//     let Rate = document.getElementById('ratingOfhotel').value
//     let Cordinate = document.getElementById('cordinateOfhotel').value
//     let Description = document.getElementById('descOfHotel').value
//     let Location = document.getElementById('locationOfhotel').value
//     let Map = document.getElementById('mapOfhotel').value
//     let Day1 = document.getElementById('firstOfhotel').value
//     let Day2 = document.getElementById('secondOfhotel').value
//     let Day3 = document.getElementById('thirdOfhotel').value
//     let Image= document.getElementById('img').files[0]
//     // localStorage.clear() 

//     let formData = new FormData()
//     formData.append("Id", id )
//     formData.append("Name", Name )
//     formData.append("Description", Description )
//     formData.append("rating", Rate)
//     formData.append("cordinate", Cordinate )
//     formData.append("location", Location )
//     formData.append("map", Map )
//     formData.append("day1", Day1 )
//     formData.append("day2", Day2 )
//     formData.append("day3", Day3 )
//     formData.append("imagefile", Image )

    
//     fetch("http://egyvoyage2.somee.com/api/Hotel", {
//         method: "PUT",
//         body: formData 
//     })
//     .then((res) =>
//     { 
//         console.log(res)
//         clearData()
//         showSuccessAlert("Hotel updated successfully")              
//     })
//     .catch(error =>{
//         console.log(error)
//     })
// });

//     function clearData(){
//         document.getElementById('nameOfHotel').value = ""
//         document.getElementById('ratingOfhotel').value = ""
//         document.getElementById('mapOfhotel').value = ""
//         document.getElementById('descOfHotel').value = ""
//         document.getElementById('locationOfhotel').value = ""
//         document.getElementById('cordinateOfhotel').value = ""
//         document.getElementById('firstOfhotel').value = ""
//         document.getElementById('secondOfhotel').value = ""
//         document.getElementById('thirdOfhotel').value = ""
//         document.getElementById('img').value = ""
//     }

//     function showSuccessAlert(alart){
//         const alertPlaceholder = document.getElementById('success-alart')
//         const appendAlert = (message, type) => {
//         const wrapper = document.createElement('div')
//         wrapper.innerHTML = [
//         `<div class="alert alert-${type} alert-dismissible" role="alert">`,
//             `  <div>${message}</div>`,
//             '  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
//         '</div>'
//         ].join('')
//         alertPlaceholder.append(wrapper)
//     }
//     appendAlert(alart, 'success')       
//     }




document.getElementById('nameOfHotel').value = localStorage.getItem("name");
document.getElementById('ratingOfhotel').value = localStorage.getItem("rate");
document.getElementById('descOfHotel').value = localStorage.getItem("description");
document.getElementById('locationOfhotel').value = localStorage.getItem("location");
document.getElementById('cordinateOfhotel').value = localStorage.getItem("cordinate");
document.getElementById('mapOfhotel').value = localStorage.getItem("map");
document.getElementById('firstOfhotel').value = localStorage.getItem("day1");
document.getElementById('secondOfhotel').value = localStorage.getItem("day2");
document.getElementById('thirdOfhotel').value = localStorage.getItem("day3");

// const proxyUrl = 'https://cors-anywhere.herokuapp.com/';
const targetUrl = localStorage.getItem("image");

fetch( targetUrl)
    .then(response => response.blob())
    .then(blob => {
        const file = new File([blob], "image.jpg", { type: "image/jpeg"});
        const dataTransfer = new DataTransfer();
        dataTransfer.items.add(file);
        document.getElementById('img').files = dataTransfer.files;
        console.log( document.getElementById('img').files)
    })
    .catch(error => {
        console.error('Error fetching the image:', error);
    });
    


let editHotelBtn = document.getElementById('addBtn');
editHotelBtn.addEventListener('click', function(event) {
    event.preventDefault(); 
    let id = localStorage.getItem("id");
    let Name = document.getElementById('nameOfHotel').value;
    let Rate = document.getElementById('ratingOfhotel').value;
    let Cordinate = document.getElementById('cordinateOfhotel').value;
    let Description = document.getElementById('descOfHotel').value;
    let Location = document.getElementById('locationOfhotel').value;
    let Map = document.getElementById('mapOfhotel').value;
    let Day1 = document.getElementById('firstOfhotel').value;
    let Day2 = document.getElementById('secondOfhotel').value;
    let Day3 = document.getElementById('thirdOfhotel').value;
    let Image = document.getElementById('img').files[0];

    let formData = new FormData();
    formData.append("Id", id);
    formData.append("Name", Name);
    formData.append("Description", Description);
    formData.append("rating", Rate);
    formData.append("cordinate", Cordinate);
    formData.append("location", Location);
    formData.append("map", Map);
    formData.append("day1", Day1);
    formData.append("day2", Day2);
    formData.append("day3", Day3);
    formData.append("imagefile", Image);

    fetch("http://egyvoyage2.somee.com/api/Hotel", {
        method: "PUT",
        body: formData
    })
    .then(res => {
        console.log(res);
        clearForm()
        let name = localStorage.getItem("name")
        showAlert("success",`${name}  has been Updated successfully`);
        localStorage.clear();
        scroll()
        
    })
    .catch(error => {
        console.log(error);
        let name = localStorage.getItem("name")
        showAlert("danger",`Fail to update  ${name}, Try Again`);
        localStorage.clear();
        scroll()
    });
});

function clearForm() {
    document.getElementById('edithotelForm').reset();
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


