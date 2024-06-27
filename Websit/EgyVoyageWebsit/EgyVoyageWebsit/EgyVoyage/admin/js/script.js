
// Function to create bar chart
function createBarChart(barData, barContainerId) {
    const ctx = document.getElementById(barContainerId).getContext('2d');
    const data = {
        labels: barData.map(entry => entry.hotelName),
        datasets: [{
            data: barData.map(entry => entry.count),
            backgroundColor: barData.map(() => getRandomColor()),
        }]
    };
    const options = {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true,
                ticks: {
                    callback: function(value) {
                        return value;
                    }
                },
                title: {
                    display: true,
                    text: 'Number of Reservation'
                }
            },
            x: {
                title: {
                    display: true,
                    text: 'Hotel Name'
                }
            }
        },
        plugins: {
            legend: {
                display: false,
            },
            datalabels: {
                color: '#000',
                formatter: (value, context) => {
                    return value;
                },
                font: {
                    weight: 'bold',
                    size: 14
                }
            },
            tooltip: {
                callbacks: {
                    label: function(context) {
                        return context.label + ': ' + context.raw;
                    }
                }
            }
        }
    };

    // Destroy existing chart instance if it exists
    if (window.myBarChart) {
        window.myBarChart.destroy();
    }

    // Create new chart instance
    window.myBarChart = new Chart(ctx, {
        type: 'bar',
        data: data,
        options: options,
        plugins: [ChartDataLabels]
    });
}

// Function to update bar chart based on selected month
async function updateBarChart() {
    const selectedMonth = document.getElementById('monthSelect').value;

    // Fetch data from the API
    let response = await fetch('http://egyvoyage2.somee.com/api/DashBoard/chart');
    let responseData = await response.json();

    // Filter data based on selected month
    let barData = [];
    if (selectedMonth === 'all') {
        // Flatten the data for all months
        responseData.forEach(monthData => {
            barData = barData.concat(monthData.data);
        });
    } else {
        // Find data for the selected month
        let monthData = responseData.find(month => month.monthName === selectedMonth);
        if (monthData) {
            barData = monthData.data;
        }
    }

    // Update bar chart with filtered data
    createBarChart(barData, 'barChart1');
}

// Initial call to update bar chart with all months data
updateBarChart();

// Function to generate random colors
function getRandomColor() {
    const letters = '0123456789ABCDEF';
    let color = '#';
    for (let i = 0; i < 6; i++) {
        color += letters[Math.round(Math.random() * 15)];
    }
    return color;
}


// Function to create pie chart
function createPieChart(pieData, pieContainerId) {
    const ctx = document.getElementById(pieContainerId).getContext('2d');
    const totalReservations = pieData.reduce((sum, entry) => sum + entry.reservationCount, 0);
    const colors = pieData.map(entry => entry.color);
    const data = {
        labels: pieData.map(entry => entry.hotelName),
        datasets: [{
            data: pieData.map(entry => entry.reservationCount),
            backgroundColor: colors,
        }]
    };
    const options = {
        responsive: true,
        plugins: {
            legend: {
                display: false
            },
            datalabels: {
                color: '#fff',
                formatter: (value) => {
                    return ((value / totalReservations) * 100).toFixed(2) + '%';
                },
                font: {
                    weight: 'bold',
                    size: 14
                }
            },
            tooltip: {
                callbacks: {
                    label: function(context) {
                        var label = context.label || '';
                        if (label) {
                            label += ': ';
                        }
                        label += ((context.raw / totalReservations) * 100).toFixed(2) + '%';
                        return label;
                    }
                }
            }
        }
    };

    new Chart(ctx, {
        type: 'pie',
        data: data,
        options: options,
        plugins: [ChartDataLabels]
    });
}
async function fetchAndCreatePieChart() {
    try {
        const response = await fetch('http://egyvoyage2.somee.com/api/DashBoard/Piechart');
        const data = await response.json();

        // Assuming the data is directly the array you provided
        const pieData = data.map(item => ({
            hotelName: item.hotelName,
            reservationCount: item.reservationCount,
            color: getRandomColor()
        }));

        // Calculate total reservations for percentage calculation
        const totalReservations = pieData.reduce((sum, entry) => sum + entry.reservationCount, 0);

        // Create the pie chart with the data
        createPieChart(pieData, 'pieChart');

        // Populate the table with hotel names, colors, and percentages
        const tableBody = document.getElementById('hotelTable').querySelector('tbody');
        tableBody.innerHTML = ''; // Clear any existing rows
        pieData.forEach(entry => {
            const percentage = ((entry.reservationCount / totalReservations) * 100).toFixed(2);
            const row = document.createElement('tr');
            row.innerHTML = `
                <td><div class="color-box" style="background-color: ${entry.color};"></div></td>
                <td>${entry.hotelName}</td>
                <td>${percentage}%</td>
            `;
            tableBody.appendChild(row);
        });
    } catch (error) {
        console.error('Error fetching data:', error);
    }
}

// Call the function to fetch data and create the pie chart and table
fetchAndCreatePieChart();

