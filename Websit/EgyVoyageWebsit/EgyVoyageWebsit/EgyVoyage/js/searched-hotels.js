/* ------------------  Search Hotel  ---------------------- */

const searchBtn = document.getElementById("searchBtn");
searchBtn.addEventListener('click',function(event) {
  event.preventDefault();
  console.log("وليس للانسان الا ما سعى");
  let destination = document.getElementById("destination").value;
  let start = document.getElementById("start").value;
  let end = document.getElementById("end").value;

  localStorage.setItem("arrive",start);
  localStorage.setItem("departure",end);

  console.log(destination);
  console.log(start);
  console.log(end);
  
  const searchData = {
    distination: `${destination}`,
    start: `${start}`,
    end: `${end}`,
  };

  console.log(searchData);

  fetch('http://egyvoyage2.somee.com/api/Reservation/search', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(searchData)
  })
  .then(response => {
    if (!response.ok) {
      throw new Error('Erorr is : ');
    }
    return response.json();
  })
  .then(data => {
    // clearData()
    console.log(data)
    localStorage.setItem('hotelData', JSON.stringify(data));
    window.location.href = '/searched-hotels.html';
  })
  .catch(error => {
    console.error(' Err:', error);
  });
});


// function clearData() {
  // document.getElementById("destination").value = "";
//   document.getElementById("start").value = "";
//   document.getElementById("end").value = "";
  // }




