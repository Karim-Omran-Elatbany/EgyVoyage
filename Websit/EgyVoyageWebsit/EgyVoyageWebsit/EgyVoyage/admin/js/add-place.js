document.getElementById('addPlaceForm').addEventListener('submit', function(event) {
    event.preventDefault();
    
    const form = this;
    const formData = new FormData();

    // Client-side validation
    let isValid = true;
    form.querySelectorAll('.form-control[required]').forEach(function(input) {
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
    
        formData.append("Name", document.getElementById('nameOfHotel').value);
        formData.append("Description", document.getElementById('descOfHotel').value);
        formData.append("rating", document.getElementById('ratingOfhotel').value);
        formData.append("url_location", document.getElementById('locationOfhotel').value);
        formData.append("cordinate", document.getElementById('cordinateOfhotel').value);
        formData.append("city", document.getElementById('mapOfhotel').value);
        formData.append("imagefile", document.getElementById('img').files[0]);
        formData.append("start", document.getElementById('firstOfhotel').value);
        formData.append("end", document.getElementById('secondOfhotel').value);
        formData.append("price", document.getElementById('priceOfhotel').value);
        // Submitting form data using fetch API
        fetch('http://egyvoyage2.somee.com/api/Place', {
            method: 'POST',
            body: formData
        })
            // .then(response => response.json())
        .then(data => {
            console.log(data);
            localStorage.setItem("name", document.getElementById('nameOfHotel').value)
            let name = localStorage.getItem('name')
            clearForm();
            showAlert('success',`${name} has been added successfully`);
            scroll()
            localStorage.clear()
        })
        .catch(error => {
            console.error(error);
            showAlert('danger','Failed to add this place ,Try Again');
            scroll()
        });
});
    
function clearForm() {
    document.getElementById('addPlaceForm').reset();
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
    