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

function deleteHotel(id){
    fetch(`http://egyvoyage2.somee.com/api/Hotel`)
        .then( (res)=> res.json())
        .then((response)=>{
            let hotel= response
            
            for (let i =0; i <hotel.length; i++) {
                if(hotel[i].id == id){
                    // console.log(hotel[i])
                    localStorage.setItem("name", hotel[i].name) 
                }   
            }
            fetch(`http://egyvoyage2.somee.com/api/Hotel?id=${id}`, {
                method: "DELETE"
            })
            .then((res) =>{
                console.log(res) 
                let div= document.getElementById(`hotel${id}`)
                div.style.display="none"    
                let name = localStorage.getItem('name')
                showAlert('success',`${name} has been deleted successfully`) 
                scroll() 
                localStorage.clear()        
            })
            .catch(error =>{
                console.log(error)
            })       
        })
        .catch(error =>{ 
            console.log(error); 
        }) 

}

