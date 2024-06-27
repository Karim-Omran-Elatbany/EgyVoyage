function scroll(){
    window.scrollTo({
        top:0,
        behavior: "smooth",
    })
}

document.getElementById('addHotelForm').addEventListener('submit', function(event) {
    event.preventDefault();
    const inputs = document.querySelectorAll('#addHotelForm input[required]');
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

    // Form data
    const formData = new FormData();
    formData.append("Name", document.getElementById('nameOfHotel').value);
    
    formData.append("rating", document.getElementById('ratingOfhotel').value);
    formData.append("cordinate", document.getElementById('cordinateOfhotel').value);
    formData.append("location", document.getElementById('locationOfhotel').value);
    formData.append("imagefile", document.getElementById('img').files[0]);
    formData.append("Description", document.getElementById('descOfHotel').value);
    
    formData.append("day1", document.getElementById('firstOfhotel').value);
    formData.append("day2", document.getElementById('secondOfhotel').value);
    formData.append("day3", document.getElementById('thirdOfhotel').value);
    formData.append("map", document.getElementById('mapOfhotel').value);


    // Fetch API
    fetch("http://egyvoyage2.somee.com/api/Hotel", {
        method: "POST",
        body: formData,
    })
    // .then(response => response.json())
    .then(data => {
        console.log(data);
        localStorage.setItem("name", document.getElementById('nameOfHotel').value)
        let name = localStorage.getItem('name')
        clearForm();
        showAlert("success",`${name} has been added successfully`);
        scroll()
        localStorage.clear()
    })
    .catch(error => {
        console.error('Error:', error);
        showAlert("danger","Failed to add this hotel ,Try Again");
        scroll()
    });
});

function clearForm() {
    document.getElementById('addHotelForm').reset();
}

function showAlert(type,message) {
    const alertPlaceholder = document.getElementById('alert');
    alertPlaceholder.innerHTML = `
    <div class="alert alert-${type} alert-dismissible" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    `;
}

