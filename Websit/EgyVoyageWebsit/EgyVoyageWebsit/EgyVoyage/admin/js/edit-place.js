document.getElementById('nameOfHotel').value = localStorage.getItem("name");
document.getElementById('ratingOfhotel').value = localStorage.getItem("rate");
document.getElementById('descOfHotel').value = localStorage.getItem("description");
document.getElementById('locationOfhotel').value = localStorage.getItem("location");
document.getElementById('cordinateOfhotel').value = localStorage.getItem("cordinate");
document.getElementById('mapOfhotel').value = localStorage.getItem("city");
document.getElementById('firstOfhotel').value = localStorage.getItem("Stime");
document.getElementById('secondOfhotel').value = localStorage.getItem("Etime");
document.getElementById('priceOfhotel').value = localStorage.getItem("price");


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
    let Price = document.getElementById('priceOfhotel').value;
    let Cordinate = document.getElementById('cordinateOfhotel').value;
    let Description = document.getElementById('descOfHotel').value;
    let Location = document.getElementById('locationOfhotel').value;
    let City = document.getElementById('mapOfhotel').value;
    let StartTime = document.getElementById('firstOfhotel').value;
    let EndTime = document.getElementById('secondOfhotel').value;
    let Image = document.getElementById('img').files[0];
    

    let formData = new FormData();
    formData.append("Id", id);
    formData.append("Name", Name);
    formData.append("Description", Description);
    formData.append("rating", Rate);
    formData.append("url_location", Location);
    formData.append("cordinate", Cordinate);
    formData.append("city", City);
    formData.append("imagefile", Image);
    formData.append("start", StartTime);
    formData.append("end", EndTime);
    formData.append("price", Price);

    fetch("http://egyvoyage2.somee.com/api/Place", {
        method: "PUT",
        body: formData 
    })
    .then((res) => { 
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
    document.getElementById('editPlaceForm').reset();
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