document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('nameOfRoom').value = localStorage.getItem("name");
    document.getElementById('guestOfRoom').value = localStorage.getItem("guest");
    document.getElementById('categoryOfRoom').value = localStorage.getItem("category");
    document.getElementById('priceOfRoom').value = localStorage.getItem("price");

    fetch(localStorage.getItem("image"))
        .then(response => response.blob())
        .then(blob => {
            const file = new File([blob], "image.jpg", { type: "image/jpeg" });
            const dataTransfer = new DataTransfer();
            dataTransfer.items.add(file);
            document.getElementById('imgOfRoom').files = dataTransfer.files;
            console.log(document.getElementById('imgOfRoom').files )
        })
        .catch(error => {
            console.error('Error fetching the image:', error);
        });

        const freeWifi = localStorage.getItem("freeWifi") === "true";
        const smoking = localStorage.getItem("smoking") === "true";
        const breakfast = localStorage.getItem("breakfast") === "true";

        document.getElementById('checkbox1').checked = breakfast;
        document.getElementById('checkbox2').checked = smoking;
        document.getElementById('checkbox3').checked = freeWifi;

        document.getElementById('edit').addEventListener('click', function(event) {
            event.preventDefault();
            const id = localStorage.getItem("id");
            const hotelId = localStorage.getItem("hotelId");
            const Name = document.getElementById('nameOfRoom').value;
            const Price = document.getElementById('priceOfRoom').value;
            const category = document.getElementById('categoryOfRoom').value;
            const guest = document.getElementById('guestOfRoom').value;
            const breakfast = document.getElementById('checkbox1').checked;
            const smoking = document.getElementById('checkbox2').checked;
            const freeWifi = document.getElementById('checkbox3').checked;
            const Image = document.getElementById('imgOfRoom').files[0];
            // localStorage.clear();

            const formData = new FormData();
            formData.append("Id", id);
            formData.append("Name", Name);
            formData.append("category", category);
            formData.append("price", Price);
            formData.append("HotelId", hotelId);
            formData.append("capacity", guest);
            formData.append("imagefile", Image);
            formData.append("freeWifi", freeWifi);
            formData.append("smoking", smoking);
            formData.append("breakfast", breakfast);

            fetch("http://egyvoyage2.somee.com/api/Room", {
                method: "PUT",
                body: formData
            })
            .then((res) => {
                console.log(res);
                let name = localStorage.getItem("name")
                clearForm();
                showAlert("success",`${name}  has been Updated successfully`);
                scroll()
                localStorage.clear();
            })
            .catch(error => {
                console.log(error);
                let name = localStorage.getItem("name")
                showAlert("danger",`Fail to update  ${name}, Try Again`);
                scroll()
                localStorage.clear();
                
            });
        });
})

function clearForm() {
    document.getElementById('editroomForm').reset();
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
};

