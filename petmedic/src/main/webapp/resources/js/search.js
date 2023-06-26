// Make an AJAX request to the Spring Boot controller
function fetchMarkers(category) {
  return new Promise((resolve, reject) => {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', `/markers?category=${encodeURIComponent(category)}`);
    xhr.onload = () => {
      if (xhr.status === 200) {
        resolve(JSON.parse(xhr.responseText));
      } else {
        reject(xhr.statusText);
      }
    };
    xhr.onerror = () => reject(xhr.statusText);
    xhr.send();
  });
}

// Display the markers on the map
function displayMarkers(category) {
  fetchMarkers(category)
    .then(markers => {
      // Use the markers data to display the markers on the map
      // Refer to the Kakao Maps API documentation for marker creation and placement
    })
    .catch(error => {
      console.error('Error fetching markers:', error);
    });
}

// Call the displayMarkers function with the desired search category
const searchCategory = 'your desired category';
displayMarkers(searchCategory);
